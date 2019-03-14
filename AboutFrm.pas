unit AboutFrm;

interface

uses
  TSTOPluginIntf,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  SpTBXItem, SpTBXControls, SpTBXExPanel, VirtualTrees, SpTBXExControls;

type
  TFrmAbout = class(TForm)
    PanInfo: TSpTBXExPanel;
    Image1: TImage;
    SpTBXLabel1: TSpTBXLabel;
    LblVersion: TSpTBXLabel;
    LblAuthor: TSpTBXLabel;
    SpTBXLabel3: TSpTBXLabel;
    GbPlugins: TSpTBXGroupBox;
    TvPlugins: TSpTBXVirtualStringTree;
    SpTBXButton1: TSpTBXButton;

    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure TvPluginsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure SpTBXButton1Click(Sender: TObject);

  Private
    FPluginList : ITSTOPlugins;

    Procedure SetPluginList(APluginList : ITSTOPlugins);

  Public
    Property PluginList : ITSTOPlugins Read FPluginList Write SetPluginList;

  End;

implementation

Uses
  SpTBXSkins;

{$R *.dfm}

procedure TFrmAbout.FormCreate(Sender: TObject);
begin
  If SameText(SkinManager.CurrentSkinName, 'WMP11') Then
  Begin
    PanInfo.Color := $00262525;
    PanInfo.TBXStyleBackground := False;

    TvPlugins.Color := $00262525;
    TvPlugins.Font.Color := clWhite;
  End;
end;

procedure TFrmAbout.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #27 Then
  Begin
    Key := #0;
    Close;
  End;
end;

Procedure TFrmAbout.SetPluginList(APluginList : ITSTOPlugins);
Begin
  FPluginList := APluginList;

  TvPlugins.RootNodeCount := FPluginList.Count;
End;

procedure TFrmAbout.SpTBXButton1Click(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFrmAbout.TvPluginsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
begin
  CellText := FPluginList[Node.Index].Name + ' - V' + FPluginList[Node.Index].PluginVersion;
end;

end.
