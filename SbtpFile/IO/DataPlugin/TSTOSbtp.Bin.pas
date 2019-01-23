unit TSTOSbtp.Bin;

interface

Uses Windows, HsStreamEx, TSTOSbtpIntf;

Type
  IBinSbtpSubVariable = Interface(ISbtpSubVariable)
    ['{4B61686E-29A0-2112-91BD-618FC563E57D}']
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

  End;

  IBinSbtpSubVariables = Interface(ISbtpSubVariables)
    ['{4B61686E-29A0-2112-AD5D-BDA0707E79C0}']
    Function  Get(Index : Integer) : IBinSbtpSubVariable;
    Procedure Put(Index : Integer; Const Item : IBinSbtpSubVariable);

    Function Add() : IBinSbtpSubVariable; OverLoad;
    Function Add(Const AItem : IBinSbtpSubVariable) : Integer; OverLoad;

    Property Items[Index : Integer] : IBinSbtpSubVariable Read Get Write Put; Default;

  End;

  IBinSbtpVariable = Interface(ISbtpVariable)
    ['{4B61686E-29A0-2112-B4F0-E9282D0EBD3D}']
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Function  GetSubItem() : IBinSbtpSubVariables;

    Property SubItem : IBinSbtpSubVariables Read GetSubItem;

  End;

  IBinSbtpVariables = Interface(ISbtpVariables)
    ['{4B61686E-29A0-2112-9B6F-61BCC5656B3F}']
    Function  Get(Index : Integer) : IBinSbtpVariable;
    Procedure Put(Index : Integer; Const Item : IBinSbtpVariable);

    Function Add() : IBinSbtpVariable; OverLoad;
    Function Add(Const AItem : IBinSbtpVariable) : Integer; OverLoad;

    Property Items[Index : Integer] : IBinSbtpVariable Read Get Write Put; Default;

  End;

  IBinSbtpHeader = Interface(ISbtpHeader)
    ['{4B61686E-29A0-2112-9F36-1A81FBE06C31}']
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

  End;

  IBinSbtpFile = Interface(ISbtpFile)
    ['{4B61686E-29A0-2112-A562-E106D9FBFE45}']
    Function  GetHeader() : IBinSbtpHeader;

    Function  GetItem() : IBinSbtpVariables;

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Property Header : IBinSbtpHeader    Read GetHeader;
    Property Item   : IBinSbtpVariables Read GetItem;

  End;

  IBinSbtpFiles = Interface(ISbtpFiles)
    ['{4B61686E-29A0-2112-6969-6CC05ECFA921}']
    Function  Get(Index : Integer) : IBinSbtpFile;
    Procedure Put(Index : Integer; Const Item : IBinSbtpFile);

    Function Add() : IBinSbtpFile; OverLoad;
    Function Add(Const AItem : IBinSbtpFile) : Integer; OverLoad;

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Property Items[Index : Integer] : IBinSbtpFile Read Get Write Put; Default;

  End;

  TBinSbtpFile = Class(TObject)
  Public
    Class Function CreateSbtpFile() : IBinSbtpFile; OverLoad;
    Class Function CreateSbtpFile(AStream : IStreamEx) : IBinSbtpFile; OverLoad;
    Class Function CreateSbtpFiles() : IBinSbtpFiles;

  End;

implementation

Uses Forms, HsInterfaceEx, TSTOSbtpImpl;

Type
  TBinSbtpSubVariable = Class(TSbtpSubVariable, IBinSbtpSubVariable)
  Protected
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Property VariableName : String Read GetVariableName Write SetVariableName;
    Property VariableData : String Read GetVariableData Write SetVariableData;
    
  End;

  TBinSbtpSubVariables = Class(TSbtpSubVariables, IBinSbtpSubVariables)
  Protected
    Function  GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : IBinSbtpSubVariable; OverLoad;
    Procedure Put(Index : Integer; Const Item : IBinSbtpSubVariable); OverLoad;

    Function Add() : IBinSbtpSubVariable; OverLoad;
    Function Add(Const AItem : IBinSbtpSubVariable) : Integer; OverLoad;

  End;

  TBinSbtpVariable = Class(TSbtpVariable, IBinSbtpVariable)
  Protected
    Function GetSubItem() : IBinSbtpSubVariables; OverLoad;
    Function GetSubItemClass() : TSbtpSubVariablesClass; OverRide;

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Property VariableType : String               Read GetVariableType Write SetVariableType;
    Property NbSubItems   : DWord                Read GetNbSubItems;
    Property SubItem      : IBinSbtpSubVariables Read GetSubItem;

  End;

  TBinSbtpVariables = Class(TSbtpVariables, IBinSbtpVariables)
  Protected
    Function  GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : IBinSbtpVariable; OverLoad;
    Procedure Put(Index : Integer; Const Item : IBinSbtpVariable); OverLoad;

    Function Add() : IBinSbtpVariable; OverLoad;
    Function Add(Const AItem : IBinSbtpVariable) : Integer; OverLoad;

  End;

  TBinSbtpHeader = Class(TSbtpHeader, IBinSbtpHeader)
  Private
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Property Header        : String Read GetHeader        Write SetHeader;
    Property HeaderPadding : Word   Read GetHeaderPadding Write SetHeaderPadding;

  End;

  TBinSbtpFileImpl = Class(TSbtpFile, IBinSbtpFile)
  Protected
    Function GetHeader() : IBinSbtpHeader; OverLoad;
    Function GetHeaderClass() : TSbtpHeaderClass; OverRide;
    Function GetItem() : IBinSbtpVariables; OverLoad;
    Function GetItemClass() : TSbtpVariablesClass; OverRide;

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Property Header : IBinSbtpHeader    Read GetHeader;
    Property Item   : IBinSbtpVariables Read GetItem;

  End;

  TBinSbtpFilesImpl = Class(TSbtpFiles, IBinSbtpFiles)
  Protected
    Function  GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : IBinSbtpFile; OverLoad;
    Procedure Put(Index : Integer; Const Item : IBinSbtpFile); OverLoad;

    Function Add() : IBinSbtpFile; OverLoad;
    Function Add(Const AItem : IBinSbtpFile) : Integer; OverLoad;

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

  End;

Class Function TBinSbtpFile.CreateSbtpFile() : IBinSbtpFile;
Begin
  Result := TBinSbtpFileImpl.Create();
End;

Class Function TBinSbtpFile.CreateSbtpFile(AStream : IStreamEx) : IBinSbtpFile;
Begin
  Result := TBinSbtpFileImpl.Create();
  With KeepStreamPosition(AStream, 0) Do
    Result.LoadFromStream(AStream);
End;

Class Function TBinSbtpFile.CreateSbtpFiles() : IBinSbtpFiles;
Begin
  Result := TBinSbtpFilesImpl.Create();
End;

(******************************************************************************)

Procedure TBinSbtpSubVariable.LoadFromStream(ASource : IStreamEx);
Begin
  VariableName := ASource.ReadAnsiString();
  VariableData := ASource.ReadAnsiString(SizeOf(DWord), True);
End;

Procedure TBinSbtpSubVariable.SaveToStream(ATarget : IStreamEx);
Begin
  ATarget.WriteAnsiString(VariableName);
  ATarget.WriteAnsiString(VariableData, True, SizeOf(DWord), True);
End;

Function TBinSbtpSubVariables.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TBinSbtpSubVariable;
End;

Function TBinSbtpSubVariables.Get(Index : Integer) : IBinSbtpSubVariable;
Begin
  Result := InHerited Items[Index] As IBinSbtpSubVariable;
End;

Procedure TBinSbtpSubVariables.Put(Index : Integer; Const Item : IBinSbtpSubVariable);
Begin
  InHerited Items[Index] := Item;
End;

Function TBinSbtpSubVariables.Add() : IBinSbtpSubVariable;
Begin
  Result := InHerited Add() As IBinSbtpSubVariable;
End;

Function TBinSbtpSubVariables.Add(Const AItem : IBinSbtpSubVariable) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Function TBinSbtpVariable.GetSubItem() : IBinSbtpSubVariables;
Begin
  Result := InHerited GetSubItem() As IBinSbtpSubVariables;
End;

Function TBinSbtpVariable.GetSubItemClass() : TSbtpSubVariablesClass;
Begin
  Result := TBinSbtpSubVariables;
End;

Procedure TBinSbtpVariable.LoadFromStream(ASource : IStreamEx);
Var lNbSubItems : DWord;
Begin
  VariableType := ASource.ReadAnsiString();
  lNbSubItems := ASource.ReadDWord(True);

  While lNbSubItems > 0 Do
  Begin
    SubItem.Add().LoadFromStream(ASource);
    Application.ProcessMessages();
    Dec(lNbSubItems)
  End;
End;

Procedure TBinSbtpVariable.SaveToStream(ATarget : IStreamEx);
Var X : Integer;
Begin
  ATarget.WriteAnsiString(VariableType);
  ATarget.WriteDWord(SubItem.Count, True);
  For X := 0 To SubItem.Count - 1 Do
    SubItem[X].SaveToStream(ATarget);
End;

Function TBinSbtpVariables.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TBinSbtpVariable;
End;

Function TBinSbtpVariables.Get(Index : Integer) : IBinSbtpVariable;
Begin
  Result := InHerited Items[Index] As IBinSbtpVariable;
End;

Procedure TBinSbtpVariables.Put(Index : Integer; Const Item : IBinSbtpVariable);
Begin
  InHerited Items[Index] := Item;
End;

Function TBinSbtpVariables.Add() : IBinSbtpVariable;
Begin
  Result := InHerited Add() As IBinSbtpVariable;
End;

Function TBinSbtpVariables.Add(Const AItem : IBinSbtpVariable) : Integer;
Begin
  Result := InHerited Add(AItem);
End;


Procedure TBinSbtpHeader.LoadFromStream(ASource : IStreamEx);
Begin
  Header        := ASource.ReadAnsiString(4);
  HeaderPadding := ASource.ReadWord(True);
End;

Procedure TBinSbtpHeader.SaveToStream(ATarget : IStreamEx);
Begin
  ATarget.WriteAnsiString(Header, False);
  ATarget.WriteWord(HeaderPadding, True);
End;

Function TBinSbtpFileImpl.GetHeaderClass() : TSbtpHeaderClass;
Begin
  Result := TBinSbtpHeader;
End;

Function TBinSbtpFileImpl.GetItemClass() : TSbtpVariablesClass;
Begin
  Result := TBinSbtpVariables;
End;

Function TBinSbtpFileImpl.GetHeader() : IBinSbtpHeader;
Begin
  Result := InHerited GetHeader() As IBinSbtpHeader;
End;

Function TBinSbtpFileImpl.GetItem() : IBinSbtpVariables;
Begin
  Result := InHerited GetItem() As IBinSbtpVariables;
End;

Procedure TBinSbtpFileImpl.LoadFromStream(ASource : IStreamEx);
Begin
  Clear();
  Header.LoadFromStream(ASource);

  Repeat
    Item.Add().LoadFromStream(ASource);
  Until ASource.Position >= ASource.Size;
End;

Procedure TBinSbtpFileImpl.SaveToStream(ATarget : IStreamEx);
Var X : Integer;
Begin
  Header.SaveToStream(ATarget);
  For X := 0 To Item.Count - 1 Do
    Item[X].SaveToStream(ATarget);
End;

Function TBinSbtpFilesImpl.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TBinSbtpFileImpl;
End;

Function TBinSbtpFilesImpl.Get(Index : Integer) : IBinSbtpFile;
Begin
  Result := InHerited Items[Index] As IBinSbtpFile;
End;

Procedure TBinSbtpFilesImpl.Put(Index : Integer; Const Item : IBinSbtpFile);
Begin
  InHerited Items[Index] := Item;
End;

Function TBinSbtpFilesImpl.Add() : IBinSbtpFile;
Begin
  Result := InHerited Add() As IBinSbtpFile;
End;

Function TBinSbtpFilesImpl.Add(Const AItem : IBinSbtpFile) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Procedure TBinSbtpFilesImpl.LoadFromStream(ASource : IStreamEx);
Var lNbFiles : Byte;
    lNbVars  : Byte;
Begin
  lNbFiles := ASource.ReadByte();
  While lNbFiles > 0 Do
  Begin
    With Add() Do
    Begin
      lNbVars := ASource.ReadByte();
      Header.HeaderPadding := ASource.ReadByte();

      While lNbVars > 0 Do
      Begin
        Item.Add().LoadFromStream(ASource);
        Dec(lNbVars);
      End;
    End;
    Dec(lNbFiles);
  End;
End;

Procedure TBinSbtpFilesImpl.SaveToStream(ATarget : IStreamEx);
Var X, Y : Integer;
Begin
  ATarget.WriteByte(Count);
  For X := 0 To Count - 1 Do
  Begin
    With Get(X) Do
    Begin
      ATarget.WriteByte(Item.Count);
      ATarget.WriteByte(Header.HeaderPadding);

      For Y := 0 To Item.Count - 1 Do
        Item[Y].SaveToStream(ATarget);
    End;
  End;
End;

end.
