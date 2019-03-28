unit PlgTSTOVintageScript;

interface

uses
  PlgTSTOCustomPlugin, TSTOPluginIntf,
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

    procedure mnuListMissingRGBFilesClick(Sender: TObject);
    procedure mnuBuildSkinStoreClick(Sender: TObject);
    procedure mnuFreeFarmAndSelectorClick(Sender: TObject);
    procedure mnuOldStoreMenuClick(Sender: TObject);
    procedure mnuPluginSettingsClick(Sender: TObject);

  Private
    FHackMasterListFileName : String;
    FResourcePath : String;
    FStorePath : String;
    FScriptPath : String;

    Procedure InitUI();
//    Procedure LoadSettings();
//    Procedure SaveSettings();

  Protected
    Function  GetPluginKind() : TTSTOPluginKind; OverRide;
    Function  GetHaveSettings() : Boolean; OverRide;

    Function  GetEnabled() : Boolean; OverRide;

    Function  GetName() : String; OverRide;
    Function  GetDescription() : String; OverRide;
    Function  GetPluginId() : String; OverRide;
    Function  GetPluginVersion() : String; OverRide;

//    Procedure Configure(); OverRide;
    Procedure Initialize(AMainApplication : ITSTOApplication); OverRide;
//    Procedure Finalize(); OverRide;
    Function  ShowSettings() : Boolean; OverRide;

  public

  end;

Function CreateTSTOPlugin() : ITSTOPlugin;

implementation

Uses
  Dialogs,
  HsStringListEx, HsXmlDocEx,
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

Function TTSTOVintageScript.GetEnabled() : Boolean;
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
    InitUI();

    FHackMasterListFileName := 'Z:\Temp\TSTO\Bin\HackNew\NhakinHack.Src\HackMasterList.xml';
    FResourcePath           := 'Z:\Temp\TSTO\Bin\HackNew\NhakinHack.Src\GameScript.src\3.src\';
    FStorePath              := 'Z:\Temp\TSTO\Bin\HackNew\NhakinHack.Src\GameScripts.src\2.src\';
    FScriptPath             := 'Z:\Temp\TSTO\Bin\HackNew\4_14_Terwilligers_Patch3_PostLaunch_PCH4G4DL5LB0\gamescripts-r202094-EKXHLFAI\0';
  End;
End;

Function TTSTOVintageScript.ShowSettings() : Boolean;
Begin
  With TTSTOVintageScriptSettingsDlg.Create(Self) Do
  Try

    If ShowModal() = mrOk Then
    Begin

    End;

    Finally
      Release();
  End;
End;

Procedure TTSTOVintageScript.InitUI();
Begin
  MainApp.RemoveItem(iikMainMenu, Self, mnuVintagePlugin);

  If Enabled Then
  Begin
    MainApp.AddItem(iikMainMenu, Self, mnuVintagePlugin);
  End;
End;

procedure TTSTOVintageScript.mnuListMissingRGBFilesClick(Sender: TObject);
Var lNodes : IXmlNodeListEx;
    X : Integer;
    lLst : IHsStringListEx;
begin
  lNodes := LoadXMLDocument(FHackMasterListFileName).SelectNodes('//Category[not(@BuildStore="false")]');
  If Assigned(lNodes) Then
  Begin
    lLst := THsStringListEx.CreateList();

    Try
      For X := 0 To lNodes.Count - 1 Do
        If Not FileExists(FResourcePath + lNodes[X].Attributes['Name'] + 'Store.rgb') Then
          lLst.Add(lNodes[X].Attributes['Name'] + 'Store.rgb');

      If lLst.Count > 0 Then
        ShowMessage(IntToStr(lLst.Count) + ' missing files : '#$D#$A + lLst.Text)
      Else
        ShowMessage('No missing file found.');

      Finally
        lLst := Nil;
    End;
  End;
end;

procedure TTSTOVintageScript.mnuBuildSkinStoreClick(Sender: TObject);
Var lNodes : IXmlNodeListEx;
    X      : Integer;
    lLst   : IHsStringListEx;
begin
  lNodes := LoadXMLDocument(FHackMasterListFileName).SelectNodes('//*[@Type="BuildingSkin"]');
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

      lLst.SaveToFile(FStorePath + '00-BuildingUpgrade.xml');

      Finally
        lLst := Nil;
    End;

    Finally
      lNodes := Nil;
  End;

  lNodes := LoadXMLDocument(FHackMasterListFileName).SelectNodes('//*[@Type="CharacterSkin"]');
  If Assigned(lNodes) Then
  Try
    lLst := THsStringListEx.CreateList();

    Try
      lLst.Add('<StoreKahnCharacterSkin>');
      For X := 0 To lNodes.Count - 1 Do
      Begin
        lLst.Add(  '<Object type="consumable" id="' + lNodes[X].AttributeNodes['id'].Text + '" ' +
                   'name="' + lNodes[X].AttributeNodes['name'].Text + '"/>' );
      End;
      lLst.Add('</StoreKahnCharacterSkin>');

      lLst.SaveToFile(FStorePath + '00-CharacterSkin.xml');

      Finally
        lLst := Nil;
    End;

    Finally
      lNodes := Nil;
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
begin
  If FileExists(FScriptPath + 'Farms.xml') Then
  Begin
    lXml := LoadXMLDocument(FScriptPath + 'Farms.xml');
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
          lStrs2.SaveToFile(ExtractFilePath(ExcludeTrailingBackSlash(FScriptPath)) + '\FreeFarmPatch.xml');

          lStrs2.Clear();
          For X := lStrs.Count - 1 DownTo 0 Do
            lStrs2.Add(lStrs[X]);
          lStrs2.SaveToFile(ExtractFilePath(ExcludeTrailingBackSlash(FScriptPath)) + '\FarmSelectors.xml');

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
begin
  lNodes := LoadXMLDocument(FHackMasterListFileName).SelectNodes('//Category[not(@BuildStore="false")]');
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
          lLst2.SaveToFile(FStorePath + 'storemenu_' + LowerCase(lNodes[X].AttributeNodes['Name'].Text) + '.xml');

          Finally
            lLst2 := Nil;
        End;
      End;

      lLst.SaveToFile(FStorePath + '00-StoreMenu.xml');
      ShowMessage('Done');

      Finally
        lLst := Nil;
    End;
  End;
end;

procedure TTSTOVintageScript.mnuPluginSettingsClick(Sender: TObject);
begin
  ShowSettings();
end;

end.
