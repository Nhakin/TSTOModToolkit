unit TSTOProjectWorkSpace.IO;

interface

Uses Windows, Classes, HsStreamEx, HsInterfaceEx,
  TSTOProjectWorkSpaceIntf, TSTOScriptTemplate.IO, TSTOHackSettings;

Type
  ITSTOWorkSpaceProjectSrcFilesIO = Interface(ITSTOWorkSpaceProjectSrcFiles)
    ['{4B61686E-29A0-2112-83D8-AF14FA400832}']
    Function Remove(Const Item : ITSTOWorkSpaceProjectSrcFile) : Integer;

    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

    Property OnChange : TNotifyEvent Read GetOnChange Write SetOnChange;

  End;

  ITSTOWorkSpaceProjectSrcFolderIO = Interface(ITSTOWorkSpaceProjectSrcFolder)
    ['{4B61686E-29A0-2112-9A95-856C256092DA}']
    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

    Property OnChange : TNotifyEvent Read GetOnChange Write SetOnChange;

  End;

  ITSTOWorkSpaceProjectSrcFoldersIO = Interface(ITSTOWorkSpaceProjectSrcFolders)
    ['{4B61686E-29A0-2112-B4BD-C15FECA88CC7}']
    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

    Function  Get(Index : Integer) : ITSTOWorkSpaceProjectSrcFolderIO;
    Procedure Put(Index : Integer; Const Item : ITSTOWorkSpaceProjectSrcFolderIO);

    Function Add() : ITSTOWorkSpaceProjectSrcFolderIO; OverLoad;
    Function Add(Const AItem : ITSTOWorkSpaceProjectSrcFolderIO) : Integer; OverLoad;

    Property Items[Index : Integer] : ITSTOWorkSpaceProjectSrcFolderIO Read Get Write Put; Default;

    Property OnChange : TNotifyEvent Read GetOnChange Write SetOnChange;

  End;

  ITSTOWorkSpaceProjectGroupIO = Interface;
  ITSTOWorkSpaceProjectIO = Interface(ITSTOWorkSpaceProject)
    ['{4B61686E-29A0-2112-84E7-E72095D7D3D9}']
    Function  GetWorkSpace() : ITSTOWorkSpaceProjectGroupIO;
    Function  GetGlobalSettings() : ITSTOHackSettings;
    Function  GetSrcPath() : String;

    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

    Property WorkSpace      : ITSTOWorkSpaceProjectGroupIO Read GetWorkSpace;
    Property GlobalSettings : ITSTOHackSettings            Read GetGlobalSettings;
    Property SrcPath        : String                       Read GetSrcPath;

    Property OnChange : TNotifyEvent Read GetOnChange Write SetOnChange;

  End;

  ITSTOWorkSpaceProjectGroupIO = Interface(ITSTOWorkSpaceProjectGroup)
    ['{4B61686E-29A0-2112-A7E7-81D654C5F3FD}']
    Function GetFileName() : String;

    Function  GetAsXml() : String;
    Procedure SetAsXml(Const AXmlString : String);

    Function  GetHackSettings() : ITSTOHackSettings;

    Function  Get(Index : Integer) : ITSTOWorkSpaceProjectIO;
    Procedure Put(Index : Integer; Const Item : ITSTOWorkSpaceProjectIO);

    Function Add() : ITSTOWorkSpaceProjectIO; OverLoad;
    Function Add(Const AItem : ITSTOWorkSpaceProjectIO) : Integer; OverLoad;

    Function  GetModified() : Boolean;

    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure LoadFromFile(Const AFileName : String);

    Procedure SaveToStream(ATarget : IStreamEx);
    Procedure SaveToFile(Const AFileName : String);

    Procedure ForceChanged();

    Procedure CreateWsGroupProject(APath : String; Const AHackFileName : String);
    Procedure CreateWsProject(APath : String; AProject : ITSTOWorkSpaceProjectIO);
    Procedure GenerateScripts(AProject : ITSTOWorkSpaceProjectIO);
    Procedure CompileMod(AWorkSpaceProject : ITSTOWorkSpaceProjectIO);
    Procedure PackMod(AWorkSpaceProject : ITSTOWorkSpaceProjectIO);

    Property FileName     : String            Read GetFileName;
    Property AsXml        : String            Read GetAsXml        Write SetAsXml;
    Property HackSettings : ITSTOHackSettings Read GetHackSettings;

    Property Items[Index : Integer] : ITSTOWorkSpaceProjectIO Read Get Write Put; Default;

    Property Modified : Boolean Read GetModified;

    Property OnChange : TNotifyEvent Read GetOnChange Write SetOnChange;

  End;

  TTSTOWorkSpaceProjectGroupIO = Class(TObject)
  Public
    Class Function CreateProjectGroup() : ITSTOWorkSpaceProjectGroupIO;

  End;

implementation

Uses
  Forms, SysUtils,
  HsXmlDocEx, HsZipUtils, HsCheckSumEx, HsStringListEx, HsFunctionsEx,
  TSTOZero.Bin, TSTOProjectWorkSpaceImpl, TSTOProjectWorkSpace.Types,
  TSTOProjectWorkSpace.Bin, TSTOProjectWorkSpace.Xml;

Type
  ITSTOWorkSpaceProjectIOEx = Interface(ITSTOWorkSpaceProjectIO)
    ['{4B61686E-29A0-2112-84E7-E72095D7D3D9}']
    Procedure SetWorkSpace(AWorkSpace : ITSTOWorkSpaceProjectGroupIO);

    Property WorkSpace : ITSTOWorkSpaceProjectGroupIO Read GetWorkSpace Write SetWorkSpace;

  End;

  TTSTOWorkSpaceProjectSrcFilesIO = Class(TTSTOWorkSpaceProjectSrcFiles, ITSTOWorkSpaceProjectSrcFilesIO)
  Private
    FOnChange : TNotifyEvent;

  Protected
    Function Remove(Const Item : ITSTOWorkSpaceProjectSrcFile) : Integer;

    Procedure DoChanged(Sender : TObject);
    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

  End;

  TTSTOWorkSpaceProjectSrcFolderIO = Class(TTSTOWorkSpaceProjectSrcFolder, ITSTOWorkSpaceProjectSrcFolderIO)
  Protected
    Function  GetOnChange() : TNotifyEvent; Virtual; Abstract;
    Procedure SetOnChange(AOnChange : TNotifyEvent); Virtual; Abstract;

  End;

  TTSTOWorkSpaceProjectSrcFoldersIO = Class(TTSTOWorkSpaceProjectSrcFolders, ITSTOWorkSpaceProjectSrcFoldersIO)
  Private
    FOnChange : TNotifyEvent;

  Protected
    Function  GetItemClass() : TInterfacedObjectExClass; OverRide;

    Function  Get(Index : Integer) : ITSTOWorkSpaceProjectSrcFolderIO; OverLoad;
    Procedure Put(Index : Integer; Const Item : ITSTOWorkSpaceProjectSrcFolderIO); OverLoad;

    Function Add() : ITSTOWorkSpaceProjectSrcFolderIO; OverLoad;
    Function Add(Const AItem : ITSTOWorkSpaceProjectSrcFolderIO) : Integer; OverLoad;

    Procedure DoChange(Sender : TObject);
    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

  End;

  TTSTOWorkSpaceProjectIO = Class(TTSTOWorkSpaceProject, ITSTOWorkSpaceProjectIO, ITSTOWorkSpaceProjectIOEx)
  Private
    FOnChange  : TNotifyEvent;
    FWorkSpace : Pointer;

  Protected
    Function  GetWorkSpaceProjectSrcFoldersClass() : TTSTOWorkSpaceProjectSrcFoldersClass; OverRide;

    Function  GetWorkSpace() : ITSTOWorkSpaceProjectGroupIO;
    Procedure SetWorkSpace(AWorkSpace : ITSTOWorkSpaceProjectGroupIO);

    Function  GetSrcPath() : String;

    Function  GetGlobalSettings() : ITSTOHackSettings;

    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

    Procedure SetProjectName(Const AProjectName : AnsiString); OverRide;
    Procedure SetProjectKind(Const AProjectKind : TWorkSpaceProjectKind); OverRide;
    Procedure SetProjectType(Const AProjectType : TWorkSpaceProjectType); OverRide;
    Procedure SetZeroCrc32(Const AZeroCrc32 : DWord); OverRide;
    Procedure SetPackOutput(Const APackOutput : Boolean); OverRide;
    Procedure SetOutputPath(Const AOutputPath : AnsiString); OverRide;
    Procedure SetCustomScriptPath(Const ACustomScriptPath : AnsiString); OverRide;
    Procedure SetCustomModPath(Const ACustomModPath : AnsiString); OverRide;

  Public
    Constructor Create(AWorkSpace : ITSTOWorkSpaceProjectGroupIO); ReIntroduce;

  End;

  TTSTOWorkSpaceProjectGroupIOImpl = Class(TTSTOWorkSpaceProjectGroup,
    ITSTOWorkSpaceProjectGroupIO, IBinTSTOWorkSpaceProjectGroup, IXmlTSTOWorkSpaceProjectGroup)
  Private
    FFileName : String;
    FHackSettings : ITSTOHackSettings;
    FOnChange : TNotifyEvent;
    FModified : Boolean;

    FBinImpl : IBinTSTOWorkSpaceProjectGroup;
    FXmlImpl : IXmlTSTOWorkSpaceProjectGroup;

    Function GetBinImplementor() : IBinTSTOWorkSpaceProjectGroup;
    Function GetXmlImplementor() : IXmlTSTOWorkSpaceProjectGroup;

  Protected
    Property BinImpl : IBinTSTOWorkSpaceProjectGroup Read GetBinImplementor Implements IBinTSTOWorkSpaceProjectGroup;
    Property XmlImpl : IXmlTSTOWorkSpaceProjectGroup Read GetXmlImplementor Implements IXmlTSTOWorkSpaceProjectGroup;

    Function GetFileName() : String;

    Function  GetItemClass() : TInterfacedObjectExClass; OverRide;

    Function  Get(Index : Integer) : ITSTOWorkSpaceProjectIO; OverLoad;
    Procedure Put(Index : Integer; Const Item : ITSTOWorkSpaceProjectIO); OverLoad;

    Function Add() : ITSTOWorkSpaceProjectIO; OverLoad;
    Function Add(Const AItem : ITSTOWorkSpaceProjectIO) : Integer; OverLoad;

    Function  GetAsXml() : String;
    Procedure SetAsXml(Const AXmlString : String);

    Procedure SetProjectGroupName(Const AProjectGroupName : AnsiString); OverRide;
    Procedure SetHackFileName(Const AHackFileName : AnsiString); OverRide;
    Procedure SetPackOutput(Const APackOutput : Boolean); OverRide;
    Procedure SetOutputPath(Const AOutputPath : AnsiString); OverRide;

    Function  GetHackSettings() : ITSTOHackSettings;

    Function  GetModified() : Boolean;
    Procedure DoOnChange(Sender : TObject);
    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure LoadFromFile(Const AFileName : String);

    Procedure SaveToStream(ATarget : IStreamEx);
    Procedure SaveToFile(Const AFileName : String);

    Procedure ForceChanged();

    Procedure CreateWsProject(APath : String; AProject : ITSTOWorkSpaceProjectIO);
    Procedure CreateWsGroupProject(APath : String; Const AHackFileName : String);
    Procedure GenerateScripts(AProject : ITSTOWorkSpaceProjectIO);

    Procedure CompileMod(AWorkSpaceProject : ITSTOWorkSpaceProjectIO);
    Procedure PackMod(AWorkSpaceProject : ITSTOWorkSpaceProjectIO);

  Public
    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;

  End;

Class Function TTSTOWorkSpaceProjectGroupIO.CreateProjectGroup() : ITSTOWorkSpaceProjectGroupIO;
Begin
  Result := TTSTOWorkSpaceProjectGroupIOImpl.Create();
End;

(******************************************************************************)

Function TTSTOWorkSpaceProjectSrcFilesIO.Remove(Const Item : ITSTOWorkSpaceProjectSrcFile) : Integer;
Begin
  InHerited Remove(Item As IInterfaceEx);
  DoChanged(Self);
End;

Procedure TTSTOWorkSpaceProjectSrcFilesIO.DoChanged(Sender : TObject);
Begin
  If Assigned(FOnChange) Then
    FOnChange(Sender);
End;

Function TTSTOWorkSpaceProjectSrcFilesIO.GetOnChange() : TNotifyEvent;
Begin
  Result := FOnChange;
End;

Procedure TTSTOWorkSpaceProjectSrcFilesIO.SetOnChange(AOnChange : TNotifyEvent);
Begin
  FOnChange := AOnChange;
End;

Function TTSTOWorkSpaceProjectSrcFoldersIO.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TTSTOWorkSpaceProjectSrcFolderIO;
End;

Function TTSTOWorkSpaceProjectSrcFoldersIO.Get(Index : Integer) : ITSTOWorkSpaceProjectSrcFolderIO;
Begin
  Result := InHerited Get(Index) As ITSTOWorkSpaceProjectSrcFolderIO;
End;

Procedure TTSTOWorkSpaceProjectSrcFoldersIO.Put(Index : Integer; Const Item : ITSTOWorkSpaceProjectSrcFolderIO);
Begin
  InHerited Put(Index, Item);
End;

Function TTSTOWorkSpaceProjectSrcFoldersIO.Add() : ITSTOWorkSpaceProjectSrcFolderIO;
Begin
  Result := InHerited Add() As ITSTOWorkSpaceProjectSrcFolderIO;
  Result.OnChange := DoChange;
End;

Function TTSTOWorkSpaceProjectSrcFoldersIO.Add(Const AItem : ITSTOWorkSpaceProjectSrcFolderIO) : Integer;
Begin
  Result := InHerited Add(AItem);
  AItem.OnChange := DoChange;
End;

Procedure TTSTOWorkSpaceProjectSrcFoldersIO.DoChange(Sender : TObject);
Begin
  If Assigned(FOnChange) Then
    FOnChange(Sender);
End;

Function TTSTOWorkSpaceProjectSrcFoldersIO.GetOnChange() : TNotifyEvent;
Begin
  Result := FOnChange;
End;

Procedure TTSTOWorkSpaceProjectSrcFoldersIO.SetOnChange(AOnChange : TNotifyEvent);
Begin
  FOnChange := AOnChange;
End;

Constructor TTSTOWorkSpaceProjectIO.Create(AWorkSpace : ITSTOWorkSpaceProjectGroupIO);
Begin
  InHerited Create(True);

  FWorkSpace := Pointer(AWorkSpace);
End;

Function TTSTOWorkSpaceProjectIO.GetWorkSpace() : ITSTOWorkSpaceProjectGroupIO;
Begin
  Result := ITSTOWorkSpaceProjectGroupIO(FWorkSpace);
End;

Procedure TTSTOWorkSpaceProjectIO.SetWorkSpace(AWorkSpace : ITSTOWorkSpaceProjectGroupIO);
Begin
  FWorkSpace := Pointer(AWorkSpace);
End;

Function TTSTOWorkSpaceProjectIO.GetSrcPath() : String;
Begin
  If CustomModPath = '' Then
    Raise Exception.Create('You must configure Custom mod path in project settings');
  Result := ExtractFilePath(ExcludeTrailingBackslash(CustomModPath)) + '0\';
End;

Function TTSTOWorkSpaceProjectIO.GetGlobalSettings() : ITSTOHackSettings;
Begin
  Result := GetWorkSpace().HackSettings;
End;

Function TTSTOWorkSpaceProjectIO.GetWorkSpaceProjectSrcFoldersClass() : TTSTOWorkSpaceProjectSrcFoldersClass;
Begin
  Result := TTSTOWorkSpaceProjectSrcFoldersIO;
End;

Function TTSTOWorkSpaceProjectIO.GetOnChange() : TNotifyEvent;
Begin
  Result := FOnChange;
End;

Procedure TTSTOWorkSpaceProjectIO.SetOnChange(AOnChange : TNotifyEvent);
Begin
  FOnChange := AOnChange;
End;

Procedure TTSTOWorkSpaceProjectIO.SetProjectName(Const AProjectName : AnsiString);
Begin
  If GetProjectName() <> AProjectName Then
  Begin
    InHerited SetProjectName(AProjectName);

    If Assigned(FOnChange) Then
      FOnChange(Self);
  End;
End;

Procedure TTSTOWorkSpaceProjectIO.SetProjectKind(Const AProjectKind : TWorkSpaceProjectKind);
Begin
  If GetProjectKind() <> AProjectKind Then
  Begin
    InHerited SetProjectKind(AProjectKind);

    If Assigned(FOnChange) Then
      FOnChange(Self);
  End;
End;

Procedure TTSTOWorkSpaceProjectIO.SetProjectType(Const AProjectType : TWorkSpaceProjectType);
Begin
  If GetProjectType() <> AProjectType Then
  Begin
    InHerited SetProjectType(AProjectType);

    If Assigned(FOnChange) Then
      FOnChange(Self);
  End;
End;

Procedure TTSTOWorkSpaceProjectIO.SetZeroCrc32(Const AZeroCrc32 : DWord);
Begin
  If GetZeroCrc32() <> AZeroCrc32 Then
  Begin
    InHerited SetZeroCrc32(AZeroCrc32);

    If Assigned(FOnChange) Then
      FOnChange(Self);
  End;
End;

Procedure TTSTOWorkSpaceProjectIO.SetPackOutput(Const APackOutput : Boolean);
Begin
  If GetPackOutput() <> APackOutput Then
  Begin
    InHerited SetPackOutput(APackOutput);

    If Assigned(FOnChange) Then
      FOnChange(Self);
  End;
End;

Procedure TTSTOWorkSpaceProjectIO.SetOutputPath(Const AOutputPath : AnsiString);
Begin
  If GetOutputPath() <> AOutputPath Then
  Begin
    InHerited SetOutputPath(AOutputPath);

    If Assigned(FOnChange) Then
      FOnChange(Self);
  End;
End;

Procedure TTSTOWorkSpaceProjectIO.SetCustomScriptPath(Const ACustomScriptPath : AnsiString);
Begin
  If GetCustomScriptPath() <> ACustomScriptPath Then
  Begin
    InHerited SetCustomScriptPath(ACustomScriptPath);

    If Assigned(FOnChange) Then
      FOnChange(Self);
  End;
End;

Procedure TTSTOWorkSpaceProjectIO.SetCustomModPath(Const ACustomModPath : AnsiString);
Begin
  If GetCustomModPath() <> ACustomModPath Then
  Begin
    InHerited SetCustomModPath(ACustomModPath);

    If Assigned(FOnChange) Then
      FOnChange(Self);
  End;
End;

Procedure TTSTOWorkSpaceProjectGroupIOImpl.AfterConstruction();
Begin
  FModified := False;

  InHerited AfterConstruction();
End;

Procedure TTSTOWorkSpaceProjectGroupIOImpl.BeforeDestruction();
Begin
  FBinImpl := Nil;
  FXmlImpl := Nil;
  FHackSettings := Nil;

  InHerited BeforeDestruction();
End;

Function TTSTOWorkSpaceProjectGroupIOImpl.GetBinImplementor() : IBinTSTOWorkSpaceProjectGroup;
Begin
  If Not Assigned(FBinImpl) Then
    FBinImpl := TBinTSTOWorkSpaceProjectGroup.CreateWSProjectGroup();
  FBinImpl.Assign(Self);

  Result := FBinImpl;
End;

Function TTSTOWorkSpaceProjectGroupIOImpl.GetXmlImplementor() : IXmlTSTOWorkSpaceProjectGroup;
Begin
  If Not Assigned(FXmlImpl) Then
    FXmlImpl := TXmlTSTOWorkSpaceProjectGroup.CreateWSProjectGroup();
  FXmlImpl.Assign(Self);

  Result := FXmlImpl;
End;

Function TTSTOWorkSpaceProjectGroupIOImpl.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TTSTOWorkSpaceProjectIO;
End;

Function TTSTOWorkSpaceProjectGroupIOImpl.Get(Index : Integer) : ITSTOWorkSpaceProjectIO;
Begin
  Result := InHerited Get(Index) As ITSTOWorkSpaceProjectIO;
End;

Procedure TTSTOWorkSpaceProjectGroupIOImpl.Put(Index : Integer; Const Item : ITSTOWorkSpaceProjectIO);
Begin
  InHerited Add(Item);
End;

Function TTSTOWorkSpaceProjectGroupIOImpl.Add() : ITSTOWorkSpaceProjectIO;
Begin
  Result := InHerited Add() As ITSTOWorkSpaceProjectIO;
  (Result As ITSTOWorkSpaceProjectIOEx).WorkSpace := Self;
  Result.OnChange := DoOnChange;
End;

Function TTSTOWorkSpaceProjectGroupIOImpl.Add(Const AItem : ITSTOWorkSpaceProjectIO) : Integer;
Begin
  Result := InHerited Add(AItem);
  (AItem As ITSTOWorkSpaceProjectIOEx).WorkSpace := Self;
  AItem.OnChange := DoOnChange;
End;

Function TTSTOWorkSpaceProjectGroupIOImpl.GetFileName() : String;
Begin
  Result := FFileName;
End;

Function TTSTOWorkSpaceProjectGroupIOImpl.GetAsXml() : String;
Begin
  Result := FormatXmlData(XmlImpl.Xml);
  FXmlImpl := Nil;
End;

Procedure TTSTOWorkSpaceProjectGroupIOImpl.SetAsXml(Const AXmlString : String);
Var X : Integer;
Begin
  FXmlImpl := TXmlTSTOWorkSpaceProjectGroup.CreateWSProjectGroup(AXmlString);
  Assign(FXmlImpl);
  FXmlImpl := Nil;

  For X := 0 To Count - 1 Do
    With Get(X) As ITSTOWorkSpaceProjectIOEx Do
    Begin
      WorkSpace := Self;
      OnChange  := DoOnChange;
    End;
End;

Procedure TTSTOWorkSpaceProjectGroupIOImpl.SetProjectGroupName(Const AProjectGroupName : AnsiString);
Begin
  If GetProjectGroupName() <> AProjectGroupName Then
  Begin
    InHerited SetProjectGroupName(AProjectGroupName);
    DoOnChange(Self);
  End;
End;

Procedure TTSTOWorkSpaceProjectGroupIOImpl.SetHackFileName(Const AHackFileName : AnsiString);
Begin
  If GetHackFileName() <> AHackFileName Then
  Begin
    InHerited SetHackFileName(AHackFileName);
    DoOnChange(Self);
  End;
End;

Procedure TTSTOWorkSpaceProjectGroupIOImpl.SetPackOutput(Const APackOutput : Boolean);
Begin
  If GetPackOutput() <> APackOutput Then
  Begin
    InHerited SetPackOutput(APackOutput);
    DoOnChange(Self);
  End;
End;

Procedure TTSTOWorkSpaceProjectGroupIOImpl.SetOutputPath(Const AOutputPath : AnsiString);
Begin
  If GetOutputPath() <> AOutputPath Then
  Begin
    InHerited SetOutputPath(AOutputPath);
    DoOnChange(Self);
  End;
End;

Function TTSTOWorkSpaceProjectGroupIOImpl.GetHackSettings() : ITSTOHackSettings;
Begin
  If Not Assigned(FHackSettings) Then
  Begin
    FHackSettings := TTSTOHackSettings.CreateHackSettings();
    If FileExists(HackFileName) Then
      FHackSettings.LoadFromFile(HackFileName);
    FHackSettings.OnChanged := DoOnChange;
  End;

  Result := FHackSettings;
End;

Function TTSTOWorkSpaceProjectGroupIOImpl.GetModified() : Boolean;
Begin
  Result := FModified;
End;

Procedure TTSTOWorkSpaceProjectGroupIOImpl.ForceChanged();
Begin
  DoOnChange(Self);
End;

Procedure TTSTOWorkSpaceProjectGroupIOImpl.DoOnChange(Sender : TObject);
Begin
  If Assigned(FOnChange) Then
    FOnChange(Sender);
  FModified := True;
End;

Function TTSTOWorkSpaceProjectGroupIOImpl.GetOnChange() : TNotifyEvent;
Begin
  Result := FOnChange;
End;

Procedure TTSTOWorkSpaceProjectGroupIOImpl.SetOnChange(AOnChange : TNotifyEvent);
Begin
  FOnChange := AOnChange;
End;

Procedure TTSTOWorkSpaceProjectGroupIOImpl.LoadFromStream(ASource : IStreamEx);
Var X : Integer;
Begin
  FBinImpl := TBinTSTOWorkSpaceProjectGroup.CreateWSProjectGroup();
  FBinImpl.LoadFromStream(ASource);
  Assign(FBinImpl);

  For X := 0 To Count - 1 Do
    With Get(X) As ITSTOWorkSpaceProjectIOEx Do
    Begin
      WorkSpace := Self;
      OnChange  := DoOnChange;
    End;

  FBinImpl := Nil;
End;

Procedure TTSTOWorkSpaceProjectGroupIOImpl.LoadFromFile(Const AFileName : String);
Var lMem : IMemoryStreamEx;
Begin
  FFileName := AfileName;

  If SameText(ExtractFileExt(AFileName), '.xml') Then
    With TStringList.Create() Do
    Try
      LoadFromFile(AFileName);
      SetAsXml(Text);

      Finally
        Free();
    End
  Else
  Begin
    lMem := TMemoryStreamEx.Create();
    Try
      lMem.LoadFromFile(AFileName);
      lMem.Position := 0;
      LoadFromStream(lMem);

      Finally
        lMem := Nil;
    End;
  End;
End;

Procedure TTSTOWorkSpaceProjectGroupIOImpl.SaveToStream(ATarget : IStreamEx);
Begin
  BinImpl.SaveToStream(ATarget);
  FBinImpl := Nil;
  FModified := False;
End;

Procedure TTSTOWorkSpaceProjectGroupIOImpl.SaveToFile(Const AFileName : String);
Var lMem : IMemoryStreamEx;
Begin
  If SameText(ExtractFileExt(AFileName), '.xml') Then
    With TStringList.Create() Do
    Try
      Text := GetAsXml();
      SaveToFile(AFileName);

      Finally
        Free();
    End
  Else
  Begin
    lMem := TMemoryStreamEx.Create();
    Try
      SaveToStream(lMem);

      lMem.SaveToFile(AFileName);

      Finally
        lMem := Nil;
    End;
  End;

  If Assigned(FHackSettings) Then
    FHackSettings.SaveToFile();

  FModified := False;
End;

Procedure TTSTOWorkSpaceProjectGroupIOImpl.CreateWsProject(APath : String; AProject : ITSTOWorkSpaceProjectIO);
  Procedure RecursiveSearch(AStartPath : String; AProject : ITSTOWorkSpaceProjectIO);
  Var lSr  : TSearchRec;
      lMem : IMemoryStreamEx;
  Begin
    AStartPath := IncludeTrailingBackslash(AStartPath);

    If FindFirst(AStartPath + '*.*', faAnyFile, lSr) = 0 Then
    Try
      Repeat
        If (lSr.Attr And faDirectory <> 0) Then
        Begin
          If SameText(ExtractFileExt(lSr.Name), '.Src') Then
          Begin
            AProject.SrcFolders.Add().SrcPath := IncludeTrailingBackslash(AStartPath + lSr.Name);
            RecursiveSearch(IncludeTrailingBackslash(AStartPath + lSr.Name), AProject);
          End;
        End
        Else If SameText(lSr.Name, 'ZeroCrc.hex') Then
        Begin
          lMem := TMemoryStreamEx.Create();
          Try
            lMem.LoadFromFile(APath + lSr.Name);
            AProject.ZeroCrc32 := lMem.ReadDWord();
            AProject.ProjectKind := spkRoot;

            Finally
              lMem := Nil;
          End;
        End
        Else
          AProject.SrcFolders[AProject.SrcFolders.Count - 1].Add(lSr.Name);
      Until FindNext(lSr) <> 0

      Finally
        FindClose(lSr);
    End;
  End;

Begin
  AProject.ProjectName := ExtractFileName(ExcludeTrailingBackslash(APath));
  RecursiveSearch(APath, AProject);
End;

Procedure TTSTOWorkSpaceProjectGroupIOImpl.CreateWsGroupProject(APath : String; Const AHackFileName : String);
Var lSr : TSearchRec;
    lProject : ITSTOWorkSpaceProjectIO;
Begin
  Clear();

  APath := IncludeTrailingBackslash(APath);
  If FindFirst(APath + '*.*', faDirectory, lSr) = 0 Then
  Try
    ProjectGroupName := ExtractFileName(ExcludeTrailingBackslash(APath));
    OutputPath       := APath + 'Output\' + ProjectGroupName + '\%ProjectName%\';
    HackFileName     := AHackFileName;

    Repeat
      If (lSr.Attr And faDirectory <> 0) And Not SameText(lSr.Name, '.') And Not SameText(lSr.Name, '..') Then
      Begin
        lProject := Add();
        lProject.ProjectName := lSr.Name;
        lProject.CustomModPath := APath + lSr.Name + '\1.src';
        If Pos(UpperCase(lSr.Name), 'TEXTPOOL') > 0 Then
          lProject.ProjectType := sptTextPools
        Else If Pos(UpperCase(lSr.Name), 'GAMESCRIPT') > 0 Then
          lProject.ProjectType := sptScript;

        CreateWsProject(APath + lSr.Name + '\', lProject);
      End;
    Until FindNext(lSr) <> 0

    Finally
      FindClose(lSr);
  End;
End;

Procedure TTSTOWorkSpaceProjectGroupIOImpl.GenerateScripts(AProject : ITSTOWorkSpaceProjectIO);
Var lTemplate : ITSTOScriptTemplateHacksIO;
    X, Y, Z : Integer;
    lOutPath : String;
    lCanAdd : Boolean;
    lModified : Boolean;
Begin
  lModified := False;

  lTemplate := TTSTOScriptTemplateHacksIO.CreateScriptTemplateHacks();
  Try
    lTemplate.Assign(GetHackSettings().ScriptTemplates);
    For X := 0 To lTemplate.Count - 1 Do
      If lTemplate[X].Enabled Then
      Begin
        lOutPath := ExtractFilePath(lTemplate[X].Settings.OutputFileName);
        If (lOutPath = '') Or Not DirectoryExists(lOutPath) Then
          lTemplate[X].Settings.OutputFileName :=
            AProject.CustomScriptPath +
            ExtractFileName(lTemplate[X].Settings.OutputFileName);

        If Not DirectoryExists(ExtractFilePath(lTemplate[X].Settings.OutputFileName)) Then
          ForceDirectories(ExtractFilePath(lTemplate[X].Settings.OutputFileName));
      End;

    lTemplate.GenerateScripts(GetHackSettings().HackMasterList, AProject.EncryptScript);

    For X := 0 To lTemplate.Count - 1 Do
      If lTemplate[X].Enabled Then
      Begin
        If FileExists(lTemplate[X].Settings.OutputFileName) Then
        Begin
          lOutPath := ExtractFilePath(lTemplate[X].Settings.OutputFileName);
          For Y := 0 To AProject.SrcFolders.Count - 1 Do
            If SameText( IncludeTrailingBackslash(AProject.SrcFolders[Y].SrcPath),
                         IncludeTrailingBackslash(lOutPath) ) Then
            Begin
              lCanAdd := True;
              For Z := 0 To AProject.SrcFolders[Y].SrcFileCount - 1 Do
                If SameText( ExtractFileName(lTemplate[X].Settings.OutputFileName),
                             AProject.SrcFolders[Y].SrcFiles[Z].FileName ) Then
                Begin
                  lCanAdd := False;
                  Break;
                End;

              If lCanAdd Then
              Begin
                AProject.SrcFolders[Y].FileList.Add().FileName := ExtractFileName(lTemplate[X].Settings.OutputFileName);
                lModified := True;
              End;

              Break;
            End;
        End;
      End;

    Finally
      lTemplate := Nil;
  End;

  If lModified Then
    DoOnChange(Self);
End;

Procedure TTSTOWorkSpaceProjectGroupIOImpl.CompileMod(AWorkSpaceProject : ITSTOWorkSpaceProjectIO);
Var lZips   : IHsMemoryZippers;
    lZip    : IHsMemoryZipper;
    X, Y, Z : Integer;
    lPos    : Integer;
    lZero   : IBinZeroFile;
    lMem    : IMemoryStreamEx;
    lFileList : IHsStringListEx;
    lOutPath  : String;
Begin
  lZips := THsMemoryZippers.Create();
  Try
    lZips.Clear();

    lOutPath := AWorkSpaceProject.OutputPath;
    If lOutPath = '' Then
      lOutPath := AWorkSpaceProject.WorkSpace.OutputPath;
    lOutPath := IncludeTrailingBackSlash(StringReplace(lOutPath, '%ProjectName%', AWorkSpaceProject.ProjectName, [rfReplaceAll, rfIgnoreCase]));

    If Not DirectoryExists(lOutPath) Then
      ForceDirectories(lOutPath);

    For X := 0 To AWorkSpaceProject.SrcFolders.Count - 1 Do
    Begin
      lZip := lZips.Add();

      lFileList := THsStringListEx.CreateList();
      Try
        For Y := 0 To AWorkSpaceProject.SrcFolders[X].SrcFileCount - 1 Do
          With AWorkSpaceProject.SrcFolders[X] Do
            If FileExists(IncludeTrailingBackslash(SrcPath) + SrcFiles[Y].FileName) Then
              lFileList.Add(IncludeTrailingBackslash(SrcPath) + SrcFiles[Y].FileName);
        lZip.AddFiles(lFileList, faAnyFile);
        lZip.FileName := ChangeFileExt(ExtractFileName(ExcludeTrailingBackslash(AWorkSpaceProject.SrcFolders[X].SrcPath)), '');
        TStream(lZip.InterfaceObject).Position := 0;

        Finally
          lFileList := Nil;
      End;
    End;

    lZero := TBinZeroFile.CreateBinZeroFile();
    Try
      lZero.ArchiveDirectory := 'KahnAbyss/TSTO DLC Generator';
      For Y := 0 To lZips.Count - 1 Do
      Begin
        With lZero.FileDatas.Add() Do
        Begin
          FileName := lZips[Y].FileName;
          Crc32    := GetCrc32Value(TStream(lZips[Y].InterfaceObject));

          For Z := 0 To lZips[Y].Count - 1 Do
            With ArchivedFiles.Add() Do
            Begin
              FileName1     := lZips[Y][Z].FileName;
              FileExtension := StringReplace(ExtractFileExt(lZips[Y][Z].FileName), '.', '', [rfReplaceAll, rfIgnoreCase]);
              FileName2     := FileName1;
              FileSize      := lZips[Y][Z].UncompressedSize;
              ArchiveFileId := Y;
              Application.ProcessMessages();
            End;
        End;
      End;

      lMem := TMemoryStreamEx.Create();
      Try
        If AWorkSpaceProject.ProjectKind = spkRoot Then
        Begin
          With lZero.FileDatas[lZero.FileDatas.Count - 1].ArchivedFiles.Add() Do
          Begin
            FileName1     := 'ZeroCrc.hex';
            FileExtension := 'hex';
            FileName2     := FileName1;
            FileSize      := 0;
            ArchiveFileId := lZero.FileDatas.Count - 1
          End;
        End;

        lZero.SaveToStream(lMem);

        If AWorkSpaceProject.ProjectKind = spkRoot Then
        Begin
          lMem.Size := lMem.Size - SizeOf(DWord);
          SetCrc32Value(TStream(lMem.InterfaceObject), lMem.Size - SizeOf(QWord), AWorkSpaceProject.ZeroCrc32);
          lMem.Position := lMem.Size;
          lMem.WriteDWord(AWorkSpaceProject.ZeroCrc32, True);
        End;

        Finally
          lZero := Nil;
      End;

      If AWorkSpaceProject.PackOutput Or AWorkSpaceProject.WorkSpace.PackOutput Then
      Begin
        lMem.Position := 0;
        lZip := THsMemoryZipper.Create();
        Try
          lZip.AddFromStream('0', lMem);

          For X := 0 To lZips.Count - 1 Do
          Begin
            (lZips[X] As IMemoryStreamEx).Position := 0;
            lZip.AddFromStream(lZips[X].FileName, (lZips[X] As IMemoryStreamEx));
          End;

          lZip.SaveToFile(lOutPath + AWorkSpaceProject.ProjectName + '.zip');

          Finally
            lZip := Nil;
        End;
      End
      Else
      Begin
        lMem.SaveToFile(lOutPath + '0');

        For X := 0 To lZips.Count - 1 Do
          lZips[X].SaveToFile(lOutPath + lZips[X].FileName);
      End;

      Finally
        lMem := Nil;
    End;

    Finally
      lZips := Nil;
  End;
End;

Procedure TTSTOWorkSpaceProjectGroupIOImpl.PackMod(AWorkSpaceProject : ITSTOWorkSpaceProjectIO);
Var lOutPath : String;
    lSr      : TSearchRec;
    lCanPack : Boolean;
    lZip     : IHsMemoryZipper;
Begin
  lCanPack := False;

  If AWorkSpaceProject.OutputPath <> '' Then
    lOutPath := AWorkSpaceProject.OutputPath
  Else
    lOutPath := OutputPath;

  lOutPath := IncludeTrailingBackSlash(StringReplace(lOutPath, '%ProjectName%', AWorkSpaceProject.ProjectName, [rfReplaceAll, rfIgnoreCase]));

  If DirectoryExists(lOutPath) Then
  Begin
    If FindFirst(lOutPath + '*.*', faAnyFile, lSr) = 0 Then
    Try
      Repeat
        If lSr.Attr * faDirectory <> faDirectory Then
        Begin
          lCanPack := True;
          Break;
        End;
      Until FindNext(lSr) <> 0;
      Finally
        FindClose(lSr);
    End;
  End;

  If Not lCanPack Then
  Begin
    If MessageConfirm('Project haven''t been built do you want to buid it now?') Then
    Begin
      CompileMod(AWorkSpaceProject);
      lCanPack := True;
    End;
  End;

  If lCanPack Then
  Begin
    lZip := THsMemoryZipper.Create();
    Try
      lZip.AddFiles(lOutPath + '*.*', faAnyFile);
      lZip.SaveToFile(ExtractFilePath(ExcludeTrailingBackslash(lOutPath)) + AWorkSpaceProject.ProjectName + '.zip');

      Finally
        lZip := Nil;
    End;
  End;
End;

end.
