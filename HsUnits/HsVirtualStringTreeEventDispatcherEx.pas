Unit HsVirtualStringTreeEventDispatcherEx;

Interface

Uses
  Windows, Graphics, Classes, ExtCtrls, Controls, ActiveX,
  ImgList, Menus, VirtualTrees, HsEventListEx;

Type
  IVTAddToSelectionEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-9B88-3A27823420C0}']
    Function  Get(Index : Integer) : TVTAddToSelectionEvent;
    Procedure Put(Index : Integer; Item : TVTAddToSelectionEvent);

    Function  Add(Item : TVTAddToSelectionEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTAddToSelectionEvent);
    Function  Remove(Item : TVTAddToSelectionEvent) : Integer;
    Function  IndexOf(Item : TVTAddToSelectionEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode);

    Property Items[Index : Integer] : TVTAddToSelectionEvent Read Get Write Put; Default;

  End;

  IVTAdvancedHeaderPaintEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-9427-D27723100FF6}']
    Function  Get(Index : Integer) : TVTAdvancedHeaderPaintEvent;
    Procedure Put(Index : Integer; Item : TVTAdvancedHeaderPaintEvent);

    Function  Add(Item : TVTAdvancedHeaderPaintEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTAdvancedHeaderPaintEvent);
    Function  Remove(Item : TVTAdvancedHeaderPaintEvent) : Integer;
    Function  IndexOf(Item : TVTAdvancedHeaderPaintEvent) : Integer;

    Procedure Execute(Sender : TVTHeader; Var PaintInfo : THeaderPaintInfo; Const Elements : THeaderPaintElements);

    Property Items[Index : Integer] : TVTAdvancedHeaderPaintEvent Read Get Write Put; Default;

  End;

  IVTAfterAutoFitColumnEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-9303-C54E8E19728D}']
    Function  Get(Index : Integer) : TVTAfterAutoFitColumnEvent;
    Procedure Put(Index : Integer; Item : TVTAfterAutoFitColumnEvent);

    Function  Add(Item : TVTAfterAutoFitColumnEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTAfterAutoFitColumnEvent);
    Function  Remove(Item : TVTAfterAutoFitColumnEvent) : Integer;
    Function  IndexOf(Item : TVTAfterAutoFitColumnEvent) : Integer;

    Procedure Execute(Sender : TVTHeader; Column : TColumnIndex);

    Property Items[Index : Integer] : TVTAfterAutoFitColumnEvent Read Get Write Put; Default;

  End;

  IVTAfterAutoFitColumnsEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-B3AC-BF669C4CC8C5}']
    Function  Get(Index : Integer) : TVTAfterAutoFitColumnsEvent;
    Procedure Put(Index : Integer; Item : TVTAfterAutoFitColumnsEvent);

    Function  Add(Item : TVTAfterAutoFitColumnsEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTAfterAutoFitColumnsEvent);
    Function  Remove(Item : TVTAfterAutoFitColumnsEvent) : Integer;
    Function  IndexOf(Item : TVTAfterAutoFitColumnsEvent) : Integer;

    Procedure Execute(Sender : TVTHeader);

    Property Items[Index : Integer] : TVTAfterAutoFitColumnsEvent Read Get Write Put; Default;

  End;

  IVTAfterCellPaintEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-9052-57D2CF2D3CCF}']
    Function  Get(Index : Integer) : TVTAfterCellPaintEvent;
    Procedure Put(Index : Integer; Item : TVTAfterCellPaintEvent);

    Function  Add(Item : TVTAfterCellPaintEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTAfterCellPaintEvent);
    Function  Remove(Item : TVTAfterCellPaintEvent) : Integer;
    Function  IndexOf(Item : TVTAfterCellPaintEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; TargetCanvas : TCanvas; Node : PVirtualNode; Column : TColumnIndex; CellRect : TRect);

    Property Items[Index : Integer] : TVTAfterCellPaintEvent Read Get Write Put; Default;

  End;

  IVTColumnExportEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-81D6-9873FD001EB5}']
    Function  Get(Index : Integer) : TVTColumnExportEvent;
    Procedure Put(Index : Integer; Item : TVTColumnExportEvent);

    Function  Add(Item : TVTColumnExportEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTColumnExportEvent);
    Function  Remove(Item : TVTColumnExportEvent) : Integer;
    Function  IndexOf(Item : TVTColumnExportEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; aExportType : TVTExportType; Column : TVirtualTreeColumn);

    Property Items[Index : Integer] : TVTColumnExportEvent Read Get Write Put; Default;

  End;

  IVTAfterColumnWidthTrackingEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-8A4D-655A0ECFCB66}']
    Function  Get(Index : Integer) : TVTAfterColumnWidthTrackingEvent;
    Procedure Put(Index : Integer; Item : TVTAfterColumnWidthTrackingEvent);

    Function  Add(Item : TVTAfterColumnWidthTrackingEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTAfterColumnWidthTrackingEvent);
    Function  Remove(Item : TVTAfterColumnWidthTrackingEvent) : Integer;
    Function  IndexOf(Item : TVTAfterColumnWidthTrackingEvent) : Integer;

    Procedure Execute(Sender : TVTHeader; Column : TColumnIndex);

    Property Items[Index : Integer] : TVTAfterColumnWidthTrackingEvent Read Get Write Put; Default;

  End;

  IVTAfterGetMaxColumnWidthEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-A134-5B262619B3E2}']
    Function  Get(Index : Integer) : TVTAfterGetMaxColumnWidthEvent;
    Procedure Put(Index : Integer; Item : TVTAfterGetMaxColumnWidthEvent);

    Function  Add(Item : TVTAfterGetMaxColumnWidthEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTAfterGetMaxColumnWidthEvent);
    Function  Remove(Item : TVTAfterGetMaxColumnWidthEvent) : Integer;
    Function  IndexOf(Item : TVTAfterGetMaxColumnWidthEvent) : Integer;

    Procedure Execute(Sender : TVTHeader; Column : TColumnIndex; Var MaxWidth : Integer);

    Property Items[Index : Integer] : TVTAfterGetMaxColumnWidthEvent Read Get Write Put; Default;

  End;

  IVTTreeExportEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-A88F-405DF66E36E8}']
    Function  Get(Index : Integer) : TVTTreeExportEvent;
    Procedure Put(Index : Integer; Item : TVTTreeExportEvent);

    Function  Add(Item : TVTTreeExportEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTTreeExportEvent);
    Function  Remove(Item : TVTTreeExportEvent) : Integer;
    Function  IndexOf(Item : TVTTreeExportEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; aExportType : TVTExportType);

    Property Items[Index : Integer] : TVTTreeExportEvent Read Get Write Put; Default;

  End;

  IVTAfterHeaderHeightTrackingEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-BA58-76E2CB663E50}']
    Function  Get(Index : Integer) : TVTAfterHeaderHeightTrackingEvent;
    Procedure Put(Index : Integer; Item : TVTAfterHeaderHeightTrackingEvent);

    Function  Add(Item : TVTAfterHeaderHeightTrackingEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTAfterHeaderHeightTrackingEvent);
    Function  Remove(Item : TVTAfterHeaderHeightTrackingEvent) : Integer;
    Function  IndexOf(Item : TVTAfterHeaderHeightTrackingEvent) : Integer;

    Procedure Execute(Sender : TVTHeader);

    Property Items[Index : Integer] : TVTAfterHeaderHeightTrackingEvent Read Get Write Put; Default;

  End;

  IVTAfterItemEraseEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-A0D8-239893112D98}']
    Function  Get(Index : Integer) : TVTAfterItemEraseEvent;
    Procedure Put(Index : Integer; Item : TVTAfterItemEraseEvent);

    Function  Add(Item : TVTAfterItemEraseEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTAfterItemEraseEvent);
    Function  Remove(Item : TVTAfterItemEraseEvent) : Integer;
    Function  IndexOf(Item : TVTAfterItemEraseEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; TargetCanvas : TCanvas; Node : PVirtualNode; ItemRect : TRect);

    Property Items[Index : Integer] : TVTAfterItemEraseEvent Read Get Write Put; Default;

  End;

  IVTAfterItemPaintEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-8EF8-519B349E0004}']
    Function  Get(Index : Integer) : TVTAfterItemPaintEvent;
    Procedure Put(Index : Integer; Item : TVTAfterItemPaintEvent);

    Function  Add(Item : TVTAfterItemPaintEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTAfterItemPaintEvent);
    Function  Remove(Item : TVTAfterItemPaintEvent) : Integer;
    Function  IndexOf(Item : TVTAfterItemPaintEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; TargetCanvas : TCanvas; Node : PVirtualNode; ItemRect : TRect);

    Property Items[Index : Integer] : TVTAfterItemPaintEvent Read Get Write Put; Default;

  End;

  IVTNodeExportEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-88E3-A5D2E64E3DE7}']
    Function  Get(Index : Integer) : TVTNodeExportEvent;
    Procedure Put(Index : Integer; Item : TVTNodeExportEvent);

    Function  Add(Item : TVTNodeExportEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTNodeExportEvent);
    Function  Remove(Item : TVTNodeExportEvent) : Integer;
    Function  IndexOf(Item : TVTNodeExportEvent) : Integer;

    Function Execute(Sender : TBaseVirtualTree; aExportType : TVTExportType; Node : PVirtualNode) : Boolean;
    
    Property Items[Index : Integer] : TVTNodeExportEvent Read Get Write Put; Default;

  End;

  IVTPaintEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-ACA7-F245E76D6CE9}']
    Function  Get(Index : Integer) : TVTPaintEvent;
    Procedure Put(Index : Integer; Item : TVTPaintEvent);

    Function  Add(Item : TVTPaintEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTPaintEvent);
    Function  Remove(Item : TVTPaintEvent) : Integer;
    Function  IndexOf(Item : TVTPaintEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; TargetCanvas : TCanvas);

    Property Items[Index : Integer] : TVTPaintEvent Read Get Write Put; Default;

  End;

  IVTBeforeAutoFitColumnEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-A439-AEDB326F5404}']
    Function  Get(Index : Integer) : TVTBeforeAutoFitColumnEvent;
    Procedure Put(Index : Integer; Item : TVTBeforeAutoFitColumnEvent);

    Function  Add(Item : TVTBeforeAutoFitColumnEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTBeforeAutoFitColumnEvent);
    Function  Remove(Item : TVTBeforeAutoFitColumnEvent) : Integer;
    Function  IndexOf(Item : TVTBeforeAutoFitColumnEvent) : Integer;

    Procedure Execute(Sender : TVTHeader; Column : TColumnIndex; Var SmartAutoFitType : TSmartAutoFitType; Var Allowed : Boolean);

    Property Items[Index : Integer] : TVTBeforeAutoFitColumnEvent Read Get Write Put; Default;

  End;

  IVTBeforeAutoFitColumnsEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-9DE6-238B54D358D7}']
    Function  Get(Index : Integer) : TVTBeforeAutoFitColumnsEvent;
    Procedure Put(Index : Integer; Item : TVTBeforeAutoFitColumnsEvent);

    Function  Add(Item : TVTBeforeAutoFitColumnsEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTBeforeAutoFitColumnsEvent);
    Function  Remove(Item : TVTBeforeAutoFitColumnsEvent) : Integer;
    Function  IndexOf(Item : TVTBeforeAutoFitColumnsEvent) : Integer;

    Procedure Execute(Sender : TVTHeader; Var SmartAutoFitType : TSmartAutoFitType);

    Property Items[Index : Integer] : TVTBeforeAutoFitColumnsEvent Read Get Write Put; Default;

  End;

  IVTBeforeCellPaintEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-A9E3-A052F1A91D9C}']
    Function  Get(Index : Integer) : TVTBeforeCellPaintEvent;
    Procedure Put(Index : Integer; Item : TVTBeforeCellPaintEvent);

    Function  Add(Item : TVTBeforeCellPaintEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTBeforeCellPaintEvent);
    Function  Remove(Item : TVTBeforeCellPaintEvent) : Integer;
    Function  IndexOf(Item : TVTBeforeCellPaintEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; TargetCanvas : TCanvas; Node : PVirtualNode; Column : TColumnIndex; CellPaintMode : TVTCellPaintMode; CellRect : TRect; Var ContentRect : TRect);

    Property Items[Index : Integer] : TVTBeforeCellPaintEvent Read Get Write Put; Default;

  End;

  IVTBeforeColumnWidthTrackingEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-BE42-FD88FAF69DE7}']
    Function  Get(Index : Integer) : TVTBeforeColumnWidthTrackingEvent;
    Procedure Put(Index : Integer; Item : TVTBeforeColumnWidthTrackingEvent);

    Function  Add(Item : TVTBeforeColumnWidthTrackingEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTBeforeColumnWidthTrackingEvent);
    Function  Remove(Item : TVTBeforeColumnWidthTrackingEvent) : Integer;
    Function  IndexOf(Item : TVTBeforeColumnWidthTrackingEvent) : Integer;

    Procedure Execute(Sender : TVTHeader; Column : TColumnIndex; Shift : TShiftState);

    Property Items[Index : Integer] : TVTBeforeColumnWidthTrackingEvent Read Get Write Put; Default;

  End;

  IVTBeforeDrawLineImageEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-A823-1ACD1D4E282E}']
    Function  Get(Index : Integer) : TVTBeforeDrawLineImageEvent;
    Procedure Put(Index : Integer; Item : TVTBeforeDrawLineImageEvent);

    Function  Add(Item : TVTBeforeDrawLineImageEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTBeforeDrawLineImageEvent);
    Function  Remove(Item : TVTBeforeDrawLineImageEvent) : Integer;
    Function  IndexOf(Item : TVTBeforeDrawLineImageEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Level : Integer; Var PosX : Integer);

    Property Items[Index : Integer] : TVTBeforeDrawLineImageEvent Read Get Write Put; Default;

  End;

  IVTBeforeGetMaxColumnWidthEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-9FD2-A0B7A53E3342}']
    Function  Get(Index : Integer) : TVTBeforeGetMaxColumnWidthEvent;
    Procedure Put(Index : Integer; Item : TVTBeforeGetMaxColumnWidthEvent);

    Function  Add(Item : TVTBeforeGetMaxColumnWidthEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTBeforeGetMaxColumnWidthEvent);
    Function  Remove(Item : TVTBeforeGetMaxColumnWidthEvent) : Integer;
    Function  IndexOf(Item : TVTBeforeGetMaxColumnWidthEvent) : Integer;

    Procedure Execute(Sender : TVTHeader; Column : TColumnIndex; Var UseSmartColumnWidth : Boolean);

    Property Items[Index : Integer] : TVTBeforeGetMaxColumnWidthEvent Read Get Write Put; Default;

  End;

  IVTBeforeHeaderHeightTrackingEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-9C85-B8D0ECC4D763}']
    Function  Get(Index : Integer) : TVTBeforeHeaderHeightTrackingEvent;
    Procedure Put(Index : Integer; Item : TVTBeforeHeaderHeightTrackingEvent);

    Function  Add(Item : TVTBeforeHeaderHeightTrackingEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTBeforeHeaderHeightTrackingEvent);
    Function  Remove(Item : TVTBeforeHeaderHeightTrackingEvent) : Integer;
    Function  IndexOf(Item : TVTBeforeHeaderHeightTrackingEvent) : Integer;

    Procedure Execute(Sender : TVTHeader; Shift : TShiftState);

    Property Items[Index : Integer] : TVTBeforeHeaderHeightTrackingEvent Read Get Write Put; Default;

  End;

  IVTBeforeItemEraseEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-92B3-9543A027B602}']
    Function  Get(Index : Integer) : TVTBeforeItemEraseEvent;
    Procedure Put(Index : Integer; Item : TVTBeforeItemEraseEvent);

    Function  Add(Item : TVTBeforeItemEraseEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTBeforeItemEraseEvent);
    Function  Remove(Item : TVTBeforeItemEraseEvent) : Integer;
    Function  IndexOf(Item : TVTBeforeItemEraseEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; TargetCanvas : TCanvas; Node : PVirtualNode; ItemRect : TRect; Var ItemColor : TColor; Var EraseAction : TItemEraseAction);

    Property Items[Index : Integer] : TVTBeforeItemEraseEvent Read Get Write Put; Default;

  End;

  IVTBeforeItemPaintEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-B5BD-17C95B9F544A}']
    Function  Get(Index : Integer) : TVTBeforeItemPaintEvent;
    Procedure Put(Index : Integer; Item : TVTBeforeItemPaintEvent);

    Function  Add(Item : TVTBeforeItemPaintEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTBeforeItemPaintEvent);
    Function  Remove(Item : TVTBeforeItemPaintEvent) : Integer;
    Function  IndexOf(Item : TVTBeforeItemPaintEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; TargetCanvas : TCanvas; Node : PVirtualNode; ItemRect : TRect; Var CustomDraw : Boolean);

    Property Items[Index : Integer] : TVTBeforeItemPaintEvent Read Get Write Put; Default;

  End;

  ICanResizeEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-8EEA-7752D5E7E91F}']
    Function  Get(Index : Integer) : TCanResizeEvent;
    Procedure Put(Index : Integer; Item : TCanResizeEvent);

    Function  Add(Item : TCanResizeEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TCanResizeEvent);
    Function  Remove(Item : TCanResizeEvent) : Integer;
    Function  IndexOf(Item : TCanResizeEvent) : Integer;

    Procedure Execute(Sender : TObject; Var NewWidth : Integer; Var NewHeight : Integer; Var Resize : Boolean);

    Property Items[Index : Integer] : TCanResizeEvent Read Get Write Put; Default;

  End;

  IVTCanSplitterResizeColumnEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-84DB-2DB428C39F44}']
    Function  Get(Index : Integer) : TVTCanSplitterResizeColumnEvent;
    Procedure Put(Index : Integer; Item : TVTCanSplitterResizeColumnEvent);

    Function  Add(Item : TVTCanSplitterResizeColumnEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTCanSplitterResizeColumnEvent);
    Function  Remove(Item : TVTCanSplitterResizeColumnEvent) : Integer;
    Function  IndexOf(Item : TVTCanSplitterResizeColumnEvent) : Integer;

    Procedure Execute(Sender : TVTHeader; P : TPoint; Column : TColumnIndex; Var Allowed : Boolean);

    Property Items[Index : Integer] : TVTCanSplitterResizeColumnEvent Read Get Write Put; Default;

  End;

  IVTCanSplitterResizeHeaderEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-A105-B16F7A1283B4}']
    Function  Get(Index : Integer) : TVTCanSplitterResizeHeaderEvent;
    Procedure Put(Index : Integer; Item : TVTCanSplitterResizeHeaderEvent);

    Function  Add(Item : TVTCanSplitterResizeHeaderEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTCanSplitterResizeHeaderEvent);
    Function  Remove(Item : TVTCanSplitterResizeHeaderEvent) : Integer;
    Function  IndexOf(Item : TVTCanSplitterResizeHeaderEvent) : Integer;

    Procedure Execute(Sender : TVTHeader; P : TPoint; Var Allowed : Boolean);

    Property Items[Index : Integer] : TVTCanSplitterResizeHeaderEvent Read Get Write Put; Default;

  End;

  IVTCanSplitterResizeNodeEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-A911-588F3F9DC975}']
    Function  Get(Index : Integer) : TVTCanSplitterResizeNodeEvent;
    Procedure Put(Index : Integer; Item : TVTCanSplitterResizeNodeEvent);

    Function  Add(Item : TVTCanSplitterResizeNodeEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTCanSplitterResizeNodeEvent);
    Function  Remove(Item : TVTCanSplitterResizeNodeEvent) : Integer;
    Function  IndexOf(Item : TVTCanSplitterResizeNodeEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; P : TPoint; Node : PVirtualNode; Column : TColumnIndex; Var Allowed : Boolean);

    Property Items[Index : Integer] : TVTCanSplitterResizeNodeEvent Read Get Write Put; Default;

  End;

  IVTChangeEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-B495-0DE73AC1CB58}']
    Function  Get(Index : Integer) : TVTChangeEvent;
    Procedure Put(Index : Integer; Item : TVTChangeEvent);

    Function  Add(Item : TVTChangeEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTChangeEvent);
    Function  Remove(Item : TVTChangeEvent) : Integer;
    Function  IndexOf(Item : TVTChangeEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode);

    Property Items[Index : Integer] : TVTChangeEvent Read Get Write Put; Default;

  End;

  IVTCheckChangingEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-BBEF-723D73D99A24}']
    Function  Get(Index : Integer) : TVTCheckChangingEvent;
    Procedure Put(Index : Integer; Item : TVTCheckChangingEvent);

    Function  Add(Item : TVTCheckChangingEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTCheckChangingEvent);
    Function  Remove(Item : TVTCheckChangingEvent) : Integer;
    Function  IndexOf(Item : TVTCheckChangingEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Var NewState : TCheckState; Var Allowed : Boolean);

    Property Items[Index : Integer] : TVTCheckChangingEvent Read Get Write Put; Default;

  End;

  IVTChangingEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-B1B0-B95B5014E844}']
    Function  Get(Index : Integer) : TVTChangingEvent;
    Procedure Put(Index : Integer; Item : TVTChangingEvent);

    Function  Add(Item : TVTChangingEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTChangingEvent);
    Function  Remove(Item : TVTChangingEvent) : Integer;
    Function  IndexOf(Item : TVTChangingEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Var Allowed : Boolean);

    Property Items[Index : Integer] : TVTChangingEvent Read Get Write Put; Default;

  End;

  IVTColumnClickEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-871B-71D047D551DA}']
    Function  Get(Index : Integer) : TVTColumnClickEvent;
    Procedure Put(Index : Integer; Item : TVTColumnClickEvent);

    Function  Add(Item : TVTColumnClickEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTColumnClickEvent);
    Function  Remove(Item : TVTColumnClickEvent) : Integer;
    Function  IndexOf(Item : TVTColumnClickEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Column : TColumnIndex; Shift : TShiftState);

    Property Items[Index : Integer] : TVTColumnClickEvent Read Get Write Put; Default;

  End;

  IVTColumnDblClickEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-8172-83BE8E9F3B5F}']
    Function  Get(Index : Integer) : TVTColumnDblClickEvent;
    Procedure Put(Index : Integer; Item : TVTColumnDblClickEvent);

    Function  Add(Item : TVTColumnDblClickEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTColumnDblClickEvent);
    Function  Remove(Item : TVTColumnDblClickEvent) : Integer;
    Function  IndexOf(Item : TVTColumnDblClickEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Column : TColumnIndex; Shift : TShiftState);

    Property Items[Index : Integer] : TVTColumnDblClickEvent Read Get Write Put; Default;

  End;

  IVTHeaderNotifyEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-A1F2-3A43AABE9EC1}']
    Function  Get(Index : Integer) : TVTHeaderNotifyEvent;
    Procedure Put(Index : Integer; Item : TVTHeaderNotifyEvent);

    Function  Add(Item : TVTHeaderNotifyEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTHeaderNotifyEvent);
    Function  Remove(Item : TVTHeaderNotifyEvent) : Integer;
    Function  IndexOf(Item : TVTHeaderNotifyEvent) : Integer;

    Procedure Execute(Sender : TVTHeader; Column : TColumnIndex);

    Property Items[Index : Integer] : TVTHeaderNotifyEvent Read Get Write Put; Default;

  End;

  IColumnChangeEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-BD6D-57B4F7802ECB}']
    Function  Get(Index : Integer) : TColumnChangeEvent;
    Procedure Put(Index : Integer; Item : TColumnChangeEvent);

    Function  Add(Item : TColumnChangeEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TColumnChangeEvent);
    Function  Remove(Item : TColumnChangeEvent) : Integer;
    Function  IndexOf(Item : TColumnChangeEvent) : Integer;

    Procedure Execute(Const Sender : TBaseVirtualTree; Const Column : TColumnIndex; Visible : Boolean);

    Property Items[Index : Integer] : TColumnChangeEvent Read Get Write Put; Default;

  End;

  IVTColumnWidthDblClickResizeEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-BFFE-2227FD900E41}']
    Function  Get(Index : Integer) : TVTColumnWidthDblClickResizeEvent;
    Procedure Put(Index : Integer; Item : TVTColumnWidthDblClickResizeEvent);

    Function  Add(Item : TVTColumnWidthDblClickResizeEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTColumnWidthDblClickResizeEvent);
    Function  Remove(Item : TVTColumnWidthDblClickResizeEvent) : Integer;
    Function  IndexOf(Item : TVTColumnWidthDblClickResizeEvent) : Integer;

    Procedure Execute(Sender : TVTHeader; Column : TColumnIndex; Shift : TShiftState; P : TPoint; Var Allowed : Boolean);

    Property Items[Index : Integer] : TVTColumnWidthDblClickResizeEvent Read Get Write Put; Default;

  End;

  IVTColumnWidthTrackingEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-8322-A45944457C2F}']
    Function  Get(Index : Integer) : TVTColumnWidthTrackingEvent;
    Procedure Put(Index : Integer; Item : TVTColumnWidthTrackingEvent);

    Function  Add(Item : TVTColumnWidthTrackingEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTColumnWidthTrackingEvent);
    Function  Remove(Item : TVTColumnWidthTrackingEvent) : Integer;
    Function  IndexOf(Item : TVTColumnWidthTrackingEvent) : Integer;

    Procedure Execute(Sender : TVTHeader; Column : TColumnIndex; Shift : TShiftState; Var TrackPoint : TPoint; P : TPoint; Var Allowed : Boolean);

    Property Items[Index : Integer] : TVTColumnWidthTrackingEvent Read Get Write Put; Default;

  End;

  IVTCompareEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-B45B-A90A24EF2E8E}']
    Function  Get(Index : Integer) : TVTCompareEvent;
    Procedure Put(Index : Integer; Item : TVTCompareEvent);

    Function  Add(Item : TVTCompareEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTCompareEvent);
    Function  Remove(Item : TVTCompareEvent) : Integer;
    Function  IndexOf(Item : TVTCompareEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Node1 : PVirtualNode; Node2 : PVirtualNode; Column : TColumnIndex; Var Result : Integer);

    Property Items[Index : Integer] : TVTCompareEvent Read Get Write Put; Default;

  End;

  IVTCreateDataObjectEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-8377-0020859AB940}']
    Function  Get(Index : Integer) : TVTCreateDataObjectEvent;
    Procedure Put(Index : Integer; Item : TVTCreateDataObjectEvent);

    Function  Add(Item : TVTCreateDataObjectEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTCreateDataObjectEvent);
    Function  Remove(Item : TVTCreateDataObjectEvent) : Integer;
    Function  IndexOf(Item : TVTCreateDataObjectEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Out IDataObject : IDataObject);

    Property Items[Index : Integer] : TVTCreateDataObjectEvent Read Get Write Put; Default;

  End;

  IVTCreateDragManagerEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-B0B7-6EA618C7EAF7}']
    Function  Get(Index : Integer) : TVTCreateDragManagerEvent;
    Procedure Put(Index : Integer; Item : TVTCreateDragManagerEvent);

    Function  Add(Item : TVTCreateDragManagerEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTCreateDragManagerEvent);
    Function  Remove(Item : TVTCreateDragManagerEvent) : Integer;
    Function  IndexOf(Item : TVTCreateDragManagerEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Out DragManager : IVTDragManager);

    Property Items[Index : Integer] : TVTCreateDragManagerEvent Read Get Write Put; Default;

  End;

  IVTCreateEditorEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-B636-3EA790D359D9}']
    Function  Get(Index : Integer) : TVTCreateEditorEvent;
    Procedure Put(Index : Integer; Item : TVTCreateEditorEvent);

    Function  Add(Item : TVTCreateEditorEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTCreateEditorEvent);
    Function  Remove(Item : TVTCreateEditorEvent) : Integer;
    Function  IndexOf(Item : TVTCreateEditorEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex; Out EditLink : IVTEditLink);

    Property Items[Index : Integer] : TVTCreateEditorEvent Read Get Write Put; Default;

  End;

  IVTDragAllowedEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-9057-0F8959319E37}']
    Function  Get(Index : Integer) : TVTDragAllowedEvent;
    Procedure Put(Index : Integer; Item : TVTDragAllowedEvent);

    Function  Add(Item : TVTDragAllowedEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTDragAllowedEvent);
    Function  Remove(Item : TVTDragAllowedEvent) : Integer;
    Function  IndexOf(Item : TVTDragAllowedEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex; Var Allowed : Boolean);

    Property Items[Index : Integer] : TVTDragAllowedEvent Read Get Write Put; Default;

  End;

  IVTDragDropEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-8F10-D39F77295D0A}']
    Function  Get(Index : Integer) : TVTDragDropEvent;
    Procedure Put(Index : Integer; Item : TVTDragDropEvent);

    Function  Add(Item : TVTDragDropEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTDragDropEvent);
    Function  Remove(Item : TVTDragDropEvent) : Integer;
    Function  IndexOf(Item : TVTDragDropEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Source : TObject; DataObject : IDataObject; Formats : TFormatArray; Shift : TShiftState; Pt : TPoint; Var Effect : Integer; Mode : TDropMode);

    Property Items[Index : Integer] : TVTDragDropEvent Read Get Write Put; Default;

  End;

  IVTDragOverEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-A63D-85BAB8E02F4F}']
    Function  Get(Index : Integer) : TVTDragOverEvent;
    Procedure Put(Index : Integer; Item : TVTDragOverEvent);

    Function  Add(Item : TVTDragOverEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTDragOverEvent);
    Function  Remove(Item : TVTDragOverEvent) : Integer;
    Function  IndexOf(Item : TVTDragOverEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Source : TObject; Shift : TShiftState; State : TDragState; Pt : TPoint; Mode : TDropMode; Var Effect : Integer; Var Accept : Boolean);

    Property Items[Index : Integer] : TVTDragOverEvent Read Get Write Put; Default;

  End;

  IVTDrawHintEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-8DB0-9284715FCD88}']
    Function  Get(Index : Integer) : TVTDrawHintEvent;
    Procedure Put(Index : Integer; Item : TVTDrawHintEvent);

    Function  Add(Item : TVTDrawHintEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTDrawHintEvent);
    Function  Remove(Item : TVTDrawHintEvent) : Integer;
    Function  IndexOf(Item : TVTDrawHintEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; HintCanvas : TCanvas; Node : PVirtualNode; R : TRect; Column : TColumnIndex);

    Property Items[Index : Integer] : TVTDrawHintEvent Read Get Write Put; Default;

  End;

  IVTDrawTextEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-B72B-BD5AC86F1E1D}']
    Function  Get(Index : Integer) : TVTDrawTextEvent;
    Procedure Put(Index : Integer; Item : TVTDrawTextEvent);

    Function  Add(Item : TVTDrawTextEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTDrawTextEvent);
    Function  Remove(Item : TVTDrawTextEvent) : Integer;
    Function  IndexOf(Item : TVTDrawTextEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; TargetCanvas : TCanvas; Node : PVirtualNode; Column : TColumnIndex; Const Text : WideString; Const CellRect : TRect; Var DefaultDraw : Boolean);

    Property Items[Index : Integer] : TVTDrawTextEvent Read Get Write Put; Default;

  End;

  IVTEditCancelEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-A68A-F773C1331F3A}']
    Function  Get(Index : Integer) : TVTEditCancelEvent;
    Procedure Put(Index : Integer; Item : TVTEditCancelEvent);

    Function  Add(Item : TVTEditCancelEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTEditCancelEvent);
    Function  Remove(Item : TVTEditCancelEvent) : Integer;
    Function  IndexOf(Item : TVTEditCancelEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Column : TColumnIndex);

    Property Items[Index : Integer] : TVTEditCancelEvent Read Get Write Put; Default;

  End;

  IVTEditChangeEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-B7D4-DE8163D43959}']
    Function  Get(Index : Integer) : TVTEditChangeEvent;
    Procedure Put(Index : Integer; Item : TVTEditChangeEvent);

    Function  Add(Item : TVTEditChangeEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTEditChangeEvent);
    Function  Remove(Item : TVTEditChangeEvent) : Integer;
    Function  IndexOf(Item : TVTEditChangeEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex);

    Property Items[Index : Integer] : TVTEditChangeEvent Read Get Write Put; Default;

  End;

  IVTEditChangingEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-BF5A-1AA2983431A8}']
    Function  Get(Index : Integer) : TVTEditChangingEvent;
    Procedure Put(Index : Integer; Item : TVTEditChangingEvent);

    Function  Add(Item : TVTEditChangingEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTEditChangingEvent);
    Function  Remove(Item : TVTEditChangingEvent) : Integer;
    Function  IndexOf(Item : TVTEditChangingEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex; Var Allowed : Boolean);

    Property Items[Index : Integer] : TVTEditChangingEvent Read Get Write Put; Default;

  End;

  IVTOperationEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-8875-058CD7B10B56}']
    Function  Get(Index : Integer) : TVTOperationEvent;
    Procedure Put(Index : Integer; Item : TVTOperationEvent);

    Function  Add(Item : TVTOperationEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTOperationEvent);
    Function  Remove(Item : TVTOperationEvent) : Integer;
    Function  IndexOf(Item : TVTOperationEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; OperationKind : TVTOperationKind);

    Property Items[Index : Integer] : TVTOperationEvent Read Get Write Put; Default;

  End;

  IVTFocusChangeEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-BC64-9D5791ADD92E}']
    Function  Get(Index : Integer) : TVTFocusChangeEvent;
    Procedure Put(Index : Integer; Item : TVTFocusChangeEvent);

    Function  Add(Item : TVTFocusChangeEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTFocusChangeEvent);
    Function  Remove(Item : TVTFocusChangeEvent) : Integer;
    Function  IndexOf(Item : TVTFocusChangeEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex);

    Property Items[Index : Integer] : TVTFocusChangeEvent Read Get Write Put; Default;

  End;

  IVTFocusChangingEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-8F07-60E83790D301}']
    Function  Get(Index : Integer) : TVTFocusChangingEvent;
    Procedure Put(Index : Integer; Item : TVTFocusChangingEvent);

    Function  Add(Item : TVTFocusChangingEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTFocusChangingEvent);
    Function  Remove(Item : TVTFocusChangingEvent) : Integer;
    Function  IndexOf(Item : TVTFocusChangingEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; OldNode : PVirtualNode; NewNode : PVirtualNode; OldColumn : TColumnIndex; NewColumn : TColumnIndex; Var Allowed : Boolean);

    Property Items[Index : Integer] : TVTFocusChangingEvent Read Get Write Put; Default;

  End;

  IVTFreeNodeEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-BA84-05CFF42BBA39}']
    Function  Get(Index : Integer) : TVTFreeNodeEvent;
    Procedure Put(Index : Integer; Item : TVTFreeNodeEvent);

    Function  Add(Item : TVTFreeNodeEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTFreeNodeEvent);
    Function  Remove(Item : TVTFreeNodeEvent) : Integer;
    Function  IndexOf(Item : TVTFreeNodeEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode);

    Property Items[Index : Integer] : TVTFreeNodeEvent Read Get Write Put; Default;

  End;

  IVTGetCellIsEmptyEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-8BE5-61DAA8DC3329}']
    Function  Get(Index : Integer) : TVTGetCellIsEmptyEvent;
    Procedure Put(Index : Integer; Item : TVTGetCellIsEmptyEvent);

    Function  Add(Item : TVTGetCellIsEmptyEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTGetCellIsEmptyEvent);
    Function  Remove(Item : TVTGetCellIsEmptyEvent) : Integer;
    Function  IndexOf(Item : TVTGetCellIsEmptyEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex; Var IsEmpty : Boolean);

    Property Items[Index : Integer] : TVTGetCellIsEmptyEvent Read Get Write Put; Default;

  End;

  IVSTGetCellTextEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-890F-EDC82D6324F9}']
    Function  Get(Index : Integer) : TVSTGetCellTextEvent;
    Procedure Put(Index : Integer; Item : TVSTGetCellTextEvent);

    Function  Add(Item : TVSTGetCellTextEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVSTGetCellTextEvent);
    Function  Remove(Item : TVSTGetCellTextEvent) : Integer;
    Function  IndexOf(Item : TVSTGetCellTextEvent) : Integer;

    Procedure Execute(Sender : TCustomVirtualStringTree; Var E : TVSTGetCellTextEventArgs);

    Property Items[Index : Integer] : TVSTGetCellTextEvent Read Get Write Put; Default;

  End;

  IVTGetCursorEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-AA2D-E59C90E621C8}']
    Function  Get(Index : Integer) : TVTGetCursorEvent;
    Procedure Put(Index : Integer; Item : TVTGetCursorEvent);

    Function  Add(Item : TVTGetCursorEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTGetCursorEvent);
    Function  Remove(Item : TVTGetCursorEvent) : Integer;
    Function  IndexOf(Item : TVTGetCursorEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Var Cursor : TCursor);

    Property Items[Index : Integer] : TVTGetCursorEvent Read Get Write Put; Default;

  End;

  IVTGetHeaderCursorEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-B8B2-5611A89179CD}']
    Function  Get(Index : Integer) : TVTGetHeaderCursorEvent;
    Procedure Put(Index : Integer; Item : TVTGetHeaderCursorEvent);

    Function  Add(Item : TVTGetHeaderCursorEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTGetHeaderCursorEvent);
    Function  Remove(Item : TVTGetHeaderCursorEvent) : Integer;
    Function  IndexOf(Item : TVTGetHeaderCursorEvent) : Integer;

    Procedure Execute(Sender : TVTHeader; Var Cursor : HICON);

    Property Items[Index : Integer] : TVTGetHeaderCursorEvent Read Get Write Put; Default;

  End;

  IVTHelpContextEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-BBBE-CE39A6B11EE5}']
    Function  Get(Index : Integer) : TVTHelpContextEvent;
    Procedure Put(Index : Integer; Item : TVTHelpContextEvent);

    Function  Add(Item : TVTHelpContextEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTHelpContextEvent);
    Function  Remove(Item : TVTHelpContextEvent) : Integer;
    Function  IndexOf(Item : TVTHelpContextEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex; Var HelpContext : Integer);

    Property Items[Index : Integer] : TVTHelpContextEvent Read Get Write Put; Default;

  End;

  IVSTGetHintEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-A41D-604E6099FA25}']
    Function  Get(Index : Integer) : TVSTGetHintEvent;
    Procedure Put(Index : Integer; Item : TVSTGetHintEvent);

    Function  Add(Item : TVSTGetHintEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVSTGetHintEvent);
    Function  Remove(Item : TVSTGetHintEvent) : Integer;
    Function  IndexOf(Item : TVSTGetHintEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex; Var LineBreakStyle : TVTTooltipLineBreakStyle; Var HintText : WideString);

    Property Items[Index : Integer] : TVSTGetHintEvent Read Get Write Put; Default;

  End;

  IVTHintKindEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-BF33-7FFBAA9C0C91}']
    Function  Get(Index : Integer) : TVTHintKindEvent;
    Procedure Put(Index : Integer; Item : TVTHintKindEvent);

    Function  Add(Item : TVTHintKindEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTHintKindEvent);
    Function  Remove(Item : TVTHintKindEvent) : Integer;
    Function  IndexOf(Item : TVTHintKindEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex; Var Kind : TVTHintKind);

    Property Items[Index : Integer] : TVTHintKindEvent Read Get Write Put; Default;

  End;

  IVTGetHintSizeEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-84B9-9443AA9924FD}']
    Function  Get(Index : Integer) : TVTGetHintSizeEvent;
    Procedure Put(Index : Integer; Item : TVTGetHintSizeEvent);

    Function  Add(Item : TVTGetHintSizeEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTGetHintSizeEvent);
    Function  Remove(Item : TVTGetHintSizeEvent) : Integer;
    Function  IndexOf(Item : TVTGetHintSizeEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex; Var R : TRect);

    Property Items[Index : Integer] : TVTGetHintSizeEvent Read Get Write Put; Default;

  End;

  IVTGetImageEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-9B06-3F8CDB981054}']
    Function  Get(Index : Integer) : TVTGetImageEvent;
    Procedure Put(Index : Integer; Item : TVTGetImageEvent);

    Function  Add(Item : TVTGetImageEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTGetImageEvent);
    Function  Remove(Item : TVTGetImageEvent) : Integer;
    Function  IndexOf(Item : TVTGetImageEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Kind : TVTImageKind; Column : TColumnIndex; Var Ghosted : Boolean; Var ImageIndex : TImageIndex);

    Property Items[Index : Integer] : TVTGetImageEvent Read Get Write Put; Default;

  End;

  IVTGetImageExEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-93E3-F51A7BBBFAC8}']
    Function  Get(Index : Integer) : TVTGetImageExEvent;
    Procedure Put(Index : Integer; Item : TVTGetImageExEvent);

    Function  Add(Item : TVTGetImageExEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTGetImageExEvent);
    Function  Remove(Item : TVTGetImageExEvent) : Integer;
    Function  IndexOf(Item : TVTGetImageExEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Kind : TVTImageKind; Column : TColumnIndex; Var Ghosted : Boolean; Var ImageIndex : TImageIndex; Var ImageList : TCustomImageList);

    Property Items[Index : Integer] : TVTGetImageExEvent Read Get Write Put; Default;

  End;

  IVTGetImageTextEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-9780-2081B54D9CE9}']
    Function  Get(Index : Integer) : TVTGetImageTextEvent;
    Procedure Put(Index : Integer; Item : TVTGetImageTextEvent);

    Function  Add(Item : TVTGetImageTextEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTGetImageTextEvent);
    Function  Remove(Item : TVTGetImageTextEvent) : Integer;
    Function  IndexOf(Item : TVTGetImageTextEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Kind : TVTImageKind; Column : TColumnIndex; Var ImageText : WideString);

    Property Items[Index : Integer] : TVTGetImageTextEvent Read Get Write Put; Default;

  End;

  IVTGetLineStyleEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-B3F6-89995AFEA008}']
    Function  Get(Index : Integer) : TVTGetLineStyleEvent;
    Procedure Put(Index : Integer; Item : TVTGetLineStyleEvent);

    Function  Add(Item : TVTGetLineStyleEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTGetLineStyleEvent);
    Function  Remove(Item : TVTGetLineStyleEvent) : Integer;
    Function  IndexOf(Item : TVTGetLineStyleEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Var Bits : Pointer);

    Property Items[Index : Integer] : TVTGetLineStyleEvent Read Get Write Put; Default;

  End;

  IVTGetNodeDataSizeEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-B995-FCF3688A52FF}']
    Function  Get(Index : Integer) : TVTGetNodeDataSizeEvent;
    Procedure Put(Index : Integer; Item : TVTGetNodeDataSizeEvent);

    Function  Add(Item : TVTGetNodeDataSizeEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTGetNodeDataSizeEvent);
    Function  Remove(Item : TVTGetNodeDataSizeEvent) : Integer;
    Function  IndexOf(Item : TVTGetNodeDataSizeEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Var NodeDataSize : Integer);

    Property Items[Index : Integer] : TVTGetNodeDataSizeEvent Read Get Write Put; Default;

  End;

  IVTPopupEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-BB4C-AA815AE187AA}']
    Function  Get(Index : Integer) : TVTPopupEvent;
    Procedure Put(Index : Integer; Item : TVTPopupEvent);

    Function  Add(Item : TVTPopupEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTPopupEvent);
    Function  Remove(Item : TVTPopupEvent) : Integer;
    Function  IndexOf(Item : TVTPopupEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex; Const P : TPoint; Var AskParent : Boolean; Var PopupMenu : TPopupMenu);

    Property Items[Index : Integer] : TVTPopupEvent Read Get Write Put; Default;

  End;

  IVSTGetTextEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-9A3A-E817270738C2}']
    Function  Get(Index : Integer) : TVSTGetTextEvent;
    Procedure Put(Index : Integer; Item : TVSTGetTextEvent);

    Function  Add(Item : TVSTGetTextEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVSTGetTextEvent);
    Function  Remove(Item : TVSTGetTextEvent) : Integer;
    Function  IndexOf(Item : TVSTGetTextEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex; TextType : TVSTTextType; Var CellText : WideString);

    Property Items[Index : Integer] : TVSTGetTextEvent Read Get Write Put; Default;

  End;

  IVTGetUserClipboardFormatsEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-B6AF-8D502FF668DA}']
    Function  Get(Index : Integer) : TVTGetUserClipboardFormatsEvent;
    Procedure Put(Index : Integer; Item : TVTGetUserClipboardFormatsEvent);

    Function  Add(Item : TVTGetUserClipboardFormatsEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTGetUserClipboardFormatsEvent);
    Function  Remove(Item : TVTGetUserClipboardFormatsEvent) : Integer;
    Function  IndexOf(Item : TVTGetUserClipboardFormatsEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Var Formats : TFormatEtcArray);

    Property Items[Index : Integer] : TVTGetUserClipboardFormatsEvent Read Get Write Put; Default;

  End;

  IVTHeaderClickEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-B4BB-340697C43CC5}']
    Function  Get(Index : Integer) : TVTHeaderClickEvent;
    Procedure Put(Index : Integer; Item : TVTHeaderClickEvent);

    Function  Add(Item : TVTHeaderClickEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTHeaderClickEvent);
    Function  Remove(Item : TVTHeaderClickEvent) : Integer;
    Function  IndexOf(Item : TVTHeaderClickEvent) : Integer;

    Procedure Execute(Sender : TVTHeader; HitInfo : TVTHeaderHitInfo);

    Property Items[Index : Integer] : TVTHeaderClickEvent Read Get Write Put; Default;

  End;

  IVTHeaderDraggedEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-8B76-9771C8DE63C6}']
    Function  Get(Index : Integer) : TVTHeaderDraggedEvent;
    Procedure Put(Index : Integer; Item : TVTHeaderDraggedEvent);

    Function  Add(Item : TVTHeaderDraggedEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTHeaderDraggedEvent);
    Function  Remove(Item : TVTHeaderDraggedEvent) : Integer;
    Function  IndexOf(Item : TVTHeaderDraggedEvent) : Integer;

    Procedure Execute(Sender : TVTHeader; Column : TColumnIndex; OldPosition : Integer);

    Property Items[Index : Integer] : TVTHeaderDraggedEvent Read Get Write Put; Default;

  End;

  IVTHeaderDraggedOutEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-8945-BA8B3403840C}']
    Function  Get(Index : Integer) : TVTHeaderDraggedOutEvent;
    Procedure Put(Index : Integer; Item : TVTHeaderDraggedOutEvent);

    Function  Add(Item : TVTHeaderDraggedOutEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTHeaderDraggedOutEvent);
    Function  Remove(Item : TVTHeaderDraggedOutEvent) : Integer;
    Function  IndexOf(Item : TVTHeaderDraggedOutEvent) : Integer;

    Procedure Execute(Sender : TVTHeader; Column : TColumnIndex; DropPosition : TPoint);

    Property Items[Index : Integer] : TVTHeaderDraggedOutEvent Read Get Write Put; Default;

  End;

  IVTHeaderDraggingEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-8BEF-95CB41540463}']
    Function  Get(Index : Integer) : TVTHeaderDraggingEvent;
    Procedure Put(Index : Integer; Item : TVTHeaderDraggingEvent);

    Function  Add(Item : TVTHeaderDraggingEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTHeaderDraggingEvent);
    Function  Remove(Item : TVTHeaderDraggingEvent) : Integer;
    Function  IndexOf(Item : TVTHeaderDraggingEvent) : Integer;

    Procedure Execute(Sender : TVTHeader; Column : TColumnIndex; Var Allowed : Boolean);

    Property Items[Index : Integer] : TVTHeaderDraggingEvent Read Get Write Put; Default;

  End;

  IVTHeaderPaintEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-8017-9A30017FF7F2}']
    Function  Get(Index : Integer) : TVTHeaderPaintEvent;
    Procedure Put(Index : Integer; Item : TVTHeaderPaintEvent);

    Function  Add(Item : TVTHeaderPaintEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTHeaderPaintEvent);
    Function  Remove(Item : TVTHeaderPaintEvent) : Integer;
    Function  IndexOf(Item : TVTHeaderPaintEvent) : Integer;

    Procedure Execute(Sender : TVTHeader; HeaderCanvas : TCanvas; Column : TVirtualTreeColumn; R : TRect; Hover : Boolean; Pressed : Boolean; DropMark : TVTDropMarkMode);

    Property Items[Index : Integer] : TVTHeaderPaintEvent Read Get Write Put; Default;

  End;

  IVTHeaderPaintQueryElementsEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-BA16-BE6D361DC5CD}']
    Function  Get(Index : Integer) : TVTHeaderPaintQueryElementsEvent;
    Procedure Put(Index : Integer; Item : TVTHeaderPaintQueryElementsEvent);

    Function  Add(Item : TVTHeaderPaintQueryElementsEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTHeaderPaintQueryElementsEvent);
    Function  Remove(Item : TVTHeaderPaintQueryElementsEvent) : Integer;
    Function  IndexOf(Item : TVTHeaderPaintQueryElementsEvent) : Integer;

    Procedure Execute(Sender : TVTHeader; Var PaintInfo : THeaderPaintInfo; Var Elements : THeaderPaintElements);

    Property Items[Index : Integer] : TVTHeaderPaintQueryElementsEvent Read Get Write Put; Default;

  End;

  IVTHeaderHeightDblClickResizeEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-8D48-61977A5447E7}']
    Function  Get(Index : Integer) : TVTHeaderHeightDblClickResizeEvent;
    Procedure Put(Index : Integer; Item : TVTHeaderHeightDblClickResizeEvent);

    Function  Add(Item : TVTHeaderHeightDblClickResizeEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTHeaderHeightDblClickResizeEvent);
    Function  Remove(Item : TVTHeaderHeightDblClickResizeEvent) : Integer;
    Function  IndexOf(Item : TVTHeaderHeightDblClickResizeEvent) : Integer;

    Procedure Execute(Sender : TVTHeader; Var P : TPoint; Shift : TShiftState; Var Allowed : Boolean);

    Property Items[Index : Integer] : TVTHeaderHeightDblClickResizeEvent Read Get Write Put; Default;

  End;

  IVTHeaderHeightTrackingEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-B5AD-6F9BB9796BD2}']
    Function  Get(Index : Integer) : TVTHeaderHeightTrackingEvent;
    Procedure Put(Index : Integer; Item : TVTHeaderHeightTrackingEvent);

    Function  Add(Item : TVTHeaderHeightTrackingEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTHeaderHeightTrackingEvent);
    Function  Remove(Item : TVTHeaderHeightTrackingEvent) : Integer;
    Function  IndexOf(Item : TVTHeaderHeightTrackingEvent) : Integer;

    Procedure Execute(Sender : TVTHeader; Var P : TPoint; Shift : TShiftState; Var Allowed : Boolean);

    Property Items[Index : Integer] : TVTHeaderHeightTrackingEvent Read Get Write Put; Default;

  End;

  IVTHeaderMouseEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-8DAE-B9788C6EE9AA}']
    Function  Get(Index : Integer) : TVTHeaderMouseEvent;
    Procedure Put(Index : Integer; Item : TVTHeaderMouseEvent);

    Function  Add(Item : TVTHeaderMouseEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTHeaderMouseEvent);
    Function  Remove(Item : TVTHeaderMouseEvent) : Integer;
    Function  IndexOf(Item : TVTHeaderMouseEvent) : Integer;

    Procedure Execute(Sender : TVTHeader; Button : TMouseButton; Shift : TShiftState; X : Integer; Y : Integer);

    Property Items[Index : Integer] : TVTHeaderMouseEvent Read Get Write Put; Default;

  End;

  IVTHeaderMouseMoveEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-9A22-EA2B9605F7F8}']
    Function  Get(Index : Integer) : TVTHeaderMouseMoveEvent;
    Procedure Put(Index : Integer; Item : TVTHeaderMouseMoveEvent);

    Function  Add(Item : TVTHeaderMouseMoveEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTHeaderMouseMoveEvent);
    Function  Remove(Item : TVTHeaderMouseMoveEvent) : Integer;
    Function  IndexOf(Item : TVTHeaderMouseMoveEvent) : Integer;

    Procedure Execute(Sender : TVTHeader; Shift : TShiftState; X : Integer; Y : Integer);

    Property Items[Index : Integer] : TVTHeaderMouseMoveEvent Read Get Write Put; Default;

  End;

  IVTHotNodeChangeEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-BFDA-9AF2F39DF808}']
    Function  Get(Index : Integer) : TVTHotNodeChangeEvent;
    Procedure Put(Index : Integer; Item : TVTHotNodeChangeEvent);

    Function  Add(Item : TVTHotNodeChangeEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTHotNodeChangeEvent);
    Function  Remove(Item : TVTHotNodeChangeEvent) : Integer;
    Function  IndexOf(Item : TVTHotNodeChangeEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; OldNode : PVirtualNode; NewNode : PVirtualNode);

    Property Items[Index : Integer] : TVTHotNodeChangeEvent Read Get Write Put; Default;

  End;

  IVTIncrementalSearchEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-A0CC-AC4D0A19F299}']
    Function  Get(Index : Integer) : TVTIncrementalSearchEvent;
    Procedure Put(Index : Integer; Item : TVTIncrementalSearchEvent);

    Function  Add(Item : TVTIncrementalSearchEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTIncrementalSearchEvent);
    Function  Remove(Item : TVTIncrementalSearchEvent) : Integer;
    Function  IndexOf(Item : TVTIncrementalSearchEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Const SearchText : WideString; Var Result : Integer);

    Property Items[Index : Integer] : TVTIncrementalSearchEvent Read Get Write Put; Default;

  End;

  IVTInitChildrenEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-B610-C5A89365D9F4}']
    Function  Get(Index : Integer) : TVTInitChildrenEvent;
    Procedure Put(Index : Integer; Item : TVTInitChildrenEvent);

    Function  Add(Item : TVTInitChildrenEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTInitChildrenEvent);
    Function  Remove(Item : TVTInitChildrenEvent) : Integer;
    Function  IndexOf(Item : TVTInitChildrenEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Var ChildCount : Cardinal);

    Property Items[Index : Integer] : TVTInitChildrenEvent Read Get Write Put; Default;

  End;

  IVTInitNodeEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-9BFB-6FC87016133C}']
    Function  Get(Index : Integer) : TVTInitNodeEvent;
    Procedure Put(Index : Integer; Item : TVTInitNodeEvent);

    Function  Add(Item : TVTInitNodeEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTInitNodeEvent);
    Function  Remove(Item : TVTInitNodeEvent) : Integer;
    Function  IndexOf(Item : TVTInitNodeEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; ParentNode : PVirtualNode; Node : PVirtualNode; Var InitialStates : TVirtualNodeInitStates);

    Property Items[Index : Integer] : TVTInitNodeEvent Read Get Write Put; Default;

  End;

  IVTKeyActionEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-8370-A15F472ADA2D}']
    Function  Get(Index : Integer) : TVTKeyActionEvent;
    Procedure Put(Index : Integer; Item : TVTKeyActionEvent);

    Function  Add(Item : TVTKeyActionEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTKeyActionEvent);
    Function  Remove(Item : TVTKeyActionEvent) : Integer;
    Function  IndexOf(Item : TVTKeyActionEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Var CharCode : Word; Var Shift : TShiftState; Var DoDefault : Boolean);

    Property Items[Index : Integer] : TVTKeyActionEvent Read Get Write Put; Default;

  End;

  IVTSaveNodeEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-9C01-0A17E3F469F8}']
    Function  Get(Index : Integer) : TVTSaveNodeEvent;
    Procedure Put(Index : Integer; Item : TVTSaveNodeEvent);

    Function  Add(Item : TVTSaveNodeEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTSaveNodeEvent);
    Function  Remove(Item : TVTSaveNodeEvent) : Integer;
    Function  IndexOf(Item : TVTSaveNodeEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Stream : TStream);

    Property Items[Index : Integer] : TVTSaveNodeEvent Read Get Write Put; Default;

  End;

  IVTSaveTreeEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-8E1B-97978F3FDD75}']
    Function  Get(Index : Integer) : TVTSaveTreeEvent;
    Procedure Put(Index : Integer; Item : TVTSaveTreeEvent);

    Function  Add(Item : TVTSaveTreeEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTSaveTreeEvent);
    Function  Remove(Item : TVTSaveTreeEvent) : Integer;
    Function  IndexOf(Item : TVTSaveTreeEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Stream : TStream);

    Property Items[Index : Integer] : TVTSaveTreeEvent Read Get Write Put; Default;

  End;

  IVTMeasureItemEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-B4EC-A5D1AE15E954}']
    Function  Get(Index : Integer) : TVTMeasureItemEvent;
    Procedure Put(Index : Integer; Item : TVTMeasureItemEvent);

    Function  Add(Item : TVTMeasureItemEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTMeasureItemEvent);
    Function  Remove(Item : TVTMeasureItemEvent) : Integer;
    Function  IndexOf(Item : TVTMeasureItemEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; TargetCanvas : TCanvas; Node : PVirtualNode; Var NodeHeight : Integer);

    Property Items[Index : Integer] : TVTMeasureItemEvent Read Get Write Put; Default;

  End;

  IVTMeasureTextEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-AEAD-76C1903E9669}']
    Function  Get(Index : Integer) : TVTMeasureTextEvent;
    Procedure Put(Index : Integer; Item : TVTMeasureTextEvent);

    Function  Add(Item : TVTMeasureTextEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTMeasureTextEvent);
    Function  Remove(Item : TVTMeasureTextEvent) : Integer;
    Function  IndexOf(Item : TVTMeasureTextEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; TargetCanvas : TCanvas; Node : PVirtualNode; Column : TColumnIndex; Const Text : WideString; Var Extent : Integer);

    Property Items[Index : Integer] : TVTMeasureTextEvent Read Get Write Put; Default;

  End;

  IMouseWheelEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-9161-F2AD78E86E78}']
    Function  Get(Index : Integer) : TMouseWheelEvent;
    Procedure Put(Index : Integer; Item : TMouseWheelEvent);

    Function  Add(Item : TMouseWheelEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TMouseWheelEvent);
    Function  Remove(Item : TMouseWheelEvent) : Integer;
    Function  IndexOf(Item : TMouseWheelEvent) : Integer;

    Procedure Execute(Sender : TObject; Shift : TShiftState; WheelDelta : Integer; MousePos : TPoint; Var Handled : Boolean);

    Property Items[Index : Integer] : TMouseWheelEvent Read Get Write Put; Default;

  End;

  IVSTNewTextEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-AB9B-4E10200CB225}']
    Function  Get(Index : Integer) : TVSTNewTextEvent;
    Procedure Put(Index : Integer; Item : TVSTNewTextEvent);

    Function  Add(Item : TVSTNewTextEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVSTNewTextEvent);
    Function  Remove(Item : TVSTNewTextEvent) : Integer;
    Function  IndexOf(Item : TVSTNewTextEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex; NewText : WideString);

    Property Items[Index : Integer] : TVSTNewTextEvent Read Get Write Put; Default;

  End;

  IVTNodeClickEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-8D00-1D6B684513D6}']
    Function  Get(Index : Integer) : TVTNodeClickEvent;
    Procedure Put(Index : Integer; Item : TVTNodeClickEvent);

    Function  Add(Item : TVTNodeClickEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTNodeClickEvent);
    Function  Remove(Item : TVTNodeClickEvent) : Integer;
    Function  IndexOf(Item : TVTNodeClickEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Const HitInfo : THitInfo);

    Property Items[Index : Integer] : TVTNodeClickEvent Read Get Write Put; Default;

  End;

  IVTNodeCopiedEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-A045-93F6375ED3F1}']
    Function  Get(Index : Integer) : TVTNodeCopiedEvent;
    Procedure Put(Index : Integer; Item : TVTNodeCopiedEvent);

    Function  Add(Item : TVTNodeCopiedEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTNodeCopiedEvent);
    Function  Remove(Item : TVTNodeCopiedEvent) : Integer;
    Function  IndexOf(Item : TVTNodeCopiedEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode);

    Property Items[Index : Integer] : TVTNodeCopiedEvent Read Get Write Put; Default;

  End;

  IVTNodeCopyingEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-9577-AE54B3F4C0A5}']
    Function  Get(Index : Integer) : TVTNodeCopyingEvent;
    Procedure Put(Index : Integer; Item : TVTNodeCopyingEvent);

    Function  Add(Item : TVTNodeCopyingEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTNodeCopyingEvent);
    Function  Remove(Item : TVTNodeCopyingEvent) : Integer;
    Function  IndexOf(Item : TVTNodeCopyingEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Target : PVirtualNode; Var Allowed : Boolean);

    Property Items[Index : Integer] : TVTNodeCopyingEvent Read Get Write Put; Default;

  End;

  IVTNodeHeightDblClickResizeEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-902D-04C465CF7890}']
    Function  Get(Index : Integer) : TVTNodeHeightDblClickResizeEvent;
    Procedure Put(Index : Integer; Item : TVTNodeHeightDblClickResizeEvent);

    Function  Add(Item : TVTNodeHeightDblClickResizeEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTNodeHeightDblClickResizeEvent);
    Function  Remove(Item : TVTNodeHeightDblClickResizeEvent) : Integer;
    Function  IndexOf(Item : TVTNodeHeightDblClickResizeEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex; Shift : TShiftState; P : TPoint; Var Allowed : Boolean);

    Property Items[Index : Integer] : TVTNodeHeightDblClickResizeEvent Read Get Write Put; Default;

  End;

  IVTNodeHeightTrackingEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-A13D-FD08F653EE46}']
    Function  Get(Index : Integer) : TVTNodeHeightTrackingEvent;
    Procedure Put(Index : Integer; Item : TVTNodeHeightTrackingEvent);

    Function  Add(Item : TVTNodeHeightTrackingEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTNodeHeightTrackingEvent);
    Function  Remove(Item : TVTNodeHeightTrackingEvent) : Integer;
    Function  IndexOf(Item : TVTNodeHeightTrackingEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex; Shift : TShiftState; Var TrackPoint : TPoint; P : TPoint; Var Allowed : Boolean);

    Property Items[Index : Integer] : TVTNodeHeightTrackingEvent Read Get Write Put; Default;

  End;

  IVTNodeMovedEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-B6A8-AB84FDD7F72A}']
    Function  Get(Index : Integer) : TVTNodeMovedEvent;
    Procedure Put(Index : Integer; Item : TVTNodeMovedEvent);

    Function  Add(Item : TVTNodeMovedEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTNodeMovedEvent);
    Function  Remove(Item : TVTNodeMovedEvent) : Integer;
    Function  IndexOf(Item : TVTNodeMovedEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode);

    Property Items[Index : Integer] : TVTNodeMovedEvent Read Get Write Put; Default;

  End;

  IVTNodeMovingEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-9FF1-1D7CCCE2874B}']
    Function  Get(Index : Integer) : TVTNodeMovingEvent;
    Procedure Put(Index : Integer; Item : TVTNodeMovingEvent);

    Function  Add(Item : TVTNodeMovingEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTNodeMovingEvent);
    Function  Remove(Item : TVTNodeMovingEvent) : Integer;
    Function  IndexOf(Item : TVTNodeMovingEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Target : PVirtualNode; Var Allowed : Boolean);

    Property Items[Index : Integer] : TVTNodeMovingEvent Read Get Write Put; Default;

  End;

  IVTBackgroundPaintEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-8550-115C60E9D29B}']
    Function  Get(Index : Integer) : TVTBackgroundPaintEvent;
    Procedure Put(Index : Integer; Item : TVTBackgroundPaintEvent);

    Function  Add(Item : TVTBackgroundPaintEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTBackgroundPaintEvent);
    Function  Remove(Item : TVTBackgroundPaintEvent) : Integer;
    Function  IndexOf(Item : TVTBackgroundPaintEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; TargetCanvas : TCanvas; R : TRect; Var Handled : Boolean);

    Property Items[Index : Integer] : TVTBackgroundPaintEvent Read Get Write Put; Default;

  End;

  IVTPaintTextListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-9282-F7666255C4D1}']
    Function  Get(Index : Integer) : TVTPaintText;
    Procedure Put(Index : Integer; Item : TVTPaintText);

    Function  Add(Item : TVTPaintText) : Integer;
    Procedure Insert(Index : Integer; Item : TVTPaintText);
    Function  Remove(Item : TVTPaintText) : Integer;
    Function  IndexOf(Item : TVTPaintText) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Const TargetCanvas : TCanvas; Node : PVirtualNode; Column : TColumnIndex; TextType : TVSTTextType);

    Property Items[Index : Integer] : TVTPaintText Read Get Write Put; Default;

  End;

  IVTPrepareButtonImagesEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-AC96-B004D4456ADC}']
    Function  Get(Index : Integer) : TVTPrepareButtonImagesEvent;
    Procedure Put(Index : Integer; Item : TVTPrepareButtonImagesEvent);

    Function  Add(Item : TVTPrepareButtonImagesEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTPrepareButtonImagesEvent);
    Function  Remove(Item : TVTPrepareButtonImagesEvent) : Integer;
    Function  IndexOf(Item : TVTPrepareButtonImagesEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Const APlusBM : TBitmap; Const APlusHotBM : TBitmap; Const APlusSelectedHotBM : TBitmap; Const AMinusBM : TBitmap; Const AMinusHotBM : TBitmap; Const AMinusSelectedHotBM : TBitmap; Var ASize : TSize);

    Property Items[Index : Integer] : TVTPrepareButtonImagesEvent Read Get Write Put; Default;

  End;

  IVTRemoveFromSelectionEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-A47B-FD10BB7A00AD}']
    Function  Get(Index : Integer) : TVTRemoveFromSelectionEvent;
    Procedure Put(Index : Integer; Item : TVTRemoveFromSelectionEvent);

    Function  Add(Item : TVTRemoveFromSelectionEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTRemoveFromSelectionEvent);
    Function  Remove(Item : TVTRemoveFromSelectionEvent) : Integer;
    Function  IndexOf(Item : TVTRemoveFromSelectionEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode);

    Property Items[Index : Integer] : TVTRemoveFromSelectionEvent Read Get Write Put; Default;

  End;

  IVTRenderOLEDataEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-B8B6-8958738CD122}']
    Function  Get(Index : Integer) : TVTRenderOLEDataEvent;
    Procedure Put(Index : Integer; Item : TVTRenderOLEDataEvent);

    Function  Add(Item : TVTRenderOLEDataEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTRenderOLEDataEvent);
    Function  Remove(Item : TVTRenderOLEDataEvent) : Integer;
    Function  IndexOf(Item : TVTRenderOLEDataEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Const FormatEtcIn : tagFORMATETC; Out Medium : tagSTGMEDIUM; ForClipboard : Boolean; Var Result : HRESULT);

    Property Items[Index : Integer] : TVTRenderOLEDataEvent Read Get Write Put; Default;

  End;

  IVTScrollEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-8324-A004827310EE}']
    Function  Get(Index : Integer) : TVTScrollEvent;
    Procedure Put(Index : Integer; Item : TVTScrollEvent);

    Function  Add(Item : TVTScrollEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTScrollEvent);
    Function  Remove(Item : TVTScrollEvent) : Integer;
    Function  IndexOf(Item : TVTScrollEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; DeltaX : Integer; DeltaY : Integer);

    Property Items[Index : Integer] : TVTScrollEvent Read Get Write Put; Default;

  End;

  IVSTShortenStringEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-BCCD-5900D04CB808}']
    Function  Get(Index : Integer) : TVSTShortenStringEvent;
    Procedure Put(Index : Integer; Item : TVSTShortenStringEvent);

    Function  Add(Item : TVSTShortenStringEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVSTShortenStringEvent);
    Function  Remove(Item : TVSTShortenStringEvent) : Integer;
    Function  IndexOf(Item : TVSTShortenStringEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; TargetCanvas : TCanvas; Node : PVirtualNode; Column : TColumnIndex; Const S : WideString; TextSpace : Integer; Var Result : WideString; Var Done : Boolean);

    Property Items[Index : Integer] : TVSTShortenStringEvent Read Get Write Put; Default;

  End;

  IVTScrollBarShowEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-9DC9-E53B2BA80EDE}']
    Function  Get(Index : Integer) : TVTScrollBarShowEvent;
    Procedure Put(Index : Integer; Item : TVTScrollBarShowEvent);

    Function  Add(Item : TVTScrollBarShowEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTScrollBarShowEvent);
    Function  Remove(Item : TVTScrollBarShowEvent) : Integer;
    Function  IndexOf(Item : TVTScrollBarShowEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Bar : Integer; Show : Boolean);

    Property Items[Index : Integer] : TVTScrollBarShowEvent Read Get Write Put; Default;

  End;

  IVTStateChangeEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-ACE9-0000E7597D7D}']
    Function  Get(Index : Integer) : TVTStateChangeEvent;
    Procedure Put(Index : Integer; Item : TVTStateChangeEvent);

    Function  Add(Item : TVTStateChangeEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTStateChangeEvent);
    Function  Remove(Item : TVTStateChangeEvent) : Integer;
    Function  IndexOf(Item : TVTStateChangeEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Enter : TVirtualTreeStates; Leave : TVirtualTreeStates);

    Property Items[Index : Integer] : TVTStateChangeEvent Read Get Write Put; Default;

  End;

  IVTStructureChangeEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-B9EC-F8C69376CA4A}']
    Function  Get(Index : Integer) : TVTStructureChangeEvent;
    Procedure Put(Index : Integer; Item : TVTStructureChangeEvent);

    Function  Add(Item : TVTStructureChangeEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTStructureChangeEvent);
    Function  Remove(Item : TVTStructureChangeEvent) : Integer;
    Function  IndexOf(Item : TVTStructureChangeEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Reason : TChangeReason);

    Property Items[Index : Integer] : TVTStructureChangeEvent Read Get Write Put; Default;

  End;

  IVTUpdatingEventListEx = Interface(IMethodListEx)
    ['{4B61686E-29A0-2112-AA41-25CAAF05F9C8}']
    Function  Get(Index : Integer) : TVTUpdatingEvent;
    Procedure Put(Index : Integer; Item : TVTUpdatingEvent);

    Function  Add(Item : TVTUpdatingEvent) : Integer;
    Procedure Insert(Index : Integer; Item : TVTUpdatingEvent);
    Function  Remove(Item : TVTUpdatingEvent) : Integer;
    Function  IndexOf(Item : TVTUpdatingEvent) : Integer;

    Procedure Execute(Sender : TBaseVirtualTree; State : TVTUpdateState);

    Property Items[Index : Integer] : TVTUpdatingEvent Read Get Write Put; Default;

  End;

  TVTAddToSelectionEventListEx = Class(TMethodListEx, IVTAddToSelectionEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTAddToSelectionEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTAddToSelectionEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTAddToSelectionEvent Read Get Write Put; Default;

    Function  Add(Item : TVTAddToSelectionEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTAddToSelectionEvent); OverLoad;
    Function  Remove(Item : TVTAddToSelectionEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTAddToSelectionEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode);

  End;

  TVTAdvancedHeaderPaintEventListEx = Class(TMethodListEx, IVTAdvancedHeaderPaintEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTAdvancedHeaderPaintEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTAdvancedHeaderPaintEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTAdvancedHeaderPaintEvent Read Get Write Put; Default;

    Function  Add(Item : TVTAdvancedHeaderPaintEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTAdvancedHeaderPaintEvent); OverLoad;
    Function  Remove(Item : TVTAdvancedHeaderPaintEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTAdvancedHeaderPaintEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TVTHeader; Var PaintInfo : THeaderPaintInfo; Const Elements : THeaderPaintElements);

  End;

  TVTAfterAutoFitColumnEventListEx = Class(TMethodListEx, IVTAfterAutoFitColumnEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTAfterAutoFitColumnEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTAfterAutoFitColumnEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTAfterAutoFitColumnEvent Read Get Write Put; Default;

    Function  Add(Item : TVTAfterAutoFitColumnEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTAfterAutoFitColumnEvent); OverLoad;
    Function  Remove(Item : TVTAfterAutoFitColumnEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTAfterAutoFitColumnEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TVTHeader; Column : TColumnIndex);

  End;

  TVTAfterAutoFitColumnsEventListEx = Class(TMethodListEx, IVTAfterAutoFitColumnsEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTAfterAutoFitColumnsEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTAfterAutoFitColumnsEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTAfterAutoFitColumnsEvent Read Get Write Put; Default;

    Function  Add(Item : TVTAfterAutoFitColumnsEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTAfterAutoFitColumnsEvent); OverLoad;
    Function  Remove(Item : TVTAfterAutoFitColumnsEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTAfterAutoFitColumnsEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TVTHeader);

  End;

  TVTAfterCellPaintEventListEx = Class(TMethodListEx, IVTAfterCellPaintEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTAfterCellPaintEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTAfterCellPaintEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTAfterCellPaintEvent Read Get Write Put; Default;

    Function  Add(Item : TVTAfterCellPaintEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTAfterCellPaintEvent); OverLoad;
    Function  Remove(Item : TVTAfterCellPaintEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTAfterCellPaintEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; TargetCanvas : TCanvas; Node : PVirtualNode; Column : TColumnIndex; CellRect : TRect);

  End;

  TVTColumnExportEventListEx = Class(TMethodListEx, IVTColumnExportEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTColumnExportEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTColumnExportEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTColumnExportEvent Read Get Write Put; Default;

    Function  Add(Item : TVTColumnExportEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTColumnExportEvent); OverLoad;
    Function  Remove(Item : TVTColumnExportEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTColumnExportEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; aExportType : TVTExportType; Column : TVirtualTreeColumn);

  End;

  TVTAfterColumnWidthTrackingEventListEx = Class(TMethodListEx, IVTAfterColumnWidthTrackingEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTAfterColumnWidthTrackingEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTAfterColumnWidthTrackingEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTAfterColumnWidthTrackingEvent Read Get Write Put; Default;

    Function  Add(Item : TVTAfterColumnWidthTrackingEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTAfterColumnWidthTrackingEvent); OverLoad;
    Function  Remove(Item : TVTAfterColumnWidthTrackingEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTAfterColumnWidthTrackingEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TVTHeader; Column : TColumnIndex);

  End;

  TVTAfterGetMaxColumnWidthEventListEx = Class(TMethodListEx, IVTAfterGetMaxColumnWidthEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTAfterGetMaxColumnWidthEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTAfterGetMaxColumnWidthEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTAfterGetMaxColumnWidthEvent Read Get Write Put; Default;

    Function  Add(Item : TVTAfterGetMaxColumnWidthEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTAfterGetMaxColumnWidthEvent); OverLoad;
    Function  Remove(Item : TVTAfterGetMaxColumnWidthEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTAfterGetMaxColumnWidthEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TVTHeader; Column : TColumnIndex; Var MaxWidth : Integer);

  End;

  TVTTreeExportEventListEx = Class(TMethodListEx, IVTTreeExportEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTTreeExportEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTTreeExportEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTTreeExportEvent Read Get Write Put; Default;

    Function  Add(Item : TVTTreeExportEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTTreeExportEvent); OverLoad;
    Function  Remove(Item : TVTTreeExportEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTTreeExportEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; aExportType : TVTExportType);

  End;

  TVTAfterHeaderHeightTrackingEventListEx = Class(TMethodListEx, IVTAfterHeaderHeightTrackingEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTAfterHeaderHeightTrackingEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTAfterHeaderHeightTrackingEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTAfterHeaderHeightTrackingEvent Read Get Write Put; Default;

    Function  Add(Item : TVTAfterHeaderHeightTrackingEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTAfterHeaderHeightTrackingEvent); OverLoad;
    Function  Remove(Item : TVTAfterHeaderHeightTrackingEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTAfterHeaderHeightTrackingEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TVTHeader);

  End;

  TVTAfterItemEraseEventListEx = Class(TMethodListEx, IVTAfterItemEraseEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTAfterItemEraseEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTAfterItemEraseEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTAfterItemEraseEvent Read Get Write Put; Default;

    Function  Add(Item : TVTAfterItemEraseEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTAfterItemEraseEvent); OverLoad;
    Function  Remove(Item : TVTAfterItemEraseEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTAfterItemEraseEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; TargetCanvas : TCanvas; Node : PVirtualNode; ItemRect : TRect);

  End;

  TVTAfterItemPaintEventListEx = Class(TMethodListEx, IVTAfterItemPaintEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTAfterItemPaintEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTAfterItemPaintEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTAfterItemPaintEvent Read Get Write Put; Default;

    Function  Add(Item : TVTAfterItemPaintEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTAfterItemPaintEvent); OverLoad;
    Function  Remove(Item : TVTAfterItemPaintEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTAfterItemPaintEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; TargetCanvas : TCanvas; Node : PVirtualNode; ItemRect : TRect);

  End;

  TVTNodeExportEventListEx = Class(TMethodListEx, IVTNodeExportEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTNodeExportEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTNodeExportEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTNodeExportEvent Read Get Write Put; Default;

    Function  Add(Item : TVTNodeExportEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTNodeExportEvent); OverLoad;
    Function  Remove(Item : TVTNodeExportEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTNodeExportEvent) : Integer; OverLoad;

    Function Execute(Sender : TBaseVirtualTree; aExportType : TVTExportType; Node : PVirtualNode) : Boolean;

  End;

  TVTPaintEventListEx = Class(TMethodListEx, IVTPaintEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTPaintEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTPaintEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTPaintEvent Read Get Write Put; Default;

    Function  Add(Item : TVTPaintEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTPaintEvent); OverLoad;
    Function  Remove(Item : TVTPaintEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTPaintEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; TargetCanvas : TCanvas);

  End;

  TVTBeforeAutoFitColumnEventListEx = Class(TMethodListEx, IVTBeforeAutoFitColumnEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTBeforeAutoFitColumnEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTBeforeAutoFitColumnEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTBeforeAutoFitColumnEvent Read Get Write Put; Default;

    Function  Add(Item : TVTBeforeAutoFitColumnEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTBeforeAutoFitColumnEvent); OverLoad;
    Function  Remove(Item : TVTBeforeAutoFitColumnEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTBeforeAutoFitColumnEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TVTHeader; Column : TColumnIndex; Var SmartAutoFitType : TSmartAutoFitType; Var Allowed : Boolean);

  End;

  TVTBeforeAutoFitColumnsEventListEx = Class(TMethodListEx, IVTBeforeAutoFitColumnsEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTBeforeAutoFitColumnsEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTBeforeAutoFitColumnsEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTBeforeAutoFitColumnsEvent Read Get Write Put; Default;

    Function  Add(Item : TVTBeforeAutoFitColumnsEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTBeforeAutoFitColumnsEvent); OverLoad;
    Function  Remove(Item : TVTBeforeAutoFitColumnsEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTBeforeAutoFitColumnsEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TVTHeader; Var SmartAutoFitType : TSmartAutoFitType);

  End;

  TVTBeforeCellPaintEventListEx = Class(TMethodListEx, IVTBeforeCellPaintEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTBeforeCellPaintEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTBeforeCellPaintEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTBeforeCellPaintEvent Read Get Write Put; Default;

    Function  Add(Item : TVTBeforeCellPaintEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTBeforeCellPaintEvent); OverLoad;
    Function  Remove(Item : TVTBeforeCellPaintEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTBeforeCellPaintEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; TargetCanvas : TCanvas; Node : PVirtualNode; Column : TColumnIndex; CellPaintMode : TVTCellPaintMode; CellRect : TRect; Var ContentRect : TRect);

  End;

  TVTBeforeColumnWidthTrackingEventListEx = Class(TMethodListEx, IVTBeforeColumnWidthTrackingEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTBeforeColumnWidthTrackingEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTBeforeColumnWidthTrackingEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTBeforeColumnWidthTrackingEvent Read Get Write Put; Default;

    Function  Add(Item : TVTBeforeColumnWidthTrackingEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTBeforeColumnWidthTrackingEvent); OverLoad;
    Function  Remove(Item : TVTBeforeColumnWidthTrackingEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTBeforeColumnWidthTrackingEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TVTHeader; Column : TColumnIndex; Shift : TShiftState);

  End;

  TVTBeforeDrawLineImageEventListEx = Class(TMethodListEx, IVTBeforeDrawLineImageEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTBeforeDrawLineImageEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTBeforeDrawLineImageEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTBeforeDrawLineImageEvent Read Get Write Put; Default;

    Function  Add(Item : TVTBeforeDrawLineImageEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTBeforeDrawLineImageEvent); OverLoad;
    Function  Remove(Item : TVTBeforeDrawLineImageEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTBeforeDrawLineImageEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Level : Integer; Var PosX : Integer);

  End;

  TVTBeforeGetMaxColumnWidthEventListEx = Class(TMethodListEx, IVTBeforeGetMaxColumnWidthEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTBeforeGetMaxColumnWidthEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTBeforeGetMaxColumnWidthEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTBeforeGetMaxColumnWidthEvent Read Get Write Put; Default;

    Function  Add(Item : TVTBeforeGetMaxColumnWidthEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTBeforeGetMaxColumnWidthEvent); OverLoad;
    Function  Remove(Item : TVTBeforeGetMaxColumnWidthEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTBeforeGetMaxColumnWidthEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TVTHeader; Column : TColumnIndex; Var UseSmartColumnWidth : Boolean);

  End;

  TVTBeforeHeaderHeightTrackingEventListEx = Class(TMethodListEx, IVTBeforeHeaderHeightTrackingEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTBeforeHeaderHeightTrackingEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTBeforeHeaderHeightTrackingEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTBeforeHeaderHeightTrackingEvent Read Get Write Put; Default;

    Function  Add(Item : TVTBeforeHeaderHeightTrackingEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTBeforeHeaderHeightTrackingEvent); OverLoad;
    Function  Remove(Item : TVTBeforeHeaderHeightTrackingEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTBeforeHeaderHeightTrackingEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TVTHeader; Shift : TShiftState);

  End;

  TVTBeforeItemEraseEventListEx = Class(TMethodListEx, IVTBeforeItemEraseEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTBeforeItemEraseEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTBeforeItemEraseEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTBeforeItemEraseEvent Read Get Write Put; Default;

    Function  Add(Item : TVTBeforeItemEraseEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTBeforeItemEraseEvent); OverLoad;
    Function  Remove(Item : TVTBeforeItemEraseEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTBeforeItemEraseEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; TargetCanvas : TCanvas; Node : PVirtualNode; ItemRect : TRect; Var ItemColor : TColor; Var EraseAction : TItemEraseAction);

  End;

  TVTBeforeItemPaintEventListEx = Class(TMethodListEx, IVTBeforeItemPaintEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTBeforeItemPaintEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTBeforeItemPaintEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTBeforeItemPaintEvent Read Get Write Put; Default;

    Function  Add(Item : TVTBeforeItemPaintEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTBeforeItemPaintEvent); OverLoad;
    Function  Remove(Item : TVTBeforeItemPaintEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTBeforeItemPaintEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; TargetCanvas : TCanvas; Node : PVirtualNode; ItemRect : TRect; Var CustomDraw : Boolean);

  End;

  TCanResizeEventListEx = Class(TMethodListEx, ICanResizeEventListEx)
  Protected
    Function  Get(Index : Integer) : TCanResizeEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TCanResizeEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TCanResizeEvent Read Get Write Put; Default;

    Function  Add(Item : TCanResizeEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TCanResizeEvent); OverLoad;
    Function  Remove(Item : TCanResizeEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TCanResizeEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TObject; Var NewWidth : Integer; Var NewHeight : Integer; Var Resize : Boolean);

  End;

  TVTCanSplitterResizeColumnEventListEx = Class(TMethodListEx, IVTCanSplitterResizeColumnEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTCanSplitterResizeColumnEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTCanSplitterResizeColumnEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTCanSplitterResizeColumnEvent Read Get Write Put; Default;

    Function  Add(Item : TVTCanSplitterResizeColumnEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTCanSplitterResizeColumnEvent); OverLoad;
    Function  Remove(Item : TVTCanSplitterResizeColumnEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTCanSplitterResizeColumnEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TVTHeader; P : TPoint; Column : TColumnIndex; Var Allowed : Boolean);

  End;

  TVTCanSplitterResizeHeaderEventListEx = Class(TMethodListEx, IVTCanSplitterResizeHeaderEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTCanSplitterResizeHeaderEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTCanSplitterResizeHeaderEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTCanSplitterResizeHeaderEvent Read Get Write Put; Default;

    Function  Add(Item : TVTCanSplitterResizeHeaderEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTCanSplitterResizeHeaderEvent); OverLoad;
    Function  Remove(Item : TVTCanSplitterResizeHeaderEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTCanSplitterResizeHeaderEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TVTHeader; P : TPoint; Var Allowed : Boolean);

  End;

  TVTCanSplitterResizeNodeEventListEx = Class(TMethodListEx, IVTCanSplitterResizeNodeEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTCanSplitterResizeNodeEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTCanSplitterResizeNodeEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTCanSplitterResizeNodeEvent Read Get Write Put; Default;

    Function  Add(Item : TVTCanSplitterResizeNodeEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTCanSplitterResizeNodeEvent); OverLoad;
    Function  Remove(Item : TVTCanSplitterResizeNodeEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTCanSplitterResizeNodeEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; P : TPoint; Node : PVirtualNode; Column : TColumnIndex; Var Allowed : Boolean);

  End;

  TVTChangeEventListEx = Class(TMethodListEx, IVTChangeEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTChangeEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTChangeEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTChangeEvent Read Get Write Put; Default;

    Function  Add(Item : TVTChangeEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTChangeEvent); OverLoad;
    Function  Remove(Item : TVTChangeEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTChangeEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode);

  End;

  TVTCheckChangingEventListEx = Class(TMethodListEx, IVTCheckChangingEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTCheckChangingEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTCheckChangingEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTCheckChangingEvent Read Get Write Put; Default;

    Function  Add(Item : TVTCheckChangingEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTCheckChangingEvent); OverLoad;
    Function  Remove(Item : TVTCheckChangingEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTCheckChangingEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Var NewState : TCheckState; Var Allowed : Boolean);

  End;

  TVTChangingEventListEx = Class(TMethodListEx, IVTChangingEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTChangingEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTChangingEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTChangingEvent Read Get Write Put; Default;

    Function  Add(Item : TVTChangingEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTChangingEvent); OverLoad;
    Function  Remove(Item : TVTChangingEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTChangingEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Var Allowed : Boolean);

  End;

  TVTColumnClickEventListEx = Class(TMethodListEx, IVTColumnClickEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTColumnClickEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTColumnClickEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTColumnClickEvent Read Get Write Put; Default;

    Function  Add(Item : TVTColumnClickEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTColumnClickEvent); OverLoad;
    Function  Remove(Item : TVTColumnClickEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTColumnClickEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Column : TColumnIndex; Shift : TShiftState);

  End;

  TVTColumnDblClickEventListEx = Class(TMethodListEx, IVTColumnDblClickEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTColumnDblClickEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTColumnDblClickEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTColumnDblClickEvent Read Get Write Put; Default;

    Function  Add(Item : TVTColumnDblClickEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTColumnDblClickEvent); OverLoad;
    Function  Remove(Item : TVTColumnDblClickEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTColumnDblClickEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Column : TColumnIndex; Shift : TShiftState);

  End;

  TVTHeaderNotifyEventListEx = Class(TMethodListEx, IVTHeaderNotifyEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTHeaderNotifyEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTHeaderNotifyEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTHeaderNotifyEvent Read Get Write Put; Default;

    Function  Add(Item : TVTHeaderNotifyEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTHeaderNotifyEvent); OverLoad;
    Function  Remove(Item : TVTHeaderNotifyEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTHeaderNotifyEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TVTHeader; Column : TColumnIndex);

  End;

  TColumnChangeEventListEx = Class(TMethodListEx, IColumnChangeEventListEx)
  Protected
    Function  Get(Index : Integer) : TColumnChangeEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TColumnChangeEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TColumnChangeEvent Read Get Write Put; Default;

    Function  Add(Item : TColumnChangeEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TColumnChangeEvent); OverLoad;
    Function  Remove(Item : TColumnChangeEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TColumnChangeEvent) : Integer; OverLoad;

    Procedure Execute(Const Sender : TBaseVirtualTree; Const Column : TColumnIndex; Visible : Boolean);

  End;

  TVTColumnWidthDblClickResizeEventListEx = Class(TMethodListEx, IVTColumnWidthDblClickResizeEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTColumnWidthDblClickResizeEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTColumnWidthDblClickResizeEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTColumnWidthDblClickResizeEvent Read Get Write Put; Default;

    Function  Add(Item : TVTColumnWidthDblClickResizeEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTColumnWidthDblClickResizeEvent); OverLoad;
    Function  Remove(Item : TVTColumnWidthDblClickResizeEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTColumnWidthDblClickResizeEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TVTHeader; Column : TColumnIndex; Shift : TShiftState; P : TPoint; Var Allowed : Boolean);

  End;

  TVTColumnWidthTrackingEventListEx = Class(TMethodListEx, IVTColumnWidthTrackingEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTColumnWidthTrackingEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTColumnWidthTrackingEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTColumnWidthTrackingEvent Read Get Write Put; Default;

    Function  Add(Item : TVTColumnWidthTrackingEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTColumnWidthTrackingEvent); OverLoad;
    Function  Remove(Item : TVTColumnWidthTrackingEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTColumnWidthTrackingEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TVTHeader; Column : TColumnIndex; Shift : TShiftState; Var TrackPoint : TPoint; P : TPoint; Var Allowed : Boolean);

  End;

  TVTCompareEventListEx = Class(TMethodListEx, IVTCompareEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTCompareEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTCompareEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTCompareEvent Read Get Write Put; Default;

    Function  Add(Item : TVTCompareEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTCompareEvent); OverLoad;
    Function  Remove(Item : TVTCompareEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTCompareEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Node1 : PVirtualNode; Node2 : PVirtualNode; Column : TColumnIndex; Var Result : Integer);

  End;

  TVTCreateDataObjectEventListEx = Class(TMethodListEx, IVTCreateDataObjectEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTCreateDataObjectEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTCreateDataObjectEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTCreateDataObjectEvent Read Get Write Put; Default;

    Function  Add(Item : TVTCreateDataObjectEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTCreateDataObjectEvent); OverLoad;
    Function  Remove(Item : TVTCreateDataObjectEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTCreateDataObjectEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Out IDataObject : IDataObject);

  End;

  TVTCreateDragManagerEventListEx = Class(TMethodListEx, IVTCreateDragManagerEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTCreateDragManagerEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTCreateDragManagerEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTCreateDragManagerEvent Read Get Write Put; Default;

    Function  Add(Item : TVTCreateDragManagerEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTCreateDragManagerEvent); OverLoad;
    Function  Remove(Item : TVTCreateDragManagerEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTCreateDragManagerEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Out DragManager : IVTDragManager);

  End;

  TVTCreateEditorEventListEx = Class(TMethodListEx, IVTCreateEditorEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTCreateEditorEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTCreateEditorEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTCreateEditorEvent Read Get Write Put; Default;

    Function  Add(Item : TVTCreateEditorEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTCreateEditorEvent); OverLoad;
    Function  Remove(Item : TVTCreateEditorEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTCreateEditorEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex; Out EditLink : IVTEditLink);

  End;

  TVTDragAllowedEventListEx = Class(TMethodListEx, IVTDragAllowedEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTDragAllowedEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTDragAllowedEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTDragAllowedEvent Read Get Write Put; Default;

    Function  Add(Item : TVTDragAllowedEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTDragAllowedEvent); OverLoad;
    Function  Remove(Item : TVTDragAllowedEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTDragAllowedEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex; Var Allowed : Boolean);

  End;

  TVTDragDropEventListEx = Class(TMethodListEx, IVTDragDropEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTDragDropEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTDragDropEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTDragDropEvent Read Get Write Put; Default;

    Function  Add(Item : TVTDragDropEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTDragDropEvent); OverLoad;
    Function  Remove(Item : TVTDragDropEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTDragDropEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Source : TObject; DataObject : IDataObject; Formats : TFormatArray; Shift : TShiftState; Pt : TPoint; Var Effect : Integer; Mode : TDropMode);

  End;

  TVTDragOverEventListEx = Class(TMethodListEx, IVTDragOverEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTDragOverEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTDragOverEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTDragOverEvent Read Get Write Put; Default;

    Function  Add(Item : TVTDragOverEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTDragOverEvent); OverLoad;
    Function  Remove(Item : TVTDragOverEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTDragOverEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Source : TObject; Shift : TShiftState; State : TDragState; Pt : TPoint; Mode : TDropMode; Var Effect : Integer; Var Accept : Boolean);

  End;

  TVTDrawHintEventListEx = Class(TMethodListEx, IVTDrawHintEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTDrawHintEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTDrawHintEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTDrawHintEvent Read Get Write Put; Default;

    Function  Add(Item : TVTDrawHintEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTDrawHintEvent); OverLoad;
    Function  Remove(Item : TVTDrawHintEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTDrawHintEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; HintCanvas : TCanvas; Node : PVirtualNode; R : TRect; Column : TColumnIndex);

  End;

  TVTDrawTextEventListEx = Class(TMethodListEx, IVTDrawTextEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTDrawTextEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTDrawTextEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTDrawTextEvent Read Get Write Put; Default;

    Function  Add(Item : TVTDrawTextEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTDrawTextEvent); OverLoad;
    Function  Remove(Item : TVTDrawTextEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTDrawTextEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; TargetCanvas : TCanvas; Node : PVirtualNode; Column : TColumnIndex; Const Text : WideString; Const CellRect : TRect; Var DefaultDraw : Boolean);

  End;

  TVTEditCancelEventListEx = Class(TMethodListEx, IVTEditCancelEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTEditCancelEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTEditCancelEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTEditCancelEvent Read Get Write Put; Default;

    Function  Add(Item : TVTEditCancelEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTEditCancelEvent); OverLoad;
    Function  Remove(Item : TVTEditCancelEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTEditCancelEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Column : TColumnIndex);

  End;

  TVTEditChangeEventListEx = Class(TMethodListEx, IVTEditChangeEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTEditChangeEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTEditChangeEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTEditChangeEvent Read Get Write Put; Default;

    Function  Add(Item : TVTEditChangeEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTEditChangeEvent); OverLoad;
    Function  Remove(Item : TVTEditChangeEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTEditChangeEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex);

  End;

  TVTEditChangingEventListEx = Class(TMethodListEx, IVTEditChangingEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTEditChangingEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTEditChangingEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTEditChangingEvent Read Get Write Put; Default;

    Function  Add(Item : TVTEditChangingEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTEditChangingEvent); OverLoad;
    Function  Remove(Item : TVTEditChangingEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTEditChangingEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex; Var Allowed : Boolean);

  End;

  TVTOperationEventListEx = Class(TMethodListEx, IVTOperationEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTOperationEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTOperationEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTOperationEvent Read Get Write Put; Default;

    Function  Add(Item : TVTOperationEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTOperationEvent); OverLoad;
    Function  Remove(Item : TVTOperationEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTOperationEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; OperationKind : TVTOperationKind);

  End;

  TVTFocusChangeEventListEx = Class(TMethodListEx, IVTFocusChangeEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTFocusChangeEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTFocusChangeEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTFocusChangeEvent Read Get Write Put; Default;

    Function  Add(Item : TVTFocusChangeEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTFocusChangeEvent); OverLoad;
    Function  Remove(Item : TVTFocusChangeEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTFocusChangeEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex);

  End;

  TVTFocusChangingEventListEx = Class(TMethodListEx, IVTFocusChangingEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTFocusChangingEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTFocusChangingEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTFocusChangingEvent Read Get Write Put; Default;

    Function  Add(Item : TVTFocusChangingEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTFocusChangingEvent); OverLoad;
    Function  Remove(Item : TVTFocusChangingEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTFocusChangingEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; OldNode : PVirtualNode; NewNode : PVirtualNode; OldColumn : TColumnIndex; NewColumn : TColumnIndex; Var Allowed : Boolean);

  End;

  TVTFreeNodeEventListEx = Class(TMethodListEx, IVTFreeNodeEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTFreeNodeEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTFreeNodeEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTFreeNodeEvent Read Get Write Put; Default;

    Function  Add(Item : TVTFreeNodeEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTFreeNodeEvent); OverLoad;
    Function  Remove(Item : TVTFreeNodeEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTFreeNodeEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode);

  End;

  TVTGetCellIsEmptyEventListEx = Class(TMethodListEx, IVTGetCellIsEmptyEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTGetCellIsEmptyEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTGetCellIsEmptyEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTGetCellIsEmptyEvent Read Get Write Put; Default;

    Function  Add(Item : TVTGetCellIsEmptyEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTGetCellIsEmptyEvent); OverLoad;
    Function  Remove(Item : TVTGetCellIsEmptyEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTGetCellIsEmptyEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex; Var IsEmpty : Boolean);

  End;

  TVSTGetCellTextEventListEx = Class(TMethodListEx, IVSTGetCellTextEventListEx)
  Protected
    Function  Get(Index : Integer) : TVSTGetCellTextEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVSTGetCellTextEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVSTGetCellTextEvent Read Get Write Put; Default;

    Function  Add(Item : TVSTGetCellTextEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVSTGetCellTextEvent); OverLoad;
    Function  Remove(Item : TVSTGetCellTextEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVSTGetCellTextEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TCustomVirtualStringTree; Var E : TVSTGetCellTextEventArgs);

  End;

  TVTGetCursorEventListEx = Class(TMethodListEx, IVTGetCursorEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTGetCursorEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTGetCursorEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTGetCursorEvent Read Get Write Put; Default;

    Function  Add(Item : TVTGetCursorEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTGetCursorEvent); OverLoad;
    Function  Remove(Item : TVTGetCursorEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTGetCursorEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Var Cursor : TCursor);

  End;

  TVTGetHeaderCursorEventListEx = Class(TMethodListEx, IVTGetHeaderCursorEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTGetHeaderCursorEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTGetHeaderCursorEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTGetHeaderCursorEvent Read Get Write Put; Default;

    Function  Add(Item : TVTGetHeaderCursorEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTGetHeaderCursorEvent); OverLoad;
    Function  Remove(Item : TVTGetHeaderCursorEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTGetHeaderCursorEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TVTHeader; Var Cursor : HICON);

  End;

  TVTHelpContextEventListEx = Class(TMethodListEx, IVTHelpContextEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTHelpContextEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTHelpContextEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTHelpContextEvent Read Get Write Put; Default;

    Function  Add(Item : TVTHelpContextEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTHelpContextEvent); OverLoad;
    Function  Remove(Item : TVTHelpContextEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTHelpContextEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex; Var HelpContext : Integer);

  End;

  TVSTGetHintEventListEx = Class(TMethodListEx, IVSTGetHintEventListEx)
  Protected
    Function  Get(Index : Integer) : TVSTGetHintEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVSTGetHintEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVSTGetHintEvent Read Get Write Put; Default;

    Function  Add(Item : TVSTGetHintEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVSTGetHintEvent); OverLoad;
    Function  Remove(Item : TVSTGetHintEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVSTGetHintEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex; Var LineBreakStyle : TVTTooltipLineBreakStyle; Var HintText : WideString);

  End;

  TVTHintKindEventListEx = Class(TMethodListEx, IVTHintKindEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTHintKindEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTHintKindEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTHintKindEvent Read Get Write Put; Default;

    Function  Add(Item : TVTHintKindEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTHintKindEvent); OverLoad;
    Function  Remove(Item : TVTHintKindEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTHintKindEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex; Var Kind : TVTHintKind);

  End;

  TVTGetHintSizeEventListEx = Class(TMethodListEx, IVTGetHintSizeEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTGetHintSizeEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTGetHintSizeEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTGetHintSizeEvent Read Get Write Put; Default;

    Function  Add(Item : TVTGetHintSizeEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTGetHintSizeEvent); OverLoad;
    Function  Remove(Item : TVTGetHintSizeEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTGetHintSizeEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex; Var R : TRect);

  End;

  TVTGetImageEventListEx = Class(TMethodListEx, IVTGetImageEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTGetImageEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTGetImageEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTGetImageEvent Read Get Write Put; Default;

    Function  Add(Item : TVTGetImageEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTGetImageEvent); OverLoad;
    Function  Remove(Item : TVTGetImageEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTGetImageEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Kind : TVTImageKind; Column : TColumnIndex; Var Ghosted : Boolean; Var ImageIndex : TImageIndex);

  End;

  TVTGetImageExEventListEx = Class(TMethodListEx, IVTGetImageExEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTGetImageExEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTGetImageExEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTGetImageExEvent Read Get Write Put; Default;

    Function  Add(Item : TVTGetImageExEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTGetImageExEvent); OverLoad;
    Function  Remove(Item : TVTGetImageExEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTGetImageExEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Kind : TVTImageKind; Column : TColumnIndex; Var Ghosted : Boolean; Var ImageIndex : TImageIndex; Var ImageList : TCustomImageList);

  End;

  TVTGetImageTextEventListEx = Class(TMethodListEx, IVTGetImageTextEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTGetImageTextEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTGetImageTextEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTGetImageTextEvent Read Get Write Put; Default;

    Function  Add(Item : TVTGetImageTextEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTGetImageTextEvent); OverLoad;
    Function  Remove(Item : TVTGetImageTextEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTGetImageTextEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Kind : TVTImageKind; Column : TColumnIndex; Var ImageText : WideString);

  End;

  TVTGetLineStyleEventListEx = Class(TMethodListEx, IVTGetLineStyleEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTGetLineStyleEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTGetLineStyleEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTGetLineStyleEvent Read Get Write Put; Default;

    Function  Add(Item : TVTGetLineStyleEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTGetLineStyleEvent); OverLoad;
    Function  Remove(Item : TVTGetLineStyleEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTGetLineStyleEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Var Bits : Pointer);

  End;

  TVTGetNodeDataSizeEventListEx = Class(TMethodListEx, IVTGetNodeDataSizeEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTGetNodeDataSizeEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTGetNodeDataSizeEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTGetNodeDataSizeEvent Read Get Write Put; Default;

    Function  Add(Item : TVTGetNodeDataSizeEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTGetNodeDataSizeEvent); OverLoad;
    Function  Remove(Item : TVTGetNodeDataSizeEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTGetNodeDataSizeEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Var NodeDataSize : Integer);

  End;

  TVTPopupEventListEx = Class(TMethodListEx, IVTPopupEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTPopupEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTPopupEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTPopupEvent Read Get Write Put; Default;

    Function  Add(Item : TVTPopupEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTPopupEvent); OverLoad;
    Function  Remove(Item : TVTPopupEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTPopupEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex; Const P : TPoint; Var AskParent : Boolean; Var PopupMenu : TPopupMenu);

  End;

  TVSTGetTextEventListEx = Class(TMethodListEx, IVSTGetTextEventListEx)
  Protected
    Function  Get(Index : Integer) : TVSTGetTextEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVSTGetTextEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVSTGetTextEvent Read Get Write Put; Default;

    Function  Add(Item : TVSTGetTextEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVSTGetTextEvent); OverLoad;
    Function  Remove(Item : TVSTGetTextEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVSTGetTextEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex; TextType : TVSTTextType; Var CellText : WideString);

  End;

  TVTGetUserClipboardFormatsEventListEx = Class(TMethodListEx, IVTGetUserClipboardFormatsEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTGetUserClipboardFormatsEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTGetUserClipboardFormatsEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTGetUserClipboardFormatsEvent Read Get Write Put; Default;

    Function  Add(Item : TVTGetUserClipboardFormatsEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTGetUserClipboardFormatsEvent); OverLoad;
    Function  Remove(Item : TVTGetUserClipboardFormatsEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTGetUserClipboardFormatsEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Var Formats : TFormatEtcArray);

  End;

  TVTHeaderClickEventListEx = Class(TMethodListEx, IVTHeaderClickEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTHeaderClickEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTHeaderClickEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTHeaderClickEvent Read Get Write Put; Default;

    Function  Add(Item : TVTHeaderClickEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTHeaderClickEvent); OverLoad;
    Function  Remove(Item : TVTHeaderClickEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTHeaderClickEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TVTHeader; HitInfo : TVTHeaderHitInfo);

  End;

  TVTHeaderDraggedEventListEx = Class(TMethodListEx, IVTHeaderDraggedEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTHeaderDraggedEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTHeaderDraggedEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTHeaderDraggedEvent Read Get Write Put; Default;

    Function  Add(Item : TVTHeaderDraggedEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTHeaderDraggedEvent); OverLoad;
    Function  Remove(Item : TVTHeaderDraggedEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTHeaderDraggedEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TVTHeader; Column : TColumnIndex; OldPosition : Integer);

  End;

  TVTHeaderDraggedOutEventListEx = Class(TMethodListEx, IVTHeaderDraggedOutEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTHeaderDraggedOutEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTHeaderDraggedOutEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTHeaderDraggedOutEvent Read Get Write Put; Default;

    Function  Add(Item : TVTHeaderDraggedOutEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTHeaderDraggedOutEvent); OverLoad;
    Function  Remove(Item : TVTHeaderDraggedOutEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTHeaderDraggedOutEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TVTHeader; Column : TColumnIndex; DropPosition : TPoint);

  End;

  TVTHeaderDraggingEventListEx = Class(TMethodListEx, IVTHeaderDraggingEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTHeaderDraggingEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTHeaderDraggingEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTHeaderDraggingEvent Read Get Write Put; Default;

    Function  Add(Item : TVTHeaderDraggingEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTHeaderDraggingEvent); OverLoad;
    Function  Remove(Item : TVTHeaderDraggingEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTHeaderDraggingEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TVTHeader; Column : TColumnIndex; Var Allowed : Boolean);

  End;

  TVTHeaderPaintEventListEx = Class(TMethodListEx, IVTHeaderPaintEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTHeaderPaintEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTHeaderPaintEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTHeaderPaintEvent Read Get Write Put; Default;

    Function  Add(Item : TVTHeaderPaintEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTHeaderPaintEvent); OverLoad;
    Function  Remove(Item : TVTHeaderPaintEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTHeaderPaintEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TVTHeader; HeaderCanvas : TCanvas; Column : TVirtualTreeColumn; R : TRect; Hover : Boolean; Pressed : Boolean; DropMark : TVTDropMarkMode);

  End;

  TVTHeaderPaintQueryElementsEventListEx = Class(TMethodListEx, IVTHeaderPaintQueryElementsEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTHeaderPaintQueryElementsEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTHeaderPaintQueryElementsEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTHeaderPaintQueryElementsEvent Read Get Write Put; Default;

    Function  Add(Item : TVTHeaderPaintQueryElementsEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTHeaderPaintQueryElementsEvent); OverLoad;
    Function  Remove(Item : TVTHeaderPaintQueryElementsEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTHeaderPaintQueryElementsEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TVTHeader; Var PaintInfo : THeaderPaintInfo; Var Elements : THeaderPaintElements);

  End;

  TVTHeaderHeightDblClickResizeEventListEx = Class(TMethodListEx, IVTHeaderHeightDblClickResizeEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTHeaderHeightDblClickResizeEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTHeaderHeightDblClickResizeEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTHeaderHeightDblClickResizeEvent Read Get Write Put; Default;

    Function  Add(Item : TVTHeaderHeightDblClickResizeEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTHeaderHeightDblClickResizeEvent); OverLoad;
    Function  Remove(Item : TVTHeaderHeightDblClickResizeEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTHeaderHeightDblClickResizeEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TVTHeader; Var P : TPoint; Shift : TShiftState; Var Allowed : Boolean);

  End;

  TVTHeaderHeightTrackingEventListEx = Class(TMethodListEx, IVTHeaderHeightTrackingEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTHeaderHeightTrackingEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTHeaderHeightTrackingEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTHeaderHeightTrackingEvent Read Get Write Put; Default;

    Function  Add(Item : TVTHeaderHeightTrackingEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTHeaderHeightTrackingEvent); OverLoad;
    Function  Remove(Item : TVTHeaderHeightTrackingEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTHeaderHeightTrackingEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TVTHeader; Var P : TPoint; Shift : TShiftState; Var Allowed : Boolean);

  End;

  TVTHeaderMouseEventListEx = Class(TMethodListEx, IVTHeaderMouseEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTHeaderMouseEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTHeaderMouseEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTHeaderMouseEvent Read Get Write Put; Default;

    Function  Add(Item : TVTHeaderMouseEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTHeaderMouseEvent); OverLoad;
    Function  Remove(Item : TVTHeaderMouseEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTHeaderMouseEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TVTHeader; Button : TMouseButton; Shift : TShiftState; X : Integer; Y : Integer);

  End;

  TVTHeaderMouseMoveEventListEx = Class(TMethodListEx, IVTHeaderMouseMoveEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTHeaderMouseMoveEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTHeaderMouseMoveEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTHeaderMouseMoveEvent Read Get Write Put; Default;

    Function  Add(Item : TVTHeaderMouseMoveEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTHeaderMouseMoveEvent); OverLoad;
    Function  Remove(Item : TVTHeaderMouseMoveEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTHeaderMouseMoveEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TVTHeader; Shift : TShiftState; X : Integer; Y : Integer);

  End;

  TVTHotNodeChangeEventListEx = Class(TMethodListEx, IVTHotNodeChangeEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTHotNodeChangeEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTHotNodeChangeEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTHotNodeChangeEvent Read Get Write Put; Default;

    Function  Add(Item : TVTHotNodeChangeEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTHotNodeChangeEvent); OverLoad;
    Function  Remove(Item : TVTHotNodeChangeEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTHotNodeChangeEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; OldNode : PVirtualNode; NewNode : PVirtualNode);

  End;

  TVTIncrementalSearchEventListEx = Class(TMethodListEx, IVTIncrementalSearchEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTIncrementalSearchEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTIncrementalSearchEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTIncrementalSearchEvent Read Get Write Put; Default;

    Function  Add(Item : TVTIncrementalSearchEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTIncrementalSearchEvent); OverLoad;
    Function  Remove(Item : TVTIncrementalSearchEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTIncrementalSearchEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Const SearchText : WideString; Var Result : Integer);

  End;

  TVTInitChildrenEventListEx = Class(TMethodListEx, IVTInitChildrenEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTInitChildrenEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTInitChildrenEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTInitChildrenEvent Read Get Write Put; Default;

    Function  Add(Item : TVTInitChildrenEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTInitChildrenEvent); OverLoad;
    Function  Remove(Item : TVTInitChildrenEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTInitChildrenEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Var ChildCount : Cardinal);

  End;

  TVTInitNodeEventListEx = Class(TMethodListEx, IVTInitNodeEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTInitNodeEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTInitNodeEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTInitNodeEvent Read Get Write Put; Default;

    Function  Add(Item : TVTInitNodeEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTInitNodeEvent); OverLoad;
    Function  Remove(Item : TVTInitNodeEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTInitNodeEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; ParentNode : PVirtualNode; Node : PVirtualNode; Var InitialStates : TVirtualNodeInitStates);

  End;

  TVTKeyActionEventListEx = Class(TMethodListEx, IVTKeyActionEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTKeyActionEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTKeyActionEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTKeyActionEvent Read Get Write Put; Default;

    Function  Add(Item : TVTKeyActionEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTKeyActionEvent); OverLoad;
    Function  Remove(Item : TVTKeyActionEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTKeyActionEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Var CharCode : Word; Var Shift : TShiftState; Var DoDefault : Boolean);

  End;

  TVTSaveNodeEventListEx = Class(TMethodListEx, IVTSaveNodeEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTSaveNodeEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTSaveNodeEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTSaveNodeEvent Read Get Write Put; Default;

    Function  Add(Item : TVTSaveNodeEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTSaveNodeEvent); OverLoad;
    Function  Remove(Item : TVTSaveNodeEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTSaveNodeEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Stream : TStream);

  End;

  TVTSaveTreeEventListEx = Class(TMethodListEx, IVTSaveTreeEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTSaveTreeEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTSaveTreeEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTSaveTreeEvent Read Get Write Put; Default;

    Function  Add(Item : TVTSaveTreeEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTSaveTreeEvent); OverLoad;
    Function  Remove(Item : TVTSaveTreeEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTSaveTreeEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Stream : TStream);

  End;

  TVTMeasureItemEventListEx = Class(TMethodListEx, IVTMeasureItemEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTMeasureItemEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTMeasureItemEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTMeasureItemEvent Read Get Write Put; Default;

    Function  Add(Item : TVTMeasureItemEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTMeasureItemEvent); OverLoad;
    Function  Remove(Item : TVTMeasureItemEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTMeasureItemEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; TargetCanvas : TCanvas; Node : PVirtualNode; Var NodeHeight : Integer);

  End;

  TVTMeasureTextEventListEx = Class(TMethodListEx, IVTMeasureTextEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTMeasureTextEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTMeasureTextEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTMeasureTextEvent Read Get Write Put; Default;

    Function  Add(Item : TVTMeasureTextEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTMeasureTextEvent); OverLoad;
    Function  Remove(Item : TVTMeasureTextEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTMeasureTextEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; TargetCanvas : TCanvas; Node : PVirtualNode; Column : TColumnIndex; Const Text : WideString; Var Extent : Integer);

  End;

  TMouseWheelEventListEx = Class(TMethodListEx, IMouseWheelEventListEx)
  Protected
    Function  Get(Index : Integer) : TMouseWheelEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TMouseWheelEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TMouseWheelEvent Read Get Write Put; Default;

    Function  Add(Item : TMouseWheelEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TMouseWheelEvent); OverLoad;
    Function  Remove(Item : TMouseWheelEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TMouseWheelEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TObject; Shift : TShiftState; WheelDelta : Integer; MousePos : TPoint; Var Handled : Boolean);

  End;

  TVSTNewTextEventListEx = Class(TMethodListEx, IVSTNewTextEventListEx)
  Protected
    Function  Get(Index : Integer) : TVSTNewTextEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVSTNewTextEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVSTNewTextEvent Read Get Write Put; Default;

    Function  Add(Item : TVSTNewTextEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVSTNewTextEvent); OverLoad;
    Function  Remove(Item : TVSTNewTextEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVSTNewTextEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex; NewText : WideString);

  End;

  TVTNodeClickEventListEx = Class(TMethodListEx, IVTNodeClickEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTNodeClickEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTNodeClickEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTNodeClickEvent Read Get Write Put; Default;

    Function  Add(Item : TVTNodeClickEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTNodeClickEvent); OverLoad;
    Function  Remove(Item : TVTNodeClickEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTNodeClickEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Const HitInfo : THitInfo);

  End;

  TVTNodeCopiedEventListEx = Class(TMethodListEx, IVTNodeCopiedEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTNodeCopiedEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTNodeCopiedEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTNodeCopiedEvent Read Get Write Put; Default;

    Function  Add(Item : TVTNodeCopiedEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTNodeCopiedEvent); OverLoad;
    Function  Remove(Item : TVTNodeCopiedEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTNodeCopiedEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode);

  End;

  TVTNodeCopyingEventListEx = Class(TMethodListEx, IVTNodeCopyingEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTNodeCopyingEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTNodeCopyingEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTNodeCopyingEvent Read Get Write Put; Default;

    Function  Add(Item : TVTNodeCopyingEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTNodeCopyingEvent); OverLoad;
    Function  Remove(Item : TVTNodeCopyingEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTNodeCopyingEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Target : PVirtualNode; Var Allowed : Boolean);

  End;

  TVTNodeHeightDblClickResizeEventListEx = Class(TMethodListEx, IVTNodeHeightDblClickResizeEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTNodeHeightDblClickResizeEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTNodeHeightDblClickResizeEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTNodeHeightDblClickResizeEvent Read Get Write Put; Default;

    Function  Add(Item : TVTNodeHeightDblClickResizeEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTNodeHeightDblClickResizeEvent); OverLoad;
    Function  Remove(Item : TVTNodeHeightDblClickResizeEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTNodeHeightDblClickResizeEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex; Shift : TShiftState; P : TPoint; Var Allowed : Boolean);

  End;

  TVTNodeHeightTrackingEventListEx = Class(TMethodListEx, IVTNodeHeightTrackingEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTNodeHeightTrackingEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTNodeHeightTrackingEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTNodeHeightTrackingEvent Read Get Write Put; Default;

    Function  Add(Item : TVTNodeHeightTrackingEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTNodeHeightTrackingEvent); OverLoad;
    Function  Remove(Item : TVTNodeHeightTrackingEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTNodeHeightTrackingEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex; Shift : TShiftState; Var TrackPoint : TPoint; P : TPoint; Var Allowed : Boolean);

  End;

  TVTNodeMovedEventListEx = Class(TMethodListEx, IVTNodeMovedEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTNodeMovedEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTNodeMovedEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTNodeMovedEvent Read Get Write Put; Default;

    Function  Add(Item : TVTNodeMovedEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTNodeMovedEvent); OverLoad;
    Function  Remove(Item : TVTNodeMovedEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTNodeMovedEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode);

  End;

  TVTNodeMovingEventListEx = Class(TMethodListEx, IVTNodeMovingEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTNodeMovingEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTNodeMovingEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTNodeMovingEvent Read Get Write Put; Default;

    Function  Add(Item : TVTNodeMovingEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTNodeMovingEvent); OverLoad;
    Function  Remove(Item : TVTNodeMovingEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTNodeMovingEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Target : PVirtualNode; Var Allowed : Boolean);

  End;

  TVTBackgroundPaintEventListEx = Class(TMethodListEx, IVTBackgroundPaintEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTBackgroundPaintEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTBackgroundPaintEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTBackgroundPaintEvent Read Get Write Put; Default;

    Function  Add(Item : TVTBackgroundPaintEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTBackgroundPaintEvent); OverLoad;
    Function  Remove(Item : TVTBackgroundPaintEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTBackgroundPaintEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; TargetCanvas : TCanvas; R : TRect; Var Handled : Boolean);

  End;

  TVTPaintTextListEx = Class(TMethodListEx, IVTPaintTextListEx)
  Protected
    Function  Get(Index : Integer) : TVTPaintText; OverLoad;
    Procedure Put(Index : Integer; Item : TVTPaintText); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTPaintText Read Get Write Put; Default;

    Function  Add(Item : TVTPaintText) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTPaintText); OverLoad;
    Function  Remove(Item : TVTPaintText) : Integer; OverLoad;
    Function  IndexOf(Item : TVTPaintText) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Const TargetCanvas : TCanvas; Node : PVirtualNode; Column : TColumnIndex; TextType : TVSTTextType);

  End;

  TVTPrepareButtonImagesEventListEx = Class(TMethodListEx, IVTPrepareButtonImagesEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTPrepareButtonImagesEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTPrepareButtonImagesEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTPrepareButtonImagesEvent Read Get Write Put; Default;

    Function  Add(Item : TVTPrepareButtonImagesEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTPrepareButtonImagesEvent); OverLoad;
    Function  Remove(Item : TVTPrepareButtonImagesEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTPrepareButtonImagesEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Const APlusBM : TBitmap; Const APlusHotBM : TBitmap; Const APlusSelectedHotBM : TBitmap; Const AMinusBM : TBitmap; Const AMinusHotBM : TBitmap; Const AMinusSelectedHotBM : TBitmap; Var ASize : TSize);

  End;

  TVTRemoveFromSelectionEventListEx = Class(TMethodListEx, IVTRemoveFromSelectionEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTRemoveFromSelectionEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTRemoveFromSelectionEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTRemoveFromSelectionEvent Read Get Write Put; Default;

    Function  Add(Item : TVTRemoveFromSelectionEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTRemoveFromSelectionEvent); OverLoad;
    Function  Remove(Item : TVTRemoveFromSelectionEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTRemoveFromSelectionEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode);

  End;

  TVTRenderOLEDataEventListEx = Class(TMethodListEx, IVTRenderOLEDataEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTRenderOLEDataEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTRenderOLEDataEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTRenderOLEDataEvent Read Get Write Put; Default;

    Function  Add(Item : TVTRenderOLEDataEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTRenderOLEDataEvent); OverLoad;
    Function  Remove(Item : TVTRenderOLEDataEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTRenderOLEDataEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Const FormatEtcIn : tagFORMATETC; Out Medium : tagSTGMEDIUM; ForClipboard : Boolean; Var Result : HRESULT);

  End;

  TVTScrollEventListEx = Class(TMethodListEx, IVTScrollEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTScrollEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTScrollEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTScrollEvent Read Get Write Put; Default;

    Function  Add(Item : TVTScrollEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTScrollEvent); OverLoad;
    Function  Remove(Item : TVTScrollEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTScrollEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; DeltaX : Integer; DeltaY : Integer);

  End;

  TVSTShortenStringEventListEx = Class(TMethodListEx, IVSTShortenStringEventListEx)
  Protected
    Function  Get(Index : Integer) : TVSTShortenStringEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVSTShortenStringEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVSTShortenStringEvent Read Get Write Put; Default;

    Function  Add(Item : TVSTShortenStringEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVSTShortenStringEvent); OverLoad;
    Function  Remove(Item : TVSTShortenStringEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVSTShortenStringEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; TargetCanvas : TCanvas; Node : PVirtualNode; Column : TColumnIndex; Const S : WideString; TextSpace : Integer; Var Result : WideString; Var Done : Boolean);

  End;

  TVTScrollBarShowEventListEx = Class(TMethodListEx, IVTScrollBarShowEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTScrollBarShowEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTScrollBarShowEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTScrollBarShowEvent Read Get Write Put; Default;

    Function  Add(Item : TVTScrollBarShowEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTScrollBarShowEvent); OverLoad;
    Function  Remove(Item : TVTScrollBarShowEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTScrollBarShowEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Bar : Integer; Show : Boolean);

  End;

  TVTStateChangeEventListEx = Class(TMethodListEx, IVTStateChangeEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTStateChangeEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTStateChangeEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTStateChangeEvent Read Get Write Put; Default;

    Function  Add(Item : TVTStateChangeEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTStateChangeEvent); OverLoad;
    Function  Remove(Item : TVTStateChangeEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTStateChangeEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Enter : TVirtualTreeStates; Leave : TVirtualTreeStates);

  End;

  TVTStructureChangeEventListEx = Class(TMethodListEx, IVTStructureChangeEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTStructureChangeEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTStructureChangeEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTStructureChangeEvent Read Get Write Put; Default;

    Function  Add(Item : TVTStructureChangeEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTStructureChangeEvent); OverLoad;
    Function  Remove(Item : TVTStructureChangeEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTStructureChangeEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Reason : TChangeReason);

  End;

  TVTUpdatingEventListEx = Class(TMethodListEx, IVTUpdatingEventListEx)
  Protected
    Function  Get(Index : Integer) : TVTUpdatingEvent; OverLoad;
    Procedure Put(Index : Integer; Item : TVTUpdatingEvent); OverLoad;

    Function  GetExecuteProc() : TMethod; OverRide;

  Public
    Property Items[Index : Integer] : TVTUpdatingEvent Read Get Write Put; Default;

    Function  Add(Item : TVTUpdatingEvent) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Item : TVTUpdatingEvent); OverLoad;
    Function  Remove(Item : TVTUpdatingEvent) : Integer; OverLoad;
    Function  IndexOf(Item : TVTUpdatingEvent) : Integer; OverLoad;

    Procedure Execute(Sender : TBaseVirtualTree; State : TVTUpdateState);

  End;

(******************************************************************************)

  IVirtualStringTreeEventDispatcher = Interface(IEventDispatcher)
    ['{4B61686E-29A0-2112-9B16-431A3F76463B}']
    Procedure RegisterVTAddToSelectionEvent(AEvent, ANewEvent : TVTAddToSelectionEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTAddToSelectionEvent(AEvent, AOldEvent : TVTAddToSelectionEvent);
    Procedure DisableVTAddToSelectionEvent(AEvent, ADisabledEvent : TVTAddToSelectionEvent);
    Procedure EnableVTAddToSelectionEvent(AEvent, AEnabledEvent : TVTAddToSelectionEvent);

    Procedure RegisterVTAdvancedHeaderPaintEvent(AEvent, ANewEvent : TVTAdvancedHeaderPaintEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTAdvancedHeaderPaintEvent(AEvent, AOldEvent : TVTAdvancedHeaderPaintEvent);
    Procedure DisableVTAdvancedHeaderPaintEvent(AEvent, ADisabledEvent : TVTAdvancedHeaderPaintEvent);
    Procedure EnableVTAdvancedHeaderPaintEvent(AEvent, AEnabledEvent : TVTAdvancedHeaderPaintEvent);

    Procedure RegisterVTAfterAutoFitColumnEvent(AEvent, ANewEvent : TVTAfterAutoFitColumnEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTAfterAutoFitColumnEvent(AEvent, AOldEvent : TVTAfterAutoFitColumnEvent);
    Procedure DisableVTAfterAutoFitColumnEvent(AEvent, ADisabledEvent : TVTAfterAutoFitColumnEvent);
    Procedure EnableVTAfterAutoFitColumnEvent(AEvent, AEnabledEvent : TVTAfterAutoFitColumnEvent);

    Procedure RegisterVTAfterAutoFitColumnsEvent(AEvent, ANewEvent : TVTAfterAutoFitColumnsEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTAfterAutoFitColumnsEvent(AEvent, AOldEvent : TVTAfterAutoFitColumnsEvent);
    Procedure DisableVTAfterAutoFitColumnsEvent(AEvent, ADisabledEvent : TVTAfterAutoFitColumnsEvent);
    Procedure EnableVTAfterAutoFitColumnsEvent(AEvent, AEnabledEvent : TVTAfterAutoFitColumnsEvent);

    Procedure RegisterVTAfterCellPaintEvent(AEvent, ANewEvent : TVTAfterCellPaintEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTAfterCellPaintEvent(AEvent, AOldEvent : TVTAfterCellPaintEvent);
    Procedure DisableVTAfterCellPaintEvent(AEvent, ADisabledEvent : TVTAfterCellPaintEvent);
    Procedure EnableVTAfterCellPaintEvent(AEvent, AEnabledEvent : TVTAfterCellPaintEvent);

    Procedure RegisterVTColumnExportEvent(AEvent, ANewEvent : TVTColumnExportEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTColumnExportEvent(AEvent, AOldEvent : TVTColumnExportEvent);
    Procedure DisableVTColumnExportEvent(AEvent, ADisabledEvent : TVTColumnExportEvent);
    Procedure EnableVTColumnExportEvent(AEvent, AEnabledEvent : TVTColumnExportEvent);

    Procedure RegisterVTAfterColumnWidthTrackingEvent(AEvent, ANewEvent : TVTAfterColumnWidthTrackingEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTAfterColumnWidthTrackingEvent(AEvent, AOldEvent : TVTAfterColumnWidthTrackingEvent);
    Procedure DisableVTAfterColumnWidthTrackingEvent(AEvent, ADisabledEvent : TVTAfterColumnWidthTrackingEvent);
    Procedure EnableVTAfterColumnWidthTrackingEvent(AEvent, AEnabledEvent : TVTAfterColumnWidthTrackingEvent);

    Procedure RegisterVTAfterGetMaxColumnWidthEvent(AEvent, ANewEvent : TVTAfterGetMaxColumnWidthEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTAfterGetMaxColumnWidthEvent(AEvent, AOldEvent : TVTAfterGetMaxColumnWidthEvent);
    Procedure DisableVTAfterGetMaxColumnWidthEvent(AEvent, ADisabledEvent : TVTAfterGetMaxColumnWidthEvent);
    Procedure EnableVTAfterGetMaxColumnWidthEvent(AEvent, AEnabledEvent : TVTAfterGetMaxColumnWidthEvent);

    Procedure RegisterVTTreeExportEvent(AEvent, ANewEvent : TVTTreeExportEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTTreeExportEvent(AEvent, AOldEvent : TVTTreeExportEvent);
    Procedure DisableVTTreeExportEvent(AEvent, ADisabledEvent : TVTTreeExportEvent);
    Procedure EnableVTTreeExportEvent(AEvent, AEnabledEvent : TVTTreeExportEvent);

    Procedure RegisterVTAfterHeaderHeightTrackingEvent(AEvent, ANewEvent : TVTAfterHeaderHeightTrackingEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTAfterHeaderHeightTrackingEvent(AEvent, AOldEvent : TVTAfterHeaderHeightTrackingEvent);
    Procedure DisableVTAfterHeaderHeightTrackingEvent(AEvent, ADisabledEvent : TVTAfterHeaderHeightTrackingEvent);
    Procedure EnableVTAfterHeaderHeightTrackingEvent(AEvent, AEnabledEvent : TVTAfterHeaderHeightTrackingEvent);

    Procedure RegisterVTAfterItemEraseEvent(AEvent, ANewEvent : TVTAfterItemEraseEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTAfterItemEraseEvent(AEvent, AOldEvent : TVTAfterItemEraseEvent);
    Procedure DisableVTAfterItemEraseEvent(AEvent, ADisabledEvent : TVTAfterItemEraseEvent);
    Procedure EnableVTAfterItemEraseEvent(AEvent, AEnabledEvent : TVTAfterItemEraseEvent);

    Procedure RegisterVTAfterItemPaintEvent(AEvent, ANewEvent : TVTAfterItemPaintEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTAfterItemPaintEvent(AEvent, AOldEvent : TVTAfterItemPaintEvent);
    Procedure DisableVTAfterItemPaintEvent(AEvent, ADisabledEvent : TVTAfterItemPaintEvent);
    Procedure EnableVTAfterItemPaintEvent(AEvent, AEnabledEvent : TVTAfterItemPaintEvent);

    Procedure RegisterVTNodeExportEvent(AEvent, ANewEvent : TVTNodeExportEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTNodeExportEvent(AEvent, AOldEvent : TVTNodeExportEvent);
    Procedure DisableVTNodeExportEvent(AEvent, ADisabledEvent : TVTNodeExportEvent);
    Procedure EnableVTNodeExportEvent(AEvent, AEnabledEvent : TVTNodeExportEvent);

    Procedure RegisterVTPaintEvent(AEvent, ANewEvent : TVTPaintEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTPaintEvent(AEvent, AOldEvent : TVTPaintEvent);
    Procedure DisableVTPaintEvent(AEvent, ADisabledEvent : TVTPaintEvent);
    Procedure EnableVTPaintEvent(AEvent, AEnabledEvent : TVTPaintEvent);

    Procedure RegisterVTBeforeAutoFitColumnEvent(AEvent, ANewEvent : TVTBeforeAutoFitColumnEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTBeforeAutoFitColumnEvent(AEvent, AOldEvent : TVTBeforeAutoFitColumnEvent);
    Procedure DisableVTBeforeAutoFitColumnEvent(AEvent, ADisabledEvent : TVTBeforeAutoFitColumnEvent);
    Procedure EnableVTBeforeAutoFitColumnEvent(AEvent, AEnabledEvent : TVTBeforeAutoFitColumnEvent);

    Procedure RegisterVTBeforeAutoFitColumnsEvent(AEvent, ANewEvent : TVTBeforeAutoFitColumnsEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTBeforeAutoFitColumnsEvent(AEvent, AOldEvent : TVTBeforeAutoFitColumnsEvent);
    Procedure DisableVTBeforeAutoFitColumnsEvent(AEvent, ADisabledEvent : TVTBeforeAutoFitColumnsEvent);
    Procedure EnableVTBeforeAutoFitColumnsEvent(AEvent, AEnabledEvent : TVTBeforeAutoFitColumnsEvent);

    Procedure RegisterVTBeforeCellPaintEvent(AEvent, ANewEvent : TVTBeforeCellPaintEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTBeforeCellPaintEvent(AEvent, AOldEvent : TVTBeforeCellPaintEvent);
    Procedure DisableVTBeforeCellPaintEvent(AEvent, ADisabledEvent : TVTBeforeCellPaintEvent);
    Procedure EnableVTBeforeCellPaintEvent(AEvent, AEnabledEvent : TVTBeforeCellPaintEvent);

    Procedure RegisterVTBeforeColumnWidthTrackingEvent(AEvent, ANewEvent : TVTBeforeColumnWidthTrackingEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTBeforeColumnWidthTrackingEvent(AEvent, AOldEvent : TVTBeforeColumnWidthTrackingEvent);
    Procedure DisableVTBeforeColumnWidthTrackingEvent(AEvent, ADisabledEvent : TVTBeforeColumnWidthTrackingEvent);
    Procedure EnableVTBeforeColumnWidthTrackingEvent(AEvent, AEnabledEvent : TVTBeforeColumnWidthTrackingEvent);

    Procedure RegisterVTBeforeDrawLineImageEvent(AEvent, ANewEvent : TVTBeforeDrawLineImageEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTBeforeDrawLineImageEvent(AEvent, AOldEvent : TVTBeforeDrawLineImageEvent);
    Procedure DisableVTBeforeDrawLineImageEvent(AEvent, ADisabledEvent : TVTBeforeDrawLineImageEvent);
    Procedure EnableVTBeforeDrawLineImageEvent(AEvent, AEnabledEvent : TVTBeforeDrawLineImageEvent);

    Procedure RegisterVTBeforeGetMaxColumnWidthEvent(AEvent, ANewEvent : TVTBeforeGetMaxColumnWidthEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTBeforeGetMaxColumnWidthEvent(AEvent, AOldEvent : TVTBeforeGetMaxColumnWidthEvent);
    Procedure DisableVTBeforeGetMaxColumnWidthEvent(AEvent, ADisabledEvent : TVTBeforeGetMaxColumnWidthEvent);
    Procedure EnableVTBeforeGetMaxColumnWidthEvent(AEvent, AEnabledEvent : TVTBeforeGetMaxColumnWidthEvent);

    Procedure RegisterVTBeforeHeaderHeightTrackingEvent(AEvent, ANewEvent : TVTBeforeHeaderHeightTrackingEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTBeforeHeaderHeightTrackingEvent(AEvent, AOldEvent : TVTBeforeHeaderHeightTrackingEvent);
    Procedure DisableVTBeforeHeaderHeightTrackingEvent(AEvent, ADisabledEvent : TVTBeforeHeaderHeightTrackingEvent);
    Procedure EnableVTBeforeHeaderHeightTrackingEvent(AEvent, AEnabledEvent : TVTBeforeHeaderHeightTrackingEvent);

    Procedure RegisterVTBeforeItemEraseEvent(AEvent, ANewEvent : TVTBeforeItemEraseEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTBeforeItemEraseEvent(AEvent, AOldEvent : TVTBeforeItemEraseEvent);
    Procedure DisableVTBeforeItemEraseEvent(AEvent, ADisabledEvent : TVTBeforeItemEraseEvent);
    Procedure EnableVTBeforeItemEraseEvent(AEvent, AEnabledEvent : TVTBeforeItemEraseEvent);

    Procedure RegisterVTBeforeItemPaintEvent(AEvent, ANewEvent : TVTBeforeItemPaintEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTBeforeItemPaintEvent(AEvent, AOldEvent : TVTBeforeItemPaintEvent);
    Procedure DisableVTBeforeItemPaintEvent(AEvent, ADisabledEvent : TVTBeforeItemPaintEvent);
    Procedure EnableVTBeforeItemPaintEvent(AEvent, AEnabledEvent : TVTBeforeItemPaintEvent);

    Procedure RegisterCanResizeEvent(AEvent, ANewEvent : TCanResizeEvent; Const Index : Integer = -1);
    Procedure UnRegisterCanResizeEvent(AEvent, AOldEvent : TCanResizeEvent);
    Procedure DisableCanResizeEvent(AEvent, ADisabledEvent : TCanResizeEvent);
    Procedure EnableCanResizeEvent(AEvent, AEnabledEvent : TCanResizeEvent);

    Procedure RegisterVTCanSplitterResizeColumnEvent(AEvent, ANewEvent : TVTCanSplitterResizeColumnEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTCanSplitterResizeColumnEvent(AEvent, AOldEvent : TVTCanSplitterResizeColumnEvent);
    Procedure DisableVTCanSplitterResizeColumnEvent(AEvent, ADisabledEvent : TVTCanSplitterResizeColumnEvent);
    Procedure EnableVTCanSplitterResizeColumnEvent(AEvent, AEnabledEvent : TVTCanSplitterResizeColumnEvent);

    Procedure RegisterVTCanSplitterResizeHeaderEvent(AEvent, ANewEvent : TVTCanSplitterResizeHeaderEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTCanSplitterResizeHeaderEvent(AEvent, AOldEvent : TVTCanSplitterResizeHeaderEvent);
    Procedure DisableVTCanSplitterResizeHeaderEvent(AEvent, ADisabledEvent : TVTCanSplitterResizeHeaderEvent);
    Procedure EnableVTCanSplitterResizeHeaderEvent(AEvent, AEnabledEvent : TVTCanSplitterResizeHeaderEvent);

    Procedure RegisterVTCanSplitterResizeNodeEvent(AEvent, ANewEvent : TVTCanSplitterResizeNodeEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTCanSplitterResizeNodeEvent(AEvent, AOldEvent : TVTCanSplitterResizeNodeEvent);
    Procedure DisableVTCanSplitterResizeNodeEvent(AEvent, ADisabledEvent : TVTCanSplitterResizeNodeEvent);
    Procedure EnableVTCanSplitterResizeNodeEvent(AEvent, AEnabledEvent : TVTCanSplitterResizeNodeEvent);

    Procedure RegisterVTChangeEvent(AEvent, ANewEvent : TVTChangeEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTChangeEvent(AEvent, AOldEvent : TVTChangeEvent);
    Procedure DisableVTChangeEvent(AEvent, ADisabledEvent : TVTChangeEvent);
    Procedure EnableVTChangeEvent(AEvent, AEnabledEvent : TVTChangeEvent);

    Procedure RegisterVTCheckChangingEvent(AEvent, ANewEvent : TVTCheckChangingEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTCheckChangingEvent(AEvent, AOldEvent : TVTCheckChangingEvent);
    Procedure DisableVTCheckChangingEvent(AEvent, ADisabledEvent : TVTCheckChangingEvent);
    Procedure EnableVTCheckChangingEvent(AEvent, AEnabledEvent : TVTCheckChangingEvent);

    Procedure RegisterVTChangingEvent(AEvent, ANewEvent : TVTChangingEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTChangingEvent(AEvent, AOldEvent : TVTChangingEvent);
    Procedure DisableVTChangingEvent(AEvent, ADisabledEvent : TVTChangingEvent);
    Procedure EnableVTChangingEvent(AEvent, AEnabledEvent : TVTChangingEvent);

    Procedure RegisterVTColumnClickEvent(AEvent, ANewEvent : TVTColumnClickEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTColumnClickEvent(AEvent, AOldEvent : TVTColumnClickEvent);
    Procedure DisableVTColumnClickEvent(AEvent, ADisabledEvent : TVTColumnClickEvent);
    Procedure EnableVTColumnClickEvent(AEvent, AEnabledEvent : TVTColumnClickEvent);

    Procedure RegisterVTColumnDblClickEvent(AEvent, ANewEvent : TVTColumnDblClickEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTColumnDblClickEvent(AEvent, AOldEvent : TVTColumnDblClickEvent);
    Procedure DisableVTColumnDblClickEvent(AEvent, ADisabledEvent : TVTColumnDblClickEvent);
    Procedure EnableVTColumnDblClickEvent(AEvent, AEnabledEvent : TVTColumnDblClickEvent);

    Procedure RegisterVTHeaderNotifyEvent(AEvent, ANewEvent : TVTHeaderNotifyEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTHeaderNotifyEvent(AEvent, AOldEvent : TVTHeaderNotifyEvent);
    Procedure DisableVTHeaderNotifyEvent(AEvent, ADisabledEvent : TVTHeaderNotifyEvent);
    Procedure EnableVTHeaderNotifyEvent(AEvent, AEnabledEvent : TVTHeaderNotifyEvent);

    Procedure RegisterColumnChangeEvent(AEvent, ANewEvent : TColumnChangeEvent; Const Index : Integer = -1);
    Procedure UnRegisterColumnChangeEvent(AEvent, AOldEvent : TColumnChangeEvent);
    Procedure DisableColumnChangeEvent(AEvent, ADisabledEvent : TColumnChangeEvent);
    Procedure EnableColumnChangeEvent(AEvent, AEnabledEvent : TColumnChangeEvent);

    Procedure RegisterVTColumnWidthDblClickResizeEvent(AEvent, ANewEvent : TVTColumnWidthDblClickResizeEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTColumnWidthDblClickResizeEvent(AEvent, AOldEvent : TVTColumnWidthDblClickResizeEvent);
    Procedure DisableVTColumnWidthDblClickResizeEvent(AEvent, ADisabledEvent : TVTColumnWidthDblClickResizeEvent);
    Procedure EnableVTColumnWidthDblClickResizeEvent(AEvent, AEnabledEvent : TVTColumnWidthDblClickResizeEvent);

    Procedure RegisterVTColumnWidthTrackingEvent(AEvent, ANewEvent : TVTColumnWidthTrackingEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTColumnWidthTrackingEvent(AEvent, AOldEvent : TVTColumnWidthTrackingEvent);
    Procedure DisableVTColumnWidthTrackingEvent(AEvent, ADisabledEvent : TVTColumnWidthTrackingEvent);
    Procedure EnableVTColumnWidthTrackingEvent(AEvent, AEnabledEvent : TVTColumnWidthTrackingEvent);

    Procedure RegisterVTCompareEvent(AEvent, ANewEvent : TVTCompareEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTCompareEvent(AEvent, AOldEvent : TVTCompareEvent);
    Procedure DisableVTCompareEvent(AEvent, ADisabledEvent : TVTCompareEvent);
    Procedure EnableVTCompareEvent(AEvent, AEnabledEvent : TVTCompareEvent);

    Procedure RegisterVTCreateDataObjectEvent(AEvent, ANewEvent : TVTCreateDataObjectEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTCreateDataObjectEvent(AEvent, AOldEvent : TVTCreateDataObjectEvent);
    Procedure DisableVTCreateDataObjectEvent(AEvent, ADisabledEvent : TVTCreateDataObjectEvent);
    Procedure EnableVTCreateDataObjectEvent(AEvent, AEnabledEvent : TVTCreateDataObjectEvent);

    Procedure RegisterVTCreateDragManagerEvent(AEvent, ANewEvent : TVTCreateDragManagerEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTCreateDragManagerEvent(AEvent, AOldEvent : TVTCreateDragManagerEvent);
    Procedure DisableVTCreateDragManagerEvent(AEvent, ADisabledEvent : TVTCreateDragManagerEvent);
    Procedure EnableVTCreateDragManagerEvent(AEvent, AEnabledEvent : TVTCreateDragManagerEvent);

    Procedure RegisterVTCreateEditorEvent(AEvent, ANewEvent : TVTCreateEditorEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTCreateEditorEvent(AEvent, AOldEvent : TVTCreateEditorEvent);
    Procedure DisableVTCreateEditorEvent(AEvent, ADisabledEvent : TVTCreateEditorEvent);
    Procedure EnableVTCreateEditorEvent(AEvent, AEnabledEvent : TVTCreateEditorEvent);

    Procedure RegisterVTDragAllowedEvent(AEvent, ANewEvent : TVTDragAllowedEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTDragAllowedEvent(AEvent, AOldEvent : TVTDragAllowedEvent);
    Procedure DisableVTDragAllowedEvent(AEvent, ADisabledEvent : TVTDragAllowedEvent);
    Procedure EnableVTDragAllowedEvent(AEvent, AEnabledEvent : TVTDragAllowedEvent);

    Procedure RegisterVTDragDropEvent(AEvent, ANewEvent : TVTDragDropEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTDragDropEvent(AEvent, AOldEvent : TVTDragDropEvent);
    Procedure DisableVTDragDropEvent(AEvent, ADisabledEvent : TVTDragDropEvent);
    Procedure EnableVTDragDropEvent(AEvent, AEnabledEvent : TVTDragDropEvent);

    Procedure RegisterVTDragOverEvent(AEvent, ANewEvent : TVTDragOverEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTDragOverEvent(AEvent, AOldEvent : TVTDragOverEvent);
    Procedure DisableVTDragOverEvent(AEvent, ADisabledEvent : TVTDragOverEvent);
    Procedure EnableVTDragOverEvent(AEvent, AEnabledEvent : TVTDragOverEvent);

    Procedure RegisterVTDrawHintEvent(AEvent, ANewEvent : TVTDrawHintEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTDrawHintEvent(AEvent, AOldEvent : TVTDrawHintEvent);
    Procedure DisableVTDrawHintEvent(AEvent, ADisabledEvent : TVTDrawHintEvent);
    Procedure EnableVTDrawHintEvent(AEvent, AEnabledEvent : TVTDrawHintEvent);

    Procedure RegisterVTDrawTextEvent(AEvent, ANewEvent : TVTDrawTextEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTDrawTextEvent(AEvent, AOldEvent : TVTDrawTextEvent);
    Procedure DisableVTDrawTextEvent(AEvent, ADisabledEvent : TVTDrawTextEvent);
    Procedure EnableVTDrawTextEvent(AEvent, AEnabledEvent : TVTDrawTextEvent);

    Procedure RegisterVTEditCancelEvent(AEvent, ANewEvent : TVTEditCancelEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTEditCancelEvent(AEvent, AOldEvent : TVTEditCancelEvent);
    Procedure DisableVTEditCancelEvent(AEvent, ADisabledEvent : TVTEditCancelEvent);
    Procedure EnableVTEditCancelEvent(AEvent, AEnabledEvent : TVTEditCancelEvent);

    Procedure RegisterVTEditChangeEvent(AEvent, ANewEvent : TVTEditChangeEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTEditChangeEvent(AEvent, AOldEvent : TVTEditChangeEvent);
    Procedure DisableVTEditChangeEvent(AEvent, ADisabledEvent : TVTEditChangeEvent);
    Procedure EnableVTEditChangeEvent(AEvent, AEnabledEvent : TVTEditChangeEvent);

    Procedure RegisterVTEditChangingEvent(AEvent, ANewEvent : TVTEditChangingEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTEditChangingEvent(AEvent, AOldEvent : TVTEditChangingEvent);
    Procedure DisableVTEditChangingEvent(AEvent, ADisabledEvent : TVTEditChangingEvent);
    Procedure EnableVTEditChangingEvent(AEvent, AEnabledEvent : TVTEditChangingEvent);

    Procedure RegisterVTOperationEvent(AEvent, ANewEvent : TVTOperationEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTOperationEvent(AEvent, AOldEvent : TVTOperationEvent);
    Procedure DisableVTOperationEvent(AEvent, ADisabledEvent : TVTOperationEvent);
    Procedure EnableVTOperationEvent(AEvent, AEnabledEvent : TVTOperationEvent);

    Procedure RegisterVTFocusChangeEvent(AEvent, ANewEvent : TVTFocusChangeEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTFocusChangeEvent(AEvent, AOldEvent : TVTFocusChangeEvent);
    Procedure DisableVTFocusChangeEvent(AEvent, ADisabledEvent : TVTFocusChangeEvent);
    Procedure EnableVTFocusChangeEvent(AEvent, AEnabledEvent : TVTFocusChangeEvent);

    Procedure RegisterVTFocusChangingEvent(AEvent, ANewEvent : TVTFocusChangingEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTFocusChangingEvent(AEvent, AOldEvent : TVTFocusChangingEvent);
    Procedure DisableVTFocusChangingEvent(AEvent, ADisabledEvent : TVTFocusChangingEvent);
    Procedure EnableVTFocusChangingEvent(AEvent, AEnabledEvent : TVTFocusChangingEvent);

    Procedure RegisterVTFreeNodeEvent(AEvent, ANewEvent : TVTFreeNodeEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTFreeNodeEvent(AEvent, AOldEvent : TVTFreeNodeEvent);
    Procedure DisableVTFreeNodeEvent(AEvent, ADisabledEvent : TVTFreeNodeEvent);
    Procedure EnableVTFreeNodeEvent(AEvent, AEnabledEvent : TVTFreeNodeEvent);

    Procedure RegisterVTGetCellIsEmptyEvent(AEvent, ANewEvent : TVTGetCellIsEmptyEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTGetCellIsEmptyEvent(AEvent, AOldEvent : TVTGetCellIsEmptyEvent);
    Procedure DisableVTGetCellIsEmptyEvent(AEvent, ADisabledEvent : TVTGetCellIsEmptyEvent);
    Procedure EnableVTGetCellIsEmptyEvent(AEvent, AEnabledEvent : TVTGetCellIsEmptyEvent);

    Procedure RegisterVSTGetCellTextEvent(AEvent, ANewEvent : TVSTGetCellTextEvent; Const Index : Integer = -1);
    Procedure UnRegisterVSTGetCellTextEvent(AEvent, AOldEvent : TVSTGetCellTextEvent);
    Procedure DisableVSTGetCellTextEvent(AEvent, ADisabledEvent : TVSTGetCellTextEvent);
    Procedure EnableVSTGetCellTextEvent(AEvent, AEnabledEvent : TVSTGetCellTextEvent);

    Procedure RegisterVTGetCursorEvent(AEvent, ANewEvent : TVTGetCursorEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTGetCursorEvent(AEvent, AOldEvent : TVTGetCursorEvent);
    Procedure DisableVTGetCursorEvent(AEvent, ADisabledEvent : TVTGetCursorEvent);
    Procedure EnableVTGetCursorEvent(AEvent, AEnabledEvent : TVTGetCursorEvent);

    Procedure RegisterVTGetHeaderCursorEvent(AEvent, ANewEvent : TVTGetHeaderCursorEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTGetHeaderCursorEvent(AEvent, AOldEvent : TVTGetHeaderCursorEvent);
    Procedure DisableVTGetHeaderCursorEvent(AEvent, ADisabledEvent : TVTGetHeaderCursorEvent);
    Procedure EnableVTGetHeaderCursorEvent(AEvent, AEnabledEvent : TVTGetHeaderCursorEvent);

    Procedure RegisterVTHelpContextEvent(AEvent, ANewEvent : TVTHelpContextEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTHelpContextEvent(AEvent, AOldEvent : TVTHelpContextEvent);
    Procedure DisableVTHelpContextEvent(AEvent, ADisabledEvent : TVTHelpContextEvent);
    Procedure EnableVTHelpContextEvent(AEvent, AEnabledEvent : TVTHelpContextEvent);

    Procedure RegisterVSTGetHintEvent(AEvent, ANewEvent : TVSTGetHintEvent; Const Index : Integer = -1);
    Procedure UnRegisterVSTGetHintEvent(AEvent, AOldEvent : TVSTGetHintEvent);
    Procedure DisableVSTGetHintEvent(AEvent, ADisabledEvent : TVSTGetHintEvent);
    Procedure EnableVSTGetHintEvent(AEvent, AEnabledEvent : TVSTGetHintEvent);

    Procedure RegisterVTHintKindEvent(AEvent, ANewEvent : TVTHintKindEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTHintKindEvent(AEvent, AOldEvent : TVTHintKindEvent);
    Procedure DisableVTHintKindEvent(AEvent, ADisabledEvent : TVTHintKindEvent);
    Procedure EnableVTHintKindEvent(AEvent, AEnabledEvent : TVTHintKindEvent);

    Procedure RegisterVTGetHintSizeEvent(AEvent, ANewEvent : TVTGetHintSizeEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTGetHintSizeEvent(AEvent, AOldEvent : TVTGetHintSizeEvent);
    Procedure DisableVTGetHintSizeEvent(AEvent, ADisabledEvent : TVTGetHintSizeEvent);
    Procedure EnableVTGetHintSizeEvent(AEvent, AEnabledEvent : TVTGetHintSizeEvent);

    Procedure RegisterVTGetImageEvent(AEvent, ANewEvent : TVTGetImageEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTGetImageEvent(AEvent, AOldEvent : TVTGetImageEvent);
    Procedure DisableVTGetImageEvent(AEvent, ADisabledEvent : TVTGetImageEvent);
    Procedure EnableVTGetImageEvent(AEvent, AEnabledEvent : TVTGetImageEvent);

    Procedure RegisterVTGetImageExEvent(AEvent, ANewEvent : TVTGetImageExEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTGetImageExEvent(AEvent, AOldEvent : TVTGetImageExEvent);
    Procedure DisableVTGetImageExEvent(AEvent, ADisabledEvent : TVTGetImageExEvent);
    Procedure EnableVTGetImageExEvent(AEvent, AEnabledEvent : TVTGetImageExEvent);

    Procedure RegisterVTGetImageTextEvent(AEvent, ANewEvent : TVTGetImageTextEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTGetImageTextEvent(AEvent, AOldEvent : TVTGetImageTextEvent);
    Procedure DisableVTGetImageTextEvent(AEvent, ADisabledEvent : TVTGetImageTextEvent);
    Procedure EnableVTGetImageTextEvent(AEvent, AEnabledEvent : TVTGetImageTextEvent);

    Procedure RegisterVTGetLineStyleEvent(AEvent, ANewEvent : TVTGetLineStyleEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTGetLineStyleEvent(AEvent, AOldEvent : TVTGetLineStyleEvent);
    Procedure DisableVTGetLineStyleEvent(AEvent, ADisabledEvent : TVTGetLineStyleEvent);
    Procedure EnableVTGetLineStyleEvent(AEvent, AEnabledEvent : TVTGetLineStyleEvent);

    Procedure RegisterVTGetNodeDataSizeEvent(AEvent, ANewEvent : TVTGetNodeDataSizeEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTGetNodeDataSizeEvent(AEvent, AOldEvent : TVTGetNodeDataSizeEvent);
    Procedure DisableVTGetNodeDataSizeEvent(AEvent, ADisabledEvent : TVTGetNodeDataSizeEvent);
    Procedure EnableVTGetNodeDataSizeEvent(AEvent, AEnabledEvent : TVTGetNodeDataSizeEvent);

    Procedure RegisterVTPopupEvent(AEvent, ANewEvent : TVTPopupEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTPopupEvent(AEvent, AOldEvent : TVTPopupEvent);
    Procedure DisableVTPopupEvent(AEvent, ADisabledEvent : TVTPopupEvent);
    Procedure EnableVTPopupEvent(AEvent, AEnabledEvent : TVTPopupEvent);

    Procedure RegisterVSTGetTextEvent(AEvent, ANewEvent : TVSTGetTextEvent; Const Index : Integer = -1);
    Procedure UnRegisterVSTGetTextEvent(AEvent, AOldEvent : TVSTGetTextEvent);
    Procedure DisableVSTGetTextEvent(AEvent, ADisabledEvent : TVSTGetTextEvent);
    Procedure EnableVSTGetTextEvent(AEvent, AEnabledEvent : TVSTGetTextEvent);

    Procedure RegisterVTGetUserClipboardFormatsEvent(AEvent, ANewEvent : TVTGetUserClipboardFormatsEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTGetUserClipboardFormatsEvent(AEvent, AOldEvent : TVTGetUserClipboardFormatsEvent);
    Procedure DisableVTGetUserClipboardFormatsEvent(AEvent, ADisabledEvent : TVTGetUserClipboardFormatsEvent);
    Procedure EnableVTGetUserClipboardFormatsEvent(AEvent, AEnabledEvent : TVTGetUserClipboardFormatsEvent);

    Procedure RegisterVTHeaderClickEvent(AEvent, ANewEvent : TVTHeaderClickEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTHeaderClickEvent(AEvent, AOldEvent : TVTHeaderClickEvent);
    Procedure DisableVTHeaderClickEvent(AEvent, ADisabledEvent : TVTHeaderClickEvent);
    Procedure EnableVTHeaderClickEvent(AEvent, AEnabledEvent : TVTHeaderClickEvent);

    Procedure RegisterVTHeaderDraggedEvent(AEvent, ANewEvent : TVTHeaderDraggedEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTHeaderDraggedEvent(AEvent, AOldEvent : TVTHeaderDraggedEvent);
    Procedure DisableVTHeaderDraggedEvent(AEvent, ADisabledEvent : TVTHeaderDraggedEvent);
    Procedure EnableVTHeaderDraggedEvent(AEvent, AEnabledEvent : TVTHeaderDraggedEvent);

    Procedure RegisterVTHeaderDraggedOutEvent(AEvent, ANewEvent : TVTHeaderDraggedOutEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTHeaderDraggedOutEvent(AEvent, AOldEvent : TVTHeaderDraggedOutEvent);
    Procedure DisableVTHeaderDraggedOutEvent(AEvent, ADisabledEvent : TVTHeaderDraggedOutEvent);
    Procedure EnableVTHeaderDraggedOutEvent(AEvent, AEnabledEvent : TVTHeaderDraggedOutEvent);

    Procedure RegisterVTHeaderDraggingEvent(AEvent, ANewEvent : TVTHeaderDraggingEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTHeaderDraggingEvent(AEvent, AOldEvent : TVTHeaderDraggingEvent);
    Procedure DisableVTHeaderDraggingEvent(AEvent, ADisabledEvent : TVTHeaderDraggingEvent);
    Procedure EnableVTHeaderDraggingEvent(AEvent, AEnabledEvent : TVTHeaderDraggingEvent);

    Procedure RegisterVTHeaderPaintEvent(AEvent, ANewEvent : TVTHeaderPaintEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTHeaderPaintEvent(AEvent, AOldEvent : TVTHeaderPaintEvent);
    Procedure DisableVTHeaderPaintEvent(AEvent, ADisabledEvent : TVTHeaderPaintEvent);
    Procedure EnableVTHeaderPaintEvent(AEvent, AEnabledEvent : TVTHeaderPaintEvent);

    Procedure RegisterVTHeaderPaintQueryElementsEvent(AEvent, ANewEvent : TVTHeaderPaintQueryElementsEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTHeaderPaintQueryElementsEvent(AEvent, AOldEvent : TVTHeaderPaintQueryElementsEvent);
    Procedure DisableVTHeaderPaintQueryElementsEvent(AEvent, ADisabledEvent : TVTHeaderPaintQueryElementsEvent);
    Procedure EnableVTHeaderPaintQueryElementsEvent(AEvent, AEnabledEvent : TVTHeaderPaintQueryElementsEvent);

    Procedure RegisterVTHeaderHeightDblClickResizeEvent(AEvent, ANewEvent : TVTHeaderHeightDblClickResizeEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTHeaderHeightDblClickResizeEvent(AEvent, AOldEvent : TVTHeaderHeightDblClickResizeEvent);
    Procedure DisableVTHeaderHeightDblClickResizeEvent(AEvent, ADisabledEvent : TVTHeaderHeightDblClickResizeEvent);
    Procedure EnableVTHeaderHeightDblClickResizeEvent(AEvent, AEnabledEvent : TVTHeaderHeightDblClickResizeEvent);

    Procedure RegisterVTHeaderHeightTrackingEvent(AEvent, ANewEvent : TVTHeaderHeightTrackingEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTHeaderHeightTrackingEvent(AEvent, AOldEvent : TVTHeaderHeightTrackingEvent);
    Procedure DisableVTHeaderHeightTrackingEvent(AEvent, ADisabledEvent : TVTHeaderHeightTrackingEvent);
    Procedure EnableVTHeaderHeightTrackingEvent(AEvent, AEnabledEvent : TVTHeaderHeightTrackingEvent);

    Procedure RegisterVTHeaderMouseEvent(AEvent, ANewEvent : TVTHeaderMouseEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTHeaderMouseEvent(AEvent, AOldEvent : TVTHeaderMouseEvent);
    Procedure DisableVTHeaderMouseEvent(AEvent, ADisabledEvent : TVTHeaderMouseEvent);
    Procedure EnableVTHeaderMouseEvent(AEvent, AEnabledEvent : TVTHeaderMouseEvent);

    Procedure RegisterVTHeaderMouseMoveEvent(AEvent, ANewEvent : TVTHeaderMouseMoveEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTHeaderMouseMoveEvent(AEvent, AOldEvent : TVTHeaderMouseMoveEvent);
    Procedure DisableVTHeaderMouseMoveEvent(AEvent, ADisabledEvent : TVTHeaderMouseMoveEvent);
    Procedure EnableVTHeaderMouseMoveEvent(AEvent, AEnabledEvent : TVTHeaderMouseMoveEvent);

    Procedure RegisterVTHotNodeChangeEvent(AEvent, ANewEvent : TVTHotNodeChangeEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTHotNodeChangeEvent(AEvent, AOldEvent : TVTHotNodeChangeEvent);
    Procedure DisableVTHotNodeChangeEvent(AEvent, ADisabledEvent : TVTHotNodeChangeEvent);
    Procedure EnableVTHotNodeChangeEvent(AEvent, AEnabledEvent : TVTHotNodeChangeEvent);

    Procedure RegisterVTIncrementalSearchEvent(AEvent, ANewEvent : TVTIncrementalSearchEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTIncrementalSearchEvent(AEvent, AOldEvent : TVTIncrementalSearchEvent);
    Procedure DisableVTIncrementalSearchEvent(AEvent, ADisabledEvent : TVTIncrementalSearchEvent);
    Procedure EnableVTIncrementalSearchEvent(AEvent, AEnabledEvent : TVTIncrementalSearchEvent);

    Procedure RegisterVTInitChildrenEvent(AEvent, ANewEvent : TVTInitChildrenEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTInitChildrenEvent(AEvent, AOldEvent : TVTInitChildrenEvent);
    Procedure DisableVTInitChildrenEvent(AEvent, ADisabledEvent : TVTInitChildrenEvent);
    Procedure EnableVTInitChildrenEvent(AEvent, AEnabledEvent : TVTInitChildrenEvent);

    Procedure RegisterVTInitNodeEvent(AEvent, ANewEvent : TVTInitNodeEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTInitNodeEvent(AEvent, AOldEvent : TVTInitNodeEvent);
    Procedure DisableVTInitNodeEvent(AEvent, ADisabledEvent : TVTInitNodeEvent);
    Procedure EnableVTInitNodeEvent(AEvent, AEnabledEvent : TVTInitNodeEvent);

    Procedure RegisterVTKeyActionEvent(AEvent, ANewEvent : TVTKeyActionEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTKeyActionEvent(AEvent, AOldEvent : TVTKeyActionEvent);
    Procedure DisableVTKeyActionEvent(AEvent, ADisabledEvent : TVTKeyActionEvent);
    Procedure EnableVTKeyActionEvent(AEvent, AEnabledEvent : TVTKeyActionEvent);

    Procedure RegisterVTSaveNodeEvent(AEvent, ANewEvent : TVTSaveNodeEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTSaveNodeEvent(AEvent, AOldEvent : TVTSaveNodeEvent);
    Procedure DisableVTSaveNodeEvent(AEvent, ADisabledEvent : TVTSaveNodeEvent);
    Procedure EnableVTSaveNodeEvent(AEvent, AEnabledEvent : TVTSaveNodeEvent);

    Procedure RegisterVTSaveTreeEvent(AEvent, ANewEvent : TVTSaveTreeEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTSaveTreeEvent(AEvent, AOldEvent : TVTSaveTreeEvent);
    Procedure DisableVTSaveTreeEvent(AEvent, ADisabledEvent : TVTSaveTreeEvent);
    Procedure EnableVTSaveTreeEvent(AEvent, AEnabledEvent : TVTSaveTreeEvent);

    Procedure RegisterVTMeasureItemEvent(AEvent, ANewEvent : TVTMeasureItemEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTMeasureItemEvent(AEvent, AOldEvent : TVTMeasureItemEvent);
    Procedure DisableVTMeasureItemEvent(AEvent, ADisabledEvent : TVTMeasureItemEvent);
    Procedure EnableVTMeasureItemEvent(AEvent, AEnabledEvent : TVTMeasureItemEvent);

    Procedure RegisterVTMeasureTextEvent(AEvent, ANewEvent : TVTMeasureTextEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTMeasureTextEvent(AEvent, AOldEvent : TVTMeasureTextEvent);
    Procedure DisableVTMeasureTextEvent(AEvent, ADisabledEvent : TVTMeasureTextEvent);
    Procedure EnableVTMeasureTextEvent(AEvent, AEnabledEvent : TVTMeasureTextEvent);

    Procedure RegisterMouseWheelEvent(AEvent, ANewEvent : TMouseWheelEvent; Const Index : Integer = -1);
    Procedure UnRegisterMouseWheelEvent(AEvent, AOldEvent : TMouseWheelEvent);
    Procedure DisableMouseWheelEvent(AEvent, ADisabledEvent : TMouseWheelEvent);
    Procedure EnableMouseWheelEvent(AEvent, AEnabledEvent : TMouseWheelEvent);

    Procedure RegisterVSTNewTextEvent(AEvent, ANewEvent : TVSTNewTextEvent; Const Index : Integer = -1);
    Procedure UnRegisterVSTNewTextEvent(AEvent, AOldEvent : TVSTNewTextEvent);
    Procedure DisableVSTNewTextEvent(AEvent, ADisabledEvent : TVSTNewTextEvent);
    Procedure EnableVSTNewTextEvent(AEvent, AEnabledEvent : TVSTNewTextEvent);

    Procedure RegisterVTNodeClickEvent(AEvent, ANewEvent : TVTNodeClickEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTNodeClickEvent(AEvent, AOldEvent : TVTNodeClickEvent);
    Procedure DisableVTNodeClickEvent(AEvent, ADisabledEvent : TVTNodeClickEvent);
    Procedure EnableVTNodeClickEvent(AEvent, AEnabledEvent : TVTNodeClickEvent);

    Procedure RegisterVTNodeCopiedEvent(AEvent, ANewEvent : TVTNodeCopiedEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTNodeCopiedEvent(AEvent, AOldEvent : TVTNodeCopiedEvent);
    Procedure DisableVTNodeCopiedEvent(AEvent, ADisabledEvent : TVTNodeCopiedEvent);
    Procedure EnableVTNodeCopiedEvent(AEvent, AEnabledEvent : TVTNodeCopiedEvent);

    Procedure RegisterVTNodeCopyingEvent(AEvent, ANewEvent : TVTNodeCopyingEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTNodeCopyingEvent(AEvent, AOldEvent : TVTNodeCopyingEvent);
    Procedure DisableVTNodeCopyingEvent(AEvent, ADisabledEvent : TVTNodeCopyingEvent);
    Procedure EnableVTNodeCopyingEvent(AEvent, AEnabledEvent : TVTNodeCopyingEvent);

    Procedure RegisterVTNodeHeightDblClickResizeEvent(AEvent, ANewEvent : TVTNodeHeightDblClickResizeEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTNodeHeightDblClickResizeEvent(AEvent, AOldEvent : TVTNodeHeightDblClickResizeEvent);
    Procedure DisableVTNodeHeightDblClickResizeEvent(AEvent, ADisabledEvent : TVTNodeHeightDblClickResizeEvent);
    Procedure EnableVTNodeHeightDblClickResizeEvent(AEvent, AEnabledEvent : TVTNodeHeightDblClickResizeEvent);

    Procedure RegisterVTNodeHeightTrackingEvent(AEvent, ANewEvent : TVTNodeHeightTrackingEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTNodeHeightTrackingEvent(AEvent, AOldEvent : TVTNodeHeightTrackingEvent);
    Procedure DisableVTNodeHeightTrackingEvent(AEvent, ADisabledEvent : TVTNodeHeightTrackingEvent);
    Procedure EnableVTNodeHeightTrackingEvent(AEvent, AEnabledEvent : TVTNodeHeightTrackingEvent);

    Procedure RegisterVTNodeMovedEvent(AEvent, ANewEvent : TVTNodeMovedEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTNodeMovedEvent(AEvent, AOldEvent : TVTNodeMovedEvent);
    Procedure DisableVTNodeMovedEvent(AEvent, ADisabledEvent : TVTNodeMovedEvent);
    Procedure EnableVTNodeMovedEvent(AEvent, AEnabledEvent : TVTNodeMovedEvent);

    Procedure RegisterVTNodeMovingEvent(AEvent, ANewEvent : TVTNodeMovingEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTNodeMovingEvent(AEvent, AOldEvent : TVTNodeMovingEvent);
    Procedure DisableVTNodeMovingEvent(AEvent, ADisabledEvent : TVTNodeMovingEvent);
    Procedure EnableVTNodeMovingEvent(AEvent, AEnabledEvent : TVTNodeMovingEvent);

    Procedure RegisterVTBackgroundPaintEvent(AEvent, ANewEvent : TVTBackgroundPaintEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTBackgroundPaintEvent(AEvent, AOldEvent : TVTBackgroundPaintEvent);
    Procedure DisableVTBackgroundPaintEvent(AEvent, ADisabledEvent : TVTBackgroundPaintEvent);
    Procedure EnableVTBackgroundPaintEvent(AEvent, AEnabledEvent : TVTBackgroundPaintEvent);

    Procedure RegisterVTPaintText(AEvent, ANewEvent : TVTPaintText; Const Index : Integer = -1);
    Procedure UnRegisterVTPaintText(AEvent, AOldEvent : TVTPaintText);
    Procedure DisableVTPaintText(AEvent, ADisabledEvent : TVTPaintText);
    Procedure EnableVTPaintText(AEvent, AEnabledEvent : TVTPaintText);

    Procedure RegisterVTPrepareButtonImagesEvent(AEvent, ANewEvent : TVTPrepareButtonImagesEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTPrepareButtonImagesEvent(AEvent, AOldEvent : TVTPrepareButtonImagesEvent);
    Procedure DisableVTPrepareButtonImagesEvent(AEvent, ADisabledEvent : TVTPrepareButtonImagesEvent);
    Procedure EnableVTPrepareButtonImagesEvent(AEvent, AEnabledEvent : TVTPrepareButtonImagesEvent);

    Procedure RegisterVTRemoveFromSelectionEvent(AEvent, ANewEvent : TVTRemoveFromSelectionEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTRemoveFromSelectionEvent(AEvent, AOldEvent : TVTRemoveFromSelectionEvent);
    Procedure DisableVTRemoveFromSelectionEvent(AEvent, ADisabledEvent : TVTRemoveFromSelectionEvent);
    Procedure EnableVTRemoveFromSelectionEvent(AEvent, AEnabledEvent : TVTRemoveFromSelectionEvent);

    Procedure RegisterVTRenderOLEDataEvent(AEvent, ANewEvent : TVTRenderOLEDataEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTRenderOLEDataEvent(AEvent, AOldEvent : TVTRenderOLEDataEvent);
    Procedure DisableVTRenderOLEDataEvent(AEvent, ADisabledEvent : TVTRenderOLEDataEvent);
    Procedure EnableVTRenderOLEDataEvent(AEvent, AEnabledEvent : TVTRenderOLEDataEvent);

    Procedure RegisterVTScrollEvent(AEvent, ANewEvent : TVTScrollEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTScrollEvent(AEvent, AOldEvent : TVTScrollEvent);
    Procedure DisableVTScrollEvent(AEvent, ADisabledEvent : TVTScrollEvent);
    Procedure EnableVTScrollEvent(AEvent, AEnabledEvent : TVTScrollEvent);

    Procedure RegisterVSTShortenStringEvent(AEvent, ANewEvent : TVSTShortenStringEvent; Const Index : Integer = -1);
    Procedure UnRegisterVSTShortenStringEvent(AEvent, AOldEvent : TVSTShortenStringEvent);
    Procedure DisableVSTShortenStringEvent(AEvent, ADisabledEvent : TVSTShortenStringEvent);
    Procedure EnableVSTShortenStringEvent(AEvent, AEnabledEvent : TVSTShortenStringEvent);

    Procedure RegisterVTScrollBarShowEvent(AEvent, ANewEvent : TVTScrollBarShowEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTScrollBarShowEvent(AEvent, AOldEvent : TVTScrollBarShowEvent);
    Procedure DisableVTScrollBarShowEvent(AEvent, ADisabledEvent : TVTScrollBarShowEvent);
    Procedure EnableVTScrollBarShowEvent(AEvent, AEnabledEvent : TVTScrollBarShowEvent);

    Procedure RegisterVTStateChangeEvent(AEvent, ANewEvent : TVTStateChangeEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTStateChangeEvent(AEvent, AOldEvent : TVTStateChangeEvent);
    Procedure DisableVTStateChangeEvent(AEvent, ADisabledEvent : TVTStateChangeEvent);
    Procedure EnableVTStateChangeEvent(AEvent, AEnabledEvent : TVTStateChangeEvent);

    Procedure RegisterVTStructureChangeEvent(AEvent, ANewEvent : TVTStructureChangeEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTStructureChangeEvent(AEvent, AOldEvent : TVTStructureChangeEvent);
    Procedure DisableVTStructureChangeEvent(AEvent, ADisabledEvent : TVTStructureChangeEvent);
    Procedure EnableVTStructureChangeEvent(AEvent, AEnabledEvent : TVTStructureChangeEvent);

    Procedure RegisterVTUpdatingEvent(AEvent, ANewEvent : TVTUpdatingEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTUpdatingEvent(AEvent, AOldEvent : TVTUpdatingEvent);
    Procedure DisableVTUpdatingEvent(AEvent, ADisabledEvent : TVTUpdatingEvent);
    Procedure EnableVTUpdatingEvent(AEvent, AEnabledEvent : TVTUpdatingEvent);

  End;

  TVirtualStringTreeEventDispatcher = Class(TCustomEventDispatcher, IVirtualStringTreeEventDispatcher)
  Protected
    Procedure InitEvents(); OverRide;

    Procedure RegisterVTAddToSelectionEvent(AEvent, ANewEvent : TVTAddToSelectionEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTAddToSelectionEvent(AEvent, AOldEvent : TVTAddToSelectionEvent);
    Procedure DisableVTAddToSelectionEvent(AEvent, ADisabledEvent : TVTAddToSelectionEvent);
    Procedure EnableVTAddToSelectionEvent(AEvent, AEnabledEvent : TVTAddToSelectionEvent);

    Procedure RegisterVTAdvancedHeaderPaintEvent(AEvent, ANewEvent : TVTAdvancedHeaderPaintEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTAdvancedHeaderPaintEvent(AEvent, AOldEvent : TVTAdvancedHeaderPaintEvent);
    Procedure DisableVTAdvancedHeaderPaintEvent(AEvent, ADisabledEvent : TVTAdvancedHeaderPaintEvent);
    Procedure EnableVTAdvancedHeaderPaintEvent(AEvent, AEnabledEvent : TVTAdvancedHeaderPaintEvent);

    Procedure RegisterVTAfterAutoFitColumnEvent(AEvent, ANewEvent : TVTAfterAutoFitColumnEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTAfterAutoFitColumnEvent(AEvent, AOldEvent : TVTAfterAutoFitColumnEvent);
    Procedure DisableVTAfterAutoFitColumnEvent(AEvent, ADisabledEvent : TVTAfterAutoFitColumnEvent);
    Procedure EnableVTAfterAutoFitColumnEvent(AEvent, AEnabledEvent : TVTAfterAutoFitColumnEvent);

    Procedure RegisterVTAfterAutoFitColumnsEvent(AEvent, ANewEvent : TVTAfterAutoFitColumnsEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTAfterAutoFitColumnsEvent(AEvent, AOldEvent : TVTAfterAutoFitColumnsEvent);
    Procedure DisableVTAfterAutoFitColumnsEvent(AEvent, ADisabledEvent : TVTAfterAutoFitColumnsEvent);
    Procedure EnableVTAfterAutoFitColumnsEvent(AEvent, AEnabledEvent : TVTAfterAutoFitColumnsEvent);

    Procedure RegisterVTAfterCellPaintEvent(AEvent, ANewEvent : TVTAfterCellPaintEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTAfterCellPaintEvent(AEvent, AOldEvent : TVTAfterCellPaintEvent);
    Procedure DisableVTAfterCellPaintEvent(AEvent, ADisabledEvent : TVTAfterCellPaintEvent);
    Procedure EnableVTAfterCellPaintEvent(AEvent, AEnabledEvent : TVTAfterCellPaintEvent);

    Procedure RegisterVTColumnExportEvent(AEvent, ANewEvent : TVTColumnExportEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTColumnExportEvent(AEvent, AOldEvent : TVTColumnExportEvent);
    Procedure DisableVTColumnExportEvent(AEvent, ADisabledEvent : TVTColumnExportEvent);
    Procedure EnableVTColumnExportEvent(AEvent, AEnabledEvent : TVTColumnExportEvent);

    Procedure RegisterVTAfterColumnWidthTrackingEvent(AEvent, ANewEvent : TVTAfterColumnWidthTrackingEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTAfterColumnWidthTrackingEvent(AEvent, AOldEvent : TVTAfterColumnWidthTrackingEvent);
    Procedure DisableVTAfterColumnWidthTrackingEvent(AEvent, ADisabledEvent : TVTAfterColumnWidthTrackingEvent);
    Procedure EnableVTAfterColumnWidthTrackingEvent(AEvent, AEnabledEvent : TVTAfterColumnWidthTrackingEvent);

    Procedure RegisterVTAfterGetMaxColumnWidthEvent(AEvent, ANewEvent : TVTAfterGetMaxColumnWidthEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTAfterGetMaxColumnWidthEvent(AEvent, AOldEvent : TVTAfterGetMaxColumnWidthEvent);
    Procedure DisableVTAfterGetMaxColumnWidthEvent(AEvent, ADisabledEvent : TVTAfterGetMaxColumnWidthEvent);
    Procedure EnableVTAfterGetMaxColumnWidthEvent(AEvent, AEnabledEvent : TVTAfterGetMaxColumnWidthEvent);

    Procedure RegisterVTTreeExportEvent(AEvent, ANewEvent : TVTTreeExportEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTTreeExportEvent(AEvent, AOldEvent : TVTTreeExportEvent);
    Procedure DisableVTTreeExportEvent(AEvent, ADisabledEvent : TVTTreeExportEvent);
    Procedure EnableVTTreeExportEvent(AEvent, AEnabledEvent : TVTTreeExportEvent);

    Procedure RegisterVTAfterHeaderHeightTrackingEvent(AEvent, ANewEvent : TVTAfterHeaderHeightTrackingEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTAfterHeaderHeightTrackingEvent(AEvent, AOldEvent : TVTAfterHeaderHeightTrackingEvent);
    Procedure DisableVTAfterHeaderHeightTrackingEvent(AEvent, ADisabledEvent : TVTAfterHeaderHeightTrackingEvent);
    Procedure EnableVTAfterHeaderHeightTrackingEvent(AEvent, AEnabledEvent : TVTAfterHeaderHeightTrackingEvent);

    Procedure RegisterVTAfterItemEraseEvent(AEvent, ANewEvent : TVTAfterItemEraseEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTAfterItemEraseEvent(AEvent, AOldEvent : TVTAfterItemEraseEvent);
    Procedure DisableVTAfterItemEraseEvent(AEvent, ADisabledEvent : TVTAfterItemEraseEvent);
    Procedure EnableVTAfterItemEraseEvent(AEvent, AEnabledEvent : TVTAfterItemEraseEvent);

    Procedure RegisterVTAfterItemPaintEvent(AEvent, ANewEvent : TVTAfterItemPaintEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTAfterItemPaintEvent(AEvent, AOldEvent : TVTAfterItemPaintEvent);
    Procedure DisableVTAfterItemPaintEvent(AEvent, ADisabledEvent : TVTAfterItemPaintEvent);
    Procedure EnableVTAfterItemPaintEvent(AEvent, AEnabledEvent : TVTAfterItemPaintEvent);

    Procedure RegisterVTNodeExportEvent(AEvent, ANewEvent : TVTNodeExportEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTNodeExportEvent(AEvent, AOldEvent : TVTNodeExportEvent);
    Procedure DisableVTNodeExportEvent(AEvent, ADisabledEvent : TVTNodeExportEvent);
    Procedure EnableVTNodeExportEvent(AEvent, AEnabledEvent : TVTNodeExportEvent);

    Procedure RegisterVTPaintEvent(AEvent, ANewEvent : TVTPaintEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTPaintEvent(AEvent, AOldEvent : TVTPaintEvent);
    Procedure DisableVTPaintEvent(AEvent, ADisabledEvent : TVTPaintEvent);
    Procedure EnableVTPaintEvent(AEvent, AEnabledEvent : TVTPaintEvent);

    Procedure RegisterVTBeforeAutoFitColumnEvent(AEvent, ANewEvent : TVTBeforeAutoFitColumnEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTBeforeAutoFitColumnEvent(AEvent, AOldEvent : TVTBeforeAutoFitColumnEvent);
    Procedure DisableVTBeforeAutoFitColumnEvent(AEvent, ADisabledEvent : TVTBeforeAutoFitColumnEvent);
    Procedure EnableVTBeforeAutoFitColumnEvent(AEvent, AEnabledEvent : TVTBeforeAutoFitColumnEvent);

    Procedure RegisterVTBeforeAutoFitColumnsEvent(AEvent, ANewEvent : TVTBeforeAutoFitColumnsEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTBeforeAutoFitColumnsEvent(AEvent, AOldEvent : TVTBeforeAutoFitColumnsEvent);
    Procedure DisableVTBeforeAutoFitColumnsEvent(AEvent, ADisabledEvent : TVTBeforeAutoFitColumnsEvent);
    Procedure EnableVTBeforeAutoFitColumnsEvent(AEvent, AEnabledEvent : TVTBeforeAutoFitColumnsEvent);

    Procedure RegisterVTBeforeCellPaintEvent(AEvent, ANewEvent : TVTBeforeCellPaintEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTBeforeCellPaintEvent(AEvent, AOldEvent : TVTBeforeCellPaintEvent);
    Procedure DisableVTBeforeCellPaintEvent(AEvent, ADisabledEvent : TVTBeforeCellPaintEvent);
    Procedure EnableVTBeforeCellPaintEvent(AEvent, AEnabledEvent : TVTBeforeCellPaintEvent);

    Procedure RegisterVTBeforeColumnWidthTrackingEvent(AEvent, ANewEvent : TVTBeforeColumnWidthTrackingEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTBeforeColumnWidthTrackingEvent(AEvent, AOldEvent : TVTBeforeColumnWidthTrackingEvent);
    Procedure DisableVTBeforeColumnWidthTrackingEvent(AEvent, ADisabledEvent : TVTBeforeColumnWidthTrackingEvent);
    Procedure EnableVTBeforeColumnWidthTrackingEvent(AEvent, AEnabledEvent : TVTBeforeColumnWidthTrackingEvent);

    Procedure RegisterVTBeforeDrawLineImageEvent(AEvent, ANewEvent : TVTBeforeDrawLineImageEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTBeforeDrawLineImageEvent(AEvent, AOldEvent : TVTBeforeDrawLineImageEvent);
    Procedure DisableVTBeforeDrawLineImageEvent(AEvent, ADisabledEvent : TVTBeforeDrawLineImageEvent);
    Procedure EnableVTBeforeDrawLineImageEvent(AEvent, AEnabledEvent : TVTBeforeDrawLineImageEvent);

    Procedure RegisterVTBeforeGetMaxColumnWidthEvent(AEvent, ANewEvent : TVTBeforeGetMaxColumnWidthEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTBeforeGetMaxColumnWidthEvent(AEvent, AOldEvent : TVTBeforeGetMaxColumnWidthEvent);
    Procedure DisableVTBeforeGetMaxColumnWidthEvent(AEvent, ADisabledEvent : TVTBeforeGetMaxColumnWidthEvent);
    Procedure EnableVTBeforeGetMaxColumnWidthEvent(AEvent, AEnabledEvent : TVTBeforeGetMaxColumnWidthEvent);

    Procedure RegisterVTBeforeHeaderHeightTrackingEvent(AEvent, ANewEvent : TVTBeforeHeaderHeightTrackingEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTBeforeHeaderHeightTrackingEvent(AEvent, AOldEvent : TVTBeforeHeaderHeightTrackingEvent);
    Procedure DisableVTBeforeHeaderHeightTrackingEvent(AEvent, ADisabledEvent : TVTBeforeHeaderHeightTrackingEvent);
    Procedure EnableVTBeforeHeaderHeightTrackingEvent(AEvent, AEnabledEvent : TVTBeforeHeaderHeightTrackingEvent);

    Procedure RegisterVTBeforeItemEraseEvent(AEvent, ANewEvent : TVTBeforeItemEraseEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTBeforeItemEraseEvent(AEvent, AOldEvent : TVTBeforeItemEraseEvent);
    Procedure DisableVTBeforeItemEraseEvent(AEvent, ADisabledEvent : TVTBeforeItemEraseEvent);
    Procedure EnableVTBeforeItemEraseEvent(AEvent, AEnabledEvent : TVTBeforeItemEraseEvent);

    Procedure RegisterVTBeforeItemPaintEvent(AEvent, ANewEvent : TVTBeforeItemPaintEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTBeforeItemPaintEvent(AEvent, AOldEvent : TVTBeforeItemPaintEvent);
    Procedure DisableVTBeforeItemPaintEvent(AEvent, ADisabledEvent : TVTBeforeItemPaintEvent);
    Procedure EnableVTBeforeItemPaintEvent(AEvent, AEnabledEvent : TVTBeforeItemPaintEvent);

    Procedure RegisterCanResizeEvent(AEvent, ANewEvent : TCanResizeEvent; Const Index : Integer = -1);
    Procedure UnRegisterCanResizeEvent(AEvent, AOldEvent : TCanResizeEvent);
    Procedure DisableCanResizeEvent(AEvent, ADisabledEvent : TCanResizeEvent);
    Procedure EnableCanResizeEvent(AEvent, AEnabledEvent : TCanResizeEvent);

    Procedure RegisterVTCanSplitterResizeColumnEvent(AEvent, ANewEvent : TVTCanSplitterResizeColumnEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTCanSplitterResizeColumnEvent(AEvent, AOldEvent : TVTCanSplitterResizeColumnEvent);
    Procedure DisableVTCanSplitterResizeColumnEvent(AEvent, ADisabledEvent : TVTCanSplitterResizeColumnEvent);
    Procedure EnableVTCanSplitterResizeColumnEvent(AEvent, AEnabledEvent : TVTCanSplitterResizeColumnEvent);

    Procedure RegisterVTCanSplitterResizeHeaderEvent(AEvent, ANewEvent : TVTCanSplitterResizeHeaderEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTCanSplitterResizeHeaderEvent(AEvent, AOldEvent : TVTCanSplitterResizeHeaderEvent);
    Procedure DisableVTCanSplitterResizeHeaderEvent(AEvent, ADisabledEvent : TVTCanSplitterResizeHeaderEvent);
    Procedure EnableVTCanSplitterResizeHeaderEvent(AEvent, AEnabledEvent : TVTCanSplitterResizeHeaderEvent);

    Procedure RegisterVTCanSplitterResizeNodeEvent(AEvent, ANewEvent : TVTCanSplitterResizeNodeEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTCanSplitterResizeNodeEvent(AEvent, AOldEvent : TVTCanSplitterResizeNodeEvent);
    Procedure DisableVTCanSplitterResizeNodeEvent(AEvent, ADisabledEvent : TVTCanSplitterResizeNodeEvent);
    Procedure EnableVTCanSplitterResizeNodeEvent(AEvent, AEnabledEvent : TVTCanSplitterResizeNodeEvent);

    Procedure RegisterVTChangeEvent(AEvent, ANewEvent : TVTChangeEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTChangeEvent(AEvent, AOldEvent : TVTChangeEvent);
    Procedure DisableVTChangeEvent(AEvent, ADisabledEvent : TVTChangeEvent);
    Procedure EnableVTChangeEvent(AEvent, AEnabledEvent : TVTChangeEvent);

    Procedure RegisterVTCheckChangingEvent(AEvent, ANewEvent : TVTCheckChangingEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTCheckChangingEvent(AEvent, AOldEvent : TVTCheckChangingEvent);
    Procedure DisableVTCheckChangingEvent(AEvent, ADisabledEvent : TVTCheckChangingEvent);
    Procedure EnableVTCheckChangingEvent(AEvent, AEnabledEvent : TVTCheckChangingEvent);

    Procedure RegisterVTChangingEvent(AEvent, ANewEvent : TVTChangingEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTChangingEvent(AEvent, AOldEvent : TVTChangingEvent);
    Procedure DisableVTChangingEvent(AEvent, ADisabledEvent : TVTChangingEvent);
    Procedure EnableVTChangingEvent(AEvent, AEnabledEvent : TVTChangingEvent);

    Procedure RegisterVTColumnClickEvent(AEvent, ANewEvent : TVTColumnClickEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTColumnClickEvent(AEvent, AOldEvent : TVTColumnClickEvent);
    Procedure DisableVTColumnClickEvent(AEvent, ADisabledEvent : TVTColumnClickEvent);
    Procedure EnableVTColumnClickEvent(AEvent, AEnabledEvent : TVTColumnClickEvent);

    Procedure RegisterVTColumnDblClickEvent(AEvent, ANewEvent : TVTColumnDblClickEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTColumnDblClickEvent(AEvent, AOldEvent : TVTColumnDblClickEvent);
    Procedure DisableVTColumnDblClickEvent(AEvent, ADisabledEvent : TVTColumnDblClickEvent);
    Procedure EnableVTColumnDblClickEvent(AEvent, AEnabledEvent : TVTColumnDblClickEvent);

    Procedure RegisterVTHeaderNotifyEvent(AEvent, ANewEvent : TVTHeaderNotifyEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTHeaderNotifyEvent(AEvent, AOldEvent : TVTHeaderNotifyEvent);
    Procedure DisableVTHeaderNotifyEvent(AEvent, ADisabledEvent : TVTHeaderNotifyEvent);
    Procedure EnableVTHeaderNotifyEvent(AEvent, AEnabledEvent : TVTHeaderNotifyEvent);

    Procedure RegisterColumnChangeEvent(AEvent, ANewEvent : TColumnChangeEvent; Const Index : Integer = -1);
    Procedure UnRegisterColumnChangeEvent(AEvent, AOldEvent : TColumnChangeEvent);
    Procedure DisableColumnChangeEvent(AEvent, ADisabledEvent : TColumnChangeEvent);
    Procedure EnableColumnChangeEvent(AEvent, AEnabledEvent : TColumnChangeEvent);

    Procedure RegisterVTColumnWidthDblClickResizeEvent(AEvent, ANewEvent : TVTColumnWidthDblClickResizeEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTColumnWidthDblClickResizeEvent(AEvent, AOldEvent : TVTColumnWidthDblClickResizeEvent);
    Procedure DisableVTColumnWidthDblClickResizeEvent(AEvent, ADisabledEvent : TVTColumnWidthDblClickResizeEvent);
    Procedure EnableVTColumnWidthDblClickResizeEvent(AEvent, AEnabledEvent : TVTColumnWidthDblClickResizeEvent);

    Procedure RegisterVTColumnWidthTrackingEvent(AEvent, ANewEvent : TVTColumnWidthTrackingEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTColumnWidthTrackingEvent(AEvent, AOldEvent : TVTColumnWidthTrackingEvent);
    Procedure DisableVTColumnWidthTrackingEvent(AEvent, ADisabledEvent : TVTColumnWidthTrackingEvent);
    Procedure EnableVTColumnWidthTrackingEvent(AEvent, AEnabledEvent : TVTColumnWidthTrackingEvent);

    Procedure RegisterVTCompareEvent(AEvent, ANewEvent : TVTCompareEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTCompareEvent(AEvent, AOldEvent : TVTCompareEvent);
    Procedure DisableVTCompareEvent(AEvent, ADisabledEvent : TVTCompareEvent);
    Procedure EnableVTCompareEvent(AEvent, AEnabledEvent : TVTCompareEvent);

    Procedure RegisterVTCreateDataObjectEvent(AEvent, ANewEvent : TVTCreateDataObjectEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTCreateDataObjectEvent(AEvent, AOldEvent : TVTCreateDataObjectEvent);
    Procedure DisableVTCreateDataObjectEvent(AEvent, ADisabledEvent : TVTCreateDataObjectEvent);
    Procedure EnableVTCreateDataObjectEvent(AEvent, AEnabledEvent : TVTCreateDataObjectEvent);

    Procedure RegisterVTCreateDragManagerEvent(AEvent, ANewEvent : TVTCreateDragManagerEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTCreateDragManagerEvent(AEvent, AOldEvent : TVTCreateDragManagerEvent);
    Procedure DisableVTCreateDragManagerEvent(AEvent, ADisabledEvent : TVTCreateDragManagerEvent);
    Procedure EnableVTCreateDragManagerEvent(AEvent, AEnabledEvent : TVTCreateDragManagerEvent);

    Procedure RegisterVTCreateEditorEvent(AEvent, ANewEvent : TVTCreateEditorEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTCreateEditorEvent(AEvent, AOldEvent : TVTCreateEditorEvent);
    Procedure DisableVTCreateEditorEvent(AEvent, ADisabledEvent : TVTCreateEditorEvent);
    Procedure EnableVTCreateEditorEvent(AEvent, AEnabledEvent : TVTCreateEditorEvent);

    Procedure RegisterVTDragAllowedEvent(AEvent, ANewEvent : TVTDragAllowedEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTDragAllowedEvent(AEvent, AOldEvent : TVTDragAllowedEvent);
    Procedure DisableVTDragAllowedEvent(AEvent, ADisabledEvent : TVTDragAllowedEvent);
    Procedure EnableVTDragAllowedEvent(AEvent, AEnabledEvent : TVTDragAllowedEvent);

    Procedure RegisterVTDragDropEvent(AEvent, ANewEvent : TVTDragDropEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTDragDropEvent(AEvent, AOldEvent : TVTDragDropEvent);
    Procedure DisableVTDragDropEvent(AEvent, ADisabledEvent : TVTDragDropEvent);
    Procedure EnableVTDragDropEvent(AEvent, AEnabledEvent : TVTDragDropEvent);

    Procedure RegisterVTDragOverEvent(AEvent, ANewEvent : TVTDragOverEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTDragOverEvent(AEvent, AOldEvent : TVTDragOverEvent);
    Procedure DisableVTDragOverEvent(AEvent, ADisabledEvent : TVTDragOverEvent);
    Procedure EnableVTDragOverEvent(AEvent, AEnabledEvent : TVTDragOverEvent);

    Procedure RegisterVTDrawHintEvent(AEvent, ANewEvent : TVTDrawHintEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTDrawHintEvent(AEvent, AOldEvent : TVTDrawHintEvent);
    Procedure DisableVTDrawHintEvent(AEvent, ADisabledEvent : TVTDrawHintEvent);
    Procedure EnableVTDrawHintEvent(AEvent, AEnabledEvent : TVTDrawHintEvent);

    Procedure RegisterVTDrawTextEvent(AEvent, ANewEvent : TVTDrawTextEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTDrawTextEvent(AEvent, AOldEvent : TVTDrawTextEvent);
    Procedure DisableVTDrawTextEvent(AEvent, ADisabledEvent : TVTDrawTextEvent);
    Procedure EnableVTDrawTextEvent(AEvent, AEnabledEvent : TVTDrawTextEvent);

    Procedure RegisterVTEditCancelEvent(AEvent, ANewEvent : TVTEditCancelEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTEditCancelEvent(AEvent, AOldEvent : TVTEditCancelEvent);
    Procedure DisableVTEditCancelEvent(AEvent, ADisabledEvent : TVTEditCancelEvent);
    Procedure EnableVTEditCancelEvent(AEvent, AEnabledEvent : TVTEditCancelEvent);

    Procedure RegisterVTEditChangeEvent(AEvent, ANewEvent : TVTEditChangeEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTEditChangeEvent(AEvent, AOldEvent : TVTEditChangeEvent);
    Procedure DisableVTEditChangeEvent(AEvent, ADisabledEvent : TVTEditChangeEvent);
    Procedure EnableVTEditChangeEvent(AEvent, AEnabledEvent : TVTEditChangeEvent);

    Procedure RegisterVTEditChangingEvent(AEvent, ANewEvent : TVTEditChangingEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTEditChangingEvent(AEvent, AOldEvent : TVTEditChangingEvent);
    Procedure DisableVTEditChangingEvent(AEvent, ADisabledEvent : TVTEditChangingEvent);
    Procedure EnableVTEditChangingEvent(AEvent, AEnabledEvent : TVTEditChangingEvent);

    Procedure RegisterVTOperationEvent(AEvent, ANewEvent : TVTOperationEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTOperationEvent(AEvent, AOldEvent : TVTOperationEvent);
    Procedure DisableVTOperationEvent(AEvent, ADisabledEvent : TVTOperationEvent);
    Procedure EnableVTOperationEvent(AEvent, AEnabledEvent : TVTOperationEvent);

    Procedure RegisterVTFocusChangeEvent(AEvent, ANewEvent : TVTFocusChangeEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTFocusChangeEvent(AEvent, AOldEvent : TVTFocusChangeEvent);
    Procedure DisableVTFocusChangeEvent(AEvent, ADisabledEvent : TVTFocusChangeEvent);
    Procedure EnableVTFocusChangeEvent(AEvent, AEnabledEvent : TVTFocusChangeEvent);

    Procedure RegisterVTFocusChangingEvent(AEvent, ANewEvent : TVTFocusChangingEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTFocusChangingEvent(AEvent, AOldEvent : TVTFocusChangingEvent);
    Procedure DisableVTFocusChangingEvent(AEvent, ADisabledEvent : TVTFocusChangingEvent);
    Procedure EnableVTFocusChangingEvent(AEvent, AEnabledEvent : TVTFocusChangingEvent);

    Procedure RegisterVTFreeNodeEvent(AEvent, ANewEvent : TVTFreeNodeEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTFreeNodeEvent(AEvent, AOldEvent : TVTFreeNodeEvent);
    Procedure DisableVTFreeNodeEvent(AEvent, ADisabledEvent : TVTFreeNodeEvent);
    Procedure EnableVTFreeNodeEvent(AEvent, AEnabledEvent : TVTFreeNodeEvent);

    Procedure RegisterVTGetCellIsEmptyEvent(AEvent, ANewEvent : TVTGetCellIsEmptyEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTGetCellIsEmptyEvent(AEvent, AOldEvent : TVTGetCellIsEmptyEvent);
    Procedure DisableVTGetCellIsEmptyEvent(AEvent, ADisabledEvent : TVTGetCellIsEmptyEvent);
    Procedure EnableVTGetCellIsEmptyEvent(AEvent, AEnabledEvent : TVTGetCellIsEmptyEvent);

    Procedure RegisterVSTGetCellTextEvent(AEvent, ANewEvent : TVSTGetCellTextEvent; Const Index : Integer = -1);
    Procedure UnRegisterVSTGetCellTextEvent(AEvent, AOldEvent : TVSTGetCellTextEvent);
    Procedure DisableVSTGetCellTextEvent(AEvent, ADisabledEvent : TVSTGetCellTextEvent);
    Procedure EnableVSTGetCellTextEvent(AEvent, AEnabledEvent : TVSTGetCellTextEvent);

    Procedure RegisterVTGetCursorEvent(AEvent, ANewEvent : TVTGetCursorEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTGetCursorEvent(AEvent, AOldEvent : TVTGetCursorEvent);
    Procedure DisableVTGetCursorEvent(AEvent, ADisabledEvent : TVTGetCursorEvent);
    Procedure EnableVTGetCursorEvent(AEvent, AEnabledEvent : TVTGetCursorEvent);

    Procedure RegisterVTGetHeaderCursorEvent(AEvent, ANewEvent : TVTGetHeaderCursorEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTGetHeaderCursorEvent(AEvent, AOldEvent : TVTGetHeaderCursorEvent);
    Procedure DisableVTGetHeaderCursorEvent(AEvent, ADisabledEvent : TVTGetHeaderCursorEvent);
    Procedure EnableVTGetHeaderCursorEvent(AEvent, AEnabledEvent : TVTGetHeaderCursorEvent);

    Procedure RegisterVTHelpContextEvent(AEvent, ANewEvent : TVTHelpContextEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTHelpContextEvent(AEvent, AOldEvent : TVTHelpContextEvent);
    Procedure DisableVTHelpContextEvent(AEvent, ADisabledEvent : TVTHelpContextEvent);
    Procedure EnableVTHelpContextEvent(AEvent, AEnabledEvent : TVTHelpContextEvent);

    Procedure RegisterVSTGetHintEvent(AEvent, ANewEvent : TVSTGetHintEvent; Const Index : Integer = -1);
    Procedure UnRegisterVSTGetHintEvent(AEvent, AOldEvent : TVSTGetHintEvent);
    Procedure DisableVSTGetHintEvent(AEvent, ADisabledEvent : TVSTGetHintEvent);
    Procedure EnableVSTGetHintEvent(AEvent, AEnabledEvent : TVSTGetHintEvent);

    Procedure RegisterVTHintKindEvent(AEvent, ANewEvent : TVTHintKindEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTHintKindEvent(AEvent, AOldEvent : TVTHintKindEvent);
    Procedure DisableVTHintKindEvent(AEvent, ADisabledEvent : TVTHintKindEvent);
    Procedure EnableVTHintKindEvent(AEvent, AEnabledEvent : TVTHintKindEvent);

    Procedure RegisterVTGetHintSizeEvent(AEvent, ANewEvent : TVTGetHintSizeEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTGetHintSizeEvent(AEvent, AOldEvent : TVTGetHintSizeEvent);
    Procedure DisableVTGetHintSizeEvent(AEvent, ADisabledEvent : TVTGetHintSizeEvent);
    Procedure EnableVTGetHintSizeEvent(AEvent, AEnabledEvent : TVTGetHintSizeEvent);

    Procedure RegisterVTGetImageEvent(AEvent, ANewEvent : TVTGetImageEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTGetImageEvent(AEvent, AOldEvent : TVTGetImageEvent);
    Procedure DisableVTGetImageEvent(AEvent, ADisabledEvent : TVTGetImageEvent);
    Procedure EnableVTGetImageEvent(AEvent, AEnabledEvent : TVTGetImageEvent);

    Procedure RegisterVTGetImageExEvent(AEvent, ANewEvent : TVTGetImageExEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTGetImageExEvent(AEvent, AOldEvent : TVTGetImageExEvent);
    Procedure DisableVTGetImageExEvent(AEvent, ADisabledEvent : TVTGetImageExEvent);
    Procedure EnableVTGetImageExEvent(AEvent, AEnabledEvent : TVTGetImageExEvent);

    Procedure RegisterVTGetImageTextEvent(AEvent, ANewEvent : TVTGetImageTextEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTGetImageTextEvent(AEvent, AOldEvent : TVTGetImageTextEvent);
    Procedure DisableVTGetImageTextEvent(AEvent, ADisabledEvent : TVTGetImageTextEvent);
    Procedure EnableVTGetImageTextEvent(AEvent, AEnabledEvent : TVTGetImageTextEvent);

    Procedure RegisterVTGetLineStyleEvent(AEvent, ANewEvent : TVTGetLineStyleEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTGetLineStyleEvent(AEvent, AOldEvent : TVTGetLineStyleEvent);
    Procedure DisableVTGetLineStyleEvent(AEvent, ADisabledEvent : TVTGetLineStyleEvent);
    Procedure EnableVTGetLineStyleEvent(AEvent, AEnabledEvent : TVTGetLineStyleEvent);

    Procedure RegisterVTGetNodeDataSizeEvent(AEvent, ANewEvent : TVTGetNodeDataSizeEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTGetNodeDataSizeEvent(AEvent, AOldEvent : TVTGetNodeDataSizeEvent);
    Procedure DisableVTGetNodeDataSizeEvent(AEvent, ADisabledEvent : TVTGetNodeDataSizeEvent);
    Procedure EnableVTGetNodeDataSizeEvent(AEvent, AEnabledEvent : TVTGetNodeDataSizeEvent);

    Procedure RegisterVTPopupEvent(AEvent, ANewEvent : TVTPopupEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTPopupEvent(AEvent, AOldEvent : TVTPopupEvent);
    Procedure DisableVTPopupEvent(AEvent, ADisabledEvent : TVTPopupEvent);
    Procedure EnableVTPopupEvent(AEvent, AEnabledEvent : TVTPopupEvent);

    Procedure RegisterVSTGetTextEvent(AEvent, ANewEvent : TVSTGetTextEvent; Const Index : Integer = -1);
    Procedure UnRegisterVSTGetTextEvent(AEvent, AOldEvent : TVSTGetTextEvent);
    Procedure DisableVSTGetTextEvent(AEvent, ADisabledEvent : TVSTGetTextEvent);
    Procedure EnableVSTGetTextEvent(AEvent, AEnabledEvent : TVSTGetTextEvent);

    Procedure RegisterVTGetUserClipboardFormatsEvent(AEvent, ANewEvent : TVTGetUserClipboardFormatsEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTGetUserClipboardFormatsEvent(AEvent, AOldEvent : TVTGetUserClipboardFormatsEvent);
    Procedure DisableVTGetUserClipboardFormatsEvent(AEvent, ADisabledEvent : TVTGetUserClipboardFormatsEvent);
    Procedure EnableVTGetUserClipboardFormatsEvent(AEvent, AEnabledEvent : TVTGetUserClipboardFormatsEvent);

    Procedure RegisterVTHeaderClickEvent(AEvent, ANewEvent : TVTHeaderClickEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTHeaderClickEvent(AEvent, AOldEvent : TVTHeaderClickEvent);
    Procedure DisableVTHeaderClickEvent(AEvent, ADisabledEvent : TVTHeaderClickEvent);
    Procedure EnableVTHeaderClickEvent(AEvent, AEnabledEvent : TVTHeaderClickEvent);

    Procedure RegisterVTHeaderDraggedEvent(AEvent, ANewEvent : TVTHeaderDraggedEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTHeaderDraggedEvent(AEvent, AOldEvent : TVTHeaderDraggedEvent);
    Procedure DisableVTHeaderDraggedEvent(AEvent, ADisabledEvent : TVTHeaderDraggedEvent);
    Procedure EnableVTHeaderDraggedEvent(AEvent, AEnabledEvent : TVTHeaderDraggedEvent);

    Procedure RegisterVTHeaderDraggedOutEvent(AEvent, ANewEvent : TVTHeaderDraggedOutEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTHeaderDraggedOutEvent(AEvent, AOldEvent : TVTHeaderDraggedOutEvent);
    Procedure DisableVTHeaderDraggedOutEvent(AEvent, ADisabledEvent : TVTHeaderDraggedOutEvent);
    Procedure EnableVTHeaderDraggedOutEvent(AEvent, AEnabledEvent : TVTHeaderDraggedOutEvent);

    Procedure RegisterVTHeaderDraggingEvent(AEvent, ANewEvent : TVTHeaderDraggingEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTHeaderDraggingEvent(AEvent, AOldEvent : TVTHeaderDraggingEvent);
    Procedure DisableVTHeaderDraggingEvent(AEvent, ADisabledEvent : TVTHeaderDraggingEvent);
    Procedure EnableVTHeaderDraggingEvent(AEvent, AEnabledEvent : TVTHeaderDraggingEvent);

    Procedure RegisterVTHeaderPaintEvent(AEvent, ANewEvent : TVTHeaderPaintEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTHeaderPaintEvent(AEvent, AOldEvent : TVTHeaderPaintEvent);
    Procedure DisableVTHeaderPaintEvent(AEvent, ADisabledEvent : TVTHeaderPaintEvent);
    Procedure EnableVTHeaderPaintEvent(AEvent, AEnabledEvent : TVTHeaderPaintEvent);

    Procedure RegisterVTHeaderPaintQueryElementsEvent(AEvent, ANewEvent : TVTHeaderPaintQueryElementsEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTHeaderPaintQueryElementsEvent(AEvent, AOldEvent : TVTHeaderPaintQueryElementsEvent);
    Procedure DisableVTHeaderPaintQueryElementsEvent(AEvent, ADisabledEvent : TVTHeaderPaintQueryElementsEvent);
    Procedure EnableVTHeaderPaintQueryElementsEvent(AEvent, AEnabledEvent : TVTHeaderPaintQueryElementsEvent);

    Procedure RegisterVTHeaderHeightDblClickResizeEvent(AEvent, ANewEvent : TVTHeaderHeightDblClickResizeEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTHeaderHeightDblClickResizeEvent(AEvent, AOldEvent : TVTHeaderHeightDblClickResizeEvent);
    Procedure DisableVTHeaderHeightDblClickResizeEvent(AEvent, ADisabledEvent : TVTHeaderHeightDblClickResizeEvent);
    Procedure EnableVTHeaderHeightDblClickResizeEvent(AEvent, AEnabledEvent : TVTHeaderHeightDblClickResizeEvent);

    Procedure RegisterVTHeaderHeightTrackingEvent(AEvent, ANewEvent : TVTHeaderHeightTrackingEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTHeaderHeightTrackingEvent(AEvent, AOldEvent : TVTHeaderHeightTrackingEvent);
    Procedure DisableVTHeaderHeightTrackingEvent(AEvent, ADisabledEvent : TVTHeaderHeightTrackingEvent);
    Procedure EnableVTHeaderHeightTrackingEvent(AEvent, AEnabledEvent : TVTHeaderHeightTrackingEvent);

    Procedure RegisterVTHeaderMouseEvent(AEvent, ANewEvent : TVTHeaderMouseEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTHeaderMouseEvent(AEvent, AOldEvent : TVTHeaderMouseEvent);
    Procedure DisableVTHeaderMouseEvent(AEvent, ADisabledEvent : TVTHeaderMouseEvent);
    Procedure EnableVTHeaderMouseEvent(AEvent, AEnabledEvent : TVTHeaderMouseEvent);

    Procedure RegisterVTHeaderMouseMoveEvent(AEvent, ANewEvent : TVTHeaderMouseMoveEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTHeaderMouseMoveEvent(AEvent, AOldEvent : TVTHeaderMouseMoveEvent);
    Procedure DisableVTHeaderMouseMoveEvent(AEvent, ADisabledEvent : TVTHeaderMouseMoveEvent);
    Procedure EnableVTHeaderMouseMoveEvent(AEvent, AEnabledEvent : TVTHeaderMouseMoveEvent);

    Procedure RegisterVTHotNodeChangeEvent(AEvent, ANewEvent : TVTHotNodeChangeEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTHotNodeChangeEvent(AEvent, AOldEvent : TVTHotNodeChangeEvent);
    Procedure DisableVTHotNodeChangeEvent(AEvent, ADisabledEvent : TVTHotNodeChangeEvent);
    Procedure EnableVTHotNodeChangeEvent(AEvent, AEnabledEvent : TVTHotNodeChangeEvent);

    Procedure RegisterVTIncrementalSearchEvent(AEvent, ANewEvent : TVTIncrementalSearchEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTIncrementalSearchEvent(AEvent, AOldEvent : TVTIncrementalSearchEvent);
    Procedure DisableVTIncrementalSearchEvent(AEvent, ADisabledEvent : TVTIncrementalSearchEvent);
    Procedure EnableVTIncrementalSearchEvent(AEvent, AEnabledEvent : TVTIncrementalSearchEvent);

    Procedure RegisterVTInitChildrenEvent(AEvent, ANewEvent : TVTInitChildrenEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTInitChildrenEvent(AEvent, AOldEvent : TVTInitChildrenEvent);
    Procedure DisableVTInitChildrenEvent(AEvent, ADisabledEvent : TVTInitChildrenEvent);
    Procedure EnableVTInitChildrenEvent(AEvent, AEnabledEvent : TVTInitChildrenEvent);

    Procedure RegisterVTInitNodeEvent(AEvent, ANewEvent : TVTInitNodeEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTInitNodeEvent(AEvent, AOldEvent : TVTInitNodeEvent);
    Procedure DisableVTInitNodeEvent(AEvent, ADisabledEvent : TVTInitNodeEvent);
    Procedure EnableVTInitNodeEvent(AEvent, AEnabledEvent : TVTInitNodeEvent);

    Procedure RegisterVTKeyActionEvent(AEvent, ANewEvent : TVTKeyActionEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTKeyActionEvent(AEvent, AOldEvent : TVTKeyActionEvent);
    Procedure DisableVTKeyActionEvent(AEvent, ADisabledEvent : TVTKeyActionEvent);
    Procedure EnableVTKeyActionEvent(AEvent, AEnabledEvent : TVTKeyActionEvent);

    Procedure RegisterVTSaveNodeEvent(AEvent, ANewEvent : TVTSaveNodeEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTSaveNodeEvent(AEvent, AOldEvent : TVTSaveNodeEvent);
    Procedure DisableVTSaveNodeEvent(AEvent, ADisabledEvent : TVTSaveNodeEvent);
    Procedure EnableVTSaveNodeEvent(AEvent, AEnabledEvent : TVTSaveNodeEvent);

    Procedure RegisterVTSaveTreeEvent(AEvent, ANewEvent : TVTSaveTreeEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTSaveTreeEvent(AEvent, AOldEvent : TVTSaveTreeEvent);
    Procedure DisableVTSaveTreeEvent(AEvent, ADisabledEvent : TVTSaveTreeEvent);
    Procedure EnableVTSaveTreeEvent(AEvent, AEnabledEvent : TVTSaveTreeEvent);

    Procedure RegisterVTMeasureItemEvent(AEvent, ANewEvent : TVTMeasureItemEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTMeasureItemEvent(AEvent, AOldEvent : TVTMeasureItemEvent);
    Procedure DisableVTMeasureItemEvent(AEvent, ADisabledEvent : TVTMeasureItemEvent);
    Procedure EnableVTMeasureItemEvent(AEvent, AEnabledEvent : TVTMeasureItemEvent);

    Procedure RegisterVTMeasureTextEvent(AEvent, ANewEvent : TVTMeasureTextEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTMeasureTextEvent(AEvent, AOldEvent : TVTMeasureTextEvent);
    Procedure DisableVTMeasureTextEvent(AEvent, ADisabledEvent : TVTMeasureTextEvent);
    Procedure EnableVTMeasureTextEvent(AEvent, AEnabledEvent : TVTMeasureTextEvent);

    Procedure RegisterMouseWheelEvent(AEvent, ANewEvent : TMouseWheelEvent; Const Index : Integer = -1);
    Procedure UnRegisterMouseWheelEvent(AEvent, AOldEvent : TMouseWheelEvent);
    Procedure DisableMouseWheelEvent(AEvent, ADisabledEvent : TMouseWheelEvent);
    Procedure EnableMouseWheelEvent(AEvent, AEnabledEvent : TMouseWheelEvent);

    Procedure RegisterVSTNewTextEvent(AEvent, ANewEvent : TVSTNewTextEvent; Const Index : Integer = -1);
    Procedure UnRegisterVSTNewTextEvent(AEvent, AOldEvent : TVSTNewTextEvent);
    Procedure DisableVSTNewTextEvent(AEvent, ADisabledEvent : TVSTNewTextEvent);
    Procedure EnableVSTNewTextEvent(AEvent, AEnabledEvent : TVSTNewTextEvent);

    Procedure RegisterVTNodeClickEvent(AEvent, ANewEvent : TVTNodeClickEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTNodeClickEvent(AEvent, AOldEvent : TVTNodeClickEvent);
    Procedure DisableVTNodeClickEvent(AEvent, ADisabledEvent : TVTNodeClickEvent);
    Procedure EnableVTNodeClickEvent(AEvent, AEnabledEvent : TVTNodeClickEvent);

    Procedure RegisterVTNodeCopiedEvent(AEvent, ANewEvent : TVTNodeCopiedEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTNodeCopiedEvent(AEvent, AOldEvent : TVTNodeCopiedEvent);
    Procedure DisableVTNodeCopiedEvent(AEvent, ADisabledEvent : TVTNodeCopiedEvent);
    Procedure EnableVTNodeCopiedEvent(AEvent, AEnabledEvent : TVTNodeCopiedEvent);

    Procedure RegisterVTNodeCopyingEvent(AEvent, ANewEvent : TVTNodeCopyingEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTNodeCopyingEvent(AEvent, AOldEvent : TVTNodeCopyingEvent);
    Procedure DisableVTNodeCopyingEvent(AEvent, ADisabledEvent : TVTNodeCopyingEvent);
    Procedure EnableVTNodeCopyingEvent(AEvent, AEnabledEvent : TVTNodeCopyingEvent);

    Procedure RegisterVTNodeHeightDblClickResizeEvent(AEvent, ANewEvent : TVTNodeHeightDblClickResizeEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTNodeHeightDblClickResizeEvent(AEvent, AOldEvent : TVTNodeHeightDblClickResizeEvent);
    Procedure DisableVTNodeHeightDblClickResizeEvent(AEvent, ADisabledEvent : TVTNodeHeightDblClickResizeEvent);
    Procedure EnableVTNodeHeightDblClickResizeEvent(AEvent, AEnabledEvent : TVTNodeHeightDblClickResizeEvent);

    Procedure RegisterVTNodeHeightTrackingEvent(AEvent, ANewEvent : TVTNodeHeightTrackingEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTNodeHeightTrackingEvent(AEvent, AOldEvent : TVTNodeHeightTrackingEvent);
    Procedure DisableVTNodeHeightTrackingEvent(AEvent, ADisabledEvent : TVTNodeHeightTrackingEvent);
    Procedure EnableVTNodeHeightTrackingEvent(AEvent, AEnabledEvent : TVTNodeHeightTrackingEvent);

    Procedure RegisterVTNodeMovedEvent(AEvent, ANewEvent : TVTNodeMovedEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTNodeMovedEvent(AEvent, AOldEvent : TVTNodeMovedEvent);
    Procedure DisableVTNodeMovedEvent(AEvent, ADisabledEvent : TVTNodeMovedEvent);
    Procedure EnableVTNodeMovedEvent(AEvent, AEnabledEvent : TVTNodeMovedEvent);

    Procedure RegisterVTNodeMovingEvent(AEvent, ANewEvent : TVTNodeMovingEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTNodeMovingEvent(AEvent, AOldEvent : TVTNodeMovingEvent);
    Procedure DisableVTNodeMovingEvent(AEvent, ADisabledEvent : TVTNodeMovingEvent);
    Procedure EnableVTNodeMovingEvent(AEvent, AEnabledEvent : TVTNodeMovingEvent);

    Procedure RegisterVTBackgroundPaintEvent(AEvent, ANewEvent : TVTBackgroundPaintEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTBackgroundPaintEvent(AEvent, AOldEvent : TVTBackgroundPaintEvent);
    Procedure DisableVTBackgroundPaintEvent(AEvent, ADisabledEvent : TVTBackgroundPaintEvent);
    Procedure EnableVTBackgroundPaintEvent(AEvent, AEnabledEvent : TVTBackgroundPaintEvent);

    Procedure RegisterVTPaintText(AEvent, ANewEvent : TVTPaintText; Const Index : Integer = -1);
    Procedure UnRegisterVTPaintText(AEvent, AOldEvent : TVTPaintText);
    Procedure DisableVTPaintText(AEvent, ADisabledEvent : TVTPaintText);
    Procedure EnableVTPaintText(AEvent, AEnabledEvent : TVTPaintText);

    Procedure RegisterVTPrepareButtonImagesEvent(AEvent, ANewEvent : TVTPrepareButtonImagesEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTPrepareButtonImagesEvent(AEvent, AOldEvent : TVTPrepareButtonImagesEvent);
    Procedure DisableVTPrepareButtonImagesEvent(AEvent, ADisabledEvent : TVTPrepareButtonImagesEvent);
    Procedure EnableVTPrepareButtonImagesEvent(AEvent, AEnabledEvent : TVTPrepareButtonImagesEvent);

    Procedure RegisterVTRemoveFromSelectionEvent(AEvent, ANewEvent : TVTRemoveFromSelectionEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTRemoveFromSelectionEvent(AEvent, AOldEvent : TVTRemoveFromSelectionEvent);
    Procedure DisableVTRemoveFromSelectionEvent(AEvent, ADisabledEvent : TVTRemoveFromSelectionEvent);
    Procedure EnableVTRemoveFromSelectionEvent(AEvent, AEnabledEvent : TVTRemoveFromSelectionEvent);

    Procedure RegisterVTRenderOLEDataEvent(AEvent, ANewEvent : TVTRenderOLEDataEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTRenderOLEDataEvent(AEvent, AOldEvent : TVTRenderOLEDataEvent);
    Procedure DisableVTRenderOLEDataEvent(AEvent, ADisabledEvent : TVTRenderOLEDataEvent);
    Procedure EnableVTRenderOLEDataEvent(AEvent, AEnabledEvent : TVTRenderOLEDataEvent);

    Procedure RegisterVTScrollEvent(AEvent, ANewEvent : TVTScrollEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTScrollEvent(AEvent, AOldEvent : TVTScrollEvent);
    Procedure DisableVTScrollEvent(AEvent, ADisabledEvent : TVTScrollEvent);
    Procedure EnableVTScrollEvent(AEvent, AEnabledEvent : TVTScrollEvent);

    Procedure RegisterVSTShortenStringEvent(AEvent, ANewEvent : TVSTShortenStringEvent; Const Index : Integer = -1);
    Procedure UnRegisterVSTShortenStringEvent(AEvent, AOldEvent : TVSTShortenStringEvent);
    Procedure DisableVSTShortenStringEvent(AEvent, ADisabledEvent : TVSTShortenStringEvent);
    Procedure EnableVSTShortenStringEvent(AEvent, AEnabledEvent : TVSTShortenStringEvent);

    Procedure RegisterVTScrollBarShowEvent(AEvent, ANewEvent : TVTScrollBarShowEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTScrollBarShowEvent(AEvent, AOldEvent : TVTScrollBarShowEvent);
    Procedure DisableVTScrollBarShowEvent(AEvent, ADisabledEvent : TVTScrollBarShowEvent);
    Procedure EnableVTScrollBarShowEvent(AEvent, AEnabledEvent : TVTScrollBarShowEvent);

    Procedure RegisterVTStateChangeEvent(AEvent, ANewEvent : TVTStateChangeEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTStateChangeEvent(AEvent, AOldEvent : TVTStateChangeEvent);
    Procedure DisableVTStateChangeEvent(AEvent, ADisabledEvent : TVTStateChangeEvent);
    Procedure EnableVTStateChangeEvent(AEvent, AEnabledEvent : TVTStateChangeEvent);

    Procedure RegisterVTStructureChangeEvent(AEvent, ANewEvent : TVTStructureChangeEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTStructureChangeEvent(AEvent, AOldEvent : TVTStructureChangeEvent);
    Procedure DisableVTStructureChangeEvent(AEvent, ADisabledEvent : TVTStructureChangeEvent);
    Procedure EnableVTStructureChangeEvent(AEvent, AEnabledEvent : TVTStructureChangeEvent);

    Procedure RegisterVTUpdatingEvent(AEvent, ANewEvent : TVTUpdatingEvent; Const Index : Integer = -1);
    Procedure UnRegisterVTUpdatingEvent(AEvent, AOldEvent : TVTUpdatingEvent);
    Procedure DisableVTUpdatingEvent(AEvent, ADisabledEvent : TVTUpdatingEvent);
    Procedure EnableVTUpdatingEvent(AEvent, AEnabledEvent : TVTUpdatingEvent);

  End;

Implementation

Uses
  SysUtils, TypInfo;

Function TVTAddToSelectionEventListEx.Get(Index : Integer) : TVTAddToSelectionEvent;
Begin
  Result := TVTAddToSelectionEvent(InHerited Items[Index].Method);
End;

Procedure TVTAddToSelectionEventListEx.Put(Index : Integer; Item : TVTAddToSelectionEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTAddToSelectionEventListEx.Add(Item : TVTAddToSelectionEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTAddToSelectionEventListEx.Insert(Index: Integer; Item : TVTAddToSelectionEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTAddToSelectionEventListEx.Remove(Item : TVTAddToSelectionEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTAddToSelectionEventListEx.IndexOf(Item : TVTAddToSelectionEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTAddToSelectionEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTAddToSelectionEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTAddToSelectionEventListEx.Execute(Sender : TBaseVirtualTree; Node : PVirtualNode);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTAddToSelectionEvent(lItem.Method)(Sender, Node);
  End;
End;

Function TVTAdvancedHeaderPaintEventListEx.Get(Index : Integer) : TVTAdvancedHeaderPaintEvent;
Begin
  Result := TVTAdvancedHeaderPaintEvent(InHerited Items[Index].Method);
End;

Procedure TVTAdvancedHeaderPaintEventListEx.Put(Index : Integer; Item : TVTAdvancedHeaderPaintEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTAdvancedHeaderPaintEventListEx.Add(Item : TVTAdvancedHeaderPaintEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTAdvancedHeaderPaintEventListEx.Insert(Index: Integer; Item : TVTAdvancedHeaderPaintEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTAdvancedHeaderPaintEventListEx.Remove(Item : TVTAdvancedHeaderPaintEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTAdvancedHeaderPaintEventListEx.IndexOf(Item : TVTAdvancedHeaderPaintEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTAdvancedHeaderPaintEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTAdvancedHeaderPaintEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTAdvancedHeaderPaintEventListEx.Execute(Sender : TVTHeader; Var PaintInfo : THeaderPaintInfo; Const Elements : THeaderPaintElements);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTAdvancedHeaderPaintEvent(lItem.Method)(Sender, PaintInfo, Elements);
  End;
End;

Function TVTAfterAutoFitColumnEventListEx.Get(Index : Integer) : TVTAfterAutoFitColumnEvent;
Begin
  Result := TVTAfterAutoFitColumnEvent(InHerited Items[Index].Method);
End;

Procedure TVTAfterAutoFitColumnEventListEx.Put(Index : Integer; Item : TVTAfterAutoFitColumnEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTAfterAutoFitColumnEventListEx.Add(Item : TVTAfterAutoFitColumnEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTAfterAutoFitColumnEventListEx.Insert(Index: Integer; Item : TVTAfterAutoFitColumnEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTAfterAutoFitColumnEventListEx.Remove(Item : TVTAfterAutoFitColumnEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTAfterAutoFitColumnEventListEx.IndexOf(Item : TVTAfterAutoFitColumnEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTAfterAutoFitColumnEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTAfterAutoFitColumnEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTAfterAutoFitColumnEventListEx.Execute(Sender : TVTHeader; Column : TColumnIndex);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTAfterAutoFitColumnEvent(lItem.Method)(Sender, Column);
  End;
End;

Function TVTAfterAutoFitColumnsEventListEx.Get(Index : Integer) : TVTAfterAutoFitColumnsEvent;
Begin
  Result := TVTAfterAutoFitColumnsEvent(InHerited Items[Index].Method);
End;

Procedure TVTAfterAutoFitColumnsEventListEx.Put(Index : Integer; Item : TVTAfterAutoFitColumnsEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTAfterAutoFitColumnsEventListEx.Add(Item : TVTAfterAutoFitColumnsEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTAfterAutoFitColumnsEventListEx.Insert(Index: Integer; Item : TVTAfterAutoFitColumnsEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTAfterAutoFitColumnsEventListEx.Remove(Item : TVTAfterAutoFitColumnsEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTAfterAutoFitColumnsEventListEx.IndexOf(Item : TVTAfterAutoFitColumnsEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTAfterAutoFitColumnsEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTAfterAutoFitColumnsEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTAfterAutoFitColumnsEventListEx.Execute(Sender : TVTHeader);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTAfterAutoFitColumnsEvent(lItem.Method)(Sender);
  End;
End;

Function TVTAfterCellPaintEventListEx.Get(Index : Integer) : TVTAfterCellPaintEvent;
Begin
  Result := TVTAfterCellPaintEvent(InHerited Items[Index].Method);
End;

Procedure TVTAfterCellPaintEventListEx.Put(Index : Integer; Item : TVTAfterCellPaintEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTAfterCellPaintEventListEx.Add(Item : TVTAfterCellPaintEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTAfterCellPaintEventListEx.Insert(Index: Integer; Item : TVTAfterCellPaintEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTAfterCellPaintEventListEx.Remove(Item : TVTAfterCellPaintEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTAfterCellPaintEventListEx.IndexOf(Item : TVTAfterCellPaintEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTAfterCellPaintEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTAfterCellPaintEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTAfterCellPaintEventListEx.Execute(Sender : TBaseVirtualTree; TargetCanvas : TCanvas; Node : PVirtualNode; Column : TColumnIndex; CellRect : TRect);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTAfterCellPaintEvent(lItem.Method)(Sender, TargetCanvas, Node, Column, CellRect);
  End;
End;

Function TVTColumnExportEventListEx.Get(Index : Integer) : TVTColumnExportEvent;
Begin
  Result := TVTColumnExportEvent(InHerited Items[Index].Method);
End;

Procedure TVTColumnExportEventListEx.Put(Index : Integer; Item : TVTColumnExportEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTColumnExportEventListEx.Add(Item : TVTColumnExportEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTColumnExportEventListEx.Insert(Index: Integer; Item : TVTColumnExportEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTColumnExportEventListEx.Remove(Item : TVTColumnExportEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTColumnExportEventListEx.IndexOf(Item : TVTColumnExportEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTColumnExportEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTColumnExportEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTColumnExportEventListEx.Execute(Sender : TBaseVirtualTree; aExportType : TVTExportType; Column : TVirtualTreeColumn);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTColumnExportEvent(lItem.Method)(Sender, aExportType, Column);
  End;
End;

Function TVTAfterColumnWidthTrackingEventListEx.Get(Index : Integer) : TVTAfterColumnWidthTrackingEvent;
Begin
  Result := TVTAfterColumnWidthTrackingEvent(InHerited Items[Index].Method);
End;

Procedure TVTAfterColumnWidthTrackingEventListEx.Put(Index : Integer; Item : TVTAfterColumnWidthTrackingEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTAfterColumnWidthTrackingEventListEx.Add(Item : TVTAfterColumnWidthTrackingEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTAfterColumnWidthTrackingEventListEx.Insert(Index: Integer; Item : TVTAfterColumnWidthTrackingEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTAfterColumnWidthTrackingEventListEx.Remove(Item : TVTAfterColumnWidthTrackingEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTAfterColumnWidthTrackingEventListEx.IndexOf(Item : TVTAfterColumnWidthTrackingEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTAfterColumnWidthTrackingEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTAfterColumnWidthTrackingEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTAfterColumnWidthTrackingEventListEx.Execute(Sender : TVTHeader; Column : TColumnIndex);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTAfterColumnWidthTrackingEvent(lItem.Method)(Sender, Column);
  End;
End;

Function TVTAfterGetMaxColumnWidthEventListEx.Get(Index : Integer) : TVTAfterGetMaxColumnWidthEvent;
Begin
  Result := TVTAfterGetMaxColumnWidthEvent(InHerited Items[Index].Method);
End;

Procedure TVTAfterGetMaxColumnWidthEventListEx.Put(Index : Integer; Item : TVTAfterGetMaxColumnWidthEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTAfterGetMaxColumnWidthEventListEx.Add(Item : TVTAfterGetMaxColumnWidthEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTAfterGetMaxColumnWidthEventListEx.Insert(Index: Integer; Item : TVTAfterGetMaxColumnWidthEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTAfterGetMaxColumnWidthEventListEx.Remove(Item : TVTAfterGetMaxColumnWidthEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTAfterGetMaxColumnWidthEventListEx.IndexOf(Item : TVTAfterGetMaxColumnWidthEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTAfterGetMaxColumnWidthEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTAfterGetMaxColumnWidthEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTAfterGetMaxColumnWidthEventListEx.Execute(Sender : TVTHeader; Column : TColumnIndex; Var MaxWidth : Integer);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTAfterGetMaxColumnWidthEvent(lItem.Method)(Sender, Column, MaxWidth);
  End;
End;

Function TVTTreeExportEventListEx.Get(Index : Integer) : TVTTreeExportEvent;
Begin
  Result := TVTTreeExportEvent(InHerited Items[Index].Method);
End;

Procedure TVTTreeExportEventListEx.Put(Index : Integer; Item : TVTTreeExportEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTTreeExportEventListEx.Add(Item : TVTTreeExportEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTTreeExportEventListEx.Insert(Index: Integer; Item : TVTTreeExportEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTTreeExportEventListEx.Remove(Item : TVTTreeExportEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTTreeExportEventListEx.IndexOf(Item : TVTTreeExportEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTTreeExportEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTTreeExportEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTTreeExportEventListEx.Execute(Sender : TBaseVirtualTree; aExportType : TVTExportType);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTTreeExportEvent(lItem.Method)(Sender, aExportType);
  End;
End;

Function TVTAfterHeaderHeightTrackingEventListEx.Get(Index : Integer) : TVTAfterHeaderHeightTrackingEvent;
Begin
  Result := TVTAfterHeaderHeightTrackingEvent(InHerited Items[Index].Method);
End;

Procedure TVTAfterHeaderHeightTrackingEventListEx.Put(Index : Integer; Item : TVTAfterHeaderHeightTrackingEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTAfterHeaderHeightTrackingEventListEx.Add(Item : TVTAfterHeaderHeightTrackingEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTAfterHeaderHeightTrackingEventListEx.Insert(Index: Integer; Item : TVTAfterHeaderHeightTrackingEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTAfterHeaderHeightTrackingEventListEx.Remove(Item : TVTAfterHeaderHeightTrackingEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTAfterHeaderHeightTrackingEventListEx.IndexOf(Item : TVTAfterHeaderHeightTrackingEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTAfterHeaderHeightTrackingEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTAfterHeaderHeightTrackingEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTAfterHeaderHeightTrackingEventListEx.Execute(Sender : TVTHeader);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTAfterHeaderHeightTrackingEvent(lItem.Method)(Sender);
  End;
End;

Function TVTAfterItemEraseEventListEx.Get(Index : Integer) : TVTAfterItemEraseEvent;
Begin
  Result := TVTAfterItemEraseEvent(InHerited Items[Index].Method);
End;

Procedure TVTAfterItemEraseEventListEx.Put(Index : Integer; Item : TVTAfterItemEraseEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTAfterItemEraseEventListEx.Add(Item : TVTAfterItemEraseEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTAfterItemEraseEventListEx.Insert(Index: Integer; Item : TVTAfterItemEraseEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTAfterItemEraseEventListEx.Remove(Item : TVTAfterItemEraseEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTAfterItemEraseEventListEx.IndexOf(Item : TVTAfterItemEraseEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTAfterItemEraseEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTAfterItemEraseEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTAfterItemEraseEventListEx.Execute(Sender : TBaseVirtualTree; TargetCanvas : TCanvas; Node : PVirtualNode; ItemRect : TRect);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTAfterItemEraseEvent(lItem.Method)(Sender, TargetCanvas, Node, ItemRect);
  End;
End;

Function TVTAfterItemPaintEventListEx.Get(Index : Integer) : TVTAfterItemPaintEvent;
Begin
  Result := TVTAfterItemPaintEvent(InHerited Items[Index].Method);
End;

Procedure TVTAfterItemPaintEventListEx.Put(Index : Integer; Item : TVTAfterItemPaintEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTAfterItemPaintEventListEx.Add(Item : TVTAfterItemPaintEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTAfterItemPaintEventListEx.Insert(Index: Integer; Item : TVTAfterItemPaintEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTAfterItemPaintEventListEx.Remove(Item : TVTAfterItemPaintEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTAfterItemPaintEventListEx.IndexOf(Item : TVTAfterItemPaintEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTAfterItemPaintEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTAfterItemPaintEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTAfterItemPaintEventListEx.Execute(Sender : TBaseVirtualTree; TargetCanvas : TCanvas; Node : PVirtualNode; ItemRect : TRect);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTAfterItemPaintEvent(lItem.Method)(Sender, TargetCanvas, Node, ItemRect);
  End;
End;

Function TVTNodeExportEventListEx.Get(Index : Integer) : TVTNodeExportEvent;
Begin
  Result := TVTNodeExportEvent(InHerited Items[Index].Method);
End;

Procedure TVTNodeExportEventListEx.Put(Index : Integer; Item : TVTNodeExportEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTNodeExportEventListEx.Add(Item : TVTNodeExportEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTNodeExportEventListEx.Insert(Index: Integer; Item : TVTNodeExportEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTNodeExportEventListEx.Remove(Item : TVTNodeExportEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTNodeExportEventListEx.IndexOf(Item : TVTNodeExportEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTNodeExportEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTNodeExportEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Function TVTNodeExportEventListEx.Execute(Sender : TBaseVirtualTree; aExportType : TVTExportType; Node : PVirtualNode) : Boolean;
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      Result := TVTNodeExportEvent(lItem.Method)(Sender, aExportType, Node);
  End;
End;

Function TVTPaintEventListEx.Get(Index : Integer) : TVTPaintEvent;
Begin
  Result := TVTPaintEvent(InHerited Items[Index].Method);
End;

Procedure TVTPaintEventListEx.Put(Index : Integer; Item : TVTPaintEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTPaintEventListEx.Add(Item : TVTPaintEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTPaintEventListEx.Insert(Index: Integer; Item : TVTPaintEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTPaintEventListEx.Remove(Item : TVTPaintEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTPaintEventListEx.IndexOf(Item : TVTPaintEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTPaintEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTPaintEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTPaintEventListEx.Execute(Sender : TBaseVirtualTree; TargetCanvas : TCanvas);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTPaintEvent(lItem.Method)(Sender, TargetCanvas);
  End;
End;

Function TVTBeforeAutoFitColumnEventListEx.Get(Index : Integer) : TVTBeforeAutoFitColumnEvent;
Begin
  Result := TVTBeforeAutoFitColumnEvent(InHerited Items[Index].Method);
End;

Procedure TVTBeforeAutoFitColumnEventListEx.Put(Index : Integer; Item : TVTBeforeAutoFitColumnEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTBeforeAutoFitColumnEventListEx.Add(Item : TVTBeforeAutoFitColumnEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTBeforeAutoFitColumnEventListEx.Insert(Index: Integer; Item : TVTBeforeAutoFitColumnEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTBeforeAutoFitColumnEventListEx.Remove(Item : TVTBeforeAutoFitColumnEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTBeforeAutoFitColumnEventListEx.IndexOf(Item : TVTBeforeAutoFitColumnEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTBeforeAutoFitColumnEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTBeforeAutoFitColumnEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTBeforeAutoFitColumnEventListEx.Execute(Sender : TVTHeader; Column : TColumnIndex; Var SmartAutoFitType : TSmartAutoFitType; Var Allowed : Boolean);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTBeforeAutoFitColumnEvent(lItem.Method)(Sender, Column, SmartAutoFitType, Allowed);
  End;
End;

Function TVTBeforeAutoFitColumnsEventListEx.Get(Index : Integer) : TVTBeforeAutoFitColumnsEvent;
Begin
  Result := TVTBeforeAutoFitColumnsEvent(InHerited Items[Index].Method);
End;

Procedure TVTBeforeAutoFitColumnsEventListEx.Put(Index : Integer; Item : TVTBeforeAutoFitColumnsEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTBeforeAutoFitColumnsEventListEx.Add(Item : TVTBeforeAutoFitColumnsEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTBeforeAutoFitColumnsEventListEx.Insert(Index: Integer; Item : TVTBeforeAutoFitColumnsEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTBeforeAutoFitColumnsEventListEx.Remove(Item : TVTBeforeAutoFitColumnsEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTBeforeAutoFitColumnsEventListEx.IndexOf(Item : TVTBeforeAutoFitColumnsEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTBeforeAutoFitColumnsEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTBeforeAutoFitColumnsEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTBeforeAutoFitColumnsEventListEx.Execute(Sender : TVTHeader; Var SmartAutoFitType : TSmartAutoFitType);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTBeforeAutoFitColumnsEvent(lItem.Method)(Sender, SmartAutoFitType);
  End;
End;

Function TVTBeforeCellPaintEventListEx.Get(Index : Integer) : TVTBeforeCellPaintEvent;
Begin
  Result := TVTBeforeCellPaintEvent(InHerited Items[Index].Method);
End;

Procedure TVTBeforeCellPaintEventListEx.Put(Index : Integer; Item : TVTBeforeCellPaintEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTBeforeCellPaintEventListEx.Add(Item : TVTBeforeCellPaintEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTBeforeCellPaintEventListEx.Insert(Index: Integer; Item : TVTBeforeCellPaintEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTBeforeCellPaintEventListEx.Remove(Item : TVTBeforeCellPaintEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTBeforeCellPaintEventListEx.IndexOf(Item : TVTBeforeCellPaintEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTBeforeCellPaintEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTBeforeCellPaintEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTBeforeCellPaintEventListEx.Execute(Sender : TBaseVirtualTree; TargetCanvas : TCanvas; Node : PVirtualNode; Column : TColumnIndex; CellPaintMode : TVTCellPaintMode; CellRect : TRect; Var ContentRect : TRect);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTBeforeCellPaintEvent(lItem.Method)(Sender, TargetCanvas, Node, Column, CellPaintMode, CellRect, ContentRect);
  End;
End;

Function TVTBeforeColumnWidthTrackingEventListEx.Get(Index : Integer) : TVTBeforeColumnWidthTrackingEvent;
Begin
  Result := TVTBeforeColumnWidthTrackingEvent(InHerited Items[Index].Method);
End;

Procedure TVTBeforeColumnWidthTrackingEventListEx.Put(Index : Integer; Item : TVTBeforeColumnWidthTrackingEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTBeforeColumnWidthTrackingEventListEx.Add(Item : TVTBeforeColumnWidthTrackingEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTBeforeColumnWidthTrackingEventListEx.Insert(Index: Integer; Item : TVTBeforeColumnWidthTrackingEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTBeforeColumnWidthTrackingEventListEx.Remove(Item : TVTBeforeColumnWidthTrackingEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTBeforeColumnWidthTrackingEventListEx.IndexOf(Item : TVTBeforeColumnWidthTrackingEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTBeforeColumnWidthTrackingEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTBeforeColumnWidthTrackingEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTBeforeColumnWidthTrackingEventListEx.Execute(Sender : TVTHeader; Column : TColumnIndex; Shift : TShiftState);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTBeforeColumnWidthTrackingEvent(lItem.Method)(Sender, Column, Shift);
  End;
End;

Function TVTBeforeDrawLineImageEventListEx.Get(Index : Integer) : TVTBeforeDrawLineImageEvent;
Begin
  Result := TVTBeforeDrawLineImageEvent(InHerited Items[Index].Method);
End;

Procedure TVTBeforeDrawLineImageEventListEx.Put(Index : Integer; Item : TVTBeforeDrawLineImageEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTBeforeDrawLineImageEventListEx.Add(Item : TVTBeforeDrawLineImageEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTBeforeDrawLineImageEventListEx.Insert(Index: Integer; Item : TVTBeforeDrawLineImageEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTBeforeDrawLineImageEventListEx.Remove(Item : TVTBeforeDrawLineImageEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTBeforeDrawLineImageEventListEx.IndexOf(Item : TVTBeforeDrawLineImageEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTBeforeDrawLineImageEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTBeforeDrawLineImageEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTBeforeDrawLineImageEventListEx.Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Level : Integer; Var PosX : Integer);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTBeforeDrawLineImageEvent(lItem.Method)(Sender, Node, Level, PosX);
  End;
End;

Function TVTBeforeGetMaxColumnWidthEventListEx.Get(Index : Integer) : TVTBeforeGetMaxColumnWidthEvent;
Begin
  Result := TVTBeforeGetMaxColumnWidthEvent(InHerited Items[Index].Method);
End;

Procedure TVTBeforeGetMaxColumnWidthEventListEx.Put(Index : Integer; Item : TVTBeforeGetMaxColumnWidthEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTBeforeGetMaxColumnWidthEventListEx.Add(Item : TVTBeforeGetMaxColumnWidthEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTBeforeGetMaxColumnWidthEventListEx.Insert(Index: Integer; Item : TVTBeforeGetMaxColumnWidthEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTBeforeGetMaxColumnWidthEventListEx.Remove(Item : TVTBeforeGetMaxColumnWidthEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTBeforeGetMaxColumnWidthEventListEx.IndexOf(Item : TVTBeforeGetMaxColumnWidthEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTBeforeGetMaxColumnWidthEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTBeforeGetMaxColumnWidthEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTBeforeGetMaxColumnWidthEventListEx.Execute(Sender : TVTHeader; Column : TColumnIndex; Var UseSmartColumnWidth : Boolean);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTBeforeGetMaxColumnWidthEvent(lItem.Method)(Sender, Column, UseSmartColumnWidth);
  End;
End;

Function TVTBeforeHeaderHeightTrackingEventListEx.Get(Index : Integer) : TVTBeforeHeaderHeightTrackingEvent;
Begin
  Result := TVTBeforeHeaderHeightTrackingEvent(InHerited Items[Index].Method);
End;

Procedure TVTBeforeHeaderHeightTrackingEventListEx.Put(Index : Integer; Item : TVTBeforeHeaderHeightTrackingEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTBeforeHeaderHeightTrackingEventListEx.Add(Item : TVTBeforeHeaderHeightTrackingEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTBeforeHeaderHeightTrackingEventListEx.Insert(Index: Integer; Item : TVTBeforeHeaderHeightTrackingEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTBeforeHeaderHeightTrackingEventListEx.Remove(Item : TVTBeforeHeaderHeightTrackingEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTBeforeHeaderHeightTrackingEventListEx.IndexOf(Item : TVTBeforeHeaderHeightTrackingEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTBeforeHeaderHeightTrackingEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTBeforeHeaderHeightTrackingEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTBeforeHeaderHeightTrackingEventListEx.Execute(Sender : TVTHeader; Shift : TShiftState);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTBeforeHeaderHeightTrackingEvent(lItem.Method)(Sender, Shift);
  End;
End;

Function TVTBeforeItemEraseEventListEx.Get(Index : Integer) : TVTBeforeItemEraseEvent;
Begin
  Result := TVTBeforeItemEraseEvent(InHerited Items[Index].Method);
End;

Procedure TVTBeforeItemEraseEventListEx.Put(Index : Integer; Item : TVTBeforeItemEraseEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTBeforeItemEraseEventListEx.Add(Item : TVTBeforeItemEraseEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTBeforeItemEraseEventListEx.Insert(Index: Integer; Item : TVTBeforeItemEraseEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTBeforeItemEraseEventListEx.Remove(Item : TVTBeforeItemEraseEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTBeforeItemEraseEventListEx.IndexOf(Item : TVTBeforeItemEraseEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTBeforeItemEraseEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTBeforeItemEraseEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTBeforeItemEraseEventListEx.Execute(Sender : TBaseVirtualTree; TargetCanvas : TCanvas; Node : PVirtualNode; ItemRect : TRect; Var ItemColor : TColor; Var EraseAction : TItemEraseAction);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTBeforeItemEraseEvent(lItem.Method)(Sender, TargetCanvas, Node, ItemRect, ItemColor, EraseAction);
  End;
End;

Function TVTBeforeItemPaintEventListEx.Get(Index : Integer) : TVTBeforeItemPaintEvent;
Begin
  Result := TVTBeforeItemPaintEvent(InHerited Items[Index].Method);
End;

Procedure TVTBeforeItemPaintEventListEx.Put(Index : Integer; Item : TVTBeforeItemPaintEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTBeforeItemPaintEventListEx.Add(Item : TVTBeforeItemPaintEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTBeforeItemPaintEventListEx.Insert(Index: Integer; Item : TVTBeforeItemPaintEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTBeforeItemPaintEventListEx.Remove(Item : TVTBeforeItemPaintEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTBeforeItemPaintEventListEx.IndexOf(Item : TVTBeforeItemPaintEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTBeforeItemPaintEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTBeforeItemPaintEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTBeforeItemPaintEventListEx.Execute(Sender : TBaseVirtualTree; TargetCanvas : TCanvas; Node : PVirtualNode; ItemRect : TRect; Var CustomDraw : Boolean);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTBeforeItemPaintEvent(lItem.Method)(Sender, TargetCanvas, Node, ItemRect, CustomDraw);
  End;
End;

Function TCanResizeEventListEx.Get(Index : Integer) : TCanResizeEvent;
Begin
  Result := TCanResizeEvent(InHerited Items[Index].Method);
End;

Procedure TCanResizeEventListEx.Put(Index : Integer; Item : TCanResizeEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TCanResizeEventListEx.Add(Item : TCanResizeEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TCanResizeEventListEx.Insert(Index: Integer; Item : TCanResizeEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TCanResizeEventListEx.Remove(Item : TCanResizeEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TCanResizeEventListEx.IndexOf(Item : TCanResizeEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TCanResizeEventListEx.GetExecuteProc() : TMethod;
Var lResult : TCanResizeEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TCanResizeEventListEx.Execute(Sender : TObject; Var NewWidth : Integer; Var NewHeight : Integer; Var Resize : Boolean);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TCanResizeEvent(lItem.Method)(Sender, NewWidth, NewHeight, Resize);
  End;
End;

Function TVTCanSplitterResizeColumnEventListEx.Get(Index : Integer) : TVTCanSplitterResizeColumnEvent;
Begin
  Result := TVTCanSplitterResizeColumnEvent(InHerited Items[Index].Method);
End;

Procedure TVTCanSplitterResizeColumnEventListEx.Put(Index : Integer; Item : TVTCanSplitterResizeColumnEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTCanSplitterResizeColumnEventListEx.Add(Item : TVTCanSplitterResizeColumnEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTCanSplitterResizeColumnEventListEx.Insert(Index: Integer; Item : TVTCanSplitterResizeColumnEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTCanSplitterResizeColumnEventListEx.Remove(Item : TVTCanSplitterResizeColumnEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTCanSplitterResizeColumnEventListEx.IndexOf(Item : TVTCanSplitterResizeColumnEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTCanSplitterResizeColumnEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTCanSplitterResizeColumnEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTCanSplitterResizeColumnEventListEx.Execute(Sender : TVTHeader; P : TPoint; Column : TColumnIndex; Var Allowed : Boolean);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTCanSplitterResizeColumnEvent(lItem.Method)(Sender, P, Column, Allowed);
  End;
End;

Function TVTCanSplitterResizeHeaderEventListEx.Get(Index : Integer) : TVTCanSplitterResizeHeaderEvent;
Begin
  Result := TVTCanSplitterResizeHeaderEvent(InHerited Items[Index].Method);
End;

Procedure TVTCanSplitterResizeHeaderEventListEx.Put(Index : Integer; Item : TVTCanSplitterResizeHeaderEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTCanSplitterResizeHeaderEventListEx.Add(Item : TVTCanSplitterResizeHeaderEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTCanSplitterResizeHeaderEventListEx.Insert(Index: Integer; Item : TVTCanSplitterResizeHeaderEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTCanSplitterResizeHeaderEventListEx.Remove(Item : TVTCanSplitterResizeHeaderEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTCanSplitterResizeHeaderEventListEx.IndexOf(Item : TVTCanSplitterResizeHeaderEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTCanSplitterResizeHeaderEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTCanSplitterResizeHeaderEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTCanSplitterResizeHeaderEventListEx.Execute(Sender : TVTHeader; P : TPoint; Var Allowed : Boolean);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTCanSplitterResizeHeaderEvent(lItem.Method)(Sender, P, Allowed);
  End;
End;

Function TVTCanSplitterResizeNodeEventListEx.Get(Index : Integer) : TVTCanSplitterResizeNodeEvent;
Begin
  Result := TVTCanSplitterResizeNodeEvent(InHerited Items[Index].Method);
End;

Procedure TVTCanSplitterResizeNodeEventListEx.Put(Index : Integer; Item : TVTCanSplitterResizeNodeEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTCanSplitterResizeNodeEventListEx.Add(Item : TVTCanSplitterResizeNodeEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTCanSplitterResizeNodeEventListEx.Insert(Index: Integer; Item : TVTCanSplitterResizeNodeEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTCanSplitterResizeNodeEventListEx.Remove(Item : TVTCanSplitterResizeNodeEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTCanSplitterResizeNodeEventListEx.IndexOf(Item : TVTCanSplitterResizeNodeEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTCanSplitterResizeNodeEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTCanSplitterResizeNodeEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTCanSplitterResizeNodeEventListEx.Execute(Sender : TBaseVirtualTree; P : TPoint; Node : PVirtualNode; Column : TColumnIndex; Var Allowed : Boolean);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTCanSplitterResizeNodeEvent(lItem.Method)(Sender, P, Node, Column, Allowed);
  End;
End;

Function TVTChangeEventListEx.Get(Index : Integer) : TVTChangeEvent;
Begin
  Result := TVTChangeEvent(InHerited Items[Index].Method);
End;

Procedure TVTChangeEventListEx.Put(Index : Integer; Item : TVTChangeEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTChangeEventListEx.Add(Item : TVTChangeEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTChangeEventListEx.Insert(Index: Integer; Item : TVTChangeEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTChangeEventListEx.Remove(Item : TVTChangeEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTChangeEventListEx.IndexOf(Item : TVTChangeEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTChangeEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTChangeEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTChangeEventListEx.Execute(Sender : TBaseVirtualTree; Node : PVirtualNode);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTChangeEvent(lItem.Method)(Sender, Node);
  End;
End;

Function TVTCheckChangingEventListEx.Get(Index : Integer) : TVTCheckChangingEvent;
Begin
  Result := TVTCheckChangingEvent(InHerited Items[Index].Method);
End;

Procedure TVTCheckChangingEventListEx.Put(Index : Integer; Item : TVTCheckChangingEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTCheckChangingEventListEx.Add(Item : TVTCheckChangingEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTCheckChangingEventListEx.Insert(Index: Integer; Item : TVTCheckChangingEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTCheckChangingEventListEx.Remove(Item : TVTCheckChangingEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTCheckChangingEventListEx.IndexOf(Item : TVTCheckChangingEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTCheckChangingEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTCheckChangingEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTCheckChangingEventListEx.Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Var NewState : TCheckState; Var Allowed : Boolean);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTCheckChangingEvent(lItem.Method)(Sender, Node, NewState, Allowed);
  End;
End;

Function TVTChangingEventListEx.Get(Index : Integer) : TVTChangingEvent;
Begin
  Result := TVTChangingEvent(InHerited Items[Index].Method);
End;

Procedure TVTChangingEventListEx.Put(Index : Integer; Item : TVTChangingEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTChangingEventListEx.Add(Item : TVTChangingEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTChangingEventListEx.Insert(Index: Integer; Item : TVTChangingEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTChangingEventListEx.Remove(Item : TVTChangingEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTChangingEventListEx.IndexOf(Item : TVTChangingEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTChangingEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTChangingEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTChangingEventListEx.Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Var Allowed : Boolean);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTChangingEvent(lItem.Method)(Sender, Node, Allowed);
  End;
End;

Function TVTColumnClickEventListEx.Get(Index : Integer) : TVTColumnClickEvent;
Begin
  Result := TVTColumnClickEvent(InHerited Items[Index].Method);
End;

Procedure TVTColumnClickEventListEx.Put(Index : Integer; Item : TVTColumnClickEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTColumnClickEventListEx.Add(Item : TVTColumnClickEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTColumnClickEventListEx.Insert(Index: Integer; Item : TVTColumnClickEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTColumnClickEventListEx.Remove(Item : TVTColumnClickEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTColumnClickEventListEx.IndexOf(Item : TVTColumnClickEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTColumnClickEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTColumnClickEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTColumnClickEventListEx.Execute(Sender : TBaseVirtualTree; Column : TColumnIndex; Shift : TShiftState);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTColumnClickEvent(lItem.Method)(Sender, Column, Shift);
  End;
End;

Function TVTColumnDblClickEventListEx.Get(Index : Integer) : TVTColumnDblClickEvent;
Begin
  Result := TVTColumnDblClickEvent(InHerited Items[Index].Method);
End;

Procedure TVTColumnDblClickEventListEx.Put(Index : Integer; Item : TVTColumnDblClickEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTColumnDblClickEventListEx.Add(Item : TVTColumnDblClickEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTColumnDblClickEventListEx.Insert(Index: Integer; Item : TVTColumnDblClickEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTColumnDblClickEventListEx.Remove(Item : TVTColumnDblClickEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTColumnDblClickEventListEx.IndexOf(Item : TVTColumnDblClickEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTColumnDblClickEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTColumnDblClickEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTColumnDblClickEventListEx.Execute(Sender : TBaseVirtualTree; Column : TColumnIndex; Shift : TShiftState);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTColumnDblClickEvent(lItem.Method)(Sender, Column, Shift);
  End;
End;

Function TVTHeaderNotifyEventListEx.Get(Index : Integer) : TVTHeaderNotifyEvent;
Begin
  Result := TVTHeaderNotifyEvent(InHerited Items[Index].Method);
End;

Procedure TVTHeaderNotifyEventListEx.Put(Index : Integer; Item : TVTHeaderNotifyEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTHeaderNotifyEventListEx.Add(Item : TVTHeaderNotifyEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTHeaderNotifyEventListEx.Insert(Index: Integer; Item : TVTHeaderNotifyEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTHeaderNotifyEventListEx.Remove(Item : TVTHeaderNotifyEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTHeaderNotifyEventListEx.IndexOf(Item : TVTHeaderNotifyEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTHeaderNotifyEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTHeaderNotifyEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTHeaderNotifyEventListEx.Execute(Sender : TVTHeader; Column : TColumnIndex);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTHeaderNotifyEvent(lItem.Method)(Sender, Column);
  End;
End;

Function TColumnChangeEventListEx.Get(Index : Integer) : TColumnChangeEvent;
Begin
  Result := TColumnChangeEvent(InHerited Items[Index].Method);
End;

Procedure TColumnChangeEventListEx.Put(Index : Integer; Item : TColumnChangeEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TColumnChangeEventListEx.Add(Item : TColumnChangeEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TColumnChangeEventListEx.Insert(Index: Integer; Item : TColumnChangeEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TColumnChangeEventListEx.Remove(Item : TColumnChangeEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TColumnChangeEventListEx.IndexOf(Item : TColumnChangeEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TColumnChangeEventListEx.GetExecuteProc() : TMethod;
Var lResult : TColumnChangeEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TColumnChangeEventListEx.Execute(Const Sender : TBaseVirtualTree; Const Column : TColumnIndex; Visible : Boolean);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TColumnChangeEvent(lItem.Method)(Sender, Column, Visible);
  End;
End;

Function TVTColumnWidthDblClickResizeEventListEx.Get(Index : Integer) : TVTColumnWidthDblClickResizeEvent;
Begin
  Result := TVTColumnWidthDblClickResizeEvent(InHerited Items[Index].Method);
End;

Procedure TVTColumnWidthDblClickResizeEventListEx.Put(Index : Integer; Item : TVTColumnWidthDblClickResizeEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTColumnWidthDblClickResizeEventListEx.Add(Item : TVTColumnWidthDblClickResizeEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTColumnWidthDblClickResizeEventListEx.Insert(Index: Integer; Item : TVTColumnWidthDblClickResizeEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTColumnWidthDblClickResizeEventListEx.Remove(Item : TVTColumnWidthDblClickResizeEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTColumnWidthDblClickResizeEventListEx.IndexOf(Item : TVTColumnWidthDblClickResizeEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTColumnWidthDblClickResizeEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTColumnWidthDblClickResizeEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTColumnWidthDblClickResizeEventListEx.Execute(Sender : TVTHeader; Column : TColumnIndex; Shift : TShiftState; P : TPoint; Var Allowed : Boolean);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTColumnWidthDblClickResizeEvent(lItem.Method)(Sender, Column, Shift, P, Allowed);
  End;
End;

Function TVTColumnWidthTrackingEventListEx.Get(Index : Integer) : TVTColumnWidthTrackingEvent;
Begin
  Result := TVTColumnWidthTrackingEvent(InHerited Items[Index].Method);
End;

Procedure TVTColumnWidthTrackingEventListEx.Put(Index : Integer; Item : TVTColumnWidthTrackingEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTColumnWidthTrackingEventListEx.Add(Item : TVTColumnWidthTrackingEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTColumnWidthTrackingEventListEx.Insert(Index: Integer; Item : TVTColumnWidthTrackingEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTColumnWidthTrackingEventListEx.Remove(Item : TVTColumnWidthTrackingEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTColumnWidthTrackingEventListEx.IndexOf(Item : TVTColumnWidthTrackingEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTColumnWidthTrackingEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTColumnWidthTrackingEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTColumnWidthTrackingEventListEx.Execute(Sender : TVTHeader; Column : TColumnIndex; Shift : TShiftState; Var TrackPoint : TPoint; P : TPoint; Var Allowed : Boolean);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTColumnWidthTrackingEvent(lItem.Method)(Sender, Column, Shift, TrackPoint, P, Allowed);
  End;
End;

Function TVTCompareEventListEx.Get(Index : Integer) : TVTCompareEvent;
Begin
  Result := TVTCompareEvent(InHerited Items[Index].Method);
End;

Procedure TVTCompareEventListEx.Put(Index : Integer; Item : TVTCompareEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTCompareEventListEx.Add(Item : TVTCompareEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTCompareEventListEx.Insert(Index: Integer; Item : TVTCompareEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTCompareEventListEx.Remove(Item : TVTCompareEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTCompareEventListEx.IndexOf(Item : TVTCompareEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTCompareEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTCompareEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTCompareEventListEx.Execute(Sender : TBaseVirtualTree; Node1 : PVirtualNode; Node2 : PVirtualNode; Column : TColumnIndex; Var Result : Integer);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTCompareEvent(lItem.Method)(Sender, Node1, Node2, Column, Result);
  End;
End;

Function TVTCreateDataObjectEventListEx.Get(Index : Integer) : TVTCreateDataObjectEvent;
Begin
  Result := TVTCreateDataObjectEvent(InHerited Items[Index].Method);
End;

Procedure TVTCreateDataObjectEventListEx.Put(Index : Integer; Item : TVTCreateDataObjectEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTCreateDataObjectEventListEx.Add(Item : TVTCreateDataObjectEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTCreateDataObjectEventListEx.Insert(Index: Integer; Item : TVTCreateDataObjectEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTCreateDataObjectEventListEx.Remove(Item : TVTCreateDataObjectEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTCreateDataObjectEventListEx.IndexOf(Item : TVTCreateDataObjectEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTCreateDataObjectEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTCreateDataObjectEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTCreateDataObjectEventListEx.Execute(Sender : TBaseVirtualTree; Out IDataObject : IDataObject);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTCreateDataObjectEvent(lItem.Method)(Sender, IDataObject);
  End;
End;

Function TVTCreateDragManagerEventListEx.Get(Index : Integer) : TVTCreateDragManagerEvent;
Begin
  Result := TVTCreateDragManagerEvent(InHerited Items[Index].Method);
End;

Procedure TVTCreateDragManagerEventListEx.Put(Index : Integer; Item : TVTCreateDragManagerEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTCreateDragManagerEventListEx.Add(Item : TVTCreateDragManagerEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTCreateDragManagerEventListEx.Insert(Index: Integer; Item : TVTCreateDragManagerEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTCreateDragManagerEventListEx.Remove(Item : TVTCreateDragManagerEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTCreateDragManagerEventListEx.IndexOf(Item : TVTCreateDragManagerEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTCreateDragManagerEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTCreateDragManagerEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTCreateDragManagerEventListEx.Execute(Sender : TBaseVirtualTree; Out DragManager : IVTDragManager);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTCreateDragManagerEvent(lItem.Method)(Sender, DragManager);
  End;
End;

Function TVTCreateEditorEventListEx.Get(Index : Integer) : TVTCreateEditorEvent;
Begin
  Result := TVTCreateEditorEvent(InHerited Items[Index].Method);
End;

Procedure TVTCreateEditorEventListEx.Put(Index : Integer; Item : TVTCreateEditorEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTCreateEditorEventListEx.Add(Item : TVTCreateEditorEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTCreateEditorEventListEx.Insert(Index: Integer; Item : TVTCreateEditorEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTCreateEditorEventListEx.Remove(Item : TVTCreateEditorEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTCreateEditorEventListEx.IndexOf(Item : TVTCreateEditorEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTCreateEditorEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTCreateEditorEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTCreateEditorEventListEx.Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex; Out EditLink : IVTEditLink);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTCreateEditorEvent(lItem.Method)(Sender, Node, Column, EditLink);
  End;
End;

Function TVTDragAllowedEventListEx.Get(Index : Integer) : TVTDragAllowedEvent;
Begin
  Result := TVTDragAllowedEvent(InHerited Items[Index].Method);
End;

Procedure TVTDragAllowedEventListEx.Put(Index : Integer; Item : TVTDragAllowedEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTDragAllowedEventListEx.Add(Item : TVTDragAllowedEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTDragAllowedEventListEx.Insert(Index: Integer; Item : TVTDragAllowedEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTDragAllowedEventListEx.Remove(Item : TVTDragAllowedEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTDragAllowedEventListEx.IndexOf(Item : TVTDragAllowedEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTDragAllowedEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTDragAllowedEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTDragAllowedEventListEx.Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex; Var Allowed : Boolean);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTDragAllowedEvent(lItem.Method)(Sender, Node, Column, Allowed);
  End;
End;

Function TVTDragDropEventListEx.Get(Index : Integer) : TVTDragDropEvent;
Begin
  Result := TVTDragDropEvent(InHerited Items[Index].Method);
End;

Procedure TVTDragDropEventListEx.Put(Index : Integer; Item : TVTDragDropEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTDragDropEventListEx.Add(Item : TVTDragDropEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTDragDropEventListEx.Insert(Index: Integer; Item : TVTDragDropEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTDragDropEventListEx.Remove(Item : TVTDragDropEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTDragDropEventListEx.IndexOf(Item : TVTDragDropEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTDragDropEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTDragDropEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTDragDropEventListEx.Execute(Sender : TBaseVirtualTree; Source : TObject; DataObject : IDataObject; Formats : TFormatArray; Shift : TShiftState; Pt : TPoint; Var Effect : Integer; Mode : TDropMode);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTDragDropEvent(lItem.Method)(Sender, Source, DataObject, Formats, Shift, Pt, Effect, Mode);
  End;
End;

Function TVTDragOverEventListEx.Get(Index : Integer) : TVTDragOverEvent;
Begin
  Result := TVTDragOverEvent(InHerited Items[Index].Method);
End;

Procedure TVTDragOverEventListEx.Put(Index : Integer; Item : TVTDragOverEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTDragOverEventListEx.Add(Item : TVTDragOverEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTDragOverEventListEx.Insert(Index: Integer; Item : TVTDragOverEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTDragOverEventListEx.Remove(Item : TVTDragOverEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTDragOverEventListEx.IndexOf(Item : TVTDragOverEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTDragOverEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTDragOverEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTDragOverEventListEx.Execute(Sender : TBaseVirtualTree; Source : TObject; Shift : TShiftState; State : TDragState; Pt : TPoint; Mode : TDropMode; Var Effect : Integer; Var Accept : Boolean);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTDragOverEvent(lItem.Method)(Sender, Source, Shift, State, Pt, Mode, Effect, Accept);
  End;
End;

Function TVTDrawHintEventListEx.Get(Index : Integer) : TVTDrawHintEvent;
Begin
  Result := TVTDrawHintEvent(InHerited Items[Index].Method);
End;

Procedure TVTDrawHintEventListEx.Put(Index : Integer; Item : TVTDrawHintEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTDrawHintEventListEx.Add(Item : TVTDrawHintEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTDrawHintEventListEx.Insert(Index: Integer; Item : TVTDrawHintEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTDrawHintEventListEx.Remove(Item : TVTDrawHintEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTDrawHintEventListEx.IndexOf(Item : TVTDrawHintEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTDrawHintEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTDrawHintEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTDrawHintEventListEx.Execute(Sender : TBaseVirtualTree; HintCanvas : TCanvas; Node : PVirtualNode; R : TRect; Column : TColumnIndex);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTDrawHintEvent(lItem.Method)(Sender, HintCanvas, Node, R, Column);
  End;
End;

Function TVTDrawTextEventListEx.Get(Index : Integer) : TVTDrawTextEvent;
Begin
  Result := TVTDrawTextEvent(InHerited Items[Index].Method);
End;

Procedure TVTDrawTextEventListEx.Put(Index : Integer; Item : TVTDrawTextEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTDrawTextEventListEx.Add(Item : TVTDrawTextEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTDrawTextEventListEx.Insert(Index: Integer; Item : TVTDrawTextEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTDrawTextEventListEx.Remove(Item : TVTDrawTextEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTDrawTextEventListEx.IndexOf(Item : TVTDrawTextEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTDrawTextEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTDrawTextEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTDrawTextEventListEx.Execute(Sender : TBaseVirtualTree; TargetCanvas : TCanvas; Node : PVirtualNode; Column : TColumnIndex; Const Text : WideString; Const CellRect : TRect; Var DefaultDraw : Boolean);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTDrawTextEvent(lItem.Method)(Sender, TargetCanvas, Node, Column, Text, CellRect, DefaultDraw);
  End;
End;

Function TVTEditCancelEventListEx.Get(Index : Integer) : TVTEditCancelEvent;
Begin
  Result := TVTEditCancelEvent(InHerited Items[Index].Method);
End;

Procedure TVTEditCancelEventListEx.Put(Index : Integer; Item : TVTEditCancelEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTEditCancelEventListEx.Add(Item : TVTEditCancelEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTEditCancelEventListEx.Insert(Index: Integer; Item : TVTEditCancelEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTEditCancelEventListEx.Remove(Item : TVTEditCancelEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTEditCancelEventListEx.IndexOf(Item : TVTEditCancelEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTEditCancelEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTEditCancelEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTEditCancelEventListEx.Execute(Sender : TBaseVirtualTree; Column : TColumnIndex);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTEditCancelEvent(lItem.Method)(Sender, Column);
  End;
End;

Function TVTEditChangeEventListEx.Get(Index : Integer) : TVTEditChangeEvent;
Begin
  Result := TVTEditChangeEvent(InHerited Items[Index].Method);
End;

Procedure TVTEditChangeEventListEx.Put(Index : Integer; Item : TVTEditChangeEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTEditChangeEventListEx.Add(Item : TVTEditChangeEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTEditChangeEventListEx.Insert(Index: Integer; Item : TVTEditChangeEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTEditChangeEventListEx.Remove(Item : TVTEditChangeEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTEditChangeEventListEx.IndexOf(Item : TVTEditChangeEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTEditChangeEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTEditChangeEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTEditChangeEventListEx.Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTEditChangeEvent(lItem.Method)(Sender, Node, Column);
  End;
End;

Function TVTEditChangingEventListEx.Get(Index : Integer) : TVTEditChangingEvent;
Begin
  Result := TVTEditChangingEvent(InHerited Items[Index].Method);
End;

Procedure TVTEditChangingEventListEx.Put(Index : Integer; Item : TVTEditChangingEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTEditChangingEventListEx.Add(Item : TVTEditChangingEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTEditChangingEventListEx.Insert(Index: Integer; Item : TVTEditChangingEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTEditChangingEventListEx.Remove(Item : TVTEditChangingEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTEditChangingEventListEx.IndexOf(Item : TVTEditChangingEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTEditChangingEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTEditChangingEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTEditChangingEventListEx.Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex; Var Allowed : Boolean);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTEditChangingEvent(lItem.Method)(Sender, Node, Column, Allowed);
  End;
End;

Function TVTOperationEventListEx.Get(Index : Integer) : TVTOperationEvent;
Begin
  Result := TVTOperationEvent(InHerited Items[Index].Method);
End;

Procedure TVTOperationEventListEx.Put(Index : Integer; Item : TVTOperationEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTOperationEventListEx.Add(Item : TVTOperationEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTOperationEventListEx.Insert(Index: Integer; Item : TVTOperationEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTOperationEventListEx.Remove(Item : TVTOperationEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTOperationEventListEx.IndexOf(Item : TVTOperationEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTOperationEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTOperationEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTOperationEventListEx.Execute(Sender : TBaseVirtualTree; OperationKind : TVTOperationKind);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTOperationEvent(lItem.Method)(Sender, OperationKind);
  End;
End;

Function TVTFocusChangeEventListEx.Get(Index : Integer) : TVTFocusChangeEvent;
Begin
  Result := TVTFocusChangeEvent(InHerited Items[Index].Method);
End;

Procedure TVTFocusChangeEventListEx.Put(Index : Integer; Item : TVTFocusChangeEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTFocusChangeEventListEx.Add(Item : TVTFocusChangeEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTFocusChangeEventListEx.Insert(Index: Integer; Item : TVTFocusChangeEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTFocusChangeEventListEx.Remove(Item : TVTFocusChangeEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTFocusChangeEventListEx.IndexOf(Item : TVTFocusChangeEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTFocusChangeEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTFocusChangeEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTFocusChangeEventListEx.Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTFocusChangeEvent(lItem.Method)(Sender, Node, Column);
  End;
End;

Function TVTFocusChangingEventListEx.Get(Index : Integer) : TVTFocusChangingEvent;
Begin
  Result := TVTFocusChangingEvent(InHerited Items[Index].Method);
End;

Procedure TVTFocusChangingEventListEx.Put(Index : Integer; Item : TVTFocusChangingEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTFocusChangingEventListEx.Add(Item : TVTFocusChangingEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTFocusChangingEventListEx.Insert(Index: Integer; Item : TVTFocusChangingEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTFocusChangingEventListEx.Remove(Item : TVTFocusChangingEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTFocusChangingEventListEx.IndexOf(Item : TVTFocusChangingEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTFocusChangingEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTFocusChangingEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTFocusChangingEventListEx.Execute(Sender : TBaseVirtualTree; OldNode : PVirtualNode; NewNode : PVirtualNode; OldColumn : TColumnIndex; NewColumn : TColumnIndex; Var Allowed : Boolean);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTFocusChangingEvent(lItem.Method)(Sender, OldNode, NewNode, OldColumn, NewColumn, Allowed);
  End;
End;

Function TVTFreeNodeEventListEx.Get(Index : Integer) : TVTFreeNodeEvent;
Begin
  Result := TVTFreeNodeEvent(InHerited Items[Index].Method);
End;

Procedure TVTFreeNodeEventListEx.Put(Index : Integer; Item : TVTFreeNodeEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTFreeNodeEventListEx.Add(Item : TVTFreeNodeEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTFreeNodeEventListEx.Insert(Index: Integer; Item : TVTFreeNodeEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTFreeNodeEventListEx.Remove(Item : TVTFreeNodeEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTFreeNodeEventListEx.IndexOf(Item : TVTFreeNodeEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTFreeNodeEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTFreeNodeEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTFreeNodeEventListEx.Execute(Sender : TBaseVirtualTree; Node : PVirtualNode);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTFreeNodeEvent(lItem.Method)(Sender, Node);
  End;
End;

Function TVTGetCellIsEmptyEventListEx.Get(Index : Integer) : TVTGetCellIsEmptyEvent;
Begin
  Result := TVTGetCellIsEmptyEvent(InHerited Items[Index].Method);
End;

Procedure TVTGetCellIsEmptyEventListEx.Put(Index : Integer; Item : TVTGetCellIsEmptyEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTGetCellIsEmptyEventListEx.Add(Item : TVTGetCellIsEmptyEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTGetCellIsEmptyEventListEx.Insert(Index: Integer; Item : TVTGetCellIsEmptyEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTGetCellIsEmptyEventListEx.Remove(Item : TVTGetCellIsEmptyEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTGetCellIsEmptyEventListEx.IndexOf(Item : TVTGetCellIsEmptyEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTGetCellIsEmptyEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTGetCellIsEmptyEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTGetCellIsEmptyEventListEx.Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex; Var IsEmpty : Boolean);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTGetCellIsEmptyEvent(lItem.Method)(Sender, Node, Column, IsEmpty);
  End;
End;

Function TVSTGetCellTextEventListEx.Get(Index : Integer) : TVSTGetCellTextEvent;
Begin
  Result := TVSTGetCellTextEvent(InHerited Items[Index].Method);
End;

Procedure TVSTGetCellTextEventListEx.Put(Index : Integer; Item : TVSTGetCellTextEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVSTGetCellTextEventListEx.Add(Item : TVSTGetCellTextEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVSTGetCellTextEventListEx.Insert(Index: Integer; Item : TVSTGetCellTextEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVSTGetCellTextEventListEx.Remove(Item : TVSTGetCellTextEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVSTGetCellTextEventListEx.IndexOf(Item : TVSTGetCellTextEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVSTGetCellTextEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVSTGetCellTextEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVSTGetCellTextEventListEx.Execute(Sender : TCustomVirtualStringTree; Var E : TVSTGetCellTextEventArgs);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVSTGetCellTextEvent(lItem.Method)(Sender, E);
  End;
End;

Function TVTGetCursorEventListEx.Get(Index : Integer) : TVTGetCursorEvent;
Begin
  Result := TVTGetCursorEvent(InHerited Items[Index].Method);
End;

Procedure TVTGetCursorEventListEx.Put(Index : Integer; Item : TVTGetCursorEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTGetCursorEventListEx.Add(Item : TVTGetCursorEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTGetCursorEventListEx.Insert(Index: Integer; Item : TVTGetCursorEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTGetCursorEventListEx.Remove(Item : TVTGetCursorEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTGetCursorEventListEx.IndexOf(Item : TVTGetCursorEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTGetCursorEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTGetCursorEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTGetCursorEventListEx.Execute(Sender : TBaseVirtualTree; Var Cursor : TCursor);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTGetCursorEvent(lItem.Method)(Sender, Cursor);
  End;
End;

Function TVTGetHeaderCursorEventListEx.Get(Index : Integer) : TVTGetHeaderCursorEvent;
Begin
  Result := TVTGetHeaderCursorEvent(InHerited Items[Index].Method);
End;

Procedure TVTGetHeaderCursorEventListEx.Put(Index : Integer; Item : TVTGetHeaderCursorEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTGetHeaderCursorEventListEx.Add(Item : TVTGetHeaderCursorEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTGetHeaderCursorEventListEx.Insert(Index: Integer; Item : TVTGetHeaderCursorEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTGetHeaderCursorEventListEx.Remove(Item : TVTGetHeaderCursorEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTGetHeaderCursorEventListEx.IndexOf(Item : TVTGetHeaderCursorEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTGetHeaderCursorEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTGetHeaderCursorEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTGetHeaderCursorEventListEx.Execute(Sender : TVTHeader; Var Cursor : HICON);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTGetHeaderCursorEvent(lItem.Method)(Sender, Cursor);
  End;
End;

Function TVTHelpContextEventListEx.Get(Index : Integer) : TVTHelpContextEvent;
Begin
  Result := TVTHelpContextEvent(InHerited Items[Index].Method);
End;

Procedure TVTHelpContextEventListEx.Put(Index : Integer; Item : TVTHelpContextEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTHelpContextEventListEx.Add(Item : TVTHelpContextEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTHelpContextEventListEx.Insert(Index: Integer; Item : TVTHelpContextEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTHelpContextEventListEx.Remove(Item : TVTHelpContextEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTHelpContextEventListEx.IndexOf(Item : TVTHelpContextEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTHelpContextEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTHelpContextEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTHelpContextEventListEx.Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex; Var HelpContext : Integer);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTHelpContextEvent(lItem.Method)(Sender, Node, Column, HelpContext);
  End;
End;

Function TVSTGetHintEventListEx.Get(Index : Integer) : TVSTGetHintEvent;
Begin
  Result := TVSTGetHintEvent(InHerited Items[Index].Method);
End;

Procedure TVSTGetHintEventListEx.Put(Index : Integer; Item : TVSTGetHintEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVSTGetHintEventListEx.Add(Item : TVSTGetHintEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVSTGetHintEventListEx.Insert(Index: Integer; Item : TVSTGetHintEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVSTGetHintEventListEx.Remove(Item : TVSTGetHintEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVSTGetHintEventListEx.IndexOf(Item : TVSTGetHintEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVSTGetHintEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVSTGetHintEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVSTGetHintEventListEx.Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex; Var LineBreakStyle : TVTTooltipLineBreakStyle; Var HintText : WideString);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVSTGetHintEvent(lItem.Method)(Sender, Node, Column, LineBreakStyle, HintText);
  End;
End;

Function TVTHintKindEventListEx.Get(Index : Integer) : TVTHintKindEvent;
Begin
  Result := TVTHintKindEvent(InHerited Items[Index].Method);
End;

Procedure TVTHintKindEventListEx.Put(Index : Integer; Item : TVTHintKindEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTHintKindEventListEx.Add(Item : TVTHintKindEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTHintKindEventListEx.Insert(Index: Integer; Item : TVTHintKindEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTHintKindEventListEx.Remove(Item : TVTHintKindEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTHintKindEventListEx.IndexOf(Item : TVTHintKindEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTHintKindEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTHintKindEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTHintKindEventListEx.Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex; Var Kind : TVTHintKind);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTHintKindEvent(lItem.Method)(Sender, Node, Column, Kind);
  End;
End;

Function TVTGetHintSizeEventListEx.Get(Index : Integer) : TVTGetHintSizeEvent;
Begin
  Result := TVTGetHintSizeEvent(InHerited Items[Index].Method);
End;

Procedure TVTGetHintSizeEventListEx.Put(Index : Integer; Item : TVTGetHintSizeEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTGetHintSizeEventListEx.Add(Item : TVTGetHintSizeEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTGetHintSizeEventListEx.Insert(Index: Integer; Item : TVTGetHintSizeEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTGetHintSizeEventListEx.Remove(Item : TVTGetHintSizeEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTGetHintSizeEventListEx.IndexOf(Item : TVTGetHintSizeEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTGetHintSizeEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTGetHintSizeEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTGetHintSizeEventListEx.Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex; Var R : TRect);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTGetHintSizeEvent(lItem.Method)(Sender, Node, Column, R);
  End;
End;

Function TVTGetImageEventListEx.Get(Index : Integer) : TVTGetImageEvent;
Begin
  Result := TVTGetImageEvent(InHerited Items[Index].Method);
End;

Procedure TVTGetImageEventListEx.Put(Index : Integer; Item : TVTGetImageEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTGetImageEventListEx.Add(Item : TVTGetImageEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTGetImageEventListEx.Insert(Index: Integer; Item : TVTGetImageEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTGetImageEventListEx.Remove(Item : TVTGetImageEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTGetImageEventListEx.IndexOf(Item : TVTGetImageEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTGetImageEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTGetImageEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTGetImageEventListEx.Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Kind : TVTImageKind; Column : TColumnIndex; Var Ghosted : Boolean; Var ImageIndex : TImageIndex);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTGetImageEvent(lItem.Method)(Sender, Node, Kind, Column, Ghosted, ImageIndex);
  End;
End;

Function TVTGetImageExEventListEx.Get(Index : Integer) : TVTGetImageExEvent;
Begin
  Result := TVTGetImageExEvent(InHerited Items[Index].Method);
End;

Procedure TVTGetImageExEventListEx.Put(Index : Integer; Item : TVTGetImageExEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTGetImageExEventListEx.Add(Item : TVTGetImageExEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTGetImageExEventListEx.Insert(Index: Integer; Item : TVTGetImageExEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTGetImageExEventListEx.Remove(Item : TVTGetImageExEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTGetImageExEventListEx.IndexOf(Item : TVTGetImageExEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTGetImageExEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTGetImageExEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTGetImageExEventListEx.Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Kind : TVTImageKind; Column : TColumnIndex; Var Ghosted : Boolean; Var ImageIndex : TImageIndex; Var ImageList : TCustomImageList);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTGetImageExEvent(lItem.Method)(Sender, Node, Kind, Column, Ghosted, ImageIndex, ImageList);
  End;
End;

Function TVTGetImageTextEventListEx.Get(Index : Integer) : TVTGetImageTextEvent;
Begin
  Result := TVTGetImageTextEvent(InHerited Items[Index].Method);
End;

Procedure TVTGetImageTextEventListEx.Put(Index : Integer; Item : TVTGetImageTextEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTGetImageTextEventListEx.Add(Item : TVTGetImageTextEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTGetImageTextEventListEx.Insert(Index: Integer; Item : TVTGetImageTextEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTGetImageTextEventListEx.Remove(Item : TVTGetImageTextEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTGetImageTextEventListEx.IndexOf(Item : TVTGetImageTextEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTGetImageTextEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTGetImageTextEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTGetImageTextEventListEx.Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Kind : TVTImageKind; Column : TColumnIndex; Var ImageText : WideString);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTGetImageTextEvent(lItem.Method)(Sender, Node, Kind, Column, ImageText);
  End;
End;

Function TVTGetLineStyleEventListEx.Get(Index : Integer) : TVTGetLineStyleEvent;
Begin
  Result := TVTGetLineStyleEvent(InHerited Items[Index].Method);
End;

Procedure TVTGetLineStyleEventListEx.Put(Index : Integer; Item : TVTGetLineStyleEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTGetLineStyleEventListEx.Add(Item : TVTGetLineStyleEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTGetLineStyleEventListEx.Insert(Index: Integer; Item : TVTGetLineStyleEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTGetLineStyleEventListEx.Remove(Item : TVTGetLineStyleEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTGetLineStyleEventListEx.IndexOf(Item : TVTGetLineStyleEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTGetLineStyleEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTGetLineStyleEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTGetLineStyleEventListEx.Execute(Sender : TBaseVirtualTree; Var Bits : Pointer);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTGetLineStyleEvent(lItem.Method)(Sender, Bits);
  End;
End;

Function TVTGetNodeDataSizeEventListEx.Get(Index : Integer) : TVTGetNodeDataSizeEvent;
Begin
  Result := TVTGetNodeDataSizeEvent(InHerited Items[Index].Method);
End;

Procedure TVTGetNodeDataSizeEventListEx.Put(Index : Integer; Item : TVTGetNodeDataSizeEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTGetNodeDataSizeEventListEx.Add(Item : TVTGetNodeDataSizeEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTGetNodeDataSizeEventListEx.Insert(Index: Integer; Item : TVTGetNodeDataSizeEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTGetNodeDataSizeEventListEx.Remove(Item : TVTGetNodeDataSizeEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTGetNodeDataSizeEventListEx.IndexOf(Item : TVTGetNodeDataSizeEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTGetNodeDataSizeEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTGetNodeDataSizeEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTGetNodeDataSizeEventListEx.Execute(Sender : TBaseVirtualTree; Var NodeDataSize : Integer);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTGetNodeDataSizeEvent(lItem.Method)(Sender, NodeDataSize);
  End;
End;

Function TVTPopupEventListEx.Get(Index : Integer) : TVTPopupEvent;
Begin
  Result := TVTPopupEvent(InHerited Items[Index].Method);
End;

Procedure TVTPopupEventListEx.Put(Index : Integer; Item : TVTPopupEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTPopupEventListEx.Add(Item : TVTPopupEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTPopupEventListEx.Insert(Index: Integer; Item : TVTPopupEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTPopupEventListEx.Remove(Item : TVTPopupEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTPopupEventListEx.IndexOf(Item : TVTPopupEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTPopupEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTPopupEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTPopupEventListEx.Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex; Const P : TPoint; Var AskParent : Boolean; Var PopupMenu : TPopupMenu);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTPopupEvent(lItem.Method)(Sender, Node, Column, P, AskParent, PopupMenu);
  End;
End;

Function TVSTGetTextEventListEx.Get(Index : Integer) : TVSTGetTextEvent;
Begin
  Result := TVSTGetTextEvent(InHerited Items[Index].Method);
End;

Procedure TVSTGetTextEventListEx.Put(Index : Integer; Item : TVSTGetTextEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVSTGetTextEventListEx.Add(Item : TVSTGetTextEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVSTGetTextEventListEx.Insert(Index: Integer; Item : TVSTGetTextEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVSTGetTextEventListEx.Remove(Item : TVSTGetTextEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVSTGetTextEventListEx.IndexOf(Item : TVSTGetTextEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVSTGetTextEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVSTGetTextEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVSTGetTextEventListEx.Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex; TextType : TVSTTextType; Var CellText : WideString);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVSTGetTextEvent(lItem.Method)(Sender, Node, Column, TextType, CellText);
  End;
End;

Function TVTGetUserClipboardFormatsEventListEx.Get(Index : Integer) : TVTGetUserClipboardFormatsEvent;
Begin
  Result := TVTGetUserClipboardFormatsEvent(InHerited Items[Index].Method);
End;

Procedure TVTGetUserClipboardFormatsEventListEx.Put(Index : Integer; Item : TVTGetUserClipboardFormatsEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTGetUserClipboardFormatsEventListEx.Add(Item : TVTGetUserClipboardFormatsEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTGetUserClipboardFormatsEventListEx.Insert(Index: Integer; Item : TVTGetUserClipboardFormatsEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTGetUserClipboardFormatsEventListEx.Remove(Item : TVTGetUserClipboardFormatsEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTGetUserClipboardFormatsEventListEx.IndexOf(Item : TVTGetUserClipboardFormatsEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTGetUserClipboardFormatsEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTGetUserClipboardFormatsEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTGetUserClipboardFormatsEventListEx.Execute(Sender : TBaseVirtualTree; Var Formats : TFormatEtcArray);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTGetUserClipboardFormatsEvent(lItem.Method)(Sender, Formats);
  End;
End;

Function TVTHeaderClickEventListEx.Get(Index : Integer) : TVTHeaderClickEvent;
Begin
  Result := TVTHeaderClickEvent(InHerited Items[Index].Method);
End;

Procedure TVTHeaderClickEventListEx.Put(Index : Integer; Item : TVTHeaderClickEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTHeaderClickEventListEx.Add(Item : TVTHeaderClickEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTHeaderClickEventListEx.Insert(Index: Integer; Item : TVTHeaderClickEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTHeaderClickEventListEx.Remove(Item : TVTHeaderClickEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTHeaderClickEventListEx.IndexOf(Item : TVTHeaderClickEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTHeaderClickEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTHeaderClickEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTHeaderClickEventListEx.Execute(Sender : TVTHeader; HitInfo : TVTHeaderHitInfo);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTHeaderClickEvent(lItem.Method)(Sender, HitInfo);
  End;
End;

Function TVTHeaderDraggedEventListEx.Get(Index : Integer) : TVTHeaderDraggedEvent;
Begin
  Result := TVTHeaderDraggedEvent(InHerited Items[Index].Method);
End;

Procedure TVTHeaderDraggedEventListEx.Put(Index : Integer; Item : TVTHeaderDraggedEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTHeaderDraggedEventListEx.Add(Item : TVTHeaderDraggedEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTHeaderDraggedEventListEx.Insert(Index: Integer; Item : TVTHeaderDraggedEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTHeaderDraggedEventListEx.Remove(Item : TVTHeaderDraggedEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTHeaderDraggedEventListEx.IndexOf(Item : TVTHeaderDraggedEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTHeaderDraggedEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTHeaderDraggedEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTHeaderDraggedEventListEx.Execute(Sender : TVTHeader; Column : TColumnIndex; OldPosition : Integer);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTHeaderDraggedEvent(lItem.Method)(Sender, Column, OldPosition);
  End;
End;

Function TVTHeaderDraggedOutEventListEx.Get(Index : Integer) : TVTHeaderDraggedOutEvent;
Begin
  Result := TVTHeaderDraggedOutEvent(InHerited Items[Index].Method);
End;

Procedure TVTHeaderDraggedOutEventListEx.Put(Index : Integer; Item : TVTHeaderDraggedOutEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTHeaderDraggedOutEventListEx.Add(Item : TVTHeaderDraggedOutEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTHeaderDraggedOutEventListEx.Insert(Index: Integer; Item : TVTHeaderDraggedOutEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTHeaderDraggedOutEventListEx.Remove(Item : TVTHeaderDraggedOutEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTHeaderDraggedOutEventListEx.IndexOf(Item : TVTHeaderDraggedOutEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTHeaderDraggedOutEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTHeaderDraggedOutEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTHeaderDraggedOutEventListEx.Execute(Sender : TVTHeader; Column : TColumnIndex; DropPosition : TPoint);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTHeaderDraggedOutEvent(lItem.Method)(Sender, Column, DropPosition);
  End;
End;

Function TVTHeaderDraggingEventListEx.Get(Index : Integer) : TVTHeaderDraggingEvent;
Begin
  Result := TVTHeaderDraggingEvent(InHerited Items[Index].Method);
End;

Procedure TVTHeaderDraggingEventListEx.Put(Index : Integer; Item : TVTHeaderDraggingEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTHeaderDraggingEventListEx.Add(Item : TVTHeaderDraggingEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTHeaderDraggingEventListEx.Insert(Index: Integer; Item : TVTHeaderDraggingEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTHeaderDraggingEventListEx.Remove(Item : TVTHeaderDraggingEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTHeaderDraggingEventListEx.IndexOf(Item : TVTHeaderDraggingEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTHeaderDraggingEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTHeaderDraggingEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTHeaderDraggingEventListEx.Execute(Sender : TVTHeader; Column : TColumnIndex; Var Allowed : Boolean);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTHeaderDraggingEvent(lItem.Method)(Sender, Column, Allowed);
  End;
End;

Function TVTHeaderPaintEventListEx.Get(Index : Integer) : TVTHeaderPaintEvent;
Begin
  Result := TVTHeaderPaintEvent(InHerited Items[Index].Method);
End;

Procedure TVTHeaderPaintEventListEx.Put(Index : Integer; Item : TVTHeaderPaintEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTHeaderPaintEventListEx.Add(Item : TVTHeaderPaintEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTHeaderPaintEventListEx.Insert(Index: Integer; Item : TVTHeaderPaintEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTHeaderPaintEventListEx.Remove(Item : TVTHeaderPaintEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTHeaderPaintEventListEx.IndexOf(Item : TVTHeaderPaintEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTHeaderPaintEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTHeaderPaintEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTHeaderPaintEventListEx.Execute(Sender : TVTHeader; HeaderCanvas : TCanvas; Column : TVirtualTreeColumn; R : TRect; Hover : Boolean; Pressed : Boolean; DropMark : TVTDropMarkMode);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTHeaderPaintEvent(lItem.Method)(Sender, HeaderCanvas, Column, R, Hover, Pressed, DropMark);
  End;
End;

Function TVTHeaderPaintQueryElementsEventListEx.Get(Index : Integer) : TVTHeaderPaintQueryElementsEvent;
Begin
  Result := TVTHeaderPaintQueryElementsEvent(InHerited Items[Index].Method);
End;

Procedure TVTHeaderPaintQueryElementsEventListEx.Put(Index : Integer; Item : TVTHeaderPaintQueryElementsEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTHeaderPaintQueryElementsEventListEx.Add(Item : TVTHeaderPaintQueryElementsEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTHeaderPaintQueryElementsEventListEx.Insert(Index: Integer; Item : TVTHeaderPaintQueryElementsEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTHeaderPaintQueryElementsEventListEx.Remove(Item : TVTHeaderPaintQueryElementsEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTHeaderPaintQueryElementsEventListEx.IndexOf(Item : TVTHeaderPaintQueryElementsEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTHeaderPaintQueryElementsEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTHeaderPaintQueryElementsEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTHeaderPaintQueryElementsEventListEx.Execute(Sender : TVTHeader; Var PaintInfo : THeaderPaintInfo; Var Elements : THeaderPaintElements);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTHeaderPaintQueryElementsEvent(lItem.Method)(Sender, PaintInfo, Elements);
  End;
End;

Function TVTHeaderHeightDblClickResizeEventListEx.Get(Index : Integer) : TVTHeaderHeightDblClickResizeEvent;
Begin
  Result := TVTHeaderHeightDblClickResizeEvent(InHerited Items[Index].Method);
End;

Procedure TVTHeaderHeightDblClickResizeEventListEx.Put(Index : Integer; Item : TVTHeaderHeightDblClickResizeEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTHeaderHeightDblClickResizeEventListEx.Add(Item : TVTHeaderHeightDblClickResizeEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTHeaderHeightDblClickResizeEventListEx.Insert(Index: Integer; Item : TVTHeaderHeightDblClickResizeEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTHeaderHeightDblClickResizeEventListEx.Remove(Item : TVTHeaderHeightDblClickResizeEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTHeaderHeightDblClickResizeEventListEx.IndexOf(Item : TVTHeaderHeightDblClickResizeEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTHeaderHeightDblClickResizeEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTHeaderHeightDblClickResizeEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTHeaderHeightDblClickResizeEventListEx.Execute(Sender : TVTHeader; Var P : TPoint; Shift : TShiftState; Var Allowed : Boolean);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTHeaderHeightDblClickResizeEvent(lItem.Method)(Sender, P, Shift, Allowed);
  End;
End;

Function TVTHeaderHeightTrackingEventListEx.Get(Index : Integer) : TVTHeaderHeightTrackingEvent;
Begin
  Result := TVTHeaderHeightTrackingEvent(InHerited Items[Index].Method);
End;

Procedure TVTHeaderHeightTrackingEventListEx.Put(Index : Integer; Item : TVTHeaderHeightTrackingEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTHeaderHeightTrackingEventListEx.Add(Item : TVTHeaderHeightTrackingEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTHeaderHeightTrackingEventListEx.Insert(Index: Integer; Item : TVTHeaderHeightTrackingEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTHeaderHeightTrackingEventListEx.Remove(Item : TVTHeaderHeightTrackingEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTHeaderHeightTrackingEventListEx.IndexOf(Item : TVTHeaderHeightTrackingEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTHeaderHeightTrackingEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTHeaderHeightTrackingEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTHeaderHeightTrackingEventListEx.Execute(Sender : TVTHeader; Var P : TPoint; Shift : TShiftState; Var Allowed : Boolean);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTHeaderHeightTrackingEvent(lItem.Method)(Sender, P, Shift, Allowed);
  End;
End;

Function TVTHeaderMouseEventListEx.Get(Index : Integer) : TVTHeaderMouseEvent;
Begin
  Result := TVTHeaderMouseEvent(InHerited Items[Index].Method);
End;

Procedure TVTHeaderMouseEventListEx.Put(Index : Integer; Item : TVTHeaderMouseEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTHeaderMouseEventListEx.Add(Item : TVTHeaderMouseEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTHeaderMouseEventListEx.Insert(Index: Integer; Item : TVTHeaderMouseEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTHeaderMouseEventListEx.Remove(Item : TVTHeaderMouseEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTHeaderMouseEventListEx.IndexOf(Item : TVTHeaderMouseEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTHeaderMouseEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTHeaderMouseEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTHeaderMouseEventListEx.Execute(Sender : TVTHeader; Button : TMouseButton; Shift : TShiftState; X : Integer; Y : Integer);
Var Z     : Integer;
    lItem : IMethodEx;
Begin
  For Z := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[Z];
    If lItem.Enabled Then
      TVTHeaderMouseEvent(lItem.Method)(Sender, Button, Shift, X, Y);
  End;
End;

Function TVTHeaderMouseMoveEventListEx.Get(Index : Integer) : TVTHeaderMouseMoveEvent;
Begin
  Result := TVTHeaderMouseMoveEvent(InHerited Items[Index].Method);
End;

Procedure TVTHeaderMouseMoveEventListEx.Put(Index : Integer; Item : TVTHeaderMouseMoveEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTHeaderMouseMoveEventListEx.Add(Item : TVTHeaderMouseMoveEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTHeaderMouseMoveEventListEx.Insert(Index: Integer; Item : TVTHeaderMouseMoveEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTHeaderMouseMoveEventListEx.Remove(Item : TVTHeaderMouseMoveEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTHeaderMouseMoveEventListEx.IndexOf(Item : TVTHeaderMouseMoveEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTHeaderMouseMoveEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTHeaderMouseMoveEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTHeaderMouseMoveEventListEx.Execute(Sender : TVTHeader; Shift : TShiftState; X : Integer; Y : Integer);
Var Z     : Integer;
    lItem : IMethodEx;
Begin
  For Z := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[Z];
    If lItem.Enabled Then
      TVTHeaderMouseMoveEvent(lItem.Method)(Sender, Shift, X, Y);
  End;
End;

Function TVTHotNodeChangeEventListEx.Get(Index : Integer) : TVTHotNodeChangeEvent;
Begin
  Result := TVTHotNodeChangeEvent(InHerited Items[Index].Method);
End;

Procedure TVTHotNodeChangeEventListEx.Put(Index : Integer; Item : TVTHotNodeChangeEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTHotNodeChangeEventListEx.Add(Item : TVTHotNodeChangeEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTHotNodeChangeEventListEx.Insert(Index: Integer; Item : TVTHotNodeChangeEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTHotNodeChangeEventListEx.Remove(Item : TVTHotNodeChangeEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTHotNodeChangeEventListEx.IndexOf(Item : TVTHotNodeChangeEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTHotNodeChangeEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTHotNodeChangeEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTHotNodeChangeEventListEx.Execute(Sender : TBaseVirtualTree; OldNode : PVirtualNode; NewNode : PVirtualNode);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTHotNodeChangeEvent(lItem.Method)(Sender, OldNode, NewNode);
  End;
End;

Function TVTIncrementalSearchEventListEx.Get(Index : Integer) : TVTIncrementalSearchEvent;
Begin
  Result := TVTIncrementalSearchEvent(InHerited Items[Index].Method);
End;

Procedure TVTIncrementalSearchEventListEx.Put(Index : Integer; Item : TVTIncrementalSearchEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTIncrementalSearchEventListEx.Add(Item : TVTIncrementalSearchEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTIncrementalSearchEventListEx.Insert(Index: Integer; Item : TVTIncrementalSearchEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTIncrementalSearchEventListEx.Remove(Item : TVTIncrementalSearchEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTIncrementalSearchEventListEx.IndexOf(Item : TVTIncrementalSearchEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTIncrementalSearchEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTIncrementalSearchEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTIncrementalSearchEventListEx.Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Const SearchText : WideString; Var Result : Integer);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTIncrementalSearchEvent(lItem.Method)(Sender, Node, SearchText, Result);
  End;
End;

Function TVTInitChildrenEventListEx.Get(Index : Integer) : TVTInitChildrenEvent;
Begin
  Result := TVTInitChildrenEvent(InHerited Items[Index].Method);
End;

Procedure TVTInitChildrenEventListEx.Put(Index : Integer; Item : TVTInitChildrenEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTInitChildrenEventListEx.Add(Item : TVTInitChildrenEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTInitChildrenEventListEx.Insert(Index: Integer; Item : TVTInitChildrenEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTInitChildrenEventListEx.Remove(Item : TVTInitChildrenEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTInitChildrenEventListEx.IndexOf(Item : TVTInitChildrenEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTInitChildrenEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTInitChildrenEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTInitChildrenEventListEx.Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Var ChildCount : Cardinal);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTInitChildrenEvent(lItem.Method)(Sender, Node, ChildCount);
  End;
End;

Function TVTInitNodeEventListEx.Get(Index : Integer) : TVTInitNodeEvent;
Begin
  Result := TVTInitNodeEvent(InHerited Items[Index].Method);
End;

Procedure TVTInitNodeEventListEx.Put(Index : Integer; Item : TVTInitNodeEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTInitNodeEventListEx.Add(Item : TVTInitNodeEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTInitNodeEventListEx.Insert(Index: Integer; Item : TVTInitNodeEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTInitNodeEventListEx.Remove(Item : TVTInitNodeEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTInitNodeEventListEx.IndexOf(Item : TVTInitNodeEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTInitNodeEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTInitNodeEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTInitNodeEventListEx.Execute(Sender : TBaseVirtualTree; ParentNode : PVirtualNode; Node : PVirtualNode; Var InitialStates : TVirtualNodeInitStates);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTInitNodeEvent(lItem.Method)(Sender, ParentNode, Node, InitialStates);
  End;
End;

Function TVTKeyActionEventListEx.Get(Index : Integer) : TVTKeyActionEvent;
Begin
  Result := TVTKeyActionEvent(InHerited Items[Index].Method);
End;

Procedure TVTKeyActionEventListEx.Put(Index : Integer; Item : TVTKeyActionEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTKeyActionEventListEx.Add(Item : TVTKeyActionEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTKeyActionEventListEx.Insert(Index: Integer; Item : TVTKeyActionEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTKeyActionEventListEx.Remove(Item : TVTKeyActionEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTKeyActionEventListEx.IndexOf(Item : TVTKeyActionEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTKeyActionEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTKeyActionEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTKeyActionEventListEx.Execute(Sender : TBaseVirtualTree; Var CharCode : Word; Var Shift : TShiftState; Var DoDefault : Boolean);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTKeyActionEvent(lItem.Method)(Sender, CharCode, Shift, DoDefault);
  End;
End;

Function TVTSaveNodeEventListEx.Get(Index : Integer) : TVTSaveNodeEvent;
Begin
  Result := TVTSaveNodeEvent(InHerited Items[Index].Method);
End;

Procedure TVTSaveNodeEventListEx.Put(Index : Integer; Item : TVTSaveNodeEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTSaveNodeEventListEx.Add(Item : TVTSaveNodeEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTSaveNodeEventListEx.Insert(Index: Integer; Item : TVTSaveNodeEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTSaveNodeEventListEx.Remove(Item : TVTSaveNodeEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTSaveNodeEventListEx.IndexOf(Item : TVTSaveNodeEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTSaveNodeEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTSaveNodeEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTSaveNodeEventListEx.Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Stream : TStream);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTSaveNodeEvent(lItem.Method)(Sender, Node, Stream);
  End;
End;

Function TVTSaveTreeEventListEx.Get(Index : Integer) : TVTSaveTreeEvent;
Begin
  Result := TVTSaveTreeEvent(InHerited Items[Index].Method);
End;

Procedure TVTSaveTreeEventListEx.Put(Index : Integer; Item : TVTSaveTreeEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTSaveTreeEventListEx.Add(Item : TVTSaveTreeEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTSaveTreeEventListEx.Insert(Index: Integer; Item : TVTSaveTreeEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTSaveTreeEventListEx.Remove(Item : TVTSaveTreeEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTSaveTreeEventListEx.IndexOf(Item : TVTSaveTreeEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTSaveTreeEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTSaveTreeEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTSaveTreeEventListEx.Execute(Sender : TBaseVirtualTree; Stream : TStream);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTSaveTreeEvent(lItem.Method)(Sender, Stream);
  End;
End;

Function TVTMeasureItemEventListEx.Get(Index : Integer) : TVTMeasureItemEvent;
Begin
  Result := TVTMeasureItemEvent(InHerited Items[Index].Method);
End;

Procedure TVTMeasureItemEventListEx.Put(Index : Integer; Item : TVTMeasureItemEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTMeasureItemEventListEx.Add(Item : TVTMeasureItemEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTMeasureItemEventListEx.Insert(Index: Integer; Item : TVTMeasureItemEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTMeasureItemEventListEx.Remove(Item : TVTMeasureItemEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTMeasureItemEventListEx.IndexOf(Item : TVTMeasureItemEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTMeasureItemEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTMeasureItemEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTMeasureItemEventListEx.Execute(Sender : TBaseVirtualTree; TargetCanvas : TCanvas; Node : PVirtualNode; Var NodeHeight : Integer);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTMeasureItemEvent(lItem.Method)(Sender, TargetCanvas, Node, NodeHeight);
  End;
End;

Function TVTMeasureTextEventListEx.Get(Index : Integer) : TVTMeasureTextEvent;
Begin
  Result := TVTMeasureTextEvent(InHerited Items[Index].Method);
End;

Procedure TVTMeasureTextEventListEx.Put(Index : Integer; Item : TVTMeasureTextEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTMeasureTextEventListEx.Add(Item : TVTMeasureTextEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTMeasureTextEventListEx.Insert(Index: Integer; Item : TVTMeasureTextEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTMeasureTextEventListEx.Remove(Item : TVTMeasureTextEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTMeasureTextEventListEx.IndexOf(Item : TVTMeasureTextEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTMeasureTextEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTMeasureTextEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTMeasureTextEventListEx.Execute(Sender : TBaseVirtualTree; TargetCanvas : TCanvas; Node : PVirtualNode; Column : TColumnIndex; Const Text : WideString; Var Extent : Integer);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTMeasureTextEvent(lItem.Method)(Sender, TargetCanvas, Node, Column, Text, Extent);
  End;
End;

Function TMouseWheelEventListEx.Get(Index : Integer) : TMouseWheelEvent;
Begin
  Result := TMouseWheelEvent(InHerited Items[Index].Method);
End;

Procedure TMouseWheelEventListEx.Put(Index : Integer; Item : TMouseWheelEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TMouseWheelEventListEx.Add(Item : TMouseWheelEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TMouseWheelEventListEx.Insert(Index: Integer; Item : TMouseWheelEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TMouseWheelEventListEx.Remove(Item : TMouseWheelEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TMouseWheelEventListEx.IndexOf(Item : TMouseWheelEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TMouseWheelEventListEx.GetExecuteProc() : TMethod;
Var lResult : TMouseWheelEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TMouseWheelEventListEx.Execute(Sender : TObject; Shift : TShiftState; WheelDelta : Integer; MousePos : TPoint; Var Handled : Boolean);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TMouseWheelEvent(lItem.Method)(Sender, Shift, WheelDelta, MousePos, Handled);
  End;
End;

Function TVSTNewTextEventListEx.Get(Index : Integer) : TVSTNewTextEvent;
Begin
  Result := TVSTNewTextEvent(InHerited Items[Index].Method);
End;

Procedure TVSTNewTextEventListEx.Put(Index : Integer; Item : TVSTNewTextEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVSTNewTextEventListEx.Add(Item : TVSTNewTextEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVSTNewTextEventListEx.Insert(Index: Integer; Item : TVSTNewTextEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVSTNewTextEventListEx.Remove(Item : TVSTNewTextEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVSTNewTextEventListEx.IndexOf(Item : TVSTNewTextEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVSTNewTextEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVSTNewTextEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVSTNewTextEventListEx.Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex; NewText : WideString);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVSTNewTextEvent(lItem.Method)(Sender, Node, Column, NewText);
  End;
End;

Function TVTNodeClickEventListEx.Get(Index : Integer) : TVTNodeClickEvent;
Begin
  Result := TVTNodeClickEvent(InHerited Items[Index].Method);
End;

Procedure TVTNodeClickEventListEx.Put(Index : Integer; Item : TVTNodeClickEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTNodeClickEventListEx.Add(Item : TVTNodeClickEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTNodeClickEventListEx.Insert(Index: Integer; Item : TVTNodeClickEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTNodeClickEventListEx.Remove(Item : TVTNodeClickEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTNodeClickEventListEx.IndexOf(Item : TVTNodeClickEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTNodeClickEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTNodeClickEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTNodeClickEventListEx.Execute(Sender : TBaseVirtualTree; Const HitInfo : THitInfo);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTNodeClickEvent(lItem.Method)(Sender, HitInfo);
  End;
End;

Function TVTNodeCopiedEventListEx.Get(Index : Integer) : TVTNodeCopiedEvent;
Begin
  Result := TVTNodeCopiedEvent(InHerited Items[Index].Method);
End;

Procedure TVTNodeCopiedEventListEx.Put(Index : Integer; Item : TVTNodeCopiedEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTNodeCopiedEventListEx.Add(Item : TVTNodeCopiedEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTNodeCopiedEventListEx.Insert(Index: Integer; Item : TVTNodeCopiedEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTNodeCopiedEventListEx.Remove(Item : TVTNodeCopiedEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTNodeCopiedEventListEx.IndexOf(Item : TVTNodeCopiedEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTNodeCopiedEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTNodeCopiedEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTNodeCopiedEventListEx.Execute(Sender : TBaseVirtualTree; Node : PVirtualNode);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTNodeCopiedEvent(lItem.Method)(Sender, Node);
  End;
End;

Function TVTNodeCopyingEventListEx.Get(Index : Integer) : TVTNodeCopyingEvent;
Begin
  Result := TVTNodeCopyingEvent(InHerited Items[Index].Method);
End;

Procedure TVTNodeCopyingEventListEx.Put(Index : Integer; Item : TVTNodeCopyingEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTNodeCopyingEventListEx.Add(Item : TVTNodeCopyingEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTNodeCopyingEventListEx.Insert(Index: Integer; Item : TVTNodeCopyingEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTNodeCopyingEventListEx.Remove(Item : TVTNodeCopyingEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTNodeCopyingEventListEx.IndexOf(Item : TVTNodeCopyingEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTNodeCopyingEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTNodeCopyingEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTNodeCopyingEventListEx.Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Target : PVirtualNode; Var Allowed : Boolean);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTNodeCopyingEvent(lItem.Method)(Sender, Node, Target, Allowed);
  End;
End;

Function TVTNodeHeightDblClickResizeEventListEx.Get(Index : Integer) : TVTNodeHeightDblClickResizeEvent;
Begin
  Result := TVTNodeHeightDblClickResizeEvent(InHerited Items[Index].Method);
End;

Procedure TVTNodeHeightDblClickResizeEventListEx.Put(Index : Integer; Item : TVTNodeHeightDblClickResizeEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTNodeHeightDblClickResizeEventListEx.Add(Item : TVTNodeHeightDblClickResizeEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTNodeHeightDblClickResizeEventListEx.Insert(Index: Integer; Item : TVTNodeHeightDblClickResizeEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTNodeHeightDblClickResizeEventListEx.Remove(Item : TVTNodeHeightDblClickResizeEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTNodeHeightDblClickResizeEventListEx.IndexOf(Item : TVTNodeHeightDblClickResizeEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTNodeHeightDblClickResizeEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTNodeHeightDblClickResizeEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTNodeHeightDblClickResizeEventListEx.Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex; Shift : TShiftState; P : TPoint; Var Allowed : Boolean);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTNodeHeightDblClickResizeEvent(lItem.Method)(Sender, Node, Column, Shift, P, Allowed);
  End;
End;

Function TVTNodeHeightTrackingEventListEx.Get(Index : Integer) : TVTNodeHeightTrackingEvent;
Begin
  Result := TVTNodeHeightTrackingEvent(InHerited Items[Index].Method);
End;

Procedure TVTNodeHeightTrackingEventListEx.Put(Index : Integer; Item : TVTNodeHeightTrackingEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTNodeHeightTrackingEventListEx.Add(Item : TVTNodeHeightTrackingEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTNodeHeightTrackingEventListEx.Insert(Index: Integer; Item : TVTNodeHeightTrackingEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTNodeHeightTrackingEventListEx.Remove(Item : TVTNodeHeightTrackingEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTNodeHeightTrackingEventListEx.IndexOf(Item : TVTNodeHeightTrackingEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTNodeHeightTrackingEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTNodeHeightTrackingEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTNodeHeightTrackingEventListEx.Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex; Shift : TShiftState; Var TrackPoint : TPoint; P : TPoint; Var Allowed : Boolean);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTNodeHeightTrackingEvent(lItem.Method)(Sender, Node, Column, Shift, TrackPoint, P, Allowed);
  End;
End;

Function TVTNodeMovedEventListEx.Get(Index : Integer) : TVTNodeMovedEvent;
Begin
  Result := TVTNodeMovedEvent(InHerited Items[Index].Method);
End;

Procedure TVTNodeMovedEventListEx.Put(Index : Integer; Item : TVTNodeMovedEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTNodeMovedEventListEx.Add(Item : TVTNodeMovedEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTNodeMovedEventListEx.Insert(Index: Integer; Item : TVTNodeMovedEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTNodeMovedEventListEx.Remove(Item : TVTNodeMovedEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTNodeMovedEventListEx.IndexOf(Item : TVTNodeMovedEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTNodeMovedEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTNodeMovedEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTNodeMovedEventListEx.Execute(Sender : TBaseVirtualTree; Node : PVirtualNode);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTNodeMovedEvent(lItem.Method)(Sender, Node);
  End;
End;

Function TVTNodeMovingEventListEx.Get(Index : Integer) : TVTNodeMovingEvent;
Begin
  Result := TVTNodeMovingEvent(InHerited Items[Index].Method);
End;

Procedure TVTNodeMovingEventListEx.Put(Index : Integer; Item : TVTNodeMovingEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTNodeMovingEventListEx.Add(Item : TVTNodeMovingEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTNodeMovingEventListEx.Insert(Index: Integer; Item : TVTNodeMovingEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTNodeMovingEventListEx.Remove(Item : TVTNodeMovingEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTNodeMovingEventListEx.IndexOf(Item : TVTNodeMovingEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTNodeMovingEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTNodeMovingEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTNodeMovingEventListEx.Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Target : PVirtualNode; Var Allowed : Boolean);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTNodeMovingEvent(lItem.Method)(Sender, Node, Target, Allowed);
  End;
End;

Function TVTBackgroundPaintEventListEx.Get(Index : Integer) : TVTBackgroundPaintEvent;
Begin
  Result := TVTBackgroundPaintEvent(InHerited Items[Index].Method);
End;

Procedure TVTBackgroundPaintEventListEx.Put(Index : Integer; Item : TVTBackgroundPaintEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTBackgroundPaintEventListEx.Add(Item : TVTBackgroundPaintEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTBackgroundPaintEventListEx.Insert(Index: Integer; Item : TVTBackgroundPaintEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTBackgroundPaintEventListEx.Remove(Item : TVTBackgroundPaintEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTBackgroundPaintEventListEx.IndexOf(Item : TVTBackgroundPaintEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTBackgroundPaintEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTBackgroundPaintEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTBackgroundPaintEventListEx.Execute(Sender : TBaseVirtualTree; TargetCanvas : TCanvas; R : TRect; Var Handled : Boolean);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTBackgroundPaintEvent(lItem.Method)(Sender, TargetCanvas, R, Handled);
  End;
End;

Function TVTPaintTextListEx.Get(Index : Integer) : TVTPaintText;
Begin
  Result := TVTPaintText(InHerited Items[Index].Method);
End;

Procedure TVTPaintTextListEx.Put(Index : Integer; Item : TVTPaintText);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTPaintTextListEx.Add(Item : TVTPaintText) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTPaintTextListEx.Insert(Index: Integer; Item : TVTPaintText);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTPaintTextListEx.Remove(Item : TVTPaintText) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTPaintTextListEx.IndexOf(Item : TVTPaintText) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTPaintTextListEx.GetExecuteProc() : TMethod;
Var lResult : TVTPaintText;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTPaintTextListEx.Execute(Sender : TBaseVirtualTree; Const TargetCanvas : TCanvas; Node : PVirtualNode; Column : TColumnIndex; TextType : TVSTTextType);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTPaintText(lItem.Method)(Sender, TargetCanvas, Node, Column, TextType);
  End;
End;

Function TVTPrepareButtonImagesEventListEx.Get(Index : Integer) : TVTPrepareButtonImagesEvent;
Begin
  Result := TVTPrepareButtonImagesEvent(InHerited Items[Index].Method);
End;

Procedure TVTPrepareButtonImagesEventListEx.Put(Index : Integer; Item : TVTPrepareButtonImagesEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTPrepareButtonImagesEventListEx.Add(Item : TVTPrepareButtonImagesEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTPrepareButtonImagesEventListEx.Insert(Index: Integer; Item : TVTPrepareButtonImagesEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTPrepareButtonImagesEventListEx.Remove(Item : TVTPrepareButtonImagesEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTPrepareButtonImagesEventListEx.IndexOf(Item : TVTPrepareButtonImagesEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTPrepareButtonImagesEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTPrepareButtonImagesEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTPrepareButtonImagesEventListEx.Execute(Sender : TBaseVirtualTree; Const APlusBM : TBitmap; Const APlusHotBM : TBitmap; Const APlusSelectedHotBM : TBitmap; Const AMinusBM : TBitmap; Const AMinusHotBM : TBitmap; Const AMinusSelectedHotBM : TBitmap; Var ASize : TSize);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTPrepareButtonImagesEvent(lItem.Method)(Sender, APlusBM, APlusHotBM, APlusSelectedHotBM, AMinusBM, AMinusHotBM, AMinusSelectedHotBM, ASize);
  End;
End;

Function TVTRemoveFromSelectionEventListEx.Get(Index : Integer) : TVTRemoveFromSelectionEvent;
Begin
  Result := TVTRemoveFromSelectionEvent(InHerited Items[Index].Method);
End;

Procedure TVTRemoveFromSelectionEventListEx.Put(Index : Integer; Item : TVTRemoveFromSelectionEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTRemoveFromSelectionEventListEx.Add(Item : TVTRemoveFromSelectionEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTRemoveFromSelectionEventListEx.Insert(Index: Integer; Item : TVTRemoveFromSelectionEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTRemoveFromSelectionEventListEx.Remove(Item : TVTRemoveFromSelectionEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTRemoveFromSelectionEventListEx.IndexOf(Item : TVTRemoveFromSelectionEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTRemoveFromSelectionEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTRemoveFromSelectionEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTRemoveFromSelectionEventListEx.Execute(Sender : TBaseVirtualTree; Node : PVirtualNode);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTRemoveFromSelectionEvent(lItem.Method)(Sender, Node);
  End;
End;

Function TVTRenderOLEDataEventListEx.Get(Index : Integer) : TVTRenderOLEDataEvent;
Begin
  Result := TVTRenderOLEDataEvent(InHerited Items[Index].Method);
End;

Procedure TVTRenderOLEDataEventListEx.Put(Index : Integer; Item : TVTRenderOLEDataEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTRenderOLEDataEventListEx.Add(Item : TVTRenderOLEDataEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTRenderOLEDataEventListEx.Insert(Index: Integer; Item : TVTRenderOLEDataEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTRenderOLEDataEventListEx.Remove(Item : TVTRenderOLEDataEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTRenderOLEDataEventListEx.IndexOf(Item : TVTRenderOLEDataEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTRenderOLEDataEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTRenderOLEDataEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTRenderOLEDataEventListEx.Execute(Sender : TBaseVirtualTree; Const FormatEtcIn : tagFORMATETC; Out Medium : tagSTGMEDIUM; ForClipboard : Boolean; Var Result : HRESULT);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTRenderOLEDataEvent(lItem.Method)(Sender, FormatEtcIn, Medium, ForClipboard, Result);
  End;
End;

Function TVTScrollEventListEx.Get(Index : Integer) : TVTScrollEvent;
Begin
  Result := TVTScrollEvent(InHerited Items[Index].Method);
End;

Procedure TVTScrollEventListEx.Put(Index : Integer; Item : TVTScrollEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTScrollEventListEx.Add(Item : TVTScrollEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTScrollEventListEx.Insert(Index: Integer; Item : TVTScrollEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTScrollEventListEx.Remove(Item : TVTScrollEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTScrollEventListEx.IndexOf(Item : TVTScrollEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTScrollEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTScrollEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTScrollEventListEx.Execute(Sender : TBaseVirtualTree; DeltaX : Integer; DeltaY : Integer);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTScrollEvent(lItem.Method)(Sender, DeltaX, DeltaY);
  End;
End;

Function TVSTShortenStringEventListEx.Get(Index : Integer) : TVSTShortenStringEvent;
Begin
  Result := TVSTShortenStringEvent(InHerited Items[Index].Method);
End;

Procedure TVSTShortenStringEventListEx.Put(Index : Integer; Item : TVSTShortenStringEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVSTShortenStringEventListEx.Add(Item : TVSTShortenStringEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVSTShortenStringEventListEx.Insert(Index: Integer; Item : TVSTShortenStringEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVSTShortenStringEventListEx.Remove(Item : TVSTShortenStringEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVSTShortenStringEventListEx.IndexOf(Item : TVSTShortenStringEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVSTShortenStringEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVSTShortenStringEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVSTShortenStringEventListEx.Execute(Sender : TBaseVirtualTree; TargetCanvas : TCanvas; Node : PVirtualNode; Column : TColumnIndex; Const S : WideString; TextSpace : Integer; Var Result : WideString; Var Done : Boolean);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVSTShortenStringEvent(lItem.Method)(Sender, TargetCanvas, Node, Column, S, TextSpace, Result, Done);
  End;
End;

Function TVTScrollBarShowEventListEx.Get(Index : Integer) : TVTScrollBarShowEvent;
Begin
  Result := TVTScrollBarShowEvent(InHerited Items[Index].Method);
End;

Procedure TVTScrollBarShowEventListEx.Put(Index : Integer; Item : TVTScrollBarShowEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTScrollBarShowEventListEx.Add(Item : TVTScrollBarShowEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTScrollBarShowEventListEx.Insert(Index: Integer; Item : TVTScrollBarShowEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTScrollBarShowEventListEx.Remove(Item : TVTScrollBarShowEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTScrollBarShowEventListEx.IndexOf(Item : TVTScrollBarShowEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTScrollBarShowEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTScrollBarShowEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTScrollBarShowEventListEx.Execute(Sender : TBaseVirtualTree; Bar : Integer; Show : Boolean);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTScrollBarShowEvent(lItem.Method)(Sender, Bar, Show);
  End;
End;

Function TVTStateChangeEventListEx.Get(Index : Integer) : TVTStateChangeEvent;
Begin
  Result := TVTStateChangeEvent(InHerited Items[Index].Method);
End;

Procedure TVTStateChangeEventListEx.Put(Index : Integer; Item : TVTStateChangeEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTStateChangeEventListEx.Add(Item : TVTStateChangeEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTStateChangeEventListEx.Insert(Index: Integer; Item : TVTStateChangeEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTStateChangeEventListEx.Remove(Item : TVTStateChangeEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTStateChangeEventListEx.IndexOf(Item : TVTStateChangeEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTStateChangeEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTStateChangeEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTStateChangeEventListEx.Execute(Sender : TBaseVirtualTree; Enter : TVirtualTreeStates; Leave : TVirtualTreeStates);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTStateChangeEvent(lItem.Method)(Sender, Enter, Leave);
  End;
End;

Function TVTStructureChangeEventListEx.Get(Index : Integer) : TVTStructureChangeEvent;
Begin
  Result := TVTStructureChangeEvent(InHerited Items[Index].Method);
End;

Procedure TVTStructureChangeEventListEx.Put(Index : Integer; Item : TVTStructureChangeEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTStructureChangeEventListEx.Add(Item : TVTStructureChangeEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTStructureChangeEventListEx.Insert(Index: Integer; Item : TVTStructureChangeEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTStructureChangeEventListEx.Remove(Item : TVTStructureChangeEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTStructureChangeEventListEx.IndexOf(Item : TVTStructureChangeEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTStructureChangeEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTStructureChangeEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTStructureChangeEventListEx.Execute(Sender : TBaseVirtualTree; Node : PVirtualNode; Reason : TChangeReason);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTStructureChangeEvent(lItem.Method)(Sender, Node, Reason);
  End;
End;

Function TVTUpdatingEventListEx.Get(Index : Integer) : TVTUpdatingEvent;
Begin
  Result := TVTUpdatingEvent(InHerited Items[Index].Method);
End;

Procedure TVTUpdatingEventListEx.Put(Index : Integer; Item : TVTUpdatingEvent);
Begin
  InHerited Items[Index] := TMethodEx.Create(TMethod(Item));
End;

Function TVTUpdatingEventListEx.Add(Item : TVTUpdatingEvent) : Integer;
Begin
  Result := InHerited Add(TMethodEx.Create(TMethod(Item)));
End;

Procedure TVTUpdatingEventListEx.Insert(Index: Integer; Item : TVTUpdatingEvent);
Begin
  InHerited Insert(Index, TMethodEx.Create(TMethod(Item)));
End;

Function TVTUpdatingEventListEx.Remove(Item : TVTUpdatingEvent) : Integer;
Begin
  Result := InHerited Remove(TMethodEx.Create(TMethod(Item)));
End;

Function TVTUpdatingEventListEx.IndexOf(Item : TVTUpdatingEvent) : Integer;
Begin
  Result := InHerited IndexOf(TMethodEx.Create(TMethod(Item)));
End;

Function TVTUpdatingEventListEx.GetExecuteProc() : TMethod;
Var lResult : TVTUpdatingEvent;
Begin
  lResult := Execute;
  Result  := TMethod(lResult);
End;

Procedure TVTUpdatingEventListEx.Execute(Sender : TBaseVirtualTree; State : TVTUpdateState);
Var X     : Integer;
    lItem : IMethodEx;
Begin
  For X := 0 To Count - 1 Do
  Begin
    lItem := InHerited Items[X];
    If lItem.Enabled Then
      TVTUpdatingEvent(lItem.Method)(Sender, State);
  End;
End;

Procedure TVirtualStringTreeEventDispatcher.InitEvents();
Var lProps      : TPropList;
    lNbProp     : Integer;
    X           : Integer;
Begin
  lNbProp := GetPropList(PTypeInfo(Component.ClassInfo), [tkMethod], @lProps, True);
  For X := 0 To lNbProp - 1 Do
  Begin
    If SameText(lProps[X].PropType^.Name, 'TVTAddToSelectionEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTAddToSelectionEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTAdvancedHeaderPaintEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTAdvancedHeaderPaintEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTAfterAutoFitColumnEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTAfterAutoFitColumnEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTAfterAutoFitColumnsEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTAfterAutoFitColumnsEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTAfterCellPaintEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTAfterCellPaintEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTColumnExportEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTColumnExportEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTAfterColumnWidthTrackingEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTAfterColumnWidthTrackingEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTAfterGetMaxColumnWidthEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTAfterGetMaxColumnWidthEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTTreeExportEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTTreeExportEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTAfterHeaderHeightTrackingEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTAfterHeaderHeightTrackingEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTAfterItemEraseEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTAfterItemEraseEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTAfterItemPaintEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTAfterItemPaintEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTNodeExportEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTNodeExportEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTPaintEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTPaintEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTBeforeAutoFitColumnEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTBeforeAutoFitColumnEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTBeforeAutoFitColumnsEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTBeforeAutoFitColumnsEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTBeforeCellPaintEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTBeforeCellPaintEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTBeforeColumnWidthTrackingEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTBeforeColumnWidthTrackingEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTBeforeDrawLineImageEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTBeforeDrawLineImageEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTBeforeGetMaxColumnWidthEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTBeforeGetMaxColumnWidthEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTBeforeHeaderHeightTrackingEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTBeforeHeaderHeightTrackingEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTBeforeItemEraseEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTBeforeItemEraseEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTBeforeItemPaintEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTBeforeItemPaintEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TCanResizeEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TCanResizeEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTCanSplitterResizeColumnEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTCanSplitterResizeColumnEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTCanSplitterResizeHeaderEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTCanSplitterResizeHeaderEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTCanSplitterResizeNodeEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTCanSplitterResizeNodeEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTChangeEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTChangeEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTCheckChangingEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTCheckChangingEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTChangingEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTChangingEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTColumnClickEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTColumnClickEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTColumnDblClickEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTColumnDblClickEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTHeaderNotifyEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTHeaderNotifyEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TColumnChangeEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TColumnChangeEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTColumnWidthDblClickResizeEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTColumnWidthDblClickResizeEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTColumnWidthTrackingEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTColumnWidthTrackingEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTCompareEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTCompareEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTCreateDataObjectEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTCreateDataObjectEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTCreateDragManagerEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTCreateDragManagerEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTCreateEditorEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTCreateEditorEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTDragAllowedEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTDragAllowedEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTDragDropEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTDragDropEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTDragOverEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTDragOverEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTDrawHintEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTDrawHintEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTDrawTextEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTDrawTextEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTEditCancelEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTEditCancelEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTEditChangeEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTEditChangeEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTEditChangingEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTEditChangingEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTOperationEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTOperationEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTFocusChangeEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTFocusChangeEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTFocusChangingEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTFocusChangingEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTFreeNodeEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTFreeNodeEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTGetCellIsEmptyEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTGetCellIsEmptyEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVSTGetCellTextEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVSTGetCellTextEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTGetCursorEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTGetCursorEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTGetHeaderCursorEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTGetHeaderCursorEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTHelpContextEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTHelpContextEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVSTGetHintEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVSTGetHintEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTHintKindEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTHintKindEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTGetHintSizeEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTGetHintSizeEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTGetImageEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTGetImageEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTGetImageExEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTGetImageExEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTGetImageTextEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTGetImageTextEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTGetLineStyleEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTGetLineStyleEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTGetNodeDataSizeEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTGetNodeDataSizeEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTPopupEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTPopupEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVSTGetTextEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVSTGetTextEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTGetUserClipboardFormatsEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTGetUserClipboardFormatsEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTHeaderClickEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTHeaderClickEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTHeaderDraggedEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTHeaderDraggedEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTHeaderDraggedOutEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTHeaderDraggedOutEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTHeaderDraggingEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTHeaderDraggingEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTHeaderPaintEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTHeaderPaintEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTHeaderPaintQueryElementsEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTHeaderPaintQueryElementsEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTHeaderHeightDblClickResizeEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTHeaderHeightDblClickResizeEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTHeaderHeightTrackingEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTHeaderHeightTrackingEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTHeaderMouseEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTHeaderMouseEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTHeaderMouseMoveEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTHeaderMouseMoveEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTHotNodeChangeEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTHotNodeChangeEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTIncrementalSearchEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTIncrementalSearchEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTInitChildrenEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTInitChildrenEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTInitNodeEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTInitNodeEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTKeyActionEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTKeyActionEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTSaveNodeEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTSaveNodeEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTSaveTreeEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTSaveTreeEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTMeasureItemEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTMeasureItemEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTMeasureTextEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTMeasureTextEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TMouseWheelEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TMouseWheelEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVSTNewTextEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVSTNewTextEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTNodeClickEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTNodeClickEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTNodeCopiedEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTNodeCopiedEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTNodeCopyingEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTNodeCopyingEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTNodeHeightDblClickResizeEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTNodeHeightDblClickResizeEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTNodeHeightTrackingEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTNodeHeightTrackingEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTNodeMovedEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTNodeMovedEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTNodeMovingEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTNodeMovingEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTBackgroundPaintEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTBackgroundPaintEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTPaintText') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTPaintTextListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTPrepareButtonImagesEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTPrepareButtonImagesEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTRemoveFromSelectionEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTRemoveFromSelectionEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTRenderOLEDataEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTRenderOLEDataEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTScrollEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTScrollEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVSTShortenStringEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVSTShortenStringEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTScrollBarShowEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTScrollBarShowEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTStateChangeEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTStateChangeEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTStructureChangeEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTStructureChangeEventListEx))
    Else If SameText(lProps[X].PropType^.Name, 'TVTUpdatingEvent') Then
      Events.Add(InternalInitList(lProps[X].Name, TVTUpdatingEventListEx));
  End;

  InHerited InitEvents();
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTAddToSelectionEvent(AEvent, ANewEvent : TVTAddToSelectionEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTAddToSelectionEvent(AEvent, AOldEvent : TVTAddToSelectionEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTAddToSelectionEvent(AEvent, ADisabledEvent : TVTAddToSelectionEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTAddToSelectionEvent(AEvent, AEnabledEvent : TVTAddToSelectionEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTAdvancedHeaderPaintEvent(AEvent, ANewEvent : TVTAdvancedHeaderPaintEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTAdvancedHeaderPaintEvent(AEvent, AOldEvent : TVTAdvancedHeaderPaintEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTAdvancedHeaderPaintEvent(AEvent, ADisabledEvent : TVTAdvancedHeaderPaintEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTAdvancedHeaderPaintEvent(AEvent, AEnabledEvent : TVTAdvancedHeaderPaintEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTAfterAutoFitColumnEvent(AEvent, ANewEvent : TVTAfterAutoFitColumnEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTAfterAutoFitColumnEvent(AEvent, AOldEvent : TVTAfterAutoFitColumnEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTAfterAutoFitColumnEvent(AEvent, ADisabledEvent : TVTAfterAutoFitColumnEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTAfterAutoFitColumnEvent(AEvent, AEnabledEvent : TVTAfterAutoFitColumnEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTAfterAutoFitColumnsEvent(AEvent, ANewEvent : TVTAfterAutoFitColumnsEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTAfterAutoFitColumnsEvent(AEvent, AOldEvent : TVTAfterAutoFitColumnsEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTAfterAutoFitColumnsEvent(AEvent, ADisabledEvent : TVTAfterAutoFitColumnsEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTAfterAutoFitColumnsEvent(AEvent, AEnabledEvent : TVTAfterAutoFitColumnsEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTAfterCellPaintEvent(AEvent, ANewEvent : TVTAfterCellPaintEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTAfterCellPaintEvent(AEvent, AOldEvent : TVTAfterCellPaintEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTAfterCellPaintEvent(AEvent, ADisabledEvent : TVTAfterCellPaintEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTAfterCellPaintEvent(AEvent, AEnabledEvent : TVTAfterCellPaintEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTColumnExportEvent(AEvent, ANewEvent : TVTColumnExportEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTColumnExportEvent(AEvent, AOldEvent : TVTColumnExportEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTColumnExportEvent(AEvent, ADisabledEvent : TVTColumnExportEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTColumnExportEvent(AEvent, AEnabledEvent : TVTColumnExportEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTAfterColumnWidthTrackingEvent(AEvent, ANewEvent : TVTAfterColumnWidthTrackingEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTAfterColumnWidthTrackingEvent(AEvent, AOldEvent : TVTAfterColumnWidthTrackingEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTAfterColumnWidthTrackingEvent(AEvent, ADisabledEvent : TVTAfterColumnWidthTrackingEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTAfterColumnWidthTrackingEvent(AEvent, AEnabledEvent : TVTAfterColumnWidthTrackingEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTAfterGetMaxColumnWidthEvent(AEvent, ANewEvent : TVTAfterGetMaxColumnWidthEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTAfterGetMaxColumnWidthEvent(AEvent, AOldEvent : TVTAfterGetMaxColumnWidthEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTAfterGetMaxColumnWidthEvent(AEvent, ADisabledEvent : TVTAfterGetMaxColumnWidthEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTAfterGetMaxColumnWidthEvent(AEvent, AEnabledEvent : TVTAfterGetMaxColumnWidthEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTTreeExportEvent(AEvent, ANewEvent : TVTTreeExportEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTTreeExportEvent(AEvent, AOldEvent : TVTTreeExportEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTTreeExportEvent(AEvent, ADisabledEvent : TVTTreeExportEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTTreeExportEvent(AEvent, AEnabledEvent : TVTTreeExportEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTAfterHeaderHeightTrackingEvent(AEvent, ANewEvent : TVTAfterHeaderHeightTrackingEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTAfterHeaderHeightTrackingEvent(AEvent, AOldEvent : TVTAfterHeaderHeightTrackingEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTAfterHeaderHeightTrackingEvent(AEvent, ADisabledEvent : TVTAfterHeaderHeightTrackingEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTAfterHeaderHeightTrackingEvent(AEvent, AEnabledEvent : TVTAfterHeaderHeightTrackingEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTAfterItemEraseEvent(AEvent, ANewEvent : TVTAfterItemEraseEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTAfterItemEraseEvent(AEvent, AOldEvent : TVTAfterItemEraseEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTAfterItemEraseEvent(AEvent, ADisabledEvent : TVTAfterItemEraseEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTAfterItemEraseEvent(AEvent, AEnabledEvent : TVTAfterItemEraseEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTAfterItemPaintEvent(AEvent, ANewEvent : TVTAfterItemPaintEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTAfterItemPaintEvent(AEvent, AOldEvent : TVTAfterItemPaintEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTAfterItemPaintEvent(AEvent, ADisabledEvent : TVTAfterItemPaintEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTAfterItemPaintEvent(AEvent, AEnabledEvent : TVTAfterItemPaintEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTNodeExportEvent(AEvent, ANewEvent : TVTNodeExportEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTNodeExportEvent(AEvent, AOldEvent : TVTNodeExportEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTNodeExportEvent(AEvent, ADisabledEvent : TVTNodeExportEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTNodeExportEvent(AEvent, AEnabledEvent : TVTNodeExportEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTPaintEvent(AEvent, ANewEvent : TVTPaintEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTPaintEvent(AEvent, AOldEvent : TVTPaintEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTPaintEvent(AEvent, ADisabledEvent : TVTPaintEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTPaintEvent(AEvent, AEnabledEvent : TVTPaintEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTBeforeAutoFitColumnEvent(AEvent, ANewEvent : TVTBeforeAutoFitColumnEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTBeforeAutoFitColumnEvent(AEvent, AOldEvent : TVTBeforeAutoFitColumnEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTBeforeAutoFitColumnEvent(AEvent, ADisabledEvent : TVTBeforeAutoFitColumnEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTBeforeAutoFitColumnEvent(AEvent, AEnabledEvent : TVTBeforeAutoFitColumnEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTBeforeAutoFitColumnsEvent(AEvent, ANewEvent : TVTBeforeAutoFitColumnsEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTBeforeAutoFitColumnsEvent(AEvent, AOldEvent : TVTBeforeAutoFitColumnsEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTBeforeAutoFitColumnsEvent(AEvent, ADisabledEvent : TVTBeforeAutoFitColumnsEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTBeforeAutoFitColumnsEvent(AEvent, AEnabledEvent : TVTBeforeAutoFitColumnsEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTBeforeCellPaintEvent(AEvent, ANewEvent : TVTBeforeCellPaintEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTBeforeCellPaintEvent(AEvent, AOldEvent : TVTBeforeCellPaintEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTBeforeCellPaintEvent(AEvent, ADisabledEvent : TVTBeforeCellPaintEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTBeforeCellPaintEvent(AEvent, AEnabledEvent : TVTBeforeCellPaintEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTBeforeColumnWidthTrackingEvent(AEvent, ANewEvent : TVTBeforeColumnWidthTrackingEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTBeforeColumnWidthTrackingEvent(AEvent, AOldEvent : TVTBeforeColumnWidthTrackingEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTBeforeColumnWidthTrackingEvent(AEvent, ADisabledEvent : TVTBeforeColumnWidthTrackingEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTBeforeColumnWidthTrackingEvent(AEvent, AEnabledEvent : TVTBeforeColumnWidthTrackingEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTBeforeDrawLineImageEvent(AEvent, ANewEvent : TVTBeforeDrawLineImageEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTBeforeDrawLineImageEvent(AEvent, AOldEvent : TVTBeforeDrawLineImageEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTBeforeDrawLineImageEvent(AEvent, ADisabledEvent : TVTBeforeDrawLineImageEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTBeforeDrawLineImageEvent(AEvent, AEnabledEvent : TVTBeforeDrawLineImageEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTBeforeGetMaxColumnWidthEvent(AEvent, ANewEvent : TVTBeforeGetMaxColumnWidthEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTBeforeGetMaxColumnWidthEvent(AEvent, AOldEvent : TVTBeforeGetMaxColumnWidthEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTBeforeGetMaxColumnWidthEvent(AEvent, ADisabledEvent : TVTBeforeGetMaxColumnWidthEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTBeforeGetMaxColumnWidthEvent(AEvent, AEnabledEvent : TVTBeforeGetMaxColumnWidthEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTBeforeHeaderHeightTrackingEvent(AEvent, ANewEvent : TVTBeforeHeaderHeightTrackingEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTBeforeHeaderHeightTrackingEvent(AEvent, AOldEvent : TVTBeforeHeaderHeightTrackingEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTBeforeHeaderHeightTrackingEvent(AEvent, ADisabledEvent : TVTBeforeHeaderHeightTrackingEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTBeforeHeaderHeightTrackingEvent(AEvent, AEnabledEvent : TVTBeforeHeaderHeightTrackingEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTBeforeItemEraseEvent(AEvent, ANewEvent : TVTBeforeItemEraseEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTBeforeItemEraseEvent(AEvent, AOldEvent : TVTBeforeItemEraseEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTBeforeItemEraseEvent(AEvent, ADisabledEvent : TVTBeforeItemEraseEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTBeforeItemEraseEvent(AEvent, AEnabledEvent : TVTBeforeItemEraseEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTBeforeItemPaintEvent(AEvent, ANewEvent : TVTBeforeItemPaintEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTBeforeItemPaintEvent(AEvent, AOldEvent : TVTBeforeItemPaintEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTBeforeItemPaintEvent(AEvent, ADisabledEvent : TVTBeforeItemPaintEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTBeforeItemPaintEvent(AEvent, AEnabledEvent : TVTBeforeItemPaintEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterCanResizeEvent(AEvent, ANewEvent : TCanResizeEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterCanResizeEvent(AEvent, AOldEvent : TCanResizeEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableCanResizeEvent(AEvent, ADisabledEvent : TCanResizeEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableCanResizeEvent(AEvent, AEnabledEvent : TCanResizeEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTCanSplitterResizeColumnEvent(AEvent, ANewEvent : TVTCanSplitterResizeColumnEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTCanSplitterResizeColumnEvent(AEvent, AOldEvent : TVTCanSplitterResizeColumnEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTCanSplitterResizeColumnEvent(AEvent, ADisabledEvent : TVTCanSplitterResizeColumnEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTCanSplitterResizeColumnEvent(AEvent, AEnabledEvent : TVTCanSplitterResizeColumnEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTCanSplitterResizeHeaderEvent(AEvent, ANewEvent : TVTCanSplitterResizeHeaderEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTCanSplitterResizeHeaderEvent(AEvent, AOldEvent : TVTCanSplitterResizeHeaderEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTCanSplitterResizeHeaderEvent(AEvent, ADisabledEvent : TVTCanSplitterResizeHeaderEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTCanSplitterResizeHeaderEvent(AEvent, AEnabledEvent : TVTCanSplitterResizeHeaderEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTCanSplitterResizeNodeEvent(AEvent, ANewEvent : TVTCanSplitterResizeNodeEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTCanSplitterResizeNodeEvent(AEvent, AOldEvent : TVTCanSplitterResizeNodeEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTCanSplitterResizeNodeEvent(AEvent, ADisabledEvent : TVTCanSplitterResizeNodeEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTCanSplitterResizeNodeEvent(AEvent, AEnabledEvent : TVTCanSplitterResizeNodeEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTChangeEvent(AEvent, ANewEvent : TVTChangeEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTChangeEvent(AEvent, AOldEvent : TVTChangeEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTChangeEvent(AEvent, ADisabledEvent : TVTChangeEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTChangeEvent(AEvent, AEnabledEvent : TVTChangeEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTCheckChangingEvent(AEvent, ANewEvent : TVTCheckChangingEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTCheckChangingEvent(AEvent, AOldEvent : TVTCheckChangingEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTCheckChangingEvent(AEvent, ADisabledEvent : TVTCheckChangingEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTCheckChangingEvent(AEvent, AEnabledEvent : TVTCheckChangingEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTChangingEvent(AEvent, ANewEvent : TVTChangingEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTChangingEvent(AEvent, AOldEvent : TVTChangingEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTChangingEvent(AEvent, ADisabledEvent : TVTChangingEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTChangingEvent(AEvent, AEnabledEvent : TVTChangingEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTColumnClickEvent(AEvent, ANewEvent : TVTColumnClickEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTColumnClickEvent(AEvent, AOldEvent : TVTColumnClickEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTColumnClickEvent(AEvent, ADisabledEvent : TVTColumnClickEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTColumnClickEvent(AEvent, AEnabledEvent : TVTColumnClickEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTColumnDblClickEvent(AEvent, ANewEvent : TVTColumnDblClickEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTColumnDblClickEvent(AEvent, AOldEvent : TVTColumnDblClickEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTColumnDblClickEvent(AEvent, ADisabledEvent : TVTColumnDblClickEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTColumnDblClickEvent(AEvent, AEnabledEvent : TVTColumnDblClickEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTHeaderNotifyEvent(AEvent, ANewEvent : TVTHeaderNotifyEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTHeaderNotifyEvent(AEvent, AOldEvent : TVTHeaderNotifyEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTHeaderNotifyEvent(AEvent, ADisabledEvent : TVTHeaderNotifyEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTHeaderNotifyEvent(AEvent, AEnabledEvent : TVTHeaderNotifyEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterColumnChangeEvent(AEvent, ANewEvent : TColumnChangeEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterColumnChangeEvent(AEvent, AOldEvent : TColumnChangeEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableColumnChangeEvent(AEvent, ADisabledEvent : TColumnChangeEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableColumnChangeEvent(AEvent, AEnabledEvent : TColumnChangeEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTColumnWidthDblClickResizeEvent(AEvent, ANewEvent : TVTColumnWidthDblClickResizeEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTColumnWidthDblClickResizeEvent(AEvent, AOldEvent : TVTColumnWidthDblClickResizeEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTColumnWidthDblClickResizeEvent(AEvent, ADisabledEvent : TVTColumnWidthDblClickResizeEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTColumnWidthDblClickResizeEvent(AEvent, AEnabledEvent : TVTColumnWidthDblClickResizeEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTColumnWidthTrackingEvent(AEvent, ANewEvent : TVTColumnWidthTrackingEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTColumnWidthTrackingEvent(AEvent, AOldEvent : TVTColumnWidthTrackingEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTColumnWidthTrackingEvent(AEvent, ADisabledEvent : TVTColumnWidthTrackingEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTColumnWidthTrackingEvent(AEvent, AEnabledEvent : TVTColumnWidthTrackingEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTCompareEvent(AEvent, ANewEvent : TVTCompareEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTCompareEvent(AEvent, AOldEvent : TVTCompareEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTCompareEvent(AEvent, ADisabledEvent : TVTCompareEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTCompareEvent(AEvent, AEnabledEvent : TVTCompareEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTCreateDataObjectEvent(AEvent, ANewEvent : TVTCreateDataObjectEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTCreateDataObjectEvent(AEvent, AOldEvent : TVTCreateDataObjectEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTCreateDataObjectEvent(AEvent, ADisabledEvent : TVTCreateDataObjectEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTCreateDataObjectEvent(AEvent, AEnabledEvent : TVTCreateDataObjectEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTCreateDragManagerEvent(AEvent, ANewEvent : TVTCreateDragManagerEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTCreateDragManagerEvent(AEvent, AOldEvent : TVTCreateDragManagerEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTCreateDragManagerEvent(AEvent, ADisabledEvent : TVTCreateDragManagerEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTCreateDragManagerEvent(AEvent, AEnabledEvent : TVTCreateDragManagerEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTCreateEditorEvent(AEvent, ANewEvent : TVTCreateEditorEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTCreateEditorEvent(AEvent, AOldEvent : TVTCreateEditorEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTCreateEditorEvent(AEvent, ADisabledEvent : TVTCreateEditorEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTCreateEditorEvent(AEvent, AEnabledEvent : TVTCreateEditorEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTDragAllowedEvent(AEvent, ANewEvent : TVTDragAllowedEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTDragAllowedEvent(AEvent, AOldEvent : TVTDragAllowedEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTDragAllowedEvent(AEvent, ADisabledEvent : TVTDragAllowedEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTDragAllowedEvent(AEvent, AEnabledEvent : TVTDragAllowedEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTDragDropEvent(AEvent, ANewEvent : TVTDragDropEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTDragDropEvent(AEvent, AOldEvent : TVTDragDropEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTDragDropEvent(AEvent, ADisabledEvent : TVTDragDropEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTDragDropEvent(AEvent, AEnabledEvent : TVTDragDropEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTDragOverEvent(AEvent, ANewEvent : TVTDragOverEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTDragOverEvent(AEvent, AOldEvent : TVTDragOverEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTDragOverEvent(AEvent, ADisabledEvent : TVTDragOverEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTDragOverEvent(AEvent, AEnabledEvent : TVTDragOverEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTDrawHintEvent(AEvent, ANewEvent : TVTDrawHintEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTDrawHintEvent(AEvent, AOldEvent : TVTDrawHintEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTDrawHintEvent(AEvent, ADisabledEvent : TVTDrawHintEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTDrawHintEvent(AEvent, AEnabledEvent : TVTDrawHintEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTDrawTextEvent(AEvent, ANewEvent : TVTDrawTextEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTDrawTextEvent(AEvent, AOldEvent : TVTDrawTextEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTDrawTextEvent(AEvent, ADisabledEvent : TVTDrawTextEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTDrawTextEvent(AEvent, AEnabledEvent : TVTDrawTextEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTEditCancelEvent(AEvent, ANewEvent : TVTEditCancelEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTEditCancelEvent(AEvent, AOldEvent : TVTEditCancelEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTEditCancelEvent(AEvent, ADisabledEvent : TVTEditCancelEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTEditCancelEvent(AEvent, AEnabledEvent : TVTEditCancelEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTEditChangeEvent(AEvent, ANewEvent : TVTEditChangeEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTEditChangeEvent(AEvent, AOldEvent : TVTEditChangeEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTEditChangeEvent(AEvent, ADisabledEvent : TVTEditChangeEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTEditChangeEvent(AEvent, AEnabledEvent : TVTEditChangeEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTEditChangingEvent(AEvent, ANewEvent : TVTEditChangingEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTEditChangingEvent(AEvent, AOldEvent : TVTEditChangingEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTEditChangingEvent(AEvent, ADisabledEvent : TVTEditChangingEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTEditChangingEvent(AEvent, AEnabledEvent : TVTEditChangingEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTOperationEvent(AEvent, ANewEvent : TVTOperationEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTOperationEvent(AEvent, AOldEvent : TVTOperationEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTOperationEvent(AEvent, ADisabledEvent : TVTOperationEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTOperationEvent(AEvent, AEnabledEvent : TVTOperationEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTFocusChangeEvent(AEvent, ANewEvent : TVTFocusChangeEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTFocusChangeEvent(AEvent, AOldEvent : TVTFocusChangeEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTFocusChangeEvent(AEvent, ADisabledEvent : TVTFocusChangeEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTFocusChangeEvent(AEvent, AEnabledEvent : TVTFocusChangeEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTFocusChangingEvent(AEvent, ANewEvent : TVTFocusChangingEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTFocusChangingEvent(AEvent, AOldEvent : TVTFocusChangingEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTFocusChangingEvent(AEvent, ADisabledEvent : TVTFocusChangingEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTFocusChangingEvent(AEvent, AEnabledEvent : TVTFocusChangingEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTFreeNodeEvent(AEvent, ANewEvent : TVTFreeNodeEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTFreeNodeEvent(AEvent, AOldEvent : TVTFreeNodeEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTFreeNodeEvent(AEvent, ADisabledEvent : TVTFreeNodeEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTFreeNodeEvent(AEvent, AEnabledEvent : TVTFreeNodeEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTGetCellIsEmptyEvent(AEvent, ANewEvent : TVTGetCellIsEmptyEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTGetCellIsEmptyEvent(AEvent, AOldEvent : TVTGetCellIsEmptyEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTGetCellIsEmptyEvent(AEvent, ADisabledEvent : TVTGetCellIsEmptyEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTGetCellIsEmptyEvent(AEvent, AEnabledEvent : TVTGetCellIsEmptyEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVSTGetCellTextEvent(AEvent, ANewEvent : TVSTGetCellTextEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVSTGetCellTextEvent(AEvent, AOldEvent : TVSTGetCellTextEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVSTGetCellTextEvent(AEvent, ADisabledEvent : TVSTGetCellTextEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVSTGetCellTextEvent(AEvent, AEnabledEvent : TVSTGetCellTextEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTGetCursorEvent(AEvent, ANewEvent : TVTGetCursorEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTGetCursorEvent(AEvent, AOldEvent : TVTGetCursorEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTGetCursorEvent(AEvent, ADisabledEvent : TVTGetCursorEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTGetCursorEvent(AEvent, AEnabledEvent : TVTGetCursorEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTGetHeaderCursorEvent(AEvent, ANewEvent : TVTGetHeaderCursorEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTGetHeaderCursorEvent(AEvent, AOldEvent : TVTGetHeaderCursorEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTGetHeaderCursorEvent(AEvent, ADisabledEvent : TVTGetHeaderCursorEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTGetHeaderCursorEvent(AEvent, AEnabledEvent : TVTGetHeaderCursorEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTHelpContextEvent(AEvent, ANewEvent : TVTHelpContextEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTHelpContextEvent(AEvent, AOldEvent : TVTHelpContextEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTHelpContextEvent(AEvent, ADisabledEvent : TVTHelpContextEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTHelpContextEvent(AEvent, AEnabledEvent : TVTHelpContextEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVSTGetHintEvent(AEvent, ANewEvent : TVSTGetHintEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVSTGetHintEvent(AEvent, AOldEvent : TVSTGetHintEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVSTGetHintEvent(AEvent, ADisabledEvent : TVSTGetHintEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVSTGetHintEvent(AEvent, AEnabledEvent : TVSTGetHintEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTHintKindEvent(AEvent, ANewEvent : TVTHintKindEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTHintKindEvent(AEvent, AOldEvent : TVTHintKindEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTHintKindEvent(AEvent, ADisabledEvent : TVTHintKindEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTHintKindEvent(AEvent, AEnabledEvent : TVTHintKindEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTGetHintSizeEvent(AEvent, ANewEvent : TVTGetHintSizeEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTGetHintSizeEvent(AEvent, AOldEvent : TVTGetHintSizeEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTGetHintSizeEvent(AEvent, ADisabledEvent : TVTGetHintSizeEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTGetHintSizeEvent(AEvent, AEnabledEvent : TVTGetHintSizeEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTGetImageEvent(AEvent, ANewEvent : TVTGetImageEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTGetImageEvent(AEvent, AOldEvent : TVTGetImageEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTGetImageEvent(AEvent, ADisabledEvent : TVTGetImageEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTGetImageEvent(AEvent, AEnabledEvent : TVTGetImageEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTGetImageExEvent(AEvent, ANewEvent : TVTGetImageExEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTGetImageExEvent(AEvent, AOldEvent : TVTGetImageExEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTGetImageExEvent(AEvent, ADisabledEvent : TVTGetImageExEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTGetImageExEvent(AEvent, AEnabledEvent : TVTGetImageExEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTGetImageTextEvent(AEvent, ANewEvent : TVTGetImageTextEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTGetImageTextEvent(AEvent, AOldEvent : TVTGetImageTextEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTGetImageTextEvent(AEvent, ADisabledEvent : TVTGetImageTextEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTGetImageTextEvent(AEvent, AEnabledEvent : TVTGetImageTextEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTGetLineStyleEvent(AEvent, ANewEvent : TVTGetLineStyleEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTGetLineStyleEvent(AEvent, AOldEvent : TVTGetLineStyleEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTGetLineStyleEvent(AEvent, ADisabledEvent : TVTGetLineStyleEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTGetLineStyleEvent(AEvent, AEnabledEvent : TVTGetLineStyleEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTGetNodeDataSizeEvent(AEvent, ANewEvent : TVTGetNodeDataSizeEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTGetNodeDataSizeEvent(AEvent, AOldEvent : TVTGetNodeDataSizeEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTGetNodeDataSizeEvent(AEvent, ADisabledEvent : TVTGetNodeDataSizeEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTGetNodeDataSizeEvent(AEvent, AEnabledEvent : TVTGetNodeDataSizeEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTPopupEvent(AEvent, ANewEvent : TVTPopupEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTPopupEvent(AEvent, AOldEvent : TVTPopupEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTPopupEvent(AEvent, ADisabledEvent : TVTPopupEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTPopupEvent(AEvent, AEnabledEvent : TVTPopupEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVSTGetTextEvent(AEvent, ANewEvent : TVSTGetTextEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVSTGetTextEvent(AEvent, AOldEvent : TVSTGetTextEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVSTGetTextEvent(AEvent, ADisabledEvent : TVSTGetTextEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVSTGetTextEvent(AEvent, AEnabledEvent : TVSTGetTextEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTGetUserClipboardFormatsEvent(AEvent, ANewEvent : TVTGetUserClipboardFormatsEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTGetUserClipboardFormatsEvent(AEvent, AOldEvent : TVTGetUserClipboardFormatsEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTGetUserClipboardFormatsEvent(AEvent, ADisabledEvent : TVTGetUserClipboardFormatsEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTGetUserClipboardFormatsEvent(AEvent, AEnabledEvent : TVTGetUserClipboardFormatsEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTHeaderClickEvent(AEvent, ANewEvent : TVTHeaderClickEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTHeaderClickEvent(AEvent, AOldEvent : TVTHeaderClickEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTHeaderClickEvent(AEvent, ADisabledEvent : TVTHeaderClickEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTHeaderClickEvent(AEvent, AEnabledEvent : TVTHeaderClickEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTHeaderDraggedEvent(AEvent, ANewEvent : TVTHeaderDraggedEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTHeaderDraggedEvent(AEvent, AOldEvent : TVTHeaderDraggedEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTHeaderDraggedEvent(AEvent, ADisabledEvent : TVTHeaderDraggedEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTHeaderDraggedEvent(AEvent, AEnabledEvent : TVTHeaderDraggedEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTHeaderDraggedOutEvent(AEvent, ANewEvent : TVTHeaderDraggedOutEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTHeaderDraggedOutEvent(AEvent, AOldEvent : TVTHeaderDraggedOutEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTHeaderDraggedOutEvent(AEvent, ADisabledEvent : TVTHeaderDraggedOutEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTHeaderDraggedOutEvent(AEvent, AEnabledEvent : TVTHeaderDraggedOutEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTHeaderDraggingEvent(AEvent, ANewEvent : TVTHeaderDraggingEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTHeaderDraggingEvent(AEvent, AOldEvent : TVTHeaderDraggingEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTHeaderDraggingEvent(AEvent, ADisabledEvent : TVTHeaderDraggingEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTHeaderDraggingEvent(AEvent, AEnabledEvent : TVTHeaderDraggingEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTHeaderPaintEvent(AEvent, ANewEvent : TVTHeaderPaintEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTHeaderPaintEvent(AEvent, AOldEvent : TVTHeaderPaintEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTHeaderPaintEvent(AEvent, ADisabledEvent : TVTHeaderPaintEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTHeaderPaintEvent(AEvent, AEnabledEvent : TVTHeaderPaintEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTHeaderPaintQueryElementsEvent(AEvent, ANewEvent : TVTHeaderPaintQueryElementsEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTHeaderPaintQueryElementsEvent(AEvent, AOldEvent : TVTHeaderPaintQueryElementsEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTHeaderPaintQueryElementsEvent(AEvent, ADisabledEvent : TVTHeaderPaintQueryElementsEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTHeaderPaintQueryElementsEvent(AEvent, AEnabledEvent : TVTHeaderPaintQueryElementsEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTHeaderHeightDblClickResizeEvent(AEvent, ANewEvent : TVTHeaderHeightDblClickResizeEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTHeaderHeightDblClickResizeEvent(AEvent, AOldEvent : TVTHeaderHeightDblClickResizeEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTHeaderHeightDblClickResizeEvent(AEvent, ADisabledEvent : TVTHeaderHeightDblClickResizeEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTHeaderHeightDblClickResizeEvent(AEvent, AEnabledEvent : TVTHeaderHeightDblClickResizeEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTHeaderHeightTrackingEvent(AEvent, ANewEvent : TVTHeaderHeightTrackingEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTHeaderHeightTrackingEvent(AEvent, AOldEvent : TVTHeaderHeightTrackingEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTHeaderHeightTrackingEvent(AEvent, ADisabledEvent : TVTHeaderHeightTrackingEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTHeaderHeightTrackingEvent(AEvent, AEnabledEvent : TVTHeaderHeightTrackingEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTHeaderMouseEvent(AEvent, ANewEvent : TVTHeaderMouseEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTHeaderMouseEvent(AEvent, AOldEvent : TVTHeaderMouseEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTHeaderMouseEvent(AEvent, ADisabledEvent : TVTHeaderMouseEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTHeaderMouseEvent(AEvent, AEnabledEvent : TVTHeaderMouseEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTHeaderMouseMoveEvent(AEvent, ANewEvent : TVTHeaderMouseMoveEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTHeaderMouseMoveEvent(AEvent, AOldEvent : TVTHeaderMouseMoveEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTHeaderMouseMoveEvent(AEvent, ADisabledEvent : TVTHeaderMouseMoveEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTHeaderMouseMoveEvent(AEvent, AEnabledEvent : TVTHeaderMouseMoveEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTHotNodeChangeEvent(AEvent, ANewEvent : TVTHotNodeChangeEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTHotNodeChangeEvent(AEvent, AOldEvent : TVTHotNodeChangeEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTHotNodeChangeEvent(AEvent, ADisabledEvent : TVTHotNodeChangeEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTHotNodeChangeEvent(AEvent, AEnabledEvent : TVTHotNodeChangeEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTIncrementalSearchEvent(AEvent, ANewEvent : TVTIncrementalSearchEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTIncrementalSearchEvent(AEvent, AOldEvent : TVTIncrementalSearchEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTIncrementalSearchEvent(AEvent, ADisabledEvent : TVTIncrementalSearchEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTIncrementalSearchEvent(AEvent, AEnabledEvent : TVTIncrementalSearchEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTInitChildrenEvent(AEvent, ANewEvent : TVTInitChildrenEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTInitChildrenEvent(AEvent, AOldEvent : TVTInitChildrenEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTInitChildrenEvent(AEvent, ADisabledEvent : TVTInitChildrenEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTInitChildrenEvent(AEvent, AEnabledEvent : TVTInitChildrenEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTInitNodeEvent(AEvent, ANewEvent : TVTInitNodeEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTInitNodeEvent(AEvent, AOldEvent : TVTInitNodeEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTInitNodeEvent(AEvent, ADisabledEvent : TVTInitNodeEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTInitNodeEvent(AEvent, AEnabledEvent : TVTInitNodeEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTKeyActionEvent(AEvent, ANewEvent : TVTKeyActionEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTKeyActionEvent(AEvent, AOldEvent : TVTKeyActionEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTKeyActionEvent(AEvent, ADisabledEvent : TVTKeyActionEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTKeyActionEvent(AEvent, AEnabledEvent : TVTKeyActionEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTSaveNodeEvent(AEvent, ANewEvent : TVTSaveNodeEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTSaveNodeEvent(AEvent, AOldEvent : TVTSaveNodeEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTSaveNodeEvent(AEvent, ADisabledEvent : TVTSaveNodeEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTSaveNodeEvent(AEvent, AEnabledEvent : TVTSaveNodeEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTSaveTreeEvent(AEvent, ANewEvent : TVTSaveTreeEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTSaveTreeEvent(AEvent, AOldEvent : TVTSaveTreeEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTSaveTreeEvent(AEvent, ADisabledEvent : TVTSaveTreeEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTSaveTreeEvent(AEvent, AEnabledEvent : TVTSaveTreeEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTMeasureItemEvent(AEvent, ANewEvent : TVTMeasureItemEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTMeasureItemEvent(AEvent, AOldEvent : TVTMeasureItemEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTMeasureItemEvent(AEvent, ADisabledEvent : TVTMeasureItemEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTMeasureItemEvent(AEvent, AEnabledEvent : TVTMeasureItemEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTMeasureTextEvent(AEvent, ANewEvent : TVTMeasureTextEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTMeasureTextEvent(AEvent, AOldEvent : TVTMeasureTextEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTMeasureTextEvent(AEvent, ADisabledEvent : TVTMeasureTextEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTMeasureTextEvent(AEvent, AEnabledEvent : TVTMeasureTextEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterMouseWheelEvent(AEvent, ANewEvent : TMouseWheelEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterMouseWheelEvent(AEvent, AOldEvent : TMouseWheelEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableMouseWheelEvent(AEvent, ADisabledEvent : TMouseWheelEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableMouseWheelEvent(AEvent, AEnabledEvent : TMouseWheelEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVSTNewTextEvent(AEvent, ANewEvent : TVSTNewTextEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVSTNewTextEvent(AEvent, AOldEvent : TVSTNewTextEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVSTNewTextEvent(AEvent, ADisabledEvent : TVSTNewTextEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVSTNewTextEvent(AEvent, AEnabledEvent : TVSTNewTextEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTNodeClickEvent(AEvent, ANewEvent : TVTNodeClickEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTNodeClickEvent(AEvent, AOldEvent : TVTNodeClickEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTNodeClickEvent(AEvent, ADisabledEvent : TVTNodeClickEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTNodeClickEvent(AEvent, AEnabledEvent : TVTNodeClickEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTNodeCopiedEvent(AEvent, ANewEvent : TVTNodeCopiedEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTNodeCopiedEvent(AEvent, AOldEvent : TVTNodeCopiedEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTNodeCopiedEvent(AEvent, ADisabledEvent : TVTNodeCopiedEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTNodeCopiedEvent(AEvent, AEnabledEvent : TVTNodeCopiedEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTNodeCopyingEvent(AEvent, ANewEvent : TVTNodeCopyingEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTNodeCopyingEvent(AEvent, AOldEvent : TVTNodeCopyingEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTNodeCopyingEvent(AEvent, ADisabledEvent : TVTNodeCopyingEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTNodeCopyingEvent(AEvent, AEnabledEvent : TVTNodeCopyingEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTNodeHeightDblClickResizeEvent(AEvent, ANewEvent : TVTNodeHeightDblClickResizeEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTNodeHeightDblClickResizeEvent(AEvent, AOldEvent : TVTNodeHeightDblClickResizeEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTNodeHeightDblClickResizeEvent(AEvent, ADisabledEvent : TVTNodeHeightDblClickResizeEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTNodeHeightDblClickResizeEvent(AEvent, AEnabledEvent : TVTNodeHeightDblClickResizeEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTNodeHeightTrackingEvent(AEvent, ANewEvent : TVTNodeHeightTrackingEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTNodeHeightTrackingEvent(AEvent, AOldEvent : TVTNodeHeightTrackingEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTNodeHeightTrackingEvent(AEvent, ADisabledEvent : TVTNodeHeightTrackingEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTNodeHeightTrackingEvent(AEvent, AEnabledEvent : TVTNodeHeightTrackingEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTNodeMovedEvent(AEvent, ANewEvent : TVTNodeMovedEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTNodeMovedEvent(AEvent, AOldEvent : TVTNodeMovedEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTNodeMovedEvent(AEvent, ADisabledEvent : TVTNodeMovedEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTNodeMovedEvent(AEvent, AEnabledEvent : TVTNodeMovedEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTNodeMovingEvent(AEvent, ANewEvent : TVTNodeMovingEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTNodeMovingEvent(AEvent, AOldEvent : TVTNodeMovingEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTNodeMovingEvent(AEvent, ADisabledEvent : TVTNodeMovingEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTNodeMovingEvent(AEvent, AEnabledEvent : TVTNodeMovingEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTBackgroundPaintEvent(AEvent, ANewEvent : TVTBackgroundPaintEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTBackgroundPaintEvent(AEvent, AOldEvent : TVTBackgroundPaintEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTBackgroundPaintEvent(AEvent, ADisabledEvent : TVTBackgroundPaintEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTBackgroundPaintEvent(AEvent, AEnabledEvent : TVTBackgroundPaintEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTPaintText(AEvent, ANewEvent : TVTPaintText; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTPaintText(AEvent, AOldEvent : TVTPaintText);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTPaintText(AEvent, ADisabledEvent : TVTPaintText);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTPaintText(AEvent, AEnabledEvent : TVTPaintText);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTPrepareButtonImagesEvent(AEvent, ANewEvent : TVTPrepareButtonImagesEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTPrepareButtonImagesEvent(AEvent, AOldEvent : TVTPrepareButtonImagesEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTPrepareButtonImagesEvent(AEvent, ADisabledEvent : TVTPrepareButtonImagesEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTPrepareButtonImagesEvent(AEvent, AEnabledEvent : TVTPrepareButtonImagesEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTRemoveFromSelectionEvent(AEvent, ANewEvent : TVTRemoveFromSelectionEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTRemoveFromSelectionEvent(AEvent, AOldEvent : TVTRemoveFromSelectionEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTRemoveFromSelectionEvent(AEvent, ADisabledEvent : TVTRemoveFromSelectionEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTRemoveFromSelectionEvent(AEvent, AEnabledEvent : TVTRemoveFromSelectionEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTRenderOLEDataEvent(AEvent, ANewEvent : TVTRenderOLEDataEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTRenderOLEDataEvent(AEvent, AOldEvent : TVTRenderOLEDataEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTRenderOLEDataEvent(AEvent, ADisabledEvent : TVTRenderOLEDataEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTRenderOLEDataEvent(AEvent, AEnabledEvent : TVTRenderOLEDataEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTScrollEvent(AEvent, ANewEvent : TVTScrollEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTScrollEvent(AEvent, AOldEvent : TVTScrollEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTScrollEvent(AEvent, ADisabledEvent : TVTScrollEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTScrollEvent(AEvent, AEnabledEvent : TVTScrollEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVSTShortenStringEvent(AEvent, ANewEvent : TVSTShortenStringEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVSTShortenStringEvent(AEvent, AOldEvent : TVSTShortenStringEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVSTShortenStringEvent(AEvent, ADisabledEvent : TVSTShortenStringEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVSTShortenStringEvent(AEvent, AEnabledEvent : TVSTShortenStringEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTScrollBarShowEvent(AEvent, ANewEvent : TVTScrollBarShowEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTScrollBarShowEvent(AEvent, AOldEvent : TVTScrollBarShowEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTScrollBarShowEvent(AEvent, ADisabledEvent : TVTScrollBarShowEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTScrollBarShowEvent(AEvent, AEnabledEvent : TVTScrollBarShowEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTStateChangeEvent(AEvent, ANewEvent : TVTStateChangeEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTStateChangeEvent(AEvent, AOldEvent : TVTStateChangeEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTStateChangeEvent(AEvent, ADisabledEvent : TVTStateChangeEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTStateChangeEvent(AEvent, AEnabledEvent : TVTStateChangeEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTStructureChangeEvent(AEvent, ANewEvent : TVTStructureChangeEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTStructureChangeEvent(AEvent, AOldEvent : TVTStructureChangeEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTStructureChangeEvent(AEvent, ADisabledEvent : TVTStructureChangeEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTStructureChangeEvent(AEvent, AEnabledEvent : TVTStructureChangeEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.RegisterVTUpdatingEvent(AEvent, ANewEvent : TVTUpdatingEvent; Const Index : Integer = -1);
Begin
  InternalRegisterEvent(TMethod(AEvent), TMethod(ANewEvent), Index);
End;

Procedure TVirtualStringTreeEventDispatcher.UnRegisterVTUpdatingEvent(AEvent, AOldEvent : TVTUpdatingEvent);
Begin
  InternalUnRegisterEvent(TMethod(AEvent), TMethod(AOldEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.DisableVTUpdatingEvent(AEvent, ADisabledEvent : TVTUpdatingEvent);
Begin
  InternalDisableEvent(TMethod(AEvent), TMethod(ADisabledEvent));
End;

Procedure TVirtualStringTreeEventDispatcher.EnableVTUpdatingEvent(AEvent, AEnabledEvent : TVTUpdatingEvent);
Begin
  InternalEnableEvent(TMethod(AEvent), TMethod(AEnabledEvent));
End;

End.
