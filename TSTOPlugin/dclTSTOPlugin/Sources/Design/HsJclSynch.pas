{**************************************************************************************************}
{                                                                                                  }
{ Project JEDI Code Library (JCL)                                                                  }
{                                                                                                  }
{ The contents of this file are subject to the Mozilla Public License Version 1.1 (the "License"); }
{ you may not use this file except in compliance with the License. You may obtain a copy of the    }
{ License at http://www.mozilla.org/MPL/                                                           }
{                                                                                                  }
{ Software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF   }
{ ANY KIND, either express or implied. See the License for the specific language governing rights  }
{ and limitations under the License.                                                               }
{                                                                                                  }
{ The Original Code is JclSynch.pas.                                                               }
{                                                                                                  }
{ The Initial Developers of the Original Code are Marcel van Brakel and Azret Botash.              }
{ Portions created by these individuals are Copyright (C) of these individuals.                    }
{ All Rights Reserved.                                                                             }
{                                                                                                  }
{ Contributor(s):                                                                                  }
{   Marcel van Brakel                                                                              }
{   Olivier Sannier (obones)                                                                       }
{   Matthias Thoma (mthoma)                                                                        }
{                                                                                                  }
{**************************************************************************************************}
{                                                                                                  }
{ This unit contains various classes and support routines for implementing synchronisation in      }
{ multithreaded applications. This ranges from interlocked access to simple typed variables to     }
{ wrapper classes for synchronisation primitives provided by the operating system                  }
{ (critical section, semaphore, mutex etc). It also includes three user defined classes to         }
{ complement these.                                                                                }
{                                                                                                  }
{**************************************************************************************************}
{                                                                                                  }
{ Last modified: $Date::                                                                         $ }
{ Revision:      $Rev::                                                                          $ }
{ Author:        $Author::                                                                       $ }
{                                                                                                  }
{**************************************************************************************************}

Unit HsJclSynch;

Interface

Uses
  {$IFDEF MSWINDOWS}
  Windows,//, JclWin32,
  {$ENDIF MSWINDOWS}
  SysUtils;
//  JclBase;

// Locked Integer manipulation

// Routines to manipulate simple typed variables in a thread safe manner
Function LockedAdd(Var Target : Integer; Value : Integer) : Integer; Overload;
Function LockedCompareExchange(Var Target : Integer; Exch, Comp : Integer) : Integer; Overload;
Function LockedCompareExchange(Var Target : TObject; Exch, Comp : TObject) : TObject; Overload;
Function LockedCompareExchange(Var Target : Pointer; Exch, Comp : Pointer) : Pointer; Overload;
Function LockedDec(Var Target : Integer) : Integer; Overload;
Function LockedExchange(Var Target : Integer; Value : Integer) : Integer; Overload;
Function LockedExchangeAdd(Var Target : Integer; Value : Integer) : Integer; Overload;
Function LockedExchangeDec(Var Target : Integer) : Integer; Overload;
Function LockedExchangeInc(Var Target : Integer) : Integer; Overload;
Function LockedExchangeSub(Var Target : Integer; Value : Integer) : Integer; Overload;
Function LockedInc(Var Target : Integer) : Integer; Overload;
Function LockedSub(Var Target : Integer; Value : Integer) : Integer; Overload;

{$IFDEF CPU64}
function LockedAdd(var Target: Int64; Value: Int64): Int64; overload;
function LockedCompareExchange(var Target: Int64; Exch, Comp: Int64): Int64; overload;
function LockedDec(var Target: Int64): Int64; overload;
function LockedExchange(var Target: Int64; Value: Int64): Int64; overload;
function LockedExchangeAdd(var Target: Int64; Value: Int64): Int64; overload;
function LockedExchangeDec(var Target: Int64): Int64; overload;
function LockedExchangeInc(var Target: Int64): Int64; overload;
function LockedExchangeSub(var Target: Int64; Value: Int64): Int64; overload;
function LockedInc(var Target: Int64): Int64; overload;
function LockedSub(var Target: Int64; Value: Int64): Int64; overload;

{$IFDEF BORLAND}
function LockedDec(var Target: NativeInt): NativeInt; overload;
function LockedInc(var Target: NativeInt): NativeInt; overload;
{$ENDIF BORLAND}
{$ENDIF CPU64}

// THsJclDispatcherObject

// Base class for operating system provided synchronisation primitives
Type
  THsJclWaitResult = (wrAbandoned, wrError, wrIoCompletion, wrSignaled, wrTimeout);

  THsJclWaitHandle = THandle;

  THsJclDispatcherObject = Class(TObject)
  Private
    FExisted: Boolean;
    FHandle:  THsJclWaitHandle;
    FName:    String;
  Public
    Constructor Attach(AHandle : THsJclWaitHandle);
    Destructor Destroy; OverRide;
    //function MsgWaitFor(const TimeOut: Cardinal): THsJclWaitResult; Mask: DWORD): THsJclWaitResult;
    //function MsgWaitForEx(const TimeOut: Cardinal): THsJclWaitResult; Mask: DWORD): THsJclWaitResult;
    Function SignalAndWait(Const Obj : THsJclDispatcherObject; TimeOut : Cardinal; Alertable : Boolean) : THsJclWaitResult;
    Function WaitAlertable(Const TimeOut : Cardinal) : THsJclWaitResult;
    Function WaitFor(Const TimeOut : Cardinal) : THsJclWaitResult;
    Function WaitForever : THsJclWaitResult;
    Property Existed: Boolean Read FExisted;
    Property Handle: THsJclWaitHandle Read FHandle;
    Property Name: String Read FName;
  End;

// Wait functions

 // Object enabled Wait functions (takes THsJclDispatcher objects as parameter as
 // opposed to handles) mostly for convenience
Function WaitForMultipleObjects(Const Objects : Array Of THsJclDispatcherObject; WaitAll : Boolean; TimeOut : Cardinal) : Cardinal;
Function WaitAlertableForMultipleObjects(Const Objects : Array Of THsJclDispatcherObject; WaitAll : Boolean; TimeOut : Cardinal) : Cardinal;

Type
  THsJclCriticalSection = Class(TObject)
  Private
    FCriticalSection: TRTLCriticalSection;
  Public
    Constructor Create; Virtual;
    Destructor Destroy; OverRide;
    Class Procedure CreateAndEnter(Var CS : THsJclCriticalSection);
    Procedure Enter;
    Procedure Leave;
  End;

  THsJclCriticalSectionEx = Class(THsJclCriticalSection)
  Private
    FSpinCount: Cardinal;
    Function GetSpinCount : Cardinal;
    Procedure SetSpinCount(Const Value : Cardinal);
  Public
    Constructor Create; OverRide;
    Constructor CreateEx(SpinCount : Cardinal; NoFailEnter : Boolean); Virtual;
    Class Function GetSpinTimeOut : Cardinal;
    Class Procedure SetSpinTimeOut(Const Value : Cardinal);
    Function TryEnter : Boolean;
    Property SpinCount: Cardinal Read GetSpinCount Write SetSpinCount;
  End;

  THsJclEvent = Class(THsJclDispatcherObject)
  Public
    Constructor Create(SecAttr : PSecurityAttributes; Manual, Signaled : Boolean; Const Name : String);
    Constructor Open(Access : Cardinal; Inheritable : Boolean; Const Name : String);
    Function Pulse : Boolean;
    Function ResetEvent : Boolean;
    Function SetEvent : Boolean;
  End;

  THsJclWaitableTimer = Class(THsJclDispatcherObject)
  Private
    FResume: Boolean;
  Public
    Constructor Create(SecAttr : PSecurityAttributes; Manual : Boolean; Const Name : String);
    Constructor Open(Access : Cardinal; Inheritable : Boolean; Const Name : String);
    Function Cancel : Boolean;
    Function SetTimer(Const DueTime : Int64; Period : Longint; Resume : Boolean) : Boolean;
    Function SetTimerApc(Const DueTime : Int64; Period : Longint; Resume : Boolean; Apc : TFNTimerAPCRoutine; Arg : Pointer) : Boolean;
  End;

  THsJclSemaphore = Class(THsJclDispatcherObject)
  Public
    Constructor Create(SecAttr : PSecurityAttributes; Initial, Maximum : Longint; Const Name : String);
    Constructor Open(Access : Cardinal; Inheritable : Boolean; Const Name : String);
    Function Release(ReleaseCount : Longint) : Boolean;
    Function ReleasePrev(ReleaseCount : Longint; Var PrevCount : Longint) : Boolean;
  End;

  THsJclMutex = Class(THsJclDispatcherObject)
  Public
    Constructor Create(SecAttr : PSecurityAttributes; InitialOwner : Boolean; Const Name : String);
    Constructor Open(Access : Cardinal; Inheritable : Boolean; Const Name : String);
    Function Acquire(Const TimeOut : Cardinal = INFINITE) : Boolean;
    Function Release : Boolean;
  End;

  POptexSharedInfo = ^TOptexSharedInfo;

  TOptexSharedInfo = Record
    SpinCount: Integer;      // number of times to try and enter the optex before
    // waiting on kernel event, 0 on single processor
    LockCount: Integer;      // count of enter attempts
    ThreadId:  Longword;      // id of thread that owns the optex, 0 if free
    RecursionCount: Integer; // number of times the optex is owned, 0 if free
  End;

  THsJclOptex = Class(TObject)
  Private
    FEvent:   THsJclEvent;
    FExisted: Boolean;
    FFileMapping: THandle;
    FName:    String;
    FSharedInfo: POptexSharedInfo;
    Function GetUniProcess : Boolean;
    Function GetSpinCount : Integer;
    Procedure SetSpinCount(Value : Integer);
  Public
    Constructor Create(Const Name : String = ''; SpinCount : Integer = 4000);
    Destructor Destroy; OverRide;
    Procedure Enter;
    Procedure Leave;
    Function TryEnter : Boolean;
    Property Existed: Boolean Read FExisted;
    Property Name: String Read FName;
    Property SpinCount: Integer Read GetSpinCount Write SetSpinCount;
    Property UniProcess: Boolean Read GetUniProcess;
  End;

  TMrewPreferred = (mpReaders, mpWriters, mpEqual);

  TMrewThreadInfo = Record
    ThreadId: Longword;        // client-id of thread
    RecursionCount: Integer;   // number of times a thread accessed the mrew
    Reader:   Boolean;         // true if reader, false if writer
  End;
  TMrewThreadInfoArray = Array Of TMrewThreadInfo;

  THsJclMultiReadExclusiveWrite = Class(TObject)
  Private
    FLock:      THsJclCriticalSection;
    FPreferred: TMrewPreferred;
    FSemReaders: THsJclSemaphore;
    FSemWriters: THsJclSemaphore;
    FState:     Integer;
    FThreads:   TMrewThreadInfoArray;
    FWaitingReaders: Integer;
    FWaitingWriters: Integer;
    Procedure AddToThreadList(ThreadId : Longword; Reader : Boolean);
    Procedure RemoveFromThreadList(Index : Integer);
    Function FindThread(ThreadId : Longword) : Integer;
    Procedure ReleaseWaiters(WasReading : Boolean);
  Protected
    Procedure Release;
  Public
    Constructor Create(Preferred : TMrewPreferred);

    Destructor Destroy; OverRide;
    Procedure BeginRead;
    Procedure BeginWrite;
    Procedure EndRead;
    Procedure EndWrite;
  End;

  PMetSectSharedInfo = ^TMetSectSharedInfo;

  TMetSectSharedInfo = Record
    Initialized:  Longbool;       // Is the metered section initialized?
    SpinLock:     Longint;        // Used to gain access to this structure
    ThreadsWaiting: Longint;      // Count of threads waiting
    AvailableCount: Longint;      // Available resource count
    MaximumCount: Longint;        // Maximum resource count
  End;

  PMeteredSection = ^TMeteredSection;

  TMeteredSection = Record
    Event:      THandle;           // Handle to a kernel event object
    FileMap:    THandle;           // Handle to memory mapped file
    SharedInfo: PMetSectSharedInfo;
  End;

  THsJclMeteredSection = Class(TObject)
  Private
    FMetSect: PMeteredSection;
    Procedure CloseMeteredSection;
    Function InitMeteredSection(InitialCount, MaxCount : Longint; Const Name : String; OpenOnly : Boolean) : Boolean;
    Function CreateMetSectEvent(Const Name : String; OpenOnly : Boolean) : Boolean;
    Function CreateMetSectFileView(InitialCount, MaxCount : Longint; Const Name : String; OpenOnly : Boolean) : Boolean;
  Protected
    Procedure AcquireLock;
    Procedure ReleaseLock;
  Public
    Constructor Create(InitialCount, MaxCount : Longint; Const Name : String);
    Constructor Open(Const Name : String);
    Destructor Destroy; OverRide;
    Function Enter(TimeOut : Longword) : THsJclWaitResult;
    Function Leave(ReleaseCount : Longint) : Boolean; Overload;
    Function Leave(ReleaseCount : Longint; out PrevCount : Longint) : Boolean; Overload;
  End;

// Debugging

 // Note that the following function and structure declarations are all offically
 // undocumented and, except for QueryCriticalSection, require Windows NT since
 // it is all part of the Windows NT Native API.
 { TODO -cTest : Test this structures }
Type
  TEventInfo = Record
    EventType: Longint;        // 0 = manual, otherwise auto
    Signaled:  Longbool;       // true is signaled
  End;

  TMutexInfo = Record
    SignalState: Longint;         // >0 = signaled, <0 = |SignalState| recurs. acquired
    Owned:     Bytebool;          // owned by thread
    Abandoned: Bytebool;          // is abandoned?
  End;

  TSemaphoreCounts = Record
    CurrentCount: Longint;    // current semaphore count
    MaximumCount: Longint;    // maximum semaphore count
  End;

  TTimerInfo = Record
    Remaining: TLargeInteger;  // 100ns intervals until signaled
    Signaled:  Bytebool;       // is signaled?
  End;

Function QueryCriticalSection(CS : THsJclCriticalSection; Var Info : TRTLCriticalSection) : Boolean;
{ TODO -cTest : Test these 4 functions }
Function QueryEvent(Handle : THandle; Var Info : TEventInfo) : Boolean;
Function QueryMutex(Handle : THandle; Var Info : TMutexInfo) : Boolean;
Function QuerySemaphore(Handle : THandle; Var Info : TSemaphoreCounts) : Boolean;
Function QueryTimer(Handle : THandle; Var Info : TTimerInfo) : Boolean;

Type
  // Exceptions
  EHsJclWin32Error = Class(Exception);
  EHsJclWin32HandleObjectError = Class(EHsJclWin32Error);
  EHsJclDispatcherObjectError = Class(EHsJclWin32Error);
  EHsJclCriticalSectionError = Class(EHsJclWin32Error);
  EHsJclEventError = Class(EHsJclWin32Error);
  EHsJclWaitableTimerError = Class(EHsJclWin32Error);
  EHsJclSemaphoreError = Class(EHsJclWin32Error);
  EHsJclMutexError = Class(EHsJclWin32Error);
  EHsJclMeteredSectionError = Class(EHsJclWin32Error);

Function ValidateMutexName(Const aName : String) : String;

Implementation

Uses Math, Registry;

{uses
  SysUtils;{,
  JclLogic, JclRegistry, JclResources,
  JclSysInfo, JclStrings;}

Const
  RegSessionManager = {HKLM\} 'SYSTEM\CurrentControlSet\Control\Session Manager';
  RegCritSecTimeout = {RegSessionManager\} 'CriticalSectionTimeout';
  RtdlSetWaitableTimer: Function(hTimer : THandle; Var lpDueTime : TLargeInteger; lPeriod : Longint; pfnCompletionRoutine : TFNTimerAPCRoutine; lpArgToCompletionRoutine : Pointer; fResume : BOOL) : BOOL StdCall = SetWaitableTimer;

Resourcestring
  RsSynchAttachWin32Handle = 'Invalid handle to TJclWin32HandleObject.Attach';
  RsSynchDuplicateWin32Handle = 'Invalid handle to TJclWin32HandleObject.Duplicate';
  RsSynchInitCriticalSection = 'Failed to initalize critical section';
  RsSynchAttachDispatcher = 'Invalid handle to TJclDispatcherObject.Attach';
  RsSynchCreateEvent   = 'Failed to create event';
  RsSynchOpenEvent     = 'Failed to open event';
  RsSynchCreateWaitableTimer = 'Failed to create waitable timer';
  RsSynchOpenWaitableTimer = 'Failed to open waitable timer';
  RsSynchCreateSemaphore = 'Failed to create semaphore';
  RsSynchOpenSemaphore = 'Failed to open semaphore';
  RsSynchCreateMutex   = 'Failed to create mutex';
  RsSynchOpenMutex     = 'Failed to open mutex';
  RsMetSectInvalidParameter = 'An invalid parameter was passed to the constructor.';
  RsMetSectInitialize  = 'Failed to initialize the metered section.';
  RsMetSectNameEmpty   = 'Name cannot be empty when using the Open constructor.';

(******************************************************************************)

// Locked Integer manipulation
Function LockedAdd(Var Target : Integer; Value : Integer) : Integer;
Asm
        {$IFDEF CPU32}
        // --> EAX Target
        //     EDX Value
        // <-- EAX Result
        MOV     ECX, EAX
        MOV     EAX, EDX
        LOCK XADD [ECX], EAX
        ADD     EAX, EDX
        {$ENDIF CPU32}
        {$IFDEF CPU64}
        // --> RCX Target
        //     EDX Value
        // <-- EAX Result
        MOV     EAX, EDX
        LOCK XADD [RCX], EAX
        ADD     EAX, EDX
        {$ENDIF CPU64}
End;

Function LockedCompareExchange(Var Target : Integer; Exch, Comp : Integer) : Integer;
Asm
        {$IFDEF CPU32}
        // --> EAX Target
        //     EDX Exch
        //     ECX Comp
        // <-- EAX Result
        XCHG    EAX, ECX
        //     EAX Comp
        //     EDX Exch
        //     ECX Target
        LOCK CMPXCHG [ECX], EDX
        {$ENDIF CPU32}
        {$IFDEF CPU64}
        // --> RCX Target
        //     EDX Exch
        //     R8  Comp
        // <-- EAX Result
        MOV     RAX, R8
        //     RCX Target
        //     EDX Exch
        //     RAX Comp
        LOCK CMPXCHG [RCX], EDX
        {$ENDIF CPU64}
End;

Function LockedCompareExchange(Var Target : Pointer; Exch, Comp : Pointer) : Pointer;
Asm
        {$IFDEF CPU32}
        // --> EAX Target
        //     EDX Exch
        //     ECX Comp
        // <-- EAX Result
        XCHG    EAX, ECX
        //     EAX Comp
        //     EDX Exch
        //     ECX Target
        LOCK CMPXCHG [ECX], EDX
        {$ENDIF CPU32}
        {$IFDEF CPU64}
        // --> RCX Target
        //     RDX Exch
        //     R8  Comp
        // <-- RAX Result
        MOV     RAX, R8
        //     RCX Target
        //     RDX Exch
        //     RAX Comp
        LOCK CMPXCHG [RCX], RDX
        {$ENDIF CPU64}
End;

Function LockedCompareExchange(Var Target : TObject; Exch, Comp : TObject) : TObject;
Asm
        {$IFDEF CPU32}
        // --> EAX Target
        //     EDX Exch
        //     ECX Comp
        // <-- EAX Result
        XCHG    EAX, ECX
        //     EAX Comp
        //     EDX Exch
        //     ECX Target
        LOCK CMPXCHG [ECX], EDX
        {$ENDIF CPU32}
        {$IFDEF CPU64}
        // --> RCX Target
        //     RDX Exch
        //     R8  Comp
        // <-- RAX Result
        MOV     RAX, R8
        // --> RCX Target
        //     RDX Exch
        //     RAX Comp
        LOCK CMPXCHG [RCX], RDX
        {$ENDIF CPU64}
End;

Function LockedDec(Var Target : Integer) : Integer;
Asm
        {$IFDEF CPU32}
        // --> EAX Target
        // <-- EAX Result
        MOV     ECX, EAX
        MOV     EAX, -1
        LOCK XADD [ECX], EAX
        DEC     EAX
        {$ENDIF CPU32}
        {$IFDEF CPU64}
        // --> RCX Target
        // <-- EAX Result
        MOV     EAX, -1
        LOCK XADD [RCX], EAX
        DEC     EAX
        {$ENDIF CPU64}
End;

Function LockedExchange(Var Target : Integer; Value : Integer) : Integer;
Asm
        {$IFDEF CPU32}
        // --> EAX Target
        //     EDX Value
        // <-- EAX Result
        MOV     ECX, EAX
        MOV     EAX, EDX
        //     ECX Target
        //     EAX Value
        LOCK XCHG [ECX], EAX
        {$ENDIF CPU32}
        {$IFDEF CPU64}
        // --> RCX Target
        //     EDX Value
        // <-- EAX Result
        MOV     EAX, EDX
        //     RCX Target
        //     EAX Value
        LOCK XCHG [RCX], EAX
        {$ENDIF CPU64}
End;

Function LockedExchangeAdd(Var Target : Integer; Value : Integer) : Integer;
Asm
        {$IFDEF CPU32}
        // --> EAX Target
        //     EDX Value
        // <-- EAX Result
        MOV     ECX, EAX
        MOV     EAX, EDX
        //     ECX Target
        //     EAX Value
        LOCK XADD [ECX], EAX
        {$ENDIF CPU32}
        {$IFDEF CPU64}
        // --> RCX Target
        //     EDX Value
        // <-- EAX Result
        MOV     EAX, EDX
        //     RCX Target
        //     EAX Value
        LOCK XADD [RCX], EAX
        {$ENDIF CPU64}
End;

Function LockedExchangeDec(Var Target : Integer) : Integer;
Asm
        {$IFDEF CPU32}
        // --> EAX Target
        // <-- EAX Result
        MOV     ECX, EAX
        MOV     EAX, -1
        LOCK XADD [ECX], EAX
        {$ENDIF CPU32}
        {$IFDEF CPU64}
        // --> RCX Target
        // <-- EAX Result
        MOV     EAX, -1
        LOCK XADD [RCX], EAX
        {$ENDIF CPU64}
End;

Function LockedExchangeInc(Var Target : Integer) : Integer;
Asm
        {$IFDEF CPU32}
        // --> EAX Target
        // <-- EAX Result
        MOV     ECX, EAX
        MOV     EAX, 1
        LOCK XADD [ECX], EAX
        {$ENDIF CPU32}
        {$IFDEF CPU64}
        // --> RCX Target
        // <-- EAX Result
        MOV     EAX, 1
        LOCK XADD [RCX], EAX
        {$ENDIF CPU64}
End;

Function LockedExchangeSub(Var Target : Integer; Value : Integer) : Integer;
Asm
        {$IFDEF CPU32}
        // --> EAX Target
        //     EDX Value
        // <-- EAX Result
        MOV     ECX, EAX
        NEG     EDX
        MOV     EAX, EDX
        //     ECX Target
        //     EAX -Value
        LOCK XADD [ECX], EAX
        {$ENDIF CPU32}
        {$IFDEF CPU64}
        // --> RCX Target
        //     EDX Value
        // <-- EAX Result
        NEG     EDX
        MOV     EAX, EDX
        //     RCX Target
        //     EAX -Value
        LOCK XADD [RCX], EAX
        {$ENDIF CPU64}
End;

Function LockedInc(Var Target : Integer) : Integer;
Asm
        {$IFDEF CPU32}
        // --> EAX Target
        // <-- EAX Result
        MOV     ECX, EAX
        MOV     EAX, 1
        LOCK XADD [ECX], EAX
        INC     EAX
        {$ENDIF CPU32}
        {$IFDEF CPU64}
        // --> RCX Target
        // <-- EAX Result
        MOV     EAX, 1
        LOCK XADD [RCX], EAX
        INC     EAX
        {$ENDIF CPU64}
End;

Function LockedSub(Var Target : Integer; Value : Integer) : Integer;
Asm
        {$IFDEF CPU32}
        // --> EAX Target
        //     EDX Value
        // <-- EAX Result
        MOV     ECX, EAX
        NEG     EDX
        MOV     EAX, EDX
        LOCK XADD [ECX], EAX
        ADD     EAX, EDX
        {$ENDIF CPU32}
        {$IFDEF CPU64}
        // --> RCX Target
        //     EDX Value
        // <-- EAX Result
        NEG     EDX
        MOV     EAX, EDX
        LOCK XADD [RCX], EAX
        ADD     EAX, EDX
        {$ENDIF CPU64}
End;

{$IFDEF CPU64}

// Locked Int64 manipulation
function LockedAdd(var Target: Int64; Value: Int64): Int64;
asm
        // --> RCX Target
        //     RDX Value
        // <-- RAX Result
        MOV     RAX, RDX
        LOCK XADD [RCX], RAX
        ADD     RAX, RDX
end;

function LockedCompareExchange(var Target: Int64; Exch, Comp: Int64): Int64;
asm
        // --> RCX Target
        //     RDX Exch
        //     R8  Comp
        // <-- RAX Result
        MOV     RAX, R8
        LOCK CMPXCHG [RCX], RDX
end;

function LockedDec(var Target: Int64): Int64;
asm
        // --> RCX Target
        // <-- RAX Result
        MOV     RAX, -1
        LOCK XADD [RCX], RAX
        DEC     RAX
end;

function LockedExchange(var Target: Int64; Value: Int64): Int64;
asm
        // --> RCX Target
        //     RDX Value
        // <-- RAX Result
        MOV     RAX, RDX
        LOCK XCHG [RCX], RAX
end;

function LockedExchangeAdd(var Target: Int64; Value: Int64): Int64;
asm
        // --> RCX Target
        //     RDX Value
        // <-- RAX Result
        MOV     RAX, RDX
        LOCK XADD [RCX], RAX
end;

function LockedExchangeDec(var Target: Int64): Int64;
asm
        // --> RCX Target
        // <-- RAX Result
        MOV     RAX, -1
        LOCK XADD [RCX], RAX
end;

function LockedExchangeInc(var Target: Int64): Int64;
asm
        // --> RCX Target
        // <-- RAX Result
        MOV     RAX, 1
        LOCK XADD [RCX], RAX
end;

function LockedExchangeSub(var Target: Int64; Value: Int64): Int64;
asm
        // --> RCX Target
        //     RDX Value
        // <-- RAX Result
        NEG     RDX
        MOV     RAX, RDX
        LOCK XADD [RCX], RAX
end;

function LockedInc(var Target: Int64): Int64;
asm
        // --> RCX Target
        // <-- RAX Result
        MOV     RAX, 1
        LOCK XADD [RCX], RAX
        INC     RAX
end;

function LockedSub(var Target: Int64; Value: Int64): Int64;
asm
        // --> RCX Target
        //     RDX Value
        // <-- RAX Result
        NEG     RDX
        MOV     RAX, RDX
        LOCK XADD [RCX], RAX
        ADD     RAX, RDX
end;

{$IFDEF BORLAND}

function LockedDec(var Target: NativeInt): NativeInt;
asm
        // --> RCX Target
        // <-- RAX Result
        MOV     RAX, -1
        LOCK XADD [RCX], RAX
        DEC     RAX
end;

function LockedInc(var Target: NativeInt): NativeInt;
asm
        // --> RCX Target
        // <-- RAX Result
        MOV     RAX, 1
        LOCK XADD [RCX], RAX
        INC     RAX
end;

{$ENDIF BORLAND}

{$ENDIF CPU64}

//=== { THsJclDispatcherObject } ===============================================

Function MapSignalResult(Const Ret : DWORD) : THsJclWaitResult;
Begin
  Case Ret Of
    WAIT_ABANDONED:
      Result := wrAbandoned;
    WAIT_OBJECT_0:
      Result := wrSignaled;
    WAIT_TIMEOUT:
      Result := wrTimeout;
    WAIT_IO_COMPLETION:
      Result := wrIoCompletion;
    WAIT_FAILED:
      Result := wrError;
    Else
      Result := wrError;
  End;
End;

Constructor THsJclDispatcherObject.Attach(AHandle : THsJclWaitHandle);
Begin
  Inherited Create;
  FExisted := True;
  FHandle  := AHandle;
  FName    := '';
End;

Destructor THsJclDispatcherObject.Destroy;
Begin
  CloseHandle(FHandle);
  Inherited Destroy;
End;

{ TODO: Use RTDL Version of SignalObjectAndWait }

Function THsJclDispatcherObject.SignalAndWait(Const Obj : THsJclDispatcherObject; TimeOut : Cardinal; Alertable : Boolean) : THsJclWaitResult;
Begin
  // Note: Do not make this method virtual! It's only available on NT 4 up...
  Result := MapSignalResult(Cardinal(
{$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
    Windows.SignalObjectAndWait(Obj.Handle, Handle, TimeOut, Alertable)));
End;

Function THsJclDispatcherObject.WaitAlertable(Const TimeOut : Cardinal) : THsJclWaitResult;
Begin
  Result := MapSignalResult(
{$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
    Windows.WaitForSingleObjectEx(FHandle, TimeOut, True));
End;

Function THsJclDispatcherObject.WaitFor(Const TimeOut : Cardinal) : THsJclWaitResult;
Begin
  Result := MapSignalResult(
{$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
    Windows.WaitForSingleObject(FHandle, TimeOut));
End;

Function THsJclDispatcherObject.WaitForever : THsJclWaitResult;
Begin
  Result := WaitFor(INFINITE);
End;

// Wait functions
Function WaitForMultipleObjects(Const Objects : Array Of THsJclDispatcherObject; WaitAll : Boolean; TimeOut : Cardinal) : Cardinal;
Var
  Handles :  Array Of THsJclWaitHandle;
  I, Count : Integer;
Begin
  Count := High(Objects) + 1;
  SetLength(Handles, Count);
  For I := 0 To Count - 1 Do
    Handles[I] := Objects[I].Handle;
  Result :=
{$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
    Windows.WaitForMultipleObjects(Count, @Handles[0], WaitAll, TimeOut);
End;

Function WaitAlertableForMultipleObjects(Const Objects : Array Of THsJclDispatcherObject; WaitAll : Boolean; TimeOut : Cardinal) : Cardinal;
Var
  Handles :  Array Of THsJclWaitHandle;
  I, Count : Integer;
Begin
  Count := High(Objects) + 1;
  SetLength(Handles, Count);
  For I := 0 To Count - 1 Do
    Handles[I] := Objects[I].Handle;
  Result :=
{$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
    Windows.WaitForMultipleObjectsEx(Count, @Handles[0], WaitAll, TimeOut, True);
End;

//=== { THsJclCriticalSection } ================================================

Constructor THsJclCriticalSection.Create;
Begin
  Inherited Create;
  {$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
  Windows.InitializeCriticalSection(FCriticalSection);
End;

Destructor THsJclCriticalSection.Destroy;
Begin
  {$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
  Windows.DeleteCriticalSection(FCriticalSection);
  Inherited Destroy;
End;

Class Procedure THsJclCriticalSection.CreateAndEnter(Var CS : THsJclCriticalSection);
Var
  NewCritSect : THsJclCriticalSection;
Begin
  NewCritSect := THsJclCriticalSection.Create;
  If LockedCompareExchange(Pointer(CS), Pointer(NewCritSect), nil) <> nil Then
  Begin
    // LoadInProgress was <> nil -> no exchange took place, free the CS
    NewCritSect.Free;
  End;
  CS.Enter;
End;

Procedure THsJclCriticalSection.Enter;
Begin
  {$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
  Windows.EnterCriticalSection(FCriticalSection);
End;

Procedure THsJclCriticalSection.Leave;
Begin
  {$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
  Windows.LeaveCriticalSection(FCriticalSection);
End;

//== { THsJclCriticalSectionEx } ===============================================

Const
  DefaultCritSectSpinCount = 4000;

Constructor THsJclCriticalSectionEx.Create;
Begin
  CreateEx(DefaultCritSectSpinCount, False);
End;

{ TODO: Use RTDL Version of InitializeCriticalSectionAndSpinCount }

Constructor THsJclCriticalSectionEx.CreateEx(SpinCount : Cardinal; NoFailEnter : Boolean);
Begin
  FSpinCount := SpinCount;
  If NoFailEnter Then
    SpinCount := SpinCount Or Cardinal($80000000);

  If Not InitializeCriticalSectionAndSpinCount(FCriticalSection, SpinCount) Then
    Raise EHsJclCriticalSectionError.CreateRes(@RsSynchInitCriticalSection);
End;

Function THsJclCriticalSectionEx.GetSpinCount : Cardinal;
Begin
  // Spinning only makes sense on multiprocessor systems. On a single processor
  // system the thread would simply waste cycles while the owning thread is
  // suspended and thus cannot release the critical section.
  //  if ProcessorCount = 1 then
  //    Result := 0
  //  else
  Result := FSpinCount;
End;

Class Function THsJclCriticalSectionEx.GetSpinTimeOut : Cardinal;
Begin
  With TRegistry.Create(KEY_ALL_ACCESS) Do
    Try
      RootKey := HKEY_LOCAL_MACHINE;
      If OpenKey(RegSessionManager, False) Then
        Result := ReadInteger(RegCritSecTimeout)
      Else
        Result := 0;

    Finally
      Free();
    End;
End;

{ TODO: Use RTLD version of SetCriticalSectionSpinCount }
Procedure THsJclCriticalSectionEx.SetSpinCount(Const Value : Cardinal);
Begin
  FSpinCount := SetCriticalSectionSpinCount(FCriticalSection, Value);
End;

Class Procedure THsJclCriticalSectionEx.SetSpinTimeOut(Const Value : Cardinal);
Begin
  With TRegistry.Create(KEY_ALL_ACCESS) Do
    Try
      RootKey := HKEY_LOCAL_MACHINE;
      If OpenKey(RegSessionManager, False) Then
        WriteInteger(RegCritSecTimeout, Value);

    Finally
      Free();
    End;
End;

{ TODO: Use RTLD version of TryEnterCriticalSection }
Function THsJclCriticalSectionEx.TryEnter : Boolean;
Begin
  Result := TryEnterCriticalSection(FCriticalSection);
End;

//== { THsJclEvent } ===========================================================

Constructor THsJclEvent.Create(SecAttr : PSecurityAttributes; Manual, Signaled : Boolean; Const Name : String);
Begin
  Inherited Create;
  FName   := Name;
  FHandle :=
{$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
    Windows.CreateEvent(SecAttr, Manual, Signaled, PChar(FName));
  If FHandle = 0 Then
    Raise EHsJclEventError.CreateRes(@RsSynchCreateEvent);
  FExisted := GetLastError = ERROR_ALREADY_EXISTS;
End;

Constructor THsJclEvent.Open(Access : Cardinal; Inheritable : Boolean; Const Name : String);
Begin
  FName    := Name;
  FExisted := True;
  FHandle  :=
{$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
    Windows.OpenEvent(Access, Inheritable, PChar(Name));
  If FHandle = 0 Then
    Raise EHsJclEventError.CreateRes(@RsSynchOpenEvent);
End;

Function THsJclEvent.Pulse : Boolean;
Begin
  Result :=
{$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
    Windows.PulseEvent(FHandle);
End;

Function THsJclEvent.ResetEvent : Boolean;
Begin
  Result :=
{$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
    Windows.ResetEvent(FHandle);
End;

Function THsJclEvent.SetEvent : Boolean;
Begin
  Result :=
{$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
    Windows.SetEvent(FHandle);
End;

//=== { THsJclWaitableTimer } ==================================================

{ TODO: Use RTLD version of CreateWaitableTimer }
Constructor THsJclWaitableTimer.Create(SecAttr : PSecurityAttributes; Manual : Boolean; Const Name : String);
Begin
  FName   := Name;
  FResume := False;
  FHandle := CreateWaitableTimer(SecAttr, Manual, PChar(Name));
  If FHandle = 0 Then
    Raise EHsJclWaitableTimerError.CreateRes(@RsSynchCreateWaitableTimer);
  FExisted := GetLastError = ERROR_ALREADY_EXISTS;
End;

{ TODO: Use RTLD version of CancelWaitableTimer }
Function THsJclWaitableTimer.Cancel : Boolean;
Begin
  Result := CancelWaitableTimer(FHandle);
End;

{ TODO: Use RTLD version of OpenWaitableTimer }

Constructor THsJclWaitableTimer.Open(Access : Cardinal; Inheritable : Boolean; Const Name : String);
Begin
  FExisted := True;
  FName    := Name;
  FResume  := False;
  FHandle  := OpenWaitableTimer(Access, Inheritable, PChar(Name));
  If FHandle = 0 Then
    Raise EHsJclWaitableTimerError.CreateRes(@RsSynchOpenWaitableTimer);
End;

{ TODO: Use RTLD version of SetWaitableTimer }
Function THsJclWaitableTimer.SetTimer(Const DueTime : Int64; Period : Longint; Resume : Boolean) : Boolean;
Var
  DT : Int64;
Begin
  DT      := DueTime;
  FResume := Resume;
  Result  := SetWaitableTimer(FHandle, DT, Period, nil, nil, FResume);
End;

{ TODO -cHelp : OS restrictions }
Function THsJclWaitableTimer.SetTimerApc(Const DueTime : Int64; Period : Longint; Resume : Boolean; Apc : TFNTimerAPCRoutine; Arg : Pointer) : Boolean;
Var
  DT : Int64;
Begin
  DT      := DueTime;
  FResume := Resume;
  Result  := RtdlSetWaitableTimer(FHandle, DT, Period, Apc, Arg, FResume);
  { TODO : Exception for Win9x, older WinNT? }
  // if not Result and (GetLastError = ERROR_CALL_NOT_IMPLEMENTED) then
  //   RaiseLastOSError;
End;

//== { THsJclSemaphore } =======================================================

Constructor THsJclSemaphore.Create(SecAttr : PSecurityAttributes; Initial, Maximum : Integer; Const Name : String);
Begin
  Assert((Initial >= 0) And (Maximum > 0));
  FName   := Name;
  FHandle :=
{$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
    Windows.CreateSemaphore(SecAttr, Initial, Maximum, PChar(Name));
  If FHandle = 0 Then
    Raise EHsJclSemaphoreError.CreateRes(@RsSynchCreateSemaphore);
  FExisted := GetLastError = ERROR_ALREADY_EXISTS;
End;

Constructor THsJclSemaphore.Open(Access : Cardinal; Inheritable : Boolean; Const Name : String);
Begin
  FName    := Name;
  FExisted := True;
  FHandle  :=
{$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
    Windows.OpenSemaphore(Access, Inheritable, PChar(Name));
  If FHandle = 0 Then
    Raise EHsJclSemaphoreError.CreateRes(@RsSynchOpenSemaphore);
End;

Function THsJclSemaphore.ReleasePrev(ReleaseCount : Longint; Var PrevCount : Longint) : Boolean;
Begin
  Result :=
{$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
    Windows.ReleaseSemaphore(FHandle, ReleaseCount, @PrevCount);
End;

Function THsJclSemaphore.Release(ReleaseCount : Integer) : Boolean;
Begin
  Result :=
{$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
    Windows.ReleaseSemaphore(FHandle, ReleaseCount, nil);
End;

//=== { THsJclMutex } ==========================================================

Function THsJclMutex.Acquire(Const TimeOut : Cardinal) : Boolean;
Begin
  Result := WaitFor(TimeOut) = wrSignaled;
End;

Function CreateMutex(lpMutexAttributes : PSecurityAttributes; bInitialOwner : BOOL; lpName : PChar) : THandle; StdCall;
  External kernel32 Name 'CreateMutexA';
Function CreateMutexA(lpMutexAttributes : PSecurityAttributes; bInitialOwner : BOOL; lpName : PChar) : THandle; StdCall;
  External kernel32 Name 'CreateMutexA';
Function CreateMutexW(lpMutexAttributes : PSecurityAttributes; bInitialOwner : BOOL; lpName : PChar) : THandle; StdCall;
  External kernel32 Name 'CreateMutexW';

Constructor THsJclMutex.Create(SecAttr : PSecurityAttributes; InitialOwner : Boolean; Const Name : String);
Begin
  Inherited Create;
  FName   := Name;
  FHandle := CreateMutex(SecAttr, InitialOwner, PChar(Name));
  If FHandle = 0 Then
    Raise EHsJclMutexError.CreateRes(@RsSynchCreateMutex);
  FExisted := GetLastError = ERROR_ALREADY_EXISTS;
End;

Constructor THsJclMutex.Open(Access : Cardinal; Inheritable : Boolean; Const Name : String);
Begin
  Inherited Create;
  FName    := Name;
  FExisted := True;
  FHandle  :=
{$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
    Windows.OpenMutex(Access, Inheritable, PChar(Name));
  If FHandle = 0 Then
    Raise EHsJclMutexError.CreateRes(@RsSynchOpenMutex);
End;

Function THsJclMutex.Release : Boolean;
Begin
  Result :=
{$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
    Windows.ReleaseMutex(FHandle);
End;

//=== { THsJclOptex } ==========================================================

Constructor THsJclOptex.Create(Const Name : String; SpinCount : Integer);
Begin
  FExisted := False;
  FName    := Name;
  If Name = '' Then
  Begin
    // None shared optex, don't need filemapping, sharedinfo is local
    FFileMapping := 0;
    FEvent      := THsJclEvent.Create(nil, False, False, '');
    FSharedInfo := AllocMem(SizeOf(TOptexSharedInfo));
  End
  Else
  Begin
    // Shared optex, event protects access to sharedinfo. Creation of filemapping
    // doesn't need protection as it will automatically "open" instead of "create"
    // if another process already created it.
    FEvent   := THsJclEvent.Create(nil, False, False, 'Optex_Event_' + Name);
    FExisted := FEvent.Existed;
    FFileMapping :=
{$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
      Windows.CreateFileMapping(INVALID_HANDLE_VALUE, nil, PAGE_READWRITE,
      0, SizeOf(TOptexSharedInfo), PChar('Optex_MMF_' + Name));
    Assert(FFileMapping <> 0);
    FSharedInfo :=
{$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
      Windows.MapViewOfFile(FFileMapping, FILE_MAP_WRITE, 0, 0, 0);
    Assert(FSharedInfo <> nil);
  End;
  SetSpinCount(SpinCount);
End;

Destructor THsJclOptex.Destroy;
Begin
  FreeAndNil(FEvent);
  If UniProcess Then
    FreeMem(FSharedInfo)
  Else
  Begin
    {$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
    Windows.UnmapViewOfFile(FSharedInfo);
    {$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
    Windows.CloseHandle(FFileMapping);
  End;
  Inherited Destroy;
End;

Procedure THsJclOptex.Enter;
Var
  ThreadId : Longword;
Begin
  If TryEnter Then
    Exit;
  ThreadId :=
{$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
    Windows.GetCurrentThreadId;
  If
{$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
  Windows.InterlockedIncrement(FSharedInfo^.LockCount) = 1 Then
  Begin
    // Optex was unowned
    FSharedInfo^.ThreadId := ThreadId;
    FSharedInfo^.RecursionCount := 1;
  End
  Else
  Begin
    If FSharedInfo^.ThreadId = ThreadId Then
    Begin
      // We already owned it, increase ownership count
      Inc(FSharedInfo^.RecursionCount);
    End
    Else
    Begin
      // Optex is owner by someone else, wait for it to be released and then
      // immediately take ownership
      FEvent.WaitForever;
      FSharedInfo^.ThreadId := ThreadId;
      FSharedInfo^.RecursionCount := 1;
    End;
  End;
End;

Function THsJclOptex.GetSpinCount : Integer;
Begin
  Result := FSharedInfo^.SpinCount;
End;

Function THsJclOptex.GetUniProcess : Boolean;
Begin
  Result := FFileMapping = 0;
End;

Procedure THsJclOptex.Leave;
Begin
  Dec(FSharedInfo^.RecursionCount);
  If FSharedInfo^.RecursionCount > 0 Then
    {$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
    Windows.InterlockedDecrement(FSharedInfo^.LockCount)
  Else
  Begin
    FSharedInfo^.ThreadId := 0;
    If
{$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
    Windows.InterlockedDecrement(FSharedInfo^.LockCount) > 0 Then
      FEvent.SetEvent;
  End;
End;

Procedure THsJclOptex.SetSpinCount(Value : Integer);
Begin
  If Value < 0 Then
    Value := DefaultCritSectSpinCount;
  // Spinning only makes sense on multiprocessor systems
  Windows.InterlockedExchange(Integer(FSharedInfo^.SpinCount), Value);
End;

Function THsJclOptex.TryEnter : Boolean;
Var
  ThreadId :  Longword;
  ThreadOwnsOptex : Boolean;
  SpinCount : Integer;
Begin
  ThreadId  := Windows.GetCurrentThreadId;
  SpinCount := FSharedInfo^.SpinCount;
  Repeat
    //ThreadOwnsOptex := InterlockedCompareExchange(Pointer(FSharedInfo^.LockCount),
    //  Pointer(1), Pointer(0)) = Pointer(0); // not available on win95
    ThreadOwnsOptex := LockedCompareExchange(FSharedInfo^.LockCount, 1, 0) = 0;
    If ThreadOwnsOptex Then
    Begin
      // Optex was unowned
      FSharedInfo^.ThreadId := ThreadId;
      FSharedInfo^.RecursionCount := 1;
    End
    Else
    Begin
      If FSharedInfo^.ThreadId = ThreadId Then
      Begin
        // We already owned the Optex
        {$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
        Windows.InterlockedIncrement(FSharedInfo^.LockCount);
        Inc(FSharedInfo^.RecursionCount);
        ThreadOwnsOptex := True;
      End;
    End;
    Dec(SpinCount);
  Until ThreadOwnsOptex Or (SpinCount <= 0);
  Result := ThreadOwnsOptex;
End;

//=== { THsJclMultiReadExclusiveWrite } ========================================

Constructor THsJclMultiReadExclusiveWrite.Create(Preferred : TMrewPreferred);
Begin
  Inherited Create;
  FLock      := THsJclCriticalSection.Create;
  FPreferred := Preferred;
  FSemReaders := THsJclSemaphore.Create(nil, 0, MaxInt, '');
  FSemWriters := THsJclSemaphore.Create(nil, 0, MaxInt, '');
  SetLength(FThreads, 0);
  FState := 0;
  FWaitingReaders := 0;
  FWaitingWriters := 0;
End;

Destructor THsJclMultiReadExclusiveWrite.Destroy;
Begin
  FreeAndNil(FSemReaders);
  FreeAndNil(FSemWriters);
  FreeAndNil(FLock);
  Inherited Destroy;
End;

Procedure THsJclMultiReadExclusiveWrite.AddToThreadList(ThreadId : Longword; Reader : Boolean);
Var
  L : Integer;
Begin
  // Caller must own lock
  L := Length(FThreads);
  SetLength(FThreads, L + 1);
  FThreads[L].ThreadId := ThreadId;
  FThreads[L].RecursionCount := 1;
  FThreads[L].Reader   := Reader;
End;

Procedure THsJclMultiReadExclusiveWrite.BeginRead;
Var
  ThreadId : Longword;
  Index :    Integer;
  MustWait : Boolean;
Begin
  MustWait := False;
  ThreadId :=
{$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
    Windows.GetCurrentThreadId;
  FLock.Enter;
  Try
    Index := FindThread(ThreadId);
    If Index >= 0 Then
    Begin
      // Thread is on threadslist so it is already reading
      Inc(FThreads[Index].RecursionCount);
    End
    Else
    Begin
      // Request to read (first time)
      AddToThreadList(ThreadId, True);
      If FState >= 0 Then
      Begin
        // MREW is unowned or only readers. If there are no waiting writers or
        // readers are preferred then allow thread to continue, otherwise it must
        // wait it's turn
        If (FPreferred = mpReaders) Or (FWaitingWriters = 0) Then
          Inc(FState)
        Else
        Begin
          Inc(FWaitingReaders);
          MustWait := True;
        End;
      End
      Else
      Begin
        // MREW is owner by a writer, must wait
        Inc(FWaitingReaders);
        MustWait := True;
      End;
    End;
  Finally
    FLock.Leave;
  End;
  If MustWait Then
    FSemReaders.WaitForever;
End;

Procedure THsJclMultiReadExclusiveWrite.BeginWrite;
Var
  ThreadId : Longword;
  Index :    Integer;
  MustWait : Boolean;
Begin
  MustWait := False;
  FLock.Enter;
  Try
    ThreadId :=
{$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
      Windows.GetCurrentThreadId;
    Index    := FindThread(ThreadId);
    If Index < 0 Then
    Begin
      // Request to write (first time)
      AddToThreadList(ThreadId, False);
      If FState = 0 Then
      Begin
        // MREW is unowned so start writing
        FState := -1;
      End
      Else
      Begin
        // MREW is owner, must wait
        Inc(FWaitingWriters);
        MustWait := True;
      End;
    End
    Else
    Begin
      If FThreads[Index].Reader Then
      Begin
        // Request to write while reading
        Inc(FThreads[Index].RecursionCount);
        FThreads[Index].Reader := False;
        Dec(FState);
        If FState = 0 Then
        Begin
          // MREW is unowned so start writing
          FState := -1;
        End
        Else
        Begin
          // MREW is owned, must wait
          MustWait := True;
          Inc(FWaitingWriters);
        End;
      End
      Else
        // Requesting to write while already writing
        Inc(FThreads[Index].RecursionCount);
    End;
  Finally
    FLock.Leave;
  End;
  If MustWait Then
    FSemWriters.WaitFor(INFINITE);
End;

Procedure THsJclMultiReadExclusiveWrite.EndRead;
Begin
  Release;
End;

Procedure THsJclMultiReadExclusiveWrite.EndWrite;
Begin
  Release;
End;

Function THsJclMultiReadExclusiveWrite.FindThread(ThreadId : Longword) : Integer;
Var
  I : Integer;
Begin
  // Caller must lock
  Result := -1;
  For I := 0 To Length(FThreads) - 1 Do
    If FThreads[I].ThreadId = ThreadId Then
    Begin
      Result := I;
      Exit;
    End;
End;

Procedure THsJclMultiReadExclusiveWrite.Release;
Var
  ThreadId :   Longword;
  Index :      Integer;
  WasReading : Boolean;
Begin
  ThreadId := GetCurrentThreadId;
  FLock.Enter;
  Try
    Index := FindThread(ThreadId);
    If Index >= 0 Then
    Begin
      Dec(FThreads[Index].RecursionCount);
      If FThreads[Index].RecursionCount = 0 Then
      Begin
        WasReading := FThreads[Index].Reader;
        If WasReading Then
          Dec(FState)
        Else
          FState := 0;
        RemoveFromThreadList(Index);
        If FState = 0 Then
          ReleaseWaiters(WasReading);
      End;
    End;
  Finally
    FLock.Leave;
  End;
End;

Procedure THsJclMultiReadExclusiveWrite.ReleaseWaiters(WasReading : Boolean);
Var
  ToRelease : TMrewPreferred;
Begin
  // Caller must Lock
  ToRelease := mpEqual;
  Case FPreferred Of
    mpReaders:
      If FWaitingReaders > 0 Then
        ToRelease := mpReaders
      Else
      If FWaitingWriters > 0 Then
        ToRelease := mpWriters;
    mpWriters:
      If FWaitingWriters > 0 Then
        ToRelease := mpWriters
      Else
      If FWaitingReaders > 0 Then
        ToRelease := mpReaders;
    mpEqual:
      If WasReading Then
      Begin
        If FWaitingWriters > 0 Then
          ToRelease := mpWriters
        Else
        If FWaitingReaders > 0 Then
          ToRelease := mpReaders;
      End
      Else
      Begin
        If FWaitingReaders > 0 Then
          ToRelease := mpReaders
        Else
        If FWaitingWriters > 0 Then
          ToRelease := mpWriters;
      End;
  End;
  Case ToRelease Of
    mpReaders:
    Begin
      FState := FWaitingReaders;
      FWaitingReaders := 0;
      FSemReaders.Release(FState);
    End;
    mpWriters:
    Begin
      FState := -1;
      Dec(FWaitingWriters);
      FSemWriters.Release(1);
    End;
    mpEqual:
    // no waiters
  End;
End;

Procedure THsJclMultiReadExclusiveWrite.RemoveFromThreadList(Index : Integer);
Var
  L : Integer;
Begin
  // Caller must Lock
  L := Length(FThreads);
  If Index < (L - 1) Then
    Move(FThreads[Index + 1], FThreads[Index], SizeOf(TMrewThreadInfo) * (L - Index - 1));
  SetLength(FThreads, L - 1);
End;

//=== { THsJclMeteredSection } =================================================

Const
  MAX_METSECT_NAMELEN = 128;

Constructor THsJclMeteredSection.Create(InitialCount, MaxCount : Integer; Const Name : String);
Begin
  If (MaxCount < 1) Or (InitialCount > MaxCount) Or (InitialCount < 0) Or
    (Length(Name) > MAX_METSECT_NAMELEN) Then
    Raise EHsJclMeteredSectionError.CreateRes(@RsMetSectInvalidParameter);
  FMetSect := PMeteredSection(AllocMem(SizeOf(TMeteredSection)));
  If FMetSect <> nil Then
  Begin
    If Not InitMeteredSection(InitialCount, MaxCount, Name, False) Then
    Begin
      CloseMeteredSection;
      FMetSect := nil;
      Raise EHsJclMeteredSectionError.CreateRes(@RsMetSectInitialize);
    End;
  End;
End;

Constructor THsJclMeteredSection.Open(Const Name : String);
Begin
  FMetSect := nil;
  If Name = '' Then
    Raise EHsJclMeteredSectionError.CreateRes(@RsMetSectNameEmpty);
  FMetSect := PMeteredSection(AllocMem(SizeOf(TMeteredSection)));
  Assert(FMetSect <> nil);
  If Not InitMeteredSection(0, 0, Name, True) Then
  Begin
    CloseMeteredSection;
    FMetSect := nil;
    Raise EHsJclMeteredSectionError.CreateRes(@RsMetSectInitialize);
  End;
End;

Destructor THsJclMeteredSection.Destroy;
Begin
  CloseMeteredSection;
  Inherited Destroy;
End;

Procedure THsJclMeteredSection.AcquireLock;
Begin
  While
{$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
    Windows.InterlockedExchange(FMetSect^.SharedInfo^.SpinLock, 1) <> 0 Do
    {$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
    Windows.Sleep(0);
End;

Procedure THsJclMeteredSection.CloseMeteredSection;
Begin
  If FMetSect <> nil Then
  Begin
    If FMetSect^.SharedInfo <> nil Then
      {$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
      Windows.UnmapViewOfFile(FMetSect^.SharedInfo);
    If FMetSect^.FileMap <> 0 Then
      {$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
      Windows.CloseHandle(FMetSect^.FileMap);
    If FMetSect^.Event <> 0 Then
      {$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
      Windows.CloseHandle(FMetSect^.Event);
    FreeMem(FMetSect);
  End;
End;

Function THsJclMeteredSection.CreateMetSectEvent(Const Name : String; OpenOnly : Boolean) : Boolean;
Var
  FullName : String;
Begin
  If Name = '' Then
    FMetSect^.Event :=
{$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
      Windows.CreateEvent(nil, False, False, nil)
  Else
  Begin
    FullName := 'JCL_MSECT_EVT_' + Name;
    If OpenOnly Then
      FMetSect^.Event :=
{$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
        Windows.OpenEvent(0, False, PChar(FullName))
    Else
      FMetSect^.Event :=
{$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
        Windows.CreateEvent(nil, False, False, PChar(FullName));
  End;
  Result := FMetSect^.Event <> 0;
End;

Function THsJclMeteredSection.CreateMetSectFileView(InitialCount, MaxCount : Longint; Const Name : String; OpenOnly : Boolean) : Boolean;
Var
  FullName :  String;
  LastError : DWORD;
Begin
  Result := False;
  If Name = '' Then
    FMetSect^.FileMap :=
{$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
      Windows.CreateFileMapping(INVALID_HANDLE_VALUE, nil, PAGE_READWRITE, 0, SizeOf(TMetSectSharedInfo), nil)
  Else
  Begin
    FullName := 'JCL_MSECT_MMF_' + Name;
    If OpenOnly Then
      FMetSect^.FileMap :=
{$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
        Windows.OpenFileMapping(0, False, PChar(FullName))
    Else
      FMetSect^.FileMap :=
{$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
        Windows.CreateFileMapping(INVALID_HANDLE_VALUE, nil, PAGE_READWRITE, 0, SizeOf(TMetSectSharedInfo), PChar(FullName));
  End;
  If FMetSect^.FileMap <> 0 Then
  Begin
    LastError := GetLastError;
    FMetSect^.SharedInfo :=
{$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
      Windows.MapViewOfFile(FMetSect^.FileMap, FILE_MAP_WRITE, 0, 0, 0);
    If FMetSect^.SharedInfo <> nil Then
    Begin
      If LastError = ERROR_ALREADY_EXISTS Then
        While Not FMetSect^.SharedInfo^.Initialized Do
          Sleep(0)
      Else
      Begin
        FMetSect^.SharedInfo^.SpinLock     := 0;
        FMetSect^.SharedInfo^.ThreadsWaiting := 0;
        FMetSect^.SharedInfo^.AvailableCount := InitialCount;
        FMetSect^.SharedInfo^.MaximumCount := MaxCount;
        {$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
        Windows.InterlockedExchange(Integer(FMetSect^.SharedInfo^.Initialized), 1);
      End;
      Result := True;
    End;
  End;
End;

Function THsJclMeteredSection.Enter(TimeOut : Longword) : THsJclWaitResult;
Begin
  Result := wrSignaled;
  While Result = wrSignaled Do
  Begin
    AcquireLock;
    Try
      If FMetSect^.SharedInfo^.AvailableCount >= 1 Then
      Begin
        Dec(FMetSect^.SharedInfo^.AvailableCount);
        Result := MapSignalResult(WAIT_OBJECT_0);
        Exit;
      End;
      Inc(FMetSect^.SharedInfo^.ThreadsWaiting);
      {$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
      Windows.ResetEvent(FMetSect^.Event);
    Finally
      ReleaseLock;
    End;
    Result := MapSignalResult(
{$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
      Windows.WaitForSingleObject(FMetSect^.Event, TimeOut));
  End;
End;

Function THsJclMeteredSection.InitMeteredSection(InitialCount, MaxCount : Longint; Const Name : String; OpenOnly : Boolean) : Boolean;
Begin
  Result := False;
  If CreateMetSectEvent(Name, OpenOnly) Then
    Result := CreateMetSectFileView(InitialCount, MaxCount, Name, OpenOnly);
End;

Function THsJclMeteredSection.Leave(ReleaseCount : Integer; out PrevCount : Integer) : Boolean;
Var
  Count : Integer;
Begin
  Result := False;
  AcquireLock;
  Try
    PrevCount := FMetSect^.SharedInfo^.AvailableCount;
    If (ReleaseCount < 0) Or
      (FMetSect^.SharedInfo^.AvailableCount + ReleaseCount > FMetSect^.SharedInfo^.MaximumCount) Then
    Begin
      {$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
      Windows.SetLastError(ERROR_INVALID_PARAMETER);
      Exit;
    End;
    Inc(FMetSect^.SharedInfo^.AvailableCount, ReleaseCount);
    ReleaseCount := Min(ReleaseCount, FMetSect^.SharedInfo^.ThreadsWaiting);
    If FMetSect^.SharedInfo^.ThreadsWaiting > 0 Then
    Begin
      For Count := 0 To ReleaseCount - 1 Do
      Begin
        Dec(FMetSect^.SharedInfo^.ThreadsWaiting);
        {$IFDEF HAS_UNITSCOPE}Winapi.{$ENDIF}
        Windows.SetEvent(FMetSect^.Event);
      End;
    End;
  Finally
    ReleaseLock;
  End;
  Result := True;
End;

Function THsJclMeteredSection.Leave(ReleaseCount : Integer) : Boolean;
Var
  Previous : Longint;
Begin
  Result := Leave(ReleaseCount, Previous);
End;

Procedure THsJclMeteredSection.ReleaseLock;
Begin
  Windows.InterlockedExchange(FMetSect^.SharedInfo^.SpinLock, 0);
End;

//=== Debugging ==============================================================

Function QueryCriticalSection(CS : THsJclCriticalSection; Var Info : TRTLCriticalSection) : Boolean;
Begin
  Result := CS <> nil;
  If Result Then
    Info := CS.FCriticalSection;
End;

 // Native API functions
 // http://undocumented.ntinternals.net/

{ TODO: RTLD version }

Type
  TNtQueryProc = Function(Handle : THandle; InfoClass : Byte; Info : Pointer; Len : Longint; ResLen : PLongint) : Longint; StdCall;

Var
  _QueryEvent :     TNtQueryProc = nil;
  _QueryMutex :     TNtQueryProc = nil;
  _QuerySemaphore : TNtQueryProc = nil;
  _QueryTimer :     TNtQueryProc = nil;

Function CallQueryProc(Var P : TNtQueryProc; Const Name : String; Handle : THandle; Info : Pointer; InfoSize : Longint) : Boolean;
Var
  NtDll :  THandle;
  Status : Longint;
Begin
  Result := False;

  If @P = nil Then
  Begin
    NtDll := GetModuleHandle(PChar('ntdll.dll'));
    If NtDll <> 0 Then
      @P := GetProcAddress(NtDll, PChar(Name));
  End;

  If @P <> nil Then
  Begin
    Status := P(Handle, 0, Info, InfoSize, nil);
    Result := (Status And $80000000) = 0;
  End;
End;

Function QueryEvent(Handle : THandle; Var Info : TEventInfo) : Boolean;
Begin
  Result := CallQueryProc(_QueryEvent, 'NtQueryEvent', Handle, @Info, SizeOf(Info));
End;

Function QueryMutex(Handle : THandle; Var Info : TMutexInfo) : Boolean;
Begin
  Result := CallQueryProc(_QueryMutex, 'NtQueryMutex', Handle, @Info, SizeOf(Info));
End;

Function QuerySemaphore(Handle : THandle; Var Info : TSemaphoreCounts) : Boolean;
Begin
  Result := CallQueryProc(_QuerySemaphore, 'NtQuerySemaphore', Handle, @Info, SizeOf(Info));
End;

Function QueryTimer(Handle : THandle; Var Info : TTimerInfo) : Boolean;
Begin
  Result := CallQueryProc(_QueryTimer, 'NtQueryTimer', Handle, @Info, SizeOf(Info));
End;

Function ValidateMutexName(Const aName : String) : String;
Const
  cMutexMaxName = 200;
Begin
  If Length(aName) > cMutexMaxName Then
    Result := Copy(aName, Length(aName) - cMutexMaxName, cMutexMaxName)
  Else
    Result := aName;

  Result := StringReplace(Result, '\', '_', [rfReplaceAll, rfIgnoreCase]);
End;

End.

