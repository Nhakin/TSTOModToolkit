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

Initialization
  RegisterImageFileFormat(TRgbFileFormat);

end.
