unit TSTOShellMain;

interface

uses
    Windows,
    Messages,
    SysUtils,
    Classes,
    Forms,
    Graphics,
    SxComObj,
    SxDataModule, Vcl.Menus, SxPopupMenu, SxCustShlObj, SxContextMenu,
    SxFileClasses, System.ImageList, Vcl.ImgList, Vcl.Controls, SxPropertySheetExt,
    TSTORgbPropPage, SxThumbnailProvider, SxExtractImage;

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
    SxFileClasses: TSxFileClasses;
    SxThumbnailProvider: TSxThumbnailProvider;
    procedure SxPopupMenuPopup(Sender: TObject);
    procedure SxShellPropSheetExtAddPropSheet(Sender: TSxShellPropSheetExt;
      PropSheetClass: TFormClass; var AllowInsert: Boolean);
    procedure SxThumbnailProviderGetThumbnail(Sender: TSxThumbnailProvider;
      CX: Integer; Image: TBitmap; var HasAlphaChannel: Boolean);
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  end;

implementation

uses Dialogs,
  TSTORgb, ComServ;

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

procedure TSxModule1.SxThumbnailProviderGetThumbnail(
  Sender: TSxThumbnailProvider; CX: Integer; Image: TBitmap;
  var HasAlphaChannel: Boolean);
type
  TRGBQ = array  [word] of TRGBQuad;
var i: Integer;
    h: Integer;
    top: Integer;
    c: TCanvas;
    q: ^TRGBQ;
    lRgb : ITSTORgbFile;
    lH, lW : Integer;
begin
  If SameText(ExtractFileExt(SxThumbnailProvider.FileName), '.rgb') Then
  Begin
{
    lRgb := TTSTORgbFile.CreateRGBFile();
    Try
      Image.Width  := CX;
      Image.Height := CX * 3 Div 4;

      lRgb.LoadRgbFromFile(SxThumbnailProvider.FileName);
      Image.Assign(lRgb.Picture);

      Finally
        lRgb := Nil;
    End;
}
//(*
    HasAlphaChannel := False;

    Image.width:=CX;
    image.height:=Cx*3 div 4;
    Image.PixelFormat := pf32bit;
    Image.AlphaFormat := afDefined;
    HasAlphaChannel := True;

    C := Image.Canvas;

    C.Font.Name:='Arial';
    C.Font.Size:=9;


    top := 0;
    h := C.TextHeight('A');

    // Out some text
    for i := 0 to 3 do
    begin
      c.TextOut(0,TOP,'TSTORgb');
      INC(TOP, H);
    end;

    // Add transparency gradient. Top is solid, bottom is transparent
    for I := 0 to Image.Height-1 do
    begin
      q:= Image.ScanLine[i];
      for H := 0 to Image.Width-1 do
        q^[H].rgbReserved := 255 - (I * 255) div image.Height;
    end;
//*)
  End;
end;

initialization
  RegisterSxDataModule(ComServer,TSxModule1);

end.
