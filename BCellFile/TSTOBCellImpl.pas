unit TSTOBCellImpl;

interface

Uses Windows, SysUtils, {$If CompilerVersion < 18.5}HsStreamEx,{$IfEnd}
  HsInterfaceEx, TSTOBCellIntf;

Type
  TBCellSubItem = Class(TInterfacedObjectEx, IBCellSubItem)
  Private
    FString1 : String;
    FString2 : String;
    FPadding : TBytes;

  Protected
    Procedure Created(); OverRide;

    Function  GetString1() : String;
    Procedure SetString1(Const AString1 : String);

    Function  GetString2() : String;
    Procedure SetString2(Const AString2 : String);

    Function  GetPadding() : TBytes;

    Procedure Clear();

    Procedure Assign(ASource : IInterface); ReIntroduce;

  End;

  TBCellSubItems = Class(TInterfaceListEx, IBCellSubItems)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : IBCellSubItem; OverLoad;
    Procedure Put(Index : Integer; Const Item : IBCellSubItem); OverLoad;

    Function Add() : IBCellSubItem; ReIntroduce; OverLoad;
    Function Add(Const AItem : IBCellSubItem) : Integer; OverLoad;

    Procedure Assign(ASource : IInterface); ReIntroduce;

  End;

  TBCellSubItemsClass = Class Of TBCellSubItems;
  TBCellItem = Class(TInterfacedObjectEx, IBCellItem)
  Private
    FRgbFileName : String;
    FxDiffs      : Double;
    FSubItems    : IBCellSubItems;

  Protected
    Procedure Created(); OverRide;
    Function  GetSubItemClass() : TBCellSubItemsClass; Virtual;

    Function  GetRgbFileName() : String; Virtual;
    Procedure SetRgbFileName(Const ARgbFileName : String);

    Function  GetxDiffs() : Double; Virtual;
    Procedure SetxDiffs(Const AxDiffs : Double); Virtual;

    Function  GetNbSubItems() : Word; Virtual;

    Function  GetSubItems() : IBCellSubItems; 

    Procedure Clear();

    Procedure Assign(ASource : IInterface); ReIntroduce; 

  Public
    Destructor Destroy(); OverRide;

  End;

  TBCellItems = Class(TInterfaceListEx, IBCellItems)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : IBCellItem; OverLoad;
    Procedure Put(Index : Integer; Const Item : IBCellItem); OverLoad;

    Function Add() : IBCellItem; ReIntroduce; OverLoad;
    Function Add(Const AItem : IBCellItem) : Integer; OverLoad;

    Procedure Assign(ASource : IInterface); ReIntroduce;

  End;

  TBCellItemsClass = Class Of TBCellItems;
  TTSTOBCellFile = Class(TInterfacedObjectEx, ITSTOBCellFile)
  Private
    FFileSig : String;
    FItems   : IBCellItems;

  Protected
    Procedure Created(); OverRide;
    Function GetItemClass() : TBCellItemsClass; Virtual;

    Function  GetFileSig() : String; Virtual;
    Procedure SetFileSig(Const AFileSig : String); Virtual;

    Function  GetNbItem() : Word; Virtual;

    Function  GetItems() : IBCellItems;

    Procedure Clear();

    Procedure Assign(ASource : IInterface); ReIntroduce; 

  Public
    Destructor Destroy(); OverRide;

  End;

implementation

Uses RTLConsts;

Procedure TBCellSubItem.Created();
Begin
  InHerited Created();

  Clear();
End;

Procedure TBCellSubItem.Clear();
Begin
  SetLength(FPadding, 28);
  ZeroMemory(@FPadding[0], Length(FPadding));

  FString1 := '';
  FString2 := '';
End;

Procedure TBCellSubItem.Assign(ASource : IInterface);
Var lSrc : IBCellSubItem;
Begin
  If Supports(ASource, IBCellSubItem, lSrc) Then
  Begin
    FString1 := lSrc.String1;
    FString2 := lSrc.String2;
    FPadding := lSrc.Padding;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, ['Unsupported Interface', ClassName]);
End;

Function TBCellSubItem.GetString1() : String;
Begin
  Result := FString1;
End;

Procedure TBCellSubItem.SetString1(Const AString1 : String);
Begin
  FString1 := AString1;
End;

Function TBCellSubItem.GetString2() : String;
Begin
  Result := FString2;
End;

Procedure TBCellSubItem.SetString2(Const AString2 : String);
Begin
  FString2 := AString2;
End;

Function TBCellSubItem.GetPadding() : TBytes;
Begin
  Result := FPadding;
End;

Function TBCellSubItems.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TBCellSubItem;
End;

Function TBCellSubItems.Get(Index : Integer) : IBCellSubItem;
Begin
  Result := InHerited Items[Index] As IBCellSubItem;
End;

Procedure TBCellSubItems.Put(Index : Integer; Const Item : IBCellSubItem);
Begin
  InHerited Items[Index] := Item;
End;

Function TBCellSubItems.Add() : IBCellSubItem;
Begin
  Result := InHerited Add() As IBCellSubItem;
End;

Function TBCellSubItems.Add(Const AItem : IBCellSubItem) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Procedure TBCellSubItems.Assign(ASource : IInterface);
Var lSrc : IBCellSubItems;
    X    : Integer;
Begin
  If Supports(ASource, IBCellSubItems, lSrc) Then
  Begin
    Clear();
    For X := 0 To lSrc.Count - 1 Do
      Add().Assign(lSrc[X]);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, ['Unsupported Interface', ClassName]);
End; 

Procedure TBCellItem.Created();
Begin
  InHerited Created();

  Clear();
End;

Destructor TBCellItem.Destroy();
Begin
  FSubItems := Nil;

  InHerited Destroy();
End;

Function TBCellItem.GetSubItemClass() : TBCellSubItemsClass;
Begin
  Result := TBCellSubItems;
End;

Procedure TBCellItem.Clear();
Begin
  FRgbFileName := '';
  FxDiffs      := 0;
  FSubItems    := GetSubItemClass().Create();
End;

Procedure TBCellItem.Assign(ASource : IInterface);
Var lSrc : IBCellItem;
Begin
  If Supports(ASource, IBCellItem, lSrc) Then
  Begin
    FRgbFileName := lSrc.RgbFileName;
    FxDiffs      := lSrc.xDiffs;
    FSubItems.Assign(lSrc.SubItems);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, ['Unsupported Interface', ClassName]);
End;

Function TBCellItem.GetRgbFileName() : String;
Begin
  Result := FRgbFileName;
End;

Procedure TBCellItem.SetRgbFileName(Const ARgbFileName : String);
Begin
  FRgbFileName := ARgbFileName;
End;

Function TBCellItem.GetxDiffs() : Double;
Begin
  Result := FxDiffs;
End;

Procedure TBCellItem.SetxDiffs(Const AxDiffs : Double);
Begin
  FxDiffs := AxDiffs;
End;

Function TBCellItem.GetNbSubItems() : Word;
Begin
  Result := FSubItems.Count;
End;

Function TBCellItem.GetSubItems() : IBCellSubItems;
Begin
  Result := FSubItems;
End;

Function TBCellItems.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TBCellItem;
End;

Function TBCellItems.Get(Index : Integer) : IBCellItem;
Begin
  Result := InHerited Items[Index] As IBCellItem;
End;

Procedure TBCellItems.Put(Index : Integer; Const Item : IBCellItem);
Begin
  InHerited Items[Index] := Item;
End;

Function TBCellItems.Add() : IBCellItem;
Begin
  Result := InHerited Add() As IBCellItem;
End;

Function TBCellItems.Add(Const AItem : IBCellItem) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Procedure TBCellItems.Assign(ASource : IInterface);
Var lSrc : IBCellItems;
    X    : Integer;
Begin
  If Supports(ASource, IBCellItems, lSrc) Then
  Begin
    Clear();

    For X := 0 To lSrc.Count - 1 Do
      Add().Assign(lSrc[X]);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, ['Unsupported Interface', ClassName]);
End;

Procedure TTSTOBCellFile.Created();
Begin
  InHerited Created();

  Clear();
End;

Destructor TTSTOBCellFile.Destroy();
Begin
  FItems := Nil;

  InHerited Destroy();
End;

Function TTSTOBCellFile.GetItemClass() : TBCellItemsClass;
Begin
  Result := TBCellItems;
End;

Procedure TTSTOBCellFile.Clear();
Begin
  FFileSig := '';
  FItems   := GetItemClass().Create();
End;

Procedure TTSTOBCellFile.Assign(ASource : IInterface);
Var lSrc : ITSTOBCellFile;
Begin
  If Supports(ASource, ITSTOBCellFile, lSrc) Then
  Begin
    FFileSig := lSrc.FileSig;
    FItems.Assign(lSrc.Items);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, ['Unsupported Interface', ClassName]);
End;

Function TTSTOBCellFile.GetFileSig() : String;
Begin
  Result := Copy(FFileSig, 1, Length(FFileSig) - 1);
End;

Procedure TTSTOBCellFile.SetFileSig(Const AFileSig : String);
Begin
  FFileSig := AFileSig + #1;
End;

Function TTSTOBCellFile.GetNbItem() : Word;
Begin
  Result := FItems.Count;
End;

Function TTSTOBCellFile.GetItems() : IBCellItems;
Begin
  Result := FItems;
End;

end.
