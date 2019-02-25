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
    FMainApp    : ITSTOApplication;
    FIntfImpl   : TInterfaceExImplementor;
    FPluginPath : String;
    FPluginFileName : String;
    FEnabled    : Boolean;

    Function GetIntfImpl() : TInterfaceExImplementor;

  Protected
    Property IntfImpl: TInterfaceExImplementor Read GetIntfImpl Implements ITSTOPlugin;

    Function  GetEnabled() : Boolean;
    Procedure SetEnabled(Const AEnabled : Boolean);

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
  Result := FEnabled;
End;

Procedure TTSTOPluginDemo.SetEnabled(Const AEnabled : Boolean);
Begin
  FEnabled := AEnabled;
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
    FEnabled := lIni.ReadBool(Self.Name, 'Enabled', True);

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
    lIni.WriteBool(Self.Name, 'Enabled', FEnabled);

    Finally
      lIni.Free();
  End;
End;

End.
