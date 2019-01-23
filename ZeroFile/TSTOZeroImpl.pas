unit TSTOZeroImpl;

interface

Uses Windows, HsInterfaceEx, TSTOZeroIntf;

Type
  TZeroFileHeaderClass = Class Of TZeroFileHeader;
  TZeroFileDatasClass = Class Of TZeroFileDatas;
  TArchivedFileDatasClass = Class Of TArchivedFileDatas;

  TArchivedFileData = Class(TInterfacedObjectEx, IArchivedFileData)
  Private
    FDataLength    : Word;
    FFileName1     : AnsiString;
    FFileExtension : AnsiString;
    FFileName2     : AnsiString;
    FFileSize      : DWord;
    FWord1         : Word;
    FArchiveFileId : Word;

  Protected
    Procedure Created(); OverRide;

    Function  GetDataLength() : Word;
    Procedure SetDataLength(Const ADataLength : Word);

    Function  GetFileName1() : AnsiString;
    Procedure SetFileName1(Const AFileName1 : AnsiString);

    Function  GetFileExtension() : AnsiString;
    Procedure SetFileExtension(Const AFileExtension : AnsiString);

    Function  GetFileName2() : AnsiString;
    Procedure SetFileName2(Const AFileName2 : AnsiString);

    Function  GetFileSize() : DWord;
    Procedure SetFileSize(Const AFileSize : DWord);

    Function  GetWord1() : Word;
    Procedure SetWord1(Const AWord1 : Word);

    Function  GetArchiveFileId() : Word;
    Procedure SetArchiveFileId(Const AArchiveFileId : Word);

  Public
    Property DataLength    : Word       Read GetDataLength    Write SetDataLength;
    Property FileName1     : AnsiString Read GetFileName1     Write SetFileName1;
    Property FileExtension : AnsiString Read GetFileExtension Write SetFileExtension;
    Property FileName2     : AnsiString Read GetFileName2     Write SetFileName2;
    Property FileSize      : DWord      Read GetFileSize      Write SetFileSize;
    Property Word1         : Word       Read GetWord1         Write SetWord1;
    Property ArchiveFileId : Word       Read GetArchiveFileId Write SetArchiveFileId;

    Procedure Assign(ASource : TObject); ReIntroduce; Virtual;
    Procedure Clear();

  End;

  TArchivedFileDatas = Class(TInterfaceListEx, IArchivedFileDatas)
  Private
    Function InternalSort(Item1, Item2 : IInterfaceEx) : Integer;

  Protected
    Function  GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : IArchivedFileData; OverLoad;
    Procedure Put(Index : Integer; Const Item : IArchivedFileData); OverLoad;

    Function Add() : IArchivedFileData; ReIntroduce; OverLoad;
    Function Add(Const AItem : IArchivedFileData) : Integer; OverLoad;
    Procedure Sort();

  End;

  TZeroFileData = Class(TInterfacedObjectEx, IZeroFileData)
  Private
    FDataLength : Word;
    FFileName   : AnsiString;
    FByte1      : Byte;
    FCrc32      : DWord;

    FArchivedFiles : IArchivedFileDatas;

  Protected
    Procedure Created(); OverRide;

    Function  GetArchivedFileDatasClass() : TArchivedFileDatasClass; Virtual;

    Function  GetDataLength() : Word;
    Procedure SetDataLength(Const ADataLength : Word);

    Function  GetFileName() : AnsiString;
    Procedure SetFileName(Const AFileName : AnsiString);

    Function  GetByte1() : Byte;
    Procedure SetByte1(Const AByte1 : Byte);

    Function  GetCrc32() : DWord;
    Procedure SetCrc32(Const ACrc32 : DWord);

    Function GetArchivedFiles() : IArchivedFileDatas;

  Public
    Property DataLength : Word       Read GetDataLength Write SetDataLength;
    Property FileName   : AnsiString Read GetFileName   Write SetFileName;
    Property Byte1      : Byte       Read GetByte1      Write SetByte1;
    Property Crc32      : DWord      Read GetCrc32      Write SetCrc32;

    Property ArchivedFiles : IArchivedFileDatas Read GetArchivedFiles;

    Procedure Assign(ASource : TObject); ReIntroduce; Virtual;
    Procedure Clear();

  End;

  TZeroFileDatas = Class(TInterfaceListEx, IZeroFileDatas)
  Protected
    Function  GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : IZeroFileData; OverLoad;
    Procedure Put(Index : Integer; Const Item : IZeroFileData); OverLoad;

    Function Add() : IZeroFileData; ReIntroduce; OverLoad;
    Function Add(Const AItem : IZeroFileData) : Integer; OverLoad;

  End;
    
  TZeroFileHeader = Class(TInterfacedObjectEx, IZeroFileHeader)
  Private
    FStr1         : AnsiString;
    FWord1        : Word;
    FZeroFileSize : DWord;
    FByte1        : Byte;
    FWord2        : Word;

  Protected
    Procedure Created(); OverRide;

    Function  GetStr1() : AnsiString;
    Procedure SetStr1(Const AStr1 : AnsiString);

    Function  GetWord1() : Word;
    Procedure SetWord1(Const AWord1 : Word);

    Function  GetZeroFileSize() : DWord;
    Procedure SetZeroFileSize(Const AZeroFileSize : DWord);

    Function  GetByte1() : Byte;
    Procedure SetByte1(Const AByte1 : Byte);

    Function  GetWord2() : Word;
    Procedure SetWord2(Const AWord2 : Word);

  Public
    Property Str1         : AnsiString Read GetStr1         Write SetStr1;
    Property Word1        : Word       Read GetWord1        Write SetWord1;
    Property ZeroFileSize : DWord      Read GetZeroFileSize Write SetZeroFileSize;
    Property Byte1        : Byte       Read GetByte1        Write SetByte1;
    Property Word2        : Word       Read GetWord2        Write SetWord2;

    Procedure Assign(ASource : TObject); ReIntroduce; Virtual;
    Procedure Clear();

  End;

  TZeroFile = Class(TInterfacedObjectEx, IZeroFile)
  Private
    FFileHeader       : IZeroFileHeader;
    FArchiveDirectory : AnsiString;
    FFileDatas        : IZeroFileDatas;
    FCrc32            : DWord;

  Protected
    Procedure Created(); OverRide;

    Function GetFileHeaderClass() : TZeroFileHeaderClass; Virtual;
    Function GetZeroFileDatasClass() : TZeroFileDatasClass; Virtual;

    Function  GetFileHeader() : IZeroFileHeader;
    Function  GetArchiveDirectory() : AnsiString;
    Procedure SetArchiveDirectory(Const AArchiveDirectory : AnsiString);

    Function  GetFileDatas() : IZeroFileDatas;
    Function  GetCrc32() : DWord;
    Procedure SetCrc32(Const ACrc32 : DWord);

  Public
    Property FileHeader       : IZeroFileHeader Read GetFileHeader;
    Property ArchiveDirectory : AnsiString      Read GetArchiveDirectory Write SetArchiveDirectory;
    Property FileDatas        : IZeroFileDatas  Read GetFileDatas;
    Property Crc32            : DWord           Read GetCrc32            Write SetCrc32;

    Procedure Assign(ASource : TObject); ReIntroduce; Virtual;
    Procedure Clear();

    Destructor  Destroy(); OverRide;

  End;

implementation

Uses SysUtils, RTLConsts;

Procedure TZeroFileData.Created();
Begin
  Clear();
End;

Function TZeroFileData.GetArchivedFileDatasClass() : TArchivedFileDatasClass;
Begin
  Result := TArchivedFileDatas;
End;

Procedure TZeroFileData.Clear();
Begin
  FDataLength := 0;
  FFileName   := '';
  FByte1      := 1;
  FCrc32      := 0;

  FArchivedFiles := GetArchivedFileDatasClass().Create();
End;

Procedure TZeroFileData.Assign(ASource : TObject);
Var lSrc : IZeroFileData;
Begin
{  If Supports(ASource, IArchiveFileData, lSrc) Then
  Begin
    FDataLength := lSrc.DataLength;
    FFileName   := lSrc.FileName;
    FByte1      := lSrc.Byte1;
    FCrc32      := lSrc.Crc32;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [ASource.ClassName, ClassName]);}
End;

Function TZeroFileData.GetDataLength() : Word;
Begin
  Result := FDataLength;
End;

Procedure TZeroFileData.SetDataLength(Const ADataLength : Word);
Begin
  FDataLength := ADataLength;
End;

Function TZeroFileData.GetFileName() : AnsiString;
Begin
  Result := FFileName;
End;

Procedure TZeroFileData.SetFileName(Const AFileName : AnsiString);
Begin
  FFileName := AFileName;
End;

Function TZeroFileData.GetByte1() : Byte;
Begin
  Result := FByte1;
End;

Procedure TZeroFileData.SetByte1(Const AByte1 : Byte);
Begin
  FByte1 := AByte1;
End;

Function TZeroFileData.GetCrc32() : DWord;
Begin
  Result := FCrc32;
End;

Procedure TZeroFileData.SetCrc32(Const ACrc32 : DWord);
Begin
  FCrc32 := ACrc32;
End;

Function TZeroFileData.GetArchivedFiles() : IArchivedFileDatas;
Begin
  Result := FArchivedFiles;
End;

Function TZeroFileDatas.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TZeroFileData;
End;

Function TZeroFileDatas.Get(Index : Integer) : IZeroFileData;
Begin
  Result := InHerited Items[Index] As IZeroFileData;
End;

Procedure TZeroFileDatas.Put(Index : Integer; Const Item : IZeroFileData);
Begin
  InHerited Items[Index] := Item;
End;

Function TZeroFileDatas.Add() : IZeroFileData;
Begin
  Result := InHerited Add() As IZeroFileData;
End;

Function TZeroFileDatas.Add(Const AItem : IZeroFileData) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Procedure TArchivedFileData.Created();
Begin
  Clear();
End;

Procedure TArchivedFileData.Clear();
Begin
  FDataLength    := 0;
  FFileName1     := '';
  FFileExtension := '';
  FFileName2     := '';
  FFileSize      := 0;
  FWord1         := 1;
  FArchiveFileId := 0;
End;

Procedure TArchivedFileData.Assign(ASource : TObject);
Var lSrc : IArchivedFileData;
Begin
  If Supports(ASource, IArchivedFileData, lSrc) Then
  Begin
    FDataLength    := lSrc.DataLength;
    FFileName1     := lSrc.FileName1;
    FFileExtension := lSrc.FileExtension;
    FFileName2     := lSrc.FileName2;
    FFileSize      := lSrc.FileSize;
    FWord1         := lSrc.Word1;
    FArchiveFileId := lSrc.ArchiveFileId;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [ASource.ClassName, ClassName]);
End;

Function TArchivedFileData.GetDataLength() : Word;
Begin
  Result := FDataLength;
End;

Procedure TArchivedFileData.SetDataLength(Const ADataLength : Word);
Begin
  FDataLength := ADataLength;
End;

Function TArchivedFileData.GetFileName1() : AnsiString;
Begin
  Result := FFileName1;
End;

Procedure TArchivedFileData.SetFileName1(Const AFileName1 : AnsiString);
Begin
  FFileName1 := AFileName1;
End;

Function TArchivedFileData.GetFileExtension() : AnsiString;
Begin
  Result := FFileExtension;
End;

Procedure TArchivedFileData.SetFileExtension(Const AFileExtension : AnsiString);
Begin
  FFileExtension := AFileExtension;
End;

Function TArchivedFileData.GetFileName2() : AnsiString;
Begin
  Result := FFileName2;
End;

Procedure TArchivedFileData.SetFileName2(Const AFileName2 : AnsiString);
Begin
  FFileName2 := AFileName2;
End;

Function TArchivedFileData.GetFileSize() : DWord;
Begin
  Result := FFileSize;
End;

Procedure TArchivedFileData.SetFileSize(Const AFileSize : DWord);
Begin
  FFileSize := AFileSize;
End;

Function TArchivedFileData.GetWord1() : Word;
Begin
  Result := FWord1;
End;

Procedure TArchivedFileData.SetWord1(Const AWord1 : Word);
Begin
  FWord1 := AWord1;
End;

Function TArchivedFileData.GetArchiveFileId() : Word;
Begin
  Result := FArchiveFileId;
End;

Procedure TArchivedFileData.SetArchiveFileId(Const AArchiveFileId : Word);
Begin
  FArchiveFileId := AArchiveFileId;
End;

Function TArchivedFileDatas.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TArchivedFileData;
End;

Function TArchivedFileDatas.Get(Index : Integer) : IArchivedFileData;
Begin
  Result := InHerited Items[Index] As IArchivedFileData;
End;

Procedure TArchivedFileDatas.Put(Index : Integer; Const Item : IArchivedFileData);
Begin
  InHerited Items[Index] := Item;
End;

Function TArchivedFileDatas.Add() : IArchivedFileData;
Begin
  Result := InHerited Add() As IArchivedFileData;
End;

Function TArchivedFileDatas.Add(Const AItem : IArchivedFileData) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Function TArchivedFileDatas.InternalSort(Item1, Item2 : IInterfaceEx) : Integer;
Var lItem1, lItem2 : IArchivedFileData;
Begin
  If Supports(Item1, IArchivedFileData, lItem1) And
     Supports(Item2, IArchivedFileData, lItem2) Then
  Begin
    If lItem1.ArchiveFileId > lItem2.ArchiveFileId Then
      Result := 1
    Else If lItem1.ArchiveFileId < lItem2.ArchiveFileId Then
      Result := -1
    Else
      Result := CompareText(lItem1.FileName1, lItem2.FileName1);
  End
  Else
    Raise Exception.Create('Invalid interface type');
End;

Procedure TArchivedFileDatas.Sort();
Begin
  InHerited Sort(InternalSort);
End;

Procedure TZeroFileHeader.Created();
Begin
  Clear();
End;

Procedure TZeroFileHeader.Clear();
Begin
  FStr1         := 'BGrm';
  FWord1        := 770;//515;
  FZeroFileSize := 0;
  FByte1        := 0;
  FWord2        := 27904;//109;
End;

Procedure TZeroFileHeader.Assign(ASource : TObject);
Var lSrc : IZeroFileHeader;
Begin
  If Supports(ASource, IZeroFileHeader, lSrc) Then
  Begin
    FStr1         := lSrc.Str1;
    FWord1        := lSrc.Word1;
    FZeroFileSize := lSrc.ZeroFileSize;
    FByte1        := lSrc.Byte1;
    FWord2        := lSrc.Word2;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [ASource.ClassName, ClassName]);
End;

Function TZeroFileHeader.GetStr1() : AnsiString;
Begin
  Result := FStr1;
End;

Procedure TZeroFileHeader.SetStr1(Const AStr1 : AnsiString);
Begin
  FStr1 := AStr1;
End;

Function TZeroFileHeader.GetWord1() : Word;
Begin
  Result := FWord1;
End;

Procedure TZeroFileHeader.SetWord1(Const AWord1 : Word);
Begin
  FWord1 := AWord1;
End;

Function TZeroFileHeader.GetZeroFileSize() : DWord;
Begin
  Result := FZeroFileSize;
End;

Procedure TZeroFileHeader.SetZeroFileSize(Const AZeroFileSize : DWord);
Begin
  FZeroFileSize := AZeroFileSize;
End;

Function TZeroFileHeader.GetByte1() : Byte;
Begin
  Result := FByte1;
End;

Procedure TZeroFileHeader.SetByte1(Const AByte1 : Byte);
Begin
  FByte1 := AByte1;
End;

Function TZeroFileHeader.GetWord2() : Word;
Begin
  Result := FWord2;
End;

Procedure TZeroFileHeader.SetWord2(Const AWord2 : Word);
Begin
  FWord2 := AWord2;
End;

Procedure TZeroFile.Created();
Begin
  Clear();
End;

Destructor TZeroFile.Destroy();
Begin
  FFileHeader := Nil;
  FFileDatas  := Nil;

  InHerited Destroy();
End;

Function TZeroFile.GetFileHeaderClass() : TZeroFileHeaderClass;
Begin
  Result := TZeroFileHeader;
End;

Function TZeroFile.GetZeroFileDatasClass() : TZeroFileDatasClass;
Begin
  Result := TZeroFileDatas;
End;

Procedure TZeroFile.Clear();
Begin
  FFileHeader := GetFileHeaderClass().Create();
  FFileDatas  := GetZeroFileDatasClass().Create();
  FCrc32 := 0;
End;

Procedure TZeroFile.Assign(ASource : TObject);
Var lSrc : TZeroFile;
Begin
{  If ASource Is TZeroFile Then
  Begin
    lSrc := TZeroFile(ASource);

    FFileHeader := lSrc.FileHeader;
    FFileData   := lSrc.FileData;
    FCrc32      := lSrc.Crc32;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [ASource.ClassName, ClassName]);}
End;

Function TZeroFile.GetFileHeader() : IZeroFileHeader;
Begin
  Result := FFileHeader;
End;

Function TZeroFile.GetArchiveDirectory() : AnsiString;
Begin
  Result := FArchiveDirectory;
End;

Procedure TZeroFile.SetArchiveDirectory(Const AArchiveDirectory : AnsiString);
Begin
  FArchiveDirectory := AArchiveDirectory;
End;

Function TZeroFile.GetFileDatas() : IZeroFileDatas;
Begin
  Result := FFileDatas;
End;

Function TZeroFile.GetCrc32() : DWord;
Begin
  Result := FCrc32;
End;

Procedure TZeroFile.SetCrc32(Const ACrc32 : DWord);
Begin
  FCrc32 := ACrc32;
End;

end.
