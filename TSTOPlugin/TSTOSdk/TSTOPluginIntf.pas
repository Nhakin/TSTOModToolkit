unit TSTOPluginIntf;

interface

Uses JvPlugin, TB2Item, SptbxItem, HsInterfaceEx, TSTOProjectWorkSpace.IO;

Type
  TUIItemKind = (iikToolBar, iikMainMenu);
  
  ITSTOApplication = Interface(IInterfaceEx)
    ['{168D6848-663D-4EE2-9599-84B00AAC1ABC}']
    Function GetWorkSpace() : ITSTOWorkSpaceProjectGroupIO;

    Procedure AddItem(AItemKind : TUIItemKind; Sender : TJvPlugin; AItem : TTBCustomItem);
    Procedure RemoveItem(AItemKind : TUIItemKind; Sender : TJvPlugin; AItem : TTBCustomItem);

    Property WorkSpace  : ITSTOWorkSpaceProjectGroupIO Read GetWorkSpace;

  End;

  TTSTOPluginKind = (pkScript, pkGUI);

  ITSTOPlugin = Interface(IInterfaceEx)
    ['{E20CF1A9-1302-4643-8715-7CE1FC87090B}']
    Function  GetInitialized() : Boolean;

    Function  GetEnabled() : Boolean;
    Procedure SetEnabled(Const AEnabled : Boolean);

    Function  GetPluginKind() : TTSTOPluginKind;

    Function  GetName() : String;
    Function  GetAuthor() : String;
    Function  GetCopyright() : String;
    Function  GetDescription() : String;
    Function  GetPluginId() : String;
    Function  GetPluginVersion() : String;

    Procedure Initialize(AMainApplication : ITSTOApplication);
    Procedure Finalize();

    Property Initialized : Boolean         Read GetInitialized;
    Property Enabled     : Boolean         Read GetEnabled    Write SetEnabled;
    Property PluginKind  : TTSTOPluginKind Read GetPluginKind;

    Property Name          : String Read GetName;
    Property Author        : String Read GetAuthor;
    Property Copyright     : String Read GetCopyright;
    Property Description   : String Read GetDescription;
    Property PluginId      : String Read GetPluginId;
    Property PluginVersion : String Read GetPluginVersion;

  End;

implementation

end.
