unit DlgTSTOPluginManager;

interface

uses
  TSTOTreeviews, TSTOPluginIntf, TSTOPluginManagerIntf,
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, TB2Dock,
  TB2Toolbar, SpTBXItem, TB2Item, SpTBXDkPanels, SpTBXControls, SpTBXExPanel,
  ImgList, VirtualTrees, SpTBXExControls, StdCtrls,
  SpTBXEditors;

type
  TTSTOPluginManagerDlg = class(TForm)
    imgToolBar: TImageList;
    SpTBXBItemContainer1: TSpTBXBItemContainer;
    tbPopupMenuItems: TSpTBXSubmenuItem;
    tbSavePlugins: TSpTBXItem;
    sptbxDckMain: TSpTBXDock;
    sptbxtbMain: TSpTBXToolbar;
    PanTv: TSpTBXExPanel;
    SpTBXStatusBar1: TSpTBXStatusBar;
    SpTBXSplitter1: TSpTBXSplitter;
    SpTBXExPanel2: TSpTBXExPanel;
    SpTBXGroupBox1: TSpTBXGroupBox;
    SpTBXLabel1: TSpTBXLabel;
    EditName: TSpTBXEdit;
    SpTBXLabel2: TSpTBXLabel;
    EditAuthor: TSpTBXEdit;
    SpTBXLabel3: TSpTBXLabel;
    EditCopyright: TSpTBXEdit;
    SpTBXLabel4: TSpTBXLabel;
    EditVersion: TSpTBXEdit;
    SpTBXLabel5: TSpTBXLabel;
    EditDescription: TSpTBXEdit;
    CmdPluginSetting: TSpTBXButton;

    procedure tbSavePluginsClick(Sender: TObject);
    procedure CmdPluginSettingClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);

  private
    FMainApp  : ITSTOApplication;
    FPlugins  : ITSTOPlugins;
    FTvPlugin : TTSTOBaseTreeView;

    Function  GetPlugins() : ITSTOPlugins;
    Procedure SetPlugins(APlugins : ITSTOPlugins);

    Procedure SetMainApp(AMainApp : ITSTOApplication);

    procedure tvPluginsInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure tvPluginsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
    procedure tvPluginsFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);

  public
    Property Plugins : ITSTOPlugins     Read GetPlugins Write SetPlugins;
    Property MainApp : ITSTOApplication Read FMainApp   Write SetMainApp;

  end;

implementation

Uses HsStreamEx;

{$R *.dfm}

procedure TTSTOPluginManagerDlg.FormCreate(Sender: TObject);
begin
  FTvPlugin := TTSTOBaseTreeView.Create(Self);
  FTvPlugin.Parent := PanTv;
  FTvPlugin.Align  := alClient;

  FTvPlugin.OnInitNode     := tvPluginsInitNode;
  FTvPlugin.OnGetText      := tvPluginsGetText;
  FTvPlugin.OnFocusChanged := tvPluginsFocusChanged;
  FTvPlugin.TreeOptions.PaintOptions := FTvPlugin.TreeOptions.PaintOptions - [toShowRoot, toShowTreeLines];
end;

procedure TTSTOPluginManagerDlg.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #27 Then
  Begin
    Key := #0;
    Close();
  End;
end;

procedure TTSTOPluginManagerDlg.tbSavePluginsClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TTSTOPluginManagerDlg.CmdPluginSettingClick(Sender: TObject);
Var lNodeData : ITSTOPlugin;
begin
  If FTvPlugin.GetNodeData(FTvPlugin.GetFirstSelected(), ITSTOPlugin, lNodeData) Then
    If lNodeData.ShowSettings() Then
    Begin
      lNodeData.Finalize();

      If lNodeData.Enabled Then
        lNodeData.Initialize(FMainApp);
    End;
end;

procedure TTSTOPluginManagerDlg.tvPluginsFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
Var lNodeData : ITSTOPlugin;
begin
  If FTvPlugin.GetNodeData(Node, ITSTOPlugin, lNodeData) Then
  Begin
    EditName.Text        := lNodeData.Name;
    EditAuthor.Text      := lNodeData.Author;
    EditCopyright.Text   := lNodeData.Copyright;
    EditVersion.Text     := lNodeData.PluginVersion;
    EditDescription.Text := lNodeData.Description;

    CmdPluginSetting.Enabled := lNodeData.HaveSettings;
  End;
end;

procedure TTSTOPluginManagerDlg.tvPluginsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
Var lNodeData : ITSTOPlugin;
begin
  If FTvPlugin.GetNodeData(Node, ITSTOPlugin, lNodeData) Then
    CellText := lNodeData.Name;
end;

procedure TTSTOPluginManagerDlg.tvPluginsInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
begin
  FTvPlugin.SetNodeData(Node, FPlugins[Node.Index]);
end;

Function TTSTOPluginManagerDlg.GetPlugins() : ITSTOPlugins;
Begin
  Result := FPlugins;
End;

Procedure TTSTOPluginManagerDlg.SetPlugins(APlugins : ITSTOPlugins);
Begin
  FPlugins := APlugins;

  If Assigned(FPlugins) Then
  Begin
    FTvPlugin.BeginUpdate();
    Try
      FTvPlugin.RootNodeCount := FPlugins.Count;

      Finally
        FTvPlugin.EndUpdate();
    End;
  End
  Else
    FTvPlugin.RootNodeCount := 0;
End;

Procedure TTSTOPluginManagerDlg.SetMainApp(AMainApp : ITSTOApplication);
Var lMemStrm : IMemoryStreamEx;
Begin
  FMainApp := AMainApp;

  If Assigned(FMainApp) Then
  Begin
    lMemStrm := TMemoryStreamEx.Create();
    Try
      FMainApp.Host.Icon.SaveToStream(TStream(lMemStrm.InterfaceObject));
      lMemStrm.Position := 0;
      Self.Icon.LoadFromStream(TStream(lMemStrm.InterfaceObject));

      Finally
        lMemStrm := Nil
    End;
  End;
End;

end.
