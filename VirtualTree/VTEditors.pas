Unit VTEditors;

Interface

{$Define TntSupport}
{$If CompilerVersion > 19}
  {$Undef TntSupport}
{$EndIf}
{$Define DELPHI6_LVL}

Uses Windows, Messages, Mask, StdCtrls, SysUtils,
  Controls, Classes, ImgList, Graphics, ComCtrls,
  Forms, Buttons, Math
  {$IfDef TntSupport}, TntStdCtrls {$EndIf};

Const
  DD_DROPDOWNBUTTONWIDTH = 17;
  DD_DROPDOWNBUTTONHEIGHT = 17;
  DD_MINHEIGHT = 50;
  DD_MINWIDTH  = 80;

  ErrText = 'Error';

  Ctrl_Codes = [vk_back, vk_tab, vk_return];
  Numeric_Codes = [ord('0')..ord('9'), ord('-')];
  Money_Codes = Numeric_Codes;
  Float_Codes = Numeric_Codes + [ord(','), ord('.')];
  Range_Codes = Numeric_Codes + [ord(','), ord(';')];
  Hex_Codes  = Numeric_Codes + [ord('A')..ord('F'), ord('a')..ord('f')];
  Bin_Codes  = ['0', '1'];
  AlphaNum_Codes = [ord('0')..ord('9')] + [ord('a')..ord('z'), ord('A')..ord('Z')];

Type
  TGradientDirection = (gdHorizontal, gdVertical);
  TGradientPart = (gpFull, gpLeft, gpRight, gpMiddle);

  TDropDownStyle = (dsDropDown, dsDropDownList);
  TDropPosition = (dpAuto, dpDown, dpUp);
  TDropDownEditType = (etString, etNumeric, etFloat, etUppercase, etMixedCase, etLowerCase,
    etPassword, etMoney, etRange, etHex, etAlphaNumeric, etValidChars);
  TLabelPosition = (lpLeftTop, lpLeftCenter, lpLeftBottom, lpTopLeft, lpBottomLeft,
    lpLeftTopLeft, lpLeftCenterLeft, lpLeftBottomLeft, lpTopCenter, lpBottomCenter,
    lpRightTop, lpRightCenter, lpRighBottom, lpTopRight, lpBottomRight);
  TButtonStyle = (bsButton, bsDropDown);

  TDropDown = Procedure(Sender: TObject; Var acceptdrop: Boolean) Of Object;
  TDropUp = Procedure(Sender: TObject; Cancelled: Boolean) Of Object;
  TClipboardEvent = Procedure(Sender: TObject; value: String; Var allow: Boolean) Of Object;
  TGetDropDownPosEvent = Procedure(Sender: TObject; Var Pos: TPoint) Of Object;

(******************************************************************************)

  THsVTCustomDropDown = Class;

{$Region ' DropDownForm '}
  THsVTDropDownForm = Class(TForm)
  Strict Private
    FDeActivate         : DWORD;
    FShadow             : Boolean;
    FHsVTDropDown       : THsVTCustomDropDown;
    FScrollBox          : TScrollBox;
    FSizeable           : Boolean;
    FCancelOnDeActivate : Boolean;
    FOnSizing           : TNotifyEvent;
    FBlockActivate      : Boolean;

    Procedure WMSize(Var Message: TWMSize); Message WM_SIZE;
    Procedure WMSizing(Var Message: TWMSize); Message WM_SIZING;
    Procedure WMClose(Var Msg: TMessage); Message WM_CLOSE;
    Procedure WMActivate(Var Message: TWMActivate); Message WM_ACTIVATE;
    Procedure WMNCHitTest(Var Message: TWMNCHitTest); Message WM_NCHITTEST;
    Procedure WMGetDlgCode(Var Message: TMessage); Message WM_GETDLGCODE;

    Function GetParentWnd() : HWnd;
    Procedure SetAdvDropDown(Const Value: THsVTCustomDropDown);

  Protected
    Procedure CreateParams(Var Params: TCreateParams); OverRide;
    Procedure Paint(); OverRide;
    Procedure DrawBackGround(aCanvas: TCanvas);
    Function GetClientRect: TRect; OverRide;
    Procedure AdjustClientRect(Var Rect: TRect); OverRide;
    Function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; OverRide;
    Function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; OverRide;

  Public
    Property BlockActivate  : Boolean    Read FBlockActivate Write FBlockActivate;
    Property DeActivateTime : DWORD      Read FDeActivate;
    Property ScrollBox      : TScrollBox Read FScrollBox;
    Property Sizeable       : Boolean    Read FSizeable      Write FSizeable;

    Property Shadow             : Boolean             Read FShadow             Write FShadow;
    Property CancelOnDeActivate : Boolean             Read FCancelOnDeActivate Write FCancelOnDeActivate Default True;
    Property HsVTDropDown       : THsVTCustomDropDown Read FHsVTDropDown       Write SetAdvDropDown;
    Property OnSizing           : TNotifyEvent        Read FOnSizing           Write FOnSizing;

    Procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); OverRide;
    Procedure UpdateSize(); Virtual;

    Constructor Create(AOwner: TComponent); OverRide;
    Constructor CreateNew(AOwner: TComponent; Dummy: Integer = 0); OverRide;

  End;
{$EndRegion ' DropDownForm '}

{$Region ' DropDownButton '}
  THsVTDropDownEditButton = Class(TWinControl)
  Strict Private Type
    THsVTDropDownSpeedButton = Class Sealed(TSpeedButton)
    Strict Private
      FEtched      : Boolean;
      FFocused     : Boolean;
      FHot         : Boolean;
      FUp          : Boolean;
      FButtonStyle : TButtonStyle;

      Procedure CMMouseLeave(Var Message: TMessage); Message CM_MOUSELEAVE;
      Procedure CMMouseEnter(Var Message: TMessage); Message CM_MOUSEENTER;

      Procedure SetEtched(Const Value: Boolean);
      Procedure SetFocused(Const Value: Boolean);
      Procedure SetButtonStyle(Const Value: TButtonStyle);

      Procedure PaintDropDown();
      Procedure PaintButton();

    Protected
      Procedure Paint(); OverRide; Final;

    Public
      Constructor Create(AOwner: TComponent); OverRide; Final;

    Published
      Property ButtonStyle : TButtonStyle Read FButtonStyle Write SetButtonStyle;
      Property Etched      : Boolean      Read FEtched      Write SetEtched;
      Property Focused     : Boolean      Read FFocused     Write SetFocused;

    End;

  Strict Private
    FButton              : THsVTDropDownSpeedButton;
    FFocusControl        : TWinControl;
    FOnClick             : TNotifyEvent;

    FButtonWidth         : Integer;
    FButtonColorDown     : TColor;
    FButtonBorderColor   : TColor;
    FButtonTextColor     : TColor;
    FButtonTextColorHot  : TColor;
    FButtonColor         : TColor;
    FButtonColorHot      : TColor;
    FButtonTextColorDown : TColor;

    Procedure CMEnabledChanged(Var Msg: TMessage); Message CM_ENABLEDCHANGED;
    Function  CreateButton() : THsVTDropDownSpeedButton;

    Function  GetGlyph() : TBitmap;
    Procedure SetGlyph(Value: TBitmap);

    Function  GetNumGlyphs() : TNumGlyphs;
    Procedure SetNumGlyphs(Value: TNumGlyphs);

    Procedure SetCaption(value:String);
    Function  GetCaption() : String;

    Procedure BtnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    Procedure AdjustWinSize (Var W: Integer; Var H: Integer);
    Procedure WMSize(Var Message: TWMSize);  Message WM_SIZE;

  Protected
    Procedure Loaded(); OverRide;
    Procedure Notification(AComponent: TComponent; Operation: TOperation); OverRide;

    Property BWidth : Integer Read FButtonWidth Write FButtonWidth;
    Property Button : THsVTDropDownSpeedButton Read FButton;
    
  Published
    Property Glyph         : TBitmap     Read GetGlyph      Write SetGlyph;
    Property ButtonCaption : String      Read GetCaption    Write SetCaption;
    Property NumGlyphs     : TNumGlyphs  Read GetNumGlyphs  Write SetNumGlyphs Default 1;
    Property FocusControl  : TWinControl Read FFocusControl Write FFocusControl;

    Property Align;
    Property Ctl3D;
    Property DragCursor;
    Property DragMode;
    Property Enabled;
    Property ParentCtl3D;
    Property ParentShowHint;
    Property PopupMenu;
    Property ShowHint;
    Property TabOrder;
    Property TabStop;
    Property Visible;
    Property OnDragDrop;
    Property OnDragOver;
    Property OnEndDrag;
    Property OnEnter;
    Property OnExit;
    {$IFDEF WIN32}
    Property OnStartDrag;
    {$ENDIF}
    Property OnClick: TNotifyEvent Read FOnClick Write FOnClick;

  Public
    Property ButtonColor         : TColor Read FButtonColor         Write FButtonColor Default clNone;
    Property ButtonColorHot      : TColor Read FButtonColorHot      Write FButtonColorHot Default clNone;
    Property ButtonColorDown     : TColor Read FButtonColorDown     Write FButtonColorDown Default clNone;
    Property ButtonTextColor     : TColor Read FButtonTextColor     Write FButtonTextColor Default clNone;
    Property ButtonTextColorHot  : TColor Read FButtonTextColorHot  Write FButtonTextColorHot Default clNone;
    Property ButtonTextColorDown : TColor Read FButtonTextColorDown Write FButtonTextColorDown Default clNone;
    Property ButtonBorderColor   : TColor Read FButtonBorderColor   Write FButtonBorderColor Default clNone;

    Procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); OverRide;

    Constructor Create(AOwner: TComponent); OverRide;
    
  End;
{$EndRegion ' DropDownButton '}

{$IfDef TntSupport}
  THsVTCustomEdit = Class(TTntCustomEdit)
{$Else}
  THsVTCustomEdit = Class(TCustomMaskEdit)
{$EndIf}
  Strict Private
    FAlignment                   : TAlignment;
    FLabel                       : TLabel;
    FParentFnt                   : Boolean;
    FEditorEnabled               : Boolean;
    FFlat                        : Boolean;
    FImages                      : TCustomImageList;
    FMouseInControl              : Boolean;
    FEtched                      : Boolean;
    FFocusControl                : TWinControl;
    FEditType                    : TDropDownEditType;
    FLengthLimit                 : Smallint;
    FPrecision                   : Smallint;
    FPrefix                      : String;
    FSuffix                      : String;
    FOldString                   : String;
    FSigned                      : Boolean;
    FReturnIsTab                 : Boolean;
    FBlockChange                 : Boolean;
    FAllowNumericNullValue       : Boolean;
    FDefaultHandling             : Boolean;
    FCanUndo                     : Boolean;
    FExcelStyleDecimalSeparator  : Boolean;
    FValidChars                  : String;
    FBlockCopy                   : Boolean;
    FOnClipboardCopy             : TClipboardEvent;
    FOnClipboardPaste            : TClipboardEvent;
    FOnClipboardCut              : TClipboardEvent;
    FButtonDown                  : Boolean;
    FAutoThousandSeparator       : Boolean;
    FIsModified                  : Boolean;
    FEditRect                    : TRect;
    FFocusDraw                   : Boolean;
    FForceShadow                 : Boolean;
    FLabelMargin                 : Integer;
    FLabelPosition               : TLabelPosition;
    FLabelAlwaysEnabled          : Boolean;
    FLabelTransparent            : Boolean;
    FLabelFont                   : TFont;
    FOnLabelDblClick             : TNotifyEvent;
    FOnLabelClick                : TNotifyEvent;
    FBorderColor                 : TColor;
    FFocusBorderColor            : TColor;
    FDisabledBorder              : Boolean;

    FRequired      : Boolean;
    FRequiredColor : TColor;

    Procedure WMChar(Var Msg: TWMKey); Message WM_CHAR;
    Procedure CNCommand(Var Message: TWMCommand); Message CN_COMMAND;
    Procedure WMSize(Var Message: TWMSize); Message WM_SIZE;
    Procedure WMKeyDown(Var Msg: TWMKeyDown); Message WM_KEYDOWN;
    Procedure WMGetDlgCode(Var Message: TWMGetDlgCode); Message WM_GETDLGCODE;
    Procedure WMPaste(Var Message: TWMPaste); Message WM_PASTE;
    Procedure WMCut(Var Message: TWMCut); Message WM_CUT;
    Procedure WMCopy(Var Message: TWMCopy); Message WM_COPY;
    Procedure CMVisibleChanged(Var Message: TMessage); Message CM_VISIBLECHANGED;
    Procedure CMEnter(Var Message: TCMGotFocus); Message CM_ENTER;
    Procedure CMExit(Var Message: TCMExit);   Message CM_EXIT;
    Procedure CMMouseEnter(Var Message: TMessage); Message CM_MOUSEENTER;
    Procedure CMMouseLeave(Var Message: TMessage); Message CM_MOUSELEAVE;
    Procedure CMFontChanged(Var Message: TMessage); Message CM_FONTCHANGED;
    Procedure CMParentFontChanged(Var Message: TMessage); Message CM_PARENTFONTCHANGED;
    Procedure WMSetFocus(Var Message: TWMSetFocus); Message WM_SETFOCUS;
    Procedure WMKillFocus(Var Msg: TWMKillFocus); Message WM_KILLFOCUS;
    Procedure WMLButtonUp(Var Msg: TWMMouse); Message WM_LBUTTONUP;
    Procedure WMLButtonDown(Var Msg: TWMMouse); Message WM_LBUTTONDOWN;
    Procedure CMWantSpecialKey(Var Msg: TCMWantSpecialKey); Message CM_WANTSPECIALKEY;
    Procedure WMPaint(Var Message: TWMPaint); Message WM_PAINT;
    Procedure WMNCPaint(Var Message: TMessage); Message WM_NCPAINT;
    Procedure WMLButtonDblClk(Var Message: TWMLButtonDblClk); Message WM_LBUTTONDBLCLK;

    Procedure SetEditorEnabled(Const Value: Boolean);
    Procedure SetImages(Const Value: TCustomImageList);
    Function Is3DBorderControl: Boolean;
//    Procedure SetSelectionColor(Const Value: TColor);
//    Procedure SetSelectionColorTo(Const Value: TColor);
    Procedure SetEditType(Const Value: TDropDownEditType);
    Function GetText: String;
    Procedure SetPrefix(Const Value: String);
    Procedure SetSuffix(Const Value: String);
    Procedure SetPrecision(Const Value: Smallint);
    Function FixedLength(s: String): Integer;
    Function AllowMin(ch: Char): Boolean;
    Function DecimalPos: Integer;
    Procedure SetFloat(Const Value: Double);
    Procedure SetInt(Const Value: Integer);
    Procedure AutoSeparators;
    Function GetModified: Boolean;
    Procedure SetModified(Const Value: Boolean);
    Procedure SetCanUndo(Const Value: Boolean);
    Function GetFloat() : Double;
    Function GetInt: Integer;
    Function EStrToFloat(s: String): Extended;
    Function CharFromPos(pt: TPoint): Integer;
    Procedure UpdateLookup;
    Procedure SetAutoThousandSeparator(Const Value: Boolean);
    Function GetLabelCaption: String;
    Procedure SetLabelAlwaysEnabled(Const Value: Boolean);
    Procedure SetLabelCaption(Const Value: String);
    Procedure SetLabelFont(Const Value: TFont);
    Procedure SetLabelMargin(Const Value: Integer);
    Procedure SetLabelPosition(Const Value: TLabelPosition);
    Procedure SetLabelTransparent(Const Value: Boolean);
    Procedure LabelFontChange(Sender: TObject);
    Procedure SetFocusBorderColor(Const Value: TColor);
    Procedure SetDisabledBorder(Const Value: Boolean);

  Protected
    FOldText : String;

    Procedure CreateWnd(); OverRide;
    Procedure DestroyWnd(); OverRide;
    Procedure CreateParams(Var Params: TCreateParams); OverRide;
    Procedure SetParent(AParent: TWinControl); OverRide;
    Procedure Loaded(); OverRide;
    Procedure KeyPress(Var Key: Char); OverRide;
    Procedure Notification(AComponent: TComponent; Operation: TOperation); OverRide;
    Procedure DoEnter; OverRide;
    Function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; OverRide;
    Function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; OverRide;
    Function PosFromChar(uChar: Word): TPoint;
    Function CreateLabel: TLabel;
    Procedure UpdateLabel();
    Procedure LabelClick(Sender: TObject); Virtual;
    Procedure LabelDblClick(Sender: TObject); Virtual;

    Procedure HandleMouseWheelDown(); Virtual;
    Procedure HandleMouseWheelUp(); Virtual;

    Function GetMinHeight() : Integer;
    Function GetEditRect() : TRect;
    Procedure SetEditRect(); Virtual;
    Procedure ResizeControl(); Virtual;
    Procedure SetTextDirect(s:String);
    Procedure SetText(Value: String); Virtual;

    Procedure SetFlat(Const Value: Boolean); Virtual;
    Procedure SetEtched(Const Value : Boolean); Virtual;
    Procedure SetAlignment(Const Value : TAlignment); Virtual;
    Procedure SetBorderColor(Const Value: TColor); Virtual;
    Procedure SetRequired(Const Value : Boolean); Virtual;
    Procedure SetRequiredColor(Const Value : TColor); Virtual;

    Procedure DrawControlBorder(DC:HDC);
    Procedure DrawBorders(); Virtual;
    Function  GetBackGroundRect() : TRect; Virtual;
    Procedure DrawBackGround(); Virtual;

    Property Alignment                   : TAlignment               Read FAlignment                   Write SetAlignment Default taLeftJustify;
    Property BorderColor                 : TColor                   Read FBorderColor                 Write SetBorderColor Default clNone;
    Property DisabledBorder              : Boolean                  Read FDisabledBorder              Write SetDisabledBorder Default True;
    Property FocusBorderColor            : TColor                   Read FFocusBorderColor            Write SetFocusBorderColor Default clNone;
    Property FocusControl                : TWinControl              Read FFocusControl                Write FFocusControl;
    Property FocusDraw                   : Boolean                  Read FFocusDraw                   Write FFocusDraw Default True;
    Property ForceShadow                 : Boolean                  Read FForceShadow                 Write FForceShadow Default False;

    Property EditType                    : TDropDownEditType        Read FEditType                    Write SetEditType Default etString;
    Property ReturnIsTab                 : Boolean                  Read fReturnIsTab                 Write FReturnIsTab Default False;
    Property LengthLimit                 : Smallint                 Read fLengthLimit                 Write FLengthLimit Default 0;
    Property Precision                   : Smallint                 Read FPrecision                   Write SetPrecision;
    Property Prefix                      : String                   Read FPrefix                      Write SetPrefix;
    Property Suffix                      : String                   Read FSuffix                      Write SetSuffix;
    Property DefaultHandling             : Boolean                  Read FDefaultHandling             Write FDefaultHandling;
    Property CanUndo                     : Boolean                  Read FCanUndo                     Write SetCanUndo Default True;
    Property ExcelStyleDecimalSeparator  : Boolean                  Read FExcelStyleDecimalSeparator  Write FExcelStyleDecimalSeparator Default False;
    Property ValidChars                  : String                   Read FValidChars                  Write FValidChars;
    Property FloatValue                  : Double                   Read GetFloat                     Write SetFloat;
    Property IntValue                    : Integer                  Read GetInt                       Write SetInt;
    Property Modified                    : Boolean                  Read GetModified                  Write SetModified;
    Property Signed                      : Boolean                  Read FSigned                      Write FSigned Default False;
    Property AutoThousandSeparator       : Boolean                  Read FAutoThousandSeparator       Write SetAutoThousandSeparator Default True;

    Property Flat                        : Boolean                  Read FFlat                        Write SetFlat Default False;
    Property EditorEnabled               : Boolean                  Read FEditorEnabled               Write SetEditorEnabled Default True;
    Property Etched                      : Boolean                  Read FEtched                      Write SetEtched;

    Property LabelCaption                : String                   Read GetLabelCaption              Write SetLabelCaption;
    Property LabelPosition               : TLabelPosition           Read FLabelPosition               Write SetLabelPosition Default lpLeftTop;
    Property LabelMargin                 : Integer                  Read FLabelMargin                 Write SetLabelMargin Default 4;
    Property LabelTransparent            : Boolean                  Read FLabelTransparent            Write SetLabelTransparent Default False;
    Property LabelAlwaysEnabled          : Boolean                  Read FLabelAlwaysEnabled          Write SetLabelAlwaysEnabled Default False;
    Property LabelFont                   : TFont                    Read FLabelFont                   Write SetLabelFont;

    Property Images : TCustomImageList Read FImages Write SetImages;
    Property Text   : String           Read GetText Write SetText;

    Property Required      : Boolean Read FRequired      Write SetRequired;
    Property RequiredColor : TColor  Read FRequiredColor Write SetRequiredColor;

    Property OnClipboardCopy             : TClipboardEvent          Read FOnClipboardCopy             Write FOnClipboardCopy;
    Property OnClipboardCut              : TClipboardEvent          Read FOnClipboardCut              Write FOnClipboardCut;
    Property OnClipboardPaste            : TClipboardEvent          Read FOnClipboardPaste            Write FOnClipboardPaste;
    Property OnLabelClick                : TNotifyEvent             Read FOnLabelClick                Write FOnLabelClick;
    Property OnLabelDblClick             : TNotifyEvent             Read FOnLabelDblClick             Write FOnLabelDblClick;

    Property EditRect       : TRect   Read FEditRect Write FEditRect;
    Property MouseInControl : Boolean Read FMouseInControl;

  Public
    Procedure Assign(Source: TPersistent); OverRide;
    Procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); OverRide;
    Procedure SelectAll();
    Procedure SelectBeforeDecimal;
    Procedure SelectAfterDecimal;

    Constructor Create(AOwner: TComponent); OverRide;
    Destructor Destroy(); OverRide;

  End;

  THsVTEdit = Class(THsVTCustomEdit)
  Published
    Property Alignment;
    Property BorderColor;
    Property DisabledBorder;
    Property FocusBorderColor;
    Property FocusControl;
    Property FocusDraw;
    Property ForceShadow;

    Property EditType;
    Property ReturnIsTab;
    Property LengthLimit;
    Property Precision;
    Property Prefix;
    Property Suffix;
    Property DefaultHandling;
    Property CanUndo;
    Property ExcelStyleDecimalSeparator;
    Property ValidChars;
    Property FloatValue;
    Property IntValue;
    Property Modified;
    Property Signed;
    Property AutoThousandSeparator;

    Property Flat;

    Property LabelCaption;
    Property LabelPosition;
    Property LabelMargin;
    Property LabelTransparent;
    Property LabelAlwaysEnabled;
    Property LabelFont;
    Property Text;

    Property OnClipboardCopy;
    Property OnClipboardCut;
    Property OnClipboardPaste;
    Property OnLabelClick;
    Property OnLabelDblClick;

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

  End;

  THsVTCustomButtonEdit = Class(THsVTCustomEdit)
  Strict Private
    FButton      : THsVTDropDownEditButton;
    FButtonWidth : Integer;
    FButtonHint  : String;

    FOnButtonClick : TNotifyEvent;

    Procedure CMEnabledChanged(Var Msg: TMessage); Message CM_ENABLEDCHANGED;

  Protected
    Procedure DrawButtonBorder();
    Procedure DrawBorders(); OverRide;
    Function  GetBackGroundRect() : TRect; OverRide;

    Procedure WndProc(Var Message: TMessage); OverRide;

    Procedure CreateDropDownButton(); Virtual;

    Procedure Loaded(); OverRide;
    Procedure ResizeControl(); OverRide;
    Procedure SetEditRect(); OverRide;

    Function  GetButtonGlyph() : TBitmap; Virtual;
    Procedure SetButtonGlyph(Const Value: TBitmap); Virtual;

    Procedure SetButtonHint(Const Value: String); Virtual;

    Function  GetButtonWidth() : Integer; Virtual;
    Procedure SetButtonWidth(Const Value: Integer); Virtual;

    Function  GetButtonCaption() : String; Virtual;
    Procedure SetButtonCaption(Const value: String); Virtual;

    Procedure DoOnButtonClick(Sender: TObject);
    
    Procedure SetFlat(Const Value: Boolean); OverRide;
    Procedure SetEtched(Const Value: Boolean); OverRide;
    Procedure SetBorderColor(Const Value: TColor); OverRide;

    Property ButtonWidth   : Integer Read GetButtonWidth   Write SetButtonWidth Default 17;
    Property ButtonHint    : String  Read FButtonHint      Write SetButtonHint;
    Property ButtonGlyph   : TBitmap Read GetButtonGlyph   Write SetButtonGlyph;
    Property ButtonCaption : String  Read GetButtonCaption Write SetButtonCaption;

    Property OnButtonClick : TNotifyEvent Read FOnButtonClick Write FOnButtonClick;

    Property Button : THsVTDropDownEditButton Read FButton;

  Public
    Procedure Assign(Source: TPersistent); OverRide;

    Constructor Create(AOwner: TComponent); OverRide;
    Destructor Destroy(); OverRide;

  End;

  THsVTButtonEdit = Class(THsVTCustomButtonEdit)
  Published
    Property Alignment;
    Property BorderColor;
    Property DisabledBorder;
    Property FocusBorderColor;
    Property FocusControl;
    Property FocusDraw;
    Property ForceShadow;
    Property Font;
    
    Property EditType;
    Property ReturnIsTab;
    Property LengthLimit;
    Property Precision;
    Property Prefix;
    Property Suffix;
    Property DefaultHandling;
    Property CanUndo;
    Property ExcelStyleDecimalSeparator;
    Property ValidChars;
    Property FloatValue;
    Property IntValue;
    Property Modified;
    Property Signed;
    Property AutoThousandSeparator;

    Property Flat;
//    Property Etched;

    Property LabelCaption;
    Property LabelPosition;
    Property LabelMargin;
    Property LabelTransparent;
    Property LabelAlwaysEnabled;
    Property LabelFont;

    Property Text;

    Property OnClipboardCopy;
    Property OnClipboardCut;
    Property OnClipboardPaste;
    Property OnLabelClick;
    Property OnLabelDblClick;
    Property OnKeyPress;

    Property ButtonWidth;
    Property ButtonHint;
    Property ButtonGlyph;
    Property ButtonCaption;

    Property OnButtonClick;

  End;

  THsVTCustomDropDown = Class(THsVTCustomButtonEdit)
  Strict Private
    FDropDownForm        : THsVTDropDownForm;
    FDDFStatus           : TStatusBar;
    FDropDownWidth       : Integer;
    FDropDownHeight      : Integer;
    FUserDropDownWidth   : Integer;
    FUserDropDownHeight  : Integer;
    FDropDownShadow      : Boolean;
    FDropDownBorderWidth : Integer;
    FDropDownColorTo     : TColor;
    FDropDownColor       : TColor;
    FDropDownBorderColor : TColor;
    FDropDownGradient    : TGradientDirection;
    FDropDownSizeable    : Boolean;
    FDropDownEnabled     : Boolean;
    FDroppedDown         : Boolean;
    FDropPosition        : TDropPosition;
    FOnGetDropDownPos    : TGetDropDownPosEvent;

    FOnBeforeDropDown : TNotifyEvent;
    FOnBeforeDropUp   : TNotifyEvent;
    FOnDropDown       : TDropDown;
    FOnDropUP         : TDropUp;
    FStyle            : TDropDownStyle;

    Procedure WMKeyDown(Var Msg: TWMKeyDown); Message WM_KEYDOWN;
    Procedure WMLButtonDown(Var Msg: TWMMouse); Message WM_LBUTTONDOWN;
    Procedure WMLButtonUp(Var Msg: TWMMouse); Message WM_LBUTTONUP;
    Procedure CMWantSpecialKey(Var Msg: TCMWantSpecialKey); Message CM_WANTSPECIALKEY;

    Procedure CreateDropDownForm();
    Procedure MouseButtonDown(Sender: TObject);
    Procedure DropDownButtonClick(Sender: TObject);

    Procedure SetStyle(Const Value: TDropDownStyle);

    Procedure SetDropDownEnabled(Const Value: Boolean);
    Procedure SetDropDownColor(Const Value: TColor);
    Procedure SetDropDownHeight(Const Value: Integer);
    Procedure SetDropDownWidth(Const Value: Integer);

    Procedure OnFormHide(Sender: TObject);
    Procedure OnFormKeyPress(Sender: TObject; Var Key: Char);
    Procedure OnFormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
    Procedure OnFormKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
    Procedure OnFormMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; Var Handled: Boolean);
    Procedure OnFormMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; Var Handled: Boolean);

  Protected
    Procedure KeyDown(Var Key: Word; Shift: TShiftState); OverRide;

    Procedure BeforeDropDown(); Virtual;
    Procedure AdaptDropDownSize(Var AHeight: Integer); Virtual;
    Procedure AfterDropDown(); Virtual;
    Procedure DoShowDropDown(); Virtual;
    Procedure DoHideDropDown(Cancelled: Boolean); Virtual;
    Procedure UpdateDropDownSize(); Virtual;

    Property DropDownStyle               : TDropDownStyle           Read FStyle                       Write SetStyle;
    Property DropDownEnabled             : Boolean                  Read FDropDownEnabled             Write SetDropDownEnabled Default True;   // Enable dropdown when EditorEnable = false or Readonly = true;
    Property DropDownColor               : TColor                   Read FDropDownColor               Write SetDropDownColor Default clWhite;
    Property DropDownColorTo             : TColor                   Read FDropDownColorTo             Write FDropDownColorTo Default clNone; //when clNone, solid color is used
    Property DropDownGradient            : TGradientDirection       Read FDropDownGradient            Write FDropDownGradient Default gdHorizontal;
    Property DropDownBorderColor         : TColor                   Read FDropDownBorderColor         Write FDropDownBorderColor Default clBlack; //border color
    Property DropDownBorderWidth         : Integer                  Read FDropDownBorderWidth         Write FDropDownBorderWidth Default 1;
    Property DropDownShadow              : Boolean                  Read FDropDownShadow              Write FDropDownShadow Default True; //shadow on dropdown
    Property DropDownWidth               : Integer                  Read FDropDownWidth               Write SetDropDownWidth Default 0; //when 0, same size as control
    Property DropDownHeight              : Integer                  Read FDropDownHeight              Write SetDropDownHeight Default 0; //when 0, autosize
    Property DropDownSizeable            : Boolean                  Read FDropDownSizeable            Write FDropDownSizeable Default True;
    Property OnBeforeDropDown            : TNotifyEvent             Read FOnBeforeDropDown            Write FOnBeforeDropDown;
    Property OnDropDown                  : TDropDown                Read FOnDropDown                  Write FOnDropDown;
    Property OnBeforeDropUp              : TNotifyEvent             Read FOnBeforeDropUp              Write FOnBeforeDropUp;
    Property OnDropUp                    : TDropUP                  Read FOnDropUP                    Write FOnDropUp;
    Property DropPosition                : TDropPosition            Read FDropPosition                Write FDropPosition Default dpAuto;
    Property OnGetDropDownPos            : TGetDropDownPosEvent     Read FOnGetDropDownPos            Write FOnGetDropDownPos;

    Property DropDownForm : THsVTDropDownForm Read FDropDownForm;

  Public
    Property DroppedDown : Boolean Read FDroppedDown;

    Procedure Assign(Source : TPersistent); OverRide;

    Procedure ShowDropDown();
    Procedure HideDropDown(CancelChanges: Boolean = False);

    Constructor Create(AOwner: TComponent); OverRide;
    Destructor  Destroy(); OverRide;

  End;

  THsVTDropDown = Class(THsVTCustomDropDown)
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

    Property DropDownStyle;
    Property DropDownColor;
    Property DropDownColorTo;
    Property DropDownBorderColor;
    Property DropDownBorderWidth;
    Property DropDownShadow;
    Property DropDownWidth;
    Property DropDownHeight;
    Property DropDownEnabled;
    Property DropPosition;
    Property ButtonWidth;
    Property ButtonHint;
    Property DropDownSizeable;
    Property Enabled;
    Property EditorEnabled;
    Property Font;
    Property ButtonGlyph;
    Property Images;
    Property LabelCaption;
    Property LabelPosition;
    Property LabelMargin;
    Property LabelTransparent;
    Property LabelAlwaysEnabled;
    Property LabelFont;

    Property ReadOnly;
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
    Property OnGetDropDownPos;

  End;

  THsVTCustomControlDropDown = Class(THsVTCustomDropDown)
  Strict Private
    FControl : TControl;

    Procedure SetCenterControl();
    Procedure SetControl(Const Value: TControl);

    Procedure OnControlKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState); Virtual;
    Procedure OnControlKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState); Virtual;
    Procedure OnControlKeyPress(Sender: TObject; Var Key: Char); Virtual;
    Procedure OnControlMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); Virtual;

  Protected
    Procedure Notification(AComponent: TComponent; Operation: TOperation); OverRide;
    Procedure Loaded(); OverRide;
    Procedure DoShowDropDown(); OverRide;
    Procedure UpdateDropDownSize(); OverRide;

    Property Control : TControl Read FControl Write SetControl;

  End;

  THsVTControlDropDown = class(THsVTCustomControlDropDown)
  Published
    Property Control;

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

    Property DropDownStyle;
    Property DropDownColor;
    Property DropDownColorTo;
    Property DropDownBorderColor;
    Property DropDownBorderWidth;
    Property DropDownShadow;
    Property DropDownWidth;
    Property DropDownHeight;
    Property DropDownEnabled;
    Property DropPosition;
    Property ButtonWidth;
    Property ButtonHint;
    Property DropDownSizeable;
    Property Enabled;
    Property EditorEnabled;
    Property Font;
    Property ButtonGlyph;
    Property Images;
    Property LabelCaption;
    Property LabelPosition;
    Property LabelMargin;
    Property LabelTransparent;
    Property LabelAlwaysEnabled;
    Property LabelFont;

    Property ReadOnly;
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
    Property OnGetDropDownPos;

  End;

Implementation

Uses Clipbrd;

Function BrightnessColor(Col: TColor; BR,BG,BB: Integer): TColor; Overload;
Var
  r1,g1,b1: Integer;
Begin
  Col := Longint(ColorToRGB(Col));
  r1  := GetRValue(Col);
  g1  := GetGValue(Col);
  b1  := GetBValue(Col);

  If r1 = 0 Then
    r1 := Max(0,BR)
  Else
    r1 := Round( Min(100,(100 + BR))/100 * r1 );

  If g1 = 0 Then
    g1 := Max(0,BG)
  Else
    g1 := Round( Min(100,(100 + BG))/100 * g1 );

  If b1 = 0 Then
    b1 := Max(0,BB)
  Else
    b1 := Round( Min(100,(100 + BB))/100 * b1 );

  Result := RGB(r1,g1,b1);
End;

Procedure DrawGradient(Canvas: TCanvas; FromColor, ToColor: TColor; Steps: Integer; R: TRect; Direction: Boolean);
Var
  diffr, startr, endr: Integer;
  diffg, startg, endg: Integer;
  diffb, startb, endb: Integer;
  rstepr, rstepg, rstepb, rstepw: Real;
  i, stepw: Word;

Begin
  If Direction Then
    R.Right := R.Right - 1
  Else
    R.Bottom := R.Bottom - 1;

  If Steps = 0 Then
    Steps := 1;

  FromColor := ColorToRGB(FromColor);
  ToColor := ColorToRGB(ToColor);

  startr := (FromColor And $0000FF);
  startg := (FromColor And $00FF00) Shr 8;
  startb := (FromColor And $FF0000) Shr 16;
  endr := (ToColor And $0000FF);
  endg := (ToColor And $00FF00) Shr 8;
  endb := (ToColor And $FF0000) Shr 16;

  diffr := endr - startr;
  diffg := endg - startg;
  diffb := endb - startb;

  rstepr := diffr / steps;
  rstepg := diffg / steps;
  rstepb := diffb / steps;

  If Direction Then
    rstepw := (R.Right - R.Left) / Steps
  Else
    rstepw := (R.Bottom - R.Top) / Steps;

  With Canvas Do
  Begin
    For i := 0 To steps - 1 Do
    Begin
      endr := startr + Round(rstepr * i);
      endg := startg + Round(rstepg * i);
      endb := startb + Round(rstepb * i);
      stepw := Round(i * rstepw);
      Pen.Color := endr + (endg Shl 8) + (endb Shl 16);
      Brush.Color := Pen.Color;
      If Direction Then
        Rectangle(R.Left + stepw, R.Top, R.Left + stepw + Round(rstepw) + 1, R.Bottom)
      Else
        Rectangle(R.Left, R.Top + stepw, R.Right, R.Top + stepw + Round(rstepw) + 1);
    End;
  End;
End;

Procedure DrawSelectionGradient(Canvas: TCanvas; color1,color2,mircolor1,mircolor2,linecolortop,linecolorbottom,bordercolor,edgecolor,bkgcolor: TColor; r: TRect; part: TGradientPart);
Var
  dl,dr: Integer;
Begin
  r.Bottom := r.Bottom - 2;
  r.Right  := r.Right - 1;

  // top line
  Canvas.Pen.Color := linecolortop;
  Canvas.MoveTo(r.left,r.top + 1);
  Canvas.LineTo(r.right,r.top + 1);

  If (part In [gpFull, gpLeft]) Then
  Begin
    Canvas.Moveto(r.left + 1,r.Top +1);
    Canvas.LineTo(r.left + 1,r.Top + (r.Bottom -r.Top) Div 2);
  End;

  If (part In [gpFull, gpRight]) Then
  Begin
    Canvas.Moveto(r.right -2,r.Top +1);
    Canvas.LineTo(r.right -2,r.Top + (r.Bottom -r.Top) Div 2);
  End;

  Canvas.Pen.Color := linecolorbottom;
  Canvas.MoveTo(r.left,r.bottom - 1);
  Canvas.LineTo(r.right,r.bottom - 1);

  If (part In [gpFull, gpLeft]) Then
  Begin
    Canvas.Moveto(r.left + 1,r.Top + (r.Bottom -r.Top) Div 2);
    Canvas.LineTo(r.left + 1,r.Bottom - 1);
  End;

  If (part In [gpFull, gpRight]) Then
  Begin
    Canvas.Moveto(r.right - 2, r.Top + (r.Bottom -r.Top) Div 2);
    Canvas.LineTo(r.right - 2, r.Bottom - 1);
  End;

  dl := 2;
  dr := 2;
  If (part In [gpMiddle,gpLeft]) Then
    dr := 0;

  If (part In [gpMiddle,gpRight]) Then
    dl := 0;

  Canvas.Pen.Color := bordercolor;

  Canvas.MoveTo(r.left + dl,r.top);
  Canvas.LineTo(r.right - dr,r.top);

  Canvas.MoveTo(r.left + dl,r.bottom);
  Canvas.LineTo(r.right - dr,r.bottom);

  If (part In [gpFull, gpRight]) Then
  Begin
    Canvas.MoveTo(r.right - 1,r.top + 2);
    Canvas.LineTo(r.right - 1,r.bottom - 1);
  End;

  If (part In [gpFull, gpLeft]) Then
  Begin
    Canvas.MoveTo(r.left,r.top + 2);
    Canvas.LineTo(r.left,r.bottom - 1);
  End;

  If (part In [gpFull, gpLeft]) Then
  Begin
    Canvas.Pixels[r.Left + 1,r.Top] := edgecolor;
    Canvas.Pixels[r.Left + 1,r.Top + 1] := edgecolor;
    Canvas.Pixels[r.Left,r.Top + 1] := edgecolor;
    Canvas.Pixels[r.Left + 1,r.Bottom] := edgecolor;
    Canvas.Pixels[r.Left + 1,r.Bottom - 1] := edgecolor;
    Canvas.Pixels[r.Left,r.Bottom - 1] := edgecolor;

    Canvas.Pixels[r.Left,r.Top] := bkgcolor;
    Canvas.Pixels[r.Left,r.Bottom] := bkgcolor;
  End;

  If (part In [gpFull, gpRight]) Then
  Begin
    Canvas.Pixels[r.right - 2,r.top] := edgecolor;
    Canvas.Pixels[r.right - 2,r.top + 1] := edgecolor;
    Canvas.Pixels[r.right - 1,r.top + 1] := edgecolor;
    Canvas.Pixels[r.right - 2,r.bottom] := edgecolor;
    Canvas.Pixels[r.right - 2,r.bottom - 1] := edgecolor;
    Canvas.Pixels[r.right - 1,r.bottom - 1] := edgecolor;

    Canvas.Pixels[r.Right - 1,r.Top] := bkgcolor;
    Canvas.Pixels[r.Right - 1,r.Bottom] := bkgcolor;
  End;

  r := Rect(r.Left + dl, r.Top + 2, r.Right - dr, r.Bottom - 1);

  If (color2 = clNone) Then
  Begin
    Canvas.Brush.Color := color1;
    Canvas.Pen.Color := color1;
    Canvas.FillRect(r);
  End
  Else
  Begin
    If mircolor1 <> clNone Then
    Begin
      DrawGradient(Canvas,color1,color2,16,Rect(r.Left, r.Top, r.Right, r.Top + (r.Bottom - r.Top) Div 2), False);
      DrawGradient(Canvas,mircolor1,mircolor2,16,Rect(r.Left, r.Top + (r.Bottom - r.Top) Div 2, r.Right, r.Bottom), False);
    End
    Else
      DrawGradient(Canvas,color1,color2,16,r, False);
  End;
End;

Procedure DrawBitmapTransp(Canvas: TCanvas;bmp:TBitmap;bkcolor:TColor;r:TRect);
Var
  tmpbmp: TBitmap;
  srcColor: TColor;
  tgtrect: TRect;
Begin
  TmpBmp := TBitmap.Create;
  Try
    TmpBmp.Height := bmp.Height;
    TmpBmp.Width  := bmp.Width;

    tgtrect.left := 0;
    tgtrect.top  := 0;
    tgtrect.right := r.right - r.left;
    tgtrect.bottom := r.bottom - r.Top;

    TmpBmp.Canvas.Brush.Color := bkcolor;
    srcColor := bmp.Canvas.Pixels[0,0];
    TmpBmp.Canvas.BrushCopy(tgtrect,bmp,tgtrect,srcColor);
    Canvas.CopyRect(r, TmpBmp.Canvas, tgtrect);
  Finally
    TmpBmp.Free;
  End;
End;

Function CheckSeparator(ch: Char): Boolean;
Begin
  {$IFNDEF DELPHI_UNICODE}
  Result := ch In ['-', ',', ';'];
  {$ENDIF}

  {$IFDEF DELPHI_UNICODE}
  Result := (ch = '-') Or (ch = ',') Or (ch = ';');
  {$ENDIF}
End;

Function CheckTerminator(ch: Char): Boolean;
Const
  Terminators = [' ',',','.','-',''''];
Begin
  {$IFNDEF DELPHI_UNICODE}
  Result := ch In Terminators;
  {$ENDIF}
  {$IFDEF DELPHI_UNICODE}
  Result := (ch = ' ') Or (ch = ',') Or (ch = '.') Or (ch = '-') Or (ch = '''');
  {$ENDIF}
End;

Function ShiftCase(Name: String): String;

{$IFNDEF DELPHI_UNICODE}
  Function LowCase(C: Char): Char;
  Begin
    If C In ['A' .. 'Z'] Then
      LowCase := Chr(Ord(C) - Ord('A') + Ord('a'))
    Else Lowcase := C;
  End;
{$ENDIF}

Var
  I, L: Integer;
  NewName: String;
  First: Boolean;
Begin
  First := True;
  NewName := Name;
  L := Length(Name);

  For I := 1 To L Do
  Begin
    If CheckTerminator(NewName[I]) Then
      First:= True
    Else
    If First Then
    Begin
        {$IFNDEF DELPHI_UNICODE}
      NewName[I] := Upcase(Name[I]);
        {$ENDIF}
        {$IFDEF DELPHI_UNICODE}
      NewName[I] := Character.ToUpper(Name[I]);
        {$ENDIF}
      First := False;
    End
    Else
      {$IFNDEF DELPHI_UNICODE}
      NewName[I] := Lowcase(Name[I]);
      {$ENDIF}
      {$IFDEF DELPHI_UNICODE}
    NewName[I] := Character.ToLower(Name[I]);
      {$ENDIF}

    If (Copy(NewName, 1, I) = 'Mc') Or
      ((Pos (' Mc', NewName) = I - 2) And (I > 2)) Or
      ((I > L - 3) And ((Copy(NewName, I - 1, 2) = ' I') Or
      (Copy(NewName, I - 2, 3) = ' II'))) Then
      First:= True;
  End;

  Result := NewName;
End;

Type
  TAutoType = (atNumeric, atFloat, atString, atDate, atTime, atHex);

Function IsType(s: String): TAutoType;
Var
  i: Integer;
  isI, isF, isH: Boolean;
  th, de, mi: Integer;

Begin
  Result := atString;

  isI := True;
  isF := True;
  isH := True;

  If s = '' Then
  Begin
    isI := False;
    isF := False;
    isH := False;
  End;

  th := -1; de := 0; mi := 0;

  For i := 1 To Length(s) Do
  Begin
    If Not (ord(s[i]) In Numeric_Codes) Then
      isI := False;
    If Not (ord(s[i]) In Float_Codes) Then
      isF := False;
    If Not (ord(s[i]) In Hex_Codes) Then
      isH := False;

    If (s[i] = {$If CompilerVersion > 19}FormatSettings.{$EndIf}ThousandSeparator) And (i - th < 3) Then
      isF := False;
    If s[i] = {$If CompilerVersion > 19}FormatSettings.{$EndIf}ThousandSeparator Then
      th := i;
    If s[i] = {$If CompilerVersion > 19}FormatSettings.{$EndIf}DecimalSeparator Then
      inc(de);
    If s[i] = '-' Then
      inc(mi);
  End;

  If isH And Not isI Then
    Result := atHex;

  If isI Then
    Result := atNumeric
  Else
  Begin
    If isF Then
      Result := atFloat;
  End;

  If (mi > 1) Or (de > 1) Then
    Result := atString;
End;

Function StripThousandSep(s: String): String;
Begin
  While (Pos({$If CompilerVersion > 19}FormatSettings.{$EndIf}ThousandSeparator, s) > 0) Do
    Delete(s, Pos({$If CompilerVersion > 19}FormatSettings.{$EndIf}ThousandSeparator, s), 1);
  Result := s;
End;

Function HexToInt(s: String): Integer;
  Function CharVal(c: Char): Integer;
  Begin
    Result := 0;
    If ((c >= '0') And (c <= '9')) Then
      Result := ord(c) - ord('0');
    If ((c >= 'A') And (c <= 'F')) Then
      Result := ord(c) - ord('A') + 10;
    If ((c >= 'a') And (c <= 'f')) Then
      Result := ord(c) - ord('a') + 10;
  End;

Var
  i: Integer;
  r, m: Integer;
Begin
  r := 0;
  m := 1;
  For i := Length(s) Downto 1 Do
  Begin
    r := r + m * CharVal(s[i]);
    m := m Shl 4;
  End;
  Result := r;
End;

(******************************************************************************)

Constructor THsVTDropDownForm.Create(AOwner: TComponent);
Begin
  CreateNew(AOwner);
End;

Constructor THsVTDropDownForm.CreateNew(AOwner: TComponent; Dummy: Integer);
Begin
  InHerited;
  FShadow := True;
  FCancelOnDeActivate := True;
End;

Procedure THsVTDropDownForm.CreateParams(Var Params: TCreateParams);
{$IFNDEF DELPHI2006_LVL}
Const
  CS_DROPSHADOW = $00020000;
{$ENDIF}
Var
  f: TCustomForm;
Begin
  InHerited CreateParams(Params);

  //Params.Style := Params.Style + WS_BORDER;

  (*
  if Shadow and (Win32Platform = VER_PLATFORM_WIN32_NT) and
    ((Win32MajorVersion > 5) or
    ((Win32MajorVersion = 5) and (Win32MinorVersion >= 1))) then
    Params.WindowClass.Style := Params.WindowClass.Style or CS_DROPSHADOW
  else
    Params.WindowClass.Style := Params.WindowClass.Style - CS_DROPSHADOW;
  *)

  If (Win32Platform = VER_PLATFORM_WIN32_NT) Then // not for Win9x
    Params.ExStyle := Params.ExStyle Or WS_EX_TOPMOST;

   //Params.Style := WS_SIZEBOX or WS_SYSMENU;
   //Params.ExStyle := WS_EX_DLGMODALFRAME or WS_EX_WINDOWEDGE; Params.ExStyle: = WS_EX_DLGMODALFRAME or WS_EX_WINDOWEDGE;
  If Assigned(HsVTDropDown) Then
    f := GetParentForm(HsVTDropDown)
  Else
    f := Nil;

  If Assigned(f) Then
    Params.WndParent := f.Handle;

End;

Function THsVTDropDownForm.GetClientRect: TRect;
Begin
  Result := InHerited GetClientRect;
End;

Procedure THsVTDropDownForm.AdjustClientRect(Var Rect: TRect);
Begin
  InHerited AdjustClientRect(Rect);

  If Assigned(FHsVTDropDown) Then
    InflateRect(Rect, -FHsVTDropDown.DropDownBorderWidth, -FHsVTDropDown.DropDownBorderWidth);
End;

Function THsVTDropDownForm.GetParentWnd() : HWnd;
Var P : HWnd;
Begin
  If (Owner <> Nil) Then
  Begin
    P := GetParent((Owner As TWinControl).Handle);
    Result := P;
    While P <> 0 Do
    Begin
      Result := P;
      P := GetParent(P);
    End;
  End
  Else
    Result := 0;
End;

Procedure THsVTDropDownForm.Paint();
Begin
  InHerited;
  DrawBackGround(Canvas);
End;

Function THsVTDropDownForm.DoMouseWheelDown(Shift: TShiftState;
  MousePos: TPoint): Boolean;
Begin
  Result := InHerited DoMouseWheelDown(Shift, MousePos);
End;

Function THsVTDropDownForm.DoMouseWheelUp(Shift: TShiftState;
  MousePos: TPoint): Boolean;
Begin
  Result := InHerited DoMouseWheelUp(Shift, MousePos);
End;

Procedure THsVTDropDownForm.DrawBackGround(ACanvas: TCanvas);
Var
  R: TRect;
Begin
  If Not Assigned(FHsVTDropDown) Then
    Exit;

  R := ClientRect;
  InflateRect(R, -FHsVTDropDown.DropDownBorderWidth, -FHsVTDropDown.DropDownBorderWidth);
  If (HsVTDropDown.DropDownColor <> clNone) And (HsVTDropDown.DropDownColorTo <> clNone) Then
    DrawGradient(aCanvas, HsVTDropDown.DropDownColor, HsVTDropDown.DropDownColorTo, 80, R, HsVTDropDown.DropDownGradient = gdHorizontal)
  Else If (HsVTDropDown.DropDownColor <> clNone) Then
  Begin
    ACanvas.Brush.Color := HsVTDropDown.DropDownColor;
    ACanvas.FillRect(R);
  End;

  If FHsVTDropDown.DropDownBorderWidth > 0 Then
  Begin
    R := ClientRect;
    R.Top  := R.Top + FHsVTDropDown.DropDownBorderWidth Div 2;
    R.Left := R.Left + FHsVTDropDown.DropDownBorderWidth Div 2;

    ACanvas.Pen.Width   := FHsVTDropDown.DropDownBorderWidth;
    ACanvas.Pen.Color   := FHsVTDropDown.DropDownBorderColor;
    ACanvas.Brush.Style := bsClear;
    ACanvas.Rectangle(R);
  End;
End;

Procedure THsVTDropDownForm.WMSize(Var Message: TWMSize);
Begin
  InHerited;
  DrawBackGround(Canvas);
End;

Procedure THsVTDropDownForm.WMSizing(Var Message: TWMSize);
Begin
  InHerited;
  If Assigned(FOnSizing) Then
    FOnSizing(Self);
End;

Procedure THsVTDropDownForm.SetAdvDropDown(Const Value: THsVTCustomDropDown);
Begin
  FHsVTDropDown := Value;
End;

Procedure THsVTDropDownForm.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
Begin
  InHerited;
End;

Procedure THsVTDropDownForm.UpdateSize;
Begin

End;

Procedure THsVTDropDownForm.WMActivate(Var Message: TWMActivate);
Var
  ph: THandle;
  RealDeActivate: Boolean;

Begin
  InHerited;

  If FBlockActivate Then
    Exit;

  If Message.Active = Integer(False) Then
  Begin
    If Visible Then
    Begin
      FDeActivate := GetTickCount;
      RealDeActivate := True;

      ph := Message.ActiveWindow;
      Repeat
        ph := GetParent(ph);
        If ph = self.Handle Then
          RealDeactivate := False;
      Until (ph = 0) Or (RealDeactivate = False);

      If RealDeActivate Then
      Begin
        If Assigned(HsVTDropDown) Then
          HsVTDropDown.DoHideDropDown(CancelOnDeActivate)
        Else
          Hide;
      End;
    End;
  End
  Else
  Begin
    SendMessage(GetParentWnd, WM_NCACTIVATE, 1, 0);
  End;
End;

Procedure THsVTDropDownForm.WMClose(Var Msg: TMessage);
Begin
  InHerited;
End;

Procedure THsVTDropDownForm.WMNCHitTest(Var Message: TWMNCHitTest);
Var pt : TPoint;
Begin
  //InHerited;
  pt := ScreenToClient(Point(Message.XPos, Message.YPos));

  If Sizeable And (pt.X > Width - 10) And (pt.Y > Height - 10) Then
    message.Result := HTBOTTOMRIGHT;
End;

Procedure THsVTDropDownForm.WMGetDlgCode(Var Message: TMessage);
Begin
  If TabStop Or True Then
    Message.Result := DLGC_WANTALLKEYS Or DLGC_WANTARROWS
  Else
    Message.Result := 0;
End;

Procedure THsVTDropDownEditButton.THsVTDropDownSpeedButton.SetButtonStyle(Const Value: TButtonStyle);
Begin
  FButtonStyle := Value;
  Invalidate();
End;

Procedure THsVTDropDownEditButton.THsVTDropDownSpeedButton.SetEtched(Const Value: Boolean);
Begin
  If Value <> FEtched Then
  Begin
    FEtched := value;
    Invalidate();
  End;
End;

Procedure THsVTDropDownEditButton.THsVTDropDownSpeedButton.SetFocused(Const Value: Boolean);
Begin
  If Value <> FFocused Then
  Begin
    FFocused := Value;
    Invalidate();
  End;
End;

Procedure THsVTDropDownEditButton.THsVTDropDownSpeedButton.CMMouseEnter(Var Message: TMessage);
Begin
  InHerited;
  FHot := True;
  Invalidate();
End;

Procedure THsVTDropDownEditButton.THsVTDropDownSpeedButton.CMMouseLeave(Var Message: TMessage);
Begin
  InHerited;
  FHot := False;
  Invalidate();
End;

Procedure THsVTDropDownEditButton.THsVTDropDownSpeedButton.Paint();
Begin
  Case ButtonStyle Of
    bsButton : PaintButton();
    bsDropDown : PaintDropDown();
  End;
End;

Procedure THsVTDropDownEditButton.THsVTDropDownSpeedButton.PaintDropDown();
Var ARect : TRect;
Begin
  If (THsVTDropDownEditButton(Owner).ButtonColor <> clNone) Then
  Begin
    Canvas.Brush.Color := THsVTDropDownEditButton(Owner).ButtonColor;

    If FHot Then
      Canvas.Brush.Color := THsVTDropDownEditButton(Owner).ButtonColorHot;

    If (FState In [bsDown, bsExclusive]) And Not FUp Then
      Canvas.Brush.Color := THsVTDropDownEditButton(Owner).ButtonColorDown;

    Canvas.Pen.Color := Canvas.Brush.Color;
    ARect := ClientRect;
    ARect.Left := ARect.Left + 2;
    Canvas.FillRect(ClientRect);
    ARect.Left := ARect.Left - 2;

    Canvas.Pen.Color := THsVTCustomEdit(Owner.Owner).BorderColor;
    Canvas.MoveTo(ARect.Left, ARect.Top);
    Canvas.LineTo(ARect.Left, ARect.Bottom);

    Canvas.Brush.Color := THsVTDropDownEditButton(Owner).ButtonTextColor;

    If FHot Then
      Canvas.Brush.Color := THsVTDropDownEditButton(Owner).ButtonTextColorHot;

    If ((FState In [bsDown, bsExclusive]) And Not FUp) Then
      Canvas.Brush.Color := THsVTDropDownEditButton(Owner).ButtonTextColorDown;

    Canvas.Pen.Color := Canvas.Brush.Color;
    Canvas.Polygon([Point(5, 7), Point(11, 7), Point(8, 10)]);
  End
  Else If Assigned(Glyph) And Not Glyph.Empty Then
  Begin
    Canvas.Brush.Color := clBtnFace;
    Canvas.Pen.Color := clgray;
    Canvas.Rectangle(ClientRect);
    Glyph.TransparentMode := tmAuto;
    Glyph.Transparent := True;
    Canvas.Draw(0,0,Glyph);
  End
  Else
  Begin
    InHerited Paint();

    Canvas.Pen.Color := clBtnFace;
    Canvas.Pen.Width := 1;
    Canvas.MoveTo(Width-2,0);
    Canvas.LineTo(0,0);
    Canvas.LineTo(0,Height - 1);

    Canvas.Pen.Color := clWhite;
    Canvas.Pen.Width := 1;
    Canvas.MoveTo(Width-3,1);
    Canvas.LineTo(1,1);
    Canvas.LineTo(1,Height - 2);

    Canvas.Brush.Color := clBlack;
    Canvas.Pen.Color := Canvas.Brush.Color;

    Canvas.Polygon([Point(5, 7), Point(11, 7), Point(8, 10)]);
  End;
End;

Procedure THsVTDropDownEditButton.THsVTDropDownSpeedButton.PaintButton();
Const
  Flags: Array[Boolean] Of Integer = (0, BF_FLAT);
  Edge: Array[Boolean] Of Integer = (EDGE_RAISED, EDGE_ETCHED);

Var r            : TRect;
    BtnFaceBrush : HBRUSH;
Begin
  Canvas.Font.Assign(THsVTCustomEdit(Owner.Owner).Font);

  If Not Flat Then
    InHerited Paint
  Else
  Begin
    r := BoundsRect;
    FillRect(Canvas.Handle,r,Canvas.Brush.Handle);

    BtnFaceBrush := CreateSolidBrush(GetSysColor(COLOR_BTNFACE));

    FillRect(Canvas.Handle, r, BtnFaceBrush);

    DeleteObject(BtnFaceBrush);

    r.Bottom := r.Bottom + 1;
    r.Right  := r.Right + 1;
    DrawEdge(Canvas.Handle, r, Edge[fEtched], BF_RECT Or flags[fState=bsDown]);

    r := ClientRect;

    If Assigned(Glyph) Then
    Begin
      If Not Glyph.Empty Then
      Begin
        InflateRect(r,-3,-3);
        If fstate = bsdown Then
          offsetrect(r,1,1);
        DrawBitmapTransp(canvas,glyph,ColorToRGB(clBtnFace),r);
      End;
    End;

    If (Caption <> '') Then
    Begin
      Inflaterect(r,-3,-1);
      If FState = bsdown Then
        Offsetrect(r,1,1);
      Windows.SetBKMode(canvas.handle,windows.TRANSPARENT);
      DrawText(Canvas.handle,PChar(Caption),length(Caption),r,DT_CENTER);
    End;
  End;
End;

Constructor THsVTDropDownEditButton.THsVTDropDownSpeedButton.Create(AOwner: TComponent);
Begin
  InHerited Create(AOwner);

  FUp := False;
End;

Constructor THsVTDropDownEditButton.Create(AOwner: TComponent);
Begin
  InHerited Create(AOwner);

  ControlStyle := ControlStyle - [csAcceptsControls, csSetCaption] + [csOpaque];
  FButton := CreateButton;
  FButton.ButtonStyle := bsDropDown;

  Glyph := Nil;
  Width := 16;
  Height := 25;

  FButtonWidth         := 16;
  FButtonColor         := clNone;
  FButtonColorHot      := clNone;
  FButtonColorDown     := clNone;
  FButtonTextColor     := clNone;
  FButtonTextColorHot  := clNone;
  FButtonTextColorDown := clNone;
  FButtonBorderColor   := clNone;
End;

Function THsVTDropDownEditButton.CreateButton() : THsVTDropDownSpeedButton;
Begin
  Result := THsVTDropDownSpeedButton.Create(Self);
  Result.Parent    := Self;
  Result.OnMouseUp := BtnMouseDown;
  Result.Visible   := True;
  Result.Enabled   := Enabled;
  Result.Caption   := '';
End;

Procedure THsVTDropDownEditButton.CMEnabledChanged(Var Msg: TMessage);
Begin
  InHerited;

  If (ComponentState * [csDesigning] = []) And Assigned(FButton) Then
    FButton.Enabled := Enabled;
End;

Procedure THsVTDropDownEditButton.Notification(AComponent: TComponent;
  Operation: TOperation);
Begin
  InHerited Notification(AComponent, Operation);
  If (Operation = opRemove) And (AComponent = FFocusControl) Then
    FFocusControl := Nil;
End;

Procedure THsVTDropDownEditButton.AdjustWinSize(Var W: Integer; Var H: Integer);
Begin
  If Assigned(FButton) Or
     (ComponentState * [csLoading, csDesigning] = [csLoading]) Then
  Begin
    W := FButtonWidth;
    FButton.SetBounds (0, 0, W, H);
  End;
End;

Procedure THsVTDropDownEditButton.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
Var W, H: Integer;
Begin
  W := AWidth;
  H := AHeight;
  AdjustWinSize(W, H);

  InHerited SetBounds(ALeft, ATop, W, H);
End;

Procedure THsVTDropDownEditButton.WMSize(Var Message: TWMSize);
Var W, H: Integer;
Begin
  InHerited;

  W := Width;
  H := Height;
  AdjustWinSize(W, H);
  If (W <> Width) Or (H <> Height) Then
    InHerited SetBounds(Left, Top, W, H);

  Message.Result := 0;
End;

Procedure THsVTDropDownEditButton.BtnMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
Begin
  If Button = mbLeft Then
  Begin
    If Assigned(FOnClick) And (Sender = FButton) Then
      FOnClick(Self);
  End;
End;

Procedure THsVTDropDownEditButton.Loaded();
Var W, H: Integer;
Begin
  InHerited Loaded();

  W := Width;
  H := Height;
  AdjustWinSize(W, H);

  If (W <> Width) Or (H <> Height) Then
    InHerited SetBounds(Left, Top, W, H);
End;

Function THsVTDropDownEditButton.GetGlyph() : TBitmap;
Begin
  Result := FButton.Glyph;
End;

Procedure THsVTDropDownEditButton.SetGlyph(Value: TBitmap);
Begin
  FButton.Glyph := Value;
End;

Procedure THsVTDropDownEditButton.SetCaption(value:String);
Begin
  FButton.Caption := Value;
End;

Function THsVTDropDownEditButton.GetCaption() : String;
Begin
  Result := FButton.Caption;
End;

Function THsVTDropDownEditButton.GetNumGlyphs() : TNumGlyphs;
Begin
  Result := FButton.NumGlyphs;
End;

Procedure THsVTDropDownEditButton.SetNumGlyphs(Value: TNumGlyphs);
Begin
  FButton.NumGlyphs := Value;
End;

(******************************************************************************)

Constructor THsVTCustomEdit.Create(AOwner: TComponent);
Begin
  InHerited Create(AOwner);

  FBorderColor := clNone;
  FFocusBorderColor := clNone;
  FDisabledBorder := True;

  FEditType := etString;
  FParentFnt := False;
  FEditorEnabled := True;

  SetBounds(left, top, 200, 21);

  ControlStyle := ControlStyle - [csSetCaption];
  ReadOnly := False;
  Text := '';
  FOldText := '';

  FDefaultHandling := True;
  FCanUndo := True;
  FAutoThousandSeparator := True;
  FFocusDraw := True;

  FLabelFont := TFont.Create;
  FLabelFont.OnChange := LabelFontChange;

//  FRequired := True;
//  FRequiredColor := clFuchsia;
End;

Destructor THsVTCustomEdit.Destroy();
Begin
  FLabelFont.Free();

  InHerited Destroy();
End;

Procedure THsVTCustomEdit.CreateParams(Var Params: TCreateParams);
Const
  Alignments : Array[TAlignment] Of DWord = (ES_LEFT, ES_RIGHT, ES_CENTER);
Begin
  InHerited CreateParams(Params);

  Params.Style := Params.Style Or
                  ES_MULTILINE Or
                  WS_CLIPCHILDREN Or
                  Alignments[FAlignment];
End;

Function THsVTCustomEdit.CreateLabel: TLabel;
Begin
  Result := TLabel.Create(self);
  Result.Parent := self.Parent;
  Result.FocusControl := self;
  Result.Font.Assign(LabelFont);
  Result.OnClick := LabelClick;
  Result.OnDblClick := LabelDblClick;
  Result.ParentFont := self.ParentFont;
End;

Procedure THsVTCustomEdit.WMSize(Var Message: TWMSize);
Begin
  InHerited;
  ResizeControl();
End;

Function THsVTCustomEdit.GetMinHeight: Integer;
Var
  DC: HDC;
  SaveFont: HFont;
  I:  Integer;
  SysMetrics, Metrics: TTextMetric;
Begin
  DC := GetDC(0);
  GetTextMetrics(DC, SysMetrics);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  I := SysMetrics.tmHeight;
  If I > Metrics.tmHeight Then
    I := Metrics.tmHeight;
  Result := Metrics.tmHeight + I Div 4;
End;

Function THsVTCustomEdit.GetEditRect: TRect;
Begin
  Result := FEditRect;
End;

Procedure THsVTCustomEdit.SetEditRect();
Var Loc: TRect;
Begin
  SendMessage(Handle, EM_GETRECT, 0, Longint(@Loc));

  Loc.Bottom := ClientHeight + 1;
  Loc.Right  := ClientWidth - 3;

  If self.BorderStyle = bsNone Then
  Begin
    Loc.Top := 3;
    Loc.Left := 2;
  End
  Else
  Begin
    Loc.Top := 1;
    Loc.Left := 1;
  End;
  FEditRect := Loc;

  If Not Ctl3D Then
    Loc.Left := Loc.Left + 1;

  SendMessage(Handle, EM_SETRECTNP, 0, Longint(@Loc));
End;

Procedure THsVTCustomEdit.CreateWnd();
Begin
  InHerited CreateWnd();

  SetEditRect;
  If Assigned(FLabel) Then
    UpdateLabel();
End;

Procedure THsVTCustomEdit.DestroyWnd;
Begin
  InHerited;
End;

Procedure THsVTCustomEdit.SetEditorEnabled(Const Value: Boolean);
Begin
  FEditorEnabled := Value;
  //ReadOnly := not (Value);
  If FEditorEnabled Then
    ControlStyle := ControlStyle + [csDoubleClicks]
  Else
    ControlStyle := ControlStyle - [csDoubleClicks];
End;

Type
  TWinControlAccess = Class(TWinControl);

Procedure THsVTCustomEdit.WMKeyDown(Var Msg: TWMKeyDown);
Var selp   : Integer;
    s      : String;
    isCtrl : Boolean;
Begin
  If csDesigning In ComponentState Then
    Exit;

  If Not EditorEnabled And Enabled Then
  Begin
    If (Msg.CharCode In [VK_RETURN,VK_ESCAPE,VK_TAB]) Then
      InHerited;
    Exit;
  End;

  IsCtrl := GetKeyState(VK_CONTROL) And $8000 = $8000;

  If (msg.CharCode In [VK_TAB, VK_RETURN]) And IsCtrl Then
  Begin
    InHerited;
    Exit;
  End;

  If (msg.CharCode = VK_RETURN) And (FReturnIsTab) Then
  Begin
    msg.CharCode := VK_TAB;
    If IsWindowVisible(self.Handle) Then
      PostMessage(self.Handle, WM_KEYDOWN, VK_TAB, 0);
  End;

  If (msg.CharCode = VK_RIGHT) And (FSuffix <> '') Then
  Begin
    selp := hiword(SendMessage(self.handle, EM_GETSEL, 0, 0));
    If selp >= Length(self.text) Then
    Begin
      msg.CharCode := 0;
      msg.Result := 0;
      Exit;
    End;
  End;

  If (msg.CharCode = VK_DELETE) And (FSuffix <> '') Then
  Begin
    selp := hiword(SendMessage(Handle, EM_GETSEL, 0, 0));
    If (selp >= Length(self.text)) And (SelLength = 0) Then
    Begin
      msg.CharCode := 0;
      msg.Result := 0;
      Exit;
    End;
    SetModified(True);
  End;

  If (msg.CharCode = VK_LEFT) And (FPrefix <> '') Then
  Begin
    selp := hiword(SendMessage(Handle, EM_GETSEL, 0, 0));

    If selp <= Length(FPrefix) Then
    Begin
      msg.CharCode := 0;
      msg.Result := 0;
      Exit;
    End;
  End;

  If (msg.CharCode = VK_END) And (FSuffix <> '') Then
  Begin
    If (GetKeyState(VK_SHIFT) And $8000 = 0) Then
    Begin
      SelStart := Length(Text);
      SelLength := 0;
    End
    Else
      SelLength := Length(Text) - SelStart;
    msg.charcode := 0;
    msg.Result := 0;
    Exit;
  End;

  If (msg.CharCode = VK_HOME) And (FPrefix <> '') Then
  Begin
    If (GetKeyState(VK_SHIFT) And $8000 = 0) Then
    Begin
      SelStart := Length(fPrefix);
      SelLength := 0;
    End
    Else
    Begin
      SendMessage(Handle, EM_SETSEL, Length(fprefix) + Length(self.text), Length(fprefix));
    End;
    msg.Charcode := 0;
    msg.Result := 0;
    Exit;
  End;

  If (msg.CharCode = VK_BACK) And (FPrefix <> '') Then
  Begin
    If (SelStart <= Length(FPrefix) + 1) Then
    Begin
      msg.CharCode := 0;
      msg.Result := 0;
      Exit;
    End;
    SetModified(True);
  End;

  If (msg.CharCode = VK_DELETE) And (SelStart >= Length(FPrefix)) Then
  Begin
    s := self.text;
    If SelLength = 0 Then
      Delete(s, SelStart - Length(fprefix) + 1, 1)
    Else
      Delete(s, SelStart - Length(fprefix) + 1, SelLength);

    If (lengthlimit > 0) And (fixedLength(s) - 1 > lengthlimit) Then
    Begin
      msg.CharCode := 0;
      msg.Result := 0;
      Exit;
    End;

    SetModified(True);
  End;

  InHerited;

  If (msg.CharCode = VK_DELETE) And (EditType = etMoney) Then
    AutoSeparators;

  If (fPrefix <> '') And (SelStart < Length(fPrefix)) Then
    SelStart := Length(fPrefix);
End;

Procedure THsVTCustomEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
Begin
  InHerited;

  If (ComponentState * [csDestroying] = []) And (Operation = opRemove) Then
  Begin
    If (AComponent = FImages) Then
    Begin
      Images := Nil;
      Invalidate();
    End;

    If (AComponent = FFocusControl) Then
      FocusControl := Nil;
  End;
End;

Procedure THsVTCustomEdit.SetImages(Const Value: TCustomImageList);
Begin
  FImages := value;
End;

Procedure THsVTCustomEdit.WMGetDlgCode(Var Message: TWMGetDlgCode);
Begin
  InHerited;
//  Message.Result := 1; // Message.Result or DLGC_WANTALLKEYS or DLGC_WANTARROWS;
End;

Procedure THsVTCustomEdit.KeyPress(Var Key: Char);
Begin
  InHerited KeyPress(key);
  If (Key = Char(VK_RETURN)) Then
    Key := #0;
End;

Procedure THsVTCustomEdit.SetFlat(Const Value: Boolean);
Begin
  If (FFlat <> Value) Then
    FFlat := Value;
End;

Function THsVTCustomEdit.DoMouseWheelDown(Shift: TShiftState;
  MousePos: TPoint): Boolean;
Begin
  Result := InHerited DoMouseWheelDown(Shift, MousePos);
  HandleMouseWheelDown();
End;

Function THsVTCustomEdit.DoMouseWheelUp(Shift: TShiftState;
  MousePos: TPoint): Boolean;
Begin
  Result := InHerited DoMouseWheelUp(Shift, MousePos);
  HandleMouseWheelUp();
End;

Procedure THsVTCustomEdit.HandleMouseWheelDown();
Begin

End;

Procedure THsVTCustomEdit.HandleMouseWheelUp();
Begin

End;

Procedure THsVTCustomEdit.ResizeControl();
Var MinHeight: Integer;
Begin
  MinHeight := GetMinHeight;

  If (Height < MinHeight) Then
    Height := MinHeight;

  Invalidate();
End;

Procedure THsVTCustomEdit.WMChar(Var Msg: TWMKey);
Var
  oldSelStart, oldprec: Integer;
  s: String;
  key: Char;
  isCtrl: Boolean;
  cf: TCustomForm;

  Function scanprecision(s: String; inspos: Integer): Boolean;
  Var
    mdist: Integer;
  Begin
    Result := False;
    inspos := inspos - Length(FPrefix);
    If FPrecision <= 0 Then
      Exit;

    If (Length(s) - inspos > FPrecision) Then
    Begin
      Result := False;
      exit;
    End;

    If (Pos({$If CompilerVersion > 19}FormatSettings.{$EndIf}DecimalSeparator, s) > 0) Then
    Begin
      mdist := Length(s) - Pos({$If CompilerVersion > 19}FormatSettings.{$EndIf}DecimalSeparator, s);
      If (inspos >= Pos({$If CompilerVersion > 19}FormatSettings.{$EndIf}DecimalSeparator, s)) And (mdist >= FPrecision) Then
        Result := True;
    End;
  End;

  Function scandistance(s: String; inspos: Integer): Boolean;
  Var
    mdist: Integer;
  Begin
    Result := False;
    inspos := inspos - Length(fPrefix);
    mdist  := Length(s);

    If (Pos({$If CompilerVersion > 19}FormatSettings.{$EndIf}ThousandSeparator, s) = 0) Then
    Begin
      Result := False;
      Exit;
    End;

    While (Pos({$If CompilerVersion > 19}FormatSettings.{$EndIf}ThousandSeparator, s) > 0) Do
    Begin
      If abs(Pos({$If CompilerVersion > 19}FormatSettings.{$EndIf}ThousandSeparator, s) - inspos) < mdist Then
        mdist := abs(Pos({$If CompilerVersion > 19}FormatSettings.{$EndIf}ThousandSeparator, s) - inspos);
      If (abs(Pos({$If CompilerVersion > 19}FormatSettings.{$EndIf}ThousandSeparator, s) - inspos) < 3) Then
      Begin
        Result := True;
        break;
      End;

      If inspos > Pos({$If CompilerVersion > 19}FormatSettings.{$EndIf}ThousandSeparator, s) Then
        inspos := inspos - Pos({$If CompilerVersion > 19}FormatSettings.{$EndIf}ThousandSeparator, s);
      delete(s, 1, Pos({$If CompilerVersion > 19}FormatSettings.{$EndIf}ThousandSeparator, s));
    End;

    If (mdist > 3) Then
    Begin
      Result := True;
    End;
  End;

Begin
  If Not EditorEnabled Then
    Exit;

  IsCtrl := GetKeyState(VK_CONTROL) And $8000 = $8000;

  If (SelLength = length(Text)) And (Text <> '') Then
    FBlockChange := True;

  If (Msg.CharCode = VK_RETURN) And IsCtrl Then
  Begin
    Msg.CharCode := 0;
    Msg.Result := 1;
    Exit;
  End;

  If Msg.CharCode = VK_RETURN Then
  Begin
    key := #13;
    If Assigned(OnKeyPress) Then
      OnKeyPress(Self, key);

    Msg.CharCode := 0;

    If Not DefaultHandling Then
    Begin
      If (Parent Is TWinControl) Then
      Begin
        PostMessage((Parent As TWinControl).Handle, WM_KEYDOWN, VK_RETURN, 0);

        cf := GetParentForm(self);

        If Assigned(cf) Then
          If cf.KeyPreview Then
          Begin
            InHerited;
            Exit;
          End;

        PostMessage((Parent As TWinControl).Handle, WM_KEYUP, VK_RETURN, 0);
      End;
    End;
    Exit;
  End;

  If Msg.CharCode = VK_ESCAPE Then
  Begin
    If Not DefaultHandling Then
    Begin
      If (Parent Is TWinControl) Then
      Begin

        cf := GetParentForm(self);

        If Assigned(cf) Then
          If cf.KeyPreview Then
          Begin
            InHerited;
            Exit;
          End;

        PostMessage((Parent As TWinControl).Handle, WM_KEYDOWN, VK_ESCAPE, 0);
        PostMessage((Parent As TWinControl).Handle, WM_KEYUP, VK_ESCAPE, 0);
      End;
    End;
  End;

  If (Msg.Charcode = VK_ESCAPE) And Not FCanUndo Then
  Begin
    InHerited;
    Exit;
  End;

// allow Ctrl-C, Ctrl-X, Ctrl-V
  If IsCtrl And (Msg.CharCode In [3, 22, 24]) Then
  Begin
    InHerited;
    Exit;
  End;

  If (msg.charcode = ord('.')) And (FExcelStyleDecimalSeparator) And (msg.keydata And $400000 = $400000) Then
  Begin
    msg.charcode := ord({$If CompilerVersion > 19}FormatSettings.{$EndIf}DecimalSeparator);
  End;

  If (msg.charcode = ord(',')) And (FExcelStyleDecimalSeparator) And (msg.keydata And $400000 = $400000) Then
  Begin
    msg.charcode := ord({$If CompilerVersion > 19}FormatSettings.{$EndIf}DecimalSeparator);
  End;

  If (msg.CharCode = vk_back) And (FPrefix <> '') Then
    If (SelStart <= Length(FPrefix)) And (SelLength = 0) Then
      Exit;

  If (FLengthLimit > 0) And (FixedLength(self.Text) > FLengthLimit) And
    (SelLength = 0) And (SelStart < DecimalPos)
    And (msg.charcode <> vk_back) And (msg.charcode <> ord({$If CompilerVersion > 19}FormatSettings.{$EndIf}DecimalSeparator)) And Not AllowMin(chr(msg.CharCode)) Then
    Exit;

  If (msg.charcode = vk_back) Then
  Begin
    s := self.Text;
    If SelLength = 0 Then
      delete(s, SelStart - Length(fprefix), 1)
    Else
      delete(s, SelStart - Length(fprefix), SelLength);

    InHerited;
    If (Text = '') And (s <> '') Then
      Change;

    //if (lengthlimit > 0) and (fixedLength(s) - 1 > lengthlimit) then
    Exit;
  End;

  If IsCtrl And (Msg.CharCode = 10) Then
    Exit;

  If (EditType In [etMoney, etNumeric, etFloat]) And Not FSigned And (msg.charcode = ord('-')) Then
    Exit;

  Case EditType Of
    etString, etPassword:
    Begin
      SetModified(True);
      InHerited;
    End;

    etAlphaNumeric:
    Begin
      If msg.charcode In AlphaNum_Codes + Ctrl_Codes Then
      Begin
        SetModified(True);
        InHerited;
      End;
    End;

    etValidChars:
    Begin
      If (pos(chr(msg.CharCode), ValidChars) > 0) Or (msg.CharCode = 8) Then
      Begin
        SetModified(True);
        InHerited;
      End;
    End;

    etNumeric:
    Begin
      If (msg.CharCode = ord('-')) Then
      Begin
        If (SelLength = Length(self.Text)) Then
        Begin
          InHerited Text := '-';
          SelStart := 1;
          Exit;
        End;

        s := self.Text;
        oldSelStart := SelStart;
      // oldSelLength := SelLength;
        If (Pos('-', s) > 0) Then
        Begin
          delete(s, 1, 1);
          InHerited Text := s + Suffix;
          If (oldSelStart > 0) And (oldSelStart > Length(fPrefix)) Then
            SelStart := oldSelStart - 1
          Else
            SelStart := Length(Prefix);
          SelLength := 0;
        End
        Else
        Begin
          InHerited Text := '-' + self.Text + Suffix;
          SelLength := 0;
          SelStart  := oldSelStart + 1;
          SetModified(True);
        End;
      // SelLength := oldSelLength;
      End
      Else
      Begin
        If (msg.charcode In Numeric_Codes + Ctrl_Codes) Then
          InHerited;

        If ((GetKeyState(vk_rcontrol) And $8000 = $8000) Or
          (GetKeyState(vk_lcontrol) And $8000 = $8000)) Then
          InHerited;
      End;
    End;

    etHex:
    If msg.charcode In Hex_Codes + Ctrl_Codes Then
    Begin
      SetModified(True);
      InHerited;
    End;

    etRange:
    Begin
      If msg.charcode In Range_Codes + Ctrl_Codes Then
      Begin
        SetModified(True);
        s := (InHerited Text) + ' ';
        If (msg.charcode In [ord('-'), ord(','), ord(';')]) Then
        Begin
          If (SelStart <= Length(fPrefix)) Then
            Exit;
          If (SelStart > Length(fPrefix)) And (CheckSeparator(s[SelStart])) Then
            Exit;
          If (SelStart > Length(fPrefix)) And (CheckSeparator(s[SelStart + 1])) Then
            Exit;
          InHerited;
        End
        Else
          InHerited;
      End;
    End;
    
    etMoney:
    Begin
      If (chr(msg.charcode) = {$If CompilerVersion > 19}FormatSettings.{$EndIf}DecimalSeparator) And
         ((Pos({$If CompilerVersion > 19}FormatSettings.{$EndIf}DecimalSeparator, self.Text) > 0) Or (FPrecision = 0)) Then
      Begin
        If (FPrecision > 0) Then
        Begin
          If SelLength = Length(Text) Then
            Text := '0,0';
          SelectAfterDecimal;
        End;
        Exit;
      End;

      If (msg.charcode In Money_Codes + Ctrl_Codes) Or (chr(msg.charcode) = {$If CompilerVersion > 19}FormatSettings.{$EndIf}DecimalSeparator) Then
      Begin
        If (chr(msg.charcode) = {$If CompilerVersion > 19}FormatSettings.{$EndIf}ThousandSeparator) Or (chr(msg.charcode) = {$If CompilerVersion > 19}FormatSettings.{$EndIf}DecimalSeparator) Then
        Begin
          If scandistance(self.Text, SelStart) Then
            Exit;
        End;

        If scanprecision(self.Text, SelStart) And (msg.charcode In [$30..$39, ord({$If CompilerVersion > 19}FormatSettings.{$EndIf}DecimalSeparator)]) And (SelLength = 0) Then
        Begin
          If (FPrecision > 0) And (SelStart - Length(fprefix) >= Pos({$If CompilerVersion > 19}FormatSettings.{$EndIf}DecimalSeparator, self.text))
            And (msg.charcode In [$30..$39]) And (SelStart - Length(fprefix) < Length(self.text)) Then
          Begin
            SelLength := 1;
          End
          Else
            Exit;
        End;

        If (SelStart = 0) And (self.Text = '') And (msg.charcode = ord({$If CompilerVersion > 19}FormatSettings.{$EndIf}DecimalSeparator)) Then
        Begin
          InHerited Text := '0' + {$If CompilerVersion > 19}FormatSettings.{$EndIf}DecimalSeparator;
          SelStart := 2;
          SetModified(True);
          Exit;
        End;

        If (msg.charcode = ord('-')) And (SelLength = 0) Then
        Begin
          s := self.Text;
          oldprec := FPrecision;
          FPrecision := 0;
          oldSelStart := SelStart;

          If (Pos('-', s) <> 0) Then
          Begin
            delete(s, 1, 1);
            InHerited Text := s + Suffix;
            SetModified(True);
            If (oldSelStart > 0) And (oldSelStart > Length(fPrefix)) Then
              SelStart := oldSelStart - 1
            Else
              SelStart := Length(Prefix);
          End
          Else
          Begin
            If (Floatvalue <> 0) Or (1 > 0) Then
            Begin
              InHerited Text := '-' + self.Text + Suffix;
              SelLength := 0;
              SelStart  := oldSelStart + 1;
              SetModified(True);
            End;
          End;
          FPrecision := oldprec;
          Exit;
        End;

        InHerited;

        If (self.Text <> '') And (self.Text <> '-') And
          (chr(msg.charcode) <> {$If CompilerVersion > 19}FormatSettings.{$EndIf}DecimalSeparator) Then
        Begin
          If InHerited Modified Then
            SetModified(True);

          AutoSeparators;

        End;
      End;
    End;

    etFloat:
    Begin
      If (msg.charcode = ord(',')) And ({$If CompilerVersion > 19}FormatSettings.{$EndIf}DecimalSeparator <> ',') And ({$If CompilerVersion > 19}FormatSettings.{$EndIf}ThousandSeparator <> ',') Then
        Exit;
      If (msg.charcode = ord('.')) And ({$If CompilerVersion > 19}FormatSettings.{$EndIf}DecimalSeparator <> '.') And ({$If CompilerVersion > 19}FormatSettings.{$EndIf}ThousandSeparator <> '.') Then
        Exit;

      If (msg.charcode In Float_Codes + Ctrl_Codes) Then
      Begin
        If (chr(msg.charcode) = {$If CompilerVersion > 19}FormatSettings.{$EndIf}DecimalSeparator) And
          (Pos({$If CompilerVersion > 19}FormatSettings.{$EndIf}DecimalSeparator, self.getseltext) = 0) And
          ((Pos({$If CompilerVersion > 19}FormatSettings.{$EndIf}DecimalSeparator, self.Text) > 0) Or (FPrecision = 0)) Then
        Begin
          If (FPrecision > 0) Then
            SelectAfterDecimal;
          Exit;
        End;

        If ((msg.charcode = ord(',')) And (Pos(',', self.Text) > 0) And (Pos(',', self.getSelText) = 0)) And
          (chr(msg.charcode) <> {$If CompilerVersion > 19}FormatSettings.{$EndIf}ThousandSeparator) Then
          exit;

        If (chr(msg.charcode) = {$If CompilerVersion > 19}FormatSettings.{$EndIf}ThousandSeparator) Or (chr(msg.charcode) = {$If CompilerVersion > 19}FormatSettings.{$EndIf}DecimalSeparator) Then
        Begin
          If scandistance(self.Text, SelStart) Then
            exit;
        End;

        If ScanPrecision(self.text, SelStart) And (msg.charcode In [$30..$39, ord({$If CompilerVersion > 19}FormatSettings.{$EndIf}DecimalSeparator)]) And (SelLength = 0) Then
        Begin
          If (FPrecision > 0) And (SelStart - Length(fprefix) >= Pos({$If CompilerVersion > 19}FormatSettings.{$EndIf}DecimalSeparator, self.Text))
            And (msg.CharCode In [$30..$39]) And (SelStart - Length(fprefix) < Length(self.Text)) Then
          Begin
            SelLength := 1;
          End
          Else
            Exit;
        End;

        If (SelStart = 0) And (self.Text = '') And (msg.charcode = ord({$If CompilerVersion > 19}FormatSettings.{$EndIf}DecimalSeparator)) Then
        Begin
          InHerited Text := '0' + {$If CompilerVersion > 19}FormatSettings.{$EndIf}DecimalSeparator;
          SelStart := 2;
          SetModified(True);
          Exit;
        End;

        If (msg.charcode = ord('-')) And (SelLength = 0) Then
        Begin
          s := self.Text;
          oldprec := FPrecision;
          FPrecision := 0;
          oldSelStart := SelStart;

          If (Pos('-', s) <> 0) Then
          Begin
            delete(s, 1, 1);
            InHerited Text := s + Suffix;
            If (oldSelStart > 0) And (oldSelStart > Length(fPrefix)) Then
              SelStart := oldSelStart - 1
            Else
              SelStart := Length(Prefix);
            SetModified(True);
          End
          Else
          Begin
            If (floatvalue <> 0) Or (1 > 0) Then
            Begin
              InHerited Text := '-' + self.text + Suffix;
              SelLength := 0;
              SelStart  := oldSelStart + 1;
              SetModified(True);
            End;
          End;
          FPrecision := oldprec;
          Exit;
        End;
        InHerited;
      End;
    End;

    etUppercase:
    Begin
      s := AnsiUpperCase(chr(msg.charcode));
      msg.charcode := ord(s[1]);
      InHerited;
    End;

    etLowercase:
    Begin
      s := AnsiLowerCase(chr(msg.charcode));
      msg.charcode := ord(s[1]);
      InHerited;
    End;
    
    etMixedCase:
    Begin
      oldSelStart := SelStart;
      InHerited;
      InHerited Text := ShiftCase(self.text);
      SelStart := oldSelStart + 1;
    End;
  End;

  If InHerited Modified Then
    SetModified(True);

  UpdateLookup;
End;

Procedure THsVTCustomEdit.WMCut(Var Message: TWMCut);
Var
  Allow: Boolean;
Begin
  If Not FEditorEnabled Or ReadOnly Then
    Exit;

  Allow := True;
  FBlockCopy := True;
  If Assigned(FOnClipboardCut) Then
  Begin
    FOnClipboardCut(self, copy(self.text, SelStart + 1 - Length(fPrefix), SelLength), allow);
  End;
  If Allow Then
    InHerited;

  FBlockCopy := False;
End;

Procedure THsVTCustomEdit.WMPaste(Var Message: TWMPaste);
Var
{$IFNDEF DELPHI_UNICODE}
  Data: THandle;
  content: PAnsiChar;
{$ENDIF}
  newstr: String;
  newss, newsl, i: Integer;
  allow: Boolean;

  Function InsertString(s: String): String;
  Var
    ss: Integer;
  Begin
    Result := self.text;
    ss := SelStart - Length(fPrefix);
    If (SelLength = 0) Then
    Begin
      insert(s, result, ss + 1);
      newsl := 0;
      newss := ss + Length(s) + Length(fPrefix);
    End
    Else
    Begin
      delete(result, ss + 1, SelLength);
      insert(s, result, ss + 1);
      newsl := Length(s);
      newss := ss + Length(fPrefix);
    End;
  End;

Begin
  if ReadOnly then
    Exit;

  {$IFDEF DELPHI_UNICODE}
  if ClipBoard.HasFormat(CF_TEXT) then
  begin
    Allow := True;
    newstr := InsertString(Clipboard.AsText);
  {$ENDIF}
{$IFNDEF DELPHI_UNICODE}

  if ClipBoard.HasFormat(CF_TEXT) then
  begin
    ClipBoard.Open;
    Data := GetClipBoardData(CF_TEXT);
    try
      if Data <> 0 then
        Content := PAnsiChar(GlobalLock(Data))
      else
        Content := nil
    finally
      if Data <> 0 then
        GlobalUnlock(Data);
      ClipBoard.Close;
    end;

    if Content = nil then
      Exit;

    Allow := True;

    newstr := InsertString(StrPas(Content));

{$ENDIF}

    if Assigned(FOnClipboardPaste) then
      FOnClipboardPaste(self, newstr, Allow);

    if not Allow then Exit;

    if MaxLength > 0 then
    begin
{$IFNDEF DELPHI_UNICODE}
      if Length(StrPas(Content)) + Length(Self.Text) - SelLength > MaxLength then
        Exit;
{$Else}
      if Length(Clipboard.AsText) + Length(Self.Text) - SelLength > MaxLength then
        Exit;
{$ENDIF}
    end;

    case FEditType of
      etAlphaNumeric:
        begin
          Allow := True;
          for i := 1 to length(newstr) do
            if not (ord(newstr[i]) in AlphaNum_Codes) then
              Allow := False;

          if Allow then
          begin
            Self.Text := newstr;
            SetModified(True);
          end;
        end;
      etNumeric:
        begin
          if IsType(newstr) = atNumeric then
          begin
            if not (not Signed and (pos('-', newstr) > 0)) then
            begin
              self.Text := newstr;
              SetModified(True);
            end;
          end;
        end;
      etFloat, etMoney:
        begin
          if IsType(newstr) in [atFloat, atNumeric] then
          begin
{$IFNDEF DELPHI_UNICODE}
            if not ((FPrecision = 0) and (Pos({$If CompilerVersion > 19}FormatSettings.{$EndIf}DecimalSeparator, StrPas(Content)) > 0)) then
              begin
                if not (not Signed and (pos('-', newstr) > 0)) then
                begin
                  self.Text := newstr;
                  Floatvalue := Floatvalue;
                  SetModified(True);
                end;
              end;
{$Else}
            if not ((FPrecision = 0) and (Pos({$If CompilerVersion > 19}FormatSettings.{$EndIf}DecimalSeparator, Clipboard.AsText) > 0)) then
              begin
                if not (not Signed and (pos('-', newstr) > 0)) then
                begin
                  self.Text := newstr;
                  Floatvalue := Floatvalue;
                  SetModified(True);
                end;
              end;
{$ENDIF}
          end;
        end;
      etString, etPassWord: self.Text := NewStr;
      etLowerCase: self.Text := AnsiLowerCase(NewStr);
      etUpperCase: self.Text := AnsiUpperCase(NewStr);
      etMixedCase: self.Text := ShiftCase(NewStr);
      etValidChars:
        begin
          Allow := true;
          for i := 1 to length(newstr) do
          begin
            if pos(newstr[i], ValidChars) = 0 then
            begin
              Allow := false;
              break;
            end;
          end;
          if Allow then
          begin
            self.Text := newstr;
            SetModified(True);
          end;
        end;
    end;

    if (FEditType = etMoney) and (Length(self.Text) > 3) then
      SelectAll
    else
    begin
      SelStart := newss;
      SelLength := newsl;
    end;

    if FEditType in [etString, etPassWord, etLowerCase, etUpperCase, etMixedCase] then
      SetModified(true);
  end;

  UpdateLookup;
End;

Procedure THsVTCustomEdit.LabelClick(Sender: TObject);
Begin
  If Assigned(FOnLabelClick) Then
    FOnLabelClick(Self);
End;

Procedure THsVTCustomEdit.LabelDblClick(Sender: TObject);
Begin
  If Assigned(FOnLabelDblClick) Then
    FOnLabelDblClick(Self);
End;

Procedure THsVTCustomEdit.LabelFontChange(Sender: TObject);
Begin
  If FLabel <> Nil Then
  Begin
    UpdateLabel();
    If (csDesigning In ComponentState) And Not (csLoading In ComponentState) Then
      ParentFont := False;
  End;
End;

Procedure THsVTCustomEdit.Loaded();
Begin
  InHerited;
  FParentFnt := self.ParentFont;

  SetEditRect;
  ResizeControl();

  If Not LabelAlwaysEnabled And Assigned(FLabel) Then
    FLabel.Enabled := Enabled;

  If (FLabel <> Nil) Then
    UpdateLabel();

  If ParentFont And Assigned(FLabel) Then
    FLabel.Font.Assign(Font);
End;

Procedure THsVTCustomEdit.CMEnter(Var Message: TCMGotFocus);
Begin
  If AutoSelect And Not (csLButtonDown In ControlState) Then
    SelectAll();
  InHerited;
  DrawBorders();
End;

Procedure THsVTCustomEdit.CMExit(Var Message: TCMExit);
Begin
  InHerited;
  DrawBorders();
End;

Procedure THsVTCustomEdit.CMMouseEnter(Var Message: TMessage);
Begin
  InHerited;
  If Not FMouseInControl And Enabled Then
  Begin
    FMouseInControl := True;
    DrawBorders();
  End;
End;

Procedure THsVTCustomEdit.CMMouseLeave(Var Message: TMessage);
Begin
  InHerited;
  If FMouseInControl And Enabled Then
  Begin
    FMouseInControl := False;
    DrawBorders();
  End;
End;

Procedure THsVTCustomEdit.CMParentFontChanged(Var Message: TMessage);
Begin
  InHerited;
  If Assigned(FLabel) And ParentFont Then
  Begin
    FLabel.Font.Assign(Font);
    UpdateLabel();
  End;
End;

Procedure THsVTCustomEdit.CMVisibleChanged(Var Message: TMessage);
Begin
  InHerited;

  If LabelCaption <> '' Then
    FLabel.Visible := Self.Visible;
End;

Procedure THsVTCustomEdit.SetEtched(Const Value: Boolean);
Begin
  If FEtched <> Value Then
  Begin
    FEtched := Value;
    Invalidate();
  End;
End;

Function THsVTCustomEdit.Is3DBorderControl: Boolean;
Begin
  If csDesigning In ComponentState Then
    Result := False
  Else
    Result := FMouseInControl Or (Screen.ActiveControl = Self);
End;

Procedure THsVTCustomEdit.DoEnter;
Begin
  InHerited;
  SetEditRect();
End;

Procedure THsVTCustomEdit.DrawControlBorder(DC: HDC);
Var
  ARect:TRect;
  BtnFaceBrush, WindowBrush: HBRUSH;
Begin
  If (csDesigning In ComponentState) Then
    Exit;

  If (FBorderColor <> clNone) Then
  Begin
    If (GetFocus <> Handle) Or (FFocusBorderColor = clNone) Then
    Begin
      BtnFaceBrush := CreateSolidBrush(ColorToRGB(FBorderColor));
      GetWindowRect(Handle, ARect);
      OffsetRect(ARect, -ARect.Left, -ARect.Top);
      FrameRect(DC, ARect, BtnFaceBrush);
      DeleteObject(BtnFaceBrush);
      Exit;
    End;
  End;

  If (FFocusBorderColor <> clNone) Then
  Begin
    If (GetFocus = Handle) Then
    Begin
      BtnFaceBrush := CreateSolidBrush(ColorToRGB(FFocusBorderColor));
      GetWindowRect(Handle, ARect);
      OffsetRect(ARect, -ARect.Left, -ARect.Top);
      FrameRect(DC, ARect, BtnFaceBrush);
      DeleteObject(BtnFaceBrush);
    End;
    Exit;
  End;

  If Is3DBorderControl Then
    BtnFaceBrush := CreateSolidBrush(GetSysColor(COLOR_BTNFACE))
  Else
    BtnFaceBrush := CreateSolidBrush(ColorToRGB((parent As TWinControl).brush.color));

  WindowBrush := CreateSolidBrush(GetSysColor(COLOR_WINDOW));

  Try
    GetWindowRect(Handle, ARect);
    OffsetRect(ARect, -ARect.Left, -ARect.Top);
    If Is3DBorderControl Then
    Begin
      DrawEdge(DC, ARect, BDR_SUNKENOUTER, BF_RECT Or BF_ADJUST);
      FrameRect(DC, ARect, BtnFaceBrush);
      InflateRect(ARect, -1, -1);
    End
    Else
    Begin
      FrameRect(DC, ARect, BtnFaceBrush);
      InflateRect(ARect, -1, -1);
      FrameRect(DC, ARect, BtnFaceBrush);
      InflateRect(ARect, -1, -1);
    End;

    Finally
      DeleteObject(WindowBrush);
      DeleteObject(BtnFaceBrush);
  End;
End;

Procedure THsVTCustomEdit.DrawBorders();
Var DC : HDC;
Begin
  If Enabled And Not (FFlat Or (FBorderColor <> clNone) Or (FFocusBorderColor <> clNone)) Then
    Exit;

  DC := GetWindowDC(Handle);
  Try
    DrawControlBorder(DC);

    Finally
      ReleaseDC(DC, Handle);
  End;
End;

Procedure THsVTCustomEdit.CMFontChanged(Var Message: TMessage);
Begin
  InHerited;
  If HandleAllocated Then
    SetEditRect();
End;

Procedure THsVTCustomEdit.WMSetFocus(Var Message: TWMSetFocus);
Begin
  If ComponentState * [csLoading] = [] Then
  Begin
    InHerited;

    If Not EditorEnabled Then
    Begin
      HideCaret(Handle);
      Invalidate();
      Exit;
    End;

    FOldString := Self.Text;

    If AutoSelect Then
      SelectAll()
    Else If EditType In [etFloat, etMoney] Then
      SelectBeforeDecimal();
  End;
End;

Procedure THsVTCustomEdit.SetEditType(Const Value: TDropDownEditType);
Var
  at: TAutoType;
Begin
  If FEditType <> Value Then
  Begin
    FEditType := Value;
    If FEditType = etPassword Then
    Begin
      PassWordChar := '*';
      FCanUndo := False;
      ReCreateWnd();
    End
    Else
      Passwordchar := #0;

    at := IsType(self.Text);
    Case FEditType Of
      etHex:
        If Not (at In [atNumeric, atHex]) Then
          self.IntValue := 0;
      etNumeric:
        If (at <> atNumeric) Then
          self.IntValue := 0;
      etFloat, etMoney:
        If Not (at In [atFloat, atNumeric]) Then
          self.FloatValue := 0.0;
    End;

    If (csDesigning In ComponentState) And (FEditType = etFloat) And (Precision = 0) Then
      Precision := 2;
  End;
End;

Procedure THsVTCustomEdit.WMKillFocus(Var Msg: TWMKillFocus);
Var
  OldModified: Boolean;
Begin
  If (csLoading In ComponentState) Then
    Exit;

  If (FPrecision > 0) And (EditType In [etFloat, etMoney]) Then
  Begin
    If (self.Text <> '') Or Not FAllowNumericNullValue Then
    Begin
      // update for precision
      OldModified := Modified;
      Floatvalue := self.Floatvalue;
      Modified := OldModified;
    End;
  End;

  If (EditType In [etNumeric]) And (Self.Text = '') And Not FAllowNumericNullValue Then
    Text := '0';

  If (EditType In [etFloat, etMoney]) And (Self.Text = '') And Not FAllowNumericNullValue  Then
    Floatvalue := 0.0;

  InHerited;

  If Not EditorEnabled Then
    Invalidate();
End;

Function THsVTCustomEdit.GetText: String;
Var
  s: String;
Begin
  s := InHerited Text;
  If (fPrefix <> '') And (Pos(fPrefix, s) = 1) Then
    delete(s, 1, Length(fPrefix));
  If (fSuffix <> '') Then
    delete(s, Length(s) - Length(fSuffix) + 1, Length(fSuffix));
  Result := s;
End;

Procedure THsVTCustomEdit.SetText(Value: String);
Var
  fmt, neg: String;
  f: Extended;
Begin
  If (value = '') Then
  Begin
    Case FEditType Of
      etFloat:
        If Not (IsType(value) In [atFloat, atNumeric]) Then
          value := '0';
      etMoney:
        If Not (IsType(value) In [atFloat, atNumeric]) Then
          value := '0';
      etHex:
        If Not (IsType(value) In [atHex, atNumeric]) Then
          value := '0';
      etNumeric:
        If Not (IsType(value) In [atNumeric]) Then
          value := '0';
    End;
  End;

  If (FPrecision > 0) And (Value <> '') And (Value <> ErrText) Then
  Begin
    If (FEditType In [etMoney]) Then
    Begin
      If (Pos('-', value) > 0) Then
        neg := '-' Else neg := '';
      fmt := '%.' + IntToStr(FPrecision) + 'n';
      Value := Format(fmt, [EStrToFloat(Value)]);
    End;

    If (FEditType In [etFloat]) Then
    Begin
      fmt := '%.' + inttostr(FPrecision) + 'f';
      f := EStrToFloat(value);
      Value := Format(fmt, [f]);
    End;
  End;

  If (FEditType In [etHex]) Then
    Value := AnsiUpperCase(value);

  InHerited Text := FPrefix + Value + FSuffix;

  FOldText := Value;

  SetModified(False);
End;

Procedure THsVTCustomEdit.SetTextDirect(s: String);
Begin
  InHerited Text := s;
End;

Procedure THsVTCustomEdit.SetParent(AParent: TWinControl);
Begin
  InHerited;
  If FLabel <> Nil Then
    FLabel.Parent := AParent;
End;

Procedure THsVTCustomEdit.SetPrecision(Const Value: Smallint);
Var
  at: TAutoType;
Begin
  If (FPrecision <> value) And (editType In [etFloat, etMoney, etString]) Then
  Begin
    FPrecision := Value;
    at := IsType(self.text);
    If (at In [atFloat, atNumeric]) Then
      FloatValue := FloatValue
    Else
      FloatValue := 0.0;
  End;
End;

Procedure THsVTCustomEdit.SetPrefix(Const Value: String);
Var
  s: String;
Begin
  s := self.Text;
  fPrefix := Value;
  InHerited Text := s;
  Text := s;
End;

Procedure THsVTCustomEdit.SetSuffix(Const Value: String);
Var
  s: String;
Begin
  s := self.text;
  fSuffix := Value;
  InHerited Text := s;
  Text := s;
End;

Procedure THsVTCustomEdit.SelectAll();
Begin
  SelStart := 0;
  SelLength := Length(self.text);

  If (fPrefix <> '') Then
  Begin
    If (SelStart < Length(fPrefix)) Then
    Begin
      SelStart := Length(fPrefix);
      SelLength := Length(self.Text);
    End;
  End;

  If (fSuffix <> '') Then
  Begin
    SelStart := Length(fPrefix);
    SelLength := Length(self.Text);
  End;
End;

Procedure THsVTCustomEdit.SelectAfterDecimal;
Var
  i: Integer;
Begin
  i := Pos({$If CompilerVersion > 19}FormatSettings.{$EndIf}DecimalSeparator, self.Text);

  If (i > 0) Then
    SelStart := i + Length(fPrefix)
  Else
    SelStart := Length(fPrefix);
End;

Procedure THsVTCustomEdit.SelectBeforeDecimal;
Var
  i: Integer;
Begin
  i := Pos({$If CompilerVersion > 19}FormatSettings.{$EndIf}DecimalSeparator, self.text);
  If (i > 0) Then
    SelStart := i + Length(fPrefix) - 1
  Else
    SelStart := Length(fPrefix);
End;

Procedure THsVTCustomEdit.WMCopy(Var Message: TWMCopy);
Var
  Allow: Boolean;
Begin
  Allow := True;
  If Assigned(FOnClipboardCopy) And Not FBlockCopy Then
    FOnClipboardCopy(self, copy(self.Text, SelStart + 1 - Length(fPrefix), SelLength), allow);
  FBlockCopy := False;  
  If Allow Then
    InHerited;
End;

Procedure THsVTCustomEdit.WMLButtonDblClk(Var Message: TWMLButtonDblClk);
Begin
  InHerited;
End;

Procedure THsVTCustomEdit.WMLButtonDown(Var Msg: TWMMouse);
Var
  uchar: Integer;
Begin
  If Not EditorEnabled Then
  Begin
    InHerited;
//??    MouseButtonDown(Nil);
  End
  Else
  Begin
  {click outside selection}
    uchar := CharFromPos(point(msg.xpos, msg.ypos));

    If (SelLength <= 0) Or (uchar < SelStart) Or (uChar > SelStart + SelLength) Or
      (GetFocus <> self.Handle) Then
      InHerited
    Else
    If (uChar >= SelStart) And (uChar <= SelStart + SelLength) And (SelLength > 0) Then
      FButtonDown := True;
  End;
End;

Procedure THsVTCustomEdit.WMLButtonUp(Var Msg: TWMMouse);
Var
  uchar: Integer;

Begin
  If Not EditorEnabled Or ReadOnly Then
    DrawBackGround();
  
  If fButtonDown Then
  Begin
    uchar := CharFromPos(point(msg.xpos, msg.ypos));
    SelStart := uChar;
    SelLength := 0;
  End;

  fButtonDown := False;

  InHerited;
  If (fPrefix <> '') Then
  Begin
    If (SelStart < Length(fPrefix)) Then
    Begin
      SelStart := Length(fPrefix);
      SelLength := Length(self.Text);
    End;
  End;
  If (fSuffix <> '') Then
  Begin
    If (SelStart > Length(self.text)) Then
    Begin
      SelStart := Length(self.Text);
      SelLength := 0;
    End;
    If (SelStart + SelLength > Length(self.text)) Then
    Begin
      SelLength := Length(self.Text) - SelStart;
    End;
  End;
End;

Procedure THsVTCustomEdit.WMNCPaint(Var Message: TMessage);
Begin
  InHerited;
  If (FFocusBorderColor <> clNone) Or (FBorderColor <> clNone) {or (not Enabled and DisabledBorder)} Then
    DrawBorders();
End;

Function THsVTCustomEdit.AllowMin(ch: Char): Boolean;
Begin
  Result := Signed And (EditType In [etFloat,etNumeric, etMoney]) And (ch = '-');
End;

Procedure THsVTCustomEdit.Assign(Source: TPersistent);
Var lSrc : THsVTCustomEdit;
Begin
  If (Source Is THsVTCustomEdit) Then
  Begin
    lSrc := (Source As THsVTCustomEdit);

    FFocusDraw := lSrc.FocusDraw;
    FForceShadow := lSrc.ForceShadow;

    FEditType := lSrc.EditType;
    FReturnIsTab := lSrc.ReturnIsTab;
    FLengthLimit := lSrc.LengthLimit;
    FPrecision := lSrc.Precision;
    FPrefix := lSrc.Prefix;
    FSuffix := lSrc.Suffix;
    FDefaultHandling := lSrc.DefaultHandling;
    FCanUndo := lSrc.CanUndo;
    FExcelStyleDecimalSeparator := lSrc.ExcelStyleDecimalSeparator;
    FValidChars := lSrc.ValidChars;

    FSigned := lSrc.Signed;
    FAutoThousandSeparator := lSrc.AutoThousandSeparator;

    FFlat := lSrc.Flat;

    FEditorEnabled := lSrc.EditorEnabled;

//    FEtched := lSrc.Etched;
    FImages  := lSrc.Images;

//    FSelectionColor := lSrc.SelectionColor;
//    FSelectionColorTo := lSrc.SelectionColorTo;
  End;
End;

Function THsVTCustomEdit.DecimalPos: Integer;
Var i : Integer;
Begin
  i := Pos({$If CompilerVersion > 19}FormatSettings.{$EndIf}DecimalSeparator, self.text);

  If (i = 0) Then
    Result := Length(fprefix) + Length(self.text) + Length(fSuffix) + 1
  Else
    Result := Length(fPrefix) + i;
End;

Function THsVTCustomEdit.FixedLength(s: String): Integer;
Var i : Integer;
Begin
  s := StripThousandSep(s);
  i := Pos({$If CompilerVersion > 19}FormatSettings.{$EndIf}DecimalSeparator, s);
  If (i > 0) Then
    Result := i
  Else
    Result := Length(s) + 1;

  If Signed And (EditType In [etFloat,etNumeric, etMoney]) And (pos('-',s) > 0) Then
    Result := Result - 1;
End;

Procedure THsVTCustomEdit.SetFloat(Const Value: Double);
Var
  s:String;
Begin
  Case FEditType Of
    etHex:
      self.Text := IntToHex(trunc(value), 0);
    etNumeric:
      If (FPrecision >= 0) Then
        self.Text := Format('%.' + inttostr(FPrecision) + 'n', [value])
      Else
        self.Text := Format('%g', [Value]);
    etFloat, etString:
      If (FPrecision >= 0) Then
      Begin
        s := Format('%.' + inttostr(FPrecision) + 'f', [value]);
        self.Text := s;
      End  
      Else
        self.Text := Format('%g', [Value]);
    etMoney:
    Begin
      If (FPrecision >= 0) Then
        self.Text := Format('%.' + inttostr(FPrecision) + 'f', [value]) Else self.Text := Format('%g', [Value]);
      AutoSeparators;
    End;
  End;
  SetModified(True);
End;

Procedure THsVTCustomEdit.SetFocusBorderColor(Const Value: TColor);
Begin
  FFocusBorderColor := Value;
End;

Procedure THsVTCustomEdit.SetInt(Const Value: Integer);
Begin
  Case FEditType Of
    etHex:
      self.Text := IntToHex(value, 0);
    etNumeric:
      self.Text := Inttostr(value);
    etFloat:
      self.Text := Inttostr(value);
    etMoney:
    Begin
      self.Text := IntToStr(value);
      AutoSeparators;
    End;
  End;
  SetModified(True);
End;

Procedure THsVTCustomEdit.SetLabelAlwaysEnabled(Const Value: Boolean);
Begin
  FLabelAlwaysEnabled := Value;
End;

Procedure THsVTCustomEdit.SetLabelCaption(Const Value: String);
Begin
  If FLabel = Nil Then
    FLabel := CreateLabel;
  FLabel.Caption := Value;
  UpdateLabel();
End;

Procedure THsVTCustomEdit.SetLabelFont(Const Value: TFont);
Begin
  If Not ParentFont Then
    FLabelFont.Assign(Value);

  If FLabel <> Nil Then
    UpdateLabel();
End;

Procedure THsVTCustomEdit.SetLabelMargin(Const Value: Integer);
Begin
  FLabelMargin := Value;
  If FLabel <> Nil Then
    UpdateLabel();
End;

Procedure THsVTCustomEdit.SetLabelPosition(Const Value: TLabelPosition);
Begin
  FLabelPosition := Value;
  If FLabel <> Nil Then
    UpdateLabel();
End;

Procedure THsVTCustomEdit.SetLabelTransparent(Const Value: Boolean);
Begin
  FLabelTransparent := Value;
  If FLabel <> Nil Then
    UpdateLabel();
End;

Procedure THsVTCustomEdit.AutoSeparators;
Var
  s, si, neg: String;
  d: Double;
  Diffl, OldSelStart, OldPrec: Integer;

Begin
  s := self.Text;
  Diffl := Length(s);
  OldSelStart := SelStart;

  If (s = '') Then
    Exit;

  If (Pos('-', s) = 1) Then
  Begin
    Delete(s, 1, 1);
    neg := '-';
  End
  Else
    neg := '';

  If (Pos({$If CompilerVersion > 19}FormatSettings.{$EndIf}DecimalSeparator, s) > 0) Then
    s := Copy(s, Pos({$If CompilerVersion > 19}FormatSettings.{$EndIf}DecimalSeparator, s), 255)
  Else
    s := '';

  d := Trunc(Abs(self.FloatValue));

  If FAutoThousandSeparator Then
    si := Format('%n', [d])
  Else
    si := Format('%f', [d]);

  si := Copy(si, 1, Pos({$If CompilerVersion > 19}FormatSettings.{$EndIf}DecimalSeparator, si) - 1);

  OldPrec := FPrecision;
  FPrecision := 0;

  FBlockChange := (Text <> FPrefix + neg + si + s + fSuffix);

  InHerited Text := FPrefix + neg + si + s + fSuffix;

  FPrecision := OldPrec;

  Diffl := Length(self.Text) - Diffl;

  SelStart := OldSelStart + Diffl;
  SelLength := 0;
End;

Function THsVTCustomEdit.GetModified: Boolean;
Begin
  Result := FIsModified;
End;

Procedure THsVTCustomEdit.SetModified(Const Value: Boolean);
Begin
  If csLoading In ComponentState Then
    Exit;

  If Not EditorEnabled Or ReadOnly Then
    Exit;

  InHerited Modified := value;
  FIsModified := value;
End;

Procedure THsVTCustomEdit.CNCommand(Var Message: TWMCommand);
Begin
  If (Message.NotifyCode = EN_CHANGE) Then
  Begin
    If FBlockChange Then
    Begin
      FBlockChange := False;
      Exit;
    End;
  End;

  InHerited;
End;

Procedure THsVTCustomEdit.CMWantSpecialKey(Var Msg: TCMWantSpecialKey);
Var IsPrev : Boolean;
    p      : TWinControl;
Begin
  p := Parent;
  While Assigned(p) And Not (p Is TCustomForm) Do
    p := p.Parent;

  If Not Assigned(p) Then
    Exit; 

  IsPrev := (p As TCustomForm).KeyPreview;

  If (Msg.CharCode = VK_ESCAPE) And FCanUndo And Not IsPrev Then
  Begin
    //Text := FOldString;
    //Font.Color := FFocusFontColor;
    SelectAll();
    SetModified(False);
    Msg.CharCode := 0;
    Msg.Result := 0;
    // Take care of default key handling
    If (Parent Is TWinControl) And FDefaultHandling Then
    Begin
      PostMessage((Parent As TWinControl).Handle, WM_KEYDOWN, VK_ESCAPE, 0);
      PostMessage((Parent As TWinControl).Handle, WM_KEYUP, VK_ESCAPE, 0);
    End;
  End;
  If (Msg.CharCode = VK_RETURN) And FDefaultHandling And Not IsPrev Then
  Begin
    // Take care of default key handling
    If (Parent Is TWinControl) Then
    Begin
      If (GetFocus = Parent.handle) Then
      Begin
        PostMessage((Parent As TWinControl).Handle, WM_KEYDOWN, VK_RETURN, 0);
        PostMessage((Parent As TWinControl).Handle, WM_KEYUP, VK_RETURN, 0);
      End;
    End;
  End;

  InHerited;
End;

Procedure THsVTCustomEdit.SetCanUndo(Const Value: Boolean);
Begin
  If FCanUndo <> Value Then
  Begin
    FCanUndo := Value;

    If FCanUndo And (FEditType = etPassWord) Then
      FCanUndo := False;
    ReCreateWnd();

    self.Width := self.Width + 1;
    self.Width := self.Width - 1;
  End;
End;

Function THsVTCustomEdit.GetFloat() : Double;
Var
  s: String;
  d: Double;
  e: Integer;
Begin
  Result := 0;
  Case FEditType Of
    etHex:
      If self.Text <> '' Then
        Result := HexToInt(self.Text);
    etString:
    Begin
      val(self.Text, d, e);
      Result := d;
    End;
    etNumeric, etFloat:
      If (Text <> '') And (Text <> ErrText) Then
      Begin
        s := self.Text;
        If (s = '-') Then
          Result := 0
        Else
          Result := EStrToFloat(s);
      End;  
    etMoney:
      If self.Text <> '' Then
      Begin
        s := StripThousandSep(self.Text);
        If (Pos({$If CompilerVersion > 19}FormatSettings.{$EndIf}DecimalSeparator, s) = Length(s)) Then
          Delete(s, Pos({$If CompilerVersion > 19}FormatSettings.{$EndIf}DecimalSeparator, s), 1);
        If (s = '') Or (s = '-') Then
          Result := 0 Else
          Result := EStrToFloat(s);
      End;
  End;
End;

Function ValStr(s: String): Integer;
Var
  err: Integer;
Begin
  val(s, result, err);
End;

Function THsVTCustomEdit.GetInt: Integer;
Begin
  Result := 0;
  Case FEditType Of
    etHex:
      If (self.Text <> '') Then
        Result := HexToInt(self.Text);
    etNumeric, etFloat:
      Result := ValStr(self.Text);
    etMoney:
      Result := ValStr(StripThousandSep(self.Text));
  End;
End;

Function THsVTCustomEdit.GetLabelCaption: String;
Begin
  If FLabel <> Nil Then
    Result := FLabel.Caption
  Else
    Result := '';
End;

Procedure THsVTCustomEdit.UpdateLabel();
Var
  tw: Integer;
  r:  TRect;

Begin
  FLabel.Transparent := FLabeltransparent;

  If Not FParentFnt Then
  Begin
    FLabel.Font.Assign(FLabelFont);
  End
  Else
    FLabel.Font.Assign(Font);

  tw := 0;
  If Assigned(FLabel.Parent) And FLabel.Parent.HandleAllocated  Then
  Begin
    r := Rect(0,0,1000,255);
    DrawText(FLabel.Canvas.Handle, PChar(FLabel.Caption), Length(FLabel.Caption), r, DT_HIDEPREFIX Or DT_CALCRECT);
    tw := r.Right;
  End;

  Case FLabelPosition Of
    lpLeftTop:
    Begin
      FLabel.Top := self.Top;
      FLabel.Left := self.Left - tw - FLabelMargin;
    End;
    lpLeftCenter:
    Begin
      If Self.Height > FLabel.Height Then
        FLabel.Top := self.Top + ((self.Height - FLabel.Height) Div 2)
      Else
        FLabel.Top := self.Top - ((FLabel.Height - self.Height) Div 2);
      FLabel.Left := self.Left - tw - FLabelMargin;
    End;
    lpLeftBottom:
    Begin
      FLabel.Top := self.Top + self.Height - FLabel.Height;
      FLabel.Left := self.Left - tw - FLabelMargin;
    End;
    lpTopLeft:
    Begin
      FLabel.Top := self.Top - FLabel.height - FLabelMargin;
      FLabel.Left := self.Left;
    End;
    lpTopRight:
    Begin
      FLabel.Top := self.Top - FLabel.height - FLabelMargin;
      FLabel.Left := self.Left + self.Width - FLabel.Width;
    End;
    lpTopCenter:
    Begin
      FLabel.Top := self.Top - FLabel.height - FLabelMargin;
      If self.Width - FLabel.Width > 0 Then
        FLabeL.Left := self.Left + ((self.Width - FLabel.Width) Div 2)
      Else
        FLabeL.Left := self.Left - ((FLabel.Width - self.Width) Div 2)
    End;
    lpBottomLeft:
    Begin
      FLabel.top := self.top + self.height + FLabelMargin;
      FLabel.left := self.left;
    End;
    lpBottomCenter:
    Begin
      FLabel.top := self.top + self.height + FLabelMargin;
      If self.Width - FLabel.Width > 0 Then
        FLabeL.Left := self.Left + ((self.Width - FLabel.width) Div 2)
      Else
        FLabeL.Left := self.Left - ((FLabel.Width - self.width) Div 2)
    End;
    lpBottomRight:
    Begin
      FLabel.top := self.top + self.height + FLabelMargin;
      FLabel.Left := self.Left + self.Width - FLabel.Width;
    End;
    lpLeftTopLeft:
    Begin
      FLabel.top := self.top;
      FLabel.left := self.left - FLabelMargin;
    End;
    lpLeftCenterLeft:
    Begin
      If Self.Height > FLabel.Height Then
        FLabel.Top := self.top + ((self.height - FLabel.height) Div 2)
      Else
        FLabel.Top := self.Top - ((FLabel.Height - self.Height) Div 2);
      FLabel.left := self.left - FLabelMargin;
    End;
    lpLeftBottomLeft:
    Begin
      FLabel.top := self.top + self.height - FLabel.height;
      FLabel.left := self.left - FLabelMargin;
    End;
    lpRightTop:
    Begin
      FLabel.Top := self.Top;
      FLabel.Left := self.Left + Self.Width + FLabelMargin;
    End;
    lpRightCenter:
    Begin
      If Self.Height > FLabel.Height Then
        FLabel.Top := self.Top + ((self.Height - FLabel.Height) Div 2)
      Else
        FLabel.Top := self.Top - ((FLabel.Height - self.Height) Div 2);

      FLabel.Left := self.Left + Self.Width + FLabelMargin;
    End;
    lpRighBottom:
    Begin
      FLabel.Top := self.Top + self.Height - FLabel.Height;
      FLabel.Left := self.Left + Self.Width + FLabelMargin;
    End;
  End;

  FLabel.Visible := Visible;
End;

Procedure THsVTCustomEdit.UpdateLookup;
Begin
End;

Function THsVTCustomEdit.EStrToFloat(s: String): Extended;
Begin
  If Pos({$If CompilerVersion > 19}FormatSettings.{$EndIf}ThousandSeparator, s) > 0 Then
    s := StripThousandSep(s);

  If (FPrecision > 0) And (Length(s) > FPrecision) Then
    If s[Length(s) - FPrecision] = {$If CompilerVersion > 19}FormatSettings.{$EndIf}Thousandseparator Then
      s[Length(s) - FPrecision] := {$If CompilerVersion > 19}FormatSettings.{$EndIf}DecimalSeparator;
  Try
    Result := StrToFloat(s);
  Except
    Result := 0;
  End;
End;

Function THsVTCustomEdit.CharFromPos(pt: TPoint): Integer;
Begin
  Result := Loword(SendMessage(self.Handle, EM_CHARFROMPOS, 0, makelparam(pt.x, pt.y)));
End;

Function THsVTCustomEdit.PosFromChar(uChar: Word): TPoint;
Var
  pt: tpoint;
  l:  Integer;
  DC: HDC;
  s:  String;
  sz: TSize;
Begin
  If uChar = 0 Then
    Result := Point(0, 0);

  l := SendMessage(Handle, EM_POSFROMCHAR, uChar, 0);
  pt := Point(loword(l), hiword(l));

  Result := pt;

  If (pt.x < 0) Or (pt.y < 0) Or (pt.x >= 65535) Or (pt.y >= 65535) Then
  Begin
    s := InHerited Text;

    If Length(s) = 0 Then
      Result := Point(0, 0)
    Else
    Begin
      dec(uChar);
      l := SendMessage(Handle, EM_POSFROMCHAR, uChar, 0);
      pt.x := loword(l);
      pt.y := hiword(l);

      Delete(s, 1, Length(s) - 1);
      DC := GetDC(Handle);
      GetTextExtentPoint32(DC, PChar(s + 'w'), 2, sz);
      pt.x := pt.x + sz.cx;
      GetTextExtentPoint32(DC, PChar(s), 2, sz);
      pt.x := pt.x - sz.cx;
      ReleaseDC(Handle, DC);
    End;

    Result := pt;
  End;
End;

Procedure THsVTCustomEdit.SetAutoThousandSeparator(
  Const Value: Boolean);
Begin
  FAutoThousandSeparator := Value;
  If FEditType In [etMoney, etFloat] Then
    AutoSeparators;
End;

Procedure THsVTCustomEdit.WMPaint(Var Message: TWMPaint);
Begin
  InHerited;
  DrawBackGround();

  If (FFocusBorderColor <> clNone) Or (FBorderColor <> clNone) Or (Not Enabled And DisabledBorder) Then
    DrawBorders();
End;

Function THsVTCustomEdit.GetBackGroundRect() : TRect;
Begin
  Result := Rect(2, 2, Width - 1, Height - 2);
End;

Procedure THsVTCustomEdit.DrawBackGround();
Var lDC     : HDC;
    lCanvas : TCanvas;
    lRect   : TRect;
    lFlag   : DWord;
Begin
  If Not FEditorEnabled And Focused And Not (csDesigning In ComponentState) And FFocusDraw Then
  Begin
    lDC := GetWindowDC(Handle);
    Try
      lCanvas := TCanvas.Create;
      Try
        lCanvas.Handle := lDC;

        lRect := GetBackGroundRect();
        lCanvas.Pen.Color := clBlack;
        lCanvas.Brush.Color := clHighlight;
        lCanvas.Rectangle(lRect);

        lRect.Left := lRect.Left + 2;
        lRect.Right := lRect.Right - 3;
        lCanvas.Font.Assign(Font);
        lCanvas.Font.Color := clHighlightText;
        lCanvas.Brush.Style := bsClear;

        lFlag := DT_SINGLELINE Or DT_VCENTER;
        Case FAlignment Of
          taLeftJustify  : lFlag := lFlag Or DT_LEFT;
          taRightJustify : lFlag := lFlag Or DT_RIGHT;
          taCenter       : lFlag := lFlag Or DT_CENTER;
        End;

        DrawText(lCanvas.Handle, PChar(Text), -1, lRect,  lFlag);

        Finally
          lCanvas.Free();
      End;

      Finally
        ReleaseDC(Handle,lDC);
    End;
  End
  Else If FRequired And (Text = '') And Not Focused Then
  Begin
    lDC := GetWindowDC(Handle);
    Try
      lCanvas := TCanvas.Create();
      Try
        lCanvas.Handle := lDC;

        lRect := GetBackGroundRect();

        lCanvas.Brush.Color := FRequiredColor;
        lCanvas.Pen.Color   := FRequiredColor;
        lCanvas.Rectangle(lRect);

        Finally
          lCanvas.Free();
      End;

      Finally
        ReleaseDC(Handle, lDC);
    End;
  End;
End;

Procedure THsVTCustomEdit.SetAlignment(Const Value : TAlignment);
Begin
  If Value <> FAlignment Then
  Begin
    FAlignment := Value;
    RecreateWnd();
  End;
End;

Procedure THsVTCustomEdit.SetBorderColor(Const Value: TColor);
Begin
  If (FBorderColor <> Value) Then
  Begin
    FBorderColor := Value;
    Invalidate();
  End;
End;

Procedure THsVTCustomEdit.SetRequired(Const Value : Boolean);
Begin
  If FRequired <> Value Then
  Begin
    FRequired := Value;
    Invalidate();
  End;
End;

Procedure THsVTCustomEdit.SetRequiredColor(Const Value : TColor);
Begin
  If FRequiredColor <> Value Then
  Begin
    FRequiredColor := Value;
    Invalidate();
  End;
End;

Procedure THsVTCustomEdit.SetBounds(ALeft, ATop, AWidth,
  AHeight: Integer);
Begin
  InHerited;

  If (FLabel <> Nil) And (FLabel.Parent <> Nil) Then
    UpdateLabel();
End;

Procedure THsVTCustomEdit.SetDisabledBorder(Const Value: Boolean);
Begin
  If (FDisabledBorder <> Value) Then
  Begin
    FDisabledBorder := Value;
    Invalidate();
  End;
End;

(******************************************************************************)

Constructor THsVTCustomButtonEdit.Create(AOwner: TComponent);
Begin
  InHerited Create(AOwner);

  FButton := Nil;
  FButtonWidth := DD_DROPDOWNBUTTONWIDTH;
  CreateDropDownButton();
End;

Destructor THsVTCustomButtonEdit.Destroy();
Begin
  FButton.Free();

  InHerited Destroy();
End;

Procedure THsVTCustomButtonEdit.DoOnButtonClick(Sender: TObject);
Begin
  If Assigned(FOnButtonClick) Then
    FOnButtonClick(Self);
End;

Procedure THsVTCustomButtonEdit.Assign(Source: TPersistent);
Var lSrc : THsVTCustomButtonEdit;
Begin
  InHerited Assign(Source);

  If Source Is THsVTCustomButtonEdit Then
  Begin
    lSrc := Source As THsVTCustomButtonEdit;

    ButtonWidth   := lSrc.ButtonWidth;
    ButtonHint    := lSrc.ButtonHint;
    ButtonCaption := lSrc.ButtonCaption;
    ButtonGlyph.Assign(lSrc.ButtonGlyph);
  End;
End;

Procedure THsVTCustomButtonEdit.WndProc(Var Message: TMessage);
Begin
  If Message.Msg = EM_SETREADONLY Then
  Begin
    InHerited;

    If Assigned(FButton) Then    
      FButton.Invalidate();
  End
  Else
    InHerited;
End;

Procedure THsVTCustomButtonEdit.DrawButtonBorder();
Begin
  If csDesigning In ComponentState Then
    FButton.Button.Focused := Enabled
  Else
    FButton.Button.Focused := MouseInControl Or (Screen.ActiveControl = Self);
End;

Procedure THsVTCustomButtonEdit.DrawBorders();
Var DC : HDC;
Begin
  If Enabled And Not (Flat Or (BorderColor <> clNone) Or (FocusBorderColor <> clNone)) Then
    Exit;

  DC := GetWindowDC(Handle);
  Try
    DrawControlBorder(DC);
    DrawButtonBorder();

    Finally
      ReleaseDC(DC, Handle);
  End;
End;

Function THsVTCustomButtonEdit.GetBackGroundRect() : TRect;
Begin
  Result := InHerited GetBackGroundRect();

  If FButton.Visible Then
    Result.Right := Result.Right - FButton.Width;
End;

Procedure THsVTCustomButtonEdit.CMEnabledChanged(Var Msg: TMessage);
Begin
  InHerited;

  If Assigned(FButton) Then
    FButton.Enabled := Self.Enabled;
End;

Procedure THsVTCustomButtonEdit.Loaded();
Begin
  InHerited Loaded();

  If Assigned(FButton) Then
    FButton.Enabled := Enabled;
End;

Procedure THsVTCustomButtonEdit.ResizeControl();
Var
  MinHeight: Integer;
  Dist,FlatCorr: Integer;
  Offs: Integer;
Begin
  If (BorderStyle = bsNone) Then
    Dist := 2
  Else
    Dist := 4;

  If Flat Then
    Dist := 3;

  If Flat Then
    FlatCorr := 1
  Else
    FlatCorr := -1;

  MinHeight := GetMinHeight;

  If Not Ctl3d Then
    Offs := 2
  Else
    Offs := 0;

  If (Height < MinHeight) Then
    Height := MinHeight
  Else If (FButton <> Nil) Then
  Begin
    If NewStyleControls And Ctl3D And (BorderStyle = bsSingle) Then
      FButton.SetBounds(Width - FButton.BWidth - Dist - Offs,1 + FlatCorr,FButton.BWidth,Height - Dist)
    Else
      FButton.SetBounds(Width - FButton.BWidth - Offs,1,FButton.BWidth,Height - 2);
    SetEditRect;
  End;

  Invalidate();
End;

Function THsVTCustomButtonEdit.GetButtonGlyph() : TBitmap;
Begin
  If Assigned(FButton) Then
    Result := FButton.Glyph
  Else
    Result := Nil;
End;

Procedure THsVTCustomButtonEdit.SetFlat(Const Value: Boolean);
Begin
  If InHerited Flat <> Value Then
  Begin
    InHerited Flat := Value;

    If Assigned(FButton) Then
      FButton.Button.Flat := True;
  End;
End;

Procedure THsVTCustomButtonEdit.SetEtched(Const Value: Boolean);
Begin
  If InHerited Etched <> Value Then
  Begin
    InHerited Etched := Value;

    FButton.Button.Etched := Value;
    Invalidate();
  End;
End;

Function THsVTCustomButtonEdit.GetButtonWidth() : Integer;
Begin
  Result := FButtonWidth;
End;

Procedure THsVTCustomButtonEdit.SetButtonWidth(Const Value: Integer);
Begin
  If Assigned(FButton) And (FButtonWidth <> Value) Then
  Begin
    FButtonWidth := Value;
    FButton.BWidth := Value;
    If FButton.HandleAllocated Then
      ResizeControl();
  End;
End;

Procedure THsVTCustomButtonEdit.SetButtonCaption(Const value: String);
Begin
  If Assigned(FButton) Then
    FButton.ButtonCaption := value;
End;

Function THsVTCustomButtonEdit.GetButtonCaption() : String;
Begin
  Result := '';
  If Assigned(FButton) Then
    Result := FButton.ButtonCaption;
End;

Procedure THsVTCustomButtonEdit.SetBorderColor(Const Value: TColor);
Begin
  If InHerited BorderColor <> Value Then
  Begin
    InHerited BorderColor := Value;
    Invalidate();
    FButton.Repaint();
  End;
End;

Procedure THsVTCustomButtonEdit.SetButtonGlyph(Const Value: TBitmap);
Begin
  If Assigned(FButton) Then
    FButton.Glyph.Assign(Value);
End;

Procedure THsVTCustomButtonEdit.SetButtonHint(Const Value: String);
Begin
  If FButtonHint <> Value Then
  Begin
    FButtonHint := Value;

    If Assigned(FButton) Then
    Begin
      FButton.Hint := Value;
      FButton.ShowHint := Value <> '';
    End;
  End;
End;

Procedure THsVTCustomButtonEdit.SetEditRect();
Var Loc: TRect;
Begin
  SendMessage(Handle, EM_GETRECT, 0, Longint(@Loc));

  Loc.Bottom := ClientHeight + 1;
  If FButton.Visible Then
    Loc.Right := ClientWidth - FButton.Width - 3
  Else
    Loc.Right := ClientWidth - 3;

  If self.BorderStyle = bsNone Then
  Begin
    Loc.Top := 3;
    Loc.Left := 2;
  End
  Else
  Begin
    Loc.Top := 1;
    Loc.Left := 1;
  End;

  EditRect := Loc;

  If Not Ctl3D Then
    Loc.Left := Loc.Left + 1;

  SendMessage(Handle, EM_SETRECTNP, 0, Longint(@Loc));
End;

Procedure THsVTCustomButtonEdit.CreateDropDownButton();
Begin
  If Not Assigned(FButton) Then
  Begin
    FButton := THsVTDropDownEditButton.Create(Self);
    FButton.Parent := Self;
    FButton.Button.ButtonStyle := bsButton;
    FButton.OnClick := DoOnButtonClick;

    If (csDesigning In ComponentState) Then
      FButton.Color := clBtnFace;

    FButton.Width        := ButtonWidth;
    FButton.Height       := DD_DROPDOWNBUTTONHEIGHT;
    FButton.Visible      := True;
    FButton.FocusControl := Self;
  End;
End;

Constructor THsVTCustomDropDown.Create(AOwner: TComponent);
Begin
  InHerited Create(AOwner);

  If ComponentState * [csDesigning] = [] Then
    CreateDropDownForm();

  FDropDownBorderColor := clBlack;
  FDropDownGradient    := gdHorizontal;
  FDropDownColor       := clWhite;
  FDropDownColorTo     := clNone;
  FDropDownHeight      := 0;
  FDropDownWidth       := 0;
  FDropDownBorderWidth := 1;
  FDropDownSizeable    := True;
  FDropDownShadow      := True;
  FDropDownEnabled     := True;
  FUserDropDownWidth   := -1;
  FUserDropDOwnHeight  := -1;
  FDropPosition        := dpAuto;

  Button.OnClick := DropDownButtonClick;
  Button.Button.ButtonStyle := bsDropDown;
End;

Destructor THsVTCustomDropDown.Destroy();
Begin
  If Not (csDesigning In ComponentState) Then
    FDropDownForm.Free();

  InHerited Destroy();
End;

Procedure THsVTCustomDropDown.SetStyle(Const Value: TDropDownStyle);
Begin
  FStyle := Value;
  EditorEnabled := (Value = dsDropDown);
End;

Procedure THsVTCustomDropDown.Assign(Source : TPersistent);
Var lSrc : THsVTCustomDropDown;
Begin
  InHerited Assign(Source);

  If Source Is THsVTCustomDropDown Then
  Begin
    lSrc := Source As THsVTCustomDropDown;

    FDropDownEnabled     := lSrc.DropDownEnabled;
    FDropDownColor       := lSrc.DropDownColor;
    FDropDownColorTo     := lSrc.DropDownColorTo;
    FDropDownGradient    := lSrc.DropDownGradient;
    FDropDownBorderColor := lSrc.DropDownBorderColor;
    FDropDownBorderWidth := lSrc.DropDownBorderWidth;
    FDropDownShadow      := lSrc.DropDownShadow;
    FDropDownWidth       := lSrc.DropDownWidth;
    FDropDownHeight      := lSrc.DropDownHeight;
    FDropDownSizeable    := lSrc.DropDownSizeable;
    FDropPosition        := lSrc.DropPosition;
  End;
End;

Procedure THsVTCustomDropDown.WMKeyDown(Var Msg: TWMKeyDown);
Var IsAlt : Boolean;
Begin
  If csDesigning In ComponentState Then
    Exit;

  IsAlt := GetKeyState(VK_MENU) And $8000 = $8000;

  If IsAlt Then
  Begin
    Case Msg.CharCode Of
      VK_UP, VK_DOWN:
      Begin
        If DroppedDown Then
          DoHideDropDown(False)
        Else
          DoShowDropDown();
      End;
    End;
  End;

  If Not EditorEnabled And Enabled Then
  Begin
    If Not ReadOnly Then
    Begin
      Case Msg.CharCode Of
        VK_F4:
        Begin
          If FDropDownForm.Visible Then
            DoHideDropDown(False)
          Else
            DoShowDropDown();
        End;

        VK_RETURN : DoHideDropDown(False);
        VK_ESCAPE : DoHideDropDown(True);
      End;
    End;

    If (Msg.CharCode In [VK_RETURN,VK_ESCAPE,VK_TAB]) Then
      InHerited;

    Exit;
  End;

  InHerited;

  Case Msg.CharCode Of
    VK_F4:
    Begin
      If FDropDownForm.Visible Then
        DoHideDropDown(False)
      Else
        DoShowDropDown();
    End;

    VK_RETURN:
      DoHideDropDown(False);
    VK_ESCAPE:
      DoHideDropDown(True);
  End;
End;

Procedure THsVTCustomDropDown.WMLButtonDown(Var Msg: TWMMouse);
Begin
  InHerited;

  If Not EditorEnabled Then
    MouseButtonDown(Nil);
End;

Procedure THsVTCustomDropDown.WMLButtonUp(Var Msg: TWMMouse);
Begin
  InHerited;
End;

Procedure THsVTCustomDropDown.CMWantSpecialKey(Var Msg: TCMWantSpecialKey);
Begin
  InHerited;

  If (Msg.CharCode = VK_ESCAPE) And (DroppedDown) Then
    Msg.Result := 1;
End;

Procedure THsVTCustomDropDown.KeyDown(Var Key: Word; Shift: TShiftState);
Begin
  InHerited;

  If (ssAlt In Shift) Then
  Begin
    Case Key Of
      VK_UP, VK_DOWN:
      Begin
        If DroppedDown Then
          DoHideDropDown(False)
        Else
          DoShowDropDown;
      End;
    End;
  End;
End;

Procedure THsVTCustomDropDown.CreateDropDownForm();
Begin
  If Not Assigned(FDropDownForm) Then
  Begin
    FDropDownForm := THsVTDropDownForm.CreateNew(Self, 0);

    With FDropDownForm Do
    Begin
      HsVTDropDown := Self;
      BorderStyle  := bsNone;
      Visible      := False;
      Width        := FDropDownWidth;
      Height       := FDropDownHeight;
      Sizeable     := True;
      
      OnHide           := OnFormHide;
      OnKeyPress       := OnFormKeyPress;
      OnKeyDown        := OnFormKeyDown;
      OnKeyUp          := OnFormKeyUp;
      OnMouseWheelDown := OnFormMouseWheelDown;
      OnMouseWheelUp   := OnFormMouseWheelUp;

      DoubleBuffered := True;
    End;

    FDDFStatus := TStatusBar.Create(Self);
    FDDFStatus.Parent := FDropDownForm;
    FDDFStatus.Visible := False;
  End;
End;

Procedure THsVTCustomDropDown.MouseButtonDown(Sender: TObject);
Begin
  If csDesigning In ComponentState Then
    Exit;

  If Not FDropDownForm.Visible And (GetTickCount - FDropDownForm.DeActivateTime > 250) Then
    DoShowDropDown;
End;

Procedure THsVTCustomDropDown.DropDownButtonClick(Sender: TObject);
Begin
  MouseButtonDown(Nil);
End;

Procedure THsVTCustomDropDown.BeforeDropDown();
Begin
  If Assigned(FOnBeforeDropDown) Then
    FOnBeforeDropDown(Self);
End;

Procedure THsVTCustomDropDown.UpdateDropDownSize();
Var h: Integer;
Begin
  If Assigned(FDropDownForm) Then
  Begin
    If (FDropDownWidth > 0) Then
      FDropDownForm.Width := FDropDownWidth
    Else
      FDropDownForm.Width := Self.Width;

    If (FDropDownHeight > 0) Then
      FDropDownForm.Height := FDropDownHeight
    Else
    Begin
      // AutoSize
      h := DropDownBorderWidth * 2;
      FDropDownForm.Height := h;
    End;
  End;
End;

Procedure THsVTCustomDropDown.AdaptDropDownSize(Var AHeight: Integer); 
Begin
  //
End;

Procedure THsVTCustomDropDown.AfterDropDown();
Begin
  If Assigned(FocusControl) And FocusControl.TabStop And
    FocusControl.CanFocus And (GetFocus <> FocusControl.Handle) Then
    FocusControl.SetFocus();
End;

Procedure THsVTCustomDropDown.DoShowDropDown();
{$IFNDEF DELPHI2006_LVL}
Const
  CS_DROPSHADOW = $00020000;
{$ENDIF}
Var
  p: TPoint;
  accept: Boolean;
  R: TRect;
  {$IFDEF DELPHI6_LVL}
  mon: TMonitor;
  {$ENDIF}
  w, h: Integer;

Begin
  If (csDesigning In ComponentState) Or Not Assigned(FDropDownForm) Then
    Exit;

  If FDropDownForm.Visible Or Not Enabled Or ReadOnly Then
    Exit;

  BeforeDropDown;

  FDropDownForm.Shadow := DropDownShadow;

  If Not (FDropDownForm.Shadow) Then
    SetClassLong(FDropDownForm.Handle,GCL_STYLE, GetClassLong(FDropDownForm.Handle, GCL_STYLE) And Not CS_DROPSHADOW)
  Else
    SetClassLong(FDropDownForm.Handle,GCL_STYLE, GetClassLong(FDropDownForm.Handle, GCL_STYLE) Or CS_DROPSHADOW);
  FDropDownForm.Left := self.Left;
  FDropDownForm.Top  := self.Top;

  UpdateDropDownSize; //<-- Icitte
//  SetCenterControl();

//  FDropDownForm.Constraints.MinWidth := DD_MINWIDTH;
//  FDropDownForm.Constraints.MinHeight := DD_MINHEIGHT;

  If (Parent Is TWinControl) Then
  Begin
    P := Point(Left, Top);
    P := Parent.ClientToScreen(P);
  End
  Else
  Begin
    P := Point(0, 0);
    P := ClientToScreen(P);
  End;

  Case FDropPosition Of
    dpAuto:
    Begin
      If P.y + FDropDownForm.Height >= GetSystemMetrics(SM_CYSCREEN) Then
      Begin //Up
        FDropDownForm.Left := P.x;
        FDropDownForm.Top  := p.y - FDropDownForm.Height;
      End
      Else
      Begin //Down
        FDropDownForm.Left := P.x;
        FDropDownForm.Top  := p.y + Height - 1;
      End;
    End;

    dpDown:
    Begin
      FDropDownForm.Left := P.x;
      FDropDownForm.Top  := p.y + Height - 1;
    End;

    dpUp:
    Begin
      FDropDownForm.Left := P.x;
      FDropDownForm.Top  := p.y - FDropDownForm.Height;
    End;
  End;

  Accept := True;

  If Assigned(FOnDropDown) Then
    FOnDropdown(Self, Accept);

  If Not Accept Then
    Exit;

  R := Rect(-1, -1, -1, -1);
  {$IFDEF DELPHI6_LVL}
  mon := Screen.MonitorFromPoint(p);
  If Assigned(mon) Then
    R := mon.WorkAreaRect
  Else
  {$ENDIF}
  Begin
    SystemParametersInfo(SPI_GETWORKAREA, 0, @R, 0);
  End;

  If (R.Left >= 0) And (R.Right < FDropDownForm.Left + FDropDownForm.Width) And (R.Right > FDropDownForm.Left) Then
    FDropDownForm.Left := FDropDownForm.Left - ((FDropDownForm.Left + FDropDownForm.Width) - R.Right);

  p.x := FDropDownForm.Left;
  p.y := FDropDownForm.Top;

  If FUserDropDownWidth <> -1 Then
  Begin
    FDropDownForm.Width := FUserDropDownWidth;
  End;

  If FUserDropDownHeight <> -1 Then
  Begin
    FDropDownForm.Height := FUserDropDownHeight;
  End;

  If Assigned(FOnGetDropDownPos) Then
  Begin
    FOnGetDropDownPos(Self, p);

    FDropDownForm.Left := P.x;
    FDropDownForm.Top  := p.y;
  End;

  w := FDropDownForm.Width;
  h := FDropDownForm.Height;

  FDropDownForm.Width := 0;
  FDropDownForm.Height := 0;
  FDropDownForm.Visible := True;

  If DropDownShadow And ForceShadow Then
  Begin
    FDropDownForm.Visible := False;
    FDropDownForm.Width := 1;
    FDropDownForm.Height := 1;
    FDropDownForm.Visible := True;
  End;

  AdaptDropDownSize(h);

  If Accept Then
  Begin
    FDroppedDown := True;
    SetWindowPos(FDropDownForm.Handle,HWND_TOPMOST,p.x,p.y,w,h,0);
    AfterDropDown;
  End;
End;

Procedure THsVTCustomDropDown.SetDropDownEnabled(Const Value: Boolean);
Begin
  FDropDownEnabled := Value;

  If Assigned(Button) Then
    Button.Enabled := FDropDownEnabled;
End;

Procedure THsVTCustomDropDown.SetDropDownColor(Const Value: TColor);
Begin
  FDropDownColor := Value;
End;

Procedure THsVTCustomDropDown.SetDropDownHeight(Const Value: Integer);
Begin
  If (FDropDownHeight <> Value) Then
  Begin
    FDropDownHeight := Value;
    FUserDropDownHeight := -1;
  End;
End;

Procedure THsVTCustomDropDown.SetDropDownWidth(Const Value: Integer);
Begin
  If (FDropDownWidth <> Value) Then
  Begin
    FDropDownWidth := Value;
    FUserDropDownWidth := -1;
  End;
End;

Procedure THsVTCustomDropDown.DoHideDropDown(Cancelled: Boolean);
Begin
  If (ComponentState * [csDesigning] = []) And FDropDownForm.Visible Then
  Begin
    If Assigned(FOnBeforeDropUp) Then
      FOnBeforeDropUp(self);

    FUserDropDownWidth := FDropDownForm.Width;
    FUserDropDownHeight := FDropDownForm.Height;

    FDropDownForm.Hide;

    Application.CancelHint;

    If Cancelled Then
      Text := FOldText;

    If Assigned(FOnDropUp) Then
      FOnDropUP(self, Cancelled);
  End;
End;

Procedure THsVTCustomDropDown.ShowDropDown();
Begin
  DoShowDropDown();
End;

Procedure THsVTCustomDropDown.HideDropDown(CancelChanges: Boolean = False);
Begin
  DoHideDropDown(CancelChanges);
End;

Procedure THsVTCustomDropDown.OnFormHide(Sender: TObject);
Begin
  FDroppedDown := False;
  If TabStop And CanFocus And (GetFocus <> Handle) And Not (csDestroying In ComponentState) Then
    SetFocus;
End;

Procedure THsVTCustomDropDown.OnFormMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; Var Handled: Boolean);
Begin
  HandleMouseWheelDown();
End;

Procedure THsVTCustomDropDown.OnFormMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; Var Handled: Boolean);
Begin
  HandleMouseWheelUp();
End;

Procedure THsVTCustomDropDown.OnFormKeyPress(Sender: TObject;
  Var Key: Char);
Begin
  SendMessage(Self.Handle, WM_Char, Integer(Key), 0);
End;

Procedure THsVTCustomDropDown.OnFormKeyUp(Sender: TObject; Var Key: Word;
  Shift: TShiftState);
Begin
  SendMessage(Self.Handle, WM_KEYUP, Key, 0);
End;

Procedure THsVTCustomDropDown.OnFormKeyDown(Sender: TObject; Var Key: Word;
  Shift: TShiftState);
Begin
  SendMessage(Self.Handle, WM_KEYDOWN, Key, 0);
End;

Procedure THsVTCustomControlDropDown.SetCenterControl();
Begin
  If Assigned(DropDownForm) And Assigned(FControl) Then
  Begin
    FControl.Parent := DropDownForm;
    FControl.Top := DropDownBorderWidth;
    FControl.Align := alClient;
  End;
End;

Procedure THsVTCustomControlDropDown.SetControl(Const Value: TControl);
Begin
  If (FControl <> Value) Then
  Begin
    FControl := Value;

    If ComponentState * [csDesigning] = [] Then
      SetCenterControl();
  End;
End;

Procedure THsVTCustomControlDropDown.OnControlKeyDown(Sender: TObject; Var Key: Word;
  Shift: TShiftState);
Begin
  SendMessage(Self.Handle, WM_KEYDOWN, Key, 0);
End;

Procedure THsVTCustomControlDropDown.OnControlKeyPress(Sender: TObject; Var Key: Char);
Begin
  SendMessage(Self.Handle, WM_CHAR, Integer(Key), 0);
End;

Procedure THsVTCustomControlDropDown.OnControlKeyUp(Sender: TObject; Var Key: Word;
  Shift: TShiftState);
Begin
  SendMessage(Self.Handle, WM_KEYUP, Key, 0);
End;

Procedure THsVTCustomControlDropDown.OnControlMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Begin
  HideDropDown();
End;

Procedure THsVTCustomControlDropDown.DoShowDropDown();
Begin

  If Assigned(FControl) And (FControl Is TWinControl) Then
  Begin
    TWinControlAccess(FControl).OnKeyDown  := OnControlKeyDown;
    TWinControlAccess(FControl).OnKeyUp    := OnControlKeyUp;
    TWinControlAccess(FControl).OnKeyPress := OnControlKeyPress;
    TWinControlAccess(FControl).OnMouseUp  := OnControlMouseUp;
  End;

  SetCenterControl();

  InHerited DoShowDropDown();
End;

Procedure THsVTCustomControlDropDown.UpdateDropDownSize();
Var h: Integer;
Begin
  If Assigned(DropDownForm) Then
  Begin
    If (DropDownWidth > 0) Then
      DropDownForm.Width := DropDownWidth
    Else
    Begin
      If Assigned(FControl) And FControl.Visible Then
        DropDownForm.Width := FControl.Width
      Else
        DropDownForm.Width := Self.Width;
    End;

    If (DropDownHeight > 0) Then
      DropDownForm.Height := DropDownHeight
    Else
    Begin
      h := DropDownBorderWidth * 2;
      If Assigned(FControl) And FControl.Visible Then
        h := h + FControl.Height;

      DropDownForm.Height := h;
    End;
  End;
End;

Procedure THsVTCustomControlDropDown.Notification(AComponent: TComponent; Operation: TOperation);
Begin
  InHerited;

  If (ComponentState * [csDestroying] = []) And (Operation = opRemove) Then
    If (AComponent = FControl) Then
      Control := Nil;
End;

Procedure THsVTCustomControlDropDown.Loaded();
Begin
  InHerited Loaded();

  If ComponentState * [csDesigning] = [] Then
    SetCenterControl();
End;

End.
