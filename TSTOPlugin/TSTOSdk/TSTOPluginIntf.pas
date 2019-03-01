unit TSTOPluginIntf;

interface

Uses JvPlugin, TB2Item, HsInterfaceEx,
  TSTOProjectWorkSpace.IO, TSTOCustomPatches.IO, TSTOScriptTemplate.IO;

Type
  TUIItemKind = (iikToolBar, iikMainMenu);
  
  ITSTOApplication = Interface(IInterfaceEx)
    ['{168D6848-663D-4EE2-9599-84B00AAC1ABC}']
    Function GetWorkSpace() : ITSTOWorkSpaceProjectGroupIO;

    Procedure AddItem(AItemKind : TUIItemKind; Sender : TJvPlugin; AItem : TTBCustomItem);
    Procedure RemoveItem(AItemKind : TUIItemKind; Sender : TJvPlugin; AItem : TTBCustomItem);

    Property WorkSpace  : ITSTOWorkSpaceProjectGroupIO Read GetWorkSpace;

  End;

  TTSTOPluginKind = (pkScript, pkPatches, pkGUI);

  ITSTOPlugin = Interface(IInterfaceEx)
    ['{E20CF1A9-1302-4643-8715-7CE1FC87090B}']
    Function  GetInitialized() : Boolean;

    Function  GetEnabled() : Boolean;
    Procedure SetEnabled(Const AEnabled : Boolean);

    Function  GetPluginKind() : TTSTOPluginKind;

    Procedure Initialize(AMainApplication : ITSTOApplication);
    Procedure Finalize();

    Function GetAuthor() : String;
    Function GetCopyRight() : String;
    Function GetDescription() : String;
    Function GetPluginId() : String;
    Function GetPluginVersion() : String;

    Property Initialized : Boolean         Read GetInitialized;
    Property Enabled     : Boolean         Read GetEnabled    Write SetEnabled;
    Property PluginKind  : TTSTOPluginKind Read GetPluginKind;

    Property Author        : String Read GetAuthor;
    Property CopyRight     : String Read GetCopyRight;
    Property Description   : String Read GetDescription;
    Property PluginId      : String Read GetPluginId;
    Property PluginVersion : String Read GetPluginVersion;

  End;

  ITSTOPluginManager = Interface(ITSTOPlugin)
    ['{17FD91FF-4DD0-4E73-8AE5-B903D70F8747}']
    Function  GetCustomPatchesPlugins() : ITSTOCustomPatchesIO;
    Function  GetScriptsTemplatePlugins() : ITSTOScriptTemplateHacksIO;

    Property CustomPatchesPlugins   : ITSTOCustomPatchesIO       Read GetCustomPatchesPlugins;
    Property ScriptsTemplatePlugins : ITSTOScriptTemplateHacksIO Read GetScriptsTemplatePlugins;

  End;

implementation

end.
