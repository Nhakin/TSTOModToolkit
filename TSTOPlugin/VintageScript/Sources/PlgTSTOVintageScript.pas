unit PlgTSTOVintageScript;

interface

uses
  PlgTSTOCustomPlugin, TSTOPluginIntf, ClsTSTOVintageScript,
  SysUtils, Classes, TB2Item, SpTBXItem,
  ImgList, Controls;

type
  TTSTOVintageScript = class(TTSTOCustomPlugin)
    mnuVintageItems: TSpTBXBItemContainer;
    imgToolBar: TImageList;
    mnuVintageScript: TSpTBXSubmenuItem;
    mnuListMissingRGBFiles: TSpTBXItem;
    mnuOldStoreMenu: TSpTBXItem;
    mnuFreeFarmAndSelector: TSpTBXItem;
    mnuHelper: TSpTBXSubmenuItem;
    mnuBuildSkinStore: TSpTBXItem;
    mnuVintagePlugin: TSpTBXSubmenuItem;
    mnuPluginSettings: TSpTBXItem;
    SpTBXSeparatorItem1: TSpTBXSeparatorItem;

    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure mnuListMissingRGBFilesClick(Sender: TObject);
    procedure mnuBuildSkinStoreClick(Sender: TObject);
    procedure mnuFreeFarmAndSelectorClick(Sender: TObject);
    procedure mnuOldStoreMenuClick(Sender: TObject);
    procedure mnuPluginSettingsClick(Sender: TObject);

  Private
    FSettings : ITSTOVintageScriptSetting;
    FMnuItems : TSpTBXSubmenuItem;
    FTbItems  : TSpTBXSubmenuItem;

    Procedure InitUI();
    Procedure LoadSettings();
    Procedure SaveSettings();

  Protected
    Function  GetPluginKind() : TTSTOPluginKind; OverRide;
    Function  GetHaveSettings() : Boolean; OverRide;

    Function  GetName() : String; OverRide;
    Function  GetDescription() : String; OverRide;
    Function  GetPluginId() : String; OverRide;
    Function  GetPluginVersion() : String; OverRide;

    Procedure Initialize(AMainApplication : ITSTOApplication); OverRide;
    Procedure Finalize(); OverRide;
    Function  ShowSettings() : Boolean; OverRide;

  public

  end;

Function CreateTSTOPlugin() : ITSTOPlugin;

implementation

Uses
  Dialogs,
  HsStringListEx, HsXmlDocEx,
  TSTOHackMasterList.IO,
  DlgTSTOVintageScriptSettings;

{$R *.dfm}

Function CreateTSTOPlugin() : ITSTOPlugin;
Begin
  Result := TTSTOVintageScript.Create(Nil);
End;

(******************************************************************************)

Function TTSTOVintageScript.GetPluginKind() : TTSTOPluginKind;
Begin
  Result := pkGUI;
End;

Function TTSTOVintageScript.GetHaveSettings() : Boolean;
Begin
  Result := True;
End;

Function TTSTOVintageScript.GetName() : String;
Begin
  Result := 'TSTOVintageScript';
End;

Function TTSTOVintageScript.GetDescription() : String;
Begin
  Result := 'Patches and custom script for old TSTO';
End;

Function TTSTOVintageScript.GetPluginId() : String;
Begin
  Result := 'TSTOModToolKit.PlgTSTOVintageScript';
End;

Function TTSTOVintageScript.GetPluginVersion() : String;
Begin
  Result := '1.0.0.1';
End;

Procedure TTSTOVintageScript.Initialize(AMainApplication: ITSTOApplication);
Begin
  InHerited Initialize(AMainApplication);

  If Initialized Then
  Begin
    LoadSettings();
    InitUI();
  End;
End;

procedure TTSTOVintageScript.DataModuleCreate(Sender: TObject);
begin
  If Not Assigned(FMnuItems) Then
  Begin
    FMnuItems := TSpTBXSubmenuItem.Create(Self);
    FMnuItems.Name := 'mnuPlgVintage';
    FMnuItems.Caption := 'Vintage Scripts';
    FMnuItems.Images := imgToolBar;
    FMnuItems.ImageIndex := 0;
  End;

  If Not Assigned(FTbItems) Then
  Begin
    FTbItems := TSpTBXSubmenuItem.Create(Self);
    FTbItems.Name := 'tbPlgVintage';
    FTbItems.Caption := 'Vintage Scripts';
    FTbItems.Images := imgToolBar;
    FTbItems.ImageIndex := 0;
    FTbItems.DropdownCombo := True;
  End;
end;

procedure TTSTOVintageScript.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(FMnuItems);
  FreeAndNil(FTbItems);
end;

Procedure TTSTOVintageScript.Finalize();
Begin
  SaveSettings();

  InHerited Finalize();
End;

Function TTSTOVintageScript.ShowSettings() : Boolean;
Var lSettings : ITSTOVintageScriptSetting;
    X : Integer;
    lIsModified : Boolean;
Begin
  With TTSTOVintageScriptSettingsDlg.Create(Self) Do
  Try
    lSettings := TTSTOVintageScriptSetting.CreateSettings();
    Try
      lSettings.Assign(FSettings);

      MainApp := Self.MainApp;
      PluginSettings := FSettings;

      If ShowModal() = mrOk Then
      Begin
        lIsModified := (lSettings.Enabled <> FSettings.Enabled) Or
                       (lSettings.UseAppSetting <> FSettings.UseAppSetting) Or
                       Not SameText(lSettings.HackMasterListFileName, FSettings.HackMasterListFileName) Or
                       Not SameText(lSettings.ResourcePath, FSettings.ResourcePath) Or
                       Not SameText(lSettings.StorePath, FSettings.StorePath) Or
                       Not SameText(lSettings.ScriptPath, FSettings.ScriptPath);

        If Not lIsModified Then
          For X := 0 To lSettings.Items.Count - 1 Do
          Begin
            lIsModified := (lSettings.Items[X].Enabled <> FSettings.Items[X].Enabled) Or
                           (lSettings.Items[X].AddInMenu <> FSettings.Items[X].AddInMenu) Or
                           (lSettings.Items[X].AddInToolBar <> FSettings.Items[X].AddInToolBar) Or
                           (lSettings.Items[X].ScriptType <> FSettings.Items[X].ScriptType);

            If lIsModified Then
              Break;
          End;

        If lIsModified Then
        Begin
          Enabled := FSettings.Enabled;
          SaveSettings();
          InitUI();
        End;
      End;

      Finally
        lSettings := Nil;
    End;

    Finally
      Release();
  End;
End;

Procedure TTSTOVintageScript.InitUI();
  Type
    TSTOItemType = (itMenu, itToolBar);

  Procedure InternalBuild(ARoot : TSpTBXSubmenuItem; Const AItems : TSTOVintageScriptTypes; Const AItemType : TSTOItemType);
  Var X       : Integer;
      lSubMnu : TSpTBXSubmenuItem;
      lMnu    : TSpTBXItem;
  Begin
    If AItems <> [] Then
    Begin
      If AItems * [vstRGBFiles, vstSkinStore] <> [] Then
      Begin
        lSubMnu := TSpTbxSubMenuItem.Create(Self);
        lSubMnu.Caption := mnuHelper.Caption;
        If AItems * [vstRGBFiles, vstSkinStore] = [vstRGBFiles, vstSkinStore] Then
          lSubMnu.LinkSubitems := mnuHelper
        Else If AItems * [vstRGBFiles] = [vstRGBFiles] Then
        Begin
          lMnu := TSpTbxItem.Create(Self);
          lMnu.Caption := mnuListMissingRGBFiles.Caption;
          lMnu.OnClick := mnuListMissingRGBFiles.OnClick;
          lSubMnu.Add(lMnu);
        End
        Else
        Begin
          lMnu := TSpTbxItem.Create(Self);
          lMnu.Caption := mnuBuildSkinStore.Caption;
          lMnu.OnClick := mnuBuildSkinStore.OnClick;
          lSubMnu.Add(lMnu);
        End;

        ARoot.Add(lSubMnu);
      End;

      If AItems * [vstFarm, vstOldMenu] <> [] Then
      Begin
        lSubMnu := TSpTbxSubMenuItem.Create(Self);
        lSubMnu.Caption := mnuVintageScript.Caption;
        If AItems * [vstFarm, vstOldMenu] = [vstFarm, vstOldMenu] Then
          lSubMnu.LinkSubitems := mnuVintageScript
        Else If AItems * [vstFarm] = [vstFarm] Then
        Begin
          lMnu := TSpTbxItem.Create(Self);
          lMnu.Caption := mnuFreeFarmAndSelector.Caption;
          lMnu.OnClick := mnuFreeFarmAndSelector.OnClick;
          lSubMnu.Add(lMnu);
        End
        Else
        Begin
          lMnu := TSpTbxItem.Create(Self);
          lMnu.Caption := mnuOldStoreMenu.Caption;
          lMnu.OnClick := mnuOldStoreMenu.OnClick;
          lSubMnu.Add(lMnu);
        End;

        ARoot.Add(lSubMnu);
      End;

      If AItemType = itMenu Then
      Begin
        ARoot.Add(TSpTBXSeparatorItem.Create(Self));
        lMnu := TSpTBXItem.Create(Self);
        lMnu.Caption := mnuPluginSettings.Caption;
        lMnu.OnClick := mnuPluginSettings.OnClick;
        ARoot.Add(lMnu);

        MainApp.AddItem(iikMainMenu, Self, ARoot);
      End
      Else If AItemType = itToolBar Then
        MainApp.AddItem(iikToolBar, Self, ARoot);
    End;
  End;

Var lMnuTypes     : TSTOVintageScriptTypes;
    lToolBarTypes : TSTOVintageScriptTypes;
    X             : Integer;
Begin
  FMnuItems.Clear();
  FTbItems.Clear();

  MainApp.RemoveItem(iikMainMenu, Self, FMnuItems);
  MainApp.RemoveItem(iikToolBar, Self, FTbItems);

  If Enabled Then
  Begin
    For X := 0 To FSettings.Items.Count - 1 Do
      If FSettings.Items[X].Enabled Then
      Begin
        If FSettings.Items[X].Enabled And FSettings.Items[X].AddInMenu Then
          lMnuTypes := lMnuTypes + [FSettings.Items[X].ScriptType];

        If FSettings.Items[X].Enabled And FSettings.Items[X].AddInToolBar Then
          lToolBarTypes := lToolBarTypes + [FSettings.Items[X].ScriptType];
      End;

    InternalBuild(FMnuItems, lMnuTypes, itMenu);
    InternalBuild(FTbItems, lToolBarTypes, itToolBar);
  End;
End;

Procedure TTSTOVintageScript.LoadSettings();
Begin
  FSettings := TTSTOVintageScriptSetting.CreateSettings();
  FSettings.LoadFromFile(ChangeFileExt(PluginFileName, '.cfg'));
  Enabled := FSettings.Enabled;
End;

Procedure TTSTOVintageScript.SaveSettings();
Begin
  FSettings.SaveToFile(ChangeFileExt(PluginFileName, '.cfg'));
End;

procedure TTSTOVintageScript.mnuListMissingRGBFilesClick(Sender: TObject);
Var lNodes : IXmlNodeListEx;
    X, Y : Integer;
    lLst : IHsStringListEx;
    lHackMaster : ITSTOHackMasterListIO;
begin
  lLst := THsStringListEx.CreateList();
  Try
    If FSettings.UseAppSetting And Assigned(MainApp.WorkSpace) And
       Assigned(MainApp.WorkSpace.HackSettings.HackMasterList) Then
    Begin
      lHackMaster := MainApp.WorkSpace.HackSettings.HackMasterList;
      For X := 0 To lHackMaster.Count - 1 Do
        If lHackMaster[X].BuildStore Then
          If Not FileExists(FSettings.ResourcePath + lHackMaster[X].Name + 'Store.rgb') Then
            lLst.Add(lHackMaster[X].Name + 'Store.rgb');
    End
    Else
    Begin
      lNodes := LoadXMLDocument(FSettings.HackMasterListFileName).SelectNodes('//Category[not(@BuildStore="false")]');
      If Assigned(lNodes) Then
      Begin
        For X := 0 To lNodes.Count - 1 Do
          If Not FileExists(FSettings.ResourcePath + lNodes[X].Attributes['Name'] + 'Store.rgb') Then
            lLst.Add(lNodes[X].Attributes['Name'] + 'Store.rgb');
      End;
    End;

    If lLst.Count > 0 Then
      ShowMessage(IntToStr(lLst.Count) + ' missing files : '#$D#$A + lLst.Text)
    Else
      ShowMessage('No missing file found.');

    Finally
      lLst := Nil;
  End;
end;

procedure TTSTOVintageScript.mnuBuildSkinStoreClick(Sender: TObject);
Var lNodes  : IXmlNodeListEx;
    X, Y, Z : Integer;
    lLst    : IHsStringListEx;
    lHackML : ITSTOHackMasterListIO;
begin
  lHackML := MainApp.WorkSpace.HackSettings.HackMasterList;
  If FSettings.UseAppSetting And Assigned(MainApp.WorkSpace) And
     Assigned(lHackML) Then
  Begin
    lLst := THsStringListEx.CreateList();
    Try
      lLst.Add('<StoreKahnBuildingsUpgrade>');

      For X := 0 To lHackMl.Count - 1 Do
        For Y := 0 To lHackMl[X].Count - 1 Do
          For Z := 0 To lHackMl[X][Y].Count - 1 Do
            If SameText(lHackMl[X][Y][Z].ObjectType, 'BuildingSkin') Then
              lLst.Add( '<Object type="consumable" id="' + IntToStr(lHackMl[X][Y][Z].Id) + '" ' +
                        'name="' + lHackMl[X][Y][Z].Name + '"/>' );
      lLst.Add('</StoreKahnBuildingsUpgrade>');
      lLst.SaveToFile(FSettings.StorePath + '00-BuildingUpgrade.xml');

      Finally
        lLst := Nil;
    End;

    lLst := THsStringListEx.CreateList();
    Try
      lLst.Add('<StoreKahnCharacterSkin>');

      For X := 0 To lHackMl.Count - 1 Do
        For Y := 0 To lHackMl[X].Count - 1 Do
          For Z := 0 To lHackMl[X][Y].Count - 1 Do
            If SameText(lHackMl[X][Y][Z].ObjectType, 'CharacterSkin') Then
              lLst.Add( '<Object type="consumable" id="' + IntToStr(lHackMl[X][Y][Z].Id) + '" ' +
                        'name="' + lHackMl[X][Y][Z].Name + '"/>' );
      lLst.Add('</StoreKahnCharacterSkin>');
      lLst.SaveToFile(FSettings.StorePath + '00-CharacterSkin.xml');

      Finally
        lLst := Nil;
    End;
  End
  Else
  Begin
    lNodes := LoadXMLDocument(FSettings.HackMasterListFileName).SelectNodes('//*[@Type="BuildingSkin"]');
    If Assigned(lNodes) Then
    Try
      lLst := THsStringListEx.CreateList();

      Try
        lLst.Add('<StoreKahnBuildingsUpgrade>');
        For X := 0 To lNodes.Count - 1 Do
        Begin
          lLst.Add(  '<Object type="consumable" id="' + lNodes[X].AttributeNodes['id'].Text + '" ' +
                     'name="' + lNodes[X].AttributeNodes['name'].Text + '"/>' );
        End;
        lLst.Add('</StoreKahnBuildingsUpgrade>');

        lLst.SaveToFile(FSettings.StorePath + '00-BuildingUpgrade.xml');

        Finally
          lLst := Nil;
      End;

      Finally
        lNodes := Nil;
    End;

    lNodes := LoadXMLDocument(FSettings.HackMasterListFileName).SelectNodes('//*[@Type="CharacterSkin"]');
    If Assigned(lNodes) Then
    Try
      lLst := THsStringListEx.CreateList();

      Try
        lLst.Add('<StoreKahnCharacterSkin>');
        For X := 0 To lNodes.Count - 1 Do
        Begin
          lLst.Add( '<Object type="consumable" id="' + lNodes[X].AttributeNodes['id'].Text + '" ' +
                    'name="' + lNodes[X].AttributeNodes['name'].Text + '"/>' );
        End;
        lLst.Add('</StoreKahnCharacterSkin>');

        lLst.SaveToFile(FSettings.StorePath + '00-CharacterSkin.xml');

        Finally
          lLst := Nil;
      End;

      Finally
        lNodes := Nil;
    End;
  End;

  ShowMessage('Done');
end;

procedure TTSTOVintageScript.mnuFreeFarmAndSelectorClick(Sender: TObject);
Var lXml          : IXmlDocumentEx;
    lNodes        : IXmlNodeListEx;
    X, Y          : Integer;
    lSelectorName : String;
    lStrs         ,
    lStrs2        : IHsStringListEx;
    lPath         : String;
begin
  If FSettings.UseAppSetting And Assigned(MainApp.CurrentProject) Then
    lPath := IncludeTrailingBackSlash(MainApp.CurrentProject.SrcPath)
  Else
    lPath := FSettings.ScriptPath;

  If FileExists(lPath + 'Farms.xml') Then
  Begin
    lXml := LoadXMLDocument(lPath + 'Farms.xml');
    Try
      lNodes := lXml.SelectNodes('//Farm');

      If Assigned(lNodes) Then
      Begin
        lStrs := THsStringListEx.CreateList();
        lStrs2 := THsStringListEx.CreateList();

        Try
          lStrs2.Add('<Patch Name="FreeFarm" Active="true">');
          lStrs2.Add('  <PatchDesc>Free Farm Job</PatchDesc>');
          lStrs2.Add('  <FileName>Farms.xml</FileName>');

          For X := 0 To lNodes.Count - 1 Do
            For Y := 0 To lNodes[X].ChildNodes.Count - 1 Do
            Begin
              If SameText(lNodes[X].ChildNodes[Y].NodeName, 'Job') Then
              Begin
                lSelectorName := 'Khn' + lNodes[X].AttributeNodes['name'].Text +
                                 lNodes[X].ChildNodes[Y].AttributeNodes['name'].Text +
                                 'JobCostFormula';

                lStrs.Add( '<Selector name="' + lSelectorName + '" ' +
                           'type="formula" formula="if(HackDisabled==0, 0, ' +
                           lNodes[X].ChildNodes[Y].ChildNodes['Cost'].AttributeNodes['money'].Text + ')"/>'
                );

                lStrs2.Add('  <PatchData>');
                lStrs2.Add('    <PatchType>3</PatchType>');
                lStrs2.Add('    <PatchPath>//Job[@name="' + lNodes[X].ChildNodes[Y].AttributeNodes['name'].Text + '"]/Cost</PatchPath>');
                lStrs2.Add('    <Code>');
                lStrs2.Add('      <![CDATA[<Cost money="selector ' + lSelectorName + '"/>');
                lStrs2.Add('      ]]>');
                lStrs2.Add('    </Code>');
                lStrs2.Add('  </PatchData>');
              End;
            End;

          lStrs2.Add('</Patch>');
          lStrs2.SaveToFile(ExtractFilePath(ExcludeTrailingBackSlash(lPath)) + '\FreeFarmPatch.xml');

          lStrs2.Clear();
          For X := lStrs.Count - 1 DownTo 0 Do
            lStrs2.Add(lStrs[X]);
          lStrs2.SaveToFile(ExtractFilePath(ExcludeTrailingBackSlash(lPath)) + '\FarmSelectors.xml');

          Finally
            lStrs := Nil;
            lStrs2 := Nil;
        End;
      End;

      Finally
        lXml := Nil;
    End;
  End;
end;

procedure TTSTOVintageScript.mnuOldStoreMenuClick(Sender: TObject);
Var lNodes : IXmlNodeListEx;
    X, Y, Z : Integer;
    lLst  : IHsStringListEx;
    lLst2 : IHsStringListEx;
    lNode : IXmlNodeEx;
    lHackML : ITSTOHackMasterListIO;
    lPath   : String;
begin
  If Assigned(MainApp.CurrentProject) Then
    lPath := ExtractFilePath(ExcludeTrailingBackSlash(MainApp.CurrentProject.SrcPath))
  Else
    lPath := FSettings.StorePath;

  lHackML := MainApp.WorkSpace.HackSettings.HackMasterList;

  If FSettings.UseAppSetting And Assigned(lHackML) Then
  Begin
    lLst := THsStringListEx.CreateList();
    Try
      For X := 0 To lHackML.Count - 1 Do
        If lHackML[X].BuildStore Then
        Begin
          lLst.Add( '<Category name="Khn' + lHackML[X].Name + '" ' +
                    'title="UI_' + lHackML[X].Name + '" ' +
                    'icon="' + lHackML[X].Name + 'Store" ' +
                    'disabledIcon="' + lHackML[X].Name + 'Store" ' +
                    'emptyText="UI_StoreEmpty" ' +
                    'file="StoreMenu_' + lHackML[X].Name + '.xml"/>' );

          lLst2 := THsStringListEx.CreateList();
          Try
            lLst2.Add('<Category name="Khn' + lHackML[X].Name + '">');
            For Y := 0 To lHackML[X].Count - 1 Do
              If lHackML[X][Y].Enabled Then
                For Z := 0 To lHackML[X][Y].Count - 1 Do
                  If lHackML[X][Y][Z].AddInStore Then
                    lLst2.Add( '<Object type="' + LowerCase(lHackML[X][Y][Z].ObjectType) + '" ' +
                               'id="' + IntToStr(lHackML[X][Y][Z].Id) + '" ' +
                               'name="' + lHackML[X][Y][Z].Name + '"/>' );
            lLst2.Add('</Category>');

            lLst2.Text := FormatXmlData(lLst2.Text);
            lLst2.SaveToFile(lPath + 'storemenu_' + LowerCase(lHackML[X].Name) + '.xml');

            Finally
              lLst2 := Nil;
          End;
        End;

      lLst.SaveToFile(lPath + '00-StoreMenu.xml');
      ShowMessage('Done');

      Finally
        lLst := Nil;
    End;
  End
  Else
  Begin
    lNodes := LoadXMLDocument(FSettings.HackMasterListFileName).SelectNodes('//Category[not(@BuildStore="false")]');
    If Assigned(lNodes) Then
    Begin
      lLst := THsStringListEx.CreateList();

      Try
        For X := lNodes.Count - 1 DownTo 0 Do
        Begin
          lLst.Add( '<Category name="Khn' + lNodes[X].AttributeNodes['Name'].Text + '" ' +
                    'title="UI_' + lNodes[X].AttributeNodes['Name'].Text + '" ' +
                    'icon="' + lNodes[X].AttributeNodes['Name'].Text + 'Store" ' +
                    'disabledIcon="' + lNodes[X].AttributeNodes['Name'].Text + '" ' +
                    'emptyText="UI_StoreEmpty" ' +
                    'file="StoreMenu_' + lNodes[X].AttributeNodes['Name'].Text + '.xml"/>' );

          lLst2 := THsStringListEx.CreateList();
          Try
            lLst2.Add('<Category name="' + lNodes[X].AttributeNodes['Name'].Text + '">');
            For Y := 0 To lNodes[X].ChildNodes.Count - 1 Do
            Begin
              lNode := lNodes[X].ChildNodes[Y].AttributeNodes.FindNode('Enabled');

              If Not Assigned(lNode) Or (Assigned(lNode) And lNode.AsBoolean) Then
                For Z := 0 To lNodes[X].ChildNodes[Y].ChildNodes.Count - 1 Do
                Begin
                  lNode := lNodes[X].ChildNodes[Y].ChildNodes[Z].AttributeNodes.FindNode('AddInStore');
                  If Not Assigned(lNode) Or (Assigned(lNode) And lNode.AsBoolean) Then
                    lLst2.Add( '<Object type="' + LowerCase(lNodes[X].ChildNodes[Y].AttributeNodes['Type'].Text) + '" ' +
                               'id="' + lNodes[X].ChildNodes[Y].ChildNodes[Z].AttributeNodes['id'].AsString + '" ' +
                               'name="' + lNodes[X].ChildNodes[Y].ChildNodes[Z].AttributeNodes['name'].AsString + '"/>' );
                End;
            End;
            lLst2.Add('</Category>');

            lLst2.Text := FormatXmlData(lLst2.Text);
            lLst2.SaveToFile(lPath + 'storemenu_' + LowerCase(lNodes[X].AttributeNodes['Name'].Text) + '.xml');

            Finally
              lLst2 := Nil;
          End;
        End;

        lLst.SaveToFile(lPath + '00-StoreMenu.xml');
        ShowMessage('Done');

        Finally
          lLst := Nil;
      End;
    End;
  End;
end;

procedure TTSTOVintageScript.mnuPluginSettingsClick(Sender: TObject);
begin
  ShowSettings();
end;

end.
