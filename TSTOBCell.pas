unit TSTOBCell;

Interface

Uses Windows, Classes, SysUtils, RTLConsts, ExtCtrls, TSTORgb,
  HsInterfaceEx, HsStreamEx, HsZipUtils;

Type
  IBCellSubItem = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-811C-9E834727F7ED}']
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Function  GetString1() : AnsiString;
    Function  GetString2() : AnsiString;

    Function  GetPadding() : AnsiString;
    Procedure SetPadding(Const APadding : AnsiString);

    Property String1 : AnsiString Read GetString1;
    Property String2 : AnsiString Read GetString2;
    Property Padding : AnsiString Read GetPadding  Write SetPadding;

  End;

  IBCellSubItems = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-ACC5-AD106146755A}']
    Function  Get(Index : Integer) : IBCellSubItem;
    Procedure Put(Index : Integer; Const Item : IBCellSubItem);

    Function Add() : IBCellSubItem; OverLoad;
    Function Add(Const AItem : IBCellSubItem) : Integer; OverLoad;

    Property Items[Index : Integer] : IBCellSubItem Read Get Write Put; Default;

  End;

  IBCellItem = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-864C-85BB9941128B}']
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Function  GetRgbFileName() : AnsiString;

    Function  GetxDiffs() : Double;
    Procedure SetxDiffs(Const AxDiffs : Double);

    Function  GetNbSubItems() : Word;

    Function  GetSubItems() : IBCellSubItems;

    Property RgbFileName : AnsiString         Read GetRgbFileName;
    Property xDiffs      : Double         Read GetxDiffs       Write SetxDiffs;
    Property NbSubItems  : Word           Read GetNbSubItems;
    Property SubItems    : IBCellSubItems Read GetSubItems;

  End;

  IBCellItems = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-9219-826128EA18E2}']
    Function  Get(Index : Integer) : IBCellItem;
    Procedure Put(Index : Integer; Const Item : IBCellItem);

    Function Add() : IBCellItem; OverLoad;
    Function Add(Const AItem : IBCellItem) : Integer; OverLoad;

    Property Items[Index : Integer] : IBCellItem Read Get Write Put; Default;

  End;

  ITSTOBCellFile = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-8426-FA48515A107D}']
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Function  GetFileSig() : AnsiString;
    Procedure SetFileSig(Const AFileSig : AnsiString);

    Function  GetNbItem() : Word;

    Function  GetItems() : IBCellItems;

    Property FileSig : AnsiString      Read GetFileSig Write SetFileSig;
    Property NbItem  : Word        Read GetNbItem;
    Property Items   : IBCellItems Read GetItems;

  End;

  ITSTOBCellAnimation = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-9A1F-A0A24790BBBE}']
    Function GetFrames() : ITSTORgbFiles;

    Procedure Play();
    Procedure Stop();
    Procedure Pause();
    Procedure FirstFrame();
    Procedure LastFrame();
    Procedure NextFrame();
    Procedure PreviousFrame();

    Procedure LoadFromStream(AStream : IStreamEx);
    Procedure LoadFromZip(Const AFileName : AnsiString; AZip : IHsMemoryZipper);
    Procedure LoadFromFile(Const AFileName : AnsiString);

    Property Frames : ITSTORgbFiles Read GetFrames;

  End;

  TTSTOBCellFile = Class(TObject)
  Public
    Class Function CreateBCellFile() : ITSTOBCellFile;
    Class Function CreateBCellAnimation(APicture : TImage) : ITSTOBCellAnimation;

  End;

Implementation

Uses Math, Imaging, ImagingTypes, ImagingFormats, ImagingClasses,
  ImagingComponents, ImagingCanvases;

Type
  TBCellSubItem = Class(TInterfacedObjectEx, IBCellSubItem)
  Private
    FString1 : AnsiString;
    FString2 : AnsiString;
    FPadding : AnsiString;

  Protected
    Procedure Created(); OverRide;

    Function  GetString1() : AnsiString; Virtual;
    Function  GetString2() : AnsiString; Virtual;

    Function  GetPadding() : AnsiString; Virtual;
    Procedure SetPadding(Const APadding : AnsiString); Virtual;

    Procedure Clear();

  Public
    Procedure Assign(ASource : TObject); ReIntroduce; Virtual;

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

  End;

  TBCellSubItems = Class(TInterfaceListEx, IBCellSubItems)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : IBCellSubItem; OverLoad;
    Procedure Put(Index : Integer; Const Item : IBCellSubItem); OverLoad;

    Function Add() : IBCellSubItem; ReIntroduce; OverLoad;
    Function Add(Const AItem : IBCellSubItem) : Integer; ReIntroduce; OverLoad;

  End;

  TBCellItem = Class(TInterfacedObjectEx, IBCellItem)
  Private
    FRgbFileName : AnsiString;
    FxDiffs      : Double;
    FSubItems    : IBCellSubItems;

  Protected
    Procedure Created(); OverRide;

    Function  GetRgbFileName() : AnsiString; Virtual;

    Function  GetxDiffs() : Double; Virtual;
    Procedure SetxDiffs(Const AxDiffs : Double); Virtual;

    Function  GetNbSubItems() : Word; Virtual;

    Function  GetSubItems() : IBCellSubItems; Virtual;

    Procedure Clear();

  Public
    Procedure Assign(ASource : TObject); ReIntroduce; Virtual;

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Destructor Destroy(); OverRide;

  End;

  TBCellItems = Class(TInterfaceListEx, IBCellItems)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : IBCellItem; OverLoad;
    Procedure Put(Index : Integer; Const Item : IBCellItem); OverLoad;

    Function Add() : IBCellItem; OverLoad;
    Function Add(Const AItem : IBCellItem) : Integer; OverLoad;

  End;

  TTSTOBCellFileImpl = Class(TInterfacedObjectEx, ITSTOBCellFile)
  Private
    FFileSig : AnsiString;
    FItems   : IBCellItems;

  Protected
    Function  GetFileSig() : AnsiString; Virtual;
    Procedure SetFileSig(Const AFileSig : AnsiString); Virtual;

    Function  GetNbItem() : Word; Virtual;

    Function  GetItems() : IBCellItems; Virtual;

    Procedure Clear();

  Public
    Procedure Assign(ASource : TObject); ReIntroduce; Virtual;

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Constructor Create(); ReIntroduce; Virtual;

    Destructor Destroy(); OverRide;

  End;

  TTSTOBCellAnimation = Class(TInterfacedObjectEx, ITSTOBCellAnimation)
  Private
    FImages  : TDynImageDataArray;
    FTimer   : TTimer;
    FPicture : TImage;
    FImgIdx  : Integer;
    FPath    : AnsiString;
    FBackColor : DWord;

    Procedure DoOnTimer(Sender : TObject);
    Procedure InitFrames(ABCell : ITSTOBCellFile);
    Procedure DisplayImage();

  Protected
    Function GetFrames() : ITSTORgbFiles;

    Procedure Play();
    Procedure Stop();
    Procedure Pause();
    Procedure FirstFrame();
    Procedure LastFrame();
    Procedure NextFrame();
    Procedure PreviousFrame();

    Procedure LoadFromStream(AStream : IStreamEx);
    Procedure LoadFromZip(Const AFileName : AnsiString; AZip : IHsMemoryZipper);
    Procedure LoadFromFile(Const AFileName : AnsiString);

  Public
    Constructor Create(APicture : TImage); ReIntroduce; Virtual;
    Destructor  Destroy(); OverRide;

  End;

Class Function TTSTOBCellFile.CreateBCellFile() : ITSTOBCellFile;
Begin
  Result := TTSTOBCellFileImpl.Create();
End;

Class Function TTSTOBCellFile.CreateBCellAnimation(APicture : TImage) : ITSTOBCellAnimation;
Begin
  Result := TTSTOBCellAnimation.Create(APicture);
End;

(******************************************************************************)

Procedure TBCellSubItem.Created();
Begin
  InHerited Created();

  Clear();
End;

Procedure TBCellSubItem.Clear();
Begin
  FPadding := '';
  FString1 := '';
  FString2 := '';
End;

Procedure TBCellSubItem.Assign(ASource : TObject);
Var lSrc : IBCellSubItem;
Begin
  If Supports(ASource, IBCellSubItem, lSrc) Then
  Begin
    FString1 := lSrc.String1;
    FString2 := lSrc.String2;
    FPadding := lSrc.Padding;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [ASource.ClassName, ClassName]);
End;

Procedure TBCellSubItem.LoadFromStream(ASource : IStreamEx);
Begin
  FString1 := ASource.ReadAnsiString(ASource.ReadByte() - 1);
  ASource.ReadByte();
  FString1 := ASource.ReadAnsiString(ASource.ReadByte() - 1);
  ASource.ReadByte();
  FPadding := ASource.ReadAnsiString(28);
End;

Procedure TBCellSubItem.SaveToStream(ATarget : IStreamEx);
Begin
  ATarget.WriteAnsiString(FString1 + #0);
  ATarget.WriteAnsiString(FString2 + #0);
  ATarget.WriteAnsiString(FPadding, False);
End;

Function TBCellSubItem.GetString1() : AnsiString;
Begin
  Result := FString1;
End;

Function TBCellSubItem.GetString2() : AnsiString;
Begin
  Result := FString2;
End;

Function TBCellSubItem.GetPadding() : AnsiString;
Begin
  Result := FPadding;
End;

Procedure TBCellSubItem.SetPadding(Const APadding : AnsiString);
Begin
  FPadding := APadding;
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

Procedure TBCellItem.Clear();
Begin
  FRgbFileName := '';
  FxDiffs      := 0;
  FSubItems    := TBCellSubItems.Create();
End;

Procedure TBCellItem.Assign(ASource : TObject);
Var lSrc : IBCellItem;
Begin
  If Supports(ASource, IBCellItem, lSrc) Then
  Begin
    FRgbFileName := lSrc.RgbFileName;
    FxDiffs      := lSrc.xDiffs;
    FSubItems    := lSrc.SubItems;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [ASource.ClassName, ClassName]);
End;

Procedure TBCellItem.LoadFromStream(ASource : IStreamEx);
Var lNbSubItems : Word;
Begin
  FRgbFileName := ASource.ReadAnsiString(ASource.ReadByte() - 1);
  ASource.ReadByte();

  FxDiffs     := ASource.ReadFloat();
  lNbSubItems := ASource.ReadWord(True);
  While lNbSubItems > 0 Do
  Begin
    FSubItems.Add().LoadFromStream(ASource);
    Dec(lNbSubItems)
  End;
End;

Procedure TBCellItem.SaveToStream(ATarget : IStreamEx);
Var X : Integer;
Begin
  ATarget.WriteAnsiString(FRgbFileName + #0);
  ATarget.WriteFloat(FxDiffs);
  ATarget.WriteWord(FSubItems.Count, True);
  For X := 0 To FSubItems.Count - 1 Do
    FSubItems[X].SaveToStream(ATarget);
End;

Function TBCellItem.GetRgbFileName() : AnsiString;
Begin
  Result := FRgbFileName;
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

Constructor TTSTOBCellFileImpl.Create();
Begin
  InHerited Create();

  FItems := TBCellItems.Create();
End;

Destructor TTSTOBCellFileImpl.Destroy();
Begin
  FItems := Nil;

  InHerited Destroy();
End;

Procedure TTSTOBCellFileImpl.Clear();
Begin
  FFileSig := '';
End;

Procedure TTSTOBCellFileImpl.Assign(ASource : TObject);
Var lSrc : ITSTOBCellFile;
Begin
  If Supports(ASource, ITSTOBCellFile, lSrc) Then
  Begin
    FFileSig := lSrc.FileSig;
    FItems   := lSrc.Items;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [ASource.ClassName, ClassName]);
End;

Procedure TTSTOBCellFileImpl.LoadFromStream(ASource : IStreamEx);
Var lNbItems : Word;
Begin
  FFileSig := ASource.ReadAnsiString(8);
  lNbItems := ASource.ReadWord();
  While lNbItems > 0 Do
  Begin
    FItems.Add().LoadFromStream(ASource);
    Dec(lNbItems)
  End;
End;

Procedure TTSTOBCellFileImpl.SaveToStream(ATarget : IStreamEx);
Var X : Integer;
Begin
  ATarget.WriteAnsiString(FFileSig, False);
  ATarget.WriteWord(FItems.Count);
  For X := 0 To FItems.Count - 1 Do
    FItems[X].SaveToStream(ATarget);
End;

Function TTSTOBCellFileImpl.GetFileSig() : AnsiString;
Begin
  Result := FFileSig;
End;

Procedure TTSTOBCellFileImpl.SetFileSig(Const AFileSig : AnsiString);
Begin
  FFileSig := AFileSig;
End;

Function TTSTOBCellFileImpl.GetNbItem() : Word;
Begin
  Result := FItems.Count;
End;

Function TTSTOBCellFileImpl.GetItems() : IBCellItems;
Begin
  Result := FItems;
End;

(******************************************************************************)

Constructor TTSTOBCellAnimation.Create(APicture : TImage);
Begin
  InHerited Create(True);

  FPicture := APicture;

  FImgIdx    := 0;
  FBackColor := $FFF0F0F0;

  FTimer          := TTimer.Create(Nil);
  FTimer.Interval := 150;
  FTimer.OnTimer  := DoOnTimer;
End;

Destructor TTSTOBCellAnimation.Destroy();
Begin
  FreeImagesInArray(FImages);
  FreeAndNil(FTimer);

  InHerited Destroy();
End;

Procedure TTSTOBCellAnimation.DisplayImage();
Var lCvsSrc ,
    lCvsTrg : TFastARGB32Canvas;
    lImgTrg : TImageData;
Begin
  If Assigned(FPicture) Then
  Begin
    NewImage(FImages[FImgIdx].Width, FImages[FImgIdx].Height, ifA8R8G8B8, lImgTrg);
    lCvsSrc := TFastARGB32Canvas.CreateForData(@FImages[FImgIdx]);
    lCvsTrg := TFastARGB32Canvas.CreateForData(@lImgTrg);
    Try
      lCvsTrg.FillColor32 := FBackColor;
      lCvsTrg.Clear();

      lCvsSrc.DrawAlpha(Rect(0, 0, lImgTrg.Width, lImgTrg.Height), lCvsTrg, 0, 0);
      With FPicture.Picture.Bitmap Do
        DisplayImageData( Canvas, Rect(0, 0, Width, Height), lImgTrg,
          Rect(0, 0, lImgTrg.Width, lImgTrg.Height)
        );
      FPicture.Invalidate();

      Finally
        lCvsTrg.Free();
        lCvsSrc.Free();
        FreeImage(lImgTrg);
    End;
  End;
End;

Procedure TTSTOBCellAnimation.DoOnTimer(Sender : TObject);
Begin
  NextFrame();
End;

Function TTSTOBCellAnimation.GetFrames() : ITSTORgbFiles;
Begin
//  Result := FImages;
End;

Procedure TTSTOBCellAnimation.Play();
Begin
  FTimer.Enabled := True;
End;

Procedure TTSTOBCellAnimation.Stop();
Begin
  FTimer.Enabled := False;
  FImgIdx := 0;

  DisplayImage();
End;

Procedure TTSTOBCellAnimation.Pause();
Begin
  FTimer.Enabled := False;
End;

Procedure TTSTOBCellAnimation.FirstFrame();
Begin
  FImgIdx := 0;
  DisplayImage();
End;

Procedure TTSTOBCellAnimation.LastFrame();
Begin
  FImgIdx := High(FImages);
  DisplayImage();
End;

Procedure TTSTOBCellAnimation.NextFrame();
Begin
  If FImgIdx < High(FImages) Then
    Inc(FImgIdx)
  Else
    FImgIdx := 0;

  DisplayImage();
End;

Procedure TTSTOBCellAnimation.PreviousFrame();
Begin
  If FImgIdx > 0 Then
    Dec(FImgIdx)
  Else
    FImgIdx := High(FImages);

  DisplayImage();
End;

Procedure TTSTOBCellAnimation.InitFrames(ABCell : ITSTOBCellFile);
Var X : Integer;
    lW, lH : Integer;
    lWorkImg : TDynImageDataArray;
Begin
  lW := 0;
  lH := 0;

  For X := Low(FImages) To High(FImages) Do
  Begin
    lW := Max(lW, FImages[X].Width);
    lH := Max(lH, FImages[X].Height);
  End;

  If Assigned(FPicture) Then
  Begin
    FPicture.Height := lH;
    FPicture.Width  := lW;
    FPicture.Picture.Bitmap.Height := lH;
    FPicture.Picture.Bitmap.Width  := lW;
  End;

  SetLength(lWorkImg, Length(FImages));

  For X := 0 To ABCell.Items.Count - 1 Do
  Begin
    NewImage(lW, lH, ifA8R8G8B8, lWorkImg[X]);
    CopyRect( FImages[X], 0, 0, FImages[X].Width, FImages[X].Height,
              lWorkImg[X], lW - FImages[X].Width, lH - FImages[X].Height);
//              lWorkImg[X], Round(lW - ABCell.Items[X].xDiffs), lH - FImages[X].Height);
  End;

  FreeImagesInArray(FImages);
  FImages := lWorkImg;
End;

Procedure TTSTOBCellAnimation.LoadFromStream(AStream : IStreamEx);
Var lBCell : ITSTOBCellFile;
    X : Integer;
Begin
  FreeImagesInArray(FImages);
  SetLength(FImages, 0);

  lBCell := TTSTOBCellFile.CreateBCellFile();
  Try
    lBCell.LoadFromStream(AStream);

    SetLength(FImages, lBCell.Items.Count);
    For X := 0 To lBCell.Items.Count - 1 Do
      If FileExists(FPath + lBCell.Items[X].RgbFileName) Then
        LoadImageFromFile(FPath + lBCell.Items[X].RgbFileName, FImages[X]);

    InitFrames(lBCell);

    Finally
      lBCell := Nil;
  End;
End;

Procedure TTSTOBCellAnimation.LoadFromZip(Const AFileName : AnsiString; AZip : IHsMemoryZipper);
Var lBCell : ITSTOBCellFile;
    lMem : IMemoryStreamEx;
    X    : Integer;
Begin
  FreeImagesInArray(FImages);
  SetLength(FImages, 0);

  AZip.ShowProgress := False;

  lMem := TMemoryStreamEx.Create();
  Try
    AZip.ExtractToStream(AFileName, lMem);
    If lMem.Size > 0 Then
    Begin
      lMem.Position := 0;
      lBCell := TTSTOBCellFile.CreateBCellFile();
      Try
        lBCell.LoadFromStream(lMem);

        SetLength(FImages, lBCell.Items.Count);
        For X := 0 To lBCell.Items.Count - 1 Do
        Begin
          lMem.Clear();
          AZip.ExtractToStream(lBCell.Items[X].RgbFileName, lMem);
          lMem.Position := 0;
          LoadImageFromStream(TStream(lMem.InterfaceObject), FImages[X]);
        End;

        InitFrames(lBCell);

        Finally
          lBCell := Nil;
      End;
    End;

    Finally
      lMem := Nil;
  End;
End;

Procedure TTSTOBCellAnimation.LoadFromFile(Const AFileName : AnsiString);
Var lMem : IMemoryStreamEx;
Begin
  FPath := ExtractFilePath(AFileName);
  lMem := TMemoryStreamEx.Create();
  Try
    lMem.LoadFromFile(AFileName);
    LoadFromStream(lMem);

    Finally
      lMem := Nil;
  End;
End;

End.
