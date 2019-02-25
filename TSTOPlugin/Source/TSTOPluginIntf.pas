unit TSTOPluginIntf;

interface

Uses HsInterfaceEx, TSTOWorkspaceIntf;

Type
  ITSTOApplication = Interface(IInterfaceEx)
    ['{168D6848-663D-4EE2-9599-84B00AAC1ABC}']
    Function  GetWorkSpace() : ITSTOWorkSpaceProjectGroupIO;

    Property WorkSpace : ITSTOWorkSpaceProjectGroupIO Read GetWorkSpace;

  End;

  ITSTOPlugin = Interface(IInterfaceEx)
    ['{E20CF1A9-1302-4643-8715-7CE1FC87090B}']
    Procedure InitPlugin(AMainApplication : ITSTOApplication);

  End;

implementation

end.
