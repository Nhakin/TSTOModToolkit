{**************************************************************************************************}
{                                                                                                  }
{ Project JEDI Code Library (JCL)                                                                  }
{                                                                                                  }
{ The contents of this file are subject to the Mozilla Public License Version 1.1 (the "License"); }
{ you may not use this file except in compliance with the License. You may obtain a copy of the    }
{ License at http://www.mozilla.org/MPL/                                                           }
{                                                                                                  }
{ Software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF   }
{ ANY KIND, either express or implied. See the License for the specific language governing rights  }
{ and limitations under the License.                                                               }
{                                                                                                  }
{ The Original Code is JvSimpleXML.PAS, released on 2002-06-03.                                    }
{                                                                                                  }
{ The Initial Developer of the Original Code is Sébastien Buysse [sbuysse att buypin dott com].    }
{ Portions created by Sébastien Buysse are Copyright (C) 2001 Sébastien Buysse.                    }
{ All Rights Reserved.                                                                             }
{                                                                                                  }
{ Contributor(s):                                                                                  }
{   Christophe Paris,                                                                              }
{   Florent Ouchet (move from the JVCL to the JCL)                                                 }
{   Teträm                                                                                         }
{                                                                                                  }
{**************************************************************************************************}
{                                                                                                  }
{ This unit contains Xml parser and writter classes                                                }
{                                                                                                  }
{**************************************************************************************************}
{                                                                                                  }
{ Last modified: $Date::                                                                         $ }
{ Revision:      $Rev::                                                                          $ }
{ Author:        $Author::                                                                       $ }
{                                                                                                  }
{**************************************************************************************************}

// Known Issues: This component does not parse the !DOCTYPE tags but preserves them

unit HsJclSimpleXml;

interface

uses
  {$IFDEF HAS_UNIT_RTLCONSTS}
  RTLConsts,
  {$ENDIF HAS_UNIT_RTLCONSTS}
  {$IFDEF MSWINDOWS}
  Windows, // Delphi 2005 inline
  {$ENDIF MSWINDOWS}
  SysUtils,
  Classes,
  Variants,
  IniFiles,
  Contnrs;{,
  JclBase, JclStreams;}

type
  THsJclSimpleItem = class(TObject)
  private
    FName: string;
  protected
    procedure SetName(const Value: string); virtual;
  public
    property Name: string read FName write SetName;
  end;

type
  THsJclSimpleItemHashedList = class(TObjectList)
  private
    FNameHash: TStringHash;
    FCaseSensitive: Boolean;
    function GetSimpleItemByName(const Name: string): THsJclSimpleItem;
    function GetSimpleItem(Index: Integer): THsJclSimpleItem;
    procedure SetCaseSensitive(const Value: Boolean);
  protected
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
  public
    constructor Create(ACaseSensitive: Boolean);
    destructor Destroy; override;
    function Add(Item: THsJclSimpleItem): Integer;
    function Extract(Item: THsJclSimpleItem): THsJclSimpleItem;
    procedure Clear; override;
    function IndexOfSimpleItem(Item: THsJclSimpleItem): Integer;
    function IndexOfName(const Name: string): Integer;
    procedure Insert(Index: Integer; Item: THsJclSimpleItem);
    procedure InvalidateHash;
    procedure Move(CurIndex, NewIndex: Integer);
    property CaseSensitive: Boolean read FCaseSensitive write SetCaseSensitive;
    property SimpleItemByNames[const Name: string]: THsJclSimpleItem read GetSimpleItemByName;
    property SimpleItems[Index: Integer]: THsJclSimpleItem read GetSimpleItem;
  end;

type
  THsJclSimpleData = class(THsJclSimpleItem)
  private
    FValue: string;
    FData: Pointer;
  protected
    function GetBoolValue: Boolean;
    procedure SetBoolValue(const Value: Boolean);
    function GetFloatValue: Extended;
    procedure SetFloatValue(const Value: Extended);
    function GetAnsiValue: AnsiString;
    procedure SetAnsiValue(const Value: AnsiString);
    function GetIntValue: Int64;
    procedure SetIntValue(const Value: Int64);
  public
    constructor Create; overload; virtual;
    constructor Create(const AName: string); overload;
    constructor Create(const AName, AValue: string); overload;
    property Value: string read FValue write FValue;
    property AnsiValue: AnsiString read GetAnsiValue write SetAnsiValue;
    property IntValue: Int64 read GetIntValue write SetIntValue;
    property BoolValue: Boolean read GetBoolValue write SetBoolValue;
    property FloatValue: Extended read GetFloatValue write SetFloatValue;

    property Data: Pointer read FData write FData;
  end;

type
  THsJclSimpleXMLData = class(THsJclSimpleData)
  private
    FNameSpace: string;
  public
    function FullName:string;
    property NameSpace: string read FNameSpace write FNameSpace;
  end;

type
  EHsJclError = Class(Exception);
  EHsJclSimpleXMLError = class(EHsJclError);

  THsJclSimpleXML = class;
  {$TYPEINFO ON} // generate RTTI for published properties
  THsJclSimpleXMLElem = class;
  {$IFNDEF TYPEINFO_ON}
  {$TYPEINFO OFF}
  {$ENDIF ~TYPEINFO_ON}
  THsJclSimpleXMLElems = class;
  THsJclSimpleXMLProps = class;
  THsJclSimpleXMLElemsProlog = class;
  THsJclSimpleXMLNamedElems = class;
  THsJclSimpleXMLElemComment = class;
  THsJclSimpleXMLElemClassic = class;
  THsJclSimpleXMLElemCData = class;
  THsJclSimpleXMLElemDocType = class;
  THsJclSimpleXMLElemText = class;
  THsJclSimpleXMLElemHeader = class;
  THsJclSimpleXMLElemSheet = class;
  THsJclSimpleXMLElemMSOApplication = class;
  THsJclOnSimpleXMLParsed = procedure(Sender: TObject; const Name: string) of object;
  THsJclOnValueParsed = procedure(Sender: TObject; const Name, Value: string) of object;
  THsJclOnSimpleProgress = procedure(Sender: TObject; const Position, Total: Integer) of object;

  //Those hash stuffs are for future use only
  //Plans are to replace current hash by this mechanism
  THsJclHashKind = (hkList, hkDirect);
  PJclHashElem = ^THsJclHashElem;
  THsJclHashElem = packed record
    Next: PJclHashElem;
    Obj: TObject;
  end;
  PJclHashRecord = ^THsJclHashRecord;
  THsJclHashList = array [0..25] of PJclHashRecord;
  PJclHashList = ^THsJclHashList;
  THsJclHashRecord = packed record
    Count: Byte;
    case Kind: THsJclHashKind of
      hkList: (List: PJclHashList);
      hkDirect: (FirstElem: PJclHashElem);
  end;

  THsJclSimpleXMLProp = class(THsJclSimpleXMLData)
  private
    FParent: THsJclSimpleXMLElem;
  protected
    function GetSimpleXML: THsJclSimpleXML;
    procedure SetName(const Value: string); override;
  public
    constructor Create(AParent: THsJclSimpleXMLElem; const AName, AValue: string);
    procedure SaveToStringStream(StringStream: TStringStream);
    property Parent: THsJclSimpleXMLElem read FParent;
    property SimpleXML: THsJclSimpleXML read GetSimpleXML;
  end;

  {$IFDEF SUPPORTS_FOR_IN}
  THsJclSimpleXMLPropsEnumerator = class
  private
    FIndex: Integer;
    FList: THsJclSimpleXMLProps;
  public
    constructor Create(AList: THsJclSimpleXMLProps);
    function GetCurrent: THsJclSimpleXMLProp; {$IFDEF SUPPORTS_INLINE}inline;{$ENDIF}
    function MoveNext: Boolean;
    property Current: THsJclSimpleXMLProp read GetCurrent;
  end;
  {$ENDIF SUPPORTS_FOR_IN}

  THsJclSimpleXMLProps = class(TObject)
  private
    FProperties: TStringList;
    FParent: THsJclSimpleXMLElem;
    function GetCount: Integer;
    function GetItemNamedDefault(const Name, Default: string): THsJclSimpleXMLProp;
    function GetItemNamed(const Name: string): THsJclSimpleXMLProp;
  protected
    function GetSimpleXML: THsJclSimpleXML;
    function GetItem(const Index: Integer): THsJclSimpleXMLProp;
    procedure DoItemRename(Value: THsJclSimpleXMLProp; const Name: string);
    procedure Error(const S: string);
    procedure FmtError(const S: string; const Args: array of const);
  public
    constructor Create(AParent: THsJclSimpleXMLElem);
    destructor Destroy; override;
    procedure SortProperties(const Order: array of string);
    function Add(const Name, Value: string): THsJclSimpleXMLProp; overload;
    {$IFDEF SUPPORTS_UNICODE}
    function Add(const Name: string; const Value: AnsiString): THsJclSimpleXMLProp; overload;
    {$ENDIF SUPPORTS_UNICODE}
    function Add(const Name: string; const Value: Int64): THsJclSimpleXMLProp; overload;
    function Add(const Name: string; const Value: Boolean): THsJclSimpleXMLProp; overload;
    function Insert(const Index: Integer; const Name, Value: string): THsJclSimpleXMLProp; overload;
    function Insert(const Index: Integer; const Name: string; const Value: Int64): THsJclSimpleXMLProp; overload;
    function Insert(const Index: Integer; const Name: string; const Value: Boolean): THsJclSimpleXMLProp; overload;
    procedure Clear; virtual;
    procedure Delete(const Index: Integer); overload;
    procedure Delete(const Name: string); overload;
    {$IFDEF SUPPORTS_FOR_IN}
    function GetEnumerator: THsJclSimpleXMLPropsEnumerator;
    {$ENDIF SUPPORTS_FOR_IN}
    function Value(const Name: string; const Default: string = ''): string;
    function IntValue(const Name: string; const Default: Int64 = -1): Int64;
    function BoolValue(const Name: string; Default: Boolean = True): Boolean;
    function FloatValue(const Name: string; const Default: Extended = 0): Extended;
    procedure LoadFromStringStream(StringStream: TStringStream);
    procedure SaveToStringStream(StringStream: TStringStream);
    property Item[const Index: Integer]: THsJclSimpleXMLProp read GetItem; default;
    property ItemNamed[const Name: string]: THsJclSimpleXMLProp read GetItemNamed;
    property Count: Integer read GetCount;
    property Parent: THsJclSimpleXMLElem read FParent;
  end;

  {$IFDEF SUPPORTS_FOR_IN}
  THsJclSimpleXMLElemsPrologEnumerator = class
  private
    FIndex: Integer;
    FList: THsJclSimpleXMLElemsProlog;
  public
    constructor Create(AList: THsJclSimpleXMLElemsProlog);
    function GetCurrent: THsJclSimpleXMLElem; {$IFDEF SUPPORTS_INLINE}inline;{$ENDIF}
    function MoveNext: Boolean;
    property Current: THsJclSimpleXMLElem read GetCurrent;
  end;
  {$ENDIF SUPPORTS_FOR_IN}

  THsJclSimpleXMLElemsProlog = class(TObject)
  private
    FElems: THsJclSimpleItemHashedList;
    function GetCount: Integer;
    function GetItem(const Index: Integer): THsJclSimpleXMLElem;
    function GetEncoding: string;
    function GetStandalone: Boolean;
    function GetVersion: string;
    procedure SetEncoding(const Value: string);
    procedure SetStandalone(const Value: Boolean);
    procedure SetVersion(const Value: string);
  protected
    FSimpleXML: THsJclSimpleXML;
    function FindHeader: THsJclSimpleXMLElem;
    procedure Error(const S: string);
    procedure FmtError(const S: string; const Args: array of const);
  public
    constructor Create(ASimpleXML: THsJclSimpleXML);
    destructor Destroy; override;
    function AddComment(const AValue: string): THsJclSimpleXMLElemComment;
    function AddDocType(const AValue: string): THsJclSimpleXMLElemDocType;
    procedure Clear;
    function AddStyleSheet(const AType, AHRef: string): THsJclSimpleXMLElemSheet;
    function AddMSOApplication(const AProgId : string): THsJclSimpleXMLElemMSOApplication;
    procedure LoadFromStringStream(StringStream: TStringStream);
    procedure SaveToStringStream(StringStream: TStringStream);
    {$IFDEF SUPPORTS_FOR_IN}
    function GetEnumerator: THsJclSimpleXMLElemsPrologEnumerator;
    {$ENDIF SUPPORTS_FOR_IN}
    property Item[const Index: Integer]: THsJclSimpleXMLElem read GetItem; default;
    property Count: Integer read GetCount;
    property Encoding: string read GetEncoding write SetEncoding;
    property SimpleXML: THsJclSimpleXML read FSimpleXML;
    property Standalone: Boolean read GetStandalone write SetStandalone;
    property Version: string read GetVersion write SetVersion;
  end;

  {$IFDEF SUPPORTS_FOR_IN}
  THsJclSimpleXMLNamedElemsEnumerator = class
  private
    FIndex: Integer;
    FList: THsJclSimpleXMLNamedElems;
  public
    constructor Create(AList: THsJclSimpleXMLNamedElems);
    function GetCurrent: THsJclSimpleXMLElem; {$IFDEF SUPPORTS_INLINE}inline;{$ENDIF}
    function MoveNext: Boolean;
    property Current: THsJclSimpleXMLElem read GetCurrent;
  end;
  {$ENDIF SUPPORTS_FOR_IN}

  THsJclSimpleXMLNamedElems = class(THsJclSimpleItem)
  private
    FElems: THsJclSimpleXMLElems;
    function GetCount: Integer;
  protected
    FItems: TList;
    function GetItem(const Index: Integer): THsJclSimpleXMLElem;
    procedure SetName(const Value: string); override;
  public
    constructor Create(AElems: THsJclSimpleXMLElems; const AName: string);
    destructor Destroy; override;

    function Add: THsJclSimpleXMLElemClassic; overload;
    function Add(const Value: string): THsJclSimpleXMLElemClassic; overload;
    function Add(const Value: Int64): THsJclSimpleXMLElemClassic; overload;
    function Add(const Value: Boolean): THsJclSimpleXMLElemClassic; overload;
    function Add(Value: TStream): THsJclSimpleXMLElemClassic; overload;
    function AddFirst: THsJclSimpleXMLElemClassic;
    function AddComment(const Value: string): THsJclSimpleXMLElemComment;
    function AddCData(const Value: string): THsJclSimpleXMLElemCData;
    function AddText(const Value: string): THsJclSimpleXMLElemText;
    procedure Clear; virtual;
    procedure Delete(const Index: Integer);
    procedure Move(const CurIndex, NewIndex: Integer);
    function IndexOf(const Value: THsJclSimpleXMLElem): Integer; overload;
    function IndexOf(const Value: string): Integer; overload;
    {$IFDEF SUPPORTS_FOR_IN}
    function GetEnumerator: THsJclSimpleXMLNamedElemsEnumerator;
    {$ENDIF SUPPORTS_FOR_IN}

    property Elems: THsJclSimpleXMLElems read FElems;
    property Item[const Index: Integer]: THsJclSimpleXMLElem read GetItem; default;
    property Count: Integer read GetCount;
  end;

  {$IFDEF SUPPORTS_FOR_IN}
  THsJclSimpleXMLElemsEnumerator = class
  private
    FIndex: Integer;
    FList: THsJclSimpleXMLElems;
  public
    constructor Create(AList: THsJclSimpleXMLElems);
    function GetCurrent: THsJclSimpleXMLElem; {$IFDEF SUPPORTS_INLINE}inline;{$ENDIF}
    function MoveNext: Boolean;
    property Current: THsJclSimpleXMLElem read GetCurrent;
  end;
  {$ENDIF SUPPORTS_FOR_IN}

  THsJclSimpleXMLElemCompare = function(Elems: THsJclSimpleXMLElems; Index1, Index2: Integer): Integer of object;
  THsJclSimpleXMLElems = class(TObject)
  private
    FParent: THsJclSimpleXMLElem;
    function GetCount: Integer;
    function GetItemNamedDefault(const Name, Default: string): THsJclSimpleXMLElem;
    function GetItemNamed(const Name: string): THsJclSimpleXMLElem;
    function GetNamedElems(const Name: string): THsJclSimpleXMLNamedElems;
  protected
    FElems: THsJclSimpleItemHashedList;
    FCompare: THsJclSimpleXMLElemCompare;
    FNamedElems: THsJclSimpleItemHashedList;
    function GetItem(const Index: Integer): THsJclSimpleXMLElem;
    procedure AddChild(const Value: THsJclSimpleXMLElem);
    procedure AddChildFirst(const Value: THsJclSimpleXMLElem);
    procedure InsertChild(const Value: THsJclSimpleXMLElem; Index: Integer);
    procedure DoItemRename(Value: THsJclSimpleXMLElem; const Name: string);
    procedure CreateElems;
    function SimpleCompare(Elems: THsJclSimpleXMLElems; Index1, Index2: Integer): Integer;
  public
    constructor Create(AParent: THsJclSimpleXMLElem);
    destructor Destroy; override;

    // Use notify to indicate to a list that the given element is removed
    // from the list so that it doesn't delete it as well as the one
    // that insert it in itself. This method is automatically called
    // by AddChild and AddChildFirst if the Container property of the
    // given element is set.
    procedure Notify(Value: THsJclSimpleXMLElem; Operation: TOperation);

    function Add(const Name: string): THsJclSimpleXMLElemClassic; overload;
    function Add(const Name, Value: string): THsJclSimpleXMLElemClassic; overload;
    function Add(const Name: string; const Value: Int64): THsJclSimpleXMLElemClassic; overload;
    function Add(const Name: string; const Value: Boolean): THsJclSimpleXMLElemClassic; overload;
    function Add(const Name: string; Value: TStream; BufferSize: Integer = 0): THsJclSimpleXMLElemClassic; overload;
    function Add(Value: THsJclSimpleXMLElem): THsJclSimpleXMLElem; overload;
    function AddFirst(Value: THsJclSimpleXMLElem): THsJclSimpleXMLElem; overload;
    function AddFirst(const Name: string): THsJclSimpleXMLElemClassic; overload;
    function AddComment(const Name: string; const Value: string): THsJclSimpleXMLElemComment;
    function AddCData(const Name: string; const Value: string): THsJclSimpleXMLElemCData;
    function AddText(const Name: string; const Value: string): THsJclSimpleXMLElemText;
    function Insert(Value: THsJclSimpleXMLElem; Index: Integer): THsJclSimpleXMLElem; overload;
    function Insert(const Name: string; Index: Integer): THsJclSimpleXMLElemClassic; overload;
    procedure Clear; virtual;
    procedure Delete(const Index: Integer); overload;
    procedure Delete(const Name: string); overload;
    function Remove(Value: THsJclSimpleXMLElem): Integer;
    procedure Move(const CurIndex, NewIndex: Integer);
    {$IFDEF SUPPORTS_FOR_IN}
    function GetEnumerator: THsJclSimpleXMLElemsEnumerator;
    {$ENDIF SUPPORTS_FOR_IN}
    function IndexOf(const Value: THsJclSimpleXMLElem): Integer; overload;
    function IndexOf(const Name: string): Integer; overload;
    function Value(const Name: string; const Default: string = ''): string;
    function IntValue(const Name: string; const Default: Int64 = -1): Int64;
    function FloatValue(const Name: string; const Default: Extended = 0): Extended;
    function BoolValue(const Name: string; Default: Boolean = True): Boolean;
    procedure BinaryValue(const Name: string; Stream: TStream);
    procedure LoadFromStringStream(StringStream: TStringStream);
    procedure SaveToStringStream(StringStream: TStringStream; const Level: string = '');
    procedure Sort;
    procedure CustomSort(AFunction: THsJclSimpleXMLElemCompare);
    property Parent: THsJclSimpleXMLElem read FParent;
    property Item[const Index: Integer]: THsJclSimpleXMLElem read GetItem; default;
    property ItemNamed[const Name: string]: THsJclSimpleXMLElem read GetItemNamed;
    property Count: Integer read GetCount;
    property NamedElems[const Name: string]: THsJclSimpleXMLNamedElems read GetNamedElems;
  end;

  {$TYPEINFO ON}
  THsJclSimpleXMLElem = class(THsJclSimpleXMLData)
  private
    FParent: THsJclSimpleXMLElem;
    FSimpleXML: THsJclSimpleXML;
    function GetHasItems: Boolean;
    function GetHasProperties: Boolean;
    function GetItemCount: Integer;
    function GetPropertyCount: Integer;
  protected
    FItems: THsJclSimpleXMLElems;
    FProps: THsJclSimpleXMLProps;
    function GetChildsCount: Integer;
    function GetProps: THsJclSimpleXMLProps;
    procedure SetName(const Value: string); override;
    function GetItems: THsJclSimpleXMLElems;
    procedure Error(const S: string);
    procedure FmtError(const S: string; const Args: array of const);
  public
    //constructor Create; overload;
    //constructor Create(const AName: string); overload;
    //constructor Create(const AName, AValue: string); overload;
    constructor Create(ASimpleXML: THsJclSimpleXML); overload;
    destructor Destroy; override;
    procedure Assign(Value: THsJclSimpleXMLElem); virtual;
    procedure Clear; virtual;
    procedure LoadFromStringStream(StringStream: TStringStream); virtual; abstract;
    procedure SaveToStringStream(StringStream: TStringStream; const Level: string = ''); virtual;
      abstract;
    procedure LoadFromString(const Value: string);
    function SaveToString: string;
    procedure GetBinaryValue(Stream: TStream; BufferSize: Integer = 0);
    function GetChildIndex(const AChild: THsJclSimpleXMLElem): Integer;
    function GetNamedIndex(const AChild: THsJclSimpleXMLElem): Integer;

    property SimpleXML: THsJclSimpleXML read FSimpleXML;
  published
    property Parent: THsJclSimpleXMLElem read FParent;
    property ChildsCount: Integer read GetChildsCount;
    property HasItems: Boolean read GetHasItems;
    property HasProperties: Boolean read GetHasProperties;
    property ItemCount: Integer read GetItemCount;
    property PropertyCount: Integer read GetPropertyCount;
    property Items: THsJclSimpleXMLElems read GetItems;
    property Properties: THsJclSimpleXMLProps read GetProps;
  end;
  {$IFNDEF TYPEINFO_ON}
  {$TYPEINFO OFF}
  {$ENDIF ~TYPEINFO_ON}
  THsJclSimpleXMLElemClass = class of THsJclSimpleXMLElem;

  THsJclSimpleXMLElemComment = class(THsJclSimpleXMLElem)
  public
    procedure LoadFromStringStream(StringStream: TStringStream); override;
    procedure SaveToStringStream(StringStream: TStringStream; const Level: string = ''); override;
  end;

  THsJclSimpleXMLElemClassic = class(THsJclSimpleXMLElem)
  public
    procedure LoadFromStringStream(StringStream: TStringStream); override;
    procedure SaveToStringStream(StringStream: TStringStream; const Level: string = ''); override;
  end;

  THsJclSimpleXMLElemCData = class(THsJclSimpleXMLElem)
  public
    procedure LoadFromStringStream(StringStream: TStringStream); override;
    procedure SaveToStringStream(StringStream: TStringStream; const Level: string = ''); override;
  end;

  THsJclSimpleXMLElemText = class(THsJclSimpleXMLElem)
  public
    procedure LoadFromStringStream(StringStream: TStringStream); override;
    procedure SaveToStringStream(StringStream: TStringStream; const Level: string = ''); override;
  end;

  THsJclSimpleXMLElemProcessingInstruction = class(THsJclSimpleXMLElem)
  public
    procedure LoadFromStringStream(StringStream: TStringStream); override;
    procedure SaveToStringStream(StringStream: TStringStream; const Level: string = ''); override;
  end;

  THsJclSimpleXMLElemHeader = class(THsJclSimpleXMLElemProcessingInstruction)
  private
    function GetEncoding: string;
    function GetStandalone: Boolean;
    function GetVersion: string;
    procedure SetEncoding(const Value: string);
    procedure SetStandalone(const Value: Boolean);
    procedure SetVersion(const Value: string);
  public
    constructor Create; override;

    procedure LoadFromStringStream(StringStream: TStringStream); override;
    procedure SaveToStringStream(StringStream: TStringStream; const Level: string = ''); override;
    property Version: string read GetVersion write SetVersion;
    property Standalone: Boolean read GetStandalone write SetStandalone;
    property Encoding: string read GetEncoding write SetEncoding;
  end;

  // for backward compatibility
  THsJclSimpleXMLElemSheet = class(THsJclSimpleXMLElemProcessingInstruction)
  end;

  // for backward compatibility
  THsJclSimpleXMLElemMSOApplication = class(THsJclSimpleXMLElemProcessingInstruction)
  end;

  THsJclSimpleXMLElemDocType = class(THsJclSimpleXMLElem)
  public
    procedure LoadFromStringStream(StringStream: TStringStream); override;
    procedure SaveToStringStream(StringStream: TStringStream; const Level: string = ''); override;
  end;

  THsJclSimpleXMLOptions = set of (sxoAutoCreate, sxoAutoIndent, sxoAutoEncodeValue,
    sxoAutoEncodeEntity, sxoDoNotSaveProlog, sxoTrimPrecedingTextWhitespace,
    sxoTrimFollowingTextWhitespace, sxoKeepWhitespace, sxoDoNotSaveBOM, sxoCaseSensitive);
  THsJclSimpleXMLEncodeEvent = procedure(Sender: TObject; var Value: string) of object;
  THsJclSimpleXMLEncodeStreamEvent = procedure(Sender: TObject; InStream, OutStream: TStream) of object;

  THsJclStringEncoding = (seAnsi, seUTF8, seUTF16, seAuto);

  THsJclSimpleXML = class(TObject)
  protected
    FEncoding: THsJclStringEncoding;
    FCodePage: Word;
    FFileName: TFileName;
    FOptions: THsJclSimpleXMLOptions;
    FRoot: THsJclSimpleXMLElemClassic;
    FOnTagParsed: THsJclOnSimpleXMLParsed;
    FOnValue: THsJclOnValueParsed;
    FOnLoadProg: THsJclOnSimpleProgress;
    FOnSaveProg: THsJclOnSimpleProgress;
    FProlog: THsJclSimpleXMLElemsProlog;
    FSaveCount: Integer;
    FSaveCurrent: Integer;
    FIndentString: string;
    FBaseIndentString: string;
    FOnEncodeValue: THsJclSimpleXMLEncodeEvent;
    FOnDecodeValue: THsJclSimpleXMLEncodeEvent;
    FOnDecodeStream: THsJclSimpleXMLEncodeStreamEvent;
    FOnEncodeStream: THsJclSimpleXMLEncodeStreamEvent;
    procedure SetIndentString(const Value: string);
    procedure SetBaseIndentString(const Value: string);
    procedure SetRoot(const Value: THsJclSimpleXMLElemClassic);
    procedure SetFileName(const Value: TFileName);
  protected
    procedure DoLoadProgress(const APosition, ATotal: Integer);
    procedure DoSaveProgress;
    procedure DoTagParsed(const AName: string);
    procedure DoValueParsed(const AName, AValue: string);
    procedure DoEncodeValue(var Value: string); virtual;
    procedure DoDecodeValue(var Value: string); virtual;
    procedure GetEncodingFromXMLHeader(var Encoding: THsJclStringEncoding; var CodePage: Word);
  public
    constructor Create;
    destructor Destroy; override;
    procedure LoadFromString(const Value: string);
    procedure LoadFromFile(const FileName: TFileName; Encoding: THsJclStringEncoding = seAuto; CodePage: Word = CP_ACP);
    procedure LoadFromStream(Stream: TStream; Encoding: THsJclStringEncoding = seAuto; CodePage: Word = CP_ACP);
    procedure LoadFromStringStream(StringStream: TStringStream);
    procedure LoadFromResourceName(Instance: THandle; const ResName: string; Encoding: THsJclStringEncoding = seAuto; CodePage: Word = CP_ACP);
    procedure SaveToFile(const FileName: TFileName; Encoding: THsJclStringEncoding = seAuto; CodePage: Word = CP_ACP);
    procedure SaveToStream(Stream: TStream; Encoding: THsJclStringEncoding = seAuto; CodePage: Word = CP_ACP);
    procedure SaveToStringStream(StringStream: TStringStream);
    function SaveToString: string;
    function SaveToStringEncoding(Encoding: THsJclStringEncoding; CodePage: Word = CP_ACP): string;
    property CodePage: Word read FCodePage;
    property Prolog: THsJclSimpleXMLElemsProlog read FProlog write FProlog;
    property Root: THsJclSimpleXMLElemClassic read FRoot write SetRoot;
    property XMLData: string read SaveToString write LoadFromString;
    property FileName: TFileName read FFileName write SetFileName;
    property IndentString: string read FIndentString write SetIndentString;
    property BaseIndentString: string read FBaseIndentString write SetBaseIndentString;
    property Options: THsJclSimpleXMLOptions read FOptions write FOptions;
    property OnSaveProgress: THsJclOnSimpleProgress read FOnSaveProg write FOnSaveProg;
    property OnLoadProgress: THsJclOnSimpleProgress read FOnLoadProg write FOnLoadProg;
    property OnTagParsed: THsJclOnSimpleXMLParsed read FOnTagParsed write FOnTagParsed;
    property OnValueParsed: THsJclOnValueParsed read FOnValue write FOnValue;
    property OnEncodeValue: THsJclSimpleXMLEncodeEvent read FOnEncodeValue write FOnEncodeValue;
    property OnDecodeValue: THsJclSimpleXMLEncodeEvent read FOnDecodeValue write FOnDecodeValue;
    property OnEncodeStream: THsJclSimpleXMLEncodeStreamEvent read FOnEncodeStream write FOnEncodeStream;
    property OnDecodeStream: THsJclSimpleXMLEncodeStreamEvent read FOnDecodeStream write FOnDecodeStream;
  end;

  TXMLVariant = class(TInvokeableVariantType)
  public
    procedure Clear(var V: TVarData); override;
    function IsClear(const V: TVarData): Boolean; override;
    procedure Copy(var Dest: TVarData; const Source: TVarData;
      const Indirect: Boolean); override;
    procedure CastTo(var Dest: TVarData; const Source: TVarData;
      const AVarType: TVarType); override;

    function DoFunction(var Dest: TVarData; const V: TVarData;
      const Name: string; const Arguments: TVarDataArray): Boolean; override;
    function GetProperty(var Dest: TVarData; const V: TVarData;
      const Name: string): Boolean; override;
    function SetProperty(const V: TVarData; const Name: string;
      const Value: TVarData): Boolean; override;
  end;

procedure XMLCreateInto(var ADest: Variant; const AXML: THsJclSimpleXMLElem);
function XMLCreate(const AXML: THsJclSimpleXMLElem): Variant; overload;
function XMLCreate: Variant; overload;
function VarXML: TVarType;

// Encodes a string into an internal format:
// any character TAB,LF,CR,#32..#127 is preserved
// all other characters are converted to hex notation except
// for some special characters that are converted to XML entities
function SimpleXMLEncode(const S: string): string;
// Decodes a string encoded with SimpleXMLEncode:
// any character TAB,LF,CR,#32..#127 is preserved
// all other characters and substrings are converted from
// the special XML entities to characters or from hex to characters
// NB! Setting TrimBlanks to true will slow down the process considerably
procedure SimpleXMLDecode(var S: string; TrimBlanks: Boolean);

function XMLEncode(const S: string): string;
function XMLDecode(const S: string): string;

// Encodes special characters (', ", <, > and &) into XML entities (@apos;, &quot;, &lt;, &gt; and &amp;)
function EntityEncode(const S: string): string;
// Decodes XML entities (@apos;, &quot;, &lt;, &gt; and &amp;) into special characters (', ", <, > and &)
function EntityDecode(const S: string): string;


implementation
(*
uses
  {$IFDEF HAS_UNITSCOPE}
  System.Types,
  {$ENDIF HAS_UNITSCOPE}
  JclCharsets,
  JclStrings,
  JclUnicode,
  JclStringConversions,
  JclResources;
*)

const
  cBufferSize = 8192;

var
  GlobalXMLVariant: TXMLVariant = nil;

  PreparedNibbleCharMapping: Boolean = False;
  NibbleCharMapping: array [Low(Char)..High(Char)] of Byte;

function XMLVariant: TXMLVariant;
begin
  if not Assigned(GlobalXMLVariant) then
    GlobalXMLVariant := TXMLVariant.Create;
  Result := GlobalXMLVariant;
end;

procedure AddEntity(var Res: string; var ResIndex, ResLen: Integer; const Entity: string);
var
  EntityIndex, EntityLen: Integer;
begin
  EntityLen := Length(Entity);
  if (ResIndex + EntityLen) > ResLen then
  begin
    if ResLen <= EntityLen then
      ResLen := ResLen * EntityLen
    else
      ResLen := ResLen * 2;
    SetLength(Res, ResLen);
  end;
  for EntityIndex := 1 to EntityLen do
  begin
    Res[ResIndex] := Entity[EntityIndex];
    Inc(ResIndex);
  end;
end;

function EntityEncode(const S: string): string;
var
  C: Char;
  SIndex, SLen, RIndex, RLen: Integer;
  Tmp: string;
begin
  SLen := Length(S);
  RLen := SLen;
  RIndex := 1;
  SetLength(Tmp, RLen);
  for SIndex := 1 to SLen do
  begin
    C := S[SIndex];
    case C of
      '"':
        AddEntity(Tmp, RIndex, RLen, '&quot;');
      '&':
        AddEntity(Tmp, RIndex, RLen, '&amp;');
      #39:
        AddEntity(Tmp, RIndex, RLen, '&apos;');
      '<':
        AddEntity(Tmp, RIndex, RLen, '&lt;');
      '>':
        AddEntity(Tmp, RIndex, RLen, '&gt;');
    else
      if RIndex > RLen then
      begin
        RLen := RLen * 2;
        SetLength(Tmp, RLen);
      end;
      Tmp[RIndex] := C;
      Inc(RIndex);
    end;
  end;
  if RIndex > 1 then
    SetLength(Tmp, RIndex - 1);

  Result := Tmp;
end;

function EntityDecode(const S: string): string;
var
  I, J, L: Integer;
begin
  Result := S;
  I := 1;
  J := 1;
  L := Length(Result);

  while I <= L do
  begin
    if Result[I] = '&' then
    begin
      if SameText(Copy(Result, I, 5), '&amp;') then
      begin
        Result[J] := '&';
        Inc(J);
        Inc(I, 4);
      end
      else
      if SameText(Copy(Result, I, 4), '&lt;') then
      begin
        Result[J] := '<';
        Inc(J);
        Inc(I, 3);
      end
      else
      if SameText(Copy(Result, I, 4), '&gt;') then
      begin
        Result[J] := '>';
        Inc(J);
        Inc(I, 3);
      end
      else
      if SameText(Copy(Result, I, 6), '&apos;') then
      begin
        Result[J] := #39;
        Inc(J);
        Inc(I, 5);
      end
      else
      if SameText(Copy(Result, I, 6), '&quot;') then
      begin
        Result[J] := '"';
        Inc(J);
        Inc(I, 5);
      end
      else
      begin
        Result[J] := Result[I];
        Inc(J);
      end;
    end
    else
    begin
      Result[J] := Result[I];
      Inc(J);
    end;
    Inc(I);
  end;
  if J > 1 then
    SetLength(Result, J - 1)
  else
    SetLength(Result, 0);
end;

function SimpleXMLEncode(const S: string): string;
var
  C: Char;
  SIndex, SLen, RIndex, RLen: Integer;
  Tmp: string;
begin
  SLen := Length(S);
  RLen := SLen;
  RIndex := 1;
  SetLength(Tmp, RLen);
  for SIndex := 1 to SLen do
  begin
    C := S[SIndex];
    case C of
      '"':
        AddEntity(Tmp, RIndex, RLen, '&quot;');
      '&':
        AddEntity(Tmp, RIndex, RLen, '&amp;');
      #39:
        AddEntity(Tmp, RIndex, RLen, '&apos;');
      '<':
        AddEntity(Tmp, RIndex, RLen, '&lt;');
      '>':
        AddEntity(Tmp, RIndex, RLen, '&gt;');
      #$0..#$8, // NativeTab, NativeLineFeed
      #$B..#$C, // NativeCarriageReturn
      #$E..#$F,
      Char(128)..Char(255):
        AddEntity(Tmp, RIndex, RLen, Format('&#x%.2x;', [Ord(C)]));
      {$IFDEF SUPPORTS_UNICODE}
      Char(256)..High(Char):
        AddEntity(Tmp, RIndex, RLen, Format('&#x%.4x;', [Ord(C)]));
      {$ENDIF SUPPORTS_UNICODE}
    else
      if RIndex > RLen then
      begin
        RLen := RLen * 2;
        SetLength(Tmp, RLen);
      end;
      Tmp[RIndex] := C;
      Inc(RIndex);
    end;
  end;
  if RIndex > 1 then
    SetLength(Tmp, RIndex - 1);

  Result := Tmp;
end;

procedure SimpleXMLDecode(var S: string; TrimBlanks: Boolean);
  procedure DecodeEntity(var S: string; StringLength: Cardinal;
    var ReadIndex, WriteIndex: Cardinal);
  const
    cHexPrefix: array [Boolean] of string = ('', '$');
  var
    I: Cardinal;
    Value: Integer;
    IsHex: Boolean;
  begin
    Inc(ReadIndex, 2);
    IsHex := (ReadIndex <= StringLength) and ((S[ReadIndex] = 'x') or (S[ReadIndex] = 'X'));
    Inc(ReadIndex, Ord(IsHex));
    I := ReadIndex;
    while ReadIndex <= StringLength do
    begin
      if S[ReadIndex] = ';' then
      begin
        Value := StrToIntDef(cHexPrefix[IsHex] + Copy(S, I, ReadIndex - I), -1); // no characters are less than 0
        if Value >= 0 then
          S[WriteIndex] := Chr(Value)
        else
          ReadIndex := I - (2 + Cardinal(IsHex)); // reset to start
        Exit;
      end;
      Inc(ReadIndex);
    end;
    ReadIndex := I - (2 + Cardinal(IsHex)); // reset to start
  end;

  procedure SkipBlanks(var S: string; StringLength: Cardinal; var ReadIndex: Cardinal);
  begin
    while ReadIndex < StringLength do
    begin
      if S[ReadIndex] = #$A then
        S[ReadIndex] := #$D
      else
      if S[ReadIndex + 1] = #$A then
        S[ReadIndex + 1] := #$D;
      if (S[ReadIndex] < #33) and (S[ReadIndex] = S[ReadIndex + 1]) then
        Inc(ReadIndex)
      else
        Exit;
    end;
  end;

var
  StringLength, ReadIndex, WriteIndex: Cardinal;
begin
  // NB! This procedure replaces the text inplace to speed up the conversion. This
  // works because when decoding, the string can only become shorter. This is
  // accomplished by keeping track of the current read and write points.
  // In addition, the original string length is read only once and passed to the
  // inner procedures to speed up conversion as much as possible
  ReadIndex := 1;
  WriteIndex := 1;
  StringLength := Length(S);
  while ReadIndex <= StringLength do
  begin
    // this call lowers conversion speed by ~30%, ie 21MB/sec -> 15MB/sec (repeated tests, various inputs)
    if TrimBlanks then
      SkipBlanks(S, StringLength, ReadIndex);
    if S[ReadIndex] = '&' then
    begin
      if (ReadIndex < StringLength) and (S[ReadIndex + 1] = '#') then
      begin
        DecodeEntity(S, StringLength, ReadIndex, WriteIndex);
        Inc(WriteIndex);
      end
      else
      if SameText(Copy(S, ReadIndex, 5), '&amp;') then
      begin
        S[WriteIndex] := '&';
        Inc(WriteIndex);
        Inc(ReadIndex, 4);
      end
      else
      if SameText(Copy(S, ReadIndex, 4), '&lt;') then
      begin
        S[WriteIndex] := '<';
        Inc(WriteIndex);
        Inc(ReadIndex, 3);
      end
      else
      if SameText(Copy(S, ReadIndex, 4), '&gt;') then
      begin
        S[WriteIndex] := '>';
        Inc(WriteIndex);
        Inc(ReadIndex, 3);
      end
      else
      if SameText(Copy(S, ReadIndex, 6), '&apos;') then
      begin
        S[WriteIndex] := #39;
        Inc(WriteIndex);
        Inc(ReadIndex, 5);
      end
      else
      if SameText(Copy(S, ReadIndex, 6), '&quot;') then
      begin
        S[WriteIndex] := '"';
        Inc(WriteIndex);
        Inc(ReadIndex, 5);
      end
      else
      begin
        S[WriteIndex] := S[ReadIndex];
        Inc(WriteIndex);
      end;
    end
    else
    begin
      S[WriteIndex] := S[ReadIndex];
      Inc(WriteIndex);
    end;
    Inc(ReadIndex);
  end;
  if WriteIndex > 0 then
    SetLength(S, WriteIndex - 1)
  else
    SetLength(S, 0);
    // this call lowers conversion speed by ~65%, ie 21MB/sec -> 7MB/sec (repeated tests, various inputs)
//  if TrimBlanks then
//    S := AdjustLineBreaks(S);
end;

function XMLEncode(const S: string): string;
begin
  Result := SimpleXMLEncode(S);
end;

function XMLDecode(const S: string): string;
begin
  Result := S;
  SimpleXMLDecode(Result, False);
end;

//=== { THsJclSimpleItem } =====================================================

procedure THsJclSimpleItem.SetName(const Value: string);
begin
  FName := Value;
end;

//=== { THsJclSimpleItemHashedList } ===========================================

procedure THsJclSimpleItemHashedList.Clear;
begin
  InvalidateHash;
  inherited Clear;
end;

constructor THsJclSimpleItemHashedList.Create(ACaseSensitive: Boolean);
begin
  inherited Create(True);
  FCaseSensitive := ACaseSensitive;
end;

destructor THsJclSimpleItemHashedList.Destroy;
begin
  FreeAndNil(FNameHash);
  inherited Destroy;
end;

function THsJclSimpleItemHashedList.Add(Item: THsJclSimpleItem): Integer;
begin
  Result := inherited Add(Item);
  if FNameHash <> nil then
  begin
    if FCaseSensitive then
      FNameHash.Add(Item.Name, Result)
    else
      FNameHash.Add(UpperCase(Item.Name), Result);
  end;
end;

function THsJclSimpleItemHashedList.Extract(Item: THsJclSimpleItem): THsJclSimpleItem;
begin
  Result := THsJclSimpleItem(inherited Extract(Item));
  InvalidateHash;
end;

function THsJclSimpleItemHashedList.GetSimpleItem(Index: Integer): THsJclSimpleItem;
begin
  Result := THsJclSimpleItem(GetItem(Index));
end;

function THsJclSimpleItemHashedList.GetSimpleItemByName(const Name: string): THsJclSimpleItem;
var
  I: Integer;
begin
  I := IndexOfName(Name);
  if I >= 0 then
    Result := THsJclSimpleItem(Items[I])
  else
    Result := nil;
end;

function THsJclSimpleItemHashedList.IndexOfSimpleItem(Item: THsJclSimpleItem): Integer;
begin
  Result := IndexOf(Item);
end;

function THsJclSimpleItemHashedList.IndexOfName(const Name: string): Integer;
var
  I: Integer;
begin
  if FCaseSensitive then
  begin
    if FNameHash = nil then
    begin
      FNameHash := TStringHash.Create(8);
      for I := 0 to Count - 1 do
        FNameHash.Add(THsJclSimpleData(Items[I]).Name, I);
    end;
    Result := FNameHash.ValueOf(Name);
  end
  else
  begin
    if FNameHash = nil then
    begin
      FNameHash := TStringHash.Create(8);
      for I := 0 to Count - 1 do
        FNameHash.Add(UpperCase(THsJclSimpleData(Items[I]).Name), I);
    end;
    Result := FNameHash.ValueOf(UpperCase(Name));
  end;
end;

procedure THsJclSimpleItemHashedList.Insert(Index: Integer; Item: THsJclSimpleItem);
begin
  InvalidateHash;
  inherited Insert(Index, Item);
end;

procedure THsJclSimpleItemHashedList.InvalidateHash;
begin
  FreeAndNil(FNameHash);
end;

procedure THsJclSimpleItemHashedList.Move(CurIndex, NewIndex: Integer);
begin
  InvalidateHash;
  inherited Move(CurIndex, NewIndex);
end;

procedure THsJclSimpleItemHashedList.Notify(Ptr: Pointer; Action: TListNotification);
begin
  if (Action = lnDeleted) and (FNameHash <> nil) then
  begin
//    Mantis 0006062 Hotfix
//    if FCaseSensitive then
//      FNameHash.Remove(THsJclSimpleItem(Ptr).Name)
//    else
//      FNameHash.Remove(UpperCase(THsJclSimpleItem(Ptr).Name));
    InvalidateHash;
  end;
  inherited Notify(Ptr, Action);
end;

procedure THsJclSimpleItemHashedList.SetCaseSensitive(const Value: Boolean);
begin
  if FCaseSensitive <> Value then
  begin
    InvalidateHash;
    FCaseSensitive := Value;
  end;
end;

//=== { THsJclSimpleData } =====================================================

constructor THsJclSimpleData.Create;
begin
  inherited Create;
end;

constructor THsJclSimpleData.Create(const AName: string);
begin
  inherited Create;
  FName := AName;
end;

constructor THsJclSimpleData.Create(const AName, AValue: string);
begin
  inherited Create;
  FName := AName;
  FValue := AValue;
end;

function THsJclSimpleData.GetAnsiValue: AnsiString;
begin
  Result := AnsiString(Value);
end;

function THsJclSimpleData.GetBoolValue: Boolean;
begin
  Result := StrToBoolDef(Value, False);
end;

function THsJclSimpleData.GetFloatValue: Extended;
begin
  Result := 0.0;
  if not TryStrToFloat(Value, Result) then
    Result := 0.0;
end;

function THsJclSimpleData.GetIntValue: Int64;
begin
  Result := StrToInt64Def(Value, -1);
end;

procedure THsJclSimpleData.SetAnsiValue(const Value: AnsiString);
begin
  Self.Value := string(Value);
end;

procedure THsJclSimpleData.SetBoolValue(const Value: Boolean);
begin
  FValue := BoolToStr(Value);
end;

procedure THsJclSimpleData.SetFloatValue(const Value: Extended);
begin
  FValue := FloatToStr(Value);
end;

procedure THsJclSimpleData.SetIntValue(const Value: Int64);
begin
  FValue := IntToStr(Value);
end;

//=== { THsJclSimpleXMLData } ==================================================

function THsJclSimpleXMLData.FullName: string;
begin
  if NameSpace <> '' then
    Result := NameSpace + ':' + Name
  else
    Result := Name;
end;

//=== { THsJclSimpleXML } ======================================================

constructor THsJclSimpleXML.Create;
begin
  inherited Create;
  FRoot := THsJclSimpleXMLElemClassic.Create(Self);
  FProlog := THsJclSimpleXMLElemsProlog.Create(Self);
  FOptions := [sxoAutoIndent, sxoAutoEncodeValue, sxoAutoEncodeEntity];
  FIndentString := '  ';
end;

destructor THsJclSimpleXML.Destroy;
begin
  FreeAndNil(FRoot);
  FreeAndNil(FProlog);
  inherited Destroy;
end;

procedure THsJclSimpleXML.DoDecodeValue(var Value: string);
begin
  if sxoAutoEncodeValue in Options then
    SimpleXMLDecode(Value, False)
  else
  if sxoAutoEncodeEntity in Options then
    Value := EntityDecode(Value);
  if Assigned(FOnDecodeValue) then
    FOnDecodeValue(Self, Value);
end;

procedure THsJclSimpleXML.DoEncodeValue(var Value: string);
begin
  if Assigned(FOnEncodeValue) then
    FOnEncodeValue(Self, Value);
  if sxoAutoEncodeValue in Options then
    Value := SimpleXMLEncode(Value)
  else
  if sxoAutoEncodeEntity in Options then
    Value := EntityEncode(Value);
end;

procedure THsJclSimpleXML.DoLoadProgress(const APosition, ATotal: Integer);
begin
  if Assigned(FOnLoadProg) then
    FOnLoadProg(Self, APosition, ATotal);
end;

procedure THsJclSimpleXML.DoSaveProgress;
begin
  if Assigned(FOnSaveProg) then
  begin
    Inc(FSaveCurrent);
    FOnSaveProg(Self, FSaveCurrent, FSaveCount);
  end;
end;

procedure THsJclSimpleXML.DoTagParsed(const AName: string);
begin
  if Assigned(FOnTagParsed) then
    FOnTagParsed(Self, AName);
end;

procedure THsJclSimpleXML.DoValueParsed(const AName, AValue: string);
begin
  if Assigned(FOnValue) then
    FOnValue(Self, AName, AValue);
end;

procedure THsJclSimpleXML.LoadFromFile(const FileName: TFileName; Encoding: THsJclStringEncoding; CodePage: Word);
var
  Stream: TMemoryStream;
begin
  Stream := TMemoryStream.Create;
  try
    Stream.LoadFromFile(FileName);
    LoadFromStream(Stream, Encoding, CodePage);
  finally
    Stream.Free;
  end;
end;

procedure THsJclSimpleXML.LoadFromResourceName(Instance: THandle; const ResName: string;
  Encoding: THsJclStringEncoding; CodePage: Word);
{$IFNDEF MSWINDOWS}
const
  RT_RCDATA = PChar(10);
{$ENDIF !MSWINDOWS}
var
  Stream: TResourceStream;
begin
  Stream := TResourceStream.Create(Instance, ResName, RT_RCDATA);
  try
    LoadFromStream(Stream, Encoding, CodePage);
  finally
    Stream.Free;
  end;
end;

procedure THsJclSimpleXML.LoadFromStream(Stream: TStream; Encoding: THsJclStringEncoding; CodePage: Word);
var
  AOutStream: TStream;
  AStringStream: TStringStream;
  DoFree: Boolean;
begin
  FRoot.Clear;
  FProlog.Clear;
  AOutStream := nil;
  DoFree := False;
  try
    if Assigned(FOnDecodeStream) then
    begin
      AOutStream := TMemoryStream.Create;
      DoFree := True;
      FOnDecodeStream(Self, Stream, AOutStream);
      AOutStream.Seek(0, soBeginning);
    end
    else
      AOutStream := Stream;

    case Encoding of
      seAnsi:
        begin
          AStringStream := THsJclAnsiStream.Create(AOutStream, False);
          THsJclAnsiStream(AStringStream).CodePage := CodePage;
        end;
      seUTF8:
        AStringStream := THsJclUTF8Stream.Create(AOutStream, False);
      seUTF16:
        AStringStream := THsJclUTF16Stream.Create(AOutStream, False);
    else
      AStringStream := THsJclAutoStream.Create(AOutStream, False);
      if CodePage <> CP_ACP then
        THsJclAutoStream(AStringStream).CodePage := CodePage;
    end;
    try
      AStringStream.SkipBOM;

      LoadFromStringStream(AStringStream);

      // save codepage and encoding for future saves
      if AStringStream is THsJclAutoStream then
      begin
        FCodePage := THsJclAutoStream(AStringStream).CodePage;
        FEncoding := THsJclAutoStream(AStringStream).Encoding;
      end
      else
      if AStringStream is THsJclAnsiStream then
      begin
        FCodePage := THsJclAnsiStream(AStringStream).CodePage;
        FEncoding := Encoding;
      end
      else
      begin
        FCodePage := CodePage;
        FEncoding := Encoding;
      end;
    finally
      AStringStream.Free;
    end;
  finally
    if DoFree then
      AOutStream.Free;
  end;
end;

procedure THsJclSimpleXML.LoadFromStringStream(StringStream: TStringStream);
var
  BufferSize: Integer;
begin
  if Assigned(FOnLoadProg) then
    FOnLoadProg(Self, StringStream.Stream.Position, StringStream.Stream.Size);

  BufferSize := StringStream.BufferSize;
  StringStream.BufferSize := 1;

  // Read doctype and so on
  FProlog.LoadFromStringStream(StringStream);

  StringStream.BufferSize := BufferSize;

  // Read elements
  FRoot.LoadFromStringStream(StringStream);

  if Assigned(FOnLoadProg) then
    FOnLoadProg(Self, StringStream.Stream.Position, StringStream.Stream.Size);
end;

procedure THsJclSimpleXML.LoadFromString(const Value: string);
var
  Stream: TStringStream;
begin
  Stream := TStringStream.Create(Value {$IFDEF SUPPORTS_UNICODE}, TEncoding.Unicode{$ENDIF});
  try
    LoadFromStream(Stream {$IFDEF SUPPORTS_UNICODE}, seUTF16, CP_UTF16LE{$ENDIF});
  finally
    Stream.Free;
  end;
end;

procedure THsJclSimpleXML.GetEncodingFromXMLHeader(var Encoding: THsJclStringEncoding; var CodePage: Word);
var
  XMLHeader: THsJclSimpleXMLElemHeader;
  I: Integer;
begin
  XMLHeader := nil;
  for I := 0 to Prolog.Count - 1 do
    if Prolog.Item[I] is THsJclSimpleXMLElemHeader then
    begin
      XMLHeader := THsJclSimpleXMLElemHeader(Prolog.Item[I]);
      Break;
    end;
  if Assigned(XMLHeader) then
  begin
    CodePage := CodePageFromCharsetName(XMLHeader.Encoding);
    case CodePage of
      CP_UTF8:
        Encoding := seUTF8;
      CP_UTF16LE:
        Encoding := seUTF16;
    else
      Encoding := seAnsi;
    end;
  end
  else
  begin
    // restore from previous load
    Encoding := FEncoding;
    CodePage := FCodePage;
  end;
end;

procedure THsJclSimpleXML.SaveToFile(const FileName: TFileName; Encoding: THsJclStringEncoding; CodePage: Word);
var
  Stream: TMemoryStream;
begin
  Stream := TMemoryStream.Create;
  try
    SaveToStream(Stream, Encoding, CodePage);
    Stream.SaveToFile(FileName);
  finally
    Stream.Free;
  end;
end;

procedure THsJclSimpleXML.SaveToStream(Stream: TStream; Encoding: THsJclStringEncoding; CodePage: Word);
var
  AOutStream: TStream;
  AStringStream: TStringStream;
  DoFree: Boolean;
begin
  if Assigned(FOnEncodeStream) then
  begin
    AOutStream := TMemoryStream.Create;
    DoFree := True;
  end
  else
  begin
    AOutStream := Stream;
    DoFree := False;
  end;
  try
    if Encoding = seAuto then
      GetEncodingFromXMLHeader(Encoding, CodePage);

    case Encoding of
      seUTF8:
        begin
          AStringStream := THsJclUTF8Stream.Create(AOutStream, False);
          FCodePage := CP_UTF8;
        end;
      seUTF16:
        begin
          AStringStream := THsJclUTF16Stream.Create(AOutStream, False);
          FCodePage := CP_UTF16LE;
        end
    else
      AStringStream := THsJclAnsiStream.Create(AOutStream);
      THsJclAnsiStream(AStringStream).CodePage := CodePage;
    end;
    try
      if not (sxoDoNotSaveBOM in Options) then
        AStringStream.WriteBOM;
      SaveToStringStream(AStringStream);
      AStringStream.Flush;
    finally
      AStringStream.Free;
    end;
    if Assigned(FOnEncodeStream) then
    begin
      AOutStream.Seek(0, soBeginning);
      FOnEncodeStream(Self, AOutStream, Stream);
    end;
  finally
    if DoFree then
      AOutStream.Free;
  end;
end;

procedure THsJclSimpleXML.SaveToStringStream(StringStream: TStringStream);
var
  lCount: Integer;
begin
  lCount := Root.ChildsCount + Prolog.Count;
  FSaveCount := lCount;
  FSaveCurrent := 0;

  if Assigned(FOnSaveProg) then
    FOnSaveProg(Self, 0, lCount);

  if not (sxoDoNotSaveProlog in FOptions) then
    Prolog.SaveToStringStream(StringStream);

  Root.SaveToStringStream(StringStream, BaseIndentString);

  if Assigned(FOnSaveProg) then
    FOnSaveProg(Self, lCount, lCount);
end;

function THsJclSimpleXML.SaveToString: string;
begin
  Result := SaveToStringEncoding(seAuto, CP_ACP);
end;

function THsJclSimpleXML.SaveToStringEncoding(Encoding: THsJclStringEncoding; CodePage: Word): string;
var
  Stream: TStringStream;
begin
  {$IFDEF SUPPORTS_UNICODE}
  // Use the same logic for seAuto as in SaveToStream for creating the TStringStream.
  // Otherwise a Unicode-TStringStream is written to from a THsJclAnsiStream proxy.
  if Encoding = seAuto then
    GetEncodingFromXMLHeader(Encoding, CodePage);

  case Encoding of
    seAnsi:
      Stream := TStringStream.Create('', TEncoding.{$IFDEF COMPILER16_UP}ANSI{$ELSE}Default{$ENDIF});
    seUTF8:
      Stream := TStringStream.Create('', TEncoding.UTF8);
  else
    //seUTF16:
    Stream := TStringStream.Create('', TEncoding.Unicode);
  end;
  {$ELSE ~SUPPORTS_UNICODE}
  Stream := TStringStream.Create('');
  {$ENDIF ~SUPPORTS_UNICODE}
  try
    SaveToStream(Stream, Encoding, CodePage);
    Result := Stream.DataString;
  finally
    Stream.Free;
  end;
end;

procedure THsJclSimpleXML.SetBaseIndentString(const Value: string);
begin
  // test if the new value is only made of spaces or tabs
  if not StrContainsChars(Value, CharIsWhiteSpace, True) then
    Exit;

  FBaseIndentString := Value;
end;

procedure THsJclSimpleXML.SetFileName(const Value: TFileName);
begin
  FFileName := Value;
  LoadFromFile(Value);
end;

//=== { THsJclSimpleXMLElem } ==================================================

procedure THsJclSimpleXMLElem.Assign(Value: THsJclSimpleXMLElem);
var
  Elems: THsJclSimpleXMLElem;
  SrcElem, DestElem: THsJclSimpleXMLElem;
  I: Integer;
  SrcProps, DestProps: THsJclSimpleXMLProps;
  SrcProp: THsJclSimpleXMLProp;
  SrcElems, DestElems: THsJclSimpleXMLElems;
begin
  Clear;
  if Value = nil then
    Exit;
  Elems := THsJclSimpleXMLElem(Value);
  Name := Elems.Name;
  Self.Value := Elems.Value;
  SrcProps := Elems.FProps;
  if Assigned(SrcProps) then
  begin
    DestProps := Properties;
    for I := 0 to SrcProps.Count - 1 do
    begin
      SrcProp := SrcProps.Item[I];
      DestProps.Add(SrcProp.Name, SrcProp.Value);
    end;
  end;

  SrcElems := Elems.FItems;
  if Assigned(SrcElems) then
  begin
    DestElems := Items;
    for I := 0 to SrcElems.Count - 1 do
    begin
      // Create from the class type, so that the virtual constructor is called
      // creating an element of the correct class type.
      SrcElem := SrcElems.Item[I];
      DestElem := THsJclSimpleXMLElemClass(SrcElem.ClassType).Create(SrcElem.Name, SrcElem.Value);
      DestElem.Assign(SrcElem);
      DestElems.Add(DestElem);
    end;
  end;
end;

procedure THsJclSimpleXMLElem.Clear;
begin
  if FItems <> nil then
    FItems.Clear;
  if FProps <> nil then
    FProps.Clear;
end;

constructor THsJclSimpleXMLElem.Create(ASimpleXML: THsJclSimpleXML);
begin
  Create;
  FSimpleXML := ASimpleXML;
end;

destructor THsJclSimpleXMLElem.Destroy;
begin
  FSimpleXML := nil;
  FParent := nil;
  Clear;
  FreeAndNil(FItems);
  FreeAndNil(FProps);
  inherited Destroy;
end;

procedure THsJclSimpleXMLElem.Error(const S: string);
begin
  raise EHsJclSimpleXMLError.Create(S);
end;

procedure THsJclSimpleXMLElem.FmtError(const S: string;
  const Args: array of const);
begin
  Error(Format(S, Args));
end;

procedure THsJclSimpleXMLElem.GetBinaryValue(Stream: TStream; BufferSize: Integer = 0);
var
  I, J, ValueLength, RequiredStreamSize: Integer;
  Buf: array of Byte;
  N1, N2: Byte;

  function NibbleCharToNibble(const AChar: Char): Byte;
  begin
    case AChar of
      '0': Result := 0;
      '1': Result := 1;
      '2': Result := 2;
      '3': Result := 3;
      '4': Result := 4;
      '5': Result := 5;
      '6': Result := 6;
      '7': Result := 7;
      '8': Result := 8;
      '9': Result := 9;
      'a', 'A': Result := 10;
      'b', 'B': Result := 11;
      'c', 'C': Result := 12;
      'd', 'D': Result := 13;
      'e', 'E': Result := 14;
      'f', 'F': Result := 15;
      else
        Result := 16;
    end;
  end;

  procedure PrepareNibbleCharMapping;
  var
    C: Char;
  begin
    if not PreparedNibbleCharMapping then
    begin
      for C := Low(Char) to High(Char) do
        NibbleCharMapping[C] := NibbleCharToNibble(C);
      PreparedNibbleCharMapping := True;
    end;
  end;

var
  CurrentStreamPosition: Integer;
begin
  if BufferSize = 0 then
    BufferSize := cBufferSize;

  SetLength(Buf, BufferSize);
  PrepareNibbleCharMapping;
  I := 1;
  J := 0;
  ValueLength := Length(Value);
  RequiredStreamSize := Stream.Position + ValueLength div 2;
  if Stream.Size < RequiredStreamSize then
  begin
    CurrentStreamPosition := Stream.Position;
    Stream.Size := RequiredStreamSize;
    Stream.Seek(CurrentStreamPosition, soBeginning);
  end;
  while I < ValueLength do
  begin
    //faster replacement for St := '$' + Value[I] + Value[I + 1]; Buf[J] := StrToIntDef(St, 0);
    N1 := NibbleCharMapping[Value[I]];
    N2 := NibbleCharMapping[Value[I + 1]];
    Inc(I, 2);
    if (N1 > 15) or (N2 > 15) then
      Buf[J] := 0
    else
      Buf[J] := (N1 shl 4) or N2;
    Inc(J);
    if J = Length(Buf) - 1 then //Buffered write to speed up the process a little
    begin
      Stream.Write(Buf[0], J);
      J := 0;
    end;
  end;
  Stream.Write(Buf[0], J);
end;

function THsJclSimpleXMLElem.GetChildIndex(const AChild: THsJclSimpleXMLElem): Integer;
begin
  if FItems = nil then
    Result := -1
  else
    Result := FItems.FElems.IndexOfSimpleItem(AChild);
end;

function THsJclSimpleXMLElem.GetChildsCount: Integer;
var
  I: Integer;
begin
  Result := 1;
  if FItems <> nil then
    for I := 0 to FItems.Count - 1 do
      Result := Result + FItems[I].ChildsCount;
end;

function THsJclSimpleXMLElem.GetHasItems: Boolean;
begin
  Result := Assigned(FItems) and (FItems.Count > 0);
end;

function THsJclSimpleXMLElem.GetHasProperties: Boolean;
begin
  Result := Assigned(FProps) and (FProps.Count > 0);
end;

function THsJclSimpleXMLElem.GetItemCount: Integer;
begin
  Result := 0;
  if Assigned(FItems) then
    Result := FItems.Count;
end;

function THsJclSimpleXMLElem.GetItems: THsJclSimpleXMLElems;
begin
  if FItems = nil then
    FItems := THsJclSimpleXMLElems.Create(Self);
  Result := FItems;
end;

function THsJclSimpleXMLElem.GetNamedIndex(const AChild: THsJclSimpleXMLElem): Integer;
begin
  Result := Items.NamedElems[AChild.Name].IndexOf(AChild);
end;

function THsJclSimpleXMLElem.GetPropertyCount: Integer;
begin
  Result := 0;
  if Assigned(FProps) then
    Result := FProps.Count;
end;

function THsJclSimpleXMLElem.GetProps: THsJclSimpleXMLProps;
begin
  if FProps = nil then
    FProps := THsJclSimpleXMLProps.Create(Self);
  Result := FProps;
end;

procedure THsJclSimpleXMLElem.LoadFromString(const Value: string);
var
  Stream: TStringStream;
  StrStream: TStringStream;
begin
  StrStream := TStringStream.Create(Value);
  try
    Stream := THsJclAutoStream.Create(StrStream);
    try
      LoadFromStringStream(Stream);
    finally
      Stream.Free;
    end;
  finally
    StrStream.Free;
  end;
end;

function THsJclSimpleXMLElem.SaveToString: string;
var
  Stream: TStringStream;
  StrStream: TStringStream;
begin
  StrStream := TStringStream.Create('');
  try
    Stream := THsJclAutoStream.Create(StrStream);
    try
      SaveToStringStream(Stream);
      Stream.Flush;
    finally
      Stream.Free;
    end;
    Result := StrStream.DataString;
  finally
    StrStream.Free;
  end;
end;

procedure THsJclSimpleXMLElem.SetName(const Value: string);
begin
  if (Value <> Name) and (Value <> '') then
  begin
    if (Parent <> nil) and (Name <> '') then
      Parent.Items.DoItemRename(Self, Value);
    inherited SetName(Value);
  end;
end;

//=== { THsJclSimpleXMLNamedElemsEnumerator } ==================================

{$IFDEF SUPPORTS_FOR_IN}
constructor THsJclSimpleXMLNamedElemsEnumerator.Create(AList: THsJclSimpleXMLNamedElems);
begin
  inherited Create;
  FIndex := -1;
  FList := AList;
end;

function THsJclSimpleXMLNamedElemsEnumerator.GetCurrent: THsJclSimpleXMLElem;
begin
  Result := FList[FIndex];
end;

function THsJclSimpleXMLNamedElemsEnumerator.MoveNext: Boolean;
begin
  Result := FIndex < FList.Count - 1;
  if Result then
    Inc(FIndex);
end;
{$ENDIF SUPPORTS_FOR_IN}

//=== { THsJclSimpleXMLNamedElems } ============================================

constructor THsJclSimpleXMLNamedElems.Create(AElems: THsJclSimpleXMLElems; const AName: string);
begin
  inherited Create;
  FElems := AElems;
  FName := AName;
  FItems := TList.Create;
end;

destructor THsJclSimpleXMLNamedElems.Destroy;
begin
  FItems.Free;
  inherited Destroy;
end;

function THsJclSimpleXMLNamedElems.Add(const Value: Int64): THsJclSimpleXMLElemClassic;
begin
  Result := Elems.Add(Name, Value);
end;

function THsJclSimpleXMLNamedElems.Add(Value: TStream): THsJclSimpleXMLElemClassic;
begin
  Result := Elems.Add(Name, Value);
end;

function THsJclSimpleXMLNamedElems.Add(const Value: Boolean): THsJclSimpleXMLElemClassic;
begin
  Result := Elems.Add(Name, Value);
end;

function THsJclSimpleXMLNamedElems.Add: THsJclSimpleXMLElemClassic;
begin
  Result := Elems.Add(Name);
end;

function THsJclSimpleXMLNamedElems.Add(const Value: string): THsJclSimpleXMLElemClassic;
begin
  Result := Elems.Add(Name, Value);
end;

function THsJclSimpleXMLNamedElems.AddCData(const Value: string): THsJclSimpleXMLElemCData;
begin
  Result := Elems.AddCData(Name, Value);
end;

function THsJclSimpleXMLNamedElems.AddComment(const Value: string): THsJclSimpleXMLElemComment;
begin
  Result := Elems.AddComment(Name, Value);
end;

function THsJclSimpleXMLNamedElems.AddFirst: THsJclSimpleXMLElemClassic;
begin
  Result := Elems.AddFirst(Name);
end;

function THsJclSimpleXMLNamedElems.AddText(const Value: string): THsJclSimpleXMLElemText;
begin
  Result := Elems.AddText(Name, Value);
end;

procedure THsJclSimpleXMLNamedElems.Clear;
var
  Index: Integer;
begin
  for Index := FItems.Count - 1 downto 0 do
    Elems.Remove(THsJclSimpleXMLElem(FItems.Items[Index]));
end;

procedure THsJclSimpleXMLNamedElems.Delete(const Index: Integer);
begin
  if (Index >= 0) and (Index < FItems.Count) then
    Elems.Remove(THsJclSimpleXMLElem(FItems.Items[Index]));
end;

function THsJclSimpleXMLNamedElems.GetCount: Integer;
begin
  Result := FItems.Count;
end;

{$IFDEF SUPPORTS_FOR_IN}
function THsJclSimpleXMLNamedElems.GetEnumerator: THsJclSimpleXMLNamedElemsEnumerator;
begin
  Result := THsJclSimpleXMLNamedElemsEnumerator.Create(Self);
end;
{$ENDIF SUPPORTS_FOR_IN}

function THsJclSimpleXMLNamedElems.GetItem(const Index: Integer): THsJclSimpleXMLElem;
begin
  if (Index >= 0) then
  begin
    While (Index >= Count) do
      if Assigned(Elems.Parent) and Assigned(Elems.Parent.SimpleXML) and
         (sxoAutoCreate in Elems.Parent.SimpleXML.Options) then
        Add
      else
        break;
    if Index < Count then
      Result := THsJclSimpleXMLElem(FItems.Items[Index])
    else
      Result := nil;
  end
  else
    Result := nil;
end;

function THsJclSimpleXMLNamedElems.IndexOf(const Value: THsJclSimpleXMLElem): Integer;
begin
  Result := FItems.IndexOf(Value);
end;

function THsJclSimpleXMLNamedElems.IndexOf(const Value: string): Integer;
var
  Index: Integer;
  NewItem: THsJclSimpleXMLElem;
begin
  Result := -1;
  for Index := 0 to FItems.Count - 1 do
    if THsJclSimpleXMLElem(FItems.Items[Index]).Value = Value then
  begin
    Result := Index;
    Break;
  end;
  if (Result = -1) and (sxoAutoCreate in Elems.Parent.SimpleXML.Options) then
  begin
    NewItem := Elems.Add(Name, Value);
    Result := FItems.IndexOf(NewItem);
  end;
end;

procedure THsJclSimpleXMLNamedElems.Move(const CurIndex, NewIndex: Integer);
var
  ElemsCurIndex, ElemsNewIndex: Integer;
begin
  ElemsCurIndex := Elems.IndexOf(THsJclSimpleXMLElem(FItems.Items[CurIndex]));
  ElemsNewIndex := Elems.IndexOf(THsJclSimpleXMLElem(FItems.Items[NewIndex]));
  Elems.Move(ElemsCurIndex, ElemsNewIndex);
  FItems.Move(CurIndex, NewIndex);
end;

procedure THsJclSimpleXMLNamedElems.SetName(const Value: string);
begin
  raise EHsJclSimpleXMLError.CreateRes(@SReadOnlyProperty);
end;

//=== { THsJclSimpleXMLElemsEnumerator } =======================================

{$IFDEF SUPPORTS_FOR_IN}
constructor THsJclSimpleXMLElemsEnumerator.Create(AList: THsJclSimpleXMLElems);
begin
  inherited Create;
  FIndex := -1;
  FList := AList;
end;

function THsJclSimpleXMLElemsEnumerator.GetCurrent: THsJclSimpleXMLElem;
begin
  Result := FList[FIndex];
end;

function THsJclSimpleXMLElemsEnumerator.MoveNext: Boolean;
begin
  Result := FIndex < FList.Count - 1;
  if Result then
    Inc(FIndex);
end;
{$ENDIF SUPPORTS_FOR_IN}

//=== { THsJclSimpleXMLElems } =================================================

function THsJclSimpleXMLElems.Add(const Name: string): THsJclSimpleXMLElemClassic;
begin
  Result := THsJclSimpleXMLElemClassic.Create(Name);
  AddChild(Result);
end;

function THsJclSimpleXMLElems.Add(const Name, Value: string): THsJclSimpleXMLElemClassic;
begin
  Result := THsJclSimpleXMLElemClassic.Create(Name, Value);
  AddChild(Result);
end;

function THsJclSimpleXMLElems.Add(const Name: string; const Value: Int64): THsJclSimpleXMLElemClassic;
begin
  Result := THsJclSimpleXMLElemClassic.Create(Name, IntToStr(Value));
  AddChild(Result);
end;

function THsJclSimpleXMLElems.Add(Value: THsJclSimpleXMLElem): THsJclSimpleXMLElem;
begin
  if Value <> nil then
    AddChild(Value);
  Result := Value;
end;

function THsJclSimpleXMLElems.Add(const Name: string; const Value: Boolean): THsJclSimpleXMLElemClassic;
begin
  Result := THsJclSimpleXMLElemClassic.Create(Name, BoolToStr(Value));
  AddChild(Result);
end;

function THsJclSimpleXMLElems.Add(const Name: string; Value: TStream; BufferSize: Integer): THsJclSimpleXMLElemClassic;
var
  Stream: TStringStream;
  Buf: array of Byte;
  St: string;
  I, Count: Integer;
begin
  Stream := TStringStream.Create('');
  try
    if BufferSize = 0 then
      BufferSize := cBufferSize;

    SetLength(Buf, BufferSize);
    Buf[0] := 0;
    repeat
      Count := Value.Read(Buf[0], Length(Buf));
      St := '';
      for I := 0 to Count - 1 do
        St := St + IntToHex(Buf[I], 2);
      Stream.WriteString(St);
    until Count = 0;
    Result := THsJclSimpleXMLElemClassic.Create(Name, Stream.DataString);
    AddChild(Result);
  finally
    Stream.Free;
  end;
end;

procedure THsJclSimpleXMLElems.AddChild(const Value: THsJclSimpleXMLElem);
var
  NamedIndex: Integer;
begin
  CreateElems;

  // If there already is a container, notify it to remove the element
  if Assigned(Value.Parent) then
    Value.Parent.Items.Notify(Value, opRemove);

  FElems.Add(Value);

  if FNamedElems <> nil then
  begin
    NamedIndex := FNamedElems.IndexOfName(Value.Name);
    if NamedIndex >= 0 then
      THsJclSimpleXMLNamedElems(FNamedElems.SimpleItems[NamedIndex]).FItems.Add(Value);
  end;

  Notify(Value, opInsert);
end;

procedure THsJclSimpleXMLElems.AddChildFirst(const Value: THsJclSimpleXMLElem);
var
  NamedIndex: Integer;
begin
  CreateElems;

  // If there already is a container, notify it to remove the element
  if Assigned(Value.Parent) then
    Value.Parent.Items.Notify(Value, opRemove);

  FElems.Insert(0, Value);

  if FNamedElems <> nil then
  begin
    NamedIndex := FNamedElems.IndexOfName(Value.Name);
    if NamedIndex >= 0 then
      THsJclSimpleXMLNamedElems(FNamedElems.SimpleItems[NamedIndex]).FItems.Insert(0, Value);
  end;

  Notify(Value, opInsert);
end;

function THsJclSimpleXMLElems.AddFirst(const Name: string): THsJclSimpleXMLElemClassic;
begin
  Result := THsJclSimpleXMLElemClassic.Create(Name);
  AddChildFirst(Result);
end;

function THsJclSimpleXMLElems.AddFirst(Value: THsJclSimpleXMLElem): THsJclSimpleXMLElem;
begin
  if Value <> nil then
    AddChildFirst(Value);
  Result := Value;
end;

function THsJclSimpleXMLElems.AddComment(const Name,
  Value: string): THsJclSimpleXMLElemComment;
begin
  Result := THsJclSimpleXMLElemComment.Create(Name, Value);
  AddChild(Result);
end;

function THsJclSimpleXMLElems.AddCData(const Name, Value: string): THsJclSimpleXMLElemCData;
begin
  Result := THsJclSimpleXMLElemCData.Create(Name, Value);
  AddChild(Result);
end;

function THsJclSimpleXMLElems.AddText(const Name, Value: string): THsJclSimpleXMLElemText;
begin
  Result := THsJclSimpleXMLElemText.Create(Name, Value);
  AddChild(Result);
end;

procedure THsJclSimpleXMLElems.BinaryValue(const Name: string; Stream: TStream);
var
  Elem: THsJclSimpleXMLElem;
begin
  Elem := GetItemNamed(Name);
  if Elem <> nil then
    Elem.GetBinaryValue(Stream);
end;

function THsJclSimpleXMLElems.BoolValue(const Name: string; Default: Boolean): Boolean;
var
  Elem: THsJclSimpleXMLElem;
begin
  try
    Elem := GetItemNamedDefault(Name, BoolToStr(Default));
    if (Elem = nil) or (Elem.Value = '') then
      Result := Default
    else
      Result := Elem.BoolValue;
  except
    Result := Default;
  end;
end;

procedure THsJclSimpleXMLElems.Clear;
begin
  if FElems <> nil then
    FElems.Clear;
  if FNamedElems <> nil then
    FNamedElems.Clear;
end;

constructor THsJclSimpleXMLElems.Create(AParent: THsJclSimpleXMLElem);
begin
  inherited Create;
  FParent := AParent;
end;

procedure THsJclSimpleXMLElems.CreateElems;
var
  CaseSensitive: Boolean;
begin
  if FElems = nil then
  begin
    CaseSensitive := Assigned(Parent) and Assigned(Parent.SimpleXML)
      and (sxoCaseSensitive in Parent.SimpleXML.Options);
    FElems := THsJclSimpleItemHashedList.Create(CaseSensitive);
  end;
end;

procedure THsJclSimpleXMLElems.Delete(const Index: Integer);
var
  Elem: THsJclSimpleXMLElem;
  NamedIndex: Integer;
begin
  if (FElems <> nil) and (Index >= 0) and (Index < FElems.Count) then
  begin
    Elem := THsJclSimpleXMLElem(FElems.SimpleItems[Index]);
    if FNamedElems <> nil then
    begin
      NamedIndex := FNamedElems.IndexOfName(Elem.Name);
      if NamedIndex >= 0 then
        THsJclSimpleXMLNamedElems(FNamedElems.SimpleItems[NamedIndex]).FItems.Remove(Elem);
    end;
    FElems.Delete(Index);
  end;
end;

procedure THsJclSimpleXMLElems.Delete(const Name: string);
begin
  if FElems <> nil then
    Delete(FElems.IndexOfName(Name));
end;

destructor THsJclSimpleXMLElems.Destroy;
begin
  FParent := nil;
  Clear;
  FreeAndNil(FElems);
  FreeAndNil(FNamedElems);
  inherited Destroy;
end;

procedure THsJclSimpleXMLElems.DoItemRename(Value: THsJclSimpleXMLElem; const Name: string);
var
  NamedIndex: Integer;
begin
  if FNamedElems <> nil then
  begin
    NamedIndex := FNamedElems.IndexOfName(Value.Name);
    if NamedIndex >= 0 then
      THsJclSimpleXMLNamedElems(FNamedElems.SimpleItems[NamedIndex]).FItems.Remove(Value);

    NamedIndex := FNamedElems.IndexOfName(Name);
    if NamedIndex >= 0 then
      THsJclSimpleXMLNamedElems(FNamedElems.SimpleItems[NamedIndex]).FItems.Add(Value);
  end;
  FElems.InvalidateHash;
end;

function THsJclSimpleXMLElems.FloatValue(const Name: string;
  const Default: Extended): Extended;
var
  Elem: THsJclSimpleXMLElem;
begin
  Elem := GetItemNamedDefault(Name, FloatToStr(Default));
  if Elem = nil then
    Result := Default
  else
    Result := Elem.FloatValue;
end;

function THsJclSimpleXMLElems.GetCount: Integer;
begin
  if FElems = nil then
    Result := 0
  else
    Result := FElems.Count;
end;

{$IFDEF SUPPORTS_FOR_IN}
function THsJclSimpleXMLElems.GetEnumerator: THsJclSimpleXMLElemsEnumerator;
begin
  Result := THsJclSimpleXMLElemsEnumerator.Create(Self);
end;
{$ENDIF SUPPORTS_FOR_IN}

function THsJclSimpleXMLElems.GetItem(const Index: Integer): THsJclSimpleXMLElem;
begin
  if (FElems = nil) or (Index > FElems.Count) then
    Result := nil
  else
    Result := THsJclSimpleXMLElem(FElems.SimpleItems[Index]);
end;

function THsJclSimpleXMLElems.GetItemNamedDefault(const Name, Default: string): THsJclSimpleXMLElem;
var
  I: Integer;
begin
  Result := nil;
  if FElems <> nil then
  begin
    I := FElems.IndexOfName(Name);
    if I <> -1 then
      Result := THsJclSimpleXMLElem(FElems.SimpleItems[I])
    else
    if Assigned(Parent) and Assigned(Parent.SimpleXML) and (sxoAutoCreate in Parent.SimpleXML.Options) then
      Result := Add(Name, Default);
  end
  else
  if Assigned(Parent) and Assigned(Parent.SimpleXML) and (sxoAutoCreate in Parent.SimpleXML.Options) then
    Result := Add(Name, Default);
end;

function THsJclSimpleXMLElems.GetNamedElems(const Name: string): THsJclSimpleXMLNamedElems;
var
  NamedIndex: Integer;
  CaseSensitive: Boolean;
begin
  if FNamedElems = nil then
  begin
    CaseSensitive := Assigned(Parent) and Assigned(Parent.SimpleXML)
      and (sxoCaseSensitive in Parent.SimpleXML.Options);
    FNamedElems := THsJclSimpleItemHashedList.Create(CaseSensitive);
  end;
  NamedIndex := FNamedElems.IndexOfName(Name);
  if NamedIndex = -1 then
  begin
    Result := THsJclSimpleXMLNamedElems.Create(Self, Name);
    FNamedElems.Add(Result);
    if FElems <> nil then
      for NamedIndex := 0 to FElems.Count - 1 do
        if FElems.SimpleItems[NamedIndex].Name = Name then
          Result.FItems.Add(FElems.SimpleItems[NamedIndex]);
  end
  else
    Result := THsJclSimpleXMLNamedElems(FNamedElems.SimpleItems[NamedIndex]);
end;

function THsJclSimpleXMLElems.GetItemNamed(const Name: string): THsJclSimpleXMLElem;
begin
  Result := GetItemNamedDefault(Name, '');
end;

function THsJclSimpleXMLElems.IntValue(const Name: string; const Default: Int64): Int64;
var
  Elem: THsJclSimpleXMLElem;
begin
  Elem := GetItemNamedDefault(Name, IntToStr(Default));
  if Elem = nil then
    Result := Default
  else
    Result := Elem.IntValue;
end;

procedure THsJclSimpleXMLElems.LoadFromStringStream(StringStream: TStringStream);
type
  TReadStatus = (rsWaitingTag, rsReadingTagKind);
var
  lPos: TReadStatus;
  St: TUCS4Array;
  lElem: THsJclSimpleXMLElem;
  Ch: UCS4;
  ContainsText, ContainsWhiteSpace, KeepWhiteSpace: Boolean;
  SimpleXML: THsJclSimpleXML;
begin
  SetLength(St, 0);
  lPos := rsWaitingTag;
  SimpleXML := Parent.SimpleXML;
  KeepWhiteSpace := (SimpleXML <> nil) and (sxoKeepWhitespace in SimpleXML.Options);
  ContainsText := False;
  ContainsWhiteSpace := False;

  // We read from a stream, thus replacing the existing items
  Clear;

  if SimpleXML <> nil then
    SimpleXML.DoLoadProgress(StringStream.Stream.Position, StringStream.Stream.Size);

  while StringStream.PeekUCS4(Ch) do
  begin
    case lPos of
      rsWaitingTag: //We are waiting for a tag and thus avoiding spaces
        begin
          if Ch = Ord('<') then
          begin
            lPos := rsReadingTagKind;
            St := UCS4Array(Ch);
          end
          else
          if UnicodeIsWhiteSpace(Ch) then
            ContainsWhiteSpace := True
          else
            ContainsText := True;
        end;

      rsReadingTagKind: //We are trying to determine the kind of the tag
        begin
          lElem := nil;
          case Ch of
            Ord('/'):
              if UCS4ArrayEquals(St, '<') then
              begin // "</"
                // We have reached an end tag. If whitespace was found while
                // waiting for the end tag, and the user told us to keep it
                // then we have to create a text element.
                // But it must only be created if there are no other elements
                // in the list. If we did not check this, we would create a
                // text element for whitespace found between two adjacent end
                // tags.
                if ContainsText or (ContainsWhiteSpace and KeepWhiteSpace) then
                begin
                  lElem := THsJclSimpleXMLElemText.Create;
                  CreateElems;
                  FElems.Add(lElem);
                  Notify(lElem, opInsert);
                  lElem.LoadFromStringStream(StringStream);
                end;
                Break;
              end
              else
              begin
                lElem := THsJclSimpleXMLElemClassic.Create;
                UCS4ArrayConcat(St, Ch); // "<name/"
                lPos := rsWaitingTag;
              end;

            Ord(NativeSpace), Ord('>'), Ord(':'): //This should be a classic tag
              begin    // "<XXX " or "<XXX:" or "<XXX>
                lElem := THsJclSimpleXMLElemClassic.Create;
                SetLength(St, 0);
                lPos := rsWaitingTag;
              end;
          else
            if ContainsText or (ContainsWhiteSpace and KeepWhiteSpace) then
            begin
              // inner text
              lElem := THsJclSimpleXMLElemText.Create;
              lPos := rsReadingTagKind;
              ContainsText := False;
              ContainsWhiteSpace := False;
            end
            else
            begin
              if not UCS4ArrayEquals(St, '<![CDATA') or not UnicodeIsWhiteSpace(Ch) then
                UCS4ArrayConcat(St, Ch);
              if UCS4ArrayEquals(St, '<![CDATA[') then
              begin
                lElem := THsJclSimpleXMLElemCData.Create;
                lPos := rsWaitingTag;
                SetLength(St, 0);
              end
              else
              if UCS4ArrayEquals(St, '<!--') then
              begin
                lElem := THsJclSimpleXMLElemComment.Create;
                lPos := rsWaitingTag;
                SetLength(St, 0);
              end
              else
              if UCS4ArrayEquals(St, '<?') then
              begin
                lElem := THsJclSimpleXMLElemProcessingInstruction.Create;
                lPos := rsWaitingTag;
                SetLength(St, 0);
              end;
            end;
          end;

          if lElem <> nil then
          begin
            CreateElems;
            FElems.Add(lElem);
            Notify(lElem, opInsert);
            lElem.LoadFromStringStream(StringStream);
          end;
        end;
    end;
  end;
end;

procedure THsJclSimpleXMLElems.Notify(Value: THsJclSimpleXMLElem; Operation: TOperation);
var
  NamedIndex: Integer;
begin
  case Operation of
    opRemove:
      if Value.Parent = Parent then  // Only remove if we have it
      begin
        if FNamedElems <> nil then
        begin
          NamedIndex := FNamedElems.IndexOfName(Value.Name);
          if NamedIndex >= 0 then
            THsJclSimpleXMLNamedElems(FNamedElems.SimpleItems[NamedIndex]).FItems.Remove(Value);
        end;
        FElems.Remove(Value);
      end;
    opInsert:
      begin
        Value.FParent := Parent;
        Value.FSimpleXML := Parent.SimpleXML;
      end;
  end;
end;

function THsJclSimpleXMLElems.Remove(Value: THsJclSimpleXMLElem): Integer;
begin
  if FElems = nil
     then Result := -1 // like TList.IndexOf(alien)
     else begin
        Result := FElems.IndexOfSimpleItem(Value);
        Notify(Value, opRemove);
     end;
end;

procedure THsJclSimpleXMLElems.SaveToStringStream(StringStream: TStringStream;
  const Level: string);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Item[I].SaveToStringStream(StringStream, Level);
end;

function THsJclSimpleXMLElems.SimpleCompare(Elems: THsJclSimpleXMLElems; Index1,
  Index2: Integer): Integer;
begin
  Result := CompareText(Elems.Item[Index1].Name, Elems.Item[Index2].Name);
end;

function THsJclSimpleXMLElems.Value(const Name, Default: string): string;
var
  Elem: THsJclSimpleXMLElem;
begin
  Result := '';
  Elem := GetItemNamedDefault(Name, Default);
  if Elem = nil then
    Result := Default
  else
    Result := Elem.Value;
end;

procedure THsJclSimpleXMLElems.Move(const CurIndex, NewIndex: Integer);
begin
  if FElems <> nil then
    FElems.Move(CurIndex, NewIndex);
end;

function THsJclSimpleXMLElems.IndexOf(const Value: THsJclSimpleXMLElem): Integer;
begin
  if FElems = nil then
    Result := -1
  else
    Result := FElems.IndexOfSimpleItem(Value);
end;

function THsJclSimpleXMLElems.IndexOf(const Name: string): Integer;
begin
  if FElems = nil then
    Result := -1
  else
    Result := FElems.IndexOfName(Name);
end;

procedure THsJclSimpleXMLElems.InsertChild(const Value: THsJclSimpleXMLElem; Index: Integer);
var
  NamedIndex: Integer;
begin
  CreateElems;

  // If there already is a container, notify it to remove the element
  if Assigned(Value.Parent) then begin
    if (value.parent<>FParent) then begin
      if FNamedElems <> nil then begin
        NamedIndex := FNamedElems.IndexOfName(Value.Name);
        if NamedIndex >= 0 then
           THsJclSimpleXMLNamedElems(FNamedElems.SimpleItems[NamedIndex]).FItems.Remove(Value);
      end;
      Value.FParent.items.FElems.Extract(Value); //EW here is the real difference
      Value.FParent := nil;
      Value.FSimpleXML := nil;
    end
    else
    begin
      Value.Parent.Items.Notify(Value, opRemove);
    end;
  end;

  FElems.Insert(Index, Value);

  if FNamedElems <> nil then
  begin
    NamedIndex := FNamedElems.IndexOfName(Value.Name);
    if NamedIndex >= 0 then
      THsJclSimpleXMLNamedElems(FNamedElems.SimpleItems[NamedIndex]).FItems.Add(Value);
  end;

  Notify(Value, opInsert);
end;

function THsJclSimpleXMLElems.Insert(Value: THsJclSimpleXMLElem;
  Index: Integer): THsJclSimpleXMLElem;
begin
  if Value <> nil then
    InsertChild(Value, Index);
  Result := Value;
end;

function THsJclSimpleXMLElems.Insert(const Name: string;
  Index: Integer): THsJclSimpleXMLElemClassic;
begin
  Result := THsJclSimpleXMLElemClassic.Create(Name);
  InsertChild(Result, Index);
end;

procedure QuickSort(Elems: THsJclSimpleXMLElems; List: TList; L, R: Integer;
  AFunction: THsJclSimpleXMLElemCompare);
var
  I, J, M: Integer;
begin
  repeat
    I := L;
    J := R;
    M := (L + R) shr 1;
    repeat
      while AFunction(Elems, I, M) < 0 do
        Inc(I);
      while AFunction(Elems, J, M) > 0 do
        Dec(J);
      if I < J then
      begin
        List.Exchange(I, J);
        Inc(I);
        Dec(J);
      end
      else
      if I = J then
      begin
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then
      QuickSort(Elems, List, L, J, AFunction);
    L := I;
  until I >= R;
end;

procedure THsJclSimpleXMLElems.CustomSort(AFunction: THsJclSimpleXMLElemCompare);
begin
  if FElems <> nil then
    QuickSort(Self, FElems, 0, FElems.Count - 1, AFunction);
end;

procedure THsJclSimpleXMLElems.Sort;
begin
  CustomSort(SimpleCompare);
end;

//=== { THsJclSimpleXMLPropsEnumerator } =======================================

{$IFDEF SUPPORTS_FOR_IN}
constructor THsJclSimpleXMLPropsEnumerator.Create(AList: THsJclSimpleXMLProps);
begin
  inherited Create;
  FIndex := -1;
  FList := AList;
end;

function THsJclSimpleXMLPropsEnumerator.GetCurrent: THsJclSimpleXMLProp;
begin
  Result := FList[FIndex];
end;

function THsJclSimpleXMLPropsEnumerator.MoveNext: Boolean;
begin
  Result := FIndex < FList.Count - 1;
  if Result then
    Inc(FIndex);
end;
{$ENDIF SUPPORTS_FOR_IN}

//=== { THsJclSimpleXMLProps } =================================================

function THsJclSimpleXMLProps.Add(const Name, Value: string): THsJclSimpleXMLProp;
begin
  if FProperties = nil then
    FProperties := TStringList.Create;
  Result := THsJclSimpleXMLProp.Create(Parent, Name, Value);
  FProperties.AddObject(Name, Result);
end;

function THsJclSimpleXMLProps.Add(const Name: string; const Value: Int64): THsJclSimpleXMLProp;
begin
  Result := Add(Name, IntToStr(Value));
end;

function THsJclSimpleXMLProps.Add(const Name: string; const Value: Boolean): THsJclSimpleXMLProp;
begin
  Result := Add(Name, BoolToStr(Value));
end;

{$IFDEF SUPPORTS_UNICODE}
function THsJclSimpleXMLProps.Add(const Name: string;
  const Value: AnsiString): THsJclSimpleXMLProp;
begin
  Result := Add(Name, string(Value));
end;
{$ENDIF SUPPORTS_UNICODE}

function THsJclSimpleXMLProps.Insert(const Index: Integer; const Name, Value: string): THsJclSimpleXMLProp;
begin
  if FProperties = nil then
    FProperties := TStringList.Create;
  Result := THsJclSimpleXMLProp.Create(Parent, Name, Value);
  FProperties.InsertObject(Index, Name, Result);
end;

function THsJclSimpleXMLProps.Insert(const Index: Integer; const Name: string; const Value: Int64): THsJclSimpleXMLProp;
begin
  Result := Insert(Index, Name, IntToStr(Value));
end;

function THsJclSimpleXMLProps.Insert(const Index: Integer; const Name: string; const Value: Boolean): THsJclSimpleXMLProp;
begin
  Result := Insert(Index, Name, BoolToStr(Value));
end;

function THsJclSimpleXMLProps.BoolValue(const Name: string; Default: Boolean): Boolean;
var
  Prop: THsJclSimpleXMLProp;
begin
  try
    Prop := GetItemNamedDefault(Name, BoolToStr(Default));
    if (Prop = nil) or (Prop.Value = '') then
      Result := Default
    else
      Result := Prop.BoolValue;
  except
    Result := Default;
  end;
end;

procedure THsJclSimpleXMLProps.Clear;
var
  I: Integer;
begin
  if FProperties <> nil then
  begin
    for I := 0 to FProperties.Count - 1 do
    begin
      THsJclSimpleXMLProp(FProperties.Objects[I]).Free;
      FProperties.Objects[I] := nil;
    end;
    FProperties.Clear;
  end;
end;

procedure THsJclSimpleXMLProps.Delete(const Index: Integer);
begin
  if (FProperties <> nil) and (Index >= 0) and (Index < FProperties.Count) then
  begin
    TObject(FProperties.Objects[Index]).Free;
    FProperties.Delete(Index);
  end;
end;

constructor THsJclSimpleXMLProps.Create(AParent: THsJclSimpleXMLElem);
begin
  inherited Create;
  FParent := AParent;
end;

procedure THsJclSimpleXMLProps.Delete(const Name: string);
begin
  if FProperties <> nil then
    Delete(FProperties.IndexOf(Name));
end;

destructor THsJclSimpleXMLProps.Destroy;
begin
  FParent := nil;
  Clear;
  FreeAndNil(FProperties);
  inherited Destroy;
end;

procedure THsJclSimpleXMLProps.DoItemRename(Value: THsJclSimpleXMLProp; const Name: string);
var
  I: Integer;
begin
  if FProperties = nil then
    Exit;
  I := FProperties.IndexOfObject(Value);
  if I <> -1 then
    FProperties[I] := Name;
end;

procedure THsJclSimpleXMLProps.Error(const S: string);
begin
  raise EHsJclSimpleXMLError.Create(S);
end;

function THsJclSimpleXMLProps.FloatValue(const Name: string;
  const Default: Extended): Extended;
var
  Prop: THsJclSimpleXMLProp;
begin
  Prop := GetItemNamedDefault(Name, FloatToStr(Default));
  if Prop = nil then
    Result := Default
  else
    Result := Prop.FloatValue;
end;

procedure THsJclSimpleXMLProps.FmtError(const S: string;
  const Args: array of const);
begin
  Error(Format(S, Args));
end;

function THsJclSimpleXMLProps.GetCount: Integer;
begin
  if FProperties = nil then
    Result := 0
  else
    Result := FProperties.Count;
end;

{$IFDEF SUPPORTS_FOR_IN}
function THsJclSimpleXMLProps.GetEnumerator: THsJclSimpleXMLPropsEnumerator;
begin
  Result := THsJclSimpleXMLPropsEnumerator.Create(Self);
end;
{$ENDIF SUPPORTS_FOR_IN}

function THsJclSimpleXMLProps.GetItem(const Index: Integer): THsJclSimpleXMLProp;
begin
  if FProperties <> nil then
    Result := THsJclSimpleXMLProp(FProperties.Objects[Index])
  else
    Result := nil;
end;

function THsJclSimpleXMLProps.GetItemNamedDefault(const Name, Default: string): THsJclSimpleXMLProp;
var
  I: Integer;
begin
  Result := nil;
  if FProperties <> nil then
  begin
    I := FProperties.IndexOf(Name);
    if I <> -1 then
      Result := THsJclSimpleXMLProp(FProperties.Objects[I])
    else
    if Assigned(FParent) and Assigned(FParent.SimpleXML) and (sxoAutoCreate in FParent.SimpleXML.Options) then
      Result := Add(Name, Default);
  end
  else
  if Assigned(FParent) and Assigned(FParent.SimpleXML) and (sxoAutoCreate in FParent.SimpleXML.Options) then
  begin
    Result := Add(Name, Default);
  end;
end;

function THsJclSimpleXMLProps.GetItemNamed(const Name: string): THsJclSimpleXMLProp;
begin
  Result := GetItemNamedDefault(Name, '');
end;

function THsJclSimpleXMLProps.GetSimpleXML: THsJclSimpleXML;
begin
  if FParent <> nil then
    Result := FParent.SimpleXML
  else
    Result := nil;
end;

function THsJclSimpleXMLProps.IntValue(const Name: string; const Default: Int64): Int64;
var
  Prop: THsJclSimpleXMLProp;
begin
  Prop := GetItemNamedDefault(Name, IntToStr(Default));
  if Prop = nil then
    Result := Default
  else
    Result := Prop.IntValue;
end;

procedure THsJclSimpleXMLProps.LoadFromStringStream(StringStream: TStringStream);
//<element Prop="foo" Prop='bar' foo:bar="beuh"/>
//Stop on / or ? or >
type
  TPosType = (
    ptWaiting,
    ptReadingName,
    ptStartingContent,
    ptReadingValue,
    ptSpaceBeforeEqual
    );
var
  lPos: TPosType;
  lName, lValue, lNameSpace: TUCS4Array;
  sValue: string;
  lPropStart: UCS4;
  Ch: UCS4;
begin
  SetLength(lValue, 0);
  SetLength(lNameSpace, 0);
  SetLength(lName, 0);
  lPropStart := Ord(NativeSpace);
  lPos := ptWaiting;

  // We read from a stream, thus replacing the existing properties
  Clear;

  while StringStream.PeekUCS4(Ch) do
  begin
    case lPos of
      ptWaiting: //We are waiting for a property
        begin
          if UnicodeIsWhiteSpace(Ch) then
            StringStream.ReadUCS4(Ch)
          else
          if UnicodeIsIdentifierStart(Ch) or (Ch = Ord('-')) or (Ch = Ord('.')) or (Ch = Ord('_')) then
          begin
            StringStream.ReadUCS4(Ch);
            lName := UCS4Array(Ch);
            SetLength(lNameSpace, 0);
            lPos := ptReadingName;
          end
          else
          if (Ch = Ord('/')) or (Ch = Ord('>')) or (Ch = Ord('?')) then
            // end of properties
            Break
          else
            FmtError(LoadResString(@RsEInvalidXMLElementUnexpectedCharacte), [UCS4ToChar(Ch), StringStream.PeekPosition]);
        end;

      ptReadingName: //We are reading a property name
        begin
          StringStream.ReadUCS4(Ch);
          if UnicodeIsIdentifierPart(Ch) or (Ch = Ord('-')) or (Ch = Ord('.')) then
          begin
            UCS4ArrayConcat(lName, Ch);
          end
          else
          if Ch = Ord(':') then
          begin
            lNameSpace := lName;
            SetLength(lName, 0);
          end
          else
          if Ch = Ord('=') then
            lPos := ptStartingContent
          else
          if UnicodeIsWhiteSpace(Ch) then
            lPos := ptSpaceBeforeEqual
          else
            FmtError(LoadResString(@RsEInvalidXMLElementUnexpectedCharacte), [UCS4ToChar(Ch), StringStream.PeekPosition]);
        end;

      ptStartingContent: //We are going to start a property content
        begin
          StringStream.ReadUCS4(Ch);
          if UnicodeIsWhiteSpace(Ch) then
            // ignore white space
          else
          if (Ch = Ord('''')) or (Ch = Ord('"')) then
          begin
            lPropStart := Ch;
            SetLength(lValue, 0);
            lPos := ptReadingValue;
          end
          else
            FmtError(LoadResString(@RsEInvalidXMLElementUnexpectedCharacte_), [UCS4ToChar(Ch), StringStream.PeekPosition]);
        end;

      ptReadingValue: //We are reading a property
        begin
          StringStream.ReadUCS4(Ch);
          if Ch = lPropStart then
          begin
            sValue := UCS4ToString(lValue);
            if GetSimpleXML <> nil then
              GetSimpleXML.DoDecodeValue(sValue);
            with Add(UCS4ToString(lName), sValue) do
              NameSpace := UCS4ToString(lNameSpace);
            lPos := ptWaiting;
          end
          else
            UCS4ArrayConcat(lValue, Ch);
        end;

      ptSpaceBeforeEqual: // We are reading the white space between a property name and the = sign
        begin
          StringStream.ReadUCS4(Ch);
          if UnicodeIsWhiteSpace(Ch) then
            // more white space, stay in this state and ignore
          else
          if Ch = Ord('=') then
            lPos := ptStartingContent
          else
            FmtError(LoadResString(@RsEInvalidXMLElementUnexpectedCharacte), [UCS4ToChar(Ch), StringStream.PeekPosition]);
        end;
    else
      Assert(False, RsEUnexpectedValueForLPos);
    end;
  end;
end;

procedure THsJclSimpleXMLProps.SaveToStringStream(StringStream: TStringStream);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Item[I].SaveToStringStream(StringStream);
end;

procedure THsJclSimpleXMLProps.SortProperties(const Order: array of string);
var
  I, Index, InsertIndex: Integer;
begin
  InsertIndex := 0;
  for I := 0 to High(Order) do
  begin
    Index := FProperties.IndexOf(Order[I]);
    if Index <> -1 then
    begin
      FProperties.Move(Index, InsertIndex);
      Inc(InsertIndex);
    end;
  end;
end;

function THsJclSimpleXMLProps.Value(const Name, Default: string): string;
var
  Prop: THsJclSimpleXMLProp;
begin
  Result := '';
  Prop := GetItemNamedDefault(Name, Default);
  if Prop = nil then
    Result := Default
  else
    Result := Prop.Value;
end;

//=== { THsJclSimpleXMLProp } ==================================================

constructor THsJclSimpleXMLProp.Create(AParent: THsJclSimpleXMLElem; const AName, AValue: string);
begin
  inherited Create(AName, AValue);
  FParent := AParent;
end;

function THsJclSimpleXMLProp.GetSimpleXML: THsJclSimpleXML;
begin
  if FParent <> nil then
    Result := FParent.SimpleXML
  else
    Result := nil;
end;

procedure THsJclSimpleXMLProp.SaveToStringStream(StringStream: TStringStream);
var
  AEncoder: THsJclSimpleXML;
  Tmp: string;
begin
  AEncoder := GetSimpleXML;
  Tmp := Value;
  if AEncoder <> nil then
    AEncoder.DoEncodeValue(Tmp);
  if NameSpace <> '' then
    Tmp := Format(' %s:%s="%s"', [NameSpace, Name, Tmp])
  else
    Tmp := Format(' %s="%s"', [Name, tmp]);

  StringStream.WriteBuffer(Tmp[1], Length(Tmp));
end;

procedure THsJclSimpleXMLProp.SetName(const Value: string);
begin
  if (Value <> Name) and (Value <> '') then
  begin
    if (Parent <> nil) and (Name <> '') then
      FParent.Properties.DoItemRename(Self, Value);
    inherited SetName(Value);
  end;
end;

//=== { THsJclSimpleXMLElemClassic } ===========================================

procedure THsJclSimpleXMLElemClassic.LoadFromStringStream(StringStream: TStringStream);
//<element Prop="foo" Prop='bar'/>
//<element Prop="foo" Prop='bar'>foor<b>beuh</b>bar</element>
//<xml:element Prop="foo" Prop='bar'>foor<b>beuh</b>bar</element>
type
  TReadStatus = (rsWaitingOpeningTag, rsOpeningName, rsTypeOpeningTag, rsEndSingleTag,
    rsWaitingClosingTag1, rsWaitingClosingTag2, rsClosingName);
var
  lPos: TReadStatus;
  St, lName, lNameSpace: TUCS4Array;
  sValue: string;
  Ch: UCS4;
begin
  SetLength(St, 0);
  SetLength(lName, 0);
  SetLength(lNameSpace, 0);
  sValue := '';
  lPos := rsWaitingOpeningTag;

  if SimpleXML <> nil then
    SimpleXML.DoLoadProgress(StringStream.Stream.Position, StringStream.Stream.Size);

  while StringStream.ReadUCS4(Ch) do
  begin
    case lPos of
      rsWaitingOpeningTag: // wait beginning of tag
        if Ch = Ord('<') then
          lPos := rsOpeningName // read name
        else
        if not UnicodeIsWhiteSpace(Ch) then
          FmtError(LoadResString(@RsEInvalidXMLElementExpectedBeginningO), [UCS4ToChar(Ch), StringStream.PeekPosition]);

      rsOpeningName:
        if UnicodeIsIdentifierPart(Ch) or (Ch = Ord('-')) or (Ch = Ord('.')) then
          UCS4ArrayConcat(St, Ch)
        else
        if (Ch = Ord(':')) and (Length(lNameSpace) = 0) then
        begin
          lNameSpace := St;
          SetLength(st, 0);
        end
        else
        if UnicodeIsWhiteSpace(Ch) and (Length(St) = 0) then
          // whitespace after "<" (no name)
          FmtError(LoadResString(@RsEInvalidXMLElementMalformedTagFoundn), [StringStream.PeekPosition])
        else
        if UnicodeIsWhiteSpace(Ch) then
        begin
          lName := St;
          SetLength(St, 0);
          Properties.LoadFromStringStream(StringStream);
          lPos := rsTypeOpeningTag;
        end
        else
        if Ch = Ord('/') then // single tag
        begin
          lName := St;
          lPos := rsEndSingleTag
        end
        else
        if Ch = Ord('>') then // 2 tags
        begin
          lName := St;
          SetLength(St, 0);
          //Load elements
          Items.LoadFromStringStream(StringStream);
          lPos := rsWaitingClosingTag1;
        end
        else
          // other invalid characters
          FmtError(LoadResString(@RsEInvalidXMLElementMalformedTagFoundn), [StringStream.PeekPosition]);

      rsTypeOpeningTag:
        if UnicodeIsWhiteSpace(Ch) then
          // nothing, spaces after name or properties
        else
        if Ch = Ord('/') then
          lPos := rsEndSingleTag // single tag
        else
        if Ch = Ord('>') then // 2 tags
        begin
          //Load elements
          Items.LoadFromStringStream(StringStream);
          lPos := rsWaitingClosingTag1;
        end
        else
          FmtError(LoadResString(@RsEInvalidXMLElementExpectedEndOfTagBu), [UCS4ToChar(Ch), StringStream.PeekPosition]);

      rsEndSingleTag:
        if Ch = Ord('>') then
          Break
        else
          FmtError(LoadResString(@RsEInvalidXMLElementExpectedEndOfTagBu), [UCS4ToChar(Ch), StringStream.PeekPosition]);

      rsWaitingClosingTag1:
        if UnicodeIsWhiteSpace(Ch) then
          // nothing, spaces before closing tag
        else
        if Ch = Ord('<') then
          lPos := rsWaitingClosingTag2
        else
          FmtError(LoadResString(@RsEInvalidXMLElementExpectedEndOfTagBu), [UCS4ToChar(Ch), StringStream.PeekPosition]);

      rsWaitingClosingTag2:
        if Ch = Ord('/') then
          lPos := rsClosingName
        else
          FmtError(LoadResString(@RsEInvalidXMLElementExpectedEndOfTagBu), [UCS4ToChar(Ch), StringStream.PeekPosition]);

      rsClosingName:
        if UnicodeIsWhiteSpace(Ch) or (Ch = Ord('>')) then
        begin
          if Length(lNameSpace) > 0 then
          begin
            if not SameText(UCS4ToString(lNameSpace) + ':' + UCS4ToString(lName), UCS4ToString(St)) then
              FmtError(LoadResString(@RsEInvalidXMLElementErroneousEndOfTagE), [UCS4ToString(lName), UCS4ToString(St), StringStream.PeekPosition]);
          end
          else
            if not UCS4ArrayEquals(lName, St) then
              FmtError(LoadResString(@RsEInvalidXMLElementErroneousEndOfTagE), [UCS4ToString(lName), UCS4ToString(St), StringStream.PeekPosition]);
          //Set value if only one sub element
          //This might reduce speed, but this is for compatibility issues
          if (Items.Count = 1) and (Items[0] is THsJclSimpleXMLElemText) then
          begin
            sValue := Items[0].Value;
            Items.Clear;
            // free some memory
            FreeAndNil(FItems);
          end;
          Break;
        end
        else
        if UnicodeIsIdentifierPart(Ch) or (Ch = Ord('-')) or (Ch = Ord('.')) or (Ch = Ord(':')) then
          UCS4ArrayConcat(St, Ch)
        else
          // other invalid characters
          FmtError(LoadResString(@RsEInvalidXMLElementMalformedTagFoundn), [StringStream.PeekPosition]);
    end;
  end;

  Name := UCS4ToString(lName);
  if SimpleXML <> nil then
    SimpleXML.DoDecodeValue(sValue);
  Value := sValue;
  NameSpace := UCS4ToString(lNameSpace);

  if SimpleXML <> nil then
  begin
    SimpleXML.DoTagParsed(Name);
    SimpleXML.DoValueParsed(Name, sValue);
  end;
end;

procedure THsJclSimpleXMLElemClassic.SaveToStringStream(StringStream: TStringStream; const Level: string);
var
  St, AName, tmp: string;
  LevelAdd: string;
  AutoIndent: Boolean;
begin
  if(NameSpace <> '') then
    AName := NameSpace + ':' + Name
  else
    AName := Name;

  if Name <> '' then
  begin
    if SimpleXML <> nil then
       SimpleXML.DoEncodeValue(AName);
    St := Level + '<' + AName;

    StringStream.WriteString(St, 1, Length(St));
    if Assigned(FProps) then
      FProps.SaveToStringStream(StringStream);
  end;

  AutoIndent := (SimpleXML <> nil) and (sxoAutoIndent in SimpleXML.Options);

  if (ItemCount = 0) then
  begin
    tmp := Value;
    if (Name <> '') then
    begin
      if Value = '' then
      begin
        if AutoIndent then
          St := '/>' + sLineBreak
        else
          St := '/>';
      end
      else
      begin
        if SimpleXML <> nil then
          SimpleXML.DoEncodeValue(tmp);
        if AutoIndent then
          St := '>' + tmp + '</' + AName + '>' + sLineBreak
        else
          St := '>' + tmp + '</' + AName + '>';
      end;
      StringStream.WriteString(St, 1, Length(St));
    end;
  end
  else
  begin
    if (Name <> '') then
    begin
      if AutoIndent then
        St := '>' + sLineBreak
      else
        St := '>';
      StringStream.WriteString(St, 1, Length(St));
    end;
    if AutoIndent then
    begin
      LevelAdd := SimpleXML.IndentString;
    end;
    FItems.SaveToStringStream(StringStream, Level + LevelAdd);
    if Name <> '' then
    begin
      if AutoIndent then
        St := Level + '</' + AName + '>' + sLineBreak
      else
        St := Level + '</' + AName + '>';
      StringStream.WriteString(St, 1, Length(St));
    end;
  end;
  if SimpleXML <> nil then
    SimpleXML.DoSaveProgress;
end;

//=== { THsJclSimpleXMLElemComment } ===========================================

procedure THsJclSimpleXMLElemComment.LoadFromStringStream(StringStream: TStringStream);
//<!-- declarations for <head> & <body> -->
const
  CS_START_COMMENT = '<!--';
  CS_STOP_COMMENT  = '    -->';
var
  lPos: Integer;
  St: TUCS4Array;
  Ch: UCS4;
  lOk: Boolean;
begin
  SetLength(St, 0);
  lPos := 1;
  lOk := False;

  if SimpleXML <> nil then
    SimpleXML.DoLoadProgress(StringStream.Stream.Position, StringStream.Stream.Size);

  while StringStream.ReadUCS4(Ch) do
  begin
    case lPos of
      1..4: //<!--
        if Ch = Ord(CS_START_COMMENT[lPos]) then
          Inc(lPos)
        else
        if not UnicodeIsWhiteSpace(Ch) then
          FmtError(LoadResString(@RsEInvalidCommentExpectedsButFounds), [CS_START_COMMENT[lPos], UCS4ToChar(Ch), StringStream.PeekPosition]);
      5:
        if Ch = Ord(CS_STOP_COMMENT[lPos]) then
          Inc(lPos)
        else
          UCS4ArrayConcat(St, Ch);
      6: //-
        if Ch = Ord(CS_STOP_COMMENT[lPos]) then
          Inc(lPos)
        else
        begin
          UCS4ArrayConcat(St, Ord('-'));
          UCS4ArrayConcat(St, Ch);
          Dec(lPos);
        end;
      7: //>
        if Ch = Ord(CS_STOP_COMMENT[lPos]) then
        begin
          lOk := True;
          Break; //End if
        end
        else // -- is not authorized in comments
          FmtError(LoadResString(@RsEInvalidCommentNotAllowedInsideComme), [StringStream.PeekPosition]);
    end;
  end;

  if not lOk then
    FmtError(LoadResString(@RsEInvalidCommentUnexpectedEndOfData), [StringStream.PeekPosition]);

  Value := UCS4ToString(St);
  Name := '';

  if SimpleXML <> nil then
    SimpleXML.DoValueParsed('', Value);
end;

procedure THsJclSimpleXMLElemComment.SaveToStringStream(StringStream: TStringStream; const Level: string);
var
  St: string;
begin
  St := Level + '<!--';
  StringStream.WriteString(St, 1, Length(St));
  if Value <> '' then
    StringStream.WriteString(Value, 1, Length(Value));
  if (SimpleXML <> nil) and (sxoAutoIndent in SimpleXML.Options) then
    St := '-->' + sLineBreak
  else
    St := '-->';
  StringStream.WriteString(St, 1, Length(St));
  if SimpleXML <> nil then
    SimpleXML.DoSaveProgress;
end;

//=== { THsJclSimpleXMLElemCData } =============================================

procedure THsJclSimpleXMLElemCData.LoadFromStringStream(StringStream: TStringStream);
//<![CDATA[<greeting>Hello, world!</greeting>]]>
const
  CS_START_CDATA = '<![CDATA[';
  CS_STOP_CDATA  = '         ]]>';
var
  lPos: Integer;
  St: TUCS4Array;
  Ch: UCS4;
  lOk: Boolean;
begin
  SetLength(St, 0);
  lPos := 1;
  lOk := False;

  if SimpleXML <> nil then
    SimpleXML.DoLoadProgress(StringStream.Stream.Position, StringStream.Stream.Size);

  while StringStream.ReadUCS4(Ch) do
  begin
    case lPos of
      1..9: //<![CDATA[
        if Ch = Ord(CS_START_CDATA[lPos]) then
          Inc(lPos)
        else
        if not UnicodeIsWhiteSpace(Ch) then
          FmtError(LoadResString(@RsEInvalidCDATAExpectedsButFounds), [CS_START_CDATA[lPos], UCS4ToChar(Ch), StringStream.PeekPosition]);
      10: // ]
        if Ch = Ord(CS_STOP_CDATA[lPos]) then
          Inc(lPos)
        else
          UCS4ArrayConcat(St, Ch);
      11: // ]
        if Ch = Ord(CS_STOP_CDATA[lPos]) then
          Inc(lPos)
        else
        begin
          UCS4ArrayConcat(St, Ord(']'));
          UCS4ArrayConcat(St, Ch);
          Dec(lPos);
        end;
      12: //>
        if Ch = Ord(CS_STOP_CDATA[lPos]) then
        begin
          lOk := True;
          Break; //End if
        end
        else
        // ]]]
        if Ch = Ord(CS_STOP_CDATA[lPos-1]) then
          UCS4ArrayConcat(St, Ord(']'))
        else
        begin
          UCS4ArrayConcat(St, Ord(']'));
          UCS4ArrayConcat(St, Ord(']'));
          UCS4ArrayConcat(St, Ch);
          Dec(lPos, 2);
        end;
    end;
  end;

  if not lOk then
    FmtError(LoadResString(@RsEInvalidCDATAUnexpectedEndOfData), [StringStream.PeekPosition]);

  Value := UCS4ToString(St);
  Name := '';

  if SimpleXML <> nil then
    SimpleXML.DoValueParsed('', Value);
end;

procedure THsJclSimpleXMLElemCData.SaveToStringStream(StringStream: TStringStream; const Level: string);
var
  St: string;
begin
  St := Level + '<![CDATA[';
  StringStream.WriteString(St, 1, Length(St));
  if Value <> '' then
    StringStream.WriteString(Value, 1, Length(Value));
  if (SimpleXML <> nil) and (sxoAutoIndent in SimpleXML.Options) then
    St := ']]>' + sLineBreak
  else
    St := ']]>';
  StringStream.WriteString(St, 1, Length(St));
  if SimpleXML <> nil then
    SimpleXML.DoSaveProgress;
end;

//=== { THsJclSimpleXMLElemText } ==============================================

procedure THsJclSimpleXMLElemText.LoadFromStringStream(StringStream: TStringStream);
var
  Ch: UCS4;
  USt: TUCS4Array;
  St, TrimValue: string;
begin
  SetLength(USt, 0);
  St := '';

  if SimpleXML <> nil then
    SimpleXML.DoLoadProgress(StringStream.Stream.Position, StringStream.Stream.Size);

  while StringStream.PeekUCS4(Ch) do
  begin
    case Ch of
      Ord('<'):
        //Quit text
        Break;
    else
      begin
        StringStream.ReadUCS4(Ch);
        UCS4ArrayConcat(USt, Ch);
      end;
    end;
  end;

  St := UCS4ToString(USt);

  if Assigned(SimpleXML) then
  begin
    SimpleXML.DoDecodeValue(St);

    TrimValue := St;
    if sxoTrimPrecedingTextWhitespace in SimpleXML.Options then
      TrimValue := TrimLeft(TrimValue);
    if sxoTrimFollowingTextWhitespace in SimpleXML.Options then
      TrimValue := TrimRight(TrimValue);
    if (TrimValue <> '') or not (sxoKeepWhitespace in SimpleXML.Options) then
      St := TrimValue;
  end;

  Value := St;
  Name := '';

  if SimpleXML <> nil then
    SimpleXML.DoValueParsed('', St);
end;

procedure THsJclSimpleXMLElemText.SaveToStringStream(StringStream: TStringStream; const Level: string);
var
  St, tmp: string;
begin
  // should never be used
  if Value <> '' then
  begin
    tmp := Value;
    if SimpleXML <> nil then
      SimpleXML.DoEncodeValue(tmp);
    if (SimpleXML <> nil) and (sxoAutoIndent in SimpleXML.Options) then
      St := Level + tmp + sLineBreak
    else
      St := Level + tmp;
    StringStream.WriteString(St, 1, Length(St));
  end;
  if SimpleXML <> nil then
    SimpleXML.DoSaveProgress;
end;

//=== { THsJclSimpleXMLElemProcessingInstruction } =============================

procedure THsJclSimpleXMLElemProcessingInstruction.LoadFromStringStream(
  StringStream: TStringStream);
type
  TReadStatus = (rsWaitingOpeningTag, rsOpeningTag, rsOpeningName, rsEndTag1, rsEndTag2);
var
  lPos: TReadStatus;
  lOk: Boolean;
  St, lName, lNameSpace: TUCS4Array;
  Ch: UCS4;
begin
  SetLength(St, 0);
  SetLength(lName, 0);
  SetLength(lNameSpace, 0);
  lPos := rsWaitingOpeningTag;
  lOk := False;

  if SimpleXML <> nil then
    SimpleXML.DoLoadProgress(StringStream.Stream.Position, StringStream.Stream.Size);

  while StringStream.ReadUCS4(Ch) do
  begin
    case lPos of
      rsWaitingOpeningTag: // wait beginning of tag
        if Ch = Ord('<') then
          lPos := rsOpeningTag
        else
        if not UnicodeIsWhiteSpace(Ch) then
          FmtError(LoadResString(@RsEInvalidXMLElementExpectedBeginningO), [UCS4ToChar(Ch), StringStream.PeekPosition]);

      rsOpeningTag:
        if Ch = Ord('?') then
          lPos := rsOpeningName // read name
        else
          FmtError(LoadResString(@RsEInvalidXMLElementMalformedTagFoundn), [StringStream.PeekPosition]);

      rsOpeningName:
        if UnicodeIsIdentifierPart(Ch) or (Ch = Ord('-')) or (Ch = Ord('.')) then
          UCS4ArrayConcat(St, Ch)
        else
        if (Ch = Ord(':')) and (Length(lNameSpace) = 0) then
        begin
          lNameSpace := St;
          SetLength(St, 0);
        end
        else
        if UnicodeIsWhiteSpace(Ch) and (Length(St) = 0) then
          // whitespace after "<" (no name)
          FmtError(LoadResString(@RsEInvalidXMLElementMalformedTagFoundn), [StringStream.PeekPosition])
        else
        if UnicodeIsWhiteSpace(Ch) then
        begin
          lName := St;
          SetLength(St, 0);
          Properties.LoadFromStringStream(StringStream);
          lPos := rsEndTag1;
        end
        else
        if Ch = Ord('?') then
        begin
          lName := St;
          lPos := rsEndTag2;
        end
        else
          // other invalid characters
          FmtError(LoadResString(@RsEInvalidXMLElementMalformedTagFoundn), [StringStream.PeekPosition]);

      rsEndTag1:
        if Ch = Ord('?') then
          lPos := rsEndTag2
        else
        if not UnicodeIsWhiteSpace(Ch) then
          FmtError(LoadResString(@RsEInvalidXMLElementExpectedEndOfTagBu), [UCS4ToChar(Ch), StringStream.PeekPosition]);

      rsEndTag2:
        if Ch = Ord('>') then
        begin
          lOk := True;
          Break;
        end
        else
          FmtError(LoadResString(@RsEInvalidXMLElementExpectedEndOfTagBu), [UCS4ToChar(Ch), StringStream.PeekPosition]);
    end;
  end;

  if not lOk then
    FmtError(LoadResString(@RsEInvalidCommentUnexpectedEndOfData), [StringStream.PeekPosition]);

  Name := UCS4ToString(lName);
  NameSpace := UCS4ToString(lNameSpace);
end;

procedure THsJclSimpleXMLElemProcessingInstruction.SaveToStringStream(
  StringStream: TStringStream; const Level: string);
var
  St: string;
begin
  St := Level + '<?';
  if NameSpace <> '' then
    St := St + NameSpace + ':' + Name
  else
    St := St + Name;
  StringStream.WriteString(St, 1, Length(St));
  if Assigned(FProps) then
    FProps.SaveToStringStream(StringStream);
  if (SimpleXML <> nil) and (sxoAutoIndent in SimpleXML.Options) then
    St := '?>' + sLineBreak
  else
    St := '?>';
  StringStream.WriteString(St, 1, Length(St));
  if SimpleXML <> nil then
    SimpleXML.DoSaveProgress;
end;

//=== { THsJclSimpleXMLElemHeader } ============================================

constructor THsJclSimpleXMLElemHeader.Create;
begin
  inherited Create;

  Name := 'xml';
end;

function THsJclSimpleXMLElemHeader.GetEncoding: string;
var
  ASimpleXML: THsJclSimpleXML;
  DefaultCodePage: Word;
begin
  ASimpleXML := SimpleXML;
  if Assigned(ASimpleXML) then
  begin
    DefaultCodePage := ASimpleXML.CodePage;
    {$IFDEF MSWINDOWS}
    if DefaultCodePage = CP_ACP then
      DefaultCodePage := GetAcp;
    {$ENDIF MSWINDOWS}
  end
  else
    {$IFDEF UNICODE}
    DefaultCodePage := CP_UTF16LE;
    {$ELSE ~UNICODE}
    {$IFDEF MSWINDOWS}
    DefaultCodePage := GetACP;
    {$ELSE ~MSWINDOWS}
    DefaultCodePage := 1252;
    {$ENDIF ~MSWINDOWS}
    {$ENDIF ~UNICODE}
  Result := Properties.Value('encoding', CharsetNameFromCodePage(DefaultCodePage));
end;

function THsJclSimpleXMLElemHeader.GetStandalone: Boolean;
begin
  Result := Properties.Value('standalone') = 'yes';
end;

function THsJclSimpleXMLElemHeader.GetVersion: string;
begin
  Result := Properties.Value('version', '1.0');
end;

procedure THsJclSimpleXMLElemHeader.LoadFromStringStream(StringStream: TStringStream);
//<?xml version="1.0" encoding="iso-xyzxx" standalone="yes"?>
var
  CodePage: Word;
  EncodingProp: THsJclSimpleXMLProp;
begin
  inherited LoadFromStringStream(StringStream);

  if Assigned(FProps) then
    EncodingProp := FProps.ItemNamed['encoding']
  else
    EncodingProp := nil;
  if Assigned(EncodingProp) and (EncodingProp.Value <> '') then
    CodePage := CodePageFromCharsetName(EncodingProp.Value)
  else
    CodePage := CP_ACP;

  // set current stringstream codepage
  if StringStream is THsJclAutoStream then
    THsJclAutoStream(StringStream).CodePage := CodePage
  else
  if StringStream is THsJclAnsiStream then
    THsJclAnsiStream(StringStream).CodePage := CodePage
  else
  if not (StringStream is THsJclUTF8Stream) and not (StringStream is THsJclUTF16Stream) then
    Error(LoadResString(@RsENoCharset));
end;

procedure THsJclSimpleXMLElemHeader.SaveToStringStream(
  StringStream: TStringStream; const Level: string);
begin
  SetVersion(GetVersion);
  SetEncoding(GetEncoding);
  SetStandalone(GetStandalone);
  Properties.SortProperties(['version', 'encoding', 'standalone']);

  inherited SaveToStringStream(StringStream, Level);
end;

procedure THsJclSimpleXMLElemHeader.SetEncoding(const Value: string);
var
  Prop: THsJclSimpleXMLProp;
begin
  Prop := Properties.ItemNamed['encoding'];
  if Assigned(Prop) then
    Prop.Value := Value
  else
    Properties.Add('encoding', Value);
end;

procedure THsJclSimpleXMLElemHeader.SetStandalone(const Value: Boolean);
var
  Prop: THsJclSimpleXMLProp;
const
  BooleanValues: array [Boolean] of string = ('no', 'yes');
begin
  Prop := Properties.ItemNamed['standalone'];
  if Assigned(Prop) then
    Prop.Value := BooleanValues[Value]
  else
    Properties.Add('standalone', BooleanValues[Value]);
end;

procedure THsJclSimpleXMLElemHeader.SetVersion(const Value: string);
var
  Prop: THsJclSimpleXMLProp;
begin
  Prop := Properties.ItemNamed['version'];
  if Assigned(Prop) then
    Prop.Value := Value
  else
    // Various XML parsers (including MSIE, Firefox) require the "version" to be the first
    Properties.Insert(0, 'version', Value);
end;

//=== { THsJclSimpleXMLElemDocType } ===========================================

procedure THsJclSimpleXMLElemDocType.LoadFromStringStream(StringStream: TStringStream);
{
<!DOCTYPE test [
<!ELEMENT test (#PCDATA) >
<!ENTITY % xx '&#37;zz;'>
<!ENTITY % zz '&#60;!ENTITY tricky "error-prone" >' >
%xx;
]>

<!DOCTYPE greeting SYSTEM "hello.dtd">
}
const
  CS_START_DOCTYPE = '<!DOCTYPE';
var
  lPos: Integer;
  lOk: Boolean;
  Ch, lChar: UCS4;
  St: TUCS4Array;
begin
  lPos := 1;
  lOk := False;
  lChar := Ord('>');
  SetLength(St, 0);

  if SimpleXML <> nil then
    SimpleXML.DoLoadProgress(StringStream.Stream.Position, StringStream.Stream.Size);

  while StringStream.ReadUCS4(Ch) do
  begin
    case lPos of
      1..9: //<!DOCTYPE
        if Ch = Ord(CS_START_DOCTYPE[lPos]) then
          Inc(lPos)
        else
        if not UnicodeIsWhiteSpace(Ch) then
          FmtError(LoadResString(@RsEInvalidHeaderExpectedsButFounds), [CS_START_DOCTYPE[lPos], UCS4ToChar(Ch), StringStream.PeekPosition]);
      10: //]> or >
        if lChar = Ch then
        begin
          if lChar = Ord('>') then
          begin
            lOk := True;
            Break; //This is the end
          end
          else
          begin
            UCS4ArrayConcat(St, Ch);
            lChar := Ord('>');
          end;
        end
        else
        begin
          UCS4ArrayConcat(St, Ch);
          if Ch = Ord('[') then
            lChar := Ord(']');
        end;
    end;
  end;

  if not lOk then
    FmtError(LoadResString(@RsEInvalidCommentUnexpectedEndOfData), [StringStream.PeekPosition]);

  Name := '';
  Value := StrTrimCharsLeft(UCS4ToString(St), CharIsWhiteSpace);

  if SimpleXML <> nil then
    SimpleXML.DoValueParsed('', Value);
end;

procedure THsJclSimpleXMLElemDocType.SaveToStringStream(StringStream: TStringStream;
  const Level: string);
var
  St: string;
begin
  if (SimpleXML <> nil) and (sxoAutoIndent in SimpleXML.Options) then
    St := Level + '<!DOCTYPE ' + Value + '>' + sLineBreak
  else
    St := Level + '<!DOCTYPE ' + Value + '>';
  StringStream.WriteString(St, 1, Length(St));
  if SimpleXML <> nil then
    SimpleXML.DoSaveProgress;
end;

//=== { THsJclSimpleXMLElemsPrologEnumerator } =================================

{$IFDEF SUPPORTS_FOR_IN}
constructor THsJclSimpleXMLElemsPrologEnumerator.Create(AList: THsJclSimpleXMLElemsProlog);
begin
  inherited Create;
  FIndex := -1;
  FList := AList;
end;

function THsJclSimpleXMLElemsPrologEnumerator.GetCurrent: THsJclSimpleXMLElem;
begin
  Result := FList[FIndex];
end;

function THsJclSimpleXMLElemsPrologEnumerator.MoveNext: Boolean;
begin
  Result := FIndex < FList.Count - 1;
  if Result then
    Inc(FIndex);
end;
{$ENDIF SUPPORTS_FOR_IN}

//=== { THsJclSimpleXMLElemsProlog } ===========================================

constructor THsJclSimpleXMLElemsProlog.Create(ASimpleXML: THsJclSimpleXML);
var
  CaseSensitive: Boolean;
begin
  inherited Create;
  FSimpleXML := ASimpleXML;
  CaseSensitive := Assigned(ASimpleXML) and (sxoCaseSensitive in ASimpleXML.Options);
  FElems := THsJclSimpleItemHashedList.Create(CaseSensitive);
end;

destructor THsJclSimpleXMLElemsProlog.Destroy;
begin
  Clear;
  FreeAndNil(FElems);
  inherited Destroy;
end;

procedure THsJclSimpleXMLElemsProlog.Clear;
begin
  FElems.Clear;
end;

function THsJclSimpleXMLElemsProlog.GetCount: Integer;
begin
  Result := FElems.Count;
end;

function THsJclSimpleXMLElemsProlog.GetItem(const Index: Integer): THsJclSimpleXMLElem;
begin
  Result := THsJclSimpleXMLElem(FElems.SimpleItems[Index]);
end;

procedure THsJclSimpleXMLElemsProlog.LoadFromStringStream(StringStream: TStringStream);
{<?xml version="1.0" encoding="UTF-8" ?>
<!-- Test -->
<!DOCTYPE greeting [
  <!ELEMENT greeting (#PCDATA)>
]>
<greeting>Hello, world!</greeting>

<?xml version="1.0"?> <!DOCTYPE greeting SYSTEM "hello.dtd"> <greeting>Hello, world!</greeting>
}
var
  lPos: Integer;
  St: TUCS4Array;
  lEnd: Boolean;
  lElem: THsJclSimpleXMLElem;
  Ch: UCS4;
begin
  SetLength(St, 0);
  lPos := 0;

  if SimpleXML <> nil then
    SimpleXML.DoLoadProgress(StringStream.Stream.Position, StringStream.Stream.Size);

  while StringStream.PeekUCS4(Ch) do
  begin
    case lPos of
      0: //We are waiting for a tag and thus avoiding spaces and any BOM
        begin
          if UnicodeIsWhiteSpace(Ch) then
            // still waiting
          else
          if Ch = Ord('<') then
          begin
            lPos := 1;
            St := UCS4Array(Ch);
          end
          else
            FmtError(LoadResString(@RsEInvalidDocumentUnexpectedTextInFile), [StringStream.PeekPosition]);
        end;
      1: //We are trying to determine the kind of the tag
        begin
          lElem := nil;
          lEnd := False;

          if not UCS4ArrayEquals(St, '<![CDATA') or not UnicodeIsWhiteSpace(Ch) then
            UCS4ArrayConcat(St, Ch);
          if UCS4ArrayEquals(St, '<![CDATA[') then
            lEnd := True
          else
          if UCS4ArrayEquals(St, '<!--') then
            lElem := THsJclSimpleXMLElemComment.Create(SimpleXML)
          else
          if UCS4ArrayEquals(St, '<?xml-stylesheet') then
            lElem := THsJclSimpleXMLElemSheet.Create(SimpleXML)
          else
          if UCS4ArrayEquals(St, '<?xml ') then
            lElem := THsJclSimpleXMLElemHeader.Create(SimpleXML)
          else
          if UCS4ArrayEquals(St, '<!DOCTYPE') then
            lElem := THsJclSimpleXMLElemDocType.Create(SimpleXML)
          else
          if UCS4ArrayEquals(St, '<?mso-application') then
            lElem := THsJclSimpleXMLElemMSOApplication.Create(SimpleXML)
          else
          if (Length(St) > 3) and (St[1] = Ord('?')) and UnicodeIsWhiteSpace(St[High(St)]) then
            lElem := THsJclSimpleXMLElemProcessingInstruction.Create(SimpleXML)
          else
          if (Length(St) > 1) and (St[1] <> Ord('!')) and (St[1] <> Ord('?')) then
            lEnd := True;

          if lEnd then
            Break
          else
          if lElem <> nil then
          begin
            FElems.Add(lElem);
            lElem.LoadFromStringStream(StringStream);
            SetLength(St, 0);
            lPos := 0;
          end;
        end;
    end;
  end;
end;

procedure THsJclSimpleXMLElemsProlog.SaveToStringStream(StringStream: TStringStream);
var
  I: Integer;
begin
  FindHeader;
  for I := 0 to Count - 1 do
    Item[I].SaveToStringStream(StringStream, '');
end;

function VarXML: TVarType;
begin
  Result := XMLVariant.VarType;
end;

procedure XMLCreateInto(var ADest: Variant; const AXML: THsJclSimpleXMLElem);
begin
  TVarData(ADest).vType := VarXML;
  TVarData(ADest).vAny := AXML;
end;

function XMLCreate(const AXML: THsJclSimpleXMLElem): Variant;
begin
  XMLCreateInto(Result, AXML);
end;

function XMLCreate: Variant;
begin
  XMLCreateInto(Result, THsJclSimpleXMLElemClassic.Create(nil));
end;

//=== { TXMLVariant } ========================================================

procedure TXMLVariant.CastTo(var Dest: TVarData; const Source: TVarData;
  const AVarType: TVarType);
var
  StorageStream: TStringStream;
  ConversionString: TStringStream;
begin
  if Source.vType = VarType then
  begin
    case AVarType of
      varOleStr:
        begin
          StorageStream := TStringStream.Create('');
          try
            ConversionString := THsJclUTF16Stream.Create(StorageStream, False);
            try
              ConversionString.WriteBOM;
              THsJclSimpleXMLElem(Source.vAny).SaveToStringStream(ConversionString, '');
              ConversionString.Flush;
            finally
              ConversionString.Free;
            end;
            VarDataFromOleStr(Dest, StorageStream.DataString);
          finally
            StorageStream.Free;
          end;
        end;
      varString:
        begin
          StorageStream := TStringStream.Create('');
          try
            {$IFDEF SUPPORTS_UNICODE}
            ConversionString := THsJclUTF16Stream.Create(StorageStream, False);
            {$ELSE ~SUPPORTS_UNICODE}
            ConversionString := THsJclAnsiStream.Create(StorageStream, False);
            {$ENDIF ~SUPPORTS_UNICODE}
            try
              ConversionString.WriteBOM;
              THsJclSimpleXMLElem(Source.vAny).SaveToStringStream(ConversionString, '');
              ConversionString.Flush;
            finally
              ConversionString.Free;
            end;
            VarDataFromStr(Dest, StorageStream.DataString);
          finally
            StorageStream.Free;
          end;
        end;
      {$IFDEF SUPPORTS_UNICODE_STRING}
      varUString:
        begin
          StorageStream := TStringStream.Create('');
          try
            ConversionString := THsJclUTF16Stream.Create(StorageStream, False);
            try
              ConversionString.WriteBOM;
              THsJclSimpleXMLElem(Source.vAny).SaveToStringStream(ConversionString, '');
              ConversionString.Flush;
            finally
              ConversionString.Free;
            end;
            VarDataClear(Dest);
            Dest.VUString := nil;
            Dest.VType := varUString;
            UnicodeString(Dest.VUString) := UnicodeString(StorageStream.DataString);
          finally
            StorageStream.Free;
          end;
        end;
      {$ENDIF SUPPORTS_UNICODE_STRING}
    else
      RaiseCastError;
    end;
  end
  else
    inherited CastTo(Dest, Source, AVarType);
end;

procedure TXMLVariant.Clear(var V: TVarData);
begin
  V.vType := varEmpty;
  V.vAny := nil;
end;

procedure TXMLVariant.Copy(var Dest: TVarData; const Source: TVarData;
  const Indirect: Boolean);
begin
  if Indirect and VarDataIsByRef(Source) then
    VarDataCopyNoInd(Dest, Source)
  else
  begin
    Dest.vType := Source.vType;
    Dest.vAny := Source.vAny;
  end;
end;

function TXMLVariant.DoFunction(var Dest: TVarData; const V: TVarData;
  const Name: string; const Arguments: TVarDataArray): Boolean;
var
  VXML, LXML: THsJclSimpleXMLElem;
  VElems: THsJclSimpleXMLElems;
  I, J, K: Integer;
begin
  Result := False;
  if (Length(Arguments) = 1) and (Arguments[0].vType in [vtInteger, vtExtended]) then
  begin
    VXML := THsJclSimpleXMLElem(V.VAny);
    K := Arguments[0].vInteger;
    J := 0;

    if (K > 0) and VXML.HasItems then
    begin
      VElems := VXML.Items;
      for I := 0 to VElems.Count - 1 do
        if UpperCase(VElems.Item[I].Name) = Name then
        begin
          Inc(J);
          if J = K then
            Break;
        end;
    end;

    if (J = K) and (J < VXML.ItemCount) then
    begin
      LXML := VXML.Items[J];
      if LXML <> nil then
      begin
        Dest.vType := VarXML;
        Dest.vAny := Pointer(LXML);
        Result := True;
      end
    end;
  end
end;

function TXMLVariant.GetProperty(var Dest: TVarData; const V: TVarData;
  const Name: string): Boolean;
var
  VXML, LXML: THsJclSimpleXMLElem;
  lProp: THsJclSimpleXMLProp;
begin
  Result := False;
  VXML := THsJclSimpleXMLElem(V.VAny);
  if VXML.HasItems then
  begin
    LXML := VXML.Items.ItemNamed[Name];
    if LXML <> nil then
    begin
      Dest.vType := VarXML;
      Dest.vAny := Pointer(LXML);
      Result := True;
    end;
  end;
  if (not Result) and VXML.HasProperties then
  begin
    lProp := VXML.Properties.ItemNamed[Name];
    if lProp <> nil then
    begin
      VarDataFromOleStr(Dest, lProp.Value);
      Result := True;
    end;
  end;
end;

function TXMLVariant.IsClear(const V: TVarData): Boolean;
var
  VXML: THsJclSimpleXMLElem;
begin
  VXML := THsJclSimpleXMLElem(V.VAny);
  Result := (VXML = nil) or (not VXML.HasItems);
end;

function TXMLVariant.SetProperty(const V: TVarData; const Name: string;
  const Value: TVarData): Boolean;

  function GetStrValue: string;
  begin
    try
      Result := Value.VOleStr;
    except
      Result := '';
    end;
  end;

var
  VXML, LXML: THsJclSimpleXMLElem;
  lProp: THsJclSimpleXMLProp;
begin
  Result := False;
  VXML := THsJclSimpleXMLElem(V.VAny);
  if VXML.HasItems then
  begin
    LXML := VXML.Items.ItemNamed[Name];
    if LXML <> nil then
    begin
      LXML.Value := GetStrValue;
      Result := True;
    end;
  end;
  if (not Result) and VXML.HasProperties then
  begin
    lProp := VXML.Properties.ItemNamed[Name];
    if lProp <> nil then
    begin
      lProp.Value := GetStrValue;
      Result := True;
    end;
  end;
end;

procedure THsJclSimpleXMLElemsProlog.Error(const S: string);
begin
  raise EHsJclSimpleXMLError.Create(S);
end;

procedure THsJclSimpleXMLElemsProlog.FmtError(const S: string;
  const Args: array of const);
begin
  Error(Format(S, Args));
end;

procedure THsJclSimpleXML.SetIndentString(const Value: string);
begin
  // test if the new value is only made of spaces or tabs
  if not StrContainsChars(Value, CharIsWhiteSpace, True) then
    Exit;
  FIndentString := Value;
end;

procedure THsJclSimpleXML.SetRoot(const Value: THsJclSimpleXMLElemClassic);
begin
  if Value <> FRoot then
  begin
//    FRoot.FSimpleXML := nil;
    FRoot := Value;
//    FRoot.FSimpleXML := Self;
  end;
end;

function THsJclSimpleXMLElemsProlog.GetEncoding: string;
var
  Elem: THsJclSimpleXMLElemHeader;
begin
  Elem := THsJclSimpleXMLElemHeader(FindHeader);
  if Elem <> nil then
    Result := Elem.Encoding
  else
    Result := 'UTF-8';
end;

{$IFDEF SUPPORTS_FOR_IN}
function THsJclSimpleXMLElemsProlog.GetEnumerator: THsJclSimpleXMLElemsPrologEnumerator;
begin
  Result := THsJclSimpleXMLElemsPrologEnumerator.Create(Self);
end;
{$ENDIF SUPPORTS_FOR_IN}

function THsJclSimpleXMLElemsProlog.GetStandalone: Boolean;
var
  Elem: THsJclSimpleXMLElemHeader;
begin
  Elem := THsJclSimpleXMLElemHeader(FindHeader);
  if Elem <> nil then
    Result := Elem.Standalone
  else
    Result := False;
end;

function THsJclSimpleXMLElemsProlog.GetVersion: string;
var
  Elem: THsJclSimpleXMLElemHeader;
begin
  Elem := THsJclSimpleXMLElemHeader(FindHeader);
  if Elem <> nil then
    Result := Elem.Version
  else
    Result := '1.0';
end;

procedure THsJclSimpleXMLElemsProlog.SetEncoding(const Value: string);
var
  Elem: THsJclSimpleXMLElemHeader;
begin
  Elem := THsJclSimpleXMLElemHeader(FindHeader);
  if Elem <> nil then
    Elem.Encoding := Value;
end;

procedure THsJclSimpleXMLElemsProlog.SetStandalone(const Value: Boolean);
var
  Elem: THsJclSimpleXMLElemHeader;
begin
  Elem := THsJclSimpleXMLElemHeader(FindHeader);
  if Elem <> nil then
    Elem.Standalone := Value;
end;

procedure THsJclSimpleXMLElemsProlog.SetVersion(const Value: string);
var
  Elem: THsJclSimpleXMLElemHeader;
begin
  Elem := THsJclSimpleXMLElemHeader(FindHeader);
  if Elem <> nil then
    Elem.Version := Value;
end;

function THsJclSimpleXMLElemsProlog.FindHeader: THsJclSimpleXMLElem;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    if Item[I] is THsJclSimpleXMLElemHeader then
    begin
      Result := Item[I];
      Exit;
    end;
  // (p3) if we get here, an xml header was not found
  Result := THsJclSimpleXMLElemHeader.Create(SimpleXML);
  FElems.Add(Result);
end;

function THsJclSimpleXMLElemsProlog.AddStyleSheet(const AType, AHRef: string): THsJclSimpleXMLElemSheet;
begin
  // make sure there is an xml header
  FindHeader;
  Result := THsJclSimpleXMLElemSheet.Create('xml-stylesheet');
  Result.Properties.Add('type',AType);
  Result.Properties.Add('href',AHRef);
  FElems.Add(Result);
end;

function THsJclSimpleXMLElemsProlog.AddMSOApplication(const AProgId : string): THsJclSimpleXMLElemMSOApplication;
begin
  // make sure there is an xml header
  FindHeader;
  Result := THsJclSimpleXMLElemMSOApplication.Create('mso-application');
  Result.Properties.Add('progid',AProgId);
  FElems.Add(Result);
end;

function THsJclSimpleXMLElemsProlog.AddComment(const AValue: string): THsJclSimpleXMLElemComment;
begin
  // make sure there is an xml header
  FindHeader;
  Result := THsJclSimpleXMLElemComment.Create('', AValue);
  FElems.Add(Result);
end;

function THsJclSimpleXMLElemsProlog.AddDocType(const AValue: string): THsJclSimpleXMLElemDocType;
begin
  // make sure there is an xml header
  FindHeader;
  Result := THsJclSimpleXMLElemDocType.Create('', AValue);
  FElems.Add(Result);
end;

initialization

finalization
  FreeAndNil(GlobalXMLVariant);

end.
