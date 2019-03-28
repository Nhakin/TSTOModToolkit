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
  HsClipBoardEx in '..\..\..\HsUnits\HsClipBoardEx.pas',
  HsEncodingEx in '..\..\..\HsUnits\HsEncodingEx.pas',
  HsEventListEx in '..\..\..\HsUnits\HsEventListEx.pas',
  HsFunctionsEx in '..\..\..\HsUnits\HsFunctionsEx.pas',
  HsIniFilesEx in '..\..\..\HsUnits\HsIniFilesEx.pas',
  HsInterfaceEx in '..\..\..\HsUnits\HsInterfaceEx.pas',
  HsListEx in '..\..\..\HsUnits\HsListEx.pas',
  HsStreamEx in '..\..\..\HsUnits\HsStreamEx.pas',
  HsStringListEx in '..\..\..\HsUnits\HsStringListEx.pas',
  HsXmlDocEx in '..\..\..\HsUnits\HsXmlDocEx.pas',
  PlgTSTOCustomPlugin in '..\..\TSTOSdk\PlgTSTOCustomPlugin.pas' {TSTOCustomPlugin: TDataModule},
  TSTOCustomPatches.IO in '..\..\TSTOSdk\TSTOCustomPatches.IO.pas',
  TSTOCustomPatchesIntf in '..\..\TSTOSdk\TSTOCustomPatchesIntf.pas',
  TSTOHackMasterList.IO in '..\..\TSTOSdk\TSTOHackMasterList.IO.pas',
  TSTOHackMasterListIntf in '..\..\TSTOSdk\TSTOHackMasterListIntf.pas',
  TSTOHackSettingsIntf in '..\..\TSTOSdk\TSTOHackSettingsIntf.pas',
  TSTOPluginIntf in '..\..\TSTOSdk\TSTOPluginIntf.pas',
  TSTOProjectIntf in '..\..\TSTOSdk\TSTOProjectIntf.pas',
  TSTOProjectWorkSpace.IO in '..\..\TSTOSdk\TSTOProjectWorkSpace.IO.pas',
  TSTOProjectWorkSpaceIntf in '..\..\TSTOSdk\TSTOProjectWorkSpaceIntf.pas',
  TSTORGBProgress in '..\..\TSTOSdk\TSTORGBProgress.pas',
  TSTOSbtp.IO in '..\..\TSTOSdk\TSTOSbtp.IO.pas',
  TSTOSbtpIntf in '..\..\TSTOSdk\TSTOSbtpIntf.pas',
  TSTOScriptTemplate.IO in '..\..\TSTOSdk\TSTOScriptTemplate.IO.pas',
  TSTOScriptTemplateIntf in '..\..\TSTOSdk\TSTOScriptTemplateIntf.pas',
  TSTOTreeviews in '..\..\TSTOSdk\TSTOTreeviews.pas',
  uSelectDirectoryEx in '..\..\..\uSelectDirectoryEx.pas',
  ClsTSTOVintageScript in 'ClsTSTOVintageScript.pas',
  DlgTSTOVintageScriptSettings in 'DlgTSTOVintageScriptSettings.pas' {TSTOVintageScriptSettingsDlg},
  PlgTSTOVintageScript in 'PlgTSTOVintageScript.pas' {TSTOVintageScript: TDataModule};

{$R *.res}
{$R ..\..\..\Images.res}

exports
  CreateTSTOPlugin;

begin
end.
