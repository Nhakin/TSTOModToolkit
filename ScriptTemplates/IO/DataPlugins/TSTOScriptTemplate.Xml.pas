unit TSTOScriptTemplate.Xml;

interface

uses xmldom, XMLDoc, XMLIntf, HsXmlDocEx, HsInterfaceEx;

type
  ITSTOXmlScriptTemplateSettings = Interface(IXmlNodeEx)
    ['{4B61686E-29A0-2112-922B-480A3EEAE7A5}']
    Function  GetOutputFileName() : WideString;
    Procedure SetOutputFileName(Const AOutputFileName : WideString);

    Function  GetCategoryNamePrefix() : WideString;
    Procedure SetCategoryNamePrefix(Const ACategoryNamePrefix : WideString);

    Function  GetStoreItemsPath() : WideString;
    Procedure SetStoreItemsPath(Const AStoreItemsPath : WideString);

    Function  GetRequirementPath() : WideString;
    Procedure SetRequirementPath(Const ARequirementPath : WideString);

    Function  GetStorePrefix() : WideString;
    Procedure SetStorePrefix(Const AStorePrefix : WideString);

    Procedure Assign(ASource : IInterface);

    Property OutputFileName     : WideString Read GetOutputFileName     Write SetOutputFileName;
    Property CategoryNamePrefix : WideString Read GetCategoryNamePrefix Write SetCategoryNamePrefix;
    Property StoreItemsPath     : WideString Read GetStoreItemsPath     Write SetStoreItemsPath;
    Property RequirementPath    : WideString Read GetRequirementPath    Write SetRequirementPath;
    Property StorePrefix        : WideString Read GetStorePrefix        Write SetStorePrefix;

  End;

  ITSTOXmlScriptTemplateVariable = Interface(IXmlNodeEx)
    ['{4B61686E-29A0-2112-ABE8-5C36A0F2EDFE}']
    Function  GetName() : WideString;
    Procedure SetName(Const AName : WideString);

    Function  GetFunction() : WideString;
    Procedure SetFunction(Const AFunction : WideString);

    Procedure Assign(ASource : IInterface);

    Property Name    : WideString Read GetName     Write SetName;
    Property VarFunc : WideString Read GetFunction Write SetFunction;

  End;

  ITSTOXmlScriptTemplateVariables = Interface(IXmlNodeCollectionEx)
    ['{4B61686E-29A0-2112-ABE3-0120C43ABE81}']
    Function GetItem(Const Index : Integer) : ITSTOXmlScriptTemplateVariable;

    Function Add() : ITSTOXmlScriptTemplateVariable;
    Function Insert(Const Index: Integer) : ITSTOXmlScriptTemplateVariable;

    Procedure Assign(ASource : IInterface);

    Property Items[Const Index: Integer] : ITSTOXmlScriptTemplateVariable Read GetItem; Default;

  End;

  ITSTOXmlScriptTemplateHack = Interface(IXmlNodeEx)
    ['{4B61686E-29A0-2112-AA2F-B5955E5A8A40}']
    Function  GetName() : WideString;
    Procedure SetName(Const AName : WideString);

    Function  GetEnabled() : Boolean;
    Procedure SetEnabled(Const AEnabled : Boolean);

    Function  GetVariables() : ITSTOXmlScriptTemplateVariables;

    Function  GetSettings() : ITSTOXmlScriptTemplateSettings;

    Function  GetTemplateFile() : WideString;
    Procedure SetTemplateFile(Const ATemplateFile : WideString);

    Procedure Assign(ASource : IInterface);

    Property Name         : WideString                      Read GetName         Write SetName;
    Property Enabled      : Boolean                         Read GetEnabled      Write SetEnabled;
    Property Variables    : ITSTOXmlScriptTemplateVariables Read GetVariables;
    Property Settings     : ITSTOXmlScriptTemplateSettings  Read GetSettings;
    Property TemplateFile : WideString                      Read GetTemplateFile Write SetTemplateFile;

  End;

  ITSTOXmlScriptTemplateHacks = Interface(IXmlNodeCollectionEx)
    ['{4B61686E-29A0-2112-AF00-C8FFF939672C}']
    Function GetItem(Const Index : Integer) : ITSTOXmlScriptTemplateHack;

    Function Add() : ITSTOXmlScriptTemplateHack;
    Function Insert(Const Index: Integer) : ITSTOXmlScriptTemplateHack;

    Procedure Assign(ASource : IInterface);

    Property Items[Const Index: Integer] : ITSTOXmlScriptTemplateHack Read GetItem; Default;

  End;

  TTSTOXmlScriptTemplateHacks = Class(TObject)
  Public
    Class Function CreateScriptTemplateHacks() : ITSTOXmlScriptTemplateHacks; OverLoad;
    Class Function CreateScriptTemplateHacks(Const AXmlString: String) : ITSTOXmlScriptTemplateHacks; OverLoad;

  End;

implementation

Uses
  RtlConsts, SysUtils, TSTOScriptTemplateIntf, TSTOScriptTemplateImpl;

Type
  TTSTOXmlScriptTemplateSettings = Class(TXmlNodeEx, ITSTOXmlScriptTemplateSettings, ITSTOScriptTemplateSettings)
  Protected
    Function  GetOutputFileName() : WideString;
    Procedure SetOutputFileName(Const AOutputFileName : WideString);

    Function  GetCategoryNamePrefix() : WideString;
    Procedure SetCategoryNamePrefix(Const ACategoryNamePrefix : WideString);

    Function  GetStoreItemsPath() : WideString;
    Procedure SetStoreItemsPath(Const AStoreItemsPath : WideString);

    Function  GetRequirementPath() : WideString;
    Procedure SetRequirementPath(Const ARequirementPath : WideString);

    Function  GetStorePrefix() : WideString;
    Procedure SetStorePrefix(Const AStorePrefix : WideString);

    Procedure Assign(ASource : IInterface); ReIntroduce;

    Property OutputFileName     : WideString Read GetOutputFileName     Write SetOutputFileName;
    Property CategoryNamePrefix : WideString Read GetCategoryNamePrefix Write SetCategoryNamePrefix;
    Property StoreItemsPath     : WideString Read GetStoreItemsPath     Write SetStoreItemsPath;
    Property RequirementPath    : WideString Read GetRequirementPath    Write SetRequirementPath;
    Property StorePrefix        : WideString Read GetStorePrefix        Write SetStorePrefix;

  End;

  TTSTOXmlScriptTemplateVariable = Class(TXmlNodeEx, ITSTOXmlScriptTemplateVariable, ITSTOScriptTemplateVariable)
  Protected
    Function  GetName() : WideString;
    Procedure SetName(Const AName : WideString);

    Function  GetFunction() : WideString;
    Procedure SetFunction(Const AFunction : WideString);

    Property Name    : WideString Read GetName     Write SetName;
    Property VarFunc : WideString Read GetFunction Write SetFunction;

    Procedure Assign(ASource : IInterface); ReIntroduce;

  End;

  TTSTOXmlScriptTemplateVariables = Class(TXMLNodeCollectionEx, ITSTOXmlScriptTemplateVariables, ITSTOScriptTemplateVariables)
  Private
    FVariablesImpl : ITSTOScriptTemplateVariables;
    Function GetImplementor() : ITSTOScriptTemplateVariables;

  Protected
    Property VariablesImpl : ITSTOScriptTemplateVariables Read GetImplementor Implements ITSTOScriptTemplateVariables;

    Function GetItem(Const Index : Integer) : ITSTOXmlScriptTemplateVariable;

    Function Add() : ITSTOXmlScriptTemplateVariable;
    Function Insert(Const Index : Integer) : ITSTOXmlScriptTemplateVariable;

    Procedure Assign(ASource : IInterface); ReIntroduce;

    Property Items[Const Index: Integer] : ITSTOXmlScriptTemplateVariable Read GetItem; Default;

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TTSTOXmllScriptTemplateHack = Class(TXmlNodeEx, ITSTOXmlScriptTemplateHack, ITSTOScriptTemplateHack)
  Protected
    Function  GetName() : WideString;
    Procedure SetName(Const AName : WideString);

    Function  GetEnabled() : Boolean;
    Procedure SetEnabled(Const AEnabled : Boolean);

    Function  GetVariables() : ITSTOXmlScriptTemplateVariables;

    Function  GetSettings() : ITSTOXmlScriptTemplateSettings;

    Function  GetTemplateFile() : WideString;
    Procedure SetTemplateFile(Const ATemplateFile : WideString);

    Function  MyGetVariables() : ITSTOScriptTemplateVariables;
    Function  MyGetSettings() : ITSTOScriptTemplateSettings;

    Function ITSTOScriptTemplateHack.GetVariables = MyGetVariables;
    Function ITSTOScriptTemplateHack.GetSettings  = MyGetSettings;

    Procedure Assign(ASource : IInterface); ReIntroduce;

    Property Name         : WideString                      Read GetName         Write SetName;
    Property Enabled      : Boolean                         Read GetEnabled      Write SetEnabled;
    Property Variables    : ITSTOXmlScriptTemplateVariables Read GetVariables;
    Property Settings     : ITSTOXmlScriptTemplateSettings  Read GetSettings;
    Property TemplateFile : WideString                      Read GetTemplateFile Write SetTemplateFile;

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TTSTOXmlScriptTemplateHacksImpl = Class(TXMLNodeCollectionEx, ITSTOXmlScriptTemplateHacks, ITSTOScriptTemplateHacks)
  Private
    FHacksImpl : ITSTOScriptTemplateHacks;

    Function GetImplementor() : ITSTOScriptTemplateHacks;

  Protected
    Property HacksImpl : ITSTOScriptTemplateHacks Read GetImplementor Implements ITSTOScriptTemplateHacks;

    Function GetItem(Const Index : Integer) : ITSTOXmlScriptTemplateHack;

    Function Add() : ITSTOXmlScriptTemplateHack;
    Function Insert(Const Index : Integer) : ITSTOXmlScriptTemplateHack;

    Procedure Assign(ASource : IInterface);

    Property Items[Const Index: Integer] : ITSTOXmlScriptTemplateHack Read GetItem; Default;

  Public
    Procedure AfterConstruction(); OverRide;

  End;

Class Function TTSTOXmlScriptTemplateHacks.CreateScriptTemplateHacks() : ITSTOXmlScriptTemplateHacks;
Var lXml : TXmlDocumentEx;
Begin
  Result := NewXMLDocument('').GetDocBinding('HackTemplates', TTSTOXmlScriptTemplateHacksImpl) As ITSTOXmlScriptTemplateHacks;
Exit;
  lXml := TXmlDocumentEx.Create(Nil);
  Try
    lXml.Options := lXml.Options + [doNodeAutoIndent];
    Result := (lXml As IXmlDocumentEx).GetDocBinding('HackTemplates', TTSTOXmlScriptTemplateHacksImpl) As ITSTOXmlScriptTemplateHacks;

    Finally
      lXml.Free();
  End;
End;

Class Function TTSTOXmlScriptTemplateHacks.CreateScriptTemplateHacks(Const AXmlString : String) : ITSTOXmlScriptTemplateHacks;
Var lXml : TXmlDocumentEx;
Begin
//  Result := LoadXmlData(AXmlString).GetDocBinding('HackTemplates', TTSTOXmlScriptTemplateHacksImpl) As ITSTOXmlScriptTemplateHacks;
//Exit;
  lXml := TXmlDocumentEx.Create(Nil);
  Try
    lXml.Options := lXml.Options + [doNodeAutoIndent];
    lXml.LoadFromXML(AXmlString);
    Result := (lXml As IXmlDocumentEx).GetDocBinding('HackTemplates', TTSTOXmlScriptTemplateHacksImpl) As ITSTOXmlScriptTemplateHacks;

    Finally
//      lXml.Free();
  End;
End;

(******************************************************************************)

Procedure TTSTOXmlScriptTemplateSettings.Assign(ASource : IInterface);
  Procedure InternalAssign(ASource : ITSTOScriptTemplateSettings);
  Begin
    If ASource.OutputFileName <> '' Then
      ChildNodes['OutputFileName'].NodeValue := ASource.OutputFileName;
    If ASource.CategoryNamePrefix <> '' Then
      ChildNodes['CategoryNamePrefix'].NodeValue := ASource.CategoryNamePrefix;
    If ASource.StoreItemsPath <> '' Then
      ChildNodes['StoreItemsPath'].NodeValue := ASource.StoreItemsPath;
    If ASource.RequirementPath <> '' Then
      ChildNodes['RequirementPath'].NodeValue := ASource.RequirementPath;
    If ASource.StorePrefix <> '' Then
      ChildNodes['StorePrefix'].NodeValue := ASource.StorePrefix;
  End;

Var lXmlSrc : ITSTOXmlScriptTemplateSettings;
    lSrc    : ITSTOScriptTemplateSettings;
Begin
  If Supports(ASource, IXmlNodeEx) And
     Supports(ASource, ITSTOXmlScriptTemplateSettings, lXmlSrc) Then
  Begin
    InternalAssign(lXmlSrc As ITSTOScriptTemplateSettings);
//    ChildNodes['OutputFileName'].NodeValue     := lXmlSrc.OutputFileName;
//    ChildNodes['CategoryNamePrefix'].NodeValue := lXmlSrc.CategoryNamePrefix;
//    ChildNodes['StoreItemsPath'].NodeValue     := lXmlSrc.StoreItemsPath;
//    ChildNodes['RequirementPath'].NodeValue    := lXmlSrc.RequirementPath;
//    ChildNodes['StorePrefix'].NodeValue        := lXmlSrc.StorePrefix;
  End
  Else If Supports(ASource, ITSTOScriptTemplateSettings, lSrc) Then
  Begin
    InternalAssign(lSrc As ITSTOScriptTemplateSettings);
//    ChildNodes['OutputFileName'].NodeValue     := lSrc.OutputFileName;
//    ChildNodes['CategoryNamePrefix'].NodeValue := lSrc.CategoryNamePrefix;
//    ChildNodes['StoreItemsPath'].NodeValue     := lSrc.StoreItemsPath;
//    ChildNodes['RequirementPath'].NodeValue    := lSrc.RequirementPath;
//    ChildNodes['StorePrefix'].NodeValue        := lSrc.StorePrefix;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TTSTOXmlScriptTemplateSettings.GetOutputFileName() : WideString;
Var lNode : IXmlNodeEx;
Begin
  lNode := ChildNodes.FindNode('OutputFileName');
  If Assigned(lNode) Then
    Result := lNode.AsString
  Else
    Result := '';
End;

Procedure TTSTOXmlScriptTemplateSettings.SetOutputFileName(Const AOutputFileName : WideString);
Begin
  ChildNodes['OutputFileName'].AsString := AOutputFileName;
End;

Function TTSTOXmlScriptTemplateSettings.GetCategoryNamePrefix() : WideString;
Var lNode : IXmlNodeEx;
Begin
  lNode := ChildNodes.FindNode('CategoryNamePrefix');
  If Assigned(lNode) Then
    Result := lNode.AsString
  Else
    Result := '';
End;

Procedure TTSTOXmlScriptTemplateSettings.SetCategoryNamePrefix(Const ACategoryNamePrefix : WideString);
Begin
  ChildNodes['CategoryNamePrefix'].AsString := ACategoryNamePrefix;
End;

Function TTSTOXmlScriptTemplateSettings.GetStoreItemsPath() : WideString;
Var lNode : IXmlNodeEx;
Begin
  lNode := ChildNodes.FindNode('StoreItemsPath');
  If Assigned(lNode) Then
    Result := lNode.AsString
  Else
    Result := '';
End;

Procedure TTSTOXmlScriptTemplateSettings.SetStoreItemsPath(Const AStoreItemsPath : WideString);
Begin
  ChildNodes['StoreItemsPath'].AsString := AStoreItemsPath;
End;

Function TTSTOXmlScriptTemplateSettings.GetRequirementPath() : WideString;
Var lNode : IXmlNodeEx;
Begin
  lNode := ChildNodes.FindNode('RequirementPath');
  If Assigned(lNode) Then
    Result := lNode.AsString
  Else
    Result := '';
End;

Procedure TTSTOXmlScriptTemplateSettings.SetRequirementPath(Const ARequirementPath : WideString);
Begin
  ChildNodes['RequirementPath'].AsString := ARequirementPath;
End;

Function TTSTOXmlScriptTemplateSettings.GetStorePrefix() : WideString;
Var lNode : IXmlNodeEx;
Begin
  lNode := ChildNodes.FindNode('StorePrefix');
  If Assigned(lNode) Then
    Result := lNode.AsString
  Else
    Result := '';
End;

Procedure TTSTOXmlScriptTemplateSettings.SetStorePrefix(Const AStorePrefix : WideString);
Begin
  ChildNodes['StorePrefix'].AsString := AStorePrefix;
End;

Procedure TTSTOXmlScriptTemplateVariable.Assign(ASource : IInterface);
Var lXmlSrc : ITSTOXmlScriptTemplateVariable;
    lSrc    : ITSTOScriptTemplateVariable;
Begin
  If Supports(ASource, IXmlNodeEx) And
     Supports(ASource, ITSTOXmlScriptTemplateVariable, lXmlSrc) Then
  Begin
    SetAttribute('Name', lXmlSrc.Name);
    SetAttribute('Function', lXmlSrc.VarFunc);
  End
  Else If Supports(ASource, ITSTOScriptTemplateVariable, lSrc) Then
  Begin
    SetAttribute('Name', lSrc.Name);
    SetAttribute('Function', lSrc.VarFunc);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TTSTOXmlScriptTemplateVariable.GetName() : WideString;
Begin
  Result := AttributeNodes['Name'].Text;
End;

Procedure TTSTOXmlScriptTemplateVariable.SetName(Const AName : WideString);
Begin
  SetAttribute('Name', AName);
End;

Function TTSTOXmlScriptTemplateVariable.GetFunction() : WideString;
Begin
  Result := AttributeNodes['Function'].Text;
End;

Procedure TTSTOXmlScriptTemplateVariable.SetFunction(Const AFunction : WideString);
Begin
  SetAttribute('Function', AFunction);
End;

Procedure TTSTOXmlScriptTemplateVariables.AfterConstruction();
Begin
  RegisterChildNode('Variable', TTSTOXmlScriptTemplateVariable);
  ItemTag       := 'Variable';
  ItemInterface := ITSTOXmlScriptTemplateVariable;

  InHerited AfterConstruction();
End;

Procedure TTSTOXmlScriptTemplateVariables.Assign(ASource : IInterface);
Var lXmlSrc : ITSTOXmlScriptTemplateVariables;
    lSrc    : ITSTOScriptTemplateVariables;
    X       : Integer;
Begin
  If Supports(ASource, IXmlNodeEx) And
     Supports(ASource, ITSTOXmlScriptTemplateVariables, lXmlSrc) Then
  Begin
    Clear();

    For X := 0 To lXmlSrc.Count - 1 Do
      Add().Assign(lXmlSrc[X]);
  End
  Else If Supports(ASource, ITSTOScriptTemplateVariables, lSrc) Then
  Begin
    Clear();

    For X := 0 To lSrc.Count - 1 Do
      Add().Assign(lSrc[X]);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TTSTOXmlScriptTemplateVariables.GetImplementor() : ITSTOScriptTemplateVariables;
Var X : Integer;
Begin
  If Not Assigned(FVariablesImpl) Then
    FVariablesImpl := TTSTOScriptTemplateVariables.Create();

  FVariablesImpl.Clear();
  For X := 0 To Count - 1 Do
    FVariablesImpl.Add().Assign(Items[X]);

  Result := FVariablesImpl;
End;

Function TTSTOXmlScriptTemplateVariables.GetItem(Const Index : Integer) : ITSTOXmlScriptTemplateVariable;
Begin
  Result := List[Index] As ITSTOXmlScriptTemplateVariable;
End;

Function TTSTOXmlScriptTemplateVariables.Add() : ITSTOXmlScriptTemplateVariable;
Begin
  Result := AddItem(-1) As ITSTOXmlScriptTemplateVariable;
End;

Function TTSTOXmlScriptTemplateVariables.Insert(Const Index : Integer) : ITSTOXmlScriptTemplateVariable;
Begin
  Result := AddItem(Index) As ITSTOXmlScriptTemplateVariable;
End;
Procedure TTSTOXmllScriptTemplateHack.AfterConstruction();
Begin
  InHerited AfterConstruction();

  RegisterChildNode('Variables', TTSTOXmlScriptTemplateVariables);
  RegisterChildNode('Settings', TTSTOXmlScriptTemplateSettings);
End;

Procedure TTSTOXmllScriptTemplateHack.Assign(ASource : IInterface);
Var lXmlSrc : ITSTOXmlScriptTemplateHack;
    lSrc    : ITSTOScriptTemplateHack;
Begin
  If Supports(ASource, IXmlNodeEx) And
     Supports(ASource, ITSTOXmlScriptTemplateHack, lXmlSrc) Then
  Begin
    SetAttribute('Name', lXmlSrc.Name);
    SetAttribute('Enabled', lXmlSrc.Enabled);
    Variables.Assign(lXmlSrc.Variables);
    Settings.Assign(lXmlSrc.Settings);
    TemplateFile := lXmlSrc.TemplateFile;
  End
  Else If Supports(ASource, ITSTOScriptTemplateHack, lSrc) Then
  Begin
    SetAttribute('Name', lSrc.Name);
    SetAttribute('Enabled', lSrc.Enabled);
    Variables.Assign(lSrc.Variables);
    Settings.Assign(lSrc.Settings);
    TemplateFile := lSrc.TemplateFile;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TTSTOXmllScriptTemplateHack.GetName() : WideString;
Begin
  Result := AttributeNodes['Name'].AsString;
End;

Procedure TTSTOXmllScriptTemplateHack.SetName(Const AName : WideString);
Begin
  SetAttribute('Name', AName);
End;

Function TTSTOXmllScriptTemplateHack.GetEnabled() : Boolean;
Begin
  Result := AttributeNodes['Enabled'].AsBoolean;
End;

Procedure TTSTOXmllScriptTemplateHack.SetEnabled(Const AEnabled : Boolean);
Begin
  SetAttribute('Enabled', AEnabled);
End;

Function TTSTOXmllScriptTemplateHack.GetVariables() : ITSTOXmlScriptTemplateVariables;
Begin
  Result := ChildNodes['Variables'] As ITSTOXmlScriptTemplateVariables;
End;

Function TTSTOXmllScriptTemplateHack.MyGetVariables() : ITSTOScriptTemplateVariables;
Begin
  Result := GetVariables() As ITSTOScriptTemplateVariables;
End;

Function TTSTOXmllScriptTemplateHack.GetSettings() : ITSTOXmlScriptTemplateSettings;
Begin
  Result := ChildNodes['Settings'] As ITSTOXmlScriptTemplateSettings;
End;

Function TTSTOXmllScriptTemplateHack.MyGetSettings() : ITSTOScriptTemplateSettings;
Begin
  Result := GetSettings() As ITSTOScriptTemplateSettings;
End;

Function TTSTOXmllScriptTemplateHack.GetTemplateFile() : WideString;
Begin
  Result := ChildNodes['TemplateFile'].ChildNodes['#cdata-section'].Text;
End;

Procedure TTSTOXmllScriptTemplateHack.SetTemplateFile(Const ATemplateFile : WideString);
Var lNode : IXMLNode;
begin
  lNode := OwnerDocument.CreateNode(ATemplateFile, ntCDATA);
  ChildNodes['TemplateFile'].ChildNodes.Clear();
  ChildNodes['TemplateFile'].ChildNodes.Add(lNode);
End;

Procedure TTSTOXmlScriptTemplateHacksImpl.AfterConstruction();
Begin
  RegisterChildNode('HackTemplate', TTSTOXmllScriptTemplateHack);
  ItemTag       := 'HackTemplate';
  ItemInterface := ITSTOXmlScriptTemplateHack;

  InHerited AfterConstruction();
End;

Procedure TTSTOXmlScriptTemplateHacksImpl.Assign(ASource : IInterface);
Var lXmlSrc : ITSTOXmlScriptTemplateHacks;
    lSrc    : ITSTOScriptTemplateHacks;
    X       : Integer;
Begin
  If Supports(ASource, IXmlNodeEx) And
     Supports(ASource, ITSTOXmlScriptTemplateHacks, lXmlSrc) Then
  Begin
    Clear();

    For X := 0 To lXmlSrc.Count - 1 Do
      Add().Assign(lXmlSrc[X]);
  End
  Else If Supports(ASource, ITSTOScriptTemplateHacks, lSrc) Then
  Begin
    Clear();

    For X := 0 To lSrc.Count - 1 Do
      Add().Assign(lSrc[X]);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TTSTOXmlScriptTemplateHacksImpl.GetImplementor() : ITSTOScriptTemplateHacks;
Var X : Integer;
Begin
  If Not Assigned(FHacksImpl) Then
    FHacksImpl := TTSTOScriptTemplateHacks.Create();

  FHacksImpl.Clear();
  For X := 0 To Count - 1 Do
    FHacksImpl.Add().Assign(Items[X]);

  Result := FHacksImpl;
End;

Function TTSTOXmlScriptTemplateHacksImpl.GetItem(Const Index : Integer) : ITSTOXmlScriptTemplateHack;
Begin
  Result := List[Index] As ITSTOXmlScriptTemplateHack;
End;

Function TTSTOXmlScriptTemplateHacksImpl.Add() : ITSTOXmlScriptTemplateHack;
Begin
  Result := AddItem(-1) As ITSTOXmlScriptTemplateHack;
End;

Function TTSTOXmlScriptTemplateHacksImpl.Insert(Const Index : Integer) : ITSTOXmlScriptTemplateHack;
Begin
  Result := AddItem(Index) As ITSTOXmlScriptTemplateHack;
End;

end.