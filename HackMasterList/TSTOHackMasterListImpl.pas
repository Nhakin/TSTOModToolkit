unit TSTOHackMasterListImpl;

interface

Uses HsInterfaceEx, HsStringListEx, TSTOHackMasterListIntf;

Type
  TTSTOHackMasterMovedItem = Class(TInterfacedObjectEx, ITSTOHackMasterMovedItem)
  Private
    FXmlFileName : String;
    FOldCategory : String;
    FNewCategory : String;

  Protected
    Function  GetXmlFileName() : String; Virtual;
    Procedure SetXmlFileName(Const AXmlFileName : String); Virtual;

    Function  GetOldCategory() : String; Virtual;
    Procedure SetOldCategory(Const AOldCategory : String); Virtual;

    Function  GetNewCategory() : String; Virtual;
    Procedure SetNewCategory(Const ANewCategory : String); Virtual;

    Procedure Assign(ASource : IInterface);

  End;

  TTSTOHackMasterMovedItems = Class(TInterfaceListEx, ITSTOHackMasterMovedItems)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : ITSTOHackMasterMovedItem; OverLoad;
    Procedure Put(Index : Integer; Const Item : ITSTOHackMasterMovedItem); OverLoad;

    Function Add() : ITSTOHackMasterMovedItem; OverLoad;
    Function Add(Const AItem : ITSTOHackMasterMovedItem) : Integer; OverLoad;

    Procedure Assign(ASource : IInterface);

  End;

  TTSTOHackMasterDataID = Class(TInterfacedObjectEx, ITSTOHackMasterDataID)
  Private
    FId           : Integer;
    FName         : String;
    FAddInStore   : Boolean;
    FOverRide     : Boolean;
    FIsBadItem    : Boolean;
    FObjectType   : String;
    FNPCCharacter : Boolean;
    FSkinObject   : String;
    FMiscData     : IHsStringListEx;

  Protected
    Procedure Created(); OverRide;

    Function  GetId() : Integer;
    Procedure SetId(Const AId : Integer);

    Function  GetName() : String;
    Procedure SetName(Const AName : String);

    Function  GetAddInStore() : Boolean;
    Procedure SetAddInStore(Const AAddInStore : Boolean);

    Function  GetOverRide() : Boolean;
    Procedure SetOverRide(Const AOverRide : Boolean);

    Function  GetIsBadItem() : Boolean;
    Procedure SetIsBadItem(Const AIsBadItem : Boolean);

    Function  GetObjectType() : String;
    Procedure SetObjectType(Const AObjectType : String);

    Function  GetNPCCharacter() : Boolean;
    Procedure SetNPCCharacter(Const ANPCCharacter : Boolean);

    Function  GetSkinObject() : String;
    Procedure SetSkinObject(Const ASkinObject : String);

    Function GetMiscData() : IHsStringListEx;

    Procedure Clear();

    Procedure Assign(ASource : IInterface);

  Public
    Destructor Destroy(); OverRide;
    
  End;

  TTSTOHackMasterPackage = Class(TInterfaceListEx, ITSTOHackMasterPackage)
  Private
    FPackageType : String;
    FXmlFile     : String;
    FEnabled     : Boolean;
    
    Function InternalSort(Item1, Item2 : IInterfaceEx) : Integer;

  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;

    Function Get(Index : Integer) : ITSTOHackMasterDataID; OverLoad;

    Function  GetPackageType() : String;
    Procedure SetPackageType(Const APackageType : String);

    Function  GetXmlFile() : String;
    Procedure SetXmlFile(Const AXmlFile : String);

    Function  GetEnabled() : Boolean;
    Procedure SetEnabled(Const AEnabled : Boolean);

    Function Add() : ITSTOHackMasterDataID; ReIntroduce; OverLoad;
    Function Add(Const AItem : ITSTOHackMasterDataID) : Integer; ReIntroduce; OverLoad;

    Procedure Clear(); OverRide;

    Procedure Assign(ASource : IInterface);
    Procedure Sort();

    Property DataID[Index: Integer] : ITSTOHackMasterDataID Read Get; Default;

  End;

  TTSTOHackMasterCategory = Class(TInterfaceListEx, ITSTOHackMasterCategory)
  Private
    FName       : String;
    FEnabled    : Boolean;
    FBuildStore : Boolean;

    Function InternalSort(Item1, Item2 : IInterfaceEx) : Integer;

  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;

    Function  Get(Index : Integer) : ITSTOHackMasterPackage; OverLoad;

    Function  GetName() : String;
    Procedure SetName(Const AName : String);

    Function  GetEnabled() : Boolean;
    Procedure SetEnabled(Const AEnabled : Boolean);

    Function  GetBuildStore() : Boolean;
    Procedure SetBuildStore(Const ABuildStore : Boolean);

    Function Add() : ITSTOHackMasterPackage; ReIntroduce; OverLoad;
    Function Add(Const AItem : ITSTOHackMasterPackage) : Integer; ReIntroduce; OverLoad;

    Procedure Clear(); OverRide;

    Procedure Assign(ASource : IInterface);
    Procedure Sort();

    Property Package[Index : Integer] : ITSTOHackMasterPackage Read Get; Default;

    Property Name       : String  Read GetName       Write SetName;
    Property Enabled    : Boolean Read GetEnabled    Write SetEnabled;
    Property BuildStore : Boolean Read GetBuildStore Write SetBuildStore;

  End;

  TTSTOHackMasterList = Class(TInterfaceListEx, ITSTOHackMasterList)
  Private
    FMovedItems : ITSTOHackMasterMovedItems;

    Function InternalSort(Item1, Item2 : IInterfaceEx) : Integer;

  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;

    Function Get(Index : Integer) : ITSTOHackMasterCategory; OverLoad;

    Function GetMovedItems() : ITSTOHackMasterMovedItems;

    Function Add() : ITSTOHackMasterCategory; ReIntroduce; OverLoad;
    Function Add(Const AItem : ITSTOHackMasterCategory) : Integer; ReIntroduce; OverLoad;

    Procedure Assign(ASource : IInterface);
    Procedure Sort();

    Property Category[Index : Integer] : ITSTOHackMasterCategory Read Get; Default;

  Public
    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;

  End;

implementation

Uses SysUtils, RtlConsts;

Procedure TTSTOHackMasterMovedItem.Assign(ASource : IInterface);
Var lSrc : ITSTOHackMasterMovedItem;
Begin
  If Supports(ASource, ITSTOHackMasterMovedItem, lSrc) Then
  Begin
    FXmlFileName := lSrc.XmlFileName;
    FOldCategory := lSrc.OldCategory;
    FNewCategory := lSrc.NewCategory;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TTSTOHackMasterMovedItem.GetXmlFileName() : String;
Begin
  Result := FXmlFileName;
End;

Procedure TTSTOHackMasterMovedItem.SetXmlFileName(Const AXmlFileName : String);
Begin
  FXmlFileName := AXmlFileName;
End;

Function TTSTOHackMasterMovedItem.GetOldCategory() : String;
Begin
  Result := FOldCategory;
End;

Procedure TTSTOHackMasterMovedItem.SetOldCategory(Const AOldCategory : String);
Begin
  FOldCategory := AOldCategory;
End;

Function TTSTOHackMasterMovedItem.GetNewCategory() : String;
Begin
  Result := FNewCategory;
End;

Procedure TTSTOHackMasterMovedItem.SetNewCategory(Const ANewCategory : String);
Begin
  FNewCategory := ANewCategory;
End;

Function TTSTOHackMasterMovedItems.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TTSTOHackMasterMovedItem;
End;

Procedure TTSTOHackMasterMovedItems.Assign(ASource : IInterface);
Var lSrc : ITSTOHackMasterMovedItems;
    X    : Integer;
Begin
  If Supports(ASource, ITSTOHackMasterMovedItems, lSrc) Then
  Begin
    For X := 0 To lSrc.Count - 1 Do
      Add().Assign(lSrc[X]);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TTSTOHackMasterMovedItems.Get(Index : Integer) : ITSTOHackMasterMovedItem;
Begin
  Result := InHerited Items[Index] As ITSTOHackMasterMovedItem;
End;

Procedure TTSTOHackMasterMovedItems.Put(Index : Integer; Const Item : ITSTOHackMasterMovedItem);
Begin
  InHerited Items[Index] := Item;
End;

Function TTSTOHackMasterMovedItems.Add() : ITSTOHackMasterMovedItem;
Begin
  Result := InHerited Add() As ITSTOHackMasterMovedItem;
End;

Function TTSTOHackMasterMovedItems.Add(Const AItem : ITSTOHackMasterMovedItem) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Procedure TTSTOHackMasterDataID.Created();
Begin
  InHerited Created();

  Clear();
End;

Destructor TTSTOHackMasterDataID.Destroy();
Begin
  FMiscData := Nil;
  InHerited Destroy();
End;

Procedure TTSTOHackMasterDataID.Clear();
Begin
  FId         := 0;
  FName       := '';
  FAddInStore := False;
  FOverRide   := False;
  FMiscData := THsStringListEx.CreateList();
End;

Procedure TTSTOHackMasterDataID.Assign(ASource : IInterface);
Var lSrc : ITSTOHackMasterDataID;
Begin
  If Supports(ASource, ITSTOHackMasterDataID, lSrc) Then
  Begin
    FId            := lSrc.Id;
    FName          := lSrc.Name;
    FAddInStore    := lSrc.AddInStore;
    FOverRide      := lSrc.OverRide;
    FIsBadItem     := lSrc.IsBadItem;
    FObjectType    := lSrc.ObjectType;
    FNPCCharacter  := lSrc.NPCCharacter;
    FSkinObject    := lSrc.SkinObject;
    FMiscData.Text := lSrc.MiscData.Text;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TTSTOHackMasterDataID.GetId() : Integer;
Begin
  Result := FId;
End;

Procedure TTSTOHackMasterDataID.SetId(Const AId : Integer);
Begin
  FId := AId;
End;

Function TTSTOHackMasterDataID.GetName() : String;
Begin
  Result := FName;
End;

Procedure TTSTOHackMasterDataID.SetName(Const AName : String);
Begin
  FName := AName;
End;

Function TTSTOHackMasterDataID.GetAddInStore() : Boolean;
Begin
  Result := FAddInStore;
End;

Procedure TTSTOHackMasterDataID.SetAddInStore(Const AAddInStore : Boolean);
Begin
  FAddInStore := AAddInStore;
End;

Function TTSTOHackMasterDataID.GetOverRide() : Boolean;
Begin
  Result := FOverRide;
End;

Procedure TTSTOHackMasterDataID.SetOverRide(Const AOverRide : Boolean);
Begin
  FOverRide := AOverRide;
End;

Function TTSTOHackMasterDataID.GetIsBadItem() : Boolean;
Begin
  Result := FIsBadItem;
End;

Procedure TTSTOHackMasterDataID.SetIsBadItem(Const AIsBadItem : Boolean);
Begin
  FIsBadItem := AIsBadItem;
End;

Function TTSTOHackMasterDataID.GetObjectType() : String;
Begin
  Result := FObjectType;
End;

Procedure TTSTOHackMasterDataID.SetObjectType(Const AObjectType : String);
Begin
  FObjectType := AObjectType;
End;

Function TTSTOHackMasterDataID.GetNPCCharacter() : Boolean;
Begin
  Result := FNPCCharacter;
End;

Procedure TTSTOHackMasterDataID.SetNPCCharacter(Const ANPCCharacter : Boolean);
Begin
  FNPCCharacter := ANPCCharacter;
End;

Function TTSTOHackMasterDataID.GetSkinObject() : String;
Begin
  Result := FSkinObject;
End;

Procedure TTSTOHackMasterDataID.SetSkinObject(Const ASkinObject : String);
Begin
  FSkinObject := ASkinObject;
End;

Function TTSTOHackMasterDataID.GetMiscData() : IHsStringListEx;
Begin
  Result := FMiscData;
End;

Function TTSTOHackMasterPackage.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TTSTOHackMasterDataID;
End;

Procedure TTSTOHackMasterPackage.Clear();
Begin
  FPackageType := '';
  FXmlFile     := '';

  InHerited Clear();
End;

Function TTSTOHackMasterPackage.InternalSort(Item1, Item2 : IInterfaceEx) : Integer;
Var lItem1, lItem2 : ITSTOHackMasterDataID;
Begin
  If Supports(Item1, ITSTOHackMasterDataID, lItem1) And Supports(Item2, ITSTOHackMasterDataID, lItem2) Then
  Begin
    If lItem1.Id > lItem2.Id Then
      Result := 1
    Else If lItem2.Id > lItem1.Id Then
      Result := -1
    Else
      Result := 0;
  End
  Else
    Result := 0;
End;

Procedure TTSTOHackMasterPackage.Sort();
Var X : Integer;
Begin
  InHerited Sort(InternalSort);
End;

Procedure TTSTOHackMasterPackage.Assign(ASource : IInterface);
Var lSrc : ITSTOHackMasterPackage;
    X    : Integer;
Begin
  If Supports(ASource, ITSTOHackMasterPackage, lSrc) Then
  Begin
    Clear();

    FPackageType := lSrc.PackageType;
    FXmlFile     := lSrc.XmlFile;
    FEnabled     := lSrc.Enabled;

    For X := 0 To lSrc.Count - 1 Do
      Add().Assign(lSrc[X]);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TTSTOHackMasterPackage.Get(Index : Integer) : ITSTOHackMasterDataID;
Begin
  Result := InHerited Items[Index] As ITSTOHackMasterDataID;
End;

Function TTSTOHackMasterPackage.Add() : ITSTOHackMasterDataID;
Begin
  Result := InHerited Add() As ITSTOHackMasterDataID;
End;

Function TTSTOHackMasterPackage.Add(Const AItem : ITSTOHackMasterDataID) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Function TTSTOHackMasterPackage.GetPackageType() : String;
Begin
  Result := FPackageType;
End;

Procedure TTSTOHackMasterPackage.SetPackageType(Const APackageType : String);
Begin
  FPackageType := APackageType;
End;

Function TTSTOHackMasterPackage.GetXmlFile() : String;
Begin
  Result := FXmlFile;
End;

Procedure TTSTOHackMasterPackage.SetXmlFile(Const AXmlFile : String);
Begin
  FXmlFile := AXmlFile;
End;

Function TTSTOHackMasterPackage.GetEnabled() : Boolean;
Begin
  Result := FEnabled;
End;

Procedure TTSTOHackMasterPackage.SetEnabled(Const AEnabled : Boolean);
Begin
  FEnabled := AEnabled;
End;

Function TTSTOHackMasterCategory.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TTSTOHackMasterPackage;
End;

Function TTSTOHackMasterCategory.Get(Index : Integer) : ITSTOHackMasterPackage;
Begin
  Result := InHerited Items[Index] As ITSTOHackMasterPackage;
End;

Procedure TTSTOHackMasterCategory.Clear();
Begin
  FName    := '';

  InHerited Clear();
End;

Function TTSTOHackMasterCategory.InternalSort(Item1, Item2 : IInterfaceEx) : Integer;
Var lItem1, lItem2 : ITSTOHackMasterPackage;
Begin
  If Supports(Item1, ITSTOHackMasterPackage, lItem1) And Supports(Item2, ITSTOHackMasterPackage, lItem2) Then
    Result := CompareText(lItem1.PackageType, lItem2.PackageType)
  Else
    Result := 0;
End;

Procedure TTSTOHackMasterCategory.Sort();
Var X : Integer;
Begin
//  InHerited Sort(InternalSort);

  For X := 0 To Count - 1 Do
    Package[X].Sort();
End;

Procedure TTSTOHackMasterCategory.Assign(ASource : IInterface);
Var lSrc : ITSTOHackMasterCategory;
    X    : Integer;
Begin
  If Supports(ASource, ITSTOHackMasterCategory, lSrc) Then
  Begin
    Clear();

    FName       := lSrc.Name;
    FEnabled    := lSrc.Enabled;
    FBuildStore := lSrc.BuildStore;

    For X := 0 To lSrc.Count - 1 Do
      Add().Assign(lSrc[X]);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TTSTOHackMasterCategory.GetName() : String;
Begin
  Result := FName;
End;

Procedure TTSTOHackMasterCategory.SetName(Const AName : String);
Begin
  FName := AName;
End;

Function TTSTOHackMasterCategory.GetEnabled() : Boolean;
Begin
  Result := FEnabled;
End;

Procedure TTSTOHackMasterCategory.SetEnabled(Const AEnabled : Boolean);
Begin
  FEnabled := AEnabled;
End;

Function TTSTOHackMasterCategory.GetBuildStore() : Boolean;
Begin
  Result := FBuildStore;
End;

Procedure TTSTOHackMasterCategory.SetBuildStore(Const ABuildStore : Boolean);
Begin
  FBuildStore := ABuildStore;
End;

Function TTSTOHackMasterCategory.Add() : ITSTOHackMasterPackage;
Begin
  Result := InHerited Add() As ITSTOHackMasterPackage;
End;

Function TTSTOHackMasterCategory.Add(Const AItem : ITSTOHackMasterPackage) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Procedure TTSTOHackMasterList.AfterConstruction();
Begin
  InHerited AfterConstruction();

  FMovedItems := TTSTOHackMasterMovedItems.Create();
End;

Procedure TTSTOHackMasterList.BeforeDestruction();
Begin
  FMovedItems := Nil;

  InHerited BeforeDestruction();
End;

Function TTSTOHackMasterList.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TTSTOHackMasterCategory;
End;

Function TTSTOHackMasterList.Get(Index : Integer) : ITSTOHackMasterCategory;
Begin
  Result := InHerited Items[Index] As ITSTOHackMasterCategory;
End;

Function TTSTOHackMasterList.GetMovedItems() : ITSTOHackMasterMovedItems;
Begin
  Result := FMovedItems;
End;

Function TTSTOHackMasterList.Add() : ITSTOHackMasterCategory;
Begin
  Result := InHerited Add() As ITSTOHackMasterCategory;
End;

Function TTSTOHackMasterList.Add(Const AItem : ITSTOHackMasterCategory) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Function TTSTOHackMasterList.InternalSort(Item1, Item2 : IInterfaceEx) : Integer;
Var lItem1, lItem2 : ITSTOHackMasterCategory;
Begin
  If Supports(Item1, ITSTOHackMasterCategory, lItem1) And Supports(Item2, ITSTOHackMasterCategory, lItem2) Then
    Result := CompareText(lItem1.Name, lItem2.Name)
  Else
    Result := 0;
End;

Procedure TTSTOHackMasterList.Sort();
Var X : Integer;
Begin
  InHerited Sort(InternalSort);

  For X := 0 To Count - 1 Do
    Category[X].Sort();
End;

Procedure TTSTOHackMasterList.Assign(ASource : IInterface);
Var lSrc : ITSTOHackMasterList;
    X    : Integer;
Begin
  If Supports(ASource, ITSTOHackMasterList, lSrc) Then
  Begin
    Clear();

    GetMovedItems().Assign(lSrc.MovedItems);
    For X := 0 To lSrc.Count - 1 Do
      Add().Assign(lSrc[X]);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

end.
