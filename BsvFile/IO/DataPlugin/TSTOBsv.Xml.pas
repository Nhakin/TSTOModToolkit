unit TSTOBsv.Xml;

Interface

Uses Classes, SysUtils, RTLConsts, HsXmlDocEx;

Type
  IXmlBsvImage = Interface(IXmlNodeEx)
    ['{4B61686E-29A0-2112-90B9-955AA4158E49}']
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

    Procedure Assign(ASource : IInterface);

    Property ImageName : AnsiString Read GetImageName Write SetImageName;
    Property X         : Word   Read GetX         Write SetX;
    Property Y         : Word   Read GetY         Write SetY;
    Property Width     : Word   Read GetWidth     Write SetWidth;
    Property Height    : Word   Read GetHeight    Write SetHeight;

  End;

  IXmlBsvImages = Interface(IXmlNodeCollectionEx)
    ['{4B61686E-29A0-2112-8931-C22CD848108C}']
    Function GetItem(Const Index : Integer) : IXmlBsvImage;

    Function Add() : IXmlBsvImage;
    Function Insert(Const Index: Integer) : IXmlBsvImage;

    Procedure Assign(ASource : IInterface);
    
    Property Items[Const Index: Integer] : IXmlBsvImage Read GetItem; Default;

  End;

  IXmlBsvAnimation = Interface(IXmlNodeEx)
    ['{4B61686E-29A0-2112-909C-C4CBB6E73754}']
    Function  GetAnimationName() : AnsiString;
    Procedure SetAnimationName(Const AAnimationName : AnsiString);

    Function  GetStartFrame() : Word;
    Procedure SetStartFrame(Const AStartFrame : Word);

    Function  GetEndFrame() : Word;
    Procedure SetEndFrame(Const AEndFrame : Word);

    Procedure Assign(ASource : IInterface);

    Property AnimationName : AnsiString Read GetAnimationName Write SetAnimationName;
    Property StartFrame    : Word   Read GetStartFrame    Write SetStartFrame;
    Property EndFrame      : Word   Read GetEndFrame      Write SetEndFrame;

  End;

  IXmlBsvAnimations = Interface(IXmlNodeCollectionEx)
    ['{4B61686E-29A0-2112-B4E8-7EE9E3AB521C}']
    Function GetItem(Const Index : Integer) : IXmlBsvAnimation;

    Function Add() : IXmlBsvAnimation;
    Function Insert(Const Index: Integer) : IXmlBsvAnimation;

    Procedure Assign(ASource : IInterface);

    Property Items[Const Index: Integer] : IXmlBsvAnimation Read GetItem; Default;

  End;

  IXmlBsvSubData = Interface(IXmlNodeEx)
    ['{4B61686E-29A0-2112-B50B-D85085FC64EB}']
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

  IXmlBsvSubDatas = Interface(IXmlNodeCollectionEx)
    ['{4B61686E-29A0-2112-8992-2474D8C7D5AD}']
    Function GetItem(Const Index : Integer) : IXmlBsvSubData;

    Function Add() : IXmlBsvSubData;
    Function Insert(Const Index: Integer) : IXmlBsvSubData;

    Procedure Assign(ASource : IInterface);

    Property Items[Const Index: Integer] : IXmlBsvSubData Read GetItem; Default;

  End;

  IXmlBsvSub = Interface(IXmlNodeEx)
    ['{4B61686E-29A0-2112-BF12-5274FC98CBCC}']
    Function  GetSubCount() : Word;

    Function  GetSubLen() : Byte;
    Procedure SetSubLen(Const ASubLen : Byte);

    Function  GetSubData() : IXmlBsvSubDatas;

    Procedure Assign(ASource : IInterface);

    Property SubCount : Word            Read GetSubCount;
    Property SubLen   : Byte            Read GetSubLen   Write SetSubLen;
    Property SubData  : IXmlBsvSubDatas Read GetSubData;

  End;

  IXmlBsvSubs = Interface(IXmlNodeCollectionEx)
    ['{4B61686E-29A0-2112-997D-05BD79702236}']
    Function GetItem(Const Index : Integer) : IXmlBsvSub;

    Function Add() : IXmlBsvSub;
    Function Insert(Const Index: Integer) : IXmlBsvSub;

    Procedure Assign(ASource : IInterface);

    Property Items[Const Index: Integer] : IXmlBsvSub Read GetItem; Default;

  End;

  IXmlBsvFile = Interface(IXmlNodeEx)
    ['{4B61686E-29A0-2112-BB1A-792C3984FE97}']
    Function  GetFileSig() : Word;
    Procedure SetFileSig(Const AFileSig : Word);

    Function  GetRegionCount() : Word;

    Function  GetHasOpacity() : Byte;
    Procedure SetHasOpacity(Const AHasOpacity : Byte);

    Function  GetRgbFileName() : AnsiString;
    Procedure SetRgbFileName(Const ARgbFileName : AnsiString);

    Function  GetRegion() : IXmlBsvImages;

    Function  GetTransformationCount() : Word;

    Function  GetSub() : IXmlBsvSubs;

    Function  GetAnimationCount() : Word;

    Function  GetAnimation() : IXmlBsvAnimations;

    Procedure Assign(ASource : IInterface);
    
    Property FileSig             : Word              Read GetFileSig             Write SetFileSig;
    Property RegionCount         : Word              Read GetRegionCount;
    Property HasOpacity          : Byte              Read GetHasOpacity          Write SetHasOpacity;
    Property RgbFileName         : AnsiString            Read GetRgbFileName         Write SetRgbFileName;
    Property Region              : IXmlBsvImages     Read GetRegion;
    Property TransformationCount : Word              Read GetTransformationCount;
    Property Sub                 : IXmlBsvSubs       Read GetSub;
    Property AnimationCount      : Word              Read GetAnimationCount;
    Property Animation           : IXmlBsvAnimations Read GetAnimation;

  End;

(******************************************************************************)

  TXmlBsvFile = Class(TObject)
  Public
    Class Function CreateBsvFile() : IXmlBsvFile; OverLoad;
    Class Function CreateBsvFile(Const AXmlText : AnsiString) : IXmlBsvFile; OverLoad;

  End;

Implementation

Uses Variants, HsInterfaceEx, TSTOBsvIntf;

Type
  TXmlBsvImage = Class(TXmlNodeEx, IBsvImage, IXmlBsvImage)
  Private
    FImageImpl : Pointer;
    Function GetImplementor() : IBsvImage;

  Protected
    Property ImageImpl : IBsvImage Read GetImplementor;
    
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

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TXmlBsvImages = Class(TXMLNodeCollectionEx, IBsvImages, IXmlBsvImages)
  Private
    FImagesImpl : IBsvImages;

    Function GetImplementor() : IBsvImages;

  Protected
    Property ImagesImpl : IBsvImages Read GetImplementor Implements IBsvImages;

    Function GetItem(Const Index : Integer) : IXmlBsvImage;

    Function Add() : IXmlBsvImage;
    Function Insert(Const Index : Integer) : IXmlBsvImage;

    Procedure Assign(ASource : IInterface); 
    Procedure AssignTo(ATarget : IBsvImages);

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TXmlBsvAnimation = Class(TXmlNodeEx, IBsvAnimation, IXmlBsvAnimation)
  Private
    FAnimationImpl : Pointer;

    Function GetImplementor() : IBsvAnimation;

  Protected
    Property AnimationImpl : IBsvAnimation Read GetImplementor;

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

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TXmlBsvAnimations = Class(TXMLNodeCollectionEx, IBsvAnimations, IXmlBsvAnimations)
  Private
    FAnimationsImpl : IBsvAnimations;

    Function GetImplementor() : IBsvAnimations;

  Protected
    Property AnimationsImpl : IBsvAnimations Read GetImplementor Implements IBsvAnimations;
    
    Function GetItem(Const Index : Integer) : IXmlBsvAnimation;

    Function Add() : IXmlBsvAnimation;
    Function Insert(Const Index : Integer) : IXmlBsvAnimation;

    Procedure Assign(ASource : IInterface);
    Procedure AssignTo(ATarget : IBsvAnimations);

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TXmlBsvSubData = Class(TXmlNodeEx, IBsvSubData, IXmlBsvSubData)
  Private
    FSubDataImpl : Pointer;

    Function GetImplementor() : IBsvSubData;

  Protected
    Property SubDataImpl : IBsvSubData Read GetImplementor;
    
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

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TXmlBsvSubDatas = Class(TXMLNodeCollectionEx, IBsvSubDatas, IXmlBsvSubDatas)
  Private
    FSubDatasImpl : IBsvSubDatas;

    Function GetImplementor() : IBsvSubDatas;

  Protected
    Property SubDatasImpl : IBsvSubDatas Read GetImplementor Implements IBsvSubDatas;

    Function GetItem(Const Index : Integer) : IXmlBsvSubData;

    Function Add() : IXmlBsvSubData;
    Function Insert(Const Index : Integer) : IXmlBsvSubData;

    Procedure Assign(ASource : IInterface);
    Procedure AssignTo(ATarget : IBsvSubDatas);
    
  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TXmlBsvSub = Class(TXmlNodeEx, IBsvSub, IXmlBsvSub)
  Private
    FSubImpl : Pointer;

    Function GetImplementor() : IBsvSub;

  Protected
    Property SubImpl : IBsvSub Read GetImplementor;

    Function  GetSubCount() : Word;

    Function  GetSubLen() : Byte;
    Procedure SetSubLen(Const ASubLen : Byte);

    Function  GetSubData() : IXmlBsvSubDatas;
    Function  GetISubData() : IBsvSubDatas;

    Function IBsvSub.GetSubData = GetISubData;

    Procedure Clear();

    Property SubCount : Word            Read GetSubCount;
    Property SubLen   : Byte            Read GetSubLen   Write SetSubLen;
    Property SubData  : IXmlBsvSubDatas Read GetSubData;

    Procedure Assign(ASource : IInterface);

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TXmlBsvSubs = Class(TXMLNodeCollectionEx, IBsvSubs, IXmlBsvSubs)
  Private
    FSubsImpl : IBsvSubs;

    Function GetImplementor() : IBsvSubs;

  Protected
    Property SubsImpl : IBsvSubs Read GetImplementor Implements IBsvSubs;

    Function GetItem(Const Index : Integer) : IXmlBsvSub;

    Function Add() : IXmlBsvSub;
    Function Insert(Const Index : Integer) : IXmlBsvSub;

    Procedure Assign(ASource : IInterface);
    Procedure AssignTo(ATarget : IBsvSubs);
    
  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TXmlBsvFileImpl = Class(TXmlNodeEx, IBsvFile, IXmlBsvFile)
  Private
    FFileImpl : Pointer;

    Function GetImplementor() : IBsvFile;

  Protected
    Property FileImpl : IBsvFile Read GetImplementor;
    
    Function  GetFileSig() : Word;
    Procedure SetFileSig(Const AFileSig : Word);

    Function  GetRegionCount() : Word;

    Function  GetHasOpacity() : Byte;
    Procedure SetHasOpacity(Const AHasOpacity : Byte);

    Function  GetRgbFileName() : AnsiString;
    Procedure SetRgbFileName(Const ARgbFileName : AnsiString);

    Function  GetRegion() : IXmlBsvImages;
    Function  GetIRegion() : IBsvImages;
    Function  IBsvFile.GetRegion = GetIRegion;

    Function  GetTransformationCount() : Word;

    Function  GetSub() : IXmlBsvSubs;
    Function  GetISub() : IBsvSubs;
    Function  IBsvFile.GetSub = GetISub;

    Function  GetAnimationCount() : Word;

    Function  GetAnimation() : IXmlBsvAnimations;
    Function  GetIAnimation() : IBsvAnimations;
    Function  IBsvFile.GetAnimation = GetIAnimation;

    Procedure Clear();

    Procedure Assign(ASource : IInterface);

    Property FileSig             : Word              Read GetFileSig             Write SetFileSig;
    Property RegionCount         : Word              Read GetRegionCount;
    Property HasOpacity          : Byte              Read GetHasOpacity          Write SetHasOpacity;
    Property RgbFileName         : AnsiString            Read GetRgbFileName         Write SetRgbFileName;
    Property Region              : IXmlBsvImages     Read GetRegion;
    Property TransformationCount : Word              Read GetTransformationCount;
    Property Sub                 : IXmlBsvSubs       Read GetSub;
    Property AnimationCount      : Word              Read GetAnimationCount;
    Property Animation           : IXmlBsvAnimations Read GetAnimation;

  Public
    Procedure AfterConstruction(); OverRide;

  End;

Class Function TXmlBsvFile.CreateBsvFile() : IXmlBsvFile;
Begin
  Result := NewXmlDocument().GetDocBinding('BsvFile', TXmlBsvFileImpl) As IXmlBsvFile;
End;

Class Function TXmlBsvFile.CreateBsvFile(Const AXmlText : AnsiString) : IXmlBsvFile;
Begin
  Result := LoadXmlData(AXmlText).GetDocBinding('BsvFile', TXmlBsvFileImpl) As IXmlBsvFile;
End;

(******************************************************************************)

Procedure TXmlBsvImage.AfterConstruction();
Begin
  InHerited AfterConstruction();

  FImageImpl := Pointer(IBsvImage(Self));
End;

Function TXmlBsvImage.GetImplementor() : IBsvImage;
Begin
  Result := IBsvImage(FImageImpl);
End;

Procedure TXmlBsvImage.Clear();
Begin
  ChildNodes['ImageName'].NodeValue := Null;
  ChildNodes['X'].NodeValue         := Null;
  ChildNodes['Y'].NodeValue         := Null;
  ChildNodes['Width'].NodeValue     := Null;
  ChildNodes['Height'].NodeValue    := Null;
End;

Procedure TXmlBsvImage.Assign(ASource : IInterface);
Var lXmlSrc : IXmlBsvImage;
    lSrc : IBsvImage;
Begin
  If Supports(ASource, IXmlNodeEx) And
     Supports(ASource, IXmlBsvImage, lXmlSrc) Then
  Begin
    ChildNodes['ImageName'].NodeValue := lXmlSrc.ImageName;
    ChildNodes['X'].NodeValue         := lXmlSrc.X;
    ChildNodes['Y'].NodeValue         := lXmlSrc.Y;
    ChildNodes['Width'].NodeValue     := lXmlSrc.Width;
    ChildNodes['Height'].NodeValue    := lXmlSrc.Height;
  End
  Else If Supports(ASource, IBsvImage, lSrc) Then
  Begin
    ChildNodes['ImageName'].NodeValue := lSrc.ImageName;
    ChildNodes['X'].NodeValue         := lSrc.X;
    ChildNodes['Y'].NodeValue         := lSrc.Y;
    ChildNodes['Width'].NodeValue     := lSrc.Width;
    ChildNodes['Height'].NodeValue    := lSrc.Height;

    FImageImpl := Pointer(lSrc);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TXmlBsvImage.GetImageName() : AnsiString;
Begin
  Result := ChildNodes['ImageName'].AsString;
End;

Procedure TXmlBsvImage.SetImageName(Const AImageName : AnsiString);
Begin
  ChildNodes['ImageName'].AsString := AImageName;
  If Not IsImplementorOf(ImageImpl) Then
    ImageImpl.ImageName := AImageName;
End;

Function TXmlBsvImage.GetX() : Word;
Begin
  Result := ChildNodes['X'].AsInteger;
End;

Procedure TXmlBsvImage.SetX(Const AX : Word);
Begin
  ChildNodes['X'].AsInteger := AX;
  If Not IsImplementorOf(ImageImpl) Then
    ImageImpl.X := AX;
End;

Function TXmlBsvImage.GetY() : Word;
Begin
  Result := ChildNodes['Y'].AsInteger;
End;

Procedure TXmlBsvImage.SetY(Const AY : Word);
Begin
  ChildNodes['Y'].AsInteger := AY;
  If Not IsImplementorOf(ImageImpl) Then
    ImageImpl.Y := AY;
End;

Function TXmlBsvImage.GetWidth() : Word;
Begin
  Result := ChildNodes['Width'].AsInteger;
End;

Procedure TXmlBsvImage.SetWidth(Const AWidth : Word);
Begin
  ChildNodes['Width'].AsInteger := AWidth;
  If Not IsImplementorOf(ImageImpl) Then
    ImageImpl.Width := AWidth;
End;

Function TXmlBsvImage.GetHeight() : Word;
Begin
  Result := ChildNodes['Height'].AsInteger;
End;

Procedure TXmlBsvImage.SetHeight(Const AHeight : Word);
Begin
  ChildNodes['Height'].AsInteger := AHeight;
  If Not IsImplementorOf(ImageImpl) Then
    ImageImpl.Height := AHeight;
End;

Procedure TXmlBsvImages.AfterConstruction();
Begin
  RegisterChildNode('XmlBsvImage', TXmlBsvImage);
  ItemTag       := 'XmlBsvImage';
  ItemInterface := IXmlBsvImage;

  InHerited AfterConstruction();
End;

Function TXmlBsvImages.GetImplementor() : IBsvImages;
Begin
  If Not Assigned(FImagesImpl) Then
    FImagesImpl := TBsvFile.CreateBsvImages();
  Result := FImagesImpl;

  AssignTo(Result);  
End;

Function TXmlBsvImages.GetItem(Const Index : Integer) : IXmlBsvImage;
Begin
  Result := List[Index] As IXmlBsvImage;
End;

Function TXmlBsvImages.Add() : IXmlBsvImage;
Begin
  Result := AddItem(-1) As IXmlBsvImage;
End;

Function TXmlBsvImages.Insert(Const Index : Integer) : IXmlBsvImage;
Begin
  Result := AddItem(Index) As IXmlBsvImage;
End;

Procedure TXmlBsvImages.Assign(ASource : IInterface);
Var lXmlSrc : IXmlBsvImages;
    lSrc : IBsvImages;
    X : Integer;
Begin
  If Supports(ASource, IXMLNodeCollectionEx) And
     Supports(ASource, IXmlBsvImages, lXmlSrc) Then
  Begin
    Clear();

    For X := 0 To lXmlSrc.Count - 1 Do
      Add().Assign(lXmlSrc[X]);
  End
  Else If Supports(ASource, IBsvImages, lSrc) Then
  Begin
    Clear();
    For X := 0 To lSrc.Count - 1 Do
      Add().Assign(lSrc[X]);

    FImagesImpl := lSrc;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Procedure TXmlBsvImages.AssignTo(ATarget : IBsvImages);
Var X : Integer;
    lItem : IBsvImage;
Begin
  ATarget.Clear();
  For X := 0 To Count - 1 Do
    If Supports(List[X], IBsvImage, lItem) Then
      ATarget.Add().Assign(lItem);
End;

Procedure TXmlBsvAnimation.AfterConstruction();
Begin
  InHerited AfterConstruction();

  FAnimationImpl := Pointer(IBsvAnimation(Self));
End;

Function TXmlBsvAnimation.GetImplementor() : IBsvAnimation;
Begin
  Result := IBsvAnimation(FAnimationImpl);
End;

Procedure TXmlBsvAnimation.Clear();
Begin
  ChildNodes['AnimationName'].NodeValue := Null;
  ChildNodes['StartFrame'].NodeValue    := Null;
  ChildNodes['EndFrame'].NodeValue      := Null;
End;

Procedure TXmlBsvAnimation.Assign(ASource : IInterface);
Var lXmlSrc : IXmlBsvAnimation;
    lSrc : IBsvAnimation;
Begin
  If Supports(ASource, IXmlNodeEx) And
     Supports(ASource, IXmlBsvAnimation, lXmlSrc) Then
  Begin
    ChildNodes['AnimationName'].NodeValue := lXmlSrc.AnimationName;
    ChildNodes['StartFrame'].NodeValue    := lXmlSrc.StartFrame;
    ChildNodes['EndFrame'].NodeValue      := lXmlSrc.EndFrame;
  End
  Else If Supports(ASource, IBsvAnimation, lSrc) Then
  Begin
    ChildNodes['AnimationName'].NodeValue := lSrc.AnimationName;
    ChildNodes['StartFrame'].NodeValue    := lSrc.StartFrame;
    ChildNodes['EndFrame'].NodeValue      := lSrc.EndFrame;

    FAnimationImpl := Pointer(lSrc);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TXmlBsvAnimation.GetAnimationName() : AnsiString;
Begin
  Result := ChildNodes['AnimationName'].AsString;
End;

Procedure TXmlBsvAnimation.SetAnimationName(Const AAnimationName : AnsiString);
Begin
  ChildNodes['AnimationName'].AsString := AAnimationName;
  If Not IsImplementorOf(AnimationImpl) Then
    AnimationImpl.AnimationName := AAnimationName;
End;

Function TXmlBsvAnimation.GetStartFrame() : Word;
Begin
  Result := ChildNodes['StartFrame'].AsInteger;
End;

Procedure TXmlBsvAnimation.SetStartFrame(Const AStartFrame : Word);
Begin
  ChildNodes['StartFrame'].AsInteger := AStartFrame;
  If Not IsImplementorOf(AnimationImpl) Then
    AnimationImpl.StartFrame := AStartFrame;
End;

Function TXmlBsvAnimation.GetEndFrame() : Word;
Begin
  Result := ChildNodes['EndFrame'].AsInteger;
End;

Procedure TXmlBsvAnimation.SetEndFrame(Const AEndFrame : Word);
Begin
  ChildNodes['EndFrame'].AsInteger := AEndFrame;
  If Not IsImplementorOf(AnimationImpl) Then
    AnimationImpl.EndFrame := AEndFrame;
End;

Procedure TXmlBsvAnimations.AfterConstruction();
Begin
  RegisterChildNode('XmlBsvAnimation', TXmlBsvAnimation);
  ItemTag       := 'XmlBsvAnimation';
  ItemInterface := IXmlBsvAnimation;

  InHerited AfterConstruction();
End;

Function TXmlBsvAnimations.GetImplementor() : IBsvAnimations;
Begin
  If Not Assigned(FAnimationsImpl) Then
    FAnimationsImpl := TBsvFile.CreateBsvAnimations();
  Result := FAnimationsImpl;

  AssignTo(Result);
End;

Function TXmlBsvAnimations.GetItem(Const Index : Integer) : IXmlBsvAnimation;
Begin
  Result := List[Index] As IXmlBsvAnimation;
End;

Function TXmlBsvAnimations.Add() : IXmlBsvAnimation;
Begin
  Result := AddItem(-1) As IXmlBsvAnimation;
End;

Function TXmlBsvAnimations.Insert(Const Index : Integer) : IXmlBsvAnimation;
Begin
  Result := AddItem(Index) As IXmlBsvAnimation;
End;

Procedure TXmlBsvAnimations.Assign(ASource : IInterface);
Var lXmlSrc : IXmlBsvAnimations;
    lSrc    : IBsvAnimations;
    X       : Integer;
Begin
  If Supports(ASource, IXmlNodeListEx) And
     Supports(ASource, IXmlBsvAnimations, lXmlSrc) Then
  Begin
    Clear();

    For X := 0 To lXmlSrc.Count - 1 Do
      Add().Assign(lXmlSrc[X]);
  End
  Else If Supports(ASource, IBsvAnimations, lSrc) Then
  Begin
    Clear();

    For X := 0 To lSrc.Count - 1 Do
      Add().Assign(lSrc[X]);

    FAnimationsImpl := lSrc;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Procedure TXmlBsvAnimations.AssignTo(ATarget : IBsvAnimations);
Var X : Integer;
    lItem : IBsvAnimation;
Begin
  ATarget.Clear();

  For X := 0 To Count - 1 Do
    If Supports(List[X], IBsvAnimation, lItem) Then
      ATarget.Add().Assign(lItem);
End;

Procedure TXmlBsvSubData.AfterConstruction();
Begin
  InHerited AfterConstruction();
  FSubDataImpl := Pointer(IBsvSubData(Self));
End;

Function TXmlBsvSubData.GetImplementor() : IBsvSubData;
Begin
  Result := IBsvSubData(FSubDataImpl);
End;

Procedure TXmlBsvSubData.Clear();
Begin
  ChildNodes['ImageId'].NodeValue := Null;
  ChildNodes['X'].NodeValue       := Null;
  ChildNodes['Y'].NodeValue       := Null;
  ChildNodes['XScale'].NodeValue  := Null;
  ChildNodes['Skew_H'].NodeValue  := Null;
  ChildNodes['Skew_V'].NodeValue  := Null;
  ChildNodes['YScale'].NodeValue  := Null;
End;

Procedure TXmlBsvSubData.Assign(ASource : IInterface);
Var lXmlSrc : IXmlBsvSubData;
    lSrc    : IBsvSubData;
Begin
  If Supports(ASource, IXmlNodeEx) And
     Supports(ASource, IXmlBsvSubData, lXmlSrc) Then
  Begin
    ChildNodes['ImageId'].NodeValue := lXmlSrc.ImageId;
    ChildNodes['X'].NodeValue       := lXmlSrc.X;
    ChildNodes['Y'].NodeValue       := lXmlSrc.Y;
    ChildNodes['XScale'].NodeValue  := lXmlSrc.XScale;
    ChildNodes['Skew_H'].NodeValue  := lXmlSrc.Skew_H;
    ChildNodes['Skew_V'].NodeValue  := lXmlSrc.Skew_V;
    ChildNodes['YScale'].NodeValue  := lXmlSrc.YScale;
    ChildNodes['Opacity'].NodeValue := lXmlSrc.Opacity;
  End
  Else If Supports(ASource, IBsvSubData, lSrc) Then
  Begin
    ChildNodes['ImageId'].NodeValue := lSrc.ImageId;
    ChildNodes['X'].NodeValue       := lSrc.X;
    ChildNodes['Y'].NodeValue       := lSrc.Y;
    ChildNodes['XScale'].NodeValue  := lSrc.XScale;
    ChildNodes['Skew_H'].NodeValue  := lSrc.Skew_H;
    ChildNodes['Skew_V'].NodeValue  := lSrc.Skew_V;
    ChildNodes['YScale'].NodeValue  := lSrc.YScale;
    ChildNodes['Opacity'].NodeValue := lSrc.Opacity;

    FSubDataImpl := Pointer(lSrc);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TXmlBsvSubData.GetImageId() : Word;
Begin
  Result := ChildNodes['ImageId'].AsInteger;
End;

Procedure TXmlBsvSubData.SetImageId(Const AImageId : Word);
Begin
  ChildNodes['ImageId'].AsInteger := AImageId;
  If Not IsImplementorOf(SubDataImpl) Then
    SubDataImpl.ImageId := AImageId;
End;

Function TXmlBsvSubData.GetX() : Single;
Begin
  Result := ChildNodes['X'].AsFloat;
End;

Procedure TXmlBsvSubData.SetX(Const AX : Single);
Begin
  ChildNodes['X'].AsFloat := AX;
  If Not IsImplementorOf(SubDataImpl) Then
    SubDataImpl.X := AX;
End;

Function TXmlBsvSubData.GetY() : Single;
Begin
  Result := ChildNodes['Y'].AsFloat;
End;

Procedure TXmlBsvSubData.SetY(Const AY : Single);
Begin
  ChildNodes['Y'].AsFloat := AY;
  If Not IsImplementorOf(SubDataImpl) Then
    SubDataImpl.Y := AY;
End;

Function TXmlBsvSubData.GetXScale() : Single;
Begin
  Result := ChildNodes['XScale'].AsFloat;
End;

Procedure TXmlBsvSubData.SetXScale(Const AXScale : Single);
Begin
  ChildNodes['XScale'].AsFloat := AXScale;
  If Not IsImplementorOf(SubDataImpl) Then
    SubDataImpl.XScale := AXScale;
End;

Function TXmlBsvSubData.GetSkew_H() : Single;
Begin
  Result := ChildNodes['Skew_H'].AsFloat;
End;

Procedure TXmlBsvSubData.SetSkew_H(Const ASkew_H : Single);
Begin
  ChildNodes['Skew_H'].AsFloat := ASkew_H;
  If Not IsImplementorOf(SubDataImpl) Then
    SubDataImpl.Skew_H := ASkew_H;
End;

Function TXmlBsvSubData.GetSkew_V() : Single;
Begin
  Result := ChildNodes['Skew_V'].AsFloat;
End;

Procedure TXmlBsvSubData.SetSkew_V(Const ASkew_V : Single);
Begin
  ChildNodes['Skew_V'].AsFloat := ASkew_V;
  If Not IsImplementorOf(SubDataImpl) Then
    SubDataImpl.Skew_V := ASkew_V;
End;

Function TXmlBsvSubData.GetYScale() : Single;
Begin
  Result := ChildNodes['YScale'].AsFloat;
End;

Procedure TXmlBsvSubData.SetYScale(Const AYScale : Single);
Begin
  ChildNodes['YScale'].AsFloat := AYScale;
  If Not IsImplementorOf(SubDataImpl) Then
    SubDataImpl.YScale := AYScale;
End;

Function TXmlBsvSubData.GetOpacity() : Byte;
Begin
  Result := ChildNodes['Opacity'].AsInteger;
End;

Procedure TXmlBsvSubData.SetOpacity(Const AOpacity : Byte);
Begin
  ChildNodes['Opacity'].AsInteger := AOpacity;
  If Not IsImplementorOf(SubDataImpl) Then
    SubDataImpl.Opacity := AOpacity;
End;

Procedure TXmlBsvSubDatas.AfterConstruction();
Begin
  RegisterChildNode('XmlBsvSubData', TXmlBsvSubData);
  ItemTag       := 'XmlBsvSubData';
  ItemInterface := IXmlBsvSubData;

  InHerited AfterConstruction();
End;

Function TXmlBsvSubDatas.GetImplementor() : IBsvSubDatas;
Begin
  If Not Assigned(FSubDatasImpl) Then
    FSubDatasImpl := TBsvFile.CreateBsvSubDatas();
  Result := FSubDatasImpl;

  AssignTo(Result);
End;

Function TXmlBsvSubDatas.GetItem(Const Index : Integer) : IXmlBsvSubData;
Begin
  Result := List[Index] As IXmlBsvSubData;
End;

Function TXmlBsvSubDatas.Add() : IXmlBsvSubData;
Begin
  Result := AddItem(-1) As IXmlBsvSubData;
End;

Function TXmlBsvSubDatas.Insert(Const Index : Integer) : IXmlBsvSubData;
Begin
  Result := AddItem(Index) As IXmlBsvSubData;
End;

Procedure TXmlBsvSubDatas.Assign(ASource : IInterface);
Var lXmlSrc : IXmlBsvSubDatas;
    lSrc    : IBsvSubDatas;
    X       : Integer;
Begin
  If Supports(ASource, IXMLNodeCollectionEx) And
     Supports(ASource, IXmlBsvSubDatas, lXmlSrc) Then
  Begin
    Clear();

    For X := 0 To lXmlSrc.Count - 1 Do
      Add().Assign(lXmlSrc[X]);
  End
  Else If Supports(ASource, IBsvSubDatas, lSrc) Then
  Begin
    Clear();

    For X := 0 To lSrc.Count - 1 Do
      Add().Assign(lSrc[X]);

    FSubDatasImpl := lSrc;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Procedure TXmlBsvSubDatas.AssignTo(ATarget : IBsvSubDatas);
Var X : Integer;
    lItem : IBsvSubData;
Begin
  ATarget.Clear();

  For X := 0 To Count - 1 Do
    If Supports(List[X], IBsvSubData, lItem) Then
      ATarget.Add().Assign(lItem);
End;

Procedure TXmlBsvSub.AfterConstruction();
Begin
  InHerited AfterConstruction();

  RegisterChildNode('SubData', TXmlBsvSubDatas);

  FSubImpl := Pointer(IBsvSub(Self));
End;

Function TXmlBsvSub.GetImplementor() : IBsvSub;
Begin
  Result := IBsvSub(FSubImpl);
End;

Procedure TXmlBsvSub.Clear();
Begin
  ChildNodes['SubCount'].NodeValue := Null;
  ChildNodes['SubLen'].NodeValue   := Null;
  ChildNodes['SubData'].NodeValue  := Null;
End;

Procedure TXmlBsvSub.Assign(ASource : IInterface);
Var lXmlSrc : IXmlBsvSub;
    lSrc    : IBsvSub;
Begin
  If Supports(ASource, IXmlNodeEx) And
     Supports(ASource, IXmlBsvSub, lXmlSrc) Then
  Begin
    ChildNodes['SubCount'].NodeValue := lXmlSrc.SubCount;
    ChildNodes['SubLen'].NodeValue   := lXmlSrc.SubLen;
    SubData.Assign(lXmlSrc.SubData);
  End
  Else If Supports(ASource, IBsvSub, lSrc) Then
  Begin
    ChildNodes['SubCount'].NodeValue := lSrc.SubCount;
    ChildNodes['SubLen'].NodeValue   := lSrc.SubLen;
    SubData.Assign(lSrc.SubData);

    FSubImpl := Pointer(lSrc);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TXmlBsvSub.GetSubCount() : Word;
Begin
  Result := SubData.Count;
End;

Function TXmlBsvSub.GetSubLen() : Byte;
Begin
  Result := ChildNodes['SubLen'].AsInteger;
End;

Procedure TXmlBsvSub.SetSubLen(Const ASubLen : Byte);
Begin
  ChildNodes['SubLen'].AsInteger := ASubLen;
  If Not IsImplementorOf(SubImpl) Then
    SubImpl.SubLen := ASubLen;
End;

Function TXmlBsvSub.GetSubData() : IXmlBsvSubDatas;
Begin
  Result := ChildNodes['SubData'] As IXmlBsvSubDatas;
End;

Function TXmlBsvSub.GetISubData() : IBsvSubDatas;
Begin
  Result := GetSubData() As IBsvSubDatas;
End;

Procedure TXmlBsvSubs.AfterConstruction();
Begin
  RegisterChildNode('XmlBsvSub', TXmlBsvSub);
  ItemTag       := 'XmlBsvSub';
  ItemInterface := IXmlBsvSub;

  InHerited AfterConstruction();
End;

Function TXmlBsvSubs.GetImplementor() : IBsvSubs;
Begin
  If Not Assigned(FSubsImpl) Then
    FSubsImpl := TBsvFile.CreateBsvSubs();
  Result := FSubsImpl;

  AssignTo(FSubsImpl);
End;

Function TXmlBsvSubs.GetItem(Const Index : Integer) : IXmlBsvSub;
Begin
  Result := List[Index] As IXmlBsvSub;
End;

Function TXmlBsvSubs.Add() : IXmlBsvSub;
Begin
  Result := AddItem(-1) As IXmlBsvSub;
End;

Function TXmlBsvSubs.Insert(Const Index : Integer) : IXmlBsvSub;
Begin
  Result := AddItem(Index) As IXmlBsvSub;
End;

Procedure TXmlBsvSubs.Assign(ASource : IInterface);
Var lXmlSrc : IXmlBsvSubs;
    lSrc    : IBsvSubs;
    X       : Integer;
Begin
  If Supports(ASource, IXMLNodeCollectionEx) And
     Supports(ASource, IXmlBsvSubs, lXmlSrc) Then
  Begin
    Clear();

    For X := 0 To lXmlSrc.Count - 1 Do
      Add().Assign(lXmlSrc[X]);
  End
  Else If Supports(ASource, IBsvSubs, lSrc) Then
  Begin
    Clear();

    For X := 0 To lSrc.Count - 1 Do
      Add().Assign(lSrc[X]);

    FSubsImpl := lSrc;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Procedure TXmlBsvSubs.AssignTo(ATarget : IBsvSubs);
Begin

End;

Procedure TXmlBsvFileImpl.AfterConstruction();
Begin
  InHerited AfterConstruction();

  RegisterChildNode('Region', TXmlBsvImages);
  RegisterChildNode('Sub', TXmlBsvSubs);
  RegisterChildNode('Animation', TXmlBsvAnimations);

  FFileImpl := Pointer(IBsvFile(Self));
End;

Function TXmlBsvFileImpl.GetImplementor() : IBsvFile;
Begin
  Result := IBsvFile(FFileImpl);
End;

Procedure TXmlBsvFileImpl.Clear();
Begin
  ChildNodes['FileSig'].NodeValue             := Null;
  ChildNodes['RegionCount'].NodeValue         := Null;
  ChildNodes['HasOpacity'].NodeValue          := Null;
  ChildNodes['RgbFileName'].NodeValue         := Null;
  ChildNodes['Region'].NodeValue              := Null;
  ChildNodes['TransformationCount'].NodeValue := Null;
  ChildNodes['Sub'].NodeValue                 := Null;
  ChildNodes['AnimationCount'].NodeValue      := Null;
  ChildNodes['Animation'].NodeValue           := Null;
End;

Procedure TXmlBsvFileImpl.Assign(ASource : IInterface);
Var lXmlSrc : IXmlBsvFile;
    lSrc    : IBsvFile;
Begin
  If Supports(ASource, IXmlNodeEx) And
     Supports(ASource, IXmlBsvFile, lXmlSrc) Then
  Begin
    ChildNodes['FileSig'].NodeValue     := lXmlSrc.FileSig;
    ChildNodes['HasOpacity'].NodeValue  := lXmlSrc.HasOpacity;
    ChildNodes['RgbFileName'].NodeValue := lXmlSrc.RgbFileName;
    Region.Assign(lXmlSrc.Region);
    Sub.Assign(lXmlSrc.Sub);
    Animation.Assign(lXmlSrc.Animation);
  End
  Else If Supports(ASource, IBsvFile, lSrc) Then
  Begin
    ChildNodes['FileSig'].NodeValue     := lSrc.FileSig;
    ChildNodes['HasOpacity'].NodeValue  := lSrc.HasOpacity;
    ChildNodes['RgbFileName'].NodeValue := lSrc.RgbFileName;
    Region.Assign(lSrc.Region);
    Sub.Assign(lSrc.Sub);
    Animation.Assign(lSrc.Animation);

    FFileImpl := Pointer(lSrc);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TXmlBsvFileImpl.GetFileSig() : Word;
Begin
  Result := ChildNodes['FileSig'].AsInteger;
End;

Procedure TXmlBsvFileImpl.SetFileSig(Const AFileSig : Word);
Begin
  ChildNodes['FileSig'].AsInteger := AFileSig;
End;

Function TXmlBsvFileImpl.GetRegionCount() : Word;
Begin
  Result := Region.Count;
End;

Function TXmlBsvFileImpl.GetHasOpacity() : Byte;
Begin
  Result := ChildNodes['HasOpacity'].AsInteger;
End;

Procedure TXmlBsvFileImpl.SetHasOpacity(Const AHasOpacity : Byte);
Begin
  ChildNodes['HasOpacity'].AsInteger := AHasOpacity;
End;

Function TXmlBsvFileImpl.GetRgbFileName() : AnsiString;
Begin
  Result := ChildNodes['RgbFileName'].AsString;
End;

Procedure TXmlBsvFileImpl.SetRgbFileName(Const ARgbFileName : AnsiString);
Begin
  ChildNodes['RgbFileName'].AsString := ARgbFileName;
End;

Function TXmlBsvFileImpl.GetRegion() : IXmlBsvImages;
Begin
  Result := ChildNodes['Region'] As IXmlBsvImages;
End;

Function TXmlBsvFileImpl.GetIRegion() : IBsvImages;
Begin
  Result := GetRegion() As IBsvImages;
End;

Function TXmlBsvFileImpl.GetTransformationCount() : Word;
Begin
  Result := Sub.Count;
End;

Function TXmlBsvFileImpl.GetSub() : IXmlBsvSubs;
Begin
  Result := ChildNodes['Sub'] As IXmlBsvSubs;
End;

Function TXmlBsvFileImpl.GetISub() : IBsvSubs;
Begin
  Result := GetSub() As IBsvSubs;
End;

Function TXmlBsvFileImpl.GetAnimationCount() : Word;
Begin
  Result := Animation.Count;
End;

Function TXmlBsvFileImpl.GetAnimation() : IXmlBsvAnimations;
Begin
  Result := ChildNodes['Animation'] As IXmlBsvAnimations;
End;

Function TXmlBsvFileImpl.GetIAnimation() : IBsvAnimations;
Begin
  Result := GetAnimation() As IBsvAnimations;
End;

End.
