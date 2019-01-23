unit TSTOProjectWorkSpaceIntfReg;

interface

implementation

Uses HsInterfaceEx,
  TSTOProjectWorkSpaceIntf, TSTOProjectWorkSpace.IO,
  TSTOProjectWorkSpace.Xml, TSTOProjectWorkSpace.Bin;

Initialization
  //TSTOProjectWorkSpaceIntf
  RegisterInterface('ITSTOWorkSpaceProjectGroup', ITSTOWorkSpaceProjectGroup);
  RegisterInterface('ITSTOWorkSpaceProject', ITSTOWorkSpaceProject);
  RegisterInterface('ITSTOWorkSpaceProjectSrcFolder', ITSTOWorkSpaceProjectSrcFolder);
  RegisterInterface('ITSTOWorkSpaceProjectSrcFolders', ITSTOWorkSpaceProjectSrcFolders);
  RegisterInterface('ITSTOWorkSpaceProjectSrcFile', ITSTOWorkSpaceProjectSrcFile);
  RegisterInterface('ITSTOWorkSpaceProjectSrcFiles', ITSTOWorkSpaceProjectSrcFiles);

  //TSTOProjectWorkSpace.IO
  RegisterInterface('ITSTOWorkSpaceProjectGroupIO', ITSTOWorkSpaceProjectGroupIO);

  //TSTOProjectWorkSpace.Xml
  RegisterInterface('IXmlTSTOWorkSpaceProjectSrcFolder', IXmlTSTOWorkSpaceProjectSrcFolder);
  RegisterInterface('IXmlTSTOWorkSpaceProjectSrcFolders', IXmlTSTOWorkSpaceProjectSrcFolders);
  RegisterInterface('IXmlTSTOWorkSpaceProject', IXmlTSTOWorkSpaceProject);
  RegisterInterface('IXmlTSTOWorkSpaceProjectGroup', IXmlTSTOWorkSpaceProjectGroup);

  //TSTOProjectWorkSpace.Bin
  RegisterInterface('IBinTSTOWorkSpaceProjectSrcFolder', IBinTSTOWorkSpaceProjectSrcFolder);
  RegisterInterface('IBinTSTOWorkSpaceProjectSrcFolders', IBinTSTOWorkSpaceProjectSrcFolders);
  RegisterInterface('IBinTSTOWorkSpaceProject', IBinTSTOWorkSpaceProject);
  RegisterInterface('IBinTSTOWorkSpaceProjectGroup', IBinTSTOWorkSpaceProjectGroup);

end.
