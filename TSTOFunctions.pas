unit TSTOFunctions;

interface

Uses Classes, HsInterfaceEx, TSTOProject.Xml, TSTOHackMasterList.IO;

Type
  ITSTOItemLister = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-BAA6-1CD0E7C8D5D4}']
    Function ListXmlPackageFiles(Const AFileName : String; AResult : TStringList) : Boolean; OverLoad;
    Function ListXmlPackageFiles(AProject : ITSTOXmlProject; AResult : TStringList) : Boolean; OverLoad;

    Procedure ListNonFreeItems(AFileList : TStringList; Const AFileName : String); OverLoad;
    Procedure ListNonFreeItems(AProject : ITSTOXmlProject; Const AFileName : String); OverLoad;
    Procedure ListNonFreeItems(Const AMasterList : String; Const AFileName : String); OverLoad;

    Procedure ListUniqueItems(AFileList : TStringList; Const AFileName : String); OverLoad;
    Procedure ListUniqueItems(AProject : ITSTOXmlProject; Const AFileName : String); OverLoad;
    Procedure ListUniqueItems(Const AMasterList : String; Const AFileName : String); OverLoad;

    Procedure ListRequirementItems(AFileList : TStringList; Const AFileName : String); OverLoad;
    Procedure ListRequirementItems(AProject : ITSTOXmlProject; Const AFileName : String); OverLoad;
    Procedure ListRequirementItems(Const AMasterList : String; Const AFileName : String); OverLoad;

    Procedure ListNonSellableItems(AFileList : TStringList; Const AFileName : String); OverLoad;
    Procedure ListNonSellableItems(AProject : ITSTOXmlProject; Const AFileName : String); OverLoad;
    Procedure ListNonSellableItems(Const AMasterList : String; Const AFileName : String); OverLoad;

    Procedure ListStoreRequirement(Const AMasterList : String; Const AFileName : String);

  End;

  TTSTOItemLister = Class(TObject)
  Public
    Class Function CreateLister() : ITSTOItemLister;

  End;

implementation

Uses Dialogs, SysUtils, XmlIntf, XmlDom,
  HsXmlDocEx, HsStringListEx;

Procedure FixXml(AStartNode : IXmlNodeListEx);
Var X : Integer;
Begin
  For X := AStartNode.Count - 1 DownTo 0 Do
  Begin
    If AStartNode[X].NodeType = ntText Then
      AStartNode.Delete(X)
    Else If AStartNode[X].ChildNodes.Count > 0 Then
      FixXml(AStartNode[X].ChildNodes);
  End;
End;

Type
  INodeName = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-ACB9-E50013F8D344}']
    Function  GetNodeIdentifier() : String;
    Procedure SetNodeIdentifier(Const ANodeIdentifier : String);

    Function  GetNode() : IXmlNodeEx;
    Procedure SetNode(Const ANode : IXmlNodeEx);

    Property NodeIdentifier : String     Read GetNodeIdentifier Write SetNodeIdentifier;
    Property Node           : IXmlNodeEx Read GetNode           Write SetNode;

  End;

  INodeNames = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-989F-2C6F82BC73BA}']
    Function  Get(Index : Integer) : INodeName;
    Procedure Put(Index : Integer; Const Item : INodeName);

    Function Add() : INodeName; OverLoad;
    Function Add(Const AItem : INodeName) : Integer; OverLoad;
    Function IndexOf(Const ANodeName : String) : Integer;
    
    Property Items[Index : Integer] : INodeName Read Get Write Put; Default;

  End;

  TNodeName = Class(TInterfacedObjectEx, INodeName)
  Private
    FNodeIdentifier : String;
    FNode           : Pointer;

  Protected
    Function  GetNodeIdentifier() : String;
    Procedure SetNodeIdentifier(Const ANodeIdentifier : String);

    Function  GetNode() : IXmlNodeEx;
    Procedure SetNode(Const ANode : IXmlNodeEx);

  End;

  TNodeNames = Class(TInterfaceListEx, INodeNames)
  Protected
    Function  GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : INodeName; OverLoad;
    Procedure Put(Index : Integer; Const Item : INodeName); OverLoad;

    Function Add() : INodeName; ReIntroduce; OverLoad;
    Function Add(Const AItem : INodeName) : Integer; ReIntroduce; OverLoad;
    Function IndexOf(Const ANodeName : String) : Integer; ReIntroduce; OverLoad;

  End;

  tOverRideListKind = (orlkNonFree, orlkUnique, orlkRequirements, orlkNonSellable);
  tOverRideParamsRec = Record
    DocElementName : String;
    XPathQuery     : String;
    ParamKind      : tOverRideListKind;
  End;

  TTSTOItemListerImpl = Class(TInterfacedObjectEx, ITSTOItemLister)
  Private
    Function GetOverRideNode(AXml : IXmlDocumentEx; ANodeList : INodeNames; Const AFileName : String) : INodeName;
    Function CreateOverRideList(AFileList : TStringList; Const ADocName, AXPath : String; Const AListKind : tOverRideListKind) : IXmlDocumentEx; OverLoad;
    Function CreateOverRideList(AFileList : TStringList; Const AParams : tOverRideParamsRec) : IXmlDocumentEx; OverLoad;
    Function CreateOverRideList(AFileList : TStringList; Const AKind : tOverRideListKind) : IXmlDocumentEx; OverLoad;
    Function CreateOverRideListEx(Const AMasterList, ADocName, AXPath : String; Const AListKind : tOverRideListKind; Const AAddComment : Boolean = False) : IXmlDocumentEx; OverLoad;
    Procedure SaveOverRideList(AXml : IXmlDocumentEx; Const AFileName : String);

  Protected
    Function ListXmlPackageFiles(Const AFileName : String; AResult : TStringList) : Boolean; OverLoad;
    Function ListXmlPackageFiles(AProject : ITSTOXmlProject; AResult : TStringList) : Boolean; OverLoad;

    Procedure ListNonFreeItems(AFileList : TStringList; Const AFileName : String); OverLoad;
    Procedure ListNonFreeItems(AProject : ITSTOXmlProject; Const AFileName : String); OverLoad;
    Procedure ListNonFreeItems(Const AMasterList : String; Const AFileName : String); OverLoad;
    Procedure ListUniqueItems(AFileList : TStringList; Const AFileName : String); OverLoad;
    Procedure ListUniqueItems(AProject : ITSTOXmlProject; Const AFileName : String); OverLoad;
    Procedure ListUniqueItems(Const AMasterList : String; Const AFileName : String); OverLoad;
    Procedure ListRequirementItems(AFileList : TStringList; Const AFileName : String); OverLoad;
    Procedure ListRequirementItems(AProject : ITSTOXmlProject; Const AFileName : String); OverLoad;
    Procedure ListRequirementItems(Const AMasterList : String; Const AFileName : String); OverLoad;
    Procedure ListNonSellableItems(AFileList : TStringList; Const AFileName : String); OverLoad;
    Procedure ListNonSellableItems(AProject : ITSTOXmlProject; Const AFileName : String); OverLoad;
    Procedure ListNonSellableItems(Const AMasterList : String; Const AFileName : String); OverLoad;
    Procedure ListNonFreeFarmJobs(AProject : ITSTOXmlProject; Const AFileName : String);
    Procedure ListStoreRequirement(Const AMasterList : String; Const AFileName : String);

  End;

Const
  OverRideParams : Array[tOverRideListKind] Of tOverRideParamsRec = (
    (DocElementName : 'CostOverRides'; XPathQuery : '//Cost/..'; ParamKind : orlkNonFree),
    (DocElementName : 'UniqueOverRides'; XPathQuery : '//Unique[@value="true"]/..'; ParamKind : orlkUnique),
    (DocElementName : 'RequirementOverRides'; XPathQuery : '//*[VisibilityRequirements or Requirements or Requirement]'; ParamKind : orlkRequirements),
    (DocElementName : 'NonSellableOverRides'; XPathQuery : '//Sell[@allowed="false" or @storeoverride="false"]/..'; ParamKind : orlkNonSellable)
  );
   
Class Function TTSTOItemLister.CreateLister() : ITSTOItemLister;
Begin
  Result := TTSTOItemListerImpl.Create();
End;
  
(******************************************************************************)

Function TNodeName.GetNodeIdentifier() : String;
Begin
  Result := FNodeIdentifier;
End;

Procedure TNodeName.SetNodeIdentifier(Const ANodeIdentifier : String);
Begin
  FNodeIdentifier := ANodeIdentifier;
End;

Function TNodeName.GetNode() : IXmlNodeEx;
Begin
  Result := IXmlNodeEx(FNode);
End;

Procedure TNodeName.SetNode(Const ANode : IXmlNodeEx);
Begin
  FNode := Pointer(ANode);
End;

Function TNodeNames.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TNodeName;
End;

Function TNodeNames.Get(Index : Integer) : INodeName;
Begin
  Result := InHerited Items[Index] As INodeName;
End;

Procedure TNodeNames.Put(Index : Integer; Const Item : INodeName);
Begin
  InHerited Items[Index] := Item;
End;

Function TNodeNames.Add() : INodeName;
Begin
  Result := InHerited Add() As INodeName;
End;

Function TNodeNames.Add(Const AItem : INodeName) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Function TNodeNames.IndexOf(Const ANodeName : String) : Integer;
Var X : Integer;
Begin
  Result := -1;
  For X := 0 To Count - 1 Do
    If SameText(Get(X).NodeIdentifier, ANodeName) Then
    Begin
      Result := X;
      Break;
    End;
End;

(******************************************************************************)

Function TTSTOItemListerImpl.ListXmlPackageFiles(Const AFileName : String; AResult : TStringList) : Boolean;
Var lXml   : IXmlDocumentEx;
    lNodes : IXmlNodeListEx;
    X      : Integer;
Begin
  AResult.Clear();
  AResult.Sorted := True;
  AResult.Duplicates := dupIgnore;

  lXml := LoadXmlDocument(AFileName);

  lNodes := lXml.SelectNodes('IDMasterList/Package/Include/@path');
  For X := 0 To lNodes.Count - 1 Do
    AResult.Add(Copy(lNodes[X].Text, 1, Pos(':', lNodes[X].Text) - 1));

  lNodes := lXml.SelectNodes('IDMasterList/Package[not(Include)]/@name');
  For X := 0 To lNodes.Count - 1 Do
    AResult.Add(lNodes[X].Text + '.xml');

  Result := AResult.Count > 0;
End;

Function TTSTOItemListerImpl.ListXmlPackageFiles(AProject : ITSTOXmlProject; AResult : TStringList) : Boolean;
Var X, Y   : Integer;
    lXml   : IXmlDocumentEx;
    lNodes : IXmlNodeListEx;
Begin
  AResult.Clear();
  AResult.Sorted := True;
  AResult.Duplicates := dupIgnore;

  With AProject.Settings Do
    For X := 0 To MasterFiles.Count - 1 Do
      If FileExists(SourcePath + MasterFiles[X].FileName) Then
      Begin
        lXml := LoadXmlDocument(SourcePath + MasterFiles[X].FileName);
        Try
          lNodes := lXml.SelectNodes('IDMasterList/Package/Include/@path');
          If Assigned(lNodes) Then
          Try
            For Y := 0 To lNodes.Count - 1 Do
              AResult.Add(Copy(lNodes[Y].Text, 1, Pos(':', lNodes[Y].Text) - 1));

            Finally
              lNodes := Nil;
          End;

          lNodes := lXml.SelectNodes('IDMasterList/Package[not(Include)]/@name');
          If Assigned(lNodes) Then
          Try
            For Y := 0 To lNodes.Count - 1 Do
              AResult.Add(lNodes[Y].Text + '.xml');

            Finally
              lNodes := Nil;
          End;
                    
          Finally
            lXml := Nil;
        End;
      End;

  Result := AResult.Count > 0;
End;

Function TTSTOItemListerImpl.GetOverRideNode(AXml : IXmlDocumentEx; ANodeList : INodeNames; Const AFileName : String) : INodeName;
  Function GetNodeList(Const AListName : String) : INodeName;
  Var lIdx : Integer;
  Begin
    lIdx := ANodeList.IndexOf(AListName);
    If lIdx = -1 Then
    Begin
      Result := ANodeList.Add();
      With Result Do
      Begin
        Node := AXml.DocumentElement.AddChild('List');
        Node.Attributes['name'] := AListName;
        NodeIdentifier := AListName;
      End;
    End
    Else
      Result := ANodeList[lIdx];
  End;

Var lIdx : Integer;
Begin
  Result := Nil;
  
  If Pos('BUILDING', UpperCase(AFileName)) > 0 Then
    Result := GetNodeList('KhnBuilding')
  Else If Pos('DECORATION', UpperCase(AFileName)) > 0 Then
    Result := GetNodeList('KhnDecoration')
  Else If (Pos('CONSUMABLE', UpperCase(AFileName)) > 0) Or
          (Pos('SKIN', UpperCase(AFileName)) > 0) Then
  Begin
    lIdx := ANodeList.IndexOf('KhnConsumable');
    If lIdx = -1 Then
    Begin
      Result := ANodeList.Add();
      With Result Do
      Begin
        Node := AXml.DocumentElement.AddChild('Consumables');
        Node.Attributes['override'] := 'true';
        NodeIdentifier := 'KhnConsumable';
      End;
    End
    Else
      Result := ANodeList[lIdx];
  End
  Else If Pos('CHARACTER', UpperCase(AFileName)) > 0 Then
    Result := GetNodeList('KhnCharacter');
End;

Function TTSTOItemListerImpl.CreateOverRideList(AFileList : TStringList; Const ADocName, AXPath : String; Const AListKind : tOverRideListKind) : IXmlDocumentEx;
Var X, Y      : Integer;
    lNodes    : IXmlNodeListEx;
    lCurNode  : INodeName;
    lNodeList : INodeNames;
Begin
  Result := NewXmlDocument('');
  Result.Options := Result.Options + [doNodeAutoIndent];
  Result.AddChild(ADocName);
  lNodeList := TNodeNames.Create();
  Try
    For X := 0 To AFileList.Count - 1 Do
      If FileExists(AFileList[X]) Then
      Begin
        lCurNode := GetOverRideNode(Result, lNodeList, AFileList[X]);
        If Assigned(lCurNode) Then
        Begin
          lNodes := LoadXmlDocument(AFileList[X]).SelectNodes(AXPath);
          If Assigned(lNodes) Then
          Try
            For Y := 0 To lNodes.Count - 1 Do
              If lNodes[Y].HasAttribute('name') Then
              Begin
                If SameText(lCurNode.NodeIdentifier, 'KhnConsumable') Then
                Begin
                  With lCurNode.Node.AddChild('Consumable') Do
                  Begin
                    Attributes['name'] := lNodes[Y].AttributeNodes['name'].Text;
                    
                    Case AListKind Of
                      orlkNonFree :
                      Begin
                        AddChild('Cost').Attributes['money'] := '0';
                      End;

                      orlkUnique :
                      Begin
                        AddChild('Unique').Attributes['value'] := 'false';
                      End;

                      orlkRequirements :
                      Begin
                        If lNodes[Y].ChildNodes.IndexOf('VisibilityRequirements') > -1 Then
                          With AddChild('VisibilityRequirements').AddChild('Requirement') Do
                          Begin
                            Attributes['type']  := 'level';
                            Attributes['level'] := '1';
                          End;

                        If (lNodes[Y].ChildNodes.IndexOf('Requirements') > -1) Or
                           (lNodes[Y].ChildNodes.IndexOf('Requirement') > -1) Then
                          With AddChild('Requirements').AddChild('Requirement') Do
                          Begin
                            Attributes['type']  := 'level';
                            Attributes['level'] := '1';
                          End;
                      End;

                      orlkNonSellable :
                      Begin
                        With AddChild('Sell') Do
                        Begin
                          Attributes['allowed'] := 'true';
                          Attributes['storeoverride'] := 'true';
                        End;
                      End;
                    End;
                  End;
                End
                Else
                  lCurNode.Node.AddChild('String').Attributes['name'] := lNodes[Y].AttributeNodes['name'].Text;
              End;

            Finally
              lNodes := Nil;
          End;
        End;
      End;

    Finally
      lNodeList := Nil;
  End;
End;

Function TTSTOItemListerImpl.CreateOverRideList(AFileList : TStringList; Const AParams : tOverRideParamsRec) : IXmlDocumentEx;
Begin
  With AParams Do
    Result := CreateOverRideList(AFileList, DocElementName, XPathQuery, ParamKind);
End;

Function TTSTOItemListerImpl.CreateOverRideList(AFileList : TStringList; Const AKind : tOverRideListKind) : IXmlDocumentEx; 
Begin
  With OverRideParams[AKind] Do
    Result := CreateOverRideList(AFileList, DocElementName, XPathQuery, ParamKind);
End;

Procedure TTSTOItemListerImpl.SaveOverRideList(AXml : IXmlDocumentEx; Const AFileName : String);
Var X : Integer;
Begin
  With AXml.DOMDocument.documentElement Do
    For X := childNodes.length - 1 DownTo 0 Do
      If (childNodes[X].nodeType <> COMMENT_NODE) And (childNodes[X].childNodes.length = 0) Then
        childNodes[X].parentNode.removeChild(childNodes[X]);

  With TStringList.Create() Do
  Try
    Text := FormatXmlData(AXml.Xml.Text);
    If AFileName = '' Then
      ShowMessage(Text)
    Else
      SaveToFile(AFileName);

    Finally
      Free();
  End;
End;

Function TTSTOItemListerImpl.CreateOverRideListEx(Const AMasterList, ADocName, AXPath : String; Const AListKind : tOverRideListKind; Const AAddComment : Boolean = False) : IXmlDocumentEx;
Var X, Y, Z : Integer;
    lCategoryNodes : IXmlNodeListEx;
    lPackageNodes  : IXmlNodeListEx;
    lItemNodes     : IXmlNodeListEx;
    lComment       : IXmlNode;

    lCurNode  : INodeName;
    lPrevNode : INodeName;
    lNodeList : INodeNames;
Begin
  Result := NewXmlDocument('');
  Result.Options := Result.Options + [doNodeAutoIndent];
  Result.NodeIndentStr := '  ';
  Result.AddChild(ADocName);
  lNodeList := TNodeNames.Create();
  Try
    lCategoryNodes := LoadXmlDocument(AMasterList).SelectNodes('//Category[@Enabled="true"]');
    If lCategoryNodes.Count > 0 Then
    Try
      For X := 0 To lCategoryNodes.Count - 1 Do
      Begin
        lPrevNode := Nil;
        lPackageNodes := lCategoryNodes[X].OwnerDocument.SelectNodes('Package[@Enabled="true"]', lCategoryNodes[X]);
        If lPackageNodes.Count > 0 Then
        Try
          For Y := 0 To lPackageNodes.Count - 1 Do
          Begin
            lCurNode := GetOverRideNode(Result, lNodeList, lPackageNodes[Y].AttributeNodes['XmlFile'].Text);
            If Assigned(lCurNode) Then
            Begin
              If AAddComment And (lPrevNode <> lCurNode) And (lCategoryNodes[X].AttributeNodes['Name'].Text <> '') Then
              Begin
                lPrevNode := lCurNode;
                lComment := lCurNode.Node.OwnerDocument.CreateNode(' ' + lCategoryNodes[X].AttributeNodes['Name'].Text + ' ', ntComment);
                lCurNode.Node.ChildNodes.Add(lComment);
              End;

              lItemNodes := lPackageNodes[Y].OwnerDocument.SelectNodes(AXPath, lPackageNodes[Y]);

              If lItemNodes.Count > 0 Then
              Try
                For Z := 0 To lItemNodes.Count - 1 Do
                  If SameText(lCurNode.NodeIdentifier, 'KhnConsumable') Then
                  Begin
                    With lCurNode.Node.AddChild('Consumable') Do
                    Begin
                      Attributes['name'] := lItemNodes[Z].AttributeNodes['name'].Text;

                      Case AListKind Of
                        orlkNonFree :
                        Begin
                          AddChild('Cost').Attributes['money'] := '0';
                        End;

                        orlkUnique :
                        Begin
                          AddChild('Unique').Attributes['value'] := 'false';
                        End;

                        orlkRequirements :
                        Begin
                          If lItemNodes[Z].ChildNodes.IndexOf('VisibilityRequirements') > -1 Then
                            With AddChild('VisibilityRequirements').AddChild('Requirement') Do
                            Begin
                              Attributes['type']  := 'level';
                              Attributes['level'] := '1';
                            End;

                          If (lItemNodes[Z].ChildNodes.IndexOf('Requirements') > -1) Or
                             (lItemNodes[Z].ChildNodes.IndexOf('Requirement') > -1) Then
                            With AddChild('Requirements').AddChild('Requirement') Do
                            Begin
                              Attributes['type']  := 'level';
                              Attributes['level'] := '1';
                            End;
                        End;

                        orlkNonSellable :
                        Begin
                          With AddChild('Sell') Do
                          Begin
                            Attributes['allowed'] := 'true';
                            Attributes['storeoverride'] := 'true';
                          End;
                        End;
                      End;
                    End;
                  End
                  Else
                    lCurNode.Node.AddChild('String').Attributes['name'] := lItemNodes[Z].AttributeNodes['name'].Text;

                Finally
                  lItemNodes := Nil;
              End
              Else
              Begin
                If AAddComment And (lCategoryNodes[X].AttributeNodes['Name'].Text <> '') Then
                Begin
                  lComment := lCurNode.Node.OwnerDocument.CreateNode(' N/A ', ntComment);
                  lCurNode.Node.ChildNodes.Add(lComment);
                End;
              End;
            End;
          End;

          Finally
            lPackageNodes := Nil;
        End;
      End;

      Finally
        lCategoryNodes := Nil;
    End;

    Finally
      lNodeList := Nil;
  End;
End;

Procedure TTSTOItemListerImpl.ListNonFreeItems(AFileList : TStringList; Const AFileName : String);
Begin
  SaveOverRideList(CreateOverRideList(AFileList, orlkNonFree), AFileName);
End;

Procedure TTSTOItemListerImpl.ListNonFreeItems(AProject : ITSTOXmlProject; Const AFileName : String);
Var X         : Integer;
    lFileList : TStringList;
Begin
  lFileList := TStringList.Create();
  Try
    If ListXmlPackageFiles(AProject, lFileList) Then
    Begin
      lFileList.Sorted := False;
      For X := 0 To lFileList.Count - 1 Do
        lFileList[X] := AProject.Settings.SourcePath + lFileList[X];

      ListNonFreeItems(lFileList, AFileName);
    End;

    Finally
      lFileList.Free();
  End;
End;

Procedure TTSTOItemListerImpl.ListNonFreeItems(Const AMasterList : String; Const AFileName : String);
Begin
  SaveOverRideList(CreateOverRideListEx(AMasterList, 'CostOverRides', 'DataID[@OverRide="true" and (Cost or BuildTime[not(@time="0")])]', orlkNonFree, True), AFileName);
End;

Procedure TTSTOItemListerImpl.ListUniqueItems(AFileList : TStringList; Const AFileName : String);
Begin
  SaveOverRideList(CreateOverRideList(AFileList, orlkUnique), AFileName);
End;

Procedure TTSTOItemListerImpl.ListUniqueItems(AProject : ITSTOXmlProject; Const AFileName : String);
Var X         : Integer;
    lFileList : TStringList;
Begin
  lFileList := TStringList.Create();
  Try
    If ListXmlPackageFiles(AProject, lFileList) Then
    Begin
      lFileList.Sorted := False;
      For X := 0 To lFileList.Count - 1 Do
        lFileList[X] := AProject.Settings.SourcePath + lFileList[X];

      ListUniqueItems(lFileList, AFileName);
    End;

    Finally
      lFileList.Free();
  End;
End;

Procedure TTSTOItemListerImpl.ListUniqueItems(Const AMasterList : String; Const AFileName : String);
Begin
  SaveOverRideList(CreateOverRideListEx(AMasterList, 'UniqueOverRides', 'DataID[@OverRide="true" and Unique[@value="true"]]', orlkUnique, True), AFileName);
End;

Procedure TTSTOItemListerImpl.ListRequirementItems(AFileList : TStringList; Const AFileName : String);
Begin
  SaveOverRideList(CreateOverRideList(AFileList, orlkRequirements), AFileName);
End;

Procedure TTSTOItemListerImpl.ListRequirementItems(AProject : ITSTOXmlProject; Const AFileName : String);
Var X         : Integer;
    lFileList : TStringList;
Begin
  lFileList := TStringList.Create();
  Try
    If ListXmlPackageFiles(AProject, lFileList) Then
    Begin
      lFileList.Sorted := False;
      For X := 0 To lFileList.Count - 1 Do
        lFileList[X] := AProject.Settings.SourcePath + lFileList[X];

      ListRequirementItems(lFileList, AFileName);
    End;

    Finally
      lFileList.Free();
  End;
End;

Procedure TTSTOItemListerImpl.ListRequirementItems(Const AMasterList : String; Const AFileName : String);
Begin
  SaveOverRideList(CreateOverRideListEx(AMasterList, 'RequirementOverRides', 'DataID[@OverRide="true" and (VisibilityRequirements or Requirements or Requirement)]', orlkRequirements, True), AFileName);
End;

Procedure TTSTOItemListerImpl.ListNonSellableItems(AFileList : TStringList; Const AFileName : String);
Begin
  SaveOverRideList(CreateOverRideList(AFileList, orlkNonSellable), AFileName);
End;

Procedure TTSTOItemListerImpl.ListNonSellableItems(AProject : ITSTOXmlProject; Const AFileName : String);
Var X         : Integer;
    lFileList : TStringList;
Begin
  lFileList := TStringList.Create();
  Try
    If ListXmlPackageFiles(AProject, lFileList) Then
    Begin
      lFileList.Sorted := False;
      For X := 0 To lFileList.Count - 1 Do
        lFileList[X] := AProject.Settings.SourcePath + lFileList[X];

      ListNonSellableItems(lFileList, AFileName);
    End;

    Finally
      lFileList.Free();
  End;
End;

Procedure TTSTOItemListerImpl.ListNonSellableItems(Const AMasterList : String; Const AFileName : String);
Begin
  SaveOverRideList(CreateOverRideListEx(AMasterList, 'SellableOverRides', 'DataID[@OverRide="true" and Sell[@allowed="false" or @storeoverride="false"]]', orlkNonSellable, True), AFileName);
End;

Procedure TTSTOItemListerImpl.ListNonFreeFarmJobs(AProject : ITSTOXmlProject; Const AFileName : String);
Var lXml   : IXmlDocumentEx;
    lNodes : IXmlNodeListEx;
    lCommentStr : String;
    X : Integer;
Begin
  With AProject.Settings Do
    If FileExists(SourcePath + 'Farms.xml') Then
    Begin
      lNodes := LoadXmlDocument(SourcePath + 'farms.xml').SelectNodes('//Job[Cost[not(@money="0")]]');
      lXml := NewXmlDocument('');
      lXml.Options := lXml.Options + [doNodeAutoIndent];
      lXml.NodeIndentStr := '  ';
      lXml.AddChild('List').Attributes['name'] := 'KhnFreeFarmJob';

      lCommentStr := '';
      For X := 0 To lNodes.Count - 1 Do
      Begin
        With lNodes[X].DOMNode.parentNode.attributes.getNamedItem('name') Do
          If lCommentStr <> nodeValue Then
          Begin
            lCommentStr := nodeValue;
            lXml.DocumentElement.ChildNodes.Add(lXml.CreateNode(' ' + lCommentStr + ' ', ntComment));
          End;

        lXml.DocumentElement.AddChild('String').Attributes['name'] :=
          lNodes[X].AttributeNodes['name'].Text;
      End;

      If AFileName = '' Then
        ShowMessage(lXml.Xml.Text)
      Else
        lXml.SaveToFile(AFileName);
    End
    Else
      MessageDlg('File : ' + SourcePath + 'Farms.xml does not exist.', mtWarning, [mbOK], 0);
{
  lPath := 'C:\Projects\TSTO-Hacker\Bin\Hacks\KahnHack\4_21_Superheroes2_Patch2_PostLaunch_DNOE50KJG1UF\gamescripts-r323603-9658GBJP\0\';
  lNodes := LoadXmlDocument(lPath + 'farms.xml').SelectNodes('//Job[Cost[not(@money="0")]]');
  lXml := NewXmlDocument('');
  lXml.Options := lXml.Options + [doNodeAutoIndent];
  lXml.NodeIndentStr := '  ';
  //<List name="KhnBuilding">
  lXml.AddChild('List').Attributes['name'] := 'KhnFreeFarmJob';

  lStr := '';
  For X := 0 To lNodes.Count - 1 Do
  Begin
    If lStr <> lNodes[X].DOMNode.parentNode.attributes.getNamedItem('name').nodeValue Then
    Begin
      lStr := lNodes[X].DOMNode.parentNode.attributes.getNamedItem('name').nodeValue;
      lXml.DocumentElement.ChildNodes.Add(lXml.CreateNode(' ' + lStr + ' ', ntComment));
    End;
    //<String name="IncomeTax3" />
    lXml.DocumentElement.AddChild('String').Attributes['name'] :=
      lNodes[X].AttributeNodes['name'].Text;
  End;

  ShowMessage(lXml.Xml.Text);
}
End;

Procedure TTSTOItemListerImpl.ListStoreRequirement(Const AMasterList : String; Const AFileName : String);
Var lHackMaster : ITSTOHackMasterListIO;
    X : Integer;
    lLst : IHsStringListEx;
Begin
  lHackMaster := TTSTOHackMasterListIO.CreateHackMasterList();
  lLst := THsStringListEx.CreateList();
  Try
    lHackMaster.LoadFromFile(AMasterList);
    lLst.Add('<StoreRequirements>');

    For X := 0 To lHackMaster.Count - 1 Do
      If lHackMaster[X].BuildStore And (lHackMaster[X].Name <> '') Then
        lLst.Add(lHackMaster.ListStoreRequirements(lHackMaster[X].Name));
    lLst.Add('</StoreRequirements>');

    lLst.Text := FormatXmlData(lLst.Text);
    lLst.SaveToFile(AFileName);

    Finally
      lHackMaster := Nil;
      lLst := Nil;
  End;
End;

end.
