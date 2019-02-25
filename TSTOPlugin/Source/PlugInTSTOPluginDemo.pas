unit PlugInTSTOPluginDemo;

interface

uses
  Windows, Messages, SysUtils, Classes, Dialogs, Forms, Controls,
  JvPlugin, HsInterfaceEx, TSTOPluginIntf;

type
  TTSTOPluginDemo = class(TJvPlugIn, ITSTOPlugin)
    procedure JvPlugInDestroy(Sender: TObject);
  Private
    FMainApp  : ITSTOApplication;
    FIntfImpl : TInterfaceExImplementor;

    Function GetIntfImpl() : TInterfaceExImplementor;

  Protected
    Property IntfImpl : TInterfaceExImplementor Read GetIntfImpl Implements ITSTOPlugin;

    Procedure InitPlugin(AMainApplication : ITSTOApplication);

  public

  end;

function RegisterPlugin: TTSTOPluginDemo; stdcall;

implementation

{$R *.dfm}

function RegisterPlugin: TTSTOPluginDemo;
begin
  Result := TTSTOPluginDemo.Create(nil);
end;

Function TTSTOPluginDemo.GetIntfImpl() : TInterfaceExImplementor;
Begin
  If Not Assigned(FIntfImpl) Then
    FIntfImpl := TInterfaceExImplementor.Create(Self, False);
  Result := FIntfImpl;
End;

Procedure TTSTOPluginDemo.InitPlugin(AMainApplication : ITSTOApplication);
Begin
  FMainApp := AMainApplication;
End;

procedure TTSTOPluginDemo.JvPlugInDestroy(Sender: TObject);
begin
  FMainApp := Nil;
end;

end.
