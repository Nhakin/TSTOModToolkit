Unit HsScrollBarEventDispatcher;

Interface

Uses Classes, Controls, StdCtrls, HsEventListEx;

Type
  IScrollEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-A618-04AB9D5D08B3}']
    Function  Get(Index : Integer) : TScrollEvent;
    Procedure Put(Index : Integer; Item : TScrollEvent);

    Function  Add(Item : TScrollEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TScrollEvent);
    Function  Remove(Item : TScrollEvent) : Integer;
    Function  IndexOf(Item : TScrollEvent) : Integer;

    Procedure Execute(Sender : TObject; ScrollCode : TScrollCode; Var ScrollPos : Integer);

    Property Items[Index : Integer] : TScrollEvent Read Get Write Put; Default;

  End;

  TScrollEventListEx = Class(TMethodListEx, IScrollEventListEx)
  Protected
    Function  Get(Index : Integer) : TScrollEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TScrollEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TScrollEvent Read Get Write Put; Default;

    Function  Add(Item : TScrollEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TScrollEvent); OverLoad;
    Function  Remove(Item : TScrollEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TScrollEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TObject; ScrollCode : TScrollCode; Var ScrollPos : Integer);

  End;

(******************************************************************************)

  IScrollBarDispatcher = Interface(IEventDispatcher)
    ['{4B61686E-29A0-2112-8219-C2CCED92C11B}']
    Procedure RegisterScrollEvent(AEvent, ANewEvent : TScrollEvent; Const Index : Integer = -1);
    Procedure UnRegisterScrollEvent(AEvent, AOldEvent : TScrollEvent);
    Procedure DisableScrollEvent(AEvent, ADisabledEvent : TScrollEvent);
    Procedure EnableScrollEvent(AEvent, AEnabledEvent : TScrollEvent);

  End;

  TScrollBarDispatcher = Class(TCustomEventDispatcher, IScrollBarDispatcher)
  Protected
    Procedure InitEvents(); OverRide;

    Procedure RegisterScrollEvent(AEvent, ANewEvent : TScrollEvent; Const Index : Integer = -1);
    Procedure UnRegisterScrollEvent(AEvent, AOldEvent : TScrollEvent);
    Procedure DisableScrollEvent(AEvent, ADisabledEvent : TScrollEvent);
    Procedure EnableScrollEvent(AEvent, AEnabledEvent : TScrollEvent);

  End;

  THsScrollBarEx = Class(TScrollBar)
  Private
    FOnChange        : TNotifyEvent;
    FOnContextPopup  : TContextPopupEvent;
    FOnDragDrop      : TDragDropEvent;
    FOnDragOver      : TDragOverEvent;
    FOnEndDock       : TEndDragEvent;
    FOnEndDrag       : TEndDragEvent;
    FOnEnter         : TNotifyEvent;
    FOnExit          : TNotifyEvent;
    FOnKeyDown       : TKeyEvent;
    FOnKeyPress      : TKeyPressEvent;
    FOnKeyUp         : TKeyEvent;
    FOnScroll        : TScrollEvent;
    FOnStartDock     : TStartDockEvent;
    FOnStartDrag     : TStartDragEvent;
    FEventDispatcher : IScrollBarDispatcher;

    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);
    Function  GetOnContextPopup() : TContextPopupEvent;
    Procedure SetOnContextPopup(AOnContextPopup : TContextPopupEvent);
    Function  GetOnDragDrop() : TDragDropEvent;
    Procedure SetOnDragDrop(AOnDragDrop : TDragDropEvent);
    Function  GetOnDragOver() : TDragOverEvent;
    Procedure SetOnDragOver(AOnDragOver : TDragOverEvent);
    Function  GetOnEndDock() : TEndDragEvent;
    Procedure SetOnEndDock(AOnEndDock : TEndDragEvent);
    Function  GetOnEndDrag() : TEndDragEvent;
    Procedure SetOnEndDrag(AOnEndDrag : TEndDragEvent);
    Function  GetOnEnter() : TNotifyEvent;
    Procedure SetOnEnter(AOnEnter : TNotifyEvent);
    Function  GetOnExit() : TNotifyEvent;
    Procedure SetOnExit(AOnExit : TNotifyEvent);
    Function  GetOnKeyDown() : TKeyEvent;
    Procedure SetOnKeyDown(AOnKeyDown : TKeyEvent);
    Function  GetOnKeyPress() : TKeyPressEvent;
    Procedure SetOnKeyPress(AOnKeyPress : TKeyPressEvent);
    Function  GetOnKeyUp() : TKeyEvent;
    Procedure SetOnKeyUp(AOnKeyUp : TKeyEvent);
    Function  GetOnScroll() : TScrollEvent;
    Procedure SetOnScroll(AOnScroll : TScrollEvent);
    Function  GetOnStartDock() : TStartDockEvent;
    Procedure SetOnStartDock(AOnStartDock : TStartDockEvent);
    Function  GetOnStartDrag() : TStartDragEvent;
    Procedure SetOnStartDrag(AOnStartDrag : TStartDragEvent);

  Published
    Property OnChange       : TNotifyEvent       Read GetOnChange       Write SetOnChange;
    Property OnContextPopup : TContextPopupEvent Read GetOnContextPopup Write SetOnContextPopup;
    Property OnDragDrop     : TDragDropEvent     Read GetOnDragDrop     Write SetOnDragDrop;
    Property OnDragOver     : TDragOverEvent     Read GetOnDragOver     Write SetOnDragOver;
    Property OnEndDock      : TEndDragEvent      Read GetOnEndDock      Write SetOnEndDock;
    Property OnEndDrag      : TEndDragEvent      Read GetOnEndDrag      Write SetOnEndDrag;
    Property OnEnter        : TNotifyEvent       Read GetOnEnter        Write SetOnEnter;
    Property OnExit         : TNotifyEvent       Read GetOnExit         Write SetOnExit;
    Property OnKeyDown      : TKeyEvent          Read GetOnKeyDown      Write SetOnKeyDown;
    Property OnKeyPress     : TKeyPressEvent     Read GetOnKeyPress     Write SetOnKeyPress;
    Property OnKeyUp        : TKeyEvent          Read GetOnKeyUp        Write SetOnKeyUp;
    Property OnScroll       : TScrollEvent       Read GetOnScroll       Write SetOnScroll;
    Property OnStartDock    : TStartDockEvent    Read GetOnStartDock    Write SetOnStartDock;
    Property OnStartDrag    : TStartDragEvent    Read GetOnStartDrag    Write SetOnStartDrag;

  Public
    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;

    Procedure RegisterEvent(ANotifyEvent, AEvent : TNotifyEvent); OverLoad;
    Procedure UnRegisterEvent(ANotifyEvent, AEvent : TNotifyEvent); OverLoad;
    Procedure EnableEvent(ANotifyEvent, AEvent : TNotifyEvent); OverLoad;
    Procedure DisableEvent(ANotifyEvent, AEvent : TNotifyEvent); OverLoad;

    Procedure RegisterEvent(ANotifyEvent, AEvent : TContextPopupEvent); OverLoad;
    Procedure UnRegisterEvent(ANotifyEvent, AEvent : TContextPopupEvent); OverLoad;
    Procedure EnableEvent(ANotifyEvent, AEvent : TContextPopupEvent); OverLoad;
    Procedure DisableEvent(ANotifyEvent, AEvent : TContextPopupEvent); OverLoad;

    Procedure RegisterEvent(ANotifyEvent, AEvent : TDragDropEvent); OverLoad;
    Procedure UnRegisterEvent(ANotifyEvent, AEvent : TDragDropEvent); OverLoad;
    Procedure EnableEvent(ANotifyEvent, AEvent : TDragDropEvent); OverLoad;
    Procedure DisableEvent(ANotifyEvent, AEvent : TDragDropEvent); OverLoad;

    Procedure RegisterEvent(ANotifyEvent, AEvent : TDragOverEvent); OverLoad;
    Procedure UnRegisterEvent(ANotifyEvent, AEvent : TDragOverEvent); OverLoad;
    Procedure EnableEvent(ANotifyEvent, AEvent : TDragOverEvent); OverLoad;
    Procedure DisableEvent(ANotifyEvent, AEvent : TDragOverEvent); OverLoad;

    Procedure RegisterEvent(ANotifyEvent, AEvent : TEndDragEvent); OverLoad;
    Procedure UnRegisterEvent(ANotifyEvent, AEvent : TEndDragEvent); OverLoad;
    Procedure EnableEvent(ANotifyEvent, AEvent : TEndDragEvent); OverLoad;
    Procedure DisableEvent(ANotifyEvent, AEvent : TEndDragEvent); OverLoad;

    Procedure RegisterEvent(ANotifyEvent, AEvent : TKeyEvent); OverLoad;
    Procedure UnRegisterEvent(ANotifyEvent, AEvent : TKeyEvent); OverLoad;
    Procedure EnableEvent(ANotifyEvent, AEvent : TKeyEvent); OverLoad;
    Procedure DisableEvent(ANotifyEvent, AEvent : TKeyEvent); OverLoad;

    Procedure RegisterEvent(ANotifyEvent, AEvent : TKeyPressEvent); OverLoad;
    Procedure UnRegisterEvent(ANotifyEvent, AEvent : TKeyPressEvent); OverLoad;
    Procedure EnableEvent(ANotifyEvent, AEvent : TKeyPressEvent); OverLoad;
    Procedure DisableEvent(ANotifyEvent, AEvent : TKeyPressEvent); OverLoad;

    Procedure RegisterEvent(ANotifyEvent, AEvent : TStartDockEvent); OverLoad;
    Procedure UnRegisterEvent(ANotifyEvent, AEvent : TStartDockEvent); OverLoad;
    Procedure EnableEvent(ANotifyEvent, AEvent : TStartDockEvent); OverLoad;
    Procedure DisableEvent(ANotifyEvent, AEvent : TStartDockEvent); OverLoad;

    Procedure RegisterEvent(ANotifyEvent, AEvent : TStartDragEvent); OverLoad;
    Procedure UnRegisterEvent(ANotifyEvent, AEvent : TStartDragEvent); OverLoad;
    Procedure EnableEvent(ANotifyEvent, AEvent : TStartDragEvent); OverLoad;
    Procedure DisableEvent(ANotifyEvent, AEvent : TStartDragEvent); OverLoad;

    Procedure RegisterEvent(ANotifyEvent, AEvent : TScrollEvent); OverLoad;
    Procedure UnRegisterEvent(ANotifyEvent, AEvent : TScrollEvent); OverLoad;
    Procedure EnableEvent(ANotifyEvent, AEvent : TScrollEvent); OverLoad;
    Procedure DisableEvent(ANotifyEvent, AEvent : TScrollEvent); OverLoad;

  End;

Implementation

Uses TypInfo, SysUtils;

Function TScrollEventListEx.Get(Index : Integer) : TScrollEvent;
Begin
  Result := TScrollEvent(InHerited Items[Index].Method);
End;

Procedure TScrollEventListEx.Put(Index : Integer; Item : TScrollEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TScrollEventListEx.Add(Item : TScrollEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TScrollEventListEx.Insert(Index: Integer; Item : TScrollEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TScrollEventListEx.Remove(Item : TScrollEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TScrollEventListEx.IndexOf(Item : TScrollEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TScrollEventListEx.GetExecuteProc() : TMethod;
Var lResult : TScrollEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TScrollEventListEx.Execute(Sender : TObject; ScrollCode : TScrollCode; Var ScrollPos : Integer);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TScrollEvent(lItem.Method)(Sender, ScrollCode, ScrollPos);
  End;
End;

Procedure TScrollBarDispatcher.InitEvents();
Var lProps      : TPropList;
    lNbProp     : Integer;
    X           : Integer;
Begin
  lNbProp := GetPropList(PTypeInfo(Component.ClassInfo), [tkMethod], @lProps, True);
  For X := 0 To lNbProp - 1 Do
  Begin
    If SameText(lProps[X].PropType^.Name, 'TScrollEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TScrollEventListEx));
  End;

  InHerited InitEvents();
End;
{
I don't know I have a life time subscription so I don't purchase guns individually.
But for sure I can't see the PPD-40, AR-18 and Daewoo USAS-12 in the game.
I'll try to re-install the game to see if it fixe it.
But as I said if it's not in-game update the latest version on Goggle Play is 12.2.0 released 30 may 2016.
}
Procedure TScrollBarDispatcher.RegisterScrollEvent(AEvent, ANewEvent : TScrollEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TScrollBarDispatcher.UnRegisterScrollEvent(AEvent, AOldEvent : TScrollEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TScrollBarDispatcher.DisableScrollEvent(AEvent, ADisabledEvent : TScrollEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TScrollBarDispatcher.EnableScrollEvent(AEvent, AEnabledEvent : TScrollEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

(******************************************************************************)

Procedure THsScrollBarEx.AfterConstruction();
Begin
  InHerited AfterConstruction();

  FEventDispatcher := TScrollBarDispatcher.Create(Self);
End;

Procedure THsScrollBarEx.BeforeDestruction();
Begin
  FEventDispatcher := Nil;
  
  InHerited BeforeDestruction();
End;

Function THsScrollBarEx.GetOnChange() : TNotifyEvent;
Begin
  Result := InHerited OnChange;
End;

Procedure THsScrollBarEx.SetOnChange(AOnChange : TNotifyEvent);
Begin
  If Assigned(FEventDispatcher) Then
  Begin
    FEventDispatcher.UnRegisterNotifyEvent(OnChange, FOnChange);
    If Assigned(AOnChange) Then
      FEventDispatcher.RegisterNotifyEvent(OnChange, AOnChange, 0);
    FOnChange := AOnChange;
  End
  Else
    InHerited OnChange := AOnChange;
End;

Function THsScrollBarEx.GetOnContextPopup() : TContextPopupEvent;
Begin
  Result := InHerited OnContextPopup;
End;

Procedure THsScrollBarEx.SetOnContextPopup(AOnContextPopup : TContextPopupEvent);
Begin
  If Assigned(FEventDispatcher) Then
  Begin
    FEventDispatcher.UnRegisterContextPopupEvent(OnContextPopup, FOnContextPopup);
    If Assigned(AOnContextPopup) Then
      FEventDispatcher.RegisterContextPopupEvent(OnContextPopup, AOnContextPopup, 0);
    FOnContextPopup := AOnContextPopup;
  End
  Else
    InHerited OnContextPopup := AOnContextPopup;
End;

Function THsScrollBarEx.GetOnDragDrop() : TDragDropEvent;
Begin
  Result := InHerited OnDragDrop;
End;

Procedure THsScrollBarEx.SetOnDragDrop(AOnDragDrop : TDragDropEvent);
Begin
  If Assigned(FEventDispatcher) Then
  Begin
    FEventDispatcher.UnRegisterDragDropEvent(OnDragDrop, FOnDragDrop);
    If Assigned(AOnDragDrop) Then
      FEventDispatcher.RegisterDragDropEvent(OnDragDrop, AOnDragDrop, 0);
    FOnDragDrop := AOnDragDrop;
  End
  Else
    InHerited OnDragDrop := AOnDragDrop;
End;

Function THsScrollBarEx.GetOnDragOver() : TDragOverEvent;
Begin
  Result := InHerited OnDragOver;
End;

Procedure THsScrollBarEx.SetOnDragOver(AOnDragOver : TDragOverEvent);
Begin
  If Assigned(FEventDispatcher) Then
  Begin
    FEventDispatcher.UnRegisterDragOverEvent(OnDragOver, FOnDragOver);
    If Assigned(AOnDragOver) Then
      FEventDispatcher.RegisterDragOverEvent(OnDragOver, AOnDragOver, 0);
    FOnDragOver := AOnDragOver;
  End
  Else
    InHerited OnDragOver := AOnDragOver;
End;

Function THsScrollBarEx.GetOnEndDock() : TEndDragEvent;
Begin
  Result := InHerited OnEndDock;
End;

Procedure THsScrollBarEx.SetOnEndDock(AOnEndDock : TEndDragEvent);
Begin
  If Assigned(FEventDispatcher) Then
  Begin
    FEventDispatcher.UnRegisterEndDragEvent(OnEndDock, FOnEndDock);
    If Assigned(AOnEndDock) Then
      FEventDispatcher.RegisterEndDragEvent(OnEndDock, AOnEndDock, 0);
    FOnEndDock := AOnEndDock;
  End
  Else
    InHerited OnEndDock := AOnEndDock;
End;

Function THsScrollBarEx.GetOnEndDrag() : TEndDragEvent;
Begin
  Result := InHerited OnEndDrag;
End;

Procedure THsScrollBarEx.SetOnEndDrag(AOnEndDrag : TEndDragEvent);
Begin
  If Assigned(FEventDispatcher) Then
  Begin
    FEventDispatcher.UnRegisterEndDragEvent(OnEndDrag, FOnEndDrag);
    If Assigned(AOnEndDrag) Then
      FEventDispatcher.RegisterEndDragEvent(OnEndDrag, AOnEndDrag, 0);
    FOnEndDrag := AOnEndDrag;
  End
  Else
    InHerited OnEndDrag := AOnEndDrag;
End;

Function THsScrollBarEx.GetOnEnter() : TNotifyEvent;
Begin
  Result := InHerited OnEnter;
End;

Procedure THsScrollBarEx.SetOnEnter(AOnEnter : TNotifyEvent);
Begin
  If Assigned(FEventDispatcher) Then
  Begin
    FEventDispatcher.UnRegisterNotifyEvent(OnEnter, FOnEnter);
    If Assigned(AOnEnter) Then
      FEventDispatcher.RegisterNotifyEvent(OnEnter, AOnEnter, 0);
    FOnEnter := AOnEnter;
  End
  Else
    InHerited OnEnter := AOnEnter;
End;

Function THsScrollBarEx.GetOnExit() : TNotifyEvent;
Begin
  Result := InHerited OnExit;
End;

Procedure THsScrollBarEx.SetOnExit(AOnExit : TNotifyEvent);
Begin
  If Assigned(FEventDispatcher) Then
  Begin
    FEventDispatcher.UnRegisterNotifyEvent(OnExit, FOnExit);
    If Assigned(AOnExit) Then
      FEventDispatcher.RegisterNotifyEvent(OnExit, AOnExit, 0);
    FOnExit := AOnExit;
  End
  Else
    InHerited OnExit := AOnExit;
End;

Function THsScrollBarEx.GetOnKeyDown() : TKeyEvent;
Begin
  Result := InHerited OnKeyDown;
End;

Procedure THsScrollBarEx.SetOnKeyDown(AOnKeyDown : TKeyEvent);
Begin
  If Assigned(FEventDispatcher) Then
  Begin
    FEventDispatcher.UnRegisterKeyEvent(OnKeyDown, FOnKeyDown);
    If Assigned(AOnKeyDown) Then
      FEventDispatcher.RegisterKeyEvent(OnKeyDown, AOnKeyDown, 0);
    FOnKeyDown := AOnKeyDown;
  End
  Else
    InHerited OnKeyDown := AOnKeyDown;
End;

Function THsScrollBarEx.GetOnKeyPress() : TKeyPressEvent;
Begin
  Result := InHerited OnKeyPress;
End;

Procedure THsScrollBarEx.SetOnKeyPress(AOnKeyPress : TKeyPressEvent);
Begin
  If Assigned(FEventDispatcher) Then
  Begin
    FEventDispatcher.UnRegisterKeyPressEvent(OnKeyPress, FOnKeyPress);
    If Assigned(AOnKeyPress) Then
      FEventDispatcher.RegisterKeyPressEvent(OnKeyPress, AOnKeyPress, 0);
    FOnKeyPress := AOnKeyPress;
  End
  Else
    InHerited OnKeyPress := AOnKeyPress;
End;

Function THsScrollBarEx.GetOnKeyUp() : TKeyEvent;
Begin
  Result := InHerited OnKeyUp;
End;

Procedure THsScrollBarEx.SetOnKeyUp(AOnKeyUp : TKeyEvent);
Begin
  If Assigned(FEventDispatcher) Then
  Begin
    FEventDispatcher.UnRegisterKeyEvent(OnKeyUp, FOnKeyUp);
    If Assigned(AOnKeyUp) Then
      FEventDispatcher.RegisterKeyEvent(OnKeyUp, AOnKeyUp, 0);
    FOnKeyUp := AOnKeyUp;
  End
  Else
    InHerited OnKeyUp := AOnKeyUp;
End;

Function THsScrollBarEx.GetOnScroll() : TScrollEvent;
Begin
  Result := InHerited OnScroll;
End;

Procedure THsScrollBarEx.SetOnScroll(AOnScroll : TScrollEvent);
Begin
  If Assigned(FEventDispatcher) Then
  Begin
    FEventDispatcher.UnRegisterScrollEvent(OnScroll, FOnScroll);
    If Assigned(AOnScroll) Then
      FEventDispatcher.RegisterScrollEvent(OnScroll, AOnScroll, 0);
    FOnScroll := AOnScroll;
  End
  Else
    InHerited OnScroll := AOnScroll;
End;

Function THsScrollBarEx.GetOnStartDock() : TStartDockEvent;
Begin
  Result := InHerited OnStartDock;
End;

Procedure THsScrollBarEx.SetOnStartDock(AOnStartDock : TStartDockEvent);
Begin
  If Assigned(FEventDispatcher) Then
  Begin
    FEventDispatcher.UnRegisterStartDockEvent(OnStartDock, FOnStartDock);
    If Assigned(AOnStartDock) Then
      FEventDispatcher.RegisterStartDockEvent(OnStartDock, AOnStartDock, 0);
    FOnStartDock := AOnStartDock;
  End
  Else
    InHerited OnStartDock := AOnStartDock;
End;

Function THsScrollBarEx.GetOnStartDrag() : TStartDragEvent;
Begin
  Result := InHerited OnStartDrag;
End;

Procedure THsScrollBarEx.SetOnStartDrag(AOnStartDrag : TStartDragEvent);
Begin
  If Assigned(FEventDispatcher) Then
  Begin
    FEventDispatcher.UnRegisterStartDragEvent(OnStartDrag, FOnStartDrag);
    If Assigned(AOnStartDrag) Then
      FEventDispatcher.RegisterStartDragEvent(OnStartDrag, AOnStartDrag, 0);
    FOnStartDrag := AOnStartDrag;
  End
  Else
    InHerited OnStartDrag := AOnStartDrag;
End;

Procedure THsScrollBarEx.RegisterEvent(ANotifyEvent, AEvent : TNotifyEvent);
Begin
  FEventDispatcher.RegisterNotifyEvent(ANotifyEvent, AEvent);
End;

Procedure THsScrollBarEx.UnRegisterEvent(ANotifyEvent, AEvent : TNotifyEvent);
Begin
  FEventDispatcher.UnRegisterNotifyEvent(ANotifyEvent, AEvent);
End;

Procedure THsScrollBarEx.EnableEvent(ANotifyEvent, AEvent : TNotifyEvent);
Begin
  FEventDispatcher.EnableNotifyEvent(ANotifyEvent, AEvent);
End;

Procedure THsScrollBarEx.DisableEvent(ANotifyEvent, AEvent : TNotifyEvent);
Begin
  FEventDispatcher.DisableNotifyEvent(ANotifyEvent, AEvent);
End;

Procedure THsScrollBarEx.RegisterEvent(ANotifyEvent, AEvent : TContextPopupEvent);
Begin
  FEventDispatcher.RegisterContextPopupEvent(ANotifyEvent, AEvent);
End;

Procedure THsScrollBarEx.UnRegisterEvent(ANotifyEvent, AEvent : TContextPopupEvent);
Begin
  FEventDispatcher.UnRegisterContextPopupEvent(ANotifyEvent, AEvent);
End;

Procedure THsScrollBarEx.EnableEvent(ANotifyEvent, AEvent : TContextPopupEvent);
Begin
  FEventDispatcher.EnableContextPopupEvent(ANotifyEvent, AEvent);
End;

Procedure THsScrollBarEx.DisableEvent(ANotifyEvent, AEvent : TContextPopupEvent);
Begin
  FEventDispatcher.DisableContextPopupEvent(ANotifyEvent, AEvent);
End;

Procedure THsScrollBarEx.RegisterEvent(ANotifyEvent, AEvent : TDragDropEvent);
Begin
  FEventDispatcher.RegisterDragDropEvent(ANotifyEvent, AEvent);
End;

Procedure THsScrollBarEx.UnRegisterEvent(ANotifyEvent, AEvent : TDragDropEvent);
Begin
  FEventDispatcher.UnRegisterDragDropEvent(ANotifyEvent, AEvent);
End;

Procedure THsScrollBarEx.EnableEvent(ANotifyEvent, AEvent : TDragDropEvent);
Begin
  FEventDispatcher.EnableDragDropEvent(ANotifyEvent, AEvent);
End;

Procedure THsScrollBarEx.DisableEvent(ANotifyEvent, AEvent : TDragDropEvent);
Begin
  FEventDispatcher.DisableDragDropEvent(ANotifyEvent, AEvent);
End;

Procedure THsScrollBarEx.RegisterEvent(ANotifyEvent, AEvent : TDragOverEvent);
Begin
  FEventDispatcher.RegisterDragOverEvent(ANotifyEvent, AEvent);
End;

Procedure THsScrollBarEx.UnRegisterEvent(ANotifyEvent, AEvent : TDragOverEvent);
Begin
  FEventDispatcher.UnRegisterDragOverEvent(ANotifyEvent, AEvent);
End;

Procedure THsScrollBarEx.EnableEvent(ANotifyEvent, AEvent : TDragOverEvent);
Begin
  FEventDispatcher.EnableDragOverEvent(ANotifyEvent, AEvent);
End;

Procedure THsScrollBarEx.DisableEvent(ANotifyEvent, AEvent : TDragOverEvent);
Begin
  FEventDispatcher.DisableDragOverEvent(ANotifyEvent, AEvent);
End;

Procedure THsScrollBarEx.RegisterEvent(ANotifyEvent, AEvent : TEndDragEvent);
Begin
  FEventDispatcher.RegisterEndDragEvent(ANotifyEvent, AEvent);
End;

Procedure THsScrollBarEx.UnRegisterEvent(ANotifyEvent, AEvent : TEndDragEvent);
Begin
  FEventDispatcher.UnRegisterEndDragEvent(ANotifyEvent, AEvent);
End;

Procedure THsScrollBarEx.EnableEvent(ANotifyEvent, AEvent : TEndDragEvent);
Begin
  FEventDispatcher.EnableEndDragEvent(ANotifyEvent, AEvent);
End;

Procedure THsScrollBarEx.DisableEvent(ANotifyEvent, AEvent : TEndDragEvent);
Begin
  FEventDispatcher.DisableEndDragEvent(ANotifyEvent, AEvent);
End;

Procedure THsScrollBarEx.RegisterEvent(ANotifyEvent, AEvent : TKeyEvent);
Begin
  FEventDispatcher.RegisterKeyEvent(ANotifyEvent, AEvent);
End;

Procedure THsScrollBarEx.UnRegisterEvent(ANotifyEvent, AEvent : TKeyEvent);
Begin
  FEventDispatcher.UnRegisterKeyEvent(ANotifyEvent, AEvent);
End;

Procedure THsScrollBarEx.EnableEvent(ANotifyEvent, AEvent : TKeyEvent);
Begin
  FEventDispatcher.EnableKeyEvent(ANotifyEvent, AEvent);
End;

Procedure THsScrollBarEx.DisableEvent(ANotifyEvent, AEvent : TKeyEvent);
Begin
  FEventDispatcher.DisableKeyEvent(ANotifyEvent, AEvent);
End;

Procedure THsScrollBarEx.RegisterEvent(ANotifyEvent, AEvent : TKeyPressEvent);
Begin
  FEventDispatcher.RegisterKeyPressEvent(ANotifyEvent, AEvent);
End;

Procedure THsScrollBarEx.UnRegisterEvent(ANotifyEvent, AEvent : TKeyPressEvent);
Begin
  FEventDispatcher.UnRegisterKeyPressEvent(ANotifyEvent, AEvent);
End;

Procedure THsScrollBarEx.EnableEvent(ANotifyEvent, AEvent : TKeyPressEvent);
Begin
  FEventDispatcher.EnableKeyPressEvent(ANotifyEvent, AEvent);
End;

Procedure THsScrollBarEx.DisableEvent(ANotifyEvent, AEvent : TKeyPressEvent);
Begin
  FEventDispatcher.DisableKeyPressEvent(ANotifyEvent, AEvent);
End;

Procedure THsScrollBarEx.RegisterEvent(ANotifyEvent, AEvent : TStartDockEvent);
Begin
  FEventDispatcher.RegisterStartDockEvent(ANotifyEvent, AEvent);
End;

Procedure THsScrollBarEx.UnRegisterEvent(ANotifyEvent, AEvent : TStartDockEvent);
Begin
  FEventDispatcher.UnRegisterStartDockEvent(ANotifyEvent, AEvent);
End;

Procedure THsScrollBarEx.EnableEvent(ANotifyEvent, AEvent : TStartDockEvent);
Begin
  FEventDispatcher.EnableStartDockEvent(ANotifyEvent, AEvent);
End;

Procedure THsScrollBarEx.DisableEvent(ANotifyEvent, AEvent : TStartDockEvent);
Begin
  FEventDispatcher.DisableStartDockEvent(ANotifyEvent, AEvent);
End;

Procedure THsScrollBarEx.RegisterEvent(ANotifyEvent, AEvent : TStartDragEvent);
Begin
  FEventDispatcher.RegisterStartDragEvent(ANotifyEvent, AEvent);
End;

Procedure THsScrollBarEx.UnRegisterEvent(ANotifyEvent, AEvent : TStartDragEvent);
Begin
  FEventDispatcher.UnRegisterStartDragEvent(ANotifyEvent, AEvent);
End;

Procedure THsScrollBarEx.EnableEvent(ANotifyEvent, AEvent : TStartDragEvent);
Begin
  FEventDispatcher.EnableStartDragEvent(ANotifyEvent, AEvent);
End;

Procedure THsScrollBarEx.DisableEvent(ANotifyEvent, AEvent : TStartDragEvent);
Begin
  FEventDispatcher.DisableStartDragEvent(ANotifyEvent, AEvent);
End;

Procedure THsScrollBarEx.RegisterEvent(ANotifyEvent, AEvent : TScrollEvent);
Begin
  FEventDispatcher.RegisterScrollEvent(ANotifyEvent, AEvent);
End;

Procedure THsScrollBarEx.UnRegisterEvent(ANotifyEvent, AEvent : TScrollEvent);
Begin
  FEventDispatcher.UnRegisterScrollEvent(ANotifyEvent, AEvent);
End;

Procedure THsScrollBarEx.EnableEvent(ANotifyEvent, AEvent : TScrollEvent);
Begin
  FEventDispatcher.EnableScrollEvent(ANotifyEvent, AEvent);
End;

Procedure THsScrollBarEx.DisableEvent(ANotifyEvent, AEvent : TScrollEvent);
Begin
  FEventDispatcher.DisableScrollEvent(ANotifyEvent, AEvent);
End;

End.
