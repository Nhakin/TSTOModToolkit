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
    TSTORgbPropPage, SxThumbnailProvider, SxExtractImage, SxConst;

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
    SxExtractImage: TSxExtractImage;
    procedure SxPopupMenuPopup(Sender: TObject);
    procedure SxShellPropSheetExtAddPropSheet(Sender: TSxShellPropSheetExt;
      PropSheetClass: TFormClass; var AllowInsert: Boolean);
    procedure SxExtractImageExtractImage(Sender: TSxExtractImage;
      Image: TBitmap; Size: TSxSize);
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  end;

implementation

uses Dialogs,
  ExtCtrls,
  ImagingClasses, ImagingComponents, ImagingRgb, Imaging, ImagingTypes, ImagingCanvases, ComServ;

{$R *.DFM}

procedure TSxModule1.SxExtractImageExtractImage(Sender: TSxExtractImage;
  Image: TBitmap; Size: TSxSize);
var lH, lW : Integer;
    lRgb : TImageData;
    lFName : String;
begin
  With TStringList.Create() Do
  Try
    if FileExists('00-Debug.log') then
      LoadFromFile('00-Debug.log');
    Add('SxExtractImageExtractImage : ' + Sender.FileName);
    SaveToFile('00-Debug.log');

    Finally
      Free();
  End;

//  lFName := Sender.FileName;
//  If lFName = '' Then
    lFName := 'C:\Projects\casinostore.rgb';

  If FileExists(lFName) Then
    If LoadImageFromFile(lFName, lRgb) Then
    Try
      Image.Width  := Size.cX;
      Image.Height := Size.cY;
      Image.PixelFormat := pf32bit;
      Image.AlphaFormat := afDefined;

      If (Image.Width < lRgb.Width) And (Image.Height < lRgb.Height) Then
      Begin
        If lRgb.Height > lRgb.Width Then
        Begin
          lH := Image.Height;
          lW := Round(lH / lRgb.Height * Image.Width);
        End
        Else If lRgb.Width > lRgb.Height Then
        Begin
          lW := Image.Width;
          lH := Round(lW / lRgb.Width * Image.Height);
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
          ResizeImage(lRgb, lW, lH, rfLanczos);
      End;

      ConvertDataToBitmap(lRgb, Image);

      Finally
        FreeImage(lRgb);
    End;
end;

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
