unit TSTOZero.Bin;

Interface

Uses Windows,
  HsInterfaceEx, HsStreamEx, TSTOZeroIntf;

Type
  IBinArchivedFileData = Interface(IArchivedFileData)
    ['{4B61686E-29A0-2112-BB3E-489428B09AA2}']
    Function GetAsString() : String;
    Function GetDataAsString(Const AIndent : Integer = 0) : String;

    Function  GetData() : IInterface;
    Procedure SetData(AData : IInterface);

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Property AsString : String     Read GetAsString;
    Property Data     : IInterface Read GetData Write SetData;
    
  End;

  IBinArchivedFileDatas = Interface(IArchivedFileDatas)
    ['{4B61686E-29A0-2112-9AB6-7D935CE6B6D5}']
    Function  Get(Index : Integer) : IBinArchivedFileData;
    Procedure Put(Index : Integer; Const Item : IBinArchivedFileData);

    Function Add() : IBinArchivedFileData; OverLoad;
    Function Add(Const AItem : IBinArchivedFileData) : Integer; OverLoad;

    Property Items[Index : Integer] : IBinArchivedFileData Read Get Write Put; Default;

  End;

  IBinZeroFileData = Interface(IZeroFileData)
    ['{4B61686E-29A0-2112-8C86-A1156E6BF8D8}']
    Function GetArchivedFiles() : IBinArchivedFileDatas;

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Property ArchivedFiles : IBinArchivedFileDatas Read GetArchivedFiles;

  End;

  IBinZeroFileDatas = Interface(IZeroFileDatas)
    ['{4B61686E-29A0-2112-9428-9A15CDEF8FBA}']
    Function  Get(Index : Integer) : IBinZeroFileData;
    Procedure Put(Index : Integer; Const Item : IBinZeroFileData);

    Function Add() : IBinZeroFileData; OverLoad;
    Function Add(Const AItem : IBinZeroFileData) : Integer; OverLoad;

    Property Items[Index : Integer] : IBinZeroFileData Read Get Write Put; Default;

  End;

  IBinZeroFileHeader = Interface(IZeroFileHeader)
    ['{4B61686E-29A0-2112-8113-2C6B9491E2E3}']
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Function GetDataLength() : Word;
    Property DataLength : Word Read GetDataLength;

  End;

  IBinZeroFile = Interface(IZeroFile)
    ['{4B61686E-29A0-2112-B416-9B3A4B064422}']
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Function  GetFileHeader() : IBinZeroFileHeader;
    Function  GetFileDatas() : IBinZeroFileDatas;

    Property FileHeader : IBinZeroFileHeader Read GetFileHeader;
    Property FileDatas  : IBinZeroFileDatas  Read GetFileDatas;

  End;

  TBinZeroFile = Class(TObject)
  Public
    Class Function CreateBinZeroFile() : IBinZeroFile;
    Class Function CreateBinArchivedFileDatas() : IBinArchivedFileDatas;

  End;

Implementation

Uses Classes, SysUtils,
  HsCheckSumEx, HsStringListEx, TSTOZeroImpl;

Type
  TBinArchivedFileData = Class(TArchivedFileData, IBinArchivedFileData)
  Private
    FData : IInterface;

  Protected
    Function GetAsString() : String;
    Function GetDataAsString(Const AIndent : Integer = 0) : String;

    Function  GetData() : IInterface;
    Procedure SetData(AData : IInterface);

    Function GetDataLength() : Word;

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

  Public
    Destructor Destroy(); OverRide;

  End;

  TBinArchivedFileDatas = Class(TArchivedFileDatas, IBinArchivedFileDatas)
  Protected
    Function  GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : IBinArchivedFileData; OverLoad;
    Procedure Put(Index : Integer; Const Item : IBinArchivedFileData); OverLoad;

    Function Add() : IBinArchivedFileData; OverLoad;
    Function Add(Const AItem : IBinArchivedFileData) : Integer; OverLoad;

  End;

  TBinZeroFileData = Class(TZeroFileData, IBinZeroFileData)
  Protected
    Function  GetArchivedFileDatasClass() : TArchivedFileDatasClass; OverRide;

    Function GetDataLength() : Word;
    Function GetArchivedFiles() : IBinArchivedFileDatas; OverLoad;

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

  End;

  TBinZeroFileDatas = Class(TZeroFileDatas, IBinZeroFileDatas)
  Protected
    Function  GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : IBinZeroFileData; OverLoad;
    Procedure Put(Index : Integer; Const Item : IBinZeroFileData); OverLoad;

    Function Add() : IBinZeroFileData; OverLoad;
    Function Add(Const AItem : IBinZeroFileData) : Integer; OverLoad;

  End;

  TBinZeroFileHeader = Class(TZeroFileHeader, IBinZeroFileHeader)
  Protected
    Function GetDataLength() : Word;

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

  End;

  TBinZeroFileImpl = Class(TZeroFile, IBinZeroFile)
  Protected
    Function GetFileHeaderClass() : TZeroFileHeaderClass; OverRide;
    Function GetZeroFileDatasClass() : TZeroFileDatasClass; OverRide;

    Function  GetFileHeader() : IBinZeroFileHeader; OverLoad;
    Function  GetFileDatas() : IBinZeroFileDatas; OverLoad;

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Property FileHeader : IBinZeroFileHeader Read GetFileHeader;
    Property FileDatas  : IBinZeroFileDatas  Read GetFileDatas;
    
  End;

Class Function TBinZeroFile.CreateBinZeroFile() : IBinZeroFile;
Begin
  Result := TBinZeroFileImpl.Create();
End;

Class Function TBinZeroFile.CreateBinArchivedFileDatas() : IBinArchivedFileDatas;
Begin
  Result := TBinArchivedFileDatas.Create();
End;

(******************************************************************************)

Function TBinZeroFileData.GetArchivedFileDatasClass() : TArchivedFileDatasClass;
Begin
  Result := TBinArchivedFileDatas;
End;

Function TBinZeroFileData.GetDataLength() : Word;
Begin
  Result := SizeOf(DataLength) +
            Length(FileName) + SizeOf(Word) +
            SizeOf(Byte1) +
            SizeOf(Crc32);
End;

Function TBinZeroFileData.GetArchivedFiles() : IBinArchivedFileDatas;
Begin
  Result := InHerited ArchivedFiles As IBinArchivedFileDatas;
End;

Procedure TBinZeroFileData.LoadFromStream(ASource : IStreamEx);
Var lByte : Byte;
Begin
  DataLength := ASource.ReadWord(True);

  lByte := ASource.ReadByte();
  FileName := ASource.ReadAnsiString(lByte-1);
  ASource.ReadByte();
  
  Byte1      := ASource.ReadByte();
  Crc32      := ASource.ReadDWord(True);
End;

Procedure TBinZeroFileData.SaveToStream(ATarget : IStreamEx);
Begin
  InHerited DataLength := GetDataLength() - SizeOf(DataLength);
  
  ATarget.WriteWord(DataLength, True);
  ATarget.WriteByte(Length(FileName) + 1);
  ATarget.WriteAnsiString(FileName, False);
  ATarget.WriteByte(0);
  ATarget.WriteByte(Byte1);
  ATarget.WriteDWord(Crc32, True);
End;

Function TBinZeroFileDatas.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TBinZeroFileData;
End;

Function TBinZeroFileDatas.Get(Index : Integer) : IBinZeroFileData;
Begin
  Result := InHerited Items[Index] As IBinZeroFileData;
End;

Procedure TBinZeroFileDatas.Put(Index : Integer; Const Item : IBinZeroFileData);
Begin
  InHerited Items[Index] := Item;
End;

Function TBinZeroFileDatas.Add() : IBinZeroFileData;
Begin
  Result := InHerited Add() As IBinZeroFileData;
End;

Function TBinZeroFileDatas.Add(Const AItem : IBinZeroFileData) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Destructor TBinArchivedFileData.Destroy();
Begin
  FData := Nil;

  InHerited Destroy();
End;

Function TBinArchivedFileData.GetDataAsString(Const AIndent : Integer = 0) : String;
Var lMem : IMemoryStreamEx;
    lStr : IHsStringListEx;
Begin
  lMem := TMemoryStreamEx.Create();
  lStr := THsStringListEx.CreateList();
  Try
    lStr.Add(StringOfChar(' ', AIndent) + 'DataLength : ' + IntToStr(DataLength));
    lStr.Add(StringOfChar(' ', AIndent) + 'FileName : ' + FileName1);
    lStr.Add(StringOfChar(' ', AIndent) + 'FileExtension : ' + FileExtension);
    lStr.Add(StringOfChar(' ', AIndent) + 'FileName2 : ' + FileName2);
    lStr.Add(StringOfChar(' ', AIndent) + 'FileSize : ' + IntToStr(FileSize));
    lStr.Add(StringOfChar(' ', AIndent) + 'Word1 : ' + IntToStr(Word1));
    lStr.Add(StringOfChar(' ', AIndent) + 'ArchiveFileId : ' + IntToStr(ArchiveFileId));

    SaveToStream(lMem);
    lStr.Add(StringOfChar(' ', AIndent) + 'RawData : ' + lMem.AsHexString);

    Result := lStr.Text;

    Finally
      lStr := Nil;
      lMem := Nil;
  End;
End;

Function TBinArchivedFileData.GetData() : IInterface;
Begin
  Result := FData;
End;

Procedure TBinArchivedFileData.SetData(AData : IInterface);
Begin
  FData := AData;
End;

Function TBinArchivedFileData.GetAsString() : String;
Begin
  Result := GetDataAsString();
End;

Function TBinArchivedFileData.GetDataLength() : Word;
  Function GetTSTOStrLen(Const AString : String) : Integer;
  Begin
    Result := Length(AString) + SizeOf(Word);
  End;

Begin
  Result := SizeOf(DataLength) +
            GetTSTOStrLen(FileName1) +
            GetTSTOStrLen(FileExtension) +
            GetTSTOStrLen(FileName2) +
            SizeOf(FileSize) +
            SizeOf(Word1) +
            SizeOf(ArchiveFileId);
End;

Procedure TBinArchivedFileData.LoadFromStream(ASource : IStreamEx);
Var lByte : Byte;
Begin
  DataLength    := ASource.ReadWord(True);

  lByte := ASource.ReadByte();
  FileName1 := ASource.ReadAnsiString(lByte-1);
  ASource.ReadByte();

  lByte := ASource.ReadByte();
  FileExtension := ASource.ReadAnsiString(lByte-1);
  ASource.ReadByte();

  lByte := ASource.ReadByte();
  FileName2:= ASource.ReadAnsiString(lByte-1);
  ASource.ReadByte();

  FileSize      := ASource.ReadDWord(True);
  Word1         := ASource.ReadWord(True);
  ArchiveFileId := ASource.ReadWord(True);
End;

Procedure TBinArchivedFileData.SaveToStream(ATarget : IStreamEx);
Begin
  InHerited DataLength := GetDataLength() - SizeOf(DataLength);

  ATarget.WriteWord(DataLength, True);
  ATarget.WriteByte(Length(FileName1) + 1);
  ATarget.WriteAnsiString(FileName1, False);
  ATarget.WriteByte(0);
  ATarget.WriteByte(Length(FileExtension) + 1);
  ATarget.WriteAnsiString(FileExtension, False);
  ATarget.WriteByte(0);
  ATarget.WriteByte(Length(FileName2) + 1);
  ATarget.WriteAnsiString(FileName2, False);
  ATarget.WriteByte(0);
  ATarget.WriteDWord(FileSize, True);
  ATarget.WriteWord(Word1, True);
  ATarget.WriteWord(ArchiveFileId, True);
End;

Function TBinArchivedFileDatas.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TBinArchivedFileData;
End;

Function TBinArchivedFileDatas.Get(Index : Integer) : IBinArchivedFileData;
Begin
  Result := InHerited Items[Index] As IBinArchivedFileData;
End;

Procedure TBinArchivedFileDatas.Put(Index : Integer; Const Item : IBinArchivedFileData);
Begin
  InHerited Items[Index] := Item;
End;

Function TBinArchivedFileDatas.Add() : IBinArchivedFileData;
Begin
  Result := InHerited Add() As IBinArchivedFileData;
End;

Function TBinArchivedFileDatas.Add(Const AItem : IBinArchivedFileData) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Function TBinZeroFileHeader.GetDataLength() : Word;
Begin
  Result := Length(Str1) +
            SizeOf(Word1) +
            SizeOf(ZeroFileSize) +
            SizeOf(Byte1) +
            SizeOf(Word2);
End;

Procedure TBinZeroFileHeader.LoadFromStream(ASource : IStreamEx);
Begin
  Str1         := ASource.ReadAnsiString(4);
  Word1        := ASource.ReadWord(True);
  ZeroFileSize := ASource.ReadDWord(True);
  Byte1        := ASource.ReadByte();
  Word2        := ASource.ReadWord(True);
End;

Procedure TBinZeroFileHeader.SaveToStream(ATarget : IStreamEx);
Begin
  ATarget.WriteAnsiString(Str1, False);
  ATarget.WriteWord(Word1, True);
  ATarget.WriteDWord(ZeroFileSize, True);
  ATarget.WriteByte(Byte1);
  ATarget.WriteWord(Word2, True);
End;

Function TBinZeroFileImpl.GetFileHeaderClass() : TZeroFileHeaderClass;
Begin
  Result := TBinZeroFileHeader;
End;

Function TBinZeroFileImpl.GetZeroFileDatasClass() : TZeroFileDatasClass;
Begin
  Result := TBinZeroFileDatas;
End;

Procedure TBinZeroFileImpl.LoadFromStream(ASource : IStreamEx);
Var lFileData : IBinArchivedFileData;
    lWord     : Word;
    lByte     : Byte;
Begin
  FileHeader.LoadFromStream(ASource);

  lByte := ASource.ReadByte();
  ArchiveDirectory := ASource.ReadAnsiString(lByte-1);
  ASource.ReadByte();

  lWord := ASource.ReadWord(True);
  While lWord > 0 Do
  Begin
    FileDatas.Add().LoadFromStream(ASource);
    Dec(lWord);
  End;

  lWord := ASource.ReadWord(True);
  While lWord > 0 Do
  Begin
    lFileData := TBinArchivedFileData.Create();
    lFileData.LoadFromStream(ASource);
    FileDatas[lFileData.ArchiveFileId].ArchivedFiles.Add(lFileData);
    Dec(lWord);
  End;

  Crc32 := ASource.ReadDWord(True);
End;

Procedure TBinZeroFileImpl.SaveToStream(ATarget : IStreamEx);
Var X, Y : Integer;
    lWord : Word;
Begin
  lWord := 0;
  FileHeader.ZeroFileSize := FileHeader.DataLength + SizeOf(Crc32) +
                             Length(ArchiveDirectory) + SizeOf(Word) +
                             SizeOf(DWord) {-->ArchiveCount + ArchivedCount<--};

  For X := 0 To FileDatas.Count - 1 Do
  Begin
    FileHeader.ZeroFileSize := FileHeader.ZeroFileSize + FileDatas[X].DataLength;
    For Y := 0 To FileDatas[X].ArchivedFiles.Count - 1 Do
      FileHeader.ZeroFileSize := FileHeader.ZeroFileSize + FileDatas[X].ArchivedFiles[Y].DataLength;
  End;

  FileHeader.SaveToStream(ATarget);
  ATarget.WriteByte(Length(ArchiveDirectory) + 1);
  ATarget.WriteAnsiString(ArchiveDirectory, False);
  ATarget.WriteByte(0);
  
  ATarget.WriteWord(FileDatas.Count, True);
  For X := 0 To FileDatas.Count - 1 Do
  Begin
    FileDatas[X].SaveToStream(ATarget);
    lWord := lWord + FileDatas[X].ArchivedFiles.Count;
  End;

  ATarget.WriteWord(lWord, True);
  For X := 0 To FileDatas.Count - 1 Do
    For Y := 0 To FileDatas[X].ArchivedFiles.Count - 1 Do
      FileDatas[X].ArchivedFiles[Y].SaveToStream(ATarget);

  With KeepStreamPosition(ATarget, 0) Do
    Crc32 := GetCrc32Value(TStream(ATarget.InterfaceObject));
    
  ATarget.WriteDWord(Crc32, True);
End;

Function TBinZeroFileImpl.GetFileHeader() : IBinZeroFileHeader;
Begin
  Result := InHerited FileHeader As IBinZeroFileHeader;
End;

Function TBinZeroFileImpl.GetFileDatas() : IBinZeroFileDatas;
Begin
  Result := InHerited FileDatas As IBinZeroFileDatas;
End;

Initialization
  RegisterInterface('IBinArchivedFileData', IBinArchivedFileData);
  RegisterInterface('IBinArchivedFileDatas', IBinArchivedFileDatas);
  RegisterInterface('IBinZeroFileData', IBinZeroFileData);
  RegisterInterface('IBinZeroFileDatas', IBinZeroFileDatas);
  RegisterInterface('IBinZeroFileHeader', IBinZeroFileHeader);
  RegisterInterface('IBinZeroFile ', IBinZeroFile); 

End.
