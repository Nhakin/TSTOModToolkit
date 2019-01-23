unit TSTOSbtpImpl;

interface

Uses Windows, HsInterfaceEx, TSTOSbtpIntf;

Type
  TSbtpSubVariable = Class(TInterfacedObjectEx, ISbtpSubVariable)
  Private
    FVariableName : String;
    FVariableData : String;

  Protected
    Procedure Created(); OverRide;

    Function  GetVariableName() : String; Virtual;
    Procedure SetVariableName(Const AVariableName : String); Virtual;

    Function  GetVariableData() : String; Virtual;
    Procedure SetVariableData(Const AVariableData : String); Virtual;

    Procedure Clear();

    Procedure Assign(ASource : IInterface); ReIntroduce;

  End;

  TSbtpSubVariables = Class(TInterfaceListEx, ISbtpSubVariables)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : ISbtpSubVariable; OverLoad;
    Procedure Put(Index : Integer; Const Item : ISbtpSubVariable); OverLoad;

    Function Add() : ISbtpSubVariable; ReIntroduce; OverLoad;
    Function Add(Const AItem : ISbtpSubVariable) : Integer; OverLoad;

    Procedure Assign(ASource : IInterface); ReIntroduce; Virtual;
    Function IndexOf(Const AVariableName : String) : Integer; ReIntroduce; OverLoad;

  End;

  TSbtpSubVariablesClass = Class Of TSbtpSubVariables;
  TSbtpVariable = Class(TInterfacedObjectEx, ISbtpVariable)
  Private
    FVariableType : String;
    FSubItem      : ISbtpSubVariables;

  Protected
    Function GetSubItemClass() : TSbtpSubVariablesClass; Virtual;

    Function  GetVariableType() : String; Virtual;
    Procedure SetVariableType(Const AVariableType : String); Virtual;

    Function  GetNbSubItems() : DWord;

    Function  GetSubItem() : ISbtpSubVariables;

    Procedure Assign(ASource : IInterface); ReIntroduce;

  Public
    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;

  End;

  TSbtpVariables = Class(TInterfaceListEx, ISbtpVariables)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : ISbtpVariable; OverLoad;
    Procedure Put(Index : Integer; Const Item : ISbtpVariable); OverLoad;

    Function Add() : ISbtpVariable; ReIntroduce; OverLoad;
    Function Add(Const AItem : ISbtpVariable) : Integer; OverLoad;

    Procedure Assign(ASource : IInterface); ReIntroduce; Virtual;

    Function IndexOf(Const AVariableType : String) : Integer; ReIntroduce; OverLoad;

  End;

  TSbtpHeader = Class(TInterfacedObjectEx, ISbtpHeader)
  Private
    FHeader        : String;
    FHeaderPadding : Word;

  Protected
    Function  GetHeader() : String;
    Procedure SetHeader(Const AHeader : String);

    Function  GetHeaderPadding() : Word;
    Procedure SetHeaderPadding(Const AHeaderPadding : Word);

    Procedure Clear();

    Procedure Assign(ASource : IInterface); ReIntroduce;

  End;

  TSbtpHeaderClass = Class Of TSbtpHeader;
  TSbtpVariablesClass = Class Of TSbtpVariables;
  
  TSbtpFile = Class(TInterfacedObjectEx, ISbtpFile)
  Private
    FHeader : ISbtpHeader;
    FItem   : ISbtpVariables;

  Protected
    Function  GetHeaderClass() : TSbtpHeaderClass; Virtual;
    Function  GetItemClass() : TSbtpVariablesClass; Virtual;

    Function  GetHeader() : ISbtpHeader;
    Function  GetItem() : ISbtpVariables;

    Procedure Clear();

    Procedure Assign(ASource : IInterface); ReIntroduce;

  Public
    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;

  End;

  TSbtpFiles = Class(TInterfaceListEx, ISbtpFiles)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : ISbtpFile; OverLoad;
    Procedure Put(Index : Integer; Const Item : ISbtpFile); OverLoad;

    Function Add() : ISbtpFile; ReIntroduce; OverLoad;
    Function Add(Const AItem : ISbtpFile) : Integer; OverLoad;

    Procedure Assign(ASource : IInterface); ReIntroduce; Virtual;

  End;

implementation

Uses Dialogs, 
  SysUtils, RtlConsts;

Procedure TSbtpSubVariable.Created();
Begin
  InHerited Created();

  Clear();
End;

Procedure TSbtpSubVariable.Clear();
Begin
  FVariableName := '';
  FVariableData := '';
End;

Procedure TSbtpSubVariable.Assign(ASource : IInterface);
Var lSrc : ISbtpSubVariable;
Begin
  If Supports(ASource, ISbtpSubVariable, lSrc) Then
  Begin
    FVariableName := lSrc.VariableName;
    FVariableData := lSrc.VariableData;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TSbtpSubVariable.GetVariableName() : String;
Begin
  Result := FVariableName;
End;

Procedure TSbtpSubVariable.SetVariableName(Const AVariableName : String);
Begin
  FVariableName := AVariableName;
End;

Function TSbtpSubVariable.GetVariableData() : String;
Begin
  Result := FVariableData;
End;

Procedure TSbtpSubVariable.SetVariableData(Const AVariableData : String);
Begin
  FVariableData := AVariableData;
End;

Function TSbtpSubVariables.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TSbtpSubVariable;
End;

Function TSbtpSubVariables.Get(Index : Integer) : ISbtpSubVariable;
Begin
  Result := InHerited Items[Index] As ISbtpSubVariable;
End;

Procedure TSbtpSubVariables.Put(Index : Integer; Const Item : ISbtpSubVariable);
Begin
  InHerited Items[Index] := Item;
End;

Function TSbtpSubVariables.Add() : ISbtpSubVariable;
Begin
  Result := InHerited Add() As ISbtpSubVariable;
End;

Function TSbtpSubVariables.Add(Const AItem : ISbtpSubVariable) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Procedure TSbtpSubVariables.Assign(ASource : IInterface);
Var lSrc : ISbtpSubVariables;
    X    : Integer;
Begin
  If Supports(ASource, ISbtpSubVariables, lSrc) Then
  Begin
    If Not IsImplementorOf(lSrc) Then
    Begin
      Clear();

      For X := 0 To lSrc.Count - 1 Do
        Add().Assign(lSrc[X]);
    End;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TSbtpSubVariables.IndexOf(Const AVariableName : String) : Integer;
Var X : Integer;
Begin
  Result := -1;

  For X := 0 To Count - 1 Do
    If SameText(Get(X).VariableName, AVariableName) Then
    Begin
      Result := X;
      Break;
    End;
End;

Procedure TSbtpVariable.AfterConstruction();
Begin
  InHerited AfterConstruction();

  FSubItem := GetSubItemClass().Create();
End;

Procedure TSbtpVariable.BeforeDestruction();
Begin
  FSubItem := Nil;

  InHerited BeforeDestruction();
End;

Function TSbtpVariable.GetSubItemClass() : TSbtpSubVariablesClass;
Begin
  Result := TSbtpSubVariables;
End;

Procedure TSbtpVariable.Assign(ASource : IInterface);
Var lSrc : ISbtpVariable;
Begin
  If Supports(ASource, ISbtpVariable, lSrc) Then
  Begin
    FVariableType := lSrc.VariableType;
    FSubItem.Assign(lSrc.SubItem);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TSbtpVariable.GetVariableType() : String;
Begin
  Result := FVariableType;
End;

Procedure TSbtpVariable.SetVariableType(Const AVariableType : String);
Begin
  FVariableType := AVariableType;
End;

Function TSbtpVariable.GetNbSubItems() : DWord;
Begin
  Result := FSubItem.Count;
End;

Function TSbtpVariable.GetSubItem() : ISbtpSubVariables;
Begin
  Result := FSubItem;
End;

Function TSbtpVariables.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TSbtpVariable;
End;

Function TSbtpVariables.Get(Index : Integer) : ISbtpVariable;
Begin
  Result := InHerited Items[Index] As ISbtpVariable;
End;

Procedure TSbtpVariables.Put(Index : Integer; Const Item : ISbtpVariable);
Begin
  InHerited Items[Index] := Item;
End;

Function TSbtpVariables.Add() : ISbtpVariable;
Begin
  Result := InHerited Add() As ISbtpVariable;
End;

Function TSbtpVariables.Add(Const AItem : ISbtpVariable) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Procedure TSbtpVariables.Assign(ASource : IInterface);
Var lSrc : ISbtpVariables;
    X : Integer;
Begin
  If Supports(ASource, ISbtpVariables, lSrc) Then
  Begin
    If Not IsImplementorOf(lSrc) Then
    Begin
      Clear();
      For X := 0 To lSrc.Count - 1 Do
        Add().Assign(lSrc[X]);
    End;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TSbtpVariables.IndexOf(Const AVariableType : String) : Integer;
Var X : Integer;
Begin
  Result := -1;

  For X := 0 To Count - 1 Do
    If SameText(Get(X).VariableType, AVariableType) Then
    Begin
      Result := X;
      Break;
    End;
End;

Procedure TSbtpHeader.Clear();
Begin
  FHeader        := '';
  FHeaderPadding := 0;
End;

Procedure TSbtpHeader.Assign(ASource : IInterface);
Var lSrc : ISbtpHeader;
Begin
  If Supports(ASource, ISbtpHeader, lSrc)  Then
  Begin
    FHeader        := lSrc.Header;
    FHeaderPadding := lSrc.HeaderPadding;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TSbtpHeader.GetHeader() : String;
Begin
  Result := FHeader;
End;

Procedure TSbtpHeader.SetHeader(Const AHeader : String);
Begin
  FHeader := AHeader;
End;

Function TSbtpHeader.GetHeaderPadding() : Word;
Begin
  Result := FHeaderPadding;
End;

Procedure TSbtpHeader.SetHeaderPadding(Const AHeaderPadding : Word);
Begin
  FHeaderPadding := AHeaderPadding;
End;

Procedure TSbtpFile.AfterConstruction();
Begin
  InHerited AfterConstruction();

  FHeader := GetHeaderClass().Create();
  FItem   := GetItemClass().Create();
End;

Procedure TSbtpFile.BeforeDestruction();
Begin
  FHeader := Nil;
  FItem   := Nil;

  InHerited BeforeDestruction();
End;

Function TSbtpFile.GetHeaderClass() : TSbtpHeaderClass;
Begin
  Result := TSbtpHeader;
End;

Function TSbtpFile.GetItemClass() : TSbtpVariablesClass;
Begin
  Result := TSbtpVariables;
End;

Procedure TSbtpFile.Clear();
Begin
End;

Procedure TSbtpFile.Assign(ASource : IInterface);
Var lSrc : ISbtpFile;
Begin
  If Supports(ASource, ISbtpFile, lSrc) Then
  Begin
    FHeader.Assign(lSrc.Header);
    FItem.Assign(lSrc.Item);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TSbtpFile.GetHeader() : ISbtpHeader;
Begin
  Result := FHeader;
End;

Function TSbtpFile.GetItem() : ISbtpVariables;
Begin
  Result := FItem;
End;

Function TSbtpFiles.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TSbtpFile;
End;

Function TSbtpFiles.Get(Index : Integer) : ISbtpFile;
Begin
  Result := InHerited Items[Index] As ISbtpFile;
End;

Procedure TSbtpFiles.Put(Index : Integer; Const Item : ISbtpFile);
Begin
  InHerited Items[Index] := Item;
End;

Function TSbtpFiles.Add() : ISbtpFile;
Begin
  Result := InHerited Add() As ISbtpFile;
End;

Function TSbtpFiles.Add(Const AItem : ISbtpFile) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Procedure TSbtpFiles.Assign(ASource : IInterface);
Var lSrc : ISbtpFiles;
    X    : Integer;
Begin
  If Supports(ASource, ISbtpFiles, lSrc) Then
  Begin
    Clear();

    For X := 0 To lSrc.Count - 1 Do
      Add().Assign(lSrc[X]);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

end.
