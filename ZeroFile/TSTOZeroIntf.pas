unit TSTOZeroIntf;

Interface

Uses Windows, HsInterfaceEx;

Type
  IArchivedFileData = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-88CD-8AEE4A0BDD74}']
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

    Property DataLength    : Word       Read GetDataLength    Write SetDataLength;
    Property FileName1     : AnsiString Read GetFileName1     Write SetFileName1;
    Property FileExtension : AnsiString Read GetFileExtension Write SetFileExtension;
    Property FileName2     : AnsiString Read GetFileName2     Write SetFileName2;
    Property FileSize      : DWord      Read GetFileSize      Write SetFileSize;
    Property Word1         : Word       Read GetWord1         Write SetWord1;
    Property ArchiveFileId : Word       Read GetArchiveFileId Write SetArchiveFileId;

  End;

  IArchivedFileDatas = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-B44F-D75CE6C4B3CE}']
    Function  Get(Index : Integer) : IArchivedFileData;
    Procedure Put(Index : Integer; Const Item : IArchivedFileData);

    Function Add() : IArchivedFileData; OverLoad;
    Function Add(Const AItem : IArchivedFileData) : Integer; OverLoad;

    Procedure Sort();
    Property Items[Index : Integer] : IArchivedFileData Read Get Write Put; Default;

  End;
  
  IZeroFileData = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-90A7-F52BF50DEF96}']
    Function  GetDataLength() : Word;
    Procedure SetDataLength(Const ADataLength : Word);

    Function  GetFileName() : AnsiString;
    Procedure SetFileName(Const AFileName : AnsiString);

    Function  GetByte1() : Byte;
    Procedure SetByte1(Const AByte1 : Byte);

    Function  GetCrc32() : DWord;
    Procedure SetCrc32(Const ACrc32 : DWord);

    Function GetArchivedFiles() : IArchivedFileDatas;

    Property DataLength : Word       Read GetDataLength Write SetDataLength;
    Property FileName   : AnsiString Read GetFileName   Write SetFileName;
    Property Byte1      : Byte       Read GetByte1      Write SetByte1;
    Property Crc32      : DWord      Read GetCrc32      Write SetCrc32;

    Property ArchivedFiles : IArchivedFileDatas Read GetArchivedFiles;

  End;

  IZeroFileDatas = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-A794-81A233E73F48}']
    Function  Get(Index : Integer) : IZeroFileData;
    Procedure Put(Index : Integer; Const Item : IZeroFileData);

    Function Add() : IZeroFileData; OverLoad;
    Function Add(Const AItem : IZeroFileData) : Integer; OverLoad;

    Property Items[Index : Integer] : IZeroFileData Read Get Write Put; Default;

  End;

  IZeroFileHeader = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-A9DD-73723520A3F6}']
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

    Property Str1         : AnsiString Read GetStr1        Write SetStr1;
    Property Word1        : Word       Read GetWord1        Write SetWord1;
    Property ZeroFileSize : DWord      Read GetZeroFileSize Write SetZeroFileSize;
    Property Byte1        : Byte       Read GetByte1        Write SetByte1;
    Property Word2        : Word       Read GetWord2        Write SetWord2;

  End;

  IZeroFile = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-9EAF-F8EB66ABD8B5}']
    Function  GetFileHeader() : IZeroFileHeader;

    Function  GetArchiveDirectory() : AnsiString;
    Procedure SetArchiveDirectory(Const AArchiveDirectory : AnsiString);

    Function  GetFileDatas() : IZeroFileDatas;

    Function  GetCrc32() : DWord;
    Procedure SetCrc32(Const ACrc32 : DWord);

    Property FileHeader       : IZeroFileHeader Read GetFileHeader;
    Property ArchiveDirectory : AnsiString      Read GetArchiveDirectory Write SetArchiveDirectory;
    Property FileDatas        : IZeroFileDatas  Read GetFileDatas;
    Property Crc32            : DWord           Read GetCrc32            Write SetCrc32;

  End;

(******************************************************************************)

Implementation

End.

