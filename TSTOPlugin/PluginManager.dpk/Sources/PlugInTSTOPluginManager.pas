unit PlugInTSTOPluginManager;

interface

uses
  TSTOPluginIntf, HsInterfaceEx,
  Windows, Messages, SysUtils, Classes, Dialogs, Forms, Controls,
  JvPlugin, JvComponentBase, JvPluginManager;

type
  TTSTOPluginManagerPlg = class(TJvPlugIn, ITSTOPlugin)
    JvPluginManager1: TJvPluginManager;
    procedure JvPlugInCreate(Sender: TObject);
    procedure JvPlugInInitialize(Sender: TObject; var AllowLoad: Boolean);

  Private
    FIntfImpl    : TInterfaceExImplementor;
    FMainApp     : ITSTOApplication;
    FInitialized : Boolean;

    Function GetIntfImpl() : TInterfaceExImplementor;

  Protected
    Property IntfImpl : TInterfaceExImplementor Read GetIntfImpl Implements ITSTOPlugin;

    //ITSTOPlugin
    Function  GetInitialized() : Boolean;

    Function  GetEnabled() : Boolean;
    Procedure SetEnabled(Const AEnabled : Boolean);

    Function  GetPluginKind() : TTSTOPluginKind;

    Function GetAuthor() : String;
    Function GetCopyRight() : String;
    Function GetDescription() : String;
    Function GetPluginId() : String;
    Function GetPluginVersion() : String;

    Procedure Initialize(AMainApplication : ITSTOApplication); ReIntroduce;
    Procedure Finalize();

  Public

  end;

Function RegisterPlugin() : TJvPlugIn; StdCall;

Exports
  RegisterPlugin;

implementation

{$R *.dfm}

Function RegisterPlugin() : TJvPlugIn;
Begin
  Result := TTSTOPluginManagerPlg.Create(nil);
End;

Function TTSTOPluginManagerPlg.GetIntfImpl() : TInterfaceExImplementor;
Begin
  If Not Assigned(FIntfImpl) Then
    FIntfImpl := TInterfaceExImplementor.Create(Self, False);
  Result := FIntfImpl;
End;

Function TTSTOPluginManagerPlg.GetInitialized() : Boolean;
Begin
  Result := FInitialized;
End;

Function TTSTOPluginManagerPlg.GetEnabled() : Boolean;
Begin
  Result := True;
End;

Procedure TTSTOPluginManagerPlg.SetEnabled(Const AEnabled : Boolean);
Begin

End;

Function TTSTOPluginManagerPlg.GetPluginKind() : TTSTOPluginKind;
Begin
  Result := pkGUI;
End;

Function TTSTOPluginManagerPlg.GetAuthor() : String;
Begin
  Result := Self.Author;
End;

Function TTSTOPluginManagerPlg.GetCopyRight() : String;
Begin
  Result := Self.Copyright;
End;

Function TTSTOPluginManagerPlg.GetDescription() : String;
Begin
  Result := Self.Description;
End;

Function TTSTOPluginManagerPlg.GetPluginId() : String;
Begin
  Result := Self.PluginID;
End;

Function TTSTOPluginManagerPlg.GetPluginVersion() : String;
Begin
  Result := Self.PluginVersion;
End;

Procedure TTSTOPluginManagerPlg.Initialize(AMainApplication : ITSTOApplication);
Begin
  FMainApp := AMainApplication;

  FInitialized := True;
End;

procedure TTSTOPluginManagerPlg.JvPlugInCreate(Sender: TObject);
begin
  FInitialized := False;
end;

procedure TTSTOPluginManagerPlg.JvPlugInInitialize(Sender: TObject;
  var AllowLoad: Boolean);
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
begin
  InternalListPlugins(ExtractFilePath(ParamStr(0)) + 'Plugins\', 0);

  For X := 0 To JvPluginManager1.PluginCount - 1 Do
    JvPluginManager1.Plugins[X].Configure();
  AllowLoad := True;
end;

Procedure TTSTOPluginManagerPlg.Finalize();
Begin
  If FInitialized Then
  Begin
    FMainApp := Nil;
    FInitialized := False;
  End;
End;

end.
