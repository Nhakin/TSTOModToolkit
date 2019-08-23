unit TSTORgbPropPage;

interface

uses
    Windows,
    Messages,
    SysUtils,
    Classes,
    Forms,
    SxPropertySheetForm, Vcl.Controls, Vcl.StdCtrls;

type
  TTSTORgbPropSheet = class(TSxShellPropSheetForm)
    Label1: TLabel;
    Label2: TLabel;
    procedure SxShellPropSheetFormResize(Sender: TObject);
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}


procedure TTSTORgbPropSheet.SxShellPropSheetFormResize(Sender: TObject);
begin
  Label2.Caption := IntToStr(Width) + 'X' + IntToStr(Height);
end;

initialization
  RegisterPropSheetForm(TTSTORgbPropSheet);

end.









 
 
 
