{**************************************************************************************************}

{ Project JEDI Code Library (JCL)                                                                  }

{ The contents of this file are subject to the Mozilla Public License Version 1.1 (the "License"); }
{ you may not use this file except in compliance with the License. You may obtain a copy of the    }
{ License at http://www.mozilla.org/MPL/                                                           }

{ Software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF   }
{ ANY KIND, either express or implied. See the License for the specific language governing rights  }
{ and limitations under the License.                                                               }

{ The Original Code is pcre.pas.                                                                   }

{ The Initial Developer of the Original Code is Peter Thornqvist.                                  }
{ Portions created by Peter Thornqvist are Copyright (C) of Peter Thornqvist. All rights reserved. }
{ Portions created by University of Cambridge are                                                  }
{ Copyright (C) 1997-2001 by University of Cambridge.                                              }

{ Contributor(s):                                                                                  }
{   Robert Rossmair (rrossmair)                                                                    }
{   Mario R. Carro                                                                                 }
{   Florent Ouchet (outchy)                                                                        }

{ The latest release of PCRE is always available from                                              }
{ ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-xxx.tar.gz                            }

{ Modified by Jan Goyvaerts for use with TPerlRegEx                                                }
{ TPerlRegEx is available at http://www.regular-expressions.info/delphi.html                       }

{**************************************************************************************************}

{ Header conversion of pcre.h                                                                      }

{**************************************************************************************************}

Unit pcre;

Interface

(*************************************************
*       Perl-Compatible Regular Expressions      *
*************************************************)

{$WEAKPACKAGEUNIT ON}

// Define PCRE_STATICLINK to link the OBJ files with PCRE 7.9.
{$DEFINE PCRE_STATICLINK}

 // Define PCRE_LINKDLL to use pcrelib.dll
 {.$DEFINE PCRE_LINKDLL}

// The supplied pcrelib.dll compiled PCRE 7.9 using the C calling convention
{$IFDEF PCRE_LINKDLL}
  {$DEFINE PCRE_EXPORT_CDECL}
{$ENDIF}

(*$HPPEMIT '#include "pcre.h"'*)

Const
  MAX_PATTERN_LENGTH  = $10003;
  {$EXTERNALSYM MAX_PATTERN_LENGTH}
  MAX_QUANTIFY_REPEAT = $10000;
  {$EXTERNALSYM MAX_QUANTIFY_REPEAT}
  MAX_CAPTURE_COUNT   = $FFFF;
  {$EXTERNALSYM MAX_CAPTURE_COUNT}
  MAX_NESTING_DEPTH   = 200;
  {$EXTERNALSYM MAX_NESTING_DEPTH}

Const
  (* Options *)
  PCRE_CASELESS  = $00000001;
  {$EXTERNALSYM PCRE_CASELESS}
  PCRE_MULTILINE = $00000002;
  {$EXTERNALSYM PCRE_MULTILINE}
  PCRE_DOTALL    = $00000004;
  {$EXTERNALSYM PCRE_DOTALL}
  PCRE_EXTENDED  = $00000008;
  {$EXTERNALSYM PCRE_EXTENDED}
  PCRE_ANCHORED  = $00000010;
  {$EXTERNALSYM PCRE_ANCHORED}
  PCRE_DOLLAR_ENDONLY = $00000020;
  {$EXTERNALSYM PCRE_DOLLAR_ENDONLY}
  PCRE_EXTRA     = $00000040;
  {$EXTERNALSYM PCRE_EXTRA}
  PCRE_NOTBOL    = $00000080;
  {$EXTERNALSYM PCRE_NOTBOL}
  PCRE_NOTEOL    = $00000100;
  {$EXTERNALSYM PCRE_NOTEOL}
  PCRE_UNGREEDY  = $00000200;
  {$EXTERNALSYM PCRE_UNGREEDY}
  PCRE_NOTEMPTY  = $00000400;
  {$EXTERNALSYM PCRE_NOTEMPTY}
  PCRE_UTF8      = $00000800;
  {$EXTERNALSYM PCRE_UTF8}
  PCRE_NO_AUTO_CAPTURE = $00001000;
  {$EXTERNALSYM PCRE_NO_AUTO_CAPTURE}
  PCRE_NO_UTF8_CHECK = $00002000;
  {$EXTERNALSYM PCRE_NO_UTF8_CHECK}
  PCRE_AUTO_CALLOUT = $00004000;
  {$EXTERNALSYM PCRE_AUTO_CALLOUT}
  PCRE_PARTIAL   = $00008000;
  {$EXTERNALSYM PCRE_PARTIAL}
  PCRE_DFA_SHORTEST = $00010000;
  {$EXTERNALSYM PCRE_DFA_SHORTEST}
  PCRE_DFA_RESTART = $00020000;
  {$EXTERNALSYM PCRE_DFA_RESTART}
  PCRE_FIRSTLINE = $00040000;
  {$EXTERNALSYM PCRE_FIRSTLINE}
  PCRE_DUPNAMES  = $00080000;
  {$EXTERNALSYM PCRE_DUPNAMES}
  PCRE_NEWLINE_CR = $00100000;
  {$EXTERNALSYM PCRE_NEWLINE_CR}
  PCRE_NEWLINE_LF = $00200000;
  {$EXTERNALSYM PCRE_NEWLINE_LF}
  PCRE_NEWLINE_CRLF = $00300000;
  {$EXTERNALSYM PCRE_NEWLINE_CRLF}
  PCRE_NEWLINE_ANY = $00400000;
  {$EXTERNALSYM PCRE_NEWLINE_ANY}
  PCRE_NEWLINE_ANYCRLF = $00500000;
  {$EXTERNALSYM PCRE_NEWLINE_ANYCRLF}
  PCRE_BSR_ANYCRLF = $00800000;
  {$EXTERNALSYM PCRE_BSR_ANYCRLF}
  PCRE_BSR_UNICODE = $01000000;
  {$EXTERNALSYM PCRE_BSR_UNICODE}
  PCRE_JAVASCRIPT_COMPAT = $02000000;
  {$EXTERNALSYM PCRE_JAVASCRIPT_COMPAT}
  PCRE_NO_START_OPTIMIZE = $04000000;
  {$EXTERNALSYM PCRE_NO_START_OPTIMIZE}
  PCRE_NO_START_OPTIMISE = $04000000;
  {$EXTERNALSYM PCRE_NO_START_OPTIMISE}

  (* Exec-time and get-time error codes *)

  PCRE_ERROR_NOMATCH   = -1;
  {$EXTERNALSYM PCRE_ERROR_NOMATCH}
  PCRE_ERROR_NULL      = -2;
  {$EXTERNALSYM PCRE_ERROR_NULL}
  PCRE_ERROR_BADOPTION = -3;
  {$EXTERNALSYM PCRE_ERROR_BADOPTION}
  PCRE_ERROR_BADMAGIC  = -4;
  {$EXTERNALSYM PCRE_ERROR_BADMAGIC}
  PCRE_ERROR_UNKNOWN_NODE = -5;
  {$EXTERNALSYM PCRE_ERROR_UNKNOWN_NODE}
  PCRE_ERROR_NOMEMORY  = -6;
  {$EXTERNALSYM PCRE_ERROR_NOMEMORY}
  PCRE_ERROR_NOSUBSTRING = -7;
  {$EXTERNALSYM PCRE_ERROR_NOSUBSTRING}
  PCRE_ERROR_MATCHLIMIT = -8;
  {$EXTERNALSYM PCRE_ERROR_MATCHLIMIT}
  PCRE_ERROR_CALLOUT   = -9;  (* Never used by PCRE itself *)
  {$EXTERNALSYM PCRE_ERROR_CALLOUT}
  PCRE_ERROR_BADUTF8   = -10;
  {$EXTERNALSYM PCRE_ERROR_BADUTF8}
  PCRE_ERROR_BADUTF8_OFFSET = -11;
  {$EXTERNALSYM PCRE_ERROR_BADUTF8_OFFSET}
  PCRE_ERROR_PARTIAL   = -12;
  {$EXTERNALSYM PCRE_ERROR_PARTIAL}
  PCRE_ERROR_BADPARTIAL = -13;
  {$EXTERNALSYM PCRE_ERROR_BADPARTIAL}
  PCRE_ERROR_INTERNAL  = -14;
  {$EXTERNALSYM PCRE_ERROR_INTERNAL}
  PCRE_ERROR_BADCOUNT  = -15;
  {$EXTERNALSYM PCRE_ERROR_BADCOUNT}
  PCRE_ERROR_DFA_UITEM = -16;
  {$EXTERNALSYM PCRE_ERROR_DFA_UITEM}
  PCRE_ERROR_DFA_UCOND = -17;
  {$EXTERNALSYM PCRE_ERROR_DFA_UCOND}
  PCRE_ERROR_DFA_UMLIMIT = -18;
  {$EXTERNALSYM PCRE_ERROR_DFA_UMLIMIT}
  PCRE_ERROR_DFA_WSSIZE = -19;
  {$EXTERNALSYM PCRE_ERROR_DFA_WSSIZE}
  PCRE_ERROR_DFA_RECURSE = -20;
  {$EXTERNALSYM PCRE_ERROR_DFA_RECURSE}
  PCRE_ERROR_RECURSIONLIMIT = -21;
  {$EXTERNALSYM PCRE_ERROR_RECURSIONLIMIT}
  PCRE_ERROR_NULLWSLIMIT = -22;  (* No longer actually used *)
  {$EXTERNALSYM PCRE_ERROR_NULLWSLIMIT}
  PCRE_ERROR_BADNEWLINE = -23;
  {$EXTERNALSYM PCRE_ERROR_BADNEWLINE}

  (* Request types for pcre_fullinfo() *)

  PCRE_INFO_OPTIONS   = 0;
  {$EXTERNALSYM PCRE_INFO_OPTIONS}
  PCRE_INFO_SIZE      = 1;
  {$EXTERNALSYM PCRE_INFO_SIZE}
  PCRE_INFO_CAPTURECOUNT = 2;
  {$EXTERNALSYM PCRE_INFO_CAPTURECOUNT}
  PCRE_INFO_BACKREFMAX = 3;
  {$EXTERNALSYM PCRE_INFO_BACKREFMAX}
  PCRE_INFO_FIRSTCHAR = 4;
  {$EXTERNALSYM PCRE_INFO_FIRSTCHAR}
  PCRE_INFO_FIRSTTABLE = 5;
  {$EXTERNALSYM PCRE_INFO_FIRSTTABLE}
  PCRE_INFO_LASTLITERAL = 6;
  {$EXTERNALSYM PCRE_INFO_LASTLITERAL}
  PCRE_INFO_NAMEENTRYSIZE = 7;
  {$EXTERNALSYM PCRE_INFO_NAMEENTRYSIZE}
  PCRE_INFO_NAMECOUNT = 8;
  {$EXTERNALSYM PCRE_INFO_NAMECOUNT}
  PCRE_INFO_NAMETABLE = 9;
  {$EXTERNALSYM PCRE_INFO_NAMETABLE}
  PCRE_INFO_STUDYSIZE = 10;
  {$EXTERNALSYM PCRE_INFO_STUDYSIZE}
  PCRE_INFO_DEFAULT_TABLES = 11;
  {$EXTERNALSYM PCRE_INFO_DEFAULT_TABLES}
  PCRE_INFO_OKPARTIAL = 12;
  {$EXTERNALSYM PCRE_INFO_OKPARTIAL}
  PCRE_INFO_JCHANGED  = 13;
  {$EXTERNALSYM PCRE_INFO_JCHANGED}
  PCRE_INFO_HASCRORLF = 14;
  {$EXTERNALSYM PCRE_INFO_HASCRORLF}

  (* Request types for pcre_config() *)
  PCRE_CONFIG_UTF8 = 0;
  {$EXTERNALSYM PCRE_CONFIG_UTF8}
  PCRE_CONFIG_NEWLINE = 1;
  {$EXTERNALSYM PCRE_CONFIG_NEWLINE}
  PCRE_CONFIG_LINK_SIZE = 2;
  {$EXTERNALSYM PCRE_CONFIG_LINK_SIZE}
  PCRE_CONFIG_POSIX_MALLOC_THRESHOLD = 3;
  {$EXTERNALSYM PCRE_CONFIG_POSIX_MALLOC_THRESHOLD}
  PCRE_CONFIG_MATCH_LIMIT = 4;
  {$EXTERNALSYM PCRE_CONFIG_MATCH_LIMIT}
  PCRE_CONFIG_STACKRECURSE = 5;
  {$EXTERNALSYM PCRE_CONFIG_STACKRECURSE}
  PCRE_CONFIG_UNICODE_PROPERTIES = 6;
  {$EXTERNALSYM PCRE_CONFIG_UNICODE_PROPERTIES}
  PCRE_CONFIG_MATCH_LIMIT_RECURSION = 7;
  {$EXTERNALSYM PCRE_CONFIG_MATCH_LIMIT_RECURSION}
  PCRE_CONFIG_BSR = 8;
  {$EXTERNALSYM PCRE_CONFIG_BSR}

  (* Bit flags for the pcre_extra structure *)

  PCRE_EXTRA_STUDY_DATA = $0001;
  {$EXTERNALSYM PCRE_EXTRA_STUDY_DATA}
  PCRE_EXTRA_MATCH_LIMIT = $0002;
  {$EXTERNALSYM PCRE_EXTRA_MATCH_LIMIT}
  PCRE_EXTRA_CALLOUT_DATA = $0004;
  {$EXTERNALSYM PCRE_EXTRA_CALLOUT_DATA}
  PCRE_EXTRA_TABLES = $0008;
  {$EXTERNALSYM PCRE_EXTRA_TABLES}
  PCRE_EXTRA_MATCH_LIMIT_RECURSION = $0010;
  {$EXTERNALSYM PCRE_EXTRA_MATCH_LIMIT_RECURSION}

Type
  (* Types *)
  PPAnsiChar  = ^PAnsiChar;
  {$EXTERNALSYM PPAnsiChar}
  PPPAnsiChar = ^PPAnsiChar;
  {$EXTERNALSYM PPPAnsiChar}
  PInteger    = ^Integer;
  {$EXTERNALSYM PInteger}

  real_pcre = Packed Record
    {magic_number: Longword;
    size: Integer;
    tables: PAnsiChar;
    options: Longword;
    top_bracket: Word;
    top_backref: word;
    first_char: PAnsiChar;
    req_char: PAnsiChar;
    code: array [0..0] of AnsiChar;}
  End;
  TPCRE = real_pcre;
  PPCRE = ^TPCRE;

  real_pcre_extra = Packed Record
    {options: PAnsiChar;
    start_bits: array [0..31] of AnsiChar;}
    flags:      Cardinal;        (* Bits for which fields are set *)
    study_data: Pointer;         (* Opaque data from pcre_study() *)
    match_limit: Cardinal;       (* Maximum number of calls to match() *)
    callout_data: Pointer;       (* Data passed back in callouts *)
    tables:     PAnsiChar;       (* Pointer to character tables *)
    match_limit_recursion: Cardinal; (* Max recursive calls to match() *)
  End;
  TPCREExtra = real_pcre_extra;
  PPCREExtra = ^TPCREExtra;

  pcre_callout_block = Packed Record
    version:      Integer;           (* Identifies version of block *)
    (* ------------------------ Version 0 ------------------------------- *)
    callout_number: Integer;    (* Number compiled into pattern *)
    offset_vector: PInteger;    (* The offset vector *)
    subject:      PAnsiChar;         (* The subject being matched *)
    subject_length: Integer;    (* The length of the subject *)
    start_match:  Integer;       (* Offset to start of this match attempt *)
    current_position: Integer;  (* Where we currently are in the subject *)
    capture_top:  Integer;       (* Max current capture *)
    capture_last: Integer;      (* Most recently closed capture *)
    callout_data: Pointer;      (* Data passed in with the call *)
    (* ------------------- Added for Version 1 -------------------------- *)
    pattern_position: Integer;  (* Offset to next item in the pattern *)
    next_item_length: Integer;  (* Length of next item in the pattern *)
    (* ------------------------------------------------------------------ *)
  End;

  pcre_malloc_callback = Function(Size : Integer) : Pointer; {$IFDEF PCRE_EXPORT_CDECL} Cdecl; {$ENDIF PCRE_EXPORT_CDECL}
  {$EXTERNALSYM pcre_malloc_callback}
  pcre_free_callback = Procedure(P : Pointer); {$IFDEF PCRE_EXPORT_CDECL} Cdecl; {$ENDIF PCRE_EXPORT_CDECL}
  {$EXTERNALSYM pcre_free_callback}
  pcre_stack_malloc_callback = Function(Size : Integer) : Pointer; {$IFDEF PCRE_EXPORT_CDECL} Cdecl; {$ENDIF PCRE_EXPORT_CDECL}
  {$EXTERNALSYM pcre_stack_malloc_callback}
  pcre_stack_free_callback = Procedure(P : Pointer); {$IFDEF PCRE_EXPORT_CDECL} Cdecl; {$ENDIF PCRE_EXPORT_CDECL}
  {$EXTERNALSYM pcre_stack_free_callback}
  pcre_callout_callback = Function(Var callout_block : pcre_callout_block) : Integer; {$IFDEF PCRE_EXPORT_CDECL} Cdecl; {$ENDIF PCRE_EXPORT_CDECL}
  {$EXTERNALSYM pcre_callout_callback}

Var
  // renamed from "pcre_X" to "pcre_X_func" to allow functions with name "pcre_X" to be
  // declared in implementation when static linked
  pcre_malloc_func :  ^pcre_malloc_callback = nil;
  {$EXTERNALSYM pcre_malloc_func}
  pcre_free_func :    ^pcre_free_callback = nil;
  {$EXTERNALSYM pcre_free_func}
  pcre_stack_malloc_func : ^pcre_stack_malloc_callback = nil;
  {$EXTERNALSYM pcre_stack_malloc_func}
  pcre_stack_free_func : ^pcre_stack_free_callback = nil;
  {$EXTERNALSYM pcre_stack_free_func}
  pcre_callout_func : ^pcre_callout_callback = nil;

  {$EXTERNALSYM pcre_callout_func}

Procedure SetPCREMallocCallback(Const Value : pcre_malloc_callback);
{$EXTERNALSYM SetPCREMallocCallback}
Function GetPCREMallocCallback : pcre_malloc_callback;
{$EXTERNALSYM GetPCREMallocCallback}
Function CallPCREMalloc(Size : Integer) : Pointer;
{$EXTERNALSYM CallPCREMalloc}

Procedure SetPCREFreeCallback(Const Value : pcre_free_callback);
{$EXTERNALSYM SetPCREFreeCallback}
Function GetPCREFreeCallback : pcre_free_callback;
{$EXTERNALSYM GetPCREFreeCallback}
Procedure CallPCREFree(P : Pointer);
{$EXTERNALSYM CallPCREFree}

Procedure SetPCREStackMallocCallback(Const Value : pcre_stack_malloc_callback);
{$EXTERNALSYM SetPCREStackMallocCallback}
Function GetPCREStackMallocCallback : pcre_stack_malloc_callback;
{$EXTERNALSYM GetPCREStackMallocCallback}
Function CallPCREStackMalloc(Size : Integer) : Pointer;
{$EXTERNALSYM CallPCREStackMalloc}

Procedure SetPCREStackFreeCallback(Const Value : pcre_stack_free_callback);
{$EXTERNALSYM SetPCREStackFreeCallback}
Function GetPCREStackFreeCallback : pcre_stack_free_callback;
{$EXTERNALSYM GetPCREStackFreeCallback}
Procedure CallPCREStackFree(P : Pointer);
{$EXTERNALSYM CallPCREStackFree}

Procedure SetPCRECalloutCallback(Const Value : pcre_callout_callback);
{$EXTERNALSYM SetPCRECalloutCallback}
Function GetPCRECalloutCallback : pcre_callout_callback;
{$EXTERNALSYM GetPCRECalloutCallback}
Function CallPCRECallout(Var callout_block : pcre_callout_block) : Integer;
{$EXTERNALSYM CallPCRECallout}

Type
  TPCRELibNotLoadedHandler = Procedure; {$IFDEF PCRE_EXPORT_CDECL} Cdecl; {$ENDIF PCRE_EXPORT_CDECL}

Var
  // Value to initialize function pointers below with, in case LoadPCRE fails
  // or UnloadPCRE is called.  Typically the handler will raise an exception.
  LibNotLoadedHandler : TPCRELibNotLoadedHandler = nil;

(* Functions *)

{$IFNDEF PCRE_LINKONREQUEST}
// static link and static dll import
Function pcre_compile(Const pattern : PAnsiChar; options : Integer; Const errptr : PPAnsiChar; erroffset : PInteger; Const tableptr : PAnsiChar) : PPCRE;
  {$IFDEF PCRE_EXPORT_CDECL} Cdecl; {$ENDIF PCRE_EXPORT_CDECL}
{$EXTERNALSYM pcre_compile}
Function pcre_compile2(Const pattern : PAnsiChar; options : Integer; Const errorcodeptr : PInteger; Const errorptr : PPAnsiChar; erroroffset : PInteger; Const tables : PAnsiChar) : PPCRE;
  {$IFDEF PCRE_EXPORT_CDECL} Cdecl; {$ENDIF PCRE_EXPORT_CDECL}
{$EXTERNALSYM pcre_compile2}
Function pcre_config(what : Integer; where : Pointer) : Integer;
  {$IFDEF PCRE_EXPORT_CDECL} Cdecl; {$ENDIF PCRE_EXPORT_CDECL}
{$EXTERNALSYM pcre_config}
Function pcre_copy_named_substring(Const code : PPCRE; Const subject : PAnsiChar; ovector : PInteger; stringcount : Integer; Const stringname : PAnsiChar; buffer : PAnsiChar; size : Integer) : Integer;
  {$IFDEF PCRE_EXPORT_CDECL} Cdecl; {$ENDIF PCRE_EXPORT_CDECL}
{$EXTERNALSYM pcre_copy_named_substring}
Function pcre_copy_substring(Const subject : PAnsiChar; ovector : PInteger; stringcount, stringnumber : Integer; buffer : PAnsiChar; buffersize : Integer) : Integer;
  {$IFDEF PCRE_EXPORT_CDECL} Cdecl; {$ENDIF PCRE_EXPORT_CDECL}
{$EXTERNALSYM pcre_copy_substring}
Function pcre_dfa_exec(Const argument_re : PPCRE; Const extra_data : PPCREExtra; Const subject : PAnsiChar; length : Integer; start_offset : Integer; options : Integer; offsets : PInteger; offsetcount : Integer; workspace : PInteger; wscount : Integer) : Integer;
  {$IFDEF PCRE_EXPORT_CDECL} Cdecl; {$ENDIF PCRE_EXPORT_CDECL}
{$EXTERNALSYM pcre_dfa_exec}
Function pcre_exec(Const code : PPCRE; Const extra : PPCREExtra; Const subject : PAnsiChar; length, startoffset, options : Integer; ovector : PInteger; ovecsize : Integer) : Integer;
  {$IFDEF PCRE_EXPORT_CDECL} Cdecl; {$ENDIF PCRE_EXPORT_CDECL}
{$EXTERNALSYM pcre_exec}
Procedure pcre_free_substring(stringptr : PAnsiChar);
  {$IFDEF PCRE_EXPORT_CDECL} Cdecl; {$ENDIF PCRE_EXPORT_CDECL}
{$EXTERNALSYM pcre_free_substring}
Procedure pcre_free_substring_list(stringlistptr : PPAnsiChar);
  {$IFDEF PCRE_EXPORT_CDECL} Cdecl; {$ENDIF PCRE_EXPORT_CDECL}
{$EXTERNALSYM pcre_free_substring_list}
Function pcre_fullinfo(Const code : PPCRE; Const extra : PPCREExtra; what : Integer; where : Pointer) : Integer;
  {$IFDEF PCRE_EXPORT_CDECL} Cdecl; {$ENDIF PCRE_EXPORT_CDECL}
{$EXTERNALSYM pcre_fullinfo}
Function pcre_get_named_substring(Const code : PPCRE; Const subject : PAnsiChar; ovector : PInteger; stringcount : Integer; Const stringname : PAnsiChar; Const stringptr : PPAnsiChar) : Integer;
  {$IFDEF PCRE_EXPORT_CDECL} Cdecl; {$ENDIF PCRE_EXPORT_CDECL}
{$EXTERNALSYM pcre_get_named_substring}
Function pcre_get_stringnumber(Const code : PPCRE; Const stringname : PAnsiChar) : Integer;
  {$IFDEF PCRE_EXPORT_CDECL} Cdecl; {$ENDIF PCRE_EXPORT_CDECL}
{$EXTERNALSYM pcre_get_stringnumber}
Function pcre_get_stringtable_entries(Const code : PPCRE; Const stringname : PAnsiChar; firstptr : PPAnsiChar; lastptr : PPAnsiChar) : Integer;
  {$IFDEF PCRE_EXPORT_CDECL} Cdecl; {$ENDIF PCRE_EXPORT_CDECL}
{$EXTERNALSYM pcre_get_stringtable_entries}
Function pcre_get_substring(Const subject : PAnsiChar; ovector : PInteger; stringcount, stringnumber : Integer; Const stringptr : PPAnsiChar) : Integer;
  {$IFDEF PCRE_EXPORT_CDECL} Cdecl; {$ENDIF PCRE_EXPORT_CDECL}
{$EXTERNALSYM pcre_get_substring}
Function pcre_get_substring_list(Const subject : PAnsiChar; ovector : PInteger; stringcount : Integer; listptr : PPPAnsiChar) : Integer;
  {$IFDEF PCRE_EXPORT_CDECL} Cdecl; {$ENDIF PCRE_EXPORT_CDECL}
{$EXTERNALSYM pcre_get_substring_list}
Function pcre_info(Const code : PPCRE; optptr, firstcharptr : PInteger) : Integer;
  {$IFDEF PCRE_EXPORT_CDECL} Cdecl; {$ENDIF PCRE_EXPORT_CDECL}
{$EXTERNALSYM pcre_info}
Function pcre_maketables : PAnsiChar;
  {$IFDEF PCRE_EXPORT_CDECL} Cdecl; {$ENDIF PCRE_EXPORT_CDECL}
{$EXTERNALSYM pcre_maketables}
Function pcre_refcount(argument_re : PPCRE; adjust : Integer) : Integer;
  {$IFDEF PCRE_EXPORT_CDECL} Cdecl; {$ENDIF PCRE_EXPORT_CDECL}
{$EXTERNALSYM pcre_refcount}
Function pcre_study(Const code : PPCRE; options : Integer; Const errptr : PPAnsiChar) : PPCREExtra;
  {$IFDEF PCRE_EXPORT_CDECL} Cdecl; {$ENDIF PCRE_EXPORT_CDECL}
{$EXTERNALSYM pcre_study}
Function pcre_version : PAnsiChar; {$IFDEF PCRE_EXPORT_CDECL} Cdecl; {$ENDIF PCRE_EXPORT_CDECL}
{$EXTERNALSYM pcre_version}

// Calling pcre_free in the DLL causes an access violation error; use pcre_dispose instead
Procedure pcre_dispose(pattern, hints, chartable : Pointer); {$IFDEF PCRE_EXPORT_CDECL} Cdecl; {$ENDIF PCRE_EXPORT_CDECL}

{$ELSE}
// dynamic dll import
type
  pcre_compile_func = function(const pattern: PAnsiChar; options: Integer;
    const errptr: PPAnsiChar; erroffset: PInteger; const tableptr: PAnsiChar): PPCRE;
    {$IFDEF PCRE_EXPORT_CDECL} cdecl; {$ENDIF PCRE_EXPORT_CDECL}
  {$EXTERNALSYM pcre_compile_func}
  pcre_compile2_func = function(const pattern: PAnsiChar; options: Integer;
    const errorcodeptr: PInteger; const errorptr: PPAnsiChar; erroroffset: PInteger;
    const tables: PAnsiChar): PPCRE; {$IFDEF PCRE_EXPORT_CDECL} cdecl; {$ENDIF PCRE_EXPORT_CDECL}
  {$EXTERNALSYM pcre_compile2_func}
  pcre_config_func = function(what: Integer; where: Pointer): Integer;
  {$IFDEF PCRE_EXPORT_CDECL} cdecl; {$ENDIF PCRE_EXPORT_CDECL}
  {$EXTERNALSYM pcre_config_func}
  pcre_copy_named_substring_func = function(const code: PPCRE; const subject: PAnsiChar;
    ovector: PInteger; stringcount: Integer; const stringname: PAnsiChar;
    buffer: PAnsiChar; size: Integer): Integer; {$IFDEF PCRE_EXPORT_CDECL} cdecl; {$ENDIF PCRE_EXPORT_CDECL}
  {$EXTERNALSYM pcre_copy_named_substring_func}
  pcre_copy_substring_func = function(const subject: PAnsiChar; ovector: PInteger;
    stringcount, stringnumber: Integer; buffer: PAnsiChar; buffersize: Integer): Integer;
    {$IFDEF PCRE_EXPORT_CDECL} cdecl; {$ENDIF PCRE_EXPORT_CDECL}
  {$EXTERNALSYM pcre_copy_substring_func}
  pcre_dfa_exec_func = function(const argument_re: PPCRE; const extra_data: PPCREExtra;
    const subject: PAnsiChar; length: Integer; start_offset: Integer;
    options: Integer; offsets: PInteger; offsetcount: Integer; workspace: PInteger;
    wscount: Integer): Integer; {$IFDEF PCRE_EXPORT_CDECL} cdecl; {$ENDIF PCRE_EXPORT_CDECL}
  {$EXTERNALSYM pcre_dfa_exec_func}
  pcre_exec_func = function(const code: PPCRE; const extra: PPCREExtra; const subject: PAnsiChar;
    length, startoffset, options: Integer; ovector: PInteger; ovecsize: Integer): Integer;
    {$IFDEF PCRE_EXPORT_CDECL} cdecl; {$ENDIF PCRE_EXPORT_CDECL}
  {$EXTERNALSYM pcre_exec_func}
  pcre_free_substring_func = procedure(stringptr: PAnsiChar);
    {$IFDEF PCRE_EXPORT_CDECL} cdecl; {$ENDIF PCRE_EXPORT_CDECL}
  {$EXTERNALSYM pcre_free_substring_func}
  pcre_free_substring_list_func = procedure(stringptr: PPAnsiChar);
    {$IFDEF PCRE_EXPORT_CDECL} cdecl; {$ENDIF PCRE_EXPORT_CDECL}
  {$EXTERNALSYM pcre_free_substring_list_func}
  pcre_fullinfo_func = function(const code: PPCRE; const extra: PPCREExtra;
    what: Integer; where: Pointer): Integer;
    {$IFDEF PCRE_EXPORT_CDECL} cdecl; {$ENDIF PCRE_EXPORT_CDECL}
  {$EXTERNALSYM pcre_fullinfo_func}
  pcre_get_named_substring_func = function(const code: PPCRE; const subject: PAnsiChar;
    ovector: PInteger; stringcount: Integer; const stringname: PAnsiChar;
    const stringptr: PPAnsiChar): Integer; {$IFDEF PCRE_EXPORT_CDECL} cdecl; {$ENDIF PCRE_EXPORT_CDECL}
  {$EXTERNALSYM pcre_get_named_substring_func}
  pcre_get_stringnumber_func = function(const code: PPCRE;
    const stringname: PAnsiChar): Integer; {$IFDEF PCRE_EXPORT_CDECL} cdecl; {$ENDIF PCRE_EXPORT_CDECL}
  {$EXTERNALSYM pcre_get_stringnumber_func}
  pcre_get_stringtable_entries_func = function(const code: PPCRE; const stringname: PAnsiChar;
    firstptr: PPAnsiChar; lastptr: PPAnsiChar): Integer;
    {$IFDEF PCRE_EXPORT_CDECL} cdecl; {$ENDIF PCRE_EXPORT_CDECL}
  {$EXTERNALSYM pcre_get_stringtable_entries_func}
  pcre_get_substring_func = function(const subject: PAnsiChar; ovector: PInteger;
    stringcount, stringnumber: Integer; const stringptr: PPAnsiChar): Integer;
    {$IFDEF PCRE_EXPORT_CDECL} cdecl; {$ENDIF PCRE_EXPORT_CDECL}
  {$EXTERNALSYM pcre_get_substring_func}
  pcre_get_substring_list_func = function(const subject: PAnsiChar; ovector: PInteger;
    stringcount: Integer; listptr: PPPAnsiChar): Integer;
    {$IFDEF PCRE_EXPORT_CDECL} cdecl; {$ENDIF PCRE_EXPORT_CDECL}
  {$EXTERNALSYM pcre_get_substring_list_func}
  pcre_info_func = function(const code: PPCRE; optptr, firstcharptr: PInteger): Integer;
  {$IFDEF PCRE_EXPORT_CDECL} cdecl; {$ENDIF PCRE_EXPORT_CDECL}
  {$EXTERNALSYM pcre_info_func}
  pcre_maketables_func = function: PAnsiChar; {$IFDEF PCRE_EXPORT_CDECL} cdecl; {$ENDIF PCRE_EXPORT_CDECL}
  {$EXTERNALSYM pcre_maketables_func}
  pcre_refcount_func = function(argument_re: PPCRE; adjust: Integer): Integer;
  {$IFDEF PCRE_EXPORT_CDECL} cdecl; {$ENDIF PCRE_EXPORT_CDECL}
  {$EXTERNALSYM pcre_refcount_func}
  pcre_study_func = function(const code: PPCRE; options: Integer; const errptr: PPAnsiChar): PPCREExtra;
  {$IFDEF PCRE_EXPORT_CDECL} cdecl; {$ENDIF PCRE_EXPORT_CDECL}
  {$EXTERNALSYM pcre_study_func}
  pcre_version_func = function: PAnsiChar; {$IFDEF PCRE_EXPORT_CDECL} cdecl; {$ENDIF PCRE_EXPORT_CDECL}
  {$EXTERNALSYM pcre_version_func}

var
  pcre_compile: pcre_compile_func = nil;
  {$EXTERNALSYM pcre_compile}
  pcre_compile2: pcre_compile2_func = nil;
  {$EXTERNALSYM pcre_compile2}
  pcre_config: pcre_config_func = nil;
  {$EXTERNALSYM pcre_config}
  pcre_copy_named_substring: pcre_copy_named_substring_func = nil;
  {$EXTERNALSYM pcre_copy_named_substring}
  pcre_copy_substring: pcre_copy_substring_func = nil;
  {$EXTERNALSYM pcre_copy_substring}
  pcre_dfa_exec: pcre_dfa_exec_func = nil;
  {$EXTERNALSYM pcre_dfa_exec}
  pcre_exec: pcre_exec_func = nil;
  {$EXTERNALSYM pcre_exec}
  pcre_free_substring: pcre_free_substring_func = nil;
  {$EXTERNALSYM pcre_free_substring}
  pcre_free_substring_list: pcre_free_substring_list_func = nil;
  {$EXTERNALSYM pcre_free_substring_list}
  pcre_fullinfo: pcre_fullinfo_func = nil;
  {$EXTERNALSYM pcre_fullinfo}
  pcre_get_named_substring: pcre_get_named_substring_func = nil;
  {$EXTERNALSYM pcre_get_named_substring}
  pcre_get_stringnumber: pcre_get_stringnumber_func = nil;
  {$EXTERNALSYM pcre_get_stringnumber}
  pcre_get_stringtable_entries: pcre_get_stringtable_entries_func = nil;
  {$EXTERNALSYM pcre_get_stringtable_entries}
  pcre_get_substring: pcre_get_substring_func = nil;
  {$EXTERNALSYM pcre_get_substring}
  pcre_get_substring_list: pcre_get_substring_list_func = nil;
  {$EXTERNALSYM pcre_get_substring_list}
  pcre_info: pcre_info_func = nil;
  {$EXTERNALSYM pcre_info}
  pcre_maketables: pcre_maketables_func = nil;
  {$EXTERNALSYM pcre_maketables}
  pcre_refcount: pcre_refcount_func = nil;
  {$EXTERNALSYM pcre_refcount}
  pcre_study: pcre_study_func = nil;
  {$EXTERNALSYM pcre_study}
  pcre_version: pcre_version_func = nil;
  {$EXTERNALSYM pcre_version}

{$ENDIF ~PCRE_LINKONREQUEST}

Function IsPCRELoaded : Boolean;
Function LoadPCRE : Boolean;
Procedure UnloadPCRE;

Implementation

Uses
  SysUtils,
  {$IFDEF MSWINDOWS}
  Windows;

  {$ENDIF MSWINDOWS}
  {$IFDEF UNIX}
  {$IFDEF HAS_UNIT_TYPES}
  Types,
  {$ENDIF HAS_UNIT_TYPES}
  {$IFDEF HAS_UNIT_LIBC}
  Libc;
  {$ELSE ~HAS_UNIT_LIBC}
  dl;
  {$ENDIF ~HAS_UNIT_LIBC}
  {$ENDIF UNIX}

{$IFDEF PCRE_STATICLINK}
{$LINK pcre\pcre_compile.obj}
{$LINK pcre\pcre_config.obj}
{$LINK pcre\pcre_dfa_exec.obj}
{$LINK pcre\pcre_exec.obj}
{$LINK pcre\pcre_fullinfo.obj}
{$LINK pcre\pcre_get.obj}
{$LINK pcre\pcre_globals.obj}
{$LINK pcre\pcre_info.obj}
{$LINK pcre\pcre_maketables.obj}
{$LINK pcre\pcre_newline.obj}
{$LINK pcre\pcre_ord2utf8.obj}
{$LINK pcre\pcre_refcount.obj}
{$LINK pcre\pcre_study.obj}
{$LINK pcre\pcre_tables.obj}
{$LINK pcre\pcre_try_flipped.obj}
{$LINK pcre\pcre_ucd.obj}
{$LINK pcre\pcre_valid_utf8.obj}
{$LINK pcre\pcre_version.obj}
{$LINK pcre\pcre_xclass.obj}
{$LINK pcre\pcre_default_tables.obj}

// user's defined callbacks
Var
  pcre_malloc_user :  pcre_malloc_callback;
  pcre_free_user :    pcre_free_callback;
  pcre_stack_malloc_user : pcre_stack_malloc_callback;
  pcre_stack_free_user : pcre_stack_free_callback;
  pcre_callout_user : pcre_callout_callback;

Function pcre_compile; External;
Function pcre_compile2; External;
Function pcre_config; External;
Function pcre_copy_named_substring; External;
Function pcre_copy_substring; External;
Function pcre_dfa_exec; External;
Function pcre_exec; External;
Procedure pcre_free_substring; External;
Procedure pcre_free_substring_list; External;
Function pcre_fullinfo; External;
Function pcre_get_named_substring; External;
Function pcre_get_stringnumber; External;
Function pcre_get_stringtable_entries; External;
Function pcre_get_substring; External;
Function pcre_get_substring_list; External;
Function pcre_info; External;
Function pcre_maketables; External;
Function pcre_refcount; External;
Function pcre_study; External;
Function pcre_version; External;

Type
  size_t = Longint;

Const
  szMSVCRT = 'MSVCRT.DLL';

Function _memcpy(dest, src : Pointer; Count : size_t) : Pointer; Cdecl; External szMSVCRT Name 'memcpy';
Function _memmove(dest, src : Pointer; Count : size_t) : Pointer; Cdecl; External szMSVCRT Name 'memmove';
Function _memset(dest : Pointer; val : Integer; Count : size_t) : Pointer; Cdecl; External szMSVCRT Name 'memset';
Function _strncmp(s1 : PAnsiChar; s2 : PAnsiChar; n : size_t) : Integer; Cdecl; External szMSVCRT Name 'strncmp';
Function _memcmp(s1 : Pointer; s2 : Pointer; n : size_t) : Integer; Cdecl; External szMSVCRT Name 'memcmp';
Function _strlen(s : PAnsiChar) : size_t; Cdecl; External szMSVCRT Name 'strlen';
Function __ltolower(__ch : Integer) : Integer; Cdecl; External szMSVCRT Name 'tolower';
Function __ltoupper(__ch : Integer) : Integer; Cdecl; External szMSVCRT Name 'toupper';
Function _isalnum(__ch : Integer) : Integer; Cdecl; External szMSVCRT Name 'isalnum';
Function _isalpha(__ch : Integer) : Integer; Cdecl; External szMSVCRT Name 'isalpha';
Function _iscntrl(__ch : Integer) : Integer; Cdecl; External szMSVCRT Name 'iscntrl';
Function _isdigit(__ch : Integer) : Integer; Cdecl; External szMSVCRT Name 'isdigit';
Function _isgraph(__ch : Integer) : Integer; Cdecl; External szMSVCRT Name 'isgraph';
Function _islower(__ch : Integer) : Integer; Cdecl; External szMSVCRT Name 'islower';
Function _isprint(__ch : Integer) : Integer; Cdecl; External szMSVCRT Name 'isprint';
Function _ispunct(__ch : Integer) : Integer; Cdecl; External szMSVCRT Name 'ispunct';
Function _isspace(__ch : Integer) : Integer; Cdecl; External szMSVCRT Name 'isspace';
Function _isupper(__ch : Integer) : Integer; Cdecl; External szMSVCRT Name 'isupper';
Function _isxdigit(__ch : Integer) : Integer; Cdecl; External szMSVCRT Name 'isxdigit';
Function _strchr(__s : PAnsiChar; __c : Integer) : PAnsiChar; Cdecl; External szMSVCRT Name 'strchr';

Function malloc(size : size_t) : Pointer; Cdecl; External szMSVCRT Name 'malloc';

Function pcre_malloc(Size : Integer) : Pointer;
Begin
  If Assigned(pcre_malloc_user) Then
    Result := pcre_malloc_user(Size)
  Else
    Result := malloc(Size);
End;

Function pcre_stack_malloc(Size : Integer) : Pointer;
Begin
  If Assigned(pcre_stack_malloc_user) Then
    Result := pcre_stack_malloc_user(Size)
  Else
    Result := malloc(Size);
End;

Function _malloc(size : size_t) : Pointer;
Begin
  Result := pcre_malloc(size);
End;

Procedure Free(pBlock : Pointer); Cdecl; External szMSVCRT Name 'free';

Procedure pcre_free(P : Pointer);
Begin
  If Assigned(pcre_free_user) Then
    pcre_free_user(P)
  Else
    Free(P);
End;

Procedure pcre_stack_free(P : Pointer);
Begin
  If Assigned(pcre_stack_free_user) Then
    pcre_stack_free_user(P)
  Else
    Free(P);
End;

Procedure _free(pBlock : Pointer);
Begin
  pcre_free(pBlock);
End;

Function pcre_callout(Var callout_block : pcre_callout_block) : Integer; Cdecl;
Begin
  If Assigned(pcre_callout_user) Then
    Result := pcre_callout_user(callout_block)
  Else
    Result := 0;
End;

{$ELSE ~PCRE_STATICLINK}

type
  {$IFDEF MSWINDOWS}
  TModuleHandle = HINST;
  {$ENDIF MSWINDOWS}
  {$IFDEF LINUX}
  TModuleHandle = Pointer;
  {$ENDIF LINUX}

const
  {$IFDEF MSWINDOWS}
  libpcremodulename = 'pcrelib.dll';
  {$ENDIF MSWINDOWS}
  {$IFDEF UNIX}
  libpcremodulename = 'libpcre.so.0';
  {$ENDIF UNIX}
  PCRECompileExportName = 'pcre_compile';
  PCRECompile2ExportName = 'pcre_compile2';
  PCREConfigExportName = 'pcre_config';
  PCRECopyNamedSubstringExportName = 'pcre_copy_named_substring';
  PCRECopySubStringExportName = 'pcre_copy_substring';
  PCREDfaExecExportName = 'pcre_dfa_exec';
  PCREExecExportName = 'pcre_exec';
  PCREFreeSubStringExportName = 'pcre_free_substring';
  PCREFreeSubStringListExportName = 'pcre_free_substring_list';
  PCREFullInfoExportName = 'pcre_fullinfo';
  PCREGetNamedSubstringExportName = 'pcre_get_named_substring';
  PCREGetStringNumberExportName = 'pcre_get_stringnumber';
  PCREGetStringTableEntriesExportName = 'pcre_get_stringtable_entries';
  PCREGetSubStringExportName = 'pcre_get_substring';
  PCREGetSubStringListExportName = 'pcre_get_substring_list';
  PCREInfoExportName = 'pcre_info';
  PCREMakeTablesExportName = 'pcre_maketables';
  PCRERefCountExportName = 'pcre_refcount';
  PCREStudyExportName = 'pcre_study';
  PCREVersionExportName = 'pcre_version';
  PCREMallocExportName = 'pcre_malloc';
  PCREFreeExportName = 'pcre_free';
  PCREStackMallocExportName = 'pcre_stack_malloc';
  PCREStackFreeExportName = 'pcre_stack_free';
  PCRECalloutExportName = 'pcre_callout';
  INVALID_MODULEHANDLE_VALUE = TModuleHandle(0);

var
  PCRELib: TModuleHandle = INVALID_MODULEHANDLE_VALUE;
{$ENDIF ~PCRE_STATICLINK}

Procedure SetPCREMallocCallback(Const Value : pcre_malloc_callback);
Begin
  {$IFDEF PCRE_STATICLINK}
  pcre_malloc_user := Value;
  {$ELSE ~PCRE_STATICLINK}
  if not Assigned(pcre_malloc_func) then
    LoadPCRE;

  if Assigned(pcre_malloc_func) then
    pcre_malloc_func^ := Value
  else if Assigned(LibNotLoadedHandler) then
    LibNotLoadedHandler;
  {$ENDIF ~PCRE_STATICLINK}
End;

Function GetPCREMallocCallback : pcre_malloc_callback;
Begin
  {$IFDEF PCRE_STATICLINK}
  Result := pcre_malloc_user;
  {$ELSE ~PCRE_STATICLINK}
  if not Assigned(pcre_malloc_func) then
    LoadPCRE;

  if not Assigned(pcre_malloc_func) then
  begin
    Result := nil;
    if Assigned(LibNotLoadedHandler) then
      LibNotLoadedHandler;
  end
  else
    Result := pcre_malloc_func^;
  {$ENDIF ~PCRE_STATICLINK}
End;

Function CallPCREMalloc(Size : Integer) : Pointer;
Begin
  {$IFDEF PCRE_STATICLINK}
  Result := pcre_malloc(Size);
  {$ELSE ~PCRE_STATICLINK}
  Result := pcre_malloc_func^(Size);
  {$ENDIF ~PCRE_STATICLINK}
End;

Procedure SetPCREFreeCallback(Const Value : pcre_free_callback);
Begin
  {$IFDEF PCRE_STATICLINK}
  pcre_free_user := Value;
  {$ELSE ~PCRE_STATICLINK}
  if not Assigned(pcre_free_func) then
    LoadPCRE;

  if Assigned(pcre_free_func) then
    pcre_free_func^ := Value
  else if Assigned(LibNotLoadedHandler) then
    LibNotLoadedHandler;
  {$ENDIF ~PCRE_STATICLINK}
End;

Function GetPCREFreeCallback : pcre_free_callback;
Begin
  {$IFDEF PCRE_STATICLINK}
  Result := pcre_free_user;
  {$ELSE ~PCRE_STATICLINK}
  if not Assigned(pcre_free_func) then
    LoadPCRE;

  if not Assigned(pcre_free_func) then
  begin
    Result := nil;
    if Assigned(LibNotLoadedHandler) then
      LibNotLoadedHandler;
  end
  else
    Result := pcre_free_func^
  {$ENDIF ~PCRE_STATICLINK}
End;

Procedure CallPCREFree(P : Pointer);
Begin
  {$IFDEF PCRE_STATICLINK}
  pcre_free(P);
  {$ELSE ~PCRE_STATICLINK}
  if not Assigned(pcre_free_func) then
    LoadPCRE;
  pcre_free_func^(P);
  {$ENDIF ~PCRE_STATICLINK}
End;

Procedure SetPCREStackMallocCallback(Const Value : pcre_stack_malloc_callback);
Begin
  {$IFDEF PCRE_STATICLINK}
  pcre_stack_malloc_user := Value;
  {$ELSE ~PCRE_STATICLINK}
  if not Assigned(pcre_stack_malloc_func) then
    LoadPCRE;

  if Assigned(pcre_stack_malloc_func) then
    pcre_stack_malloc_func^ := Value
  else if Assigned(LibNotLoadedHandler) then
    LibNotLoadedHandler;
  {$ENDIF ~PCRE_STATICLINK}
End;

Function GetPCREStackMallocCallback : pcre_stack_malloc_callback;
Begin
  {$IFDEF PCRE_STATICLINK}
  Result := pcre_stack_malloc_user;
  {$ELSE ~PCRE_STATICLINK}
  if not Assigned(pcre_stack_malloc_func) then
    LoadPCRE;

  if not Assigned(pcre_stack_malloc_func) then
  begin
    Result := nil;
    if Assigned(LibNotLoadedHandler) then
      LibNotLoadedHandler;
  end
  else
    Result := pcre_stack_malloc_func^;
  {$ENDIF ~PCRE_STATICLINK}
End;

Function CallPCREStackMalloc(Size : Integer) : Pointer;
Begin
  {$IFDEF PCRE_STATICLINK}
  Result := pcre_stack_malloc(Size);
  {$ELSE ~PCRE_STATICLINK}
  Result := pcre_stack_malloc_func^(Size);
  {$ENDIF ~PCRE_STATICLINK}
End;

Procedure SetPCREStackFreeCallback(Const Value : pcre_stack_free_callback);
Begin
  {$IFDEF PCRE_STATICLINK}
  pcre_stack_free_user := Value;
  {$ELSE ~PCRE_STATICLINK}
  if not Assigned(pcre_stack_free_func) then
    LoadPCRE;

  if Assigned(pcre_stack_free_func) then
    pcre_stack_free_func^ := Value
  else if Assigned(LibNotLoadedHandler) then
    LibNotLoadedHandler;
  {$ENDIF ~PCRE_STATICLINK}
End;

Function GetPCREStackFreeCallback : pcre_stack_free_callback;
Begin
  {$IFDEF PCRE_STATICLINK}
  Result := pcre_stack_free_user;
  {$ELSE ~PCRE_STATICLINK}
  if not Assigned(pcre_stack_free_func) then
    LoadPCRE;

  if not Assigned(pcre_stack_free_func) then
  begin
    Result := nil;
    if Assigned(LibNotLoadedHandler) then
      LibNotLoadedHandler;
  end
  else
    Result := pcre_stack_free_func^;
  {$ENDIF ~PCRE_STATICLINK}
End;

Procedure CallPCREStackFree(P : Pointer);
Begin
  {$IFDEF PCRE_STATICLINK}
  pcre_stack_free(P);
  {$ELSE ~PCRE_STATICLINK}
  pcre_stack_free_func^(P);
  {$ENDIF ~PCRE_STATICLINK}
End;

Procedure SetPCRECalloutCallback(Const Value : pcre_callout_callback);
Begin
  {$IFDEF PCRE_STATICLINK}
  pcre_callout_user := Value;
  {$ELSE ~PCRE_STATICLINK}
  if not Assigned(pcre_callout_func) then
    LoadPCRE;

  if Assigned(pcre_callout_func) then
    pcre_callout_func^ := Value
  else if Assigned(LibNotLoadedHandler) then
    LibNotLoadedHandler;
  {$ENDIF ~PCRE_STATICLINK}
End;

Function GetPCRECalloutCallback : pcre_callout_callback;
Begin
  {$IFDEF PCRE_STATICLINK}
  Result := pcre_callout_user;
  {$ELSE ~PCRE_STATICLINK}
  if not Assigned(pcre_callout_func) then
    LoadPCRE;

  if not Assigned(pcre_callout_func) then
  begin
    Result := nil;
    if Assigned(LibNotLoadedHandler) then
      LibNotLoadedHandler;
  end
  else
    Result := pcre_callout_func^;
  {$ENDIF ~PCRE_STATICLINK}
End;

Function CallPCRECallout(Var callout_block : pcre_callout_block) : Integer;
Begin
  {$IFDEF PCRE_STATICLINK}
  Result := pcre_callout(callout_block);
  {$ELSE ~PCRE_STATICLINK}
  Result := pcre_callout_func^(callout_block);
  {$ENDIF ~PCRE_STATICLINK}
End;

{$IFNDEF PCRE_STATICLINK}
procedure InitPCREFuncPtrs(const Value: Pointer);
begin
  {$IFDEF PCRE_LINKONREQUEST}
  @pcre_compile := Value;
  @pcre_compile2 := Value;
  @pcre_config := Value;
  @pcre_copy_named_substring := Value;
  @pcre_copy_substring := Value;
  @pcre_dfa_exec := Value;
  @pcre_exec := Value;
  @pcre_free_substring := Value;
  @pcre_free_substring_list := Value;
  @pcre_fullinfo := Value;
  @pcre_get_named_substring := Value;
  @pcre_get_stringnumber := Value;
  @pcre_get_stringtable_entries := Value;
  @pcre_get_substring := Value;
  @pcre_get_substring_list := Value;
  @pcre_info := Value;
  @pcre_maketables := Value;
  @pcre_refcount := Value;
  @pcre_study := Value;
  @pcre_version := Value;
  {$ENDIF PCRE_LINKONREQUEST}
  pcre_malloc_func := nil;
  pcre_free_func := nil;
  pcre_stack_malloc_func := nil;
  pcre_stack_free_func := nil;
  pcre_callout_func := nil;
end;
{$ENDIF ~PCRE_STATICLINK}

Function IsPCRELoaded : Boolean;
Begin
  {$IFDEF PCRE_STATICLINK}
  Result := True;
  {$ELSE ~PCRE_STATICLINK}
  Result := PCRELib <> INVALID_MODULEHANDLE_VALUE;
  {$ENDIF ~PCRE_STATICLINK}
End;

Function LoadPCRE : Boolean;
{$IFDEF PCRE_STATICLINK}
Begin
  Result := True;
End;

{$ELSE ~PCRE_STATICLINK}
  function GetSymbol(SymbolName: PAnsiChar): Pointer;
  begin
    {$IFDEF MSWINDOWS}
    Result := GetProcAddress(PCRELib, PChar(SymbolName));
    {$ENDIF MSWINDOWS}
    {$IFDEF UNIX}
    Result := dlsym(PCRELib, PChar(SymbolName));
    {$ENDIF UNIX}
  end;

begin
  Result := PCRELib <> INVALID_MODULEHANDLE_VALUE;
  if Result then
    Exit;

  if PCRELib = INVALID_MODULEHANDLE_VALUE then
    {$IFDEF MSWINDOWS}
    PCRELib := SafeLoadLibrary(libpcremodulename);
    {$ENDIF MSWINDOWS}
    {$IFDEF UNIX}
    PCRELib := dlopen(PAnsiChar(libpcremodulename), RTLD_NOW);
    {$ENDIF UNIX}
  Result := PCRELib <> INVALID_MODULEHANDLE_VALUE;
  if Result then
  begin
    {$IFDEF PCRE_LINKONREQUEST}
    @pcre_compile := GetSymbol(PCRECompileExportName);
    @pcre_compile2 := GetSymbol(PCRECompile2ExportName);
    @pcre_config := GetSymbol(PCREConfigExportName);
    @pcre_copy_named_substring := GetSymbol(PCRECopyNamedSubstringExportName);
    @pcre_copy_substring := GetSymbol(PCRECopySubStringExportName);
    @pcre_dfa_exec := GetSymbol(PCREDfaExecExportName);
    @pcre_exec := GetSymbol(PCREExecExportName);
    @pcre_free_substring := GetSymbol(PCREFreeSubStringExportName);
    @pcre_free_substring_list := GetSymbol(PCREFreeSubStringListExportName);
    @pcre_fullinfo := GetSymbol(PCREFullInfoExportName);
    @pcre_get_named_substring := GetSymbol(PCREGetNamedSubstringExportName);
    @pcre_get_stringnumber := GetSymbol(PCREGetStringNumberExportName);
    @pcre_get_stringtable_entries := GetSymbol(PCREGetStringTableEntriesExportName);
    @pcre_get_substring := GetSymbol(PCREGetSubStringExportName);
    @pcre_get_substring_list := GetSymbol(PCREGetSubStringListExportName);
    @pcre_info := GetSymbol(PCREInfoExportName);
    @pcre_maketables := GetSymbol(PCREMakeTablesExportName);
    @pcre_refcount := GetSymbol(PCRERefCountExportName);
    @pcre_study := GetSymbol(PCREStudyExportName);
    @pcre_version := GetSymbol(PCREVersionExportName);
    {$ENDIF PCRE_LINKONREQUEST}
    pcre_malloc_func := GetSymbol(PCREMallocExportName);
    pcre_free_func := GetSymbol(PCREFreeExportName);
    pcre_stack_malloc_func := GetSymbol(PCREStackMallocExportName);
    pcre_stack_free_func := GetSymbol(PCREStackFreeExportName);
    pcre_callout_func := GetSymbol(PCRECalloutExportName);
  end
  else
    InitPCREFuncPtrs(@LibNotLoadedHandler);
end;
{$ENDIF ~PCRE_STATICLINK}

Procedure UnloadPCRE;
Begin
  {$IFNDEF PCRE_STATICLINK}
  if PCRELib <> INVALID_MODULEHANDLE_VALUE then
    {$IFDEF MSWINDOWS}
    FreeLibrary(PCRELib);
    {$ENDIF MSWINDOWS}
    {$IFDEF UNIX}
    dlclose(Pointer(PCRELib));
    {$ENDIF UNIX}
  PCRELib := INVALID_MODULEHANDLE_VALUE;
  InitPCREFuncPtrs(@LibNotLoadedHandler);
  {$ENDIF ~PCRE_STATICLINK}
End;

{$IFDEF PCRE_STATICLINK}
Procedure pcre_dispose(pattern, hints, chartable : Pointer);
Begin
  If pattern <> nil Then
    pcre_free(pattern);
  If hints <> nil Then
    pcre_free(hints);
  If chartable <> nil Then
    pcre_free(chartable);
End;

{$ENDIF PCRE_STATICLINK}

{$IFDEF PCRE_LINKDLL}
function pcre_compile; external libpcremodulename name PCRECompileExportName;
function pcre_compile2; external libpcremodulename name PCRECompile2ExportName;
function pcre_config; external libpcremodulename name PCREConfigExportName;
function pcre_copy_named_substring; external libpcremodulename name PCRECopyNamedSubStringExportName;
function pcre_copy_substring; external libpcremodulename name PCRECopySubStringExportName;
function pcre_dfa_exec; external libpcremodulename name PCREDfaExecExportName;
function pcre_exec; external libpcremodulename name PCREExecExportName;
procedure pcre_free_substring; external libpcremodulename name PCREFreeSubStringExportName;
procedure pcre_free_substring_list; external libpcremodulename name PCREFreeSubStringListExportName;
function pcre_fullinfo; external libpcremodulename name PCREFullInfoExportName;
function pcre_get_named_substring; external libpcremodulename name PCREGetNamedSubStringExportName;
function pcre_get_stringnumber; external libpcremodulename name PCREGetStringNumberExportName;
function pcre_get_stringtable_entries; external libpcremodulename name PCREGetStringTableEntriesExportName;
function pcre_get_substring; external libpcremodulename name PCREGetSubStringExportName;
function pcre_get_substring_list; external libpcremodulename name PCREGetSubStringListExportName;
function pcre_info; external libpcremodulename name PCREInfoExportName;
function pcre_maketables; external libpcremodulename name PCREMakeTablesExportName;
function pcre_refcount; external libpcremodulename name PCRERefCountExportName;
function pcre_study; external libpcremodulename name PCREStudyExportName;
function pcre_version; external libpcremodulename name PCREVersionExportName;
procedure pcre_dispose; external libpcremodulename name 'pcre_dispose';
{$ENDIF PCRE_LINKDLL}

End.

