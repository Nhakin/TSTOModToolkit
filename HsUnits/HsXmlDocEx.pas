unit HsXmlDocEx;

interface

Uses Classes, SysUtils, XmlDom, XmlDoc, XmlIntf, HsInterfaceEx;

Type
  IXmlNodeEx = Interface;
  IXmlDocumentEx = Interface;
  IXmlNodeListEx = Interface;
  
  IXmlNodeCollectionEx = Interface(IXmlNodeCollection)
    ['{A657BDB8-9BAC-4E8F-8FD7-E4E0F914D805}']
    Function GetAttributeNodes() : IXmlNodeListEx;
    Function GetOwnerDocument() : IXmlDocumentEx;

    Function AddItem(Index: Integer) : IXmlNodeEx;

    Property AttributeNodes : IXmlNodeListEx Read GetAttributeNodes;
    Property OwnerDocument  : IXmlDocumentEx Read GetOwnerDocument;

  End;

  IXmlNodeExEnumerator = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-6969-ABC941048707}']
    Function GetCurrent() : IXmlNodeEx;
    Function MoveNext() : Boolean;

    Property Current : IXmlNodeEx Read GetCurrent;

  End;

  IXmlNodeListEx = Interface(IXmlNodeList)
    ['{4B61686E-29A0-2112-B0F9-AC06CC566B8A}']
    Function GetNode(Const IndexOrName: OleVariant) : IXmlNodeEx;
    Function GetEnumerator() : IXmlNodeExEnumerator;

    Function First() : IXmlNodeEx;
    Function Last() : IXmlNodeEx;
    Function FindNode(NodeName : DOMString) : IXmlNodeEx;
    Function Remove(Const Node : IXmlNodeEx) : Integer;

    Property Nodes[Const IndexOrName: OleVariant] : IXmlNodeEx Read GetNode; Default;
    Property Enumerator : IXmlNodeExEnumerator Read GetEnumerator;

  End;

  IXmlDocumentEx = Interface(IXmlDocument)
    ['{4B61686E-29A0-2112-BEBE-F039CC566B87}']
    Function GetDocumentElement() : IXmlNodeEx;
    Procedure SetDocumentElement(Const Value : IXmlNodeEx);
    Function GetDocumentNode() : IXmlNodeEx;
    Function GetChildNodes() : IXmlNodeListEx;

    Function AddChild(Const TagName: DOMString) : IXmlNodeEx; OverLoad;
    Function AddChild(Const TagName, NamespaceURI: DOMString) : IXmlNodeEx; OverLoad;

    Function SelectNode(Const ANodePath : Widestring; ARoot : IXmlNodeEx = Nil) : IXmlNodeEx;
    Function SelectNodes(Const ANodePath : Widestring; ARoot : IXmlNodeEx = Nil) : IXmlNodeListEx;

    Property DocumentElement : IXmlNodeEx     Read GetDocumentElement Write SetDocumentElement;
    Property Node            : IXmlNodeEx     Read GetDocumentNode;
    Property ChildNodes      : IXmlNodeListEx Read GetChildNodes;

  End;

  IXmlDocumentExList = Interface(IInterfaceList)
    ['{4B61686E-29A0-2112-9CD9-D5C429F92359}']
    Function  Get(Index: Integer) : IXmlDocumentEx;
    Procedure Put(Index: Integer; Const Item: IXmlDocumentEx);
    Function  Add(Const Item : IXmlDocumentEx) : Integer;

    Function IndexOf(Const AFileName : String) : Integer;

    Property Items[Index : Integer] : IXmlDocumentEx Read Get Write Put; Default;

  End;

  IXmlNodeEx = Interface(IXmlNode)
    ['{4B61686E-29A0-2112-B94C-F039CC566B87}']
    Function GetChildNodes() : IXmlNodeListEx;
    Function GetAttributeNodes() : IXmlNodeListEx;
    Function GetOwnerDocument() : IXmlDocumentEx;
    Function GetParentNode() : IXmlNodeEx;

    Function AddChild(Const TagName : DOMString; Index : Integer = -1) : IXmlNodeEx; OverLoad;
    Function AddChild(Const TagName, NamespaceURI : DOMString;
      GenPrefix : Boolean = False; Index : Integer = -1) : IXmlNodeEx; OverLoad;

    Function PreviousSibling() : IXmlNodeEx;
    Function NextSibling() : IXmlNodeEx;

    Property ChildNodes     : IXmlNodeListEx Read GetChildNodes;
    Property AttributeNodes : IXmlNodeListEx Read GetAttributeNodes;
    Property OwnerDocument  : IXmlDocumentEx Read GetOwnerDocument;
    property ParentNode     : IXmlNodeEx     Read GetParentNode;

    Function  GetAsString() : String;
    Procedure SetAsString(Const AString : String);

    Function  GetAsByte() : Byte;
    Procedure SetAsByte(Const AByte : Byte);

    Function  GetAsInteger() : Integer;
    Procedure SetAsInteger(Const AInteger : Integer);

    Function  GetAsFloat() : Double;
    Procedure SetAsFloat(Const AFloat : Double);

    Function  GetAsCurrency() : Currency;
    Procedure SetAsCurrency(Const ACurrency : Currency);

    Function  GetAsBoolean() : Boolean;
    Procedure SetAsBoolean(Const ABoolean : Boolean);

    Function  GetAsDateTime() : TDateTime;
    Procedure SetAsDateTime(Const ADateTime : TDateTime);

    Property AsString   : String    Read GetAsString   Write SetAsString;
    Property AsByte     : Byte      Read GetAsByte     Write SetAsByte;
    Property AsInteger  : Integer   Read GetAsInteger  Write SetAsInteger;
    Property AsFloat    : Double    Read GetAsFloat    Write SetAsFloat;
    Property AsCurrency : Currency  Read GetAsCurrency Write SetAsCurrency;
    Property AsBoolean  : Boolean   Read GetAsBoolean  Write SetAsBoolean;
    Property AsDateTime : TDateTime Read GetAsDateTime Write SetAsDateTime;

  End;

  TXmlDocumentEx = Class(TXmlDocument, IXmlDocumentEx)
  Private
    FDocumentNode : IXMLNodeEx;

  Protected
    Function GetDocumentElement() : IXmlNodeEx; OverLoad;
    Procedure SetDocumentElement(Const Value : IXmlNodeEx); OverLoad;
    Function GetDocumentNode() : IXmlNodeEx; OverLoad;
    Function GetChildNodes() : IXmlNodeListEx; OverLoad;

    Function AddChild(Const TagName: DOMString) : IXmlNodeEx; OverLoad;
    Function AddChild(Const TagName, NamespaceURI: DOMString) : IXmlNodeEx; OverLoad;

    Function SelectNode(Const ANodePath : Widestring; ARoot : IXmlNodeEx = Nil) : IXmlNodeEx;
    Function SelectNodes(Const ANodePath : Widestring; ARoot : IXmlNodeEx = Nil) : IXmlNodeListEx;

    Property DocumentElement : IXmlNodeEx Read GetDocumentElement Write SetDocumentElement;
    Property Node            : IXmlNodeEx Read GetDocumentNode;
    Property ChildNodes      : IXmlNodeListEx Read GetChildNodes;

  End;

  TXmlDocumentExList = Class(TInterfaceList, IXmlDocumentExList)
  Protected
    Function  Get(Index: Integer) : IXmlDocumentEx; OverLoad;
    Procedure Put(Index: Integer; Const Item: IXmlDocumentEx); OverLoad;
    Function  Add(Const Item : IXmlDocumentEx) : Integer; OverLoad;

    Function IndexOf(Const AFileName : String) : Integer; OverLoad;

  End;

  TXmlNodeEx = Class(TXmlNode, IInterfaceEx, IXmlNodeEx)
  Private
    FFmtSettings : TFormatSettings;

  Protected //TXmlNode
    Function CreateChildList() : IXMLNodeList; OverRide;
    Procedure AttributeListNotifyEx(Operation: TNodeListOperation;
      Var Node: IXMLNode; Const IndexOrName: OleVariant; BeforeOperation: Boolean);
    Function CreateAttributeList() : IXMLNodeList; OverRide;
    Function CreateChildNode(Const ADOMNode: IDOMNode) : IXMLNode; OverRide;
    Function CreateAttributeNode(const ADOMNode: IDOMNode): IXMLNode; OverRide;

  Protected //IInterfaceEx
    Function IsImplementorOf(Const I : IInterfaceEx) : Boolean;

    Function GetInterfaceObject() : TObject;
    Function GetRefCount() : Integer;
    Function GetController() : IInterfaceEx;

    Function  GetIsContained() : Boolean;
    Procedure SetIsContained(Const AIsContained : Boolean);

    Function  GetHaveRefCount() : Boolean;
    Procedure SetHaveRefCount(Const AHaveRefCount : Boolean);

  Protected //IXmlNodeEx
    Function GetChildNodes() : IXMLNodeListEx; OverLoad; Virtual;
    Function GetAttributeNodes() : IXMLNodeListEx; OverLoad; Virtual;
    Function GetOwnerDocument() : IXmlDocumentEx; OverLoad; Virtual;
    Function GetParentNode() : IXmlNodeEx; OverLoad; Virtual;

    Function AddChild(Const TagName : DOMString; Index : Integer = -1) : IXmlNodeEx; OverLoad;
    Function AddChild(Const TagName, NamespaceURI : DOMString;
      GenPrefix : Boolean = False; Index : Integer = -1) : IXmlNodeEx; OverLoad;

    Function PreviousSibling() : IXmlNodeEx; OverLoad;
    Function NextSibling() : IXmlNodeEx; OverLoad;

    Function  GetAsString() : String; Virtual;
    Procedure SetAsString(Const AString : String); Virtual;

    Function  GetAsByte() : Byte;
    Procedure SetAsByte(Const AByte : Byte);

    Function  GetAsInteger() : Integer; Virtual;
    Procedure SetAsInteger(Const AInteger : Integer); Virtual;

    Function  GetAsFloat() : Double; Virtual;
    Procedure SetAsFloat(Const AFloat : Double); Virtual;

    Function  GetAsCurrency() : Currency; Virtual;
    Procedure SetAsCurrency(Const ACurrency : Currency); Virtual;

    Function  GetAsBoolean() : Boolean; Virtual;
    Procedure SetAsBoolean(Const ABoolean : Boolean); Virtual;

    Function  GetAsDateTime() : TDateTime; Virtual;
    Procedure SetAsDateTime(Const ADateTime : TDateTime); Virtual;

    Property NodeValue      : OleVariant     Read GetNodeValue Write SetNodeValue;
    Property ChildNodes     : IXmlNodeListEx Read GetChildNodes;
    Property AttributeNodes : IXmlNodeListEx Read GetAttributeNodes;

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TXmlNodeExEnumerator = Class(TInterfacedObjectEx, IXmlNodeExEnumerator)
  Private
    FList  : IXmlNodeListEx;
    FIndex : Integer;

  Protected
    Function GetCurrent() : IXmlNodeEx; OverLoad;
    Function MoveNext() : Boolean;

    Property Current : IXmlNodeEx Read GetCurrent;

  Public
    Constructor Create(AList : IXmlNodeListEx); ReIntroduce;

  End;

  TXmlNodeListEx = Class(TXmlNodeList, IXmlNodeListEx)
  Protected
    Function GetNode(Const IndexOrName: OleVariant) : IXmlNodeEx; OverLoad;
    Function GetEnumerator() : IXmlNodeExEnumerator;

    Function First() : IXmlNodeEx; OverLoad;
    Function Last() : IXmlNodeEx; OverLoad;
    Function FindNode(NodeName : DOMString) : IXmlNodeEx; OverLoad;
    Function Remove(Const Node : IXmlNodeEx) : Integer; OverLoad;

  End;

  TXMLNodeCollectionEx = Class(TXmlNodeCollection, IInterfaceEx, IXmlNodeEx, IXmlNodeCollectionEx)
  Private
    FIntfEx : TInterfaceExImplementor;

    Function GetImplementor() : TInterfaceExImplementor;

  Protected
    Function IsImplementorOf(Const I : IInterfaceEx) : Boolean;

    Function CreateChildNode(Const ADOMNode: IDOMNode) : IXMLNode; OverRide;
//    Procedure AttributeListNotifyEx(Operation: TNodeListOperation;
//      Var Node: IXMLNode; Const IndexOrName: OleVariant; BeforeOperation: Boolean);
//    Function CreateAttributeList() : IXMLNodeList; OverRide;

    Function AddChild(Const TagName : DOMString; Index : Integer = -1) : IXmlNodeEx; OverLoad; Virtual; Abstract;
    Function AddChild(Const TagName, NamespaceURI : DOMString;
      GenPrefix : Boolean = False; Index : Integer = -1) : IXmlNodeEx; OverLoad; Virtual; Abstract;
    Function AddItem(Index: Integer) : IXMLNodeEx; OverLoad;

    Function  GetAsString() : String; Virtual; Abstract;
    Procedure SetAsString(Const AString : String); Virtual; Abstract;

    Function  GetAsByte() : Byte; Virtual; Abstract;
    Procedure SetAsByte(Const AByte : Byte); Virtual; Abstract;

    Function  GetAsInteger() : Integer; Virtual; Abstract;
    Procedure SetAsInteger(Const AInteger : Integer); Virtual; Abstract;

    Function  GetAsFloat() : Double; Virtual; Abstract;
    Procedure SetAsFloat(Const AFloat : Double); Virtual; Abstract;

    Function  GetAsCurrency() : Currency; Virtual; Abstract;
    Procedure SetAsCurrency(Const ACurrency : Currency); Virtual; Abstract;

    Function  GetAsBoolean() : Boolean; Virtual; Abstract;
    Procedure SetAsBoolean(Const ABoolean : Boolean); Virtual; Abstract;

    Function  GetAsDateTime() : TDateTime; Virtual; Abstract;
    Procedure SetAsDateTime(Const ADateTime : TDateTime); Virtual; Abstract;

  Protected
    Property IntfExImpl : TInterfaceExImplementor Read GetImplementor Implements IInterfaceEx;

    Function GetChildNodes() : IXMLNodeListEx; OverLoad; Virtual;
    Function GetAttributeNodes() : IXMLNodeListEx; OverLoad; Virtual;
    Function GetOwnerDocument() : IXmlDocumentEx; OverLoad; Virtual;
    Function GetParentNode() : IXmlNodeEx; OverLoad; Virtual;

    Function PreviousSibling() : IXmlNodeEx; OverLoad;
    Function NextSibling() : IXmlNodeEx; OverLoad;

//    Property AttributeNodes : IXmlNodeListEx Read GetAttributeNodes;
    
  End;

Function FormatXMLData(Const AXmlData : DOMString; Const ANodeIndentStr : String = '  ') : DOMString;
Function LoadXMLData(Const AXmlData : DOMString) : IXmlDocumentEx;
Function LoadXMLDocument(Const FileName : DOMString): IXmlDocumentEx;
Function NewXMLDocument(Version : DOMString = '1.0') : IXmlDocumentEx;

implementation

Uses Dialogs,
  XSBuiltIns, XMLConst, Variants;

Function FormatXMLData(Const AXmlData : DOMString; Const ANodeIndentStr : String = '  ') : DOMString;
Var
  lSrcDoc ,
  lTrgDoc : IXMLDocument;

  Function CloneNodeToDoc(Const SourceNode: IXMLNode; Const TargetDoc: IXMLDocument; Deep: Boolean = True) : IXMLNode;
  Var
    I: Integer;
  Begin
    With SourceNode Do
      Case nodeType Of
        ntElement:
        Begin
          Result := TargetDoc.CreateElement(NodeName, NamespaceURI);
          For I := 0 To AttributeNodes.Count - 1 Do
            Result.AttributeNodes.Add(CloneNodeToDoc(AttributeNodes[I], TargetDoc, False));
          If Deep Then
            For I := 0 To ChildNodes.Count - 1 Do
              Result.ChildNodes.Add(CloneNodeToDoc(ChildNodes[I], TargetDoc, Deep));
        End;

        ntAttribute:
        Begin
          Result := TargetDoc.CreateNode(NodeName, ntAttribute, NamespaceURI);
          Result.NodeValue := NodeValue;
        End;

        ntText, ntCData, ntComment:
        Begin
          If VarIsNull(NodeValue) Then
            Result :=  TargetDoc.CreateNode('', NodeType)
          Else
            Result := TargetDoc.CreateNode(NodeValue, NodeType);
        End;

        ntEntityRef:
          Result := TargetDoc.createNode(nodeName, NodeType);

        ntProcessingInstr:
          Result := TargetDoc.CreateNode(NodeName, ntProcessingInstr, NodeValue);

        ntDocFragment:
        Begin
          Result := TargetDoc.CreateNode('', ntDocFragment);
          If Deep Then
            For I := 0 To ChildNodes.Count - 1 Do
              Result.ChildNodes.Add(CloneNodeToDoc(ChildNodes[I], TargetDoc, Deep));
        End;

        Else
           {ntReserved, ntEntity, ntDocument, ntDocType:}
          XMLDocError(SInvalidNodeType);
      End;
  End;

  Procedure RemoveDeclNode;
  Var FirstNode : IXMLNode;
  Begin
    FirstNode := lSrcDoc.Node.ChildNodes[0];
    If (FirstNode.NodeName = 'xml') Or (FirstNode.NodeName = '#xmldecl') Then
      lSrcDoc.ChildNodes.Delete(0);
  End;

  Procedure CopyChildNodes(SrcNode, DestNode: IXMLNode);
  Var X    : Integer;
      lSrc , 
      lTrg : IXMLNode;
  Begin
    For X := 0 To SrcNode.ChildNodes.Count - 1 Do
    Begin
      lSrc := SrcNode.ChildNodes[X];
      lTrg := CloneNodeToDoc(lSrc, lTrgDoc, False);
      { Note this fails on documents with DOCTYPE nodes }
      DestNode.ChildNodes.Add(lTrg);
      If lSrc.HasChildNodes Then
        CopyChildNodes(lSrc, lTrg);
    End;
  End;

Begin
  lSrcDoc := LoadXMLData(AXmlData);
  lTrgDoc := NewXMLDocument('');
  If lSrcDoc.Version <> '' Then
    lTrgDoc.Version := lSrcDoc.Version;
  If lSrcDoc.StandAlone <> '' Then
    lTrgDoc.StandAlone := lSrcDoc.StandAlone;
  If lSrcDoc.Encoding <> '' Then
    lTrgDoc.Encoding := lSrcDoc.Encoding;
  If (lSrcDoc.ChildNodes.Count > 1) Then
    RemoveDeclNode;
  lTrgDoc.Options := lTrgDoc.Options + [doNodeAutoIndent];
  lTrgDoc.NodeIndentStr := ANodeIndentStr;
  CopyChildNodes(lSrcDoc.Node, lTrgDoc.Node);
  lTrgDoc.SaveToXML(Result);
End;

Function LoadXMLData(Const AXmlData : DOMString) : IXmlDocumentEx;
Begin
  Result := TXmlDocumentEx.Create(Nil);
  Result.LoadFromXML(AXmlData);
End;

Function LoadXMLDocument(Const FileName : DOMString) : IXmlDocumentEx;
Begin
  Result := TXmlDocumentEx.Create(FileName);
End;

Function NewXMLDocument(Version : DOMString = '1.0') : IXmlDocumentEx;
Begin
  Result := TXmlDocumentEx.Create(nil);
  Result.Active := True;
  If Version <> '' Then
    Result.Version := Version;
End;

{$Hints Off}
Type
  TXmlDocumentAccess = Class(TXmlDocument);
  TXmlNodeAccess = Class(TXmlNode);

  TXmlNodeHack = Class(TInterfacedObject)
  Private
    FAttributeNodes    : IXMLNodeList;
    FChildNodes        : IXMLNodeList;
    FChildNodeClasses  : TNodeClassArray;

  End;
{$Hints On}

Function TXmlDocumentEx.GetDocumentNode() : IXmlNodeEx;
Var
  DocNodeObject : TXMLNodeEx;
Begin
  CheckActive();
  If Not Assigned(FDocumentNode) Then
  Begin
    DocNodeObject := TXMLNodeEx.Create(DOMDocument, Nil, Self);
    FDocumentNode := DocNodeObject;
    TXmlNodeHack(DocNodeObject).FChildNodeClasses := InHerited DocBindingInfo;
  End;

  Result := FDocumentNode;
End;

Function TXmlDocumentEx.GetChildNodes() : IXmlNodeListEx;
Begin
  Result := Node.ChildNodes As IXmlNodeListEx;
End;

Function TXmlDocumentEx.AddChild(Const TagName: DOMString) : IXmlNodeEx;
Begin
  Result := GetDocumentNode().AddChild(TagName);
//  Result := InHerited AddChild(TagName) As IXmlNodeEx;
End;

Function TXmlDocumentEx.AddChild(Const TagName, NamespaceURI: DOMString) : IXmlNodeEx;
Begin
  Result := InHerited AddChild(TagName, NamespaceURI) As IXmlNodeEx;
End;

Function TXmlDocumentEx.GetDocumentElement() : IXmlNodeEx;
Begin
  CheckActive();
  Result := Nil;
  If Node.HasChildNodes Then
  Begin
    Result := Node.ChildNodes.Last;
    While Assigned(Result) And (Result.NodeType <> ntElement) Do
      Result := Result.PreviousSibling();
  End;
End;

Procedure TXmlDocumentEx.SetDocumentElement(Const Value : IXmlNodeEx);
Var OldDocElement : IXmlNodeEx;
Begin
  CheckActive();
  OldDocElement := GetDocumentElement();
  If Assigned(OldDocElement) Then
    Node.ChildNodes.ReplaceNode(OldDocElement, Value)
  Else
    Node.ChildNodes.Add(Value);
End;

{
  https://msdn.microsoft.com/en-us/library/ms256122.aspx
}
Function TXmlDocumentEx.SelectNode(Const ANodePath : Widestring; ARoot : IXmlNodeEx = Nil) : IXmlNodeEx;
Var lList : IXmlNodeListEx;
Begin
  lList := SelectNodes(ANodePath, ARoot);
  If Assigned(lList) And (lList.Count > 0) Then
    Result := lList[0]
  Else
    Result := Nil;
End;

Function TXmlDocumentEx.SelectNodes(Const ANodePath : Widestring; ARoot : IXmlNodeEx = Nil) : IXmlNodeListEx;
Var intfSelect : IDomNodeSelect;
    intfAccess : IXmlNodeAccess;
    dnlResult  : IDomNodeList;
    X          : Integer;
Begin
  Result := Nil;

  If Not Assigned(ARoot) Then
    ARoot := DocumentElement;

  If Supports(ARoot, IXmlNodeAccess, intfAccess) And
     Supports(ARoot.DOMNode, IDomNodeSelect, intfSelect) Then
  Begin
    dnlResult := intfSelect.SelectNodes(ANodePath);

    If Assigned(dnlResult) Then
    Begin
      Result := TXmlNodeListEx.Create(intfAccess.GetNodeObject, '', Nil);

      For X := 0 To dnlResult.Length - 1 Do
        Result.Add(TXmlNodeEx.Create(dnlResult.Item[X], Nil, Self));
    End;
  End;
End;

Function TXmlDocumentExList.Get(Index: Integer) : IXmlDocumentEx; 
Begin
  Result := InHerited Items[Index] As IXmlDocumentEx;
End;

Procedure TXmlDocumentExList.Put(Index: Integer; Const Item: IXmlDocumentEx);
Begin
  InHerited Items[Index] := Item;
End;

Function TXmlDocumentExList.Add(Const Item : IXmlDocumentEx) : Integer;
Begin
  Result := InHerited Add(Item);
End;

Function TXmlDocumentExList.IndexOf(Const AFileName : String) : Integer;
Var X : Integer;
Begin
  Result := -1;

  For X := 0 To Count - 1 Do
    If SameText(ExtractFileName(Get(X).FileName), AFileName) Then
    Begin
      Result := X;
      Break;
    End;
End;

Procedure TXmlNodeEx.AfterConstruction();
Begin
  InHerited AfterConstruction();

  GetLocaleFormatSettings(0, FFmtSettings);

  FFmtSettings.ThousandSeparator := #0;
  FFmtSettings.DecimalSeparator := '.';
End;

Function TXmlNodeEx.CreateChildList() : IXMLNodeList;
Var X       : Integer;
    lResult : TXmlNodeListEx;
Begin
  lResult := TXmlNodeListEx.Create(Self, GetNamespaceURI, ChildListNotify);
  For X := 0 To DOMNode.ChildNodes.Length - 1 Do
    lResult.List.Add(CreateChildNode(DOMNode.ChildNodes[X]));

  Result := lResult;
End;

Procedure TXmlNodeEx.AttributeListNotifyEx(Operation: TNodeListOperation;
  Var Node: IXMLNode; Const IndexOrName: OleVariant; BeforeOperation: Boolean);
const
  NodeChangeMap: array[TNodeListOperation] of TNodeChange = (ncAddAttribute,
    ncRemoveAttribute, ncAddAttribute);
var
  I: Integer;
  HostedNode: TXmlNodeAccess;
Begin
  DoNodeChange(NodeChangeMap[Operation], BeforeOperation);
  if BeforeOperation and (AttributeNodes.UpdateCount = 0) then
    case Operation of
      nlRemove: DOMElement.removeAttributeNode(Node.DOMNode as IDOMAttr);
      nlInsert: DOMElement.setAttributeNode(Node.DOMNode as IDOMAttr);
      nlCreateNode:
        begin
          Node := TXmlNodeEx.Create(CreateDOMNode(OwnerDocument.DOMDocument, IndexOrName,
                    ntAttribute, ''), nil, OwnerDocument);
          AttributeNodes.Add(Node);
        end;
    end;

  if Assigned(HostedNodes) then
    for I := 0 to Length(HostedNodes) - 1 do
    begin
      HostedNode := TXmlNodeAccess(HostedNodes[I]);
      if Assigned(HostedNode.OnHostAttrNotify) then
          HostedNode.OnHostAttrNotify(Operation, Node, IndexOrName, BeforeOperation);
    end;
End;

Function TXmlNodeEx.CreateAttributeList() : IXMLNodeList;
Var X       : Integer;
    lResult : TXmlNodeListEx;
Begin
  lResult := TXMLNodeListEx.Create(Self, '', AttributeListNotifyEx);
  If Assigned(DOMNode.Attributes) Then
    For X := 0 To DOMNode.Attributes.Length - 1 Do
      lResult.List.Add(CreateAttributeNode(DOMNode.Attributes[X]));

  Result := lResult;
End;

Function TXmlNodeEx.CreateChildNode(Const ADOMNode: IDOMNode) : IXMLNode;
Var X : Integer;
    lChildNodeClass: TXMLNodeClass;
Begin
  If Assigned(HostNode) Then
    Result := TXmlNodeAccess(HostNode).CreateChildNode(ADOMNode)
  Else
  Begin
    lChildNodeClass := TXmlDocumentAccess(OwnerDocument).GetChildNodeClass(ADOMNode);

    If lChildNodeClass = Nil Then
    Begin
      lChildNodeClass := TXMLNodeEx;

      For X := 0 to Length(ChildNodeClasses) - 1 Do
        With ChildNodeClasses[X] Do
          If NodeMatches(ADOMNode, NodeName, NamespaceURI) Then
          Begin
            lChildNodeClass := NodeClass;
            Break;
          End;
    End;

    Result := lChildNodeClass.Create(ADOMNode, Self, OwnerDocument);
  End;
End;

Function TXmlNodeEx.CreateAttributeNode(Const ADOMNode: IDOMNode) : IXMLNode;
Begin
  Result := TXMLNodeEx.Create(ADOMNode, Nil, OwnerDocument)
End;

Function TXmlNodeEx.IsImplementorOf(Const I : IInterfaceEx) : Boolean;
Begin
  Result := I.InterfaceObject = Self;
End;

Function TXmlNodeEx.GetInterfaceObject() : TObject;
Begin
  Result := Self;
End;

Function TXmlNodeEx.GetRefCount() : Integer;
Begin
  Result := InHerited RefCount;
End;

Function TXmlNodeEx.GetController() : IInterfaceEx;
Begin
  Result := Nil;
End;

Function TXmlNodeEx.GetIsContained() : Boolean;
Begin
  Result := False;
End;

Procedure TXmlNodeEx.SetIsContained(Const AIsContained : Boolean);
Begin

End;

Function TXmlNodeEx.GetHaveRefCount() : Boolean;
Begin
  Result := True;
End;

Procedure TXmlNodeEx.SetHaveRefCount(Const AHaveRefCount : Boolean);
Begin

End;

Function TXmlNodeEx.GetChildNodes() : IXMLNodeListEx;
Begin
  Result := InHerited GetChildNodes() As IXmlNodeListEx;
End;

Function TXmlNodeEx.GetAttributeNodes() : IXMLNodeListEx;
Begin
  Result := InHerited GetAttributeNodes() As IXmlNodeListEx;
End;

Function TXmlNodeEx.GetOwnerDocument() : IXmlDocumentEx;
Begin
  If Assigned(OwnerDocument) Then
    OwnerDocument.GetInterface(IXmlDocumentEx, Result);
End;

Function TXmlNodeEx.GetParentNode() : IXmlNodeEx;
Begin
  Result := InHerited GetParentNode() As IXmlNodeEx;
End;

Function TXmlNodeEx.AddChild(Const TagName : DOMString; Index : Integer = -1) : IXmlNodeEx;
Begin
  Result := InHerited AddChild(TagName, Index) As IXmlNodeEx;
End;

Function TXmlNodeEx.AddChild(Const TagName, NamespaceURI : DOMString;
  GenPrefix : Boolean = False; Index : Integer = -1) : IXmlNodeEx;
Begin

End;

Function TXmlNodeEx.PreviousSibling() : IXmlNodeEx;
Begin
  Result := InHerited PreviousSibling() As IXmlNodeEx;
End;

Function TXmlNodeEx.NextSibling() : IXmlNodeEx;
Begin
  Result := InHerited NextSibling() As IXmlNodeEx;
End;

Function TXmlNodeEx.GetAsString() : String;
Begin
  Result := GetText();
End;

Procedure TXmlNodeEx.SetAsString(Const AString : String);
Begin
  NodeValue := AString;
End;

Function TXmlNodeEx.GetAsByte() : Byte;
Begin
  If VarIsNull(NodeValue) Then
    Result := 0
  Else
    Result := NodeValue;
End;

Procedure TXmlNodeEx.SetAsByte(Const AByte : Byte);
Begin
  NodeValue := AByte;
End;

Function TXmlNodeEx.GetAsInteger() : Integer;
Begin
  If VarIsNull(NodeValue) Then
    Result := 0
  Else
    Result := NodeValue;
End;

Procedure TXmlNodeEx.SetAsInteger(Const AInteger : Integer);
Begin
  NodeValue := AInteger;
End;

Function TXmlNodeEx.GetAsFloat() : Double;
Begin
  If VarIsNull(NodeValue) Then
    Result := 0
  Else
  Begin
    If Not TryStrToFloat(NodeValue, Result, FFmtSettings) Then
      Raise Exception.Create('Invalid floating point value.');
  End;
End;

Procedure TXmlNodeEx.SetAsFloat(Const AFloat : Double);
Begin
  NodeValue := AFloat;
End;

Function TXmlNodeEx.GetAsCurrency() : Currency;
Begin
  Result := GetAsFloat();
End;

Procedure TXmlNodeEx.SetAsCurrency(Const ACurrency : Currency);
Begin
  NodeValue := ACurrency;
End;

Function TXmlNodeEx.GetAsBoolean() : Boolean;
Begin
  If VarIsNull(NodeValue) Then
    Result := False
  Else If VarIsStr(NodeValue) Then
    Result := StrToBoolDef(NodeValue, False)
  Else If VarIsNumeric(NodeValue) Then
    Result := NodeValue <> 0
  Else
    Raise Exception.Create('Invalid data type ' + IntToStr(VarType(NodeValue)) + '.');
End;

Procedure TXmlNodeEx.SetAsBoolean(Const ABoolean : Boolean);
Begin
  NodeValue := ABoolean;
End;

Function TXmlNodeEx.GetAsDateTime() : TDateTime;
Begin
  If VarIsNull(NodeValue) Then
    Result := 0
  Else
  Begin
    With TXSDateTime.Create() Do
    Try
      XSToNative(NodeValue);
      Result := AsDateTime;

      Finally
        Free();
    End;
  End;
End;

Procedure TXmlNodeEx.SetAsDateTime(Const ADateTime : TDateTime);
Begin
  With TXSDateTime.Create() Do
  Try
    AsDateTime := ADateTime;
    NodeValue := NativeToXS;

    Finally
      Free();
  End;
End;

(******************************************************************************)

Constructor TXmlNodeExEnumerator.Create(AList : IXmlNodeListEx);
Begin
  InHerited Create(True);

  FList  := AList;
  FIndex := -1;
End;

Function TXmlNodeExEnumerator.MoveNext() : Boolean;
Begin
  If (FIndex >= FList.Count) Then
    Result := False
  Else
  Begin
    Inc(FIndex);
    Result := (FIndex < FList.Count);
  End;
End;

Function TXmlNodeExEnumerator.GetCurrent() : IXmlNodeEx;
Begin
  Result := FList[FIndex];
End;

Function TXmlNodeListEx.GetNode(Const IndexOrName: OleVariant) : IXmlNodeEx;
Begin
  Result := InHerited GetNode(IndexOrName) As IXmlNodeEx;
End;

Function TXmlNodeListEx.GetEnumerator() : IXmlNodeExEnumerator;
Begin
  Result := TXmlNodeExEnumerator.Create(Self);
End;

Function TXmlNodeListEx.First() : IXmlNodeEx;
Begin
  Result := InHerited First() As IXmlNodeEx;
End;

Function TXmlNodeListEx.Last() : IXmlNodeEx;
Begin
  Result := InHerited Last() As IXmlNodeEx;
End;

Function TXmlNodeListEx.FindNode(NodeName : DOMString) : IXmlNodeEx;
Begin
  Result := InHerited FindNode(NodeName) As IXmlNodeEx;
End;

Function TXmlNodeListEx.Remove(Const Node : IXmlNodeEx) : Integer;
Begin
  Result := InHerited Remove(Node);
End;

Function TXMLNodeCollectionEx.IsImplementorOf(Const I : IInterfaceEx) : Boolean;
Begin
  Result := I.InterfaceObject = Self;
End;

Function TXMLNodeCollectionEx.CreateChildNode(Const ADOMNode: IDOMNode) : IXMLNode;
Var X : Integer;
    lChildNodeClass: TXMLNodeClass;
Begin
  If Assigned(HostNode) Then
    Result := TXmlNodeAccess(HostNode).CreateChildNode(ADOMNode)
  Else
  Begin
    lChildNodeClass := TXmlDocumentAccess(OwnerDocument).GetChildNodeClass(ADOMNode);

    If lChildNodeClass = Nil Then
    Begin
      lChildNodeClass := TXMLNodeEx;

      For X := 0 to Length(ChildNodeClasses) - 1 Do
        With ChildNodeClasses[X] Do
          If NodeMatches(ADOMNode, NodeName, NamespaceURI) Then
          Begin
            lChildNodeClass := NodeClass;
            Break;
          End;
    End;

    Result := lChildNodeClass.Create(ADOMNode, Self, OwnerDocument);
  End;
End;

//Procedure TXMLNodeCollectionEx.AttributeListNotifyEx(Operation: TNodeListOperation;
//  Var Node: IXMLNode; Const IndexOrName: OleVariant; BeforeOperation: Boolean);
//const
//  NodeChangeMap: array[TNodeListOperation] of TNodeChange = (ncAddAttribute,
//    ncRemoveAttribute, ncAddAttribute);
//var
//  I: Integer;
//  HostedNode: TXmlNodeAccess;
//Begin
//  DoNodeChange(NodeChangeMap[Operation], BeforeOperation);
//  if BeforeOperation and (AttributeNodes.UpdateCount = 0) then
//    case Operation of
//      nlRemove: DOMElement.removeAttributeNode(Node.DOMNode as IDOMAttr);
//      nlInsert: DOMElement.setAttributeNode(Node.DOMNode as IDOMAttr);
//      nlCreateNode:
//        begin
//          Node := TXmlNodeEx.Create(CreateDOMNode(OwnerDocument.DOMDocument, IndexOrName,
//                    ntAttribute, ''), nil, OwnerDocument);
//          AttributeNodes.Add(Node);
//        end;
//    end;
//
//  if Assigned(HostedNodes) then
//    for I := 0 to Length(HostedNodes) - 1 do
//    begin
//      HostedNode := TXmlNodeAccess(HostedNodes[I]);
//      if Assigned(HostedNode.OnHostAttrNotify) then
//          HostedNode.OnHostAttrNotify(Operation, Node, IndexOrName, BeforeOperation);
//    end;
//End;
//
//Function TXMLNodeCollectionEx.CreateAttributeList() : IXMLNodeList;
//Var X       : Integer;
//    lResult : TXmlNodeListEx;
//Begin
//  lResult := TXMLNodeListEx.Create(Self, '', AttributeListNotifyEx);
//  If Assigned(DOMNode.Attributes) Then
//    For X := 0 To DOMNode.Attributes.Length - 1 Do
//      lResult.List.Add(CreateAttributeNode(DOMNode.Attributes[X]));
//
//  Result := lResult;
//End;

Function TXMLNodeCollectionEx.AddItem(Index: Integer) : IXMLNodeEx;
Begin
  Result := InHerited AddItem(Index) As IXmlNodeEx;
End;

Function TXMLNodeCollectionEx.GetImplementor() : TInterfaceExImplementor;
Begin
  If Not Assigned(FIntfEx) Then
    FIntfEx := TInterfaceExImplementor.Create(Self, False);
  Result := FIntfEx;
End;

Function TXMLNodeCollectionEx.GetChildNodes() : IXMLNodeListEx;
Begin
  Result := InHerited GetChildNodes() As IXmlNodeListEx;
End;

Function TXMLNodeCollectionEx.GetAttributeNodes() : IXMLNodeListEx;
Begin
  Result := InHerited GetAttributeNodes() As IXmlNodeListEx;
End;

Function TXMLNodeCollectionEx.GetOwnerDocument() : IXmlDocumentEx;
Begin
  If Assigned(OwnerDocument) Then
    OwnerDocument.GetInterface(IXmlDocumentEx, Result);
End;

Function TXMLNodeCollectionEx.GetParentNode() : IXmlNodeEx;
Begin
  Result := InHerited GetParentNode() As IXmlNodeEx;
End;

Function TXMLNodeCollectionEx.PreviousSibling() : IXmlNodeEx;
Begin
  Result := InHerited PreviousSibling() As IXmlNodeEx;
End;

Function TXMLNodeCollectionEx.NextSibling() : IXmlNodeEx;
Begin
  Result := InHerited NextSibling() As IXmlNodeEx;
End;

end.
