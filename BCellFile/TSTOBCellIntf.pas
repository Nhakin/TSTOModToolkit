unit TSTOBCellIntf;

interface

Uses {$If CompilerVersion < 18.5}HsStreamEx{$Else}SysUtils{$IfEnd}, HsInterfaceEx;

Type
  IBCellSubItem = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-8346-E191F686FC84}']
    Function  GetString1() : String;
    Procedure SetString1(Const AString1 : String);

    Function  GetString2() : String;
    Procedure SetString2(Const AString2 : String);

    Function  GetPadding() : TBytes;

    Procedure Assign(ASource : IInterface);

    Property String1 : String Read GetString1 Write SetString1;
    Property String2 : String Read GetString2 Write SetString2;
    Property Padding : TBytes Read GetPadding;


  End;

  IBCellSubItems = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-BF1E-2F0BCE8852DB}']
    Function  Get(Index : Integer) : IBCellSubItem;
    Procedure Put(Index : Integer; Const Item : IBCellSubItem);

    Function Add() : IBCellSubItem; OverLoad;
    Function Add(Const AItem : IBCellSubItem) : Integer; OverLoad;

    Procedure Assign(ASource : IInterface);

    Property Items[Index : Integer] : IBCellSubItem Read Get Write Put; Default;

  End;

  IBCellItem = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-8D45-FEEC8868D302}']
    Function  GetRgbFileName() : String;
    Procedure SetRgbFileName(Const ARgbFileName : String);

    Function  GetxDiffs() : Double;
    Procedure SetxDiffs(Const AxDiffs : Double);

    Function  GetNbSubItems() : Word;

    Function  GetSubItems() : IBCellSubItems;

    Procedure Assign(ASource : IInterface);

    Property RgbFileName : String         Read GetRgbFileName  Write SetRgbFileName;
    Property xDiffs      : Double         Read GetxDiffs       Write SetxDiffs;
    Property NbSubItems  : Word           Read GetNbSubItems;
    Property SubItems    : IBCellSubItems Read GetSubItems;

  End;

  IBCellItems = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-87EC-A493DC9A5B7F}']
    Function  Get(Index : Integer) : IBCellItem;
    Procedure Put(Index : Integer; Const Item : IBCellItem);

    Function Add() : IBCellItem; OverLoad;
    Function Add(Const AItem : IBCellItem) : Integer; OverLoad;

    Procedure Assign(ASource : IInterface);

    Property Items[Index : Integer] : IBCellItem Read Get Write Put; Default;

  End;

  ITSTOBCellFile = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-8A07-3772A4BD0D2F}']
    Function  GetFileSig() : String;
    Procedure SetFileSig(Const AFileSig : String);

    Function  GetNbItem() : Word;

    Function  GetItems() : IBCellItems;

    Procedure Assign(ASource : IInterface);
    
    Property FileSig : String      Read GetFileSig Write SetFileSig;
    Property NbItem  : Word        Read GetNbItem;
    Property Items   : IBCellItems Read GetItems;

  End;

  TTSTOBCellFile = Class(TObject)
  Public
    Class Function CreateBCellFile() : ITSTOBCellFile;
    Class Function CreateBCellItems() : IBCellItems;
    Class Function CreateBCellSubItems() : IBCellSubItems;

  End;

implementation

Uses TSTOBCellImpl;

Class Function TTSTOBCellFile.CreateBCellFile() : ITSTOBCellFile;
Begin
  Result := TSTOBCellImpl.TTSTOBCellFile.Create();
End;

Class Function TTSTOBCellFile.CreateBCellItems() : IBCellItems;
Begin
  Result := TBCellItems.Create();
End;

Class Function TTSTOBCellFile.CreateBCellSubItems() : IBCellSubItems;
Begin
  Result := TBCellSubItems.Create();
End;

end.
