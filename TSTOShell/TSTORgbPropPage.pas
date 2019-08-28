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
    ImgPreview: TImage;
    Label1: TLabel;
    LblFileName: TLabel;
    Label2: TLabel;
    lblImageSize: TLabel;
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
  lblFileName.Caption := ExtractFileName(PropSheetComponent.FileName);

  lRgb := TTSTORgbFile.CreateRGBFile();
  Try
    lRgb.LoadRgbFromFile(PropSheetComponent.FileName);
    lblImageSize.Caption := IntToStr(lRgb.Width) + ' X ' + IntToStr(lRgb.Height);
    ImgPreview.Picture.Assign(lRgb.Picture);

    Finally
      lRgb := Nil;
  End;
end;

initialization
  RegisterPropSheetForm(TTSTORgbPropSheet);

end.









 
 
 
