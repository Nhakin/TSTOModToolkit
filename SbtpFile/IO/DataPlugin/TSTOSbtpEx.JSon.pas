unit TSTOSbtpEx.JSon;

interface

Uses Windows, HsJSonEx;

Type
  IJSonSbtpSubVariable = Interface(IHsJSonObject)
    ['{4B61686E-29A0-2112-BE0B-99AD11FF41D2}']
    Function  GetVariableName() : String;
    Procedure SetVariableName(Const AVariableName : String);

    Function  GetVariableData() : String;
    Procedure SetVariableData(Const AVariableData : String);

    Procedure Assign(ASource : IInterface);

    Property VariableName : String Read GetVariableName Write SetVariableName;
    Property VariableData : String Read GetVariableData Write SetVariableData;

  End;

  IJSonSbtpSubVariables = Interface(IHsJSonObjects)
    ['{4B61686E-29A0-2112-83EF-58060F0E7493}']
    Function GetItem(Const Index : Integer) : IJSonSbtpSubVariable;

    Function Add() : IJSonSbtpSubVariable; OverLoad;
    Function Add(Const AItem : IJSonSbtpSubVariable) : Integer; OverLoad;

    Procedure Assign(ASource : IInterface);

    Property Items[Const Index: Integer] : IJSonSbtpSubVariable Read GetItem; Default;

  End;

  IJSonSbtpVariable = Interface(IHsJSonObject)
    ['{4B61686E-29A0-2112-830D-13807B6A49B8}']
    Function  GetVariableType() : String;
    Procedure SetVariableType(Const AVariableType : String);

    Function  GetNbSubItems() : DWord;

    Function  GetSubItem() : IJSonSbtpSubVariables;

    Procedure Assign(ASource : IInterface);
    
    Property VariableType : String                Read GetVariableType Write SetVariableType;
    Property NbSubItems   : DWord                 Read GetNbSubItems;
    Property SubItem      : IJSonSbtpSubVariables Read GetSubItem;

  End;

  IJSonSbtpVariables = Interface(IHsJSonObjects)
    ['{4B61686E-29A0-2112-A391-FDA5B5B7C163}']
    Function GetItem(Const Index : Integer) : IJSonSbtpVariable;

    Function Add() : IJSonSbtpVariable; OverLoad;
    Function Add(Const AItem : IJSonSbtpVariable) : Integer; OverLoad;

    Procedure Assign(ASource : IInterface);
    
    Property Items[Const Index: Integer] : IJSonSbtpVariable Read GetItem; Default;

  End;

  IJSonSbtpHeader = Interface(IHsJSonObject)
    ['{4B61686E-29A0-2112-AF8D-F819467F1FE3}']
    Function  GetHeader() : String;
    Procedure SetHeader(Const AHeader : String);

    Function  GetHeaderPadding() : Word;
    Procedure SetHeaderPadding(Const AHeaderPadding : Word);

    Procedure Assign(ASource : IInterface);

    Property Header        : String Read GetHeader        Write SetHeader;
    Property HeaderPadding : Word   Read GetHeaderPadding Write SetHeaderPadding;

  End;

  IJSonSbtpFile = Interface(IHsJSonObject)
    ['{4B61686E-29A0-2112-A9AC-B4821E48638E}']
    Function  GetHeader() : IJSonSbtpHeader;
    Function  GetItem() : IJSonSbtpVariables;

    Procedure Assign(ASource : IInterface);

    Property Header : IJSonSbtpHeader    Read GetHeader;
    Property Item   : IJSonSbtpVariables Read GetItem;

  End;

(******************************************************************************)

  TJSonSbtpFile = Class(TObject)
  Public
    Class Function CreateSbtpFile() : IJSonSbtpFile; OverLoad;
    Class Function CreateSbtpFile(Const AJSonString : String) : IJSonSbtpFile; OverLoad;

  End;

implementation

Uses Dialogs,
  SysUtils, RtlConsts, HsInterfaceEx, TSTOSbtpIntf;

Type
  TJSonSbtpSubVariable = Class(THsJSonObject, ISbtpSubVariable, IJSonSbtpSubVariable)
  Private
    FSubVariableImpl : Pointer;
    Function GetImplementor() : ISbtpSubVariable;

  Protected
    Property SubVariableImpl : ISbtpSubVariable Read GetImplementor;

    Function  GetVariableName() : String;
    Procedure SetVariableName(Const AVariableName : String);

    Function  GetVariableData() : String;
    Procedure SetVariableData(Const AVariableData : String);

    Procedure Clear();

    Procedure Assign(ASource : IInterface); ReIntroduce;

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TJSonSbtpSubVariables = Class(THsJSonObjects, ISbtpSubVariables, IJSonSbtpSubVariables)
  Private
    FSubVariablesImpl : ISbtpSubVariables;//Pointer;
    Function GetImplementor() : ISbtpSubVariables;

  Protected
    Property SubVariablesImpl : ISbtpSubVariables Read GetImplementor Implements ISbtpSubVariables;

    Function GetItemClass() : THsJSonObjectClass; OverRide;
    Function GetItem(Const Index : Integer) : IJSonSbtpSubVariable; OverLoad;

    Function Add() : IJSonSbtpSubVariable; OverLoad;
    Function Add(Const AItem : IJSonSbtpSubVariable) : Integer; OverLoad;

    Procedure Assign(ASource : IInterface);
    Procedure AssignTo(ATarget : ISbtpSubVariables);

    Property Items[Const Index: Integer] : IJSonSbtpSubVariable Read GetItem; Default;

  End;

  TJSonSbtpVariable = Class(THsJSonObject, ISbtpVariable, IJSonSbtpVariable)
  Private
    FVariableImpl : Pointer;
    Function GetImplementor() : ISbtpVariable;

  Protected
    Property VariableImpl : ISbtpVariable Read GetImplementor;

    Function  GetVariableType() : String;
    Procedure SetVariableType(Const AVariableType : String);

    Function  GetNbSubItems() : DWord;

    Function  GetSubItem() : IJSonSbtpSubVariables;
    Function  GetISubItem() : ISbtpSubVariables;

    Function ISbtpVariable.GetSubItem = GetISubItem;

    Procedure Clear();

    Procedure Assign(ASource : IInterface);

  Public
    Procedure AfterConstruction(); OverRide;
    Destructor Destroy(); OverRide;

  End;

  TJSonSbtpVariables = Class(THsJSonObjects, ISbtpVariables, IJSonSbtpVariables)
  Private
    FVariablesImpl : ISbtpVariables;//Pointer;
    Function GetImplementor() : ISbtpVariables;

  Protected
    Property VariablesImpl : ISbtpVariables Read GetImplementor Implements ISbtpVariables;

    Function GetItemClass() : THsJSonObjectClass; OverRide;
    Function GetItem(Const Index : Integer) : IJSonSbtpVariable; OverLoad;

    Function Add() : IJSonSbtpVariable; OverLoad;
    Function Add(Const AItem : IJSonSbtpVariable) : Integer; OverLoad;

    Procedure Assign(ASource : IInterface);
    Procedure AssignTo(ATarget : ISbtpVariables);

    Property Items[Const Index: Integer] : IJSonSbtpVariable Read GetItem; Default;

  End;

  TJSonSbtpHeader = Class(THsJSonObject, ISbtpHeader, IJSonSbtpHeader)
  Private
    FHeaderImpl : Pointer;
    Function GetImplementor() : ISbtpHeader;

  Protected
    Property HeaderImpl : ISbtpHeader Read GetImplementor;

    Function  GetHeader() : String;
    Procedure SetHeader(Const AHeader : String);

    Function  GetHeaderPadding() : Word;
    Procedure SetHeaderPadding(Const AHeaderPadding : Word);

    Procedure Clear();

    Procedure Assign(ASource : IInterface);

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TJSonSbtpFileImpl = Class(THsJSonObject, ISbtpFile, IJSonSbtpFile)
  Private
    FFileImpl : Pointer;

    Function GetImplementor() : ISbtpFile;

  Protected
    Property FileImpl : ISbtpFile Read GetImplementor;

    Function _Release() : Integer; OverRide; StdCall;

    Function  GetHeader() : IJSonSbtpHeader;
    Function  GetIHeader() : ISbtpHeader;

    Function  GetItem() : IJSonSbtpVariables;
    Function  GetIItem() : ISbtpVariables;

    Function ISbtpFile.GetHeader = GetIHeader;
    Function ISbtpFile.GetItem = GetIItem;

    Procedure Clear();

    Procedure Assign(ASource : IInterface);

  Public
    Procedure AfterConstruction(); OverRide;

    Destructor Destroy(); OverRide;

  End;

Class Function TJSonSbtpFile.CreateSbtpFile() : IJSonSbtpFile;
Begin
  Result := TJSonSbtpFileImpl.Create();
End;

Class Function TJSonSbtpFile.CreateSbtpFile(Const AJSonString : String) : IJSonSbtpFile;
Begin
  Result := THsJSonObject.GetDocBinding(AJSonString, TJSonSbtpFileImpl) As IJSonSbtpFile;
End;

(******************************************************************************)

Procedure TJSonSbtpSubVariable.AfterConstruction();
Begin
  FSubVariableImpl := Pointer(ISbtpSubVariable(Self));

  InHerited AfterConstruction();
End;

Function TJSonSbtpSubVariable.GetImplementor() : ISbtpSubVariable;
Begin
  Result := ISbtpSubVariable(FSubVariableImpl);
End;

Procedure TJSonSbtpSubVariable.Assign(ASource : IInterface);
Var lJSonSrc : IJSonSbtpSubVariable;
    lSrc     : ISbtpSubVariable;
Begin
  If Supports(ASource, IHsJSonObject) And
     Supports(ASource, IJSonSbtpSubVariable, lJSonSrc) Then
  Begin
    S['VariableName'] := lJSonSrc.VariableName;
    S['VariableData'] := lJSonSrc.VariableData;
  End
  Else If Supports(ASource, ISbtpSubVariable, lSrc)  Then
  Begin
    S['VariableName'] := lSrc.VariableName;
    S['VariableData'] := lSrc.VariableData;

    FSubVariableImpl := Pointer(lSrc);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Procedure TJSonSbtpSubVariable.Clear();
Begin
  S['VariableName'] := '';
  S['VariableData'] := '';
End;

Function TJSonSbtpSubVariable.GetVariableName() : String;
Begin
  Result := S['VariableName'];
End;

Procedure TJSonSbtpSubVariable.SetVariableName(Const AVariableName : String);
Begin
  S['VariableName'] := AVariableName;

  If Not IsImplementorOf(SubVariableImpl) Then
    SubVariableImpl.VariableName := AVariableName;
End;

Function TJSonSbtpSubVariable.GetVariableData() : String;
Begin
  Result := S['VariableData'];
End;

Procedure TJSonSbtpSubVariable.SetVariableData(Const AVariableData : String);
Begin
  S['VariableData'] := AVariableData;

  If Not IsImplementorOf(SubVariableImpl) Then
    SubVariableImpl.VariableData := AVariableData;
End;

Function TJSonSbtpSubVariables.GetImplementor() : ISbtpSubVariables;
Begin
  If Not Assigned(FSubVariablesImpl) Then
    FSubVariablesImpl := TSbtpFile.CreateSbtpSubVariables();
  Result := FSubVariablesImpl;
//  Begin
//    Result := TSbtpFile.CreateSbtpSubVariables();
//    FSubVariablesImpl := Pointer(Result);
//  End
//  Else
//    Result := ISbtpSubVariables(FSubVariablesImpl);

  AssignTo(Result);
End;

Procedure TJSonSbtpSubVariables.Assign(ASource : IInterface);
Var lJSonSrc : IJSonSbtpSubVariables;
    lSrc     : ISbtpSubVariables;
    X        : Integer;
Begin
  If Supports(ASource, IHsJSonObjects) And
     Supports(ASource, IJSonSbtpSubVariables, lJSonSrc) Then
  Begin
    Clear();

    For X := 0 To lJSonSrc.Count - 1 Do
      Add().Assign(lJSonSrc[X]);
  End
  Else If Supports(ASource, ISbtpSubVariables, lSrc) Then
  Begin
    Clear();
    For X := 0 To lSrc.Count - 1 Do
      Add().Assign(lSrc[X]);

    FSubVariablesImpl := {Pointer(}lSrc;//);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Procedure TJSonSbtpSubVariables.AssignTo(ATarget : ISbtpSubVariables);
Var X : Integer;
Begin
  ATarget.Clear();

  For X := 0 To Count - 1 Do
    ATarget.Add().Assign(Items[X]);
End;

Function TJSonSbtpSubVariables.Add() : IJSonSbtpSubVariable;
Begin
  Result := InHerited Add() As IJSonSbtpSubVariable;
  If Assigned(FSubVariablesImpl) Then
    SubVariablesImpl.Add(Result);
End;

Function TJSonSbtpSubVariables.Add(Const AItem : IJSonSbtpSubVariable) : Integer;
Begin
  Result := InHerited Add(AItem);
  If Assigned(FSubVariablesImpl) Then
    SubVariablesImpl.Add(AItem);
End;

Function TJSonSbtpSubVariables.GetItemClass() : THsJSonObjectClass;
Begin
  Result := TJSonSbtpSubVariable;
End;

Function TJSonSbtpSubVariables.GetItem(Const Index : Integer) : IJSonSbtpSubVariable;
Begin
  Result := InHerited Nodes[Index] As IJSonSbtpSubVariable;
End;

Procedure TJSonSbtpVariable.AfterConstruction();
Begin
  InHerited AfterConstruction();

  RegisterChildNode('SubItem', TJSonSbtpSubVariables);
  FVariableImpl := Pointer(ISbtpVariable(Self));
End;

Destructor TJSonSbtpVariable.Destroy();
Begin
  Clear();

  InHerited Destroy();
End;

Function TJSonSbtpVariable.GetImplementor() : ISbtpVariable;
Begin
  Result := ISbtpVariable(FVariableImpl);
End;

Procedure TJSonSbtpVariable.Assign(ASource : IInterface);
Var lJSonSrc : IJSonSbtpVariable;
    lSrc     : ISbtpVariable;
Begin
  If Supports(ASource, IHsJSonObject) And
     Supports(ASource, IJSonSbtpVariable, lJSonSrc) Then
  Begin
    S['VariableType'] := lJSonSrc.VariableType;
    GetSubItem().Assign(lJSonSrc.SubItem);
  End
  Else If Supports(ASource, ISbtpVariable, lSrc)  Then
  Begin
    S['VariableType'] := lSrc.VariableType;
    GetSubItem().Assign(lSrc.SubItem);

    FVariableImpl := Pointer(lSrc);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Procedure TJSonSbtpVariable.Clear();
Begin
  S['VariableType'] := '';
  O['SubItem']      := Nil;
End;

Function  TJSonSbtpVariable.GetVariableType() : String;
Begin
  Result := S['VariableType'];
End;

Procedure TJSonSbtpVariable.SetVariableType(Const AVariableType : String);
Begin
  S['VariableType'] := AVariableType;

  If Not IsImplementorOf(VariableImpl) Then
    VariableImpl.VariableType := AVariableType;
End;

Function TJSonSbtpVariable.GetNbSubItems() : DWord;
Begin
  Result := A['SubVariable'].Count;
End;

Function TJSonSbtpVariable.GetSubItem() : IJSonSbtpSubVariables;
Begin
  If O['SubItem'] = Nil Then
    O['SubItem'] := TJSonSbtpSubVariables.Create(svtArray);

  Result := A['SubItem'] As IJSonSbtpSubVariables
End;

Function TJSonSbtpVariable.GetISubItem() : ISbtpSubVariables;
Begin
  Result := GetSubItem() As ISbtpSubVariables;
End;

Function TJSonSbtpVariables.GetImplementor() : ISbtpVariables;
Begin
  If Not Assigned(FVariablesImpl) Then
    FVariablesImpl := TSbtpFile.CreateSbtpVariables();
  Result := FVariablesImpl;
//  Begin
//    Result := TSbtpFile.CreateSbtpVariables();
//    FVariablesImpl := Pointer(Result);
//  End
//  Else
//    Result := ISbtpVariables(FVariablesImpl);

  AssignTo(Result);
End;

Procedure TJSonSbtpVariables.Assign(ASource : IInterface);
Var lJSonSrc : IJSonSbtpVariables;
    lSrc     : ISbtpVariables;
    X        : Integer;
Begin
  If Supports(ASource, IHsJSonObjects) And
     Supports(ASource, IJSonSbtpVariables, lJSonSrc) Then
  Begin
    Clear();

    For X := 0 To lJSonSrc.Count - 1 Do
      Add().Assign(lJSonSrc[X]);
  End
  Else If Supports(ASource, ISbtpVariables, lSrc) Then
  Begin
    Clear();
    For X := 0 To lSrc.Count - 1 Do
      Add().Assign(lSrc[X]);

//    FVariablesImpl := Pointer(lSrc);
    FVariablesImpl := lSrc;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Procedure TJSonSbtpVariables.AssignTo(ATarget : ISbtpVariables);
Var X : Integer;
Begin
  ATarget.Clear();

  For X := 0 To Count - 1 Do
    ATarget.Add().Assign(Items[X]);
End;

Function TJSonSbtpVariables.GetItemClass() : THsJSonObjectClass;
Begin
  Result := TJSonSbtpVariable;
End;

Function TJSonSbtpVariables.GetItem(Const Index : Integer) : IJSonSbtpVariable;
Begin
  Result := InHerited Nodes[Index] As IJSonSbtpVariable;
End;

Function TJSonSbtpVariables.Add() : IJSonSbtpVariable;
Begin
  Result := InHerited Add() As IJSonSbtpVariable;
//  If Assigned(FVariablesImpl) Then
//    VariablesImpl.Add(Result);
End;

Function TJSonSbtpVariables.Add(Const AItem : IJSonSbtpVariable) : Integer;
Begin
  Result := InHerited Add(AItem);
  If Assigned(FVariablesImpl) Then
    VariablesImpl.Add(AItem);
End;

Procedure TJSonSbtpHeader.AfterConstruction();
Begin
  InHerited AfterConstruction();

  FHeaderImpl := Pointer(ISbtpHeader(Self));
End;

Function TJSonSbtpHeader.GetImplementor() : ISbtpHeader;
Begin
  Result := ISbtpHeader(FHeaderImpl);
End;

Procedure TJSonSbtpHeader.Assign(ASource : IInterface);
Var lJSonSrc : IJSonSbtpHeader;
    lSrc     : ISbtpHeader;
Begin
  If Supports(ASource, IHsJSonObject) And
     Supports(ASource, IJSonSbtpHeader, lJSonSrc) Then
  Begin
    S['Header']        := lJSonSrc.Header;
    I['HeaderPadding'] := lJSonSrc.HeaderPadding;
  End
  Else If Supports(ASource, ISbtpHeader, lSrc) Then
  Begin
    S['Header']        := lSrc.Header;
    I['HeaderPadding'] := lSrc.HeaderPadding;

    FHeaderImpl := Pointer(lSrc);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Procedure TJSonSbtpHeader.Clear();
Begin
  S['Header'] := '';
  I['HeaderPadding'] := 0;
End;

Function TJSonSbtpHeader.GetHeader() : String;
Begin
  Result := S['Header'];
End;

Procedure TJSonSbtpHeader.SetHeader(Const AHeader : String);
Begin
  S['Header'] := AHeader;

  If Not IsImplementorOf(HeaderImpl) Then
    HeaderImpl.Header := AHeader;
End;

Function TJSonSbtpHeader.GetHeaderPadding() : Word;
Begin
  Result := I['HeaderPadding'];
End;

Procedure TJSonSbtpHeader.SetHeaderPadding(Const AHeaderPadding : Word);
Begin
  I['HeaderPadding'] := AHeaderPadding;

  If Not IsImplementorOf(HeaderImpl) Then
    HeaderImpl.HeaderPadding := AHeaderPadding;
End;

Procedure TJSonSbtpFileImpl.AfterConstruction();
Begin
  InHerited AfterConstruction();

  RegisterChildNode('Header', TJSonSbtpHeader);
  RegisterChildNode('Variable', TJSonSbtpVariables);

  FFileImpl := Pointer(ISbtpFile(Self));
End;

Destructor TJSonSbtpFileImpl.Destroy();
Begin
  Clear();

  InHerited Destroy();
End;

Function TJSonSbtpFileImpl._Release() : Integer;
Begin
//  If GetRefCount() = 1 Then
//  Begin
//    If Not IsImplementorOf(FileImpl) Then
//      FileImpl.Assign(Self);
//  End;

  Result := InHerited _Release();
End;

Function TJSonSbtpFileImpl.GetImplementor() : ISbtpFile;
Begin
  Result := ISbtpFile(FFileImpl);
End;

Procedure TJSonSbtpFileImpl.Assign(ASource : IInterface);
Var lJSonSrc : IJSonSbtpFile;
    lSrc : ISbtpFile;
Begin
  If Supports(ASource, IHsJSonObject) And
     Supports(ASource, IJSonSbtpFile, lJSonSrc) Then
  Begin
    GetHeader().Assign(lJSonSrc.Header);
    GetItem().Assign(lJSonSrc.Item);
  End
  Else If Supports(ASource, ISbtpFile, lSrc) Then
  Begin
    GetHeader().Assign(lSrc.Header);
    GetItem().Assign(lSrc.Item);

    FFileImpl := Pointer(lSrc);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Procedure TJSonSbtpFileImpl.Clear();
Begin
  O['Header']   := Nil;
  O['Variable'] := Nil;
End;

Function TJSonSbtpFileImpl.GetHeader() : IJSonSbtpHeader;
Begin
  If O['Header'] = Nil Then
    O['Header'] := TJSonSbtpHeader.Create();

  Result := O['Header'] As IJSonSbtpHeader;
End;

Function TJSonSbtpFileImpl.GetIHeader() : ISbtpHeader;
Begin
  Result := GetHeader() As ISbtpHeader;
End;

Function TJSonSbtpFileImpl.GetItem() : IJSonSbtpVariables;
Begin
  If O['Variable'] = Nil Then
    O['Variable'] := TJSonSbtpVariables.Create(svtArray);

  Result := A['Variable'] As IJSonSbtpVariables
End;

Function TJSonSbtpFileImpl.GetIItem() : ISbtpVariables;
Begin
  Result := GetItem() As ISbtpVariables
End;

end.
