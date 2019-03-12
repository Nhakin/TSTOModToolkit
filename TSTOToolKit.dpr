program TSTOToolKit;

uses
  ShareMem,
  Forms,
  CustomPatchFrm in 'CustomPatchFrm.pas' {FrmCustomPatches},
  dmImage in 'dmImage.pas' {DataModuleImage: TDataModule},
  HackMasterListFrm in 'HackMasterListFrm.pas' {FrmHackMasterList},
  HsAlarmEx in 'HsUnits\HsAlarmEx.pas',
  HsBase64Ex in 'HsUnits\HsBase64Ex.pas',
  HsBaseConvEx in 'HsUnits\HsBaseConvEx.pas',
  HsCheckSumEx in 'HsUnits\HsCheckSumEx.pas',
  HsClipBoardEx in 'HsUnits\HsClipBoardEx.pas',
  HsEncodingEx in 'HsUnits\HsEncodingEx.pas',
  HsEventListEx in 'HsUnits\HsEventListEx.pas',
  HsFunctionsEx in 'HsUnits\HsFunctionsEx.pas',
  HsHttpEx in 'HsUnits\HsHttpEx.pas',
  HsInterfaceEx in 'HsUnits\HsInterfaceEx.pas',
  HsJSonEx in 'HsUnits\HsJSonEx.pas',
  HsJSonFormatterEx in 'HsUnits\HsJSonFormatterEx.pas',
  HsListEx in 'HsUnits\HsListEx.pas',
  HsStreamEx in 'HsUnits\HsStreamEx.pas',
  HsStringListEx in 'HsUnits\HsStringListEx.pas',
  HsSuperObjectEx in 'HsUnits\HsSuperObjectEx.pas',
  HsXmlDocEx in 'HsUnits\HsXmlDocEx.pas',
  HsZipUtils in 'HsUnits\HsZipUtils.pas',
  ImagingRgb in 'Vampyre\ImagingRgb.pas',
  IntfReg in 'IntfReg.pas',
  MainDckFrm in 'MainDckFrm.pas' {FrmDckMain},
  ProjectGroupSettingFrm in 'ProjectGroupSettingFrm.pas' {FrmProjectGroupSettings},
  ProjectSettingFrm in 'ProjectSettingFrm.pas' {FrmProjectSettings},
  RemoveFileFromProjectFrm in 'RemoveFileFromProjectFrm.pas' {FrmRemoveFileFromProject},
  TSTORgbProgress in 'TSTORgbProgress.pas',
  SettingsFrm in 'SettingsFrm.pas' {FrmSettings},
  SptbFrm in 'SptbFrm.pas' {FrmSbtp},
  SuperObject in 'SuperObject.pas',
  TSTOBCell in 'TSTOBCell.pas',
  TSTOBCell.Bin in 'BCellFile\IO\DataPlugin\TSTOBCell.Bin.pas',
  TSTOBCell.IO in 'BCellFile\IO\TSTOBCell.IO.pas',
  TSTOBCell.Xml in 'BCellFile\IO\DataPlugin\TSTOBCell.Xml.pas',
  TSTOBCellImpl in 'BCellFile\TSTOBCellImpl.pas',
  TSTOBCellIntf in 'BCellFile\TSTOBCellIntf.pas',
  TSTOBsv.Bin in 'BsvFile\IO\DataPlugin\TSTOBsv.Bin.pas',
  TSTOBsv.IO in 'BsvFile\IO\TSTOBsv.IO.pas',
  TSTOBsv.Xml in 'BsvFile\IO\DataPlugin\TSTOBsv.Xml.pas',
  TSTOBsvImpl in 'BsvFile\TSTOBsvImpl.pas',
  TSTOBsvIntf in 'BsvFile\TSTOBsvIntf.pas',
  TSTOBsvIntfReg in 'BsvFile\TSTOBsvIntfReg.pas',
  TSTOCustomPatches.IO in 'CustomPatches\IO\TSTOCustomPatches.IO.pas',
  TSTOCustomPatches.Xml in 'CustomPatches\IO\DataPlugin\TSTOCustomPatches.Xml.pas',
  TSTOCustomPatchesImpl in 'CustomPatches\TSTOCustomPatchesImpl.pas',
  TSTOCustomPatchesIntf in 'CustomPatches\TSTOCustomPatchesIntf.pas',
  TSTOCustomPatchesIntfReg in 'CustomPatches\TSTOCustomPatchesIntfReg.pas',
  TSTODlcIndex in 'Xml\TSTODlcIndex.pas',
  TSTODownloader in 'TSTODownloader.pas',
  TSTOHackMasterList.Bin in 'HackMasterList\IO\DataPlugin\TSTOHackMasterList.Bin.pas',
  TSTOHackMasterList.IO in 'HackMasterList\IO\TSTOHackMasterList.IO.pas',
  TSTOHackMasterList.Xml in 'HackMasterList\IO\DataPlugin\TSTOHackMasterList.Xml.pas',
  TSTOHackMasterListImpl in 'HackMasterList\TSTOHackMasterListImpl.pas',
  TSTOHackMasterListIntf in 'HackMasterList\TSTOHackMasterListIntf.pas',
  TSTOHackSettings in 'TSTOHackSettings.pas',
  TSTOModToolKit in 'TSTOModToolKit.pas',
  TSTOPackageList in 'TSTOPackageList.pas',
  TSTOPatches in 'TSTOPatches.pas',
  TSTOProject.Bin in 'TSTOProject\IO\DataPlugin\TSTOProject.Bin.pas',
  TSTOProject.Xml in 'TSTOProject\IO\DataPlugin\TSTOProject.Xml.pas',
  TSTOProjectImpl in 'TSTOProject\TSTOProjectImpl.pas',
  TSTOProjectIntf in 'TSTOProject\TSTOProjectIntf.pas',
  TSTOProjectWorkSpace.Bin in 'WorkSpace\IO\DataPlugin\TSTOProjectWorkSpace.Bin.pas',
  TSTOProjectWorkSpace.IO in 'WorkSpace\IO\TSTOProjectWorkSpace.IO.pas',
  TSTOProjectWorkSpace.Types in 'WorkSpace\TSTOProjectWorkSpace.Types.pas',
  TSTOProjectWorkSpace.Xml in 'WorkSpace\IO\DataPlugin\TSTOProjectWorkSpace.Xml.pas',
  TSTOProjectWorkSpaceImpl in 'WorkSpace\TSTOProjectWorkSpaceImpl.pas',
  TSTOProjectWorkSpaceIntf in 'WorkSpace\TSTOProjectWorkSpaceIntf.pas',
  TSTOProjectWorkSpaceIntfReg in 'WorkSpace\TSTOProjectWorkSpaceIntfReg.pas',
  TSTORessource in 'TSTORessource.pas',
  TSTORgb in 'TSTORgb.pas',
  TSTORgbTrans in 'TSTORgbTrans.pas',
  TSTOSbtp.Bin in 'SbtpFile\IO\DataPlugin\TSTOSbtp.Bin.pas',
  TSTOSbtp.IO in 'SbtpFile\IO\TSTOSbtp.IO.pas',
  TSTOSbtp.JSon in 'SbtpFile\IO\DataPlugin\TSTOSbtp.JSon.pas',
  TSTOSbtp.Xml in 'SbtpFile\IO\DataPlugin\TSTOSbtp.Xml.pas',
  TSTOSbtpEx.JSon in 'SbtpFile\IO\DataPlugin\TSTOSbtpEx.JSon.pas',
  TSTOSbtpImpl in 'SbtpFile\TSTOSbtpImpl.pas',
  TSTOSbtpIntf in 'SbtpFile\TSTOSbtpIntf.pas',
  TSTOSbtpIntfReg in 'SbtpFile\TSTOSbtpIntfReg.pas',
  TSTOSbtpTypes in 'SbtpFile\TSTOSbtpTypes.pas',
  TSTOScriptTemplate.Bin in 'ScriptTemplates\IO\DataPlugins\TSTOScriptTemplate.Bin.pas',
  TSTOScriptTemplate.IO in 'ScriptTemplates\IO\TSTOScriptTemplate.IO.pas',
  TSTOScriptTemplate.Xml in 'ScriptTemplates\IO\DataPlugins\TSTOScriptTemplate.Xml.pas',
  TSTOScriptTemplateImpl in 'ScriptTemplates\TSTOScriptTemplateImpl.pas',
  TSTOScriptTemplateIntf in 'ScriptTemplates\TSTOScriptTemplateIntf.pas',
  TSTOScriptTemplateIntfReg in 'ScriptTemplates\TSTOScriptTemplateIntfReg.pas',
  TSTOScriptTemplateTypes in 'ScriptTemplates\TSTOScriptTemplateTypes.pas',
  TSTOStoreMenu in 'Xml\TSTOStoreMenu.pas',
  TSTOStoreMenuMaster in 'Xml\TSTOStoreMenuMaster.pas',
  TSTOTreeviews in 'VirtualTree\TSTOTreeviews.pas',
  TSTOXmlBaseType in 'Xml\TSTOXmlBaseType.pas',
  TSTOZero.Bin in 'ZeroFile\DataPlugin\TSTOZero.Bin.pas',
  TSTOZeroImpl in 'ZeroFile\TSTOZeroImpl.pas',
  TSTOZeroIntf in 'ZeroFile\TSTOZeroIntf.pas',
  VTCombos in 'VirtualTree\VTCombos.pas',
  VTEditors in 'VirtualTree\VTEditors.pas',
  TSTOPluginIntf in 'TSTOPlugin\TSTOSdk\TSTOPluginIntf.pas',
  TSTOPluginManagerIntf in 'TSTOPlugin\PluginManager.dpk\Source\TSTOPluginManagerIntf.pas',
  AboutFrm in 'AboutFrm.pas' {FrmAbout};

{$R *.res}
{$R Images.res}

begin
  {$IfDef Debug}
    ReportMemoryLeaksOnShutdown := True;
  {$EndIf}

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'TSTOModToolKit';
  Application.CreateForm(TDataModuleImage, DataModuleImage);
  Application.CreateForm(TFrmDckMain, FrmDckMain);
  Application.Run;
end.
