unit CustomPatchFrm;

interface

uses
  dmImage, TSTOProject.Xml, TSTOCustomPatches.IO, TSTOHackSettings,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  VirtualTrees, {$If CompilerVersion = 18.5}VirtualTrees.D2007Types,{$EndIf}
  Dialogs, ComCtrls, ToolWin, StdCtrls, ExtCtrls, Menus, Tabs,
  SynEditHighlighter, SynHighlighterXML, SynEdit, SpTBXExControls, TB2Dock,
  TB2Toolbar, SpTBXItem, TB2Item, SpTBXControls, SpTBXDkPanels, SpTBXTabs;

type
  TFrmCustomPatches = class(TForm)
    PanInfo: TPanel;
    PanTreeView: TPanel;
    popVSTCustomPatches: TPopupMenu;
    popAdd: TMenuItem;
    popDelete: TMenuItem;
    EditXml: TSynEdit;
    SynXMLSyn1: TSynXMLSyn;
    vstPatchData: TSpTBXVirtualStringTree;
    dckTbMain: TSpTBXDock;
    tbMainV2: TSpTBXToolbar;
    tbSave: TSpTBXItem;
    SplitterV2: TSpTBXSplitter;
    gbPatchInfoV2: TSpTBXGroupBox;
    tsXmlV2: TSpTBXTabSet;
    tsOutput: TSpTBXTabItem;
    tsXPathResult: TSpTBXTabItem;
    tsInput: TSpTBXTabItem;
    vstCustomPacthes: TSpTBXVirtualStringTree;
    lblPatchName: TLabel;
    EditPatchName: TEdit;
    lblPatchDesc: TLabel;
    EditPatchDesc: TEdit;
    lblPatchFileName: TLabel;
    EditPatchFileName: TEdit;

    procedure FormCreate(Sender: TObject);
    procedure tbSaveOldClick(Sender: TObject);
    procedure tsXmlV1Change(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);

    procedure vstCustomPacthesInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vstCustomPacthesFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);

    procedure vstPatchDataInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vstPatchDataCreateEditor(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; out EditLink: IVTEditLink);
    procedure vstPatchDataFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vstPatchDataKeyAction(Sender: TBaseVirtualTree;
      var CharCode: Word; var Shift: TShiftState; var DoDefault: Boolean);
    procedure popAddClick(Sender: TObject);
    procedure vstPatchDataAfterCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellRect: TRect);
    procedure tsXmlV2ActiveTabChange(Sender: TObject; TabIndex: Integer);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure vstPatchDataGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vstCustomPacthesGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: string);

  Private
    FProject       : ITSTOXMLProject;
    FHackSettings  : ITSTOHackSettings;
    FCustomPatches : ITSTOCustomPatchesIO;

    FPrevPatch     : PVirtualNode;
    FPrevPatchData : PVirtualNode;

    Procedure SetProject(AProject : ITSTOXMLProject);
    Procedure SetHackSettings(AHackSettings : ITSTOHackSettings);

    Procedure SetNodeData(ANode : PVirtualNode; ANodeData : IInterface);
    Function  GetNodeData(ANode : PVirtualNode; AId : TGUID; Var ANodeData) : Boolean; OverLoad;

    Procedure DisplayXml(APatch : ITSTOCustomPatchIO; AIndex : Integer = -1);

  Published
    Property ProjectFile  : ITSTOXMLProject   Read FProject      Write SetProject;
    Property HackSettings : ITSTOHackSettings Read FHackSettings Write SetHackSettings;

  end;

implementation

Uses SpTBXSkins, TypInfo, XmlDoc, HsXmlDocEx, HsStreamEx, VTEditors, VTCombos,
  TSTOPatches;

{$R *.dfm}

procedure TFrmCustomPatches.FormCreate(Sender: TObject);
Var lTop, lLeft : Integer;
    X : Integer;
    lControl : TControl;
begin
  FPrevPatch     := Nil;
  FPrevPatchData := Nil;
(*
  For X := gbPatchInfoV1.ControlCount - 1 DownTo 0 Do
  Begin
    lControl := gbPatchInfoV1.Controls[X];
    lLeft := lControl.Left;
    lTop  := lControl.Top;
    If lControl Is TLabel Then
    Begin
      lControl := TSpTBXLabel.Create(Self);
      TSpTbxLabel(lControl).Caption := TLabel(gbPatchInfoV1.Controls[X]).Caption;
      lControl.Height := gbPatchInfoV1.Controls[X].Height;
      lControl.Width  := gbPatchInfoV1.Controls[X].Width;
    End;
    lControl.Parent := gbPatchInfoV2;
    lControl.Left := lLeft;
    lControl.Top  := lTop;
  End;
*)
  If SameText(SkinManager.CurrentSkin.SkinName, 'WMP11') Then
  Begin
    vstCustomPacthes.Color := $00262525;
    vstPatchData.Color := $00262525;
    PanTreeView.Color := $00262525;
    PanInfo.Color := $00262525;

    With SkinManager.CurrentSkin Do
      Options(skncListItem, sknsNormal).TextColor := $00F1F1F1;
  End;
end;

procedure TFrmCustomPatches.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #27 Then
  Begin
    Key := #0;
    Close;
  End;
end;

Procedure TFrmCustomPatches.SetProject(AProject : ITSTOXMLProject);
Var lXml : IXmlDocumentEx;
Begin
  lXml := LoadXmlData(AProject.OwnerDocument.Xml.Text);
  Try
    FProject := TTSTOXmlTSTOProject.GetTSTOProject(lXml);
  //  vstCustomPacthes.RootNodeCount := FProject.CustomPatches.Patches.Count;

    Finally
      lXml := Nil;
  End;
End;

Procedure TFrmCustomPatches.SetHackSettings(AHackSettings : ITSTOHackSettings);
Begin
  FHackSettings := AHackSettings;

  If Assigned(FHackSettings) Then
  Begin
    FCustomPatches := TTSTOCustomPatchesIO.CreateCustomPatchIO();
    FCustomPatches.Assign(FHackSettings.CustomPatches);

    vstCustomPacthes.RootNodeCount := FCustomPatches.Patches.Count;
  End;
End;

procedure TFrmCustomPatches.tbSaveOldClick(Sender: TObject);
Var lStrStream : IStringStreamEx;
    lMem       : IMemoryStreamEx;
begin
  If FCustomPatches.Modified Then
  Begin
    lMem := TMemoryStreamEx.Create();
    Try
      FHackSettings.CustomPatches.AsXml := FCustomPatches.AsXml;
      FHackSettings.CustomPatches.ForceChanged();

      Finally
        lMem := Nil;
    End;
  End;

  ModalResult := mrOk;
(*
  If (FProject.CustomPatches.Patches.Count > 0) And
     (FProject.Settings.CustomPatchFileName <> '') Then
  Begin
    lStrStream := TStringStreamEx.Create(FormatXMLData(FProject.CustomPatches.Xml));
    Try
      lStrStream.SaveToFile(FProject.Settings.CustomPatchFileName);

      Finally
       lStrStream := Nil;
    End;
  End;

  ModalResult := mrOk;
*)
end;

procedure TFrmCustomPatches.tsXmlV1Change(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
Var lPatch : ITSTOCustomPatchIO;
begin
  If GetNodeData(FPrevPatch, ITSTOCustomPatchIO, lPatch) Then
    DisplayXml(lPatch, NewTab);
end;

procedure TFrmCustomPatches.tsXmlV2ActiveTabChange(Sender: TObject;
  TabIndex: Integer);
Var lPatch : ITSTOCustomPatchIO;
begin
  If GetNodeData(FPrevPatch, ITSTOCustomPatchIO, lPatch) Then
    DisplayXml(lPatch, TabIndex);
end;

Function TFrmCustomPatches.GetNodeData(ANode : PVirtualNode; AId : TGUID; Var ANodeData) : Boolean;
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

Procedure TFrmCustomPatches.SetNodeData(ANode : PVirtualNode; ANodeData : IInterface);
Var lNodeData : PPointer;
Begin
  lNodeData  := TreeFromNode(ANode).GetNodeData(ANode);
  lNodeData^ := Pointer(ANodeData);
End;

procedure TFrmCustomPatches.popAddClick(Sender: TObject);
begin
//
end;

Procedure TFrmCustomPatches.DisplayXml(APatch : ITSTOCustomPatchIO; AIndex : Integer = -1);
Var lXml   : IXmlDocumentEx;
    lNodes : IXmlNodeListEx;
    X      : Integer;
    lModder : ITSTOModder;
Begin
  EditXml.Lines.Text := '';
  If AIndex = -1 Then
    AIndex := tsXmlV2.ActiveTabIndex;

  If FileExists(FProject.Settings.SourcePath + APatch.FileName) Then
    Case AIndex Of
      0 :
      Begin
        With TStringList.Create() Do
        Try
          LoadFromFile(FProject.Settings.SourcePath + APatch.FileName);
          If Copy(Text, 1, 3) = #$EF#$BB#$BF Then
            Text := Copy(Text, 4, Length(Text));

          EditXml.Lines.Text := FormatXmlData(Text);

          Finally
            Free();
        End;
      End;

      1 :
      Begin
        EditXml.BeginUpdate();
        lXml := LoadXMLDocument(FProject.Settings.SourcePath + APatch.FileName);
        Try
          EditXml.Lines.Text := '';
          For X := 0 To APatch.PatchData.Count - 1 Do
          Begin
            If APatch.PatchData[X].PatchPath <> '' Then
            Begin
              lNodes := lXml.SelectNodes(APatch.PatchData[X].PatchPath);
              If Assigned(lNodes) Then
                With lNodes.Enumerator Do
                  While MoveNext() Do
                    With EditXml.Lines Do
                      Text := Text + FormatXmlData(Current.Xml);
            End;
          End;

          Finally
            lXml := Nil;
            EditXml.EndUpdate();
        End;
      End;

      2 :
      Begin
        EditXml.BeginUpdate();
        lXml := LoadXMLDocument(FProject.Settings.SourcePath + APatch.FileName);
        lModder := TTSTOModder.Create();
        Try
          lModder.PreviewCustomPatches(lXml, APatch.PatchData);
          EditXml.Text := FormatXmlData(lXml.Xml.Text);

          Finally
            lModder := Nil;
            lXml := Nil;
            EditXml.EndUpdate();
        End;
      End;
    End;
End;

procedure TFrmCustomPatches.vstCustomPacthesFocusChanged(
  Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex);
Var lPatch : ITSTOCustomPatchIO;
    lPatchData : ITSTOPatchDataIO;
begin
  If GetNodeData(FPrevPatch, ITSTOCustomPatchIO, lPatch) Then
  Try
    lPatch.PatchName := EditPatchName.Text;
    lPatch.PatchDesc := EditPatchDesc.Text;
    lPatch.FileName  := EditPatchFileName.Text;

    If GetNodeData(FPrevPatchData, ITSTOPatchDataIO, lPatchData) Then
    Try

      Finally
        lPatchData := Nil;
    End;

    Finally
      lPatch := Nil;
  End;

  FPrevPatch := Node;

  If GetNodeData(FPrevPatch, ITSTOCustomPatchIO, lPatch) Then
  Try
    EditPatchName.Text     := lPatch.PatchName;
    EditPatchDesc.Text     := lPatch.PatchDesc;
    EditPatchFileName.Text := lPatch.FileName;

    DisplayXml(lPatch);
    vstPatchData.BeginUpdate();
    Try
      If vstPatchData.IsEditing Then
        vstPatchData.EndEditNode();

      vstPatchData.Clear();
      vstPatchData.RootNodeCount := lPatch.PatchData.Count;

      Finally
        vstPatchData.EndUpdate();
    End;

    FPrevPatchData := Nil;

    Finally
      lPatch := Nil;
  End;
end;

procedure TFrmCustomPatches.vstCustomPacthesGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
Var lNodeData : ITSTOCustomPatchIO;
begin
  If GetNodeData(Node, ITSTOCustomPatchIO, lNodeData) Then
    CellText := lNodeData.PatchName
  Else
    CellText := '';
end;

procedure TFrmCustomPatches.vstCustomPacthesInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
begin
  SetNodeData(Node, FCustomPatches.Patches[Node.Index]);
  //FProject.CustomPatches.Patches[Node.Index]);
end;

(******************************************************************************)

Type
  TVTPatchDataEditor = Class(TInterfacedObject, IVTEditLink)
  Private
    FEdit   : TWinControl;
    FTree   : TCustomVirtualStringTree;//TVirtualStringTree;
    FNode   : PVirtualNode;
    FColumn : Integer;

    Procedure EditKeyDown(Sender : TObject; Var Key : Word; Shift : TShiftState);
    Procedure EditKeyUp(Sender : TObject; Var Key : Word; Shift : TShiftState);

  Protected
    Function BeginEdit() : Boolean; StdCall;
    Function CancelEdit() : Boolean; StdCall;
    Function EndEdit() : Boolean; StdCall;

    Function  GetBounds() : TRect; StdCall;
    Procedure SetBounds(R : TRect); StdCall;

    Function  PrepareEdit(Tree : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex): Boolean; StdCall;
    Procedure ProcessMessage(Var Message: TMessage); StdCall;

  Public
    Destructor Destroy(); OverRide;

  End;

Const
  _PATCH_TYPE : Array[0..3] Of String = (
    'Add Attributes', 'Delete Attributes',
    'Add Nodes', 'Delete Nodes'
  );

Destructor TVTPatchDataEditor.Destroy();
Begin
  If Assigned(FEdit) And FEdit.HandleAllocated Then
    PostMessage(FEdit.Handle, CM_RELEASE, 0, 0);

  InHerited Destroy();
End;

Procedure TVTPatchDataEditor.EditKeyDown(Sender : TObject; Var Key : Word; Shift : TShiftState);
Var CanAdvance : Boolean;
Begin
  Case Key Of
    VK_ESCAPE : Key := 0;

    VK_RETURN :
    Begin
      FTree.EndEditNode();
      Key := 0;
    End;

    VK_UP, VK_DOWN :
    Begin
      CanAdvance := Shift = [];
      If FEdit Is TVirtualStringTreeDropDown Then
        CanAdvance := CanAdvance And Not TVirtualStringTreeDropDown(FEdit).DroppedDown;

      If CanAdvance Then
      Begin
        PostMessage(FTree.Handle, WM_KEYDOWN, Key, 0);
        Key := 0;
      End;
    End;
  End;
End;

Procedure TVTPatchDataEditor.EditKeyUp(Sender : TObject; Var Key : Word; Shift : TShiftState);
Begin
  Case Key Of
    VK_ESCAPE :
    Begin
      FTree.CancelEditNode();
      Key := 0;
    End;
  End;
End;

Function TVTPatchDataEditor.BeginEdit() : Boolean;
Begin
  Result := True;
  FEdit.Show();
  FEdit.SetFocus();
End;

Function TVTPatchDataEditor.CancelEdit() : Boolean;
Begin
  Result := True;
  FEdit.Hide();
  FTree.SetFocus();
End;

Function TVTPatchDataEditor.EndEdit() : Boolean;
Var lPatch : PPointer;
    lPatchData : ITSTOPatchDataIO;
Begin
  Result := True;

  lPatch := FTree.GetNodeData(FNode);
  If Assigned(lPatch) And
     Supports(IInterface(lPatch^), ITSTOPatchDataIO, lPatchData) Then
    Case FColumn Of
      0 : lPatchData.PatchType := TVirtualStringTreeDropDown(FEdit).ItemIndex + 1;
      1 : lPatchData.PatchPath := THsVTEdit(FEdit).Text;
      2 : lPatchData.Code      := TMemo(FEdit).Lines.Text;
    End;

  FEdit.Hide();
  FTree.SetFocus();
End;

Function TVTPatchDataEditor.GetBounds() : TRect;
Begin
  Result := FEdit.BoundsRect;
End;

Type
  TVSTreeAccess = Class(TCustomVirtualStringTree);

Procedure TVTPatchDataEditor.SetBounds(R : TRect);
Var Dummy : Integer;
Begin
  TVSTreeAccess(FTree).Header.Columns.GetColumnBounds(FColumn, Dummy, R.Right);

  If FEdit Is TMemo Then
    R.Bottom := FTree.Height - TVSTreeAccess(FTree).Header.Height;

  FEdit.BoundsRect := R;
End;

Function TVTPatchDataEditor.PrepareEdit(Tree : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex): Boolean;
  Function CreateEdit() : TWinControl;
  Begin
    Result := THsVTEdit.Create(Nil);

    With Result As THsVTEdit Do
    Begin
      Visible   := False;
      Parent    := Tree;
      OnKeyDown := EditKeyDown;
      OnKeyUp   := EditKeyUp;
    End;
  End;

  Function CreateComboBox() : TWinControl;
  Begin
    Result := TVirtualStringTreeDropDown.Create(Nil);

    With Result As TVirtualStringTreeDropDown Do
    Begin
      Visible   := False;
      Parent    := Tree;
      OnKeyDown := EditKeyDown;
      OnKeyUp   := EditKeyUp;
    End;
  End;

  Function CreateMemo() : TWinControl;
  Begin
    Result := TMemo.Create(Nil);

    With Result As TMemo Do
    Begin
      Visible := False;
      Parent  := Tree;
      ScrollBars := ssVertical;
    End;
  End;

Var lNodeData : PPointer;
    lPatchData : ITSTOPatchDataIO;
    X : Integer;
Begin
  Result  := True;
  FTree   := Tree As TCustomVirtualStringTree;//TVirtualStringTree;
  FNode   := Node;
  FColumn := Column;

  If Assigned(FEdit) Then
    FreeAndNil(FEdit);

  lNodeData := FTree.GetNodeData(Node);
  If Assigned(lNodeData) And
     Supports(IInterface(lNodeData^), ITSTOPatchDataIO, lPatchData) Then
    Case Column Of
      0 :
      Begin
        FEdit := CreateComboBox();

        With FEdit As TVirtualStringTreeDropDown Do
        Begin
          For X := Low(_PATCH_TYPE) To High(_PATCH_TYPE) Do
            Items.Add(_PATCH_TYPE[X]);

          ItemIndex := lPatchData.PatchType - 1;
        End;
      End;

      1 :
      Begin
        FEdit := CreateEdit();

        With FEdit As THsVTEdit Do
          Text := lPatchData.PatchPath;
      End;

      2 :
      Begin
        FEdit := CreateMemo();
        With FEdit As TMemo Do
          Lines.Text := lPatchData.Code;
(*##
        FEdit := CreateMemo();

        With FEdit As TMemo Do
          For X := 0 To lPatchData.Code.ChildNodes.Count - 1 Do
            Lines.Add(lPatchData.Code.ChildNodes[X].Xml);
*)
      End;
    End;
End;

Procedure TVTPatchDataEditor.ProcessMessage(Var Message: TMessage);
Begin
  FEdit.WindowProc(Message);
End;

(******************************************************************************)

procedure TFrmCustomPatches.vstPatchDataAfterCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellRect: TRect);

  Function MouseInCell() : Boolean;
  Var lRect : TRect;
      lPt : TPoint;
      lParent : TWinControl;
  Begin
    lRect := TVirtualStringTree(Sender).Header.Columns[Column].GetRect();
    lPt   := Mouse.CursorPos;

    lParent := Sender;
    While Assigned(lParent) Do
    Begin
      Dec(lPt.X, lParent.Left);
      lParent := lParent.Parent;
    End;

    Result := (lPt.X >= lRect.Left) And (lPt.X <= lRect.Right);
  End;

Var lRect : TRect;
    lCurState : TSpTBXSkinStatesType;
    lCellText : String;
    lPatchData : ITSTOPatchDataIO;
begin
  lRect := TVirtualStringTree(Sender).Header.Columns[Column].GetRect();
  TargetCanvas.Brush.Color := TVirtualStringTree(Sender).Color;
  TargetCanvas.Pen.Color   := TargetCanvas.Brush.Color;
  TargetCanvas.Rectangle(CellRect);

  lRect.Top := CellRect.Top;
  lRect.Bottom := CellRect.Bottom;

  With TVirtualStringTree(Sender), TreeOptions Do
    If (Node = FocusedNode) And
       ((Column = Sender.FocusedColumn) Or (toFullRowSelect In SelectionOptions)) Then
    Begin
      If CurrentSkin.Options(skncListItem, sknsChecked).IsEmpty Then
        lCurState := sknsHotTrack
      Else
        lCurState := sknsChecked;
    End
    Else If (Node = HotNode) And
            (MouseInCell() Or (toFullRowSelect In SelectionOptions)) Then
      lCurState := sknsHotTrack
    Else
      lCurState := sknsNormal;

  If (lCurState <> sknsNormal) And
     Not CurrentSkin.Options(skncListItem, lCurState).IsEmpty Then
    CurrentSkin.PaintBackground(
      TargetCanvas, lRect,
      skncListItem, lCurState,
      True, True
    );

  TargetCanvas.Brush.Style := bsClear;
  TargetCanvas.Font.Assign(Sender.Font);
  If CurrentSkin.Options(skncListItem, lCurState).TextColor <> clNone Then
    TargetCanvas.Font.Color := CurrentSkin.Options(skncListItem, lCurState).TextColor;

  lRect.Left := lRect.Left + 8;
  lRect.Top  := (lRect.Bottom - lRect.Top - TargetCanvas.TextHeight('XXX')) Div 2;

  lCellText := '';
  If GetNodeData(Node, ITSTOPatchDataIO, lPatchData) Then
    Case Column Of
      0 : lCellText := _PATCH_TYPE[lPatchData.PatchType - 1];
      1 : lCellText := lPatchData.PatchPath;
      2 : lCellText := lPatchData.Code;
(*##
      2 :
      Begin
        If lPatchData.Code.ChildNodes.Count > 0 Then
          lCellText := lPatchData.Code.ChildNodes[0].Xml;
      End;
*)
    End;

  TargetCanvas.TextOut( lRect.Left, lRect.Top, lCellText );
end;

procedure TFrmCustomPatches.vstPatchDataCreateEditor(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; out EditLink: IVTEditLink);
begin
  EditLink := TVTPatchDataEditor.Create();
end;

procedure TFrmCustomPatches.vstPatchDataFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
begin
  If Sender.IsEditing Then
    Sender.EndEditNode();

  If Assigned(Node) Then
    Sender.EditNode(Node, Column);

  FPrevPatchData := Node;
end;

procedure TFrmCustomPatches.vstPatchDataGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
Var lPatchData : ITSTOPatchDataIO;
begin
  CellText := '';

  If GetNodeData(Node, ITSTOPatchDataIO, lPatchData) Then
    Case Column Of
      0 : CellText := _PATCH_TYPE[lPatchData.PatchType - 1];
      1 : CellText := lPatchData.PatchPath;
      2 : CellText :=  lPatchData.Code;
(*##
      2 :
      Begin
        If lPatchData.Code.ChildNodes.Count > 0 Then
          CellText := lPatchData.Code.ChildNodes[0].Xml;
      End;
*)
    End;
end;

procedure TFrmCustomPatches.vstPatchDataInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
Var lPatch : ITSTOCustomPatchIO;
begin
  If GetNodeData(FPrevPatch, ITSTOCustomPatchIO, lPatch) Then
    SetNodeData(Node, lPatch.PatchData[Node.Index]);
end;

procedure TFrmCustomPatches.vstPatchDataKeyAction(Sender: TBaseVirtualTree;
  var CharCode: Word; var Shift: TShiftState; var DoDefault: Boolean);
Var lPatch : ITSTOCustomPatchIO;
    lPatchData : ITSTOPatchDataIO;
begin
  If CharCode = VK_DOWN Then
  Begin
    If Not Assigned(FPrevPatchData.NextSibling) And
       GetNodeData(FPrevPatch, ITSTOCustomPatchIO, lPatch) Then
    Begin
      lPatchData := lPatch.PatchData.Add();
      lPatchData.PatchType := 1;
      Sender.AddChild(Nil, Pointer(lPatchData));
    End;
  End
  Else If (ssCtrl In Shift) And (CharCode = VK_DELETE) And
          GetNodeData(FPrevPatch, ITSTOCustomPatchIO, lPatch) And
          GetNodeData(FPrevPatchData, ITSTOPatchDataIO, lPatchData) And
          (MessageDlg('Do you want to delete this patch?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) Then
  Begin
    Sender.DeleteNode(FPrevPatchData);
    lPatch.PatchData.Remove(lPatchData);
    FPrevPatchData := Nil;
  End;
end;
//http://www.xnxx.com/video-16n3p42/geile_stiefelschlampen_ficken_sich_gegenseitig
//http://www.xnxx.com/video-611oyc9/two_lesbians_teens_licking_pussy_and_fuck_with_a_dildo
end.
