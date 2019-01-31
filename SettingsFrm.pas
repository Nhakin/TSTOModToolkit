unit SettingsFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ToolWin, ExtCtrls, TSTOProject.Xml, dmImage,
  SpTBXItem, SpTBXControls, TB2Dock, TB2Toolbar, TB2Item, SpTBXExPanel,
  VTEditors, SpTBXEditors, System.ImageList, Vcl.ImgList;

type
  TFrmSettings = class(TForm)
    dckNewTB: TSpTBXDock;
    tbMainV2: TSpTBXToolbar;
    tbSaveV2: TSpTBXItem;
    SbMainV2: TSpTBXStatusBar;
    PanData: TSpTBXExPanel;
    LblDLCServer: TLabel;
    LblDLCPath: TLabel;
    LblHackPath: TLabel;
    LblHackFileName: TLabel;
    LblSourcePath: TLabel;
    LblTargetPath: TLabel;
    LblResourcePath: TLabel;
    EditDLCServer: TEdit;
    EditDLCPath: TEdit;
    EditHackPath: TEdit;
    EditHackFileName: TEdit;
    EditSourcePath: TEdit;
    EditTargetPath: TEdit;
    EditResourcePath: TEdit;
    SbReloadRessourceIndex: TSpTBXSpeedButton;
    SbCreateNewHack: TSpTBXSpeedButton;

    procedure FormShow(Sender: TObject);
    procedure tbSaveClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SbReloadRessourceIndexClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SbCreateNewHackClick(Sender: TObject);

  Private
    FProject : ITSTOXMLProject;
    FResourceChanged : Boolean;

    FEditDLCPath      : TSpTBXButtonEdit;
    FEditHackPath     : TSpTBXButtonEdit;
    FEditHackFileName : TSpTBXButtonEdit;
    FEditResourcePath : TSpTBXButtonEdit;

    Procedure DoEditDLCPathButtonClick(Sender : TObject);
    Procedure DoEditHackPathButtonClick(Sender : TObject);
    Procedure DoEditHackFileNameButtonClick(Sender : TObject);
    Procedure DoEditResourcePathButtonClick(Sender : TObject);

  Published
    Property ProjectFile     : ITSTOXMLProject Read FProject Write FProject;
    Property ResourceChanged : Boolean         Read FResourceChanged;

  End;

implementation

Uses
  SpTbxSkins, HsFunctionsEx, HsZipUtils, HsStreamEx, uSelectDirectoryEx,
  TSTORessource, TSTOHackSettings;

{$R *.dfm}

procedure TFrmSettings.FormCreate(Sender: TObject);
Var lImgList : TImageList;

  Function CreateButtonEdit(AEdit : TEdit) : TSpTBXButtonEdit;
  Begin
    Result := TSpTBXButtonEdit.Create(Self);

    Result.Parent := PanData;
    Result.SetBounds(AEdit.Left, AEdit.Top, AEdit.Width, AEdit.Height);
    Result.EditButton.Images := lImgList;
    Result.EditButton.ImageIndex := 0;
    Result.Anchors := AEdit.Anchors;
  End;

Var X, Y : Integer;
    lBmp : TBitMap;
begin
  Constraints.MinHeight := 290;
  Constraints.MaxHeight := 290;

  If SameText(CurrentSkin.SkinName, 'WMP11') Then
  Begin
    PanData.Color := $00262525;
    Self.Color := $00262525;

    For X := 0 To ComponentCount - 1 Do
      If Components[X] Is TLabel Then
        TLabel(Components[X]).Font.Color := CurrentSkin.Options(skncLabel, sknsNormal).TextColor;//$00F1F1F1;
  End;

  lBmp := TBitMap.Create();
  Try
    lBmp.LoadFromResourceName(HInstance, 'Magnifier');

    lImgList := TImageList.Create(Self);
    lImgList.DrawingStyle := dsTransparent;
    lImgList.Width  := 12;
    lImgList.Height := 12;
    lImgList.AddMasked(lBmp, clOlive);

    Finally
      lBmp.Free();
  End;

  FEditDLCPath      := CreateButtonEdit(EditDLCPath);
  FEditHackPath     := CreateButtonEdit(EditHackPath);
  FEditHackFileName := CreateButtonEdit(EditHackFileName);
  FEditResourcePath := CreateButtonEdit(EditResourcePath);

  FEditDLCPath.EditButton.OnClick      := DoEditDLCPathButtonClick;
  FEditHackPath.EditButton.OnClick     := DoEditHackPathButtonClick;
  FEditHackFileName.EditButton.OnClick := DoEditHackFileNameButtonClick;
  FEditResourcePath.EditButton.OnClick := DoEditResourcePathButtonClick;
End;

Procedure TFrmSettings.DoEditDLCPathButtonClick(Sender : TObject);
Var lSelDir : AnsiString;
Begin
  If SelectDirectoryEx('DLC Directory', ExtractFilePath(ParamStr(0)),
    lSelDir, True, False, False) Then
    FEditDLCPath.Text := lSelDir;
End;

Procedure TFrmSettings.DoEditHackPathButtonClick(Sender : TObject);
Var lSelDir : AnsiString;
Begin
  If SelectDirectoryEx('Hack Directory', ExtractFilePath(ParamStr(0)),
    lSelDir, True, False, False) Then
    FEditHackPath.Text := lSelDir;
End;

Procedure TFrmSettings.DoEditHackFileNameButtonClick(Sender : TObject);
begin
  With TOpenDialog.Create(Self) Do
  Try
    Filter := 'Zip File|*.zip';

    If Execute() Then
      FEditHackFileName.Text := FileName;

    Finally
      Free();
  End;
end;


Procedure TFrmSettings.DoEditResourcePathButtonClick(Sender : TObject);
Var lSelDir : AnsiString;
Begin
  If SelectDirectoryEx('Resource Directory', ExtractFilePath(ParamStr(0)),
    lSelDir, True, False, False) Then
    FEditResourcePath.Text := lSelDir;
End;

procedure TFrmSettings.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #27 Then
  Begin
    Key := #0;
    Close;
  End;
end;

procedure TFrmSettings.FormShow(Sender: TObject);
begin
  EditDLCServer.Text     := FProject.Settings.DLCServer;
  EditSourcePath.Text    := FProject.Settings.SourcePath;
  EditTargetPath.Text    := FProject.Settings.TargetPath;
  FEditDLCPath.Text      := FProject.Settings.DLCPath;
  FEditHackPath.Text     := FProject.Settings.HackPath;
  FEditHackFileName.Text := FProject.Settings.HackFileName;
  FEditResourcePath.Text := FProject.Settings.ResourcePath;

  FResourceChanged := False;
end;

procedure TFrmSettings.SbCreateNewHackClick(Sender: TObject);
Var lNewHack : ITSTOHackSettings;
begin
  With TSaveDialog.Create(Self) Do
  Try
    Filter := 'Zip File|*.zip';

    If Execute() Then
    Begin
      If Not SameText(ExtractFileExt(FileName), '.zip') Then
        FileName := FileName + '.zip';

      lNewHack := TTSTOHackSettings.CreateHackSettings();
      Try
        lNewHack.NewHackFile();
        lNewHack.SaveToFile(FileName);
        ShowMessage('Done');

        Finally
          lNewHack := Nil;
      End;

      FEditHackFileName.Text := FileName;
    End;

    Finally
      Free();
  End;
end;

procedure TFrmSettings.SbReloadRessourceIndexClick(Sender: TObject);
Var lRes : ITSTOResourcePaths;
begin
  If DirectoryExists(EditResourcePath.Text) Then
  Begin
    If MessageConfirm('Do you want to rebuild ressource index?'#$D#$A'It can be long if you have a lot.') Then
    Begin
      lRes := TTSTOResourcePaths.CreateResourcePaths();
      Try
        lRes.ListResource(IncludeTrailingBackslash(EditResourcePath.Text));
        lRes.SaveToFile(IncludeTrailingBackslash(EditResourcePath.Text) + 'ResourceIndex.bin');
        
        FResourceChanged := True;
        ShowMessage('Done');

        Finally
          lRes := Nil;
      End;
    End;
  End;
end;

procedure TFrmSettings.tbSaveClick(Sender: TObject);
begin
  If (FEditHackFileName.Text = '') And
     MessageConfirm('No default hack file selected.'#$D#$A'Do you want to create one?') Then
    SbCreateNewHackClick(Self);

  FProject.Settings.DLCServer    := AnsiString(EditDLCServer.Text);
  FProject.Settings.SourcePath   := AnsiString(EditSourcePath.Text);
  FProject.Settings.TargetPath   := AnsiString(EditTargetPath.Text);
  FProject.Settings.DLCPath      := FEditDLCPath.Text;
  FProject.Settings.HackPath     := FEditHackPath.Text;
  FProject.Settings.HackFileName := FEditHackFileName.Text;
  FProject.Settings.ResourcePath := FEditResourcePath.Text;

  ModalResult := mrOk;
end;

end.
