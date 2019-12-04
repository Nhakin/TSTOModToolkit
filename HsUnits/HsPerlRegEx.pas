unit HsPerlRegEx;

interface

Uses
  Windows, Classes, HsInterfaceEx, pcre;

Type
  TPerlRegExOptions = Set Of (
    preCaseLess,       
    preMultiLine,      
    preSingleLine,     
    preExtended,       
    preAnchored,       
    preUnGreedy,       
    preNoAutoCapture
  );

  TPerlRegExState = Set Of (
    preNotBOL,         
    preNotEOL,         
    preNotEmpty        
  );

{$IFDEF UNICODE}
  {$WARN IMPLICIT_STRING_CAST OFF}
  PCREString = UTF8String;
{$ELSE UNICODE}
  PCREString = Ansistring;
{$ENDIF UNICODE}

  TPerlRegExReplaceEvent = Procedure(Sender : TObject; Var ReplaceWith : PCREString) Of Object;

Type
  IHsPerlRegEx = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-883A-28FB8F49A42E}']
    Function  GetCompiled() : Boolean;
    Function  GetFoundMatch() : Boolean;
    Function  GetStudied() : Boolean;
    Function  GetMatchedText() : PCREString;
    Function  GetMatchedLength() : Integer;
    Function  GetMatchedOffset() : Integer;
    Function  GetStart() : Integer;
    Procedure SetStart(Const AStart : Integer);
    Function  GetStop() : Integer;
    Procedure SetStop(Const AStop : Integer);
    Function  GetState() : TPerlRegExState;
    Procedure SetState(Const AState : TPerlRegExState);
    Function  GetSubject() : PCREString;
    Procedure SetSubject(Const ASubject : PCREString);
    Function  GetSubjectLeft() : PCREString;
    Function  GetSubjectRight() : PCREString;
    Function  GetOptions() : TPerlRegExOptions;
    Procedure SetOptions(AOptions : TPerlRegExOptions);
    Function  GetRegEx() : PCREString;
    Procedure SetRegEx(Const ARegEx : PCREString);
    Function  GetReplacement() : PCREString;
    Procedure SetReplacement(Const AReplacement : PCREString);
    Function  GetGroupCount() : Integer;
    Function  GetGroups(Index : Integer) : PCREString;
    Function  GetGroupLengths(Index : Integer) : Integer;
    Function  GetGroupOffsets(Index : Integer) : Integer;
    Function  GetOnMatch() : TNotifyEvent;
    Procedure SetOnMatch(Const AOnMatch : TNotifyEvent);
    Function  GetOnReplace() : TPerlRegExReplaceEvent;
    Procedure SetOnReplace(Const AOnReplace : TPerlRegExReplaceEvent);

    Procedure Compile();
    Procedure Study();
    Function  Match() : Boolean;
    Function  MatchAgain() : Boolean;
    Function  Replace() : PCREString;
    Function  ReplaceAll() : Boolean;
    Function  ComputeReplacement() : PCREString;
    Procedure StoreGroups();
    Function  NamedGroup(Const Name : PCREString) : Integer;
    Procedure Split(Strings : TStrings; Limit : Integer);
    Procedure SplitCapture(Strings : TStrings; Limit : Integer); Overload;
    Procedure SplitCapture(Strings : TStrings; Limit : Integer; Offset : Integer); Overload;
    Function  EscapeRegExChars(Const S : String) : String;

    Property Compiled      : Boolean           Read GetCompiled;
    Property FoundMatch    : Boolean           Read GetFoundMatch;
    Property Studied       : Boolean           Read GetStudied;
    Property MatchedText   : PCREString        Read GetMatchedText;
    Property MatchedLength : Integer           Read GetMatchedLength;
    Property MatchedOffset : Integer           Read GetMatchedOffset;
    Property Start         : Integer           Read GetStart         Write SetStart;
    Property Stop          : Integer           Read GetStop          Write SetStop;
    Property State         : TPerlRegExState   Read GetState         Write SetState;
    Property Subject       : PCREString        Read GetSubject       Write SetSubject;
    Property SubjectLeft   : PCREString        Read GetSubjectLeft;
    Property SubjectRight  : PCREString        Read GetSubjectRight;
    Property Options       : TPerlRegExOptions Read GetOptions       Write SetOptions;
    Property RegEx         : PCREString        Read GetRegEx         Write SetRegEx;
    Property Replacement   : PCREString        Read GetReplacement   Write SetReplacement;

    Property GroupCount: Integer Read GetGroupCount;
    Property Groups[Index : Integer]       : PCREString Read GetGroups;
    Property GroupLengths[Index : Integer] : Integer    Read GetGroupLengths;
    Property GroupOffsets[Index : Integer] : Integer    Read GetGroupOffsets;

    Property OnMatch   : TNotifyEvent           Read GetOnMatch   Write SetOnMatch;
    Property OnReplace : TPerlRegExReplaceEvent Read GetOnReplace Write SetOnReplace;

  End;

  IHsPerlRegExListEnumerator = Interface(IInterfaceExEnumerator)
    ['{4B61686E-29A0-2112-9943-5CA3EC051724}']
    Function GetCurrent() : IHsPerlRegEx;
    Property Current : IHsPerlRegEx Read GetCurrent;

  End;

  IHsPerlRegExList = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-ABBD-DDCBC30A3F7C}']
    Function  Get(Index : Integer) : IHsPerlRegEx;
    Procedure Put(Index : Integer; Const Item : IHsPerlRegEx);

    Function Add() : IHsPerlRegEx; OverLoad;
    Function Add(Const AItem : IHsPerlRegEx) : Integer; OverLoad;

    Procedure Insert(Index : Integer; Const Item : IHsPerlRegEx);
    Function  Remove(Const Item : IHsPerlRegEx) : Integer;
    Function  Extract(Const Item : IHsPerlRegEx) : IHsPerlRegEx;
    Function  IndexOf(Const Item : IHsPerlRegEx) : Integer; 

    Function  GetEnumerator() : IHsPerlRegExListEnumerator; 

    Function  GetSubject() : PCREString;
    Procedure SetSubject(Const ASuject : PCREString);

    Function  GetStart() : Integer;
    Procedure SetStart(Const AStart : Integer);

    Function  GetStop() : Integer;
    Procedure SetStop(Const AStop : Integer);

    Function GetMatchedRegEx() : IHsPerlRegEx;

    Function Match() : Boolean;
    Function MatchAgain() : Boolean;

    Property Items[Index : Integer] : IHsPerlRegEx Read Get Write Put; Default;

    Property Subject      : PCREString   Read GetSubject Write SetSubject;
    Property Start        : Integer      Read GetStart   Write SetStart;
    Property Stop         : Integer      Read GetStop    Write SetStop;
    Property MatchedRegEx : IHsPerlRegEx Read GetMatchedRegEx;

  End;

  THsPerlRegEx = Class(TObject)
  Public
    Class Function CreateHsPerlRegEx() : IHsPerlRegEx;
    Class Function CreateHsPerlRegExList() : IHsPerlRegExList;

  End;

Const
  MAX_SUBEXPRESSIONS = 99;
  
implementation

Uses SysUtils;

Type
  THsPerlRegExImpl =  Class(TInterfacedObjectEx, IHsPerlRegEx)
  Strict Private   
    FCompiled    ,
    FStudied     : Boolean;
    FOptions     : TPerlRegExOptions;
    FState       : TPerlRegExState;
    FRegEx       ,
    FReplacement ,
    FSubject     : PCREString;
    FStart       ,
    FStop        : Integer;
    FOnMatch     : TNotifyEvent;
    FOnReplace   : TPerlRegExReplaceEvent;

  Protected
    Function  GetMatchedText() : PCREString;
    Function  GetMatchedLength() : Integer;
    Function  GetMatchedOffset() : Integer;

    Function  GetOptions() : TPerlRegExOptions;
    Procedure SetOptions(Value : TPerlRegExOptions);

    Function  GetRegEx() : PCREString;
    Procedure SetRegEx(Const Value : PCREString);

    Function  GetGroupCount() : Integer;
    Function  GetGroups(Index : Integer) : PCREString;
    Function  GetGroupLengths(Index : Integer) : Integer;
    Function  GetGroupOffsets(Index : Integer) : Integer;

    Function  GetSubject() : PCREString;
    Procedure SetSubject(Const Value : PCREString);

    Function  GetStart() : Integer;
    Procedure SetStart(Const Value : Integer);

    Function  GetStop() : Integer;
    Procedure SetStop(Const Value : Integer);

    Function  GetFoundMatch() : Boolean;

    Function  GetCompiled() : Boolean;
    Function  GetStudied() : Boolean;

    Function  GetState() : TPerlRegExState;
    Procedure SetState(Const AState : TPerlRegExState);

    Function  GetReplacement() : PCREString;
    Procedure SetReplacement(Const AReplacement : PCREString);

    Function  GetOnMatch() : TNotifyEvent;
    Procedure SetOnMatch(Const AOnMatch : TNotifyEvent);

    Function  GetOnReplace() : TPerlRegExReplaceEvent;
    Procedure SetOnReplace(Const AOnReplace : TPerlRegExReplaceEvent);

  Strict Private
    FOffsets         : Array[0..(MAX_SUBEXPRESSIONS + 1) * 3] Of Integer;
    FOffsetCount     : Integer;
    FpcreOptions     : Integer;
    FPattern         ,
    FHints           ,
    FCharTable       : Pointer;
    FSubjectPChar    : PAnsiChar;
    FHasStoredGroups : Boolean;
    FStoredGroups    : Array Of PCREString;

  Protected
    Function GetSubjectLeft() : PCREString;
    Function GetSubjectRight() : PCREString;

    Procedure CleanUp();
    Procedure ClearStoredGroups();

    Procedure Compile();
    Procedure Study();
    Function  Match() : Boolean;
    Function  MatchAgain() : Boolean;
    Function  Replace() : PCREString;
    Function  ReplaceAll() : Boolean;
    Function  ComputeReplacement() : PCREString;
    Procedure StoreGroups();
    Function  NamedGroup(Const Name : PCREString) : Integer;
    Procedure Split(Strings : TStrings; Limit : Integer);
    Procedure SplitCapture(Strings : TStrings; Limit : Integer); Overload;
    Procedure SplitCapture(Strings : TStrings; Limit : Integer; Offset : Integer); Overload;
    Function  EscapeRegExChars(Const S : String) : String;

  Public
    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;

  End;

  THsPerlRegExList = Class(TInterfaceListEx, IHsPerlRegExList)
  Strict Private Type
    THsPerlRegExListEnumerator = Class(TInterfaceExEnumerator, IHsPerlRegExListEnumerator)
    Protected
      Function GetCurrent() : IHsPerlRegEx; OverLoad;

    End;
    
  Strict Private
    FSubject      : PCREString;
    FMatchedRegEx : IHsPerlRegEx;
    FStart        ,
    FStop         : Integer;

    Procedure InitRegEx(ARegEx : IHsPerlRegEx);

  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;

    Function  Get(Index : Integer) : IHsPerlRegEx; OverLoad;
    Procedure Put(Index : Integer; Const Item : IHsPerlRegEx); OverLoad;

    Function Add() : IHsPerlRegEx; ReIntroduce; OverLoad;
    Function Add(Const AItem : IHsPerlRegEx) : Integer; OverLoad;

    Procedure Insert(Index : Integer; Const Item : IHsPerlRegEx); OverLoad;
    Function  Remove(Const Item : IHsPerlRegEx) : Integer; ReIntroduce; OverLoad;
    Function  Extract(Const Item : IHsPerlRegEx) : IHsPerlRegEx; OverLoad;
    Function  IndexOf(Const Item : IHsPerlRegEx) : Integer; ReIntroduce; OverLoad;

    Function  GetEnumerator() : IHsPerlRegExListEnumerator; OverLoad;

    Function  GetSubject() : PCREString;
    Procedure SetSubject(Const ASuject : PCREString);

    Function  GetStart() : Integer;
    Procedure SetStart(Const AStart : Integer);

    Function  GetStop() : Integer;
    Procedure SetStop(Const AStop : Integer);

    Function GetMatchedRegEx() : IHsPerlRegEx;

    Function Match() : Boolean;
    Function MatchAgain() : Boolean;

  End;
    
Class Function THsPerlRegEx.CreateHsPerlRegEx() : IHsPerlRegEx;
Begin
  Result := THsPerlRegExImpl.Create();
End;

Class Function THsPerlRegEx.CreateHsPerlRegExList() : IHsPerlRegExList;
Begin
  Result := THsPerlRegExList.Create();
End;

(******************************************************************************)
(*
Procedure THsPerlRegExImpl.AfterConstruction();
Begin
  InHerited AfterConstruction();

  FRegExImpl := Nil;
End;

Procedure THsPerlRegExImpl.BeforeDestruction();
Begin
  If Assigned(FRegExImpl) Then
    FreeAndNil(FRegExImpl);

  InHerited BeforeDestruction();
End;

Function THsPerlRegExImpl.GetRegExImpl() : TPerlRegEx;
Begin
  If Not Assigned(FRegExImpl) Then
    FRegExImpl := TPerlRegEx.Create();
  Result := FRegExImpl;
End;
*)
Procedure THsPerlRegExImpl.AfterConstruction();
Begin
  InHerited AfterConstruction();

  FState      := [preNotEmpty];
  FCharTable   := pcre_maketables;
{$IFDEF UNICODE}
  FpcreOptions := PCRE_UTF8 or PCRE_NEWLINE_ANY;
{$ELSE}
  FpcreOptions := PCRE_NEWLINE_ANY;
{$ENDIF}
End;

Procedure THsPerlRegExImpl.BeforeDestruction();
Begin
  pcre_dispose(FPattern, FHints, FCharTable);

  InHerited BeforeDestruction();
End;

Function THsPerlRegExImpl.EscapeRegExChars(Const S : String) : String;
Var I : Integer;
Begin
  Result := S;
  I      := Length(Result);
  While I > 0 Do
  Begin
    Case Result[I] Of
      '.', '[', ']', '(', ')', '?', '*', '+', '{', '}', '^', '$', '|', '\':
        Insert('\', Result, I);
      #0:
      Begin
        Result[I] := '0';
        Insert('\', Result, I);
      End;
    End;
    Dec(I);
  End;
End;

Function THsPerlRegExImpl.GetFoundMatch() : Boolean;
Begin
  Result := FOffsetCount > 0;
End;

Function THsPerlRegExImpl.GetMatchedText() : PCREString;
Begin
  Assert(GetFoundMatch(), 'REQUIRE: There must be a successful match first');
  Result := GetGroups(0);
End;

Function THsPerlRegExImpl.GetMatchedLength() : Integer;
Begin
  Assert(GetFoundMatch(), 'REQUIRE: There must be a successful match first');
  Result := GetGroupLengths(0);
End;

Function THsPerlRegExImpl.GetMatchedOffset() : Integer;
Begin
  Assert(GetFoundMatch(), 'REQUIRE: There must be a successful match first');
  Result := GetGroupOffsets(0);
End;

Function THsPerlRegExImpl.GetGroupCount() : Integer;
Begin
  Assert(GetFoundMatch(), 'REQUIRE: There must be a successful match first');
  Result := FOffsetCount - 1;
End;

Function THsPerlRegExImpl.GetGroupLengths(Index : Integer) : Integer;
Begin
  Assert(GetFoundMatch(), 'REQUIRE: There must be a successful match first');
  Assert((Index >= 0) And (Index <= GetGroupCount()), 'REQUIRE: Index <= GroupCount');
  Result := FOffsets[Index * 2 + 1] - FOffsets[Index * 2];
End;

Function THsPerlRegExImpl.GetGroupOffsets(Index : Integer) : Integer;
Begin
  Assert(GetFoundMatch(), 'REQUIRE: There must be a successful match first');
  Assert((Index >= 0) And (Index <= GetGroupCount()), 'REQUIRE: Index <= GroupCount');
  Result := FOffsets[Index * 2];
End;

Function THsPerlRegExImpl.GetGroups(Index : Integer) : PCREString;
Begin
  Assert(GetFoundMatch(), 'REQUIRE: There must be a successful match first');
  If Index > GetGroupCount() Then
    Result := ''
  Else If FHasStoredGroups Then
    Result := FStoredGroups[Index]
  Else
    Result := Copy(FSubject, FOffsets[Index * 2], FOffsets[Index * 2 + 1] - FOffsets[Index * 2]);
End;

Function THsPerlRegExImpl.GetCompiled() : Boolean;
Begin
  Result := FCompiled;
End;

Function THsPerlRegExImpl.GetStudied() : Boolean;
Begin
  Result := FStudied;
End;

Function THsPerlRegExImpl.GetStart() : Integer;
Begin
  Result := FStart;
End;

Function THsPerlRegExImpl.GetStop() : Integer;
Begin
  Result := FStop;
End;

Function THsPerlRegExImpl.GetState() : TPerlRegExState;
Begin
  Result := FState;
End;

Procedure THsPerlRegExImpl.SetState(Const AState : TPerlRegExState);
Begin
  FState := AState;
End;

Function THsPerlRegExImpl.GetSubject() : PCREString;
Begin
  Result := FSubject;
End;

Function THsPerlRegExImpl.GetOptions() : TPerlRegExOptions;
Begin
  Result := FOptions;
End;

Function THsPerlRegExImpl.GetRegEx() : PCREString;
Begin
  Result := FRegEx;
End;

Function THsPerlRegExImpl.GetReplacement() : PCREString;
Begin
  Result := FReplacement;
End;

Procedure THsPerlRegExImpl.SetReplacement(Const AReplacement : PCREString);
Begin
  FReplacement := AReplacement;
End;

Function THsPerlRegExImpl.GetOnMatch() : TNotifyEvent;
Begin
  Result := FOnMatch;
End;

Procedure THsPerlRegExImpl.SetOnMatch(Const AOnMatch : TNotifyEvent);
Begin
  FOnMatch := AOnMatch;
End;

Function THsPerlRegExImpl.GetOnReplace() : TPerlRegExReplaceEvent;
Begin
  Result := FOnReplace;
End;

Procedure THsPerlRegExImpl.SetOnReplace(Const AOnReplace : TPerlRegExReplaceEvent);
Begin
  FOnReplace := AOnReplace
End;

Function THsPerlRegExImpl.GetSubjectLeft() : PCREString;
Begin
  Result := Copy(GetSubject(), 1, FOffsets[0] - 1);
End;

Function THsPerlRegExImpl.GetSubjectRight() : PCREString;
Begin
  Result := Copy(FSubject, FOffsets[1], MaxInt);
End;

Procedure THsPerlRegExImpl.CleanUp();
Begin
  FCompiled := False;
  FStudied  := False;
  pcre_dispose(FPattern, FHints, Nil);
  FPattern := Nil;
  FHints   := Nil;
  ClearStoredGroups();
  FOffsetCount := 0;
End;

Procedure THsPerlRegExImpl.ClearStoredGroups();
Begin
  FHasStoredGroups := False;
  FStoredGroups    := Nil;
End;

Function THsPerlRegExImpl.Match() : Boolean;
Var I, Opts : Integer;
Begin
  ClearStoredGroups();

  If Not GetCompiled() Then
    Compile();

  If preNotBOL In GetState() Then
    Opts := PCRE_NOTBOL
  Else
    Opts := 0;

  If preNotEOL In GetState() Then
    Opts := Opts Or PCRE_NOTEOL;

  If preNotEmpty In GetState() Then
    Opts := Opts Or PCRE_NOTEMPTY;

  FOffsetCount := pcre_exec(FPattern, FHints, FSubjectPChar, FStop, 0, Opts, @FOffsets[0], High(FOffsets));
  Result := FOffsetCount > 0;

  If Result Then
  Begin
    For I := 0 To FOffsetCount * 2 - 1 Do
      Inc(FOffsets[I]);
    FStart := FOffsets[1];
    If FOffsets[0] = FOffsets[1] Then
      Inc(FStart); // Make sure we don't get stuck at the same position
    If Assigned(FOnMatch) Then
      FOnMatch(Self);
  End;
End;

Function THsPerlRegExImpl.MatchAgain() : Boolean;
Var
  I, Opts : Integer;
Begin
  ClearStoredGroups();

  If Not GetCompiled() Then
    Compile();

  If preNotBOL In GetState() Then
    Opts := PCRE_NOTBOL
  Else
    Opts := 0;

  If preNotEOL In GetState() Then
    Opts := Opts Or PCRE_NOTEOL;

  If preNotEmpty In GetState() Then
    Opts := Opts Or PCRE_NOTEMPTY;

  If FStart - 1 > FStop Then
    FOffsetCount := -1
  Else
    FOffsetCount := pcre_exec(FPattern, FHints, FSubjectPChar, FStop, FStart - 1, Opts, @FOffsets[0], High(FOffsets));

  Result := FOffsetCount > 0;
  // Convert offsets into PCREString indices
  If Result Then
  Begin
    For I := 0 To FOffsetCount * 2 - 1 Do
      Inc(FOffsets[I]);

    FStart := FOffsets[1];

    If FOffsets[0] = FOffsets[1] Then
      Inc(FStart); // Make sure we don't get stuck at the same position

    If Assigned(FOnMatch) Then
      FOnMatch(Self);
  End;
End;

Function THsPerlRegExImpl.NamedGroup(Const Name : PCREString) : Integer;
Begin
  Result := pcre_get_stringnumber(FPattern, PAnsiChar(Name));
End;

Function THsPerlRegExImpl.Replace() : PCREString;
Begin
  Assert(GetFoundMatch(), 'REQUIRE: There must be a successful match first');
  // Substitute backreferences
  Result := ComputeReplacement;
  // Allow for just-in-time substitution determination
  If Assigned(FOnReplace) Then
    FOnReplace(Self, Result);
  // Perform substitution
  Delete(FSubject, GetMatchedOffset(), GetMatchedLength());
  If Result <> '' Then
    Insert(Result, FSubject, GetMatchedOffset());
  FSubjectPChar := PAnsiChar(FSubject);
  // Position to continue search
  FStart := FStart - GetMatchedLength() + Length(Result);
  FStop  := FStop - GetMatchedLength() + Length(Result);
  // Replacement no longer matches regex, we assume
  ClearStoredGroups();
  FOffsetCount := 0;
End;

Function THsPerlRegExImpl.ReplaceAll() : Boolean;
Begin
  If Match() Then
  Begin
    Result := True;
    Repeat
      Replace();
    Until Not MatchAgain();
  End
  Else
    Result := False;
End;

Function THsPerlRegExImpl.ComputeReplacement() : PCREString;
Var
  Mode    : AnsiChar;
  S       : PCREString;
  I, J, N : Integer;

  Function FirstCap(Const S : String) : String;
  Begin
    If S = '' Then
      Result := ''
    Else
    Begin
      Result := AnsiLowerCase(S);
    {$IFDEF UNICODE}
      CharUpperBuffW(@Result[1], 1);
    {$ELSE}
      CharUpperBuffA(@Result[1], 1);
    {$ENDIF}
    End;
  End;

  Function InitialCaps(Const S : String) : String;
  Var
    I :  Integer;
    Up : Boolean;
  Begin
    Result := AnsiLowerCase(S);
    Up     := True;
  {$IFDEF UNICODE}
    for I := 1 to Length(Result) do begin
      case Result[I] of
        #0..'&', '(', '*', '+', ',', '-', '.', '?', '<', '[', '{', #$00B7:
          Up := True
        else
          if Up and (Result[I] <> '''') then begin
            CharUpperBuffW(@Result[I], 1);
            Up := False
          end
      end;
    end;
  {$ELSE UNICODE}
    If SysLocale.FarEast Then
    Begin
      I := 1;
      While I <= Length(Result) Do
      Begin
        If Result[I] In LeadBytes Then
        Begin
          Inc(I, 2);
        End
        Else
        Begin
          If Result[I] In [#0..'&', '('..'.', '?', '<', '[', '{'] Then
            Up := True
          Else If Up And (Result[I] <> '''') Then
          Begin
            CharUpperBuffA(@Result[I], 1);
            Result[I] := UpperCase(Result[I])[1];
            Up := False;
          End;
          Inc(I);
        End;
      End;
    End
    Else
      For I := 1 To Length(Result) Do
      Begin
        If Result[I] In [#0..'&', '('..'.', '?', '<', '[', '{', #$B7] Then
          Up := True
        Else If Up And (Result[I] <> '''') Then
        Begin
          CharUpperBuffA(@Result[I], 1);
          Result[I] := AnsiUpperCase(Result[I])[1];
          Up := False;
        End;
      End;
  {$ENDIF UNICODE}
  End;

  Procedure ReplaceBackreference(Number : Integer);
  Var
    Backreference : PCREString;
  Begin
    Delete(S, I, J - I);
    If Number <= GetGroupCount() Then
    Begin
      Backreference := GetGroups(Number);
      If Backreference <> '' Then
      Begin
        // Ignore warnings; converting to UTF-8 does not cause data loss
        Case Mode Of
          'L', 'l': Backreference := AnsiLowerCase(Backreference);
          'U', 'u': Backreference := AnsiUpperCase(Backreference);
          'F', 'f': Backreference := FirstCap(Backreference);
          'I', 'i': Backreference := InitialCaps(Backreference);
        End;
        
        If S <> '' Then
        Begin
          Insert(Backreference, S, I);
          I := I + Length(Backreference);
        End
        Else
        Begin
          S := Backreference;
          I := MaxInt;
        End;
      End;
    End;
  End;

  Procedure ProcessBackreference(NumberOnly, Dollar : Boolean);
  Var
    Number, Number2 : Integer;
    Group : PCREString;
  Begin
    Number := -1;
    If (J <= Length(S)) And (S[J] In ['0'..'9']) Then
    Begin
      // Get the number of the backreference
      Number := Ord(S[J]) - Ord('0');
      Inc(J);
      If (J <= Length(S)) And (S[J] In ['0'..'9']) Then
      Begin
        // Expand it to two digits only if that would lead to a valid backreference
        Number2 := Number * 10 + Ord(S[J]) - Ord('0');
        If Number2 <= GetGroupCount() Then
        Begin
          Number := Number2;
          Inc(J);
        End;
      End;
    End
    Else If Not NumberOnly Then
    Begin
      If Dollar And (J < Length(S)) And (S[J] = '{') Then
      Begin
        // Number or name in curly braces
        Inc(J);
        Case S[J] Of
          '0'..'9':
          Begin
            Number := Ord(S[J]) - Ord('0');
            Inc(J);
            While (J <= Length(S)) And (S[J] In ['0'..'9']) Do
            Begin
              Number := Number * 10 + Ord(S[J]) - Ord('0');
              Inc(J);
            End;
          End;

          'A'..'Z', 'a'..'z', '_':
          Begin
            Inc(J);
            While (J <= Length(S)) And (S[J] In ['A'..'Z', 'a'..'z', '0'..'9', '_']) Do
              Inc(J);
            If (J <= Length(S)) And (S[J] = '}') Then
            Begin
              Group  := Copy(S, I + 2, J - I - 2);
              Number := NamedGroup(Group);
            End;
          End;
        End;

        If (J > Length(S)) Or (S[J] <> '}') Then
          Number := -1
        Else
          Inc(J);
      End
      Else If Dollar And (S[J] = '_') Then
      Begin
        // $_ (whole subject)
        Delete(S, I, J + 1 - I);
        Insert(FSubject, S, I);
        I := I + Length(FSubject);
        Exit;
      End
      Else
        Case S[J] Of
          '&':
          Begin
            // \& or $& (whole regex match)
            Number := 0;
            Inc(J);
          End;

          '+':
          Begin
            // \+ or $+ (highest-numbered participating group)
            Number := GetGroupCount();
            Inc(J);
          End;

          '`':
          Begin
            // \` or $` (backtick; subject to the left of the match)
            Delete(S, I, J + 1 - I);
            Insert(GetSubjectLeft(), S, I);
            I := I + FOffsets[0] - 1;
            Exit;
          End;

          '''':
          Begin
            // \' or $' (straight quote; subject to the right of the match)
            Delete(S, I, J + 1 - I);
            Insert(GetSubjectRight(), S, I);
            I := I + Length(FSubject) - FOffsets[1];
            Exit;
          End
        End;
    End;

    If Number >= 0 Then
      ReplaceBackreference(Number)
    Else
      Inc(I);
  End;

Begin
  S := FReplacement;
  I := 1;
  While I < Length(S) Do
  Begin
    Case S[I] Of
      '\':
      Begin
        J := I + 1;
        Assert(J <= Length(S), 'CHECK: We let I stop one character before the end, so J cannot point beyond the end of the PCREString here');
        Case S[J] Of
          '$', '\':
          Begin
            Delete(S, I, 1);
            Inc(I);
          End;
          'g':
          Begin
            If (J < Length(S) - 1) And (S[J + 1] = '<') And (S[J + 2] In ['A'..'Z', 'a'..'z', '_']) Then
            Begin
              // Python-style named group reference \g<name>
              J := J + 3;
              While (J <= Length(S)) And (S[J] In ['0'..'9', 'A'..'Z', 'a'..'z', '_']) Do
                Inc(J);
              If (J <= Length(S)) And (S[J] = '>') Then
              Begin
                N := NamedGroup(Copy(S, I + 3, J - I - 3));
                Inc(J);
                Mode := #0;
                If N > 0 Then
                  ReplaceBackreference(N)
                Else
                  Delete(S, I, J - I);
              End
              Else
                I := J;
            End
            Else
              I := I + 2;
          End;
          'l', 'L', 'u', 'U', 'f', 'F', 'i', 'I':
          Begin
            Mode := S[J];
            Inc(J);
            ProcessBackreference(True, False);
          End;
          Else
          Begin
            Mode := #0;
            ProcessBackreference(False, False);
          End;
        End;
      End;
      '$':
      Begin
        J := I + 1;
        Assert(J <= Length(S), 'CHECK: We let I stop one character before the end, so J cannot point beyond the end of the PCREString here');
        If S[J] = '$' Then
        Begin
          Delete(S, J, 1);
          Inc(I);
        End
        Else
        Begin
          Mode := #0;
          ProcessBackreference(False, True);
        End;
      End;
      Else
        Inc(I)
    End;
  End;
  Result := S;
End;

Procedure THsPerlRegExImpl.SetOptions(Value : TPerlRegExOptions);
Begin
  If (FOptions <> Value) Then
  Begin
    FOptions    := Value;
  {$IFDEF UNICODE}
    FpcreOptions := PCRE_UTF8 or PCRE_NEWLINE_ANY;
  {$ELSE}
    FpcreOptions := PCRE_NEWLINE_ANY;
  {$ENDIF}
    If (preCaseLess In Value) Then
      FpcreOptions := FpcreOptions Or PCRE_CASELESS;
    If (preMultiLine In Value) Then
      FpcreOptions := FpcreOptions Or PCRE_MULTILINE;
    If (preSingleLine In Value) Then
      FpcreOptions := FpcreOptions Or PCRE_DOTALL;
    If (preExtended In Value) Then
      FpcreOptions := FpcreOptions Or PCRE_EXTENDED;
    If (preAnchored In Value) Then
      FpcreOptions := FpcreOptions Or PCRE_ANCHORED;
    If (preUnGreedy In Value) Then
      FpcreOptions := FpcreOptions Or PCRE_UNGREEDY;
    If (preNoAutoCapture In Value) Then
      FpcreOptions := FpcreOptions Or PCRE_NO_AUTO_CAPTURE;

    CleanUp();
  End;
End;

Procedure THsPerlRegExImpl.SetRegEx(Const Value : PCREString);
Begin
  If FRegEx <> Value Then
  Begin
    FRegEx := Value;
    CleanUp();
  End;
End;

Procedure THsPerlRegExImpl.SetStart(Const Value : Integer);
Begin
  If Value < 1 Then
    FStart := 1
  Else
    FStart := Value;
  // If FStart > Length(Subject), MatchAgain() will simply return False
End;

Procedure THsPerlRegExImpl.SetStop(Const Value : Integer);
Begin
  If Value > Length(FSubject) Then
    FStop := Length(FSubject)
  Else
    FStop := Value;
End;

Procedure THsPerlRegExImpl.SetSubject(Const Value : PCREString);
Begin
  FSubject := Value;
  FSubjectPChar := PAnsiChar(Value);
  FStart := 1;
  FStop  := Length(FSubject);
  If Not FHasStoredGroups Then
    FOffsetCount := 0;
End;

Procedure THsPerlRegExImpl.Split(Strings : TStrings; Limit : Integer);
Var Offset ,
    Count  : Integer;
Begin
  Assert(Strings <> Nil, 'REQUIRE: Strings');
  If (Limit = 1) Or Not Match() Then
    Strings.Add(FSubject)
  Else
  Begin
    Offset := 1;
    Count  := 1;
    Repeat
      Strings.Add(Copy(FSubject, Offset, GetMatchedOffset() - Offset));
      Inc(Count);
      Offset := GetMatchedOffset() + GetMatchedLength();
    Until ((Limit > 1) And (Count >= Limit)) Or Not MatchAgain();
    Strings.Add(Copy(FSubject, Offset, MaxInt));
  End;
End;

Procedure THsPerlRegExImpl.SplitCapture(Strings : TStrings; Limit, Offset : Integer);
Var Count      : Integer;
    bUseOffset : Boolean;
    iOffset    : Integer;
Begin
  Assert(Strings <> Nil, 'REQUIRE: Strings');
  If (Limit = 1) Or Not Match Then
    Strings.Add(FSubject)
  Else
  Begin
    bUseOffset := Offset <> 1;
    If Offset <> 1 Then
      Dec(Limit);
    iOffset := 1;
    Count   := 1;
    Repeat
      If bUseOffset Then
      Begin
        If GetMatchedOffset() >= Offset Then
        Begin
          bUseOffset := False;
          Strings.Add(Copy(FSubject, 1, GetMatchedOffset() - 1));
          If GetGroupCount() > 0 Then
            Strings.Add(GetGroups(GetGroupCount()));
        End;
      End
      Else
      Begin
        Strings.Add(Copy(FSubject, iOffset, GetMatchedOffset() - iOffset));
        Inc(Count);
        If GetGroupCount() > 0 Then
          Strings.Add(GetGroups(GetGroupCount()));
      End;
      iOffset := GetMatchedOffset() + GetMatchedLength();
    Until ((Limit > 1) And (Count >= Limit)) Or Not MatchAgain;
    Strings.Add(Copy(FSubject, iOffset, MaxInt));
  End;
End;

Procedure THsPerlRegExImpl.SplitCapture(Strings : TStrings; Limit : Integer);
Begin
  SplitCapture(Strings, Limit, 1);
End;

Procedure THsPerlRegExImpl.StoreGroups;
Var
  I : Integer;
Begin
  If FOffsetCount > 0 Then
  Begin
    ClearStoredGroups();
    SetLength(FStoredGroups, GetGroupCount() + 1);
    For I := GetGroupCount() DownTo 0 Do
      FStoredGroups[I] := GetGroups(I);
    FHasStoredGroups := True;
  End;
End;

Procedure THsPerlRegExImpl.Compile();
Var
  Error : PAnsiChar;
  ErrorOffset : Integer;
Begin
  If FRegEx = '' Then
    Raise Exception.Create('TPerlRegEx.Compile() - Please specify a regular expression in RegEx first');
  CleanUp();
  FPattern := pcre_compile(PAnsiChar(FRegEx), FpcreOptions, @Error, @ErrorOffset, FCharTable);
  If FPattern = Nil Then
    Raise Exception.Create(Format('TPerlRegEx.Compile() - Error in regex at offset %d: %s', [ErrorOffset, Ansistring(Error)]));
  FCompiled := True;
End;

Procedure THsPerlRegExImpl.Study();
Var
  Error : PAnsiChar;
Begin
  If Not FCompiled Then
    Compile();
  FHints := pcre_study(FPattern, 0, @Error);
  If Error <> Nil Then
    Raise Exception.Create('TPerlRegEx.Study() - Error studying the regex: ' + Ansistring(Error));
  FStudied := True;
End;

Function THsPerlRegExList.THsPerlRegExListEnumerator.GetCurrent() : IHsPerlRegEx;
Begin
  Result := InHerited Current As IHsPerlRegEx;
End;

Function THsPerlRegExList.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := THsPerlRegExImpl;
End;

Function THsPerlRegExList.Get(Index : Integer) : IHsPerlRegEx;
Begin
  Result := InHerited Items[Index] As IHsPerlRegEx;
End;

Procedure THsPerlRegExList.Put(Index : Integer; Const Item : IHsPerlRegEx);
Begin
  InHerited Items[Index] := Item;
  InitRegEx(Item);
End;

Function THsPerlRegExList.Add() : IHsPerlRegEx;
Begin
  Result := InHerited Add() As IHsPerlRegEx;
  InitRegEx(Result);
End;

Function THsPerlRegExList.Add(Const AItem : IHsPerlRegEx) : Integer;
Begin
  Result := InHerited Add(AItem);
  InitRegEx(AItem);
End;

Procedure THsPerlRegExList.InitRegEx(ARegEx : IHsPerlRegEx);
Begin
  ARegEx.Subject := FSubject;
  ARegEx.Start   := FStart;
End;

Procedure THsPerlRegExList.Insert(Index : Integer; Const Item : IHsPerlRegEx);
Begin
  InHerited Insert(Index, Item);
  InitRegEx(Item);
End;

Function THsPerlRegExList.Remove(Const Item : IHsPerlRegEx) : Integer;
Begin
  Result := InHerited Remove(IInterfaceEx(Item));
End;

Function THsPerlRegExList.Extract(Const Item : IHsPerlRegEx) : IHsPerlRegEx;
Begin
  Result := IHsPerlRegEx(InHerited Extract(IInterfaceEx(Item)));
End;

Function THsPerlRegExList.IndexOf(Const Item : IHsPerlRegEx) : Integer;
Begin
  Result := InHerited IndexOf(IInterfaceEx(Item));
End;

Function THsPerlRegExList.GetEnumerator() : IHsPerlRegExListEnumerator;
Begin
  Result := THsPerlRegExListEnumerator.Create(Self);
End;

Function THsPerlRegExList.GetSubject() : PCREString;
Begin
  Result := FSubject;
End;

Procedure THsPerlRegExList.SetSubject(Const ASuject : PCREString);
Var lRegExp : IHsPerlRegEx;
Begin
  If FSubject <> ASuject Then
  Begin
    FSubject := ASuject;
    For lRegExp In IHsPerlRegExList(Self) Do
      lRegExp.Subject := ASuject;
    FMatchedRegEx := Nil;
  End;
End;

Function THsPerlRegExList.GetStart() : Integer;
Begin
  Result := FStart;
End;

Procedure THsPerlRegExList.SetStart(Const AStart : Integer);
Var lRegExp : IHsPerlRegEx;
Begin
  If FStart <> AStart Then
  Begin
    FStart := AStart;
    For lRegExp In IHsPerlRegExList(Self) Do
      lRegExp.Start := AStart;
    FMatchedRegEx := Nil;
  End;
End;

Function THsPerlRegExList.GetStop() : Integer;
Begin
  Result := FStop;
End;

Procedure THsPerlRegExList.SetStop(Const AStop : Integer);
Var lRegExp : IHsPerlRegEx;
Begin
  If FStop <> AStop Then
  Begin
    FStop := AStop;
    For lRegExp In IHsPerlRegExList(Self) Do
      lRegExp.Stop := AStop;
    FMatchedRegEx := Nil;
  End;
End;

Function THsPerlRegExList.GetMatchedRegEx() : IHsPerlRegEx;
Begin
  Result := FMatchedRegEx;
End;

Function THsPerlRegExList.Match() : Boolean;
Begin
  SetStart(1);
  FMatchedRegEx := Nil;
  Result := MatchAgain;
End;

Function THsPerlRegExList.MatchAgain() : Boolean;
Var lRegEx : IHsPerlRegEx;
    lStart ,
    lPos   : Integer;
Begin
  If FMatchedRegEx <> Nil Then
    lStart := FMatchedRegEx.MatchedOffset + FMatchedRegEx.MatchedLength
  Else
    lStart := FStart;

  FMatchedRegEx := Nil;
  lPos := MaxInt;

  For lRegEx In IHsPerlRegExList(Self) Do
  Begin
    If (Not lRegEx.FoundMatch) Or (lRegEx.MatchedOffset < lStart) Then
    Begin
      lRegEx.Start := lStart;
      lRegEx.MatchAgain();
    End;

    If lRegEx.FoundMatch And (lRegEx.MatchedOffset < lPos) Then
    Begin
      lPos := lRegEx.MatchedOffset;
      FMatchedRegEx := lRegEx;
    End;

    If lPos = lStart Then
      Break;
  End;

  Result := lPos < MaxInt;
End;

end.
