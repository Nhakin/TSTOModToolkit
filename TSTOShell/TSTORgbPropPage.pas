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
    Panel1: TPanel;
    Label1: TLabel;
    LblFileName: TLabel;
    Label2: TLabel;
    lblImageSize: TLabel;
    Label3: TLabel;
    lblHeight: TLabel;
    lblWidth: TLabel;
    Label6: TLabel;
    ImgPreview: TImage;
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
begin
  If LoadImageFromFile(PropSheetComponent.FileName, lImg) Then
  Try
    lblFileName.Caption  := ExtractFilePath(PropSheetComponent.FileName);
    lblImageSize.Caption := IntToStr(lImg.Width) + ' X ' + IntToStr(lImg.Height);
    lblHeight.Caption    := IntToStr(lImg.Height);
    lblWidth.Caption     := IntToStr(lImg.Width);

    lGraphic := TBitMap.Create();
    Try
      ConvertDataToBitmap(lImg, lGraphic);

      ImgPreview.Picture.Assign(lGraphic);
      ImgPreview.Refresh();
      Finally
        lGraphic.Free();
    End;

    Finally
      FreeImage(lImg);
  End;
end;

initialization
  RegisterPropSheetForm(TTSTORgbPropSheet);

end.









 
 
 
