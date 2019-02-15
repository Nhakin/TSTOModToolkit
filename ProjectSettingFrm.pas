unit ProjectSettingFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  TSTOProjectWorkSpaceIntf, TSTOProject.Xml, dmImage,
  SpTBXItem, SpTBXControls, SpTBXExPanel, TB2Item, TB2Dock, TB2Toolbar,
  Vcl.StdCtrls, SpTBXEditors, VirtualTrees, SpTBXExControls;

type
  TFrmProjectSettings = class(TForm)
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
    rgProjectKind: TSpTBXRadioGroup;
    rgProjectType: TSpTBXRadioGroup;
    LabelCustomScriptPath: TSpTBXLabel;
    EditCustomScriptPath: TSpTBXButtonEdit;
    EditCustomModPath: TSpTBXButtonEdit;
    SpTBXLabel2: TSpTBXLabel;
    procedure FormCreate(Sender: TObject);
    procedure EditOutputPathSubEditButton0Click(Sender: TObject);
    procedure SpTbxSaveClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure rgProjectTypeClick(Sender: TObject);
    procedure EditCustomScriptPathSubEditButton0Click(Sender: TObject);
    procedure EditCustomModPathSubEditButton0Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);

  private
    FWorkSpaceProject : ITSTOWorkSpaceProject;
    FAppSettings : ITSTOXMLSettings;
    FFormSettings : ITSTOXMLFormSetting;


  Protected
    Function  GetWorkSpaceProject() : ITSTOWorkSpaceProject;
    Procedure SetWorkSpaceProject(AWorkSpaceProject : ITSTOWorkSpaceProject);

    Procedure SetAppSettings(AAppSettings : ITSTOXMLSettings);

  public
    Property WorkSpaceProject : ITSTOWorkSpaceProject Read GetWorkSpaceProject Write SetWorkSpaceProject;
    Property AppSettings      : ITSTOXMLSettings      Read FAppSettings        Write SetAppSettings;

    Procedure AfterConstruction(); OverRide;

  end;

implementation

Uses RTTI, Vcl.ImgList, uSelectDirectoryEx, TSTOProjectWorkSpace.Types;

{$R *.dfm}

procedure TFrmProjectSettings.EditCustomModPathSubEditButton0Click(Sender: TObject);
Var lSelDir : AnsiString;
begin
  If SelectDirectoryEx('Custom mod path', ExtractFilePath(ParamStr(0)),
    lSelDir, True, False, False) Then
    EditCustomModPath.Text := lSelDir;
end;

procedure TFrmProjectSettings.EditCustomScriptPathSubEditButton0Click(Sender: TObject);
Var lSelDir : AnsiString;
begin
  If SelectDirectoryEx('Custom script path', ExtractFilePath(ParamStr(0)),
    lSelDir, True, False, False) Then
    EditCustomScriptPath.Text := lSelDir;
end;

procedure TFrmProjectSettings.EditOutputPathSubEditButton0Click(Sender: TObject);
Var lSelDir : AnsiString;
Begin
  If SelectDirectoryEx('Output path', ExtractFilePath(ParamStr(0)),
    lSelDir, True, False, False) Then
    EditOutputPath.Text := lSelDir;
End;

procedure TFrmProjectSettings.FormActivate(Sender: TObject);
begin
  WindowState := TRttiEnumerationType.GetValue<TWindowState>(FFormSettings.WindowState);
  Left        := FFormSettings.X;
  Top         := FFormSettings.Y;
  Height      := FFormSettings.H;
  Width       := FFormSettings.W;
end;

procedure TFrmProjectSettings.FormCloseQuery(Sender: TObject;
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

procedure TFrmProjectSettings.FormCreate(Sender: TObject);
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

  EditCustomScriptPath.EditButton.Images     := lImgList;
  EditCustomScriptPath.EditButton.ImageIndex := 0;

  EditCustomModPath.EditButton.Images     := lImgList;
  EditCustomModPath.EditButton.ImageIndex := 0;
end;

procedure TFrmProjectSettings.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #27 Then
  Begin
    Key := #0;
    Close;
  End;
end;

Procedure TFrmProjectSettings.AfterConstruction();
Begin
  InHerited AfterConstruction();
End;

Function TFrmProjectSettings.GetWorkSpaceProject() : ITSTOWorkSpaceProject;
Begin
  Result := FWorkSpaceProject;
End;

procedure TFrmProjectSettings.rgProjectTypeClick(Sender: TObject);
begin
  EditCustomScriptPath.Enabled := rgProjectType.ItemIndex = 0;
end;

Procedure TFrmProjectSettings.SetWorkSpaceProject(AWorkSpaceProject : ITSTOWorkSpaceProject);
Begin
  FWorkSpaceProject := AWorkSpaceProject;

  Caption := 'Project Options for ' + FWorkSpaceProject.ProjectName;

  EditProjectName.Text      := FWorkSpaceProject.ProjectName;
  rgProjectKind.ItemIndex   := Ord(FWorkSpaceProject.ProjectKind);
  rgProjectType.ItemIndex   := Ord(FWorkSpaceProject.ProjectType);
  chkPackOutput.Checked     := FWorkSpaceProject.PackOutput;
  EditOutputPath.Text       := FWorkSpaceProject.OutputPath;
  EditCustomScriptPath.Text := FWorkSpaceProject.CustomScriptPath;
  EditCustomModPath.Text    := FWorkSpaceProject.CustomModPath;
End;

Procedure TFrmProjectSettings.SetAppSettings(AAppSettings : ITSTOXMLSettings);
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

procedure TFrmProjectSettings.SpTbxSaveClick(Sender: TObject);
begin
  FWorkSpaceProject.ProjectName      := EditProjectName.Text;
  FWorkSpaceProject.ProjectKind      := TWorkSpaceProjectKind(rgProjectKind.ItemIndex);
  FWorkSpaceProject.ProjectType      := TWorkSpaceProjectType(rgProjectType.ItemIndex);
  FWorkSpaceProject.PackOutput       := chkPackOutput.Checked;
  FWorkSpaceProject.OutputPath       := EditOutputPath.Text;
  FWorkSpaceProject.CustomScriptPath := EditCustomScriptPath.Text;
  FWorkSpaceProject.CustomModPath    := EditCustomModPath.Text;

  ModalResult := mrOk;
end;

end.
