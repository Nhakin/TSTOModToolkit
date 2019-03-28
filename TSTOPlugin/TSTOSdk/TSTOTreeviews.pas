unit TSTOTreeviews;

interface

Uses
  Messages, Classes, VirtualTrees, SpTBXExControls, SpTBXSkins, HsInterfaceEx;

Type
  TTSTOBaseTreeView = Class(TSpTBXVirtualStringTree)
  Protected
    Procedure WMSpSkinChange(Var Message: TMessage); Message WM_SPSKINCHANGE;
    Function  DebugEnabled() : Boolean; Virtual;

    Function  GetIsDebugMode() : Boolean; Virtual;
    Procedure SetIsDebugMode(Const AIsDebugMode : Boolean); Virtual;

    Procedure InitSkin(); Virtual;

  Public
    Property IsDebugMode : Boolean Read GetIsDebugMode Write SetIsDebugMode;

    Procedure SetNodeData(ANode : PVirtualNode; ANodeData : IInterface);
    Function  GetNodeData(ANode : PVirtualNode; AId : TGUID; Var ANodeData) : Boolean; OverLoad;
    Function  GetNodeData(ANode : PVirtualNode; AId : TGUID) : Boolean; OverLoad;

    Constructor Create(AOwner : TComponent); OverRide;

  End;

implementation

Uses SysUtils, Graphics;

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
  NodeDataSize := SizeOf(IInterface);

  InitSkin();
End;

Procedure TTSTOBaseTreeView.InitSkin();
Begin
  If SameText(SkinManager.CurrentSkin.SkinName, 'WMP11') Then
  Begin
    Color := $00262525;
    Font.Color := $00F1F1F1
  End
  Else
  Begin
    Color := clWindow;
    With SkinManager.CurrentSkin Do
      Options(skncListItem, sknsNormal).TextColor := clWindowText;
  End;
End;

Procedure TTSTOBaseTreeView.WMSpSkinChange(Var Message: TMessage);
Begin
  InHerited;

  InitSkin();
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

end.
