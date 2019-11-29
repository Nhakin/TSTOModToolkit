Unit RegExpObj;

Interface

//http://rvelthuis.de/articles/articles-cobjs.html

Const
  RE_OK                   = 0;
  RE_NOTFOUND             = 1;
  RE_INVALIDPARAMETER     = 2;
  RE_EXPRESSIONTOOBIG     = 3;
  RE_OUTOFMEMORY          = 4;
  RE_TOOMANYSUBEXPS       = 5;
  RE_UNMATCHEDPARENS      = 6;
  RE_INVALIDREPEAT        = 7;
  RE_NESTEDREPEAT         = 8;
  RE_INVALIDRANGE         = 9;
  RE_UNMATCHEDBRACKET     = 10;
  RE_TRAILINGBACKSLASH    = 11;
  RE_INTERNAL             = 20;
  RE_NOPROG               = 30;
  RE_NOSTRING             = 31;
  RE_NOMAGIC              = 32;
  RE_NOMATCH              = 33;
  RE_NOEND                = 34;
  RE_INVALIDHANDLE        = 99;

Type
  HRegExp = Type Pointer;

  TRegMatch = Record
    Start : Cardinal;        { Start of match }
    Stop  : Cardinal;        { End of match }
  End;

Function  RegComp(Pattern : String; Var Error : Integer) : HRegExp; Stdcall;
Function  RegExec(RegEx : HRegExp; Str : String; Var Match : TRegMatch) : Integer; Stdcall;
Function  RegError(Regex : HRegExp; Error : Integer; Var ErrorBuf : String) : Integer; Stdcall;
Procedure RegFree(Regex : HRegExp); Stdcall;
Function  RegPointer(Regex : HRegExp) : Pointer; Stdcall;

Implementation

Uses SysUtils;

{$L regexp.obj}

Const
  NSUBEXP = 10;
  MAGIC = 156;

Type
  PRegExp = ^_RegExp;
  _RegExp = Packed Record
    StartP   : Array[0..NSUBEXP - 1] Of PChar;
    EndP     : Array[0..NSUBEXP - 1] Of PChar;
    RegStart : Char;                // Internal use only.
    RegAnch  : Char;                // Internal use only.
    RegMust  : PChar;               // Internal use only.
    RegMLen  : Integer;             // Internal use only.
    Prog     : Array[0..0] Of Char; // Internal use only.
  End;
  
Function _regcomp(exp : PChar) : PRegExp; Cdecl; External;
Function _regexec(prog : PRegExp; str : PChar) : Longbool; Cdecl; External;
Function _reggeterror : Integer; Cdecl; External;
Procedure _regseterror(Err : Integer); Cdecl; External;

(******************************************************************************)

Function _malloc(Size : Cardinal) : Pointer; Cdecl;
Begin
  GetMem(Result, Size);
End;

Function _strlen(Const Str: PChar): Cardinal; Cdecl; External 'msvcrt.dll' Name 'strlen';
Function _strcspn(s1, s2: PChar): Cardinal; Cdecl; External 'msvcrt.dll' Name 'strcspn';
Function _strchr(Const S: PChar; C: Integer): PChar; Cdecl; External 'msvcrt.dll' Name 'strchr';
Function _strncmp(S1, S2: PChar; MaxLen: Cardinal): Integer; Cdecl; External 'msvcrt.dll' Name 'strncmp';

//function _sprintf(S: PChar; const Format: PChar): Integer; cdecl; varargs; external 'msvcrt.dll' name 'sprintf';
//function _fscanf(Stream: Pointer; const Format: PChar): Integer; cdecl; varargs; external 'msvcrt.dll' name 'fscanf';

(*
Function _strlen(Const Str : PChar) : Cardinal; Cdecl;
Begin
  Result := StrLen(Str);
End;

Function _strcspn(s1, s2 : PChar) : Cardinal; Cdecl;
Label Bye;
Var
  SrchS2 : PChar;
  Len    : Integer;
Begin
  Len := 0;
  While S1^ <> #0 Do
  Begin
    SrchS2 := S2;

    While SrchS2^ <> #0 Do
    Begin
      If S1^ = SrchS2^ Then
        Goto Bye;
      Inc(SrchS2);
    End;

    Inc(S1);
    Inc(Len);
  End;
  Bye:
    Result := Len;
End;

Function _strchr(Const S: PChar; C: Integer): PChar; Cdecl;
Begin
  Result := StrScan(S, Chr(C));
End;

Function _strncmp(S1, S2: PChar; MaxLen: Cardinal): Integer; Cdecl;
Begin
  Result := StrLComp(S1, S2, MaxLen);
End;
*)
(******************************************************************************)

Resourcestring
  S_OK                = 'No error';
  S_NOTFOUND          = 'Not found';
  S_INVALIDPARAMETER  = 'Invalid parameter';
  S_EXPRESSIONTOOBIG  = 'Expression too big';
  S_OUTOFMEMORY       = 'Not enough memory';
  S_TOOMANYSUBEXPS    = 'Too many subexpresssions';
  S_UNMATCHEDPARENS   = 'Unmatched parentheses';
  S_INVALIDREPEAT     = 'Invalid repeat';
  S_NESTEDREPEAT      = 'Nested repeat';
  S_INVALIDRANGE      = 'Invalid range';
  S_UNMATCHEDBRACKET  = 'Unmatched bracket';
  S_TRAILINGBACKSLASH = 'Trailing backslash';
  S_INTERNAL          = 'Internal error - should not happen';
  S_NOPROG            = 'No compiled expression';
  S_NOSTRING          = 'No string';
  S_NOMAGIC           = 'Invalid compiled expression';
  S_NOMATCH           = 'No match';
  S_NOEND             = 'No end';
  S_INVALIDHANDLE     = 'Invalid handle';

Function VerifyHandle(Const Reg : HRegExp): Boolean;
Var
  PReg : PRegExp Absolute Reg;
Begin
  Result := (PReg <> Nil) And
            (PReg.Prog[0] = Chr(MAGIC));
End;

Function RegComp(Pattern : String; Var Error : Integer) : HRegExp; Stdcall;
Begin
  Result := _regcomp(PChar(Pattern));
  If Result = Nil Then
    Error := _reggeterror
  Else
    Error := RE_OK;
End;

Function RegExec(RegEx : HRegExp; Str: String; Var Match : TRegMatch) : Integer; Stdcall;
Var
  PReg : PRegExp Absolute RegEx;
Begin
  _regseterror(0);

  If _regexec(PReg, PChar(str)) Then
  Begin
    Match.Start := PReg.StartP[0] - PChar(Str);
    Match.Stop  := PReg.EndP[0] - PChar(Str);
    Result := RE_OK;
  End
  Else If _reggeterror <> 0 Then
    Result := _reggeterror
  Else
    Result := RE_NOTFOUND;
End;

Function RegError(Regex : HRegExp; Error : Integer; Var ErrorBuf : String) : Integer; Stdcall;
Begin
  If VerifyHandle(Regex) Then
  Begin
    Case Error Of
      RE_OK : ErrorBuf := S_OK;
      RE_NOTFOUND : ErrorBuf := S_NOTFOUND;
      RE_INVALIDPARAMETER : ErrorBuf := S_INVALIDPARAMETER;
      RE_EXPRESSIONTOOBIG : ErrorBuf := S_EXPRESSIONTOOBIG;
      RE_OUTOFMEMORY : ErrorBuf := S_OUTOFMEMORY;
      RE_TOOMANYSUBEXPS : ErrorBuf := S_TOOMANYSUBEXPS;
      RE_UNMATCHEDPARENS : ErrorBuf := S_UNMATCHEDPARENS;
      RE_INVALIDREPEAT : ErrorBuf := S_INVALIDREPEAT;
      RE_NESTEDREPEAT : ErrorBuf := S_NESTEDREPEAT;
      RE_INVALIDRANGE : ErrorBuf := S_INVALIDRANGE;
      RE_UNMATCHEDBRACKET : ErrorBuf := S_UNMATCHEDBRACKET;
      RE_TRAILINGBACKSLASH : ErrorBuf := S_TRAILINGBACKSLASH;
      RE_INTERNAL : ErrorBuf := S_INTERNAL;
      RE_NOPROG : ErrorBuf := S_NOPROG;
      RE_NOSTRING : ErrorBuf := S_NOSTRING;
      RE_NOMAGIC : ErrorBuf := S_NOMAGIC;
      RE_NOMATCH : ErrorBuf := S_NOMATCH;
      RE_NOEND : ErrorBuf := S_NOEND;
      RE_INVALIDHANDLE : ErrorBuf := S_INVALIDHANDLE;
    End;
    
    Result := RE_OK;
  End
  Else
    Result := RE_INVALIDHANDLE;
End;

Procedure RegFree(Regex : HRegExp); Stdcall;
Begin
  FreeMem(Pointer(Regex));
End;

Function RegPointer(Regex : HRegExp) : Pointer; Stdcall;
Begin
  Result := @PRegExp(Regex)^.Prog;
End;

End.

