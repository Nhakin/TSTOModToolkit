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
  TSxShellPropSheetForm1 = class(TSxShellPropSheetForm)
    Label1: TLabel;
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}


initialization
    RegisterPropSheetForm(TSxShellPropSheetForm1);
end.









 
 
 
