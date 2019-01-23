Unit HsJSonFormatterEx;

Interface

Uses Classes;

Type
  RawUTF8 = Type AnsiString;

  TTextWriterJSONFormat = (
    jsonCompact, jsonHumanReadable,
    jsonUnquotedPropName, jsonUnquotedPropNameCompact);

Function FormatJSonData(Const JSON: RawUTF8;
  Format: TTextWriterJSONFormat=jsonHumanReadable): RawUTF8; OverLoad;
Function FormatJSonData(AStream : TStream;
  Format: TTextWriterJSONFormat=jsonHumanReadable): RawUTF8; OverLoad;

Implementation

Uses SysUtils, HsFunctionsEx, HsStreamEx;

Const
  CP_UTF8 = 25001;
  CP_UTF16 = 1200;

Type
  TStrRec =
    {$ifndef FPC_REQUIRES_PROPER_ALIGNMENT}
    Packed
    {$endif FPC_REQUIRES_PROPER_ALIGNMENT}
    Record
  {$ifdef UNICODE}
    {$ifdef CPUX64}
    /// padding bytes for 16 byte alignment of the header
    _Padding: Longint;
    {$endif}
    /// the associated code page used for this string
    // - exist only since Delphi/FPC 2009
    // - 0 or 65535 for RawByteString
    // - 1200=CP_UTF16 for UnicodeString
    // - 65001=CP_UTF8 for RawUTF8
    // - the current code page for AnsiString
    codePage: Word;
    /// either 1 (for AnsiString) or 2 (for UnicodeString)
    // - exist only since Delphi/FPC 2009
    elemSize: Word;
  {$endif UNICODE}
    /// string reference count (basic garbage memory mechanism)
    refCnt: Longint;
    /// length in characters
    // - size in bytes = length*elemSize
    length: Longint;
  End;

  RawByteString = Type AnsiString;
  PRawByteString = ^RawByteString;
  TByteArray = Array[0..MaxInt-1] Of Byte;
  PByteArray = ^TByteArray;
  PUTF8Char = Type PAnsiChar;
  PtrInt = Integer;

  TTextWriterOption = (twoEnumSetsAsTextInRecord, twoFlushToStreamNoAutoResize);
  TTextWriterOptions = Set Of TTextWriterOption;

  TTextWriter = Class(TObject)
  Private
    B, BEnd: PUTF8Char;
    fTempBufSize: Integer;
    fTempBuf: PUTF8Char;
    fTotalFileSize: Cardinal;
    fHumanReadableLevel: Integer;

    fStream: TStream;
    fStreamIsOwned: Boolean;
    fInitialStreamPosition: Cardinal;

    fCustomOptions: TTextWriterOptions;

    Function GetJSONField(P: PUTF8Char; out PDest: PUTF8Char;
      wasString: PBoolean=Nil; EndOfObject: PUTF8Char=Nil): PUTF8Char;
    Function GetJSONPropName(Var P: PUTF8Char): PUTF8Char;
    Function JsonPropNameValid(P: PUTF8Char): Boolean;
    Function GotoEndOfJSONString(P: PUTF8Char): PUTF8Char;

  Protected
    Procedure SetStream(aStream: TStream);

  Public
    Procedure SetText(Var result: RawUTF8);
    Procedure FlushFinal;
    Procedure FlushToStream; Virtual;

    Procedure Add(c: AnsiChar); Overload;
    Procedure Add(c1, c2: AnsiChar); Overload;

    Procedure AddCRAndIndent;
    Procedure AddShort(Const Text: ShortString);

    Procedure AddNoJSONEscape(P: Pointer; Len: Integer);
    Procedure AddJSONEscape(P: Pointer; Len: PtrInt=0);

    Function AddJSONReformat(JSON: PUTF8Char; Format: TTextWriterJSONFormat;
      EndOfObject: PUTF8Char): PUTF8Char;

    Constructor CreateOwnedStream(aBufSize: Integer=4096);
    Constructor Create(aStream: TStream; aBufSize: Integer=8192);
    Destructor Destroy(); Override;

  End;

Const
  STRRECSIZE = SizeOf(TStrRec);

  IsJsonIdentifier: Set Of Byte =
    [ord('_'),ord('0')..ord('9'),ord('a')..ord('z'),ord('A')..ord('Z'),
    ord('.'),ord('['),ord(']')];
  NULL_LOW  = ord('n')+ord('u')Shl 8+ord('l')Shl 16+ord('l')Shl 24;
  TRUE_LOW  = ord('t')+ord('r')Shl 8+ord('u')Shl 16+ord('e')Shl 24;

  DigitFloatChars = ['-','+','0'..'9','.','E','e'];
  EndOfJSONValueField = [#0,#9,#10,#13,' ',',','}',']'];
  EndOfJSONField  = [',',']','}',':'];
  JSON_ESCAPE: Set Of Byte = [0..31,ord('\'),ord('"')];

Var
  ConvertHexToBin: Array[Byte] Of Byte;
  TwoDigitsHex: Array[Byte] Of Array[1..2] Of AnsiChar;
  TwoDigitsHexW: Array[AnsiChar] Of Word absolute TwoDigitsHex;
  TwoDigitsHexWB: Array[Byte] Of Word absolute TwoDigitsHex;

Procedure SetRawUTF8(Var Dest: RawUTF8; text: pointer; len: Integer);
Asm // eax=@Dest text=edx len=ecx
  CMP ECX,128 // avoid huge move() in ReallocMem()
{$ifdef UNICODE}
  JA @3
{$else}
  JA System.@LStrFromPCharLen
{$endif}
  OR ECX,ECX // len=0
{$ifdef UNICODE}
  JZ @3
{$else}
  JZ System.@LStrFromPCharLen
{$endif}
  PUSH EBX
  MOV EBX,[EAX]
  TEST EBX,EBX
  JNZ @2
  @0: POP EBX
{$ifdef UNICODE}
  @3: PUSH CP_UTF8 // UTF-8 code page for Delphi 2009+
  CALL System.@LStrFromPCharLen // we need a call, not a jmp here
  RET
{$else}
  JMP System.@LStrFromPCharLen
{$endif}
  @2: CMP dword ptr [EBX-8],1
  JNE @0
  CMP dword ptr [EBX-4],ECX
  JE @1
  SUB EBX,STRRECSIZE
  PUSH EDX
  PUSH EAX
  PUSH ECX
  PUSH EBX
  MOV EAX,ESP // ReallocMem() over ebx pointer on stack
  LEA EDX,ECX+STRRECSIZE+1
  CALL System.@ReallocMem
  POP EBX
  POP ECX
  ADD EBX,STRRECSIZE
  POP EAX
  POP EDX
  MOV [EAX],EBX
  MOV dword ptr [EBX-4],ECX
  MOV byte ptr [EBX+ECX],0
  @1: MOV EAX,EDX
  MOV EDX,EBX
  CALL dword ptr [MoveFast]
  POP EBX
End;

Procedure FastNewRawUTF8(Var s: RawUTF8; len: Integer);
Asm // eax=s edx=len
  TEST EDX,EDX
  MOV ECX,[EAX]
  JZ System.@LStrClr
  TEST ECX,ECX
  JZ @set
  CMP dword ptr [ECX-8],1
  JNE @set
  CMP dword ptr [ECX-4],EDX
  JE @out
  @set:MOV ECX,EDX
  XOR EDX,EDX
{$ifdef UNICODE}
  PUSH CP_UTF8 // UTF-8 code page for Delphi 2009+
  CALL  System.@LStrFromPCharLen // we need a call, not a jmp here
{$else}
  JMP System.@LStrFromPCharLen
{$endif}
  @out:
End;

(******************************************************************************)

Constructor TTextWriter.Create(aStream: TStream; aBufSize: Integer);
Begin
  InHerited Create();

  SetStream(aStream);
  If aBufSize<256 Then
    aBufSize := 256;
  fTempBufSize := aBufSize;
  GetMem(fTempBuf,aBufSize);
  B := fTempBuf-1; // Add() methods will append at B+1
  BEnd := fTempBuf+fTempBufSize-2;

  fStreamIsOwned := False;
End;

Constructor TTextWriter.CreateOwnedStream(aBufSize: Integer);
Begin
  InHerited Create();

  Create(TRawByteStringStream.Create, aBufSize);
  fStreamIsOwned := True;
End;

Destructor TTextWriter.Destroy;
Begin
  If fStreamIsOwned Then
    fStream.Free;
  FreeMem(fTempBuf);

  Inherited;
End;

Procedure TTextWriter.SetStream(aStream: TStream);
Begin
  If fStream <> Nil Then
    If fStreamIsOwned Then
      FreeAndNil(fStream);

  If aStream <> Nil Then
  Begin
    fStream := aStream;
    fInitialStreamPosition := fStream.Seek(0,soFromCurrent);
    fTotalFileSize := fInitialStreamPosition;
  End;
End;

Procedure TTextWriter.FlushFinal;
Begin
  Include(fCustomOptions,twoFlushToStreamNoAutoResize);
  FlushToStream;
End;

Procedure TTextWriter.FlushToStream;
Begin
//  if fEchos<>nil then begin
//    EchoFlush;
//    fEchoStart := 0;
//  end;
  inc(fTotalFileSize,fStream.Write(fTempBuf^,B-fTempBuf+1));
  If (Not (twoFlushToStreamNoAutoResize In fCustomOptions)) And
    (fTempBufSize<49152) And
    (fTotalFileSize-fInitialStreamPosition>1 Shl 18) Then
  Begin
    FreeMem(fTempBuf); // with big content (256KB) comes bigger buffer (64KB)
    fTempBufSize := 65536;
    GetMem(fTempBuf,65536);
    BEnd := fTempBuf+(65536-2);
  End;
  B := fTempBuf-1;
End;

Procedure TTextWriter.SetText(Var result: RawUTF8);
Var Len: Cardinal;
Begin
  FlushFinal;
  Len := fTotalFileSize-fInitialStreamPosition;
  If Len=0 Then
    result := '' Else
  If fStream.InheritsFrom(TRawByteStringStream) Then
    With TRawByteStringStream(fStream) Do
      If fInitialStreamPosition=0 Then
        result := DataString Else
        SetRawUTF8(result,PAnsiChar(pointer(DataString))+fInitialStreamPosition,Len) Else
  If fStream.InheritsFrom(TCustomMemoryStream) Then
    With TCustomMemoryStream(fStream) Do
      SetRawUTF8(result,PAnsiChar(Memory)+fInitialStreamPosition,Len) Else
  Begin
    FastNewRawUTF8(result,Len);
    fStream.Seek(fInitialStreamPosition,soBeginning);
    fStream.Read(pointer(result)^,Len);
  End;
End;

Procedure TTextWriter.Add(c: AnsiChar);
Begin
  If B>=BEnd Then
    FlushToStream;
  B[1] := c;
  inc(B);
End;

Procedure TTextWriter.Add(c1, c2: AnsiChar);
Begin
  If BEnd-B<=1 Then
    FlushToStream;
  B[1] := c1;
  B[2] := c2;
  inc(B,2);
End;

Procedure TTextWriter.AddCRAndIndent;
Var ntabs: Cardinal;
Begin
  If B^=#9 Then
    exit; // we most probably just added an indentation level
  ntabs := fHumanReadableLevel;
  If ntabs>=Cardinal(fTempBufSize) Then
    exit; // avoid buffer overflow
  If BEnd-B<=Integer(ntabs)+1 Then
    FlushToStream;
  pWord(B+1)^ := 13+10 Shl 8; // CR + LF

  FillcharFast(B[3],ntabs*2,$20);
  Inc(B, (ntabs*2)+2);
//  FillcharFast(B[3],ntabs,9); // indentation using tabs
//  inc(B,ntabs+2);
End;

Procedure TTextWriter.AddShort(Const Text: ShortString);
Begin
  If ord(Text[0])=0 Then
    exit;
  If BEnd-B<=ord(Text[0]) Then
    FlushToStream;
  MoveFast(Text[1],B[1],ord(Text[0]));
  inc(B,ord(Text[0]));
End;

Function TTextWriter.GetJSONField(P: PUTF8Char; out PDest: PUTF8Char;
  wasString: PBoolean=Nil; EndOfObject: PUTF8Char=Nil): PUTF8Char;
// this code is very fast
Var D: PUTF8Char;
  b,c4: Integer;
Label slash,num;
Begin
  If wasString<>Nil Then
    wasString^ := False; // default is 'no string'
  PDest := Nil; // PDest=nil indicates error or unexpected end (#0)
  result := Nil;
  If P = Nil Then
    exit;

  If P^ <= ' ' Then
    Repeat inc(P);
      If P^ = #0 Then
        exit;
    Until P^ > ' ';

  Case P^ Of
    'n':
    If (PInteger(P)^=NULL_LOW) And (P[4] In EndOfJSONValueField)  Then
    Begin
      result := Nil; // null -> returns nil and wasString=false
      inc(P,3);
    End
    Else
      exit; // PDest=nil to indicate error

    'f':
    If (PInteger(P+1)^=ord('a')+ord('l')Shl 8+ord('s')Shl 16+ord('e')Shl 24) And
      (P[5] In EndOfJSONValueField) Then
    Begin
      result := P; // false -> returns 'false' and wasString=false
      inc(P,4);
    End
    Else
      exit; // PDest=nil to indicate error

    't':
    If (PInteger(P)^=TRUE_LOW) And (P[4] In EndOfJSONValueField)  Then
    Begin
      result := P; // true -> returns 'true' and wasString=false
      inc(P,3);
    End
    Else
      exit; // PDest=nil to indicate error

    '"':
    Begin
    // '"string \"\\field"' -> 'string "\field'
      If wasString<>Nil Then
        wasString^ := True;
      inc(P);
      result := P;
      D := P;
      Repeat // unescape P^ into U^ (cf. http://www.ietf.org/rfc/rfc4627.txt)
        Case P^ Of
          #0:
            exit;  // leave PDest=nil for unexpected end
          '"':
            break; // end of string
          '\':
            Goto slash;
        Else
        Begin
          D^ := P^; // 3 stages pipelined process of unescaped chars
          inc(P);
          inc(D);
          Case P^ Of
            #0: exit;
            '"': break;
            '\': Goto slash;
          Else
            D^ := P^;
            inc(P);
            inc(D);
            Case P^ Of
              #0: exit;
              '"': break;
              '\': Goto slash;
            Else
              D^ := P^;
              inc(P);
              inc(D);
              continue;
            End;
          End;
        End;
        End;
        slash:
          inc(P);
        Case P^ Of // unescape JSON string
          #0:
            exit; // to avoid potential buffer overflow issue for \#0
          'b':
            D^ := #08;
          't':
            D^ := #09;
          'n':
            D^ := #$0a;
          'f':
            D^ := #$0c;
          'r':
            D^ := #$0d;
          'u':
          Begin // inlined decoding of '\0123' UTF-16 codepoint into UTF-8
            c4 := ConvertHexToBin[ord(P[1])];
            If c4<=15 Then
            Begin
              b := ConvertHexToBin[ord(P[2])];
              If b<=15 Then
              Begin
                c4 := c4 Shl 4+b;
                b  := ConvertHexToBin[ord(P[3])];
                If b<=15 Then
                Begin
                  c4 := c4 Shl 4+b;
                  b  := ConvertHexToBin[ord(P[4])];
                  If b<=15 Then
                  Begin
                    c4 := c4 Shl 4+b;
                    If c4<>0 Then
                    Begin
                      If c4<=$7F Then
                      Begin
                        D^ := AnsiChar(c4);
                        inc(D);
                      End
                      Else
                      If c4>$7ff Then
                      Begin
                        D^ := AnsiChar($E0 Or (c4 Shr 12));
                        D[1] := AnsiChar($80 Or ((c4 Shr 6) And $3F));
                        D[2] := AnsiChar($80 Or (c4 And $3F));
                        inc(D,3);
                      End
                      Else
                      Begin
                        D^ := AnsiChar($C0 Or (c4 Shr 6));
                        D[1] := AnsiChar($80 Or (c4 And $3F));
                        inc(D,2);
                      End;
                      inc(P,5);
                      continue;
                    End;
                  End;
                End;
              End;
            End;
            D^ := '?'; // bad formated hexa number -> '?0123'
          End;
        Else
          D^ := P^; // litterals: '\"' -> '"'
        End;
        inc(P);
        inc(D);
      Until False;
    // here P^='"'
      D^ := #0; // make zero-terminated
      inc(P);
      If P^=#0 Then
        exit;
    End;

    '0':
      If P[1] In ['0'..'9'] Then // 0123 excluded by JSON!
        exit
      Else // leave PDest=nil for unexpected end
        Goto num;
        
    '-','1'..'9':
    Begin
      num:// numerical field: all chars before end of field
        result := P;
      Repeat
        If Not (P^ In DigitFloatChars) Then
          break;
        inc(P);
      Until False;
      If P^=#0 Then
        exit;
      If P^<=' ' Then
        P^ := #0; // force numerical field with no trailing ' '
    End;
  Else
    exit; // PDest=nil to indicate error
  End;

  If Not (P^ In EndOfJSONField) Then
  Begin
    inc(P);
    While Not (P^ In EndOfJSONField) Do
    Begin
      inc(P);
      If P^=#0 Then
        exit; // leave PDest=nil for unexpected end
    End;
  End;

  If EndOfObject<>Nil Then
    EndOfObject^ := P^;

  P^ := #0; // make zero-terminated
  PDest := @P[1];
  If P[1]=#0 Then
    PDest := Nil;
End;

Function TTextWriter.GetJSONPropName(Var P: PUTF8Char): PUTF8Char;
Var Name: PUTF8Char;
  wasString: Boolean;
  EndOfObject: AnsiChar;
Begin  // should match GotoNextJSONObjectOrArray() and JsonPropNameValid()
  result := Nil;
  
  If P=Nil Then
    exit;

  If P^ In [#1..' '] Then
    Repeat inc(P) Until Not(P^ In [#1..' ']);

  Name := P; // put here to please some versions of Delphi compiler 
  Case P^ Of
    '_','A'..'Z','a'..'z','0'..'9','$':
    Begin // e.g. '{age:{$gt:18}}'
      Repeat
        inc(P);
      Until Not (ord(P[0]) In IsJsonIdentifier);

      If P^ In [#1..' '] Then
      Begin
        P^ := #0;
        inc(P);
      End;

      If P^ In [#1..' '] Then
        Repeat inc(P) Until Not(P^ In [#1..' ']);

      If Not (P^ In [':','=']) Then // allow both age:18 and age=18 pairs
        exit;

      P^ := #0;
      inc(P);
    End;

    '''':
    Begin // single quotes won't handle nested quote character
      inc(P);
      Name := P;
      While P^ <> '''' Do
        If P^ < ' ' Then
          exit
        Else
          inc(P);

      P^ := #0;
      Repeat inc(P) Until Not(P^ In [#1..' ']);
      If P^<>':' Then
        exit;
      inc(P);
    End;

    '"':
    Begin
      Name := GetJSONField(P,P,@wasString,@EndOfObject);
      If (Name=Nil) Or (Not wasString) Or (EndOfObject<>':') Then
        exit;
    End

    Else
      exit;
  End;
  result := Name;
End;

Function TTextWriter.JsonPropNameValid(P: PUTF8Char): Boolean;
Asm
  TEST EAX,EAX
  JZ @z
  MOVZX EDX,byte ptr [EAX]
  BT [offset @f],EDX
  MOV ECX,offset @c
  JB @2
  XOR EAX,EAX
  @z: RET
  @f: DD 0,$03FF0010,$87FFFFFE,$07FFFFFE,0,0,0,0 // IsJsonIdentifierFirstChar
  @c: DD 0,$03FF4000,$AFFFFFFE,$07FFFFFE,0,0,0,0 // IsJsonIdentifier
  @s: MOV DL,[EAX]
  BT [ECX],EDX
  JNB @1
  @2: MOV DL,[EAX+1]
  BT [ECX],EDX
  JNB @1
  MOV DL,[EAX+2]
  BT [ECX],EDX
  JNB @1
  MOV DL,[EAX+3]
  BT [ECX],EDX
  LEA EAX,[EAX+4]
  JB @s
  @1: TEST DL,DL
  SETZ AL
End;

Procedure TTextWriter.AddNoJSONEscape(P: Pointer; Len: Integer);
Var i: Integer;
Begin
  If (P<>Nil) And (Len>0) Then
  Begin
    inc(B); // allow CancelLastChar
    Repeat
      i := BEnd-B+1; // guess biggest size to be added into buf^ at once
      If Len<i Then
        i := Len;
      // add UTF-8 bytes
      MoveFast(P^,B^,i);
      inc(B,i);
      If i=Len Then
        break;
      inc(PByte(P),i);
      dec(Len,i);
      // FlushInc writes B-buf+1 -> special one below:
      inc(fTotalFileSize,fStream.Write(fTempBuf^,B-fTempBuf));
      B := fTempBuf;
    Until False;
    dec(B); // allow CancelLastChar
  End;
End;

Procedure TTextWriter.AddJSONEscape(P: Pointer; Len: PtrInt);
Var i,c: Integer;
Label noesc;
Begin
  If P=Nil Then
    exit;

  If Len=0 Then
    Len := MaxInt;

  i := 0;
  While i<Len Do
  Begin
    If Not(PByteArray(P)[i] In JSON_ESCAPE) Then
    Begin
      noesc:
        c := i;
      Repeat
        inc(i);
      Until (i>=Len) Or (PByteArray(P)[i] In JSON_ESCAPE);
      inc(PByte(P),c);
      dec(i,c);
      dec(Len,c);
      If BEnd-B<=i Then
        AddNoJSONEscape(P,i) Else
      Begin
        MoveFast(P^,B[1],i);
        inc(B,i);
      End;
    End;

    While i<Len Do
    Begin
      c := PByteArray(P)[i];
      
      Case c Of
        0:
          exit;
        8:
          c := ord('\')+ord('b')Shl 8;
        9:
          c := ord('\')+ord('t')Shl 8;
        10:
          c := ord('\')+ord('n')Shl 8;
        12:
          c := ord('\')+ord('f')Shl 8;
        13:
          c := ord('\')+ord('r')Shl 8;
        ord('\'):
          c := ord('\')+ord('\')Shl 8;
        ord('"'):
          c := ord('\')+ord('"')Shl 8;
        1..7,11,14..31:
        Begin // characters below ' ', #7 e.g. -> // 'u0007'
          AddShort('\u00');
          c := TwoDigitsHexWB[c];
        End;
      Else
        Goto noesc;
      End;

      If BEnd-B<=1 Then
        FlushToStream;

      PWord(B+1)^ := c;
      inc(B,2);
      inc(i);
    End;
  End;
End;

Function TTextWriter.GotoEndOfJSONString(P: PUTF8Char): PUTF8Char;
Begin // P^='"' at function call
  inc(P);
  Repeat
    If P^=#0 Then
      break
    Else If P^<>'\' Then
      If P^<>'"' Then // ignore \"
        inc(P)
      Else
        break
    Else    // found ending "
    If P[1]=#0 Then // avoid potential buffer overflow issue for \#0
      break
    Else
      inc(P,2);     // ignore \?
  Until False;
  result := P;
End; // P^='"' at function return

Function TTextWriter.AddJSONReformat(JSON: PUTF8Char;
  Format: TTextWriterJSONFormat; EndOfObject: PUTF8Char): PUTF8Char;
Var objEnd: AnsiChar;
  Name,Value: PUTF8Char;
  ValueLen: Integer;
Begin
  result := Nil;
  If JSON=Nil Then
    exit;

  If JSON^ In [#1..' '] Then
    Repeat inc(JSON) Until Not(JSON^ In [#1..' ']);

  Case JSON^ Of
    '[':
    Begin // array
      Repeat inc(JSON) Until Not(JSON^ In [#1..' ']);

      If JSON^=']' Then
      Begin
        Add('[');
        inc(JSON);
      End
      Else
      Begin
        If Not (Format In [jsonCompact,jsonUnquotedPropNameCompact]) Then
          AddCRAndIndent;
        inc(fHumanReadableLevel);
        Add('[');
        Repeat
          If JSON=Nil Then
            exit;
          If Not (Format In [jsonCompact,jsonUnquotedPropNameCompact]) Then
            AddCRAndIndent;
          JSON := AddJSONReformat(JSON,Format,@objEnd);
          If objEnd=']' Then
            break;
          Add(objEnd);
        Until False;
        dec(fHumanReadableLevel);
        If Not (Format In [jsonCompact,jsonUnquotedPropNameCompact]) Then
          AddCRAndIndent;
      End;
      Add(']');
    End;

    '{':
    Begin // object
      Repeat inc(JSON) Until Not(JSON^ In [#1..' ']);
      Add('{');
      inc(fHumanReadableLevel);
      If Not (Format In [jsonCompact,jsonUnquotedPropNameCompact]) Then
        AddCRAndIndent;
      If JSON^='}' Then
        Repeat inc(JSON) Until Not(JSON^ In [#1..' ']) Else
        Repeat
          Name := GetJSONPropName(JSON);
          If Name=Nil Then
            exit;
          If (Format In [jsonUnquotedPropName,jsonUnquotedPropNameCompact]) And
            JsonPropNameValid(Name) Then
            AddNoJSONEscape(Name,StrLen(Name)) Else
          Begin
            Add('"');
            AddJSONEscape(Name);
            Add('"');
          End;
          If Format In [jsonCompact,jsonUnquotedPropNameCompact] Then
            Add(':') Else
            Add(':',' ');
          If JSON^ In [#1..' '] Then
            Repeat inc(JSON) Until Not(JSON^ In [#1..' ']);
          JSON := AddJSONReformat(JSON,Format,@objEnd);
          If objEnd='}' Then
            break;
          Add(objEnd);
          If Not (Format In [jsonCompact,jsonUnquotedPropNameCompact]) Then
            AddCRAndIndent;
        Until False;
      dec(fHumanReadableLevel);
      If Not (Format In [jsonCompact,jsonUnquotedPropNameCompact]) Then
        AddCRAndIndent;
      Add('}');
    End;

    '"':
    Begin // string
      Value := JSON;
      JSON  := GotoEndOfJSONString(JSON);
      If JSON^<>'"' Then
        exit;
      inc(JSON);
      AddNoJSONEscape(Value,JSON-Value);
    End;

  Else
    // numeric or true/false/null
    Value := GetJSONField(JSON,result,Nil,EndOfObject); // let wasString=nil
    If Value=Nil Then
      AddShort('null') Else
    Begin
      ValueLen := StrLen(Value);
      While (ValueLen>0) And (Value[ValueLen-1]<=' ') Do
        dec(ValueLen);
      AddNoJSONEscape(Value,ValueLen);
    End;
    exit;
  End;

  If JSON<>Nil Then
  Begin
    If JSON^ In [#1..' '] Then
      Repeat inc(JSON) Until Not(JSON^ In [#1..' ']);
    If EndOfObject<>Nil Then
      EndOfObject^ := JSON^;
    If JSON^<>#0 Then
      Repeat inc(JSON) Until Not(JSON^ In [#1..' ']);
  End;
  result := JSON;
End;

(******************************************************************************)

Function FormatJSonData(Const JSON: RawUTF8; Format: TTextWriterJSONFormat) : RawUTF8;
Var Tmp : RawUTF8;
    n   : Integer;
Begin
  n := length(JSON);
  SetString(Tmp, PAnsiChar(Pointer(JSON)), n); // make local copy
  If n < 4096 Then
    n := 4096
  Else // minimal rough estimation of the output buffer size
    inc(n,n Shr 4);

  With TTextWriter.CreateOwnedStream(n) Do
  Try
    AddJSONReformat(Pointer(Tmp), Format, Nil);
    SetText(Result);

    Finally
      Free();
  End;
End;

Function FormatJSonData(AStream : TStream;
  Format: TTextWriterJSONFormat=jsonHumanReadable): RawUTF8; OverLoad;
Begin
  With TTextWriter.Create(AStream, AStream.Size) Do
  Try
    If AStream Is TRawByteStringStream Then
    Begin
      AddJSONReformat(Pointer(TRawByteStringStream(AStream).DataString), Format, Nil);
      SetText(Result);
    End;

    Finally
      Free();
  End;
End;

Procedure Init();
Const
  HexChars: Array[0..15] Of AnsiChar = '0123456789ABCDEF';

Var v : Byte;
    I : Integer;
Begin
  FillcharFast(ConvertHexToBin[0], sizeof(ConvertHexToBin), 255);
  v := 0;
  For i := ord('0') To ord('9') Do
  Begin
    ConvertHexToBin[i] := v;
    inc(v);
  End;

  For i := ord('A') To ord('F') Do
  Begin
    ConvertHexToBin[i] := v;
    ConvertHexToBin[i+(ord('a')-ord('A'))] := v;
    inc(v);
  End;

  For i := 0 To 255 Do
  Begin
    TwoDigitsHex[i][1] := HexChars[i Shr 4];
    TwoDigitsHex[i][2] := HexChars[i And $f];
  End;
End;

Initialization
  Init();

End.
