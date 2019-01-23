unit ScripterEditorFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IDEMain, LMDDckSite, LMDDckStyleElems, SpTBXItem, ComCtrls, ScriptCtrls, atScript,
  atScripter, AdvMemo, StdCtrls, AdvCodeList, ToolWin, ExtCtrls, dIDEActions,
  TB2Dock, TB2Toolbar, TB2Item;

type
  TFrmScripterEditor = class(TForm)
    ScripterEngine: TIDEEngine;
    LMDDockManager1: TLMDDockManager;
    dckScript: TLMDDockSite;
    SpTBXStatusBar1: TSpTBXStatusBar;
    PanMemo: TLMDDockPanel;
    PanExplorer: TLMDDockPanel;
    PanCodeList: TLMDDockPanel;
    ScripterMain: TIDEScripter;
    SourceExplorer: TSourceExplorer;
    MemoSource: TIDEMemo;
    Watches: TLMDDockPanel;
    WatchList: TIDEWatchListView;
    CodeList: TAdvCodeList;
    dckToolBar: TSpTBXDock;
    ToolBar2: TSpTBXToolbar;
    tbNewProject: TSpTBXItem;
    tbOpenProject: TSpTBXItem;
    tbSaveAll: TSpTBXItem;
    ToolBar4: TSpTBXToolbar;
    tbNewUnit: TSpTBXItem;
    tbNewForm: TSpTBXItem;
    tbOpenFile: TSpTBXItem;
    tbSaveFile: TSpTBXItem;
    tbEdit: TSpTBXToolbar;
    tbCut: TSpTBXItem;
    tbCopy: TSpTBXItem;
    tbPaste: TSpTBXItem;
    ToolBar1: TSpTBXToolbar;
    tbRun: TSpTBXItem;
    tbPause: TSpTBXItem;
    tbReset: TSpTBXItem;
    tbTraceInto: TSpTBXItem;
    tbStepOver: TSpTBXItem;
    tbToggleBreakPoint: TSpTBXItem;
    tbAddWatch: TSpTBXItem;
    SpTBXSeparatorItem1: TSpTBXSeparatorItem;
    SpTBXSeparatorItem2: TSpTBXSeparatorItem;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure dckScriptUpdateHotSpots(Sender: TObject; AClient: TControl;
      AZone: TLMDDockZone; var EnabledAreas: TLMDActiveAreas);
    procedure dckScriptCustomInsertQuery(Sender: TObject;
      AClient: TControl; AZone: TLMDDockZone; AAlign: TAlign;
      var AIsCustomInsert: Boolean);
    procedure dckScriptCustomInsert(Sender: TObject; AClient: TControl;
      AZone: TLMDDockZone; AAlign: TAlign);

  private
    FActions : TdmIDEActions;
    FInited  : Boolean;
    FMainZone : TLMDDockZone;

    Procedure DoNewUnit(Sender : TObject);
    Procedure DoRunScript(Sender : TObject);
    Procedure DoOpenFile(Sender : TObject);
    Procedure DoSaveFile(Sender : TObject);

    Procedure DoOnScriptPanelEnter(Sender : TObject);
    Procedure DoOnScriptPanelClose(Sender: TObject; Var CloseAction: TLMDockPanelCloseAction);
    Procedure DoOnScriptPanelCloseQuery(Sender: TObject; Var CanClose: Boolean);
    Procedure DoOnScriptPanelStartDock(Sender: TObject; Var DragObject: TDragDockObject);
    Procedure DoOnScriptPanelEndDock(Sender, Target: TObject; X, Y: Integer);

    Procedure CreateSourceTab(AFile : TIDEProjectFile);

  public

  end;

implementation

{$R *.dfm}

Type
  TLMDScriptEditorDockPanel = Class(TLMDDockPanel)
  Private
    FScript : TIDEProjectFile;

  Public
    Property Script : TIDEProjectFile Read FScript   Write FScript;

  End;

procedure TFrmScripterEditor.FormCreate(Sender: TObject);
begin
  FActions := TdmIDEActions.Create(Self);
  FActions.Engine := ScripterEngine;

  tbNewUnit.Action.OnExecute  := DoNewUnit;
  tbRun.Action.OnExecute      := DoRunScript;
  tbOpenFile.Action.OnExecute := DoOpenFile;
  tbSaveFile.Action.OnExecute := DoSaveFile;

  FMainZone := PanMemo.Zone.Parent;

  FInited := False;
end;

procedure TFrmScripterEditor.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FActions);
end;

Procedure TFrmScripterEditor.DoNewUnit(Sender : TObject);
Begin
  CreateSourceTab(ScripterEngine.NewUnit(slPascal, False));
End;

Procedure TFrmScripterEditor.DoRunScript(Sender : TObject);
Begin
  ScripterEngine.RunActiveScript();
End;

Procedure TFrmScripterEditor.DoOpenFile(Sender : TObject);
Begin
  CreateSourceTab(ScripterEngine.DlgOpenFile());
End;

Procedure TFrmScripterEditor.DoSaveFile(Sender : TObject);
Begin
  If ScripterEngine.ActiveFile.Saved Then
    ScripterEngine.ActiveFile.Save()
  Else If ScripterEngine.DlgSaveActiveFileAs() Then
    FMainZone.SelectedPage.Panel.Caption := ScripterEngine.ActiveFile.UnitName;
End;

Procedure TFrmScripterEditor.DoOnScriptPanelEnter(Sender : TObject);
Begin
  With TLMDScriptEditorDockPanel(Sender) Do
  Begin
    MemoSource.Parent := TLMDScriptEditorDockPanel(Sender);
    TIDEEngine(TIDEProjectFiles(Script.Collection).Owner).ActiveFile := Script;
    SourceExplorer.Refresh();
  End;
End;

Procedure TFrmScripterEditor.DoOnScriptPanelClose(Sender : TObject;
  Var CloseAction : TLMDockPanelCloseAction);
Var lPanel : TLMDScriptEditorDockPanel;
    lNextPan : Integer;
Begin
  If (Sender Is TLMDScriptEditorDockPanel) Then
  Begin
    lPanel := TLMDScriptEditorDockPanel(Sender);
    If lPanel.Zone.Index < FMainZone.TabCount - 1 Then
      lNextPan := lPanel.Zone.Index + 1
    Else If FMainZone.TabCount > 2 Then
      lNextPan := FMainZone.TabCount - 2
    Else
      lNextPan := 0;

    MemoSource.Parent := FMainZone.Tabs[lNextPan].Zone.Panel;
    FMainZone.Tabs[lNextPan].Zone.Panel.Show();

    CloseAction := caFree;
  End
  Else
    CloseAction := caHide;
End;

Procedure TFrmScripterEditor.DoOnScriptPanelCloseQuery(Sender : TObject;
  Var CanClose : Boolean);
Var lDlgResult : TIDECloseFileResult;
Begin
  If FMainZone.TabCount > 1 Then
  Begin
    lDlgResult := cfrClosed;

    If ScripterEngine.ActiveFile.Modified Then
    Begin
      Case Application.MessageBox(PChar(Format('Save changes to %s?', [ScripterEngine.ActiveFile.UnitName])), PChar('Confirm'), MB_YESNOCANCEL) Of
        IDYES :
        Begin
          If Not ScripterEngine.DlgSaveActiveFile() Then
            lDlgResult := cfrCanceled;
        End;

        IDNO : lDlgResult := cfrClosed;
        Else
          lDlgResult := cfrCanceled;
      End;
    End
    Else
      lDlgResult := ScripterEngine.DlgCloseActiveFile();

    CanClose := lDlgResult <> cfrCanceled;
    If lDlgResult = cfrClosed Then
      ScripterEngine.ActiveFile.Free();
  End
  Else
    CanClose := False;
End;

procedure TFrmScripterEditor.DoOnScriptPanelStartDock(Sender: TObject;
  var DragObject: TDragDockObject);
begin
//
  Caption := 'DoOnScriptPanelStartDock';
end;

procedure TFrmScripterEditor.DoOnScriptPanelEndDock(Sender, Target: TObject; X,
  Y: Integer);
begin
//
  Caption := 'DoOnScriptPanelEndDock';
end;

Procedure TFrmScripterEditor.CreateSourceTab(AFile : TIDEProjectFile);
Var lDckZone : TLMDDockZone;
    lName    : String;
    lScriptPan : TLMDScriptEditorDockPanel;
    lComponent : TComponent;
Begin
  If Assigned(AFile) Then
  Begin
    lName := '_' + AFile.UnitName;
    lComponent := FindComponent(lName);

    If Assigned(lComponent) Then
      TControl(lComponent).Show()
    Else
    Begin
      lScriptPan := TLMDScriptEditorDockPanel.Create(Self);
      lScriptPan.Name       := lName;
      lScriptPan.Caption    := AFile.UnitName;
      lScriptPan.Script     := AFile;
      lScriptPan.ClientKind := dkDocument;
      MemoSource.Parent     := lScriptPan;

      lScriptPan.OnEnter      := DoOnScriptPanelEnter;
      lScriptPan.OnCloseQuery := DoOnScriptPanelCloseQuery;
      lScriptPan.OnClose      := DoOnScriptPanelClose;
//      lScriptPan.OnMouseDown  := DoOnScriptPanelMouseDown;
//      lScriptPan.OnMouseUp    := DoOnScriptPanelMouseUp;

      lDckZone := dckScript.SpaceZone;
      While (lDckZone <> Nil) And (lDckZone.Kind <> zkTabs) And
            (lDckZone.ZoneCount > 0) Do
        lDckZone := lDckZone[0];

      If lDckZone <> Nil Then
        dckScript.DockControl(lScriptPan, lDckZone, alClient);

      If lScriptPan.Zone <> Nil Then
      Begin
        lScriptPan.Zone.Index := lScriptPan.Zone.Parent.ZoneCount - 1;
        lScriptPan.Show();
      End;

      DoOnScriptPanelEnter(lScriptPan);
    End;
  End;
End;

procedure TFrmScripterEditor.FormActivate(Sender: TObject);
begin
  If Not FInited Then
  Begin
    DoNewUnit(Self);
    FInited := True;
    PanMemo.Free();
  End;
end;
{
  TLMDActiveArea    = (hsaSiteLeft, hsaSiteTop, hsaSiteRight, hsaSiteBottom,
                       hsaZoneLeft, hsaZoneTop, hsaZoneRight, hsaZoneBottom,
                       hsaDocsLeft, hsaDocsTop, hsaDocsRight, hsaDocsBottom,
                       hsaTabs, hsaSplitters, hsaTabAreas);
}
procedure TFrmScripterEditor.dckScriptUpdateHotSpots(Sender: TObject;
  AClient: TControl; AZone: TLMDDockZone;
  var EnabledAreas: TLMDActiveAreas);
Var lZone : TLMDDockZone;
    lPanel : TLMDDockPanel;
begin
  If AClient.InheritsFrom(TLMDDockPanel) Then
    lPanel := TLMDDockPanel(AClient)
  Else
    Caption := AClient.ClassName;

  lZone := AZone;
  If Assigned(lZone) And Assigned(lPanel) Then
  Begin
    If lZone.AutoHideSide = alNone Then
    Begin
      Case lPanel.ClientKind Of
        dkTool : EnabledAreas := [ hsaZoneLeft, hsaZoneTop, hsaZoneRight, hsaZoneBottom,
                                   hsaSiteLeft, hsaSiteTop, hsaSiteRight, hsaSiteBottom ];
        dkDocument : EnabledAreas := [hsaTabs, hsaTabAreas];
      End;
    End
    Else If lPanel.ClientKind = dkDocument Then
      EnabledAreas := [];
  End;
end;

procedure TFrmScripterEditor.dckScriptCustomInsertQuery(Sender: TObject;
  AClient: TControl; AZone: TLMDDockZone; AAlign: TAlign;
  var AIsCustomInsert: Boolean);
begin
//
end;

procedure TFrmScripterEditor.dckScriptCustomInsert(Sender: TObject;
  AClient: TControl; AZone: TLMDDockZone; AAlign: TAlign);
begin
//
end;

end.
