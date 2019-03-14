unit PlgTSTOPluginManager;

interface

uses
  TSTOPluginIntf, TSTOPluginManagerIntf, TSTOCustomPatches.IO, TSTOScriptTemplate.IO,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PlgTSTOCustomPlugin, SpTBXItem, TB2Item;

type
  TTSTOPluginManager = class(TTSTOCustomPlugin, ITSTOPluginManager)
    SpTBXBItemContainer1: TSpTBXBItemContainer;
    grpPluginManagerMenuItem: TSpTBXTBGroupItem;
    SpTBXSeparatorItem1: TSpTBXSeparatorItem;
    mnuPluginManager: TSpTBXItem;

    procedure mnuPluginManagerClick(Sender: TObject);
        
  Private
    FPluginList : ITSTOPlugins;
    FPlgPatches : ITSTOPlugins;
    FPlgScripts : ITSTOPlugins;
  
    Procedure RefreshPluginList();
    Procedure LoadPlugin(Const AFileName : String);

  Protected
    Procedure Initialize(AMainApplication : ITSTOApplication); OverRide;
    Procedure Finalize(); OverRide;

    Function  GetName() : String; OverRide;
    Function  GetDescription() : String; OverRide;
    Function  GetPluginId() : String; OverRide;
    Function  GetPluginVersion() : String; OverRide;

    Function GetPlugins() : ITSTOPlugins;
    Function GetCustomPatchesPlugins() : ITSTOCustomPatchesIO;
    Function GetScriptsTemplatePlugins() : ITSTOScriptTemplateHacksIO;

  public
    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;

  end;

Function CreatePluginManager(AHostApplication : TApplication; AApplication : ITSTOApplication) : ITSTOPluginManager;

Exports
  CreatePluginManager;

implementation

Uses
  {SpTbxSkins, SpTbxAdditionalSkins,} DlgTSTOPluginManager;

{$R *.dfm}

Function CreatePluginManager(AHostApplication : TApplication; AApplication : ITSTOApplication) : ITSTOPluginManager;
Begin
  Result := TTSTOPluginManager.Create(Nil);
  Result.Configure();
  Result.Initialize(AApplication);
End;

Procedure TTSTOPluginManager.AfterConstruction();
Begin
  InHerited AfterConstruction();

  FPluginList := TTSTOPlugins.CreatePluginList();
End;

Procedure TTSTOPluginManager.BeforeDestruction();
Begin
  Finalize();

  InHerited BeforeDestruction();
End;

Procedure TTSTOPluginManager.LoadPlugin(Const AFileName : String);
Var lModule : HWnd;
    X       : Integer;
    lCreatePlg : Function() : ITSTOPlugin;
    lPlugin : ITSTOPlugin;
Begin
  If FileExists(AFileName) Then
  Begin
    lModule := SafeLoadLibrary(AFileName);
    If lModule <> 0 Then
    Begin
      lCreatePlg := GetProcAddress(lModule, 'CreateTSTOPlugin');
      If Assigned(lCreatePlg) Then
      Begin
        lPlugin := lCreatePlg();
        lPlugin.Configure();
        lPlugin.Initialize(MainApp);
        FPluginList.Add(lPlugin);
      End;
    End;
  End;
End;

Procedure TTSTOPluginManager.RefreshPluginList();
  Procedure InternalListPlugins(AStartPath : String; ALvl : Integer);
  Var lSr : TSearchRec;
  Begin
    If FindFirst(AStartPath + '*.*', faAnyFile, lSr) = 0 Then
    Try
      Repeat
        If (lSr.Attr And faDirectory = faDirectory) And (lSr.Name <> '.') And (lSr.Name <> '..') And (ALvl < 1) Then
          InternalListPlugins(AStartPath + lSr.Name + '\', ALvl + 1)
        Else If SameText(ExtractFileExt(lSr.Name), '.dll') And (ALvl = 1) Then
          LoadPlugin(AStartPath + lSr.Name);
      Until FindNext(lSr) <> 0;

      Finally
        FindClose(lSr);
    End;
  End;

Var X : Integer;
    lPlugin : ITSTOPlugin;
Begin
  For X := 0 To FPluginList.Count - 1 Do
    FPluginList[X].Finalize();
  FPluginList.Clear();
  
  InternalListPlugins(ExtractFilePath(ParamStr(0)) + 'Plugins\', 0);
End;

Procedure TTSTOPluginManager.Initialize(AMainApplication : ITSTOApplication);
Var lMnu    : TComponent;
    lPlugin : ITSTOPlugin;
    X       : Integer;
Begin
  InHerited Initialize(AMainApplication);

  If Initialized Then
  Begin
    lMnu := MainApp.Host.MainForm.FindComponent('mnuPlugins');
    If Assigned(lMnu) And SameText(lMnu.ClassName, 'TSpTBXSubmenuItem') Then
      MainApp.AddItem(Self, grpPluginManagerMenuItem, TTBCustomItem(lMnu));

    RefreshPluginList();
  End;
End;

Procedure TTSTOPluginManager.Finalize();
Begin
  If Initialized Then
  Begin
    If Assigned(FPluginList) Then
    Begin
      FPluginList.Clear();
      FPluginList := Nil;
    End;

    If Assigned(FPlgPatches) Then
    Begin
      FPlgPatches.Clear();
      FPlgPatches := Nil;
    End;

    If Assigned(FPlgScripts) Then
    Begin
      FPlgScripts.Clear();
      FPlgScripts := Nil;
    End;
  End;

  InHerited Finalize();
End;

Function TTSTOPluginManager.GetName() : String;
Begin
  Result := 'TSTOPluginManager';
End;

Function TTSTOPluginManager.GetDescription() : String;
Begin
  Result := 'TSTO Plugin Manager';
End;

Function TTSTOPluginManager.GetPluginId() : String;
Begin
  Result := 'TSTOToolKit.PlgTSTOPluginManager';
End;

Function TTSTOPluginManager.GetPluginVersion() : String;
Begin
  Result := '1.0.0.1';
End;

procedure TTSTOPluginManager.mnuPluginManagerClick(Sender: TObject);
begin
  With TTSTOPluginManagerDlg.Create(Self) Do
  Try
    Plugins := FPluginList;
    MainApp := Self.MainApp;

    ShowModal();

    Finally
      Release();
  End;
end;

Function TTSTOPluginManager.GetPlugins() : ITSTOPlugins;
Begin
  Result := FPluginList;
End;

Function TTSTOPluginManager.GetCustomPatchesPlugins() : ITSTOCustomPatchesIO;
Var X : Integer;
Begin
  If Not Assigned(FPlgPatches) Then
    FPlgPatches := TTSTOPlugins.CreatePluginList();

  FPlgPatches.Clear();
  For X := 0 To FPluginList.Count - 1 Do
    If FPluginList[X].PluginKind = pkPatches Then
      FPlgPatches.Add(FPluginList[X]);

//  Result := FPlgPatches;
End;

Function TTSTOPluginManager.GetScriptsTemplatePlugins() : ITSTOScriptTemplateHacksIO;
Var X : Integer;
Begin
  If Not Assigned(FPlgScripts) Then
    FPlgScripts := TTSTOPlugins.CreatePluginList();

  FPlgScripts.Clear();
  For X := 0 To FPluginList.Count - 1 Do
    If FPluginList[X].PluginKind = pkPatches Then
      FPlgScripts.Add(FPluginList[X]);

//  Result := FPlgScripts;
End;

end.
