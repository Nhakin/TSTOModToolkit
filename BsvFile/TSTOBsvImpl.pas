unit TSTOBsvImpl;

interface

Uses Windows, HsInterfaceEx, TSTOBsvIntf;

Type
  TBsvAnimation = Class(TInterfacedObjectEx, IBsvAnimation)
  Private
    FAnimationName : AnsiString;
    FStartFrame    : Word;
    FEndFrame      : Word;

  Protected
    Function  GetAnimationName() : AnsiString;
    Procedure SetAnimationName(Const AAnimationName : AnsiString);

    Function  GetStartFrame() : Word;
    Procedure SetStartFrame(Const AStartFrame : Word);

    Function  GetEndFrame() : Word;
    Procedure SetEndFrame(Const AEndFrame : Word);

    Procedure Clear();

    Procedure Assign(ASource : IInterface);

    Property AnimationName : AnsiString Read GetAnimationName Write SetAnimationName;
    Property StartFrame    : Word   Read GetStartFrame    Write SetStartFrame;
    Property EndFrame      : Word   Read GetEndFrame      Write SetEndFrame;

  End;

  TBsvAnimations = Class(TInterfaceListEx, IBsvAnimations)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : IBsvAnimation; OverLoad;
    Procedure Put(Index : Integer; Const Item : IBsvAnimation); OverLoad;

    Function Add() : IBsvAnimation; ReIntroduce; OverLoad;
    Function Add(Const AItem : IBsvAnimation) : Integer; OverLoad;

    Procedure Assign(ASource : IInterface);

  End;

  TBsvSubData = Class(TInterfacedObjectEx, IBsvSubData)
  Private
    FImageId : Word;
    FX       : Single;
    FY       : Single;
    FXScale  : Single;
    FSkew_H  : Single;
    FSkew_V  : Single;
    FYScale  : Single;
    FOpacity : Byte;

  Protected
    Function  GetImageId() : Word;
    Procedure SetImageId(Const AImageId : Word);

    Function  GetX() : Single;
    Procedure SetX(Const AX : Single);

    Function  GetY() : Single;
    Procedure SetY(Const AY : Single);

    Function  GetXScale() : Single;
    Procedure SetXScale(Const AXScale : Single);

    Function  GetSkew_H() : Single;
    Procedure SetSkew_H(Const ASkew_H : Single);

    Function  GetSkew_V() : Single;
    Procedure SetSkew_V(Const ASkew_V : Single);

    Function  GetYScale() : Single;
    Procedure SetYScale(Const AYScale : Single);

    Function  GetOpacity() : Byte;
    Procedure SetOpacity(Const AOpacity : Byte);

    Procedure Clear();

    Procedure Assign(ASource : IInterface);

    Property ImageId : Word   Read GetImageId Write SetImageId;
    Property X       : Single Read GetX       Write SetX;
    Property Y       : Single Read GetY       Write SetY;
    Property XScale  : Single Read GetXScale  Write SetXScale;
    Property Skew_H  : Single Read GetSkew_H  Write SetSkew_H;
    Property Skew_V  : Single Read GetSkew_V  Write SetSkew_V;
    Property YScale  : Single Read GetYScale  Write SetYScale;
    Property Opacity : Byte   Read GetOpacity Write SetOpacity;

  End;

  TBsvSubDatas = Class(TInterfaceListEx, IBsvSubDatas)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : IBsvSubData; OverLoad;
    Procedure Put(Index : Integer; Const Item : IBsvSubData); OverLoad;

    Function Add() : IBsvSubData; ReIntroduce; OverLoad;
    Function Add(Const AItem : IBsvSubData) : Integer; OverLoad;

    Procedure Assign(ASource : IInterface);

  End;

  TBsvSubDatasClass = Class Of TBsvSubDatas;
  TBsvSub = Class(TInterfacedObjectEx, IBsvSub)
  Private
    FSubLen   : Byte;
    FSubData  : IBsvSubDatas;

  Protected
    Procedure Created(); OverRide;

    Function GetSubDataClass() : TBsvSubDatasClass; Virtual;

    Function  GetSubCount() : Word;

    Function  GetSubLen() : Byte;
    Procedure SetSubLen(Const ASubLen : Byte);

    Function  GetSubData() : IBsvSubDatas;

    Procedure Clear();

    Procedure Assign(ASource : IInterface); 

    Property SubCount : Word         Read GetSubCount;
    Property SubLen   : Byte         Read GetSubLen   Write SetSubLen;
    Property SubData  : IBsvSubDatas Read GetSubData;

  Public
    Destructor Destroy(); OverRide;

  End;

  TBsvSubs = Class(TInterfaceListEx, IBsvSubs)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : IBsvSub; OverLoad;
    Procedure Put(Index : Integer; Const Item : IBsvSub); OverLoad;

    Function Add() : IBsvSub; ReIntroduce; OverLoad;
    Function Add(Const AItem : IBsvSub) : Integer; OverLoad;

    Procedure Assign(ASource : IInterface);

  End;

  TBsvImage = Class(TInterfacedObjectEx, IBsvImage)
  Private
    FImageName : AnsiString;
    FX         : Word;
    FY         : Word;
    FWidth     : Word;
    FHeight    : Word;

  Protected
    Function  GetImageName() : AnsiString;
    Procedure SetImageName(Const AImageName : AnsiString);

    Function  GetX() : Word;
    Procedure SetX(Const AX : Word);

    Function  GetY() : Word;
    Procedure SetY(Const AY : Word);

    Function  GetWidth() : Word;
    Procedure SetWidth(Const AWidth : Word);

    Function  GetHeight() : Word;
    Procedure SetHeight(Const AHeight : Word);
    
    Procedure Clear();

    Procedure Assign(ASource : IInterface); 

    Property ImageName : AnsiString Read GetImageName Write SetImageName;
    Property X         : Word   Read GetX         Write SetX;
    Property Y         : Word   Read GetY         Write SetY;
    Property Width     : Word   Read GetWidth     Write SetWidth;
    Property Height    : Word   Read GetHeight    Write SetHeight;

  End;

  TBsvImages = Class(TInterfaceListEx, IBsvImages)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : IBsvImage; OverLoad;
    Procedure Put(Index : Integer; Const Item : IBsvImage); OverLoad;

    Function Add() : IBsvImage; ReIntroduce; OverLoad;
    Function Add(Const AItem : IBsvImage) : Integer; OverLoad;

    Procedure Assign(ASource : IInterface);

  End;

  TBsvImagesClass = Class Of TBsvImages;
  TBsvSubsClass = Class Of TBsvSubs;
  TBsvAnimationsClass = Class Of TBsvAnimations;

  TBsvFile = Class(TInterfacedObjectEx, IBsvFile)
  Private
    FFileSig     : Word;
    FHasOpacity  : Byte;
    FRgbFileName : AnsiString;
    FRegion      : IBsvImages;
    FSub         : IBsvSubs;
    FAnimation   : IBsvAnimations;

  Protected
    Procedure Created(); OverRide;

    Function GetImagesClass() : TBsvImagesClass; Virtual;
    Function GetSubsClass() : TBsvSubsClass; Virtual;
    Function GetAnimationsClass() : TBsvAnimationsClass; Virtual;

    Function  GetFileSig() : Word;
    Procedure SetFileSig(Const AFileSig : Word);

    Function  GetRegionCount() : Word;

    Function  GetHasOpacity() : Byte;
    Procedure SetHasOpacity(Const AHasOpacity : Byte);

    Function  GetRgbFileName() : AnsiString;
    Procedure SetRgbFileName(Const ARgbFileName : AnsiString);

    Function  GetRegion() : IBsvImages;

    Function  GetTransformationCount() : Word;

    Function  GetSub() : IBsvSubs;

    Function  GetAnimationCount() : Word;

    Function  GetAnimation() : IBsvAnimations;

    Procedure Clear();

    Procedure Assign(ASource : IInterface); 

    Property FileSig             : Word           Read GetFileSig             Write SetFileSig;
    Property RegionCount         : Word           Read GetRegionCount;
    Property HasOpacity          : Byte           Read GetHasOpacity          Write SetHasOpacity;
    Property RgbFileName         : AnsiString         Read GetRgbFileName         Write SetRgbFileName;
    Property Region              : IBsvImages     Read GetRegion;
    Property TransformationCount : Word           Read GetTransformationCount;
    Property Sub                 : IBsvSubs       Read GetSub;
    Property AnimationCount      : Word           Read GetAnimationCount;
    Property Animation           : IBsvAnimations Read GetAnimation;

  Public
    Destructor Destroy(); OverRide;

  End;

implementation

Uses SysUtils, RTLConsts;

Procedure TBsvFile.Created();
Begin
  InHerited Created();

  Clear();
End;

Destructor TBsvFile.Destroy();
Begin
  FRegion := Nil;
  FSub := Nil;
  FAnimation := Nil;

  InHerited Destroy();
End;


Function TBsvFile.GetImagesClass() : TBsvImagesClass;
Begin
  Result := TBsvImages;
End;

Function TBsvFile.GetSubsClass() : TBsvSubsClass;
Begin
  Result := TBsvSubs;
End;

Function TBsvFile.GetAnimationsClass() : TBsvAnimationsClass;
Begin
  Result := TBsvAnimations;
End;

Procedure TBsvFile.Clear();
Begin
  FFileSig             := 0;
  FHasOpacity          := 0;
  FRgbFileName         := '';

  FRegion    := GetImagesClass().Create();
  FSub       := GetSubsClass().Create();
  FAnimation := GetAnimationsClass().Create();
End;

Procedure TBsvFile.Assign(ASource : IInterface);
Var lSrc : IBsvFile;
Begin
  If Supports(ASource, IBsvFile, lSrc) Then
  Begin
    FFileSig     := lSrc.FileSig;
    FHasOpacity  := lSrc.HasOpacity;
    FRgbFileName := lSrc.RgbFileName;

    FRegion.Assign(lSrc.Region);
    FSub.Assign(lSrc.Sub);
    FAnimation.Assign(lSrc.Animation);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TBsvFile.GetFileSig() : Word;
Begin
  Result := FFileSig;
End;

Procedure TBsvFile.SetFileSig(Const AFileSig : Word);
Begin
  FFileSig := AFileSig;
End;

Function TBsvFile.GetRegionCount() : Word;
Begin
  Result := FRegion.Count;
End;

Function TBsvFile.GetHasOpacity() : Byte;
Begin
  Result := FHasOpacity;
End;

Procedure TBsvFile.SetHasOpacity(Const AHasOpacity : Byte);
Begin
  FHasOpacity := AHasOpacity;
End;

Function TBsvFile.GetRgbFileName() : AnsiString;
Begin
  Result := FRgbFileName;
End;

Procedure TBsvFile.SetRgbFileName(Const ARgbFileName : AnsiString);
Begin
  FRgbFileName := ARgbFileName;
End;

Function TBsvFile.GetRegion() : IBsvImages;
Begin
  Result := FRegion;
End;

Function TBsvFile.GetTransformationCount() : Word;
Begin
  Result := FSub.Count;
End;

Function TBsvFile.GetSub() : IBsvSubs;
Begin
  Result := FSub;
End;

Function TBsvFile.GetAnimationCount() : Word;
Begin
  Result := FAnimation.Count;
End;

Function TBsvFile.GetAnimation() : IBsvAnimations;
Begin
  Result := FAnimation;
End;

Procedure TBsvAnimation.Clear();
Begin
  FAnimationName := '';
  FStartFrame    := 0;
  FEndFrame      := 0;
End;

Procedure TBsvAnimation.Assign(ASource : IInterface);
Var lSrc : IBsvAnimation;
Begin
  If Supports(ASource, IBsvAnimation, lSrc)Then
  Begin
    FAnimationName := lSrc.AnimationName;
    FStartFrame    := lSrc.StartFrame;
    FEndFrame      := lSrc.EndFrame;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TBsvAnimation.GetAnimationName() : AnsiString;
Begin
  Result := FAnimationName;
End;

Procedure TBsvAnimation.SetAnimationName(Const AAnimationName : AnsiString);
Begin
  FAnimationName := AAnimationName;
End;

Function TBsvAnimation.GetStartFrame() : Word;
Begin
  Result := FStartFrame;
End;

Procedure TBsvAnimation.SetStartFrame(Const AStartFrame : Word);
Begin
  FStartFrame := AStartFrame;
End;

Function TBsvAnimation.GetEndFrame() : Word;
Begin
  Result := FEndFrame;
End;

Procedure TBsvAnimation.SetEndFrame(Const AEndFrame : Word);
Begin
  FEndFrame := AEndFrame;
End;

Function TBsvAnimations.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TBsvAnimation;
End;

Function TBsvAnimations.Get(Index : Integer) : IBsvAnimation;
Begin
  Result := InHerited Items[Index] As IBsvAnimation;
End;

Procedure TBsvAnimations.Put(Index : Integer; Const Item : IBsvAnimation);
Begin
  InHerited Items[Index] := Item;
End;

Function TBsvAnimations.Add() : IBsvAnimation;
Begin
  Result := InHerited Add() As IBsvAnimation;
End;

Function TBsvAnimations.Add(Const AItem : IBsvAnimation) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Procedure TBsvAnimations.Assign(ASource : IInterface);
Var lSrc : IBsvAnimations;
    X : Integer;
Begin
  If Supports(ASource, IBsvAnimations, lSrc)Then
  Begin
    If Not IsImplementorOf(lSrc) Then
    Begin
      Clear();
      For X := 0 To lSrc.Count - 1 Do
        Add().Assign(lSrc[X]);
    End;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Procedure TBsvSubData.Clear();
Begin
  FImageId := 0;
  FX       := 0;
  FY       := 0;
  FXScale  := 0;
  FSkew_H  := 0;
  FSkew_V  := 0;
  FYScale  := 0;
  FOpacity := 0;
End;

Procedure TBsvSubData.Assign(ASource : IInterface);
Var lSrc : IBsvSubData;
Begin
  If Supports(ASource, IBsvSubData, lSrc) Then
  Begin
    FImageId := lSrc.ImageId;
    FX       := lSrc.X;
    FY       := lSrc.Y;
    FXScale  := lSrc.XScale;
    FSkew_H  := lSrc.Skew_H;
    FSkew_V  := lSrc.Skew_V;
    FYScale  := lSrc.YScale;
    FOpacity := lSrc.Opacity;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TBsvSubData.GetImageId() : Word;
Begin
  Result := FImageId;
End;

Procedure TBsvSubData.SetImageId(Const AImageId : Word);
Begin
  FImageId := AImageId;
End;

Function TBsvSubData.GetX() : Single;
Begin
  Result := FX;
End;

Procedure TBsvSubData.SetX(Const AX : Single);
Begin
  FX := AX;
End;

Function TBsvSubData.GetY() : Single;
Begin
  Result := FY;
End;

Procedure TBsvSubData.SetY(Const AY : Single);
Begin
  FY := AY;
End;

Function TBsvSubData.GetXScale() : Single;
Begin
  Result := FXScale;
End;

Procedure TBsvSubData.SetXScale(Const AXScale : Single);
Begin
  FXScale := AXScale;
End;

Function TBsvSubData.GetSkew_H() : Single;
Begin
  Result := FSkew_H;
End;

Procedure TBsvSubData.SetSkew_H(Const ASkew_H : Single);
Begin
  FSkew_H := ASkew_H;
End;

Function TBsvSubData.GetSkew_V() : Single;
Begin
  Result := FSkew_V;
End;

Procedure TBsvSubData.SetSkew_V(Const ASkew_V : Single);
Begin
  FSkew_V := ASkew_V;
End;

Function TBsvSubData.GetYScale() : Single;
Begin
  Result := FYScale;
End;

Procedure TBsvSubData.SetYScale(Const AYScale : Single);
Begin
  FYScale := AYScale;
End;

Function TBsvSubData.GetOpacity() : Byte;
Begin
  Result := FOpacity;
End;

Procedure TBsvSubData.SetOpacity(Const AOpacity : Byte);
Begin
  FOpacity := AOpacity;
End;

Function TBsvSubDatas.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TBsvSubData;
End;

Function TBsvSubDatas.Get(Index : Integer) : IBsvSubData;
Begin
  Result := InHerited Items[Index] As IBsvSubData;
End;

Procedure TBsvSubDatas.Put(Index : Integer; Const Item : IBsvSubData);
Begin
  InHerited Items[Index] := Item;
End;

Function TBsvSubDatas.Add() : IBsvSubData;
Begin
  Result := InHerited Add() As IBsvSubData;
End;

Function TBsvSubDatas.Add(Const AItem : IBsvSubData) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Procedure TBsvSubDatas.Assign(ASource : IInterface);
Var lSrc : IBsvSubDatas;
    X : Integer;
Begin
  If Supports(ASource, IBsvSubDatas, lSrc)Then
  Begin
    If Not IsImplementorOf(lSrc) Then
    Begin
      Clear();
      For X := 0 To lSrc.Count - 1 Do
        Add().Assign(lSrc[X]);
    End;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Procedure TBsvSub.Created();
Begin
  InHerited Created();

  Clear();
End;

Destructor TBsvSub.Destroy();
Begin
  FSubData := Nil;

  InHerited Destroy();
End;

Function TBsvSub.GetSubDataClass() : TBsvSubDatasClass;
Begin
  Result := TBsvSubDatas;
End;

Procedure TBsvSub.Clear();
Begin
  FSubLen  := 0;
  FSubData := GetSubDataClass().Create();
End;

Procedure TBsvSub.Assign(ASource : IInterface);
Var lSrc : IBsvSub;
Begin
  If Supports(ASource, IBsvSub, lSrc) Then
  Begin
    FSubLen   := lSrc.SubLen;
    FSubData.Assign(lSrc.SubData);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TBsvSub.GetSubCount() : Word;
Begin
  Result := SubData.Count;
End;

Function TBsvSub.GetSubLen() : Byte;
Begin
  Result := FSubLen;
End;

Procedure TBsvSub.SetSubLen(Const ASubLen : Byte);
Begin
  FSubLen := ASubLen;
End;

Function TBsvSub.GetSubData() : IBsvSubDatas;
Begin
  Result := FSubData;
End;

Function TBsvSubs.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TBsvSub;
End;

Function TBsvSubs.Get(Index : Integer) : IBsvSub;
Begin
  Result := InHerited Items[Index] As IBsvSub;
End;

Procedure TBsvSubs.Put(Index : Integer; Const Item : IBsvSub);
Begin
  InHerited Items[Index] := Item;
End;

Function TBsvSubs.Add() : IBsvSub;
Begin
  Result := InHerited Add() As IBsvSub;
End;

Function TBsvSubs.Add(Const AItem : IBsvSub) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Procedure TBsvSubs.Assign(ASource : IInterface);
Var lSrc : IBsvSubs;
    X : Integer;
Begin
  If Supports(ASource, IBsvSubs, lSrc)Then
  Begin
    If Not IsImplementorOf(lSrc) Then
    Begin
      Clear();
      For X := 0 To lSrc.Count - 1 Do
        Add().Assign(lSrc[X]);
    End;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Procedure TBsvImage.Clear();
Begin
  FImageName := '';
  FX         := 0;
  FY         := 0;
  FWidth     := 0;
  FHeight    := 0;
End;

Procedure TBsvImage.Assign(ASource : IInterface);
Var lSrc : IBsvImage;
Begin
  If Supports(ASource, IBsvImage, lSrc) Then
  Begin
    FImageName := lSrc.ImageName;
    FX         := lSrc.X;
    FY         := lSrc.Y;
    FWidth     := lSrc.Width;
    FHeight    := lSrc.Height;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TBsvImage.GetImageName() : AnsiString;
Begin
  Result := FImageName;
End;

Procedure TBsvImage.SetImageName(Const AImageName : AnsiString);
Begin
  FImageName := AImageName;
End;

Function TBsvImage.GetX() : Word;
Begin
  Result := FX;
End;

Procedure TBsvImage.SetX(Const AX : Word);
Begin
  FX := AX;
End;

Function TBsvImage.GetY() : Word;
Begin
  Result := FY;
End;

Procedure TBsvImage.SetY(Const AY : Word);
Begin
  FY := AY;
End;

Function TBsvImage.GetWidth() : Word;
Begin
  Result := FWidth;
End;

Procedure TBsvImage.SetWidth(Const AWidth : Word);
Begin
  FWidth := AWidth;
End;

Function TBsvImage.GetHeight() : Word;
Begin
  Result := FHeight;
End;

Procedure TBsvImage.SetHeight(Const AHeight : Word);
Begin
  FHeight := AHeight;
End;

Function TBsvImages.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TBsvImage;
End;

Function TBsvImages.Get(Index : Integer) : IBsvImage;
Begin
  Result := InHerited Items[Index] As IBsvImage;
End;

Procedure TBsvImages.Put(Index : Integer; Const Item : IBsvImage);
Begin
  InHerited Items[Index] := Item;
End;

Function TBsvImages.Add() : IBsvImage;
Begin
  Result := InHerited Add() As IBsvImage;
End;

Function TBsvImages.Add(Const AItem : IBsvImage) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Procedure TBsvImages.Assign(ASource : IInterface);
Var lSrc : IBsvImages;
    X : Integer;
Begin
  If Supports(ASource, IBsvImages, lSrc)Then
  Begin
    If Not IsImplementorOf(lSrc) Then
    Begin
      Clear();
      For X := 0 To lSrc.Count - 1 Do
        Add().Assign(lSrc[X]);
    End;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

{
Var lRgb : ITSTORgbFile;
    lBsv : IBsvFileIO;
    lPng : TPngImage;
    lFName : AnsiString;
    lX, lY, lW, lH : Word;
    lXml : IXmlDocumentEx;
    lXmlNodes : IXmlNodeListEx;
Begin
  lPath := 'V:\TSTOModToolKit\Bin\TSTODlcServer\4_18_XMAS2015_77NKAMSPG5KD\BuildStates-50-r272024-LZ8QBWET\1\';
  lBsv := TBsvFileIO.CreateBsvFile();
  lRgb := TTSTORgbFile.CreateRGBFile();
  Try
    lRgb.LoadRgbFromFile(lPath + 'buildstates.rgb');
    lBsv.LoadFromFile(lPath + 'buildstates_1x2.bsv3');
    lXml := LoadXmlData(lBsv.AsXml);

    lXmlNodes := lXml.SelectNodes('//ImageId');
    lStrs := THsStringListEx.CreateList();
    For X := 0 To lXmlNodes.Count - 1 Do
      If lStrs.IndexOf(lXmlNodes[X].Text) = -1 Then
      Begin
        lStrs.Add(lXmlNodes[X].Text);

        lX := lBsv.Region[lXmlNodes[X].NodeValue].X;
        lY := lBsv.Region[lXmlNodes[X].NodeValue].Y;
        lW := lBsv.Region[lXmlNodes[X].NodeValue].Width;
        lH := lBsv.Region[lXmlNodes[X].NodeValue].Height;

        lPng := TPngImage.CreateBlank(COLOR_RGBALPHA, 16, lW, lH);
        Try
          For Z := lY To lY+lH Do //y
            For Y := lX To lX+lW Do //x
            Begin
              lPng.Pixels[Y-lX, Z-lY] := TPngImage(lRgb.Picture).Pixels[Y, Z];
              lPng.AlphaScanline[Z-lY]^[Y-lX] := TPngImage(lRgb.Picture).AlphaScanLine[Z]^[Y];
            End;

          If lXmlNodes[X].NodeValue < 10 Then
            lFName := '0' + IntToStr(lXmlNodes[X].NodeValue)
          Else
            lFName := IntToStr(lXmlNodes[X].NodeValue);

          lFName := lFName + '-' + lBsv.Region[lXmlNodes[X].NodeValue].ImageName;
          lPng.SaveToFile(lPath + lFName + '.png');

          Finally
            lPng.Free();
        End;
      End;

    lBsv.SaveToXml(lPath + 'buildstates_1x2.xml');

    Finally
      lBsv := Nil;
      lStrs := Nil;
  End;
End;  
}
end.
