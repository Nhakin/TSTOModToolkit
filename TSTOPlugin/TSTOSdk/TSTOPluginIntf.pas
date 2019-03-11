unit TSTOPluginIntf;

interface

Uses Graphics, JvPlugin, TB2Item, HsInterfaceEx, TSTOProjectWorkSpace.IO;

Type
  TUIItemKind = (iikToolBar, iikMainMenu);
  
  ITSTOApplication = Interface(IInterfaceEx)
    ['{168D6848-663D-4EE2-9599-84B00AAC1ABC}']
    Function GetWorkSpace() : ITSTOWorkSpaceProjectGroupIO;
    Function GetCurrentSkinName() : String;
    Function GetIcon() : TIcon;
    
    Procedure AddItem(AItemKind : TUIItemKind; Sender : TJvPlugin; AItem : TTBCustomItem); OverLoad;
    Procedure AddItem(Sender : TJvPlugin; ASrcItem, ATrgItem : TTBCustomItem); OverLoad;
    Procedure RemoveItem(AItemKind : TUIItemKind; Sender : TJvPlugin; AItem : TTBCustomItem);

    Property WorkSpace       : ITSTOWorkSpaceProjectGroupIO Read GetWorkSpace;
    Property CurrentSkinName : String                       Read GetCurrentSkinName;
    Property Icon            : TIcon                        Read GetIcon;
    
  End;

  TTSTOPluginKind = (pkScript, pkPatches, pkGUI);

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
    Function  GetHaveSettings() : Boolean;

    Function  GetMainApp() : ITSTOApplication;
    Function  GetPluginPath() : String;
    Function  GetPluginFileName() : String;

    Procedure Initialize(AMainApplication : ITSTOApplication);
    Procedure Finalize();
    Function  ShowSettings() : Boolean;
    Function  Execute() : Integer;
    
    Property Initialized : Boolean         Read GetInitialized;
    Property Enabled     : Boolean         Read GetEnabled    Write SetEnabled;
    Property PluginKind  : TTSTOPluginKind Read GetPluginKind;

    Property Name            : String       Read GetName;
    Property Author          : String       Read GetAuthor;
    Property Copyright       : String       Read GetCopyright;
    Property Description     : String       Read GetDescription;
    Property PluginId        : String       Read GetPluginId;
    Property PluginVersion   : String       Read GetPluginVersion;
    Property HaveSettings    : Boolean      Read GetHaveSettings;

    Property MainApp        : ITSTOApplication Read GetMainApp;
    Property PluginPath     : String           Read GetPluginPath;
    Property PluginFileName : String           Read GetPluginFileName;

  End;

  ITSTOPlugins = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-858B-BB0F2B390FB5}']
    Function  Get(Index : Integer) : ITSTOPlugin;
    Procedure Put(Index : Integer; Const Item : ITSTOPlugin);

    Function Add(Const AItem : ITSTOPlugin) : Integer; OverLoad;

    Property Items[Index : Integer] : ITSTOPlugin Read Get Write Put; Default;

  End;

  TTSTOPlugins = Class(TObject)
  Public
    Class Function CreatePluginList() : ITSTOPlugins;
    
  End;
  
implementation

Type
  TTSTOPluginsImpl = Class(TInterfaceListEx, ITSTOPlugins)
  Protected
    Function  Get(Index : Integer) : ITSTOPlugin; OverLoad;
    Procedure Put(Index : Integer; Const Item : ITSTOPlugin); OverLoad;

    Function Add(Const AItem : ITSTOPlugin) : Integer; OverLoad;

  End;

Class Function TTSTOPlugins.CreatePluginList() : ITSTOPlugins;
Begin
  Result := TTSTOPluginsImpl.Create();
End;

Function TTSTOPluginsImpl.Get(Index : Integer) : ITSTOPlugin;
Begin
  Result := InHerited Items[Index] As ITSTOPlugin;
End;

Procedure TTSTOPluginsImpl.Put(Index : Integer; Const Item : ITSTOPlugin);
Begin
  InHerited Items[Index] := Item;
End;

Function TTSTOPluginsImpl.Add(Const AItem : ITSTOPlugin) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

end.
