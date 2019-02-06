unit TSTOBsv.IO;

interface

Uses Windows, ExtCtrls, ImagingRGB, HsStreamEx, TSTOBsvIntf, TSTORgb;

Type
  IBsvImageIO = Interface(IBsvImage)
    ['{4B61686E-29A0-2112-90E4-70C55344243D}']
    Function GetRect() : TRect;

    Property Rect : TRect  Read GetRect;

  End;

  IBsvImagesIO = Interface(IBsvImages)
    ['{4B61686E-29A0-2112-BBF5-C3309CA14167}']
    Function  Get(Index : Integer) : IBsvImageIO;
    Procedure Put(Index : Integer; Const Item : IBsvImageIO);

    Function Add() : IBsvImageIO; OverLoad;
    Function Add(Const AItem : IBsvImageIO) : Integer; OverLoad;

    Procedure Assign(ASource : IInterface);

    Property Items[Index : Integer] : IBsvImageIO Read Get Write Put; Default;

  End;

  IBsvAnimationIO = Interface(IBsvAnimation)
    ['{4B61686E-29A0-2112-A8D5-278A640D622E}']
    Function GetFrames() : ITSTORgbFiles;

    Function CreateAnimation(AImage : TImage) : IImagingAnimation;

    Property Frames : ITSTORgbFiles Read GetFrames;

  End;

  IBsvAnimationsIO = Interface(IBsvAnimations)
    ['{4B61686E-29A0-2112-B978-B606CD1516C8}']
    Function  Get(Index : Integer) : IBsvAnimationIO;
    Procedure Put(Index : Integer; Const Item : IBsvAnimationIO);

    Function Add() : IBsvAnimationIO;

    Procedure Assign(ASource : IInterface);

    Property Items[Index : Integer] : IBsvAnimationIO Read Get Write Put; Default;

  End;

  IBsvFileIO = Interface(IBsvFile)
    ['{4B61686E-29A0-2112-A55C-536B8735CEA0}']
    //IBsvFile
    Function GetRegion() : IBsvImagesIO;
    Function GetAnimation() : IBsvAnimationsIO;

    Property Region    : IBsvImagesIO Read GetRegion;
    Property Animation : IBsvAnimationsIO Read GetAnimation;

    //IBsvFileIO
    Function  GetAsXml() : String;
    Procedure SetAsXml(Const AXmlString : String);

    Procedure LoadFromXml(Const AFileName : String);
    Procedure LoadFromStream(AStream : IStreamEx);
    Procedure LoadFromFile(Const AFileName : String);

    Procedure SaveToXml(Const AFileName : String);
    Procedure SaveToStream(AStream : IStreamEx);
    Procedure SaveToFile(Const AFileName : String);

    Property AsXml  : String Read GetAsXml  Write SetAsXml;

    Procedure DumpRegions(Const APath : String; Const AFileName : String = '');
    Procedure DumpTransformations(Const AAnimationIndex, AFrameIndex : Integer;
      Const APath : String; Const AFileName : String = '');

    Function GetRgbFile() : ITSTORgbFile;
    Property RgbFile : ITSTORgbFile Read GetRgbFile;

  End;

  TBsvFileIO = Class(TObject)
  Public
    Class Function CreateBsvFile() : IBsvFileIO;

  End;

implementation

Uses SysUtils, Types, Math, PngImage, Imaging, ImagingClasses, ImagingTypes,
  HsFunctionsEx, HsInterfaceEx, HsXmlDocEx,
  TSTOBsvImpl, TSTOBsv.Bin, TSTOBsv.Xml, TSTORgbTrans;

Type
  TBsvImageIO = Class(TBsvImage, IBsvImageIO)
  Protected
    Function GetRect() : TRect;

  End;

  TBsvImagesIO = Class(TBsvImages, IBsvImagesIO)
  Private
    FImages : IBsvImages;

  Protected
    Function  GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : IBsvImageIO; OverLoad;
    Procedure Put(Index : Integer; Const Item : IBsvImageIO); OverLoad;

    Function Add() : IBsvImageIO; OverLoad;
    Function Add(Const AItem : IBsvImageIO) : Integer; OverLoad;

    Procedure Assign(ASource : IInterface);

  Public
    Destructor Destroy(); OverRide;

  End;

  TBsvAnimationIO = Class(TBsvAnimation, IBsvAnimationIO)
  Private
    FBsvFile : Pointer;
    FFrames  : ITSTORgbFiles;

    Function GetBsvFile() : IBsvFileIO;

    Function GetAnimationRect() : TRect;
    Function LoadFrame(Const AIndex : Integer; Const AFrameSize : TRect) : ITSTORgbFile;

  Protected
    Function GetFrames() : ITSTORgbFiles;

    Function CreateAnimation(AImage : TImage) : IImagingAnimation;

    Property BsvFile : IBsvFileIO Read GetBsvFile;

  Public
    Constructor Create(ABsvFile : IBsvFileIO); ReIntroduce;
    Destructor Destroy(); OverRide;

  End;

  TBsvAnimationsIO = Class(TBsvAnimations, IBsvAnimationsIO)
  Private
    FBsvFileIO : Pointer;

  Protected
    Function  Get(Index : Integer) : IBsvAnimationIO; OverLoad;
    Procedure Put(Index : Integer; Const Item : IBsvAnimationIO); OverLoad;

    Function Add() : IBsvAnimationIO; OverLoad;

  Public
    Constructor Create(ABsvFile : IBsvFileIO); ReIntroduce;

  End;

  TBsvFileIOImpl = Class(TInterfacedObjectEx,
    IBsvFile, IBsvFileIO, IBinBsvFile, IXmlBsvFile)
  Private
    FRawImpl : TBsvFile;
    FBinImpl : IBinBsvFile;
    FXmlImpl : IXmlBsvFile;

    FRgbFile    : ITSTORgbFile;
    FRegions    : IBsvImagesIO;
    FAnimations : IBsvAnimationsIO;

    Function GetRawImplementor() : IBsvFile;
    Function GetIOImplementor() : TBsvFile;
    Function GetBinImplementor() : IBinBsvFile;
    Function GetXmlImplementor() : IXmlBsvFile;

  Protected
    Property RawImpl : IBsvFile    Read GetRawImplementor Implements IBsvFile;
    Property IOImpl  : TBsvFile    Read GetIOImplementor  Implements IBsvFileIO;
    Property BinImpl : IBinBsvFile Read GetBinImplementor Implements IBinBsvFile;
    Property XmlImpl : IXmlBsvFile Read GetXmlImplementor Implements IXmlBsvFile;

    Function GetIRegion() : IBsvImagesIO;
    Function GetIAnimation() : IBsvAnimationsIO;

    Function IBsvFileIO.GetRegion = GetIRegion;
    Function IBsvFileIO.GetAnimation = GetIAnimation;

    Function  GetAsXml() : String;
    Procedure SetAsXml(Const AXmlString : String);

    Procedure LoadFromXml(Const AFileName : String);
    Procedure LoadFromStream(AStream : IStreamEx);
    Procedure LoadFromFile(Const AFileName : String);

    Procedure SaveToXml(Const AFileName : String);
    Procedure SaveToStream(AStream : IStreamEx);
    Procedure SaveToFile(Const AFileName : String);

    Function GetRgbFile() : ITSTORgbFile;

    Procedure DumpRegions(Const APath : String; Const AFileName : String = '');
    Procedure DumpTransformations(Const AAnimationIndex, AFrameIndex : Integer;
      Const APath : String; Const AFileName : String = '');

  Public
    Destructor Destroy(); OverRide;

  End;

Class Function TBsvFileIO.CreateBsvFile() : IBsvFileIO;
Begin
  Result := TBsvFileIOImpl.Create();
End;

(******************************************************************************)

Function TBsvImageIO.GetRect() : TRect;
Begin
  Result := Rect(X, Y, X + Width, Y + Height);
End;

Destructor TBsvImagesIO.Destroy();
Begin
  FImages := Nil;

  InHerited Destroy();
End;

Function TBsvImagesIO.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TBsvImageIO;
End;

Function TBsvImagesIO.Get(Index : Integer) : IBsvImageIO;
Begin
  Result := InHerited Items[Index] As IBsvImageIO;
End;

Procedure TBsvImagesIO.Put(Index : Integer; Const Item : IBsvImageIO);
Begin
  InHerited Items[Index] := Item;
End;

Function TBsvImagesIO.Add() : IBsvImageIO;
Begin
  Result := InHerited Add() As IBsvImageIO;
  If Assigned(FImages) Then
    FImages.Add(Result);
End;

Function TBsvImagesIO.Add(Const AItem : IBsvImageIO) : Integer;
Begin
  Result := InHerited Add(AItem);
  If Assigned(FImages) Then
    FImages.Add(AItem);
End;

Procedure TBsvImagesIO.Assign(ASource : IInterface);
Begin
  InHerited Assign(ASource);
  Supports(ASource, IBsvImages, FImages);
End;

Constructor TBsvAnimationIO.Create(ABsvFile : IBsvFileIO);
Begin
  InHerited Create(True);

  FBsvFile := Pointer(ABsvFile);
End;

Destructor TBsvAnimationIO.Destroy();
Begin
  FFrames  := Nil;

  InHerited Destroy();
End;

Function TBsvAnimationIO.GetBsvFile() : IBsvFileIO;
Begin
  Result := IBsvFileIO(FBsvFile);
End;

Function TBsvAnimationIO.GetFrames() : ITSTORgbFiles;
Var X : Integer;
    lRect : TRect;
Begin
  If Not Assigned(FFrames) Then
  Begin
    FFrames := TTSTORgbFile.CreateRGBFileList();
    lRect := GetAnimationRect();

    For X := StartFrame To EndFrame Do
      FFrames.Add(LoadFrame(X, lRect));
  End;

  Result := FFrames;
End;

Function TBsvAnimationIO.CreateAnimation(AImage : TImage) : IImagingAnimation;
Var lMultImage : TMultiImage;
    lMem       : IMemoryStreamEx;
    X          : Integer;
    lFrames    : ITSTORgbFiles;
    lImageData : TImageData;
Begin
  lMem := TStringStreamEx.Create();
  lFrames := GetFrames();
  lMultImage := TMultiImage.Create();
  Try
    For X := 0 To lFrames.Count - 1 Do
    Begin
      lMem.Clear();
      lFrames[X].SaveRgbToStream(lMem);
      Try
        LoadImageFromMemory(lMem.Memory, lMem.Size, lImageData);
        lMultImage.AddImage(lImageData);

        Finally
          FreeImage(lImageData);
      End;
    End;

    lMultImage.Height     := lMultImage[0].Height;
    lMultImage.Width      := lMultImage[0].Width;
    lMultImage.ImageCount := lFrames.Count;
    lMultImage.Format     := lMultImage[0].Format;
    Result := TImagingAnimation.Create(AImage, lMultImage, $FF262525);

    Finally
      lMultImage.Free();
      lMem := Nil;
  End;
End;

Function TBsvAnimationIO.GetAnimationRect() : TRect;
Var minX, minY,
    maxX, maxY : Double;
    X, Y       : Integer;
    lRect      : TRect;
Begin
  maxX := -400;
  maxY := -400;
  minX := 0;
  minY := 0;

  For X := 0 To BsvFile.Sub.Count - 1 Do
  Begin
    With BsvFile.Sub[X] Do
      For Y := 0 To SubData.Count - 1 Do
      Begin
        lRect := BsvFile.Region[SubData[Y].ImageId].Rect;
        minX  := Min(SubData[Y].X, minX);
        minY  := Min(SubData[Y].Y, minY);
        maxX  := Max(SubData[Y].X + (lRect.Right-lRect.Left), maxX);
        maxY  := Max(SubData[Y].Y + (lRect.Bottom-lRect.Top), maxY);
      End;
  End;

  Result := Rect( Abs(Round(minX)),
                  Abs(Round(minY)),
                  Abs(Round(maxX)),
                  Abs(Round(maxY)));
End;

Function TBsvAnimationIO.LoadFrame(Const AIndex : Integer; Const AFrameSize : TRect) : ITSTORgbFile;
Var lX, lY : Integer;
    X      : Integer;
    lTrans : ITSTORgbTransformation;
    lRgbSrc ,
    lRgbTrg : ITSTORgbFile;
Begin
  Result := TTSTORgbFile.CreateRGBFile( AFrameSize.Left + AFrameSize.Right,
                                        AFrameSize.Top + AFrameSize.Bottom);

  lRgbSrc := BsvFile.RgbFile;
  With BsvFile.Sub[AIndex] Do
    For X := SubData.Count - 1 DownTo 0 Do
    Begin
      lX := Round(SubData[X].X + AFrameSize.Left);
      lY := Round(SubData[X].Y + AFrameSize.Top + AFrameSize.Bottom);

      lRgbTrg := TTSTORgbFile.CreateRGBFile();
      Try
        With BsvFile.Region[SubData[X].ImageId] Do
        Begin
          With Rect Do
            lRgbTrg.SetImageSize(Right-Left, Bottom-Top);
          lRgbSrc.DrawTo(0, 0, lRgbTrg, Rect);
        End;

        lTrans := TTSTORgbTransformation.CreateTransformation();
        Try
          lTrans.Transform(lRgbTrg, SubData[X]).DrawTo(lX, lY, Result);

          Finally
            lTrans := Nil;
        End;

        Finally
          lRgbTrg := Nil;
      End;
    End;
End;

Constructor TBsvAnimationsIO.Create(ABsvFile : IBsvFileIO);
Begin
  InHerited Create(True);
  FBsvFileIO := Pointer(ABsvFile);
End;

Function TBsvAnimationsIO.Get(Index : Integer) : IBsvAnimationIO;
Begin
  Result := InHerited Items[Index] As IBsvAnimationIO;
End;

Procedure TBsvAnimationsIO.Put(Index : Integer; Const Item : IBsvAnimationIO);
Begin
  InHerited Items[Index] := Item;
End;

Function TBsvAnimationsIO.Add() : IBsvAnimationIO;
Begin
  If Assigned(FBsvFileIO) Then
  Begin
    With IBsvFileIO(FBsvFileIO) Do
    Begin
      Result := TBsvAnimationIO.Create(IBsvFileIO(FBsvFileIO));
      InHerited Add(Result);
    End;
    IBsvFile(FBsvFileIO).Animation.Add(Result);
  End;
End;

Destructor TBsvFileIOImpl.Destroy();
Begin
  If Assigned(FRawImpl) Then
    FreeAndNil(FRawImpl);

  FBinImpl    := Nil; 
  FXmlImpl    := Nil; 
  FRgbFile    := Nil; 
  FRegions    := Nil; 
  FAnimations := Nil; 

  InHerited Destroy();
End;

Function TBsvFileIOImpl.GetRawImplementor() : IBsvFile;
Begin
  Result := GetIOImplementor();
End;

Function TBsvFileIOImpl.GetIOImplementor() : TBsvFile;
Begin
  If Not Assigned(FRawImpl) Then
    FRawImpl := TBsvFile.Create(Self);
  Result := FRawImpl;
End;

Function TBsvFileIOImpl.GetBinImplementor() : IBinBsvFile;
Begin
  FBinImpl := TBinBsvFile.CreateBsvFile();
  FBinImpl.Assign(Self);

  Result := FBinImpl;
End;

Function TBsvFileIOImpl.GetXmlImplementor() : IXmlBsvFile;
Begin
  FXmlImpl := TXmlBsvFile.CreateBsvFile();
  FXmlImpl.Assign(Self);

  Result := FXmlImpl;
End;

Function TBsvFileIOImpl.GetIRegion() : IBsvImagesIO;
Begin
  If Not Assigned(FRegions) Then
  Begin
    FRegions := TBsvImagesIO.Create();
    FRegions.Assign(RawImpl.Region);
  End;

  Result := FRegions;
End;

Function TBsvFileIOImpl.GetIAnimation() : IBsvAnimationsIO;
Var X : Integer;
Begin
  If Not Assigned(FAnimations) Then
  Begin
    FAnimations := TBsvAnimationsIO.Create(Self);
    For X := 0 To RawImpl.Animation.Count - 1 Do
      FAnimations.Add().Assign(RawImpl.Animation[X]);
  End;

  Result := FAnimations;
End;

Function TBsvFileIOImpl.GetAsXml() : String;
Begin
  Result := FormatXmlData(XmlImpl.Xml);
End;

Procedure TBsvFileIOImpl.SetAsXml(Const AXmlString : String);
Begin
  FXmlImpl := TXmlBsvFile.CreateBsvFile(AXmlString);
  RawImpl.Assign(FXmlImpl);
End;

Procedure TBsvFileIOImpl.LoadFromXml(Const AFileName : String);
Var lSStrm : IStringStreamEx;
Begin
  lSStrm := TStringStreamEx.Create();
  Try
    lSStrm.LoadFromFile(AFileName);
    SetAsXml(lSStrm.DataString);

    Finally
      lSStrm := Nil;
  End;
End;

Procedure TBsvFileIOImpl.LoadFromStream(AStream : IStreamEx);
Begin
  FBinImpl := TBinBsvFile.CreateBsvFile(AStream);
  RawImpl.Assign(FBinImpl);
End;

Procedure TBsvFileIOImpl.LoadFromFile(Const AFileName : String);
Var lMem : IMemoryStreamEx;
Begin
  lMem := TMemoryStreamEx.Create();
  Try
    lMem.LoadFromFile(AFileName);
    LoadFromStream(lMem);

    Finally
      lMem := Nil;
  End;
End;

Procedure TBsvFileIOImpl.SaveToXml(Const AFileName : String);
Var lSStrm : IStringStreamEx;
Begin
  lSStrm := TStringStreamEx.Create(GetAsXml());
  Try
    lSStrm.SaveToFile(AFileName);

    Finally
      lSStrm := Nil;
  End;
End;

Procedure TBsvFileIOImpl.SaveToStream(AStream : IStreamEx);
Begin
  BinImpl.SaveToStream(AStream);
End;

Procedure TBsvFileIOImpl.SaveToFile(Const AFileName : String);
Var lMem : IMemoryStreamEx;
Begin
  lMem := TMemoryStreamEx.Create();
  Try
    SaveToStream(lMem);
    lMem.SaveToFile(AFileName);

    Finally
      lMem := Nil;
  End;
End;

Function TBsvFileIOImpl.GetRgbFile() : ITSTORgbFile;
Begin
  If Not Assigned(FRgbFile) Then
    FRgbFile := TTSTORgbFile.CreateRGBFile();
  Result := FRgbFile;
End;

Procedure TBsvFileIOImpl.DumpRegions(Const APath : String; Const AFileName : String = '');
Var lFileName : String;
    lRgbTrg   : ITSTORgbFile;
    X         ,
    lPadding  : Integer;
    lRegions  : IBsvImagesIO;
Begin
  lRegions := GetIRegion();
  Try
    lPadding := Length(IntToStr(lRegions.Count));

    For X := 0 To lRegions.Count - 1 Do
    Begin
      With lRegions[X].Rect Do
        lRgbTrg := TTSTORgbFile.CreateRGBFile(
                     Right - Left, Bottom - Top
                   );
      Try
        FRgbFile.DrawTo(0, 0, lRgbTrg, lRegions[X].Rect);
        If AFileName = '' Then
          lFileName := 'R' + PushZero(IntToStr(X), lPadding) + '-' +
                       lRegions[X].ImageName + '.png'
        Else
          lFileName := ChangeFileExt(AFileName, '') + '-' +
                       PushZero(IntToStr(X), lPadding) +
                       ExtractFileExt(AFileName);

        lRgbTrg.SaveAsPng(IncludeTrailingBackslash(APath) + lFileName);

        Finally
          lRgbTrg := Nil;
      End;
    End;

    Finally
      lRegions := Nil;
  End;
End;

Procedure TBsvFileIOImpl.DumpTransformations(Const AAnimationIndex, AFrameIndex : Integer;
  Const APath : String; Const AFileName : String = '');
Var lRgbSrc   ,
    lRgbTrg   : ITSTORgbFile;
    X         : Integer;
    lSubIdx   : Integer;
    lBsvFile  : IBsvFileIO;
    lTrans    : ITSTORgbTransformation;
    lPadding  : Integer;
Begin
  lRgbSrc  := FRgbFile;
  lBsvFile := Self;
  Try
    lSubIdx := lBsvFile.Animation[AAnimationIndex].StartFrame + AFrameIndex;

    With lBsvFile, Sub[lSubIdx] Do
    Begin
      lPadding := Length(IntToStr(SubData.Count));

      For X := 0 To SubData.Count - 1 Do
      Begin
        With lBsvFile.Region[SubData[X].ImageId] Do
        Begin
          lRgbTrg := TTSTORgbFile.CreateRGBFile(
                       Rect.Right - Rect.Left, Rect.Bottom - Rect.Top
                     );
          lRgbSrc.DrawTo(0, 0, lRgbTrg, Rect);
        End;

        lTrans := TTSTORgbTransformation.CreateTransformation();
        Try
          With lTrans.Transform(lRgbTrg, SubData[X]) Do
            If AFileName = '' Then
              SaveAsPng( IncludeTrailingBackSlash(APath) +
                         'A' + IntToStr(AAnimationIndex) +
                         'F' + IntToStr(AFrameIndex) +
                         '-T' + PushZero(IntToStr(X), lPadding) + '-' +
                         Region[SubData[X].ImageId].ImageName + '.png')
            Else
              SaveAsPng( IncludeTrailingBackSlash(APath) +
                         ChangeFileExt(AFileName, '') + '-' +
                         PushZero(IntToStr(X), lPadding) +
                         ExtractFileExt(AFileName) );
          Finally
            lTrans := Nil;
        End;
      End;
    End;
    
    Finally
      lRgbSrc := Nil;
      lBsvFile := Nil;
  End;
End;

(*
Operation
Rotation
  eM11 Cosine
  eM12 Sine
  eM21 Negative sine
  eM22 Cosine
Scaling
  eM11 Horizontal scaling component
  eM12 Not used
  eM21 Not used
  eM22 Vertical Scaling Component
Shear
  eM11 Not used
  eM12 Horizontal Proportionality Constant
  eM21 Vertical Proportionality Constant
  eM22 Not used
Reflection
  eM11 Horizontal Reflection Component
  eM12 Not used
  eM21 Not used
  eM22 Vertical Reflection Component

  lCanvas := PaintBox1.Canvas;
  XForm.eM11 := -1;
  XForm.eM12 := 0;
  XForm.eM21 := 0;
  XForm.eM22 := 1;
  XForm.eDx  := ImgResource.Picture.Width;
  XForm.eDy  := ImgResource.Picture.Height;

  SetGraphicsMode(lCanvas.Handle, GM_ADVANCED);
  SetWorldTransform(lCanvas.Handle, XForm);
  lCanvas.Draw(0, 0, ImgResource.Picture.Graphic);
*)

end.
