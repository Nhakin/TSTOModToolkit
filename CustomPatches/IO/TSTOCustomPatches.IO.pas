unit TSTOCustomPatches.IO;

interface

Uses Classes, TSTOCustomPatchesIntf;

Type
  ITSTOPatchDataIO = Interface(ITSTOPatchData)
    ['{4B61686E-29A0-2112-BEDF-E83EBF2AEC51}']
    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

    Property OnChange : TNotifyEvent Read GetOnChange Write SetOnChange;

  End;

  ITSTOPatchDatasIO = Interface(ITSTOPatchDatas)
    ['{4B61686E-29A0-2112-BB65-879B0C21F3FC}']
    Function  Get(Index : Integer) : ITSTOPatchDataIO;
    Procedure Put(Index : Integer; Const Item : ITSTOPatchDataIO);

    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

    Function Add() : ITSTOPatchDataIO; OverLoad;
    Function Add(Const AItem : ITSTOPatchDataIO) : Integer; OverLoad;
    Function Remove(Const AItem : ITSTOPatchDataIO) : Integer;

    Property Items[Index : Integer] : ITSTOPatchDataIO Read Get Write Put; Default;

    Property OnChange : TNotifyEvent Read GetOnChange Write SetOnChange;

  End;

  ITSTOCustomPatchIO = Interface(ITSTOCustomPatch)
    ['{4B61686E-29A0-2112-95A5-DFC99ED38E13}']
    Function  GetPatchData() : ITSTOPatchDatasIO;

    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

    Property PatchData : ITSTOPatchDatasIO Read GetPatchData;

    Property OnChange : TNotifyEvent Read GetOnChange Write SetOnChange;

  End;

  ITSTOCustomPatchListIO = Interface(ITSTOCustomPatchList)
    ['{4B61686E-29A0-2112-ABB1-EF0013E01FA7}']
    Function  Get(Index : Integer) : ITSTOCustomPatchIO;
    Procedure Put(Index : Integer; Const Item : ITSTOCustomPatchIO);

    Function GetModified() : Boolean;

    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

    Function Add() : ITSTOCustomPatchIO; OverLoad;
    Function Add(Const AItem : ITSTOCustomPatchIO) : Integer; OverLoad;
    Function Remove(Const AItem : ITSTOCustomPatchIO) : Integer;

    Property Items[Index : Integer] : ITSTOCustomPatchIO Read Get Write Put; Default;

    Property Modified : Boolean Read GetModified;

    Property OnChange : TNotifyEvent Read GetOnChange Write SetOnChange;

  End;

(******************************************************************************)

  ITSTOCustomPatchesIO = Interface(ITSTOCustomPatches)
    ['{4B61686E-29A0-2112-9AB6-78B41DBCF99D}']
    Function  GetAsXml() : String;
    Procedure SetAsXml(Const AXml : String);

    Function  GetPatches() : ITSTOCustomPatchListIO;

    Function GetModified() : Boolean;

    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);
    Procedure ForceChanged();

    Property AsXml    : String Read GetAsXml Write SetAsXml;
    Property Patches  : ITSTOCustomPatchListIO Read GetPatches;
    Property Modified : Boolean Read GetModified;

    Property OnChange : TNotifyEvent Read GetOnChange Write SetOnChange;

  End;

  TTSTOCustomPatchesIO = Class(TObject)
  Public
    Class Function CreateCustomPatchIO() : ITSTOCustomPatchesIO;

  End;

implementation

Uses
  HsXmlDocEx, HsInterfaceEx, TSTOCustomPatchesImpl, TSTOCustomPatches.Xml;

Type
  TTSTOPatchDataIO = Class(TTSTOPatchData, ITSTOPatchDataIO)
  Private
    FOnChange : TNotifyEvent;

  Protected
    Procedure SetPatchType(Const APatchType : Integer); OverRide;
    Procedure SetPatchPath(Const APatchPath : WideString); OverRide;
    Procedure SetCode(Const ACode : WideString); OverRide;

    Procedure DoOnChange(Sender : TObject);
    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

  End;

  TTSTOPatchDatasIO = Class(TTSTOPatchDatas, ITSTOPatchDatasIO)
  Private
    FOnChange : TNotifyEvent;

  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;

    Function  Get(Index : Integer) : ITSTOPatchDataIO; OverLoad;
    Procedure Put(Index : Integer; Const Item : ITSTOPatchDataIO); OverLoad;

    Function Add() : ITSTOPatchDataIO; ReIntroduce; OverLoad;
    Function Add(Const AItem : ITSTOPatchDataIO) : Integer; OverLoad;
    Function Remove(Const AItem : ITSTOPatchDataIO) : Integer; ReIntroduce;

    Procedure DoOnChange(Sender : TObject);
    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

  End;

  TTSTOCustomPatchIO = Class(TTSTOCustomPatch, ITSTOCustomPatchIO)
  Private
    FOnChange : TNotifyEvent;

  Protected
    Function GetPatchDatasClass() : TTSTOPatchDatasClass; OverRide;

    Procedure SetPatchName(Const APatchName : WideString); OverRide;
    Procedure SetPatchActive(Const APatchActive : Boolean); OverRide;
    Procedure SetPatchDesc(Const APatchDesc : WideString); OverRide;
    Procedure SetFileName(Const AFileName : WideString); OverRide;

    Function  GetPatchData() : ITSTOPatchDatasIO;

    Procedure DoOnChange(Sender : TObject);
    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

    Procedure Assign(ASource : IInterface); OverRide;

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TTSTOCustomPatchListIO = Class(TTSTOCustomPatchList, ITSTOCustomPatchListIO)
  Private
    FOnChange : TNotifyEvent;
    FModified : Boolean;

  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;

    Function  Get(Index : Integer) : ITSTOCustomPatchIO; OverLoad;
    Procedure Put(Index : Integer; Const Item : ITSTOCustomPatchIO); OverLoad;

    Function  GetModified() : Boolean;

    Function Add() : ITSTOCustomPatchIO; ReIntroduce; OverLoad;
    Function Add(Const AItem : ITSTOCustomPatchIO) : Integer; OverLoad;
    Function Remove(Const AItem : ITSTOCustomPatchIO) : Integer; ReIntroduce;

    Procedure DoOnChange(Sender : TObject);
    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TTSTOCustomPatchesIOImpl = Class(TTSTOCustomPatches, ITSTOCustomPatchesIO,
    ITSTOXmlCustomPatches)
  Private
    FOnChange : TNotifyEvent;
    FModified : Boolean;

    Function GetXmlImpl() : ITSTOXmlCustomPatches;

  Protected
    Property XmlImpl : ITSTOXmlCustomPatches Read GetXmlImpl Implements ITSTOXmlCustomPatches;

    Function  GetCustomPatchListClass() : TTSTOCustomPatchListClass; OverRide;

    Function  GetPatches() : ITSTOCustomPatchListIO;

    Function  GetAsXml() : String;
    Procedure SetAsXml(Const AXml : String);

    Function  GetModified() : Boolean;

    Procedure DoOnChange(Sender : TObject);
    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);
    Procedure ForceChanged();

    Procedure Assign(ASource : IInterface); OverRide;

  Public
    Procedure AfterConstruction(); OverRide;

  End;

Class Function TTSTOCustomPatchesIO.CreateCustomPatchIO() : ITSTOCustomPatchesIO;
Begin
  Result := TTSTOCustomPatchesIOImpl.Create();
End;

(******************************************************************************)

Procedure TTSTOPatchDataIO.SetPatchType(Const APatchType : Integer);
Begin
  If GetPatchType() <> APatchType Then
  Begin
    InHerited SetPatchType(APatchType);
    DoOnChange(Self);
  End;
End;

Procedure TTSTOPatchDataIO.SetPatchPath(Const APatchPath : WideString);
Begin
  If GetPatchPath() <> APatchPath Then
  Begin
    InHerited SetPatchPath(APatchPath);
    DoOnChange(Self);
  End;
End;

Procedure TTSTOPatchDataIO.SetCode(Const ACode : WideString);
Begin
  If GetCode() <> ACode Then
  Begin
    InHerited SetCode(ACode);
    DoOnChange(Self);
  End;
End;

Procedure TTSTOPatchDataIO.DoOnChange(Sender : TObject);
Begin
  If Assigned(FOnChange) Then
    FOnChange(Sender);
End;

Function TTSTOPatchDataIO.GetOnChange() : TNotifyEvent;
Begin
  Result := FOnChange;
End;

Procedure TTSTOPatchDataIO.SetOnChange(AOnChange : TNotifyEvent);
Begin
  FOnChange := AOnChange;
End;

Function TTSTOPatchDatasIO.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TTSTOPatchDataIO;
End;

Function TTSTOPatchDatasIO.Get(Index : Integer) : ITSTOPatchDataIO;
Begin
  Result := InHerited Get(Index) As ITSTOPatchDataIO;
End;

Procedure TTSTOPatchDatasIO.Put(Index : Integer; Const Item : ITSTOPatchDataIO);
Begin
  InHerited Put(Index, Item);
End;

Function TTSTOPatchDatasIO.Add() : ITSTOPatchDataIO;
Begin
  Result := InHerited Add() As ITSTOPatchDataIO;
  Result.OnChange := DoOnChange;
  DoOnChange(Self);
End;

Function TTSTOPatchDatasIO.Add(Const AItem : ITSTOPatchDataIO) : Integer;
Begin
  Result := InHerited Add(AItem);
  AItem.OnChange := DoOnChange;
  DoOnChange(Self);
End;

Function TTSTOPatchDatasIO.Remove(Const AItem : ITSTOPatchDataIO) : Integer;
Begin
  Result := InHerited Remove(AItem As IInterfaceEx);
  DoOnChange(Self);
End;

Procedure TTSTOPatchDatasIO.DoOnChange(Sender : TObject);
Begin
  If Assigned(FOnChange) Then
    FOnChange(Sender);
End;

Function TTSTOPatchDatasIO.GetOnChange() : TNotifyEvent;
Begin
  Result := FOnChange;
End;

Procedure TTSTOPatchDatasIO.SetOnChange(AOnChange : TNotifyEvent);
Begin
  FOnChange := AOnChange;
End;

Procedure TTSTOCustomPatchIO.AfterConstruction();
Begin
  InHerited AfterConstruction();
  GetPatchData().OnChange := DoOnChange;
End;

Procedure TTSTOCustomPatchIO.Assign(ASource : IInterface);
Var lPatch : ITSTOPatchDatasIO;
    X      : Integer;
Begin
  InHerited Assign(ASource);

  lPatch := GetPatchData();
  For X := 0 To lPatch.Count - 1 Do
    lPatch[X].OnChange := DoOnChange;
End;

Function TTSTOCustomPatchIO.GetPatchDatasClass() : TTSTOPatchDatasClass;
Begin
  Result := TTSTOPatchDatasIO;
End;

Procedure TTSTOCustomPatchIO.SetPatchName(Const APatchName : WideString);
Begin
  If GetPatchName() <> APatchName Then
  Begin
    InHerited SetPatchName(APatchName);
    DoOnChange(Self);
  End;
End;

Procedure TTSTOCustomPatchIO.SetPatchActive(Const APatchActive : Boolean);
Begin
  If GetPatchActive() <> APatchActive Then
  Begin
    InHerited SetPatchActive(APatchActive);
    DoOnChange(Self);
  End;
End;

Procedure TTSTOCustomPatchIO.SetPatchDesc(Const APatchDesc : WideString);
Begin
  If GetPatchDesc() <> APatchDesc Then
  Begin
    InHerited SetPatchDesc(APatchDesc);
    DoOnChange(Self);
  End;
End;

Procedure TTSTOCustomPatchIO.SetFileName(Const AFileName : WideString);
Begin
  If GetFileName() <> AFileName Then
  Begin
    InHerited SetFileName(AFileName);
    DoOnChange(Self);
  End;
End;

Function TTSTOCustomPatchIO.GetPatchData() : ITSTOPatchDatasIO;
Begin
  Result := InHerited GetPatchData() As ITSTOPatchDatasIO;
End;

Procedure TTSTOCustomPatchIO.DoOnChange(Sender : TObject);
Begin
  If Assigned(FOnChange) Then
    FOnChange(Sender);
End;

Function TTSTOCustomPatchIO.GetOnChange() : TNotifyEvent;
Begin
  Result := FOnChange;
End;

Procedure TTSTOCustomPatchIO.SetOnChange(AOnChange : TNotifyEvent);
Begin
  FOnChange := AOnChange;
End;

Procedure TTSTOCustomPatchListIO.AfterConstruction();
Begin
  InHerited AfterConstruction();
  FModified := False;
End;

Function TTSTOCustomPatchListIO.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TTSTOCustomPatchIO;
End;

Function TTSTOCustomPatchListIO.Get(Index : Integer) : ITSTOCustomPatchIO;
Begin
  Result := InHerited Get(Index) As ITSTOCustomPatchIO;
End;

Procedure TTSTOCustomPatchListIO.Put(Index : Integer; Const Item : ITSTOCustomPatchIO);
Begin
  InHerited Put(Index, Item);
End;

Function TTSTOCustomPatchListIO.Add() : ITSTOCustomPatchIO;
Begin
  Result := InHerited Add() As ITSTOCustomPatchIO;
  Result.OnChange := DoOnChange;
  DoOnChange(Self);
End;

Function TTSTOCustomPatchListIO.Add(Const AItem : ITSTOCustomPatchIO) : Integer;
Begin
  Result := InHerited Add(AItem);
  AItem.OnChange := DoOnChange;
  DoOnChange(Self);
End;

Function TTSTOCustomPatchListIO.Remove(Const AItem : ITSTOCustomPatchIO) : Integer;
Begin
  Result := InHerited Remove(AItem As IInterfaceEx);
  DoOnChange(Self);
End;

Function TTSTOCustomPatchListIO.GetModified() : Boolean;
Begin
  Result := FModified;
End;

Procedure TTSTOCustomPatchListIO.DoOnChange(Sender : TObject);
Begin
  If Assigned(FOnChange) Then
    FOnChange(Sender);
  FModified := True;
End;

Function TTSTOCustomPatchListIO.GetOnChange() : TNotifyEvent;
Begin
  Result := FOnChange;
End;

Procedure TTSTOCustomPatchListIO.SetOnChange(AOnChange : TNotifyEvent);
Begin
  FOnChange := AOnChange;
End;

Procedure TTSTOCustomPatchesIOImpl.AfterConstruction();
Begin
  InHerited AfterConstruction();

  GetPatches().OnChange := DoOnChange;
End;

Procedure TTSTOCustomPatchesIOImpl.Assign(ASource : IInterface);
Var lPatches : ITSTOCustomPatchListIO;
    X        : Integer;
Begin
  InHerited Assign(ASource);

  lPatches := GetPatches();
  For X := 0 To lPatches.Count - 1 Do
    lPatches[X].OnChange := DoOnChange;
End;

Function TTSTOCustomPatchesIOImpl.GetXmlImpl() : ITSTOXmlCustomPatches;
Begin
  Result := TTSTOXmlCustomPatches.CreateCustomPatches();
  Result.Assign(Self);
End;

Function TTSTOCustomPatchesIOImpl.GetCustomPatchListClass() : TTSTOCustomPatchListClass;
Begin
  Result := TTSTOCustomPatchListIO;
End;

Function TTSTOCustomPatchesIOImpl.GetPatches() : ITSTOCustomPatchListIO;
Begin
  Result := InHerited GetPatches() As ITSTOCustomPatchListIO;
End;

Function TTSTOCustomPatchesIOImpl.GetAsXml() : String;
Begin
  Result := FormatXmlData(XmlImpl.Xml);
End;

Procedure TTSTOCustomPatchesIOImpl.SetAsXml(Const AXml : String);
Begin
  Assign(TTSTOXmlCustomPatches.CreateCustomPatches(AXml));
End;

Function TTSTOCustomPatchesIOImpl.GetModified() : Boolean;
Begin
  Result := FModified;
End;

Procedure TTSTOCustomPatchesIOImpl.DoOnChange(Sender : TObject);
Begin
  If Assigned(FOnChange) Then
    FOnChange(Sender);
  FModified := True;
End;

Function TTSTOCustomPatchesIOImpl.GetOnChange() : TNotifyEvent;
Begin
  Result := FOnChange;
End;

Procedure TTSTOCustomPatchesIOImpl.SetOnChange(AOnChange : TNotifyEvent);
Begin
  FOnChange := AOnChange;
End;

Procedure TTSTOCustomPatchesIOImpl.ForceChanged();
Begin
  DoOnChange(Self);
End;

end.
