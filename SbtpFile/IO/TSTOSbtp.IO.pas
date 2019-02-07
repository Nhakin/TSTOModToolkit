unit TSTOSbtp.IO;

interface

Uses Classes, HsXmlDocEx, HsInterfaceEx, HsStreamEx, TSTOSbtpIntf;

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

  TSbtpFileIO = Class(TObject)
  Public
    Class Function CreateSbtpFile() : ISbtpFileIO;
    Class Function LoadBinSbtpFile(Const AFileName : String) : ISbtpFileIO; OverLoad;
    Class Function LoadBinSbtpFile(AStream : IStreamEx) : ISbtpFileIO; OverLoad;
    Class Function LoadXmlSbtpFile(Const AFileName : String) : ISbtpFileIO; OverLoad;
    Class Function LoadXmlSbtpFile(AXmlDocument : IXmlDocumentEx) : ISbtpFileIO; OverLoad;

  End;

  TSbtpFilesIO = Class(TObject)
  Public
    Class Function CreateSbtpFiles() : ISbtpFilesIO;
    Class Function LoadBinSbtpFiles(Const AFileName : String) : ISbtpFilesIO; OverLoad;
    Class Function LoadBinSbtpFiles(AStream : IStreamEx) : ISbtpFilesIO; OverLoad;
    Class Function LoadXmlSbtpFiles(Const AFileName : String) : ISbtpFilesIO; OverLoad;
    Class Function LoadXmlSbtpFiles(AXmlDocument : IXmlDocumentEx) : ISbtpFilesIO; OverLoad;

  End;

implementation

Uses SysUtils, Dialogs,
  TSTOSbtpImpl, TSTOSbtp.Bin, TSTOSbtp.Xml, TSTOSbtpEx.JSon;

Type
  TImplementorType = (itRaw, itBin, itXml, itJSon);

  TSbtpHeaderIO = Class(TSbtpHeader, ISbtpHeaderIO)

  End;

  TSbtpSubVariableIO = Class(TSbtpSubVariable, ISbtpSubVariableIO)
  Private
    FOnChange : TNotifyEvent;

  Protected
    Procedure SetVariableName(Const AVariableName : String); OverRide;
    Procedure SetVariableData(Const AVariableData : String); OverRide;

    Procedure DoOnChange(Sender : TObject);
    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

  End;

  TSbtpSubVariablesIO = Class(TSbtpSubVariables, ISbtpSubVariablesIO)
  Private
    FOnChange : TNotifyEvent;

  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;

    Function  Get(Index : Integer) : ISbtpSubVariableIO;
    Procedure Put(Index : Integer; Const Item : ISbtpSubVariableIO);

    Function Add() : ISbtpSubVariableIO; OverLoad;
    Function Add(Const AItem : ISbtpSubVariableIO) : Integer; OverLoad;
    Function Remove(Const AItem : ISbtpSubVariableIO) : Integer;

    Procedure DoOnChange(Sender : TObject);
    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

    Procedure Assign(ASource : IInterface); OverRide;

  End;

  TSbtpVariableIO = Class(TSbtpVariable, ISbtpVariableIO)
  Private
    FOnChange : TNotifyEvent;

  Protected
    Function GetSubItemClass() : TSbtpSubVariablesClass; OverRide;

    Procedure SetVariableType(Const AVariableType : String); OverRide;
    Function  GetSubItem() : ISbtpSubVariablesIO;

    Procedure DoOnChange(Sender : TObject);
    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TSbtpVariablesIO = Class(TSbtpVariables, ISbtpVariablesIO)
  Private
    FOnChange : TNotifyEvent;

  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;

    Function  Get(Index : Integer) : ISbtpVariableIO;
    Procedure Put(Index : Integer; Const Item : ISbtpVariableIO);

    Function Add() : ISbtpVariableIO; OverLoad;
    Function Add(Const AItem : ISbtpVariableIO) : Integer; OverLoad;
    Function Remove(Const Item : ISbtpVariableIO) : Integer; OverLoad;

    Procedure DoOnChange(Sender : TObject);
    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

    Procedure Assign(ASource : IInterface); OverRide;

  End;

  TSbtpFileIOImpl = Class(TSbtpFile, ISbtpFileIO,
    IBinSbtpFile, IXmlSbtpFile, IJSonSbtpFile)
  Private
    FBinImpl  : IBinSbtpFile;
    FXmlImpl  : IXmlSbtpFile;
    FJSonImpl : IJSonSbtpFile;

    FOnChange : TNotifyEvent;
    FModified : Boolean;

    Procedure SwitchImplementor();
    Function GetBinImplementor() : IBinSbtpFile;
    Function GetXmlImplementor() : IXmlSbtpFile;
    Function GetJSonImplementor() : IJSonSbtpFile;

  Protected
    Property BinImpl  : IBinSbtpFile  Read GetBinImplementor Implements IBinSbtpFile;
    Property XmlImpl  : IXmlSbtpFile  Read GetXmlImplementor Implements IXmlSbtpFile;
    Property JSonImpl : IJSonSbtpFile Read GetJSonImplementor Implements IJSonSbtpFile;

    Function  GetHeaderClass() : TSbtpHeaderClass; OverRide;
    Function  GetItemClass() : TSbtpVariablesClass; OverRide;

    Function  GetHeader() : ISbtpHeaderIO;
    Function  GetItem() : ISbtpVariablesIO;

    Function  GetAsXml() : String;
    Procedure SetAsXml(Const AXmlString : String);

    Function  GetAsJSon() : String;
    Procedure SetAsJSon(Const AJSonString : String);

    Function  GetModified() : Boolean;
    Procedure DoOnChange(Sender : TObject);
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

  Public
    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;

  End;

  TSbtpFilesIOImpl =  Class(TSbtpFiles, ISbtpFilesIO, IBinSbtpFiles, IXmlSbtpFiles)
  Private
    FBinImpl : IBinSbtpFiles;
    FXmlImpl : IXmlSbtpFiles;

    FModified : Boolean;
    FOnChange : TNotifyEvent;

    Function GetBinImplementor() : IBinSbtpFiles;
    Function GetXmlImplementor() : IXmlSbtpFiles;

  Protected
    Property BinImpl : IBinSbtpFiles Read GetBinImplementor Implements IBinSbtpFiles;
    Property XmlImpl : IXmlSbtpFiles Read GetXmlImplementor Implements IXmlSbtpFiles;

    Function GetItemClass() : TInterfacedObjectExClass; OverRide;

    Function  Get(Index : Integer) : ISbtpFileIO; OverLoad;
    Procedure Put(Index : Integer; Const Item : ISbtpFileIO); OverLoad;

    Function Add() : ISbtpFileIO; OverLoad;
    Function Add(Const AItem : ISbtpFileIO) : Integer; OverLoad;
    Function Remove(Const AItem : ISbtpFileIO) : Integer;

    Function  GetAsXml() : String;
    Procedure SetAsXml(Const AXmlString : String);

    Function  GetModified() : Boolean;

    Procedure DoOnChange(Sender : TObject);
    Procedure ForceChanged();
    Procedure ClearChanges();
    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

    Procedure LoadFromXml(Const AFileName : String);
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure LoadFromFile(Const AFileName : String);

    Procedure SaveToXml(Const AFileName : String);
    Procedure SaveToStream(ATarget : IStreamEx);
    Procedure SaveToFile(Const AFileName : String);

    Procedure Assign(ASource : IInterface); OverRide;

  End;

Class Function TSbtpFileIO.CreateSbtpFile() : ISbtpFileIO;
Begin
  Result := TSbtpFileIOImpl.Create();
End;

Class Function TSbtpFileIO.LoadBinSbtpFile(Const AFileName : String) : ISbtpFileIO;
Begin
  Result := TSbtpFileIOImpl.Create();
  Result.LoadFromFile(AFileName);
End;

Class Function TSbtpFileIO.LoadBinSbtpFile(AStream : IStreamEx) : ISbtpFileIO;
Begin
  Result := TSbtpFileIOImpl.Create();
  Result.LoadFromStream(AStream);
End;

Class Function TSbtpFileIO.LoadXmlSbtpFile(Const AFileName : String) : ISbtpFileIO;
Begin
  Result := TSbtpFileIOImpl.Create();
  Result.LoadFromXml(AFileName);
End;

Class Function TSbtpFileIO.LoadXmlSbtpFile(AXmlDocument : IXmlDocumentEx) : ISbtpFileIO;
Begin
  Result := TSbtpFileIOImpl.Create();
  Result.AsXml := AXmlDocument.Xml.Text;
End;

Class Function TSbtpFilesIO.CreateSbtpFiles() : ISbtpFilesIO;
Begin
  Result := TSbtpFilesIOImpl.Create();
End;

Class Function TSbtpFilesIO.LoadBinSbtpFiles(Const AFileName : String) : ISbtpFilesIO;
Begin
  Result := TSbtpFilesIOImpl.Create();
  Result.LoadFromFile(AFileName);
End;

Class Function TSbtpFilesIO.LoadBinSbtpFiles(AStream : IStreamEx) : ISbtpFilesIO;
Begin
  Result := TSbtpFilesIOImpl.Create();
  Result.LoadFromStream(AStream);
End;

Class Function TSbtpFilesIO.LoadXmlSbtpFiles(Const AFileName : String) : ISbtpFilesIO;
Begin
  Result := TSbtpFilesIOImpl.Create();
  Result.LoadFromXml(AFileName);
End;

Class Function TSbtpFilesIO.LoadXmlSbtpFiles(AXmlDocument : IXmlDocumentEx) : ISbtpFilesIO;
Begin
  Result := TSbtpFilesIOImpl.Create();
  Result.AsXml := AXmlDocument.Xml.Text;
End;

(******************************************************************************)

Procedure TSbtpSubVariableIO.SetVariableName(Const AVariableName : String);
Begin
  If GetVariableName() <> AVariableName Then
  Begin
    InHerited SetVariableName(AVariableName);

    DoOnChange(Self);
  End;
End;

Procedure TSbtpSubVariableIO.SetVariableData(Const AVariableData : String);
Begin
  If GetVariableData() <> AVariableData Then
  Begin
    InHerited SetVariableData(AVariableData);

    DoOnChange(Self);
  End;
End;

Procedure TSbtpSubVariableIO.DoOnChange(Sender : TObject);
Begin
  If Assigned(FOnChange) Then
    FOnChange(Sender);
End;

Function TSbtpSubVariableIO.GetOnChange() : TNotifyEvent;
Begin
  Result := FOnChange;
End;

Procedure TSbtpSubVariableIO.SetOnChange(AOnChange : TNotifyEvent);
Begin
  FOnChange := AOnChange;
End;

Function TSbtpSubVariablesIO.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TSbtpSubVariableIO;
End;

Procedure TSbtpSubVariablesIO.Assign(ASource : IInterface);
Var X : Integer;
Begin
  InHerited Assign(ASource);

  For X := 0 To Count - 1 Do
    Get(X).OnChange := DoOnChange;
End;

Function TSbtpSubVariablesIO.Get(Index : Integer) : ISbtpSubVariableIO;
Begin
  Result := InHerited Get(Index) As ISbtpSubVariableIO;
End;

Procedure TSbtpSubVariablesIO.Put(Index : Integer; Const Item : ISbtpSubVariableIO);
Begin
  InHerited Put(Index, Item);
End;

Function TSbtpSubVariablesIO.Add() : ISbtpSubVariableIO;
Begin
  Result := InHerited Add() As ISbtpSubVariableIO;
  Result.OnChange := DoOnChange;
  DoOnChange(Self);
End;

Function TSbtpSubVariablesIO.Add(Const AItem : ISbtpSubVariableIO) : Integer;
Begin
  Result := InHerited Add(AItem);
  AItem.OnChange := DoOnChange;
  DoOnChange(Self);
End;

Function TSbtpSubVariablesIO.Remove(Const AItem : ISbtpSubVariableIO) : Integer;
Begin
  Result := InHerited Remove(AItem As IInterfaceEx);
  DoOnChange(Self);
End;

Procedure TSbtpSubVariablesIO.DoOnChange(Sender : TObject);
Begin
  If Assigned(FOnChange) Then
    FOnChange(Sender);
End;

Function TSbtpSubVariablesIO.GetOnChange() : TNotifyEvent;
Begin
  Result := FOnChange;
End;

Procedure TSbtpSubVariablesIO.SetOnChange(AOnChange : TNotifyEvent);
Begin
  FOnChange := AOnChange;
End;

Procedure TSbtpVariableIO.AfterConstruction();
Begin
  InHerited AfterConstruction();
  GetSubItem().OnChange := DoOnChange;
End;

Function TSbtpVariableIO.GetSubItemClass() : TSbtpSubVariablesClass;
Begin
  Result := TSbtpSubVariablesIO;
End;

Procedure TSbtpVariableIO.SetVariableType(Const AVariableType : String);
Begin
  If GetVariableType() <> AVariableType Then
  Begin
    InHerited SetVariableType(AVariableType);

    DoOnChange(Self);
  End;
End;

Function TSbtpVariableIO.GetSubItem() : ISbtpSubVariablesIO;
Begin
  Result := InHerited GetSubItem() As ISbtpSubVariablesIO;
End;

Procedure TSbtpVariableIO.DoOnChange(Sender : TObject);
Begin
  If Assigned(FOnChange) Then
    FOnChange(Sender);
End;

Function TSbtpVariableIO.GetOnChange() : TNotifyEvent;
Begin
  Result := FOnChange;
End;

Procedure TSbtpVariableIO.SetOnChange(AOnChange : TNotifyEvent);
Begin
  FOnChange := AOnChange;
End;

Function TSbtpVariablesIO.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TSbtpVariableIO;
End;

Procedure TSbtpVariablesIO.Assign(ASource : IInterface);
Var X : Integer;
Begin
  InHerited Assign(ASource);

  For X := 0 To Count - 1 Do
    Get(X).OnChange := DoOnChange;
End;

Function TSbtpVariablesIO.Get(Index : Integer) : ISbtpVariableIO;
Begin
  Result := InHerited Get(Index) as ISbtpVariableIO;
End;

Procedure TSbtpVariablesIO.Put(Index : Integer; Const Item : ISbtpVariableIO);
Begin
  InHerited Put(Index, Item);
End;

Function TSbtpVariablesIO.Add() : ISbtpVariableIO;
Begin
  Result := InHerited Add() As ISbtpVariableIO;
  Result.OnChange := DoOnChange;
  DoOnChange(Self);
End;

Function TSbtpVariablesIO.Add(Const AItem : ISbtpVariableIO) : Integer;
Begin
  Result := InHerited Add(AItem);
  AItem.OnChange := DoOnChange;
  DoOnChange(Self);
End;

Function TSbtpVariablesIO.Remove(Const Item : ISbtpVariableIO) : Integer;
Begin
  Result := InHerited Remove(Item As IInterfaceEx);
  DoOnChange(Self);
End;

Procedure TSbtpVariablesIO.DoOnChange(Sender : TObject);
Begin
  If Assigned(FOnChange) Then
    FOnChange(Sender);
End;

Function TSbtpVariablesIO.GetOnChange() : TNotifyEvent;
Begin
  Result := FOnChange;
End;

Procedure TSbtpVariablesIO.SetOnChange(AOnChange : TNotifyEvent);
Begin
  FOnChange := AOnChange;
End;

Procedure TSbtpFileIOImpl.AfterConstruction();
Begin
  InHerited AfterConstruction();

  GetItem().OnChange := DoOnChange;

  FModified := False;
End;

Procedure TSbtpFileIOImpl.BeforeDestruction();
Begin
  FXmlImpl  := Nil;
  FJSonImpl := Nil;
  FBinImpl  := Nil;

  InHerited BeforeDestruction();
End;

Function TSbtpFileIOImpl.GetHeaderClass() : TSbtpHeaderClass;
Begin
  Result := TSbtpHeaderIO;
End;

Function TSbtpFileIOImpl.GetItemClass() : TSbtpVariablesClass;
Begin
  Result := TSbtpVariablesIO;
End;

Function TSbtpFileIOImpl.GetHeader() : ISbtpHeaderIO;
Begin
  Result := InHerited GetHeader() As ISbtpHeaderIO;
End;

Function TSbtpFileIOImpl.GetItem() : ISbtpVariablesIO;
Begin
  Result := InHerited GetItem() As ISbtpVariablesIO;
End;

Procedure TSbtpFileIOImpl.SwitchImplementor();
Begin
  If Assigned(FXmlImpl) Then
  Begin
    Assign(FXmlImpl);
    FXmlImpl := Nil;
  End;

  If Assigned(FJSonImpl) Then
  Begin
    Assign(FJSonImpl);
    FJSonImpl := Nil;
  End;
End;

Function TSbtpFileIOImpl.GetBinImplementor() : IBinSbtpFile;
Begin
  FBinImpl := TBinSbtpFile.CreateSbtpFile();
  FBinImpl.Assign(Self);

  Result := FBinImpl;
End;

Function TSbtpFileIOImpl.GetXmlImplementor() : IXmlSbtpFile;
Begin
  SwitchImplementor();
  FXmlImpl := TXmlSbtpFile.CreateSbtpFile();
  FXmlImpl.Assign(Self);
//  FXmlImpl._Release();

  Result := FXmlImpl;
End;

Function TSbtpFileIOImpl.GetJSonImplementor() : IJSonSbtpFile;
Begin
  SwitchImplementor();
  FJSonImpl := TJSonSbtpFile.CreateSbtpFile();
  FJSonImpl.Assign(Self);
//  FJSonImpl._Release();

  Result := FJSonImpl;
End;

Function TSbtpFileIOImpl.GetAsXml() : String;
Begin
  Result := FormatXmlData(XmlImpl.Xml);
End;

Procedure TSbtpFileIOImpl.SetAsXml(Const AXmlString : String);
Begin
  FXmlImpl := TXmlSbtpFile.CreateSbtpFile(AXmlString);
  Try
    Assign(FXmlImpl);

    Finally
      FXmlImpl := Nil;
  End;
End;

Function TSbtpFileIOImpl.GetAsJSon() : String;
Begin
  Result := JSonImpl.AsJSon;
End;

Procedure TSbtpFileIOImpl.SetAsJSon(Const AJSonString : String);
Begin
  FJSonImpl := TJSonSbtpFile.CreateSbtpFile(AJSonString);
  Try
    Assign(FJSonImpl);

    Finally
      FJSonImpl := Nil;
  End;
End;

Function TSbtpFileIOImpl.GetModified() : Boolean;
Begin
  Result := FModified;
End;

Procedure TSbtpFileIOImpl.DoOnChange(Sender : TObject);
Begin
  If Assigned(FOnChange) Then
    FOnChange(Sender);
  FModified := True;
End;

Function TSbtpFileIOImpl.GetOnChange() : TNotifyEvent;
Begin
  Result := FOnChange;
End;

Procedure TSbtpFileIOImpl.SetOnChange(AOnChange : TNotifyEvent);
Begin
  FOnChange := AOnChange;
End;

Procedure TSbtpFileIOImpl.LoadFromXml(Const AFileName : String);
Var lSStrm : IStringStreamEx;
Begin
  lSStrm := TStringStreamEx.Create();
  Try
    lSStrm.LoadFromFile(AFileName);
    SetAsXml(lSStrm.DataString);

    Finally
      lSStrm := Nil;
  End;
End;

Procedure TSbtpFileIOImpl.LoadFromJSon(Const AFileName : String);
Var lSStrm : IStringStreamEx;
Begin
  lSStrm := TStringStreamEx.Create();
  Try
    lSStrm.LoadFromFile(AFileName);
    SetAsJSon(lSStrm.DataString);

    Finally
      lSStrm := Nil;
  End;
End;

Procedure TSbtpFileIOImpl.LoadFromStream(ASource : IStreamEx);
Begin
  FBinImpl := TBinSbtpFile.CreateSbtpFile(ASource);
  Assign(FBinImpl);
End;

Procedure TSbtpFileIOImpl.LoadFromFile(Const AFileName : String);
Var lMem : IMemoryStreamEx;
Begin
  lMem := TMemoryStreamEx.Create();
  Try
    lMem.LoadFromFile(AFileName);
    LoadFromStream(lMem);

    Finally
      lMem := Nil;
  End;
End;

Procedure TSbtpFileIOImpl.SaveToXml(Const AFileName : String);
Var lSStrm : IStringStreamEx;
Begin
  lSStrm := TStringStreamEx.Create(GetAsXml());
  Try
    lSStrm.SaveToFile(AFileName);

    Finally
      lSStrm := Nil;
  End;
End;

Procedure TSbtpFileIOImpl.SaveToJSon(Const AFileName : String);
Var lSStrm : IStringStreamEx;
Begin
  lSStrm := TStringStreamEx.Create(GetAsJSon());
  Try
    lSStrm.SaveToFile(AFileName);

    Finally
      lSStrm := Nil;
  End;
End;

Procedure TSbtpFileIOImpl.SaveToStream(ATarget : IStreamEx);
Begin
  BinImpl.SaveToStream(ATarget);
End;

Procedure TSbtpFileIOImpl.SaveToFile(Const AFileName : String);
Var lMem : IMemoryStreamEx;
Begin
  lMem := TMemoryStreamEx.Create();
  Try
    SaveToStream(lMem);
    lMem.SaveToFile(AFileName);

    Finally
      lMem := Nil;
  End;
End;

Function TSbtpFilesIOImpl.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TSbtpFileIOImpl;
End;

Function TSbtpFilesIOImpl.GetBinImplementor() : IBinSbtpFiles;
Begin
  If Not Assigned(FBinImpl) Then
    FBinImpl := TBinSbtpFile.CreateSbtpFiles();
  FBinImpl.Assign(Self);

  Result := FBinImpl;
End;

Function TSbtpFilesIOImpl.GetXmlImplementor() : IXmlSbtpFiles;
Begin
  If Not Assigned(FXmlImpl) Then
    FXmlImpl := TXmlSbtpFile.CreateSbtpFiles();
  FXmlImpl.Assign(Self);

  Result := FXmlImpl;
End;

Function TSbtpFilesIOImpl.Get(Index : Integer) : ISbtpFileIO;
Begin
  Result := InHerited Items[Index] As ISbtpFileIO;
End;

Procedure TSbtpFilesIOImpl.Put(Index : Integer; Const Item : ISbtpFileIO);
Begin
  InHerited Items[Index] := Item;
End;

Function TSbtpFilesIOImpl.Add() : ISbtpFileIO;
Begin
  Result := InHerited Add() As ISbtpFileIO;
  Result.OnChange := DoOnChange;
  DoOnChange(Self);
End;

Function TSbtpFilesIOImpl.Add(Const AItem : ISbtpFileIO) : Integer;
Begin
  Result := InHerited Add(AItem);
  AItem.OnChange := DoOnChange;
  DoOnChange(Self);
End;

Function TSbtpFilesIOImpl.Remove(Const AItem : ISbtpFileIO) : Integer;
Begin
  Result := InHerited Remove(AItem As IInterfaceEx);
  DoOnChange(Self);
End;

Function TSbtpFilesIOImpl.GetAsXml() : String;
Begin
  Result := FormatXmlData(XmlImpl.Xml);
End;

Procedure TSbtpFilesIOImpl.SetAsXml(Const AXmlString : String);
Begin
  FXmlImpl := TXmlSbtpFile.CreateSbtpFiles(AXmlString);
  Assign(FXmlImpl);
End;

Function TSbtpFilesIOImpl.GetModified() : Boolean;
Begin
  Result := FModified;
End;

Procedure TSbtpFilesIOImpl.DoOnChange(Sender : TObject);
Begin
  If Assigned(FOnChange) Then
    FOnChange(Sender);
  FModified := True;
End;

Procedure TSbtpFilesIOImpl.ForceChanged();
Begin
  DoOnChange(Self);
End;

Procedure TSbtpFilesIOImpl.ClearChanges();
Begin
  FModified := False;
End;

Function TSbtpFilesIOImpl.GetOnChange() : TNotifyEvent;
Begin
  Result := FOnChange;
End;

Procedure TSbtpFilesIOImpl.SetOnChange(AOnChange : TNotifyEvent);
Begin
  FOnChange := AOnChange;
End;

Procedure TSbtpFilesIOImpl.LoadFromXml(Const AFileName : String);
Var lSStrm : IStringStreamEx;
Begin
  lSStrm := TStringStreamEx.Create();
  Try
    lSStrm.LoadFromFile(AFileName);
    SetAsXml(lSStrm.DataString);

    Finally
      lSStrm := Nil;
  End;
End;

Procedure TSbtpFilesIOImpl.LoadFromStream(ASource : IStreamEx);
Begin
  FBinImpl := TBinSbtpFile.CreateSbtpFiles();
  With KeepStreamPosition(ASource, 0) Do
    FBinImpl.LoadFromStream(ASource);
  Assign(FBinImpl);
End;

Procedure TSbtpFilesIOImpl.LoadFromFile(Const AFileName : String);
Var lMem : IMemoryStreamEx;
Begin
  lMem := TMemoryStreamEx.Create();
  Try
    lMem.LoadFromFile(AFileName);
    LoadFromStream(lMem);

    Finally
      lMem := Nil;
  End;
End;

Procedure TSbtpFilesIOImpl.SaveToXml(Const AFileName : String);
Var lSStrm : IStringStreamEx;
Begin
  lSStrm := TStringStreamEx.Create(GetAsXml());
  Try
    lSStrm.SaveToFile(AFileName);

    Finally
      lSStrm := Nil;
  End;
End;

Procedure TSbtpFilesIOImpl.SaveToStream(ATarget : IStreamEx);
Begin
  BinImpl.SaveToStream(ATarget);
End;

Procedure TSbtpFilesIOImpl.SaveToFile(Const AFileName : String);
Var lMem : IMemoryStreamEx;
Begin
  lMem := TMemoryStreamEx.Create();
  Try
    SaveToStream(lMem);
    lMem.SaveToFile(AFileName);

    Finally
      lMem := Nil;
  End;
End;

Procedure TSbtpFilesIOImpl.Assign(ASource : IInterface);
Var X : Integer;
Begin
  InHerited Assign(ASource);

  For X := 0 To Count - 1 Do
    Get(X).OnChange := DoOnChange;
End;

end.
