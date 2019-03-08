unit PlgTSTOPluginManager;

interface

uses
  HsInterfaceEx, TSTOPluginIntf,
  Windows, Messages, SysUtils, Classes, Dialogs, Forms, Controls,
  JvPlugin, JvComponentBase, JvPluginManager, SpTBXItem, TB2Item;

type
  TTSTOPluginManager = class(TJvPlugIn, ITSTOPlugin)
    JvPluginManager1: TJvPluginManager;
    SpTBXBItemContainer1: TSpTBXBItemContainer;
    grpPluginManagerMenuItem: TSpTBXTBGroupItem;
    SpTBXSeparatorItem1: TSpTBXSeparatorItem;
    mnuPluginManager: TSpTBXItem;

    procedure mnuPluginManagerClick(Sender: TObject);

  Private
    FIntfImpl    : TInterfaceExImplementor;
    FMainApp     : ITSTOApplication;
    FInitialized : Boolean;

    Function GetIntfImpl() : TInterfaceExImplementor;

  Protected
    Property IntfImpl: TInterfaceExImplementor Read GetIntfImpl Implements ITSTOPlugin;

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
    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;

  End;

Function RegisterPlugin() : TJvPlugIn; StdCall;

Exports
  RegisterPlugin;

implementation

Uses
  DlgTSTOPluginManager;

{$R *.dfm}

Function RegisterPlugin() : TJvPlugIn;
Begin
  Result := TTSTOPluginManager.Create(nil);
End;

Procedure TTSTOPluginManager.AfterConstruction();
  Procedure InternalListPlugins(AStartPath : String; ALvl : Integer);
  Var lSr : TSearchRec;
  Begin
    If FindFirst(AStartPath + '*.*', faAnyFile, lSr) = 0 Then
    Try
      Repeat
        If (lSr.Attr And faDirectory = faDirectory) And (lSr.Name <> '.') And (lSr.Name <> '..') And (ALvl < 1) Then
          InternalListPlugins(AStartPath + lSr.Name + '\', ALvl + 1)
        Else If SameText(ExtractFileExt(lSr.Name), '.dll') And (ALvl = 1) Then
          JvPluginManager1.LoadPlugin(AStartPath + lSr.Name, plgDLL);
      Until FindNext(lSr) <> 0;

      Finally
        FindClose(lSr);
    End;
  End;

Var X : Integer;
Begin
  InHerited AfterConstruction();

  InternalListPlugins(ExtractFilePath(ParamStr(0)) + 'Plugins\', 0);

  For X := 0 To JvPluginManager1.PluginCount - 1 Do
    JvPluginManager1.Plugins[X].Configure();
End;

Procedure TTSTOPluginManager.BeforeDestruction();
Begin
  FMainApp := Nil;

  InHerited BeforeDestruction();
End;

Function TTSTOPluginManager.GetIntfImpl() : TInterfaceExImplementor;
Begin
  If Not Assigned(FIntfImpl) Then
    FIntfImpl := TInterfaceExImplementor.Create(Self, False);
  Result := FIntfImpl;
End;

Procedure TTSTOPluginManager.Initialize(AMainApplication : ITSTOApplication);
Var lMnu    : TComponent;
    lPlugin : ITSTOPlugin;
    X       : Integer;
    lGroup  : TSpTBXTBGroupItem;
    lItem   : TSpTbxItem;
Begin
  If Not FInitialized Then
  Begin
    FMainApp := AMainApplication;

    For X := 0 To JvPluginManager1.PluginCount - 1 Do
      If JvPluginManager1.Plugins[X].GetInterface(ITSTOPlugin, lPlugin) And lPlugin.Enabled Then
        lPlugin.Initialize(FMainApp);

    lMnu := HostApplication.MainForm.FindComponent('mnuPlugins');
    If Assigned(lMnu) And SameText(lMnu.ClassName, 'TSpTBXSubmenuItem') Then
      FMainApp.AddItem(Self, grpPluginManagerMenuItem, TTBCustomItem(lMnu));

    FInitialized := True;
  End;
End;

procedure TTSTOPluginManager.mnuPluginManagerClick(Sender: TObject);
begin
  With TTSTOPluginManagerDlg.Create(Self) Do
  Try
    If ShowModal() = mrOk Then
    Begin

    End;

    Finally
      Release();
  End;
end;

Procedure TTSTOPluginManager.Finalize();
Begin
  If FInitialized Then
  Begin
    FMainApp := Nil;
    FInitialized := False;
  End;
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

Function TTSTOPluginManager.GetName() : String;
Begin
  Result := Self.Name;
End;

Function TTSTOPluginManager.GetAuthor() : String;
Begin
  Result := Self.Author;
End;

Function TTSTOPluginManager.GetCopyright() : String;
Begin
  Result := Self.Copyright;
End;

Function TTSTOPluginManager.GetDescription() : String;
Begin
  Result := Self.Description;
End;

Function TTSTOPluginManager.GetPluginId() : String;
Begin
  Result := Self.PluginID;
End;

Function TTSTOPluginManager.GetPluginVersion() : String;
Begin
  Result := Self.PluginVersion;
End;

end.
