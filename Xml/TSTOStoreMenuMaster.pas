Unit TSTOStoreMenuMaster;

Interface

Uses XMLDoc, XMLIntf;

Type
  ITSTOXmlStoreObject = Interface(IXmlNode)
    ['{323CE256-39FA-4CD0-BC10-D469F87D108F}']
    Function GetType_: Widestring;
    Function GetId: Integer;
    Function GetName: Widestring;
    Function GetShowDuringTutorial: Widestring;
    Function GetAllowRandomRecommendation: Widestring;
    Procedure SetType_(Value: Widestring);
    Procedure SetId(Value: Integer);
    Procedure SetName(Value: Widestring);
    Procedure SetShowDuringTutorial(Value: Widestring);
    Procedure SetAllowRandomRecommendation(Value: Widestring);

    Property StoreObjectType           : Widestring Read GetType_                     Write SetType_;
    Property Id                        : Integer    Read GetId                        Write SetId;
    Property Name                      : Widestring Read GetName                      Write SetName;
    Property ShowDuringTutorial        : Widestring Read GetShowDuringTutorial        Write SetShowDuringTutorial;
    Property AllowRandomRecommendation : Widestring Read GetAllowRandomRecommendation Write SetAllowRandomRecommendation;

  End;

  ITSTOXmlStoreObjectList = Interface(IXmlNodeCollection)
    ['{E910BBDA-1117-4B31-9341-503FEA896D53}']
    Function Add: ITSTOXmlStoreObject;
    Function Insert(Const Index: Integer): ITSTOXmlStoreObject;
    Function GetItem(Index: Integer): ITSTOXmlStoreObject;
    Property Items[Index: Integer]: ITSTOXmlStoreObject Read GetItem; Default;

  End;

  ITSTOXmlStoreRequirement = Interface(IXmlNode)
    ['{112587AE-9AA7-4748-8E58-55A53B49676E}']
    Function GetType_: Widestring;
    Function GetQuest: Widestring;
    Procedure SetType_(Value: Widestring);
    Procedure SetQuest(Value: Widestring);

    Property StoreReqType : Widestring Read GetType_ Write SetType_;
    Property Quest        : Widestring Read GetQuest Write SetQuest;

  End;

  ITSTOXmlStoreRequirements = Interface(IXmlNodeCollection)
    ['{85817538-5B24-4053-A608-79D5D7A6DC61}']
    Function GetRequirement(Index: Integer): ITSTOXmlStoreRequirement;

    Function Add: ITSTOXmlStoreRequirement;
    Function Insert(Const Index: Integer): ITSTOXmlStoreRequirement;
    Property Requirement[Index: Integer]: ITSTOXmlStoreRequirement Read GetRequirement; Default;

  End;

  ITSTOXmlStoreCategory = Interface(IXmlNode)
    ['{8DB9BC2E-DE9A-4EE2-9976-0317657B7BEF}']
    Function GetName: Widestring;
    Function GetTitle: Widestring;
    Function GetBaseCategory: Widestring;
    Function GetIcon: Widestring;
    Function GetDisabledIcon: Widestring;
    Function GetEmptyText: Widestring;
    Function GetFile_: Widestring;
    Function GetObject_: ITSTOXmlStoreObjectList;
    Function GetRequirements: ITSTOXmlStoreRequirements;
    Procedure SetName(Value: Widestring);
    Procedure SetTitle(Value: Widestring);
    Procedure SetBaseCategory(Value: Widestring);
    Procedure SetIcon(Value: Widestring);
    Procedure SetDisabledIcon(Value: Widestring);
    Procedure SetEmptyText(Value: Widestring);
    Procedure SetFile_(Value: Widestring);

    Property Name         : Widestring                Read GetName         Write SetName;
    Property Title        : Widestring                Read GetTitle        Write SetTitle;
    Property BaseCategory : Widestring                Read GetBaseCategory Write SetBaseCategory;
    Property Icon         : Widestring                Read GetIcon         Write SetIcon;
    Property DisabledIcon : Widestring                Read GetDisabledIcon Write SetDisabledIcon;
    Property EmptyText    : Widestring                Read GetEmptyText    Write SetEmptyText;
    Property FileName     : Widestring                Read GetFile_        Write SetFile_;
    Property StoreObject  : ITSTOXmlStoreObjectList   Read GetObject_;
    Property Requirements : ITSTOXmlStoreRequirements Read GetRequirements;

  End;

  ITSTOXmlStoreCategoryList = Interface(IXmlNodeCollection)
    ['{2F47CB96-F8BF-4B75-A59E-A52D7DDEFB12}']
    Function Add: ITSTOXmlStoreCategory;
    Function Insert(Const Index: Integer): ITSTOXmlStoreCategory;
    Function GetItem(Index: Integer): ITSTOXmlStoreCategory;

    Property Items[Index: Integer]: ITSTOXmlStoreCategory Read GetItem; Default;

  End;
    
  ITSTOXmlStoreMenus = Interface(IXmlNodeCollection)
    ['{7FB363C6-0643-4A56-ABAB-CAE50BAD11A9}']
    Function GetCategory(Index: Integer): ITSTOXmlStoreCategory;
    Function Add: ITSTOXmlStoreCategory;
    Function Insert(Const Index: Integer): ITSTOXmlStoreCategory;

    Property Category[Index: Integer]: ITSTOXmlStoreCategory Read GetCategory; Default;

  End;

{ Global Functions }

Function GetStoreMenus(Doc: IXmlDocument): ITSTOXmlStoreMenus;
Function LoadStoreMenus(Const FileName: Widestring): ITSTOXmlStoreMenus;
Function NewStoreMenus: ITSTOXmlStoreMenus;

Const
  TargetNamespace = '';

Implementation

Type
  TXMLStoreMenusType = Class(TXMLNodeCollection, ITSTOXmlStoreMenus)
  Protected
    Function GetCategory(Index: Integer): ITSTOXmlStoreCategory;
    Function Add: ITSTOXmlStoreCategory;
    Function Insert(Const Index: Integer): ITSTOXmlStoreCategory;

  Public
    Procedure AfterConstruction; Override;

  End;

  TXMLCategoryType = Class(TXMLNode, ITSTOXmlStoreCategory)
  Private
    FObject_: ITSTOXmlStoreObjectList;

  Protected
    Function GetName: Widestring;
    Function GetTitle: Widestring;
    Function GetBaseCategory: Widestring;
    Function GetIcon: Widestring;
    Function GetDisabledIcon: Widestring;
    Function GetEmptyText: Widestring;
    Function GetFile_: Widestring;
    Function GetObject_: ITSTOXmlStoreObjectList;
    Function GetRequirements: ITSTOXmlStoreRequirements;
    Procedure SetName(Value: Widestring);
    Procedure SetTitle(Value: Widestring);
    Procedure SetBaseCategory(Value: Widestring);
    Procedure SetIcon(Value: Widestring);
    Procedure SetDisabledIcon(Value: Widestring);
    Procedure SetEmptyText(Value: Widestring);
    Procedure SetFile_(Value: Widestring);

  Public
    Procedure AfterConstruction; Override;

  End;

  TXMLCategoryTypeList = Class(TXMLNodeCollection, ITSTOXmlStoreCategoryList)
  Protected
    Function Add: ITSTOXmlStoreCategory;
    Function Insert(Const Index: Integer): ITSTOXmlStoreCategory;
    Function GetItem(Index: Integer): ITSTOXmlStoreCategory;

  End;

  TXMLObjectType = Class(TXMLNode, ITSTOXmlStoreObject)
  Protected
    Function GetType_: Widestring;
    Function GetId: Integer;
    Function GetName: Widestring;
    Function GetShowDuringTutorial: Widestring;
    Function GetAllowRandomRecommendation: Widestring;
    Procedure SetType_(Value: Widestring);
    Procedure SetId(Value: Integer);
    Procedure SetName(Value: Widestring);
    Procedure SetShowDuringTutorial(Value: Widestring);
    Procedure SetAllowRandomRecommendation(Value: Widestring);

  End;

  TXMLObjectTypeList = Class(TXMLNodeCollection, ITSTOXmlStoreObjectList)
  Protected
    Function Add: ITSTOXmlStoreObject;
    Function Insert(Const Index: Integer): ITSTOXmlStoreObject;
    Function GetItem(Index: Integer): ITSTOXmlStoreObject;

  End;

  TXMLRequirementsType = Class(TXMLNodeCollection, ITSTOXmlStoreRequirements)
  Protected
    Function GetRequirement(Index: Integer): ITSTOXmlStoreRequirement;
    Function Add: ITSTOXmlStoreRequirement;
    Function Insert(Const Index: Integer): ITSTOXmlStoreRequirement;

  Public
    Procedure AfterConstruction; Override;

  End;

  TXMLRequirementType = Class(TXMLNode, ITSTOXmlStoreRequirement)
  Protected
    Function GetType_: Widestring;
    Function GetQuest: Widestring;
    Procedure SetType_(Value: Widestring);
    Procedure SetQuest(Value: Widestring);

  End;

//  TXMLRequirementTypeList = Class(TXMLNodeCollection, ITSTOXmlStoreRequirementList)
//  Protected
//    Function Add: ITSTOXmlStoreRequirement;
//    Function Insert(Const Index: Integer): ITSTOXmlStoreRequirement;
//    Function GetItem(Index: Integer): ITSTOXmlStoreRequirement;
//
//  End;

(******************************************************************************)

{ Global Functions }

Function GetStoreMenus(Doc: IXmlDocument): ITSTOXmlStoreMenus;
Begin
  Result := Doc.GetDocBinding('StoreMenus', TXMLStoreMenusType, TargetNamespace) As ITSTOXmlStoreMenus;
End;

Function LoadStoreMenus(Const FileName: Widestring): ITSTOXmlStoreMenus;
Begin
  Result := LoadXMLDocument(FileName).GetDocBinding('StoreMenus', TXMLStoreMenusType, TargetNamespace) As ITSTOXmlStoreMenus;
End;

Function NewStoreMenus: ITSTOXmlStoreMenus;
Begin
  Result := NewXMLDocument.GetDocBinding('StoreMenus', TXMLStoreMenusType, TargetNamespace) As ITSTOXmlStoreMenus;
End;

{ TXMLStoreMenusType }

Procedure TXMLStoreMenusType.AfterConstruction;
Begin
  RegisterChildNode('Category', TXMLCategoryType);
  ItemTag := 'Category';
  ItemInterface := ITSTOXmlStoreCategory;
  Inherited;
End;

Function TXMLStoreMenusType.GetCategory(Index: Integer): ITSTOXmlStoreCategory;
Begin
  Result := List[Index] As ITSTOXmlStoreCategory;
End;

Function TXMLStoreMenusType.Add: ITSTOXmlStoreCategory;
Begin
  Result := AddItem(-1) As ITSTOXmlStoreCategory;
End;

Function TXMLStoreMenusType.Insert(Const Index: Integer): ITSTOXmlStoreCategory;
Begin
  Result := AddItem(Index) As ITSTOXmlStoreCategory;
End;

{ TXMLCategoryType }

Procedure TXMLCategoryType.AfterConstruction;
Begin
  RegisterChildNode('Object', TXMLObjectType);
  RegisterChildNode('Requirements', TXMLRequirementsType);
  FObject_ := CreateCollection(TXMLObjectTypeList, ITSTOXmlStoreObject, 'Object') As ITSTOXmlStoreObjectList;
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

Function TXMLCategoryType.GetTitle: Widestring;
Begin
  Result := AttributeNodes['title'].Text;
End;

Procedure TXMLCategoryType.SetTitle(Value: Widestring);
Begin
  SetAttribute('title', Value);
End;

Function TXMLCategoryType.GetBaseCategory: Widestring;
Begin
  Result := AttributeNodes['baseCategory'].Text;
End;

Procedure TXMLCategoryType.SetBaseCategory(Value: Widestring);
Begin
  SetAttribute('baseCategory', Value);
End;

Function TXMLCategoryType.GetIcon: Widestring;
Begin
  Result := AttributeNodes['icon'].Text;
End;

Procedure TXMLCategoryType.SetIcon(Value: Widestring);
Begin
  SetAttribute('icon', Value);
End;

Function TXMLCategoryType.GetDisabledIcon: Widestring;
Begin
  Result := AttributeNodes['disabledIcon'].Text;
End;

Procedure TXMLCategoryType.SetDisabledIcon(Value: Widestring);
Begin
  SetAttribute('disabledIcon', Value);
End;

Function TXMLCategoryType.GetEmptyText: Widestring;
Begin
  Result := AttributeNodes['emptyText'].Text;
End;

Procedure TXMLCategoryType.SetEmptyText(Value: Widestring);
Begin
  SetAttribute('emptyText', Value);
End;

Function TXMLCategoryType.GetFile_: Widestring;
Begin
  Result := AttributeNodes['file'].Text;
End;

Procedure TXMLCategoryType.SetFile_(Value: Widestring);
Begin
  SetAttribute('file', Value);
End;

Function TXMLCategoryType.GetObject_: ITSTOXmlStoreObjectList;
Begin
  Result := FObject_;
End;

Function TXMLCategoryType.GetRequirements: ITSTOXmlStoreRequirements;
Begin
  Result := ChildNodes['Requirements'] As ITSTOXmlStoreRequirements;
End;

{ TXMLCategoryTypeList }

Function TXMLCategoryTypeList.Add: ITSTOXmlStoreCategory;
Begin
  Result := AddItem(-1) As ITSTOXmlStoreCategory;
End;

Function TXMLCategoryTypeList.Insert(Const Index: Integer): ITSTOXmlStoreCategory;
Begin
  Result := AddItem(Index) As ITSTOXmlStoreCategory;
End;
Function TXMLCategoryTypeList.GetItem(Index: Integer): ITSTOXmlStoreCategory;
Begin
  Result := List[Index] As ITSTOXmlStoreCategory;
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

Function TXMLObjectType.GetShowDuringTutorial: Widestring;
Begin
  Result := AttributeNodes['showDuringTutorial'].Text;
End;

Procedure TXMLObjectType.SetShowDuringTutorial(Value: Widestring);
Begin
  SetAttribute('showDuringTutorial', Value);
End;

Function TXMLObjectType.GetAllowRandomRecommendation: Widestring;
Begin
  Result := AttributeNodes['allowRandomRecommendation'].Text;
End;

Procedure TXMLObjectType.SetAllowRandomRecommendation(Value: Widestring);
Begin
  SetAttribute('allowRandomRecommendation', Value);
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

{ TXMLRequirementsType }

Procedure TXMLRequirementsType.AfterConstruction;
Begin
  RegisterChildNode('Requirement', TXMLRequirementType);
  ItemTag := 'Requirement';
  ItemInterface := ITSTOXmlStoreRequirement;
  Inherited;
End;

Function TXMLRequirementsType.GetRequirement(Index: Integer): ITSTOXmlStoreRequirement;
Begin
  Result := List[Index] As ITSTOXmlStoreRequirement;
End;

Function TXMLRequirementsType.Add: ITSTOXmlStoreRequirement;
Begin
  Result := AddItem(-1) As ITSTOXmlStoreRequirement;
End;

Function TXMLRequirementsType.Insert(Const Index: Integer): ITSTOXmlStoreRequirement;
Begin
  Result := AddItem(Index) As ITSTOXmlStoreRequirement;
End;

{ TXMLRequirementType }

Function TXMLRequirementType.GetType_: Widestring;
Begin
  Result := AttributeNodes['type'].Text;
End;

Procedure TXMLRequirementType.SetType_(Value: Widestring);
Begin
  SetAttribute('type', Value);
End;

Function TXMLRequirementType.GetQuest: Widestring;
Begin
  Result := AttributeNodes['quest'].Text;
End;

Procedure TXMLRequirementType.SetQuest(Value: Widestring);
Begin
  SetAttribute('quest', Value);
End;

End.