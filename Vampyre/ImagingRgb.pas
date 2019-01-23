unit ImagingRgb;

interface

Uses Windows, ExtCtrls, Graphics,
  Imaging, ImagingTypes, ImagingClasses;

Type
  TRgbFileFormat = Class(TImageFileFormat)
  Protected
    Procedure Define(); OverRide;

    Function LoadData(Handle : TImagingHandle; Var Images : TDynImageDataArray;
      OnlyFirstLevel : Boolean) : Boolean; OverRide;
    Function SaveData(Handle : TImagingHandle; Const Images : TDynImageDataArray;
      Index : LongInt) : Boolean; OverRide;
    Procedure ConvertToSupported(Var Image: TImageData;
      Const Info: TImageFormatInfo); OverRide;

  Public
    Function TestFormat(Handle : TImagingHandle) : Boolean; OverRide;

  End;

  TRgbxFileFormat = Class(TImageFileFormat)
  Protected
    Procedure Define(); OverRide;

    Function LoadData(Handle : TImagingHandle; Var Images : TDynImageDataArray;
      OnlyFirstLevel : Boolean) : Boolean; OverRide;
    Function SaveData(Handle : TImagingHandle; Const Images : TDynImageDataArray;
      Index : LongInt) : Boolean; OverRide;
    Function IsSupported(Const Image: TImageData): Boolean; OverRide;

  Public
    Function TestFormat(Handle : TImagingHandle) : Boolean; OverRide;

  End;

  TImagingAnimation = Class(TObject)
  Private
    FTimer     : TTimer;
    FAnimation : TMultiImage;
    FImage     : TImage;
    FPaintBox  : TPaintBox;
    FBackColor : TColor32;
    FCanvas    : TCanvas;

    Procedure InitAnimation(Const AAnimation : TMultiImage);

    Procedure DoOnTimer(Sender : TObject);
    Procedure DoOnPaintBoxPaint(Sender : TObject);

  Public
    Constructor Create(APaintBox : TPaintBox; AAnimation : TMultiImage); ReIntroduce; OverLoad;
    Constructor Create(AImage : TImage; AAnimation : TMultiImage); ReIntroduce; OverLoad;
    Destructor Destroy(); OverRide;

  End;

implementation

Uses
  ImagingUtility, ImagingIO, ImagingComponents, ImagingCanvases, //HsStreamEx,
  Dialogs, SysUtils, Classes;

Const
  RgbMap : Array[0..$F] Of Byte = ( //-> Round(X / $F * $FF)
    $00, $11, $22, $33,
    $44, $55, $66, $77,
    $88, $99, $AA, $BB,
    $CC, $DD, $EE, $FF
  );
  RgbMult : Array[0..$F] Of Double = ( //-> $FF / RgbMap[X]
    0, 15, 7.5, 5,
    3.75, 3, 2.5, 2.14285714285714,
    1.875, 1.66666666666667, 1.5, 1.36363636363636,
    1.25, 1.15384615384615, 1.07142857142857, 1
  );
  RgbPreMult : Array[0..$F, 0..$F] Of Byte = ( //Color, Alpha -> ClampToByte(Round(RgbMap[X] * RgbMult[X]))
    ($00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00),
    ($00, $FF, $80, $55, $40, $33, $2A, $24, $20, $1C, $1A, $17, $15, $14, $12, $11),
    ($00, $FF, $FF, $AA, $80, $66, $55, $49, $40, $39, $33, $2E, $2A, $27, $24, $22),
    ($00, $FF, $FF, $FF, $BF, $99, $80, $6D, $60, $55, $4C, $46, $40, $3B, $37, $33),
    ($00, $FF, $FF, $FF, $FF, $CC, $AA, $92, $80, $71, $66, $5D, $55, $4E, $49, $44),
    ($00, $FF, $FF, $FF, $FF, $FF, $D4, $B6, $9F, $8E, $80, $74, $6A, $62, $5B, $55),
    ($00, $FF, $FF, $FF, $FF, $FF, $FF, $DB, $BF, $AA, $99, $8B, $80, $76, $6D, $66),
    ($00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $DF, $C6, $B2, $A2, $95, $89, $7F, $77),
    ($00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $E3, $CC, $B9, $AA, $9D, $92, $88),
    ($00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $E6, $D1, $BF, $B1, $A4, $99),
    ($00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $E8, $D4, $C4, $B6, $AA),
    ($00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $EA, $D8, $C8, $BB),
    ($00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $EB, $DB, $CC),
    ($00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $ED, $DD),
    ($00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $EE),
    ($00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF)
  );

Type
  TRgbHeader = Packed Record
    FileSig : DWord;
    Width   : Word;
    Height  : Word;
  End;

Procedure TRgbFileFormat.Define();
Begin
  FName := 'Simpson Rgb Image';
  FFeatures := [ffLoad, ffSave];
  FSupportedFormats   := [ifA4R4G4B4, ifA8R8G8B8]; //TWordArray - TColor32Rec

  AddMasks('*.rgb');
End;

Function TRgbFileFormat.TestFormat(Handle : TImagingHandle) : Boolean;
Var lHeader    : TRgbHeader;
    lReadCount : LongInt;
    lIO        : TIOFunctions;
Begin
  Result := False;

  If Assigned(Handle) Then
  Begin
    lIO := GetIO();

    lReadCount := lIO.Read(Handle, @lHeader, SizeOf(lHeader));
    lIO.Seek(Handle, -lReadCount, smFromCurrent);
    Result := ((lHeader.FileSig = $20000000) Or (lHeader.FileSig = $60000000)) And
              (GetInputSize(lIO, Handle) - SizeOf(lHeader) = lHeader.Width * lHeader.Height * 2);
  End;
End;

Function TRgbFileFormat.LoadData(Handle : TImagingHandle; Var Images : TDynImageDataArray;
  OnlyFirstLevel : Boolean) : Boolean;
Var lWord    : Word;
    lPixel32 : PColor32RecArray;
    lIdx     : Integer;
    lHeader  : TRgbHeader;
Begin
  Result := False;

  If Assigned(Handle) Then
  Begin
    SetLength(Images, 1);

    With GetIO() Do
    Begin
      Read(Handle, @lHeader, SizeOf(lHeader));

      NewImage(lHeader.Width, lHeader.Height, ifA8R8G8B8, Images[0]);
      With Images[0] Do
      Begin
        lPixel32 := Bits;

        For lIdx := 0 To (Size Div 4) - 1 Do
        Begin
          //RGBA4444->ARGB8888
          Read(Handle, @lWord, SizeOf(lWord));
          With lPixel32^[lIdx] Do
          Begin
            A := lWord And $F;
            R := RgbPreMult[lWord And $F000 Shr $C, A];
            G := RgbPreMult[lWord And $0F00 Shr $8, A];
            B := RgbPreMult[lWord And $00F0 Shr $4, A];
            A := RgbMap[A];
          End;
        End;
      End;
      
      Result := True;
    End;
  End;
End;

Function TRgbFileFormat.SaveData(Handle : TImagingHandle; Const Images : TDynImageDataArray;
  Index : LongInt) : Boolean;
Var lWord : Word;

    ImageToSave : TImageData;
    MustBeFreed : Boolean;
    lPixel8  : PWordArray;
    lPixel32 : PColor32RecArray;

    lIdx  : Integer;
    lInfo : TImageFormatInfo;
    lMult : Extended;
    lHeader  : TRgbHeader;
Begin
  Result := False;
  If MakeCompatible(Images[Index], ImageToSave, MustBeFreed) Then
    With GetIO(), ImageToSave Do
    Try
      lHeader.FileSig := $20000000;
      lHeader.Width   := ImageToSave.Width;
      lHeader.Height  := ImageToSave.Height;
      Write(Handle, @lHeader, SizeOf(lHeader));

      lInfo := GetFormatInfo(ImageToSave.Format);
      If lInfo.Format = ifA4R4G4B4 Then
      Begin
        lPixel8 := Bits;

        For lIdx := 0 To (Size Div lInfo.BytesPerPixel) - 1 Do
        Begin
          lWord := lPixel8^[lIdx] And $F000 Shr $C Or
                   lPixel8^[lIdx] And $0FFF Shl $4;
          Write(Handle, @lWord, SizeOf(lWord));
        End;
      End
      Else If lInfo.Format = ifA8R8G8B8 Then
      Begin
        lPixel32 := Bits;

        For lIdx := 0 To (Size Div lInfo.BytesPerPixel) - 1 Do
        Begin
          If lPixel32^[lIdx].A > 0 Then
          Begin
            lMult := lPixel32^[lIdx].A / $FF;
            lWord := lPixel32^[lIdx].A And $F0 Shr 4 Or
                     ClampToByte(Round(lPixel32^[lIdx].R * lMult)) And $F0 Shl 8 Or
                     ClampToByte(Round(lPixel32^[lIdx].G * lMult)) And $F0 Shl 4 Or
                     ClampToByte(Round(lPixel32^[lIdx].B * lMult)) And $F0;
          End
          Else
            lWord := 0;

          Write(Handle, @lWord, SizeOf(lWord));
        End;
      End;

      Result := True;

      Finally
        If MustBeFreed Then
          FreeImage(ImageToSave);
    End
  Else If MustBeFreed Then
    FreeImage(ImageToSave);
End;

Procedure TRgbFileFormat.ConvertToSupported(Var Image: TImageData;
  Const Info : TImageFormatInfo);
Begin
  ConvertImage(Image, ifA8R8G8B8);
End;

(******************************************************************************)

Type
  TRgbxHeader = Packed Record
    FileSig  : Word;
    Palette  : TPalette32Size256;
    Width    : Word;
    Height   : Word;
    NbFrames : Byte;
  End;

Procedure TRgbxFileFormat.Define(); 
Begin
  FName := 'Simpson Rgb Animation';
  FFeatures := [ffLoad, ffSave, ffMultiImage];
  FSupportedFormats   := [ifIndex8, ifA4R4G4B4, ifA8R8G8B8];

  AddMasks('*.rgbx');
End;

Function TRgbxFileFormat.TestFormat(Handle : TImagingHandle) : Boolean;
Var lWord : Word;
Begin
  With GetIO Do
  Begin
    Read(Handle, @lWord, SizeOf(lWord));
    Seek(Handle, 0, smFromBeginning);
    Result := lWord = $29A;
  End;
End;

Function TRgbxFileFormat.LoadData(Handle : TImagingHandle; Var Images : TDynImageDataArray;
  OnlyFirstLevel : Boolean) : Boolean;
Var lIO : TIOFunctions;
    lBytes    : PByteArray;
    lByte     : Byte;
    lWord     : Word;
    lDWord    : DWord;
    X, lX, lY : Integer;
    lNbChange : Integer;
    lNbPixel  : Byte;
    lHeader   : TRgbxHeader;
Begin
  lIO := GetIO();

  lIO.Read(Handle, @lHeader, SizeOf(lHeader));
  If OnlyFirstLevel Then
    SetLength(Images, 1)
  Else
    SetLength(Images, lHeader.NbFrames);

  //First Frame
  NewImage(lHeader.Width, lHeader.Height, ifIndex8, Images[0]);
  Move(lHeader.Palette[0], Images[0].Palette^, SizeOf(lHeader.Palette));
  lIO.Read(Handle, Images[0].Bits, lHeader.Width * lHeader.Height);

  If Length(Images) > 1 Then
  Begin
    For X := 1 To lHeader.NbFrames - 1 Do
    Begin
{
      NewImage(lW, lH, ifIndex8, Images[X]);
      Move(lPal^, Images[X].Palette^, $400);
}
      CloneImage(Images[X-1], Images[X]);

      lBytes := Images[X].Bits;

      lIO.Read(Handle, @lByte, SizeOf(lByte));
      lIO.Read(Handle, @lWord, SizeOf(lWord));
      lNbChange := (lByte Shl $10) Or lWord;

      While lNbChange > 0 Do
      Begin
        lIO.Read(Handle, @lDWord, SizeOf(lDWord));
        lNbPixel := lDWord And $FF000000 Shr $18;
        lY := lDWord And $00FFF000 Shr $C;
        lX := lDWord And $00000FFF;

        lIO.Read(Handle, @lBytes^[lY * lHeader.Width + lX], lNbPixel);
        Dec(lNbChange);
      End;
    End;
  End;

  Result := True;
End;

Type
  TChangesRec = Record
    X : Word;
    Y : Word;
    PixelIds : TDynByteArray;
  End;
  PChangesRec = ^TChangesRec;
  TChangesRecs = Array Of TChangesRec;

Function TRgbxFileFormat.SaveData(Handle : TImagingHandle; Const Images : TDynImageDataArray;
  Index : LongInt) : Boolean;
Var lIO : TIOFunctions;

    lWord   : Word;
    lByte   : Byte;

    lImgData  : TDynImageDataArray;
    lPrevData ,
    lCurData  : PByte;

    X : Integer;
    lW, lH : Integer;

    lChanges    : TChangesRecs;
    lCurChange  : PChangesRec;
    lLastChange : Integer;
    lDWord      : DWord;
    lHeader     : TRgbxHeader;
Begin
  Try
    SetLength(lImgData, Length(Images));
    For X := 0 To Length(lImgData) Do
      CloneImage(Images[X], lImgData[X]);

    lIO := GetIO();
    MakePaletteForImages(lImgData, @lHeader.Palette[0], 256, True);
    lHeader.FileSig  := $29A;
    lHeader.Width    := lImgData[0].Width;
    lHeader.Height   := lImgData[0].Height;
    lHeader.NbFrames := Length(lImgData);

    lIO.Write(Handle, @lHeader, SizeOf(lHeader));
    lIO.Write(Handle, lImgData[0].Bits, lImgData[0].Size);

    If Length(lImgData) > 1 Then
    Begin
      For X := 1 To High(lImgData) Do
      Begin
        lPrevData := lImgData[X-1].Bits;
        lCurData  := lImgData[X].Bits;

        lLastChange := 0;
        lCurChange  := Nil;
        SetLength(lChanges, 0);

        For lH := 0 To lImgData[X].Height - 1 Do
          For lW := 0 To lImgData[X].Width - 1 Do
          Begin
            If lCurData^ <> lPrevData^ Then
            Begin
              If lLastChange <> lH * lImgData[X].Width + lW - 1 Then
              Begin
                SetLength(lChanges, Length(lChanges) + 1);
                lCurChange := @lChanges[High(lChanges)];
                lCurChange.X := lW;
                lCurChange.Y := lH;
              End
              Else
              Begin
                If Assigned(lCurChange) And (Length(lCurChange.PixelIds) > 254) Then
                Begin
                  SetLength(lChanges, Length(lChanges) + 1);
                  lCurChange := @lChanges[High(lChanges)];
                  lCurChange.X := lChanges[High(lChanges) - 1].X;
                  lCurChange.Y := lChanges[High(lChanges) - 1].Y;
                End;
              End;

              SetLength(lCurChange.PixelIds, Length(lCurChange.PixelIds) + 1);
              lCurChange.PixelIds[High(lCurChange.PixelIds)] := lCurData^;

              lLastChange := lH * lImgData[X].Width + lW;
            End;

            Inc(lCurData);
            Inc(lPrevData);
          End;

        lByte := Length(lChanges) And $FF0000 Shr $10;
        lWord := Length(lChanges) And $00FFFF;
        lIO.Write(Handle, @lByte, SizeOf(lByte));
        lIO.Write(Handle, @lWord, SizeOf(lWord));

        For lH := Low(lChanges) To High(lChanges) Do
        Begin
          lDWord := Length(lChanges[lH].PixelIds) And $FF Shl $18 Or
                    lChanges[lH].Y And $FFF Shl $C Or lChanges[lH].X And $FFF;
          lIO.Write(Handle, @lDWord, SizeOf(lDWord));
          lIO.Write(Handle, @lChanges[lH].PixelIds[0], Length(lChanges[lH].PixelIds));
        End;
      End;
    End;

    Finally
      FreeImagesInArray(lImgData);
  End;
  Result := True;
End;

Function TRgbxFileFormat.IsSupported(Const Image : TImageData) : Boolean;
Begin
  Result := (Image.Height < 4096) And (Image.Width < 4096);
End;

(******************************************************************************)

Constructor TImagingAnimation.Create(APaintBox : TPaintBox; AAnimation : TMultiImage);
Begin
  InHerited Create();

  FPaintBox := APaintBox;
  InitAnimation(AAnimation);

  FTimer := TTimer.Create(Nil);
  FTimer.Interval := 150;
  FTimer.OnTimer  := DoOnTimer;
  FTimer.Enabled  := True;

  FPaintBox.Width   := FAnimation.Width;
  FPaintBox.Height  := FAnimation.Height;
  FPaintBox.OnPaint := DoOnPaintBoxPaint;

  FCanvas := FPaintBox.Canvas;
End;

Constructor TImagingAnimation.Create(AImage : TImage; AAnimation : TMultiImage);
Begin
  InHerited Create();

  FImage := AImage;
  InitAnimation(AAnimation);

  FTimer := TTimer.Create(Nil);
  FTimer.Interval := 150;
  FTimer.OnTimer  := DoOnTimer;
  FTimer.Enabled  := True;

  FImage.Picture.Bitmap.Width  := FAnimation.Width;
  FImage.Picture.Bitmap.Height := FAnimation.Height;

  FCanvas := FImage.Picture.Bitmap.Canvas;
End;

Destructor TImagingAnimation.Destroy();
Begin
  FTimer.Free();
  FAnimation.Free();

  InHerited Destroy();
End;

Procedure TImagingAnimation.InitAnimation(Const AAnimation : TMultiImage);
Var lSrcCvs ,
    lTrgCvs : TImagingCanvas;
    lX : Integer;
Begin
  FAnimation := TMultiImage.CreateFromParams( AAnimation.Width, AAnimation.Height,
                                              AAnimation.Format, AAnimation.ImageCount);

  For lX := 0 To AAnimation.ImageCount - 1 Do
  Begin
    AAnimation.ActiveImage := lX;
    FAnimation.ActiveImage := lX;

    lSrcCvs := FindBestCanvasForImage(AAnimation).CreateForImage(AAnimation);
    lTrgCvs := FindBestCanvasForImage(FAnimation).CreateForImage(FAnimation);
    Try
      lTrgCvs.FillColor32 := FBackColor;
      lTrgCvs.FillRect(Rect(0, 0, FAnimation.Width, FAnimation.Height));
      lSrcCvs.DrawAlpha(Rect(0, 0, AAnimation.Width, AAnimation.Height), lTrgCvs, 0, 0);

      Finally
        lTrgCvs.Free();
        lSrcCvs.Free();
    End;
  End;
End;

Procedure TImagingAnimation.DoOnTimer(Sender : TObject);
Begin
  If Assigned(FAnimation) Then
  Begin
    If FAnimation.ImageCount > 1 Then
      If FAnimation.ActiveImage < FAnimation.ImageCount - 1 Then
        FAnimation.ActiveImage := FAnimation.ActiveImage + 1
      Else
        FAnimation.ActiveImage := 0;

    If Assigned(FPaintBox) Then
      FPaintBox.Repaint();
  End;
End;

Procedure TImagingAnimation.DoOnPaintBoxPaint(Sender : TObject);
Begin
  If Assigned(FAnimation) Then
    DisplayImage(FPaintBox.Canvas, 0, 0, FAnimation);
End;

(***************************************************************************** )

procedure TEcranClient2014.cmdTestClick(Sender: TObject);
Var lBCell : ITSTOBCellFileIO;
    lPath  : String;
    X : Integer;
    lW, lH  : Integer;
    lImage  : TSingleImage;
    lCvsSrc ,
    lCvsTrg : TImagingCanvas;
    lImgData : TImageData;
    lBkgColor : DWord;
begin
  FBCellAnim := TMultiImage.Create();
  lPath  := 'C:\Projects\TSTO-Hacker\Bin\Debug\';
  lBCell := TTSTOBCellFileIO.CreateBCellFile();
  Try
    lBCell.LoadFromFile(lPath + 'babybear_tap_2.bcell');
    lW := 0;
    lH := 0;

    For X := 0 To lBCell.Items.Count - 1 Do
    Begin
      If FileExists(lPath + lBCell.Items[X].RgbFileName) Then
      Begin
        lImage := TSingleImage.Create();
        Try
          lImage.LoadFromFile(lPath + lBCell.Items[X].RgbFileName);
          FBCellAnim.AddImage(lImage);

          lW := Max(lW, lImage.Width);
          lH := Max(lH, lImage.Height);

          Finally
            lImage.Free();
        End;
      End;
    End;

//    lBkgColor := $FFD4D0C8;//$FFC8D0D4;//ColorToRGB(clBtnFace);
    lBkgColor := ColorToRGB(clBtnFace);
    With TColor32Rec(lBkgColor) Do
    Begin
      A := R;
      R := B;
      B := A;
      A := $FF;
    End;
    
    For X := 0 To FBCellAnim.ImageCount - 1 Do
    Begin
      FBCellAnim.ActiveImage := X;

      NewImage(lW, lH, ifA8R8G8B8, lImgData);
      lCvsSrc := FindBestCanvasForImage(FBCellAnim).CreateForImage(FBCellAnim);
      lCvsTrg := FindBestCanvasForImage(lImgData).CreateForData(@lImgData);
      Try
        lCvsTrg.FillColor32 := lBkgColor;
        lCvsTrg.FillRect(Rect(0, 0, lW, lH));
        lCvsSrc.DrawAlpha(Rect(0, 0, FBCellAnim.Width, FBCellAnim.Height), lCvsTrg, 0, lH - FBCellAnim.Height);
        FBCellAnim[X] := lImgData;

        Finally
          lCvsTrg.Free();
          lCvsSrc.Free();
          FreeImage(lImgData);
      End;
    End;

    Finally
      lBCell := Nil;
  End;
end;

procedure TEcranClient2014.cmdTest2Click(Sender: TObject);
  Function GetAnimSize(ABsv : IBsvFileIO) : TRect;
  Var maxX, maxY,
      minX, minY : Single;
      lX, lY : Integer;
      lRect : TRect;
  Begin
    maxX := -400;
    maxY := -400;
    minX := 0;
    minY := 0;

    For lX := 0 To ABsv.Sub.Count - 1 Do
    Begin
      With ABsv.Sub[lX] Do
        For lY := 0 To SubData.Count - 1 Do
        Begin
          lRect := ABsv.Region[SubData[lY].ImageId].Rect;
          minX  := Min(SubData[lY].X, minX);
          minY  := Min(SubData[lY].Y, minY);
          maxX  := Max(SubData[lY].X + (lRect.Right - lRect.Left), maxX);
          maxY  := Max(SubData[lY].Y + (lRect.Bottom - lRect.Top), maxY);
        End;
    End;

    Result := Rect( Abs(System.Round(minX)),
                    Abs(System.Round(minY)),
                    Abs(System.Round(maxX)),
                    Abs(System.Round(maxY)) );
  End;

Var lBsv : IBsvFileIO;
    lPath : String;
    lCvsSrc : TImagingCanvas;
    lCvsTrg : TImagingCanvas;
    lImgSrc : TSingleImage;
    lImgTrg : TSingleImage;
    lSize   : TRect;

    lImgMaster : TSingleImage;
    lX, lY : Integer;
    lRgbTrg : ITSTORgbFile;
begin
  FBCellAnim := TMultiImage.Create();

  lPath  := 'C:\Projects\TSTO-Hacker\Bin\Debug\';

  lBsv := TBsvFileIO.CreateBsvFile();
  lImgMaster := TSingleImage.Create();
  Try
    lBsv.LoadFromFile(lPath + 'allseeingeye.bsv3');

    lSize := GetAnimSize(lBsv);
    lImgMaster.LoadFromFile(lPath + 'allseeingeye.rgb');
    lCvsSrc := FindBestCanvasForImage(lImgMaster).CreateForImage(lImgMaster);
    Try
      FBCellAnim.ImageCount := lBsv.Animation[0].EndFrame -
                               lBsv.Animation[0].StartFrame + 1;
      For lX := lBsv.Animation[0].StartFrame To lBsv.Animation[0].EndFrame Do
      Begin
        lImgTrg := TSingleImage.CreateFromParams(lSize.Left + lSize.Right, lSize.Top + lSize.Bottom, ifA8R8G8B8);
        lCvsTrg := FindBestCanvasForImage(lImgTrg).CreateForImage(lImgTrg);
        Try
          For lY := lBsv.Sub[lX].SubData.Count - 1 DownTo 0 Do
            With lBsv.Region[lBsv.Sub[lX].SubData[lY].ImageId] Do
              lCvsSrc.DrawAlpha(Rect, lCvsTrg,
                System.Round(lBsv.Sub[lX].SubData[lY].X + lSize.Left),
                System.Round(lBsv.Sub[lX].SubData[lY].Y + lSize.Top + lSize.Bottom)
              );

          FBCellAnim[lX - lBsv.Animation[0].StartFrame] := lImgTrg.ImageDataPointer^;

          Finally
            lCvsTrg.Free();
            lImgTrg.Free();
        End;
      End;
      FBCellAnim.SaveMultiToFile(lPath + 'allseeingeye2.png');

      Finally
        lCvsSrc.Free();
    End;
    pbTest.Repaint();

    Finally
      lBsv := Nil;
      lImgMaster.Free();
  End;
end;

procedure TEcranClient2014.tmrAniTimer(Sender: TObject);
begin
  If Assigned(FBCellAnim) Then
  Begin
    If FBCellAnim.ImageCount > 1 Then
    Begin
      If FBCellAnim.ActiveImage < FBCellAnim.ImageCount - 1 Then
        FBCellAnim.ActiveImage := FBCellAnim.ActiveImage + 1
      Else
        FBCellAnim.ActiveImage := 0;

      pbTest.Repaint();
    End;
  End;
end;

procedure TEcranClient2014.pbTestPaint(Sender: TObject);
begin
  If Assigned(FBCellAnim) Then
    DisplayImage(pbTest.Canvas, 0, 0, FBCellAnim);
end;

( *****************************************************************************)

//        S := '';
//        For X := 0 To 255 Do
//        Begin
//          S := S + '(Color : $' + IntToHex(lPal[X].Color, 8) + '), ';
//
//          If (X + 1) Mod 4 = 0 Then
//            S := S + #$D#$A;
//        End;
//        ShowMessage(S);

Initialization
  RegisterImageFileFormat(TRgbFileFormat);
  RegisterImageFileFormat(TRgbxFileFormat);
  
end.
