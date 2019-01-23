unit SptbFrm;

interface

uses
  dmImage, TSTOProject.Xml, TSTOSbtpIntf, TSTOSbtp.IO, TSTOHackSettings,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ToolWin, ComCtrls, ExtCtrls, VirtualTrees, StdCtrls, Menus;

type
  TFrmSbtp = class(TForm)
    Splitter1: TSplitter;
    PanInfo: TPanel;
    panToolBar: TPanel;
    tbMain: TToolBar;
    tbSave: TToolButton;
    PanTreeView: TPanel;
    vstSbtpFile: TVirtualStringTree;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label5: TLabel;
    EditVariableName: TEdit;
    EditVariableValue: TEdit;
    popSave: TPopupMenu;
    Save1: TMenuItem;
    SaveAsXml1: TMenuItem;
    tbLoadXml: TToolButton;
    vstSbtpData: TVirtualStringTree;

    procedure FormShow(Sender: TObject);
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

  Private
    FHackSettings : ITSTOHackSettings;
    FTvData       : ISbtpFilesIO;
    FPrevNode     : PVirtualNode;
    FTvVarData    : ISbtpVariable;

    Procedure SetNodeData(ANode : PVirtualNode; ANodeData : IInterface);
    Function  GetNodeData(ANode : PVirtualNode; AId : TGUID; Var ANodeData) : Boolean; OverLoad;
    Function  GetNodeData(ANode : PVirtualNode; AId : TGUID) : Boolean; OverLoad;

  Published
    Property HackSettings : ITSTOHackSettings Read FHackSettings Write FHackSettings;

  end;

implementation

Uses HsZipUtils, HsStreamEx;

{$R *.dfm}

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

procedure TFrmSbtp.FormShow(Sender: TObject);
Var X : Integer;
    lMemStrm : IMemoryStreamEx;
begin
  FPrevNode := Nil;

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
end;

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
  Allowed := (GetNodeData(Node, ISbtpVariable) And (Column = 0)) Or
             (GetNodeData(Node, ISbtpSubVariable) And (Column In [1, 2]));
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
  If GetNodeData(Node, ISbtpVariable, lVarPref) Then
  Begin
    If Column = 0 Then
    Begin
      CellText := lVarPref.VariableType;
      If CellText = '' Then
        CellText := '<None>';
    End;
  End
  Else If GetNodeData(Node, ISbtpSubVariable, lSubVar) Then
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
  If GetNodeData(Node, ISbtpVariable, lData) Then
    ChildCount := lData.SubItem.Count;
end;

procedure TFrmSbtp.vstSbtpDataInitNode(Sender: TBaseVirtualTree; ParentNode,
  Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
begin
//
  If Not Assigned(ParentNode) Then
  Begin
    SetNodeData(Node, FTvVarData);
    If FTvVarData.SubItem.Count > 0 Then
      InitialStates := InitialStates + [ivsHasChildren];
  End
  Else
    SetNodeData(Node, FTvVarData.SubItem[Node.Index]);
end;

procedure TFrmSbtp.vstSbtpDataNewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; NewText: string);
Var lVarPref : ISbtpVariable;
    lSubVar  : ISbtpSubVariable;
begin
  If GetNodeData(Node, ISbtpVariable, lVarPref) Then
  Begin
    If Column = 0 Then
      lVarPref.VariableType := NewText;
  End
  Else If GetNodeData(Node, ISbtpSubVariable, lSubVar) Then
  Begin
    If Column = 1 Then
      lSubVar.VariableName := NewText
    Else If Column = 2 Then
      lSubVar.VariableData := NewText;
  End;
end;

procedure TFrmSbtp.vstSbtpFileFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
Var lVarPref : ISbtpVariable;
begin
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

(*
  If Assigned(FPrevNode) Then
  Begin
    If GetNodeData(FPrevNode, ITSTOSbtpVariable, lVariable) Then
    Try
      lVariable.VariableName := EditVariableName.Text;
      lVariable.DataAsString := EditVariableValue.Text;

      Finally
        lVariable := Nil;
    End;
  End;

  FPrevNode := Node;

  If GetNodeData(FPrevNode, ITSTOSbtpVariable, lVariable) Then
  Try
    EditVariableName.Text  := lVariable.VariableName;
    EditVariableValue.Text := lVariable.DataAsString;

    Finally
      lVariable := Nil;
  End;
*)
end;

procedure TFrmSbtp.vstSbtpFileGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
Var lPatch : ISbtpFileIO;
    lVarPref : ISbtpVariable;
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
