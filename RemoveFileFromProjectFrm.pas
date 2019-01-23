unit RemoveFileFromProjectFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SpTBXControls, SpTBXItem, Vcl.ExtCtrls,
  TSTOTreeviews, TSTOProjectWorkSpaceIntf;

type
  TFrmRemoveFileFromProject = class(TForm)
    SpTBXGroupBox1: TSpTBXGroupBox;
    SBOk: TSpTBXButton;
    SbCancel: TSpTBXButton;
    PanTreeView: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);

  Private
    FTvFiles : TTSTORemoveFileTreeView;
    FTvData  : ITSTOWorkSpaceProjectSrcFiles;

    Function  GetFileList() : ITSTOWorkSpaceProjectSrcFiles;
    Procedure SetFileList(Const AFileList : ITSTOWorkSpaceProjectSrcFiles);

    Function GetSelectedFiles() : ITSTOWorkSpaceProjectSrcFiles;

  Public
    Property FileList      : ITSTOWorkSpaceProjectSrcFiles Read GetFileList Write SetFileList;
    Property SelectedFiles : ITSTOWorkSpaceProjectSrcFiles Read GetSelectedFiles;

  end;

implementation

Uses SpTBXSkins;

{$R *.dfm}

procedure TFrmRemoveFileFromProject.FormCreate(Sender: TObject);
begin
  FTvFiles := TTSTORemoveFileTreeView.Create(Self);

  FTvFiles.Parent := PanTreeView;
  FTvFiles.Align  := alClient;

  If SameText(SkinManager.CurrentSkinName, 'WMP11') Then
    FTvFiles.Color := $00262525
  Else
    FTvFiles.Color := clNone;

  SkinManager.SetSkin(SkinManager.CurrentSkinName);
end;

procedure TFrmRemoveFileFromProject.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  If Key = #27 Then
  Begin
    Key := #0;
    Close;
  End;
end;

Function TFrmRemoveFileFromProject.GetFileList() : ITSTOWorkSpaceProjectSrcFiles;
Begin
  Result := FTvData;
End;

Procedure TFrmRemoveFileFromProject.SetFileList(Const AFileList : ITSTOWorkSpaceProjectSrcFiles);
Begin
  FTvData := AFileList;
  FTvFiles.TvData := FTvData;
  FTvFiles.LoadData();
End;

Function TFrmRemoveFileFromProject.GetSelectedFiles() : ITSTOWorkSpaceProjectSrcFiles;
Begin
  Result := FTvFiles.GetSelectedItems();
End;

end.
