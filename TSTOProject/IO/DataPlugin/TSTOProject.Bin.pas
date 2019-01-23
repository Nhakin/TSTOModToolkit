unit TSTOProject.Bin;

interface

Uses Classes, SysUtils, HsInterfaceEx, HsStreamEx, TSTOProjectIntf;

Type
  ITSTOBinMasterFile = Interface(ITSTOMasterFile)
    ['{4B61686E-29A0-2112-ADA1-5F552FBA5DA7}']
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

  End;

  ITSTOBinMasterFiles = Interface(ITSTOMasterFiles)
    ['{4B61686E-29A0-2112-9C6D-CF06D62D2340}']
    Function  Get(Index : Integer) : ITSTOBinMasterFile;
    Procedure Put(Index : Integer; Const Item : ITSTOBinMasterFile);

    Function Add() : ITSTOBinMasterFile; OverLoad;
    Function Add(Const AItem : ITSTOBinMasterFile) : Integer; OverLoad;

    Property Items[Index : Integer] : ITSTOBinMasterFile Read Get Write Put; Default;

  End;

  ITSTOBinAppSettings = Interface(ITSTOAppSettings)
    ['{4B61686E-29A0-2112-8D84-F9E010DA562C}']
    Function  GetFileVersion() : Byte;

    Function  GetMasterFile() : ITSTOBinMasterFiles;

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Property FileVersion : Byte                Read GetFileVersion;
    Property MasterFile  : ITSTOBinMasterFiles Read GetMasterFile;

  End;

implementation

Uses
  TSTOProjectImpl;

Type
  TTSTOBinMasterFile = Class(TTSTOMasterFile, ITSTOBinMasterFile)
  Protected
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

  End;

  TTSTOBinMasterFiles = Class(TTSTOMasterFiles, ITSTOBinMasterFiles)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : ITSTOBinMasterFile; OverLoad;
    Procedure Put(Index : Integer; Const Item : ITSTOBinMasterFile); OverLoad;

    Function Add() : ITSTOBinMasterFile; OverLoad;
    Function Add(Const AItem : ITSTOBinMasterFile) : Integer; OverLoad;

  End;

  TTSTOBinAppSettings = Class(TTSTOAppSettings, ITSTOBinAppSettings)
  Strict Private Const
    cFileVersion      = 1;

    cBuildCustomStore = 1;
    cInstantBuild     = 2;
    cAllFreeItems     = 4;
    cNonUnique        = 8;
    cFreeLand         = 16;
    cUnlimitedTime    = 32;

  Strict Private
    Procedure LoadFromStreamV001(ASource : IStreamEx);

  Protected
    Function  GetFileVersion() : Byte;

    Function  GetMasterFile() : ITSTOBinMasterFiles;

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Function  CreateMasterFiles() : ITSTOMasterFiles; OverRide;

    Property MasterFile  : ITSTOBinMasterFiles Read GetMasterFile;

  Public
    Destructor Destroy(); OverRide;

  End;

Procedure TTSTOBinMasterFile.LoadFromStream(ASource : IStreamEx);
Begin
  FileName := ASource.ReadAnsiString();
  NodeName := ASource.ReadAnsiString();
  NodeKind := ASource.ReadAnsiString();
End;

Procedure TTSTOBinMasterFile.SaveToStream(ATarget : IStreamEx);
Begin
  ATarget.WriteAnsiString(FileName);
  ATarget.WriteAnsiString(NodeName);
  ATarget.WriteAnsiString(NodeKind);
End;

Function TTSTOBinMasterFiles.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TTSTOBinMasterFile;
End;

Function TTSTOBinMasterFiles.Get(Index : Integer) : ITSTOBinMasterFile;
Begin
  Result := InHerited Items[Index] As ITSTOBinMasterFile;
End;

Procedure TTSTOBinMasterFiles.Put(Index : Integer; Const Item : ITSTOBinMasterFile);
Begin
  InHerited Items[Index] := Item;
End;

Function TTSTOBinMasterFiles.Add() : ITSTOBinMasterFile;
Begin
  Result := InHerited Add() As ITSTOBinMasterFile;
End;

Function TTSTOBinMasterFiles.Add(Const AItem : ITSTOBinMasterFile) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Destructor TTSTOBinAppSettings.Destroy();
Begin
 InHerited Destroy();
End;

Function TTSTOBinAppSettings.CreateMasterFiles() : ITSTOMasterFiles;
Begin
  Result := TTSTOBinMasterFiles.Create();
End;

Procedure TTSTOBinAppSettings.LoadFromStreamV001(ASource : IStreamEx);
Var lHackFlags : Byte;
    lNbItem    : Byte;
Begin
  DLCServer           := ASource.ReadAnsiString();
  DLCPath             := ASource.ReadAnsiString();
  HackPath            := ASource.ReadAnsiString();
  HackFileName        := ASource.ReadAnsiString();
  CustomPatchFileName := ASource.ReadAnsiString();
  ResourcePath        := ASource.ReadAnsiString();
  SourcePath          := ASource.ReadAnsiString();
  TargetPath          := ASource.ReadAnsiString();
  WorkSpaceFile       := ASource.ReadAnsiString();
  SkinName            := ASource.ReadAnsiString();

  lNbItem := ASource.ReadByte();
  While lNbItem > 0 Do
  Begin
    MasterFile.Add().LoadFromStream(ASource);
    Dec(lNbItem);
  End;

  lHackFlags := ASource.ReadByte();

  BuildCustomStore := lHackFlags And cBuildCustomStore = cBuildCustomStore;
  BuildCustomStore := lHackFlags And cInstantBuild = cInstantBuild;
  BuildCustomStore := lHackFlags And cAllFreeItems = cAllFreeItems;
  BuildCustomStore := lHackFlags And cNonUnique = cNonUnique;
  BuildCustomStore := lHackFlags And cFreeLand = cFreeLand;
  BuildCustomStore := lHackFlags And cUnlimitedTime = cUnlimitedTime;
End;

Procedure TTSTOBinAppSettings.LoadFromStream(ASource : IStreamEx);
Begin
  Case ASource.ReadByte() Of
    1 : LoadFromStreamV001(ASource);
    Else
      Raise Exception.Create('Invalid configuration file');
  End;
End;

Procedure TTSTOBinAppSettings.SaveToStream(ATarget : IStreamEx);
Var X : Integer;
    lHackFlags : Byte;
Begin
  ATarget.WriteByte(cFileVersion);
  ATarget.WriteAnsiString(DLCServer);
  ATarget.WriteAnsiString(DLCPath);
  ATarget.WriteAnsiString(HackPath);
  ATarget.WriteAnsiString(HackFileName);
  ATarget.WriteAnsiString(CustomPatchFileName);
  ATarget.WriteAnsiString(ResourcePath);
  ATarget.WriteAnsiString(SourcePath);
  ATarget.WriteAnsiString(TargetPath);
  ATarget.WriteAnsiString(WorkSpaceFile);
  ATarget.WriteAnsiString(SkinName);

  ATarget.WriteByte(MasterFile.Count);
  For X := 0 To MasterFile.Count - 1 Do
    MasterFile[X].SaveToStream(ATarget);

  lHackFlags := 0;

  If BuildCustomStore Then
    lHackFlags := lHackFlags Or cBuildCustomStore;
  If InstantBuild Then
    lHackFlags := lHackFlags Or cInstantBuild;
  If AllFreeItems Then
    lHackFlags := lHackFlags Or cAllFreeItems;
  If NonUnique Then
    lHackFlags := lHackFlags Or cNonUnique;
  If FreeLand Then
    lHackFlags := lHackFlags Or cFreeLand;
  If UnlimitedTime Then
    lHackFlags := lHackFlags Or cUnlimitedTime;

  ATarget.WriteByte(lHackFlags);
End;

Function TTSTOBinAppSettings.GetFileVersion() : Byte;
Begin
  Result := cFileVersion;
End;

Function TTSTOBinAppSettings.GetMasterFile() : ITSTOBinMasterFiles;
Begin
  Result := InHerited MasterFile As ITSTOBinMasterFiles;
End;

end.
