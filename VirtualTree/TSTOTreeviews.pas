unit TSTOTreeviews;

interface

Uses Windows, Classes, ImgList, Graphics, VirtualTrees, Messages,
  SpTBXExControls, SpTBXSkins, HsInterfaceEx,
  TSTOPackageList, TSTOProject.Xml, TSTOCustomPatches.IO, TSTODlcIndex,
  TSTOSbtp.IO, TSTOProjectWorkSpace.IO, TSTORessource, TSTOProjectWorkSpaceIntf,
  TSTOScriptTemplate.IO//, TSTOScriptTemplateIntf
  {$If CompilerVersion = 18.5}, VirtualTrees.D2007Types{$EndIf};

Type
  TTSTOBaseTreeView = Class(TSpTBXVirtualStringTree)
  Protected
    Procedure WMSpSkinChange(Var Message: TMessage); Message WM_SPSKINCHANGE;
    Function  DebugEnabled() : Boolean; Virtual;

    Function  GetIsDebugMode() : Boolean; Virtual;
    Procedure SetIsDebugMode(Const AIsDebugMode : Boolean); Virtual;

  Public
    Property IsDebugMode : Boolean Read GetIsDebugMode Write SetIsDebugMode;

    Procedure SetNodeData(ANode : PVirtualNode; ANodeData : IInterface);
    Function  GetNodeData(ANode : PVirtualNode; AId : TGUID; Var ANodeData) : Boolean; OverLoad;
    Function  GetNodeData(ANode : PVirtualNode; AId : TGUID) : Boolean; OverLoad;

    Constructor Create(AOwner : TComponent); OverRide;

  End;

  TTSTODlcServerTreeView = Class(TTSTOBaseTreeView)
  Private
    FTSTOProject : Pointer;
    FTvData      : ITSTOPlatformPackageNodes;

    Function  GetTSTOProject() : ITSTOXMLProject;
    Procedure SetTSTOProject(ATSTOProject : ITSTOXMLProject);

  Protected
    Procedure DoChecked(Node : PVirtualNode); OverRide;
    Function  DoCompare(Node1, Node2 : PVirtualNode; Column : TColumnIndex) : Integer; OverRide;
    Function  DoExpanding(Node : PVirtualNode) : Boolean; OverRide;
    {$IfDef VT60}
    Function  DoGetImageIndex(Node : PVirtualNode; Kind : TVTImageKind; Column : TColumnIndex;
      Var Ghosted : Boolean; Var Index : TImageIndex): TCustomImageList; OverRide;
    Procedure DoGetText(Var pEventArgs : TVSTGetCellTextEventArgs); OverRide;
    {$Else}
    Function  DoGetImageIndex(Node : PVirtualNode; Kind : TVTImageKind; Column : TColumnIndex;
      Var Ghosted : Boolean; Var Index : Integer): TCustomImageList; OverRide;
    Procedure DoGetText(Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      Var Text: UnicodeString); OverRide;
    {$EndIf}
    Function  DoInitChildren(Node: PVirtualNode; Var ChildCount : Cardinal) : Boolean; OverRide;
    Procedure DoInitNode(Parent, Node : PVirtualNode; Var InitStates : TVirtualNodeInitStates); OverRide;
    Procedure DoPaintText(Node : PVirtualNode; Const Canvas : TCanvas; Column : TColumnIndex;
      TextType : TVSTTextType); OverRide;

  Public
    Property TSTOProject : ITSTOXMLProject Read GetTSTOProject Write SetTSTOProject;

    Procedure LoadData(Const AFileName : String); OverLoad;
    Procedure LoadData(APackage : ITSTOXmlDlcIndex); OverLoad;
    Procedure LoadData(); OverLoad;
    Procedure SelectMissingPackage();

    Constructor Create(AOwner : TComponent); OverRide;
    Destructor  Destroy(); OverRide;

  End;

  TTSTOWorkSpaceTreeView = Class(TTSTOBaseTreeView)
  Private
    FTvData : ITSTOWorkSpaceProjectGroupIO;

    Function  GetTvData() : ITSTOWorkSpaceProjectGroupIO;
    Procedure SetTvData(ATvData : ITSTOWorkSpaceProjectGroupIO);

  Protected
    {$IfDef VT60}
    Function  DoGetImageIndex(Node : PVirtualNode; Kind : TVTImageKind; Column : TColumnIndex;
      Var Ghosted : Boolean; Var Index : TImageIndex): TCustomImageList; OverRide;
    Procedure DoGetText(Var pEventArgs : TVSTGetCellTextEventArgs); OverRide;
    {$Else}
    Function  DoGetImageIndex(Node : PVirtualNode; Kind : TVTImageKind; Column : TColumnIndex;
      Var Ghosted : Boolean; Var Index : Integer): TCustomImageList; OverRide;
    Procedure DoGetText(Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      Var Text: UnicodeString); OverRide;
    {$EndIf}
    Function  DoInitChildren(Node: PVirtualNode; Var ChildCount : Cardinal) : Boolean; OverRide;
    Procedure DoInitNode(Parent, Node : PVirtualNode; Var InitStates : TVirtualNodeInitStates); OverRide;

    Function DoKeyAction(var CharCode: Word; var Shift: TShiftState): Boolean; OverRide;

  Public
    Property TvData : ITSTOWorkSpaceProjectGroupIO Read GetTvData Write SetTvData;

    Procedure MoveNodeUp(ANode : PVirtualNode);
    Procedure MoveNodeDown(ANode : PVirtualNode);

    Procedure LoadData();

  End;

  TTSTOSbtpFileTreeView = Class(TTSTOBaseTreeView)
  Private
    FTvData : ISbtpFileIO;

    Function  GetTvData() : ISbtpFileIO;
    Procedure SetTvData(ATvData : ISbtpFileIO);

  Protected
    Procedure DoAdvancedHeaderDraw(Var PaintInfo: THeaderPaintInfo; Const Elements: THeaderPaintElements); OverRide;
    Function  DoCompare(Node1, Node2 : PVirtualNode; Column : TColumnIndex) : Integer; OverRide;
    {$IfDef VT60}
    Procedure DoGetText(Var pEventArgs : TVSTGetCellTextEventArgs); OverRide;
    Procedure DoHeaderClick(Const HitInfo: TVTHeaderHitInfo); OverRide;
    {$Else}
    Procedure DoGetText(Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      Var Text: UnicodeString); OverRide;
    Procedure DoHeaderClick(HitInfo: TVTHeaderHitInfo); OverRide;
    {$EndIf}
    Procedure DoHeaderDrawQueryElements(Var PaintInfo : THeaderPaintInfo; Var Elements : THeaderPaintElements); OverRide;
    Function  DoInitChildren(Node: PVirtualNode; Var ChildCount : Cardinal) : Boolean; OverRide;
    Procedure DoInitNode(Parent, Node : PVirtualNode; Var InitStates : TVirtualNodeInitStates); OverRide;

  Public
    Property TvData : ISbtpFileIO Read GetTvData Write SetTvData;

    Constructor Create(AOwner : TComponent); OverRide;

  End;

  TTSTOCustomPatchesTreeView = Class(TTSTOBaseTreeView)
  Private
    FTvData : Pointer;

    Function  GetTvData() : ITSTOCustomPatchListIO;
    Procedure SetTvData(ATvData : ITSTOCustomPatchListIO);

  Protected
    Procedure DoChecked(Node : PVirtualNode); OverRide;
    {$IfDef VT60}
    Procedure DoGetText(Var pEventArgs : TVSTGetCellTextEventArgs); OverRide;
    {$Else}
    Procedure DoGetText(Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      Var Text: UnicodeString); OverRide;
    {$EndIf}
    Procedure DoInitNode(Parent, Node : PVirtualNode; Var InitStates : TVirtualNodeInitStates); OverRide;

  Public
    Property TvData : ITSTOCustomPatchListIO Read GetTvData Write SetTvData;

    Procedure LoadData();

    Constructor Create(AOwner : TComponent); OverRide;

  End;

  TTSTORessourcesTreeView = Class(TTSTOBaseTreeView)
  Private
    FTvData : Pointer;

    Function  GetTvData() : ITSTOResourcePaths;
    Procedure SetTvData(ATvData : ITSTOResourcePaths);

    Procedure DoSetNodeExpandState(Sender : TBaseVirtualTree; Node : PVirtualNode; Data : Pointer; Var Abort : Boolean);
    Procedure DoCompare(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode;
      Column: TColumnIndex; var Result: Integer);

  Protected
    Procedure DoGetText(Var pEventArgs : TVSTGetCellTextEventArgs); OverRide;
    Function  DoGetImageIndex(Node : PVirtualNode; Kind : TVTImageKind; Column : TColumnIndex;
      Var Ghosted : Boolean; Var Index : TImageIndex): TCustomImageList; OverRide;
    Procedure DoInitNode(Parent, Node : PVirtualNode; Var InitStates : TVirtualNodeInitStates); OverRide;
    Function  DoInitChildren(Node: PVirtualNode; Var ChildCount : Cardinal) : Boolean; OverRide;

  Public
    Property TvData : ITSTOResourcePaths Read GetTvData Write SetTvData;

    Procedure LoadData();

    Procedure ExpandAllNodes();
    Procedure CollapseAllNodes();

    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;

  End;

  TTSTORemoveFileTreeView = Class(TTSTOBaseTreeView)
  Private
    FTvData : Pointer;

    Function  GetTvData() : ITSTOWorkSpaceProjectSrcFiles;
    Procedure SetTvData(ATvData : ITSTOWorkSpaceProjectSrcFiles);

  Protected
    Procedure DoInitNode(Parent, Node : PVirtualNode; Var InitStates : TVirtualNodeInitStates); OverRide;
    Procedure DoGetText(Var pEventArgs : TVSTGetCellTextEventArgs); OverRide;

  Public
    Property TvData : ITSTOWorkSpaceProjectSrcFiles Read GetTvData Write SetTvData;

    Procedure LoadData();

    Function GetSelectedItems() : ITSTOWorkSpaceProjectSrcFiles;

    Constructor Create(AOwner : TComponent); OverRide;

  End;

  TTSTOScriptTemplateTreeView = Class(TTSTOBaseTreeView)
  Private
    FTvData : Pointer;

    Function  GetTvData() : ITSTOScriptTemplateHacksIO;
    Procedure SetTvData(ATvData : ITSTOScriptTemplateHacksIO);

  Protected
    Procedure DoInitNode(Parent, Node : PVirtualNode; Var InitStates : TVirtualNodeInitStates); OverRide;
    Procedure DoGetText(Var pEventArgs : TVSTGetCellTextEventArgs); OverRide;
    Procedure DoCanEdit(Node : PVirtualNode; Column : TColumnIndex; Var Allowed: Boolean); OverRide;
    Procedure DoNewText(Node : PVirtualNode; Column : TColumnIndex; Const Text: String); OverRide;
    Procedure DoChecked(Node : PVirtualNode); OverRide;

  Public
    Property TvData : ITSTOScriptTemplateHacksIO Read GetTvData Write SetTvData;

    Procedure LoadData();

    Constructor Create(AOwner : TComponent); OverRide;

  End;

  TTSTOScriptTemplateSettingsTreeView = Class(TTSTOBaseTreeView)
  Private Type
    ISTSetting = Interface(IInterfaceEx)
      ['{4B61686E-29A0-2112-97E5-26C02CC207EB}']
      Function  GetPropertyName() : WideString;
      Procedure SetPropertyName(Const APropertyName : WideString);

      Function  GetPropertyValue() : WideString;
      Procedure SetPropertyValue(Const APropertyValue : WideString);

      Function  GetOnChanged() : TNotifyEvent;
      Procedure SetOnChanged(AOnChanged : TNotifyEvent);

      Property PropertyName  : WideString   Read GetPropertyName  Write SetPropertyName;
      Property PropertyValue : WideString   Read GetPropertyValue Write SetPropertyValue;
      Property OnChanged     : TNotifyEvent Read GetOnChanged     Write SetOnChanged;

    End;

    ISTSettings = Interface(IInterfaceListEx)
      ['{4B61686E-29A0-2112-B08E-1877E46B2900}']
      Function  Get(Index : Integer) : ISTSetting;
      Procedure Put(Index : Integer; Const Item : ISTSetting);

      Function Add() : ISTSetting; OverLoad;
      Function Add(Const AItem : ISTSetting) : Integer; OverLoad;

      Function IndexOf(Const ASettingName : String) : Integer;

      Property Items[Index : Integer] : ISTSetting Read Get Write Put; Default;

    End;

  Private
    FTvData : Pointer;
    FSettings : ISTSettings;

    Function  GetTvData() : ITSTOScriptTemplateHackIO;
    Procedure SetTvData(ATvData : ITSTOScriptTemplateHackIO);

  Protected
    Procedure DoInitNode(Parent, Node : PVirtualNode; Var InitStates : TVirtualNodeInitStates); OverRide;
    Procedure DoGetText(Var pEventArgs : TVSTGetCellTextEventArgs); OverRide;
    Procedure DoCanEdit(Node : PVirtualNode; Column : TColumnIndex; Var Allowed: Boolean); OverRide;
    Procedure DoFocusChange(Node : PVirtualNode; Column : TColumnIndex); OverRide;
    Procedure DoNewText(Node : PVirtualNode; Column : TColumnIndex; Const Text : String); OverRide;

  Public
    Property TvData : ITSTOScriptTemplateHackIO Read GetTvData Write SetTvData;

    Procedure LoadData();

    Constructor Create(AOwner : TComponent); OverRide;

  End;

  TTSTOScriptTemplateVariablesTreeView = Class(TTSTOBaseTreeView)
  Private
    FTvData : Pointer;

    Function  GetTvData() : ITSTOScriptTemplateVariablesIO;
    Procedure SetTvData(ATvData : ITSTOScriptTemplateVariablesIO);

  Protected
    Function  GetIsDebugMode() : Boolean; OverRide;
    Procedure SetIsDebugMode(Const AIsDebugMode : Boolean); OverRide;

    Procedure DoInitNode(Parent, Node : PVirtualNode; Var InitStates : TVirtualNodeInitStates); OverRide;
    Procedure DoGetText(Var pEventArgs : TVSTGetCellTextEventArgs); OverRide;
    Procedure DoCanEdit(Node : PVirtualNode; Column : TColumnIndex; Var Allowed: Boolean); OverRide;
    Function  DoCreateEditor(Node: PVirtualNode; Column: TColumnIndex): IVTEditLink; OverRide;
    Procedure DoFocusChange(Node : PVirtualNode; Column : TColumnIndex); OverRide;

  Public
    Property TvData : ITSTOScriptTemplateVariablesIO Read GetTvData Write SetTvData;

    Procedure LoadData();

    Constructor Create(AOwner : TComponent); OverRide;

  End;

implementation

Uses SysUtils, Controls, TypInfo,
  HsZipUtils, HsStreamEx, HsXmlDocEx, VTEditors, VTCombos,
  TSTOModToolKit, TSTOZero.Bin, TSTOBsv.IO, TSTORgb, TSTOSbtpIntf,
  TSTOProjectWorkSpaceImpl, TSTOScriptTemplateTypes;

Type
  PInterface = ^IInterface;

  TCustomTSTOVTEditor = Class(TInterfacedObject, IVTEditLink)
  Private
    FEdit   : TWinControl;
    FTree   : TTSTOBaseTreeView;
    FNode   : PVirtualNode;
    FColumn : Integer;

    Procedure EditKeyDown(Sender : TObject; Var Key : Word; Shift : TShiftState);
    Procedure EditKeyUp(Sender : TObject; Var Key : Word; Shift : TShiftState);

  Protected
    Function CreateEdit(ATree : TBaseVirtualTree) : TWinControl;
    Function CreateComboBox(ATree : TBaseVirtualTree) : TWinControl;

    Function BeginEdit() : Boolean; StdCall;
    Function CancelEdit() : Boolean; StdCall;
    Function EndEdit() : Boolean; Virtual; StdCall; Abstract;
    Function PrepareEdit(Tree : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex): Boolean; Virtual; StdCall; Abstract;

    Function  GetBounds() : TRect; StdCall;
    Procedure SetBounds(R : TRect); StdCall;

    Procedure ProcessMessage(Var Message: TMessage); StdCall;

  Public
    Destructor Destroy(); OverRide;

  End;

Destructor TCustomTSTOVTEditor.Destroy();
Begin
  If Assigned(FEdit) And FEdit.HandleAllocated Then
    PostMessage(FEdit.Handle, CM_RELEASE, 0, 0);

  InHerited Destroy();
End;

Function TCustomTSTOVTEditor.CreateEdit(ATree : TBaseVirtualTree) : TWinControl;
Begin
  Result := THsVTEdit.Create(Nil);

  With Result As THsVTEdit Do
  Begin
    Visible   := False;
    Parent    := ATree;
    OnKeyDown := EditKeyDown;
    OnKeyUp   := EditKeyUp;
  End;
End;

Function TCustomTSTOVTEditor.CreateComboBox(ATree : TBaseVirtualTree) : TWinControl;
Begin
  Result := TVirtualStringTreeDropDown.Create(Nil);

  With Result As TVirtualStringTreeDropDown Do
  Begin
    Visible   := False;
    Parent    := ATree;
    OnKeyDown := EditKeyDown;
    OnKeyUp   := EditKeyUp;
  End;
End;

Procedure TCustomTSTOVTEditor.EditKeyDown(Sender : TObject; Var Key : Word; Shift : TShiftState);
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

Procedure TCustomTSTOVTEditor.EditKeyUp(Sender : TObject; Var Key : Word; Shift : TShiftState);
Begin
  Case Key Of
    VK_ESCAPE :
    Begin
      FTree.CancelEditNode();
      Key := 0;
    End;
  End;
End;

Function TCustomTSTOVTEditor.BeginEdit() : Boolean;
Begin
  Result := True;
  FEdit.Show();
  FEdit.SetFocus();
End;

Function TCustomTSTOVTEditor.CancelEdit() : Boolean;
Begin
  Result := True;
  FEdit.Hide();
  FTree.SetFocus();
End;

Function TCustomTSTOVTEditor.GetBounds() : TRect;
Begin
  Result := FEdit.BoundsRect;
End;

Type
  TVSTreeAccess = Class(TCustomVirtualStringTree);

Procedure TCustomTSTOVTEditor.SetBounds(R : TRect);
Var Dummy : Integer;
Begin
  TVSTreeAccess(FTree).Header.Columns.GetColumnBounds(FColumn, Dummy, R.Right);
  FEdit.BoundsRect := R;
End;

Procedure TCustomTSTOVTEditor.ProcessMessage(Var Message: TMessage);
Begin
  FEdit.WindowProc(Message);
End;

(******************************************************************************)

Constructor TTSTOBaseTreeView.Create(AOwner : TComponent);
Begin
  InHerited Create(AOwner);

  With TreeOptions Do
    PaintOptions := PaintOptions + [toPopupMode, toHotTrack];

  Header.Options := Header.Options + [hoAutoResize];
  Header.Columns.Add();
  With Header.Columns.Add() Do
    Options := Options - [coVisible];
  Header.AutoSizeIndex := 0;
End;

Procedure TTSTOBaseTreeView.WMSpSkinChange(Var Message: TMessage);
Begin
  InHerited;

  If SameText(SkinManager.CurrentSkin.SkinName, 'WMP11') Then
  Begin
    Color := $00262525;
    With SkinManager.CurrentSkin Do
      Options(skncListItem, sknsNormal).TextColor := $00F1F1F1;
  End
  Else
  Begin
    Color := clWindow;
    With SkinManager.CurrentSkin Do
      Options(skncListItem, sknsNormal).TextColor := clWindowText;
  End;
End;

Function  TTSTOBaseTreeView.DebugEnabled() : Boolean;
Begin
  Result := False;
End;

Function TTSTOBaseTreeView.GetIsDebugMode() : Boolean;
Begin
  Result := Header.Options * [hoVisible] <> [];
End;

Procedure TTSTOBaseTreeView.SetIsDebugMode(Const AIsDebugMode : Boolean);
Begin
  If IsDebugMode <> AIsDebugMode Then
  Begin
    If AIsDebugMode Then
    Begin
      Header.Options := Header.Options + [hoVisible];
      Header.Columns[Header.Columns.Count - 1].Options :=
        Header.Columns[Header.Columns.Count - 1].Options + [coVisible];
      Header.AutoSizeIndex := Header.Columns.Count - 1;
    End
    Else
    Begin
      Header.Options := Header.Options - [hoVisible];
      Header.Columns[Header.Columns.Count - 1].Options :=
        Header.Columns[Header.Columns.Count - 1].Options - [coVisible];
      Header.AutoSizeIndex := Header.Columns.Count - 2;
    End;
  End;
End;

Procedure TTSTOBaseTreeView.SetNodeData(ANode : PVirtualNode; ANodeData : IInterface);
Var lNodeData : PPointer;
Begin
  lNodeData  := GetNodeData(ANode);
  lNodeData^ := Pointer(ANodeData);
End;

Function TTSTOBaseTreeView.GetNodeData(ANode : PVirtualNode; AId : TGUID; Var ANodeData) : Boolean;
Var lNodeData : PPointer;
Begin
  If Assigned(ANode) Then
  Begin
    lNodeData := InHerited GetNodeData(ANode);
    Result := Assigned(lNodeData) And Assigned(lNodeData^) And
              Supports(IInterface(lNodeData^), AId, ANodeData);
  End
  Else
    Result := False;
End;

Function TTSTOBaseTreeView.GetNodeData(ANode : PVirtualNode; AId : TGUID) : Boolean;
Var lDummy : IInterface;
Begin
  Result := GetNodeData(ANode, AId, lDummy);
End;

(******************************************************************************)

Constructor TTSTODlcServerTreeView.Create(AOwner : TComponent);
Begin
  InHerited Create(AOwner);

  With TreeOptions Do
    MiscOptions := MiscOptions + [toCheckSupport];
End;

Destructor TTSTODlcServerTreeView.Destroy();
Begin
  FTvData := Nil;

  InHerited Destroy();
End;

Procedure TTSTODlcServerTreeView.DoPaintText(Node : PVirtualNode; Const Canvas : TCanvas; Column : TColumnIndex;
  TextType : TVSTTextType);
Var lPkg : ITSTOPackageNode;
Begin
  If (Column = 0) And GetNodeData(Node, ITSTOPackageNode, lPkg) And lPkg.FileExist Then
    Canvas.Font.Style := [fsBold];

  InHerited DoPaintText(Node, Canvas, Column, TextType);
End;

Function TTSTODlcServerTreeView.GetTSTOProject() : ITSTOXMLProject;
Begin
  Result := ITSTOXMLProject(FTSTOProject);
End;

Procedure TTSTODlcServerTreeView.SetTSTOProject(ATSTOProject : ITSTOXMLProject);
Begin
  FTSTOProject := Pointer(ATSTOProject);
  LoadData();
End;

Procedure TTSTODlcServerTreeView.LoadData(Const AFileName : String);
Var lStrStream : IStringStreamEx;
    lZip       : IHsMemoryZipper;
    lDlcIndex  : ITSTOXmlDlcIndex;
Begin
  If FileExists(AFileName) Then
  Begin
    lZip := THsMemoryZipper.Create();
    lStrStream := TStringStreamEx.Create();
    Try
      lZip.LoadFromFile(AFileName);
      lZip.ExtractToStream(lZip[0].FileName, lStrStream);

      lDlcIndex := GetDlcIndex(LoadXmlData(lStrStream.DataString));
      LoadData(lDlcIndex);

      Finally
        lZip := Nil;
        lStrStream := Nil;
        lDlcIndex := Nil;
    End;
  End;
End;

Procedure TTSTODlcServerTreeView.LoadData(APackage : ITSTOXmlDlcIndex);
Begin
  FTvData := TTSTOPlatformPackageNodes.Create();

  BeginUpdate();
  Try
    Clear();

    If Assigned(APackage) Then
    Begin
      FTvData.Load(APackage.OwnerDocument.Xml.Text);
      RootNodeCount := FTvData.Count;
    End;

    Finally
      EndUpdate();
  End;
End;

Procedure TTSTODlcServerTreeView.LoadData();
Begin
  With TTSTODlcGenerator.Create() Do
  Try
    LoadData(GetIndexPackage(TSTOProject));

    Finally
      Free();
  End;
End;

Procedure TTSTODlcServerTreeView.SelectMissingPackage();
Var lNode     : PVirtualNode;
    lTierItem : ITSTOTierPackageNode;
    lItem     : ITSTOPackageNode;
begin
  lNode := GetFirstSelected();

  If GetNodeData(lNode, ITSTOTierPackageNode, lTierItem) Then
  Try
    If (lTierItem.Packages.Count > 0) And (lNode.ChildCount = 0) Then
      ReinitChildren(lNode, False);

    lNode := lNode.FirstChild;
    While Assigned(lNode) Do
    Begin
      If GetNodeData(lNode, ITSTOPackageNode, lItem) Then
      Try
        If Not lItem.FileExist Then
          CheckState[lNode] := csCheckedNormal;

        Finally
          lItem := Nil;
      End;


      lNode := lNode.NextSibling;
    End;

    Finally
      lTierItem := Nil;
  End;
End;

Procedure TTSTODlcServerTreeView.DoChecked(Node : PVirtualNode);
  Procedure DoRecursiveCheck(AStartPoint : PVirtualNode; ACheckState : TCheckState);
  Begin
    While Assigned(AStartPoint) Do
    Begin
      AStartPoint.CheckState := ACheckState;
      DoRecursiveCheck(AStartPoint.FirstChild, ACheckState);
      AStartPoint := AStartPoint.NextSibling;
    End;
  End;
//IPlatformPackageNode -> ITierPackageNode
Var lNode : PVirtualNode;
Begin
  If (Node.States * [vsHasChildren] <> []) And (Node.ChildCount = 0) Then
  Begin
    ReinitChildren(Node, False);
    If GetNodeData(Node, ITSTOPlatformPackageNode) Then
    Begin
      lNode := Node.FirstChild;

      While Assigned(lNode) Do
      Begin
        ReInitChildren(lNode, False);
        lNode := lNode.NextSibling;
      End;
    End;

    DoRecursiveCheck(Node.FirstChild, Node.CheckState);
  End;
End;

Function TTSTODlcServerTreeView.DoCompare(Node1, Node2 : PVirtualNode; Column : TColumnIndex) : Integer;
Var lPkg1, lPkg2 : ITSTOPackageNode;
    lFile1, lFile2 : IBinArchivedFileData;
    lPlatform1, lPlatform2 : ITSTOPlatformPackageNode;
Begin
  If GetNodeData(Node1, ITSTOPlatformPackageNode, lPlatform1) And
     GetNodeData(Node2, ITSTOPlatformPackageNode, lPlatform2) Then
    Result := CompareText(lPlatform1.PlatformName, lPlatform2.PlatformName)
  Else If GetNodeData(Node1, ITSTOPackageNode, lPkg1) And
          GetNodeData(Node2, ITSTOPackageNode, lPkg2) Then
    Result := CompareText(ExtractFileName(lPkg1.FileName), ExtractFileName(lPkg2.FileName))
  Else If GetNodeData(Node1, IBinArchivedFileData, lFile1) And
          GetNodeData(Node2, IBinArchivedFileData, lFile2) Then
    Result := CompareText(lFile1.FileName1, lFile2.FileName1)
  Else
    Result := 0;
End;

Function TTSTODlcServerTreeView.DoExpanding(Node : PVirtualNode) : Boolean;
Begin
  If GetNodeData(Node, ITSTOTierPackageNode) Or
     GetNodeData(Node, ITSTOPackageNode) Then
    Sort(Node, 0, sdAscending);
  Result := True;
End;

{$IfDef VT60}
Function TTSTODlcServerTreeView.DoGetImageIndex(Node : PVirtualNode; Kind : TVTImageKind; Column : TColumnIndex;
  Var Ghosted : Boolean; Var Index : TImageIndex): TCustomImageList;
{$Else}
Function TTSTODlcServerTreeView.DoGetImageIndex(Node : PVirtualNode; Kind : TVTImageKind; Column : TColumnIndex;
  Var Ghosted : Boolean; Var Index : Integer): TCustomImageList;
{$EndIf}
Var lFile : IBinArchivedFileData;
Begin
  Result := Nil;

  If Column = 0 Then
  Begin
    If GetNodeData(Node, ITSTOPackageNode) Then
      Index := 58
    Else If GetNodeData(Node, IBinZeroFileData) Then
      Index := 8
    Else If GetNodeData(Node, IBinArchivedFileData, lFile) Then
    Begin
      If SameText(lFile.FileExtension, 'xml') Then
        Index := 110
      Else If SameText(lFile.FileExtension, 'txt') Then
        Index := 108
      Else If SameText(lFile.FileExtension, 'rgb') Then
        Index := 103
      Else If SameText(lFile.FileExtension, 'sbtp') Then
        Index := 66
      Else If SameText(lFile.FileExtension, 'hex') Then
        Index := 52
      Else If SameText(lFile.FileExtension, 'bcell') Or
              SameText(lFile.FileExtension, 'bsv3') Then
        Index := 116;
    End;
  End;
End;

{$IfDef VT60}
Procedure TTSTODlcServerTreeView.DoGetText(Var pEventArgs : TVSTGetCellTextEventArgs);
{$Else}
Procedure TTSTODlcServerTreeView.DoGetText(Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  Var Text: UnicodeString);
{$EndIf}
Var lPlatform : ITSTOPlatformPackageNode;
    lTier     : ITSTOTierPackageNode;
    lPkg      : ITSTOPackageNode;
    lArchive  : IBinZeroFileData;
    lFile     : IBinArchivedFileData;
    lNodeIntf : PInterface;
    lBsvAnim  : IBsvAnimationIO;
    lCellText : String;
Begin
{$IfDef VT60}
  With pEventArgs Do
{$EndIf}
  Begin
    lCellText := '';

    If Column = 0 Then
    Begin
      If GetNodeData(Node, ITSTOPlatformPackageNode, lPlatform) Then
        lCellText := 'Platform - ' + lPlatform.PlatformName
      Else If GetNodeData(Node, ITSTOTierPackageNode, lTier) Then
        lCellText := 'Tier - ' + lTier.TierName
      Else If GetNodeData(Node, ITSTOPackageNode, lPkg) Then
        lCellText := ExtractFileName(lPkg.FileName)
      Else If GetNodeData(Node, IBinZeroFileData, lArchive) Then
        lCellText := lArchive.FileName
      Else If GetNodeData(Node, IBinArchivedFileData, lFile) Then
        lCellText := lFile.FileName1
      Else If GetNodeData(Node, IBsvAnimationIO, lBsvAnim) Then
        lCellText := lBsvAnim.AnimationName
      Else If GetNodeData(Node.Parent, IBsvAnimationIO) And
              GetNodeData(Node, ITSTORgbFile) Then
        lCellText := 'Frame #' + IntToStr(Node.Index);
    End
    Else If Column = 1 Then
    Begin
      lNodeIntf := GetNodeData(Node);
      lCellText := GetInterfaceName(lNodeIntf^);
    End;

//    If (lCellText <> '') And IsDebugMode Then
//      lCellText := lCellText + ' - ' + IntToStr(Self.GetNodeLevel(Node));
{$IfDef VT60}
    CellText := lCellText;
{$Else}
    Text := lCellText;
{$EndIf}
  End;
End;

Function TTSTODlcServerTreeView.DoInitChildren(Node: PVirtualNode; Var ChildCount : Cardinal) : Boolean;
Var lPlatform : ITSTOPlatformPackageNode;
    lTier     : ITSTOTierPackageNode;
    lPkg      : ITSTOPackageNode;
    lArchive  : IBinZeroFileData;
    lArcData  : IBinArchivedFileData;
    lZip      : IHsMemoryZipper;
    lMem      : IMemoryStreamEx;

    lBsvFile  : IBsvFileIO;
    lBsvAnim  : IBsvAnimationIO;
Begin
  If GetNodeData(Node, ITSTOPlatformPackageNode, lPlatform) Then
    ChildCount := lPlatform.Tiers.Count
  Else If GetNodeData(Node, ITSTOTierPackageNode, lTier) And
          GetNodeData(Node.Parent, ITSTOPlatformPackageNode, lPlatform) Then
    ChildCount := lTier.Packages.Count
  Else If GetNodeData(Node, ITSTOPackageNode, lPkg) Then
  Begin
    If lPkg.FileExist Then
    Begin
      lZip := THsMemoryZipper.Create();
      lMem := TMemoryStreamEx.Create();
      Try
        lZip.ShowProgress := False;
        lZip.LoadFromFile(TSTOProject.Settings.DLCPath + lPkg.FileName);
        lZip.ExtractToStream('0', TStream(lMem.InterfaceObject));
        lMem.Position := 0;
        lPkg.ZeroFile.LoadFromStream(lMem);
        ChildCount := lPkg.ZeroFile.FileDatas.Count;

        Finally
          lMem := Nil;
          lZip := Nil;
      End;
    End;
  End
  Else If GetNodeData(Node, IBinZeroFileData, lArchive) Then
    ChildCount := lArchive.ArchivedFiles.Count
  Else If GetNodeData(Node, IBinArchivedFileData, lArcData) Then
  Begin
    If SameText(lArcData.FileExtension, 'bsv3') Then
    Begin
      If GetNodeData(Node.Parent, IBinZeroFileData, lArchive) And
         GetNodeData(Node.Parent.Parent, ITSTOPackageNode, lPkg) Then
      Begin
        lZip := THsMemoryZipper.Create();
        lMem := TMemoryStreamEx.Create();
        lBsvFile := TBsvFileIO.CreateBsvFile();
        Try
          lZip.ShowProgress := False;
          lZip.LoadFromFile(TSTOProject.Settings.DLCPath + lPkg.FileName);
          lZip.ExtractToStream(lArchive.FileName, lMem);
          lMem.Position := 0;

          lZip.LoadFromStream(lMem);
          lMem.Clear();

          lZip.ExtractToStream(lArcData.FileName1, lMem);
          lMem.Position := 0;

          lBsvFile.LoadFromStream(lMem);
          lArcData.Data := lBsvFile;

          If (lBsvFile.RgbFileName <> '') And (lZip.FindFile(lBsvFile.RgbFileName) > -1) Then
          Begin
            lMem.Clear();
            lZip.ExtractToStream(lBsvFile.RgbFileName, lMem);
            lMem.Position := 0;
            lBsvFile.RgbFile.LoadRgbFromStream(lMem);
          End
          Else If lZip.FindFile(ChangeFileExt(lArcData.FileName1, '.rgb')) > -1 Then
          Begin
            lMem.Clear();
            lZip.ExtractToStream(ChangeFileExt(lArcData.FileName1, '.rgb'), lMem);
            lMem.Position := 0;
            lBsvFile.RgbFile.LoadRgbFromStream(lMem);
          End;

          ChildCount := lBsvFile.Animation.Count;

          Finally
            lBsvFile := Nil;
            lMem := Nil;
            lZip := Nil;
        End;
      End;
    End
    Else
      ChildCount := 0;
  End
  Else If GetNodeData(Node, IBsvAnimationIO, lBsvAnim) And
          GetNodeData(Node.Parent, IBinArchivedFileData, lArcData) And
          Supports(lArcData.Data, IBsvFileIO, lBsvFile) Then
    ChildCount := lBsvAnim.Frames.Count
  Else
    ChildCount := 0;

  Result := ChildCount > 0;
End;

Procedure TTSTODlcServerTreeView.DoInitNode(Parent, Node : PVirtualNode; Var InitStates : TVirtualNodeInitStates);
Var lPlatform : ITSTOPlatformPackageNode;
    lTier     : ITSTOTierPackageNode;
    lPkg      : ITSTOPackageNode;
    lArchive  : IBinZeroFileData;
    lArcData  : IBinArchivedFileData;
    lBsvFile  : IBsvFileIO;
    lBsvAnim  : IBsvAnimationIO;
Begin
  If Not Assigned(Parent) Then
  Begin
    SetNodeData(Node, FTvData[Node.Index]);
    InitStates := InitStates + [ivsHasChildren];
  End
  Else
  Begin
    If GetNodeData(Parent, ITSTOPlatformPackageNode, lPlatform) Then
    Begin
      SetNodeData(Node, lPlatform.Tiers[Node.Index]);
      InitStates := InitStates + [ivsHasChildren];
    End
    Else If GetNodeData(Parent, ITSTOTierPackageNode, lTier) Then
    Begin
      SetNodeData(Node, lTier.Packages[Node.Index]);

      lTier.Packages[Node.Index].FileExist :=
        FileExists(TSTOProject.Settings.DLCPath + lTier.Packages[Node.Index].FileName);
      If lTier.Packages[Node.Index].FileExist Then
        InitStates := InitStates + [ivsHasChildren];
    End
    Else If GetNodeData(Parent, ITSTOPackageNode, lPkg) Then
    Begin
      SetNodeData(Node, lPkg.ZeroFile.FileDatas[Node.Index]);

      If lPkg.ZeroFile.FileDatas[Node.Index].ArchivedFiles.Count > 0 Then
        InitStates := InitStates + [ivsHasChildren];
    End
    Else If GetNodeData(Parent, IBinZeroFileData, lArchive) Then
    Begin
      SetNodeData(Node, lArchive.ArchivedFiles[Node.Index]);
      If SameText(lArchive.ArchivedFiles[Node.Index].FileExtension, 'bsv3') Then
        InitStates := InitStates + [ivsHasChildren];
    End
    Else If GetNodeData(Parent, IBinArchivedFileData, lArcData) Then
    Begin
      If Supports(lArcData.Data, IBsvFileIO, lBsvFile) Then
      Begin
        SetNodeData(Node, lBsvFile.Animation[Node.Index]);
        InitStates := InitStates + [ivsHasChildren];
      End;
    End
    Else If GetNodeData(Parent, IBsvAnimationIO, lBsvAnim) Then
      SetNodeData(Node, lBsvAnim.Frames[Node.Index]);
  End;

  If GetNodeData(Node, ITSTOPlatformPackageNode) Or
     GetNodeData(Node, ITSTOTierPackageNode) Or
     GetNodeData(Node, ITSTOPackageNode) Then
    Node.CheckType := ctTriStateCheckBox;
End;

(******************************************************************************)

Procedure TTSTOWorkSpaceTreeView.LoadData();
Begin
  RootNodeCount := 1;
End;

Function TTSTOWorkSpaceTreeView.GetTvData() : ITSTOWorkSpaceProjectGroupIO;
Begin
  Result := FTvData;
End;

Procedure TTSTOWorkSpaceTreeView.SetTvData(ATvData : ITSTOWorkSpaceProjectGroupIO);
Begin
  FTvData := ATvData;
  If Assigned(FTvData) Then
  Begin
    BeginUpdate();
    Try
      LoadData();

      Finally
        EndUpdate();
    End;
  End
  Else
    RootNodeCount := 0;
End;
(*@@
Function TTSTOWorkSpaceTreeView.GetIsDebugMode() : Boolean;
Begin
  Result := Header.Options * [hoVisible] <> [];
End;

Procedure TTSTOWorkSpaceTreeView.SetIsDebugMode(Const AIsDebugMode : Boolean);
Begin
  If IsDebugMode <> AIsDebugMode Then
  Begin
    If AIsDebugMode Then
    Begin
      Header.Options := Header.Options + [hoVisible];
      Header.Columns[1].Options :=
        Header.Columns[1].Options + [coVisible];
      Header.AutoSizeIndex := 1;
    End
    Else
    Begin
      Header.Options := Header.Options - [hoVisible];
      Header.Columns[1].Options :=
        Header.Columns[1].Options - [coVisible];
      Header.AutoSizeIndex := 0;
    End;
  End;
End;
*)
{$IfDef VT60}
Function TTSTOWorkSpaceTreeView.DoGetImageIndex(Node : PVirtualNode; Kind : TVTImageKind; Column : TColumnIndex;
  Var Ghosted : Boolean; Var Index : TImageIndex): TCustomImageList;
{$Else}
Function TTSTOWorkSpaceTreeView.DoGetImageIndex(Node : PVirtualNode; Kind : TVTImageKind; Column : TColumnIndex;
  Var Ghosted : Boolean; Var Index : Integer): TCustomImageList;
{$EndIf}
Var lSrcFolder : ITSTOWorkSpaceProjectSrcFolder;
    lSrcFile   : ITSTOWorkSpaceProjectSrcFile;
Begin
  Result := Nil;
  If Column = 0 Then
  Begin
    If GetNodeData(Node, ITSTOWorkSpaceProjectGroup) Then
      Index := 45
    Else If GetNodeData(Node, ITSTOWorkSpaceProject) Then
      Index := 58
    Else If GetNodeData(Node, ITSTOWorkSpaceProjectSrcFolder) Then
      Index := 8
    Else If GetNodeData(Node, ITSTOWorkSpaceProjectSrcFile, lSrcFile) Then
    Begin
      If SameText(ExtractFileExt(lSrcFile.FileName), '.xml') Then
        Index := 110
      Else If SameText(ExtractFileExt(lSrcFile.FileName), '.txt') Then
        Index := 108
      Else If SameText(ExtractFileExt(lSrcFile.FileName), '.rgb') Then
        Index := 103
      Else If SameText(ExtractFileExt(lSrcFile.FileName), '.sbtp') Then
        Index := 66
      Else If SameText(ExtractFileExt(lSrcFile.FileName), '.hex') Then
        Index := 52
      Else If SameText(ExtractFileExt(lSrcFile.FileName), '.bcell') Or
              SameText(ExtractFileExt(lSrcFile.FileName), '.bsv3') Then
        Index := 116;
    End;
  End;
End;

{$IfDef VT60}
Procedure TTSTOWorkSpaceTreeView.DoGetText(Var pEventArgs : TVSTGetCellTextEventArgs);
{$Else}
Procedure TTSTOWorkSpaceTreeView.DoGetText(Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  Var Text: UnicodeString);
{$EndIf}
Var lPG        : ITSTOWorkSpaceProjectGroup;
    lPrj       : ITSTOWorkSpaceProject;
    lSrcFolder : ITSTOWorkSpaceProjectSrcFolder;
    lSrcFile   : ITSTOWorkSpaceProjectSrcFile;
    lCellText  : AnsiString;
    lNodeIntf : PInterface;
Begin
{$IfDef VT60}
  With pEventArgs Do
  {$EndIf}
  Begin
    If Column = 0 Then
    Begin
      If GetNodeData(Node, ITSTOWorkSpaceProjectGroup, lPG) Then
        lCellText := lPG.ProjectGroupName
      Else If GetNodeData(Node, ITSTOWorkSpaceProject, lPrj) Then
        lCellText := lPrj.ProjectName
      Else If GetNodeData(Node, ITSTOWorkSpaceProjectSrcFolder, lSrcFolder) Then
        lCellText := ChangeFileExt(ExtractFileName(ExcludeTrailingBackSlash(lSrcFolder.SrcPath)), '')
      Else If GetNodeData(Node, ITSTOWorkSpaceProjectSrcFile, lSrcFile) Then
        lCellText := lSrcFile.FileName;
    End
    Else If Column = 1 Then
    Begin
      lNodeIntf := GetNodeData(Node);
      lCellText  := GetInterfaceName(lNodeIntf^);
    End;

//    If (lCellText <> '') And IsDebugMode Then
//      lCellText := lCellText + ' - ' + IntToStr(Self.GetNodeLevel(Node));

  {$IfDef VT60}
    CellText := lCellText;
  {$Else}
    Text := lCellText;
  {$EndIf}
  End
End;

Function TTSTOWorkSpaceTreeView.DoInitChildren(Node: PVirtualNode; Var ChildCount : Cardinal) : Boolean;
Var lPG        : ITSTOWorkSpaceProjectGroup;
    lPrj       : ITSTOWorkSpaceProject;
    lSrcFolder : ITSTOWorkSpaceProjectSrcFolder;
Begin
  If GetNodeData(Node, ITSTOWorkSpaceProjectGroup, lPG) Then
    ChildCount := lPG.Count
  Else If GetNodeData(Node, ITSTOWorkSpaceProject, lPrj) Then
    ChildCount := lPrj.SrcFolders.Count
  Else If GetNodeData(Node, ITSTOWorkSpaceProjectSrcFolder, lSrcFolder) Then
    ChildCount := lSrcFolder.SrcFileCount;

  Result := ChildCount > 0;
End;

Procedure TTSTOWorkSpaceTreeView.DoInitNode(Parent, Node : PVirtualNode; Var InitStates : TVirtualNodeInitStates);
Var lPG  : ITSTOWorkSpaceProjectGroup;
    lPrj : ITSTOWorkSpaceProject;
    lSrcFolder : ITSTOWorkSpaceProjectSrcFolder;
Begin
  If Assigned(FTvData) Then
  Begin
    If Not Assigned(Parent) Then
    Begin
      SetNodeData(Node, FTvData);
      If FTvData.Count > 0 Then
        InitStates := InitStates + [ivsHasChildren];
    End
    Else
    Begin
      If GetNodeData(Parent, ITSTOWorkSpaceProjectGroup, lPG) Then
      Begin
        SetNodeData(Node, lPg[Node.Index]);
        If lPg[Node.Index].SrcFolders.Count > 0 Then
          InitStates := InitStates + [ivsHasChildren];
      End
      Else If GetNodeData(Parent, ITSTOWorkSpaceProject, lPrj) Then
      Begin
        SetNodeData(Node, lPrj.SrcFolders[Node.Index]);
        If lPrj.SrcFolders[Node.Index].SrcFileCount > 0 Then
          InitStates := InitStates + [ivsHasChildren];
      End
      Else If GetNodeData(Parent, ITSTOWorkSpaceProjectSrcFolder, lSrcFolder) Then
      Begin
        SetNodeData(Node, lSrcFolder.SrcFiles[Node.Index]);
      End;
    End;
  End;
End;

Procedure TTSTOWorkSpaceTreeView.MoveNodeUp(ANode : PVirtualNode);
Var lPrjs : IInterfaceListEx;
Begin
  If Assigned(ANode.Parent) And
     GetNodeData(ANode.Parent, IInterfaceListEx, lPrjs) And
     Assigned(ANode.PrevSibling) Then
  Begin
    lPrjs.Exchange(ANode.Index, ANode.Index - 1);
    MoveTo(ANode, ANode.PrevSibling, amInsertBefore, False);
  End;
End;

Procedure TTSTOWorkSpaceTreeView.MoveNodeDown(ANode : PVirtualNode);
Var lPrjs : IInterfaceListEx;
Begin
  If Assigned(ANode.Parent) And
     GetNodeData(ANode.Parent, IInterfaceListEx, lPrjs) And
     Assigned(ANode.NextSibling) Then
  Begin
    lPrjs.Exchange(ANode.Index, ANode.Index + 1);
    MoveTo(ANode, ANode.NextSibling, amInsertAfter, False);
  End;
End;

Function TTSTOWorkSpaceTreeView.DoKeyAction(var CharCode: Word; var Shift: TShiftState): Boolean;
Var lNode : PVirtualNode;
Begin
  Result := True;
  lNode := GetFirstSelected();

  If (ssCtrl In Shift) And
     GetNodeData(lNode, ITSTOWorkSpaceProject) And
     GetNodeData(lNode.Parent, IInterfaceListEx) Then
    Case CharCode Of
      VK_UP : MoveNodeUp(lNode);
      VK_DOWN : MoveNodeDown(lNode);
    End
  Else
    Result := InHerited DoKeyAction(CharCode, Shift);
End;

(******************************************************************************)

Constructor TTSTOSbtpFileTreeView.Create(AOwner : TComponent);
Begin
  InHerited Create(AOwner);

  With Header Do
  Begin
    Columns.Clear();

    Options := Options + [hoAutoResize, hoOwnerDraw, hoVisible] - [hoDrag];

    Columns.Add().Text := 'Variable Prefix';
    Columns.Add().Text := 'Variable Suffix';
    Columns.Add().Text := 'Data';

    AutoSizeIndex := 2;

    Columns[0].Width := 85;
    Columns[1].Width := 115;
  End;

  With TreeOptions Do
  Begin
    MiscOptions      := MiscOptions + [toGridExtensions];
    PaintOptions     := PaintOptions - [toShowTreeLines] + [toHotTrack];{ +
                        [toShowHorzGridLines, toShowVertGridLines, toFullVertGridLines];}
    SelectionOptions := SelectionOptions + [toExtendedFocus, toFullRowSelect];
  End;
End;

Function TTSTOSbtpFileTreeView.GetTvData() : ISbtpFileIO;
Begin
  Result := FTvData;
End;

Procedure TTSTOSbtpFileTreeView.SetTvData(ATvData : ISbtpFileIO);
Begin
  FTvData := ATvData;

  BeginUpdate();
  Try
    Clear();
    RootNodeCount := ATvData.Item.Count;

    Finally
      EndUpdate();
  End;
End;

Procedure TTSTOSbtpFileTreeView.DoAdvancedHeaderDraw(Var PaintInfo: THeaderPaintInfo; Const Elements: THeaderPaintElements);
Const
  SortGlyphs : Array[TSortDirection] Of Integer =  (3, 2);
Begin
  InHerited DoAdvancedHeaderDraw(PaintInfo, Elements);
Exit;
  If hpeSortGlyph In Elements Then
    With PaintInfo Do
      GetUtilityImages.Draw( TargetCanvas, PaintRectangle.Right - UtilityImageSize,
                             SortGlyphPos.Y, SortGlyphs[Header.SortDirection]);
End;

Function TTSTOSbtpFileTreeView.DoCompare(Node1, Node2 : PVirtualNode; Column : TColumnIndex) : Integer;
Var lNodeData1, lNodeData2 : ISbtpSubVariable;
    lSbtpVar1,  lSbtpVar2 : ISbtpVariable;
Begin
  Result := 0;

  If GetNodeData(Node1, ISbtpVariable, lSbtpVar1) And
     GetNodeData(Node2, ISbtpVariable, lSbtpVar2) And (Column = 0) Then
    Result := CompareText(lSbtpVar1.VariableType, lSbtpVar2.VariableType)
  Else If GetNodeData(Node1, ISbtpSubVariable, lNodeData1) And
     GetNodeData(Node2, ISbtpSubVariable, lNodeData2) Then
    Case Column Of
      1 : Result := CompareText(lNodeData1.VariableName, lNodeData2.VariableName);
      2 : Result := CompareText(lNodeData1.VariableData, lNodeData2.VariableData);
    End;
End;

{$IfDef VT60}
Procedure TTSTOSbtpFileTreeView.DoGetText(Var pEventArgs : TVSTGetCellTextEventArgs);
{$Else}
Procedure TTSTOSbtpFileTreeView.DoGetText(Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  Var Text: UnicodeString);
{$EndIf}
Var lVarPref  : ISbtpVariable;
    lSubVar   : ISbtpSubVariable;
    lCellText : String;
Begin
{$IfDef VT60}
  With pEventArgs Do
{$EndIf}
  Begin
    lCellText := '';

    If GetNodeData(Node, ISbtpVariable, lVarPref) Then
    Begin
      If Column = 0 Then
        lCellText := lVarPref.VariableType;
    End
    Else If GetNodeData(Node, ISbtpSubVariable, lSubVar) Then
    Begin
      If Column = 1 Then
        lCellText := lSubVar.VariableName
      Else If Column = 2 Then
        lCellText := lSubVar.VariableData;
    End;
{$IfDef VT60}
    CellText := lCellText;
{$Else}
    Text := lCellText;
{$EndIf}
  End;
End;

{$IfDef VT60}
Procedure TTSTOSbtpFileTreeView.DoHeaderClick(Const HitInfo: TVTHeaderHitInfo);
{$Else}
Procedure TTSTOSbtpFileTreeView.DoHeaderClick(HitInfo: TVTHeaderHitInfo);
{$EndIf}
Begin
  If HitInfo.Button = mbLeft Then
  Begin
{    If HitInfo.Column = 0 Then
      Header.SortColumn := NoColumn
    Else}
    Begin
      If Header.SortColumn <> HitInfo.Column Then
        Header.SortDirection := sdAscending
      Else If Header.SortDirection = sdAscending Then
        Header.SortDirection := sdDescending
      Else
        Header.SortDirection := sdAscending;

      Header.SortColumn := HitInfo.Column;
      SortTree(Header.SortColumn, Header.SortDirection, False);
    End;
  End;
End;

Procedure TTSTOSbtpFileTreeView.DoHeaderDrawQueryElements(Var PaintInfo : THeaderPaintInfo; Var Elements : THeaderPaintElements);
Begin
  InHerited DoHeaderDrawQueryElements(PaintInfo , Elements);
Exit;
  If Assigned(PaintInfo.Column) And
     (PaintInfo.Column.Index = Header.SortColumn) Then
     Elements := Elements + [hpeSortGlyph];
End;

Function TTSTOSbtpFileTreeView.DoInitChildren(Node: PVirtualNode; Var ChildCount : Cardinal) : Boolean;
Var lVarPref : ISbtpVariable;
Begin
  If GetNodeData(Node, ISbtpVariable, lVarPref) Then
    ChildCount := lVarPref.SubItem.Count;
  Result := ChildCount > 0;
End;

Procedure TTSTOSbtpFileTreeView.DoInitNode(Parent, Node : PVirtualNode; Var InitStates : TVirtualNodeInitStates);
Var lVarPref : ISbtpVariable;
Begin
  If Not Assigned(Parent) Then
  Begin
    SetNodeData(Node, TvData.Item[Node.Index]);
    If TvData.Item[Node.Index].SubItem.Count > 0 Then
      InitStates := InitStates + [ivsHasChildren];
  End
  Else
  Begin
    If GetNodeData(Parent, ISbtpVariable, lVarPref) Then
      SetNodeData(Node, lVarPref.SubItem[Node.Index]);
  End;
End;

(******************************************************************************)

Constructor TTSTOCustomPatchesTreeView.Create(AOwner : TComponent);
Begin
  InHerited Create(AOwner);

  With Header Do
  Begin
    Columns.Clear();

    Options := Options + [hoAutoResize, hoVisible] - [hoDrag];

    Columns.Add().Text := 'Name';
    Columns.Add().Text := 'Description';

    AutoSizeIndex := 1;

    Columns[0].Width := 125;
  End;

  With TreeOptions Do
  Begin
    MiscOptions      := MiscOptions + [toCheckSupport, toGridExtensions];
    PaintOptions     := PaintOptions - [toShowRoot, toShowTreeLines] +
                        [{toShowHorzGridLines, toShowVertGridLines,
                         toFullVertGridLines,} toHotTrack];
    SelectionOptions := SelectionOptions + [toFullRowSelect, toExtendedFocus];
  End;
End;

Function TTSTOCustomPatchesTreeView.GetTvData() : ITSTOCustomPatchListIO;
Begin
  Result := ITSTOCustomPatchListIO(FTvData);
End;

Procedure TTSTOCustomPatchesTreeView.SetTvData(ATvData : ITSTOCustomPatchListIO);
Begin
  FTvData := Pointer(ATvData);

  If Assigned(FTvData) Then
  Begin
    BeginUpdate();
    Try
      LoadData();

      Finally
        EndUpdate();
    End;
  End
  Else
    RootNodeCount := 0;
End;

Procedure TTSTOCustomPatchesTreeView.LoadData();
Begin
  RootNodeCount := TvData.Count;
End;

Procedure TTSTOCustomPatchesTreeView.DoChecked(Node : PVirtualNode);
Var lNodeData : ITSTOCustomPatchIO;//ITSTOXMLCustomPatch;
Begin
  If GetNodeData(Node, ITSTOCustomPatchIO, lNodeData) Then
    lNodeData.PatchActive := Node.CheckState In [csCheckedNormal, csCheckedPressed];
End;

{$IfDef VT60}
Procedure TTSTOCustomPatchesTreeView.DoGetText(Var pEventArgs : TVSTGetCellTextEventArgs);
{$Else}
Procedure TTSTOCustomPatchesTreeView.DoGetText(Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  Var Text: UnicodeString);
{$EndIf}
Var lNodeData : ITSTOCustomPatchIO;
    lCellText : String;
Begin
{$IfDef VT60}
  With pEventArgs Do
{$EndIf}
  Begin
    If GetNodeData(Node, ITSTOCustomPatchIO, lNodeData) Then
      Case Column Of
        0 : lCellText := lNodeData.PatchName;
        1 : lCellText := lNodeData.PatchDesc;
        Else
          lCellText := '';
      End;
{$IfDef VT60}
   CellText := lCellText;
{$Else}
   Text := lCellText;
{$EndIf}
  End;
End;

Procedure TTSTOCustomPatchesTreeView.DoInitNode(Parent, Node : PVirtualNode; Var InitStates : TVirtualNodeInitStates);
Begin
  SetNodeData(Node, TvData[Node.Index]);
  Node.CheckType := ctCheckBox;
  If TvData[Node.Index].PatchActive Then
    Node.CheckState := csCheckedNormal;
End;

Procedure TTSTORessourcesTreeView.AfterConstruction();
Begin
  InHerited AfterConstruction();

  InHerited OnCompareNodes := DoCompare;
End;

Procedure TTSTORessourcesTreeView.BeforeDestruction();
Begin
  FTvData := Nil;

  InHerited BeforeDestruction();
End;

Procedure TTSTORessourcesTreeView.DoGetText(Var pEventArgs : TVSTGetCellTextEventArgs);
Var lResPath  : ITSTOResourcePath;
    lResFile  : ITSTOResourceFile;
    lNodeIntf : PInterface;
Begin
  With pEventArgs Do
  Begin
    CellText := '';
    If Column = 0 Then
    Begin
      If GetNodeData(Node, ITSTOResourcePath, lResPath) Then
        CellText := lResPath.ResourcePath
      Else If GetNodeData(Node, ITSTOResourceFile, lResFile) Then
        CellText := lResFile.FileName;
    End
    Else If Column = 1 Then
    Begin
      lNodeIntf := GetNodeData(Node);
      CellText  := GetInterfaceName(lNodeIntf^);
    End;
  End;
End;

Function TTSTORessourcesTreeView.DoGetImageIndex(Node : PVirtualNode; Kind : TVTImageKind; Column : TColumnIndex;
  Var Ghosted : Boolean; Var Index : TImageIndex): TCustomImageList;
Var lResPath : ITSTOResourcePath;
    lResFile : ITSTOResourceFile;
Begin
  Result := Nil;
  If Column = 0 Then
  Begin
    If GetNodeData(Node, ITSTOResourcePath, lResPath) Then
      Index := 8
    Else If GetNodeData(Node, ITSTOResourceFile, lResFile) Then
    Begin
      If SameText(ExtractFileExt(lResFile.FileName), '.rgb') Or
         SameText(ExtractFileExt(lResFile.FileName), '.png') Then
        Index := 103
    End;
  End;
End;

Procedure TTSTORessourcesTreeView.DoInitNode(Parent, Node : PVirtualNode; Var InitStates : TVirtualNodeInitStates);
Var lResPath : ITSTOResourcePath;
Begin
  If Not Assigned(Parent) Then
  Begin
    SetNodeData(Node, TvData[Node.Index]);

    If TvData[Node.Index].ResourceFiles.Count > 0 Then
      InitStates := InitStates + [ivsHasChildren];
  End
  Else
  Begin
    If GetNodeData(Node.Parent, ITSTOResourcePath, lResPath) Then
    Begin
      SetNodeData(Node, lResPath.ResourceFiles[Node.Index]);
    End;
  End;
End;

Function TTSTORessourcesTreeView.DoInitChildren(Node: PVirtualNode; Var ChildCount : Cardinal) : Boolean;
Var lResPath : ITSTOResourcePath;
Begin
  If GetNodeData(Node, ITSTOResourcePath, lResPath) Then
    ChildCount := lResPath.ResourceFiles.Count;
  Result := ChildCount > 0;
End;

Procedure TTSTORessourcesTreeView.DoSetNodeExpandState(Sender : TBaseVirtualTree; Node : PVirtualNode; Data : Pointer; Var Abort : Boolean);
Begin
  Expanded[Node] := PBoolean(Data)^;
End;

Procedure TTSTORessourcesTreeView.DoCompare(Sender: TBaseVirtualTree;
  Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
Var lRp1, lRp2 : ITSTOResourcePath;
    lFile1, lFile2 : ITSTOResourceFile;
Begin
  Result := -1;

  If GetNodeData(Node1, ITSTOResourcePath, lRp1) And
     GetNodeData(Node2, ITSTOResourcePath, lRp2) Then
    Result := CompareText(lRp1.ResourcePath, lRp2.ResourcePath)
  Else If GetNodeData(Node1, ITSTOResourceFile, lFile1) And
          GetNodeData(Node2, ITSTOResourceFile, lFile2) Then
    Result := CompareText(lFile1.FileName, lFile2.FileName);
End;

Procedure TTSTORessourcesTreeView.ExpandAllNodes();
Var lExpandState : Boolean;
Begin
  lExpandState := True;
  BeginUpdate();
  Try
    IterateSubtree(Nil, DoSetNodeExpandState, @lExpandState);
    Finally
      EndUpdate();
  End;
End;

Procedure TTSTORessourcesTreeView.CollapseAllNodes();
Var lExpandState : Boolean;
Begin
  lExpandState := False;
  BeginUpdate();
  Try
    IterateSubtree(Nil, DoSetNodeExpandState, @lExpandState);
    Finally
      EndUpdate();
  End;
End;

Function TTSTORessourcesTreeView.GetTvData() : ITSTOResourcePaths;
Begin
  Result := ITSTOResourcePaths(FTvData);
End;

Procedure TTSTORessourcesTreeView.SetTvData(ATvData : ITSTOResourcePaths);
Begin
  FTvData := Pointer(ATvData);

  If Assigned(FTvData) Then
  Begin
    BeginUpdate();
    Try
      LoadData();

      Finally
        EndUpdate();
    End;
  End
  Else
    RootNodeCount := 0;
End;

Procedure TTSTORessourcesTreeView.LoadData();
Begin
  BeginUpdate();
  Try
    RootNodeCount := TvData.Count;

    Finally
      EndUpdate();
  End;
End;

Constructor TTSTORemoveFileTreeView.Create(AOwner : TComponent);
Begin
  InHerited Create(AOwner);

  With TreeOptions Do
  Begin
    SelectionOptions := SelectionOptions + [toMultiSelect];
    PaintOptions     := PaintOptions - [toShowRoot];
    MiscOptions      := MiscOptions + [toCheckSupport];
  End;
End;

Function TTSTORemoveFileTreeView.GetTvData() : ITSTOWorkSpaceProjectSrcFiles;
Begin
  Result := ITSTOWorkSpaceProjectSrcFiles(FTvData);
End;

Procedure TTSTORemoveFileTreeView.SetTvData(ATvData : ITSTOWorkSpaceProjectSrcFiles);
Begin
  FTvData := Pointer(ATvData);
End;

Procedure TTSTORemoveFileTreeView.DoInitNode(Parent, Node : PVirtualNode; Var InitStates : TVirtualNodeInitStates);
Begin
  If Not Assigned(Parent) Then
  Begin
    SetNodeData(Node, TvData[Node.Index]);
    Node.CheckType := ctCheckBox;
  End;
End;

Procedure TTSTORemoveFileTreeView.DoGetText(Var pEventArgs : TVSTGetCellTextEventArgs);
Begin
  pEventArgs.CellText := TvData[pEventArgs.Node.Index].FileName;
End;

Procedure TTSTORemoveFileTreeView.LoadData();
Begin
  BeginUpdate();
  Try
    RootNodeCount := TvData.Count;

    Finally
      EndUpdate();
  End;
End;

Function TTSTORemoveFileTreeView.GetSelectedItems() : ITSTOWorkSpaceProjectSrcFiles;
Var lNode : PVirtualNode;
    lSrcFile : ITSTOWorkSpaceProjectSrcFile;
Begin
  Result := TTSTOWorkSpaceProjectSrcFiles.Create();

  lNode := RootNode.FirstChild;

  While Assigned(lNode) Do
  Begin
    If lNode.CheckState = csCheckedNormal Then
    Begin
      If GetNodeData(lNode, ITSTOWorkSpaceProjectSrcFile, lSrcFile) Then
      Try
        Result.Add(lSrcFile);

        Finally
          lSrcFile := Nil;
      End;
    End;

    lNode := lNode.NextSibling;
  End;
End;

Constructor TTSTOScriptTemplateTreeView.Create(AOwner : TComponent);
Begin
  InHerited Create(AOwner);

  With TreeOptions Do
  Begin
    PaintOptions := PaintOptions - [toShowRoot];
    MiscOptions  := MiscOptions + [toCheckSupport];
  End;
End;

Procedure TTSTOScriptTemplateTreeView.LoadData();
Begin
  If Assigned(TvData) Then
  Begin
    BeginUpdate();
    Try
      RootNodeCount := TvData.Count;

      Finally
        EndUpdate();
    End;
  End
  Else
    RootNodeCount := 0;
End;

Function TTSTOScriptTemplateTreeView.GetTvData() : ITSTOScriptTemplateHacksIO;
Begin
  Result := ITSTOScriptTemplateHacksIO(FTvData);
End;

Procedure TTSTOScriptTemplateTreeView.SetTvData(ATvData : ITSTOScriptTemplateHacksIO);
Begin
  FTvData := Pointer(ATvData);
  LoadData();
End;

Procedure TTSTOScriptTemplateTreeView.DoInitNode(Parent, Node : PVirtualNode; Var InitStates : TVirtualNodeInitStates);
Begin
  SetNodeData(Node, TvData[Node.Index]);
  Node.CheckType := ctCheckBox;
  If TvData[Node.Index].Enabled Then
    Node.CheckState := csCheckedNormal;
End;

Procedure TTSTOScriptTemplateTreeView.DoGetText(Var pEventArgs : TVSTGetCellTextEventArgs);
Var lNodeData : ITSTOScriptTemplateHackIO;
    lNodeIntf : PInterface;
Begin
  With pEventArgs Do
  Begin
    CellText := '';
    If Column = 0 Then
    Begin
      If GetNodeData(pEventArgs.Node, ITSTOScriptTemplateHackIO, lNodeData) Then
        CellText := lNodeData.Name;
    End
    Else If Column = 1 Then
    Begin
      lNodeIntf := GetNodeData(Node);
      CellText  := GetInterfaceName(lNodeIntf^);
    End;
  End;
End;

Procedure TTSTOScriptTemplateTreeView.DoCanEdit(Node: PVirtualNode; Column: TColumnIndex; Var Allowed: Boolean);
Begin
  Allowed := True;
End;

Procedure TTSTOScriptTemplateTreeView.DoNewText(Node : PVirtualNode; Column : TColumnIndex; Const Text: String);
Var lNodeData : ITSTOScriptTemplateHackIO;
Begin
  If GetNodeData(Node, ITSTOScriptTemplateHackIO, lNodeData) Then
    lNodeData.Name := Text;
End;

Procedure TTSTOScriptTemplateTreeView.DoChecked(Node : PVirtualNode);
Var lNodeData : ITSTOScriptTemplateHackIO;
Begin
  If GetNodeData(Node, ITSTOScriptTemplateHackIO, lNodeData) Then
    lNodeData.Enabled := Node.CheckState = csCheckedNormal;
End;

Type
  ISTSetting = TTSTOScriptTemplateSettingsTreeView.ISTSetting;
  ISTSettings = TTSTOScriptTemplateSettingsTreeView.ISTSettings;

  TSTSetting = Class(TInterfacedObjectEx, ISTSetting)
  Private
    FPropertyName  : WideString;
    FPropertyValue : WideString;
    FOnChanged     : TNotifyEvent;

  Protected
    Function  GetPropertyName() : WideString;
    Procedure SetPropertyName(Const APropertyName : WideString);

    Function  GetPropertyValue() : WideString;
    Procedure SetPropertyValue(Const APropertyValue : WideString);

    Function  GetOnChanged() : TNotifyEvent;
    Procedure SetOnChanged(AOnChanged : TNotifyEvent);

  End;

  TSTSettings = Class(TInterfaceListEx, ISTSettings)
  Private
    FData : Pointer;

    Function GetData() : ITSTOScriptTemplateHackIO;
    Procedure DoSettingChange(Sender : TObject);

  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;

    Function  Get(Index : Integer) : ISTSetting; OverLoad;
    Procedure Put(Index : Integer; Const Item : ISTSetting); OverLoad;

    Function IndexOf(Const ASettingName : String) : Integer; ReIntroduce;

    Function Add() : ISTSetting; OverLoad;
    Function Add(Const AItem : ISTSetting) : Integer; OverLoad;

    Property Data : ITSTOScriptTemplateHackIO Read GetData;

  Public
    Constructor Create(AData : ITSTOScriptTemplateHackIO); ReIntroduce;

  End;

Function TSTSetting.GetPropertyName() : WideString;
Begin
  Result := FPropertyName;
End;

Procedure TSTSetting.SetPropertyName(Const APropertyName : WideString);
Begin
  If FPropertyName <> APropertyName Then
  Begin
    FPropertyName := APropertyName;

    If Assigned(FOnChanged) Then
      FOnChanged(Self);
  End;
End;

Function TSTSetting.GetPropertyValue() : WideString;
Begin
  Result := FPropertyValue;
End;

Procedure TSTSetting.SetPropertyValue(Const APropertyValue : WideString);
Begin
  If FPropertyValue <> APropertyValue Then
  Begin
    FPropertyValue := APropertyValue;

    If Assigned(FOnChanged) Then
      FOnChanged(Self);
  End;
End;

Function TSTSetting.GetOnChanged() : TNotifyEvent;
Begin
  Result := FOnChanged;
End;

Procedure TSTSetting.SetOnChanged(AOnChanged : TNotifyEvent);
Begin
  FOnChanged := AOnChanged;
End;

Constructor TSTSettings.Create(AData : ITSTOScriptTemplateHackIO);
Var lTemplateFunc : TScriptTemplateFunctions;
    X : Integer;
Begin
  InHerited Create();

  FData := Pointer(AData);

  If Assigned(FData) Then
    With Data Do
    Begin
      lTemplateFunc := [];

      For X := 0 To Variables.Count - 1 Do
        If SameText(Variables[X].VarFunc, 'hmBuildStoreMenu') Then
          lTemplateFunc := lTemplateFunc + [stfBuildStoreMenu]
        Else If SameText(Variables[X].VarFunc, 'hmBuildInventoryMenu') Then
          lTemplateFunc := lTemplateFunc + [stfBuildInventoryMenu]
        Else If SameText(Variables[X].VarFunc, 'hmBuildStoreItems') Then
          lTemplateFunc := lTemplateFunc + [stfBuildStoreItems]
        Else If SameText(Variables[X].VarFunc, 'hmBuildStoreReqs') Then
          lTemplateFunc := lTemplateFunc + [stfBuildStoreReqs]
        Else If SameText(Variables[X].VarFunc, 'hmBuildDeleteBadItems') Then
          lTemplateFunc := lTemplateFunc + [stfBuildDeleteBadItems]
        Else If SameText(Variables[X].VarFunc, 'hmBuildFreeItems') Then
          lTemplateFunc := lTemplateFunc + [stfBuildFreeItems]
        Else If SameText(Variables[X].VarFunc, 'hmBuildUniqueItems') Then
          lTemplateFunc := lTemplateFunc + [stfBuildUniqueItems]
        Else If SameText(Variables[X].VarFunc, 'hmBuildReqsItems') Then
          lTemplateFunc := lTemplateFunc + [stfBuildReqsItems]
        Else If SameText(Variables[X].VarFunc, 'hmBuildNonSellableItems') Then
          lTemplateFunc := lTemplateFunc + [stfBuildNonSellableItems];

      With Settings Do
      Begin
        With Add() Do
        Begin
          PropertyName  := 'OutputFileName';
          PropertyValue := OutputFileName;
          OnChanged     := DoSettingChange;
        End;

        If (lTemplateFunc * [stfBuildStoreMenu] = [stfBuildStoreMenu]) Then
        Begin
          If IndexOf('CategoryNamePrefix') = -1 Then
            With Add() Do
            Begin
              PropertyName  := 'CategoryNamePrefix';
              PropertyValue := CategoryNamePrefix;
              OnChanged     := DoSettingChange;
            End;

          If IndexOf('StoreItemsPath') = -1 Then
            With Add() Do
            Begin
              PropertyName  := 'StoreItemsPath';
              PropertyValue := StoreItemsPath;
              OnChanged     := DoSettingChange;
            End;

          If IndexOf('RequirementPath') = -1 Then
            With Add() Do
            Begin
              PropertyName  := 'RequirementPath';
              PropertyValue := RequirementPath;
              OnChanged     := DoSettingChange;
            End;
        End;

        If (lTemplateFunc * [stfBuildInventoryMenu] = [stfBuildInventoryMenu]) Then
        Begin
          If IndexOf('CategoryNamePrefix') = -1 Then
            With Add() Do
            Begin
              PropertyName  := 'CategoryNamePrefix';
              PropertyValue := CategoryNamePrefix;
              OnChanged     := DoSettingChange;
            End;

          If IndexOf('StoreItemsPath') = -1 Then
            With Add() Do
            Begin
              PropertyName  := 'StoreItemsPath';
              PropertyValue := StoreItemsPath;
              OnChanged     := DoSettingChange;
            End;
        End;

        If (lTemplateFunc * [stfBuildStoreReqs] = [stfBuildStoreReqs]) Then
        Begin
          If IndexOf('CategoryNamePrefix') = -1 Then
            With Add() Do
            Begin
              PropertyName  := 'CategoryNamePrefix';
              PropertyValue := CategoryNamePrefix;
              OnChanged     := DoSettingChange;
            End;
        End;

        If (lTemplateFunc * [stfBuildStoreItems] = [stfBuildStoreItems]) Then
        Begin
          If IndexOf('StorePrefix') = -1 Then
            With Add() Do
            Begin
              PropertyName  := 'StorePrefix';
              PropertyValue := StorePrefix;
              OnChanged     := DoSettingChange;
            End;
        End;
      End;
    End;
End;

Procedure TSTSettings.DoSettingChange(Sender : TObject);
Var lData : ISTSetting;
Begin
  If Assigned(Data) And Supports(Sender, ISTSetting, lData) Then
  Begin
    With Data.Settings Do
      If SameText(lData.PropertyName, 'OutputFileName') Then
        OutputFileName := lData.PropertyValue
      Else If SameText(lData.PropertyName, 'CategoryNamePrefix') Then
        CategoryNamePrefix := lData.PropertyValue
      Else If SameText(lData.PropertyName, 'StoreItemsPath') Then
        StoreItemsPath := lData.PropertyValue
      Else If SameText(lData.PropertyName, 'RequirementPath') Then
        RequirementPath := lData.PropertyValue
      Else If SameText(lData.PropertyName, 'StorePrefix') Then
        StorePrefix := lData.PropertyValue;
  End;
End;


Function TSTSettings.GetData() : ITSTOScriptTemplateHackIO;
Begin
  Result := ITSTOScriptTemplateHackIO(FData);
End;

Function TSTSettings.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TSTSetting;
End;

Function TSTSettings.IndexOf(Const ASettingName : String) : Integer;
Var X : Integer;
Begin
  Result := -1;

  For X := 0 To Count - 1 Do
    If SameText(Get(X).PropertyName, 'ASettingName') Then
    Begin
      Result := X;
      Break;
    End;
End;

Function TSTSettings.Get(Index : Integer) : ISTSetting;
Begin
  Result := InHerited Items[Index] As ISTSetting;
End;

Procedure TSTSettings.Put(Index : Integer; Const Item : ISTSetting);
Begin
  InHerited Items[Index] := Item;
End;

Function TSTSettings.Add() : ISTSetting;
Begin
  Result := InHerited Add() As ISTSetting;
End;

Function TSTSettings.Add(Const AItem : ISTSetting) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Type
  TTSTOScriptTemplateSettingsEditor = Class(TCustomTSTOVTEditor)
  Protected
    Function EndEdit() : Boolean; OverRide; StdCall;
    Function PrepareEdit(Tree : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex): Boolean; OverRide; StdCall;

  End;

Function TTSTOScriptTemplateSettingsEditor.EndEdit() : Boolean;
Var lNodeData : ISTSetting;
Begin
  Result := True;

  If FTree.GetNodeData(FNode, ISTSetting, lNodeData) Then
    Case FColumn Of
      1 : lNodeData.PropertyValue := THsVTEdit(FEdit).Text;
    End;

  FEdit.Hide();
  FTree.SetFocus();
End;

Function TTSTOScriptTemplateSettingsEditor.PrepareEdit(Tree : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex): Boolean;
Var lVarData : ISTSetting;
Begin
  Result  := True;
  FTree   := Tree As TTSTOBaseTreeView;
  FNode   := Node;
  FColumn := Column;

  If Assigned(FEdit) Then
    FreeAndNil(FEdit);

  If FTree.GetNodeData(Node, ISTSetting, lVarData) Then
    Case Column Of
      1 :
      Begin
        FEdit := CreateEdit(Tree);

        With FEdit As THsVTEdit Do
          Text := lVarData.PropertyValue;
      End;
    End;
End;

Constructor TTSTOScriptTemplateSettingsTreeView.Create(AOwner : TComponent);
Begin
  InHerited Create(AOwner);

  With Header Do
  Begin
    Columns.Clear();

    Options := Options + [hoAutoResize, hoVisible] - [hoDrag];

    Columns.Add().Text := 'Name';
    Columns.Add().Text := 'Value';

    AutoSizeIndex := 1;

    Columns[0].Width := 125;
  End;

  With TreeOptions Do
  Begin
    PaintOptions := PaintOptions - [toShowRoot, toShowTreeLines] + [toHotTrack];{ +
                    [toHideFocusRect, toHideSelection];}
    MiscOptions  := MiscOptions + [toEditable, toGridExtensions];
    SelectionOptions := SelectionOptions + [toExtendedFocus];//, toDisableDrawSelection];
  End;

End;

Procedure TTSTOScriptTemplateSettingsTreeView.DoInitNode(Parent, Node : PVirtualNode; Var InitStates : TVirtualNodeInitStates);
Begin
  SetNodeData(Node, FSettings[Node.Index]);
End;

Procedure TTSTOScriptTemplateSettingsTreeView.DoGetText(Var pEventArgs : TVSTGetCellTextEventArgs);
Var lNodeData : ISTSetting;
Begin
  With pEventArgs Do
  Begin
    CellText := '';

    If GetNodeData(Node, ISTSetting, lNodeData) Then
      Case Column Of
        0 : CellText := lNodeData.PropertyName;
        1 : CellText := lNodeData.PropertyValue;
      End;
  End;
End;

Procedure TTSTOScriptTemplateSettingsTreeView.DoCanEdit(Node : PVirtualNode; Column : TColumnIndex; Var Allowed: Boolean);
Begin
  Allowed := Column = 1;
End;

Procedure TTSTOScriptTemplateSettingsTreeView.DoFocusChange(Node : PVirtualNode; Column : TColumnIndex);
Begin
  InHerited DoFocusChange(Node, Column);

  If IsEditing Then
    EndEditNode();

  If Assigned(Node) Then
    EditNode(Node, Column);
End;

Procedure TTSTOScriptTemplateSettingsTreeView.DoNewText(Node : PVirtualNode; Column : TColumnIndex; Const Text : String);
Var lNodeData : ISTSetting;
Begin
  If (Column = 1) And GetNodeData(Node, ISTSetting, lNodeData) Then
    lNodeData.PropertyValue := Text;
End;

Function TTSTOScriptTemplateSettingsTreeView.GetTvData() : ITSTOScriptTemplateHackIO;
Begin
  Result := ITSTOScriptTemplateHackIO(FTvData);
End;

Procedure TTSTOScriptTemplateSettingsTreeView.SetTvData(ATvData : ITSTOScriptTemplateHackIO);
Begin
  FTvData := Pointer(ATvData);
  RootNodeCount := 0;
  LoadData();
End;

Procedure TTSTOScriptTemplateSettingsTreeView.LoadData();
Var lTemplateFunc : TScriptTemplateFunctions;
    X : Integer;
Begin
  RootNodeCount := 0;

  If Assigned(TvData) Then
  Begin
    FSettings := TSTSettings.Create(TvData);
    BeginUpdate();
    Try
      RootNodeCount := FSettings.Count;
      Finally
        EndUpdate();
    End;
  End;
End;

Type
  TTSTOScriptTemplateVariablesEditor = Class(TCustomTSTOVTEditor)
  Protected
    Function EndEdit() : Boolean; OverRide; StdCall;
    Function PrepareEdit(Tree : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex): Boolean; OverRide; StdCall;

  End;

Function TTSTOScriptTemplateVariablesEditor.EndEdit() : Boolean;
Var lNodeData : ITSTOScriptTemplateVariableIO;
Begin
  Result := True;

  If FTree.GetNodeData(FNode, ITSTOScriptTemplateVariableIO, lNodeData) Then
    Case FColumn Of
      0 : lNodeData.Name    := THsVTEdit(FEdit).Text;
      1 : lNodeData.VarFunc := TVirtualStringTreeDropDown(FEdit).Text;
    End;

  FEdit.Hide();
  FTree.SetFocus();
End;

Function TTSTOScriptTemplateVariablesEditor.PrepareEdit(Tree : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex): Boolean;
Var lNodeData : PPointer;
    lVarData  : ITSTOScriptTemplateVariableIO;
    X : Integer;
    lTypeData  : PTypeData;
    lEnumNames : PByteArray;
Begin
  Result  := True;
  FTree   := Tree As TTSTOBaseTreeView;
  FNode   := Node;
  FColumn := Column;

  If Assigned(FEdit) Then
    FreeAndNil(FEdit);

  If FTree.GetNodeData(Node, ITSTOScriptTemplateVariableIO, lVarData) Then
    Case Column Of
      0 :
      Begin
        FEdit := CreateEdit(Tree);

        With FEdit As THsVTEdit Do
          Text := lVarData.Name;
      End;

      1 :
      Begin
        FEdit := CreateComboBox(Tree);

        With FEdit As TVirtualStringTreeDropDown Do
        Begin
          lTypeData  := GetTypeData(TypeInfo(TScriptTemplateFunction));
          lEnumNames := @lTypeData.NameList;

          For X := lTypeData.MinValue To lTypeData.MaxValue Do
          Begin
            Items.Add(StringReplace(Copy(PAnsiChar(lEnumNames), 2, lEnumNames[0]), 'stf', 'hm', [rfIgnoreCase]));
            lEnumNames := @lEnumNames[lEnumNames[0] + 1];
          End;

          ItemIndex := Items.IndexOf(lVarData.VarFunc);
        End;
      End;
    End;
End;

Constructor TTSTOScriptTemplateVariablesTreeView.Create(AOwner : TComponent);
Begin
  InHerited Create(AOwner);

  With Header Do
  Begin
    Columns.Clear();

    Options := Options + [hoAutoResize, hoVisible] - [hoDrag];

    Columns.Add().Text := 'Name';
    Columns.Add().Text := 'Function';

    With Columns.Add() Do
      Options := Options - [coVisible];

    AutoSizeIndex := 1;

    Columns[0].Width := 125;
  End;

  With TreeOptions Do
  Begin
    PaintOptions := PaintOptions - [toShowRoot, toShowTreeLines] + [toHotTrack];{ +
                    [toHideFocusRect, toHideSelection];}
    MiscOptions  := MiscOptions + [toEditable, toGridExtensions];
    SelectionOptions := SelectionOptions + [toExtendedFocus];//, toDisableDrawSelection];
  End;
End;

Function TTSTOScriptTemplateVariablesTreeView.GetIsDebugMode() : Boolean;
Begin
  Result := Header.Columns[Header.Columns.Count - 1].Options * [coVisible] = [coVisible];
End;

Procedure TTSTOScriptTemplateVariablesTreeView.SetIsDebugMode(Const AIsDebugMode : Boolean);
Begin
  With Header, Columns[Header.Columns.Count - 1] Do
    If AIsDebugMode Then
    Begin
      Options := Options + [coVisible];
      AutoSizeIndex := Columns.Count - 1;
    End
    Else
    Begin
      Options := Options - [coVisible];
      AutoSizeIndex := Columns.Count - 2;
    End;
End;

Function  TTSTOScriptTemplateVariablesTreeView.GetTvData() : ITSTOScriptTemplateVariablesIO;
Begin
  Result := ITSTOScriptTemplateVariablesIO(FTvData);
End;

Procedure TTSTOScriptTemplateVariablesTreeView.SetTvData(ATvData : ITSTOScriptTemplateVariablesIO);
Begin
  FTvData := Pointer(ATvData);
  LoadData();
End;

Procedure TTSTOScriptTemplateVariablesTreeView.DoInitNode(Parent, Node : PVirtualNode; Var InitStates : TVirtualNodeInitStates);
Begin
  SetNodeData(Node, TvData[Node.Index]);
End;

Procedure TTSTOScriptTemplateVariablesTreeView.DoGetText(Var pEventArgs : TVSTGetCellTextEventArgs);
Var lNodeData : ITSTOScriptTemplateVariableIO;
    lNodeIntf : PInterface;
Begin
  With pEventArgs Do
  Begin
    CellText := '';
    If GetNodeData(Node, ITSTOScriptTemplateVariableIO, lNodeData) Then
      Case Column Of
        0 : CellText := lNodeData.Name;
        1 : CellText := lNodeData.VarFunc;
        2 :
        Begin
          lNodeIntf := GetNodeData(Node);
          CellText := GetInterfaceName(lNodeIntf^);
        End;
      End;
  End;
End;

Function TTSTOScriptTemplateVariablesTreeView.DoCreateEditor(Node: PVirtualNode; Column: TColumnIndex): IVTEditLink;
Begin
  Result := TTSTOScriptTemplateVariablesEditor.Create();
End;

Procedure TTSTOScriptTemplateVariablesTreeView.DoCanEdit(Node : PVirtualNode; Column : TColumnIndex; Var Allowed: Boolean);
Begin
  Allowed := Column < 2;
End;

Procedure TTSTOScriptTemplateVariablesTreeView.DoFocusChange(Node : PVirtualNode; Column : TColumnIndex);
Begin
  InHerited DoFocusChange(Node, Column);

  If IsEditing Then
    EndEditNode();

  If Assigned(Node) Then
    EditNode(Node, Column);
End;

Procedure TTSTOScriptTemplateVariablesTreeView.LoadData();
Begin
  RootNodeCount := 0;

  If Assigned(TvData) Then
  Begin
    BeginUpdate();
    Try
      RootNodeCount := TvData.Count;

      Finally
        EndUpdate();
    End;
  End;
End;

end.
