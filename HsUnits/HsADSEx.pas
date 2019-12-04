unit HsADSEx;

interface

Uses Windows, Classes;

Type
  TStreamType  = ( siInvalid, siStandard, siExtendedAttribute, siSecurity, siAlternate,
                 siHardLink, siProperty, siObjectIdentifier, siReparsePoints, siSparseFile);
  TStreamTypes = Set Of TStreamType;

  TInternalFindStreamData = Record
    FileHandle : THandle;
    Context    : Pointer;
    StreamIds  : TStreamTypes;
  End;

  TFindStreamData = Record
    Internal   : TInternalFindStreamData;
    Attributes : DWord;
    StreamID   : TStreamType;
    Name       : WideString;
    Size       : Int64;
  End;
  
Function HsFindFirstStreamEx(Const FileName : String; StreamIds : TStreamTypes; Var Data : TFindStreamData) : Boolean;
Function HsFindNextStreamEx(Var Data : TFindStreamData) : Boolean;
Function HsFindStreamCloseEx(Var Data : TFindStreamData) : Boolean;

Procedure HsListStreamEx(AStartPoint : String; AList : TStrings; Const ARecursive : Boolean = True);
Function  HsFindSreamEx(AStartPoint : String; AList : TStrings; Const ARecursive : Boolean = True) : Boolean;

implementation

Uses Dialogs,
  SysUtils, HsPerlRegEx;

type
  TBackupSeek = function (hFile: THandle; dwLowBytesToSeek, dwHighBytesToSeek: DWORD;
    out lpdwLowByteSeeked, lpdwHighByteSeeked: DWORD;
    var lpContext: Pointer): BOOL; stdcall;

Var
  _BackupSeek : TBackupSeek = Nil;

Function FindStream(Var Data : TFindStreamData) : Boolean;
  Procedure GetProcedureAddress(Var P : Pointer; Const ModuleName, ProcName : String);
  Var ModuleHandle : HModule;
  Begin
    If Not Assigned(P) Then
    Begin
      ModuleHandle := GetModuleHandle(PChar(ModuleName));
      If ModuleHandle = 0 Then
      Begin
        ModuleHandle := SafeLoadLibrary(PChar(ModuleName));
        If ModuleHandle = 0 Then
          Raise Exception.Create('Invalid dll');
      End;
      P := GetProcAddress(ModuleHandle, PChar(ProcName));
      If Not Assigned(P) Then
        Raise Exception.CreateFmt('Function %s not found in %s.', [ProcName, ModuleName]);
    End;
   End;

  Function MyBackupSeek(hFile: THandle; dwLowBytesToSeek, dwHighBytesToSeek: DWord;
    Out lpdwLowByteSeeked, lpdwHighByteSeeked: DWord;
    Var lpContext: Pointer) : Boolean;
  Begin
    GetProcedureAddress(Pointer(@_BackupSeek), kernel32, 'BackupSeek');
    Result := _BackupSeek(hFile, dwLowBytesToSeek, dwHighBytesToSeek, lpdwLowByteSeeked, lpdwHighByteSeeked, lpContext);
  End;

Type
  THslULargeInteger = record
    Case Integer Of
    0: (
         LowPart: LongWord;
         HighPart: LongWord
       );
    1: (
         QuadPart: Int64
       );
  End;

Var Header      : TWin32StreamId;
    BytesToRead ,
    BytesRead   : DWord;
    BytesToSeek : THslULargeInteger;
    Hi, Lo      : DWord;
    FoundStream : Boolean;
    StreamName  : PWideChar;
Begin
  Result      := False;
  FoundStream := False;
  FillChar(Header, SizeOf(Header), 0);
  // We loop until we either found a stream or an error occurs.
  While Not FoundStream Do
  Begin
    // Read stream header
    BytesToRead := DWord(Cardinal(@Header.cStreamName[0]) - Cardinal(@Header.dwStreamId));
    BytesRead   := 0;
    If Not BackupRead(Data.Internal.FileHandle, @Header, BytesToRead, BytesRead, False, True, Data.Internal.Context) Then
    Begin
      SetLastError(ERROR_READ_FAULT);
      Exit;
    End
    Else
    Begin
      If BytesRead = 0 Then // EOF
      Begin
        SetLastError(ERROR_NO_MORE_FILES);
        Exit;
      End
      Else
      Begin
        // If stream has a name then read it
        If Header.dwStreamNameSize > 0 Then
        Begin
          StreamName := HeapAlloc(GetProcessHeap, 0, Header.dwStreamNameSize + SizeOf(WChar));
          If StreamName = nil Then
          Begin
            SetLastError(ERROR_OUTOFMEMORY);
            Exit;
          End;

          If Not BackupRead( Data.Internal.FileHandle,
                             Pointer(StreamName),
                             Header.dwStreamNameSize,
                             BytesRead,
                             False,
                             True,
                             Data.Internal.Context) Then
          Begin
            HeapFree(GetProcessHeap, 0, StreamName);
            SetLastError(ERROR_READ_FAULT);
            Exit;
          End;
          StreamName[Header.dwStreamNameSize Div SizeOf(WChar)] := Widechar(#0);
        End
        Else
          StreamName := nil;

        // Did we find any of the specified streams ([] means any stream)?
        If (Data.Internal.StreamIds = []) Or
          (TStreamType(Header.dwStreamId) In Data.Internal.StreamIds) Then
        Begin
          FoundStream     := True;
          Data.Size       := Header.Size;
          Data.Name       := StreamName;
          Data.Attributes := Header.dwStreamAttributes;
          Data.StreamId   := TStreamType(Header.dwStreamId);
        End;

        // Release stream name memory if necessary
        If Header.dwStreamNameSize > 0 Then
          HeapFree(GetProcessHeap, 0, StreamName);

        // Move past data part to beginning of next stream (or EOF)
        BytesToSeek.QuadPart := Header.Size;
        If (Header.Size <> 0) And (Not MyBackupSeek(Data.Internal.FileHandle, BytesToSeek.LowPart,
          BytesToSeek.HighPart, Lo, Hi, Data.Internal.Context)) Then
        Begin
          SetLastError(ERROR_READ_FAULT);
          Exit;
        End;
      End;
    End;
  End;

  // Due to the usage of Exit, we only get here if everything succeeded
  Result := True;
End;

Function HsFindFirstStreamEx(Const FileName : String; StreamIds : TStreamTypes; Var Data : TFindStreamData) : Boolean;
Begin
  Result := False;
  // Open file for reading, note that the FILE_FLAG_BACKUP_SEMANTICS requires
  // the SE_BACKUP_NAME and SE_RESTORE_NAME privileges.
  Data.Internal.FileHandle := CreateFile( PChar(FileName),
                                          GENERIC_READ,
                                          FILE_SHARE_READ Or FILE_SHARE_WRITE,
                                          Nil,
                                          OPEN_EXISTING,
                                          FILE_FLAG_BACKUP_SEMANTICS,
                                          0);
  If Data.Internal.FileHandle <> INVALID_HANDLE_VALUE Then
  Begin
    // Initialize private context
    Data.Internal.StreamIds := StreamIds;
    Data.Internal.Context := Nil;
    // Call upon the Borg worker to find the next (first) stream
    Result := FindStream(Data);
    If Not Result Then
    Begin
      // Failure, cleanup relieving the caller of having to call FindStreamClose
      CloseHandle(Data.Internal.FileHandle);
      Data.Internal.FileHandle := INVALID_HANDLE_VALUE;
      Data.Internal.Context    := Nil;
      If GetLastError = ERROR_NO_MORE_FILES Then
        SetLastError(ERROR_FILE_NOT_FOUND);
    End;
  End;
End;

Function HsFindNextStreamEx(Var Data : TFindStreamData) : Boolean;
Begin
  Result := False;
  If Data.Internal.FileHandle <> INVALID_HANDLE_VALUE Then
    Result := FindStream(Data)
  Else
    SetLastError(ERROR_INVALID_HANDLE);
End;

Function HsFindStreamCloseEx(Var Data : TFindStreamData) : Boolean;
Var
  BytesRead : DWord;
  LastError : DWord;
Begin
  Result    := Data.Internal.FileHandle <> INVALID_HANDLE_VALUE;
  LastError := ERROR_SUCCESS;
  If Result Then
  Begin
    // Call BackupRead one last time to signal that we're done with it
    BytesRead := 0;
    Result    := BackupRead(0, Nil, 0, BytesRead, True, False, Data.Internal.Context);
    If Not Result Then
      LastError := GetLastError();
    CloseHandle(Data.Internal.FileHandle);
    Data.Internal.FileHandle := INVALID_HANDLE_VALUE;
    Data.Internal.Context    := Nil;
  End
  Else
    LastError := ERROR_INVALID_HANDLE;
  SetLastError(LastError);
End;

Procedure HsListStreamEx(AStartPoint : String; AList : TStrings; Const ARecursive : Boolean = True);
  Procedure InternalListStream(AName : String);
  Var lData : TFindStreamData;
  Begin
    If HsFindFirstStreamEx(AName, [siAlternate], lData) Then
    Try
      Repeat
        If SameText(AStartPoint, AName) Then
          AName := ExcludeTrailingBackSlash(AName);
        AList.Add(AName + StringReplace(lData.Name, ':$DATA', '', [rfReplaceAll, rfIgnoreCase]));
      Until Not HsFindNextStreamEx(lData);

      Finally
        HsFindStreamCloseEx(lData);
    End;
  End;

Var lSr : TSearchRec;
Begin
  If DirectoryExists(AStartPoint) Then
    AStartPoint := IncludeTrailingBackSlash(AStartPoint);

  If FileExists(AStartPoint) Then
    InternalListStream(AStartPoint)
  Else If FindFirst(AStartPoint + '*.*', faAnyFile, lSr) = 0 Then
  Try
    Repeat
      If lSr.Attr And faDirectory = faDirectory Then
      Begin
        If lSr.Name = '.' Then
          InternalListStream(AStartPoint)
        Else If (lSr.Name <> '..') And ARecursive Then
          HsListStreamEx(AStartPoint + lSr.Name {+ '\'}, AList);
      End
      Else
        InternalListStream(AStartPoint + lSr.Name);
    Until FindNext(lSr) <> 0;

    Finally
      FindClose(lSr);
  End;
End;

Function HsFindSreamEx(AStartPoint : String; AList : TStrings; Const ARecursive : Boolean = True) : Boolean;
Var lLst    : TStringList;
    lRegExp : IHsPerlRegEx;
    lRegStr : String;
Begin
  lLst := TStringList.Create();
  lRegExp := THsPerlRegEx.CreateHsPerlRegEx();
  Try
    HsListStreamEx(ExtractFilePath(AStartPoint), lLst, ARecursive);

    lRegStr := '^' +
               StringReplace(
                 StringReplace(
                   lRegExp.EscapeRegExChars(
                     StringReplace(
                       ExcludeTrailingBackSlash(ExtractFilePath(AStartPoint)) + #$90 + ExtractFileName(AStartPoint)
                     , '*', #$90, [rfReplaceAll]))
                 , #$90, '.*', [rfReplaceAll])
               , '.*.*', '.*', [rfReplaceAll]) + '$';
//ShowMessage(lRegStr);Exit;

    lRegExp.RegEx := lRegStr;
    lRegExp.Subject := lLst.Text;
    lRegExp.Options := [preCaseLess, preMultiLine];

    If lRegExp.Match() Then
      Repeat
        AList.Add(lRegExp.MatchedText);
      Until Not lRegExp.MatchAgain();

    Finally
      lLst.Free();
      lRegExp := Nil;
  End;

  Result := AList.Count > 0;
End;

end.
