unit TSTOProjectWorkSpaceImpl;

Interface

Uses Windows, Classes, SysUtils, RTLConsts,
  HsInterfaceEx, HsStringListEx,
  TSTOProjectWorkSpaceIntf, TSTOProjectWorkSpace.Types;

Type
  TTSTOWorkSpaceProjectSrcFile = Class(TInterfacedObjectEx, ITSTOWorkSpaceProjectSrcFile)
  Private
    FFileName : AnsiString;

  Protected
    Function  GetFileName() : AnsiString;
    Procedure SetFileName(Const AFileName : AnsiString);

    Property FileName : AnsiString Read GetFileName Write SetFileName;

  End;

  TTSTOWorkSpaceProjectSrcFiles = Class(TInterfaceListEx, ITSTOWorkSpaceProjectSrcFiles)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : ITSTOWorkSpaceProjectSrcFile; OverLoad;
    Procedure Put(Index : Integer; Const Item : ITSTOWorkSpaceProjectSrcFile); OverLoad;

    Function Add() : ITSTOWorkSpaceProjectSrcFile; OverLoad;
    Function Add(Const AItem : ITSTOWorkSpaceProjectSrcFile) : Integer; OverLoad;
    Function Remove(Const Item : ITSTOWorkSpaceProjectSrcFile) : Integer; OverLoad;

  End;

  TTSTOWorkSpaceProjectSrcFilesClass = Class Of TTSTOWorkSpaceProjectSrcFiles;
  TTSTOWorkSpaceProjectSrcFolder = Class(TInterfacedObjectEx, ITSTOWorkSpaceProjectSrcFolder)
  Private
    FSrcPath  : AnsiString;
    FSrcFiles : ITSTOWorkSpaceProjectSrcFiles;

  Protected
    Function GetSrcFilesClass() : TTSTOWorkSpaceProjectSrcFilesClass; Virtual;

    Function  GetSrcPath() : AnsiString;
    Procedure SetSrcPath(Const ASrcPath : AnsiString);

    Function  GetSrcFileCount() : Integer;

    Function  GetFileList() : ITSTOWorkSpaceProjectSrcFiles;

    Function  GetSrcFiles(Index : Integer) : ITSTOWorkSpaceProjectSrcFile;

    Procedure Add(Const AFileName : AnsiString); OverLoad;
    Function  Add(Const AItem : ITSTOWorkSpaceProjectSrcFile) : Integer; OverLoad;
    Function  Add() : ITSTOWorkSpaceProjectSrcFile; OverLoad;

    Procedure Clear();

    Property SrcPath      : AnsiString  Read GetSrcPath Write SetSrcPath;
    Property SrcFileCount : Integer Read GetSrcFileCount;
    Property SrcFiles[Index : Integer] : ITSTOWorkSpaceProjectSrcFile Read GetSrcFiles;

    Procedure Assign(ASource : IInterface);

  Public
    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;

  End;

  TTSTOWorkSpaceProjectSrcFolders = Class(TInterfaceListEx, ITSTOWorkSpaceProjectSrcFolders)
  Protected
    Function  GetItemClass() : TInterfacedObjectExClass; OverRide;

    Function  Get(Index : Integer) : ITSTOWorkSpaceProjectSrcFolder; OverLoad;
    Procedure Put(Index : Integer; Const Item : ITSTOWorkSpaceProjectSrcFolder); OverLoad;

    Function Add() : ITSTOWorkSpaceProjectSrcFolder; ReIntroduce; OverLoad;
    Function Add(Const AItem : ITSTOWorkSpaceProjectSrcFolder) : Integer; ReIntroduce; OverLoad;
    Function Remove(Const Item : ITSTOWorkSpaceProjectSrcFile) : Integer;

    Procedure Assign(ASource : IInterface);

  End;

  TTSTOWorkSpaceProjectSrcFoldersClass = Class Of TTSTOWorkSpaceProjectSrcFolders;

  TTSTOWorkSpaceProject = Class(TInterfacedObjectEx, ITSTOWorkSpaceProject)
  Private
    FProjectName      : AnsiString;
    FProjectKind      : TWorkSpaceProjectKind;
    FProjectType      : TWorkSpaceProjectType;
    FZeroCrc32        : DWord;
    FPackOutput       : Boolean;
    FOutputPath       : AnsiString;
    FCustomScriptPath : AnsiString;
    FCustomModPath    : AnsiString;
    FSrcFolders       : ITSTOWorkSpaceProjectSrcFolders;

  Protected
    Function  GetWorkSpaceProjectSrcFoldersClass() : TTSTOWorkSpaceProjectSrcFoldersClass; Virtual;

    Function  GetProjectName() : AnsiString; Virtual;
    Procedure SetProjectName(Const AProjectName : AnsiString); Virtual;

    Function  GetProjectKind() : TWorkSpaceProjectKind; Virtual;
    Procedure SetProjectKind(Const AProjectKind : TWorkSpaceProjectKind); Virtual;

    Function  GetProjectType() : TWorkSpaceProjectType; Virtual;
    Procedure SetProjectType(Const AProjectType : TWorkSpaceProjectType); Virtual;

    Function  GetZeroCrc32() : DWord; Virtual;
    Procedure SetZeroCrc32(Const AZeroCrc32 : DWord); Virtual;

    Function  GetPackOutput() : Boolean; Virtual;
    Procedure SetPackOutput(Const APackOutput : Boolean); Virtual;

    Function  GetOutputPath() : AnsiString; Virtual;
    Procedure SetOutputPath(Const AOutputPath : AnsiString); Virtual;

    Function  GetCustomScriptPath() : AnsiString; Virtual;
    Procedure SetCustomScriptPath(Const ACustomScriptPath : AnsiString); Virtual;

    Function  GetCustomModPath() : AnsiString; Virtual;
    Procedure SetCustomModPath(Const ACustomModPath : AnsiString); Virtual;

    Function  GetSrcFolders() : ITSTOWorkSpaceProjectSrcFolders;

    Procedure Clear();

    Procedure Assign(ASource : IInterface);

    Property ProjectName      : AnsiString                      Read GetProjectName      Write SetProjectName;
    Property ProjectKind      : TWorkSpaceProjectKind           Read GetProjectKind      Write SetProjectKind;
    Property ProjectType      : TWorkSpaceProjectType           Read GetProjectType      Write SetProjectType;
    Property ZeroCrc32        : DWord                           Read GetZeroCrc32        Write SetZeroCrc32;
    Property PackOutput       : Boolean                         Read GetPackOutput       Write SetPackOutput;
    Property OutputPath       : AnsiString                      Read GetOutputPath       Write SetOutputPath;
    Property CustomScriptPath : AnsiString                      Read GetCustomScriptPath Write SetCustomScriptPath;
    Property CustomModPath    : AnsiString                      Read GetCustomModPath    Write SetCustomModPath;
    Property SrcFolders       : ITSTOWorkSpaceProjectSrcFolders Read GetSrcFolders;

  Public
    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;

  End;

  TTSTOWorkSpaceProjectGroup = Class(TInterfaceListEx, ITSTOWorkSpaceProjectGroup)
  Private
    FProjectGroupName : AnsiString;
    FHackFileName     : AnsiString;
    FPackOutput       : Boolean;
    FOutputPath       : AnsiString;

  Protected
    Function  GetItemClass() : TInterfacedObjectExClass; OverRide;

    Function  Get(Index : Integer) : ITSTOWorkSpaceProject; OverLoad;
    Procedure Put(Index : Integer; Const Item : ITSTOWorkSpaceProject); OverLoad;

    Function  GetProjectGroupName() : AnsiString; Virtual;
    Procedure SetProjectGroupName(Const AProjectGroupName : AnsiString); Virtual;

    Function  GetHackFileName() : AnsiString; Virtual;
    Procedure SetHackFileName(Const AHackFileName : AnsiString); Virtual;

    Function  GetPackOutput() : Boolean; Virtual;
    Procedure SetPackOutput(Const APackOutput : Boolean); Virtual;

    Function  GetOutputPath() : AnsiString; Virtual;
    Procedure SetOutputPath(Const AOutputPath : AnsiString); Virtual;

    Function Add() : ITSTOWorkSpaceProject; ReIntroduce; OverLoad;
    Function Add(Const AItem : ITSTOWorkSpaceProject) : Integer; ReIntroduce; OverLoad;

    Function Remove(Const Item : ITSTOWorkSpaceProject) : Integer; OverLoad;

    Procedure Clear(); OverRide;

    Procedure Assign(ASource : IInterface); Virtual;

    Property Items[Index : Integer] : ITSTOWorkSpaceProject Read Get Write Put; Default;

    Property ProjectGroupName : AnsiString Read GetProjectGroupName Write SetProjectGroupName;
    Property HackFileName     : AnsiString Read GetHackFileName     Write SetHackFileName;
    Property PackOutput       : Boolean    Read GetPackOutput       Write SetPackOutput;
    Property OutputPath       : AnsiString Read GetOutputPath       Write SetOutputPath;

  End;

Implementation

Function TTSTOWorkSpaceProjectSrcFile.GetFileName() : AnsiString;
Begin
  Result := FFileName;
End;

Procedure TTSTOWorkSpaceProjectSrcFile.SetFileName(Const AFileName : AnsiString);
Begin
  FFileName := AFileName;
End;

Function TTSTOWorkSpaceProjectSrcFiles.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TTSTOWorkSpaceProjectSrcFile;
End;

Function TTSTOWorkSpaceProjectSrcFiles.Get(Index : Integer) : ITSTOWorkSpaceProjectSrcFile;
Begin
  Result := InHerited Items[Index] As ITSTOWorkSpaceProjectSrcFile;
End;

Procedure TTSTOWorkSpaceProjectSrcFiles.Put(Index : Integer; Const Item : ITSTOWorkSpaceProjectSrcFile);
Begin
  InHerited Items[Index] := Item;
End;

Function TTSTOWorkSpaceProjectSrcFiles.Add() : ITSTOWorkSpaceProjectSrcFile;
Begin
  Result := InHerited Add() As ITSTOWorkSpaceProjectSrcFile;
End;

Function TTSTOWorkSpaceProjectSrcFiles.Add(Const AItem : ITSTOWorkSpaceProjectSrcFile) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Function TTSTOWorkSpaceProjectSrcFiles.Remove(Const Item : ITSTOWorkSpaceProjectSrcFile) : Integer;
Var X : Integer;
Begin
  For X := Count - 1 DownTo 0 Do
    If SameText(Get(X).FileName, Item.FileName) Then
    Begin
      Result := X;
      Delete(X);
      Break;
    End;
End;

Procedure TTSTOWorkSpaceProjectSrcFolder.AfterConstruction();
Begin
  InHerited AfterConstruction();

  FSrcFiles := GetSrcFilesClass().Create();
End;

Procedure TTSTOWorkSpaceProjectSrcFolder.BeforeDestruction();
Begin
  FSrcFiles := Nil;

  InHerited BeforeDestruction();
End;

Function TTSTOWorkSpaceProjectSrcFolder.GetSrcFilesClass() : TTSTOWorkSpaceProjectSrcFilesClass;
Begin
  Result := TTSTOWorkSpaceProjectSrcFiles;
End;

Function TTSTOWorkSpaceProjectSrcFolder.Add(Const AItem : ITSTOWorkSpaceProjectSrcFile) : Integer;
Begin
  Result := FSrcFiles.Add(AItem);
End;

Function TTSTOWorkSpaceProjectSrcFolder.Add() : ITSTOWorkSpaceProjectSrcFile;
Begin
  Result := FSrcFiles.Add();
End;

Procedure TTSTOWorkSpaceProjectSrcFolder.Add(Const AFileName : AnsiString);
Begin
  FSrcFiles.Add().FileName := AFileName;
End;

Procedure TTSTOWorkSpaceProjectSrcFolder.Clear();
Begin
  FSrcPath  := '';
  FSrcFiles := TTSTOWorkSpaceProjectSrcFiles.Create();
End;

Procedure TTSTOWorkSpaceProjectSrcFolder.Assign(ASource : IInterface);
Var lSrc : ITSTOWorkSpaceProjectSrcFolder;
    X    : Integer;
Begin
  If Supports(ASource, ITSTOWorkSpaceProjectSrcFolder, lSrc) Then
  Begin
    FSrcPath  := lSrc.SrcPath;

    FSrcFiles.Clear();
    For X := 0 To lSrc.SrcFileCount - 1 Do
      FSrcFiles.Add(lSrc.SrcFiles[X]);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TTSTOWorkSpaceProjectSrcFolder.GetSrcPath() : AnsiString;
Begin
  Result := FSrcPath;
End;

Procedure TTSTOWorkSpaceProjectSrcFolder.SetSrcPath(Const ASrcPath : AnsiString);
Begin
  FSrcPath := ASrcPath;
End;

Function TTSTOWorkSpaceProjectSrcFolder.GetSrcFileCount() : Integer;
Begin
  Result := FSrcFiles.Count;
End;

Function TTSTOWorkSpaceProjectSrcFolder.GetFileList() : ITSTOWorkSpaceProjectSrcFiles;
Begin
  Result := FSrcFiles;
End;

Function TTSTOWorkSpaceProjectSrcFolder.GetSrcFiles(Index : Integer) : ITSTOWorkSpaceProjectSrcFile;
Begin
  Result := FSrcFiles[Index];
End;

Procedure TTSTOWorkSpaceProjectSrcFolders.Assign(ASource : IInterface);
Var lSrc : ITSTOWorkSpaceProjectSrcFolders;
    X    : Integer;
Begin
  If Supports(ASource, ITSTOWorkSpaceProjectSrcFolders, lSrc) Then
  Begin
    Clear();
    For X := 0 To lSrc.Count - 1 Do
      Add().Assign(lSrc[X]);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TTSTOWorkSpaceProjectSrcFolders.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TTSTOWorkSpaceProjectSrcFolder;
End;

Function TTSTOWorkSpaceProjectSrcFolders.Get(Index : Integer) : ITSTOWorkSpaceProjectSrcFolder;
Begin
  Result := InHerited Items[Index] As ITSTOWorkSpaceProjectSrcFolder;
End;

Procedure TTSTOWorkSpaceProjectSrcFolders.Put(Index : Integer; Const Item : ITSTOWorkSpaceProjectSrcFolder);
Begin
  InHerited Items[Index] := Item;
End;

Function TTSTOWorkSpaceProjectSrcFolders.Add() : ITSTOWorkSpaceProjectSrcFolder;
Begin
  Result := InHerited Add() As ITSTOWorkSpaceProjectSrcFolder;
End;

Function TTSTOWorkSpaceProjectSrcFolders.Add(Const AItem : ITSTOWorkSpaceProjectSrcFolder) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Function TTSTOWorkSpaceProjectSrcFolders.Remove(Const Item : ITSTOWorkSpaceProjectSrcFile) : Integer;
Begin
  Result := InHerited Remove(Item As IInterfaceEx);
End;

Procedure TTSTOWorkSpaceProject.AfterConstruction();
Begin
  InHerited AfterConstruction();

  Clear();
  FSrcFolders  := GetWorkSpaceProjectSrcFoldersClass().Create();
End;

Procedure TTSTOWorkSpaceProject.BeforeDestruction();
Begin
  FSrcFolders := Nil;

  InHerited BeforeDestruction();
End;

Function TTSTOWorkSpaceProject.GetWorkSpaceProjectSrcFoldersClass() : TTSTOWorkSpaceProjectSrcFoldersClass;
Begin
  Result := TTSTOWorkSpaceProjectSrcFolders;
End;

Procedure TTSTOWorkSpaceProject.Clear();
Begin
  FProjectName := '';
  FProjectKind := spkRoot;
  FZeroCrc32   := 0;
End;

Procedure TTSTOWorkSpaceProject.Assign(ASource : IInterface);
Var lSrc : ITSTOWorkSpaceProject;
Begin
  If Supports(ASource, ITSTOWorkSpaceProject, lSrc) Then
  Begin
    FProjectName      := lSrc.ProjectName;
    FProjectKind      := lSrc.ProjectKind;
    FProjectType      := lSrc.ProjectType;
    FZeroCrc32        := lSrc.ZeroCrc32;
    FPackOutput       := lSrc.PackOutput;
    FOutputPath       := lSrc.OutputPath;
    FCustomScriptPath := lSrc.CustomScriptPath;
    FCustomModPath    := lSrc.CustomModPath;

    FSrcFolders.Assign(lSrc.SrcFolders);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TTSTOWorkSpaceProject.GetProjectName() : AnsiString;
Begin
  Result := FProjectName;
End;

Procedure TTSTOWorkSpaceProject.SetProjectName(Const AProjectName : AnsiString);
Begin
  FProjectName := AProjectName;
End;

Function TTSTOWorkSpaceProject.GetProjectKind() : TWorkSpaceProjectKind;
Begin
  Result := FProjectKind;
End;

Procedure TTSTOWorkSpaceProject.SetProjectKind(Const AProjectKind : TWorkSpaceProjectKind);
Begin
  FProjectKind := AProjectKind;
End;

Function TTSTOWorkSpaceProject.GetProjectType() : TWorkSpaceProjectType;
Begin
  Result := FProjectType;
End;

Procedure TTSTOWorkSpaceProject.SetProjectType(Const AProjectType : TWorkSpaceProjectType);
Begin
  FProjectType := AProjectType;
End;

Function TTSTOWorkSpaceProject.GetZeroCrc32() : DWord;
Begin
  Result := FZeroCrc32;
End;

Procedure TTSTOWorkSpaceProject.SetZeroCrc32(Const AZeroCrc32 : DWord);
Begin
  FZeroCrc32 := AZeroCrc32;
End;

Function TTSTOWorkSpaceProject.GetPackOutput() : Boolean;
Begin
  Result := FPackOutput;
End;

Procedure TTSTOWorkSpaceProject.SetPackOutput(Const APackOutput : Boolean);
Begin
  FPackOutput := APackOutput;
End;

Function TTSTOWorkSpaceProject.GetOutputPath() : AnsiString;
Begin
  Result := FOutputPath;
End;

Procedure TTSTOWorkSpaceProject.SetOutputPath(Const AOutputPath : AnsiString);
Begin
  FOutputPath := AOutputPath;
End;

Function TTSTOWorkSpaceProject.GetCustomScriptPath() : AnsiString;
Begin
  If FCustomScriptPath <> '' Then
    Result := IncludeTrailingBackSlash(FCustomScriptPath)
  Else
    Result := '';
End;

Procedure TTSTOWorkSpaceProject.SetCustomScriptPath(Const ACustomScriptPath : AnsiString);
Begin
  If ACustomScriptPath <> '' Then
    FCustomScriptPath := IncludeTrailingBackSlash(ACustomScriptPath)
  Else
    FCustomScriptPath := '';
End;

Function TTSTOWorkSpaceProject.GetCustomModPath() : AnsiString;
Begin
  If FCustomModPath <> '' Then
    Result := IncludeTrailingBackSlash(FCustomModPath)
  Else
    Result := '';
End;

Procedure TTSTOWorkSpaceProject.SetCustomModPath(Const ACustomModPath : AnsiString);
Begin
  If ACustomModPath <> '' Then
    FCustomModPath := IncludeTrailingBackSlash(ACustomModPath)
  Else
    FCustomModPath := '';
End;

Function TTSTOWorkSpaceProject.GetSrcFolders() : ITSTOWorkSpaceProjectSrcFolders;
Begin
  Result := FSrcFolders;
End;

Procedure TTSTOWorkSpaceProjectGroup.Assign(ASource : IInterface);
Var lSrc : ITSTOWorkSpaceProjectGroup;
    X : Integer;
Begin
  If Supports(ASource, ITSTOWorkSpaceProjectGroup, lSrc) Then
  Begin
    Clear();
    FProjectGroupName := lSrc.ProjectGroupName;
    FHackFileName     := lSrc.HackFileName;
    FPackOutput       := lSrc.PackOutput;
    FOutputPath       := lSrc.OutputPath;

    For X := 0 To lSrc.Count - 1 Do
      Add().Assign(lSrc[X]);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TTSTOWorkSpaceProjectGroup.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TTSTOWorkSpaceProject;
End;

Function TTSTOWorkSpaceProjectGroup.Get(Index : Integer) : ITSTOWorkSpaceProject;
Begin
  Result := InHerited Items[Index] As ITSTOWorkSpaceProject;
End;

Procedure TTSTOWorkSpaceProjectGroup.Put(Index : Integer; Const Item : ITSTOWorkSpaceProject);
Begin
  InHerited Items[Index] := Item;
End;

Procedure TTSTOWorkSpaceProjectGroup.Clear();
Begin
  InHerited Clear();

  FProjectGroupName := '';
End;

Function TTSTOWorkSpaceProjectGroup.GetProjectGroupName() : AnsiString;
Begin
  Result := FProjectGroupName;
End;

Procedure TTSTOWorkSpaceProjectGroup.SetProjectGroupName(Const AProjectGroupName : AnsiString);
Begin
  FProjectGroupName := AProjectGroupName;
End;

Function TTSTOWorkSpaceProjectGroup.GetHackFileName() : AnsiString;
Begin
  Result := FHackFileName;
End;

Procedure TTSTOWorkSpaceProjectGroup.SetHackFileName(Const AHackFileName : AnsiString);
Begin
  FHackFileName := AHackFileName;
End;

Function TTSTOWorkSpaceProjectGroup.GetPackOutput() : Boolean;
Begin
  Result := FPackOutput;
End;

Procedure TTSTOWorkSpaceProjectGroup.SetPackOutput(Const APackOutput : Boolean);
Begin
  FPackOutput := APackOutput;
End;

Function TTSTOWorkSpaceProjectGroup.GetOutputPath() : AnsiString;
Begin
  Result := FOutputPath;
End;

Procedure TTSTOWorkSpaceProjectGroup.SetOutputPath(Const AOutputPath : AnsiString);
Begin
  FOutputPath := AOutputPath;
End;

Function TTSTOWorkSpaceProjectGroup.Add() : ITSTOWorkSpaceProject;
Begin
  Result := InHerited Add() As ITSTOWorkSpaceProject;
End;

Function TTSTOWorkSpaceProjectGroup.Add(Const AItem : ITSTOWorkSpaceProject) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Function TTSTOWorkSpaceProjectGroup.Remove(Const Item : ITSTOWorkSpaceProject) : Integer;
Begin
  Result := InHerited Remove(Item As IInterfaceEx);
End;

End.
