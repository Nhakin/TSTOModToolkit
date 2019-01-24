unit DlcDownloadFrm;

interface

uses
  dmImage, TSTOPackageList, TSTOProject.Xml,
  TSTOBCell, TSTOCustomPatches.Xml, TSTOSbtpIntf, TSTOSbtp.IO,
  Controls, Classes, Windows, Messages, SysUtils, Variants, Graphics, Menus,
  ComCtrls, ToolWin, StdCtrls, ExtCtrls, Forms, Dialogs,
  SynEditHighlighter, SynHighlighterXML, SynEdit, KControls, KHexEditor,
  VirtualTrees, VTEditors, TSTOTreeViews, xmldom, XMLIntf, msxmldom, XMLDoc;

type
  TDlcDownload = class(TForm)
    Splitter1: TSplitter;
    PanInfo: TPanel;
    PanToolBar: TPanel;
    tbMain: TToolBar;
    tbDownload: TToolButton;
    tbSynch: TToolButton;
    MainMenu1: TMainMenu;
    mnuFile: TMenuItem;
    mnuSettings: TMenuItem;
    N1: TMenuItem;
    mnuExit: TMenuItem;
    GroupBox1: TGroupBox;
    EditVersion: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    EditTier: TEdit;
    EditMinVersion: TEdit;
    Label3: TLabel;
    EditPlatform: TEdit;
    Label4: TLabel;
    EditFileName: TEdit;
    Label5: TLabel;
    EditLanguage: TEdit;
    Label6: TLabel;
    tbCreateMod: TToolButton;
    tbUnpackMod: TToolButton;
    tbPackMod: TToolButton;
    tbExtractRgb: TToolButton;
    PanXml: TPanel;
    EditXML: TSynEdit;
    SynXMLSyn1: TSynXMLSyn;
    PanFilter: TPanel;
    PanTreeView: TPanel;
    PanHexEdit: TPanel;
    KHexEditor: TKHexEditor;
    PanImage: TPanel;
    ScrlImage: TScrollBox;
    ImgResource: TImage;
    PanSize: TPanel;
    Label7: TLabel;
    EditImageSize: TEdit;
    tbValidateXml: TToolButton;
    ToolButton1: TToolButton;
    PanSbtp: TPanel;
    PansbtpTreeView: TPanel;
    mnuSbtpCustomPatch: TMenuItem;
    PanModOptions: TPanel;
    Splitter3: TSplitter;
    PanModLeft: TPanel;
    GroupBox2: TGroupBox;
    chkAllFree: TCheckBox;
    chkNonUnique: TCheckBox;
    chkBuildStore: TCheckBox;
    chkInstantBuild: TCheckBox;
    chkFreeLandUpgade: TCheckBox;
    chkUnlimitedTime: TCheckBox;
    PanModRight: TPanel;
    vstCustomPatchesOld: TVirtualStringTree;
    mnuCustomPatch: TMenuItem;
    ToolButton2: TToolButton;
    popTV: TPopupMenu;
    ExportasXML1: TMenuItem;
    Animate1: TAnimate;
    ExpandAll1: TMenuItem;
    N2: TMenuItem;
    CollapseAll1: TMenuItem;
    Label8: TLabel;
    EditFileSize: TEdit;
    tbCreateMasterList: TToolButton;
    tbBuildList: TToolButton;
    OpenDialog1: TOpenDialog;
    mnuTools: TMenuItem;
    mnuDownloadAllIndexes: TMenuItem;
    mnuIndexes: TMenuItem;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure tbSynchClick(Sender: TObject);
    procedure tbDownloadClick(Sender: TObject);
    procedure tbUnpackModClick(Sender: TObject);
    procedure tbPackModClick(Sender: TObject);
    procedure tbCreateModClick(Sender: TObject);
    procedure tbExtractRgbClick(Sender: TObject);
    procedure tbValidateXmlClick(Sender: TObject);

    procedure mnuExitClick(Sender: TObject);
    procedure mnuSettingsClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure mnuSbtpCustomPatchClick(Sender: TObject);
    procedure mnuCustomPatchClick(Sender: TObject);
    procedure tbMainMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ToolButton2Click(Sender: TObject);
    procedure popTVPopup(Sender: TObject);
    procedure ExportasXML1Click(Sender: TObject);
    procedure ExpandAll1Click(Sender: TObject);
    procedure CollapseAll1Click(Sender: TObject);
    procedure tbCreateMasterListClick(Sender: TObject);
    procedure tbBuildListClick(Sender: TObject);
    procedure mnuDownloadAllIndexesClick(Sender: TObject);

  private
    FEditFilter : THsVTButtonEdit;

    FTvDlcServer     : TTSTODlcServerTreeView;
    FTvSbtpFile      : TTSTOSbtpFileTreeView;
    FTvCustomPatches : TTSTOCustomPatchesTreeView;

    FPrj        : ITSTOXMLProject;
    FBCell      : ITSTOBCellAnimation;
    FPrevNode   : PVirtualNode;

    Procedure DoEditFilterButtonClick(Sender : TObject);
    Procedure DoMnuIndexesClick(Sender : TObject);
    Procedure DoTvDlcServerOnFocusChanged(Sender : TBaseVirtualTree;
      Node : PVirtualNode; Column : TColumnIndex);

    Procedure SetNodeData(ANode : PVirtualNode; ANodeData : IInterface);
    Function  GetNodeData(ANode : PVirtualNode; AId : TGUID; Var ANodeData) : Boolean; OverLoad;
    Function  GetNodeData(ANode : PVirtualNode; AId : TGUID) : Boolean; OverLoad;

    Procedure GetPackageList(Sender : TBaseVirtualTree; Node : PVirtualNode; Data : Pointer; Var Abort : Boolean);
    Procedure DoFilterNode(Sender : TBaseVirtualTree; Node : PVirtualNode; Data : Pointer; Var Abort : Boolean);
    Procedure DoExpandNode(Sender : TBaseVirtualTree; Node : PVirtualNode; Data : Pointer; Var Abort : Boolean);

    Procedure GetRgbNodeList(Sender : TBaseVirtualTree; Node : PVirtualNode; Data : Pointer; Var Abort : Boolean);
    Procedure ExtractRgbFiles(APackageList : ITSTOPackageNodes);

    Procedure LoadDlcIndexes();

  end;

Var
  DlcDownload : TDlcDownload;

implementation

Uses
  Math, uSelectDirectoryEx, Imaging, ImagingClasses, ImagingTypes, ImagingComponents,
  SettingsFrm, SptbFrm, CustomPatchFrm, TSTOSbtpEx.JSon, TSTOSbtp.Xml,
  RgbExtractProgress, PngImage, AviWriter_2,
  TSTODlcIndex, TSTOBCell.IO, TSTOFunctions,
  TSTODownloader, TSTOModToolKit, TSTOZero.Bin, TSTORgb, TSTOBsv.IO,
  TSTOHackMasterList.IO,
  HsInterfaceEx, HsZipUtils, HsXmlDocEx, HsStreamEx, HsJSonEx, HsStringListEx;

{$R *.dfm}

Type
  PInterface = ^IInterface;

procedure TDlcDownload.mnuExitClick(Sender: TObject);
begin
  Close();
end;

procedure TDlcDownload.mnuCustomPatchClick(Sender: TObject);
Var lPkg  : ITSTOPackageNode;
    lPath : String;
begin
Raise Exception.Create('Not working anymore in V1 Use V2');
  If GetNodeData(FTvDlcServer.GetFirstSelected(), ITSTOPackageNode, lPkg) Then
  Begin
    lPath := IncludeTrailingBackSlash(FPrj.Settings.HackPath + ChangeFileExt(lPkg.FileName, ''));
    FPrj.Settings.SourcePath := lPath + '0\';
    FPrj.Settings.TargetPath := lPath + '1.src\';
  End;

  With TFrmCustomPatches.Create(Self) Do
  Try
    ProjectFile := FPrj;

    If ShowModal() = mrOk Then
    Begin
      FPrj := TTSTOXmlTSTOProject.GetTSTOProject(ProjectFile.OwnerDocument);

      vstCustomPacthes.BeginUpdate();
      Try
        vstCustomPacthes.Clear();
//        vstCustomPacthes.RootNodeCount := FPrj.CustomPatches.Patches.Count;

        Finally
          vstCustomPacthes.EndUpdate();
      End;
    End;

    Finally
      Release();
  End;
end;

procedure TDlcDownload.mnuDownloadAllIndexesClick(Sender: TObject);
begin
  With TTSTODlcGenerator.Create() Do
  Try
    DownloadAllDLCIndex(FPrj);
    LoadDlcIndexes();
    
    Finally
      Free();
  End;
end;

procedure TDlcDownload.mnuSbtpCustomPatchClick(Sender: TObject);
begin
Raise Exception.Create('Not working anymore in V1 Use V2');
  With TFrmSbtp.Create(Self) Do
  Try
    //ProjectFile := FPrj;

    ShowModal();
    
    Finally
      Release();
  End;
end;

procedure TDlcDownload.mnuSettingsClick(Sender: TObject);
begin
  With TFrmSettings.Create(Self) Do
  Try
    ProjectFile := FPrj;
    ShowModal();

    Finally
      Release();
  End;
end;

procedure TDlcDownload.popTVPopup(Sender: TObject);
Var lNode : PVirtualNode;
    lArch : IBinArchivedFileData;
    lPkg  : ITSTOPackageNode;
begin
Exit;
  lNode := FTvDlcServer.GetFirstSelected();

  If Not (
          (
            GetNodeData(lNode, IBinArchivedFileData, lArch) And
            (
              SameText(lArch.FileExtension, 'sbtp') Or
              SameText(lArch.FileExtension, 'bsv3')
            )
          ) Or (
            GetNodeData(lNode, ITSTOPackageNode, lPkg) And
            lPkg.FileExist And
            (Pos('TEXTPOOL', UpperCase(lPkg.FileName)) > 0)
          )
         ) Then
    Abort;
end;

procedure TDlcDownload.FormCreate(Sender: TObject);
begin
  FEditFilter := THsVTButtonEdit.Create(Self);
  FEditFilter.Parent := PanFilter;
  FEditFilter.ButtonWidth := 25;
  FEditFilter.OnButtonClick := DoEditFilterButtonClick;
  FEditFilter.Align := alClient;

  DataModuleImage.imgToolBar.GetBitmap(94, FEditFilter.ButtonGlyph);

  If FileExists(ChangeFileExt(ParamStr(0), '.xml')) Then
    FPrj := TTSTOXmlTSTOProject.LoadTSTOProject(ChangeFileExt(ParamStr(0), '.xml'))
  Else
  Begin
    FPrj := TTSTOXmlTSTOProject.NewTSTOProject();
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

  FTvSbtpFile := TTSTOSbtpFileTreeView.Create(Self);
  FTvSbtpFile.Parent := PanSbtp;
  FTvSbtpFile.Align  := alClient;

  FTvCustomPatches := TTSTOCustomPatchesTreeView.Create(Self);
  FTvCustomPatches.Parent := PanModRight;
  FTvCustomPatches.Align  := alClient;
//  FTvCustomPatches.TvData := FPrj.CustomPatches.Patches;
end;

procedure TDlcDownload.FormDestroy(Sender: TObject);
Var lStrStream : IStringStreamEx;
begin
  With FPrj.Settings Do
  Begin
    BuildCustomStore := chkBuildStore.Checked;
    InstantBuild     := chkInstantBuild.Checked;
    AllFreeItems     := chkAllFree.Checked;
    NonUnique        := chkNonUnique.Checked;
    FreeLand         := chkFreeLandUpgade.Checked;
    UnlimitedTime    := chkUnlimitedTime.Checked;
  End;
{
  If (FPrj.CustomPatches.Patches.Count > 0) And
     (FPrj.Settings.CustomPatchFileName <> '') Then
  Begin
    lStrStream := TStringStreamEx.Create(FormatXMLData(FPrj.CustomPatches.Xml));
    Try
      lStrStream.SaveToFile(FPrj.Settings.CustomPatchFileName);

      Finally
       lStrStream := Nil;
    End;
  End;
}
  lStrStream := TStringStreamEx.Create(FormatXMLData(FPrj.XML));
  Try
    lStrStream.SaveToFile(ChangeFileExt(ParamStr(0), '.xml'));

    Finally
      lStrStream := Nil;
  End;

  FPrj        := Nil;
  FBCell      := Nil;
end;

Procedure TDlcDownload.DoMnuIndexesClick(Sender : TObject);
Var X : Integer;
Begin
  For X := 0 To mnuIndexes.Count - 1 Do
    mnuIndexes[X].Checked := mnuIndexes[X] = Sender;

  FTvDlcServer.LoadData( FPrj.Settings.DLCPath + 'dlc\' +
                         StripHotkey(TMenuItem(Sender).Caption) + '.zip');
End;

Procedure TDlcDownload.LoadDlcIndexes();
Var lMnu : TMenuItem;
    X : Integer;
Begin
  For X := mnuIndexes.Count - 1 DownTo 0 Do
  Begin
    lMnu := mnuIndexes.Items[X];
    mnuIndexes.Remove(lMnu);
    lMnu.Free();
  End;

  With TTSTODlcGenerator.Create() Do
  Try
    With GetIndexFileNames(FPrj) Do
      For X := 0 To Count - 1 Do
        If FileExists(FPrj.Settings.DLCPath + Strings[X]) Then
        Begin
          lMnu := TMenuItem.Create(mnuIndexes);
          lMnu.Caption := ChangeFileExt(ExtractFileName(Strings[X]), '');
          lMnu.OnClick := DoMnuIndexesClick;
          mnuIndexes.Add(lMnu);

          If X = 0 Then
          Begin
            lMnu := TMenuItem.Create(mnuIndexes);
            lMnu.Caption := '-';
            mnuIndexes.Add(lMnu);
          End;
        End;

    Finally
      Free();
  End;
End;

Procedure TDlcDownload.DoEditFilterButtonClick(Sender : TObject);
Var lSearch : String;
Begin
  lSearch := FEditFilter.Text;
  FTvDlcServer.IterateSubtree(Nil, DoFilterNode, @lSearch)
End;

Procedure TDlcDownload.SetNodeData(ANode : PVirtualNode; ANodeData : IInterface);
Var lNodeData : PPointer;
Begin
  lNodeData  := TreeFromNode(ANode).GetNodeData(ANode);
  lNodeData^ := Pointer(ANodeData);
End;

Function TDlcDownload.GetNodeData(ANode : PVirtualNode; AId : TGUID; Var ANodeData) : Boolean;
Var lNodeData : PPointer;
Begin
  If Assigned(ANode) Then
  Begin
    lNodeData := TreeFromNode(ANode).GetNodeData(ANode);
    Result := Assigned(lNodeData^) And Supports(IInterface(lNodeData^), AId, ANodeData);
  End
  Else
    Result := False;
End;

Function TDlcDownload.GetNodeData(ANode : PVirtualNode; AId : TGUID) : Boolean;
Var lDummy : IInterface;
Begin
  Result := GetNodeData(ANode, AId, lDummy);
End;

procedure TDlcDownload.DoTvDlcServerOnFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
Var lPkg     : ITSTOPackageNode;
    lArchive : IBinZeroFileData;
    lFile    : IBinArchivedFileData;

    lPath : String;
    lZip  : IHsMemoryZipper;
    lMem  : IMemoryStreamEx;
    lImg  : ITSTORgbFile;
    lXml  : IXmlDocumentEx;
    lXmlStr : String;
begin
  tbPackMod.Enabled     := False;
  tbUnpackMod.Enabled   := False;
  tbCreateMod.Enabled   := False;
  tbValidateXml.Enabled := False;

  ImgResource.Picture := Nil;
  EditImageSize.Text  := '';

  PanHexEdit.Visible  := False;
  PanXml.Visible      := False;
  PanInfo.Visible     := True;
  PanImage.Visible    := False;
  PanSbtp.Visible     := False;

  FBCell := Nil;

  If GetNodeData(Node, ITSTOPackageNode, lPkg) Then
  Begin
    EditFileName.Text   := lPkg.FileName;
    EditPlatform.Text   := lPkg.PkgPlatform;
    EditTier.Text       := lPkg.Tier;
    EditMinVersion.Text := lPkg.MinVersion;
    EditVersion.Text    := lPkg.Version;
    EditLanguage.Text   := lPkg.Language;
    EditFileSize.Text   := IntToStr(lPkg.FileSize);
    
    lPath := IncludeTrailingBackslash(FPrj.Settings.HackPath + ChangeFileExt(lPkg.FileName, ''));

    tbUnpackMod.Enabled   := lPkg.FileExist;
    tbPackMod.Enabled     := DirectoryExists(lPath);
    tbValidateXml.Enabled := DirectoryExists(lPath);
    If Pos(UpperCase('GAMESCRIPT'), UpperCase(lPkg.FileName)) > 0 Then
      tbCreateMod.Enabled := DirectoryExists(lPath + '0') And
                             DirectoryExists(lPath + '1.src')
    Else If Pos(UpperCase('TEXTPOOLS'), UpperCase(lPkg.FileName)) > 0 Then
    Begin
      If FileExists(FPrj.Settings.HackFileName) Then
      Begin
        lZip := THsMemoryZipper.Create();
        lMem := TMemoryStreamEx.Create();
        Try
          lZip.LoadFromFile(FPrj.Settings.HackFileName);
          lZip.ExtractToStream('TextPools', lMem);
          tbCreateMod.Enabled := DirectoryExists(lPath + '0') And
                                 DirectoryExists(lPath + '1.src') And
                                 (lMem.Size > 0);
          Finally
            lMem := Nil;
            lZip := Nil;
        End;
      End;
    End;
  End
  Else If GetNodeData(Node, IBinArchivedFileData, lFile) And
          GetNodeData(Node.Parent, IBinZeroFileData, lArchive) And
          GetNodeData(Node.Parent.Parent, ITSTOPackageNode, lPkg) Then
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
          lImg := TTSTORgbFile.CreateRGBFile();
          Try
            Try
              lImg.LoadRgbFromStream(lMem);
              ImgResource.Picture.Assign(lImg.Picture);
              EditImageSize.Text := IntToStr(ImgResource.Picture.Width) + ' x ' + IntToStr(ImgResource.Picture.Height);
              PanImage.Visible := True;

              Except
                On E:Exception Do
                Begin
                  lMem.Position := 0;
                  KHexEditor.LoadFromStream(TStream(lMem.InterfaceObject));

                  PanHexEdit.Visible := True;
                  PanHexEdit.BringToFront();
                End;
            End;

            Finally
              lImg := Nil;
          End;
        End
        Else If SameText(lFile.FileExtension, 'xml') Then
        Begin
          lXmlStr := (lMem As IStringStreamEx).DataString;
          If Copy(lXmlStr, 1, 3) = #$EF#$BB#$BF Then
            lXmlStr := Copy(lXmlStr, 4, Length(lXmlStr));
          lXml := LoadXMLData(lXmlStr);
          EditXml.Lines.Text := FormatXmlData(lXml.Xml.Text);

          PanXml.Visible  := True;
          PanInfo.Visible := False;
        End
        Else If SameText(lFile.FileExtension, 'txt') Then
        Begin
          EditXml.Lines.Text := (lMem As IStringStreamEx).DataString;
          PanXml.Visible  := True;
          PanInfo.Visible := False;
        End
        Else If SameText(lFile.FileExtension, 'sbtp') Then
        Begin
          lMem.Position := 0;
          FTvSbtpFile.TvData := TSbtpFileIO.LoadBinSbtpFile(lMem);

          PanSbtp.Visible := True;
          PanInfo.Visible := False;
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

        PanImage.Visible := True;

        Finally
          lMem := Nil;
          lZip := Nil;
      End;
    End;
  End
  Else If GetNodeData(Node, ITSTORgbFile, lImg) Then
  Begin
    ImgResource.Picture.Assign(lImg.Picture);
    lImg.ReleaseGraphic();
    PanImage.Visible := True;
  End;
end;

Type
  PPackageList = ^ITSTOPackageNodes;

Procedure TDlcDownload.GetPackageList(Sender : TBaseVirtualTree; Node : PVirtualNode; Data : Pointer; Var Abort : Boolean);
Var lPkg : ITSTOPackageNode;
Begin
  If (Node.CheckState = csCheckedNormal) And
     Sender.IsVisible[Node] And
     GetNodeData(Node, ITSTOPackageNode, lPkg) Then
    PPackageList(Data).Add(lPkg);
End;

Procedure TDlcDownload.DoFilterNode(Sender : TBaseVirtualTree; Node : PVirtualNode; Data : Pointer; Var Abort : Boolean);
Begin
  Sender.IsVisible[Node] := (Pos(UpperCase(PString(Data)^), UpperCase(TVirtualStringTree(Sender).Text[Node, 0])) > 0) Or (PString(Data)^ = '');
  If Sender.IsVisible[Node] And Not Sender.IsVisible[Node.Parent] Then
    Repeat
      Sender.IsVisible[Node] := True;
      Node := Node.Parent;
    Until Node = Sender.RootNode;
End;

procedure TDlcDownload.tbBuildListClick(Sender: TObject);
Var lDateStr : String;
begin
  With TOpenDialog.Create(Self) Do
  Try
    Filter := 'Xml File|*.xml';

    If Execute() Then
    Begin
      lDateStr := FormatDateTime('yyyymmdd', Now());

      With TTSTOItemLister.CreateLister() Do
      Begin
        ListNonFreeItems(FileName, ExtractFilePath(FileName) + 'LstNonFree - ' + lDateStr + '.xml');
        ListUniqueItems(FileName, ExtractFilePath(FileName) + 'LstNonUnique - ' + lDateStr + '.xml');
        ListRequirementItems(FileName, ExtractFilePath(FileName) + 'LstReqs - ' + lDateStr + '.xml');
        ListNonSellableItems(FileName, ExtractFilePath(FileName) + 'LstNonSellable - ' + lDateStr + '.xml');
        ListStoreRequirement(FileName, ExtractFilePath(FileName) + 'StoreReqs - ' + lDateStr + '.xml');

        ShowMessage('Done');
      End;
    End;

    Finally
      Free();
  End;
end;

procedure TDlcDownload.tbCreateMasterListClick(Sender: TObject);
Var lSelDir : AnsiString;
    lHackML : ITSTOHackMasterListIO;
    lPrj    : ITSTOXMLProject;
    lDateStr  : String;
begin
  If SelectDirectoryEx('Source Directory', FPrj.Settings.HackPath,
    lSelDir,True, False, False) Then
  Begin
    lDateStr := FormatDateTime('yyyymmdd', Now());
    
    lHackML := TTSTOHackMasterListIO.CreateHackMasterList();
    lPrj := TTSTOXmlTSTOProject.NewTSTOProject();
    Try
      lPrj.Settings.SourcePath := lSelDir;
      With lPrj.Settings.MasterFiles.Add() Do
      Begin
        FileName := 'BuildingMasterList.xml';
        NodeName := 'Building';
        NodeKind := 'building';
      End;

      With lPrj.Settings.MasterFiles.Add() Do
      Begin
        FileName := 'CharacterMasterList.xml';
        NodeName := 'Character';
        NodeKind := 'character';
      End;

      With lPrj.Settings.MasterFiles.Add() Do
      Begin
        FileName := 'CharacterSkinMasterList.xml';
        NodeName := 'Consumable';
        NodeKind := 'consumable';
      End;

      With lPrj.Settings.MasterFiles.Add() Do
      Begin
        FileName := 'ConsumableMasterList.xml';
        NodeName := 'Consumable';
        NodeKind := 'consumable';
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

procedure TDlcDownload.tbCreateModClick(Sender: TObject);
Var //lModOpts : TScriptOptions;
    lPkg     : ITSTOPackageNode;
    lPath    : String;
begin
  If GetNodeData(FTvDlcServer.GetFirstSelected(), ITSTOPackageNode, lPkg) Then
  Try
    lPath := IncludeTrailingBackSlash(FPrj.Settings.HackPath + ChangeFileExt(lPkg.FileName, ''));
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

      With TTSTODlcGenerator.Create() Do
      Try
  //      CreateMod(lPath + '0\', lPath + '1.src\', lModOpts);
Raise Exception.Create('Not working anymore in V1 Use V2');
//        CreateMod(FPrj);
        MessageDlg('Done', mtCustom, [mbOk], 0);

        Finally
          Free();
      End;
    End
    Else If Pos('TEXTPOOL', UpperCase(lPkg.FileName)) > 0 Then
    Begin
      With TTSTODlcGenerator.Create() Do
      Try
Raise Exception.Create('Not working anymore in V1 Use V2');
//        CreateSbtpMod(FPrj);
        MessageDlg('Done', mtCustom, [mbOk], 0);

        Finally
          Free();
      End;
    End;

    Finally
      lPkg := Nil;
  End;
end;

procedure TDlcDownload.tbDownloadClick(Sender: TObject);
Var lPkgList : ITSTOPackageNodes;
    lDown    : ITSTODownloader;
    X        : Integer;
    lFound   : Boolean;
begin
  lPkgList := TTSTOPackageNodes.Create();
  Try
    FTvDlcServer.IterateSubtree(Nil, GetPackageList, @lPkgList);//, [], True);

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

      lFound := False;
      For X := 0 To mnuIndexes.Count - 1 Do
        If mnuIndexes[X].Checked Then
        Begin
          FTvDlcServer.LoadData( FPrj.Settings.DLCPath + 'dlc\' +
                                 StripHotkey(mnuIndexes[X].Caption) + '.zip');

          lFound := True;
          Break;
        End;

      If Not lFound Then
        FTvDlcServer.LoadData();
    End
    Else
      MessageDlg('No file selected', mtError, [mbOK], 0);

    Finally
      lPkgList := Nil;
  End;
end;

procedure TDlcDownload.tbPackModClick(Sender: TObject);
Var lPrj : ITSTOXMLProject;
    lPkg : ITSTOPackageNode;
    lSr  : TSearchRec;
    lPath : String;
    lMem : IMemoryStreamEx;
begin
  If GetNodeData(FTvDlcServer.GetFirstSelected(), ITSTOPackageNode, lPkg) Then
  Try
    lPrj := TTSTOXmlTSTOProject.GetTSTOProject(LoadXMLData(FPrj.Xml));
    lPrj.ProjectFiles.Clear();
    Try
      lPath := IncludeTrailingBackSlash(FPrj.Settings.HackPath + ChangeFileExt(lPkg.FileName, ''));
      If FindFirst(lPath + '*.src', faDirectory, lSr) = 0 Then
      Try
        With lPrj.ProjectFiles.Add() Do
        Begin
          Repeat
            SourcePaths.Add(IncludeTrailingBackSlash(lPath + lSr.Name));
          Until FindNext(lSr) <> 0;

          OutputPath := IncludeTrailingBackSlash(lPrj.Settings.DLCPath + ExtractFilePath(lPkg.FileName));
          OutputFileName := ExtractFileName(lPkg.FileName);
        End;

        Finally
          FindClose(lSr);
      End;
//With TStringList.Create() Do
//Try
//  Text := FormatXmlData(lPrj.Xml);
//  SaveToFile('00-Test.xml');
//Finally
//  Free();
//End;
//ShowMessage('Done');
//Exit;
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

procedure TDlcDownload.tbSynchClick(Sender: TObject);
begin
  With TTSTODlcGenerator.Create() Do
  Try
    DownloadDLCIndex(FPrj);

    Finally
      Free();
  End;

  FTvDlcServer.LoadData();
end;

procedure TDlcDownload.tbUnpackModClick(Sender: TObject);
Var lZip : IHsMemoryZipper;
    lPkg : ITSTOPackageNode;
    lMem : IMemoryStreamEx;
    lMem2 : IMemoryStreamEx;
    lPath : String;
    lFileType : WideString;
begin
  If GetNodeData(FTvDlcServer.GetFirstSelected(), ITSTOPackageNode, lPkg) Then
  Begin
    lZip := THsMemoryZipper.Create();
    lMem := TMemoryStreamEx.Create();
    Try
      lPath := FPrj.Settings.HackPath + ChangeFileExt(lPkg.FileName, '');
      If Not DirectoryExists(lPath) Then
        ForceDirectories(lPath);

      lZip.LoadFromFile(FPrj.Settings.DLCPath + lPkg.FileName);
      lZip.ExtractToStream('1', lMem);
      If lMem.Size > 0 Then
      Begin
        lZip.LoadFromStream(lMem);
        lZip.ExtractFiles('*.*', lPath + '\0');
        lZip.ExtractFiles('*.*', lPath + '\1.src');

        If FileExists(FPrj.Settings.HackFileName) Then
        Begin
          lFileType := 'gamescripts';
          If (Pos(lFileType, lPkg.FileName) > 0) Then
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
      lZip.LoadFromFile(FPrj.Settings.DLCPath + lPkg.FileName);
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
        lPkg := Nil;
    End;
  End;
end;

procedure TDlcDownload.tbValidateXmlClick(Sender: TObject);
Var lPrj  : ITSTOXMLProject;
    lSr   : TSearchRec;
    lPath : String;
    lPkg  : ITSTOPackageNode;
begin
  If GetNodeData(FTvDlcServer.GetFirstSelected(), ITSTOPackageNode, lPkg) Then
  Begin
    lPrj  := TTSTOXmlTSTOProject.NewTSTOProject();
    lPath := IncludeTrailingBackslash(FPrj.Settings.HackPath + ChangeFileExt(lPkg.FileName, ''));
    Try
      If FindFirst(lPath + '*.src', faDirectory, lSr) = 0 Then
      Try
        With lPrj.ProjectFiles.Add() Do
        Repeat
          SourcePaths.Add(IncludeTrailingBackslash(lPath + lSr.Name));
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

Procedure FormatXmlFiles(Const APath : String);
Var lSr : TSearchRec;
Begin
  If FindFirst(APath + '*.xml', faAnyFile, lSr) = 0 Then
  Try
    Repeat
      With TStringList.Create() Do
      Try
        LoadFromFile(APath + lSr.Name);

        Try
          If Copy(Text, 1, 3) = 'ï»¿?' Then
            Text := Copy(Text, 4, Length(Text));

          Text := FormatXmlData(Text);
          SaveToFile(APath + lSr.Name);

          Except
            On e:Exception Do
              ShowMessage(lSr.Name + ' - ' + e.Message);
        End;

        Finally
          Free();
      End;
    Until FindNext(lSr) <> 0;

    Finally
      FindClose(lSr);
  End;
End;

procedure TDlcDownload.ToolButton1Click(Sender: TObject);
(*
Var lNode : PVirtualNode;
    lFile : IBinArchivedFileData;
    lArchive : IBinZeroFileData;
    lPkg : ITSTOPackageNode;
    lZip : IHsMemoryZipper;
    lMem : IMemoryStreamEx;
    lSbtp : ISbtpFileIO;
    lJSon : IJSonSbtpFile;
    lStr : String;
    lXml : IXmlDocumentEx;

    lPath : String;
    lBsv : IBsvFileIO;
    X : Integer;
    lRgb : ITSTORgbFile;
    lRgb2 : ITSTORgbFile;
    lStrs : IHsStringListEx;

    lRadiants : Extended;
    cRad : Extended;
    sRad : Extended;
    XForm : TXForm;
    lCanvas : TCanvas;

    lBCell : ITSTOBCellFileIO;
    lAvi : TAviWriter_2;
    lBmp : TBitmap;
    lRgbs : ITSTORgbFiles;
    lW, lH : Integer;
    lFmt : TFormatSettings;
    lSr : TSearchRec;

    lImg : TImageData;
    lHackMaster : ITSTOHackMasterListIO;

    lLst : TStringList;
    lNodes : IXmlNodeListEx;
    lFarmName : String;
    lJobName  : String;

    lRgbColor : Word;
*)
Const
  RgbMap : Array[0..$F] Of Byte = ( //-> Round(X / $F * $FF)
    $00, $11, $22, $33,
    $44, $55, $66, $77,
    $88, $99, $AA, $BB,
    $CC, $DD, $EE, $FF
  );
  RgbMult : Array[0..$F] Of Double = ( //-> $FF / RgbMap[X]
    0, 15, 7.5, 5,
    3.75, 3, 2.5, 2.14285714285714,
    1.875, 1.66666666666667, 1.5, 1.36363636363636,
    1.25, 1.15384615384615, 1.07142857142857, 1
  );
  RgbPreMult : Array[0..$F, 0..$F] Of Byte = ( //Color, Alpha -> ClampToByte(Round(RgbMap[X] * RgbMult[X]))
    ($00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00),
    ($00, $FF, $80, $55, $40, $33, $2A, $24, $20, $1C, $1A, $17, $15, $14, $12, $11),
    ($00, $FF, $FF, $AA, $80, $66, $55, $49, $40, $39, $33, $2E, $2A, $27, $24, $22),
    ($00, $FF, $FF, $FF, $BF, $99, $80, $6D, $60, $55, $4C, $46, $40, $3B, $37, $33),
    ($00, $FF, $FF, $FF, $FF, $CC, $AA, $92, $80, $71, $66, $5D, $55, $4E, $49, $44),
    ($00, $FF, $FF, $FF, $FF, $FF, $D4, $B6, $9F, $8E, $80, $74, $6A, $62, $5B, $55),
    ($00, $FF, $FF, $FF, $FF, $FF, $FF, $DB, $BF, $AA, $99, $8B, $80, $76, $6D, $66),
    ($00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $DF, $C6, $B2, $A2, $95, $89, $7F, $77),
    ($00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $E3, $CC, $B9, $AA, $9D, $92, $88),
    ($00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $E6, $D1, $BF, $B1, $A4, $99),
    ($00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $E8, $D4, $C4, $B6, $AA),
    ($00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $EA, $D8, $C8, $BB),
    ($00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $EB, $DB, $CC),
    ($00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $ED, $DD),
    ($00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $EE),
    ($00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF)
  );    
begin
(*
  lRgbColor := 29773;

  ShowMessage(IntToStr(SizeOf(TRgbAPixelRec)));
  
  ShowMessage( 'Red : ' + IntToHex(RgbPreMult[lRgbColor And $F000 Shr $C, lRgbColor And $000F], 2) + #$D#$A +
               'Green : ' + IntToHex(RgbPreMult[lRgbColor And $0F00 Shr $8, lRgbColor And $000F], 2) + #$D#$A +
               'Blue : ' + IntToHex(RgbPreMult[lRgbColor And $00F0 Shr $4, lRgbColor And $000F], 2) + #$D#$A +
               'Alpha : ' + IntToHex(RgbMap[lRgbColor And $000F], 2));
{
  ShowMessage( 'Alpha : ' + IntToStr(lRgbColor And $000F) + #$D#$A +
               'Red : ' + IntToStr(lRgbColor And $F000 Shr $C) + #$D#$A +
               'Green : ' + IntToStr(lRgbColor And $0F00 Shr $8) + #$D#$A +
               'Blue : ' + IntToStr(lRgbColor And $00F0 Shr $4));
}
Exit;
  lHackMaster := TTSTOHackMasterListIO.CreateHackMasterList();
  Try
    lHackMaster.LoadFromFile('Z:\Temp\TSTO\Hack\KahnHack\4_35_THoHTieIn2018_H9STXIPV025M\HackMasterList.xml');
    ShowMessage(lHackMaster.ListStoreRequirements('MissHoover'));
    Finally
      lHackMaster := Nil;
  End;
Exit;
  lPath := 'C:\Projects\TSTO-Hacker\Bin\Hacks\KahnHack\StoneCutters\1.src\';
  FormatXmlFiles(lPath);
  ShowMessage('Done');  
Exit;
  lPath := 'C:\Projects\TSTO-Hacker\Bin\Hacks\KahnHack\4_21_Superheroes2_Takedown_Patch1_7HJX2AY8DSYW\textpools-en-r328058-01I9LT8U\0\';
  lPath := 'C:\Projects\TSTO-Hacker\Bin\Hacks\KahnHack\StoneCutters\TextpoolsEn\';
  If FindFirst(lPath + '*.sbtp', faAnyFile, lSr) = 0 Then
  Try
    Repeat
      lSbtp := TSbtpFileIO.LoadBinSbtpFile(lPath + lSr.Name);
      Try
        lSbtp.SaveToXml(lPath + ChangeFileExt(lSr.Name, '.xml'));
        Finally
          lSbtp := Nil;
      End;
    Until FindNext(lSr) <> 0;

    Finally
      FindClose(lSr);
  End;
  ShowMessage('Done');
Exit;
  lPath := 'C:\Projects\TSTO-Hacker\Bin\Hacks\KahnHack\4_21_FilmSetPromo_Patch1_PostLaunch_2PNORJTAERR9\gamescripts-r326821-SFBGR2CM\0\';
  lNodes := LoadXmlDocument(lPath + 'farms.xml').SelectNodes('//Job/Cost[not(@money="0")]');
  With TStringList.Create() Do
  Try
    Add('<Dah>');
{
      <PatchData>
        <PatchType>3</PatchType>
        <PatchPath>//Job[@name="Corn"]/Cost</PatchPath>
        <Code>
          <DynamicCost money="selector KhnCletusFarmCornJobCostFormula"/>
        </Code>
      </PatchData>
}
    For X := 0 To lNodes.Count - 1 Do
    Begin
      lFarmName := lNodes[X].DOMNode.parentNode.parentNode.attributes.getNamedItem('name').nodeValue;
      lJobName  := lNodes[X].DOMNode.parentNode.attributes.getNamedItem('name').nodeValue;
      Add('<PatchData>');
      Add('<PatchType>3</PatchType>');
      Add('<PatchPath>//Job[@name="' + lJobName + '"]/Cost</PatchPath>');
      Add('<Code>');
      Add('<DynamicCost money="selector Khn' + lFarmName + lJobName + 'JobCostFormula"/>');
      Add('</Code>');
      Add('</PatchData>');
//      Break;
    End;
    Add('</Dah>');
    ShowMessage(FormatXmlData(Text));

    Finally
      Free();
  End;
  //ShowMessage(lNodes[0].Xml);
Exit;

  lPath := 'C:\Projects\TSTO-Hacker\Bin\Hacks\KahnHack\4_21_Superheroes2_Patch1_PostLaunch_T3D4HI3NBUGU\textpools-en-r322335-WUGPKCL8\0\';
  lSbtp := TSbtpFileIO.CreateSbtpFile();
  Try
    lSbtp.LoadFromFile(lPath + 'scorpio_eng_en15.sbtp');
    lSbtp.SaveToXml(lPath + 'scorpio_eng_en15.xml');
    ShowMessage('Done');
    
    Finally
      lSbtp := Nil;
  End;
Exit;
  lPath := 'C:\Projects\TSTO-Hacker\Bin\Hacks\KahnHack\4_21_Superheroes2_EDVUQ6D8A5WW\gamescripts-r321828-OIF8125N\';
  With TTSTOItemLister.CreateLister() Do
  Begin
    ListNonFreeItems(lPath + 'HackMasterListDetail.xml', lPath + 'HsCostOverRideNew.xml');
    ListUniqueItems(lPath + 'HackMasterListDetail.xml', lPath + 'HsUniqueOverRideNew.xml');
    ListRequirementItems(lPath + 'HackMasterListDetail.xml', lPath + 'HsRequirementOverRideNew.xml');
    ListNonSellableItems(lPath + 'HackMasterListDetail.xml', lPath + 'HsNonSellableOverRideNew.xml');
    ShowMessage('Done');
  End;
Exit;
  lPath := 'C:\Projects\TSTO-Hacker\Bin\Hacks\KahnHack\ScriptIco\';
  If FindFirst(lPath + '*.png', faAnyFile, lSr) = 0 Then
  Try
    Repeat
      LoadImageFromFile(lPath + lSr.Name, lImg);
      SaveImageToFile(lPath + ChangeFileExt(lSr.Name, '.rgb'), lImg);
    Until FindNext(lSr) <> 0;
    ShowMessage('Done');

    Finally
      FindClose(lSr);
  End;
Exit;
  lPath := 'C:\Projects\TSTO-Hacker\Bin\Hacks\KahnHack\4_20_HomersChiliad_Patch1_PostLaunch_B1KJ7EK7IFOJ\gamescripts-r318969-JIWHRBU0\';
  With TTSTOItemLister.CreateLister() Do
  Begin
    ListNonFreeItems(lPath + 'HackMasterListDetail.xml', lPath + 'HsCostOverRideNew.xml');
    ListUniqueItems(lPath + 'HackMasterListDetail.xml', lPath + 'HsUniqueOverRideNew.xml');
    ListRequirementItems(lPath + 'HackMasterListDetail.xml', lPath + 'HsRequirementOverRideNew.xml');
    ListNonSellableItems(lPath + 'HackMasterListDetail.xml', lPath + 'HsNonSellableOverRideNew.xml');
    ShowMessage('Done');
  End;
Exit;
  lHackMaster := TTSTOHackMasterListIO.CreateHackMasterList();
  Try
    lHackMaster.BuildMasterList(FPrj);
    lHackMaster.SaveToFile('C:\Projects\TSTO-Hacker\Bin\Hacks\KahnHack\4_20_HomersChiliad_Patch1_PostLaunch_B1KJ7EK7IFOJ\gamescripts-r318969-JIWHRBU0\HackMasterList.xml');
    ShowMessage('Done');

    Finally
      lHackMaster := Nil;
  End;
Exit;
  FormatXmlFiles('C:\TSTO Hack\Roscky\KirkAudio-mp4-r157326-B8353263.Paid\2.src\');
  ShowMessage('Done');
Exit;
  lPath := 'C:\Projects\TSTO-Hacker\Bin\Temp\';
  lBCell := TTSTOBCellFileIO.CreateBCellFile();
  lBCell.LoadFromFile(lPath + 'babybear_tap_2.bcell');
  lStrs := THsStringListEx.CreateList();
  Try
    lStrs.Text := lBCell.AsXml;
    lStrs.SaveToFile(lPath + 'babybear_tap_2.xml');
    Finally
      lStrs := Nil;
  End;

  For X := 0 To lBCell.Items.Count - 1 Do
    If FileExists(lPath + lBCell.Items[X].RgbFileName) Then
    Begin
      LoadImageFromFile(lPath + lBCell.Items[X].RgbFileName, lImg);
      Try
        SaveImageToFile(lPath + ChangeFileExt(lBCell.Items[X].RgbFileName, '.png'), lImg);

        Finally
          FreeImage(lImg);
      End;
    End;
  ShowMessage('Done');
Exit;
  lPath := 'C:\Projects\TSTO-Hacker\Bin\Temp\';
  lBCell := TTSTOBCellFileIO.CreateBCellFile();
  lAvi   := TAviWriter_2.Create(Self);
  Try
    lW := 0;
    lH := 0;

    lRgbs := TTSTORgbFile.CreateRGBFileList();
    lBCell.LoadFromFile(lPath + 'babybear_tap_2.bcell');
    For X := 0 To lBCell.Items.Count - 1 Do
      If FileExists(lPath + lBCell.Items[X].RgbFileName) Then
      Begin
        With lRgbs.Add() Do
        Begin
          LoadRgbFromFile(lPath + lBCell.Items[X].RgbFileName);
          lW := Max(lW, Width);
          lH := Max(lH, Height);
        End;
      End;

    With lAvi Do
    Begin
      Width               := lW;
      Height              := lH;
      FrameTime           := 500;
      CompressionQuality  := 10000;
      WavFileName         := '';
      Stretch             := True;
      OnTheFlyCompression := False;
      PixelFormat         := pf8Bit;

      FileName := lPath + 'TestAvi.avi';
      TempFileName := ExtractFilePath(FileName) + '~AWTemp' +
                      ExtractFileName(FileName);
      SetCompression('MRLE');
    End;

    For X := 0 To lBCell.Items.Count - 1 Do
    Begin
      lRgb := TTSTORgbFile.CreateRGBFile(lW, lH);
      Try
        lRgb.DrawFrom(Round(lW - lBCell.Items[X].xDiffs), lH - lRgbs[X].Height, lRgbs[X]);
        lBmp := lRgb.CreateBitmap();
        Try
          If X = 0 Then
            lAvi.InitVideo(lBmp);
          lAvi.AddFrame(lBmp);
          lBmp.SaveToFile(lPath + IntToStr(X) + '.bmp');
          lRgbs[X].SaveAsPng(lPath + IntToStr(X) + '.png');

          Finally
            lBmp.Free();
        End;

        Finally
          lRgb := Nil;
      End;
    End;

    lAvi.FinalizeVideo();
    lAvi.WriteAvi();

    ShowMessage('Done');

    Finally
      lBCell := Nil;
      lRgbs  := Nil;
      lAvi.Free();
  End;
Exit;
{
  <XScale>-0,99664306640625</XScale>
  <Skew_H>0.0817718505859375</Skew_H>
  <Skew_V>0.0826873779296875</Skew_V>
  <YScale>0.996566772460938</YScale>
}
  lPath := 'C:\Projects\TSTO-Hacker\Bin\Temp\';
  lBsv := TBsvFileIO.CreateBsvFile();
  Try
    lBsv.LoadFromFile(lPath + 'coconutbabalooflipped_dilapidated.bsv3');
    lBsv.RgbFile.LoadRgbFromFile(lPath + 'coconutbabalooflipped_dilapidated.rgb');

    lBsv.DumpRegions(lPath);
    lBsv.DumpTransformations(0, 0, lPath);
    ShowMessage('Done');

    Finally
      lBsv := Nil;
  End;
Exit;
  lPath := 'C:\Projects\TSTO-Hacker\Bin\Temp\';
  lBsv := TBsvFileIO.CreateBsvFile();
  Try
    lBsv.LoadFromFile(lPath + 'coconutbabalooflipped_dilapidated.bsv3');
    lBsv.SaveToXml(lPath + 'coconutbabalooflipped_dilapidated.xml');

    Finally
      lBsv := Nil;
  End;
Exit;
  lPath := 'C:\Projects\TSTO-Hacker\Bin\Temp\';
  lBsv := TBsvFileIO.CreateBsvFile();
  Try
    lBsv.LoadFromFile(lPath + 'coconutbabalooflipped_dilapidated.bsv3');
    lBsv.SaveToXml(lPath + 'coconutbabalooflipped_dilapidated.xml');
    lBsv.RgbFile.LoadRgbFromFile(lPath + 'coconutbabalooflipped_dilapidated.rgb');
    lBsv.RgbFile.SaveAsPng(lPath + 'coconutbabalooflipped_dilapidated.png');
    lBsv.DumpRegions(lPath + 'Region-.png');
    ShowMessage('Done');

    Finally
      lBsv := Nil;
  End;

Exit;
  lNode := FTvDlcServer.GetFirstSelected();
  If GetNodeData(lNode, IBinArchivedFileData, lFile) And
     GetNodeData(lNode.Parent, IBinZeroFileData, lArchive) And
     GetNodeData(lNode.Parent.Parent, ITSTOPackageNode, lPkg) Then
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
      lMem.Position := 0;

      lSbtp := TSbtpFileIO.LoadBinSbtpFile(lMem);
      Try
        lSbtp.SaveToXml(FPrj.Settings.HackPath + ChangeFileExt(lFile.FileName1, '.xml'));
        ShowMessage('Done');

        Finally
          lSbtp := Nil;
      End;

      Finally
        lMem := Nil;
        lZip := Nil;
    End;
  End;
Exit;
*)
end;

Type
  TRgbAPixels = Array Of Array Of Word;

procedure TDlcDownload.ToolButton2Click(Sender: TObject);
Var lPath : String;
    lSr   : TSearchRec;
    lRgb  : ITSTORgbFile;

    lMem : IMemoryStreamEx;
    lPng : TPngImage;
    lX, lY : Integer;
    lW, lH : Word;
    lPixel : TRgbAPixels;
    lA, lR, lG, lB : Byte;
    lColor : Word;
    lDWord : DWord;
begin
  lPath := 'Z:\Temp\TSTO\Hack\KahnHack\4_35_THOH2018_IA7KQRW0AI2A\THOH2018Menu_LTD-ipad-r436534-9H4YNMIF\1.src\';
  lMem := TMemoryStreamEx.Create();
  lMem.LoadFromFile(lPath + 'bse_thoh2018_threepanel.rgb');
  lMem.ReadDWord();
  lW := lMem.ReadWord();
  lH := lMem.ReadWord();
  lPng := TPngImage.CreateBlank(COLOR_RGBALPHA, 16, lW, lH);
  Try
    For lY := 0 To lH - 1 Do
      For lX := 0 To lW - 1 Do
      Begin
        lDWord := lMem.ReadDWord();

        lPng.Pixels[lX, lY] := lDWord;// And $FFFFFF00;
        If lPng.Header.ColorType = COLOR_RGBALPHA Then
          lPng.AlphaScanline[lY]^[lX] := $FF;//lDWord And $000000FF;

(*
    Result := RoundMin(RgbMap[ARgbAColor And $F000 Shr $C] * lMult, $FF) Or
              RoundMin(RgbMap[ARgbAColor And $0F00 Shr $8] * lMult, $FF) Shl $8 Or
              RoundMin(RgbMap[ARgbAColor And $00F0 Shr $4] * lMult, $FF) Shl $10;

*)
      End;

    ImgResource.Picture.Assign(lPng);
    ImgResource.Repaint();

    Finally
      lMem := Nil;
      lPng.Free();
  End;

Exit;
//  ShowMessage(IntToHex(Rgb($F0, $E0, $D0), 8));
//  lColor := $FEDC;
//  ShowMessage( IntToHex( (lColor Shr 8 Or
//               lColor Shl 4 Or
//               lColor Shl 16) And $F0F0F0, 8) + ' - ' +
//
//               IntToHex(lColor Shr 8 And $F0 Or //Red
//               lColor Shr 4 And $F0 Shl 8 Or //Green
//               lColor And $F0 Shl 16, 8) //Blue
//
//             );
//
//Exit;
  lRgb := TTSTORgbFile.CreateRGBFile();
  Try
    lRgb.LoadRgbFromFile('1979onda.rgb');
//    SmoothRotate(TPngImage(lRgb.Picture), 45);
    ImgResource.Picture.Assign(lRgb.Picture);
    PanImage.Visible := True;

    Finally
      lRgb := Nil;
  End;
Exit;
  lPath := 'C:\Projects\TSTO-Hacker\Bin\Hacks\KahnHack\';
  If FindFirst(lPath + '*.png', faAnyFile, lSr) = 0 Then
  Try
    Repeat
      lRgb := TTSTORgbFile.CreateRGBFile();
      Try
        lRgb.PngToRgb(lPath + lSr.Name, lPath + ChangeFileExt(lSr.Name, '.rgb'));
        Finally
          lRgb := Nil;
      End;
    Until FindNext(lSr) <> 0;
    ShowMessage('Done');
    Finally
      FindClose(lSr);
  End;
end;

Procedure TDlcDownload.GetRgbNodeList(Sender : TBaseVirtualTree; Node : PVirtualNode; Data : Pointer; Var Abort : Boolean);
Var lPkg  : ITSTOPackageNode;
    lMem  : IMemoryStreamEx;
    lZip  : IHsMemoryZipper;
    X, Y  : Integer;
Begin
  If GetNodeData(Node, ITSTOPackageNode, lPkg) And lPkg.FileExist Then
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
          PPackageList(Data).Add(lPkg);
          Break;
        End;
  End;
End;

Procedure TDlcDownload.DoExpandNode(Sender : TBaseVirtualTree; Node : PVirtualNode; Data : Pointer; Var Abort : Boolean);
Begin
  If Sender.GetNodeLevel(Node) < 4 Then
    Sender.Expanded[Node] := PBoolean(Data)^;
End;

procedure TDlcDownload.ExpandAll1Click(Sender: TObject);
Var lBln : Boolean;
begin
  lBln := True;
  FTvDlcServer.IterateSubtree(FTvDlcServer.GetFirstSelected(), DoExpandNode, @lBln);//, [], True);
end;

procedure TDlcDownload.CollapseAll1Click(Sender: TObject);
Var lBln : Boolean;
begin
  lBln := False;
  FTvDlcServer.IterateSubtree(FTvDlcServer.GetFirstSelected(), DoExpandNode, @lBln);//, [], True);
end;

procedure TDlcDownload.ExportasXML1Click(Sender: TObject);
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

  If GetNodeData(lNode, IBinArchivedFileData, lArch) Then
  Begin
    Raise Exception.Create('ToDo');
  End
  Else If GetNodeData(lNode, ITSTOPackageNode, lPkg) Then
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

Procedure TDlcDownload.ExtractRgbFiles(APackageList : ITSTOPackageNodes);
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

Var lProgress : IRgbProgress;
    X, Y      : Integer;
    lZip1     ,
    lZip2     : IHsMemoryZipper;
    lMem      : IMemoryStreamEx;
    lRgbFiles : IBinArchivedFileDatas;
    lCurArch  : Integer;
    lRgbFile  : ITSTORgbFile;
    lPath     : String;
    lCurPath  : String;
Begin
  If APackageList.Count > 0 Then
  Begin
    lPath := ExtractFilePath(ParamStr(0)) + '\Res\';
    If Not DirectoryExists(lPath) Then
      ForceDirectories(lPath);

    lProgress := TRgbProgress.CreateRgbProgress();
    lProgress.Show();
    Try
      For X := 0 To APackageList.Count - 1 Do
      Begin
        lProgress.CurOperation := ExtractFileName(APackageList[X].FileName);
        lProgress.ItemProgress := Round(X / APackageList.Count * 100);

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

                  lMem.Clear();
                  lZip2.ExtractToStream(lRgbFiles[Y].FileName1, lMem);
                  Try
                    lRgbFile.LoadRgbFromStream(lMem);
                    lCurPath := IncludeTrailingBackSlash(lPath + ChangeFileExt(ExtractFileName(APackageList[X].FileName), ''));
                    If Not DirectoryExists(lCurPath) Then
                      ForceDirectories(lCurPath);
                    lRgbFile.Picture.SaveToFile(lCurPath + ChangeFileExt(lRgbFiles[Y].FileName1, '.png'));

                    Except
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
End;

procedure TDlcDownload.tbExtractRgbClick(Sender: TObject);
Var lPkgList : ITSTOPackageNodes;
begin
  If MessageDlg('Do you want to extract RGB Files?', mtConfirmation, [mbYes, mbNo], 0) = mrYes Then
  Begin
    lPkgList := TTSTOPackageNodes.Create();
    Try
      FTvDlcServer.IterateSubtree(FTvDlcServer.GetFirstSelected(), GetRgbNodeList, @lPkgList);
      lPkgList.Sort();
      ExtractRgbFiles(lPkgList);

      Finally
        lPkgList := Nil;
    End;
  End;
end;

procedure TDlcDownload.tbMainMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If ([ssCtrl, ssAlt, ssShift, ssRight] * Shift  = Shift) And (Button = mbRight) Then
    FTvDlcServer.IsDebugMode := Not FTvDlcServer.IsDebugMode; 
end;
{
C:\Projects\TSTO-Hacker\Source\Xml\TSTOStoreMenuMaster.pas
  Interface Uses: xmldom
C:\Projects\TSTO-Hacker\Source\HsUnits\HsZipUtils.pas
  Interface Uses: AbZipper
C:\Projects\TSTO-Hacker\Source\TSTOPackageList.pas
  Interface Uses: RTLConsts
  Implementation Uses: HsStringListEx,TSTOProject,TSTOZeroImpl
C:\Projects\TSTO-Hacker\Source\DlcDownloadFrm.pas
  Interface Uses: TSTODlcIndex
  Implementation Uses: HsEncodingEx,TSTOPatches,XMLDoc,xmldom
C:\Projects\TSTO-Hacker\Source\SptbFrm.pas
  Implementation Uses: HsInterfaceEx
C:\Projects\TSTO-Hacker\Source\CustomPatchFrm.pas
  Implementation Uses: TypInfo
C:\Projects\TSTO-Hacker\Source\BCellFile\IO\DataPlugin\TSTOBCell.Xml.pas
  Implementation Uses: HsStreamEx
C:\Projects\TSTO-Hacker\Source\SbtpFile\IO\DataPlugin\TSTOSbtp.Xml.pas
  Implementation Uses: TypInfo
C:\Projects\TSTO-Hacker\Source\SbtpFile\TSTOSbtpImpl.pas
  Interface Uses: HsStreamEx
C:\Projects\TSTO-Hacker\Source\SbtpFile\TSTOSbtpIntf.pas
  Interface Uses: RTLConsts
C:\Projects\TSTO-Hacker\Source\SbtpFile\IO\DataPlugin\TSTOSbtp.JSon.pas
  Interface Uses: RTLConsts
  Implementation Uses: HsStreamEx,TypInfo
C:\Projects\TSTO-Hacker\Source\BsvFile\TSTOBsvIntf.pas
  Interface Uses: RTLConsts
C:\Projects\TSTO-Hacker\Source\BsvFile\IO\DataPlugin\TSTOBsv.Bin.pas
  Interface Uses: RTLConsts
}
end.
