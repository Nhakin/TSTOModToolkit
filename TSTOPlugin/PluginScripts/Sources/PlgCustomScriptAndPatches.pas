unit PlgCustomScriptAndPatches;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PlgTSTOCustomPlugin;

type
  TTSTOCustomScriptPlugin = class(TTSTOCustomPlugin)
    procedure TSTOCustomPluginCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Function RegisterPlugin() : TTSTOCustomScriptPlugin; StdCall;

implementation

{$R *.dfm}

Function RegisterPlugin() : TTSTOCustomScriptPlugin;
Begin
  Result := TTSTOCustomScriptPlugin.Create(Nil);
End;

procedure TTSTOCustomScriptPlugin.TSTOCustomPluginCreate(Sender: TObject);
begin
  inherited;
//
end;

end.
