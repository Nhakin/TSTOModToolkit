library PluginVintageScript;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  ShareMem,
  SysUtils,
  Classes,
  PlgTSTOVintageScript in 'PlgTSTOVintageScript.pas' {TSTOVintageScript: TDataModule},
  PlgTSTOCustomPlugin in '..\..\TSTOSdk\PlgTSTOCustomPlugin.pas' {TSTOCustomPlugin: TDataModule},
  TSTOScriptTemplateIntf in '..\..\TSTOSDK\TSTOScriptTemplateIntf.pas',
  TSTOScriptTemplate.IO in '..\..\TSTOSDK\TSTOScriptTemplate.IO.pas',
  TSTOSbtpIntf in '..\..\TSTOSDK\TSTOSbtpIntf.pas',
  TSTOSbtp.IO in '..\..\TSTOSDK\TSTOSbtp.IO.pas',
  TSTORGBProgress in '..\..\TSTOSDK\TSTORGBProgress.pas',
  TSTOProjectWorkSpaceIntf in '..\..\TSTOSDK\TSTOProjectWorkSpaceIntf.pas',
  TSTOProjectWorkSpace.IO in '..\..\TSTOSDK\TSTOProjectWorkSpace.IO.pas',
  TSTOProjectIntf in '..\..\TSTOSDK\TSTOProjectIntf.pas',
  TSTOPluginIntf in '..\..\TSTOSdk\TSTOPluginIntf.pas',
  TSTOHackSettingsIntf in '..\..\TSTOSDK\TSTOHackSettingsIntf.pas',
  TSTOHackMasterListIntf in '..\..\TSTOSDK\TSTOHackMasterListIntf.pas',
  TSTOHackMasterList.IO in '..\..\TSTOSDK\TSTOHackMasterList.IO.pas',
  TSTOCustomPatchesIntf in '..\..\TSTOSDK\TSTOCustomPatchesIntf.pas',
  TSTOCustomPatches.IO in '..\..\TSTOSDK\TSTOCustomPatches.IO.pas',
  HsXmlDocEx in '..\..\..\HsUnits\HsXmlDocEx.pas',
  HsStringListEx in '..\..\..\HsUnits\HsStringListEx.pas',
  HsStreamEx in '..\..\..\HsUnits\HsStreamEx.pas',
  HsListEx in '..\..\..\HsUnits\HsListEx.pas',
  HsInterfaceEx in '..\..\..\HsUnits\HsInterfaceEx.pas',
  HsFunctionsEx in '..\..\..\HsUnits\HsFunctionsEx.pas',
  HsEventListEx in '..\..\..\HsUnits\HsEventListEx.pas',
  HsEncodingEx in '..\..\..\HsUnits\HsEncodingEx.pas',
  HsClipBoardEx in '..\..\..\HsUnits\HsClipBoardEx.pas',
  DlgTSTOVintageScriptSettings in 'DlgTSTOVintageScriptSettings.pas' {TSTOVintageScriptSettingsDlg};

{$R *.res}

exports
  CreateTSTOPlugin;

begin
end.
