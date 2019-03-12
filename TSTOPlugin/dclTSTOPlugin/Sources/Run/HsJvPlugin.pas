{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: uilPlugin.PAS, released on 1999-09-06.

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

Todo : Why the "stdcall" definitions ? (routines Configure, Initialize...)
       Why the TriggerConfigureEvent (and similar) procedures ? necessary ?
       What for the GlobalNameSpace.BeginWrite ?
-----------------------------------------------------------------------------}
// $Id$

Unit HsJvPlugin;

Interface

Uses
  Types, SysUtils, Classes, Forms, Graphics;

Type
  // For legacy reasons, the first one still exists but you are encouraged to use the second
  TPluginMessageEvent = Procedure(Sender : TObject; APluginMessage : Longint; AMessageText : String) Of Object;
  TPluginMessageObjEvent = Procedure(Sender : TObject; APluginMessage : Longint; AMessageText : String; AObj : TObject) Of Object;
  TPluginInitializeEvent = Procedure(Sender : TObject; Var AllowLoad : Boolean) Of Object;
  THsJvPluginCommand  = Class;
  THsJvPluginCommands = Class;

  THsJvPlugIn = Class(TDataModule)
  Private
    FPluginID                   : String;
    FAuthor                     : String;
    FCopyright                  : String;
    FDescription                : String;
    FFileName                   : TFileName;
    FCommands                   : THsJvPluginCommands;
    FHostApplication            : TApplication;
    FManager                    : TComponent;
    FInstanceCount              : Integer;
    FOnPluginMessage            : TPluginMessageEvent;
    FOnBroadcastToAllMessage    : TPluginMessageEvent;
    FOnPluginMessageObj         : TPluginMessageObjEvent;
    FOnBroadcastToAllMessageObj : TPluginMessageObjEvent;
    FOnInitialize               : TPluginInitializeEvent;
    FOnConfigure                : TNotifyEvent;
    FPluginVersion              : String;

  Protected
    Procedure SetCommands(NewValue : THsJvPluginCommands); Virtual;
    Procedure TriggerPluginMessageEvent(APluginMessage : Longint; AMessageText : String); Virtual;
    Procedure TriggerInitializeEvent(Var AllowLoad : Boolean); Virtual;
    Procedure TriggerConfigureEvent; Virtual;

  Published
    Property Author                 : String                 Read FAuthor             Write FAuthor;
    Property Commands               : THsJvPluginCommands    Read FCommands           Write SetCommands;
    Property Description            : String                 Read FDescription        Write FDescription;
    Property Copyright              : String                 Read FCopyright          Write FCopyright;
    Property InstanceCount          : Integer                Read FInstanceCount      Write FInstanceCount Default 1;
    Property PluginID               : String                 Read FPluginID           Write FPluginID;
    //property Version                : string                 read GetVersion          write SetVersion;
    Property PluginVersion          : String                 Read FPluginVersion      Write FPluginVersion;
    Property OnPluginMessage        : TPluginMessageEvent    Read FOnPluginMessage    Write FOnPluginMessage;
    Property OnPluginMessageWithObj : TPluginMessageObjEvent Read FOnPluginMessageObj Write FOnPluginMessageObj;
    Property OnInitialize           : TPluginInitializeEvent Read FOnInitialize       Write FOnInitialize;
    Property OnConfigure            : TNotifyEvent           Read FOnConfigure        Write FOnConfigure;

  Public
    Property HostApplication: TApplication Read FHostApplication;
    Property Manager: TComponent Read FManager;
    Property FileName: TFileName Read FFileName;

    // Host uses this Event property (not the plugin component through the object inspector) so it is not published.
    Property OnPluginBroadcast: TPluginMessageEvent Read FOnBroadcastToAllMessage Write FOnBroadcastToAllMessage;
    Property OnPluginBroadcastObj: TPluginMessageObjEvent Read FOnBroadcastToAllMessageObj Write FOnBroadcastToAllMessageObj;

    Procedure Configure; Virtual; StdCall;
    Function Initialize(Manager : TComponent; HostApplication : TApplication; FileName : String) : Boolean; Virtual; StdCall;
    Procedure SendPluginMessage(APluginMessage : Longint; AMessageText : String);
    Procedure BroadcastMsgToALL(APluginMessage : Longint; AMessageText : String); Virtual; StdCall;
    Procedure BroadcastMsgToALLObj(APluginMessage : Longint; AMessageText : String; AObj : TObject);
    // Only reason I can think of that would require BroadcastMsgToALL to be exported is when the plugin needs to
    // send a message to other modules in order to function properly.  In such a case the host
    // would need to implement a rebroadcast method.  In Delphi this is done by the Plugin Manager,
    // other languages, implementation of rebroadcast. Leaving the obj ver alone for now.

    Constructor Create(AOwner : TComponent); OverRide;
    Destructor Destroy; OverRide;

  End;

  THsJvPluginCommand = Class(TCollectionItem)
  Private
    FName      : String;
    FCaption   : String;
    FHint      : String;
    FData      : String;
    FShortCut  : TShortCut;
    FBitmap    : TBitmap;
    FOnExecute : TNotifyEvent;

    Procedure SetBitmap(Value : TBitmap);

  Protected
    Function GetDisplayName : String; OverRide;

  Published
    Property Bitmap    : TBitmap      Read FBitmap    Write SetBitmap;
    Property Caption   : String       Read FCaption   Write FCaption;
    Property Hint      : String       Read FHint      Write FHint;
    Property Data      : String       Read FData      Write FData;
    Property Name      : String       Read FName      Write FName;
    Property ShortCut  : TShortCut    Read FShortCut  Write FShortCut;
    Property OnExecute : TNotifyEvent Read FOnExecute Write FOnExecute;

  Public
    Constructor Create(Collection : TCollection); OverRide;
    Destructor Destroy; OverRide;
  
  End;

  THsJvPluginCommands = Class(TCollection)
  Private
    FPlugin: THsJvPlugIn;

  Protected
    Function GetOwner() : TPersistent; OverRide;
    Procedure SetItemName(AItem : TCollectionItem); OverRide;

  Public
    Constructor Create(APlugIn : THsJvPlugIn);

  End;

Implementation

ResourceString
  RsEFmtResNotFound = 'Resource not found: %s';

//=== { TJvPlugin } ==========================================================

Constructor THsJvPlugIn.Create(AOwner : TComponent);
Begin
  // Create datamodule
  CreateNew(AOwner);
  DesignSize := Point(100, 100);

  // Create commands-collection
  FCommands := THsJvPluginCommands.Create(Self);

  FInstanceCount := 1;
  If (ClassType <> THsJvPlugIn) And Not (csDesigning In ComponentState) Then
  Begin
    If Not InitInheritedComponent(Self, THsJvPlugIn) Then
      Raise EResNotFound.CreateResFmt(@RsEFmtResNotFound, [ClassName]);

    If OldCreateOrder Then
      DoCreate;
  End;
End;

Destructor THsJvPlugIn.Destroy;
Begin
  Commands.Free;
  Inherited Destroy;
End;

Procedure THsJvPlugIn.SetCommands(NewValue : THsJvPluginCommands);
Begin
  FCommands.Assign(NewValue);
End;

// Show Versionsstring defined in JvPlugCommon

{function TJvPlugin.GetVersion: string;
begin
  Result := C_VersionString;
end;

procedure TJvPlugin.SetVersion(newValue: string);
begin
end;}

// Here the plugin should verify if it CAN be loaded (e.g. Main application implements correct interface,
//      Dongle is there....)

Function THsJvPlugIn.Initialize(Manager : TComponent; HostApplication : TApplication; FileName : String) : Boolean;
Begin
  Result    := True;
  FHostApplication := HostApplication;
  FFileName := FileName;
  FManager  := Manager;
  TriggerInitializeEvent(Result);
End;

Procedure THsJvPlugIn.Configure;
Begin
  TriggerConfigureEvent;
End;

Procedure THsJvPlugIn.TriggerPluginMessageEvent(APluginMessage : Longint; AMessageText : String);
Begin
  If Assigned(FOnPluginMessage) Then
    FOnPluginMessage(Self, APluginMessage, AMessageText);
End;

Procedure THsJvPlugIn.TriggerInitializeEvent(Var AllowLoad : Boolean);
Begin
  If Assigned(FOnInitialize) Then
    FOnInitialize(Self, AllowLoad);
End;

Procedure THsJvPlugIn.TriggerConfigureEvent;
Begin
  If Assigned(FOnConfigure) Then
    FOnConfigure(Self);
End;

Procedure THsJvPlugIn.SendPluginMessage(APluginMessage : Integer; AMessageText : String);
Begin
  TriggerPluginMessageEvent(APluginMessage, AMessageText);
End;

Procedure THsJvPlugIn.BroadcastMsgToALL(APluginMessage : Integer; AMessageText : String);
Begin
  // Remember, when called, this method will trigger assigned method within host, not within the plugin component.
  If Assigned(FOnBroadcastToAllMessage) Then
    FOnBroadcastToAllMessage(Self, APluginMessage, AMessageText);
End;

Procedure THsJvPlugIn.BroadcastMsgToALLObj(APluginMessage : Integer; AMessageText : String; AObj : TObject);
Begin
  // Remember, when called, this method will trigger assigned method within host, not within the plugin component.
  If Assigned(FOnBroadcastToAllMessageObj) Then
    FOnBroadcastToAllMessageObj(Self, APluginMessage, AMessageText, AObj);
End;

//=== { TJvPluginCommand } ===================================================

Constructor THsJvPluginCommand.Create(Collection : TCollection);
Begin
  Inherited Create(Collection);
  FBitmap   := TBitmap.Create;
  FShortCut := 0;
End;

Destructor THsJvPluginCommand.Destroy;
Begin
  FBitmap.Free;
  Inherited Destroy;
End;

Function THsJvPluginCommand.GetDisplayName : String;
Begin
  Result := Name;
  If Result = '' Then
    Result := Inherited GetDisplayName;
End;

Procedure THsJvPluginCommand.SetBitmap(Value : TBitmap);
Begin
  FBitmap.Assign(Value);
End;

//=== { TJvPluginCommands } ==================================================

Constructor THsJvPluginCommands.Create(APlugIn : THsJvPlugIn);
Begin
  Inherited Create(THsJvPluginCommand);
  FPlugin := APlugIn;
End;

Function THsJvPluginCommands.GetOwner : TPersistent;
Begin
  Result := FPlugin;
End;

Procedure THsJvPluginCommands.SetItemName(AItem : TCollectionItem);
Var
  I : Integer;
  J : Integer;

  Function NameUsed : Boolean;
  Var
    AName : String;
  Begin
    AName := Format('Command%d', [I]);
    J     := AItem.Collection.Count - 1;
    While (J > -1) And Not AnsiSameText(THsJvPluginCommand(AItem.Collection.Items[J]).Name, AName) Do
      Dec(J);
    Result := J > -1;
  End;

  Procedure FindCmdIdx;
  Begin
    I := 1;
    While (I < MaxInt) And NameUsed Do
      Inc(I);
  End;

Begin
  With THsJvPluginCommand(AItem) Do
    If Name = '' Then
    Begin
      FindCmdIdx;
      Name := Format('Command%d', [I]);
    End;
End;

End.

