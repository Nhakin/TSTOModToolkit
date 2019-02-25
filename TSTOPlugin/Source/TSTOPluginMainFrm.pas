unit TSTOPluginMainFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvComponentBase, JvPluginManager, StdCtrls, HsInterfaceEx,
  TSTOPluginIntf, TSTOWorkspaceIntf;

type
  TForm4 = class(TForm, ITSTOApplication)
    JvPluginManager1: TJvPluginManager;
    ListBox1: TListBox;

    procedure FormCreate(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);

  Private
    FWorkSpace : ITSTOWorkSpaceProjectGroupIO;
    FIntfImpl : TInterfaceExImplementor;

    Function GetIntfImpl() : TInterfaceExImplementor;

  Protected
    Property IntfImpl : TInterfaceExImplementor Read GetIntfImpl Implements ITSTOApplication;

    Function GetWorkSpace() : ITSTOWorkSpaceProjectGroupIO;

  public

  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

Uses
  JvPlugin;

procedure TForm4.FormCreate(Sender: TObject);
  Procedure InternalListPlugins(AStartPath : String; ALvl : Integer);
  Var lSr : TSearchRec;
  Begin
    If FindFirst(AStartPath + '*.*', faAnyFile, lSr) = 0 Then
    Try
      Repeat
        If (lSr.Attr And faDirectory = faDirectory) And (lSr.Name <> '.') And (lSr.Name <> '..') And (ALvl < 1) Then
          InternalListPlugins(AStartPath + lSr.Name + '\', ALvl + 1)
        Else If SameText(ExtractFileExt(lSr.Name), '.dll') Then
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
    ListBox1.AddItem(JvPluginManager1.Plugins[X].Name, JvPluginManager1.Plugins[X]);
end;

Function TForm4.GetIntfImpl() : TInterfaceExImplementor;
Begin
  If Not Assigned(FIntfImpl) Then
    FIntfImpl := TInterfaceExImplementor.Create(Self, False);
  Result := FIntfImpl;
End;

procedure TForm4.ListBox1Click(Sender: TObject);
Var lPluginIntf : ITSTOPlugin;
    lPlugin     : TJvPlugin;
begin
  lPlugin := TJvPlugin(ListBox1.Items.Objects[ListBox1.ItemIndex]);
  If lPlugin.GetInterface(ITSTOPlugin, lPluginIntf) Then
  Begin
    lPlugin.Configure();
    
    If lPluginIntf.Enabled Then
    Begin
      lPluginIntf.InitPlugin(Self);
      ShowMessage(lPlugin.Name + ' - ' + lPlugin.Copyright);
    End;{
    Else
      JvPluginManager1.UnloadPlugin(ListBox1.ItemIndex);}
  End
  Else
    ShowMessage('ITSTOPlugin not implemented');
end;

Function TForm4.GetWorkSpace() : ITSTOWorkSpaceProjectGroupIO;
Begin
  Result := FWorkSpace;
End;

end.
