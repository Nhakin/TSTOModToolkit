unit DlgTSTOPluginDemoSettings;

interface

uses
  TSTOPluginIntf,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TB2Dock, TB2Toolbar, SpTBXItem, ImgList, TB2Item, StdCtrls;

type
  TTSTOPluginDemoSettingsDlg = class(TForm)
    chkEnabled: TCheckBox;
    SpTBXBItemContainer1: TSpTBXBItemContainer;
    tbPopupMenuItems: TSpTBXSubmenuItem;
    tbSavePlugins: TSpTBXItem;
    imgToolBar: TImageList;
    sptbxDckMain: TSpTBXDock;
    sptbxtbMain: TSpTBXToolbar;
    chkAddMenuItem: TCheckBox;
    chkAddToolBarButton: TCheckBox;

    procedure tbSavePluginsClick(Sender: TObject);
    procedure chkEnabledClick(Sender: TObject);

  Private
    FMainApp : ITSTOApplication;

    Procedure SetMainApp(AMainApp : ITSTOApplication);

    Function  GetPluginEnabled() : Boolean;
    Procedure SetPluginEnabled(Const APluginEnabled : Boolean);

    Function  GetAddMenuItem() : Boolean;
    Procedure SetAddMenuItem(Const AAddMenuItem : Boolean);

    Function  GetAddToolBarButton() : Boolean;
    Procedure SetAddToolBarButton(Const AAddToolBarButton : Boolean);

  Public
    Property MainApp          : ITSTOApplication Read FMainApp Write SetMainApp;

    Property PluginEnabled    : Boolean Read GetPluginEnabled    Write SetPluginEnabled;
    Property AddMenuItem      : Boolean Read GetAddMenuItem      Write SetAddMenuItem;
    Property AddToolBarButton : Boolean Read GetAddToolBarButton Write SetAddToolBarButton;

  end;

implementation

Uses HsStreamEx;

{$R *.dfm}

procedure TTSTOPluginDemoSettingsDlg.tbSavePluginsClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

Procedure TTSTOPluginDemoSettingsDlg.SetMainApp(AMainApp : ITSTOApplication);
Var lMemStrm : IMemoryStreamEx;
Begin
  FMainApp := AMainApp;

  If Assigned(FMainApp) Then
  Begin
    lMemStrm := TMemoryStreamEx.Create();
    Try
      FMainApp.Icon.SaveToStream(TStream(lMemStrm.InterfaceObject));
      lMemStrm.Position := 0;
      Icon.LoadFromStream(TStream(lMemStrm.InterfaceObject));
      
      Finally
        lMemStrm := Nil;
    End;
  End;
End;

Function TTSTOPluginDemoSettingsDlg.GetPluginEnabled() : Boolean;
Begin
  Result := chkEnabled.Checked;
End;

Procedure TTSTOPluginDemoSettingsDlg.SetPluginEnabled(Const APluginEnabled : Boolean);
Begin
  chkEnabled.Checked := APluginEnabled;

  chkAddMenuItem.Enabled      := APluginEnabled;
  chkAddToolBarButton.Enabled := APluginEnabled;
End;

procedure TTSTOPluginDemoSettingsDlg.chkEnabledClick(Sender: TObject);
begin
  chkAddMenuItem.Enabled      := chkEnabled.Checked;
  chkAddToolBarButton.Enabled := chkEnabled.Checked;
end;

Function TTSTOPluginDemoSettingsDlg.GetAddMenuItem() : Boolean;
Begin
  Result := chkAddMenuItem.Checked;
End;

Procedure TTSTOPluginDemoSettingsDlg.SetAddMenuItem(Const AAddMenuItem : Boolean);
Begin
  chkAddMenuItem.Checked := AAddMenuItem;
End;

Function TTSTOPluginDemoSettingsDlg.GetAddToolBarButton() : Boolean;
Begin
  Result := chkAddToolBarButton.Checked;
End;

Procedure TTSTOPluginDemoSettingsDlg.SetAddToolBarButton(Const AAddToolBarButton : Boolean);
Begin
  chkAddToolBarButton.Checked := AAddToolBarButton;
End;

end.
