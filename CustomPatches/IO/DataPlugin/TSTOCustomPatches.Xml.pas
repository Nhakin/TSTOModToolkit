unit TSTOCustomPatches.Xml;

interface

uses HsXmlDocEx;

type
  ITSTOXmlDependencies = interface(IXMLNodeCollectionEx)
    ['{662B9657-6A94-4724-A295-FE516274F8DF}']
    function GetDependency(Index: Integer): WideString;

    function Add(const Dependency: WideString): IXMLNodeEx;
    function Insert(const Index: Integer; const Dependency: WideString): IXMLNodeEx;

    property Dependency[Index: Integer]: WideString read GetDependency; default;

  end;

  ITSTOXmlPatchData = interface(IXMLNodeEx)
    ['{AF0FBAD8-C5AB-46AB-919E-7FBD772EA287}']
    Function  GetPatchType: Integer;
    Procedure SetPatchType(Const Value: Integer);

    Function  GetPatchPath: WideString;
    Procedure SetPatchPath(Const Value: WideString);

    Function  GetCode() : WideString;
    Procedure SetCode(Const Value : WideString);

    Function GetDependencies: ITSTOXmlDependencies;

    Procedure Assign(ASource : IInterface);

    Property PatchType : Integer    Read GetPatchType Write SetPatchType;
    Property PatchPath : WideString Read GetPatchPath Write SetPatchPath;
    Property Code      : WideString Read GetCode      Write SetCode;
    Property Dependencies: ITSTOXmlDependencies read GetDependencies;

  end;

  ITSTOXmlPatchDataList = interface(IXMLNodeCollectionEx)
    ['{F5ACA895-35A1-41B4-851B-C2F97F5089A4}']
    function Add: ITSTOXmlPatchData;
    function Insert(const Index: Integer): ITSTOXmlPatchData;
    function GetItem(Index: Integer): ITSTOXmlPatchData;

    property Items[Index: Integer]: ITSTOXmlPatchData read GetItem; default;

  end;

  ITSTOXMLCustomPatch = interface(IXMLNodeEx)
    ['{38E6678E-34D0-4B22-BB3F-984F9E92A505}']
    Function  GetPatchName: WideString;
    Procedure SetPatchName(Const Value: WideString);

    Function  GetPatchActive: Boolean;
    Procedure SetPatchActive(Const Value: Boolean);

    Function  GetPatchDesc: WideString;
    Procedure SetPatchDesc(Const Value: WideString);

    Function  GetFileName: WideString;
    Procedure SetFileName(Const Value: WideString);

    Function  GetPatchData: ITSTOXmlPatchDataList;

    Procedure Assign(ASource : IInterface);

    Property PatchName   : WideString Read GetPatchName   Write SetPatchName;
    Property PatchActive : Boolean    Read GetPatchActive Write SetPatchActive;
    Property PatchDesc   : WideString Read GetPatchDesc   Write SetPatchDesc;
    Property FileName    : WideString Read GetFileName    Write SetFileName;
    Property PatchData   : ITSTOXmlPatchDataList read GetPatchData;

  end;

  ITSTOXmlPatches = interface(IXMLNodeCollectionEx)
    ['{F902B5D9-E44C-477C-8420-A08667D54D72}']
    Function GetPatch(Index: Integer): ITSTOXMLCustomPatch;

    Function Add: ITSTOXMLCustomPatch;
    Function Insert(const Index: Integer): ITSTOXMLCustomPatch;

    Property Patch[Index: Integer]: ITSTOXMLCustomPatch read GetPatch; default;

  end;

  ITSTOXmlCustomPatches = interface(IXMLNodeEx)
    ['{D8E9E295-73F0-4AD7-B102-6D2467A9E2FF}']
    Function GetPatches: ITSTOXmlPatches;
    Function GetActivePatchCount() : Integer;

    Procedure Assign(ASource : IInterface);

    Property Patches : ITSTOXmlPatches read GetPatches;
    Property ActivePatchCount : Integer Read GetActivePatchCount;

  end;

  TTSTOXmlCustomPatches = Class(TObject)
  Public
    Class Function CreateCustomPatches(AXmlString : String) : ITSTOXmlCustomPatches; OverLoad;
    Class Function CreateCustomPatches() : ITSTOXmlCustomPatches; OverLoad;

  End;

const
  TargetNamespace = '';

implementation

Uses
  SysUtils, RtlConsts, HsInterfaceEx, XmlIntf,
  TSTOCustomPatchesIntf, TSTOCustomPatchesImpl;

Type
  TTSTOXmlCustomPatchesImpl = class(TXMLNodeEx, ITSTOCustomPatches, ITSTOXmlCustomPatches)
  Private
    FInterfaceState : TInterfaceState;

  Protected
    Function GetInterfaceState() : TInterfaceState;
    Function GetPatches() : ITSTOXmlPatches;
    Function GetActivePatchCount() : Integer;
    Function MyGetPatches() : ITSTOCustomPatchList;

    Function ITSTOCustomPatches.GetPatches = MyGetPatches;

    Procedure Assign(ASource : IInterface); ReIntroduce;

  Public
    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;

  end;

  TTSTOXmlPatches = class(TXMLNodeCollectionEx, ITSTOCustomPatchList, ITSTOXmlPatches)
  Private
    FPatches : Pointer;

    Function GetImplementor() : ITSTOCustomPatchList;

  Protected
    Property PatchesImpl : ITSTOCustomPatchList Read GetImplementor Implements ITSTOCustomPatchList;

    Function GetPatch(Index : Integer) : ITSTOXMLCustomPatch;
    Function Add() : ITSTOXMLCustomPatch;
    Function Insert(Const Index : Integer) : ITSTOXMLCustomPatch;

  Public
    Procedure AfterConstruction(); OverRide;

  end;

  TTSTOXmlPatch = class(TXMLNodeEx, ITSTOCustomPatch, ITSTOXMLCustomPatch)
  Private
    FPatchData: ITSTOXmlPatchDataList;
    FInterfaceState : TInterfaceState;

  Protected
    Function GetInterfaceState() : TInterfaceState;

    Function  GetPatchName() : WideString;
    Procedure SetPatchName(Const Value: WideString);

    Function  GetPatchActive() : Boolean;
    Procedure SetPatchActive(Const Value: Boolean);

    Function  GetPatchDesc() : WideString;
    Procedure SetPatchDesc(Const Value: WideString);

    Function  GetFileName() : WideString;
    Procedure SetFileName(Const Value: WideString);

    Function  GetPatchData() : ITSTOXmlPatchDataList;

    Function  MyGetPatchData() : ITSTOPatchDatas;
    Function  ITSTOCustomPatch.GetPatchData = MyGetPatchData;

    Procedure Assign(ASource : IInterface);

  public
    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;

  end;

  TTSTOXmlPatchData = class(TXMLNodeEx, ITSTOPatchData, ITSTOXmlPatchData)
  Private
    FInterfaceState : TInterfaceState;

  protected
    Function GetInterfaceState() : TInterfaceState;

    Function  GetPatchType() : Integer;
    Procedure SetPatchType(Const Value: Integer);

    Function  GetPatchPath() : WideString;
    Procedure SetPatchPath(Const Value: WideString);

    Function  GetCode() : WideString;
    Procedure SetCode(Const Value : WideString);

    Function GetDependencies() : ITSTOXmlDependencies;

    Procedure Assign(ASource : IInterface);

  public
    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;

  end;

  TTSTOXmlPatchDatas = class(TXMLNodeCollectionEx, ITSTOPatchDatas, ITSTOXmlPatchDataList)
  Private
    FPatcheDatas : Pointer;

    Function GetImplementor() : ITSTOPatchDatas;

  Protected
    Property PatchesImpl : ITSTOPatchDatas Read GetImplementor Implements ITSTOPatchDatas;

    Function Add() : ITSTOXmlPatchData;
    Function Insert(Const Index : Integer) : ITSTOXmlPatchData;
    Function GetItem(Index : Integer) : ITSTOXmlPatchData;

  end;

  TTSTOXmlDependenciesType = class(TXMLNodeCollectionEx, ITSTOXmlDependencies)
  protected
    function GetDependency(Index: Integer): WideString;
    function Add(const Dependency: WideString): IXMLNodeEx;
    function Insert(const Index: Integer; const Dependency: WideString): IXMLNodeEx;

  public
    procedure AfterConstruction; override;

  end;

Class Function TTSTOXmlCustomPatches.CreateCustomPatches(AXmlString : String) : ITSTOXmlCustomPatches;
Begin
  Result := LoadXMLData(AXmlString).GetDocBinding('CustomPatches', TTSTOXmlCustomPatchesImpl, TargetNamespace) as ITSTOXmlCustomPatches;
End;

Class Function TTSTOXmlCustomPatches.CreateCustomPatches() : ITSTOXmlCustomPatches;
Begin
  Result := NewXMLDocument.GetDocBinding('CustomPatches', TTSTOXmlCustomPatchesImpl, TargetNamespace) as ITSTOXmlCustomPatches;
End;

(******************************************************************************)

{ TTSTOXmlCustomPatchesType }

procedure TTSTOXmlCustomPatchesImpl.AfterConstruction();
begin
  RegisterChildNode('Patches', TTSTOXmlPatches);
  FInterfaceState := isCreating;

  InHerited AfterConstruction();
end;

Procedure TTSTOXmlCustomPatchesImpl.BeforeDestruction();
Begin
  FInterfaceState := isDestroying;

  InHerited AfterConstruction();
End;

Function TTSTOXmlCustomPatchesImpl.GetInterfaceState() : TInterfaceState;
Begin
  Result := FInterfaceState;
End;

Procedure TTSTOXmlCustomPatchesImpl.Assign(ASource : IInterface);
Var lXmlSrc : ITSTOXmlCustomPatches;
    lSrc : ITSTOCustomPatches;
    X : Integer;
Begin
  If Supports(ASource, IXmlNodeEx) And
     Supports(ASource, ITSTOXmlCustomPatches, lXmlSrc) Then
  Begin
    For X := 0 To lXmlSrc.Patches.Count - 1 Do
      GetPatches().Add().Assign(lXmlSrc.Patches[X]);
  End
  Else If Supports(ASource, ITSTOCustomPatches, lSrc) Then
  Begin
    For X := 0 To lSrc.Patches.Count - 1 Do
      GetPatches().Add().Assign(lSrc.Patches[X]);

//    FFileImpl := Pointer(lSrc);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;


function TTSTOXmlCustomPatchesImpl.GetPatches() : ITSTOXmlPatches;
begin
  Result := ChildNodes['Patches'] as ITSTOXmlPatches;
end;

Function TTSTOXmlCustomPatchesImpl.MyGetPatches() : ITSTOCustomPatchList;
Begin
  Result := GetPatches() As ITSTOCustomPatchList;
End;

Function TTSTOXmlCustomPatchesImpl.GetActivePatchCount() : Integer;
Var lNodeList : IXmlNodeListEx;
Begin
  lNodeList := (OwnerDocument As IXmlDocumentEx).SelectNodes('//Patch[@Active="true"]');
  If Assigned(lNodeList) Then
    Result := lNodeList.Count
  Else
    Result := 0;
End;

procedure TTSTOXmlPatches.AfterConstruction();
begin
  RegisterChildNode('Patch', TTSTOXmlPatch);
  ItemTag := 'Patch';
  ItemInterface := ITSTOXMLCustomPatch;

  FPatches := Nil;

  InHerited AfterConstruction();
end;

Function TTSTOXmlPatches.GetImplementor() : ITSTOCustomPatchList;
Var X : Integer;
Begin
  If Not Assigned(FPatches) Then
  Begin
    Result := TTSTOCustomPatchList.Create();

    For X := 0 To List.Count - 1 Do
      Result.Add().Assign(List[X]);

    FPatches := Pointer(Result);
  End
  Else
    Result := ITSTOCustomPatchList(FPatches);
End;

function TTSTOXmlPatches.GetPatch(Index: Integer): ITSTOXMLCustomPatch;
begin
  Result := List[Index] as ITSTOXMLCustomPatch;
end;

function TTSTOXmlPatches.Add: ITSTOXMLCustomPatch;
begin
  Result := AddItem(-1) as ITSTOXMLCustomPatch;
end;

function TTSTOXmlPatches.Insert(const Index: Integer): ITSTOXMLCustomPatch;
begin
  Result := AddItem(Index) as ITSTOXMLCustomPatch;
end;

procedure TTSTOXmlPatch.AfterConstruction();
begin
  RegisterChildNode('PatchData', TTSTOXmlPatchData);
  FPatchData := CreateCollection(TTSTOXmlPatchDatas, ITSTOXmlPatchData, 'PatchData') as ITSTOXmlPatchDataList;
  FInterfaceState := isCreating;

  InHerited AfterConstruction();
end;

Procedure TTSTOXmlPatch.BeforeDestruction();
Begin
  FInterfaceState := isDestroying;

  InHerited BeforeDestruction();
End;

Function TTSTOXmlPatch.GetInterfaceState() : TInterfaceState;
Begin
  Result := FInterfaceState;
End;

Procedure TTSTOXmlPatch.Assign(ASource : IInterface);
Var lXmlSrc : ITSTOXMLCustomPatch;
    lSrc    : ITSTOCustomPatch;
    X       : Integer;
Begin
  If Supports(ASource, IXmlNodeEx) And
     Supports(ASource, ITSTOXMLCustomPatch, lXmlSrc) Then
  Begin
    SetAttribute('Name', lXmlSrc.PatchName);
    SetAttribute('Active', lXmlSrc.PatchActive);
    ChildNodes['PatchDesc'].NodeValue := lXmlSrc.PatchDesc;
    ChildNodes['FileName'].NodeValue := lXmlSrc.FileName;

    For X := 0 To lXmlSrc.PatchData.Count - 1 Do
      GetPatchData().Add().Assign(lXmlSrc.PatchData[X]);
  End
  Else If Supports(ASource, ITSTOCustomPatch, lSrc) Then
  Begin
    SetAttribute('Name', lSrc.PatchName);
    SetAttribute('Active', lSrc.PatchActive);
    ChildNodes['PatchDesc'].NodeValue := lSrc.PatchDesc;
    ChildNodes['FileName'].NodeValue := lSrc.FileName;

    For X := 0 To lSrc.PatchData.Count - 1 Do
      GetPatchData().Add().Assign(lSrc.PatchData[X]);

//    FHeaderImpl := Pointer(lSrc);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

function TTSTOXmlPatch.GetPatchName: WideString;
begin
  Result := AttributeNodes['Name'].Text;
end;

procedure TTSTOXmlPatch.SetPatchName(Const Value: WideString);
begin
  SetAttribute('Name', Value);
end;

function TTSTOXmlPatch.GetPatchActive: Boolean;
begin
  Result := AttributeNodes['Active'].AsBoolean;
end;

procedure TTSTOXmlPatch.SetPatchActive(Const Value: Boolean);
begin
  SetAttribute('Active', Value);
end;

function TTSTOXmlPatch.GetPatchDesc: WideString;
begin
  Result := ChildNodes['PatchDesc'].Text;
end;

procedure TTSTOXmlPatch.SetPatchDesc(Const Value: WideString);
begin
  ChildNodes['PatchDesc'].NodeValue := Value;
end;

function TTSTOXmlPatch.GetFileName: WideString;
begin
  Result := ChildNodes['FileName'].Text;
end;

procedure TTSTOXmlPatch.SetFileName(Const Value: WideString);
begin
  ChildNodes['FileName'].NodeValue := Value;
end;

function TTSTOXmlPatch.GetPatchData: ITSTOXmlPatchDataList;
begin
  Result := FPatchData;
end;

Function TTSTOXmlPatch.MyGetPatchData() : ITSTOPatchDatas;
Begin
  Result := GetPatchData() As ITSTOPatchDatas;
End;

procedure TTSTOXmlPatchData.AfterConstruction();
begin
  RegisterChildNode('Dependencies', TTSTOXmlDependenciesType);
  FInterfaceState := isCreating;

  InHerited AfterConstruction();
end;

Procedure TTSTOXmlPatchData.BeforeDestruction();
Begin
  FInterfaceState := isDestroying;

  InHerited BeforeDestruction();
End;

Function TTSTOXmlPatchData.GetInterfaceState() : TInterfaceState;
Begin
  Result := FInterfaceState;
End;

Procedure TTSTOXmlPatchData.Assign(ASource : IInterface);
Var lXmlSrc : ITSTOXmlPatchData;
    lSrc    : ITSTOPatchData;
    X       : Integer;
Begin
  If Supports(ASource, IXmlNodeEx) And
     Supports(ASource, ITSTOXmlPatchData, lXmlSrc) Then
  Begin
    ChildNodes['PatchType'].NodeValue := lXmlSrc.PatchType;
    ChildNodes['PatchPath'].NodeValue := lXmlSrc.PatchPath;
    SetCode(lXmlSrc.Code);
  End
  Else If Supports(ASource, ITSTOPatchData, lSrc) Then
  Begin
    ChildNodes['PatchType'].NodeValue := lSrc.PatchType;
    ChildNodes['PatchPath'].NodeValue := lSrc.PatchPath;
    SetCode(lSrc.Code);

//    FPatchDataImpl := Pointer(lSrc);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

function TTSTOXmlPatchData.GetPatchType: Integer;
begin
  Result := ChildNodes['PatchType'].AsInteger;
end;

procedure TTSTOXmlPatchData.SetPatchType(Const Value: Integer);
begin
  ChildNodes['PatchType'].NodeValue := Value;
end;

function TTSTOXmlPatchData.GetPatchPath: WideString;
begin
  Result := ChildNodes['PatchPath'].Text;
end;

procedure TTSTOXmlPatchData.SetPatchPath(Const Value : WideString);
begin
  ChildNodes['PatchPath'].NodeValue := Value;
end;

function TTSTOXmlPatchData.GetCode() : WideString;
begin
  Result := ChildNodes['Code'].ChildNodes['#cdata-section'].Text;
end;

Procedure TTSTOXmlPatchData.SetCode(Const Value : WideString);
Var lNode : IXMLNode;
begin
  lNode := OwnerDocument.CreateNode(Value, ntCDATA);
  ChildNodes['Code'].ChildNodes.Clear();
  ChildNodes['Code'].ChildNodes.Add(lNode);
End;

function TTSTOXmlPatchData.GetDependencies: ITSTOXmlDependencies;
begin
  Result := ChildNodes['Dependencies'] as ITSTOXmlDependencies;
end;

Function TTSTOXmlPatchDatas.GetImplementor() : ITSTOPatchDatas;
Var X : Integer;
Begin
  If Not Assigned(FPatcheDatas) Then
  Begin
    Result := TTSTOPatchDatas.Create();

    For X := 0 To List.Count - 1 Do
      Result.Add().Assign(List[X]);

    FPatcheDatas := Pointer(Result);
  End
  Else
    Result := ITSTOPatchDatas(FPatcheDatas);
End;

function TTSTOXmlPatchDatas.Add: ITSTOXmlPatchData;
begin
  Result := AddItem(-1) as ITSTOXmlPatchData;
end;

function TTSTOXmlPatchDatas.Insert(const Index: Integer): ITSTOXmlPatchData;
begin
  Result := AddItem(Index) as ITSTOXmlPatchData;
end;
function TTSTOXmlPatchDatas.GetItem(Index: Integer): ITSTOXmlPatchData;
begin
  Result := List[Index] as ITSTOXmlPatchData;
end;

procedure TTSTOXmlDependenciesType.AfterConstruction;
begin
  ItemTag := 'Dependency';
  ItemInterface := IXMLNodeEx;
  inherited;
end;

function TTSTOXmlDependenciesType.GetDependency(Index: Integer): WideString;
begin
  Result := List[Index].Text;
end;

function TTSTOXmlDependenciesType.Add(const Dependency: WideString): IXMLNodeEx;
begin
  Result := AddItem(-1);
  Result.NodeValue := Dependency;
end;

function TTSTOXmlDependenciesType.Insert(const Index: Integer; const Dependency: WideString): IXMLNodeEx;
begin
  Result := AddItem(Index);
  Result.NodeValue := Dependency;
end;

end.
