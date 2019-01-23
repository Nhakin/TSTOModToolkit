Unit TSTOStoreMenu;

Interface

Uses HsXmlDocEx;
  //xmldom, XMLDoc, XMLIntf;

Type
  ITSTOXmlStoreObjectSet = Interface(IXmlNodeEx)
    ['{7F78B039-92FB-41EE-9B5D-B3D369F24DDB}']
    Function  GetName() : Widestring;
    Procedure SetName(Value : Widestring);

    Property Name : Widestring Read GetName Write SetName;

  End;

  ITSTOXmlStoreObjectSetList = Interface(IXmlNodeCollectionEx)
    ['{B0BD25FA-8265-4987-B3FF-AD80CF4A395E}']
    Function Add: ITSTOXmlStoreObjectSet;
    Function Insert(Const Index: Integer): ITSTOXmlStoreObjectSet;
    Function GetItem(Index: Integer): ITSTOXmlStoreObjectSet;

    Property Items[Index: Integer]: ITSTOXmlStoreObjectSet Read GetItem; Default;

  End;

  ITSTOXmlStoreObject = Interface(IXmlNodeEx)
    ['{8600FC16-8255-4773-ADDE-6DED77E1F01F}']
    Function GetType_: Widestring;
    Function GetId: Integer;
    Function GetName: Widestring;
    Procedure SetType_(Value: Widestring);
    Procedure SetId(Value: Integer);
    Procedure SetName(Value: Widestring);

    Property ObjectType : Widestring Read GetType_ Write SetType_;
    Property Id         : Integer    Read GetId    Write SetId;
    Property Name       : Widestring Read GetName  Write SetName;

  End;

  ITSTOXmlStoreObjectList = Interface(IXmlNodeCollectionEx)
    ['{C7B9314F-D194-4761-9F0D-DAA81F9D9BA0}']
    Function Add: ITSTOXmlStoreObject;
    Function Insert(Const Index: Integer): ITSTOXmlStoreObject;
    Function GetItem(Index: Integer): ITSTOXmlStoreObject;

    Property Items[Index: Integer]: ITSTOXmlStoreObject Read GetItem; Default;

  End;

  ITSTOXmlStoreCategory = Interface(IXmlNodeEx)
    ['{81A1FCE3-0636-4CCF-ACB8-8D75726BF6EF}']
    Function GetName: Widestring;
    Function GetObjectSet: ITSTOXmlStoreObjectSetList;
    Function GetObjects: ITSTOXmlStoreObjectList;
    Procedure SetName(Value: Widestring);

    Property Name      : Widestring                 Read GetName Write SetName;
    Property ObjectSet : ITSTOXmlStoreObjectSetList Read GetObjectSet;
    Property Objects   : ITSTOXmlStoreObjectList    Read GetObjects;

  End;

{ Global Functions }

Function GetStoreCategory(Doc: IXmlDocumentEx): ITSTOXmlStoreCategory;
Function LoadStoreCategory(Const FileName: Widestring): ITSTOXmlStoreCategory;
Function NewStoreCategory: ITSTOXmlStoreCategory;

Const
  TargetNamespace = '';

Implementation

Type
  TXMLCategoryType = Class(TXMLNodeEx, ITSTOXmlStoreCategory)
  Private
    FObjectSet : ITSTOXmlStoreObjectSetList;
    FObjects   : ITSTOXmlStoreObjectList;

  Protected
    Function GetName: Widestring;
    Function GetObjectSet: ITSTOXmlStoreObjectSetList;
    Function GetObjects: ITSTOXmlStoreObjectList;
    Procedure SetName(Value: Widestring);

  Public
    Procedure AfterConstruction; Override;

  End;

  TXMLObjectSetType = Class(TXMLNodeEx, ITSTOXmlStoreObjectSet)
  Protected
    Function GetName: Widestring;
    Procedure SetName(Value: Widestring);

  End;

  TXMLObjectSetTypeList = Class(TXMLNodeCollectionEx, ITSTOXmlStoreObjectSetList)
  Protected
    Function Add: ITSTOXmlStoreObjectSet;
    Function Insert(Const Index: Integer): ITSTOXmlStoreObjectSet;
    Function GetItem(Index: Integer): ITSTOXmlStoreObjectSet;

  End;

  TXMLObjectType = Class(TXMLNodeEx, ITSTOXmlStoreObject)
  Protected
    Function GetType_: Widestring;
    Function GetId: Integer;
    Function GetName: Widestring;
    Procedure SetType_(Value: Widestring);
    Procedure SetId(Value: Integer);
    Procedure SetName(Value: Widestring);

  End;

  TXMLObjectTypeList = Class(TXMLNodeCollectionEx, ITSTOXmlStoreObjectList)
  Protected
    Function Add: ITSTOXmlStoreObject;
    Function Insert(Const Index: Integer): ITSTOXmlStoreObject;
    Function GetItem(Index: Integer): ITSTOXmlStoreObject;

  End;

(******************************************************************************)

{ Global Functions }

Function GetStoreCategory(Doc: IXmlDocumentEx): ITSTOXmlStoreCategory;
Begin
  Result := Doc.GetDocBinding('Category', TXMLCategoryType, TargetNamespace) As ITSTOXmlStoreCategory;
End;

Function LoadStoreCategory(Const FileName: Widestring): ITSTOXmlStoreCategory;
Begin
  Result := LoadXMLDocument(FileName).GetDocBinding('Category', TXMLCategoryType, TargetNamespace) As ITSTOXmlStoreCategory;
End;

Function NewStoreCategory: ITSTOXmlStoreCategory;
Begin
  Result := NewXMLDocument.GetDocBinding('Category', TXMLCategoryType, TargetNamespace) As ITSTOXmlStoreCategory;
End;

{ TXMLCategoryType }

Procedure TXMLCategoryType.AfterConstruction;
Begin
  RegisterChildNode('ObjectSet', TXMLObjectSetType);
  RegisterChildNode('Object', TXMLObjectType);
  FObjectSet := CreateCollection(TXMLObjectSetTypeList, ITSTOXmlStoreObjectSet, 'ObjectSet') As ITSTOXmlStoreObjectSetList;
  FObjects := CreateCollection(TXMLObjectTypeList, ITSTOXmlStoreObject, 'Object') As ITSTOXmlStoreObjectList;
  Inherited;
End;

Function TXMLCategoryType.GetName: Widestring;
Begin
  Result := AttributeNodes['name'].Text;
End;

Procedure TXMLCategoryType.SetName(Value: Widestring);
Begin
  SetAttribute('name', Value);
End;

Function TXMLCategoryType.GetObjectSet: ITSTOXmlStoreObjectSetList;
Begin
  Result := FObjectSet;
End;

Function TXMLCategoryType.GetObjects: ITSTOXmlStoreObjectList;
Begin
  Result := FObjects;
End;

{ TXMLObjectSetType }

Function TXMLObjectSetType.GetName: Widestring;
Begin
  Result := AttributeNodes['name'].Text;
End;

Procedure TXMLObjectSetType.SetName(Value: Widestring);
Begin
  SetAttribute('name', Value);
End;

{ TXMLObjectSetTypeList }

Function TXMLObjectSetTypeList.Add: ITSTOXmlStoreObjectSet;
Begin
  Result := AddItem(-1) As ITSTOXmlStoreObjectSet;
End;

Function TXMLObjectSetTypeList.Insert(Const Index: Integer): ITSTOXmlStoreObjectSet;
Begin
  Result := AddItem(Index) As ITSTOXmlStoreObjectSet;
End;
Function TXMLObjectSetTypeList.GetItem(Index: Integer): ITSTOXmlStoreObjectSet;
Begin
  Result := List[Index] As ITSTOXmlStoreObjectSet;
End;

{ TXMLObjectType }

Function TXMLObjectType.GetType_: Widestring;
Begin
  Result := AttributeNodes['type'].Text;
End;

Procedure TXMLObjectType.SetType_(Value: Widestring);
Begin
  SetAttribute('type', Value);
End;

Function TXMLObjectType.GetId: Integer;
Begin
  Result := AttributeNodes['id'].NodeValue;
End;

Procedure TXMLObjectType.SetId(Value: Integer);
Begin
  SetAttribute('id', Value);
End;

Function TXMLObjectType.GetName: Widestring;
Begin
  Result := AttributeNodes['name'].Text;
End;

Procedure TXMLObjectType.SetName(Value: Widestring);
Begin
  SetAttribute('name', Value);
End;

{ TXMLObjectTypeList }

Function TXMLObjectTypeList.Add: ITSTOXmlStoreObject;
Begin
  Result := AddItem(-1) As ITSTOXmlStoreObject;
End;

Function TXMLObjectTypeList.Insert(Const Index: Integer): ITSTOXmlStoreObject;
Begin
  Result := AddItem(Index) As ITSTOXmlStoreObject;
End;
Function TXMLObjectTypeList.GetItem(Index: Integer): ITSTOXmlStoreObject;
Begin
  Result := List[Index] As ITSTOXmlStoreObject;
End;

End.