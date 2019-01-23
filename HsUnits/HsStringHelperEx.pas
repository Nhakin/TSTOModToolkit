unit HsStringHelperEx;

interface

Uses SysUtils, Classes, Dialogs;

Type
{$Region ' AdvancedRecords '}
  IntegerEx = Record
  Strict Private
    FInt : Integer;

  Public
    Const
      MaxValue = 2147483647;
      MinValue = -2147483648;

    Class Operator Implicit(AInteger : Integer) : IntegerEx;
    Class Operator Implicit(AInteger : IntegerEx) : Integer;
    Class Operator Implicit(AInteger : IntegerEx) : Single;
    Class Operator Implicit(AInteger : IntegerEx) : Double;
    Class Operator Implicit(AInteger : IntegerEx) : Extended;

    Class Operator Add(ALeftOp : Integer; ARightOp : IntegerEx) : IntegerEx;
    Class Operator Add(ALeftOp : IntegerEx; ARightOp : Integer) : IntegerEx;
    Class Operator Subtract(ALeftOp : Integer; ARightOp : IntegerEx) : IntegerEx;
    Class Operator Subtract(ALeftOp : IntegerEx; ARightOp : Integer) : IntegerEx;
    Class Operator Multiply(ALeftOp : Integer; ARightOp : IntegerEx) : IntegerEx;
    Class Operator Multiply(ALeftOp : IntegerEx; ARightOp : Integer) : IntegerEx;
    Class Operator Divide(ALeftOp : Integer; ARightOp : IntegerEx) : Double;
    Class Operator Divide(ALeftOp : IntegerEx; ARightOp : Integer) : Double;
    Class Operator IntDivide(ALeftOp : Integer; ARightOp : IntegerEx) : IntegerEx;
    Class Operator IntDivide(ALeftOp : IntegerEx; ARightOp : Integer) : IntegerEx;
    Class Operator Modulus(ALeftOp : Integer; ARightOp : IntegerEx) : IntegerEx;
    Class Operator Modulus(ALeftOp : IntegerEx; ARightOp : Integer) : IntegerEx;
    Class Operator LeftShift(ALeftOp : Integer; ARightOp : IntegerEx) : IntegerEx;
    Class Operator LeftShift(ALeftOp : IntegerEx; ARightOp : Integer) : IntegerEx;
    Class Operator RightShift(ALeftOp : Integer; ARightOp : IntegerEx) : IntegerEx;
    Class Operator RightShift(ALeftOp : IntegerEx; ARightOp : Integer) : IntegerEx;

    Class Operator Negative(AInteger : IntegerEx) : IntegerEx;
    Class Operator Positive(AInteger : IntegerEx) : IntegerEx;
    Class Operator Inc(AInteger : IntegerEx) : IntegerEx;
    Class Operator Dec(AInteger : IntegerEx) : IntegerEx;

    Class Operator LogicalNot(AInteger : IntegerEx) : IntegerEx;
    Class Operator LogicalAnd(ALeftOp : Integer; ARightOp : Integer) : IntegerEx;
    Class Operator LogicalOr(ALeftOp : Integer; ARightOp : Integer) : IntegerEx;
    Class Operator LogicalXor(ALeftOp : Integer; ARightOp : Integer) : IntegerEx;

    Class Operator Equal(ALeftOp : Integer; ARightOp : Integer): Boolean;
    Class Operator NotEqual(ALeftOp : Integer; ARightOp : Integer): Boolean;
    Class Operator GreaterThan(ALeftOp : Integer; ARightOp : Integer): Boolean;
    Class Operator GreaterThanOrEqual(ALeftOp : Integer; ARightOp : Integer): Boolean;
    Class Operator LessThan(ALeftOp : Integer; ARightOp : Integer): Boolean;
    Class Operator LessThanOrEqual(ALeftOp : Integer; ARightOp : Integer): Boolean;

    Constructor Create(Const AInteger : Integer); 

  End;

  DoubleEx = Record
  Strict Private
    FDouble : Double;

  Public
    Const
      Epsilon : Double = 4.9406564584124654418e-324;
      MaxValue : Double = 1.7976931348623157081e+308;
      MinValue : Double = -1.7976931348623157081e+308;
      PositiveInfinity : Double =  1.0 / 0.0;
      NegativeInfinity : Double = -1.0 / 0.0;
      NaN : Double = 0.0 / 0.0;

    Class Operator Implicit(ADouble : Double) : DoubleEx;
    Class Operator Implicit(ADouble : DoubleEx) : Double;

    Class Operator Add(ALeftOp : Double; ARightOp : Double) : DoubleEx;
    Class Operator Subtract(ALeftOp : Double; ARightOp : Double) : DoubleEx;
    Class Operator Multiply(ALeftOp : Double; ARightOp : Double) : DoubleEx;
    Class Operator Divide(ALeftOp : Double; ARightOp : Double) : DoubleEx;

    Class Operator Negative(ADouble : Double) : DoubleEx;
    Class Operator Positive(ADouble : Double) : DoubleEx;
    Class Operator Inc(ADouble : Double) : DoubleEx;
    Class Operator Dec(ADouble : Double) : DoubleEx;

    Class Operator Equal(ALeftOp : Double; ARightOp : Double): Boolean;
    Class Operator NotEqual(ALeftOp : Double; ARightOp : Double): Boolean;
    Class Operator GreaterThan(ALeftOp : Double; ARightOp : Double): Boolean;
    Class Operator GreaterThanOrEqual(ALeftOp : Double; ARightOp : Double): Boolean;
    Class Operator LessThan(ALeftOp : Double; ARightOp : Double): Boolean;
    Class Operator LessThanOrEqual(ALeftOp : Double; ARightOp : Double): Boolean;

    Constructor Create(Const ADouble : Double); 

  End;  

  StringEx = Record
  Strict Private
    FStr : String;

  Public
    Class Operator Implicit(AString : String) : StringEx;
    Class Operator Implicit(AString : StringEx) : String;

    Class Operator Implicit(AString : StringEx) : WideString;
    Class Operator Implicit(AString : WideString) : StringEx;

    Class Operator Add(ALeftOp : String; ARightOp : String) : StringEx;
    Class Operator Equal(ALeftOp : String; ARightOp : String): Boolean;
    Class Operator NotEqual(ALeftOp : String; ARightOp : String): Boolean;
    Class Operator GreaterThan(ALeftOp : String; ARightOp : String): Boolean;
    Class Operator GreaterThanOrEqual(ALeftOp : String; ARightOp : String): Boolean;
    Class Operator LessThan(ALeftOp : String; ARightOp : String): Boolean;
    Class Operator LessThanOrEqual(ALeftOp : String; ARightOp : String): Boolean;

    Constructor Create(Const AString : String);

  End;

  TStringExDynArray = Record
  Strict Private
    FStrings : Array Of StringEx;

    Function  GetStrings(Index : Integer) : StringEx;
    Procedure SetStrings(Index : Integer; AString : StringEx);

  Public
    Property Strings[Index : Integer] : StringEx Read GetStrings Write SetStrings; Default;

    Function Low() : Integer;
    Function High() : Integer;
    Procedure SetLength(Const ALength : Integer);

  Public
    Class Operator Implicit(AStrings : TStrings) : TStringExDynArray;

    Constructor Create(Const AStrings : Array Of String);

  End;
{$EndRegion}

  TStringExHelper = Record Helper For StringEx
  Strict Private
    Function  GetIsEmpty() : Boolean; InLine;
    Function  GetLength() : Integer; InLine;

    Function  GetChars(Index : Integer) : Char; InLine;
    Procedure SetChars(Index : Integer; AChar : Char); InLine;

    Function  GetAsWideString() : WideString;
    Procedure SetAsWideString(Const AValue : WideString);

    Function  GetAsBoolean() : Boolean; InLine;
    Procedure SetAsBoolean(Const AValue : Boolean); InLine;

    Function  GetAsInteger() : IntegerEx; InLine;
    Procedure SetAsInteger(Const AValue : IntegerEx); InLine;

    Function  GetAsSingle() : Single; InLine;
    Procedure SetAsSingle(Const AValue : Single); InLine;

    Function  GetAsFloat() : DoubleEx; InLine;
    Procedure SetAsFloat(Const AValue : DoubleEx); InLine;

    Function  GetAsExtended() : Extended; InLine;
    Procedure SetAsExtended(Const AValue : Extended); InLine;

  Public
    Property IsEmpty   : Boolean Read GetIsEmpty;
    Property Length    : Integer Read GetLength;

    Property Chars[Index : Integer] : Char Read GetChars Write SetChars; Default;

    Property AsWideString : WideString Read GetAsWideString Write SetAsWideString;
    Property AsBoolean    : Boolean    Read GetAsBoolean    Write SetAsBoolean;
    Property AsInteger    : IntegerEx  Read GetAsInteger    Write SetAsInteger;
    Property AsSingle     : Single     Read GetAsSingle     Write SetAsSingle;
    Property AsFloat      : DoubleEx   Read GetAsFloat      Write SetAsFloat;
    Property AsExtended   : Extended   Read GetAsExtended   Write SetAsExtended;

    Function Replace(Const OldPattern, NewPattern : String; Flags : TReplaceFlags) : StringEx;
    Function ToUpper() : StringEx; InLine;
    Function ToLower() : StringEx; InLine;
    Function SubString(Const AStartIndex : Integer; ALength : Integer = -1) : StringEx; InLine;
    Function Trim() : StringEx; InLine;
    Function TrimLeft() : StringEx; InLine;
    Function TrimRight() : StringEx; InLine;
    Function PadLeft(ATotalWidth : Integer; APaddingChar : Char = ' ') : StringEx;
    Function PadRight(ATotalWidth : Integer; APaddingChar : Char = ' ') : StringEx;
    Function Format(Const Args : Array Of Const) : StringEx;

    Function Contains(Const Value : String) : Boolean; InLine;
    Function IndexOf(AValue : Char; AStartIndex : Integer = 1) : Integer; OverLoad;
    Function IndexOf(Const AValue : String; AStartIndex : Integer = 1) : Integer; OverLoad;
    Function ExtractStrings(Separator, WhiteSpace : TSysCharSet; Strings : TStrings) : Integer; OverLoad;
    Function ExtractStrings(Separator, WhiteSpace : TSysCharSet) : TStringExDynArray; OverLoad;
    Function CharCount(Const AValue : Char) : Integer; OverLoad;
    Function CharCount(Const AValues : Array Of Char) : Integer; OverLoad;
    Function IsValidEmail() : Boolean;

    Procedure ShowMessage();
    Function MessageDlg(DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; DlgCaption : String = '') : Integer; OverLoad;
    Function MessageDlg(DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; DefaultButton: TMsgDlgBtn; DlgCaption : String = '') : Integer; OverLoad;

    Function MessageConfirm() : Boolean;
    Function MessageWarning() : Boolean;
    Procedure MessageWarningOk();
    Procedure MessageInformation();

  End;

  TStringsHelper = Class Helper For TStrings
  Private
    Function  Get(Index: Integer): StringEx;
    Procedure Put(Index: Integer; Const S : StringEx);
    Function  GetTextStr() : StringEx;
    Procedure SetTextStr(Const Value : StringEx);

  Public
    Property Strings[Index: Integer] : StringEx Read Get Write Put; Default;
    Property Text : StringEx Read GetTextStr Write SetTextStr;

  End;

(******************************************************************************)

  Int8    = ShortInt;
  Int16   = SmallInt;
  Int32   = Integer;
  IntPtr  = NativeInt;
  UInt8   = Byte;
  UInt16  = Word;
  UInt32  = Cardinal;

  PUInt64 = ^UInt64;

  TFloatSpecial = ( fsZero, fsNZero, fsDenormal, fsNDenormal,
    fsPositive, fsNegative, fsInf, fsNInf, fsNaN );

  TIntegerExHelper = Record Helper For IntegerEx
  Strict Private
    Function  GetBytes(Index : Cardinal) : UInt8;
    Procedure SetBytes(Index: Cardinal; Const Value: UInt8);

  Public
    Property Bytes[Index: Cardinal] : UInt8  Read GetBytes Write SetBytes;

    Function ToString() : StringEx; InLine;
    Function ToBoolean() : Boolean; InLine;
    Function ToHexString() : StringEx; OverLoad; InLine;
    Function ToHexString(Const MinDigits : Word) : StringEx; OverLoad; InLine;
    Function ToSingle() : Single; InLine;
    Function ToDouble() : DoubleEx; InLine;
    Function ToExtended() : Extended; InLine;

    Class Function Size() : IntegerEx; InLine; Static;
    Class Function Parse(Const S : StringEx) : IntegerEx; InLine; Static;
    Class Function TryParse(Const S: StringEx; Out Value: IntegerEx) : Boolean; InLine; Static;

  End;

(******************************************************************************)

  TDoubleExHelper = Record Helper For DoubleEx
  Strict Private
    Function GetSpecialType() : TFloatSpecial;

    Function  GetBytes(Index : Cardinal) : UInt8;
    Procedure SetBytes(Index: Cardinal; Const Value: UInt8);

    Function  GetWords(Index : Cardinal) : UInt16;
    Procedure SetWords(Index: Cardinal; Const Value: UInt16);

    Function  GetSign() : Boolean; InLine;
    Procedure SetSign(NewSign: Boolean);

    Function  GetExp() : UInt64; InLine;
    Procedure SetExp(NewExp: UInt64);

    Function  GetFrac() : UInt64; InLine;
    Procedure SetFrac(NewFrac: UInt64);

    Function GetIsNan() : Boolean; InLine;
    Function GetIsInfinity() : Boolean; InLine;
    Function GetIsNegativeInfinity() : Boolean; InLine;
    Function GetIsPositiveInfinity() : Boolean; InLine;

  Public
    Property Bytes[Index: Cardinal] : UInt8  Read GetBytes Write SetBytes;
    Property Words[Index: Cardinal] : UInt16 Read GetWords Write SetWords;

    Property Sign : Boolean Read GetSign Write SetSign;
    Property Exp  : UInt64  Read GetExp  Write SetExp;
    Property Frac : UInt64  Read GetFrac Write SetFrac;

    Property IsNan              : Boolean Read GetIsNan;
    Property IsInfinity         : Boolean Read GetIsInfinity;
    Property IsNegativeInfinity : Boolean Read GetIsNegativeInfinity;
    Property IsPositiveInfinity : Boolean Read GetIsPositiveInfinity;

    Class Function Size() : IntegerEx; InLine; Static;

  End;
     
implementation

Uses StrUtils, Controls;

{$Region ' AdvancedRecords '}
Constructor StringEx.Create(Const AString : String);
Begin
  Self := AString;
End;

Class Operator StringEx.Implicit(AString : String) : StringEx;
Begin
  Result.FStr := AString;
End;

Class Operator StringEx.Implicit(AString : StringEx) : String;
Begin
  Result := AString.FStr;
End;

Class Operator StringEx.Implicit(AString : StringEx) : WideString;
Begin
  Result := Utf8Encode(AString.FStr);
End;

Class Operator StringEx.Implicit(AString : WideString) : StringEx;
Begin
  Result.FStr := Utf8Decode(AString);
End;

Class Operator StringEx.Add(ALeftOp : String; ARightOp : String) : StringEx;
Begin
  Result := ALeftOp + ARightOp;
End;

Class Operator StringEx.Equal(ALeftOp : String; ARightOp : String) : Boolean;
Begin
  Result := ALeftOp = ARightOp;
End;

Class Operator StringEx.NotEqual(ALeftOp : String; ARightOp : String) : Boolean;
Begin
  Result := ALeftOp <> ARightOp;
End;

Class Operator StringEx.GreaterThan(ALeftOp : String; ARightOp : String) : Boolean;
Begin
  Result := ALeftOp > ARightOp;
End;

Class Operator StringEx.GreaterThanOrEqual(ALeftOp : String; ARightOp : String) : Boolean;
Begin
  Result := ALeftOp >= ARightOp;
End;

Class Operator StringEx.LessThan(ALeftOp : String; ARightOp : String) : Boolean;
Begin
  Result := ALeftOp < ARightOp;
End;

Class Operator StringEx.LessThanOrEqual(ALeftOp : String; ARightOp : String) : Boolean;
Begin
  Result := ALeftOp <= ARightOp;
End;

(******************************************************************************)

Constructor IntegerEx.Create(Const AInteger : Integer);
Begin
  FInt := AInteger;
End;

Class Operator IntegerEx.Implicit(AInteger : Integer) : IntegerEx;
Begin
  Result := IntegerEx.Create(AInteger);
End;

Class Operator IntegerEx.Implicit(AInteger : IntegerEx) : Integer;
Begin
  Result := AInteger.FInt;
End;

Class Operator IntegerEx.Implicit(AInteger : IntegerEx) : Single;
Begin
  Result := AInteger.FInt;
End;

Class Operator IntegerEx.Implicit(AInteger : IntegerEx) : Double;
Begin
  Result := AInteger.FInt;
End;

Class Operator IntegerEx.Implicit(AInteger : IntegerEx) : Extended;
Begin
  Result := AInteger.FInt;
End;

Class Operator IntegerEx.Add(ALeftOp : Integer; ARightOp : IntegerEx) : IntegerEx;
Begin
  Result := IntegerEx.Create(ALeftOp + ARightOp);
End;

Class Operator IntegerEx.Add(ALeftOp : IntegerEx; ARightOp : Integer) : IntegerEx;
Begin
  Result := IntegerEx.Create(ALeftOp + ARightOp);
End;

Class Operator IntegerEx.Subtract(ALeftOp : Integer; ARightOp : IntegerEx) : IntegerEx;
Begin
  Result := IntegerEx.Create(ALeftOp - ARightOp);
End;

Class Operator IntegerEx.Subtract(ALeftOp : IntegerEx; ARightOp : Integer) : IntegerEx;
Begin
  Result := IntegerEx.Create(ALeftOp - ARightOp);
End;

Class Operator IntegerEx.Multiply(ALeftOp : Integer; ARightOp : IntegerEx) : IntegerEx;
Begin
  Result := IntegerEx.Create(ALeftOp * ARightOp);
End;

Class Operator IntegerEx.Multiply(ALeftOp : IntegerEx; ARightOp : Integer) : IntegerEx;
Begin
  Result := IntegerEx.Create(ALeftOp * ARightOp);
End;

Class Operator IntegerEx.Divide(ALeftOp : Integer; ARightOp : IntegerEx) : Double;
Begin
  Result := ALeftOp / ARightOp;
End;

Class Operator IntegerEx.Divide(ALeftOp : IntegerEx; ARightOp : Integer) : Double;
Begin
  Result := ALeftOp / ARightOp;
End;

Class Operator IntegerEx.IntDivide(ALeftOp : Integer; ARightOp : IntegerEx) : IntegerEx;
Begin
  Result := IntegerEx.Create(ALeftOp Div ARightOp);
End;

Class Operator IntegerEx.IntDivide(ALeftOp : IntegerEx; ARightOp : Integer) : IntegerEx;
Begin
  Result := IntegerEx.Create(ALeftOp Div ARightOp);
End;

Class Operator IntegerEx.Modulus(ALeftOp : Integer; ARightOp : IntegerEx) : IntegerEx;
Begin
  Result := IntegerEx.Create(ALeftOp Mod ARightOp);
End;

Class Operator IntegerEx.Modulus(ALeftOp : IntegerEx; ARightOp : Integer) : IntegerEx;
Begin
  Result := IntegerEx.Create(ALeftOp Mod ARightOp);
End;

Class Operator IntegerEx.LeftShift(ALeftOp : Integer; ARightOp : IntegerEx) : IntegerEx;
Begin
  Result := IntegerEx.Create(ALeftOp Shl ARightOp);
End;

Class Operator IntegerEx.LeftShift(ALeftOp : IntegerEx; ARightOp : Integer) : IntegerEx;
Begin
  Result := IntegerEx.Create(ALeftOp Shl ARightOp);
End;

Class Operator IntegerEx.RightShift(ALeftOp : Integer; ARightOp : IntegerEx) : IntegerEx;
Begin
  Result := IntegerEx.Create(ALeftOp Shr ARightOp);
End;

Class Operator IntegerEx.RightShift(ALeftOp : IntegerEx; ARightOp : Integer) : IntegerEx;
Begin
  Result := IntegerEx.Create(ALeftOp Shr ARightOp);
End;

Class Operator IntegerEx.Negative(AInteger : IntegerEx) : IntegerEx;
Begin
  Result := IntegerEx.Create(-AInteger);
End;

Class Operator IntegerEx.Positive(AInteger : IntegerEx) : IntegerEx;
Begin
  Result := IntegerEx.Create(AInteger);
End;

Class Operator IntegerEx.Inc(AInteger : IntegerEx) : IntegerEx;
Begin
  Result := IntegerEx.Create(AInteger + 1);
End;

Class Operator IntegerEx.Dec(AInteger : IntegerEx) : IntegerEx;
Begin
  Result := IntegerEx.Create(AInteger - 1);
End;

Class Operator IntegerEx.LogicalNot(AInteger : IntegerEx) : IntegerEx;
Begin
  Result := IntegerEx.Create(Not AInteger);
End;

Class Operator IntegerEx.LogicalAnd(ALeftOp : Integer; ARightOp : Integer) : IntegerEx;
Begin
  Result := IntegerEx.Create(ALeftOp And ARightOp);
End;

Class Operator IntegerEx.LogicalOr(ALeftOp : Integer; ARightOp : Integer) : IntegerEx;
Begin
  Result := IntegerEx.Create(ALeftOp Or ARightOp);
End;

Class Operator IntegerEx.LogicalXor(ALeftOp : Integer; ARightOp : Integer) : IntegerEx;
Begin
  Result := IntegerEx.Create(ALeftOp Xor ARightOp);
End;

Class Operator IntegerEx.Equal(ALeftOp : Integer; ARightOp : Integer): Boolean;
Begin
  Result := ALeftOp = ARightOp;
End;

Class Operator IntegerEx.NotEqual(ALeftOp : Integer; ARightOp : Integer): Boolean;
Begin
  Result := ALeftOp <> ARightOp;
End;

Class Operator IntegerEx.GreaterThan(ALeftOp : Integer; ARightOp : Integer): Boolean;
Begin
  Result := ALeftOp > ARightOp;
End;

Class Operator IntegerEx.GreaterThanOrEqual(ALeftOp : Integer; ARightOp : Integer): Boolean;
Begin
  Result := ALeftOp >= ARightOp;
End;

Class Operator IntegerEx.LessThan(ALeftOp : Integer; ARightOp : Integer): Boolean;
Begin
  Result := ALeftOp < ARightOp;
End;

Class Operator IntegerEx.LessThanOrEqual(ALeftOp : Integer; ARightOp : Integer): Boolean;
Begin
  Result := ALeftOp <= ARightOp;
End;

(******************************************************************************)

Constructor DoubleEx.Create(Const ADouble : Double);
Begin
  FDouble := ADouble;
End;

Class Operator DoubleEx.Implicit(ADouble : Double) : DoubleEx;
Begin
  Result := DoubleEx.Create(ADouble);
End;

Class Operator DoubleEx.Implicit(ADouble : DoubleEx) : Double;
Begin
  Result := ADouble.FDouble;
End;

Class Operator DoubleEx.Add(ALeftOp : Double; ARightOp : Double) : DoubleEx;
Begin
  Result := DoubleEx.Create(ALeftOp + ARightOp);
End;

Class Operator DoubleEx.Subtract(ALeftOp : Double; ARightOp : Double) : DoubleEx;
Begin
  Result := DoubleEx.Create(ALeftOp - ARightOp);
End;

Class Operator DoubleEx.Multiply(ALeftOp : Double; ARightOp : Double) : DoubleEx;
Begin
  Result := DoubleEx.Create(ALeftOp * ARightOp);
End;

Class Operator DoubleEx.Divide(ALeftOp : Double; ARightOp : Double) : DoubleEx;
Begin
  Result := ALeftOp / ARightOp;
End;

Class Operator DoubleEx.Negative(ADouble : Double) : DoubleEx;
Begin
  Result := DoubleEx.Create(-ADouble);
End;

Class Operator DoubleEx.Positive(ADouble : Double) : DoubleEx;
Begin
  Result := DoubleEx.Create(ADouble);
End;

Class Operator DoubleEx.Inc(ADouble : Double) : DoubleEx;
Begin
  Result := DoubleEx.Create(ADouble + 1);
End;

Class Operator DoubleEx.Dec(ADouble : Double) : DoubleEx;
Begin
  Result := DoubleEx.Create(ADouble - 1);
End;

Class Operator DoubleEx.Equal(ALeftOp : Double; ARightOp : Double): Boolean;
Begin
  Result := ALeftOp = ARightOp;
End;

Class Operator DoubleEx.NotEqual(ALeftOp : Double; ARightOp : Double): Boolean;
Begin
  Result := ALeftOp <> ARightOp;
End;

Class Operator DoubleEx.GreaterThan(ALeftOp : Double; ARightOp : Double): Boolean;
Begin
  Result := ALeftOp > ARightOp;
End;

Class Operator DoubleEx.GreaterThanOrEqual(ALeftOp : Double; ARightOp : Double): Boolean;
Begin
  Result := ALeftOp >= ARightOp;
End;

Class Operator DoubleEx.LessThan(ALeftOp : Double; ARightOp : Double): Boolean;
Begin
  Result := ALeftOp < ARightOp;
End;

Class Operator DoubleEx.LessThanOrEqual(ALeftOp : Double; ARightOp : Double): Boolean;
Begin
  Result := ALeftOp <= ARightOp;
End;

(******************************************************************************)

Constructor TStringExDynArray.Create(Const AStrings : Array Of String);
Var X : Integer;
Begin
  System.SetLength(FStrings, Length(AStrings));

  For X := System.Low(AStrings) To System.High(AStrings) Do
    FStrings[X] := AStrings[X];
End;

Class Operator TStringExDynArray.Implicit(AStrings : TStrings) : TStringExDynArray;
Var X : Integer;
Begin
  Result.SetLength(AStrings.Count);
  For X := 0 To AStrings.Count - 1 Do
    Result[X] := AStrings[X];
End;

Function TStringExDynArray.GetStrings(Index : Integer) : StringEx;
Begin
  If Index < High() Then
    Result := FStrings[Index];
End;

Procedure TStringExDynArray.SetStrings(Index : Integer; AString : StringEx);
Begin
  If Index > High() Then
    SetLength(Index);
  FStrings[Index] := AString;
End;

Function TStringExDynArray.Low() : Integer;
Begin
  Result := System.Low(FStrings);
End;

Function TStringExDynArray.High() : Integer;
Begin
  Result := System.High(FStrings);
End;

Procedure TStringExDynArray.SetLength(Const ALength : Integer);
Begin
  System.SetLength(FStrings, ALength);
End;
{$EndRegion}

(******************************************************************************)

Function TStringExHelper.GetChars(Index : Integer) : Char;
Begin
  Result := Self[Index];
End;

Procedure TStringExHelper.SetChars(Index : Integer; AChar : Char);
Begin
  Self[Index] := AChar;
End;

Function TStringExHelper.GetAsWideString() : WideString;
Begin
  Result := AnsiToUtf8(Self);
End;

Procedure TStringExHelper.SetAsWideString(Const AValue : WideString);
Begin
  Self := Utf8ToAnsi(AValue);
End;

Function TStringExHelper.GetAsBoolean() : Boolean;
Begin
  Result := StrToBoolDef(Self, False);
End;

Procedure TStringExHelper.SetAsBoolean(Const AValue : Boolean);
Begin
  Self := BoolToStr(AValue, True);
End;

Function TStringExHelper.GetAsInteger() : IntegerEx;
Begin
  Result := StrToIntDef(Self, 0);
End;

Procedure TStringExHelper.SetAsInteger(Const AValue : IntegerEx);
Begin
  Self := IntToStr(AValue);
End;

Function TStringExHelper.GetAsSingle() : Single;
Begin
  Result := StrToFloatDef(Self, 0);
End;

Procedure TStringExHelper.SetAsSingle(Const AValue : Single);
Begin
  Self := FloatToStr(AValue);
End;

Function TStringExHelper.GetAsFloat() : DoubleEx;
Begin
  Result := StrToFloatDef(Self, 0);
End;

Procedure TStringExHelper.SetAsFloat(Const AValue : DoubleEx);
Begin
  Self := FloatToStr(Double(AValue));
End;

Function TStringExHelper.GetAsExtended() : Extended;
Begin
  Result := StrToFloatDef(Self, 0);
End;

Procedure TStringExHelper.SetAsExtended(Const AValue : Extended);
Begin
  Self := FloatToStr(AValue);
End;

Function TStringExHelper.GetIsEmpty() : Boolean;
Begin
  Result := Self = EmptyStr;
End;

Function TStringExHelper.GetLength() : Integer;
Begin
  Result := System.Length(Self);
End;

Function TStringExHelper.Replace(Const OldPattern, NewPattern : String; Flags : TReplaceFlags) : StringEx;
Begin
  Result := StringEx.Create(StringReplace(Self, OldPattern, NewPattern, Flags));
End;

Function TStringExHelper.ToUpper() : StringEx;
Begin
  Result := StringEx.Create(AnsiUpperCase(Self));
End;

Function TStringExHelper.ToLower() : StringEx;
Begin
  Result := StringEx.Create(AnsiLowerCase(Self));
End;

Function TStringExHelper.SubString(Const AStartIndex : Integer; ALength : Integer = -1) : StringEx;
Begin
  If ALength = -1 Then
    ALength := Length;

  Result := Copy(Self, AStartIndex, ALength);
End;

Function TStringExHelper.Trim() : StringEx;
Begin
  Result := StringEx.Create(SysUtils.Trim(Self));
End;

Function TStringExHelper.TrimLeft() : StringEx;
Begin
  Result := StringEx.Create(SysUtils.TrimLeft(Self));
End;

Function TStringExHelper.TrimRight() : StringEx;
Begin
  Result := StringEx.Create(SysUtils.TrimRight(Self));
End;

Function TStringExHelper.PadLeft(ATotalWidth : Integer; APaddingChar : Char = ' ') : StringEx;
Begin
  ATotalWidth := ATotalWidth - Length;

  If ATotalWidth > 0 Then
    Result := System.StringOfChar(APaddingChar, ATotalWidth) + Self
  Else
    Result := Self;
End;

Function TStringExHelper.PadRight(ATotalWidth : Integer; APaddingChar : Char = ' ') : StringEx;
Begin
  ATotalWidth := ATotalWidth - Length;

  If ATotalWidth > 0 Then
    Result := Self + System.StringOfChar(APaddingChar, ATotalWidth)
  Else
    Result := Self;
End;

Function TStringExHelper.Format(Const Args : Array Of Const) : StringEx;
Begin
  Result := SysUtils.Format(Self, Args);
End;

Function TStringExHelper.Contains(Const Value : String) : Boolean;
Begin
  Result := System.Pos(Value, Self) > 0;
End;

Function TStringExHelper.IndexOf(AValue : Char; AStartIndex : Integer = 1) : Integer;
Begin
  Result := PosEx(AValue, Self, AStartIndex);
End;

Function TStringExHelper.IndexOf(Const AValue : String; AStartIndex : Integer = 1) : Integer;
Begin
  Result := PosEx(AValue, Self, AStartIndex);
End;

Function TStringExHelper.ExtractStrings(Separator, WhiteSpace : TSysCharSet; Strings : TStrings) : Integer;
Begin
  Result := Classes.ExtractStrings(Separator, WhiteSpace, PChar(Self), Strings);
End;

Function TStringExHelper.ExtractStrings(Separator, WhiteSpace : TSysCharSet) : TStringExDynArray;
Var lLst : TStringList;
Begin
  lLst := TStringList.Create();
  Try
    Classes.ExtractStrings(Separator, WhiteSpace, PChar(Self), lLst);
    Result := lLst;

    Finally
      lLst.Free();
  End;
End;

Function TStringExHelper.CharCount(Const AValue : Char) : Integer;
Var X : Integer;
Begin
  Result := 0;

  For X := 1 To Length Do
    If Self[X] = AValue Then
      Inc(Result);
End;

Function TStringExHelper.CharCount(Const AValues : Array Of Char) : Integer;
Var X : Integer;
    C : Char;
Begin
  Result := 0;

  For X := 1 To Length Do
    For C In AValues Do
      If Self[X] = C Then
        Inc(Result);
End;

Function TStringExHelper.IsValidEmail() : Boolean;
Const
  InvalidEmailChar : Array[0..9] Of Char = (
    ' ', 'ä', 'ö', 'ü', 'ß', '[', ']', '(', ')', ':'
  );
Var lIdx : Integer;
Begin
  Result := False;
  lIdx := IndexOf('@');
  If (ToLower.CharCount(InvalidEmailChar) = 0) And (lIdx > 1) And (lIdx < Length) Then
    With SubString(lIdx + 1) Do
      Result := (Length > 1) And (IndexOf('@') < 1) And
                (Chars[1] <> '.') And (Chars[Length] <> '.')
End;

Procedure TStringExHelper.ShowMessage();
Begin
  Dialogs.ShowMessage(Self);
End;

Function TStringExHelper.MessageDlg(DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; DlgCaption : String = '') : Integer;
Var DefaultButton: TMsgDlgBtn;
Begin
  If mbOk In Buttons Then
    DefaultButton := mbOk
  Else If mbYes In Buttons Then
    DefaultButton := mbYes
  Else
    DefaultButton := mbRetry;

  Result := MessageDlg(DlgType, Buttons, DefaultButton, DlgCaption);
End;

Function TStringExHelper.MessageDlg(DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; DefaultButton: TMsgDlgBtn; DlgCaption : String = '') : Integer;
Begin
  With CreateMessageDialog(Self, DlgType, Buttons, DefaultButton) Do
  Try
    If (DlgCaption <> '') Then
      Caption := DlgCaption;

    Result := ShowModal();

    Finally
      Release();
  End;
End;

Function TStringExHelper.MessageConfirm() : Boolean;
Begin
  Result := MessageDlg(mtConfirmation, [mbYes, mbNo]) = mrYes;
End;

Function TStringExHelper.MessageWarning() : Boolean;
Begin
  Result := MessageDlg(mtWarning, [mbYes, mbNo]) = mrYes;
End;

Procedure TStringExHelper.MessageWarningOk();
Begin
  MessageDlg(mtWarning, [mbOk]);
End;

Procedure TStringExHelper.MessageInformation();
Begin
  MessageDlg(mtInformation, [mbOk]);
End;

(******************************************************************************)

Function TStringsHelper.Get(Index: Integer): StringEx;
Begin
  Result := InHerited Strings[Index];
End;

Procedure TStringsHelper.Put(Index: Integer; Const S : StringEx);
Begin
  InHerited Strings[Index] := S;
End;

Function TStringsHelper.GetTextStr() : StringEx;
Begin
  Result := InHerited GetTextStr();
End;

Procedure TStringsHelper.SetTextStr(Const Value : StringEx);
Begin
  InHerited SetTextStr(Value);
End;

(******************************************************************************)

Type
  PByteArray = ^TByteArray;
  TByteArray = array[0..32767] of Byte;

  PWordArray = ^TWordArray;
  TWordArray = array[0..16383] of Word;

  TBasicNumeric = Record
  Strict Private

  Public
    Class Function  GetBytes(Const Value : PByteArray; Index : Cardinal) : UInt8; InLine; Static;
    Class Procedure SetBytes(Const Value : PByteArray; Index : Cardinal; Const ByteValue : UInt8); InLine; Static;

    Class Function  GetWords(Const Value : PWordArray; Index : Cardinal) : UInt16; InLine; Static;
    Class Procedure SetWords(Const Value : PWordArray; Index : Cardinal; Const WordValue : UInt16); InLine; Static;

  End;

Class Function TBasicNumeric.GetBytes(Const Value : PByteArray; Index: Cardinal) : UInt8;
Begin
  Result := Value[Index];
End;

Class Procedure TBasicNumeric.SetBytes(Const Value : PByteArray; Index: Cardinal; Const ByteValue : UInt8);
Begin
  Value[Index] := ByteValue;
End;

Class Function TBasicNumeric.GetWords(Const Value : PWordArray; Index: Cardinal) : UInt16; 
Begin
  Result := Value[Index];
End;

Class Procedure TBasicNumeric.SetWords(Const Value : PWordArray; Index: Cardinal; Const WordValue: UInt16);
Begin
  Value[Index] := WordValue;
End;

Function TIntegerExHelper.ToString() : StringEx;
Begin
  Result := IntToStr(Self);
End;

Function TIntegerExHelper.ToBoolean() : Boolean;
Begin
  Result := Self <> 0;
End;

Function TIntegerExHelper.ToHexString() : StringEx;
Begin
  Result := IntToHex(Self, 0);
End;

Function TIntegerExHelper.ToHexString(Const MinDigits : Word) : StringEx;
Begin
  Result := IntToHex(Self, MinDigits);
End;

Function TIntegerExHelper.ToSingle() : Single;
Begin
  Result := Self;
End;

Function TIntegerExHelper.ToDouble() : DoubleEx;
Begin
  Result := Double(Self);
End;

Function TIntegerExHelper.ToExtended() : Extended;
Begin
  Result := Self;
End;

Class Function TIntegerExHelper.Size() : IntegerEx;
Begin
  Result := SizeOf(Integer);
End;

Class Function TIntegerExHelper.Parse(Const S : StringEx): IntegerEx;
Begin
  Result := IntegerEx.Create(S.AsInteger);
End;

Class Function TIntegerExHelper.TryParse(Const S: StringEx; Out Value: IntegerEx): Boolean;
Var lResult : Integer;
Begin
  Result := TryStrToInt(S, lResult);
  Value := lResult;
End;

Function TIntegerExHelper.GetBytes(Index : Cardinal) : UInt8;
Begin
  If Index >= 4 Then
    System.Error(reRangeError);
  Result := TBasicNumeric.GetBytes(@Self, Index);
End;

Procedure TIntegerExHelper.SetBytes(Index: Cardinal; Const Value: UInt8);
Begin
  If Index >= 4 Then
    System.Error(reRangeError);
  TBasicNumeric.SetBytes(@Self, Index, Value);
End;

(******************************************************************************)

Function TDoubleExHelper.GetSpecialType() : TFloatSpecial;
Var U64 : UInt64;
    W   : Word;
Begin
  U64 := PUInt64(@Self)^;
  W   := Words[3];

  If ($0010 <= W) And (W <= $7FEF) Then
    Result := fsPositive
  Else If ($8010 <= W) And (W <= $FFEF) Then
    Result := fsNegative
  Else If U64 = 0 Then
    Result := fsZero
  Else If U64 = $8000000000000000 Then
    Result := fsNZero
  Else If W <= $000F Then
    Result := fsDenormal
  Else If ($8000 <= W) And (W <= $800F) Then
    Result := fsNDenormal
  Else If U64 = $7FF0000000000000 Then
    Result := fsInf
  Else If U64 = $FFF0000000000000 Then
    Result := fsNInf
  Else
    Result := fsNan;
End;

Function TDoubleExHelper.GetSign() : Boolean;
Begin
  Result := Bytes[7] >= $80;
End;

Procedure TDoubleExHelper.SetSign(NewSign: Boolean);
Var B : Byte;
Begin
  B := Bytes[7];

  If NewSign Then
    B := B Or $80
  Else
    B := B And $7F;

  Bytes[7] := B;
End;

Function TDoubleExHelper.GetExp() : UInt64;
Begin
  Result := (Words[3] Shr 4) And $7FF;
End;

Procedure TDoubleExHelper.SetExp(NewExp: UInt64);
Var W : Word;
Begin
  W := Words[3];
  W := (W And $800F) Or ((NewExp And $7FF) Shl 4);
  Words[3] := W;
End;

Function TDoubleExHelper.GetFrac() : UInt64;
Begin
  Result := PUInt64(@Self)^ And $000FFFFFFFFFFFFF;
End;

Procedure TDoubleExHelper.SetFrac(NewFrac: UInt64);
Var U64 : UInt64;
Begin
  U64 := PUInt64(@Self)^;
  U64 := (U64 And $FFF0000000000000) Or (NewFrac And $000FFFFFFFFFFFFF);
  PUInt64(@Self)^ := U64;
End;

Function TDoubleExHelper.GetIsNan() : Boolean;
Begin
  Result := GetSpecialType() = fsNan;
End;

Function TDoubleExHelper.GetIsInfinity() : Boolean;
Var lType : TFloatSpecial;
Begin
  lType := GetSpecialType();
  Result := (lType = fsInf) Or (lType = fsNInf);
End;

Function TDoubleExHelper.GetIsNegativeInfinity() : Boolean;
Begin
  Result := GetSpecialType() = fsNInf;
End;

Function TDoubleExHelper.GetIsPositiveInfinity() : Boolean;
Begin
  Result := GetSpecialType() = fsInf;
End;

Function TDoubleExHelper.GetBytes(Index : Cardinal) : UInt8;
Begin
  If Index >= 8 Then
    System.Error(reRangeError);
  Result := TBasicNumeric.GetBytes(@Self, Index);
End;

Procedure TDoubleExHelper.SetBytes(Index: Cardinal; Const Value: UInt8);
Begin
  If Index >= 8 Then
    System.Error(reRangeError);
  TBasicNumeric.SetBytes(@Self, Index, Value);
End;

Function TDoubleExHelper.GetWords(Index : Cardinal) : UInt16;
Begin
  If Index >= 4 Then
    System.Error(reRangeError);
  Result := TBasicNumeric.GetWords(@Self, Index);
End;

Procedure TDoubleExHelper.SetWords(Index: Cardinal; Const Value: UInt16);
Begin
  If Index >= 4 Then
    System.Error(reRangeError);
  TBasicNumeric.SetWords(@Self, Index, Value);
End;

Class Function TDoubleExHelper.Size() : IntegerEx;
Begin
  Result := SizeOf(Double);
End;

end.
