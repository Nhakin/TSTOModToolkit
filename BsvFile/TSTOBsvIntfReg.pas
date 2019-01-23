unit TSTOBsvIntfReg;

interface

implementation

Uses HsInterfaceEx, TSTOBsvIntf, TSTOBsv.IO, TSTOBsv.Bin, TSTOBsv.Xml;

Initialization
  RegisterInterface('IBsvImage', IBsvImage);
  RegisterInterface('IBsvImages', IBsvImages);
  RegisterInterface('IBsvAnimation', IBsvAnimation);
  RegisterInterface('IBsvAnimations', IBsvAnimations);
  RegisterInterface('IBsvSubData', IBsvSubData);
  RegisterInterface('IBsvSubDatas', IBsvSubDatas);
  RegisterInterface('IBsvSub', IBsvSub);
  RegisterInterface('IBsvSubs', IBsvSubs);
  RegisterInterface('IBsvFile', IBsvFile);

  RegisterInterface('IBsvImageIO', IBsvImageIO);
  RegisterInterface('IBsvImagesIO', IBsvImagesIO);
  RegisterInterface('IBsvAnimationIO', IBsvAnimationIO);
  RegisterInterface('IBsvAnimationsIO', IBsvAnimationsIO);
  RegisterInterface('IBsvFileIO', IBsvFileIO);

  RegisterInterface('IBinBsvImage', IBinBsvImage);
  RegisterInterface('IBinBsvImages', IBinBsvImages);
  RegisterInterface('IBinBsvAnimation', IBinBsvAnimation);
  RegisterInterface('IBinBsvAnimations', IBinBsvAnimations);
  RegisterInterface('IBinBsvSubData', IBinBsvSubData);
  RegisterInterface('IBinBsvSubDatas', IBinBsvSubDatas);
  RegisterInterface('IBinBsvSub', IBinBsvSub);
  RegisterInterface('IBinBsvSubs', IBinBsvSubs);
  RegisterInterface('IBinBsvFile', IBinBsvFile);

  RegisterInterface('IXmlBsvImage', IXmlBsvImage);
  RegisterInterface('IXmlBsvImages', IXmlBsvImages);
  RegisterInterface('IXmlBsvAnimation', IXmlBsvAnimation);
  RegisterInterface('IXmlBsvAnimations', IXmlBsvAnimations);
  RegisterInterface('IXmlBsvSubData', IXmlBsvSubData);
  RegisterInterface('IXmlBsvSubDatas', IXmlBsvSubDatas);
  RegisterInterface('IXmlBsvSub', IXmlBsvSub);
  RegisterInterface('IXmlBsvSubs', IXmlBsvSubs);
  RegisterInterface('IXmlBsvFile', IXmlBsvFile);

end.
