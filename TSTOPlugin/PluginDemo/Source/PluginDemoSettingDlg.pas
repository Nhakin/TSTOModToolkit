unit PluginDemoSettingDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TB2Dock, TB2Toolbar, SpTBXItem, ImgList, TB2Item, StdCtrls;

type
  TDlgPluginDemoSetting = class(TForm)
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
    Function  GetPluginEnabled() : Boolean;
    Procedure SetPluginEnabled(Const APluginEnabled : Boolean);

    Function  GetAddMenuItem() : Boolean;
    Procedure SetAddMenuItem(Const AAddMenuItem : Boolean);

    Function  GetAddToolBarButton() : Boolean;
    Procedure SetAddToolBarButton(Const AAddToolBarButton : Boolean);

  Public
    Property PluginEnabled    : Boolean Read GetPluginEnabled    Write SetPluginEnabled;
    Property AddMenuItem      : Boolean Read GetAddMenuItem      Write SetAddMenuItem;
    Property AddToolBarButton : Boolean Read GetAddToolBarButton Write SetAddToolBarButton;

  end;

implementation

{$R *.dfm}

procedure TDlgPluginDemoSetting.tbSavePluginsClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

Function TDlgPluginDemoSetting.GetPluginEnabled() : Boolean;
Begin
  Result := chkEnabled.Checked;
End;

Procedure TDlgPluginDemoSetting.SetPluginEnabled(Const APluginEnabled : Boolean);
Begin
  chkEnabled.Checked := APluginEnabled;
End;

procedure TDlgPluginDemoSetting.chkEnabledClick(Sender: TObject);
begin
  chkAddMenuItem.Enabled      := chkEnabled.Checked;
  chkAddToolBarButton.Enabled := chkEnabled.Checked;
end;

Function TDlgPluginDemoSetting.GetAddMenuItem() : Boolean;
Begin
  Result := chkAddMenuItem.Checked;
End;

Procedure TDlgPluginDemoSetting.SetAddMenuItem(Const AAddMenuItem : Boolean);
Begin
  chkAddMenuItem.Checked := AAddMenuItem;
End;

Function TDlgPluginDemoSetting.GetAddToolBarButton() : Boolean;
Begin
  Result := chkAddToolBarButton.Checked;
End;

Procedure TDlgPluginDemoSetting.SetAddToolBarButton(Const AAddToolBarButton : Boolean);
Begin
  chkAddToolBarButton.Checked := AAddToolBarButton;
End;

end.
