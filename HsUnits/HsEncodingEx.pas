Unit HsEncodingEx;

Interface

Uses Windows, SysUtils;
(*
UnDef STRING_IS_UNICODE
UnDef DOTNET
UnDef USE_ICONV
UnDef HAS_LocaleCharsFromUnicode
Def SUPPORTS_CODEPAGE_ENCODING
UnDef ENDIAN_BIG
*)
Type
  {$If CompilerVersion >= 20}
  THsWideChar = Char;
  PHsWideChar = PChar;
  THsUnicodeString = UnicodeString;
  {$Else}
  THsWideChar = WideChar;
  PHsWideChar = PWideChar;
  THsUnicodeString = WideString;
  {$IfEnd}
  THsWideChars = Array Of THsWideChar;
  THsBytes = Array Of Byte;

  IHsEncoding = Interface(IInterface)
    ['{4B61686E-29A0-2112-AA8D-F4C6299CD089}']
    Function GetByteCount(Const AChars : THsWideChars) : Integer; OverLoad;
    Function GetByteCount(Const AChars : THsWideChars; ACharIndex, ACharCount : Integer) : Integer; OverLoad;
    Function GetByteCount(Const AChars : PHsWideChar; ACharCount : Integer) : Integer; OverLoad;
    Function GetByteCount(Const AStr : THsUnicodeString) : Integer; OverLoad;
    Function GetByteCount(Const AStr : THsUnicodeString; ACharIndex, ACharCount : Integer) : Integer; OverLoad;

    Function GetBytes(Const AChars : THsWideChars) : THsBytes; OverLoad;
    Function GetBytes(Const AChars : THsWideChars; ACharIndex, ACharCount : Integer) : THsBytes; OverLoad;
    Function GetBytes(Const AChars : THsWideChars; ACharIndex, ACharCount : Integer; Var VBytes: THsBytes; AByteIndex: Integer) : Integer; OverLoad;
    Function GetBytes(Const AChars : PHsWideChar; ACharCount : Integer) : THsBytes; OverLoad;
    Function GetBytes(Const AChars : PHsWideChar; ACharCount : Integer; Var VBytes: THsBytes; AByteIndex: Integer) : Integer; OverLoad;
    Function GetBytes(Const AChars : PHsWideChar; ACharCount : Integer; ABytes : PByte; AByteCount : Integer) : Integer; OverLoad;
    Function GetBytes(Const AStr : THsUnicodeString) : THsBytes; OverLoad;
    Function GetBytes(Const AStr : THsUnicodeString; ACharIndex, ACharCount : Integer) : THsBytes; OverLoad;
    Function GetBytes(Const AStr : THsUnicodeString; ACharIndex, ACharCount : Integer; Var VBytes: THsBytes; AByteIndex: Integer) : Integer; OverLoad;

    Function GetCharCount(Const ABytes : THsBytes) : Integer; OverLoad;
    Function GetCharCount(Const ABytes : THsBytes; AByteIndex, AByteCount : Integer) : Integer; OverLoad;
    Function GetCharCount(Const ABytes : PByte; AByteCount : Integer) : Integer; OverLoad;

    Function GetChars(Const ABytes : THsBytes) : THsWideChars; OverLoad;
    Function GetChars(Const ABytes : THsBytes; AByteIndex, AByteCount : Integer) : THsWideChars; OverLoad;
    Function GetChars(Const ABytes : THsBytes; AByteIndex, AByteCount : Integer; Var VChars: THsWideChars; ACharIndex : Integer) : Integer; OverLoad;
    Function GetChars(Const ABytes : PByte; AByteCount : Integer) : THsWideChars; OverLoad;
    Function GetChars(Const ABytes : PByte; AByteCount : Integer; Var VChars: THsWideChars; ACharIndex : Integer) : Integer; OverLoad;
    Function GetChars(Const ABytes : PByte; AByteCount : Integer; AChars : PHsWideChar; ACharCount : Integer) : Integer; OverLoad;

    Function GetMaxByteCount(ACharCount : Integer) : Integer;
    Function GetMaxCharCount(AByteCount : Integer) : Integer;
    Function GetPreamble() : THsBytes;
    Function Convert(ADestination: IHsEncoding; Const ABytes: THsBytes) : THsBytes; OverLoad;
    Function Convert(ADestination: IHsEncoding; Const ABytes: THsBytes;
      AStartIndex, ACount: Integer) : THsBytes; OverLoad;

    Function GetString(Const ABytes : THsBytes) : THsUnicodeString; OverLoad;
    Function GetString(Const ABytes : THsBytes; AByteIndex, AByteCount : Integer) : THsUnicodeString; OverLoad;
    Function GetString(Const ABytes : PByte; AByteCount : Integer) : THsUnicodeString; OverLoad;

    Function GetIsSingleByte() : Boolean;
    Function GetCodePage() : Cardinal;

    Function GetASCII() : IHsEncoding;
    Function GetBigEndianUnicode() : IHsEncoding;
    Function GetDefault() : IHsEncoding;
    Function GetUnicode() : IHsEncoding;
    Function GetUTF7() : IHsEncoding;
    Function GetUTF8() : IHsEncoding;

    Property IsSingleByte : Boolean  Read GetIsSingleByte;
    Property CodePage     : Cardinal Read GetCodePage;

    Property ASCII            : IHsEncoding Read GetASCII;
    Property BigEndianUnicode : IHsEncoding Read GetBigEndianUnicode;
    Property Default          : IHsEncoding Read GetDefault;
    Property Unicode          : IHsEncoding Read GetUnicode;
    Property UTF7             : IHsEncoding Read GetUTF7;
    Property UTF8             : IHsEncoding Read GetUTF8;

  End;

  THsEncoding = Class(TInterfacedObject, IHsEncoding)
  Protected
    FIsSingleByte : Boolean;
    FMaxCharSize  : Integer;

    Function GetByteCount(Const AChars : PHsWideChar; ACharCount : Integer) : Integer; OverLoad; Virtual; Abstract;
    Function GetBytes(Const AChars : PHsWideChar; ACharCount : Integer; ABytes : PByte; AByteCount : Integer) : Integer; OverLoad; Virtual; Abstract;
    Function GetCharCount(Const ABytes : PByte; AByteCount : Integer) : Integer; OverLoad; Virtual; Abstract;
    Function GetChars(Const ABytes : PByte; AByteCount : Integer; AChars : PHsWideChar; ACharCount : Integer) : Integer; OverLoad; Virtual; Abstract;

    Function GetIsSingleByte() : Boolean;
    Function GetCodePage() : Cardinal; Virtual;
    Function GetPreamble() : THsBytes; Virtual;

    Function GetASCII() : IHsEncoding;
    Function GetBigEndianUnicode() : IHsEncoding;
    Function GetDefault() : IHsEncoding;
    Function GetUnicode() : IHsEncoding;
    Function GetUTF7() : IHsEncoding;
    Function GetUTF8() : IHsEncoding;

  Public
    Function GetByteCount(Const AChars : THsWideChars) : Integer; OverLoad;
    Function GetByteCount(Const AChars : THsWideChars; ACharIndex, ACharCount : Integer) : Integer; OverLoad;
    Function GetByteCount(Const AStr : THsUnicodeString) : Integer; OverLoad;
    Function GetByteCount(Const AStr : THsUnicodeString; ACharIndex, ACharCount : Integer) : Integer; OverLoad;

    Function GetBytes(Const AChars : THsWideChars) : THsBytes; OverLoad;
    Function GetBytes(Const AChars : THsWideChars; ACharIndex, ACharCount : Integer) : THsBytes; OverLoad;
    Function GetBytes(Const AChars : THsWideChars; ACharIndex, ACharCount : Integer; Var VBytes: THsBytes; AByteIndex: Integer) : Integer; OverLoad;
    Function GetBytes(Const AChars : PHsWideChar; ACharCount : Integer) : THsBytes; OverLoad;
    Function GetBytes(Const AChars : PHsWideChar; ACharCount : Integer; Var VBytes: THsBytes; AByteIndex: Integer) : Integer; OverLoad;
    Function GetBytes(Const AStr : THsUnicodeString) : THsBytes; OverLoad;
    Function GetBytes(Const AStr : THsUnicodeString; ACharIndex, ACharCount : Integer) : THsBytes; OverLoad;
    Function GetBytes(Const AStr : THsUnicodeString; ACharIndex, ACharCount : Integer; Var VBytes: THsBytes; AByteIndex: Integer) : Integer; OverLoad;

    Function GetCharCount(Const ABytes : THsBytes) : Integer; OverLoad;
    Function GetCharCount(Const ABytes : THsBytes; AByteIndex, AByteCount : Integer) : Integer; OverLoad;

    Function GetChars(Const ABytes : THsBytes) : THsWideChars; OverLoad;
    Function GetChars(Const ABytes : THsBytes; AByteIndex, AByteCount : Integer) : THsWideChars; OverLoad;
    Function GetChars(Const ABytes : THsBytes; AByteIndex, AByteCount : Integer; Var VChars: THsWideChars; ACharIndex : Integer) : Integer; OverLoad;
    Function GetChars(Const ABytes : PByte; AByteCount : Integer) : THsWideChars; OverLoad;
    Function GetChars(Const ABytes : PByte; AByteCount : Integer; Var VChars: THsWideChars; ACharIndex : Integer) : Integer; OverLoad;

    Function GetMaxByteCount(ACharCount : Integer) : Integer; Virtual; Abstract;
    Function GetMaxCharCount(AByteCount : Integer) : Integer; Virtual; Abstract;
    Function GetString(Const ABytes : THsBytes) : THsUnicodeString; OverLoad;
    Function GetString(Const ABytes : THsBytes; AByteIndex, AByteCount : Integer) : THsUnicodeString; OverLoad;
    Function GetString(Const ABytes : PByte; AByteCount : Integer) : THsUnicodeString; OverLoad;

    Class Function Convert(ASource, ADestination: IHsEncoding;
      Const ABytes: THsBytes) : THsBytes; OverLoad;
    Class Function Convert(ASource, ADestination: IHsEncoding;
      Const ABytes: THsBytes; AStartIndex, ACount: Integer) : THsBytes; OverLoad;
    Function Convert(ADestination: IHsEncoding;
      Const ABytes: THsBytes) : THsBytes; OverLoad;
    Function Convert(ADestination: IHsEncoding;
      Const ABytes: THsBytes; AStartIndex, ACount: Integer) : THsBytes; OverLoad;

    Class Function GetEncoding(ACodePage: Integer) : IHsEncoding;
    Class Function GetBufferEncoding(Const ABuffer : THsBytes; Out AEncoding : IHsEncoding) : Integer;

    Class Function ASCII() : IHsEncoding;
    Class Function BigEndianUnicode() : IHsEncoding;
    Class Function Default() : IHsEncoding;
    Class Function Unicode() : IHsEncoding;
    Class Function UTF7() : IHsEncoding;
    Class Function UTF8() : IHsEncoding;

  End;

  THsMBCSEncoding = Class(THsEncoding)
  Private
    FCodePage: Cardinal;
    FMBToWCharFlags: Cardinal;
    FWCharToMBFlags: Cardinal;

  Protected
    Function GetCodePage() : Cardinal; OverRide;
    Function GetPreamble() : THsBytes; OverRide;

  Public
    Function GetByteCount(Const AChars : PHsWideChar; ACharCount : Integer) : Integer; OverLoad; OverRide;
    Function GetBytes(Const AChars : PHsWideChar; ACharCount : Integer; ABytes : PByte; AByteCount : Integer) : Integer; OverLoad; OverRide;
    Function GetCharCount(Const ABytes : PByte; AByteCount : Integer) : Integer; OverLoad; OverRide;
    Function GetChars(Const ABytes : PByte; AByteCount : Integer; AChars : PHsWideChar; ACharCount : Integer) : Integer; OverLoad; OverRide;
    Function GetMaxByteCount(CharCount: Integer) : Integer; OverRide;
    Function GetMaxCharCount(ByteCount: Integer) : Integer; OverRide;

    Constructor Create(); OverLoad; Virtual;
    Constructor Create(CodePage: Integer); OverLoad; Virtual;
    Constructor Create(CodePage, MBToWCharFlags, WCharToMBFlags: Integer); OverLoad; Virtual;

  End;

  THsUTF7Encoding = Class(THsMBCSEncoding)
  Public
    Function GetByteCount(Const AChars : PHsWideChar; ACharCount : Integer) : Integer; OverLoad; OverRide;
    Function GetBytes(Const AChars : PHsWideChar; ACharCount : Integer; ABytes : PByte; AByteCount : Integer) : Integer; OverLoad; OverRide;
    Function GetCharCount(Const ABytes : PByte; AByteCount : Integer) : Integer; OverLoad; OverRide;
    Function GetChars(Const ABytes : PByte; AByteCount : Integer; AChars : PHsWideChar; ACharCount : Integer) : Integer; OverLoad; OverRide;
    Function GetMaxByteCount(CharCount: Integer) : Integer; OverRide;
    Function GetMaxCharCount(ByteCount: Integer) : Integer; OverRide;

    Constructor Create(); OverRide;

  End;

  THsUTF8Encoding = Class(THsUTF7Encoding)
  Protected
    Function GetPreamble() : THsBytes; OverRide;

  Public
    Function GetMaxByteCount(CharCount: Integer) : Integer; OverRide;
    Function GetMaxCharCount(ByteCount: Integer) : Integer; OverRide;

    Constructor Create(); OverRide;

  End;

  THsUTF16LittleEndianEncoding = Class(THsEncoding)
  Protected
    Function GetCodePage() : Cardinal; OverRide;
    Function GetPreamble() : THsBytes; OverRide;

  Public
    Function GetByteCount(Const AChars : PHsWideChar; ACharCount : Integer) : Integer; OverLoad; OverRide;
    Function GetBytes(Const AChars : PHsWideChar; ACharCount : Integer; ABytes : PByte; AByteCount : Integer) : Integer; OverLoad; OverRide;
    Function GetCharCount(Const ABytes : PByte; AByteCount : Integer) : Integer; OverLoad; OverRide;
    Function GetChars(Const ABytes : PByte; AByteCount : Integer; AChars : PHsWideChar; ACharCount : Integer) : Integer; OverLoad; OverRide;
    Function GetMaxByteCount(CharCount: Integer) : Integer; OverRide;
    Function GetMaxCharCount(ByteCount: Integer) : Integer; OverRide;

    Constructor Create(); Virtual;

  End;

  THsUTF16BigEndianEncoding = Class(THsUTF16LittleEndianEncoding)
  Protected
    Function GetCodePage() : Cardinal; OverRide;
    Function GetPreamble() : THsBytes; OverRide;

  Public
    Function GetBytes(Const AChars : PHsWideChar; ACharCount : Integer; ABytes : PByte; AByteCount : Integer) : Integer; OverLoad; OverRide;
    Function GetChars(Const ABytes : PByte; AByteCount : Integer; AChars : PHsWideChar; ACharCount : Integer) : Integer; OverLoad; OverRide;

  End;

  THsASCIIEncoding = Class(THsEncoding)
  Public
    Function GetByteCount(Const AChars : PHsWideChar; ACharCount : Integer) : Integer; OverRide;
    Function GetBytes(Const AChars : PHsWideChar; ACharCount : Integer; ABytes : PByte; AByteCount : Integer) : Integer; OverRide;
    Function GetCharCount(Const ABytes : PByte; AByteCount : Integer) : Integer; OverRide;
    Function GetChars(Const ABytes : PByte; AByteCount : Integer; AChars : PHsWideChar; ACharCount : Integer) : Integer; OverRide;
    Function GetMaxByteCount(ACharCount : Integer) : Integer; OverRide;
    Function GetMaxCharCount(AByteCount : Integer) : Integer; OverRide;

    Constructor Create(); Virtual;

  End;

  THs8BitEncoding = Class(THsEncoding)
  Public
    Function GetByteCount(Const AChars : PHsWideChar; ACharCount : Integer) : Integer; OverRide;
    Function GetBytes(Const AChars : PHsWideChar; ACharCount : Integer; ABytes : PByte; AByteCount : Integer) : Integer; OverRide;
    Function GetCharCount(Const ABytes : PByte; AByteCount : Integer) : Integer; OverRide;
    Function GetChars(Const ABytes : PByte; AByteCount : Integer; AChars : PHsWideChar; ACharCount : Integer) : Integer; OverRide;
    Function GetMaxByteCount(ACharCount : Integer) : Integer; OverRide;
    Function GetMaxCharCount(AByteCount : Integer) : Integer; OverRide;

    Constructor Create(); Virtual;

  End;

Implementation

Uses Math;

Resourcestring
  RSInvalidSourceArray = 'Invalid source array';
  RSInvalidDestinationArray = 'Invalid destination array';
  RSCharIndexOutOfBounds = 'Character index out of bounds (%d)';
  RSInvalidCharCount = 'Invalid count (%d)';
  RSInvalidDestinationIndex = 'Invalid destination index (%d)';

  RSInvalidCodePage = 'Invalid codepage (%d)';
  RSInvalidCharSet  = 'Invalid character set (%s)';
  RSInvalidCharSetConv = 'Invalid character set conversion (%s <-> %s)';
  RSInvalidCharSetConvWithFlags = 'Invalid character set conversion (%s <-> %s, %s)';

Function ValidateChars(Const AChars : THsWideChars; ACharIndex, ACharCount : Integer) : PHsWideChar;
Var Len : Integer;
Begin
  Len := Length(AChars);
  If (ACharIndex < 0) Or (ACharIndex >= Len) Then
    Raise Exception.CreateResFmt(@RSCharIndexOutOfBounds, [ACharIndex]);

  If ACharCount < 0 Then
    Raise Exception.CreateResFmt(@RSInvalidCharCount, [ACharCount]);

  If (Len - ACharIndex) < ACharCount Then
    Raise Exception.CreateResFmt(@RSInvalidCharCount, [ACharCount]);

  If ACharCount > 0 Then
    Result := @AChars[ACharIndex]
  Else
    Result := Nil;
End;

Function ValidateBytes(Const ABytes : THsBytes; AByteIndex, AByteCount : Integer) : PByte; OverLoad;
Var Len : Integer;
Begin
  Len := Length(ABytes);
  If (AByteIndex < 0) Or (AByteIndex >= Len) Then
    Raise Exception.CreateResFmt(@RSInvalidDestinationIndex, [AByteIndex]);

  If (Len - AByteIndex) < AByteCount Then
    Raise Exception.CreateRes(@RSInvalidDestinationArray);

  If AByteCount > 0 Then
    Result := @ABytes[AByteIndex]
  Else
    Result := Nil;
End;

Function ValidateBytes(Const ABytes : THsBytes; AByteIndex, AByteCount, ANeeded: Integer) : PByte; OverLoad;
Var Len : Integer;
Begin
  Len := Length(ABytes);
  If (AByteIndex < 0) Or (AByteIndex >= Len) Then
    Raise Exception.CreateResFmt(@RSInvalidDestinationIndex, [AByteIndex]);

  If (Len - AByteIndex) < ANeeded Then
    Raise Exception.CreateRes(@RSInvalidDestinationArray);

  If AByteCount > 0 Then
    Result := @ABytes[AByteIndex]
  Else
    Result := Nil;
End;

Function ValidateStr(Const AStr : THsUnicodeString; ACharIndex, ACharCount : Integer) : PHsWideChar;
Begin
  If ACharIndex < 1 Then
    Raise Exception.CreateResFmt(@RSCharIndexOutOfBounds, [ACharIndex]);

  If ACharCount < 0 Then
    Raise Exception.CreateResFmt(@RSInvalidCharCount, [ACharCount]);

  If (Length(AStr) - ACharIndex + 1) < ACharCount Then
    Raise Exception.CreateResFmt(@RSInvalidCharCount, [ACharCount]);

  If ACharCount > 0 Then
    Result := @AStr[ACharIndex]
  Else
    Result := Nil;
End;

(******************************************************************************)

Class Function THsEncoding.GetEncoding(ACodePage: Integer) : IHsEncoding;
Begin
  Case ACodePage Of
    1200:  Result := THsUTF16LittleEndianEncoding.Create();
    1201:  Result := THsUTF16BigEndianEncoding.Create();
    65000: Result := THsUTF7Encoding.Create();
    20127: Result := THsASCIIEncoding.Create();
    65001: Result := THsUTF8Encoding.Create();

    Else
      Result := THsMBCSEncoding.Create(ACodePage);
  End;
End;

Class Function THsEncoding.GetBufferEncoding(Const ABuffer : THsBytes; Out AEncoding : IHsEncoding) : Integer;
  Function ContainsPreamble(Const Buffer, Signature : THsBytes): Boolean;
  Var X : Integer;
  Begin
    If Length(Buffer) >= Length(Signature) Then
    Begin
      Result := True;
      For X := 0 To Length(Signature)-1 Do
      Begin
        If Buffer[X] <> Signature[X] Then
        Begin
          Result := False;
          Break;
        End;
      End;
    End
    Else
      Result := False;
  End;

Var Preamble : THsBytes;
Begin
  Result := 0;
  If AEncoding = Nil Then
  Begin
    // Find the appropriate encoding
    If ContainsPreamble(ABuffer, Unicode().GetPreamble()) Then
      AEncoding := Unicode()
    Else If ContainsPreamble(ABuffer, BigEndianUnicode().GetPreamble()) Then
      AEncoding := BigEndianUnicode()
    Else If ContainsPreamble(ABuffer, UTF8().GetPreamble()) Then
      AEncoding := UTF8()
    Else
      AEncoding := Default();

    Result := Length(AEncoding.GetPreamble());
  End
  Else
  Begin
    Preamble := AEncoding.GetPreamble();
    If ContainsPreamble(ABuffer, Preamble) Then
      Result := Length(Preamble);
  End;
End;

Class Function THsEncoding.ASCII() : IHsEncoding;
Begin
  Result := THsASCIIEncoding.Create();
End;

Class Function THsEncoding.BigEndianUnicode() : IHsEncoding;
Begin
  Result := THsUTF16BigEndianEncoding.Create();
End;

Class Function THsEncoding.Default() : IHsEncoding;
Begin
  Result := THsMBCSEncoding.Create();
End;

Class Function THsEncoding.Unicode() : IHsEncoding;
Begin
  Result := THsUTF16LittleEndianEncoding.Create();
End;

Class Function THsEncoding.UTF7() : IHsEncoding;
Begin
  Result := THsUTF7Encoding.Create();
End;

Class Function THsEncoding.UTF8() : IHsEncoding;
Begin
  Result := THsUTF8Encoding.Create(CP_UTF8, 0, 0);
End;

Function THsEncoding.GetByteCount(Const AChars : THsWideChars) : Integer;
Begin
  If AChars <> Nil Then
    Result := GetByteCount(PHsWideChar(AChars), Length(AChars))
  Else
    Result := 0;
End;

Function THsEncoding.GetByteCount(Const AChars : THsWideChars;
  ACharIndex, ACharCount : Integer) : Integer;
Var
  LChars: PHsWideChar;
Begin
  LChars := ValidateChars(AChars, ACharIndex, ACharCount);
  If LChars <> Nil Then
    Result := GetByteCount(LChars, ACharCount)
  Else
    Result := 0;
End;

Function THsEncoding.GetByteCount(Const AStr : THsUnicodeString) : Integer;
Begin
  If AStr <> '' Then
    Result := GetByteCount(PHsWideChar(AStr), Length(AStr))
  Else
    Result := 0;
End;

Function THsEncoding.GetByteCount(Const AStr : THsUnicodeString; ACharIndex, ACharCount : Integer) : Integer;
Var LChars : PHsWideChar;
Begin
  LChars := ValidateStr(AStr, ACharIndex, ACharCount);
  If LChars <> Nil Then
    Result := GetByteCount(LChars, ACharCount)
  Else
    Result := 0;
End;

Function THsEncoding.GetBytes(Const AChars : THsWideChars) : THsBytes;
Begin
  If AChars <> Nil Then
    Result := GetBytes(PHsWideChar(AChars), Length(AChars))
  Else
    Result := Nil;
End;

Function THsEncoding.GetBytes(Const AChars : THsWideChars;
  ACharIndex, ACharCount : Integer) : THsBytes;
Var Len : Integer;
Begin
  Len := GetByteCount(AChars, ACharIndex, ACharCount);
  If Len > 0 Then
  Begin
    SetLength(Result, Len);
    GetBytes(@AChars[ACharIndex], ACharCount, PByte(Result), Len);
  End
  Else
    Result := Nil;
End;

Function THsEncoding.GetBytes(Const AChars : THsWideChars;
  ACharIndex, ACharCount : Integer; Var VBytes: THsBytes; AByteIndex: Integer) : Integer;
Begin
  Result := GetBytes(
    ValidateChars(AChars, ACharIndex, ACharCount),
    ACharCount, VBytes, AByteIndex);
End;

Function THsEncoding.GetBytes(Const AChars : PHsWideChar; ACharCount : Integer) : THsBytes;
Var Len : Integer;
Begin
  Len := GetByteCount(AChars, ACharCount);
  If Len > 0 Then
  Begin
    SetLength(Result, Len);
    GetBytes(AChars, ACharCount, PByte(Result), Len);
  End
  Else
    Result := Nil;
End;

Function THsEncoding.GetBytes(Const AChars : PHsWideChar; ACharCount : Integer;
  Var VBytes: THsBytes; AByteIndex: Integer) : Integer;
Var Len        ,
    LByteCount : Integer;
    LBytes     : PByte;
Begin
  If (AChars = Nil) And (ACharCount <> 0) Then
    Raise Exception.CreateRes(@RSInvalidSourceArray);

  If (VBytes = Nil) And (ACharCount <> 0) Then
    Raise Exception.CreateRes(@RSInvalidDestinationArray);

  If ACharCount < 0 Then
    Raise Exception.CreateResFmt(@RSInvalidCharCount, [ACharCount]);

  Len        := Length(VBytes);
  LByteCount := GetByteCount(AChars, ACharCount);
  LBytes     := ValidateBytes(VBytes, AByteIndex, Len, LByteCount);
  Dec(Len, AByteIndex);

  If (ACharCount > 0) And (Len > 0) Then
    Result := GetBytes(AChars, ACharCount, LBytes, LByteCount)
  Else
    Result := 0;
End;

Function THsEncoding.GetBytes(Const AStr : THsUnicodeString) : THsBytes;
Var Len : Integer;
Begin
  Len := GetByteCount(AStr);
  If Len > 0 Then
  Begin
    SetLength(Result, Len);
    GetBytes(PHsWideChar(AStr), Length(AStr), PByte(Result), Len);
  End
  Else
    Result := Nil;
End;

Function THsEncoding.GetBytes(Const AStr : THsUnicodeString; ACharIndex, ACharCount : Integer) : THsBytes;
Var Len    : Integer;
    LChars : PHsWideChar;
Begin
  LChars := ValidateStr(AStr, ACharIndex, ACharCount);
  If LChars <> Nil Then
  Begin
    Len := GetByteCount(LChars, ACharCount);
    If Len > 0 Then
    Begin
      SetLength(Result, Len);
      GetBytes(LChars, ACharCount, PByte(Result), Len);
    End;
  End
  Else
    Result := Nil;
End;

Function THsEncoding.GetBytes(Const AStr : THsUnicodeString; ACharIndex, ACharCount : Integer;
  Var VBytes: THsBytes; AByteIndex: Integer) : Integer;
Var LChars : PHsWideChar;
Begin
  LChars := ValidateStr(AStr, ACharIndex, ACharCount);
  If LChars <> Nil Then
    Result := GetBytes(LChars, ACharCount, VBytes, AByteIndex)
  Else
    Result := 0;
End;

Function THsEncoding.GetCharCount(Const ABytes : THsBytes) : Integer;
Begin
  If ABytes <> Nil Then
    Result := GetCharCount(PByte(ABytes), Length(ABytes))
  Else
    Result := 0;
End;

Function THsEncoding.GetCharCount(Const ABytes : THsBytes; AByteIndex, AByteCount : Integer) : Integer;
Var LBytes : PByte;
Begin
  LBytes := ValidateBytes(ABytes, AByteIndex, AByteCount);
  If LBytes <> Nil Then
    Result := GetCharCount(LBytes, AByteCount)
  Else
    Result := 0;
End;

Function THsEncoding.GetChars(Const ABytes : THsBytes) : THsWideChars;
Begin
  If ABytes <> Nil Then
    Result := GetChars(PByte(ABytes), Length(ABytes))
  Else
    Result := Nil;
End;

Function THsEncoding.GetChars(Const ABytes : THsBytes; AByteIndex, AByteCount : Integer) : THsWideChars;
Var Len : Integer;
Begin
  Len := GetCharCount(ABytes, AByteIndex, AByteCount);
  If Len > 0 Then
  Begin
    SetLength(Result, Len);
    GetChars(@ABytes[AByteIndex], AByteCount, PHsWideChar(Result), Len);
  End
  Else
    Result := Nil;
End;

Function THsEncoding.GetChars(Const ABytes : THsBytes;
  AByteIndex, AByteCount : Integer; Var VChars: THsWideChars; ACharIndex : Integer) : Integer;
Var LBytes : PByte;
Begin
  LBytes := ValidateBytes(ABytes, AByteIndex, AByteCount);
  If LBytes <> Nil Then
    Result := GetChars(LBytes, AByteCount, VChars, ACharIndex)
  Else
    Result := 0;
End;

Function THsEncoding.GetChars(Const ABytes : PByte; AByteCount : Integer) : THsWideChars;
Var Len : Integer;
Begin
  Len := GetCharCount(ABytes, AByteCount);
  If Len > 0 Then
  Begin
    SetLength(Result, Len);
    GetChars(ABytes, AByteCount, PHsWideChar(Result), Len);
  End
  Else
    Result := Nil;
End;

Function THsEncoding.GetChars(Const ABytes : PByte; AByteCount : Integer;
  Var VChars: THsWideChars; ACharIndex : Integer) : Integer;
Var LCharCount : Integer;
Begin
  If (ABytes = Nil) And (AByteCount <> 0) Then
    Raise Exception.CreateRes(@RSInvalidSourceArray);

  If AByteCount < 0 Then
    Raise Exception.CreateResFmt(@RSInvalidCharCount, [AByteCount]);

  If (ACharIndex < 0) Or (ACharIndex > Length(VChars)) Then
    Raise Exception.CreateResFmt(@RSInvalidDestinationIndex, [ACharIndex]);

  LCharCount := GetCharCount(ABytes, AByteCount);
  If LCharCount > 0 Then
  Begin
    If (ACharIndex + LCharCount) > Length(VChars) Then
      Raise Exception.CreateRes(@RSInvalidDestinationArray);

    Result := GetChars(ABytes, AByteCount, @VChars[ACharIndex], LCharCount);
  End
  Else
    Result := 0;
End;

Function THsEncoding.GetIsSingleByte() : Boolean;
Begin
  Result := FIsSingleByte;
End;

Function THsEncoding.GetCodePage() : Cardinal;
Begin
  Result := Cardinal(-1);
End;

Function THsEncoding.GetASCII() : IHsEncoding;
Begin
  Result := THsEncoding.ASCII;
End;

Function THsEncoding.GetBigEndianUnicode() : IHsEncoding;
Begin
  Result := THsEncoding.BigEndianUnicode;
End;

Function THsEncoding.GetDefault() : IHsEncoding;
Begin
  Result := THsEncoding.Default;
End;

Function THsEncoding.GetUnicode() : IHsEncoding;
Begin
  Result := THsEncoding.Unicode;
End;

Function THsEncoding.GetUTF7() : IHsEncoding;
Begin
  Result := THsEncoding.UTF7;
End;

Function THsEncoding.GetUTF8() : IHsEncoding;
Begin
  Result := THsEncoding.UTF8;
End;

Function THsEncoding.GetPreamble() : THsBytes;
Begin
  SetLength(Result, 0);
End;

Class Function THsEncoding.Convert(ASource, ADestination: IHsEncoding;
  Const ABytes: THsBytes) : THsBytes;
Begin
  Result := ADestination.GetBytes(ASource.GetChars(ABytes));
End;

Class Function THsEncoding.Convert(ASource, ADestination: IHsEncoding;
  Const ABytes: THsBytes; AStartIndex, ACount : Integer): THsBytes;
Begin
  Result := ADestination.GetBytes(ASource.GetChars(ABytes, AStartIndex, ACount));
End;

Function THsEncoding.Convert(ADestination: IHsEncoding; Const ABytes: THsBytes) : THsBytes;
Begin
  Convert(Self, ADestination, ABytes);
End;

Function THsEncoding.Convert(ADestination: IHsEncoding; Const ABytes: THsBytes;
  AStartIndex, ACount: Integer) : THsBytes;
Begin
  Convert(Self, ADestination, ABytes, AStartIndex, ACount);
End;

Function THsEncoding.GetString(Const ABytes : THsBytes) : THsUnicodeString;
Begin
  If ABytes <> Nil Then
    Result := GetString(PByte(ABytes), Length(ABytes))
  Else
    Result := '';
End;

Function THsEncoding.GetString(Const ABytes : THsBytes;
  AByteIndex, AByteCount : Integer) : THsUnicodeString;
Var Len : Integer;
Begin
  Len := GetCharCount(ABytes, AByteIndex, AByteCount);
  If Len > 0 Then
  Begin
    SetLength(Result, Len);
    GetChars(@ABytes[AByteIndex], AByteCount, PHsWideChar(Result), Len);
  End
  Else
    Result := '';
End;

Function THsEncoding.GetString(Const ABytes : PByte; AByteCount : Integer) : THsUnicodeString;
Var Len : Integer;
Begin
  Len := GetCharCount(ABytes, AByteCount);
  If Len > 0 Then
  Begin
    SetLength(Result, Len);
    GetChars(ABytes, AByteCount, PHsWideChar(Result), Len);
  End
  Else
    Result := '';
End;

Constructor THsMBCSEncoding.Create();
Begin
  Create(CP_ACP, 0, 0);
End;

Constructor THsMBCSEncoding.Create(CodePage: Integer);
Begin
  Create(CodePage, 0, 0);
End;

Constructor THsMBCSEncoding.Create(CodePage, MBToWCharFlags, WCharToMBFlags: Integer);
Var LCPInfo : TCPInfo;
    LError  : Boolean;
Begin
  FCodePage := CodePage;
  FMBToWCharFlags := MBToWCharFlags;
  FWCharToMBFlags := WCharToMBFlags;

  LError := Not GetCPInfo(FCodePage, LCPInfo);
  If LError And (FCodePage = 20127) Then
  Begin
    FCodePage := 1252;
    LError := Not GetCPInfo(FCodePage, LCPInfo);

    If LError Then
    Begin
      FCodePage := 437;
      LError := Not GetCPInfo(FCodePage, LCPInfo);
    End;
  End;

  If LError Then
    Raise Exception.CreateResFmt(@RSInvalidCodePage, [FCodePage]);

  FMaxCharSize := LCPInfo.MaxCharSize;
  FIsSingleByte := (FMaxCharSize = 1);
End;

Function THsMBCSEncoding.GetByteCount(Const AChars : PHsWideChar; ACharCount : Integer) : Integer;
Begin
  Result := WideCharToMultiByte(FCodePage, FWCharToMBFlags, AChars, ACharCount, Nil, 0, Nil, Nil);
End;

Function THsMBCSEncoding.GetBytes(Const AChars : PHsWideChar; ACharCount : Integer; ABytes : PByte;
  AByteCount : Integer) : Integer;
Begin
  Result := WideCharToMultiByte(FCodePage, FWCharToMBFlags, AChars, ACharCount, PAnsiChar(ABytes), AByteCount, Nil, Nil);
End;

Function THsMBCSEncoding.GetCharCount(Const ABytes : PByte; AByteCount : Integer) : Integer;
Begin
  Result := MultiByteToWideChar(FCodePage, FMBToWCharFlags, PAnsiChar(ABytes), AByteCount, Nil, 0);
End;

Function THsMBCSEncoding.GetChars(Const ABytes : PByte; AByteCount : Integer; AChars: PWideChar;
  ACharCount : Integer) : Integer;
Begin
  Result := MultiByteToWideChar(FCodePage, FMBToWCharFlags, PAnsiChar(ABytes), AByteCount, AChars, ACharCount);
End;

Function THsMBCSEncoding.GetMaxByteCount(CharCount: Integer) : Integer;
Begin
  Result := (CharCount + 1) * FMaxCharSize;
End;

Function THsMBCSEncoding.GetMaxCharCount(ByteCount: Integer) : Integer;
Begin
  Result := ByteCount;
End;

Function THsMBCSEncoding.GetCodePage() : Cardinal;
Begin
  Result := FCodePage;
End;

Function THsMBCSEncoding.GetPreamble() : THsBytes;
Begin
  Case FCodePage Of
    CP_UTF8 :
    Begin
      SetLength(Result, 3);
      Result[0] := $EF;
      Result[1] := $BB;
      Result[2] := $BF;
    End;

    1200 :
    Begin
      SetLength(Result, 2);
      Result[0] := $FF;
      Result[1] := $FE;
    End;

    1201 :
    Begin
      SetLength(Result, 2);
      Result[0] := $FE;
      Result[1] := $FF;
    End;

    Else
      SetLength(Result, 0);
  End;
End;

Constructor THsUTF7Encoding.Create();
Begin
  Inherited Create(CP_UTF7);
End;

Function THsUTF7Encoding.GetByteCount(Const AChars : PHsWideChar; ACharCount : Integer) : Integer;
Begin
  Result := Inherited GetByteCount(AChars, ACharCount);
End;

Function THsUTF7Encoding.GetBytes(Const AChars : PHsWideChar; ACharCount : Integer;
  ABytes : PByte; AByteCount : Integer) : Integer;
Begin
  Result := Inherited GetBytes(AChars, ACharCount, ABytes, AByteCount);
End;

Function THsUTF7Encoding.GetCharCount(Const ABytes : PByte; AByteCount : Integer) : Integer;
Begin
  Result := Inherited GetCharCount(ABytes, AByteCount);
End;

Function THsUTF7Encoding.GetChars(Const ABytes : PByte; AByteCount : Integer;
  AChars : PHsWideChar; ACharCount : Integer) : Integer;
Begin
  Result := Inherited GetChars(ABytes, AByteCount, AChars, ACharCount);
End;

Function THsUTF7Encoding.GetMaxByteCount(CharCount: Integer) : Integer;
Begin
  Result := (CharCount * 3) + 2;
End;

Function THsUTF7Encoding.GetMaxCharCount(ByteCount: Integer) : Integer;
Begin
  Result := ByteCount;
End;

Constructor THsUTF8Encoding.Create();
Begin
  Inherited Create(CP_UTF8, 0, 0);
End;

Function THsUTF8Encoding.GetMaxByteCount(CharCount: Integer) : Integer;
Begin
  Result := (CharCount + 1) * 3;
End;

Function THsUTF8Encoding.GetMaxCharCount(ByteCount: Integer) : Integer;
Begin
  Result := ByteCount + 1;
End;

Function THsUTF8Encoding.GetPreamble() : THsBytes;
Begin
  SetLength(Result, 3);
  Result[0] := $EF;
  Result[1] := $BB;
  Result[2] := $BF;
End;

Constructor THsUTF16LittleEndianEncoding.Create();
Begin
  FIsSingleByte := False;
  FMaxCharSize  := 4;
End;

Function THsUTF16LittleEndianEncoding.GetByteCount(Const AChars : PHsWideChar; ACharCount : Integer) : Integer;
Begin
  Result := ACharCount * SizeOf(Widechar);
End;

Function THsUTF16LittleEndianEncoding.GetBytes(Const AChars : PHsWideChar; ACharCount : Integer;
  ABytes : PByte; AByteCount : Integer) : Integer;
Begin
  Result := ACharCount * SizeOf(Widechar);
  Move(AChars^, ABytes^, Result);
End;

Function THsUTF16LittleEndianEncoding.GetCharCount(Const ABytes : PByte; AByteCount : Integer) : Integer;
Begin
  Result := AByteCount Div SizeOf(Widechar);
End;

Function THsUTF16LittleEndianEncoding.GetChars(Const ABytes : PByte; AByteCount : Integer;
  AChars : PHsWideChar; ACharCount : Integer) : Integer;
Begin
  Result := AByteCount Div SizeOf(Widechar);
  Move(ABytes^, AChars^, Result * SizeOf(Widechar));
End;

Function THsUTF16LittleEndianEncoding.GetMaxByteCount(CharCount: Integer) : Integer;
Begin
  Result := (CharCount + 1) * 2;
End;

Function THsUTF16LittleEndianEncoding.GetMaxCharCount(ByteCount: Integer) : Integer;
Begin
  Result := (ByteCount Div SizeOf(Widechar)) + (ByteCount And 1) + 1;
End;

Function THsUTF16LittleEndianEncoding.GetCodePage() : Cardinal;
Begin
  Result := 1200; // UTF-16LE
End;

Function THsUTF16LittleEndianEncoding.GetPreamble() : THsBytes;
Begin
  SetLength(Result, 2);
  Result[0] := $FF;
  Result[1] := $FE;
End;

Function THsUTF16BigEndianEncoding.GetBytes(Const AChars : PHsWideChar; ACharCount : Integer;
  ABytes : PByte; AByteCount : Integer) : Integer;
Var I : Integer;
    P : PHsWideChar;
Begin
  P := AChars;
  For I := ACharCount - 1 Downto 0 Do
  Begin
    ABytes^ := Hi(Word(P^));
    Inc(ABytes);
    ABytes^ := Lo(Word(P^));
    Inc(ABytes);
    Inc(P);
  End;
  Result := ACharCount * SizeOf(Widechar);
End;

Function THsUTF16BigEndianEncoding.GetChars(Const ABytes : PByte; AByteCount : Integer;
  AChars : PHsWideChar; ACharCount : Integer) : Integer;
Var P1 ,
    P2 : PByte;
    I  : Integer;
Begin
  P1 := ABytes;
  P2 := P1;
  Inc(P1);
  For I := 0 To ACharCount - 1 Do
  Begin
    AChars^ := Widechar(MakeWord(P1^, P2^));
    Inc(P2, 2);
    Inc(P1, 2);
    Inc(AChars);
  End;
  Result := ACharCount;
End;

Function THsUTF16BigEndianEncoding.GetCodePage() : Cardinal;
Begin
  Result := 1201; // UTF-16BE
End;

Function THsUTF16BigEndianEncoding.GetPreamble() : THsBytes;
Begin
  SetLength(Result, 2);
  Result[0] := $FE;
  Result[1] := $FF;
End;

Constructor THsASCIIEncoding.Create();
Begin
  FIsSingleByte := True;
  FMaxCharSize  := 1;
End;

Function THsASCIIEncoding.GetByteCount(Const AChars : PHsWideChar; ACharCount : Integer) : Integer;
Begin
  Result := ACharCount;
End;

Function THsASCIIEncoding.GetBytes(Const AChars : PHsWideChar; ACharCount : Integer;
  ABytes : PByte; AByteCount : Integer) : Integer;
Var P : PHsWideChar;
    i : Integer;
Begin
  P := AChars;
  Result := Min(ACharCount, AByteCount);
  For i := 1 To Result Do
  Begin
    If Word(P^) > $007F Then
      ABytes^ := Byte(Ord('?'))
    Else
      ABytes^ := Byte(P^);

    Inc(P);
    Inc(ABytes);
  End;
End;

Function THsASCIIEncoding.GetCharCount(Const ABytes : PByte; AByteCount : Integer) : Integer;
Begin
  Result := AByteCount;
End;

Function THsASCIIEncoding.GetChars(Const ABytes : PByte; AByteCount : Integer;
  AChars : PHsWideChar; ACharCount : Integer) : Integer;
Var P : PByte;
    i : Integer;
Begin
  P := ABytes;
  Result := Min(ACharCount, AByteCount);
  For i := 1 To Result Do
  Begin
    If P^ > $7F Then
      Word(AChars^) := $FFFD
    Else
      Word(AChars^) := P^;

    Inc(AChars);
    Inc(P);
  End;
End;

Function THsASCIIEncoding.GetMaxByteCount(ACharCount : Integer) : Integer;
Begin
  Result := ACharCount;
End;

Function THsASCIIEncoding.GetMaxCharCount(AByteCount : Integer) : Integer;
Begin
  Result := AByteCount;
End;

Constructor THs8BitEncoding.Create();
Begin
  FIsSingleByte := True;
  FMaxCharSize  := 1;
End;

Function THs8BitEncoding.GetByteCount(Const AChars : PHsWideChar; ACharCount : Integer) : Integer;
Begin
  Result := ACharCount;
End;

Function THs8BitEncoding.GetBytes(Const AChars : PHsWideChar; ACharCount : Integer;
  ABytes : PByte; AByteCount : Integer) : Integer;
Var P : PHsWideChar;
    i : Integer;
Begin
  P := AChars;
  Result := Min(ACharCount, AByteCount);
  For i := 1 To Result Do
  Begin
    If Word(P^) > $00FF Then
      ABytes^ := Byte(Ord('?'))
    Else
      ABytes^ := Byte(P^);

    Inc(P);
    Inc(ABytes);
  End;
End;

Function THs8BitEncoding.GetCharCount(Const ABytes : PByte; AByteCount : Integer) : Integer;
Begin
  Result := AByteCount;
End;

Function THs8BitEncoding.GetChars(Const ABytes : PByte; AByteCount : Integer;
  AChars : PHsWideChar; ACharCount : Integer) : Integer;
Var P : PByte;
    i : Integer;
Begin
  P := ABytes;
  Result := Min(ACharCount, AByteCount);
  For i := 1 To Result Do
  Begin
    Word(AChars^) := P^;

    Inc(AChars);
    Inc(P);
  End;
End;

Function THs8BitEncoding.GetMaxByteCount(ACharCount : Integer) : Integer;
Begin
  Result := ACharCount;
End;

Function THs8BitEncoding.GetMaxCharCount(AByteCount : Integer) : Integer;
Begin
  Result := AByteCount;
End;

End.
