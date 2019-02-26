unit TSTOPluginIntf;

interface

{x$Define MainApp}

Uses JvPlugin, SptbxItem, HsInterfaceEx,
  {$IfDef MainApp}TSTOProjectWorkSpace.IO{$Else}TSTOWorkspaceIntf{$EndIf};

Type
  ITSTOApplication = Interface(IInterfaceEx)
    ['{168D6848-663D-4EE2-9599-84B00AAC1ABC}']
    Function GetWorkSpace() : ITSTOWorkSpaceProjectGroupIO;

    Procedure AddToolBarButton(Sender : TJvPlugin; AItem : TSpTbxItem);
    Procedure AddMenuItem(Sender : TJvPlugin; AItem : TSpTbxItem);
{
    Procedure RemoveToolBarButton(AItem : TSpTbxItem);
    Procedure AddMenuItem(AItem : TSpTbxItem);
    Procedure RemoveMenuItem(AItem : TSpTbxItem);
}
    Property WorkSpace  : ITSTOWorkSpaceProjectGroupIO Read GetWorkSpace;

  End;

  TTSTOPluginKind = (pkScript, pkGUI);

  ITSTOPlugin = Interface(IInterfaceEx)
    ['{E20CF1A9-1302-4643-8715-7CE1FC87090B}']
    Function  GetEnabled() : Boolean;
    Procedure SetEnabled(Const AEnabled : Boolean);

    Function  GetPluginKind() : TTSTOPluginKind;
    Procedure SetPluginKind(Const ATSTOPluginKind : TTSTOPluginKind);

    Procedure InitPlugin(AMainApplication : ITSTOApplication);

    Property Enabled    : Boolean         Read GetEnabled    Write SetEnabled;
    Property PluginKind : TTSTOPluginKind Read GetPluginKind Write SetPluginKind;

  End;

implementation

end.
