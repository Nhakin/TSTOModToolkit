unit TSTOProjectImpl;

interface

Uses HsInterfaceEx, HsStreamEx, TSTOProjectIntf;

Type
  TTSTOMasterFile = Class(TInterfacedObjectEx, ITSTOMasterFile)
  Private
    FFileName : AnsiString;
    FNodeName : AnsiString;
    FNodeKind : AnsiString;

  Protected
    Function  GetFileName() : AnsiString;
    Procedure SetFileName(Const AFileName : AnsiString);

    Function  GetNodeName() : AnsiString;
    Procedure SetNodeName(Const ANodeName : AnsiString);

    Function  GetNodeKind() : AnsiString;
    Procedure SetNodeKind(Const ANodeKind : AnsiString);

    Procedure Clear();

    Property FileName : AnsiString Read GetFileName Write SetFileName;
    Property NodeName : AnsiString Read GetNodeName Write SetNodeName;
    Property NodeKind : AnsiString Read GetNodeKind Write SetNodeKind;

  Public
    Procedure Assign(ASource : IInterfaceEx); ReIntroduce;

  End;

  TTSTOMasterFiles = Class(TInterfaceListEx, ITSTOMasterFiles)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : ITSTOMasterFile; OverLoad;
    Procedure Put(Index : Integer; Const Item : ITSTOMasterFile); OverLoad;

    Function Add() : ITSTOMasterFile; ReIntroduce; OverLoad;
    Function Add(Const AItem : ITSTOMasterFile) : Integer; ReIntroduce; OverLoad;

  End;

  TTSTOAppSettings = Class(TInterfacedObjectEx, ITSTOAppSettings)
  Private
    FDLCServer           : AnsiString;
    FDLCPath             : AnsiString;
    FHackPath            : AnsiString;
    FHackFileName        : AnsiString;
    FCustomPatchFileName : AnsiString;
    FResourcePath        : AnsiString;
    FSourcePath          : AnsiString;
    FTargetPath          : AnsiString;
    FWorkSpaceFile       : AnsiString;
    FSkinName            : AnsiString;
    FHackFileTemplate    : AnsiString;

    FMasterFile          : ITSTOMasterFiles;
    FBuildCustomStore    : Boolean;
    FInstantBuild        : Boolean;
    FAllFreeItems        : Boolean;
    FNonUnique           : Boolean;
    FFreeLand            : Boolean;
    FUnlimitedTime       : Boolean;

  Protected
    Function  GetDLCServer() : AnsiString;
    Procedure SetDLCServer(Const ADLCServer : AnsiString);

    Function  GetDLCPath() : AnsiString;
    Procedure SetDLCPath(Const ADLCPath : AnsiString);

    Function  GetHackPath() : AnsiString;
    Procedure SetHackPath(Const AHackPath : AnsiString);

    Function  GetHackFileName() : AnsiString;
    Procedure SetHackFileName(Const AHackFileName : AnsiString);

    Function  GetCustomPatchFileName() : AnsiString;
    Procedure SetCustomPatchFileName(Const ACustomPatchFileName : AnsiString);

    Function  GetResourcePath() : AnsiString;
    Procedure SetResourcePath(Const AResourcePath : AnsiString);

    Function  GetSourcePath() : AnsiString;
    Procedure SetSourcePath(Const ASourcePath : AnsiString);

    Function  GetTargetPath() : AnsiString;
    Procedure SetTargetPath(Const ATargetPath : AnsiString);

    Function  GetWorkSpaceFile() : AnsiString;
    Procedure SetWorkSpaceFile(Const AWorkSpaceFile : AnsiString);

    Function  GetSkinName() : AnsiString;
    Procedure SetSkinName(Const ASkinName : AnsiString);

    Function  GetHackFileTemplate() : AnsiString;
    Procedure SetHackFileTemplate(Const AHackFileTemplate : AnsiString);

    Function  GetMasterFile() : ITSTOMasterFiles;

    Function  GetBuildCustomStore() : Boolean;
    Procedure SetBuildCustomStore(Const ABuildCustomStore : Boolean);

    Function  GetInstantBuild() : Boolean;
    Procedure SetInstantBuild(Const AInstantBuild : Boolean);

    Function  GetAllFreeItems() : Boolean;
    Procedure SetAllFreeItems(Const AAllFreeItems : Boolean);

    Function  GetNonUnique() : Boolean;
    Procedure SetNonUnique(Const ANonUnique : Boolean);

    Function  GetFreeLand() : Boolean;
    Procedure SetFreeLand(Const AFreeLand : Boolean);

    Function  GetUnlimitedTime() : Boolean;
    Procedure SetUnlimitedTime(Const AUnlimitedTime : Boolean);

    Procedure Assign(ASource : IInterfaceEx); ReIntroduce;
    Function  CreateMasterFiles() : ITSTOMasterFiles; Virtual;
    Procedure Created(); OverRide;

    Property DLCServer           : AnsiString       Read GetDLCServer           Write SetDLCServer;
    Property DLCPath             : AnsiString       Read GetDLCPath             Write SetDLCPath;
    Property HackPath            : AnsiString       Read GetHackPath            Write SetHackPath;
    Property HackFileName        : AnsiString       Read GetHackFileName        Write SetHackFileName;
    Property CustomPatchFileName : AnsiString       Read GetCustomPatchFileName Write SetCustomPatchFileName;
    Property ResourcePath        : AnsiString       Read GetResourcePath        Write SetResourcePath;
    Property SourcePath          : AnsiString       Read GetSourcePath          Write SetSourcePath;
    Property TargetPath          : AnsiString       Read GetTargetPath          Write SetTargetPath;
    Property WorkSpaceFile       : AnsiString       Read GetWorkSpaceFile       Write SetWorkSpaceFile;
    Property SkinName            : AnsiString       Read GetSkinName            Write SetSkinName;
    Property MasterFile          : ITSTOMasterFiles Read GetMasterFile;
    Property BuildCustomStore    : Boolean          Read GetBuildCustomStore    Write SetBuildCustomStore;
    Property InstantBuild        : Boolean          Read GetInstantBuild        Write SetInstantBuild;
    Property AllFreeItems        : Boolean          Read GetAllFreeItems        Write SetAllFreeItems;
    Property NonUnique           : Boolean          Read GetNonUnique           Write SetNonUnique;
    Property FreeLand            : Boolean          Read GetFreeLand            Write SetFreeLand;
    Property UnlimitedTime       : Boolean          Read GetUnlimitedTime       Write SetUnlimitedTime;

  Public
    Destructor Destroy(); OverRide;

  End;

implementation

Uses SysUtils, RTLConsts;

Procedure TTSTOMasterFile.Clear();
Begin
  FFileName := '';
  FNodeName := '';
  FNodeKind := '';
End;

Procedure TTSTOMasterFile.Assign(ASource : IInterfaceEx);
Var lSrc : ITSTOMasterFile;
Begin
  If Supports(ASource, ITSTOMasterFile, lSrc) Then
  Begin
    lSrc := TTSTOMasterFile(ASource);

    FFileName := lSrc.FileName;
    FNodeName := lSrc.NodeName;
    FNodeKind := lSrc.NodeKind;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TTSTOMasterFile.GetFileName() : AnsiString;
Begin
  Result := FFileName;
End;

Procedure TTSTOMasterFile.SetFileName(Const AFileName : AnsiString);
Begin
  FFileName := AFileName;
End;

Function TTSTOMasterFile.GetNodeName() : AnsiString;
Begin
  Result := FNodeName;
End;

Procedure TTSTOMasterFile.SetNodeName(Const ANodeName : AnsiString);
Begin
  FNodeName := ANodeName;
End;

Function TTSTOMasterFile.GetNodeKind() : AnsiString;
Begin
  Result := FNodeKind;
End;

Procedure TTSTOMasterFile.SetNodeKind(Const ANodeKind : AnsiString);
Begin
  FNodeKind := ANodeKind;
End;

Function TTSTOMasterFiles.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TTSTOMasterFile;
End;

Function TTSTOMasterFiles.Get(Index : Integer) : ITSTOMasterFile;
Begin
  Result := InHerited Items[Index] As ITSTOMasterFile;
End;

Procedure TTSTOMasterFiles.Put(Index : Integer; Const Item : ITSTOMasterFile);
Begin
  InHerited Items[Index] := Item;
End;

Function TTSTOMasterFiles.Add() : ITSTOMasterFile;
Begin
  Result := InHerited Add() As ITSTOMasterFile;
End;

Function TTSTOMasterFiles.Add(Const AItem : ITSTOMasterFile) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Procedure TTSTOAppSettings.Created();
Begin
  FMasterFile := CreateMasterFiles();
End;

Function TTSTOAppSettings.CreateMasterFiles() : ITSTOMasterFiles;
Begin
  Result := TTSTOMasterFiles.Create();
End;

Destructor TTSTOAppSettings.Destroy();
Begin
  FMasterFile := Nil;

  InHerited Destroy();
End;

Procedure TTSTOAppSettings.Assign(ASource : IInterfaceEx);
Var lSrc : ITSTOAppSettings;
Begin
  If Supports(ASource, ITSTOAppSettings, lSrc) Then
  Begin
    FDLCServer           := lSrc.DLCServer;
    FDLCPath             := lSrc.DLCPath;
    FHackPath            := lSrc.HackPath;
    FHackFileName        := lSrc.HackFileName;
    FCustomPatchFileName := lSrc.CustomPatchFileName;
    FResourcePath        := lSrc.ResourcePath;
    FSourcePath          := lSrc.SourcePath;
    FTargetPath          := lSrc.TargetPath;
    FWorkSpaceFile       := lSrc.WorkSpaceFile;
    FSkinName            := lSrc.SkinName;
    FHackFileTemplate    := lSrc.HackFileTemplate;

    FMasterFile          := lSrc.MasterFile;
    FBuildCustomStore    := lSrc.BuildCustomStore;
    FInstantBuild        := lSrc.InstantBuild;
    FAllFreeItems        := lSrc.AllFreeItems;
    FNonUnique           := lSrc.NonUnique;
    FFreeLand            := lSrc.FreeLand;
    FUnlimitedTime       := lSrc.UnlimitedTime;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TTSTOAppSettings.GetDLCServer() : AnsiString;
Begin
  Result := FDLCServer;
End;

Procedure TTSTOAppSettings.SetDLCServer(Const ADLCServer : AnsiString);
Begin
  FDLCServer := ADLCServer;
End;

Function TTSTOAppSettings.GetDLCPath() : AnsiString;
Begin
  Result := FDLCPath;
End;

Procedure TTSTOAppSettings.SetDLCPath(Const ADLCPath : AnsiString);
Begin
  FDLCPath := ADLCPath;
End;

Function TTSTOAppSettings.GetHackPath() : AnsiString;
Begin
  Result := FHackPath;
End;

Procedure TTSTOAppSettings.SetHackPath(Const AHackPath : AnsiString);
Begin
  FHackPath := AHackPath;
End;

Function TTSTOAppSettings.GetHackFileName() : AnsiString;
Begin
  Result := FHackFileName;
End;

Procedure TTSTOAppSettings.SetHackFileName(Const AHackFileName : AnsiString);
Begin
  FHackFileName := AHackFileName;
End;

Function TTSTOAppSettings.GetCustomPatchFileName() : AnsiString;
Begin
  Result := FCustomPatchFileName;
End;

Procedure TTSTOAppSettings.SetCustomPatchFileName(Const ACustomPatchFileName : AnsiString);
Begin
  FCustomPatchFileName := ACustomPatchFileName;
End;

Function TTSTOAppSettings.GetResourcePath() : AnsiString;
Begin
  Result := FResourcePath;
End;

Procedure TTSTOAppSettings.SetResourcePath(Const AResourcePath : AnsiString);
Begin
  FResourcePath := AResourcePath;
End;

Function TTSTOAppSettings.GetSourcePath() : AnsiString;
Begin
  Result := FSourcePath;
End;

Procedure TTSTOAppSettings.SetSourcePath(Const ASourcePath : AnsiString);
Begin
  FSourcePath := ASourcePath;
End;

Function TTSTOAppSettings.GetTargetPath() : AnsiString;
Begin
  Result := FTargetPath;
End;

Procedure TTSTOAppSettings.SetTargetPath(Const ATargetPath : AnsiString);
Begin
  FTargetPath := ATargetPath;
End;

Function TTSTOAppSettings.GetWorkSpaceFile() : AnsiString;
Begin
  Result := FWorkSpaceFile;
End;

Procedure TTSTOAppSettings.SetWorkSpaceFile(Const AWorkSpaceFile : AnsiString);
Begin
  FWorkSpaceFile := AWorkSpaceFile;
End;

Function TTSTOAppSettings.GetSkinName() : AnsiString;
Begin
  Result := FSkinName;
End;

Procedure TTSTOAppSettings.SetSkinName(Const ASkinName : AnsiString);
Begin
  FSkinName := ASkinName;
End;


Function TTSTOAppSettings.GetHackFileTemplate() : AnsiString;
Begin
  Result := FHackFileTemplate;
End;

Procedure TTSTOAppSettings.SetHackFileTemplate(Const AHackFileTemplate : AnsiString);
Begin
  FHackFileTemplate := AHackFileTemplate;
End;

Function TTSTOAppSettings.GetMasterFile() : ITSTOMasterFiles;
Begin
  Result := FMasterFile;
End;

Function TTSTOAppSettings.GetBuildCustomStore() : Boolean;
Begin
  Result := FBuildCustomStore;
End;

Procedure TTSTOAppSettings.SetBuildCustomStore(Const ABuildCustomStore : Boolean);
Begin
  FBuildCustomStore := ABuildCustomStore;
End;

Function TTSTOAppSettings.GetInstantBuild() : Boolean;
Begin
  Result := FInstantBuild;
End;

Procedure TTSTOAppSettings.SetInstantBuild(Const AInstantBuild : Boolean);
Begin
  FInstantBuild := AInstantBuild;
End;

Function TTSTOAppSettings.GetAllFreeItems() : Boolean;
Begin
  Result := FAllFreeItems;
End;

Procedure TTSTOAppSettings.SetAllFreeItems(Const AAllFreeItems : Boolean);
Begin
  FAllFreeItems := AAllFreeItems;
End;

Function TTSTOAppSettings.GetNonUnique() : Boolean;
Begin
  Result := FNonUnique;
End;

Procedure TTSTOAppSettings.SetNonUnique(Const ANonUnique : Boolean);
Begin
  FNonUnique := ANonUnique;
End;

Function TTSTOAppSettings.GetFreeLand() : Boolean;
Begin
  Result := FFreeLand;
End;

Procedure TTSTOAppSettings.SetFreeLand(Const AFreeLand : Boolean);
Begin
  FFreeLand := AFreeLand;
End;

Function TTSTOAppSettings.GetUnlimitedTime() : Boolean;
Begin
  Result := FUnlimitedTime;
End;

Procedure TTSTOAppSettings.SetUnlimitedTime(Const AUnlimitedTime : Boolean);
Begin
  FUnlimitedTime := AUnlimitedTime;
End;

end.
