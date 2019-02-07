unit SptbFrm;

interface

uses
  dmImage, TSTOProject.Xml, TSTOSbtpIntf, TSTOSbtp.IO, TSTOHackSettings,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ToolWin, ComCtrls, ExtCtrls, VirtualTrees, StdCtrls, Menus, TB2Item,
  SpTBXItem, TB2Dock, TB2Toolbar, SpTBXControls, SpTBXExControls, SpTbxSkins,
  SpTBXDkPanels, TSTOTreeViews;

type
  TFrmSbtp = class(TForm)
    PanInfo: TPanel;
    PanTreeView: TPanel;
    vstSbtpFile: TSpTBXVirtualStringTree;
    popSave: TPopupMenu;
    Save1: TMenuItem;
    SaveAsXml1: TMenuItem;
    SpTBXBItemContainer1: TSpTBXBItemContainer;
    tbPopupMenuItems: TSpTBXSubmenuItem;
    tbOpenFile: TSpTBXItem;
    tbSave: TSpTBXSubmenuItem;
    tbSave2: TSpTBXItem;
    tbSaveAsXml: TSpTBXItem;
    sptbxDckMain: TSpTBXDock;
    sptbxtbMain: TSpTBXToolbar;
    tbMainPopup: TSpTBXTBGroupItem;
    SpTBXItem3: TSpTBXItem;
    gbPatchInfoV2: TSpTBXGroupBox;
    Label5: TLabel;
    Label1: TLabel;
    EditVariableValue: TEdit;
    EditVariableName: TEdit;
    SplitTvs: TSpTBXSplitter;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure vstSbtpFileInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vstSbtpFileInitChildren(Sender: TBaseVirtualTree;
      Node: PVirtualNode; var ChildCount: Cardinal);
    procedure vstSbtpFileFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);

    procedure tbSaveClick(Sender: TObject);
    procedure SaveAsXml1Click(Sender: TObject);
    procedure tbLoadXmlClick(Sender: TObject);
    procedure tbMainMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    procedure vstSbtpDataInitChildren(Sender: TBaseVirtualTree;
      Node: PVirtualNode; var ChildCount: Cardinal);
    procedure vstSbtpDataInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vstSbtpDataFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vstSbtpDataEditing(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; var Allowed: Boolean);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure vstSbtpFileGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vstSbtpDataGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vstSbtpDataNewText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; NewText: string);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormActivate(Sender: TObject);

  Private
    FHackSettings : ITSTOHackSettings;
    FAppSettings  : ITSTOXMLSettings;
    FFormSettings : ITSTOXMLFormSetting;
    FTvData       : ISbtpFilesIO;
    FPrevNode     : PVirtualNode;
    FTvVarData    : ISbtpVariable;
    FTvSbtpData   : TTSTOSbtpFileTreeView;

    Procedure SetHackSettings(AHackSettings : ITSTOHackSettings);
    Procedure SetAppSettings(AAppSettings  : ITSTOXMLSettings);

    Procedure DoOnChanged(Sender : TObject);

    Procedure SetNodeData(ANode : PVirtualNode; ANodeData : IInterface);
    Function  GetNodeData(ANode : PVirtualNode; AId : TGUID; Var ANodeData) : Boolean; OverLoad;
    Function  GetNodeData(ANode : PVirtualNode; AId : TGUID) : Boolean; OverLoad;


  Published
    Property HackSettings : ITSTOHackSettings Read FHackSettings Write SetHackSettings;
    Property AppSettings  : ITSTOXMLSettings  Read FAppSettings  Write SetAppSettings;
  end;

implementation

Uses RTTI, HsZipUtils, HsStreamEx, HsInterfaceEx;

{$R *.dfm}

procedure TFrmSbtp.FormActivate(Sender: TObject);
Var X : Integer;
begin
  WindowState := TRttiEnumerationType.GetValue<TWindowState>(FFormSettings.WindowState);
  Left        := FFormSettings.X;
  Top         := FFormSettings.Y;
  Height      := FFormSettings.H;
  Width       := FFormSettings.W;

  For X := 0 To FFormSettings.Count - 1 Do
    If SameText(FFormSettings[X].SettingName, 'SplitTvsLeft') Then
      PanTreeView.Width := FFormSettings[X].SettingValue;
end;

procedure TFrmSbtp.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
Var lSetting : ITSTOXmlCustomFormSetting;
    X      : Integer;
begin
  CanClose := True;

  If FTvData.Modified Then
    Case MessageDlg('Save changes to Textpool patches ?', mtInformation, [mbYes, mbNo, mbCancel], 0) Of
      mrYes : tbSaveClick(Self);
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

      lSetting := Nil;
      For X := 0 To FFormSettings.Count - 1 Do
        If SameText(FFormSettings[X].SettingName, 'SplitTvsLeft') Then
        Begin
          lSetting := FFormSettings[X];
        End;

      If Not Assigned(lSetting) Then
        lSetting := FFormSettings.Add();

      lSetting.SettingName := 'SplitTvsLeft';
      lSetting.SettingValue := PanTreeView.Width;
    End;
  End;
end;

procedure TFrmSbtp.FormCreate(Sender: TObject);
Var lProject : ITSTOXMLProject;
    X, Y     : Integer;
begin
  FTvSbtpData := TTSTOSbtpFileTreeView.Create(Self);
  FTvSbtpData.Parent := PanInfo;
  FTvSbtpData.Align  := alClient;
  FTvSbtpData.NodeDataSize := SizeOf(IInterface);

  FTvSbtpData.OnEditing      := vstSbtpDataEditing;
  FTvSbtpData.OnFocusChanged := vstSbtpDataFocusChanged;
  FTvSbtpData.OnGetText      := vstSbtpDataGetText;
  FTvSbtpData.OnInitChildren := vstSbtpDataInitChildren;
  FTvSbtpData.OnInitNode     := vstSbtpDataInitNode;
  FTvSbtpData.OnNewText      := vstSbtpDataNewText;

  If SameText(SkinManager.CurrentSkin.SkinName, 'WMP11') Then
  Begin
    vstSbtpFile.Color := $00262525;
    FTvSbtpData.Color :=  $00262525;

    With SkinManager.CurrentSkin Do
      Options(skncListItem, sknsNormal).TextColor := $00F1F1F1;
  End;
end;

procedure TFrmSbtp.FormDestroy(Sender: TObject);
begin
  FTvData := Nil;
end;

procedure TFrmSbtp.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #27 Then
  Begin
    Key := #0;
    Close;
  End;
end;

Procedure TFrmSbtp.SetHackSettings(AHackSettings : ITSTOHackSettings);
Var X : Integer;
    lMemStrm : IMemoryStreamEx;
Begin
  FPrevNode := Nil;

  FHackSettings := AHackSettings;

  FTvData := TSbtpFilesIO.CreateSbtpFiles();
  lMemStrm := TMemoryStreamEx.Create();
  Try
    FHackSettings.TextPools.SaveToStream(lMemStrm);
    lMemStrm.Position := 0;
    FTvData.LoadFromStream(lMemStrm);
    Finally
      lMemStrm := Nil;
  End;

  vstSbtpFile.RootNodeCount := FTvData.Count;
  FTvData.OnChange := DoOnChanged;
End;

Procedure TFrmSbtp.SetAppSettings(AAppSettings  : ITSTOXMLSettings);
Var X : Integer;
Begin
  FAppSettings := AAppSettings;

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

    With FFormSettings.Add() Do
    Begin
      SettingName  := 'SplitTvsLeft';
      SettingValue := PanTreeView.Width;
    End;
  End;
End;

Procedure TFrmSbtp.DoOnChanged(Sender : TObject);
Begin
  tbSave.Enabled := True;
  tbSave2.Enabled := True;
End;

procedure TFrmSbtp.SaveAsXml1Click(Sender: TObject);
begin
  With TSaveDialog.Create(Self) Do
  Try
    Filter := 'Xml Files|*.xml';
    If Execute() Then
      FTvData.SaveToXml(FileName);

    Finally
      Free();
  End;
end;

procedure TFrmSbtp.tbLoadXmlClick(Sender: TObject);
begin
  With TOpenDialog.Create(Self) Do
  Try
    Filter := 'Xml Files|*.xml';
    If Execute() Then
    Begin
      If Not Assigned(FTvData) Then
        FTvData := TSbtpFilesIO.CreateSbtpFiles();

      FTvData.LoadFromXml(FileName);
      vstSbtpFile.BeginUpdate();
      Try
        vstSbtpFile.Clear();
        vstSbtpFile.RootNodeCount := FTvData.Count;
        
        Finally
          vstSbtpFile.EndUpdate();
      End;
    End;

    Finally
      Free();
  End;
end;

procedure TFrmSbtp.tbMainMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If ([ssCtrl, ssAlt, ssShift, ssRight] * Shift  = Shift) And (Button = mbRight) Then
  Begin
    If vstSbtpFile.Header.Options * [hoVisible] = [] Then
    Begin
      vstSbtpFile.Header.Options := vstSbtpFile.Header.Options + [hoVisible];
      vstSbtpFile.Header.Columns[1].Options :=
        vstSbtpFile.Header.Columns[1].Options + [coVisible];
      vstSbtpFile.Header.AutoSizeIndex := 1;
    End
    Else
    Begin
      vstSbtpFile.Header.Options := vstSbtpFile.Header.Options - [hoVisible];
      vstSbtpFile.Header.Columns[1].Options :=
        vstSbtpFile.Header.Columns[1].Options - [coVisible];
      vstSbtpFile.Header.AutoSizeIndex := 0;
    End;
  End;
end;

procedure TFrmSbtp.tbSaveClick(Sender: TObject);
Var lMem : IMemoryStreamEx;
begin
  If FTvData.Modified Then
  Begin
    lMem := TMemoryStreamEx.Create();
    Try
      FTvData.SaveToStream(lMem);
      lMem.Position := 0;
      FHackSettings.TextPools.LoadFromStream(lMem);
      FHackSettings.TextPools.ForceChanged();

      FTvData.ClearChanges();

      Finally
        lMem := Nil;
    End;
  End;

  ModalResult := mrOk;
end;

Function TFrmSbtp.GetNodeData(ANode : PVirtualNode; AId : TGUID; Var ANodeData) : Boolean;
Var lNodeData : PPointer;
Begin
  lNodeData := TreeFromNode(ANode).GetNodeData(ANode);
  Result := Assigned(lNodeData^) And Supports(IInterface(lNodeData^), AId, ANodeData);
End;

Function TFrmSbtp.GetNodeData(ANode : PVirtualNode; AId : TGUID) : Boolean;
Var lDummy : IInterface;
Begin
  Result := GetNodeData(ANode, AId, lDummy);
End;

Procedure TFrmSbtp.SetNodeData(ANode : PVirtualNode; ANodeData : IInterface);
Var lNodeData : PPointer;
Begin
  lNodeData  := TreeFromNode(ANode).GetNodeData(ANode);
  lNodeData^ := Pointer(ANodeData);
End;

procedure TFrmSbtp.vstSbtpDataEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
begin
  Allowed := ({FTvSbtpData.}GetNodeData(Node, ISbtpVariable) And (Column = 0)) Or
             ({FTvSbtpData.}GetNodeData(Node, ISbtpSubVariable) And (Column In [1, 2]));
end;

procedure TFrmSbtp.vstSbtpDataFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
begin
  If Sender.IsEditing Then
    Sender.EndEditNode();

  If Assigned(Node) Then
    Sender.EditNode(Node, Column);
end;

procedure TFrmSbtp.vstSbtpDataGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
Var lVarPref : ISbtpVariable;
    lSubVar  : ISbtpSubVariable;
begin
  CellText := '';
  If {FTvSbtpData.}GetNodeData(Node, ISbtpVariable, lVarPref) Then
  Begin
    If Column = 0 Then
    Begin
      CellText := lVarPref.VariableType;
      If CellText = '' Then
        CellText := '<None>';
    End;
  End
  Else If {FTvSbtpData.}GetNodeData(Node, ISbtpSubVariable, lSubVar) Then
  Begin
    If Column = 1 Then
      CellText := lSubVar.VariableName
    Else If Column = 2 Then
      CellText := lSubVar.VariableData;
  End;
end;

procedure TFrmSbtp.vstSbtpDataInitChildren(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var ChildCount: Cardinal);
Var lData : ISbtpVariable;
begin
  If {FTvSbtpData.}GetNodeData(Node, ISbtpVariable, lData) Then
    ChildCount := lData.SubItem.Count;
end;

procedure TFrmSbtp.vstSbtpDataInitNode(Sender: TBaseVirtualTree; ParentNode,
  Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
begin
  If Not Assigned(ParentNode) Then
  Begin
    {FTvSbtpData.}SetNodeData(Node, FTvVarData);
    If FTvVarData.SubItem.Count > 0 Then
      InitialStates := InitialStates + [ivsHasChildren];
  End
  Else
    {FTvSbtpData.}SetNodeData(Node, FTvVarData.SubItem[Node.Index]);
end;

procedure TFrmSbtp.vstSbtpDataNewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; NewText: string);
Var lVarPref : ISbtpVariable;
    lSubVar  : ISbtpSubVariable;
begin
  If {FTvSbtpData.}GetNodeData(Node, ISbtpVariable, lVarPref) Then
  Begin
    If Column = 0 Then
      lVarPref.VariableType := NewText;
  End
  Else If {FTvSbtpData.}GetNodeData(Node, ISbtpSubVariable, lSubVar) Then
  Begin
    If Column = 1 Then
      lSubVar.VariableName := NewText
    Else If Column = 2 Then
      lSubVar.VariableData := NewText;
  End;
end;

procedure TFrmSbtp.vstSbtpFileFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
//Var lVarPref : ISbtpVariable;
Var lFile : ISbtpFileIO;
begin
//(*
  With FTvSbtpData Do
  Begin
    If GetNodeData(Node, ISbtpFileIO, lFile) Or
       GetNodeData(Node.Parent, ISbtpFileIO, lFile) Then
    Begin
      If IsEditing Then
        EndEditNode();

      BeginUpdate();
      Try
        FTvSbtpData.TvData := lFile;

        Finally
          EndUpdate();
      End;
    End;
  End;
//*)
(*
  If Assigned(FPrevNode) Then
  Begin

  End;

  If GetNodeData(Node, ISbtpVariable, lVarPref) Then
  Begin
    If vstSbtpData.IsEditing Then
      vstSbtpData.EndEditNode();

    FPrevNode := Node;
    FTvVarData := lVarPref;
    vstSbtpData.BeginUpdate();
    Try
      vstSbtpData.Clear();
      vstSbtpData.RootNodeCount := 1;

      Finally
        vstSbtpData.EndUpdate();
    End;
  End;
*)
end;

procedure TFrmSbtp.vstSbtpFileGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
Var lPatch : ISbtpFileIO;
    lVarPref : ISbtpVariable;
    lVarData : ^IInterface;
begin
  CellText := '';
  Case Column Of
    0 :
    Begin
      If GetNodeData(Node, ISbtpFileIO, lPatch) Then
        CellText := 'File Index : ' + IntToStr(lPatch.Header.HeaderPadding)
      Else If GetNodeData(Node, ISbtpVariable, lVarPref) Then
      Begin
        CellText := lVarPref.VariableType;
        If CellText = '' Then
          CellText := '<None>';
      End;
    End;

    1 :
    Begin
      If hoVisible In Sender.Header.Options Then
      Begin
        lVarData := Sender.GetNodeData(Node);
        CellText := GetInterfaceName(lVarData^)
      End;
    End;
  End;
end;

procedure TFrmSbtp.vstSbtpFileInitChildren(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var ChildCount: Cardinal);
Var lPatch : ISbtpFileIO;
begin
  If GetNodeData(Node, ISbtpFileIO, lPatch) Then
    ChildCount := lPatch.Item.Count
end;

procedure TFrmSbtp.vstSbtpFileInitNode(Sender: TBaseVirtualTree; ParentNode,
  Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
Var lPatch : ISbtpFileIO;
    lVarPref : ISbtpVariables;
begin
  If Not Assigned(ParentNode) Then
  Begin
    SetNodeData(Node, FTvData[Node.Index]);
    If FTvData[Node.Index].Item.Count > 0 Then
      InitialStates := InitialStates + [ivsHasChildren];
  End
  Else
  Begin
    If GetNodeData(ParentNode, ISbtpFileIO, lPatch) Then
      SetNodeData(Node, lPatch.Item[Node.Index]);
  End;
end;

end.
