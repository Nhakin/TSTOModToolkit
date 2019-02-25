Unit PlugInTSTOPluginDemo;

Interface

Uses
  Windows, Messages, SysUtils, Classes, Dialogs, Forms, Controls,
  JvPlugin, HsInterfaceEx, TSTOPluginIntf;

Type
  TTSTOPluginDemo = Class(TJvPlugIn, ITSTOPlugin)
    procedure JvPlugInCreate(Sender: TObject);
    Procedure JvPlugInDestroy(Sender : TObject);
    procedure JvPlugInConfigure(Sender: TObject);

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
End;

procedure TTSTOPluginDemo.JvPlugInConfigure(Sender: TObject);
Var lIni : TIniFile;
begin
  lIni := TIniFile.Create(ChangeFileExt(FPluginFileName, '.cfg'));
  Try
    FPluginSettings.Enabled := lIni.ReadBool(Self.Name, 'Enabled', True);
    FPluginSettings.PluginKind := TTSTOPluginKind(lIni.ReadInteger(Self.Name, 'ProjectKind', 1);
    Finally
      lIni.Free();
  End;
end;

procedure TTSTOPluginDemo.JvPlugInCreate(Sender: TObject);
Var lFileName : Array[0..MAX_PATH] Of Char;
begin
  FillChar(lFileName, sizeof(lFileName), #0);
  GetModuleFileName(hInstance, lFileName, sizeof(lFileName));

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

    Finally
      lIni.Free();
  End;
End;

End.
