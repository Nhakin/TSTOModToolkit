unit HsSpeedButtonEx;

interface

Uses Classes, Controls, Buttons,
  HsEventListEx;

Type
  THsSpeedButtonEx = Class(TSpeedButton)
  Private
    FOnClick         : TNotifyEvent;
    FOnDblClick      : TNotifyEvent;
    FOnMouseDown     : TMouseEvent;
    FOnMouseUp       : TMouseEvent;
    FOnMouseMove     : TMouseMoveEvent;
    FEventDispatcher : IEventDispatcher;

    Function  GetOnClick() : TNotifyEvent;
    Procedure SetOnClick(AOnClick : TNotifyEvent);

    Function  GetOnDblClick() : TNotifyEvent;
    Procedure SetOnDblClick(AOnDblClick : TNotifyEvent);

    Function  GetOnMouseDown() : TMouseEvent;
    Procedure SetOnMouseDown(AOnMouseDown : TMouseEvent);

    Function  GetOnMouseUp() : TMouseEvent;
    Procedure SetOnMouseUp(AOnMouseUp : TMouseEvent);

    Function  GetOnMouseMove() : TMouseMoveEvent;
    Procedure SetOnMouseMove(AOnMouseMove : TMouseMoveEvent);

  Published
    Property OnClick     : TNotifyEvent    Read GetOnClick     Write SetOnClick;
    Property OnDblClick  : TNotifyEvent    Read GetOnDblClick  Write SetOnDblClick;
    Property OnMouseDown : TMouseEvent     Read GetOnMouseDown Write SetOnMouseDown;
    Property OnMouseUp   : TMouseEvent     Read GetOnMouseUp   Write SetOnMouseUp;
    Property OnMouseMove : TMouseMoveEvent Read GetOnMouseMove Write SetOnMouseMove;

  Public
    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;

    Procedure RegisterEvent(ANotifyEvent, AEvent : TNotifyEvent); OverLoad;
    Procedure RegisterEvent(ANotifyEvent, AEvent : TMouseEvent); OverLoad;
    Procedure RegisterEvent(ANotifyEvent, AEvent : TMouseMoveEvent); OverLoad;

    Procedure UnRegisterEvent(ANotifyEvent, AEvent : TNotifyEvent); OverLoad;
    Procedure UnRegisterEvent(ANotifyEvent, AEvent : TMouseEvent); OverLoad;
    Procedure UnRegisterEvent(ANotifyEvent, AEvent : TMouseMoveEvent); OverLoad;

    Procedure EnableEvent(ANotifyEvent, AEvent : TNotifyEvent); OverLoad;
    Procedure EnableEvent(ANotifyEvent, AEvent : TMouseEvent); OverLoad;
    Procedure EnableEvent(ANotifyEvent, AEvent : TMouseMoveEvent); OverLoad;

    Procedure DisableEvent(ANotifyEvent, AEvent : TNotifyEvent); OverLoad;
    Procedure DisableEvent(ANotifyEvent, AEvent : TMouseEvent); OverLoad;
    Procedure DisableEvent(ANotifyEvent, AEvent : TMouseMoveEvent); OverLoad;

  End;

implementation

Procedure THsSpeedButtonEx.AfterConstruction();
Begin
  InHerited AfterConstruction();

  FEventDispatcher := TCustomEventDispatcher.Create(Self);
End;

Procedure THsSpeedButtonEx.BeforeDestruction();
Begin
  FEventDispatcher := Nil;
  
  InHerited BeforeDestruction();
End;

Function THsSpeedButtonEx.GetOnClick() : TNotifyEvent;
Begin
  Result := InHerited OnClick;
End;

Procedure THsSpeedButtonEx.SetOnClick(AOnClick : TNotifyEvent);
Begin
  If Assigned(FEventDispatcher) Then
  Begin
    FEventDispatcher.UnRegisterNotifyEvent(OnClick, FOnClick);
    If Assigned(AOnClick) Then
      FEventDispatcher.RegisterNotifyEvent(OnClick, AOnClick, 0);
    FOnClick := AOnClick;
  End
  Else
    InHerited OnClick := AOnClick;
End;

Function THsSpeedButtonEx.GetOnDblClick() : TNotifyEvent;
Begin
  Result := InHerited OnDblClick;
End;

Procedure THsSpeedButtonEx.SetOnDblClick(AOnDblClick : TNotifyEvent);
Begin
  If Assigned(FEventDispatcher) Then
  Begin
    FEventDispatcher.UnRegisterNotifyEvent(OnDblClick, FOnDblClick);
    If Assigned(AOnDblClick) Then
      FEventDispatcher.RegisterNotifyEvent(OnDblClick, AOnDblClick, 0);
    FOnDblClick := AOnDblClick;
  End
  Else
    InHerited OnDblClick := AOnDblClick;
End;

Function THsSpeedButtonEx.GetOnMouseDown() : TMouseEvent;
Begin
  Result := InHerited OnMouseDown;
End;

Procedure THsSpeedButtonEx.SetOnMouseDown(AOnMouseDown : TMouseEvent);
Begin
  If Assigned(FEventDispatcher) Then
  Begin
    FEventDispatcher.UnRegisterMouseEvent(OnMouseDown, FOnMouseDown);
    If Assigned(AOnMouseDown) Then
      FEventDispatcher.RegisterMouseEvent(OnMouseDown, AOnMouseDown, 0);
    FOnMouseDown := AOnMouseDown;
  End
  Else
    InHerited OnMouseDown := AOnMouseDown;
End;

Function THsSpeedButtonEx.GetOnMouseUp() : TMouseEvent;
Begin
  Result := InHerited OnMouseUp;
End;

Procedure THsSpeedButtonEx.SetOnMouseUp(AOnMouseUp : TMouseEvent);
Begin
  If Assigned(FEventDispatcher) Then
  Begin
    FEventDispatcher.UnRegisterMouseEvent(OnMouseUp, FOnMouseUp);
    If Assigned(AOnMouseUp) Then
      FEventDispatcher.RegisterMouseEvent(OnMouseUp, AOnMouseUp, 0);
    FOnMouseUp := AOnMouseUp;
  End
  Else
    InHerited OnMouseUp := AOnMouseUp;
End;

Function THsSpeedButtonEx.GetOnMouseMove() : TMouseMoveEvent;
Begin
  Result := InHerited OnMouseMove;
End;

Procedure THsSpeedButtonEx.SetOnMouseMove(AOnMouseMove : TMouseMoveEvent);
Begin
  If Assigned(FEventDispatcher) Then
  Begin
    FEventDispatcher.UnRegisterMouseMoveEvent(OnMouseMove, FOnMouseMove);
    If Assigned(AOnMouseMove) Then
      FEventDispatcher.RegisterMouseMoveEvent(OnMouseMove, AOnMouseMove, 0);
    FOnMouseMove := AOnMouseMove;
  End
  Else
    InHerited OnMouseMove := AOnMouseMove;
End;

Procedure THsSpeedButtonEx.RegisterEvent(ANotifyEvent, AEvent : TNotifyEvent);
Begin
  FEventDispatcher.RegisterNotifyEvent(ANotifyEvent, AEvent);
End;

Procedure THsSpeedButtonEx.RegisterEvent(ANotifyEvent, AEvent : TMouseEvent);
Begin
  FEventDispatcher.RegisterMouseEvent(ANotifyEvent, AEvent);
End;

Procedure THsSpeedButtonEx.RegisterEvent(ANotifyEvent, AEvent : TMouseMoveEvent);
Begin
  FEventDispatcher.RegisterMouseMoveEvent(ANotifyEvent, AEvent);
End;

Procedure THsSpeedButtonEx.UnRegisterEvent(ANotifyEvent, AEvent : TNotifyEvent);
Begin
  FEventDispatcher.UnRegisterNotifyEvent(ANotifyEvent, AEvent);
End;

Procedure THsSpeedButtonEx.UnRegisterEvent(ANotifyEvent, AEvent : TMouseEvent);
Begin
  FEventDispatcher.UnRegisterMouseEvent(ANotifyEvent, AEvent);
End;

Procedure THsSpeedButtonEx.UnRegisterEvent(ANotifyEvent, AEvent : TMouseMoveEvent);
Begin
  FEventDispatcher.UnRegisterMouseMoveEvent(ANotifyEvent, AEvent);
End;

Procedure THsSpeedButtonEx.EnableEvent(ANotifyEvent, AEvent : TNotifyEvent);
Begin
  FEventDispatcher.EnableNotifyEvent(ANotifyEvent, AEvent);
End;

Procedure THsSpeedButtonEx.EnableEvent(ANotifyEvent, AEvent : TMouseEvent);
Begin
  FEventDispatcher.EnableMouseEvent(ANotifyEvent, AEvent);
End;

Procedure THsSpeedButtonEx.EnableEvent(ANotifyEvent, AEvent : TMouseMoveEvent);
Begin
  FEventDispatcher.EnableMouseMoveEvent(ANotifyEvent, AEvent);
End;

Procedure THsSpeedButtonEx.DisableEvent(ANotifyEvent, AEvent : TNotifyEvent);
Begin
  FEventDispatcher.DisableNotifyEvent(ANotifyEvent, AEvent);
End;

Procedure THsSpeedButtonEx.DisableEvent(ANotifyEvent, AEvent : TMouseEvent);
Begin
  FEventDispatcher.DisableMouseEvent(ANotifyEvent, AEvent);
End;

Procedure THsSpeedButtonEx.DisableEvent(ANotifyEvent, AEvent : TMouseMoveEvent);
Begin
  FEventDispatcher.DisableMouseMoveEvent(ANotifyEvent, AEvent);
End;

end.
