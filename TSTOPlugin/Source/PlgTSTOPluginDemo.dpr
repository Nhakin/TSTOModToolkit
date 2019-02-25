library PlgTSTOPluginDemo;

uses
  ShareMem,
  PlugInTSTOPluginDemo in 'PlugInTSTOPluginDemo.pas' {TSTOPluginDemo: TJvPlugIn},
  TSTOPluginIntf in 'TSTOPluginIntf.pas',
  HsClipBoardEx in '..\..\HsUnits\HsClipBoardEx.pas',
  HsEncodingEx in '..\..\HsUnits\HsEncodingEx.pas',
  HsEventListEx in '..\..\HsUnits\HsEventListEx.pas',
  HsFunctionsEx in '..\..\HsUnits\HsFunctionsEx.pas',
  HsInterfaceEx in '..\..\HsUnits\HsInterfaceEx.pas',
  HsListEx in '..\..\HsUnits\HsListEx.pas',
  HsStreamEx in '..\..\HsUnits\HsStreamEx.pas',
  HsStringListEx in '..\..\HsUnits\HsStringListEx.pas',
  HsXmlDocEx in '..\..\HsUnits\HsXmlDocEx.pas',
  RGBProgress in 'TSTOSDK\RGBProgress.pas',
  TSTOCustomPatchesIntf in 'TSTOSDK\TSTOCustomPatchesIntf.pas',
  TSTOHackMasterListIntf in 'TSTOSDK\TSTOHackMasterListIntf.pas',
  TSTOHackSettingsIntf in 'TSTOSDK\TSTOHackSettingsIntf.pas',
  TSTOProjectIntf in 'TSTOSDK\TSTOProjectIntf.pas',
  TSTOSbtpIntf in 'TSTOSDK\TSTOSbtpIntf.pas',
  TSTOScriptTemplateIntf in 'TSTOSDK\TSTOScriptTemplateIntf.pas',
  TSTOScriptTemplateIntfIO in 'TSTOSDK\TSTOScriptTemplateIntfIO.pas',
  TSTOWorkspaceIntf in 'TSTOSDK\TSTOWorkspaceIntf.pas';

{$R *.res}

exports
  RegisterPlugin;

begin
end.
