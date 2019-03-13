library PluginDemo;

uses
  ShareMem,
  HsClipBoardEx in '..\..\..\HsUnits\HsClipBoardEx.pas',
  HsEncodingEx in '..\..\..\HsUnits\HsEncodingEx.pas',
  HsEventListEx in '..\..\..\HsUnits\HsEventListEx.pas',
  HsFunctionsEx in '..\..\..\HsUnits\HsFunctionsEx.pas',
  HsInterfaceEx in '..\..\..\HsUnits\HsInterfaceEx.pas',
  HsListEx in '..\..\..\HsUnits\HsListEx.pas',
  HsStreamEx in '..\..\..\HsUnits\HsStreamEx.pas',
  HsStringListEx in '..\..\..\HsUnits\HsStringListEx.pas',
  HsXmlDocEx in '..\..\..\HsUnits\HsXmlDocEx.pas',
  TSTORGBProgress in '..\..\TSTOSDK\TSTORGBProgress.pas',
  TSTOCustomPatchesIntf in '..\..\TSTOSDK\TSTOCustomPatchesIntf.pas',
  TSTOHackMasterListIntf in '..\..\TSTOSDK\TSTOHackMasterListIntf.pas',
  TSTOHackSettingsIntf in '..\..\TSTOSDK\TSTOHackSettingsIntf.pas',
  TSTOProjectIntf in '..\..\TSTOSDK\TSTOProjectIntf.pas',
  TSTOSbtpIntf in '..\..\TSTOSDK\TSTOSbtpIntf.pas',
  TSTOScriptTemplateIntf in '..\..\TSTOSDK\TSTOScriptTemplateIntf.pas',
  TSTOProjectWorkSpaceIntf in '..\..\TSTOSDK\TSTOProjectWorkSpaceIntf.pas',
  TSTOCustomPatches.IO in '..\..\TSTOSDK\TSTOCustomPatches.IO.pas',
  TSTOHackMasterList.IO in '..\..\TSTOSDK\TSTOHackMasterList.IO.pas',
  TSTOProjectWorkSpace.IO in '..\..\TSTOSDK\TSTOProjectWorkSpace.IO.pas',
  TSTOSbtp.IO in '..\..\TSTOSDK\TSTOSbtp.IO.pas',
  TSTOScriptTemplate.IO in '..\..\TSTOSDK\TSTOScriptTemplate.IO.pas',
  TSTOPluginIntf in '..\..\TSTOSdk\TSTOPluginIntf.pas',
  DlgTSTOPluginDemoSettings in 'DlgTSTOPluginDemoSettings.pas' {TSTOPluginDemoSettingsDlg},
  PlgTSTOCustomPlugin in '..\..\TSTOSdk\PlgTSTOCustomPlugin.pas' {TSTOCustomPlugin: TJvPlugIn},
  PlgTSTOPluginDemo in 'PlgTSTOPluginDemo.pas' {TSTOPluginDemo: TTSTOCustomPlugin};

{$R *.res}

exports
  CreateTSTOPlugin;

begin
end.
