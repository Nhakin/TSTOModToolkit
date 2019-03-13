unit PlgTSTOPluginDemo;

interface

uses
  TSTOPluginIntf,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PlgTSTOCustomPlugin, ImgList, TB2Item, SpTBXItem;

type
  TTSTOPluginDemo = class(TTSTOCustomPlugin)
    SpTBXBItemContainer1: TSpTBXBItemContainer;
    SpTbxPluginDemo: TSpTBXItem;
    SpTbxSubMenu: TSpTBXSubmenuItem;
    SpTbxPlay: TSpTBXItem;
    SpTbxStop: TSpTBXItem;
    SpTBXSeparatorItem1: TSpTBXSeparatorItem;
    SpTbxChildSubMenu: TSpTBXSubmenuItem;
    SpTbxPlayAnimation: TSpTBXItem;
    SpTbxStopAnimation: TSpTBXItem;
    SpTBXSeparatorItem2: TSpTBXSeparatorItem;
    GrpPluginDemo: TSpTBXTBGroupItem;
    GrpPluginDemoItems: TSpTBXTBGroupItem;
    SpTBXGrpSingleItem: TSpTBXItem;
    SpTbxGrpSubMenu: TSpTBXSubmenuItem;
    SpTBXGrpSubItem1: TSpTBXItem;
    SpTBXGrpSubItem2: TSpTBXItem;
    ilMain: TImageList;

    procedure TSTOPluginDemoDestroy(Sender: TObject);

    procedure SpTbxPluginDemoClick(Sender: TObject);
    procedure SpTbxPlayAnimationClick(Sender: TObject);
    procedure SpTbxStopAnimationClick(Sender: TObject);

  Private
    FAddMenuItem      : Boolean;
    FAddToolBarButton : Boolean;

    Procedure InitUI();
    Procedure LoadSettings();
    Procedure SaveSettings();

  Protected
    Function  GetPluginKind() : TTSTOPluginKind; OverRide;
    Function  GetHaveSettings() : Boolean; OverRide;

    Function  GetName() : String; OverRide;
    Function  GetDescription() : String; OverRide;
    Function  GetPluginId() : String; OverRide;
    Function  GetPluginVersion() : String; OverRide;
    
    Procedure Configure();
    Procedure Initialize(AMainApplication : ITSTOApplication); OverRide;
    Procedure Finalize(); OverRide;
    Function  ShowSettings() : Boolean; OverRide;

  end;

Function CreateTSTOPlugin(AApplication : ITSTOApplication) : ITSTOPlugin;

implementation

Uses IniFiles, DlgTSTOPluginDemoSettings;

{$R *.dfm}

Function CreateTSTOPlugin(AApplication : ITSTOApplication) : ITSTOPlugin;
Begin
  Result := TTSTOPluginDemo.Create(Nil);
End;

Procedure TTSTOPluginDemo.Initialize(AMainApplication: ITSTOApplication);
Begin
  InHerited Initialize(AMainApplication);

  If Initialized Then
    InitUI();
End;

Procedure TTSTOPluginDemo.Finalize();
Begin
  If Initialized Then
  Begin
    MainApp.RemoveItem(iikToolBar, Self, SpTbxPluginDemo);
    MainApp.RemoveItem(iikToolBar, Self, SpTbxSubMenu);
    MainApp.RemoveItem(iikToolBar, Self, GrpPluginDemoItems);

    MainApp.RemoveItem(iikMainMenu, Self, SpTbxPluginDemo);
    MainApp.RemoveItem(iikMainMenu, Self, SpTbxSubMenu);
    MainApp.RemoveItem(iikMainMenu, Self, GrpPluginDemoItems);
  End;

  InHerited Finalize();
End;

Function TTSTOPluginDemo.GetPluginKind() : TTSTOPluginKind;
Begin
  Result := pkGUI;
End;

Function TTSTOPluginDemo.GetHaveSettings() : Boolean;
Begin
  Result := True;
End;

Function TTSTOPluginDemo.ShowSettings() : Boolean;
Begin
  Result := InHerited ShowSettings();

  With TTSTOPluginDemoSettingsDlg.Create(Self) Do
  Try
    MainApp          := Self.MainApp;
    PluginEnabled    := Self.Enabled;
    AddMenuItem      := FAddMenuItem;
    AddToolBarButton := FAddToolBarButton;

    If ShowModal() = mrOk Then
    Begin
      Result := (Self.Enabled <> PluginEnabled) Or
                (FAddMenuItem <> AddMenuItem) Or
                (FAddToolBarButton <> AddToolBarButton);

      Self.Enabled      := PluginEnabled;
      FAddMenuItem      := AddMenuItem;
      FAddToolBarButton := AddToolBarButton;

      If Result Then
        SaveSettings();
    End;

    Finally
      Release();
  End;
End;

procedure TTSTOPluginDemo.SpTbxPlayAnimationClick(Sender: TObject);
begin
  inherited;

  ShowMessage('Play Animation');
end;

procedure TTSTOPluginDemo.SpTbxPluginDemoClick(Sender: TObject);
begin
  inherited;

  ShowMessage('Plugin Demo');
end;

procedure TTSTOPluginDemo.SpTbxStopAnimationClick(Sender: TObject);
begin
  inherited;

  ShowMessage('Stop Animation');
end;

Function TTSTOPluginDemo.GetName() : String;
Begin
  Result := 'TSTOPluginDemo';
End;

Function TTSTOPluginDemo.GetDescription() : String;
Begin
  Result := 'Add buttons and menu item to main application';
End;

Function TTSTOPluginDemo.GetPluginId() : String;
Begin
  Result := 'TSTOModToolKit.PlgTSTOPluginDemo';
End;

Function TTSTOPluginDemo.GetPluginVersion() : String;
Begin
  Result := '1.0.0.2';
End;

procedure TTSTOPluginDemo.Configure();
begin
  LoadSettings();

  InHerited;
end;

procedure TTSTOPluginDemo.TSTOPluginDemoDestroy(Sender: TObject);
begin
  SaveSettings();

  InHerited;
end;

Procedure TTSTOPluginDemo.InitUI();
Begin
  MainApp.RemoveItem(iikToolBar, Self, SpTbxPluginDemo);
  MainApp.RemoveItem(iikToolBar, Self, SpTbxSubMenu);
  MainApp.RemoveItem(iikToolBar, Self, GrpPluginDemoItems);

  MainApp.RemoveItem(iikMainMenu, Self, SpTbxPluginDemo);
  MainApp.RemoveItem(iikMainMenu, Self, SpTbxSubMenu);
  MainApp.RemoveItem(iikMainMenu, Self, GrpPluginDemoItems);

  If Enabled Then
  Begin
    If FAddToolBarButton Then
    Begin
      MainApp.AddItem(iikToolBar, Self, SpTbxPluginDemo);
      MainApp.AddItem(iikToolBar, Self, SpTbxSubMenu);
      MainApp.AddItem(iikToolBar, Self, GrpPluginDemoItems);
    End;

    If FAddMenuItem Then
    Begin
      MainApp.AddItem(iikMainMenu, Self, SpTbxPluginDemo);
      MainApp.AddItem(iikMainMenu, Self, SpTbxSubMenu);
      MainApp.AddItem(iikMainMenu, Self, GrpPluginDemoItems);
    End;
  End;
End;

Procedure TTSTOPluginDemo.LoadSettings();
Var lIni : TIniFile;
Begin
  lIni := TIniFile.Create(ChangeFileExt(PluginFileName, '.cfg'));
  Try
    Enabled           := lIni.ReadBool(Self.Name, 'Enabled', True);
    FAddMenuItem      := lIni.ReadBool(Self.Name, 'AddMenuItem', True);
    FAddToolBarButton := lIni.ReadBool(Self.Name, 'AddToolBarButton', True);

    Finally
      lIni.Free();
  End;
End;

Procedure TTSTOPluginDemo.SaveSettings();
Var lIni : TIniFile;
Begin
  lIni := TIniFile.Create(ChangeFileExt(PluginFileName, '.cfg'));
  Try
    lIni.WriteBool(Self.Name, 'Enabled', Enabled);
    lIni.WriteBool(Self.Name, 'AddMenuItem', FAddMenuItem);
    lIni.WriteBool(Self.Name, 'AddToolBarButton', FAddToolBarButton);

    Finally
      lIni.Free();
  End;
End;

end.
