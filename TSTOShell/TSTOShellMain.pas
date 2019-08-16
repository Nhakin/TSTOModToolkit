unit TSTOShellMain;

interface

uses
    Windows,
    Messages,
    SysUtils,
    Classes,
    Forms,
    SxComObj,
    SxDataModule, Vcl.Menus, SxPopupMenu, SxCustShlObj, SxContextMenu,
    SxFileClasses, System.ImageList, Vcl.ImgList, Vcl.Controls, SxPropertySheetExt,
    TSTORgbPropPage;

type
  TSxModule1 = class(TSxModule)
    SxContextMenu: TSxContextMenu;
    SxPopupMenu: TSxPopupMenu;
    STOToolkit1: TMenuItem;
    ConvertToPng1: TMenuItem;
    ConvertToRGB4441: TMenuItem;
    SxFileClasses: TSxFileClasses;
    ImageList: TImageList;
    N1: TMenuItem;
    N2: TMenuItem;
    SxShellPropSheetExt: TSxShellPropSheetExt;
    procedure SxPopupMenuPopup(Sender: TObject);
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  end;

implementation

uses Dialogs,
  ComServ;

{$R *.DFM}

procedure TSxModule1.SxPopupMenuPopup(Sender: TObject);
begin
  SxPopupMenu.Items[1].Visible := SameText(ExtractFileExt(SxContextMenu.FileName), '.png') Or
                                  SameText(ExtractFileExt(SxContextMenu.FileName), '.rgb');
end;

initialization
  RegisterSxDataModule(ComServer,TSxModule1);

end.
