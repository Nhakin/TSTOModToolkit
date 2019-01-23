unit ScripterEditorFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IDEMain, LMDDckSite, SpTBXItem, ComCtrls, ScriptCtrls, atScript,
  atScripter, AdvMemo, StdCtrls, AdvCodeList, ToolWin, ExtCtrls, dIDEActions;

type
  TFrmScripterEditor = class(TForm)
    ScripterEngine: TIDEEngine;
    LMDDockManager1: TLMDDockManager;
    LMDDockSite1: TLMDDockSite;
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
    ControlBar1: TControlBar;
    ToolBar2: TToolBar;
    tbNewProject: TToolButton;
    tbOpenProject: TToolButton;
    tbSaveAll: TToolButton;
    ToolBar4: TToolBar;
    tbNewUnit: TToolButton;
    tbNewForm: TToolButton;
    tbOpenFile: TToolButton;
    tbSaveFile: TToolButton;
    tbEdit: TToolBar;
    tbCut: TToolButton;
    tbCopy: TToolButton;
    tbPaste: TToolButton;
    ToolBar1: TToolBar;
    tbRun: TToolButton;
    tbPause: TToolButton;
    tbReset: TToolButton;
    ToolButton9: TToolButton;
    tbTraceInto: TToolButton;
    tbStepOver: TToolButton;
    ToolButton12: TToolButton;
    tbToggleBreakPoint: TToolButton;
    tbAddWatch: TToolButton;
  private

  public

  end;

implementation

{$R *.dfm}

end.
