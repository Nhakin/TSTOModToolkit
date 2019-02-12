unit VTCombos;

interface

{$Define VT60}

Uses
  Windows, Classes, Messages, SysUtils, Forms,
  VTEditors, VirtualTrees
  {$If CompilerVersion = 18.5}{$IfDef VT60}, VirtualTrees.D2007Types{$EndIf}{$EndIf};

Type
  TCustomVirtualStringTreeDropDown = Class(THsVTCustomControlDropDown)
  Strict Private Type
    TVSTDDChild = Class Sealed(TVirtualStringTree)
    Strict Private
      FDropDown : TCustomVirtualStringTreeDropDown;

    Strict Protected
      {$IfDef VT60}
      Procedure DoGetText(Var pEventArgs: TVSTGetCellTextEventArgs); OverRide; Final;
      procedure DoTextDrawing(Var PaintInfo: TVTPaintInfo; Const Text: UnicodeString; CellRect: TRect; DrawFormat: Cardinal); OverRide; Final;
      {$Else}
      Procedure DoGetText(Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; Var Text: UnicodeString); OverRide; Final;
      Procedure DoTextDrawing(Var PaintInfo: TVTPaintInfo; Text: UnicodeString; CellRect: TRect; DrawFormat: Cardinal); OverRide; Final;
      {$EndIf}
      Procedure DoNodeClick(Const HitInfo: THitInfo); OverRide; Final;
      Procedure DoHeaderClick({$IfDef VT60}Const {$EndIf}HitInfo: TVTHeaderHitInfo); OverRide; Final;
      Procedure DoFocusChange(Node: PVirtualNode; Column: TColumnIndex); OverRide; Final;

    Public
      Procedure SelectNode(Node : PVirtualNode);

      Constructor Create(AOwner : TCustomVirtualStringTreeDropDown); ReIntroduce;

    End;

  Strict Private
    FVST : TVSTDDChild;
    FItems : TStringList;
    FDropDownCount : Integer;

    Procedure WMKeyDown(Var Msg: TWMKeyDown); Message WM_KEYDOWN;

    Function  GetItems() : TStrings;
    Procedure SetItems(AStrings : TStrings);

    Function  GetItemIndex() : Integer;
    Procedure SetItemIndex(Const AItemIndex : Integer);

    Procedure OnItemsChange(Sender : TObject);

  Strict Protected
    Procedure InitTreeView(ATreeView : TVirtualStringTree); Virtual;

    Procedure UpdateDropDownSize(); OverRide; Final;

    Property Items         : TStrings Read GetItems       Write SetItems;
    Property DropDownCount : Integer  Read FDropDownCount Write FDropDownCount Default 8;
    Property ItemIndex     : Integer  Read GetItemIndex   Write SetItemIndex;

  Public
    Constructor Create(AOwner : TComponent); OverRide;
    Destructor  Destroy(); OverRide;

  End;

  TVirtualStringTreeDropDown = Class(TCustomVirtualStringTreeDropDown)
  Published
    Property Align;
    Property Anchors;
    Property BevelEdges;
    Property BevelInner;
    Property BevelKind;
    Property BevelOuter;
    Property BevelWidth;
    Property BiDiMode;
    Property BorderStyle;
    Property Color;
    Property Constraints;
    Property Ctl3D;
    Property BorderColor;
    Property FocusBorderColor;

    Property ImeMode;
    Property ImeName;
    Property MaxLength;
    Property ParentBiDiMode;
    Property ParentColor;
    Property ParentCtl3D;
    Property ParentFont;
    Property ParentShowHint;
    Property PopupMenu;
    Property ShowHint;
    Property Visible;

    Property Enabled;
    Property Font;
    Property LabelCaption;
    Property LabelPosition;
    Property LabelMargin;
    Property LabelTransparent;
    Property LabelAlwaysEnabled;
    Property LabelFont;

    Property Text;

    Property DragCursor;
    Property DragKind;
    Property DragMode;
    Property TabStop;
    Property TabOrder;

    Property OnEnter;
    Property OnExit;
    Property OnChange;
    Property OnClick;
    Property OnDblClick;

    Property OnKeyDown;
    Property OnKeyPress;
    Property OnKeyUp;
    {$IFDEF DELPHI2006_LVL}
    Property OnMouseEnter;
    Property OnMouseLeave;
    {$ENDIF}
    Property OnDragDrop;
    Property OnDragOver;
    Property OnEndDrag;

    Property OnBeforeDropDown;
    Property OnDropDown;
    Property OnBeforeDropUp;
    Property OnDropUp;
    Property OnLabelClick;
    Property OnLabelDblClick;

    Property Items;
    Property DropDownCount;
    Property ItemIndex;

  End;

  TCustomVirtualStringTreeGridDropDown = Class(TVirtualStringTreeDropDown)
  Strict Private Type
    TVSTGridSettings = Class Sealed(TPersistent)
    Strict Private
      FTreeView : TVirtualStringTree;

      Function  GetHeaderVisible() : Boolean;
      Procedure SetHeaderVisible(Const AHeaderVisible : Boolean);

      Function  GetColumns() : TVirtualTreeColumns;
      Procedure SetColumns(AColumns : TVirtualTreeColumns);

      Function  GetCheckListMode() : Boolean;
      Procedure SetCheckListMode(Const ACheckListMode : Boolean);

    Published
      Property HeaderVisible : Boolean Read GetHeaderVisible Write SetHeaderVisible Default True;
      Property Columns       : TVirtualTreeColumns Read GetColumns Write SetColumns;
      Property CheckListMode : Boolean Read GetCheckListMode Write SetCheckListMode Default False;

    Public
      Constructor Create(ATreeView : TVirtualStringTree); ReIntroduce;

    End;

  Strict Private
    FSettings : TVSTGridSettings;

    Procedure DoOnInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);

  Strict Protected
    Procedure InitTreeView(ATreeView : TVirtualStringTree); OverRide;

  Published
    Property GridSettings : TVSTGridSettings Read FSettings;

  Public
    Destructor Destroy(); OverRide;

  End;

implementation

{$Warn COMPARING_SIGNED_UNSIGNED Off}
{$Warn COMBINING_SIGNED_UNSIGNED Off}

Constructor TCustomVirtualStringTreeDropDown.TVSTDDChild.Create(AOwner : TCustomVirtualStringTreeDropDown);
Begin
  InHerited Create(AOwner);

  FDropDown := AOwner;
End;

Procedure TCustomVirtualStringTreeDropDown.TVSTDDChild.DoTextDrawing(Var PaintInfo : TVTPaintInfo; {$IfDef VT60}Const {$EndIf}Text : UnicodeString; CellRect : TRect; DrawFormat : Cardinal);
Var lDoDraw : Boolean;
    lInfo : TVTImageInfo;
Begin
  With PaintInfo Do
  Begin
    lDoDraw := True;
    If Assigned(OnDrawText) Then
      OnDrawText(Self, Canvas, Node, Column, Text, CellRect, lDoDraw);

    If lDoDraw Then
    Begin
      If ((HotNode = Node) Or (Node.States * [vsSelected] <> [])) And
         (TreeOptions.PaintOptions * [toHotTrack] <> []) Then
      Begin
        Canvas.Brush.Color := Colors.FocusedSelectionColor;
        Canvas.FillRect(CellRect);

        If (Column > NoColumn) Then
        Begin
          If Header.Columns[Column].CheckBox Then
          Begin
            lInfo.Index := GetCheckImage(Node, ctCheckBox, Node.CheckState);
            lInfo.XPos := (CellRect.Right - CellRect.Left - CheckImages.Width) Div 2;
            lInfo.YPos := (CellRect.Bottom - CellRect.Top - CheckImages.Height) Div 2;
            lInfo.Ghosted := False;
            lInfo.Images := CheckImages;

            PaintCheckImage(Canvas, lInfo, Node.States * [vsSelected] <> []);
          End;
        End;

        Canvas.Font.Color := Colors.SelectionTextColor;
        Canvas.Font.Style := [];
      End;

      CellRect.Left := CellRect.Left + TextMargin;
      Windows.DrawTextW(Canvas.Handle, PWideChar(Text), Length(Text), CellRect, DrawFormat);
    End;
  End;
End;

{$IfDef VT60}
Procedure TCustomVirtualStringTreeDropDown.TVSTDDChild.DoGetText(Var pEventArgs: TVSTGetCellTextEventArgs);
Var lStr : TStringList;
Begin
  With pEventArgs Do
  Begin
    CellText := '';
    lStr := TStringList.Create();
    Try
      ExtractStrings([Char(VK_TAB)], [Char(VK_TAB)], PChar(FDropDown.Items[Node.Index]), lStr);
      If Column = NoColumn Then
        CellText := lStr[0]
      Else If Header.Columns[Header.MainColumn].CheckBox And
              (Column > Header.MainColumn) And
              (Column - 1 < lStr.Count) Then
        CellText := lStr[Column-1]
      Else If Column < lStr.Count Then
        CellText := lStr[Column];

      Finally
        lStr.Free();
    End;
  End;

  InHerited DoGetText(pEventArgs);
End;
{$Else}
Procedure TCustomVirtualStringTreeDropDown.TVSTDDChild.DoGetText(Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; Var Text: UnicodeString);
Var lStr : TStringList;
Begin
  Text := '';
  lStr := TStringList.Create();
  Try
    ExtractStrings([Char(VK_TAB)], [Char(VK_TAB)], PChar(FDropDown.Items[Node.Index]), lStr);
    If Column = NoColumn Then
      Text := lStr[0]
    Else If Header.Columns[Header.MainColumn].CheckBox And
            (Column > Header.MainColumn) And
            (Column - 1 < lStr.Count) Then
      Text := lStr[Column-1]
    Else If Column < lStr.Count Then
      Text := lStr[Column];

    Finally
      lStr.Free();
  End;

  InHerited DoGetText(Node, Column, TextType, Text);
End;
{$EndIf}

Procedure TCustomVirtualStringTreeDropDown.TVSTDDChild.DoNodeClick(Const HitInfo: THitInfo);
Var lNode : PVirtualNode;
    lNbCheck   ,
    lNbChecked : Integer;
Begin
  If HitInfo.HitColumn > NoColumn Then
  Begin
    If Header.Columns[HitInfo.HitColumn].CheckBox Then
    Begin
      lNode := RootNode.FirstChild;
      lNbCheck   := 0;
      lNbChecked := 0;

      While Assigned(lNode) Do
      Begin
        Inc(lNbCheck);
        If lNode.CheckState In [csCheckedNormal, csCheckedPressed] Then
          Inc(lNbChecked);

        lNode := lNode.NextSibling;
      End;

      If lNbCheck = lNbChecked Then
        Header.Columns[HitInfo.HitColumn].CheckState := csCheckedNormal
      Else If lNbChecked = 0 Then
        Header.Columns[HitInfo.HitColumn].CheckState := csUncheckedNormal
      Else
        Header.Columns[HitInfo.HitColumn].CheckState := csMixedPressed;
    End
    Else
      FDropDown.HideDropDown();
  End;

  InHerited DoNodeClick(HitInfo);
End;

Procedure TCustomVirtualStringTreeDropDown.TVSTDDChild.DoHeaderClick({$IfDef VT60}Const {$EndIf}HitInfo: TVTHeaderHitInfo);
Var lNode : PVirtualNode;
Begin
  If HitInfo.Column > NoColumn Then
  Begin
    With Header.Columns[HitInfo.Column] Do
      If CheckBox Then
      Begin
        lNode := RootNode.FirstChild;

        While Assigned(lNode) Do
        Begin
          Case CheckState Of
            csMixedNormal : lNode.CheckState := csCheckedNormal;
            Else
              lNode.CheckState := CheckState;
          End;

          lNode := lNode.NextSibling;
        End;
      End;
  End;

  InHerited DoHeaderClick(HitInfo);
  Invalidate();
End;

Procedure TCustomVirtualStringTreeDropDown.TVSTDDChild.DoFocusChange(Node: PVirtualNode; Column: TColumnIndex);
Begin
  SelectNode(Node);

  InHerited DoFocusChange(Node, Column);
End;

Procedure TCustomVirtualStringTreeDropDown.TVSTDDChild.SelectNode(Node : PVirtualNode);
Var lStr : TStringList;
Begin
  Selected[Node] := True;
  FocusedNode := Node;
  If Assigned(Node) Then
  Begin
    lStr := TStringList.Create();
    Try
      ExtractStrings([Char(VK_TAB)], [], PChar(FDropDown.Items[Node.Index]), lStr);
      FDropDown.Text := lStr[0];

      Finally
        lStr.Free();
    End;
  End
  Else
    FDropDown.Text := '';
End;

Constructor TCustomVirtualStringTreeDropDown.Create(AOwner : TComponent);
Begin
  InHerited Create(AOwner);

  FItems := TStringList.Create();
  FItems.OnChange := OnItemsChange;

  FDropDownCount := 8;

  FVST := TVSTDDChild.Create(Self);
  InitTreeView(FVST);
  Control := FVST;
  DropDownStyle := dsDropDownList;

//  DropDownBorderWidth := 0;
{
  Button.ButtonColor := clBlack;
  Button.ButtonColorHot := clBlack;
  Button.ButtonColorDown := clBlack;
  Button.ButtonBorderColor := clPurple;

  Button.ButtonTextColor := clRed;
  Button.ButtonTextColorHot := clRed;
  Button.ButtonTextColorDown := clRed;
}
End;

Destructor TCustomVirtualStringTreeDropDown.Destroy();
Begin
  FreeAndNil(FItems);
  FreeAndNil(FVST);

  InHerited Destroy();
End;

Procedure TCustomVirtualStringTreeDropDown.UpdateDropDownSize();
Begin
  DropDownForm.Width := Self.Width;
  DropDownForm.Height := FVST.DefaultNodeHeight * FDropDownCount +
                         DropDownBorderWidth * 2 +
                         GetSystemMetrics(SM_CXBORDER) * 2;
End;

Procedure TCustomVirtualStringTreeDropDown.InitTreeView(ATreeView : TVirtualStringTree);
Begin
  ATreeView.DefaultNodeHeight := 14;
  ATreeView.BorderStyle := bsNone;

  With ATreeView.TreeOptions Do
  Begin
    PaintOptions := PaintOptions + [toPopupMode, toHotTrack] - [toShowRoot];
    SelectionOptions := SelectionOptions + [toFullRowSelect, toAlwaysSelectNode];
    MiscOptions := MiscOptions + [toGridExtensions];
  End;

  DropDownForm.Sizeable := False;
End;

Procedure TCustomVirtualStringTreeDropDown.WMKeyDown(Var Msg: TWMKeyDown);
Var lNode : PVirtualNode;
Begin
  InHerited;

  If (GetKeyState(VK_MENU) And $8000 = 0) And Not DroppedDown Then
  Begin
    Case Msg.CharCode Of
      VK_UP :
      Begin
        lNode := FVST.GetFirstSelected();

        If Assigned(lNode) And (lNode.Index > 0) Then
          FVST.SelectNode(lNode.PrevSibling);
      End;

      VK_DOWN :
      Begin
        lNode := FVST.GetFirstSelected();

        If Assigned(lNode) And (lNode.Index < FItems.Count - 1) Then
          FVST.SelectNode(lNode.NextSibling);
      End;
    End;
  End;
End;

Function TCustomVirtualStringTreeDropDown.GetItems() : TStrings;
Begin
  Result := FItems;
End;

Procedure TCustomVirtualStringTreeDropDown.SetItems(AStrings : TStrings);
Begin
  FItems.Assign(AStrings);
End;

Function TCustomVirtualStringTreeDropDown.GetItemIndex() : Integer;
Var lNode : PVirtualNode;
Begin
  lNode := FVST.GetFirstSelected();

  If Assigned(lNode) Then
    Result := lNode.Index
  Else
    Result := -1;
End;

Procedure TCustomVirtualStringTreeDropDown.SetItemIndex(Const AItemIndex : Integer);
Var lNode : PVirtualNode;
Begin
  If AItemIndex = -1 Then
    FVST.SelectNode(Nil)
  Else If AItemIndex < FItems.Count Then
  Begin
    lNode := FVST.GetFirstSelected();
    If Not Assigned(lNode) Then
      lNode := FVST.RootNode.FirstChild;

    While Assigned(lNode) Do
    Begin
      If lNode.Index = AItemIndex Then
      Begin
        FVST.SelectNode(lNode);
        lNode := Nil;
      End
      Else If lNode.Index < AItemIndex Then
        lNode := lNode.NextSibling
      Else If lNode.Index > AItemIndex Then
        lNode := lNode.PrevSibling;
    End;
  End;
End;

Procedure TCustomVirtualStringTreeDropDown.OnItemsChange(Sender : TObject);
Begin
  FVST.RootNodeCount := FItems.Count;
End;

Constructor TCustomVirtualStringTreeGridDropDown.TVSTGridSettings.Create(ATreeView : TVirtualStringTree);
Begin
  InHerited Create();

  FTreeView := ATreeView;

  HeaderVisible := True;
  CheckListMode := False;
End;

Function TCustomVirtualStringTreeGridDropDown.TVSTGridSettings.GetHeaderVisible() : Boolean;
Begin
  Result := FTreeView.Header.Options * [hoVisible] <> [];
End;

Procedure TCustomVirtualStringTreeGridDropDown.TVSTGridSettings.SetHeaderVisible(Const AHeaderVisible : Boolean);
Begin
  If AHeaderVisible Then
    FTreeView.Header.Options := FTreeView.Header.Options + [hoVisible]
  Else
    FTreeView.Header.Options := FTreeView.Header.Options - [hoVisible];
End;

Function TCustomVirtualStringTreeGridDropDown.TVSTGridSettings.GetColumns() : TVirtualTreeColumns;
Begin
  Result := FTreeView.Header.Columns;
End;

Procedure TCustomVirtualStringTreeGridDropDown.TVSTGridSettings.SetColumns(AColumns : TVirtualTreeColumns);
Begin
  FTreeView.Header.Columns := AColumns;
End;

Function TCustomVirtualStringTreeGridDropDown.TVSTGridSettings.GetCheckListMode() : Boolean;
Begin
  Result := FTreeView.Header.Columns[0].Options * [coVisible] <> [];
End;

Procedure TCustomVirtualStringTreeGridDropDown.TVSTGridSettings.SetCheckListMode(Const ACheckListMode : Boolean);
Begin
  If ACheckListMode Then
    FTreeView.Header.Columns[0].Options := FTreeView.Header.Columns[0].Options + [coVisible]
  Else
    FTreeView.Header.Columns[0].Options := FTreeView.Header.Columns[0].Options - [coVisible];
End;

Destructor TCustomVirtualStringTreeGridDropDown.Destroy();
Begin
  FreeAndNil(FSettings);

  InHerited Destroy();
End;

Procedure TCustomVirtualStringTreeGridDropDown.DoOnInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
Begin
  Node.CheckType := ctCheckBox;
End;

Procedure TCustomVirtualStringTreeGridDropDown.InitTreeView(ATreeView : TVirtualStringTree);
Begin
  InHerited InitTreeView(ATreeView);

  With ATreeView.Header Do
  Begin
    With Columns.Add() Do
    Begin
      MinWidth := 25;
      MaxWidth := 25;
      Options := Options - [coDraggable, coResizable, coVisible];
      CheckBox := True;
      CheckType := ctTriStateCheckBox;
      CheckState := csUncheckedNormal;
    End;

    MainColumn := 0;
    AutoSizeIndex := 0;
    Options := Options + [hoVisible, hoAutoResize, hoShowImages];
  End;

  With ATreeView.TreeOptions Do
  Begin
    PaintOptions := PaintOptions + [toFullVertGridLines, toShowVertGridLines, toShowHorzGridLines] - [toHotTrack];
    MiscOptions := MiscOptions + [toCheckSupport];
  End;

  ATreeView.DefaultNodeHeight := 20;
  ATreeView.OnInitNode := DoOnInitNode;

  FSettings := TVSTGridSettings.Create(ATreeView);

  DropDownForm.Sizeable := True;
End;

end.
