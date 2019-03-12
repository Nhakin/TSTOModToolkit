unit PlgTSTOPluginManager;

interface

uses
  TSTOPluginIntf, TSTOPluginManagerIntf, TSTOCustomPatches.IO, TSTOScriptTemplate.IO,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PlgTSTOCustomPlugin, SpTBXItem, TB2Item, JvComponentBase,
  JvPluginManager;

type
  TTSTOPluginManager = class(TTSTOCustomPlugin, ITSTOPluginManager)
    JvPluginManager1: TJvPluginManager;
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

  Protected
    Procedure Initialize(AMainApplication : ITSTOApplication); OverRide;
    Procedure Finalize(); OverRide;

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
  JvPlugin, SpTbxSkins, SpTbxAdditionalSkins, DlgTSTOPluginManager;
  
{$R *.dfm}

Function CreatePluginManager(AHostApplication : TApplication; AApplication : ITSTOApplication) : ITSTOPluginManager;
Var lPlug : TJvPlugIn;
Begin
  lPlug := TTSTOPluginManager.Create(Nil);
  lPlug.Configure();
  lPlug.Initialize(Nil, AHostApplication, '');
  If lPlug.GetInterface(ITSTOPluginManager, Result) Then
    Result.Initialize(AApplication);
End;

Procedure TTSTOPluginManager.AfterConstruction();
Begin
  InHerited AfterConstruction();

  RefreshPluginList();
End;

Procedure TTSTOPluginManager.BeforeDestruction();
Begin
  Finalize();

  InHerited BeforeDestruction();
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
          JvPluginManager1.LoadPlugin(AStartPath + lSr.Name, plgDLL);
      Until FindNext(lSr) <> 0;

      Finally
        FindClose(lSr);
    End;
  End;

Var X : Integer;
    lPlugin : ITSTOPlugin;
Begin
  For X := JvPluginManager1.PluginCount - 1 DownTo 0 Do
  Begin
    If JvPluginManager1.Plugins[X].GetInterface(ITSTOPlugin, lPlugin) Then
      lPlugin.Finalize();
    JvPluginManager1.UnloadPlugin(X);
  End;

  InternalListPlugins(ExtractFilePath(ParamStr(0)) + 'Plugins\', 0);

  For X := 0 To JvPluginManager1.PluginCount - 1 Do
    JvPluginManager1.Plugins[X].Configure();
End;

Procedure TTSTOPluginManager.Initialize(AMainApplication : ITSTOApplication);
Var lMnu    : TComponent;
    lPlugin : ITSTOPlugin;
    X       : Integer;
Begin
  InHerited Initialize(AMainApplication);

  If Initialized Then
  Begin
    FPluginList := TTSTOPlugins.CreatePluginList();

    For X := 0 To JvPluginManager1.PluginCount - 1 Do
      If JvPluginManager1.Plugins[X].GetInterface(ITSTOPlugin, lPlugin) Then
      Begin
        lPlugin.Initialize(MainApp);
        FPluginList.Add(lPlugin);
      End;

    lMnu := HostApplication.MainForm.FindComponent('mnuPlugins');
    If Assigned(lMnu) And SameText(lMnu.ClassName, 'TSpTBXSubmenuItem') Then
      MainApp.AddItem(Self, grpPluginManagerMenuItem, TTBCustomItem(lMnu));

    SkinManager.SetSkin(MainApp.CurrentSkinName);
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

procedure TTSTOPluginManager.mnuPluginManagerClick(Sender: TObject);
begin
  With TTSTOPluginManagerDlg.Create(Self) Do
  Try
    Plugins := FPluginList;
    MainApp := Self.MainApp;

    If ShowModal() = mrOk Then
    Begin

    End;

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
