Unit TSTOHackMasterList.Xml;

Interface

Uses HsXmlDocEx, HsStringListEx;

Type
  IXmlTSTOHackMasterDataID = Interface(IXMLNodeEx)
    ['{3B70CF15-242C-438B-B2B0-CF6D4C60808B}']
    Function  GetId() : Integer;
    Procedure SetId(Const Value: Integer);
    
    Function  GetName() : String;
    Procedure SetName(Const Value: String);

    Function  GetAddInStore() : Boolean;
    Procedure SetAddInStore(Const AAddInStore : Boolean);

    Function  GetOverRide() : Boolean;
    Procedure SetOverRide(Const AOverRide : Boolean);

    Function  GetIsBadItem() : Boolean;
    Procedure SetIsBadItem(Const AIsBadItem : Boolean);

    Function  GetMiscData() : IHsStringListEx;

    Procedure Assign(ASource : IInterface);

    Property Id         : Integer         Read GetId         Write SetId;
    Property Name       : String          Read GetName       Write SetName;
    Property AddInStore : Boolean         Read GetAddInStore Write SetAddInStore;
    Property OverRide   : Boolean         Read GetOverRide   Write SetOverRide;
    Property IsBadItem  : Boolean         Read GetIsBadItem  Write SetIsBadItem;
    Property MiscData   : IHsStringListEx Read GetMiscData;

  End;

  IXmlTSTOHackMasterPackage = Interface(IXmlNodeCollectionEx)
    ['{6170F205-8932-492E-8530-0A5D10E5D86D}']
    Function GetDataID(Index : Integer) : IXmlTSTOHackMasterDataID;

    Function  GetPackageType() : String;
    Procedure SetPackageType(Const Value : String);

    Function  GetXmlFile() : String;
    Procedure SetXmlFile(Const Value : String);

    Function  GetEnabled() : Boolean;
    Procedure SetEnabled(Const AEnabled : Boolean);

    Function Add() : IXmlTSTOHackMasterDataID;
    Function Insert(Const Index : Integer) : IXmlTSTOHackMasterDataID;

    Procedure Assign(ASource : IInterface);

    Property DataID[Index: Integer]: IXmlTSTOHackMasterDataID Read GetDataID; Default;

    Property PackageType : String  Read GetPackageType Write SetPackageType;
    Property XmlFile     : String  Read GetXmlFile     Write SetXmlFile;
    Property Enabled     : Boolean Read GetEnabled     Write SetEnabled;

  End;

  IXmlTSTOHackMasterCategory = Interface(IXmlNodeCollectionEx)
    ['{E78BD474-D686-499F-AF61-B9E19B68468C}']
    Function GetPackage(Index: Integer): IXmlTSTOHackMasterPackage;

    Function  GetName() : String;
    Procedure SetName(Const Value: String);

    Function  GetEnabled() : Boolean;
    Procedure SetEnabled(Const AEnabled : Boolean);

    Function  GetBuildStore() : Boolean;
    Procedure SetBuildStore(Const ABuildStore : Boolean);

    Function Add: IXmlTSTOHackMasterPackage;
    Function Insert(Const Index: Integer): IXmlTSTOHackMasterPackage;

    Procedure Assign(ASource : IInterface);

    Property Package[Index: Integer]: IXmlTSTOHackMasterPackage Read GetPackage; Default;

    Property Name       : String  Read GetName       Write SetName;
    Property Enabled    : Boolean Read GetEnabled    Write SetEnabled;
    Property BuildStore : Boolean Read GetBuildStore Write SetBuildStore;

  End;

  IXmlTSTOHackMasterList = Interface(IXmlNodeCollectionEx)
    ['{8685D965-C38D-436A-9B36-B919FA738878}']
    Function GetCategory(Index: Integer): IXmlTSTOHackMasterCategory;

    Function Add: IXmlTSTOHackMasterCategory;
    Function Insert(Const Index: Integer): IXmlTSTOHackMasterCategory;

    Procedure Assign(ASource : IInterface);

    Property Category[Index: Integer]: IXmlTSTOHackMasterCategory Read GetCategory; Default;

  End;

  TXmlTSTOHackMasterList = Class(TObject)
  Private
    Class Procedure InitMiscData(AXmlDoc : IXmlTSTOHackMasterList);
    
  Public
    Class Function CreateMasterList() : IXmlTSTOHackMasterList; OverLoad;
    Class Function CreateMasterList(Const AXmlText : String) : IXmlTSTOHackMasterList; OverLoad;

  End;

Implementation

Uses
  Dialogs,
  SysUtils, RtlConsts, Variants, HsInterfaceEx,
  TSTOHackMasterListIntf, TSTOHackMasterListImpl, XMLIntf;

Type
  TTSTOXMLDataID = Class(TXmlNodeEx, ITSTOHackMasterDataID, IXmlTSTOHackMasterDataID)
  Private
    FDataIDImpl : Pointer;
    Function GetImplementor() : ITSTOHackMasterDataID;

  Protected
    Property DataIDImpl : ITSTOHackMasterDataID Read GetImplementor;
    
    Function  GetId() : Integer;
    Procedure SetId(Const Value: Integer);
    
    Function  GetName() : String;
    Procedure SetName(Const Value: String);

    Function  GetAddInStore() : Boolean;
    Procedure SetAddInStore(Const AAddInStore : Boolean);

    Function  GetOverRide() : Boolean;
    Procedure SetOverRide(Const AOverRide : Boolean);

    Function  GetIsBadItem() : Boolean;
    Procedure SetIsBadItem(Const AIsBadItem : Boolean);

    Function  GetMiscData() : IHsStringListEx; //All ChidNodes of <DataID/>

    Procedure Assign(ASource : IInterface);

  Public
    Procedure AfterConstruction; Override;

  End;

  TTSTOXMLPackage = Class(TXmlNodeCollectionEx, ITSTOHackMasterPackage, IXmlTSTOHackMasterPackage)
  Private
    FMasterImpl : ITSTOHackMasterPackage;

    Function GetImplementor() : ITSTOHackMasterPackage;

  Protected
    Property MasterImpl : ITSTOHackMasterPackage Read GetImplementor Implements ITSTOHackMasterPackage;
    
    Function GetDataID(Index : Integer) : IXmlTSTOHackMasterDataID;

    Function  GetPackageType() : String;
    Procedure SetPackageType(Const Value : String);

    Function  GetXmlFile() : String;
    Procedure SetXmlFile(Const Value : String);

    Function  GetEnabled() : Boolean;
    Procedure SetEnabled(Const AEnabled : Boolean);

    Function Add() : IXmlTSTOHackMasterDataID;
    Function Insert(Const Index: Integer): IXmlTSTOHackMasterDataID;

    Procedure Assign(ASource : IInterface);
    Procedure AssignTo(ATarget : ITSTOHackMasterPackage);

  Public
    Procedure AfterConstruction; Override;

  End;

  TTSTOXMLCategory = Class(TXmlNodeCollectionEx, ITSTOHackMasterCategory, IXmlTSTOHackMasterCategory)
  Private
    FCategoryImpl : ITSTOHackMasterCategory;

    Function GetImplementor() : ITSTOHackMasterCategory;

  Protected
    Property CategoryImpl : ITSTOHackMasterCategory Read GetImplementor Implements ITSTOHackMasterCategory;

    Function GetPackage(Index: Integer): IXmlTSTOHackMasterPackage;

    Function  GetName() : String;
    Procedure SetName(Const Value: String);

    Function  GetEnabled() : Boolean;
    Procedure SetEnabled(Const AEnabled : Boolean);

    Function  GetBuildStore() : Boolean;
    Procedure SetBuildStore(Const ABuildStore : Boolean);

    Function Add() : IXmlTSTOHackMasterPackage;
    Function Insert(Const Index: Integer): IXmlTSTOHackMasterPackage;

    Procedure Assign(ASource : IInterface);
    Procedure AssignTo(ATarget : ITSTOHackMasterCategory);

  Public
    Procedure AfterConstruction; Override;

  End;

  TTSTOXMLMasterListImpl = Class(TXmlNodeCollectionEx, ITSTOHackMasterList, IXmlTSTOHackMasterList)
  Private
    FMasterListImpl : ITSTOHackMasterList;

    Function GetImplementor() : ITSTOHackMasterList;

  Protected
    Property CategoryImpl : ITSTOHackMasterList Read GetImplementor Implements ITSTOHackMasterList;

    Function GetCategory(Index: Integer): IXmlTSTOHackMasterCategory;
    Function Add: IXmlTSTOHackMasterCategory;
    Function Insert(Const Index: Integer): IXmlTSTOHackMasterCategory;

    Procedure Assign(ASource : IInterface);
    Procedure AssignTo(ATarget : ITSTOHackMasterList);

  Public
    Procedure AfterConstruction; Override;

  End;

Class Function TXmlTSTOHackMasterList.CreateMasterList() : IXmlTSTOHackMasterList;
Begin
  Result := NewXMLDocument().GetDocBinding('MasterLists', TTSTOXMLMasterListImpl, '') As IXmlTSTOHackMasterList;
End;

Class Function TXmlTSTOHackMasterList.CreateMasterList(Const AXmlText : String) : IXmlTSTOHackMasterList;
Begin
  Result := LoadXmlData(AXmlText).GetDocBinding('MasterLists', TTSTOXMLMasterListImpl, '') As IXmlTSTOHackMasterList;
//  InitMiscData(Result);
End;

Class Procedure TXmlTSTOHackMasterList.InitMiscData(AXmlDoc : IXmlTSTOHackMasterList);
Var lXml : IXmlDocumentEx;
    W, X ,
    Y, Z : Integer;
Begin
  For X := 0 To AXmlDoc.Count - 1 Do
    For Y := 0 To AXmlDoc.Category[X].Count - 1 Do
      For Z := 0 To AXmlDoc.Category[X].Package[Y].Count - 1 Do
        If AXmlDoc.Category[X].Package[Y].DataID[Z].HasChildNodes Then
        Begin
          lXml := NewXmlDocument('');
          Try
            With lXml.AddChild('MiscData').ChildNodes Do
              For W := 0 To AXmlDoc.Category[X].Package[Y].DataID[Z].ChildNodes.Count - 1 Do
                Add(AXmlDoc.Category[X].Package[Y].DataID[Z].ChildNodes[W].CloneNode(True));
            AXmlDoc.Category[X].Package[Y].DataID[Z].MiscData.Text := lXml.Xml.Text;

            Finally
              lXml := Nil;
          End;
        End;
End;

{ TTSTOXMLMasterListsType }

Procedure TTSTOXMLMasterListImpl.AfterConstruction;
Begin
  RegisterChildNode('Category', TTSTOXMLCategory);
  ItemTag := 'Category';
  ItemInterface := IXmlTSTOHackMasterCategory;
  Inherited;
End;

Function TTSTOXMLMasterListImpl.GetImplementor() : ITSTOHackMasterList;
Begin
  If Not Assigned(FMasterListImpl) Then
    FMasterListImpl := TTSTOHackMasterList.Create();
  Result := FMasterListImpl;

  AssignTo(Result);
End;

Procedure TTSTOXMLMasterListImpl.Assign(ASource : IInterface);
Var lXmlSrc : IXmlTSTOHackMasterList;
    lSrc : ITSTOHackMasterList;
    X : Integer;
Begin
  If Supports(ASource, IXMLNodeCollectionEx) And
     Supports(ASource, IXmlTSTOHackMasterList, lXmlSrc) Then
  Begin
    Clear();

    For X := 0 To lXmlSrc.Count - 1 Do
      Add().Assign(lXmlSrc[X]);
  End
  Else If Supports(ASource, ITSTOHackMasterList, lSrc) Then
  Begin
    Clear();

    For X := 0 To lSrc.Count - 1 Do
      Add().Assign(lSrc[X]);

    FMasterListImpl := lSrc;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Procedure TTSTOXMLMasterListImpl.AssignTo(ATarget : ITSTOHackMasterList);
Var X : Integer;
Begin
  ATarget.Clear();

  For X := 0 To List.Count - 1 Do
    ATarget.Add().Assign(List[X]);
End;

Function TTSTOXMLMasterListImpl.GetCategory(Index: Integer): IXmlTSTOHackMasterCategory;
Begin
  Result := List[Index] As IXmlTSTOHackMasterCategory;
End;

Function TTSTOXMLMasterListImpl.Add: IXmlTSTOHackMasterCategory;
Begin
  Result := AddItem(-1) As IXmlTSTOHackMasterCategory;
End;

Function TTSTOXMLMasterListImpl.Insert(Const Index: Integer): IXmlTSTOHackMasterCategory;
Begin
  Result := AddItem(Index) As IXmlTSTOHackMasterCategory;
End;

{ TTSTOXMLCategoryType }

Procedure TTSTOXMLCategory.AfterConstruction;
Begin
  RegisterChildNode('Package', TTSTOXMLPackage);
  ItemTag := 'Package';
  ItemInterface := IXmlTSTOHackMasterPackage;
  Inherited;
End;

Function TTSTOXMLCategory.GetImplementor() : ITSTOHackMasterCategory;
Begin
  If Not Assigned(FCategoryImpl) Then
    FCategoryImpl := TTSTOHackMasterCategory.Create();
  Result := FCategoryImpl;

  AssignTo(FCategoryImpl);
End;

Procedure TTSTOXMLCategory.Assign(ASource : IInterface);
Var lXmlSrc : IXmlTSTOHackMasterCategory;
    lSrc : ITSTOHackMasterCategory;
    X : Integer;
Begin
  If Supports(ASource, IXMLNodeCollectionEx) And
     Supports(ASource, IXmlTSTOHackMasterCategory, lXmlSrc) Then
  Begin
    Clear();

    SetName(lXmlSrc.Name);
    SetEnabled(lXmlSrc.Enabled);
    SetBuildStore(lXmlSrc.BuildStore);
    For X := 0 To lXmlSrc.Count - 1 Do
      Add().Assign(lXmlSrc[X]);
  End
  Else If Supports(ASource, ITSTOHackMasterCategory, lSrc) Then
  Begin
    Clear();

    SetName(lSrc.Name);
    SetEnabled(lSrc.Enabled);
    SetBuildStore(lSrc.BuildStore);
    For X := 0 To lSrc.Count - 1 Do
      Add().Assign(lSrc[X]);

    FCategoryImpl := lSrc;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Procedure TTSTOXMLCategory.AssignTo(ATarget : ITSTOHackMasterCategory);
Var X : Integer;
Begin
  ATarget.Clear();
  ATarget.Name := GetName();
  ATarget.Enabled := GetEnabled();
  ATarget.BuildStore := GetBuildStore();

  For X := 0 To List.Count - 1 Do
    ATarget.Add().Assign(List[X]);
End;

Function TTSTOXMLCategory.GetName: String;
Begin
  Result := AttributeNodes['Name'].Text;
End;

Procedure TTSTOXMLCategory.SetName(Const Value: String);
Begin
  SetAttribute('Name', Value);

  If Assigned(FCategoryImpl) Then
    FCategoryImpl.Name := Value;
End;

Function TTSTOXMLCategory.GetEnabled() : Boolean;
Begin
  If VarIsNull(AttributeNodes['Enabled'].NodeValue) Then
    Result := False
  Else If VarIsStr(AttributeNodes['Enabled'].NodeValue) Then
    Result := StrToBoolDef(AttributeNodes['Enabled'].NodeValue, False)
  Else If VarIsNumeric(AttributeNodes['Enabled'].NodeValue) Then
    Result := AttributeNodes['Enabled'].NodeValue <> 0
  Else
    Raise Exception.Create('Invalid data type ' + IntToStr(VarType(AttributeNodes['Enabled'].NodeValue)) + '.');
End;

Procedure TTSTOXMLCategory.SetEnabled(Const AEnabled : Boolean);
Begin
  SetAttribute('Enabled', AEnabled);

  If Assigned(FCategoryImpl) Then
    FCategoryImpl.Enabled := AEnabled;
End;

Function TTSTOXMLCategory.GetBuildStore() : Boolean;
Begin
  If VarIsNull(AttributeNodes['BuildStore'].NodeValue) Then
    Result := False
  Else If VarIsStr(AttributeNodes['BuildStore'].NodeValue) Then
    Result := StrToBoolDef(AttributeNodes['BuildStore'].NodeValue, False)
  Else If VarIsNumeric(AttributeNodes['BuildStore'].NodeValue) Then
    Result := AttributeNodes['BuildStore'].NodeValue <> 0
  Else
    Raise Exception.Create('Invalid data type ' + IntToStr(VarType(AttributeNodes['BuildStore'].NodeValue)) + '.');
End;

Procedure TTSTOXMLCategory.SetBuildStore(Const ABuildStore : Boolean);
Begin
  SetAttribute('BuildStore', ABuildStore);

  If Assigned(FCategoryImpl) Then
    FCategoryImpl.BuildStore := ABuildStore;
End;

Function TTSTOXMLCategory.GetPackage(Index: Integer): IXmlTSTOHackMasterPackage;
Begin
  Result := List[Index] As IXmlTSTOHackMasterPackage;
End;

Function TTSTOXMLCategory.Add: IXmlTSTOHackMasterPackage;
Begin
  Result := AddItem(-1) As IXmlTSTOHackMasterPackage;
End;

Function TTSTOXMLCategory.Insert(Const Index: Integer): IXmlTSTOHackMasterPackage;
Begin
  Result := AddItem(Index) As IXmlTSTOHackMasterPackage;
End;

{ TTSTOXMLPackageType }

Procedure TTSTOXMLPackage.AfterConstruction;
Begin
  RegisterChildNode('DataID', TTSTOXMLDataID);
  ItemTag := 'DataID';
  ItemInterface := IXmlTSTOHackMasterDataID;

  Inherited;
End;

Function TTSTOXMLPackage.GetImplementor() : ITSTOHackMasterPackage;
Begin
  If Not Assigned(FMasterImpl) Then
    FMasterImpl := TTSTOHackMasterPackage.Create();
  Result := FMasterImpl;

  AssignTo(FMasterImpl);
End;

Procedure TTSTOXMLPackage.Assign(ASource : IInterface);
Var lXmlSrc : IXmlTSTOHackMasterPackage;
    lSrc : ITSTOHackMasterPackage;
    X : Integer;
Begin
  If Supports(ASource, IXMLNodeCollectionEx) And
     Supports(ASource, IXmlTSTOHackMasterPackage, lXmlSrc) Then
  Begin
    Clear();

    SetPackageType(lXmlSrc.PackageType);
    SetXmlFile(lXmlSrc.XmlFile);
    SetEnabled(lXmlSrc.Enabled);

    For X := 0 To lXmlSrc.Count - 1 Do
      Add().Assign(lXmlSrc[X]);
  End
  Else If Supports(ASource, ITSTOHackMasterPackage, lSrc) Then
  Begin
    Clear();

    SetPackageType(lSrc.PackageType);
    SetXmlFile(lSrc.XmlFile);
    SetEnabled(lSrc.Enabled);

    For X := 0 To lSrc.Count - 1 Do
      Add().Assign(lSrc[X]);

    FMasterImpl := lSrc;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Procedure TTSTOXMLPackage.AssignTo(ATarget : ITSTOHackMasterPackage);
Var X : Integer;
    lItem : ITSTOHackMasterDataID;
Begin
  ATarget.Clear();
  ATarget.PackageType := GetPackageType();
  ATarget.XmlFile := GetXmlFile();
  ATarget.Enabled := GetEnabled();
  
  For X := 0 To Count - 1 Do
    If Supports(List[X], ITSTOHackMasterDataID, lItem) Then
      ATarget.Add().Assign(lItem);
End;

Function TTSTOXMLPackage.GetPackageType() : String;
Begin
  Result := AttributeNodes['Type'].Text;
End;

Procedure TTSTOXMLPackage.SetPackageType(Const Value: String);
Begin
  SetAttribute('Type', Value);

  If Assigned(FMasterImpl) Then
    FMasterImpl.PackageType := Value;
End;

Function TTSTOXMLPackage.GetXmlFile() : String;
Begin
  Result := AttributeNodes['XmlFile'].Text;
End;

Procedure TTSTOXMLPackage.SetXmlFile(Const Value : String);
Begin
  SetAttribute('XmlFile', Value);

  If Assigned(FMasterImpl) Then
    FMasterImpl.XmlFile := Value;
End;

Function TTSTOXMLPackage.GetEnabled() : Boolean;
Begin
  If VarIsNull(AttributeNodes['Enabled'].NodeValue) Then
    Result := False
  Else If VarIsStr(AttributeNodes['Enabled'].NodeValue) Then
    Result := StrToBoolDef(AttributeNodes['Enabled'].NodeValue, False)
  Else If VarIsNumeric(AttributeNodes['Enabled'].NodeValue) Then
    Result := AttributeNodes['Enabled'].NodeValue <> 0
  Else
    Raise Exception.Create('Invalid data type ' + IntToStr(VarType(AttributeNodes['Enabled'].NodeValue)) + '.');
End;

Procedure TTSTOXMLPackage.SetEnabled(Const AEnabled : Boolean);
Begin
  SetAttribute('Enabled', AEnabled);

  If Assigned(FMasterImpl) Then
    FMasterImpl.Enabled := AEnabled;
End;

Function TTSTOXMLPackage.GetDataID(Index: Integer): IXmlTSTOHackMasterDataID;
Begin
  Result := List[Index] As IXmlTSTOHackMasterDataID;
End;

Function TTSTOXMLPackage.Add: IXmlTSTOHackMasterDataID;
Begin
  Result := AddItem(-1) As IXmlTSTOHackMasterDataID;
  If Assigned(FMasterImpl) Then
    FMasterImpl.Add(Result As ITSTOHackMasterDataID);
End;

Function TTSTOXMLPackage.Insert(Const Index: Integer): IXmlTSTOHackMasterDataID;
Begin
  Result := AddItem(Index) As IXmlTSTOHackMasterDataID;
End;

{ TTSTOXMLDataIDType }

Procedure TTSTOXMLDataID.AfterConstruction();
Begin
  InHerited AfterConstruction();

  FDataIDImpl := Pointer(ITSTOHackMasterDataID(Self));
End;

Function TTSTOXMLDataID.GetImplementor() : ITSTOHackMasterDataID;
Begin
  Result := ITSTOHackMasterDataID(FDataIDImpl);
End;

Function TTSTOXMLDataID.GetMiscData() : IHsStringListEx;
Var X : Integer;
Begin
  Result := THsStringListEx.CreateList();
  If ChildNodes.Count > 0 Then
  Begin
    Result.Add('<MiscData>');
    For X := 0 To ChildNodes.Count - 1 Do
      Result.Add(ChildNodes[X].Xml);
    Result.Add('</MiscData>');
  End;
End;

Procedure TTSTOXMLDataID.Assign(ASource : IInterface);
Var lXmlSrc : IXmlTSTOHackMasterDataID;
    lSrc : ITSTOHackMasterDataID;
    lXml : IXmlDocumentEx;
    X : Integer;
Begin
  If Supports(ASource, IXmlNodeEx) And
     Supports(ASource, IXmlTSTOHackMasterDataID, lXmlSrc) Then
  Begin
    SetId(lXmlSrc.Id);
    SetName(lXmlSrc.Name);
    SetAddInStore(lXmlSrc.AddInStore);
    SetOverRide(lXmlSrc.OverRide);
    SetIsBadItem(lXmlSrc.IsBadItem);

    If lXmlSrc.MiscData.Text <> '' Then
    Begin
      lXml := LoadXmlData(lXmlSrc.MiscData.Text);
      For X := 0 To lXml.DocumentElement.ChildNodes.Count - 1 Do
        ChildNodes.Add(lXml.DocumentElement.ChildNodes[X].CloneNode(True));
    End;
  End
  Else If Supports(ASource, ITSTOHackMasterDataID, lSrc) Then
  Begin
    SetId(lSrc.Id);
    SetName(lSrc.Name);
    SetAddInStore(lSrc.AddInStore);
    SetOverRide(lSrc.OverRide);
    SetIsBadItem(lSrc.IsBadItem);

    If lSrc.MiscData.Text <> '' Then
    Begin
      lXml := LoadXmlData(lSrc.MiscData.Text);
      For X := 0 To lXml.DocumentElement.ChildNodes.Count - 1 Do
        ChildNodes.Add(lXml.DocumentElement.ChildNodes[X].CloneNode(True));
    End;

    FDataIDImpl := Pointer(lSrc);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TTSTOXMLDataID.GetId: Integer;
Begin
  Result := AttributeNodes['id'].NodeValue;
End;

Procedure TTSTOXMLDataID.SetId(Const Value: Integer);
Begin
  SetAttribute('id', Value);

  If Not IsImplementorOf(DataIDImpl) Then
    DataIDImpl.Id := Value;
End;

Function TTSTOXMLDataID.GetName: String;
Begin
  Result := AttributeNodes['name'].Text;
End;

Procedure TTSTOXMLDataID.SetName(Const Value: String);
Begin
  SetAttribute('name', Value);

  If Not IsImplementorOf(DataIDImpl) Then
    DataIDImpl.Name := Value;
End;

Function TTSTOXMLDataID.GetAddInStore() : Boolean;
Begin
  If VarIsNull(AttributeNodes['AddInStore'].NodeValue) Then
    Result := False
  Else If VarIsStr(AttributeNodes['AddInStore'].NodeValue) Then
    Result := StrToBoolDef(AttributeNodes['AddInStore'].NodeValue, False)
  Else If VarIsNumeric(AttributeNodes['AddInStore'].NodeValue) Then
    Result := AttributeNodes['AddInStore'].NodeValue <> 0
  Else
    Raise Exception.Create('Invalid data type ' + IntToStr(VarType(AttributeNodes['AddInStore'].NodeValue)) + '.');
End;

Procedure TTSTOXMLDataID.SetAddInStore(Const AAddInStore : Boolean);
Begin
  SetAttribute('AddInStore', AAddInStore);

  If Not IsImplementorOf(DataIDImpl) Then
    DataIDImpl.AddInStore := AAddInStore;
End;

Function TTSTOXMLDataID.GetOverRide() : Boolean;
Begin
  If VarIsNull(AttributeNodes['OverRide'].NodeValue) Then
    Result := False
  Else If VarIsStr(AttributeNodes['OverRide'].NodeValue) Then
    Result := StrToBoolDef(AttributeNodes['OverRide'].NodeValue, False)
  Else If VarIsNumeric(AttributeNodes['OverRide'].NodeValue) Then
    Result := AttributeNodes['OverRide'].NodeValue <> 0
  Else
    Raise Exception.Create('Invalid data type ' + IntToStr(VarType(AttributeNodes['OverRide'].NodeValue)) + '.');
End;

Procedure TTSTOXMLDataID.SetOverRide(Const AOverRide : Boolean);
Begin
  SetAttribute('OverRide', AOverRide);

  If Not IsImplementorOf(DataIDImpl) Then
    DataIDImpl.OverRide := AOverRide;
End;

Function TTSTOXMLDataID.GetIsBadItem() : Boolean;
Begin
  If VarIsNull(AttributeNodes['IsBadItem'].NodeValue) Then
    Result := False
  Else If VarIsStr(AttributeNodes['IsBadItem'].NodeValue) Then
    Result := StrToBoolDef(AttributeNodes['IsBadItem'].NodeValue, False)
  Else If VarIsNumeric(AttributeNodes['IsBadItem'].NodeValue) Then
    Result := AttributeNodes['IsBadItem'].NodeValue <> 0
  Else
    Raise Exception.Create('Invalid data type ' + IntToStr(VarType(AttributeNodes['IsBadItem'].NodeValue)) + '.');
End;

Procedure TTSTOXMLDataID.SetIsBadItem(Const AIsBadItem : Boolean);
Begin
  SetAttribute('IsBadItem', AIsBadItem);

  If Not IsImplementorOf(DataIDImpl) Then
    DataIDImpl.IsBadItem := AIsBadItem;
End;

End.  