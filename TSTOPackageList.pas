unit TSTOPackageList;

Interface

Uses Classes, SysUtils, HsInterfaceEx,
  TSTODlcIndex, TSTOZero.Bin;

Type
  ITSTOPackageNode = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-BC4D-DD271C9712F2}']
    Function  GetPlatform() : Widestring;
    Function  GetMinVersion() : Widestring;
    Function  GetTier() : Widestring;
    Function  GetVersion() : Widestring;
    Function  GetFileName() : Widestring;
    Function  GetLanguage() : Widestring;
    Function  GetZeroFile() : IBinZeroFile;
    Function  GetFileSize() : Integer;
    Function  GetFileExist() : Boolean;
    Procedure SetFileExist(Const AExist : Boolean);

    Property PkgPlatform  : Widestring   Read GetPlatform;
    Property MinVersion   : Widestring   Read GetMinVersion;
    Property Tier         : Widestring   Read GetTier;
    Property Version      : Widestring   Read GetVersion;
    Property FileName     : Widestring   Read GetFileName;
    Property Language     : Widestring   Read GetLanguage;
    Property ZeroFile     : IBinZeroFile Read GetZeroFile;
    Property FileSize     : Integer      Read GetFileSize;
    Property FileExist    : Boolean      Read GetFileExist Write SetFileExist;

  End;

  ITSTOPackageNodes = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-933E-646D8525F8F1}']
    Function  Get(Index : Integer) : ITSTOPackageNode;
    Procedure Put(Index : Integer; Const Item : ITSTOPackageNode);

    Function Add(Const AItem : ITSTOPackageNode) : Integer; OverLoad;
    Procedure Sort();

    Property Items[Index : Integer] : ITSTOPackageNode Read Get Write Put; Default;

  End;

  ITSTOTierPackageNode = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-8E51-2E83B9C72A7B}']
    Function  GetTierName() : String;
    Procedure SetTierName(Const ATierName : String);

    Function  GetOnLoadPackage() : TNotifyEvent;
    Procedure SetOnLoadPackage(Const AOnLoadPackage : TNotifyEvent);

    Function  GetPackages() : ITSTOPackageNodes;

    Property TierName      : String            Read GetTierName      Write SetTierName;
    Property OnLoadPackage : TNotifyEvent      Read GetOnLoadPackage Write SetOnLoadPackage;
    Property Packages      : ITSTOPackageNodes Read GetPackages;

  End;

  ITSTOTierPackageNodes = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-B41A-11EF807627D2}']
    Function  Get(Index : Integer) : ITSTOTierPackageNode;
    Procedure Put(Index : Integer; Const Item : ITSTOTierPackageNode);

    Function Add() : ITSTOTierPackageNode; OverLoad;
    Function Add(Const AItem : ITSTOTierPackageNode) : Integer; OverLoad;
    Function IndexOf(Const ATierName: String) : Integer;

    Property Items[Index : Integer] : ITSTOTierPackageNode Read Get Write Put; Default;

  End;

  ITSTOPlatformPackageNode = Interface;
  TLoadTierPkg = Procedure(APlatform : ITSTOPlatformPackageNode; ATier : ITSTOTierPackageNode) Of Object;

  ITSTOPlatformPackageNode = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-8C64-EF6DDD860AFE}']
    Function  GetPlatformName() : String;
    Procedure SetPlatformName(Const APlatformName : String);

    Function  GetOnLoadTier() : TNotifyEvent;
    Procedure SetOnLoadTier(Const AOnLoadTier : TNotifyEvent);

    Function  GetOnLoadTierPkg() : TLoadTierPkg;
    Procedure SetOnLoadTierPkg(Const AOnLoadTierPkg : TLoadTierPkg);

    Function  GetTiers() : ITSTOTierPackageNodes;

    Property PlatformName  : String                Read GetPlatformName  Write SetPlatformName;
    Property OnLoadTier    : TNotifyEvent          Read GetOnLoadTier    Write SetOnLoadTier;
    Property OnLoadTierPkg : TLoadTierPkg          Read GetOnLoadTierPkg Write SetOnLoadTierPkg;
    Property Tiers         : ITSTOTierPackageNodes Read GetTiers;

  End;

  ITSTOPlatformPackageNodes = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-974A-A19BD02C90C4}']
    Function  Get(Index : Integer) : ITSTOPlatformPackageNode;
    Procedure Put(Index : Integer; Const Item : ITSTOPlatformPackageNode);

    Function Add() : ITSTOPlatformPackageNode; OverLoad;
    Function Add(Const AItem : ITSTOPlatformPackageNode) : Integer; OverLoad;

    Procedure Load(APackages : ITSTOXmlPackageList); OverLoad;
    Procedure Load(AXmlPackages : String); OverLoad;

    Property Items[Index : Integer] : ITSTOPlatformPackageNode Read Get Write Put; Default;

  End;

(******************************************************************************)

  TTSTOPackageNode = Class(TInterfacedObjectEx, ITSTOPackageNode)
  Private
    FPlatform   : Widestring;
    FMinVersion : Widestring;
    FTier       : Widestring;
    FVersion    : Widestring;
    FFileName   : Widestring;
    FLanguage   : Widestring;
    FZeroFile   : IBinZeroFile;
    FFileSize   : Integer;
    FFileExist  : Boolean;

  Protected
    Function  GetPlatform() : Widestring;
    Function  GetMinVersion() : Widestring;
    Function  GetTier() : Widestring;
    Function  GetVersion() : Widestring;
    Function  GetFileName() : Widestring;
    Function  GetLanguage() : Widestring;
    Function  GetZeroFile() : IBinZeroFile;
    Function  GetFileSize() : Integer;
    Function  GetFileExist() : Boolean;
    Procedure SetFileExist(Const AExist : Boolean);

  Public
    Constructor Create(ANode : ITSTOXmlPackage); ReIntroduce;

  End;

  TTSTOPackageNodes = Class(TInterfaceListEx, ITSTOPackageNodes)
  Private
    Function InternalSort(Item1, Item2 : IInterfaceEx) : Integer;

  Protected
    Function  Get(Index : Integer) : ITSTOPackageNode; OverLoad;
    Procedure Put(Index : Integer; Const Item : ITSTOPackageNode); OverLoad;

    Function Add(Const AItem : ITSTOPackageNode) : Integer; OverLoad;
    Procedure Sort();

  End;

  TTSTOTierPackageNode = Class(TInterfacedObjectEx, ITSTOTierPackageNode)
  Private
    FTierName      : String;
    FOnLoadPackage : TNotifyEvent;
    FPackages      : ITSTOPackageNodes;

  Protected
    Function  GetTierName() : String;
    Procedure SetTierName(Const ATierName : String);

    Function  GetOnLoadPackage() : TNotifyEvent;
    Procedure SetOnLoadPackage(Const AOnLoadPackage : TNotifyEvent);

    Function  GetPackages() : ITSTOPackageNodes;

    Procedure Clear();

  Public
    Destructor Destroy(); OverRide;

  End;

  TTierPackageNodes = Class(TInterfaceListEx, ITSTOTierPackageNodes)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;

    Function  Get(Index : Integer) : ITSTOTierPackageNode; OverLoad;
    Procedure Put(Index : Integer; Const Item : ITSTOTierPackageNode); OverLoad;

    Function Add() : ITSTOTierPackageNode; ReIntroduce; OverLoad;
    Function Add(Const AItem : ITSTOTierPackageNode) : Integer; ReIntroduce; OverLoad;
    Function IndexOf(Const ATierName: String) : Integer; ReIntroduce; OverLoad;

    Property Items[Index : Integer] : ITSTOTierPackageNode Read Get Write Put; Default;

  End;

  TTSTOPlatformPackageNode = Class(TInterfacedObjectEx, ITSTOPlatformPackageNode)
  Private
    FPlatformName  : String;
    FOnLoadTier    : TNotifyEvent;
    FOnLoadTierPkg : TLoadTierPkg;
    FTiers         : ITSTOTierPackageNodes;

    Procedure DoOnLoadPackage(Sender : TObject);

  Protected
    Function  GetPlatformName() : String;
    Procedure SetPlatformName(Const APlatformName : String);

    Function  GetOnLoadTier() : TNotifyEvent;
    Procedure SetOnLoadTier(Const AOnLoadTier : TNotifyEvent);

    Function  GetOnLoadTierPkg() : TLoadTierPkg;
    Procedure SetOnLoadTierPkg(Const AOnLoadTierPkg : TLoadTierPkg);

    Function  GetTiers() : ITSTOTierPackageNodes;

    Procedure Clear();

  Public
    Destructor Destroy(); OverRide;

  End;

  TTSTOPlatformPackageNodes = Class(TInterfaceListEx, ITSTOPlatformPackageNodes)
  Private
    FXmlData : String;

    Procedure DoOnLoadTier(Sender : TObject);
    Procedure DoOnLoadTierPkg(APlatform : ITSTOPlatformPackageNode; ATier : ITSTOTierPackageNode);

  Protected
    Function  GetItemClass() : TInterfacedObjectExClass; OverRide;

    Function  Get(Index : Integer) : ITSTOPlatformPackageNode; OverLoad;
    Procedure Put(Index : Integer; Const Item : ITSTOPlatformPackageNode); OverLoad;

    Function Add() : ITSTOPlatformPackageNode; ReIntroduce; OverLoad;
    Function Add(Const AItem : ITSTOPlatformPackageNode) : Integer; ReIntroduce; OverLoad;

    Function  IndexOf(Const APlatformName : String) : Integer; ReIntroduce; OverLoad;
    Procedure Load(APackages : ITSTOXmlPackageList); OverLoad;
    Procedure Load(AXmlPackages : String); OverLoad;

    Property Items[Index : Integer] : ITSTOPlatformPackageNode Read Get Write Put; Default;

  End;

Implementation

Uses XmlDoc, Dialogs,
  HsXmlDocEx;

Constructor TTSTOPackageNode.Create(ANode : ITSTOXmlPackage);
Begin
  InHerited Create(True);

  FPlatform   := ANode.PkgPlatform;
  FMinVersion := ANode.MinVersion;
  FTier       := ANode.Tier;
  FVersion    := IntToStr(ANode.Version.Val);
  FFileName   := ANode.FileName.Path + '\' + ANode.FileName.FileName;
  FLanguage   := ANode.Language.Val;
  FFileSize   := ANode.FileSize.Val;
End;

Function TTSTOPackageNode.GetPlatform() : Widestring;
Begin
  Result := FPlatform;
End;

Function TTSTOPackageNode.GetMinVersion() : Widestring;
Begin
  Result := FMinVersion;
End;

Function TTSTOPackageNode.GetTier() : Widestring;
Begin
  Result := FTier;
End;

Function TTSTOPackageNode.GetVersion() : Widestring;
Begin
  Result := FVersion;
End;

Function TTSTOPackageNode.GetFileName() : Widestring;
Begin
  Result := FFileName;
End;

Function TTSTOPackageNode.GetLanguage() : Widestring;
Begin
  Result := FLanguage;
End;

Function TTSTOPackageNode.GetZeroFile() : IBinZeroFile;
Begin
  If Not Assigned(FZeroFile) Then
    FZeroFile := TBinZeroFile.CreateBinZeroFile();
  Result := FZeroFile;
End;

Function TTSTOPackageNode.GetFileSize() : Integer;
Begin
  Result := FFileSize;
End;

Function TTSTOPackageNode.GetFileExist() : Boolean;
Begin
  Result := FFileExist;
End;

Procedure TTSTOPackageNode.SetFileExist(Const AExist : Boolean);
Begin
  FFileExist := AExist;
End;

Function TTSTOPackageNodes.InternalSort(Item1, Item2 : IInterfaceEx) : Integer;
Var lItem1, lItem2 : ITSTOPackageNode;
Begin
  If Supports(Item1, ITSTOPackageNode, lItem1) And
     Supports(Item2, ITSTOPackageNode, lItem2) Then
    Result := CompareText(ExtractFileName(lItem1.FileName), ExtractFileName(lItem2.FileName))
  Else
    Raise Exception.Create('Invalid interface type');
End;

Procedure TTSTOPackageNodes.Sort();
Begin
  InHerited Sort(InternalSort);
End;

Function TTSTOPackageNodes.Get(Index : Integer) : ITSTOPackageNode;
Begin
  Result := InHerited Items[Index] As ITSTOPackageNode;
End;

Procedure TTSTOPackageNodes.Put(Index : Integer; Const Item : ITSTOPackageNode);
Var lItem : IInterfaceEx;
Begin
  If Supports(Item, IInterfaceEx, lItem) Then
    InHerited Items[Index] := lItem;
End;

Function TTSTOPackageNodes.Add(Const AItem : ITSTOPackageNode) : Integer;
Var lItem : IInterfaceEx;
Begin
  If Supports(AItem, IInterfaceEx, lItem) Then
    Result := InHerited Add(lItem)
  Else
    Result := -1;
End;

Procedure TTSTOTierPackageNode.Clear();
Begin
  FTierName := '';
End;

Destructor TTSTOTierPackageNode.Destroy();
Begin
  FPackages := Nil;

  InHerited Destroy();
End;

Function TTSTOTierPackageNode.GetTierName() : String;
Begin
  Result := FTierName;
End;

Procedure TTSTOTierPackageNode.SetTierName(Const ATierName : String);
Begin
  FTierName := ATierName;
End;

Function TTSTOTierPackageNode.GetOnLoadPackage() : TNotifyEvent;
Begin
  Result := FOnLoadPackage;
End;

Procedure TTSTOTierPackageNode.SetOnLoadPackage(Const AOnLoadPackage : TNotifyEvent);
Begin
  FOnLoadPackage := AOnLoadPackage;
End;

Function TTSTOTierPackageNode.GetPackages() : ITSTOPackageNodes;
Begin
  If Not Assigned(FPackages) Then
  Begin
    FPackages := TTSTOPackageNodes.Create();

    If Assigned(FOnLoadPackage) Then
      FOnLoadPackage(Self);
  End;

  Result := FPackages;
End;

Function TTierPackageNodes.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TTSTOTierPackageNode;
End;

Function TTierPackageNodes.Get(Index : Integer) : ITSTOTierPackageNode;
Begin
  Result := InHerited Items[Index] As ITSTOTierPackageNode;
End;

Procedure TTierPackageNodes.Put(Index : Integer; Const Item : ITSTOTierPackageNode);
Begin
  InHerited Items[Index] := Item;
End;

Function TTierPackageNodes.Add() : ITSTOTierPackageNode;
Begin
  Result := InHerited Add() As ITSTOTierPackageNode;
End;

Function TTierPackageNodes.Add(Const AItem : ITSTOTierPackageNode) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Function TTierPackageNodes.IndexOf(Const ATierName : String) : Integer;
Var X : Integer;
Begin
  Result := -1;
  For X := 0 To Count - 1 Do
    If SameText(Items[X].TierName, ATierName) Then
    Begin
      Result := X;
      Break;
    End;
End;

Destructor TTSTOPlatformPackageNode.Destroy();
Begin
  FTiers := Nil;

  InHerited Destroy();
End;

Procedure TTSTOPlatformPackageNode.DoOnLoadPackage(Sender : TObject);
Var lTier : ITSTOTierPackageNode;
Begin
  If Supports(Sender, ITSTOTierPackageNode, lTier) And Assigned(FOnLoadTierPkg) Then
    FOnLoadTierPkg(Self, lTier);
End;

Procedure TTSTOPlatformPackageNode.Clear();
Begin
  FPlatformName := '';
End;

Function TTSTOPlatformPackageNode.GetPlatformName() : String;
Begin
  Result := FPlatformName;
End;

Procedure TTSTOPlatformPackageNode.SetPlatformName(Const APlatformName : String);
Begin
  FPlatformName := APlatformName;
End;

Function TTSTOPlatformPackageNode.GetOnLoadTier() : TNotifyEvent;
Begin
  Result := FOnLoadTier;
End;

Procedure TTSTOPlatformPackageNode.SetOnLoadTier(Const AOnLoadTier : TNotifyEvent);
Begin
  FOnLoadTier := AOnLoadTier;
End;

Function TTSTOPlatformPackageNode.GetOnLoadTierPkg() : TLoadTierPkg;
Begin
  Result := FOnLoadTierPkg;
End;

Procedure TTSTOPlatformPackageNode.SetOnLoadTierPkg(Const AOnLoadTierPkg : TLoadTierPkg);
Begin
  FOnLoadTierPkg := AOnLoadTierPkg;
End;

Function TTSTOPlatformPackageNode.GetTiers() : ITSTOTierPackageNodes;
Var X : Integer;
Begin
  If Not Assigned(FTiers) Then
  Begin
    FTiers := TTierPackageNodes.Create();

    If Assigned(FOnLoadTier) Then
    Begin
      FOnLoadTier(Self);

      For X := 0 To FTiers.Count - 1 Do
        FTiers[X].OnLoadPackage := DoOnLoadPackage;
    End;
  End;

  Result := FTiers;
End;

Function TTSTOPlatformPackageNodes.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TTSTOPlatformPackageNode;
End;

Function TTSTOPlatformPackageNodes.Get(Index : Integer) : ITSTOPlatformPackageNode;
Begin
  Result := InHerited Items[Index] As ITSTOPlatformPackageNode;
End;

Procedure TTSTOPlatformPackageNodes.Put(Index : Integer; Const Item : ITSTOPlatformPackageNode);
Begin
  InHerited Items[Index] := Item;
End;

Procedure TTSTOPlatformPackageNodes.DoOnLoadTier(Sender : TObject);
Var lPlatform : ITSTOPlatformPackageNode;
    lNodes : IXmlNodeListEx;
    X : Integer;
Begin
  If Supports(Sender, ITSTOPlatformPackageNode, lPlatform) Then
  Try
    With lPlatform Do
    Begin
      lNodes := LoadXmlData(FXmlData).SelectNodes(
                  'Package[@platform="' + PlatformName + '"][' +
                  '  not(@tier = following-sibling::Package[@platform="' + PlatformName + '"]/@tier)' +
                  ']/@tier'
                );

      If Assigned(lNodes) Then
      Try
        For X := 0 To lNodes.Count - 1 Do
          lPlatform.Tiers.Add().TierName := lNodes[X].Text;

        Finally
          lNodes := Nil;
      End;
    End;

    Finally
      lPlatform := Nil;
  End;
End;

Procedure TTSTOPlatformPackageNodes.DoOnLoadTierPkg(APlatform : ITSTOPlatformPackageNode; ATier : ITSTOTierPackageNode);
Var lXmlNodeCls : TXmlNodeClass;
    lNodes      : IXmlNodeListEx;
    lXmlNode    : ITSTOXmlPackage;
    lPkg        : ITSTOPackageNode;
    X : Integer;
Begin
  lXmlNodeCls := Nil;
  With (NewDlcIndex() As IXmlNodeAccess) Do
    For X := Low(ChildNodeClasses) To High(ChildNodeClasses) Do
    Begin
      If SameText(ChildNodeClasses[X].NodeName, 'Package') Then
      Begin
        lXmlNodeCls := ChildNodeClasses[X].NodeClass;
        Break;
      End;
    End;

  If Assigned(lXmlNodeCls) Then
  Begin
    With APlatform, ATier Do
    Begin
      lNodes := LoadXmlData(FXmlData).SelectNodes(
                  'Package[@platform="' + PlatformName +
                  '" and @tier="' + TierName + '"]'
                );

      If Assigned(lNodes) Then
      Try
        For X := 0 To lNodes.Count - 1 Do
        Begin
          lXmlNode := lXmlNodeCls.Create(
            lNodes[X].DOMNode, Nil,
            (lNodes[X].OwnerDocument As IXmlDocumentAccess).DocumentObject
          ) As ITSTOXmlPackage;

          lPkg := TTSTOPackageNode.Create(lXmlNode);
//@@Kahn          lPkg.FileExist := FileExists(FPrj.Settings.DLCPath + lPkg.FileName);
          ATier.Packages.Add(lPkg);
        End;

        Finally
          lNodes := Nil;
      End;
    End;
  End;
End;

Function TTSTOPlatformPackageNodes.Add() : ITSTOPlatformPackageNode;
Begin
  Result := InHerited Add() As ITSTOPlatformPackageNode;
End;

Function TTSTOPlatformPackageNodes.Add(Const AItem : ITSTOPlatformPackageNode) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Function TTSTOPlatformPackageNodes.IndexOf(Const APlatformName : String) : Integer;
Var X : Integer;
Begin
  Result := -1;

  For X := 0 To Count - 1 Do
    If SameText(Items[X].PlatformName, APlatformName) Then
    Begin
      Result := X;
      Break;
    End;
End;

Procedure TTSTOPlatformPackageNodes.Load(APackages : ITSTOXmlPackageList);
Var X    : Integer;
    lNodes : IXmlNodeListEx;
Begin
  Load(APackages.OwnerDocument.Xml.Text);
Exit;
  FXmlData := APackages.OwnerDocument.Xml.Text;

  lNodes := LoadXmlData(FXmlData).SelectNodes(
              'Package[not(@platform = following-sibling::Package/@platform)]/@platform'
            );
  If Assigned(lNodes) Then
  Try
    For X := 0 To lNodes.Count - 1 Do
    Begin
      With Add() Do
      Begin
        PlatformName  := lNodes[X].Text;
        OnLoadTier    := DoOnLoadTier;
        OnLoadTierPkg := DoOnLoadTierPkg;
      End;
    End;

    Finally
      lNodes := Nil;
  End;
End;

Procedure TTSTOPlatformPackageNodes.Load(AXmlPackages : String);
Var lXml : IXmlDocumentEx;
    lNodes : IXmlNodeListEx;
    X : Integer;
Begin
  lXml := LoadXmlData(AXmlPackages);
  Try
    //Remove useless packages
    lNodes := lXml.SelectNodes('(//InitialPackages | //TutorialPackages)');

    If Assigned(lNodes) Then
    Try
      For X := 0 To lNodes.Count - 1 Do
        With lNodes[X] Do
          DOMNode.parentNode.removeChild(DOMNode);

      Finally
        lNodes := Nil;
    End;

    //Remove useless attributes from remaining packages
    lNodes := lXml.SelectNodes('//Package');
    If Assigned(lNodes) Then
      Try
        For X := 0 To lNodes.Count - 1 Do
          With lNodes[X].DOMNode.attributes Do
          Begin
            removeNamedItem('unzip');
            removeNamedItem('xml');
            removeNamedItem('type');
            removeNamedItem('ignore');
          End;

        Finally
          lNodes := Nil;
      End;

    //Remove useless nodes from remaining packages
    lNodes := lXml.SelectNodes(
                '(' +
                '  //LocalDir | ' + //FileSize | ' +
                '  //IndexFileCRC | //IndexFileSig' +
                ')'
              );
    If Assigned(lNodes) Then
    Try
      For X := 0 To lNodes.Count - 1 Do
        With lNodes[X] Do
          DOMNode.parentNode.removeChild(DOMNode);

      Finally
        lNodes := Nil;
    End;

    lNodes := lXml.SelectNodes(
                'Package[not(@platform = following-sibling::Package/@platform)]/@platform'
              );
    If Assigned(lNodes) Then
    Try
      For X := 0 To lNodes.Count - 1 Do
      Begin
        With Add() Do
        Begin
          PlatformName  := lNodes[X].Text;
          OnLoadTier    := DoOnLoadTier;
          OnLoadTierPkg := DoOnLoadTierPkg;
        End;
      End;

      Finally
        lNodes := Nil;
    End;
    FXmlData := lXml.Xml.Text;

    Finally
      lXml := Nil;
  End;
End;

Initialization
  RegisterInterface('ITSTOPackageNode', ITSTOPackageNode);
  RegisterInterface('ITSTOPackageNodes', ITSTOPackageNodes);
  RegisterInterface('ITSTOTierPackageNode', ITSTOTierPackageNode);
  RegisterInterface('ITSTOTierPackageNodes', ITSTOTierPackageNodes);
  RegisterInterface('ITSTOPlatformPackageNode', ITSTOPlatformPackageNode);
  RegisterInterface('ITSTOPlatformPackageNodes', ITSTOPlatformPackageNodes);

End.

