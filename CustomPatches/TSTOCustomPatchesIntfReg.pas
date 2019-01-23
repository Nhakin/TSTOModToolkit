unit TSTOCustomPatchesIntfReg;

interface

implementation

Uses
  HsInterfaceEx, TSTOCustomPatchesIntf, TSTOCustomPatches.Xml;

Initialization
  //TSTOCustomPatchesIntf
  RegisterInterface('ITSTOPatchData', ITSTOPatchData);
  RegisterInterface('ITSTOPatchDatas', ITSTOPatchDatas);
  RegisterInterface('ITSTOCustomPatch', ITSTOCustomPatch);
  RegisterInterface('ITSTOCustomPatchList', ITSTOCustomPatchList);
  RegisterInterface('ITSTOCustomPatches', ITSTOCustomPatches);

  //TSTOCustomPatches.Xml
  RegisterInterface('ITSTOXmlPatchData', ITSTOXmlPatchData);
  RegisterInterface('ITSTOXmlPatchDataList', ITSTOXmlPatchDataList);
  RegisterInterface('ITSTOXMLCustomPatch', ITSTOXMLCustomPatch);
  RegisterInterface('ITSTOXmlPatches', ITSTOXmlPatches);
  RegisterInterface('ITSTOXmlCustomPatches', ITSTOXmlCustomPatches);

end.
