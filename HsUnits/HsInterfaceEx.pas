unit HsInterfaceEx;

interface

Uses Classes;

Type
  IInterfaceEx = Interface(IInterface)
    ['{4B61686E-29A0-2112-A2FF-12982276F9A7}']
    Function GetInterfaceObject() : TObject;
    Function GetRefCount() : Integer;
    Function GetController() : IInterfaceEx;

    Function  GetIsContained() : Boolean;
    Procedure SetIsContained(Const AIsContained : Boolean);

    Function  GetHaveRefCount() : Boolean;
    Procedure SetHaveRefCount(Const AHaveRefCount : Boolean);

    Property InterfaceObject : TObject      Read GetInterfaceObject;
    Property RefCount        : Integer      Read GetRefCount;
    Property Controller      : IInterfaceEx Read GetController;
    Property IsContained     : Boolean      Read GetIsContained  Write SetIsContained;
    Property HaveRefCount    : Boolean      Read GetHaveRefCount Write SetHaveRefCount;
    
  End;
  PInterfaceEx = ^IInterfaceEx;
  
  TInterfacedObjectExClass = Class Of TInterfacedObjectEx;
  TInterfacedObjectEx = Class(TObject, IInterface, IInterfaceEx)
  {$If CompilerVersion >= 18.5}Strict{$IfEnd} Private
    FHaveRefCount : Boolean;
    FIsContained  : Boolean;

    FRefCount   : Integer;
    FController : Pointer;

  Protected
    Procedure Created(); Virtual;

    //IInterface
    Function QueryInterface(Const IID: TGUID; Out Obj) : HResult; Virtual; StdCall;
    Function _AddRef() : Integer; Virtual; StdCall;
    Function _Release() : Integer; Virtual; StdCall;

    //IInterfaceEx
    Function GetInterfaceObject() : TObject; Virtual;
    Function GetRefCount() : Integer;

    Function  GetController() : IInterfaceEx;
    Procedure SetController(AController : IInterfaceEx);

    Function  GetIsContained() : Boolean;
    Procedure SetIsContained(Const AIsContained : Boolean);

    Function  GetHaveRefCount() : Boolean;
    Procedure SetHaveRefCount(Const AHaveRefCount : Boolean);

    Property HaveRefCount : Boolean Read GetHaveRefCount Write SetHaveRefCount;

  Public
    Function  IsImplementorOf(Const I : IInterfaceEx) : Boolean;

    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;
    Class Function NewInstance() : TObject; OverRide;

    Constructor Create(Const Controller : IInterfaceEx; Const AIsContained : Boolean = False); OverLoad; Virtual;
    Constructor Create(Const AHaveRefCount : Boolean = True); OverLoad; Virtual;

  End;

  TInterfaceState = (isCreating, isDestroying);
  TInterfaceStates = Set Of TInterfaceState;

  TInterfaceExImplementor = Class(TInterfacedObjectEx)
  {$If CompilerVersion >= 18.5}Strict{$IfEnd} Private
    FOwner     : TObject;
    FFreeOwner : Boolean;

  Protected
    Function _Release() : Integer; OverRide; StdCall;
    Function QueryInterface(Const IID: TGUID; Out Obj) : HResult; OverRide; StdCall;

    Function GetInterfaceObject() : TObject; OverRide;

  Public
    Constructor Create(AOwner : TObject; Const AFreeOwner : Boolean = True); ReIntroduce; Virtual;

  End;

(******************************************************************************)
{
> 0 (positive) Item1 is greater than Item2
0 Item1 is equal to Item2
< 0 (negative) Item1 is less than Item2
}
  IInterfaceExEnumerator = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-8592-5FA941048707}']
    Function GetCurrent() : IInterfaceEx;
    Function MoveNext() : Boolean;

    Property Current : IInterfaceEx Read GetCurrent;

  End;

  TInterfaceListExSortCompare = Function(Item1, Item2 : IInterfaceEx) : Integer Of Object;
  IInterfaceListEx = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-99C8-A98B57DAD3AD}']
    Function  Get(Index : Integer) : IInterfaceEx;
    Procedure Put(Index : Integer; Const Item : IInterfaceEx);

    Function  GetEnumerator() : IInterfaceExEnumerator;
    
    Function  GetCapacity() : Integer;
    Procedure SetCapacity(NewCapacity: Integer);

    Function  GetCount() : Integer;

//    Procedure Sort(Compare : TInterfaceListExSortCompare);
    
    Function  Add() : IInterfaceEx; OverLoad;
    Function  Add(Const Item : IInterfaceEx) : Integer; OverLoad;
    Procedure Insert(Index : Integer; Const Item : IInterfaceEx);
    Function  Remove(Const Item : IInterfaceEx) : Integer;
    Function  Extract(Const Item : IInterfaceEx) : IInterfaceEx;
    Procedure Exchange(Const Index1, Index2 : Integer);
    Procedure Move(CurIndex, NewIndex : Integer);
    Procedure Delete(Const Index : Integer);

    Procedure Clear();
    Function  IndexOf(Const Item: IInterfaceEx): Integer;

    Property Items[Index : Integer] : IInterfaceEx Read Get Write Put; Default;

    Property Enumerator : IInterfaceExEnumerator Read GetEnumerator;

    Property Capacity : Integer Read GetCapacity Write SetCapacity;
    Property Count    : Integer Read GetCount;

  End;

  TInterfaceExEnumeratorClass = Class Of TInterfaceExEnumerator;
  TInterfaceExEnumerator = Class(TInterfacedObjectEx, IInterfaceExEnumerator)
  {$If CompilerVersion >= 18.5}Strict{$IfEnd} Private
    FList  : IInterfaceListEx;
    FIndex : Integer;
    
  Protected
    Function GetCurrent() : IInterfaceEx;
    Function MoveNext() : Boolean;

    Property Current : IInterfaceEx Read GetCurrent;

  Public
    Constructor Create(AList : IInterfaceListEx); ReIntroduce;
    
  End;

  TInterfaceListEx = Class(TInterfacedObjectEx, IInterfaceListEx)
  {$If CompilerVersion >= 18.5}Strict{$IfEnd} Private
    FList : TThreadList;

  Protected
    Procedure Created(); OverRide;

    Function GetItemClass() : TInterfacedObjectExClass; Virtual;
    Function GetEnumeratorClass() : TInterfaceExEnumeratorClass; Virtual;
    Procedure Notify(Ptr : Pointer; Action : TListNotification); Virtual;

    //IInterfaceListEx
    Function  Get(Index : Integer) : IInterfaceEx;
    Procedure Put(Index : Integer; Const Item : IInterfaceEx);

    Function  GetEnumerator() : IInterfaceExEnumerator;

    Function  GetCapacity() : Integer;
    Procedure SetCapacity(NewCapacity: Integer);

    Function  GetCount() : Integer;
    Procedure SetCount(NewCount: Integer);

    Procedure Sort(Compare : TInterfaceListExSortCompare);

    Function  Add() : IInterfaceEx; OverLoad; Virtual;
    Function  Add(Const Item : IInterfaceEx) : Integer; OverLoad; Virtual;
    Procedure Insert(Index : Integer; Const Item : IInterfaceEx);
    Function  Remove(Const Item : IInterfaceEx) : Integer; Virtual;
    Function  Extract(Const Item : IInterfaceEx) : IInterfaceEx;
    Procedure Exchange(Const Index1, Index2 : Integer);
    Procedure Move(CurIndex, NewIndex : Integer);
    Procedure Delete(Const Index : Integer);

    Procedure Clear(); Virtual;
    Function  IndexOf(Const Item : IInterfaceEx) : Integer; Virtual;

    Property Items[Index : Integer] : IInterfaceEx Read Get Write Put; Default;

    Property Enumerator : IInterfaceExEnumerator Read GetEnumerator;

    Property Capacity : Integer Read GetCapacity Write SetCapacity;
    Property Count    : Integer Read GetCount    Write SetCount;
    
  Public
    Destructor  Destroy(); OverRide;

  End;

Procedure RegisterInterface(Const AInterfaceName : String; Const AIID : TGUID);

Function GetInterfaceName(Const AIID : TGUID) : String; OverLoad;
Function GetInterfaceName(Const I : IInterface) : String; OverLoad;
Function GetInterfaceIID(Const I : IInterface; Var IID : TGUID) : Boolean;
Function GetImplementingObject(Const I : IInterface; Var Obj : TObject) : Boolean;

implementation

Uses Dialogs, TypInfo,
  RTLConsts, SysUtils;

Type
  IInterfaceIdentEx = Interface(IInterfaceEx)
    ['{178F63AF-29A0-2112-AD92-B978CFF3CCDD}']
    Function  GetIID() : TGUID;
    Procedure SetIID(Const AIID : TGUID);

    Function  GetInterfaceName() : String;
    Procedure SetInterfaceName(Const AInterfaceName : String);

    Property IID           : TGUID  Read GetIID           Write SetIID;
    Property InterfaceName : String Read GetInterfaceName Write SetInterfaceName;

  End;

  TInterfaceIdentEx = Class(TInterfacedObjectEx, IInterfaceIdentEx)
  Private
    FIID : TGUID;
    FInterfaceName : String;

  Protected
    Function  GetIID() : TGUID;
    Procedure SetIID(Const AIID : TGUID);

    Function  GetInterfaceName() : String;
    Procedure SetInterfaceName(Const AInterfaceName : String);
  
  Public
    Property IID           : TGUID  Read FIID           Write FIID;
    Property InterfaceName : String Read FInterfaceName Write FInterfaceName;

  End;

  IInterfaceIdentsEx = Interface(IInterfaceListEx)
    ['{32881A9C-29A0-2112-A85B-535A2F444862}']
    Function  Get(Index: Integer) : IInterfaceIdentEx;
    Procedure Put(Index: Integer; Const Item: IInterfaceIdentEx);
    Function  Add() : IInterfaceIdentEx;
    Function  IndexOf(Const AIID : TGUID) : Integer;

    Property Items[Index: Integer] : IInterfaceIdentEx Read Get Write Put; Default;

  End;

  TInterfaceIdentsEx = Class(TInterfaceListEx, IInterfaceIdentsEx)
  Protected
    Function  Get(Index: Integer) : IInterfaceIdentEx; OverLoad;
    Procedure Put(Index: Integer; Const Item: IInterfaceIdentEx); OverLoad;
    Function  Add() : IInterfaceIdentEx; ReIntroduce; OverLoad;
    Function  IndexOf(Const AIID : TGUID) : Integer; ReIntroduce; OverLoad;

  Public
    Property Items[Index: Integer] : IInterfaceIdentEx Read Get Write Put; Default;

  End;

Var
  gInterfaceList : IInterfaceIdentsEx;

Function TInterfaceIdentEx.GetIID() : TGUID;
Begin
  Result := FIID;
End;

Procedure TInterfaceIdentEx.SetIID(Const AIID : TGUID);
Begin
  FIID := AIID;
End;

Function TInterfaceIdentEx.GetInterfaceName() : String;
Begin
  Result := FInterfaceName;
End;

Procedure TInterfaceIdentEx.SetInterfaceName(Const AInterfaceName : String);
Begin
  FInterfaceName := AInterfaceName;
End;

Function TInterfaceIdentsEx.Get(Index: Integer) : IInterfaceIdentEx;
Begin
  Result := InHerited Items[Index] As IInterfaceIdentEx;
End;

Procedure TInterfaceIdentsEx.Put(Index: Integer; Const Item: IInterfaceIdentEx);
Begin
  InHerited Items[Index] := Item As IInterfaceIdentEx;
End;

Function TInterfaceIdentsEx.Add() : IInterfaceIdentEx;
Begin
  Result := TInterfaceIdentEx.Create();
  InHerited Add(Result As IInterfaceEx);
End;

Function TInterfaceIdentsEx.IndexOf(Const AIID : TGUID) : Integer;
Var X : Integer;
Begin
  Result := -1;

  For X := 0 To Count - 1 Do
    If IsEqualGUID(Items[X].IID, AIID) Then
    Begin
      Result := X;
      Break;
    End;
End;

(******************************************************************************)
{
http://hallvards.blogspot.ca/2006/09/hack11-get-guid-of-interface-reference.html
http://blog.synopse.info/post/2012/06/13/Retrieve-the-object-instance-from-an-interface
http://blog.barrkel.com/2011/03/ugly-alternative-to-interface-to-object.html
}
Function GetPIMTOffset(Const I : IInterface) : Integer;
// PIMT = Pointer to Interface Method Table
Const
  AddByte = $04244483; // opcode for ADD DWORD PTR [ESP+4], Shortint
  AddLong = $04244481; // opcode for ADD DWORD PTR [ESP+4], Longint

Type
  TAdjustSelfThunk = Packed Record //PAdjustSelfThunk(PPointer(PPointer(I)^)^)^
    Case AddInstruction : LongInt Of
      AddByte : (AdjustmentByte : ShortInt);
      AddLong : (AdjustmentLong : LongInt);
  End;
  PAdjustSelfThunk = ^TAdjustSelfThunk;
  TInterfaceMT = Packed Record
    QueryInterfaceThunk : PAdjustSelfThunk;
  End;
  PInterfaceMT = ^TInterfaceMT;
  TInterfaceRef = ^PInterfaceMT;
Begin
  Result := -1;
  
  If Assigned(Pointer(I)) Then
  Try
    With TInterfaceRef(I)^.QueryInterfaceThunk^ Do
      Case AddInstruction Of
        AddByte: Result := -AdjustmentByte;
        AddLong: Result := -AdjustmentLong;
      End;

    Except
      // Protect against non-Delphi or invalid interface references
  End;
End;

Function GetImplementingObject(Const I : IInterface; Var Obj : TObject) : Boolean;
Var lOffset : Integer;
Begin
  lOffset := GetPIMTOffset(I);

  If lOffset > 0 Then
    Obj := TObject(PAnsiChar(I) - lOffset)
  Else
    Obj := Nil;

  Result := Assigned(Obj);
End;

Function GetInterfaceEntry(Const I : IInterface) : PInterfaceEntry;
Var lOffset    : Integer;
    lObject    : TObject;
    lIntfTable : PInterfaceTable;
    X          : Integer;
    lCurClass  : TClass;
Begin
  Result  := Nil;
  lOffset := GetPIMTOffset(I);

  If (lOffset >= 0) And GetImplementingObject(I, lObject) Then
  Begin
    lCurClass := lObject.ClassType;
    While Assigned(lCurClass) And (Result = Nil) Do
    Begin
      lIntfTable := lCurClass.GetInterfaceTable();

      If Assigned(lIntfTable) Then
        For X := 0 to lIntfTable.EntryCount - 1 Do
          If PInterfaceEntry(@lIntfTable.Entries[X]).IOffset = lOffset Then
            Result := @lIntfTable.Entries[X];

      lCurClass := lCurClass.ClassParent;
    End;
  End;
End;

Function GetInterfaceIID(Const I : IInterface; Var IID : TGUID) : Boolean;
Var InterfaceEntry : PInterfaceEntry;
Begin
  InterfaceEntry := GetInterfaceEntry(I);
  Result := Assigned(InterfaceEntry);

  If Result Then
    IID := InterfaceEntry.IID;
End;

Function GetInterfaceName(Const AIID : TGUID) : String;
Var X : Integer;
Begin
  Result := GUIDToString(AIID);
  If Assigned(gInterfaceList) Then
    For X := 0 To gInterfaceList.Count - 1 Do
      If IsEqualGUID(gInterfaceList[X].IID, AIID) Then
      Begin
        Result := gInterfaceList[X].InterfaceName;
        Break;
      End;
End;

Function GetInterfaceName(Const I : IInterface) : String;
Var lGuid : TGUID;
Begin
{
  lGuid := GetTypeData(TypeInfo(IInterface))^.Guid;
  Result :=  GetInterfaceName(lGuid)
}
  If GetInterfaceIID(I, lGuid) Then
    Result := GetInterfaceName(lGuid)
  Else
    Result := '';
End;

(******************************************************************************)

{$If CompilerVersion < 23}
  {$Define CPUX86}
{$IfEnd}

{$IfDef CPUX86}
Function InterlockedIncrement(Var I : Integer) : Integer;
Asm
  MOV  EDX,1
  XCHG EAX,EDX
  LOCK XADD  [EDX],EAX
  INC  EAX
End;

Function InterlockedDecrement(Var I : Integer) : Integer;
Asm
  MOV  EDX,-1
  XCHG EAX,EDX
  LOCK XADD  [EDX],EAX
  DEC  EAX
End;
{$EndIf}

{$IfDef CPUX64}
Function InterlockedDecrement(Var I : LongInt) : LongInt;
Asm
  MOV  EAX,-1
  LOCK XADD  [RCX].Integer,EAX
  DEC  EAX
End;

Function InterlockedIncrement(Var I : LongInt) : LongInt;
Asm
  MOV  EAX,1
  LOCK XADD  [RCX].Integer,EAX
  INC  EAX
End;
{$EndIf}

Constructor TInterfacedObjectEx.Create(Const Controller: IInterfaceEx; Const AIsContained : Boolean = False);
Begin
  InHerited Create();

  FController   := Pointer(Controller);
  FIsContained  := AIsContained;
  FHaveRefCount := False;

  Created();
End;

Constructor TInterfacedObjectEx.Create(Const AHaveRefCount : Boolean = True);
Begin
  InHerited Create();

  FController   := Nil;
  FHaveRefCount := AHaveRefCount;

  Created();
End;

Class Function TInterfacedObjectEx.NewInstance() : TObject;
Begin
  Result := InHerited NewInstance();
  TInterfacedObjectEx(Result).FRefCount := 1;
End;

Procedure TInterfacedObjectEx.AfterConstruction();
Begin
  InterlockedDecrement(FRefCount);
End;

Procedure TInterfacedObjectEx.BeforeDestruction();
Begin
  If FHaveRefCount And (FRefCount <> 0) Then
    Error(reInvalidPtr);
End;

Function TInterfacedObjectEx.IsImplementorOf(Const I : IInterfaceEx) : Boolean;
Begin
  Result := I.InterfaceObject = Self;
End;

Procedure TInterfacedObjectEx.Created();
Begin

End;

Function TInterfacedObjectEx.QueryInterface(Const IID: TGUID; Out Obj) : HResult;
Begin
  If Assigned(FController) And Not FIsContained Then
    Result := IInterfaceEx(FController).QueryInterface(IID, Obj)
  Else
  Begin
    If GetInterface(IID, Obj) Then
      Result := S_OK
    Else
      Result := E_NOINTERFACE;
  End;
End;

Function TInterfacedObjectEx._AddRef() : Integer;
Begin
  If Assigned(FController) Then
    Result := IInterfaceEx(FController)._AddRef()
  Else
  Begin
    If FHaveRefCount Then
      Result := InterlockedIncrement(FRefCount)
    Else
      Result := -1;
  End
End;

Function TInterfacedObjectEx._Release() : Integer;
Begin
  If Assigned(FController) Then
    Result := IInterfaceEx(FController)._Release()
  Else
  Begin
    If FHaveRefCount Then
    Begin
      Result := InterlockedDecrement(FRefCount);

      If Result = 0 Then
        Destroy();
    End
    Else
      Result := -1;
  End;
End;

Function TInterfacedObjectEx.GetInterfaceObject() : TObject;
Begin
  Result := Self;
End;

Function TInterfacedObjectEx.GetRefCount() : Integer;
Begin
  If Assigned(FController) Then
    Result := IInterfaceEx(FController).RefCount
  Else
    Result := FRefCount;
End;

Function TInterfacedObjectEx.GetController() : IInterfaceEx;
Begin
  Result := IInterfaceEx(FController);
End;

Procedure TInterfacedObjectEx.SetController(AController : IInterfaceEx);
Begin
  FController := Pointer(AController);
End;

Function TInterfacedObjectEx.GetIsContained() : Boolean;
Begin
  Result := FIsContained;
End;

Procedure TInterfacedObjectEx.SetIsContained(Const AIsContained : Boolean);
Begin
  If Assigned(FController) Then
    FIsContained := AIsContained
  Else
    FIsContained := False;
End;

Function TInterfacedObjectEx.GetHaveRefCount() : Boolean;
Begin
  Result := FHaveRefCount;
End;

Procedure TInterfacedObjectEx.SetHaveRefCount(Const AHaveRefCount : Boolean);
Begin
  If FHaveRefCount <> AHaveRefCount Then
  Begin
    FHaveRefCount := AHaveRefCount;

    If FHaveRefCount Then
      FRefCount := 1
    Else
      FRefCount := 0;
  End;
End;

(******************************************************************************)

Constructor TInterfaceExImplementor.Create(AOwner : TObject; Const AFreeOwner : Boolean = True);
Begin
  InHerited Create(True);

  FOwner     := AOwner;
  FFreeOwner := AFreeOwner;
End;

Function TInterfaceExImplementor._Release() : Integer;
Begin
  Result := InHerited _Release();

  If Result = 0 Then
  Begin
    If Assigned(FOwner) And FFreeOwner Then
      FOwner.Free();
  End;
End;

Function TInterfaceExImplementor.QueryInterface(Const IID: TGUID; Out Obj) : HResult; StdCall;
Begin
  If Assigned(FOwner) And Supports(FOwner, IID, Obj) Then
    Result := S_OK
  Else
    Result := InHerited QueryInterface(IID, Obj);
End;

Function TInterfaceExImplementor.GetInterfaceObject() : TObject;
Begin
  If Assigned(FOwner) Then
    Result := FOwner
  Else
    Result := InHerited GetInterfaceObject();
End;

(******************************************************************************)

Constructor TInterfaceExEnumerator.Create(AList : IInterfaceListEx);
Begin
  InHerited Create(True);

  FList  := AList;
  FIndex := -1;
End;

Function TInterfaceExEnumerator.GetCurrent() : IInterfaceEx;
Begin
  Result := FList[FIndex];
End;

Function TInterfaceExEnumerator.MoveNext() : Boolean;
Begin
  If (FIndex >= FList.Count) Then
    Result := False
  Else
  Begin
    Inc(FIndex);
    Result := (FIndex < FList.Count);
  End;
End;

Procedure TInterfaceListEx.Created();
Begin
  InHerited Created();
  
  FList := TThreadList.Create();
End;

Destructor TInterfaceListEx.Destroy();
Begin
  Clear();
  FreeAndNil(FList);

  Inherited Destroy();
End;

Procedure TInterfaceListEx.Notify(Ptr : Pointer; Action : TListNotification);
Begin

End;

Function TInterfaceListEx.Get(Index : Integer): IInterfaceEx;
Begin
  With FList.LockList() Do
  Try
    If (Index < 0) Or (Index >= Count) Then
      Error(@SListIndexError, Index);
    Result := IInterfaceEx(List[Index]);

    Finally
      FList.UnlockList();
  End;
End;

Procedure TInterfaceListEx.Put(Index : Integer; Const Item : IInterfaceEx);
Begin
  With FList.LockList() Do
  Try
    If (Index < 0) Or (Index >= Count) Then
      Error(@SListIndexError, Index);

    If Item <> IInterfaceEx(List[Index]) Then
    Begin
      If List[Index] <> Nil Then
        Notify(List[Index], lnDeleted);
      IInterfaceEx(List[Index]) := Item;
      If List[Index] <> Nil Then
        Notify(List[Index], lnAdded);
    End;

    Finally
      FList.UnlockList();
  End;
End;

Function TInterfaceListEx.GetEnumerator() : IInterfaceExEnumerator;
Begin
  Result := GetEnumeratorClass().Create(Self); 
End;

Function TInterfaceListEx.GetCapacity() : Integer;
Begin
  With FList.LockList() Do
  Try
    Result := Capacity;

    Finally
      FList.UnlockList();
  End;
End;

Procedure TInterfaceListEx.SetCapacity(NewCapacity : Integer);
Begin
  With FList.LockList() Do
  Try
    Capacity := NewCapacity;

    Finally
      FList.UnlockList();
  End;
End;

Function TInterfaceListEx.GetCount() : Integer;
Begin
  With FList.LockList() Do
  Try
    Result := Count;

    Finally
      FList.UnlockList();
  End;
End;

Procedure TInterfaceListEx.SetCount(NewCount : Integer);
Begin
  With FList.LockList() Do
  Try
    Count := NewCount;

    Finally
      FList.UnlockList();
  End;
End;

Function TInterfaceListEx.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TInterfacedObjectEx;
End;

Function TInterfaceListEx.GetEnumeratorClass() : TInterfaceExEnumeratorClass;
Begin
  Result := TInterfaceExEnumerator;
End;

Function TInterfaceListEx.Add() : IInterfaceEx;
Begin
  Result := GetItemClass().Create(True);
  Add(Result);
  Notify(Pointer(Result), lnAdded);
End;

Function TInterfaceListEx.Add(Const Item : IInterfaceEx): Integer;
Begin
  With FList.LockList() Do
  Try
    Result := Add(Nil);
    Put(Result, Item);

    If Assigned(Item) Then
      Notify(Pointer(Item), lnAdded);

    Finally
      FList.UnlockList();
  End;
End;

Procedure TInterfaceListEx.Insert(Index : Integer; Const Item : IInterfaceEx);
Begin
  With FList.LockList() Do
  Try
    Insert(Index, Nil);
    Put(Index, Item);

    If Assigned(Item) Then
      Notify(Pointer(Item), lnAdded);

    Finally
      FList.UnlockList();
  End;
End;

Function TInterfaceListEx.Remove(Const Item : IInterfaceEx) : Integer;
Begin
  With FList.LockList() Do
  Try
    Result := IndexOf(Pointer(Item));

    If Result > -1 Then
    Begin
      Put(Result, Nil);
      Delete(Result);
      Notify(Pointer(Item), lnDeleted);
    End;

    Finally
      FList.UnlockList();
  End;
End;

Function TInterfaceListEx.Extract(Const Item : IInterfaceEx) : IInterfaceEx;
Var lIndex : Integer;
Begin
  With FList.LockList() Do
  Try
    lIndex := IndexOf(Pointer(Item));
    If lIndex > -1 Then
    Begin
      Result := IInterfaceEx(List[lIndex]);
      Delete(lIndex);
      Notify(Pointer(Result), lnExtracted);
    End;

    Finally
      FList.UnlockList();
  End;
End;

Procedure TInterfaceListEx.Exchange(Const Index1, Index2 : Integer);
Begin
  With FList.LockList() Do
  Try
    Exchange(Index1, Index2);

    Finally
      FList.UnlockList();
  End;
End;

Procedure TInterfaceListEx.Move(CurIndex, NewIndex : Integer);
Begin
  With FList.LockList() Do
  Try
    Move(CurIndex, NewIndex);

    Finally
      FList.UnlockList();
  End;
End;

Procedure TInterfaceListEx.Delete(Const Index : Integer);
Begin
  With FList.LockList() Do
  Try
    If Index > -1 Then
    Begin
      Put(Index, Nil);
      Delete(Index);
    End;

    Finally
      FList.UnlockList();
  End;
End;

Procedure TInterfaceListEx.Sort(Compare : TInterfaceListExSortCompare);
  Procedure QuickSort(L, R: Integer; SCompare : TInterfaceListExSortCompare);
  Var I, J : Integer;
      P    : IInterfaceEx;
  Begin
    Repeat
      I := L;
      J := R;
      P := Items[(L + R) Shr 1];

      Repeat
        While SCompare(Items[I], P) < 0 Do
          Inc(I);

        While SCompare(Items[J], P) > 0 Do
          Dec(J);

        If I <= J Then
        Begin
          Exchange(I, J);

          Inc(I);
          Dec(J);
        End;
      Until I > J;

      If L < J Then
        QuickSort(L, J, SCompare);

      L := I;
    Until I >= R;
  End;

Begin
  If Count > 0 Then
    QuickSort(0, Count - 1, Compare);
End;

Procedure TInterfaceListEx.Clear();
Var X : Integer;
Begin
  If FList <> Nil Then
    With FList.LockList() Do
    Try
      For X := 0 To Count - 1 Do
        IInterfaceEx(List[X]) := Nil;
      Clear();

      Finally
        FList.UnlockList();
    End;
End;

Function TInterfaceListEx.IndexOf(Const Item : IInterfaceEx): Integer;
Begin
  With FList.LockList() Do
  Try
    Result := IndexOf(Pointer(Item));

    Finally
      FList.UnlockList();
  End;
End;

Procedure RegisterInterface(Const AInterfaceName : String; Const AIID : TGUID);
Var lIdx : Integer;
Begin
  If Not Assigned(gInterfaceList) Then
    gInterfaceList := TInterfaceIdentsEx.Create();

  lIdx := gInterfaceList.IndexOf(AIID);
  If lIdx = -1 Then
  Begin
    With gInterfaceList.Add() Do
    Begin
      InterfaceName := AInterfaceName;
      IID           := AIID;
    End;
  End
  Else
    gInterfaceList.Items[lIdx].InterfaceName := AInterfaceName;
End;

End.
