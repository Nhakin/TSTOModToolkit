Unit PlugInTSTOPluginDemo;

Interface

Uses
  Windows, Messages, SysUtils, Classes, Dialogs, Forms, Controls,
  JvPlugin, HsInterfaceEx, TSTOPluginIntf, System.ImageList, Vcl.ImgList,
  TB2Item, SpTBXItem;

Type
  TTSTOPluginDemo = Class(TJvPlugIn, ITSTOPlugin)
    SpTBXBItemContainer1: TSpTBXBItemContainer;
    SpTbxPluginDemo: TSpTBXItem;
    ilMain: TImageList;
    SpTbxSubMenu: TSpTBXSubmenuItem;
    SpTbxStop: TSpTBXItem;
    SpTbxPlay: TSpTBXItem;
    SpTBXSeparatorItem1: TSpTBXSeparatorItem;
    SpTbxChildSubMenu: TSpTBXSubmenuItem;
    SpTbxPlayAnimation: TSpTBXItem;
    SpTBXSeparatorItem2: TSpTBXSeparatorItem;
    SpTbxStopAnimation: TSpTBXItem;
    GrpPluginDemoItems: TSpTBXTBGroupItem;
    SpTBXGrpSingleItem: TSpTBXItem;
    SpTbxGrpSubMenu: TSpTBXSubmenuItem;
    SpTBXGrpSubItem2: TSpTBXItem;
    SpTBXGrpSubItem1: TSpTBXItem;
    GrpPluginDemo: TSpTBXTBGroupItem;

    procedure JvPlugInCreate(Sender: TObject);
    Procedure JvPlugInDestroy(Sender : TObject);
    procedure SpTbxPluginDemoClick(Sender: TObject);
    procedure JvPlugInConfigure(Sender: TObject);
    procedure SpTbxPlayClick(Sender: TObject);
    procedure SpTbxStopClick(Sender: TObject);

  Private
    FIntfImpl       : TInterfaceExImplementor;
    FMainApp        : ITSTOApplication;
    FPluginPath     : String;
    FPluginFileName : String;
    FInitialized    : Boolean;

    FPluginSettings : Record
      Enabled    : Boolean;
      PluginKind : TTSTOPluginKind;
    End;

    Function GetIntfImpl() : TInterfaceExImplementor;

  Protected
    Property IntfImpl: TInterfaceExImplementor Read GetIntfImpl Implements ITSTOPlugin;

    //ITSTOPlugin
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

  Public

  End;

Function RegisterPlugin() : TTSTOPluginDemo; StdCall;

Implementation

{$R *.dfm}

Uses 
  IniFiles;

Function RegisterPlugin() : TTSTOPluginDemo;
Begin
  Result := TTSTOPluginDemo.Create(nil);
End;

Function TTSTOPluginDemo.GetIntfImpl() : TInterfaceExImplementor;
Begin
  If Not Assigned(FIntfImpl) Then
    FIntfImpl := TInterfaceExImplementor.Create(Self, False);
  Result := FIntfImpl;
End;

Function TTSTOPluginDemo.GetInitialized() : Boolean;
Begin
  Result := FInitialized;
End;

Function TTSTOPluginDemo.GetEnabled() : Boolean;
Begin
  Result := FPluginSettings.Enabled;
End;

Procedure TTSTOPluginDemo.SetEnabled(Const AEnabled : Boolean);
Begin
  FPluginSettings.Enabled := AEnabled;
End;

Function TTSTOPluginDemo.GetPluginKind() : TTSTOPluginKind;
Begin
  Result := FPluginSettings.PluginKind;
End;

Function TTSTOPluginDemo.GetName() : String;
Begin
  Result := Self.Name;
End;

Function TTSTOPluginDemo.GetAuthor() : String;
Begin
  Result := Self.Author;
End;

Function TTSTOPluginDemo.GetCopyright() : String;
Begin
  Result := Self.Copyright;
End;

Function TTSTOPluginDemo.GetDescription() : String;
Begin
  Result := Self.Description;
End;

Function TTSTOPluginDemo.GetPluginId() : String;
Begin
  Result := Self.PluginID;
End;

Function TTSTOPluginDemo.GetPluginVersion() : String;
Begin
  Result := Self.PluginVersion;
End;


Procedure TTSTOPluginDemo.Initialize(AMainApplication: ITSTOApplication);
Begin
  FMainApp := AMainApplication;

  FMainApp.AddItem(iikToolBar, Self, SpTbxPluginDemo);
  FMainApp.AddItem(iikToolBar, Self, SpTbxSubMenu);
  FMainApp.AddItem(iikToolBar, Self, GrpPluginDemoItems);

  FMainApp.AddItem(iikMainMenu, Self, SpTbxPluginDemo);
  FMainApp.AddItem(iikMainMenu, Self, SpTbxSubMenu);
  FMainApp.AddItem(iikMainMenu, Self, GrpPluginDemoItems);

  FInitialized := True;
End;

Procedure TTSTOPluginDemo.Finalize();
Begin
  If FInitialized Then
  Begin
    FMainApp.RemoveItem(iikToolBar, Self, SpTbxPluginDemo);
    FMainApp.RemoveItem(iikToolBar, Self, SpTbxSubMenu);
    FMainApp.RemoveItem(iikToolBar, Self, GrpPluginDemoItems);
  
    FMainApp.RemoveItem(iikMainMenu, Self, SpTbxPluginDemo);
    FMainApp.RemoveItem(iikMainMenu, Self, SpTbxSubMenu);
    FMainApp.RemoveItem(iikMainMenu, Self, GrpPluginDemoItems);

    FInitialized := False;
  End;
End;

procedure TTSTOPluginDemo.JvPlugInConfigure(Sender: TObject);
Var lIni : TIniFile;
begin
  lIni := TIniFile.Create(ChangeFileExt(FPluginFileName, '.cfg'));
  Try
    FPluginSettings.Enabled := lIni.ReadBool(Self.Name, 'Enabled', True);
    FPluginSettings.PluginKind := TTSTOPluginKind(lIni.ReadInteger(Self.Name, 'PluginKind', 1));

    Finally
      lIni.Free();
  End;
end;

procedure TTSTOPluginDemo.JvPlugInCreate(Sender: TObject);
Var lFileName : Array[0..MAX_PATH] Of Char;
begin
  FillChar(lFileName, SizeOf(lFileName), #0);
  GetModuleFileName(hInstance, lFileName, SizeOf(lFileName));

  FPluginFileName := lFileName;
  FPluginPath     := ExtractFilePath(lFileName);
  FInitialized    := False;
end;

Procedure TTSTOPluginDemo.JvPlugInDestroy(Sender: TObject);
Var lIni : TIniFile;
Begin
  FMainApp := Nil;

  lIni := TIniFile.Create(ChangeFileExt(FPluginFileName, '.cfg'));
  Try
    lIni.WriteBool(Self.Name, 'Enabled', FPluginSettings.Enabled);
    lIni.WriteInteger(Self.Name, 'PluginKind', Ord(FPluginSettings.PluginKind));

    Finally
      lIni.Free();
  End;
End;

procedure TTSTOPluginDemo.SpTbxPluginDemoClick(Sender: TObject);
begin
  ShowMessage('Plugin Demo');
end;

procedure TTSTOPluginDemo.SpTbxStopClick(Sender: TObject);
begin
  ShowMessage('Stop Animation');
end;

procedure TTSTOPluginDemo.SpTbxPlayClick(Sender: TObject);
begin
  ShowMessage('Play Animation');
end;

End.
