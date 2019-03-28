library PluginCustomSciptAndPatches;

uses
  ShareMem,
  TSTOCustomPatches.IO in '..\..\TSTOSDK\TSTOCustomPatches.IO.pas',
  TSTOCustomPatchesIntf in '..\..\TSTOSDK\TSTOCustomPatchesIntf.pas',
  TSTOHackMasterList.IO in '..\..\TSTOSDK\TSTOHackMasterList.IO.pas',
  TSTOHackMasterListIntf in '..\..\TSTOSDK\TSTOHackMasterListIntf.pas',
  TSTOHackSettingsIntf in '..\..\TSTOSDK\TSTOHackSettingsIntf.pas',
  TSTOPluginIntf in '..\..\TSTOSdk\TSTOPluginIntf.pas',
  TSTOProjectIntf in '..\..\TSTOSDK\TSTOProjectIntf.pas',
  TSTOProjectWorkSpace.IO in '..\..\TSTOSDK\TSTOProjectWorkSpace.IO.pas',
  TSTOProjectWorkSpaceIntf in '..\..\TSTOSDK\TSTOProjectWorkSpaceIntf.pas',
  TSTORGBProgress in '..\..\TSTOSDK\TSTORGBProgress.pas',
  TSTOSbtp.IO in '..\..\TSTOSDK\TSTOSbtp.IO.pas',
  TSTOSbtpIntf in '..\..\TSTOSDK\TSTOSbtpIntf.pas',
  TSTOScriptTemplate.IO in '..\..\TSTOSDK\TSTOScriptTemplate.IO.pas',
  TSTOScriptTemplateIntf in '..\..\TSTOSDK\TSTOScriptTemplateIntf.pas',
  HsClipBoardEx in '..\..\..\HsUnits\HsClipBoardEx.pas',
  HsEncodingEx in '..\..\..\HsUnits\HsEncodingEx.pas',
  HsEventListEx in '..\..\..\HsUnits\HsEventListEx.pas',
  HsFunctionsEx in '..\..\..\HsUnits\HsFunctionsEx.pas',
  HsInterfaceEx in '..\..\..\HsUnits\HsInterfaceEx.pas',
  HsListEx in '..\..\..\HsUnits\HsListEx.pas',
  HsStreamEx in '..\..\..\HsUnits\HsStreamEx.pas',
  HsStringListEx in '..\..\..\HsUnits\HsStringListEx.pas',
  HsXmlDocEx in '..\..\..\HsUnits\HsXmlDocEx.pas',
  PlgTSTOCustomPlugin in '..\..\TSTOSdk\PlgTSTOCustomPlugin.pas' {TSTOCustomPlugin: TJvPlugIn},
  PlgCustomScriptAndPatches in 'PlgCustomScriptAndPatches.pas' {TSTOCustomScriptPlugin: TTSTOCustomPlugin},
  DlgCustomScriptAndPatches in 'DlgCustomScriptAndPatches.pas' {Form4};

{$R *.res}

exports
  CreateTSTOPlugin;

begin

end.
