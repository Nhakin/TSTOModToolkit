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

    FPluginSettings : Record
      Enabled    : Boolean;
      PluginKind : TTSTOPluginKind;
    End;

    Function GetIntfImpl() : TInterfaceExImplementor;

  Protected
    Property IntfImpl: TInterfaceExImplementor Read GetIntfImpl Implements ITSTOPlugin;

    Function  GetEnabled() : Boolean;
    Procedure SetEnabled(Const AEnabled : Boolean);

    Function  GetPluginKind() : TTSTOPluginKind;
    Procedure SetPluginKind(Const ATSTOPluginKind : TTSTOPluginKind);

    Procedure InitPlugin(AMainApplication : ITSTOApplication);

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

Procedure TTSTOPluginDemo.SetPluginKind(Const ATSTOPluginKind : TTSTOPluginKind);
Begin
  FPluginSettings.PluginKind := ATSTOPluginKind;
End;

Procedure TTSTOPluginDemo.InitPlugin(AMainApplication: ITSTOApplication);
Begin
  FMainApp := AMainApplication;

  FMainApp.AddToolBarButton(Self, SpTbxPluginDemo);
  FMainApp.AddToolBarDropDownButton(Self, SpTbxSubMenu);
  FMainApp.AddMenuItem(Self, SpTbxPluginDemo);
  FMainApp.AddSubMenuItem(Self, SpTbxSubMenu);
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
