unit TSTOBsvIntf;

Interface

Uses Windows, Classes, SysUtils, HsInterfaceEx;

Type
  IBsvImage = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-9D7D-C3CE63792EF6}']
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

  IBsvImages = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-BFFE-4785853D114C}']
    Function  Get(Index : Integer) : IBsvImage;
    Procedure Put(Index : Integer; Const Item : IBsvImage);

    Function Add() : IBsvImage; OverLoad;
    Function Add(Const AItem : IBsvImage) : Integer; OverLoad;

    Procedure Assign(ASource : IInterface);

    Property Items[Index : Integer] : IBsvImage Read Get Write Put; Default;

  End;

  IBsvAnimation = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-AD8D-F588C303F301}']
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

  IBsvAnimations = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-A614-B2290352E7C1}']
    Function  Get(Index : Integer) : IBsvAnimation;
    Procedure Put(Index : Integer; Const Item : IBsvAnimation);

    Function Add() : IBsvAnimation; OverLoad;
    Function Add(Const AItem : IBsvAnimation) : Integer; OverLoad;

    Procedure Assign(ASource : IInterface);

    Property Items[Index : Integer] : IBsvAnimation Read Get Write Put; Default;

  End;

  IBsvSubData = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-B17B-85476FFF980A}']
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

  IBsvSubDatas = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-B64A-10D1ACC3736C}']
    Function  Get(Index : Integer) : IBsvSubData;
    Procedure Put(Index : Integer; Const Item : IBsvSubData);

    Function Add() : IBsvSubData; OverLoad;
    Function Add(Const AItem : IBsvSubData) : Integer; OverLoad;

    Procedure Assign(ASource : IInterface);

    Property Items[Index : Integer] : IBsvSubData Read Get Write Put; Default;

  End;

  IBsvSub = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-AC6E-337FF1A39E13}']
    Function  GetSubCount() : Word;

    Function  GetSubLen() : Byte;
    Procedure SetSubLen(Const ASubLen : Byte);

    Function  GetSubData() : IBsvSubDatas;

    Procedure Assign(ASource : IInterface);

    Property SubCount : Word         Read GetSubCount;
    Property SubLen   : Byte         Read GetSubLen   Write SetSubLen;
    Property SubData  : IBsvSubDatas Read GetSubData;

  End;

  IBsvSubs = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-AAFD-987E3BEDDAF0}']
    Function  Get(Index : Integer) : IBsvSub;
    Procedure Put(Index : Integer; Const Item : IBsvSub);

    Function Add() : IBsvSub; OverLoad;
    Function Add(Const AItem : IBsvSub) : Integer; OverLoad;

    Procedure Assign(ASource : IInterface);

    Property Items[Index : Integer] : IBsvSub Read Get Write Put; Default;

  End;  
  
  IBsvFile = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-9CF9-C13414D17FDA}']
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

  End;

(******************************************************************************)

  TBsvFile = Class(TObject)
  Public
    Class Function CreateBsvFile() : IBsvFile;
    Class Function CreateBsvImages() : IBsvImages;
    Class Function CreateBsvAnimations() : IBsvAnimations;
    Class Function CreateBsvSubDatas() : IBsvSubDatas;
    Class Function CreateBsvSubs() : IBsvSubs;

  End;

Implementation

Uses TSTOBsvImpl;

Class Function TBsvFile.CreateBsvFile() : IBsvFile;
Begin
  Result := TSTOBsvImpl.TBsvFile.Create();
End;

Class Function TBsvFile.CreateBsvImages() : IBsvImages;
Begin
  Result := TSTOBsvImpl.TBsvImages.Create();
End;

Class Function TBsvFile.CreateBsvAnimations() : IBsvAnimations;
Begin
  Result := TSTOBsvImpl.TBsvAnimations.Create();
End;

Class Function TBsvFile.CreateBsvSubDatas() : IBsvSubDatas;
Begin
  Result := TSTOBsvImpl.TBsvSubDatas.Create();
End;

Class Function TBsvFile.CreateBsvSubs() : IBsvSubs;
Begin
  Result := TSTOBsvImpl.TBsvSubs.Create();
End;

End.
