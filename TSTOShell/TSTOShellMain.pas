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
    TSTORgbPropPage, SxThumbnailProvider, SxExtractImage, SxConst, SxExtractIcon;

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
    procedure SxExtractImageExtractImage(Sender: TSxExtractImage;
      Image: TBitmap; Size: TSxSize);
    procedure SxThumbnailProviderGetThumbnail(Sender: TSxThumbnailProvider;
      CX: Integer; Image: TBitmap; var HasAlphaChannel: Boolean);

  private
    Function GetPictureRatio(ASrcWidth, ASrcHeight, ATrgWidth, ATrgHeight : Integer) : TPoint;

  protected

  public

  end;

implementation

uses Dialogs,
  ExtCtrls,
  ImagingClasses, ImagingComponents, ImagingRgb, Imaging,
  ImagingTypes, ImagingCanvases, RgbTools, ComServ;

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
Var lFileType : TImageType;
begin
  lFileType := GetImageType(SxContextMenu.FileName);

  PopTSTOToolkit.Visible     := lFileType <> itUnknown;
  PopConvertToPng.Enabled    := lFileType <> itPng;
  PopConvertToRGB444.Enabled := lFileType <> itRGBA4444;
  PopConvertToRGB888.Enabled := lFileType <> itRGBA8888;
end;

procedure TSxModule1.SxShellPropSheetExtAddPropSheet(
  Sender: TSxShellPropSheetExt; PropSheetClass: TFormClass;
  var AllowInsert: Boolean);
begin
  AllowInsert := (PropSheetClass = TTSTORgbPropSheet) And
                 SameText(ExtractFileExt(Sender.FileName), '.rgb');
end;

Function TSxModule1.GetPictureRatio(ASrcWidth, ASrcHeight, ATrgWidth, ATrgHeight : Integer) : TPoint;
Begin
(*
      If (lImg.Height > ImgPreview.Height) Or (lImg.Width > ImgPreview.Width) Then
      Begin
        If (lImg.Height > ImgPreview.Height) Then
        Begin
          lH := ImgPreview.Height;
          lW := Round((lH / lImg.Height) * ImgPreview.Width);
        End
        Else
        Begin
          lW := ImgPreview.Width;
          lH := Round((lW / lImg.Width) * ImgPreview.Height);
        End;

        ResizeImage(lImg, lW, lH, rfLanczos);

        lblImageSize.Caption := lblImageSize.Caption + ' (Resized at ' + IntToStr(lW) + ' X ' + IntToStr(lH) + ')';
      End;
*)
  Result.X := ASrcWidth;
  Result.Y := ASrcHeight;

  If (ASrcWidth > ATrgWidth) Or (ASrcHeight > ATrgHeight) Then
  Begin
    If ASrcHeight > ATrgHeight Then
    Begin
      Result.Y := ATrgHeight;
      Result.X := Round((Result.Y / ASrcHeight) * ATrgWidth);
    End
    Else If ASrcWidth > ATrgWidth Then
    Begin
      Result.X := ATrgWidth;
      Result.Y := Round((Result.X / ASrcWidth) * ATrgHeight)
    End;
  End;
End;

procedure TSxModule1.SxThumbnailProviderGetThumbnail(
  Sender: TSxThumbnailProvider; CX: Integer; Image: TBitmap;
  var HasAlphaChannel: Boolean);
Var lTrgWidth  ,
    lTrgHeight ,
    lSrcWidth  ,
    lSrcHeight : Integer;
    lFName : String;
    lImg : TImageData;
begin
  lTrgWidth  := CX;
  lTrgHeight := CX * 3 Div 4;
  HasAlphaChannel := True;

//  lFName := Sender.FileName;
//  If lFName = '' Then
    lFName := 'C:\Projects\casinostore.rgb';

  If FileExists(lFName) Then
    If LoadImageFromFile(lFName, lImg) Then
    Try
      lSrcWidth  := lImg.Width;
      lSrcHeight := lImg.Height;

      With GetPictureRatio(lSrcWidth, lSrcHeight, lTrgWidth, lTrgHeight) Do
      Begin
        If (X > 0) And (Y > 0) Then
          ResizeImage(lImg, X, Y, rfLanczos);
      End;
      ConvertDataToBitmap(lImg, Image);

      Finally
        FreeImage(lImg);
    End;
end;

initialization
  RegisterSxDataModule(ComServer,TSxModule1);

end.
