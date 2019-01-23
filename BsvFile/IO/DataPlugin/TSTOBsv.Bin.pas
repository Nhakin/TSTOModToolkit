unit TSTOBsv.Bin;

Interface

Uses
  Classes, SysUtils, HsStreamEx, TSTOBsvIntf;

Type
  IBinBsvImage = Interface(IBsvImage)
    ['{4B61686E-29A0-2112-85CC-80DC1067203C}']
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

  End;

  IBinBsvImages = Interface(IBsvImages)
    ['{4B61686E-29A0-2112-BD3F-6D214A1CDC11}']
    Function  Get(Index : Integer) : IBinBsvImage;
    Procedure Put(Index : Integer; Const Item : IBinBsvImage);

    Function Add() : IBinBsvImage; OverLoad;
    Function Add(Const AItem : IBinBsvImage) : Integer; OverLoad;

    Property Items[Index : Integer] : IBinBsvImage Read Get Write Put; Default;

  End;

  IBinBsvAnimation = Interface(IBsvAnimation)
    ['{4B61686E-29A0-2112-9833-8B8623565D93}']
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

  End;

  IBinBsvAnimations = Interface(IBsvAnimations)
    ['{4B61686E-29A0-2112-A281-F7434B6EDCD9}']
    Function  Get(Index : Integer) : IBinBsvAnimation;
    Procedure Put(Index : Integer; Const Item : IBinBsvAnimation);

    Function Add() : IBinBsvAnimation; OverLoad;
    Function Add(Const AItem : IBinBsvAnimation) : Integer; OverLoad;

    Property Items[Index : Integer] : IBinBsvAnimation Read Get Write Put; Default;

  End;

  IBinBsvSubData = Interface(IBsvSubData)
    ['{4B61686E-29A0-2112-ACAE-6E216546B61D}']
    Procedure LoadFromStream(ASource : IStreamEx; Const AReadOpacity : Boolean);
    Procedure SaveToStream(ATarget : IStreamEx; Const AWriteOpacity : Boolean);

  End;

  IBinBsvSubDatas = Interface(IBsvSubDatas)
    ['{4B61686E-29A0-2112-BEA0-D799811A2036}']
    Function  Get(Index : Integer) : IBinBsvSubData;
    Procedure Put(Index : Integer; Const Item : IBinBsvSubData);

    Function Add() : IBinBsvSubData; OverLoad;
    Function Add(Const AItem : IBinBsvSubData) : Integer; OverLoad;

    Property Items[Index : Integer] : IBinBsvSubData Read Get Write Put; Default;

  End;

  IBinBsvSub = Interface(IBsvSub)
    ['{4B61686E-29A0-2112-8EA6-DA02EB5A942F}']
    Procedure LoadFromStream(ASource : IStreamEx; Const AReadOpacity : Boolean);
    Procedure SaveToStream(ATarget : IStreamEx; Const AWriteOpacity : Boolean);

    Function  GetSubData() : IBinBsvSubDatas;

    Property SubData : IBinBsvSubDatas Read GetSubData;

  End;

  IBinBsvSubs = Interface(IBsvSubs)
    ['{4B61686E-29A0-2112-AFD7-E7B37E76E76A}']
    Function  Get(Index : Integer) : IBinBsvSub;
    Procedure Put(Index : Integer; Const Item : IBinBsvSub);

    Function Add() : IBinBsvSub; OverLoad;
    Function Add(Const AItem : IBinBsvSub) : Integer; OverLoad;

    Property Items[Index : Integer] : IBinBsvSub Read Get Write Put; Default;

  End;

  IBinBsvFile = Interface(IBsvFile)
    ['{4B61686E-29A0-2112-9F36-3ED5322257F5}']
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Function  GetRegion() : IBinBsvImages;
    Function  GetSub() : IBinBsvSubs;
    Function  GetAnimation() : IBinBsvAnimations;

    Property Region              : IBinBsvImages     Read GetRegion;
    Property Sub                 : IBinBsvSubs       Read GetSub;
    Property Animation           : IBinBsvAnimations Read GetAnimation;

  End;

(******************************************************************************)

  TBinBsvFile = Class(TObject)
  Public
    Class Function CreateBsvFile() : IBinBsvFile; OverLoad;
    Class Function CreateBsvFile(AStream : IStreamEx) : IBinBsvFile; OverLoad;

  End;

Implementation

Uses HsInterfaceEx, TSTOBsvImpl;

Type
  TBinBsvImage = Class(TBsvImage, IBinBsvImage)
  Protected
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

  End;

  TBinBsvImages = Class(TBsvImages, IBinBsvImages)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : IBinBsvImage; OverLoad;
    Procedure Put(Index : Integer; Const Item : IBinBsvImage); OverLoad;

    Function Add() : IBinBsvImage; OverLoad;
    Function Add(Const AItem : IBinBsvImage) : Integer; OverLoad;

  End;

  TBinBsvAnimation = Class(TBsvAnimation, IBinBsvAnimation)
  Protected
    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

  End;

  TBinBsvAnimations = Class(TBsvAnimations, IBinBsvAnimations)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : IBinBsvAnimation; OverLoad;
    Procedure Put(Index : Integer; Const Item : IBinBsvAnimation); OverLoad;

    Function Add() : IBinBsvAnimation; OverLoad;
    Function Add(Const AItem : IBinBsvAnimation) : Integer; OverLoad;

  End;

  TBinBsvSubData = Class(TBsvSubData, IBinBsvSubData)
  Protected
    Procedure LoadFromStream(ASource : IStreamEx; Const AReadOpacity : Boolean);
    Procedure SaveToStream(ATarget : IStreamEx; Const AWriteOpacity : Boolean);

  End;

  TBinBsvSubDatas = Class(TBsvSubDatas, IBinBsvSubDatas)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : IBinBsvSubData; OverLoad;
    Procedure Put(Index : Integer; Const Item : IBinBsvSubData); OverLoad;

    Function Add() : IBinBsvSubData; OverLoad;
    Function Add(Const AItem : IBinBsvSubData) : Integer; OverLoad;

  End;

  TBinBsvSub = Class(TBsvSub, IBinBsvSub)
  Protected
    Function GetSubDataClass() : TBsvSubDatasClass; OverRide;

    Function  GetSubData() : IBinBsvSubDatas; OverLoad;

    Procedure LoadFromStream(ASource : IStreamEx; Const AReadOpacity : Boolean);
    Procedure SaveToStream(ATarget : IStreamEx; Const AWriteOpacity : Boolean);

    Property SubData  : IBinBsvSubDatas Read GetSubData;

  End;

  TBinBsvSubs = Class(TBsvSubs, IBinBsvSubs)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : IBinBsvSub; OverLoad;
    Procedure Put(Index : Integer; Const Item : IBinBsvSub); OverLoad;

    Function Add() : IBinBsvSub; OverLoad;
    Function Add(Const AItem : IBinBsvSub) : Integer; OverLoad;

  End;

  TBinBsvFileImpl = Class(TBsvFile, IBinBsvFile)
  Protected
    Function GetImagesClass() : TBsvImagesClass; OverRide;
    Function GetSubsClass() : TBsvSubsClass; OverRide;
    Function GetAnimationsClass() : TBsvAnimationsClass; OverRide;

    Function  GetRegion() : IBinBsvImages; OverLoad;
    Function  GetSub() : IBinBsvSubs; OverLoad;
    Function  GetAnimation() : IBinBsvAnimations; OverLoad;

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Property Region    : IBinBsvImages     Read GetRegion;
    Property Sub       : IBinBsvSubs       Read GetSub;
    Property Animation : IBinBsvAnimations Read GetAnimation;

  End;

Class Function TBinBsvFile.CreateBsvFile() : IBinBsvFile;
Begin
  Result := TBinBsvFileImpl.Create();
End;

Class Function TBinBsvFile.CreateBsvFile(AStream : IStreamEx) : IBinBsvFile;
Begin
  Result := CreateBsvFile();
  Result.LoadFromStream(AStream);
End;

(******************************************************************************)

Procedure TBinBsvImage.LoadFromStream(ASource : IStreamEx);
Begin
  ImageName := ASource.ReadAnsiString(ASource.ReadByte()-1);
  ASource.ReadByte();
  X      := ASource.ReadWord();
  Y      := ASource.ReadWord();
  Width  := ASource.ReadWord();
  Height := ASource.ReadWord();
End;

Procedure TBinBsvImage.SaveToStream(ATarget : IStreamEx);
Begin
  ATarget.WriteByte(Length(ImageName)+1);
  ATarget.WriteAnsiString(ImageName, False);
  ATarget.WriteByte(0);
  ATarget.WriteWord(X);
  ATarget.WriteWord(Y);
  ATarget.WriteWord(Width);
  ATarget.WriteWord(Height);
End;

Function TBinBsvImages.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TBinBsvImage;
End;

Function TBinBsvImages.Get(Index : Integer) : IBinBsvImage;
Begin
  Result := InHerited Items[Index] As IBinBsvImage;
End;

Procedure TBinBsvImages.Put(Index : Integer; Const Item : IBinBsvImage);
Begin
  InHerited Items[Index] := Item;
End;

Function TBinBsvImages.Add() : IBinBsvImage;
Begin
  Result := InHerited Add() As IBinBsvImage;
End;

Function TBinBsvImages.Add(Const AItem : IBinBsvImage) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Procedure TBinBsvAnimation.LoadFromStream(ASource : IStreamEx);
Begin
  AnimationName := ASource.ReadAnsiString(ASource.ReadByte() - 1);
  ASource.ReadByte();
  StartFrame := ASource.ReadWord();
  EndFrame   := ASource.ReadWord();
End;

Procedure TBinBsvAnimation.SaveToStream(ATarget : IStreamEx);
Begin
  ATarget.WriteByte(Length(AnimationName)+1);
  ATarget.WriteAnsiString(AnimationName, False);
  ATarget.WriteByte(0);
  ATarget.WriteWord(StartFrame);
  ATarget.WriteWord(EndFrame);
End;

Function TBinBsvAnimations.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TBinBsvAnimation;
End;

Function TBinBsvAnimations.Get(Index : Integer) : IBinBsvAnimation;
Begin
  Result := InHerited Items[Index] As IBinBsvAnimation;
End;

Procedure TBinBsvAnimations.Put(Index : Integer; Const Item : IBinBsvAnimation);
Begin
  InHerited Items[Index] := Item;
End;

Function TBinBsvAnimations.Add() : IBinBsvAnimation;
Begin
  Result := InHerited Add() As IBinBsvAnimation;
End;

Function TBinBsvAnimations.Add(Const AItem : IBinBsvAnimation) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Procedure TBinBsvSubData.LoadFromStream(ASource : IStreamEx; Const AReadOpacity : Boolean);
Begin
  ImageId := ASource.ReadWord();
  X       := ASource.ReadSingle();
  Y       := ASource.ReadSingle();
  XScale  := ASource.ReadSingle();
  Skew_H  := ASource.ReadSingle();
  Skew_V  := ASource.ReadSingle();
  YScale  := ASource.ReadSingle();

  If AReadOpacity Then
    Opacity := ASource.ReadByte
  Else
    Opacity := $FF;
End;

Procedure TBinBsvSubData.SaveToStream(ATarget : IStreamEx; Const AWriteOpacity : Boolean);
Begin
  ATarget.WriteWord(ImageId);
  ATarget.WriteSingle(X);
  ATarget.WriteSingle(Y);
  ATarget.WriteSingle(XScale);
  ATarget.WriteSingle(Skew_H);
  ATarget.WriteSingle(Skew_V);
  ATarget.WriteSingle(YScale);

  If AWriteOpacity Then
    ATarget.WriteByte(Opacity);
End;

Function TBinBsvSubDatas.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TBinBsvSubData;
End;

Function TBinBsvSubDatas.Get(Index : Integer) : IBinBsvSubData;
Begin
  Result := InHerited Items[Index] As IBinBsvSubData;
End;

Procedure TBinBsvSubDatas.Put(Index : Integer; Const Item : IBinBsvSubData);
Begin
  InHerited Items[Index] := Item;
End;

Function TBinBsvSubDatas.Add() : IBinBsvSubData;
Begin
  Result := InHerited Add() As IBinBsvSubData;
End;

Function TBinBsvSubDatas.Add(Const AItem : IBinBsvSubData) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Function TBinBsvSub.GetSubDataClass() : TBsvSubDatasClass;
Begin
  Result := TBinBsvSubDatas;
End;

Function TBinBsvSub.GetSubData() : IBinBsvSubDatas;
Begin
  Result := InHerited GetSubData() As IBinBsvSubDatas;
End;

Procedure TBinBsvSub.LoadFromStream(ASource : IStreamEx; Const AReadOpacity : Boolean);
Var lWord : Word;
Begin
  lWord  := ASource.ReadWord();
  SubLen := ASource.ReadByte();

  While lWord > 0 Do
  Begin
    SubData.Add().LoadFromStream(ASource, AReadOpacity);
    Dec(lWord);
  End;
End;

Procedure TBinBsvSub.SaveToStream(ATarget : IStreamEx; Const AWriteOpacity : Boolean);
Var X : Integer;
Begin
  ATarget.WriteWord(SubCount);
  ATarget.WriteByte(SubLen);
  For X := 0 To SubCount - 1 Do
    SubData[X].SaveToStream(ATarget, AWriteOpacity);
End;

Function TBinBsvSubs.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TBinBsvSub;
End;

Function TBinBsvSubs.Get(Index : Integer) : IBinBsvSub;
Begin
  Result := InHerited Items[Index] As IBinBsvSub;
End;

Procedure TBinBsvSubs.Put(Index : Integer; Const Item : IBinBsvSub);
Begin
  InHerited Items[Index] := Item;
End;

Function TBinBsvSubs.Add() : IBinBsvSub;
Begin
  Result := InHerited Add() As IBinBsvSub;
End;

Function TBinBsvSubs.Add(Const AItem : IBinBsvSub) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Function TBinBsvFileImpl.GetImagesClass() : TBsvImagesClass;
Begin
  Result := TBinBsvImages;
End;

Function TBinBsvFileImpl.GetSubsClass() : TBsvSubsClass;
Begin
  Result := TBinBsvSubs;
End;

Function TBinBsvFileImpl.GetAnimationsClass() : TBsvAnimationsClass;
Begin
  Result := TBinBsvAnimations;
End;

Procedure TBinBsvFileImpl.LoadFromStream(ASource : IStreamEx);
Var lWord : Word;
Begin
  FileSig    := ASource.ReadWord();
  lWord      := ASource.ReadWord();
  HasOpacity := ASource.ReadByte();

  If FileSig = 515 Then
  Begin
    RgbFileName := ASource.ReadAnsiString(ASource.ReadByte() - 1);
    ASource.ReadByte();
  End;

  While lWord > 0 Do
  Begin
    Region.Add().LoadFromStream(ASource);
    Dec(lWord);
  End;

  lWord := ASource.ReadWord();
  While lWord > 0 Do
  Begin
    Sub.Add().LoadFromStream(ASource, HasOpacity = 1);
    Dec(lWord);
  End;

  lWord := ASource.ReadWord();
  While lWord > 0 Do
  Begin
    Animation.Add().LoadFromStream(ASource);
    Dec(lWord)
  End;
End;

Procedure TBinBsvFileImpl.SaveToStream(ATarget : IStreamEx);
Var X : Integer;
Begin
  ATarget.WriteWord(FileSig);
  ATarget.WriteWord(RegionCount);
  ATarget.WriteByte(HasOpacity);
  ATarget.WriteByte(Length(RgbFileName)+1);
  ATarget.WriteAnsiString(RgbFileName, False);
  ATarget.WriteByte(0);

  For X := 0 To RegionCount Do
    Region[X].SaveToStream(ATarget);
  ATarget.WriteWord(TransformationCount);
  For X := 0 To TransformationCount Do
    Sub[X].SaveToStream(ATarget, HasOpacity = 1);
  ATarget.WriteWord(AnimationCount);
  For X := 0 To AnimationCount Do
    Animation[X].SaveToStream(ATarget);
End;

Function TBinBsvFileImpl.GetRegion() : IBinBsvImages;
Begin
  Result := InHerited GetRegion() As IBinBsvImages;
End;

Function TBinBsvFileImpl.GetSub() : IBinBsvSubs;
Begin
  Result := InHerited GetSub() As IBinBsvSubs;
End;

Function TBinBsvFileImpl.GetAnimation() : IBinBsvAnimations;
Begin
  Result := InHerited GetAnimation() As IBinBsvAnimations;
End;

End.
