unit TSTOSbtpIntf;

interface

Uses Windows, Classes, SysUtils, HsInterfaceEx, HsStreamEx;

Type
  ISbtpSubVariable = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-ACC5-11ABFE2E8AE6}']
    Function  GetVariableName() : String;
    Procedure SetVariableName(Const AVariableName : String);

    Function  GetVariableData() : String;
    Procedure SetVariableData(Const AVariableData : String);

    Procedure Assign(ASource : IInterface);

    Property VariableName : String Read GetVariableName Write SetVariableName;
    Property VariableData : String Read GetVariableData Write SetVariableData;

  End;

  ISbtpSubVariables = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-AD16-759EDCAAB9C2}']
    Function  Get(Index : Integer) : ISbtpSubVariable;
    Procedure Put(Index : Integer; Const Item : ISbtpSubVariable);

    Function Add() : ISbtpSubVariable; OverLoad;
    Function Add(Const AItem : ISbtpSubVariable) : Integer; OverLoad;

    Procedure Assign(ASource : IInterface);
    Function IndexOf(Const AVariableName : String) : Integer;

    Property Items[Index : Integer] : ISbtpSubVariable Read Get Write Put; Default;

  End;

  ISbtpVariable = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-A664-5C2711E17303}']
    Function  GetVariableType() : String;
    Procedure SetVariableType(Const AVariableType : String);

    Function  GetNbSubItems() : DWord;

    Function  GetSubItem() : ISbtpSubVariables;

    Procedure Assign(ASource : IInterface);

    Property VariableType : String            Read GetVariableType Write SetVariableType;
    Property NbSubItems   : DWord             Read GetNbSubItems;
    Property SubItem      : ISbtpSubVariables Read GetSubItem;

  End;

  ISbtpVariables = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-A002-6CC05ECF025D}']
    Function  Get(Index : Integer) : ISbtpVariable;
    Procedure Put(Index : Integer; Const Item : ISbtpVariable);

    Function Add() : ISbtpVariable; OverLoad;
    Function Add(Const AItem : ISbtpVariable) : Integer; OverLoad;

    Procedure Assign(ASource : IInterface);
    Function IndexOf(Const AVariableType : String) : Integer;

    Property Items[Index : Integer] : ISbtpVariable Read Get Write Put; Default;

  End;

  ISbtpHeader = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-8457-61895A539B6F}']
    Function  GetHeader() : String;
    Procedure SetHeader(Const AHeader : String);

    Function  GetHeaderPadding() : Word;
    Procedure SetHeaderPadding(Const AHeaderPadding : Word);

    Procedure Assign(ASource : IInterface);
    Procedure Clear();
    
    Property Header        : String Read GetHeader        Write SetHeader;
    Property HeaderPadding : Word   Read GetHeaderPadding Write SetHeaderPadding;

  End;

  ISbtpFile = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-9796-5A92D84911C9}']
    Function  GetHeader() : ISbtpHeader;

    Function  GetItem() : ISbtpVariables;

    Procedure Assign(ASource : IInterface);

    Property Header : ISbtpHeader    Read GetHeader;
    Property Item   : ISbtpVariables Read GetItem;

  End;

  ISbtpFiles = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-E2F1-6CC05ECFA599}']
    Function  Get(Index : Integer) : ISbtpFile;
    Procedure Put(Index : Integer; Const Item : ISbtpFile);

    Function Add() : ISbtpFile; OverLoad;
    Function Add(Const AItem : ISbtpFile) : Integer; OverLoad;

    Procedure Assign(ASource : IInterface);

    Property Items[Index : Integer] : ISbtpFile Read Get Write Put; Default;

  End;

(******************************************************************************)

  ISbtpSubVariableIO = Interface(ISbtpSubVariable)
    ['{4B61686E-29A0-2112-B781-30B4271D1B0B}']
    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

    Property OnChange : TNotifyEvent Read GetOnChange Write SetOnChange;

  End;

  ISbtpSubVariablesIO = Interface(ISbtpSubVariables)
    ['{4B61686E-29A0-2112-A240-2C35BECC3662}']
    Function  Get(Index : Integer) : ISbtpSubVariableIO;
    Procedure Put(Index : Integer; Const Item : ISbtpSubVariableIO);

    Function Add() : ISbtpSubVariableIO; OverLoad;
    Function Add(Const AItem : ISbtpSubVariableIO) : Integer; OverLoad;
    Function Remove(Const AItem : ISbtpSubVariableIO) : Integer;

    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

    Property Items[Index : Integer] : ISbtpSubVariableIO Read Get Write Put; Default;

    Property OnChange : TNotifyEvent Read GetOnChange Write SetOnChange;

  End;

  ISbtpVariableIO = Interface(ISbtpVariable)
    ['{4B61686E-29A0-2112-9654-566023E64148}']
    Function  GetSubItem() : ISbtpSubVariablesIO;

    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

    Property SubItem : ISbtpSubVariablesIO Read GetSubItem;

    Property OnChange : TNotifyEvent Read GetOnChange Write SetOnChange;

  End;

  ISbtpVariablesIO = Interface(ISbtpVariables)
    ['{4B61686E-29A0-2112-8136-3CBFD2DF07A4}']
    Function  Get(Index : Integer) : ISbtpVariableIO;
    Procedure Put(Index : Integer; Const Item : ISbtpVariableIO);

    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

    Function Add() : ISbtpVariableIO; OverLoad;
    Function Add(Const AItem : ISbtpVariableIO) : Integer; OverLoad;
    Function Remove(Const Item : ISbtpVariableIO) : Integer;

    Procedure Assign(ASource : IInterface);
    Function IndexOf(Const AVariableType : String) : Integer;

    Property Items[Index : Integer] : ISbtpVariableIO Read Get Write Put; Default;

    Property OnChange : TNotifyEvent Read GetOnChange Write SetOnChange;

  End;

  ISbtpHeaderIO = interface(ISbtpHeader)
    ['{4B61686E-29A0-2112-B74D-BF2C6BCF70D6}']
  End;

  ISbtpFileIO = Interface(ISbtpFile)
    ['{4B61686E-29A0-2112-BCA3-54C93B307A67}']
    Function  GetHeader() : ISbtpHeaderIO;

    Function  GetItem() : ISbtpVariablesIO;

    Function  GetAsXml() : String;
    Procedure SetAsXml(Const AXmlString : String);

    Function  GetAsJSon() : String;
    Procedure SetAsJSon(Const AJSonString : String);

    Function  GetModified() : Boolean;

    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

    Procedure LoadFromXml(Const AFileName : String);
    Procedure LoadFromJSon(Const AFileName : String);
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure LoadFromFile(Const AFileName : String);

    Procedure SaveToXml(Const AFileName : String);
    Procedure SaveToJSon(Const AFileName : String);
    Procedure SaveToStream(ATarget : IStreamEx);
    Procedure SaveToFile(Const AFileName : String);

    Property AsXml  : String Read GetAsXml  Write SetAsXml;
    Property AsJSon : String Read GetAsJSon Write SetAsJSon;

    Property Header   : ISbtpHeaderIO    Read GetHeader;
    Property Item     : ISbtpVariablesIO Read GetItem;
    property Modified : Boolean          Read GetModified;

    Property OnChange : TNotifyEvent Read GetOnChange Write SetOnChange;

  End;

  ISbtpFilesIO = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-ABE5-85C7675F5247}']
    Function  Get(Index : Integer) : ISbtpFileIO;
    Procedure Put(Index : Integer; Const Item : ISbtpFileIO);

    Function Add() : ISbtpFileIO; OverLoad;
    Function Add(Const AItem : ISbtpFileIO) : Integer; OverLoad;
    Function Remove(Const AItem : ISbtpFileIO) : Integer;

    Function  GetAsXml() : String;
    Procedure SetAsXml(Const AXmlString : String);

    Function  GetModified() : Boolean;

    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);
    Procedure ForceChanged();
    Procedure ClearChanges();

    Procedure LoadFromXml(Const AFileName : String);
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure LoadFromFile(Const AFileName : String);

    Procedure SaveToXml(Const AFileName : String);
    Procedure SaveToStream(ATarget : IStreamEx);
    Procedure SaveToFile(Const AFileName : String);

    Property Items[Index : Integer] : ISbtpFileIO Read Get Write Put; Default;

    Property AsXml    : String  Read GetAsXml Write SetAsXml;
    Property Modified : Boolean Read GetModified;

    Property OnChange : TNotifyEvent Read GetOnChange Write SetOnChange;

  End;

implementation

end.
