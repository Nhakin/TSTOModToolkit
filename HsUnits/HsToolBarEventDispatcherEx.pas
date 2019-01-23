unit HsToolBarEventDispatcherEx;

interface

Uses
  Windows, ComCtrls, HsEventListEx;

Type
  ITBAdvancedCustomDrawEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-A457-1266CEFCC7F6}']
    Function  Get(Index : Integer) : TTBAdvancedCustomDrawEvent;
    Procedure Put(Index : Integer; Item : TTBAdvancedCustomDrawEvent);

    Function  Add(Item : TTBAdvancedCustomDrawEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TTBAdvancedCustomDrawEvent);
    Function  Remove(Item : TTBAdvancedCustomDrawEvent) : Integer;

    Procedure Execute(Sender : TToolBar; Const ARect : TRect;
      Stage : TCustomDrawStage; Var DefaultDraw : Boolean);

    Property Items[Index : Integer] : TTBAdvancedCustomDrawEvent Read Get Write Put; Default;

  End;

  ITBAdvancedCustomDrawBtnEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-98F5-FC1D6F540F3E}']
    Function  Get(Index : Integer) : TTBAdvancedCustomDrawBtnEvent;
    Procedure Put(Index : Integer; Item : TTBAdvancedCustomDrawBtnEvent);

    Function  Add(Item : TTBAdvancedCustomDrawBtnEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TTBAdvancedCustomDrawBtnEvent);
    Function  Remove(Item : TTBAdvancedCustomDrawBtnEvent) : Integer;

    Procedure Execute(Sender : TToolBar; Button : TToolButton;
      State : TCustomDrawState; Stage : TCustomDrawStage;
      Var Flags : TTBCustomDrawFlags; Var DefaultDraw : Boolean);

    Property Items[Index : Integer] : TTBAdvancedCustomDrawBtnEvent Read Get Write Put; Default;

  End;

  ITBCustomDrawEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-934B-0DAC411B4E86}']
    Function  Get(Index : Integer) : TTBCustomDrawEvent;
    Procedure Put(Index : Integer; Item : TTBCustomDrawEvent);

    Function  Add(Item : TTBCustomDrawEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TTBCustomDrawEvent);
    Function  Remove(Item : TTBCustomDrawEvent) : Integer;

    Procedure Execute(Sender : TToolBar; Const ARect : TRect; Var DefaultDraw : Boolean);

    Property Items[Index : Integer] : TTBCustomDrawEvent Read Get Write Put; Default;

  End;

  ITBCustomDrawBtnEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-A56D-01498780A179}']
    Function  Get(Index : Integer) : TTBCustomDrawBtnEvent;
    Procedure Put(Index : Integer; Item : TTBCustomDrawBtnEvent);

    Function  Add(Item : TTBCustomDrawBtnEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TTBCustomDrawBtnEvent);
    Function  Remove(Item : TTBCustomDrawBtnEvent) : Integer;

    Procedure Execute(Sender : TToolBar; Button : TToolButton;
      State : TCustomDrawState; Var DefaultDraw : Boolean);

    Property Items[Index : Integer] : TTBCustomDrawBtnEvent Read Get Write Put; Default;

  End;

  ITBButtonEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-AE22-CAD7991F8FD6}']
    Function  Get(Index : Integer) : TTBButtonEvent;
    Procedure Put(Index : Integer; Item : TTBButtonEvent);

    Function  Add(Item : TTBButtonEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TTBButtonEvent);
    Function  Remove(Item : TTBButtonEvent) : Integer;

    Procedure Execute(Sender : TToolbar; Button : TToolButton);

    Property Items[Index : Integer] : TTBButtonEvent Read Get Write Put; Default;

  End;
    
  ITBCustomizeQueryEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-9FFA-ECEE4C44761E}']
    Function  Get(Index : Integer) : TTBCustomizeQueryEvent;
    Procedure Put(Index : Integer; Item : TTBCustomizeQueryEvent);

    Function  Add(Item : TTBCustomizeQueryEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TTBCustomizeQueryEvent);
    Function  Remove(Item : TTBCustomizeQueryEvent) : Integer;

    Procedure Execute(Sender : TToolbar; Index : Integer; Var Allow : Boolean);

    Property Items[Index : Integer] : TTBCustomizeQueryEvent Read Get Write Put; Default;

  End;

  ITBNewButtonEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-B2F2-8D5AE9CED053}']
    Function  Get(Index : Integer) : TTBNewButtonEvent;
    Procedure Put(Index : Integer; Item : TTBNewButtonEvent);

    Function  Add(Item : TTBNewButtonEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TTBNewButtonEvent);
    Function  Remove(Item : TTBNewButtonEvent) : Integer;

    Procedure Execute(Sender : TToolbar; Index : Integer; Var Button : TToolButton);

    Property Items[Index : Integer] : TTBNewButtonEvent Read Get Write Put; Default;

  End;
  
  TTBAdvancedCustomDrawEventListEx = Class(TMethodListEx, ITBAdvancedCustomDrawEventListEx)
  Protected
    Function  Get(Index : Integer) : TTBAdvancedCustomDrawEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TTBAdvancedCustomDrawEvent); OverLoad;

  Public
    Property Items[Index : Integer] : TTBAdvancedCustomDrawEvent Read Get Write Put; Default;

    Function  Add(Item : TTBAdvancedCustomDrawEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TTBAdvancedCustomDrawEvent); OverLoad;
    Function  Remove(Item : TTBAdvancedCustomDrawEvent) : Integer; OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;
    Procedure Execute(Sender : TToolBar; Const ARect : TRect;
      Stage : TCustomDrawStage; Var DefaultDraw : Boolean);

  End;

  TTBAdvancedCustomDrawBtnEventListEx = Class(TMethodListEx, ITBAdvancedCustomDrawBtnEventListEx)
  Protected
    Function  Get(Index : Integer) : TTBAdvancedCustomDrawBtnEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TTBAdvancedCustomDrawBtnEvent); OverLoad;

  Public
    Property Items[Index : Integer] : TTBAdvancedCustomDrawBtnEvent Read Get Write Put; Default;

    Function  Add(Item : TTBAdvancedCustomDrawBtnEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TTBAdvancedCustomDrawBtnEvent); OverLoad;
    Function  Remove(Item : TTBAdvancedCustomDrawBtnEvent) : Integer; OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;
    Procedure Execute(Sender : TToolBar; Button : TToolButton;
      State : TCustomDrawState; Stage : TCustomDrawStage;
      Var Flags : TTBCustomDrawFlags; Var DefaultDraw : Boolean);

  End;

  TTBCustomDrawEventListEx = Class(TMethodListEx, ITBCustomDrawEventListEx)
  Protected
    Function  Get(Index : Integer) : TTBCustomDrawEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TTBCustomDrawEvent); OverLoad;

  Public
    Property Items[Index : Integer] : TTBCustomDrawEvent Read Get Write Put; Default;

    Function  Add(Item : TTBCustomDrawEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TTBCustomDrawEvent); OverLoad;
    Function  Remove(Item : TTBCustomDrawEvent) : Integer; OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;
    Procedure Execute(Sender : TToolBar; Const ARect : TRect; Var DefaultDraw : Boolean);

  End;
  
  TTBCustomDrawBtnEventListEx = Class(TMethodListEx, ITBCustomDrawBtnEventListEx)
  Protected
    Function  Get(Index : Integer) : TTBCustomDrawBtnEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TTBCustomDrawBtnEvent); OverLoad;

  Public
    Property Items[Index : Integer] : TTBCustomDrawBtnEvent Read Get Write Put; Default;

    Function  Add(Item : TTBCustomDrawBtnEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TTBCustomDrawBtnEvent); OverLoad;
    Function  Remove(Item : TTBCustomDrawBtnEvent) : Integer; OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;
    Procedure Execute(Sender : TToolBar; Button : TToolButton;
      State : TCustomDrawState; Var DefaultDraw : Boolean);

  End;

  TTBButtonEventListEx = Class(TMethodListEx, ITBButtonEventListEx)
  Protected
    Function  Get(Index : Integer) : TTBButtonEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TTBButtonEvent); OverLoad;

  Public
    Property Items[Index : Integer] : TTBButtonEvent Read Get Write Put; Default;

    Function  Add(Item : TTBButtonEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TTBButtonEvent); OverLoad;
    Function  Remove(Item : TTBButtonEvent) : Integer; OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;
    Procedure Execute(Sender : TToolbar; Button : TToolButton);

  End;

  TTBCustomizeQueryEventListEx = Class(TMethodListEx, ITBCustomizeQueryEventListEx)
  Protected
    Function  Get(Index : Integer) : TTBCustomizeQueryEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TTBCustomizeQueryEvent); OverLoad;

  Public
    Property Items[Index : Integer] : TTBCustomizeQueryEvent Read Get Write Put; Default;

    Function  Add(Item : TTBCustomizeQueryEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TTBCustomizeQueryEvent); OverLoad;
    Function  Remove(Item : TTBCustomizeQueryEvent) : Integer; OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;
    Procedure Execute(Sender : TToolbar; Index : Integer; Var Allow : Boolean);

  End;

  TTBNewButtonEventListEx = Class(TMethodListEx, ITBNewButtonEventListEx)
  Protected
    Function  Get(Index : Integer) : TTBNewButtonEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TTBNewButtonEvent); OverLoad;

  Public
    Property Items[Index : Integer] : TTBNewButtonEvent Read Get Write Put; Default;

    Function  Add(Item : TTBNewButtonEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TTBNewButtonEvent); OverLoad;
    Function  Remove(Item : TTBNewButtonEvent) : Integer; OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;
    Procedure Execute(Sender : TToolbar; Index : Integer; Var Button : TToolButton);

  End;

(******************************************************************************)

  IToolBarEventDispatcher = Interface(IEventDispatcher)
    ['{4B61686E-29A0-2112-891E-F65CE31E636E}']
    Procedure RegisterTBAdvancedCustomDrawEvent(AEvent, ANewEvent : TTBAdvancedCustomDrawEvent; Const Index : Integer = -1);
    Procedure UnRegisterTBAdvancedCustomDrawEvent(AEvent, AOldEvent : TTBAdvancedCustomDrawEvent);
    Procedure DisableTBAdvancedCustomDrawEvent(AEvent, ADisabledEvent : TTBAdvancedCustomDrawEvent);
    Procedure EnableTBAdvancedCustomDrawEvent(AEvent, AEnabledEvent : TTBAdvancedCustomDrawEvent);

    Procedure RegisterTBAdvancedCustomDrawBtnEvent(AEvent, ANewEvent : TTBAdvancedCustomDrawBtnEvent; Const Index : Integer = -1);
    Procedure UnRegisterTBAdvancedCustomDrawBtnEvent(AEvent, AOldEvent : TTBAdvancedCustomDrawBtnEvent);
    Procedure DisableTBAdvancedCustomDrawBtnEvent(AEvent, ADisabledEvent : TTBAdvancedCustomDrawBtnEvent);
    Procedure EnableTBAdvancedCustomDrawBtnEvent(AEvent, AEnabledEvent : TTBAdvancedCustomDrawBtnEvent);

    Procedure RegisterTBCustomDrawEvent(AEvent, ANewEvent : TTBCustomDrawEvent; Const Index : Integer = -1);
    Procedure UnRegisterTBCustomDrawEvent(AEvent, AOldEvent : TTBCustomDrawEvent);
    Procedure DisableTBCustomDrawEvent(AEvent, ADisabledEvent : TTBCustomDrawEvent);
    Procedure EnableTBCustomDrawEvent(AEvent, AEnabledEvent : TTBCustomDrawEvent);

    Procedure RegisterTBCustomDrawBtnEvent(AEvent, ANewEvent : TTBCustomDrawBtnEvent; Const Index : Integer = -1);
    Procedure UnRegisterTBCustomDrawBtnEvent(AEvent, AOldEvent : TTBCustomDrawBtnEvent);
    Procedure DisableTBCustomDrawBtnEvent(AEvent, ADisabledEvent : TTBCustomDrawBtnEvent);
    Procedure EnableTBCustomDrawBtnEvent(AEvent, AEnabledEvent : TTBCustomDrawBtnEvent);

    Procedure RegisterTBButtonEvent(AEvent, ANewEvent : TTBButtonEvent; Const Index : Integer = -1);
    Procedure UnRegisterTBButtonEvent(AEvent, AOldEvent : TTBButtonEvent);
    Procedure DisableTBButtonEvent(AEvent, ADisabledEvent : TTBButtonEvent);
    Procedure EnableTBButtonEvent(AEvent, AEnabledEvent : TTBButtonEvent);

    Procedure RegisterTBCustomizeQueryEvent(AEvent, ANewEvent : TTBCustomizeQueryEvent; Const Index : Integer = -1);
    Procedure UnRegisterTBCustomizeQueryEvent(AEvent, AOldEvent : TTBCustomizeQueryEvent);
    Procedure DisableTBCustomizeQueryEvent(AEvent, ADisabledEvent : TTBCustomizeQueryEvent);
    Procedure EnableTBCustomizeQueryEvent(AEvent, AEnabledEvent : TTBCustomizeQueryEvent);

    Procedure RegisterTBNewButtonEvent(AEvent, ANewEvent : TTBNewButtonEvent; Const Index : Integer = -1);
    Procedure UnRegisterTBNewButtonEvent(AEvent, AOldEvent : TTBNewButtonEvent);
    Procedure DisableTBNewButtonEvent(AEvent, ADisabledEvent : TTBNewButtonEvent);
    Procedure EnableTBNewButtonEvent(AEvent, AEnabledEvent : TTBNewButtonEvent);
    
  End;

  TToolBarEventDispatcher = Class(TCustomEventDispatcher, IToolBarEventDispatcher)
  Protected
    Procedure InitEvents(); OverRide;

    //IToolBarEventDispatcher
    Procedure RegisterTBAdvancedCustomDrawEvent(AEvent, ANewEvent : TTBAdvancedCustomDrawEvent; Const Index : Integer = -1);
    Procedure UnRegisterTBAdvancedCustomDrawEvent(AEvent, AOldEvent : TTBAdvancedCustomDrawEvent);
    Procedure DisableTBAdvancedCustomDrawEvent(AEvent, ADisabledEvent : TTBAdvancedCustomDrawEvent);
    Procedure EnableTBAdvancedCustomDrawEvent(AEvent, AEnabledEvent : TTBAdvancedCustomDrawEvent);

    Procedure RegisterTBAdvancedCustomDrawBtnEvent(AEvent, ANewEvent : TTBAdvancedCustomDrawBtnEvent; Const Index : Integer = -1);
    Procedure UnRegisterTBAdvancedCustomDrawBtnEvent(AEvent, AOldEvent : TTBAdvancedCustomDrawBtnEvent);
    Procedure DisableTBAdvancedCustomDrawBtnEvent(AEvent, ADisabledEvent : TTBAdvancedCustomDrawBtnEvent);
    Procedure EnableTBAdvancedCustomDrawBtnEvent(AEvent, AEnabledEvent : TTBAdvancedCustomDrawBtnEvent);

    Procedure RegisterTBCustomDrawEvent(AEvent, ANewEvent : TTBCustomDrawEvent; Const Index : Integer = -1);
    Procedure UnRegisterTBCustomDrawEvent(AEvent, AOldEvent : TTBCustomDrawEvent);
    Procedure DisableTBCustomDrawEvent(AEvent, ADisabledEvent : TTBCustomDrawEvent);
    Procedure EnableTBCustomDrawEvent(AEvent, AEnabledEvent : TTBCustomDrawEvent);

    Procedure RegisterTBCustomDrawBtnEvent(AEvent, ANewEvent : TTBCustomDrawBtnEvent; Const Index : Integer = -1);
    Procedure UnRegisterTBCustomDrawBtnEvent(AEvent, AOldEvent : TTBCustomDrawBtnEvent);
    Procedure DisableTBCustomDrawBtnEvent(AEvent, ADisabledEvent : TTBCustomDrawBtnEvent);
    Procedure EnableTBCustomDrawBtnEvent(AEvent, AEnabledEvent : TTBCustomDrawBtnEvent);

    Procedure RegisterTBButtonEvent(AEvent, ANewEvent : TTBButtonEvent; Const Index : Integer = -1);
    Procedure UnRegisterTBButtonEvent(AEvent, AOldEvent : TTBButtonEvent);
    Procedure DisableTBButtonEvent(AEvent, ADisabledEvent : TTBButtonEvent);
    Procedure EnableTBButtonEvent(AEvent, AEnabledEvent : TTBButtonEvent);

    Procedure RegisterTBCustomizeQueryEvent(AEvent, ANewEvent : TTBCustomizeQueryEvent; Const Index : Integer = -1);
    Procedure UnRegisterTBCustomizeQueryEvent(AEvent, AOldEvent : TTBCustomizeQueryEvent);
    Procedure DisableTBCustomizeQueryEvent(AEvent, ADisabledEvent : TTBCustomizeQueryEvent);
    Procedure EnableTBCustomizeQueryEvent(AEvent, AEnabledEvent : TTBCustomizeQueryEvent);

    Procedure RegisterTBNewButtonEvent(AEvent, ANewEvent : TTBNewButtonEvent; Const Index : Integer = -1);
    Procedure UnRegisterTBNewButtonEvent(AEvent, AOldEvent : TTBNewButtonEvent);
    Procedure DisableTBNewButtonEvent(AEvent, ADisabledEvent : TTBNewButtonEvent);
    Procedure EnableTBNewButtonEvent(AEvent, AEnabledEvent : TTBNewButtonEvent);

  End;

implementation

Uses SysUtils, TypInfo;

Function TTBAdvancedCustomDrawEventListEx.Get(Index : Integer) : TTBAdvancedCustomDrawEvent;
Begin
  Result := TTBAdvancedCustomDrawEvent(InHerited Items[Index].Method);
End;

Procedure TTBAdvancedCustomDrawEventListEx.Put(Index : Integer; Item : TTBAdvancedCustomDrawEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TTBAdvancedCustomDrawEventListEx.Add(Item : TTBAdvancedCustomDrawEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TTBAdvancedCustomDrawEventListEx.Insert(Index : Integer; Item : TTBAdvancedCustomDrawEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TTBAdvancedCustomDrawEventListEx.Remove(Item : TTBAdvancedCustomDrawEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TTBAdvancedCustomDrawEventListEx.GetExecuteProc() : TMethod;
Var lRetVal : TTBAdvancedCustomDrawEvent;
Begin
  lRetVal := Execute;
  Result  := TMethod(lRetVal);
End;

Procedure TTBAdvancedCustomDrawEventListEx.Execute(Sender : TToolBar; Const ARect : TRect;
  Stage : TCustomDrawStage; Var DefaultDraw : Boolean);
Var Z : Integer;
    lItem : IMethodEx;
Begin
  For Z := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[Z];
    If lItem.Enabled Then
      TTBAdvancedCustomDrawEvent(lItem.Method)(Sender, ARect, Stage, DefaultDraw);
  End;
End;

Function TTBAdvancedCustomDrawBtnEventListEx.Get(Index : Integer) : TTBAdvancedCustomDrawBtnEvent;
Begin
  Result := TTBAdvancedCustomDrawBtnEvent(InHerited Items[Index].Method);
End;

Procedure TTBAdvancedCustomDrawBtnEventListEx.Put(Index : Integer; Item : TTBAdvancedCustomDrawBtnEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TTBAdvancedCustomDrawBtnEventListEx.Add(Item : TTBAdvancedCustomDrawBtnEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TTBAdvancedCustomDrawBtnEventListEx.Insert(Index : Integer; Item : TTBAdvancedCustomDrawBtnEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TTBAdvancedCustomDrawBtnEventListEx.Remove(Item : TTBAdvancedCustomDrawBtnEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TTBAdvancedCustomDrawBtnEventListEx.GetExecuteProc() : TMethod;
Var lRetVal : TTBAdvancedCustomDrawBtnEvent;
Begin
  lRetVal := Execute;
  Result  := TMethod(lRetVal);
End;

Function TTBCustomDrawEventListEx.Get(Index : Integer) : TTBCustomDrawEvent;
Begin
  Result := TTBCustomDrawEvent(InHerited Items[Index].Method);
End;

Procedure TTBCustomDrawEventListEx.Put(Index : Integer; Item : TTBCustomDrawEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TTBCustomDrawEventListEx.Add(Item : TTBCustomDrawEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TTBCustomDrawEventListEx.Insert(Index : Integer; Item : TTBCustomDrawEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TTBCustomDrawEventListEx.Remove(Item : TTBCustomDrawEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TTBCustomDrawEventListEx.GetExecuteProc() : TMethod;
Var lRetVal : TTBCustomDrawEvent;
Begin
  lRetVal := Execute;
  Result  := TMethod(lRetVal);
End;

Procedure TTBCustomDrawEventListEx.Execute(Sender : TToolBar; Const ARect : TRect; Var DefaultDraw : Boolean);
Var Z : Integer;
    lItem : IMethodEx;
Begin
  For Z := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[Z];
    If lItem.Enabled Then
      TTBCustomDrawEvent(lItem.Method)(Sender, ARect, DefaultDraw);
  End;
End;

Procedure TTBAdvancedCustomDrawBtnEventListEx.Execute(Sender : TToolBar; Button : TToolButton;
  State : TCustomDrawState; Stage : TCustomDrawStage; Var Flags : TTBCustomDrawFlags; Var DefaultDraw : Boolean);
Var Z : Integer;
    lItem : IMethodEx;
Begin
  For Z := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[Z];
    If lItem.Enabled Then
      TTBAdvancedCustomDrawBtnEvent(lItem.Method)(Sender, Button, State, Stage, Flags, DefaultDraw);
  End;
End;

Function TTBCustomDrawBtnEventListEx.Get(Index : Integer) : TTBCustomDrawBtnEvent;
Begin
  Result := TTBCustomDrawBtnEvent(InHerited Items[Index].Method);
End;

Procedure TTBCustomDrawBtnEventListEx.Put(Index : Integer; Item : TTBCustomDrawBtnEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TTBCustomDrawBtnEventListEx.Add(Item : TTBCustomDrawBtnEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TTBCustomDrawBtnEventListEx.Insert(Index : Integer; Item : TTBCustomDrawBtnEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TTBCustomDrawBtnEventListEx.Remove(Item : TTBCustomDrawBtnEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TTBCustomDrawBtnEventListEx.GetExecuteProc() : TMethod;
Var lRetVal : TTBCustomDrawBtnEvent;
Begin
  lRetVal := Execute;
  Result  := TMethod(lRetVal);
End;

Procedure TTBCustomDrawBtnEventListEx.Execute(Sender : TToolBar; Button : TToolButton;
  State : TCustomDrawState; Var DefaultDraw : Boolean);
Var Z : Integer;
    lItem : IMethodEx;
Begin
  For Z := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[Z];
    If lItem.Enabled Then
      TTBCustomDrawBtnEvent(lItem.Method)(Sender, Button, State, DefaultDraw);
  End;
End;

Function TTBButtonEventListEx.Get(Index : Integer) : TTBButtonEvent;
Begin
  Result := TTBButtonEvent(InHerited Items[Index].Method);
End;

Procedure TTBButtonEventListEx.Put(Index : Integer; Item : TTBButtonEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TTBButtonEventListEx.Add(Item : TTBButtonEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TTBButtonEventListEx.Insert(Index : Integer; Item : TTBButtonEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TTBButtonEventListEx.Remove(Item : TTBButtonEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TTBButtonEventListEx.GetExecuteProc() : TMethod;
Var lRetVal : TTBButtonEvent;
Begin
  lRetVal := Execute;
  Result  := TMethod(lRetVal);
End;

Procedure TTBButtonEventListEx.Execute(Sender : TToolbar; Button : TToolButton);
Var Z : Integer;
    lItem : IMethodEx;
Begin
  For Z := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[Z];
    If lItem.Enabled Then
      TTBButtonEvent(lItem.Method)(Sender, Button);
  End;
End;

Function TTBCustomizeQueryEventListEx.Get(Index : Integer) : TTBCustomizeQueryEvent;
Begin
  Result := TTBCustomizeQueryEvent(InHerited Items[Index].Method);
End;

Procedure TTBCustomizeQueryEventListEx.Put(Index : Integer; Item : TTBCustomizeQueryEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TTBCustomizeQueryEventListEx.Add(Item : TTBCustomizeQueryEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TTBCustomizeQueryEventListEx.Insert(Index : Integer; Item : TTBCustomizeQueryEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TTBCustomizeQueryEventListEx.Remove(Item : TTBCustomizeQueryEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TTBCustomizeQueryEventListEx.GetExecuteProc() : TMethod;
Var lRetVal : TTBCustomizeQueryEvent;
Begin
  lRetVal := Execute;
  Result  := TMethod(lRetVal);
End;

Procedure TTBCustomizeQueryEventListEx.Execute(Sender : TToolbar; Index : Integer; Var Allow : Boolean);
Var Z : Integer;
    lItem : IMethodEx;
Begin
  For Z := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[Z];
    If lItem.Enabled Then
      TTBCustomizeQueryEvent(lItem.Method)(Sender, Index, Allow);
  End;
End;

Function TTBNewButtonEventListEx.Get(Index : Integer) : TTBNewButtonEvent;
Begin
  Result := TTBNewButtonEvent(InHerited Items[Index].Method);
End;

Procedure TTBNewButtonEventListEx.Put(Index : Integer; Item : TTBNewButtonEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TTBNewButtonEventListEx.Add(Item : TTBNewButtonEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TTBNewButtonEventListEx.Insert(Index : Integer; Item : TTBNewButtonEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TTBNewButtonEventListEx.Remove(Item : TTBNewButtonEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TTBNewButtonEventListEx.GetExecuteProc() : TMethod;
Var lRetVal : TTBNewButtonEvent;
Begin
  lRetVal := Execute;
  Result  := TMethod(lRetVal);
End;

Procedure TTBNewButtonEventListEx.Execute(Sender : TToolbar; Index : Integer; Var Button : TToolButton);
Var Z : Integer;
    lItem : IMethodEx;
Begin
  For Z := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[Z];
    If lItem.Enabled Then
      TTBNewButtonEvent(lItem.Method)(Sender, Index, Button);
  End;
End;

Procedure TToolBarEventDispatcher.InitEvents();
Var lProps      : TPropList;
    lNbProp     : Integer;
    X           : Integer;
Begin
  lNbProp := GetPropList(PTypeInfo(Component.ClassInfo), [tkMethod], @lProps, True);
  For X := 0 To lNbProp - 1 Do
  Begin
    If SameText(lProps[X].PropType^.Name, 'TTBAdvancedCustomDrawEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TTBAdvancedCustomDrawEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TTBAdvancedCustomDrawBtnEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TTBAdvancedCustomDrawBtnEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TTBCustomDrawEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TTBCustomDrawEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TTBCustomDrawBtnEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TTBCustomDrawBtnEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TTBButtonEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TTBButtonEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TTBCustomizeQueryEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TTBCustomizeQueryEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TTBNewButtonEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TTBNewButtonEventListEx));
  End;

  InHerited InitEvents();
End;

Procedure TToolBarEventDispatcher.RegisterTBAdvancedCustomDrawEvent(AEvent, ANewEvent : TTBAdvancedCustomDrawEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TToolBarEventDispatcher.UnRegisterTBAdvancedCustomDrawEvent(AEvent, AOldEvent : TTBAdvancedCustomDrawEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TToolBarEventDispatcher.DisableTBAdvancedCustomDrawEvent(AEvent, ADisabledEvent : TTBAdvancedCustomDrawEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TToolBarEventDispatcher.EnableTBAdvancedCustomDrawEvent(AEvent, AEnabledEvent : TTBAdvancedCustomDrawEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TToolBarEventDispatcher.RegisterTBAdvancedCustomDrawBtnEvent(AEvent, ANewEvent : TTBAdvancedCustomDrawBtnEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TToolBarEventDispatcher.UnRegisterTBAdvancedCustomDrawBtnEvent(AEvent, AOldEvent : TTBAdvancedCustomDrawBtnEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TToolBarEventDispatcher.DisableTBAdvancedCustomDrawBtnEvent(AEvent, ADisabledEvent : TTBAdvancedCustomDrawBtnEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TToolBarEventDispatcher.EnableTBAdvancedCustomDrawBtnEvent(AEvent, AEnabledEvent : TTBAdvancedCustomDrawBtnEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TToolBarEventDispatcher.RegisterTBCustomDrawEvent(AEvent, ANewEvent : TTBCustomDrawEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TToolBarEventDispatcher.UnRegisterTBCustomDrawEvent(AEvent, AOldEvent : TTBCustomDrawEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TToolBarEventDispatcher.DisableTBCustomDrawEvent(AEvent, ADisabledEvent : TTBCustomDrawEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TToolBarEventDispatcher.EnableTBCustomDrawEvent(AEvent, AEnabledEvent : TTBCustomDrawEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TToolBarEventDispatcher.RegisterTBCustomDrawBtnEvent(AEvent, ANewEvent : TTBCustomDrawBtnEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TToolBarEventDispatcher.UnRegisterTBCustomDrawBtnEvent(AEvent, AOldEvent : TTBCustomDrawBtnEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TToolBarEventDispatcher.DisableTBCustomDrawBtnEvent(AEvent, ADisabledEvent : TTBCustomDrawBtnEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TToolBarEventDispatcher.EnableTBCustomDrawBtnEvent(AEvent, AEnabledEvent : TTBCustomDrawBtnEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TToolBarEventDispatcher.RegisterTBButtonEvent(AEvent, ANewEvent : TTBButtonEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TToolBarEventDispatcher.UnRegisterTBButtonEvent(AEvent, AOldEvent : TTBButtonEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TToolBarEventDispatcher.DisableTBButtonEvent(AEvent, ADisabledEvent : TTBButtonEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TToolBarEventDispatcher.EnableTBButtonEvent(AEvent, AEnabledEvent : TTBButtonEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TToolBarEventDispatcher.RegisterTBCustomizeQueryEvent(AEvent, ANewEvent : TTBCustomizeQueryEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TToolBarEventDispatcher.UnRegisterTBCustomizeQueryEvent(AEvent, AOldEvent : TTBCustomizeQueryEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TToolBarEventDispatcher.DisableTBCustomizeQueryEvent(AEvent, ADisabledEvent : TTBCustomizeQueryEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TToolBarEventDispatcher.EnableTBCustomizeQueryEvent(AEvent, AEnabledEvent : TTBCustomizeQueryEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TToolBarEventDispatcher.RegisterTBNewButtonEvent(AEvent, ANewEvent : TTBNewButtonEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TToolBarEventDispatcher.UnRegisterTBNewButtonEvent(AEvent, AOldEvent : TTBNewButtonEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TToolBarEventDispatcher.DisableTBNewButtonEvent(AEvent, ADisabledEvent : TTBNewButtonEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TToolBarEventDispatcher.EnableTBNewButtonEvent(AEvent, AEnabledEvent : TTBNewButtonEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

end.
