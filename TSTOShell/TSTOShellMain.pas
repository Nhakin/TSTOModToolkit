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
  ExtCtrls, TSTORgb,
  ImagingClasses, ImagingComponents, ImagingRgb, Imaging, ImagingTypes, ImagingCanvases, ComServ;

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
    lRgb2 : TImageData;
    lStrm : TMemoryStream;
    lFName : String;
    lImage : TImage;

    lRgb3 : TSingleImage;
    lCanvas : TImagingCanvas;
begin
  With TStringList.Create() Do
  Try
    if FileExists('00-Debug.log') then
      LoadFromFile('00-Debug.log');
    Add('SxThumbnailProviderGetThumbnail : ' + SxThumbnailProvider.FileName);
    SaveToFile('00-Debug.log');

    Finally
      Free();
  End;

  lFName := SxThumbnailProvider.FileName;
  If lFName = '' Then
    lFName := 'C:\Projects\casinostore.rgb';

  If FileExists(lFName) Then
    If LoadImageFromFile(lFName, lRgb2) Then
    Try
      Image.Width  := CX;
      Image.Height := CX * 3 Div 4;
      Image.PixelFormat := pf32bit;
      Image.AlphaFormat := afDefined;
      HasAlphaChannel := True;

      If lRgb2.Height > lRgb2.Width Then
      Begin
        lH := Image.Height;
        lW := Round(lH / lRgb2.Height * lH);
      End
      Else If lRgb2.Width > lRgb2.Height Then
      Begin
        lW := Image.Width;
        lH := Round(lW / lRgb2.Width * lW);
      End
      Else
      Begin
        lW := Image.Width;
        lH := Image.Height;
      End;

      If lH > Image.Height Then
        lH := Image.Height;
      If lW > Image.Width Then
        lW := Image.Width;

      If (lW > 0) And (lH > 0) Then
        ResizeImage(lRgb2, lW, lH, rfLanczos);

      DisplayImageData(Image.Canvas, Rect(0, 0, lW, lH), lRgb2, Rect(0, 0, lW, lH));

      Finally
        FreeImage(lRgb2);
    End;
end;

initialization
  RegisterSxDataModule(ComServer,TSxModule1);

end.
