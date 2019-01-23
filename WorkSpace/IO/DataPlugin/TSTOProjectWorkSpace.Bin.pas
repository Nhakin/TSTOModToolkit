unit TSTOProjectWorkSpace.Bin;

Interface

Uses Classes, SysUtils, RTLConsts,
  HsInterfaceEx, HsStreamEx,
  TSTOProjectWorkSpaceIntf;

Type
  IBinTSTOWorkSpaceProjectSrcFolder = Interface(ITSTOWorkSpaceProjectSrcFolder)
    ['{4B61686E-29A0-2112-AB5B-6ADB205EB15A}']
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

  End;

  IBinTSTOWorkSpaceProjectSrcFolders = Interface(ITSTOWorkSpaceProjectSrcFolders)
    ['{4B61686E-29A0-2112-9D6F-585DB1EF5131}']
    Function  Get(Index : Integer) : IBinTSTOWorkSpaceProjectSrcFolder;
    Procedure Put(Index : Integer; Const Item : IBinTSTOWorkSpaceProjectSrcFolder);

    Function Add() : IBinTSTOWorkSpaceProjectSrcFolder; OverLoad;
    Function Add(Const AItem : IBinTSTOWorkSpaceProjectSrcFolder) : Integer; OverLoad;

    Property Items[Index : Integer] : IBinTSTOWorkSpaceProjectSrcFolder Read Get Write Put; Default;

  End;

  IBinTSTOWorkSpaceProject = Interface(ITSTOWorkSpaceProject)
    ['{4B61686E-29A0-2112-99B3-8D5D7F97AEAB}']
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Function GetSrcFolders() : IBinTSTOWorkSpaceProjectSrcFolders;
    
    Property SrcFolders  : IBinTSTOWorkSpaceProjectSrcFolders Read GetSrcFolders;

  End;

  IBinTSTOWorkSpaceProjectGroup = Interface(ITSTOWorkSpaceProjectGroup)
    ['{4B61686E-29A0-2112-B1D0-7D60874C2F7A}']
    Function  Get(Index : Integer) : IBinTSTOWorkSpaceProject;
    Procedure Put(Index : Integer; Const Item : IBinTSTOWorkSpaceProject);

    Function Add() : IBinTSTOWorkSpaceProject; OverLoad;
    Function Add(Const AItem : IBinTSTOWorkSpaceProject) : Integer; OverLoad;

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Property Items[Index : Integer] : IBinTSTOWorkSpaceProject Read Get Write Put; Default;

  End;

  TBinTSTOWorkSpaceProjectGroup = Class(TObject)
  Public
    Class Function CreateWSProjectGroup() : IBinTSTOWorkSpaceProjectGroup;

  End;

Implementation

Uses
  TSTOProjectWorkSpaceImpl, TSTOProjectWorkSpace.Types;
  
Type
  TBinTSTOWorkSpaceProjectSrcFolder = Class(TTSTOWorkSpaceProjectSrcFolder, IBinTSTOWorkSpaceProjectSrcFolder)
  Private
    Procedure LoadFromStreamV001(ASource : IStreamEx);

  Protected
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

  End;

  TBinTSTOWorkSpaceProjectSrcFolders = Class(TTSTOWorkSpaceProjectSrcFolders, IBinTSTOWorkSpaceProjectSrcFolders)
  Protected
    Function  GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : IBinTSTOWorkSpaceProjectSrcFolder; OverLoad;
    Procedure Put(Index : Integer; Const Item : IBinTSTOWorkSpaceProjectSrcFolder); OverLoad;

    Function Add() : IBinTSTOWorkSpaceProjectSrcFolder; OverLoad;
    Function Add(Const AItem : IBinTSTOWorkSpaceProjectSrcFolder) : Integer; OverLoad;

  End;

  TBinTSTOWorkSpaceProject = Class(TTSTOWorkSpaceProject, IBinTSTOWorkSpaceProject)
  Private
    Procedure LoadFromStreamV001(ASource : IStreamEx);

  Protected
    Function GetWorkSpaceProjectSrcFoldersClass() : TTSTOWorkSpaceProjectSrcFoldersClass; OverRide;
    Function GetSrcFolders() : IBinTSTOWorkSpaceProjectSrcFolders; OverLoad;

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

  End;

  TBinTSTOWorkSpaceProjectGroupImpl = Class(TTSTOWorkSpaceProjectGroup, IBinTSTOWorkSpaceProjectGroup)
  Private
    Procedure LoadFromStreamV001(ASource : IStreamEx);
    Procedure LoadFromStreamV002(ASource : IStreamEx);

  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;

    Function  Get(Index : Integer) : IBinTSTOWorkSpaceProject; OverLoad;
    Procedure Put(Index : Integer; Const Item : IBinTSTOWorkSpaceProject); OverLoad;

    Function Add() : IBinTSTOWorkSpaceProject; OverLoad;
    Function Add(Const AItem : IBinTSTOWorkSpaceProject) : Integer; OverLoad;

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

  End;

Class Function TBinTSTOWorkSpaceProjectGroup.CreateWSProjectGroup() : IBinTSTOWorkSpaceProjectGroup;
Begin
  Result := TBinTSTOWorkSpaceProjectGroupImpl.Create();
End;

(******************************************************************************)
Procedure TBinTSTOWorkSpaceProjectSrcFolder.LoadFromStreamV001(ASource : IStreamEx);
Var lNbFile : Integer;
Begin
  SrcPath := ASource.ReadAnsiString();

  lNbFile := ASource.ReadWord();
  While lNbFile > 0 Do
  Begin
    Add(ASource.ReadAnsiString());
    Dec(lNbFile);
  End;
End;

Procedure TBinTSTOWorkSpaceProjectSrcFolder.LoadFromStream(ASource : IStreamEx);
Begin
  Case ASource.ReadByte() Of
    1 : LoadFromStreamV001(ASource);
    Else
      Raise Exception.Create('Invalid workspace file');
  End;
End;

Procedure TBinTSTOWorkSpaceProjectSrcFolder.SaveToStream(ATarget : IStreamEx);
Const
  cStreamVersion = 1;

Var X : Integer;
Begin
  ATarget.WriteByte(cStreamVersion);
  ATarget.WriteAnsiString(SrcPath);

  ATarget.WriteWord(SrcFileCount);
  For X := 0 To SrcFileCount - 1 Do
    ATarget.WriteAnsiString(SrcFiles[X].FileName);
End;

Function TBinTSTOWorkSpaceProjectSrcFolders.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TBinTSTOWorkSpaceProjectSrcFolder;
End;

Function TBinTSTOWorkSpaceProjectSrcFolders.Get(Index : Integer) : IBinTSTOWorkSpaceProjectSrcFolder;
Begin
  Result := InHerited Items[Index] As IBinTSTOWorkSpaceProjectSrcFolder;
End;

Procedure TBinTSTOWorkSpaceProjectSrcFolders.Put(Index : Integer; Const Item : IBinTSTOWorkSpaceProjectSrcFolder);
Begin
  InHerited Items[Index] := Item;
End;

Function TBinTSTOWorkSpaceProjectSrcFolders.Add() : IBinTSTOWorkSpaceProjectSrcFolder;
Begin
  Result := InHerited Add() As IBinTSTOWorkSpaceProjectSrcFolder;
End;

Function TBinTSTOWorkSpaceProjectSrcFolders.Add(Const AItem : IBinTSTOWorkSpaceProjectSrcFolder) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Function TBinTSTOWorkSpaceProject.GetWorkSpaceProjectSrcFoldersClass() : TTSTOWorkSpaceProjectSrcFoldersClass;
Begin
  Result := TBinTSTOWorkSpaceProjectSrcFolders;
End;

Function TBinTSTOWorkSpaceProject.GetSrcFolders() : IBinTSTOWorkSpaceProjectSrcFolders;
Begin
  Result := InHerited GetSrcFolders() As IBinTSTOWorkSpaceProjectSrcFolders;
End;

Procedure TBinTSTOWorkSpaceProject.LoadFromStreamV001(ASource : IStreamEx);
Var lNbPath : Byte;
    lSrcFolders : IBinTSTOWorkSpaceProjectSrcFolders;
Begin
  ProjectName := ASource.ReadAnsiString();
  ProjectKind := TWorkSpaceProjectKind(ASource.ReadByte());
  ProjectType := TWorkSpaceProjectType(ASource.ReadByte());
  ZeroCrc32   := ASource.ReadDWord();
  PackOutput  := ASource.ReadByte() <> 0;
  OutputPath  := ASource.ReadAnsiString();

  If ProjectType = sptScript Then
    CustomScriptPath := ASource.ReadAnsiString();

  lNbPath := ASource.ReadByte();
  lSrcFolders := GetSrcFolders();
  While lNbPath > 0 Do
  Begin
    lSrcFolders.Add().LoadFromStream(ASource);
    Dec(lNbPath);
  End;
End;

Procedure TBinTSTOWorkSpaceProject.LoadFromStream(ASource : IStreamEx);
Begin
  Case ASource.ReadByte() Of
    1 : LoadFromStreamV001(ASource);
    Else
      Raise Exception.Create('Invalid workspace file');
  End;
End;

Procedure TBinTSTOWorkSpaceProject.SaveToStream(ATarget : IStreamEx);
Const
  cStreamVersion = 1;

Var X : Integer;
    lSrcFolders : IBinTSTOWorkSpaceProjectSrcFolders;
Begin
  ATarget.WriteByte(cStreamVersion);
  ATarget.WriteAnsiString(ProjectName);
  ATarget.WriteByte(Ord(ProjectKind));
  ATarget.WriteByte(Ord(ProjectType));
  ATarget.WriteDWord(ZeroCrc32);
  If PackOutput Then
    ATarget.WriteByte(1)
  Else
    ATarget.WriteByte(0);
  ATarget.WriteAnsiString(OutputPath);

  If ProjectType = sptScript Then
    ATarget.WriteAnsiString(CustomScriptPath);

  lSrcFolders := GetSrcFolders();
  ATarget.WriteByte(lSrcFolders.Count);
  For X := 0 To lSrcFolders.Count - 1 Do
    lSrcFolders[X].SaveToStream(ATarget);
End;

Function TBinTSTOWorkSpaceProjectGroupImpl.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TBinTSTOWorkSpaceProject;
End;

Function TBinTSTOWorkSpaceProjectGroupImpl.Get(Index : Integer) : IBinTSTOWorkSpaceProject;
Begin
  Result := InHerited Items[Index] As IBinTSTOWorkSpaceProject;
End;

Procedure TBinTSTOWorkSpaceProjectGroupImpl.Put(Index : Integer; Const Item : IBinTSTOWorkSpaceProject);
Begin
  InHerited Items[Index] := Item;
End;

Function TBinTSTOWorkSpaceProjectGroupImpl.Add() : IBinTSTOWorkSpaceProject;
Begin
  Result := InHerited Add() As IBinTSTOWorkSpaceProject;
End;

Function TBinTSTOWorkSpaceProjectGroupImpl.Add(Const AItem : IBinTSTOWorkSpaceProject) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Procedure TBinTSTOWorkSpaceProjectGroupImpl.LoadFromStreamV001(ASource : IStreamEx);
Var lNbProject : Integer;
Begin
  ProjectGroupName := ASource.ReadAnsiString();
  PackOutput       := ASource.ReadBoolean();
  OutputPath       := ASource.ReadAnsiString();

  lNbProject := ASource.ReadByte();
  While lNbProject > 0 Do
  Begin
    Add().LoadFromStream(ASource);
    Dec(lNbProject);
  End;
End;

Procedure TBinTSTOWorkSpaceProjectGroupImpl.LoadFromStreamV002(ASource : IStreamEx);
Var lNbProject : Integer;
Begin
  ProjectGroupName := ASource.ReadAnsiString();
  HackFileName     := ASource.ReadAnsiString();
  PackOutput       := ASource.ReadBoolean();
  OutputPath       := ASource.ReadAnsiString();

  lNbProject := ASource.ReadByte();
  While lNbProject > 0 Do
  Begin
    Add().LoadFromStream(ASource);
    Dec(lNbProject);
  End;
End;

Procedure TBinTSTOWorkSpaceProjectGroupImpl.LoadFromStream(ASource : IStreamEx);
Begin
  Case ASource.ReadByte() Of
    1 : LoadFromStreamV001(ASource);
    2 : LoadFromStreamV002(ASource);
    Else
      Raise Exception.Create('Invalid workspace file');
  End;
End;

Procedure TBinTSTOWorkSpaceProjectGroupImpl.SaveToStream(ATarget : IStreamEx);
Const
  cStreamVersion = 2;

Var X : Integer;
Begin
  ATarget.WriteByte(cStreamVersion);
  ATarget.WriteAnsiString(ProjectGroupName);
  ATarget.WriteAnsiString(HackFileName);
  ATarget.WriteBoolean(PackOutput);
  ATarget.WriteAnsiString(OutputPath);

  ATarget.WriteByte(Count);
  For X := 0 To Count - 1 Do
    Get(X).SaveToStream(ATarget);
End;

(*
Procedure CreateWsProject(APath : String; AProject : ITSTOWorkSpaceProject);
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

Procedure CreateWsGroupProject(APath : String);
Var lSr : TSearchRec;
    lPgIO : ITSTOWorkSpaceProjectGroupIO;
    lProject : ITSTOWorkSpaceProject;
Begin
  lPgIO := TTSTOWorkSpaceProjectGroupIO.CreateProjectGroup();
  Try
    lPgIO.ProjectGroupName := ExtractFileName(ExcludeTrailingBackslash(APath));

    If FindFirst(APath + '*.*', faDirectory, lSr) = 0 Then
    Try
      Repeat
        If (lSr.Attr And faDirectory <> 0) And Not SameText(lSr.Name, '.') And Not SameText(lSr.Name, '..') Then
        Begin
          lProject := lPgIO.Add();
          lProject.ProjectName := lSr.Name;
          CreateWsProject(IncludeTrailingBackslash(APath) + lSr.Name + '\', lProject);
        End;
      Until FindNext(lSr) <> 0

      Finally
        FindClose(lSr);
    End;

    lPgIO.SaveToFile(APath + 'WWPromo.xml');
    lPgIO.SaveToFile(APath + 'WWPromo.bin');

    Finally
      lPgIO := Nil;
  End;
End;
*)

End.

