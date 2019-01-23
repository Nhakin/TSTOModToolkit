unit HsVirtualNodeEx;

interface

Uses
  Windows, SysUtils, Graphics, Messages, Classes, ImgList, HsInterfaceEx,
  VirtualTrees, VirtualTrees.D2007Types;

Type
  IVirtualNodeDataEx = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-B58B-BBD7AA55535C}']
    
  End;

  IVirtualNodeListEx = Interface;
  IVirtualNodeEx = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-9737-1F5CEDE9B841}']
    Function  GetIndex() : Cardinal;

    Function  GetChildCount() : Cardinal;

    Function  GetNodeHeight() : Word;
    Procedure SetNodeHeight(Const AHeight : Word);

    Function  GetStates() : TVirtualNodeStates;
    Procedure SetStates(Const AStates : TVirtualNodeStates);

    Function  GetAlign() : Byte;
    Procedure SetAlign(Const AAlign : Byte);

    Function  GetCheckState() : TCheckState;
    Procedure SetCheckState(Const ACheckState : TCheckState);

    Function  GetCheckType() : TCheckType;
    Procedure SetCheckType(Const ACheckType : TCheckType);

    Function  GetTotalCount() : Cardinal;

    Function  GetTotalHeight() : Cardinal;
    Procedure SetTotalHeight(ATotalHeight : Cardinal);

    Function  GetParent() : IVirtualNodeEx;
    Function  GetPrevSibling() : IVirtualNodeEx;
    Function  GetNextSibling() : IVirtualNodeEx;
    Function  GetFirstChild() : IVirtualNodeEx;
    Function  GetLastChild() : IVirtualNodeEx;

    Function  GetLevel() : Integer;
    Function  GetChilds() : IVirtualNodeListEx;
    
    Function  GetNodeData() : IVirtualNodeDataEx;
    Procedure SetNodeData(ANodeData : IVirtualNodeDataEx);

    Property Index       : Cardinal           Read GetIndex;
    Property ChildCount  : Cardinal           Read GetChildCount;
    Property NodeHeight  : Word               Read GetNodeHeight  Write SetNodeHeight;
    Property States      : TVirtualNodeStates Read GetStates      Write SetStates;
    Property Align       : Byte               Read GetAlign       Write SetAlign;
    Property CheckState  : TCheckState        Read GetCheckState  Write SetCheckState;
    Property CheckType   : TCheckType         Read GetCheckType   Write SetCheckType;
    Property TotalCount  : Cardinal           Read GetTotalCount;
    Property TotalHeight : Cardinal           Read GetTotalHeight Write SetTotalHeight;
    Property Parent      : IVirtualNodeEx     Read GetParent;
    Property PrevSibling : IVirtualNodeEx     Read GetPrevSibling;
    Property NextSibling : IVirtualNodeEx     Read GetNextSibling;
    Property FirstChild  : IVirtualNodeEx     Read GetFirstChild;
    Property LastChild   : IVirtualNodeEx     Read GetLastChild;

    Property Level       : Integer            Read GetLevel;
    Property Childs      : IVirtualNodeListEx Read GetChilds;
    
    Property NodeData    : IVirtualNodeDataEx Read GetNodeData    Write SetNodeData;

  End;

  IVirtualNodeListEx = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-9461-C2FF69A65334}']
    Function  Get(Index: Integer) : IVirtualNodeEx;
    Procedure Put(Index: Integer; Const Item: IVirtualNodeEx);

    Function  GetCount() : Integer;

    Property Items[Index : Integer] : IVirtualNodeEx Read Get Write Put; Default;

    Property Count : Integer Read GetCount;

  End;

  TVTColumnType = (vtctString, vtctInteger, vtctDouble, vtctBoolean, vtctDateTime);

  IVTColumnEx = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-8CD6-7D02CF21DDEA}']
    Function  GetColumnName() : String;
    Procedure SetColumnName(Const AColumnName : String);

    Function  GetColumnType() : TVTColumnType;
    Procedure SetColumnType(Const AColumnType : TVTColumnType);

    Function  GetColumnValue() : Variant;
    Procedure SetColumnValue(Const AColumnValue : Variant);

    Function  GetAsString() : String;
    Procedure SetAsString(Const AString : String);

    Function  GetAsBoolean() : Boolean;
    Procedure SetAsBoolean(Const ABoolean : Boolean);

    Function  GetAsDateTime() : TDateTime;
    Procedure SetAsDateTime(Const ADateTime : TDateTime);

    Function  GetAsFloat() : Double;
    Procedure SetAsFloat(Const AFloat : Double);

    Property ColumnName        : String        Read GetColumnName  Write SetColumnName;
    Property ColumnType        : TVTColumnType Read GetColumnType  Write SetColumnType;
    Property ColumnValue       : Variant       Read GetColumnValue Write SetColumnValue;

    Property AsString   : String    Read GetAsString   Write SetAsString;
    Property AsBoolean  : Boolean   Read GetAsBoolean  Write SetAsBoolean;
    Property AsDateTime : TDateTime Read GetAsDateTime Write SetAsDateTime;
    Property AsFloat    : Double    Read GetAsFloat    Write SetAsFloat;
    
  End;

  IVTStringColumnEx = Interface(IVTColumnEx)
    ['{4B61686E-29A0-2112-BBF2-15C003FDE245}']
    Function  GetSize() : Integer;
    Procedure SetSize(Const ASize : Integer);

    Property Size : Integer Read GetSize Write SetSize;
    
  End;

  IVTBooleanColumnEx = Interface(IVTColumnEx)
    ['{4B61686E-29A0-2112-99AC-3ADFA42EB2B7}']
    Function  GetDisplayAsCheckBox() : Boolean;
    Procedure SetDisplayAsCheckBox(Const ADisplayAsCheckBox : Boolean);

    Property DisplayAsCheckBox : Boolean Read GetDisplayAsCheckBox Write SetDisplayAsCheckBox;

  End;

  IVTDisplayFormatColumnEx = Interface(IVTColumnEx)
    ['{4B61686E-29A0-2112-ADF3-5011DF30FD80}']
    Function  GetDisplayFormat() : String;
    Procedure SetDisplayFormat(Const ADisplayFormat : String);

    Property DisplayFormat : String Read GetDisplayFormat Write SetDisplayFormat;

  End;

  TVTColumnDateFormat = (dfDate, dfTime, dfDateTime);
  IVTDateTimeColumnEx = Interface(IVTDisplayFormatColumnEx)
    ['{4B61686E-29A0-2112-97E5-288D057DA0E4}']
    Function  GetDateFormat() : TVTColumnDateFormat;
    Procedure SetDateFormat(Const ADateFormat : TVTColumnDateFormat);

  End;

  IVTFloatColumnEx = Interface(IVTDisplayFormatColumnEx)
    ['{4B61686E-29A0-2112-A1C8-F3D3033D1475}']
    Function  GetCurrency() : Boolean;
    Procedure SetCurrency(ACurrency : Boolean);

    Function  GetPrecision() : Integer;
    Procedure SetPrecision(Const APrecision : Integer);

    Property Currency  : Boolean Read GetCurrency  Write SetCurrency;
    Property Precision : Integer Read GetPrecision Write SetPrecision;
    
  End;

  IVTColumnExs = Interface(IVirtualNodeDataEx)
    ['{4B61686E-29A0-2112-9511-D51AE2A86F7E}']
    Function  Get(Index : Integer) : IVTColumnEx;
    Procedure Put(Index : Integer; Const Item : IVTColumnEx);

    Function  GetCount() : Integer;
    
    Function Add(Const AItem : IVTColumnEx) : Integer;
    Function AddStringColumn() : IVTStringColumnEx;
    Function AddBooleanColumn() : IVTBooleanColumnEx;
    Function AddDateTimeColumn() : IVTDateTimeColumnEx;
    Function AddFloatColumn() : IVTFloatColumnEx;
    
    Property Items[Index : Integer] : IVTColumnEx Read Get Write Put; Default;

    Property Count : Integer Read GetCount;

  End;

  IVTRowEx = Interface(IVirtualNodeEx)
    ['{4B61686E-29A0-2112-90C9-DDBACE3EA3DB}']
    Function GetColumns() : IVTColumnExs;
    Function ColumnByName(Const AColumnName : String) : IVTColumnEx;
    
    Property Columns : IVTColumnExs Read GetColumns;

  End;

  IVTRowExs = Interface(IVirtualNodeListEx)
    ['{4B61686E-29A0-2112-B0A0-F0E82927EAE1}']
    Function  Get(Index : Integer) : IVTRowEx;
    Procedure Put(Index : Integer; Const Item : IVTRowEx);

    Function Add() : IVTRowEx; OverLoad;
    Function Add(Const AItem : IVTRowEx) : Integer; OverLoad;

    Property Items[Index : Integer] : IVTRowEx Read Get Write Put; Default;

  End;
  
(******************************************************************************)

  TVirtualNodeDataEx = Class;
  TVirtualNodeEx = Class;
  TVirtualNodeExClass = Class Of TVirtualNodeEx;
  TVirtualNodeDataExClass = Class Of TVirtualNodeDataEx;

  TVirtualNodeListEx = Class(TInterfaceListEx, IVirtualNodeListEx)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;

    Function  Get(Index: Integer) : IVirtualNodeEx;
    Procedure Put(Index: Integer; Const Item: IVirtualNodeEx);

  End;

  TVirtualNodeDataEx = Class(TInterfacedObjectEx, IVirtualNodeDataEx)
  End;

  TVirtualNodeEx = Class(TInterfacedObjectEx, IVirtualNodeEx)
  Private
    FTreeView : TBaseVirtualTree;
    FNode     : PVirtualNode;
    FNodeData : IVirtualNodeDataEx;

  Protected
    Function GetNodeDataClass() : TVirtualNodeDataExClass; Virtual;
    Function GetNodeClass() : TVirtualNodeExClass; Virtual;

    Function  GetIndex() : Cardinal;

    Function  GetChildCount() : Cardinal;

    Function  GetNodeHeight() : Word;
    Procedure SetNodeHeight(Const AHeight : Word);

    Function  GetStates() : TVirtualNodeStates;
    Procedure SetStates(Const AStates : TVirtualNodeStates);

    Function  GetAlign() : Byte;
    Procedure SetAlign(Const AAlign : Byte);

    Function  GetCheckState() : TCheckState;
    Procedure SetCheckState(Const ACheckState : TCheckState);

    Function  GetCheckType() : TCheckType;
    Procedure SetCheckType(Const ACheckType : TCheckType);

    Function  GetTotalCount() : Cardinal;

    Function  GetTotalHeight() : Cardinal;
    Procedure SetTotalHeight(ATotalHeight : Cardinal);

    Function  GetParent() : IVirtualNodeEx;
    Function  GetPrevSibling() : IVirtualNodeEx;
    Function  GetNextSibling() : IVirtualNodeEx;
    Function  GetFirstChild() : IVirtualNodeEx;
    Function  GetLastChild() : IVirtualNodeEx;

    Function  GetLevel() : Integer;
    Function  GetChilds() : IVirtualNodeListEx;

    Function  GetNodeData() : IVirtualNodeDataEx;
    Procedure SetNodeData(ANodeData : IVirtualNodeDataEx);

    Property Index       : Cardinal           Read GetIndex;
    Property ChildCount  : Cardinal           Read GetChildCount;
    Property NodeHeight  : Word               Read GetNodeHeight  Write SetNodeHeight;
    Property States      : TVirtualNodeStates Read GetStates      Write SetStates;
    Property Align       : Byte               Read GetAlign       Write SetAlign;
    Property CheckState  : TCheckState        Read GetCheckState  Write SetCheckState;
    Property CheckType   : TCheckType         Read GetCheckType   Write SetCheckType;
    Property TotalCount  : Cardinal           Read GetTotalCount;
    Property TotalHeight : Cardinal           Read GetTotalHeight Write SetTotalHeight;
    Property Parent      : IVirtualNodeEx     Read GetParent;
    Property PrevSibling : IVirtualNodeEx     Read GetPrevSibling;
    Property NextSibling : IVirtualNodeEx     Read GetNextSibling;
    Property FirstChild  : IVirtualNodeEx     Read GetFirstChild;
    Property LastChild   : IVirtualNodeEx     Read GetLastChild;

    Property Level       : Integer            Read GetLevel;
    Property NodeData    : IVirtualNodeDataEx Read GetNodeData    Write SetNodeData;
    Property TreeView    : TBaseVirtualTree   Read FTreeView;

  Public
    Constructor Create(ANode : PVirtualNode); ReIntroduce; Virtual;
    Destructor  Destroy(); OverRide;

  End;

  TVTColumnExClass = Class Of TVTColumnEx;

  TVTColumnEx = Class(TInterfacedObjectEx, IVTColumnEx)
  Private
    FColumnName  : String;
    FColumnType  : TVTColumnType;
    FColumnValue : Variant;

    Function AccessError(Const TypeName : String) : Exception;

  Protected
    Function  GetColumnName() : String;
    Procedure SetColumnName(Const AColumnName : String);

    Function  GetColumnType() : TVTColumnType;
    Procedure SetColumnType(Const AColumnType : TVTColumnType);

    Function  GetColumnValue() : Variant;
    Procedure SetColumnValue(Const AColumnValue : Variant); Virtual;

    Function  GetAsString() : String; Virtual;
    Procedure SetAsString(Const AString : String); Virtual;

    Function  GetAsBoolean() : Boolean; Virtual;
    Procedure SetAsBoolean(Const ABoolean : Boolean); Virtual;

    Function  GetAsDateTime() : TDateTime; Virtual;
    Procedure SetAsDateTime(Const ADateTime : TDateTime); Virtual;

    Function  GetAsFloat() : Double; Virtual;
    Procedure SetAsFloat(Const AFloat : Double); Virtual;

    Procedure Clear();

    Property ColumnName  : String        Read GetColumnName  Write SetColumnName;
    Property ColumnType  : TVTColumnType Read GetColumnType  Write SetColumnType;
    Property ColumnValue : Variant       Read GetColumnValue Write SetColumnValue;
    
  End;

  TVTStringColumnEx = Class(TVTColumnEx, IVTStringColumnEx)
  Private
    FSize : Integer;

  Protected
    Function  GetSize() : Integer;
    Procedure SetSize(Const ASize : Integer);

    Function  GetAsString() : String; OverRide;
    Procedure SetAsString(Const AString : String); OverRide;

  End;

  TVTBooleanColumnEx = Class(TVTColumnEx, IVTBooleanColumnEx)
  Private
    FDisplayAsCheckBox : Boolean;

  Protected
    Function  GetDisplayAsCheckBox() : Boolean;
    Procedure SetDisplayAsCheckBox(Const ADisplayAsCheckBox : Boolean);

  End;

  TVTDisplayFormatColumnEx = Class(TVTColumnEx, IVTDisplayFormatColumnEx)
  Private
    FDisplayFormat : String;
    FFmtSettings   : TFormatSettings;
    
  Protected
    Procedure Created(); OverRide;

    Function  GetDisplayFormat() : String;
    Procedure SetDisplayFormat(Const ADisplayFormat : String);

    Property DisplayFormat : String          Read GetDisplayFormat Write SetDisplayFormat;
    Property FmtSettings   : TFormatSettings Read FFmtSettings;
    
  End;

  TVTDateTimeColumnEx = Class(TVTDisplayFormatColumnEx, IVTDateTimeColumnEx)
  Private
    FDateFormat : TVTColumnDateFormat;

  Protected
    Procedure Created(); OverRide;

    Function  GetDateFormat() : TVTColumnDateFormat;
    Procedure SetDateFormat(Const ADateFormat : TVTColumnDateFormat);

    Function  GetAsString() : String; OverRide;
    Procedure SetAsString(Const AString : String); OverRide;

    Function  GetAsDateTime() : TDateTime; OverRide;
    Procedure SetAsDateTime(Const ADateTime : TDateTime); OverRide;

  End;

  TVTFloatColumnEx = Class(TVTDisplayFormatColumnEx, IVTFloatColumnEx)
  Private
    FCurrency  : Boolean;
    FPrecision : Integer;

  Protected
    Procedure Created(); OverRide;

    Function  GetCurrency() : Boolean;
    Procedure SetCurrency(ACurrency : Boolean);

    Function  GetPrecision() : Integer;
    Procedure SetPrecision(Const APrecision : Integer);

    Function  GetAsString() : String; OverRide;
    Procedure SetAsString(Const AString : String); OverRide;

    Function  GetAsFloat() : Double; OverRide;
    Procedure SetAsFloat(Const AFloat : Double); OverRide;

  End;

  TVTColumnExsClass = Class Of TVTColumnExs;
  TVTColumnExs = Class(TVirtualNodeDataEx, IVTColumnExs)
  Private
    FColumnList : IInterfaceListEx;

  Protected
    Procedure Created(); OverRide;

    Function  Get(Index : Integer) : IVTColumnEx; OverLoad;
    Procedure Put(Index : Integer; Const Item : IVTColumnEx); OverLoad;

    Function  GetCount() : Integer;

    Function Add(Const AItem : IVTColumnEx) : Integer; OverLoad;

    Function AddStringColumn() : IVTStringColumnEx;
    Function AddBooleanColumn() : IVTBooleanColumnEx;
    Function AddDateTimeColumn() : IVTDateTimeColumnEx;
    Function AddFloatColumn() : IVTFloatColumnEx;

    Property Items[Index : Integer] : IVTColumnEx Read Get Write Put; Default;

  Public
    Destructor Destroy(); OverRide;
    
  End;

  TVTRowExClass = Class Of TVTRowEx;
  TVTRowEx = Class(TVirtualNodeEx, IVTRowEx)
  Private
    FColumns : IVTColumnExs;

  Protected
    Function GetNodeDataClass() : TVTColumnExsClass; ReIntroduce; Virtual;
    Function GetNodeClass() : TVirtualNodeExClass; OverRide;

    Function  GetColumns() : IVTColumnExs;

  Public
    Property Columns : IVTColumnExs Read GetColumns;

    Function ColumnByName(Const AColumnName : String) : IVTColumnEx;

    Constructor Create(ANode : PVirtualNode); OverRide;
    Destructor  Destroy(); OverRide;

  End;

  TVTRowExs = Class(TVirtualNodeListEx, IVTRowExs)
  Protected
    Function  GetItemClass() : TVTRowExClass; ReIntroduce; Virtual;
    Function  Get(Index : Integer) : IVTRowEx; OverLoad;
    Procedure Put(Index : Integer; Const Item : IVTRowEx); OverLoad;

    Function Add() : IVTRowEx; ReIntroduce; OverLoad;
    Function Add(Const AItem : IVTRowEx) : Integer; ReIntroduce; OverLoad;

  End;
  
(******************************************************************************)

  THsVTInitNodeEvent = Procedure(Sender : TBaseVirtualTree; ParentNode, Node : IVirtualNodeEx;
    Var InitialStates: TVirtualNodeInitStates) Of Object;
  THsVTInitChildrenEvent = Procedure(Sender : TBaseVirtualTree; Node : IVirtualNodeEx; Var ChildCount : Cardinal) Of Object;
  THsVSTGetTextEvent = procedure(Sender : TBaseVirtualTree; Node : IVirtualNodeEx; Column : TColumnIndex;
    TextType : TVSTTextType; Var CellText : UnicodeString) Of Object;
  THsVTGetImageEvent = Procedure(Sender : TBaseVirtualTree; Node : IVirtualNodeEx; Kind : TVTImageKind; Column : TColumnIndex;
    Var Ghosted : Boolean; Var ImageIndex : TImageIndex) Of Object;
  THsVTGetImageExEvent = Procedure(Sender : TBaseVirtualTree; Node : IVirtualNodeEx; Kind : TVTImageKind; Column : TColumnIndex;
    Var Ghosted : Boolean; Var ImageIndex : TImageIndex; Var ImageList : TCustomImageList) Of Object;
  THsVSTNewTextEvent = Procedure(Sender : TBaseVirtualTree; Node : IVirtualNodeEx; Column : TColumnIndex;
    NewText : UnicodeString) Of Object;

  THsCustomVirtualStringTreeEx = Class(TCustomVirtualStringTree)
  Private
    FNodeClass  : TVirtualNodeExClass;
    FNodeList   : IInterfaceListEx;

    FPrevHitInfo : THitInfo;

    FOnInitNode     : THsVTInitNodeEvent;
    FOnInitChildren : THsVTInitChildrenEvent;
    FOnGetText      : THsVSTGetTextEvent;
    FOnGetImage     : THsVTGetImageEvent;
    FOnGetImageEx   : THsVTGetImageExEvent;
    FOnNewText      : THsVSTNewTextEvent;
    
    Function InternalGetNodeData(ANode : PVirtualNode; Var ANodeData : IVirtualNodeEx) : Boolean;
    Function InternalGetRow(ANode : PVirtualNode; Var ARow : IVTRowEx) : Boolean;

    Procedure WMLButtonDown(Var Message : TWMLButtonUp); Message WM_LBUTTONDOWN;
    Procedure WMLButtonUp(Var Message : TWMLButtonUp); Message WM_LBUTTONUP;

  Protected
    Procedure DoFreeNode(Node: PVirtualNode); OverRide;

    Procedure DoInitNode(Parent, Node : PVirtualNode; Var InitStates : TVirtualNodeInitStates); OverRide;
    Function  DoInitChildren(Node : PVirtualNode; Var ChildCount : Cardinal) : Boolean; OverRide;
    Procedure DoGetText(Var pEventArgs : TVSTGetCellTextEventArgs); OverRide;
    Function  DoGetImageIndex(Node : PVirtualNode; Kind : TVTImageKind; Column : TColumnIndex;
      Var Ghosted : Boolean; Var Index : TImageIndex) : TCustomImageList; OverRide;
    Procedure DoAfterCellPaint(Canvas : TCanvas; Node : PVirtualNode; Column : TColumnIndex; CellRect : TRect); OverRide;
    Procedure DoCanEdit(Node : PVirtualNode; Column : TColumnIndex; Var Allowed : Boolean); OverRide;
    Procedure DoNewText(Node : PVirtualNode; Column : TColumnIndex; Const Text : UnicodeString); OverRide;

    Property NodeClass         : TVirtualNodeExClass    Read FNodeClass      Write FNodeClass;
    Property OnInitNode        : THsVTInitNodeEvent     Read FOnInitNode     Write FOnInitNode;
    Property OnInitChildren    : THsVTInitChildrenEvent Read FOnInitChildren Write FOnInitChildren;
    Property OnGetText         : THsVSTGetTextEvent     Read FOnGetText      Write FOnGetText;
    Property OnGetImageIndex   : THsVTGetImageEvent     Read FOnGetImage     Write FOnGetImage;
    Property OnGetImageIndexEx : THsVTGetImageExEvent   Read FOnGetImageEx   Write FOnGetImageEx;
    Property OnNewText         : THsVSTNewTextEvent     Read FOnNewText      Write FOnNewText;
    
  Public
    Constructor Create(AOwner : TComponent); OverRide;
    Destructor  Destroy(); OverRide;

  End;

  THsVirtualStringTreeEx = Class(THsCustomVirtualStringTreeEx)
  Published
    Property AccessibleName;
    Property Action;
    Property Align;
    Property Alignment;
    Property Anchors;
    Property AnimationDuration;
    Property AutoExpandDelay;
    Property AutoScrollDelay;
    Property AutoScrollInterval;
    Property Background;
    Property BackgroundOffsetX;
    Property BackgroundOffsetY;
    Property BiDiMode;
    Property BevelEdges;
    Property BevelInner;
    Property BevelOuter;
    Property BevelKind;
    Property BevelWidth;
    Property BorderStyle;
    Property BottomSpace;
    Property ButtonFillMode;
    Property ButtonStyle;
    Property BorderWidth;
    Property ChangeDelay;
    Property CheckImageKind;
    Property ClipboardFormats;
    Property Color;
    Property Colors;
    Property Constraints;
    Property Ctl3D;
    Property CustomCheckImages;
    Property DefaultNodeHeight;
    Property DefaultPasteMode;
    Property DefaultText;
    Property DragCursor;
    Property DragHeight;
    Property DragKind;
    Property DragImageKind;
    Property DragMode;
    Property DragOperations;
    Property DragType;
    Property DragWidth;
    Property DrawSelectionMode;
    Property EditDelay;
    Property EmptyListMessage;
    Property Enabled;
    Property Font;
    Property Header;
    Property HintAnimation;
    Property HintMode;
    Property HotCursor;
    Property Images;
    Property IncrementalSearch;
    Property IncrementalSearchDirection;
    Property IncrementalSearchStart;
    Property IncrementalSearchTimeout;
    Property Indent;
    Property LineMode;
    Property LineStyle;
    Property Margin;
    Property NodeAlignment;
    Property NodeDataSize;
    Property OperationCanceled;
    Property ParentBiDiMode;
    Property ParentColor default False;
    Property ParentCtl3D;
    Property ParentFont;
    Property ParentShowHint;
    Property PopupMenu;
    Property RootNodeCount;
    Property ScrollBarOptions;
    Property SelectionBlendFactor;
    Property SelectionCurveRadius;
    Property ShowHint;
    Property StateImages;
    {$If CompilerVersion >= 24}
    Property StyleElements;
    {$IfEnd}
    Property TabOrder;
    Property TabStop default True;
    Property TextMargin;
    Property TreeOptions;
    Property Visible;
    Property WantTabs;

    Property OnAddToSelection;
    Property OnAdvancedHeaderDraw;
    Property OnAfterAutoFitColumn;
    Property OnAfterAutoFitColumns;
    Property OnAfterCellPaint;
    Property OnAfterColumnExport;
    Property OnAfterColumnWidthTracking;
    Property OnAfterGetMaxColumnWidth;
    Property OnAfterHeaderExport;
    Property OnAfterHeaderHeightTracking;
    Property OnAfterItemErase;
    Property OnAfterItemPaint;
    Property OnAfterNodeExport;
    Property OnAfterPaint;
    Property OnAfterTreeExport;
    Property OnBeforeAutoFitColumn;
    Property OnBeforeAutoFitColumns;
    Property OnBeforeCellPaint;
    Property OnBeforeColumnExport;
    Property OnBeforeColumnWidthTracking;
    Property OnBeforeDrawTreeLine;
    Property OnBeforeGetMaxColumnWidth;
    Property OnBeforeHeaderExport;
    Property OnBeforeHeaderHeightTracking;
    Property OnBeforeItemErase;
    Property OnBeforeItemPaint;
    Property OnBeforeNodeExport;
    Property OnBeforePaint;
    Property OnBeforeTreeExport;
    Property OnCanSplitterResizeColumn;
    Property OnCanSplitterResizeHeader;
    Property OnCanSplitterResizeNode;
    Property OnChange;
    Property OnChecked;
    Property OnChecking;
    Property OnClick;
    Property OnCollapsed;
    Property OnCollapsing;
    Property OnColumnClick;
    Property OnColumnDblClick;
    Property OnColumnExport;
    Property OnColumnResize;
    Property OnColumnVisibilityChanged;
    Property OnColumnWidthDblClickResize;
    Property OnColumnWidthTracking;
    Property OnCompareNodes;
    Property OnContextPopup;
    Property OnCreateDataObject;
    Property OnCreateDragManager;
    Property OnCreateEditor;
    Property OnDblClick;
    Property OnDragAllowed;
    Property OnDragOver;
    Property OnDragDrop;
    Property OnDrawHint;
    Property OnDrawText;
    Property OnEditCancelled;
    Property OnEdited;
    Property OnEditing;
    Property OnEndDock;
    Property OnEndDrag;
    Property OnEndOperation;
    Property OnEnter;
    Property OnExit;
    Property OnExpanded;
    Property OnExpanding;
    Property OnFocusChanged;
    Property OnFocusChanging;
//    Property OnFreeNode;
    Property OnGetCellText;
    Property OnGetCellIsEmpty;
    Property OnGetCursor;
    Property OnGetHeaderCursor;
    Property OnGetText;
    Property OnPaintText;
    Property OnGetHelpContext;
    Property OnGetHintKind;
    Property OnGetHintSize;
    Property OnGetImageIndex;
    Property OnGetImageIndexEx;
    Property OnGetImageText;
    Property OnGetHint;
    Property OnGetLineStyle;
    Property OnGetNodeDataSize;
    Property OnGetPopupMenu;
    Property OnGetUserClipboardFormats;
    Property OnHeaderClick;
    Property OnHeaderDblClick;
    Property OnHeaderDragged;
    Property OnHeaderDraggedOut;
    Property OnHeaderDragging;
    Property OnHeaderDraw;
    Property OnHeaderDrawQueryElements;
    Property OnHeaderHeightDblClickResize;
    Property OnHeaderHeightTracking;
    Property OnHeaderMouseDown;
    Property OnHeaderMouseMove;
    Property OnHeaderMouseUp;
    Property OnHotChange;
    Property OnIncrementalSearch;
    Property OnInitChildren;
    Property OnInitNode;
    Property OnKeyAction;
    Property OnKeyDown;
    Property OnKeyPress;
    Property OnKeyUp;
    Property OnLoadNode;
    Property OnLoadTree;
    Property OnMeasureItem;
    Property OnMeasureTextWidth;
    Property OnMeasureTextHeight;
    Property OnMouseDown;
    Property OnMouseMove;
    Property OnMouseUp;
    Property OnMouseWheel;
    Property OnMouseEnter;
    Property OnMouseLeave;
    Property OnNewText;
    Property OnNodeClick;
    Property OnNodeCopied;
    Property OnNodeCopying;
    Property OnNodeDblClick;
    Property OnNodeExport;
    Property OnNodeHeightDblClickResize;
    Property OnNodeHeightTracking;
    Property OnNodeMoved;
    Property OnNodeMoving;
    Property OnPaintBackground;
    Property OnPrepareButtonBitmaps;
    Property OnRemoveFromSelection;
    Property OnRenderOLEData;
    Property OnResetNode;
    Property OnResize;
    Property OnSaveNode;
    Property OnSaveTree;
    Property OnScroll;
    Property OnShortenString;
    Property OnShowScrollBar;
    Property OnStartDock;
    Property OnStartDrag;
    Property OnStartOperation;
    Property OnStateChange;
    Property OnStructureChange;
    Property OnUpdating;
    Property OnCanResize;
    {$If CompilerVersion >= 24}
    Property OnGesture;
    Property Touch;
    {$IfEnd}

  Public
    Property NodeClass;
      
  End;

implementation

Uses
  Variants, DBConsts;

Type
  PInterface = ^IInterface;

Function TVirtualNodeListEx.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TVirtualNodeEx;
End;

Function TVirtualNodeListEx.Get(Index: Integer) : IVirtualNodeEx;
Begin
  Result := InHerited Items[Index] As IVirtualNodeEx;
End;

Procedure TVirtualNodeListEx.Put(Index: Integer; Const Item: IVirtualNodeEx);
Begin
  InHerited Items[Index] := Item;
End;

Constructor TVirtualNodeEx.Create(ANode : PVirtualNode);
Var lNodeData : PInterface;
Begin
  InHerited Create(True);

  FNode     := ANode;
  FTreeView := TreeFromNode(ANode);

  If Assigned(FTreeView) Then
  Begin
    lNodeData := FTreeView.GetNodeData(ANode);

    If Assigned(lNodeData) And Not Assigned(lNodeData^) Then
      lNodeData^ := Self;
  End;
End;

Destructor TVirtualNodeEx.Destroy();
Begin
  FNodeData := Nil;

  InHerited Destroy();
End;

Function TVirtualNodeEx.GetNodeDataClass() : TVirtualNodeDataExClass;
Begin
  Result := TVirtualNodeDataEx;
End;

Function TVirtualNodeEx.GetNodeClass() : TVirtualNodeExClass;
Begin
  Result := TVirtualNodeEx;
End;

Function TVirtualNodeEx.GetIndex() : Cardinal;
Begin
  Result := FNode.Index;
End;

Function TVirtualNodeEx.GetChildCount() : Cardinal;
Begin
  Result := FNode.ChildCount;
End;

Function TVirtualNodeEx.GetNodeHeight() : Word;
Begin
  Result := FNode.NodeHeight;
End;

Procedure TVirtualNodeEx.SetNodeHeight(Const AHeight : Word);
Begin
  FNode.NodeHeight := AHeight;
End;

Function TVirtualNodeEx.GetStates() : TVirtualNodeStates;
Begin
  Result := FNode.States;
End;

Procedure TVirtualNodeEx.SetStates(Const AStates : TVirtualNodeStates);
Begin
  FNode.States := AStates;
End;

Function TVirtualNodeEx.GetAlign() : Byte;
Begin
  Result := FNode.Align;
End;

Procedure TVirtualNodeEx.SetAlign(Const AAlign : Byte);
Begin
  FNode.Align := AAlign;
End;

Function TVirtualNodeEx.GetCheckState() : TCheckState;
Begin
  Result := FNode.CheckState;
End;

Procedure TVirtualNodeEx.SetCheckState(Const ACheckState : TCheckState);
Begin
  FNode.CheckState := ACheckState;
End;

Function TVirtualNodeEx.GetCheckType() : TCheckType;
Begin
  Result := FNode.CheckType;
End;

Procedure TVirtualNodeEx.SetCheckType(Const ACheckType : TCheckType);
Begin
  FNode.CheckType := ACheckType;
End;

Function TVirtualNodeEx.GetTotalCount() : Cardinal;
Begin
  Result := FNode.TotalCount;
End;

Function TVirtualNodeEx.GetTotalHeight() : Cardinal;
Begin
  Result := FNode.TotalHeight;
End;

Procedure TVirtualNodeEx.SetTotalHeight(ATotalHeight : Cardinal);
Begin
  FNode.TotalHeight := ATotalHeight;
End;

Function TVirtualNodeEx.GetParent() : IVirtualNodeEx;
Begin
  Result := GetNodeClass().Create(FNode.Parent);
End;

Function TVirtualNodeEx.GetFirstChild() : IVirtualNodeEx;
Begin
  Result := GetNodeClass().Create(FNode.FirstChild);
End;

Function TVirtualNodeEx.GetLastChild() : IVirtualNodeEx;
Begin
  Result := GetNodeClass().Create(FNode.LastChild);
End;

Function TVirtualNodeEx.GetPrevSibling() : IVirtualNodeEx;
Begin
  If Assigned(FNode.PrevSibling) Then
    Result := GetNodeClass().Create(FNode.PrevSibling)
  Else
    Result := Nil;
End;

Function TVirtualNodeEx.GetNextSibling() : IVirtualNodeEx;
Begin
  If Assigned(FNode.NextSibling) Then
    Result := GetNodeClass().Create(FNode.NextSibling)
  Else
    Result := Nil;
End;

Function TVirtualNodeEx.GetLevel() : Integer;
Begin
  Result := FTreeView.GetNodeLevel(FNode);
End;

Function TVirtualNodeEx.GetChilds() : IVirtualNodeListEx;
Var lRetVal : TVirtualNodeListEx;
    lNode   : PVirtualNode;
Begin
  lRetVal := TVirtualNodeListEx.Create(True);
  lNode := FNode.FirstChild;
  While Assigned(lNode) Do
  Begin
    lRetVal.Add(GetNodeClass().Create(lNode));
    lNode := lNode.NextSibling;
  End;

  Result := lRetVal;
End;

Function TVirtualNodeEx.GetNodeData() : IVirtualNodeDataEx;
Var lData : PInterface;
    lNode : IVirtualNodeEx;
Begin
  Result := Nil;

  If Assigned(FNodeData) Then
    Result := FNodeData
  Else If Assigned(FTreeView) And Assigned(FNode) Then
  Begin
    lData := FTreeView.GetNodeData(FNode);

    If Assigned(lData) And Assigned(lData^) And
       Supports(lData^, IVirtualNodeEx, lNode) Then
    Begin
      If IsImplementorOf(lNode) Then
      Begin
        FNodeData := GetNodeDataClass().Create(True);
        Result    := FNodeData;
      End
      Else
        Result := lNode.NodeData;
    End;
  End;
End;

Procedure TVirtualNodeEx.SetNodeData(ANodeData : IVirtualNodeDataEx);
Begin
  FNodeData := ANodeData;
End;

Procedure TVTColumnEx.Clear();
Begin
  FColumnName  := '';
  FColumnType  := vtctString;
  FColumnValue := Null;
End;

Function TVTColumnEx.AccessError(Const TypeName : String) : Exception;
Const
  SColAccessError = 'Cannot access column ''%s'' as type %s';
Begin
  Result := Exception.CreateFmt(SColAccessError, [FColumnName, TypeName]);
End;

Function TVTColumnEx.GetColumnName() : String;
Begin
  Result := FColumnName;
End;

Procedure TVTColumnEx.SetColumnName(Const AColumnName : String);
Begin
  FColumnName := AColumnName;
End;

Function TVTColumnEx.GetColumnType() : TVTColumnType;
Begin
  Result := FColumnType;
End;

Procedure TVTColumnEx.SetColumnType(Const AColumnType : TVTColumnType);
Begin
  FColumnType := AColumnType;
End;

Function TVTColumnEx.GetColumnValue() : Variant;
Begin
  Result := FColumnValue;
End;

Procedure TVTColumnEx.SetColumnValue(Const AColumnValue : Variant);
Begin
  FColumnValue := AColumnValue;
End;

Function TVTColumnEx.GetAsString() : String;
Begin
  Raise AccessError('String');
End;

Procedure TVTColumnEx.SetAsString(Const AString : String);
Begin
  Raise AccessError('String');
End;

Function TVTColumnEx.GetAsBoolean() : Boolean;
Begin
  Raise AccessError('Boolean');
End;

Procedure TVTColumnEx.SetAsBoolean(Const ABoolean : Boolean);
Begin
  Raise AccessError('Boolean');
End;

Function TVTColumnEx.GetAsDateTime() : TDateTime;
Begin
  Raise AccessError('DateTime');
End;

Procedure TVTColumnEx.SetAsDateTime(Const ADateTime : TDateTime);
Begin
  Raise AccessError('DateTime');
End;

Function TVTColumnEx.GetAsFloat() : Double;
Begin
  Raise AccessError('Float');
End;

Procedure TVTColumnEx.SetAsFloat(Const AFloat : Double);
Begin
  Raise AccessError('Float');
End;

(******************************************************************************)

Function TVTStringColumnEx.GetSize() : Integer;
Begin
  Result := FSize;
End;

Procedure TVTStringColumnEx.SetSize(Const ASize : Integer);
Begin
  FSize := ASize;
End;

Function TVTStringColumnEx.GetAsString() : String;
Begin
  Result := String(ColumnValue);
End;

Procedure TVTStringColumnEx.SetAsString(Const AString : String);
Begin
  ColumnValue := VarAsType(Copy(AString, 1, FSize), varString);
End;

Function TVTBooleanColumnEx.GetDisplayAsCheckBox() : Boolean;
Begin
  Result := FDisplayAsCheckBox;
End;

Procedure TVTBooleanColumnEx.SetDisplayAsCheckBox(Const ADisplayAsCheckBox : Boolean);
Begin
  FDisplayAsCheckBox := ADisplayAsCheckBox;
End;

Type
  IVTInternalBooleanColumnEx = Interface(IVTBooleanColumnEx)
    ['{4B61686E-29A0-2112-921B-2683ADA479B3}']
    Function  GetCheckState() : TCheckState;
    Procedure SetCheckState(Const ACheckState : TCheckState);

    Property CheckState : TCheckState Read GetCheckState Write SetCheckState;

  End;

  TVTInternalBooleanColumnEx = Class(TVTBooleanColumnEx, IVTInternalBooleanColumnEx)
  Private
    FCheckState : TCheckState;

  Protected
    Procedure SetColumnValue(Const AColumnValue : Variant); OverRide;

    Function  GetCheckState() : TCheckState;
    Procedure SetCheckState(Const ACheckState : TCheckState);

    Function  GetAsString() : String; OverRide;
    Procedure SetAsString(Const AString : String); OverRide;

    Function  GetAsBoolean() : Boolean; OverRide;
    Procedure SetAsBoolean(Const ABoolean : Boolean); OverRide;

  End;

Procedure TVTInternalBooleanColumnEx.SetColumnValue(Const AColumnValue : Variant);
Begin
  InHerited SetColumnValue(AColumnValue);

  If Not VarIsNull(AColumnValue) Then
  Begin
    If AColumnValue Then
      FCheckState := csCheckedNormal
    Else
      FCheckState := csUncheckedNormal;
  End;
End;

Function TVTInternalBooleanColumnEx.GetAsString() : String;
Const
  StrValue : Array[Boolean] Of String = (
    STextFalse, STextTrue
  );
Begin
  If FCheckState In [csCheckedNormal, csUncheckedNormal] Then
    Result := StrValue[FCheckState = csCheckedNormal]
  Else
    Result := '';
End;

Procedure TVTInternalBooleanColumnEx.SetAsString(Const AString : String);
Const
  StrValue : Array[Boolean] Of String = (
    STextFalse, STextTrue
  );
  SInvalidBoolValue = '''%s'' is not a valid boolean value for column ''%s''';

Var lLen : Integer;
Begin
  lLen := Length(AString);
  If lLen = 0 Then
    SetAsBoolean(False)
  Else
  Begin
    If AnsiCompareText(AString, Copy(StrValue[False], 1, lLen)) = 0 Then
      SetAsBoolean(False)
    Else If AnsiCompareText(AString, Copy(StrValue[True], 1, lLen)) = 0 Then
      SetAsBoolean(True)
    Else
      Exception.CreateFmt(SInvalidBoolValue, [AString, ColumnName]);
  End;
End;

Function TVTInternalBooleanColumnEx.GetAsBoolean() : Boolean;
Begin
  Result := FCheckState = csCheckedNormal;
End;

Procedure TVTInternalBooleanColumnEx.SetAsBoolean(Const ABoolean : Boolean);
Begin
  SetColumnValue(ABoolean);
End;

Function TVTInternalBooleanColumnEx.GetCheckState() : TCheckState;
Begin
  Result := FCheckState;
End;

Procedure TVTInternalBooleanColumnEx.SetCheckState(Const ACheckState : TCheckState);
Begin
  FCheckState := ACheckState;

  If FCheckState = csCheckedNormal Then
    SetAsBoolean(True)
  Else If FCheckState = csUncheckedNormal Then
    SetAsBoolean(False)
  Else
    ColumnValue := Null;
End;

Procedure TVTDisplayFormatColumnEx.Created();
Begin
  InHerited Created();

  GetLocaleFormatSettings(0, FFmtSettings);
End;

Function TVTDisplayFormatColumnEx.GetDisplayFormat() : String;
Begin
  Result := FDisplayFormat;
End;

Procedure TVTDisplayFormatColumnEx.SetDisplayFormat(Const ADisplayFormat : String);
Begin
  FDisplayFormat := ADisplayFormat;
End;

Procedure TVTDateTimeColumnEx.Created();
Begin
  InHerited Created();

  FDateFormat := dfDateTime;
End;

Function TVTDateTimeColumnEx.GetDateFormat() : TVTColumnDateFormat;
Begin
  Result := FDateFormat;
End;

Procedure TVTDateTimeColumnEx.SetDateFormat(Const ADateFormat : TVTColumnDateFormat);
Begin
  FDateFormat := ADateFormat;
End;
(*
procedure TDateTimeField.GetText(var Text: string; DisplayText: Boolean);
var
  F: string;
  D: TDateTime;
begin
  if GetValue(D) then
  begin
    if DisplayText and (FDisplayFormat <> '') then
      F := FDisplayFormat
    else
      case DataType of
        ftDate: F := ShortDateFormat;
        ftTime: F := LongTimeFormat;
      end;
    DateTimeToString(Text, F, D);
  end else
    Text := '';
end;
*)
Function TVTDateTimeColumnEx.GetAsString() : String;
Var lFmt  : String;
Begin
  If VarIsType(ColumnValue, varDate) Then
  Begin
    If FDisplayFormat <> '' Then
      lFmt := DisplayFormat
    Else
      Case FDateFormat Of
        dfDate : lFmt := ShortDateFormat;
        dfTime : lFmt := LongTimeFormat;
      End;

    DateTimeToString(Result, lFmt, ColumnValue);
  End
  Else
    Result := '';
End;
(*
procedure TDateTimeField.SetAsString(const Value: string);
var
  DateTime: TDateTime;
begin
  if Value = '' then Clear else
  begin
    case DataType of
      ftDate: DateTime := StrToDate(Value);
      ftTime: DateTime := StrToTime(Value);
    else
      DateTime := StrToDateTime(Value);
    end;
    SetAsDateTime(DateTime);
  end;
end;
*)
Procedure TVTDateTimeColumnEx.SetAsString(Const AString : String);
Var lDate : TDateTime;
Begin
  If AString = '' Then
    ColumnValue := Null
  Else
  Begin
    If FDisplayFormat <> '' Then
    Begin
      FFmtSettings.ShortDateFormat := DisplayFormat;
      lDate := StrToDateTime(AString, FmtSettings);
    End
    Else
      Case FDateFormat Of
        dfDate : lDate := StrToDate(AString);
        dfTime : lDate := StrToTime(AString);
        Else
          lDate := StrToDateTime(AString);
      End;

    SetAsDateTime(lDate);
  End;
End;

Function TVTDateTimeColumnEx.GetAsDateTime() : TDateTime;
Begin
  Result := VarAsType(ColumnValue, varDate);
End;

Procedure TVTDateTimeColumnEx.SetAsDateTime(Const ADateTime : TDateTime);
Begin
  ColumnValue := ADateTime;
End;

Procedure TVTFloatColumnEx.Created();
Begin
  InHerited Created();

  FCurrency  := False;
  FPrecision := 15;
End;

Function TVTFloatColumnEx.GetCurrency() : Boolean;
Begin
  Result := FCurrency;
End;

Procedure TVTFloatColumnEx.SetCurrency(ACurrency : Boolean);
Begin
  FCurrency := ACurrency;
End;

Function TVTFloatColumnEx.GetPrecision() : Integer;
Begin
  Result := FPrecision;
End;

Procedure TVTFloatColumnEx.SetPrecision(Const APrecision : Integer);
Begin
  FPrecision := APrecision;
End;

Function TVTFloatColumnEx.GetAsString() : String;
Var Format : TFloatFormat;
    Digits : Integer;
    lFloat : Double;
Begin
  lFloat := GetAsFloat();

  If DisplayFormat = '' Then
  Begin
    If FCurrency Then
    Begin
//      If DisplayText Then
//        Format := ffCurrency
//      Else
        Format := ffFixed;

      Digits := CurrencyDecimals;
    End
    Else
    Begin
      Format := ffGeneral;
      Digits := 0;
    End;
    Result := FloatToStrF(lFloat, Format, FPrecision, Digits);
  End
  Else
    Result := FormatFloat(DisplayFormat, lFloat);
End;

Procedure TVTFloatColumnEx.SetAsString(Const AString : String);
Const
  SInvalidFloatValue = '''%s'' is not a valid floating point value for column ''%s''';
  
Var lFloat : Extended;
Begin
  If AString = '' Then
    ColumnValue := Null
  Else
  Begin
    If Not TextToFloat(PChar(AString), lFloat, fvExtended) Then
      Raise Exception.CreateFmt(SInvalidFloatValue, [AString, ColumnName]);

    SetAsFloat(lFloat);
  End;
End;

Function TVTFloatColumnEx.GetAsFloat() : Double;
Begin
  Result := VarAsType(ColumnValue, varDouble);
End;

Procedure TVTFloatColumnEx.SetAsFloat(Const AFloat : Double);
Begin
  ColumnValue := AFloat;
End;

(******************************************************************************)

Procedure TVTColumnExs.Created();
Begin
  InHerited Created();
  FColumnList := TInterfaceListEx.Create();
End;

Destructor TVTColumnExs.Destroy();
Begin
  FColumnList := Nil;
  InHerited Destroy();
End;

Function TVTColumnExs.Get(Index : Integer) : IVTColumnEx;
Begin
  Result := FColumnList[Index] As IVTColumnEx;
End;

Procedure TVTColumnExs.Put(Index : Integer; Const Item : IVTColumnEx);
Begin
  FColumnList[Index] := Item;
End;

Function TVTColumnExs.GetCount() : Integer;
Begin
  Result := FColumnList.Count;
End;

Function TVTColumnExs.Add(Const AItem : IVTColumnEx) : Integer;
Begin
  Result := FColumnList.Add(AItem);
End;

Function TVTColumnExs.AddStringColumn() : IVTStringColumnEx;
Begin
  Result := TVTStringColumnEx.Create();
  Result.ColumnType := vtctString;
  Result.Size := 20;

  Add(Result);
End;

Function TVTColumnExs.AddBooleanColumn() : IVTBooleanColumnEx;
Begin
  Result := TVTInternalBooleanColumnEx.Create();
  Result.ColumnType := vtctBoolean;

  Add(Result);
End;

Function TVTColumnExs.AddDateTimeColumn() : IVTDateTimeColumnEx;
Begin
  Result := TVTDateTimeColumnEx.Create();
  Result.ColumnType := vtctDateTime;

  Add(Result);
End;

Function TVTColumnExs.AddFloatColumn() : IVTFloatColumnEx;
Begin
  Result := TVTFloatColumnEx.Create();
  Result.ColumnType := vtctDouble;

  Add(Result);
End;

Constructor TVTRowEx.Create(ANode : PVirtualNode);
Var lData : PInterfaceEx;
    lRow  : IVTRowEx;
Begin
  InHerited Create(ANode);

  lData := TreeView.GetNodeData(ANode);
  If Assigned(lData) And Assigned(lData^) Then
  Begin
     If IsImplementorOf(lData^) Then
       FColumns := GetNodeDataClass().Create()
     Else
     Begin
       If Supports(lData^, IVTRowEx, lRow) Then
         FColumns := lRow.Columns;
     End;
  End;
End;

Function TVTRowEx.GetNodeDataClass() : TVTColumnExsClass;
Begin
  Result := TVTColumnExs;
End;

Function TVTRowEx.GetNodeClass() : TVirtualNodeExClass;
Begin
  Result := TVTRowEx;
End;

Destructor TVTRowEx.Destroy();
Begin
  FColumns := Nil;

  InHerited Destroy();
End;

Function TVTRowEx.GetColumns() : IVTColumnExs;
Begin
  Result := FColumns;
End;

Function TVTRowEx.ColumnByName(Const AColumnName : String) : IVTColumnEx;
Var X : Integer;
Begin
  Result := Nil;

  For X := 0 To FColumns.Count - 1 Do
    If SameText(FColumns[X].ColumnName, AColumnName) Then
    Begin
      Result := FColumns[X];
      Break;
    End;
End;

Function TVTRowExs.GetItemClass() : TVTRowExClass;
Begin
  Result := TVTRowEx;
End;

Function TVTRowExs.Get(Index : Integer) : IVTRowEx;
Begin
  Result := InHerited Items[Index] As IVTRowEx;
End;

Procedure TVTRowExs.Put(Index : Integer; Const Item : IVTRowEx);
Begin
  InHerited Items[Index] := Item;
End;

Function TVTRowExs.Add() : IVTRowEx;
Begin
  Result := InHerited Add() As IVTRowEx;
End;

Function TVTRowExs.Add(Const AItem : IVTRowEx) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

(******************************************************************************)

Constructor THsCustomVirtualStringTreeEx.Create(AOwner : TComponent);
Begin
  InHerited Create(AOwner);

  FNodeClass := TVirtualNodeEx;
  FNodeList  := TInterfaceListEx.Create();

//  InHerited OnGetImageIndexEx := Cliss;//DoGetImageEx;
End;

Destructor THsCustomVirtualStringTreeEx.Destroy();
Begin
  FNodeList := Nil;

  InHerited Destroy();
End;

Function THsCustomVirtualStringTreeEx.InternalGetNodeData(ANode : PVirtualNode; Var ANodeData : IVirtualNodeEx) : Boolean;
Var lData : PInterface;
Begin
  Result := False;
  ANodeData := Nil;

  If Assigned(ANode) Then
  Begin
    lData := GetNodeData(ANode);
    If Assigned(lData) Then
    Begin
      If Assigned(lData^) Then
        Result := Supports(lData^, IVirtualNodeEx, ANodeData);
    End;
  End;
End;

Function THsCustomVirtualStringTreeEx.InternalGetRow(ANode : PVirtualNode; Var ARow : IVTRowEx) : Boolean;
Var lNodeIntf : IVirtualNodeEx;
Begin
  Result := False;
  ARow   := Nil;

  If InternalGetNodeData(ANode, lNodeIntf) Then
    Result := Supports(lNodeIntf, IVTRowEx, ARow);
End;

Procedure THsCustomVirtualStringTreeEx.DoFreeNode(Node: PVirtualNode);
Var lData : IVirtualNodeEx;
Begin
  If InternalGetNodeData(Node, lData) Then
  Begin
    lData._Release();
    lData := Nil;
  End;

  InHerited DoFreeNode(Node);
End;

Procedure THsCustomVirtualStringTreeEx.WMLButtonDown(Var Message : TWMLButtonUp);
Const
  ChkStateConv : Array[csUncheckedNormal..csCheckedPressed] Of TCheckState = (
    csUncheckedPressed, csUncheckedNormal, csCheckedPressed, csCheckedNormal
  );

Var lRow     : IVTRowEx;
    lBlnCol  : IVTInternalBooleanColumnEx;
    lChkPt   : TPoint;
    lHitInfo : THitInfo;
Begin
  InHerited;

  GetHitTestInfoAt(Message.XPos, Message.YPos, False, lHitInfo);

  If (TreeOptions.MiscOptions * [toGridExtensions, toEditable] = [toGridExtensions, toEditable]) And Assigned(lHitInfo.HitNode) And
     InternalGetRow(lHitInfo.HitNode, lRow) And (lRow.Columns[lHitInfo.HitColumn].ColumnType = vtctBoolean) And
     (lHitInfo.HitColumn < lRow.Columns.Count) And Supports(lRow.Columns[lHitInfo.HitColumn], IVTInternalBooleanColumnEx, lBlnCol) And
     lBlnCol.DisplayAsCheckBox Then
     //lRow.Columns[lHitInfo.HitColumn].DisplayAsCheckBox Then
  Begin
    With GetDisplayRect(lHitInfo.HitNode, lHitInfo.HitColumn, False) Do
    Begin
      lChkPt.X := Left + (Right - Left - CheckImages.Width) Div 2;
      lChkPt.Y := Top + (Bottom - Top - CheckImages.Height) Div 2;
    End;

    If (lHitInfo.HitPoint.X >= lChkPt.X) And (lHitInfo.HitPoint.X <= lChkPt.X + CheckImages.Width) And
       (lHitInfo.HitPoint.Y >= lChkPt.Y) And (lHitInfo.HitPoint.Y <= lChkPt.Y + CheckImages.Height) Then
    Begin
      FPrevHitInfo := lHitInfo;
      lBlnCol.CheckState := ChkStateConv[lBlnCol.CheckState];
      InvalidateNode(lHitInfo.HitNode);
    End;
  End;
End;

Procedure THsCustomVirtualStringTreeEx.WMLButtonUp(Var Message : TWMLButtonUp);
Const
  ChkStateCancelConv : Array[csUncheckedNormal..csCheckedPressed] Of TCheckState = (
    csUncheckedPressed, csUncheckedNormal, csCheckedPressed, csCheckedNormal
  );
  ChkStateApplyConv :  Array[csUncheckedNormal..csCheckedPressed] Of TCheckState = (
    csUncheckedNormal, csCheckedNormal, csCheckedNormal, csUncheckedNormal
  );
Var lRow : IVTRowEx;
    lChkPt : TPoint;
    lHitInfo : THitInfo;
    lBlnCol : IVTInternalBooleanColumnEx;
Begin
  GetHitTestInfoAt(Message.XPos, Message.YPos, False, lHitInfo);
  If (toGridExtensions In TreeOptions.MiscOptions) And
     Assigned(lHitInfo.HitNode) Then
  Begin
    If InternalGetRow(lHitInfo.HitNode, lRow) And (lHitInfo.HitColumn < lRow.Columns.Count) Then
    Begin
      If (lHitInfo.HitNode = FPrevHitInfo.HitNode) And
         (lHitInfo.HitColumn = FPrevHitInfo.HitColumn) Then
      Begin
        With GetDisplayRect(lHitInfo.HitNode, lHitInfo.HitColumn, False) Do
        Begin
          lChkPt.X := Left + (Right - Left - CheckImages.Width) Div 2;
          lChkPt.Y := Top + (Bottom - Top - CheckImages.Height) Div 2;
        End;

        If (lHitInfo.HitPoint.X >= lChkPt.X) And (lHitInfo.HitPoint.X <= lChkPt.X + CheckImages.Width) And
           (lHitInfo.HitPoint.Y >= lChkPt.Y) And (lHitInfo.HitPoint.Y <= lChkPt.Y + CheckImages.Height) And
           Supports(lRow.Columns[lHitInfo.HitColumn], IVTInternalBooleanColumnEx, lBlnCol) Then
          lBlnCol.CheckState := ChkStateApplyConv[lBlnCol.CheckState]
        Else
          lBlnCol.CheckState := ChkStateCancelConv[lBlnCol.CheckState];

        InvalidateNode(lHitInfo.HitNode);
      End
      Else If InternalGetRow(FPrevHitInfo.HitNode, lRow) And
              Supports(lRow.Columns[FPrevHitInfo.HitColumn], IVTInternalBooleanColumnEx, lBlnCol) Then
      Begin
        lBlnCol.CheckState := ChkStateCancelConv[lBlnCol.CheckState];
        InvalidateNode(FPrevHitInfo.HitNode);
      End;
    End;

    FillChar(FPrevHitInfo, SizeOf(FPrevHitInfo), #0);
  End;

  InHerited;
End;

Procedure THsCustomVirtualStringTreeEx.DoInitNode(Parent, Node : PVirtualNode; Var InitStates : TVirtualNodeInitStates);
Var lData       : PInterface;
    lNodeIntf   : IVirtualNodeEx;
    lParentIntf : IVirtualNodeEx;
Begin
  lData := GetNodeData(Node);
  If Assigned(lData) Then
  Begin
    If Not Assigned(lData^) Then
      lNodeIntf := NodeClass.Create(Node)
    Else
      Supports(lData^, IVirtualNodeEx, lNodeIntf);
  End;

  If Assigned(FOnInitNode) Then
  Begin
    lParentIntf := Nil;

    If Assigned(Parent) Then
      InternalGetNodeData(Parent, lParentIntf);

    FOnInitNode(Self, lParentIntf, lNodeIntf, InitStates);
  End;
End;

Function THsCustomVirtualStringTreeEx.DoInitChildren(Node : PVirtualNode; Var ChildCount : Cardinal) : Boolean;
Var lData : IVirtualNodeEx;
Begin
  If Assigned(FOnInitChildren) And
     InternalGetNodeData(Node, lData) Then
  Begin
    FOnInitChildren(Self, lData, ChildCount);
    Result := True;
  End
  Else
    Result := False;
End;

Procedure THsCustomVirtualStringTreeEx.DoGetText(Var pEventArgs : TVSTGetCellTextEventArgs);
Var lData : IVirtualNodeEx;
Begin
  If Assigned(FOnGetText) And
     InternalGetNodeData(pEventArgs.Node, lData) Then
  Begin
    FOnGetText(Self, lData, pEventArgs.Column, ttNormal, pEventArgs.CellText);
    FOnGetText(Self, lData, pEventArgs.Column, ttStatic, pEventArgs.StaticText);
  End;
End;

Function THsCustomVirtualStringTreeEx.DoGetImageIndex(Node : PVirtualNode; Kind : TVTImageKind; Column : TColumnIndex;
  Var Ghosted : Boolean; Var Index : TImageIndex) : TCustomImageList;
Const
  cTVTImageKind2String : Array [TVTImageKind] Of String = ('ikNormal', 'ikSelected', 'ikState', 'ikOverlay');
Var lData : IVirtualNodeEx;
Begin
  If (Assigned(FOnGetImageEx) Or Assigned(FOnGetImage)) And
     InternalGetNodeData(Node, lData) Then
  Begin
    If Assigned(FOnGetImageEx) Then
    Begin
      If Kind = ikState Then
        Result := Self.StateImages
      Else
        Result := Self.Images;
      
      FOnGetImageEx(Self, lData, Kind, Column, Ghosted, Index, Result);
    End
    Else
    Begin
      If Assigned(FOnGetImage) Then
      Begin
        FOnGetImage(Self, lData, Kind, Column, Ghosted, Index);
        If Kind = ikState Then
          Result := Self.StateImages
        Else
          Result := Self.Images;
      End
      Else
        Result := Nil;
    End;
    Assert((Index < 0) Or Assigned(Result), 'An image index was supplied for TVTImageKind.' + cTVTImageKind2String[Kind] + ' but no image list was supplied.');
  End;
End;

Procedure THsCustomVirtualStringTreeEx.DoAfterCellPaint(Canvas : TCanvas; Node : PVirtualNode; Column : TColumnIndex; CellRect : TRect);
Var lRow     : IVTRowEx;
    lImgInfo : TVTImageInfo;
    lBlnCol  : IVTInternalBooleanColumnEx;
Begin
  If (toGridExtensions In TreeOptions.MiscOptions) And InternalGetRow(Node, lRow) And
     (Column < lRow.Columns.Count) And Supports(lRow.Columns[Column], IVTInternalBooleanColumnEx, lBlnCol) And
     lBlnCol.DisplayAsCheckBox Then
  Begin
    lImgInfo.Index   := GetCheckImage(Nil, ctCheckBox, lBlnCol.CheckState);
    lImgInfo.XPos    := CellRect.Left + (CellRect.Right - CellRect.Left - CheckImages.Width) Div 2;
    lImgInfo.YPos    := (DefaultNodeHeight - CheckImages.Height) Div 2;
    lImgInfo.Ghosted := False;
    lImgInfo.Images  := CheckImages;

    PaintCheckImage(Canvas, lImgInfo, False);
  End;

  InHerited DoAfterCellPaint(Canvas, Node, Column, CellRect);
End;

Procedure THsCustomVirtualStringTreeEx.DoCanEdit(Node : PVirtualNode; Column : TColumnIndex; Var Allowed : Boolean);
Var lRow : IVTRowEx;
    lBln : IVTInternalBooleanColumnEx;
Begin
  If (TreeOptions.MiscOptions * [toGridExtensions, toEditable] = [toGridExtensions, toEditable]) And
     InternalGetRow(Node, lRow) And (Column < lRow.Columns.Count) And
     Supports(lRow.Columns[Column], IVTInternalBooleanColumnEx, lBln) And lBln.DisplayAsCheckBox Then
    Allowed := False
  Else
    InHerited DoCanEdit(Node, Column, Allowed);
End;

Procedure THsCustomVirtualStringTreeEx.DoNewText(Node : PVirtualNode; Column : TColumnIndex; Const Text : UnicodeString);
Var lData : IVirtualNodeEx;
Begin
  If Assigned(FOnNewText) And
     InternalGetNodeData(Node, lData) Then
    FOnNewText(Self, lData, Column, Text);

  // The width might have changed, so update the scrollbar.
  If UpdateCount = 0 Then
    UpdateHorizontalScrollBar(True);
End;

end.
