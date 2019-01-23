Unit TSTODlcIndex;

Interface

Uses HsXmlDocEx, TSTOXmlBaseType;

Type
  ITSTOXmlLocalDir = Interface(IXmlNodeEx)
    ['{7B8D236D-A81E-477E-81E8-D3524588282C}']
    Function GetName: Widestring;
    Procedure SetName(Value: Widestring);

    Property Name: Widestring Read GetName Write SetName;

  End;

  ITSTOXmlFileName = Interface(IXmlNodeEx)
    ['{30F83FAF-336D-4E56-B5F9-A34FF8FC68D1}']
    Function GetVal() : WideString;
    Procedure SetVal(Value : WideString);

    Function  GetPath() : Widestring;
    Function  GetFileName() : Widestring;

    Property Val : WideString Read GetVal Write SetVal;
    Property Path     : Widestring Read GetPath;
    Property FileName : Widestring Read GetFileName;

  End;

  ITSTOXmlPackage = Interface(IXmlNodeEx)
    ['{BE1E7B9E-A595-450B-BC08-A112D4FB5DD6}']
    Function GetPlatform() : Widestring;
    Function GetUnzip() : Widestring;
    Function GetMinVersion() : Widestring;
    Function GetTier() : Widestring;
    Function GetXml() : Widestring;
    Function GetType_() : Widestring;
    Function GetIgnore() : Widestring;
    Function GetLocalDir() : ITSTOXmlLocalDir;
    Function GetFileSize() : ITSTOXmlIntegerVal;
    Function GetIndexFileCRC() : ITSTOXmlIntegerVal;
    Function GetIndexFileSig() : ITSTOXmlWideStringVal;
    Function GetVersion() : ITSTOXmlIntegerVal;
    Function GetFileName() : ITSTOXmlFileName;
    Function GetLanguage() : ITSTOXmlWideStringVal;
    Procedure SetPlatform(Value : Widestring);
    Procedure SetUnzip(Value : Widestring);
    Procedure SetMinVersion(Value : Widestring);
    Procedure SetTier(Value : Widestring);
    Procedure SetXml(Value : Widestring);
    Procedure SetType_(Value : Widestring);
    Procedure SetIgnore(Value : Widestring);

    Property PkgPlatform  : Widestring            Read GetPlatform   Write SetPlatform;
    Property Unzip        : Widestring            Read GetUnzip      Write SetUnzip;
    Property MinVersion   : Widestring            Read GetMinVersion Write SetMinVersion;
    Property Tier         : Widestring            Read GetTier       Write SetTier;
    Property Xml          : Widestring            Read GetXml        Write SetXml;
    Property PkgType      : Widestring            Read GetType_      Write SetType_;
    Property Ignore       : Widestring            Read GetIgnore     Write SetIgnore;
    Property LocalDir     : ITSTOXmlLocalDir      Read GetLocalDir;
    Property FileSize     : ITSTOXmlIntegerVal    Read GetFileSize;
    Property IndexFileCRC : ITSTOXmlIntegerVal    Read GetIndexFileCRC;
    Property IndexFileSig : ITSTOXmlWideStringVal Read GetIndexFileSig;
    Property Version      : ITSTOXmlIntegerVal    Read GetVersion;
    Property FileName     : ITSTOXmlFileName      Read GetFileName;
    Property Language     : ITSTOXmlWideStringVal Read GetLanguage;

  End;

  ITSTOXmlPackageList = Interface(IXmlNodeCollectionEx)
    ['{B0EA3356-E061-46BF-907E-03DE5D670612}']
    Function Add: ITSTOXmlPackage;
    Function Insert(Const Index: Integer): ITSTOXmlPackage;
    Function GetItem(Index: Integer): ITSTOXmlPackage;
    Property Items[Index: Integer]: ITSTOXmlPackage Read GetItem; Default;

  End;

  ITSTOXmlInitialPackages = Interface(IXmlNodeCollectionEx)
    ['{E0183305-EE7A-4FD6-9606-7735838C67A7}']
    Function GetPackage(Index: Integer): ITSTOXmlPackage;

    Function Add: ITSTOXmlPackage;
    Function Insert(Const Index: Integer): ITSTOXmlPackage;
    Property Package[Index: Integer]: ITSTOXmlPackage Read GetPackage; Default;

  End;

  ITSTOXmlTutorialPackages = Interface(IXmlNodeCollectionEx)
    ['{C9016021-E5EC-4B31-8EBF-C6D634040CBF}']
    Function GetPackage(Index: Integer): ITSTOXmlPackage;

    Function Add: ITSTOXmlPackage;
    Function Insert(Const Index: Integer): ITSTOXmlPackage;
    Property Package[Index: Integer]: ITSTOXmlPackage Read GetPackage; Default;

  End;

  ITSTOXmlDlcIndex = Interface(IXmlNodeEx)
    ['{D31726F6-340F-425E-8EBB-ECC986E09A1A}']
    Function GetPackage: ITSTOXmlPackageList;
    Function GetInitialPackages: ITSTOXmlInitialPackages;
    Function GetTutorialPackages: ITSTOXmlTutorialPackages;

    Property Package          : ITSTOXmlPackageList      Read GetPackage;
    Property InitialPackages  : ITSTOXmlInitialPackages  Read GetInitialPackages;
    Property TutorialPackages : ITSTOXmlTutorialPackages Read GetTutorialPackages;

  End;

{ Global Functions }

Function GetDlcIndex(Doc: IXmlDocumentEx): ITSTOXmlDlcIndex;
Function LoadDlcIndex(Const FileName: Widestring): ITSTOXmlDlcIndex;
Function NewDlcIndex: ITSTOXmlDlcIndex;

Const
  TargetNamespace = '';

Implementation

Type
{ TXMLDlcIndexType }

  TXMLDlcIndexType = Class(TXMLNodeEx, ITSTOXmlDlcIndex)
  Private
    FPackage: ITSTOXmlPackageList;
  Protected
    { ITSTOXmlDlcIndexType }
    Function GetPackage: ITSTOXmlPackageList;
    Function GetInitialPackages: ITSTOXmlInitialPackages;
    Function GetTutorialPackages: ITSTOXmlTutorialPackages;
  Public
    Procedure AfterConstruction; Override;
  End;

  TXMLPackageType = Class(TXMLNodeEx, ITSTOXmlPackage)
  Protected
    Function GetPlatform() : Widestring;
    Function GetUnzip() : Widestring;
    Function GetMinVersion() : Widestring;
    Function GetTier() : Widestring;
    Function GetXml() : Widestring;
    Function GetType_() : Widestring;
    Function GetIgnore() : Widestring;
    Function GetLocalDir() : ITSTOXmlLocalDir;
    Function GetFileSize() : ITSTOXmlIntegerVal;
    Function GetIndexFileCRC() : ITSTOXmlIntegerVal;
    Function GetIndexFileSig() : ITSTOXmlWideStringVal;
    Function GetVersion() : ITSTOXmlIntegerVal;
    Function GetFileName() : ITSTOXmlFileName;
    Function GetLanguage() : ITSTOXmlWideStringVal;
    Procedure SetPlatform(Value : Widestring);
    Procedure SetUnzip(Value : Widestring);
    Procedure SetMinVersion(Value : Widestring);
    Procedure SetTier(Value : Widestring);
    Procedure SetXml(Value : Widestring);
    Procedure SetType_(Value : Widestring);
    Procedure SetIgnore(Value : Widestring);

  Public
    Procedure AfterConstruction(); Override;

  End;

  TXMLPackageTypeList = Class(TXMLNodeCollectionEx, ITSTOXmlPackageList)
  Protected
    Function Add: ITSTOXmlPackage;
    Function Insert(Const Index: Integer): ITSTOXmlPackage;
    Function GetItem(Index: Integer): ITSTOXmlPackage;

  End;

  TXMLLocalDirType = Class(TXMLNodeEx, ITSTOXmlLocalDir)
  Protected
    Function GetName: Widestring;
    Procedure SetName(Value: Widestring);

  End;

  TXMLFileNameType = Class(TXMLNodeEx, ITSTOXmlFileName)
  Protected
    Function  GetVal() : WideString;
    Procedure SetVal(Value : WideString);
    Function  GetPath() : Widestring;
    Function  GetFileName() : Widestring;

  End;

  TXMLInitialPackagesType = Class(TXMLNodeCollectionEx, ITSTOXmlInitialPackages)
  Protected
    Function GetPackage(Index: Integer): ITSTOXmlPackage;
    Function Add: ITSTOXmlPackage;
    Function Insert(Const Index: Integer): ITSTOXmlPackage;

  Public
    Procedure AfterConstruction; Override;

  End;

  TXMLTutorialPackagesType = Class(TXMLNodeCollectionEx, ITSTOXmlTutorialPackages)
  Protected
    Function GetPackage(Index: Integer): ITSTOXmlPackage;
    Function Add: ITSTOXmlPackage;
    Function Insert(Const Index: Integer): ITSTOXmlPackage;

  Public
    Procedure AfterConstruction; Override;

  End;

(******************************************************************************)

{ Global Functions }

Function GetDlcIndex(Doc: IXmlDocumentEx): ITSTOXmlDlcIndex;
Begin
  Result := Doc.GetDocBinding('DlcIndex', TXMLDlcIndexType, TargetNamespace) As ITSTOXmlDlcIndex;
End;

Function LoadDlcIndex(Const FileName: Widestring): ITSTOXmlDlcIndex;
Begin
  Result := LoadXMLDocument(FileName).GetDocBinding('DlcIndex', TXMLDlcIndexType, TargetNamespace) As ITSTOXmlDlcIndex;
End;

Function NewDlcIndex: ITSTOXmlDlcIndex;
Begin
  Result := NewXMLDocument.GetDocBinding('DlcIndex', TXMLDlcIndexType, TargetNamespace) As ITSTOXmlDlcIndex;
End;

{ TXMLDlcIndexType }

Procedure TXMLDlcIndexType.AfterConstruction;
Begin
  RegisterChildNode('Package', TXMLPackageType);
  RegisterChildNode('InitialPackages', TXMLInitialPackagesType);
  RegisterChildNode('TutorialPackages', TXMLTutorialPackagesType);
  FPackage := CreateCollection(TXMLPackageTypeList, ITSTOXmlPackage, 'Package') As ITSTOXmlPackageList;
  Inherited;
End;

Function TXMLDlcIndexType.GetPackage: ITSTOXmlPackageList;
Begin
  Result := FPackage;
End;

Function TXMLDlcIndexType.GetInitialPackages: ITSTOXmlInitialPackages;
Begin
  Result := ChildNodes['InitialPackages'] As ITSTOXmlInitialPackages;
End;

Function TXMLDlcIndexType.GetTutorialPackages: ITSTOXmlTutorialPackages;
Begin
  Result := ChildNodes['TutorialPackages'] As ITSTOXmlTutorialPackages;
End;

{ TXMLPackageType }

Procedure TXMLPackageType.AfterConstruction;
Begin
  RegisterChildNode('LocalDir', TXMLLocalDirType);
  RegisterChildNode('FileSize', TTSTOXmlIntegerVal);
  RegisterChildNode('IndexFileCRC', TTSTOXmlIntegerVal);
  RegisterChildNode('IndexFileSig', TTSTOXmlWideStringVal);
  RegisterChildNode('Version', TTSTOXmlIntegerVal);
  RegisterChildNode('FileName', TXMLFileNameType);
  RegisterChildNode('Language', TTSTOXmlWideStringVal);
  Inherited;
End;

Function TXMLPackageType.GetPlatform: Widestring;
Begin
  Result := AttributeNodes['platform'].Text;
End;

Procedure TXMLPackageType.SetPlatform(Value: Widestring);
Begin
  SetAttribute('platform', Value);
End;

Function TXMLPackageType.GetUnzip: Widestring;
Begin
  Result := AttributeNodes['unzip'].Text;
End;

Procedure TXMLPackageType.SetUnzip(Value: Widestring);
Begin
  SetAttribute('unzip', Value);
End;

Function TXMLPackageType.GetMinVersion: Widestring;
Begin
  Result := AttributeNodes['minVersion'].Text;
End;

Procedure TXMLPackageType.SetMinVersion(Value: Widestring);
Begin
  SetAttribute('minVersion', Value);
End;

Function TXMLPackageType.GetTier: Widestring;
Begin
  Result := AttributeNodes['tier'].Text;
End;

Procedure TXMLPackageType.SetTier(Value: Widestring);
Begin
  SetAttribute('tier', Value);
End;

Function TXMLPackageType.GetXml: Widestring;
Begin
  Result := AttributeNodes['xml'].Text;
End;

Procedure TXMLPackageType.SetXml(Value: Widestring);
Begin
  SetAttribute('xml', Value);
End;

Function TXMLPackageType.GetType_: Widestring;
Begin
  Result := AttributeNodes['type'].Text;
End;

Procedure TXMLPackageType.SetType_(Value: Widestring);
Begin
  SetAttribute('type', Value);
End;

Function TXMLPackageType.GetIgnore: Widestring;
Begin
  Result := AttributeNodes['ignore'].Text;
End;

Procedure TXMLPackageType.SetIgnore(Value: Widestring);
Begin
  SetAttribute('ignore', Value);
End;

Function TXMLPackageType.GetLocalDir: ITSTOXmlLocalDir;
Begin
  Result := ChildNodes['LocalDir'] As ITSTOXmlLocalDir;
End;

Function TXMLPackageType.GetFileSize: ITSTOXmlIntegerVal;
Begin
  Result := ChildNodes['FileSize'] As ITSTOXmlIntegerVal;
End;

Function TXMLPackageType.GetIndexFileCRC: ITSTOXmlIntegerVal;
Begin
  Result := ChildNodes['IndexFileCRC'] As ITSTOXmlIntegerVal;
End;

Function TXMLPackageType.GetIndexFileSig: ITSTOXmlWideStringVal;
Begin
  Result := ChildNodes['IndexFileSig'] As ITSTOXmlWideStringVal;
End;

Function TXMLPackageType.GetVersion: ITSTOXmlIntegerVal;
Begin
  Result := ChildNodes['Version'] As ITSTOXmlIntegerVal;
End;

Function TXMLPackageType.GetFileName: ITSTOXmlFileName;
Begin
  Result := ChildNodes['FileName'] As ITSTOXmlFileName;
End;

Function TXMLPackageType.GetLanguage: ITSTOXmlWideStringVal;
Begin
  Result := ChildNodes['Language'] As ITSTOXmlWideStringVal;
End;

{ TXMLPackageTypeList }

Function TXMLPackageTypeList.Add: ITSTOXmlPackage;
Begin
  Result := AddItem(-1) As ITSTOXmlPackage;
End;

Function TXMLPackageTypeList.Insert(Const Index: Integer): ITSTOXmlPackage;
Begin
  Result := AddItem(Index) As ITSTOXmlPackage;
End;

Function TXMLPackageTypeList.GetItem(Index: Integer): ITSTOXmlPackage;
Begin
  Result := List[Index] As ITSTOXmlPackage;
End;

{ TXMLLocalDirType }

Function TXMLLocalDirType.GetName: Widestring;
Begin
  Result := AttributeNodes['name'].Text;
End;

Procedure TXMLLocalDirType.SetName(Value: Widestring);
Begin
  SetAttribute('name', Value);
End;

Function TXMLFileNameType.GetVal() : WideString;
Begin
  Result := AttributeNodes['val'].Text;
End;

Procedure TXMLFileNameType.SetVal(Value : WideString);
Begin
  SetAttribute('val', Value);
End;

Function TXMLFileNameType.GetPath() : Widestring;
Var lPos : Integer;
Begin
  lPos := Pos(':', AttributeNodes['val'].Text);
  If lPos > 0 Then
    Result := Copy(AttributeNodes['val'].Text, 1, lPos - 1)
  Else
    Result := ''
End;

Function TXMLFileNameType.GetFileName() : Widestring;
Var lPos : Integer;
Begin
  lPos := Pos(':', AttributeNodes['val'].Text);
  If lPos > 0 Then
    Result := Copy(AttributeNodes['val'].Text, lPos + 1, Length(AttributeNodes['val'].Text))
  Else
    Result := ''
End;

{ TXMLInitialPackagesType }

Procedure TXMLInitialPackagesType.AfterConstruction;
Begin
  RegisterChildNode('Package', TXMLPackageType);
  ItemTag := 'Package';
  ItemInterface := ITSTOXmlPackage;
  Inherited;
End;

Function TXMLInitialPackagesType.GetPackage(Index: Integer): ITSTOXmlPackage;
Begin
  Result := List[Index] As ITSTOXmlPackage;
End;

Function TXMLInitialPackagesType.Add: ITSTOXmlPackage;
Begin
  Result := AddItem(-1) As ITSTOXmlPackage;
End;

Function TXMLInitialPackagesType.Insert(Const Index: Integer): ITSTOXmlPackage;
Begin
  Result := AddItem(Index) As ITSTOXmlPackage;
End;

{ TXMLTutorialPackagesType }

Procedure TXMLTutorialPackagesType.AfterConstruction;
Begin
  RegisterChildNode('Package', TXMLPackageType);
  ItemTag := 'Package';
  ItemInterface := ITSTOXmlPackage;
  Inherited;
End;

Function TXMLTutorialPackagesType.GetPackage(Index: Integer): ITSTOXmlPackage;
Begin
  Result := List[Index] As ITSTOXmlPackage;
End;

Function TXMLTutorialPackagesType.Add: ITSTOXmlPackage;
Begin
  Result := AddItem(-1) As ITSTOXmlPackage;
End;

Function TXMLTutorialPackagesType.Insert(Const Index: Integer): ITSTOXmlPackage;
Begin
  Result := AddItem(Index) As ITSTOXmlPackage;
End;

End.