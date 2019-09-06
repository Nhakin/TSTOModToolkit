unit RgbTools;

interface

Uses Windows;

Type
  TImageType = (itUnknown, itPng, itRGBA4444, itRGBA8888);

Const
  ImageTypeStr : Array[TImageType] Of String = (
    'Unknown', 'Png', 'RGBA4444', 'RGBA8888');

Function GetImageType(Const AFileName : String) : TImageType;

implementation

Uses Classes, SysUtils;

Function GetImageType(Const AFileName : String) : TImageType;
Const
  PngHeader  = $474E5089;
  Rgba4444_1 = $20000000;
  Rgba4444_2 = $60000000;
  Rgba8888   = $00000000;
Var lDWord : DWord;
Begin
  Result := itUnknown;
  If FileExists(AFileName) Then
    With TMemoryStream.Create() Do
    Try
      LoadFromFile(AFileName);
      ReadBuffer(lDWord, SizeOf(lDWord));
      Case lDWord Of
        PngHeader  : Result := itPng;
        Rgba4444_1 ,
        Rgba4444_2 : Result := itRGBA4444;
        Rgba8888   : Result := itRGBA8888;
        Else
          Result := itUnknown;
      End;

      Finally
        Free();
    End;
End;

end.
