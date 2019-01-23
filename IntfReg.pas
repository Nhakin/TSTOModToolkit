unit IntfReg;

interface

implementation

Uses
  XmlIntf, XmlDoc, HsInterfaceEx;

Initialization
  RegisterInterface('IXmlNode', IXmlNode);
  RegisterInterface('IXmlNodeAccess', IXMLNodeAccess);
  
end.
