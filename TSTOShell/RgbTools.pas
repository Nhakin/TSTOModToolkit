unit RgbTools;

interface

Type
  TImageType = (itUnknown, itPng, itRGBA4444, itRGBA8888);

Function GetImageType(Const AFileName : String) : TImageType;

implementation

Function GetImageType(Const AFileName : String) : TImageType;
Const
  PngHeader = $474E5089;

Begin
  Result := itUnknown;
End;

end.
