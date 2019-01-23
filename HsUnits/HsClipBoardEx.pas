Unit HsClipBoardEx;

Interface

Uses Windows, Classes, Clipbrd;

Var CF_RAWDATA : Word;

Type
  THsClipBoard = Class(TClipboard)
  Public
    Procedure SetData(AData : TMemoryStream); OverLoad;
    Procedure SetData(AData : TMemoryStream; ADataType : Word); OverLoad;

    Function GetData() : TMemoryStream; OverLoad;
    Function GetData(ADataType : Word) : TMemoryStream; OverLoad;

  End;

Function ClipBoard() : THsClipBoard;

Implementation

Procedure THsClipBoard.SetData(AData : TMemoryStream; ADataType : Word);
Begin
  SetBuffer(ADataType, TMemoryStream(AData).Memory^, TMemoryStream(AData).Size);
End;

Procedure THsClipBoard.SetData(AData: TMemoryStream);
Begin
  SetData(AData, CF_RAWDATA);
End;

Function THsClipBoard.GetData(ADataType : Word) : TMemoryStream;
Var Data    : THandle;
    DataPtr : Pointer;
Begin
  Result := Nil;
  Open();
  Try
    Data := GetClipboardData(ADataType);

    If Data = 0 Then Exit;
    DataPtr := GlobalLock(Data);

    If DataPtr = Nil Then Exit;
    Try
      Result := TMemoryStream.Create();
      TMemoryStream(Result).WriteBuffer(DataPtr^, GlobalSize(Data));
      TMemoryStream(Result).Position := 0;

      Finally
        GlobalUnlock(Data);
    End;

    Finally
      Close();
  End;
End;

Function THsClipBoard.GetData() : TMemoryStream;
Begin
  Result := GetData(CF_RAWDATA);
End;

(******************************************************************************)

Var FHsClipBoard: THsClipBoard;

Function ClipBoard() : THsClipBoard;
Begin
  If FHsClipBoard = Nil Then
    FHsClipBoard := THsClipBoard.Create();

  Result := FHsClipBoard;
End;

Initialization
  FHsClipBoard := Nil;
  CF_RAWDATA   := RegisterClipboardFormat('RawData');

Finalization
  If Assigned(FHsClipBoard) Then
    FHsClipBoard.Free();

End.

