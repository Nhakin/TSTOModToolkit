unit TSTORgb;

interface

Uses Windows, SysUtils, Graphics, PngImage,
  HsInterfaceEx, HsStreamEx;

Type
  TFlipAxis = (faNone, faHorizontal, faVertical, faHorzVert);
  TRgbA4Pixels = Array Of Array Of Word;
  TRgbA8Pixels = Array Of Array Of DWord;
  TRgbAPixelRec = Packed Record
    Red   ,
    Green ,
    Blue  ,
    Alpha : Byte
  End;

  ITSTORgbFile = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-80AC-8F7294522025}']
    Function GetPicture() : TGraphic;
    Function GetWidth() : Integer;
    Function GetHeight() : Integer;

    Procedure RgbToPng(Const ARgbFileName, APngFileName : String); OverLoad;
    Procedure SaveAsPng(Const APngFileName : String);
    Procedure PngToRgb(Const APngFileName, ARgbFileName : String);

    Procedure SaveRgbToStream(AStream : IStreamEx);
    Procedure LoadRgbFromStream(AStream : IStreamEx);
    Procedure LoadRgbFromFile(Const AFileName : String);
    Procedure LoadPngImage(APngImage : TPngImage);
    Procedure LoadPngFromFile(Const AFileName : String);

    Function GetRotationSize(Const AWidth, AHeight : Integer; Const AAngle : Extended) : TSize;

    Procedure DrawTo( Const AX, AY : Integer; AImage : ITSTORgbFile; Const ARect : TRect;
                      Const AFlipAxis : TFlipAxis = faNone; Const ARotation : Extended = 0); OverLoad;
    Procedure DrawTo( Const AX, AY : Integer; AImage : ITSTORgbFile;
                      Const AFlipAxis : TFlipAxis = faNone; Const ARotation : Extended = 0); OverLoad;
    Procedure DrawFrom( Const AX, AY : Integer; AImage : ITSTORgbFile; Const ARect : TRect;
                        Const AFlipAxis : TFlipAxis = faNone; Const ARotation : Extended = 0); OverLoad;
    Procedure DrawFrom( Const AX, AY : Integer; AImage : ITSTORgbFile;
                        Const AFlipAxis : TFlipAxis = faNone; Const ARotation : Extended = 0); OverLoad;

    Procedure SetImageSize(Const AWidth : Integer = 0; Const AHeight : Integer = 0);
    Procedure Clear();
    Procedure ReleaseGraphic();
    Function  CreateBitmap() : TBitmap;

    Property Picture : TGraphic Read GetPicture;
    Property Width   : Integer  Read GetWidth;
    Property Height  : Integer  Read GetHeight;

    Function  GetPixels() : TRgbA4Pixels;
    Procedure SetPixels(Const APixels : TRgbA4Pixels);
    Property Pixels : TRgbA4Pixels Read GetPixels Write SetPixels;

    Function  GetPixelRec(Const X, Y : Integer) : TRgbAPixelRec;
    Procedure SetPixelRec(Const X, Y : Integer; APixelRec : TRgbAPixelRec);
    Property PixelRec[Const X, Y : Integer] : TRgbAPixelRec Read GetPixelRec Write SetPixelRec;

  End;

  ITSTORgbFiles = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-9C89-CE68A0D4F5AC}']
    Function  Get(Index: Integer) : ITSTORgbFile;
    Procedure Put(Index: Integer; Const Item: ITSTORgbFile);

    Function  Add() : ITSTORgbFile; OverLoad;
    Function  Add(AItem : ITSTORgbFile) : Integer; OverLoad;

    Property Items[Index : Integer] : ITSTORgbFile Read Get Write Put; Default;

  End;

  TTSTORgbFile = Class(TObject)
  Public
    Class Function CreateRGBFile(Const AWidth : Integer = 0; Const AHeight : Integer = 0) : ITSTORgbFile;
    Class Function CreateRGBFileList() : ITSTORgbFiles;

  End;

//Procedure SmoothRotate(APng: TPngImage; AAngle: Extended);

implementation

Uses Classes, Types, Math;

Function Round(Number : Double; Digits: Integer = 0) : Double;
Var RoundFact : Double;
Begin
  RoundFact := 1;

  While Digits < 0 Do
  Begin
    RoundFact := RoundFact / 10;
    Inc(Digits);
  End;

  While Digits > 0 Do
  Begin
    RoundFact := RoundFact * 10;
    Dec(Digits);
  End;

  If Number < 0 Then
    Result := Int(Number * RoundFact - 0.500000001) / RoundFact
  Else
    Result := Int(Number * RoundFact + 0.500000001) / RoundFact;
End;

Function RoundInt(Number : Double) : Integer;
Begin
  Result := Trunc(Round(Number));
End;

Function RoundMin(Const ANumber : Double; Const AMin : Integer) : Integer;
Begin
  Result := Min(RoundInt(ANumber), AMin);
End;

Const
  RgbMap : Array[0..$F] Of Byte = ( // Min(Round(X / $F * $FF), $FF)
    $00, $11, $22, $33,
    $44, $55, $66, $77,
    $88, $99, $AA, $BB,
    $CC, $DD, $EE, $FF
  );

(******************************************************************************)

Type
//  TRgbAPixels = Array Of Array Of Word;

  TTSTORgbFileImpl = Class(TInterfacedObjectEx, ITSTORgbFile)
  Private
    FFileSign    : DWord;
    FPixels      : TRgbA4Pixels;
    FPixelsDword : TRgbA8Pixels;
    FInitGraphic : Boolean;
    FGraphic     : TPngImage;

    Procedure LoadPngCanvas(APngImage : TPngImage);
    Function  RgbA4444ToRgb(Const ARgbAColor : Word) : DWord;

    Function GetRect(Const APixels : TRgbA4Pixels; Const ARect : TRect) : TRgbA4Pixels;
    Function Rotate(Const APixels : TRgbA4Pixels; AAngle : Extended) : TRgbA4Pixels;
    Function Transform(Const APixels : TRgbA4Pixels; ARect : TRect; Const AAxis : TFlipAxis) : TRgbA4Pixels;

  Protected
    Function  GetPicture() : TGraphic;
    Function  GetWidth() : Integer;
    Function  GetHeight() : Integer;
    Function  GetPixels() : TRgbA4Pixels;
    Procedure SetPixels(Const APixels : TRgbA4Pixels);
    Function  GetPixelRec(Const X, Y : Integer) : TRgbAPixelRec;
    Procedure SetPixelRec(Const X, Y : Integer; APixelRec : TRgbAPixelRec);

    Procedure SaveAsPng(Const APngFileName : String);
    Procedure RgbToPng(Const ARgbFileName, APngFileName : String); OverLoad;
    Procedure PngToRgb(Const APngFileName, ARgbFileName : String);

    Procedure SaveRgbToStream(AStream : IStreamEx; APixels : TRgbA4Pixels); OverLoad;
    Procedure SaveRgbToStream(AStream : IStreamEx); OverLoad;
    Procedure LoadRgbFromStream(AStream : IStreamEx);
    Procedure LoadRgbFromFile(Const AFileName : String);
    Procedure LoadPngImage(APngImage : TPngImage);
    Procedure LoadPngFromFile(Const AFileName : String);

    Function GetRotationSize(Const AWidth, AHeight : Integer; Const AAngle : Extended) : TSize;

    Procedure DrawTo( Const AX, AY : Integer; AImage : ITSTORgbFile; Const ARect : TRect;
                      Const AFlipAxis : TFlipAxis = faNone; Const ARotation : Extended = 0); OverLoad;
    Procedure DrawTo( Const AX, AY : Integer; AImage : ITSTORgbFile;
                      Const AFlipAxis : TFlipAxis = faNone; Const ARotation : Extended = 0); OverLoad;
    Procedure DrawFrom( Const AX, AY : Integer; AImage : ITSTORgbFile; Const ARect : TRect;
                        Const AFlipAxis : TFlipAxis = faNone; Const ARotation : Extended = 0); OverLoad;
    Procedure DrawFrom( Const AX, AY : Integer; AImage : ITSTORgbFile;
                        Const AFlipAxis : TFlipAxis = faNone; Const ARotation : Extended = 0); OverLoad;
    Procedure SetImageSize(Const AWidth : Integer = 0; Const AHeight : Integer = 0);

    Procedure Clear();
    Procedure ReleaseGraphic();
    Function  CreateBitmap() : TBitmap;

    Property Picture : TGraphic    Read GetPicture;
    Property Width   : Integer     Read GetWidth;
    Property Height  : Integer     Read GetHeight;
    Property Pixels  : TRgbA4Pixels Read GetPixels Write SetPixels;
    Property PixelRec[Const X, Y : Integer] : TRgbAPixelRec Read GetPixelRec Write SetPixelRec;

  Public
    Constructor Create(Const AWidth : Integer = 0; Const AHeight : Integer = 0); ReIntroduce;
    Destructor  Destroy(); OverRide;

  End;

  TTSTORgbFiles = Class(TInterfaceListEx, ITSTORgbFiles)
  Protected
    Function  Get(Index: Integer) : ITSTORgbFile; OverLoad;
    Procedure Put(Index: Integer; Const Item: ITSTORgbFile); OverLoad;

    Function  Add() : ITSTORgbFile; ReIntroduce; OverLoad;
    Function  Add(AItem : ITSTORgbFile) : Integer; OverLoad;

  End;

Class Function TTSTORgbFile.CreateRGBFile(Const AWidth : Integer = 0; Const AHeight : Integer = 0) : ITSTORgbFile;
Begin
  Result := TTSTORgbFileImpl.Create(AWidth, AHeight);
End;

Class Function TTSTORgbFile.CreateRGBFileList() : ITSTORgbFiles;
Begin
  Result := TTSTORgbFiles.Create();
End;

(******************************************************************************)

Constructor TTSTORgbFileImpl.Create(Const AWidth : Integer = 0; Const AHeight : Integer = 0);
Begin
  InHerited Create();

  SetImageSize(AWidth, AHeight);
End;

Destructor TTSTORgbFileImpl.Destroy();
Begin
  ReleaseGraphic();
  InHerited Destroy();
End;

Function TTSTORgbFileImpl.GetPixels() : TRgbA4Pixels;
Begin
  Result := FPixels;
End;

Procedure TTSTORgbFileImpl.SetPixels(Const APixels : TRgbA4Pixels);
Begin
  FPixels := APixels;
  ReleaseGraphic();
End;

Function TTSTORgbFileImpl.GetPixelRec(Const X, Y : Integer) : TRgbAPixelRec;
Begin
  Result.Red   := RgbMap[FPixels[Y][X] And $F000 Shr $C];
  Result.Green := RgbMap[FPixels[Y][X] And $0F00 Shr $8];
  Result.Blue  := RgbMap[FPixels[Y][X] And $00F0 Shr $4];
  Result.Alpha := RgbMap[FPixels[Y][X] And $000F];
End;

Procedure TTSTORgbFileImpl.SetPixelRec(Const X, Y : Integer; APixelRec : TRgbAPixelRec);
Var lMult : Double;
Begin
  If APixelRec.Alpha > 0 Then
  Begin
    lMult := APixelRec.Alpha / $FF;
    FPixels[Y][X] := APixelRec.Alpha And $F0 Shr 4 Or
                     RoundMin(APixelRec.Red * lMult, $FF) And $F0 Shl 8 Or
                     RoundMin(APixelRec.Green * lMult, $FF) And $F0 Shl 4 Or
                     RoundMin(APixelRec.Blue * lMult, $FF) And $F0;
  End
  Else
    FPixels[Y][X] := 0;
End;

(*
00 D0 E0 F0 RGB -> 13689072
   BB GG RR
00 00 FE DC RGBA -> 65244
00 00 RG BA
*)
Function TTSTORgbFileImpl.RgbA4444ToRgb(Const ARgbAColor : Word) : DWord;
Var lMult : Double;
Begin
  If ARgbAColor And $000F > 0 Then
  Begin
    lMult := $FF / RgbMap[ARgbAColor And $000F];

    Result := RoundMin(RgbMap[ARgbAColor And $F000 Shr $C] * lMult, $FF) Or
              RoundMin(RgbMap[ARgbAColor And $0F00 Shr $8] * lMult, $FF) Shl $8 Or
              RoundMin(RgbMap[ARgbAColor And $00F0 Shr $4] * lMult, $FF) Shl $10;
  End
  Else
    Result := 0;
End;

Procedure TTSTORgbFileImpl.LoadPngCanvas(APngImage : TPngImage);
Var X, Y : Integer;
Begin
  If FFileSign = 0 Then
    For Y := Low(FPixelsDword) To High(FPixelsDword) Do //Height
      For X := Low(FPixelsDword[Y]) To High(FPixelsDword[Y]) Do //Width
      Begin
        APngImage.Pixels[X, Y] := FPixelsDword[Y][X];
        If APngImage.Header.ColorType = COLOR_RGBALPHA Then
          APngImage.AlphaScanline[Y]^[X] := (FPixelsDword[Y][X] And $FF000000) Shr $18;
      End
  Else
    For Y := Low(FPixels) To High(FPixels) Do //Height
      For X := Low(FPixels[Y]) To High(FPixels[Y]) Do //Width
      Begin
        APngImage.Pixels[X, Y] := RgbA4444ToRgb(FPixels[Y][X]);
        If APngImage.Header.ColorType = COLOR_RGBALPHA Then
          APngImage.AlphaScanline[Y]^[X] := RgbMap[FPixels[Y][X] And $F];
      End;
End;

(*
Procedure DrawOpacityBrush(ACanvas: TCanvas; X, Y: Integer; AColor: TColor; ASize: Integer; Opacity: Byte);
Var
  Bmp: TBitmap;
  lH, lW: Integer;
  Pixels: PRGBQuad;
  ColorRgb: Integer;
  ColorR, ColorG, ColorB: Byte;
Begin
  Bmp := TBitmap.Create;
  Try
    Bmp.PixelFormat := pf32Bit; // needed for an alpha channel
    Bmp.Height := ASize;
    Bmp.Width  := ASize;

    With Bmp.Canvas Do
    Begin
      Brush.Color := clFuchsia; // background color to mask out
      ColorRgb := ColorToRGB(Brush.Color);
      FillRect(Rect(0, 0, ASize, ASize));
      Pen.Color := AColor;
      Pen.Style := psSolid;
      Pen.Width := ASize;

      Brush.Color := AColor;
    End;

    ColorR := GetRValue(ColorRgb);
    ColorG := GetGValue(ColorRgb);
    ColorB := GetBValue(ColorRgb);
    Bmp.Transparent := True;

    For lH := 0 To Bmp.Height - 1 Do
    Begin
      Pixels := PRGBQuad(Bmp.ScanLine[lH]);
      For lW := 0 To Bmp.Width - 1 Do
      Begin
        With Pixels^ Do
        Begin
          If (rgbRed = ColorR) And (rgbGreen = ColorG) And (rgbBlue = ColorB) Then
            rgbReserved := 0
          Else
            rgbReserved := Opacity;

          // must pre-multiply the pixel with its alpha channel before drawing
          rgbRed   := (rgbRed * rgbReserved) Div $FF;
          rgbGreen := (rgbGreen * rgbReserved) Div $FF;
          rgbBlue  := (rgbBlue * rgbReserved) Div $FF;
        End;
        Inc(Pixels);
      End;
    End;

    ACanvas.Draw(X, Y, Bmp);

    Finally
      Bmp.Free;
  End;
End;
*)
Function TTSTORgbFileImpl.GetPicture() : TGraphic;
Begin
  If FInitGraphic Then
  Begin
    If Assigned(FGraphic) Then
      FreeAndNil(FGraphic);

    If FFileSign = 0 Then
    Begin
      If Length(FPixelsDword) > 0 Then
      Begin
        FGraphic := TPngImage.CreateBlank(COLOR_RGBALPHA, 16, Length(FPixelsDword[0]), Length(FPixelsDword));
        LoadPngCanvas(FGraphic);
      End;
    End
    Else
    Begin
      If Length(FPixels) > 0 Then
      Begin
        FGraphic := TPngImage.CreateBlank(COLOR_RGBALPHA, 16, Length(FPixels[0]), Length(FPixels));
        LoadPngCanvas(FGraphic);
      End;
    End;

    FInitGraphic := False;
  End;

  Result := FGraphic;
End;

Function TTSTORgbFileImpl.GetWidth() : Integer;
Begin
  If Length(FPixels) > 0 Then
    Result := Length(FPixels[0])
  Else
    Result := 0;
End;

Function TTSTORgbFileImpl.GetHeight() : Integer;
Begin
  Result := Length(FPixels);
End;

Procedure TTSTORgbFileImpl.SaveAsPng(Const APngFileName : String);
Var lPng : TPngImage;
Begin
  If Length(FPixels) > 0 Then
  Begin
    lPng := TPngImage.CreateBlank(COLOR_RGBALPHA, 16, Length(FPixels[0]), Length(FPixels));
    Try
      LoadPngCanvas(lPng);
      lPng.SaveToFile(APngFileName);

      Finally
        lPng.Free();
    End;
  End;
End;

Procedure TTSTORgbFileImpl.RgbToPng(Const ARgbFileName, APngFileName : String);
Begin
  LoadRgbFromFile(ARgbFileName);
  SaveAsPng(APngFileName);
End;

Procedure TTSTORgbFileImpl.PngToRgb(Const APngFileName, ARgbFileName : String);
Var lMem : IMemoryStreamEx;
Begin
  LoadPngFromFile(APngFileName);

  lMem := TMemoryStreamEx.Create();
  Try
    SaveRgbToStream(lMem, FPixels);
    lMem.SaveToFile(ARgbFileName);

    Finally
      lMem := Nil;
  End;
End;

Procedure TTSTORgbFileImpl.SaveRgbToStream(AStream : IStreamEx; APixels : TRgbA4Pixels);
Var X, Y : Integer;
Begin
  If Length(APixels) > 0 Then
  Begin
    AStream.WriteDWord($20000000);
    AStream.WriteWord(Length(APixels[0]));
    AStream.WriteWord(Length(APixels));

    For Y := Low(APixels) To High(APixels) Do
      For X := Low(APixels[Y]) To High(APixels[Y]) Do
        AStream.WriteWord(APixels[Y][X]);
  End;
End;

Procedure TTSTORgbFileImpl.SaveRgbToStream(AStream : IStreamEx);
Begin
  SaveRgbToStream(AStream, FPixels);
End;

Procedure TTSTORgbFileImpl.LoadRgbFromStream(AStream : IStreamEx);
Var lWidth  : Word;
    lHeight : Word;
    X, Y    : Integer;
Begin
  SetLength(FPixels, 0);

  AStream.Position := 0;
  FFileSign := AStream.ReadDWord();
  If (FFileSign = $20000000) Or (FFileSign = $60000000) Then
  Begin
    lWidth  := AStream.ReadWord();
    lHeight := AStream.ReadWord();

    SetLength(FPixels, lHeight);
    For Y := 0 To lHeight - 1 Do
    Begin
      SetLength(FPixels[Y], lWidth);

      For X := 0 To lWidth - 1 Do
        FPixels[Y][X] := AStream.ReadWord();
    End;
  End
  Else If (FFileSign = $00000000) Then
  Begin
    lWidth  := AStream.ReadWord();
    lHeight := AStream.ReadWord();

    SetLength(FPixelsDword, lHeight);
    For Y := 0 To lHeight - 1 Do
    Begin
      SetLength(FPixelsDword[Y], lWidth);

      For X := 0 To lWidth - 1 Do
        FPixelsDword[Y][X] := AStream.ReadDWord();
    End;
  End
  Else
    Raise Exception.Create('Invalid signature value');

  FInitGraphic := True;
End;

Procedure TTSTORgbFileImpl.LoadRgbFromFile(Const AFileName : String);
Var lMem : IMemoryStreamEx;
Begin
  If FileExists(AFileName) Then
  Begin
    lMem := TMemoryStreamEx.Create();
    Try
      lMem.LoadFromFile(AFileName);
      LoadRgbFromStream(lMem);

      Finally
        lMem := Nil;
    End;
  End;
End;
{
  00 BB GG RR
        RG BA
}
Procedure TTSTORgbFileImpl.LoadPngImage(APngImage : TPngImage);
Var X, Y : Integer;
Begin
  FFileSign := $20000000;
  SetLength(FPixels, 0);
  SetLength(FPixels, APngImage.Height);

  For Y := 0 To APngImage.Height - 1 Do
  Begin
    SetLength(FPixels[Y], APngImage.Width);

    For X := 0 To APngImage.Width - 1 Do
    Begin
      If APngImage.Header.ColorType = COLOR_RGBALPHA Then
        FPixels[Y][X] := APngImage.AlphaScanline[Y]^[X] And $F0 Shr 4
      Else
        FPixels[Y][X] := $F;

      If FPixels[Y][X] > 0 Then
        FPixels[Y][X] := FPixels[Y][X] Or //Alpha
                         APngImage.Pixels[X, Y] And $0000F0 Shl 8 Or //Red
                         APngImage.Pixels[X, Y] And $00F000 Shr 4 Or //Green
                         APngImage.Pixels[X, Y] And $F00000 Shr 16; //Blue
    End;
  End;

  FInitGraphic := True;
End;

Procedure TTSTORgbFileImpl.LoadPngFromFile(Const AFileName : String);
Var lPng : TPngImage;
Begin
  lPng := TPngImage.Create();
  Try
    lPng.LoadFromFile(AFileName);
    LoadPngImage(lPng);

    Finally
      lPng.Free();
  End;
End;

Function TTSTORgbFileImpl.GetRect(Const APixels : TRgbA4Pixels; Const ARect : TRect) : TRgbA4Pixels;
Var lW, lH,
    lX, lY : Integer;
Begin
  lH := ARect.Bottom - ARect.Top;
  lW := ARect.Right - ARect.Left;
  SetLength(Result, lH);
  For lY := ARect.Top To ARect.Bottom - 1 Do
  Begin
    SetLength(Result[lY-ARect.Top], lW);
    For lX := ARect.Left To ARect.Right - 1 Do
      If (lY <= High(APixels)) And (lX <= High(APixels[lY])) Then
        Result[lY-ARect.Top][lX-ARect.Left] := APixels[lY][lX];
  End;
End;

Function TTSTORgbFileImpl.GetRotationSize(Const AWidth, AHeight : Integer; Const AAngle : Extended) : TSize;
  Function Min(A, B : Double): Double;
  Begin
    If A < B Then
      Result := A
    Else
      Result := B;
  End;

  Function Max(A, B : Double): Double;
  Begin
    If A > B Then
      Result := A
    Else
      Result := B;
  End;

  Function Ceil(A : Double): Integer;
  Begin
    Result := Integer(Trunc(A));
    If Frac(A) > 0 Then
      Inc(Result);
  End;

Var lRadiants : Extended;
    lCosine, lSine : Double;
    lPoint1X, lPoint1Y,
    lPoint2X, lPoint2Y,
    lPoint3X, lPoint3Y : Double;
    lMinX, lMinY,
    lMaxX, lMaxY : Double;
Begin
  {Convert degrees to radians}
  lRadiants := (2 * PI * AAngle) / 360;

  lCosine := Abs(Cos(lRadiants));
  lSine   := Abs(Sin(lRadiants));

  lPoint1X := (-AHeight * lSine);
  lPoint1Y := (AHeight * lCosine);
  lPoint2X := (AWidth * lCosine - AHeight * lSine);
  lPoint2Y := (AHeight * lCosine + AWidth * lSine);
  lPoint3X := (AWidth * lCosine);
  lPoint3Y := (AWidth * lSine);

  lMinX := Min(0, Min(lPoint1X, Min(lPoint2X, lPoint3X)));
  lMinY := Min(0, Min(lPoint1Y, Min(lPoint2Y, lPoint3Y)));
  lMaxX := Max(lPoint1X, Max(lPoint2X, lPoint3X));
  lMaxY := Max(lPoint1Y, Max(lPoint2Y, lPoint3Y));

  Result.cx := Ceil(lMaxX - lMinX);
  Result.cy := Ceil(lMaxY - lMinY);
End;

Function TTSTORgbFileImpl.Rotate(Const APixels : TRgbA4Pixels; AAngle : Extended) : TRgbA4Pixels;
  {Supporting functions}
  Function TrimInt(i, Min, Max: Integer) : Integer;
  Begin
    If i > Max Then
      Result := Max
    Else If i < Min Then
      Result := Min
    Else
      Result := i;
  End;

  Function IntToByte(i : Integer) : Byte;
  Begin
    If i > 255 Then
      Result := 255
    Else If i < 0 Then
      Result := 0
    Else
      Result := i;
  End;

  Function RgbAToRgbARec(ARgbAColor : Word) : TRgbAPixelRec;
  Begin
    Result.Red   := ARgbAColor And $F000 Shr 8;
    Result.Green := ARgbAColor And $0F00 Shr 4;
    Result.Blue  := ARgbAColor And $00F0;
    Result.Alpha := ARgbAColor And $000F Shl 4;
  End;

  Function RgbARecToRgbA(ATFColor : TRgbAPixelRec) : Word;
  Begin
    Result := Min(RoundInt(ATFColor.Alpha / $FF * $10), $F);

    If Result > 0 Then
      Result := Result Or
                Min(RoundInt(ATFColor.Red / $FF * $10), $F) Shl 12 Or
                Min(RoundInt(ATFColor.Green / $FF * $10), $F) Shl 8 Or
                Min(RoundInt(ATFColor.Blue / $FF * $10), $F) Shl 4;
  End;

Var
  Top, Bottom,
  eww, nsw,
  fx, fy : Extended;
  cAngle, sAngle : Double;
  xDiff, yDiff,
  ifx, ify,
  px, py,
  ix, iy,
  x, y,
  cx, cy : Integer;
  nw, ne,
  sw, se ,
  lNewPixel : TRgbAPixelRec;
  lH, lW : Integer;
  lRH, lRW : Integer;
Begin
  If (Length(APixels) > 0) And (Length(APixels[0]) > 0) Then
  Begin
    lH := Length(APixels);
    lW := Length(APixels[0]);

    With GetRotationSize(lW, lH, AAngle) Do
    Begin
      lRH := cy;
      lRW := cx;
    End;

    cx := lRW Div 2;
    cy := lRH Div 2;

    {Gather some variables}
    AAngle  := -AAngle * Pi / 180;
    sAngle := Sin(AAngle);
    cAngle := Cos(AAngle);
    xDiff  := (lRW - lW) Div 2;
    yDiff  := (lRH - lH) Div 2;

    SetLength(Result, lRH);
    {Iterates over each line}
    For y := 0 To lRH - 1 Do
    Begin
      py := 2 * (y - cy) + 1;

      {Iterates over each column}
      For x := 0 To lRW - 1 Do
      Begin
        SetLength(Result[Y], lRW);

        px  := 2 * (x - cx) + 1;
        fx  := (((px * cAngle - py * sAngle) - 1) / 2 + cx) - xDiff;
        fy  := (((px * sAngle + py * cAngle) - 1) / 2 + cy) - yDiff;
        ifx := System.Round(fx);
        ify := System.Round(fy);

        {Only continues if it does not exceed image boundaries}
        If (ifx > -1) And (ifx < lW) And (ify > -1) And (ify < lH) Then
        Begin
          {Obtains data to paint the new pixel}
          eww := fx - ifx;
          nsw := fy - ify;
          iy  := TrimInt(ify + 1, 0, lH - 1);
          ix  := TrimInt(ifx + 1, 0, lW - 1);

          nw := RgbAToRgbARec(APixels[ify][ifx]);
          ne := RgbAToRgbARec(APixels[ify][ix]);
          sw := RgbAToRgbARec(APixels[iy][ifx]);
          se := RgbAToRgbARec(APixels[iy][ix]);

          {Defines the new pixel}
          Top            := nw.Blue + eww * (ne.Blue - nw.Blue);
          Bottom         := sw.Blue + eww * (se.Blue - sw.Blue);
          lNewPixel.Blue := IntToByte(System.Round(Top + nsw * (Bottom - Top)));

          Top             := nw.Green + eww * (ne.Green - nw.Green);
          Bottom          := sw.Green + eww * (se.Green - sw.Green);
          lNewPixel.Green := IntToByte(System.Round(Top + nsw * (Bottom - Top)));

          Top           := nw.Red + eww * (ne.Red - nw.Red);
          Bottom        := sw.Red + eww * (se.Red - sw.Red);
          lNewPixel.Red := IntToByte(System.Round(Top + nsw * (Bottom - Top)));

          Top             := nw.Alpha + eww * (ne.Alpha - nw.Alpha);
          Bottom          := sw.Alpha + eww * (se.Alpha - sw.Alpha);
          lNewPixel.Alpha := IntToByte(System.Round(Top + nsw * (Bottom - Top)));

          Result[y][x] := RgbARecToRgbA(lNewPixel);
        End;
      End;
    End;
  End;
End;

Function TTSTORgbFileImpl.Transform(Const APixels : TRgbA4Pixels; ARect : TRect; Const AAxis : TFlipAxis) : TRgbA4Pixels;
Var lX, lY : Integer;
    lW, lH : Integer;
    lPixels : TRgbA4Pixels;
Begin
  lPixels := GetRect(APixels, ARect);

  lH := ARect.Bottom - ARect.Top;
  lW := ARect.Right - ARect.Left;

  If AAxis = faNone Then
    Result := lPixels
  Else
  Begin
    SetLength(Result, lH);
    For lY := Low(lPixels) To High(lPixels) Do
    Begin
      SetLength(Result[lY], lW);
      If AAxis = faVertical Then
        Result[lY] := lPixels[High(lPixels)-lY]
      Else
        For lX := Low(lPixels[lY]) To High(lPixels[lY]) Do
          If AAxis = faHorizontal Then
            Result[lY][lX] := lPixels[lY][High(lPixels[lY])-lX]
          Else If AAxis = faHorzVert Then
            Result[lY][lX] := lPixels[High(lPixels)-lY][High(lPixels[lY])-lX];
    End;
  End;
End;

Procedure TTSTORgbFileImpl.DrawTo( Const AX, AY : Integer; AImage : ITSTORgbFile; Const ARect : TRect;
  Const AFlipAxis : TFlipAxis = faNone; Const ARotation : Extended = 0);
Var lX, lY : Integer;
    lPixels : TRgbA4Pixels;
    lTrans  : TRgbA4Pixels;
Begin
  lPixels := TTSTORgbFileImpl(AImage.InterfaceObject).Pixels;
  If (Length(lPixels) > 0) And (Length(FPixels) > 0) Then
  Begin
    If ARotation <> 0 Then
    Begin
      lTrans := Rotate(GetRect(FPixels, ARect), ARotation);
      If (Length(lTrans) > 0) And (Length(lTrans[0]) > 0) Then
        lTrans := Transform(lTrans, Rect(0, 0, Length(lTrans[0]), Length(lTrans)), AFlipAxis);
    End
    Else
      lTrans := Transform(FPixels, ARect, AFlipAxis);

    For lY := Low(lTrans) To High(lTrans) Do
      For lX := Low(lTrans[lY]) To High(lTrans[lY]) Do
        If (AY + lY <= High(lPixels)) And (AX + lX <= High(lPixels[lY])) And
           (lTrans[lY][lX] And $F > 0) Then
          lPixels[AY + lY][AX + lX] := lTrans[lY][lX];

    TTSTORgbFileImpl(AImage.InterfaceObject).Pixels := lPixels;
  End;
End;

Procedure TTSTORgbFileImpl.DrawTo( Const AX, AY : Integer; AImage : ITSTORgbFile;
  Const AFlipAxis : TFlipAxis = faNone; Const ARotation : Extended = 0);
Begin
  DrawTo(AX, AY, AImage, Rect(0, 0, Width, Height), AFlipAxis, ARotation);
End;

Procedure TTSTORgbFileImpl.DrawFrom( Const AX, AY : Integer; AImage : ITSTORgbFile; Const ARect : TRect;
  Const AFlipAxis : TFlipAxis = faNone; Const ARotation : Extended = 0);
Var lX, lY : Integer;
    lPixels : TRgbA4Pixels;
Begin
  If Length(FPixels) > 0 Then
  Begin
    lPixels := TTSTORgbFileImpl(AImage.InterfaceObject).Pixels;

    If Length(lPixels) > 0 Then
    Begin
      lPixels := Transform(lPixels, ARect, AFlipAxis);
      For lY := Low(lPixels) To High(lPixels) Do
        For lX := Low(lPixels[lY]) To High(lPixels[lY]) Do
          If (AY + lY <= High(FPixels)) And (AX + lX <= High(FPixels[lY])) And
             (lPixels[lY][lX] And $F > 0) Then
            FPixels[AY + lY][AX + lX] := lPixels[lY][lX];
    End;
  End;
End;

Procedure TTSTORgbFileImpl.DrawFrom( Const AX, AY : Integer; AImage : ITSTORgbFile;
  Const AFlipAxis : TFlipAxis = faNone; Const ARotation : Extended = 0); 
Begin
  DrawFrom(AX, AY, AImage, Rect(0, 0, AImage.Width, AImage.Height), AFlipAxis, ARotation);
End;

Procedure TTSTORgbFileImpl.SetImageSize(Const AWidth : Integer = 0; Const AHeight : Integer = 0);
Var X, Y : Integer;
Begin
  SetLength(FPixels, 0);

  If (AWidth > 0) And (AHeight > 0) Then
  Begin
    SetLength(FPixels, AHeight);
    For Y := 0 To AHeight - 1 Do
    Begin
      SetLength(FPixels[Y], AWidth);
      For X := 0 To AWidth - 1 Do
        FPixels[Y][X] := 0;
    End;
  End;

  FInitGraphic := True;
End;

Procedure TTSTORgbFileImpl.Clear();
Begin
  SetImageSize(0, 0);
  ReleaseGraphic();
End;

Procedure TTSTORgbFileImpl.ReleaseGraphic();
Begin
  If Assigned(FGraphic) Then
    FreeAndNil(FGraphic);
  FInitGraphic := True;
End;

Function TTSTORgbFileImpl.CreateBitmap() : TBitmap;
Var lH, lW: Integer;
//    Pixels: PRGBQuad;
Begin
  Result := TBitmap.Create();
  Result.PixelFormat := pf8Bit;//pf32Bit; // needed for an alpha channel
  Result.Height := Height;
  Result.Width  := Width;
  Result.Transparent := True;

  Result.Canvas.Brush.Color := clFuchsia;
  Result.Canvas.FillRect(Rect(0, 0, Width, Height));

  For lH := 0 To Result.Height - 1 Do
  Begin
//    Pixels := PRGBQuad(Result.ScanLine[lH]);
    For lW := 0 To Result.Width - 1 Do
    Begin
      With PixelRec[lW, lH] Do
        If Alpha > 0 Then
          Result.Canvas.Pixels[lW, lH] := RgbA4444ToRgb(Pixels[lH][lW]);
//      With Pixels^, PixelRec[lW, lH] Do
//      Begin
//        If Alpha > 0 Then
//        Begin
//          rgbReserved := Alpha;
//          // must pre-multiply the pixel with its alpha channel before drawing
//          rgbRed      := (Red * Alpha) Div $FF;
//          rgbGreen    := (Green * Alpha) Div $FF;
//          rgbBlue     := (Blue * Alpha) Div $FF;
//        End;
//      End;

//      Inc(Pixels);
    End;
  End;
End;

Function TTSTORgbFiles.Get(Index: Integer) : ITSTORgbFile;
Begin
  Result := InHerited Items[Index] As ITSTORgbFile;
End;

Procedure TTSTORgbFiles.Put(Index: Integer; Const Item: ITSTORgbFile);
Begin
  InHerited Items[Index] := Item;
End;

Function TTSTORgbFiles.Add() : ITSTORgbFile;
Begin
  Result := TTSTORgbFile.CreateRGBFile();
  InHerited Add(Result);
End;

Function TTSTORgbFiles.Add(AItem : ITSTORgbFile) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

(*
by Gustavo Daud (Submited on 21 May 2006 )
Use this method to rotate RGB and RGB Alpha 'Portable Network Graphics' Images
using a smooth antialiased algorithm in order to get much better results.
Note: Part of this code was based on JansFreeware code [http://jansfreeware.com/]
This is only possible when using the 1.56 library version.
*)
Procedure SmoothRotate(APng : TPngImage; AAngle : Extended);

  {Supporting functions}
  Function TrimInt(i, Min, Max: Integer) : Integer;
  Begin
    If i > Max Then
      Result := Max
    Else If i < Min Then
      Result := Min
    Else
      Result := i;
  End;

  Function IntToByte(i : Integer) : Byte;
  Begin
    If i > 255 Then
      Result := 255
    Else If i < 0 Then
      Result := 0
    Else
      Result := i;
  End;

  Function Min(A, B : Double): Double;
  Begin
    If A < B Then
      Result := A
    Else
      Result := B;
  End;

  Function Max(A, B : Double): Double;
  Begin
    If A > B Then
      Result := A
    Else
      Result := B;
  End;

  Function Ceil(A : Double): Integer;
  Begin
    Result := Integer(Trunc(A));
    If Frac(A) > 0 Then
      Inc(Result);
  End;

  {Calculates the png new size}
  Function NewSize() : TSize;
  Var lRadiants : Extended;
      lCosine, lSine : Double;
      lPoint1X, lPoint1Y,
      lPoint2X, lPoint2Y,
      lPoint3X, lPoint3Y : Double;
      lMinX, lMinY,
      lMaxX, lMaxY : Double;
  Begin
    {Convert degrees to radians}
    lRadiants := (2 * PI * AAngle) / 360;

    lCosine := Abs(Cos(lRadiants));
    lSine   := Abs(Sin(lRadiants));

    lPoint1X := (-APng.Height * lSine);
    lPoint1Y := (APng.Height * lCosine);
    lPoint2X := (APng.Width * lCosine - APng.Height * lSine);
    lPoint2Y := (APng.Height * lCosine + APng.Width * lSine);
    lPoint3X := (APng.Width * lCosine);
    lPoint3Y := (APng.Width * lSine);

    lMinX := Min(0, Min(lPoint1X, Min(lPoint2X, lPoint3X)));
    lMinY := Min(0, Min(lPoint1Y, Min(lPoint2Y, lPoint3Y)));
    lMaxX := Max(lPoint1X, Max(lPoint2X, lPoint3X));
    lMaxY := Max(lPoint1Y, Max(lPoint2Y, lPoint3Y));

    Result.cx := Ceil(lMaxX - lMinX);
    Result.cy := Ceil(lMaxY - lMinY);
  End;

Type
  TFColor  = Record
    b ,
    g ,
    r : Byte
  End;

Var
  Top, Bottom,
  eww, nsw,
  fx, fy,
  wx, wy : Extended;
  cAngle, sAngle : Double;
  xDiff, yDiff,
  ifx, ify,
  px, py,
  ix, iy,
  x, y,
  cx, cy : Integer;
  nw, ne,
  sw, se : TFColor;
  anw, ane,
  asw, ase : Byte;
  P1, P2, P3 : pByteArray;
  A1, A2, A3 : pByteArray;
  lResult : TPNGImage;
  IsAlpha : Boolean;
Begin
  {Only allows RGB and RGBALPHA images}
  If Not (APng.Header.ColorType In [COLOR_RGBALPHA, COLOR_RGB]) Then
    Raise Exception.Create( 'Only COLOR_RGBALPHA and COLOR_RGB formats' +
                            ' are supported');
  {Creates a copy}
  With NewSize() Do
    lResult := TPngImage.CreateBlank(APng.Header.ColorType, 8, cx, cy);

  IsAlpha := APng.Header.ColorType In [COLOR_RGBALPHA];

  cx := lResult.Width Div 2;
  cy := lResult.Height Div 2;

  {Gather some variables}
  AAngle  := -AAngle * Pi / 180;
  sAngle := Sin(AAngle);
  cAngle := Cos(AAngle);
  xDiff  := (lResult.Width - APng.Width) Div 2;
  yDiff  := (lResult.Height - APng.Height) Div 2;

  {Iterates over each line}
  For y := 0 To lResult.Height - 1 Do
  Begin
    P3 := lResult.Scanline[y];
    If IsAlpha Then
      A3 := lResult.AlphaScanline[y];
    py := 2 * (y - cy) + 1;

    {Iterates over each column}
    For x := 0 To lResult.Width - 1 Do
    Begin
      px  := 2 * (x - cx) + 1;
      fx  := (((px * cAngle - py * sAngle) - 1) / 2 + cx) - xDiff;
      fy  := (((px * sAngle + py * cAngle) - 1) / 2 + cy) - yDiff;
      ifx := System.Round(fx);
      ify := System.Round(fy);

      {Only continues if it does not exceed image boundaries}
      If (ifx > -1) And (ifx < APng.Width) And (ify > -1) And (ify < APng.Height) Then
      Begin
        {Obtains data to paint the new pixel}
        eww := fx - ifx;
        nsw := fy - ify;
        iy  := TrimInt(ify + 1, 0, APng.Height - 1);
        ix  := TrimInt(ifx + 1, 0, APng.Width - 1);

        If IsAlpha Then
        Begin
          A1 := APng.AlphaScanline[ify];
          A2 := APng.AlphaScanline[iy];
        End;

        P1   := APng.Scanline[ify];
        nw.r := P1[ifx * 3];
        nw.g := P1[ifx * 3 + 1];
        nw.b := P1[ifx * 3 + 2];
        If IsAlpha Then
          anw := A1[ifx];

        ne.r := P1[ix * 3];
        ne.g := P1[ix * 3 + 1];
        ne.b := P1[ix * 3 + 2];
        If IsAlpha Then
          ane := A1[ix];

        P2   := APng.Scanline[iy];
        sw.r := P2[ifx * 3];
        sw.g := P2[ifx * 3 + 1];
        sw.b := P2[ifx * 3 + 2];
        If IsAlpha Then
          asw := A2[ifx];

        se.r := P2[ix * 3];
        se.g := P2[ix * 3 + 1];
        se.b := P2[ix * 3 + 2];
        If IsAlpha Then
          ase := A2[ix];

        {Defines the new pixel}
        Top           := nw.b + eww * (ne.b - nw.b);
        Bottom        := sw.b + eww * (se.b - sw.b);
        P3[x * 3 + 2] := IntToByte(System.Round(Top + nsw * (Bottom - Top)));

        Top           := nw.g + eww * (ne.g - nw.g);
        Bottom        := sw.g + eww * (se.g - sw.g);
        P3[x * 3 + 1] := IntToByte(System.Round(Top + nsw * (Bottom - Top)));

        Top           := nw.r + eww * (ne.r - nw.r);
        Bottom        := sw.r + eww * (se.r - sw.r);
        P3[x * 3]     := IntToByte(System.Round(Top + nsw * (Bottom - Top)));

        {Only for alpha}
        If IsAlpha Then
        Begin
          Top    := anw + eww * (ane - anw);
          Bottom := asw + eww * (ase - asw);
          A3[x]  := IntToByte(System.Round(Top + nsw * (Bottom - Top)));
        End;
      End;
    End;
  End;

  APng.Assign(lResult);
  lResult.Free();
End;

end.
