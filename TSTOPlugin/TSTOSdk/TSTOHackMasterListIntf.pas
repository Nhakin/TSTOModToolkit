unit TSTOHackMasterListIntf;

interface

Uses Classes, HsInterfaceEx, HsStringListEx, HsStreamEx,
  TSTOProjectIntf, TSTOScriptTemplateIntf, TSTORGBProgress;

Type
  ITSTOHackMasterMovedItem = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-86ED-11F68463C280}']
    Function  GetXmlFileName() : String;
    Procedure SetXmlFileName(Const APackageXmlFileName : String);

    Function  GetOldCategory() : String;
    Procedure SetOldCategory(Const AOldCategory : String);

    Function  GetNewCategory() : String;
    Procedure SetNewCategory(Const ANewCategory : String);

    Procedure Assign(ASource : IInterface);

    Property XmlFileName : String Read GetXmlFileName Write SetXmlFileName;
    Property OldCategory : String Read GetOldCategory Write SetOldCategory;
    Property NewCategory : String Read GetNewCategory Write SetNewCategory;

  End;

  ITSTOHackMasterMovedItems = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-B067-0A6B4097DD41}']
    Function  Get(Index : Integer) : ITSTOHackMasterMovedItem;
    Procedure Put(Index : Integer; Const Item : ITSTOHackMasterMovedItem);

    Function Add() : ITSTOHackMasterMovedItem; OverLoad;
    Function Add(Const AItem : ITSTOHackMasterMovedItem) : Integer; OverLoad;

    Procedure Assign(ASource : IInterface);

    Property Items[Index : Integer] : ITSTOHackMasterMovedItem Read Get Write Put; Default;

  End;

  ITSTOHackMasterDataID = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-A5E4-CE2614077B1B}']
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

    Procedure Assign(ASource : IInterface);

    Property Id           : Integer         Read GetId           Write SetId;
    Property Name         : String          Read GetName         Write SetName;
    Property AddInStore   : Boolean         Read GetAddInStore   Write SetAddInStore;
    Property OverRide     : Boolean         Read GetOverRide     Write SetOverRide;
    Property IsBadItem    : Boolean         Read GetIsBadItem    Write SetIsBadItem;
    Property ObjectType   : String          Read GetObjectType   Write SetObjectType;
    Property NPCCharacter : Boolean         Read GetNPCCharacter Write SetNPCCharacter;
    Property SkinObject   : String          Read GetSkinObject   Write SetSkinObject;
    Property MiscData     : IHsStringListEx Read GetMiscData;

  End;

  ITSTOHackMasterPackage = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-8236-652CE15FDD1A}']
    Function  Get(Index : Integer) : ITSTOHackMasterDataID;

    Function  GetPackageType() : String;
    Procedure SetPackageType(Const APackageType : String);

    Function  GetXmlFile() : String;
    Procedure SetXmlFile(Const AXmlFile : String);

    Function  GetEnabled() : Boolean;
    Procedure SetEnabled(Const AEnabled : Boolean);

    Function Add() : ITSTOHackMasterDataID; OverLoad;
    Function Add(Const AItem : ITSTOHackMasterDataID) : Integer; OverLoad;

    Procedure Assign(ASource : IInterface);
    Procedure Sort();

    Property DataID[Index: Integer] : ITSTOHackMasterDataID Read Get; Default;

    Property PackageType : String  Read GetPackageType Write SetPackageType;
    Property XmlFile     : String  Read GetXmlFile     Write SetXmlFile;
    Property Enabled     : Boolean Read GetEnabled     Write SetEnabled;

  End;

  ITSTOHackMasterCategory = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-934E-0FDE3257ECCB}']
    Function  Get(Index : Integer) : ITSTOHackMasterPackage;

    Function  GetName() : String;
    Procedure SetName(Const AName : String);

    Function  GetEnabled() : Boolean;
    Procedure SetEnabled(Const AEnabled : Boolean);

    Function  GetBuildStore() : Boolean;
    Procedure SetBuildStore(Const ABuildStore : Boolean);

    Function Add() : ITSTOHackMasterPackage; OverLoad;
    Function Add(Const AItem : ITSTOHackMasterPackage) : Integer; OverLoad;

    Procedure Assign(ASource : IInterface);
    Procedure Sort();

    Property Package[Index : Integer] : ITSTOHackMasterPackage Read Get; Default;

    Property Name       : String  Read GetName       Write SetName;
    Property Enabled    : Boolean Read GetEnabled    Write SetEnabled;
    Property BuildStore : Boolean Read GetBuildStore Write SetBuildStore;

  End;

  ITSTOHackMasterList = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-ABF9-59B79A7BC175}']
    Function Get(Index : Integer) : ITSTOHackMasterCategory;

    Function GetMovedItems() : ITSTOHackMasterMovedItems;

    Function Add() : ITSTOHackMasterCategory; OverLoad;
    Function Add(Const AItem : ITSTOHackMasterCategory) : Integer; OverLoad;

    Procedure Assign(ASource : IInterface);
    Procedure Sort();

    Property Category[Index : Integer] : ITSTOHackMasterCategory Read Get; Default;

    Property MovedItems : ITSTOHackMasterMovedItems Read GetMovedItems;
  End;

implementation

end.
