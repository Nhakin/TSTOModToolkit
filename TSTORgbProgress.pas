unit TSTORgbProgress;

interface

Uses
  HsInterfaceEx;

Type
  IRgbProgress = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-95F5-7E2008F64210}']
    Function  GetItemProgress() : Byte;
    Procedure SetItemProgress(Const AItemProgress : Byte);

    Function  GetCurOperation() : String;
    Procedure SetCurOperation(Const ACurOperation : String);

    Function  GetArchiveProgress() : Byte;
    Procedure SetArchiveProgress(Const AArchiveProgress : Byte);

    Function  GetCurArchiveName() : String;
    Procedure SetCurArchiveName(Const ACurArchiveName : String);

    Procedure Show();
    Procedure Hide();
    
    Property ItemProgress    : Byte   Read GetItemProgress    Write SetItemProgress;
    Property CurOperation    : String Read GetCurOperation    Write SetCurOperation;
    Property ArchiveProgress : Byte   Read GetArchiveProgress Write SetArchiveProgress;
    Property CurArchiveName  : String Read GetCurArchiveName  Write SetCurArchiveName;

  End;

  TRgbProgress = Class(TObject)
  Public
    Class Function CreateRgbProgress() : IRgbProgress;

  End;

implementation

Uses SysUtils, Forms, Classes, ExtCtrls, ComCtrls, StdCtrls, Controls;

Type
  TRgbExtractProgress = Class(TInterfacedObjectEx, IRgbProgress)
  Private Type
    TRgbExtractProgressImpl = Class(TForm)
    Private
      FlblStatus       : TLabel;
      FItemProgress    : TProgressBar;
      FlblPackage      : TLabel;
      FArchiveProgress : TProgressBar;

      Function  GetItemProgress() : Byte;
      Procedure SetItemProgress(Const AItemProgress : Byte);

      Function  GetCurOperation() : String;
      Procedure SetCurOperation(Const ACurOperation : String);

      Function  GetArchiveProgress() : Byte;
      Procedure SetArchiveProgress(Const AArchiveProgress : Byte);

      Function  GetCurArchiveName() : String;
      Procedure SetCurArchiveName(Const ACurArchiveName : String);

    Protected
      Procedure DoClose(Var Action : TCloseAction); OverRide;

    Public
      Constructor Create(AOwner : TComponent); OverRide;

    End;

  Private
    FProgressFrm : TRgbExtractProgressImpl;

    Function GetImpl() : TRgbExtractProgressImpl;

  Protected
    Property IntfImpl : TRgbExtractProgressImpl Read GetImpl Implements IRgbProgress;

    Procedure Created(); OverRide;

  Public
    Destructor Destroy(); OverRide;

  End;

Class Function TRgbProgress.CreateRgbProgress() : IRgbProgress;
Begin
  Result := TRgbExtractProgress.Create();
End;

(******************************************************************************)

Procedure TRgbExtractProgress.Created();
Begin
  FProgressFrm := TRgbExtractProgressImpl.Create(Nil);
End;

Destructor TRgbExtractProgress.Destroy();
Begin
  FreeAndNil(FProgressFrm);

  InHerited Destroy();
End;

Function TRgbExtractProgress.GetImpl() : TRgbExtractProgressImpl;
Begin
  Result := FProgressFrm;
End;

Constructor TRgbExtractProgress.TRgbExtractProgressImpl.Create(AOwner : TComponent);
Var lPanel : TPanel;
Begin
  CreateNew(AOwner);

  Name        := 'FrmProgress';
  Caption     := 'Progress...';
  Width       := 350;
  Height      := 130;
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
    Height     := 75;
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

  FItemProgress := TProgressBar.Create(Self);
  With FItemProgress Do
  Begin
    Name     := 'PBarItem';
    Parent   := lPanel;
    Left     := 0;
    Top      := 19;
    Width    := 317;
    Height   := 16;
    Smooth   := True;
    Position := 0;
    Max      := 100;
  End;

  FlblPackage := TLabel.Create(Self);
  With FlblPackage Do
  Begin
    Name   := 'lblPackage';
    Parent := lPanel;
    Left   := 0;
    Top    := 39;
    Width  := 3;
    Height := 13;
    AutoSize := True;
    Caption := '';
  End;

  FArchiveProgress := TProgressBar.Create(Self);
  With FArchiveProgress Do
  Begin
    Name     := 'PBarArchive';
    Parent   := lPanel;
    Left     := 0;
    Top      := 56;
    Width    := 317;
    Height   := 16;
    Smooth   := True;
    Position := 0;
    Max      := 100;
  End;
End;

Procedure TRgbExtractProgress.TRgbExtractProgressImpl.DoClose(Var Action : TCloseAction);
Begin
  Action := caFree;
End;

Function TRgbExtractProgress.TRgbExtractProgressImpl.GetItemProgress() : Byte;
Begin
  Result := FItemProgress.Position;
End;

Procedure TRgbExtractProgress.TRgbExtractProgressImpl.SetItemProgress(Const AItemProgress : Byte);
Begin
  FItemProgress.Position := AItemProgress;
  Application.ProcessMessages();
End;

Function TRgbExtractProgress.TRgbExtractProgressImpl.GetArchiveProgress() : Byte;
Begin
  Result := FArchiveProgress.Position;
End;

Procedure TRgbExtractProgress.TRgbExtractProgressImpl.SetArchiveProgress(Const AArchiveProgress : Byte);
Begin
  FArchiveProgress.Position := AArchiveProgress;
  Application.ProcessMessages();
End;

Function TRgbExtractProgress.TRgbExtractProgressImpl.GetCurArchiveName() : String;
Begin
  Result := FlblPackage.Caption;
End;

Procedure TRgbExtractProgress.TRgbExtractProgressImpl.SetCurArchiveName(Const ACurArchiveName : String);
Begin
  FlblPackage.Caption := ACurArchiveName;
  Application.ProcessMessages();
End;

Function TRgbExtractProgress.TRgbExtractProgressImpl.GetCurOperation() : String;
Begin
  Result := FlblStatus.Caption;
End;

Procedure TRgbExtractProgress.TRgbExtractProgressImpl.SetCurOperation(Const ACurOperation : String);
Begin
  FlblStatus.Caption := ACurOperation;
  Application.ProcessMessages();
End;

end.
