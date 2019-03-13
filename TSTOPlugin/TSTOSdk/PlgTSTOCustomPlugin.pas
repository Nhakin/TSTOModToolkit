unit PlgTSTOCustomPlugin;

interface

uses
  HsInterfaceEx, TSTOPluginIntf,
  Windows, SysUtils, Classes;

type
  TTSTOCustomPlugin = Class(TDataModule, ITSTOPlugin)
  Private
    FMainApp        : ITSTOApplication;
    FPluginPath     : String;
    FPluginFileName : String;
    FInitialized    : Boolean;

    FEnabled        : Boolean;
    
  Protected
    //IInterfaceEx
    Function GetInterfaceObject() : TObject; Virtual;
    Function GetRefCount() : Integer; Virtual;

    Function  GetController() : IInterfaceEx; Virtual;
    Procedure SetController(AController : IInterfaceEx); Virtual; Abstract;

    Function  GetIsContained() : Boolean; Virtual;
    Procedure SetIsContained(Const AIsContained : Boolean); Virtual; Abstract;

    Function  GetHaveRefCount() : Boolean; Virtual;
    Procedure SetHaveRefCount(Const AHaveRefCount : Boolean); Virtual; Abstract;

    //ITSTOPlugin
    Function  GetInitialized() : Boolean; Virtual;

    Function  GetEnabled() : Boolean; Virtual;
    Procedure SetEnabled(Const AEnabled : Boolean); Virtual;

    Function  GetPluginKind() : TTSTOPluginKind; Virtual;

    Function  GetName() : String; Virtual;
    Function  GetAuthor() : String; Virtual;
    Function  GetCopyright() : String; Virtual;
    Function  GetDescription() : String; Virtual;
    Function  GetPluginId() : String; Virtual;
    Function  GetPluginVersion() : String; Virtual;
    Function  GetHaveSettings() : Boolean; Virtual;

    Function  GetMainApp() : ITSTOApplication;
    Function  GetPluginPath() : String;
    Function  GetPluginFileName() : String;

    Procedure Configure(); Virtual;
    Procedure Initialize(AMainApplication : ITSTOApplication); ReIntroduce; Virtual;
    Procedure Finalize(); Virtual;
    Function  ShowSettings() : Boolean; Virtual;
    Function  Execute() : Integer; Virtual; Abstract;

    Property MainApp        : ITSTOApplication Read GetMainApp;
    Property PluginPath     : String           Read GetPluginPath;
    Property PluginFileName : String           Read GetPluginFileName;
    Property Initialized    : Boolean          Read GetInitialized;
    Property Enabled        : Boolean          Read GetEnabled Write SetEnabled;
    Property PluginKind     : TTSTOPluginKind  Read GetPluginKind;

  Public
    Procedure AfterConstruction(); OverRide;

  End;

implementation

Uses
  SpTbxSkins, SpTbxAdditionalSkins;

{$R *.dfm}

Procedure TTSTOCustomPlugin.AfterConstruction();
Var lFileName : Array[0..MAX_PATH] Of Char;
Begin
  FillChar(lFileName, SizeOf(lFileName), #0);
  GetModuleFileName(hInstance, lFileName, SizeOf(lFileName));

  FPluginFileName := lFileName;
  FPluginPath     := ExtractFilePath(lFileName);
  FInitialized    := False;
End;

Function TTSTOCustomPlugin.GetInterfaceObject() : TObject;
Begin
  Result := Self;
End;

Function TTSTOCustomPlugin.GetRefCount() : Integer;
Begin
  Result := -1;
End;

Function TTSTOCustomPlugin.GetController() : IInterfaceEx;
Begin
  Result := Nil;
End;

Function TTSTOCustomPlugin.GetIsContained() : Boolean;
Begin
  Result := False;
End;

Function TTSTOCustomPlugin.GetHaveRefCount() : Boolean;
Begin
  Result := False;
End;

Function TTSTOCustomPlugin.GetInitialized() : Boolean;
Begin
  Result := FInitialized;
End;

Function TTSTOCustomPlugin.GetEnabled() : Boolean;
Begin
  Result := FEnabled;
End;

Procedure TTSTOCustomPlugin.SetEnabled(Const AEnabled : Boolean);
Begin
  FEnabled := AEnabled;
End;

Function TTSTOCustomPlugin.GetPluginKind() : TTSTOPluginKind;
Begin
  Result := pkScript;
End;

Function TTSTOCustomPlugin.GetName() : String;
Begin
  Result := 'TTSTOCustomPlugin';
End;

Function TTSTOCustomPlugin.GetAuthor() : String;
Begin
  Result := 'KahnAbyss';
End;

Function TTSTOCustomPlugin.GetCopyright() : String;
Begin
  Result := 'Copyright © 2003-2019 by HellSpawn; all rights reserved.';
End;

Function TTSTOCustomPlugin.GetDescription() : String;
Begin
  Result := 'Plugin Description';
End;

Function TTSTOCustomPlugin.GetPluginId() : String;
Begin
  Result := 'TSTOModToolKit.PlgTSTOCustomPlugin';
End;

Function TTSTOCustomPlugin.GetPluginVersion() : String;
Begin
  Result := '1.0.0.0';
End;

Function TTSTOCustomPlugin.GetHaveSettings() : Boolean;
Begin
  Result := False;
End;

Function TTSTOCustomPlugin.GetMainApp() : ITSTOApplication;
Begin
  Result := FMainApp;
End;

Function TTSTOCustomPlugin.GetPluginPath() : String;
Begin
  Result := FPluginPath;
End;

Function TTSTOCustomPlugin.GetPluginFileName() : String;
Begin
  Result := FPluginFileName;
End;

Procedure TTSTOCustomPlugin.Configure();
Begin

End;

Procedure TTSTOCustomPlugin.Initialize(AMainApplication: ITSTOApplication);
Begin
  If Not FInitialized Then
  Begin
    FMainApp := AMainApplication;

    If Assigned(FMainApp) Then
    Begin
      SkinManager.SetSkin(MainApp.CurrentSkinName);
      FInitialized := True;
    End;
  End;
End;

Procedure TTSTOCustomPlugin.Finalize();
Begin
  If FInitialized Then
  Begin

    FInitialized := False;
  End;
End;

Function TTSTOCustomPlugin.ShowSettings() : Boolean;
Begin
  Result := False;
End;

end.
