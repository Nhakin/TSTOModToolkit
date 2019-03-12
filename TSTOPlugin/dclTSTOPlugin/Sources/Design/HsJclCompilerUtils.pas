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
{ The Original Code is DelphiInstall.pas.                                                          }
{                                                                                                  }
{ The Initial Developer of the Original Code is Petr Vones. Portions created by Petr Vones are     }
{ Copyright (C) of Petr Vones. All Rights Reserved.                                                }
{                                                                                                  }
{ Contributor(s):                                                                                  }
{   Andreas Hausladen (ahuser)                                                                     }
{   Florent Ouchet (outchy)                                                                        }
{   Robert Marquardt (marquardt)                                                                   }
{   Robert Rossmair (rrossmair) - crossplatform & BCB support                                      }
{   Uwe Schuster (uschuster)                                                                       }
{                                                                                                  }
{**************************************************************************************************}
{                                                                                                  }
{ Last modified: $Date::                                                                         $ }
{ Revision:      $Rev::                                                                          $ }
{ Author:        $Author::                                                                       $ }
{                                                                                                  }
{**************************************************************************************************}

unit HsJclCompilerUtils;

interface

uses
  {$IFDEF MSWINDOWS}
  Windows,
  {$ENDIF MSWINDOWS}
  Classes, SysUtils, IniFiles;{,
  JclBase, JclSysUtils;}

type
  TTextHandler = procedure(const Text: string) of object;
  
  EHsJclError = Class(Exception);
  EHsJclCompilerUtilsException = class(EHsJclError);

  THsJclCompilerSettingsFormat = (csfDOF, csfBDSProj, csfMsBuild);

  THsJclBorlandCommandLineTool = class;
  THsJclBorlandCommandLineToolEvent = procedure(Sender:THsJclBorlandCommandLineTool) of object;

  IJclCommandLineTool = interface
    ['{A0034B09-A074-D811-847D-0030849E4592}']
    function GetExeName: string;
    function GetOptions: TStrings;
    function GetOutput: string;
    function GetOutputCallback: TTextHandler;
    procedure AddPathOption(const Option, Path: string);
    function Execute(const CommandLine: string): Boolean;
    procedure SetOutputCallback(const CallbackMethod: TTextHandler);
    property ExeName: string read GetExeName;
    property Options: TStrings read GetOptions;
    property OutputCallback: TTextHandler read GetOutputCallback write SetOutputCallback;
    property Output: string read GetOutput;
  end;
    
  THsJclBorlandCommandLineTool = class(TInterfacedObject, IJclCommandLineTool)
  private
    FBinDirectory: string;
    FCompilerSettingsFormat: THsJclCompilerSettingsFormat;
    FLongPathBug: Boolean;
    FOptions: TStringList;
    FOutputCallback: TTextHandler;
    FOutput: string;
    FOnAfterExecute: THsJclBorlandCommandLineToolEvent;
    FOnBeforeExecute: THsJclBorlandCommandLineToolEvent;
  protected
    procedure CheckOutputValid;
    function GetFileName: string;
    function InternalExecute(const CommandLine: string): Boolean;
  public
    constructor Create(const ABinDirectory: string; ALongPathBug: Boolean;
      ACompilerSettingsFormat: THsJclCompilerSettingsFormat);
    destructor Destroy; override;
    { IJclCommandLineTool }
    function GetExeName: string; virtual;
    function GetOptions: TStrings;
    function GetOutput: string;
    function GetOutputCallback: TTextHandler;
    procedure AddPathOption(const Option, Path: string);
    function Execute(const CommandLine: string): Boolean; virtual;
    procedure SetOutputCallback(const CallbackMethod: TTextHandler);
    property BinDirectory: string read FBinDirectory;
    property CompilerSettingsFormat: THsJclCompilerSettingsFormat read FCompilerSettingsFormat;
    property ExeName: string read GetExeName;
    property LongPathBug: Boolean read FLongPathBug;
    property Options: TStrings read GetOptions;
    property OutputCallback: TTextHandler write SetOutputCallback;
    property Output: string read GetOutput;

    property FileName: string read GetFileName;
    property OnAfterExecute: THsJclBorlandCommandLineToolEvent read FOnAfterExecute write FOnAfterExecute;
    property OnBeforeExecute: THsJclBorlandCommandLineToolEvent read FOnBeforeExecute write FOnBeforeExecute;
  end;

  THsJclBCC32 = class(THsJclBorlandCommandLineTool)
  public
    class function GetPlatform: string; virtual;
    function GetExeName: string; override;
  end;

  THsJclBCC64 = class(THsJclBCC32)
  public
    class function GetPlatform: string; override;
    function GetExeName: string; override;
  end;

  TProjectOptions = record
    UsePackages: Boolean;
    UnitOutputDir: string;
    SearchPath: string;
    DynamicPackages: string;
    SearchDcpPath: string;
    Conditionals: string;
    Namespace: string;
  end;

  THsJclStringsGetterFunction = function: TStrings of object;

  THsJclDCC32 = class(THsJclBorlandCommandLineTool)
  private
    FDCPSearchPath: string;
    FLibrarySearchPath: string;
    FLibraryDebugSearchPath: string;
    FCppSearchPath: string;
    FOnEnvironmentVariables: THsJclStringsGetterFunction;
    FSupportsNoConfig: Boolean;
    FSupportsPlatform: Boolean;
    FDCCVersion: Single;
  protected
    procedure AddProjectOptions(const ProjectFileName, DCPPath: string);
    function Compile(const ProjectFileName: string): Boolean;
  public
    class function GetPlatform: string; virtual;
    constructor Create(const ABinDirectory: string; ALongPathBug: Boolean; ADCCVersion: Single;
      ACompilerSettingsFormat: THsJclCompilerSettingsFormat; ASupportsNoConfig, ASupportsPlatform: Boolean;
      const ADCPSearchPath, ALibrarySearchPath, ALibraryDebugSearchPath, ACppSearchPath: string);
    function GetExeName: string; override;
    function Execute(const CommandLine: string): Boolean; override;
    function MakePackage(const PackageName, BPLPath, DCPPath: string;
      ExtraOptions: string = ''; ADebug: Boolean = False): Boolean;
    function MakeProject(const ProjectName, OutputDir, DcpSearchPath: string;
      ExtraOptions: string = ''; ADebug: Boolean = False): Boolean;
    procedure SetDefaultOptions(ADebug: Boolean); virtual;
    function AddBDSProjOptions(const ProjectFileName: string; var ProjectOptions: TProjectOptions): Boolean;
    function AddDOFOptions(const ProjectFileName: string; var ProjectOptions: TProjectOptions): Boolean;
    function AddDProjOptions(const ProjectFileName: string; var ProjectOptions: TProjectOptions): Boolean;
    property CppSearchPath: string read FCppSearchPath;
    property DCPSearchPath: string read FDCPSearchPath;
    property LibrarySearchPath: string read FLibrarySearchPath;
    property LibraryDebugSearchPath: string read FLibraryDebugSearchPath;
    property OnEnvironmentVariables: THsJclStringsGetterFunction read FOnEnvironmentVariables write FOnEnvironmentVariables;
    property SupportsNoConfig: Boolean read FSupportsNoConfig;
    property SupportsPlatform: Boolean read FSupportsPlatform;
    property DCCVersion: Single read FDCCVersion;
  end;

  THsJclDCC64 = class(THsJclDCC32)
  public
    class function GetPlatform: string; override;
    function GetExeName: string; override;
  end;

  THsJclDCCOSX32 = class(THsJclDCC32)
  public
    class function GetPlatform: string; override;
    function GetExeName: string; override;
  end;

  {$IFDEF MSWINDOWS}
  THsJclDCCIL = class(THsJclDCC32)
  private
    FMaxCLRVersion: string;
  protected
    function GetMaxCLRVersion: string;
  public
    function GetExeName: string; override;
    function MakeProject(const ProjectName, OutputDir, ExtraOptions: string;
      ADebug: Boolean = False): Boolean; reintroduce;
    procedure SetDefaultOptions(ADebug: Boolean); override;
    property MaxCLRVersion: string read GetMaxCLRVersion;
  end;
  {$ENDIF MSWINDOWS}

  THsJclBpr2Mak = class(THsJclBorlandCommandLineTool)
  public
    function GetExeName: string; override;
  end;

  THsJclBorlandMake = class(THsJclBorlandCommandLineTool)
  public
    function GetExeName: string; override;
  end;

const
  AsmExeName                = 'tasm32.exe';
  BCC32ExeName              = 'bcc32.exe';
  BCC64ExeName              = 'bcc64.exe';
  DCC32ExeName              = 'dcc32.exe';
  DCC64ExeName              = 'dcc64.exe';
  DCCOSX32ExeName           = 'dccosx.exe';
  DCCILExeName              = 'dccil.exe';
  Bpr2MakExeName            = 'bpr2mak.exe';
  MakeExeName               = 'make.exe';

  BDSPlatformWin32        = 'Win32';
  BDSPlatformWin64        = 'Win64';
  BDSPlatformOSX32        = 'OSX32';

  BinaryExtensionPackage       = '.bpl';
  BinaryExtensionLibrary       = '.dll';
  BinaryExtensionExecutable    = '.exe';
  SourceExtensionDelphiPackage = '.dpk';
  SourceExtensionBCBPackage    = '.bpk';
  SourceExtensionDelphiProject = '.dpr';
  SourceExtensionBCBProject    = '.bpr';
  SourceExtensionDProject      = '.dproj';
  SourceExtensionBDSProject    = '.bdsproj';
  SourceExtensionDOFProject    = '.dof';
  SourceExtensionConfiguration = '.cfg';

function BinaryFileName(const OutputPath, ProjectFileName: string): string;

function IsDelphiPackage(const FileName: string): Boolean;
function IsDelphiProject(const FileName: string): Boolean;
function IsBCBPackage(const FileName: string): Boolean;
function IsBCBProject(const FileName: string): Boolean;

procedure GetDPRFileInfo(const DPRFileName: string; out BinaryExtension: string;
  const LibSuffix: PString = nil);
procedure GetBPRFileInfo(const BPRFileName: string; out BinaryFileName: string;
  const Description: PString = nil);
procedure GetDPKFileInfo(const DPKFileName: string; out RunOnly: Boolean;
  const LibSuffix: PString = nil; const Description: PString = nil);
procedure GetBPKFileInfo(const BPKFileName: string; out RunOnly: Boolean;
  const BinaryFileName: PString = nil; const Description: PString = nil);

implementation

uses
  SysConst, HsJclSynch, HsJclMsBuild;{,
  JclFileUtils,
  JclDevToolsResources,
  JclIDEUtils,
  JclAnsiStrings,
  JclWideStrings,
  JclStrings,
  JclSysInfo,
  JclSimpleXml,
  JclMsBuild;}

const
  // DOF options
  DOFDirectoriesSection = 'Directories';
  DOFUnitOutputDirKey   = 'UnitOutputDir';
  DOFSearchPathName     = 'SearchPath';
  DOFConditionals       = 'Conditionals';
  DOFLinkerSection      = 'Linker';
  DOFPackagesKey        = 'Packages';
  DOFCompilerSection    = 'Compiler';
  DOFPackageNoLinkKey   = 'PackageNoLink';
  // injection of new compiler options to workaround L1496 internal error of Delphi 5 and C++Builder 5
  // adding -B switch to the compiler command line forces units to be built
  DOFAdditionalSection  = 'Additional';
  DOFOptionsKey         = 'Options';

  // BDSProj options
  BDSProjPersonalityInfoNodeName = 'PersonalityInfo';
  BDSProjOptionNodeName = 'Option';
  BDSProjNameProperty = 'Name';
  BDSProjPersonalityValue = 'Personality';
  BDSProjUnitOutputDirValue = 'UnitOutputDir';
  BDSProjSearchPathValue = 'SearchPath';
  BDSProjPackagesValue = 'Packages';
  BDSProjConditionalsValue = 'Conditionals';
  BDSProjUsePackagesValue = 'UsePackages';
  BDSProjDirectoriesNodeName = 'Directories';

  // DProj options
  DProjPersonalityNodeName = 'Borland.Personality';
  DProjDelphiPersonalityValue = 'Delphi.Personality';
  DProjDelphiDotNetPersonalityValue = 'DelphiDotNet.Personality';
  DProjUsePackageNodeName = 'DCC_UsePackage';
  DProjDcuOutputDirNodeName = 'DCC_DcuOutput';
  DProjUnitSearchPathNodeName = 'DCC_UnitSearchPath';
  DProjDefineNodeName = 'DCC_Define';
  DProjNamespaceNodeName = 'DCC_Namespace';

  DelphiLibSuffixOption   = '{$LIBSUFFIX ''';
  DelphiDescriptionOption = '{$DESCRIPTION ''';
  DelphiRunOnlyOption     = '{$RUNONLY}';
  DelphiBinaryExtOption   = '{$E ';
  BCBLFlagsOption     = '<LFLAGS ';
  BCBDSwitchOption    = '-D';
  BCBGprSwitchOption  = '-Gpr';
  BCBProjectOption    = '<PROJECT ';

Type
  THsJclProcessPriority = (ppIdle, ppNormal, ppHigh, ppRealTime, ppBelowNormal, ppAboveNormal);

Const
  BELOW_NORMAL_PRIORITY_CLASS = $00004000;
  ABOVE_NORMAL_PRIORITY_CLASS = $00008000;
  
  HsProcessPriorities: array [THsJclProcessPriority] of DWORD =
    (IDLE_PRIORITY_CLASS, NORMAL_PRIORITY_CLASS, HIGH_PRIORITY_CLASS, REALTIME_PRIORITY_CLASS,
     BELOW_NORMAL_PRIORITY_CLASS, ABOVE_NORMAL_PRIORITY_CLASS);

ResourceString
  RsEUnknownProjectExtension    = '%s not a known project extension';
  RsECmdLineToolOutputInvalid   = '%s: Output invalid, when OutputCallback assigned.';

Type
  THsStartupVisibility = (svHide, svShow, svNotSet);
  THsJclExecuteCmdProcessOptionBeforeResumeEvent = procedure(const ProcessInfo: TProcessInformation) of object;

  TBuffer = array [0..255] of AnsiChar;

  TPipeInfo = record
    PipeRead, PipeWrite: THandle;
    Buffer: TBuffer;
    Line: string;
    TextHandler: TTextHandler;
    RawOutput: Boolean;
    AutoConvertOem: Boolean;
    Event: THsJclEvent;
  end;
  PPipeInfo = ^TPipeInfo;
    
  THsJclExecuteCmdProcessOptions = {record} class(TObject)
  private
    FCommandLine: string;
    FAbortPtr: PBoolean;
    FAbortEvent: THsJclEvent;

    FOutputLineCallback: TTextHandler;
    FRawOutput: Boolean;
    FMergeError: Boolean;
    FErrorLineCallback: TTextHandler;
    FRawError: Boolean;
    FProcessPriority: THsJclProcessPriority;

    FAutoConvertOem: Boolean;
    {$IFDEF MSWINDOWS}
    FCreateProcessFlags: DWORD;
    FStartupVisibility: THsStartupVisibility;
    FBeforeResume: THsJclExecuteCmdProcessOptionBeforeResumeEvent;
    {$ENDIF MSWINDOWS}

    FExitCode: Cardinal;
    FOutput: string;
    FError: string;
  public
    // in:
    property CommandLine: string read FCommandLine write FCommandLine;
    property AbortPtr: PBoolean read FAbortPtr write FAbortPtr;
    property AbortEvent: THsJclEvent read FAbortEvent write FAbortEvent;

    property OutputLineCallback: TTextHandler read FOutputLineCallback write FOutputLineCallback;
    property RawOutput: Boolean read FRawOutput write FRawOutput default False;
    property MergeError: Boolean read FMergeError write FMergeError default False;
    property ErrorLineCallback: TTextHandler read FErrorLineCallback write FErrorLineCallback;
    property RawError: Boolean read FRawError write FRawError default False;
    property ProcessPriority: THsJclProcessPriority read FProcessPriority write FProcessPriority default ppNormal;

    // AutoConvertOem assumes the process outputs OEM encoded strings and converts them to the
    // default string encoding.
    property AutoConvertOem: Boolean read FAutoConvertOem write FAutoConvertOem default True;
    {$IFDEF MSWINDOWS}
    property CreateProcessFlags: DWORD read FCreateProcessFlags write FCreateProcessFlags;
    property StartupVisibility: THsStartupVisibility read FStartupVisibility write FStartupVisibility;
    property BeforeResume: THsJclExecuteCmdProcessOptionBeforeResumeEvent read FBeforeResume write FBeforeResume;
    {$ENDIF MSWINDOWS}

    // out:
    property ExitCode: Cardinal read FExitCode;
    property Output: string read FOutput;
    property Error: string read FError;

  public
    constructor Create(const ACommandLine: string);

  end;

constructor THsJclExecuteCmdProcessOptions.Create(const ACommandLine: string);
begin
  inherited Create;
  FCommandLine := ACommandLine;
  FAutoConvertOem := True;
  FProcessPriority := ppNormal;
end;
  
function StrTrimQuotes(const S: string): string;
var
  First, Last: Char;
  L: Integer;
begin
  L := Length(S);
  if L > 1 then
  begin
    First := S[1];
    Last := S[L];
    if (First = Last) and ((First = '''') or (First = '"')) then
      Result := Copy(S, 2, L - 2)
    else
      Result := S;
  end
  else
    Result := S;
end;

procedure StrToStrings(S, Sep: AnsiString; const List: TStrings; const AllowEmptyString: Boolean = True);
var
  I, L: Integer;
  Left: AnsiString;
begin
  Assert(List <> nil);
  List.BeginUpdate;
  try
    List.Clear;
    L := Length(Sep);
    I := Pos(Sep, S);

    while I > 0 do
    begin
      Left := Copy(S, 1, I - 1);
      if (Left <> '') or AllowEmptyString then
        List.Add(Left);
      Delete(S, 1, I + L - 1);
      I := Pos(Sep, S);
    end;

    if (S <> '') or AllowEmptyString then
      List.Add(S);  // Ignore empty strings at the end (only if AllowEmptyString = False).
      
  finally
    List.EndUpdate;
  end;
end;

function StringsToStr(const List: TStrings; const Sep: AnsiString;
  const AllowEmptyString: Boolean = True): AnsiString;
var
  I, L: Integer;
begin
  Result := '';
  for I := 0 to List.Count - 1 do
  begin
    if (List[I] <> '') or AllowEmptyString then
    begin
      // don't combine these into one addition, somehow it hurts performance
      Result := Result + List[I];
      Result := Result + Sep;
    end;
  end;

  // remove terminating separator
  if List.Count <> 0 then
  begin
    L := Length(Sep);
    Delete(Result, Length(Result) - L + 1, L);
  end;
end;

function PathGetShortName(const Path: string): string;
var
  Required: Integer;
begin
  Result := Path;
  Required := GetShortPathName(PChar(Path), nil, 0);
  if Required <> 0 then
  begin
    SetLength(Result, Required);
    Required := GetShortPathName(PChar(Path), PChar(Result), Required);
    if (Required <> 0) and (Required = Length(Result) - 1) then
      SetLength(Result, Required)
    else
      Result := Path;
  end;
end;

function PathRemoveSeparator(const Path: string): string;
var
  L: Integer;
begin
  L := Length(Path);
  if (L <> 0) and (Path[L] = '\') then
    Result := Copy(Path, 1, L - 1)
  else
    Result := Path;
end;

procedure ResetMemory(out P; Size: Longint);
begin
  if Size > 0 then
  begin
    Byte(P) := 0;
    FillChar(P, Size, 0);
  end;
end;

var
  AsyncPipeCounter: Integer;

// CreateAsyncPipe creates a pipe that uses overlapped reading.
function CreateAsyncPipe(var hReadPipe, hWritePipe: THandle;
  lpPipeAttributes: PSecurityAttributes; nSize: DWORD): BOOL;
var
  PipeName: string;
  Error: DWORD;
  PipeReadHandle, PipeWriteHandle: THandle;
begin
  Result := False;

  if (@hReadPipe = nil) or (@hWritePipe = nil) then
  begin
    SetLastError(ERROR_INVALID_PARAMETER);
    Exit;
  end;

  if nSize = 0 then
    nSize := 4096;

  InterlockedIncrement(AsyncPipeCounter);
  // In some (not so) rare instances there is a race condition
  // where the counter is the same for two threads at the same
  // time. This makes the CreateNamedPipe call below fail
  // because of the limit set to 1 in the call.
  // So, to be sure this call succeeds, we put both the process
  // and thread id in the name of the pipe.
  // This was found to happen while simply starting 7 instances
  // of the same exe file in parallel.
  PipeName := Format('\\.\Pipe\AsyncAnonPipe.%.8x.%.8x.%.8x', [GetCurrentProcessId, GetCurrentThreadId, AsyncPipeCounter]);

  PipeReadHandle := CreateNamedPipe(PChar(PipeName), PIPE_ACCESS_INBOUND or FILE_FLAG_OVERLAPPED,
      PIPE_TYPE_BYTE or PIPE_WAIT, 1, nSize, nSize, 120 * 1000, lpPipeAttributes);
  if PipeReadHandle = INVALID_HANDLE_VALUE then
    Exit;

  PipeWriteHandle := CreateFile(PChar(PipeName), GENERIC_WRITE, 0, lpPipeAttributes, OPEN_EXISTING,
      FILE_ATTRIBUTE_NORMAL {or FILE_FLAG_OVERLAPPED}, 0);
  if PipeWriteHandle = INVALID_HANDLE_VALUE then
  begin
    Error := GetLastError;
    CloseHandle(PipeReadHandle);
    SetLastError(Error);
    Exit;
  end;

  hReadPipe := PipeReadHandle;
  hWritePipe := PipeWriteHandle;

  Result := True;
end;

procedure InternalExecuteReadPipe(var PipeInfo: TPipeInfo; var Overlapped: TOverlapped);
var
  NullDWORD: ^DWORD; // XE4 broke PDWORD
  Res: DWORD;
begin
  NullDWORD := nil;
  if not ReadFile(PipeInfo.PipeRead, PipeInfo.Buffer[0], 255, NullDWORD^, @Overlapped) then
  begin
    Res := GetLastError;
    case Res of
      ERROR_BROKEN_PIPE:
        begin
          CloseHandle(PipeInfo.PipeRead);
          PipeInfo.PipeRead := 0;
        end;
      ERROR_IO_PENDING: ;
      
      else
        RaiseLastOSError(Res);
    end;
  end;
end;

procedure InternalExecuteProcessLine(const PipeInfo: TPipeInfo; LineEnd: Integer);
begin
  if PipeInfo.RawOutput or (PipeInfo.Line[LineEnd] <> #$D) then
  begin
    while (LineEnd > 0) and (PipeInfo.Line[LineEnd] In [#$A, #$D]) do
      Dec(LineEnd);
    PipeInfo.TextHandler(Copy(PipeInfo.Line, 1, LineEnd));
  end;
end;

procedure InternalExecuteProcessBuffer(var PipeInfo: TPipeInfo; PipeBytesRead: Cardinal);
var
  CR, LF: Integer;
  {$IFDEF MSWINDOWS}
  LineLen, Len: Integer;
  {$ENDIF MSWINDOWS}
  S: AnsiString;
begin
  {$IFDEF MSWINDOWS}
  if PipeInfo.AutoConvertOem then
  begin
    {$IFDEF UNICODE}
    Len := MultiByteToWideChar(CP_OEMCP, 0, PipeInfo.Buffer, PipeBytesRead, nil, 0);
    LineLen := Length(PipeInfo.Line);
    // Convert directly into the PipeInfo.Line string
    SetLength(PipeInfo.Line, LineLen + Len);
    MultiByteToWideChar(CP_OEMCP, 0, PipeInfo.Buffer, PipeBytesRead, PChar(PipeInfo.Line) + LineLen, Len);
    {$ELSE}
    Len := PipeBytesRead;
    LineLen := Length(PipeInfo.Line);
    // Convert directly into the PipeInfo.Line string
    SetLength(PipeInfo.Line, LineLen + Len);
    OemToAnsiBuff(PipeInfo.Buffer, PAnsiChar(PipeInfo.Line) + LineLen, PipeBytesRead);
    {$ENDIF UNICODE}
  end
  else
  {$ENDIF MSWINDOWS}
  begin
    SetString(S, PipeInfo.Buffer, PipeBytesRead); // interpret as ANSI
    {$IFDEF UNICODE}
    PipeInfo.Line := PipeInfo.Line + string(S); // ANSI => UNICODE
    {$ELSE}
    PipeInfo.Line := PipeInfo.Line + S;
    {$ENDIF UNICODE}
  end;
  if Assigned(PipeInfo.TextHandler) then
    repeat
      CR := Pos(#$D, PipeInfo.Line);
      if CR = Length(PipeInfo.Line) then
        CR := 0;        // line feed at CR + 1 might be missing
      LF := Pos(#$A, PipeInfo.Line);
      if (CR > 0) and ((LF > CR + 1) or (LF = 0)) then
        LF := CR;       // accept CR as line end
      if LF > 0 then
      begin
        InternalExecuteProcessLine(PipeInfo, LF);
        Delete(PipeInfo.Line, 1, LF);
      end;
    until LF = 0;
end;

procedure InternalExecuteHandlePipeEvent(var PipeInfo: TPipeInfo; var Overlapped: TOverlapped);
var
  PipeBytesRead: DWORD;
begin
  if GetOverlappedResult(PipeInfo.PipeRead, Overlapped, PipeBytesRead, False) then
  begin
    InternalExecuteProcessBuffer(PipeInfo, PipeBytesRead);
    // automatically launch the next read
    InternalExecuteReadPipe(PipeInfo, Overlapped);
  end
  else
  if GetLastError = ERROR_BROKEN_PIPE then
  begin
    CloseHandle(PipeInfo.PipeRead);
    PipeInfo.PipeRead := 0;
  end
  else
    RaiseLastOSError;
end;

procedure InternalExecuteFlushPipe(var PipeInfo: TPipeInfo; var Overlapped: TOverlapped);
var
  PipeBytesRead: DWORD;
begin
  CancelIo(PipeInfo.PipeRead);
  GetOverlappedResult(PipeInfo.PipeRead, Overlapped, PipeBytesRead, True);
  if PipeBytesRead > 0 then
    InternalExecuteProcessBuffer(PipeInfo, PipeBytesRead);
  while PeekNamedPipe(PipeInfo.PipeRead, nil, 0, nil, @PipeBytesRead, nil) and (PipeBytesRead > 0) do
  begin
    if PipeBytesRead > 255 then
      PipeBytesRead := 255;
    if not ReadFile(PipeInfo.PipeRead, PipeInfo.Buffer[0], PipeBytesRead, PipeBytesRead, nil) then
      RaiseLastOSError;
    InternalExecuteProcessBuffer(PipeInfo, PipeBytesRead);
  end;
end;

function ExecuteCmdProcess(Options: THsJclExecuteCmdProcessOptions): Boolean;
var
  OutPipeInfo, ErrorPipeInfo: TPipeInfo;
  Index: Cardinal;
const
  StartupVisibilityFlags: array[THsStartupVisibility] of DWORD = (SW_HIDE, SW_SHOW, SW_SHOWDEFAULT);
var
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  SecurityAttr: TSecurityAttributes;
  OutOverlapped, ErrorOverlapped: TOverlapped;
  ProcessEvent: THsJclDispatcherObject;
  WaitEvents: array of THsJclDispatcherObject;
  InternalAbort: Boolean;
  LastError: DWORD;
  CommandLine: string;
  AbortPtr: PBoolean;
  Flags: DWORD;
begin
  Result := False;

  // hack to pass a null reference to the parameter lpNumberOfBytesRead of ReadFile
  Options.FExitCode := $FFFFFFFF;

  SecurityAttr.nLength := SizeOf(SecurityAttr);
  SecurityAttr.lpSecurityDescriptor := nil;
  SecurityAttr.bInheritHandle := True;

  ResetMemory(OutPipeInfo, SizeOf(OutPipeInfo));
  OutPipeInfo.TextHandler := Options.OutputLineCallback;
  OutPipeInfo.RawOutput := Options.RawOutput;
  OutPipeInfo.AutoConvertOem := Options.AutoConvertOem;
  if not CreateAsyncPipe(OutPipeInfo.PipeRead, OutPipeInfo.PipeWrite, @SecurityAttr, 0) then
  begin
    Options.FExitCode := GetLastError;
    Exit;
  end;
  OutPipeInfo.Event := THsJclEvent.Create(@SecurityAttr, False {automatic reset}, False {not flagged}, '' {anonymous});
  ResetMemory(ErrorPipeInfo, SizeOf(ErrorPipeInfo));
  if not Options.MergeError then
  begin
    ErrorPipeInfo.TextHandler := Options.ErrorLineCallback;
    ErrorPipeInfo.RawOutput := Options.RawError;
    ErrorPipeInfo.AutoConvertOem := Options.AutoConvertOem;
    if not CreateAsyncPipe(ErrorPipeInfo.PipeRead, ErrorPipeInfo.PipeWrite, @SecurityAttr, 0) then
    begin
      Options.FExitCode := GetLastError;
      CloseHandle(OutPipeInfo.PipeWrite);
      CloseHandle(OutPipeInfo.PipeRead);
      OutPipeInfo.Event.Free;
      Exit;
    end;
    ErrorPipeInfo.Event := THsJclEvent.Create(@SecurityAttr, False {automatic reset}, False {not flagged}, '' {anonymous});
  end;

  ResetMemory(StartupInfo, SizeOf(TStartupInfo));
  StartupInfo.cb := SizeOf(TStartupInfo);
  StartupInfo.dwFlags := STARTF_USESTDHANDLES;
  if Options.StartupVisibility <> svNotSet then
  begin
    StartupInfo.dwFlags := StartupInfo.dwFlags or STARTF_USESHOWWINDOW;
    StartupInfo.wShowWindow := StartupVisibilityFlags[Options.StartupVisibility];
  end;
  StartupInfo.hStdInput := GetStdHandle(STD_INPUT_HANDLE);
  StartupInfo.hStdOutput := OutPipeInfo.PipeWrite;
  if Options.MergeError then
    StartupInfo.hStdError := OutPipeInfo.PipeWrite
  else
    StartupInfo.hStdError := ErrorPipeInfo.PipeWrite;
  CommandLine := Options.CommandLine;
  UniqueString(CommandLine); // CommandLine must be in a writable memory block
  ResetMemory(ProcessInfo, SizeOf(ProcessInfo));
  ProcessEvent := nil;
  try
    Flags := Options.CreateProcessFlags and not (NORMAL_PRIORITY_CLASS or IDLE_PRIORITY_CLASS or
                                                 HIGH_PRIORITY_CLASS or REALTIME_PRIORITY_CLASS);
    Flags := Flags or HsProcessPriorities[Options.ProcessPriority];
    if Assigned(Options.BeforeResume) then
      Flags := Flags or CREATE_SUSPENDED;

    if CreateProcess(nil, PChar(CommandLine), nil, nil, True, Flags,
      nil, nil, StartupInfo, ProcessInfo) then
    begin
      Result := True;
      try
        try
          if Assigned(Options.BeforeResume) then
            Options.BeforeResume(ProcessInfo);
        finally
          if Flags and CREATE_SUSPENDED <> 0 then // CREATE_SUSPENDED may also have come from CreateProcessFlags
            ResumeThread(ProcessInfo.hThread);
        end;

        // init out and error events
        CloseHandle(OutPipeInfo.PipeWrite);
        OutPipeInfo.PipeWrite := 0;
        if not Options.MergeError then
        begin
          CloseHandle(ErrorPipeInfo.PipeWrite);
          ErrorPipeInfo.PipeWrite := 0;
        end;
        InternalAbort := False;
        AbortPtr := Options.AbortPtr;
        if AbortPtr <> nil then
          AbortPtr^ := {$IFDEF FPC}Byte({$ENDIF}False{$IFDEF FPC}){$ENDIF}
        else
          AbortPtr := @InternalAbort;
        // init the array of events to wait for
        ProcessEvent := THsJclDispatcherObject.Attach(ProcessInfo.hProcess);
        SetLength(WaitEvents, 2);
        // add the process first
        WaitEvents[0] := ProcessEvent;
        // add the output event
        WaitEvents[1] := OutPipeInfo.Event;
        // add the error event
        if not Options.MergeError then
        begin
          SetLength(WaitEvents, 3);
          WaitEvents[2] := ErrorPipeInfo.Event;
        end;
        // add the abort event if any
        if Options.AbortEvent <> nil then
        begin
          Options.AbortEvent.ResetEvent;
          Index := Length(WaitEvents);
          SetLength(WaitEvents, Index + 1);
          WaitEvents[Index] := Options.AbortEvent;
        end;
        // init the asynchronous reads
        ResetMemory(OutOverlapped, SizeOf(OutOverlapped));
        OutOverlapped.hEvent := OutPipeInfo.Event.Handle;
        InternalExecuteReadPipe(OutPipeInfo, OutOverlapped);
        if not Options.MergeError then
        begin
          ResetMemory(ErrorOverlapped, SizeOf(ErrorOverlapped));
          ErrorOverlapped.hEvent := ErrorPipeInfo.Event.Handle;
          InternalExecuteReadPipe(ErrorPipeInfo, ErrorOverlapped);
        end;
        // event based loop
        while not {$IFDEF FPC}Boolean({$ENDIF}AbortPtr^{$IFDEF FPC}){$ENDIF} do
        begin
          Index := WaitAlertableForMultipleObjects(WaitEvents, False, INFINITE);
          if Index = WAIT_OBJECT_0 then
            // the subprocess has ended
            Break
          else
          if Index = (WAIT_OBJECT_0 + 1) then
          begin
            // event on output
            InternalExecuteHandlePipeEvent(OutPipeInfo, OutOverlapped);
          end
          else
          if (Index = (WAIT_OBJECT_0 + 2)) and not Options.MergeError then
          begin
            // event on error
            InternalExecuteHandlePipeEvent(ErrorPipeInfo, ErrorOverlapped);
          end
          else
          if ((Index = (WAIT_OBJECT_0 + 2)) and Options.MergeError) or
             ((Index = (WAIT_OBJECT_0 + 3)) and not Options.MergeError) then
            // event on abort
            AbortPtr^ := {$IFDEF FPC}Byte({$ENDIF}True{$IFDEF FPC}){$ENDIF}
          else
            {$IFDEF DELPHI11_UP}
            RaiseLastOSError(Index);
            {$ELSE}
            RaiseLastOSError;
            {$ENDIF DELPHI11_UP}
        end;
        if {$IFDEF FPC}Boolean({$ENDIF}AbortPtr^{$IFDEF FPC}){$ENDIF} then
          TerminateProcess(ProcessEvent.Handle, Cardinal(ERROR_CANCELLED));
        if (ProcessEvent.WaitForever = {$IFDEF RTL280_UP}TJclWaitResult.{$ENDIF RTL280_UP}wrSignaled) and not GetExitCodeProcess(ProcessEvent.Handle, Options.FExitCode) then
          Options.FExitCode := $FFFFFFFF;
        CloseHandle(ProcessInfo.hThread);
        ProcessInfo.hThread := 0;
        if OutPipeInfo.PipeRead <> 0 then
          // read data remaining in output pipe
          InternalExecuteFlushPipe(OutPipeinfo, OutOverlapped);
        if not Options.MergeError and (ErrorPipeInfo.PipeRead <> 0) then
          // read data remaining in error pipe
          InternalExecuteFlushPipe(ErrorPipeInfo, ErrorOverlapped);
      except
        // always terminate process in case of an exception.
        // This is especially useful when an exception occurred in one of
        // the texthandler but only do it if the process actually started,
        // this prevents eating up the last error value by calling those
        // three functions with an invalid handle
        // Note that we don't do it in the finally block because these
        // calls would also then eat up the last error value which we tried
        // to avoid in the first place
        if ProcessInfo.hProcess <> 0 then
        begin
          TerminateProcess(ProcessInfo.hProcess, Cardinal(ERROR_CANCELLED));
          WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
          GetExitCodeProcess(ProcessInfo.hProcess, Options.FExitCode);
        end;

        raise;
      end;
    end;
  finally
    LastError := GetLastError;
    try
      if OutPipeInfo.PipeRead <> 0 then
        CloseHandle(OutPipeInfo.PipeRead);
      if OutPipeInfo.PipeWrite <> 0 then
        CloseHandle(OutPipeInfo.PipeWrite);
      if ErrorPipeInfo.PipeRead <> 0 then
        CloseHandle(ErrorPipeInfo.PipeRead);
      if ErrorPipeInfo.PipeWrite <> 0 then
        CloseHandle(ErrorPipeInfo.PipeWrite);
      if ProcessInfo.hThread <> 0 then
        CloseHandle(ProcessInfo.hThread);

      if Assigned(ProcessEvent) then
        ProcessEvent.Free // this calls CloseHandle(ProcessInfo.hProcess)
      else if ProcessInfo.hProcess <> 0 then
        CloseHandle(ProcessInfo.hProcess);
      OutPipeInfo.Event.Free;
      ErrorPipeInfo.Event.Free;
    finally
      SetLastError(LastError);
    end;
  end;
End;

(******************************************************************************)

function AnsiStartsText(const SubStr, S: string): Boolean;
begin
  if Length(SubStr) <= Length(S) then
    Result := AnsiStrLIComp(PChar(S), PChar(SubStr), Length(SubStr)) = 0
  else
    Result := False;
end;

procedure GetDPRFileInfo(const DPRFileName: string; out BinaryExtension: string;
  const LibSuffix: PString = nil);
var
  Index: Integer;
  S: string;
  DPRFile: TStrings;
const
  ProgramText = 'program';
  LibraryText = 'library';
begin
  DPRFile := TStringList.Create;
  try
    DPRFile.LoadFromFile(DPRFileName);

    if Assigned(LibSuffix) then
      LibSuffix^ := '';

    BinaryExtension := '';

    for Index := 0 to DPRFile.Count - 1 do
    begin
      S := TrimRight(DPRFile.Strings[Index]);
      if AnsiStartsText(ProgramText, S) and (BinaryExtension = '') then
        BinaryExtension := BinaryExtensionExecutable;
      if AnsiStartsText(LibraryText, S) and (BinaryExtension = '') then
        BinaryExtension := BinaryExtensionLibrary;
      if AnsiStartsText(DelphiBinaryExtOption, S) then
        BinaryExtension :=
          StrTrimQuotes(Copy(S, Length(DelphiBinaryExtOption), Length(S) - Length(DelphiBinaryExtOption)));
      if Assigned(LibSuffix) and AnsiStartsText(DelphiLibSuffixOption, S) then
        LibSuffix^ :=
          StrTrimQuotes(Copy(S, Length(DelphiLibSuffixOption), Length(S) - Length(DelphiLibSuffixOption)));
    end;
  finally
    DPRFile.Free;
  end;
end;

procedure GetBPRFileInfo(const BPRFileName: string; out BinaryFileName: string;
  const Description: PString = nil);
var
  I, J: Integer;
  S, SubS1, SubS2, SubS3: string;
  BPKFile: TStringList;
  LProjectPos, BinaryFileNamePos, EndFileNamePos, LFlagsPos, DSwitchPos: Integer;
  SemiColonPos, AmpPos: Integer;
begin
  BPKFile := TStringList.Create;
  try
    BPKFile.LoadFromFile(BPRFileName);
    BinaryFileName := '';
    if Assigned(Description) then
      Description^ := '';
    for I := 0 to BPKFile.Count - 1 do
    begin
      S := BPKFile[I];

      LProjectPos := Pos(BCBProjectOption, S);
      if LProjectPos > 0 then
      begin
        SubS1 := Copy(S, LProjectPos, Length(S));
        J := 1;
        while (Pos('>', SubS1) = 0) and ((I + J) < BPKFile.Count) do
        begin
          SubS1 := SubS1 + BPKFile[I + J];
          Inc(J);
        end;

        BinaryFileNamePos := Pos('"', SubS1);
        if BinaryFileNamePos > 0 then
        begin
          SubS2 := Copy(SubS1, BinaryFileNamePos + 1, Length(SubS1) - BinaryFileNamePos);
          EndFileNamePos := Pos('"', SubS2);

          if EndFileNamePos > 0 then
            BinaryFileName := Copy(SubS2, 1, EndFileNamePos - 1);
        end;
      end;

      LFlagsPos := Pos(BCBLFlagsOption, S);
      if LFlagsPos > 0 then
      begin
        SubS1 := Copy(S, LFlagsPos, Length(S));
        J := 1;
        while (Pos('>', SubS1) = 0) and ((I + J) < BPKFile.Count) do
        begin
          SubS1 := SubS1 + BPKFile[I + J];
          Inc(J);
        end;
        DSwitchPos := Pos(BCBDSwitchOption, SubS1);
        if DSwitchPos > 0 then
        begin
          SubS2 := Copy(SubS1, DSwitchPos, Length(SubS1));
          SemiColonPos := Pos(';', SubS2);
          if SemiColonPos > 0 then
          begin
            SubS3 := Copy(SubS2, SemiColonPos + 1, Length(SubS2));
            AmpPos := Pos('&', SubS3);
            if (Description <> nil) and (AmpPos > 0) then
              Description^ := Copy(SubS3, 1, AmpPos - 1);
          end;
        end;
      end;
    end;
  finally
    BPKFile.Free;
  end;
end;

procedure GetDPKFileInfo(const DPKFileName: string; out RunOnly: Boolean;
  const LibSuffix: PString = nil; const Description: PString = nil);
var
  I: Integer;
  S: string;
  DPKFile: TStringList;
begin
  DPKFile := TStringList.Create;
  try
    DPKFile.LoadFromFile(DPKFileName);
    if Assigned(Description) then
      Description^ := '';
    if Assigned(LibSuffix) then
      LibSuffix^ := '';
    RunOnly := False;
    for I := 0 to DPKFile.Count - 1 do
    begin
      S := TrimRight(DPKFile.Strings[I]);
      if Assigned(Description) and (Pos(DelphiDescriptionOption, S) = 1) then
        Description^ := Copy(S, Length(DelphiDescriptionOption), Length(S) - Length(DelphiDescriptionOption))
      else
      if Assigned(LibSuffix) and (Pos(DelphiLibSuffixOption, S) = 1) then
        LibSuffix^ := StrTrimQuotes(Copy(S, Length(DelphiLibSuffixOption), Length(S) - Length(DelphiLibSuffixOption)))
      else
      if Pos(DelphiRunOnlyOption, S) = 1 then
        RunOnly := True;
    end;
  finally
    DPKFile.Free;
  end;
end;

procedure GetBPKFileInfo(const BPKFileName: string; out RunOnly: Boolean;
  const BinaryFileName: PString = nil; const Description: PString = nil);
var
  I, J: Integer;
  S, SubS1, SubS2, SubS3: string;
  BPKFile: TStringList;
  LFlagsPos, DSwitchPos, SemiColonPos, AmpPos, GprPos: Integer;
  LProjectPos, BinaryFileNamePos, EndFileNamePos: Integer;
begin
  BPKFile := TStringList.Create;
  try
    BPKFile.LoadFromFile(BPKFileName);
    if Assigned(Description) then
      Description^ := '';
    if Assigned(BinaryFileName) then
      BinaryFileName^ := '';
    RunOnly := False;
    for I := 0 to BPKFile.Count - 1 do
    begin
      S := BPKFile[I];

      LProjectPos := Pos(BCBProjectOption, S);
      if Assigned(BinaryFileName) and (LProjectPos > 0) then
      begin
        SubS1 := Copy(S, LProjectPos, Length(S));
        J := 1;
        while (Pos('>', SubS1) = 0) and ((I + J) < BPKFile.Count) do
        begin
          SubS1 := SubS1 + BPKFile[I + J];
          Inc(J);
        end;

        BinaryFileNamePos := Pos('"', SubS1);
        if BinaryFileNamePos > 0 then
        begin
          SubS2 := Copy(SubS1, BinaryFileNamePos + 1, Length(SubS1) - BinaryFileNamePos);
          EndFileNamePos := Pos('"', SubS2);

          if EndFileNamePos > 0 then
            BinaryFileName^ := Copy(SubS2, 1, EndFileNamePos - 1);
        end;
      end;

      LFlagsPos := Pos(BCBLFlagsOption, S);
      if LFlagsPos > 0 then
      begin
        SubS1 := Copy(S, LFlagsPos, Length(S));
        J := 1;
        while (Pos('>', SubS1) = 0) and ((I + J) < BPKFile.Count) do
        begin
          SubS1 := SubS1 + BPKFile[I + J];
          Inc(J);
        end;
        DSwitchPos := Pos(BCBDSwitchOption, SubS1);
        GprPos := Pos(BCBGprSwitchOption, SubS1);
        if DSwitchPos > 0 then
        begin
          SubS2 := Copy(SubS1, DSwitchPos, Length(SubS1));
          SemiColonPos := Pos(';', SubS2);
          if SemiColonPos > 0 then
          begin
            SubS3 := Copy(SubS2, SemiColonPos + 1, Length(SubS2));
            AmpPos := Pos('&', SubS3);
            if (Description <> nil) and (AmpPos > 0) then
              Description^ := Copy(SubS3, 1, AmpPos - 1);
          end;
        end;
        if GprPos > 0 then
          RunOnly := True;
      end;
    end;
  finally
    BPKFile.Free;
  end;
end;

function BinaryFileName(const OutputPath, ProjectFileName: string): string;
var
  ProjectExtension, LibSuffix, BinaryExtension: string;
  RunOnly: Boolean;
begin
  ProjectExtension := ExtractFileExt(ProjectFileName);
  if SameText(ProjectExtension, SourceExtensionDelphiPackage) then
  begin
    GetDPKFileInfo(ProjectFileName, RunOnly, @LibSuffix);
    Result := ChangeFileExt(ExtractFileName(ProjectFileName), '') + LibSuffix + BinaryExtensionPackage;
  end
  else
  if SameText(ProjectExtension, SourceExtensionDelphiProject) then
  begin
    GetDPRFileInfo(ProjectFileName, BinaryExtension, @LibSuffix);
    Result := ChangeFileExt(ExtractFileName(ProjectFileName), '') + LibSuffix + BinaryExtension;
  end
  else
  if SameText(ProjectExtension, SourceExtensionBCBPackage) then
    GetBPKFileInfo(ProjectFileName, RunOnly, @Result)
  else
  if SameText(ProjectExtension, SourceExtensionBCBProject) then
    GetBPRFileInfo(ProjectFileName, Result)
  else
    raise EHsJclCompilerUtilsException.CreateResFmt(@RsEUnknownProjectExtension, [ProjectExtension]);

  Result := IncludeTrailingBackSlash(OutputPath) + Result;
end;

function IsDelphiPackage(const FileName: string): Boolean;
begin
  Result := SameText(ExtractFileExt(FileName), SourceExtensionDelphiPackage);
end;

function IsDelphiProject(const FileName: string): Boolean;
begin
  Result := SameText(ExtractFileExt(FileName), SourceExtensionDelphiProject);
end;

function IsBCBPackage(const FileName: string): Boolean;
begin
  Result := SameText(ExtractFileExt(FileName), SourceExtensionBCBPackage);
end;

function IsBCBProject(const FileName: string): Boolean;
begin
  Result := SameText(ExtractFileExt(FileName), SourceExtensionBCBProject);
end;

{$IFDEF MSWINDOWS}
type
  TFindResStartRec = record
    StartStr: WideString;
    MatchStr: WideString;
  end;
  PFindResStartRec = ^TFindResStartRec;

// helper function to check strings starting "StartStr" in current string table
function FindResStartCallBack(hModule: HMODULE; lpszType, lpszName: PChar;
  lParam: PFindResStartRec): BOOL; stdcall;
var
  ResInfo, ResHData, ResSize, ResIndex: Cardinal;
  ResData: PWord;
  StrLength: Word;
  MatchLen: Integer;
begin
  Result := True;
  MatchLen := Length(lParam^.StartStr);

  ResInfo := FindResource(hModule, lpszName, lpszType);
  if ResInfo <> 0 then
  begin
    ResHData := LoadResource(hModule, ResInfo);
    if ResHData <> 0 then
    begin
      ResData := LockResource(ResHData);
      if Assigned(ResData) then
      begin
        // string tables are a concatenation of maximum 16 prefixed-length widestrings
        ResSize := SizeofResource(hModule, ResInfo) div 2;
        ResIndex := 0;
        // iterate all concatenated strings
        while ResIndex < ResSize do
        begin
          StrLength := ResData^;
          Inc(ResData);
          Inc(ResIndex);
          if (StrLength >= MatchLen) and
             SameText(PWideChar(lParam^.StartStr), PWideChar(ResData)) Then
//            (StrLICompW(PWideChar(lParam^.StartStr), PWideChar(ResData), MatchLen) = 0) then
          begin
            // we have a match
            SetLength(lParam^.MatchStr, StrLength);
            Move(ResData^, lParam^.MatchStr[1], StrLength * SizeOf(lParam^.MatchStr[1]));
            Result := False;
            Break;
          end;
          Inc(ResData, StrLength);
          Inc(ResIndex, StrLength);
        end;
      end;
    end;
  end;
end;

// find in specified module "FileName" a resourcestring starting with StartStr
function FindResStart(const FileName: string; const StartStr: WideString): WideString;
var
  H: HMODULE;
  FindResRec: TFindResStartRec;
begin
  FindResRec.StartStr := StartStr;
  FindResRec.MatchStr := '';

  H := LoadLibraryEx(PChar(FileName), 0, LOAD_LIBRARY_AS_DATAFILE or DONT_RESOLVE_DLL_REFERENCES);
  if H <> 0 then
    try
      EnumResourceNames(H, RT_STRING, @FindResStartCallBack, LPARAM(@FindResRec));
    finally
      FreeLibrary(H);
    end;

  Result := FindResRec.MatchStr;
end;
{$ENDIF MSWINDOWS}

//=== { THsJclBorlandCommandLineTool } =========================================

constructor THsJclBorlandCommandLineTool.Create(const ABinDirectory: string; ALongPathBug: Boolean;
  ACompilerSettingsFormat: THsJclCompilerSettingsFormat);
begin
  inherited Create;
  FBinDirectory := ABinDirectory;
  FLongPathBug := ALongPathBug;
  FCompilerSettingsFormat := ACompilerSettingsFormat;
  FOptions := TStringList.Create;
end;

destructor THsJclBorlandCommandLineTool.Destroy;
begin
  FreeAndNil(FOptions);
  inherited Destroy;
end;

procedure THsJclBorlandCommandLineTool.AddPathOption(const Option, Path: string);
var
  S: string;

  // path before Delphi 2005 must be shortened
  // to avoid the 126 character limit of DCC32 (and eventually other command line tools)
  // which shows up with misleading error messages ("Fatal: System.pas not found") or
  // might even cause AVs
  procedure ConvertToShortPathNames(var Paths: string);
  var
    List: TStringList;
    I: Integer;
  begin
    {$IFDEF MSWINDOWS}
    if LongPathBug then
    begin
      List := TStringList.Create;
      try
        StrToStrings(Paths, PathSep, List);
        for I := 0 to List.Count - 1 do
          List[I] := PathGetShortName(List[I]);
        Paths := StringsToStr(List, PathSep);
      finally
        List.Free;
      end;
    end;
    {$ENDIF MSWINDOWS}
  end;

begin
  S := PathRemoveSeparator(Path);
  ConvertToShortPathNames(S);
  { TODO : If we were sure that options are always case-insensitive
           for Borland tools, we could use UpperCase(Option) below. }
  S := Format('-%s"%s"', [Option, S]);
  // avoid duplicate entries
  if Options.IndexOf(S) = -1 then
    Options.Add(S);
end;

procedure THsJclBorlandCommandLineTool.CheckOutputValid;
begin
  if Assigned(FOutputCallback) then
    raise EHsJclCompilerUtilsException.CreateResFmt(@RsECmdLineToolOutputInvalid, [GetExeName]);
end;

function THsJclBorlandCommandLineTool.Execute(const CommandLine: string): Boolean;
begin
  if Assigned(FOnBeforeExecute) then
    FOnBeforeExecute(Self);

  Result := InternalExecute(CommandLine);

  if Assigned(FOnAfterExecute) then
    FOnAfterExecute(Self);
end;

function THsJclBorlandCommandLineTool.GetExeName: string;
begin
  Result := '';
  {$IFDEF MSWINDOWS}
  raise EAbstractError.CreateResFmt(@SAbstractError, ['']); // BCB doesn't support abstract keyword
  {$ENDIF MSWINDOWS}
end;

function THsJclBorlandCommandLineTool.GetFileName: string;
begin
  Result := BinDirectory + GetExeName;
  if Pos(' ', Result) > 0 then
    Result := AnsiQuotedStr(Result, '"');
end;

function THsJclBorlandCommandLineTool.GetOptions: TStrings;
begin
  Result := FOptions;
end;

function THsJclBorlandCommandLineTool.GetOutput: string;
begin
  CheckOutputValid;
  Result := FOutput;
end;

function THsJclBorlandCommandLineTool.GetOutputCallback: TTextHandler;
begin
  Result := FOutputCallback;
end;

function THsJclBorlandCommandLineTool.InternalExecute(const CommandLine: string): Boolean;
var
  LaunchCommand: string;
  Options: THsJclExecuteCmdProcessOptions;
begin
  LaunchCommand := Format('%s %s', [FileName, CommandLine]);

  Options := THsJclExecuteCmdProcessOptions.Create(LaunchCommand);
  try
    if Assigned(FOutputCallback) then
    begin
      Options.OutputLineCallback := FOutputCallback;
      FOutputCallback(LaunchCommand);
      Result := ExecuteCmdProcess(Options) and (Options.ExitCode = 0);
    end
    else
    begin
      Result := ExecuteCmdProcess(Options) and (Options.ExitCode = 0);
      FOutput := FOutput + Options.Output;
    end;
  finally
    Options.Free;
  end;
end;

procedure THsJclBorlandCommandLineTool.SetOutputCallback(const CallbackMethod: TTextHandler);
begin
  FOutputCallback := CallbackMethod;
end;

//=== { THsJclBCC32 } ============================================================

function THsJclBCC32.GetExeName: string;
begin
  Result := BCC32ExeName;
end;

class function THsJclBCC32.GetPlatform: string;
begin
  Result := BDSPlatformWin32;
end;

//=== { THsJclBCC64 } ============================================================

function THsJclBCC64.GetExeName: string;
begin
  Result := BCC64ExeName;
end;

class function THsJclBCC64.GetPlatform: string;
begin
  Result := BDSPlatformWin64;
end;

//=== { THsJclDCC32 } ============================================================

function THsJclDCC32.AddDProjOptions(const ProjectFileName: string; var ProjectOptions: TProjectOptions): Boolean;
var
  DProjFileName, PersonalityName: string;
  MsBuildOptions: THsJclMsBuildParser;
  ProjectExtensionsNode, PersonalityNode: THsJclSimpleXMLElem;
begin
  DProjFileName := ChangeFileExt(ProjectFileName, SourceExtensionDProject);
  Result := FileExists(DProjFileName) and (CompilerSettingsFormat = csfMsBuild);
  if Result then
  begin
    MsBuildOptions := THsJclMsBuildParser.Create(DProjFileName);
    try
      MsBuildOptions.Init;
      if SupportsPlatform then
        MsBuildOptions.Properties.GlobalProperties.Values['Platform'] := GetPlatform;

      if Assigned(FOnEnvironmentVariables) then
        MsBuildOptions.Properties.EnvironmentProperties.Assign(FOnEnvironmentVariables);

      MsBuildOptions.Parse;

      PersonalityName := '';
      ProjectExtensionsNode := MsBuildOptions.ProjectExtensions;
      if Assigned(ProjectExtensionsNode) then
      begin
        PersonalityNode := ProjectExtensionsNode.Items.ItemNamed[DProjPersonalityNodeName];
        if Assigned(PersonalityNode) then
          PersonalityName := PersonalityNode.Value;
      end;
      if StrHasPrefix(PersonalityName, [DProjDelphiPersonalityValue]) or
        AnsiSameText(PersonalityName, DProjDelphiDotNetPersonalityValue) then
      begin
        ProjectOptions.DynamicPackages := MsBuildOptions.Properties.Values[DProjUsePackageNodeName];
        ProjectOptions.UsePackages := ProjectOptions.DynamicPackages <> '';
        ProjectOptions.UnitOutputDir := MsBuildOptions.Properties.Values[DProjDcuOutputDirNodeName];
        ProjectOptions.SearchPath := MsBuildOptions.Properties.Values[DProjUnitSearchPathNodeName];
        ProjectOptions.Conditionals := MsBuildOptions.Properties.Values[DProjDefineNodeName];
        ProjectOptions.Namespace := MsBuildOptions.Properties.Values[DProjNamespaceNodeName];
      end;
    finally
      MsBuildOptions.Free;
    end;
  end;
end;

function THsJclDCC32.AddBDSProjOptions(const ProjectFileName: string; var ProjectOptions: TProjectOptions): Boolean;
var
  BDSProjFileName, PersonalityName: string;
  OptionsXmlFile: THsJclSimpleXML;
  PersonalityInfoNode, OptionNode, ChildNode, PersonalityNode, DirectoriesNode: THsJclSimpleXMLElem;
  NodeIndex: Integer;
  NameProperty: THsJclSimpleXMLProp;
begin
  BDSProjFileName := ChangeFileExt(ProjectFileName, SourceExtensionBDSProject);
  Result := FileExists(BDSProjFileName);
  if Result then
  begin
    OptionsXmlFile := THsJclSimpleXML.Create;
    try
      OptionsXmlFile.LoadFromFile(BDSProjFileName);
      OptionsXmlFile.Options := OptionsXmlFile.Options - [sxoAutoCreate];
      PersonalityInfoNode := OptionsXmlFile.Root.Items.ItemNamed[BDSProjPersonalityInfoNodeName];
      PersonalityName := '';
      if Assigned(PersonalityInfoNode) then
      begin
        OptionNode := PersonalityInfoNode.Items.ItemNamed[BDSProjOptionNodeName];
        if Assigned(OptionNode) then
          for NodeIndex := 0 to OptionNode.Items.Count - 1 do
          begin
            ChildNode := OptionNode.Items.Item[NodeIndex];
            if SameText(ChildNode.Name, BDSProjOptionNodeName) then
            begin
              NameProperty := ChildNode.Properties.ItemNamed[BDSProjNameProperty];
              if Assigned(NameProperty) and SameText(NameProperty.Value, BDSProjPersonalityValue) then
              begin
                PersonalityName := ChildNode.Value;
                Break;
              end;
            end;
          end;
      end;
      if PersonalityName <> '' then
      begin
        PersonalityNode := OptionsXmlFile.Root.Items.ItemNamed[PersonalityName];
        if Assigned(PersonalityNode) then
        begin
          DirectoriesNode := PersonalityNode.Items.ItemNamed[BDSProjDirectoriesNodeName];
          if Assigned(DirectoriesNode) then
            for NodeIndex := 0 to DirectoriesNode.Items.Count - 1 do
            begin
              ChildNode := DirectoriesNode.Items.Item[NodeIndex];
              if SameText(ChildNode.Name, BDSProjDirectoriesNodeName) then
              begin
                NameProperty := ChildNode.Properties.ItemNamed[BDSProjNameProperty];
                if Assigned(NameProperty) then
                begin
                  if SameText(NameProperty.Value, BDSProjUnitOutputDirValue) then
                    ProjectOptions.UnitOutputDir := ChildNode.Value
                  else
                  if SameText(NameProperty.Value, BDSProjSearchPathValue) then
                    ProjectOptions.SearchPath := ChildNode.Value
                  else
                  if SameText(NameProperty.Value, BDSProjPackagesValue) then
                    ProjectOptions.DynamicPackages := ChildNode.Value
                  else
                  if SameText(NameProperty.Value, BDSProjConditionalsValue) then
                    ProjectOptions.Conditionals := ChildNode.Value
                  else
                  if SameText(NameProperty.Value, BDSProjUsePackagesValue) then
                    ProjectOptions.UsePackages := StrToBoolean(ChildNode.Value);
                  ProjectOptions.Namespace := '';
                end;
              end;
            end;
        end;
      end;
    finally
      OptionsXmlFile.Free;
    end;
  end;
end;

function THsJclDCC32.AddDOFOptions(const ProjectFileName: string; var ProjectOptions: TProjectOptions): Boolean;
var
  DOFFileName: string;
  OptionsFile: TIniFile;
begin
  DOFFileName := ChangeFileExt(ProjectFileName, SourceExtensionDOFProject);
  Result := FileExists(DOFFileName);
  if Result then
  begin
    OptionsFile := TIniFile.Create(DOFFileName);
    try
      ProjectOptions.SearchPath := OptionsFile.ReadString(DOFDirectoriesSection, DOFSearchPathName, '');
      ProjectOptions.UnitOutputDir := OptionsFile.ReadString(DOFDirectoriesSection, DOFUnitOutputDirKey, '');
      ProjectOptions.Conditionals := OptionsFile.ReadString(DOFDirectoriesSection, DOFConditionals, '');
      ProjectOptions.UsePackages := OptionsFile.ReadString(DOFCompilerSection, DOFPackageNoLinkKey, '') = '1';
      ProjectOptions.DynamicPackages := OptionsFile.ReadString(DOFLinkerSection, DOFPackagesKey, '');
      ProjectOptions.Namespace := '';
    finally
      OptionsFile.Free;
    end;
  end;
end;

procedure THsJclDCC32.AddProjectOptions(const ProjectFileName, DCPPath: string);
var
  ProjectOptions: TProjectOptions;
begin
  ProjectOptions.UsePackages := False;
  ProjectOptions.UnitOutputDir := '';
  ProjectOptions.SearchPath := '';
  ProjectOptions.DynamicPackages := '';
  ProjectOptions.SearchDcpPath := '';
  ProjectOptions.Conditionals := '';
  ProjectOptions.Namespace := '';

  if AddDProjOptions(ProjectFileName, ProjectOptions) or
     AddBDSProjOptions(ProjectFileName, ProjectOptions) or
     AddDOFOptions(ProjectFileName, ProjectOptions) then
  begin
    if ProjectOptions.UnitOutputDir <> '' then
    begin
      if DCCVersion >= 24.0 then // XE3+
        AddPathOption('NU', ProjectOptions.UnitOutputDir)
      else
        AddPathOption('N', ProjectOptions.UnitOutputDir);
    end;
    if ProjectOptions.SearchPath <> '' then
    begin
      AddPathOption('I', ProjectOptions.SearchPath);
      AddPathOption('R', ProjectOptions.SearchPath);
    end;
    if ProjectOptions.Conditionals <> '' then
      Options.Add(Format('-D%s', [ProjectOptions.Conditionals]));
    if SamePath(DCPPath, DCPSearchPath) then
      ProjectOptions.SearchDcpPath := DCPPath
    else
      ProjectOptions.SearchDcpPath := StrEnsureSuffix(PathSep, DCPPath) + DCPSearchPath;
    AddPathOption('U', StrEnsureSuffix(PathSep, ProjectOptions.SearchDcpPath) + ProjectOptions.SearchPath);
    if ProjectOptions.UsePackages and (ProjectOptions.DynamicPackages <> '') then
      Options.Add(Format('-LU"%s"', [ProjectOptions.DynamicPackages]));
    if ProjectOptions.Namespace <> '' then
    Options.Add('-ns' + ProjectOptions.Namespace);
  end;
end;

function THsJclDCC32.Compile(const ProjectFileName: string): Boolean;
begin
  // Note: PathGetShortName may not return the short path if it's a network
  // drive. Hence we always double quote the path, regardless of the compiling
  // environment.
  Result := Execute(StrDoubleQuote(StrTrimQuotes(ProjectFileName)));
end;

constructor THsJclDCC32.Create(const ABinDirectory: string; ALongPathBug: Boolean; ADCCVersion: Single;
  ACompilerSettingsFormat: THsJclCompilerSettingsFormat; ASupportsNoConfig, ASupportsPlatform: Boolean;
  const ADCPSearchPath, ALibrarySearchPath, ALibraryDebugSearchPath, ACppSearchPath: string);
begin
  inherited Create(ABinDirectory, ALongPathBug, ACompilerSettingsFormat);
  FDCCVersion := ADCCVersion;
  FSupportsNoConfig := ASupportsNoConfig;
  FSupportsPlatform := ASupportsPlatform;
  FDCPSearchPath := ADCPSearchPath;
  FLibrarySearchPath := ALibrarySearchPath;
  FLibraryDebugSearchPath := ALibraryDebugSearchPath;
  FCppSearchPath := ACppSearchPath;
  SetDefaultOptions(False); // in case $(DELPHI)\bin\dcc32.cfg (replace as appropriate) is invalid
end;

function THsJclDCC32.Execute(const CommandLine: string): Boolean;

  function IsPathOption(const S: string; out Len: Integer): Boolean;
  begin
    Result := False;
    if (Length(S) >= 2) and (S[1] = '-') then
      case UpCase(S[2]) of
        'E', 'I', 'O', 'R', 'U':
          begin
            Result := True;
            Len := 2;
          end;
        'L':
          if Length(S) >= 3 then
          begin
            case UpCase(S[3]) of
              'E', 'e',
              'N', 'n':
                Result := True;
            else
              Result := False;
            end;
            Len := 3;
          end;
        'N':
          begin
            Result := True;
            if Length(S) >= 3 then
            begin
              case Upcase(S[3]) of
                'U', 'X': // -NU<dcupath> -NX<xmlpath>
                  if DCCVersion >= 24.0 then // XE3+
                    Len := 3
                  else
                    Len := 2;
                '0'..'9',
                'H', 'O', 'B':
                  Len := 3;
                'S': // -NS<namespace>
                  if DCCVersion >= 23.0 then // XE2+
                    Len := 3
                  else
                    Len := 2;
              else
                Len := 2;
              end;
            end;
          end;
      end;
  end;

var
  OptionIndex, PathIndex, SwitchLen: Integer;
  PathList: TStrings;
  Option, Arguments, CurrentFolder: string;
begin
  if Assigned(FOnBeforeExecute) then
    FOnBeforeExecute(Self);

  FOutput := '';
  Arguments := '';
  CurrentFolder := PathGetShortName(GetCurrentFolder); // used if LongPathBug is True

  PathList := TStringList.Create;
  try
    for OptionIndex := 0 to Options.Count - 1 do
    begin
      Option := Options.Strings[OptionIndex];
      if IsPathOption(Option, SwitchLen) then
      begin
        StrToStrings(StrTrimQuotes(Copy(Option, SwitchLen + 1, Length(Option) - SwitchLen)), PathSep, PathList);
        if LongPathBug then
          // change to relative paths to avoid DCC32 126 character path limit
          for PathIndex := 0 to PathList.Count - 1 do
            PathList.Strings[PathIndex] := PathGetRelativePath(CurrentFolder, ExpandFileName(PathList[PathIndex]));
        if PathList.Count > 0 then
          Arguments := Format('%s %s"%s"', [Arguments, Copy(Option, 1, SwitchLen),
            StringsToStr(PathList, PathSep)]);
      end
      else
        Arguments := Format('%s %s', [Arguments, Option]);
    end;
  finally
    PathList.Free;
  end;

  Result := InternalExecute(CommandLine + Arguments);

  if Assigned(FOnAfterExecute) then
    FOnAfterExecute(Self);
end;

function THsJclDCC32.GetExeName: string;
begin
  Result := DCC32ExeName;
end;

class function THsJclDCC32.GetPlatform: string;
begin
  Result := BDSPlatformWin32;
end;

function THsJclDCC32.MakePackage(const PackageName, BPLPath, DCPPath: string; ExtraOptions: string = ''; ADebug: Boolean = False): Boolean;
var
  SaveDir: string;
  ConfigurationFileName, BackupFileName: string;
begin
  SaveDir := GetCurrentDir;
  SetCurrentDir(ExtractFilePath(PackageName) + '.');
  try
    // backup existing configuration file, if any
    ConfigurationFileName := ChangeFileExt(PackageName, SourceExtensionConfiguration);
    if FileExists(ConfigurationFileName) then
      FileBackup(ConfigurationFileName, True);

    Options.Clear;
    SetDefaultOptions(ADebug);
    AddProjectOptions(PackageName, DCPPath);
    try
      AddPathOption('LN', DCPPath);
      AddPathOption('LE', BPLPath);
      Options.Add(ExtraOptions);
      Result := Compile(PackageName);
    finally
      // restore existing configuration file, if any
      BackupFileName := GetBackupFileName(ConfigurationFileName);
      if FileExists(BackupFileName) then
        FileMove(BackupFileName, ConfigurationFileName, True);
    end;
  finally
    SetCurrentDir(SaveDir);
  end;
end;

function THsJclDCC32.MakeProject(const ProjectName, OutputDir, DcpSearchPath: string;
  ExtraOptions: string = ''; ADebug: Boolean = False): Boolean;
var
  SaveDir: string;
  ConfigurationFileName, BackupFileName: string;
begin
  SaveDir := GetCurrentDir;
  SetCurrentDir(ExtractFilePath(ProjectName) + '.');
  try
    // backup existing configuration file, if any
    ConfigurationFileName := ChangeFileExt(ProjectName, SourceExtensionConfiguration);
    if FileExists(ConfigurationFileName) then
      FileBackup(ConfigurationFileName, True);

    Options.Clear;
    SetDefaultOptions(ADebug);
    AddProjectOptions(ProjectName, DcpSearchPath);
    try
      AddPathOption('E', OutputDir);
      Options.Add(ExtraOptions);
      Result := Compile(ProjectName);
    finally
      // restore existing configuration file, if any
      BackupFileName := GetBackupFileName(ConfigurationFileName);
      if FileExists(BackupFileName) then
        FileMove(BackupFileName, ConfigurationFileName, True);
    end;
  finally
    SetCurrentDir(SaveDir);
  end;
end;

procedure THsJclDCC32.SetDefaultOptions(ADebug: Boolean);
begin
  Options.Clear;
  if SupportsNoConfig then
    Options.Add('--no-config');
  if ADebug then
    AddPathOption('U', LibraryDebugSearchPath);
  AddPathOption('U', LibrarySearchPath);
  if CppSearchPath <> '' then
  begin
    AddPathOption('U', CppSearchPath);
    Options.Add('-LUrtl');
  end;
end;

//=== { THsJclDCC64 } ==========================================================

class function THsJclDCC64.GetPlatform: string;
begin
  Result := BDSPlatformWin64;
end;

function THsJclDCC64.GetExeName: string;
begin
  Result := DCC64ExeName;
end;

//=== { THsJclDCCOSX32 } =======================================================

class function THsJclDCCOSX32.GetPlatform: string;
begin
  Result := BDSPlatformOSX32;
end;

function THsJclDCCOSX32.GetExeName: string;
begin
  Result := DCCOSX32ExeName;
end;

{$IFDEF MSWINDOWS}
//=== { THsJclDCCIL } ==========================================================

function THsJclDCCIL.GetExeName: string;
begin
  Result := DCCILExeName;
end;

function THsJclDCCIL.GetMaxCLRVersion: string;
var
  StartPos, EndPos: Integer;
begin
  if FMaxCLRVersion <> '' then
  begin
    Result := FMaxCLRVersion;
    Exit;
  end;

  Result := FindResStart(BinDirectory + GetExeName, '  --clrversion');

  StartPos := Pos(':', Result);
  if StartPos = 0 then
    StartPos := Pos('=', Result);

  if StartPos > 0 then
    Result := Copy(Result, StartPos + 1, Length(Result) - StartPos);

  EndPos := Pos(' ', Result);
  if EndPos > 0 then
    SetLength(Result, EndPos - 1);

  if Result = '' then
    Result := 'v1.1.4322'; // do not localize

  FMaxCLRVersion := Result;
end;

function THsJclDCCIL.MakeProject(const ProjectName, OutputDir,
  ExtraOptions: string; ADebug: Boolean = False): Boolean;
var
  SaveDir: string;
begin
  SaveDir := GetCurrentDir;
  SetCurrentDir(ExtractFilePath(ProjectName) + '.');
  try
    Options.Clear;
    SetDefaultOptions(ADebug);
    AddProjectOptions(ProjectName, '');
    AddPathOption('E', OutputDir);
    Options.Add(ExtraOptions);
    Result := Compile(ProjectName);
  finally
    SetCurrentDir(SaveDir);
  end;
end;

procedure THsJclDCCIL.SetDefaultOptions(ADebug: Boolean);
begin
  Options.Clear;
  if ADebug then
    AddPathOption('U', LibraryDebugSearchPath);
  AddPathOption('U', LibrarySearchPath);
end;

{$ENDIF MSWINDOWS}

//=== { THsJclBorlandMake } ====================================================

function THsJclBorlandMake.GetExeName: string;
begin
  Result := MakeExeName;
end;

//=== { THsJclBpr2Mak } ========================================================

function THsJclBpr2Mak.GetExeName: string;
begin
  Result := Bpr2MakExeName;
end;

end.

