unit HsEventListEx;

interface

Uses Windows, Classes, Controls, StdCtrls, TypInfo,
  HsInterfaceEx, HsListEx;

Type
  TMethodListExClass = Class Of TMethodListEx;

  IMethodEx = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-B510-D0C88FFFD07E}']
    Function  GetMethod() : TMethod;

    Function  GetEnabled() : Boolean;
    Procedure SetEnabled(Const AEnabled : Boolean);

    Property Method  : TMethod Read GetMethod;
    Property Enabled : Boolean Read GetEnabled Write SetEnabled;

  End;

  IMethodListEx = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-A87E-39E3E241F475}']
    //10 1001 1010
    //A 3E9 3F2
    //1010 0110 10
    //3F2 6E A
    Function  Get(Index : Integer) : IMethodEx;
    Procedure Put(Index : Integer; Item : IMethodEx);

    Function  GetEventName() : String;
    Procedure SetEventName(Const AEventName : String);

    Function  Add(Item : IMethodEx) : Integer;
    Procedure Insert(Index : Integer; Item : IMethodEx);
    Function  Remove(Item : IMethodEx) : Integer;
    Function  IndexOf(Item : IMethodEx) : Integer;

    Function GetExecuteProc() : TMethod;

    Property Items[Index : Integer] : IMethodEx Read Get Write Put; Default;

    Property EventName : String Read GetEventName Write SetEventName;

  End;

  IMethodInfoListEx = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-BD2B-E1AC4EBE3795}']
    Function  Get(Index: Integer): IMethodListEx;
    Procedure Put(Index: Integer; Const Item: IMethodListEx);

    Function IndexOf(AEventName : String) : Integer;
    Function Add(Item : IMethodListEx) : Integer; OverLoad;

    Property Items[Index : Integer] : IMethodListEx Read Get Write Put; Default;

  End;

  INotifyEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-9862-40CA68BA0080}']
    Function  Get(Index : Integer) : TNotifyEvent;
    Procedure Put(Index : Integer; Value : TNotifyEvent);

    Function  Add(Item : TNotifyEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TNotifyEvent);
    Function  Remove(Item : TNotifyEvent) : Integer;
    Function  IndexOf(Item : TNotifyEvent) : Integer;
    Procedure Execute(Sender : TObject);

    Property Items[Index : Integer] : TNotifyEvent Read Get Write Put; Default;

  End;

  IMouseEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-B64B-E6EA6D9D9BAA}']
    Function  Get(Index : Integer) : TMouseEvent;
    Procedure Put(Index : Integer; Item : TMouseEvent);

    Function  Add(Item : TMouseEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TMouseEvent);
    Function  Remove(Item : TMouseEvent) : Integer;

    Procedure Execute(Sender : TObject; Button : TMouseButton; Shift : TShiftState; X, Y : Integer);

    Property Items[Index : Integer] : TMouseEvent Read Get Write Put; Default;

  End;

  IMouseMoveEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-BC93-9B3D9FE93988}']
    Function  Get(Index : Integer) : TMouseMoveEvent;
    Procedure Put(Index : Integer; Item : TMouseMoveEvent);

    Function  Add(Item : TMouseMoveEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TMouseMoveEvent);
    Function  Remove(Item : TMouseMoveEvent) : Integer;

    Procedure Execute(Sender : TObject; Shift : TShiftState; X, Y : Integer);

    Property Items[Index : Integer] : TMouseMoveEvent Read Get Write Put; Default;

  End;

  IKeyEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-93B9-20688FFDB8BA}']
    Function  Get(Index : Integer) : TKeyEvent;
    Procedure Put(Index : Integer; Item : TKeyEvent);

    Function  Add(Item : TKeyEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TKeyEvent);
    Function  Remove(Item : TKeyEvent) : Integer;

    Procedure Execute(Sender : TObject; Var Key : Word; Shift : TShiftState);

    Property Items[Index : Integer] : TKeyEvent Read Get Write Put; Default;

  End;

  IKeyPressEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-BC93-9B3D9FE93988}']
    Function  Get(Index : Integer) : TKeyPressEvent;
    Procedure Put(Index : Integer; Item : TKeyPressEvent);

    Function  Add(Item : TKeyPressEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TKeyPressEvent);
    Function  Remove(Item : TKeyPressEvent) : Integer;

    Procedure Execute(Sender : TObject; Var Key : Char);

    Property Items[Index : Integer] : TKeyPressEvent Read Get Write Put; Default;

  End;

  IContextPopupEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-950E-6710045E480D}']
    Function  Get(Index : Integer) : TContextPopupEvent;
    Procedure Put(Index : Integer; Item : TContextPopupEvent);

    Function  Add(Item : TContextPopupEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TContextPopupEvent);
    Function  Remove(Item : TContextPopupEvent) : Integer;

    Procedure Execute(Sender : TObject; MousePos : TPoint; Var Handled : Boolean);
    
    Property Items[Index : Integer] : TContextPopupEvent Read Get Write Put; Default;

  End;

  IDockDropEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-8D55-F330A598BBBE}']
    Function  Get(Index : Integer) : TDockDropEvent;
    Procedure Put(Index : Integer; Item : TDockDropEvent);

    Function  Add(Item : TDockDropEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TDockDropEvent);
    Function  Remove(Item : TDockDropEvent) : Integer;

    Procedure Execute(Sender : TObject; Source : TDragDockObject; X, Y : Integer);

    Property Items[Index : Integer] : TDockDropEvent Read Get Write Put; Default;

  End;

  IDockOverEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-9813-49D252963E2D}']
    Function  Get(Index : Integer) : TDockOverEvent;
    Procedure Put(Index : Integer; Item : TDockOverEvent);

    Function  Add(Item : TDockOverEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TDockOverEvent);
    Function  Remove(Item : TDockOverEvent) : Integer;

    Procedure Execute(Sender : TObject; Source : TDragDockObject;
      X, Y : Integer; State : TDragState; var Accept : Boolean);

    Property Items[Index : Integer] : TDockOverEvent Read Get Write Put; Default;

  End;  

  IDragDropEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-8658-B229A7B004B0}']
    Function  Get(Index : Integer) : TDragDropEvent;
    Procedure Put(Index : Integer; Item : TDragDropEvent);

    Function  Add(Item : TDragDropEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TDragDropEvent);
    Function  Remove(Item : TDragDropEvent) : Integer;

    Procedure Execute(Sender, Source : TObject; X, Y : Integer);

    Property Items[Index : Integer] : TDragDropEvent Read Get Write Put; Default;

  End;

  IDragOverEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-9566-91A9B186F5AA}']
    Function  Get(Index : Integer) : TDragOverEvent;
    Procedure Put(Index : Integer; Item : TDragOverEvent);

    Function  Add(Item : TDragOverEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TDragOverEvent);
    Function  Remove(Item : TDragOverEvent) : Integer;

    Procedure Execute(Sender, Source : TObject; X, Y : Integer;
      State : TDragState; Var Accept : Boolean);

    Property Items[Index : Integer] : TDragOverEvent Read Get Write Put; Default;

  End;

  IEndDragEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-8F2A-4D9503D80E49}']
    Function  Get(Index : Integer) : TEndDragEvent;
    Procedure Put(Index : Integer; Item : TEndDragEvent);

    Function  Add(Item : TEndDragEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TEndDragEvent);
    Function  Remove(Item : TEndDragEvent) : Integer;

    Procedure Execute(Sender, Target : TObject; X, Y : Integer);

    Property Items[Index : Integer] : TEndDragEvent Read Get Write Put; Default;

  End;
        
  IGetSiteInfoEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-ABAF-EC2B194C54BC}']
    Function  Get(Index : Integer) : TGetSiteInfoEvent;
    Procedure Put(Index : Integer; Item : TGetSiteInfoEvent);

    Function  Add(Item : TGetSiteInfoEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TGetSiteInfoEvent);
    Function  Remove(Item : TGetSiteInfoEvent) : Integer;

    Procedure Execute(Sender : TObject; DockClient : TControl;
      Var InfluenceRect : TRect; MousePos : TPoint; Var CanDock : Boolean);

    Property Items[Index : Integer] : TGetSiteInfoEvent Read Get Write Put; Default;

  End;
  
  IStartDockEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-A900-45ADB9EBDE17}']
    Function  Get(Index : Integer) : TStartDockEvent;
    Procedure Put(Index : Integer; Item : TStartDockEvent);

    Function  Add(Item : TStartDockEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TStartDockEvent);
    Function  Remove(Item : TStartDockEvent) : Integer;

    Procedure Execute(Sender : TObject; Var DragObject : TDragDockObject);

    Property Items[Index : Integer] : TStartDockEvent Read Get Write Put; Default;

  End;

  IStartDragEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-9667-7BAF6D42EA3D}']
    Function  Get(Index : Integer) : TStartDragEvent;
    Procedure Put(Index : Integer; Item : TStartDragEvent);

    Function  Add(Item : TStartDragEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TStartDragEvent);
    Function  Remove(Item : TStartDragEvent) : Integer;

    Procedure Execute(Sender : TObject; Var DragObject : TDragObject);

    Property Items[Index : Integer] : TStartDragEvent Read Get Write Put; Default;

  End;
  
  IUnDockEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-83FF-34CFB0E41467}']
    Function  Get(Index : Integer) : TUnDockEvent;
    Procedure Put(Index : Integer; Item : TUnDockEvent);

    Function  Add(Item : TUnDockEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TUnDockEvent);
    Function  Remove(Item : TUnDockEvent) : Integer;

    Procedure Execute(Sender : TObject; Client : TControl;
      NewTarget : TWinControl; Var Allow : Boolean);

    Property Items[Index : Integer] : TUnDockEvent Read Get Write Put; Default;

  End;
  
  IDrawItemEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-BDD2-5A214C26A742}']
    Function  Get(Index : Integer) : TDrawItemEvent;
    Procedure Put(Index : Integer; Item : TDrawItemEvent);

    Function  Add(Item : TDrawItemEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TDrawItemEvent);
    Function  Remove(Item : TDrawItemEvent) : Integer;

    Procedure Execute(Control : TWinControl; Index : Integer;
      Rect : TRect; State : TOwnerDrawState);

    Property Items[Index : Integer] : TDrawItemEvent Read Get Write Put; Default;

  End;
  
  IMeasureItemEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-A649-2D4B52146B3B}']
    Function  Get(Index : Integer) : TMeasureItemEvent;
    Procedure Put(Index : Integer; Item : TMeasureItemEvent);

    Function  Add(Item : TMeasureItemEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TMeasureItemEvent);
    Function  Remove(Item : TMeasureItemEvent) : Integer;

    Procedure Execute(Control : TWinControl; Index : Integer; Var Height : Integer);

    Property Items[Index : Integer] : TMeasureItemEvent Read Get Write Put; Default;

  End;

(******************************************************************************)

  TMethodEx = Class(TInterfacedObjectEx, IMethodEx)
  Private
    FMethod   : TMethod;
    FEnabled  : Boolean;

  Protected
    Function  GetMethod() : TMethod;

    Function  GetEnabled() : Boolean;
    Procedure SetEnabled(Const AEnabled : Boolean);

  Public
    Property Method  : TMethod Read GetMethod;
    Property Enabled : Boolean Read GetEnabled Write SetEnabled;

    Constructor Create(Const AMethod : TMethod); ReIntroduce; Virtual;

  End;

  TMethodListEx = Class(TInterfaceListEx, IMethodListEx)
  Private
    FEventName : String;

  Protected
    Function  Get(Index : Integer) : IMethodEx; OverLoad;
    Procedure Put(Index : Integer; Item : IMethodEx); OverLoad;

    Function  GetEventName() : String;
    Procedure SetEventName(Const AEventName : String);

    Function GetExecuteProc() : TMethod; Virtual; Abstract;

  Public
    Function  Add(Item : IMethodEx) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : IMethodEx); OverLoad;
    Function  Remove(Item : IMethodEx) : Integer; ReIntroduce; OverLoad;
    Function  IndexOf(Item : IMethodEx) : Integer; ReIntroduce; OverLoad;

    Property Items[Index : Integer] : IMethodEx Read Get Write Put; Default;
    Property EventName : String Read GetEventName Write SetEventName;

  End;

  TMethodInfoListEx = Class(TInterfaceListEx, IMethodInfoListEx)
  Protected
    Function  Get(Index: Integer): IMethodListEx; OverLoad;
    Procedure Put(Index: Integer; Const Item: IMethodListEx); OverLoad;

  Public
    Property Items[Index : Integer] : IMethodListEx Read Get Write Put; Default;

    Function IndexOf(AEventName : String) : Integer; ReIntroduce; OverLoad;
    Function Add(Item : IMethodListEx) : Integer; OverLoad;

  End;

  TNotifyEventListEx = Class(TMethodListEx, INotifyEventListEx)
  Protected
    Function  Get(Index : Integer) : TNotifyEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TNotifyEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TNotifyEvent Read Get Write Put; Default;

    Function  Add(Item : TNotifyEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TNotifyEvent); OverLoad;
    Function  Remove(Item : TNotifyEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TNotifyEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TObject);

  End;

  TMouseEventListEx = Class(TMethodListEx, IMouseEventListEx)
  Protected
    Function  Get(Index : Integer) : TMouseEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TMouseEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TMouseEvent Read Get Write Put; Default;

    Function  Add(Item : TMouseEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TMouseEvent); OverLoad;
    Function  Remove(Item : TMouseEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TObject; Button : TMouseButton; Shift : TShiftState; X, Y : Integer);

  End;

  TMouseMoveEventListEx = Class(TMethodListEx, IMouseMoveEventListEx)
  Protected
    Function  Get(Index : Integer) : TMouseMoveEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TMouseMoveEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TMouseMoveEvent Read Get Write Put; Default;

    Function  Add(Item : TMouseMoveEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TMouseMoveEvent); OverLoad;
    Function  Remove(Item : TMouseMoveEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TObject; Shift : TShiftState; X, Y : Integer);

  End;

  TKeyEventListEx = Class(TMethodListEx, IKeyEventListEx)
  Protected
    Function  Get(Index : Integer) : TKeyEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TKeyEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide; 

  Public
    Property Items[Index : Integer] : TKeyEvent Read Get Write Put; Default;

    Function  Add(Item : TKeyEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TKeyEvent); OverLoad;
    Function  Remove(Item : TKeyEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TObject; Var Key : Word; Shift : TShiftState);

  End;

  TKeyPressEventListEx = Class(TMethodListEx, IKeyPressEventListEx)
  Protected
    Function  Get(Index : Integer) : TKeyPressEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TKeyPressEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TKeyPressEvent Read Get Write Put; Default;

    Function  Add(Item : TKeyPressEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TKeyPressEvent); OverLoad;
    Function  Remove(Item : TKeyPressEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TObject; Var Key : Char);

  End;

  TContextPopupEventListEx = Class(TMethodListEx, IContextPopupEventListEx)
  Protected
    Function  Get(Index : Integer) : TContextPopupEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TContextPopupEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TContextPopupEvent Read Get Write Put; Default;

    Function  Add(Item : TContextPopupEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TContextPopupEvent); OverLoad;
    Function  Remove(Item : TContextPopupEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TObject; MousePos : TPoint; Var Handled : Boolean);

  End;

  TDockDropEventListEx = Class(TMethodListEx, IDockDropEventListEx)
  Protected
    Function  Get(Index : Integer) : TDockDropEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TDockDropEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TDockDropEvent Read Get Write Put; Default;

    Function  Add(Item : TDockDropEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TDockDropEvent); OverLoad;
    Function  Remove(Item : TDockDropEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TObject; Source : TDragDockObject; X, Y : Integer);

  End;

  TDockOverEventListEx = Class(TMethodListEx, IDockOverEventListEx)
  Protected
    Function  Get(Index : Integer) : TDockOverEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TDockOverEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TDockOverEvent Read Get Write Put; Default;

    Function  Add(Item : TDockOverEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TDockOverEvent); OverLoad;
    Function  Remove(Item : TDockOverEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TObject; Source : TDragDockObject;
      X, Y : Integer; State : TDragState; var Accept : Boolean);

  End;

  TDragDropEventListEx = Class(TMethodListEx, IDragDropEventListEx)
  Protected
    Function  Get(Index : Integer) : TDragDropEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TDragDropEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TDragDropEvent Read Get Write Put; Default;

    Function  Add(Item : TDragDropEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TDragDropEvent); OverLoad;
    Function  Remove(Item : TDragDropEvent) : Integer; OverLoad;

    Procedure Execute(Sender, Source : TObject; X, Y : Integer);

  End;

  TDragOverEventListEx = Class(TMethodListEx, IDragOverEventListEx)
  Protected
    Function  Get(Index : Integer) : TDragOverEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TDragOverEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TDragOverEvent Read Get Write Put; Default;

    Function  Add(Item : TDragOverEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TDragOverEvent); OverLoad;
    Function  Remove(Item : TDragOverEvent) : Integer; OverLoad;

    Procedure Execute(Sender, Source : TObject; X, Y : Integer;
      State : TDragState; Var Accept : Boolean);

  End;

  TEndDragEventListEx = Class(TMethodListEx, IEndDragEventListEx)
  Protected
    Function  Get(Index : Integer) : TEndDragEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TEndDragEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TEndDragEvent Read Get Write Put; Default;

    Function  Add(Item : TEndDragEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TEndDragEvent); OverLoad;
    Function  Remove(Item : TEndDragEvent) : Integer; OverLoad;

    Procedure Execute(Sender, Target : TObject; X, Y : Integer);

  End;

  TGetSiteInfoEventListEx = Class(TMethodListEx, IGetSiteInfoEventListEx)
  Protected
    Function  Get(Index : Integer) : TGetSiteInfoEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TGetSiteInfoEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TGetSiteInfoEvent Read Get Write Put; Default;

    Function  Add(Item : TGetSiteInfoEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TGetSiteInfoEvent); OverLoad;
    Function  Remove(Item : TGetSiteInfoEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TObject; DockClient : TControl;
      Var InfluenceRect : TRect; MousePos : TPoint; Var CanDock : Boolean);

  End;

  TStartDockEventListEx = Class(TMethodListEx, IStartDockEventListEx)
  Protected
    Function  Get(Index : Integer) : TStartDockEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TStartDockEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TStartDockEvent Read Get Write Put; Default;

    Function  Add(Item : TStartDockEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TStartDockEvent); OverLoad;
    Function  Remove(Item : TStartDockEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TObject; Var DragObject : TDragDockObject);

  End;

  TStartDragEventListEx = Class(TMethodListEx, IStartDragEventListEx)
  Protected
    Function  Get(Index : Integer) : TStartDragEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TStartDragEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TStartDragEvent Read Get Write Put; Default;

    Function  Add(Item : TStartDragEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TStartDragEvent); OverLoad;
    Function  Remove(Item : TStartDragEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TObject; Var DragObject : TDragObject);

  End;

  TUnDockEventListEx = Class(TMethodListEx, IUnDockEventListEx)
  Protected
    Function  Get(Index : Integer) : TUnDockEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TUnDockEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TUnDockEvent Read Get Write Put; Default;

    Function  Add(Item : TUnDockEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TUnDockEvent); OverLoad;
    Function  Remove(Item : TUnDockEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TObject; Client : TControl;
      NewTarget : TWinControl; Var Allow : Boolean);

  End;

  TDrawItemEventListEx = Class(TMethodListEx, IDrawItemEventListEx)
  Protected
    Function  Get(Index : Integer) : TDrawItemEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TDrawItemEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TDrawItemEvent Read Get Write Put; Default;

    Function  Add(Item : TDrawItemEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TDrawItemEvent); OverLoad;
    Function  Remove(Item : TDrawItemEvent) : Integer; OverLoad;

    Procedure Execute(Control : TWinControl; Index : Integer;
      Rect : TRect; State : TOwnerDrawState);

  End;

  TMeasureItemEventListEx = Class(TMethodListEx, IMeasureItemEventListEx)
  Protected
    Function  Get(Index : Integer) : TMeasureItemEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TMeasureItemEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TMeasureItemEvent Read Get Write Put; Default;

    Function  Add(Item : TMeasureItemEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TMeasureItemEvent); OverLoad;
    Function  Remove(Item : TMeasureItemEvent) : Integer; OverLoad;

    Procedure Execute(Control : TWinControl; Index : Integer; Var Height : Integer);

  End;

(******************************************************************************)

  IPropInfoListEx = Interface(IListEx)
    ['{4B61686E-29A0-2112-840D-A0191F04B4F6}']
    Function  Get(Index : Integer) : TPropInfo;
    Procedure Put(Index : Integer; Item : TPropInfo);

    Function  Add(Item : TPropInfo) : Integer;

    Property Items[Index : Integer] : TPropInfo Read Get Write Put; Default;

  End;

  TPropInfoListEx = Class(TInterfacedListEx, IPropInfoListEx)
  Private
    Function CreatePropInfoPointer(Const APropInfo : TPropInfo) : Pointer;

  Protected
    Property IntfImpl : TInterfaceExImplementor Read GetImplementor Implements IPropInfoListEx;

    Procedure Notify(Ptr : Pointer; Action : TListNotification); OverRide;

    Function  Get(Index : Integer) : TPropInfo; OverLoad;
    Procedure Put(Index : Integer; Item : TPropInfo); OverLoad;
    Function  Add(Item : TPropInfo) : Integer; OverLoad;

    Property Items[Index : Integer] : TPropInfo Read Get Write Put; Default;

  End;

(******************************************************************************)

  IEventDispatcher = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-8BE3-8E0C2B7FD172}']
    Procedure RegisterNotifyEvent(AEvent, ANewEvent : TNotifyEvent; Const Index : Integer = -1);
    Procedure UnRegisterNotifyEvent(AEvent, AOldEvent : TNotifyEvent);
    Procedure DisableNotifyEvent(AEvent, ADisabledEvent : TNotifyEvent);
    Procedure EnableNotifyEvent(AEvent, AEnabledEvent : TNotifyEvent);

    Procedure RegisterMouseEvent(AEvent, ANewEvent : TMouseEvent; Const Index : Integer = -1);
    Procedure UnRegisterMouseEvent(AEvent, AOldEvent : TMouseEvent);
    Procedure DisableMouseEvent(AEvent, ADisabledEvent : TMouseEvent);
    Procedure EnableMouseEvent(AEvent, AEnabledEvent : TMouseEvent);

    Procedure RegisterMouseMoveEvent(AEvent, ANewEvent : TMouseMoveEvent; Const Index : Integer = -1);
    Procedure UnRegisterMouseMoveEvent(AEvent, AOldEvent : TMouseMoveEvent);
    Procedure DisableMouseMoveEvent(AEvent, ADisabledEvent : TMouseMoveEvent);
    Procedure EnableMouseMoveEvent(AEvent, AEnabledEvent : TMouseMoveEvent);

    Procedure RegisterKeyEvent(AEvent, ANewEvent : TKeyEvent; Const Index : Integer = -1);
    Procedure UnRegisterKeyEvent(AEvent, AOldEvent : TKeyEvent);
    Procedure DisableKeyEvent(AEvent, ADisabledEvent : TKeyEvent);
    Procedure EnableKeyEvent(AEvent, AEnabledEvent : TKeyEvent);

    Procedure RegisterKeyPressEvent(AEvent, ANewEvent : TKeyPressEvent; Const Index : Integer = -1);
    Procedure UnRegisterKeyPressEvent(AEvent, AOldEvent : TKeyPressEvent);
    Procedure DisableKeyPressEvent(AEvent, ADisabledEvent : TKeyPressEvent);
    Procedure EnableKeyPressEvent(AEvent, AEnabledEvent : TKeyPressEvent);

    Procedure RegisterContextPopupEvent(AEvent, ANewEvent : TContextPopupEvent; Const Index : Integer = -1);
    Procedure UnRegisterContextPopupEvent(AEvent, AOldEvent : TContextPopupEvent);
    Procedure DisableContextPopupEvent(AEvent, ADisabledEvent : TContextPopupEvent);
    Procedure EnableContextPopupEvent(AEvent, AEnabledEvent : TContextPopupEvent);
    
    Procedure RegisterDockDropEvent(AEvent, ANewEvent : TDockDropEvent; Const Index : Integer = -1);
    Procedure UnRegisterDockDropEvent(AEvent, AOldEvent : TDockDropEvent);
    Procedure DisableDockDropEvent(AEvent, ADisabledEvent : TDockDropEvent);
    Procedure EnableDockDropEvent(AEvent, AEnabledEvent : TDockDropEvent);

    Procedure RegisterDockOverEvent(AEvent, ANewEvent : TDockOverEvent; Const Index : Integer = -1);
    Procedure UnRegisterDockOverEvent(AEvent, AOldEvent : TDockOverEvent);
    Procedure DisableDockOverEvent(AEvent, ADisabledEvent : TDockOverEvent);
    Procedure EnableDockOverEvent(AEvent, AEnabledEvent : TDockOverEvent);

    Procedure RegisterDragDropEvent(AEvent, ANewEvent : TDragDropEvent; Const Index : Integer = -1);
    Procedure UnRegisterDragDropEvent(AEvent, AOldEvent : TDragDropEvent);
    Procedure DisableDragDropEvent(AEvent, ADisabledEvent : TDragDropEvent);
    Procedure EnableDragDropEvent(AEvent, AEnabledEvent : TDragDropEvent);

    Procedure RegisterDragOverEvent(AEvent, ANewEvent : TDragOverEvent; Const Index : Integer = -1);
    Procedure UnRegisterDragOverEvent(AEvent, AOldEvent : TDragOverEvent);
    Procedure DisableDragOverEvent(AEvent, ADisabledEvent : TDragOverEvent);
    Procedure EnableDragOverEvent(AEvent, AEnabledEvent : TDragOverEvent);

    Procedure RegisterEndDragEvent(AEvent, ANewEvent : TEndDragEvent; Const Index : Integer = -1);
    Procedure UnRegisterEndDragEvent(AEvent, AOldEvent : TEndDragEvent);
    Procedure DisableEndDragEvent(AEvent, ADisabledEvent : TEndDragEvent);
    Procedure EnableEndDragEvent(AEvent, AEnabledEvent : TEndDragEvent);

    Procedure RegisterGetSiteInfoEvent(AEvent, ANewEvent : TGetSiteInfoEvent; Const Index : Integer = -1);
    Procedure UnRegisterGetSiteInfoEvent(AEvent, AOldEvent : TGetSiteInfoEvent);
    Procedure DisableGetSiteInfoEvent(AEvent, ADisabledEvent : TGetSiteInfoEvent);
    Procedure EnableGetSiteInfoEvent(AEvent, AEnabledEvent : TGetSiteInfoEvent);

    Procedure RegisterStartDockEvent(AEvent, ANewEvent : TStartDockEvent; Const Index : Integer = -1);
    Procedure UnRegisterStartDockEvent(AEvent, AOldEvent : TStartDockEvent);
    Procedure DisableStartDockEvent(AEvent, ADisabledEvent : TStartDockEvent);
    Procedure EnableStartDockEvent(AEvent, AEnabledEvent : TStartDockEvent);

    Procedure RegisterStartDragEvent(AEvent, ANewEvent : TStartDragEvent; Const Index : Integer = -1);
    Procedure UnRegisterStartDragEvent(AEvent, AOldEvent : TStartDragEvent);
    Procedure DisableStartDragEvent(AEvent, ADisabledEvent : TStartDragEvent);
    Procedure EnableStartDragEvent(AEvent, AEnabledEvent : TStartDragEvent);

    Procedure RegisterUnDockEvent(AEvent, ANewEvent : TUnDockEvent; Const Index : Integer = -1);
    Procedure UnRegisterUnDockEvent(AEvent, AOldEvent : TUnDockEvent);
    Procedure DisableUnDockEvent(AEvent, ADisabledEvent : TUnDockEvent);
    Procedure EnableUnDockEvent(AEvent, AEnabledEvent : TUnDockEvent);

    Procedure RegisterDrawItemEvent(AEvent, ANewEvent : TDrawItemEvent; Const Index : Integer = -1);
    Procedure UnRegisterDrawItemEvent(AEvent, AOldEvent : TDrawItemEvent);
    Procedure DisableDrawItemEvent(AEvent, ADisabledEvent : TDrawItemEvent);
    Procedure EnableDrawItemEvent(AEvent, AEnabledEvent : TDrawItemEvent);
    
    Procedure RegisterMeasureItemEvent(AEvent, ANewEvent : TMeasureItemEvent; Const Index : Integer = -1);
    Procedure UnRegisterMeasureItemEvent(AEvent, AOldEvent : TMeasureItemEvent);
    Procedure DisableMeasureItemEvent(AEvent, ADisabledEvent : TMeasureItemEvent);
    Procedure EnableMeasureItemEvent(AEvent, AEnabledEvent : TMeasureItemEvent);

  End;
  
  TCustomEventDispatcher = Class(TInterfacedObjectEx, IEventDispatcher)
  Private
    FComponent     : TObject;
    FEvents        : IMethodInfoListEx;
    FUnknownEvents : IPropInfoListEx;
    FKnownEvents   : TStringList;

    Function GetEventImplementor(AEvent : TMethod) : IMethodListEx;

  Protected
    Procedure InitEvents(); Virtual;

    Function  InternalInitList(Const AEventName : String; AListClass : TMethodListExClass) : IMethodListEx;
    Procedure InternalRegisterEvent(AEvent, ANewEvent : TMethod; Const Index : Integer = -1);
    Procedure InternalUnRegisterEvent(AEvent, AOldEvent : TMethod);
    Procedure InternalDisableEvent(AEvent, ADisabledEvent : TMethod);
    Procedure InternalEnableEvent(AEvent, AEnabledEvent : TMethod);

    //IEventDispatcher
    Procedure RegisterNotifyEvent(AEvent, ANewEvent : TNotifyEvent; Const Index : Integer = -1);
    Procedure UnRegisterNotifyEvent(AEvent, AOldEvent : TNotifyEvent);
    Procedure DisableNotifyEvent(AEvent, ADisabledEvent : TNotifyEvent);
    Procedure EnableNotifyEvent(AEvent, AEnabledEvent : TNotifyEvent);

    Procedure RegisterMouseEvent(AEvent, ANewEvent : TMouseEvent; Const Index : Integer = -1);
    Procedure UnRegisterMouseEvent(AEvent, AOldEvent : TMouseEvent);
    Procedure DisableMouseEvent(AEvent, ADisabledEvent : TMouseEvent);
    Procedure EnableMouseEvent(AEvent, AEnabledEvent : TMouseEvent);

    Procedure RegisterMouseMoveEvent(AEvent, ANewEvent : TMouseMoveEvent; Const Index : Integer = -1);
    Procedure UnRegisterMouseMoveEvent(AEvent, AOldEvent : TMouseMoveEvent);
    Procedure DisableMouseMoveEvent(AEvent, ADisabledEvent : TMouseMoveEvent);
    Procedure EnableMouseMoveEvent(AEvent, AEnabledEvent : TMouseMoveEvent);

    Procedure RegisterKeyEvent(AEvent, ANewEvent : TKeyEvent; Const Index : Integer = -1);
    Procedure UnRegisterKeyEvent(AEvent, AOldEvent : TKeyEvent);
    Procedure DisableKeyEvent(AEvent, ADisabledEvent : TKeyEvent);
    Procedure EnableKeyEvent(AEvent, AEnabledEvent : TKeyEvent);

    Procedure RegisterKeyPressEvent(AEvent, ANewEvent : TKeyPressEvent; Const Index : Integer = -1);
    Procedure UnRegisterKeyPressEvent(AEvent, AOldEvent : TKeyPressEvent);
    Procedure DisableKeyPressEvent(AEvent, ADisabledEvent : TKeyPressEvent);
    Procedure EnableKeyPressEvent(AEvent, AEnabledEvent : TKeyPressEvent);

    Procedure RegisterContextPopupEvent(AEvent, ANewEvent : TContextPopupEvent; Const Index : Integer = -1);
    Procedure UnRegisterContextPopupEvent(AEvent, AOldEvent : TContextPopupEvent);
    Procedure DisableContextPopupEvent(AEvent, ADisabledEvent : TContextPopupEvent);
    Procedure EnableContextPopupEvent(AEvent, AEnabledEvent : TContextPopupEvent);

    Procedure RegisterDockDropEvent(AEvent, ANewEvent : TDockDropEvent; Const Index : Integer = -1);
    Procedure UnRegisterDockDropEvent(AEvent, AOldEvent : TDockDropEvent);
    Procedure DisableDockDropEvent(AEvent, ADisabledEvent : TDockDropEvent);
    Procedure EnableDockDropEvent(AEvent, AEnabledEvent : TDockDropEvent);

    Procedure RegisterDockOverEvent(AEvent, ANewEvent : TDockOverEvent; Const Index : Integer = -1);
    Procedure UnRegisterDockOverEvent(AEvent, AOldEvent : TDockOverEvent);
    Procedure DisableDockOverEvent(AEvent, ADisabledEvent : TDockOverEvent);
    Procedure EnableDockOverEvent(AEvent, AEnabledEvent : TDockOverEvent);

    Procedure RegisterDragDropEvent(AEvent, ANewEvent : TDragDropEvent; Const Index : Integer = -1);
    Procedure UnRegisterDragDropEvent(AEvent, AOldEvent : TDragDropEvent);
    Procedure DisableDragDropEvent(AEvent, ADisabledEvent : TDragDropEvent);
    Procedure EnableDragDropEvent(AEvent, AEnabledEvent : TDragDropEvent);

    Procedure RegisterDragOverEvent(AEvent, ANewEvent : TDragOverEvent; Const Index : Integer = -1);
    Procedure UnRegisterDragOverEvent(AEvent, AOldEvent : TDragOverEvent);
    Procedure DisableDragOverEvent(AEvent, ADisabledEvent : TDragOverEvent);
    Procedure EnableDragOverEvent(AEvent, AEnabledEvent : TDragOverEvent);

    Procedure RegisterEndDragEvent(AEvent, ANewEvent : TEndDragEvent; Const Index : Integer = -1);
    Procedure UnRegisterEndDragEvent(AEvent, AOldEvent : TEndDragEvent);
    Procedure DisableEndDragEvent(AEvent, ADisabledEvent : TEndDragEvent);
    Procedure EnableEndDragEvent(AEvent, AEnabledEvent : TEndDragEvent);

    Procedure RegisterGetSiteInfoEvent(AEvent, ANewEvent : TGetSiteInfoEvent; Const Index : Integer = -1);
    Procedure UnRegisterGetSiteInfoEvent(AEvent, AOldEvent : TGetSiteInfoEvent);
    Procedure DisableGetSiteInfoEvent(AEvent, ADisabledEvent : TGetSiteInfoEvent);
    Procedure EnableGetSiteInfoEvent(AEvent, AEnabledEvent : TGetSiteInfoEvent);

    Procedure RegisterStartDockEvent(AEvent, ANewEvent : TStartDockEvent; Const Index : Integer = -1);
    Procedure UnRegisterStartDockEvent(AEvent, AOldEvent : TStartDockEvent);
    Procedure DisableStartDockEvent(AEvent, ADisabledEvent : TStartDockEvent);
    Procedure EnableStartDockEvent(AEvent, AEnabledEvent : TStartDockEvent);

    Procedure RegisterStartDragEvent(AEvent, ANewEvent : TStartDragEvent; Const Index : Integer = -1);
    Procedure UnRegisterStartDragEvent(AEvent, AOldEvent : TStartDragEvent);
    Procedure DisableStartDragEvent(AEvent, ADisabledEvent : TStartDragEvent);
    Procedure EnableStartDragEvent(AEvent, AEnabledEvent : TStartDragEvent);

    Procedure RegisterUnDockEvent(AEvent, ANewEvent : TUnDockEvent; Const Index : Integer = -1);
    Procedure UnRegisterUnDockEvent(AEvent, AOldEvent : TUnDockEvent);
    Procedure DisableUnDockEvent(AEvent, ADisabledEvent : TUnDockEvent);
    Procedure EnableUnDockEvent(AEvent, AEnabledEvent : TUnDockEvent);

    Procedure RegisterDrawItemEvent(AEvent, ANewEvent : TDrawItemEvent; Const Index : Integer = -1);
    Procedure UnRegisterDrawItemEvent(AEvent, AOldEvent : TDrawItemEvent);
    Procedure DisableDrawItemEvent(AEvent, ADisabledEvent : TDrawItemEvent);
    Procedure EnableDrawItemEvent(AEvent, AEnabledEvent : TDrawItemEvent);

    Procedure RegisterMeasureItemEvent(AEvent, ANewEvent : TMeasureItemEvent; Const Index : Integer = -1);
    Procedure UnRegisterMeasureItemEvent(AEvent, AOldEvent : TMeasureItemEvent);
    Procedure DisableMeasureItemEvent(AEvent, ADisabledEvent : TMeasureItemEvent);
    Procedure EnableMeasureItemEvent(AEvent, AEnabledEvent : TMeasureItemEvent);

    Property Component : TObject           Read FComponent;
    Property Events    : IMethodInfoListEx Read FEvents;

  Public
    Property UnknownEvents : IPropInfoListEx Read FUnknownEvents;
    Property KnownEvents   : TStringList     Read FKnownEvents;

    Function GenerateUnknownEventClasses() : String;

    Constructor Create(AComponent : TObject); ReIntroduce; Virtual;
    Destructor  Destroy(); OverRide;

  End;

  Function GetFunctionSignature(APropInfo : PPropInfo) : String; OverLoad;
  Function GetFunctionSignature(APropInfo : TPropInfo) : String; OverLoad;

implementation

Uses Dialogs,
  SysUtils, HsStreamEx;

Type
  IParamRec = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-894C-E83EE214E4EA}']
    Function  GetFlags() : TParamFlags;
    Procedure SetFlags(Const AFlags : TParamFlags);

    Function  GetParamName() : String;
    Procedure SetParamName(Const AParamName : String);

    Function  GetTypeName() : String;
    Procedure SetTypeName(Const ATypeName : String);

    Function GetAsString() : String;

    Property Flags     : TParamFlags Read GetFlags     Write SetFlags;
    Property ParamName : String      Read GetParamName Write SetParamName;
    Property TypeName  : String      Read GetTypeName  Write SetTypeName;
    Property AsString  : String      Read GetAsString;

  End;

  IParamRecs = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-97DE-1FF397C76437}']
    Function  Get(Index : Integer) : IParamRec;
    Procedure Put(Index : Integer; Const Item : IParamRec);

    Function Add() : IParamRec; OverLoad;
    Function Add(Const AItem : IParamRec) : Integer; OverLoad;

    Procedure Load(ATypeData : PTypeData);

    Property Items[Index : Integer] : IParamRec Read Get Write Put; Default;

  End;
  
  TParamRec = Class(TInterfacedObjectEx, IParamRec)
  Private
    FFlags     : TParamFlags;
    FParamName : String;
    FTypeName  : String;

  Protected
    Function  GetFlags() : TParamFlags; 
    Procedure SetFlags(Const AFlags : TParamFlags); 

    Function  GetParamName() : String; 
    Procedure SetParamName(Const AParamName : String); 

    Function  GetTypeName() : String; 
    Procedure SetTypeName(Const ATypeName : String); 

    Function GetAsString() : String;

  End;

  TParamRecs = Class(TInterfaceListEx, IParamRecs)
  Protected
    Function  GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : IParamRec; OverLoad;
    Procedure Put(Index : Integer; Const Item : IParamRec); OverLoad;

    Function Add() : IParamRec; ReIntroduce; OverLoad;
    Function Add(Const AItem : IParamRec) : Integer; OverLoad;

    Procedure Load(ATypeData : PTypeData);

  End;

Function TParamRec.GetFlags() : TParamFlags;
Begin
  Result := FFlags;
End;

Procedure TParamRec.SetFlags(Const AFlags : TParamFlags);
Begin
  FFlags := AFlags;
End;

Function TParamRec.GetParamName() : String;
Begin
  Result := FParamName;
End;

Procedure TParamRec.SetParamName(Const AParamName : String);
Begin
  FParamName := AParamName;
End;

Function TParamRec.GetTypeName() : String;
Begin
  Result := FTypeName;
End;

Procedure TParamRec.SetTypeName(Const ATypeName : String);
Begin
  FTypeName := ATypeName;
End;

Function TParamRec.GetAsString() : String;
Begin
  If pfConst In FFlags Then
    Result := 'Const '
  Else If pfVar In FFlags Then
    Result := 'Var '
  Else If pfOut In FFlags Then
    Result := 'Out '
  Else
    Result := '';

  Result := Result + FParamName + ' : ' + FTypeName;
End;

Function TParamRecs.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TParamRec;
End;

Function TParamRecs.Get(Index : Integer) : IParamRec;
Begin
  Result := InHerited Items[Index] As IParamRec;
End;

Procedure TParamRecs.Put(Index : Integer; Const Item : IParamRec);
Begin
  InHerited Items[Index] := Item;
End;

Function TParamRecs.Add() : IParamRec;
Begin
  Result := InHerited Add() As IParamRec;
End;

Function TParamRecs.Add(Const AItem : IParamRec) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Procedure TParamRecs.Load(ATypeData : PTypeData);
Var X    : Integer;
    lMem : IMemoryStreamEx;
Begin
  lMem := TMemoryStreamEx.Create();
  Try
    lMem.WriteBuffer(ATypeData.ParamList, SizeOf(ATypeData.ParamList));
    lMem.Position := 0;

    For X := 0 To ATypeData.ParamCount - 1 Do
    Begin
      With Add() Do
      Begin
        Flags     := TParamFlags(lMem.ReadByte());
        ParamName := lMem.ReadWideString();
        TypeName  := lMem.ReadWideString();
      End;
    End;

    Finally
      lMem := Nil;
  End;
End;

Function GetFunctionSignature(APropInfo : PPropInfo) : String;
Var lData   : PTypeData;
    lParams : IParamRecs;
    X       : Integer;
Begin
  Result := '';

  If APropInfo.PropType^.Kind = tkMethod Then
  Begin
    lData := GetTypeData(APropInfo.PropType^);
    If Assigned(lData) Then
    Begin
      lParams := TParamRecs.Create();
      Try
        lParams.Load(lData);

        Result := 'Procedure(';
        For X := 0 To lParams.Count - 1 Do
        Begin
          Result := Result + lParams[X].AsString;
          If X < lParams.Count - 1 Then
            Result := Result + '; ';
        End;
        Result := Result + ') Of Object;';

        Finally
          lParams := Nil;
      End;
    End;
  End;
End;

Function GetFunctionSignature(APropInfo : TPropInfo) : String;
Begin
  Result := GetFunctionSignature(@APropInfo);
End;

(******************************************************************************)

Constructor TMethodEx.Create(Const AMethod : TMethod);
Begin
  InHerited Create(True);

  FMethod  := AMethod;
  FEnabled := True;
End;

Function TMethodEx.GetMethod() : TMethod;
Begin
  Result := FMethod;
End;

Function TMethodEx.GetEnabled() : Boolean;
Begin
  Result := FEnabled;
End;

Procedure TMethodEx.SetEnabled(Const AEnabled : Boolean);
Begin
  FEnabled := AEnabled;
End;

Function TMethodListEx.Get(Index : Integer) : IMethodEx;
Begin
  Result := InHerited Items[Index] As IMethodEx;
End;

Procedure TMethodListEx.Put(Index : Integer; Item : IMethodEx);
Begin
  InHerited Items[Index] := Item;
End;

Function TMethodListEx.GetEventName() : String;
Begin
  Result := FEventName;
End;

Procedure TMethodListEx.SetEventName(Const AEventName : String);
Begin
  FEventName := AEventName;
End;

Function TMethodListEx.Add(Item : IMethodEx) : Integer;
Begin
  Result := InHerited Add(Item);
End;

Procedure TMethodListEx.Insert(Index : Integer; Item : IMethodEx);
Begin
  InHerited Insert(Index, Item);
End;

Function TMethodListEx.Remove(Item : IMethodEx) : Integer;
Begin
  Result := IndexOf(Item);
  If Result > -1 Then
    Delete(Result);
End;

Function TMethodListEx.IndexOf(Item : IMethodEx) : Integer;
Var X : Integer;
Begin
  Result := -1;

  For X := 0 To Count - 1 Do
    If (Items[X].Method.Code = Item.Method.Code) And
       (Items[X].Method.Data = Item.Method.Data) Then
    Begin
      Result := X;
      Break;
    End;
End;

Function TMethodInfoListEx.Get(Index : Integer) : IMethodListEx;
Begin
  Result := InHerited Items[Index] As IMethodListEx;
End;

Procedure TMethodInfoListEx.Put(Index : Integer; Const Item : IMethodListEx);
Begin
  InHerited Items[Index] := Item;
End;

Function TMethodInfoListEx.IndexOf(AEventName : String) : Integer;
Var X : Integer;
Begin
  Result := -1;

  For X := 0 To Count - 1 Do
    If SameText(Items[X].EventName, AEventName) Then
    Begin
      Result := X;
      Break;
    End;
End;

Function TMethodInfoListEx.Add(Item : IMethodListEx) : Integer;
Begin
  Result := InHerited Add(Item);
End;

Function TNotifyEventListEx.Get(Index : Integer) : TNotifyEvent;
Begin
  Result := TNotifyEvent(InHerited Items[Index].Method);
End;

Procedure TNotifyEventListEx.Put(Index : Integer; Item : TNotifyEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TNotifyEventListEx.Add(Item : TNotifyEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TNotifyEventListEx.Insert(Index: Integer; Item : TNotifyEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TNotifyEventListEx.Remove(Item : TNotifyEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TNotifyEventListEx.IndexOf(Item : TNotifyEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TNotifyEventListEx.GetExecuteProc() : TMethod;
Var lResult : TNotifyEvent; 
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TNotifyEventListEx.Execute(Sender : TObject);
Var X : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TNotifyEvent(lItem.Method)(Sender);
  End;
End;

Function TMouseEventListEx.Get(Index : Integer) : TMouseEvent;
Begin
  Result := TMouseEvent(InHerited Items[Index].Method);
End;

Procedure TMouseEventListEx.Put(Index : Integer; Item : TMouseEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TMouseEventListEx.Add(Item : TMouseEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TMouseEventListEx.Insert(Index: Integer; Item : TMouseEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TMouseEventListEx.Remove(Item : TMouseEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TMouseEventListEx.GetExecuteProc() : TMethod;
Var lRetVal : TMouseEvent;
Begin
  lRetVal := Execute;
  Result  := TMethod(lRetVal);
End;

Procedure TMouseEventListEx.Execute(Sender : TObject; Button : TMouseButton; Shift : TShiftState; X, Y : Integer);
Var Z : Integer;
    lItem : IMethodEx;
Begin
  For Z := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[Z];
    If lItem.Enabled Then
      TMouseEvent(lItem.Method)(Sender, Button, Shift, X, Y);
  End;
End;

Function TMouseMoveEventListEx.Get(Index : Integer) : TMouseMoveEvent;
Begin
  Result := TMouseMoveEvent(InHerited Items[Index].Method);
End;

Procedure TMouseMoveEventListEx.Put(Index : Integer; Item : TMouseMoveEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TMouseMoveEventListEx.Add(Item : TMouseMoveEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TMouseMoveEventListEx.Insert(Index: Integer; Item : TMouseMoveEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TMouseMoveEventListEx.Remove(Item : TMouseMoveEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TMouseMoveEventListEx.GetExecuteProc() : TMethod;
Var lRetVal : TMouseMoveEvent;
Begin
  lRetVal := Execute;
  Result  := TMethod(lRetVal);
End;

Procedure TMouseMoveEventListEx.Execute(Sender : TObject; Shift : TShiftState; X, Y : Integer);
Var Z : Integer;
    lItem : IMethodEx;
Begin
  For Z := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[Z];
    If lItem.Enabled Then
      TMouseMoveEvent(lItem.Method)(Sender, Shift, X, Y);
  End;
End;

Function TKeyEventListEx.Get(Index : Integer) : TKeyEvent;
Begin
  Result := TKeyEvent(InHerited Items[Index].Method);
End;

Procedure TKeyEventListEx.Put(Index : Integer; Item : TKeyEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TKeyEventListEx.Add(Item : TKeyEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TKeyEventListEx.Insert(Index : Integer; Item : TKeyEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TKeyEventListEx.Remove(Item : TKeyEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TKeyEventListEx.GetExecuteProc() : TMethod;
Var lRetVal : TKeyEvent;
Begin
  lRetVal := Execute;
  Result  := TMethod(lRetVal);
End;

Procedure TKeyEventListEx.Execute(Sender : TObject; Var Key : Word; Shift : TShiftState);
Var X : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TKeyEvent(lItem.Method)(Sender, Key, Shift);
  End;
End;

Function TKeyPressEventListEx.Get(Index : Integer) : TKeyPressEvent;
Begin
  Result := TKeyPressEvent(InHerited Items[Index].Method);
End;

Procedure TKeyPressEventListEx.Put(Index : Integer; Item : TKeyPressEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TKeyPressEventListEx.Add(Item : TKeyPressEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TKeyPressEventListEx.Insert(Index : Integer; Item : TKeyPressEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TKeyPressEventListEx.Remove(Item : TKeyPressEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TKeyPressEventListEx.GetExecuteProc() : TMethod;
Var lRetVal : TKeyPressEvent;
Begin
  lRetVal := Execute;
  Result  := TMethod(lRetVal);
End;

Procedure TKeyPressEventListEx.Execute(Sender : TObject; Var Key : Char);
Var X : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TKeyPressEvent(lItem.Method)(Sender, Key);
  End;
End;

Function TContextPopupEventListEx.Get(Index : Integer) : TContextPopupEvent;
Begin
  Result := TContextPopupEvent(InHerited Items[Index].Method);
End;

Procedure TContextPopupEventListEx.Put(Index : Integer; Item : TContextPopupEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TContextPopupEventListEx.Add(Item : TContextPopupEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TContextPopupEventListEx.Insert(Index : Integer; Item : TContextPopupEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TContextPopupEventListEx.Remove(Item : TContextPopupEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TContextPopupEventListEx.GetExecuteProc() : TMethod;
Var lRetVal : TContextPopupEvent;
Begin
  lRetVal := Execute;
  Result  := TMethod(lRetVal);
End;

Procedure TContextPopupEventListEx.Execute(Sender : TObject; MousePos : TPoint; Var Handled : Boolean);
Var X : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TContextPopupEvent(lItem.Method)(Sender, MousePos, Handled);
  End;
End;

Function TDockDropEventListEx.Get(Index : Integer) : TDockDropEvent;
Begin
  Result := TDockDropEvent(InHerited Items[Index].Method);
End;

Procedure TDockDropEventListEx.Put(Index : Integer; Item : TDockDropEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TDockDropEventListEx.Add(Item : TDockDropEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TDockDropEventListEx.Insert(Index : Integer; Item : TDockDropEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TDockDropEventListEx.Remove(Item : TDockDropEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TDockDropEventListEx.GetExecuteProc() : TMethod;
Var lRetVal : TDockDropEvent;
Begin
  lRetVal := Execute;
  Result  := TMethod(lRetVal);
End;

Procedure TDockDropEventListEx.Execute(Sender : TObject; Source : TDragDockObject; X, Y : Integer);
Var Z : Integer;
    lItem : IMethodEx;
Begin
  For Z := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[Z];
    If lItem.Enabled Then
      TDockDropEvent(lItem.Method)(Sender, Source, X, Y);
  End;
End;

Function TDockOverEventListEx.Get(Index : Integer) : TDockOverEvent;
Begin
  Result := TDockOverEvent(InHerited Items[Index].Method);
End;

Procedure TDockOverEventListEx.Put(Index : Integer; Item : TDockOverEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TDockOverEventListEx.Add(Item : TDockOverEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TDockOverEventListEx.Insert(Index : Integer; Item : TDockOverEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TDockOverEventListEx.Remove(Item : TDockOverEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TDockOverEventListEx.GetExecuteProc() : TMethod;
Var lRetVal : TDockOverEvent;
Begin
  lRetVal := Execute;
  Result  := TMethod(lRetVal);
End;

Procedure TDockOverEventListEx.Execute(Sender : TObject; Source : TDragDockObject;
  X, Y : Integer; State : TDragState; Var Accept : Boolean);
Var Z : Integer;
    lItem : IMethodEx;
Begin
  For Z := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[Z];
    If lItem.Enabled Then
      TDockOverEvent(lItem.Method)(Sender, Source, X, Y, State, Accept);
  End;
End;

Function TDragDropEventListEx.Get(Index : Integer) : TDragDropEvent;
Begin
  Result := TDragDropEvent(InHerited Items[Index].Method);
End;

Procedure TDragDropEventListEx.Put(Index : Integer; Item : TDragDropEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TDragDropEventListEx.Add(Item : TDragDropEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TDragDropEventListEx.Insert(Index : Integer; Item : TDragDropEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TDragDropEventListEx.Remove(Item : TDragDropEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TDragDropEventListEx.GetExecuteProc() : TMethod;
Var lRetVal : TDragDropEvent;
Begin
  lRetVal := Execute;
  Result  := TMethod(lRetVal);
End;

Procedure TDragDropEventListEx.Execute(Sender, Source : TObject; X, Y : Integer);
Var Z : Integer;
    lItem : IMethodEx;
Begin
  For Z := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[Z];
    If lItem.Enabled Then
      TDragDropEvent(lItem.Method)(Sender, Source, X, Y);
  End;
End;

Function TDragOverEventListEx.Get(Index : Integer) : TDragOverEvent;
Begin
  Result := TDragOverEvent(InHerited Items[Index].Method);
End;

Procedure TDragOverEventListEx.Put(Index : Integer; Item : TDragOverEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TDragOverEventListEx.Add(Item : TDragOverEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TDragOverEventListEx.Insert(Index : Integer; Item : TDragOverEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TDragOverEventListEx.Remove(Item : TDragOverEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TDragOverEventListEx.GetExecuteProc() : TMethod;
Var lRetVal : TDragOverEvent;
Begin
  lRetVal := Execute;
  Result  := TMethod(lRetVal);
End;

Procedure TDragOverEventListEx.Execute(Sender, Source : TObject; X, Y : Integer;
  State : TDragState; Var Accept : Boolean);
Var Z : Integer;
    lItem : IMethodEx;
Begin
  For Z := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[Z];
    If lItem.Enabled Then
      TDragOverEvent(lItem.Method)(Sender, Source, X, Y, State, Accept);
  End;
End;

Function TEndDragEventListEx.Get(Index : Integer) : TEndDragEvent;
Begin
  Result := TEndDragEvent(InHerited Items[Index].Method);
End;

Procedure TEndDragEventListEx.Put(Index : Integer; Item : TEndDragEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TEndDragEventListEx.Add(Item : TEndDragEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TEndDragEventListEx.Insert(Index : Integer; Item : TEndDragEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TEndDragEventListEx.Remove(Item : TEndDragEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TEndDragEventListEx.GetExecuteProc() : TMethod;
Var lRetVal : TEndDragEvent;
Begin
  lRetVal := Execute;
  Result  := TMethod(lRetVal);
End;

Procedure TEndDragEventListEx.Execute(Sender, Target : TObject; X, Y : Integer);
Var Z : Integer;
    lItem : IMethodEx;
Begin
  For Z := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[Z];
    If lItem.Enabled Then
      TEndDragEvent(lItem.Method)(Sender, Target, X, Y);
  End;
End;

Function TGetSiteInfoEventListEx.Get(Index : Integer) : TGetSiteInfoEvent;
Begin
  Result := TGetSiteInfoEvent(InHerited Items[Index].Method);
End;

Procedure TGetSiteInfoEventListEx.Put(Index : Integer; Item : TGetSiteInfoEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TGetSiteInfoEventListEx.Add(Item : TGetSiteInfoEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TGetSiteInfoEventListEx.Insert(Index : Integer; Item : TGetSiteInfoEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TGetSiteInfoEventListEx.Remove(Item : TGetSiteInfoEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TGetSiteInfoEventListEx.GetExecuteProc() : TMethod;
Var lRetVal : TGetSiteInfoEvent;
Begin
  lRetVal := Execute;
  Result  := TMethod(lRetVal);
End;

Procedure TGetSiteInfoEventListEx.Execute(Sender : TObject; DockClient : TControl;
  Var InfluenceRect : TRect; MousePos : TPoint; Var CanDock : Boolean);
Var Z : Integer;
    lItem : IMethodEx;
Begin
  For Z := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[Z];
    If lItem.Enabled Then
      TGetSiteInfoEvent(lItem.Method)(Sender, DockClient, InfluenceRect, MousePos, CanDock);
  End;
End;

Function TStartDockEventListEx.Get(Index : Integer) : TStartDockEvent;
Begin
  Result := TStartDockEvent(InHerited Items[Index].Method);
End;

Procedure TStartDockEventListEx.Put(Index : Integer; Item : TStartDockEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TStartDockEventListEx.Add(Item : TStartDockEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TStartDockEventListEx.Insert(Index : Integer; Item : TStartDockEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TStartDockEventListEx.Remove(Item : TStartDockEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TStartDockEventListEx.GetExecuteProc() : TMethod;
Var lRetVal : TStartDockEvent;
Begin
  lRetVal := Execute;
  Result  := TMethod(lRetVal);
End;

Procedure TStartDockEventListEx.Execute(Sender : TObject; Var DragObject : TDragDockObject);
Var Z : Integer;
    lItem : IMethodEx;
Begin
  For Z := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[Z];
    If lItem.Enabled Then
      TStartDockEvent(lItem.Method)(Sender, DragObject);
  End;
End;

Function TStartDragEventListEx.Get(Index : Integer) : TStartDragEvent;
Begin
  Result := TStartDragEvent(InHerited Items[Index].Method);
End;

Procedure TStartDragEventListEx.Put(Index : Integer; Item : TStartDragEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TStartDragEventListEx.Add(Item : TStartDragEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TStartDragEventListEx.Insert(Index : Integer; Item : TStartDragEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TStartDragEventListEx.Remove(Item : TStartDragEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TStartDragEventListEx.GetExecuteProc() : TMethod;
Var lRetVal : TStartDragEvent;
Begin
  lRetVal := Execute;
  Result  := TMethod(lRetVal);
End;

Procedure TStartDragEventListEx.Execute(Sender : TObject; Var DragObject : TDragObject);
Var Z : Integer;
    lItem : IMethodEx;
Begin
  For Z := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[Z];
    If lItem.Enabled Then
      TStartDragEvent(lItem.Method)(Sender, DragObject);
  End;
End;

Function TUnDockEventListEx.Get(Index : Integer) : TUnDockEvent;
Begin
  Result := TUnDockEvent(InHerited Items[Index].Method);
End;

Procedure TUnDockEventListEx.Put(Index : Integer; Item : TUnDockEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TUnDockEventListEx.Add(Item : TUnDockEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TUnDockEventListEx.Insert(Index : Integer; Item : TUnDockEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TUnDockEventListEx.Remove(Item : TUnDockEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TUnDockEventListEx.GetExecuteProc() : TMethod;
Var lRetVal : TUnDockEvent;
Begin
  lRetVal := Execute;
  Result  := TMethod(lRetVal);
End;

Procedure TUnDockEventListEx.Execute(Sender : TObject; Client : TControl;
  NewTarget : TWinControl; Var Allow : Boolean);
Var Z : Integer;
    lItem : IMethodEx;
Begin
  For Z := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[Z];
    If lItem.Enabled Then
      TUnDockEvent(lItem.Method)(Sender, Client, NewTarget, Allow);
  End;
End;

Function TDrawItemEventListEx.Get(Index : Integer) : TDrawItemEvent;
Begin
  Result := TDrawItemEvent(InHerited Items[Index].Method);
End;

Procedure TDrawItemEventListEx.Put(Index : Integer; Item : TDrawItemEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TDrawItemEventListEx.Add(Item : TDrawItemEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TDrawItemEventListEx.Insert(Index : Integer; Item : TDrawItemEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TDrawItemEventListEx.Remove(Item : TDrawItemEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TDrawItemEventListEx.GetExecuteProc() : TMethod;
Var lRetVal : TDrawItemEvent;
Begin
  lRetVal := Execute;
  Result  := TMethod(lRetVal);
End;

Procedure TDrawItemEventListEx.Execute(Control : TWinControl; Index : Integer;
      Rect : TRect; State : TOwnerDrawState);
Var Z : Integer;
    lItem : IMethodEx;
Begin
  For Z := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[Z];
    If lItem.Enabled Then
      TDrawItemEvent(lItem.Method)(Control, Index, Rect, State);
  End;
End;

Function TMeasureItemEventListEx.Get(Index : Integer) : TMeasureItemEvent;
Begin
  Result := TMeasureItemEvent(InHerited Items[Index].Method);
End;

Procedure TMeasureItemEventListEx.Put(Index : Integer; Item : TMeasureItemEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TMeasureItemEventListEx.Add(Item : TMeasureItemEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TMeasureItemEventListEx.Insert(Index : Integer; Item : TMeasureItemEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TMeasureItemEventListEx.Remove(Item : TMeasureItemEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TMeasureItemEventListEx.GetExecuteProc() : TMethod;
Var lRetVal : TMeasureItemEvent;
Begin
  lRetVal := Execute;
  Result  := TMethod(lRetVal);
End;

Procedure TMeasureItemEventListEx.Execute(Control : TWinControl; Index : Integer; Var Height : Integer);
Var Z : Integer;
    lItem : IMethodEx;
Begin
  For Z := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[Z];
    If lItem.Enabled Then
      TMeasureItemEvent(lItem.Method)(Control, Index, Height);
  End;
End;

(******************************************************************************)

Function TPropInfoListEx.CreatePropInfoPointer(Const APropInfo : TPropInfo) : Pointer;
Begin
  Result := New(PPropInfo);
  PPropInfo(Result)^ := APropInfo;
End;

Procedure TPropInfoListEx.Notify(Ptr : Pointer; Action : TListNotification);
Begin
  If Action In [lnDeleted] Then
    Dispose(Ptr);
End;

Function TPropInfoListEx.Get(Index : Integer) : TPropInfo;
Begin
  Result := TPropInfo(InHerited Items[Index]^);
End;

Procedure TPropInfoListEx.Put(Index : Integer; Item : TPropInfo);
Begin
  InHerited Items[Index] := CreatePropInfoPointer(Item);
End;

Function TPropInfoListEx.Add(Item : TPropInfo) : Integer;
Begin
  Result := InHerited Add(CreatePropInfoPointer(Item));
End;

(******************************************************************************)

Constructor TCustomEventDispatcher.Create(AComponent : TObject);
Begin
  InHerited Create(True);

  FComponent     := AComponent;
  FEvents        := TMethodInfoListEx.Create();

  FUnknownEvents := TPropInfoListEx.Create();//TStringList.Create();
  FKnownEvents   := TStringList.Create();

  InitEvents();
End;

Destructor TCustomEventDispatcher.Destroy();
Var X      : Integer;
    lProps : PPropInfo;
    lEvt   : TMethod;
Begin
  FUnknownEvents := Nil;
  FKnownEvents.Free();

  For X := 0 To FEvents.Count - 1 Do
  Begin
    lProps := GetPropInfo(FComponent.ClassInfo, FEvents[X].EventName, [tkMethod]);
    If Assigned(lProps) Then
    Begin
      lEvt.Code := Nil;
      lEvt.Data := Nil;

      If FEvents[X].Count > 0 Then
        lEvt := FEvents[X][0].Method;

      SetMethodProp(FComponent, FEvents[X].EventName, lEvt);
    End;
  End;
  FEvents := Nil;

  InHerited Destroy();
End;

Function TCustomEventDispatcher.InternalInitList(Const AEventName : String; AListClass : TMethodListExClass) : IMethodListEx;
Var lProps : PPropInfo;
    lEvt   : TMethod;
Begin
  lProps := GetPropInfo(FComponent.ClassInfo, AEventName, [tkMethod]);
  If Assigned(lProps) Then
  Begin
    Result := AListClass.Create();
    Result.EventName := AEventName;

    lEvt := GetMethodProp(FComponent, AEventName);
    If Assigned(lEvt.Code) And Assigned(lEvt.Data) Then
      Result.Add(TMethodEx.Create(lEvt));

    SetMethodProp(FComponent, AEventName, Result.GetExecuteProc());

    FKnownEvents.Add(AListClass.ClassName + ' - ' + AEventName);
  End
  Else
    Result := Nil;
End;

Function TCustomEventDispatcher.GetEventImplementor(AEvent : TMethod) : IMethodListEx;
Var lEvt : TMethod;
    X    : Integer;
Begin
  Result := Nil;

  For X := 0 To Events.Count - 1 Do
  Begin
    lEvt := Events[X].GetExecuteProc();

    If (lEvt.Code = AEvent.Code) And
       (lEvt.Data = AEvent.Data) Then
    Begin
      Result := Events[X];
      Break;
    End;
  End;
End;

Procedure TCustomEventDispatcher.InitEvents();
Var lProps      : TPropList;
    lNbProp     : Integer;
    X           : Integer;
Begin
  lNbProp := GetPropList(PTypeInfo(FComponent.ClassInfo), [tkMethod], @lProps, True);
  For X := 0 To lNbProp - 1 Do
  Begin
    If SameText(lProps[X].PropType^.Name, 'TNotifyEvent') Then
      FEvents.Add(InternalInitList(lProps[X].Name, TNotifyEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TMouseEvent') Then
      FEvents.Add(InternalInitList(lProps[X].Name, TMouseEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TMouseMoveEvent') Then
      FEvents.Add(InternalInitList(lProps[X].Name, TMouseMoveEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TKeyEvent') Then
      FEvents.Add(InternalInitList(lProps[X].Name, TKeyEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TKeyPressEvent') Then
      FEvents.Add(InternalInitList(lProps[X].Name, TKeyPressEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TContextPopupEvent') Then
      FEvents.Add(InternalInitList(lProps[X].Name, TContextPopupEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TDockDropEvent') Then
      FEvents.Add(InternalInitList(lProps[X].Name, TDockDropEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TDockOverEvent') Then
      FEvents.Add(InternalInitList(lProps[X].Name, TDockOverEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TDragDropEvent') Then
      FEvents.Add(InternalInitList(lProps[X].Name, TDragDropEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TDragOverEvent') Then
      FEvents.Add(InternalInitList(lProps[X].Name, TDragOverEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TEndDragEvent') Then
      FEvents.Add(InternalInitList(lProps[X].Name, TEndDragEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TGetSiteInfoEvent') Then
      FEvents.Add(InternalInitList(lProps[X].Name, TGetSiteInfoEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TStartDockEvent') Then
      FEvents.Add(InternalInitList(lProps[X].Name, TStartDockEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TStartDragEvent') Then
      FEvents.Add(InternalInitList(lProps[X].Name, TStartDragEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TUnDockEvent') Then
      FEvents.Add(InternalInitList(lProps[X].Name, TUnDockEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TDrawItemEvent') Then
      FEvents.Add(InternalInitList(lProps[X].Name, TDrawItemEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TMeasureItemEvent') Then
      FEvents.Add(InternalInitList(lProps[X].Name, TMeasureItemEventListEx))
    Else If FEvents.IndexOf(lProps[X].Name) = -1 Then
      FUnknownEvents.Add(lProps[X]^);
  End;
End;

Procedure TCustomEventDispatcher.InternalRegisterEvent(AEvent, ANewEvent : TMethod; Const Index : Integer = -1);
Var lList : IMethodListEx;
Begin
  lList := GetEventImplementor(AEvent);
  If Assigned(lList) Then
    If Index > -1 Then
      lList.Insert(Index, TMethodEx.Create(ANewEvent))
    Else
      lList.Add(TMethodEx.Create(ANewEvent));
End;

Procedure TCustomEventDispatcher.InternalUnRegisterEvent(AEvent, AOldEvent : TMethod);
Var lList : IMethodListEx;
Begin
  lList := GetEventImplementor(AEvent);
  If Assigned(lList) Then
    lList.Remove(TMethodEx.Create(AOldEvent));
End;

Procedure TCustomEventDispatcher.InternalDisableEvent(AEvent, ADisabledEvent : TMethod);
Var lList : IMethodListEx;
    lIdx  : Integer;
Begin
  lList := GetEventImplementor(AEvent);
  If Assigned(lList) Then
  Begin
    lIdx := lList.IndexOf(TMethodEx.Create(ADisabledEvent));
    If lIdx > -1 Then
      lList[lIdx].Enabled := False;
  End;
End;

Procedure TCustomEventDispatcher.InternalEnableEvent(AEvent, AEnabledEvent : TMethod);
Var lList : IMethodListEx;
    lIdx  : Integer;
Begin
  lList := GetEventImplementor(AEvent);
  If Assigned(lList) Then
  Begin
    lIdx := lList.IndexOf(TMethodEx.Create(AEnabledEvent));
    If lIdx > -1 Then
      lList[lIdx].Enabled := True;
  End;
End;

Procedure TCustomEventDispatcher.RegisterNotifyEvent(AEvent, ANewEvent : TNotifyEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TCustomEventDispatcher.UnRegisterNotifyEvent(AEvent, AOldEvent : TNotifyEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TCustomEventDispatcher.DisableNotifyEvent(AEvent, ADisabledEvent : TNotifyEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TCustomEventDispatcher.EnableNotifyEvent(AEvent, AEnabledEvent : TNotifyEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TCustomEventDispatcher.RegisterMouseEvent(AEvent, ANewEvent : TMouseEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TCustomEventDispatcher.UnRegisterMouseEvent(AEvent, AOldEvent : TMouseEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TCustomEventDispatcher.DisableMouseEvent(AEvent, ADisabledEvent : TMouseEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TCustomEventDispatcher.EnableMouseEvent(AEvent, AEnabledEvent : TMouseEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TCustomEventDispatcher.RegisterMouseMoveEvent(AEvent, ANewEvent : TMouseMoveEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TCustomEventDispatcher.UnRegisterMouseMoveEvent(AEvent, AOldEvent : TMouseMoveEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TCustomEventDispatcher.DisableMouseMoveEvent(AEvent, ADisabledEvent : TMouseMoveEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TCustomEventDispatcher.EnableMouseMoveEvent(AEvent, AEnabledEvent : TMouseMoveEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TCustomEventDispatcher.RegisterKeyEvent(AEvent, ANewEvent : TKeyEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TCustomEventDispatcher.UnRegisterKeyEvent(AEvent, AOldEvent : TKeyEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TCustomEventDispatcher.DisableKeyEvent(AEvent, ADisabledEvent : TKeyEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TCustomEventDispatcher.EnableKeyEvent(AEvent, AEnabledEvent : TKeyEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TCustomEventDispatcher.RegisterKeyPressEvent(AEvent, ANewEvent : TKeyPressEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TCustomEventDispatcher.UnRegisterKeyPressEvent(AEvent, AOldEvent : TKeyPressEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TCustomEventDispatcher.DisableKeyPressEvent(AEvent, ADisabledEvent : TKeyPressEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TCustomEventDispatcher.EnableKeyPressEvent(AEvent, AEnabledEvent : TKeyPressEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TCustomEventDispatcher.RegisterContextPopupEvent(AEvent, ANewEvent : TContextPopupEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TCustomEventDispatcher.UnRegisterContextPopupEvent(AEvent, AOldEvent : TContextPopupEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TCustomEventDispatcher.DisableContextPopupEvent(AEvent, ADisabledEvent : TContextPopupEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TCustomEventDispatcher.EnableContextPopupEvent(AEvent, AEnabledEvent : TContextPopupEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TCustomEventDispatcher.RegisterDockDropEvent(AEvent, ANewEvent : TDockDropEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TCustomEventDispatcher.UnRegisterDockDropEvent(AEvent, AOldEvent : TDockDropEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TCustomEventDispatcher.DisableDockDropEvent(AEvent, ADisabledEvent : TDockDropEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TCustomEventDispatcher.EnableDockDropEvent(AEvent, AEnabledEvent : TDockDropEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TCustomEventDispatcher.RegisterDockOverEvent(AEvent, ANewEvent : TDockOverEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TCustomEventDispatcher.UnRegisterDockOverEvent(AEvent, AOldEvent : TDockOverEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TCustomEventDispatcher.DisableDockOverEvent(AEvent, ADisabledEvent : TDockOverEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TCustomEventDispatcher.EnableDockOverEvent(AEvent, AEnabledEvent : TDockOverEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TCustomEventDispatcher.RegisterDragDropEvent(AEvent, ANewEvent : TDragDropEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TCustomEventDispatcher.UnRegisterDragDropEvent(AEvent, AOldEvent : TDragDropEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TCustomEventDispatcher.DisableDragDropEvent(AEvent, ADisabledEvent : TDragDropEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TCustomEventDispatcher.EnableDragDropEvent(AEvent, AEnabledEvent : TDragDropEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TCustomEventDispatcher.RegisterDragOverEvent(AEvent, ANewEvent : TDragOverEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TCustomEventDispatcher.UnRegisterDragOverEvent(AEvent, AOldEvent : TDragOverEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TCustomEventDispatcher.DisableDragOverEvent(AEvent, ADisabledEvent : TDragOverEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TCustomEventDispatcher.EnableDragOverEvent(AEvent, AEnabledEvent : TDragOverEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TCustomEventDispatcher.RegisterEndDragEvent(AEvent, ANewEvent : TEndDragEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TCustomEventDispatcher.UnRegisterEndDragEvent(AEvent, AOldEvent : TEndDragEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TCustomEventDispatcher.DisableEndDragEvent(AEvent, ADisabledEvent : TEndDragEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TCustomEventDispatcher.EnableEndDragEvent(AEvent, AEnabledEvent : TEndDragEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TCustomEventDispatcher.RegisterGetSiteInfoEvent(AEvent, ANewEvent : TGetSiteInfoEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TCustomEventDispatcher.UnRegisterGetSiteInfoEvent(AEvent, AOldEvent : TGetSiteInfoEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TCustomEventDispatcher.DisableGetSiteInfoEvent(AEvent, ADisabledEvent : TGetSiteInfoEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TCustomEventDispatcher.EnableGetSiteInfoEvent(AEvent, AEnabledEvent : TGetSiteInfoEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TCustomEventDispatcher.RegisterStartDockEvent(AEvent, ANewEvent : TStartDockEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TCustomEventDispatcher.UnRegisterStartDockEvent(AEvent, AOldEvent : TStartDockEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TCustomEventDispatcher.DisableStartDockEvent(AEvent, ADisabledEvent : TStartDockEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TCustomEventDispatcher.EnableStartDockEvent(AEvent, AEnabledEvent : TStartDockEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TCustomEventDispatcher.RegisterStartDragEvent(AEvent, ANewEvent : TStartDragEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TCustomEventDispatcher.UnRegisterStartDragEvent(AEvent, AOldEvent : TStartDragEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TCustomEventDispatcher.DisableStartDragEvent(AEvent, ADisabledEvent : TStartDragEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TCustomEventDispatcher.EnableStartDragEvent(AEvent, AEnabledEvent : TStartDragEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TCustomEventDispatcher.RegisterUnDockEvent(AEvent, ANewEvent : TUnDockEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TCustomEventDispatcher.UnRegisterUnDockEvent(AEvent, AOldEvent : TUnDockEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TCustomEventDispatcher.DisableUnDockEvent(AEvent, ADisabledEvent : TUnDockEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TCustomEventDispatcher.EnableUnDockEvent(AEvent, AEnabledEvent : TUnDockEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TCustomEventDispatcher.RegisterDrawItemEvent(AEvent, ANewEvent : TDrawItemEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TCustomEventDispatcher.UnRegisterDrawItemEvent(AEvent, AOldEvent : TDrawItemEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TCustomEventDispatcher.DisableDrawItemEvent(AEvent, ADisabledEvent : TDrawItemEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TCustomEventDispatcher.EnableDrawItemEvent(AEvent, AEnabledEvent : TDrawItemEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TCustomEventDispatcher.RegisterMeasureItemEvent(AEvent, ANewEvent : TMeasureItemEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TCustomEventDispatcher.UnRegisterMeasureItemEvent(AEvent, AOldEvent : TMeasureItemEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TCustomEventDispatcher.DisableMeasureItemEvent(AEvent, ADisabledEvent : TMeasureItemEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TCustomEventDispatcher.EnableMeasureItemEvent(AEvent, AEnabledEvent : TMeasureItemEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Function TCustomEventDispatcher.GenerateUnknownEventClasses() : String;
Var lLst : TStringList;
    lLstEvt : IPropInfoListEx;

  Function GetExecuteParam(APropInfo : TPropInfo) : String;
  Var lParams : IParamRecs;
      X : Integer;
  Begin
    Result := '';

    lParams := TParamRecs.Create();
    Try
      lParams.Load(GetTypeData(APropInfo.PropType^));

      For X := 0 To lParams.Count - 1 Do
      Begin
        Result := Result + lParams[X].AsString;
        If X < lParams.Count - 1 Then
          Result := Result + '; ';
      End;

      Finally
        lParams := Nil;
    End;
  End;

  Function GetGuid() : String;
  Const
    MagicGuid = 2383012921268594798;
  Var lGuidRec : Packed Record
        Case Boolean Of
          True : (Guid : TGuid);
          False : (Int1, Int2 : Int64);
      End;
  Begin
    CreateGUID(lGuidRec.Guid);
    lGuidRec.Int1 := MagicGuid;
    Result := GUIDToString(lGuidRec.Guid);
  End;

  Procedure GenerateInterface(APropInfo : TPropInfo);
  Var lEvtName : String;
  Begin
    lEvtName := APropInfo.PropType^.Name;

    lLst.Add('  I' + Copy(lEvtName, 2, Length(lEvtName)) + 'ListEx = Interface(IMethodListEx)');
    lLst.Add('    [''' + GetGuid() + ''']');
    lLst.Add('    Function  Get(Index : Integer) : ' + lEvtName + ';');
    lLst.Add('    Procedure Put(Index : Integer; Item : ' + lEvtName + ');');
    lLst.Add('');
    lLst.Add('    Function  Add(Item : ' + lEvtName +  ') : Integer;');
    lLst.Add('    Procedure Insert(Index : Integer; Item : ' + lEvtName + ');');
    lLst.Add('    Function  Remove(Item : ' + lEvtName + ') : Integer;');
    lLst.Add('    Function  IndexOf(Item : ' + lEvtName + ') : Integer;');
    lLst.Add('');
    lLst.Add('    Procedure Execute(' + GetExecuteParam(APropInfo) + ');');
    lLst.Add('');
    lLst.Add('    Property Items[Index : Integer] : ' + lEvtName + ' Read Get Write Put; Default;');
    lLst.Add('');
    lLst.Add('  End;');
  End;

  Procedure GenerateClassDef(APropInfo : TPropInfo);
  Var lEvtName : String;
  Begin
    lEvtName := APropInfo.PropType^.Name;

    lLst.Add('  ' + lEvtName + 'ListEx = Class(TMethodListEx, I' + Copy(lEvtName, 2, Length(lEvtName)) + 'ListEx)');
    lLst.Add('  Protected');
    lLst.Add('    Function  Get(Index : Integer) : ' + lEvtName + '; OverLoad;');
    lLst.Add('    Procedure Put(Index : Integer; Item : ' + lEvtName + '); OverLoad;');
    lLst.Add('');
    lLst.Add('    Function  GetExecuteProc() : TMethod; OverRide;');
    lLst.Add('');
    lLst.Add('  Public');
    lLst.Add('    Property Items[Index : Integer] : ' + lEvtName + ' Read Get Write Put; Default;');
    lLst.Add('');
    lLst.Add('    Function  Add(Item : ' + lEvtName +  ') : Integer; OverLoad;');
    lLst.Add('    Procedure Insert(Index : Integer; Item : ' + lEvtName + '); OverLoad;');
    lLst.Add('    Function  Remove(Item : ' + lEvtName + ') : Integer; OverLoad;');
    lLst.Add('    Function  IndexOf(Item : ' + lEvtName + ') : Integer; OverLoad;');
    lLst.Add('');
    lLst.Add('    Procedure Execute(' + GetExecuteParam(APropInfo) + ');');
    lLst.Add('');
    lLst.Add('  End;');
  End;

  Procedure GenerateClassImpl(APropInfo : TPropInfo);
  Var lEvtName     : String;
      lEvtParamStr : String;
      lEvtParams   : IParamRecs;
      X            : Integer;
  Begin
    lEvtName := APropInfo.PropType^.Name;

    lLst.Add('Function ' + lEvtName + 'ListEx.Get(Index : Integer) : ' + lEvtName + ';');
    lLst.Add('Begin');
    lLst.Add('  Result := ' + lEvtName + '(InHerited Items[Index].Method);');
    lLst.Add('End;');
    lLst.Add('');
    lLst.Add('Procedure ' + lEvtName + 'ListEx.Put(Index : Integer; Item : ' + lEvtName + ');');
    lLst.Add('Begin');
    lLst.Add('  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));');
    lLst.Add('End;');
    lLst.Add('');
    lLst.Add('Function ' + lEvtName + 'ListEx.Add(Item : ' + lEvtName + ') : Integer;');
    lLst.Add('Begin');
    lLst.Add('  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));');
    lLst.Add('End;');
    lLst.Add('');
    lLst.Add('Procedure ' + lEvtName + 'ListEx.Insert(Index: Integer; Item : ' + lEvtName + ');');
    lLst.Add('Begin');
    lLst.Add('  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));');
    lLst.Add('End;');
    lLst.Add('');
    lLst.Add('Function ' + lEvtName + 'ListEx.Remove(Item : ' + lEvtName + ') : Integer;');
    lLst.Add('Begin');
    lLst.Add('  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));');
    lLst.Add('End;');
    lLst.Add('');
    lLst.Add('Function ' + lEvtName + 'ListEx.IndexOf(Item : ' + lEvtName + ') : Integer;');
    lLst.Add('Begin');
    lLst.Add('  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));');
    lLst.Add('End;');
    lLst.Add('');
    lLst.Add('Function ' + lEvtName + 'ListEx.GetExecuteProc() : TMethod;');
    lLst.Add('Var lResult : ' + lEvtName + ';');
    lLst.Add('Begin');
    lLst.Add('  lResult := Execute;');
    lLst.Add('  Result  := TMethod(lResult);');
    lLst.Add('End;');
    lLst.Add('');

    lEvtParamStr := '';
    lEvtParams := TParamRecs.Create();
    Try
      lEvtParams.Load(GetTypeData(APropInfo.PropType^));

      For X := 0 To lEvtParams.Count - 1 Do
      Begin
        lEvtParamStr := lEvtParamStr + lEvtParams[X].ParamName;

        If X < lEvtParams.Count - 1 Then
          lEvtParamStr := lEvtParamStr + ', ';
      End;

      Finally
        lEvtParams := Nil;
    End;

    lLst.Add('Procedure ' + lEvtName + 'ListEx.Execute(' + GetExecuteParam(APropInfo) + ');');
    lLst.Add('Var X     : Integer;');
    lLst.Add('    lItem : IMethodEx;');
    lLst.Add('Begin');
    lLst.Add('  For X := 0 To Count - 1 Do');
    lLst.Add('  Begin');
    lLst.Add('    lItem := InHerited Items[X];');
    lLst.Add('    If lItem.Enabled Then');
    lLst.Add('      ' + lEvtName + '(lItem.Method)(' + lEvtParamStr + ');');
    lLst.Add('  End;');
    lLst.Add('End;');
  End;

  Procedure GenerateEventDispatcherIntf();
  Var X : Integer;
      lEvtName : String;
  Begin
    lLst.Add('  INewDispatcher = Interface(IEventDispatcher)');
    lLst.Add('    [''' + GetGuid() + ''']');

    For X := 0 To lLstEvt.Count - 1 Do
    Begin
      lEvtName := Copy(lLstEvt[X].PropType^.Name, 2, Length(lLstEvt[X].PropType^.Name));

      lLst.Add('    Procedure Register' + lEvtName + '(AEvent, ANewEvent : T' + lEvtName + '; Const Index : Integer = -1);');
      lLst.Add('    Procedure UnRegister' + lEvtName + '(AEvent, AOldEvent : T' + lEvtName + ');');
      lLst.Add('    Procedure Disable' + lEvtName + '(AEvent, ADisabledEvent : T' + lEvtName + ');');
      lLst.Add('    Procedure Enable' + lEvtName + '(AEvent, AEnabledEvent : T' + lEvtName + ');');
      lLst.Add('');
    End;
    lLst.Add('  End;');
    lLst.Add('');
    lLst.Add('  TNewDispatcher = Class(TCustomEventDispatcher, INewDispatcher)');
    lLst.Add('  Protected');
    lLst.Add('    Procedure InitEvents(); OverRide;');
    lLst.Add('');

    For X := 0 To lLstEvt.Count - 1 Do
    Begin
      lEvtName := Copy(lLstEvt[X].PropType^.Name, 2, Length(lLstEvt[X].PropType^.Name));

      lLst.Add('    Procedure Register' + lEvtName + '(AEvent, ANewEvent : T' + lEvtName + '; Const Index : Integer = -1);');
      lLst.Add('    Procedure UnRegister' + lEvtName + '(AEvent, AOldEvent : T' + lEvtName + ');');
      lLst.Add('    Procedure Disable' + lEvtName + '(AEvent, ADisabledEvent : T' + lEvtName + ');');
      lLst.Add('    Procedure Enable' + lEvtName + '(AEvent, AEnabledEvent : T' + lEvtName + ');');
      lLst.Add('');
    End;
    lLst.Add('  End;');
  End;

  Procedure GenerateEventDispatcherImpl();
  Var X        : Integer;
      lEvtName : String;
  Begin
    lLst.Add('Procedure TNewDispatcher.InitEvents();');
    lLst.Add('Var lProps      : TPropList;');
    lLst.Add('    lNbProp     : Integer;');
    lLst.Add('    X           : Integer;');
    lLst.Add('Begin');
    lLst.Add('  lNbProp := GetPropList(PTypeInfo(Component.ClassInfo), [tkMethod], @lProps, True);');
    lLst.Add('  For X := 0 To lNbProp - 1 Do');
    lLst.Add('  Begin');

    For X := 0 To lLstEvt.Count - 1 Do
    Begin
      lEvtName := lLstEvt[X].PropType^.Name;
      If X = 0 Then
        lLst.Add('    If SameText(lProps[X].PropType^.Name, ''' + lEvtName + ''') Then')
      Else
        lLst.Add('    Else If SameText(lProps[X].PropType^.Name, ''' + lEvtName + ''') Then');

      lLst.Add('      Events.Add(InternalInitList(lProps[X].Name, ' + lEvtName + 'ListEx))');
    End;
    lLst[lLst.Count - 1] := lLst[lLst.Count - 1] + ';';

    lLst.Add('  End;');
    lLst.Add('');
    lLst.Add('  InHerited InitEvents();');
    lLst.Add('End;');

    lLst.Add('');

    For X := 0 To lLstEvt.Count - 1 Do
    Begin
      lEvtName := Copy(lLstEvt[X].PropType^.Name, 2, Length(lLstEvt[X].PropType^.Name));

      lLst.Add('Procedure TNewDispatcher.Register' + lEvtName + '(AEvent, ANewEvent : T' + lEvtName + '; Const Index : Integer = -1);');
      lLst.Add('Begin');
      lLst.Add('  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);');
      lLst.Add('End;');
      lLst.Add('');
      lLst.Add('Procedure TNewDispatcher.UnRegister' + lEvtName + '(AEvent, AOldEvent : T' + lEvtName + ');');
      lLst.Add('Begin');
      lLst.Add('  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));');
      lLst.Add('End;');
      lLst.Add('');
      lLst.Add('Procedure TNewDispatcher.Disable' + lEvtName + '(AEvent, ADisabledEvent : T' + lEvtName + ');');
      lLst.Add('Begin');
      lLst.Add('  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));');
      lLst.Add('End;');
      lLst.Add('');
      lLst.Add('Procedure TNewDispatcher.Enable' + lEvtName + '(AEvent, AEnabledEvent : T' + lEvtName + ');');
      lLst.Add('Begin');
      lLst.Add('  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));');
      lLst.Add('End;');
      lLst.Add('');
    End;
  End;

  Procedure BuildEventList();
    Function IndexOf(Const AEventName : String) : Integer;
    Var X : Integer;
    Begin
      Result := -1;

      For X := 0 To lLstEvt.Count - 1 Do
        If SameText(lLstEvt[X].PropType^.Name, AEventName) Then
        Begin
          Result := X;
          Break;
        End;
    End;

  Var X : Integer;
      lIdx : Integer;
  Begin
    lLstEvt := TPropInfoListEx.Create();

    For X := 0 To FUnknownEvents.Count - 1 Do
    Begin
      lIdx := IndexOf(FUnknownEvents[X].PropType^.Name);
      If lIdx = -1 Then
        lLstEvt.Add(FUnknownEvents[X]);
    End;
  End;

Var X : Integer;
Begin
  If FUnknownEvents.Count > 0 Then
  Begin
    BuildEventList();

    lLst := TStringList.Create();
    Try
      lLst.Add('Unit Unit1;');
      lLst.Add('');
      lLst.Add('Interface');
      lLst.Add('');
      lLst.Add('Uses HsEventListEx;');
      lLst.Add('');
      lLst.Add('Type');

      For X := 0 To lLstEvt.Count - 1 Do
      Begin
        GenerateInterface(lLstEvt[X]);
        lLst.Add('');
      End;

      For X := 0 To lLstEvt.Count - 1 Do
      Begin
        GenerateClassDef(lLstEvt[X]);
        lLst.Add('');
      End;

      lLst.Add('(******************************************************************************)');
      lLst.Add('');
      GenerateEventDispatcherIntf();
      lLst.Add('');
      
      lLst.Add('Implementation');
      lLst.Add('');
      lLst.Add('Uses TypInfo;');
      lLst.Add('');

      For X := 0 To lLstEvt.Count - 1 Do
      Begin
        GenerateClassImpl(lLstEvt[X]);
        lLst.Add('');
      End;

      GenerateEventDispatcherImpl();
      lLst.Add('End.');

      Result := lLst.Text;

      Finally
        lLst.Free();
        lLstEvt := Nil;
    End;
  End;
End;

end.
