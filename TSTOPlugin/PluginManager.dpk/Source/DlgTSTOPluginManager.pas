unit DlgTSTOPluginManager;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList, TB2Dock,
  TB2Toolbar, SpTBXItem, TB2Item, SpTBXDkPanels, SpTBXControls, SpTBXExPanel;

type
  TTSTOPluginManagerDlg = class(TForm)
    imgToolBar: TImageList;
    SpTBXBItemContainer1: TSpTBXBItemContainer;
    tbPopupMenuItems: TSpTBXSubmenuItem;
    tbSavePlugins: TSpTBXItem;
    sptbxDckMain: TSpTBXDock;
    sptbxtbMain: TSpTBXToolbar;
    SpTBXExPanel1: TSpTBXExPanel;
    SpTBXStatusBar1: TSpTBXStatusBar;
    SpTBXSplitter1: TSpTBXSplitter;
    SpTBXExPanel2: TSpTBXExPanel;

    procedure tbSavePluginsClick(Sender: TObject);

  private

  public

  end;

implementation

{$R *.dfm}

procedure TTSTOPluginManagerDlg.tbSavePluginsClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

end.
