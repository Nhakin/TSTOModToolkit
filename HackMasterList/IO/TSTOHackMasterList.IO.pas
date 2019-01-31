unit TSTOHackMasterList.IO;

interface

Uses
  Classes, HsInterfaceEx, HsStreamEx, RgbExtractProgress,
  TSTOHackMasterListIntf, TSTOProject.Xml, TSTOScriptTemplateIntf;

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

    Property ItemType : tDataIDIOType Read GetItemType Write SetItemType;

    Property Unique   : Boolean Read GetUnique;
    Property Storable : Boolean Read GetStorable;
    Property Sellable : Boolean Read GetSellable;
    Property Level    : Integer Read GetLevel;
    Property IsFree   : Boolean Read GetIsFree;

  End;

  ITSTOHackMasterPackageIO = Interface(ITSTOHackMasterPackage)
    ['{4B61686E-29A0-2112-BEA7-B11FA19397B4}']
    Function IndexOf(Const ADataID : Integer) : Integer;
    Function Get(Index : Integer) : ITSTOHackMasterDataIDIO;

    Function Add() : ITSTOHackMasterDataIDIO; OverLoad;
    Function Add(Const AItem : ITSTOHackMasterDataIDIO) : Integer; OverLoad;

    Property DataID[Index: Integer] : ITSTOHackMasterDataIDIO Read Get; Default;

  End;

  ITSTOHackMasterCategoryIO = Interface(ITSTOHackMasterCategory)
    ['{4B61686E-29A0-2112-9335-525B8428CC2D}']
    Function Get(Index : Integer) : ITSTOHackMasterPackageIO;

    Function GetHaveNonUnique() : Boolean;
    Function GetHaveUnique() : Boolean;
    Function GetMinLevel() : Integer;

    Function Add() : ITSTOHackMasterPackageIO; OverLoad;
    Function Add(Const AItem : ITSTOHackMasterPackageIO) : Integer; OverLoad;
    Function IndexOf(Const APackageType, AXmlFile : String) : Integer;

    Property Package[Index : Integer] : ITSTOHackMasterPackageIO Read Get; Default;

    Property HaveNonUnique : Boolean Read GetHaveNonUnique;
    Property HaveUnique    : Boolean Read GetHaveUnique;
    Property MinLevel      : Integer Read GetMinLevel;

  End;

  ITSTOHackMasterListIO = Interface(ITSTOHackMasterList)
    ['{4B61686E-29A0-2112-8F85-9593CF0CF449}']
    Function Get(Index : Integer) : ITSTOHackMasterCategoryIO;

    Function  GetAsXml() : String;
    Procedure SetAsXml(Const AXmlString : String);

    Function Add() : ITSTOHackMasterCategoryIO; OverLoad;
    Function Add(Const AItem : ITSTOHackMasterCategoryIO) : Integer; OverLoad;
    Function IndexOf(Const ACategoryName : String) : Integer;

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

  End;

  TTSTOHackMasterListIO = Class(TObject)
  Public
    Class Function CreateHackMasterList() : ITSTOHackMasterListIO;

  End;

implementation

Uses SysUtils, Forms, Dialogs, TypInfo, Math, XMLIntf,
  HsXmlDocEx, HsStringListEx,
  TSTOHackMasterListImpl, TSTOHackMasterList.Xml, TSTOHackMasterList.Bin, TSTOScriptTemplateImpl;

Type
  TTSTOHackMasterDataIDIO = Class(TTSTOHackMasterDataID, ITSTOHackMasterDataIDIO)
  Private
    FItemType : tDataIDIOType;
    
  Protected
    Function  GetItemType() : tDataIDIOType;
    Procedure SetItemType(Const AItemType : tDataIDIOType);

    Function GetUnique() : Boolean;
    Function GetStorable() : Boolean;
    Function GetSellable() : Boolean;
    Function GetLevel() : Integer;
    Function GetBuildTime() : Integer;
    Function GetIsFree() : Boolean;

  End;

  TTSTOHackMasterPackageIO = Class(TTSTOHackMasterPackage, ITSTOHackMasterPackageIO)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;

    Function Get(Index : Integer) : ITSTOHackMasterDataIDIO; OverLoad;

    Function Add() : ITSTOHackMasterDataIDIO; OverLoad;
    Function Add(Const AItem : ITSTOHackMasterDataIDIO) : Integer; OverLoad;
    Function IndexOf(Const ADataID : Integer) : Integer; ReIntroduce; OverLoad;

  End;

  TTSTOHackMasterCategoryIO = Class(TTSTOHackMasterCategory, ITSTOHackMasterCategoryIO)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;

    Function Get(Index : Integer) : ITSTOHackMasterPackageIO; OverLoad;

    Function GetHaveNonUnique() : Boolean;
    Function GetHaveUnique() : Boolean;
    Function GetMinLevel() : Integer;

    Function Add() : ITSTOHackMasterPackageIO; OverLoad;
    Function Add(Const AItem : ITSTOHackMasterPackageIO) : Integer; OverLoad;
    Function IndexOf(Const APackageType, AXmlFile : String) : Integer; ReIntroduce; OverLoad;

    Property Package[Index : Integer] : ITSTOHackMasterPackageIO Read Get; Default;

    Property HaveNonUnique : Boolean Read GetHaveNonUnique;
    Property HaveUnique    : Boolean Read GetHaveUnique;
    Property MinLevel      : Integer Read GetMinLevel;

  End;

  TTSTOHackMasterListIOImpl = Class(TTSTOHackMasterList, ITSTOHackMasterListIO, IXmlTSTOHackMasterList, IBinTSTOHackMasterList)
  Private
    FXmlImpl : IXmlTSTOHackMasterList;
    FBinImpl : IBinTSTOHackMasterList;

    Function GetXmlImplementor() : IXmlTSTOHackMasterList;
    Function GetBinImplementor() : IBinTSTOHackMasterList;

  Protected
    Property XmlImpl : IXmlTSTOHackMasterList Read GetXmlImplementor Implements IXmlTSTOHackMasterList;
    Property BinImpl : IBinTSTOHackMasterList Read GetBinImplementor Implements IBinTSTOHackMasterList;

    Function GetItemClass() : TInterfacedObjectExClass; OverRide;

    Function Get(Index : Integer) : ITSTOHackMasterCategoryIO; OverLoad;

    Function  GetAsXml() : String;
    Procedure SetAsXml(Const AXmlString : String);

    Function Add() : ITSTOHackMasterCategoryIO; OverLoad;
    Function Add(Const AItem : ITSTOHackMasterCategoryIO) : Integer; OverLoad;
    Function IndexOf(Const ACategoryName : String) : Integer; ReIntroduce; OverLoad;

    Procedure LoadFromStream(AStream : IStreamEx);
    Procedure LoadFromFile(Const AFileName : String);

    Procedure SaveToStream(AStream : IStreamEx);
    Procedure SaveToFile(Const AFileName : String); OverLoad;
    Procedure SaveToFile(Const AFileName : String; AProject : ITSTOXMLProject; Const ASaveInfo : Boolean = True); OverLoad;

    Function GetDiff(AMasterList : ITSTOHackMasterListIO) : ITSTOHackMasterListIO;

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

    Function  BuildStoreRequirements(AProgress : IRgbProgress = Nil) : String; OverLoad;
    Procedure BuildStoreRequirements(Const AFileName : String); OverLoad;

    Procedure AddToMasterList( ACategory : ITSTOHackMasterCategoryIO; APackage : ITSTOHackMasterPackageIO; AItem : ITSTOHackMasterDataIDIO);
    Function  ListObjectType(ACategory : ITSTOHackMasterCategoryIO) : String;
    Function  BuildCharacterSkins() : String;
    Function  BuildBuildingSkins() : String;
    Function  BuildNPCCharacters() : String;

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

    Property Category[Index : Integer] : ITSTOHackMasterCategoryIO Read Get; Default;

  End;

Class Function TTSTOHackMasterListIO.CreateHackMasterList() : ITSTOHackMasterListIO;
Begin
  Result := TTSTOHackMasterListIOImpl.Create();
End;

Function TTSTOHackMasterDataIDIO.GetItemType() : tDataIDIOType;
Begin
  Result := FItemType;
End;

Procedure TTSTOHackMasterDataIDIO.SetItemType(Const AItemType : tDataIDIOType);
Begin
  FItemType := AItemType;
End;

Function TTSTOHackMasterDataIDIO.GetUnique() : Boolean;
Var lMiscData : IHsStringListEx;
Begin
  Result := False;
  If FItemType = tdtCharacter Then
    Result := True
  Else
  Begin
    lMiscData := GetMiscData();
    If lMiscData.Text <> '' Then
      Result := Assigned(LoadXmlData(lMiscData.Text).SelectNode('Unique[@value="true"]'));
  End;
End;

Function TTSTOHackMasterDataIDIO.GetStorable() : Boolean;
Var lMiscData : IHsStringListEx;
    lXml : IXmlDocumentEx;
Begin
  Result := True;

  lMiscData := GetMiscData();
  If lMiscData.Text <> '' Then
  Begin
    lXml := LoadXmlData(lMiscData.Text);
    Try
      Result := Not Assigned(lXml.SelectNode('Sell'));
      If Not Result Then
        Result := Assigned(lXml.SelectNode('Sell[@storeoverride="true"]'));

      Finally
        lXml := Nil;
    End;
  End;
End;

Function TTSTOHackMasterDataIDIO.GetSellable() : Boolean;
Var lMiscData : IHsStringListEx;
    lXml : IXmlDocumentEx;
Begin
  Result := True;

  lMiscData := GetMiscData();
  If lMiscData.Text <> '' Then
  Begin
    lXml := LoadXmlData(lMiscData.Text);
    Try
      Result := Not Assigned(lXml.SelectNode('Sell'));
      If Not Result Then
        Result := Assigned(lXml.SelectNode('Sell[@allowed="true"]'));

      Finally
        lXml := Nil;
    End;
  End;
End;

Function TTSTOHackMasterDataIDIO.GetLevel() : Integer;
Var lMiscData : IHsStringListEx;
    lNode     : IXmlNodeEx;
Begin
  Result := 1;
  lMiscData := GetMiscData();
  If lMiscData.Text <> '' Then
  Begin
    lNode := LoadXmlData(lMiscData.Text).SelectNode('Requirements//Requirement[@type="level"]');
    If Assigned(lNode) Then
      Result := lNode.AttributeNodes['level'].AsInteger
    Else
    Begin
      lNode := LoadXmlData(lMiscData.Text).SelectNode('Requirement[@type="level"]');
      If Assigned(lNode) Then
        Result := lNode.AttributeNodes['level'].AsInteger
      Else
      Begin
        lNode := LoadXmlData(lMiscData.Text).SelectNode('VisibilityRequirements//Requirement[@type="level"]');
        If Assigned(lNode) Then
          Result := lNode.AttributeNodes['level'].AsInteger;
      End;
    End;
//    lNode := LoadXmlData(lMiscData.Text).SelectNode('VisibilityRequirements//Requirement[@type="level"]');
//    If Assigned(lNode) Then
//      Result := lNode.AttributeNodes['level'].AsInteger
//    Else
//    Begin
//      lNode := LoadXmlData(lMiscData.Text).SelectNode('Requirements//Requirement[@type="level"]');
//      If Assigned(lNode) Then
//        Result := lNode.AttributeNodes['level'].AsInteger
//    End;
  End;
End;

Function TTSTOHackMasterDataIDIO.GetBuildTime() : Integer;
Var lMiscData : IHsStringListEx;
    lNode     : IXmlNodeEx;
Begin
  Result := 0;
  lMiscData := GetMiscData();
  If lMiscData.Text <> '' Then
  Begin
    lNode := LoadXmlData(lMiscData.Text).SelectNode('//BuildTime');
    If Assigned(lNode) Then
      Result := lNode.AttributeNodes['time'].AsInteger;
  End;
End;

Function TTSTOHackMasterDataIDIO.GetIsFree() : Boolean;
Var lMiscData : IHsStringListEx;
    lNode     : IXmlNodeEx;
Begin
  Result := True;
  lMiscData := GetMiscData();

  If lMiscData.Text <> '' Then
  Begin
    lNode := LoadXmlData(lMiscData.Text).SelectNode('//Cost');
    Result := Not Assigned(lNode);
  End;
End;

Function TTSTOHackMasterPackageIO.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TTSTOHackMasterDataIDIO;
End;

Function TTSTOHackMasterPackageIO.Get(Index : Integer) : ITSTOHackMasterDataIDIO;
Begin
  Result := InHerited DataID[Index] As ITSTOHackMasterDataIDIO;
End;

Function TTSTOHackMasterPackageIO.Add() : ITSTOHackMasterDataIDIO;
Begin
  Result := InHerited Add() As ITSTOHackMasterDataIDIO;
End;

Function TTSTOHackMasterPackageIO.Add(Const AItem : ITSTOHackMasterDataIDIO) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Function TTSTOHackMasterPackageIO.IndexOf(Const ADataID : Integer) : Integer;
Var X : Integer;
Begin
  Result := -1;

  For X := 0 To Count - 1 Do
    If DataID[X].Id = ADataID Then
    Begin
      Result := X;
      Break;
    End;
End;

Function TTSTOHackMasterCategoryIO.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TTSTOHackMasterPackageIO;
End;

Function TTSTOHackMasterCategoryIO.Get(Index : Integer) : ITSTOHackMasterPackageIO;
Begin
  Result := InHerited Package[Index] As ITSTOHackMasterPackageIO;
End;

Function TTSTOHackMasterCategoryIO.GetHaveNonUnique() : Boolean;
Var X, Y : Integer;
Begin
  Result := False;

  If Enabled Then
    For X := 0 To Count - 1 Do
      If Package[X].Enabled Then
        For Y := 0 To Package[X].Count - 1 Do
          If Package[X][Y].OverRide Then
          Begin
            Result := Not Package[X][Y].Unique;
            If Result Then
              Exit;
          End;
End;

Function TTSTOHackMasterCategoryIO.GetHaveUnique() : Boolean;
Var X, Y : Integer;
Begin
  Result := False;

  If Enabled Then
    For X := 0 To Count - 1 Do
      If Package[X].Enabled Then
        For Y := 0 To Package[X].Count - 1 Do
          If Package[X][Y].OverRide Then
          Begin
            Result := Package[X][Y].Unique;
            If Result Then
              Exit;
          End;
End;

Function TTSTOHackMasterCategoryIO.GetMinLevel() : Integer;
Var X, Y : Integer;
Begin
  Result := 999;

  If Enabled Then
    For X := 0 To Count - 1 Do
      If Package[X].Enabled Then
        For Y := 0 To Package[X].Count - 1 Do
          If Package[X][Y].OverRide Then
            Result := Min(Result, Package[X][Y].Level);
End;

Function TTSTOHackMasterCategoryIO.Add() : ITSTOHackMasterPackageIO;
Begin
  Result := InHerited Add() As ITSTOHackMasterPackageIO;
End;

Function TTSTOHackMasterCategoryIO.Add(Const AItem : ITSTOHackMasterPackageIO) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Function TTSTOHackMasterCategoryIO.IndexOf(Const APackageType, AXmlFile : String) : Integer;
Var X : Integer;
Begin
  Result := -1;
  For X := 0 To Count - 1 Do
    If SameText(Package[X].PackageType, APackageType) And
       SameText(Package[X].XmlFile, AXmlFile) Then
    Begin
      Result := X;
      Break;
    End;
End;

Function TTSTOHackMasterListIOImpl.GetXmlImplementor() : IXmlTSTOHackMasterList;
Begin
  FXmlImpl := TXmlTSTOHackMasterList.CreateMasterList();
  FXmlImpl.Assign(Self);

  Result := FXmlImpl;
End;

Function TTSTOHackMasterListIOImpl.GetBinImplementor() : IBinTSTOHackMasterList;
Begin
  FBinImpl := TBinTSTOHackMasterList.CreateMasterList();
  FBinImpl.Assign(Self);

  Result := FBinImpl;
End;

Function TTSTOHackMasterListIOImpl.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TTSTOHackMasterCategoryIO;
End;

Function TTSTOHackMasterListIOImpl.Get(Index : Integer) : ITSTOHackMasterCategoryIO;
Begin
  Result := InHerited Category[Index] As ITSTOHackMasterCategoryIO;
End;

Function TTSTOHackMasterListIOImpl.GetAsXml() : String;
Begin
  Result := FormatXmlData(XmlImpl.Xml);
  FXmlImpl := Nil;
End;

Procedure TTSTOHackMasterListIOImpl.SetAsXml(Const AXmlString : String);
Begin
  Assign(TXmlTSTOHackMasterList.CreateMasterList(AXmlString));
{
  FXmlImpl := TXmlTSTOHackMasterList.CreateMasterList(AXmlString);
  Try
    Assign(FXmlImpl);

    Finally
      FXmlImpl := Nil;
  End;
}
End;

Function TTSTOHackMasterListIOImpl.Add() : ITSTOHackMasterCategoryIO;
Begin
  Result := InHerited Add() As ITSTOHackMasterCategoryIO;
End;

Function TTSTOHackMasterListIOImpl.Add(Const AItem : ITSTOHackMasterCategoryIO) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Function TTSTOHackMasterListIOImpl.IndexOf(Const ACategoryName : String) : Integer;
Var X : Integer;
Begin
  Result := -1;

  For X := 0 To Count - 1 Do
    If SameText(Category[X].Name, ACategoryName) Then
    Begin
      Result := X;
      Break;
    End;
End;

Procedure TTSTOHackMasterListIOImpl.LoadFromStream(AStream : IStreamEx);
Begin
  BinImpl.LoadFromStream(AStream);
  Assign(FBinImpl);
End;

Procedure TTSTOHackMasterListIOImpl.LoadFromFile(Const AFileName : String);
Begin
  If SameText(ExtractFileExt(AFileName), '.xml') Then
    With TStringList.Create() Do
    Try
      LoadFromFile(AFileName);
      SetAsXml(Text);

      Finally
        Free();
    End
//  Else
//  Begin
//    lMem := TMemoryStreamEx.Create();
//    Try
//      lMem.LoadFromFile(AFileName);
//      lMem.Position := 0;
//      LoadFromStream(lMem);
//
//      Finally
//        lMem := Nil;
//    End;
//  End;
End;

Procedure TTSTOHackMasterListIOImpl.SaveToStream(AStream : IStreamEx);
Begin
  BinImpl.SaveToStream(AStream);
End;

Procedure TTSTOHackMasterListIOImpl.SaveToFile(Const AFileName : String);
Var X : Integer;
    lXml : IXmlDocumentEx;
    lNodes : IXmlNodeListEx;
Begin
//  If SameText(ExtractFileExt(AFileName), '.xml') Then
    With TStringList.Create() Do
    Try
      lXml := XmlImpl.OwnerDocument;
      lNodes := lXml.SelectNodes('//Package[not(*)]');

      For X := 0 To lNodes.Count - 1 Do
        lNodes[X].DOMNode.parentNode.removeChild(lNodes[X].DOMNode);
      Text := FormatXmlData(lXml.Xml.Text);

      SaveToFile(ChangeFileExt(AFileName, '.xml'));

      Finally
        Free();
    End
//  Else
//  Begin
//    lMem := TMemoryStreamEx.Create();
//    Try
//      SaveToStream(lMem);
//
//      lMem.SaveToFile(AFileName);
//
//      Finally
//        lMem := Nil;
//    End;
//  End;
End;

Procedure TTSTOHackMasterListIOImpl.SaveToFile(Const AFileName : String; AProject : ITSTOXMLProject; Const ASaveInfo : Boolean = True);
Begin
  If ASaveInfo Then
  Begin
    EnhanceMasterList(AProject);
    With TStringList.Create() Do
    Try
      Text := FormatXmlData(FXmlImpl.Xml);
      SaveToFile(AFileName);

      Finally
        Free();
        FXmlImpl := Nil;
    End;
  End
  Else
    SaveToFile(AFileName);
End;

Function TTSTOHackMasterListIOImpl.GetDiff(AMasterList : ITSTOHackMasterListIO) : ITSTOHackMasterListIO;
  Function IndexOfPackageCategory(ACategory : ITSTOHackMasterCategoryIO; APackage : ITSTOHackMasterPackageIO; Var Category : String) : Integer;
  Var X : Integer;
      lMovedItems : ITSTOHackMasterMovedItems;
  Begin
    Result := -1;
    Category := ACategory.Name;

    Result := ACategory.IndexOf(APackage.PackageType, APackage.XmlFile);
    If Result = -1 Then
    Begin
      lMovedItems := GetMovedItems();
      For X := 0 To lMovedItems.Count - 1 Do
        If SameText(lMovedItems[X].XmlFileName, APackage.XmlFile) And
           SameText(lMovedItems[X].OldCategory, ACategory.Name) Then
        Begin
          Result := IndexOf(lMovedItems[X].NewCategory);
          Category := lMovedItems[X].NewCategory;
          Break;
        End;
    End;
  End;

Var X, Y, Z : Integer;
    lCIdx, lPIdx, lIdx : Integer;
    lCurPkg : ITSTOHackMasterPackageIO;
    lCurCat : ITSTOHackMasterCategoryIO;
    lCategoryName : String;
Begin
  Result := TTSTOHackMasterListIO.CreateHackMasterList();

  For X := 0 To AMasterList.Count - 1 Do
  Begin
    lCIdx := IndexOf(AMasterList[X].Name);

    If lCIdx = -1 Then
    Begin
      lCIdx := Result.Add(TTSTOHackMasterCategoryIO.Create());//.Assign(AMasterList[X])
      Result[lCIdx].Name       := AMasterList[X].Name;
      Result[lCIdx].Enabled    := AMasterList[X].Enabled;
      Result[lCIdx].BuildStore := AMasterList[X].BuildStore;
    End;

    For Y := 0 To AMasterList[X].Count - 1 Do
    Begin
      lPIdx := IndexOfPackageCategory(AMasterList[X], AMasterList[X][Y], lCategoryName);
      //Category[lCIdx].IndexOf(AMasterList[X][Y].PackageType, AMasterList[X][Y].XmlFile);

      If lPIdx = -1 Then
      Begin
        lIdx := Result.IndexOf(lCategoryName);

        If lIdx = -1 Then
        Begin
          lCurCat := Result.Add();

          With lCurCat Do
          Begin
            Name       := AMasterList[X].Name;
            Enabled    := AMasterList[X].Enabled;
            BuildStore := AMasterList[X].BuildStore;
          End;
        End
        Else
          lCurCat := Result[lIdx];

        lCurCat.Add().Assign(AMasterList[X][Y]);
      End
      Else
      Begin
        For Z := 0 To AMasterList[X][Y].Count - 1 Do
        Begin
          lIdx := Category[lCIdx][lPIdx].IndexOf(AMasterList[X][Y][Z].Id);

          If lIdx = -1 Then
          Begin
            lIdx := Result.IndexOf(AMasterList[X].Name);

            If lIdx = -1 Then
            Begin
              lCurCat := Result.Add();

              With lCurCat Do
              Begin
                Name       := AMasterList[X].Name;
                Enabled    := AMasterList[X].Enabled;
                BuildStore := AMasterList[X].BuildStore;
              End;
            End
            Else
              lCurCat := Result[lIdx];

            lIdx := lCurCat.IndexOf(AMasterList[X][Y].PackageType, AMasterList[X][Y].XmlFile);

            If lIdx = -1 Then
            Begin
              lCurPkg := lCurCat.Add();

              lCurPkg.PackageType := AMasterList[X][Y].PackageType;
              lCurPkg.XmlFile     := AMasterList[X][Y].XmlFile;
              lCurPkg.Enabled     := AMasterList[X][Y].Enabled;
            End
            Else
              lCurPkg := lCurCat[lIdx];

            lCurPkg.Add().Assign(AMasterList[X][Y][Z]);
          End;
        End;
      End;
    End;
  End;
End;

Procedure TTSTOHackMasterListIOImpl.BuildMasterList(AProject : ITSTOXMLProject);
Var X, Y, Z       : Integer;
    lPos, lIdx    : Integer;
    lXmlMaster    : IXmlDocumentEx;
    lMasterNodes  : IXmlNodeListEx;
    lInclNodes    : IXmlNodeListEx;
    lCategoryName : String;
    lPackageType  : String;
    lCurCategory  : ITSTOHackMasterCategoryIO;
    lCurPackage   : ITSTOHackMasterPackageIO;
    lIncl         : String;
    lStrs         : TStringList;
Begin
  With AProject.Settings Do
    For X := 0 To MasterFiles.Count - 1 Do
      If FileExists(SourcePath + MasterFiles[X].FileName) Then
      Begin
        lXmlMaster := LoadXmlDocument(SourcePath + MasterFiles[X].FileName);
        Try
          lMasterNodes := lXmlMaster.SelectNodes('//Include');

          //Build full master list
          Try
            For Y := 0 To lMasterNodes.Count - 1 Do
            Begin
              lStrs := TStringList.Create();
              Try
                lIncl := lMasterNodes[Y].Attributes['path'];
                Classes.ExtractStrings([':'], [], PChar(lIncl), lStrs);

                If (lStrs.Count > 0) And FileExists(SourcePath + lStrs[0]) Then
                Begin
                  lIncl := '';
                  For Z := 1 To lStrs.Count - 1 Do
                    lIncl := lIncl + '/' + lStrs[Z];
                  lIncl := '/' + lIncl + '//DataID';

                  lInclNodes := LoadXmlDocument(SourcePath + lStrs[0]).SelectNodes(lIncl);
                  For Z := 0 To lInclNodes.Count - 1 Do
                    lMasterNodes[Y].DOMNode.parentNode.appendChild(lInclNodes[Z].DOMNode.cloneNode(True));

//                  lMasterNodes[Y].DOMNode.parentNode.attributes.getNamedItem('name').nodeValue := ChangeFileExt(lStrs[0], '');
                  lMasterNodes[Y].DOMNode.parentNode.removeChild(lMasterNodes[Y].DOMNode);
                End;

                Finally
                  lStrs.Free();
              End;
            End;

            Finally
              lMasterNodes := Nil;
          End;

          lMasterNodes := lXmlMaster.SelectNodes('IDMasterList//Package');
          If Assigned(lMasterNodes) Then
          Try
            For Y := 0 To lMasterNodes.Count - 1 Do
            Begin
              lPos := Pos('_', lMasterNodes[Y].AttributeNodes['name'].Text);
              If lPos > 0 Then
              Begin
                lCategoryName := Copy(lMasterNodes[Y].AttributeNodes['name'].Text, 1, lPos - 1);
                lPackageType  := Copy(lMasterNodes[Y].AttributeNodes['name'].Text, lPos + 1, Length(lMasterNodes[Y].AttributeNodes['name'].Text));
              End
              Else
              Begin
                lCategoryName := '';//'<None>';
                lPackageType  := lMasterNodes[Y].AttributeNodes['name'].Text;
              End;

              lIdx := IndexOf(lCategoryName);
              If lIdx = -1 Then
              Begin
                lCurCategory := Add();
                lCurCategory.Name := lCategoryName;
                lCurCategory.Enabled := True;
                lCurCategory.BuildStore := True;
              End
              Else
                lCurCategory := Category[lIdx];

              lIdx := lCurCategory.IndexOf(MasterFiles[X].NodeName, lMasterNodes[Y].AttributeNodes['name'].Text + '.xml');
              If lIdx = -1 Then
              Begin
                lCurPackage := lCurCategory.Add();

                lCurPackage.PackageType := MasterFiles[X].NodeName;
                lCurPackage.XmlFile     := lMasterNodes[Y].AttributeNodes['name'].Text + '.xml';
                lCurPackage.Enabled     := True;
              End
              Else
                lCurPackage := lCurCategory[lIdx];

              For Z := 0 To lMasterNodes[Y].ChildNodes.Count - 1 Do
              Begin
                With lMasterNodes[Y].ChildNodes[Z] Do
                  If (NodeType = ntElement) And ((lIdx = -1) Or (lCurPackage.IndexOf(AttributeNodes['id'].NodeValue) = -1)) Then
                  Try
                    With lCurPackage.Add() Do
                    Begin
                      Id         := AttributeNodes['id'].NodeValue;
                      Name       := AttributeNodes['name'].NodeValue;
                    End;

                    Except
                      On E:Exception Do
//                        ShowMessage(GetEnumName(TypeInfo(TNodeType), Ord(lMasterNodes[Y].ChildNodes[Z].NodeType)));
                        ShowMessage( 'Error : ' + lCategoryName + ' - ' + lPackageType + #$D#$A +
                                     lCurPackage.XmlFile + ' - ' + lMasterNodes[Y].ChildNodes[Z].Xml);
                  End;
              End;
            End;

            Finally
              lMasterNodes := Nil;
          End;

          Finally
            lXmlMaster := Nil;
        End;
      End;
End;

Procedure TTSTOHackMasterListIOImpl.BuildMasterList(AProject : ITSTOXMLProject; Const ASaveInfo : Boolean);
Begin
  BuildMasterList(AProject);
  If ASaveInfo Then
  Begin
    EnhanceMasterList(AProject);
    SetAsXml(FormatXmlData(FXmlImpl.Xml));
  End;
End;

Procedure TTSTOHackMasterListIOImpl.EnhanceMasterList(AProject : ITSTOXMLProject);
Var X, Y, Z    : Integer;
    lXmlSrc    : IXmlDocumentEx;
    lNodeSrc   : IXmlNodeEx;
    lXmlMLHack : IXmlDocumentEx;
    lNodeML    : IXmlNodeEx;
    lNodeFName : IXmlNodeEx;
    lNodeAttr  : IXmlNodeEx;
    lIsUnique  : Boolean;
Begin
  lXmlMLHack := XmlImpl.OwnerDocument;
  Try
    For X := 0 To Count - 1 Do
    Begin
      For Y := 0 To Category[X].Count - 1 Do
      Begin
        If FileExists(AProject.Settings.SourcePath + Category[X][Y].XmlFile) Then
        Begin
          lXmlSrc  := LoadXmlDocument(AProject.Settings.SourcePath + Category[X][Y].XmlFile);
          lNodeSrc := lXmlSrc.SelectNode('//MasterList');
          If Assigned(lNodeSrc) Then                    
            lNodeSrc.DOMNode.parentNode.removeChild(lNodeSrc.DOMNode);

          lIsUnique  := Assigned(lXmlSrc.SelectNode('BuildingDefaults[Unique[@value="true"]]'));
          lNodeFName := lXmlMLHack.SelectNode('//*[@XmlFile="' + Category[X][Y].XmlFile + '"]');
          Try
            For Z := 0 To Category[X][Y].Count - 1 Do
            Begin
              lNodeSrc := lXmlSrc.SelectNode('//*[@id="' + IntToStr(Category[X][Y][Z].Id) + '" and @name="' + Category[X][Y][Z].Name + '"]');

              If Assigned(lNodeSrc) Then
              Try
//                lNodeML := lXmlMLHack.SelectNode('//*[@id="' + IntToStr(Category[X][Y][Z].Id) + '" and @name="' + Category[X][Y][Z].Name + '"]', lNodeFName);
                lNodeML := lXmlMLHack.SelectNode('//Package[@XmlFile="' + Category[X][Y].XmlFile + '"]/DataID[@id="' + IntToStr(Category[X][Y][Z].Id) + '" and @name="' + Category[X][Y][Z].Name + '"]');
                If Assigned(lNodeML) Then
                Try
                  lNodeML.Attributes['AddInStore'] := True;
                  lNodeML.Attributes['OverRide']   := True;

                  If SameText(Category[X][Y].PackageType, 'Consumable') And lNodeSrc.HasAttribute('type') Then
                  Begin
                    lNodeML.Attributes['Type'] := lNodeSrc.AttributeNodes['type'].Text;

                    If SameText(lNodeSrc.AttributeNodes['type'].Text, 'Script') Or
                       SameText(lNodeSrc.AttributeNodes['type'].Text, 'Prestige') Or
                       SameText(lNodeSrc.AttributeNodes['type'].Text, 'PrizeBox') Then
                    Begin
                      lNodeML.Attributes['AddInStore'] := False;
                      lNodeML.Attributes['OverRide']   := False;
                    End
                    Else If ( SameText(lNodeSrc.AttributeNodes['type'].Text, 'CharacterSkin') Or
                              SameText(lNodeSrc.AttributeNodes['type'].Text, 'BuildingSkin') ) And
                            lNodeSrc.HasAttribute('object') Then
                      lNodeML.Attributes['SkinObject'] := lNodeSrc.AttributeNodes['object'].Text;
                  End;

                  If SameText(Category[X][Y].PackageType, 'Character') Then
                  Begin
                    lNodeAttr := lXmlSrc.SelectNode('Set', lNodeSrc);
                    If Assigned(lNodeAttr) Then
                      lNodeML.ChildNodes.Add(lNodeAttr.CloneNode(True))
                    Else
                    Begin
                      lNodeML.Attributes['AddInStore'] := False;
                      lNodeML.Attributes['OverRide']   := False;
                      lNodeML.Attributes['NPCCharacter'] := True;
                    End;
                  End;

                  lNodeAttr := lXmlSrc.SelectNode('Cost', lNodeSrc);
                  If Assigned(lNodeAttr) Then
                    lNodeML.ChildNodes.Add(lNodeAttr.CloneNode(True));

                  If lIsUnique Then
                    lNodeML.AddChild('Unique').Attributes['value'] := 'true'
                  Else
                  Begin
                    lNodeAttr := lXmlSrc.SelectNode('Unique[@value="true"]', lNodeSrc);
                    If Assigned(lNodeAttr) Then
                      lNodeML.ChildNodes.Add(lNodeAttr.CloneNode(True));
                  End;

                  lNodeAttr := lXmlSrc.SelectNode('BuildTime', lNodeSrc);
                  If Assigned(lNodeAttr) Then
                    lNodeML.ChildNodes.Add(lNodeAttr.CloneNode(True));

                  lNodeAttr := lXmlSrc.SelectNode('Sell[@allowed="false" or @storeoverride="false"]', lNodeSrc);
                  If Assigned(lNodeAttr) Then
                    lNodeML.ChildNodes.Add(lNodeAttr.CloneNode(True));

                  lNodeAttr := lXmlSrc.SelectNode('Characters', lNodeSrc);
                  If Assigned(lNodeAttr) Then
                    lNodeML.ChildNodes.Add(lNodeAttr.CloneNode(True));

                  lNodeAttr := lXmlSrc.SelectNode('Character', lNodeSrc);
                  If Assigned(lNodeAttr) Then
                    lNodeML.ChildNodes.Add(lNodeAttr.CloneNode(True));

                  lNodeAttr := lXmlSrc.SelectNode('Requirements', lNodeSrc);
                  If Assigned(lNodeAttr) Then
                    lNodeML.ChildNodes.Add(lNodeAttr.CloneNode(True));

                  lNodeAttr := lXmlSrc.SelectNode('Requirement', lNodeSrc);
                  If Assigned(lNodeAttr) Then
                    lNodeML.ChildNodes.Add(lNodeAttr.CloneNode(True));

                  lNodeAttr := lXmlSrc.SelectNode('VisibilityRequirements', lNodeSrc);
                  If Assigned(lNodeAttr) Then
                    lNodeML.ChildNodes.Add(lNodeAttr.CloneNode(True));

                  lNodeAttr := lXmlSrc.SelectNode('VisibilityRequirement', lNodeSrc);
                  If Assigned(lNodeAttr) Then
                    lNodeML.ChildNodes.Add(lNodeAttr.CloneNode(True));

                  lNodeAttr := lXmlSrc.SelectNode('Proxy', lNodeSrc);
                  If Assigned(lNodeAttr) Then
                  Begin
                    lNodeML.Attributes['IsBadItem']  := True;
                    lNodeML.Attributes['AddInStore'] := False;
                    lNodeML.Attributes['OverRide']   := False;
                  End;

                  Finally
                    lNodeML := Nil;
                End;

                Finally
                  lNodeSrc := Nil;
              End;
            End;

            Finally
              lXmlSrc := Nil;
          End;
        End;
      End;
    End;

    Finally
      lXmlMLHack := Nil;
  End;
End;

Type
  IStoreRequirementItem = Interface(IInterfaceEx)
    ['{1EE830DD-E1DB-46CD-BAA9-49B88B3212AF}']
    Function  GetLevel() : Integer;
    Procedure SetLevel(Const ALevel : Integer);

    Function GetCount() : Integer;

    Function GetItems(Index : Integer) : ITSTOHackMasterDataIDIO;

    Procedure Add(AItem : ITSTOHackMasterDataIDIO);
    Function GetRequirements() : String;

    Property Level : Integer Read GetLevel Write SetLevel;
    Property Count : Integer Read GetCount;
    
    Property Items[Index : Integer] : ITSTOHackMasterDataIDIO Read GetItems; Default;

  End;

  IStoreRequirementItems = Interface(IInterfaceListEx)
    ['{2BC1A224-F35F-4B2C-8B47-69060C320E92}']
    Function Get(Index : Integer) : IStoreRequirementItem;
    Function Add() : IStoreRequirementItem;
    Function IndexOf(Const ALevel : Integer) : Integer;

    Property Items[Index : Integer] : IStoreRequirementItem Read Get; Default;

  End;
  
  TStoreRequirementItem = Class(TInterfacedObjectEx, IStoreRequirementItem)
  Private
    FLevel : Integer;
    FItems : ITSTOHackMasterPackageIO;

  Protected
    Procedure Created(); OverRide;

    Function  GetLevel() : Integer;
    Procedure SetLevel(Const ALevel : Integer);

    Function GetCount() : Integer;

    Function GetItems(Index : Integer) : ITSTOHackMasterDataIDIO;

    Procedure Add(AItem : ITSTOHackMasterDataIDIO);
    Function GetRequirements() : String;

  Public
    Destructor Destroy(); OverRide;

  End;

  TStoreRequirementItems = Class(TInterfaceListEx, IStoreRequirementItems)
  Protected
    Function Get(Index : Integer) : IStoreRequirementItem; OverLoad;
    Function Add() : IStoreRequirementItem; ReIntroduce; OverLoad;
    Function IndexOf(Const ALevel : Integer) : Integer; ReIntroduce; OverLoad;
    Function GetRequirements() : String;
    
  End;

Procedure TStoreRequirementItem.Created();
Begin
  FItems := TTSTOHackMasterPackageIO.Create();
End;

Destructor TStoreRequirementItem.Destroy();
Begin
  FItems := Nil;

  InHerited Destroy();
End;

Function TStoreRequirementItem.GetLevel() : Integer;
Begin
  Result := FLevel;
End;

Procedure TStoreRequirementItem.SetLevel(Const ALevel : Integer);
Begin
  FLevel := ALevel;
End;

Function TStoreRequirementItem.GetCount() : Integer;
Begin
  Result := FItems.Count;
End;

Function TStoreRequirementItem.GetItems(Index : Integer) : ITSTOHackMasterDataIDIO;
Begin
  Result := FItems[Index];
End;

Procedure TStoreRequirementItem.Add(AItem : ITSTOHackMasterDataIDIO);
Begin
  With FItems.Add() Do
  Begin
    Assign(AItem);
    ItemType := AItem.ItemType;
  End;
End;

Function TStoreRequirementItem.GetRequirements() : String;
Var X : Integer;
    lHaveUnique : Boolean;
    lHaveNonUnique : Boolean;
Begin
  Result      := '';
  lHaveUnique := False;
  lHaveNonUnique := False;

  For X := 0 To FItems.Count - 1 Do
    If FItems[X].Unique Then
      lHaveUnique := True
    Else
      lHaveNonUnique := True;

  With TStringList.Create() Do
  Try
    If FLevel > 0 Then
    Begin
      Add('<Requirement type="conditional" logic="OR">');
      Add('<Requirement type="formula" formula="KhnEverythingUnlocked == 1"/>');
      Add('<Requirement type="level" level="' + IntToStr(FLevel) + '"/>');
      Add('</Requirement>');
    End;

    If lHaveUnique And Not lHaveNonUnique Then
    Begin
      Add('<Requirement type="conditional" logic="OR">');
      Add('<Requirement type="formula" formula="KhnNonUnique == 1"/>');
      For X := 0 To FItems.Count - 1 Do
        If (FItems[X].ItemType = tdtBuilding) And FItems[X].Unique Then
          Add('<Requirement type="building" building="' + FItems[X].Name + '" not="true" />')
        Else If FItems[X].ItemType = tdtCharacter Then
        Begin
          Add('<Requirement type="conditional" logic="OR" not="true">');
          Add('<Requirement type="item" item="' + FItems[X].Name + '" />');
          Add('<Requirement type="character" name="' + FItems[X].Name + '" />');
          Add('</Requirement>');
        End;
      Add('</Requirement>');
    End;

    Result := Text;
    
    Finally
      Free();
  End;
End;

Function TStoreRequirementItems.Get(Index : Integer) : IStoreRequirementItem;
Begin
  Result := InHerited Items[Index] As IStoreRequirementItem;
End;

Function TStoreRequirementItems.Add() : IStoreRequirementItem;
Begin
  Result := TStoreRequirementItem.Create();
  InHerited Add(Result);
End;

Function TStoreRequirementItems.IndexOf(Const ALevel : Integer) : Integer;
Var X : Integer;
Begin
  Result := -1;

  For X := 0 To Count - 1 Do
    If Get(X).Level = ALevel Then
    Begin
      Result := X;
      Break;
    End;
End;

Function TStoreRequirementItems.GetRequirements() : String;
Var X, Y : Integer;
    lIdx : Integer;
    lNonUnique : Boolean;
    lNonUniqueLvl : Integer;
    lUniqueLvls : Array Of Integer;
    lRetVal : TStringList;
    lItem : IStoreRequirementItem;
    lResult : String;
Begin
  lNonUnique := False;
  lNonUniqueLvl := 999;
  For X := 0 To Count - 1 Do
  Begin
    lItem := Get(X);
    For Y := 0 To lItem.Count - 1 Do
      With lItem[Y] Do
      Begin
        If Unique Then
        Begin
          SetLength(lUniqueLvls, Length(lUniqueLvls) + 1);
          lUniqueLvls[High(lUniqueLvls)] := Level;
        End
        Else
          lNonUniqueLvl := Min(lNonUniqueLvl, Level);
      End;
  End;

  lRetVal := TStringList.Create();
  Try
    If (lNonUniqueLvl > 0) And (lNonUniqueLvl < 999) Then
    Begin
      If Length(lUniqueLvls) > 0 Then
        For X := Low(lUniqueLvls) To High(lUniqueLvls) Do
          lNonUnique := lNonUniqueLvl <= lUniqueLvls[X];

      If lNonUnique Then
      Begin
        lResult := lResult + '<Requirement type="conditional" logic="OR">';
        lResult := lResult + '<Requirement type="formula" formula="KhnEverythingUnlocked == 1"/>';
        lResult := lResult + '<Requirement type="level" level="' + IntToStr(lNonUniqueLvl) + '"/>';
        lResult := lResult + '</Requirement>';

        If Length(lUniqueLvls) > 0 Then
          For X := Low(lUniqueLvls) To High(lUniqueLvls) Do
            If lUniqueLvls[X] < lNonUniqueLvl Then
            Begin
              lIdx := IndexOf(lUniqueLvls[X]);
              lItem := Get(lIdx);

              lResult := lResult + '<Requirement type="conditional" logic="OR">';
              lResult := lResult + '<Requirement type="formula" formula="KhnNonUnique == 1"/>';
              For Y := 0 To lItem.Count - 1 Do
                If lItem[Y].Unique Then
                Begin
                  If (lItem[Y].ItemType = tdtBuilding) Then
                    lResult := lResult + '<Requirement type="building" building="' + lItem[Y].Name + '" not="true" />'
                  Else If lItem[Y].ItemType = tdtCharacter Then
                  Begin
                    lResult := lResult + '<Requirement type="conditional" logic="OR" not="true">';
                    lResult := lResult + '<Requirement type="item" item="' + lItem[Y].Name + '" />';
                    lResult := lResult + '<Requirement type="character" name="' + lItem[Y].Name + '" />';
                    lResult := lResult + '</Requirement>';
                  End;
                End;
              lResult := lResult + '</Requirement>';
            End;
        lRetVal.Add(lResult);
      End
      Else
      Begin
        For X := Low(lUniqueLvls) To High(lUniqueLvls) Do
        Begin
          lResult := '';
          lIdx := IndexOf(lUniqueLvls[X]);
          lItem := Get(lIdx);

          lResult := lResult + '<Requirement type="conditional" logic="OR">';
          lResult := lResult + '<Requirement type="formula" formula="KhnNonUnique == 1"/>';
          For Y := 0 To lItem.Count - 1 Do
            If lItem[Y].Unique Then
            Begin
              If (lItem[Y].ItemType = tdtBuilding) Then
                lResult := lResult + '<Requirement type="building" building="' + lItem[Y].Name + '" not="true" />'
              Else If lItem[Y].ItemType = tdtCharacter Then
              Begin
                lResult := lResult + '<Requirement type="conditional" logic="OR" not="true">';
                lResult := lResult + '<Requirement type="item" item="' + lItem[Y].Name + '" />';
                lResult := lResult + '<Requirement type="character" name="' + lItem[Y].Name + '" />';
                lResult := lResult + '</Requirement>';
              End;
            End;
          lResult := lResult + '</Requirement>';
          lRetVal.Add(lResult);
        End;
      End;
    End;

    Result := lRetVal.Text;
    
    Finally
      lRetVal.Free();
  End;
End;

Function TTSTOHackMasterListIOImpl.ListStoreRequirements(Const ACategoryName : String) : String;
Var lIdx    : Integer;
    lLvlIdx : Integer;
    lLvl    : Integer;
    X, Y    : Integer;
    lStoreItems : IStoreRequirementItems;

    lNonUnique    : Boolean;
    lUnique       : Boolean;
    lLvlNonUnique : Integer;
    lMinLvl       : Integer;
    lReqs         : TStringList;
    lMultipleReqs : Boolean;
    lTmpList      : TStringList;
    lReqStr       : String;
Begin
{
  HaveUnique MultipleUniqueLvl :
  AND (
    !HD
    OR (
      AND (
        OR (
          EU
          LvlX
        )
        OR (
          NU
          Item#1
        )
      )
      AND (
        OR (
          EU
          LvlX
        )
        OR (
          NU
          Item#1
        )
      )
      ...
    )
  )

  HaveUnique UniqueLvl > 0 :
  AND (
    !HD
    OR (
      EU
      LvlX
    )
    OR (
      NU
      Item#1
      Item#2...
    )
  )

  HaveNonUnique NonUniqueLvl > 0 :
  AND (
    !HD
    OR (
      EU
      LvlX
    )
  )

  HaveNonUnique Lvl = 0 :
  !HD
}
  lNonUnique := False;
  lUnique    := False;
  lLvlNonUnique := 999;
  lMinLvl       := 999;
  
  lIdx := IndexOf(ACategoryName);
  If (lIdx > -1) And Category[lIdx].BuildStore Then
  Begin
    lStoreItems := TStoreRequirementItems.Create();
    Try
      For X := 0 To Category[lIdx].Count - 1 Do
        If Category[lIdx][X].Enabled Then
          For Y := 0 To Category[lIdx][X].Count - 1 Do
            If Category[lIdx][X][Y].AddInStore Then
            Begin
              If SameText(Category[lIdx][X].PackageType, 'Character') Then
                Category[lIdx][X][Y].ItemType := tdtCharacter
              Else If SameText(Category[lIdx][X].PackageType, 'Building') Or
                      SameText(Category[lIdx][X].PackageType, 'Decoration') Then
                Category[lIdx][X][Y].ItemType := tdtBuilding;

              lLvl := Category[lIdx][X][Y].Level;
              If lLvl < 7 Then
                lLvl := 0;

              If Category[lIdx][X][Y].ItemType = tdtCharacter Then
                lUnique := True
              Else
              Begin
                lMinLvl := Min(lMinLvl, lLvl);

                If Category[lIdx][X][Y].Unique Then
                  lUnique := True
                Else
                Begin
                  lLvlNonUnique := Min(lLvlNonUnique, lLvl);
                  lNonUnique := True;
                End;
              End;
              
              lLvlIdx := lStoreItems.IndexOf(lLvl);
              If lLvlIdx = -1 Then
              Begin
                With lStoreItems.Add() Do
                Begin
                  Level := lLvl;
                  Add(Category[lIdx][X][Y]);
                End;
              End
              Else
                lStoreItems[lLvlIdx].Add(Category[lIdx][X][Y]);
            End;

      If lNonUnique Then
        lMultipleReqs := (lLvlNonUnique > 0) And (lLvlNonUnique < 999)
      Else
        lMultipleReqs := lUnique;

//lStoreItems.SaveToFile('C:\Projects\TSTO-Hacker\Bin\Hacks\KahnHack\4_21_4thOfJuly_Patch2_PostLaunch_JB9E2ZABYP3S\gamescripts-r324526-Z1IXRY9Q\Test.Xml');

      lReqs := TStringList.Create();
      Try
        //lReqs.Add('<Requirements>');
        lReqs.Add('<StoreReqs' + ACategoryName + '>');
        If lMultipleReqs Then
          lReqs.Add('<Requirement type="conditional" logic="AND">');

        lReqs.Add('<Requirement type="reqList" location="Kahn_Requirements:ReqsHackEnabled"/>');
        If lMultipleReqs Then
        Begin
          lTmpList := TStringList.Create();
          Try
            For X := 0 To lStoreItems.Count - 1 Do
            Begin
              lReqStr := lStoreItems[X].GetRequirements;
              If lReqStr <> '' Then
                lTmpList.Add(lReqStr);
            End;

            If lTmpList.Text <> '' Then
            Begin
              If lTmpList.Count > 1 Then
              Begin
                lReqs.Add('<Requirement type="conditional" logic="OR">');
                For X := 0 To lTmpList.Count - 1 Do
                Begin
                  lReqs.Add('<Requirement type="conditional" logic="AND">');
                  lReqs.Add(lTmpList[X]);
                  lReqs.Add('</Requirement>');
                End;
                lReqs.Add('</Requirement>');
              End
              Else
                lReqs.Add(lTmpList.Text);
            End;

            Finally
              lTmpList.Free();
          End;

          lReqs.Add('</Requirement>');
        End;
        lReqs.Add('</StoreReqs' + ACategoryName + '>');

//        ShowMessage(lReqs.Text);
//        lReqs.Text := FormatXmlData(lReqs.Text);
//        ShowMessage(lReqs.Text);
        Try
          Result := FormatXmlData(lReqs.Text);
          Except
            On E:Exception Do
              ShowMessage(E.Message + ' : ' + ACategoryName + #$D#$A + lReqs.Text);
        End;

        Finally
          lReqs.Free();
      End;

      Finally
        lStoreItems := Nil;
    End;
  End;
End;

Function TTSTOHackMasterListIOImpl.BuildStoreMenu(ASettings : ITSTOScriptTemplateSettings; AProgress : IRgbProgress = Nil) : String;
Var X, Y, Z : Integer;
    lLst : IHsStringListEx;
    lNbItem : Integer;
Begin
  With ASettings Do
  Begin
    If CategoryNamePrefix = '' Then
      CategoryNamePrefix := 'Khn';
    If StoreItemsPath = '' Then
      StoreItemsPath := 'Kahn_MenuItems.xml:Stores:Store';
    If RequirementPath = '' Then
      RequirementPath := 'Kahn_Requirements:StoreReqs';

    lLst := THsStringListEx.CreateList();
    Try
      lNbItem := 0;
      If Assigned(AProgress) Then
        For X := 0 To Count - 1 Do
          If Category[X].BuildStore Then
            Inc(lNbItem);

      lLst.Add('<Categories>');

      For X := 0 To Count - 1 Do
        If Category[X].BuildStore Then
        Begin
          lLst.Add( '<Category name="' + CategoryNamePrefix + Category[X].Name +
                    '" title="UI_' + Category[X].Name +
                    '" icon="' + Category[X].Name + 'Store" ' +
                    'disabledIcon="' + Category[X].Name + 'Store" ' +
                    'emptyText="UI_StoreEmpty"' +
                    ' sortList="false" newestFirst="false"' +
                    '>');
          lLst.Add('<Include path="' + StoreItemsPath + Category[X].Name + '"/>');
          lLst.Add('<Requirement type="reqList" location="' + RequirementPath + Category[X].Name + '"/>');
          lLst.Add('</Category>');

          If Assigned(AProgress) Then
          Begin
            AProgress.CurArchiveName  := Category[X].Name;
            AProgress.ArchiveProgress := Round(X / lNbItem * 100);
            Application.ProcessMessages();
          End;
        End;

      lLst.Add('</Categories>');

      Result := FormatXMLData(lLst.Text);
      If Assigned(AProgress) Then
      Begin
        AProgress.ArchiveProgress := 100;
        Application.ProcessMessages();
      End;

      Finally
        lLst := Nil;
    End;
  End;
End;

Function TTSTOHackMasterListIOImpl.BuildStoreMenu() : String;
Begin
  Result := BuildStoreMenu(TTSTOScriptTemplateSettings.Create());
End;

Procedure TTSTOHackMasterListIOImpl.BuildStoreMenu(Const AFileName : String);
Var lLst : IHsStringListEx;
Begin
  lLst := THsStringListEx.CreateList();
  Try
    lLst.Add(BuildStoreMenu());
    lLst.SaveToFile(AFileName);

    Finally
      lLst := Nil;
  End;
End;

Function TTSTOHackMasterListIOImpl.BuildInventoryMenu(ASettings : ITSTOScriptTemplateSettings; AProgress : IRgbProgress = Nil) : String;
Var X, Y, Z : Integer;
    lLst : IHsStringListEx;
    lNbItem : Integer;
    lCurItem : Integer;
Begin
  With ASettings Do
  Begin
    If CategoryNamePrefix = '' Then
      CategoryNamePrefix := 'KhnInventory';
    If StoreItemsPath = '' Then
      StoreItemsPath := 'Kahn_MenuItems.xml:Stores:Store';

    lLst := THsStringListEx.CreateList();
    Try
      lNbItem := 0;
      lCurItem := 0;
      If Assigned(AProgress) Then
        For X := 0 To Count - 1 Do
          If Category[X].BuildStore Then
            For Y := 0 To Category[X].Count - 1 Do
              If Category[X].Package[Y].Enabled Then
                For Z := 0 To Category[X].Package[Y].Count - 1 Do
                  If Category[X].Package[Y].DataID[Z].AddInStore Then
                    Inc(lNbItem);

      lLst.Add('<InventoryMenus>');
      lLst.Add('<Categories>');

      For X := 0 To Count - 1 Do
        If Category[X].BuildStore Then
        Begin
          lLst.Add( '<Category name="' + CategoryNamePrefix + Category[X].Name +
                    '" title="UI_' + Category[X].Name +
                    '" icon="' + Category[X].Name + 'Store" ' +
                    'disabledIcon="' + Category[X].Name + 'Store" ' +
                    'emptyText="UI_StoreEmpty"' +
                    ' sortList="false" newestFirst="false"' +
                    '>');
          lLst.Add('<Include path="' + StoreItemsPath + Category[X].Name + '"/>');
          lLst.Add('<Requirements>');
          lLst.Add('<Requirement type="conditional" logic="AND">');
          lLst.Add('<Requirement type="reqList" location="Kahn_Requirements:ReqsHackEnabled"/>');
          lLst.Add('<Requirement type="conditional" logic="OR">');

          For Y := 0 To Category[X].Count - 1 Do
            If Category[X].Package[Y].Enabled Then
              For Z := 0 To Category[X].Package[Y].Count - 1 Do
                If Category[X].Package[Y].DataID[Z].AddInStore Then
                Begin
                  lLst.Add( '<Requirement type="item" item="' +
                            Category[X].Package[Y].DataID[Z].Name +
                            '" checkInventoryOnly="true"/>');

                  If Assigned(AProgress) Then
                  Begin
                    Inc(lCurItem);

                    AProgress.CurArchiveName  := Category[X].Name + ' - ' + Category[X].Package[Y].DataID[Z].Name;
                    AProgress.ArchiveProgress := Round(lCurItem / lNbItem * 100);
                    Application.ProcessMessages();
                  End;
                End;

          lLst.Add('</Requirement>');
          lLst.Add('</Requirement>');
          lLst.Add('</Requirements>');
          lLst.Add('</Category>');
        End;

      lLst.Add('</Categories>');
      lLst.Add('</InventoryMenus>');

      Result := FormatXMLData(lLst.Text);
      If Assigned(AProgress) Then
      Begin
        AProgress.ArchiveProgress := 100;
        Application.ProcessMessages();
      End;

      Finally
        lLst := Nil;
    End;
  End;
End;

Function TTSTOHackMasterListIOImpl.BuildInventoryMenu() : String;
Begin
  Result := BuildInventoryMenu(TTSTOScriptTemplateSettings.Create());
End;

Procedure TTSTOHackMasterListIOImpl.BuildInventoryMenu(Const AFileName : String);
Var lLst : IHsStringListEx;
Begin
  lLst := THsStringListEx.CreateList();
  Try
    lLst.Add(BuildInventoryMenu());
    lLst.SaveToFile(AFileName);

    Finally
      lLst := Nil;
  End;
End;

Function TTSTOHackMasterListIOImpl.BuildStoreItems(ASettings : ITSTOScriptTemplateSettings; AProgress : IRgbProgress = Nil) : String;
Var X, Y, Z : Integer;
    lLst    : IHsStringListEx;
    lNbItems : Integer;
    lCurItem : Integer;
Begin
  With ASettings Do
  Begin
    If StorePrefix = '' Then
      StorePrefix := 'Store';

    lLst := THsStringListEx.CreateList();
    Try
      lNbItems := 0;
      lCurItem := 0;
      If Assigned(AProgress) Then
        For X := 0 To Count - 1 Do
          If Category[X].Enabled And Category[X].BuildStore Then
            For Y := 0 To Category[X].Count - 1 Do
              If Category[X][Y].Enabled Then
                For Z := 0 To Category[X][Y].Count - 1 Do
                  If Category[X][Y].DataID[Z].AddInStore Then
                    Inc(lNbItems);

      lLst.Add('<Stores>');

      For X := 0 To Count - 1 Do
        If Category[X].Enabled And Category[X].BuildStore Then
        Begin
          lLst.Add('<' + StorePrefix + Category[X].Name + '>');
          For Y := 0 To Category[X].Count - 1 Do
            If Category[X][Y].Enabled Then
              For Z := 0 To Category[X][Y].Count - 1 Do
                If Category[X][Y].DataID[Z].AddInStore Then
                Begin
                  lLst.Add( '<Object type = "' + LowerCase(Category[X][Y].PackageType) + '"' +
                            ' id="' + IntToStr(Category[X][Y][Z].Id) + '"' +
                            ' name="' + Category[X][Y][Z].Name + '"/>' );

                  If Assigned(AProgress) Then
                  Begin
                    Inc(lCurItem);

                    AProgress.CurArchiveName  := Category[X].Name + ' - ' + Category[X].Package[Y].DataID[Z].Name;
                    AProgress.ArchiveProgress := Round(lCurItem / lNbItems * 100);
                    Application.ProcessMessages();
                  End;
                End;

          lLst.Add('</' + StorePrefix + Category[X].Name + '>');
        End;


      lLst.Add('</Stores>');

      Result := FormatXMLData(lLst.Text);
      If Assigned(AProgress) Then
      Begin
        AProgress.ArchiveProgress := 100;
        Application.ProcessMessages();
      End;

      Finally
        lLst := Nil;
    End;
  End;
End;

Function TTSTOHackMasterListIOImpl.BuildStoreItems() : String;
Begin
  Result := BuildStoreItems(TTSTOScriptTemplateSettings.Create());
End;

Procedure TTSTOHackMasterListIOImpl.BuildStoreItems(Const AFileName : String);
Var lLst : IHsStringListEx;
Begin
  lLst := THsStringListEx.CreateList();
  Try
    lLst.Add(BuildStoreItems());
    lLst.SaveToFile(AFileName);

    Finally
      lLst := Nil;
  End;
End;

Function  TTSTOHackMasterListIOImpl.BuildFreeItems(AProgress : IRgbProgress = Nil) : String;
  Function CategoryHavePaidItem(ACategory : ITSTOHackMasterCategoryIO) : Boolean;
  Var X, Y : Integer;
  Begin
    Result := False;

    For X := 0 To ACategory.Count - 1 Do
    Begin
      If ACategory[X].Enabled Then
      Begin
        For Y := 0 To ACategory[X].Count - 1 Do
          If Not ACategory[X][Y].IsFree And ACategory[X][Y].OverRide Then
          Begin
            Result := True;
            Break;
          End;
      End;

      If Result Then
        Break;
    End;
  End;

Var X, Y, Z : Integer;
    lLst           : IHsStringListEx;
    lCurLst        : IHsStringListEx;
    lLstBuilding   : IHsStringListEx;
    lLstDecoration : IHsStringListEx;
    lLstCharacter  : IHsStringListEx;
    lLstConsumable : IHsStringListEx;

    lCmtBuildingAdd   : Boolean;
    lCmtDecorationAdd : Boolean;
    lCmtCharacterAdd  : Boolean;
    lCmtConsumableAdd : Boolean;
    lStrComment       : String;
    lNbItems : Integer;
    lCurItem : Integer;
Begin
  lLst           := THsStringListEx.CreateList();
  lLstBuilding   := THsStringListEx.CreateList();
  lLstDecoration := THsStringListEx.CreateList();
  lLstCharacter  := THsStringListEx.CreateList();
  lLstConsumable := THsStringListEx.CreateList();
  Try
    lNbItems := 0;
    lCurItem := 0;

    If Assigned(AProgress) Then
      For X := 0 To Count - 1 Do
        If Category[X].Enabled And CategoryHavePaidItem(Category[X]) Then
          For Y := 0 To Category[X].Count - 1 Do
            If Category[X][Y].Enabled Then
              For Z := 0 To Category[X][Y].Count - 1 Do
                If Not Category[X][Y][Z].IsFree And Category[X][Y][Z].OverRide Then
                  Inc(lNbItems);

    For X := 0 To Count - 1 Do
      If Category[X].Enabled Then
      Begin
        lCmtBuildingAdd   := False;
        lCmtDecorationAdd := False;
        lCmtCharacterAdd  := False;
        lCmtConsumableAdd := False;

        lStrComment       := '<!-- ';
        If Category[X].Name = '' Then
          lStrComment := lStrComment + ' Default'
        Else
          lStrComment := lStrComment + ' ' + Category[X].Name;
        lStrComment := lStrComment + ' -->';

        If CategoryHavePaidItem(Category[X]) Then
        Begin
          For Y := 0 To Category[X].Count - 1 Do
            If Category[X][Y].Enabled Then
              For Z := 0 To Category[X][Y].Count - 1 Do
                If Not Category[X][Y][Z].IsFree And Category[X][Y][Z].OverRide Then
                Begin
                  If Assigned(AProgress) Then
                  Begin
                    Inc(lCurItem);

                    AProgress.CurArchiveName  := Category[X].Name + ' - ' + Category[X][Y][Z].Name;
                    AProgress.ArchiveProgress := Round(lCurItem / lNbItems * 100);
                    Application.ProcessMessages();
                  End;

                  lCurLst := Nil;

                  If SameText(Category[X][Y].PackageType, 'Building') Then
                  Begin
                    If Pos('_DECORATION', UpperCase(Category[X][Y].XmlFile)) > 0 Then
                    Begin
                      lCurLst := lLstDecoration;
                      If Not lCmtDecorationAdd Then
                      Begin
                        lCmtDecorationAdd := True;
                        lCurLst.Add(lStrComment);
                      End;
                    End
                    Else
                    Begin
                      lCurLst := lLstBuilding;
                      If Not lCmtBuildingAdd Then
                      Begin
                        lCmtBuildingAdd := True;
                        lCurLst.Add(lStrComment);
                      End;
                    End;
                  End
                  Else If SameText(Category[X][Y].PackageType, 'Character') Then
                  Begin
                    lCurLst := lLstCharacter;
                    If Not lCmtCharacterAdd Then
                    Begin
                      lCmtCharacterAdd := True;
                      lCurLst.Add(lStrComment);
                    End;
                  End
                  Else If SameText(Category[X][Y].PackageType, 'Consumable') Then
                  Begin
                    lCurLst := lLstConsumable;
                    If Not lCmtConsumableAdd Then
                    Begin
                      lCmtConsumableAdd := True;
                      lCurLst.Add(lStrComment);
                    End;
                  End;

                  If Assigned(lCurLst) Then
                  Begin

                    If lCurLst = lLstConsumable Then
                    Begin
                      lCurLst.Add('<Consumable name="' + Category[X][Y][Z].Name + '">');
                      lCurLst.Add('<Cost money="0"/>');
                      lCurLst.Add('</Consumable>');
                    End
                    Else
                      lCurLst.Add('<String name="' + Category[X][Y][Z].Name + '"/>');
                  End;
                End;
        End
        Else
        Begin
          lLstBuilding.Add(lStrComment);
          lLstBuilding.Add('<!-- N/A -->');

          lLstDecoration.Add(lStrComment);
          lLstDecoration.Add('<!-- N/A -->');

          lLstCharacter.Add(lStrComment);
          lLstCharacter.Add('<!-- N/A -->');

          lLstConsumable.Add(lStrComment);
          lLstConsumable.Add('<!-- N/A -->');
        End;
      End;

    lLst.Add('<List name="KhnBuilding">');
    lLst.Add(lLstBuilding.Text);
    lLst.Add('</List>');

    lLst.Add('<List name="KhnDecoration">');
    lLst.Add(lLstDecoration.Text);
    lLst.Add('</List>');

    lLst.Add('<List name="KhnCharacter">');
    lLst.Add(lLstCharacter.Text);
    lLst.Add('</List>');

    lLst.Add('<Consumables override="true">');
    lLst.Add(lLstConsumable.Text);
    lLst.Add('</Consumables>');
    Result := lLst.Text;

    If Assigned(AProgress) Then
    Begin
      AProgress.ArchiveProgress := 100;
      Application.ProcessMessages();
    End;

    Finally
      lLst := Nil;
      lLstBuilding   := Nil;
      lLstDecoration := Nil;
      lLstCharacter  := Nil;
      lLstConsumable := Nil;
  End;
End;

Procedure TTSTOHackMasterListIOImpl.BuildFreeItems(Const AFileName : String);
Var lLst : IHsStringListEx;
Begin
  lLst := THsStringListEx.CreateList();
  Try
    lLst.Text := FormatXmlData('<FreeItemEvent>' + BuildFreeItems() + '</FreeItemEvent>');
    lLst.SaveToFile(AFileName);

    Finally
      lLst := Nil;
  End;
End;

Function TTSTOHackMasterListIOImpl.BuildUniqueItems(AProgress : IRgbProgress = Nil) : String;
  Function CategoryHaveUniqueItem(ACategory : ITSTOHackMasterCategoryIO) : Boolean;
    Var X, Y : Integer;
  Begin
    Result := False;

    For X := 0 To ACategory.Count - 1 Do
    Begin
      If ACategory[X].Enabled Then
      Begin
        For Y := 0 To ACategory[X].Count - 1 Do
        Begin
          If SameText(ACategory[X].PackageType, 'Character') Then
            ACategory[X][Y].ItemType := tdtCharacter
          Else
            ACategory[X][Y].ItemType := tdtBuilding;

          If ACategory[X][Y].Unique Then
          Begin
            Result := True;
            Break;
          End;
        End;
      End;

      If Result Then
        Break;
    End;
  End;

Var X, Y, Z : Integer;
    lLst           : IHsStringListEx;
    lCurLst        : IHsStringListEx;
    lLstBuilding   : IHsStringListEx;
    lLstDecoration : IHsStringListEx;
    lLstCharacter  : IHsStringListEx;
    lLstConsumable : IHsStringListEx;

    lCmtBuildingAdd   : Boolean;
    lCmtDecorationAdd : Boolean;
    lCmtCharacterAdd  : Boolean;
    lCmtConsumableAdd : Boolean;
    lStrComment       : String;

    lNbItems : Integer;
    lCurItem : Integer;
Begin
  lLst           := THsStringListEx.CreateList();
  lLstBuilding   := THsStringListEx.CreateList();
  lLstDecoration := THsStringListEx.CreateList();
  lLstCharacter  := THsStringListEx.CreateList();
  lLstConsumable := THsStringListEx.CreateList();
  Try
    lNbItems := 0;
    lCurItem := 0;

    If Assigned(AProgress) Then
      For X := 0 To Count - 1 Do
        If Category[X].Enabled And CategoryHaveUniqueItem(Category[X]) Then
          For Y := 0 To Category[X].Count - 1 Do
            If Category[X][Y].Enabled Then
              For Z := 0 To Category[X][Y].Count - 1 Do
                If Not Category[X][Y][Z].IsFree And Category[X][Y][Z].OverRide Then
                  Inc(lNbItems);

    For X := 0 To Count - 1 Do
      If Category[X].Enabled Then
      Begin
        lCmtBuildingAdd   := False;
        lCmtDecorationAdd := False;
        lCmtCharacterAdd  := False;
        lCmtConsumableAdd := False;

        lStrComment       := '<!-- ';
        If Category[X].Name = '' Then
          lStrComment := lStrComment + ' Default'
        Else
          lStrComment := lStrComment + ' ' + Category[X].Name;
        lStrComment := lStrComment + ' -->';

        If CategoryHaveUniqueItem(Category[X]) Then
        Begin
          For Y := 0 To Category[X].Count - 1 Do
            If Category[X][Y].Enabled Then
              For Z := 0 To Category[X][Y].Count - 1 Do
              Begin
                If SameText(Category[X][Y].PackageType, 'Character') Then
                  Category[X][Y][Z].ItemType := tdtCharacter
                Else
                  Category[X][Y][Z].ItemType := tdtBuilding;

                If Category[X][Y][Z].Unique And Category[X][Y][Z].OverRide And (Category[X][Y][Z].ItemType <> tdtCharacter) Then
                Begin
                  lCurLst := Nil;

                  If Assigned(AProgress) Then
                  Begin
                    Inc(lCurItem);

                    AProgress.CurArchiveName  := Category[X].Name + ' - ' + Category[X][Y][Z].Name;
                    AProgress.ArchiveProgress := Round(lCurItem / lNbItems * 100);
                    Application.ProcessMessages();
                  End;

                  If SameText(Category[X][Y].PackageType, 'Building') Then
                  Begin
                    If Pos('_DECORATION', UpperCase(Category[X][Y].XmlFile)) > 0 Then
                    Begin
                      lCurLst := lLstDecoration;
                      If Not lCmtDecorationAdd Then
                      Begin
                        lCmtDecorationAdd := True;
                        lCurLst.Add(lStrComment);
                      End;
                    End
                    Else
                    Begin
                      lCurLst := lLstBuilding;
                      If Not lCmtBuildingAdd Then
                      Begin
                        lCmtBuildingAdd := True;
                        lCurLst.Add(lStrComment);
                      End;
                    End;
                  End
                  Else If SameText(Category[X][Y].PackageType, 'Character') Then
                  Begin
                    lCurLst := lLstCharacter;
                    If Not lCmtCharacterAdd Then
                    Begin
                      lCmtCharacterAdd := True;
                      lCurLst.Add(lStrComment);
                    End;
                  End
                  Else If SameText(Category[X][Y].PackageType, 'Consumable') Then
                  Begin
                    lCurLst := lLstConsumable;
                    If Not lCmtConsumableAdd Then
                    Begin
                      lCmtConsumableAdd := True;
                      lCurLst.Add(lStrComment);
                    End;
                  End;

                  If Assigned(lCurLst) Then
                  Begin
                    If lCurLst = lLstConsumable Then
                    Begin
                      lCurLst.Add('<Consumable name="' + Category[X][Y][Z].Name + '">');
                      lCurLst.Add('<Cost money="0"/>');
                      lCurLst.Add('</Consumable>');
                    End
                    Else
                      lCurLst.Add('<String name="' + Category[X][Y][Z].Name + '"/>');
                  End;
                End;
              End;
        End
        Else
        Begin
          lLstBuilding.Add(lStrComment);
          lLstBuilding.Add('<!-- N/A -->');

          lLstDecoration.Add(lStrComment);
          lLstDecoration.Add('<!-- N/A -->');

          lLstCharacter.Add(lStrComment);
          lLstCharacter.Add('<!-- N/A -->');

          lLstConsumable.Add(lStrComment);
          lLstConsumable.Add('<!-- N/A -->');
        End;
      End;

    lLst.Add('<List name="KhnBuildingNU">');
    lLst.Add(lLstBuilding.Text);
    lLst.Add('</List>');

    lLst.Add('<List name="KhnDecorationNU">');
    lLst.Add(lLstDecoration.Text);
    lLst.Add('</List>');

    lLst.Add('<List name="KhnCharacterNU">');
    lLst.Add(lLstCharacter.Text);
    lLst.Add('</List>');

    lLst.Add('<Consumables override="true">');
    lLst.Add(lLstConsumable.Text);
    lLst.Add('</Consumables>');

    Result := lLst.Text;
    If Assigned(AProgress) Then
    Begin
      AProgress.ArchiveProgress := 100;
      Application.ProcessMessages();
    End;

    Finally
      lLst := Nil;
      lLstBuilding   := Nil;
      lLstDecoration := Nil;
      lLstCharacter  := Nil;
      lLstConsumable := Nil;
  End;
End;

Procedure TTSTOHackMasterListIOImpl.BuildUniqueItems(Const AFileName : String);
Var lLst : IHsStringListEx;
Begin
  lLst := THsStringListEx.CreateList();
  Try
    lLst.Text := FormatXmlData('<UniqueItemEvent>' + BuildUniqueItems() + '</UniqueItemEvent>');
    lLst.SaveToFile(AFileName);

    Finally
      lLst := Nil;
  End;
End;

Function TTSTOHackMasterListIOImpl.BuildNonSellableItems(AProgress : IRgbProgress = Nil) : String;
  Function CategoryHaveNonSellableItem(ACategory : ITSTOHackMasterCategoryIO) : Boolean;
    Var X, Y : Integer;
  Begin
    Result := False;

    For X := 0 To ACategory.Count - 1 Do
    Begin
      If ACategory[X].Enabled Then
      Begin
        For Y := 0 To ACategory[X].Count - 1 Do
        Begin
          If SameText(ACategory[X].PackageType, 'Character') Then
            ACategory[X][Y].ItemType := tdtCharacter
          Else
            ACategory[X][Y].ItemType := tdtBuilding;

          If Not ACategory[X][Y].Storable Or Not ACategory[X][Y].Sellable Then
          Begin
            Result := True;
            Break;
          End;
        End;
      End;

      If Result Then
        Break;
    End;
  End;

Var X, Y, Z : Integer;
    lLst           : IHsStringListEx;
    lCurLst        : IHsStringListEx;
    lLstBuilding   : IHsStringListEx;
    lLstDecoration : IHsStringListEx;
    lLstCharacter  : IHsStringListEx;
    lLstConsumable : IHsStringListEx;

    lCmtBuildingAdd   : Boolean;
    lCmtDecorationAdd : Boolean;
    lCmtCharacterAdd  : Boolean;
    lCmtConsumableAdd : Boolean;
    lStrComment       : String;

    lNbItems : Integer;
    lCurItem : Integer;
Begin
  lLst           := THsStringListEx.CreateList();
  lLstBuilding   := THsStringListEx.CreateList();
  lLstDecoration := THsStringListEx.CreateList();
  lLstCharacter  := THsStringListEx.CreateList();
  lLstConsumable := THsStringListEx.CreateList();
  Try
    lNbItems := 0;
    lCurItem := 0;
    If Assigned(AProgress) Then
      For X := 0 To Count - 1 Do
        If Category[X].Enabled And CategoryHaveNonSellableItem(Category[X]) Then
          For Y := 0 To Category[X].Count - 1 Do
            For Z := 0 To Category[X][Y].Count - 1 Do
              If (Not Category[X][Y][Z].Storable Or Not Category[X][Y][Z].Sellable) And Category[X][Y][Z].OverRide Then
                Inc(lNbItems);

    For X := 0 To Count - 1 Do
      If Category[X].Enabled Then
      Begin
        lCmtBuildingAdd   := False;
        lCmtDecorationAdd := False;
        lCmtCharacterAdd  := False;
        lCmtConsumableAdd := False;

        lStrComment       := '<!-- ';
        If Category[X].Name = '' Then
          lStrComment := lStrComment + ' Default'
        Else
          lStrComment := lStrComment + ' ' + Category[X].Name;
        lStrComment := lStrComment + ' -->';

        If CategoryHaveNonSellableItem(Category[X]) Then
        Begin
          For Y := 0 To Category[X].Count - 1 Do
            If Category[X][Y].Enabled Then
              For Z := 0 To Category[X][Y].Count - 1 Do
                If (Not Category[X][Y][Z].Storable Or Not Category[X][Y][Z].Sellable) And Category[X][Y][Z].OverRide Then
                Begin
                  If Assigned(AProgress) Then
                  Begin
                    Inc(lCurItem);

                    AProgress.CurArchiveName  := Category[X].Name + ' - ' + Category[X][Y][Z].Name;
                    AProgress.ArchiveProgress := Round(lCurItem / lNbItems * 100);
                    Application.ProcessMessages();
                  End;

                  lCurLst := Nil;

                  If SameText(Category[X][Y].PackageType, 'Building') Then
                  Begin
                    If Pos('_DECORATION', UpperCase(Category[X][Y].XmlFile)) > 0 Then
                    Begin
                      lCurLst := lLstDecoration;
                      If Not lCmtDecorationAdd Then
                      Begin
                        lCmtDecorationAdd := True;
                        lCurLst.Add(lStrComment);
                      End;
                    End
                    Else
                    Begin
                      lCurLst := lLstBuilding;
                      If Not lCmtBuildingAdd Then
                      Begin
                        lCmtBuildingAdd := True;
                        lCurLst.Add(lStrComment);
                      End;
                    End;
                  End
                  Else If SameText(Category[X][Y].PackageType, 'Character') Then
                  Begin
                    lCurLst := lLstCharacter;
                    If Not lCmtCharacterAdd Then
                    Begin
                      lCmtCharacterAdd := True;
                      lCurLst.Add(lStrComment);
                    End;
                  End
                  Else If SameText(Category[X][Y].PackageType, 'Consumable') Then
                  Begin
                    lCurLst := lLstConsumable;
                    If Not lCmtConsumableAdd Then
                    Begin
                      lCmtConsumableAdd := True;
                      lCurLst.Add(lStrComment);
                    End;
                  End;

                  If Assigned(lCurLst) Then
                  Begin
                    If lCurLst = lLstConsumable Then
                    Begin
                      lCurLst.Add('<Consumable name="' + Category[X][Y][Z].Name + '">');
                      lCurLst.Add('<Sell allowed="true" storeoverride="true"/>');
                      lCurLst.Add('</Consumable>');
                    End
                    Else
                      lCurLst.Add('<String name="' + Category[X][Y][Z].Name + '"/>');
                  End;
                End;
        End
        Else
        Begin
          lLstBuilding.Add(lStrComment);
          lLstBuilding.Add('<!-- N/A -->');

          lLstDecoration.Add(lStrComment);
          lLstDecoration.Add('<!-- N/A -->');

          lLstCharacter.Add(lStrComment);
          lLstCharacter.Add('<!-- N/A -->');

          lLstConsumable.Add(lStrComment);
          lLstConsumable.Add('<!-- N/A -->');
        End;
      End;

    lLst.Add('<List name="KhnBuildingNSSE">');
    lLst.Add(lLstBuilding.Text);
    lLst.Add('</List>');

    lLst.Add('<List name="KhnDecorationNSSE">');
    lLst.Add(lLstDecoration.Text);
    lLst.Add('</List>');

    lLst.Add('<List name="KhnCharacterNSSE">');
    lLst.Add(lLstCharacter.Text);
    lLst.Add('</List>');

    lLst.Add('<Consumables override="true">');
    lLst.Add(lLstConsumable.Text);
    lLst.Add('</Consumables>');

    Result := lLst.Text;
    If Assigned(AProgress) Then
    Begin
      AProgress.ArchiveProgress := 100;
      Application.ProcessMessages();
    End;

    Finally
      lLst := Nil;
      lLstBuilding   := Nil;
      lLstDecoration := Nil;
      lLstCharacter  := Nil;
      lLstConsumable := Nil;
  End;
End;

Procedure TTSTOHackMasterListIOImpl.BuildNonSellableItems(Const AFileName : String);
Var lLst : IHsStringListEx;
Begin
  lLst := THsStringListEx.CreateList();
  Try
    lLst.Text := FormatXmlData('<NonSellableItemEvent>' + BuildNonSellableItems() + '</NonSellableItemEvent>');
    lLst.SaveToFile(AFileName);

    Finally
      lLst := Nil;
  End;
End;

Function TTSTOHackMasterListIOImpl.BuildReqsItems(AProgress : IRgbProgress = Nil) : String;
  Function CategoryHaveReqItem(ACategory : ITSTOHackMasterCategoryIO) : Boolean;
    Var X, Y : Integer;
  Begin
    Result := False;

    For X := 0 To ACategory.Count - 1 Do
    Begin
      If ACategory[X].Enabled Then
      Begin
        For Y := 0 To ACategory[X].Count - 1 Do
        Begin
          If SameText(ACategory[X].PackageType, 'Character') Then
            ACategory[X][Y].ItemType := tdtCharacter
          Else
            ACategory[X][Y].ItemType := tdtBuilding;

          If ACategory[X][Y].Level > 1 Then
          Begin
            Result := True;
            Break;
          End;
        End;
      End;

      If Result Then
        Break;
    End;
  End;

Var X, Y, Z : Integer;
    lLst           : IHsStringListEx;
    lCurLst        : IHsStringListEx;
    lLstBuilding   : IHsStringListEx;
    lLstDecoration : IHsStringListEx;
    lLstCharacter  : IHsStringListEx;
    lLstConsumable : IHsStringListEx;

    lCmtBuildingAdd   : Boolean;
    lCmtDecorationAdd : Boolean;
    lCmtCharacterAdd  : Boolean;
    lCmtConsumableAdd : Boolean;
    lStrComment       : String;

    lNbItems : Integer;
    lCurItem : Integer;
Begin
  lLst           := THsStringListEx.CreateList();
  lLstBuilding   := THsStringListEx.CreateList();
  lLstDecoration := THsStringListEx.CreateList();
  lLstCharacter  := THsStringListEx.CreateList();
  lLstConsumable := THsStringListEx.CreateList();
  Try
    lNbItems := 0;
    lCurItem := 0;
    If Assigned(AProgress) Then
      For X := 0 To Count - 1 Do
        If Category[X].Enabled And CategoryHaveReqItem(Category[X]) Then
          For Y := 0 To Category[X].Count - 1 Do
            For Z := 0 To Category[X][Y].Count - 1 Do
              If (Category[X][Y][Z].Level > 1) And Category[X][Y][Z].OverRide Then
                Inc(lNbItems);

    For X := 0 To Count - 1 Do
      If Category[X].Enabled Then
      Begin
        lCmtBuildingAdd   := False;
        lCmtDecorationAdd := False;
        lCmtCharacterAdd  := False;
        lCmtConsumableAdd := False;

        lStrComment       := '<!-- ';
        If Category[X].Name = '' Then
          lStrComment := lStrComment + ' Default'
        Else
          lStrComment := lStrComment + ' ' + Category[X].Name;
        lStrComment := lStrComment + ' -->';

        If CategoryHaveReqItem(Category[X]) Then
        Begin
          For Y := 0 To Category[X].Count - 1 Do
            If Category[X][Y].Enabled Then
              For Z := 0 To Category[X][Y].Count - 1 Do
                If (Category[X][Y][Z].Level > 1) And Category[X][Y][Z].OverRide Then
                Begin
                  If Assigned(AProgress) Then
                  Begin
                    Inc(lCurItem);

                    AProgress.CurArchiveName  := Category[X].Name + ' - ' + Category[X][Y][Z].Name;
                    AProgress.ArchiveProgress := Round(lCurItem / lNbItems * 100);
                    Application.ProcessMessages();
                  End;

                  lCurLst := Nil;

                  If SameText(Category[X][Y].PackageType, 'Building') Then
                  Begin
                    If Pos('_DECORATION', UpperCase(Category[X][Y].XmlFile)) > 0 Then
                    Begin
                      lCurLst := lLstDecoration;
                      If Not lCmtDecorationAdd Then
                      Begin
                        lCmtDecorationAdd := True;
                        lCurLst.Add(lStrComment);
                      End;
                    End
                    Else
                    Begin
                      lCurLst := lLstBuilding;
                      If Not lCmtBuildingAdd Then
                      Begin
                        lCmtBuildingAdd := True;
                        lCurLst.Add(lStrComment);
                      End;
                    End;
                  End
                  Else If SameText(Category[X][Y].PackageType, 'Character') Then
                  Begin
                    lCurLst := lLstCharacter;
                    If Not lCmtCharacterAdd Then
                    Begin
                      lCmtCharacterAdd := True;
                      lCurLst.Add(lStrComment);
                    End;
                  End
                  Else If SameText(Category[X][Y].PackageType, 'Consumable') Then
                  Begin
                    lCurLst := lLstConsumable;
                    If Not lCmtConsumableAdd Then
                    Begin
                      lCmtConsumableAdd := True;
                      lCurLst.Add(lStrComment);
                    End;
                  End;

                  If Assigned(lCurLst) Then
                  Begin
                    If lCurLst = lLstConsumable Then
                    Begin
                      lCurLst.Add('<Consumable name="' + Category[X][Y][Z].Name + '">');
                      lCurLst.Add('<Sell allowed="true" storeoverride="true"/>');
                      lCurLst.Add('</Consumable>');
                    End
                    Else
                      lCurLst.Add('<String name="' + Category[X][Y][Z].Name + '"/>');
                  End;
                End;
        End
        Else
        Begin
          lLstBuilding.Add(lStrComment);
          lLstBuilding.Add('<!-- N/A -->');

          lLstDecoration.Add(lStrComment);
          lLstDecoration.Add('<!-- N/A -->');

          lLstCharacter.Add(lStrComment);
          lLstCharacter.Add('<!-- N/A -->');

          lLstConsumable.Add(lStrComment);
          lLstConsumable.Add('<!-- N/A -->');
        End;
      End;

    lLst.Add('<List name="KhnBuildingEU">');
    lLst.Add(lLstBuilding.Text);
    lLst.Add('</List>');

    lLst.Add('<List name="KhnDecorationEU">');
    lLst.Add(lLstDecoration.Text);
    lLst.Add('</List>');

    lLst.Add('<List name="KhnCharacterEU">');
    lLst.Add(lLstCharacter.Text);
    lLst.Add('</List>');

    lLst.Add('<Consumables override="true">');
    lLst.Add(lLstConsumable.Text);
    lLst.Add('</Consumables>');

    Result := lLst.Text;
    If Assigned(AProgress) Then
    Begin
      AProgress.ArchiveProgress := 100;
      Application.ProcessMessages();
    End;

    Finally
      lLst := Nil;
      lLstBuilding   := Nil;
      lLstDecoration := Nil;
      lLstCharacter  := Nil;
      lLstConsumable := Nil;
  End;
End;

Procedure TTSTOHackMasterListIOImpl.BuildReqsItems(Const AFileName : String);
Var lLst : IHsStringListEx;
Begin
  lLst := THsStringListEx.CreateList();
  Try
    lLst.Text := FormatXmlData('<RequirementItemEvent>' + BuildReqsItems() + '</RequirementItemEvent>');
    lLst.SaveToFile(AFileName);

    Finally
      lLst := Nil;
  End;
End;

Function TTSTOHackMasterListIOImpl.BuildDeleteBadItems(AProgress : IRgbProgress = Nil) : String;
  Function CategoryHaveBadItems(ACategory : ITSTOHackMasterCategoryIO) : Boolean;
  Var X, Y : Integer;
  Begin
    Result := False;

    For X := 0 To ACategory.Count - 1 Do
    Begin
      If ACategory[X].Enabled Then
      Begin
        For Y := 0 To ACategory[X].Count - 1 Do
        Begin
          If ACategory[X][Y].IsBadItem Then
          Begin
            Result := True;
            Break;
          End;
        End;
      End;

      If Result Then
        Break;
    End;
  End;

Var X, Y, Z     : Integer;
    lLst        : IHsStringListEx;
    lStrComment : String;
    lNbItems : Integer;
    lCurItem : Integer;
Begin
  lLst := THsStringListEx.CreateList();
  Try
    lNbItems := 0;
    lCurItem := 0;
    If Assigned(AProgress) Then
      For X := 0 To Count - 1 Do
        If Category[X].Enabled And CategoryHaveBadItems(Category[X]) Then
          For Y := 0 To Category[X].Count - 1 Do
            For Z := 0 To Category[X][Y].Count - 1 Do
              If Category[X][Y][Z].IsBadItem Then
                Inc(lNbItems);

    lLst.Add('<KhnDeleteBadItems parallel="true">');

    For X := 0 To Count - 1 Do
      If Category[X].Enabled Then
      Begin
        lStrComment := '<!-- ';
        If Category[X].Name = '' Then
          lStrComment := lStrComment + ' Default'
        Else
          lStrComment := lStrComment + ' ' + Category[X].Name;
        lStrComment := lStrComment + ' -->';

        If CategoryHaveBadItems(Category[X]) Then
        Begin
          lLst.Add(lStrComment);

          For Y := 0 To Category[X].Count - 1 Do
            For Z := 0 To Category[X][Y].Count - 1 Do
              If Category[X][Y][Z].IsBadItem Then
              Begin
                If Assigned(AProgress) Then
                Begin
                  Inc(lCurItem);

                  AProgress.CurArchiveName  := Category[X].Name + ' - ' + Category[X][Y][Z].Name;
                  AProgress.ArchiveProgress := Round(lCurItem / lNbItems * 100);
                  Application.ProcessMessages();
                End;

                lLst.Add( '<Action type="runScriptOnAll" ' +
                          'building="' + Category[X][Y][Z].Name + '" ' +
                          'script="KhnDeleteBuilding" ' +
                          'package="Kahn_Scripts"/>' );
              End;
        End;
      End;

    lLst.Add('</KhnDeleteBadItems>');

    Result := FormatXmlData(lLst.Text);
    If Assigned(AProgress) Then
    Begin
      AProgress.ArchiveProgress := 100;
      Application.ProcessMessages();
    End;

    Finally
      lLst := Nil;
  End;
End;

Procedure TTSTOHackMasterListIOImpl.BuildDeleteBadItems(Const AFileName : String);
Var lLst : IHsStringListEx;
Begin
  lLst := THsStringListEx.CreateList();
  Try
    lLst.Add(BuildDeleteBadItems());
    lLst.SaveToFile(AFileName);

    Finally
      lLst := Nil;
  End;
End;

Function TTSTOHackMasterListIOImpl.BuildStoreRequirements(AProgress : IRgbProgress = Nil) : String;
Var X : Integer;
    lLst : IHsStringListEx;
    lNbItems : Integer;
    lCurItem : Integer;
Begin
  lLst := THsStringListEx.CreateList();
  Try
    lNbItems := 0;
    lCurItem := 0;

    If Assigned(AProgress) Then
      For X := 0 To Count - 1 Do
        If Category[X].BuildStore Then
          Inc(lNbItems);

    For X := 0 To Count - 1 Do
      If Category[X].BuildStore Then
      Begin
        If Assigned(AProgress) Then
        Begin
          Inc(lCurItem);

          AProgress.CurArchiveName  := Category[X].Name;
          AProgress.ArchiveProgress := Round(lCurItem / lNbItems * 100);
          Application.ProcessMessages();
        End;

        lLst.Add(ListStoreRequirements(Category[X].Name));
      End;

    Result := lLst.Text;
    If Assigned(AProgress) Then
    Begin
      AProgress.ArchiveProgress := 100;
      Application.ProcessMessages();
    End;

    Finally
      lLst := Nil;
  End;
End;

Procedure TTSTOHackMasterListIOImpl.BuildStoreRequirements(Const AFileName : String);
Var lLst : IHsStringListEx;
Begin
  lLst := THsStringListEx.CreateList();
  Try
    lLst.Add('<Requirements>');
    lLst.Add(BuildStoreRequirements());
    lLst.Add('</Requirements>');

    lLst.Text := FormatXmlData(lLst.Text);
    lLst.SaveToFile(AFileName);

    Finally
      lLst := Nil;
  End;
End;

Procedure TTSTOHackMasterListIOImpl.AddToMasterList(ACategory : ITSTOHackMasterCategoryIO; APackage : ITSTOHackMasterPackageIO; AItem : ITSTOHackMasterDataIDIO);
  Var lIdx    : Integer;
      lCurPkg : ITSTOHackMasterPackageIO;
Begin
  lIdx := ACategory.IndexOf(APackage.PackageType, APackage.XmlFile);
  If lIdx = -1 Then
  Begin
    lCurPkg := ACategory.Add();

    lCurPkg.PackageType := APackage.PackageType;
    lCurPkg.XmlFile     := APackage.XmlFile;
    lCurPkg.Enabled     := True;
  End
  Else
    lCurPkg := ACategory[lIdx];

  If lCurPkg.IndexOf(AItem.Id) = -1 Then
  Begin
    With lCurPkg.Add() Do
    Begin
      Id           := AItem.Id;
      Name         := AItem.Name;
      AddInStore   := AItem.AddInStore;
      OverRide     := AItem.OverRide;
      IsBadItem    := AItem.IsBadItem;
      ObjectType   := AItem.ObjectType;
      NPCCharacter := AItem.NPCCharacter;
      SkinObject   := AItem.SkinObject;
    End;
  End;
End;

Function TTSTOHackMasterListIOImpl.ListObjectType(ACategory : ITSTOHackMasterCategoryIO) : String;
Var X, Y, Z : Integer;
Begin
  For X := 0 To Count - 1 Do
    For Y := 0 To Category[X].Count - 1 Do
      For Z := 0 To Category[X][Y].Count - 1 Do
        If SameText(Category[X][Y][Z].ObjectType, ACategory.Name) Then
          AddToMasterList(ACategory, Category[X][Y], Category[X][Y][Z]);
End;

Function TTSTOHackMasterListIOImpl.BuildCharacterSkins() : String;
Var lHML    : ITSTOHackMasterListIO;
    lCurCat : ITSTOHackMasterCategoryIO;
Begin
  lHML := TTSTOHackMasterListIO.CreateHackMasterList();
  Try
    lCurCat := lHML.Add();
    With lCurCat Do
    Begin
      Name       := 'CharacterSkin';
      BuildStore := True;
      Enabled    := True;
    End;

    ListObjectType(lCurCat);

    Result := lHML.AsXml;

    Finally
      lHML := Nil;
  End;
End;

Function TTSTOHackMasterListIOImpl.BuildBuildingSkins() : String;
Var lHML    : ITSTOHackMasterListIO;
    lCurCat : ITSTOHackMasterCategoryIO;
Begin
  lHML := TTSTOHackMasterListIO.CreateHackMasterList();
  Try
    lCurCat := lHML.Add();
    With lCurCat Do
    Begin
      Name       := 'BuildingSkin';
      BuildStore := True;
      Enabled    := True;
    End;

    ListObjectType(lCurCat);

    Result := lHML.AsXml;

    Finally
      lHML := Nil;
  End;
End;

Function  TTSTOHackMasterListIOImpl.BuildNPCCharacters() : String;
Var X, Y, Z : Integer;
    lHML    : ITSTOHackMasterListIO;
    lCurCat : ITSTOHackMasterCategoryIO;
Begin
  lHML := TTSTOHackMasterListIO.CreateHackMasterList();
  Try
    lCurCat := lHML.Add();
    With lCurCat Do
    Begin
      Name       := 'NPCCharacter';
      BuildStore := True;
      Enabled    := True;
    End;

    For X := 0 To Count - 1 Do
      For Y := 0 To Category[X].Count - 1 Do
        For Z := 0 To Category[X][Y].Count - 1 Do
          If Category[X][Y][Z].NPCCharacter Then
            AddToMasterList(lCurCat, Category[X][Y], Category[X][Y][Z]);

    Result := lHML.AsXml;

    Finally
      lHML := Nil;
  End;
End;

end.
