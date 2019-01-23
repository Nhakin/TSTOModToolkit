unit TSTORessource;

interface

Uses Windows, Classes, SysUtils, RTLConsts, HsInterfaceEx, HsStreamEx;

Type
  ITSTOResourceFile = Interface;

  ITSTOResourceDuplicate = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-9329-46F0E0B05435}']
    Function  GetResourcePath() : String;
    Procedure SetResourcePath(Const AResourcePath : String);

    Function  GetResourceFile() : ITSTOResourceFile;

    Property ResourcePath : String             Read GetResourcePath  Write SetResourcePath;
    Property ResourceFile : ITSTOResourceFile Read GetResourceFile;

  End;

  ITSTOResourceDuplicates = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-9E05-19675CBA0346}']
    Function  Get(Index : Integer) : ITSTOResourceDuplicate;
    Procedure Put(Index : Integer; Const Item : ITSTOResourceDuplicate);

    Function Add() : ITSTOResourceDuplicate; OverLoad;
    Function Add(Const AItem : ITSTOResourceDuplicate) : Integer; OverLoad;

    Property Items[Index : Integer] : ITSTOResourceDuplicate Read Get Write Put; Default;

  End;

  ITSTOResourceDuplicateList = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-B2FB-03A2DD813FAA}']
    Function  GetCrc32() : DWord;
    Procedure SetCrc32(Const ACrc32 : DWord);

    Function  GetDuplicates() : ITSTOResourceDuplicates;

    Property Crc32      : DWord                    Read GetCrc32      Write SetCrc32;
    Property Duplicates : ITSTOResourceDuplicates Read GetDuplicates;

  End;

  ITSTOResourceDuplicateLists = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-8621-5961C682F631}']
    Function  Get(Index : Integer) : ITSTOResourceDuplicateList;
    Procedure Put(Index : Integer; Const Item : ITSTOResourceDuplicateList);

    Function Add() : ITSTOResourceDuplicateList; OverLoad;
    Function Add(Const AItem : ITSTOResourceDuplicateList) : Integer; OverLoad;

    Property Items[Index : Integer] : ITSTOResourceDuplicateList Read Get Write Put; Default;

  End;

  ITSTOResourceFile = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-AF3A-F1CA38D49A65}']
    Function  GetFileName() : String;
    Procedure SetFileName(Const AFileName : String);

    Function  GetWidth() : Word;
    Procedure SetWidth(Const AWidth : Word);

    Function  GetHeight() : Word;
    Procedure SetHeight(Const AHeight : Word);

    Function  GetCrc32() : DWord;
    Procedure SetCrc32(Const ACrc32 : DWord);

    Procedure LoadFromStream(AStream : IStreamEx);
    Procedure SaveToStream(AStream : IStreamEx);

    Property FileName : String Read GetFileName Write SetFileName;
    Property Width    : Word   Read GetWidth    Write SetWidth;
    Property Height   : Word   Read GetHeight   Write SetHeight;
    Property Crc32    : DWord  Read GetCrc32    Write SetCrc32;

  End;

  ITSTOResourceFiles = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-8C76-EF30370ED011}']
    Function  Get(Index : Integer) : ITSTOResourceFile;
    Procedure Put(Index : Integer; Const Item : ITSTOResourceFile);

    Function Add() : ITSTOResourceFile; OverLoad;
    Function Add(Const AItem : ITSTOResourceFile) : Integer; OverLoad;

    Function FileByName(Const AFileName : String) : ITSTOResourceFile;

    Property Items[Index : Integer] : ITSTOResourceFile Read Get Write Put; Default;

  End;

  ITSTOResourcePath = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-A9E6-3DD04FBEB6B2}']
    Function  GetResourcePath() : String;
    Procedure SetResourcePath(Const AResourcePath : String);

    Function  GetResourceFiles() : ITSTOResourceFiles;

    Property ResourcePath  : String              Read GetResourcePath  Write SetResourcePath;
    Property ResourceFiles : ITSTOResourceFiles Read GetResourceFiles;

  End;

  ITSTOResourcePaths = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-B821-0660500DDCD2}']
    Function  Get(Index : Integer) : ITSTOResourcePath;
    Procedure Put(Index : Integer; Const Item : ITSTOResourcePath);

    Function Add() : ITSTOResourcePath; OverLoad;
    Function Add(Const AItem : ITSTOResourcePath) : Integer; OverLoad;

    Function  FindDuplicateFiles() : ITSTOResourceDuplicateLists;
    Procedure ListResource(Const AResourcePath : String);
    Procedure LoadFromFile(Const AFileName : String);
    Procedure SaveToFile(Const AFileName : String);

    Function PathByName(Const APathName : String) : ITSTOResourcePath;

    Property Items[Index : Integer] : ITSTOResourcePath Read Get Write Put; Default;

  End;

  TTSTOResourcePaths = Class(TObject)
  Public
    Class Function CreateResourcePaths() : ITSTOResourcePaths; OverLoad;
    Class Function CreateResourcePaths(Const AFileName : String) : ITSTOResourcePaths; OverLoad;

  End;

implementation

Uses Forms, Dialogs, RgbExtractProgress,
  HsCheckSumEx, Imaging, ImagingTypes;

Type
  TTSTOResourceFileList = Class(TInterfacedObjectEx, ITSTOResourceDuplicate)
  Private
    FResourcePath : String;
    FResourceFile : ITSTOResourceFile;

  Protected
    Procedure Created(); OverRide;

    Function  GetResourcePath() : String;
    Procedure SetResourcePath(Const AResourcePath : String);

    Function  GetResourceFile() : ITSTOResourceFile;

  Public
    Destructor Destroy(); OverRide;

  End;

  TTSTOResourceFileLists = Class(TInterfaceListEx, ITSTOResourceDuplicates)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : ITSTOResourceDuplicate; OverLoad;
    Procedure Put(Index : Integer; Const Item : ITSTOResourceDuplicate); OverLoad;

    Function Add() : ITSTOResourceDuplicate; ReIntroduce; OverLoad;
    Function Add(Const AItem : ITSTOResourceDuplicate) : Integer; ReIntroduce; OverLoad;

  End;

  TTSTOResourceDuplicateList = Class(TInterfacedObjectEx, ITSTOResourceDuplicateList)
  Private
    FCrc32      : DWord;
    FDuplicates : ITSTOResourceDuplicates;

  Protected
    Procedure Created(); OverRide;

    Function  GetCrc32() : DWord;
    Procedure SetCrc32(Const ACrc32 : DWord);

    Function  GetDuplicates() : ITSTOResourceDuplicates;

  Public
    Destructor Destroy(); OverRide;

  End;

  TTSTOResourceDuplicateLists = Class(TInterfaceListEx, ITSTOResourceDuplicateLists)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : ITSTOResourceDuplicateList; OverLoad;
    Procedure Put(Index : Integer; Const Item : ITSTOResourceDuplicateList); OverLoad;

    Function Add() : ITSTOResourceDuplicateList; ReIntroduce; OverLoad;
    Function Add(Const AItem : ITSTOResourceDuplicateList) : Integer; ReIntroduce; OverLoad;

  End;
  
  TTSTOResourceFile = Class(TInterfacedObjectEx, ITSTOResourceFile)
  Private
    FFileName : String;
    FWidth    : Word;
    FHeight   : Word;
    FCrc32    : DWord;

  Protected
    Function  GetFileName() : String; 
    Procedure SetFileName(Const AFileName : String); 

    Function  GetWidth() : Word; 
    Procedure SetWidth(Const AWidth : Word); 

    Function  GetHeight() : Word; 
    Procedure SetHeight(Const AHeight : Word); 

    Function  GetCrc32() : DWord; 
    Procedure SetCrc32(Const ACrc32 : DWord); 

    Procedure LoadFromStream(AStream : IStreamEx);
    Procedure SaveToStream(AStream : IStreamEx);
    
  End;

  TTSTOResourceFiles = Class(TInterfaceListEx, ITSTOResourceFiles)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : ITSTOResourceFile; OverLoad;
    Procedure Put(Index : Integer; Const Item : ITSTOResourceFile); OverLoad;

    Function Add() : ITSTOResourceFile; ReIntroduce; OverLoad;
    Function Add(Const AItem : ITSTOResourceFile) : Integer; ReIntroduce; OverLoad;

    Function FileByName(Const AFileName : String) : ITSTOResourceFile;

  End;

  TTSTOResourcePath = Class(TInterfacedObjectEx, ITSTOResourcePath)
  Private
    FResourcePath  : String;
    FResourceFiles : ITSTOResourceFiles;

  Protected
    Procedure Created(); OverRide;

    Function  GetResourcePath() : String;
    Procedure SetResourcePath(Const AResourcePath : String);

    Function  GetFileCount() : Integer;

    Function  GetResourceFiles() : ITSTOResourceFiles;

  Public
    Destructor Destroy(); OverRide;

  End;

  TTSTOResourcePathsImpl = Class(TInterfaceListEx, ITSTOResourcePaths)
  Private
    FBasePath : String;
    Function IndexOfPath(Const APath : String) : Integer;

  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : ITSTOResourcePath; OverLoad;
    Procedure Put(Index : Integer; Const Item : ITSTOResourcePath); OverLoad;

    Function Add() : ITSTOResourcePath; ReIntroduce; OverLoad;
    Function Add(Const AItem : ITSTOResourcePath) : Integer; ReIntroduce; OverLoad;

    Function  FindDuplicateFiles() : ITSTOResourceDuplicateLists;
    Procedure ListResource(Const AResourcePath : String);
    Function  PathByName(Const APathName : String) : ITSTOResourcePath;
    Procedure LoadFromFile(Const AFileName : String);
    Procedure SaveToFile(Const AFileName : String);

  End;

Class Function TTSTOResourcePaths.CreateResourcePaths() : ITSTOResourcePaths;
Begin
  Result := TTSTOResourcePathsImpl.Create();
End;

Class Function TTSTOResourcePaths.CreateResourcePaths(Const AFileName : String) : ITSTOResourcePaths;
Begin
  Result := CreateResourcePaths();
  Result.LoadFromFile(AFileName);
End;

(******************************************************************************)

Procedure TTSTOResourceDuplicateList.Created();
Begin
  InHerited Created();

  FDuplicates := TTSTOResourceFileLists.Create();
End;

Destructor TTSTOResourceDuplicateList.Destroy();
Begin
  FDuplicates := Nil;

  InHerited Destroy();
End;

Function TTSTOResourceDuplicateList.GetCrc32() : DWord;
Begin
  Result := FCrc32;
End;

Procedure TTSTOResourceDuplicateList.SetCrc32(Const ACrc32 : DWord);
Begin
  FCrc32 := ACrc32;
End;

Function TTSTOResourceDuplicateList.GetDuplicates() : ITSTOResourceDuplicates;
Begin
  Result := FDuplicates;
End;

Function TTSTOResourceDuplicateLists.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TTSTOResourceDuplicateList;
End;

Function TTSTOResourceDuplicateLists.Get(Index : Integer) : ITSTOResourceDuplicateList;
Begin
  Result := InHerited Items[Index] As ITSTOResourceDuplicateList;
End;

Procedure TTSTOResourceDuplicateLists.Put(Index : Integer; Const Item : ITSTOResourceDuplicateList);
Begin
  InHerited Items[Index] := Item;
End;

Function TTSTOResourceDuplicateLists.Add() : ITSTOResourceDuplicateList;
Begin
  Result := InHerited Add() As ITSTOResourceDuplicateList;
End;

Function TTSTOResourceDuplicateLists.Add(Const AItem : ITSTOResourceDuplicateList) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Function TTSTOResourceFile.GetFileName() : String;
Begin
  Result := FFileName;
End;

Procedure TTSTOResourceFile.SetFileName(Const AFileName : String);
Begin
  FFileName := AFileName;
End;

Function TTSTOResourceFile.GetWidth() : Word;
Begin
  Result := FWidth;
End;

Procedure TTSTOResourceFile.SetWidth(Const AWidth : Word);
Begin
  FWidth := AWidth;
End;

Function TTSTOResourceFile.GetHeight() : Word;
Begin
  Result := FHeight;
End;

Procedure TTSTOResourceFile.SetHeight(Const AHeight : Word);
Begin
  FHeight := AHeight;
End;

Function TTSTOResourceFile.GetCrc32() : DWord;
Begin
  Result := FCrc32;
End;

Procedure TTSTOResourceFile.SetCrc32(Const ACrc32 : DWord);
Begin
  FCrc32 := ACrc32;
End;

Procedure TTSTOResourceFile.LoadFromStream(AStream : IStreamEx);
Begin
  FFileName := AStream.ReadAnsiString();
  FWidth    := AStream.ReadWord();
  FHeight   := AStream.ReadWord();
  FCrc32    := AStream.ReadDWord();
End;

Procedure TTSTOResourceFile.SaveToStream(AStream : IStreamEx);
Begin
  AStream.WriteAnsiString(FFileName);
  AStream.WriteWord(FWidth);
  AStream.WriteWord(FHeight);
  AStream.WriteDWord(FCrc32);
End;

Function TTSTOResourceFiles.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TTSTOResourceFile;
End;

Function TTSTOResourceFiles.Get(Index : Integer) : ITSTOResourceFile;
Begin
  Result := InHerited Items[Index] As ITSTOResourceFile;
End;

Procedure TTSTOResourceFiles.Put(Index : Integer; Const Item : ITSTOResourceFile);
Begin
  InHerited Items[Index] := Item;
End;

Function TTSTOResourceFiles.Add() : ITSTOResourceFile;
Begin
  Result := InHerited Add() As ITSTOResourceFile;
End;

Function TTSTOResourceFiles.Add(Const AItem : ITSTOResourceFile) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Function TTSTOResourceFiles.FileByName(Const AFileName : String) : ITSTOResourceFile;
Var X : Integer;
Begin
  Result := Nil;
  
  For X := 0 To Count - 1 Do
    If SameText(Get(X).FileName, AFileName) Then
    Begin
      Result := Get(X);
      Break;
    End;
End;

Procedure TTSTOResourcePath.Created();
Begin
  InHerited Created();

  FResourceFiles := TTSTOResourceFiles.Create();
End;

Destructor TTSTOResourcePath.Destroy();
Begin
  FResourceFiles := Nil;

  InHerited Destroy();
End;

Function TTSTOResourcePath.GetResourcePath() : String;
Begin
  Result := FResourcePath;
End;

Procedure TTSTOResourcePath.SetResourcePath(Const AResourcePath : String);
Begin
  FResourcePath := AResourcePath;
End;

Function TTSTOResourcePath.GetFileCount() : Integer;
Begin
  Result := FResourceFiles.Count;
End;

Function TTSTOResourcePath.GetResourceFiles() : ITSTOResourceFiles;
Begin
  Result := FResourceFiles;
End;

Function TTSTOResourcePathsImpl.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TTSTOResourcePath;
End;

Function TTSTOResourcePathsImpl.Get(Index : Integer) : ITSTOResourcePath;
Begin
  Result := InHerited Items[Index] As ITSTOResourcePath;
End;

Procedure TTSTOResourcePathsImpl.Put(Index : Integer; Const Item : ITSTOResourcePath);
Begin
  InHerited Items[Index] := Item;
End;

Function TTSTOResourcePathsImpl.Add() : ITSTOResourcePath;
Begin
  Result := InHerited Add() As ITSTOResourcePath;
End;

Function TTSTOResourcePathsImpl.Add(Const AItem : ITSTOResourcePath) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Function TTSTOResourcePathsImpl.IndexOfPath(Const APath : String) : Integer;
Var X : Integer;
Begin
  Result := -1;

  For X := 0 To Count - 1 Do
    If SameText(Get(X).ResourcePath, APath) Then
    Begin
      Result := X;
      Break;
    End;
End;

Procedure TTSTOResourcePathsImpl.LoadFromFile(Const AFileName : String);
Var lMemStrm : IMemoryStreamEx;
    X, Y     : Integer;
    lPath    : ITSTOResourcePath;
    lPathIdx : Integer;
    lPathStr : String;
Begin
  If FileExists(AFileName) Then
  Begin
    Clear();

    lMemStrm := TMemoryStreamEx.Create();
    Try
      lMemStrm.LoadFromFile(AFileName);

      X := lMemStrm.ReadWord();
      While X > 0 Do
      Begin
        lPathStr := lMemStrm.ReadAnsiString();
        lPathIdx := IndexOfPath(lPathStr);

        If lPathIdx = -1 Then
        Begin
          lPath := Add();
          lPath.ResourcePath := lPathStr;
        End
        Else
          lPath := Get(lPathIdx);

        Y := lMemStrm.ReadWord();
        While Y > 0 Do
        Begin
          lPath.ResourceFiles.Add().LoadFromStream(lMemStrm);
          Dec(Y);
        End;

        Dec(X);
      End;

      Finally
        lMemStrm := Nil;
    End;
  End;
End;

Procedure TTSTOResourcePathsImpl.SaveToFile(Const AFileName : String);
Var lCurPath : ITSTOResourcePath;
    lMemStrm : IMemoryStreamEx;
    X, Y     : Integer;
Begin
  lMemStrm := TMemoryStreamEx.Create();
  Try
    lMemStrm.WriteWord(Count);

    For X := 0 To Count - 1 Do
    Begin
      lCurPath := Get(X);
      lMemStrm.WriteAnsiString(lCurPath.ResourcePath);
      lMemStrm.WriteWord(lCurPath.ResourceFiles.Count);

      For Y := 0 To lCurPath.ResourceFiles.Count - 1 Do
        lCurPath.ResourceFiles[Y].SaveToStream(lMemStrm);
    End;

    lMemStrm.SaveToFile(AFileName);

    Finally
      lMemStrm := Nil;
  End;
End;

Procedure TTSTOResourceFileList.Created(); 
Begin
  FResourceFile := TTSTOResourceFile.Create();
End;

Destructor TTSTOResourceFileList.Destroy();
Begin
  FResourceFile := Nil;

  InHerited Destroy();
End;

Function TTSTOResourceFileList.GetResourcePath() : String;
Begin
  Result := FResourcePath;
End;

Procedure TTSTOResourceFileList.SetResourcePath(Const AResourcePath : String);
Begin
  FResourcePath := AResourcePath;
End;

Function TTSTOResourceFileList.GetResourceFile() : ITSTOResourceFile;
Begin
  Result := FResourceFile;
End;

Function TTSTOResourceFileLists.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TTSTOResourceFileList;
End;

Function TTSTOResourceFileLists.Get(Index : Integer) : ITSTOResourceDuplicate;
Begin
  Result := InHerited Items[Index] As ITSTOResourceDuplicate;
End;

Procedure TTSTOResourceFileLists.Put(Index : Integer; Const Item : ITSTOResourceDuplicate);
Begin
  InHerited Items[Index] := Item;
End;

Function TTSTOResourceFileLists.Add() : ITSTOResourceDuplicate;
Begin
  Result := InHerited Add() As ITSTOResourceDuplicate;
End;

Function TTSTOResourceFileLists.Add(Const AItem : ITSTOResourceDuplicate) : Integer;
Begin
  Result := InHerited Add(AItem);
End;
    
Function TTSTOResourcePathsImpl.FindDuplicateFiles() : ITSTOResourceDuplicateLists;
  Function GetFileList() : ITSTOResourceDuplicates;
  Var X, Y  : Integer;
      lPath : ITSTOResourcePath;
  Begin
    Result := TTSTOResourceFileLists.Create();

    For X := 0 To Count - 1 Do
    Begin
      lPath := Get(X);

      For Y := 0 To lPath.ResourceFiles.Count - 1 Do
        With Result.Add() Do
        Begin
          ResourcePath := lPath.ResourcePath;

          ResourceFile.FileName := lPath.ResourceFiles[Y].FileName;
          ResourceFile.Crc32    := lPath.ResourceFiles[Y].Crc32;
          ResourceFile.Width    := lPath.ResourceFiles[Y].Width;
          ResourceFile.Height   := lPath.ResourceFiles[Y].Height;
        End;
    End;
  End;

  Procedure AddToResult(AResourceFile1, AResourceFile2 : ITSTOResourceDuplicate);
  Var X : Integer;
      lCurDup : ITSTOResourceDuplicateList;
      lIdx : Integer;
  Begin
    lIdx := -1;
    For X := 0 To Result.Count - 1 Do
      If Result[X].Crc32 = AResourceFile1.ResourceFile.Crc32 Then
      Begin
        lIdx := X;
        Break;
      End;

    If lIdx > -1 Then
      lCurDup := Result[lIdx]
    Else
    Begin
      lCurDup := Result.Add();
      lCurDup.Crc32 := AResourceFile1.ResourceFile.Crc32;
    End;

    lIdx := -1;
    For X := 0 To lCurDup.Duplicates.Count - 1 Do
      If SameText(lCurDup.Duplicates[X].ResourcePath, AResourceFile1.ResourcePath) And
         SameText(lCurDup.Duplicates[X].ResourceFile.FileName, AResourceFile1.ResourceFile.FileName) Then
      Begin
        lIdx := X;
        Break;
      End;

    If lIdx = -1 Then
      lCurDup.Duplicates.Add(AResourceFile1);

    lIdx := -1;
    For X := 0 To lCurDup.Duplicates.Count - 1 Do
      If SameText(lCurDup.Duplicates[X].ResourcePath, AResourceFile2.ResourcePath) And
         SameText(lCurDup.Duplicates[X].ResourceFile.FileName, AResourceFile2.ResourceFile.FileName) Then
      Begin
        lIdx := X;
        Break;
      End;

    If lIdx = -1 Then
      lCurDup.Duplicates.Add(AResourceFile2);
  End;

Var lFileList : ITSTOResourceDuplicates;
    X, Y      : Integer;
    lProgress : IRgbProgress;
Begin
  lFileList := GetFileList();

  lProgress := TRgbProgress.CreateRgbProgress();
  Try
    lProgress.Show();
    Result := TTSTOResourceDuplicateLists.Create();
    For X := 0 To lFileList.Count - 1 Do
    Begin
      lProgress.CurOperation := IncludeTrailingBackslash(lFileList[X].ResourcePath) + lFileList[X].ResourceFile.FileName;
      lProgress.ItemProgress := Round(X / lFileList.Count * 100);

      For Y := X + 1 To lFileList.Count - 1 Do
      Begin
        lProgress.CurArchiveName  := IncludeTrailingBackslash(lFileList[Y].ResourcePath) +  lFileList[Y].ResourceFile.FileName;
        lProgress.ArchiveProgress := Round(Y / lFileList.Count * 100);

        If SameText(lFileList[X].ResourceFile.FileName, lFileList[Y].ResourceFile.FileName) And
           (lFileList[X].ResourceFile.Crc32 = lFileList[Y].ResourceFile.Crc32) And
           (lFileList[X].ResourceFile.Width = lFileList[Y].ResourceFile.Width) And
           (lFileList[X].ResourceFile.Height = lFileList[Y].ResourceFile.Height) Then
          AddToResult(lFileList[X], lFileList[Y]);
      End;
    End;

    Finally
      lProgress := Nil;
  End;

  With TStringList.Create() Do
  Try
    For X := 0 To Result.Count - 1 Do
    Begin
      Add('Crc 32 : 0x' + IntToHex(Result[X].Crc32, 8));
      For Y := 0 To Result[X].Duplicates.Count - 1 Do
        Add('  ' + Result[X].Duplicates[Y].ResourcePath + ' ' + Result[X].Duplicates[Y].ResourceFile.FileName);
    End;

    SaveToFile('00-DuplicateRes.txt');
    ShowMessage('Done');

    Finally
      Free();
  End;
End;

Procedure TTSTOResourcePathsImpl.ListResource(Const AResourcePath : String);
  Procedure InternalLoad(Const AStartPath : String);
  Var lSr : TSearchRec;
      lPath : ITSTOResourcePath;
      lStrPath : String;
      lPathIdx : Integer;
      lImg     : TImageData;
      lMemStrm : IMemoryStreamEx;
  Begin
    If FindFirst(IncludeTrailingBackslash(AStartPath) + '*.*', faAnyFile, lSr) = 0 Then
    Try
      Repeat
        If (lSr.Attr And faDirectory <> 0) Then
        Begin
          If (lSr.Name <> '.') And (lSr.Name <> '..') Then
            InternalLoad(IncludeTrailingBackslash(AStartPath) + lSr.Name);
        End
        Else If SameText(ExtractFileExt(lSr.Name), '.Rgb') Or
                SameText(ExtractFileExt(lSr.Name), '.Png') Then
        Begin
          lStrPath := StringReplace(AStartPath, FBasePath, '', [rfReplaceAll, rfIgnoreCase]);

          lPathIdx := IndexOfPath(lStrPath);
          If lPathIdx = - 1 Then
          Begin
            lPath := Add();
            lPath.ResourcePath := lStrPath;
          End
          Else
            lPath := Get(lPathIdx);

          With lPath.ResourceFiles.Add() Do
          Begin
            lMemStrm := TMemoryStreamEx.Create();
            lMemStrm.LoadFromFile(FBasePath + IncludeTrailingBackslash(lStrPath) + lSr.Name);
            Try
              FileName := lSr.Name;
              Crc32    := GetCrc32Value(TStream(lMemStrm.InterfaceObject));

              lMemStrm.Position := 0;
              LoadImageFromStream(TStream(lMemStrm.InterfaceObject), lImg);
              Try
                Width  := lImg.Width;
                Height := lImg.Height;

                Finally
                  FreeImage(lImg);
              End;

              Finally
                lMemStrm := Nil;
            End;
          End;
        End;

        Application.ProcessMessages();
      Until FindNext(lSr) <> 0

      Finally
        FindClose(lSr);
    End;
  End;

Begin
  FBasePath := IncludeTrailingBackslash(AResourcePath);
  InternalLoad(FBasePath);
End;

Function TTSTOResourcePathsImpl.PathByName(Const APathName : String) : ITSTOResourcePath;
Var X : Integer;
Begin
  Result := Nil;
  For X := 0 To Count - 1 Do
    If SameText(Get(X).ResourcePath, APathName) Then
    Begin
      Result := Get(X);
      Break;
    End;
End;

Initialization
  RegisterInterface('ITSTOResourceFile', ITSTOResourceFile);
  RegisterInterface('ITSTOResourceFiles', ITSTOResourceFiles);
  RegisterInterface('ITSTOResourcePath', ITSTOResourcePath);
  RegisterInterface('ITSTOResourcePaths', ITSTOResourcePaths);

end.
