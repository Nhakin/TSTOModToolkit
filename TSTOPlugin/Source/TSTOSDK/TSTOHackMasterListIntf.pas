unit TSTOHackMasterListIntf;

interface

Uses Classes, HsInterfaceEx, HsStringListEx, HsStreamEx,
  TSTOProjectIntf, TSTOScriptTemplateIntf, RGBProgress;

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

(******************************************************************************)

  tDataIDIOType = (tdtUnknown, tdtCharacter, tdtBuilding);

  ITSTOHackMasterDataIDIO = Interface(ITSTOHackMasterDataID)
    ['{4B61686E-29A0-2112-B391-397796560EBB}']
    Function GetItemType() : tDataIDIOType;
    Procedure SetItemType(Const AItemType : tDataIDIOType);

    Function GetUnique() : Boolean;
    Function GetStorable() : Boolean;
    Function GetSellable() : Boolean;
    Function GetLevel() : Integer;
    Function GetIsFree() : Boolean;

    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

    Property ItemType : tDataIDIOType Read GetItemType Write SetItemType;

    Property Unique   : Boolean Read GetUnique;
    Property Storable : Boolean Read GetStorable;
    Property Sellable : Boolean Read GetSellable;
    Property Level    : Integer Read GetLevel;
    Property IsFree   : Boolean Read GetIsFree;

    Property OnChange : TNotifyEvent Read GetOnChange Write SetOnChange;

  End;

  ITSTOHackMasterPackageIO = Interface(ITSTOHackMasterPackage)
    ['{4B61686E-29A0-2112-BEA7-B11FA19397B4}']
    Function IndexOf(Const ADataID : Integer) : Integer;
    Function Get(Index : Integer) : ITSTOHackMasterDataIDIO;

    Function Add() : ITSTOHackMasterDataIDIO; OverLoad;
    Function Add(Const AItem : ITSTOHackMasterDataIDIO) : Integer; OverLoad;
    Function Remove(Const AItem : ITSTOHackMasterDataIDIO) : Integer;

    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

    Property DataID[Index: Integer] : ITSTOHackMasterDataIDIO Read Get; Default;

    Property OnChange : TNotifyEvent Read GetOnChange Write SetOnChange;

  End;

  ITSTOHackMasterCategoryIO = Interface(ITSTOHackMasterCategory)
    ['{4B61686E-29A0-2112-9335-525B8428CC2D}']
    Function Get(Index : Integer) : ITSTOHackMasterPackageIO;

    Function GetHaveNonUnique() : Boolean;
    Function GetHaveUnique() : Boolean;
    Function GetMinLevel() : Integer;

    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

    Function Add() : ITSTOHackMasterPackageIO; OverLoad;
    Function Add(Const AItem : ITSTOHackMasterPackageIO) : Integer; OverLoad;
    Function Remove(Const AItem : ITSTOHackMasterPackageIO) : Integer;
    Function IndexOf(Const APackageType, AXmlFile : String) : Integer;

    Property Package[Index : Integer] : ITSTOHackMasterPackageIO Read Get; Default;

    Property HaveNonUnique : Boolean Read GetHaveNonUnique;
    Property HaveUnique    : Boolean Read GetHaveUnique;
    Property MinLevel      : Integer Read GetMinLevel;

    Property OnChange : TNotifyEvent Read GetOnChange Write SetOnChange;

  End;

  ITSTOHackMasterListIO = Interface(ITSTOHackMasterList)
    ['{4B61686E-29A0-2112-8F85-9593CF0CF449}']
    Function Get(Index : Integer) : ITSTOHackMasterCategoryIO;

    Function  GetAsXml() : String;
    Procedure SetAsXml(Const AXmlString : String);

    Function  GetModified() : Boolean;
    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

    Function Add() : ITSTOHackMasterCategoryIO; OverLoad;
    Function Add(Const AItem : ITSTOHackMasterCategoryIO) : Integer; OverLoad;
    Function Remove(Const AItem : ITSTOHackMasterCategoryIO) : Integer;
    Function IndexOf(Const ACategoryName : String) : Integer;

    Procedure ForceChanged();
    Procedure ClearChanges();

    Procedure BuildMasterList(AProject : ITSTOXMLProject); OverLoad;
    Procedure BuildMasterList(AProject : ITSTOXMLProject; Const ASaveInfo : Boolean); OverLoad;
    Procedure EnhanceMasterList(AProject : ITSTOXMLProject);

    Function  ListStoreRequirements(Const ACategoryName : String) : String;

    Function  BuildStoreMenu(ASettings : ITSTOScriptTemplateSettings; AProgress : IRgbProgress = Nil) : String; OverLoad;
    Function  BuildStoreMenu() : String; OverLoad;
    Procedure BuildStoreMenu(Const AFileName : String); OverLoad;

    Function  BuildInventoryMenu(ASettings : ITSTOScriptTemplateSettings; AProgress : IRgbProgress = Nil) : String; OverLoad;
    Function  BuildInventoryMenu() : String; OverLoad;
    Procedure BuildInventoryMenu(Const AFileName : String); OverLoad;

    Function  BuildStoreItems(ASettings : ITSTOScriptTemplateSettings; AProgress : IRgbProgress = Nil) : String; OverLoad;
    Function  BuildStoreItems() : String; OverLoad;
    Procedure BuildStoreItems(Const AFileName : String); OverLoad;

    Function  BuildFreeItems(AProgress : IRgbProgress = Nil) : String; OverLoad;
    Procedure BuildFreeItems(Const AFileName : String); OverLoad;

    Function  BuildUniqueItems(AProgress : IRgbProgress = Nil) : String; OverLoad;
    Procedure BuildUniqueItems(Const AFileName : String); OverLoad;

    Function  BuildNonSellableItems(AProgress : IRgbProgress = Nil) : String; OverLoad;
    Procedure BuildNonSellableItems(Const AFileName : String); OverLoad;

    Function  BuildReqsItems(AProgress : IRgbProgress = Nil) : String; OverLoad;
    Procedure BuildReqsItems(Const AFileName : String); OverLoad;

    Function  BuildDeleteBadItems(AProgress : IRgbProgress = Nil) : String; OverLoad;
    Procedure BuildDeleteBadItems(Const AFileName : String); OverLoad;

    Function  BuildStoreRequirements(AProgress : IRgbProgress = Nil) : String; OverLoad;
    Procedure BuildStoreRequirements(Const AFileName : String); OverLoad;

    //Generic function to extract items from HackMasterList
    Function  BuildCharacterSkins() : String;
    Function  BuildBuildingSkins() : String;
    Function  BuildNPCCharacters() : String;

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure LoadFromFile(Const AFileName : String);

    Procedure SaveToStream(ATarget : IStreamEx);
    Procedure SaveToFile(Const AFileName : String); OverLoad;
    Procedure SaveToFile(Const AFileName : String; AProject : ITSTOXMLProject; Const ASaveInfo : Boolean = True); OverLoad;

    Function GetDiff(AMasterList : ITSTOHackMasterListIO) : ITSTOHackMasterListIO;

    Property Category[Index : Integer] : ITSTOHackMasterCategoryIO Read Get; Default;

    Property AsXml : String Read GetAsXml Write SetAsXml;

    Property Modified : Boolean      Read GetModified;
    Property OnChange : TNotifyEvent Read GetOnChange Write SetOnChange;

  End;
  
implementation

end.
