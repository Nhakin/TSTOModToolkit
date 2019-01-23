unit HsBaseConvEx;

interface

Uses HsInterfaceEx;

Type
  IHsBaseConvEx = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-922F-C9A962EA51B1}']
    Function  GetAsBinary() : String;
    Procedure SetAsBinary(Const ABinary : String);
    Function  GetAsOctal() : String;
    Procedure SetAsOctal(Const AOctal : String);
    Function  GetAsInteger() : Integer;
    Procedure SetAsInteger(Const AInteger : Integer);
    Function  GetAsHexadecimal() : String;
    Procedure SetAsHexadecimal(Const AHexadecimal : String);

    Property AsBinary      : String  Read GetAsBinary      Write SetAsBinary;
    Property AsOctal       : String  Read GetAsOctal       Write SetAsOctal;
    Property AsInteger     : Integer Read GetAsInteger     Write SetAsInteger;
    Property AsHexadecimal : String  Read GetAsHexadecimal Write SetAsHexadecimal;

  End;

  THsBaseConvEx = Class(TObject)
  Public
    Class Function CreateBaseConv() : IHsBaseConvEx;

  End;

implementation

Uses
  SysUtils, Math;
  
Type
  tBaseConvType = (bctBinary, bctOctal, bctHexaDecimal);

  THsBaseConvExImpl = Class(TInterfacedObjectEx, IHsBaseConvEx)
  Private
    FIntValue : Integer;

    Function  GetValue(Index : tBaseConvType) : String;
    Procedure SetValue(Index : tBaseConvType; Const AValue : String);

  Protected
    Function  GetAsBinary() : String;
    Procedure SetAsBinary(Const ABinary : String);
    Function  GetAsOctal() : String;
    Procedure SetAsOctal(Const AOctal : String);
    Function  GetAsInteger() : Integer;
    Procedure SetAsInteger(Const AInteger : Integer);
    Function  GetAsHexadecimal() : String;
    Procedure SetAsHexadecimal(Const AHexadecimal : String);

  End;

Class Function THsBaseConvEx.CreateBaseConv() : IHsBaseConvEx;
Begin
  Result := THsBaseConvExImpl.Create();
End;

Function THsBaseConvExImpl.GetValue(Index : tBaseConvType) : String;
Const
  ConvFactor : Array[tBaseConvType] Of Integer = (2, 8, 16);

Var lIntValue1 ,
    lIntValue2 : Integer;
    lFactor    : Integer;
Begin
  Result := '';
  lIntValue1 := FIntValue;

  lFactor := Trunc(Power(ConvFactor[Index], Trunc(Power(lIntValue1, 1 / ConvFactor[Index]))));
  While lFactor < lIntValue1 Do
    lFactor := lFactor * ConvFactor[Index];
  lFactor := lFactor Div ConvFactor[Index];

  While lIntValue1 > 0 Do
  Begin
    lIntValue2 := Trunc(lIntValue1 / lFactor);

    If lIntValue2 < 10 Then
      Result := Result + IntToStr(lIntValue2)
    Else
      Result := Result + Chr(lIntValue2 + $37);

    lIntValue1 := lIntValue1 - (lIntValue2 * lFactor);
    lFactor    := lFactor Div ConvFactor[Index];
  End;

  While lFactor > 0 Do
  Begin
    Result  := Result + '0';
    lFactor := lFactor Div ConvFactor[Index];
  End;
End;

Procedure THsBaseConvExImpl.SetValue(Index : tBaseConvType; Const AValue : String);
Const
  BinChar = '01';
  OctChar = BinChar + '2345678';
  DecChar = OctChar + '9';
  HexChar = DecChar + 'ABCDEF';

  ConvChars : Array[tBaseConvType] Of String = (BinChar, OctChar, HexChar);
  ConvFactor : Array[tBaseConvType] Of Integer = (2, 8, 16);

Var lMultiplier : Int64;
    lPosition   : Integer;
    lValue      : Integer;
Begin
  FIntValue   := 0;
  lMultiplier := 1;
  lPosition   := Length(AValue);

  While lPosition > 0 Do
  Begin
    lValue := Pos(AValue[lPosition], ConvChars[Index]) - 1;

    If lValue = -1 Then
      Raise Exception.Create('Invalid value : ' + AValue);

    FIntValue   := FIntValue + (lValue * lMultiplier);
    lMultiplier := lMultiplier * ConvFactor[Index];

    Dec(lPosition);
  End;
End;

Function THsBaseConvExImpl.GetAsBinary() : String;
Begin
  Result := GetValue(bctBinary);
End;

Procedure THsBaseConvExImpl.SetAsBinary(Const ABinary : String);
Begin
  SetValue(bctBinary, ABinary);
End;

Function THsBaseConvExImpl.GetAsOctal() : String;
Begin
  Result := GetValue(bctOctal);
End;

Procedure THsBaseConvExImpl.SetAsOctal(Const AOctal : String);
Begin
  SetValue(bctOctal, AOctal);
End;

Function THsBaseConvExImpl.GetAsInteger() : Integer;
Begin
  Result := FIntValue;
End;

Procedure THsBaseConvExImpl.SetAsInteger(Const AInteger : Integer);
Begin
  FIntValue := AInteger;
End;

Function THsBaseConvExImpl.GetAsHexadecimal() : String;
Begin
  Result := GetValue(bctHexaDecimal);
End;

Procedure THsBaseConvExImpl.SetAsHexadecimal(Const AHexadecimal : String);
Begin
  SetValue(bctHexaDecimal, AHexadecimal);
End;

end.
