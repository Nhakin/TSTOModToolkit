unit MainFrm;

interface

uses
  TSTOModToolKit,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Buttons, StdCtrls, ExtCtrls, Dialogs;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    EditServer: TEdit;
    SBDownload: TSpeedButton;
    Button1: TButton;
    Panel2: TPanel;
    Label2: TLabel;
    SBGenDLC: TSpeedButton;
    EditModSource: TEdit;
    Label3: TLabel;
    EditModOutput: TEdit;
    Panel3: TPanel;
    Label4: TLabel;
    SBPatchSBTP: TSpeedButton;
    Label5: TLabel;
    EditSBTPPatchFile: TEdit;
    EditSBTPFilesPath: TEdit;
    cmdCreateMod: TButton;
    cmdPackMod: TButton;
    cmdValidateXml: TButton;
    GroupBox1: TGroupBox;
    chkAllFree: TCheckBox;
    chkNonUnique: TCheckBox;
    chkBuildStore: TCheckBox;
    chkInstantBuild: TCheckBox;
    cmdFreeLandUpgrade: TButton;
    Button3: TButton;

    procedure SBDownloadClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SBGenDLCClick(Sender: TObject);
    procedure SBPatchSBTPClick(Sender: TObject);
    procedure cmdCreateModClick(Sender: TObject);
    procedure cmdPackModClick(Sender: TObject);
    procedure cmdValidateXmlClick(Sender: TObject);
    procedure cmdFreeLandUpgradeClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);

  private

  public

  end;

var
  Form1: TForm1;

implementation

Uses TSTOProject, TSTODlcIndex, abzipkit;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
Var lFile1 : TTSTOSbtpFile;
    lFile2 : TTSTOSbtpFile;
    X : Integer;
begin
  lFile1 := TTSTOSbtpFile.Create();
  lFile2 := TTSTOSbtpFile.Create();
  Try
    lFile1.LoadFromFile('C:\Projects\TSTO-Hacker\Bin\TSTODlcServer\4_17_HalloweenPromo_Patch2_PostLaunch_GYSXF46D5XBG\textpools-en-r260994-527U3DLE\Sources\1.src\scorpio_eng_en14.sbtp');
    lFile2.LoadFromFile('C:\TSTO Hack\Mamosa\gamescripts-r157705-A5A1CDDE\1\scorpio_eng_en14.sbtp');

    X := 0;
    While lFile2.Variables[X].VariableName <> '4thjuly_buildmenutitle' Do
      Inc(X);

    While X < lFile2.Variables.Count - 1 Do
    Begin
      lFile1.Variables.Add().Assign(lFile2.Variables[X]);
      Inc(X);
    End;

    lFile1.SaveToFile('C:\Projects\TSTO-Hacker\Bin\TSTODlcServer\4_17_HalloweenPromo_Patch2_PostLaunch_GYSXF46D5XBG\textpools-en-r260994-527U3DLE\Sources\1.src\scorpio_eng_en14.sbtp');
    ShowMessage('Done');
    
    Finally
      lFile1.Free();
      lFile2.Free();
  End;
Exit;
{
//    Procedure BuildZeroFile();
  With TTSTODlcGenerator.Create() Do
  Try
    BinPath := EditModOutput.Text;
    //'C:\TSTO Hack\Damar1st\gamescripts-r157705-A5A1CDDE\Temp';
    //'C:\TSTO Hack\Mamosa\gamescripts-r157705-A5A1CDDE\Temp';
    //EditModOutput.Text;
    BuildZeroFile();

    Finally
      Free();
  End;
ShowMessage('Done');
Exit;}
  With TTSTOSbtpPatchFile.Create() Do
  Try
    With Patchs.Add() Do
    Begin
      FileIndex := 0;
      CreatePatch(
        'C:\Projects\TSTO-Hacker\Bin\TSTODlcServer\4_17_HalloweenPromo_Patch2_PostLaunch_GYSXF46D5XBG\textpools-en-r260994-527U3DLE\Sources\1.src\scorpio_eng_en0.sbtp',
        'C:\TSTO Hack\Mamosa\gamescripts-r157705-A5A1CDDE\1\scorpio_eng_en0.sbtp'
      );
    End;

    With Patchs.Add() Do
    Begin
      FileIndex := 14;
      CreatePatch(
        'C:\Projects\TSTO-Hacker\Bin\TSTODlcServer\4_17_HalloweenPromo_Patch2_PostLaunch_GYSXF46D5XBG\textpools-en-r260994-527U3DLE\Sources\1.src\scorpio_eng_en14.sbtp',
        'C:\TSTO Hack\Mamosa\gamescripts-r157705-A5A1CDDE\1\scorpio_eng_en14.sbtp'
      );
    End;

    With Patchs.Add() Do
    Begin
      FileIndex := 15;
      CreatePatch(
        'C:\Projects\TSTO-Hacker\Bin\TSTODlcServer\4_17_HalloweenPromo_Patch2_PostLaunch_GYSXF46D5XBG\textpools-en-r260994-527U3DLE\Sources\1.src\scorpio_eng_en15.sbtp',
        'C:\TSTO Hack\Mamosa\gamescripts-r157705-A5A1CDDE\1\scorpio_eng_en15.sbtp'
      );
    End;

    SaveToFile('C:\Projects\TSTO-Hacker\Bin\TSTODlcServer\4_17_HalloweenPromo_Patch2_PostLaunch_GYSXF46D5XBG\SBTPPatchs.sptbx');
    ShowMessage('Done');

    Finally
      Free();
  End;
end;

procedure TForm1.cmdFreeLandUpgradeClick(Sender: TObject);
Var {lPath    : String;
    lSr      : TSearchRec;
    lConMast : ITSTOXmlConsumableMasterList;
    lCon     : ITSTOXmlConsumables;
    X        : Integer;}
    lPrj     : ITSTOXMLProject;
begin
  lPrj := TTSTOXmlTSTOProject.LoadTSTOProject(ChangeFileExt(ParamStr(0), '.xml'));
  Try
    TTSTODlcGenerator.FreeLandUpgrades(lPrj.Settings.SourcePath);
    ShowMessage('Done');

    Finally
      lPrj := Nil;
  End;
Exit;
(*
  lPath := 'C:\Projects\TSTO-Hacker\Bin\Hacks\KahnHack\gamescripts-r264544-O78MTP60\3.src\';
  lConMast := NewConsumableMasterList();
  lCon     := LoadConsumables(lPath + 'kahn_consumables.xml');
  Try
    With lConMast.Package.Add() Do
      For X := 0 To lCon.Consumable.Count - 1 Do
        With DataID.Add() Do
        Begin
          Id := lCon.Consumable[X].Id;
          Name := lCon.Consumable[X].Name;
          Status := 'release';
          OnDeprecated := 'retain';
        End;

    With TStringList.Create() Do
    Try
      Text := FormatXmlData(lConMast.XML);
      SaveToFile(lPath + 'kahn_consumablemasterlist.xml');

      Finally
        Free();
    End;
    ShowMessage('Done');

    Finally
      lConMast := Nil;
  End;
Exit;
  lPath := 'C:\Projects\TSTO-Hacker\Bin\Hacks\KahnHack\gamescripts-r264544-O78MTP60\3.src\';
  If FindFirst(lPath + '*.xml', faAnyFile, lSr) = 0 Then
  Try
    With TStringList.Create() Do
    Try
      Repeat
        LoadFromFile(lPath + lSr.Name);
        Text := FormatXMLData(Text);
        SaveToFile(lPath + lSr.Name);
      Until FindNext(lSr) <> 0;

      Finally
        Free();
    End;
    ShowMessage('Done');

    Finally
      FindClose(lSr);
  End;
*)
end;

procedure TForm1.Button3Click(Sender: TObject);
{Var lPath  : String;
    lDoc   : IXmlDocumentEx;
    lNodes : IXMLNodeListEx;
    X      : Integer;}
Var lDlc : ITSTOXmlDlcIndex;
    lPrj : ITSTOXmlProject;
    lZip : TAbZipKit;
begin
Exit;
  lPrj := TTSTOXmlTSTOProject.LoadTSTOProject(ChangeFileExt(ParamStr(0), '.xml'));
  ShowMessage(IntToStr(lPrj.ProjectFiles.Count));
//  lDlc := LoadDlcIndex('C:\Projects\TSTO-Hacker\Bin\TSTODlcServer\dlc\DLCIndex-v4_17_SPRINGFIELDHEIGHTS2-r269516-RW15PDGB.xml');
//  ShowMessage(IntToStr(lDlc.TutorialPackages.Count));
//  ShowMessage(lPrj.ProjectFiles.ProjectFile[0].SourcePaths.SourcePath[0]);
{//  lPath := 'C:\Projects\TSTO-Hacker\Bin\TSTOCustomPatches.xml';
  lPath := 'C:\Projects\TSTO-Hacker\Bin\Hacks\KahnHack\gamescripts-r266080-O8ZU34DI\1.src\Farms.xml';
  lDoc := TXMLDocumentEx.Create(lPath);
  Try
//    lNodes := lDoc.SelectNodes('//Patch[last()]', lDoc.DocumentElement);
    lNodes := lDoc.SelectNodes('//Farm[@name="SquidportFarm"]/Job/Cost', lDoc.DocumentElement);
    lPath := '';
    For X := 0 To lNodes.Count - 1 Do
      lPath := lPath + lNodes[X].Xml + #$D#$A;
    ShowMessage(lPath);
//    ShowMessage(IntToStr(lNodes.Count));
    Finally
      lDoc := Nil;
  End;}
end;

procedure TForm1.cmdCreateModClick(Sender: TObject);
Var lModOpts : TScriptOptions;
    lPrj     : ITSTOXMLProject;
begin
  If chkAllFree.Checked Then
    Include(lModOpts, soMakeFree);
  If chkNonUnique.Checked Then
    Include(lModOpts, soNonUnique);
  If chkBuildStore.Checked Then
    Include(lModOpts, soMakeCustomStore);
  If chkInstantBuild.Checked Then
    Include(lModOpts, soInstantBuild);

  lPrj := TTSTOXmlTSTOProject.LoadTSTOProject(ChangeFileExt(ParamStr(0), '.xml'));
  With TTSTODlcGenerator.Create() Do
  Try
    CreateMod(lPrj.Settings.SourcePath, lModOpts);
    ShowMessage('Done');

    Finally
      Free();
      lPrj := Nil;
  End;
end;

procedure TForm1.cmdPackModClick(Sender: TObject);
Var lPrj    : ITSTOXMLProject;
begin
  lPrj := TTSTOXmlTSTOProject.LoadTSTOProject( ChangeFileExt(ParamStr(0), '.xml') );
  With TTSTODlcGenerator.Create() Do
  Try
    CreateDLCEx(lPrj);
    ShowMessage('Done');
    
    Finally
      Free();
      lPrj := Nil;
  End;
end;

procedure TForm1.cmdValidateXmlClick(Sender: TObject);
Var lPath : String;
    lPrj  : ITSTOXMLProject;
begin
  lPrj := TTSTOXmlTSTOProject.LoadTSTOProject( ChangeFileExt(ParamStr(0), '.xml') );
  With TTSTODlcGenerator.Create() Do
  Try
    ValidateXmlFiles(lPrj);
    Finally
      Free();
      lPrj := Nil;
  End;
Exit;
  lPath := 'C:\Projects\TSTO-Hacker\Bin\Hacks\KahnHack\textpools-en-r262452-CFD3XBVM\1.src\';
  With TTSTOSbtpFile.Create() Do
  Try
    LoadFromFile(lPath + 'scorpio_eng_en15.sbtp');

    If Variables.IndexOf('con_kahndozendonuts_name') = -1 Then
      With Variables.Add() Do
      Begin
        VariableName := 'con_kahndozendonuts_name';
        DataAsString := 'Dozen Donuts';
      End;

    If Variables.IndexOf('con_kahndozendonuts_desc') = -1 Then
      With Variables.Add() Do
      Begin
        VariableName := 'con_kahndozendonuts_desc';
        DataAsString := '12 Donuts';
      End;

    If Variables.IndexOf('con_kahn60donuts_name') = -1 Then
      With Variables.Add() Do
      Begin
        VariableName := 'con_kahn60donuts_name';
        DataAsString := 'Stack of 60 Donuts';
      End;

    If Variables.IndexOf('con_kahn60donuts_desc') = -1 Then
      With Variables.Add() Do
      Begin
        VariableName := 'con_kahn60donuts_desc';
        DataAsString := '60 Donuts';
      End;

    If Variables.IndexOf('con_kahn132donuts_name') = -1 Then
      With Variables.Add() Do
      Begin
        VariableName := 'con_kahn132donuts_name';
        DataAsString := 'Tray of 132 Donuts';
      End;

    If Variables.IndexOf('con_kahn132donuts_desc') = -1 Then
      With Variables.Add() Do
      Begin
        VariableName := 'con_kahn132donuts_desc';
        DataAsString := '132 Donuts';
      End;

    If Variables.IndexOf('con_kahn300donuts_name') = -1 Then
      With Variables.Add() Do
      Begin
        VariableName := 'con_kahn300donuts_name';
        DataAsString := 'Truckload of 300 Donuts';
      End;

    If Variables.IndexOf('con_kahn300donuts_desc') = -1 Then
      With Variables.Add() Do
      Begin
        VariableName := 'con_kahn300donuts_desc';
        DataAsString := '300 Donuts';
      End;

    If Variables.IndexOf('con_kahn900donuts_name') = -1 Then
      With Variables.Add() Do
      Begin
        VariableName := 'con_kahn900donuts_name';
        DataAsString := 'Store Full of 900 Donuts';
      End;

    If Variables.IndexOf('con_kahn900donuts_desc') = -1 Then
      With Variables.Add() Do
      Begin
        VariableName := 'con_kahn900donuts_desc';
        DataAsString := '900 Donuts';
      End;

    If Variables.IndexOf('con_kahn2400donuts_name') = -1 Then
      With Variables.Add() Do
      Begin
        VariableName := 'con_kahn2400donuts_name';
        DataAsString := 'Boatload of 2400 Donuts';
      End;

    If Variables.IndexOf('con_kahn2400donuts_desc') = -1 Then
      With Variables.Add() Do
      Begin
        VariableName := 'con_kahn2400donuts_desc';
        DataAsString := '2400 Donuts';
      End;

    SaveToFile(lPath + 'scorpio_eng_en15.sbtp');
ShowMessage('Done');
    Finally
      Free();
  End;
end;

procedure TForm1.SBDownloadClick(Sender: TObject);
begin
  TTSTODlcGenerator.DownloadGameScript(EditServer.Text, ExtractFilePath(ParamStr(0)) + 'TSTODlcServer', True);
  ShowMessage('Done');
end;

procedure TForm1.SBGenDLCClick(Sender: TObject);
begin
  With TTSTODlcGenerator.Create() Do
  Try
    SourcePath := EditModSource.Text;
    BinPath    := EditModOutput.Text;
    CreateDLC();
    ShowMessage('Done');

    Finally
      Free();
  End;
end;

procedure TForm1.SBPatchSBTPClick(Sender: TObject);
begin
  With TTSTOSbtpPatchFile.Create() Do
  Try
    PatchSbtpFiles(
      EditSBTPPatchFile.Text,
      EditSBTPFilesPath.Text
    );
    ShowMessage('Done');
    
    Finally
      Free();
  End;
end;

end.
