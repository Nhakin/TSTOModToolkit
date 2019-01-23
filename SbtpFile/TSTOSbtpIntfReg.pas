unit TSTOSbtpIntfReg;

interface

implementation

Uses HsInterfaceEx, TSTOSbtpIntf,
  TSTOSbtp.IO, TSTOSbtp.Bin, TSTOSbtp.Xml, TSTOSbtpEx.JSon;

Initialization
  //TSTOSbtpIntf
  RegisterInterface('ISbtpSubVariable', ISbtpSubVariable);
  RegisterInterface('ISbtpSubVariables', ISbtpSubVariables);
  RegisterInterface('ISbtpVariable', ISbtpVariable);
  RegisterInterface('ISbtpVariables', ISbtpVariables);
  RegisterInterface('ISbtpHeader', ISbtpHeader);
  RegisterInterface('ISbtpFile', ISbtpFile);
  RegisterInterface('ISbtpFiles', ISbtpFiles);

  //TSTOSbtp.IO
  RegisterInterface('ISbtpFileIO', ISbtpFileIO);
  RegisterInterface('ISbtpFilesIO', ISbtpFilesIO);

  //TSTOSbtp.Bin
  RegisterInterface('IBinSbtpSubVariable', IBinSbtpSubVariable);
  RegisterInterface('IBinSbtpSubVariables', IBinSbtpSubVariables);
  RegisterInterface('IBinSbtpVariable', IBinSbtpVariable);
  RegisterInterface('IBinSbtpVariables', IBinSbtpVariables);
  RegisterInterface('IBinSbtpHeader', IBinSbtpHeader);
  RegisterInterface('IBinSbtpFile', IBinSbtpFile);
  RegisterInterface('IBinSbtpFiles', IBinSbtpFiles);

  //TSTOSbtp.Xml
  RegisterInterface('IXmlSbtpSubVariable', IXmlSbtpSubVariable);
  RegisterInterface('IXmlSbtpSubVariables', IXmlSbtpSubVariables);
  RegisterInterface('IXmlSbtpVariable', IXmlSbtpVariable);
  RegisterInterface('IXmlSbtpVariables', IXmlSbtpVariables);
  RegisterInterface('IXmlSbtpHeader', IXmlSbtpHeader);
  RegisterInterface('IXmlSbtpFile', IXmlSbtpFile);
  RegisterInterface('IXmlSbtpFiles', IXmlSbtpFiles);

  //TSTOSbtp.JSon
  RegisterInterface('IJSonSbtpSubVariable', IJSonSbtpSubVariable);
  RegisterInterface('IJSonSbtpSubVariables', IJSonSbtpSubVariables);
  RegisterInterface('IJSonSbtpVariable', IJSonSbtpVariable);
  RegisterInterface('IJSonSbtpVariables', IJSonSbtpVariables);
  RegisterInterface('IJSonSbtpHeader', IJSonSbtpHeader);
  RegisterInterface('IJSonSbtpFile', IJSonSbtpFile);
  
end.
