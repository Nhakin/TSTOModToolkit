unit dIDEActions;

interface

{$I ASCRIPT.INC}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActnList, IDEMain, ImgList, atScript,
  (*
  {$IFDEF DELPHI9_LVL}
  fToolPalette,
  {$ENDIF}
  fObjectInspector, fWatches,
  *)
  atScripter, AdvMemo;

type
  TLastSearchMode = (lsNone, lsFind, lsReplace);

  TdmIDEActions = class(TDataModule)
    ActionList1: TActionList;
    acNewUnit: TAction;
    acNewForm: TAction;
    acOpenFile: TAction;
    acSaveFile: TAction;
    acSaveAsFile: TAction;
    acSaveAll: TAction;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    acCloseFile: TAction;
    acCloseAll: TAction;
    acExit: TAction;
    acToggleFormUnit: TAction;
    ImageList1: TImageList;
    acRun: TAction;
    acStepOver: TAction;
    acTraceInto: TAction;
    acRunTo: TAction;
    acReturn: TAction;
    acPause: TAction;
    acReset: TAction;
    acEvaluate: TAction;
    acAddWatch: TAction;
    acToggleBreak: TAction;
    acSaveProjectAs: TAction;
    acRemoveFromProject: TAction;
    acNewProject: TAction;
    acOpenProject: TAction;
    acLock: TAction;
    acCopyClipboard: TAction;
    acCutClipboard: TAction;
    acPasteClipboard: TAction;
    acSelectAll: TAction;
    acDeleteControl: TAction;
    acAlignToGrid: TAction;
    acBringToFront: TAction;
    acSendToBack: TAction;
    acAlignDialog: TAction;
    acSizeDialog: TAction;
    acAlignmentPalette: TAction;
    acTabOrderDialog: TAction;
    acDesignerOptionsDlg: TAction;
    acSetMainUnit: TAction;
    acUndo: TAction;
    acFind: TAction;
    acReplace: TAction;
    FindDialog1: TAdvMemoFindDialog;
    acSearchAgain: TAction;
    ReplaceDialog1: TAdvMemoFindReplaceDialog;
    acRedo: TAction;
    acCompile: TAction;
    procedure acNewPascalUnitExecue(Sender: TObject);
    procedure acNewFormExecute(Sender: TObject);
    procedure acOpenFileExecute(Sender: TObject);
    procedure acSaveFileExecute(Sender: TObject);
    procedure acSaveAsFileExecute(Sender: TObject);
    procedure acSaveAllExecute(Sender: TObject);
    procedure acCloseFileExecute(Sender: TObject);
    procedure acCloseAllExecute(Sender: TObject);
    procedure acExitExecute(Sender: TObject);
    procedure acToggleFormUnitExecute(Sender: TObject);
    procedure acToggleFormUnitUpdate(Sender: TObject);
    procedure acRunExecute(Sender: TObject);
    procedure acStepOverExecute(Sender: TObject);
    procedure acTraceIntoExecute(Sender: TObject);
    procedure acRunToExecute(Sender: TObject);
    procedure acReturnExecute(Sender: TObject);
    procedure acPauseExecute(Sender: TObject);
    procedure acResetExecute(Sender: TObject);
    procedure acToggleBreakExecute(Sender: TObject);
    procedure acSaveProjectAsExecute(Sender: TObject);
    procedure acRemoveFromProjectExecute(Sender: TObject);
    procedure acNewProjectExecute(Sender: TObject);
    procedure acOpenProjectExecute(Sender: TObject);
    procedure HasDesignerUpdate(Sender: TObject);
    procedure acLockExecute(Sender: TObject);
    procedure acLockUpdate(Sender: TObject);
    procedure acDesignerOptionsDlgExecute(Sender: TObject);
    procedure acTabOrderDialogExecute(Sender: TObject);
    procedure acAlignDialogExecute(Sender: TObject);
    procedure acSizeDialogExecute(Sender: TObject);
    procedure acAlignmentPaletteExecute(Sender: TObject);
    procedure acBringToFrontExecute(Sender: TObject);
    procedure acSendToBackExecute(Sender: TObject);
    procedure acAlignToGridExecute(Sender: TObject);
    procedure acSelectAllExecute(Sender: TObject);
    procedure acSelectAllUpdate(Sender: TObject);
    procedure acCopyClipboardExecute(Sender: TObject);
    procedure acCutClipboardUpdate(Sender: TObject);
    procedure acCopyClipboardUpdate(Sender: TObject);
    procedure acCutClipboardExecute(Sender: TObject);
    procedure acPasteClipboardExecute(Sender: TObject);
    procedure acPasteClipboardUpdate(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction;
      var Handled: Boolean);
    procedure acAddWatchExecute(Sender: TObject);
    procedure acDeleteControlUpdate(Sender: TObject);
    procedure acDeleteControlExecute(Sender: TObject);
    procedure acSetMainUnitExecute(Sender: TObject);
    procedure acSetMainUnitUpdate(Sender: TObject);
    procedure acAddWatchUpdate(Sender: TObject);
    procedure acUndoUpdate(Sender: TObject);
    procedure acUndoExecute(Sender: TObject);
    procedure acFindUpdate(Sender: TObject);
    procedure acReplaceUpdate(Sender: TObject);
    procedure acFindExecute(Sender: TObject);
    procedure acReplaceExecute(Sender: TObject);
    procedure FindDialog1FindText(Sender: TObject);
    procedure acSearchAgainExecute(Sender: TObject);
    procedure acSearchAgainUpdate(Sender: TObject);
    procedure acRedoUpdate(Sender: TObject);
    procedure acRedoExecute(Sender: TObject);
    procedure acCompileExecute(Sender: TObject);
  private
    FEngine: TIDEEngine;
    FLastSearch: TLastSearchMode;
    (*FInspectorForm: TfmObjectInspector;
    {$IFDEF DELPHI9_LVL}
    FPaletteForm: TfmToolPalette;
    {$ENDIF}
    FWatchesForm: TfmWatches;*)
    procedure SetEngine(const Value: TIDEEngine);
    //function GetScripter: TatCustomScripter;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    property Engine: TIDEEngine read FEngine write SetEngine;
    (*property InspectorForm: TfmObjectInspector read FInspectorForm;
    property WatchesForm: TfmWatches read FWatchesForm;
    {$IFDEF DELPHI9_LVL}
    property PaletteForm: TfmToolPalette read FPaletteForm;
    {$ENDIF}*)
  end;

var
  dmIDEActions: TdmIDEActions;

implementation
uses Clipbrd;

{$R *.DFM}

{ TdmIDEActions }

procedure TdmIDEActions.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FEngine) then
    FEngine := nil;
end;

procedure TdmIDEActions.SetEngine(const Value: TIDEEngine);
begin
  if FEngine <> Value then
  begin
    FEngine := Value;
    if FEngine <> nil then
      FEngine.FreeNotification(Self);

    (*FInspectorForm.Engine := FEngine;
    FWatchesForm.Engine := FEngine;
    {$IFDEF DELPHI9_LVL}
    FPaletteForm.Engine := FEngine;
    {$ENDIF}*)
  end;
end;

procedure TdmIDEActions.acNewPascalUnitExecue(Sender: TObject);
begin
  if FEngine <> nil then
    FEngine.NewUnit(FEngine.DlgSelectLanguage('unit')); 
end;

procedure TdmIDEActions.acNewFormExecute(Sender: TObject);
begin
  if FEngine <> nil then
    FEngine.NewFormUnit(FEngine.DlgSelectLanguage('form'));
end;

procedure TdmIDEActions.acOpenFileExecute(Sender: TObject);
begin
  if FEngine <> nil then
    FEngine.DlgOpenFile;
end;

procedure TdmIDEActions.acSaveFileExecute(Sender: TObject);
begin
  if (FEngine <> nil) then
    FEngine.DlgSaveActiveFile;
end;

procedure TdmIDEActions.acSaveAsFileExecute(Sender: TObject);
begin
  if (FEngine <> nil) then
    FEngine.DlgSaveActiveFileAs;
end;

procedure TdmIDEActions.acSaveAllExecute(Sender: TObject);
begin
  if (FEngine <> nil) then
    FEngine.DlgSaveAll;
end;

procedure TdmIDEActions.acCloseFileExecute(Sender: TObject);
begin
  if FEngine <> nil then
    FEngine.DlgCloseActiveFile;
end;

procedure TdmIDEActions.acCloseAllExecute(Sender: TObject);
begin
  if FEngine <> nil then
    if FEngine.DlgCloseAll then
      FEngine.NewProject;
end;

procedure TdmIDEActions.acExitExecute(Sender: TObject);
begin
  if Owner is TForm then
    TForm(Owner).Close;
end;

procedure TdmIDEActions.acToggleFormUnitExecute(Sender: TObject);
begin
  if (FEngine <> nil) and (FEngine.ActiveFile <> nil) then
    FEngine.ToggleViewMode;
end;

procedure TdmIDEActions.acToggleFormUnitUpdate(Sender: TObject);
begin
  acToggleFormUnit.Enabled := (FEngine <> nil) and (FEngine.ActiveFile <> nil) and (FEngine.ActiveFile.IsForm);
end;

(*function TdmIDEActions.GetScripter: TatCustomScripter;
begin
  if FEngine <> nil then
    result := FEngine.Scripter
  else
    result := nil;
end;*)

procedure TdmIDEActions.acRunExecute(Sender: TObject);
begin
  if FEngine <> nil then
    FEngine.RunProject;
end;

procedure TdmIDEActions.acStepOverExecute(Sender: TObject);
begin
  if FEngine <> nil then
    FEngine.DebugStepOver;
end;

procedure TdmIDEActions.acTraceIntoExecute(Sender: TObject);
begin
  if FEngine <> nil then
    FEngine.DebugTraceInto;
end;

procedure TdmIDEActions.acRunToExecute(Sender: TObject);
begin
  if FEngine <> nil then
    FEngine.DebugRunToLine;
end;

procedure TdmIDEActions.acReturnExecute(Sender: TObject);
begin
  if FEngine <> nil then
    FEngine.DebugUntilReturn;
end;

procedure TdmIDEActions.acPauseExecute(Sender: TObject);
begin
  if FEngine <> nil then
    FEngine.DebugPause;
end;

procedure TdmIDEActions.acResetExecute(Sender: TObject);
begin
  if FEngine <> nil then
    FEngine.DebugReset;
end;

procedure TdmIDEActions.acToggleBreakExecute(Sender: TObject);
begin
  if FEngine <> nil then
    FEngine.DebugToggleBreak;
end;

procedure TdmIDEActions.acSaveProjectAsExecute(Sender: TObject);
begin
  if FEngine <> nil then
    FEngine.DlgSaveProjectAs;
end;

procedure TdmIDEActions.acRemoveFromProjectExecute(Sender: TObject);
begin
  if FEngine <> nil then
    FEngine.DlgRemoveActiveFile;
end;

procedure TdmIDEActions.acNewProjectExecute(Sender: TObject);
var
  ALang: TScriptLanguage;
begin
  if FEngine <> nil then
  begin
    ALang := FEngine.DlgSelectLanguage('project');
    if FEngine.DlgNewProject then
      FEngine.CreateMainUnits(ALang);
  end;
end;

procedure TdmIDEActions.acOpenProjectExecute(Sender: TObject);
begin
  if FEngine <> nil then
    FEngine.DlgOpenProject;
end;                                         

procedure TdmIDEActions.HasDesignerUpdate(Sender: TObject);
begin
  {This is a generic update for actions that must only be enabled if
   form designer is active}
  TAction(Sender).Enabled :=
    (FEngine <> nil) and (FEngine.ActiveFile <> nil) and
    (FEngine.Designer <> nil) and
    (FEngine.ActiveFile.ViewMode = vmForm);
end;

procedure TdmIDEActions.acLockExecute(Sender: TObject);
begin
  FEngine.Designer.LockedInverse := not FEngine.Designer.LockedInverse; 
end;

procedure TdmIDEActions.acLockUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := (FEngine <> nil) and (FEngine.ActiveFile <> nil)
    and (FEngine.ActiveFile.ViewMode = vmForm);
  TAction(Sender).Checked := TAction(Sender).Enabled and
    (FEngine.Designer <> nil) and (FEngine.Designer.LockedInverse);
end;

procedure TdmIDEActions.acDesignerOptionsDlgExecute(Sender: TObject);
begin
  FEngine.Designer.OptionsDialog;
end;

procedure TdmIDEActions.acTabOrderDialogExecute(Sender: TObject);
begin
  FEngine.Designer.TabOrderDialog;
end;

procedure TdmIDEActions.acAddWatchExecute(Sender: TObject);
begin
  FEngine.DlgAddWatch;
end;

procedure TdmIDEActions.acAlignDialogExecute(Sender: TObject);
begin
  FEngine.Designer.AlignDialog;
end;

procedure TdmIDEActions.acSizeDialogExecute(Sender: TObject);
begin
  FEngine.Designer.SizeDialog;
end;

procedure TdmIDEActions.acAlignmentPaletteExecute(Sender: TObject);
begin
  FEngine.Designer.ShowAlignmentPalette;
end;

procedure TdmIDEActions.acBringToFrontExecute(Sender: TObject);
begin
  FEngine.Designer.BringControlsToFront;
end;

procedure TdmIDEActions.acSendToBackExecute(Sender: TObject);
begin
  FEngine.Designer.SendControlsToBack;
end;

procedure TdmIDEActions.acAlignToGridExecute(Sender: TObject);
begin
  FEngine.Designer.AlignControlsToGrid;
end;

procedure TdmIDEActions.acSelectAllExecute(Sender: TObject);
begin
  Case FEngine.ActiveFile.ViewMode of
    vmUnit:
      FEngine.Memo.SelectAll;
    vmForm:
      FEngine.Designer.SelectAll;
  end;
end;

procedure TdmIDEActions.acSelectAllUpdate(Sender: TObject);
var
  AOk: boolean;
begin
  AOk := (FEngine <> nil) and (FEngine.ActiveFile <> nil);
  if AOk then
    Case FEngine.ActiveFile.ViewMode of
      vmUnit:
        AOk := (FEngine.Memo <> nil);
      vmForm:
        AOk := (FEngine.Designer <> nil);
    end;
  TAction(Sender).Enabled := AOk;
end;

procedure TdmIDEActions.acCopyClipboardExecute(Sender: TObject);
var
  ok: boolean;
begin
  ok := false;
  Case FEngine.ActiveFile.ViewMode of
    vmUnit:
      if FEngine.Memo.Focused then
      begin
        FEngine.Memo.CopyToClipBoard;
        ok := true;
      end;
    vmForm:
      if FEngine.DesignControl.Focused then
      begin
        FEngine.Designer.CopyToClipboard;
        ok := true;
      end;
  end;
  if not ok then
    SendMessage(Windows.GetFocus, WM_COPY, 0, 0);
end;

procedure TdmIDEActions.acCopyClipboardUpdate(Sender: TObject);
var
  AOk: boolean;
begin
  Aok := (FEngine <> nil) and (FEngine.ActiveFile <> nil);
  if AOk then
    Case FEngine.ActiveFile.ViewMode of
      vmUnit:
        Aok := (FEngine.Memo <> nil) and ((FEngine.Memo.SelLength > 0) or not FEngine.Memo.Focused);
      vmForm:
        AOk := (FEngine.Designer <> nil) and (FEngine.DesignControl <> nil) and
          ((FEngine.Designer.ControlCount > 0) or not FEngine.DesignControl.Focused);
    end;
  TAction(Sender).Enabled := AOk;
end;

procedure TdmIDEActions.acCutClipboardExecute(Sender: TObject);
var
  ok: boolean;
begin
  ok := false;
  Case FEngine.ActiveFile.ViewMode of
    vmUnit:
      if FEngine.Memo.Focused then
      begin
        FEngine.Memo.CutToClipboard;
        ok := true;
      end;
    vmForm:
      if FEngine.DesignControl.Focused then
      begin
        FEngine.Designer.CutToClipboard;
        ok := true;
      end;
  end;
  if not ok then
    SendMessage(Windows.GetFocus, WM_CUT, 0, 0);
end;

procedure TdmIDEActions.acCutClipboardUpdate(Sender: TObject);
var
  AOk: boolean;
begin
  Aok := (FEngine <> nil) and (FEngine.ActiveFile <> nil);
  if AOk then
    Case FEngine.ActiveFile.ViewMode of
      vmUnit:
        Aok := (FEngine.Memo <> nil) and ((FEngine.Memo.SelLength > 0) or not FEngine.Memo.Focused);
      vmForm:
        AOk := (FEngine.Designer <> nil) and (FEngine.DesignControl <> nil) and
          ((FEngine.Designer.ControlCount > 0) or not FEngine.DesignControl.Focused);
    end;
  TAction(Sender).Enabled := AOk;
end;

procedure TdmIDEActions.acPasteClipboardExecute(Sender: TObject);
var
  ok: boolean;
begin
  ok := false;
  Case FEngine.ActiveFile.ViewMode of
    vmUnit:
      if FEngine.Memo.Focused then
      begin
        FEngine.Memo.PasteFromClipBoard;
        ok := true;
      end;
    vmForm:
      if FEngine.DesignControl.Focused then
      begin
        FEngine.Designer.PasteFromClipboard;
        ok := true;
      end;
  end;
  if not ok then
    SendMessage(Windows.GetFocus, WM_PASTE, 0, 0);
end;

procedure TdmIDEActions.acPasteClipboardUpdate(Sender: TObject);

  function ClipboardHasComponent: boolean;
  begin
    result := (Clipboard.HasFormat(CF_TEXT));
    if result then
    begin
      try
        result := (lowercase(Copy(Clipboard.AsText, 1, 6)) = 'object');
      except
        result := false;
      end;
    end;
  end;

var
  AOk: boolean;
begin
  AOk := (FEngine <> nil) and (FEngine.ActiveFile <> nil);
  if AOk then
    Case FEngine.ActiveFile.ViewMode of
      vmUnit:
        AOk := (FEngine.Memo <> nil) and (Clipboard.HasFormat(CF_TEXT) or not FEngine.Memo.Focused);
      vmForm:
        begin
          AOk := (FEngine.Designer <> nil) and (FEngine.DesignControl <> nil) and
          (
          ClipboardHasComponent
          or
          not FEngine.DesignControl.Focused);
        end;
    end;
  TAction(Sender).Enabled := AOk;
end;

procedure TdmIDEActions.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
var
  ARunning: boolean;
  APaused: boolean;
  AValid: boolean;
begin
  AValid := (FEngine <> nil) and (FEngine.ActiveScript <> nil);
  ARunning := AValid and FEngine.Scripter.Running;
  APaused := AValid and FEngine.Scripter.Paused;

  acRun.Enabled := AValid and (not ARunning or APaused);
  acCompile.Enabled := AValid and (not ARunning or APaused);
  acPause.Enabled := AValid and ARunning and not APaused;
  acStepOver.Enabled := AValid and (not ARunning or APaused);
  acTraceInto.enabled := AValid and (not ARunning or APaused);
  acRunTo.enabled := AValid and (not ARunning or APaused);
  acReturn.enabled := AValid and ARunning and APaused;
  acReset.enabled := AValid and ARunning;
  acEvaluate.enabled := AValid and ARunning and APaused;
  acAddWatch.enabled := AValid;
  acToggleBreak.enabled := AValid;
end;

procedure TdmIDEActions.acDeleteControlUpdate(Sender: TObject);
var
  AOk: boolean;
begin
  Aok := (FEngine <> nil) and (FEngine.ActiveFile <> nil);
  if AOk then
    Case FEngine.ActiveFile.ViewMode of
      vmUnit:
        Aok := false;
      vmForm:
        AOk := (FEngine.Designer <> nil) and (FEngine.Designer.ControlCount > 0);
    end;
  TAction(Sender).Enabled := AOk;
end;

procedure TdmIDEActions.acDeleteControlExecute(Sender: TObject);
begin
  FEngine.Designer.RemoveSelectedControls;
end;

procedure TdmIDEActions.acSetMainUnitExecute(Sender: TObject);
begin
  if FEngine <> nil then
    FEngine.DlgSelectMainUnit;
end;

procedure TdmIDEActions.acSetMainUnitUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := (FEngine <> nil) and (FEngine.Files.Count > 0);
end;

constructor TdmIDEActions.Create(AOwner: TComponent);
begin
  inherited;
  (*FInspectorForm := TfmObjectInspector.Create(Self);
  {$IFDEF DELPHI9_LVL}
  FPaletteForm := TfmToolPalette.Create(Self);
  {$ENDIF}
  FWatchesForm := TfmWatches.Create(Self);*)
  FLastSearch := lsNone;
end;

procedure TdmIDEActions.acAddWatchUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := FEngine <> nil;
end;

procedure TdmIDEActions.acUndoUpdate(Sender: TObject);
var
  AOk: boolean;
  AActionCaption: string;
begin
  AOk := (FEngine <> nil) and (FEngine.ActiveFile <> nil);
  AActionCaption := 'Undo';
  if AOk then
    Case FEngine.ActiveFile.ViewMode of
      vmUnit:
        AOk := (FEngine.Memo <> nil) and FEngine.Memo.CanUndo;
      vmForm:
        begin
          AOk := FEngine.CanUndoDesigner;
          if AOk then
            AActionCaption := 'Undo ' + FEngine.NextUndoDesignerAction;
        end;
    end;
  TAction(Sender).Enabled := AOk;
  TAction(Sender).Caption := AActionCaption;
end;

procedure TdmIDEActions.acUndoExecute(Sender: TObject);
begin
  Case FEngine.ActiveFile.ViewMode of
    vmUnit:
      FEngine.Memo.Undo;
    vmForm:
      FEngine.UndoDesigner;
  end;
end;

procedure TdmIDEActions.acFindUpdate(Sender: TObject);
var
  AOk: boolean;
begin
  AOk := (FEngine <> nil) and (FEngine.ActiveFile <> nil) and (FEngine.Memo <> nil)
    and (FEngine.ActiveFile.ViewMode = vmUnit);
  TAction(Sender).Enabled := AOk;
end;

procedure TdmIDEActions.acReplaceUpdate(Sender: TObject);
var
  AOk: boolean;
begin
  AOk := (FEngine <> nil) and (FEngine.ActiveFile <> nil) and (FEngine.Memo <> nil)
    and (FEngine.ActiveFile.ViewMode = vmUnit);
  TAction(Sender).Enabled := AOk;
end;

procedure TdmIDEActions.acFindExecute(Sender: TObject);
begin
  FindDialog1.AdvMemo := FEngine.Memo;
  FindDialog1.Execute;
end;

procedure TdmIDEActions.acReplaceExecute(Sender: TObject);
begin
  ReplaceDialog1.AdvMemo := FEngine.Memo;
  ReplaceDialog1.Execute;
end;

procedure TdmIDEActions.FindDialog1FindText(Sender: TObject);
begin
  FindDialog1.CloseDialog;
  FLastSearch := lsFind;
end;

procedure TdmIDEActions.acSearchAgainExecute(Sender: TObject);
begin
  Case FLastSearch of
    lsFind:
      begin
        if FEngine.Memo.FindText(FindDialog1.FindText, FindDialog1.Options) = -1 then
        begin
          if (FindDialog1.DisplayMessage) then
            MessageDlg(Format(FindDialog1.NotFoundMessage, [FindDialog1.FindText]), mtInformation, [mbOK], 0);
        end
        else
        begin
          if FindDialog1.FocusMemo and FEngine.Memo.CanFocus then
            FEngine.Memo.SetFocus;
        end;
      end;
    lsReplace:
      ReplaceDialog1.Execute;
  end;
end;

procedure TdmIDEActions.acSearchAgainUpdate(Sender: TObject);
var
  AOk: boolean;
begin
  AOk := (FEngine <> nil) and (FEngine.ActiveFile <> nil) and (FEngine.Memo <> nil)
    and (FEngine.ActiveFile.ViewMode = vmUnit);
  TAction(Sender).Enabled := AOk;
end;

procedure TdmIDEActions.acRedoUpdate(Sender: TObject);
var
  AOk: boolean;
  AActionCaption: string;
begin
  AOk := (FEngine <> nil) and (FEngine.ActiveFile <> nil);
  AActionCaption := 'Redo';
  if AOk then
    Case FEngine.ActiveFile.ViewMode of
      vmUnit:
          AOk := (FEngine.Memo <> nil) and FEngine.Memo.CanRedo;
      vmForm:
        begin
          AOk := FEngine.CanRedoDesigner;
          if AOk then
            AActionCaption := 'Redo ' + FEngine.NextRedoDesignerAction
        end;
    end;
  TAction(Sender).Enabled := AOk;
  TAction(Sender).Caption := AActionCaption;
end;

procedure TdmIDEActions.acRedoExecute(Sender: TObject);
begin
  Case FEngine.ActiveFile.ViewMode of
    vmUnit:
      FEngine.Memo.Redo;
    vmForm:
      FEngine.RedoDesigner;
  end;
end;

procedure TdmIDEActions.acCompileExecute(Sender: TObject);
begin
  if FEngine <> nil then
  begin
    FEngine.CompileProject;
    MessageDlg('Project compiled.', mtInformation, [mbOk], 0);
  end;
end;

end.
