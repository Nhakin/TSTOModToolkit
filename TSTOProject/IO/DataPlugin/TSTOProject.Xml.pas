Unit TSTOProject.Xml;

Interface

Uses HsXmlDocEx, TSTOCustomPatches.Xml;

Type
  ITSTOXmlMasterFile = interface(IXmlNodeEx)
    ['{2D01B906-F4F3-4ADE-B385-2F6FD1EA59E2}']
    Function  GetFileName() : AnsiString;
    Procedure SetFileName(Value : AnsiString);
    Function  GetNodeName() : AnsiString;
    Procedure SetNodeName(Value : AnsiString);
    Function  GetNodeKind() : AnsiString;
    Procedure SetNodeKind(Value : AnsiString);

    Property FileName : AnsiString Read GetFileName Write SetFileName;
    Property NodeName : AnsiString Read GetNodeName Write SetNodeName;
    Property NodeKind : AnsiString Read GetNodeKind Write SetNodeKind;

  end;

  ITSTOXmlMasterFiles = interface(IXmlNodeCollectionEx)
    ['{F41A72D5-4282-4FEE-9C9B-C7A381B07D3F}']
    Function GetMasterFile(Index : Integer) : ITSTOXmlMasterFile;

    Function Add() : ITSTOXmlMasterFile;
    Function Insert(const Index : Integer) : ITSTOXmlMasterFile;

    Property MasterFile[Index : Integer] : ITSTOXmlMasterFile Read GetMasterFile; Default;

  end;

  ITSTOXMLSettings = Interface(IXmlNodeEx)
    ['{1A094087-BF7A-46AD-B6E2-D80959D75DC6}']
    Function  GetAllFreeItems() : Boolean;
    Procedure SetAllFreeItems(Value : Boolean);
    Function  GetBuildCustomStore() : Boolean;
    Procedure SetBuildCustomStore(Value : Boolean);
    Function  GetInstantBuild() : Boolean;
    Procedure SetInstantBuild(Value : Boolean);
    Function  GetNonUnique() : Boolean;
    Procedure SetNonUnique(Value : Boolean);
    Function  GetFreeLand() : Boolean;
    Procedure SetFreeLand(Value : Boolean);
    Function  GetUnlimitedTime() : Boolean;
    Procedure SetUnlimitedTime(Value : Boolean);

    Function  GetDLCIndexFileName() : AnsiString;
    Procedure SetDLCIndexFileName(Value : AnsiString);
    Function  GetSourcePath() : AnsiString;
    Procedure SetSourcePath(Value : AnsiString);
    Function  GetTargetPath() : AnsiString;
    Procedure SetTargetPath(Value : AnsiString);
    Function  GetWorkSpaceFile() : AnsiString;
    Procedure SetWorkSpaceFile(Value : AnsiString);
    Function  GetHackPath() : AnsiString;
    Procedure SetHackPath(Value : AnsiString);
    Function  GetHackFileName() : AnsiString;
    Procedure SetHackFileName(Value : AnsiString);
    Function  GetCustomPatchFileName() : AnsiString;
    Procedure SetCustomPatchFileName(Value : AnsiString);
    Function  GetDLCServer() : AnsiString;
    Procedure SetDLCServer(Value : AnsiString);
    Function  GetDLCPath() : AnsiString;
    Procedure SetDLCPath(Value : AnsiString);
    Function  GetSkinName() : AnsiString;
    Procedure SetSkinName(Value : AnsiString);
    Function  GetHackFileTemplate() : AnsiString;
    Procedure SetHackFileTemplate(Const AHackFileTemplate : AnsiString);
    Function  GetHackMasterList() : AnsiString;
    Procedure SetHackMasterList(Const AHackMasterList : AnsiString);
    Function  GetResourcePath() : AnsiString;
    Procedure SetResourcePath(Value : AnsiString);

    Function GetMasterFiles: ITSTOXmlMasterFiles;

    Property AllFreeItems     : Boolean Read GetAllFreeItems     Write SetAllFreeItems;
    Property BuildCustomStore : Boolean Read GetBuildCustomStore Write SetBuildCustomStore;
    Property InstantBuild     : Boolean Read GetInstantBuild     Write SetInstantBuild;
    Property NonUnique        : Boolean Read GetNonUnique        Write SetNonUnique;
    Property FreeLand         : Boolean Read GetFreeLand         Write SetFreeLand;
    Property UnlimitedTime    : Boolean Read GetUnlimitedTime    Write SetUnlimitedTime;

    Property DLCIndexFileName    : AnsiString Read GetDLCIndexFileName    Write SetDLCIndexFileName;
    Property SourcePath          : AnsiString Read GetSourcePath          Write SetSourcePath;
    Property TargetPath          : AnsiString Read GetTargetPath          Write SetTargetPath;
    Property WorkSpaceFile       : AnsiString Read GetWorkSpaceFile       Write SetWorkSpaceFile;
    Property HackPath            : AnsiString Read GetHackPath            Write SetHackPath;
    Property HackFileName        : AnsiString Read GetHackFileName        Write SetHackFileName;
    Property CustomPatchFileName : AnsiString Read GetCustomPatchFileName Write SetCustomPatchFileName;
    Property DLCServer           : AnsiString Read GetDLCServer           Write SetDLCServer;
    Property DLCPath             : AnsiString Read GetDLCPath             Write SetDLCPath;
    Property SkinName            : AnsiString Read GetSkinName            Write SetSkinName;
    Property HackFileTemplate    : AnsiString Read GetHackFileTemplate    Write SetHackFileTemplate;
    Property HackMasterList      : AnsiString Read GetHackMasterList      Write SetHackMasterList;
    Property ResourcePath        : AnsiString Read GetResourcePath        Write SetResourcePath;

    Property MasterFiles : ITSTOXmlMasterFiles Read GetMasterFiles;

  End;

  ITSTOXMLSourcePaths = Interface(IXmlNodeCollectionEx)
    ['{150EDB89-37F3-4CD3-BA76-2DA43747C01D}']
    Function GetSourcePath(Index : Integer) : AnsiString;
    Function Add(Const SourcePath : AnsiString) : IXmlNodeEx;
    Function Insert(Const Index : Integer; Const SourcePath : AnsiString) : IXmlNodeEx;

    Property SourcePath[Index : Integer] : AnsiString Read GetSourcePath; Default;

  End;

  ITSTOXMLProjectFile = Interface(IXmlNodeEx)
    ['{D71D70F7-A3BB-4E30-9A3A-71AB5CC6F311}']
    Function GetFileType() : Integer;
    Procedure SetFileType(Value : Integer);

    Function GetSourcePaths() : ITSTOXMLSourcePaths;

    Function GetOutputPath() : AnsiString;
    Procedure SetOutputPath(Value : AnsiString);

    Function GetOutputFileName() : AnsiString;
    Procedure SetOutputFileName(Value : AnsiString);


    Property FileType       : Integer             Read GetFileType       Write SetFileType;
    Property SourcePaths    : ITSTOXMLSourcePaths Read GetSourcePaths;
    Property OutputPath     : AnsiString          Read GetOutputPath     Write SetOutputPath;
    Property OutputFileName : AnsiString          Read GetOutputFileName Write SetOutputFileName;

  End;

  ITSTOXMLProjectFiles = Interface(IXmlNodeCollectionEx)
    ['{CDC40918-1876-407B-887B-E8E997EA22CC}']
    Function GetProjectFile(Index : Integer): ITSTOXMLProjectFile;

    Function Add() : ITSTOXMLProjectFile;
    Function Insert(Const Index : Integer): ITSTOXMLProjectFile;

    Property ProjectFile[Index : Integer] : ITSTOXMLProjectFile Read GetProjectFile; Default;

  End;

  ITSTOXMLProject = Interface(IXmlNodeEx)
    ['{980C930B-C7C7-4286-9244-0850265EBE31}']
    Function GetSettings() : ITSTOXMLSettings;
    Function GetProjectFiles() : ITSTOXMLProjectFiles;
    Function GetCustomPatches() : ITSTOXMLCustomPatches;

    Property Settings      : ITSTOXMLSettings      Read GetSettings;
    Property ProjectFiles  : ITSTOXMLProjectFiles  Read GetProjectFiles;
    //Property CustomPatches : ITSTOXMLCustomPatches Read GetCustomPatches;

  End;

  TTSTOXmlTSTOProject = Class(TObject)
  Public
    Class Function GetTSTOProject(Doc : IXmlDocumentEx) : ITSTOXMLProject;
    Class Function LoadTSTOProject(Const FileName : AnsiString) : ITSTOXMLProject;
    Class Function NewTSTOProject() : ITSTOXMLProject;

  End;

Const
  TargetNamespace = '';

Implementation

Uses Dialogs, SysUtils;

Type
  TTSTOXmlTSTOProjectImpl = Class(TXmlNodeEx, ITSTOXMLProject)
  Private
    FCustomPatches : ITSTOXMLCustomPatches;

  Protected
    Function GetSettings() : ITSTOXMLSettings;
    Function GetProjectFiles() : ITSTOXMLProjectFiles;
    Function GetCustomPatches() : ITSTOXMLCustomPatches;

  Public
    Procedure AfterConstruction(); OverRide;
    Destructor Destroy(); OverRide;

  End;

  TTSTOXmlMasterFile = class(TXmlNodeEx, ITSTOXmlMasterFile)
  Protected
    Function  GetFileName() : AnsiString;
    Procedure SetFileName(Value : AnsiString);
    Function  GetNodeName() : AnsiString;
    Procedure SetNodeName(Value : AnsiString);
    Function  GetNodeKind() : AnsiString;
    Procedure SetNodeKind(Value : AnsiString);

  end;

  TTSTOXmlMasterFiles = class(TXmlNodeCollectionEx, ITSTOXmlMasterFiles)
  Protected
    Function GetMasterFile(Index : Integer) : ITSTOXmlMasterFile;

    Function Add() : ITSTOXmlMasterFile;
    Function Insert(const Index : Integer) : ITSTOXmlMasterFile;

  Public
    Procedure AfterConstruction(); OverRide;

  end;

  TTSTOXmlSettings = Class(TXmlNodeEx, ITSTOXMLSettings)
  Protected
    Function  GetAllFreeItems() : Boolean;
    Procedure SetAllFreeItems(Value : Boolean);
    Function  GetBuildCustomStore() : Boolean;
    Procedure SetBuildCustomStore(Value : Boolean);
    Function  GetInstantBuild() : Boolean;
    Procedure SetInstantBuild(Value : Boolean);
    Function  GetNonUnique() : Boolean;
    Procedure SetNonUnique(Value : Boolean);
    Function  GetFreeLand() : Boolean;
    Procedure SetFreeLand(Value : Boolean);
    Function  GetUnlimitedTime() : Boolean;
    Procedure SetUnlimitedTime(Value : Boolean);

    Function  GetDLCIndexFileName() : AnsiString;
    Procedure SetDLCIndexFileName(Value : AnsiString);
    Function  GetSourcePath() : AnsiString;
    Procedure SetSourcePath(Value : AnsiString);
    Function  GetTargetPath() : AnsiString;
    Procedure SetTargetPath(Value : AnsiString);
    Function  GetWorkSpaceFile() : AnsiString;
    Procedure SetWorkSpaceFile(Value : AnsiString);
    Function  GetHackPath() : AnsiString;
    Procedure SetHackPath(Value : AnsiString);
    Function  GetHackFileName() : AnsiString;
    Procedure SetHackFileName(Value : AnsiString);
    Function  GetCustomPatchFileName() : AnsiString;
    Procedure SetCustomPatchFileName(Value : AnsiString);
    Function  GetDLCServer() : AnsiString;
    Procedure SetDLCServer(Value : AnsiString);
    Function  GetDLCPath() : AnsiString;
    Procedure SetDLCPath(Value : AnsiString);
    Function  GetSkinName() : AnsiString;
    Procedure SetSkinName(Value : AnsiString);
    Function  GetResourcePath() : AnsiString;
    Procedure SetResourcePath(Value : AnsiString);
    Function  GetHackFileTemplate() : AnsiString;
    Procedure SetHackFileTemplate(Const AHackFileTemplate : AnsiString);
    Function  GetHackMasterList() : AnsiString;
    Procedure SetHackMasterList(Const AHackMasterList : AnsiString);

    Function  GetMasterFiles() : ITSTOXmlMasterFiles;

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TTSTOXmlProjectFiles = Class(TXmlNodeCollectionEx, IXmlNodeEx, ITSTOXMLProjectFiles)
  Protected
    Function GetProjectFile(Index : Integer) : ITSTOXMLProjectFile;
    Function Add() : ITSTOXMLProjectFile;
    Function Insert(Const Index : Integer) : ITSTOXMLProjectFile;

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TTSTOXmlProjectFile = Class(TXmlNodeEx, ITSTOXMLProjectFile)
  Protected
    Function GetFileType() : Integer;
    Function GetSourcePaths() : ITSTOXMLSourcePaths;
    Function GetOutputPath() : AnsiString;
    Function GetOutputFileName() : AnsiString;

    Procedure SetFileType(Value : Integer);
    Procedure SetOutputPath(Value : AnsiString);
    Procedure SetOutputFileName(Value : AnsiString);

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TTSTOXmlSourcePaths = Class(TXmlNodeCollectionEx, ITSTOXMLSourcePaths)
  Protected
    Function GetSourcePath(Index : Integer) : AnsiString;
    Function Add(Const SourcePath : AnsiString) : IXmlNodeEx;
    Function Insert(Const Index : Integer; Const SourcePath : AnsiString) : IXmlNodeEx;

  Public
    Procedure AfterConstruction(); OverRide;

  End;

(******************************************************************************)

Class Function TTSTOXmlTSTOProject.GetTSTOProject(Doc: IXmlDocumentEx) : ITSTOXMLProject;
Begin
  Result := Doc.GetDocBinding('TSTOProject', TTSTOXmlTSTOProjectImpl, TargetNamespace) As ITSTOXMLProject;
End;

Class Function TTSTOXmlTSTOProject.LoadTSTOProject(Const FileName: AnsiString): ITSTOXMLProject;
Begin
  Result := LoadXMLDocument(FileName).GetDocBinding('TSTOProject', TTSTOXmlTSTOProjectImpl, TargetNamespace) As ITSTOXMLProject;
End;

Class Function TTSTOXmlTSTOProject.NewTSTOProject: ITSTOXMLProject;
Begin
  Result := NewXMLDocument.GetDocBinding('TSTOProject', TTSTOXmlTSTOProjectImpl, TargetNamespace) As ITSTOXMLProject;
End;

{ TTSTOXMLTSTOProjectType }

Procedure TTSTOXmlTSTOProjectImpl.AfterConstruction;
Begin
  RegisterChildNode('Settings', TTSTOXmlSettings);
  RegisterChildNode('ProjectFiles', TTSTOXmlProjectFiles);

  Inherited;
End;

Destructor TTSTOXmlTSTOProjectImpl.Destroy();
Begin
  FCustomPatches := Nil;

  InHerited Destroy();
End;

Function TTSTOXmlTSTOProjectImpl.GetSettings: ITSTOXMLSettings;
Begin
  Result := ChildNodes['Settings'] As ITSTOXMLSettings;
End;

Function TTSTOXmlTSTOProjectImpl.GetProjectFiles: ITSTOXMLProjectFiles;
Begin
  Result := ChildNodes['ProjectFiles'] As ITSTOXMLProjectFiles;
End;

Function TTSTOXmlTSTOProjectImpl.GetCustomPatches() : ITSTOXMLCustomPatches;
Var lXml : IXmlDocumentEx;
Begin
  If Not Assigned(FCustomPatches) Then
  Begin
    If FileExists(GetSettings().CustomPatchFileName) Then
    Begin
      lXml := LoadXMLDocument(GetSettings().CustomPatchFileName);
      Try
        FCustomPatches := TTSTOXmlCustomPatches.CreateCustomPatches(lXml.Xml.Text);

        Finally
          lXml := Nil;
      End;
    End
    Else
      FCustomPatches := TTSTOXmlCustomPatches.CreateCustomPatches();
  End;

  Result := FCustomPatches;
End;

function TTSTOXmlMasterFile.GetFileName: AnsiString;
begin
  Result := AttributeNodes['FileName'].Text;
end;

procedure TTSTOXmlMasterFile.SetFileName(Value: AnsiString);
begin
  SetAttribute('FileName', Value);
end;

function TTSTOXmlMasterFile.GetNodeName: AnsiString;
begin
  Result := AttributeNodes['NodeName'].Text;
end;

procedure TTSTOXmlMasterFile.SetNodeName(Value: AnsiString);
begin
  SetAttribute('NodeName', Value);
end;

Function TTSTOXmlMasterFile.GetNodeKind() : AnsiString;
Begin
  Result := AttributeNodes['NodeKind'].Text;
End;

Procedure TTSTOXmlMasterFile.SetNodeKind(Value : AnsiString);
Begin
  SetAttribute('NodeKind', Value);
End;

procedure TTSTOXmlMasterFiles.AfterConstruction;
begin
  RegisterChildNode('MasterFile', TTSTOXmlMasterFile);
  ItemTag := 'MasterFile';
  ItemInterface := ITSTOXmlMasterFile;
  inherited;
end;

function TTSTOXmlMasterFiles.GetMasterFile(Index: Integer): ITSTOXmlMasterFile;
begin
  Result := List[Index] as ITSTOXmlMasterFile;
end;

function TTSTOXmlMasterFiles.Add: ITSTOXmlMasterFile;
begin
  Result := AddItem(-1) as ITSTOXmlMasterFile;
end;

function TTSTOXmlMasterFiles.Insert(const Index: Integer): ITSTOXmlMasterFile;
begin
  Result := AddItem(Index) as ITSTOXmlMasterFile;
end;

Procedure TTSTOXmlSettings.AfterConstruction();
Begin
  RegisterChildNode('MasterFiles', TTSTOXmlMasterFiles);

  InHerited AfterConstruction;
End;

Function TTSTOXmlSettings.GetAllFreeItems() : Boolean;
Begin
  Result := ChildNodes['AllFreeItems'].AsBoolean;
End;

Procedure TTSTOXmlSettings.SetAllFreeItems(Value: Boolean);
Begin
  ChildNodes['AllFreeItems'].AsBoolean := Value;
End;

Function TTSTOXmlSettings.GetBuildCustomStore() : Boolean;
Begin
  Result := ChildNodes['BuildCustomStore'].AsBoolean;
End;

Procedure TTSTOXmlSettings.SetBuildCustomStore(Value: Boolean);
Begin
  ChildNodes['BuildCustomStore'].AsBoolean := Value;
End;

Function TTSTOXmlSettings.GetInstantBuild() : Boolean;
Begin
  Result := ChildNodes['InstantBuild'].AsBoolean;
End;

Procedure TTSTOXmlSettings.SetInstantBuild(Value : Boolean);
Begin
  ChildNodes['InstantBuild'].AsBoolean := Value;
End;

Function TTSTOXmlSettings.GetNonUnique() : Boolean;
Begin
  Result := ChildNodes['NonUnique'].AsBoolean;
End;

Procedure TTSTOXmlSettings.SetNonUnique(Value : Boolean);
Begin
  ChildNodes['NonUnique'].AsBoolean := Value;
End;

Function TTSTOXmlSettings.GetFreeLand() : Boolean;
Begin
  Result := ChildNodes['FreeLand'].AsBoolean;
End;

Procedure TTSTOXmlSettings.SetFreeLand(Value : Boolean);
Begin
  ChildNodes['FreeLand'].AsBoolean := Value;
End;

Function TTSTOXmlSettings.GetUnlimitedTime() : Boolean;
Begin
  Result := ChildNodes['UnlimitedTime'].AsBoolean;
End;

Procedure TTSTOXmlSettings.SetUnlimitedTime(Value : Boolean);
Begin
  ChildNodes['UnlimitedTime'].AsBoolean := Value;
End;

Function TTSTOXmlSettings.GetDLCIndexFileName: AnsiString;
Begin
  Result := ChildNodes['DLCIndexFileName'].Text;
End;

Procedure TTSTOXmlSettings.SetDLCIndexFileName(Value: AnsiString);
Begin
  ChildNodes['DLCIndexFileName'].NodeValue := Value;
End;

Function TTSTOXmlSettings.GetSourcePath() : AnsiString;
Begin
  Result := IncludeTrailingBackSlash(ChildNodes['SourcePath'].Text);
End;

Procedure TTSTOXmlSettings.SetSourcePath(Value : AnsiString);
Begin
  ChildNodes['SourcePath'].NodeValue := IncludeTrailingBackSlash(Value);
End;

Function TTSTOXmlSettings.GetTargetPath() : AnsiString;
Begin
  Result := IncludeTrailingBackSlash(ChildNodes['TargetPath'].Text);
End;

Procedure TTSTOXmlSettings.SetTargetPath(Value : AnsiString);
Begin
  ChildNodes['TargetPath'].NodeValue := IncludeTrailingBackSlash(Value);
End;

Function TTSTOXmlSettings.GetWorkSpaceFile() : AnsiString;
Begin
  Result := ChildNodes['WorkSpaceFile'].Text;
End;

Procedure TTSTOXmlSettings.SetWorkSpaceFile(Value : AnsiString);
Begin
  ChildNodes['WorkSpaceFile'].NodeValue := Value;
End;

Function TTSTOXmlSettings.GetHackPath() : AnsiString;
Begin
  Result := IncludeTrailingBackSlash(ChildNodes['HackPath'].Text);
End;

Procedure TTSTOXmlSettings.SetHackPath(Value : AnsiString);
Begin
  ChildNodes['HackPath'].NodeValue := IncludeTrailingBackSlash(Value);
End;

Function TTSTOXmlSettings.GetHackFileName() : AnsiString;
Begin
  Result := ChildNodes['HackFileName'].Text;
End;

Procedure TTSTOXmlSettings.SetHackFileName(Value : AnsiString);
Begin
  ChildNodes['HackFileName'].NodeValue := Value;
End;

Function TTSTOXmlSettings.GetCustomPatchFileName() : AnsiString;
Begin
  Result := ChildNodes['CustomPatchFileName'].Text;
End;

Procedure TTSTOXmlSettings.SetCustomPatchFileName(Value : AnsiString);
Begin
  ChildNodes['CustomPatchFileName'].NodeValue := Value;
End;

Function TTSTOXmlSettings.GetDLCServer() : AnsiString;
Begin
  Result := ChildNodes['DLCServer'].Text;
End;

Procedure TTSTOXmlSettings.SetDLCServer(Value : AnsiString);
Begin
  ChildNodes['DLCServer'].NodeValue := Value;
End;

Function TTSTOXmlSettings.GetDLCPath() : AnsiString;
Begin
  Result := IncludeTrailingBackSlash(ChildNodes['DLCPath'].Text);
End;

Procedure TTSTOXmlSettings.SetDLCPath(Value : AnsiString);
Begin
  ChildNodes['DLCPath'].NodeValue := IncludeTrailingBackSlash(Value);
End;

Function TTSTOXmlSettings.GetSkinName() : AnsiString;
Begin
  Result := ChildNodes['SkinName'].Text;
End;

Procedure TTSTOXmlSettings.SetSkinName(Value : AnsiString);
Begin
  ChildNodes['SkinName'].NodeValue := Value;
End;

Function TTSTOXmlSettings.GetResourcePath() : AnsiString;
Begin
  Result := IncludeTrailingBackSlash(ChildNodes['ResourcePath'].Text);
End;

Procedure TTSTOXmlSettings.SetResourcePath(Value : AnsiString);
Begin
  ChildNodes['ResourcePath'].NodeValue := IncludeTrailingBackSlash(Value);
End;

Function TTSTOXmlSettings.GetHackFileTemplate() : AnsiString;
Begin
  Result := ChildNodes['HackFileTemplate'].Text;
End;

Procedure TTSTOXmlSettings.SetHackFileTemplate(Const AHackFileTemplate : AnsiString);
Begin
  ChildNodes['HackFileTemplate'].NodeValue := AHackFileTemplate;
End;

Function TTSTOXmlSettings.GetHackMasterList() : AnsiString;
Begin
  Result := ChildNodes['HackMasterList'].Text;
End;

Procedure TTSTOXmlSettings.SetHackMasterList(Const AHackMasterList : AnsiString);
Begin
  ChildNodes['HackMasterList'].NodeValue := AHackMasterList;
End;

Function TTSTOXmlSettings.GetMasterFiles() : ITSTOXmlMasterFiles;
Begin
  Result := ChildNodes['MasterFiles'] as ITSTOXmlMasterFiles;
End;

Procedure TTSTOXmlProjectFiles.AfterConstruction;
Begin
  RegisterChildNode('ProjectFile', TTSTOXmlProjectFile);
  ItemTag := 'ProjectFile';
  ItemInterface := ITSTOXMLProjectFile;
  Inherited;
End;

Function TTSTOXmlProjectFiles.GetProjectFile(Index: Integer): ITSTOXMLProjectFile;
Begin
  Result := List[Index] As ITSTOXMLProjectFile;
End;

Function TTSTOXmlProjectFiles.Add: ITSTOXMLProjectFile;
Begin
  Result := AddItem(-1) As ITSTOXMLProjectFile;
End;

Function TTSTOXmlProjectFiles.Insert(Const Index: Integer): ITSTOXMLProjectFile;
Begin
  Result := AddItem(Index) As ITSTOXMLProjectFile;
End;

{ TTSTOXMLProjectFileType }

Procedure TTSTOXmlProjectFile.AfterConstruction;
Begin
  RegisterChildNode('SourcePaths', TTSTOXmlSourcePaths);
  Inherited;
End;

Function TTSTOXmlProjectFile.GetFileType: Integer;
Begin
  Result := AttributeNodes['FileType'].NodeValue;
End;

Procedure TTSTOXmlProjectFile.SetFileType(Value: Integer);
Begin
  SetAttribute('FileType', Value);
End;

Function TTSTOXmlProjectFile.GetSourcePaths: ITSTOXMLSourcePaths;
Begin
  Result := ChildNodes['SourcePaths'] As ITSTOXMLSourcePaths;
End;

Function TTSTOXmlProjectFile.GetOutputPath: AnsiString;
Begin
  Result := ChildNodes['OutputPath'].Text;
End;

Procedure TTSTOXmlProjectFile.SetOutputPath(Value: AnsiString);
Begin
  ChildNodes['OutputPath'].NodeValue := Value;
End;

Function TTSTOXmlProjectFile.GetOutputFileName: AnsiString;
Begin
  Result := ChildNodes['OutputFileName'].Text;
End;

Procedure TTSTOXmlProjectFile.SetOutputFileName(Value: AnsiString);
Begin
  ChildNodes['OutputFileName'].NodeValue := Value;
End;

{ TTSTOXMLSourcePathsType }

Procedure TTSTOXmlSourcePaths.AfterConstruction;
Begin
  ItemTag := 'SourcePath';
  ItemInterface := IXmlNodeEx;
  Inherited;
End;

Function TTSTOXmlSourcePaths.GetSourcePath(Index: Integer): AnsiString;
Begin
  Result := List[Index].Text;
End;

Function TTSTOXmlSourcePaths.Add(Const SourcePath: AnsiString): IXmlNodeEx;
Begin
  Result := AddItem(-1) As IXmlNodeEx;
  Result.NodeValue := SourcePath;
End;

Function TTSTOXmlSourcePaths.Insert(Const Index: Integer; Const SourcePath: AnsiString): IXmlNodeEx;
Begin
  Result := AddItem(Index) As IXmlNodeEx;
  Result.NodeValue := SourcePath;
End;

End.
