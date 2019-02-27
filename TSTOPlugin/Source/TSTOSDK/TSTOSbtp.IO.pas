unit TSTOSbtp.IO;

interface

Uses Windows, Classes, SysUtils, HsInterfaceEx, HsStreamEx, TSTOSbtpIntf;

Type
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
