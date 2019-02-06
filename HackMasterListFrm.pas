unit HackMasterListFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SpTBXItem, SpTBXControls, SpTBXExPanel, TSTOTreeviews, TSTOHackMasterList.IO,
  SpTBXDkPanels, TB2Item, TB2Dock, TB2Toolbar, Vcl.StdCtrls, SpTBXEditors, VirtualTrees,
  SciScintillaBase, SciScintillaMemo, SciScintilla, SciScintillaNPP, SciLanguageManager, TSTOProject.Xml;

type
  TFrmHackMasterList = class(TForm)
    PanTreeView: TSpTBXExPanel;
    SpTBXSplitter1: TSpTBXSplitter;
    PanData: TSpTBXExPanel;
    SpTBXBItemContainer1: TSpTBXBItemContainer;
    tbPopupMenuItems: TSpTBXSubmenuItem;
    tbSaveWorkSpace: TSpTBXItem;
    sptbxDckMain: TSpTBXDock;
    sptbxtbMain: TSpTBXToolbar;
    tbMainPopup: TSpTBXTBGroupItem;
    GrpPackage: TSpTBXGroupBox;
    Label1: TSpTBXLabel;
    EditPackageXmlFile: TSpTBXEdit;
    chkPackageEnabled: TSpTBXCheckBox;
    SpTBXLabel1: TSpTBXLabel;
    GrpCategory: TSpTBXGroupBox;
    SpTBXLabel3: TSpTBXLabel;
    EditCategoryName: TSpTBXEdit;
    chkCategoryEnabled: TSpTBXCheckBox;
    SpTBXLabel4: TSpTBXLabel;
    SpTBXLabel5: TSpTBXLabel;
    chkCategoryBuildStore: TSpTBXCheckBox;
    CmbPackageType: TSpTBXComboBox;
    SpTBXLabel2: TSpTBXLabel;
    GrpItem: TSpTBXGroupBox;
    EditXmlData: TScintillaNPP;
    SpTBXExPanel1: TSpTBXExPanel;
    SpTBXLabel7: TSpTBXLabel;
    chkItemAddInStore: TSpTBXCheckBox;
    SpTBXLabel8: TSpTBXLabel;
    chkItemOverRide: TSpTBXCheckBox;
    EditItemName: TSpTBXEdit;
    EditItemId: TSpTBXEdit;
    SpTBXLabel9: TSpTBXLabel;
    SpTBXLabel6: TSpTBXLabel;
    SpTBXLabel10: TSpTBXLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyPress(Sender: TObject; var Key: Char);

  private
    FTvMasterList : TTSTOHackMasterListTreeView;
    FMasterList   : ITSTOHackMasterListIO;
    FAppSettings  : ITSTOXMLSettings;
    FFormSettings : ITSTOXMLFormSetting;

    Procedure SetMasterList(AMasterList : ITSTOHackMasterListIO);

    Function  GetLangMgr() : TSciLanguageManager;
    Procedure SetLangMgr(ALangMgr : TSciLanguageManager);

    Procedure SetAppSettings(AAppSettings : ITSTOXMLSettings);

    Procedure DoTvMasterListFocusChanged(Sender : TBaseVirtualTree;
      Node : PVirtualNode; Column : TColumnIndex);

  public
    Property MasterList  : ITSTOHackMasterListIO Read FMasterList  Write SetMasterList;
    Property LangMgr     : TSciLanguageManager   Read GetLangMgr   Write SetLangMgr;
    Property AppSettings : ITSTOXMLSettings      Read FAppSettings Write SetAppSettings;

  end;

implementation

Uses RTTI, SpTbxSkins, HsXmlDocEx, dmImage, TSTOHackMasterListIntf;

{$R *.dfm}

procedure TFrmHackMasterList.FormActivate(Sender: TObject);
begin
  WindowState := TRttiEnumerationType.GetValue<TWindowState>(FFormSettings.WindowState);
  Left        := FFormSettings.X;
  Top         := FFormSettings.Y;
  Height      := FFormSettings.H;
  Width       := FFormSettings.W;
end;

procedure TFrmHackMasterList.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := True;

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

procedure TFrmHackMasterList.FormCreate(Sender: TObject);
begin
  FTvMasterList := TTSTOHackMasterListTreeView.Create(Self);
  FTvMasterList.Parent := PanTreeView;
  FTvMasterList.Align  := alClient;
  FTvMasterList.Images := DataModuleImage.imgToolBar;
  FTvMasterList.OnFocusChanged := DoTvMasterListFocusChanged;

  If SameText(SkinManager.CurrentSkin.SkinName, 'WMP11') Then
  Begin
    FTvMasterList.Color := $00262525;
    FTvMasterList.Font.Color := $00F1F1F1;

    With SkinManager.CurrentSkin Do
      Options(skncListItem, sknsNormal).TextColor := clBlack;
  End;
end;

procedure TFrmHackMasterList.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #27 Then
  Begin
    Key := #0;
    Close;
  End;
end;

Procedure TFrmHackMasterList.SetMasterList(AMasterList : ITSTOHackMasterListIO);
Begin
  FMasterList := AMasterList;
  FTvMasterList.TvData := FMasterList;
End;

Function TFrmHackMasterList.GetLangMgr() : TSciLanguageManager;
Begin
  Result := EditXmlData.LanguageManager;
End;

Procedure TFrmHackMasterList.SetLangMgr(ALangMgr : TSciLanguageManager);
Begin
  EditXmlData.LanguageManager := ALangMgr;
  EditXmlData.SelectedLanguage := 'XML';
  EditXmlData.Folding := EditXmlData.Folding + [foldFold];
End;

Procedure TFrmHackMasterList.SetAppSettings(AAppSettings : ITSTOXMLSettings);
Var X : Integer;
Begin
  FFormSettings := Nil;
  FAppSettings  := AAppSettings;

  For X := 0 To FAppSettings.FormPos.Count - 1 Do
    If SameText(FAppSettings.FormPos[X].Name, Self.ClassName) Then
    Begin
      FFormSettings := FAppSettings.FormPos[X];
      Break;
    End;

  If Not Assigned(FFormSettings) Then
  Begin
    FFormSettings := FAppSettings.FormPos.Add();

    FFormSettings.Name        := Self.ClassName;
    FFormSettings.WindowState := TRttiEnumerationType.GetName(WindowState);
    FFormSettings.X := Left;
    FFormSettings.Y := Top;
    FFormSettings.H := Height;
    FFormSettings.W := Width;
  End;
End;

Procedure TFrmHackMasterList.DoTvMasterListFocusChanged(Sender : TBaseVirtualTree;
  Node : PVirtualNode; Column : TColumnIndex);
Var lMovedItem : ITSTOHackMasterMovedItem;
    lCategory  : ITSTOHackMasterCategoryIO;
    lPackage   : ITSTOHackMasterPackageIO;
    lItem      : ITSTOHackMasterDataIDIO;
Begin
  If FTvMasterList.GetNodeData(Node, ITSTOHackMasterMovedItem, lMovedItem) Then
  Begin

  End
  Else If FTvMasterList.GetNodeData(Node, ITSTOHackMasterCategoryIO, lCategory) Then
  Begin
    EditCategoryName.Text := lCategory.Name;
    chkCategoryEnabled.Checked := lCategory.Enabled;
    chkCategoryBuildStore.Checked := lCategory.BuildStore;
  End
  Else If FTvMasterList.GetNodeData(Node, ITSTOHackMasterPackageIO, lPackage) Then
  Begin
    CmbPackageType.ItemIndex  := CmbPackageType.Items.IndexOf(lPackage.PackageType);
    EditPackageXmlFile.Text   := lPackage.XmlFile;
    chkPackageEnabled.Checked := lPackage.Enabled;
  End
  Else If FTvMasterList.GetNodeData(Node, ITSTOHackMasterDataIDIO, lItem) Then
  Begin
    EditItemId.Text := IntToStr(lItem.Id);
    EditItemName.Text := lItem.Name;
    chkItemAddInStore.Checked := lItem.AddInStore;
    chkItemOverRide.Checked := lItem.OverRide;
    EditXmlData.Lines.Text := FormatXmlData(lItem.MiscData.Text);
  End
End;

end.
