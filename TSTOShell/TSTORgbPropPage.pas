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

Uses TSTORgb;

procedure TTSTORgbPropSheet.SxShellPropSheetFormCreate(Sender: TObject);
Var lRgb : ITSTORgbFile;
begin
  lRgb := TTSTORgbFile.CreateRGBFile();
  Try
    lRgb.LoadRgbFromFile(PropSheetComponent.FileName);
    ImgPreview.Picture.Assign(lRgb.Picture);

    lblImageSize.Caption := IntToStr(lRgb.Width) + ' X ' + IntToStr(lRgb.Height);
    lblHeight.Caption    := IntToStr(lRgb.Height);
    lblWidth.Caption     := IntToStr(lRgb.Width);

    Finally
      lRgb := Nil;
  End;
end;

initialization
  RegisterPropSheetForm(TTSTORgbPropSheet);

end.









 
 
 
