unit TSTOBCell.Xml;

interface

Uses HsXmlDocEx;

Type
  IXmlBCellSubItem = Interface(IXmlNodeEx)
    ['{4B61686E-29A0-2112-9B19-535D51173040}']
    Function  GetString1() : String;
    Procedure SetString1(Const AString1 : String);

    Function  GetString2() : String;
    Procedure SetString2(Const AString2 : String);

    Function  GetPadding() : String;
    Procedure SetPadding(Const APadding : String);

    Procedure Assign(ASource : IInterface);

    Property String1 : String Read GetString1 Write SetString1;
    Property String2 : String Read GetString2 Write SetString2;
    Property Padding : String Read GetPadding Write SetPadding;

  End;

  IXmlBCellSubItems = Interface(IXmlNodeCollectionEx)
    ['{4B61686E-29A0-2112-BA08-09609B257D2B}']
    Function GetItem(Const Index : Integer) : IXmlBCellSubItem;

    Function Add() : IXmlBCellSubItem;
    Function Insert(Const Index: Integer) : IXmlBCellSubItem;
    Procedure Assign(ASource : IInterface);

    Property Items[Const Index: Integer] : IXmlBCellSubItem Read GetItem; Default;

  End;

  IXmlBCellItem = Interface(IXmlNodeEx)
    ['{4B61686E-29A0-2112-99AB-52EEAD7778B3}']
    Function  GetRgbFileName() : String;
    Procedure SetRgbFileName(Const ARgbFileName : String);

    Function  GetxDiffs() : Double;
    Procedure SetxDiffs(Const AxDiffs : Double);

    Function  GetNbSubItems() : Word;
    Function  GetSubItems() : IXmlBCellSubItems;

    Procedure Assign(ASource : IInterface);
    
    Property RgbFileName : String            Read GetRgbFileName Write SetRgbFileName;
    Property xDiffs      : Double            Read GetxDiffs      Write SetxDiffs;
    Property NbSubItems  : Word              Read GetNbSubItems;
    Property SubItems    : IXmlBCellSubItems Read GetSubItems;

  End;

  IXmlBCellItems = Interface(IXmlNodeCollectionEx)
    ['{4B61686E-29A0-2112-A42E-3AB61C425C64}']
    Function GetItem(Const Index : Integer) : IXmlBCellItem;

    Function Add() : IXmlBCellItem;
    Function Insert(Const Index: Integer) : IXmlBCellItem;
    Procedure Assign(ASource : IInterface);

    Property Items[Const Index: Integer] : IXmlBCellItem Read GetItem; Default;

  End;

  IXmlTSTOBCellFile = Interface(IXmlNodeEx)
    ['{4B61686E-29A0-2112-BBC3-CFECCD00C965}']
    Function  GetFileSig() : String;
    Procedure SetFileSig(Const AFileSig : String);

    Function  GetNbItem() : Word;
    Function  GetItems() : IXmlBCellItems;

    Procedure Assign(ASource : IInterface);  
    
    Property FileSig : String         Read GetFileSig Write SetFileSig;
    Property NbItem  : Word           Read GetNbItem;
    Property Items   : IXmlBCellItems Read GetItems;

  End;

  TXmlTSTOBCellFile = Class(TObject)
  Public
    Class Function CreateBCellFile() : IXmlTSTOBCellFile; OverLoad;
    Class Function CreateBCellFile(Const AXmlString : String) : IXmlTSTOBCellFile; OverLoad;

  End;

implementation

Uses SysUtils, Variants, RtlConsts, HsBaseConvEx, HsStreamEx, TSTOBCellIntf;

Type
  TXmlBCellSubItem = Class(TXmlNodeEx, IBCellSubItem, IXmlBCellSubItem)
  Private
    FSubItemImpl : Pointer;
    Function GetImplementor() : IBCellSubItem;

  Protected
    Property SubItemImpl : IBCellSubItem Read GetImplementor;

    Function  GetString1() : String;
    Procedure SetString1(Const AString1 : String);

    Function  GetString2() : String;
    Procedure SetString2(Const AString2 : String);

    Function  GetPadding() : String;
    Procedure SetPadding(Const APadding : String);

    Function GetPaddingAsTBytes() : TBytes;
    Function IBCellSubItem.GetPadding = GetPaddingAsTBytes;

    Procedure Clear();

    Procedure Assign(ASource : IInterface); ReIntroduce;

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TXmlBCellSubItems = Class(TXMLNodeCollectionEx, IBCellSubItems, IXmlBCellSubItems)
  Private
    FSubItemsImpl : Pointer;
    Function GetImplementor() : IBCellSubItems;

  Protected
    Property SubItemsImpl : IBCellSubItems Read GetImplementor Implements IBCellSubItems;

    Function GetItem(Const Index : Integer) : IXmlBCellSubItem;

    Function Add() : IXmlBCellSubItem; OverLoad;
    Function Insert(Const Index : Integer) : IXmlBCellSubItem;
    Procedure Assign(ASource : IInterface);
    Procedure AssignTo(ATarget : IBCellSubItems);

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TXmlBCellItem = Class(TXmlNodeEx, IBCellItem, IXmlBCellItem)
  Private
    FItemImpl : Pointer;
    Function GetImplementor() : IBCellItem;

  Protected
    Property ItemImpl : IBCellItem Read GetImplementor;

    Function  GetRgbFileName() : String;
    Procedure SetRgbFileName(Const ARgbFileName : String);

    Function  GetxDiffs() : Double;
    Procedure SetxDiffs(Const AxDiffs : Double);

    Function  GetNbSubItems() : Word;

    Function GetSubItems() : IXmlBCellSubItems;
    Function GetISubItems() : IBCellSubItems;
    Function IBCellItem.GetSubItems = GetISubItems;

    Procedure Clear();

    Procedure Assign(ASource : IInterface); ReIntroduce;

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TXmlBCellItems = Class(TXMLNodeCollectionEx, IBCellItems, IXmlBCellItems)
  Private
    FItemsImpl : Pointer;
    Function GetImplementor() : IBCellItems;

  Protected
    Property ItemsImpl : IBCellItems Read GetImplementor Implements IBCellItems;

    Function GetItem(Const Index : Integer) : IXmlBCellItem;

    Function Add() : IXmlBCellItem;
    Function Insert(Const Index : Integer) : IXmlBCellItem;
    Procedure Assign(ASource : IInterface);
    Procedure AssignTo(ATarget : IBCellItems);

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TXmlTSTOBCellFileImpl = Class(TXmlNodeEx, ITSTOBCellFile, IXmlTSTOBCellFile)
  Private
    FBCellImpl : Pointer;
    Function GetImplementor() : ITSTOBCellFile;

  Protected
    Property BCellImpl : ITSTOBCellFile Read GetImplementor;

    Function  GetFileSig() : String; Virtual;
    Procedure SetFileSig(Const AFileSig : String); Virtual;

    Function  GetNbItem() : Word; Virtual;

    Function GetItems() : IXmlBCellItems;
    Function GetIITems() : IBCellItems;
    Function ITSTOBCellFile.GetItems = GetIItems;

    Procedure Clear();

    Procedure Assign(ASource : IInterface); ReIntroduce; 

  Public
    Procedure AfterConstruction(); OverRide;

  End;

Class Function TXmlTSTOBCellFile.CreateBCellFile() : IXmlTSTOBCellFile;
Begin
  Result := NewXmlDocument().GetDocBinding('BCellFile', TXmlTSTOBCellFileImpl) As IXmlTSTOBCellFile;
End;

Class Function TXmlTSTOBCellFile.CreateBCellFile(Const AXmlString : String) : IXmlTSTOBCellFile;
Begin
  Result := LoadXmlData(AXmlString).GetDocBinding('BCellFile', TXmlTSTOBCellFileImpl) As IXmlTSTOBCellFile;
End;

(******************************************************************************)

Procedure TXmlBCellSubItem.AfterConstruction();
Begin
  FSubItemImpl := Pointer(IBCellSubItem(Self));

  InHerited AfterConstruction();
End;

Function TXmlBCellSubItem.GetImplementor() : IBCellSubItem;
Begin
  Result := IBCellSubItem(FSubItemImpl);
End;

Procedure TXmlBCellSubItem.Clear();
Begin
  ChildNodes['String1'].NodeValue := Null;
  ChildNodes['String2'].NodeValue := Null;
  ChildNodes['Padding'].NodeValue := Null;
End;

Procedure TXmlBCellSubItem.Assign(ASource : IInterface);
Var lXmlSrc : IXmlBCellSubItem;
    lSrc    : IBCellSubItem;
    lStr    : String;
    X       : Integer;
Begin
  If Supports(ASource, IXmlNodeEx) And
     Supports(ASource, IXmlBCellSubItem, lXmlSrc) Then
  Begin
    ChildNodes['String1'].NodeValue := lXmlSrc.String1;
    ChildNodes['String2'].NodeValue := lXmlSrc.String2;
    ChildNodes['Padding'].NodeValue := lXmlSrc.Padding;
  End
  Else If Supports(ASource, IBCellSubItem, lSrc) Then
  Begin
    ChildNodes['String1'].NodeValue := lSrc.String1;
    ChildNodes['String2'].NodeValue := lSrc.String2;

    lStr := '';
    For X := Low(lSrc.Padding) To High(lSrc.Padding) Do
      lStr := lStr + IntToHex(lSrc.Padding[X], 2);
    ChildNodes['Padding'].NodeValue := lStr;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, ['Unsupported Interface', ClassName]);
End;

Function TXmlBCellSubItem.GetString1() : String;
Begin
  Result := ChildNodes['String1'].AsString;
End;

Procedure TXmlBCellSubItem.SetString1(Const AString1 : String);
Begin
  If IsImplementorOf(SubItemImpl) Then
    ChildNodes['String1'].AsString := AString1
  Else
    SubItemImpl.String1 := AString1;
End;

Function TXmlBCellSubItem.GetString2() : String;
Begin
  Result := ChildNodes['String2'].AsString;
End;

Procedure TXmlBCellSubItem.SetString2(Const AString2 : String);
Begin
  If IsImplementorOf(SubItemImpl) Then
    ChildNodes['String2'].AsString := AString2
  Else
    SubItemImpl.String2 := AString2;
End;

Function TXmlBCellSubItem.GetPadding() : String;
Begin
  Result := ChildNodes['Padding'].AsString;
End;

Procedure TXmlBCellSubItem.SetPadding(Const APadding : String);
Begin
  If IsImplementorOf(SubItemImpl) Then
    ChildNodes['Padding'].AsString := APadding
  Else
    Raise Exception.Create('Todo : TXmlBCellSubItem.SetPadding');
End;

Function TXmlBCellSubItem.GetPaddingAsTBytes() : TBytes;
Var lBytes : TBytes;
    lPadding : String;
    lConv : IHsBaseConvEx;
Begin
  If IsImplementorOf(SubItemImpl) Then
  Begin
    lPadding := ChildNodes['Padding'].AsString;

    lConv := THsBaseConvEx.CreateBaseConv();
    Try
      While Length(lPadding) > 0 Do
      Begin
        SetLength(lBytes, Length(lBytes) + 1);
        lConv.AsHexadecimal := Copy(lPadding, 1, 2);
        lBytes[High(lBytes)] := lConv.AsInteger;
        lPadding := Copy(lPadding, 3, Length(lPadding));
      End;

      Finally
        lConv := Nil;
    End;

    Result := lBytes;
  End
  Else
    Result := SubItemImpl.Padding
End;

Procedure TXmlBCellSubItems.AfterConstruction();
Begin
  RegisterChildNode('XmlBCellSubItem', TXmlBCellSubItem);
  ItemTag       := 'XmlBCellSubItem';
  ItemInterface := IXmlBCellSubItem;

  InHerited AfterConstruction();
End;

Function TXmlBCellSubItems.GetImplementor() : IBCellSubItems;
Begin
  If Not Assigned(FSubItemsImpl) Then
  Begin
    Result := TTSTOBCellFile.CreateBCellSubItems();
    AssignTo(Result);

    FSubItemsImpl := Pointer(Result);
  End
  Else
    Result := IBCellSubItems(FSubItemsImpl);
End;

Function TXmlBCellSubItems.GetItem(Const Index : Integer) : IXmlBCellSubItem;
Begin
  Result := List[Index] As IXmlBCellSubItem;
End;

Function TXmlBCellSubItems.Add() : IXmlBCellSubItem;
Begin
  Result := AddItem(-1) As IXmlBCellSubItem;
End;

Function TXmlBCellSubItems.Insert(Const Index : Integer) : IXmlBCellSubItem;
Begin
  Result := AddItem(Index) As IXmlBCellSubItem;
End;

Procedure TXmlBCellSubItems.Assign(ASource : IInterface);
Var lXmlSrc : IXmlBCellSubItems;
    lSrc    : IBCellSubItems;
    X       : Integer;
Begin
  If Supports(ASource, IXMLNodeCollectionEx) And
     Supports(ASource, IXmlBCellSubItems, lXmlSrc) Then
  Begin
    Clear();

    For X := 0 To lXmlSrc.Count - 1 Do
      Add().Assign(lXmlSrc[X]);
  End
  Else If Supports(ASource, IBCellSubItems, lSrc) Then
  Begin
    Clear();

    For X := 0 To lSrc.Count - 1 Do
      Add().Assign(lSrc[X]);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, ['Unsupported Interface', ClassName]);
End;

Procedure TXmlBCellSubItems.AssignTo(ATarget : IBCellSubItems);
Var X : Integer;
Begin
  ATarget.Clear();

  For X := 0 To List.Count - 1 Do
    ATarget.Add().Assign(List[X]);
End;

Procedure TXmlBCellItem.AfterConstruction();
Begin
  RegisterChildNode('SubItems', TXmlBCellSubItems);
  FItemImpl := Pointer(IBCellItem(Self));

  InHerited AfterConstruction();
End;

Function TXmlBCellItem.GetImplementor() : IBCellItem;
Begin
  Result := IBCellItem(FItemImpl);
End;

Procedure TXmlBCellItem.Clear();
Begin
  ChildNodes['RgbFileName'].NodeValue := Null;
  ChildNodes['xDiffs'].NodeValue      := Null;
  ChildNodes['SubItems'].NodeValue    := Null;
End;

Procedure TXmlBCellItem.Assign(ASource : IInterface);
Var lXmlSrc : IXmlBCellItem;
    lSrc    : IBCellItem;
Begin
  If Supports(ASource, IXmlNodeEx) And
     Supports(ASource, IXmlBCellItem, lXmlSrc) Then
  Begin
    ChildNodes['RgbFileName'].NodeValue := lXmlSrc.RgbFileName;
    ChildNodes['xDiffs'].NodeValue      := lXmlSrc.xDiffs;
    GetSubItems().Assign(lXmlSrc.SubItems);
  End
  Else If Supports(ASource, IBCellItem, lSrc) Then
  Begin
    ChildNodes['RgbFileName'].NodeValue := lSrc.RgbFileName;
    ChildNodes['xDiffs'].NodeValue      := lSrc.xDiffs;
    GetSubItems().Assign(lSrc.SubItems);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, ['Unsupported Interface', ClassName]);
End;

Function TXmlBCellItem.GetRgbFileName() : String;
Begin
  Result := ChildNodes['RgbFileName'].AsString;
End;

Procedure TXmlBCellItem.SetRgbFileName(Const ARgbFileName : String);
Begin
  If IsImplementorOf(ItemImpl) Then
    ChildNodes['RgbFileName'].AsString := ARgbFileName
  Else
    ItemImpl.RgbFileName := ARgbFileName;
End;

Function TXmlBCellItem.GetxDiffs() : Double;
Begin
  Result := ChildNodes['xDiffs'].AsFloat;
End;

Procedure TXmlBCellItem.SetxDiffs(Const AxDiffs : Double);
Begin
  If IsImplementorOf(ItemImpl) Then
    ChildNodes['xDiffs'].AsFloat := AxDiffs
  Else
    ItemImpl.xDiffs := AxDiffs;
End;

Function TXmlBCellItem.GetNbSubItems() : Word;
Begin
  Result := GetSubItems().Count;
End;

Function TXmlBCellItem.GetSubItems() : IXmlBCellSubItems;
Begin
  Result := ChildNodes['SubItems'] As IXmlBCellSubItems;
End;

Function TXmlBCellItem.GetISubItems() : IBCellSubItems;
Begin
  Result := ChildNodes['SubItems'] As IBCellSubItems;
End;

Procedure TXmlBCellItems.AfterConstruction();
Begin
  RegisterChildNode('XmlBCellItem', TXmlBCellItem);
  ItemTag       := 'XmlBCellItem';
  ItemInterface := IXmlBCellItem;

  InHerited AfterConstruction();
End;

Function TXmlBCellItems.GetImplementor() : IBCellItems;
Begin
  If Not Assigned(FItemsImpl) Then
  Begin
    Result := TTSTOBCellFile.CreateBCellItems();
    AssignTo(Result);

    FItemsImpl := Pointer(Result);
  End
  Else
    Result := IBCellItems(FItemsImpl);
End;

Function TXmlBCellItems.GetItem(Const Index : Integer) : IXmlBCellItem;
Begin
  Result := List[Index] As IXmlBCellItem;
End;

Function TXmlBCellItems.Add() : IXmlBCellItem;
Begin
  Result := AddItem(-1) As IXmlBCellItem;
End;

Function TXmlBCellItems.Insert(Const Index : Integer) : IXmlBCellItem;
Begin
  Result := AddItem(Index) As IXmlBCellItem;
End;

Procedure TXmlBCellItems.Assign(ASource : IInterface);
Var lXmlSrc : IXmlBCellItems;
    lSrc    : IBCellItems;
    X       : Integer;
Begin
  If Supports(ASource, IXMLNodeCollectionEx) And
     Supports(ASource, IXmlBCellItems, lXmlSrc) Then
  Begin
    Clear();

    For X := 0 To lXmlSrc.Count - 1 Do
      Add().Assign(lXmlSrc[X]);
  End
  Else If Supports(ASource, IBCellItems, lSrc) Then
  Begin
    Clear();

    For X := 0 To lSrc.Count - 1 Do
      Add().Assign(lSrc[X]);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, ['Unsupported Interface', ClassName]);
End;

Procedure TXmlBCellItems.AssignTo(ATarget : IBCellItems);
Var X : Integer;
Begin
  ATarget.Clear();

  For X := 0 To List.Count - 1 Do
    ATarget.Add().Assign(List[X]);
End;

Procedure TXmlTSTOBCellFileImpl.AfterConstruction();
Begin
  RegisterChildNode('Items', TXmlBCellItems);

  FBCellImpl := Pointer(ITSTOBCellFile(Self));

  InHerited AfterConstruction();
End;

Function TXmlTSTOBCellFileImpl.GetImplementor() : ITSTOBCellFile;
Begin
  Result := ITSTOBCellFile(FBCellImpl);
End;

Procedure TXmlTSTOBCellFileImpl.Clear();
Begin
  ChildNodes['FileSig'].NodeValue := Null;
  ChildNodes['NbItem'].NodeValue  := Null;
  ChildNodes['Items'].NodeValue   := Null;
End;

Procedure TXmlTSTOBCellFileImpl.Assign(ASource : IInterface);
Var lXmlSrc : IXmlTSTOBCellFile;
    lSrc    : ITSTOBCellFile;
Begin
  If Supports(ASource, IXmlNodeEx) And
     Supports(ASource, IXmlTSTOBCellFile, lXmlSrc) Then
  Begin
    ChildNodes['FileSig'].NodeValue := lXmlSrc.FileSig;
    ChildNodes['NbItem'].NodeValue  := lXmlSrc.NbItem;
    GetItems().Assign(lXmlSrc.Items);
  End
  Else If Supports(ASource, ITSTOBCellFile, lSrc) Then
  Begin
    ChildNodes['FileSig'].NodeValue := lSrc.FileSig;
    ChildNodes['NbItem'].NodeValue  := lSrc.NbItem;
    GetItems().Assign(lSrc.Items);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, ['Unsupported Interface', ClassName]);
End;

Function TXmlTSTOBCellFileImpl.GetFileSig() : String;
Begin
  Result := ChildNodes['FileSig'].AsString;
End;

Procedure TXmlTSTOBCellFileImpl.SetFileSig(Const AFileSig : String);
Begin
  If IsImplementorOf(BCellImpl) Then
    ChildNodes['FileSig'].AsString := AFileSig
  Else
    BCellImpl.FileSig := AFileSig;
End;

Function TXmlTSTOBCellFileImpl.GetNbItem() : Word;
Begin
  Result := GetItems().Count;
End;

Function TXmlTSTOBCellFileImpl.GetItems() : IXmlBCellItems;
Begin
  Result := ChildNodes['Items'] As IXmlBCellItems;
End;

Function TXmlTSTOBCellFileImpl.GetIITems() : IBCellItems;
Begin
  Result := ChildNodes['Items'] As IBCellItems;
End;

end.
