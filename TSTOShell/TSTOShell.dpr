library TSTOShell;

uses
  ComServ,
  TSTOShell_TLB in 'TSTOShell_TLB.pas',
  TSTOShellMain in 'TSTOShellMain.pas' {SxModule1: TSxModule},
  TSTORgbPropPage in 'TSTORgbPropPage.pas' {TSTORgbPropSheet: TSxShellPropSheetForm},
  TSTORgb in 'TSTORgb.pas',
  ImagingRgb in 'ImagingRgb.pas';

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer,
  DllInstall;

{$R *.RES}

begin
end.
