object FrmCustomPatches: TFrmCustomPatches
  Left = 0
  Top = 0
  Caption = 'Custom Patches'
  ClientHeight = 494
  ClientWidth = 753
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object PanInfo: TPanel
    Left = 205
    Top = 26
    Width = 548
    Height = 468
    Align = alClient
    BevelOuter = bvNone
    Color = 2499877
    ParentBackground = False
    TabOrder = 0
    object EditXml: TScintillaNPP
      Left = 0
      Top = 227
      Width = 548
      Height = 213
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      Align = alClient
      EOLStyle = eolCRLF
      Indentation = [TabIndents]
      IndentWidth = 0
      MarginLeft = 1
      MarginRight = 1
      CodePage = 0
      Caret.ForeColor = clBlack
      Caret.LineBackColor = clYellow
      Caret.LineVisible = False
      Caret.Width = 1
      Caret.Period = 530
      Caret.LineBackAlpha = 256
      OtherOptions.ViewWSpace = sciWsInvisible
      OtherOptions.OverType = False
      OtherOptions.ViewEOL = False
      OtherOptions.EndAtLastLine = True
      OtherOptions.ScrollBarH = True
      OtherOptions.ScrollBarV = True
      OtherOptions.ScrollWidthTracking = False
      OtherOptions.PasteConvertEndings = True
      ActiveHotSpot.BackColor = clDefault
      ActiveHotSpot.ForeColor = clBlue
      ActiveHotSpot.Underlined = True
      ActiveHotSpot.SingleLine = False
      Colors.SelFore = clHighlightText
      Colors.SelBack = 14342874
      Colors.MarkerFore = 15987699
      Colors.MarkerBack = clGray
      Colors.MarkerActive = clRed
      Colors.FoldHi = clBtnFace
      Colors.FoldLo = clBtnFace
      Colors.WhiteSpaceFore = clDefault
      Colors.WhiteSpaceBack = clDefault
      Bookmark.BackColor = clDefault
      Bookmark.ForeColor = clDefault
      Bookmark.ActiveColor = clDefault
      Bookmark.PixmapFile = ''
      Bookmark.MarkerType = 25
      Gutter0.Width = 32
      Gutter0.MarginType = gutLineNumber
      Gutter0.Sensitive = False
      Gutter1.Width = 16
      Gutter1.MarginType = gutSymbol
      Gutter1.Sensitive = True
      Gutter2.Width = 0
      Gutter2.MarginType = gutSymbol
      Gutter2.Sensitive = True
      Gutter3.Width = 0
      Gutter3.MarginType = gutSymbol
      Gutter3.Sensitive = False
      Gutter4.Width = 0
      Gutter4.MarginType = gutSymbol
      Gutter4.Sensitive = False
      WordWrapVisualFlags = []
      WordWrapVisualFlagsLocation = []
      LayoutCache = sciCacheCaret
      HideSelect = False
      WordWrap = sciNoWrap
      EdgeColor = clSilver
      WordChars = '_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
      ControlCharSymbol = #0
      Folding = [foldCompact, foldComment, foldPreprocessor, foldAtElse, foldHTML, foldHTMLPreProcessor]
      FoldMarkers.MarkerType = sciMarkBox
      FoldMarkers.FoldOpen.BackColor = clDefault
      FoldMarkers.FoldOpen.ForeColor = clDefault
      FoldMarkers.FoldOpen.ActiveColor = clDefault
      FoldMarkers.FoldOpen.PixmapFile = ''
      FoldMarkers.FoldOpen.MarkerType = 14
      FoldMarkers.FoldClosed.BackColor = clDefault
      FoldMarkers.FoldClosed.ForeColor = clDefault
      FoldMarkers.FoldClosed.ActiveColor = clDefault
      FoldMarkers.FoldClosed.PixmapFile = ''
      FoldMarkers.FoldClosed.MarkerType = 12
      FoldMarkers.FoldSub.BackColor = clDefault
      FoldMarkers.FoldSub.ForeColor = clDefault
      FoldMarkers.FoldSub.ActiveColor = clDefault
      FoldMarkers.FoldSub.PixmapFile = ''
      FoldMarkers.FoldSub.MarkerType = 9
      FoldMarkers.FoldTail.BackColor = clDefault
      FoldMarkers.FoldTail.ForeColor = clDefault
      FoldMarkers.FoldTail.ActiveColor = clDefault
      FoldMarkers.FoldTail.PixmapFile = ''
      FoldMarkers.FoldTail.MarkerType = 10
      FoldMarkers.FoldEnd.BackColor = clDefault
      FoldMarkers.FoldEnd.ForeColor = clDefault
      FoldMarkers.FoldEnd.ActiveColor = clDefault
      FoldMarkers.FoldEnd.PixmapFile = ''
      FoldMarkers.FoldEnd.MarkerType = 13
      FoldMarkers.FoldOpenMid.BackColor = clDefault
      FoldMarkers.FoldOpenMid.ForeColor = clDefault
      FoldMarkers.FoldOpenMid.ActiveColor = clDefault
      FoldMarkers.FoldOpenMid.PixmapFile = ''
      FoldMarkers.FoldOpenMid.MarkerType = 15
      FoldMarkers.FoldMidTail.BackColor = clDefault
      FoldMarkers.FoldMidTail.ForeColor = clDefault
      FoldMarkers.FoldMidTail.ActiveColor = clDefault
      FoldMarkers.FoldMidTail.PixmapFile = ''
      FoldMarkers.FoldMidTail.MarkerType = 11
      FoldDrawFlags = [sciBelowIfNotExpanded, sciEnableHighlight]
      KeyCommands = <
        item
          Command = 2300
          ShortCut = 40
        end
        item
          Command = 2301
          ShortCut = 8232
        end
        item
          Command = 2342
          ShortCut = 16424
        end
        item
          Command = 2426
          ShortCut = 41000
        end
        item
          Command = 2302
          ShortCut = 38
        end
        item
          Command = 2303
          ShortCut = 8230
        end
        item
          Command = 2343
          ShortCut = 16422
        end
        item
          Command = 2427
          ShortCut = 40998
        end
        item
          Command = 2415
          ShortCut = 49190
        end
        item
          Command = 2416
          ShortCut = 57382
        end
        item
          Command = 2413
          ShortCut = 49192
        end
        item
          Command = 2414
          ShortCut = 57384
        end
        item
          Command = 2304
          ShortCut = 37
        end
        item
          Command = 2305
          ShortCut = 8229
        end
        item
          Command = 2308
          ShortCut = 16421
        end
        item
          Command = 2309
          ShortCut = 24613
        end
        item
          Command = 2428
          ShortCut = 40997
        end
        item
          Command = 2306
          ShortCut = 39
        end
        item
          Command = 2307
          ShortCut = 8231
        end
        item
          Command = 2310
          ShortCut = 16423
        end
        item
          Command = 2311
          ShortCut = 24615
        end
        item
          Command = 2429
          ShortCut = 40999
        end
        item
          Command = 2390
          ShortCut = 49189
        end
        item
          Command = 2391
          ShortCut = 57381
        end
        item
          Command = 2392
          ShortCut = 49191
        end
        item
          Command = 2393
          ShortCut = 57383
        end
        item
          Command = 2331
          ShortCut = 36
        end
        item
          Command = 2332
          ShortCut = 8228
        end
        item
          Command = 2431
          ShortCut = 40996
        end
        item
          Command = 2316
          ShortCut = 16420
        end
        item
          Command = 2317
          ShortCut = 24612
        end
        item
          Command = 2345
          ShortCut = 32804
        end
        item
          Command = 2314
          ShortCut = 35
        end
        item
          Command = 2315
          ShortCut = 8227
        end
        item
          Command = 2318
          ShortCut = 16419
        end
        item
          Command = 2319
          ShortCut = 24611
        end
        item
          Command = 2347
          ShortCut = 32803
        end
        item
          Command = 2432
          ShortCut = 40995
        end
        item
          Command = 2320
          ShortCut = 33
        end
        item
          Command = 2321
          ShortCut = 8225
        end
        item
          Command = 2433
          ShortCut = 40993
        end
        item
          Command = 2322
          ShortCut = 34
        end
        item
          Command = 2323
          ShortCut = 8226
        end
        item
          Command = 2434
          ShortCut = 40994
        end
        item
          Command = 2180
          ShortCut = 46
        end
        item
          Command = 2177
          ShortCut = 8238
        end
        item
          Command = 2336
          ShortCut = 16430
        end
        item
          Command = 2396
          ShortCut = 24622
        end
        item
          Command = 2324
          ShortCut = 45
        end
        item
          Command = 2179
          ShortCut = 8237
        end
        item
          Command = 2178
          ShortCut = 16429
        end
        item
          Command = 2325
          ShortCut = 27
        end
        item
          Command = 2326
          ShortCut = 8
        end
        item
          Command = 2326
          ShortCut = 8200
        end
        item
          Command = 2335
          ShortCut = 16392
        end
        item
          Command = 2176
          ShortCut = 32776
        end
        item
          Command = 2395
          ShortCut = 24584
        end
        item
          Command = 2176
          ShortCut = 16474
        end
        item
          Command = 2011
          ShortCut = 16473
        end
        item
          Command = 2177
          ShortCut = 16472
        end
        item
          Command = 2178
          ShortCut = 16451
        end
        item
          Command = 2179
          ShortCut = 16470
        end
        item
          Command = 2013
          ShortCut = 16449
        end
        item
          Command = 2327
          ShortCut = 9
        end
        item
          Command = 2328
          ShortCut = 8201
        end
        item
          Command = 2329
          ShortCut = 13
        end
        item
          Command = 2329
          ShortCut = 8205
        end
        item
          Command = 2333
          ShortCut = 16491
        end
        item
          Command = 2334
          ShortCut = 16493
        end
        item
          Command = 2373
          ShortCut = 16495
        end
        item
          Command = 2337
          ShortCut = 16460
        end
        item
          Command = 2338
          ShortCut = 24652
        end
        item
          Command = 2455
          ShortCut = 24660
        end
        item
          Command = 2339
          ShortCut = 16468
        end
        item
          Command = 2469
          ShortCut = 16452
        end
        item
          Command = 2340
          ShortCut = 16469
        end
        item
          Command = 2341
          ShortCut = 24661
        end>
      SelectedLanguage = 'XML'
      ExplicitTop = 235
    end
    object vstPatchData: TSpTBXVirtualStringTree
      AlignWithMargins = True
      Left = 3
      Top = 124
      Width = 542
      Height = 100
      Version = '6.2.5.918'
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNone
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.AutoSizeIndex = 2
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoOwnerDraw, hoShowSortGlyphs, hoVisible]
      ParentFont = False
      PopupMenu = popVSTPatchData
      TabOrder = 0
      TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning, toEditOnClick]
      TreeOptions.PaintOptions = [toHotTrack, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowVertGridLines, toThemeAware, toUseBlendedImages, toAlwaysHideSelection]
      TreeOptions.SelectionOptions = [toExtendedFocus]
      OnAfterCellPaint = vstPatchDataAfterCellPaint
      OnCreateEditor = vstPatchDataCreateEditor
      OnFocusChanged = vstPatchDataFocusChanged
      OnGetText = vstPatchDataGetText
      OnInitNode = vstPatchDataInitNode
      OnKeyAction = vstPatchDataKeyAction
      Columns = <
        item
          Position = 0
          Width = 88
          WideText = 'Type'
        end
        item
          Position = 1
          Width = 160
          WideText = 'XPath'
        end
        item
          Position = 2
          Width = 290
          WideText = 'Code'
        end>
    end
    object gbPatchInfoV2: TSpTBXGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 542
      Height = 115
      Caption = ' Patch Info '
      Color = 2499877
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 15856113
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      DesignSize = (
        542
        115)
      object lblPatchName: TLabel
        Left = 10
        Top = 27
        Width = 27
        Height = 13
        Caption = 'Name'
      end
      object lblPatchDesc: TLabel
        Left = 10
        Top = 54
        Width = 53
        Height = 13
        Caption = 'Description'
      end
      object lblPatchFileName: TLabel
        Left = 10
        Top = 79
        Width = 43
        Height = 13
        Caption = 'FileName'
      end
      object EditPatchName: TEdit
        Left = 71
        Top = 23
        Width = 460
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnExit = EditPatchNameExit
      end
      object EditPatchDesc: TEdit
        Left = 71
        Top = 50
        Width = 460
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnExit = EditPatchDescExit
      end
      object EditPatchFileName: TEdit
        Left = 71
        Top = 75
        Width = 460
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnExit = EditPatchFileNameExit
      end
    end
    object tsXmlV2: TSpTBXTabSet
      Left = 0
      Top = 440
      Width = 548
      Height = 28
      Align = alBottom
      ActiveTabIndex = 0
      TabPosition = ttpBottom
      OnActiveTabChange = tsXmlV2ActiveTabChange
      HiddenItems = <>
      object tsInput: TSpTBXTabItem
        Caption = 'Input'
        Checked = True
      end
      object tsXPathResult: TSpTBXTabItem
        Caption = 'XPath Result'
      end
      object tsOutput: TSpTBXTabItem
        Caption = 'Output'
      end
    end
  end
  object PanTreeView: TPanel
    Left = 0
    Top = 26
    Width = 200
    Height = 468
    Align = alLeft
    BevelOuter = bvNone
    Color = 2499877
    ParentBackground = False
    TabOrder = 1
    object vstCustomPacthes: TSpTBXVirtualStringTree
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 194
      Height = 462
      Version = '6.2.5.918'
      Align = alClient
      Header.AutoSizeIndex = 0
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      Header.MainColumn = -1
      Header.Options = [hoColumnResize, hoDrag, hoOwnerDraw, hoShowSortGlyphs]
      PopupMenu = popVSTCustomPatches
      TabOrder = 0
      TreeOptions.PaintOptions = [toHideFocusRect, toHotTrack, toPopupMode, toShowButtons, toShowDropmark, toThemeAware, toUseBlendedImages]
      TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect]
      OnFocusChanged = vstCustomPacthesFocusChanged
      OnGetText = vstCustomPacthesGetText
      OnInitNode = vstCustomPacthesInitNode
      Columns = <>
    end
  end
  object dckTbMain: TSpTBXDock
    Left = 0
    Top = 0
    Width = 753
    Height = 26
    AllowDrag = False
    object tbMainV2: TSpTBXToolbar
      Left = 0
      Top = 0
      CloseButton = False
      DockPos = 0
      FullSize = True
      Images = DataModuleImage.imgToolBar
      ProcessShortCuts = True
      ShrinkMode = tbsmWrap
      TabOrder = 0
      Caption = 'tbMainV2'
      Customizable = False
      MenuBar = True
      object tbSave: TSpTBXItem
        Enabled = False
        ImageIndex = 2
        OnClick = tbSaveOldClick
      end
    end
  end
  object SplitterV2: TSpTBXSplitter
    Left = 200
    Top = 26
    Height = 468
    Cursor = crSizeWE
  end
  object popVSTCustomPatches: TSpTBXPopupMenu
    Left = 56
    Top = 138
    object popAddPatch: TSpTBXItem
      Caption = 'Add'
      OnClick = popAddPatchClick
    end
    object popDeletePatch: TSpTBXItem
      Caption = 'Delete'
      OnClick = popDeletePatchClick
    end
  end
  object actlstScintilla: TActionList
    Left = 56
    Top = 72
    object SciToggleBookMark1: TSciToggleBookMark
      Category = 'ScIntilla'
      Caption = 'Toggle Bookmark'
      ShortCut = 16497
    end
    object SciNextBookmark1: TSciNextBookmark
      Category = 'ScIntilla'
      Caption = 'Next Bookmark'
      ShortCut = 113
    end
    object SciPrevBookmark1: TSciPrevBookmark
      Category = 'ScIntilla'
      Caption = 'Previous Bookmark'
      ShortCut = 8305
    end
    object SciFoldAll1: TSciFoldAll
      Category = 'ScIntilla'
      Caption = 'Fold All'
      ShortCut = 32816
    end
    object SciUnFoldAll1: TSciUnFoldAll
      Category = 'ScIntilla'
      Caption = 'Unfold All'
      ShortCut = 41008
    end
    object SciCollapseCurrentLevel1: TSciCollapseCurrentLevel
      Category = 'ScIntilla'
      Caption = 'Collapse Current Level'
      ShortCut = 49222
    end
    object SciUnCollapseCurrentLevel1: TSciUnCollapseCurrentLevel
      Category = 'ScIntilla'
      Caption = 'Uncollapse Current Level'
      ShortCut = 57414
    end
    object SciCollapseLevel11: TSciCollapseLevel1
      Category = 'ScIntilla'
      Caption = 'Collapse Level 1'
      ShortCut = 32817
    end
    object SciCollapseLevel21: TSciCollapseLevel2
      Category = 'ScIntilla'
      Caption = 'Collapse Level 2'
      ShortCut = 32818
    end
    object SciCollapseLevel31: TSciCollapseLevel3
      Category = 'ScIntilla'
      Caption = 'Collapse Level 3'
      ShortCut = 32819
    end
    object SciCollapseLevel41: TSciCollapseLevel4
      Category = 'ScIntilla'
      Caption = 'Collapse Level 4'
      ShortCut = 32820
    end
    object SciExpandLevel11: TSciExpandLevel1
      Category = 'ScIntilla'
      Caption = 'Uncollapse Level 1'
      ShortCut = 41009
    end
    object SciExpandLevel21: TSciExpandLevel2
      Category = 'ScIntilla'
      Caption = 'Uncollapse Level 2'
      ShortCut = 41010
    end
    object SciExpandLevel31: TSciExpandLevel3
      Category = 'ScIntilla'
      Caption = 'Uncollapse Level 3'
      ShortCut = 41011
    end
    object SciExpandLevel41: TSciExpandLevel4
      Category = 'ScIntilla'
      Caption = 'Uncollapse Level 4'
      ShortCut = 41012
    end
  end
  object popVSTPatchData: TSpTBXPopupMenu
    Left = 368
    Top = 178
    object popAddPatchData: TSpTBXItem
      Caption = 'Add'
      OnClick = popAddPatchDataClick
    end
    object popDeletePatchData: TSpTBXItem
      Caption = 'Delete'
      OnClick = popDeletePatchDataClick
    end
  end
end
