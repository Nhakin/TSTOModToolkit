unit TSTORgbPropPage;

interface

uses
    Windows,
    Messages,
    SysUtils,
    Classes,
    Forms,
    SxPropertySheetForm, Vcl.Controls, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TTSTORgbPropSheet = class(TSxShellPropSheetForm)
    Label1: TLabel;
    lblFileName: TLabel;
    Label2: TLabel;
    lblImageSize: TLabel;
    Label3: TLabel;
    lblHeight: TLabel;
    lblWidth: TLabel;
    Label6: TLabel;
    sbPreview: TScrollBox;
    ImgPreview: TImage;
    lblFormat: TLabel;
    Label5: TLabel;
    procedure SxShellPropSheetFormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

Uses Math, Graphics,
  Imaging, ImagingTypes, ImagingComponents;

procedure TTSTORgbPropSheet.SxShellPropSheetFormCreate(Sender: TObject);
Var lImg : TImageData;
    lGraphic : TBitMap;

    lRgbHeader : Packed Record
      FileSig : DWord;
      Width   : Word;
      Height  : Word;
    End;
    lStrm : TMemoryStream;
    lH, lW : Integer;
begin
  lStrm := TMemoryStream.Create();
  Try
    lStrm.LoadFromFile(PropSheetComponent.FileName);
    lStrm.ReadBuffer(lRgbHeader, SizeOf(lRgbHeader));
    lStrm.Position := 0;

    If LoadImageFromStream(lStrm, lImg) Then
    Try
      lblFileName.Caption  := ExtractFileName(PropSheetComponent.FileName);
      If lRgbHeader.FileSig = 0 Then
        lblFormat.Caption := 'RGBA8888'
      Else If (lRgbHeader.FileSig = $20000000) Or (lRgbHeader.FileSig = $60000000) Then
        lblFormat.Caption := 'RGBA4444';

      lblImageSize.Caption := IntToStr(lImg.Width) + ' X ' + IntToStr(lImg.Height);
      lblHeight.Caption    := IntToStr(lImg.Height);
      lblWidth.Caption     := IntToStr(lImg.Width);

      lGraphic := TBitMap.Create();
      Try
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

        ConvertDataToBitmap(lImg, lGraphic);

        ImgPreview.Picture.Assign(lGraphic);
        ImgPreview.Top  := (sbPreview.Height - ImgPreview.Height) Div 2;
        ImgPreview.Left := (sbPreview.Width - ImgPreview.Width) Div 2;

        Finally
          lGraphic.Free();
      End;

      Finally
        FreeImage(lImg);
    End;

    Finally
      lStrm.Free();
  End;
end;

initialization
  RegisterPropSheetForm(TTSTORgbPropSheet);

end.









 
 
 
