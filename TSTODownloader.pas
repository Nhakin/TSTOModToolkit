unit TSTODownloader;

interface

Uses HsInterfaceEx, TSTOPackageList;

Type
  IHttpProgress = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-880A-00CC652497B1}']
    Function  GetMaxProgress() : Integer;
    Procedure SetMaxProgress(Const Value: Integer);

    Function  GetCurProgress() : Integer;
    Procedure SetCurProgress(Const Value: Integer);

    Procedure SetCurOperation(Const Value: String);

    Procedure Show();
    Procedure Hide();
    
    Property MaxProgress  : Integer Read GetMaxProgress Write SetMaxProgress;
    Property CurProgress  : Integer Read GetCurProgress Write SetCurProgress;
    Property CurOperation : String  Write SetCurOperation;

  End;

  ITSTODownloader = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-9555-B31ED1BC32B6}']
    Function  GetServerName() : String;
    Procedure SetServerName(Const AServerName : String);

    Function  GetDownloadPath() : String;
    Procedure SetDownloadPath(Const ADownloadPath : String);

    Procedure AddFile(Const AFileName : String);
    Procedure DownloadFile(); OverLoad;
    Procedure DownloadFile(Const AShowProgress : Boolean; Const AConfirmOverWrite : Boolean = True); OverLoad;
    Procedure DownloadFiles(AFileList : ITSTOPackageNodes);
    Procedure DownloadDlcIndex(); OverLoad;
    Procedure DownloadDlcIndex(Var ADlcIndexFileName : String; Const AShowProgress : Boolean = True; Const AOverWriteIndex : Boolean = True); OverLoad;

    Property ServerName   : String Read GetServerName   Write SetServerName;
    Property DownloadPath : String Read GetDownloadPath Write SetDownloadPath;

  End;

  TTSTODownloader = Class(TObject)
  Public
    Class Function CreateDownloader() : ITSTODownloader;

  End;

implementation

Uses Classes, Forms, StdCtrls, ComCtrls, ExtCtrls, SysUtils, Controls, Dialogs,
  HsHttpEx, HsStreamEx, HsStringListEx, HsZipUtils, HsXmlDocEx;

Type
  THttpDownloadProgress = Class(TInterfacedObjectEx, IHttpProgress)
  Private Type
    THttpDownloadProgressImpl = Class(TForm)
    Private
      FlblStatus   : TLabel;
      FProgressBar : TProgressBar;

      Function  GetMaxProgress() : Integer;
      Procedure SetMaxProgress(Const Value: Integer);

      Function  GetCurProgress() : Integer;
      Procedure SetCurProgress(Const Value: Integer);

      Procedure SetCurOperation(Const Value: String);

    Protected
      Procedure DoClose(Var Action : TCloseAction); OverRide;

    Public
      Constructor Create(AOwner : TComponent); OverRide;

    End;

  Private
    FDownloadFrm : THttpDownloadProgressImpl;

    Function GetImpl() : THttpDownloadProgressImpl;

  Protected
    Property IntfImpl : THttpDownloadProgressImpl Read GetImpl Implements IHttpProgress;

    Procedure Created(); OverRide;

  Public
    Destructor Destroy(); OverRide;

  End;
(*
  THttpDownloadProgress = Class(TForm, IHttpProgress)
  Private
    FIntfImpl    : TInterfaceExImplementor;
    FlblStatus   : TLabel;
    FProgressBar : TProgressBar;

    Function  GetMaxProgress() : Integer;
    Procedure SetMaxProgress(Const Value: Integer);

    Function  GetCurProgress() : Integer;
    Procedure SetCurProgress(Const Value: Integer);

    Procedure SetCurOperation(Const Value: String);

    Function GetImpl() : TInterfaceExImplementor;

  Protected
    Property IntfImpl : TInterfaceExImplementor Read GetImpl Implements IHttpProgress;

    Procedure DoClose(Var Action : TCloseAction); OverRide;

  Public
    Constructor Create(AOwner : TComponent); OverRide;

  End;
*)
  TTSTODownloaderImpl = Class(TInterfacedObjectEx, ITSTODownloader)
  Private
    FServerName   : String;
    FDownloadPath : String;

    FHttp         : IHsIdHTTPEx;
    FProgress     : IHttpProgress;
    FFileList     : IHsStringListEx;

    Procedure OnDownloadProgress(Const AFileName : String; Const ACurProgress, AMaxValue : Int64);

  Protected
    Function  GetServerName() : String;
    Procedure SetServerName(Const AServerName : String);

    Function  GetDownloadPath() : String;
    Procedure SetDownloadPath(Const ADownloadPath : String);

    Procedure AddFile(Const AFileName : String);
    Procedure DownloadFile(Const AShowProgress : Boolean; Const AConfirmOverWrite : Boolean = True); OverLoad;
    Procedure DownloadFile(); OverLoad;
    Procedure DownloadFiles(AFileList : ITSTOPackageNodes);
    Procedure DownloadDlcIndex(); OverLoad;
    Procedure DownloadDlcIndex(Var ADlcIndexFileName : String; Const AShowProgress : Boolean = True; Const AOverWriteIndex : Boolean = True); OverLoad;

  Public
    Destructor Destroy(); OverRide;

  End;

Class Function TTSTODownloader.CreateDownloader() : ITSTODownloader;
Begin
  Result := TTSTODownloaderImpl.Create();
End;

Procedure THttpDownloadProgress.Created();
Begin
  FDownloadFrm := THttpDownloadProgressImpl.Create(Nil);
End;

Destructor THttpDownloadProgress.Destroy();
Begin
  FreeAndNil(FDownloadFrm);
  InHerited Destroy();
End;

Function THttpDownloadProgress.GetImpl() : THttpDownloadProgressImpl;
Begin
  Result := FDownloadFrm;
End;

Constructor THttpDownloadProgress.THttpDownloadProgressImpl.Create(AOwner : TComponent);
Var lPanel : TPanel;
Begin
  CreateNew(AOwner);

  Name        := 'FrmProgress';
  Caption     := 'Progress...';
  Width       := 350;
  Height      := 95;
  Position    := poOwnerFormCenter;
  FormStyle   := fsStayOnTop;
  BorderIcons := [];

  lPanel := TPanel.Create(Self);
  With lPanel Do
  Begin
    Parent     := Self;
    Left       := 8;
    Top        := 15;
    Width      := 319;
    Height     := 37;
    BevelOuter := bvNone;
    Caption    := '';
  End;

  FlblStatus := TLabel.Create(Self);
  With FlblStatus Do
  Begin
    Name   := 'lblStatus';
    Parent := lPanel;
    Left   := 0;
    Top    := 0;
    Width  := 3;
    Height := 13;
    AutoSize := True;
  End;

  FProgressBar := TProgressBar.Create(Self);
  With FProgressBar Do
  Begin
    Name     := 'PBar';
    Parent   := lPanel;
    Left     := 0;
    Top      := 19;
    Width    := 317;
    Height   := 16;
    Smooth   := True;
  End;
End;

Procedure THttpDownloadProgress.THttpDownloadProgressImpl.DoClose(Var Action : TCloseAction);
Begin
  Action := caFree;
End;

Function THttpDownloadProgress.THttpDownloadProgressImpl.GetMaxProgress() : Integer;
Begin
  Result := FProgressBar.Max;
End;

Procedure THttpDownloadProgress.THttpDownloadProgressImpl.SetMaxProgress(Const Value: Integer);
Begin
  FProgressBar.Max := Value;
End;

Function THttpDownloadProgress.THttpDownloadProgressImpl.GetCurProgress() : Integer;
Begin
  Result := FProgressBar.Position;
End;

Procedure THttpDownloadProgress.THttpDownloadProgressImpl.SetCurProgress(Const Value: Integer);
Begin
  FProgressBar.Position := Value;
End;

Procedure THttpDownloadProgress.THttpDownloadProgressImpl.SetCurOperation(Const Value: String);
Begin
  FlblStatus.Caption := Value;
End;

Destructor TTSTODownloaderImpl.Destroy();
Begin
  FFileList := Nil;

  InHerited Destroy();
End;

Procedure TTSTODownloaderImpl.OnDownloadProgress(Const AFileName : String; Const ACurProgress, AMaxValue : Int64);
Var lPrc : Integer;
Begin
  If Assigned(FProgress) Then
  Begin
    lPrc := Round(ACurProgress / AMaxValue * 100);
    FProgress.CurOperation := 'Downloading ' + AFileName + ' - ' + IntToStr(lPrc) + ' %';
    FProgress.CurProgress  := lPrc;
    Application.ProcessMessages();
  End;
End;

Function TTSTODownloaderImpl.GetServerName() : String;
Begin
  Result := FServerName;
End;

Procedure TTSTODownloaderImpl.SetServerName(Const AServerName : String);
Begin
  FServerName := AServerName;
End;

Function TTSTODownloaderImpl.GetDownloadPath() : String;
Begin
  Result := FDownloadPath;
End;

Procedure TTSTODownloaderImpl.SetDownloadPath(Const ADownloadPath : String);
Begin
  FDownloadPath := ADownloadPath;
End;

Procedure TTSTODownloaderImpl.AddFile(Const AFileName : String);
Begin
  If Not Assigned(FFileList) Then
    FFileList := THsStringListEx.CreateList();

  FFileList.Add(AFileName);
End;

Procedure TTSTODownloaderImpl.DownloadFile(Const AShowProgress : Boolean; Const AConfirmOverWrite : Boolean = True);
Var X        : Integer;
    lMem     : IMemoryStreamEx;
    lCurPath : String;
    lConfirm : TModalResult;
Begin
  If Assigned(FFileList) And (FFileList.Count > 0) Then
  Begin
    FHttp := THsIdHTTPEx.Create();
    lMem  := TMemoryStreamEx.Create();
    Try
      If AShowProgress Then
      Begin
        FHttp.OnProgress := OnDownloadProgress;

        FProgress := THttpDownloadProgress.Create();
        FProgress.MaxProgress := 100;
        FProgress.Show();
      End;

      If AConfirmOverWrite Then
        lConfirm := mrNone
      Else
        lConfirm := mrYesToAll;

      For X := 0 To FFileList.Count - 1 Do
      Begin
        lMem.Clear();

        Application.ProcessMessages();
        Try
          If Not (lConfirm In [mrYesToAll, mrNoToAll]) Then
            If FileExists(FDownloadPath + StringReplace(FFileList[X], '/', '\', [rfReplaceAll, rfIgnoreCase])) Then
            Begin
              FProgress.Hide();
              lConfirm :=  MessageDlg('The file ' + ExtractFileName(StringReplace(FFileList[X], '/', '\', [rfReplaceAll, rfIgnoreCase])) + ' aleready exist.'#$D#$A'Do you want to overwrite it?', mtConfirmation, [mbYes, mbNo, mbYesToAll, mbNoToAll], 0);
              FProgress.Show();
            End;

          If lConfirm In [mrNone, mrYes, mrYesToAll] Then
          Begin
            FHttp.Get(FServerName + FFileList[X], TStream(lMem.InterfaceObject));


            FFileList[X] := StringReplace(FFileList[X], '/', '\', [rfReplaceAll, rfIgnoreCase]);
            lCurPath := FDownloadPath + ExtractFilePath(FFileList[X]);
            If Not DirectoryExists( lCurPath ) Then
              ForceDirectories(lCurPath);
            lMem.SaveToFile(FDownloadPath + FFileList[X]);
          End;

          Except
            With TStringList.Create() Do
            Try
              If FileExists('00-DebugWeb.txt') Then
                LoadFromFile('00-DebugWeb.txt');
              Add(FServerName + FFileList[X]);
              SaveToFile('00-DebugWeb.txt');

              Finally
                Free();
            End;
        End;

        Application.ProcessMessages();
      End;

      FFileList.Clear();

      Finally
        FProgress := Nil;
        FHttp     := Nil;
        lMem      := Nil;
    End;
  End;
End;

Procedure TTSTODownloaderImpl.DownloadFile();
Begin
  DownloadFile(True);
End;

Procedure TTSTODownloaderImpl.DownloadFiles(AFileList : ITSTOPackageNodes);
Var X : Integer;
Begin
  For X := 0 To AFileList.Count - 1 Do
    AddFile(StringReplace(AFileList[X].FileName, '\', '/', [rfReplaceAll, rfIgnoreCase]));
  DownloadFile();
End;

Procedure TTSTODownloaderImpl.DownloadDlcIndex(Var ADlcIndexFileName : String; Const AShowProgress : Boolean = True; Const AOverWriteIndex : Boolean = True);
Var lZip       : IHsMemoryZipper;
    lXml       : IXmlDocumentEx;
    lDlcIndex  : String;
    lNode      : IXmlNodeEx;
    lStrStream : IStringStreamEx;
Begin
  lZip := THsMemoryZipper.Create();
  lStrStream := TStringStreamEx.Create();
  Try
    AddFile('dlc/DLCIndex.zip');
    DownloadFile(AShowProgress, False);

    If FileExists(FDownloadPath + '\dlc\DLCIndex.zip') Then
    Begin
      lZip.LoadFromFile(FDownloadPath + '\dlc\DLCIndex.zip');
      lZip.ExtractToStream(lZip[0].FileName, TStream(lStrStream.InterfaceObject));

      lXml := LoadXmlData(lStrStream.DataString);
      Try
        lNode := lXml.SelectNode('//IndexFile[1]/@index');
        If Assigned(lNode) Then
        Try
          lDlcIndex := StringReplace(lNode.Text, ':', '/', [rfReplaceAll, rfIgnoreCase]);
          Finally
            lNode := Nil;
        End;

        Finally
          lXml := Nil;
      End;

      If AOverWriteIndex Or Not FileExists(FDownloadPath + lDlcIndex) Then
      Begin
        AddFile(lDlcIndex);
        DownloadFile(AShowProgress, False);
      End;
      
      ADlcIndexFileName := {FDownloadPath +} ExtractFileName(StringReplace(lDlcIndex, '/', '\', [rfReplaceAll]));
    End;

    Finally
      lStrStream := Nil;
      lZip       := Nil;
  End;
End;

Procedure TTSTODownloaderImpl.DownloadDlcIndex();
Var lDummy : String;
Begin
  DownloadDlcIndex(lDummy);
End;

end.
