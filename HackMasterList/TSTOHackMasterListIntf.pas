unit TSTOHackMasterListIntf;

Interface

Uses Classes, SysUtils, RTLConsts, HsInterfaceEx, HsStringListEx;

Type
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

    Function GetMiscData() : IHsStringListEx;

    Procedure Assign(ASource : IInterface);

    Property Id         : Integer         Read GetId         Write SetId;
    Property Name       : String          Read GetName       Write SetName;
    Property AddInStore : Boolean         Read GetAddInStore Write SetAddInStore;
    Property OverRide   : Boolean         Read GetOverRide   Write SetOverRide;
    Property IsBadItem  : Boolean         Read GetIsBadItem  Write SetIsBadItem;
    Property MiscData   : IHsStringListEx Read GetMiscData;

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

    Function Add() : ITSTOHackMasterCategory; OverLoad;
    Function Add(Const AItem : ITSTOHackMasterCategory) : Integer; OverLoad;

    Procedure Assign(ASource : IInterface);
    Procedure Sort();

    Property Category[Index : Integer] : ITSTOHackMasterCategory Read Get; Default;

  End;

(******************************************************************************)

Implementation

(*
Procedure GetFileToModList(APrj : ITSTOXMLProject; AZip : IHsMemoryZipper);
Var lNodes : IXmlNodeListEx;
    X, Y   : Integer;
    lStr   : String;
    lLst   : TStringList;
    lPath  : String;
    lXml   : IXmlDocumentEx;
    lMem   : IMemoryStreamEx;
Begin
  lPath := IncludeTrailingBackslash(ExtractFilePath(AZip.FileName)) + '0\';
  If Not DirectoryExists(lPath) Then
    ForceDirectories(lPath);

  lStr := '';
  With TStringList.Create() Do
  Try
    Duplicates := dupIgnore;
    Sorted := True;

    For X := 0 To APrj.Settings.MasterFiles.Count - 1 Do
    Begin
      lMem := TMemoryStreamEx.Create();
      Try
        If AZip.FindFile(APrj.Settings.MasterFiles[X].FileName) > -1 Then
        Begin
          AZip.ExtractToStream(APrj.Settings.MasterFiles[X].FileName, lMem);
          lMem.SaveToFile(lPath + LowerCase(APrj.Settings.MasterFiles[X].FileName));

          lXml := LoadXMLDocument(lPath + APrj.Settings.MasterFiles[X].FileName);
          Try
            lNodes := lXml.SelectNodes('//Include/@path');
            If Assigned(lNodes) Then
            Try
              For Y := 0 To lNodes.Count - 1 Do
                Add(Copy(lNodes[Y].Text, 1, Pos(':', lNodes[Y].Text) - 1));

              Finally
                lNodes := Nil;
            End;

            lNodes := lXml.SelectNodes('IDMasterList/Package[not(Include)]/@name');
            If Assigned(lNodes) Then
            Try
              For Y := 0 To lNodes.Count - 1 Do
                Add(lNodes[Y].Text + '.xml');
                
              Finally
                lNodes := Nil;
            End;

            Finally
              lXml := Nil;
          End;
        End;

        Finally
          lMem := Nil;
      End;
    End;

    lNodes := APrj.CustomPatches.OwnerDocument.SelectNodes('Patches/Patch[@Active="true" and not(FileName = following-sibling::Patch/FileName)]/FileName');
    If Assigned(lNodes) Then
    Try
      For X := 0 To lNodes.Count - 1 Do
        Add(lNodes[X].Text);

      Finally
        lNodes := Nil;
    End;

    lStr := '';
    For X := 0 To Count - 1 Do
      lStr := lStr + Strings[X] + ';';
    AZip.ExtractFiles(Copy(lStr, 1 , Length(lStr) - 1), lPath);

    Finally
      Free();
  End;
End;
*)
End.

