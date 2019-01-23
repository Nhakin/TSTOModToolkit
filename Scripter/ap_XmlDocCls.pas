Unit ap_XmlDocCls;

Interface

Uses
  Classes,
  XMLDoc,
  XMLIntf,
  //XmlDocCls,
  Variants,
  atScript;

{$WARNINGS OFF}

Type
  TatXmlDocClsLibrary = Class(TatScripterLibrary)
  Private
    Function InternalSelectNodes(AXmlDocument : TXmlDocument; Const AXPathQuery : String; ARoot : IXmlNode) : TXmlNodeList;

  Public
    Procedure __TXmlNodeAddChild(AMachine : TatVirtualMachine);
    Procedure __TXmlNodeCloneNode(AMachine : TatVirtualMachine);
    Procedure __TXmlNodeHasAttribute(AMachine : TatVirtualMachine);
    Procedure __TXmlNodeNextSibling(AMachine : TatVirtualMachine);
    Procedure __TXmlNodeNormalize(AMachine : TatVirtualMachine);
    Procedure __TXmlNodePreviousSibling(AMachine : TatVirtualMachine);
    Procedure __TXmlNodeResync(AMachine : TatVirtualMachine);
    Procedure __TXmlNodeSetAttributeNS(AMachine : TatVirtualMachine);
    Procedure __TXmlNodeTransformNode(AMachine : TatVirtualMachine);
    Procedure __GetTXmlNodeParentNode(AMachine : TatVirtualMachine);
    Procedure __GetTXmlNodeAttributes(AMachine : TatVirtualMachine);
    Procedure __SetTXmlNodeAttributes(AMachine : TatVirtualMachine);
    Procedure __GetTXmlNodeAttributeNodes(AMachine : TatVirtualMachine);
    Procedure __GetTXmlNodeChildNodes(AMachine : TatVirtualMachine);
    Procedure __GetTXmlNodeOwnerDocument(AMachine : TatVirtualMachine);
    Procedure __GetTXmlNodeHasChildNodes(AMachine : TatVirtualMachine);
    Procedure __GetTXmlNodeIsTextElement(AMachine : TatVirtualMachine);
    Procedure __GetTXmlNodeNodeName(AMachine : TatVirtualMachine);
    Procedure __GetTXmlNodeNodeType(AMachine : TatVirtualMachine);
    Procedure __GetTXmlNodeNodeValue(AMachine : TatVirtualMachine);
    Procedure __SetTXmlNodeNodeValue(AMachine : TatVirtualMachine);
    Procedure __GetTXmlNodeText(AMachine : TatVirtualMachine);
    Procedure __SetTXmlNodeText(AMachine : TatVirtualMachine);
    Procedure __GetTXmlNodeXml(AMachine : TatVirtualMachine);

    Procedure __TXMLNodeListFirst(AMachine: TatVirtualMachine);
    Procedure __TXMLNodeListLast(AMachine: TatVirtualMachine);
    Procedure __TXMLNodeListRemove(AMachine: TatVirtualMachine);
    Procedure __TXMLNodeListReplaceNode(AMachine: TatVirtualMachine);
    Procedure __TXMLNodeListDelete(AMachine: TatVirtualMachine);
    Procedure __TXMLNodeListFindNode(AMachine: TatVirtualMachine);
    Procedure __TXMLNodeListFindSibling(AMachine: TatVirtualMachine);
    Procedure __GetTXMLNodeListCount(AMachine : TatVirtualMachine);
    Procedure __GetTXMLNodeListNodes(AMachine : TatVirtualMachine);

    Procedure __TXmlDocumentCreate(AMachine  : TatVirtualMachine);
    Procedure __TXmlDocumentAddChild(AMachine : TatVirtualMachine);
    Procedure __TXMLDocumentLoadFromFile(AMachine : TatVirtualMachine);
    Procedure __TXMLDocumentSelectNode(AMachine : TatVirtualMachine);
    Procedure __TXMLDocumentSelectNodes(AMachine : TatVirtualMachine);
    Procedure __GetTXMLDocumentActive(AMachine : TatVirtualMachine);
    Procedure __SetTXMLDocumentActive(AMachine : TatVirtualMachine);
    Procedure __GetTXMLDocumentAsyncLoadState(AMachine : TatVirtualMachine);
    Procedure __GetTXMLDocumentChildNodes(AMachine : TatVirtualMachine);
    Procedure __GetTXMLDocumentDocumentElement(AMachine : TatVirtualMachine);
    Procedure __SetTXMLDocumentDocumentElement(AMachine : TatVirtualMachine);
    Procedure __GetTXMLDocumentDOMDocument(AMachine : TatVirtualMachine);
    Procedure __SetTXMLDocumentDOMDocument(AMachine : TatVirtualMachine);
    Procedure __GetTXMLDocumentEncoding(AMachine : TatVirtualMachine);
    Procedure __SetTXMLDocumentEncoding(AMachine : TatVirtualMachine);
    Procedure __GetTXMLDocumentFileName(AMachine : TatVirtualMachine);
    Procedure __SetTXMLDocumentFileName(AMachine : TatVirtualMachine);
    Procedure __GetTXMLDocumentModified(AMachine : TatVirtualMachine);
    Procedure __GetTXMLDocumentNode(AMachine : TatVirtualMachine);
    Procedure __GetTXMLDocumentNodeIndentStr(AMachine : TatVirtualMachine);
    Procedure __SetTXMLDocumentNodeIndentStr(AMachine : TatVirtualMachine);
    Procedure __GetTXMLDocumentOptions(AMachine : TatVirtualMachine);
    Procedure __SetTXMLDocumentOptions(AMachine : TatVirtualMachine);
    Procedure __GetTXMLDocumentParseOptions(AMachine : TatVirtualMachine);
    Procedure __SetTXMLDocumentParseOptions(AMachine : TatVirtualMachine);
    Procedure __GetTXMLDocumentSchemaRef(AMachine : TatVirtualMachine);
    Procedure __GetTXMLDocumentStandAlone(AMachine : TatVirtualMachine);
    Procedure __SetTXMLDocumentStandAlone(AMachine : TatVirtualMachine);
    Procedure __GetTXMLDocumentVersion(AMachine : TatVirtualMachine);
    Procedure __SetTXMLDocumentVersion(AMachine : TatVirtualMachine);
    Procedure __GetTXMLDocumentXML(AMachine : TatVirtualMachine);
    Procedure __SetTXMLDocumentXML(AMachine : TatVirtualMachine);

    Procedure __FormatXmlData(AMachine : TatVirtualMachine);
    Procedure __LoadXMLData(AMachine : TatVirtualMachine);
    Procedure __LoadXMLDocument(AMachine : TatVirtualMachine);
    Procedure __NewXMLDocument(AMachine : TatVirtualMachine);

    Procedure Init(); OverRide;
    Class Function LibraryName() : String; OverRide;

  End;

  TXmlNodeClass = Class Of TXmlNode;
  TXmlNodeListClass = Class Of TXmlNodeList;
  TXmlDocumentClass = Class Of TXmlDocument;

Implementation

Uses
  Dialogs, 
  Forms,  HsXmlDocEx,  HsInterfaceEx,  SysUtils,  XmlDom;

Type
  TXmlNodeHack = Class(TXmlNode);
  TXMLNodeListHack = Class(TXMLNodeList);
  TXmlDocumentHack = Class(TXMLDocument)
  Private
    FLstNodes : IXmlNodeList;

  Public
    Procedure AddNodeToDestroy(Const ANode : IXmlNode);
    Destructor Destroy(); OverRide;

  End;

Destructor TXmlDocumentHack.Destroy();
Begin
  FLstNodes := Nil;

  InHerited Destroy();
End;

Procedure TXmlDocumentHack.AddNodeToDestroy(Const ANode : IXmlNode);
Begin
  If Not Assigned(FLstNodes) Then
    FLstNodes := TXmlNodeList.Create((DocumentElement As IXmlNodeAccess).GetNodeObject(),  '',  Nil);
  FLstNodes.Add(ANode);
End;

Procedure TatXmlDocClsLibrary.__TXmlNodeAddChild(AMachine: TatVirtualMachine);
Var lIRetVal : IXmlNode;
    lSelect  : IXmlNodeAccess;
Begin
  With AMachine Do
  Begin
    Case InputArgCount Of
      1 : lIRetVal := TXmlNodeHack(CurrentObject).AddChild(VarToStr(GetInputArg(0)));
      2 : lIRetVal := TXmlNodeHack(CurrentObject).AddChild(VarToStr(GetInputArg(0)), VarToInteger(GetInputArg(1)));
    End;

    If Supports(lIRetVal,  IXmlNodeAccess,  lSelect) Then
      ReturnOutputArg(ObjectToVar(lSelect.GetNodeObject()));
  End;
End;

Procedure TatXmlDocClsLibrary.__TXmlNodeCloneNode(AMachine: TatVirtualMachine);
Var lIRetVal : IXmlNode;
    lSelect  : IXmlNodeAccess;
Begin
  With AMachine Do
  Begin
    lIRetVal := TXmlNodeHack(CurrentObject).CloneNode(GetInputArg(0));
    If Supports(lIRetVal,  IXmlNodeAccess,  lSelect) Then
      ReturnOutputArg(ObjectToVar(lSelect.GetNodeObject()));
  End;
End;

Procedure TatXmlDocClsLibrary.__TXmlNodeHasAttribute(AMachine: TatVirtualMachine);
Var AResult : Variant;
Begin
  With AMachine Do
  Begin
    AResult := TXmlNodeHack(CurrentObject).HasAttribute(VarToStr(GetInputArg(0)));
    ReturnOutputArg(AResult);
  End;
End;

Procedure TatXmlDocClsLibrary.__TXmlNodeNextSibling(AMachine: TatVirtualMachine);
Var lIRetVal : IXmlNode;
    lSelect  : IXmlNodeAccess;
Begin
  With AMachine Do
  Begin
    lIRetVal := TXmlNodeHack(CurrentObject).NextSibling;
    If Supports(lIRetVal,  IXmlNodeAccess,  lSelect) Then
      ReturnOutputArg(ObjectToVar(lSelect.GetNodeObject()));
  End;
End;

Procedure TatXmlDocClsLibrary.__TXmlNodeNormalize(AMachine: TatVirtualMachine);
Begin
  With AMachine Do
  Begin
    TXmlNodeHack(CurrentObject).Normalize;
  End;
End;

Procedure TatXmlDocClsLibrary.__TXmlNodePreviousSibling(AMachine: TatVirtualMachine);
Var lIRetVal : IXmlNode;
    lSelect  : IXmlNodeAccess;
Begin
  With AMachine Do
  Begin
    lIRetVal := TXmlNodeHack(CurrentObject).PreviousSibling;
    If Supports(lIRetVal,  IXmlNodeAccess,  lSelect) Then
      ReturnOutputArg(ObjectToVar(lSelect.GetNodeObject()));
  End;
End;

Procedure TatXmlDocClsLibrary.__TXmlNodeResync(AMachine: TatVirtualMachine);
Begin
  With AMachine Do
  Begin
    TXmlNodeHack(CurrentObject).Resync;
  End;
End;

Procedure TatXmlDocClsLibrary.__TXmlNodeSetAttributeNS(AMachine: TatVirtualMachine);
Begin
  With AMachine Do
  Begin
    TXmlNodeHack(CurrentObject).SetAttributeNS(VarToStr(GetInputArg(0)), VarToStr(GetInputArg(1)), GetInputArg(2));
  End;
End;

Procedure TatXmlDocClsLibrary.__TXmlNodeTransformNode(AMachine: TatVirtualMachine);
Var
  Param1: Widestring;
Begin
  With AMachine Do
  Begin
    Param1 := GetInputArg(1);
    TXmlNodeHack(CurrentObject).TransformNode(TXmlNode(VarToObject(GetInputArg(0))), Param1);
    SetInputArg(1, Param1);
  End;
End;
  
Procedure TatXmlDocClsLibrary.__GetTXmlNodeAttributeNodes(AMachine: TatVirtualMachine);
Var lIAttributeNodes : IXmlNodeList;
    lCAttributeNodes : TObject;
Begin
  With AMachine Do
  Begin
    lIAttributeNodes := TXmlNodeHack(CurrentObject).AttributeNodes;
    If GetImplementingObject(lIAttributeNodes,  lCAttributeNodes) Then
      ReturnOutputArg(ObjectToVar(lCAttributeNodes));
  End;
End;

Procedure TatXmlDocClsLibrary.__GetTXmlNodeAttributes(AMachine: TatVirtualMachine);
Begin
  With AMachine Do
  Begin
    ReturnOutputArg(TXmlNodeHack(CurrentObject).GetAttribute(VarToStr(GetArrayIndex(0))));
  End;
End;

Procedure TatXmlDocClsLibrary.__SetTXmlNodeAttributes(AMachine: TatVirtualMachine);
Begin
  With AMachine Do
  Begin
    TXmlNodeHack(CurrentObject).SetAttribute(VarToStr(GetArrayIndex(0)), GetInputArg(0));
  End;
End;

Procedure TatXmlDocClsLibrary.__GetTXmlNodeParentNode(AMachine: TatVirtualMachine);
Var lCurNode : TXmlNodeHack;
    lRetVal  : TXmlNode;
Begin
  lRetVal := Nil;

  With AMachine Do
  Begin
    lCurNode := TXmlNodeHack(CurrentObject);
    If Not Assigned(lCurNode.ParentNode) Then
    Begin
      If Assigned(lCurNode.DomNode.parentNode) Then
      Begin
        lRetVal := TXmlNode.Create(lCurNode.DomNode.parentNode, Nil, lCurNode.OwnerDocument);
        lCurNode.SetParentNode(lRetVal);
        TXmlDocumentHack(lCurNode.OwnerDocument).AddNodeToDestroy(lRetVal);
      End;
    End
    Else
      lRetVal := lCurNode.ParentNode;

    ReturnOutputArg(ObjectToVar(lRetVal));
  End;
End;

Procedure TatXmlDocClsLibrary.__GetTXmlNodeChildNodes(AMachine: TatVirtualMachine);
Var lIChildNodes : IXmlNodeList;
    lCChildNodes : TObject;
Begin
  With AMachine Do
  Begin
    lIChildNodes := TXmlNodeHack(CurrentObject).ChildNodes;
    If GetImplementingObject(lIChildNodes, lCChildNodes) Then
      ReturnOutputArg(ObjectToVar(lCChildNodes));
  End;
End;

Procedure TatXmlDocClsLibrary.__GetTXmlNodeOwnerDocument(AMachine: TatVirtualMachine);
Var lDocAccess : IXMLDocumentAccess;
Begin
  With AMachine Do
  Begin
    If Supports(TXmlNodeHack(CurrentObject).OwnerDocument,  IXMLDocumentAccess,  lDocAccess) Then
      ReturnOutputArg(ObjectToVar(lDocAccess.DocumentObject));
  End;
End;

Procedure TatXmlDocClsLibrary.__GetTXmlNodeHasChildNodes(AMachine: TatVirtualMachine);
Begin
  With AMachine Do
  Begin
    ReturnOutputArg(TXmlNodeHack(CurrentObject).GetHasChildNodes());
  End;
End;

Procedure TatXmlDocClsLibrary.__GetTXmlNodeIsTextElement(AMachine: TatVirtualMachine);
Begin
  With AMachine Do
  Begin
    ReturnOutputArg(TXmlNodeHack(CurrentObject).GetIsTextElement());
  End;
End;

Procedure TatXmlDocClsLibrary.__GetTXmlNodeNodeName(AMachine: TatVirtualMachine);
Begin
  With AMachine Do
  Begin
    ReturnOutputArg(TXmlNodeHack(CurrentObject).GetNodeName());
  End;
End;

Procedure TatXmlDocClsLibrary.__GetTXmlNodeNodeType(AMachine: TatVirtualMachine);
Begin
  With AMachine Do
  Begin
    ReturnOutputArg(Integer(TXmlNodeHack(CurrentObject).GetNodeType()));
  End;
End;

Procedure TatXmlDocClsLibrary.__GetTXmlNodeNodeValue(AMachine: TatVirtualMachine);
Begin
  With AMachine Do
  Begin
    ReturnOutputArg(TXmlNodeHack(CurrentObject).GetNodeValue());
  End;
End;

Procedure TatXmlDocClsLibrary.__SetTXmlNodeNodeValue(AMachine: TatVirtualMachine);
Begin
  With AMachine Do
  Begin
    TXmlNodeHack(CurrentObject).SetNodeValue(GetInputArg(0));
  End;
End;

Procedure TatXmlDocClsLibrary.__GetTXmlNodeText(AMachine: TatVirtualMachine);
Begin
  With AMachine Do
  Begin
    ReturnOutputArg(TXmlNodeHack(CurrentObject).GetText());
  End;
End;

Procedure TatXmlDocClsLibrary.__SetTXmlNodeText(AMachine: TatVirtualMachine);
Begin
  With AMachine Do
  Begin
    TXmlNodeHack(CurrentObject).SetText(GetInputArg(0));
  End;
End;

Procedure TatXmlDocClsLibrary.__GetTXmlNodeXml(AMachine: TatVirtualMachine);
Begin
  With AMachine Do
  Begin
    ReturnOutputArg(TXmlNodeHack(CurrentObject).GetXml());
  End;
End;

Procedure TatXmlDocClsLibrary.__TXMLNodeListFirst(AMachine: TatVirtualMachine);
Var AResult: Variant;
Begin
  With AMachine Do
  Begin
    AResult := ObjectToVar((TXMLNodeListHack(CurrentObject).First() As IXmlNodeAccess).GetNodeObject());
    ReturnOutputArg(AResult);
  End;
End;

Procedure TatXmlDocClsLibrary.__TXMLNodeListLast(AMachine: TatVirtualMachine);
Var AResult: Variant;
Begin
  With AMachine Do
  Begin
    AResult := ObjectToVar((TXMLNodeListHack(CurrentObject).Last() As IXmlNodeAccess).GetNodeObject());
    ReturnOutputArg(AResult);
  End;
End;

Procedure TatXmlDocClsLibrary.__TXMLNodeListRemove(AMachine: TatVirtualMachine);
Var AResult: Variant;
Begin
  With AMachine Do
  Begin
    AResult := Integer(TXMLNodeListHack(CurrentObject).Remove(TXmlNode(GetInputArgAsObject(0)) As IXmlNode));
    ReturnOutputArg(AResult);
  End;
End;

Procedure TatXmlDocClsLibrary.__TXMLNodeListReplaceNode(AMachine: TatVirtualMachine);
Var AResult: Variant;
Begin
  With AMachine Do
  Begin
    AResult := ObjectToVar((TXMLNodeListHack(CurrentObject).ReplaceNode((TXmlNode(GetInputArgAsObject(0)) As IXmlNode), (TXmlNode(GetInputArgAsObject(1)) As IXmlNode)) As IXmlNodeAccess).GetNodeObject());
    ReturnOutputArg(AResult);
  End;
End;

Procedure TatXmlDocClsLibrary.__TXMLNodeListDelete(AMachine: TatVirtualMachine);
Var AResult: Variant;
Begin
  With AMachine Do
  Begin
    AResult := Integer(TXMLNodeListHack(CurrentObject).Delete(GetInputArgAsInteger(0)));
    ReturnOutputArg(AResult);
  End;
End;

Procedure TatXmlDocClsLibrary.__TXMLNodeListFindNode(AMachine: TatVirtualMachine);
Var AResult: Variant;
Begin
  With AMachine Do
  Begin
    Case InputArgCount Of
      1 : AResult := ObjectToVar((TXMLNodeListHack(CurrentObject).FindNode(GetInputArg(0)) As IXmlNodeAccess).GetNodeObject());
      2 : AResult := ObjectToVar((TXMLNodeListHack(CurrentObject).FindNode(GetInputArg(0), GetInputArg(1)) As IXmlNodeAccess).GetNodeObject());
    End;

    ReturnOutputArg(AResult);
  End;
End;

Procedure TatXmlDocClsLibrary.__TXMLNodeListFindSibling(AMachine: TatVirtualMachine);
Var AResult: Variant;
Begin
  With AMachine Do
  Begin
    AResult := ObjectToVar((TXMLNodeListHack(CurrentObject).FindSibling((TXmlNode(GetInputArgAsObject(0)) As IXmlNode), GetInputArgAsInteger(1)) As IXmlNodeAccess).GetNodeObject());
    ReturnOutputArg(AResult);
  End;
End;

Procedure TatXmlDocClsLibrary.__GetTXMLNodeListCount(AMachine: TatVirtualMachine);
Begin
  With AMachine Do
  Begin
    ReturnOutputArg(Integer(TXMLNodeListHack(CurrentObject).Count));
  End;
End;

Procedure TatXmlDocClsLibrary.__GetTXMLNodeListNodes(AMachine: TatVirtualMachine);
Var lXmlNode : IXMLNodeAccess;
Begin
  With AMachine Do
  Begin
    If Supports(TXMLNodeListHack(CurrentObject).GetNode(GetArrayIndex(0)),  IXMLNodeAccess,  lXmlNode) Then
      ReturnOutputArg(ObjectToVar(lXmlNode.GetNodeObject()));
  End;
End;

Procedure TatXmlDocClsLibrary.__GetTXMLDocumentActive(AMachine: TatVirtualMachine);
Begin
  With AMachine Do
  Begin
    ReturnOutputArg(TXMLDocument(CurrentObject).Active);
  End;
End;

Procedure TatXmlDocClsLibrary.__SetTXMLDocumentActive(AMachine: TatVirtualMachine);
Begin
  With AMachine Do
  Begin
    TXMLDocument(CurrentObject).Active := GetInputArg(0);
  End;
End;

Procedure TatXmlDocClsLibrary.__GetTXMLDocumentAsyncLoadState(AMachine: TatVirtualMachine);
Begin
  With AMachine Do
  Begin
    ReturnOutputArg(Integer(TXMLDocument(CurrentObject).AsyncLoadState));
  End;
End;

Procedure TatXmlDocClsLibrary.__GetTXMLDocumentChildNodes(AMachine: TatVirtualMachine);
Var lIChildNodes : IXmlNodeList;
    lCChildNodes : TObject;
Begin
  With AMachine Do
  Begin
    lIChildNodes := TXMLDocument(CurrentObject).ChildNodes;
    If GetImplementingObject(lIChildNodes, lCChildNodes) Then
      ReturnOutputArg(ObjectToVar(lCChildNodes));
  End;
End;

Procedure TatXmlDocClsLibrary.__GetTXMLDocumentDocumentElement(AMachine: TatVirtualMachine);
Var lXmlNode : IXMLNodeAccess; 
Begin
  With AMachine Do
  Begin
    If Supports(TXMLDocument(CurrentObject).DocumentElement, IXMLNodeAccess, lXmlNode) Then
      ReturnOutputArg(ObjectToVar(lXmlNode.GetNodeObject()));
  End;
End;

Procedure TatXmlDocClsLibrary.__SetTXMLDocumentDocumentElement(AMachine: TatVirtualMachine);
Begin
  With AMachine Do
  Begin
    TXMLDocument(CurrentObject).DocumentElement := TXmlNode(VarToObject(GetInputArg(0)));
  End;
End;

Procedure TatXmlDocClsLibrary.__GetTXMLDocumentDOMDocument(AMachine: TatVirtualMachine);
Begin
{  With AMachine Do
  Begin
    ReturnOutputArg(TXMLDocument(CurrentObject).DOMDocument);
  End;}
End;

Procedure TatXmlDocClsLibrary.__SetTXMLDocumentDOMDocument(AMachine: TatVirtualMachine);
Begin
{  With AMachine Do
  Begin
    TXMLDocument(CurrentObject).DOMDocument:=GetInputArg(0);
  End;}
End;

Procedure TatXmlDocClsLibrary.__GetTXMLDocumentEncoding(AMachine: TatVirtualMachine);
Begin
  With AMachine Do
  Begin
    ReturnOutputArg(TXMLDocument(CurrentObject).Encoding);
  End;
End;

Procedure TatXmlDocClsLibrary.__SetTXMLDocumentEncoding(AMachine: TatVirtualMachine);
Begin
  With AMachine Do
  Begin
    TXMLDocument(CurrentObject).Encoding := GetInputArg(0);
  End;
End;

Procedure TatXmlDocClsLibrary.__GetTXMLDocumentFileName(AMachine: TatVirtualMachine);
Begin
  With AMachine Do
  Begin
    ReturnOutputArg(TXMLDocument(CurrentObject).FileName);
  End;
End;

Procedure TatXmlDocClsLibrary.__SetTXMLDocumentFileName(AMachine: TatVirtualMachine);
Begin
  With AMachine Do
  Begin
    TXMLDocument(CurrentObject).FileName := GetInputArg(0);
  End;
End;

Procedure TatXmlDocClsLibrary.__GetTXMLDocumentModified(AMachine: TatVirtualMachine);
Begin
  With AMachine Do
  Begin
    ReturnOutputArg(TXMLDocument(CurrentObject).Modified);
  End;
End;

Procedure TatXmlDocClsLibrary.__GetTXMLDocumentNode(AMachine: TatVirtualMachine);
Var lXmlNode : IXMLNodeAccess;
Begin
  With AMachine Do
  Begin
    If Supports(TXMLDocument(CurrentObject).Node, IXMLNodeAccess, lXmlNode) Then
      ReturnOutputArg(ObjectToVar(lXmlNode.GetNodeObject()));
  End;
End;

Procedure TatXmlDocClsLibrary.__GetTXMLDocumentNodeIndentStr(AMachine: TatVirtualMachine);
Begin
  With AMachine Do
  Begin
    ReturnOutputArg(TXMLDocument(CurrentObject).NodeIndentStr);
  End;
End;

Procedure TatXmlDocClsLibrary.__SetTXMLDocumentNodeIndentStr(AMachine: TatVirtualMachine);
Begin
  With AMachine Do
  Begin
    TXMLDocument(CurrentObject).NodeIndentStr := GetInputArg(0);
  End;
End;

Procedure TatXmlDocClsLibrary.__GetTXMLDocumentOptions(AMachine: TatVirtualMachine);
Var
  PropValueSet: TXMLDocOptions;
Begin
  With AMachine Do
  Begin
    PropValueSet := TXMLDocument(CurrentObject).Options;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  End;
End;

Procedure TatXmlDocClsLibrary.__SetTXMLDocumentOptions(AMachine: TatVirtualMachine);
Var
  TempVar: TXMLDocOptions;
Begin
  With AMachine Do
  Begin
    IntToSet(TempVar, VarToInteger(GetInputArg(0)), SizeOf(TempVar));
    TXMLDocument(CurrentObject).Options:=TempVar;
  End;
End;

Procedure TatXmlDocClsLibrary.__GetTXMLDocumentParseOptions(AMachine: TatVirtualMachine);
Var
  PropValueSet: TParseOptions;
Begin
  With AMachine Do
  Begin
    PropValueSet := TXMLDocument(CurrentObject).ParseOptions;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  End;
End;

Procedure TatXmlDocClsLibrary.__SetTXMLDocumentParseOptions(AMachine: TatVirtualMachine);
Var
  TempVar: TParseOptions;
Begin
  With AMachine Do
  Begin
    IntToSet(TempVar, VarToInteger(GetInputArg(0)), SizeOf(TempVar));
    TXMLDocument(CurrentObject).ParseOptions:=TempVar;
  End;
End;

Procedure TatXmlDocClsLibrary.__GetTXMLDocumentSchemaRef(AMachine: TatVirtualMachine);
Begin
  With AMachine Do
  Begin
    ReturnOutputArg(TXMLDocument(CurrentObject).SchemaRef);
  End;
End;

Procedure TatXmlDocClsLibrary.__GetTXMLDocumentStandAlone(AMachine: TatVirtualMachine);
Begin
  With AMachine Do
  Begin
    ReturnOutputArg(TXMLDocument(CurrentObject).StandAlone);
  End;
End;

Procedure TatXmlDocClsLibrary.__SetTXMLDocumentStandAlone(AMachine: TatVirtualMachine);
Begin
  With AMachine Do
  Begin
    TXMLDocument(CurrentObject).StandAlone := GetInputArg(0);
  End;
End;

Procedure TatXmlDocClsLibrary.__GetTXMLDocumentVersion(AMachine: TatVirtualMachine);
Begin
  With AMachine Do
  Begin
    ReturnOutputArg(TXMLDocument(CurrentObject).Version);
  End;
End;

Procedure TatXmlDocClsLibrary.__SetTXMLDocumentVersion(AMachine: TatVirtualMachine);
Begin
  With AMachine Do
  Begin
    TXMLDocument(CurrentObject).Version := GetInputArg(0);
  End;
End;

Procedure TatXmlDocClsLibrary.__GetTXMLDocumentXML(AMachine: TatVirtualMachine);
Begin
  With AMachine Do
  Begin
    ReturnOutputArg(ObjectToVar(TXMLDocument(CurrentObject).XML));
  End;
End;

Procedure TatXmlDocClsLibrary.__SetTXMLDocumentXML(AMachine: TatVirtualMachine);
Begin
  With AMachine Do
  Begin
    TXMLDocument(CurrentObject).XML := TStringList(GetInputArgAsObject(0));
  End;
End;

Procedure TatXmlDocClsLibrary.__TXmlDocumentCreate(AMachine : TatVirtualMachine);
Var AResult : Variant;
Begin
  With AMachine do
  Begin
    AResult := ObjectToVar(TXmlDocumentHack.Create(Application));
    ReturnOutputArg(AResult);
  End;
End;

Procedure TatXmlDocClsLibrary.__TXmlDocumentAddChild(AMachine: TatVirtualMachine);
Var lIRetVal : IXmlNode;
    lSelect  : IXmlNodeAccess;
Begin
  With AMachine Do
  Begin
    lIRetVal := TXMLDocument(CurrentObject).AddChild(VarToStr(GetInputArg(0)));

    If Supports(lIRetVal, IXmlNodeAccess, lSelect) Then
      ReturnOutputArg(ObjectToVar(lSelect.GetNodeObject()));
  End;
End;

Procedure TatXmlDocClsLibrary.__TXMLDocumentLoadFromFile(AMachine: TatVirtualMachine);
Begin
  With AMachine Do
  Begin
    TXMLDocument(CurrentObject).LoadFromFile(GetInputArg(0));
    TXMLDocument(CurrentObject).Active := True;
  End;
End;

Function TatXmlDocClsLibrary.InternalSelectNodes(AXmlDocument : TXmlDocument; Const AXPathQuery : String; ARoot : IXmlNode) : TXmlNodeList;
Var intfSelect : IDomNodeSelect;
    intfAccess : IXmlNodeAccess;
    dnlResult  : IDomNodeList;
    X          : Integer;
Begin
  Result := Nil;

  If Not Assigned(ARoot) Then
    ARoot := AXmlDocument.DocumentElement;

  If Supports(ARoot, IXmlNodeAccess, intfAccess) And
    Supports(ARoot.DOMNode, IDomNodeSelect, intfSelect) Then
  Begin
    dnlResult := intfSelect.SelectNodes(AXPathQuery);

    If Assigned(dnlResult) Then
    Begin
      Result := TXmlNodeList.Create(intfAccess.GetNodeObject, '', Nil);

      For X := 0 To dnlResult.Length - 1 Do
        TXmlNodeListHack(Result).Add(TXmlNode.Create(dnlResult.Item[X], Nil, AXmlDocument));
    End;
  End;
End;

Procedure TatXmlDocClsLibrary.__TXMLDocumentSelectNode(AMachine: TatVirtualMachine);
Var lRetVal    : TXMLNodeList;
    lXPath     : String;
    lStartNode : TXMLNode;
    lXmlNode   : IXMLNodeAccess;
Begin
  With AMachine Do
  Begin
    lXPath := VarToStr(GetInputArg(0));
    If InputArgCount = 2 Then
      lStartNode := TXmlNode(GetInputArgAsObject(1))
    Else
      lStartNode := Nil;

    lRetVal := InternalSelectNodes(TXmlDocument(CurrentObject), lXPath, lStartNode);
    If Assigned(lRetVal) Then
      Try
        If TXMLNodeListHack(lRetVal).Count > 0 Then
        Begin
          If Supports(TXMLNodeListHack(lRetVal).GetNode(0), IXMLNodeAccess, lXmlNode) Then
            ReturnOutputArg(ObjectToVar(lXmlNode.GetNodeObject()))
          Else
            ReturnOutputArg(ObjectToVar(Nil));
        End
        Else
          ReturnOutputArg(ObjectToVar(Nil));

        Finally
          lRetVal.Free();
      End;
  End;
End;

Procedure TatXmlDocClsLibrary.__TXMLDocumentSelectNodes(AMachine: TatVirtualMachine);
Var lRetVal    : TXMLNodeList;
    lXPath     : String;
    lStartNode : TXMLNode;
    lXmlDoc    : TXmlDocument;
Begin
  With AMachine Do
  Begin
    lXPath := VarToStr(GetInputArg(0));
    If InputArgCount = 2 Then
      lStartNode := TXmlNode(GetInputArgAsObject(1))
    Else
      lStartNode := Nil;

    lXmlDoc := TXmlDocument(CurrentObject);
    lRetVal := InternalSelectNodes(lXmlDoc, lXPath, lStartNode);
    ReturnOutputArg(ObjectToVar(lRetVal));
  End;
End;

Procedure TatXmlDocClsLibrary.__FormatXmlData(AMachine: TatVirtualMachine);
Var AResult : Variant;
Begin
  With AMachine Do
  Begin
    AResult := HsXmlDocEx.FormatXMLData(GetInputArg(0), VarToStr(GetInputArg(1)));
    ReturnOutputArg(AResult);
  End;
End;

Procedure TatXmlDocClsLibrary.__LoadXMLData(AMachine : TatVirtualMachine);
Var lRetVal : TXmlDocumentHack;
Begin
  lRetVal := TXmlDocumentHack.Create(Application);
  With AMachine do
  Begin
    lRetVal.LoadFromXML(GetInputArg(0));
    ReturnOutputArg(ObjectToVar(lRetVal));
  End;
End;

Procedure TatXmlDocClsLibrary.__LoadXMLDocument(AMachine : TatVirtualMachine);
Var lRetVal : TXmlDocumentHack;
Begin
  lRetVal := TXmlDocumentHack.Create(Application);
  With AMachine Do
  Begin
    lRetVal.LoadFromFile(GetInputArg(0));
    ReturnOutputArg(ObjectToVar(lRetVal));
  End;
End;

Procedure TatXmlDocClsLibrary.__NewXMLDocument(AMachine : TatVirtualMachine);
Var lRetVal : TXmlDocumentHack;
Begin
  lRetVal := TXmlDocumentHack.Create(Application);
  lRetVal.Active := True;

  With AMachine Do
  Begin
    Case InputArgCount Of
      0 : lRetVal.Version := '1.0';
      1 : lRetVal.Version := GetInputArg(0);
    End;

    ReturnOutputArg(ObjectToVar(lRetVal));
  End;
End;

Procedure TatXmlDocClsLibrary.Init;
Begin
  With Scripter.DefineClass(TXmlNode) Do
  Begin
    DefineMethod('AddChild', 2, tkClass, TXmlNode, __TXmlNodeAddChild, False, 1, 'TagName: String; Index: Integer = -1');
    DefineMethod('CloneNode', 1, tkClass, TXmlNode, __TXmlNodeCloneNode, False, 0, 'Deep: Boolean');
    DefineMethod('HasAttribute', 1, tkVariant, Nil, __TXmlNodeHasAttribute, False, 0, 'Name: String');
    DefineMethod('NextSibling', 0, tkClass, TXmlNode, __TXmlNodeNextSibling, False, 0, '');
    DefineMethod('Normalize', 0, tkNone, Nil, __TXmlNodeNormalize, False, 0, '');
    DefineMethod('PreviousSibling', 0, tkClass, TXmlNode, __TXmlNodePreviousSibling, False, 0, '');
    DefineMethod('Resync', 0, tkNone, Nil, __TXmlNodeResync, False, 0, '');
    DefineMethod('SetAttributeNS', 3, tkNone, Nil, __TXmlNodeSetAttributeNS, False, 0, 'AttrName: String; NamespaceURI: String; Value: Olevariant');
    DefineMethod('TransformNode', 2, tkNone, Nil, __TXmlNodeTransformNode, False, 0, 'stylesheet: TXMLNode; output: Widestring').SetVarArgs([1]);

    DefineProp('Attributes', tkVariant, __GetTXmlNodeAttributes, __SetTXmlNodeAttributes, Nil, False, 1);    
    DefineProp('AttributeNodes', tkClass, __GetTXmlNodeAttributeNodes, Nil, TXMLNodeList, False, 0);
    DefineProp('ParentNode', tkClass, __GetTXmlNodeParentNode, Nil, TXmlNode, False, 0);
    DefineProp('ChildNodes', tkClass, __GetTXmlNodeChildNodes, Nil, TXMLNodeList, False, 0);
    DefineProp('OwnerDocument', tkClass, __GetTXmlNodeOwnerDocument, Nil, TXMLDocument, False, 0);
    DefineProp('HasChildNodes', tkVariant, __GetTXmlNodeHasChildNodes, Nil, Nil, False, 0);
    DefineProp('IsTextElement', tkVariant, __GetTXmlNodeIsTextElement, Nil, Nil, False, 0);
    DefineProp('NodeName', tkVariant, __GetTXmlNodeNodeName, Nil, Nil, False, 0);
    DefineProp('NodeType', tkEnumeration, __GetTXmlNodeNodeType, Nil, Nil, False, 0);
    DefineProp('NodeValue', tkVariant, __GetTXmlNodeNodeValue, __SetTXmlNodeNodeValue, Nil, False, 0);
    DefineProp('Text', tkWString, __GetTXmlNodeText, __SetTXmlNodeText, Nil, False, 0);
    DefineProp('Xml', tkWString, __GetTXmlNodeXml, Nil, Nil, False, 0);
  End;

  With Scripter.DefineClass(TXMLNodeList) Do
  Begin
    DefineMethod('First', 0, tkClass, TXmlNode, __TXMLNodeListFirst, False, 0, '');
    DefineMethod('Last', 0, tkClass, TXmlNode, __TXMLNodeListLast, False, 0, '');
    DefineMethod('Remove', 1, tkInteger, Nil, __TXMLNodeListRemove, False, 0, 'Node : TXMLNode');
    DefineMethod('ReplaceNode', 2, tkClass, TXmlNode, __TXMLNodeListReplaceNode, False, 0, 'OldNode : TXMLNode; NewNode : TXMLNode');
    DefineMethod('Delete', 1, tkInteger, Nil, __TXMLNodeListDelete, False, 0, 'Index : Integer');
    DefineMethod('FindNode', 2, tkClass, TXmlNode, __TXMLNodeListFindNode, False, 1, 'NodeName : WideString; NamespaceURI : WideString = ''''');
    DefineMethod('FindSibling', 2, tkClass, TXmlNode, __TXMLNodeListFindSibling, False, 0, 'Node : TXMLNode; Delta : Integer');

    DefineProp('Count', tkInteger, __GetTXMLNodeListCount, Nil, Nil, False, 0);
    DefaultProperty := DefineProp('Nodes', tkClass, __GetTXMLNodeListNodes, Nil, TXmlNode, False, 1);
  End;

  With Scripter.DefineClass(TXMLDocument) Do
  Begin
    DefineProp('Active', tkVariant, __GetTXMLDocumentActive, __SetTXMLDocumentActive, Nil, False, 0);
    DefineProp('AsyncLoadState', tkInteger, __GetTXMLDocumentAsyncLoadState, Nil, Nil, False, 0);
    DefineProp('ChildNodes', tkClass, __GetTXMLDocumentChildNodes, Nil, TXMLNodeList, False, 0);
    DefineProp('DocumentElement', tkClass, __GetTXMLDocumentDocumentElement, __SetTXMLDocumentDocumentElement, TXmlNode, False, 0);
    DefineProp('DOMDocument', tkVariant, __GetTXMLDocumentDOMDocument, __SetTXMLDocumentDOMDocument, Nil, False, 0);
    DefineProp('Encoding', tkVariant, __GetTXMLDocumentEncoding, __SetTXMLDocumentEncoding, Nil, False, 0);
    DefineProp('FileName', tkWString, __GetTXMLDocumentFileName, __SetTXMLDocumentFileName, Nil, False, 0);
    DefineProp('Modified', tkVariant, __GetTXMLDocumentModified, Nil, Nil, False, 0);
    DefineProp('Node', tkClass, __GetTXMLDocumentNode, Nil, TXmlNode, False, 0);
    DefineProp('NodeIndentStr', tkVariant, __GetTXMLDocumentNodeIndentStr, __SetTXMLDocumentNodeIndentStr, Nil, False, 0);
    DefineProp('Options', tkInteger, __GetTXMLDocumentOptions, __SetTXMLDocumentOptions, Nil, False, 0);
    DefineProp('ParseOptions', tkInteger, __GetTXMLDocumentParseOptions, __SetTXMLDocumentParseOptions, Nil, False, 0);
    DefineProp('SchemaRef', tkVariant, __GetTXMLDocumentSchemaRef, Nil, Nil, False, 0);
    DefineProp('StandAlone', tkVariant, __GetTXMLDocumentStandAlone, __SetTXMLDocumentStandAlone, Nil, False, 0);
    DefineProp('Version', tkVariant, __GetTXMLDocumentVersion, __SetTXMLDocumentVersion, Nil, False, 0);
    DefineProp('XML', tkClass, __GetTXMLDocumentXML, __SetTXMLDocumentXML, TStringList, False, 0);

    DefineMethod('Create', 0, tkClass, TXmlDocument, __TXmlDocumentCreate, true, 0, '');
    DefineMethod('AddChild', 1, tkClass, TXmlNode, __TXmlDocumentAddChild, false, 1, 'TagName : String');
    DefineMethod('LoadFromFile', 1, tkVariant, Nil, __TXMLDocumentLoadFromFile, False, 0, 'Const AFileName : WideString');
    DefineMethod('SelectNode', 2, tkClass, TXmlNode, __TXMLDocumentSelectNode, False, 1, 'ANodePath : Widestring; ARoot : TXmlNode = Nil');
    DefineMethod('SelectNodes', 2, tkClass, TXMLNodeList, __TXMLDocumentSelectNodes, False, 1, 'ANodePath : Widestring; ARoot : TXmlNode = Nil');
  End;

  With Scripter.DefineClass(ClassType) Do
  Begin
    DefineMethod('FormatXmlData', 2, tkVariant, Nil, __FormatXmlData, False, 0, 'AXml : WideString; AIndentStr : String');
    DefineMethod('LoadXmlData', 1, tkClass, TXMLDocument, __LoadXMLData, false, 0, 'AXmlData : Widestring');
    DefineMethod('LoadXmlDocument', 1, tkClass, TXMLDocument, __LoadXMLDocument, false, 0, 'FileName : Widestring');
    DefineMethod('NewXmlDocument', 1, tkClass, TXMLDocument, __NewXMLDocument, false, 1, 'Version : Widestring = ''1.0''');

    AddConstant('ntReserved', ntReserved);
    AddConstant('ntElement', ntElement);
    AddConstant('ntAttribute', ntAttribute);
    AddConstant('ntText', ntText);
    AddConstant('ntCData', ntCData);
    AddConstant('ntEntityRef', ntEntityRef);
    AddConstant('ntEntity', ntEntity);
    AddConstant('ntProcessingInstr', ntProcessingInstr);
    AddConstant('ntComment', ntComment);
    AddConstant('ntDocument', ntDocument);
    AddConstant('ntDocType', ntDocType);
    AddConstant('ntDocFragment', ntDocFragment);
    AddConstant('ntNotation', ntNotation);    
    AddConstant('doNodeAutoCreate', doNodeAutoCreate);
    AddConstant('doNodeAutoIndent', doNodeAutoIndent);
    AddConstant('doAttrNull', doAttrNull);
    AddConstant('doAutoPrefix', doAutoPrefix);
    AddConstant('doNamespaceDecl', doNamespaceDecl);
    AddConstant('doAutoSave', doAutoSave);
    AddConstant('poResolveExternals', poResolveExternals);
    AddConstant('poValidateOnParse', poValidateOnParse);
    AddConstant('poPreserveWhiteSpace', poPreserveWhiteSpace);
    AddConstant('poAsyncLoad', poAsyncLoad);
  End;
End;

Class Function TatXmlDocClsLibrary.LibraryName: String;
Begin
  Result := 'XmlDoc';
End;

Initialization
  RegisterScripterLibrary(TatXmlDocClsLibrary, True);

{$WARNINGS ON}

End.

