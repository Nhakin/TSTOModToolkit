Unit PlugInPluginManager;

Interface

Uses
  Windows, Messages, SysUtils, Classes, Dialogs, Forms, Controls,
  JvPlugin, HsInterfaceEx, TSTOPluginIntf, System.ImageList, Vcl.ImgList,
  TB2Item, SpTBXItem;

Type
  TTSTOPluginManager = Class(TJvPlugIn, ITSTOPlugin)
    SpTBXBItemContainer1: TSpTBXBItemContainer;
    SpTbxPluginManager: TSpTBXItem;

    procedure JvPlugInCreate(Sender: TObject);
    procedure SpTbxPluginManagerClick(Sender: TObject);

  Private
    FIntfImpl       : TInterfaceExImplementor;
    FMainApp        : ITSTOApplication;
    FPluginPath     : String;
    FPluginFileName : String;
    FInitialized    : Boolean;

    Function GetIntfImpl() : TInterfaceExImplementor;

  Protected
    Property IntfImpl: TInterfaceExImplementor Read GetIntfImpl Implements ITSTOPlugin;

    //ITSTOPlugin
    Function  GetInitialized() : Boolean;

    Function  GetEnabled() : Boolean;
    Procedure SetEnabled(Const AEnabled : Boolean);

    Function  GetPluginKind() : TTSTOPluginKind;
    Procedure SetPluginKind(Const ATSTOPluginKind : TTSTOPluginKind);

    Procedure Initialize(AMainApplication : ITSTOApplication);
    Procedure Finalize();

  End;

Function RegisterPlugin() : TTSTOPluginManager; StdCall;

Implementation

{$R *.dfm}

Uses 
  IniFiles;

Function RegisterPlugin() : TTSTOPluginManager;
Begin
  Result := TTSTOPluginManager.Create(nil);
End;

Function TTSTOPluginManager.GetIntfImpl() : TInterfaceExImplementor;
Begin
  If Not Assigned(FIntfImpl) Then
    FIntfImpl := TInterfaceExImplementor.Create(Self, False);
  Result := FIntfImpl;
End;

Function TTSTOPluginManager.GetInitialized() : Boolean;
Begin
  Result := FInitialized;
End;

Function TTSTOPluginManager.GetEnabled() : Boolean;
Begin
  Result := True;
End;

Procedure TTSTOPluginManager.SetEnabled(Const AEnabled : Boolean);
Begin
End;

Function TTSTOPluginManager.GetPluginKind() : TTSTOPluginKind;
Begin
  Result := pkGUI;
End;

Procedure TTSTOPluginManager.SetPluginKind(Const ATSTOPluginKind : TTSTOPluginKind);
Begin
End;

Procedure TTSTOPluginManager.Initialize(AMainApplication: ITSTOApplication);
Begin
  FMainApp := AMainApplication;

  If Assigned(FMainApp) Then
  Begin
    FMainApp.AddItem(iikMainMenu, Self, SpTbxPluginManager);

    FInitialized := True;
  End;
End;

Procedure TTSTOPluginManager.Finalize();
Begin
  If FInitialized Then
  Begin
    FMainApp.RemoveItem(iikMainMenu, Self, SpTbxPluginManager);

    FInitialized := False;
  End;
End;

procedure TTSTOPluginManager.JvPlugInCreate(Sender: TObject);
begin
  FInitialized := False;
end;

procedure TTSTOPluginManager.SpTbxPluginManagerClick(Sender: TObject);
begin
//
end;

End.
