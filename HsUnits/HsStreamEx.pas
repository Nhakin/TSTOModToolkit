unit HsStreamEx;

interface

Uses Windows, Classes, SysUtils,
  HsInterfaceEx, HsEncodingEx, HsStringListEx;

{x$Define UseClassHelper}
{$If CompilerVersion < 18.5}
  {$UnDef UseClassHelper}
Type
  TBytes = Array Of Byte;
{$Else}
  {$Define HaveStrict}
{$IfEnd}

Type
  QWord = Type UInt64;

  TDateType = ( dtNormalTimeT, dtTimeT51, dtTimeT7, dtTimeTMinutes,
                dtOleDateTime, dtSystemTime, dtFileTime, dtMsDos );

  IStreamIO = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-9BD6-AE5A1F5D055F}']
    Procedure WriteByte(Const AByte : Byte); //U8
    Procedure WriteBoolean(Const ABoolean : Boolean);
    Procedure WriteWord(Const AWord : Word; Const ABigEndian : Boolean = False); //U16
    Procedure Write24Bits(Const ADWord : DWord; Const ABigEndian : Boolean = False);
    Procedure WriteDWord(Const ADWord : DWord; Const ABigEndian : Boolean = False); //U32
    Procedure WriteQWord(Const AQWord : QWord; Const ABigEndian : Boolean = False); //U64
    Procedure WriteShortInt(Const AShortInt : ShortInt);//S8
    Procedure WriteSmallInt(Const ASmallInt : Smallint; Const ABigEndian : Boolean = False); //S16
    Procedure WriteInt(Const AInt : Integer; Const ABigEndian : Boolean = False); //S32
    Procedure WriteInt64(Const AInt64 : Int64; Const ABigEndian : Boolean = False); //S64
    Procedure WriteSingle(Const ASingle : Single); //4
    Procedure WriteFloat(Const AFloat : Double); //8
    Procedure WriteCurrency(Const ACurrency : Currency); //8
    Procedure WriteGUID(Const AGUID : TGUID);
    Procedure WriteAnsiString(Const AString : AnsiString; Const AWriteLen : Boolean; Const ALenSize : Byte; Const ABigEndian : Boolean); OverLoad;
    Procedure WriteAnsiString(Const AString : AnsiString; Const AWriteLen : Boolean); OverLoad;
    Procedure WriteAnsiString(Const AString : AnsiString); OverLoad;
    Procedure WriteWideString(Const AString : WideString; Const AWriteLen : Boolean; Const ALenSize : Byte; Const ABigEndian : Boolean); OverLoad;
    Procedure WriteWideString(Const AString : WideString; Const AWriteLen : Boolean); OverLoad;
    Procedure WriteWideString(Const AString : WideString); OverLoad;
    Procedure WriteTStrings(AStrings : IHsStringListEx; Const ALenSize : Byte = 1; Const ABigEndian : Boolean = False); OverLoad;
    Procedure WriteTStrings(AStrings : TStringList; Const ALenSize : Byte = 1; Const ABigEndian : Boolean = False); OverLoad;
    Procedure WriteDateTime(Const ADateTime : TDateTime; Const ADateType : TDateType = dtOleDateTime);

    Function ReadByte() : Byte;
    Function ReadBoolean() : Boolean;
    Function ReadWord(Const ABigEndian : Boolean = False) : Word;
    Function Read24Bits(Const ABigEndian : Boolean = False) : DWord;
    Function ReadDWord(Const ABigEndian : Boolean = False) : DWord;
    Function ReadQWord(Const ABigEndian : Boolean = False) : QWord;
    Function ReadShortInt() : ShortInt;
    Function ReadSmallInt(Const ABigEndian : Boolean = False) : Smallint;
    Function ReadInt(Const ABigEndian : Boolean = False) : Integer;
    Function ReadInt64(Const ABigEndian : Boolean = False) : Int64;
    Function ReadSingle() : Single;
    Function ReadFloat() : Double;
    Function ReadCurrency() : Currency;
    Function ReadGUID() : TGUID;
    Function ReadAnsiString(Const AStringLen : Integer) : AnsiString; OverLoad;
    Function ReadAnsiString(Const ALenSize : Byte; Const ABigEndian : Boolean) : AnsiString; OverLoad;
    Function ReadAnsiString() : AnsiString; OverLoad;
    Function ReadWideString(Const AStringLen : Integer) : WideString; OverLoad;
    Function ReadWideString(Const ALenSize : Byte; Const ABigEndian : Boolean) : WideString; OverLoad;
    Function ReadWideString() : WideString; OverLoad;
    Procedure ReadTStrings(AResult : IHsStringListEx; Const ALenSize : Byte = 1; Const ABigEndian : Boolean = False); OverLoad;
    Procedure ReadTStrings(AResult : TStringList; Const ALenSize : Byte = 1; Const ABigEndian : Boolean = False); OverLoad;
    Function ReadDateTime(Const ADateType : TDateType = dtOleDateTime) : TDateTime;

    Function GetAsHexString() : String;
    Function GetBoS() : Boolean;
    Function GetEoS() : Boolean;
    Function GetIsEmpty() : Boolean;

    Property AsHexString : String  Read GetAsHexString;
    Property BoS         : Boolean Read GetBoS;
    Property EoS         : Boolean Read GetEoS;
    Property IsEmpty     : Boolean Read GetIsEmpty;

  End;

  IStreamEx = Interface(IStreamIO)
    ['{4B61686E-29A0-2112-BD8B-8ED5119A24C6}']
    Function  Seek(Offset: Longint; Origin: Word) : Longint; Overload;
    Function  Seek(Const Offset: Int64; Origin: TSeekOrigin) : Int64; Overload;
    Procedure ReadBuffer(Var Buffer; Count : {$If CompilerVersion >= 32}NativeInt{$Else}Integer{$IfEnd});
    Procedure WriteBuffer(Const Buffer; Count : {$If CompilerVersion >= 32}NativeInt{$Else}Integer{$IfEnd});
    Function  Read(Var Buffer; Count: Longint) : Longint;
    Function  Write(Const Buffer; Count: Longint) : Longint;
    Function  CopyFrom(Source: TStream; Count: Int64) : Int64; OverLoad;
    Function  CopyFrom(Source: IStreamEx; Count: Int64) : Int64; OverLoad;
    Function  ReadComponent({$If CompilerVersion > 21}Const {$IfEnd}Instance: TComponent) : TComponent;
    Function  ReadComponentRes({$If CompilerVersion > 21}Const {$IfEnd}Instance: TComponent) : TComponent;
    Procedure WriteComponent({$If CompilerVersion > 21}Const {$IfEnd}Instance: TComponent);
    Procedure WriteComponentRes(Const ResName: String; {$If CompilerVersion > 21}Const {$IfEnd}Instance: TComponent);
    Procedure WriteDescendent({$If CompilerVersion > 21}Const {$IfEnd}Instance, Ancestor: TComponent);
    Procedure WriteDescendentRes(Const ResName: String; {$If CompilerVersion > 21}Const {$IfEnd}Instance, Ancestor: TComponent);
    Procedure WriteResourceHeader(Const ResName: String; Out FixupInfo: Integer);
    Procedure FixupResourceHeader(FixupInfo: Integer);
    Procedure ReadResHeader();

    Function  GetPosition() : Int64;
    Procedure SetPosition(Const APosition : Int64);

    Function  GetSize() : Int64;
    Procedure SetSize(Const ASize : Int64);

    Property Position : Int64 Read GetPosition Write SetPosition;
    Property Size     : Int64 Read GetSize     Write SetSize;

  End;

  IMemoryStreamEx = Interface(IStreamEx)
    ['{4B61686E-29A0-2112-B0B4-8ED5119A24C6}']
    Procedure Clear();
    Procedure SaveToClipBoard();
    Procedure LoadFromClipBoard();
    Procedure SaveToStream(Stream : TStream); OverLoad;
    Procedure SaveToStream(Stream : IStreamEx); OverLoad;
    Procedure LoadFromStream(Stream : TStream); OverLoad;
    Procedure LoadFromStream(Stream : IStreamEx); OverLoad;
    Procedure SaveToFile(Const FileName : String);
    Procedure LoadFromFile(Const FileName : String);

    Function GetMemory() : Pointer;
    Property Memory : Pointer Read GetMemory;

  End;

  IBytesStreamEx = Interface(IMemoryStreamEx)
    ['{4B61686E-29A0-2112-A77B-A2F5DEBA53DC}']
    Function GetBytes() : TBytes;
    Property Bytes : TBytes Read GetBytes;
    
  End;

  IStringStreamEx = Interface(IBytesStreamEx)
    ['{4B61686E-29A0-2112-8698-30070C22BD4D}']
    Function GetDataString() : String;
    Function GetEncoding() : IHsEncoding;

    Property DataString : String      Read GetDataString;
    Property Encoding   : IHsEncoding Read GetEncoding;

  End;

  IRawByteStringStream = Interface(IStreamEx)
    ['{4B61686E-29A0-2112-A4C9-F70B8FBBF12B}']

  End;

  IFileStreamEx = Interface(IStreamEx)
    ['{4B61686E-29A0-2112-A20F-36E090990332}']
    Function GetFileName() : String;
    Property FileName : String Read GetFileName;

  End;

{$IfDef UseClassHelper}
  TStreamImplementor = TInterfaceExImplementor;
  
  TStreamIO = Class Helper For TStream
  Protected
{$Else}
  TStreamIO = Class;
  TStreamImplementor = TStreamIO;

  TStreamIO = Class(TInterfaceExImplementor, IStreamIO)
  {$IfDef HaveStrict}Strict{$EndIf} Private
    FStream : TStream;
  Protected
    Function QueryInterface(Const IID: TGUID; Out Obj) : HResult; OverRide; StdCall;

    Property Stream : TStream Read FStream;
{$EndIf}

    //IStreamEx
    Function  GetPosition() : Int64;
    Procedure SetPosition(Const APosition : Int64);
    Function  CopyFrom(Source : IStreamEx; Count : Int64) : Int64; OverLoad;
    Function  CopyFrom(Source : TStream; Count : Int64) : Int64; OverLoad;

    Function GetBoS() : Boolean;
    Function GetEoS() : Boolean;
    Function GetIsEmpty() : Boolean;
    Function GetAsHexString() : String;

{$IfDef UseClassHelper}
  Public
{$EndIf}
    //IStreamIO
    Procedure WriteByte(Const AByte : Byte);
    Procedure WriteBoolean(Const ABoolean : Boolean);
    Procedure WriteWord(Const AWord : Word; Const ABigEndian : Boolean = False);
    Procedure Write24Bits(Const ADWord : DWord; Const ABigEndian : Boolean = False);
    Procedure WriteDWord(Const ADWord : DWord; Const ABigEndian : Boolean = False);
    Procedure WriteQWord(Const AQWord : QWord; Const ABigEndian : Boolean = False);
    Procedure WriteShortInt(Const AShortInt : ShortInt);
    Procedure WriteSmallInt(Const ASmallInt : Smallint; Const ABigEndian : Boolean = False);
    Procedure WriteInt(Const AInt : Integer; Const ABigEndian : Boolean = False);
    Procedure WriteInt64(Const AInt64 : Int64; Const ABigEndian : Boolean = False);
    Procedure WriteSingle(Const ASingle : Single);
    Procedure WriteFloat(Const AFloat : Double);
    Procedure WriteCurrency(Const ACurrency : Currency);
    Procedure WriteGUID(Const AGUID : TGUID);
    Procedure WriteAnsiString(Const AString : AnsiString; Const AWriteLen : Boolean; Const ALenSize : Byte; Const ABigEndian : Boolean); OverLoad;
    Procedure WriteAnsiString(Const AString : AnsiString; Const AWriteLen : Boolean); OverLoad;
    Procedure WriteAnsiString(Const AString : AnsiString); OverLoad;
    Procedure WriteWideString(Const AString : WideString; Const AWriteLen : Boolean; Const ALenSize : Byte; Const ABigEndian : Boolean); OverLoad;
    Procedure WriteWideString(Const AString : WideString; Const AWriteLen : Boolean); OverLoad;
    Procedure WriteWideString(Const AString : WideString); OverLoad;
    Procedure WriteTStrings(AStrings : IHsStringListEx; Const ALenSize : Byte = 1; Const ABigEndian : Boolean = False); OverLoad;
    Procedure WriteTStrings(AStrings : TStringList; Const ALenSize : Byte = 1; Const ABigEndian : Boolean = False); OverLoad;
    Procedure WriteDateTime(Const ADateTime : TDateTime; Const ADateType : TDateType = dtOleDateTime);

    Function ReadByte() : Byte;
    Function ReadBoolean() : Boolean;
    Function ReadWord(Const ABigEndian : Boolean = False) : Word;
    Function Read24Bits(Const ABigEndian : Boolean = False) : DWord;
    Function ReadDWord(Const ABigEndian : Boolean = False) : DWord;
    Function ReadQWord(Const ABigEndian : Boolean = False) : QWord;
    Function ReadShortInt() : ShortInt;
    Function ReadSmallInt(Const ABigEndian : Boolean = False) : Smallint;
    Function ReadInt(Const ABigEndian : Boolean = False) : Integer;
    Function ReadInt64(Const ABigEndian : Boolean = False) : Int64;
    Function ReadSingle() : Single;
    Function ReadFloat() : Double;
    Function ReadCurrency() : Currency;
    Function ReadGUID() : TGUID;
    Function ReadAnsiString(Const AStringLen : Integer) : AnsiString; OverLoad;
    Function ReadAnsiString(Const ALenSize : Byte; Const ABigEndian : Boolean) : AnsiString; OverLoad;
    Function ReadAnsiString() : AnsiString; OverLoad;
    Function ReadWideString(Const AStringLen : Integer) : WideString; OverLoad;
    Function ReadWideString(Const ALenSize : Byte; Const ABigEndian : Boolean) : WideString; OverLoad;
    Function ReadWideString() : WideString; OverLoad;
    Procedure ReadTStrings(AResult : IHsStringListEx; Const ALenSize : Byte = 1; Const ABigEndian : Boolean = False); OverLoad;
    Procedure ReadTStrings(AResult : TStringList; Const ALenSize : Byte = 1; Const ABigEndian : Boolean = False); OverLoad;
    Function ReadDateTime(Const ADateType : TDateType = dtOleDateTime) : TDateTime;

    Property AsHexString : String  Read GetAsHexString;
    Property BoS         : Boolean Read GetBoS;
    Property EoS         : Boolean Read GetEoS;
    Property IsEmpty     : Boolean Read GetIsEmpty;

{$IfNDef UseClassHelper}
  Public
    Constructor Create(AStream : TStream; AOwnStream : Boolean = True); ReIntroduce; OverLoad;
    Constructor Create(AStream : TStream; AOwner : TObject); ReIntroduce; OverLoad;
{$EndIf}

  End;

  TMemoryStreamEx = Class(TMemoryStream, IInterfaceEx, IStreamIO, IStreamEx, IMemoryStreamEx)
  {$IfDef HaveStrict}Strict{$EndIf} Private
    FImpl : TStreamImplementor;
    FGettingImplementor : Boolean;

  Protected
    Function GetImpl() : TStreamImplementor;

    Property IntfExImpl    : TStreamImplementor Read GetImpl Implements IInterfaceEx;
    Property StreamIOImpl  : TStreamImplementor Read GetImpl Implements IStreamIO;
    Property StreamImpl    : TStreamImplementor Read GetImpl Implements IStreamEx;
    Property MemStreamImpl : TStreamImplementor Read GetImpl Implements IMemoryStreamEx;

    Function GetMemory() : Pointer;

{$IfNDef UseClassHelper}
    Function GetIO() : IStreamIO;

  Public
    Property IO : IStreamIO Read GetIO;
{$EndIf}

  Public
    Procedure SaveToStream(Stream : IStreamEx); ReIntroduce; OverLoad;
    Procedure LoadFromStream(Stream : IStreamEx); ReIntroduce; OverLoad;
    Procedure SaveToClipBoard(); Virtual;
    Procedure LoadFromClipBoard(); Virtual;

    Constructor Create(); ReIntroduce; OverLoad; Virtual; 
    Destructor  Destroy(); OverRide;

  End;

{$If CompilerVersion >= 20}
  TBytesStreamEx = Class(TBytesStream, IStreamIO, IStreamEx, IMemoryStreamEx, IBytesStreamEx)
  Strict Private
    FImpl : TStreamImplementor;

  Protected
    Function GetImpl() : TStreamImplementor;

    Property StreamIOImpl    : TStreamImplementor Read GetImpl Implements IStreamIO;
    Property StreamImpl      : TStreamImplementor Read GetImpl Implements IStreamEx;
    Property MemStreamImpl   : TStreamImplementor Read GetImpl Implements IMemoryStreamEx;
    Property BytesStreamImpl : TStreamImplementor Read GetImpl Implements IBytesStreamEx;

    Function GetMemory() : Pointer;
    Procedure SaveToClipBoard();
    Procedure LoadFromClipBoard();
    Procedure SaveToStream(Stream : IStreamEx); OverLoad;
    Procedure LoadFromStream(Stream : IStreamEx); OverLoad;

    Function GetBytes() : TBytes;
  {$IfNDef UseClassHelper}
    Function GetIO() : IStreamIO;

  Public
    Property IO : IStreamIO Read GetIO;
  {$EndIf}

{$Else}
  TBytesStreamEx = Class(TMemoryStreamEx, IBytesStreamEx)
  {$IfDef HaveStrict}Strict{$EndIf} Private
    FImpl  : TStreamImplementor;
    FBytes : TBytes;

  Protected
    Property BytesStreamImpl : TStreamImplementor Read GetImpl Implements IBytesStreamEx;

    Function Realloc(Var NewCapacity : Longint) : Pointer; OverRide;
    Function GetBytes() : TBytes;

  {$IfNDef UseClassHelper}
    Function GetIO() : IStreamIO;

  Public
    Property IO : IStreamIO Read GetIO;
  {$EndIf}

  Public
    Property Bytes : TBytes Read GetBytes;
    Constructor Create(Const ABytes : TBytes); OverLoad;
{$IfEnd}
  End;

{$If CompilerVersion < 20}
  RawByteString = Type AnsiString;
{$IfEnd}

  TStringStreamEx = Class(TBytesStreamEx, IStringStreamEx)
  {$IfDef HaveStrict}Strict{$EndIf} Private
    FEncoding : IHsEncoding;
  {$IfNDef UseClassHelper}
    FImpl : TStreamIO;  
  {$EndIf}

  Protected
    Property StringStreamImpl : TStreamImplementor Read GetImpl Implements IStringStreamEx;

    Function GetDataString() : String;
    Function GetEncoding() : IHsEncoding;

{$IfNDef UseClassHelper}
    Function GetIO() : IStreamIO;

  Public
    Property IO : IStreamIO Read GetIO;
{$EndIf}

  Public
    Property DataString : String      Read GetDataString;
    Property Encoding   : IHsEncoding Read GetEncoding;

    Function  ReadString(Const AStringLen : Integer) : String; OverLoad;
    Function  ReadString() : String; OverLoad;
    Procedure WriteString(Const AString : String); OverLoad;
    Procedure WriteString(Const AString : String; Const AWriteLen : Boolean); OverLoad;

    Constructor Create(); OverLoad; {$If CompilerVersion < 20}OverRide;{$IfEnd}
    Constructor Create(Const AString : String); OverLoad;
    {$If CompilerVersion > 18.5}
    Constructor Create(Const AString : RawByteString); OverLoad;
    {$IfEnd}
    Constructor Create(Const AString : String; AEncoding : IHsEncoding); OverLoad;
    Constructor Create(Const AString : String; ACodePage : Integer); OverLoad;
    Constructor Create(Const ABytes : TBytes); OverLoad;

    Destructor Destroy(); OverRide;

  End;

  TRawByteStringStream = Class(TStream, IInterfaceEx, IStreamIO, IStreamEx, IRawByteStringStream)
  {$IfDef HaveStrict}Strict{$EndIf} Private
    FImpl : TStreamImplementor;
    FDataString : RawByteString;
    FPosition   : Integer;

    Function GetImpl() : TStreamImplementor;

  Protected
    Property IntfExImpl    : TStreamImplementor Read GetImpl Implements IInterfaceEx;
    Property StreamIOImpl  : TStreamImplementor Read GetImpl Implements IStreamIO;
    Property StreamImpl    : TStreamImplementor Read GetImpl Implements IStreamEx;
    Property RawStreamImpl : TStreamImplementor Read GetImpl Implements IRawByteStringStream;

    Procedure SetSize(NewSize: Longint); OverRide;

  Public
    Property DataString : RawByteString Read FDataString Write FDataString;

    Function Read(Var Buffer; Count : Longint) : Longint; OverRide;
    Function Seek(Offset : Longint; Origin : Word) : Longint; OverRide;
    Function Write(Const Buffer; Count : Longint) : Longint; OverRide;

    Constructor Create(Const aString : RawByteString = ''); OverLoad;

  End;

  TFileStreamEx = Class(TFileStream, IStreamIO, IStreamEx, IFileStreamEx)
  {$IfDef HaveStrict}Strict{$EndIf} Private
    FImpl : TStreamImplementor;

    Function GetImpl() : TStreamImplementor;

  Protected
    Property StreamIOImpl   : TStreamImplementor Read GetImpl Implements IStreamIO;
    Property StreamImpl     : TStreamImplementor Read GetImpl Implements IStreamEx;
    Property FileStreamImpl : TStreamImplementor Read GetImpl Implements IFileStreamEx;

    Function GetFileName() : String;

{$IfNDef UseClassHelper}
    Function GetIO() : IStreamIO;

  Public
    Property IO : IStreamIO Read GetIO;
{$EndIf}

{$If CompilerVersion < 18.5}
  Private
    FFileName : String;

  Public
    Property FileName : String Read GetFileName;

    Constructor Create(Const FileName : String; Mode : Word; Rights : Cardinal); OverLoad;
{$IfEnd}

  End;

Function KeepStreamPosition(AStream : TStream; Const ANewPosition : Int64 = -1) : IStreamEx; OverLoad;
Function KeepStreamPosition(AStream : IStreamEx; Const ANewPosition : Int64 = -1) : IStreamEx; OverLoad;

implementation

Uses Dialogs,
  {$If CompilerVersion < 20}RTLConsts,{$IfEnd}DateUtils, 
  HsClipBoardEx, HsFunctionsEx;

Type
  TGuidRec = Packed Record
    Case Byte Of
      0 : (
            D1: LongWord;
            D2: Word;
            D3: Word;
            D4: array[0..7] of Byte;
      );//(Guid : TGuid);
      1 : (Lo, Hi : Int64);
      2 : (DWords : Array[0..3] Of DWord);
      3 : (Words : Array[0..7] Of Word)
  End;

Type
  IPositionStream = Interface(IStreamIO)
    ['{4B61686E-29A0-2112-9F27-08794D98225F}']
    Procedure RestorePosition();

  End;

  TStreamEx = Class(TStream)
  Protected
    Function CopyFrom(Source: IStreamEx; Count: Int64) : Int64; OverLoad; Virtual; Abstract;

  End;

{$IfDef UseClassHelper}
  TKeepPositionStream = Class(TMemoryStreamEx)
{$Else}
  TKeepPositionStream = Class(TStreamIO, IStreamEx, IPositionStream)
  {$IfDef HaveStrict}Strict{$EndIf} Private
    FImpl : TStreamEx;
    FStreamPos : Integer;

  Protected
    Property StreamImpl : TStreamEx Read FImpl Implements IStreamEx;

    Function  CopyFrom(Source: TStream; Count: Int64) : Int64; ReIntroduce; OverLoad;
    Function  CopyFrom(Source: IStreamEx; Count: Int64) : Int64; ReIntroduce; OverLoad;

    Procedure RestorePosition();
{$EndIf}

  Public
    Constructor Create(AStream : TStream; Const ANewPosition : Int64 = -1); ReIntroduce; OverLoad;
    Constructor Create(AStream : IStreamEx; Const ANewPosition : Int64 = -1); ReIntroduce; OverLoad;

    Destructor Destroy(); OverRide;

  End;

Function KeepStreamPosition(AStream : TStream; Const ANewPosition : Int64 = -1) : IStreamEx;
Begin
  Result := TKeepPositionStream.Create(AStream, ANewPosition);
End;

Function KeepStreamPosition(AStream : IStreamEx; Const ANewPosition : Int64 = -1) : IStreamEx;
Begin
  Result := TKeepPositionStream.Create(AStream, ANewPosition);
End;

(******************************************************************************)

Constructor TKeepPositionStream.Create(AStream : TStream; Const ANewPosition : Int64 = -1);
{$IfDef UseClassHelper}
Var lPos : Integer;
Begin
  InHerited Create();

  lPos := AStream.Position;
  CopyFrom(AStream, 0);
  AStream.Position := lPos;

  If ANewPosition >= 0 Then
    Position := ANewPosition
  Else
    Position := lPos;
End;
{$Else}
Begin
  InHerited Create(AStream, False);

  FStreamPos := Stream.Position;
  If ANewPosition >= 0 Then
    Stream.Position := ANewPosition;
End;
{$EndIf}

Constructor TKeepPositionStream.Create(AStream : IStreamEx; Const ANewPosition : Int64 = -1);
Begin
  Create(TStream(AStream.InterfaceObject), ANewPosition);
End;

Destructor TKeepPositionStream.Destroy();
Begin
{$IfNDef UseClassHelper}
  RestorePosition();
{$EndIf}
  InHerited Destroy();
End;

{$IfNDef UseClassHelper}
Function TKeepPositionStream.CopyFrom(Source: TStream; Count: Int64) : Int64;
Begin
  Result := Stream.CopyFrom(Source, Count);
End;

Function TKeepPositionStream.CopyFrom(Source: IStreamEx; Count: Int64) : Int64;
Begin
  Result := Stream.CopyFrom(TStream(Source.InterfaceObject), Count);
End;

Procedure TKeepPositionStream.RestorePosition();
Begin
  Stream.Position := FStreamPos;
End;
{$EndIf}

(******************************************************************************)

{$IfNDef UseClassHelper}
Constructor TStreamIO.Create(AStream : TStream; AOwner : TObject);
Begin
  InHerited Create(AOwner);
  FStream := AStream;
End;

Constructor TStreamIO.Create(AStream : TStream; AOwnStream : Boolean = True);
Begin
  If AOwnStream Then
    Create(AStream, AStream)
  Else
    Create(AStream, Nil);
End;

Function TStreamIO.QueryInterface(Const IID: TGUID; Out Obj) : HResult;
Begin
  If FStream.GetInterface(IID, Obj) Then
    Result := S_OK
  Else
    Result := InHerited QueryInterface(IID, Obj);
End;
{$EndIf}

Function TStreamIO.CopyFrom(Source : TStream; Count : Int64) : Int64;
Begin
  Result := {$IfNDef UseClassHelper}FStream.{$Else}InHerited {$EndIf}CopyFrom(Source, Count);
End;

Function TStreamIO.CopyFrom(Source : IStreamEx; Count : Int64) : Int64;
Begin
  Result := CopyFrom(TStream(Source.InterfaceObject), Count);
End;

Function TStreamIO.GetBoS() : Boolean;
Begin
  Result := {$IfNDef UseClassHelper}FStream.{$EndIf}Position = 0;
End;

Function TStreamIO.GetEoS() : Boolean;
Begin
  {$IfNDef UseClassHelper}
  With FStream Do
  {$EndIf}
    Result := Position = Size;
End;

Function TStreamIO.GetIsEmpty() : Boolean;
Begin
  Result := {$IfNDef UseClassHelper}FStream.{$EndIf}Size = 0;
End;

Function TStreamIO.GetAsHexString() : String;
Var lByte : Byte;
Begin
{$IfDef UseClassHelper}
  With KeepStreamPosition(Self, 0) Do
{$Else}
  With KeepStreamPosition(FStream, 0) Do
{$EndIf}
  Begin
    While Not EoS Do
    Begin
      lByte := ReadByte();
      Result := Result + IntToHex(lByte, SizeOf(lByte) * 2);
    End;
  End;
End;

Function TStreamIO.GetPosition() : Int64;
Begin
  Result := {$IfNDef UseClassHelper}FStream.{$EndIf}Position;
End;

Procedure TStreamIO.SetPosition(Const APosition : Int64);
Begin
  {$IfNDef UseClassHelper}FStream.{$EndIf}Position := APosition;
End;

Procedure TStreamIO.WriteByte(Const AByte : Byte);
Begin
  {$IfNDef UseClassHelper}FStream.{$EndIf}WriteBuffer(AByte, SizeOf(AByte));
End;

Procedure TStreamIO.WriteBoolean(Const ABoolean : Boolean);
Begin
  If ABoolean Then
    WriteByte(1)
  Else
    WriteByte(0);
End;

Procedure TStreamIO.WriteWord(Const AWord : Word; Const ABigEndian : Boolean = False);
Begin
  If ABigEndian Then
  Begin
    WriteByte(WordRec(AWord).Hi);
    WriteByte(WordRec(AWord).Lo);
  End
  Else
    {$IfNDef UseClassHelper}FStream.{$EndIf}WriteBuffer(AWord, SizeOf(AWord));
End;

Procedure TStreamIO.Write24Bits(Const ADWord : DWord; Const ABigEndian : Boolean = False);
Var lByte : Byte;
    lWord : Word;
Begin
  If ABigEndian Then
  Begin
    lByte := ADWord And $FF0000 Shr $10;
    lWord := ADWord And $00FFFF;

    WriteByte(lByte);
    WriteWord(lWord);
  End
  Else
    {$IfNDef UseClassHelper}FStream.{$EndIf}WriteBuffer(ADWord, 3);
End;

Procedure TStreamIO.WriteDWord(Const ADWord : DWord; Const ABigEndian : Boolean = False);
Begin
  If ABigEndian Then
  Begin
    WriteWord(LongRec(ADWord).Hi, True);
    WriteWord(LongRec(ADWord).Lo, True);
  End
  Else
    {$IfNDef UseClassHelper}FStream.{$EndIf}WriteBuffer(ADWord, SizeOf(ADWord));
End;

Procedure TStreamIO.WriteQWord(Const AQWord : QWord; Const ABigEndian : Boolean = False);
Begin
  If ABigEndian Then
  Begin
    WriteInt(Int64Rec(AQWord).Hi, True);
    WriteInt(Int64Rec(AQWord).Lo, True);
  End
  Else
    {$IfNDef UseClassHelper}FStream.{$EndIf}WriteBuffer(AQWord, SizeOf(AQWord));
End;

Procedure TStreamIO.WriteAnsiString(Const AString : AnsiString; Const AWriteLen : Boolean; Const ALenSize : Byte; Const ABigEndian : Boolean);
Begin
  If AWriteLen Then
    Case ALenSize Of
      1 : WriteByte(Length(AString));
      2 : WriteWord(Length(AString), ABigEndian);
      4 : WriteDWord(Length(AString), ABigEndian);
      8 : WriteQWord(Length(AString), ABigEndian);
      Else
        Raise Exception.Create('Invalid Len Size');
    End;

  {$IfNDef UseClassHelper}FStream.{$EndIf}WriteBuffer(AString[1], Length(AString));
End;

Procedure TStreamIO.WriteAnsiString(Const AString : AnsiString; Const AWriteLen : Boolean);
Begin
  WriteAnsiString(AString, AWriteLen, 1, False);
End;

Procedure TStreamIO.WriteAnsiString(Const AString : AnsiString);
Begin
  WriteAnsiString(AString, True);
End;

Procedure TStreamIO.WriteWideString(Const AString : WideString; Const AWriteLen : Boolean; Const ALenSize : Byte; Const ABigEndian : Boolean);
Begin
  If AWriteLen Then
    Case ALenSize Of
      1 : WriteByte(Length(AString));
      2 : WriteWord(Length(AString), ABigEndian);
      4 : WriteDWord(Length(AString), ABigEndian);
      8 : WriteQWord(Length(AString), ABigEndian);
      Else
        Raise Exception.Create('Invalid Len Size');
    End;

  {$IfNDef UseClassHelper}FStream.{$EndIf}WriteBuffer(AString[1], Length(AString));
End;

Procedure TStreamIO.WriteWideString(Const AString : WideString; Const AWriteLen : Boolean);
Begin
  WriteWideString(AString, AWriteLen, 1, False);
End;

Procedure TStreamIO.WriteWideString(Const AString : WideString);
Begin
  WriteWideString(AString, True);
End;

Procedure TStreamIO.WriteTStrings(AStrings : IHsStringListEx; Const ALenSize : Byte = 1; Const ABigEndian : Boolean = False);
Begin
  WriteTStrings(TStringList(AStrings.InterfaceObject), ALenSize, ABigEndian);
End;

Procedure TStreamIO.WriteTStrings(AStrings : TStringList; Const ALenSize : Byte = 1; Const ABigEndian : Boolean = False);
Var X : Integer;
Begin
  Case ALenSize Of
    1 : WriteByte(AStrings.Count);
    2 : WriteWord(AStrings.Count, ABigEndian);
    4 : WriteDWord(AStrings.Count, ABigEndian);
    8 : WriteQWord(AStrings.Count, ABigEndian);
    Else
      Raise Exception.Create('Invalid Len Size');
  End;

  For X := 0 To AStrings.Count - 1 Do
    WriteWideString(AStrings[X], True, ALenSize, ABigEndian);
End;

Procedure TStreamIO.WriteDateTime(Const ADateTime : TDateTime; Const ADateType : TDateType = dtOleDateTime);
  Function DateTimeToDosDateTime(const AValue: TDateTime): longint;
  var year,month,day,hour,min,sec,msec : word;
      zs : longint;
  begin
    decodedatetime(avalue,year,month,day,hour,min,sec,msec);

    result := -1980;
    result := result+year and 127;
    result := result shl 4;
    result := result+month;
    result := result shl 5;
    result := result+day;
    result := result shl 16;
    zs     := hour;
    zs     := zs shl 6;
    zs     := zs+min;
    zs     := zs shl 5;
    zs     := zs+sec div 2;
    result := result+(zs and $ffff);
  end;

Var lDWord : DWord;
    lDate  : TDateTime;
    Y, Mo, D, H, Mi, S, Ms : Word;
Begin
  Case ADateType Of
    dtNormalTimeT : //4
    Begin
      WriteDWord(DateTimeToUnix(ADateTime));
    End;

    dtTimeT51 : //4
    Begin

    End;

    dtTimeT7 : //4
    Begin

    End;

    dtTimeTMinutes : //4
    Begin
      DecodeDateTime(ADateTime - EncodeDate(1970,01,01), Y, Mo, D, H, Mi, S, Ms);
//      Result := IncHour(IncMinute(EncodeDate(1970,01,01), ReadDWord()), -4);
    End;

    dtOleDateTime : {$IfNDef UseClassHelper}FStream.{$EndIf}WriteBuffer(ADateTime, SizeOf(ADateTime));
(*
    dtSystemTime : //16
    Begin
      {$IfNDef UseClassHelper}FStream.{$EndIf}ReadBuffer(lSystemTime, SizeOf(lSystemTime));
      Result := SystemTimeToDateTime(lSystemTime);
    End;

    dtFileTime : //8
    Begin
      {$IfNDef UseClassHelper}FStream.{$EndIf}ReadBuffer(lFileTime, SizeOf(lFileTime));
      FileTimeToSystemTime(lFileTime, lSystemTime);
      Result := SystemTimeToDateTime(lSystemTime);
    End;

    dtMsDos : //4
    Begin
      Result := DosDateTimeToDateTime(ReadDWord());
    End;
*)
  End;
End;

Procedure TStreamIO.WriteShortInt(Const AShortInt : ShortInt);
Begin
  {$IfNDef UseClassHelper}FStream.{$EndIf}WriteBuffer(AShortInt, SizeOf(AShortInt));
End;

Procedure TStreamIO.WriteSmallInt(Const ASmallInt : Smallint; Const ABigEndian : Boolean = False);
Begin
  If ABigEndian Then
  Begin
    WriteByte(WordRec(ASmallInt).Hi);
    WriteByte(WordRec(ASmallInt).Lo);
  End
  Else
    {$IfNDef UseClassHelper}FStream.{$EndIf}WriteBuffer(ASmallInt, SizeOf(ASmallInt));
End;

Procedure TStreamIO.WriteInt(Const AInt : Integer; Const ABigEndian : Boolean = False);
Begin
  If ABigEndian Then
  Begin
    WriteSmallInt(LongRec(AInt).Hi, True);
    WriteSmallInt(LongRec(AInt).Lo, True);
  End
  Else
    {$IfNDef UseClassHelper}FStream.{$EndIf}WriteBuffer(AInt, SizeOf(AInt));
End;

Procedure TStreamIO.WriteInt64(Const AInt64 : Int64; Const ABigEndian : Boolean = False);
Begin
  If ABigEndian Then
  Begin
    WriteInt(Int64Rec(AInt64).Hi, True);
    WriteInt(Int64Rec(AInt64).Lo, True);
  End
  Else
    {$IfNDef UseClassHelper}FStream.{$EndIf}WriteBuffer(AInt64, SizeOf(AInt64));
End;

Procedure TStreamIO.WriteSingle(Const ASingle : Single);
Begin
  {$IfNDef UseClassHelper}FStream.{$EndIf}WriteBuffer(ASingle, SizeOf(ASingle));
End;

Procedure TStreamIO.WriteFloat(Const AFloat : Double);
Begin
  {$IfNDef UseClassHelper}FStream.{$EndIf}WriteBuffer(AFloat, SizeOf(AFloat));
End;

Procedure TStreamIO.WriteCurrency(Const ACurrency : Currency);
Begin
  {$IfNDef UseClassHelper}FStream.{$EndIf}WriteBuffer(ACurrency, SizeOf(ACurrency));
End;

Procedure TStreamIO.WriteGUID(Const AGUID : TGUID);
Begin
  WriteDWord(TGuidRec(AGUID).D1, True);
  WriteWord(TGuidRec(AGUID).D2, True);
  WriteWord(TGuidRec(AGUID).D3, True);
  WriteInt64(TGuidRec(AGUID).Hi, False);
End;

Function TStreamIO.ReadByte() : Byte;
Begin
  {$IfNDef UseClassHelper}FStream.{$EndIf}ReadBuffer(Result, SizeOf(Result));
End;

Function TStreamIO.ReadBoolean() : Boolean;
Begin
  Result := ReadByte() <> 0;
End;

Function TStreamIO.ReadWord(Const ABigEndian : Boolean = False) : Word;
Begin
  If ABigEndian Then
  Begin
    WordRec(Result).Hi := ReadByte();
    WordRec(Result).Lo := ReadByte();
  End
  Else
    {$IfNDef UseClassHelper}FStream.{$EndIf}ReadBuffer(Result, SizeOf(Result));
End;

Function TStreamIO.Read24Bits(Const ABigEndian : Boolean = False) : DWord;
Var lByte : Byte;
    lWord : Word;
Begin
  If ABigEndian Then
  Begin
    lByte := ReadByte();
    lWord := ReadWord();

    Result := (lByte Shl $10) Or lWord;
  End
  Else
    {$IfNDef UseClassHelper}FStream.{$EndIf}ReadBuffer(Result, 3);
End;

Function TStreamIO.ReadDWord(Const ABigEndian : Boolean = False) : DWord;
Begin
  If ABigEndian Then
  Begin
    LongRec(Result).Hi := ReadWord(True);
    LongRec(Result).Lo := ReadWord(True);
  End
  Else
    {$IfNDef UseClassHelper}FStream.{$EndIf}ReadBuffer(Result, SizeOf(Result));
End;

Function TStreamIO.ReadQWord(Const ABigEndian : Boolean = False) : QWord;
Begin
  If ABigEndian Then
  Begin
    Int64Rec(Result).Hi := ReadDWord(True);
    Int64Rec(Result).Lo := ReadDWord(True);
  End
  Else
    {$IfNDef UseClassHelper}FStream.{$EndIf}ReadBuffer(Result, SizeOf(Result));
End;

Function TStreamIO.ReadShortInt() : ShortInt;
Begin
  {$IfNDef UseClassHelper}FStream.{$EndIf}ReadBuffer(Result, SizeOf(Result));
End;

Function TStreamIO.ReadSmallInt(Const ABigEndian : Boolean = False) : Smallint;
Begin
  If ABigEndian Then
  Begin
    WordRec(Result).Hi := ReadByte();
    WordRec(Result).Lo := ReadByte();
  End
  Else
    {$IfNDef UseClassHelper}FStream.{$EndIf}ReadBuffer(Result, SizeOf(Result));
End;

Function TStreamIO.ReadInt(Const ABigEndian : Boolean = False) : Integer;
Begin
  If ABigEndian Then
  Begin
    LongRec(Result).Hi := ReadWord(True);
    LongRec(Result).Lo := ReadWord(True);
  End
  Else
    {$IfNDef UseClassHelper}FStream.{$EndIf}ReadBuffer(Result, SizeOf(Result));
End;

Function TStreamIO.ReadInt64(Const ABigEndian : Boolean = False) : Int64;
Begin
  If ABigEndian Then
  Begin
    Int64Rec(Result).Hi := ReadDWord(True);
    Int64Rec(Result).Lo := ReadDWord(True);
  End
  Else
    {$IfNDef UseClassHelper}FStream.{$EndIf}ReadBuffer(Result, SizeOf(Result));
End;

Function TStreamIO.ReadSingle() : Single;
Begin
  {$IfNDef UseClassHelper}FStream.{$EndIf}ReadBuffer(Result, SizeOf(Result));
End;

Function TStreamIO.ReadFloat() : Double;
Begin
  {$IfNDef UseClassHelper}FStream.{$EndIf}ReadBuffer(Result, SizeOf(Result));
End;

Function TStreamIO.ReadCurrency() : Currency;
Begin
  {$IfNDef UseClassHelper}FStream.{$EndIf}ReadBuffer(Result, SizeOf(Result));
End;

Function TStreamIO.ReadGUID() : TGUID;
Begin
  TGuidRec(Result).DWords[0] := ReadDWord(True);
  TGuidRec(Result).DWords[1] := ReadDWord(True);
  TGuidRec(Result).DWords[2] := ReadDWord();
  TGuidRec(Result).DWords[3] := ReadDWord();
End;

Function TStreamIO.ReadAnsiString(Const AStringLen : Integer) : AnsiString;
Begin
  SetLength(Result, AStringLen);
  {$IfNDef UseClassHelper}FStream.{$EndIf}ReadBuffer(Result[1], AStringLen);
End;

Function TStreamIO.ReadAnsiString(Const ALenSize : Byte; Const ABigEndian : Boolean) : AnsiString;
Var lLen : Integer;
Begin
  Case ALenSize Of
    1 : lLen := ReadByte();
    2 : lLen := ReadWord(ABigEndian);
    3 : lLen := Read24Bits(ABigEndian);
    4 : lLen := ReadDWord(ABigEndian);
    Else
      Raise Exception.Create('Invalid Len Size');
  End;

  Result := ReadAnsiString(lLen);
End;

Function TStreamIO.ReadAnsiString() : AnsiString;
Begin
  Result := ReadAnsiString(1, False);
End;

Function TStreamIO.ReadWideString(Const AStringLen : Integer) : WideString;
Begin
  SetLength(Result, AStringLen);
  {$IfNDef UseClassHelper}FStream.{$EndIf}ReadBuffer(Result[1], AStringLen);
End;

Function TStreamIO.ReadWideString(Const ALenSize : Byte; Const ABigEndian : Boolean) : WideString;
Var lLen : Integer;
Begin
  Case ALenSize Of
    1 : lLen := ReadByte();
    2 : lLen := ReadWord(ABigEndian);
    3 : lLen := Read24Bits(ABigEndian);
    4 : lLen := ReadDWord(ABigEndian);
    Else
      Raise Exception.Create('Invalid Len Size');
  End;

  Result := ReadWideString(lLen);
End;

Function TStreamIO.ReadWideString() : WideString;
Begin
  Result := ReadWideString(1, False);
End;

Procedure TStreamIO.ReadTStrings(AResult : IHsStringListEx; Const ALenSize : Byte = 1; Const ABigEndian : Boolean = False);
Begin
  If Assigned(AResult) Then
    ReadTStrings(TStringList(AResult.InterfaceObject), ALenSize, ABigEndian)
  Else
    Raise Exception.Create('AResult must not be nil.');
End;

Procedure TStreamIO.ReadTStrings(AResult : TStringList; Const ALenSize : Byte = 1; Const ABigEndian : Boolean = False);
Var lNbItem : Integer;
Begin
  If Assigned(AResult) Then
  Begin
    Case ALenSize Of
      1 : lNbItem := ReadByte();
      2 : lNbItem := ReadWord(ABigEndian);
      3 : lNbItem := Read24Bits(ABigEndian);
      4 : lNbItem := ReadDWord(ABigEndian);
      Else
        Raise Exception.Create('Invalid Len Size');
    End;

    While lNbItem > 0 Do
    Begin
      AResult.Add(ReadWideString(ALenSize, ABigEndian));
      Dec(lNbItem);
    End;
  End
  Else
    Raise Exception.Create('AResult must not be nil.');
End;

Function TStreamIO.ReadDateTime(Const ADateType : TDateType) : TDateTime;
  Function DosDateTimeToDateTime( AValue: longint): TDateTime;
  Var year,month,day,hour,min,sec : integer;
  Begin
    sec    := (AValue and 31) * 2;
    AValue := AValue shr 5;
    min    := AValue and 63;
    AValue := AValue shr 6;
    hour   := AValue and 31;
    AValue := AValue shr 5;
    day    := AValue and 31;
    AValue := AValue shr 5;
    month  := AValue and 15;
    AValue := AValue shr 4;
    year   := AValue+1980;
    result := EncodeDateTime(year,month,day,hour,min,sec,0);
  End;

Var lSystemTime : TSystemTime;
    lTimeStamp  : TTimeStamp;
    lFileTime   : TFileTime;
Begin
  Case ADateType Of
    dtNormalTimeT : //4
    Begin
      Result := UnixToDateTime(ReadDWord());
    End;

    dtTimeT51 : //4
    Begin

    End;

    dtTimeT7 : //4
    Begin

    End;

    dtTimeTMinutes : //4
    Begin
      Result := IncHour(IncMinute(EncodeDate(1970,01,01), ReadDWord()), -4);
    End;

    dtOleDateTime : {$IfNDef UseClassHelper}FStream.{$EndIf}ReadBuffer(Result, SizeOf(Result));

    dtSystemTime : //16
    Begin
      {$IfNDef UseClassHelper}FStream.{$EndIf}ReadBuffer(lSystemTime, SizeOf(lSystemTime));
      Result := SystemTimeToDateTime(lSystemTime);
    End;

    dtFileTime : //8
    Begin
      {$IfNDef UseClassHelper}FStream.{$EndIf}ReadBuffer(lFileTime, SizeOf(lFileTime));
      FileTimeToSystemTime(lFileTime, lSystemTime);
      Result := SystemTimeToDateTime(lSystemTime);
    End;
(*
Function DateTimeToDosDateTime(const AValue: TDateTime): longint;
var year,month,day,hour,min,sec,msec : word;
    zs : longint;
begin
  decodedatetime(avalue,year,month,day,hour,min,sec,msec);
  result:=-1980;
  result:=result+year and 127;
  result:=result shl 4;
  result:=result+month;
  result:=result shl 5;
  result:=result+day;
  result:=result shl 16;
  zs:=hour;
  zs:=zs shl 6;
  zs:=zs+min;
  zs:=zs shl 5;
  zs:=zs+sec div 2;
  result:=result+(zs and $ffff);
end;
*)
    dtMsDos : //4
    Begin
      Result := DosDateTimeToDateTime(ReadDWord());
    End;
  End;
End;

(******************************************************************************)

Constructor TMemoryStreamEx.Create();
Begin
  InHerited Create();

  FGettingImplementor := False;
End;

Destructor TMemoryStreamEx.Destroy();
Begin
  InHerited Destroy();
End;

Function TMemoryStreamEx.GetImpl() : TStreamImplementor;
Var lIntfEntry : PInterfaceEntry;
Begin
  If Not Assigned(FImpl) Then
  Begin
    If FGettingImplementor Then
    Begin
      FImpl := TStreamImplementor.Create(Self);
      FImpl._Release();
    End
    Else
    Begin
      FGettingImplementor := True;
      Try
        lIntfEntry := GetInterfaceEntry(IInterfaceEx);
        If lIntfEntry <> Nil Then
        Begin
          If lIntfEntry^.IOffset <> 0 Then
          Begin
            IInterfaceEx(Integer(Self) + lIntfEntry^.IOffset)._AddRef();
            If Not Assigned(FImpl) Then
            Begin
              FImpl := TStreamImplementor.Create(Self, False);
              IInterfaceEx(Integer(Self) + lIntfEntry^.IOffset)._Release();
            End;
          End;
        End
        Else
          FImpl := TStreamImplementor.Create(Self);
          
        Finally
          FGettingImplementor := False;
      End;
    End;
  End;

  Result := FImpl;
End;

{$IfNDef UseClassHelper}
Function TMemoryStreamEx.GetIO() : IStreamIO;
Begin
  If Not Assigned(FImpl) Then
    FImpl := TStreamIO.Create(Self, False);

  Result := FImpl;
End;
{$EndIf}

Function TMemoryStreamEx.GetMemory() : Pointer;
Begin
  Result := InHerited Memory;
End;

Procedure TMemoryStreamEx.SaveToStream(Stream : IStreamEx);
Begin
  InHerited SaveToStream(TStream(Stream.InterfaceObject));
End;

Procedure TMemoryStreamEx.LoadFromStream(Stream : IStreamEx);
Begin
  InHerited LoadFromStream(TStream(Stream.InterfaceObject));
End;

Procedure TMemoryStreamEx.SaveToClipBoard();
Begin
  ClipBoard.SetData(Self);
End;

Procedure TMemoryStreamEx.LoadFromClipBoard();
Var lMemStream : TMemoryStream;
Begin
  If ClipBoard.HasFormat(CF_RAWDATA) Then
  Begin
    lMemStream := TMemoryStream(ClipBoard.GetData(CF_RAWDATA));
    Try
      Clear();
      CopyFrom(lMemStream, 0);
      Position := 0;

      Finally
        lMemStream.Free();
    End;
  End;
End;

(******************************************************************************)

{$If CompilerVersion < 20}
Constructor TBytesStreamEx.Create(Const ABytes : TBytes);
Begin
  InHerited Create();

  FBytes := ABytes;
  SetPointer(Pointer(FBytes), Length(FBytes));
  Capacity := Size;
End;

Function TBytesStreamEx.Realloc(Var NewCapacity : Longint) : Pointer;
Const
  MemoryDelta = $2000;
Begin
  If (NewCapacity > 0) and (NewCapacity <> Size) Then
    NewCapacity := (NewCapacity + (MemoryDelta - 1)) and not (MemoryDelta - 1);
  Result := Pointer(FBytes);

  If NewCapacity <> Capacity then
  Begin
    SetLength(FBytes, NewCapacity);
    Result := Pointer(FBytes);

    If NewCapacity <> 0 Then
    Begin
      If Result = Nil Then
        Raise EStreamError.CreateRes(@SMemoryStreamError);
    End;
  End;
End;
{$IfEnd}

{$If CompilerVersion >= 20}
Function TBytesStreamEx.GetMemory() : Pointer;
Begin
  Result := InHerited Memory;
End;

Procedure TBytesStreamEx.SaveToClipBoard();
Begin
  ClipBoard.SetData(Self);
End;

Procedure TBytesStreamEx.LoadFromClipBoard();
Var lMemStream : TMemoryStream;
Begin
  If ClipBoard.HasFormat(CF_RAWDATA) Then
  Begin
    lMemStream := TMemoryStream(ClipBoard.GetData(CF_RAWDATA));
    Try
      Clear();
      CopyFrom(lMemStream, 0);
      Position := 0;

      Finally
        lMemStream.Free();
    End;
  End;
End;

Procedure TBytesStreamEx.SaveToStream(Stream : IStreamEx);
Begin
  InHerited SaveToStream(TStream(Stream.InterfaceObject));
End;

Procedure TBytesStreamEx.LoadFromStream(Stream : IStreamEx);
Begin
  InHerited LoadFromStream(TStream(Stream.InterfaceObject));
End;
{$IfEnd}

Function TBytesStreamEx.GetBytes() : TBytes;
Begin
  {$If CompilerVersion < 20}
  Result := FBytes;
  {$Else}
  Result := InHerited Bytes;
  {$IfEnd}
  SetLength(Result, Size);
End;

{$IfDef UseClassHelper}
Function TBytesStreamEx.GetImpl() : TStreamImplementor;
Begin
  Result := InHerited MemStreamImpl;
End;
{$Else}
  {$If CompilerVersion >= 20}
  Function TBytesStreamEx.GetImpl() : TStreamImplementor;
  Begin
    If Not Assigned(FImpl) Then
      FImpl := TStreamIO.Create(Self);
    Result := FImpl;
  End;
  {$IfEnd}
Function TBytesStreamEx.GetIO() : IStreamIO;
Begin
  If Not Assigned(FImpl) Then
    FImpl := TStreamIO.Create(Self, False);

  Result := FImpl;
End;
{$EndIf}

(******************************************************************************)

Constructor TStringStreamEx.Create();
Begin
  Create('', THsEncoding.Default);
End;

Constructor TStringStreamEx.Create(Const AString : String);
Begin
  Create(AString, THsEncoding.Default);
End;

{$If CompilerVersion > 18.5}
Constructor TStringStreamEx.Create(Const AString : RawByteString);
Var lBytes : TBytes;
    lLen   : Integer;
    {$If CompilerVersion >= 20}
    lCodePage : Cardinal;
    {$IfEnd}
Begin
  {$If CompilerVersion >= 20}
  lCodePage := StringCodePage(AString);
  If (lCodePage = CP_ACP) {or (LCodePage = TEncoding.Default.CodePage)} Then
    FEncoding := THsEncoding.Default
  Else
    FEncoding := THsEncoding.GetEncoding(lCodePage);
  {$Else}
  FEncoding := THsEncoding.Default;
  {$IfEnd}

  lLen := Length(AString);
  SetLength(lBytes, lLen);
  Move(AString[1], lBytes[0], lLen);

  InHerited Create(lBytes);
End;
{$IfEnd}

Constructor TStringStreamEx.Create(Const AString : String; AEncoding : IHsEncoding);
Begin
  FEncoding := AEncoding;
  InHerited Create(TBytes(FEncoding.GetBytes(AString)));
End;

Constructor TStringStreamEx.Create(Const AString : String; ACodePage : Integer);
Begin
  Create(AString, THsEncoding.GetEncoding(ACodePage));
End;

Constructor TStringStreamEx.Create(Const ABytes : TBytes);
Begin
  InHerited Create(ABytes);

  FEncoding := Nil;
  THsEncoding.GetBufferEncoding(THsBytes(ABytes), FEncoding);
End;

Destructor TStringStreamEx.Destroy();
Begin
  FEncoding := Nil;

  InHerited Destroy();
End;

Function TStringStreamEx.GetDataString() : String;
Begin
  Result := FEncoding.GetString(THsBytes(Bytes), 0, Size);
End;

Function TStringStreamEx.GetEncoding() : IHsEncoding;
Begin
  Result := FEncoding;
End;

Function TStringStreamEx.ReadString(Const AStringLen : Integer) : String;
Var lCount : Integer;
Begin
  lCount := AStringLen;
  If lCount > Size - Position Then
    lCount := Size - Position;
  Result := FEncoding.GetString(THsBytes(Bytes), Position, lCount);
  Position := Position + lCount;
End;

Function TStringStreamEx.ReadString() : String;
Var lLen : Byte;
Begin
  ReadBuffer(lLen, SizeOf(lLen));
  Result := ReadString(lLen);
End;

Procedure TStringStreamEx.WriteString(Const AString : String; Const AWriteLen : Boolean);
Var lBytes : THsBytes;
    lLen   : Byte;
Begin
  lBytes := FEncoding.GetBytes(AString);
  lLen := Length(lBytes);
  If AWriteLen Then
    WriteBuffer(lLen, SizeOf(lLen));
  WriteBuffer(lBytes[0], Length(lBytes));
End;

Procedure TStringStreamEx.WriteString(Const AString : String);
Begin
  WriteString(AString, False);
End;

{$IfNDef UseClassHelper}
Function TStringStreamEx.GetIO() : IStreamIO;
Begin
  If Not Assigned(FImpl) Then
    FImpl := TStreamIO.Create(Self, False);

  Result := FImpl;
End;
{$EndIf}


(******************************************************************************)

Constructor TRawByteStringStream.Create(Const AString : RawByteString);
Begin
  InHerited Create();

  FDataString := AString;
End;

Function TRawByteStringStream.GetImpl() : TStreamImplementor;
Begin
  If Not Assigned(FImpl) Then
    FImpl := TStreamImplementor.Create(Self);

  Result := FImpl;
End;

Function TRawByteStringStream.Read(Var Buffer; Count : Integer): Longint;
Begin
  If Count<=0 Then
    Result := 0
  Else
  Begin
    Result := Length(FDataString) - FPosition;
    If Result > Count Then
      Result := Count;

    MoveFast(PByteArray(FDataString)[FPosition], Buffer, Result);
    Inc(fPosition, Result);
  End;
End;

Function TRawByteStringStream.Seek(Offset : Integer; Origin : Word) : Longint;
Begin
  Case Origin Of
    soFromBeginning: FPosition := Offset;
    soFromCurrent: FPosition := FPosition + Offset;
    soFromEnd: FPosition := Length(FDataString) - Offset;
  End;

  If FPosition > Length(FDataString) Then
    FPosition := Length(FDataString)
  Else If FPosition < 0 Then
    FPosition := 0;
    
  Result := FPosition;
End;

Procedure TRawByteStringStream.SetSize(NewSize : Integer);
Begin
  SetLength(FDataString, NewSize);
  If FPosition > NewSize Then
    FPosition := NewSize;
End;

Function TRawByteStringStream.Write(Const Buffer; Count: Integer): Longint;
Begin
  If Count <= 0 Then
    Result := 0
  Else
  Begin
    Result := Count;
    SetLength(FDataString,(FPosition + Result));
    MoveFast(Buffer, PByteArray(FDataString)[FPosition], Result);
    Inc(FPosition, Result);
  End;
End;

(******************************************************************************)

{$If CompilerVersion < 18.5}
Constructor TFileStreamEx.Create(Const FileName : String; Mode : Word; Rights : Cardinal);
Begin
  InHerited Create(FileName, Mode, Rights);

  FFileName := FileName;
End;
{$IfEnd}

Function TFileStreamEx.GetImpl() : TStreamImplementor;
Begin
  If Not Assigned(FImpl) Then
    FImpl := TStreamImplementor.Create(Self);

  Result := FImpl;
End;

{$IfNDef UseClassHelper}
Function TFileStreamEx.GetIO() : IStreamIO;
Begin
  If Not Assigned(FImpl) Then
    FImpl := TStreamIO.Create(Self, False);

  Result := FImpl;
End;
{$EndIf}

Function TFileStreamEx.GetFileName() : String;
Begin
{$If CompilerVersion >= 18.5}
  Result := InHerited FileName;
{$Else}
  Result := FFileName;
{$IfEnd}
End;

end.
