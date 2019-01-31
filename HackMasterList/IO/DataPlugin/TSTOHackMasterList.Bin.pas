unit TSTOHackMasterList.Bin;

interface

Uses HsInterfaceEx, HsStreamEx,
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
  Math, SysUtils, TSTOHackMasterListImpl;


Type
  TBinTSTOHackMasterListImpl = Class(TTSTOHackMasterList, IBinTSTOHackMasterList)
  Private
    Procedure LoadFromStreamV001(AStream : IStreamEx);
    Procedure LoadFromStreamV002(AStream : IStreamEx);
    Procedure LoadFromStreamV003(AStream : IStreamEx);
    Procedure LoadFromStreamV004(AStream : IStreamEx);

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
  cFileVersion = 4;

  cCategoryEnabled = 1;
  cBuildStore = 2;
  cBadItem = 4;
  cNPCCharacter = 8;
  cAddInStore = 1;
  cOverRide = 2;

Procedure TBinTSTOHackMasterListImpl.LoadFromStreamV004(AStream : IStreamEx);
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

  LoadFromStreamV003(AStream);
End;

Procedure TBinTSTOHackMasterListImpl.LoadFromStreamV003(AStream : IStreamEx);
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

              W := AStream.ReadWord();
              MiscData.Add('<MiscData>');
              While W > 0 Do
              Begin
                MiscData.Add(AStream.ReadAnsiString());

                Dec(W);
              End;
              MiscData.Add('</MiscData>');

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

              W := AStream.ReadWord();
              MiscData.Add('<MiscData>');
              While W > 0 Do
              Begin
                MiscData.Add(AStream.ReadAnsiString());

                Dec(W);
              End;
              MiscData.Add('</MiscData>');

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

              W := AStream.ReadWord();
              MiscData.Add('<MiscData>');
              While W > 0 Do
              Begin
                MiscData.Add(AStream.ReadAnsiString());

                Dec(W);
              End;
              MiscData.Add('</MiscData>');

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
    3 : LoadFromStreamV003(AStream);
    4 : LoadFromStreamV004(AStream);

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
          AStream.WriteAnsiString(Category[X][Y][Z].MiscData[W]);
      End;
    End;
  End;
End;

end.
