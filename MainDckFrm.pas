unit MainDckFrm;

interface

uses
  dmImage, HsStreamEx, HsInterfaceEx, VTEditors,
  TSTOTreeviews, TSTOProject.Xml, TSTOBCell, TSTOProjectWorkSpace.IO,
  TSTOPackageList, TSTORessource, TSTOScriptTemplate.IO, TSTOHackMasterList.IO,
  TSTOHackSettings,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, ToolWin, ActnList,
  StdCtrls, ExtCtrls, KControls, KHexEditor, VirtualTrees,
  LMDDckSite, LMDDckStyleElems, SciLanguageManager, SciScintillaBase,
  SciScintillaMemo, SciScintilla, SciScintillaNPP, SciActions, TB2Item, TB2Dock,
  TB2Toolbar, SpTBXItem, SpTBXSkins, SpTBXAdditionalSkins, SpTBXControls,
  SpTBXEditors, Mask, System.Actions, SpTBXExPanel, SpTBXDkPanels, SpTBXTabs, ImagingRgb;

Type
  TTSTOCurrentDataType = (dtUnknown, dtXml, dtZeroIndex, dtText, dtRbg, dtBCell, dtBsv3);

  ITSTOCurrentData = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-8291-F8E37E0F03C8}']
    Function  GetDataType() : TTSTOCurrentDataType;
    Procedure SetDataType(Const ADataType : TTSTOCurrentDataType);

    Function  GetDataStream() : IMemoryStreamEx;

    Property DataType   : TTSTOCurrentDataType Read GetDataType    Write SetDataType;
    Property DataStream : IMemoryStreamEx      Read GetDataStream;

  End;

(******************************************************************************)

  TFrmDckMain = class(TForm)
    dckMgr: TLMDDockManager;

    SciLangMgr: TSciLanguageManager;
    actScintilla: TActionList;
    SciToggleBookMark1: TSciToggleBookMark;
    SciNextBookmark1: TSciNextBookmark;
    SciPrevBookmark1: TSciPrevBookmark;
    SciFoldAll1: TSciFoldAll;
    SciUnFoldAll1: TSciUnFoldAll;
    SciCollapseCurrentLevel1: TSciCollapseCurrentLevel;
    SciUnCollapseCurrentLevel1: TSciUnCollapseCurrentLevel;
    SciCollapseLevel11: TSciCollapseLevel1;
    SciCollapseLevel21: TSciCollapseLevel2;
    SciCollapseLevel31: TSciCollapseLevel3;
    SciCollapseLevel41: TSciCollapseLevel4;
    SciExpandLevel11: TSciExpandLevel1;
    SciExpandLevel21: TSciExpandLevel2;
    SciExpandLevel31: TSciExpandLevel3;
    SciExpandLevel41: TSciExpandLevel4;
    SpTBXBItemContainer1: TSpTBXBItemContainer;
    tbServerItems: TSpTBXSubmenuItem;
    tbSynch: TSpTBXItem;
    tbDownload: TSpTBXItem;
    tbUnpackMod: TSpTBXItem;
    tbPackMod: TSpTBXItem;
    tbCreateMod: TSpTBXItem;
    tbValidateXml: TSpTBXItem;
    tbExtractRgb: TSpTBXItem;
    PanToolBar: TPanel;
    sptbxDckMain: TSpTBXDock;
    sptbxMainMenu: TSpTBXToolbar;
    mnuFile: TSpTBXSubmenuItem;
    mnuSettings: TSpTBXItem;
    mnuOpenWorkspace: TSpTBXItem;
    mnuCloseWorkspace: TSpTBXItem;
    N3: TSpTBXSeparatorItem;
    mnuCustomPatch: TSpTBXItem;
    mnuSbtpCustomPatch: TSpTBXItem;
    N1: TSpTBXSeparatorItem;
    mnuExit: TSpTBXItem;
    mnuWindow: TSpTBXSubmenuItem;
    N2: TSpTBXSeparatorItem;
    mnuDefaultLayout: TSpTBXItem;
    mnuSkin: TSpTBXSubmenuItem;
    SpTBXSkinGroupItem1: TSpTBXSkinGroupItem;
    sptbxtbMain: TSpTBXToolbar;
    dckMain: TLMDDockSite;
    PanHexEdit: TLMDDockPanel;
    KHexEditor: TKHexEditor;
    PanInfo: TLMDDockPanel;
    dckInfo: TLMDDockSite;
    PanProject: TLMDDockPanel;
    PanSbtp: TLMDDockPanel;
    PanTreeView: TLMDDockPanel;
    PanFilter: TPanel;
    tbPopupMenuItems: TSpTBXSubmenuItem;
    tbMainServer: TSpTBXTBGroupItem;
    tbMainPopup: TSpTBXTBGroupItem;
    tbMiscItems: TSpTBXSubmenuItem;
    tbMainMisc: TSpTBXTBGroupItem;
    mnuTools: TSpTBXSubmenuItem;
    mnuToolServer: TSpTBXTBGroupItem;
    mnuToolPopup: TSpTBXTBGroupItem;
    mnuToolMisc: TSpTBXTBGroupItem;
    tbBuildList: TSpTBXItem;
    mnuDownloadAllIndexes: TSpTBXItem;
    mnuIndexes: TSpTBXSubmenuItem;
    SpTBXSeparatorItem1: TSpTBXSeparatorItem;
    SpTBXItem3: TSpTBXItem;
    mnuIndexesItems: TSpTBXSubmenuItem;
    SpTBXItem4: TSpTBXItem;
    SpTBXSeparatorItem3: TSpTBXSeparatorItem;
    SpTBXItem5: TSpTBXItem;
    popTVItems: TSpTBXSubmenuItem;
    ExpandAll1: TSpTBXItem;
    CollapseAll1: TSpTBXItem;
    ExportasXML1: TSpTBXItem;
    popTvWSProjectItems: TSpTBXSubmenuItem;
    popTvWSApplyMod: TSpTBXItem;
    popTvWSApplyAllModFromHere: TSpTBXItem;
    popTvWSPackMod: TSpTBXItem;
    popTvWSBuildAllModFromHere: TSpTBXItem;
    popTvWS: TSpTBXPopupMenu;
    popTV: TSpTBXPopupMenu;
    popTvWSItems: TSpTBXSubmenuItem;
    popTvWSProjectGroupItems: TSpTBXSubmenuItem;
    popAddNewProject: TSpTBXItem;
    popAddExistingProject: TSpTBXItem;
    SpTBXSeparatorItem2: TSpTBXSeparatorItem;
    popRenameProjectGroup: TSpTBXItem;
    popSaveProjectGroupAs: TSpTBXItem;
    popSaveProjectGroup: TSpTBXItem;
    SpTBXSeparatorItem4: TSpTBXSeparatorItem;
    popTvWSProjectConfiguration: TSpTBXItem;
    SpTBXSeparatorItem5: TSpTBXSeparatorItem;
    SpTBXTBGroupItem1: TSpTBXTBGroupItem;
    SpTBXTBGroupItem2: TSpTBXTBGroupItem;
    popTvWSProjectSrcFolderItems: TSpTBXSubmenuItem;
    SpTBXSeparatorItem6: TSpTBXSeparatorItem;
    popAddFile: TSpTBXItem;
    SpTBXSeparatorItem7: TSpTBXSeparatorItem;
    SpTBXSeparatorItem8: TSpTBXSeparatorItem;
    SpTBXTBGroupItem3: TSpTBXTBGroupItem;
    popRemoveFile: TSpTBXItem;
    SpTBXSeparatorItem9: TSpTBXSeparatorItem;
    popTvWSRemoveProject: TSpTBXItem;
    popTvWSRenameProject: TSpTBXItem;
    popTvWSCleanProject: TSpTBXItem;
    popTvWSProcessLater: TSpTBXItem;
    popTvWSProcessSooner: TSpTBXItem;
    PanResources: TLMDDockPanel;
    PanFilterResources: TPanel;
    popTvRessourceItems: TSpTBXSubmenuItem;
    popExpandResources: TSpTBXItem;
    popCollapseResources: TSpTBXItem;
    popTvResource: TSpTBXPopupMenu;
    SpTBXSeparatorItem10: TSpTBXSeparatorItem;
    popSelectMissingFiles: TSpTBXItem;
    tbSaveWorkSpace: TSpTBXItem;
    PanHackTemplateMaster: TLMDDockPanel;
    dckScriptTemplate: TLMDDockSite;
    PanTvHackTemplate: TLMDDockPanel;
    PanHackTemplate: TLMDDockPanel;
    EditScriptTemplate: TScintillaNPP;
    PanSTVariables: TLMDDockPanel;
    PanSTSettings: TLMDDockPanel;
    tsScriptTemplate: TSpTBXTabSet;
    tsSTOutput: TSpTBXTabItem;
    tsSTSource: TSpTBXTabItem;
    popTvSTTemplate: TSpTBXPopupMenu;
    popTvSTTemplateDelete: TSpTBXItem;
    popTvSTTemplateNew: TSpTBXItem;
    popTvSTVariables: TSpTBXPopupMenu;
    popTvSTVariablesNew: TSpTBXItem;
    popTvSTVariablesDelete: TSpTBXItem;
    SpTBXSeparatorItem11: TSpTBXSeparatorItem;
    SpTBXSeparatorItem12: TSpTBXSeparatorItem;
    popTvWSProjectGroupConfiguration: TSpTBXItem;
    popTvWSGenerateScripts: TSpTBXItem;
    SpTBXSeparatorItem13: TSpTBXSeparatorItem;
    popExportHackConfig: TSpTBXItem;
    popBuildHackConfig: TSpTBXItem;
    popTvWSBuildMod: TSpTBXItem;
    PackAllModFromHere: TSpTBXItem;
    popCompareHackMasterList: TSpTBXItem;
    tbCreateMasterList: TSpTBXSubmenuItem;
    popDiffHackMasterList: TSpTBXItem;
    popNewHackMasterList: TSpTBXItem;
    LMDDockPanel1: TLMDDockPanel;
    PanCustomMod: TLMDDockPanel;
    PanModOptions: TLMDDockPanel;
    chkUnlimitedTime: TSpTBXCheckBox;
    chkFreeLandUpgade: TSpTBXCheckBox;
    chkNonUnique: TSpTBXCheckBox;
    chkAllFree: TSpTBXCheckBox;
    chkInstantBuild: TSpTBXCheckBox;
    chkBuildStore: TSpTBXCheckBox;
    PanFileInfo: TLMDDockPanel;
    Label6: TLabel;
    Label4: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    EditLanguage: TEdit;
    EditVersion: TEdit;
    EditTier: TEdit;
    EditMinVersion: TEdit;
    EditPlatform: TEdit;
    EditFileName: TEdit;
    PanImage: TLMDDockPanel;
    PanSize: TPanel;
    Label7: TLabel;
    EditImageSize: TEdit;
    ScrlImage: TScrollBox;
    ImgResource: TImage;
    mnuHackMasterList: TSpTBXItem;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mnuExitClick(Sender: TObject);
    procedure mnuSettingsClick(Sender: TObject);
    procedure mnuCustomPatchClick(Sender: TObject);
    procedure mnuSbtpCustomPatchClick(Sender: TObject);
    procedure mnuDefaultLayoutClick(Sender: TObject);
    procedure PanImageOldEnter(Sender: TObject);
    procedure tbDownloadOldClick(Sender: TObject);
    procedure tbUnpackModOldClick(Sender: TObject);
    procedure mnuOpenWorkspaceClick(Sender: TObject);
    procedure ExpandAll1Click(Sender: TObject);
    procedure CollapseAll1Click(Sender: TObject);
    procedure tbSynchOldClick(Sender: TObject);
    procedure tbPackModOldClick(Sender: TObject);
    procedure tbCreateModOldClick(Sender: TObject);
    procedure tbValidateXmlOldClick(Sender: TObject);
    procedure tbExtractRgbOldClick(Sender: TObject);
    procedure tbCreateMasterListClick(Sender: TObject);
    procedure tbBuildListClick(Sender: TObject);
    procedure mnuDownloadAllIndexesClick(Sender: TObject);
    procedure SpTBXItem3Click(Sender: TObject);
    procedure mnuCloseWorkspaceClick(Sender: TObject);
    procedure sptbxtbMainMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure popTvWSPopup(Sender: TObject);
    procedure popTVPopup(Sender: TObject);
    procedure popTvWSRemoveProjectClick(Sender: TObject);
    procedure popSaveProjectGroupClick(Sender: TObject);
    procedure popAddExistingProjectClick(Sender: TObject);
    procedure popTvWSProcessSoonerClick(Sender: TObject);
    procedure popTvWSProcessLaterClick(Sender: TObject);
    procedure popExpandResourcesClick(Sender: TObject);
    procedure popCollapseResourcesClick(Sender: TObject);
    procedure popSelectMissingFilesClick(Sender: TObject);
    procedure popRemoveFileClick(Sender: TObject);
    procedure tbSaveWorkSpaceClick(Sender: TObject);
    procedure sptbxMainMenuMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure popAddFileClick(Sender: TObject);
    procedure popTvWSProjectConfigurationClick(Sender: TObject);
    procedure popTvSTTemplateNewClick(Sender: TObject);
    procedure popTvSTTemplateDeleteClick(Sender: TObject);
    procedure popTvSTTemplatePopup(Sender: TObject);
    procedure popTvSTVariablesNewClick(Sender: TObject);
    procedure popTvSTVariablesDeleteClick(Sender: TObject);
    procedure popTvSTVariablesPopup(Sender: TObject);
    procedure tsScriptTemplateActiveTabChange(Sender: TObject;
      TabIndex: Integer);
    procedure ExportasXML1Click(Sender: TObject);
    procedure popTvWSProjectGroupConfigurationClick(Sender: TObject);
    procedure popTvWSGenerateScriptsClick(Sender: TObject);
    procedure popExportHackConfigClick(Sender: TObject);
    procedure popBuildHackConfigClick(Sender: TObject);
    procedure popTvWSApplyModClick(Sender: TObject);
    procedure popTvWSBuildModClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure popTvWSApplyAllModFromHereClick(Sender: TObject);
    procedure popTvWSBuildAllModFromHereClick(Sender: TObject);
    procedure popTvWSRenameProjectClick(Sender: TObject);
    procedure popTvWSPackModClick(Sender: TObject);
    procedure popTvWSCleanProjectClick(Sender: TObject);
    procedure popAddNewProjectClick(Sender: TObject);
    procedure popSaveProjectGroupAsClick(Sender: TObject);
    procedure popRenameProjectGroupClick(Sender: TObject);
    procedure PackAllModFromHereClick(Sender: TObject);
    procedure popCompareHackMasterListClick(Sender: TObject);
    procedure popDiffHackMasterListClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure mnuHackMasterListClick(Sender: TObject);

  private
    FEditFilter    : THsVTButtonEdit;
    FEditFilterRes : THsVTButtonEdit;
    FFormSettings  : ITSTOXMLFormSetting;

    FTvDlcServer      : TTSTODlcServerTreeView;
    FTvWorkSpace      : TTSTOWorkSpaceTreeView;
    FTvSbtpFile       : TTSTOSbtpFileTreeView;
    FTvCustomPatches  : TTSTOCustomPatchesTreeView;
    FTvResources      : TTSTORessourcesTreeView;
    FTvScriptTemplate : TTSTOScriptTemplateTreeView;
    FTvSTSettings     : TTSTOScriptTemplateSettingsTreeView;
    FTvSTVariables    : TTSTOScriptTemplateVariablesTreeView;
    FBsvAnim          : IImagingAnimation;

    FWorkSpace    : ITSTOWorkSpaceProjectGroupIO;
    FResources    : ITSTOResourcePaths;

    FPrevSTHack : ITSTOScriptTemplateHackIO;

    FPrj        : ITSTOXMLProject;
    FBCell      : ITSTOBCellAnimation;

    FLoaded      : Boolean;
    FDefLayout   : IMemoryStreamEx;
    FCurData     : ITSTOCurrentData;
    FCurDlcIndex : String;
    FFormPosLoaded : Boolean;

    Procedure ShowPanelClick(Sender : TObject);
    Procedure DoWorkSpaceOnChanged(Sender : TObject);

    Procedure DoEditFilterButtonClick(Sender : TObject);
    Procedure DoEditFilterKeyPress(Sender: TObject; var Key: Char);
    Procedure DoMnuIndexesClick(Sender : TObject);
    Procedure DoTvDlcServerOnFocusChanged(Sender : TBaseVirtualTree;
      Node : PVirtualNode; Column : TColumnIndex);

    Procedure DoTvWorkSpaceDblClick(Sender: TObject);
    Procedure DoTvWorkSpaceOnFocusChanged(Sender : TBaseVirtualTree;
      Node : PVirtualNode; Column : TColumnIndex);

    Procedure DoTvResourcesOnFocusChanged(Sender : TBaseVirtualTree;
      Node : PVirtualNode; Column : TColumnIndex);

    Procedure DoTvScriptTemplateOnFocusChanged(Sender : TBaseVirtualTree;
      Node : PVirtualNode; Column : TColumnIndex);

    Procedure DoFilterNode(Sender : TBaseVirtualTree; Node : PVirtualNode; Data : Pointer; Var Abort : Boolean);
    Procedure DoSetNodeCheckState(Sender : TBaseVirtualTree; Node : PVirtualNode; Data : Pointer; Var Abort : Boolean);
    Procedure DoSetNodeExpandedState(Sender : TBaseVirtualTree; Node : PVirtualNode; Data : Pointer; Var Abort : Boolean);

    Procedure InitPanels(APanel : TLMDDockPanel = Nil);
    Procedure CreateXmlTab(AXmlString, AXmlFileName : String);
    Procedure ProcessCurrentNode(ANode : PVirtualNode);
    Procedure GetPackageList(Sender : TBaseVirtualTree; Node : PVirtualNode; Data : Pointer; Var Abort : Boolean);

    Procedure GetRgbNodeList(Sender : TBaseVirtualTree; Node : PVirtualNode; Data : Pointer; Var Abort : Boolean);
    Procedure ExtractRgbFiles(APackageList : ITSTOPackageNodes);
    Procedure LoadDlcIndexes();

    Procedure ApplyMod(AWorkSpaceProject : ITSTOWorkSpaceProjectIO);
    Procedure ValidateHackMasterList(AWorkSpaceProject : ITSTOWorkSpaceProjectIO);

  end;

var
  FrmDckMain: TFrmDckMain;

implementation

Uses RTTI, RtlConsts, uSelectDirectoryEx, System.UITypes, XmlIntf,
  Imaging, ImagingTypes, HsBase64Ex,
  HsJSonFormatterEx, HsXmlDocEx, HsZipUtils, HsFunctionsEx,
  HsCheckSumEx, HsStringListEx, SciSupport, System.Character,
  SettingsFrm, CustomPatchFrm, SptbFrm, RgbExtractProgress, ImagingClasses,
  TSTORgb, TSTOModToolKit, TSTODownloader, TSTOFunctions,
  TSTOCustomPatches.IO, TSTOHackMasterList.Xml, TSTOBsv.IO,
  TSTOZero.Bin, TSTOSbtp.IO, TSTOProjectWorkSpaceIntf,
  TSTOProjectWorkSpace.Xml, TSTOProjectWorkSpace.Types,
  RemoveFileFromProjectFrm, ProjectSettingFrm, ProjectGroupSettingFrm, HackMasterListFrm;

{$R *.dfm}

Type
  TLMDScintillaDockPanel = Class(TLMDDockPanel)
  Private
    FSciNPP    : TScintillaNPP;
    FSciInited : Boolean;

    Function  GetLanguageManager() : TSciLanguageManager;
    Procedure SetLanguageManager(Const ALanguageManager : TSciLanguageManager);

    Function  GetLines() : TStrings;

  Protected
    Procedure DoEnter(); OverRide;

  Public
    Property LanguageManager : TSciLanguageManager Read GetLanguageManager Write SetLanguageManager;
    Property Lines : TStrings Read GetLines;

    Procedure Dock(NewDockSite: TWinControl; ARect: TRect); OverRide;

    Constructor Create(AOwner : TComponent); OverRide;
    Destructor  Destroy(); OverRide;

  End;

  TTSTOCurrentData = Class(TInterfacedObjectEx, ITSTOCurrentData)
  Private
    FDataType   : TTSTOCurrentDataType;
    FDataStream : IMemoryStreamEx;

  Protected
    Function  GetDataType() : TTSTOCurrentDataType; Virtual;
    Procedure SetDataType(Const ADataType : TTSTOCurrentDataType); Virtual;

    Function  GetDataStream() : IMemoryStreamEx; Virtual;

    Procedure Clear();

    Property DataType   : TTSTOCurrentDataType Read GetDataType    Write SetDataType;
    Property DataStream : IMemoryStreamEx      Read GetDataStream;

  Public
    Procedure Assign(ASource : TObject); ReIntroduce; Virtual;

    Constructor Create(); ReIntroduce; Virtual;
    Destructor  Destroy(); OverRide;

  End;

Constructor TLMDScintillaDockPanel.Create(AOwner : TComponent);
Begin
  InHerited Create(AOwner);

  FSciNPP := TScintillaNPP.Create(Self);
  FSciNPP.Parent := Self;
  FSciNPP.Align := alClient;
  FSciNPP.Font.Name := 'Courrier New';
  FSciNPP.Font.Size := 10;

  FSciNPP.Gutter0.Width := 32;
  FSciNPP.Gutter1.Width := 16;
  FSciNPP.Gutter1.Sensitive := True;
  FSciNPP.Gutter2.Width := 14;
  FSciNPP.Gutter2.Sensitive := True;

  FSciNPP.FoldDrawFlags := FSciNPP.FoldDrawFlags + [sciEnableHighlight];
  FSciNPP.FoldMarkers.MarkerType := sciMarkBox;
  FSciNPP.Colors.MarkerActive := clRed;
  FSciNPP.Colors.MarkerBack := clGray;
  FSciNPP.Colors.MarkerFore := $00F3F3F3;
  FSciNPP.Colors.SelBack := $00DADADA;
End;

Destructor TLMDScintillaDockPanel.Destroy();
Begin
  FSciNPP.Free();

  InHerited Destroy();
End;

Function TLMDScintillaDockPanel.GetLanguageManager() : TSciLanguageManager;
Begin
  Result := FSciNPP.LanguageManager;
End;

Procedure TLMDScintillaDockPanel.SetLanguageManager(Const ALanguageManager : TSciLanguageManager);
Begin
  FSciNPP.LanguageManager := ALanguageManager;
End;

Function TLMDScintillaDockPanel.GetLines() : TStrings;
Begin
  Result := FSciNPP.Lines;
End;

Procedure TLMDScintillaDockPanel.DoEnter();
Begin
//  If Not FSciInited Then
//  Begin
//    FSciNPP.SelectedLanguage := 'XML';
//    FSciNPP.Folding := FSciNPP.Folding + [foldFold];
//
//    FSciInited := True;
//  End;

  InHerited DoEnter();
End;

Procedure TLMDScintillaDockPanel.Dock(NewDockSite: TWinControl; ARect: TRect);
Begin
  InHerited Dock(NewDockSite, ARect);

  If Not (csDestroying In ComponentState) Then
  Begin
    FSciNPP.SelectedLanguage := 'XML';
    FSciNPP.Folding := FSciNPP.Folding + [foldFold];
  End;
End;

Constructor TTSTOCurrentData.Create();
Begin
  InHerited Create();

  FDataStream := TMemoryStreamEx.Create();
End;

Destructor TTSTOCurrentData.Destroy();
Begin
  FDataStream := Nil;

  InHerited Destroy();
End;

Procedure TTSTOCurrentData.Clear();
Begin
  FDataType   := dtUnknown;
  FDataStream := TMemoryStreamEx.Create();
End;

Procedure TTSTOCurrentData.Assign(ASource : TObject);
Var lSrc : TTSTOCurrentData;
Begin
  If ASource Is TTSTOCurrentData Then
  Begin
    lSrc := TTSTOCurrentData(ASource);

    Clear();
    FDataType := lSrc.DataType;
    FDataStream.CopyFrom(lSrc.DataStream, 0);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [ASource.ClassName, ClassName]);
End;

Function TTSTOCurrentData.GetDataType() : TTSTOCurrentDataType;
Begin
  Result := FDataType;
End;

Procedure TTSTOCurrentData.SetDataType(Const ADataType : TTSTOCurrentDataType);
Begin
  FDataType := ADataType;
End;

Function TTSTOCurrentData.GetDataStream() : IMemoryStreamEx;
Begin
  Result := FDataStream;
End;

(******************************************************************************)

procedure TFrmDckMain.FormCreate(Sender: TObject);
Var X : Integer;
    lSbMnu : TSpTBXCustomItem;
    lPath : String;
begin
  FEditFilter := THsVTButtonEdit.Create(Self);
  FEditFilter.Parent        := PanFilter;
  FEditFilter.ButtonWidth   := 25;
  FEditFilter.OnButtonClick := DoEditFilterButtonClick;
  FEditFilter.OnKeyPress    := DoEditFilterKeyPress;
  FEditFilter.Align         := alClient;
  FEditFilter.Font.Color    := clBlack;

  FEditFilterRes := THsVTButtonEdit.Create(Self);
  FEditFilterRes.Parent        := PanFilterResources;
  FEditFilterRes.ButtonWidth   := 25;
  FEditFilterRes.OnButtonClick := DoEditFilterButtonClick;
  FEditFilterRes.OnKeyPress    := DoEditFilterKeyPress;
  FEditFilterRes.Align         := alClient;
  FEditFilterRes.Font.Color    := clBlack;

  DataModuleImage.imgToolBar.GetBitmap(94, FEditFilter.ButtonGlyph);
  DataModuleImage.imgToolBar.GetBitmap(94, FEditFilterRes.ButtonGlyph);

  If FileExists(ChangeFileExt(ParamStr(0), '.xml')) Then
    FPrj := TTSTOXmlTSTOProject.LoadTSTOProject(ChangeFileExt(ParamStr(0), '.xml'))
  Else
  Begin
    lPath := IncludeTrailingBackSlash(ExtractFilePath(ParamStr(0)));

    //Fill with some default value
    FPrj := TTSTOXmlTSTOProject.NewTSTOProject();
    FPrj.Settings.DLCPath := lPath + 'DLCServer\';
    FPrj.Settings.ResourcePath := lPath + 'Res\';
    FPrj.Settings.HackPath := lPath + 'Hack\';
    FPrj.Settings.SkinName := 'WMP11';

    With FPrj.Settings.MasterFiles.Add() Do
    Begin
      FileName := 'BuildingMasterList.xml';
      NodeName := 'Building';
      NodeKind := 'building';
    End;

    With FPrj.Settings.MasterFiles.Add() Do
    Begin
      FileName := 'CharacterMasterList.xml';
      NodeName := 'Character';
      NodeKind := 'character';
    End;

    With FPrj.Settings.MasterFiles.Add() Do
    Begin
      FileName := 'CharacterSkinMasterList.xml';
      NodeName := 'Consumable';
      NodeKind := 'consumable';
    End;

    With FPrj.Settings.MasterFiles.Add() Do
    Begin
      FileName := 'ConsumableMasterList.xml';
      NodeName := 'Consumable';
      NodeKind := 'consumable';
    End;

    MessageDlg('No configuration file found.', mtInformation, [mbOk], 0);
    With TFrmSettings.Create(Self) Do
    Try
      ProjectFile := FPrj;
      ShowModal();

      Finally
        Release();
    End;
  End;

  With FPrj.Settings Do
  Begin
    chkBuildStore.Checked     := BuildCustomStore;
    chkInstantBuild.Checked   := InstantBuild;
    chkAllFree.Checked        := AllFreeItems;
    chkNonUnique.Checked      := NonUnique;
    chkFreeLandUpgade.Checked := FreeLand;
    chkUnlimitedTime.Checked  := UnlimitedTime;

    FWorkSpace := TTSTOWorkSpaceProjectGroupIO.CreateProjectGroup();
    If FileExists(WorkSpaceFile) Then
      FWorkSpace.LoadFromFile(WorkSpaceFile);
    FWorkSpace.OnChange := DoWorkSpaceOnChanged;

    If FileExists(IncludeTrailingBackslash(ResourcePath) + 'ResourceIndex.bin') Then
      FResources := TTSTOResourcePaths.CreateResourcePaths(IncludeTrailingBackslash(ResourcePath) + 'ResourceIndex.bin')
    Else
      FResources := TTSTOResourcePaths.CreateResourcePaths();
  End;

  If Not DirectoryExists(FPrj.Settings.DLCPath) Then
    With TTSTODlcGenerator.Create() Do
    Try
      DownloadDLCIndex(FPrj);

      Finally
        Free();
    End;

  LoadDlcIndexes();

  FTvDlcServer := TTSTODlcServerTreeView.Create(Self);
  FTvDlcServer.Parent         := PanTreeView;
  FTvDlcServer.Align          := alClient;
  FTvDlcServer.Images         := DataModuleImage.imgToolBar;
  FTvDlcServer.PopupMenu      := popTv;
  FTvDlcServer.OnFocusChanged := DoTvDlcServerOnFocusChanged;
  FTvDlcServer.TSTOProject    := FPrj;

  FTvWorkSpace := TTSTOWorkSpaceTreeView.Create(Self);
  FTvWorkSpace.Parent         := PanProject;
  FTvWorkSpace.Align          := alClient;
  FTvWorkSpace.Images         := DataModuleImage.imgToolBar;
  FTvWorkSpace.PopupMenu      := popTvWS;
  FTvWorkSpace.OnFocusChanged := DoTvWorkSpaceOnFocusChanged;
  FTvWorkSpace.OnDblClick     := DoTvWorkSpaceDblClick;
  If Assigned(FWorkSpace) Then
    FTvWorkSpace.TvData := FWorkSpace;

  FTvResources := TTSTORessourcesTreeView.Create(Self);
  FTvResources.Parent         := PanResources;
  FTvResources.Align          := alClient;
  FTvResources.Images         := DataModuleImage.imgToolBar;
  FTvResources.PopupMenu      := popTvResource;
  FTvResources.OnFocusChanged := DoTvResourcesOnFocusChanged;
  FTvResources.TvData         := FResources;

  FTvSbtpFile := TTSTOSbtpFileTreeView.Create(Self);
  FTvSbtpFile.Parent     := PanSbtp;
  FTvSbtpFile.Align      := alClient;

  FTvCustomPatches := TTSTOCustomPatchesTreeView.Create(Self);
  FTvCustomPatches.Parent     := PanCustomMod;
  FTvCustomPatches.Align      := alClient;
  FTvCustomPatches.TvData     := FWorkSpace.HackSettings.CustomPatches.Patches;

  FTvScriptTemplate := TTSTOScriptTemplateTreeView.Create(Self);
  FTvScriptTemplate.Parent     := PanTvHackTemplate;
  FTvScriptTemplate.Align      := alClient;
  FTvScriptTemplate.TvData     := FWorkSpace.HackSettings.ScriptTemplates;
  FTvScriptTemplate.PopupMenu  := popTvSTTemplate;
  FTvScriptTemplate.OnFocusChanged := DoTvScriptTemplateOnFocusChanged;

  FPrevSTHack := Nil;

  FTvSTSettings := TTSTOScriptTemplateSettingsTreeView.Create(Self);
  FTvSTSettings.Parent     := PanSTSettings;
  FTvSTSettings.Align      := alClient;

  FTvSTVariables := TTSTOScriptTemplateVariablesTreeView.Create(Self);
  FTvSTVariables.Parent     := PanSTVariables;
  FTvSTVariables.Align      := alClient;
  FTvSTVariables.PopupMenu  := popTvSTVariables;

  FDefLayout := TMemoryStreamEx.Create();
  dckMgr.SaveToStream(TStream(FDefLayout.InterfaceObject));

  For X := 0 To ComponentCount - 1 Do
    If Components[X].InheritsFrom(TLMDDockPanel) Then
    Begin
      lSbMnu := TSpTBXCustomItem.Create(Self);
      lSbMnu.Caption := TLMDDockPanel(Components[X]).Caption;
      lSbMnu.Tag     := Integer(TLMDDockPanel(Components[X]));
      lSbMnu.OnClick := ShowPanelClick;

      mnuWindow.Insert(mnuWindow.Count - 2, lSbMnu);
    End;

  SkinManager.SetSkin(FPrj.Settings.SkinName);

  For X := 0 To FPrj.Settings.FormPos.Count - 1 Do
    If SameText(FPrj.Settings.FormPos[X].Name, Self.ClassName) Then
    Begin
      FFormSettings := FPrj.Settings.FormPos[X];
      Break;
    End;

  If Not Assigned(FFormSettings) Then
  Begin
    FFormSettings := FPrj.Settings.FormPos.Add();

    FFormSettings.Name        := Self.ClassName;
    FFormSettings.WindowState := TRttiEnumerationType.GetName(WindowState);
    FFormSettings.X := Left;
    FFormSettings.Y := Top;
    FFormSettings.H := Height;
    FFormSettings.W := Width;
  End;

  FLoaded := False;
  FFormPosLoaded := False;
end;

procedure TFrmDckMain.FormDestroy(Sender: TObject);
Var lStrStream : IStringStreamEx;
    lDckSetting : IXmlDocumentEx;
    lNode : IXmlNodeEx;
begin
  With FPrj.Settings Do
  Begin
    BuildCustomStore := chkBuildStore.Checked;
    InstantBuild     := chkInstantBuild.Checked;
    AllFreeItems     := chkAllFree.Checked;
    NonUnique        := chkNonUnique.Checked;
    FreeLand         := chkFreeLandUpgade.Checked;
    UnlimitedTime    := chkUnlimitedTime.Checked;
    If Assigned(FWorkSpace) Then
      WorkSpaceFile := FWorkSpace.FileName;

    SkinName := SkinManager.CurrentSkinName;
  End;

  lStrStream := TStringStreamEx.Create();
  Try
    dckMgr.SaveToStream(TStream(lStrStream.InterfaceObject));
    lDckSetting := LoadXMLData(StringReplace(Copy(lStrStream.DataString, 4, Length(lStrStream.DataString)), '<?xml version="1.0" encoding="utf-8"?>', '', [rfIgnoreCase]));

    lNode := FPrj.ChildNodes.FindNode('sitelist');
    If Assigned(lNode) Then
      FPrj.ChildNodes.Remove(lNode);

    FPrj.OwnerDocument.DocumentElement.ChildNodes.Add(lDckSetting.DocumentElement);

    Finally
      lStrStream := Nil;
  End;

  lStrStream := TStringStreamEx.Create(FormatXmlData(FPrj.Xml));
  Try
    lStrStream.SaveToFile(ChangeFileExt(ParamStr(0), '.xml'));

    Finally
      lStrStream := Nil;
  End;

  FPrj       := Nil;
  FBCell     := Nil;
  FDefLayout := Nil;

  FBsvAnim := Nil;
end;

procedure TFrmDckMain.FormActivate(Sender: TObject);
begin
  If Not FFormPosLoaded Then
  Begin
    WindowState := TRttiEnumerationType.GetValue<TWindowState>(FFormSettings.WindowState);
    If WindowState = wsNormal Then
    Begin
      Left        := FFormSettings.X;
      Top         := FFormSettings.Y;
      Height      := FFormSettings.H;
      Width       := FFormSettings.W;
    End;

    FFormPosLoaded := True;
  End;
end;

procedure TFrmDckMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := True;

  If FWorkSpace.Modified Then
    Case MessageDlg('Save changes to ' + FWorkSpace.ProjectGroupName + ' ?', mtInformation, [mbYes, mbNo, mbCancel], 0) Of
      mrYes : FWorkSpace.SaveToFile(FWorkSpace.FileName);
      mrCancel : CanClose := False;
    End;

  If CanClose Then
  Begin
    FFormSettings.WindowState := TRttiEnumerationType.GetName(WindowState);
    If WindowState <> wsMaximized Then
    Begin
      FFormSettings.X := Left;
      FFormSettings.Y := Top;
      FFormSettings.H := Height;
      FFormSettings.W := Width;
    End;
  End;
end;

Procedure TFrmDckMain.ShowPanelClick(Sender: TObject);
Begin
  TControl(TMenuItem(Sender).Tag).Show;
End;

Procedure TFrmDckMain.DoWorkSpaceOnChanged(Sender : TObject);
Begin
  tbSaveWorkSpace.Enabled := True;

  If Supports(Sender, ITSTOScriptTemplateVariableIO) Then
    FTvSTSettings.LoadData();
End;

(******************************************************************************)

procedure TFrmDckMain.mnuHackMasterListClick(Sender: TObject);
begin
  With TFrmHackMasterList.Create(Self) Do
  Try
    MasterList  := FWorkSpace.HackSettings.HackMasterList;
    LangMgr     := SciLangMgr;
    AppSettings := FPrj.Settings;
    ShowModal();

    Finally
      Release();
  End;
end;

procedure TFrmDckMain.SpTBXItem3Click(Sender: TObject);
Var lHML : ITSTOHackMasterListIO;
begin
  lHML := TTSTOHackMasterListIO.CreateHackMasterList();
  Try
    lHML.LoadFromFile('HackMasterList.xml');
    ShowMessage(lHML.AsXml);

    Finally
      lHML := Nil;
  End;
end;

procedure TFrmDckMain.sptbxMainMenuMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  If ([ssCtrl, ssAlt, ssShift, ssRight] * Shift  = Shift) And (Button = mbRight) Then
    mnuSkin.Visible := Not mnuSkin.Visible;
end;

procedure TFrmDckMain.sptbxtbMainMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  If ([ssCtrl, ssAlt, ssShift, ssRight] * Shift  = Shift) And (Button = mbRight) Then
  Begin
    FTvDlcServer.IsDebugMode      := Not FTvDlcServer.IsDebugMode;
    FTvWorkSpace.IsDebugMode      := Not FTvWorkSpace.IsDebugMode;
    FTvResources.IsDebugMode      := Not FTvResources.IsDebugMode;
    FTvScriptTemplate.IsDebugMode := Not FTvScriptTemplate.IsDebugMode;
    FTvSTVariables.IsDebugMode    := Not FTvSTVariables.IsDebugMode;
    FTvCustomPatches.IsDebugMode  := Not FTvCustomPatches.IsDebugMode;
  End;
end;

procedure TFrmDckMain.FormShow(Sender: TObject);
Var lNode : IXmlNodeEx;
    lXmlStr : IStringStreamEx;
begin
  If FileExists(ChangeFileExt(ParamStr(0), '.xml')) Then
  Begin
    If Not FLoaded Then
    Begin
      HandleNeeded();

      lNode := FPrj.OwnerDocument.SelectNode('//sitelist');
      If Assigned(lNode) Then
      Try
        lXmlStr := TStringStreamEx.Create(lNode.Xml);
        Try
          dckMgr.LoadFromStream(TStream(lXmlStr.InterfaceObject));

          Finally
            lXmlStr := Nil;
        End;

        Finally
          lNode := Nil;
      End;

      FLoaded := True;
    End;
  End;
end;

procedure TFrmDckMain.mnuCustomPatchClick(Sender: TObject);
Var lPkg  : ITSTOPackageNode;
    lPath : AnsiString;
begin
  If FTvDlcServer.GetNodeData(FTvDlcServer.GetFirstSelected(), ITSTOPackageNode, lPkg) Then
  Begin
    lPath := AnsiString(IncludeTrailingBackSlash(FPrj.Settings.HackPath + ChangeFileExt(lPkg.FileName, '')));
    FPrj.Settings.SourcePath := lPath + '0\';
    FPrj.Settings.TargetPath := lPath + '1.src\';
  End;

  With TFrmCustomPatches.Create(Self) Do
  Try
    ProjectFile := FPrj;
    HackSettings := FWorkSpace.HackSettings;
    LangMgr := SciLangMgr;

    If ShowModal() = mrOk Then
    Begin
      FPrj := TTSTOXmlTSTOProject.GetTSTOProject(LoadXmlData(ProjectFile.OwnerDocument.Xml.Text));

      vstCustomPacthes.BeginUpdate();
      Try
        vstCustomPacthes.Clear();
        vstCustomPacthes.RootNodeCount := FWorkSpace.HackSettings.CustomPatches.Patches.Count;

        Finally
          vstCustomPacthes.EndUpdate();
      End;
    End;

    Finally
      Release();
  End;
end;

procedure TFrmDckMain.mnuDefaultLayoutClick(Sender: TObject);
begin
  FDefLayout.Position := 0;
  dckMgr.LoadFromStream(TStream(FDefLayout.InterfaceObject));
end;

Procedure TFrmDckMain.DoMnuIndexesClick(Sender : TObject);
Var X : Integer;
Begin
  For X := 0 To mnuIndexesItems.Count - 1 Do
    mnuIndexesItems[X].Checked := mnuIndexesItems[X] = Sender;

  FTvDlcServer.LoadData( FPrj.Settings.DLCPath + 'dlc\' +
                         StripHotkey(TSptbxItem(Sender).Caption) + '.zip');
  FCurDlcIndex := ChangeFileExt(StripHotkey(TSptbxItem(Sender).Caption), '');
End;

Procedure TFrmDckMain.LoadDlcIndexes();
Var X : Integer;
    lItem : TSptbxItem;
begin
  For X := mnuIndexesItems.Count - 1 DownTo 0 Do
  Begin
    lItem := TSptbxItem(mnuIndexesItems[X]);
    mnuIndexesItems.Remove(lItem);
    FreeAndNil(lItem);
  End;

  With TTSTODlcGenerator.Create() Do
  Try
    With GetIndexFileNames(FPrj) Do
      For X := 0 To Count - 1 Do
        If FileExists(FPrj.Settings.DLCPath + Strings[X]) Then
        Begin
          lItem := TSptbxItem.Create(mnuIndexesItems);
          lItem.Caption := ChangeFileExt(ExtractFileName(Strings[X]), '');
          lItem.OnClick := DoMnuIndexesClick;
          mnuIndexesItems.Add(lItem);

          If X = 0 Then
            mnuIndexesItems.Add(TSpTBXSeparatorItem.Create(mnuIndexesItems));
        End;

    If mnuIndexesItems.Count > 0 Then
    Begin
      mnuIndexesItems[0].Checked := True;
      FCurDlcIndex := StripHotkey(mnuIndexesItems[0].Caption);
    End;

    Finally
      Free();
  End;
End;

procedure TFrmDckMain.mnuDownloadAllIndexesClick(Sender: TObject);
begin
  With TTSTODlcGenerator.Create() Do
  Try
    DownloadAllDLCIndex(FPrj);
    LoadDlcIndexes();

    Finally
      Free();
  End;
end;

procedure TFrmDckMain.mnuExitClick(Sender: TObject);
begin
  Close();
end;

procedure TFrmDckMain.mnuOpenWorkspaceClick(Sender: TObject);
begin
  With TOpenDialog.Create(Self) Do
    If Execute() Then
    Begin
      FTvWorkSpace.BeginUpdate();
      Try
        FTvWorkSpace.TvData := Nil;

        FPrj.Settings.WorkSpaceFile := AnsiString(FileName);
        FWorkSpace := TTSTOWorkSpaceProjectGroupIO.CreateProjectGroup();
        FWorkSpace.LoadFromFile(FileName);

        FTvWorkSpace.TvData := FWorkSpace;
        FTvCustomPatches.TvData := FWorkSpace.HackSettings.CustomPatches.Patches;
        FTvScriptTemplate.TvData := FWorkSpace.HackSettings.ScriptTemplates;

        Finally
          FTvWorkSpace.EndUpdate();
      End;
    End;
end;

procedure TFrmDckMain.mnuCloseWorkspaceClick(Sender: TObject);
begin
  FTvCustomPatches.TvData  := Nil;
  FTvScriptTemplate.TvData := Nil;
  FTvSTSettings.TvData     := Nil;
  FTvSTVariables.TvData    := Nil;
  FTvWorkSpace.TvData      := Nil;
  FWorkSpace               := Nil;

  FPrj.Settings.WorkSpaceFile := '';
end;

procedure TFrmDckMain.mnuSbtpCustomPatchClick(Sender: TObject);
begin
  With TFrmSbtp.Create(Self) Do
  Try
    HackSettings := FWorkSpace.HackSettings;
    AppSettings  := FPrj.Settings;
    ShowModal();
    
    Finally
      Release();
  End;
end;

procedure TFrmDckMain.mnuSettingsClick(Sender: TObject);
begin
  With TFrmSettings.Create(Self) Do
  Try
    ProjectFile := FPrj;
    ShowModal();

    If ResourceChanged Then
    Begin
      FTvResources.TvData := Nil;
      FResources := Nil;
      FResources := TTSTOResourcePaths.CreateResourcePaths(FPrj.Settings.ResourcePath + 'ResourceIndex.bin');
      FTvResources.TvData := FResources;
    End;

    Finally
      Release();
  End;
end;

procedure TFrmDckMain.PanImageOldEnter(Sender: TObject);
begin
  InitPanels(TLMDDockPanel(Sender));
end;

procedure TFrmDckMain.popAddExistingProjectClick(Sender: TObject);
Var lSelDir : AnsiString;
    lProject : ITSTOWorkSpaceProjectIO;
begin
  If SelectDirectoryEx('Package Directory', FPrj.Settings.HackPath,
    lSelDir,True, False, False) Then
  Begin
    lProject := FWorkSpace.Add();
    lProject.ProjectName := AnsiString(ExtractFileName(ExcludeTrailingBackslash(lSelDir)));
    FWorkSpace.CreateWsProject(lSelDir + '\', lProject);
    FTvWorkSpace.ReinitNode(Nil, True);
  End;
end;

procedure TFrmDckMain.popAddFileClick(Sender: TObject);
Var X : Integer;
    lFolderNode : ITSTOWorkSpaceProjectSrcFolder;
begin
  If FTvWorkSpace.GetNodeData(FTvWorkSpace.GetFirstSelected(), ITSTOWorkSpaceProjectSrcFolder, lFolderNode) Then
    With TOpenDialog.Create(Self) Do
    Try
      Options := Options + [ofAllowMultiSelect];

      If Execute() Then
      Begin
        If Files.Count > 0 Then
          For X := 0 To Files.Count - 1 Do
            lFolderNode.FileList.Add().FileName := ExtractFileName(Files[X])
        Else
          lFolderNode.FileList.Add().FileName := FileName;

        FTvWorkSpace.BeginUpdate();
        Try
          FTvWorkSpace.RootNodeCount := 0;
          FTvWorkSpace.TvData := FWorkSpace;

          Finally
            FTvWorkSpace.EndUpdate();
        End;

        tbSaveWorkSpace.Enabled := True;
      End;

      Finally
        Free();
    End;
end;

procedure TFrmDckMain.popAddNewProjectClick(Sender: TObject);
begin
  Raise Exception.Create('ToDo');
end;

procedure TFrmDckMain.popExpandResourcesClick(Sender: TObject);
begin
  FTvResources.ExpandAllNodes();
end;

procedure TFrmDckMain.popRemoveFileClick(Sender: TObject);
Var lSrcFolder      : ITSTOWorkSpaceProjectSrcFolder;
    lSrcFile        : ITSTOWorkSpaceProjectSrcFile;
    lNode, lDelNode : PVirtualNode;
    lSelectedFiles  : ITSTOWorkSpaceProjectSrcFiles;
    lMsgStr         : String;
    X               : Integer;
    lTmpNode        : PVirtualNode;
begin
  lNode := FTvWorkSpace.GetFirstSelected();

  If FTvWorkSpace.GetNodeData(lNode, ITSTOWorkSpaceProjectSrcFolder, lSrcFolder) Then
  Begin
    With TFrmRemoveFileFromProject.Create(Self) Do
    Try
      FileList := lSrcFolder.FileList;
      Caption := 'Remove From ' + ExtractFileName(ExcludeTrailingBackSlash(lSrcFolder.SrcPath));

      If ShowModal = mrOk Then
      Begin
        lSelectedFiles := SelectedFiles;
        If lSelectedFiles.Count > 0 Then
        Begin
          lMsgStr := '';
          For X := 0 To lSelectedFiles.Count - 1 Do
            lMsgStr := lMsgStr + lSelectedFiles[X].FileName + #$D#$A;

          If MessageConfirm('Remove these items from the project?'#$D#$A + lMsgStr) Then
          Begin
            FTvWorkSpace.BeginUpdate();
            Try
              If (lNode.States * [vsHasChildren] = [vsHasChildren]) And (lNode.ChildCount = 0) Then
                FTvWorkSpace.ReinitChildren(lNode, False);

              For X := 0 To lSelectedFiles.Count - 1 Do
              Begin
                lDelNode := lNode.FirstChild;

                While Assigned(lDelNode) Do
                Begin
                  lTmpNode := lDelNode.NextSibling;

                  If FTvWorkSpace.GetNodeData(lDelNode, ITSTOWorkSpaceProjectSrcFile, lSrcFile) Then
                  Try
                    If SameText(lSrcFile.FileName, lSelectedFiles[X].FileName) Then
                    Begin
                      FTvWorkSpace.DeleteNode(lDelNode);
                      lSrcFolder.FileList.Remove(lSrcFile);
                    End;

                    Finally
                      lSrcFile := Nil;
                  End;

                  lDelNode := lTmpNode;
                End;
              End;

              Finally
                FTvWorkSpace.EndUpdate();
            End;

            tbSaveWorkSpace.Enabled := True;
          End;
        End;
      End;

      Finally
        Release();
    End;
  End
  Else If FTvWorkSpace.GetNodeData(lNode, ITSTOWorkSpaceProjectSrcFile, lSrcFile) And
          FTvWorkSpace.GetNodeData(lNode.Parent, ITSTOWorkSpaceProjectSrcFolder, lSrcFolder) Then
  Begin
    If MessageConfirm('Remove these items from the project?'#$D#$A + lSrcFile.FileName) Then
    Begin
      FTvWorkSpace.DeleteNode(lNode);

      lSrcFolder.FileList.Remove(lSrcFile);
      tbSaveWorkSpace.Enabled := True;
    End;
  End;
end;

procedure TFrmDckMain.popRenameProjectGroupClick(Sender: TObject);
begin
  Raise Exception.Create('ToDo');
end;

procedure TFrmDckMain.popCollapseResourcesClick(Sender: TObject);
begin
  FTvResources.CollapseAllNodes();
end;

procedure TFrmDckMain.popExportHackConfigClick(Sender: TObject);
begin
  FWorkSpace.HackSettings.ExtractHackSource(hiffXml);
  ShowMessage('Done');
end;

procedure TFrmDckMain.popBuildHackConfigClick(Sender: TObject);
Var lHackFileName : String;
    lIdxFileName  : String;
begin
  With TOpenDialog.Create(Self) Do
  Try
    Filter := 'Hack File Index|HackIdx';
    If Execute() Then
      lIdxFileName := FileName;

    Filter := 'Zip File|*.zip';
    If Execute() Then
      lHackFileName := ChangeFileExt(FileName, '.zip');

    Finally
      Free();
  End;

  If (lIdxFileName <> '') And (lHackFileName <> '') Then
  Begin
    FWorkSpace.HackSettings.PackHackSource(hiffBin, lIdxFileName, lHackFileName);
    ShowMessage('Done');
//    MessageInformation('Done');
  End;{
  Else
    MessageErr('Index file name AND Hack Zip file name must not be empty.');
}
end;

procedure TFrmDckMain.popCompareHackMasterListClick(Sender: TObject);
Var lHML : ITSTOHackMasterListIO;
    lStrStrm : IStringStreamEx;
begin
  With TOpenDialog.Create(Self) Do
  Try
    Filter := 'Xml File|*.xml';
    If Execute() Then
    Begin
      lHML := TTSTOHackMasterListIO.CreateHackMasterList();
      Try
        lHML.LoadFromFile(FileName);

        With FWorkSpace.HackSettings.HackMasterList.GetDiff(lHML) Do
        Begin
          lStrStrm := TStringStreamEx.Create(AsXml);
          Try
            lStrStrm.SaveToFile(ChangeFileExt(FileName, 'Diff.xml'));

            Finally
              lStrStrm := Nil;
          End;
        End;

        Finally
          lHML := Nil
      End;
    End;

    Finally
      Free();
  End;

  ShowMessage('Done');
end;

procedure TFrmDckMain.popSaveProjectGroupAsClick(Sender: TObject);
begin
  Raise Exception.Create('ToDo');
end;

procedure TFrmDckMain.popSaveProjectGroupClick(Sender: TObject);
begin
  FWorkSpace.SaveToFile(FPrj.Settings.WorkSpaceFile);
end;

procedure TFrmDckMain.popSelectMissingFilesClick(Sender: TObject);
begin
  FTvDlcServer.SelectMissingPackage();
end;

procedure TFrmDckMain.popTVPopup(Sender: TObject);
begin
  With FTvDlcServer Do
    popSelectMissingFiles.Enabled := GetNodeData(GetFirstSelected(), ITSTOTierPackageNode);
end;

procedure TFrmDckMain.popTvSTTemplateDeleteClick(Sender: TObject);
Var lDeleteTemplate : ITSTOScriptTemplateHackIO;
    lNode : PVirtualNode;
begin
  lNode := FTvScriptTemplate.GetFirstSelected();

  If Assigned(lNode) And FTvScriptTemplate.GetNodeData(lNode, ITSTOScriptTemplateHackIO, lDeleteTemplate) And
     MessageConfirm('Do you want to delete this template?') Then
  Begin
    FTvScriptTemplate.BeginUpdate();
    Try
      If FTvScriptTemplate.TvData.Remove(lDeleteTemplate) > -1 Then
      Begin
        FTvScriptTemplate.DeleteNode(lNode);
        tbSaveWorkSpace.Enabled := True;
      End;

      Finally
        FTvScriptTemplate.EndUpdate();
    End;
  End;
end;

procedure TFrmDckMain.popTvSTTemplateNewClick(Sender: TObject);
Var lNewTemplate : ITSTOScriptTemplateHackIO;
begin
  lNewTemplate := FTvScriptTemplate.TvData.Add();
  lNewTemplate.Name := '<NewTemplate>';
  FTvScriptTemplate.AddChild(Nil, lNewTemplate);
  tbSaveWorkSpace.Enabled := True;
end;

procedure TFrmDckMain.popTvSTTemplatePopup(Sender: TObject);
begin
  popTvSTTemplateDelete.Enabled := Assigned(FTvScriptTemplate.GetFirstSelected());
end;

procedure TFrmDckMain.popTvSTVariablesDeleteClick(Sender: TObject);
Var lNode : PVirtualNode;
    lDeleteVariable : ITSTOScriptTemplateVariableIO;
begin
  lNode := FTvSTVariables.GetFirstSelected();

  If Assigned(lNode) And FTvSTVariables.GetNodeData(lNode, ITSTOScriptTemplateVariableIO, lDeleteVariable) And
     MessageConfirm('Do you want to delete this variable?') Then
  Begin
    FTvSTVariables.BeginUpdate();
    Try
      If FTvSTVariables.TvData.Remove(lDeleteVariable) > -1 Then
      Begin
        FTvSTVariables.DeleteNode(lNode);
        tbSaveWorkSpace.Enabled := True;
      End;

      Finally
        FTvSTVariables.EndUpdate();
    End;
  End;
end;

procedure TFrmDckMain.popTvSTVariablesNewClick(Sender: TObject);
Var lNewVariable : ITSTOScriptTemplateVariableIO;
begin
  lNewVariable := FTvSTVariables.TvData.Add();
  lNewVariable.Name := '<NewVariable>';
  FTvSTVariables.AddChild(Nil, lNewVariable);
  tbSaveWorkSpace.Enabled := True;
end;

procedure TFrmDckMain.popTvSTVariablesPopup(Sender: TObject);
begin
  popTvSTTemplateDelete.Enabled := Assigned(FTvSTVariables.GetFirstSelected());
end;

Procedure TFrmDckMain.ApplyMod(AWorkSpaceProject : ITSTOWorkSpaceProjectIO);
Begin
  ValidateHackMasterList(AWorkSpaceProject);

  Case AWorkSpaceProject.ProjectType Of
    sptScript :
    Begin
      FPrj.Settings.AllFreeItems     := chkAllFree.Checked;
      FPrj.Settings.NonUnique        := chkNonUnique.Checked;
      FPrj.Settings.BuildCustomStore := chkBuildStore.Checked;
      FPrj.Settings.InstantBuild     := chkInstantBuild.Checked;
      FPrj.Settings.FreeLand         := chkFreeLandUpgade.Checked;
      FPrj.Settings.UnlimitedTime    := chkUnlimitedTime.Checked;

      With TTSTODlcGenerator.Create() Do
      Try
        CreateMod(FPrj, AWorkSpaceProject, FPrj.Settings.MasterFiles);

        Finally
          Free();
      End;
    End;

    sptTextPools :
    Begin
      With TTSTODlcGenerator.Create() Do
      Try
        CreateSbtpMod(AWorkSpaceProject);

        Finally
          Free();
      End;
    End;
  End;
End;

Procedure TFrmDckMain.ValidateHackMasterList(AWorkSpaceProject : ITSTOWorkSpaceProjectIO);
Var lPrj : ITSTOXMLProject;
    X    : Integer;
Begin
  If (AWorkSpaceProject.ProjectType = sptScript) And
     (AWorkSpaceProject.WorkSpace.HackSettings.HackMasterList.Count = 0) And
     MessageConfirm('Hack MasterList is empty.'#$D#$A'Do you want to create a new one?') Then
  Begin
    lPrj := TTSTOXmlTSTOProject.NewTSTOProject();
    Try
      lPrj.Settings.SourcePath := AWorkSpaceProject.SrcPath;

      For X := 0 To FPrj.Settings.MasterFiles.Count - 1 Do
        With lPrj.Settings.MasterFiles.Add() Do
        Begin
          FileName := FPrj.Settings.MasterFiles[X].FileName;
          NodeName := FPrj.Settings.MasterFiles[X].NodeName;
          NodeKind := FPrj.Settings.MasterFiles[X].NodeKind;
        End;

      FWorkSpace.HackSettings.HackMasterList.BuildMasterList(lPrj, True);
      FWorkSpace.HackSettings.HackMasterList.Sort();
      FWorkSpace.ForceChanged();

      Finally
        lPrj := Nil;
    End;
  End;
End;

procedure TFrmDckMain.popTvWSApplyModClick(Sender: TObject);
Var lProject : ITSTOWorkSpaceProjectIO;
begin
  If FTvWorkSpace.GetNodeData(FTvWorkSpace.GetFirstSelected(), ITSTOWorkSpaceProjectIO, lProject) Then
  Try
    ApplyMod(lProject);
    MessageDlg('Done', mtCustom, [mbOk], 0);

    Finally
      lProject := Nil;
  End;
end;

procedure TFrmDckMain.popTvWSApplyAllModFromHereClick(Sender: TObject);
Var lProject : ITSTOWorkSpaceProjectIO;
    lNode    : PVirtualNode;
begin
  lNode := FTvWorkSpace.GetFirstSelected();
  While Assigned(lNode) Do
  Begin
    If FTvWorkSpace.GetNodeData(lNode, ITSTOWorkSpaceProjectIO, lProject) Then
    Try
      ApplyMod(lProject);

      Finally
        lProject := Nil;
    End;

    lNode := lNode.NextSibling;
  End;

  MessageDlg('Done', mtCustom, [mbOk], 0);
end;

procedure TFrmDckMain.popTvWSBuildModClick(Sender: TObject);
Var lWorkSpace : ITSTOWorkspaceProjectIO;
begin
  With FTvWorkSpace Do
    If GetNodeData(GetFirstSelected(), ITSTOWorkspaceProjectIO, lWorkSpace) Then
      FWorkSpace.CompileMod(lWorkSpace);
end;

procedure TFrmDckMain.popTvWSBuildAllModFromHereClick(Sender: TObject);
Var lWorkSpace : ITSTOWorkspaceProjectIO;
    lNode      : PVirtualNode;
begin
  lNode := FTvWorkSpace.GetFirstSelected();
  While Assigned(lNode) Do
  Begin
    If FTvWorkSpace.GetNodeData(lNode, ITSTOWorkspaceProjectIO, lWorkSpace) Then
    Try
      FWorkSpace.CompileMod(lWorkSpace);

      Finally
        lWorkSpace := Nil;
    End;

    lNode := lNode.NextSibling;
  End;
end;

procedure TFrmDckMain.popTvWSCleanProjectClick(Sender: TObject);
begin
  Raise Exception.Create('ToDo');
end;

procedure TFrmDckMain.popTvWSGenerateScriptsClick(Sender: TObject);
Var lWorkSpace : ITSTOWorkspaceProjectIO;
    lNode      : PVirtualNode;
begin
  With FTvWorkSpace Do
  Begin
    lNode := GetFirstSelected();

    If GetNodeData(lNode, ITSTOWorkspaceProjectIO, lWorkSpace) Then
    Begin
      ValidateHackMasterList(lWorkSpace);

      FWorkSpace.GenerateScripts(lWorkSpace);
      ReinitNode(lNode, True);

      ShowMessage('Done');
    End;
  End;
end;

procedure TFrmDckMain.popTvWSPackModClick(Sender: TObject);
Var lProject : ITSTOWorkspaceProjectIO;
begin
  With FTvWorkSpace Do
    If GetNodeData(GetFirstSelected(), ITSTOWorkspaceProjectIO, lProject) Then
    Begin
      FWorkSpace.PackMod(lProject);
      ShowMessage('Done');
    End;
end;

procedure TFrmDckMain.PackAllModFromHereClick(Sender: TObject);
Var lWorkSpace : ITSTOWorkspaceProjectIO;
    lNode      : PVirtualNode;
begin
  lNode := FTvWorkSpace.GetFirstSelected();
  While Assigned(lNode) Do
  Begin
    If FTvWorkSpace.GetNodeData(lNode, ITSTOWorkspaceProjectIO, lWorkSpace) Then
    Try
      FWorkSpace.PackMod(lWorkSpace);

      Finally
        lWorkSpace := Nil;
    End;

    lNode := lNode.NextSibling;
  End;
end;

procedure TFrmDckMain.popTvWSPopup(Sender: TObject);
  Procedure SetVisibility(ASubMenu : TSpTBXSubmenuItem; Const AVisible : Boolean);
  Var X : Integer;
  Begin
    For X := 0 To ASubMenu.Count - 1 Do
      ASubMenu[X].Visible := AVisible;
  End;

Var lNode : PVirtualNode;
    lProject : ITSTOWorkspaceProjectIO;
begin
  SetVisibility(popTvWSProjectGroupItems, False);
  SetVisibility(popTvWSProjectItems, False);
  SetVisibility(popTvWSProjectSrcFolderItems, False);

  With FTvWorkSpace Do
  Begin
    lNode := GetFirstSelected();
    If Assigned(lNode) Then
    Begin
      If GetNodeData(lNode, ITSTOWorkSpaceProjectGroupIO) Then
        SetVisibility(popTvWSProjectGroupItems, True)
      Else If GetNodeData(lNode, ITSTOWorkspaceProjectIO, lProject) Then
      Begin
        SetVisibility(popTvWSProjectItems, True);
        popTvWSProcessSooner.Enabled   := Assigned(lNode.PrevSibling);
        popTvWSProcessLater.Enabled    := Assigned(lNode.NextSibling);
        popTvWSGenerateScripts.Enabled := lProject.ProjectType = sptScript;
      End
      Else If GetNodeData(lNode, ITSTOWorkSpaceProjectSrcFolder) Then
        SetVisibility(popTvWSProjectSrcFolderItems, True)
      Else If GetNodeData(lNode, ITSTOWorkSpaceProjectSrcFile) Then
        popRemoveFile.Visible := True;
    End
    Else
      Abort;
  End;
end;

procedure TFrmDckMain.popTvWSProcessLaterClick(Sender: TObject);
begin
  With FTvWorkSpace Do
  Begin
    MoveNodeDown(GetFirstSelected());
    tbSaveWorkSpace.Enabled := True;
  End;
end;

procedure TFrmDckMain.popTvWSProcessSoonerClick(Sender: TObject);
begin
  With FTvWorkSpace Do
  Begin
    MoveNodeUp(GetFirstSelected());
    tbSaveWorkSpace.Enabled := True;
  End;
end;

procedure TFrmDckMain.popTvWSProjectConfigurationClick(Sender: TObject);
Var lWsProject : ITSTOWorkSpaceProject;
begin
  If FTvWorkSpace.GetNodeData(FTvWorkSpace.GetFirstSelected(), ITSTOWorkSpaceProject, lWsProject) Then
    With TFrmProjectSettings.Create(Self) Do
    Try
      WorkSpaceProject := lWsProject;
      AppSettings      := FPrj.Settings;

      If ShowModal() = mrOk Then
        tbSaveWorkSpace.Enabled := True;

      Finally
        Release();
    End;
end;

procedure TFrmDckMain.popTvWSProjectGroupConfigurationClick(Sender: TObject);
Var lWsProjectGroup : ITSTOWorkSpaceProjectGroup;
begin
  If FTvWorkSpace.GetNodeData(FTvWorkSpace.GetFirstSelected(), ITSTOWorkSpaceProjectGroup, lWsProjectGroup) Then
    With TFrmProjectGroupSettings.Create(Self) Do
    Try
      WorkSpaceProject := lWsProjectGroup;
      AppSettings      := FPrj.Settings;
      ShowModal();

      Finally
        Release();
    End;
end;

procedure TFrmDckMain.popTvWSRemoveProjectClick(Sender: TObject);
Var lProject : ITSTOWorkSpaceProject;
begin
  FTvWorkSpace.GetNodeData(FTvWorkSpace.GetFirstSelected(), ITSTOWorkSpaceProject, lProject);
  If MessageConfirm( 'Are you sure you want to remove ' +
                     lProject.ProjectName +
                     ' from the project group? ' ) Then
  Begin
    FWorkSpace.Remove(lProject);
    FTvWorkSpace.ReinitNode(Nil, True);
    tbSaveWorkSpace.Enabled := True;
  End;
end;

procedure TFrmDckMain.popTvWSRenameProjectClick(Sender: TObject);
begin
  Raise Exception.Create('ToDo');
end;

Procedure TFrmDckMain.DoFilterNode(Sender : TBaseVirtualTree; Node : PVirtualNode; Data : Pointer; Var Abort : Boolean);
Begin
  Sender.IsVisible[Node] := (Pos(UpperCase(PString(Data)^), UpperCase(TVirtualStringTree(Sender).Text[Node, 0])) > 0) Or (PString(Data)^ = '');
  If Sender.IsVisible[Node] And Not Sender.IsVisible[Node.Parent] Then
    Repeat
      Sender.IsVisible[Node] := True;
      Node := Node.Parent;
    Until Node = Sender.RootNode;
End;

Procedure TFrmDckMain.DoSetNodeCheckState(Sender : TBaseVirtualTree; Node : PVirtualNode; Data : Pointer; Var Abort : Boolean);
Begin
  If PBoolean(Data)^ Then
    Sender.CheckState[Node] := csCheckedNormal
  Else
    Sender.CheckState[Node] := csUncheckedNormal;
End;

Procedure TFrmDckMain.DoEditFilterButtonClick(Sender : TObject);
Var lSearch : String;
Begin
  If Sender = FEditFilter Then
  Begin
    lSearch := FEditFilter.Text;
    FTvDlcServer.IterateSubtree(Nil, DoFilterNode, @lSearch)
  End
  Else If Sender = FEditFilterRes Then
  Begin
    lSearch := FEditFilterRes.Text;
    FTvResources.IterateSubtree(Nil, DoFilterNode, @lSearch)
  End;
End;

Procedure TFrmDckMain.DoEditFilterKeyPress(Sender: TObject; var Key: Char);
Begin
  If Key = #$D Then
    DoEditFilterButtonClick(Sender);
End;

Procedure TFrmDckMain.InitPanels(APanel : TLMDDockPanel = Nil);
Var lImg : ITSTORgbFile;
Begin
  If Assigned(FCurData) Then
  Begin
    If ((Assigned(APanel) And SameText(APanel.Name, 'PanImage')) Or
        (Not Assigned(APanel) And PanImage.Visible)) And
       (FCurData.DataType = dtRbg) Then
    Begin
      If (Assigned(APanel) And (APanel.Tag <> Integer(FCurData))) Or
         Not Assigned(APanel) Then
      Begin
        lImg := TTSTORgbFile.CreateRGBFile();
        Try
          Try
            FCurData.DataStream.Position := 0;
            lImg.LoadRgbFromStream(FCurData.DataStream);
            ImgResource.Picture.Assign(lImg.Picture);
            EditImageSize.Text := IntToStr(ImgResource.Picture.Width) + ' x ' + IntToStr(ImgResource.Picture.Height);

            Except
          End;

          PanImage.Tag := Integer(FCurData);

          Finally
            lImg := Nil;
        End;
      End;

      If Assigned(APanel) Then
        Exit;
    End;

    If ((Assigned(APanel) And SameText(APanel.Name, 'PanHexEdit')) Or
        (Not Assigned(APanel) And PanHexEdit.Visible)) Then
    Begin
      If (Assigned(APanel) And (APanel.Tag <> Integer(FCurData))) Or
         Not Assigned(APanel) Then
      Begin
        FCurData.DataStream.Position := 0;
        KHexEditor.Clear();
        KHexEditor.LoadFromStream(TStream(FCurData.DataStream.InterfaceObject));

        PanHexEdit.Tag := Integer(FCurData);
      End;

      If Assigned(APanel) Then
        Exit;
    End;
  End;
End;

Procedure TFrmDckMain.CreateXmlTab(AXmlString, AXmlFileName : String);
Var lDckZone : TLMDDockZone;
    lName    : String;
    lXmlPan  : TLMDScintillaDockPanel;
    lComponent : TComponent;
Begin
  lName := '_' + StringReplace(AXmlFileName, '.', '', [rfReplaceAll]) + IntToStr(Length(ExtractFileExt(AXmlFileName)) - 1);
  lComponent := FindComponent(lName);

  If Assigned(lComponent) And (lComponent Is TLMDScintillaDockPanel) Then
  Begin
    With TLMDScintillaDockPanel(lComponent) Do
    Begin
      Lines.Text := AXmlString;
      Show();
    End;
  End
  Else
  Begin
    lXmlPan := TLMDScintillaDockPanel.Create(Self);
    lXmlPan.Name := lName;
    lXmlPan.Caption := AXmlFileName;
    lXmlPan.LanguageManager := SciLangMgr;
    //lXmlPan.Lines.Add(AXmlString);
    lXmlPan.Lines.Text := AXmlString;

    lDckZone := dckInfo.SpaceZone;
    While (lDckZone <> Nil) And (lDckZone.Kind <> zkTabs) And
          (lDckZone.ZoneCount > 0) Do
      lDckZone := lDckZone[0];

    If lDckZone <> nil Then
      dckInfo.DockControl(lXmlPan, lDckZone, alClient);

    lXmlPan.DoEnter();
  End;
End;

Procedure TFrmDckMain.ProcessCurrentNode(ANode : PVirtualNode);
Var lPkg     : ITSTOPackageNode;
    lArchive : IBinZeroFileData;
    lFile    : IBinArchivedFileData;

    lWSSrcFolder : ITSTOWorkSpaceProjectSrcFolder;
    lFileName : String;

    lPath : String;
    lZip  : IHsMemoryZipper;
    lMem  : IMemoryStreamEx;
    lImg  : ITSTORgbFile;
    lXmlStr : String;
    lBsvAnimation : IBsvAnimationIO;
Begin
  tbPackMod.Enabled     := False;
  tbUnpackMod.Enabled   := False;
  tbCreateMod.Enabled   := False;
  tbValidateXml.Enabled := False;

  ImgResource.Picture := Nil;
  EditImageSize.Text  := '';

  FBsvAnim := Nil;

//  PanHexEdit.Visible  := False;
//  PanXml.Visible      := False;
//  PanInfo.Visible     := True;
//  PanImage.Visible    := False;
//  PanSbtp.Visible     := False;

  FBCell := Nil;
  If Assigned(ANode) Then
    With TTSTOBaseTreeView(TreeFromNode(ANode)) Do
      If GetNodeData(ANode, ITSTOPackageNode, lPkg) Then
      Begin
        EditFileName.Text   := lPkg.FileName;
        EditPlatform.Text   := lPkg.PkgPlatform;
        EditTier.Text       := lPkg.Tier;
        EditMinVersion.Text := lPkg.MinVersion;
        EditVersion.Text    := lPkg.Version;
        EditLanguage.Text   := lPkg.Language;

        lPath := IncludeTrailingBackslash(FPrj.Settings.HackPath + ChangeFileExt(lPkg.FileName, ''));

        tbUnpackMod.Enabled   := lPkg.FileExist;
        //tbPackMod.Enabled     := DirectoryExists(lPath);
        tbValidateXml.Enabled := DirectoryExists(lPath);
        tbCreateMod.Enabled   := FTvWorkSpace.GetNodeData(FTvWorkSpace.GetFirstSelected(), ITSTOWorkSpaceProjectIO)
      End
      Else If GetNodeData(ANode, IBinArchivedFileData, lFile) And
              GetNodeData(ANode.Parent, IBinZeroFileData, lArchive) And
              GetNodeData(ANode.Parent.Parent, ITSTOPackageNode, lPkg) Then
      Begin
        If SameText(lFile.FileExtension, 'rgb') Or
           SameText(lFile.FileExtension, 'xml') Or
           SameText(lFile.FileExtension, 'txt') Or
           SameText(lFile.FileExtension, 'sbtp') Then
        Begin
          lZip := THsMemoryZipper.Create();
          lMem := TStringStreamEx.Create();
          Try
            lZip.ShowProgress := False;

            lZip.LoadFromFile(FPrj.Settings.DLCPath + lPkg.FileName);
            lZip.ExtractToStream(lArchive.FileName, lMem);

            lMem.Position := 0;
            lZip.LoadFromStream(lMem);

            lMem.Clear();
            lZip.ExtractToStream(lFile.FileName1, lMem);

            If SameText(lFile.FileExtension, 'rgb') Then
            Begin
              FCurData := TTSTOCurrentData.Create();
              FCurData.DataType := dtRbg;
              FCurData.DataStream.CopyFrom(TStream(lMem.InterfaceObject), 0);
              InitPanels();
            End
            Else If SameText(lFile.FileExtension, 'xml') Then
            Begin
              lXmlStr := (lMem As IStringStreamEx).DataString;
              If Copy(lXmlStr, 1, 3) = #$EF#$BB#$BF Then
                lXmlStr := Copy(lXmlStr, 4, Length(lXmlStr));
              CreateXmlTab(FormatXmlData(lXmlStr), lFile.FileName1);
  (*
              lXmlStr := (lMem As IStringStreamEx).DataString;
              If Copy(lXmlStr, 1, 3) = #$EF#$BB#$BF Then
                lXmlStr := Copy(lXmlStr, 4, Length(lXmlStr));
              lXml := LoadXMLData(lXmlStr);
              EditXml.Lines.Text := FormatXmlData(lXml.Xml.Text);
  *)

  //            PanXml.Visible  := True;
  //            PanInfo.Visible := False;
            End
            Else If SameText(lFile.FileExtension, 'txt') Then
            Begin
  //            EditXml.Lines.Text := (lMem As IStringStreamEx).DataString;
  //            PanXml.Visible  := True;
  //            PanInfo.Visible := False;
            End
            Else If SameText(lFile.FileExtension, 'sbtp') Then
            Begin
              lMem.Position := 0;
              FTvSbtpFile.TvData := TSbtpFileIO.LoadBinSbtpFile(lMem);

  //            PanSbtp.Visible := True;
  //            PanInfo.Visible := False;
            End;

            Finally
              lMem := Nil;
              lZip := Nil;
          End;
        End
        Else If SameText(lFile.FileExtension, 'bcell') Then
        Begin
          lZip := THsMemoryZipper.Create();
          lMem := TStringStreamEx.Create();
          Try
            lZip.ShowProgress := False;

            lZip.LoadFromFile(FPrj.Settings.DLCPath + lPkg.FileName);
            lZip.ExtractToStream(lArchive.FileName, lMem);

            lMem.Position := 0;
            lZip.LoadFromStream(lMem);

            FBCell := TTSTOBCellFile.CreateBCellAnimation(ImgResource);
            FBCell.LoadFromZip(lFile.FileName1, lZip);

  //          PanImage.Visible := True;

            Finally
              lMem := Nil;
              lZip := Nil;
          End;
        End;
      End
      Else If GetNodeData(ANode, IBsvAnimationIO, lBsvAnimation) Then
        FBsvAnim := lBsvAnimation.CreateAnimation(ImgResource)
      Else If GetNodeData(ANode, ITSTORgbFile, lImg) Then
      Begin
        lMem := TMemoryStreamEx.Create();
        Try
          lImg.SaveRgbToStream(lMem);

          FCurData := TTSTOCurrentData.Create();
          FCurData.DataType := dtRbg;
          FCurData.DataStream.CopyFrom(TStream(lMem.InterfaceObject), 0);
          InitPanels();

          Finally
            lMem := Nil;
        End;
      End
      Else If GetNodeData(ANode.Parent, ITSTOWorkSpaceProjectSrcFolder, lWSSrcFolder) Then
      Begin
        lFileName := IncludeTrailingBackSlash(lWSSrcFolder.SrcPath) + lWSSrcFolder[ANode.Index].FileName;
        If SameText(ExtractFileExt(lFileName), '.rgb') Or
           //SameText(lFile.FileExtension, 'xml') Or
           SameText(ExtractFileExt(lFileName), '.txt') Or
           SameText(ExtractFileExt(lFileName), '.sbtp') And
           FileExists(lFileName) Then
        Begin
          lMem := TStringStreamEx.Create();
          Try
            lMem.LoadFromFile(lFileName);

            If SameText(ExtractFileExt(lFileName), '.rgb') Then
            Begin
              FCurData := TTSTOCurrentData.Create();
              FCurData.DataType := dtRbg;
              FCurData.DataStream.CopyFrom(TStream(lMem.InterfaceObject), 0);
              InitPanels();
            End
            Else If SameText(ExtractFileExt(lFileName), '.txt') Then
            Begin
  //            EditXml.Lines.Text := (lMem As IStringStreamEx).DataString;
  //            PanXml.Visible  := True;
  //            PanInfo.Visible := False;
            End
            Else If SameText(ExtractFileExt(lFileName), '.sbtp') Then
            Begin
              lMem.Position := 0;
              FTvSbtpFile.TvData := TSbtpFileIO.LoadBinSbtpFile(lMem);

  //            PanSbtp.Visible := True;
  //            PanInfo.Visible := False;
            End;

            Finally
              lMem := Nil;
          End;
        End
        Else If SameText(ExtractFileExt(lFileName), '.bcell') Then
        Begin
          lZip := THsMemoryZipper.Create();
          lMem := TStringStreamEx.Create();
          Try
            lZip.ShowProgress := False;

            lZip.LoadFromFile(FPrj.Settings.DLCPath + lPkg.FileName);
            lZip.ExtractToStream(lArchive.FileName, lMem);

            lMem.Position := 0;
            lZip.LoadFromStream(lMem);

            FBCell := TTSTOBCellFile.CreateBCellAnimation(ImgResource);
            FBCell.LoadFromZip(lFile.FileName1, lZip);

  //          PanImage.Visible := True;

            Finally
              lMem := Nil;
              lZip := Nil;
          End;
        End;
      End
      Else If GetNodeData(ANode, ITSTORgbFile, lImg) Then
      Begin
        ImgResource.Picture.Assign(lImg.Picture);
        lImg.ReleaseGraphic();
  //      PanImage.Visible := True;
      End;
End;

Type
  PPackageList = ^ITSTOPackageNodes;

Procedure TFrmDckMain.GetPackageList(Sender : TBaseVirtualTree; Node : PVirtualNode; Data : Pointer; Var Abort : Boolean);
Var lPkg : ITSTOPackageNode;
Begin
  If (Node.CheckState = csCheckedNormal) And
     Sender.IsVisible[Node] And
     TTSTOBaseTreeView(Sender).GetNodeData(Node, ITSTOPackageNode, lPkg) Then
    PPackageList(Data).Add(lPkg);
End;

Procedure TFrmDckMain.GetRgbNodeList(Sender : TBaseVirtualTree; Node : PVirtualNode; Data : Pointer; Var Abort : Boolean);
Var lPkg  : ITSTOPackageNode;
    lMem  : IMemoryStreamEx;
    lZip  : IHsMemoryZipper;
    X, Y  : Integer;
Begin
  If TTSTOBaseTreeView(Sender).GetNodeData(Node, ITSTOPackageNode, lPkg) And lPkg.FileExist Then
  Begin
    If (Node.States * [vsHasChildren] <> []) And (Node.ChildCount = 0) Then
    Begin
      lZip := THsMemoryZipper.Create();
      lMem := TMemoryStreamEx.Create();
      Try
        lZip.LoadFromFile(FPrj.Settings.DLCPath + lPkg.FileName);
        lZip.ExtractToStream('0', lMem);
        lMem.Position := 0;
        lPkg.ZeroFile.LoadFromStream(lMem);

        Finally
          lMem := Nil;
          lZip := Nil;
      End;
    End;

    For X := 0 To lPkg.ZeroFile.FileDatas.Count - 1 Do
      For Y := 0 To lPkg.ZeroFile.FileDatas[X].ArchivedFiles.Count - 1 Do
        If SameText(lPkg.ZeroFile.FileDatas[X].ArchivedFiles[Y].FileExtension, 'rgb') Then
        Begin
          If PPackageList(Data).IndexOf(lPkg As IInterfaceEx) = -1 Then
            PPackageList(Data).Add(lPkg);
          Break;
        End;
  End;
End;

Procedure TFrmDckMain.ExtractRgbFiles(APackageList : ITSTOPackageNodes);
  Function GetRgbFiles(APackage : ITSTOPackageNode) : IBinArchivedFileDatas;
  Var X, Y : Integer;
  Begin
    Result := TBinZeroFile.CreateBinArchivedFileDatas();

    For X := 0 To APackage.ZeroFile.FileDatas.Count - 1 Do
      For Y := 0 To APackage.ZeroFile.FileDatas[X].ArchivedFiles.Count - 1 Do
        If SameText(APackage.ZeroFile.FileDatas[X].ArchivedFiles[Y].FileExtension, 'rgb') Then
          Result.Add(APackage.ZeroFile.FileDatas[X].ArchivedFiles[Y]);

    Result.Sort();
  End;

  Function LocatePictureInResource(Const AFileName : String; ACrc32 : DWord; AWidth, AHeight : Integer) : Boolean;
  Var X, Y : Integer;
  Begin
    Result := False;

    For X := 0 To FResources.Count - 1 Do
      For Y := 0 To FResources[X].ResourceFiles.Count - 1 Do
      Begin
        If SameText(FResources[X].ResourceFiles[Y].FileName, AFileName) And
           (FResources[X].ResourceFiles[Y].Crc32 = ACrc32) And
           (FResources[X].ResourceFiles[Y].Width = AWidth) And
           (FResources[X].ResourceFiles[Y].Height = AHeight) Then
        Begin
          Result := True;
          Break;
        End;
      End;
  End;

Var lProgress : IRgbProgress;
    X, Y      : Integer;
    lZip1     ,
    lZip2     : IHsMemoryZipper;
    lMem      : IMemoryStreamEx;
    lRgbFiles : IBinArchivedFileDatas;
    lCurArch  : Integer;
    lRgbFile  : ITSTORgbFile;
    lPath     : AnsiString;
    lCurPath  : AnsiString;
    lConfirm  : TModalResult;
    lResPath  : ITSTOResourcePath;
    lImg      : TImageData;
Begin
  If APackageList.Count > 0 Then
  Begin
    If FPrj.Settings.ResourcePath = '' Then
      FPrj.Settings.ResourcePath := AnsiString(ExtractFilePath(ParamStr(0)) + '\Res\');
    lPath := FPrj.Settings.ResourcePath;

    If Not DirectoryExists(lPath) Then
      ForceDirectories(lPath);

    lProgress := TRgbProgress.CreateRgbProgress();
    lProgress.Show();
    Try
      lConfirm := mrNone;
      
      For X := 0 To APackageList.Count - 1 Do
      Begin
        lProgress.CurOperation := ExtractFileName(APackageList[X].FileName);
        lProgress.ItemProgress := Round(X / APackageList.Count * 100);

        lResPath := FResources.PathByName(ChangeFileExt(ExtractFileName(APackageList[X].FileName), ''));
        If Not Assigned(lResPath) Then
        Begin
          lResPath := FResources.Add();
          lResPath.ResourcePath := ChangeFileExt(ExtractFileName(APackageList[X].FileName), '');
        End;

        lZip1 := THsMemoryZipper.Create();
        Try
          lZip1.ShowProgress := False;
          lZip1.LoadFromFile(FPrj.Settings.DLCPath + APackageList[X].FileName);
          lRgbFiles := GetRgbFiles(APackageList[X]);
          Try
            If lRgbFiles.Count > 0 Then
            Begin
              lZip2    := THsMemoryZipper.Create();
              lMem     := TMemoryStreamEx.Create();
              lRgbFile := TTSTORgbFile.CreateRGBFile();
              Try
                lZip2.ShowProgress := False;
                lCurArch := -1;

                For Y := 0 To lRgbFiles.Count - 1 Do
                Begin
                  If lCurArch <> lRgbFiles[Y].ArchiveFileId Then
                  Begin
                    lCurArch := lRgbFiles[Y].ArchiveFileId;

                    lMem.Clear();
                    lZip1.ExtractToStream(APackageList[X].ZeroFile.FileDatas[lCurArch].FileName, lMem);
                    lZip2.LoadFromStream(lMem);
                  End;

                  lProgress.CurArchiveName  := lRgbFiles[Y].FileName1;
                  lProgress.ArchiveProgress := Round(Y / lRgbFiles.Count * 100);

                  lCurPath := IncludeTrailingBackSlash(lPath + ChangeFileExt(ExtractFileName(APackageList[X].FileName), ''));
                  If Not DirectoryExists(lCurPath) Then
                    ForceDirectories(lCurPath);

                  If Not (lConfirm In [mrYesToAll, mrNoToAll]) Then
                    If FileExists(lCurPath + ChangeFileExt(lRgbFiles[Y].FileName1, '.png')) Then
                    Begin
                      lProgress.Hide();
                      lConfirm := MessageDlg('The file ' + ChangeFileExt(lRgbFiles[Y].FileName1, '.png') + ' aleready exist.'#$D#$A'Do you want to overwrite it?', mtConfirmation, [mbYes, mbNo, mbYesToAll, mbNoToAll], 0);
                      lProgress.Show();
                    End;

                  If (lConfirm In [mrNone, mrYes, mrYesToAll]) Or
                     Not FileExists(lCurPath + ChangeFileExt(lRgbFiles[Y].FileName1, '.png')) Then
                  Begin
                    lMem.Clear();
                    lZip2.ExtractToStream(lRgbFiles[Y].FileName1, lMem);
                    Try
                      lRgbFile.LoadRgbFromStream(lMem);

                      lMem.Clear();
                      lRgbFile.Picture.SaveToStream(TStream(lMem.InterfaceObject));
                      lMem.Position := 0;

                      If Not LocatePictureInResource(
                         ChangeFileExt(lRgbFiles[Y].FileName1, '.png'),
                         GetCrc32Value(TStream(lMem.InterfaceObject)),
                         lRgbFile.Width, lRgbFile.Height) Then
                        lMem.SaveToFile(lCurPath + ChangeFileExt(lRgbFiles[Y].FileName1, '.png'));

                      Except
                    End;
                  End;

                  If FileExists(lCurPath + ChangeFileExt(lRgbFiles[Y].FileName1, '.png')) Then
                    If Not Assigned(lResPath.ResourceFiles.FileByName(ChangeFileExt(lRgbFiles[Y].FileName1, '.png'))) Then
                    Begin
                      lMem.Clear();
                      With lResPath.ResourceFiles.Add() Do
                      Begin
                        lMem.LoadFromFile(lCurPath + ChangeFileExt(lRgbFiles[Y].FileName1, '.png'));
                        FileName := ChangeFileExt(lRgbFiles[Y].FileName1, '.png');
                        Crc32    := GetCrc32Value(TStream(lMem.InterfaceObject));

                        lMem.Position := 0;
                        Try
                          LoadImageFromStream(TStream(lMem.InterfaceObject), lImg);
                          Width  := lImg.Width;
                          Height := lImg.Height;

                          Finally
                            FreeImage(lImg);
                        End;
                      End;
                    End;
                End;

                Finally
                  lRgbFile := Nil;
                  lMem     := Nil;
                  lZip2    := Nil;
              End;
            End;

            Finally
              lRgbFiles := Nil;
          End;

          Finally
            lZip1 := Nil;
        End;
      End;

      Finally
        lProgress := Nil;
    End;
  End;

  FResources.SaveToFile(FPrj.Settings.ResourcePath + 'ResourceIndex.bin');
  FTvResources.LoadData();
End;

procedure TFrmDckMain.tbBuildListClick(Sender: TObject);
Var lDateStr : String;
    lMasterList : ITSTOHackMasterListIO;
begin
  With TOpenDialog.Create(Self) Do
  Try
    Filter := 'Xml File|*.xml';

    If Execute() Then
    Begin
      lDateStr := FormatDateTime('yyyymmdd', Now());

      lMasterList := TTSTOHackMasterListIO.CreateHackMasterList();
      lMasterList.LoadFromFile(FileName);

      With TTSTOItemLister.CreateLister() Do
      Begin
{
        ListNonFreeItems(FileName, ExtractFilePath(FileName) + 'LstNonFree - ' + lDateStr + '.xml');
        ListUniqueItems(FileName, ExtractFilePath(FileName) + 'LstNonUnique - ' + lDateStr + '.xml');
        ListRequirementItems(FileName, ExtractFilePath(FileName) + 'LstReqs - ' + lDateStr + '.xml');
        ListNonSellableItems(FileName, ExtractFilePath(FileName) + 'LstNonSellable - ' + lDateStr + '.xml');
        ListStoreRequirement(FileName, ExtractFilePath(FileName) + 'StoreReqs - ' + lDateStr + '.xml');
}
        lMasterList.BuildStoreMenu(ExtractFilePath(FileName) + 'kahn_storemenus - ' + lDateStr + '.xml');
        lMasterList.BuildInventoryMenu(ExtractFilePath(FileName) + 'kahn_inventorymenus - ' + lDateStr + '.xml');
        lMasterList.BuildStoreItems(ExtractFilePath(FileName) + 'kahn_menuitems - ' + lDateStr + '.xml');
        lMasterList.BuildFreeItems(ExtractFilePath(FileName) + 'kahn_freeitems - ' + lDateStr + '.xml');
        lMasterList.BuildUniqueItems(ExtractFilePath(FileName) + 'kahn_uniqueitems - ' + lDateStr + '.xml');
        lMasterList.BuildNonSellableItems(ExtractFilePath(FileName) + 'kahn_nonsellableitems - ' + lDateStr + '.xml');
        lMasterList.BuildReqsItems(ExtractFilePath(FileName) + 'kahn_requirementitems - ' + lDateStr + '.xml');
        lMasterList.BuildDeleteBadItems(ExtractFilePath(FileName) + 'kahn_DeleteBadItems - ' + lDateStr + '.xml');
//        lMasterList.SaveToFile(ChangeFileExt(FileName, '-2.xml'));
        ShowMessage('Done');
      End;
    End;

    Finally
      Free();
  End;
end;

procedure TFrmDckMain.tbCreateMasterListClick(Sender: TObject);
Var lSelDir  : AnsiString;
    lHackML  : ITSTOHackMasterListIO;
    lPrj     : ITSTOXMLProject;
    lDateStr : AnsiString;
    X        : Integer;
begin
  If SelectDirectoryEx('Source Directory', FPrj.Settings.HackPath,
    lSelDir,True, False, False) Then
  Begin
    lDateStr := FormatDateTime('yyyymmdd', Now());

    lHackML := TTSTOHackMasterListIO.CreateHackMasterList();
    lPrj := TTSTOXmlTSTOProject.NewTSTOProject();
    Try
      lPrj.Settings.SourcePath := lSelDir;

      For X := 0 To FPrj.Settings.MasterFiles.Count - 1 Do
        With lPrj.Settings.MasterFiles.Add() Do
        Begin
          FileName := FPrj.Settings.MasterFiles[X].FileName;
          NodeName := FPrj.Settings.MasterFiles[X].NodeName;
          NodeKind := FPrj.Settings.MasterFiles[X].NodeKind;
        End;

      lHackML.BuildMasterList(lPrj);
      lHackML.Sort();
      lHackML.SaveToFile(ExtractFilePath(ExcludeTrailingBackslash(lSelDir)) + 'HackMasterList - ' + lDateStr + '.xml', lPrj);

      ShowMessage('Done');

      Finally
        lPrj := Nil;
        lHackML := Nil;
    End;
  End;
end;

procedure TFrmDckMain.popDiffHackMasterListClick(
  Sender: TObject);
Var lSelDir  : AnsiString;
    lHackML  : ITSTOHackMasterListIO;
    lPrj     : ITSTOXMLProject;
    lDateStr : AnsiString;
    X        : Integer;
begin
  If SelectDirectoryEx('Source Directory', FPrj.Settings.HackPath,
    lSelDir,True, False, False) Then
  Begin
    lDateStr := FormatDateTime('yyyymmdd', Now());

    lHackML := TTSTOHackMasterListIO.CreateHackMasterList();
    lPrj := TTSTOXmlTSTOProject.NewTSTOProject();
    Try
      lPrj.Settings.SourcePath := lSelDir;

      For X := 0 To FPrj.Settings.MasterFiles.Count - 1 Do
        With lPrj.Settings.MasterFiles.Add() Do
        Begin
          FileName := FPrj.Settings.MasterFiles[X].FileName;
          NodeName := FPrj.Settings.MasterFiles[X].NodeName;
          NodeKind := FPrj.Settings.MasterFiles[X].NodeKind;
        End;

      lHackML.BuildMasterList(lPrj, True);
      lHackML.Sort();
      CreateXmlTab(FWorkSpace.HackSettings.HackMasterList.GetDiff(lHackML).AsXml, 'HackMasterListDiff.xml');

      Finally
        lPrj := Nil;
        lHackML := Nil;
    End;
  End;
end;

procedure TFrmDckMain.tbCreateModOldClick(Sender: TObject);
Var lPkg  : ITSTOPackageNode;
    lPath : AnsiString;
    lProject : ITSTOWorkSpaceProjectIO;
begin
  If FTvDlcServer.GetNodeData(FTvDlcServer.GetFirstSelected(), ITSTOPackageNode, lPkg) Then
  Try
    lPath := AnsiString(IncludeTrailingBackSlash(FPrj.Settings.HackPath + ChangeFileExt(lPkg.FileName, '')));
    FPrj.Settings.SourcePath := lPath + '0\';
    FPrj.Settings.TargetPath := lPath + '1.src\';

    If Pos('GAMESCRIPT', UpperCase(lPkg.FileName)) > 0 Then
    Begin
      FPrj.Settings.AllFreeItems     := chkAllFree.Checked;
      FPrj.Settings.NonUnique        := chkNonUnique.Checked;
      FPrj.Settings.BuildCustomStore := chkBuildStore.Checked;
      FPrj.Settings.InstantBuild     := chkInstantBuild.Checked;
      FPrj.Settings.FreeLand         := chkFreeLandUpgade.Checked;
      FPrj.Settings.UnlimitedTime    := chkUnlimitedTime.Checked;

      With FTvWorkSpace Do
        If GetNodeData(GetFirstSelected(), ITSTOWorkSpaceProjectIO, lProject) Then
          With TTSTODlcGenerator.Create() Do
          Try
            CreateMod(FPrj, lProject, FPrj.Settings.MasterFiles);
            MessageDlg('Done', mtCustom, [mbOk], 0);

            Finally
              Free();
          End;
    End
    Else If Pos('TEXTPOOL', UpperCase(lPkg.FileName)) > 0 Then
    Begin
      With FTvWorkSpace Do
        If GetNodeData(GetFirstSelected(), ITSTOWorkSpaceProjectIO, lProject) Then
          With TTSTODlcGenerator.Create() Do
          Try
            CreateSbtpMod(lProject);
            MessageDlg('Done', mtCustom, [mbOk], 0);

            Finally
              Free();
          End;
    End;

    Finally
      lPkg := Nil;
  End;
end;

procedure TFrmDckMain.tbDownloadOldClick(Sender: TObject);
Var lPkgList  : ITSTOPackageNodes;
    lDown     : ITSTODownloader;
begin
  lPkgList := TTSTOPackageNodes.Create();
  Try
    FTvDlcServer.IterateSubtree(Nil, GetPackageList, @lPkgList);

    If lPkgList.Count > 0 Then
    Begin
      lDown := TTSTODownloader.CreateDownloader();
      Try
        lDown.ServerName   := FPrj.Settings.DLCServer;
        lDown.DownloadPath := FPrj.Settings.DLCPath;
        lDown.DownloadFiles(lPkgList);

        Finally
          lDown := Nil;
      End;

      FTvDlcServer.LoadData();
    End
    Else
      MessageDlg('No file selected', mtError, [mbOK], 0);

    Finally
      lPkgList := Nil;
  End;
end;

procedure TFrmDckMain.tbExtractRgbOldClick(Sender: TObject);
Var lPkgList : ITSTOPackageNodes;
    lNode     : PVirtualNode;
    lTierItem : ITSTOTierPackageNode;
begin
  If MessageDlg('Do you want to extract RGB Files?', mtConfirmation, [mbYes, mbNo], 0) = mrYes Then
  Begin
    AppLogFile('Extracting Rgb files from (1) : ' + FCurDlcIndex);
    lPkgList := TTSTOPackageNodes.Create();
    Try
      With FTvDlcServer Do
      Begin
        lNode := GetFirstSelected();

        If GetNodeData(lNode, ITSTOTierPackageNode, lTierItem) Then
        Try
          If (lTierItem.Packages.Count > 0) And (lNode.ChildCount = 0) Then
          Begin
            BeginUpdate();
            Try
              ReinitChildren(lNode, False)

              Finally
                EndUpdate();
            End;
          End;

          Finally
            lTierItem := Nil;
        End;
      End;

      FTvDlcServer.IterateSubtree(FTvDlcServer.GetFirstSelected(), GetRgbNodeList, @lPkgList);
      lPkgList.Sort();
      ExtractRgbFiles(lPkgList);

      Finally
        lPkgList := Nil;
    End;
    AppLogFile('Extracting Rgb files from (2) : ' + FCurDlcIndex);
  End;
end;

procedure TFrmDckMain.tbPackModOldClick(Sender: TObject);
Var lPrj : ITSTOXMLProject;
    lPkg : ITSTOPackageNode;
    lSr  : TSearchRec;
    lPath : AnsiString;
    lMem : IMemoryStreamEx;
begin
  If FTvDlcServer.GetNodeData(FTvDlcServer.GetFirstSelected(), ITSTOPackageNode, lPkg) Then
  Try
    lPrj := TTSTOXmlTSTOProject.GetTSTOProject(LoadXMLData(FPrj.Xml));
    lPrj.ProjectFiles.Clear();
    Try
      lPath := AnsiString(IncludeTrailingBackSlash(FPrj.Settings.HackPath + ChangeFileExt(lPkg.FileName, '')));
      If FindFirst(lPath + '*.src', faDirectory, lSr) = 0 Then
      Try
        With lPrj.ProjectFiles.Add() Do
        Begin
          Repeat
            SourcePaths.Add(AnsiString(IncludeTrailingBackSlash(lPath + lSr.Name)));
          Until FindNext(lSr) <> 0;

          OutputPath := AnsiString(IncludeTrailingBackSlash(lPrj.Settings.DLCPath + ExtractFilePath(lPkg.FileName)));
          OutputFileName := AnsiString(ExtractFileName(lPkg.FileName));
        End;

        Finally
          FindClose(lSr);
      End;

      With TTSTODlcGenerator.Create() Do
      Try
        If FileExists(lPath + 'ZeroCrc.hex') Then
        Begin
          lMem := TMemoryStreamEx.Create();
          Try
            lMem.LoadFromFile(lPath + 'ZeroCrc.hex');
            CreateRootDLC(lPrj, lMem.ReadDWord());

            Finally
              lMem := Nil;
          End;
        End
        Else
          CreateDLCEx(lPrj);

        MessageDlg('Done', mtCustom, [mbOk], 0);

        Finally
          Free();
      End;

      Finally
        lPrj := Nil;
    End;

    Finally
      lPkg := Nil;
  End;
end;

procedure TFrmDckMain.tbSaveWorkSpaceClick(Sender: TObject);
begin
  FWorkSpace.SaveToFile(FWorkSpace.FileName);
//  FHackTemplate.SaveToFile(FHackTemplate.FileName);

  tbSaveWorkSpace.Enabled := False;
end;

procedure TFrmDckMain.tbSynchOldClick(Sender: TObject);
begin
  With TTSTODlcGenerator.Create() Do
  Try
    DownloadDLCIndex(FPrj);

    Finally
      Free();
  End;

  FTvDlcServer.LoadData();
end;

procedure TFrmDckMain.tbUnpackModOldClick(Sender: TObject);
Var lZip : IHsMemoryZipper;
    lPkg : ITSTOPackageNode;
    lMem : IMemoryStreamEx;
    lMem2 : IMemoryStreamEx;
    lPath : String;
    X : Integer;
    lPkgList : ITSTOPackageNodes;
    lWSProject : ITSTOWorkSpaceProjectGroupIO;
    lBln : Boolean;
    lFileType : WideString;
begin
  lPkgList := TTSTOPackageNodes.Create();
  Try
    FTvDlcServer.IterateSubtree(Nil, GetPackageList, @lPkgList);
    If lPkgList.Count = 0 Then
      If FTvDlcServer.GetNodeData(FTvDlcServer.GetFirstSelected(), ITSTOPackageNode, lPkg) Then
        lPkgList.Add(lPkg);

    If lPkgList.Count > 0 Then
    Begin
      For X := 0 To lPkgList.Count - 1 Do
      Begin
        lPath := FPrj.Settings.HackPath + ChangeFileExt(lPkgList[X].FileName, '');
        If Not DirectoryExists(lPath) Then
          ForceDirectories(lPath);

        lZip := THsMemoryZipper.Create();
        lMem := TMemoryStreamEx.Create();
        Try
          lZip.LoadFromFile(FPrj.Settings.DLCPath + lPkgList[X].FileName);
          lZip.ExtractToStream('1', lMem);

          If lMem.Size > 0 Then
          Begin
            lZip.LoadFromStream(lMem);
            lZip.ExtractFiles('*.*', lPath + '\0');
            lZip.ExtractFiles('*.*', lPath + '\1.src');

            If FileExists(FPrj.Settings.HackFileName) Then
            Begin
              lFileType := 'gamescripts';
              If (Pos(lFileType, lPkgList[X].FileName) > 0) Then
              Begin
                lMem.Clear();
                lZip.LoadFromFile(FPrj.Settings.HackFileName);
                lZip.ExtractToStream('GameScripts', lMem);
                lZip.LoadFromStream(lMem);
                lZip.ExtractFiles('*.*', lPath);
              End;
            End;
          End;

          lMem.Clear();
          lZip.LoadFromFile(FPrj.Settings.DLCPath + lPkgList[X].FileName);
          lZip.ExtractToStream('0', lMem);
          lMem.Position := lMem.Size - SizeOf(DWord);
          lMem2 := TMemoryStreamEx.Create();
          Try
            lMem2.WriteDWord(lMem.ReadDWord(True));
            lMem2.SaveToFile(lPath + '\ZeroCrc.hex');

            Finally
              lMem2 := Nil;
          End;

          Finally
            lMem := Nil;
            lZip := Nil;
        End;
      End;

      lPath := IncludeTrailingBackSlash(FPrj.Settings.HackPath + ExtractFilePath(lPkgList[0].FileName));
      lWSProject := TTSTOWorkSpaceProjectGroupIO.CreateProjectGroup();
      Try
        lWSProject.CreateWsGroupProject(lPath, FPrj.Settings.HackFileName);
        //lWSProject.SaveToFile(lPath + ExtractFileName(ExcludeTrailingBackslash(lPath)) + '.xml');
        lWSProject.SaveToFile(lPath + ExtractFileName(ExcludeTrailingBackslash(lPath)) + '.wspg');

        Finally
          lWSProject := Nil;
      End;
    End;

    lBln := False;
    FTvDlcServer.IterateSubtree(Nil, DoSetNodeCheckState, @lBln);

    Finally
      lPkgList := Nil;
  End;
end;

procedure TFrmDckMain.tbValidateXmlOldClick(Sender: TObject);
Var lPrj  : ITSTOXMLProject;
    lSr   : TSearchRec;
    lPath : String;
    lPkg  : ITSTOPackageNode;
begin
  If FTvDlcServer.GetNodeData(FTvDlcServer.GetFirstSelected(), ITSTOPackageNode, lPkg) Then
  Begin
    lPrj  := TTSTOXmlTSTOProject.NewTSTOProject();
    lPath := IncludeTrailingBackslash(FPrj.Settings.HackPath + ChangeFileExt(lPkg.FileName, ''));
    Try
      If FindFirst(lPath + '*.src', faDirectory, lSr) = 0 Then
      Try
        With lPrj.ProjectFiles.Add() Do
        Repeat
          SourcePaths.Add(AnsiString(IncludeTrailingBackslash(lPath + lSr.Name)));
        Until FindNext(lSr) <> 0;

        Finally
          FindClose(lSr);
      End;

      With TTSTODlcGenerator.Create() Do
      Try
        ValidateXmlFiles(lPrj);

        Finally
          Free();
      End;

      Finally
        lPrj := Nil;
    End;
  End;
end;

procedure TFrmDckMain.tsScriptTemplateActiveTabChange(Sender: TObject; TabIndex: Integer);
Var lNode : PVirtualNode;
    lNodeData : ITSTOScriptTemplateHackIO;
begin
  lNode := FTvScriptTemplate.GetFirstSelected();
  If Assigned(lNode) And FTvScriptTemplate.GetNodeData(lNode, ITSTOScriptTemplateHackIO, lNodeData) Then
  Begin
    Case TabIndex Of
      0 : EditScriptTemplate.Lines.Text := lNodeData.TemplateFile;

      1 :
      Begin
        lNodeData.TemplateFile := EditScriptTemplate.Lines.Text;
        EditScriptTemplate.Lines.Text := lNodeData.GenenrateScript(FWorkSpace.HackSettings.HackMasterList);
      End;
    End;
  End;
end;

Procedure TFrmDckMain.DoTvDlcServerOnFocusChanged(Sender : TBaseVirtualTree;
  Node : PVirtualNode; Column : TColumnIndex);
Begin
  ProcessCurrentNode(Node);
End;

Procedure TFrmDckMain.DoTvWorkSpaceDblClick(Sender: TObject);
Var lSrcFolder : ITSTOWorkSpaceProjectSrcFolder;
    lStrStream : IStringStreamEx;
    lXmlStr    : String;
Begin
  With FTvWorkSpace Do
    If Assigned(FocusedNode) And
       GetNodeData(FocusedNode.Parent, ITSTOWorkSpaceProjectSrcFolder, lSrcFolder) Then
    Begin
      If FileExists(IncludeTrailingBackSlash(lSrcFolder.SrcPath) + lSrcFolder[FocusedNode.Index].FileName) Then
      Begin
        If SameText(ExtractFileExt(lSrcFolder[FocusedNode.Index].FileName), '.xml') Then
        Begin
          lStrStream := TStringStreamEx.Create();
          Try
            lStrStream.LoadFromFile(IncludeTrailingBackSlash(lSrcFolder.SrcPath) + lSrcFolder[FocusedNode.Index].FileName);
            lXmlStr := lStrStream.DataString;
            If Copy(lXmlStr, 1, 3) = #$EF#$BB#$BF Then
              lXmlStr := Copy(lXmlStr, 4, Length(lXmlStr));

            CreateXmlTab(FormatXmlData(lXmlStr), lSrcFolder[FocusedNode.Index].FileName);

            Finally
              lStrStream := Nil;
          End;
        End;
      End;
    End;
End;

Procedure TFrmDckMain.DoTvWorkSpaceOnFocusChanged(Sender : TBaseVirtualTree;
  Node : PVirtualNode; Column : TColumnIndex);
Begin
  ProcessCurrentNode(Node);
End;

Procedure TFrmDckMain.DoTvResourcesOnFocusChanged(Sender : TBaseVirtualTree;
  Node : PVirtualNode; Column : TColumnIndex);
Var lRes : ITSTOResourcePath;
    lFileName : String;
    lRgbFile  : ITSTORgbFile;
Begin
  If Assigned(Node.Parent) And FTvResources.GetNodeData(Node.Parent, ITSTOResourcePath, lRes) Then
  Begin
    lFileName := IncludeTrailingBackslash(FPrj.Settings.ResourcePath) +
                 lRes.ResourcePath + '\' + lRes.ResourceFiles[Node.Index].FileName;
    If FileExists(lFileName) Then
    Begin
      If SameText(ExtractFileExt(lFileName), '.png') Then
      Begin
        lRgbFile := TTSTORgbFile.CreateRGBFile();
        Try
          lRgbFile.LoadPngFromFile(lFileName);
          ImgResource.Picture.Assign(lRgbFile.Picture);

          EditImageSize.Text := IntToStr(lRgbFile.Picture.Width) + ' x ' + IntToStr(lRgbFile.Picture.Height);

          Finally
            lRgbFile.ReleaseGraphic();
            lRgbFile := Nil;
        End;
      End;
    End;
  End;
End;

Procedure TFrmDckMain.DoTvScriptTemplateOnFocusChanged(Sender : TBaseVirtualTree;
  Node : PVirtualNode; Column : TColumnIndex);
Var lTemplate : ITSTOScriptTemplateHackIO;
Begin
  If Assigned(FPrevSTHack) And (tsScriptTemplate.ActiveTabIndex = 0) Then
    FPrevSTHack.TemplateFile := EditScriptTemplate.Lines.Text;

  If FTvScriptTemplate.GetNodeData(Node, ITSTOScriptTemplateHackIO, lTemplate) Then
  Begin
    EditScriptTemplate.SelectedLanguage := 'XML';
    EditScriptTemplate.Folding := EditScriptTemplate.Folding + [foldFold];
    If tsScriptTemplate.ActiveTabIndex = 0 Then
      EditScriptTemplate.Lines.Text := lTemplate.TemplateFile
    Else
      EditScriptTemplate.Lines.Text := lTemplate.GenenrateScript(FWorkSpace.HackSettings.HackMasterList);

    FTvSTSettings.TvData  := lTemplate;
    FTvSTVariables.TvData := lTemplate.Variables;
    FPrevSTHack := lTemplate;
  End;
End;

Procedure TFrmDckMain.DoSetNodeExpandedState(Sender : TBaseVirtualTree; Node : PVirtualNode; Data : Pointer; Var Abort : Boolean);
Begin
  If Sender.GetNodeLevel(Node) < 4 Then
    Sender.Expanded[Node] := PBoolean(Data)^;
End;

procedure TFrmDckMain.ExpandAll1Click(Sender: TObject);
Var lBln : Boolean;
begin
  lBln := True;
  FTvDlcServer.BeginUpdate();
  Try
    FTvDlcServer.IterateSubtree(FTvDlcServer.GetFirstSelected(), DoSetNodeExpandedState, @lBln, [vsVisible])
    Finally
      FTvDlcServer.EndUpdate();
  End;
end;

procedure TFrmDckMain.ExportasXML1Click(Sender: TObject);
Var lNode : PVirtualNode;
    lArch : IBinArchivedFileData;
    lPkg  : ITSTOPackageNode;

    lZip1 ,
    lZip2 : IHsMemoryZipper;
    lMem1 ,
    lMem2 : IMemoryStreamEx;
    X, Y  : Integer;
    lSbtp : ISbtpFileIO;
begin
  lNode := FTvDlcServer.GetFirstSelected();

  If FTvDlcServer.GetNodeData(lNode, IBinArchivedFileData, lArch) Then
  Begin
    Raise Exception.Create('ToDo');
  End
  Else If FTvDlcServer.GetNodeData(lNode, ITSTOPackageNode, lPkg) Then
  Begin
    If lNode.ChildCount = 0 Then
      FTvDlcServer.ReinitChildren(lNode, False);

    lZip1 := THsMemoryZipper.Create();
    lZip2 := THsMemoryZipper.Create();
    lMem1 := TMemoryStreamEx.Create();
    Try
      lZip1.LoadFromFile(FPrj.Settings.DLCPath + lPkg.FileName);

      With lPkg.ZeroFile Do
        For X := 0 To FileDatas.Count - 1 Do
        Begin
          lMem1.Clear();
          lZip1.ExtractToStream(FileDatas[X].FileName, lMem1);
          lZip2.LoadFromStream(lMem1);

          For Y := 0 To lZip2.Count - 1 Do
          Begin
            If SameText(ExtractFileExt(lZip2[Y].FileName), '.sbtp') Then
            Begin
              lMem2 := TMemoryStreamEx.Create();
              lSbtp := TSbtpFileIO.CreateSbtpFile();
              Try
                lZip2.ExtractToStream(lZip2[Y].FileName, lMem2);
                lSbtp.LoadFromStream(lMem2);
                lSbtp.SaveToXml( FPrj.Settings.HackPath +
                                 ChangeFileExt(lPkg.FileName, '') + '\0\' +
                                 ChangeFileExt(lZip2[Y].FileName, '.xml'));
                Finally
                  lSbtp := Nil;
                  lMem2 := Nil;
              End;
            End;
          End;
        End;

      ShowMessage('Done');

      Finally
        lMem1 := Nil;
        lZip2 := Nil;
        lZip1 := Nil;
    End;
  End;
end;

procedure TFrmDckMain.CollapseAll1Click(Sender: TObject);
Var lBln : Boolean;
begin
  lBln := False;
  FTvDlcServer.BeginUpdate();
  Try
    FTvDlcServer.IterateSubtree(FTvDlcServer.GetFirstSelected(), DoSetNodeExpandedState, @lBln, [vsVisible])
    Finally
      FTvDlcServer.EndUpdate();
  End;
end;
{
http://www.xnxx.com/video-611oyc9/two_lesbians_teens_licking_pussy_and_fuck_with_a_dildo#_tabComments
}
end.