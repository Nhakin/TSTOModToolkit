unit ProjectGroupSettingFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  TSTOProjectWorkSpaceIntf, dmImage, TSTOProject.Xml,
  SpTBXItem, SpTBXControls, SpTBXExPanel, TB2Item, TB2Dock, TB2Toolbar,
  Vcl.StdCtrls, SpTBXEditors, VirtualTrees, SpTBXExControls;

type
  TFrmProjectGroupSettings = class(TForm)
    SpTBXExPanel1: TSpTBXExPanel;
    SpTBXLabel1: TSpTBXLabel;
    SpTBXStatusBar1: TSpTBXStatusBar;
    SpTBXDock1: TSpTBXDock;
    SpTBXToolbar1: TSpTBXToolbar;
    SpTbxSave: TSpTBXItem;
    EditProjectName: TSpTBXEdit;
    chkPackOutput: TSpTBXCheckBox;
    EditOutputPath: TSpTBXButtonEdit;
    SpTBXLabel5: TSpTBXLabel;
    SpTBXLabel4: TSpTBXLabel;
    SpTBXLabel2: TSpTBXLabel;
    EditHackFileName: TSpTBXButtonEdit;

    procedure FormCreate(Sender: TObject);
    procedure EditOutputPathSubEditButton0Click(Sender: TObject);
    procedure SpTbxSaveClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure EditHackFileNameSubEditButton0Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);

  private
    FWorkSpaceProjectGroup : ITSTOWorkSpaceProjectGroup;
    FAppSettings : ITSTOXMLSettings;
    FFormSettings : ITSTOXMLFormSetting;

  Protected
    Function  GetWorkSpaceProject() : ITSTOWorkSpaceProjectGroup;
    Procedure SetWorkSpaceProject(AWorkSpaceProjectGroup : ITSTOWorkSpaceProjectGroup);

    Procedure SetAppSettings(AAppSettings : ITSTOXMLSettings);

  public
    Property WorkSpaceProject : ITSTOWorkSpaceProjectGroup Read GetWorkSpaceProject Write SetWorkSpaceProject;
    Property AppSettings      : ITSTOXMLSettings           Read FAppSettings        Write SetAppSettings;
    Procedure AfterConstruction(); OverRide;

  end;

implementation

Uses RTTI, Vcl.ImgList, uSelectDirectoryEx, TSTOProjectWorkSpace.Types;

{$R *.dfm}

procedure TFrmProjectGroupSettings.EditOutputPathSubEditButton0Click(Sender: TObject);
Var lSelDir : AnsiString;
Begin
  If SelectDirectoryEx('Output path', ExtractFilePath(ParamStr(0)),
    lSelDir, True, False, False) Then
    EditOutputPath.Text := lSelDir;
End;

procedure TFrmProjectGroupSettings.EditHackFileNameSubEditButton0Click(
  Sender: TObject);
begin
  With TOpenDialog.Create(Self) Do
  Try
    Filter := 'Zip File|*.zip';

    If Execute() Then
      EditHackFileName.Text := FileName;

    Finally
      Free();
  End;
end;

procedure TFrmProjectGroupSettings.FormActivate(Sender: TObject);
begin
  WindowState := TRttiEnumerationType.GetValue<TWindowState>(FFormSettings.WindowState);
  Left        := FFormSettings.X;
  Top         := FFormSettings.Y;
  Height      := FFormSettings.H;
  Width       := FFormSettings.W;
end;

procedure TFrmProjectGroupSettings.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := True;

  If CanClose Then
  Begin
    FFormSettings.WindowState := TRttiEnumerationType.GetName(WindowState);
    If WindowState <> wsMaximized Then
    Begin
      FFormSettings.X := Left;
      FFormSettings.Y := Top;
      FFormSettings.H := Height;
      FFormSettings.W := Width;
    End;
  End;
end;

procedure TFrmProjectGroupSettings.FormCreate(Sender: TObject);
Var lBmp : TBitMap;
    lImgList : TImageList;
begin
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

  EditOutputPath.EditButton.Images     := lImgList;
  EditOutputPath.EditButton.ImageIndex := 0;

  EditHackFileName.EditButton.Images     := lImgList;
  EditHackFileName.EditButton.ImageIndex := 0;
end;

procedure TFrmProjectGroupSettings.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #27 Then
  Begin
    Key := #0;
    Close;
  End;
end;

Procedure TFrmProjectGroupSettings.AfterConstruction();
Begin
  InHerited AfterConstruction();
End;

Function TFrmProjectGroupSettings.GetWorkSpaceProject() : ITSTOWorkSpaceProjectGroup;
Begin
  Result := FWorkSpaceProjectGroup;
End;

Procedure TFrmProjectGroupSettings.SetWorkSpaceProject(AWorkSpaceProjectGroup : ITSTOWorkSpaceProjectGroup);
Begin
  FWorkSpaceProjectGroup := AWorkSpaceProjectGroup;

  Caption := 'Project Options for ' + FWorkSpaceProjectGroup.ProjectGroupName;

  EditProjectName.Text  := FWorkSpaceProjectGroup.ProjectGroupName;
  EditHackFileName.Text := FWorkSpaceProjectGroup.HackFileName;
  chkPackOutput.Checked := FWorkSpaceProjectGroup.PackOutput;
  EditOutputPath.Text   := FWorkSpaceProjectGroup.OutputPath;
End;

Procedure TFrmProjectGroupSettings.SetAppSettings(AAppSettings : ITSTOXMLSettings);
Var X : Integer;
Begin
  FAppSettings := AAppSettings;

  For X := 0 To FAppSettings.FormPos.Count - 1 Do
    If SameText(FAppSettings.FormPos[X].Name, Self.ClassName) Then
    Begin
      FFormSettings := FAppSettings.FormPos[X];
      Break;
    End;

  If Not Assigned(FFormSettings) Then
  Begin
    FFormSettings := FAppSettings.FormPos.Add();

    FFormSettings.Name        := Self.ClassName;
    FFormSettings.WindowState := TRttiEnumerationType.GetName(WindowState);
    FFormSettings.X := Left;
    FFormSettings.Y := Top;
    FFormSettings.H := Height;
    FFormSettings.W := Width;
  End;
End;

procedure TFrmProjectGroupSettings.SpTbxSaveClick(Sender: TObject);
begin
  FWorkSpaceProjectGroup.ProjectGroupName := EditProjectName.Text;
  FWorkSpaceProjectGroup.HackFileName     := EditHackFileName.Text;
  FWorkSpaceProjectGroup.PackOutput       := chkPackOutput.Checked;
  FWorkSpaceProjectGroup.OutputPath       := EditOutputPath.Text;

  ModalResult := mrOk;
end;

end.
