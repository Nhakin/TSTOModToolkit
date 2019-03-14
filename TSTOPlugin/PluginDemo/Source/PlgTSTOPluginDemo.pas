unit PlgTSTOPluginDemo;

interface

uses
  TSTOPluginIntf, PlgTSTOCustomPlugin,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, TB2Item, SpTBXItem;

type
  TTSTOPluginDemo = class(TTSTOCustomPlugin)
    SpTBXBItemContainer1: TSpTBXBItemContainer;
    SpTbxPluginDemo: TSpTBXItem;
    SpTbxSubMenu: TSpTBXSubmenuItem;
    SpTbxPlay: TSpTBXItem;
    SpTbxStop: TSpTBXItem;
    SpTBXSeparatorItem1: TSpTBXSeparatorItem;
    SpTbxChildSubMenu: TSpTBXSubmenuItem;
    SpTbxPlayAnimation: TSpTBXItem;
    SpTbxStopAnimation: TSpTBXItem;
    SpTBXSeparatorItem2: TSpTBXSeparatorItem;
    GrpPluginDemo: TSpTBXTBGroupItem;
    GrpPluginDemoItems: TSpTBXTBGroupItem;
    SpTBXGrpSingleItem: TSpTBXItem;
    SpTbxGrpSubMenu: TSpTBXSubmenuItem;
    SpTBXFreeFarm: TSpTBXItem;
    SpTbxOldStoreMenu: TSpTBXItem;
    ilMain: TImageList;

    procedure TSTOPluginDemoDestroy(Sender: TObject);

    procedure SpTbxPluginDemoClick(Sender: TObject);
    procedure SpTbxPlayAnimationClick(Sender: TObject);
    procedure SpTbxStopAnimationClick(Sender: TObject);
    procedure SpTBXGrpSingleItemClick(Sender: TObject);
    procedure SpTBXFreeFarmClick(Sender: TObject);
    procedure SpTbxOldStoreMenuClick(Sender: TObject);
    procedure SpTbxPlayClick(Sender: TObject);

  Private
    FAddMenuItem      : Boolean;
    FAddToolBarButton : Boolean;
    FScriptsPath      : String;

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

    Procedure Configure(); OverRide;
    Procedure Initialize(AMainApplication : ITSTOApplication); OverRide;
    Procedure Finalize(); OverRide;
    Function  ShowSettings() : Boolean; OverRide;

  end;

Function CreateTSTOPlugin() : ITSTOPlugin;

implementation

Uses IniFiles, HsXmlDocEx, HsStringListEx, DlgTSTOPluginDemoSettings;

{$R *.dfm}

Function CreateTSTOPlugin() : ITSTOPlugin;
Begin
  Result := TTSTOPluginDemo.Create(Nil);
End;

Procedure TTSTOPluginDemo.Initialize(AMainApplication: ITSTOApplication);
Begin
  InHerited Initialize(AMainApplication);

  If Initialized Then
  Begin
    InitUI();

    FScriptsPath := 'Z:\Temp\TSTO\Bin\HackNew\4_13_SuperheroesBossFight_Patch1_X7R495GALOCZ\gamescripts-r180893-EZJH8F1D\0\'; 
  End;
End;

Procedure TTSTOPluginDemo.Finalize();
Begin
  If Initialized Then
  Begin
    MainApp.RemoveItem(iikToolBar, Self, SpTbxPluginDemo);
    MainApp.RemoveItem(iikToolBar, Self, SpTbxSubMenu);
    MainApp.RemoveItem(iikToolBar, Self, GrpPluginDemoItems);

    MainApp.RemoveItem(iikMainMenu, Self, SpTbxPluginDemo);
    MainApp.RemoveItem(iikMainMenu, Self, SpTbxSubMenu);
    MainApp.RemoveItem(iikMainMenu, Self, GrpPluginDemoItems);
  End;

  InHerited Finalize();
End;

Function TTSTOPluginDemo.GetPluginKind() : TTSTOPluginKind;
Begin
  Result := pkGUI;
End;

Function TTSTOPluginDemo.GetHaveSettings() : Boolean;
Begin
  Result := True;
End;

Function TTSTOPluginDemo.ShowSettings() : Boolean;
Begin
  Result := InHerited ShowSettings();

  With TTSTOPluginDemoSettingsDlg.Create(Self) Do
  Try
    MainApp          := Self.MainApp;
    PluginEnabled    := Self.Enabled;
    AddMenuItem      := FAddMenuItem;
    AddToolBarButton := FAddToolBarButton;

    If ShowModal() = mrOk Then
    Begin
      Result := (Self.Enabled <> PluginEnabled) Or
                (FAddMenuItem <> AddMenuItem) Or
                (FAddToolBarButton <> AddToolBarButton);

      Self.Enabled      := PluginEnabled;
      FAddMenuItem      := AddMenuItem;
      FAddToolBarButton := AddToolBarButton;

      If Result Then
        SaveSettings();
    End;

    Finally
      Release();
  End;
End;

//List missing RGB Files for stores
procedure TTSTOPluginDemo.SpTBXGrpSingleItemClick(Sender: TObject);
Var lNodes : IXmlNodeListEx;
    X : Integer;
    lLst : IHsStringListEx;
begin
  inherited;

  lNodes := LoadXMLDocument('Z:\Temp\TSTO\Bin\HackNew\NhakinHack.Src\HackMasterList.xml').SelectNodes('//Category[not(@BuildStore="false")]');
  If Assigned(lNodes) Then
  Begin
    lLst := THsStringListEx.CreateList();

    Try
      For X := 0 To lNodes.Count - 1 Do
        If Not FileExists('Z:\Temp\TSTO\Bin\HackNew\NhakinHack.Src\GameScript.src\3.src\' + lNodes[X].Attributes['Name'] + 'Store.rgb') Then
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

//Free farm Patch and Selector
procedure TTSTOPluginDemo.SpTBXFreeFarmClick(Sender: TObject);
Var lXml   : IXmlDocumentEx;
    lNodes : IXmlNodeListEx;
    X, Y   : Integer;
    lSelectorName : String;
    lStrs  ,
    lStrs2 : IHsStringListEx;
begin
  If FileExists(FScriptsPath + 'Farms.xml') Then
  Begin
    lXml := LoadXMLDocument(FScriptsPath + 'Farms.xml');
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
          lStrs2.SaveToFile(ExtractFilePath(ExcludeTrailingBackSlash(FScriptsPath)) + '\FreeFarmPatch.xml');

          lStrs2.Clear();
          For X := lStrs.Count - 1 DownTo 0 Do
            lStrs2.Add(lStrs[X]);
          lStrs2.SaveToFile(ExtractFilePath(ExcludeTrailingBackSlash(FScriptsPath)) + '\FarmSelectors.xml');

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

//Build Store and Inventory Menu for old TSTO version
procedure TTSTOPluginDemo.SpTbxOldStoreMenuClick(Sender: TObject);
Var lNodes : IXmlNodeListEx;
    X, Y, Z : Integer;
    lLst  : IHsStringListEx;
    lLst2 : IHsStringListEx;
    lNode : IXmlNodeEx;
    lStr : String;
begin
  lNodes := LoadXMLDocument('Z:\Temp\TSTO\Bin\HackNew\NhakinHack.Src\HackMasterList.xml').SelectNodes('//Category[not(@BuildStore="false")]');
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
          lLst2.SaveToFile('Z:\Temp\TSTO\Bin\HackNew\NhakinHack.Src\GameScripts.src\2.src\storemenu_' + LowerCase(lNodes[X].AttributeNodes['Name'].Text) + '.xml');

          Finally
            lLst2 := Nil;
        End;
      End;

      lLst.SaveToFile('Z:\Temp\TSTO\Bin\HackNew\NhakinHack.Src\GameScripts.src\2.src\00-StoreMenu.xml');
      ShowMessage('Done');
      
      Finally
        lLst := Nil;
    End;
  End;
end;

procedure TTSTOPluginDemo.SpTbxPlayAnimationClick(Sender: TObject);
begin
  inherited;

  ShowMessage('Play Animation');
end;

procedure TTSTOPluginDemo.SpTbxPlayClick(Sender: TObject);
Var lNodes : IXmlNodeListEx;
    X, Y, Z : Integer;
    lLst  : IHsStringListEx;
    lLst2 : IHsStringListEx;
    lNode : IXmlNodeEx;
    lStr : String;
begin
  lNodes := LoadXMLDocument('Z:\Temp\TSTO\Bin\HackNew\NhakinHack.Src\HackMasterList.xml').SelectNodes('//*[@Type="BuildingSkin"]');
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

      lLst.SaveToFile('Z:\Temp\TSTO\Bin\HackNew\NhakinHack.Src\GameScripts.src\2.src\00-BuildingUpgrade.xml');

      Finally
        lLst := Nil;
    End;

    Finally
      lNodes := Nil;
  End;

  lNodes := LoadXMLDocument('Z:\Temp\TSTO\Bin\HackNew\NhakinHack.Src\HackMasterList.xml').SelectNodes('//*[@Type="CharacterSkin"]');
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

      lLst.SaveToFile('Z:\Temp\TSTO\Bin\HackNew\NhakinHack.Src\GameScripts.src\2.src\00-CharacterSkin.xml');

      Finally
        lLst := Nil;
    End;

    Finally
      lNodes := Nil;
  End;

  ShowMessage('Done');
end;

procedure TTSTOPluginDemo.SpTbxPluginDemoClick(Sender: TObject);
begin
  inherited;

  ShowMessage('Plugin Demo');
end;

procedure TTSTOPluginDemo.SpTbxStopAnimationClick(Sender: TObject);
begin
  inherited;

  ShowMessage('Stop Animation');
end;

Function TTSTOPluginDemo.GetName() : String;
Begin
  Result := 'TSTOPluginDemo';
End;

Function TTSTOPluginDemo.GetDescription() : String;
Begin
  Result := 'Add buttons and menu item to main application';
End;

Function TTSTOPluginDemo.GetPluginId() : String;
Begin
  Result := 'TSTOModToolKit.PlgTSTOPluginDemo';
End;

Function TTSTOPluginDemo.GetPluginVersion() : String;
Begin
  Result := '1.0.0.2';
End;

procedure TTSTOPluginDemo.Configure();
begin
  LoadSettings();

  InHerited;
end;

procedure TTSTOPluginDemo.TSTOPluginDemoDestroy(Sender: TObject);
begin
  SaveSettings();

  InHerited;
end;

Procedure TTSTOPluginDemo.InitUI();
Begin
  MainApp.RemoveItem(iikToolBar, Self, SpTbxPluginDemo);
  MainApp.RemoveItem(iikToolBar, Self, SpTbxSubMenu);
  MainApp.RemoveItem(iikToolBar, Self, GrpPluginDemoItems);

  MainApp.RemoveItem(iikMainMenu, Self, SpTbxPluginDemo);
  MainApp.RemoveItem(iikMainMenu, Self, SpTbxSubMenu);
  MainApp.RemoveItem(iikMainMenu, Self, GrpPluginDemoItems);

  If Enabled Then
  Begin
    If FAddToolBarButton Then
    Begin
      MainApp.AddItem(iikToolBar, Self, SpTbxPluginDemo);
      MainApp.AddItem(iikToolBar, Self, SpTbxSubMenu);
      MainApp.AddItem(iikToolBar, Self, GrpPluginDemoItems);
    End;

    If FAddMenuItem Then
    Begin
      MainApp.AddItem(iikMainMenu, Self, SpTbxPluginDemo);
      MainApp.AddItem(iikMainMenu, Self, SpTbxSubMenu);
      MainApp.AddItem(iikMainMenu, Self, GrpPluginDemoItems);
    End;
  End;
End;

Procedure TTSTOPluginDemo.LoadSettings();
Var lIni : TIniFile;
Begin
  lIni := TIniFile.Create(ChangeFileExt(PluginFileName, '.cfg'));
  Try
    Enabled           := lIni.ReadBool(Self.Name, 'Enabled', True);
    FAddMenuItem      := lIni.ReadBool(Self.Name, 'AddMenuItem', True);
    FAddToolBarButton := lIni.ReadBool(Self.Name, 'AddToolBarButton', True);

    Finally
      lIni.Free();
  End;
End;

Procedure TTSTOPluginDemo.SaveSettings();
Var lIni : TIniFile;
Begin
  lIni := TIniFile.Create(ChangeFileExt(PluginFileName, '.cfg'));
  Try
    lIni.WriteBool(Self.Name, 'Enabled', Enabled);
    lIni.WriteBool(Self.Name, 'AddMenuItem', FAddMenuItem);
    lIni.WriteBool(Self.Name, 'AddToolBarButton', FAddToolBarButton);

    Finally
      lIni.Free();
  End;
End;

end.
