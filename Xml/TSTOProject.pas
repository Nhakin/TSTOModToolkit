Unit TSTOProject;

Interface

Uses HsXmlDocEx, TSTOCustomPatches;

Type
  ITSTOXmlMasterFile = interface(IXmlNodeEx)
    ['{2D01B906-F4F3-4ADE-B385-2F6FD1EA59E2}']
    Function  GetFileName() : WideString;
    Procedure SetFileName(Value : WideString);
    Function  GetNodeName() : WideString;
    Procedure SetNodeName(Value : WideString);
    Function  GetNodeKind() : WideString;
    Procedure SetNodeKind(Value : WideString);

    Property FileName : WideString Read GetFileName Write SetFileName;
    Property NodeName : WideString Read GetNodeName Write SetNodeName;
    Property NodeKind : WideString Read GetNodeKind Write SetNodeKind;

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

    Function  GetDLCIndexFileName() : Widestring;
    Procedure SetDLCIndexFileName(Value : Widestring);

    Function  GetSourcePath() : Widestring;
    Procedure SetSourcePath(Value : Widestring);
    Function  GetTargetPath() : Widestring;
    Procedure SetTargetPath(Value : Widestring);
    Function  GetWorkSpaceFile() : WideString;
    Procedure SetWorkSpaceFile(Value : WideString);
    Function  GetHackPath() : Widestring;
    Procedure SetHackPath(Value : Widestring);
    Function  GetHackFileName() : Widestring;
    Procedure SetHackFileName(Value : Widestring);
    Function  GetCustomPatchFileName() : WideString;
    Procedure SetCustomPatchFileName(Value : WideString);
    Function  GetDLCServer() : WideString;
    Procedure SetDLCServer(Value : WideString);
    Function  GetDLCPath() : WideString;
    Procedure SetDLCPath(Value : WideString);
    Function  GetSkinName() : WideString;
    Procedure SetSkinName(Value : WideString);
    Function  GetResourcePath() : WideString;
    Procedure SetResourcePath(Value : WideString);

    Function GetMasterFiles: ITSTOXmlMasterFiles;

    Property AllFreeItems     : Boolean Read GetAllFreeItems     Write SetAllFreeItems;
    Property BuildCustomStore : Boolean Read GetBuildCustomStore Write SetBuildCustomStore;
    Property InstantBuild     : Boolean Read GetInstantBuild     Write SetInstantBuild;
    Property NonUnique        : Boolean Read GetNonUnique        Write SetNonUnique;
    Property FreeLand         : Boolean Read GetFreeLand         Write SetFreeLand;
    Property UnlimitedTime    : Boolean Read GetUnlimitedTime    Write SetUnlimitedTime;

    Property SourcePath          : Widestring Read GetSourcePath          Write SetSourcePath;
    Property TargetPath          : Widestring Read GetTargetPath          Write SetTargetPath;
    Property WorkSpaceFile       : WideString Read GetWorkSpaceFile       Write SetWorkSpaceFile;
    Property HackPath            : WideString Read GetHackPath            Write SetHackPath;
    Property HackFileName        : WideString Read GetHackFileName        Write SetHackFileName;
    Property CustomPatchFileName : WideString Read GetCustomPatchFileName Write SetCustomPatchFileName;
    Property DLCServer           : WideString Read GetDLCServer           Write SetDLCServer;
    Property DLCPath             : WideString Read GetDLCPath             Write SetDLCPath;
    Property SkinName            : WideString Read GetSkinName            Write SetSkinName;
    Property ResourcePath        : WideString Read GetResourcePath        Write SetResourcePath;

    Property MasterFiles : ITSTOXmlMasterFiles Read GetMasterFiles;

  End;

  ITSTOXMLSourcePaths = Interface(IXmlNodeCollectionEx)
    ['{150EDB89-37F3-4CD3-BA76-2DA43747C01D}']
    Function GetSourcePath(Index : Integer) : Widestring;
    Function Add(Const SourcePath : Widestring) : IXmlNodeEx;
    Function Insert(Const Index : Integer; Const SourcePath : Widestring) : IXmlNodeEx;

    Property SourcePath[Index : Integer] : Widestring Read GetSourcePath; Default;

  End;

  ITSTOXMLProjectFile = Interface(IXmlNodeEx)
    ['{D71D70F7-A3BB-4E30-9A3A-71AB5CC6F311}']
    Function GetSourcePaths() : ITSTOXMLSourcePaths;
    Function GetFileType() : Integer;
    Function GetOutputPath() : Widestring;
    Function GetOutputFileName() : Widestring;
    Procedure SetFileType(Value : Integer);
    Procedure SetOutputPath(Value : Widestring);
    Procedure SetOutputFileName(Value : Widestring);

    Property FileType       : Integer             Read GetFileType       Write SetFileType;
    Property SourcePaths    : ITSTOXMLSourcePaths Read GetSourcePaths;
    Property OutputPath     : Widestring          Read GetOutputPath     Write SetOutputPath;
    Property OutputFileName : Widestring          Read GetOutputFileName Write SetOutputFileName;

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
    Property CustomPatches : ITSTOXMLCustomPatches Read GetCustomPatches;

  End;

  TTSTOXmlTSTOProject = Class(TObject)
  Public
    Class Function GetTSTOProject(Doc : IXmlDocumentEx) : ITSTOXMLProject;
    Class Function LoadTSTOProject(Const FileName : Widestring) : ITSTOXMLProject;
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
    Function  GetFileName() : WideString;
    Procedure SetFileName(Value : WideString);
    Function  GetNodeName() : WideString;
    Procedure SetNodeName(Value : WideString);
    Function  GetNodeKind() : WideString;
    Procedure SetNodeKind(Value : WideString);

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

    Function  GetDLCIndexFileName() : Widestring;
    Procedure SetDLCIndexFileName(Value : Widestring);
    Function  GetSourcePath() : Widestring;
    Procedure SetSourcePath(Value : Widestring);
    Function  GetTargetPath() : Widestring;
    Procedure SetTargetPath(Value : Widestring);
    Function  GetWorkSpaceFile() : WideString;
    Procedure SetWorkSpaceFile(Value : WideString);
    Function  GetHackPath() : Widestring;
    Procedure SetHackPath(Value : Widestring);
    Function  GetHackFileName() : Widestring;
    Procedure SetHackFileName(Value : Widestring);
    Function  GetCustomPatchFileName() : WideString;
    Procedure SetCustomPatchFileName(Value : WideString);
    Function  GetDLCServer() : WideString;
    Procedure SetDLCServer(Value : WideString);
    Function  GetDLCPath() : WideString;
    Procedure SetDLCPath(Value : WideString);
    Function  GetSkinName() : WideString;
    Procedure SetSkinName(Value : WideString);
    Function  GetResourcePath() : WideString;
    Procedure SetResourcePath(Value : WideString);
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
    Function GetOutputPath() : Widestring;
    Function GetOutputFileName() : Widestring;

    Procedure SetFileType(Value : Integer);
    Procedure SetOutputPath(Value : Widestring);
    Procedure SetOutputFileName(Value : Widestring);

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TTSTOXmlSourcePaths = Class(TXmlNodeCollectionEx, ITSTOXMLSourcePaths)
  Protected
    Function GetSourcePath(Index : Integer) : Widestring;
    Function Add(Const SourcePath : Widestring) : IXmlNodeEx;
    Function Insert(Const Index : Integer; Const SourcePath : Widestring) : IXmlNodeEx;

  Public
    Procedure AfterConstruction(); OverRide;

  End;

(******************************************************************************)

Class Function TTSTOXmlTSTOProject.GetTSTOProject(Doc: IXmlDocumentEx) : ITSTOXMLProject;
Begin
  Result := Doc.GetDocBinding('TSTOProject', TTSTOXmlTSTOProjectImpl, TargetNamespace) As ITSTOXMLProject;
End;

Class Function TTSTOXmlTSTOProject.LoadTSTOProject(Const FileName: Widestring): ITSTOXMLProject;
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
Begin
  If Not Assigned(FCustomPatches) Then
  Begin
    If FileExists(GetSettings().CustomPatchFileName) Then
      FCustomPatches := LoadCustomPatches(GetSettings().CustomPatchFileName)
    Else
      FCustomPatches := NewCustomPatches();
  End;

  Result := FCustomPatches;
End;

function TTSTOXmlMasterFile.GetFileName: WideString;
begin
  Result := AttributeNodes['FileName'].Text;
end;

procedure TTSTOXmlMasterFile.SetFileName(Value: WideString);
begin
  SetAttribute('FileName', Value);
end;

function TTSTOXmlMasterFile.GetNodeName: WideString;
begin
  Result := AttributeNodes['NodeName'].Text;
end;

procedure TTSTOXmlMasterFile.SetNodeName(Value: WideString);
begin
  SetAttribute('NodeName', Value);
end;

Function TTSTOXmlMasterFile.GetNodeKind() : WideString;
Begin
  Result := AttributeNodes['NodeKind'].Text;
End;

Procedure TTSTOXmlMasterFile.SetNodeKind(Value : WideString);
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

Function TTSTOXmlSettings.GetDLCIndexFileName: Widestring;
Begin
  Result := ChildNodes['DLCIndexFileName'].Text;
End;

Procedure TTSTOXmlSettings.SetDLCIndexFileName(Value: Widestring);
Begin
  ChildNodes['DLCIndexFileName'].NodeValue := Value;
End;

Function TTSTOXmlSettings.GetSourcePath() : Widestring;
Begin
  Result := IncludeTrailingBackSlash(ChildNodes['SourcePath'].Text);
End;

Procedure TTSTOXmlSettings.SetSourcePath(Value : Widestring);
Begin
  ChildNodes['SourcePath'].NodeValue := IncludeTrailingBackSlash(Value);
End;

Function TTSTOXmlSettings.GetTargetPath() : Widestring;
Begin
  Result := IncludeTrailingBackSlash(ChildNodes['TargetPath'].Text);
End;

Procedure TTSTOXmlSettings.SetTargetPath(Value : Widestring);
Begin
  ChildNodes['TargetPath'].NodeValue := IncludeTrailingBackSlash(Value);
End;

Function TTSTOXmlSettings.GetWorkSpaceFile() : WideString;
Begin
  Result := ChildNodes['WorkSpaceFile'].Text;
End;

Procedure TTSTOXmlSettings.SetWorkSpaceFile(Value : WideString);
Begin
  ChildNodes['WorkSpaceFile'].NodeValue := Value;
End;

Function TTSTOXmlSettings.GetHackPath() : Widestring;
Begin
  Result := IncludeTrailingBackSlash(ChildNodes['HackPath'].Text);
End;

Procedure TTSTOXmlSettings.SetHackPath(Value : Widestring);
Begin
  ChildNodes['HackPath'].NodeValue := IncludeTrailingBackSlash(Value);
End;

Function TTSTOXmlSettings.GetHackFileName() : Widestring;
Begin
  Result := ChildNodes['HackFileName'].Text;
End;

Procedure TTSTOXmlSettings.SetHackFileName(Value : Widestring);
Begin
  ChildNodes['HackFileName'].NodeValue := Value;
End;

Function TTSTOXmlSettings.GetCustomPatchFileName() : WideString;
Begin
  Result := ChildNodes['CustomPatchFileName'].Text;
End;

Procedure TTSTOXmlSettings.SetCustomPatchFileName(Value : WideString);
Begin
  ChildNodes['CustomPatchFileName'].NodeValue := Value;
End;

Function TTSTOXmlSettings.GetDLCServer() : WideString;
Begin
  Result := ChildNodes['DLCServer'].Text;
End;

Procedure TTSTOXmlSettings.SetDLCServer(Value : WideString);
Begin
  ChildNodes['DLCServer'].NodeValue := Value;
End;

Function TTSTOXmlSettings.GetDLCPath() : WideString;
Begin
  Result := IncludeTrailingBackSlash(ChildNodes['DLCPath'].Text);
End;

Procedure TTSTOXmlSettings.SetDLCPath(Value : WideString);
Begin
  ChildNodes['DLCPath'].NodeValue := IncludeTrailingBackSlash(Value);
End;

Function TTSTOXmlSettings.GetSkinName() : WideString;
Begin
  Result := ChildNodes['SkinName'].Text;
End;

Procedure TTSTOXmlSettings.SetSkinName(Value : WideString);
Begin
  ChildNodes['SkinName'].NodeValue := Value;
End;

Function TTSTOXmlSettings.GetResourcePath() : WideString;
Begin
  Result := IncludeTrailingBackSlash(ChildNodes['ResourcePath'].Text);
End;

Procedure TTSTOXmlSettings.SetResourcePath(Value : WideString);
Begin
  ChildNodes['ResourcePath'].NodeValue := IncludeTrailingBackSlash(Value);
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

Function TTSTOXmlProjectFile.GetOutputPath: Widestring;
Begin
  Result := ChildNodes['OutputPath'].Text;
End;

Procedure TTSTOXmlProjectFile.SetOutputPath(Value: Widestring);
Begin
  ChildNodes['OutputPath'].NodeValue := Value;
End;

Function TTSTOXmlProjectFile.GetOutputFileName: Widestring;
Begin
  Result := ChildNodes['OutputFileName'].Text;
End;

Procedure TTSTOXmlProjectFile.SetOutputFileName(Value: Widestring);
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

Function TTSTOXmlSourcePaths.GetSourcePath(Index: Integer): Widestring;
Begin
  Result := List[Index].Text;
End;

Function TTSTOXmlSourcePaths.Add(Const SourcePath: Widestring): IXmlNodeEx;
Begin
  Result := AddItem(-1) As IXmlNodeEx;
  Result.NodeValue := SourcePath;
End;

Function TTSTOXmlSourcePaths.Insert(Const Index: Integer; Const SourcePath: Widestring): IXmlNodeEx;
Begin
  Result := AddItem(Index) As IXmlNodeEx;
  Result.NodeValue := SourcePath;
End;

End.
