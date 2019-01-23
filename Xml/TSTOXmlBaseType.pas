unit TSTOXmlBaseType;

interface

Uses HsXmlDocEx;
  //xmldom, XMLDoc, XMLIntf;

Type
  //MasterList
  ITSTOXmlDataID = Interface(IXmlNodeEx)
    ['{8DAB458F-0B68-4DC7-84CA-5E9C612A61B9}']
    Function GetId: Integer;
    Function GetName: Widestring;
    Function GetStatus: Widestring;
    Function GetOnDeprecated: Widestring;
    Function GetStartDate: Widestring;
    Function GetEndDate: Widestring;
    Function GetEnabled: Widestring;
    Procedure SetId(Value: Integer);
    Procedure SetName(Value: Widestring);
    Procedure SetStatus(Value: Widestring);
    Procedure SetOnDeprecated(Value: Widestring);
    Procedure SetStartDate(Value: Widestring);
    Procedure SetEndDate(Value: Widestring);
    Procedure SetEnabled(Value: Widestring);

    Property Id           : Integer    Read GetId           Write SetId;
    Property Name         : Widestring Read GetName         Write SetName;
    Property Status       : Widestring Read GetStatus       Write SetStatus;
    Property OnDeprecated : Widestring Read GetOnDeprecated Write SetOnDeprecated;
    Property StartDate    : Widestring Read GetStartDate    Write SetStartDate;
    Property EndDate      : Widestring Read GetEndDate      Write SetEndDate;
    Property Enabled      : Widestring Read GetEnabled      Write SetEnabled;

  End;
  
  ITSTOXmlDataIDList = Interface(IXmlNodeCollectionEx)
    ['{5CBE0E03-7674-4E2E-BB87-2D380142DA99}']
    Function Add: ITSTOXmlDataID;
    Function Insert(Const Index: Integer): ITSTOXmlDataID;
    Function GetItem(Index: Integer): ITSTOXmlDataID;

    Property Items[Index: Integer]: ITSTOXmlDataID Read GetItem; Default;

  End;

  ITSTOXmlInclude = Interface(IXmlNodeEx)
    ['{988DA634-9B91-4163-897F-A3B81F2A7DE9}']
    Function GetPath: Widestring;
    Procedure SetPath(Value: Widestring);

    Property Path: Widestring Read GetPath Write SetPath;

  End;  
  
  ITSTOXmlPackage = Interface(IXmlNodeEx)
    ['{7499121C-F0A8-41C0-B0F6-A214C8479661}']
    Function GetName: Widestring;
    Function GetRangeFrom: Integer;
    Function GetRangeTo: Integer;
    Function GetDataID: ITSTOXmlDataIDList;
    Function GetInclude: ITSTOXmlInclude;
    Procedure SetName(Value: Widestring);
    Procedure SetRangeFrom(Value: Integer);
    Procedure SetRangeTo(Value: Integer);

    Property Name      : Widestring     Read GetName      Write SetName;
    Property RangeFrom : Integer        Read GetRangeFrom Write SetRangeFrom;
    Property RangeTo   : Integer        Read GetRangeTo   Write SetRangeTo;
    Property DataID    : ITSTOXmlDataIDList Read GetDataID;
    Property Include   : ITSTOXmlInclude    Read GetInclude;

  End;

  ITSTOXmlPackageList = Interface(IXmlNodeCollectionEx)
    ['{E1A26E4B-B773-4DF1-93B4-312B320CB2AB}']
    Function Add: ITSTOXmlPackage;
    Function Insert(Const Index: Integer): ITSTOXmlPackage;
    Function GetItem(Index: Integer): ITSTOXmlPackage;
    Property Items[Index: Integer]: ITSTOXmlPackage Read GetItem; Default;

  End;

  ITSTOXmlIDMasterList = Interface(IXmlNodeCollectionEx)
    ['{AF527BDE-AA6B-401D-AAE7-2A29F6677CE5}']
    Function GetPackage(Index: Integer): ITSTOXmlPackage;
    Function Add: ITSTOXmlPackage;
    Function Insert(Const Index: Integer): ITSTOXmlPackage;

    Property Package[Index: Integer]: ITSTOXmlPackage Read GetPackage; Default;

  End;

  //Building
  ITSTOXmlCost = Interface(IXmlNodeEx)
    ['{EC79B85C-E2D4-4352-8A4D-190298288C3D}']
    Function GetMoney: Integer;
    Function GetDonuts: Integer;
    Procedure SetMoney(Value: Integer);
    Procedure SetDonuts(Value: Integer);

    Property Money: Integer Read GetMoney Write SetMoney;
    Property Donuts: Integer Read GetDonuts Write SetDonuts;

  End;

  ITSTOXmlSell = Interface(IXmlNodeEx)
    ['{B276B65D-3F18-41E7-AF78-2BD419D46096}']
    Function GetMoney: Widestring;
    Function GetDonuts: Integer;
    Function GetAllowed: Widestring;
    Function GetStoreoverride: Widestring;
    Procedure SetMoney(Value: Widestring);
    Procedure SetDonuts(Value: Integer);
    Procedure SetAllowed(Value: Widestring);
    Procedure SetStoreoverride(Value: Widestring);

    Property Money         : Widestring Read GetMoney         Write SetMoney;
    Property Donuts        : Integer    Read GetDonuts        Write SetDonuts;
    Property Allowed       : Widestring Read GetAllowed       Write SetAllowed;
    Property Storeoverride : Widestring Read GetStoreoverride Write SetStoreoverride;

  End;

  //Misc
  ITSTOXmlIntegerVal = Interface(IXmlNodeEx)
    ['{68CB759F-7C37-4C68-A1CE-DE4A703D65E1}']
    Function GetVal() : Integer;
    Procedure SetVal(Value : Integer);

    Property Val : Integer Read GetVal Write SetVal;

  End;

  ITSTOXmlWideStringVal = Interface(IXmlNodeEx)
    ['{B41F28F5-8D4E-4DDE-B9D7-35682B267F4B}']
    Function GetVal() : WideString;
    Procedure SetVal(Value : WideString);

    Property Val : WideString Read GetVal Write SetVal;

  End;

(******************************************************************************)
    
  TXMLPackage = Class(TXmlNodeEx, ITSTOXmlPackage)
  Private
    FDataID: ITSTOXmlDataIDList;

  Protected
    Function GetName: Widestring;
    Function GetRangeFrom: Integer;
    Function GetRangeTo: Integer;
    Function GetDataID: ITSTOXmlDataIDList;
    Function GetInclude: ITSTOXmlInclude;
    Procedure SetName(Value: Widestring);
    Procedure SetRangeFrom(Value: Integer);
    Procedure SetRangeTo(Value: Integer);

  Public
    Procedure AfterConstruction; Override;

  End;

  TXMLPackageList = Class(TXmlNodeCollectionEx, ITSTOXmlPackageList)
  Protected
    Function Add: ITSTOXmlPackage;
    Function Insert(Const Index: Integer): ITSTOXmlPackage;
    Function GetItem(Index: Integer): ITSTOXmlPackage;

  End;

  TXMLDataID = Class(TXmlNodeEx, ITSTOXmlDataID)
  Protected
    Function GetId: Integer;
    Function GetName: Widestring;
    Function GetStatus: Widestring;
    Function GetOnDeprecated: Widestring;
    Function GetStartDate: Widestring;
    Function GetEndDate: Widestring;
    Function GetEnabled: Widestring;
    Procedure SetId(Value: Integer);
    Procedure SetName(Value: Widestring);
    Procedure SetStatus(Value: Widestring);
    Procedure SetOnDeprecated(Value: Widestring);
    Procedure SetStartDate(Value: Widestring);
    Procedure SetEndDate(Value: Widestring);
    Procedure SetEnabled(Value: Widestring);
  End;

  TXMLDataIDList = Class(TXmlNodeCollectionEx, ITSTOXmlDataIDList)
  Protected
    Function Add: ITSTOXmlDataID;
    Function Insert(Const Index: Integer): ITSTOXmlDataID;
    Function GetItem(Index: Integer): ITSTOXmlDataID;

  End;

  TXMLInclude = Class(TXmlNodeEx, ITSTOXmlInclude)
  Protected
    Function GetPath: Widestring;
    Procedure SetPath(Value: Widestring);

  End;

  TXMLIDMasterList = Class(TXmlNodeCollectionEx, ITSTOXmlIDMasterList)
  Protected
    Function GetPackage(Index: Integer): ITSTOXmlPackage;
    Function Add: ITSTOXmlPackage;
    Function Insert(Const Index: Integer): ITSTOXmlPackage;

  Public
    Procedure AfterConstruction; Override;

  End;

  TXMLCost = Class(TXmlNodeEx, ITSTOXmlCost)
  Protected
    Function GetMoney: Integer;
    Function GetDonuts: Integer;
    Procedure SetMoney(Value: Integer);
    Procedure SetDonuts(Value: Integer);

  End;

  TXMLSell = Class(TXmlNodeEx, ITSTOXmlSell)
  Protected
    Function GetMoney: Widestring;
    Function GetDonuts: Integer;
    Function GetAllowed: Widestring;
    Function GetStoreoverride: Widestring;
    Procedure SetMoney(Value: Widestring);
    Procedure SetDonuts(Value: Integer);
    Procedure SetAllowed(Value: Widestring);
    Procedure SetStoreoverride(Value: Widestring);

  End;

  //Misc
  TTSTOXmlIntegerVal = Class(TXmlNodeEx, ITSTOXmlIntegerVal)
  Protected
    Function  GetVal() : Integer;
    Procedure SetVal(Value: Integer);

  End;

  TTSTOXmlWideStringVal = Class(TXmlNodeEx, ITSTOXmlWideStringVal)
  Protected
    Function  GetVal() : WideString;
    Procedure SetVal(Value: WideString);

  End;

implementation

Procedure TXMLPackage.AfterConstruction;
Begin
  RegisterChildNode('DataID', TXMLDataID);
  RegisterChildNode('Include', TXMLInclude);
  FDataID := CreateCollection(TXMLDataIDList, ITSTOXmlDataID, 'DataID') As ITSTOXmlDataIDList;
  Inherited;
End;

Function TXMLPackage.GetName: Widestring;
Begin
  Result := AttributeNodes['name'].Text;
End;

Procedure TXMLPackage.SetName(Value: Widestring);
Begin
  SetAttribute('name', Value);
End;

Function TXMLPackage.GetRangeFrom: Integer;
Begin
  Result := AttributeNodes['rangeFrom'].NodeValue;
End;

Procedure TXMLPackage.SetRangeFrom(Value: Integer);
Begin
  SetAttribute('rangeFrom', Value);
End;

Function TXMLPackage.GetRangeTo: Integer;
Begin
  Result := AttributeNodes['rangeTo'].NodeValue;
End;

Procedure TXMLPackage.SetRangeTo(Value: Integer);
Begin
  SetAttribute('rangeTo', Value);
End;

Function TXMLPackage.GetDataID: ITSTOXmlDataIDList;
Begin
  Result := FDataID;
End;

Function TXMLPackage.GetInclude: ITSTOXmlInclude;
Begin
  Result := ChildNodes['Include'] As ITSTOXmlInclude;
End;

Function TXMLPackageList.Add: ITSTOXmlPackage;
Begin
  Result := AddItem(-1) As ITSTOXmlPackage;
End;

Function TXMLPackageList.Insert(Const Index: Integer): ITSTOXmlPackage;
Begin
  Result := AddItem(Index) As ITSTOXmlPackage;
End;

Function TXMLPackageList.GetItem(Index: Integer): ITSTOXmlPackage;
Begin
  Result := List[Index] As ITSTOXmlPackage;
End;

Function TXMLDataID.GetId: Integer;
Begin
  Result := AttributeNodes['id'].NodeValue;
End;

Procedure TXMLDataID.SetId(Value: Integer);
Begin
  SetAttribute('id', Value);
End;

Function TXMLDataID.GetName: Widestring;
Begin
  Result := AttributeNodes['name'].Text;
End;

Procedure TXMLDataID.SetName(Value: Widestring);
Begin
  SetAttribute('name', Value);
End;

Function TXMLDataID.GetStatus: Widestring;
Begin
  Result := AttributeNodes['status'].Text;
End;

Procedure TXMLDataID.SetStatus(Value: Widestring);
Begin
  SetAttribute('status', Value);
End;

Function TXMLDataID.GetOnDeprecated: Widestring;
Begin
  Result := AttributeNodes['onDeprecated'].Text;
End;

Procedure TXMLDataID.SetOnDeprecated(Value: Widestring);
Begin
  SetAttribute('onDeprecated', Value);
End;

Function TXMLDataID.GetStartDate: Widestring;
Begin
  Result := AttributeNodes['startDate'].Text;
End;

Procedure TXMLDataID.SetStartDate(Value: Widestring);
Begin
  SetAttribute('startDate', Value);
End;

Function TXMLDataID.GetEndDate: Widestring;
Begin
  Result := AttributeNodes['endDate'].Text;
End;

Procedure TXMLDataID.SetEndDate(Value: Widestring);
Begin
  SetAttribute('endDate', Value);
End;

Function TXMLDataID.GetEnabled: Widestring;
Begin
  Result := AttributeNodes['enabled'].Text;
End;

Procedure TXMLDataID.SetEnabled(Value: Widestring);
Begin
  SetAttribute('enabled', Value);
End;

Function TXMLDataIDList.Add: ITSTOXmlDataID;
Begin
  Result := AddItem(-1) As ITSTOXmlDataID;
End;

Function TXMLDataIDList.Insert(Const Index: Integer): ITSTOXmlDataID;
Begin
  Result := AddItem(Index) As ITSTOXmlDataID;
End;
Function TXMLDataIDList.GetItem(Index: Integer): ITSTOXmlDataID;
Begin
  Result := List[Index] As ITSTOXmlDataID;
End;

Function TXMLInclude.GetPath: Widestring;
Begin
  Result := AttributeNodes['path'].Text;
End;

Procedure TXMLInclude.SetPath(Value: Widestring);
Begin
  SetAttribute('path', Value);
End;

Procedure TXMLIDMasterList.AfterConstruction;
Begin
  RegisterChildNode('Package', TXMLPackage);
  ItemTag := 'Package';
  ItemInterface := ITSTOXmlPackage;
  Inherited;
End;

Function TXMLIDMasterList.GetPackage(Index: Integer): ITSTOXmlPackage;
Begin
  Result := List[Index] As ITSTOXmlPackage;
End;

Function TXMLIDMasterList.Add: ITSTOXmlPackage;
Begin
  Result := AddItem(-1) As ITSTOXmlPackage;
End;

Function TXMLIDMasterList.Insert(Const Index: Integer): ITSTOXmlPackage;
Begin
  Result := AddItem(Index) As ITSTOXmlPackage;
End;

(******************************************************************************)

Function TXMLCost.GetMoney: Integer;
Begin
  Result := AttributeNodes['money'].NodeValue;
End;

Procedure TXMLCost.SetMoney(Value: Integer);
Begin
  SetAttribute('money', Value);
End;

Function TXMLCost.GetDonuts: Integer;
Begin
  Result := AttributeNodes['donuts'].NodeValue;
End;

Procedure TXMLCost.SetDonuts(Value: Integer);
Begin
  SetAttribute('donuts', Value);
End;

Function TXMLSell.GetMoney: Widestring;
Begin
  Result := AttributeNodes['money'].Text;
End;

Procedure TXMLSell.SetMoney(Value: Widestring);
Begin
  SetAttribute('money', Value);
End;

Function TXMLSell.GetDonuts: Integer;
Begin
  Result := AttributeNodes['donuts'].NodeValue;
End;

Procedure TXMLSell.SetDonuts(Value: Integer);
Begin
  SetAttribute('donuts', Value);
End;

Function TXMLSell.GetAllowed: Widestring;
Begin
  Result := AttributeNodes['allowed'].Text;
End;

Procedure TXMLSell.SetAllowed(Value: Widestring);
Begin
  SetAttribute('allowed', Value);
End;

Function TXMLSell.GetStoreoverride: Widestring;
Begin
  Result := AttributeNodes['storeoverride'].Text;
End;

Procedure TXMLSell.SetStoreoverride(Value: Widestring);
Begin
  SetAttribute('storeoverride', Value);
End;

Function TTSTOXmlIntegerVal.GetVal: Integer;
Begin
  Result := AttributeNodes['val'].NodeValue;
End;

Procedure TTSTOXmlIntegerVal.SetVal(Value: Integer);
Begin
  SetAttribute('val', Value);
End;

Function TTSTOXmlWideStringVal.GetVal: Widestring;
Begin
  Result := AttributeNodes['val'].Text;
End;

Procedure TTSTOXmlWideStringVal.SetVal(Value: Widestring);
Begin
  SetAttribute('val', Value);
End;

end.
