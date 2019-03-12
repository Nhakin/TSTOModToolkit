{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: uilPluginMan.PAS, released on 1999-09-06.

The Initial Developer of the Original Code is Tim Sullivan [tim att uil dott net]
Portions created by Tim Sullivan are Copyright (C) 1999 Tim Sullivan.
All Rights Reserved.

Contributor(s):
Ralf Steinhaeusser [ralfiii att gmx dott net].
Gustavo Bianconi
Steefan Lesage - converted to use new OTA


You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.delphi-jedi.org

Known Issues:

 PluginManager loads Plugins

 changed 26.7.2001, by Ralf Steinhaeusser, Changes marked with !

 Events :
 When loading plugins (LoadPlugins) the events are called in the following order:
 FOnBeforeLoad(Sender, Name, CanLoad)
     Plugin -> Register
     Plugin.Initialize
   FOnNewCommand (times Nr. of commands)
 FOnAfterLoad

Versionhistory:

 BaseVersion 5 :
 V 11 : When loading packages -> except instead of finally -> //!11
        New event : OnErrorLoading
 V 10 : Now handles custom Plugins (only their destructors are called when unloading)
 V 09 : Pluginmanager : Extension automatically follows plugintype
        First version to share with "rest of the world"
 V 08 : Problems with $ImplicitBuild
 V 07 : fixed file-creation bug: linebreaks were done with #10#13 instead of
              the other way round, what caused the IDE-navigation do show
              erroneous behaviour
 V 06 : fixed Memory leak when loading of not supported DLL's is skipped
        inserted credits to About-box
 V 05 : started adding Package-functionality
        PluginManager : Loined 2 TLists to one,
        Record with info on Plugins introduced
        fixed buggy Instance-count check
        Added PluginKind-Property
        changed : PluginName also contains path
 V 04 : cleaned Plugin-Manager :
        Removed OnBefore- and OnAfterLoading (REALLY unnecessary - OnBeforeLoad,
                and OnAfterLoad are still here !)
        Removed Trigger-routines. Were only called once -> moved into code
 V 03 : removed unecessary Set/Get-routines for most properties
 V 02 : new about-dialog, removed unnecessary CDK-auto-generated comments
        stupid fPluginHandles from TStringList -> TList
 V 01 : renamed objects, files, ressources
        fixed several Memory-leaks, fixed unload-bug, minimized uses-list
-----------------------------------------------------------------------------}
// $Id$

Unit HsJvPluginManager;

Interface

Uses
  {$IFDEF MSWINDOWS}
  Windows,
  {$ENDIF MSWINDOWS}
  Graphics, Forms,
  SysUtils, Classes,
  HsJvPlugin;
  //JvComponentBase, JvPlugin, JvJVCLUtils;

{const
  C_VersionString = '5.10';}

Type
  THsJvNewCommandEvent = Procedure(Sender: TObject; ACaption, AHint, AData: String; AShortCut: TShortCut; ABitmap: TBitmap; AEvent: TNotifyEvent) Of Object;

  THsJvBeforeLoadEvent = Procedure(Sender: TObject; FileName: String; Var AllowLoad: Boolean) Of Object;
  THsJvAfterLoadEvent = Procedure(Sender: TObject; FileName: String; Const ALibHandle: THandle; Var AllowLoad: Boolean) Of Object;
  THsJvBeforeUnloadEvent = Procedure(Sender: TObject; FileName: String; Const ALibHandle: THandle) Of Object;
  THsJvAfterUnloadEvent = Procedure(Sender: TObject; FileName: String) Of Object;
  THsJvBeforeCommandsEvent = Procedure(Sender: TObject; APlugIn: THsJvPlugIn) Of Object;
  THsJvAfterCommandsEvent = Procedure(Sender: TObject; APlugIn: THsJvPlugIn) Of Object;
  THsJvPlgInErrorEvent = Procedure(Sender: TObject; AError: Exception) Of Object;
  // End of Bianconi

  EHsJvPlugInError = Class(Exception);
  EHsJvLoadPluginError = Class(EHsJvPlugInError);
  // Bianconi
  EHsJvExtensionPlugInError = Class(EHsJvPlugInError);
  EHsJvInitializationPlugInError = Class(EHsJvPlugInError);
  EHsJvInitializationCustomPlugInError = Class(EHsJvPlugInError);
  EHsJvCantRegisterPlugInError = Class(EHsJvPlugInError);
  // End of Bianconi

  TPluginKind = (plgDLL, plgPackage, plgCustom);

  TPluginInfo = Class(TObject)
  Public
    PluginKind: TPluginKind;
    Handle:     HINST;
    PlugIn:     THsJvPlugIn;
  End;

  {$IFDEF VER230}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  {$ENDIF}

  THsJvPluginManager = Class(TComponent)
  Private
    FExtension            : String;
    FPluginFolder         : String;
    FPluginKind           : TPluginKind;
    FPluginInfos          : TList;
    FOnBeforeLoad         : THsJvBeforeLoadEvent;
    FOnAfterLoad          : THsJvAfterLoadEvent;
    FOnBeforeUnload       : THsJvBeforeUnloadEvent;
    FOnAfterUnload        : THsJvAfterUnloadEvent;
    FOnNewCommand         : THsJvNewCommandEvent;
    FPluginHostMessage    : TPluginMessageObjEvent; // uses the the object version of TPluginMessageEvent
    FOnBeforeNewCommand   : THsJvBeforeCommandsEvent;
    FOnAfterNewCommand    : THsJvAfterCommandsEvent;
    FOnPlugInError        : THsJvPlgInErrorEvent;
    FShowLoadPluginErrors : Boolean;

    Procedure SetPluginKind(Const Value: TPluginKind);
    Procedure UnloadLibrary(Kind: TPluginKind; LibHandle: Integer);

  Protected
    Procedure SetExtension(Const NewValue: String);
    Function GetPlugin(Index: Integer): THsJvPlugIn;
    Function GetPluginCount: Integer;
    Function DoBeforeLoad(Const FileName: String): Boolean; Virtual;
    Function DoAfterLoad(Const FileName: String; LibHandle: THandle): Boolean; Virtual;
    Procedure ReBroadcastMessages(Sender: TObject; PluginMessage: Longint; PluginParams: String);
    Procedure ReBroadcastMessagesObj(Sender: TObject; PluginMessage: Longint; PluginParams: String; AObj: TObject);

  Published
    Property PluginFolder         : String                 Read FPluginFolder         Write FPluginFolder;
    Property Extension            : String                 Read FExtension            Write SetExtension;
    Property PluginKind           : TPluginKind            Read FPluginKind           Write SetPluginKind;
    Property ShowLoadPluginErrors : Boolean                Read FShowLoadPluginErrors Write FShowLoadPluginErrors Default False;
    Property OnBeforeLoad         : THsJvBeforeLoadEvent     Read FOnBeforeLoad         Write FOnBeforeLoad;
    Property OnNewCommand         : THsJvNewCommandEvent       Read FOnNewCommand         Write FOnNewCommand;
    Property OnAfterLoad          : THsJvAfterLoadEvent      Read FOnAfterLoad          Write FOnAfterLoad;
    Property OnBeforeUnload       : THsJvBeforeUnloadEvent   Read FOnBeforeUnload       Write FOnBeforeUnload;
    Property OnAfterUnload        : THsJvAfterUnloadEvent    Read FOnAfterUnload        Write FOnAfterUnload;
    Property OnBeforeNewCommand   : THsJvBeforeCommandsEvent Read FOnBeforeNewCommand   Write FOnBeforeNewCommand;
    Property OnAfterNewCommand    : THsJvAfterCommandsEvent  Read FOnAfterNewCommand    Write FOnAfterNewCommand;
    Property OnPlugInError        : THsJvPlgInErrorEvent     Read FOnPlugInError        Write FOnPlugInError;
    Property OnPluginHostMessage  : TPluginMessageObjEvent Read FPluginHostMessage    Write FPluginHostMessage;

  Public
    Property Plugins[Index: Integer]: THsJvPlugIn Read GetPlugin;
    Property PluginCount : Integer Read GetPluginCount;

    Procedure LoadPlugin(FileName: String; PlgKind: TPluginKind);
    Procedure LoadPlugins();
    Procedure UnloadPlugin(Index: Integer);
    Procedure GetLoadedPlugins(PlugInList: TStrings);
    Procedure SendMessage(PluginMessage: Longint; PluginParams: String); Deprecated;
    Procedure BroadcastMessage(PluginMessage: Longint; PluginParams: String);
    Function AddCustomPlugin(PlugIn: THsJvPlugIn; Const FileName: String = ''): Boolean;

    Constructor Create(AOwner: TComponent); OverRide;
    Destructor Destroy; OverRide;

  End;

Implementation

ResourceString
  RsEErrEmptyExt = 'Extension may not be empty';
  RsEPluginPackageNotFound = 'Plugin package not found: %s';
  RsERegisterPluginNotFound = 'Plugin function %0:s not found in %1:s';
  RsERegisterPluginFailed = 'Calling %0:s in %1:s failed';

Const
  C_REGISTER_PLUGIN = 'RegisterPlugin';
  C_Extensions: Array [plgDLL..plgCustom] Of PChar = ('dll', 'bpl', 'xxx');


// Originating from Host
Procedure THsJvPluginManager.BroadcastMessage(PluginMessage: Integer; PluginParams: String);
Var
  I: Integer;
Begin
  For I := 0 To FPluginInfos.Count - 1 Do
    Plugins[I].OnPluginMessage(Self, PluginMessage, PluginParams);
End;


// Originating from Plugins
Procedure THsJvPluginManager.ReBroadcastMessages(Sender: TObject; PluginMessage: Integer; PluginParams: String);
Var
  I: Integer;
Begin
  // First trigger Host message event
  If Assigned(FPluginHostMessage) Then
    FPluginHostMessage(Self, PluginMessage, PluginParams, nil);

  // Cant call orginal BroadcastMessage becasue we need to test for origonating sender plugin.
  // Host never recieves messages it sends because bit of code above is missing in origonal BroadcastMessage.

  // Next rebroadcast message to loaded plugins skipping plugin that sent message.
  For I := 0 To FPluginInfos.Count - 1 Do
  Begin
    If (Plugins[I] <> Sender) Then
      Plugins[I].OnPluginMessage(Sender, PluginMessage, PluginParams);
  End;
End;

// Originating from Plugins with object (overloaded above version)
Procedure THsJvPluginManager.ReBroadcastMessagesObj(Sender: TObject; PluginMessage: Integer; PluginParams: String; AObj: TObject);
Var
  I: Integer;
Begin
  // First trigger Host message event
  If Assigned(FPluginHostMessage) Then
    FPluginHostMessage(Self, PluginMessage, PluginParams, AObj);

  // Cant call orginal BroadcastMessage becasue we need to test for origonating sender plugin.
  // Host never recieves messages it sends because bit of code above is missing in origonal BroadcastMessage.

  // Next rebroadcast message to loaded plugins skipping plugin that sent message.
  For I := 0 To FPluginInfos.Count - 1 Do
  Begin
    If (Plugins[I] <> Sender) Then
      Plugins[I].OnPluginMessageWithObj(Sender, PluginMessage, PluginParams, AObj);
  End;
End;

Constructor THsJvPluginManager.Create(AOwner: TComponent);
Begin
  Try
    Inherited Create(AOwner);
    FPluginInfos := TList.Create;
    FPluginKind  := plgDLL;
    FExtension   := C_Extensions[FPluginKind];
  Except
    on E: Exception Do
    Begin
      If Not (csDesigning In ComponentState) And Assigned(FOnPlugInError) Then
        FOnPlugInError(Self, E)
      Else
        Raise;
    End;
  End;
End;

Destructor THsJvPluginManager.Destroy;
Begin
  // Free the loaded plugins
  While FPluginInfos.Count > 0 Do
    UnloadPlugin(0);
  FPluginInfos.Free;
  Inherited Destroy;
End;

Function THsJvPluginManager.DoAfterLoad(Const FileName: String; LibHandle: THandle): Boolean;
Begin
  Result := True;
  If Assigned(FOnAfterLoad) Then
    FOnAfterLoad(Self, FileName, LibHandle, Result);
End;

Function THsJvPluginManager.DoBeforeLoad(Const FileName: String): Boolean;
Begin
  Result := True;
  If Assigned(FOnBeforeLoad) Then
    FOnBeforeLoad(Self, FileName, Result);
End;

Procedure THsJvPluginManager.SetExtension(Const NewValue: String);
Begin
  Try
    If FExtension <> NewValue Then
    Begin
      // (rb) No reason to block this
      If {(Length(NewValue) > 3) or} Length(NewValue) < 1 Then
        Raise EHsJvPlugInError.CreateRes(@RsEErrEmptyExt)
      Else
        FExtension := NewValue;
    End;
  Except
    on E: Exception Do
    Begin
      If Not (csDesigning In ComponentState) And Assigned(FOnPlugInError) Then
        FOnPlugInError(Self, E)
      Else
        Raise;
    End;
  End;
End;

Procedure THsJvPluginManager.SetPluginKind(Const Value: TPluginKind);
Begin
  If FPluginKind <> Value Then
  Begin
    If FExtension = C_Extensions[FPluginKind] Then
      FExtension := C_Extensions[Value];
    FPluginKind := Value;
  End;
End;

Function THsJvPluginManager.GetPluginCount: Integer;
Begin
  Result := FPluginInfos.Count;
End;

Function THsJvPluginManager.GetPlugin(Index: Integer): THsJvPlugIn;
Var
  PlgI: TPluginInfo;
Begin
  PlgI   := FPluginInfos.Items[Index];
  Result := PlgI.PlugIn;
End;

Procedure THsJvPluginManager.GetLoadedPlugins(PlugInList: TStrings);
Var
  I: Integer;
Begin
  PlugInList.BeginUpdate;
  Try
    PlugInList.Clear;
    For I := 0 To FPluginInfos.Count - 1 Do
      PlugInList.Add(Plugins[I].Name);
  Finally
    PlugInList.EndUpdate;
  End;
End;

// Create and add plugin - if error occurs, the Plugin is not added to list

Function THsJvPluginManager.AddCustomPlugin(PlugIn: THsJvPlugIn; Const FileName: String = ''): Boolean;
Var
  PlgInfo: TPluginInfo;
  Counter: Integer;
Begin
  Result := False;
  Try
    If Length(FileName) = 0 Then
      Result := PlugIn.Initialize(Self, Application, 'CustomPlugin')
    Else
      Result := PlugIn.Initialize(Self, Application, FileName);

    If Not Result Then
      Exit;

    PlgInfo := TPluginInfo.Create;
    PlgInfo.PluginKind := plgCustom;
    PlgInfo.PlugIn := PlugIn;

    FPluginInfos.Add(PlgInfo);

    Try
      If Assigned(FOnBeforeNewCommand) Then
        FOnBeforeNewCommand(Self, PlugIn);

      // Events for all new commands
      If Assigned(FOnNewCommand) Then
        For Counter := 0 To PlugIn.Commands.Count - 1 Do
          With THsJvPluginCommand(PlugIn.Commands.Items[Counter]) Do
            FOnNewCommand(Self, Caption, Hint, Data, ShortCut, Bitmap, OnExecute);
    Finally
      If Assigned(FOnAfterNewCommand) Then
        FOnAfterNewCommand(Self, PlugIn);
    End;
  Except
    on E: Exception Do
    Begin
      If Not (csDesigning In ComponentState) And Assigned(FOnPlugInError) Then
        FOnPlugInError(Self, E)
      Else
        Raise;
    End;
  End;
End;

// Load a Plugin - either DLL or package

Procedure THsJvPluginManager.LoadPlugin(FileName: String; PlgKind: TPluginKind);
Type
  TSxRegisterPlugin = Function: THsJvPlugIn; StdCall;
  
Var Counter      : Integer;
    LibHandle    : Integer;
    RegisterProc : TSxRegisterPlugin;
    PlugIn       : THsJvPlugIn;
    NumCopies    : Integer;
    PlgInfo      : TPluginInfo;
Begin
  If DoBeforeLoad(FileName) Then
  Begin
    LibHandle := 0;
    PlgInfo   := nil;
    PlugIn    := nil;
    Try
      Case PlgKind Of
        plgDLL:
          LibHandle := SafeLoadLibrary(FileName);
        plgPackage:
          LibHandle := LoadPackage(FileName);
      End;

      If LibHandle = 0 Then
        Raise EHsJvLoadPluginError.CreateResFmt(@RsEPluginPackageNotFound, [FileName]);

      // Load the registration procedure
      RegisterProc := GetProcAddress(LibHandle, C_REGISTER_PLUGIN);
      If Not Assigned(RegisterProc) Then
        Raise EHsJvLoadPluginError.CreateResFmt(@RsERegisterPluginNotFound, [C_REGISTER_PLUGIN, FileName]);

      // register the plugin
      PlugIn := RegisterProc;
      If PlugIn = nil Then
        Raise EHsJvCantRegisterPlugInError.CreateResFmt(@RsERegisterPluginFailed, [C_REGISTER_PLUGIN, FileName]);

      // make sure we don't load more copies of the plugin than allowed
      If PlugIn.InstanceCount > 0 Then // 0 = unlimited
      Begin
        NumCopies := 0;
        For Counter := 0 To FPluginInfos.Count - 1 Do
          If Plugins[Counter].PluginID = PlugIn.PluginID Then
            Inc(NumCopies);

        If NumCopies >= PlugIn.InstanceCount Then
        Begin
          PlugIn.Free;
          Exit; // Todo : Don't know what Skipload does here
        End;
      End; // if Plugin.InstanceCount > 0

      // initialize the plugin and add to list
      If AddCustomPlugin(PlugIn, FileName) Then
      Begin
        PlgInfo := FPluginInfos.Last;
        PlgInfo.PluginKind := PlgKind;
        PlgInfo.Handle := LibHandle;
        // Assign (hook) our new Host's plugin compatible broadcasting method to our newly loaded plugin 's broadcast event.
        PlgInfo.PlugIn.OnPluginBroadcast := ReBroadcastMessages;
        PlgInfo.PlugIn.OnPluginBroadcastObj := ReBroadcastMessagesObj;
      End;

      If Not DoAfterLoad(FileName, LibHandle) Then
        UnloadPlugin(FPluginInfos.IndexOf(PlgInfo));
    Except
      //!11    if - for whatever reason - an exception has occurred
      //            free Plugin and library
      // (rom) statements used twice could be wrapped in method
      on E: Exception Do
      Begin
        If PlgInfo <> nil Then
          UnloadPlugin(FPluginInfos.IndexOf(PlgInfo))
        Else
        Begin
          FreeAndNil(PlugIn);
          If LibHandle <> 0 Then
            UnloadLibrary(PlgKind, LibHandle);
        End;
        If Not (csDesigning In ComponentState) And Assigned(FOnPlugInError) Then
          FOnPlugInError(Self, E)
        Else
          Raise;
      End;
    End;
  End;
End;

 // Load all plugins in the plugin-folder
 // exceptions can only be seen through the OnErrorLoading-Event

Procedure THsJvPluginManager.LoadPlugins;
Var
  FileName: String;
  Found: Integer;
  Path: String;
  Sr: TSearchRec;
Begin
  // if the PluginPath is blank, we load from the app's folder.
  If FPluginFolder = '' Then
    Path := ExtractFilePath(Application.ExeName)
  Else
    Path := FPluginFolder;
  Path := IncludeTrailingPathDelimiter(Path);

  Found := FindFirst(Path + '*.' + FExtension, 0, Sr);
  Try
    While Found = 0 Do
    Begin
      FileName := Sr.Name;
      //! If one plugin made problems -> no other plugins where loaded
      //! To avoid that the try-except block was wrapped around here...
      Try
        LoadPlugin(Path + FileName, PluginKind);
      Except
        // OnPluginError is already triggered in LoadPlugin if available
        {if not (csDesigning in ComponentState) and Assigned(FOnPlugInError) then
          FOnPlugInError(Self, E)
        else}
        If ShowLoadPluginErrors Then
          Application.HandleException(Self);
      End;
      Found := FindNext(Sr);
    End;
  Finally
    FindClose(Sr);
  End;
End;

Procedure THsJvPluginManager.UnloadPlugin(Index: Integer);
Var
  PlgI: TPluginInfo;
  Name: String;
Begin
  PlgI := FPluginInfos.Items[Index];
  Name := PlgI.PlugIn.FileName;
  If assigned(FOnBeforeUnload) Then
    FOnBeforeUnload(self, Name, PlgI.Handle);
  PlgI.PlugIn.Free;
  UnloadLibrary(PlgI.PluginKind, PlgI.Handle);
  PlgI.Free;
  FPluginInfos.Delete(Index);
  If assigned(FOnAfterUnload) Then
    FOnAfterUnload(self, Name);
End;

{$WARN SYMBOL_DEPRECATED OFF}
Procedure THsJvPluginManager.SendMessage(PluginMessage: Longint; PluginParams: String);
Begin
  BroadcastMessage(PluginMessage, PluginParams);
End;

{$WARN SYMBOL_DEPRECATED ON}

Procedure THsJvPluginManager.UnloadLibrary(Kind: TPluginKind; LibHandle: Integer);
Begin
  Case Kind Of
    plgDLL:
      FreeLibrary(LibHandle);
    plgPackage:
      UnloadPackage(LibHandle);
  End;
End;

End.
