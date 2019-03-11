unit DlgTSTOPluginManager;

interface

uses
  TSTOPluginIntf, TSTOPluginManagerIntf,
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, TB2Dock,
  TB2Toolbar, SpTBXItem, TB2Item, SpTBXDkPanels, SpTBXControls, SpTBXExPanel,
  ImgList, JvPluginManager, VirtualTrees, SpTBXExControls, StdCtrls,
  SpTBXEditors;

type
  TTSTOPluginManagerDlg = class(TForm)
    imgToolBar: TImageList;
    SpTBXBItemContainer1: TSpTBXBItemContainer;
    tbPopupMenuItems: TSpTBXSubmenuItem;
    tbSavePlugins: TSpTBXItem;
    sptbxDckMain: TSpTBXDock;
    sptbxtbMain: TSpTBXToolbar;
    SpTBXExPanel1: TSpTBXExPanel;
    SpTBXStatusBar1: TSpTBXStatusBar;
    SpTBXSplitter1: TSpTBXSplitter;
    SpTBXExPanel2: TSpTBXExPanel;
    tvPlugins: TSpTBXVirtualStringTree;
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
    procedure tvPluginsInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure tvPluginsFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure CmdPluginSettingClick(Sender: TObject);
    procedure tvPluginsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
    procedure FormKeyPress(Sender: TObject; var Key: Char);

  private
    FMainApp : ITSTOApplication;
    FPlugins : ITSTOPlugins;
    FManager : ITSTOPluginManager;
    
    Function  GetPlugins() : ITSTOPlugins;
    Procedure SetPlugins(APlugins : ITSTOPlugins);

    Procedure SetMainApp(AMainApp : ITSTOApplication);

    Procedure SetNodeData(ANode : PVirtualNode; ANodeData : IInterface);
    Function  GetNodeData(ANode : PVirtualNode; AId : TGUID; Var ANodeData) : Boolean; OverLoad;
    Function  GetNodeData(ANode : PVirtualNode; AId : TGUID) : Boolean; OverLoad;

  public
    Property Plugins : ITSTOPlugins       Read GetPlugins Write SetPlugins;
    Property MainApp : ITSTOApplication   Read FMainApp   Write SetMainApp;

  end;

implementation

Uses HsStreamEx;

{$R *.dfm}

Procedure TTSTOPluginManagerDlg.SetNodeData(ANode : PVirtualNode; ANodeData : IInterface);
Var lNodeData : PPointer;
Begin
  lNodeData  := tvPlugins.GetNodeData(ANode);
  lNodeData^ := Pointer(ANodeData);
End;

Function TTSTOPluginManagerDlg.GetNodeData(ANode : PVirtualNode; AId : TGUID; Var ANodeData) : Boolean;
Var lNodeData : PPointer;
Begin
  lNodeData := tvPlugins.GetNodeData(ANode);
  Result := Assigned(lNodeData^) And Supports(IInterface(lNodeData^), AId, ANodeData);
End;

procedure TTSTOPluginManagerDlg.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #27 Then
  Begin
    Key := #0;
    Close();
  End;
end;

Function TTSTOPluginManagerDlg.GetNodeData(ANode : PVirtualNode; AId : TGUID) : Boolean;
Var lDummy : IInterface;
Begin
  Result := GetNodeData(ANode, AId, lDummy);
End;

procedure TTSTOPluginManagerDlg.tbSavePluginsClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TTSTOPluginManagerDlg.CmdPluginSettingClick(Sender: TObject);
Var lNodeData : ITSTOPlugin;
begin
  If GetNodeData(tvPlugins.GetFirstSelected(), ITSTOPlugin, lNodeData) Then
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
  If GetNodeData(Node, ITSTOPlugin, lNodeData) Then
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
  If GetNodeData(Node, ITSTOPlugin, lNodeData) Then
    CellText := lNodeData.Name;
end;

procedure TTSTOPluginManagerDlg.tvPluginsInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
begin
  SetNodeData(Node, FPlugins[Node.Index]);
end;

Function TTSTOPluginManagerDlg.GetPlugins() : ITSTOPlugins;
Begin
  Result := FPlugins;
End;

Procedure TTSTOPluginManagerDlg.SetPlugins(APlugins : ITSTOPlugins);
Var X : Integer;
    lPlgIntf : ITSTOPlugin;
Begin
  FPlugins := APlugins;

  If Assigned(FPlugins) Then
  Begin
    tvPlugins.BeginUpdate();
    Try
      tvPlugins.RootNodeCount := FPlugins.Count;

      Finally
        tvPlugins.EndUpdate();
    End;
  End
  Else
    tvPlugins.RootNodeCount := 0;
End;

Procedure TTSTOPluginManagerDlg.SetMainApp(AMainApp : ITSTOApplication);
Var lMemStrm : IMemoryStreamEx;
Begin
  FMainApp := AMainApp;

  If Assigned(FMainApp) Then
  Begin
    lMemStrm := TMemoryStreamEx.Create();
    Try
      FMainApp.Icon.SaveToStream(TStream(lMemStrm.InterfaceObject));
      lMemStrm.Position := 0;
      Self.Icon.LoadFromStream(TStream(lMemStrm.InterfaceObject));

      Finally
        lMemStrm := Nil
    End;
  End;
End;

end.
