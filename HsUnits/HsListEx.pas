unit HsListEx;

interface

Uses Classes, Contnrs, Graphics, 
  HsInterfaceEx;

Type
  IListEx = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-9110-4FB79EAC143B}']
    Function  Get(Index: Integer): Pointer;
    Procedure Put(Index: Integer; Item: Pointer);
    Function  GetCapacity() : Integer;
    Procedure SetCapacity(NewCapacity: Integer);
    Function  GetCount() : Integer;
    Procedure SetCount(NewCount: Integer);

    Function  GetList() : {$If CompilerVersion < 24}PPointerList{$Else}TPointerList{$IfEnd};

    Function  Add(Item: Pointer): Integer;
    Procedure Clear();
    Procedure Delete(Index: Integer);
    Procedure Exchange(Index1, Index2: Integer);
    Function  Expand() : TList;
    Function  Extract(Item: Pointer): Pointer;
    Function  First() : Pointer;
    Function  IndexOf(Item: Pointer): Integer;
    Procedure Insert(Index: Integer; Item: Pointer);
    Function  Last() : Pointer;
    Procedure Move(CurIndex, NewIndex: Integer);
    Function  Remove(Item: Pointer): Integer;
    Procedure Pack();

    Property Items[Index: Integer] : Pointer Read Get Write Put; Default;

    Property Capacity : Integer      Read GetCapacity Write SetCapacity;
    Property Count    : Integer      Read GetCount;
    Property List     : {$If CompilerVersion < 24}PPointerList{$Else}TPointerList{$IfEnd} Read GetList;
    
  End;

  TInterfacedListEx = Class(TList, IListEx)
  Private
    FImpl : TInterfaceExImplementor;

  Protected
    Function GetImplementor() : TInterfaceExImplementor;
    Property IntfImpl : TInterfaceExImplementor Read GetImplementor Implements IListEx;

    Function  GetCapacity() : Integer;
    Function  GetCount() : Integer;
    Function  GetList() : {$If CompilerVersion < 24}PPointerList{$Else}TPointerList{$IfEnd};

  End;

  IClassListEx = Interface(IListEx)
    ['{4B61686E-29A0-2112-B085-BE982E6AB837}']
    Function  Get(Index : Integer): TClass;
    Procedure Put(Index : Integer; AClass : TClass);

    Function  Add(AClass : TClass) : Integer;
    Function  Extract(Item : TClass) : TClass;
    Function  Remove(AClass : TClass) : Integer;
    Function  IndexOf(AClass : TClass) : Integer;
    Function  First() : TClass;
    Function  Last() : TClass;
    Procedure Insert(Index : Integer; AClass : TClass);

    Property Items[Index : Integer] : TClass Read Get Write Put; Default;

  End;
    
  TInterfacedClassListEx = Class(TInterfacedListEx, IClassListEx)
  Protected
    Property IntfImpl : TInterfaceExImplementor Read GetImplementor Implements IClassListEx;

    Function  Get(Index : Integer) : TClass; OverLoad;
    Procedure Put(Index : Integer; AClass : TClass); OverLoad;

  Public
    Function  Add(AClass : TClass) : Integer; OverLoad;
    Function  Extract(Item : TClass) : TClass; OverLoad;
    Function  Remove(AClass : TClass) : Integer; OverLoad;
    Function  IndexOf(AClass : TClass) : Integer; OverLoad;
    Function  First() : TClass; OverLoad;
    Function  Last() : TClass; OverLoad;
    Procedure Insert(Index : Integer; AClass : TClass); OverLoad;

    Property Items[Index : Integer] : TClass Read Get Write Put; Default;

  End;

  TColorRec = Packed Record
    Case Boolean Of
      True : (Value : TColor);
      False : (Red, Green, Blue, Dummy : Byte);
  End;
    
  TColorList = Class(TList)
  Private
    Function  GetItem(Index : Integer) : TColor;
    Procedure SetItem(Index : Integer; Value : TColor);

    Function  GetItemRec(Index : Integer) : TColorRec;
    Procedure SetItemRec(Index : Integer; Value : TColorRec);

  Protected
    Procedure Notify(Ptr : Pointer; Action : TListNotification); OverRide;

  Public
    Property Items[Index : Integer] : TColor Read GetItem Write SetItem; Default;
    Property ItemsRec[Index : Integer] : TColorRec Read GetItemRec Write SetItemRec;

    Function Add(Const AValue : TColor) : Integer;
    Function Remove(Const AValue : TColor) : Integer;
    Function IndexOf(Const AValue : TColor) : Integer;

    Procedure Sort(); ReIntroduce;

  End;

  IIntegerListEx = Interface(IListEx)
    ['{4B61686E-29A0-2112-ACA3-F86BEF1929A4}']
    Function  Get(Index : Integer) : Integer;
    Procedure Put(Index : Integer; Value : Integer);

    Function Add(Const AValue : Integer) : Integer;
    Function Remove(Const AValue : Integer) : Integer;
    Function IndexOf(Const AValue : Integer) : Integer;
    Procedure Sort();

    Property Items[Index : Integer] : Integer Read Get Write Put; Default;

  End;

  TIntegerListEx = Class(TInterfacedListEx, IIntegerListEx)
  Protected
    Property IntfImpl : TInterfaceExImplementor Read GetImplementor Implements IIntegerListEx;

    Function  Get(Index : Integer) : Integer; OverLoad;
    Procedure Put(Index : Integer; Value : Integer); OverLoad;

  Public
    Property Items[Index : Integer] : Integer Read Get Write Put; Default;

    Function Add(Const AValue : Integer) : Integer; OverLoad;
    Function Remove(Const AValue : Integer) : Integer; OverLoad;
    Function IndexOf(Const AValue : Integer) : Integer; OverLoad;

    Procedure Sort(); ReIntroduce;

  End;  

implementation

Function TInterfacedListEx.GetImplementor() : TInterfaceExImplementor;
Begin
  If Not Assigned(FImpl) Then
    FImpl := TInterfaceExImplementor.Create(Self, True);
  Result := FImpl;
End;

Function TInterfacedListEx.GetCapacity() : Integer;
Begin
  Result := InHerited Capacity;
End;

Function TInterfacedListEx.GetCount() : Integer;
Begin
  Result := InHerited Count;
End;

Function TInterfacedListEx.GetList() : {$If CompilerVersion < 24}PPointerList{$Else}TPointerList{$IfEnd};
Begin
  Result := InHerited List;
End;

Function TInterfacedClassListEx.Get(Index : Integer) : TClass;
Begin
  Result := TClass(InHerited Items[Index]);
End;

Procedure TInterfacedClassListEx.Put(Index : Integer; AClass : TClass);
Begin
  InHerited Items[Index] := AClass;
End;

Function TInterfacedClassListEx.Add(AClass : TClass) : Integer;
Begin
  Result := InHerited Add(AClass);
End;

Function TInterfacedClassListEx.Extract(Item : TClass) : TClass;
Begin
  Result := TClass(InHerited Extract(Item));
End;

Function TInterfacedClassListEx.Remove(AClass : TClass) : Integer;
Begin
  Result := InHerited Remove(AClass);
End;

Function TInterfacedClassListEx.IndexOf(AClass : TClass) : Integer;
Begin
  Result := InHerited IndexOf(AClass);
End;

Function TInterfacedClassListEx.First() : TClass;
Begin
  Result := TClass(InHerited First());
End;

Function TInterfacedClassListEx.Last() : TClass;
Begin
  Result := TClass(InHerited Last());
End;

Procedure TInterfacedClassListEx.Insert(Index : Integer; AClass : TClass);
Begin
  InHerited Insert(Index, AClass);
End;

(******************************************************************************)

Procedure TColorList.Notify(Ptr: Pointer; Action: TListNotification);
Begin
  If Action In [lnExtracted, lnDeleted] Then
    Dispose(PColor(Ptr));
End;

Function TColorList.GetItem(Index : Integer) : TColor;
Begin
  Result := PColor(InHerited Items[Index])^;
End;

Procedure TColorList.SetItem(Index : Integer; Value : TColor);
Begin
  PColor(InHerited Items[Index])^ := Value;
End;

Function TColorList.GetItemRec(Index : Integer) : TColorRec;
Begin
  Result := TColorRec(Items[Index]);
End;

Procedure TColorList.SetItemRec(Index : Integer; Value : TColorRec);
Begin
  Items[Index] := TColor(Value);
End;

Function TColorList.Add(Const AValue : TColor) : Integer;
Var lNewColor : PColor;
Begin
  lNewColor  := New(PColor);
  lNewColor^ := AValue;
  Result     := InHerited Add(lNewColor);
End;

Function TColorList.Remove(Const AValue : TColor) : Integer;
Var X : Integer;
Begin
  Result := -1;
   
  For X := 0 To Count - 1 Do
    If Items[X] = AValue Then
    Begin
      Result := InHerited Remove(InHerited Items[X]);
      Break;
    End;
End;

Function TColorList.IndexOf(Const AValue : TColor) : Integer;
Var X : Integer;
Begin
  Result := -1;
  
  For X := 0 To Count - 1 Do
    If Items[X] = AValue Then
    Begin
      Result := X;
      Break;
    End;
End;

Procedure TColorList.Sort();
  Function InternalSort(Item1, Item2: Pointer) : Integer;
  Begin
    If PColor(Item1)^ > PColor(Item2)^ Then
      Result := 1
    Else If PColor(Item1)^ < PColor(Item2)^ Then
      Result := -1
    Else
      Result := 0;
  End;

Begin
  InHerited Sort(@InternalSort);
End;

Function TIntegerListEx.Get(Index : Integer) : Integer;
Begin
  Result := Integer(InHerited Items[Index]);
End;

Procedure TIntegerListEx.Put(Index : Integer; Value : Integer);
Begin
  InHerited Items[Index] := Pointer(Value);
End;

Function TIntegerListEx.Add(Const AValue : Integer) : Integer;
Begin
  Result := InHerited Add(Pointer(AValue));
End;

Function TIntegerListEx.Remove(Const AValue : Integer) : Integer;
Begin
  Result := IndexOf(AValue);
  If Result > -1 Then
    InHerited Delete(Result);
End;

Function TIntegerListEx.IndexOf(Const AValue : Integer) : Integer;
Var X : Integer;
Begin
  Result := -1;
  
  For X := 0 To Count - 1 Do
    If Items[X] = AValue Then
    Begin
      Result := X;
      Break;
    End;
End;

Procedure TIntegerListEx.Sort();
  Function InternalSort(Item1, Item2: Pointer) : Integer;
  Begin
    If Integer(Item1) > Integer(Item2) Then
      Result := 1
    Else If Integer(Item1) < Integer(Item2) Then
      Result := -1
    Else
      Result := 0;
  End;

Begin
  InHerited Sort(@InternalSort);
End;

end.
