unit TSTORgbTrans;

interface

Uses
  HsInterfaceEx, TSTORgb, TSTOBsvIntf;

Type
  ITSTORgbTransformation = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-AD5C-206BFEEF2940}']
    Function Transform(ASrc : ITSTORgbFile; ATrans : IBsvSubData) : ITSTORgbFile;
    
  End;

  TTSTORgbTransformation = Class(TObject)
  Public
    Class Function CreateTransformation() : ITSTORgbTransformation;

  End;

implementation

Uses
  {FastStringFuncs,} Math, GR32_Transforms, GR32;

Type
  TTSTORgbTransformationImpl = Class(TInterfacedObjectEx, ITSTORgbTransformation)
  Private
    Function CreateBitmap(ARgbFile : ITSTORgbFile) : TBitmap32;
    Function CreateRgb(ABmpFile : TBitmap32) : ITSTORgbFile;

  Protected
    Function Transform(ASrc : ITSTORgbFile; ATrans : IBsvSubData) : ITSTORgbFile;

  End;

Class Function TTSTORgbTransformation.CreateTransformation() : ITSTORgbTransformation;
Begin
  Result := TTSTORgbTransformationImpl.Create();
End;

(******************************************************************************)

Function TTSTORgbTransformationImpl.CreateBitmap(ARgbFile : ITSTORgbFile) : TBitmap32;
Var lW, lH : Integer;
    lBmpPixel : TColor32Entry;
    lMult : Double;
Begin
  Result := TBitmap32.Create();
  Result.SetSize(ARgbFile.Width, ARgbFile.Height);
  Result.DrawMode := dmOpaque;//dmBlend;
  Result.Clear(0);

  For lH := 0 To ARgbFile.Height - 1 Do
    For lW := 0 To ARgbFile.Width - 1 Do
    Begin
      If ARgbFile.PixelRec[lW, lH].Alpha > 0 Then
      Begin
        lMult := $FF / ARgbFile.PixelRec[lW, lH].Alpha;

        lBmpPixel.R := Min(Round(ARgbFile.PixelRec[lW, lH].Red * lMult), $FF);
        lBmpPixel.G := Min(Round(ARgbFile.PixelRec[lW, lH].Green * lMult), $FF);
        lBmpPixel.B := Min(Round(ARgbFile.PixelRec[lW, lH].Blue * lMult), $FF);
        lBmpPixel.A := ARgbFile.PixelRec[lW, lH].Alpha;

        Result.Pixel[lW, lH] := TColor32(lBmpPixel);
      End;
    End;
End;

Function TTSTORgbTransformationImpl.CreateRgb(ABmpFile : TBitmap32) : ITSTORgbFile;
Var lW, lH : Integer;
    lRgbPixel : TRgbAPixelRec;
    lMult : Double;
Begin
  Result := TTSTORgbFile.CreateRGBFile(ABmpFile.Width, ABmpFile.Height);

  For lH := 0 To ABmpFile.Height - 1 Do
    For lW := 0 To ABmpFile.Width - 1 Do
    Begin
      If TColor32Entry(ABmpFile.Pixel[lW, lH]).A > 0 Then
      Begin
        lMult := TColor32Entry(ABmpFile.Pixel[lW, lH]).A / $FF;

        lRgbPixel.Red   := Min(Round(TColor32Entry(ABmpFile.Pixel[lW, lH]).R * lMult), $FF);
        lRgbPixel.Green := Min(Round(TColor32Entry(ABmpFile.Pixel[lW, lH]).G * lMult), $FF);
        lRgbPixel.Blue  := Min(Round(TColor32Entry(ABmpFile.Pixel[lW, lH]).B * lMult), $FF);
        lRgbPixel.Alpha := TColor32Entry(ABmpFile.Pixel[lW, lH]).A;

        Result.PixelRec[lW, lH] := lRgbPixel;
      End;
    End;
End;

Function TTSTORgbTransformationImpl.Transform(ASrc : ITSTORgbFile; ATrans : IBsvSubData) : ITSTORgbFile;
Var lBmpSrc1 ,
    lBmpTrg1 : TBitmap32;
    lTrans   : TAffineTransformation;
    lTX, lTY : Integer;
Begin
  lBmpSrc1 := CreateBitmap(ASrc);
  lBmpTrg1 := TBitmap32.Create();
  lTrans  := TAffineTransformation.Create();
  Try
    If ATrans.XScale < 0 Then
      lTX := lBmpSrc1.Width
    Else
      lTX := 0;

    If ATrans.YScale < 0 Then
      lTY := lBmpSrc1.Height
    Else
      lTY := 0;

    lTrans.SrcRect := FloatRect(0, 0, lBmpSrc1.Width, lBmpSrc1.Height);
    lTrans.Scale(ATrans.XScale, ATrans.YScale);
    lTrans.Translate(lTX, lTY);
//    lTrans.Rotate( lBmpSrc1.Width Div 2,
//                   lBmpSrc1.Height Div 2,
//                   RadToDeg(ArcTan2(ATrans.Skew_H, ATrans.Skew_V)));
//    lTrans.Skew(ATrans.Skew_H, ATrans.Skew_V);

    With lTrans.GetTransformedBounds() Do
      lBmpTrg1.SetSize(Round(Right - Left), Round(Bottom - Top));

    lBmpTrg1.Clear(0);
    lBmpTrg1.DrawMode := dmBlend;
    lBmpTrg1.MasterAlpha := ATrans.Opacity;

    GR32_Transforms.Transform(lBmpTrg1, lBmpSrc1, lTrans);

    Result := CreateRgb(lBmpTrg1);

    Finally
      lBmpSrc1.Free();
      lBmpTrg1.Free();

      lTrans.Free();
  End;
End;

end.
