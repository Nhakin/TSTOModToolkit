unit HackMasterListFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SpTBXItem, SpTBXControls, SpTBXExPanel, TSTOTreeviews, TSTOHackMasterList.IO,
  SpTBXDkPanels, TB2Item, TB2Dock, TB2Toolbar, Vcl.StdCtrls, SpTBXEditors, VirtualTrees,
  SciScintillaBase, SciScintillaMemo, SciScintilla, SciScintillaNPP, SciLanguageManager, TSTOProject.Xml,
  SciActions, System.Actions, Vcl.ActnList;

type
  TFrmHackMasterList = class(TForm)
    PanTreeView: TSpTBXExPanel;
    SpTBXSplitter1: TSpTBXSplitter;
    PanData: TSpTBXExPanel;
    SpTBXBItemContainer1: TSpTBXBItemContainer;
    tbPopupMenuItems: TSpTBXSubmenuItem;
    tbSaveHackMasterList: TSpTBXItem;
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
    EditItemType: TSpTBXEdit;
    SpTBXLabel11: TSpTBXLabel;
    SpTBXLabel12: TSpTBXLabel;
    EditItemSkinObject: TSpTBXEdit;
    actlstScintilla: TActionList;
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

    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure EditCategoryNameChange(Sender: TObject);
    procedure tbSaveHackMasterListClick(Sender: TObject);
    procedure chkCategoryEnabledClick(Sender: TObject);
    procedure chkCategoryBuildStoreClick(Sender: TObject);
    procedure CmbPackageTypeChange(Sender: TObject);
    procedure EditPackageXmlFileChange(Sender: TObject);
    procedure chkPackageEnabledClick(Sender: TObject);
    procedure EditItemIdChange(Sender: TObject);
    procedure EditItemNameChange(Sender: TObject);
    procedure EditItemTypeChange(Sender: TObject);
    procedure EditItemSkinObjectChange(Sender: TObject);
    procedure chkItemAddInStoreClick(Sender: TObject);
    procedure chkItemOverRideClick(Sender: TObject);

  private
    FTvMasterList  : TTSTOHackMasterListTreeView;
    FOriMasterList : ITSTOHackMasterListIO;
    FMasterList    : ITSTOHackMasterListIO;
    FAppSettings   : ITSTOXMLSettings;
    FFormSettings  : ITSTOXMLFormSetting;
    FIsLoading     : Boolean;

    Procedure SetMasterList(AMasterList : ITSTOHackMasterListIO);

    Function  GetLangMgr() : TSciLanguageManager;
    Procedure SetLangMgr(ALangMgr : TSciLanguageManager);

    Procedure SetAppSettings(AAppSettings : ITSTOXMLSettings);

    Procedure DoTvMasterListFocusChanged(Sender : TBaseVirtualTree;
      Node : PVirtualNode; Column : TColumnIndex);

    Procedure DoMasterListChange(Sender : TObject);

    Function GetGroupBoxData(APanel : TSpTBXGroupBox; AId : TGUID; Var AGroupBoxData) : Boolean;

  public
    Property MasterList  : ITSTOHackMasterListIO Read FMasterList  Write SetMasterList;
    Property LangMgr     : TSciLanguageManager   Read GetLangMgr   Write SetLangMgr;
    Property AppSettings : ITSTOXMLSettings      Read FAppSettings Write SetAppSettings;

  end;

implementation

Uses RTTI, SpTbxSkins, HsXmlDocEx, HsStreamEx, dmImage, TSTOHackMasterListIntf;

{$R *.dfm}

Function TFrmHackMasterList.GetGroupBoxData(APanel : TSpTBXGroupBox; AId : TGUID; Var AGroupBoxData) : Boolean;
Begin
  Result := Supports(IInterface(APanel.Tag), AId, AGroupBoxData);
End;

procedure TFrmHackMasterList.EditCategoryNameChange(Sender: TObject);
Var lCategory : ITSTOHackMasterCategory;
begin
  If Not FIsLoading And GetGroupBoxData(GrpCategory, ITSTOHackMasterCategory, lCategory) Then
    lCategory.Name := EditCategoryName.Text;
end;

procedure TFrmHackMasterList.chkCategoryBuildStoreClick(Sender: TObject);
Var lCategory : ITSTOHackMasterCategory;
begin
  If Not FIsLoading And GetGroupBoxData(GrpCategory, ITSTOHackMasterCategory, lCategory) Then
    lCategory.BuildStore := chkCategoryBuildStore.Checked;
end;

procedure TFrmHackMasterList.chkCategoryEnabledClick(Sender: TObject);
Var lCategory : ITSTOHackMasterCategory;
begin
  If Not FIsLoading And GetGroupBoxData(GrpCategory, ITSTOHackMasterCategory, lCategory) Then
    lCategory.Enabled := chkCategoryEnabled.Checked;
end;

procedure TFrmHackMasterList.chkPackageEnabledClick(Sender: TObject);
Var lPackage : ITSTOHackMasterPackage;
begin
  If Not FIsLoading And GetGroupBoxData(GrpPackage, ITSTOHackMasterPackage, lPackage) Then
    lPackage.Enabled := chkPackageEnabled.Checked;
end;

procedure TFrmHackMasterList.CmbPackageTypeChange(Sender: TObject);
Var lPackage : ITSTOHackMasterPackage;
begin
  If Not FIsLoading And GetGroupBoxData(GrpPackage, ITSTOHackMasterPackage, lPackage) Then
    lPackage.PackageType := CmbPackageType.Text;
end;

procedure TFrmHackMasterList.EditPackageXmlFileChange(Sender: TObject);
Var lPackage : ITSTOHackMasterPackage;
begin
  If Not FIsLoading And GetGroupBoxData(GrpPackage, ITSTOHackMasterPackage, lPackage) Then
    lPackage.XmlFile := EditPackageXmlFile.Text;
end;

procedure TFrmHackMasterList.chkItemAddInStoreClick(Sender: TObject);
Var lItem : ITSTOHackMasterDataID;
begin
  If Not FIsLoading And GetGroupBoxData(GrpItem, ITSTOHackMasterDataID, lItem) Then
    lItem.AddInStore := chkItemAddInStore.Checked;
end;

procedure TFrmHackMasterList.chkItemOverRideClick(Sender: TObject);
Var lItem : ITSTOHackMasterDataID;
begin
  If Not FIsLoading And GetGroupBoxData(GrpItem, ITSTOHackMasterDataID, lItem) Then
    lItem.OverRide := chkItemOverRide.Checked;
end;

procedure TFrmHackMasterList.EditItemIdChange(Sender: TObject);
Var lItem : ITSTOHackMasterDataID;
begin
  If Not FIsLoading And GetGroupBoxData(GrpItem, ITSTOHackMasterDataID, lItem) Then
    lItem.Id := StrToIntDef(EditItemId.Text, -1);
end;

procedure TFrmHackMasterList.EditItemNameChange(Sender: TObject);
Var lItem : ITSTOHackMasterDataID;
begin
  If Not FIsLoading And GetGroupBoxData(GrpItem, ITSTOHackMasterDataID, lItem) Then
    lItem.Name := EditItemName.Text;
end;

procedure TFrmHackMasterList.EditItemSkinObjectChange(Sender: TObject);
Var lItem : ITSTOHackMasterDataID;
begin
  If Not FIsLoading And GetGroupBoxData(GrpItem, ITSTOHackMasterDataID, lItem) Then
    lItem.SkinObject := EditItemSkinObject.Text;
end;

procedure TFrmHackMasterList.EditItemTypeChange(Sender: TObject);
Var lItem : ITSTOHackMasterDataID;
begin
  If Not FIsLoading And GetGroupBoxData(GrpItem, ITSTOHackMasterDataID, lItem) Then
    lItem.ObjectType := EditItemType.Text;
end;

procedure TFrmHackMasterList.FormActivate(Sender: TObject);
begin
  WindowState := TRttiEnumerationType.GetValue<TWindowState>(FFormSettings.WindowState);

  If WindowState = wsNormal Then
  Begin
    Left   := FFormSettings.X;
    Top    := FFormSettings.Y;
    Height := FFormSettings.H;
    Width  := FFormSettings.W;
  End;
end;

procedure TFrmHackMasterList.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := True;

  If FMasterList.Modified Then
    Case MessageDlg('Save changes to Hack MasterList ?', mtInformation, [mbYes, mbNo, mbCancel], 0) Of
      mrYes : tbSaveHackMasterListClick(Self);
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

    FOriMasterList := Nil;
    FMasterList    := Nil;
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
  FOriMasterList := AMasterList;

  FMasterList := TTSTOHackMasterListIO.CreateHackMasterList();
  FMasterList.Assign(FOriMasterList);
  FMasterList.OnChange := DoMasterListChange;

  FTvMasterList.TvData := FMasterList;
End;

procedure TFrmHackMasterList.tbSaveHackMasterListClick(Sender: TObject);
Var lMem : IMemoryStreamEx;
begin
  If FMasterList.Modified Then
  Begin
    FOriMasterList.Assign(FMasterList);
    FOriMasterList.ForceChanged();

    FMasterList.ClearChanges();
  End;

  ModalResult := mrOk;
end;

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
  FIsLoading := True;
  Try
    If FTvMasterList.GetNodeData(Node, ITSTOHackMasterMovedItem, lMovedItem) Then
    Begin

    End
    Else If FTvMasterList.GetNodeData(Node, ITSTOHackMasterCategoryIO, lCategory) Then
    Begin
      EditCategoryName.Text := lCategory.Name;
      chkCategoryEnabled.Checked := lCategory.Enabled;
      chkCategoryBuildStore.Checked := lCategory.BuildStore;
      GrpCategory.Tag := Integer(lCategory);
    End
    Else If FTvMasterList.GetNodeData(Node, ITSTOHackMasterPackageIO, lPackage) Then
    Begin
      CmbPackageType.ItemIndex  := CmbPackageType.Items.IndexOf(lPackage.PackageType);
      EditPackageXmlFile.Text   := lPackage.XmlFile;
      chkPackageEnabled.Checked := lPackage.Enabled;
      GrpPackage.Tag := Integer(lPackage);
    End
    Else If FTvMasterList.GetNodeData(Node, ITSTOHackMasterDataIDIO, lItem) Then
    Begin
      EditItemId.Text := IntToStr(lItem.Id);
      EditItemName.Text := lItem.Name;
      EditItemType.Text := lItem.ObjectType;
      EditItemSkinObject.Text := lItem.SkinObject;
      chkItemAddInStore.Checked := lItem.AddInStore;
      chkItemOverRide.Checked := lItem.OverRide;
      EditXmlData.Lines.Text := FormatXmlData(lItem.MiscData.Text);
      GrpItem.Tag := Integer(lItem);
    End

    Finally
      FIsLoading := False;
  End;
End;

Procedure TFrmHackMasterList.DoMasterListChange(Sender : TObject);
Begin
  tbSaveHackMasterList.Enabled := True;
End;

end.
