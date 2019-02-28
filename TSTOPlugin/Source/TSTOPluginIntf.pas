unit TSTOPluginIntf;

interface

{x$Define MainApp}

Uses JvPlugin, TB2Item, SptbxItem, HsInterfaceEx, TSTOProjectWorkSpace.IO;

Type
  ITSTOApplication = Interface(IInterfaceEx)
    ['{168D6848-663D-4EE2-9599-84B00AAC1ABC}']
    Function GetWorkSpace() : ITSTOWorkSpaceProjectGroupIO;

    Procedure AddToolBarButton(Sender : TJvPlugin; AItem : TSpTbxItem);
    Procedure AddToolBarDropDownButton(Sender : TJvPlugin; AItem : TSpTBXSubmenuItem);
    Procedure AddGroupToolBarItem(Sender : TJvPlugin; AItem : TSpTBXTBGroupItem);
    Procedure AddToolBarSeparatorItem(Sender : TJvPlugin);

    Procedure AddMenuItem(Sender : TJvPlugin; AItem : TSpTbxItem);
    Procedure AddSubMenuItem(Sender : TJvPlugin; AItem : TSpTBXSubmenuItem);
    Procedure AddGroupMenuItem(Sender : TJvPlugin; AItem : TSpTBXTBGroupItem);
    Procedure AddMenuSeparatorItem(Sender : TJvPlugin);

    Procedure RemoveToolBarItem(Sender : TJvPlugin; AItem : TTBCustomItem);
    Procedure RemoveMenuItem(Sender : TJvPlugin; AItem : TTBCustomItem);

    Property WorkSpace  : ITSTOWorkSpaceProjectGroupIO Read GetWorkSpace;

  End;

  TTSTOPluginKind = (pkScript, pkGUI);

  ITSTOPlugin = Interface(IInterfaceEx)
    ['{E20CF1A9-1302-4643-8715-7CE1FC87090B}']
    Function  GetInitialized() : Boolean;

    Function  GetEnabled() : Boolean;
    Procedure SetEnabled(Const AEnabled : Boolean);

    Function  GetPluginKind() : TTSTOPluginKind;
    Procedure SetPluginKind(Const ATSTOPluginKind : TTSTOPluginKind);

    Procedure Initialize(AMainApplication : ITSTOApplication);
    Procedure Finalize();

    Property Initialized : Boolean         Read GetInitialized;
    Property Enabled     : Boolean         Read GetEnabled    Write SetEnabled;
    Property PluginKind  : TTSTOPluginKind Read GetPluginKind Write SetPluginKind;

  End;

implementation

end.
