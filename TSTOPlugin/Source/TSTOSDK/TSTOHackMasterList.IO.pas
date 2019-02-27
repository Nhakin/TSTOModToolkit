unit TSTOHackMasterList.IO;

interface

Uses Classes, HsInterfaceEx, HsStringListEx, HsStreamEx,
  TSTOProjectIntf, TSTOScriptTemplateIntf, TSTORGBProgress, TSTOHackMasterListIntf;

Type
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
