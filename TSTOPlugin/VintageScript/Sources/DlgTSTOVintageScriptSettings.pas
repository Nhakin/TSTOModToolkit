unit DlgTSTOVintageScriptSettings;

interface

uses
  TSTOPluginIntf, TSTOTreeViews, ClsTSTOVintageScript,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TB2Dock, TB2Toolbar, SpTBXItem, TB2Item, ImgList, SpTBXControls,
  SpTBXExPanel, SpTBXDkPanels, StdCtrls, SpTBXEditors, VirtualTrees,
  SpTBXExControls;

type
  TTSTOVintageScriptSettingsDlg = class(TForm)
    imgToolBar: TImageList;
    SpTBXBItemContainer1: TSpTBXBItemContainer;
    tbPopupMenuItems: TSpTBXSubmenuItem;
    tbSavePlugins: TSpTBXItem;
    sptbxDckMain: TSpTBXDock;
    sptbxtbMain: TSpTBXToolbar;
    SpTBXExPanel1: TSpTBXExPanel;
    PanTreeView: TSpTBXExPanel;
    SpTBXSplitter1: TSpTBXSplitter;
    SpTBXExPanel3: TSpTBXExPanel;
    chkFunctionEnabled: TSpTBXCheckBox;
    gbGlobalOptions: TSpTBXGroupBox;
    chkEnabled: TSpTBXCheckBox;
    chkUseAppSettings: TSpTBXCheckBox;
    SpTBXLabel5: TSpTBXLabel;
    EditHackMasterList: TSpTBXButtonEdit;
    EditResourcePath: TSpTBXButtonEdit;
    SpTBXLabel6: TSpTBXLabel;
    SpTBXLabel7: TSpTBXLabel;
    EditStorePath: TSpTBXButtonEdit;
    SpTBXLabel8: TSpTBXLabel;
    EditScriptPath: TSpTBXButtonEdit;
    chkAddInToolBar: TSpTBXCheckBox;
    gbFunctionOptions: TSpTBXGroupBox;
    chkAddInMenu: TSpTBXCheckBox;
    mnuVintageItems: TSpTBXBItemContainer;
    mnuVintagePlugin: TSpTBXSubmenuItem;
    mnuHelper: TSpTBXSubmenuItem;
    mnuListMissingRGBFiles: TSpTBXItem;
    mnuBuildSkinStore: TSpTBXItem;
    mnuVintageScript: TSpTBXSubmenuItem;
    mnuFreeFarmAndSelector: TSpTBXItem;
    mnuOldStoreMenu: TSpTBXItem;
    SpTBXSeparatorItem1: TSpTBXSeparatorItem;
    mnuPluginSettings: TSpTBXItem;
    SpTBXToolbar1: TSpTBXToolbar;
    SpTBXSubmenuItem1: TSpTBXSubmenuItem;
    SpTBXSubmenuItem2: TSpTBXSubmenuItem;
    SpTBXSeparatorItem2: TSpTBXSeparatorItem;
    SpTBXSubmenuItem3: TSpTBXSubmenuItem;
    SpTBXSubmenuItem4: TSpTBXSubmenuItem;

    procedure tbSavePluginsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EditHackMasterListSubEditButton0Click(Sender: TObject);
    procedure EditResourcePathSubEditButton0Click(Sender: TObject);
    procedure EditStorePathSubEditButton0Click(Sender: TObject);
    procedure EditScriptPathSubEditButton0Click(Sender: TObject);

  Private
    FMainApp : ITSTOApplication;
    FPluginSettings : ITSTOVintageScriptSetting;
    FTvFunctions : TTSTOBaseTreeView;
    FCurFunction : ITSTOVintageScriptSettingItem;

    Procedure SetMainApp(AMainApp : ITSTOApplication);
    Procedure SetPluginSettings(APluginSettings : ITSTOVintageScriptSetting);

    //Treeview handling
    procedure DoTvFunctionGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure DoTvFunctionInitNode(Sender: TBaseVirtualTree;
      ParentNode, Node: PVirtualNode;
      var InitialStates: TVirtualNodeInitStates);
    procedure DoTvFunctionFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);

  Public
    Property MainApp : ITSTOApplication Read FMainApp Write SetMainApp;
    Property PluginSettings : ITSTOVintageScriptSetting Read FPluginSettings Write SetPluginSettings;

  end;

implementation

{$R *.dfm}

Uses
  SpTBXSkins, HsStreamEx, uSelectDirectoryEx;

procedure TTSTOVintageScriptSettingsDlg.EditHackMasterListSubEditButton0Click(
  Sender: TObject);
begin
  With TOpenDialog.Create(Self) Do
  Try
    Filter := 'Xml File|*.Xml';

    If Execute() Then
      EditHackMasterList.Text := FileName;

    Finally
      Free();
  End;
end;

procedure TTSTOVintageScriptSettingsDlg.EditResourcePathSubEditButton0Click(
  Sender: TObject);
Var lSelDir : AnsiString;
Begin
  If SelectDirectoryEx('Resource Path', ExtractFilePath(ParamStr(0)),
    lSelDir, True, False, False) Then
    EditResourcePath.Text := lSelDir;
end;

procedure TTSTOVintageScriptSettingsDlg.EditScriptPathSubEditButton0Click(
  Sender: TObject);
Var lSelDir : AnsiString;
Begin
  If SelectDirectoryEx('Script Path', ExtractFilePath(ParamStr(0)),
    lSelDir, True, False, False) Then
    EditScriptPath.Text := lSelDir;
end;

procedure TTSTOVintageScriptSettingsDlg.EditStorePathSubEditButton0Click(
  Sender: TObject);
Var lSelDir : AnsiString;
Begin
  If SelectDirectoryEx('Store Path', ExtractFilePath(ParamStr(0)),
    lSelDir, True, False, False) Then
    EditStorePath.Text := lSelDir;
end;

procedure TTSTOVintageScriptSettingsDlg.FormCreate(Sender: TObject);
Var lBmp : TBitMap;
    lImgList : TImageList;
begin
  lBmp := TBitMap.Create();
  Try
    lBmp.LoadFromResourceName(HInstance, 'Magnifier');

    lImgList := TImageList.Create(Self);
    lImgList.DrawingStyle := dsTransparent;
    lImgList.Width  := 12;
    lImgList.Height := 12;
    lImgList.AddMasked(lBmp, clOlive);

    Finally
      lBmp.Free();
  End;

  EditHackMasterList.EditButton.Images     := lImgList;
  EditHackMasterList.EditButton.ImageIndex := 0;

  EditResourcePath.EditButton.Images     := lImgList;
  EditResourcePath.EditButton.ImageIndex := 0;

  EditStorePath.EditButton.Images     := lImgList;
  EditStorePath.EditButton.ImageIndex := 0;

  EditScriptPath.EditButton.Images     := lImgList;
  EditScriptPath.EditButton.ImageIndex := 0;

  FTvFunctions := TTSTOBaseTreeView.Create(Self);
  FTvFunctions.Parent := PanTreeView;
  FTvFunctions.Align  := alClient;
  FTvFunctions.TreeOptions.PaintOptions := FTvFunctions.TreeOptions.PaintOptions - [toShowRoot];

  FTvFunctions.OnInitNode     := DoTvFunctionInitNode;
  FTvFunctions.OnGetText      := DoTvFunctionGetText;
  FTvFunctions.OnFocusChanged := DoTvFunctionFocusChanged;

  FCurFunction := Nil;  
end;

Procedure TTSTOVintageScriptSettingsDlg.SetMainApp(AMainApp : ITSTOApplication);
Var lMemStrm : IMemoryStreamEx;
Begin
  FMainApp := AMainApp;

  If Assigned(FMainApp) Then
  Begin
    lMemStrm := TMemoryStreamEx.Create();
    Try
      FMainApp.Host.Icon.SaveToStream(TStream(lMemStrm.InterfaceObject));
      lMemStrm.Position := 0;
      Icon.LoadFromStream(TStream(lMemStrm.InterfaceObject));

      Finally
        lMemStrm := Nil;
    End;
  End;
End;

Procedure TTSTOVintageScriptSettingsDlg.SetPluginSettings(APluginSettings : ITSTOVintageScriptSetting);
Begin
  FPluginSettings := APluginSettings;

  If Assigned(FPluginSettings) Then
  Begin
    chkEnabled.Checked        := FPluginSettings.Enabled;
    chkUseAppSettings.Checked := FPluginSettings.UseAppSetting;
    EditHackMasterList.Text   := FPluginSettings.HackMasterListFileName;
    EditResourcePath.Text     := FPluginSettings.ResourcePath;
    EditStorePath.Text        := FPluginSettings.StorePath;
    EditScriptPath.Text       := FPluginSettings.ScriptPath;

    FTvFunctions.RootNodeCount := FPluginSettings.Items.Count;
  End;
End;

procedure TTSTOVintageScriptSettingsDlg.DoTvFunctionInitNode(
  Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
begin
  FTvFunctions.SetNodeData(Node, FPluginSettings.Items[Node.Index]);
end;

procedure TTSTOVintageScriptSettingsDlg.DoTvFunctionGetText(
  Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType; var CellText: WideString);
Const
  cScriptTypeStr : Array[TSTOVintageScriptType] Of String = (
    'RGB Files', 'Skin Store', 'Farms', 'Old Menu'
  );

Var lNodeData : ITSTOVintageScriptSettingItem;
begin
  If FTvFunctions.GetNodeData(Node, ITSTOVintageScriptSettingItem, lNodeData) Then
    CellText := cScriptTypeStr[lNodeData.ScriptType];
end;

procedure TTSTOVintageScriptSettingsDlg.DoTvFunctionFocusChanged(
  Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex);
begin
  If Assigned(FCurFunction) Then
  Begin
    FCurFunction.Enabled      := chkFunctionEnabled.Checked;
    FCurFunction.AddInMenu    := chkAddInMenu.Checked;
    FCurFunction.AddInToolBar := chkAddInToolBar.Checked;
  End;

  If FTvFunctions.GetNodeData(Node, ITSTOVintageScriptSettingItem, FCurFunction) Then
  Begin
    chkFunctionEnabled.Checked := FCurFunction.Enabled;
    chkAddInMenu.Checked       := FCurFunction.AddInMenu;
    chkAddInToolBar.Checked    := FCurFunction.AddInToolBar;
  End;
end;

procedure TTSTOVintageScriptSettingsDlg.tbSavePluginsClick(Sender: TObject);
begin
  If Assigned(FCurFunction) Then
  Begin
    FCurFunction.Enabled      := chkFunctionEnabled.Checked;
    FCurFunction.AddInMenu    := chkAddInMenu.Checked;
    FCurFunction.AddInToolBar := chkAddInToolBar.Checked;
  End;

  ModalResult := mrOk;
end;

end.
