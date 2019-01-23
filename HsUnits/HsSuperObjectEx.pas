unit HsSuperObjectEx;

interface

Uses Classes, SuperObject, HsInterfaceEx;

Type
  TSuperObjectEx = Class;
  TSuperObjectExClass = Class Of TSuperObjectEx;
  ISuperObjectExList = Interface;

  ISuperObjectEx = Interface(ISuperObject)
    ['{4B61686E-29A0-2112-AF18-F50EAB511A07}']
    Procedure RegisterChildNode(Const Path : SOString; ChildNodeClass : TSuperObjectExClass);
    Function  GetChildNodeClass(Const Path : SOString; Const AIsList : Boolean = False) : TSuperObjectExClass;

    Function  GetO(Const Path : SOString) : ISuperObjectEx;
    Procedure PutO(Const Path : SOString; Const Value: ISuperObjectEx);
    Function  GetA(Const Path : SOString) : ISuperObjectExList;

    Property O[Const Path : SOString] : ISuperObjectEx     Read GetO Write PutO; Default;
    Property A[Const Path : SOString] : ISuperObjectExList Read GetA;

  End;

  ISuperObjectExList = Interface(ISuperObjectEx)
    ['{4B61686E-29A0-2112-B73D-7055FF275D6E}']
    Function GetItemClass() : TSuperObjectExClass;
    Function GetCount() : Integer;

    Function  GetItem(Const Index : Integer) : ISuperObjectEx;
    Procedure SetItem(Const Index : Integer; AItem : ISuperObjectEx);

    Function  GetB(Const Index : Integer) : Boolean;
    Procedure PutB(Const Index : Integer; Value: Boolean);
    Function  GetI(Const Index : Integer) : SuperInt;
    Procedure PutI(Const Index : Integer; Value: SuperInt);
    Function  GetD(Const Index : Integer) : Double;
    Procedure PutD(Const Index : Integer; Value: Double);
    Function  GetC(Const Index : Integer) : Currency;
    Procedure PutC(Const Index : Integer; Value: Currency);
    Function  GetS(Const Index : Integer) : SOString;
    Procedure PutS(Const Index : Integer; Value: SOString);

    Function Add() : ISuperObjectEx; OverLoad;
    Function Add(AObject : ISuperObjectEx) : Integer; OverLoad;

    Property ItemClass : TSuperObjectExClass Read GetItemClass;
    Property Count : Integer Read GetCount;

    Property Items[Const Index: Integer] : ISuperObjectEx Read GetItem Write SetItem; Default;

    Property B[Const Index : Integer] : Boolean  Read GetB Write PutB;
    Property I[Const Index : Integer] : SuperInt Read GetI Write PutI;
    Property D[Const Index : Integer] : Double   Read GetD Write PutD;
    Property C[Const Index : Integer] : Currency Read GetC Write PutC;
    Property S[Const Index : Integer] : SOString Read GetS Write PutS;

  End;

  TSuperObjectEx = Class(TSuperObject, IInterface, IInterfaceEx, ISuperObjectEx)
  Private
    FLstChildClass : TStringList;

  Protected
    //IInterfaceEx
    Function GetInterfaceObject() : TObject;
    Function GetController() : IInterfaceEx;

    Function  GetRefCount() : Integer;

    Function  GetIsContained() : Boolean;
    Procedure SetIsContained(Const AIsContained : Boolean);

    Function  GetHaveRefCount() : Boolean;
    Procedure SetHaveRefCount(Const AHaveRefCount : Boolean);

    //ISuperObject
    Function  GetDataType() : TSuperType;
    Function  GetDataPtr() : Pointer;
    Procedure SetDataPtr(Const Value: Pointer);

    Procedure RegisterChildNode(Const Path : SOString; ChildNodeClass: TSuperObjectExClass);
    Function  GetChildNodeClass(Const Path : SOString; Const AIsList : Boolean = False) : TSuperObjectExClass;

    Function  GetO(Const Path : SOString) : ISuperObjectEx; OverLoad;
    Procedure PutO(Const Path : SOString; Const Value: ISuperObjectEx); OverLoad;
    Function  GetA(Const Path : SOString) : ISuperObjectExList; OverLoad;

  Public
    Class Function GetDocBinding(AObject : ISuperObject; Const ANodeClass : TSuperObjectExClass) : ISuperObjectEx;

    Function   IsImplementorOf(Const I : IInterfaceEx) : Boolean;
    Procedure  AfterConstruction(); OverRide;
    Destructor Destroy(); OverRide;

  End;

  TSuperObjectExList = Class(TSuperObjectEx, ISuperObjectExList)
  Protected
    Function GetItemClass() : TSuperObjectExClass; Virtual;
    Function GetCount() : Integer;

    Function  GetItem(Const Index : Integer) : ISuperObjectEx;
    Procedure SetItem(Const Index : Integer; AItem : ISuperObjectEx);

    Function  GetB(Const Index : Integer) : Boolean; OverLoad;
    Procedure PutB(Const Index : Integer; Value: Boolean); OverLoad;
    Function  GetI(Const Index : Integer) : SuperInt; OverLoad;
    Procedure PutI(Const Index : Integer; Value: SuperInt); OverLoad;
    Function  GetD(Const Index : Integer) : Double; OverLoad;
    Procedure PutD(Const Index : Integer; Value: Double); OverLoad;
    Function  GetC(Const Index : Integer) : Currency; OverLoad;
    Procedure PutC(Const Index : Integer; Value: Currency); OverLoad;
    Function  GetS(Const Index : Integer) : SOString; OverLoad;
    Procedure PutS(Const Index : Integer; Value: SOString); OverLoad;

    Function Add() : ISuperObjectEx; OverLoad;
    Function Add(AObject : ISuperObjectEx) : Integer; OverLoad;

    Property Items[Const Index : Integer] : ISuperObjectEx Read GetItem Write SetItem;

  End;

Function ObjectFindFirstEx(Const obj: ISuperObject; Var F: TSuperObjectIter) : Integer;
Function ObjectFindNextEx(Var F: TSuperObjectIter) : Integer;

implementation

Uses Dialogs,
  SysUtils;

Function ObjectFindFirstEx(Const obj: ISuperObject; Var F: TSuperObjectIter) : Integer;
Var X : TSuperAvlEntry;
Begin
  Result := -1;
  
  If ObjectIsType(obj, stObject) Then
  Begin
    F.Ite := TSuperAvlIterator.Create(obj.AsObject);
    F.Ite.First();
    X := F.Ite.GetIter();

    If X <> Nil Then
    Begin
      F.key := X.Name;
      F.val := X.Value;
      Result := 0;
    End
    Else
    Begin
      ObjectFindClose(F);
      Result := -2;
    End;
  End;
End;

Function ObjectFindNextEx(Var F: TSuperObjectIter) : Integer;
Var X : TSuperAvlEntry;
Begin
  F.Ite.Next();
  X := F.Ite.GetIter();

  If X <> Nil Then
  Begin
    F.key := X.Name;
    F.val := X.Value;
    Result := 0;
  End
  Else
    Result := -1;
End;

Procedure TSuperObjectEx.AfterConstruction();
Begin
  InHerited AfterConstruction();

  FLstChildClass := TStringList.Create();
End;

Destructor TSuperObjectEx.Destroy();
Begin
  FreeAndNil(FLstChildClass);

  InHerited Destroy();
End;

Function TSuperObjectEx.IsImplementorOf(Const I : IInterfaceEx) : Boolean;
Begin
  Result := I.InterfaceObject = Self;
End;

Class Function TSuperObjectEx.GetDocBinding(AObject : ISuperObject; Const ANodeClass : TSuperObjectExClass) : ISuperObjectEx;
  Procedure InternalProcess(AParentNode : ISuperObjectEx; AStartPoint : TSuperObjectIter);
  Var ite : TSuperObjectIter;
      X   : Integer;
      lArray : ISuperObjectExList;
  Begin
    Case AStartPoint.val.DataType Of
      stString : AParentNode.S[AStartPoint.key] := AStartPoint.val.AsString;
      stBoolean : AParentNode.B[AStartPoint.key] := AStartPoint.val.AsBoolean;
      stInt : AParentNode.I[AStartPoint.key] := AStartPoint.val.AsInteger;
      stDouble : AParentNode.D[AStartPoint.key] := AStartPoint.val.AsDouble;
      stCurrency : AParentNode.C[AStartPoint.key] := AStartPoint.val.AsCurrency;

      stObject :
      Begin
        AParentNode[AStartPoint.key] :=
          AParentNode.GetChildNodeClass(AStartPoint.key).Create();

        If ObjectFindFirstEx(AStartPoint.val, ite) = 0 Then
        Try
          Repeat
            InternalProcess(AParentNode[AStartPoint.key], ite);
          Until ObjectFindNextEx(ite) <> 0;

          Finally
            ObjectFindClose(ite);
        End;
      End;

      stArray :
      Begin
        AParentNode[AStartPoint.key] :=
          AParentNode.GetChildNodeClass(AStartPoint.key, True).Create(stArray);

        For X := 0 To AStartPoint.val.AsArray.Length - 1 Do
        Begin
          Case AStartPoint.val.AsArray[X].DataType Of
            stString : AParentNode.A[AStartPoint.key].S[X] := AStartPoint.val.AsArray[X].AsString;
            stBoolean : AParentNode.A[AStartPoint.key].B[X] := AStartPoint.val.AsArray[X].AsBoolean;
            stInt : AParentNode.A[AStartPoint.key].I[X] := AStartPoint.val.AsArray[X].AsInteger;
            stDouble : AParentNode.A[AStartPoint.key].D[X] := AStartPoint.val.AsArray[X].AsDouble;
            stCurrency : AParentNode.A[AStartPoint.key].C[X] := AStartPoint.val.AsArray[X].AsCurrency;

            stObject :
            Begin
              If Supports(AParentNode.O[AStartPoint.key], ISuperObjectExList, lArray) Then
                AParentNode.A[AStartPoint.key].Add(lArray.ItemClass.Create());

              If ObjectFindFirstEx(AStartPoint.val.AsArray[X], ite) = 0 Then
              Try
                Repeat
                  InternalProcess(AParentNode.A[AStartPoint.key][X], ite);
                Until ObjectFindNextEx(ite) <> 0;

                Finally
                  ObjectFindClose(ite);
              End;
            End;
          End;
        End;
      End;
    End;
  End;

Var ite : TSuperObjectIter;
Begin
  If Supports(ANodeClass.Create(), ISuperObjectEx, Result) Then
  Begin
    If ObjectFindFirstEx(AObject, ite) = 0 Then
    Try
      Repeat
        InternalProcess(Result, ite);
      Until ObjectFindNextEx(ite) <> 0;

      Finally
        ObjectFindClose(ite);
    End;
  End
  Else
    Raise Exception.Create('ISuperObjectEx Not Implemented : ' + ANodeClass.ClassName);
End;

Function TSuperObjectEx.GetInterfaceObject() : TObject;
Begin
  Result := Self;
End;

Function TSuperObjectEx.GetController() : IInterfaceEx;
Begin
  Result := Nil;
End;

Function TSuperObjectEx.GetIsContained() : Boolean;
Begin
  Result := False;
End;

Procedure TSuperObjectEx.SetIsContained(Const AIsContained : Boolean);
Begin

End;

Function TSuperObjectEx.GetHaveRefCount() : Boolean;
Begin
  Result := True;
End;

Procedure TSuperObjectEx.SetHaveRefCount(Const AHaveRefCount : Boolean);
Begin

End;

Function TSuperObjectEx.GetDataType() : TSuperType;
Begin
  Result := InHerited DataType;
End;

Function TSuperObjectEx.GetDataPtr() : Pointer;
Begin
  Result := InHerited DataPtr;
End;

Procedure TSuperObjectEx.SetDataPtr(Const Value: Pointer);
Begin
  InHerited DataPtr := Value;
End;

Procedure TSuperObjectEx.RegisterChildNode(Const Path : SOString; ChildNodeClass: TSuperObjectExClass);
Begin
  FLstChildClass.AddObject(UpperCase(Path), TObject(ChildNodeClass));
End;

Function TSuperObjectEx.GetChildNodeClass(Const Path : SOString; Const AIsList : Boolean = False) : TSuperObjectExClass;
Var X : Integer;
    lPath : SOString;
Begin
  lPath := UpperCase(Path);
  If AIsList Then
    Result := TSuperObjectExList
  Else
    Result := TSuperObjectEx;

  For X := 0 To FLstChildClass.Count - 1 Do
    If SameText(FLstChildClass[X], lPath) Then
    Begin
      Result := TSuperObjectExClass(FLstChildClass.Objects[X]);
      Break;
    End;
End;

Function TSuperObjectEx.GetRefCount() : Integer;
Begin
  Result := InHerited RefCount;
End;

Function TSuperObjectEx.GetO(Const Path : SOString): ISuperObjectEx;
Begin
  Result := InHerited GetO(Path) As ISuperObjectEx;
End;

Procedure TSuperObjectEx.PutO(Const Path : SOString; Const Value: ISuperObjectEx);
Begin
  InHerited PutO(Path, Value);
End;

Function TSuperObjectEx.GetA(Const Path : SOString) : ISuperObjectExList;
Begin
  Result := InHerited GetO(Path) As ISuperObjectExList;
End;

Function TSuperObjectExList.GetItemClass() : TSuperObjectExClass;
Begin
  Result := TSuperObjectEx;
End;

Function TSuperObjectExList.GetItem(Const Index: Integer) : ISuperObjectEx;
Begin
  Result := AsArray[Index] As ISuperObjectEx;
End;

Procedure TSuperObjectExList.SetItem(Const Index: Integer; AItem : ISuperObjectEx);
Begin
  AsArray[Index] := AItem As ISuperObjectEx;
End;

Function TSuperObjectExList.GetB(Const Index : Integer) : Boolean;
Begin
  Result := AsArray.B[Index];
End;

Procedure TSuperObjectExList.PutB(Const Index : Integer; Value: Boolean);
Begin
  AsArray.B[Index] := Value;
End;

Function TSuperObjectExList.GetI(Const Index : Integer) : SuperInt;
Begin
  Result := AsArray.I[Index];
End;

Procedure TSuperObjectExList.PutI(Const Index : Integer; Value: SuperInt);
Begin
  AsArray.I[Index] := Value;
End;

Function TSuperObjectExList.GetD(Const Index : Integer) : Double;
Begin
  Result := AsArray.D[Index];
End;

Procedure TSuperObjectExList.PutD(Const Index : Integer; Value: Double);
Begin
  AsArray.D[Index] := Value;
End;

Function TSuperObjectExList.GetC(Const Index : Integer) : Currency;
Begin
  Result := AsArray.C[Index];
End;

Procedure TSuperObjectExList.PutC(Const Index : Integer; Value: Currency);
Begin
  AsArray.C[Index] := Value;
End;

Function TSuperObjectExList.GetS(Const Index : Integer) : SOString;
Begin
  Result := AsArray.S[Index];
End;

Procedure TSuperObjectExList.PutS(Const Index : Integer; Value: SOString);
Begin
  AsArray.S[Index] := Value;
End;

Function TSuperObjectExList.GetCount() : Integer;
Begin
  Result := AsArray.Length;
End;

Function TSuperObjectExList.Add(AObject : ISuperObjectEx) : Integer;
Begin
  AsArray.Add(AObject);
  Result := AsArray.Length - 1;
End;

Function TSuperObjectExList.Add() : ISuperObjectEx;
Begin
  Result := GetItemClass().Create();//@@!!##stObject);
  AsArray.Add(Result);
End;

end.
