Unit HsBase64Ex;

{$Warnings Off}

Interface

Uses
  Sysutils, Classes;

Function  Base64EncodeStr(Const Value: String): String;
Function  Base64DecodeStr(Const Value: String): String;
Function  Base64Encode(pInput: pointer; pOutput: pointer; Size: Longint): Longint;
Function  Base64Decode(pInput: pointer; pOutput: pointer; Size: Longint): Longint;
Procedure Base64EncodeToStream(pInput : Pointer; AStream : TStream; Size : LongInt);
Procedure Base64DecodeToStream(Const AValue : String; AStream : TStream);
Function  Base64EncodeFile(Const AFileName : String) : String;
Procedure Base64DecodeFile(Const AValue, AFileName : String);

Implementation
{$Q-}{$R-}

Const
  B64: Array[0..63] Of Byte = (65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,
    81,82,83,84,85,86,87,88,89,90,97,98,99,100,101,102,103,104,105,106,107,108,
    109,110,111,112,113,114,115,116,117,118,119,120,121,122,48,49,50,51,52,53,
    54,55,56,57,43,47);

Function Base64Encode(pInput: pointer; pOutput: pointer; Size: Longint): Longint;
Var
  i, iptr, optr: Integer;
  Input, Output: PByteArray;
Begin
  Input  := PByteArray(pInput);
  Output := PByteArray(pOutput);
  iptr   := 0;
  optr   := 0;

  For i := 1 To (Size Div 3) Do
  Begin
    Output^[optr+0] := B64[Input^[iptr] Shr 2];
    Output^[optr+1] := B64[((Input^[iptr] And 3) Shl 4) + (Input^[iptr+1] Shr 4)];
    Output^[optr+2] := B64[((Input^[iptr+1] And 15) Shl 2) + (Input^[iptr+2] Shr 6)];
    Output^[optr+3] := B64[Input^[iptr+2] And 63];
    Inc(optr,4); Inc(iptr,3);
  End;

  Case (Size Mod 3) Of
    1:
    Begin
      Output^[optr+0] := B64[Input^[iptr] Shr 2];
      Output^[optr+1] := B64[(Input^[iptr] And 3) Shl 4];
      Output^[optr+2] := Byte('=');
      Output^[optr+3] := Byte('=');
    End;

    2:
    Begin
      Output^[optr+0] := B64[Input^[iptr] Shr 2];
      Output^[optr+1] := B64[((Input^[iptr] And 3) Shl 4) + (Input^[iptr+1] Shr 4)];
      Output^[optr+2] := B64[(Input^[iptr+1] And 15) Shl 2];
      Output^[optr+3] := Byte('=');
    End;
  End;

  Result:= ((Size+2) Div 3) * 4;
End;

Function Base64EncodeStr(Const Value: String): String;
Begin
  SetLength(Result,((Length(Value)+2) Div 3) * 4);
  Base64Encode(@Value[1],@Result[1],Length(Value));
End;

Procedure Base64EncodeToStream(pInput : Pointer; AStream : TStream; Size : LongInt);
Var lResult : String;
Begin
  SetLength(lResult, ((Size + 2) Div 3) * 4);
  Base64Encode(pInput, @lResult[1], Size);
  AStream.WriteBuffer(lResult[1], Length(lResult));
End;

Function Base64EncodeFile(Const AFileName : String) : String;
Var lStrStrm : TStringStream;
Begin
  If FileExists(AFileName) Then
  Begin
    lStrStrm := TStringStream.Create('');
    With TMemoryStream.Create() Do
    Try
      LoadFromFile(AFileName);
      Base64EncodeToStream(Memory, lStrStrm, Size);
      Result := lStrStrm.DataString;
      
      Finally
        Free();
        lStrStrm.Free();
    End;
  End;
End;

Function Base64Decode(pInput: pointer; pOutput: pointer; Size: Longint): Longint;
Var
  i, j, iptr, optr: Integer;
  Temp: Array[0..3] Of Byte;
  Input, Output: PByteArray;
Begin
  Input  := PByteArray(pInput);
  Output := PByteArray(pOutput);
  iptr   := 0;
  optr   := 0;
  Result := 0;

  For i := 1 To (Size Div 4) Do
  Begin
    For j := 0 To 3 Do
    Begin
      Case Input^[iptr] Of
        65..90 : Temp[j] := Input^[iptr] - Ord('A');
        97..122: Temp[j] := Input^[iptr] - Ord('a') + 26;
        48..57 : Temp[j] := Input^[iptr] - Ord('0') + 52;
        43     : Temp[j] := 62;
        47     : Temp[j] := 63;
        61     : Temp[j] := $FF;
      End;

      Inc(iptr);
    End;

    Output^[optr] := (Temp[0] Shl 2) Or (Temp[1] Shr 4);
    Result := optr+1;
    If (Temp[2] <> $FF) And (Temp[3] = $FF) Then
    Begin
      Output^[optr + 1] := (Temp[1] Shl 4) Or (Temp[2] Shr 2);
      Result := optr + 2;
      Inc(optr)
    End
    Else If (Temp[2]<> $FF) Then
    Begin
      Output^[optr + 1] := (Temp[1] Shl 4) Or (Temp[2] Shr 2);
      Output^[optr + 2] := (Temp[2] Shl 6) Or  Temp[3];
      Result := optr + 3;
      Inc(optr, 2);
    End;

    Inc(optr);
  End;
End;

Function Base64DecodeStr(Const Value: String): String;
Begin
  SetLength(Result,(Length(Value) Div 4) * 3);
  SetLength(Result,Base64Decode(@Value[1], @Result[1], Length(Value)));
End;

Procedure Base64DecodeToStream(Const AValue : String; AStream : TStream);
Var lBase64Data : Array Of Byte;
Begin
  SetLength(lBase64Data,(Length(AValue) Div 4) * 3);
  SetLength(lBase64Data, Base64Decode(@AValue[1], @lBase64Data[0], Length(AValue)));
  AStream.WriteBuffer(lBase64Data[0], Length(lBase64Data));
End;

Procedure Base64DecodeFile(Const AValue, AFileName : String);
Var lStream : TMemoryStream;
Begin
  lStream := TMemoryStream.Create();
  Try
    Base64DecodeToStream(AValue, lStream);
    lStream.SaveToFile(AFileName);

    Finally
      lStream.Free();
  End;
End;

End.

