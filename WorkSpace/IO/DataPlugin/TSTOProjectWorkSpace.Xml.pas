Unit TSTOProjectWorkSpace.Xml;

Interface

Uses Windows, Classes, HsXmlDocEx,
  TSTOProjectWorkSpace.Types;

Type
  IXmlTSTOWorkSpaceProjectSrcFolder = Interface(IXmlNodeCollectionEx)
    ['{C65944FF-18F9-4443-B163-828724879DFF}']
    Function  GetSrcPath() : AnsiString;
    Procedure SetSrcPath(Const ASrcPath : AnsiString);

    Function  GetSrcFileCount() : Integer;

    Function  GetSrcFiles(Index : Integer) : AnsiString;

    Function Add(Const FileName : AnsiString): IXmlNodeEx;
    Function Insert(Const Index : Integer; Const AFileName : AnsiString): IXmlNodeEx;

    Property SrcPath      : AnsiString  Read GetSrcPath Write SetSrcPath;
    Property SrcFileCount : Integer Read GetSrcFileCount;
    Property SrcFiles[Index : Integer] : AnsiString Read GetSrcFiles; Default;

  End;

  IXmlTSTOWorkSpaceProjectSrcFolders = Interface(IXmlNodeCollectionEx)
    ['{FD5DE83A-A14C-4A30-BB01-32FC28F712F0}']
    Function Add() : IXmlTSTOWorkSpaceProjectSrcFolder;
    Function Insert(Const Index : Integer): IXmlTSTOWorkSpaceProjectSrcFolder;
    Function GetItem(Index : Integer): IXmlTSTOWorkSpaceProjectSrcFolder;

    Property Items[Index : Integer] : IXmlTSTOWorkSpaceProjectSrcFolder Read GetItem; Default;

  End;

  IXmlTSTOWorkSpaceProject = Interface(IXmlNodeEx)
    ['{6AB7F958-921E-4C0C-B584-C2CE4D89BBE9}']
    Function  GetProjectName() : AnsiString;
    Procedure SetProjectName(Const AProjectName : AnsiString);

    Function  GetProjectKind() : TWorkSpaceProjectKind;
    Procedure SetProjectKind(Const AProjectKind : TWorkSpaceProjectKind);

    Function  GetProjectType() : TWorkSpaceProjectType;
    Procedure SetProjectType(Const AProjectType : TWorkSpaceProjectType);
    
    Function  GetZeroCrc32() : DWord;
    Procedure SetZeroCrc32(Const AZeroCrc32 : DWord); 

    Function  GetPackOutput() : Boolean;
    Procedure SetPackOutput(Const APackOutput : Boolean);

    Function  GetOutputPath() : AnsiString;
    Procedure SetOutputPath(Const AOutputPath : AnsiString);

    Function  GetCustomScriptPath() : AnsiString;
    Procedure SetCustomScriptPath(Const ACustomScriptPath : AnsiString);

    Function  GetCustomModPath() : AnsiString;
    Procedure SetCustomModPath(Const ACustomModPath : AnsiString);

    Function  GetSrcFolders() : IXmlTSTOWorkSpaceProjectSrcFolders;

    Procedure Assign(ASource : IInterface);

    Property ProjectName      : AnsiString                         Read GetProjectName      Write SetProjectName;
    Property ProjectKind      : TWorkSpaceProjectKind              Read GetProjectKind      Write SetProjectKind;
    Property ProjectType      : TWorkSpaceProjectType              Read GetProjectType      Write SetProjectType;
    Property ZeroCrc32        : DWord                              Read GetZeroCrc32        Write SetZeroCrc32;
    Property PackOutput       : Boolean                            Read GetPackOutput       Write SetPackOutput;
    Property OutputPath       : AnsiString                         Read GetOutputPath       Write SetOutputPath;
    Property CustomScriptPath : AnsiString                         Read GetCustomScriptPath Write SetCustomScriptPath;
    Property CustomModPath    : AnsiString                         Read GetCustomModPath    Write SetCustomModPath;
    Property SrcFolders       : IXmlTSTOWorkSpaceProjectSrcFolders Read GetSrcFolders;

  End;

  IXmlTSTOWorkSpaceProjectList = Interface(IXmlNodeCollectionEx)
    ['{7CDEBA81-1CDC-461A-AA6B-297E76B85C4E}']
    Function  GetProjectGroupName() : AnsiString;
    Procedure SetProjectGroupName(Const AProjectGroupName : AnsiString);

    Function  GetHackFileName() : AnsiString;
    Procedure SetHackFileName(Const AHackFileName : AnsiString);

    Function  GetPackOutput() : Boolean;
    Procedure SetPackOutput(Const APackOutput : Boolean);

    Function  GetOutputPath() : AnsiString;
    Procedure SetOutputPath(Const AOutputPath : AnsiString);

    Function Add() : IXmlTSTOWorkSpaceProject;
    Function Insert(Const Index : Integer) : IXmlTSTOWorkSpaceProject;
    Function GetItem(Index : Integer): IXmlTSTOWorkSpaceProject;

    Property ProjectGroupName : AnsiString Read GetProjectGroupName Write SetProjectGroupName;
    Property HackFileName     : AnsiString Read GetHackFileName     Write SetHackFileName;
    Property PackOutput       : Boolean    Read GetPackOutput       Write SetPackOutput;
    Property OutputPath       : AnsiString Read GetOutputPath       Write SetOutputPath;

    Property Items[Index : Integer] : IXmlTSTOWorkSpaceProject Read GetItem; Default;

  End;

  IXmlTSTOWorkSpaceProjectGroup = Interface(IXmlNodeEx)
    ['{891622A2-67ED-4505-AC51-45ED2E51F0A9}']
    Function  GetProjectGroupName() : AnsiString;
    Procedure SetProjectGroupName(Const AProjectGroupName : AnsiString);

    Function  GetHackFileName() : AnsiString;
    Procedure SetHackFileName(Const AHackFileName : AnsiString);

    Function  GetPackOutput() : Boolean;
    Procedure SetPackOutput(Const APackOutput : Boolean);

    Function  GetOutputPath() : AnsiString;
    Procedure SetOutputPath(Const AOutputPath : AnsiString);

    Function  GetWorkSpaceProject() : IXmlTSTOWorkSpaceProjectList;

    Procedure Assign(ASource : IInterface);

    Property ProjectGroupName : AnsiString Read GetProjectGroupName Write SetProjectGroupName;
    Property HackFileName     : AnsiString Read GetHackFileName     Write SetHackFileName;
    Property PackOutput       : Boolean    Read GetPackOutput       Write SetPackOutput;
    Property OutputPath       : AnsiString Read GetOutputPath       Write SetOutputPath;

    Property WorkSpaceProject : IXmlTSTOWorkSpaceProjectList Read GetWorkSpaceProject;

  End;

  TXmlTSTOWorkSpaceProjectGroup = Class(TObject)
  Public
    Class Function CreateWSProjectGroup() : IXmlTSTOWorkSpaceProjectGroup; OverLoad;
    Class Function CreateWSProjectGroup(Const AXmlString : AnsiString) : IXmlTSTOWorkSpaceProjectGroup; OverLoad;

  End;

Implementation

Uses SysUtils, RTLConsts,
  HsInterfaceEx,
  TSTOProjectWorkSpaceIntf, TSTOProjectWorkSpaceImpl;

Type
  TXmlTSTOWorkSpaceProjectSrcFolder = Class(TXmlNodeCollectionEx, ITSTOWorkSpaceProjectSrcFolder, IXmlTSTOWorkSpaceProjectSrcFolder)
  Private
    Function GetImplementor() : ITSTOWorkSpaceProjectSrcFolder;

  Protected
    Property WSSrcFolder : ITSTOWorkSpaceProjectSrcFolder Read GetImplementor Implements ITSTOWorkSpaceProjectSrcFolder;

    Function  GetSrcPath() : AnsiString;
    Procedure SetSrcPath(Const ASrcPath : AnsiString);

    Function  GetSrcFileCount() : Integer;

    Function GetSrcFiles(Index : Integer) : AnsiString;

    Function Add(Const AFileName : AnsiString) : IXmlNodeEx;
    Function Insert(Const Index : Integer; Const AFileName : AnsiString) : IXmlNodeEx;

  Public
    Procedure AfterConstruction(); Override;

  End;

  TXmlTSTOWorkSpaceProjectSrcFolders = Class(TXmlNodeCollectionEx, IXmlTSTOWorkSpaceProjectSrcFolders)
  Protected
    Function Add() : IXmlTSTOWorkSpaceProjectSrcFolder;
    Function Insert(Const Index : Integer) : IXmlTSTOWorkSpaceProjectSrcFolder;
    Function GetItem(Index : Integer) : IXmlTSTOWorkSpaceProjectSrcFolder;

  End;

  TXmlTSTOWorkSpaceProject = Class(TXmlNodeEx, ITSTOWorkSpaceProject, IXmlTSTOWorkSpaceProject)
  Private
    FSrcFolder     : IXmlTSTOWorkSpaceProjectSrcFolders;
    FOnChanged     : TNotifyEvent;
    FWSProjectImpl : Pointer;

    Function GetImplementor() : ITSTOWorkSpaceProject;

    Procedure InternalAssign(ASource, ATarget : ITSTOWorkSpaceProject);

  Protected
    Property WSProjectImpl : ITSTOWorkSpaceProject Read GetImplementor;

  Protected
    Function  GetProjectName() : AnsiString;
    Procedure SetProjectName(Const AProjectName : AnsiString);

    Function  GetProjectKind() : TWorkSpaceProjectKind;
    Procedure SetProjectKind(Const AProjectKind : TWorkSpaceProjectKind); 

    Function  GetProjectType() : TWorkSpaceProjectType;
    Procedure SetProjectType(Const AProjectType : TWorkSpaceProjectType);
    
    Function  GetZeroCrc32() : DWord;
    Procedure SetZeroCrc32(Const AZeroCrc32 : DWord);

    Function  GetPackOutput() : Boolean;
    Procedure SetPackOutput(Const APackOutput : Boolean);

    Function  GetOutputPath() : AnsiString;
    Procedure SetOutputPath(Const AOutputPath : AnsiString);

    Function  GetCustomScriptPath() : AnsiString;
    Procedure SetCustomScriptPath(Const ACustomScriptPath : AnsiString);

    Function  GetCustomModPath() : AnsiString;
    Procedure SetCustomModPath(Const ACustomModPath : AnsiString);

    Function  GetSrcFolders() : IXmlTSTOWorkSpaceProjectSrcFolders;
    Function  GetISrcFolders() : ITSTOWorkSpaceProjectSrcFolders;
    Function  ITSTOWorkSpaceProject.GetSrcFolders = GetISrcFolders;

    Function  GetEncryptScript() : Boolean;
    Procedure SetEncryptScript(Const AEncryptScript : Boolean);

    Function  GetUseADS() : Boolean;
    Procedure SetUseADS(Const AUseADS : Boolean);

    Function  GetOnChanged() : TNotifyEvent;
    Procedure SetOnChanged(AOnChanged : TNotifyEvent);
    
    Procedure Assign(ASource : IInterface); ReIntroduce;

  Public
    Procedure AfterConstruction(); Override;

  End;

  TXmlTSTOWorkSpaceProjectList = Class(TXmlNodeCollectionEx, IXmlTSTOWorkSpaceProjectList)
  Protected
    Function  GetProjectGroupName() : AnsiString;
    Procedure SetProjectGroupName(Const AProjectGroupName : AnsiString);

    Function  GetHackFileName() : AnsiString;
    Procedure SetHackFileName(Const AHackFileName : AnsiString);

    Function  GetPackOutput() : Boolean;
    Procedure SetPackOutput(Const APackOutput : Boolean);

    Function  GetOutputPath() : AnsiString;
    Procedure SetOutputPath(Const AOutputPath : AnsiString);

    Function Add() : IXmlTSTOWorkSpaceProject;
    Function Insert(Const Index: Integer): IXmlTSTOWorkSpaceProject;
    Function GetItem(Index: Integer): IXmlTSTOWorkSpaceProject;

  End;

  TXmlTSTOProjectGroupImpl = Class(TXmlNodeEx, ITSTOWorkSpaceProjectGroup, IXmlTSTOWorkSpaceProjectGroup)
  Private
    FWorkSpaceProject : IXmlTSTOWorkSpaceProjectList;
    Function GetImplementor() : ITSTOWorkSpaceProjectGroup;

    Function  CreateITSTOWorkSpaceProjectGroup(ASource : IXmlTSTOWorkSpaceProjectGroup) : ITSTOWorkSpaceProjectGroup;
    Procedure InternalAssign(ASource, ATarget : ITSTOWorkSpaceProjectGroup); OverLoad;
    Procedure InternalAssign(ASource : ITSTOWorkSpaceProjectGroup; ATarget : IXmlTSTOWorkSpaceProjectGroup); OverLoad;
    Procedure InternalAssign(ASource : IXmlTSTOWorkSpaceProjectGroup; ATarget : ITSTOWorkSpaceProjectGroup); OverLoad;

  Protected
    Property WorkSpaceProjectGroupImpl : ITSTOWorkSpaceProjectGroup Read GetImplementor Implements ITSTOWorkSpaceProjectGroup;

    Function  GetProjectGroupName() : AnsiString;
    Procedure SetProjectGroupName(Const AProjectGroupName : AnsiString);

    Function  GetHackFileName() : AnsiString;
    Procedure SetHackFileName(Const AHackFileName : AnsiString);

    Function  GetPackOutput() : Boolean;
    Procedure SetPackOutput(Const APackOutput : Boolean);

    Function  GetOutputPath() : AnsiString;
    Procedure SetOutputPath(Const AOutputPath : AnsiString);

    Function  GetWorkSpaceProject() : IXmlTSTOWorkSpaceProjectList;

    Procedure Assign(ASource : IInterface);

  Public
    Procedure AfterConstruction(); Override;

  End;

Class Function TXmlTSTOWorkSpaceProjectGroup.CreateWSProjectGroup() : IXmlTSTOWorkSpaceProjectGroup;
Begin
  Result := NewXMLDocument.GetDocBinding('ProjectGroup', TXmlTSTOProjectGroupImpl, '') As IXmlTSTOWorkSpaceProjectGroup;
End;

Class Function TXmlTSTOWorkSpaceProjectGroup.CreateWSProjectGroup(Const AXmlString : AnsiString) : IXmlTSTOWorkSpaceProjectGroup;
Begin
  Result := LoadXmlData(AXmlString).GetDocBinding('ProjectGroup', TXmlTSTOProjectGroupImpl, '') As IXmlTSTOWorkSpaceProjectGroup;
End;

(******************************************************************************)

Procedure TXmlTSTOWorkSpaceProject.AfterConstruction();
Begin
  RegisterChildNode('SrcFolder', TXmlTSTOWorkSpaceProjectSrcFolder);
  FSrcFolder := CreateCollection(TXmlTSTOWorkSpaceProjectSrcFolders, IXmlTSTOWorkSpaceProjectSrcFolder, 'SrcFolder') As IXmlTSTOWorkSpaceProjectSrcFolders;

  FWSProjectImpl := Pointer(ITSTOWorkSpaceProject(Self));

  Inherited;
End;

Function TXmlTSTOWorkSpaceProject.GetOnChanged() : TNotifyEvent;
Begin
  Result := FOnChanged;
End;

Procedure TXmlTSTOWorkSpaceProject.SetOnChanged(AOnChanged : TNotifyEvent);
Begin
  FOnChanged := AOnChanged;
End;

Function TXmlTSTOWorkSpaceProject.GetImplementor() : ITSTOWorkSpaceProject;
Begin
  Result := ITSTOWorkSpaceProject(FWSProjectImpl);
End;

Procedure TXmlTSTOWorkSpaceProject.InternalAssign(ASource, ATarget : ITSTOWorkSpaceProject);
Var lXmlTrg : IXmlTSTOWorkSpaceProject;
    X, Y    : Integer;
Begin
  If ASource <> ATarget Then
  Begin
    ATarget.ProjectName      := ASource.ProjectName;
    ATarget.ProjectKind      := ASource.ProjectKind;
    ATarget.ProjectType      := ASource.ProjectType;
    ATarget.ZeroCrc32        := ASource.ZeroCrc32;
    ATarget.PackOutput       := ASource.PackOutput;
    ATarget.EncryptScript    := ASource.EncryptScript;
    ATarget.UseADS           := ASource.UseADS;
    ATarget.OutputPath       := ASource.OutputPath;
    ATarget.CustomScriptPath := ASource.CustomScriptPath;
    ATarget.CustomModPath    := ASource.CustomModPath;
//    ATarget.HackFileName     := ASource.HackFileName;

    If Supports(ATarget, IXmlNodeEx) And
       Supports(ATarget, IXmlTSTOWorkSpaceProject, lXmlTrg) Then
      For X := 0 To ASource.SrcFolders.Count - 1 Do
        With lXmlTrg.SrcFolders.Add() Do
        Begin
          SrcPath := ASource.SrcFolders[X].SrcPath;

          For Y := 0 To ASource.SrcFolders[X].SrcFileCount - 1 Do
            Add(ASource.SrcFolders[X].SrcFiles[Y].FileName);
        End
    Else
      For X := 0 To ASource.SrcFolders.Count - 1 Do
        With ATarget.SrcFolders.Add() Do
        Begin
          SrcPath := ASource.SrcFolders[X].SrcPath;

          For Y := 0 To ASource.SrcFolders[X].SrcFileCount - 1 Do
            Add(ASource.SrcFolders[X].SrcFiles[Y].FileName);
        End;
  End;
End;

Procedure TXmlTSTOWorkSpaceProject.Assign(ASource : IInterface);
Var lXmlSrc : IXmlTSTOWorkSpaceProject;
    lSrc    : ITSTOWorkSpaceProject;
    X, Y    : Integer;
Begin
  If Supports(ASource, ITSTOWorkSpaceProject, lSrc) Then
  Begin
    If FWSProjectImpl <> Pointer(lSrc) Then
    Begin
      InternalAssign(lSrc, Self);
      FWSProjectImpl := Pointer(lSrc);
    End;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TXmlTSTOWorkSpaceProject.GetProjectName() : AnsiString;
Begin
  Result := ChildNodes['ProjectName'].Text;
End;

Procedure TXmlTSTOWorkSpaceProject.SetProjectName(Const AProjectName : AnsiString);
Begin
  ChildNodes['ProjectName'].NodeValue := AProjectName;

  If Not IsImplementorOf(WSProjectImpl) Then
    WSProjectImpl.ProjectName := AProjectName;
End;

Function TXmlTSTOWorkSpaceProject.GetProjectKind() : TWorkSpaceProjectKind;
Begin
  Result := TWorkSpaceProjectKind(ChildNodes['ProjectKind'].AsInteger);
End;

Procedure TXmlTSTOWorkSpaceProject.SetProjectKind(Const AProjectKind : TWorkSpaceProjectKind);
Begin
  ChildNodes['ProjectKind'].NodeValue := Ord(AProjectKind);

  If Not IsImplementorOf(WSProjectImpl) Then
    WSProjectImpl.ProjectKind := AProjectKind;
End;

Function TXmlTSTOWorkSpaceProject.GetProjectType() : TWorkSpaceProjectType;
Begin
  Result := TWorkSpaceProjectType(ChildNodes['ProjectType'].AsInteger);
End;

Procedure TXmlTSTOWorkSpaceProject.SetProjectType(Const AProjectType : TWorkSpaceProjectType);
Begin
  ChildNodes['ProjectType'].NodeValue := Ord(AProjectType);

  If Not IsImplementorOf(WSProjectImpl) Then
    WSProjectImpl.ProjectType := AProjectType;
End;

Function TXmlTSTOWorkSpaceProject.GetZeroCrc32() : DWord;
Begin
  Result := ChildNodes['ZeroCrc32'].AsInteger;
End;

Procedure TXmlTSTOWorkSpaceProject.SetZeroCrc32(Const AZeroCrc32 : DWord);
Begin
  ChildNodes['ZeroCrc32'].NodeValue := AZeroCrc32;

  If Not IsImplementorOf(WSProjectImpl) Then
    WSProjectImpl.ZeroCrc32 := AZeroCrc32;
End;

Function TXmlTSTOWorkSpaceProject.GetPackOutput() : Boolean;
Begin
  Result := ChildNodes['PackOutput'].AsBoolean;
End;

Procedure TXmlTSTOWorkSpaceProject.SetPackOutput(Const APackOutput : Boolean);
Begin
  ChildNodes['PackOutput'].AsBoolean := APackOutput;

  If Not IsImplementorOf(WSProjectImpl) Then
    WSProjectImpl.PackOutput := APackOutput;
End;

Function TXmlTSTOWorkSpaceProject.GetEncryptScript() : Boolean;
Begin
  Result := ChildNodes['EncryptScript'].AsBoolean;
End;

Procedure TXmlTSTOWorkSpaceProject.SetEncryptScript(Const AEncryptScript : Boolean);
Begin
  ChildNodes['EncryptScript'].AsBoolean := AEncryptScript;

  If Not IsImplementorOf(WSProjectImpl) Then
    WSProjectImpl.EncryptScript := AEncryptScript;
End;

Function TXmlTSTOWorkSpaceProject.GetUseADS() : Boolean;
Begin
  Result := ChildNodes['UseADS'].AsBoolean;
End;

Procedure TXmlTSTOWorkSpaceProject.SetUseADS(Const AUseADS : Boolean);
Begin
  ChildNodes['UseADS'].AsBoolean := AUseADS;

  If Not IsImplementorOf(WSProjectImpl) Then
    WSProjectImpl.UseADS := AUseADS;
End;

Function TXmlTSTOWorkSpaceProject.GetOutputPath() : AnsiString;
Begin
  Result := ChildNodes['OutputPath'].AsString;
End;

Procedure TXmlTSTOWorkSpaceProject.SetOutputPath(Const AOutputPath : AnsiString);
Begin
  ChildNodes['OutputPath'].AsString := AOutputPath;

  If Not IsImplementorOf(WSProjectImpl) Then
    WSProjectImpl.OutputPath := AOutputPath;
End;

Function TXmlTSTOWorkSpaceProject.GetCustomScriptPath() : AnsiString;
Begin
  Result := ChildNodes['CustomScriptPath'].AsString;
End;

Procedure TXmlTSTOWorkSpaceProject.SetCustomScriptPath(Const ACustomScriptPath : AnsiString);
Begin
  ChildNodes['CustomScriptPath'].AsString := ACustomScriptPath;

  If Not IsImplementorOf(WSProjectImpl) Then
    WSProjectImpl.CustomScriptPath := ACustomScriptPath;
End;

Function TXmlTSTOWorkSpaceProject.GetCustomModPath() : AnsiString;
Begin
  Result := ChildNodes['CustomModPath'].AsString;
End;

Procedure TXmlTSTOWorkSpaceProject.SetCustomModPath(Const ACustomModPath : AnsiString);
Begin
  ChildNodes['CustomModPath'].AsString := ACustomModPath;

  If Not IsImplementorOf(WSProjectImpl) Then
    WSProjectImpl.CustomModPath := ACustomModPath;
End;

Function TXmlTSTOWorkSpaceProject.GetSrcFolders() : IXmlTSTOWorkSpaceProjectSrcFolders;
Begin
  Result := FSrcFolder;
End;

Function TXmlTSTOWorkSpaceProject.GetISrcFolders() : ITSTOWorkSpaceProjectSrcFolders;
Var X : Integer;
Begin
  Result := TTSTOWorkSpaceProjectSrcFolders.Create();

  For X := 0 To FSrcFolder.Count - 1 Do
    Result.Add().Assign(FSrcFolder.Items[X]);
//  Result := FSrcFolder As ITSTOWorkSpaceProjectSrcFolders;
End;

Procedure TXmlTSTOWorkSpaceProjectSrcFolder.AfterConstruction();
Begin
  ItemTag := 'File';
  ItemInterface := IXmlNodeEx;

  Inherited;
End;

Function TXmlTSTOWorkSpaceProjectSrcFolder.GetImplementor() : ITSTOWorkSpaceProjectSrcFolder;
Var X : Integer;
Begin
  Result := TTSTOWorkSpaceProjectSrcFolder.Create();

  Result.SrcPath := GetSrcPath;
  For X := 0 To List.Count - 1 Do
    Result.Add(List[X].NodeValue);
End;

Function TXmlTSTOWorkSpaceProjectSrcFolder.GetSrcPath() : AnsiString;
Begin
  Result := AttributeNodes['Name'].Text;
End;

Procedure TXmlTSTOWorkSpaceProjectSrcFolder.SetSrcPath(Const ASrcPath : AnsiString);
Begin
  SetAttribute('Name', ASrcPath);
End;

Function TXmlTSTOWorkSpaceProjectSrcFolder.GetSrcFileCount() : Integer;
Begin
  Result := List.Count;
End;

Function TXmlTSTOWorkSpaceProjectSrcFolder.GetSrcFiles(Index: Integer): AnsiString;
Begin
  Result := List[Index].Text;
End;

Function TXmlTSTOWorkSpaceProjectSrcFolder.Add(Const AFileName : AnsiString): IXmlNodeEx;
Begin
  Result := AddItem(-1);
  Result.NodeValue := AFileName;
End;

Function TXmlTSTOWorkSpaceProjectSrcFolder.Insert(Const Index : Integer; Const AFileName : AnsiString): IXmlNodeEx;
Begin
  Result := AddItem(Index);
  Result.NodeValue := AFileName;
End;

Function TXmlTSTOWorkSpaceProjectSrcFolders.Add() : IXmlTSTOWorkSpaceProjectSrcFolder;
Begin
  Result := AddItem(-1) As IXmlTSTOWorkSpaceProjectSrcFolder;
End;

Function TXmlTSTOWorkSpaceProjectSrcFolders.Insert(Const Index: Integer): IXmlTSTOWorkSpaceProjectSrcFolder;
Begin
  Result := AddItem(Index) As IXmlTSTOWorkSpaceProjectSrcFolder;
End;

Function TXmlTSTOWorkSpaceProjectSrcFolders.GetItem(Index: Integer): IXmlTSTOWorkSpaceProjectSrcFolder;
Begin
  Result := List[Index] As IXmlTSTOWorkSpaceProjectSrcFolder;
End;

Function TXmlTSTOWorkSpaceProjectList.GetProjectGroupName() : AnsiString;
Begin
  Result := OwnerDocument.DocumentElement.ChildNodes['ProjectGroupName'].Text;
End;

Procedure TXmlTSTOWorkSpaceProjectList.SetProjectGroupName(Const AProjectGroupName : AnsiString);
Begin
  OwnerDocument.DocumentElement.ChildNodes['ProjectGroupName'].Text := AProjectGroupName;
End;

Function TXmlTSTOWorkSpaceProjectList.GetHackFileName() : AnsiString;
Begin
  Result := OwnerDocument.DocumentElement.ChildNodes['HackFileName'].Text;
End;

Procedure TXmlTSTOWorkSpaceProjectList.SetHackFileName(Const AHackFileName : AnsiString);
Begin
  OwnerDocument.DocumentElement.ChildNodes['HackFileName'].Text := AHackFileName;
End;

Function TXmlTSTOWorkSpaceProjectList.GetPackOutput() : Boolean;
Begin
  Result := StrToBoolDef(OwnerDocument.DocumentElement.ChildNodes['PackOutput'].Text, False);
End;

Procedure TXmlTSTOWorkSpaceProjectList.SetPackOutput(Const APackOutput : Boolean);
Begin
  If APackOutput Then
    OwnerDocument.DocumentElement.ChildNodes['HackFileName'].Text := 'true'
  Else
    OwnerDocument.DocumentElement.ChildNodes['HackFileName'].Text := 'false';
End;

Function TXmlTSTOWorkSpaceProjectList.GetOutputPath() : AnsiString;
Begin
  Result := OwnerDocument.DocumentElement.ChildNodes['OutputPath'].Text;
End;

Procedure TXmlTSTOWorkSpaceProjectList.SetOutputPath(Const AOutputPath : AnsiString);
Begin
  OwnerDocument.DocumentElement.ChildNodes['HackFileName'].Text := AOutputPath;
End;

Function TXmlTSTOWorkSpaceProjectList.Add: IXmlTSTOWorkSpaceProject;
Begin
  Result := AddItem(-1) As IXmlTSTOWorkSpaceProject;
End;

Function TXmlTSTOWorkSpaceProjectList.Insert(Const Index: Integer): IXmlTSTOWorkSpaceProject;
Begin
  Result := AddItem(Index) As IXmlTSTOWorkSpaceProject;
End;

Function TXmlTSTOWorkSpaceProjectList.GetItem(Index: Integer): IXmlTSTOWorkSpaceProject;
Begin
  Result := List[Index] As IXmlTSTOWorkSpaceProject;
End;

Procedure TXmlTSTOProjectGroupImpl.AfterConstruction();
Begin
  RegisterChildNode('WorkSpaceProject', TXmlTSTOWorkSpaceProject);
  FWorkSpaceProject := CreateCollection(TXmlTSTOWorkSpaceProjectList, IXmlTSTOWorkSpaceProject, 'WorkSpaceProject') As IXmlTSTOWorkSpaceProjectList;

  Inherited;
End;

Function TXmlTSTOProjectGroupImpl.CreateITSTOWorkSpaceProjectGroup(ASource : IXmlTSTOWorkSpaceProjectGroup) : ITSTOWorkSpaceProjectGroup;
Var X : Integer;
Begin
  Result := TTSTOWorkSpaceProjectGroup.Create();

  Result.ProjectGroupName := ASource.ProjectGroupName;
  For X := 0 To ASource.WorkSpaceProject.Count - 1 Do
    Result.Add().Assign(ASource.WorkSpaceProject[X]);
End;

Procedure TXmlTSTOProjectGroupImpl.InternalAssign(ASource, ATarget : ITSTOWorkSpaceProjectGroup);
Var X : Integer;
Begin
  If ASource <> ATarget Then
  Begin
    ATarget.ProjectGroupName := ASource.ProjectGroupName;
    ATarget.HackFileName     := ASource.HackFileName;
    ATarget.PackOutput       := ASource.PackOutput;
    ATarget.OutputPath       := ASource.OutputPath;

    For X := 0 To ASource.Count - 1 Do
      ATarget.Add().Assign(ASource[X]);
  End;
End;

Procedure TXmlTSTOProjectGroupImpl.InternalAssign(ASource : ITSTOWorkSpaceProjectGroup; ATarget : IXmlTSTOWorkSpaceProjectGroup);
Begin
  InternalAssign(ASource, CreateITSTOWorkSpaceProjectGroup(ATarget));
End;

Procedure TXmlTSTOProjectGroupImpl.InternalAssign(ASource : IXmlTSTOWorkSpaceProjectGroup; ATarget : ITSTOWorkSpaceProjectGroup);
Begin
  InternalAssign(CreateITSTOWorkSpaceProjectGroup(ASource), ATarget);
End;

Procedure TXmlTSTOProjectGroupImpl.Assign(ASource : IInterface);
Var lXmlSrc : IXmlTSTOWorkSpaceProjectGroup;
    lSrc    : ITSTOWorkSpaceProjectGroup;
    X       : Integer;
Begin
  If Supports(ASource, IXmlNodeEx) And
     Supports(ASource, IXmlTSTOWorkSpaceProjectGroup, lXmlSrc) Then
  Begin
    FWorkSpaceProject.ProjectGroupName := lXmlSrc.ProjectGroupName;
    FWorkSpaceProject.HackFileName     := lXmlSrc.HackFileName;
    FWorkSpaceProject.PackOutput       := lXmlSrc.PackOutput;
    FWorkSpaceProject.OutputPath       := lXmlSrc.OutputPath;

    For X := 0 To lXmlSrc.ChildNodes.Count Do
      FWorkSpaceProject.Add().Assign(lXmlSrc.ChildNodes[X]);
  End
  Else If Supports(ASource, ITSTOWorkSpaceProjectGroup, lSrc) Then
  Begin
    FWorkSpaceProject.ProjectGroupName := lSrc.ProjectGroupName;
    FWorkSpaceProject.HackFileName     := lSrc.HackFileName;
    FWorkSpaceProject.PackOutput       := lSrc.PackOutput;
    FWorkSpaceProject.OutputPath       := lSrc.OutputPath;

    For X := 0 To lSrc.Count - 1 Do
      FWorkSpaceProject.Add().Assign(lSrc[X]);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TXmlTSTOProjectGroupImpl.GetImplementor() : ITSTOWorkSpaceProjectGroup;
Begin
  Result := TTSTOWorkSpaceProjectGroup.Create();

  InternalAssign(CreateITSTOWorkSpaceProjectGroup(Self), Result);
End;

Function TXmlTSTOProjectGroupImpl.GetProjectGroupName() : AnsiString;
Begin
  Result := ChildNodes['ProjectGroupName'].Text;
End;

Procedure TXmlTSTOProjectGroupImpl.SetProjectGroupName(Const AProjectGroupName : AnsiString);
Begin
  ChildNodes['ProjectGroupName'].NodeValue := AProjectGroupName;
End;

Function TXmlTSTOProjectGroupImpl.GetHackFileName() : AnsiString;
Begin
  Result := ChildNodes['HackFileName'].Text;
End;

Procedure TXmlTSTOProjectGroupImpl.SetHackFileName(Const AHackFileName : AnsiString);
Begin
  ChildNodes['HackFileName'].NodeValue := AHackFileName;
End;

Function TXmlTSTOProjectGroupImpl.GetPackOutput() : Boolean;
Begin
  Result := ChildNodes['PackOutput'].AsBoolean;
End;

Procedure TXmlTSTOProjectGroupImpl.SetPackOutput(Const APackOutput : Boolean);
Begin
  ChildNodes['PackOutput'].NodeValue := APackOutput;
End;

Function TXmlTSTOProjectGroupImpl.GetOutputPath() : AnsiString;
Begin
  Result := ChildNodes['OutputPath'].Text;
End;

Procedure TXmlTSTOProjectGroupImpl.SetOutputPath(Const AOutputPath : AnsiString);
Begin
  ChildNodes['OutputPath'].NodeValue := AOutputPath;
End;

Function TXmlTSTOProjectGroupImpl.GetWorkSpaceProject() : IXmlTSTOWorkSpaceProjectList;
Begin
  Result := FWorkSpaceProject;
End;

End.