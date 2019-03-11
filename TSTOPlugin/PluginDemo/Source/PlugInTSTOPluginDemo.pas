Unit PlugInTSTOPluginDemo;

Interface

Uses
  Windows, Messages, SysUtils, Classes, Dialogs, Forms, Controls,
  JvPlugin, HsInterfaceEx, TSTOPluginIntf, 
  TB2Item, SpTBXItem, ImgList;

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

    FEnabled          : Boolean;
    FAddMenuItem      : Boolean;
    FAddToolBarButton : Boolean;

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
    Function  GetHaveSettings() : Boolean;

    Procedure Initialize(AMainApplication : ITSTOApplication);
    Procedure Finalize();
    Function  ShowSettings() : Boolean;

  Public

  End;

Function RegisterPlugin() : TTSTOPluginDemo; StdCall;

Implementation

{$R *.dfm}

Uses 
  IniFiles, PluginDemoSettingDlg;

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
  Result := FEnabled;
End;

Procedure TTSTOPluginDemo.SetEnabled(Const AEnabled : Boolean);
Begin
  FEnabled := AEnabled;
End;

Function TTSTOPluginDemo.GetPluginKind() : TTSTOPluginKind;
Begin
  Result := pkGUI;
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

Function TTSTOPluginDemo.GetHaveSettings() : Boolean;
Begin
  Result := True;
End;

Procedure TTSTOPluginDemo.Initialize(AMainApplication: ITSTOApplication);
Begin
  If Not FInitialized Then
  Begin
    FMainApp := AMainApplication;

    If FEnabled Then
    Begin
      If FAddToolBarButton Then
      Begin
        FMainApp.AddItem(iikToolBar, Self, SpTbxPluginDemo);
        FMainApp.AddItem(iikToolBar, Self, SpTbxSubMenu);
        FMainApp.AddItem(iikToolBar, Self, GrpPluginDemoItems);
      End;

      If FAddMenuItem Then
      Begin
        FMainApp.AddItem(iikMainMenu, Self, SpTbxPluginDemo);
        FMainApp.AddItem(iikMainMenu, Self, SpTbxSubMenu);
        FMainApp.AddItem(iikMainMenu, Self, GrpPluginDemoItems);
      End;
    End;

    FInitialized := True;
  End;
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

Function TTSTOPluginDemo.ShowSettings() : Boolean;
Begin
  Result := False;

  With TDlgPluginDemoSetting.Create(Self) Do
  Try
    PluginEnabled    := FEnabled;
    AddMenuItem      := FAddMenuItem;
    AddToolBarButton := FAddToolBarButton;

    If ShowModal() = mrOk Then
    Begin
      Result := (FEnabled <> PluginEnabled) Or
                (FAddMenuItem <> AddMenuItem) Or
                (FAddToolBarButton <> AddToolBarButton);

      FEnabled          := PluginEnabled;
      FAddMenuItem      := AddMenuItem;
      FAddToolBarButton := AddToolBarButton;
    End;
      
    Finally
      Release();
  End;
End;

procedure TTSTOPluginDemo.JvPlugInConfigure(Sender: TObject);
Var lIni : TIniFile;
begin
  lIni := TIniFile.Create(ChangeFileExt(FPluginFileName, '.cfg'));
  Try
    FEnabled          := lIni.ReadBool(Self.Name, 'Enabled', True);
    FAddMenuItem      := lIni.ReadBool(Self.Name, 'AddMenuItem', True);
    FAddToolBarButton := lIni.ReadBool(Self.Name, 'AddToolBarButton', True);

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
    lIni.WriteBool(Self.Name, 'Enabled', FEnabled);
    lIni.WriteBool(Self.Name, 'AddMenuItem', FAddMenuItem);
    lIni.WriteBool(Self.Name, 'AddToolBarButton', FAddToolBarButton);

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
