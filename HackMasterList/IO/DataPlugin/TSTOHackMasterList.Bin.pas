unit TSTOHackMasterList.Bin;

interface

Uses Windows, HsInterfaceEx, HsStreamEx,
  TSTOHackMasterListIntf;

Type
  IBinTSTOHackMasterList = Interface(ITSTOHackMasterList)
    ['{4B61686E-29A0-2112-AFC8-A74E23466FF9}']
    Procedure SaveToStream(AStream : IStreamEx);
    Procedure LoadFromStream(AStream : IStreamEx);

  End;

  TBinTSTOHackMasterList = Class(TObject)
  Public
    Class Function CreateMasterList() : IBinTSTOHackMasterList; OverLoad;
    Class Function CreateMasterList(Const AFileName : String) : IBinTSTOHackMasterList; OverLoad;

  End;

implementation

Uses
  Math, SysUtils, HsStringListEx, TSTOHackMasterListImpl;


Type
  TBinTSTOHackMasterListImpl = Class(TTSTOHackMasterList, IBinTSTOHackMasterList)
  Private
    Procedure LoadMiscData(AStream : IStreamEx; AList : IHsStringListEx; Const ACounterSize, AStringSize : Integer);
    Procedure LoadMovedItems(AStream : IStreamEx);

    Procedure LoadFromStreamV001(AStream : IStreamEx);
    Procedure LoadFromStreamV002(AStream : IStreamEx);
    Procedure LoadFromStreamV003(AStream : IStreamEx; Const ACounterSize, AStringSize : Integer);
    Procedure LoadFromStreamV004(AStream : IStreamEx);
    Procedure LoadFromStreamV005(AStream : IStreamEx);

  Protected
    Procedure LoadFromStream(AStream : IStreamEx);
    Procedure SaveToStream(AStream : IStreamEx);

  End;

Class Function TBinTSTOHackMasterList.CreateMasterList() : IBinTSTOHackMasterList;
Begin
  Result := TBinTSTOHackMasterListImpl.Create();
End;

Class Function TBinTSTOHackMasterList.CreateMasterList(Const AFileName : String) : IBinTSTOHackMasterList;
Var lMem : IMemoryStreamEx;
Begin
  Result := TBinTSTOHackMasterListImpl.Create();
  lMem := TMemoryStreamEx.Create();
  Try
    If FileExists(AFileName) Then
    Begin
      lMem.LoadFromFile(AFileName);
      Result.LoadFromStream(lMem);
    End;

    Finally
      lMem := Nil;
  End;
End;

(******************************************************************************)

Const
  cFileVersion = 5;

  cCategoryEnabled = 1;
  cBuildStore = 2;
  cBadItem = 4;
  cNPCCharacter = 8;
  cAddInStore = 1;
  cOverRide = 2;

Procedure TBinTSTOHackMasterListImpl.LoadMiscData(AStream : IStreamEx; AList : IHsStringListEx; Const ACounterSize, AStringSize : Integer);
Var X : DWord;
Begin
  Case ACounterSize Of
    1 : X := AStream.ReadByte();
    2 : X := AStream.ReadWord();
    4 : X := AStream.ReadDWord();
  End;

  AList.Add('<MiscData>');
  While X > 0 Do
  Begin
    AList.Add(AStream.ReadAnsiString(AStringSize));

    Dec(X);
  End;
  AList.Add('</MiscData>');
End;

Procedure TBinTSTOHackMasterListImpl.LoadMovedItems(AStream : IStreamEx);
Var lNbItem : Word;
Begin
  lNbItem := AStream.ReadWord();
  While lNbItem > 0 Do
  Begin
    With GetMovedItems().Add Do
    Begin
      XmlFileName := AStream.ReadAnsiString();
      OldCategory := AStream.ReadAnsiString();
      NewCategory := AStream.ReadAnsiString();
    End;

    Dec(lNbItem);
  End;
End;

Procedure TBinTSTOHackMasterListImpl.LoadFromStreamV005(AStream : IStreamEx);
Begin
  LoadMovedItems(AStream);
  LoadFromStreamV003(AStream, 2, 2);
End;

Procedure TBinTSTOHackMasterListImpl.LoadFromStreamV004(AStream : IStreamEx);
Begin
  LoadMovedItems(AStream);
  LoadFromStreamV003(AStream, 2, 1);
End;

Procedure TBinTSTOHackMasterListImpl.LoadFromStreamV003(AStream : IStreamEx; Const ACounterSize, AStringSize : Integer);
Var X, Y, Z, W : Integer;
    lItemFlags : Byte;
Begin
  X := AStream.ReadWord();
  While X > 0 Do
  Begin
    With Add() Do
    Begin
      Name       := AStream.ReadAnsiString();
      lItemFlags := AStream.ReadByte();
      Enabled    := lItemFlags And cCategoryEnabled = cCategoryEnabled;
      BuildStore := lItemFlags And cBuildStore = cBuildStore;

      Y := AStream.ReadByte();
      While Y > 0 Do
      Begin
        With Add() Do
        Begin
          PackageType := AStream.ReadAnsiString();
          XmlFile     := AStream.ReadAnsiString();
          Enabled     := AStream.ReadBoolean();

          Z := AStream.ReadByte();
          While Z > 0 Do
          Begin
            With Add() Do
            Begin
              Id           := AStream.ReadDWord();
              Name         := AStream.ReadAnsiString();
              lItemFlags   := AStream.ReadByte();
              AddInStore   := lItemFlags And cAddInStore = cAddInStore;
              OverRide     := lItemFlags And cOverRide = cOverRide;
              IsBadItem    := lItemFlags And cBadItem = cBadItem;
              NPCCharacter := lItemFlags And cNPCCharacter = cNPCCharacter;
              ObjectType   := AStream.ReadAnsiString();
              SkinObject   := AStream.ReadAnsiString();

              LoadMiscData(AStream, MiscData, ACounterSize, AStringSize);

              Dec(Z);
            End;
          End;
        End;

        Dec(Y);
      End;
    End;

    Dec(X);
  End;
End;

Procedure TBinTSTOHackMasterListImpl.LoadFromStreamV002(AStream : IStreamEx);
Var X, Y, Z, W : Integer;
    lItemFlags : Byte;
Begin
  X := AStream.ReadWord();
  While X > 0 Do
  Begin
    With Add() Do
    Begin
      Name       := AStream.ReadAnsiString();
      lItemFlags := AStream.ReadByte();
      Enabled    := lItemFlags And cCategoryEnabled = cCategoryEnabled;
      BuildStore := lItemFlags And cBuildStore = cBuildStore;

      Y := AStream.ReadByte();
      While Y > 0 Do
      Begin
        With Add() Do
        Begin
          PackageType := AStream.ReadAnsiString();
          XmlFile     := AStream.ReadAnsiString();
          Enabled     := AStream.ReadBoolean();

          Z := AStream.ReadByte();
          While Z > 0 Do
          Begin
            With Add() Do
            Begin
              Id           := AStream.ReadDWord();
              Name         := AStream.ReadAnsiString();
              lItemFlags   := AStream.ReadByte();
              AddInStore   := lItemFlags And cAddInStore = cAddInStore;
              OverRide     := lItemFlags And cOverRide = cOverRide;
              IsBadItem    := lItemFlags And cBadItem = cBadItem;
              NPCCharacter := lItemFlags And cNPCCharacter = cNPCCharacter;
              ObjectType   := AStream.ReadAnsiString();

              LoadMiscData(AStream, MiscData, 2, 1);

              Dec(Z);
            End;
          End;
        End;

        Dec(Y);
      End;
    End;

    Dec(X);
  End;
End;

Procedure TBinTSTOHackMasterListImpl.LoadFromStreamV001(AStream : IStreamEx);
Var X, Y, Z, W : Integer;
    lItemFlags : Byte;
Begin
  X := AStream.ReadWord();
  While X > 0 Do
  Begin
    With Add() Do
    Begin
      Name       := AStream.ReadAnsiString();
      lItemFlags := AStream.ReadByte();
      Enabled    := lItemFlags And cCategoryEnabled = cCategoryEnabled;
      BuildStore := lItemFlags And cBuildStore = cBuildStore;

      Y := AStream.ReadByte();
      While Y > 0 Do
      Begin
        With Add() Do
        Begin
          PackageType := AStream.ReadAnsiString();
          XmlFile     := AStream.ReadAnsiString();
          Enabled     := AStream.ReadBoolean();

          Z := AStream.ReadByte();
          While Z > 0 Do
          Begin
            With Add() Do
            Begin
              Id         := AStream.ReadDWord();
              Name       := AStream.ReadAnsiString();
              lItemFlags := AStream.ReadByte();
              AddInStore := lItemFlags And cAddInStore = cAddInStore;
              OverRide   := lItemFlags And cOverRide = cOverRide;
              IsBadItem  := lItemFlags And cBadItem = cBadItem;

              LoadMiscData(AStream, MiscData, 2, 1);

              Dec(Z);
            End;
          End;
        End;

        Dec(Y);
      End;
    End;

    Dec(X);
  End;
End;

Procedure TBinTSTOHackMasterListImpl.LoadFromStream(AStream : IStreamEx);
Begin
  Case AStream.ReadByte() Of
    1 : LoadFromStreamV001(AStream);
    2 : LoadFromStreamV002(AStream);
    3 : LoadFromStreamV003(AStream, 2, 1);
    4 : LoadFromStreamV004(AStream);
    5 : LoadFromStreamV005(AStream);

    Else
      Raise Exception.Create('Invalid file version');
  End;
End;

Procedure TBinTSTOHackMasterListImpl.SaveToStream(AStream : IStreamEx);
Var X, Y, Z, W : Integer;
    lItemFlags : Byte;
Begin
  AStream.WriteByte(cFileVersion);

  AStream.WriteWord(GetMovedItems().Count);
  For X := 0 To GetMovedItems().Count - 1 Do
  Begin
    With GetMovedItems()[X] Do
    Begin
      AStream.WriteAnsiString(XmlFileName);
      AStream.WriteAnsiString(OldCategory);
      AStream.WriteAnsiString(NewCategory);
    End;
  End;

  AStream.WriteWord(Count);
  For X := 0 To Count - 1 Do
  Begin
    AStream.WriteAnsiString(Category[X].Name);

    lItemFlags := 0;
    If Category[X].Enabled Then
      lItemFlags := lItemFlags Or cCategoryEnabled;
    If Category[X].BuildStore Then
      lItemFlags := lItemFlags Or cBuildStore;
    AStream.WriteByte(lItemFlags);

    AStream.WriteByte(Category[X].Count);
    For Y := 0 To Category[X].Count - 1 Do
    Begin
      AStream.WriteAnsiString(Category[X][Y].PackageType);
      AStream.WriteAnsiString(Category[X][Y].XmlFile);
      AStream.WriteBoolean(Category[X][Y].Enabled);

      AStream.WriteByte(Category[X][Y].Count);
      For Z := 0 To Category[X][Y].Count - 1 Do
      Begin
        AStream.WriteDWord(Category[X][Y][Z].Id);
        AStream.WriteAnsiString(Category[X][Y][Z].Name);

        lItemFlags := 0;
        If Category[X][Y][Z].AddInStore Then
          lItemFlags := lItemFlags Or cAddInStore;
        If Category[X][Y][Z].OverRide Then
          lItemFlags := lItemFlags Or cOverRide;
        If Category[X][Y][Z].IsBadItem Then
          lItemFlags := lItemFlags Or cBadItem;
        If Category[X][Y][Z].NPCCharacter Then
          lItemFlags := lItemFlags Or cNPCCharacter;

        AStream.WriteByte(lItemFlags);
        AStream.WriteAnsiString(Category[X][Y][Z].ObjectType);
        AStream.WriteAnsiString(Category[X][Y][Z].SkinObject);

        AStream.WriteWord(Max(Category[X][Y][Z].MiscData.Count - 2, 0));

        For W := 1 To Category[X][Y][Z].MiscData.Count - 2 Do
          AStream.WriteAnsiString(Category[X][Y][Z].MiscData[W], True, 2, False);
      End;
    End;
  End;
End;

end.
