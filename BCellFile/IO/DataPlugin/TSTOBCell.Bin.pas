unit TSTOBCell.Bin;

interface

Uses HsStreamEx, TSTOBCellIntf;

Type
  IBinBCellSubItem = Interface(IBCellSubItem)
    ['{4B61686E-29A0-2112-AC15-41652F06CE79}']
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

  End;

  IBinBCellSubItems = Interface(IBCellSubItems)
    ['{4B61686E-29A0-2112-97A1-A5EA9782DFA0}']
    Function  Get(Index : Integer) : IBinBCellSubItem;
    Procedure Put(Index : Integer; Const Item : IBinBCellSubItem);

    Function Add() : IBinBCellSubItem; OverLoad;
    Function Add(Const AItem : IBinBCellSubItem) : Integer; OverLoad;

    Property Items[Index : Integer] : IBinBCellSubItem Read Get Write Put; Default;

  End;

  IBinBCellItem = Interface(IBCellItem)
    ['{4B61686E-29A0-2112-96EE-2F9D195D4611}']
    Function  GetSubItems() : IBinBCellSubItems;

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Property SubItems : IBinBCellSubItems Read GetSubItems;

  End;

  IBinBCellItems = Interface(IBCellItems)
    ['{4B61686E-29A0-2112-B69A-D0DE32637F40}']
    Function  Get(Index : Integer) : IBinBCellItem;
    Procedure Put(Index : Integer; Const Item : IBinBCellItem);

    Function Add() : IBinBCellItem; OverLoad;
    Function Add(Const AItem : IBinBCellItem) : Integer; OverLoad;

    Property Items[Index : Integer] : IBinBCellItem Read Get Write Put; Default;

  End;

  IBinTSTOBCellFile = Interface(ITSTOBCellFile)
    ['{4B61686E-29A0-2112-87D0-AA5A181BB050}']
    Function  GetItems() : IBinBCellItems;

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure LoadFromFile(Const AFileName : String);

    Procedure SaveToStream(ATarget : IStreamEx);
    Procedure SaveToFile(Const AFileName : String);

    Property Items : IBinBCellItems Read GetItems;

  End;

  TBinTSTOBCellFile = Class(TObject)
  Public
    Class Function CreateBCellFile() : IBinTSTOBCellFile;

  End;

implementation

Uses {$If CompilerVersion >= 18.5}SysUtils,{$IfEnd}
  HsInterfaceEx, TSTOBCellImpl;

Type
  TBinBCellSubItem = Class(TBCellSubItem, IBinBCellSubItem)
  Protected
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

  End;

  TBinBCellSubItems = Class(TBCellSubItems, IBinBCellSubItems)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;

    Function  Get(Index : Integer) : IBinBCellSubItem; OverLoad;
    Procedure Put(Index : Integer; Const Item : IBinBCellSubItem); OverLoad;

    Function Add() : IBinBCellSubItem; OverLoad;
    Function Add(Const AItem : IBinBCellSubItem) : Integer; OverLoad;

  End;

  TBinBCellItem = Class(TBCellItem, IBinBCellItem)
  Protected
    Function  GetSubItemClass() : TBCellSubItemsClass; OverRide;
    Function  GetSubItems() : IBinBCellSubItems; OverLoad;

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Property RgbFileName : AnsiString        Read GetRgbFileName  Write SetRgbFileName;
    Property xDiffs      : Double            Read GetxDiffs       Write SetxDiffs;
    Property SubItems    : IBinBCellSubItems Read GetSubItems;

  End;

  TBinBCellItems = Class(TBCellItems, IBinBCellItems)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;

    Function  Get(Index : Integer) : IBinBCellItem; OverLoad;
    Procedure Put(Index : Integer; Const Item : IBinBCellItem); OverLoad;

    Function Add() : IBinBCellItem; OverLoad;
    Function Add(Const AItem : IBinBCellItem) : Integer; OverLoad;

  End;

  TBinTSTOBCellFileImpl = Class(TTSTOBCellFile, IBinTSTOBCellFile)
  Protected
    Function GetItemClass() : TBCellItemsClass; OverRide;
    Function GetItems() : IBinBCellItems; OverLoad;

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure LoadFromFile(Const AFileName : String);

    Procedure SaveToStream(ATarget : IStreamEx);
    Procedure SaveToFile(Const AFileName : String);

    Property FileSig : AnsiString     Read GetFileSig Write SetFileSig;
    Property Items   : IBinBCellItems Read GetItems;

  End;

Class Function TBinTSTOBCellFile.CreateBCellFile() : IBinTSTOBCellFile;
Begin
  Result := TBinTSTOBCellFileImpl.Create();
End;

Procedure TBinBCellSubItem.LoadFromStream(ASource : IStreamEx);
Begin
  String1 := ASource.ReadAnsiString(ASource.ReadByte() - 1);
  ASource.ReadByte();
  String2 := ASource.ReadAnsiString(ASource.ReadByte() - 1);
  ASource.ReadByte();
  ASource.ReadBuffer(Padding[0], Length(Padding));
End;

Procedure TBinBCellSubItem.SaveToStream(ATarget : IStreamEx);
Begin
  ATarget.WriteAnsiString(String1 + #0);
  ATarget.WriteAnsiString(String2 + #0);
  ATarget.WriteBuffer(Padding[0], Length(Padding));
End;

Function TBinBCellSubItems.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TBinBCellSubItem;
End;

Function TBinBCellSubItems.Get(Index : Integer) : IBinBCellSubItem;
Begin
  Result := InHerited Items[Index] As IBinBCellSubItem;
End;

Procedure TBinBCellSubItems.Put(Index : Integer; Const Item : IBinBCellSubItem);
Begin
  InHerited Items[Index] := Item;
End;

Function TBinBCellSubItems.Add() : IBinBCellSubItem;
Begin
  Result := InHerited Add() As IBinBCellSubItem;
End;

Function TBinBCellSubItems.Add(Const AItem : IBinBCellSubItem) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Function TBinBCellItem.GetSubItemClass() : TBCellSubItemsClass;
Begin
  Result := TBinBCellSubItems;
End;

Function TBinBCellItem.GetSubItems() : IBinBCellSubItems;
Begin
  Result := InHerited GetSubItems() As IBinBCellSubItems;
End;

Procedure TBinBCellItem.LoadFromStream(ASource : IStreamEx);
Var lNbSubItems : Word;
Begin
  RgbFileName := ASource.ReadAnsiString(ASource.ReadByte() - 1);
  ASource.ReadByte();

  xDiffs      := ASource.ReadFloat();
  lNbSubItems := ASource.ReadWord(True);
  While lNbSubItems > 0 Do
  Begin
    SubItems.Add().LoadFromStream(ASource);
    Dec(lNbSubItems)
  End;
End;

Procedure TBinBCellItem.SaveToStream(ATarget : IStreamEx);
Var X : Integer;
Begin
  ATarget.WriteAnsiString(RgbFileName + #0);
  ATarget.WriteFloat(xDiffs);
  ATarget.WriteWord(SubItems.Count, True);
  For X := 0 To SubItems.Count - 1 Do
    SubItems[X].SaveToStream(ATarget);
End;

Function TBinBCellItems.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TBinBCellItem;
End;

Function TBinBCellItems.Get(Index : Integer) : IBinBCellItem;
Begin
  Result := InHerited Items[Index] As IBinBCellItem;
End;

Procedure TBinBCellItems.Put(Index : Integer; Const Item : IBinBCellItem);
Begin
  InHerited Items[Index] := Item;
End;

Function TBinBCellItems.Add() : IBinBCellItem;
Begin
  Result := InHerited Add() As IBinBCellItem;
End;

Function TBinBCellItems.Add(Const AItem : IBinBCellItem) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Function TBinTSTOBCellFileImpl.GetItemClass() : TBCellItemsClass;
Begin
  Result := TBinBCellItems;
End;

Function TBinTSTOBCellFileImpl.GetItems() : IBinBCellItems;
Begin
  Result := InHerited GetItems() As IBinBCellItems;
End;

Procedure TBinTSTOBCellFileImpl.LoadFromStream(ASource : IStreamEx);
Var lNbItems : Word;
Begin
  FileSig  := ASource.ReadAnsiString(8);
  lNbItems := ASource.ReadWord();
  While lNbItems > 0 Do
  Begin
    Items.Add().LoadFromStream(ASource);
    Dec(lNbItems)
  End;
End;

Procedure TBinTSTOBCellFileImpl.LoadFromFile(Const AFileName : String);
Var lMem : IMemoryStreamEx;
Begin
  lMem := TMemoryStreamEx.Create();
  Try
    lMem.LoadFromFile(AFileName);
    LoadFromStream(lMem);

    Finally
      lMem := Nil;
  End;
End;

Procedure TBinTSTOBCellFileImpl.SaveToStream(ATarget : IStreamEx);
Var X : Integer;
Begin
  ATarget.WriteAnsiString(FileSig, False);
  ATarget.WriteWord(Items.Count);
  For X := 0 To Items.Count - 1 Do
    Items[X].SaveToStream(ATarget);
End;

Procedure TBinTSTOBCellFileImpl.SaveToFile(Const AFileName : String);
Var lMem : IMemoryStreamEx;
Begin
  lMem := TMemoryStreamEx.Create();
  Try
    SaveToStream(lMem);
    lMem.SaveToFile(AFileName);

    Finally
      lMem := Nil;
  End;
End;

end.
