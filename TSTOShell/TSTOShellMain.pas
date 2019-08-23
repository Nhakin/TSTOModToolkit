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
    PopTSTOToolkit: TMenuItem;
    PopConvertToPng: TMenuItem;
    PopConvertToRGB444: TMenuItem;
    ImageList: TImageList;
    N1: TMenuItem;
    N2: TMenuItem;
    SxShellPropSheetExt: TSxShellPropSheetExt;
    PopConvertToRGB888: TMenuItem;
    procedure SxPopupMenuPopup(Sender: TObject);
    procedure SxShellPropSheetExtAddPropSheet(Sender: TSxShellPropSheetExt;
      PropSheetClass: TFormClass; var AllowInsert: Boolean);
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
  PopTSTOToolkit.Visible  := SameText(ExtractFileExt(SxContextMenu.FileName), '.png') Or
                             SameText(ExtractFileExt(SxContextMenu.FileName), '.rgb');
  PopConvertToPng.Enabled := Not SameText(ExtractFileExt(SxContextMenu.FileName), '.png');
end;

procedure TSxModule1.SxShellPropSheetExtAddPropSheet(
  Sender: TSxShellPropSheetExt; PropSheetClass: TFormClass;
  var AllowInsert: Boolean);
begin
  AllowInsert := (PropSheetClass = TTSTORgbPropSheet) And
                 SameText(ExtractFileExt(Sender.FileName), '.rgb');
end;

initialization
  RegisterSxDataModule(ComServer,TSxModule1);

end.
