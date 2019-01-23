unit HsCheckSumEx;

interface

Uses Windows, Classes;

//http://www.nayuki.io/page/forcing-a-files-crc-to-any-value
Function GetCrc32Value(Const AStream : TStream) : DWord; OverLoad;
Function GetCrc32Value(Const AFileName : String) : DWord; OverLoad;
Function SetCrc32Value(Const AStream : TStream; Const AOffSet : UInt64; Const ACrc32 : DWord) : Boolean; OverLoad;
Function SetCrc32Value(Const AFileName : String; Const AOffSet : UInt64; Const ACrc32 : DWord) : Boolean; OverLoad;

implementation

Uses Dialogs, SysUtils, Types;

Const
  PolyNominal = $104C11DB7;

Function ReverseDWord(AInteger : DWord) : DWord;
Var X : Integer;
Begin
  Result := 0;
  For X := 0 To 31 Do
  Begin
    Result   := (Result Shl 1) Or (AInteger And 1);
    AInteger := AInteger Shr 1;
  End;
End;

Function GetCrc32Value(Const AStream : TStream) : DWord;
Var lBuffer : Array[0..1024] Of Byte;
    lByteRead : Integer;
    X, Y : Integer;
Begin
  Result := $FFFFFFFF;
  AStream.Position := 0;
  Repeat
    lByteRead := AStream.Read(lBuffer, SizeOf(lBuffer));
    For X := 0 To lByteRead - 1 Do
      For Y := 0 To 7 Do
      Begin
        Result := Result Xor (lBuffer[X] Shr Y) Shl 31;

        If Result And (1 Shl 31) = 0 Then
          Result := Result Shl 1
        Else
          Result := (Result Shl 1) Xor PolyNominal;
      End;
  Until lByteRead <> SizeOf(lBuffer);

  Result := ReverseDWord(Not Result);
End;

Function GetCrc32Value(Const AFileName : String) : DWord;
Var lFileStream : TFileStream;
Begin
  lFileStream := TFileStream.Create(AFileName, fmOpenRead + fmShareDenyNone);
  Try
    Result := GetCrc32Value(lFileStream);
    Finally
      lFileStream.Free();
  End;
End;

(******************************************************************************)

Function MultiplyMod(AInt1, AInt2 : Int64) : Int64;
Begin
  Result := 0;
  While AInt2 <> 0 Do
  Begin
    Result := Result Xor (AInt1 * (AInt2 And 1));
    AInt2 := AInt2 Shr 1;
    AInt1 := AInt1 Shl 1;
    If AInt1 And $100000000 <> 0 Then
      AInt1 := AInt1 Xor PolyNominal;
  End;
End;

Function ReciprocalMod(AInt : Int64) : Int64;
  Function GetDegree(Const AInt : Int64) : Integer;
  Begin
    Result := 0;
    If AInt Shr Result <> 1 Then
      Repeat
        Inc(Result);
      Until AInt Shr Result = 1;
  End;

Var lRetVal ,
    lMult   , 
    lTmpVal : Int64;
    lDiv    , 
    lResult : Int64;
    lDeg    : Integer;
    X       : Integer;
Begin
  lResult := PolyNominal;
  lRetVal := 0;
  lMult   := 1;
  
  While AInt <> 0 Do
  Begin
    lDiv := 0;
    lDeg := GetDegree(AInt);
    For X := GetDegree(lResult) - lDeg DownTo 0 Do
    Begin
      If lResult And (1 Shl (X + lDeg)) <> 0 Then
      Begin
        lDiv := lDiv Or (1 Shl X);
        lResult := lResult XOr (AInt Shl X);
      End;
    End;

    lTmpVal := lRetVal XOr MultiplyMod(lDiv, lMult);
    lRetVal := lMult;
    lMult   := lTmpVal;

    lTmpVal := AInt;
    AInt    := lResult;
    lResult := lTmpVal;
  End;

  If lResult = 1 Then
    Result := lRetVal
  Else
    Raise Exception.Create('Reciprocal does not exist.');
End;

Function SetCrc32Value(Const AStream : TStream; Const AOffSet : UInt64; Const ACrc32 : DWord) : Boolean;
  Function PowMod(AInt1, AInt2 : Int64) : Int64;
  Begin
    Result := 1;
    While AInt2 <> 0 Do
    Begin
      If AInt2 And 1 <> 0 Then
        Result := MultiplyMod(Result, AInt1);
      AInt1 := MultiplyMod(AInt1, AInt1);
      AInt2 := AInt2 Shr 1;
    End;
  End;

Var lPatch : DWord;
Begin
  If AOffSet + SizeOf(lPatch) <= AStream.Size Then
  Begin
    AStream.Seek(AOffSet, soFromBeginning);
    AStream.ReadBuffer(lPatch, SizeOf(lPatch));

    lPatch := lPatch XOr ReverseDWord(
                           MultiplyMod(
                             ReciprocalMod(
                               PowMod(2, (AStream.Size - AOffSet) * 8)
                             ), ReverseDWord(GetCrc32Value(AStream)) XOr ReverseDWord(ACrc32)
                           )
                         );

    AStream.Seek(AOffSet, soFromBeginning);
    AStream.WriteBuffer(lPatch, SizeOf(lPatch));

    Result := GetCrc32Value(AStream) = ACrc32;
  End
  Else
    Raise Exception.Create('Invalid Offset.');
End;

Function SetCrc32Value(Const AFileName : String; Const AOffSet : UInt64; Const ACrc32 : DWord) : Boolean;
Var lFileStream : TFileStream;
Begin
  If FileExists(AFileName) Then
  Begin
    lFileStream := TFileStream.Create(AFileName, fmOpenReadWrite + fmShareDenyNone);
    Result := SetCrc32Value(lFileStream, AOffSet, ACrc32);
  End
  Else
    Raise Exception.Create('Error file does not exist : ' + AFileName);
End;

end.
