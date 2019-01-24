unit TSTOProjectWorkSpace.IO;

interface

Uses Windows, Classes, HsStreamEx, HsInterfaceEx,
  TSTOProjectWorkSpaceIntf, TSTOScriptTemplate.IO, TSTOHackSettings;

Type
  ITSTOWorkSpaceProjectSrcFilesIO = Interface(ITSTOWorkSpaceProjectSrcFiles)
    ['{4B61686E-29A0-2112-83D8-AF14FA400832}']
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

    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure LoadFromFile(Const AFileName : String);

    Procedure SaveToStream(ATarget : IStreamEx);
    Procedure SaveToFile(Const AFileName : String);

    Procedure CreateWsGroupProject(APath : String);
    Procedure CreateWsProject(APath : String; AProject : ITSTOWorkSpaceProject);
    Procedure GenerateScripts(AProject : ITSTOWorkSpaceProject);

    Property FileName     : String            Read GetFileName;
    Property AsXml        : String            Read GetAsXml        Write SetAsXml;
    Property HackSettings : ITSTOHackSettings Read GetHackSettings;

    Property Items[Index : Integer] : ITSTOWorkSpaceProjectIO Read Get Write Put; Default;

    Property OnChange     : TNotifyEvent      Read GetOnChange     Write SetOnChange;

  End;

  TTSTOWorkSpaceProjectGroupIO = Class(TObject)
  Public
    Class Function CreateProjectGroup() : ITSTOWorkSpaceProjectGroupIO;

  End;

implementation

Uses
  SysUtils, HsXmlDocEx,
  TSTOProjectWorkSpaceImpl, TSTOProjectWorkSpace.Types,
  TSTOProjectWorkSpace.Bin, TSTOProjectWorkSpace.Xml;

Type
  ITSTOWorkSpaceProjectIOEx = Interface(ITSTOWorkSpaceProjectIO)
    ['{4B61686E-29A0-2112-84E7-E72095D7D3D9}']
    Procedure SetWorkSpace(AWorkSpace : ITSTOWorkSpaceProjectGroupIO);

    Property WorkSpace : ITSTOWorkSpaceProjectGroupIO Read GetWorkSpace Write SetWorkSpace;

  End;

  TTSTOWorkSpaceProjectSrcFilesIO = Class(TTSTOWorkSpaceProjectSrcFiles, ITSTOWorkSpaceProjectSrcFilesIO)
  Protected
    Function  GetOnChange() : TNotifyEvent; Virtual; Abstract;
    Procedure SetOnChange(AOnChange : TNotifyEvent); Virtual; Abstract;

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

    Procedure DoOnChange(Sender : TObject);
    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure LoadFromFile(Const AFileName : String);

    Procedure SaveToStream(ATarget : IStreamEx);
    Procedure SaveToFile(Const AFileName : String);

    Procedure CreateWsProject(APath : String; AProject : ITSTOWorkSpaceProject);
    Procedure CreateWsGroupProject(APath : String);
    Procedure GenerateScripts(AProject : ITSTOWorkSpaceProject);

  Public
    Destructor Destroy(); OverRide;

  End;

Class Function TTSTOWorkSpaceProjectGroupIO.CreateProjectGroup() : ITSTOWorkSpaceProjectGroupIO;
Begin
  Result := TTSTOWorkSpaceProjectGroupIOImpl.Create();
End;

(******************************************************************************)

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

Destructor TTSTOWorkSpaceProjectGroupIOImpl.Destroy();
Begin
  FBinImpl := Nil;
  FXmlImpl := Nil;
  FHackSettings := Nil;

  InHerited Destroy();
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

Procedure TTSTOWorkSpaceProjectGroupIOImpl.DoOnChange(Sender : TObject);
Begin
  If Assigned(FOnChange) Then
    FOnChange(Sender);
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
End;

Procedure TTSTOWorkSpaceProjectGroupIOImpl.CreateWsProject(APath : String; AProject : ITSTOWorkSpaceProject);
  Procedure RecursiveSearch(AStartPath : String; AProject : ITSTOWorkSpaceProject);
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

Procedure TTSTOWorkSpaceProjectGroupIOImpl.CreateWsGroupProject(APath : String);
Var lSr : TSearchRec;
    lProject : ITSTOWorkSpaceProject;
Begin
  Clear();

  APath := IncludeTrailingBackslash(APath);
  If FindFirst(APath + '*.*', faDirectory, lSr) = 0 Then
  Try
    ProjectGroupName := ExtractFileName(ExcludeTrailingBackslash(APath));

    Repeat
      If (lSr.Attr And faDirectory <> 0) And Not SameText(lSr.Name, '.') And Not SameText(lSr.Name, '..') Then
      Begin
        lProject := Add();
        lProject.ProjectName := lSr.Name;
        CreateWsProject(APath + lSr.Name + '\', lProject);
      End;
    Until FindNext(lSr) <> 0

    Finally
      FindClose(lSr);
  End;
End;

Procedure TTSTOWorkSpaceProjectGroupIOImpl.GenerateScripts(AProject : ITSTOWorkSpaceProject);
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

    lTemplate.GenerateScripts(GetHackSettings().HackMasterList);

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

end.
