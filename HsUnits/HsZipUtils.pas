unit HsZipUtils;

interface

Uses Classes,
  AbZipTyp, AbArcTyp,
  HsInterfaceEx, HsStreamEx, HsStringListEx;

Type
  IZipProgress = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-85D5-7C2008F6424E}']
    Function  GetItemProgress() : Byte;
    Procedure SetItemProgress(Const AItemProgress : Byte);

    Function  GetArchiveProgress() : Byte;
    Procedure SetArchiveProgress(Const AArchiveProgress : Byte);

    Function  GetCurOperation() : String;
    Procedure SetCurOperation(Const ACurOperation : String);

    Procedure Show();
    
    Property ItemProgress    : Byte   Read GetItemProgress    Write SetItemProgress;
    Property ArchiveProgress : Byte   Read GetArchiveProgress Write SetArchiveProgress;
    Property CurOperation    : String Read GetCurOperation    Write SetCurOperation;

  End;
  
  IHsMemoryZipper = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-9162-498B918CE4A2}']
    Function GetItem(Index : Integer) : TAbZipItem;

    Function GetCount() : Integer;

    Function  GetFileName() : String;
    Procedure SetFileName(Const AFileName : String);

    Function  GetShowProgress() : Boolean;
    Procedure SetShowProgress(Const AShowProgress : Boolean);

    Function  GetPassword() : String;
    Procedure SetPassword(Const APassWord : String);

    Function  GetStoreOptions() : TAbStoreOptions;
    Procedure SetStoreOptions(Const AStoreOptions : TAbStoreOptions);

    Procedure AddFiles(Const AFileMask : String; ASearchAttr : Integer); OverLoad;
    Procedure AddFiles(Const AFileList : IHsStringListEx; ASearchAttr : Integer); OverLoad;
    Procedure AddFromStream(Const AFileName : String; AFromStream : TStream); OverLoad;
    Procedure AddFromStream(Const AFileName : String; AFromStream : IStreamEx); OverLoad;
    Procedure ExtractToStream(Const AFileName : String; AToStream : TStream); OverLoad;
    Procedure ExtractToStream(Const AFileName : String; AToStream : IStreamEx); OverLoad;
    Procedure ExtractToStream(Const Index : Integer; AToStream : TStream); OverLoad;
    Procedure ExtractToStream(Const Index : Integer; AToStream : IStreamEx); OverLoad;
    Procedure ExtractFiles(Const AFileMask, ATargetDir : String); OverLoad;
    Procedure ExtractFiles(Const AFileList : IHsStringListEx; ATargetDir : String); OverLoad;

    Function  FindFile(Const AFileName : String) : Integer;
    Procedure RemovePathPart(Const APathPart : String);

    Procedure LoadFromStream(AStream : IStreamEx);
    Procedure LoadFromFile(Const FileName : String);
    Procedure SaveToFile(Const AFileName : String);

    Property Items[Index : Integer] : TAbZipItem Read GetItem; Default;

    Property Count        : Integer         Read GetCount;
    Property FileName     : String          Read GetFileName     Write SetFileName;
    Property ShowProgress : Boolean         Read GetShowProgress Write SetShowProgress;
    Property Password     : String          Read GetPassword     Write SetPassword;
    Property StoreOptions : TAbStoreOptions Read GetStoreOptions Write SetStoreOptions;
  End;

  IHsMemoryZippers = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-BEE9-25DFC852367E}']
    Function  Get(Index: Integer) : IHsMemoryZipper;
    Procedure Put(Index: Integer; Const Item: IHsMemoryZipper);

    Function  Add() : IHsMemoryZipper;

    Property Items[Index : Integer] : IHsMemoryZipper Read Get Write Put; Default;

  End;

  THsMemoryZipper = Class(TMemoryStreamEx, IHsMemoryZipper)
  Private
    FZipArchive   : TAbZipArchive;
    FZipProgress  : IZipProgress;
    FFileName     : String;
    FShowProgress : Boolean;

    Procedure InitArchive();
    Procedure DoInsertStream(Sender : TObject; Item : TAbArchiveItem; OutStream, InStream : TStream);
    Procedure DoInsertFile(Sender : TObject; Item : TAbArchiveItem; OutStream : TStream);
    Procedure UnzipProc(Sender : TObject; Item : TAbArchiveItem; Const NewName : String);
    Procedure UnzipToStreamProc(Sender : TObject; Item : TAbArchiveItem; OutStream : TStream);

    Procedure DoArchiveSaveProgress(Sender : TObject; Progress : Byte; Var Abort : Boolean);
    Procedure DoArchiveExtractProgress(Sender : TObject; Progress : Byte; Var Abort : Boolean);
    Procedure DoArchiveItemProgress(Sender : TObject;
      Item : TAbArchiveItem; Progress : Byte; var Abort : Boolean);

    Function GetImpl() : TStreamImplementor;

  Protected
    Property MZImpl : TStreamImplementor Read GetImpl Implements IHsMemoryZipper;

    Function GetItem(Index : Integer) : TAbZipItem;

    Function  GetCount() : Integer;

    Function  GetFileName() : String;
    Procedure SetFileName(Const AFileName : String);

    Function  GetShowProgress() : Boolean;
    Procedure SetShowProgress(Const AShowProgress : Boolean);

    Function  GetPassword() : String;
    Procedure SetPassword(Const APassWord : String);

    Function  GetStoreOptions() : TAbStoreOptions;
    Procedure SetStoreOptions(Const AStoreOptions : TAbStoreOptions);

    Procedure AddFiles(Const AFileMask : String; ASearchAttr : Integer); OverLoad;
    Procedure AddFiles(Const AFileList : IHsStringListEx; ASearchAttr : Integer); OverLoad;
    Procedure AddFromStream(Const AFileName : String; AFromStream : TStream); OverLoad;
    Procedure AddFromStream(Const AFileName : String; AFromStream : IStreamEx); OverLoad;
    Procedure ExtractToStream(Const AFileName : String; AToStream : TStream); OverLoad;
    Procedure ExtractToStream(Const AFileName : String; AToStream : IStreamEx); OverLoad;
    Procedure ExtractToStream(Const Index : Integer; AToStream : TStream); OverLoad;
    Procedure ExtractToStream(Const Index : Integer; AToStream : IStreamEx); OverLoad;
    Procedure ExtractFiles(Const AFileMask, ATargetDir : String); OverLoad;
    Procedure ExtractFiles(Const AFileList : IHsStringListEx; ATargetDir : String); OverLoad;

    Function  FindFile(Const AFileName : String) : Integer;
    Procedure RemovePathPart(Const APathPart : String);

    Procedure LoadFromStream(AStream : IStreamEx); OverLoad;
    Procedure LoadFromFile(Const FileName : String);

  Public
    Constructor Create(); ReIntroduce; Virtual;
    Destructor  Destroy(); OverRide;

  End;

  THsMemoryZippers = Class(TInterfaceListEx, IHsMemoryZippers)
  Protected
    Function  Get(Index : Integer) : IHsMemoryZipper; OverLoad;
    Procedure Put(Index : Integer; Const Item : IHsMemoryZipper); OverLoad;
    Function  Add() : IHsMemoryZipper; ReIntroduce; OverLoad;

  End;


implementation

Uses Forms, SysUtils, StdCtrls, ComCtrls, ExtCtrls, Controls,
  AbZipPrc, AbUnzPrc, AbExcept, AbUtils;

Type
  TZipperProgress = Class(TInterfacedObjectEx, IZipProgress)
  Private Type
    TZipperProgressImpl = Class(TForm)
    Private
      FlblStatus       : TLabel;
      FItemProgress    : TProgressBar;
      FArchiveProgress : TProgressBar;

      Function  GetItemProgress() : Byte;
      Procedure SetItemProgress(Const AItemProgress : Byte);

      Function  GetArchiveProgress() : Byte;
      Procedure SetArchiveProgress(Const AArchiveProgress : Byte);

      Function  GetCurOperation() : String;
      Procedure SetCurOperation(Const ACurOperation : String);

    Protected
      Procedure DoClose(Var Action : TCloseAction); OverRide;

    Public
      Constructor Create(AOwner : TComponent); OverRide;

    End;

  Private
    FZipProgress : TZipperProgressImpl;
    Function GetImpl() : TZipperProgressImpl;

  Protected
    Property IntfImpl : TZipperProgressImpl Read GetImpl Implements IZipProgress;

    Procedure Created(); OverRide;

  Public
    Destructor Destroy(); OverRide;

  End;


Procedure TZipperProgress.Created();
Begin
  FZipProgress := TZipperProgressImpl.Create(Nil);
End;

Destructor TZipperProgress.Destroy();
Begin
  FreeAndNil(FZipProgress);
  InHerited Destroy();
End;

Function TZipperProgress.GetImpl() : TZipperProgressImpl;
Begin
  Result := FZipProgress;
End;

Constructor TZipperProgress.TZipperProgressImpl.Create(AOwner : TComponent);
Var lPanel : TPanel;
Begin
  CreateNew(AOwner);

  Name        := 'FrmProgress';
  Caption     := 'Progress...';
  Width       := 350;
  Height      := 110;
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
    Height     := 57;
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

  FArchiveProgress := TProgressBar.Create(Self);
  With FArchiveProgress Do
  Begin
    Name     := 'PBarArchive';
    Parent   := lPanel;
    Left     := 0;
    Top      := 39;
    Width    := 317;
    Height   := 16;
    Smooth   := True;
    Position := 0;
    Max      := 100;
  End;
End;

Procedure TZipperProgress.TZipperProgressImpl.DoClose(Var Action : TCloseAction);
Begin
  Action := caFree;
End;

Function TZipperProgress.TZipperProgressImpl.GetItemProgress() : Byte;
Begin
  Result := FItemProgress.Position;
End;

Procedure TZipperProgress.TZipperProgressImpl.SetItemProgress(Const AItemProgress : Byte);
Begin
  FItemProgress.Position := AItemProgress;
  Application.ProcessMessages();
End;

Function TZipperProgress.TZipperProgressImpl.GetArchiveProgress() : Byte;
Begin
  Result := FArchiveProgress.Position;
End;

Procedure TZipperProgress.TZipperProgressImpl.SetArchiveProgress(Const AArchiveProgress : Byte);
Begin
  FArchiveProgress.Position := AArchiveProgress;
  Application.ProcessMessages();
End;

Function TZipperProgress.TZipperProgressImpl.GetCurOperation() : String;
Begin
  Result := FlblStatus.Caption;
End;

Procedure TZipperProgress.TZipperProgressImpl.SetCurOperation(Const ACurOperation : String);
Begin
  FlblStatus.Caption := ACurOperation;
  Application.ProcessMessages();
End;

(******************************************************************************)

Constructor THsMemoryZipper.Create();
Begin
  InHerited Create();

  FShowProgress := True;
  InitArchive();
End;

Destructor THsMemoryZipper.Destroy();
Begin
  FreeAndNil(FZipArchive);
  InHerited Destroy();
End;

Function THsMemoryZipper.GetImpl() : TStreamImplementor;
Begin
  Result := InHerited MemStreamImpl;
End;

Procedure THsMemoryZipper.DoArchiveSaveProgress(Sender : TObject; Progress : Byte; Var Abort : Boolean);
Begin
  If Assigned(FZipProgress) Then
    FZipProgress.ArchiveProgress := Progress;
End;

Procedure THsMemoryZipper.DoArchiveExtractProgress(Sender : TObject; Progress : Byte; Var Abort : Boolean);
Begin
  If Assigned(FZipProgress) Then
    FZipProgress.ArchiveProgress := Progress;
End;

procedure THsMemoryZipper.DoArchiveItemProgress(Sender : TObject;
  Item : TAbArchiveItem; Progress : Byte; var Abort : Boolean);
Var lCurOp : String;
Begin
  If Assigned(FZipProgress) Then
  Begin
    Case Item.Action Of
      aaAdd, aaStreamAdd : lCurOp := 'Adding : ';
      Else
        lCurOp := 'Extracting : ';
    End;
    lCurOp := lCurOp + Item.FileName;

    FZipProgress.CurOperation := lCurOp;
    FZipProgress.ItemProgress := Progress;
  End;
End;

Procedure THsMemoryZipper.InitArchive();
Begin
  FreeAndNil(FZipArchive);
  FZipArchive := TAbZipArchive.CreateFromStream(Self, '');

  FZipArchive.OnArchiveSaveProgress := DoArchiveSaveProgress;
  FZipArchive.OnArchiveProgress     := DoArchiveExtractProgress;
  FZipArchive.OnArchiveItemProgress := DoArchiveItemProgress;

  FZipArchive.InsertFromStreamHelper := DoInsertStream;
  FZipArchive.InsertHelper           := DoInsertFile;
  FZipArchive.ExtractHelper          := UnzipProc;
  FZipArchive.ExtractToStreamHelper  := UnzipToStreamProc;

//  FZipArchive.AutoSave := True;
  FZipArchive.CompressionMethodToUse := smDeflated;
  FZipArchive.StoreOptions := [soStripDrive, soStripPath, soRemoveDots, soReplace];
  FZipArchive.ExtractOptions := [eoCreateDirs, eoRestorePath];
End;

Procedure THsMemoryZipper.DoInsertStream(Sender: TObject; Item: TAbArchiveItem; OutStream, InStream: TStream);
Begin
  If Assigned(InStream) Then
  Begin
    Item.ExternalFileAttributes := 0;
    Item.LastModTimeAsDateTime  := EncodeDate(1980, 01, 01);
    DoZipFromStream(TAbZipArchive(Sender), TAbZipItem(Item), OutStream, InStream);
  End
  Else
    Raise EAbZipNoInsertion.Create();
End;

Procedure THsMemoryZipper.DoInsertFile(Sender: TObject; Item: TAbArchiveItem; OutStream: TStream);
Var UncompressedStream : TStream;
    SaveDir            : String;
    AttrEx             : TAbAttrExRec;
Begin
  GetDir(0, SaveDir);
  Try
    If TAbZipArchive(Sender).BaseDirectory <> '' Then
      ChDir(TAbZipArchive(Sender).BaseDirectory);

    AbFileGetAttrEx(Item.DiskFileName, AttrEx);
    If AttrEx.Attr And faDirectory <> 0 Then
      UncompressedStream := TMemoryStream.Create()
    Else
      UncompressedStream := TFileStream.Create(Item.DiskFileName, fmOpenRead Or fmShareDenyWrite);

    Try
      DoInsertStream(Sender, Item, OutStream, UncompressedStream);

      Finally
        UncompressedStream.Free();
    End;

    Finally
      ChDir(SaveDir);
  End;
End;

Procedure THsMemoryZipper.UnzipProc(Sender: TObject; Item: TAbArchiveItem;
  Const NewName: String);
Begin
  AbUnzip(TAbZipArchive(Sender), TAbZipItem(Item), NewName);
End;

Procedure THsMemoryZipper.UnzipToStreamProc(Sender: TObject; Item: TAbArchiveItem;
  OutStream: TStream);
Begin
  AbUnzipToStream(TAbZipArchive(Sender), TAbZipItem(Item), OutStream);
End;

Function THsMemoryZipper.GetItem(Index : Integer) : TAbZipItem;
Begin
  Result := FZipArchive[Index];
End;

Function THsMemoryZipper.GetCount() : Integer;
Begin
  Result := FZipArchive.Count;
End;

Function THsMemoryZipper.GetFileName() : String;
Begin
  Result := FFileName;
End;

Procedure THsMemoryZipper.SetFileName(Const AFileName : String);
Begin
  FFileName := AFileName;
End;

Function THsMemoryZipper.GetShowProgress() : Boolean;
Begin
  Result := FShowProgress;
End;

Procedure THsMemoryZipper.SetShowProgress(Const AShowProgress : Boolean);
Begin
  FShowProgress := AShowProgress;
End;

Function THsMemoryZipper.GetPassword() : String;
Begin
  Result := FZipArchive.Password;
End;

Procedure THsMemoryZipper.SetPassword(Const APassWord : String);
Begin
  FZipArchive.Password := APassWord;
End;

Function THsMemoryZipper.GetStoreOptions() : TAbStoreOptions;
Begin
  Result := FZipArchive.StoreOptions;
End;

Procedure THsMemoryZipper.SetStoreOptions(Const AStoreOptions : TAbStoreOptions);
Begin
  FZipArchive.StoreOptions := AStoreOptions;
End;

Procedure THsMemoryZipper.AddFiles(Const AFileMask : String; ASearchAttr : Integer);
Begin
  If FShowProgress Then
  Begin
    FZipProgress := TZipperProgress.Create();
    FZipProgress.Show();
  End;

  Try
    FZipArchive.AddFiles(AFileMask, ASearchAttr);
    FZipArchive.Save();

    Finally
      FZipProgress := Nil;
  End;
End;

Procedure THsMemoryZipper.AddFiles(Const AFileList : IHsStringListEx; ASearchAttr : Integer);
Var X : Integer;
Begin
  If FShowProgress Then
  Begin
    FZipProgress := TZipperProgress.Create();
    FZipProgress.Show();
  End;

  Try
    For X := 0 To AFileList.Count - 1 Do
      FZipArchive.AddFiles(AFileList[X], faAnyFile);

    FZipArchive.Save();

    Finally
      FZipProgress := Nil;
  End;
End;

Procedure THsMemoryZipper.AddFromStream(Const AFileName : String; AFromStream : TStream);
Begin
  If FShowProgress Then
  Begin
    FZipProgress := TZipperProgress.Create();
    FZipProgress.Show();
  End;

  Try
    FZipArchive.AddFromStream(AFileName, AFromStream);

    Finally
      FZipProgress := Nil;
  End;
End;

Procedure THsMemoryZipper.AddFromStream(Const AFileName : String; AFromStream : IStreamEx);
Begin
  AddFromStream(AFileName, TStream(AFromStream.InterfaceObject));
End;

Procedure THsMemoryZipper.ExtractToStream(Const AFileName : String; AToStream : TStream);
Begin
  FZipArchive.ExtractToStream(AFileName, AToStream);
End;

Procedure THsMemoryZipper.ExtractToStream(Const AFileName : String; AToStream : IStreamEx);
Begin
  ExtractToStream(AFileName, TStream(AToStream.InterfaceObject));
End;

Type
  TAbZipArchiveHack = Class(TAbZipArchive);

Procedure THsMemoryZipper.ExtractToStream(Const Index : Integer; AToStream : TStream);
Begin
  TAbZipArchiveHack(FZipArchive).ExtractItemToStreamAt(Index, AToStream);
End;

Procedure THsMemoryZipper.ExtractToStream(Const Index : Integer; AToStream : IStreamEx);
Begin
  ExtractToStream(Index, TStream(AToStream.InterfaceObject));
End;

Procedure THsMemoryZipper.ExtractFiles(Const AFileMask, ATargetDir : String);
Begin
  If FShowProgress Then
  Begin
    FZipProgress := TZipperProgress.Create();
    FZipProgress.Show();
  End;

  Try
    If Not DirectoryExists(ATargetDir) Then
      ForceDirectories(ATargetDir);
    FZipArchive.BaseDirectory := ATargetDir;
    FZipArchive.ExtractFiles(AFileMask);

    Finally
      FZipProgress := Nil;
  End;
End;

Procedure THsMemoryZipper.ExtractFiles(Const AFileList : IHsStringListEx; ATargetDir : String);
Var X : Integer;
Begin
  For X := 0 To AFileList.Count - 1 Do
    If FindFile(AFileList[X]) > -1 Then
      ExtractFiles(AFileList[X], ATargetDir);
End;

Function THsMemoryZipper.FindFile(Const AFileName : String) : Integer;
Begin
  Result := FZipArchive.FindFile(AFileName);
End;

Procedure THsMemoryZipper.RemovePathPart(Const APathPart : String);
Var X : Integer;
    lZipArchive : IHsMemoryZipper;
    lMemStrm : IMemoryStreamEx;
Begin
  lZipArchive := THsMemoryZipper.Create();
  lMemStrm    := TMemoryStreamEx.Create();
  Try
    lZipArchive.StoreOptions := lZipArchive.StoreOptions - [soStripPath];
    lZipArchive.ShowProgress := False;
    For X := 0 To FZipArchive.Count - 1 Do
    Begin
      lMemStrm.Clear();
      FZipArchive.ExtractToStream(FZipArchive[X].FileName, TStream(lMemStrm.InterfaceObject));
      lMemStrm.Position := 0;
      lZipArchive.AddFromStream(StringReplace(FZipArchive[X].FileName, APathPart, '', [rfReplaceAll, rfIgnoreCase]), lMemStrm);
    End;

    LoadFromStream(lZipArchive As IMemoryStreamEx);

    Finally
      lZipArchive := Nil;
      lMemStrm    := Nil;
  End;
End;

Procedure THsMemoryZipper.LoadFromStream(AStream : IStreamEx);
Begin
  InHerited LoadFromStream(AStream);

  FZipArchive.ItemList.Clear();
  FZipArchive.Load();
End;

Procedure THsMemoryZipper.LoadFromFile(Const FileName : String);
Begin
  If FileExists(FileName) Then
  Begin
    InHerited LoadFromFile(FileName);

    FFileName := FileName;
    FZipArchive.ItemList.Clear();
    FZipArchive.Load();
  End;
End;

(******************************************************************************)

Function THsMemoryZippers.Get(Index : Integer) : IHsMemoryZipper;
Begin
  Result := InHerited Items[Index] As IHsMemoryZipper;
End;

Procedure THsMemoryZippers.Put(Index : Integer; Const Item : IHsMemoryZipper);
Begin
  InHerited Items[Index] := Item;
End;

Function THsMemoryZippers.Add() : IHsMemoryZipper;
Begin
  Result := THsMemoryZipper.Create();
  InHerited Add(Result);
End;

end.
