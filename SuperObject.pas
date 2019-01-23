{$IfDef FPC}
  {$MODE OBJFPC}{$H+}
{$EndIf}

{$DEFINE SUPER_METHOD}
{$DEFINE WINDOWSNT_COMPATIBILITY}
{.$DEFINE DEBUG} // track memory leack

Unit SuperObject;

Interface
Uses
  Classes
{$IfDef VER210}
  ,Generics.Collections, RTTI, TypInfo
{$EndIf}
  ;

Type
{$IfNDef FPC}
  PtrInt = Longint;
  PtrUInt = Longword;
{$EndIf}
  SuperInt = Int64;

{$If (sizeof(Char) = 1)}
  SOChar = Widechar;
  SOIChar = Word;
  PSOChar = PWideChar;
  SOString = Widestring;
{$Else}
  SOChar = Char;
  SOIChar = Word;
  PSOChar = Pchar;
  SOString = String;
{$IfEnd}

Const
  SUPER_ARRAY_LIST_DEFAULT_SIZE = 32;
  SUPER_TOKENER_MAX_DEPTH = 32;

  SUPER_AVL_MAX_DEPTH = sizeof(Longint) * 8;
  SUPER_AVL_MASK_HIGH_BIT = Not ((Not Longword(0)) Shr 1);

Type
  // forward declarations
  TSuperObject = Class;
  ISuperObject = Interface;
  TSuperArray = Class;

(* AVL Tree
 *  This is a "special" autobalanced AVL tree
 *  It use a hash value for fast compare
 *)

{$IfDef SUPER_METHOD}
  TSuperMethod = Procedure(Const This, Params: ISuperObject; Var Result: ISuperObject);
{$EndIf}

  TSuperAvlBitArray = Set Of 0..SUPER_AVL_MAX_DEPTH - 1;

  TSuperAvlSearchType = (stEQual, stLess, stGreater);
  TSuperAvlSearchTypes = Set Of TSuperAvlSearchType;
  TSuperAvlIterator = Class;

  TSuperAvlEntry = Class
  Private
    FGt, FLt: TSuperAvlEntry;
    FBf: Integer;
    FHash: Cardinal;
    FName: SOString;
    FPtr: Pointer;
    Function GetValue: ISuperObject;
    Procedure SetValue(Const val: ISuperObject);
  Public
    Class Function Hash(Const k: SOString): Cardinal; Virtual;
    Constructor Create(Const AName: SOString; Obj: Pointer); Virtual;
    Property Name: SOString Read FName;
    Property Ptr: Pointer Read FPtr;
    Property Value: ISuperObject Read GetValue Write SetValue;
  End;

  TSuperAvlTree = Class
  Private
    FRoot: TSuperAvlEntry;
    FCount: Integer;
    Function balance(bal: TSuperAvlEntry): TSuperAvlEntry;
  Protected
    Procedure doDeleteEntry(Entry: TSuperAvlEntry; all: Boolean); Virtual;
    Function CompareNodeNode(node1, node2: TSuperAvlEntry): Integer; Virtual;
    Function CompareKeyNode(Const k: SOString; h: TSuperAvlEntry): Integer; Virtual;
    Function Insert(h: TSuperAvlEntry): TSuperAvlEntry; Virtual;
    Function Search(Const k: SOString; st: TSuperAvlSearchTypes = [stEqual]): TSuperAvlEntry; Virtual;
  Public
    Constructor Create; Virtual;
    Destructor Destroy; Override;
    Function IsEmpty: Boolean;
    Procedure Clear(all: Boolean = False); Virtual;
    Procedure Pack(all: Boolean);
    Function Delete(Const k: SOString): ISuperObject;
    Function GetEnumerator: TSuperAvlIterator;
    Property count: Integer Read FCount;
  End;

  TSuperTableString = Class(TSuperAvlTree)
  Protected
    Procedure doDeleteEntry(Entry: TSuperAvlEntry; all: Boolean); Override;
    Procedure PutO(Const k: SOString; Const value: ISuperObject);
    Function GetO(Const k: SOString): ISuperObject;
    Procedure PutS(Const k: SOString; Const value: SOString);
    Function GetS(Const k: SOString): SOString;
    Procedure PutI(Const k: SOString; value: SuperInt);
    Function GetI(Const k: SOString): SuperInt;
    Procedure PutD(Const k: SOString; value: Double);
    Function GetD(Const k: SOString): Double;
    Procedure PutB(Const k: SOString; value: Boolean);
    Function GetB(Const k: SOString): Boolean;
{$IfDef SUPER_METHOD}
    Procedure PutM(Const k: SOString; value: TSuperMethod);
    Function GetM(Const k: SOString): TSuperMethod;
{$EndIf}
    Procedure PutN(Const k: SOString; Const value: ISuperObject);
    Function GetN(Const k: SOString): ISuperObject;
    Procedure PutC(Const k: SOString; value: Currency);
    Function GetC(Const k: SOString): Currency;
  Public
    Property O[Const k: SOString]: ISuperObject Read GetO Write PutO; Default;
    Property S[Const k: SOString]: SOString Read GetS Write PutS;
    Property I[Const k: SOString]: SuperInt Read GetI Write PutI;
    Property D[Const k: SOString]: Double Read GetD Write PutD;
    Property B[Const k: SOString]: Boolean Read GetB Write PutB;
{$IfDef SUPER_METHOD}
    Property M[Const k: SOString]: TSuperMethod Read GetM Write PutM;
{$EndIf}
    Property N[Const k: SOString]: ISuperObject Read GetN Write PutN;
    Property C[Const k: SOString]: Currency Read GetC Write PutC;

    Function GetValues: ISuperObject;
    Function GetNames: ISuperObject;
  End;

  TSuperAvlIterator = Class
  Private
    FTree: TSuperAvlTree;
    FBranch: TSuperAvlBitArray;
    FDepth: Longint;
    FPath: Array[0..SUPER_AVL_MAX_DEPTH - 2] Of TSuperAvlEntry;
  Public
    Constructor Create(tree: TSuperAvlTree); Virtual;
    Procedure Search(Const k: SOString; st: TSuperAvlSearchTypes = [stEQual]);
    Procedure First;
    Procedure Last;
    Function GetIter: TSuperAvlEntry;
    Procedure Next;
    Procedure Prior;
    // delphi enumerator
    Function MoveNext: Boolean;
    Property Current: TSuperAvlEntry Read GetIter;
  End;

  TSuperObjectArray = Array[0..(high(PtrInt) Div sizeof(TSuperObject))-1] Of ISuperObject;
  PSuperObjectArray = ^TSuperObjectArray;

  TSuperArray = Class
  Private
    FArray: PSuperObjectArray;
    FLength: Integer;
    FSize:  Integer;
    Procedure Expand(max: Integer);
  Protected
    Function GetO(Const index: Integer): ISuperObject;
    Procedure PutO(Const index: Integer; Const Value: ISuperObject);
    Function GetB(Const index: Integer): Boolean;
    Procedure PutB(Const index: Integer; Value: Boolean);
    Function GetI(Const index: Integer): SuperInt;
    Procedure PutI(Const index: Integer; Value: SuperInt);
    Function GetD(Const index: Integer): Double;
    Procedure PutD(Const index: Integer; Value: Double);
    Function GetC(Const index: Integer): Currency;
    Procedure PutC(Const index: Integer; Value: Currency);
    Function GetS(Const index: Integer): SOString;
    Procedure PutS(Const index: Integer; Const Value: SOString);
{$IfDef SUPER_METHOD}
    Function GetM(Const index: Integer): TSuperMethod;
    Procedure PutM(Const index: Integer; Value: TSuperMethod);
{$EndIf}
    Function GetN(Const index: Integer): ISuperObject;
    Procedure PutN(Const index: Integer; Const Value: ISuperObject);
  Public
    Constructor Create; Virtual;
    Destructor Destroy; Override;
    Function Add(Const Data: ISuperObject): Integer;
    Function Delete(index: Integer): ISuperObject;
    Procedure Insert(index: Integer; Const value: ISuperObject);
    Procedure Clear(all: Boolean = False);
    Procedure Pack(all: Boolean);
    Property Length: Integer Read FLength;

    Property N[Const index: Integer]: ISuperObject Read GetN Write PutN;
    Property O[Const index: Integer]: ISuperObject Read GetO Write PutO; Default;
    Property B[Const index: Integer]: Boolean Read GetB Write PutB;
    Property I[Const index: Integer]: SuperInt Read GetI Write PutI;
    Property D[Const index: Integer]: Double Read GetD Write PutD;
    Property C[Const index: Integer]: Currency Read GetC Write PutC;
    Property S[Const index: Integer]: SOString Read GetS Write PutS;
{$IfDef SUPER_METHOD}
    Property M[Const index: Integer]: TSuperMethod Read GetM Write PutM;
{$EndIf}
//    property A[const index: integer]: TSuperArray read GetA;
  End;

  TSuperWriter = Class
  Public
    // abstact methods to overide
    Function Append(buf: PSOChar; Size: Integer): Integer; Overload; Virtual; Abstract;
    Function Append(buf: PSOChar): Integer; Overload; Virtual; Abstract;
    Procedure Reset; Virtual; Abstract;
  End;

  TSuperWriterString = Class(TSuperWriter)
  Private
    FBuf: PSOChar;
    FBPos: Integer;
    FSize: Integer;
  Public
    Function Append(buf: PSOChar; Size: Integer): Integer; Overload; Override;
    Function Append(buf: PSOChar): Integer; Overload; Override;
    Procedure Reset; Override;
    Procedure TrimRight;
    Constructor Create; Virtual;
    Destructor Destroy; Override;
    Function GetString: SOString;
    Property Data: PSOChar Read FBuf;
    Property Size: Integer Read FSize;
    Property Position: Integer Read FBPos;
  End;

  TSuperWriterStream = Class(TSuperWriter)
  Private
    FStream: TStream;
  Public
    Function Append(buf: PSOChar): Integer; Override;
    Procedure Reset; Override;
    Constructor Create(AStream: TStream); Reintroduce; Virtual;
  End;

  TSuperAnsiWriterStream = Class(TSuperWriterStream)
  Public
    Function Append(buf: PSOChar; Size: Integer): Integer; Override;
  End;

  TSuperUnicodeWriterStream = Class(TSuperWriterStream)
  Public
    Function Append(buf: PSOChar; Size: Integer): Integer; Override;
  End;

  TSuperWriterFake = Class(TSuperWriter)
  Private
    FSize: Integer;
  Public
    Function Append(buf: PSOChar; Size: Integer): Integer; Override;
    Function Append(buf: PSOChar): Integer; Override;
    Procedure Reset; Override;
    Constructor Create; Reintroduce; Virtual;
    Property size: Integer Read FSize;
  End;

  TSuperWriterSock = Class(TSuperWriter)
  Private
    FSocket: Longint;
    FSize: Integer;
  Public
    Function Append(buf: PSOChar; Size: Integer): Integer; Override;
    Function Append(buf: PSOChar): Integer; Override;
    Procedure Reset; Override;
    Constructor Create(ASocket: Longint); Reintroduce; Virtual;
    Property Socket: Longint Read FSocket;
    Property Size: Integer Read FSize;
  End;

  TSuperTokenizerError = (
    teSuccess,
    teContinue,
    teDepth,
    teParseEof,
    teParseUnexpected,
    teParseNull,
    teParseBoolean,
    teParseNumber,
    teParseArray,
    teParseObjectKeyName,
    teParseObjectKeySep,
    teParseObjectValueSep,
    teParseString,
    teParseComment,
    teEvalObject,
    teEvalArray,
    teEvalMethod,
    teEvalInt
    );

  TSuperTokenerState = (
    tsEatws,
    tsStart,
    tsFinish,
    tsNull,
    tsCommentStart,
    tsComment,
    tsCommentEol,
    tsCommentEnd,
    tsString,
    tsStringEscape,
    tsIdentifier,
    tsEscapeUnicode,
    tsEscapeHexadecimal,
    tsBoolean,
    tsNumber,
    tsArray,
    tsArrayAdd,
    tsArraySep,
    tsObjectFieldStart,
    tsObjectField,
    tsObjectUnquotedField,
    tsObjectFieldEnd,
    tsObjectValue,
    tsObjectValueAdd,
    tsObjectSep,
    tsEvalProperty,
    tsEvalArray,
    tsEvalMethod,
    tsParamValue,
    tsParamPut,
    tsMethodValue,
    tsMethodPut
    );

  PSuperTokenerSrec = ^TSuperTokenerSrec;
  TSuperTokenerSrec = Record
    state, saved_state: TSuperTokenerState;
    obj: ISuperObject;
    current: ISuperObject;
    field_name: SOString;
    parent: ISuperObject;
    gparent: ISuperObject;
  End;

  TSuperTokenizer = Class
  Public
    str: PSOChar;
    pb:  TSuperWriterString;
    depth, is_double, floatcount, st_pos, char_offset: Integer;
    err:  TSuperTokenizerError;
    ucs_char: Word;
    quote_char: SOChar;
    stack: Array[0..SUPER_TOKENER_MAX_DEPTH-1] Of TSuperTokenerSrec;
    line, col: Integer;
  Public
    Constructor Create; Virtual;
    Destructor Destroy; Override;
    Procedure ResetLevel(adepth: Integer);
    Procedure Reset;
  End;

  // supported object types
  TSuperType = (
    stNull,
    stBoolean,
    stDouble,
    stCurrency,
    stInt,
    stObject,
    stArray,
    stString
{$IfDef SUPER_METHOD}
    ,stMethod
{$EndIf}
    );

  TSuperValidateError = (
    veRuleMalformated,
    veFieldIsRequired,
    veInvalidDataType,
    veFieldNotFound,
    veUnexpectedField,
    veDuplicateEntry,
    veValueNotInEnum,
    veInvalidLength,
    veInvalidRange
    );

  TSuperFindOption = (
    foCreatePath,
    foPutValue,
    foDelete
{$IfDef SUPER_METHOD}
    ,foCallMethod
{$EndIf}
    );

  TSuperFindOptions = Set Of TSuperFindOption;
  TSuperCompareResult = (cpLess, cpEqu, cpGreat, cpError);
  TSuperOnValidateError = Procedure(sender: Pointer; error: TSuperValidateError; Const objpath: SOString);

  TSuperEnumerator = Class
  Private
    FObj: ISuperObject;
    FObjEnum: TSuperAvlIterator;
    FCount: Integer;
  Public
    Constructor Create(Const obj: ISuperObject); Virtual;
    Destructor Destroy; Override;
    Function MoveNext: Boolean;
    Function GetCurrent: ISuperObject;
    Property Current: ISuperObject Read GetCurrent;
  End;

  ISuperObject = Interface
    ['{4B86A9E3-E094-4E5A-954A-69048B7B6327}']
    Function GetEnumerator: TSuperEnumerator;
    Function GetDataType: TSuperType;
    Function GetProcessing: Boolean;
    Procedure SetProcessing(value: Boolean);
    Function ForcePath(Const path: SOString; dataType: TSuperType = stObject): ISuperObject;
    Function Format(Const str: SOString; BeginSep: SOChar = '%'; EndSep: SOChar = '%'): SOString;

    Function GetO(Const path: SOString): ISuperObject;
    Procedure PutO(Const path: SOString; Const Value: ISuperObject);
    Function GetB(Const path: SOString): Boolean;
    Procedure PutB(Const path: SOString; Value: Boolean);
    Function GetI(Const path: SOString): SuperInt;
    Procedure PutI(Const path: SOString; Value: SuperInt);
    Function GetD(Const path: SOString): Double;
    Procedure PutC(Const path: SOString; Value: Currency);
    Function GetC(Const path: SOString): Currency;
    Procedure PutD(Const path: SOString; Value: Double);
    Function GetS(Const path: SOString): SOString;
    Procedure PutS(Const path: SOString; Const Value: SOString);
{$IfDef SUPER_METHOD}
    Function GetM(Const path: SOString): TSuperMethod;
    Procedure PutM(Const path: SOString; Value: TSuperMethod);
{$EndIf}
    Function GetA(Const path: SOString): TSuperArray;

    // Null Object Design patern
    Function GetN(Const path: SOString): ISuperObject;
    Procedure PutN(Const path: SOString; Const Value: ISuperObject);

    // Writers
    Function Write(writer: TSuperWriter; indent: Boolean; escape: Boolean; level: Integer): Integer;
    Function SaveTo(stream: TStream; indent: Boolean = False; escape: Boolean = True): Integer; Overload;
    Function SaveTo(Const FileName: String; indent: Boolean = False; escape: Boolean = True): Integer; Overload;
    Function SaveTo(socket: Longint; indent: Boolean = False; escape: Boolean = True): Integer; Overload;
    Function CalcSize(indent: Boolean = False; escape: Boolean = True): Integer;

    // convert
    Function AsBoolean: Boolean;
    Function AsInteger: SuperInt;
    Function AsDouble: Double;
    Function AsCurrency: Currency;
    Function AsString: SOString;
    Function AsArray: TSuperArray;
    Function AsObject: TSuperTableString;
{$IfDef SUPER_METHOD}
    Function AsMethod: TSuperMethod;
{$EndIf}
    Function AsJSon(indent: Boolean = False; escape: Boolean = True): SOString;

    Procedure Clear(all: Boolean = False);
    Procedure Pack(all: Boolean = False);

    Property N[Const path: SOString]: ISuperObject Read GetN Write PutN;
    Property O[Const path: SOString]: ISuperObject Read GetO Write PutO; Default;
    Property B[Const path: SOString]: Boolean Read GetB Write PutB;
    Property I[Const path: SOString]: SuperInt Read GetI Write PutI;
    Property D[Const path: SOString]: Double Read GetD Write PutD;
    Property C[Const path: SOString]: Currency Read GetC Write PutC;
    Property S[Const path: SOString]: SOString Read GetS Write PutS;
{$IfDef SUPER_METHOD}
    Property M[Const path: SOString]: TSuperMethod Read GetM Write PutM;
{$EndIf}
    Property A[Const path: SOString]: TSuperArray Read GetA;

{$IfDef SUPER_METHOD}
    Function call(Const path: SOString; Const param: ISuperObject = Nil): ISuperObject; Overload;
    Function call(Const path, param: SOString): ISuperObject; Overload;
{$EndIf}
    // clone a node
    Function Clone: ISuperObject;
    Function Delete(Const path: SOString): ISuperObject;
    // merges tow objects of same type, if reference is true then nodes are not cloned
    Procedure Merge(Const obj: ISuperObject; reference: Boolean = False); Overload;
    Procedure Merge(Const str: SOString); Overload;

    // validate methods
    Function Validate(Const rules: SOString; Const defs: SOString = ''; callback: TSuperOnValidateError = Nil; sender: Pointer = Nil): Boolean; Overload;
    Function Validate(Const rules: ISuperObject; Const defs: ISuperObject = Nil; callback: TSuperOnValidateError = Nil; sender: Pointer = Nil): Boolean; Overload;

    // compare
    Function Compare(Const obj: ISuperObject): TSuperCompareResult; Overload;
    Function Compare(Const str: SOString): TSuperCompareResult; Overload;

    // the data type
    Function IsType(AType: TSuperType): Boolean;
    Property DataType: TSuperType Read GetDataType;
    Property Processing: Boolean Read GetProcessing Write SetProcessing;

    Function GetDataPtr: Pointer;
    Procedure SetDataPtr(Const Value: Pointer);
    Property DataPtr: Pointer Read GetDataPtr Write SetDataPtr;
  End;

  TSuperObject = Class(TObject, ISuperObject)
  Private
    FRefCount: Integer;
    FProcessing: Boolean;
    FDataType: TSuperType;
    FDataPtr:  Pointer;
{.$if true}
    FO: Record
      Case TSuperType Of
        stBoolean: (c_boolean: Boolean);
        stDouble: (c_double: Double);
        stCurrency: (c_currency: Currency);
        stInt: (c_int: SuperInt);
        stObject: (c_object: TSuperTableString);
        stArray: (c_array: TSuperArray);
{$IfDef SUPER_METHOD}
        stMethod: (c_method: TSuperMethod);
{$EndIf}
    End;
{.$ifend}
    FOString: SOString;
    Function GetDataType: TSuperType;
    Function GetDataPtr: Pointer;
    Procedure SetDataPtr(Const Value: Pointer);
  Protected
    Function QueryInterface(Const IID: TGUID; out Obj): HResult; Virtual; Stdcall;
    Function _AddRef: Integer; Virtual; Stdcall;
    Function _Release: Integer; Virtual; Stdcall;

    Function GetO(Const path: SOString): ISuperObject;
    Procedure PutO(Const path: SOString; Const Value: ISuperObject);
    Function GetB(Const path: SOString): Boolean;
    Procedure PutB(Const path: SOString; Value: Boolean);
    Function GetI(Const path: SOString): SuperInt;
    Procedure PutI(Const path: SOString; Value: SuperInt);
    Function GetD(Const path: SOString): Double;
    Procedure PutD(Const path: SOString; Value: Double);
    Procedure PutC(Const path: SOString; Value: Currency);
    Function GetC(Const path: SOString): Currency;
    Function GetS(Const path: SOString): SOString;
    Procedure PutS(Const path: SOString; Const Value: SOString);
{$IfDef SUPER_METHOD}
    Function GetM(Const path: SOString): TSuperMethod;
    Procedure PutM(Const path: SOString; Value: TSuperMethod);
{$EndIf}
    Function GetA(Const path: SOString): TSuperArray;
    Function Write(writer: TSuperWriter; indent: Boolean; escape: Boolean; level: Integer): Integer; Virtual;
  Public
    Function GetEnumerator: TSuperEnumerator;
    Procedure AfterConstruction; Override;
    Procedure BeforeDestruction; Override;
    Class Function NewInstance: TObject; Override;
    Property RefCount: Integer Read FRefCount;

    Function GetProcessing: Boolean;
    Procedure SetProcessing(value: Boolean);

    // Writers
    Function SaveTo(stream: TStream; indent: Boolean = False; escape: Boolean = True): Integer; Overload;
    Function SaveTo(Const FileName: String; indent: Boolean = False; escape: Boolean = True): Integer; Overload;
    Function SaveTo(socket: Longint; indent: Boolean = False; escape: Boolean = True): Integer; Overload;
    Function CalcSize(indent: Boolean = False; escape: Boolean = True): Integer;
    Function AsJSon(indent: Boolean = False; escape: Boolean = True): SOString;

    // parser  ... owned!
    Class Function ParseString(s: PSOChar; strict: Boolean;
      partial: Boolean = True; Const this: ISuperObject = Nil;
      options: TSuperFindOptions = []; Const put: ISuperObject = Nil;
      dt: TSuperType = stNull): ISuperObject;
    Class Function ParseStream(stream: TStream; strict: Boolean;
      partial: Boolean = True; Const this: ISuperObject = Nil;
      options: TSuperFindOptions = []; Const put: ISuperObject = Nil;
      dt: TSuperType = stNull): ISuperObject;
    Class Function ParseFile(Const FileName: String; strict: Boolean;
      partial: Boolean = True; Const this: ISuperObject = Nil;
      options: TSuperFindOptions = []; Const put: ISuperObject = Nil;
      dt: TSuperType = stNull): ISuperObject;
    Class Function ParseEx(tok: TSuperTokenizer; str: PSOChar; len: Integer;
      strict: Boolean; Const this: ISuperObject = Nil;
      options: TSuperFindOptions = []; Const put: ISuperObject = Nil;
      dt: TSuperType = stNull): ISuperObject;

    // constructors / destructor
    Constructor Create(jt: TSuperType = stObject); Overload; Virtual;
    Constructor Create(b: Boolean); Overload; Virtual;
    Constructor Create(i: SuperInt); Overload; Virtual;
    Constructor Create(d: Double); Overload; Virtual;
    Constructor CreateCurrency(c: Currency); Overload; Virtual;
    Constructor Create(Const s: SOString); Overload; Virtual;
{$IfDef SUPER_METHOD}
    Constructor Create(m: TSuperMethod); Overload; Virtual;
{$EndIf}
    Destructor Destroy; Override;

    // convert
    Function AsBoolean: Boolean; Virtual;
    Function AsInteger: SuperInt; Virtual;
    Function AsDouble: Double; Virtual;
    Function AsCurrency: Currency; Virtual;
    Function AsString: SOString; Virtual;
    Function AsArray: TSuperArray; Virtual;
    Function AsObject: TSuperTableString; Virtual;
{$IfDef SUPER_METHOD}
    Function AsMethod: TSuperMethod; Virtual;
{$EndIf}
    Procedure Clear(all: Boolean = False); Virtual;
    Procedure Pack(all: Boolean = False); Virtual;
    Function GetN(Const path: SOString): ISuperObject;
    Procedure PutN(Const path: SOString; Const Value: ISuperObject);
    Function ForcePath(Const path: SOString; dataType: TSuperType = stObject): ISuperObject;
    Function Format(Const str: SOString; BeginSep: SOChar = '%'; EndSep: SOChar = '%'): SOString;

    Property N[Const path: SOString]: ISuperObject Read GetN Write PutN;
    Property O[Const path: SOString]: ISuperObject Read GetO Write PutO; Default;
    Property B[Const path: SOString]: Boolean Read GetB Write PutB;
    Property I[Const path: SOString]: SuperInt Read GetI Write PutI;
    Property D[Const path: SOString]: Double Read GetD Write PutD;
    Property C[Const path: SOString]: Currency Read GetC Write PutC;
    Property S[Const path: SOString]: SOString Read GetS Write PutS;
{$IfDef SUPER_METHOD}
    Property M[Const path: SOString]: TSuperMethod Read GetM Write PutM;
{$EndIf}
    Property A[Const path: SOString]: TSuperArray Read GetA;

{$IfDef SUPER_METHOD}
    Function call(Const path: SOString; Const param: ISuperObject = Nil): ISuperObject; Overload; Virtual;
    Function call(Const path, param: SOString): ISuperObject; Overload; Virtual;
{$EndIf}
    // clone a node
    Function Clone: ISuperObject; Virtual;
    Function Delete(Const path: SOString): ISuperObject;
    // merges tow objects of same type, if reference is true then nodes are not cloned
    Procedure Merge(Const obj: ISuperObject; reference: Boolean = False); Overload;
    Procedure Merge(Const str: SOString); Overload;

    // validate methods
    Function Validate(Const rules: SOString; Const defs: SOString = ''; callback: TSuperOnValidateError = Nil; sender: Pointer = Nil): Boolean; Overload;
    Function Validate(Const rules: ISuperObject; Const defs: ISuperObject = Nil; callback: TSuperOnValidateError = Nil; sender: Pointer = Nil): Boolean; Overload;

    // compare
    Function Compare(Const obj: ISuperObject): TSuperCompareResult; Overload;
    Function Compare(Const str: SOString): TSuperCompareResult; Overload;

    // the data type
    Function IsType(AType: TSuperType): Boolean;
    Property DataType: TSuperType Read GetDataType;
    // a data pointer to link to something ele, a treeview for example
    Property DataPtr: Pointer Read GetDataPtr Write SetDataPtr;
    Property Processing: Boolean Read GetProcessing;
  End;

{$IfDef VER210}
  TSuperRttiContext = Class;

  TSerialFromJson = Function(ctx: TSuperRttiContext; Const obj: ISuperObject; Var Value: TValue): Boolean;
  TSerialToJson = Function(ctx: TSuperRttiContext; Var value: TValue; Const index: ISuperObject): ISuperObject;

  TSuperAttribute = Class(TCustomAttribute)
  Private
    FName: String;
  Public
    Constructor Create(Const AName: String);
    Property Name: String Read FName;
  End;

  SOName = Class(TSuperAttribute);
  SODefault = Class(TSuperAttribute);


  TSuperRttiContext = Class
  Private
    Class Function GetFieldName(r: TRttiField): String;
    Class Function GetFieldDefault(r: TRttiField; Const obj: ISuperObject): ISuperObject;
  Public
    Context: TRttiContext;
    SerialFromJson: TDictionary<PTypeInfo, TSerialFromJson>;
    SerialToJson: TDictionary<PTypeInfo, TSerialToJson>;
    Constructor Create; Virtual;
    Destructor Destroy; Override;
    Function FromJson(TypeInfo: PTypeInfo; Const obj: ISuperObject; Var Value: TValue): Boolean; Virtual;
    Function ToJson(Var value: TValue; Const index: ISuperObject): ISuperObject; Virtual;
    Function AsType<T>(Const obj: ISuperObject): T;
    Function AsJson<T>(Const obj: T; Const index: ISuperObject = Nil): ISuperObject;
  End;

  TSuperObjectHelper = Class helper For TObject
  Public
    Function ToJson(ctx: TSuperRttiContext = Nil): ISuperObject;
    Constructor FromJson(Const obj: ISuperObject; ctx: TSuperRttiContext = Nil); Overload;
    Constructor FromJson(Const str: String; ctx: TSuperRttiContext = Nil); Overload;
  End;
{$EndIf}

  TSuperObjectIter = Record
    key: SOString;
    val: ISuperObject;
    Ite: TSuperAvlIterator;
  End;

Function ObjectIsError(obj: TSuperObject): Boolean;
Function ObjectIsType(Const obj: ISuperObject; typ: TSuperType): Boolean;
Function ObjectGetType(Const obj: ISuperObject): TSuperType;

Function ObjectFindFirst(Const obj: ISuperObject; Var F: TSuperObjectIter): Boolean;
Function ObjectFindNext(Var F: TSuperObjectIter): Boolean;
Procedure ObjectFindClose(Var F: TSuperObjectIter);

Function SO(Const s: SOString = '{}'): ISuperObject; Overload;
Function SO(Const value: Variant): ISuperObject; Overload;
Function SO(Const Args: Array Of Const): ISuperObject; Overload;

Function SA(Const Args: Array Of Const): ISuperObject; Overload;

Function JavaToDelphiDateTime(Const dt: Int64): TDateTime;
Function DelphiToJavaDateTime(Const dt: TDateTime): Int64;

{$IfDef VER210}

Type
  TSuperInvokeResult = (
    irSuccess,
    irMethothodError,  // method don't exist
    irParamError,     // invalid parametters
    irError            // other error
    );

Function TrySOInvoke(Var ctx: TSuperRttiContext; Const obj: TValue; Const method: String; Const params: ISuperObject; Var Return: ISuperObject): TSuperInvokeResult; Overload;
Function SOInvoke(Const obj: TValue; Const method: String; Const params: ISuperObject; ctx: TSuperRttiContext = Nil): ISuperObject; Overload;
Function SOInvoke(Const obj: TValue; Const method: String; Const params: String; ctx: TSuperRttiContext = Nil): ISuperObject; Overload;
{$EndIf}

Implementation
uses sysutils,
{$IfDef UNIX}
  baseunix, unix, DateUtils
{$ELSE}
  Windows
{$EndIf}
{$IfDef FPC}
  ,sockets
{$ELSE}
  ,WinSock
{$EndIf};

{$IfDef DEBUG}
var
  debugcount: integer = 0;
{$EndIf}

Const
  super_number_chars_set = ['0'..'9','.','+','-','e','E'];
  super_hex_chars: PSOChar = '0123456789abcdef';
  super_hex_chars_set = ['0'..'9','a'..'f','A'..'F'];

  ESC_BS: PSOChar = '\b';
  ESC_LF: PSOChar = '\n';
  ESC_CR: PSOChar = '\r';
  ESC_TAB: PSOChar = '\t';
  ESC_FF: PSOChar = '\f';
  ESC_QUOT: PSOChar = '\"';
  ESC_SL: PSOChar = '\\';
  ESC_SR: PSOChar = '\/';
  ESC_ZERO: PSOChar = '\u0000';

  TOK_CRLF: PSOChar = #13#10;
  TOK_SP: PSOChar = #32;
  TOK_BS: PSOChar = #8;
  TOK_TAB: PSOChar = #9;
  TOK_LF: PSOChar = #10;
  TOK_FF: PSOChar = #12;
  TOK_CR: PSOChar = #13;
//  TOK_SL: PSOChar = '\';
//  TOK_SR: PSOChar = '/';
  TOK_NULL: PSOChar = 'null';
  TOK_CBL: PSOChar = '{'; // curly bracket left
  TOK_CBR: PSOChar = '}'; // curly bracket right
  TOK_ARL: PSOChar = '[';
  TOK_ARR: PSOChar = ']';
  TOK_ARRAY: PSOChar = '[]';
  TOK_OBJ: PSOChar = '{}'; // empty object
  TOK_COM: PSOChar = ','; // Comma
  TOK_DQT: PSOChar = '"'; // Double Quote
  TOK_TRUE: PSOChar = 'true';
  TOK_FALSE: PSOChar = 'false';

{x$If (sizeof(Char) = 1)}
Function StrLComp(Const Str1, Str2: PSOChar; MaxLen: Cardinal): Integer;
Var
  P1, P2: PWideChar;
  I: Cardinal;
  C1, C2: Widechar;
Begin
  P1 := Str1;
  P2 := Str2;
  I  := 0;
  While I < MaxLen Do
  Begin
    C1 := P1^;
    C2 := P2^;

    If (C1 <> C2) Or (C1 = #0) Then
    Begin
      Result := Ord(C1) - Ord(C2);
      Exit;
    End;

    Inc(P1);
    Inc(P2);
    Inc(I);
  End;
  Result := 0;
End;

Function StrComp(Const Str1, Str2: PSOChar): Integer;
Var
  P1, P2: PWideChar;
  C1, C2: Widechar;
Begin
  P1 := Str1;
  P2 := Str2;
  While True Do
  Begin
    C1 := P1^;
    C2 := P2^;

    If (C1 <> C2) Or (C1 = #0) Then
    Begin
      Result := Ord(C1) - Ord(C2);
      Exit;
    End;

    Inc(P1);
    Inc(P2);
  End;
End;

Function StrLen(Const Str: PSOChar): Cardinal;
Var
  p: PSOChar;
Begin
  Result := 0;
  If Str <> Nil Then
  Begin
    p := Str;
    While p^ <> #0 Do
      inc(p);
    Result := (p - Str);
  End;
End;
{x$Ifend}

Function CurrToStr(c: Currency): SOString;
Var
  p: PSOChar;
  i, len: Integer;
Begin
  Result := IntToStr(Abs(PInt64(@c)^));
  len := Length(Result);
  SetLength(Result, len+1);
  If c <> 0 Then
  Begin
    While len <= 4 Do
    Begin
      Result := '0' + Result;
      inc(len);
    End;

    p := PSOChar(Result);
    inc(p, len-1);
    i := 0;
    Repeat
      If p^ <> '0' Then
      Begin
        len := len - i + 1;
        Repeat
          p[1] := p^;
          dec(p);
          inc(i);
        Until i > 3;
        Break;
      End;
      dec(p);
      inc(i);
      If i > 3 Then
      Begin
        len := len - i + 1;
        Break;
      End;
    Until False;
    p[1] := '.';
    SetLength(Result, len);
    If c < 0 Then
      Result := '-' + Result;
  End;
End;

{$IfDef UNIX}
  {$linklib c}
{$EndIf}
Function gcvt(value: Double; ndigit: Longint; buf: PAnsiChar): PAnsiChar; Cdecl;
  External {$IfDef MSWINDOWS} 'msvcrt.dll' Name '_gcvt'{$EndIf};

{$IfDef UNIX}
Type
  ptm = ^tm;
  tm = Record
    tm_sec: Integer;    (* Seconds: 0-59 (K&R says 0-61?) *)
    tm_min: Integer;    (* Minutes: 0-59 *)
    tm_hour: Integer;  (* Hours since midnight: 0-23 *)
    tm_mday: Integer;  (* Day of the month: 1-31 *)
    tm_mon: Integer;    (* Months *since* january: 0-11 *)
    tm_year: Integer;  (* Years since 1900 *)
    tm_wday: Integer;  (* Days since Sunday (0-6) *)
    tm_yday: Integer;  (* Days since Jan. 1: 0-365 *)
    tm_isdst: Integer;  (* +1 Daylight Savings Time, 0 No DST, -1 don't know *)
  End;

Function mktime(p: ptm): Longint; Cdecl; External;
Function gmtime(Const t: PLongint): ptm; Cdecl; External;
Function localtime (Const t: PLongint): ptm; Cdecl; External;

Function DelphiToJavaDateTime(Const dt: TDateTime): Int64;
Var
  p: ptm;
  l, ms: Integer;
  v: Int64;
Begin
  v := Round((dt - 25569) * 86400000);
  ms := v Mod 1000;
  l := v Div 1000;
  p := localtime(@l);
  Result := Int64(mktime(p)) * 1000 + ms;
End;

Function JavaToDelphiDateTime(Const dt: Int64): TDateTime;
Var
  p: ptm;
  l, ms: Integer;
Begin
  l := dt Div 1000;
  ms := dt Mod 1000;
  p := gmtime(@l);
  Result := EncodeDateTime(p^.tm_year+1900, p^.tm_mon+1, p^.tm_mday, p^.tm_hour, p^.tm_min, p^.tm_sec, ms);
End;
{$ELSE}

{$IfDef WINDOWSNT_COMPATIBILITY}
Function DayLightCompareDate(Const date: PSystemTime;
  Const compareDate: PSystemTime): Integer;
Var
  limit_day, dayinsecs, weekofmonth: Integer;
  First: Word;
Begin
  If (date^.wMonth < compareDate^.wMonth) Then
  Begin
    Result := -1; (* We are in a month before the date limit. *)
    Exit;
  End;

  If (date^.wMonth > compareDate^.wMonth) Then
  Begin
    Result := 1; (* We are in a month after the date limit. *)
    Exit;
  End;

  (* if year is 0 then date is in day-of-week format, otherwise
   * it's absolute date.
   *)
  If (compareDate^.wYear = 0) Then
  Begin
    (* compareDate.wDay is interpreted as number of the week in the month
     * 5 means: the last week in the month *)
    weekofmonth := compareDate^.wDay;
    (* calculate the day of the first DayOfWeek in the month *)
    First := (6 + compareDate^.wDayOfWeek - date^.wDayOfWeek + date^.wDay) Mod 7 + 1;
    limit_day := First + 7 * (weekofmonth - 1);
    (* check needed for the 5th weekday of the month *)
    If (limit_day > MonthDays[(date^.wMonth=2) And IsLeapYear(date^.wYear)][date^.wMonth - 1]) Then
      dec(limit_day, 7);
  End
  Else
    limit_day := compareDate^.wDay;

  (* convert to seconds *)
  limit_day := ((limit_day * 24  + compareDate^.wHour) * 60 + compareDate^.wMinute ) * 60;
  dayinsecs := ((date^.wDay * 24  + date^.wHour) * 60 + date^.wMinute ) * 60 + date^.wSecond;
  (* and compare *)

  If dayinsecs < limit_day Then
    Result :=  -1 Else
  If dayinsecs > limit_day Then
    Result :=  1 Else
    Result :=  0; (* date is equal to the date limit. *)
End;

Function CompTimeZoneID(Const pTZinfo: PTimeZoneInformation;
  lpFileTime: PFileTime; islocal: Boolean): Longword;
Var
  ret: Integer;
  beforeStandardDate, afterDaylightDate: Boolean;
  llTime: Int64;
  SysTime: TSystemTime;
  ftTemp: TFileTime;
Begin
  llTime := 0;

  If (pTZinfo^.DaylightDate.wMonth <> 0) Then
  Begin
    (* if year is 0 then date is in day-of-week format, otherwise
     * it's absolute date.
     *)
    If ((pTZinfo^.StandardDate.wMonth = 0) Or
      ((pTZinfo^.StandardDate.wYear = 0) And
      ((pTZinfo^.StandardDate.wDay < 1) Or
      (pTZinfo^.StandardDate.wDay > 5) Or
      (pTZinfo^.DaylightDate.wDay < 1) Or
      (pTZinfo^.DaylightDate.wDay > 5)))) Then
    Begin
      SetLastError(ERROR_INVALID_PARAMETER);
      Result := TIME_ZONE_ID_INVALID;
      Exit;
    End;

    If (Not islocal) Then
    Begin
      llTime := PInt64(lpFileTime)^;
      dec(llTime, Int64(pTZinfo^.Bias + pTZinfo^.DaylightBias) * 600000000);
      PInt64(@ftTemp)^ := llTime;
      lpFileTime := @ftTemp;
    End;

    FileTimeToSystemTime(lpFileTime^, SysTime);

    (* check for daylight savings *)
    ret := DayLightCompareDate(@SysTime, @pTZinfo^.StandardDate);
    If (ret = -2) Then
    Begin
      Result := TIME_ZONE_ID_INVALID;
      Exit;
    End;

    beforeStandardDate := ret < 0;

    If (Not islocal) Then
    Begin
      dec(llTime, Int64(pTZinfo^.StandardBias - pTZinfo^.DaylightBias) * 600000000);
      PInt64(@ftTemp)^ := llTime;
      FileTimeToSystemTime(lpFileTime^, SysTime);
    End;

    ret := DayLightCompareDate(@SysTime, @pTZinfo^.DaylightDate);
    If (ret = -2) Then
    Begin
      Result := TIME_ZONE_ID_INVALID;
      Exit;
    End;

    afterDaylightDate := ret >= 0;

    Result := TIME_ZONE_ID_STANDARD;
    If( pTZinfo^.DaylightDate.wMonth < pTZinfo^.StandardDate.wMonth ) Then
    Begin
      (* Northern hemisphere *)
      If( beforeStandardDate And afterDaylightDate) Then
        Result := TIME_ZONE_ID_DAYLIGHT;
    End
    Else    (* Down south *)
    If( beforeStandardDate Or afterDaylightDate) Then
      Result := TIME_ZONE_ID_DAYLIGHT;
  End
  Else
    (* No transition date *)
    Result := TIME_ZONE_ID_UNKNOWN;
End;

Function GetTimezoneBias(Const pTZinfo: PTimeZoneInformation;
  lpFileTime: PFileTime; islocal: Boolean; pBias: PLongint): Boolean;
Var
  bias: Longint;
  tzid: Longword;
Begin
  bias := pTZinfo^.Bias;
  tzid := CompTimeZoneID(pTZinfo, lpFileTime, islocal);

  If( tzid = TIME_ZONE_ID_INVALID) Then
  Begin
    Result := False;
    Exit;
  End;
  If (tzid = TIME_ZONE_ID_DAYLIGHT) Then
    inc(bias, pTZinfo^.DaylightBias)
  Else
  If (tzid = TIME_ZONE_ID_STANDARD) Then
    inc(bias, pTZinfo^.StandardBias);
  pBias^ := bias;
  Result := True;
End;

Function SystemTimeToTzSpecificLocalTime(
  lpTimeZoneInformation: PTimeZoneInformation;
  lpUniversalTime, lpLocalTime: PSystemTime): BOOL;
Var
  ft: TFileTime;
  lBias: Longint;
  llTime: Int64;
  tzinfo: TTimeZoneInformation;
Begin
  If (lpTimeZoneInformation <> Nil) Then
    tzinfo := lpTimeZoneInformation^ Else
  If (GetTimeZoneInformation(tzinfo) = TIME_ZONE_ID_INVALID) Then
  Begin
    Result := False;
    Exit;
  End;

  If (Not SystemTimeToFileTime(lpUniversalTime^, ft)) Then
  Begin
    Result := False;
    Exit;
  End;
  llTime := PInt64(@ft)^;
  If (Not GetTimezoneBias(@tzinfo, @ft, False, @lBias)) Then
  Begin
    Result := False;
    Exit;
  End;
  (* convert minutes to 100-nanoseconds-ticks *)
  dec(llTime, Int64(lBias) * 600000000);
  PInt64(@ft)^ := llTime;
  Result := FileTimeToSystemTime(ft, lpLocalTime^);
End;

Function TzSpecificLocalTimeToSystemTime(
  Const lpTimeZoneInformation: PTimeZoneInformation;
  Const lpLocalTime: PSystemTime; lpUniversalTime: PSystemTime): BOOL;
Var
  ft: TFileTime;
  lBias: Longint;
  t:  Int64;
  tzinfo: TTimeZoneInformation;
Begin
  If (lpTimeZoneInformation <> Nil) Then
    tzinfo := lpTimeZoneInformation^
  Else
  If (GetTimeZoneInformation(tzinfo) = TIME_ZONE_ID_INVALID) Then
  Begin
    Result := False;
    Exit;
  End;

  If (Not SystemTimeToFileTime(lpLocalTime^, ft)) Then
  Begin
    Result := False;
    Exit;
  End;
  t := PInt64(@ft)^;
  If (Not GetTimezoneBias(@tzinfo, @ft, True, @lBias)) Then
  Begin
    Result := False;
    Exit;
  End;
  (* convert minutes to 100-nanoseconds-ticks *)
  inc(t, Int64(lBias) * 600000000);
  PInt64(@ft)^ := t;
  Result := FileTimeToSystemTime(ft, lpUniversalTime^);
End;
{$ELSE}
Function TzSpecificLocalTimeToSystemTime(
  lpTimeZoneInformation: PTimeZoneInformation;
  lpLocalTime, lpUniversalTime: PSystemTime): BOOL; Stdcall; External 'kernel32.dll';

Function SystemTimeToTzSpecificLocalTime(
  lpTimeZoneInformation: PTimeZoneInformation;
  lpUniversalTime, lpLocalTime: PSystemTime): BOOL; Stdcall; External 'kernel32.dll';
{$EndIf}

Function JavaToDelphiDateTime(Const dt: Int64): TDateTime;
Var
  t: TSystemTime;
Begin
  DateTimeToSystemTime(25569 + (dt / 86400000), t);
  SystemTimeToTzSpecificLocalTime(Nil, @t, @t);
  Result := SystemTimeToDateTime(t);
End;

Function DelphiToJavaDateTime(Const dt: TDateTime): Int64;
Var
  t: TSystemTime;
Begin
  DateTimeToSystemTime(dt, t);
  TzSpecificLocalTimeToSystemTime(Nil, @t, @t);
  Result := Round((SystemTimeToDateTime(t) - 25569) * 86400000)
End;
{$EndIf}


Function SO(Const s: SOString): ISuperObject; Overload;
Begin
  Result := TSuperObject.ParseString(PSOChar(s), False);
End;

Function SA(Const Args: Array Of Const): ISuperObject; Overload;
Type
  TByteArray = Array[0..sizeof(Integer) - 1] Of Byte;
  PByteArray = ^TByteArray;
Var
  j: Integer;
  intf: IInterface;
Begin
  Result := TSuperObject.Create(stArray);
  For j := 0 To length(Args) - 1 Do
    With Result.AsArray Do
      Case TVarRec(Args[j]).VType Of
        vtInteger :
          Add(TSuperObject.Create(TVarRec(Args[j]).VInteger));
        vtInt64   :
          Add(TSuperObject.Create(TVarRec(Args[j]).VInt64^));
        vtBoolean :
          Add(TSuperObject.Create(TVarRec(Args[j]).VBoolean));
        vtChar    :
          Add(TSuperObject.Create(SOString(TVarRec(Args[j]).VChar)));
        vtWideChar:
          Add(TSuperObject.Create(SOChar(TVarRec(Args[j]).VWideChar)));
        vtExtended:
          Add(TSuperObject.Create(TVarRec(Args[j]).VExtended^));
        vtCurrency:
          Add(TSuperObject.CreateCurrency(TVarRec(Args[j]).VCurrency^));
        vtString  :
          Add(TSuperObject.Create(SOString(TVarRec(Args[j]).VString^)));
        vtPChar   :
          Add(TSuperObject.Create(SOString(TVarRec(Args[j]).VPChar^)));
        vtAnsiString:
          Add(TSuperObject.Create(SOString(Ansistring(TVarRec(Args[j]).VAnsiString))));
        vtWideString:
          Add(TSuperObject.Create(SOString(PWideChar(TVarRec(Args[j]).VWideString))));
        vtInterface:
          If TVarRec(Args[j]).VInterface = Nil Then
            Add(Nil) Else
          If IInterface(TVarRec(Args[j]).VInterface).QueryInterface(ISuperObject, intf) = 0 Then
            Add(ISuperObject(intf)) Else
            Add(Nil);
        vtPointer :
          If TVarRec(Args[j]).VPointer = Nil Then
            Add(Nil) Else
            Add(TSuperObject.Create(PtrInt(TVarRec(Args[j]).VPointer)));
        vtVariant:
          Add(SO(TVarRec(Args[j]).VVariant^));
        vtObject:
          If TVarRec(Args[j]).VPointer = Nil Then
            Add(Nil) Else
            Add(TSuperObject.Create(PtrInt(TVarRec(Args[j]).VPointer)));
        vtClass:
          If TVarRec(Args[j]).VPointer = Nil Then
            Add(Nil) Else
            Add(TSuperObject.Create(PtrInt(TVarRec(Args[j]).VPointer)));
{$If declared(vtUnicodeString)}
        vtUnicodeString:
          Add(TSuperObject.Create(SOString(String(TVarRec(Args[j]).VUnicodeString))));
{$Ifend}
      Else
        assert(False);
      End;
End;

Function SO(Const Args: Array Of Const): ISuperObject; Overload;
Var
  j: Integer;
  arr: ISuperObject;
Begin
  Result := TSuperObject.Create(stObject);
  arr := SA(Args);
  With arr.AsArray Do
    For j := 0 To (Length Div 2) - 1 Do
      Result.AsObject.PutO(O[j*2].AsString, O[(j*2) + 1]);
End;

Function SO(Const value: Variant): ISuperObject; Overload;
Begin
  With TVarData(value) Do
    Case VType Of
      varNull:
        Result := Nil;
      varEmpty:
        Result := Nil;
      varSmallInt:
        Result := TSuperObject.Create(VSmallInt);
      varInteger:
        Result := TSuperObject.Create(VInteger);
      varSingle:
        Result := TSuperObject.Create(VSingle);
      varDouble:
        Result := TSuperObject.Create(VDouble);
      varCurrency:
        Result := TSuperObject.CreateCurrency(VCurrency);
      varDate:
        Result := TSuperObject.Create(DelphiToJavaDateTime(vDate));
      varOleStr:
        Result := TSuperObject.Create(SOString(VOleStr));
      varBoolean:
        Result := TSuperObject.Create(VBoolean);
      varShortInt:
        Result := TSuperObject.Create(VShortInt);
      varByte:
        Result := TSuperObject.Create(VByte);
      varWord:
        Result := TSuperObject.Create(VWord);
      varLongWord:
        Result := TSuperObject.Create(VLongWord);
      varInt64:
        Result := TSuperObject.Create(VInt64);
      varString:
        Result := TSuperObject.Create(SOString(Ansistring(VString)));
{$If declared(varUString)}
      varUString:
        Result := TSuperObject.Create(SOString(String(VUString)));
{$Ifend}
    Else
      Raise Exception.CreateFmt('Unsuported variant data type: %d', [VType]);
    End;
End;

Function ObjectIsError(obj: TSuperObject): Boolean;
Begin
  Result := PtrUInt(obj) > PtrUInt(-4000);
End;

Function ObjectIsType(Const obj: ISuperObject; typ: TSuperType): Boolean;
Begin
  If obj <> Nil Then
    Result := typ = obj.DataType Else
    Result := typ = stNull;
End;

Function ObjectGetType(Const obj: ISuperObject): TSuperType;
Begin
  If obj <> Nil Then
    Result := obj.DataType Else
    Result := stNull;
End;

Function ObjectFindFirst(Const obj: ISuperObject; Var F: TSuperObjectIter): Boolean;
Var
  i: TSuperAvlEntry;
Begin
  If ObjectIsType(obj, stObject) Then
  Begin
    F.Ite := TSuperAvlIterator.Create(obj.AsObject);
    F.Ite.First;
    i := F.Ite.GetIter;
    If i <> Nil Then
    Begin
      f.key := i.Name;
      f.val := i.Value;
      Result := True;
    End
    Else
      Result := False;
  End
  Else
    Result := False;
End;

Function ObjectFindNext(Var F: TSuperObjectIter): Boolean;
Var
  i: TSuperAvlEntry;
Begin
  F.Ite.Next;
  i := F.Ite.GetIter;
  If i <> Nil Then
  Begin
    f.key := i.FName;
    f.val := i.Value;
    Result := True;
  End
  Else
    Result := False;
End;

Procedure ObjectFindClose(Var F: TSuperObjectIter);
Begin
  F.Ite.Free;
  F.val := Nil;
End;

{$IfDef VER210}

Function serialtoboolean(ctx: TSuperRttiContext; Var value: TValue; Const index: ISuperObject): ISuperObject;
Begin
  Result := TSuperObject.Create(TValueData(value).FAsSLong <> 0);
End;

Function serialtodatetime(ctx: TSuperRttiContext; Var value: TValue; Const index: ISuperObject): ISuperObject;
Begin
  Result := TSuperObject.Create(DelphiToJavaDateTime(TValueData(value).FAsDouble));
End;

Function serialtoguid(ctx: TSuperRttiContext; Var value: TValue; Const index: ISuperObject): ISuperObject;
Var
  g: TGUID;
Begin
  value.ExtractRawData(@g);
  Result := TSuperObject.Create(
    format('%.8x-%.4x-%.4x-%.2x%.2x-%.2x%.2x%.2x%.2x%.2x%.2x',
    [g.D1, g.D2, g.D3,
    g.D4[0], g.D4[1], g.D4[2],
    g.D4[3], g.D4[4], g.D4[5],
    g.D4[6], g.D4[7]])
    );
End;

Function serialfromboolean(ctx: TSuperRttiContext; Const obj: ISuperObject; Var Value: TValue): Boolean;
Var
  o: ISuperObject;
Begin
  Case ObjectGetType(obj) Of
    stBoolean:
    Begin
      TValueData(Value).FAsSLong := obj.AsInteger;
      Result := True;
    End;
    stInt:
    Begin
      TValueData(Value).FAsSLong := ord(obj.AsInteger <> 0);
      Result := True;
    End;
    stString:
    Begin
      o := SO(obj.AsString);
      If Not ObjectIsType(o, stString) Then
        Result := serialfromboolean(ctx, SO(obj.AsString), Value) Else
        Result := False;
    End;
  Else
    Result := False;
  End;
End;

Function serialfromdatetime(ctx: TSuperRttiContext; Const obj: ISuperObject; Var Value: TValue): Boolean;
Var
  dt: TDateTime;
Begin
  Case ObjectGetType(obj) Of
    stInt:
    Begin
      TValueData(Value).FAsDouble := JavaToDelphiDateTime(obj.AsInteger);
      Result := True;
    End;
    stString:
    Begin
      If TryStrToDateTime(obj.AsString, dt) Then
      Begin
        TValueData(Value).FAsDouble := dt;
        Result := True;
      End
      Else
        Result := False;
    End;
  Else
    Result := False;
  End;
End;

Function UuidFromString(Const s: PSOChar; Uuid: PGUID): Boolean;
Const
  hex2bin: Array[#0..#102] Of short = (
    -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,        (* 0x00 *)
    -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,        (* 0x10 *)
    -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,        (* 0x20 *)
    0, 1, 2, 3, 4, 5, 6, 7, 8, 9,-1,-1,-1,-1,-1,-1,        (* 0x30 *)
    -1,10,11,12,13,14,15,-1,-1,-1,-1,-1,-1,-1,-1,-1,        (* 0x40 *)
    -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,        (* 0x50 *)
    -1,10,11,12,13,14,15);                                  (* 0x60 *)
Var
  i: Integer;
Begin
  If (strlen(s) <> 36) Then
    Exit(False);

  If ((s[8] <> '-') Or (s[13] <> '-') Or (s[18] <> '-') Or (s[23] <> '-')) Then
    Exit(False);

  For i := 0 To 35 Do
  Begin
    If Not i In [8,13,18,23] Then
      If ((s[i] > 'f') Or ((hex2bin[s[i]] = -1) And (s[i] <> ''))) Then
        Exit(False);
  End;

  uuid.D1 := ((hex2bin[s[0]] Shl 28) Or (hex2bin[s[1]] Shl 24) Or (hex2bin[s[2]] Shl 20) Or (hex2bin[s[3]] Shl 16) Or
    (hex2bin[s[4]] Shl 12) Or (hex2bin[s[5]] Shl 8) Or (hex2bin[s[6]]  Shl 4) Or hex2bin[s[7]]);
  uuid.D2 := (hex2bin[s[9]] Shl 12) Or (hex2bin[s[10]] Shl 8) Or (hex2bin[s[11]] Shl 4) Or hex2bin[s[12]];
  uuid.D3 := (hex2bin[s[14]] Shl 12) Or (hex2bin[s[15]] Shl 8) Or (hex2bin[s[16]] Shl 4) Or hex2bin[s[17]];

  uuid.D4[0] := (hex2bin[s[19]] Shl 4) Or hex2bin[s[20]];
  uuid.D4[1] := (hex2bin[s[21]] Shl 4) Or hex2bin[s[22]];
  uuid.D4[2] := (hex2bin[s[24]] Shl 4) Or hex2bin[s[25]];
  uuid.D4[3] := (hex2bin[s[26]] Shl 4) Or hex2bin[s[27]];
  uuid.D4[4] := (hex2bin[s[28]] Shl 4) Or hex2bin[s[29]];
  uuid.D4[5] := (hex2bin[s[30]] Shl 4) Or hex2bin[s[31]];
  uuid.D4[6] := (hex2bin[s[32]] Shl 4) Or hex2bin[s[33]];
  uuid.D4[7] := (hex2bin[s[34]] Shl 4) Or hex2bin[s[35]];
  Result := True;
End;

Function serialfromguid(ctx: TSuperRttiContext; Const obj: ISuperObject; Var Value: TValue): Boolean;
Begin
  Case ObjectGetType(obj) Of
    stNull:
    Begin
      FillChar(Value.GetReferenceToRawData^, SizeOf(TGUID), 0);
      Result := True;
    End;
    stString:
      Result := UuidFromString(PSOChar(obj.AsString), Value.GetReferenceToRawData);
  Else
    Result := False;
  End;
End;

Function SOInvoke(Const obj: TValue; Const method: String; Const params: ISuperObject; ctx: TSuperRttiContext): ISuperObject; Overload;
Var
  owned: Boolean;
Begin
  If ctx = Nil Then
  Begin
    ctx := TSuperRttiContext.Create;
    owned := True;
  End
  Else
    owned := False;
  Try
    If TrySOInvoke(ctx, obj, method, params, Result) <> irSuccess Then
      Raise Exception.Create('Invalid method call');
  Finally
    If owned Then
      ctx.Free;
  End;
End;

Function SOInvoke(Const obj: TValue; Const method: String; Const params: String; ctx: TSuperRttiContext): ISuperObject; Overload;
Begin
  Result := SOInvoke(obj, method, so(params), ctx)
End;

Function TrySOInvoke(Var ctx: TSuperRttiContext; Const obj: TValue;
  Const method: String; Const params: ISuperObject;
  Var Return: ISuperObject): TSuperInvokeResult;
Var
  t: TRttiInstanceType;
  m: TRttiMethod;
  a: TArray<TValue>;
  ps: TArray<TRttiParameter>;
  v: TValue;
  index: ISuperObject;

  Function GetParams: Boolean;
  Var
    i: Integer;
  Begin
    Case ObjectGetType(params) Of
      stArray:
        For i := 0 To Length(ps) - 1 Do
          If (pfOut In ps[i].Flags) Then
            TValue.Make(Nil, ps[i].ParamType.Handle, a[i]) Else
          If Not ctx.FromJson(ps[i].ParamType.Handle, params.AsArray[i], a[i]) Then
            Exit(False);
      stObject:
        For i := 0 To Length(ps) - 1 Do
          If (pfOut In ps[i].Flags) Then
            TValue.Make(Nil, ps[i].ParamType.Handle, a[i]) Else
          If Not ctx.FromJson(ps[i].ParamType.Handle, params.AsObject[ps[i].Name], a[i]) Then
            Exit(False);
      stNull:
        ;
    Else
      Exit(False);
    End;
    Result := True;
  End;

  Procedure SetParams;
  Var
    i: Integer;
  Begin
    Case ObjectGetType(params) Of
      stArray:
        For i := 0 To Length(ps) - 1 Do
          If (ps[i].Flags * [pfVar, pfOut]) <> [] Then
            params.AsArray[i] := ctx.ToJson(a[i], index);
      stObject:
        For i := 0 To Length(ps) - 1 Do
          If (ps[i].Flags * [pfVar, pfOut]) <> [] Then
            params.AsObject[ps[i].Name] := ctx.ToJson(a[i], index);
    End;
  End;

Begin
  Result := irSuccess;
  index  := SO;
  Case obj.Kind Of
    tkClass:
    Begin
      t := TRttiInstanceType(ctx.Context.GetType(obj.AsObject.ClassType));
      m := t.GetMethod(method);
      If m = Nil Then
        Exit(irMethothodError);
      ps := m.GetParameters;
      SetLength(a, Length(ps));
      If Not GetParams Then
        Exit(irParamError);
      If m.IsClassMethod Then
      Begin
        v := m.Invoke(obj.AsObject.ClassType, a);
        Return := ctx.ToJson(v, index);
        SetParams;
      End
      Else
      Begin
        v := m.Invoke(obj, a);
        Return := ctx.ToJson(v, index);
        SetParams;
      End;
    End;
    tkClassRef:
    Begin
      t := TRttiInstanceType(ctx.Context.GetType(obj.AsClass));
      m := t.GetMethod(method);
      If m = Nil Then
        Exit(irMethothodError);
      ps := m.GetParameters;
      SetLength(a, Length(ps));

      If Not GetParams Then
        Exit(irParamError);
      If m.IsClassMethod Then
      Begin
        v := m.Invoke(obj, a);
        Return := ctx.ToJson(v, index);
        SetParams;
      End
      Else
        Exit(irError);
    End;
  Else
    Exit(irError);
  End;
End;

{$EndIf}

{ TSuperEnumerator }

Constructor TSuperEnumerator.Create(Const obj: ISuperObject);
Begin
  FObj := obj;
  FCount := -1;
  If ObjectIsType(FObj, stObject) Then
    FObjEnum := FObj.AsObject.GetEnumerator Else
    FObjEnum := Nil;
End;

Destructor TSuperEnumerator.Destroy;
Begin
  If FObjEnum <> Nil Then
    FObjEnum.Free;
End;

Function TSuperEnumerator.MoveNext: Boolean;
Begin
  Case ObjectGetType(FObj) Of
    stObject:
      Result := FObjEnum.MoveNext;
    stArray:
    Begin
      inc(FCount);
      If FCount < FObj.AsArray.Length Then
        Result := True Else
        Result := False;
    End;
  Else
    Result := False;
  End;
End;

Function TSuperEnumerator.GetCurrent: ISuperObject;
Begin
  Case ObjectGetType(FObj) Of
    stObject:
      Result := FObjEnum.Current.Value;
    stArray:
      Result := FObj.AsArray.GetO(FCount);
  Else
    Result := FObj;
  End;
End;

{ TSuperObject }

Constructor TSuperObject.Create(jt: TSuperType);
Begin
  Inherited Create;
{$IfDef DEBUG}
  InterlockedIncrement(debugcount);
{$EndIf}

  FProcessing := False;
  FDataPtr := Nil;
  FDataType := jt;
  Case FDataType Of
    stObject:
      FO.c_object := TSuperTableString.Create;
    stArray:
      FO.c_array := TSuperArray.Create;
    stString:
      FOString := '';
  Else
    FO.c_object := Nil;
  End;
End;

Constructor TSuperObject.Create(b: Boolean);
Begin
  Create(stBoolean);
  FO.c_boolean := b;
End;

Constructor TSuperObject.Create(i: SuperInt);
Begin
  Create(stInt);
  FO.c_int := i;
End;

Constructor TSuperObject.Create(d: Double);
Begin
  Create(stDouble);
  FO.c_double := d;
End;

Constructor TSuperObject.CreateCurrency(c: Currency);
Begin
  Create(stCurrency);
  FO.c_currency := c;
End;

Destructor TSuperObject.Destroy;
Begin
{$IfDef DEBUG}
  InterlockedDecrement(debugcount);
{$EndIf}
  Case FDataType Of
    stObject:
      FO.c_object.Free;
    stArray:
      FO.c_array.Free;
  End;
  Inherited;
End;

Function TSuperObject.Write(writer: TSuperWriter; indent: Boolean; escape: Boolean; level: Integer): Integer;
  Function DoEscape(str: PSOChar; len: Integer): Integer;
  Var
    pos, start_offset: Integer;
    c: SOChar;
    buf: Array[0..5] Of SOChar;
  Type
    TByteChar = Record
      Case Integer Of
        0: (a, b: Byte);
        1: (c: Widechar);
    End;
  Begin
    If str = Nil Then
    Begin
      Result := 0;
      exit;
    End;

    pos := 0; start_offset := 0;
    With writer Do
      While pos < len Do
      Begin
        c := str[pos];
        Case c Of
          #8,#9,#10,#12,#13,'"','\','/':
          Begin
            If(pos - start_offset > 0) Then
              Append(str + start_offset, pos - start_offset);

            If(c = #8) Then
              Append(ESC_BS, 2)
            Else
            If (c = #9) Then
              Append(ESC_TAB, 2)
            Else
            If (c = #10) Then
              Append(ESC_LF, 2)
            Else
            If (c = #12) Then
              Append(ESC_FF, 2)
            Else
            If (c = #13) Then
              Append(ESC_CR, 2)
            Else
            If (c = '"') Then
              Append(ESC_QUOT, 2)
            Else
            If (c = '\') Then
              Append(ESC_SL, 2)
            Else
            If (c = '/') Then
              Append(ESC_SR, 2);
            inc(pos);
            start_offset := pos;
          End;

          Else
            If (SOIChar(c) > 255) Then
            Begin
              If(pos - start_offset > 0) Then
                Append(str + start_offset, pos - start_offset);
              buf[0] := '\';
              buf[1] := 'u';
              buf[2] := super_hex_chars[TByteChar(c).b Shr 4];
              buf[3] := super_hex_chars[TByteChar(c).b And $f];
              buf[4] := super_hex_chars[TByteChar(c).a Shr 4];
              buf[5] := super_hex_chars[TByteChar(c).a And $f];
              Append(@buf, 6);
              inc(pos);
              start_offset := pos;
            End
            Else If (c < #32) Or (c > #127) Then
            Begin
              If(pos - start_offset > 0) Then
                Append(str + start_offset, pos - start_offset);
              buf[0] := '\';
              buf[1] := 'u';
              buf[2] := '0';
              buf[3] := '0';
              buf[4] := super_hex_chars[ord(c) Shr 4];
              buf[5] := super_hex_chars[ord(c) And $f];
              Append(buf, 6);
              inc(pos);
              start_offset := pos;
            End
            Else
              inc(pos);
        End;
      End;

    If(pos - start_offset > 0) Then
      writer.Append(str + start_offset, pos - start_offset);
      
    Result := 0;
  End;

  Function DoMinimalEscape(str: PSOChar; len: Integer): Integer;
  Var
    pos, start_offset: Integer;
    c: SOChar;
  Type
    TByteChar = Record
      Case Integer Of
        0: (a, b: Byte);
        1: (c: Widechar);
    End;
  Begin
    If str = Nil Then
    Begin
      Result := 0;
      exit;
    End;
    pos := 0; start_offset := 0;
    With writer Do
      While pos < len Do
      Begin
        c := str[pos];
        Case c Of
          #0:
          Begin
            If(pos - start_offset > 0) Then
              Append(str + start_offset, pos - start_offset);
            Append(ESC_ZERO, 6);
            inc(pos);
            start_offset := pos;
          End;
          '"':
          Begin
            If(pos - start_offset > 0) Then
              Append(str + start_offset, pos - start_offset);
            Append(ESC_QUOT, 2);
            inc(pos);
            start_offset := pos;
          End;
          '\':
          Begin
            If(pos - start_offset > 0) Then
              Append(str + start_offset, pos - start_offset);
            Append(ESC_SL, 2);
            inc(pos);
            start_offset := pos;
          End;
          '/':
          Begin
            If(pos - start_offset > 0) Then
              Append(str + start_offset, pos - start_offset);
            Append(ESC_SR, 2);
            inc(pos);
            start_offset := pos;
          End;
        Else
          inc(pos);
        End;
      End;
    If(pos - start_offset > 0) Then
      writer.Append(str + start_offset, pos - start_offset);
    Result := 0;
  End;


  Procedure _indent(i: Shortint; r: Boolean);
  Begin
    inc(level, i);
    If r Then
      With writer Do
      Begin
{$IfDef MSWINDOWS}
        Append(TOK_CRLF, 2);
{$ELSE}
        Append(TOK_LF, 1);
{$EndIf}
        For i := 0 To level - 1 Do
          Append(TOK_SP, 1);
      End;
  End;
Var
  k,j: Integer;
  iter: TSuperObjectIter;
  st:  Ansistring;
  val: ISuperObject;
  fbuffer: Array[0..31] Of AnsiChar;
Const
  ENDSTR_A: PSOChar = '": ';
  ENDSTR_B: PSOChar = '":';
Begin

  If FProcessing Then
  Begin
    Result := writer.Append(TOK_NULL, 4);
    Exit;
  End;

  FProcessing := True;
  With writer Do
    Try
      Case FDataType Of
        stObject:
          If FO.c_object.FCount > 0 Then
          Begin
            k := 0;
            Append(TOK_CBL, 1);
            If indent Then
              _indent(1, False);
            If ObjectFindFirst(Self, iter) Then
              Repeat
  {$IfDef SUPER_METHOD}
                If (iter.val = Nil) Or Not ObjectIsType(iter.val, stMethod) Then
                Begin
  {$EndIf}
                  If (iter.val = Nil) Or (Not iter.val.Processing) Then
                  Begin
                    If(k <> 0) Then
                      Append(TOK_COM, 1);
                    If indent Then
                      _indent(0, True);
                    Append(TOK_DQT, 1);
                    If escape Then
                      doEscape(PSOChar(iter.key), Length(iter.key)) Else
                      DoMinimalEscape(PSOChar(iter.key), Length(iter.key));
                    If indent Then
                      Append(ENDSTR_A, 3) Else
                      Append(ENDSTR_B, 2);
                    If(iter.val = Nil) Then
                      Append(TOK_NULL, 4) Else
                      iter.val.write(writer, indent, escape, level);
                    inc(k);
                  End;
  {$IfDef SUPER_METHOD}
                End;
  {$EndIf}
              Until Not ObjectFindNext(iter);
            ObjectFindClose(iter);
            If indent Then
              _indent(-1, True);
            Result := Append(TOK_CBR, 1);
          End
          Else
            Result := Append(TOK_OBJ, 2);
        stBoolean:
        Begin
          If (FO.c_boolean) Then
            Result := Append(TOK_TRUE, 4) Else
            Result := Append(TOK_FALSE, 5);
        End;
        stInt:
        Begin
          str(FO.c_int, st);
          Result := Append(PSOChar(SOString(st)));
        End;
        stDouble:
          Result := Append(PSOChar(SOString(gcvt(FO.c_double, 15, fbuffer))));
        stCurrency:
        Begin
          Result := Append(PSOChar(CurrToStr(FO.c_currency)));
        End;
        stString:
        Begin
          Append(TOK_DQT, 1);
          If escape Then
            doEscape(PSOChar(FOString), Length(FOString)) Else
            DoMinimalEscape(PSOChar(FOString), Length(FOString));
          Append(TOK_DQT, 1);
          Result := 0;
        End;
        stArray:
          If FO.c_array.FLength > 0 Then
          Begin
            Append(TOK_ARL, 1);
            If indent Then
              _indent(1, True);
            k := 0;
            j := 0;
            While k < FO.c_array.FLength Do
            Begin

              val :=  FO.c_array.GetO(k);
  {$IfDef SUPER_METHOD}
              If Not ObjectIsType(val, stMethod) Then
              Begin
  {$EndIf}
                If (val = Nil) Or (Not val.Processing) Then
                Begin
                  If (j <> 0) Then
                    Append(TOK_COM, 1);
                  If(val = Nil) Then
                    Append(TOK_NULL, 4) Else
                    val.write(writer, indent, escape, level);
                  inc(j);
                End;
  {$IfDef SUPER_METHOD}
              End;
  {$EndIf}
              inc(k);
            End;
            If indent Then
              _indent(-1, False);
            Result := Append(TOK_ARR, 1);
          End
          Else
            Result := Append(TOK_ARRAY, 2);
        stNull:
          Result := Append(TOK_NULL, 4);
      Else
        Result := 0;
      End;
    Finally
      FProcessing := False;
    End;
End;

Function TSuperObject.IsType(AType: TSuperType): Boolean;
Begin
  Result := AType = FDataType;
End;

Function TSuperObject.AsBoolean: Boolean;
Begin
  Case FDataType Of
    stBoolean:
      Result := FO.c_boolean;
    stInt:
      Result := (FO.c_int <> 0);
    stDouble:
      Result := (FO.c_double <> 0);
    stCurrency:
      Result := (FO.c_currency <> 0);
    stString:
      Result := (Length(FOString) <> 0);
    stNull:
      Result := False;
  Else
    Result := True;
  End;
End;

Function TSuperObject.AsInteger: SuperInt;
Var
  code: Integer;
  cint: SuperInt;
Begin
  Case FDataType Of
    stInt:
      Result := FO.c_int;
    stDouble:
      Result := round(FO.c_double);
    stCurrency:
      Result := round(FO.c_currency);
    stBoolean:
      Result := ord(FO.c_boolean);
    stString:
    Begin
      Val(FOString, cint, code);
      If code = 0 Then
        Result := cint Else
        Result := 0;
    End;
  Else
    Result := 0;
  End;
End;

Function TSuperObject.AsDouble: Double;
Var
  code: Integer;
  cdouble: Double;
Begin
  Case FDataType Of
    stDouble:
      Result := FO.c_double;
    stCurrency:
      Result := FO.c_currency;
    stInt:
      Result := FO.c_int;
    stBoolean:
      Result := ord(FO.c_boolean);
    stString:
    Begin
      Val(FOString, cdouble, code);
      If code = 0 Then
        Result := cdouble Else
        Result := 0.0;
    End;
  Else
    Result := 0.0;
  End;
End;

Function TSuperObject.AsCurrency: Currency;
Var
  code: Integer;
  cdouble: Double;
Begin
  Case FDataType Of
    stDouble:
      Result := FO.c_double;
    stCurrency:
      Result := FO.c_currency;
    stInt:
      Result := FO.c_int;
    stBoolean:
      Result := ord(FO.c_boolean);
    stString:
    Begin
      Val(FOString, cdouble, code);
      If code = 0 Then
        Result := cdouble Else
        Result := 0.0;
    End;
  Else
    Result := 0.0;
  End;
End;

Function TSuperObject.AsString: SOString;
Begin
  If FDataType = stString Then
    Result := FOString Else
    Result := AsJSon(False, False);
End;

Function TSuperObject.GetEnumerator: TSuperEnumerator;
Begin
  Result := TSuperEnumerator.Create(Self);
End;

Procedure TSuperObject.AfterConstruction;
Begin
  InterlockedDecrement(FRefCount);
End;

Procedure TSuperObject.BeforeDestruction;
Begin
  If RefCount <> 0 Then
    Raise Exception.Create('Invalid pointer');
End;

Function TSuperObject.AsArray: TSuperArray;
Begin
  If FDataType = stArray Then
    Result := FO.c_array Else
    Result := Nil;
End;

Function TSuperObject.AsObject: TSuperTableString;
Begin
  If FDataType = stObject Then
    Result := FO.c_object Else
    Result := Nil;
End;

Function TSuperObject.AsJSon(indent, escape: Boolean): SOString;
Var
  pb: TSuperWriterString;
Begin
  pb := TSuperWriterString.Create;
  Try
    If(Write(pb, indent, escape, 0) < 0) Then
    Begin
      Result := '';
      Exit;
    End;
    If pb.FBPos > 0 Then
      Result := pb.FBuf Else
      Result := '';
  Finally
    pb.Free;
  End;
End;

Class Function TSuperObject.ParseString(s: PSOChar; strict: Boolean; partial: Boolean; Const this: ISuperObject;
  options: TSuperFindOptions; Const put: ISuperObject; dt: TSuperType): ISuperObject;
Var
  tok: TSuperTokenizer;
  obj: ISuperObject;
Begin
  tok := TSuperTokenizer.Create;
  obj := ParseEx(tok, s, -1, strict, this, options, put, dt);
  If(tok.err <> teSuccess) Or (Not partial And (s[tok.char_offset] <> #0)) Then
    Result := Nil Else
    Result := obj;
  tok.Free;
End;

Class Function TSuperObject.ParseStream(stream: TStream; strict: Boolean;
  partial: Boolean; Const this: ISuperObject; options: TSuperFindOptions;
  Const put: ISuperObject; dt: TSuperType): ISuperObject;
Const
  BUFFER_SIZE = 1024;
Var
  tok: TSuperTokenizer;
  buffera: Array[0..BUFFER_SIZE-1] Of AnsiChar;
  bufferw: Array[0..BUFFER_SIZE-1] Of SOChar;
  bom: Array[0..1] Of Byte;
  unicode: Boolean;
  j, size: Integer;
  st:  String;
Begin
  st := '';
  tok := TSuperTokenizer.Create;

  If (stream.Read(bom, sizeof(bom)) = 2) And (bom[0] = $FF) And (bom[1] = $FE) Then
  Begin
    unicode := True;
    size := stream.Read(bufferw, BUFFER_SIZE * SizeOf(SoChar)) Div SizeOf(SoChar);
  End
  Else
  Begin
    unicode := False;
    stream.Seek(0, soFromBeginning);
    size := stream.Read(buffera, BUFFER_SIZE);
  End;

  While size > 0 Do
  Begin
    If Not unicode Then
      For j := 0 To size - 1 Do
        bufferw[j] := SOChar(buffera[j]);
    ParseEx(tok, bufferw, size, strict, this, options, put, dt);

    If tok.err = teContinue Then
    Begin
      If Not unicode Then
        size := stream.Read(buffera, BUFFER_SIZE)
      Else
        size := stream.Read(bufferw, BUFFER_SIZE * SizeOf(SoChar)) Div SizeOf(SoChar);
    End
    Else
      Break;
  End;

  If(tok.err <> teSuccess) Or (Not partial And (st[tok.char_offset] <> #0)) Then
    Result := Nil
  Else
    Result := tok.stack[tok.depth].current;
    
  tok.Free;
End;

Class Function TSuperObject.ParseFile(Const FileName: String; strict: Boolean;
  partial: Boolean; Const this: ISuperObject; options: TSuperFindOptions;
  Const put: ISuperObject; dt: TSuperType): ISuperObject;
Var
  stream: TFileStream;
Begin
  stream := TFileStream.Create(FileName, fmOpenRead, fmShareDenyWrite);
  Try
    Result := ParseStream(stream, strict, partial, this, options, put, dt);
  Finally
    stream.Free;
  End;
End;

Class Function TSuperObject.ParseEx(tok: TSuperTokenizer; str: PSOChar; len: Integer;
  strict: Boolean; Const this: ISuperObject; options: TSuperFindOptions; Const put: ISuperObject; dt: TSuperType): ISuperObject;

Const
  spaces = [#32,#8,#9,#10,#12,#13];
  delimiters = ['"', '.', '[', ']', '{', '}', '(', ')', ',', ':', #0];
  reserved = delimiters + spaces;
  path = ['a'..'z', 'A'..'Z', '.', '_'];

  Function hexdigit(x: SOChar): Byte;
  Begin
    If x <= '9' Then
      Result := Byte(x) - Byte('0')
    Else
      Result := (Byte(x) And 7) + 9;
  End;

  Function min(v1, v2: Integer): Integer;
  Begin
    If v1 < v2 Then
      result := v1
    Else
      result := v2
  End;

Var
  obj: ISuperObject;
  v: SOChar;
{$IfDef SUPER_METHOD}
  sm: TSuperMethod;
{$EndIf}
  numi: SuperInt;
  numd: Double;
  code: Integer;
  TokRec: PSuperTokenerSrec;
  evalstack: Integer;
  p: PSOChar;

  Function IsEndDelimiter(v: AnsiChar): Boolean;
  Begin
    If tok.depth > 0 Then
      Case tok.stack[tok.depth - 1].state Of
        tsArrayAdd:
          Result := v In [',', ']', #0];
        tsObjectValueAdd:
          Result := v In [',', '}', #0];
      Else
        Result := v = #0;
      End
    Else
      Result := v = #0;
  End;

Label out, redo_char;
Begin
  evalstack := 0;
  obj := Nil;
  Result := Nil;
  TokRec := @tok.stack[tok.depth];

  tok.char_offset := 0;
  tok.err := teSuccess;

  Repeat
    If (tok.char_offset = len) Then
    Begin
      If (tok.depth = 0) And (TokRec^.state = tsEatws) And
         (TokRec^.saved_state = tsFinish) Then
        tok.err := teSuccess
      Else
        tok.err := teContinue;

      Goto out;
    End;

    v := str^;

    Case v Of
      #10:
      Begin
        inc(tok.line);
        tok.col := 0;
      End;
      #9:
        inc(tok.col, 4);
    Else
      inc(tok.col);
    End;

    redo_char:
      Case TokRec^.state Of
        tsEatws:
        Begin
          If (SOIChar(v) < 256) And (AnsiChar(v) In spaces) Then
{nop}     Else
          If (v = '/') Then
          Begin
            tok.pb.Reset;
            tok.pb.Append(@v, 1);
            TokRec^.state := tsCommentStart;
          End
          Else
          Begin
            TokRec^.state := TokRec^.saved_state;
            Goto redo_char;
          End
        End;

        tsStart:
          Case v Of
            '"',
            '''':
            Begin
              TokRec^.state := tsString;
              tok.pb.Reset;
              tok.quote_char := v;
            End;
            '-':
            Begin
              TokRec^.state := tsNumber;
              tok.pb.Reset;
              tok.is_double := 0;
              tok.floatcount := -1;
              Goto redo_char;
            End;

            '0'..'9':
            Begin
              If (tok.depth = 0) Then
                Case ObjectGetType(this) Of
                  stObject:
                  Begin
                    TokRec^.state := tsIdentifier;
                    TokRec^.current := this;
                    Goto redo_char;
                  End;
                End;
              TokRec^.state := tsNumber;
              tok.pb.Reset;
              tok.is_double := 0;
              tok.floatcount := -1;
              Goto redo_char;
            End;
            '{':
            Begin
              TokRec^.state := tsEatws;
              TokRec^.saved_state := tsObjectFieldStart;
              TokRec^.current := TSuperObject.Create(stObject);
            End;
            '[':
            Begin
              TokRec^.state := tsEatws;
              TokRec^.saved_state := tsArray;
              TokRec^.current := TSuperObject.Create(stArray);
            End;
{$IfDef SUPER_METHOD}
            '(':
            Begin
              If (tok.depth = 0) And ObjectIsType(this, stMethod) Then
              Begin
                TokRec^.current := this;
                TokRec^.state := tsParamValue;
              End;
            End;
{$EndIf}
            'N',
            'n':
            Begin
              TokRec^.state := tsNull;
              tok.pb.Reset;
              tok.st_pos := 0;
              Goto redo_char;
            End;
            'T',
            't',
            'F',
            'f':
            Begin
              TokRec^.state := tsBoolean;
              tok.pb.Reset;
              tok.st_pos := 0;
              Goto redo_char;
            End;
          Else
            TokRec^.state := tsIdentifier;
            tok.pb.Reset;
            Goto redo_char;
          End;

        tsFinish:
        Begin
          If(tok.depth = 0) Then
            Goto out;
          obj := TokRec^.current;
          tok.ResetLevel(tok.depth);
          dec(tok.depth);
          TokRec := @tok.stack[tok.depth];
          Goto redo_char;
        End;

        tsNull:
        Begin
          tok.pb.Append(@v, 1);
          If (StrLComp(TOK_NULL, PSOChar(tok.pb.FBuf), min(tok.st_pos + 1, 4)) = 0) Then
          Begin
            If (tok.st_pos = 4) Then
              If (((SOIChar(v) < 256) And (AnsiChar(v) In path)) Or (SOIChar(v) >= 256)) Then
                TokRec^.state := tsIdentifier Else
              Begin
                TokRec^.current := TSuperObject.Create(stNull);
                TokRec^.saved_state := tsFinish;
                TokRec^.state := tsEatws;
                Goto redo_char;
              End;
          End
          Else
          Begin
            TokRec^.state := tsIdentifier;
            tok.pb.FBuf[tok.st_pos] := #0;
            dec(tok.pb.FBPos);
            Goto redo_char;
          End;
          inc(tok.st_pos);
        End;

        tsCommentStart:
        Begin
          If(v = '*') Then
          Begin
            TokRec^.state := tsComment;
          End
          Else
          If (v = '/') Then
          Begin
            TokRec^.state := tsCommentEol;
          End
          Else
          Begin
            tok.err := teParseComment;
            Goto out;
          End;
          tok.pb.Append(@v, 1);
        End;

        tsComment:
        Begin
          If(v = '*') Then
            TokRec^.state := tsCommentEnd;
          tok.pb.Append(@v, 1);
        End;

        tsCommentEol:
        Begin
          If (v = #10) Then
            TokRec^.state := tsEatws Else
            tok.pb.Append(@v, 1);
        End;

        tsCommentEnd:
        Begin
          tok.pb.Append(@v, 1);
          If (v = '/') Then
            TokRec^.state := tsEatws Else
            TokRec^.state := tsComment;
        End;

        tsString:
        Begin
          If (v = tok.quote_char) Then
          Begin
            TokRec^.current := TSuperObject.Create(SOString(tok.pb.GetString));
            TokRec^.saved_state := tsFinish;
            TokRec^.state := tsEatws;
          End
          Else
          If (v = '\') Then
          Begin
            TokRec^.saved_state := tsString;
            TokRec^.state := tsStringEscape;
          End
          Else
          Begin
            tok.pb.Append(@v, 1);
          End
        End;

        tsEvalProperty:
        Begin
          If (TokRec^.current = Nil) And (foCreatePath In options) Then
          Begin
            TokRec^.current := TSuperObject.Create(stObject);
            TokRec^.parent.AsObject.PutO(tok.pb.Fbuf, TokRec^.current)
          End
          Else
          If Not ObjectIsType(TokRec^.current, stObject) Then
          Begin
            tok.err := teEvalObject;
            Goto out;
          End;
          tok.pb.Reset;
          TokRec^.state := tsIdentifier;
          Goto redo_char;
        End;

        tsEvalArray:
        Begin
          If (TokRec^.current = Nil) And (foCreatePath In options) Then
          Begin
            TokRec^.current := TSuperObject.Create(stArray);
            TokRec^.parent.AsObject.PutO(tok.pb.Fbuf, TokRec^.current)
          End
          Else
          If Not ObjectIsType(TokRec^.current, stArray) Then
          Begin
            tok.err := teEvalArray;
            Goto out;
          End;
          tok.pb.Reset;
          TokRec^.state := tsParamValue;
          Goto redo_char;
        End;
{$IfDef SUPER_METHOD}
        tsEvalMethod:
        Begin
          If ObjectIsType(TokRec^.current, stMethod) And assigned(TokRec^.current.AsMethod) Then
          Begin
            tok.pb.Reset;
            TokRec^.obj := TSuperObject.Create(stArray);
            TokRec^.state := tsMethodValue;
            Goto redo_char;
          End
          Else
          Begin
            tok.err := teEvalMethod;
            Goto out;
          End;
        End;

        tsMethodValue:
        Begin
          Case v Of
            ')':
              TokRec^.state := tsIdentifier;
          Else
            If (tok.depth >= SUPER_TOKENER_MAX_DEPTH-1) Then
            Begin
              tok.err := teDepth;
              Goto out;
            End;
            inc(evalstack);
            TokRec^.state := tsMethodPut;
            inc(tok.depth);
            tok.ResetLevel(tok.depth);
            TokRec := @tok.stack[tok.depth];
            Goto redo_char;
          End;
        End;

        tsMethodPut:
        Begin
          TokRec^.obj.AsArray.Add(obj);
          Case v Of
            ',':
            Begin
              tok.pb.Reset;
              TokRec^.saved_state := tsMethodValue;
              TokRec^.state := tsEatws;
            End;
            ')':
            Begin
              If TokRec^.obj.AsArray.Length = 1 Then
                TokRec^.obj := TokRec^.obj.AsArray.GetO(0);
              dec(evalstack);
              tok.pb.Reset;
              TokRec^.saved_state := tsIdentifier;
              TokRec^.state := tsEatws;
            End;
          Else
            tok.err := teEvalMethod;
            Goto out;
          End;
        End;
{$EndIf}
        tsParamValue:
        Begin
          Case v Of
            ']':
              TokRec^.state := tsIdentifier;
          Else
            If (tok.depth >= SUPER_TOKENER_MAX_DEPTH-1) Then
            Begin
              tok.err := teDepth;
              Goto out;
            End;
            inc(evalstack);
            TokRec^.state := tsParamPut;
            inc(tok.depth);
            tok.ResetLevel(tok.depth);
            TokRec := @tok.stack[tok.depth];
            Goto redo_char;
          End;
        End;

        tsParamPut:
        Begin
          dec(evalstack);
          TokRec^.obj := obj;
          tok.pb.Reset;
          TokRec^.saved_state := tsIdentifier;
          TokRec^.state := tsEatws;
          If v <> ']' Then
          Begin
            tok.err := teEvalArray;
            Goto out;
          End;
        End;

        tsIdentifier:
        Begin
          If (this = Nil) Then
          Begin
            If (SOIChar(v) < 256) And IsEndDelimiter(AnsiChar(v)) Then
            Begin
              If Not strict Then
              Begin
                tok.pb.TrimRight;
                TokRec^.current := TSuperObject.Create(tok.pb.Fbuf);
                TokRec^.saved_state := tsFinish;
                TokRec^.state := tsEatws;
                Goto redo_char;
              End
              Else
              Begin
                tok.err := teParseString;
                Goto out;
              End;
            End
            Else
            If (v = '\') Then
            Begin
              TokRec^.saved_state := tsIdentifier;
              TokRec^.state := tsStringEscape;
            End
            Else
              tok.pb.Append(@v, 1);
          End
          Else
          Begin
            If (SOIChar(v) < 256) And (AnsiChar(v) In reserved) Then
            Begin
              TokRec^.gparent := TokRec^.parent;
              If TokRec^.current = Nil Then
                TokRec^.parent := this Else
                TokRec^.parent := TokRec^.current;

              Case ObjectGetType(TokRec^.parent) Of
                stObject:
                  Case v Of
                    '.':
                    Begin
                      TokRec^.state := tsEvalProperty;
                      If tok.pb.FBPos > 0 Then
                        TokRec^.current := TokRec^.parent.AsObject.GetO(tok.pb.Fbuf);
                    End;
                    '[':
                    Begin
                      TokRec^.state := tsEvalArray;
                      If tok.pb.FBPos > 0 Then
                        TokRec^.current := TokRec^.parent.AsObject.GetO(tok.pb.Fbuf);
                    End;
                    '(':
                    Begin
                      TokRec^.state := tsEvalMethod;
                      If tok.pb.FBPos > 0 Then
                        TokRec^.current := TokRec^.parent.AsObject.GetO(tok.pb.Fbuf);
                    End;
                  Else
                    If tok.pb.FBPos > 0 Then
                      TokRec^.current := TokRec^.parent.AsObject.GetO(tok.pb.Fbuf);
                    If (foPutValue In options) And (evalstack = 0) Then
                    Begin
                      TokRec^.parent.AsObject.PutO(tok.pb.Fbuf, put);
                      TokRec^.current := put;
                    End
                    Else
                    If (foDelete In options) And (evalstack = 0) Then
                    Begin
                      TokRec^.current := TokRec^.parent.AsObject.Delete(tok.pb.Fbuf);
                    End
                    Else
                    If (TokRec^.current = Nil) And (foCreatePath In options) Then
                    Begin
                      TokRec^.current := TSuperObject.Create(dt);
                      TokRec^.parent.AsObject.PutO(tok.pb.Fbuf, TokRec^.current);
                    End;
                    TokRec^.current := TokRec^.parent.AsObject.GetO(tok.pb.Fbuf);
                    TokRec^.state := tsFinish;
                    Goto redo_char;
                  End;
                stArray:
                Begin
                  If TokRec^.obj <> Nil Then
                  Begin
                    If Not ObjectIsType(TokRec^.obj, stInt) Or (TokRec^.obj.AsInteger < 0) Then
                    Begin
                      tok.err := teEvalInt;
                      TokRec^.obj := Nil;
                      Goto out;
                    End;
                    numi := TokRec^.obj.AsInteger;
                    TokRec^.obj := Nil;

                    TokRec^.current := TokRec^.parent.AsArray.GetO(numi);
                    Case v Of
                      '.':
                        If (TokRec^.current = Nil) And (foCreatePath In options) Then
                        Begin
                          TokRec^.current := TSuperObject.Create(stObject);
                          TokRec^.parent.AsArray.PutO(numi, TokRec^.current);
                        End
                        Else
                        If (TokRec^.current = Nil) Then
                        Begin
                          tok.err := teEvalObject;
                          Goto out;
                        End;
                      '[':
                      Begin
                        If (TokRec^.current = Nil) And (foCreatePath In options) Then
                        Begin
                          TokRec^.current := TSuperObject.Create(stArray);
                          TokRec^.parent.AsArray.Add(TokRec^.current);
                        End
                        Else
                        If (TokRec^.current = Nil) Then
                        Begin
                          tok.err := teEvalArray;
                          Goto out;
                        End;
                        TokRec^.state := tsEvalArray;
                      End;
                      '(':
                        TokRec^.state := tsEvalMethod;
                    Else
                      If (foPutValue In options) And (evalstack = 0) Then
                      Begin
                        TokRec^.parent.AsArray.PutO(numi, put);
                        TokRec^.current := put;
                      End
                      Else
                      If (foDelete In options) And (evalstack = 0) Then
                      Begin
                        TokRec^.current := TokRec^.parent.AsArray.Delete(numi);
                      End
                      Else
                        TokRec^.current := TokRec^.parent.AsArray.GetO(numi);
                      TokRec^.state := tsFinish;
                      Goto redo_char
                    End;
                  End
                  Else
                  Begin
                    Case v Of
                      '.':
                      Begin
                        If (foPutValue In options) Then
                        Begin
                          TokRec^.current := TSuperObject.Create(stObject);
                          TokRec^.parent.AsArray.Add(TokRec^.current);
                        End
                        Else
                          TokRec^.current := TokRec^.parent.AsArray.GetO(TokRec^.parent.AsArray.FLength - 1);
                      End;
                      '[':
                      Begin
                        If (foPutValue In options) Then
                        Begin
                          TokRec^.current := TSuperObject.Create(stArray);
                          TokRec^.parent.AsArray.Add(TokRec^.current);
                        End
                        Else
                          TokRec^.current := TokRec^.parent.AsArray.GetO(TokRec^.parent.AsArray.FLength - 1);
                        TokRec^.state := tsEvalArray;
                      End;
                      '(':
                      Begin
                        If Not (foPutValue In options) Then
                          TokRec^.current := TokRec^.parent.AsArray.GetO(TokRec^.parent.AsArray.FLength - 1) Else
                          TokRec^.current := Nil;

                        TokRec^.state := tsEvalMethod;
                      End;
                    Else
                      If (foPutValue In options) And (evalstack = 0) Then
                      Begin
                        TokRec^.parent.AsArray.Add(put);
                        TokRec^.current := put;
                      End
                      Else
                      If tok.pb.FBPos = 0 Then
                        TokRec^.current := TokRec^.parent.AsArray.GetO(TokRec^.parent.AsArray.FLength - 1);
                      TokRec^.state := tsFinish;
                      Goto redo_char
                    End;
                  End;
                End;
{$IfDef SUPER_METHOD}
                stMethod:
                  Case v Of
                    '.':
                    Begin
                      TokRec^.current := Nil;
                      sm := TokRec^.parent.AsMethod;
                      sm(TokRec^.gparent, TokRec^.obj, TokRec^.current);
                      TokRec^.obj := Nil;
                    End;
                    '[':
                    Begin
                      TokRec^.current := Nil;
                      sm := TokRec^.parent.AsMethod;
                      sm(TokRec^.gparent, TokRec^.obj, TokRec^.current);
                      TokRec^.state := tsEvalArray;
                      TokRec^.obj := Nil;
                    End;
                    '(':
                    Begin
                      TokRec^.current := Nil;
                      sm := TokRec^.parent.AsMethod;
                      sm(TokRec^.gparent, TokRec^.obj, TokRec^.current);
                      TokRec^.state := tsEvalMethod;
                      TokRec^.obj := Nil;
                    End;
                  Else
                    If Not (foPutValue In options) Or (evalstack > 0) Then
                    Begin
                      TokRec^.current := Nil;
                      sm := TokRec^.parent.AsMethod;
                      sm(TokRec^.gparent, TokRec^.obj, TokRec^.current);
                      TokRec^.obj := Nil;
                      TokRec^.state := tsFinish;
                      Goto redo_char
                    End
                    Else
                    Begin
                      tok.err := teEvalMethod;
                      TokRec^.obj := Nil;
                      Goto out;
                    End;
                  End;
{$EndIf}
              End;
            End
            Else
              tok.pb.Append(@v, 1);
          End;
        End;

        tsStringEscape:
          Case v Of
            'b',
            'n',
            'r',
            't',
            'f':
            Begin
              If(v = 'b') Then
                tok.pb.Append(TOK_BS, 1)
              Else
              If(v = 'n') Then
                tok.pb.Append(TOK_LF, 1)
              Else
              If(v = 'r') Then
                tok.pb.Append(TOK_CR, 1)
              Else
              If(v = 't') Then
                tok.pb.Append(TOK_TAB, 1)
              Else
              If(v = 'f') Then
                tok.pb.Append(TOK_FF, 1);
              TokRec^.state := TokRec^.saved_state;
            End;
            'u':
            Begin
              tok.ucs_char := 0;
              tok.st_pos := 0;
              TokRec^.state := tsEscapeUnicode;
            End;
            'x':
            Begin
              tok.ucs_char := 0;
              tok.st_pos := 0;
              TokRec^.state := tsEscapeHexadecimal;
            End
          Else
            tok.pb.Append(@v, 1);
            TokRec^.state := TokRec^.saved_state;
          End;

        tsEscapeUnicode:
        Begin
          If ((SOIChar(v) < 256) And (AnsiChar(v) In super_hex_chars_set)) Then
          Begin
            inc(tok.ucs_char, (Word(hexdigit(v)) Shl ((3-tok.st_pos)*4)));
            inc(tok.st_pos);
            If (tok.st_pos = 4) Then
            Begin
              tok.pb.Append(@tok.ucs_char, 1);
              TokRec^.state := TokRec^.saved_state;
            End
          End
          Else
          Begin
            tok.err := teParseString;
            Goto out;
          End
        End;
        tsEscapeHexadecimal:
        Begin
          If ((SOIChar(v) < 256) And (AnsiChar(v) In super_hex_chars_set)) Then
          Begin
            inc(tok.ucs_char, (Word(hexdigit(v)) Shl ((1-tok.st_pos)*4)));
            inc(tok.st_pos);
            If (tok.st_pos = 2) Then
            Begin
              tok.pb.Append(@tok.ucs_char, 1);
              TokRec^.state := TokRec^.saved_state;
            End
          End
          Else
          Begin
            tok.err := teParseString;
            Goto out;
          End
        End;
        tsBoolean:
        Begin
          tok.pb.Append(@v, 1);
          If (StrLComp('true', PSOChar(tok.pb.FBuf), min(tok.st_pos + 1, 4)) = 0) Then
          Begin
            If (tok.st_pos = 4) Then
              If (((SOIChar(v) < 256) And (AnsiChar(v) In path)) Or (SOIChar(v) >= 256)) Then
                TokRec^.state := tsIdentifier Else
              Begin
                TokRec^.current := TSuperObject.Create(True);
                TokRec^.saved_state := tsFinish;
                TokRec^.state := tsEatws;
                Goto redo_char;
              End
          End
          Else
          If (StrLComp('false', PSOChar(tok.pb.FBuf), min(tok.st_pos + 1, 5)) = 0) Then
          Begin
            If (tok.st_pos = 5) Then
              If (((SOIChar(v) < 256) And (AnsiChar(v) In path)) Or (SOIChar(v) >= 256)) Then
                TokRec^.state := tsIdentifier Else
              Begin
                TokRec^.current := TSuperObject.Create(False);
                TokRec^.saved_state := tsFinish;
                TokRec^.state := tsEatws;
                Goto redo_char;
              End
          End
          Else
          Begin
            TokRec^.state := tsIdentifier;
            tok.pb.FBuf[tok.st_pos] := #0;
            dec(tok.pb.FBPos);
            Goto redo_char;
          End;
          inc(tok.st_pos);
        End;

        tsNumber:
        Begin
          If (SOIChar(v) < 256) And (AnsiChar(v) In super_number_chars_set) Then
          Begin
            tok.pb.Append(@v, 1);
            If (SOIChar(v) < 256) Then
              Case v Of
                '.':
                Begin
                  tok.is_double := 1;
                  tok.floatcount := 0;
                End;
                'e','E':
                Begin
                  tok.is_double := 1;
                  tok.floatcount := -1;
                End;
                '0'..'9':
                Begin

                  If (tok.is_double = 1) And (tok.floatcount >= 0) Then
                  Begin
                    inc(tok.floatcount);
                    If tok.floatcount > 4 Then
                      tok.floatcount := -1;
                  End;
                End;
              End;
          End
          Else
          Begin
            If (tok.is_double = 0) Then
            Begin
              val(tok.pb.FBuf, numi, code);
              If ObjectIsType(this, stArray) Then
              Begin
                If (foPutValue In options) And (evalstack = 0) Then
                Begin
                  this.AsArray.PutO(numi, put);
                  TokRec^.current := put;
                End
                Else
                If (foDelete In options) And (evalstack = 0) Then
                  TokRec^.current := this.AsArray.Delete(numi) Else
                  TokRec^.current := this.AsArray.GetO(numi);
              End
              Else
                TokRec^.current := TSuperObject.Create(numi);

            End
            Else
            If (tok.is_double <> 0) Then
            Begin
              If tok.floatcount >= 0 Then
              Begin
                p := tok.pb.FBuf;
                While p^ <> '.' Do
                  inc(p);
                For code := 0 To tok.floatcount - 1 Do
                Begin
                  p^ := p[1];
                  inc(p);
                End;
                p^ := #0;
                val(tok.pb.FBuf, numi, code);
                Case tok.floatcount Of
                  0:
                    numi := numi * 10000;
                  1:
                    numi := numi * 1000;
                  2:
                    numi := numi * 100;
                  3:
                    numi := numi * 10;
                End;
                TokRec^.current := TSuperObject.CreateCurrency(PCurrency(@numi)^);
              End
              Else
              Begin
                val(tok.pb.FBuf, numd, code);
                TokRec^.current := TSuperObject.Create(numd);
              End;
            End
            Else
            Begin
              tok.err := teParseNumber;
              Goto out;
            End;
            TokRec^.saved_state := tsFinish;
            TokRec^.state := tsEatws;
            Goto redo_char;
          End
        End;

        tsArray:
        Begin
          If (v = ']') Then
          Begin
            TokRec^.saved_state := tsFinish;
            TokRec^.state := tsEatws;
          End
          Else
          Begin
            If(tok.depth >= SUPER_TOKENER_MAX_DEPTH-1) Then
            Begin
              tok.err := teDepth;
              Goto out;
            End;
            TokRec^.state := tsArrayAdd;
            inc(tok.depth);
            tok.ResetLevel(tok.depth);
            TokRec := @tok.stack[tok.depth];
            Goto redo_char;
          End
        End;

        tsArrayAdd:
        Begin
          TokRec^.current.AsArray.Add(obj);
          TokRec^.saved_state := tsArraySep;
          TokRec^.state := tsEatws;
          Goto redo_char;
        End;

        tsArraySep:
        Begin
          If (v = ']') Then
          Begin
            TokRec^.saved_state := tsFinish;
            TokRec^.state := tsEatws;
          End
          Else
          If (v = ',') Then
          Begin
            TokRec^.saved_state := tsArray;
            TokRec^.state := tsEatws;
          End
          Else
          Begin
            tok.err := teParseArray;
            Goto out;
          End
        End;

        tsObjectFieldStart:
        Begin
          If (v = '}') Then
          Begin
            TokRec^.saved_state := tsFinish;
            TokRec^.state := tsEatws;
          End
          Else
          If (SOIChar(v) < 256) And (AnsiChar(v) In ['"', '''']) Then
          Begin
            tok.quote_char := v;
            tok.pb.Reset;
            TokRec^.state := tsObjectField;
          End
          Else
          If Not((SOIChar(v) < 256) And ((AnsiChar(v) In reserved) Or strict)) Then
          Begin
            TokRec^.state := tsObjectUnquotedField;
            tok.pb.Reset;
            Goto redo_char;
          End
          Else
          Begin
            tok.err := teParseObjectKeyName;
            Goto out;
          End
        End;

        tsObjectField:
        Begin
          If (v = tok.quote_char) Then
          Begin
            TokRec^.field_name := tok.pb.FBuf;
            TokRec^.saved_state := tsObjectFieldEnd;
            TokRec^.state := tsEatws;
          End
          Else
          If (v = '\') Then
          Begin
            TokRec^.saved_state := tsObjectField;
            TokRec^.state := tsStringEscape;
          End
          Else
          Begin
            tok.pb.Append(@v, 1);
          End
        End;

        tsObjectUnquotedField:
        Begin
          If (SOIChar(v) < 256) And (AnsiChar(v) In [':', #0]) Then
          Begin
            TokRec^.field_name := tok.pb.FBuf;
            TokRec^.saved_state := tsObjectFieldEnd;
            TokRec^.state := tsEatws;
            Goto redo_char;
          End
          Else
          If (v = '\') Then
          Begin
            TokRec^.saved_state := tsObjectUnquotedField;
            TokRec^.state := tsStringEscape;
          End
          Else
            tok.pb.Append(@v, 1);
        End;

        tsObjectFieldEnd:
        Begin
          If (v = ':') Then
          Begin
            TokRec^.saved_state := tsObjectValue;
            TokRec^.state := tsEatws;
          End
          Else
          Begin
            tok.err := teParseObjectKeySep;
            Goto out;
          End
        End;

        tsObjectValue:
        Begin
          If (tok.depth >= SUPER_TOKENER_MAX_DEPTH-1) Then
          Begin
            tok.err := teDepth;
            Goto out;
          End;
          TokRec^.state := tsObjectValueAdd;
          inc(tok.depth);
          tok.ResetLevel(tok.depth);
          TokRec := @tok.stack[tok.depth];
          Goto redo_char;
        End;

        tsObjectValueAdd:
        Begin
          TokRec^.current.AsObject.PutO(TokRec^.field_name, obj);
          TokRec^.field_name := '';
          TokRec^.saved_state := tsObjectSep;
          TokRec^.state := tsEatws;
          Goto redo_char;
        End;

        tsObjectSep:
        Begin
          If (v = '}') Then
          Begin
            TokRec^.saved_state := tsFinish;
            TokRec^.state := tsEatws;
          End
          Else
          If (v = ',') Then
          Begin
            TokRec^.saved_state := tsObjectFieldStart;
            TokRec^.state := tsEatws;
          End
          Else
          Begin
            tok.err := teParseObjectValueSep;
            Goto out;
          End
        End;
      End;
    inc(str);
    inc(tok.char_offset);
  Until v = #0;

  If(TokRec^.state <> tsFinish) And
    (TokRec^.saved_state <> tsFinish) Then
    tok.err := teParseEof;

  out:
    If(tok.err In [teSuccess]) Then
    Begin
{$IfDef SUPER_METHOD}
      If (foCallMethod In options) And ObjectIsType(TokRec^.current, stMethod) And assigned(TokRec^.current.AsMethod) Then
      Begin
        sm := TokRec^.current.AsMethod;
        sm(TokRec^.parent, put, Result);
      End
      Else
{$EndIf}
        Result := TokRec^.current;
    End
    Else
      Result := Nil;
End;

Procedure TSuperObject.PutO(Const path: SOString; Const Value: ISuperObject);
Begin
  ParseString(PSOChar(path), True, False, self, [foCreatePath, foPutValue], Value);
End;

Procedure TSuperObject.PutB(Const path: SOString; Value: Boolean);
Begin
  ParseString(PSOChar(path), True, False, self, [foCreatePath, foPutValue], TSuperObject.Create(Value));
End;

Procedure TSuperObject.PutD(Const path: SOString; Value: Double);
Begin
  ParseString(PSOChar(path), True, False, self, [foCreatePath, foPutValue], TSuperObject.Create(Value));
End;

Procedure TSuperObject.PutC(Const path: SOString; Value: Currency);
Begin
  ParseString(PSOChar(path), True, False, self, [foCreatePath, foPutValue], TSuperObject.CreateCurrency(Value));
End;

Procedure TSuperObject.PutI(Const path: SOString; Value: SuperInt);
Begin
  ParseString(PSOChar(path), True, False, self, [foCreatePath, foPutValue], TSuperObject.Create(Value));
End;

Procedure TSuperObject.PutS(Const path: SOString; Const Value: SOString);
Begin
  ParseString(PSOChar(path), True, False, self, [foCreatePath, foPutValue], TSuperObject.Create(Value));
End;

Function TSuperObject.QueryInterface(Const IID: TGUID; out Obj): HResult; Stdcall;
Begin
  If GetInterface(IID, Obj) Then
    Result := 0
  Else
    Result := E_NOINTERFACE;
End;

Function TSuperObject.SaveTo(stream: TStream; indent, escape: Boolean): Integer;
Var
  pb: TSuperWriterStream;
Begin
  If escape Then
    pb := TSuperAnsiWriterStream.Create(stream) Else
    pb := TSuperUnicodeWriterStream.Create(stream);

  If(Write(pb, indent, escape, 0) < 0) Then
  Begin
    pb.Reset;
    pb.Free;
    Result := 0;
    Exit;
  End;
  Result := stream.Size;
  pb.Free;
End;

Function TSuperObject.CalcSize(indent, escape: Boolean): Integer;
Var
  pb: TSuperWriterFake;
Begin
  pb := TSuperWriterFake.Create;
  If(Write(pb, indent, escape, 0) < 0) Then
  Begin
    pb.Free;
    Result := 0;
    Exit;
  End;
  Result := pb.FSize;
  pb.Free;
End;

Function TSuperObject.SaveTo(socket: Integer; indent, escape: Boolean): Integer;
Var
  pb: TSuperWriterSock;
Begin
  pb := TSuperWriterSock.Create(socket);
  If(Write(pb, indent, escape, 0) < 0) Then
  Begin
    pb.Free;
    Result := 0;
    Exit;
  End;
  Result := pb.FSize;
  pb.Free;
End;

Constructor TSuperObject.Create(Const s: SOString);
Begin
  Create(stString);
  FOString := s;
End;

Procedure TSuperObject.Clear(all: Boolean);
Begin
  If FProcessing Then
    exit;
  FProcessing := True;
  Try
    Case FDataType Of
      stBoolean:
        FO.c_boolean := False;
      stDouble:
        FO.c_double := 0.0;
      stCurrency:
        FO.c_currency := 0.0;
      stInt:
        FO.c_int := 0;
      stObject:
        FO.c_object.Clear(all);
      stArray:
        FO.c_array.Clear(all);
      stString:
        FOString := '';
{$IfDef SUPER_METHOD}
      stMethod:
        FO.c_method := Nil;
{$EndIf}
    End;
  Finally
    FProcessing := False;
  End;
End;

Procedure TSuperObject.Pack(all: Boolean = False);
Begin
  If FProcessing Then
    exit;
  FProcessing := True;
  Try
    Case FDataType Of
      stObject:
        FO.c_object.Pack(all);
      stArray:
        FO.c_array.Pack(all);
    End;
  Finally
    FProcessing := False;
  End;
End;

Function TSuperObject.GetN(Const path: SOString): ISuperObject;
Begin
  Result := ParseString(PSOChar(path), False, True, self);
  If Result = Nil Then
    Result := TSuperObject.Create(stNull);
End;

Procedure TSuperObject.PutN(Const path: SOString; Const Value: ISuperObject);
Begin
  If Value = Nil Then
    ParseString(PSOChar(path), False, True, self, [foCreatePath, foPutValue], TSuperObject.Create(stNull))
  Else
    ParseString(PSOChar(path), False, True, self, [foCreatePath, foPutValue], Value);
End;

Function TSuperObject.Delete(Const path: SOString): ISuperObject;
Begin
  Result := ParseString(PSOChar(path), False, True, self, [foDelete]);
End;

Function TSuperObject.Clone: ISuperObject;
Var
  ite: TSuperObjectIter;
  arr: TSuperArray;
  j: Integer;
Begin
  Case FDataType Of
    stBoolean:
      Result := TSuperObject.Create(FO.c_boolean);
    stDouble:
      Result := TSuperObject.Create(FO.c_double);
    stCurrency:
      Result := TSuperObject.CreateCurrency(FO.c_currency);
    stInt:
      Result := TSuperObject.Create(FO.c_int);
    stString:
      Result := TSuperObject.Create(FOString);
{$IfDef SUPER_METHOD}
    stMethod:
      Result := TSuperObject.Create(FO.c_method);
{$EndIf}
    stObject:
    Begin
      Result := TSuperObject.Create(stObject);
      If ObjectFindFirst(self, ite) Then
        With Result.AsObject Do
          Repeat
            PutO(ite.key, ite.val.Clone);
          Until Not ObjectFindNext(ite);
      ObjectFindClose(ite);
    End;
    stArray:
    Begin
      Result := TSuperObject.Create(stArray);
      arr := AsArray;
      With Result.AsArray Do
        For j := 0 To arr.Length - 1 Do
          Add(arr.GetO(j).Clone);
    End;
  Else
    Result := Nil;
  End;
End;

Procedure TSuperObject.Merge(Const obj: ISuperObject; reference: Boolean);
Var
  prop1, prop2: ISuperObject;
  ite: TSuperObjectIter;
  arr: TSuperArray;
  j: Integer;
Begin
  If ObjectIsType(obj, FDataType) Then
    Case FDataType Of
      stBoolean:
        FO.c_boolean := obj.AsBoolean;
      stDouble:
        FO.c_double := obj.AsDouble;
      stCurrency:
        FO.c_currency := obj.AsCurrency;
      stInt:
        FO.c_int := obj.AsInteger;
      stString:
        FOString := obj.AsString;
{$IfDef SUPER_METHOD}
      stMethod:
        FO.c_method := obj.AsMethod;
{$EndIf}
      stObject:
      Begin
        If ObjectFindFirst(obj, ite) Then
          With FO.c_object Do
            Repeat
              prop1 := FO.c_object.GetO(ite.key);
              If (prop1 <> Nil) And (ite.val <> Nil) And (prop1.DataType = ite.val.DataType) Then
                prop1.Merge(ite.val) Else
              If reference Then
                PutO(ite.key, ite.val) Else
                PutO(ite.key, ite.val.Clone);
            Until Not ObjectFindNext(ite);
        ObjectFindClose(ite);
      End;
      stArray:
      Begin
        arr := obj.AsArray;
        With FO.c_array Do
          For j := 0 To arr.Length - 1 Do
          Begin
            prop1 := GetO(j);
            prop2 := arr.GetO(j);
            If (prop1 <> Nil) And (prop2 <> Nil) And (prop1.DataType = prop2.DataType) Then
              prop1.Merge(prop2) Else
            If reference Then
              PutO(j, prop2) Else
              PutO(j, prop2.Clone);
          End;
      End;
    End;
End;

Procedure TSuperObject.Merge(Const str: SOString);
Begin
  Merge(TSuperObject.ParseString(PSOChar(str), False), True);
End;

Class Function TSuperObject.NewInstance: TObject;
Begin
  Result := Inherited NewInstance;
  TSuperObject(Result).FRefCount := 1;
End;

Function TSuperObject.ForcePath(Const path: SOString; dataType: TSuperType = stObject): ISuperObject;
Begin
  Result := ParseString(PSOChar(path), False, True, Self, [foCreatePath], Nil, dataType);
End;

Function TSuperObject.Format(Const str: SOString; BeginSep: SOChar; EndSep: SOChar): SOString;
Var
  p1, p2: PSOChar;
Begin
  Result := '';
  p2 := PSOChar(str);
  p1 := p2;
  While True Do
    If p2^ = BeginSep Then
    Begin
      If p2 > p1 Then
        Result := Result + Copy(p1, 0, p2-p1);
      inc(p2);
      p1 := p2;

      While True Do
        If p2^ = EndSep Then
          Break
        Else If p2^ = #0 Then
          Exit
        Else
          inc(p2);

      Result := Result + GetS(copy(p1, 0, p2-p1));
      inc(p2);
      p1 := p2;
    End
    Else If p2^ = #0 Then
    Begin
      If p2 > p1 Then
        Result := Result + Copy(p1, 0, p2-p1);
      Break;
    End
    Else
      inc(p2);
End;

Function TSuperObject.GetO(Const path: SOString): ISuperObject;
Begin
  Result := ParseString(PSOChar(path), False, True, Self);
End;

Function TSuperObject.GetA(Const path: SOString): TSuperArray;
Var
  obj: ISuperObject;
Begin
  obj := ParseString(PSOChar(path), False, True, Self);
  If obj <> Nil Then
    Result := obj.AsArray
  Else
    Result := Nil;
End;

Function TSuperObject.GetB(Const path: SOString): Boolean;
Var
  obj: ISuperObject;
Begin
  obj := GetO(path);
  If obj <> Nil Then
    Result := obj.AsBoolean Else
    Result := False;
End;

Function TSuperObject.GetD(Const path: SOString): Double;
Var
  obj: ISuperObject;
Begin
  obj := GetO(path);
  If obj <> Nil Then
    Result := obj.AsDouble
  Else
    Result := 0.0;
End;

Function TSuperObject.GetC(Const path: SOString): Currency;
Var
  obj: ISuperObject;
Begin
  obj := GetO(path);
  If obj <> Nil Then
    Result := obj.AsCurrency Else
    Result := 0.0;
End;

Function TSuperObject.GetI(Const path: SOString): SuperInt;
Var
  obj: ISuperObject;
Begin
  obj := GetO(path);
  If obj <> Nil Then
    Result := obj.AsInteger Else
    Result := 0;
End;

Function TSuperObject.GetDataPtr: Pointer;
Begin
  Result := FDataPtr;
End;

Function TSuperObject.GetDataType: TSuperType;
Begin
  Result := FDataType
End;

Function TSuperObject.GetS(Const path: SOString): SOString;
Var
  obj: ISuperObject;
Begin
  obj := GetO(path);
  If obj <> Nil Then
    Result := obj.AsString Else
    Result := '';
End;

Function TSuperObject.SaveTo(Const FileName: String; indent, escape: Boolean): Integer;
Var
  stream: TFileStream;
Begin
  stream := TFileStream.Create(FileName, fmCreate);
  Try
    Result := SaveTo(stream, indent, escape);
  Finally
    stream.Free;
  End;
End;

Function TSuperObject.Validate(Const rules: SOString; Const defs: SOString = ''; callback: TSuperOnValidateError = Nil; sender: Pointer = Nil): Boolean;
Begin
  Result := Validate(TSuperObject.ParseString(PSOChar(rules), False), TSuperObject.ParseString(PSOChar(defs), False), callback, sender);
End;

Function TSuperObject.Validate(Const rules: ISuperObject; Const defs: ISuperObject = Nil; callback: TSuperOnValidateError = Nil; sender: Pointer = Nil): Boolean;
Type
  TDataType = (dtUnknown, dtStr, dtInt, dtFloat, dtNumber, dtText, dtBool,
    dtMap, dtSeq, dtScalar, dtAny);
Var
  datatypes: ISuperObject;
  names: ISuperObject;

  Function FindInheritedProperty(Const prop: PSOChar; p: ISuperObject): ISuperObject;
  Var
    o: ISuperObject;
    e: TSuperAvlEntry;
  Begin
    o := p[prop];
    If o <> Nil Then
      result := o Else
    Begin
      o := p['inherit'];
      If (o <> Nil) And ObjectIsType(o, stString) Then
      Begin
        e := names.AsObject.Search(o.AsString);
        If (e <> Nil) Then
          Result := FindInheritedProperty(prop, e.Value) Else
          Result := Nil;
      End
      Else
        Result := Nil;
    End;
  End;

  Function FindDataType(o: ISuperObject): TDataType;
  Var
    e: TSuperAvlEntry;
    obj: ISuperObject;
  Begin
    obj := FindInheritedProperty('type', o);
    If obj <> Nil Then
    Begin
      e := datatypes.AsObject.Search(obj.AsString);
      If  e <> Nil Then
        Result := TDataType(e.Value.AsInteger) Else
        Result := dtUnknown;
    End
    Else
      Result := dtUnknown;
  End;

  Procedure GetNames(o: ISuperObject);
  Var
    obj: ISuperObject;
    f: TSuperObjectIter;
  Begin
    obj := o['name'];
    If ObjectIsType(obj, stString) Then
      names[obj.AsString] := o;

    Case FindDataType(o) Of
      dtMap:
      Begin
        obj := o['mapping'];
        If ObjectIsType(obj, stObject) Then
        Begin
          If ObjectFindFirst(obj, f) Then
            Repeat
              If ObjectIsType(f.val, stObject) Then
                GetNames(f.val);
            Until Not ObjectFindNext(f);
          ObjectFindClose(f);
        End;
      End;
      dtSeq:
      Begin
        obj := o['sequence'];
        If ObjectIsType(obj, stObject) Then
          GetNames(obj);
      End;
    End;
  End;

  Function FindInheritedField(Const prop: SOString; p: ISuperObject): ISuperObject;
  Var
    o: ISuperObject;
    e: TSuperAvlEntry;
  Begin
    o := p['mapping'];
    If ObjectIsType(o, stObject) Then
    Begin
      o := o.AsObject.GetO(prop);
      If o <> Nil Then
      Begin
        Result := o;
        Exit;
      End;
    End;

    o := p['inherit'];
    If ObjectIsType(o, stString) Then
    Begin
      e := names.AsObject.Search(o.AsString);
      If (e <> Nil) Then
        Result := FindInheritedField(prop, e.Value) Else
        Result := Nil;
    End
    Else
      Result := Nil;
  End;

  Function InheritedFieldExist(Const obj: ISuperObject; p: ISuperObject; Const name: SOString = ''): Boolean;
  Var
    o: ISuperObject;
    e: TSuperAvlEntry;
    j: TSuperAvlIterator;
  Begin
    Result := True;
    o := p['mapping'];
    If ObjectIsType(o, stObject) Then
    Begin
      j := TSuperAvlIterator.Create(o.AsObject);
      Try
        j.First;
        e := j.GetIter;
        While e <> Nil Do
        Begin
          If obj.AsObject.Search(e.Name) = Nil Then
          Begin
            Result := False;
            If assigned(callback) Then
              callback(sender, veFieldNotFound, name + '.' + e.Name);
          End;
          j.Next;
          e := j.GetIter;
        End;

      Finally
        j.Free;
      End;
    End;

    o := p['inherit'];
    If ObjectIsType(o, stString) Then
    Begin
      e := names.AsObject.Search(o.AsString);
      If (e <> Nil) Then
        Result := InheritedFieldExist(obj, e.Value, name) And Result;
    End;
  End;

  Function getInheritedBool(f: PSOChar; p: ISuperObject; default: Boolean = False): Boolean;
  Var
    o: ISuperObject;
  Begin
    o := FindInheritedProperty(f, p);
    Case ObjectGetType(o) Of
      stBoolean:
        Result := o.AsBoolean;
      stNull:
        Result := Default;
    Else
      Result := default;
      If assigned(callback) Then
        callback(sender, veRuleMalformated, f);
    End;
  End;

  Procedure GetInheritedFieldList(list: ISuperObject; p: ISuperObject);
  Var
    o: ISuperObject;
    e: TSuperAvlEntry;
    i: TSuperAvlIterator;
  Begin
    Result := True;
    o := p['mapping'];
    If ObjectIsType(o, stObject) Then
    Begin
      i := TSuperAvlIterator.Create(o.AsObject);
      Try
        i.First;
        e := i.GetIter;
        While e <> Nil Do
        Begin
          If list.AsObject.Search(e.Name) = Nil Then
            list[e.Name] := e.Value;
          i.Next;
          e := i.GetIter;
        End;

      Finally
        i.Free;
      End;
    End;

    o := p['inherit'];
    If ObjectIsType(o, stString) Then
    Begin
      e := names.AsObject.Search(o.AsString);
      If (e <> Nil) Then
        GetInheritedFieldList(list, e.Value);
    End;
  End;

  Function CheckEnum(o: ISuperObject; p: ISuperObject; name: SOString = ''): Boolean;
  Var
    enum: ISuperObject;
    i: Integer;
  Begin
    Result := False;
    enum := FindInheritedProperty('enum', p);
    Case ObjectGetType(enum) Of
      stArray:
        For i := 0 To enum.AsArray.Length - 1 Do
          If (o.AsString = enum.AsArray[i].AsString) Then
          Begin
            Result := True;
            exit;
          End;
      stNull:
        Result := True;
    Else
      Result := False;
      If assigned(callback) Then
        callback(sender, veRuleMalformated, '');
      Exit;
    End;

    If (Not Result) And assigned(callback) Then
      callback(sender, veValueNotInEnum, name);
  End;

  Function CheckLength(len: Integer; p: ISuperObject; Const objpath: SOString): Boolean;
  Var
    length, o: ISuperObject;
  Begin
    result := True;
    length := FindInheritedProperty('length', p);
    Case ObjectGetType(length) Of
      stObject:
      Begin
        o := length.AsObject.GetO('min');
        If (o <> Nil) And (o.AsInteger > len) Then
        Begin
          Result := False;
          If assigned(callback) Then
            callback(sender, veInvalidLength, objpath);
        End;
        o := length.AsObject.GetO('max');
        If (o <> Nil) And (o.AsInteger < len) Then
        Begin
          Result := False;
          If assigned(callback) Then
            callback(sender, veInvalidLength, objpath);
        End;
        o := length.AsObject.GetO('minex');
        If (o <> Nil) And (o.AsInteger >= len) Then
        Begin
          Result := False;
          If assigned(callback) Then
            callback(sender, veInvalidLength, objpath);
        End;
        o := length.AsObject.GetO('maxex');
        If (o <> Nil) And (o.AsInteger <= len) Then
        Begin
          Result := False;
          If assigned(callback) Then
            callback(sender, veInvalidLength, objpath);
        End;
      End;
      stNull:
        ;
    Else
      Result := False;
      If assigned(callback) Then
        callback(sender, veRuleMalformated, '');
    End;
  End;

  Function CheckRange(obj: ISuperObject; p: ISuperObject; Const objpath: SOString): Boolean;
  Var
    length, o: ISuperObject;
  Begin
    result := True;
    length := FindInheritedProperty('range', p);
    Case ObjectGetType(length) Of
      stObject:
      Begin
        o := length.AsObject.GetO('min');
        If (o <> Nil) And (o.Compare(obj) = cpGreat) Then
        Begin
          Result := False;
          If assigned(callback) Then
            callback(sender, veInvalidRange, objpath);
        End;
        o := length.AsObject.GetO('max');
        If (o <> Nil) And (o.Compare(obj) = cpLess) Then
        Begin
          Result := False;
          If assigned(callback) Then
            callback(sender, veInvalidRange, objpath);
        End;
        o := length.AsObject.GetO('minex');
        If (o <> Nil) And (o.Compare(obj) In [cpGreat, cpEqu]) Then
        Begin
          Result := False;
          If assigned(callback) Then
            callback(sender, veInvalidRange, objpath);
        End;
        o := length.AsObject.GetO('maxex');
        If (o <> Nil) And (o.Compare(obj) In [cpLess, cpEqu]) Then
        Begin
          Result := False;
          If assigned(callback) Then
            callback(sender, veInvalidRange, objpath);
        End;
      End;
      stNull:
        ;
    Else
      Result := False;
      If assigned(callback) Then
        callback(sender, veRuleMalformated, '');
    End;
  End;


  Function process(o: ISuperObject; p: ISuperObject; objpath: SOString = ''): Boolean;
  Var
    ite: TSuperAvlIterator;
    ent: TSuperAvlEntry;
    p2, o2, sequence: ISuperObject;
    s: SOString;
    i: Integer;
    uniquelist, fieldlist: ISuperObject;
  Begin
    Result := True;
    If (o = Nil) Then
    Begin
      If getInheritedBool('required', p) Then
      Begin
        If assigned(callback) Then
          callback(sender, veFieldIsRequired, objpath);
        result := False;
      End;
    End
    Else
      Case FindDataType(p) Of
        dtStr:
          Case ObjectGetType(o) Of
            stString:
            Begin
              Result := Result And CheckLength(Length(o.AsString), p, objpath);
              Result := Result And CheckRange(o, p, objpath);
            End;
          Else
            If assigned(callback) Then
              callback(sender, veInvalidDataType, objpath);
            result := False;
          End;
        dtBool:
          Case ObjectGetType(o) Of
            stBoolean:
            Begin
              Result := Result And CheckRange(o, p, objpath);
            End;
          Else
            If assigned(callback) Then
              callback(sender, veInvalidDataType, objpath);
            result := False;
          End;
        dtInt:
          Case ObjectGetType(o) Of
            stInt:
            Begin
              Result := Result And CheckRange(o, p, objpath);
            End;
          Else
            If assigned(callback) Then
              callback(sender, veInvalidDataType, objpath);
            result := False;
          End;
        dtFloat:
          Case ObjectGetType(o) Of
            stDouble, stCurrency:
            Begin
              Result := Result And CheckRange(o, p, objpath);
            End;
          Else
            If assigned(callback) Then
              callback(sender, veInvalidDataType, objpath);
            result := False;
          End;
        dtMap:
          Case ObjectGetType(o) Of
            stObject:
            Begin
                // all objects have and match a rule ?
              ite := TSuperAvlIterator.Create(o.AsObject);
              Try
                ite.First;
                ent := ite.GetIter;
                While ent <> Nil Do
                Begin
                  p2 :=  FindInheritedField(ent.Name, p);
                  If ObjectIsType(p2, stObject) Then
                    result := process(ent.Value, p2, objpath + '.' + ent.Name) And result Else
                  Begin
                    If assigned(callback) Then
                      callback(sender, veUnexpectedField, objpath + '.' + ent.Name);
                    result := False; // field have no rule
                  End;
                  ite.Next;
                  ent := ite.GetIter;
                End;
              Finally
                ite.Free;
              End;

                // all expected field exists ?
              Result :=  InheritedFieldExist(o, p, objpath) And Result;
            End;
            stNull:
{nop};
          Else
            result := False;
            If assigned(callback) Then
              callback(sender, veRuleMalformated, objpath);
          End;
        dtSeq:
          Case ObjectGetType(o) Of
            stArray:
            Begin
              sequence := FindInheritedProperty('sequence', p);
              If sequence <> Nil Then
                Case ObjectGetType(sequence) Of
                  stObject:
                  Begin
                    For i := 0 To o.AsArray.Length - 1 Do
                      result := process(o.AsArray.GetO(i), sequence, objpath + '[' + IntToStr(i) + ']') And result;
                    If getInheritedBool('unique', sequence) Then
                    Begin
                        // type is unique ?
                      uniquelist := TSuperObject.Create(stObject);
                      Try
                        For i := 0 To o.AsArray.Length - 1 Do
                        Begin
                          s := o.AsArray.GetO(i).AsString;
                          If (s <> '') Then
                          Begin
                            If uniquelist.AsObject.Search(s) = Nil Then
                              uniquelist[s] := Nil Else
                            Begin
                              Result := False;
                              If Assigned(callback) Then
                                callback(sender, veDuplicateEntry, objpath + '[' + IntToStr(i) + ']');
                            End;
                          End;
                        End;
                      Finally
                        uniquelist := Nil;
                      End;
                    End;

                      // field is unique ?
                    If (FindDataType(sequence) = dtMap) Then
                    Begin
                      fieldlist := TSuperObject.Create(stObject);
                      Try
                        GetInheritedFieldList(fieldlist, sequence);
                        ite := TSuperAvlIterator.Create(fieldlist.AsObject);
                        Try
                          ite.First;
                          ent := ite.GetIter;
                          While ent <> Nil Do
                          Begin
                            If getInheritedBool('unique', ent.Value) Then
                            Begin
                              uniquelist := TSuperObject.Create(stObject);
                              Try
                                For i := 0 To o.AsArray.Length - 1 Do
                                Begin
                                  o2 := o.AsArray.GetO(i);
                                  If o2 <> Nil Then
                                  Begin
                                    s := o2.AsObject.GetO(ent.Name).AsString;
                                    If (s <> '') Then
                                      If uniquelist.AsObject.Search(s) = Nil Then
                                        uniquelist[s] := Nil Else
                                      Begin
                                        Result := False;
                                        If Assigned(callback) Then
                                          callback(sender, veDuplicateEntry, objpath + '[' + IntToStr(i) + '].' + ent.name);
                                      End;
                                  End;
                                End;
                              Finally
                                uniquelist := Nil;
                              End;
                            End;
                            ite.Next;
                            ent := ite.GetIter;
                          End;
                        Finally
                          ite.Free;
                        End;
                      Finally
                        fieldlist := Nil;
                      End;
                    End;


                  End;
                  stNull:
{nop};
                Else
                  result := False;
                  If assigned(callback) Then
                    callback(sender, veRuleMalformated, objpath);
                End;
              Result := Result And CheckLength(o.AsArray.Length, p, objpath);

            End;
          Else
            result := False;
            If assigned(callback) Then
              callback(sender, veRuleMalformated, objpath);
          End;
        dtNumber:
          Case ObjectGetType(o) Of
            stInt,
            stDouble, stCurrency:
            Begin
              Result := Result And CheckRange(o, p, objpath);
            End;
          Else
            If assigned(callback) Then
              callback(sender, veInvalidDataType, objpath);
            result := False;
          End;
        dtText:
          Case ObjectGetType(o) Of
            stInt,
            stDouble,
            stCurrency,
            stString:
            Begin
              result := result And CheckLength(Length(o.AsString), p, objpath);
              Result := Result And CheckRange(o, p, objpath);
            End;
          Else
            If assigned(callback) Then
              callback(sender, veInvalidDataType, objpath);
            result := False;
          End;
        dtScalar:
          Case ObjectGetType(o) Of
            stBoolean,
            stDouble,
            stCurrency,
            stInt,
            stString:
            Begin
              result := result And CheckLength(Length(o.AsString), p, objpath);
              Result := Result And CheckRange(o, p, objpath);
            End;
          Else
            If assigned(callback) Then
              callback(sender, veInvalidDataType, objpath);
            result := False;
          End;
        dtAny:
          ;
      Else
        If assigned(callback) Then
          callback(sender, veRuleMalformated, objpath);
        result := False;
      End;
    Result := Result And CheckEnum(o, p, objpath)

  End;
Var
  j: Integer;

Begin
  Result := False;
  datatypes := TSuperObject.Create(stObject);
  names  := TSuperObject.Create;
  Try
    datatypes.I['str']    := ord(dtStr);
    datatypes.I['int']    := ord(dtInt);
    datatypes.I['float']  := ord(dtFloat);
    datatypes.I['number'] := ord(dtNumber);
    datatypes.I['text']   := ord(dtText);
    datatypes.I['bool']   := ord(dtBool);
    datatypes.I['map']    := ord(dtMap);
    datatypes.I['seq']    := ord(dtSeq);
    datatypes.I['scalar'] := ord(dtScalar);
    datatypes.I['any']    := ord(dtAny);

    If ObjectIsType(defs, stArray) Then
      For j := 0 To defs.AsArray.Length - 1 Do
        If ObjectIsType(defs.AsArray[j], stObject) Then
          GetNames(defs.AsArray[j])
        Else
        Begin
          If assigned(callback) Then
            callback(sender, veRuleMalformated, '');
          Exit;
        End;


    If ObjectIsType(rules, stObject) Then
      GetNames(rules) Else
    Begin
      If assigned(callback) Then
        callback(sender, veRuleMalformated, '');
      Exit;
    End;

    Result := process(self, rules);

  Finally
    datatypes := Nil;
    names := Nil;
  End;
End;

Function TSuperObject._AddRef: Integer; Stdcall;
Begin
  Result := InterlockedIncrement(FRefCount);
End;

Function TSuperObject._Release: Integer; Stdcall;
Begin
  Result := InterlockedDecrement(FRefCount);
  If Result = 0 Then
    Destroy;
End;

Function TSuperObject.Compare(Const str: SOString): TSuperCompareResult;
Begin
  Result := Compare(TSuperObject.ParseString(PSOChar(str), False));
End;

Function TSuperObject.Compare(Const obj: ISuperObject): TSuperCompareResult;
  Function GetIntCompResult(Const i: Int64): TSuperCompareResult;
  Begin
    If i < 0 Then
      result := cpLess
    Else If i = 0 Then
      result := cpEqu
    Else
      Result := cpGreat;
  End;

  Function GetDblCompResult(Const d: Double): TSuperCompareResult;
  Begin
    If d < 0 Then
      result := cpLess
    Else If d = 0 Then
      result := cpEqu
    Else
      Result := cpGreat;
  End;

Begin
  Case DataType Of
    stBoolean:
      Case ObjectGetType(obj) Of
        stBoolean:
          Result := GetIntCompResult(ord(FO.c_boolean) - ord(obj.AsBoolean));
        stDouble:
          Result := GetDblCompResult(ord(FO.c_boolean) - obj.AsDouble);
        stCurrency:
          Result := GetDblCompResult(ord(FO.c_boolean) - obj.AsCurrency);
        stInt:
          Result := GetIntCompResult(ord(FO.c_boolean) - obj.AsInteger);
        stString:
          Result := GetIntCompResult(StrComp(PSOChar(AsString), PSOChar(obj.AsString)));
      Else
        Result := cpError;
      End;
    stDouble:
      Case ObjectGetType(obj) Of
        stBoolean:
          Result := GetDblCompResult(FO.c_double - ord(obj.AsBoolean));
        stDouble:
          Result := GetDblCompResult(FO.c_double - obj.AsDouble);
        stCurrency:
          Result := GetDblCompResult(FO.c_double - obj.AsCurrency);
        stInt:
          Result := GetDblCompResult(FO.c_double - obj.AsInteger);
        stString:
          Result := GetIntCompResult(StrComp(PSOChar(AsString), PSOChar(obj.AsString)));
      Else
        Result := cpError;
      End;
    stCurrency:
      Case ObjectGetType(obj) Of
        stBoolean:
          Result := GetDblCompResult(FO.c_currency - ord(obj.AsBoolean));
        stDouble:
          Result := GetDblCompResult(FO.c_currency - obj.AsDouble);
        stCurrency:
          Result := GetDblCompResult(FO.c_currency - obj.AsCurrency);
        stInt:
          Result := GetDblCompResult(FO.c_currency - obj.AsInteger);
        stString:
          Result := GetIntCompResult(StrComp(PSOChar(AsString), PSOChar(obj.AsString)));
      Else
        Result := cpError;
      End;
    stInt:
      Case ObjectGetType(obj) Of
        stBoolean:
          Result := GetIntCompResult(FO.c_int - ord(obj.AsBoolean));
        stDouble:
          Result := GetDblCompResult(FO.c_int - obj.AsDouble);
        stCurrency:
          Result := GetDblCompResult(FO.c_int - obj.AsCurrency);
        stInt:
          Result := GetIntCompResult(FO.c_int - obj.AsInteger);
        stString:
          Result := GetIntCompResult(StrComp(PSOChar(AsString), PSOChar(obj.AsString)));
      Else
        Result := cpError;
      End;
    stString:
      Case ObjectGetType(obj) Of
        stBoolean,
        stDouble,
        stCurrency,
        stInt,
        stString:
          Result := GetIntCompResult(StrComp(PSOChar(AsString), PSOChar(obj.AsString)));
      Else
        Result := cpError;
      End;
  Else
    Result := cpError;
  End;
End;

{$IfDef SUPER_METHOD}
Function TSuperObject.AsMethod: TSuperMethod;
Begin
  If FDataType = stMethod Then
    Result := FO.c_method Else
    Result := Nil;
End;
{$EndIf}

{$IfDef SUPER_METHOD}
Constructor TSuperObject.Create(m: TSuperMethod);
Begin
  Create(stMethod);
  FO.c_method := m;
End;
{$EndIf}

{$IfDef SUPER_METHOD}
Function TSuperObject.GetM(Const path: SOString): TSuperMethod;
Var
  v: ISuperObject;
Begin
  v := ParseString(PSOChar(path), False, True, Self);
  If (v <> Nil) And (ObjectGetType(v) = stMethod) Then
    Result := v.AsMethod Else
    Result := Nil;
End;
{$EndIf}

{$IfDef SUPER_METHOD}
Procedure TSuperObject.PutM(Const path: SOString; Value: TSuperMethod);
Begin
  ParseString(PSOChar(path), False, True, Self, [foCreatePath, foPutValue], TSuperObject.Create(Value));
End;
{$EndIf}

{$IfDef SUPER_METHOD}
Function TSuperObject.call(Const path: SOString; Const param: ISuperObject): ISuperObject;
Begin
  Result := ParseString(PSOChar(path), False, True, Self, [foCallMethod], param);
End;
{$EndIf}

{$IfDef SUPER_METHOD}
Function TSuperObject.call(Const path, param: SOString): ISuperObject;
Begin
  Result := ParseString(PSOChar(path), False, True, Self, [foCallMethod], TSuperObject.ParseString(PSOChar(param), False));
End;
{$EndIf}

Function TSuperObject.GetProcessing: Boolean;
Begin
  Result := FProcessing;
End;

Procedure TSuperObject.SetDataPtr(Const Value: Pointer);
Begin
  FDataPtr := Value;
End;

Procedure TSuperObject.SetProcessing(value: Boolean);
Begin
  FProcessing := value;
End;

{ TSuperArray }

Function TSuperArray.Add(Const Data: ISuperObject): Integer;
Begin
  Result := FLength;
  PutO(Result, data);
End;

Function TSuperArray.Delete(index: Integer): ISuperObject;
Begin
  If (Index >= 0) And (Index < FLength) Then
  Begin
    Result := FArray^[index];
    FArray^[index] := Nil;
    Dec(FLength);
    If Index < FLength Then
    Begin
      Move(FArray^[index + 1], FArray^[index],
        (FLength - index) * SizeOf(Pointer));
      Pointer(FArray^[FLength]) := Nil;
    End;
  End;
End;

Procedure TSuperArray.Insert(index: Integer; Const value: ISuperObject);
Begin
  If (Index >= 0) Then
    If (index < FLength) Then
    Begin
      If FLength = FSize Then
        Expand(index);
      If Index < FLength Then
        Move(FArray^[index], FArray^[index + 1],
          (FLength - index) * SizeOf(Pointer));
      Pointer(FArray^[index]) := Nil;
      FArray^[index] := value;
      Inc(FLength);
    End
    Else
      PutO(index, value);
End;

Procedure TSuperArray.Clear(all: Boolean);
Var
  j: Integer;
Begin
  For j := 0 To FLength - 1 Do
    If FArray^[j] <> Nil Then
    Begin
      If all Then
        FArray^[j].Clear(all);
      FArray^[j] := Nil;
    End;
  FLength := 0;
End;

Procedure TSuperArray.Pack(all: Boolean);
Var
  PackedCount, StartIndex, EndIndex, j: Integer;
Begin
  If FLength > 0 Then
  Begin
    PackedCount := 0;
    StartIndex  := 0;
    Repeat
      While (StartIndex < FLength) And (FArray^[StartIndex] = Nil) Do
        Inc(StartIndex);
      If StartIndex < FLength Then
      Begin
        EndIndex := StartIndex;
        While (EndIndex < FLength) And  (FArray^[EndIndex] <> Nil) Do
          Inc(EndIndex);

        Dec(EndIndex);

        If StartIndex > PackedCount Then
          Move(FArray^[StartIndex], FArray^[PackedCount], (EndIndex - StartIndex + 1) * SizeOf(Pointer));

        Inc(PackedCount, EndIndex - StartIndex + 1);
        StartIndex := EndIndex + 1;
      End;
    Until StartIndex >= FLength;
    FillChar(FArray^[PackedCount], (FLength - PackedCount) * sizeof(Pointer), 0);
    FLength := PackedCount;
    If all Then
      For j := 0 To FLength - 1 Do
        FArray^[j].Pack(all);
  End;
End;

Constructor TSuperArray.Create;
Begin
  Inherited Create;
  FSize := SUPER_ARRAY_LIST_DEFAULT_SIZE;
  FLength := 0;
  GetMem(FArray, sizeof(Pointer) * FSize);
  FillChar(FArray^, sizeof(Pointer) * FSize, 0);
End;

Destructor TSuperArray.Destroy;
Begin
  Clear;
  FreeMem(FArray);
  Inherited;
End;

Procedure TSuperArray.Expand(max: Integer);
Var
  new_size: Integer;
Begin
  If (max < FSize) Then
    Exit;

  If max < (FSize Shl 1) Then
    new_size := (FSize Shl 1)
  Else
    new_size := max + 1;

  ReallocMem(FArray, new_size * sizeof(Pointer));
  FillChar(FArray^[FSize], (new_size - FSize) * sizeof(Pointer), 0);
  FSize := new_size;
End;

Function TSuperArray.GetO(Const index: Integer): ISuperObject;
Begin
  If(index >= FLength) Then
    Result := Nil
  Else
    Result := FArray^[index];
End;

Function TSuperArray.GetB(Const index: Integer): Boolean;
Var
  obj: ISuperObject;
Begin
  obj := GetO(index);
  If obj <> Nil Then
    Result := obj.AsBoolean
  Else
    Result := False;
End;

Function TSuperArray.GetD(Const index: Integer): Double;
Var
  obj: ISuperObject;
Begin
  obj := GetO(index);
  If obj <> Nil Then
    Result := obj.AsDouble
  Else
    Result := 0.0;
End;

Function TSuperArray.GetI(Const index: Integer): SuperInt;
Var
  obj: ISuperObject;
Begin
  obj := GetO(index);
  If obj <> Nil Then
    Result := obj.AsInteger
  Else
    Result := 0;
End;

Function TSuperArray.GetS(Const index: Integer): SOString;
Var
  obj: ISuperObject;
Begin
  obj := GetO(index);
  If obj <> Nil Then
    Result := obj.AsString
  Else
    Result := '';
End;

Procedure TSuperArray.PutO(Const index: Integer; Const Value: ISuperObject);
Begin
  Expand(index);
  FArray^[index] := value;
  If(FLength <= index) Then
    FLength := index + 1;
End;

Function TSuperArray.GetN(Const index: Integer): ISuperObject;
Begin
  Result := GetO(index);
  If Result = Nil Then
    Result := TSuperObject.Create(stNull);
End;

Procedure TSuperArray.PutN(Const index: Integer; Const Value: ISuperObject);
Begin
  If Value <> Nil Then
    PutO(index, Value)
  Else
    PutO(index, TSuperObject.Create(stNull));
End;

Procedure TSuperArray.PutB(Const index: Integer; Value: Boolean);
Begin
  PutO(index, TSuperObject.Create(Value));
End;

Procedure TSuperArray.PutD(Const index: Integer; Value: Double);
Begin
  PutO(index, TSuperObject.Create(Value));
End;

Function TSuperArray.GetC(Const index: Integer): Currency;
Var
  obj: ISuperObject;
Begin
  obj := GetO(index);
  If obj <> Nil Then
    Result := obj.AsCurrency
  Else
    Result := 0.0;
End;

Procedure TSuperArray.PutC(Const index: Integer; Value: Currency);
Begin
  PutO(index, TSuperObject.CreateCurrency(Value));
End;

Procedure TSuperArray.PutI(Const index: Integer; Value: SuperInt);
Begin
  PutO(index, TSuperObject.Create(Value));
End;

Procedure TSuperArray.PutS(Const index: Integer; Const Value: SOString);
Begin
  PutO(index, TSuperObject.Create(Value));
End;

{$IfDef SUPER_METHOD}
Function TSuperArray.GetM(Const index: Integer): TSuperMethod;
Var
  v: ISuperObject;
Begin
  v := GetO(index);
  If (ObjectGetType(v) = stMethod) Then
    Result := v.AsMethod
  Else
    Result := Nil;
End;
{$EndIf}

{$IfDef SUPER_METHOD}
Procedure TSuperArray.PutM(Const index: Integer; Value: TSuperMethod);
Begin
  PutO(index, TSuperObject.Create(Value));
End;
{$EndIf}

{ TSuperWriterString }

Function TSuperWriterString.Append(buf: PSOChar; Size: Integer): Integer;
  Function max(a, b: Integer): Integer;
  Begin
    If a > b Then
      Result := a
    Else
      Result := b
  End;
  
Begin
  Result := size;
  If Size > 0 Then
  Begin
    If (FSize - FBPos <= size) Then
    Begin
      FSize := max(FSize * 2, FBPos + size + 8);
      ReallocMem(FBuf, FSize * SizeOf(SOChar));
    End;

    // fast move
    Case size Of
      1: FBuf[FBPos] := buf^;
      2: PInteger(@FBuf[FBPos])^ := PInteger(buf)^;
      4: PInt64(@FBuf[FBPos])^ := PInt64(buf)^;

      Else
        move(buf^, FBuf[FBPos], size * SizeOf(SOChar));
    End;

    inc(FBPos, size);
    FBuf[FBPos] := #0;
  End;
End;

Function TSuperWriterString.Append(buf: PSOChar): Integer;
Begin
  Result := Append(buf, strlen(buf));
End;

Constructor TSuperWriterString.Create;
Begin
  Inherited;
  FSize := 32;
  FBPos := 0;
  GetMem(FBuf, FSize * SizeOf(SOChar));
End;

Destructor TSuperWriterString.Destroy;
Begin
  Inherited;
  If FBuf <> Nil Then
    FreeMem(FBuf)
End;

Function TSuperWriterString.GetString: SOString;
Begin
  SetString(Result, FBuf, FBPos);
End;

Procedure TSuperWriterString.Reset;
Begin
  FBuf[0] := #0;
  FBPos := 0;
End;

Procedure TSuperWriterString.TrimRight;
Begin
  While (FBPos > 0) And (FBuf[FBPos-1] < #256) And (AnsiChar(FBuf[FBPos-1]) In [#32, #13, #10]) Do
  Begin
    dec(FBPos);
    FBuf[FBPos] := #0;
  End;
End;

{ TSuperWriterStream }

Function TSuperWriterStream.Append(buf: PSOChar): Integer;
Begin
  Result := Append(buf, StrLen(buf));
End;

Constructor TSuperWriterStream.Create(AStream: TStream);
Begin
  Inherited Create;
  FStream := AStream;
End;

Procedure TSuperWriterStream.Reset;
Begin
  FStream.Size := 0;
End;

{ TSuperWriterStream }

Function TSuperAnsiWriterStream.Append(buf: PSOChar; Size: Integer): Integer;
Var
  Buffer: Array[0..1023] Of AnsiChar;
  pBuffer: PAnsiChar;
  i: Integer;
Begin
  If Size = 1 Then
    Result := FStream.Write(buf^, Size)
  Else
  Begin
    If Size > SizeOf(Buffer) Then
      GetMem(pBuffer, Size)
    Else
      pBuffer := @Buffer;

    Try
      For i :=  0 To Size - 1 Do
        pBuffer[i] := AnsiChar(buf[i]);
      Result := FStream.Write(pBuffer^, Size);

      Finally
        If pBuffer <> @Buffer Then
          FreeMem(pBuffer);
    End;
  End;
End;

{ TSuperUnicodeWriterStream }

Function TSuperUnicodeWriterStream.Append(buf: PSOChar; Size: Integer): Integer;
Begin
  Result := FStream.Write(buf^, Size * 2);
End;

{ TSuperWriterFake }

Function TSuperWriterFake.Append(buf: PSOChar; Size: Integer): Integer;
Begin
  inc(FSize, Size);
  Result := FSize;
End;

Function TSuperWriterFake.Append(buf: PSOChar): Integer;
Begin
  inc(FSize, Strlen(buf));
  Result := FSize;
End;

Constructor TSuperWriterFake.Create;
Begin
  Inherited Create;
  FSize := 0;
End;

Procedure TSuperWriterFake.Reset;
Begin
  FSize := 0;
End;

{ TSuperWriterSock }
Function TSuperWriterSock.Append(buf: PSOChar; Size: Integer): Integer;
Var
  Buffer: Array[0..1023] Of AnsiChar;
  pBuffer: PAnsiChar;
  i: Integer;
Begin
  If Size = 1 Then
{$IfDEF FPC}
    Result := fpsend(FSocket, buf, size, 0)
{$ELSE}
    Result := send(FSocket, buf^, size, 0)
{$EndIf}
  Else
  Begin
    If Size > SizeOf(Buffer) Then
      GetMem(pBuffer, Size) Else
      pBuffer := @Buffer;

    Try
      For i :=  0 To Size - 1 Do
        pBuffer[i] := AnsiChar(buf[i]);
{$IfDEF FPC}
      Result := fpsend(FSocket, pBuffer, size, 0);
{$ELSE}
      Result := send(FSocket, pBuffer^, size, 0);
{$EndIf}

      Finally
        If pBuffer <> @Buffer Then
          FreeMem(pBuffer);
    End;
  End;
  inc(FSize, Result);
End;
Function TSuperWriterSock.Append(buf: PSOChar): Integer;
Begin
  Result := Append(buf, StrLen(buf));
End;

Constructor TSuperWriterSock.Create(ASocket: Integer);
Begin
  Inherited Create;
  FSocket := ASocket;
  FSize := 0;
End;

Procedure TSuperWriterSock.Reset;
Begin
  FSize := 0;
End;

{ TSuperTokenizer }

Constructor TSuperTokenizer.Create;
Begin
  pb := TSuperWriterString.Create;
  line := 1;
  col := 0;
  Reset;
End;

Destructor TSuperTokenizer.Destroy;
Begin
  Reset;
  pb.Free;
  Inherited;
End;

Procedure TSuperTokenizer.Reset;
Var
  i: Integer;
Begin
  For i := depth Downto 0 Do
    ResetLevel(i);
  depth := 0;
  err := teSuccess;
End;

Procedure TSuperTokenizer.ResetLevel(adepth: Integer);
Begin
  stack[adepth].state       := tsEatws;
  stack[adepth].saved_state := tsStart;
  stack[adepth].current     := Nil;
  stack[adepth].field_name  := '';
  stack[adepth].obj         := Nil;
  stack[adepth].parent      := Nil;
  stack[adepth].gparent     := Nil;
End;

{ TSuperAvlTree }

Constructor TSuperAvlTree.Create;
Begin
  FRoot := Nil;
  FCount := 0;
End;

Destructor TSuperAvlTree.Destroy;
Begin
  Clear;
  Inherited;
End;

Function TSuperAvlTree.IsEmpty: Boolean;
Begin
  result := FRoot = Nil;
End;

Function TSuperAvlTree.balance(bal: TSuperAvlEntry): TSuperAvlEntry;
Var
  deep, old: TSuperAvlEntry;
  bf: Integer;
Begin
  If (bal.FBf > 0) Then
  Begin
    deep := bal.FGt;
    If (deep.FBf < 0) Then
    Begin
      old      := bal;
      bal      := deep.FLt;
      old.FGt  := bal.FLt;
      deep.FLt := bal.FGt;
      bal.FLt  := old;
      bal.FGt  := deep;
      bf       := bal.FBf;

      If (bf <> 0) Then
      Begin
        If (bf > 0) Then
        Begin
          old.FBf := -1;
          deep.FBf := 0;
        End
        Else
        Begin
          deep.FBf := 1;
          old.FBf  := 0;
        End;
        bal.FBf := 0;
      End
      Else
      Begin
        old.FBf := 0;
        deep.FBf := 0;
      End;
    End
    Else
    Begin
      bal.FGt  := deep.FLt;
      deep.FLt := bal;

      If (deep.FBf = 0) Then
      Begin
        deep.FBf := -1;
        bal.FBf  := 1;
      End
      Else
      Begin
        deep.FBf := 0;
        bal.FBf  := 0;
      End;

      bal := deep;
    End;
  End
  Else
  Begin
    (* "Less than" subtree is deeper. *)
    deep := bal.FLt;
    If (deep.FBf > 0) Then
    Begin
      old := bal;
      bal := deep.FGt;
      old.FLt := bal.FGt;
      deep.FGt := bal.FLt;
      bal.FGt := old;
      bal.FLt := deep;

      bf := bal.FBf;
      If (bf <> 0) Then
      Begin
        If (bf < 0) Then
        Begin
          old.FBf := 1;
          deep.FBf := 0;
        End
        Else
        Begin
          deep.FBf := -1;
          old.FBf  := 0;
        End;
        bal.FBf := 0;
      End
      Else
      Begin
        old.FBf := 0;
        deep.FBf := 0;
      End;
    End
    Else
    Begin
      bal.FLt := deep.FGt;
      deep.FGt := bal;
      If (deep.FBf = 0) Then
      Begin
        deep.FBf := 1;
        bal.FBf  := -1;
      End
      Else
      Begin
        deep.FBf := 0;
        bal.FBf  := 0;
      End;
      bal := deep;
    End;
  End;
  Result := bal;
End;

Function TSuperAvlTree.Insert(h: TSuperAvlEntry): TSuperAvlEntry;
Var
  unbal, parentunbal, hh, parent: TSuperAvlEntry;
  depth, unbaldepth: Longint;
  cmp: Integer;
  unbalbf: Integer;
  branch: TSuperAvlBitArray;
  p: Pointer;
Begin
  inc(FCount);
  h.FLt := Nil;
  h.FGt := Nil;
  h.FBf := 0;
  branch := [];

  If (FRoot = Nil) Then
    FRoot := h
  Else
  Begin
    unbal := Nil;
    parentunbal := Nil;
    depth := 0;
    unbaldepth := 0;
    hh := FRoot;
    parent := Nil;
    Repeat
      If (hh.FBf <> 0) Then
      Begin
        unbal := hh;
        parentunbal := parent;
        unbaldepth := depth;
      End;

      If hh.FHash <> h.FHash Then
      Begin
        If hh.FHash < h.FHash Then
          cmp := -1
        Else If hh.FHash > h.FHash Then
          cmp := 1
        Else
          cmp := 0;
      End
      Else
        cmp := CompareNodeNode(h, hh);

      If (cmp = 0) Then
      Begin
        Result := hh;
        //exchange data
        p := hh.Ptr;
        hh.FPtr := h.Ptr;
        h.FPtr := p;
        doDeleteEntry(h, False);
        dec(FCount);
        exit;
      End;

      parent := hh;
      If (cmp > 0) Then
      Begin
        hh := hh.FGt;
        include(branch, depth);
      End
      Else
      Begin
        hh := hh.FLt;
        exclude(branch, depth);
      End;

      inc(depth);
    Until (hh = Nil);

    If (cmp < 0) Then
      parent.FLt := h
    Else
      parent.FGt := h;

    depth := unbaldepth;

    If (unbal = Nil) Then
      hh := FRoot
    Else
    Begin
      If depth In branch Then
        cmp := 1
      Else
        cmp := -1;

      inc(depth);
      unbalbf := unbal.FBf;
      If (cmp < 0) Then
        dec(unbalbf)
      Else
        inc(unbalbf);

      If cmp < 0 Then
        hh := unbal.FLt
      Else
        hh := unbal.FGt;

      If ((unbalbf <> -2) And (unbalbf <> 2)) Then
      Begin
        unbal.FBf := unbalbf;
        unbal := Nil;
      End;
    End;

    If (hh <> Nil) Then
      While (h <> hh) Do
      Begin
        If depth In branch Then
          cmp := 1
        Else
          cmp := -1;

        inc(depth);
        If (cmp < 0) Then
        Begin
          hh.FBf := -1;
          hh := hh.FLt;
        End
        Else (* cmp > 0 *)
        Begin
          hh.FBf := 1;
          hh := hh.FGt;
        End;
      End;

    If (unbal <> Nil) Then
    Begin
      unbal := balance(unbal);
      If (parentunbal = Nil) Then
        FRoot := unbal
      Else
      Begin
        depth := unbaldepth - 1;
        If depth In branch Then
          cmp := 1
        Else
          cmp := -1;

        If (cmp < 0) Then
          parentunbal.FLt := unbal
        Else
          parentunbal.FGt := unbal;
      End;
    End;
  End;
  result := h;
End;

Function TSuperAvlTree.Search(Const k: SOString; st: TSuperAvlSearchTypes): TSuperAvlEntry;
Var
  cmp, target_cmp: Integer;
  match_h, h: TSuperAvlEntry;
  ha: Cardinal;
Begin
  ha := TSuperAvlEntry.Hash(k);

  match_h := Nil;
  h := FRoot;

  If (stLess In st) Then
    target_cmp := 1
  Else If (stGreater In st) Then
    target_cmp := -1
  Else
    target_cmp := 0;

  While (h <> Nil) Do
  Begin
    If h.FHash < ha Then
      cmp := -1
    Else If h.FHash > ha Then
      cmp := 1
    Else
      cmp := 0;

    If cmp = 0 Then
      cmp := CompareKeyNode(PSOChar(k), h);
      
    If (cmp = 0) Then
    Begin
      If (stEqual In st) Then
      Begin
        match_h := h;
        break;
      End;
      cmp := -target_cmp;
    End
    Else If (target_cmp <> 0) Then
      If ((cmp Xor target_cmp) And SUPER_AVL_MASK_HIGH_BIT) = 0 Then
        match_h := h;

    If cmp < 0 Then
      h := h.FLt
    Else
      h := h.FGt;
  End;
  result := match_h;
End;

Function TSuperAvlTree.Delete(Const k: SOString): ISuperObject;
Var
  depth, rm_depth: Longint;
  branch: TSuperAvlBitArray;
  h, parent, child, path, rm, parent_rm: TSuperAvlEntry;
  cmp, cmp_shortened_sub_with_path, reduced_depth, bf: Integer;
  ha: Cardinal;
Begin
  ha := TSuperAvlEntry.Hash(k);
  cmp_shortened_sub_with_path := 0;
  branch := [];

  depth := 0;
  h := FRoot;
  parent := Nil;
  While True Do
  Begin
    If (h = Nil) Then
      exit;

    If h.FHash < ha Then
      cmp := -1
    Else If h.FHash > ha Then
      cmp := 1
    Else
      cmp := 0;

    If cmp = 0 Then
      cmp := CompareKeyNode(k, h);

    If (cmp = 0) Then
      break;

    parent := h;
    If (cmp > 0) Then
    Begin
      h := h.FGt;
      include(branch, depth)
    End
    Else
    Begin
      h := h.FLt;
      exclude(branch, depth)
    End;

    inc(depth);
    cmp_shortened_sub_with_path := cmp;
  End;
  rm := h;
  parent_rm := parent;
  rm_depth := depth;

  If (h.FBf < 0) Then
  Begin
    child := h.FLt;
    exclude(branch, depth);
    cmp := -1;
  End
  Else
  Begin
    child := h.FGt;
    include(branch, depth);
    cmp := 1;
  End;
  inc(depth);

  If (child <> Nil) Then
  Begin
    cmp := -cmp;
    Repeat
      parent := h;
      h := child;
      If (cmp < 0) Then
      Begin
        child := h.FLt;
        exclude(branch, depth);
      End
      Else
      Begin
        child := h.FGt;
        include(branch, depth);
      End;
      inc(depth);
    Until (child = Nil);

    If (parent = rm) Then
      cmp_shortened_sub_with_path := -cmp
    Else
      cmp_shortened_sub_with_path := cmp;

    If cmp > 0 Then
      child := h.FLt
    Else
      child := h.FGt;
  End;

  If (parent = Nil) Then
    FRoot := child
  Else If (cmp_shortened_sub_with_path < 0) Then
    parent.FLt := child
  Else
    parent.FGt := child;

  If parent = rm Then
    path := h
  Else
    path := parent;

  If (h <> rm) Then
  Begin
    h.FLt := rm.FLt;
    h.FGt := rm.FGt;
    h.FBf := rm.FBf;
    If (parent_rm = Nil) Then
      FRoot := h
    Else
    Begin
      depth := rm_depth - 1;
      If (depth In branch) Then
        parent_rm.FGt := h
      Else
        parent_rm.FLt := h;
    End;
  End;

  If (path <> Nil) Then
  Begin
    h := FRoot;
    parent := Nil;
    depth := 0;
    While (h <> path) Do
    Begin
      If (depth In branch) Then
      Begin
        child := h.FGt;
        h.FGt := parent;
      End
      Else
      Begin
        child := h.FLt;
        h.FLt := parent;
      End;
      inc(depth);
      parent := h;
      h := child;
    End;

    reduced_depth := 1;
    cmp := cmp_shortened_sub_with_path;
    While True Do
    Begin
      If (reduced_depth <> 0) Then
      Begin
        bf := h.FBf;
        If (cmp < 0) Then
          inc(bf)
        Else
          dec(bf);

        If ((bf = -2) Or (bf = 2)) Then
        Begin
          h := balance(h);
          bf := h.FBf;
        End
        Else
          h.FBf := bf;
        reduced_depth := Integer(bf = 0);
      End;

      If (parent = Nil) Then
        break;

      child := h;
      h := parent;
      dec(depth);

      If depth In branch Then
        cmp := 1
      Else
        cmp := -1;

      If (cmp < 0) Then
      Begin
        parent := h.FLt;
        h.FLt  := child;
      End
      Else
      Begin
        parent := h.FGt;
        h.FGt  := child;
      End;
    End;
    FRoot := h;
  End;

  If rm <> Nil Then
  Begin
    Result := rm.GetValue;
    doDeleteEntry(rm, False);
    dec(FCount);
  End;
End;

Procedure TSuperAvlTree.Pack(all: Boolean);
Var
  node1, node2: TSuperAvlEntry;
  list: TList;
  i: Integer;
Begin
  node1 := FRoot;
  list  := TList.Create;
  While node1 <> Nil Do
  Begin
    If (node1.FLt = Nil) Then
    Begin
      node2 := node1.FGt;
      If (node1.FPtr = Nil) Then
        list.Add(node1)
      Else If all Then
        node1.Value.Pack(all);
    End
    Else
    Begin
      node2 := node1.FLt;
      node1.FLt := node2.FGt;
      node2.FGt := node1;
    End;
    node1 := node2;
  End;
  
  For i := 0 To list.Count - 1 Do
    Delete(TSuperAvlEntry(list[i]).FName);
  list.Free;
End;

Procedure TSuperAvlTree.Clear(all: Boolean);
Var
  node1, node2: TSuperAvlEntry;
Begin
  node1 := FRoot;
  While node1 <> Nil Do
  Begin
    If (node1.FLt = Nil) Then
    Begin
      node2 := node1.FGt;
      doDeleteEntry(node1, all);
    End
    Else
    Begin
      node2 := node1.FLt;
      node1.FLt := node2.FGt;
      node2.FGt := node1;
    End;
    node1 := node2;
  End;
  FRoot := Nil;
  FCount := 0;
End;

Function TSuperAvlTree.CompareKeyNode(Const k: SOString; h: TSuperAvlEntry): Integer;
Begin
  Result := StrComp(PSOChar(k), PSOChar(h.FName));
End;

Function TSuperAvlTree.CompareNodeNode(node1, node2: TSuperAvlEntry): Integer;
Begin
  Result := StrComp(PSOChar(node1.FName), PSOChar(node2.FName));
End;

{ TSuperAvlIterator }

(* Initialize depth to invalid value, to indicate iterator is
** invalid.   (Depth is zero-base.)  It's not necessary to initialize
** iterators prior to passing them to the "start" function.
*)

Constructor TSuperAvlIterator.Create(tree: TSuperAvlTree);
Begin
  FDepth := Not 0;
  FTree  := tree;
End;

Procedure TSuperAvlIterator.Search(Const k: SOString; st: TSuperAvlSearchTypes);
Var
  h: TSuperAvlEntry;
  d: Longint;
  cmp, target_cmp: Integer;
  ha: Cardinal;
Begin
  ha := TSuperAvlEntry.Hash(k);
  h  := FTree.FRoot;
  d  := 0;
  FDepth := Not 0;
  If (h = Nil) Then
    exit;

  If (stLess In st) Then
    target_cmp := 1 Else
  If (stGreater In st) Then
    target_cmp := -1 Else
    target_cmp := 0;

  While True Do
  Begin
    If h.FHash < ha Then
      cmp := -1 Else
    If h.FHash > ha Then
      cmp := 1 Else
      cmp := 0;

    If cmp = 0 Then
      cmp := FTree.CompareKeyNode(k, h);
    If (cmp = 0) Then
    Begin
      If (stEqual In st) Then
      Begin
        FDepth := d;
        break;
      End;
      cmp := -target_cmp;
    End
    Else
    If (target_cmp <> 0) Then
      If ((cmp Xor target_cmp) And SUPER_AVL_MASK_HIGH_BIT) = 0 Then
        FDepth := d;
    If cmp < 0 Then
      h := h.FLt Else
      h := h.FGt;
    If (h = Nil) Then
      break;
    If (cmp > 0) Then
      include(FBranch, d) Else
      exclude(FBranch, d);
    FPath[d] := h;
    inc(d);
  End;
End;

Procedure TSuperAvlIterator.First;
Var
  h: TSuperAvlEntry;
Begin
  h := FTree.FRoot;
  FDepth := Not 0;
  FBranch := [];
  While (h <> Nil) Do
  Begin
    If (FDepth <> Not 0) Then
      FPath[FDepth] := h;
    inc(FDepth);
    h := h.FLt;
  End;
End;

Procedure TSuperAvlIterator.Last;
Var
  h: TSuperAvlEntry;
Begin
  h := FTree.FRoot;
  FDepth := Not 0;
  FBranch := [0..SUPER_AVL_MAX_DEPTH - 1];
  While (h <> Nil) Do
  Begin
    If (FDepth <> Not 0) Then
      FPath[FDepth] := h;
    inc(FDepth);
    h := h.FGt;
  End;
End;

Function TSuperAvlIterator.MoveNext: Boolean;
Begin
  If FDepth = Not 0 Then
    First Else
    Next;
  Result := GetIter <> Nil;
End;

Function TSuperAvlIterator.GetIter: TSuperAvlEntry;
Begin
  If (FDepth = Not 0) Then
  Begin
    result := Nil;
    exit;
  End;
  If FDepth = 0 Then
    Result := FTree.FRoot Else
    Result := FPath[FDepth - 1];
End;

Procedure TSuperAvlIterator.Next;
Var
  h: TSuperAvlEntry;
Begin
  If (FDepth <> Not 0) Then
  Begin
    If FDepth = 0 Then
      h := FTree.FRoot.FGt Else
      h := FPath[FDepth - 1].FGt;

    If (h = Nil) Then
      Repeat
        If (FDepth = 0) Then
        Begin
          FDepth := Not 0;
          break;
        End;
        dec(FDepth);
      Until (Not (FDepth In FBranch))
    Else
    Begin
      include(FBranch, FDepth);
      FPath[FDepth] := h;
      inc(FDepth);
      While True Do
      Begin
        h := h.FLt;
        If (h = Nil) Then
          break;
        exclude(FBranch, FDepth);
        FPath[FDepth] := h;
        inc(FDepth);
      End;
    End;
  End;
End;

Procedure TSuperAvlIterator.Prior;
Var
  h: TSuperAvlEntry;
Begin
  If (FDepth <> Not 0) Then
  Begin
    If FDepth = 0 Then
      h := FTree.FRoot.FLt Else
      h := FPath[FDepth - 1].FLt;
    If (h = Nil) Then
      Repeat
        If (FDepth = 0) Then
        Begin
          FDepth := Not 0;
          break;
        End;
        dec(FDepth);
      Until (FDepth In FBranch)
    Else
    Begin
      exclude(FBranch, FDepth);
      FPath[FDepth] := h;
      inc(FDepth);
      While True Do
      Begin
        h := h.FGt;
        If (h = Nil) Then
          break;
        include(FBranch, FDepth);
        FPath[FDepth] := h;
        inc(FDepth);
      End;
    End;
  End;
End;

Procedure TSuperAvlTree.doDeleteEntry(Entry: TSuperAvlEntry; all: Boolean);
Begin
  Entry.Free;
End;

Function TSuperAvlTree.GetEnumerator: TSuperAvlIterator;
Begin
  Result := TSuperAvlIterator.Create(Self);
End;

{ TSuperAvlEntry }

Constructor TSuperAvlEntry.Create(Const AName: SOString; Obj: Pointer);
Begin
  FName := AName;
  FPtr  := Obj;
  FHash := Hash(FName);
End;

Function TSuperAvlEntry.GetValue: ISuperObject;
Begin
  Result := ISuperObject(FPtr)
End;

Class Function TSuperAvlEntry.Hash(Const k: SOString): Cardinal;
Var
  h: Cardinal;
  i: Integer;
Begin
//(*//@@Kahn
  h := 0;
{$Q-}
  For i := 1 To Length(k) Do
    h := h*129 + ord(k[i]) + $9e370001;
{$Q+}
  Result := h;
//*)
//  Result := 0;
End;

Procedure TSuperAvlEntry.SetValue(Const val: ISuperObject);
Begin
  ISuperObject(FPtr) := val;
End;

{ TSuperTableString }

Function TSuperTableString.GetValues: ISuperObject;
Var
  ite: TSuperAvlIterator;
  obj: TSuperAvlEntry;
Begin
  Result := TSuperObject.Create(stArray);
  ite := TSuperAvlIterator.Create(Self);
  Try
    ite.First;
    obj := ite.GetIter;
    While obj <> Nil Do
    Begin
      Result.AsArray.Add(obj.Value);
      ite.Next;
      obj := ite.GetIter;
    End;
  Finally
    ite.Free;
  End;
End;

Function TSuperTableString.GetNames: ISuperObject;
Var
  ite: TSuperAvlIterator;
  obj: TSuperAvlEntry;
Begin
  Result := TSuperObject.Create(stArray);
  ite := TSuperAvlIterator.Create(Self);
  Try
    ite.First;
    obj := ite.GetIter;
    While obj <> Nil Do
    Begin
      Result.AsArray.Add(TSuperObject.Create(obj.FName));
      ite.Next;
      obj := ite.GetIter;
    End;
  Finally
    ite.Free;
  End;
End;

Procedure TSuperTableString.doDeleteEntry(Entry: TSuperAvlEntry; all: Boolean);
Begin
  If Entry.Ptr <> Nil Then
  Begin
    If all Then
      Entry.Value.Clear(True);
    Entry.Value := Nil;
  End;
  Inherited;
End;

Function TSuperTableString.GetO(Const k: SOString): ISuperObject;
Var
  e: TSuperAvlEntry;
Begin
  e := Search(k);
  If e <> Nil Then
    Result := e.Value Else
    Result := Nil
End;

Procedure TSuperTableString.PutO(Const k: SOString; Const value: ISuperObject);
Var
  entry: TSuperAvlEntry;
Begin
  entry := Insert(TSuperAvlEntry.Create(k, Pointer(value)));
  If entry.FPtr <> Nil Then
    ISuperObject(entry.FPtr)._AddRef;
End;

Procedure TSuperTableString.PutS(Const k: SOString; Const value: SOString);
Begin
  PutO(k, TSuperObject.Create(Value));
End;

Function TSuperTableString.GetS(Const k: SOString): SOString;
Var
  obj: ISuperObject;
Begin
  obj := GetO(k);
  If obj <> Nil Then
    Result := obj.AsString Else
    Result := '';
End;

Procedure TSuperTableString.PutI(Const k: SOString; value: SuperInt);
Begin
  PutO(k, TSuperObject.Create(Value));
End;

Function TSuperTableString.GetI(Const k: SOString): SuperInt;
Var
  obj: ISuperObject;
Begin
  obj := GetO(k);
  If obj <> Nil Then
    Result := obj.AsInteger Else
    Result := 0;
End;

Procedure TSuperTableString.PutD(Const k: SOString; value: Double);
Begin
  PutO(k, TSuperObject.Create(Value));
End;

Procedure TSuperTableString.PutC(Const k: SOString; value: Currency);
Begin
  PutO(k, TSuperObject.CreateCurrency(Value));
End;

Function TSuperTableString.GetC(Const k: SOString): Currency;
Var
  obj: ISuperObject;
Begin
  obj := GetO(k);
  If obj <> Nil Then
    Result := obj.AsCurrency Else
    Result := 0.0;
End;

Function TSuperTableString.GetD(Const k: SOString): Double;
Var
  obj: ISuperObject;
Begin
  obj := GetO(k);
  If obj <> Nil Then
    Result := obj.AsDouble Else
    Result := 0.0;
End;

Procedure TSuperTableString.PutB(Const k: SOString; value: Boolean);
Begin
  PutO(k, TSuperObject.Create(Value));
End;

Function TSuperTableString.GetB(Const k: SOString): Boolean;
Var
  obj: ISuperObject;
Begin
  obj := GetO(k);
  If obj <> Nil Then
    Result := obj.AsBoolean Else
    Result := False;
End;

{$IfDef SUPER_METHOD}
Procedure TSuperTableString.PutM(Const k: SOString; value: TSuperMethod);
Begin
  PutO(k, TSuperObject.Create(Value));
End;
{$EndIf}

{$IfDef SUPER_METHOD}
Function TSuperTableString.GetM(Const k: SOString): TSuperMethod;
Var
  obj: ISuperObject;
Begin
  obj := GetO(k);
  If obj <> Nil Then
    Result := obj.AsMethod Else
    Result := Nil;
End;
{$EndIf}

Procedure TSuperTableString.PutN(Const k: SOString; Const value: ISuperObject);
Begin
  If value <> Nil Then
    PutO(k, TSuperObject.Create(stNull)) Else
    PutO(k, value);
End;

Function TSuperTableString.GetN(Const k: SOString): ISuperObject;
Var
  obj: ISuperObject;
Begin
  obj := GetO(k);
  If obj <> Nil Then
    Result := obj Else
    Result := TSuperObject.Create(stNull);
End;


{$IfDef VER210}

{ TSuperAttribute }

Constructor TSuperAttribute.Create(Const AName: String);
Begin
  FName := AName;
End;

{ TSuperRttiContext }

Constructor TSuperRttiContext.Create;
Begin
  Context := TRttiContext.Create;
  SerialFromJson := TDictionary<PTypeInfo, TSerialFromJson>.Create;
  SerialToJson := TDictionary<PTypeInfo, TSerialToJson>.Create;

  SerialFromJson.Add(TypeInfo(Boolean), serialfromboolean);
  SerialFromJson.Add(TypeInfo(TDateTime), serialfromdatetime);
  SerialFromJson.Add(TypeInfo(TGUID), serialfromguid);
  SerialToJson.Add(TypeInfo(Boolean), serialtoboolean);
  SerialToJson.Add(TypeInfo(TDateTime), serialtodatetime);
  SerialToJson.Add(TypeInfo(TGUID), serialtoguid);
End;

Destructor TSuperRttiContext.Destroy;
Begin
  SerialFromJson.Free;
  SerialToJson.Free;
  Context.Free;
End;

Class Function TSuperRttiContext.GetFieldName(r: TRttiField): String;
Var
  o: TCustomAttribute;
Begin
  For o In r.GetAttributes Do
    If o Is SOName Then
      Exit(SOName(o).Name);
  Result := r.Name;
End;

Class Function TSuperRttiContext.GetFieldDefault(r: TRttiField; Const obj: ISuperObject): ISuperObject;
Var
  o: TCustomAttribute;
Begin
  If Not ObjectIsType(obj, stNull) Then
    Exit(obj);
  For o In r.GetAttributes Do
    If o Is SODefault Then
      Exit(SO(SODefault(o).Name));
  Result := obj;
End;

Function TSuperRttiContext.AsType<T>(Const obj: ISuperObject): T;
Var
  ret: TValue;
Begin
  If FromJson(TypeInfo(T), obj, ret) Then
    Result := ret.AsType<T> Else
    Raise exception.Create('Marshalling error');
End;

Function TSuperRttiContext.AsJson<T>(Const obj: T; Const index: ISuperObject = Nil): ISuperObject;
Var
  v: TValue;
Begin
  TValue.MakeWithoutCopy(@obj, TypeInfo(T), v);
  If index <> Nil Then
    Result := ToJson(v, index) Else
    Result := ToJson(v, so);
End;

Function TSuperRttiContext.FromJson(TypeInfo: PTypeInfo; Const obj: ISuperObject;
  Var Value: TValue): Boolean;

  Procedure FromChar;
  Begin
    If ObjectIsType(obj, stString) And (Length(obj.AsString) = 1) Then
    Begin
      Value := String(Ansistring(obj.AsString)[1]);
      Result := True;
    End
    Else
      Result := False;
  End;

  Procedure FromWideChar;
  Begin
    If ObjectIsType(obj, stString) And (Length(obj.AsString) = 1) Then
    Begin
      Value := obj.AsString[1];
      Result := True;
    End
    Else
      Result := False;
  End;

  Procedure FromInt64;
  Var
    i: Int64;
  Begin
    Case ObjectGetType(obj) Of
      stInt:
      Begin
        TValue.Make(Nil, TypeInfo, Value);
        TValueData(Value).FAsSInt64 := obj.AsInteger;
        Result := True;
      End;
      stString:
      Begin
        If TryStrToInt64(obj.AsString, i) Then
        Begin
          TValue.Make(Nil, TypeInfo, Value);
          TValueData(Value).FAsSInt64 := i;
          Result := True;
        End
        Else
          Result := False;
      End;
    Else
      Result := False;
    End;
  End;

  Procedure FromInt(Const obj: ISuperObject);
  Var
    TypeData: PTypeData;
    i: Integer;
    o: ISuperObject;
  Begin
    Case ObjectGetType(obj) Of
      stInt, stBoolean:
      Begin
        i := obj.AsInteger;
        TypeData := GetTypeData(TypeInfo);
        Result := (i >= TypeData.MinValue) And (i <= TypeData.MaxValue);
        If Result Then
          TValue.Make(@i, TypeInfo, Value);
      End;
      stString:
      Begin
        o := SO(obj.AsString);
        If Not ObjectIsType(o, stString) Then
          FromInt(o) Else
          Result := False;
      End;
    Else
      Result := False;
    End;
  End;

  Procedure fromSet;
  Begin
    If ObjectIsType(obj, stInt) Then
    Begin
      TValue.Make(Nil, TypeInfo, Value);
      TValueData(Value).FAsSLong := obj.AsInteger;
      Result := True;
    End
    Else
      Result := False;
  End;

  Procedure FromFloat(Const obj: ISuperObject);
  Var
    o: ISuperObject;
  Begin
    Case ObjectGetType(obj) Of
      stInt, stDouble, stCurrency:
      Begin
        TValue.Make(Nil, TypeInfo, Value);
        Case GetTypeData(TypeInfo).FloatType Of
          ftSingle:
            TValueData(Value).FAsSingle := obj.AsDouble;
          ftDouble:
            TValueData(Value).FAsDouble := obj.AsDouble;
          ftExtended:
            TValueData(Value).FAsExtended := obj.AsDouble;
          ftComp:
            TValueData(Value).FAsSInt64 := obj.AsInteger;
          ftCurr:
            TValueData(Value).FAsCurr := obj.AsCurrency;
        End;
        Result := True;
      End;
      stString:
      Begin
        o := SO(obj.AsString);
        If Not ObjectIsType(o, stString) Then
          FromFloat(o) Else
          Result := False;
      End
    Else
      Result := False;
    End;
  End;

  Procedure FromString;
  Begin
    Case ObjectGetType(obj) Of
      stObject, stArray:
        Result := False;
      stnull:
      Begin
        Value := '';
        Result := True;
      End;
    Else
      Value := obj.AsString;
      Result := True;
    End;
  End;

  Procedure FromClass;
  Var
    f: TRttiField;
    v: TValue;
  Begin
    Case ObjectGetType(obj) Of
      stObject:
      Begin
        Result := True;
        If Value.Kind <> tkClass Then
          Value := GetTypeData(TypeInfo).ClassType.Create;
        For f In Context.GetType(Value.AsObject.ClassType).GetFields Do
          If f.FieldType <> Nil Then
          Begin
            Result := FromJson(f.FieldType.Handle, GetFieldDefault(f, obj.AsObject[GetFieldName(f)]), v);
            If Result Then
              f.SetValue(Value.AsObject, v) Else
              Exit;
          End;
      End;
      stNull:
      Begin
        Value := Nil;
        Result := True;
      End
    Else
      // error
      Value := Nil;
      Result := False;
    End;
  End;

  Procedure FromRecord;
  Var
    f: TRttiField;
    p: Pointer;
    v: TValue;
  Begin
    Result := True;
    TValue.Make(Nil, TypeInfo, Value);
    For f In Context.GetType(TypeInfo).GetFields Do
    Begin
      If ObjectIsType(obj, stObject) And (f.FieldType <> Nil) Then
      Begin
        p := IValueData(TValueData(Value).FHeapData).GetReferenceToRawData;
        Result := FromJson(f.FieldType.Handle, GetFieldDefault(f, obj.AsObject[GetFieldName(f)]), v);
        If Result Then
          f.SetValue(p, v) Else
          Exit;
      End
      Else
      Begin
        Result := False;
        Exit;
      End;
    End;
  End;

  Procedure FromDynArray;
  Var
    i: Integer;
    p: Pointer;
    pb: PByte;
    val: TValue;
    typ: PTypeData;
    el: PTypeInfo;
  Begin
    Case ObjectGetType(obj) Of
      stArray:
      Begin
        i := obj.AsArray.Length;
        p := Nil;
        DynArraySetLength(p, TypeInfo, 1, @i);
        pb := p;
        typ := GetTypeData(TypeInfo);
        If typ.elType <> Nil Then
          el := typ.elType^ Else
          el := typ.elType2^;

        Result := True;
        For i := 0 To i - 1 Do
        Begin
          Result := FromJson(el, obj.AsArray[i], val);
          If Not Result Then
            Break;
          val.ExtractRawData(pb);
          val := TValue.Empty;
          Inc(pb, typ.elSize);
        End;
        If Result Then
          TValue.MakeWithoutCopy(@p, TypeInfo, Value) Else
          DynArrayClear(p, TypeInfo);
      End;
      stNull:
      Begin
        TValue.MakeWithoutCopy(Nil, TypeInfo, Value);
        Result := True;
      End;
    Else
      i := 1;
      p := Nil;
      DynArraySetLength(p, TypeInfo, 1, @i);
      pb := p;
      typ := GetTypeData(TypeInfo);
      If typ.elType <> Nil Then
        el := typ.elType^ Else
        el := typ.elType2^;

      Result := FromJson(el, obj, val);
      val.ExtractRawData(pb);
      val := TValue.Empty;

      If Result Then
        TValue.MakeWithoutCopy(@p, TypeInfo, Value) Else
        DynArrayClear(p, TypeInfo);
    End;
  End;

  Procedure FromArray;
  Var
    ArrayData: PArrayTypeData;
    idx: Integer;
    Function ProcessDim(dim: Byte; Const o: ISuperobject): Boolean;
    Var
      i: Integer;
      v: TValue;
      a: PTypeData;
    Begin
      If ObjectIsType(o, stArray) And (ArrayData.Dims[dim-1] <> Nil) Then
      Begin
        a := @GetTypeData(ArrayData.Dims[dim-1]^).ArrayData;
        If (a.MaxValue - a.MinValue + 1) <> o.AsArray.Length Then
        Begin
          Result := False;
          Exit;
        End;
        Result := True;
        If dim = ArrayData.DimCount Then
          For i := a.MinValue To a.MaxValue Do
          Begin
            Result := FromJson(ArrayData.ElType^, o.AsArray[i], v);
            If Not Result Then
              Exit;
            Value.SetArrayElement(idx, v);
            inc(idx);
          End
        Else
          For i := a.MinValue To a.MaxValue Do
          Begin
            Result := ProcessDim(dim + 1, o.AsArray[i]);
            If Not Result Then
              Exit;
          End;
      End
      Else
        Result := False;
    End;
  Var
    i: Integer;
    v: TValue;
  Begin
    TValue.Make(Nil, TypeInfo, Value);
    ArrayData := @GetTypeData(TypeInfo).ArrayData;
    idx := 0;
    If ArrayData.DimCount = 1 Then
    Begin
      If ObjectIsType(obj, stArray) And (obj.AsArray.Length = ArrayData.ElCount) Then
      Begin
        Result := True;
        For i := 0 To ArrayData.ElCount - 1 Do
        Begin
          Result := FromJson(ArrayData.ElType^, obj.AsArray[i], v);
          If Not Result Then
            Exit;
          Value.SetArrayElement(idx, v);
          v := TValue.Empty;
          inc(idx);
        End;
      End
      Else
        Result := False;
    End
    Else
      Result := ProcessDim(1, obj);
  End;

  Procedure FromClassRef;
  Var
    r: TRttiType;
  Begin
    If ObjectIsType(obj, stString) Then
    Begin
      r := Context.FindType(obj.AsString);
      If r <> Nil Then
      Begin
        Value := TRttiInstanceType(r).MetaclassType;
        Result := True;
      End
      Else
        Result := False;
    End
    Else
      Result := False;
  End;

  Procedure FromUnknown;
  Begin
    Case ObjectGetType(obj) Of
      stBoolean:
      Begin
        Value := obj.AsBoolean;
        Result := True;
      End;
      stDouble:
      Begin
        Value := obj.AsDouble;
        Result := True;
      End;
      stCurrency:
      Begin
        Value := obj.AsCurrency;
        Result := True;
      End;
      stInt:
      Begin
        Value := obj.AsInteger;
        Result := True;
      End;
      stString:
      Begin
        Value := obj.AsString;
        Result := True;
      End
    Else
      Value := Nil;
      Result := False;
    End;
  End;

  Procedure FromInterface;
  Const soguid: TGuid = '{4B86A9E3-E094-4E5A-954A-69048B7B6327}';
  Var
    o: ISuperObject;
  Begin
    If CompareMem(@GetTypeData(TypeInfo).Guid, @soguid, SizeOf(TGUID)) Then
    Begin
      If obj <> Nil Then
        TValue.Make(@obj, TypeInfo, Value) Else
      Begin
        o := TSuperObject.Create(stNull);
        TValue.Make(@o, TypeInfo, Value);
      End;
      Result := True;
    End
    Else
      Result := False;
  End;
Var
  Serial: TSerialFromJson;
Begin
  If TypeInfo <> Nil Then
  Begin
    If Not SerialFromJson.TryGetValue(TypeInfo, Serial) Then
      Case TypeInfo.Kind Of
        tkChar:
          FromChar;
        tkInt64:
          FromInt64;
        tkEnumeration, tkInteger:
          FromInt(obj);
        tkSet:
          fromSet;
        tkFloat:
          FromFloat(obj);
        tkString, tkLString, tkUString, tkWString:
          FromString;
        tkClass:
          FromClass;
        tkMethod:
          ;
        tkWChar:
          FromWideChar;
        tkRecord:
          FromRecord;
        tkPointer:
          ;
        tkInterface:
          FromInterface;
        tkArray:
          FromArray;
        tkDynArray:
          FromDynArray;
        tkClassRef:
          FromClassRef;
      Else
        FromUnknown
      End
    Else
    Begin
      TValue.Make(Nil, TypeInfo, Value);
      Result := Serial(Self, obj, Value);
    End;
  End
  Else
    Result := False;
End;

Function TSuperRttiContext.ToJson(Var value: TValue; Const index: ISuperObject): ISuperObject;
  Procedure ToInt64;
  Begin
    Result := TSuperObject.Create(SuperInt(Value.AsInt64));
  End;

  Procedure ToChar;
  Begin
    Result := TSuperObject.Create(String(Value.AsType<AnsiChar>));
  End;

  Procedure ToInteger;
  Begin
    Result := TSuperObject.Create(TValueData(Value).FAsSLong);
  End;

  Procedure ToFloat;
  Begin
    Case Value.TypeData.FloatType Of
      ftSingle:
        Result := TSuperObject.Create(TValueData(Value).FAsSingle);
      ftDouble:
        Result := TSuperObject.Create(TValueData(Value).FAsDouble);
      ftExtended:
        Result := TSuperObject.Create(TValueData(Value).FAsExtended);
      ftComp:
        Result := TSuperObject.Create(TValueData(Value).FAsSInt64);
      ftCurr:
        Result := TSuperObject.CreateCurrency(TValueData(Value).FAsCurr);
    End;
  End;

  Procedure ToString;
  Begin
    Result := TSuperObject.Create(String(Value.AsType<String>));
  End;

  Procedure ToClass;
  Var
    o: ISuperObject;
    f: TRttiField;
    v: TValue;
  Begin
    If TValueData(Value).FAsObject <> Nil Then
    Begin
      o := index[IntToStr(Integer(Value.AsObject))];
      If o = Nil Then
      Begin
        Result := TSuperObject.Create(stObject);
        index[IntToStr(Integer(Value.AsObject))] := Result;
        For f In Context.GetType(Value.AsObject.ClassType).GetFields Do
          If f.FieldType <> Nil Then
          Begin
            v := f.GetValue(Value.AsObject);
            Result.AsObject[GetFieldName(f)] := ToJson(v, index);
          End
      End
      Else
        Result := o;
    End
    Else
      Result := Nil;
  End;

  Procedure ToWChar;
  Begin
    Result :=  TSuperObject.Create(String(Value.AsType<Widechar>));
  End;

  Procedure ToVariant;
  Begin
    Result := SO(Value.AsVariant);
  End;

  Procedure ToRecord;
  Var
    f: TRttiField;
    v: TValue;
  Begin
    Result := TSuperObject.Create(stObject);
    For f In Context.GetType(Value.TypeInfo).GetFields Do
    Begin
      v := f.GetValue(IValueData(TValueData(Value).FHeapData).GetReferenceToRawData);
      Result.AsObject[GetFieldName(f)] := ToJson(v, index);
    End;
  End;

  Procedure ToArray;
  Var
    idx: Integer;
    ArrayData: PArrayTypeData;

    Procedure ProcessDim(dim: Byte; Const o: ISuperObject);
    Var
      dt: PTypeData;
      i:  Integer;
      o2: ISuperObject;
      v:  TValue;
    Begin
      If ArrayData.Dims[dim-1] = Nil Then
        Exit;
      dt := GetTypeData(ArrayData.Dims[dim-1]^);
      If Dim = ArrayData.DimCount Then
        For i := dt.MinValue To dt.MaxValue Do
        Begin
          v := Value.GetArrayElement(idx);
          o.AsArray.Add(toJSon(v, index));
          inc(idx);
        End
      Else
        For i := dt.MinValue To dt.MaxValue Do
        Begin
          o2 := TSuperObject.Create(stArray);
          o.AsArray.Add(o2);
          ProcessDim(dim + 1, o2);
        End;
    End;
  Var
    i: Integer;
    v: TValue;
  Begin
    Result := TSuperObject.Create(stArray);
    ArrayData := @Value.TypeData.ArrayData;
    idx := 0;
    If ArrayData.DimCount = 1 Then
      For i := 0 To ArrayData.ElCount - 1 Do
      Begin
        v := Value.GetArrayElement(i);
        Result.AsArray.Add(toJSon(v, index))
      End
    Else
      ProcessDim(1, Result);
  End;

  Procedure ToDynArray;
  Var
    i: Integer;
    v: TValue;
  Begin
    Result := TSuperObject.Create(stArray);
    For i := 0 To Value.GetArrayLength - 1 Do
    Begin
      v := Value.GetArrayElement(i);
      Result.AsArray.Add(toJSon(v, index));
    End;
  End;

  Procedure ToClassRef;
  Begin
    If TValueData(Value).FAsClass <> Nil Then
      Result :=  TSuperObject.Create(String(
        TValueData(Value).FAsClass.UnitName + '.' +
        TValueData(Value).FAsClass.ClassName)) Else
      Result := Nil;
  End;

  Procedure ToInterface;
  Begin
    If TValueData(Value).FHeapData <> Nil Then
      TValueData(Value).FHeapData.QueryInterface(ISuperObject, Result) Else
      Result := Nil;
  End;

Var
  Serial: TSerialToJson;
Begin
  If Not SerialToJson.TryGetValue(value.TypeInfo, Serial) Then
    Case Value.Kind Of
      tkInt64:
        ToInt64;
      tkChar:
        ToChar;
      tkSet, tkInteger, tkEnumeration:
        ToInteger;
      tkFloat:
        ToFloat;
      tkString, tkLString, tkUString, tkWString:
        ToString;
      tkClass:
        ToClass;
      tkWChar:
        ToWChar;
      tkVariant:
        ToVariant;
      tkRecord:
        ToRecord;
      tkArray:
        ToArray;
      tkDynArray:
        ToDynArray;
      tkClassRef:
        ToClassRef;
      tkInterface:
        ToInterface;
    Else
      result := Nil;
    End
  Else
    Result := Serial(Self, value, index);
End;

{ TSuperObjectHelper }

Constructor TSuperObjectHelper.FromJson(Const obj: ISuperObject; ctx: TSuperRttiContext = Nil);
Var
  v: TValue;
  ctxowned: Boolean;
Begin
  If ctx = Nil Then
  Begin
    ctx := TSuperRttiContext.Create;
    ctxowned := True;
  End
  Else
    ctxowned := False;
  Try
    v := Self;
    If Not ctx.FromJson(v.TypeInfo, obj, v) Then
      Raise Exception.Create('Invalid object');
  Finally
    If ctxowned Then
      ctx.Free;
  End;
End;

Constructor TSuperObjectHelper.FromJson(Const str: String; ctx: TSuperRttiContext = Nil);
Begin
  FromJson(SO(str), ctx);
End;

Function TSuperObjectHelper.ToJson(ctx: TSuperRttiContext = Nil): ISuperObject;
Var
  v: TValue;
  ctxowned: Boolean;
Begin
  If ctx = Nil Then
  Begin
    ctx := TSuperRttiContext.Create;
    ctxowned := True;
  End
  Else
    ctxowned := False;
  Try
    v := Self;
    Result := ctx.ToJson(v, SO);
  Finally
    If ctxowned Then
      ctx.Free;
  End;
End;

{$EndIf}

{$IfDef DEBUG}
Initialization

Finalization
  Assert(debugcount = 0, 'Memory leak');
{$EndIf}

End.
