object FrmScripterEditor: TFrmScripterEditor
  Left = 54
  Top = 275
  Width = 952
  Height = 656
  Caption = 'Script Editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object dckScript: TLMDDockSite
    Left = 0
    Top = 26
    Width = 944
    Height = 577
    Manager = LMDDockManager1
    OnCustomInsertQuery = dckScriptCustomInsertQuery
    OnCustomInsert = dckScriptCustomInsert
    OnUpdateHotSpots = dckScriptUpdateHotSpots
    Align = alClient
    TabOrder = 0
    Layout = {
      EFBBBF3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D
      227574662D38223F3E0D0A3C736974656C6973743E0D0A093C73697465206964
      3D2253454C465F53495445223E0D0A09093C7A6F6E65206B696E643D22484F52
      5A223E0D0A0909093C7A6F6E65206B696E643D2250414E454C222069643D2250
      616E4578706C6F726572222076697369626C653D2231222073697A653D223134
      3722206473697A653D22302E313539373832363038363935363532222F3E0D0A
      0909093C7A6F6E65206B696E643D2256455254222073697A653D223634332220
      6473697A653D22302E363938393133303433343738323631223E0D0A09090909
      3C7A6F6E65206B696E643D225441425322206163746976657461623D22302220
      73697A653D2234363722206473697A653D22302E383335343230333933353539
      3932382220697373706163653D2231223E0D0A09090909093C7A6F6E65206B69
      6E643D2250414E454C222069643D2250616E4D656D6F222076697369626C653D
      2231222F3E0D0A090909093C2F7A6F6E653E0D0A090909093C7A6F6E65206B69
      6E643D2250414E454C222069643D2257617463686573222076697369626C653D
      2231222073697A653D22393222206473697A653D22302E313634353739363036
      343430303732222F3E0D0A0909093C2F7A6F6E653E0D0A0909093C7A6F6E6520
      6B696E643D2250414E454C222069643D2250616E436F64654C69737422207669
      7369626C653D2231222073697A653D2231333022206473697A653D22302E3134
      31333034333437383236303837222F3E0D0A09093C2F7A6F6E653E0D0A093C2F
      736974653E0D0A3C2F736974656C6973743E}
    object PanCodeList: TLMDDockPanel
      Left = 808
      Top = 6
      Width = 130
      Height = 565
      Buttons = [pbPin, pbMaximize, pbClose]
      ParentBackground = False
      TabOrder = 6
      Caption = 'Code Sample'
      object CodeList: TAdvCodeList
        Left = 0
        Top = 21
        Width = 130
        Height = 544
        Align = alClient
        CodeBlocks = <>
        CodeBlockColor = clWhite
        CodeBlockColorTo = clInfoBk
        CodeBlockSelectColor = clWhite
        CodeBlockSelectColorTo = 13627646
        CodeBorderColor = clSilver
        CodeBorderSelectColor = clBlue
        CodeBorderWidth = 2
        CodeIndent = 2
        ItemHeight = 48
        TabOrder = 0
        UseStyler = True
        Version = '3.0.0.1'
      end
    end
    object PanExplorer: TLMDDockPanel
      Left = 6
      Top = 6
      Width = 147
      Height = 565
      Buttons = [pbPin, pbMaximize, pbClose]
      ParentBackground = False
      TabOrder = 5
      Caption = 'Source Explorer'
      object SourceExplorer: TSourceExplorer
        Left = 0
        Top = 21
        Width = 147
        Height = 544
        Scripter = ScripterMain
        AdvMemo = MemoSource
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Indent = 19
        ParentFont = False
        TabOrder = 0
      end
    end
    object PanMemo: TLMDDockPanel
      Left = 159
      Top = 27
      Width = 643
      Height = 446
      ClientKind = dkDocument
      ParentBackground = False
      TabOrder = 4
      Caption = 'Script'
      object MemoSource: TIDEMemo
        Left = 0
        Top = 0
        Width = 643
        Height = 446
        Cursor = crIBeam
        ActiveLineSettings.ShowActiveLine = False
        ActiveLineSettings.ShowActiveLineIndicator = False
        ActiveLineSettings.ActiveLineColor = 10066380
        ActiveLineSettings.ActiveLineTextColor = clBlack
        Align = alClient
        AutoCompletion.Font.Charset = DEFAULT_CHARSET
        AutoCompletion.Font.Color = clWindowText
        AutoCompletion.Font.Height = -11
        AutoCompletion.Font.Name = 'MS Sans Serif'
        AutoCompletion.Font.Style = []
        AutoCompletion.StartToken = '(.'
        AutoCorrect.Active = True
        AutoHintParameterPosition = hpBelowCode
        BookmarkGlyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          0800000000000001000000000000000000000001000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
          A6000020400000206000002080000020A0000020C0000020E000004000000040
          20000040400000406000004080000040A0000040C0000040E000006000000060
          20000060400000606000006080000060A0000060C0000060E000008000000080
          20000080400000806000008080000080A0000080C0000080E00000A0000000A0
          200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
          200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
          200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
          20004000400040006000400080004000A0004000C0004000E000402000004020
          20004020400040206000402080004020A0004020C0004020E000404000004040
          20004040400040406000404080004040A0004040C0004040E000406000004060
          20004060400040606000406080004060A0004060C0004060E000408000004080
          20004080400040806000408080004080A0004080C0004080E00040A0000040A0
          200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
          200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
          200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
          20008000400080006000800080008000A0008000C0008000E000802000008020
          20008020400080206000802080008020A0008020C0008020E000804000008040
          20008040400080406000804080008040A0008040C0008040E000806000008060
          20008060400080606000806080008060A0008060C0008060E000808000008080
          20008080400080806000808080008080A0008080C0008080E00080A0000080A0
          200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
          200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
          200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
          2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
          2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
          2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
          2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
          2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
          2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
          2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FDFD25252525
          2525252525252525FDFDFD2E25FFFFFFFFFFFFFFFFFFFF25FDFDFD2525252525
          2525252525252525FDFD9A9AB7B7B7B7B7B7B7B7B7B72525FDFDFD25B7B7B7B7
          B7B7B7B7B7B72525FDFD9A9AB7B7B7B7B7B7B7B7B7B72525FDFDFD25BFB7BFBF
          B7B7B7B7B7B72525FDFD9A9ABFBFBFB7BFBFB7B7B7B72525FDFDFD25BFBFBFBF
          BFB7BFBFB7B72525FDFD9A9ABFBFBFB7BFBFBFB7BFB72525FDFDFD25BFBFBFBF
          BFBFBFBFBFB72525FDFD9A9ABFBFBFBFBFB7BFBFB7B72525FDFDFD25BFBFBFBF
          BFBFBFBFBFB72525FDFD9A9ABFBFBFBFBFBFBFBFBFB725FDFDFDFD2525252525
          25252525252525FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD}
        BorderStyle = bsSingle
        BreakpointColor = 16762823
        BreakpointTextColor = clBlack
        ClipboardFormats = [cfText]
        CodeFolding.Enabled = True
        CodeFolding.LineColor = clGray
        Ctl3D = False
        DelErase = True
        EnhancedHomeKey = False
        Gutter.DigitCount = 4
        Gutter.Font.Charset = DEFAULT_CHARSET
        Gutter.Font.Color = clWindowText
        Gutter.Font.Height = -13
        Gutter.Font.Name = 'Courier New'
        Gutter.Font.Style = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'COURIER NEW'
        Font.Style = []
        HiddenCaret = False
        Lines.Strings = (
          '')
        MarkerList.UseDefaultMarkerImageIndex = False
        MarkerList.DefaultMarkerImageIndex = -1
        MarkerList.ImageTransparentColor = 33554432
        PrintOptions.MarginLeft = 0
        PrintOptions.MarginRight = 0
        PrintOptions.MarginTop = 0
        PrintOptions.MarginBottom = 0
        PrintOptions.PageNr = False
        PrintOptions.PrintLineNumbers = False
        RightMarginColor = 14869218
        ScrollHint = False
        SelColor = clWhite
        SelBkColor = clNavy
        ShowRightMargin = True
        SmartTabs = False
        TabOrder = 0
        TabStop = True
        TrimTrailingSpaces = False
        UILanguage.ScrollHint = 'Row'
        UILanguage.Undo = 'Undo'
        UILanguage.Redo = 'Redo'
        UILanguage.Copy = 'Copy'
        UILanguage.Cut = 'Cut'
        UILanguage.Paste = 'Paste'
        UILanguage.Delete = 'Delete'
        UILanguage.SelectAll = 'Select All'
        UrlStyle.TextColor = clBlue
        UrlStyle.BkColor = clWhite
        UrlStyle.Style = [fsUnderline]
        UseStyler = True
        Version = '3.0.2.2'
        WordWrap = wwNone
      end
    end
    object Watches: TLMDDockPanel
      Left = 159
      Top = 479
      Width = 643
      Height = 92
      ParentBackground = False
      TabOrder = 7
      Caption = 'Watches'
      object WatchList: TIDEWatchListView
        Left = 0
        Top = 21
        Width = 643
        Height = 71
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
    end
  end
  object SpTBXStatusBar1: TSpTBXStatusBar
    Left = 0
    Top = 603
    Width = 944
    Height = 26
  end
  object dckToolBar: TSpTBXDock
    Left = 0
    Top = 0
    Width = 944
    Height = 26
    object ToolBar2: TSpTBXToolbar
      Left = 596
      Top = 0
      DefaultDock = dckToolBar
      DockableTo = [dpTop]
      DockMode = dmCannotFloatOrChangeDocks
      DockPos = 596
      Images = dmIDEActions.ImageList1
      ParentShowHint = False
      ProcessShortCuts = True
      ShowHint = True
      TabOrder = 0
      Visible = False
      Caption = 'ToolBar1'
      object tbNewProject: TSpTBXItem
        Action = dmIDEActions.acNewProject
        Enabled = False
        Top = 2
      end
      object tbOpenProject: TSpTBXItem
        Action = dmIDEActions.acOpenProject
        Enabled = False
        Left = 23
        Top = 2
      end
      object tbSaveAll: TSpTBXItem
        Action = dmIDEActions.acSaveAll
        Enabled = False
        Left = 46
        Top = 2
      end
    end
    object ToolBar4: TSpTBXToolbar
      Left = 0
      Top = 0
      DefaultDock = dckToolBar
      DockableTo = [dpTop]
      DockMode = dmCannotFloatOrChangeDocks
      DockPos = 0
      Images = dmIDEActions.ImageList1
      ParentShowHint = False
      ProcessShortCuts = True
      ShowHint = True
      TabOrder = 1
      Caption = 'ToolBar1'
      object tbNewUnit: TSpTBXItem
        Action = dmIDEActions.acNewUnit
        Top = 2
      end
      object tbNewForm: TSpTBXItem
        Action = dmIDEActions.acNewForm
        Visible = False
        Left = 23
        Top = 2
      end
      object tbOpenFile: TSpTBXItem
        Action = dmIDEActions.acOpenFile
        Left = 46
        Top = 2
      end
      object tbSaveFile: TSpTBXItem
        Action = dmIDEActions.acSaveFile
        Left = 69
        Top = 2
      end
    end
    object tbEdit: TSpTBXToolbar
      Left = 79
      Top = 0
      DefaultDock = dckToolBar
      DockableTo = [dpTop]
      DockMode = dmCannotFloatOrChangeDocks
      DockPos = 78
      Images = dmIDEActions.ImageList1
      ParentShowHint = False
      ProcessShortCuts = True
      ShowHint = True
      TabOrder = 2
      Caption = 'ToolBar1'
      object tbCut: TSpTBXItem
        Action = dmIDEActions.acCutClipboard
        Top = 2
      end
      object tbCopy: TSpTBXItem
        Action = dmIDEActions.acCopyClipboard
        Left = 23
        Top = 2
      end
      object tbPaste: TSpTBXItem
        Action = dmIDEActions.acPasteClipboard
        Left = 46
        Top = 2
      end
    end
    object ToolBar1: TSpTBXToolbar
      Left = 158
      Top = 0
      DefaultDock = dckToolBar
      DockableTo = [dpTop]
      DockMode = dmCannotFloatOrChangeDocks
      DockPos = 146
      Images = dmIDEActions.ImageList1
      ParentShowHint = False
      ProcessShortCuts = True
      ShowHint = True
      TabOrder = 3
      Caption = 'tbProject'
      object tbRun: TSpTBXItem
        Action = dmIDEActions.acRun
        Top = 2
      end
      object tbPause: TSpTBXItem
        Action = dmIDEActions.acPause
        Left = 23
        Top = 2
      end
      object tbReset: TSpTBXItem
        Action = dmIDEActions.acReset
        Left = 46
        Top = 2
      end
      object SpTBXSeparatorItem1: TSpTBXSeparatorItem
      end
      object tbTraceInto: TSpTBXItem
        Action = dmIDEActions.acTraceInto
        Left = 77
        Top = 2
      end
      object tbStepOver: TSpTBXItem
        Action = dmIDEActions.acStepOver
        Left = 100
        Top = 2
      end
      object SpTBXSeparatorItem2: TSpTBXSeparatorItem
      end
      object tbToggleBreakPoint: TSpTBXItem
        Action = dmIDEActions.acToggleBreak
        Left = 131
        Top = 2
      end
      object tbAddWatch: TSpTBXItem
        Action = dmIDEActions.acAddWatch
        Left = 154
        Top = 2
      end
    end
  end
  object ScripterEngine: TIDEEngine
    Scripter = ScripterMain
    WatchList = WatchList
    Memo = MemoSource
    Options.AutoHideTabControl = True
    FileExtPascalUnit = '.psc'
    FileExtForm = '.sfm'
    FileExtBasicUnit = '.bsc'
    AutoStyler = True
    Left = 11
    Top = 38
  end
  object LMDDockManager1: TLMDDockManager
    StyleName = 'VS2012Dark'
    Left = 9
    Top = 67
  end
  object ScripterMain: TIDEScripter
    DefaultLanguage = slPascal
    SaveCompiledCode = False
    ShortBooleanEval = True
    LibOptions.SearchPath.Strings = (
      '$(CURDIR)'
      '$(APPDIR)'
      '$(APPDIR)\Scripts'
      'V:\TSTOModToolKit\Bin\Scripts')
    LibOptions.SourceFileExt = '.psc'
    LibOptions.CompiledFileExt = '.pcu'
    LibOptions.UseScriptFiles = True
    CallExecHookEvent = False
    Left = 42
    Top = 39
  end
end
