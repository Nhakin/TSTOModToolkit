{**************************************************************************************************}

{ Perl Regular Expressions VCL component                                                           }

{ The contents of this file are subject to the Mozilla Public License Version 1.1 (the "License"); }
{ you may not use this file except in compliance with the License. You may obtain a copy of the    }
{ License at http://www.mozilla.org/MPL/                                                           }

{ Software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF   }
{ ANY KIND, either express or implied. See the License for the specific language governing rights  }
{ and limitations under the License.                                                               }

{ The Original Code is PerlRegEx.pas.                                                              }

{ The Initial Developer of the Original Code is Jan Goyvaerts.                                     }
{ Portions created by Jan Goyvaerts are Copyright (C) 1999, 2005, 2008, 2010  Jan Goyvaerts.       }
{ All rights reserved.                                                                             }

{ Design & implementation, by Jan Goyvaerts, 1999, 2005, 2008, 2010                                }

{ TPerlRegEx is available at http://www.regular-expressions.info/delphi.html                       }

{**************************************************************************************************}

Unit PerlRegEx;

Interface

Uses
  Windows, Messages, SysUtils, Classes,
  pcre;

Type
  TPerlRegExOptions = Set Of (
    preCaseLess,       // /i -> Case insensitive
    preMultiLine,      // /m -> ^ and $ also match before/after a newline, not just at the beginning and the end of the string
    preSingleLine,     // /s -> Dot matches any character, including \n (newline). Otherwise, it matches anything except \n
    preExtended,       // /x -> Allow regex to contain extra whitespace, newlines and Perl-style comments, all of which will be filtered out
    preAnchored,       // /A -> Successful match can only occur at the start of the subject or right after the previous match
    preUnGreedy,       // Repeat operators (+, *, ?) are not greedy by default (i.e. they try to match the minimum number of characters instead of the maximum)
    preNoAutoCapture   // (group) is a non-capturing group; only named groups capture
  );

Type
  TPerlRegExState = Set Of (
    preNotBOL,         // Not Beginning Of Line: ^ does not match at the start of Subject
    preNotEOL,         // Not End Of Line: $ does not match at the end of Subject
    preNotEmpty        // Empty matches not allowed
  );

Const
  // Maximum number of subexpressions (backreferences)
  // Subexpressions are created by placing round brackets in the regex, and are referenced by \1, \2, ...
  // In Perl, they are available as $1, $2, ... after the regex matched; with TPerlRegEx, use the Subexpressions property
  // You can also insert \1, \2, ... in the replacement string; \0 is the complete matched expression
  MAX_SUBEXPRESSIONS = 99;

{$IFDEF UNICODE}
// All implicit string casts have been verified to be correct
{$WARN IMPLICIT_STRING_CAST OFF}
// Use UTF-8 in Delphi 2009 and later, so Unicode strings are handled correctly.
// PCRE does not support UTF-16
type
  PCREString = UTF8String;
{$ELSE UNICODE}
// Use AnsiString in Delphi 2007 and earlier
Type
  PCREString = Ansistring;
{$ENDIF UNICODE}

Type
  TPerlRegExReplaceEvent = Procedure(Sender : TObject; Var ReplaceWith : PCREString) Of Object;

Type
  TPerlRegEx = Class
  Private    // *** Property storage, getters and setters
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

    Function GetMatchedText : PCREString;
    Function GetMatchedLength : Integer;
    Function GetMatchedOffset : Integer;
    Procedure SetOptions(Value : TPerlRegExOptions);
    Procedure SetRegEx(Const Value : PCREString);
    Function GetGroupCount : Integer;
    Function GetGroups(Index : Integer) : PCREString;
    Function GetGroupLengths(Index : Integer) : Integer;
    Function GetGroupOffsets(Index : Integer) : Integer;
    Procedure SetSubject(Const Value : PCREString);
    Procedure SetStart(Const Value : Integer);
    Procedure SetStop(Const Value : Integer);
    Function GetFoundMatch : Boolean;

  Private    // *** Variables used by PCRE
    Offsets          : Array[0..(MAX_SUBEXPRESSIONS + 1) * 3] Of Integer;
    OffsetCount      : Integer;
    pcreOptions      : Integer;
    pattern          ,
    hints            ,
    chartable        : Pointer;
    FSubjectPChar    : PAnsiChar;
    FHasStoredGroups : Boolean;
    FStoredGroups    : Array Of PCREString;

    Function GetSubjectLeft : PCREString;
    Function GetSubjectRight : PCREString;

  Protected
    Procedure CleanUp;
    // Dispose off whatever we created, so we can start over. Called automatically when needed, so it is not made public
    Procedure ClearStoredGroups;

  Public
    Constructor Create;
    // Come to life
    Destructor Destroy; OverRide;
    // Clean up after ourselves
    Class Function EscapeRegExChars(Const S : String) : String;
    // Escapes regex characters in S so that the regex engine can be used to match S as plain text
    Procedure Compile;
    // Compile the regex. Called automatically by Match
    Procedure Study;
    // Study the regex. Studying takes time, but will make the execution of the regex a lot faster.
    // Call study if you will be using the same regex many times
    Function Match : Boolean;
    // Attempt to match the regex, starting the attempt from the beginning of Subject
    Function MatchAgain : Boolean;
    // Attempt to match the regex to the remainder of Subject after the previous match (as indicated by Start)
    Function Replace : PCREString;
    // Replace matched expression in Subject with ComputeReplacement.  Returns the actual replacement text from ComputeReplacement
    Function ReplaceAll : Boolean;
    // Repeat MatchAgain and Replace until you drop.  Returns True if anything was replaced at all.
    Function ComputeReplacement : PCREString;
    // Returns Replacement with backreferences filled in
    Procedure StoreGroups;
    // Stores duplicates of Groups[] so they and ComputeReplacement will still return the proper strings
    // even if FSubject is changed or cleared
    Function NamedGroup(Const Name : PCREString) : Integer;
    // Returns the index of the named group Name
    Procedure Split(Strings : TStrings; Limit : Integer);
    // Split Subject along regex matches.  Capturing groups are ignored.
    Procedure SplitCapture(Strings : TStrings; Limit : Integer); Overload;
    Procedure SplitCapture(Strings : TStrings; Limit : Integer; Offset : Integer); Overload;
    // Split Subject along regex matches.  Capturing groups are added to Strings as well.
    Property Compiled: Boolean Read FCompiled;
    // True if the RegEx has already been compiled.
    Property FoundMatch: Boolean Read GetFoundMatch;
    // Returns True when Matched* and Group* indicate a match
    Property Studied: Boolean Read FStudied;
    // True if the RegEx has already been studied
    Property MatchedText: PCREString Read GetMatchedText;
    // The matched text
    Property MatchedLength: Integer Read GetMatchedLength;
    // Length of the matched text
    Property MatchedOffset: Integer Read GetMatchedOffset;
    // Character offset in the Subject string at which MatchedText starts
    Property Start: Integer Read FStart Write SetStart;
    // Starting position in Subject from which MatchAgain begins
    Property Stop: Integer Read FStop Write SetStop;
    // Last character in Subject that Match and MatchAgain search through
    Property State: TPerlRegExState Read FState Write FState;
    // State of Subject
    Property GroupCount: Integer Read GetGroupCount;
    // Number of matched capturing groups
    Property Groups[Index: Integer]: PCREString Read GetGroups;
    // Text matched by capturing groups
    Property GroupLengths[Index: Integer]: Integer Read GetGroupLengths;
    // Lengths of the text matched by capturing groups
    Property GroupOffsets[Index: Integer]: Integer Read GetGroupOffsets;
    // Character offsets in Subject at which the capturing group matches start
    Property Subject: PCREString Read FSubject Write SetSubject;
    // The string on which Match() will try to match RegEx
    Property SubjectLeft: PCREString Read GetSubjectLeft;
    // Part of the subject to the left of the match
    Property SubjectRight: PCREString Read GetSubjectRight;

    // Part of the subject to the right of the match
  Public
    Property Options: TPerlRegExOptions Read FOptions Write SetOptions;
    // Options
    Property RegEx: PCREString Read FRegEx Write SetRegEx;
    // The regular expression to be matched
    Property Replacement: PCREString Read FReplacement Write FReplacement;
    // Text to replace matched expression with. \number and $number backreferences will be substituted with Groups
    // TPerlRegEx supports the "JGsoft" replacement text flavor as explained at http://www.regular-expressions.info/refreplace.html
    Property OnMatch: TNotifyEvent Read FOnMatch Write FOnMatch;
    // Triggered by Match and MatchAgain after a successful match
    Property OnReplace: TPerlRegExReplaceEvent Read FOnReplace Write FOnReplace;
    // Triggered by Replace and ReplaceAll just before the replacement is done, allowing you to determine the new PCREString

  End;

{
  You can add TPerlRegEx instances to a TPerlRegExList to match them all together on the same subject,
  as if they were one regex regex1|regex2|regex3|...
  TPerlRegExList does not own the TPerlRegEx components, just like a TList
  If a TPerlRegEx has been added to a TPerlRegExList, it should not be used in any other situation
  until it is removed from the list
}

Type
  TPerlRegExList = Class
  Private
    FList:    TList;
    FSubject: PCREString;
    FMatchedRegEx: TPerlRegEx;
    FStart, FStop: Integer;

    Function GetRegEx(Index : Integer) : TPerlRegEx;
    Procedure SetRegEx(Index : Integer; Value : TPerlRegEx);
    Procedure SetSubject(Const Value : PCREString);
    Procedure SetStart(Const Value : Integer);
    Procedure SetStop(Const Value : Integer);
    Function GetCount : Integer;

  Protected
    Procedure UpdateRegEx(ARegEx : TPerlRegEx);

  Public
    Constructor Create;
    Destructor Destroy; OverRide;

  Public
    Function Add(ARegEx : TPerlRegEx) : Integer;
    Procedure Clear;
    Procedure Delete(Index : Integer);
    Function IndexOf(ARegEx : TPerlRegEx) : Integer;
    Procedure Insert(Index : Integer; ARegEx : TPerlRegEx);

  Public
    Function Match : Boolean;
    Function MatchAgain : Boolean;
    Property RegEx[Index: Integer]: TPerlRegEx Read GetRegEx Write SetRegEx;
    Property Count: Integer Read GetCount;
    Property Subject: PCREString Read FSubject Write SetSubject;
    Property Start: Integer Read FStart Write SetStart;
    Property Stop: Integer Read FStop Write SetStop;
    Property MatchedRegEx: TPerlRegEx Read FMatchedRegEx;
    
  End;

Implementation

{ ********* Unit support routines ********* }

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


{ ********* TPerlRegEx component ********* }

Procedure TPerlRegEx.CleanUp;
Begin
  FCompiled := False;
  FStudied  := False;
  pcre_dispose(pattern, hints, nil);
  pattern := nil;
  hints   := nil;
  ClearStoredGroups;
  OffsetCount := 0;
End;

Procedure TPerlRegEx.ClearStoredGroups;
Begin
  FHasStoredGroups := False;
  FStoredGroups    := nil;
End;

Procedure TPerlRegEx.Compile;
Var
  Error : PAnsiChar;
  ErrorOffset : Integer;
Begin
  If FRegEx = '' Then
    Raise Exception.Create('TPerlRegEx.Compile() - Please specify a regular expression in RegEx first');
  CleanUp;
  Pattern := pcre_compile(PAnsiChar(FRegEx), pcreOptions, @Error, @ErrorOffset, chartable);
  If Pattern = nil Then
    Raise Exception.Create(Format('TPerlRegEx.Compile() - Error in regex at offset %d: %s', [ErrorOffset, Ansistring(Error)]));
  FCompiled := True;
End;

(* Backreference overview:

Assume there are 13 backreferences:

Text        TPerlRegex    .NET      Java       ECMAScript
$17         $1 + "7"      "$17"     $1 + "7"   $1 + "7"
$017        $1 + "7"      "$017"    $1 + "7"   $1 + "7"
$12         $12           $12       $12        $12
$012        $1 + "2"      $12       $12        $1 + "2"
${1}2       $1 + "2"      $1 + "2"  error      "${1}2"
$$          "$"           "$"       error      "$"
\$          "$"           "\$"      "$"        "\$"
*)

Function TPerlRegEx.ComputeReplacement : PCREString;
Var
  Mode : AnsiChar;
  S :    PCREString;
  I, J, N : Integer;

  Procedure ReplaceBackreference(Number : Integer);
  Var
    Backreference : PCREString;
  Begin
    Delete(S, I, J - I);
    If Number <= GroupCount Then
    Begin
      Backreference := Groups[Number];
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
        If Number2 <= GroupCount Then
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
        Insert(Subject, S, I);
        I := I + Length(Subject);
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
            Number := GroupCount;
            Inc(J);
          End;
          '`':
          Begin
            // \` or $` (backtick; subject to the left of the match)
            Delete(S, I, J + 1 - I);
            Insert(SubjectLeft, S, I);
            I := I + Offsets[0] - 1;
            Exit;
          End;
          '''':
          Begin
            // \' or $' (straight quote; subject to the right of the match)
            Delete(S, I, J + 1 - I);
            Insert(SubjectRight, S, I);
            I := I + Length(Subject) - Offsets[1];
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

Constructor TPerlRegEx.Create;
Begin
  Inherited Create;
  FState      := [preNotEmpty];
  chartable   := pcre_maketables;
{$IFDEF UNICODE}
  pcreOptions := PCRE_UTF8 or PCRE_NEWLINE_ANY;
{$ELSE}
  pcreOptions := PCRE_NEWLINE_ANY;
{$ENDIF}
End;

Destructor TPerlRegEx.Destroy;
Begin
  pcre_dispose(pattern, hints, chartable);
  Inherited Destroy;
End;

Class Function TPerlRegEx.EscapeRegExChars(Const S : String) : String;
Var
  I : Integer;
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

Function TPerlRegEx.GetFoundMatch : Boolean;
Begin
  Result := OffsetCount > 0;
End;

Function TPerlRegEx.GetMatchedText : PCREString;
Begin
  Assert(FoundMatch, 'REQUIRE: There must be a successful match first');
  Result := GetGroups(0);
End;

Function TPerlRegEx.GetMatchedLength : Integer;
Begin
  Assert(FoundMatch, 'REQUIRE: There must be a successful match first');
  Result := GetGroupLengths(0);
End;

Function TPerlRegEx.GetMatchedOffset : Integer;
Begin
  Assert(FoundMatch, 'REQUIRE: There must be a successful match first');
  Result := GetGroupOffsets(0);
End;

Function TPerlRegEx.GetGroupCount : Integer;
Begin
  Assert(FoundMatch, 'REQUIRE: There must be a successful match first');
  Result := OffsetCount - 1;
End;

Function TPerlRegEx.GetGroupLengths(Index : Integer) : Integer;
Begin
  Assert(FoundMatch, 'REQUIRE: There must be a successful match first');
  Assert((Index >= 0) And (Index <= GroupCount), 'REQUIRE: Index <= GroupCount');
  Result := Offsets[Index * 2 + 1] - Offsets[Index * 2];
End;

Function TPerlRegEx.GetGroupOffsets(Index : Integer) : Integer;
Begin
  Assert(FoundMatch, 'REQUIRE: There must be a successful match first');
  Assert((Index >= 0) And (Index <= GroupCount), 'REQUIRE: Index <= GroupCount');
  Result := Offsets[Index * 2];
End;

Function TPerlRegEx.GetGroups(Index : Integer) : PCREString;
Begin
  Assert(FoundMatch, 'REQUIRE: There must be a successful match first');
  If Index > GroupCount Then
    Result := ''
  Else If FHasStoredGroups Then
    Result := FStoredGroups[Index]
  Else
    Result := Copy(FSubject, Offsets[Index * 2], Offsets[Index * 2 + 1] - Offsets[Index * 2]);
End;

Function TPerlRegEx.GetSubjectLeft : PCREString;
Begin
  Result := Copy(Subject, 1, Offsets[0] - 1);
End;

Function TPerlRegEx.GetSubjectRight : PCREString;
Begin
  Result := Copy(Subject, Offsets[1], MaxInt);
End;

Function TPerlRegEx.Match : Boolean;
Var
  I, Opts : Integer;
Begin
  ClearStoredGroups;
  If Not Compiled Then
    Compile;
  If preNotBOL In State Then
    Opts := PCRE_NOTBOL
  Else
    Opts := 0;
  If preNotEOL In State Then
    Opts := Opts Or PCRE_NOTEOL;
  If preNotEmpty In State Then
    Opts := Opts Or PCRE_NOTEMPTY;
  OffsetCount := pcre_exec(Pattern, Hints, FSubjectPChar, FStop, 0, Opts, @Offsets[0], High(Offsets));
  Result := OffsetCount > 0;
  // Convert offsets into PCREString indices
  If Result Then
  Begin
    For I := 0 To OffsetCount * 2 - 1 Do
      Inc(Offsets[I]);
    FStart := Offsets[1];
    If Offsets[0] = Offsets[1] Then
      Inc(FStart); // Make sure we don't get stuck at the same position
    If Assigned(FOnMatch) Then
      FOnMatch(Self);
  End;
End;

Function TPerlRegEx.MatchAgain : Boolean;
Var
  I, Opts : Integer;
Begin
  ClearStoredGroups;
  If Not Compiled Then
    Compile;
  If preNotBOL In State Then
    Opts := PCRE_NOTBOL
  Else
    Opts := 0;
  If preNotEOL In State Then
    Opts := Opts Or PCRE_NOTEOL;
  If preNotEmpty In State Then
    Opts := Opts Or PCRE_NOTEMPTY;
  If FStart - 1 > FStop Then
    OffsetCount := -1
  Else
    OffsetCount := pcre_exec(Pattern, Hints, FSubjectPChar, FStop, FStart - 1, Opts, @Offsets[0], High(Offsets));
  Result := OffsetCount > 0;
  // Convert offsets into PCREString indices
  If Result Then
  Begin
    For I := 0 To OffsetCount * 2 - 1 Do
      Inc(Offsets[I]);
    FStart := Offsets[1];
    If Offsets[0] = Offsets[1] Then
      Inc(FStart); // Make sure we don't get stuck at the same position
    If Assigned(FOnMatch) Then
      FOnMatch(Self);
  End;
End;

Function TPerlRegEx.NamedGroup(Const Name : PCREString) : Integer;
Begin
  Result := pcre_get_stringnumber(Pattern, PAnsiChar(Name));
End;

Function TPerlRegEx.Replace : PCREString;
Begin
  Assert(FoundMatch, 'REQUIRE: There must be a successful match first');
  // Substitute backreferences
  Result := ComputeReplacement;
  // Allow for just-in-time substitution determination
  If Assigned(FOnReplace) Then
    FOnReplace(Self, Result);
  // Perform substitution
  Delete(FSubject, MatchedOffset, MatchedLength);
  If Result <> '' Then
    Insert(Result, FSubject, MatchedOffset);
  FSubjectPChar := PAnsiChar(FSubject);
  // Position to continue search
  FStart := FStart - MatchedLength + Length(Result);
  FStop  := FStop - MatchedLength + Length(Result);
  // Replacement no longer matches regex, we assume
  ClearStoredGroups;
  OffsetCount := 0;
End;

Function TPerlRegEx.ReplaceAll : Boolean;
Begin
  If Match Then
  Begin
    Result := True;
    Repeat
      Replace
    Until Not MatchAgain;
  End
  Else
    Result := False;
End;

Procedure TPerlRegEx.SetOptions(Value : TPerlRegExOptions);
Begin
  If (FOptions <> Value) Then
  Begin
    FOptions    := Value;
  {$IFDEF UNICODE}
    pcreOptions := PCRE_UTF8 or PCRE_NEWLINE_ANY;
  {$ELSE}
    pcreOptions := PCRE_NEWLINE_ANY;
  {$ENDIF}
    If (preCaseLess In Value) Then
      pcreOptions := pcreOptions Or PCRE_CASELESS;
    If (preMultiLine In Value) Then
      pcreOptions := pcreOptions Or PCRE_MULTILINE;
    If (preSingleLine In Value) Then
      pcreOptions := pcreOptions Or PCRE_DOTALL;
    If (preExtended In Value) Then
      pcreOptions := pcreOptions Or PCRE_EXTENDED;
    If (preAnchored In Value) Then
      pcreOptions := pcreOptions Or PCRE_ANCHORED;
    If (preUnGreedy In Value) Then
      pcreOptions := pcreOptions Or PCRE_UNGREEDY;
    If (preNoAutoCapture In Value) Then
      pcreOptions := pcreOptions Or PCRE_NO_AUTO_CAPTURE;
    CleanUp;
  End;
End;

Procedure TPerlRegEx.SetRegEx(Const Value : PCREString);
Begin
  If FRegEx <> Value Then
  Begin
    FRegEx := Value;
    CleanUp;
  End;
End;

Procedure TPerlRegEx.SetStart(Const Value : Integer);
Begin
  If Value < 1 Then
    FStart := 1
  Else
    FStart := Value;
  // If FStart > Length(Subject), MatchAgain() will simply return False
End;

Procedure TPerlRegEx.SetStop(Const Value : Integer);
Begin
  If Value > Length(Subject) Then
    FStop := Length(Subject)
  Else
    FStop := Value;
End;

Procedure TPerlRegEx.SetSubject(Const Value : PCREString);
Begin
  FSubject := Value;
  FSubjectPChar := PAnsiChar(Value);
  FStart := 1;
  FStop  := Length(Subject);
  If Not FHasStoredGroups Then
    OffsetCount := 0;
End;

Procedure TPerlRegEx.Split(Strings : TStrings; Limit : Integer);
Var
  Offset, Count : Integer;
Begin
  Assert(Strings <> nil, 'REQUIRE: Strings');
  If (Limit = 1) Or Not Match Then
    Strings.Add(Subject)
  Else
  Begin
    Offset := 1;
    Count  := 1;
    Repeat
      Strings.Add(Copy(Subject, Offset, MatchedOffset - Offset));
      Inc(Count);
      Offset := MatchedOffset + MatchedLength;
    Until ((Limit > 1) And (Count >= Limit)) Or Not MatchAgain;
    Strings.Add(Copy(Subject, Offset, MaxInt));
  End;
End;

Procedure TPerlRegEx.SplitCapture(Strings : TStrings; Limit, Offset : Integer);
Var
  Count :      Integer;
  bUseOffset : Boolean;
  iOffset :    Integer;
Begin
  Assert(Strings <> nil, 'REQUIRE: Strings');
  If (Limit = 1) Or Not Match Then
    Strings.Add(Subject)
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
        If MatchedOffset >= Offset Then
        Begin
          bUseOffset := False;
          Strings.Add(Copy(Subject, 1, MatchedOffset - 1));
          If Self.GroupCount > 0 Then
            Strings.Add(Self.Groups[Self.GroupCount]);
        End;
      End
      Else
      Begin
        Strings.Add(Copy(Subject, iOffset, MatchedOffset - iOffset));
        Inc(Count);
        If Self.GroupCount > 0 Then
          Strings.Add(Self.Groups[Self.GroupCount]);
      End;
      iOffset := MatchedOffset + MatchedLength;
    Until ((Limit > 1) And (Count >= Limit)) Or Not MatchAgain;
    Strings.Add(Copy(Subject, iOffset, MaxInt));
  End;
End;

Procedure TPerlRegEx.SplitCapture(Strings : TStrings; Limit : Integer);
Begin
  SplitCapture(Strings, Limit, 1);
End;

Procedure TPerlRegEx.StoreGroups;
Var
  I : Integer;
Begin
  If OffsetCount > 0 Then
  Begin
    ClearStoredGroups;
    SetLength(FStoredGroups, GroupCount + 1);
    For I := GroupCount Downto 0 Do
      FStoredGroups[I] := Groups[I];
    FHasStoredGroups := True;
  End;
End;

Procedure TPerlRegEx.Study;
Var
  Error : PAnsiChar;
Begin
  If Not FCompiled Then
    Compile;
  Hints := pcre_study(Pattern, 0, @Error);
  If Error <> nil Then
    Raise Exception.Create('TPerlRegEx.Study() - Error studying the regex: ' + Ansistring(Error));
  FStudied := True;
End;

{ TPerlRegExList }

Function TPerlRegExList.Add(ARegEx : TPerlRegEx) : Integer;
Begin
  Result := FList.Add(ARegEx);
  UpdateRegEx(ARegEx);
End;

Procedure TPerlRegExList.Clear;
Begin
  FList.Clear;
End;

Constructor TPerlRegExList.Create;
Begin
  Inherited Create;
  FList := TList.Create;
End;

Procedure TPerlRegExList.Delete(Index : Integer);
Begin
  FList.Delete(Index);
End;

Destructor TPerlRegExList.Destroy;
Begin
  FList.Free;
  Inherited;
End;

Function TPerlRegExList.GetCount : Integer;
Begin
  Result := FList.Count;
End;

Function TPerlRegExList.GetRegEx(Index : Integer) : TPerlRegEx;
Begin
  Result := TPerlRegEx(Pointer(FList[Index]));
End;

Function TPerlRegExList.IndexOf(ARegEx : TPerlRegEx) : Integer;
Begin
  Result := FList.IndexOf(ARegEx);
End;

Procedure TPerlRegExList.Insert(Index : Integer; ARegEx : TPerlRegEx);
Begin
  FList.Insert(Index, ARegEx);
  UpdateRegEx(ARegEx);
End;

Function TPerlRegExList.Match : Boolean;
Begin
  SetStart(1);
  FMatchedRegEx := nil;
  Result := MatchAgain;
End;

Function TPerlRegExList.MatchAgain : Boolean;
Var
  I, MatchStart, MatchPos : Integer;
  ARegEx : TPerlRegEx;
Begin
  If FMatchedRegEx <> nil Then
    MatchStart := FMatchedRegEx.MatchedOffset + FMatchedRegEx.MatchedLength
  Else
    MatchStart := FStart;
  FMatchedRegEx := nil;
  MatchPos := MaxInt;
  For I := 0 To Count - 1 Do
  Begin
    ARegEx := RegEx[I];
    If (Not ARegEx.FoundMatch) Or (ARegEx.MatchedOffset < MatchStart) Then
    Begin
      ARegEx.Start := MatchStart;
      ARegEx.MatchAgain;
    End;
    If ARegEx.FoundMatch And (ARegEx.MatchedOffset < MatchPos) Then
    Begin
      MatchPos      := ARegEx.MatchedOffset;
      FMatchedRegEx := ARegEx;
    End;
    If MatchPos = MatchStart Then
      Break;
  End;
  Result := MatchPos < MaxInt;
End;

Procedure TPerlRegExList.SetRegEx(Index : Integer; Value : TPerlRegEx);
Begin
  FList[Index] := Value;
  UpdateRegEx(Value);
End;

Procedure TPerlRegExList.SetStart(Const Value : Integer);
Var
  I : Integer;
Begin
  If FStart <> Value Then
  Begin
    FStart := Value;
    For I := Count - 1 Downto 0 Do
      RegEx[I].Start := Value;
    FMatchedRegEx := nil;
  End;
End;

Procedure TPerlRegExList.SetStop(Const Value : Integer);
Var
  I : Integer;
Begin
  If FStop <> Value Then
  Begin
    FStop := Value;
    For I := Count - 1 Downto 0 Do
      RegEx[I].Stop := Value;
    FMatchedRegEx := nil;
  End;
End;

Procedure TPerlRegExList.SetSubject(Const Value : PCREString);
Var
  I : Integer;
Begin
  If FSubject <> Value Then
  Begin
    FSubject := Value;
    For I := Count - 1 Downto 0 Do
      RegEx[I].Subject := Value;
    FMatchedRegEx := nil;
  End;
End;

Procedure TPerlRegExList.UpdateRegEx(ARegEx : TPerlRegEx);
Begin
  ARegEx.Subject := FSubject;
  ARegEx.Start   := FStart;
End;

End.

