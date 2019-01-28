object FrmDckMain: TFrmDckMain
  Left = 0
  Top = 0
  Caption = 'TSTO Mod Studio'
  ClientHeight = 713
  ClientWidth = 719
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanToolBar: TPanel
    Left = 0
    Top = 0
    Width = 719
    Height = 51
    Align = alTop
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 0
    object sptbxDckMain: TSpTBXDock
      Left = 0
      Top = 0
      Width = 719
      Height = 51
      AllowDrag = False
      object sptbxMainMenu: TSpTBXToolbar
        Left = 0
        Top = 0
        Align = alTop
        DockPos = 0
        FullSize = True
        Images = DataModuleImage.imgToolBar
        TabOrder = 0
        OnMouseDown = sptbxMainMenuMouseDown
        object mnuFile: TSpTBXSubmenuItem
          Caption = '&File'
          object mnuSettings: TSpTBXItem
            Caption = '&Settings'
            OnClick = mnuSettingsClick
          end
          object mnuOpenWorkspace: TSpTBXItem
            Caption = 'Open Workspace'
            OnClick = mnuOpenWorkspaceClick
          end
          object mnuCloseWorkspace: TSpTBXItem
            Caption = 'Close Workspace'
            OnClick = mnuCloseWorkspaceClick
          end
          object N3: TSpTBXSeparatorItem
          end
          object mnuCustomPatch: TSpTBXItem
            Caption = 'Custom Patch'
            OnClick = mnuCustomPatchClick
          end
          object mnuSbtpCustomPatch: TSpTBXItem
            Caption = 'Sbtp Custom Patch'
            OnClick = mnuSbtpCustomPatchClick
          end
          object N1: TSpTBXSeparatorItem
          end
          object mnuExit: TSpTBXItem
            Caption = '&Exit'
            OnClick = mnuExitClick
          end
        end
        object mnuWindow: TSpTBXSubmenuItem
          Caption = 'Window'
          object N2: TSpTBXSeparatorItem
          end
          object mnuDefaultLayout: TSpTBXItem
            Caption = 'Default Layout'
            OnClick = mnuDefaultLayoutClick
          end
        end
        object mnuTools: TSpTBXSubmenuItem
          Caption = 'Tools'
          object mnuDownloadAllIndexes: TSpTBXItem
            Caption = 'Download all indexes'
            OnClick = mnuDownloadAllIndexesClick
          end
          object mnuIndexes: TSpTBXSubmenuItem
            Caption = 'Indexes'
            LinkSubitems = mnuIndexesItems
          end
          object SpTBXSeparatorItem1: TSpTBXSeparatorItem
          end
          object mnuToolServer: TSpTBXTBGroupItem
            LinkSubitems = tbServerItems
          end
          object mnuToolPopup: TSpTBXTBGroupItem
            LinkSubitems = tbPopupMenuItems
          end
          object mnuToolMisc: TSpTBXTBGroupItem
            LinkSubitems = tbMiscItems
          end
        end
        object mnuSkin: TSpTBXSubmenuItem
          Caption = 'Skin'
          Visible = False
          object SpTBXSkinGroupItem1: TSpTBXSkinGroupItem
          end
        end
      end
      object sptbxtbMain: TSpTBXToolbar
        Left = 0
        Top = 25
        Align = alTop
        CloseButton = False
        DockPos = 0
        DockRow = 2
        FullSize = True
        Images = DataModuleImage.imgToolBar
        ProcessShortCuts = True
        Resizable = False
        ShrinkMode = tbsmWrap
        Stretch = True
        TabOrder = 1
        OnMouseDown = sptbxtbMainMouseDown
        Caption = 'sptbxtbMain'
        Customizable = False
        MenuBar = True
        object tbMainServer: TSpTBXTBGroupItem
          LinkSubitems = tbServerItems
        end
        object tbMainPopup: TSpTBXTBGroupItem
          LinkSubitems = tbPopupMenuItems
        end
        object tbMainMisc: TSpTBXTBGroupItem
          LinkSubitems = tbMiscItems
        end
        object SpTBXItem3: TSpTBXItem
          ImageIndex = 35
          OnClick = SpTBXItem3Click
        end
      end
    end
  end
  object dckMain: TLMDDockSite
    Left = 0
    Top = 51
    Width = 719
    Height = 662
    Manager = dckMgr
    Align = alClient
    TabOrder = 1
    Layout = {
      EFBBBF3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D
      227574662D38223F3E0D0A3C736974656C6973743E0D0A093C73697465206964
      3D2253454C465F53495445223E0D0A09093C7A6F6E65206B696E643D22484F52
      5A223E0D0A0909093C7A6F6E65206B696E643D22544142532220616374697665
      7461623D2230222073697A653D2231353022206473697A653D22302E32313339
      38303032383533303637223E0D0A090909093C7A6F6E65206B696E643D225041
      4E454C222069643D2250616E5472656556696577222076697369626C653D2231
      222F3E0D0A090909093C7A6F6E65206B696E643D2250414E454C222069643D22
      50616E50726F6A656374222076697369626C653D2231222F3E0D0A090909093C
      7A6F6E65206B696E643D2250414E454C222069643D2250616E5265736F757263
      6573222076697369626C653D2231222F3E0D0A0909093C2F7A6F6E653E0D0A09
      09093C7A6F6E65206B696E643D225441425322206163746976657461623D2230
      222073697A653D2235353122206473697A653D22302E37383630313939373134
      363933332220697373706163653D2231223E0D0A090909093C7A6F6E65206B69
      6E643D2250414E454C222069643D2250616E496E666F222076697369626C653D
      2231222F3E0D0A090909093C7A6F6E65206B696E643D2250414E454C22206964
      3D2250616E53627470222076697369626C653D2231222F3E0D0A090909093C7A
      6F6E65206B696E643D2250414E454C222069643D2250616E4865784564697422
      2076697369626C653D2231222F3E0D0A090909093C7A6F6E65206B696E643D22
      50414E454C222069643D2250616E4861636B54656D706C6174654D6173746572
      222076697369626C653D2231222F3E0D0A0909093C2F7A6F6E653E0D0A09093C
      2F7A6F6E653E0D0A093C2F736974653E0D0A3C2F736974656C6973743E}
    object PanHackTemplateMaster: TLMDDockPanel
      Left = 162
      Top = 27
      Width = 551
      Height = 629
      ParentBackground = False
      TabOrder = 10
      Caption = 'Script Template'
      object LMDDockSite1: TLMDDockSite
        Left = 0
        Top = 0
        Width = 551
        Height = 629
        Manager = dckMgr
        Align = alClient
        TabOrder = 0
        Layout = {
          EFBBBF3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D
          227574662D38223F3E0D0A3C736974656C6973743E0D0A093C73697465206964
          3D2253454C465F53495445223E0D0A09093C7A6F6E65206B696E643D22484F52
          5A223E0D0A0909093C7A6F6E65206B696E643D2256455254222073697A653D22
          32303722206473697A653D22302E333838333637373239383331313434223E0D
          0A090909093C7A6F6E65206B696E643D2250414E454C222069643D2250616E54
          764861636B54656D706C617465222076697369626C653D2231222073697A653D
          2233303322206473697A653D22302E343935393038333436393732313737222F
          3E0D0A090909093C7A6F6E65206B696E643D2254414253222061637469766574
          61623D2231222073697A653D2233303822206473697A653D22302E3530343039
          31363533303237383233223E0D0A09090909093C7A6F6E65206B696E643D2250
          414E454C222069643D2250616E535453657474696E6773222076697369626C65
          3D2231222F3E0D0A09090909093C7A6F6E65206B696E643D2250414E454C2220
          69643D2250616E53545661726961626C6573222076697369626C653D2231222F
          3E0D0A090909093C2F7A6F6E653E0D0A0909093C2F7A6F6E653E0D0A0909093C
          7A6F6E65206B696E643D225441425322206163746976657461623D2230222073
          697A653D2233323622206473697A653D22302E36313136333232373031363838
          35362220697373706163653D2231223E0D0A090909093C7A6F6E65206B696E64
          3D2250414E454C222069643D2250616E4861636B54656D706C61746522207669
          7369626C653D2231222F3E0D0A0909093C2F7A6F6E653E0D0A09093C2F7A6F6E
          653E0D0A093C2F736974653E0D0A3C2F736974656C6973743E}
        object PanHackTemplate: TLMDDockPanel
          Left = 219
          Top = 27
          Width = 326
          Height = 596
          ParentBackground = False
          TabOrder = 5
          Caption = 'Template Source'
          object EditScriptTemplate: TScintillaNPP
            Left = 0
            Top = 0
            Width = 326
            Height = 568
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
            LanguageManager = SciLangMgr
            SelectedLanguage = 'XML'
            ExplicitLeft = 4
            ExplicitTop = 4
            ExplicitWidth = 377
            ExplicitHeight = 417
          end
          object tsScriptTemplate: TSpTBXTabSet
            Left = 0
            Top = 568
            Width = 326
            Height = 28
            Align = alBottom
            ActiveTabIndex = 0
            TabPosition = ttpBottom
            OnActiveTabChange = tsScriptTemplateActiveTabChange
            HiddenItems = <>
            object tsSTSource: TSpTBXTabItem
              Caption = 'Source'
              Checked = True
            end
            object tsSTOutput: TSpTBXTabItem
              Caption = 'Output'
            end
          end
        end
        object PanSTSettings: TLMDDockPanel
          Left = 6
          Top = 315
          Width = 207
          Height = 288
          ParentBackground = False
          TabOrder = 7
          Caption = 'Settings'
        end
        object PanSTVariables: TLMDDockPanel
          Left = 6
          Top = 315
          Width = 207
          Height = 288
          ParentBackground = False
          TabOrder = 6
          Caption = 'Variables'
        end
        object PanTvHackTemplate: TLMDDockPanel
          Left = 6
          Top = 6
          Width = 207
          Height = 303
          Buttons = [pbPin, pbMaximize, pbClose]
          ParentBackground = False
          TabOrder = 4
          Caption = 'Templates'
        end
      end
    end
    object PanHexEdit: TLMDDockPanel
      Left = 162
      Top = 27
      Width = 551
      Height = 629
      Buttons = [pbPin, pbMaximize, pbClose]
      ParentBackground = False
      TabOrder = 7
      Caption = 'Hex Editor'
      OnEnter = PanImageEnter
      object KHexEditor: TKHexEditor
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 545
        Height = 623
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Courier New'
        Font.Pitch = fpFixed
        Font.Style = [fsBold]
        TabOrder = 0
      end
    end
    object PanInfo: TLMDDockPanel
      Left = 162
      Top = 27
      Width = 551
      Height = 629
      Buttons = [pbMenu, pbPin, pbMaximize]
      ParentBackground = False
      TabOrder = 8
      Caption = 'XML Editor'
      object dckInfo: TLMDDockSite
        Left = 0
        Top = 0
        Width = 551
        Height = 629
        Manager = dckMgr
        Align = alClient
        TabOrder = 0
        Layout = {
          EFBBBF3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D
          227574662D38223F3E0D0A3C736974656C6973743E0D0A093C73697465206964
          3D2253454C465F53495445223E0D0A09093C7A6F6E65206B696E643D22564552
          54223E0D0A0909093C7A6F6E65206B696E643D2250414E454C222069643D2250
          616E46696C65496E666F222076697369626C653D2231222073697A653D223130
          3922206473697A653D22302E313830313635323839323536313938222F3E0D0A
          0909093C7A6F6E65206B696E643D225441425322206163746976657461623D22
          30222073697A653D2232353422206473697A653D22302E343139383334373130
          3734333830322220697373706163653D2231223E0D0A090909093C7A6F6E6520
          6B696E643D2250414E454C222069643D2250616E4D6F644F7074696F6E732220
          76697369626C653D2231222F3E0D0A090909093C7A6F6E65206B696E643D2250
          414E454C222069643D2250616E437573746F6D4D6F64222076697369626C653D
          2231222F3E0D0A0909093C2F7A6F6E653E0D0A0909093C7A6F6E65206B696E64
          3D2250414E454C222069643D2250616E496D616765222076697369626C653D22
          31222073697A653D2232343222206473697A653D22302E34222F3E0D0A09093C
          2F7A6F6E653E0D0A093C2F736974653E0D0A3C2F736974656C6973743E}
        object PanCustomMod: TLMDDockPanel
          Left = 6
          Top = 142
          Width = 539
          Height = 233
          Buttons = [pbPin, pbMaximize, pbClose]
          ParentBackground = False
          TabOrder = 6
          Caption = 'Custom Mod'
        end
        object PanFileInfo: TLMDDockPanel
          Left = 6
          Top = 6
          Width = 539
          Height = 109
          Buttons = [pbPin, pbMaximize, pbClose]
          ParentBackground = False
          TabOrder = 4
          Caption = 'File Info'
          DesignSize = (
            539
            109)
          object Label6: TLabel
            Left = 225
            Top = 83
            Width = 47
            Height = 13
            Caption = 'Language'
          end
          object Label4: TLabel
            Left = 137
            Top = 83
            Width = 35
            Height = 13
            Caption = 'Version'
          end
          object Label2: TLabel
            Left = 137
            Top = 60
            Width = 18
            Height = 13
            Caption = 'Tier'
          end
          object Label3: TLabel
            Left = 13
            Top = 83
            Width = 54
            Height = 13
            Caption = 'Min Version'
          end
          object Label1: TLabel
            Left = 12
            Top = 60
            Width = 40
            Height = 13
            Caption = 'Platform'
          end
          object Label5: TLabel
            Left = 12
            Top = 33
            Width = 43
            Height = 13
            Caption = 'FileName'
          end
          object EditLanguage: TEdit
            Left = 282
            Top = 79
            Width = 34
            Height = 21
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 5
          end
          object EditVersion: TEdit
            Left = 181
            Top = 79
            Width = 34
            Height = 21
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
          end
          object EditTier: TEdit
            Left = 181
            Top = 54
            Width = 57
            Height = 21
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
          end
          object EditMinVersion: TEdit
            Left = 70
            Top = 79
            Width = 57
            Height = 21
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 3
          end
          object EditPlatform: TEdit
            Left = 70
            Top = 54
            Width = 57
            Height = 21
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 1
          end
          object EditFileName: TEdit
            Left = 70
            Top = 29
            Width = 457
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
          end
        end
        object PanImage: TLMDDockPanel
          Left = 6
          Top = 381
          Width = 539
          Height = 242
          Buttons = [pbPin, pbMaximize, pbClose]
          ParentBackground = False
          TabOrder = 7
          Caption = 'Image'
          OnEnter = PanImageEnter
          object ScrlImage: TScrollBox
            AlignWithMargins = True
            Left = 3
            Top = 60
            Width = 533
            Height = 179
            Align = alClient
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            BorderStyle = bsNone
            TabOrder = 1
            object ImgResource: TImage
              Left = 0
              Top = 0
              Width = 94
              Height = 74
              AutoSize = True
            end
          end
          object PanSize: TPanel
            AlignWithMargins = True
            Left = 3
            Top = 24
            Width = 533
            Height = 30
            Align = alTop
            BevelOuter = bvLowered
            ParentColor = True
            TabOrder = 0
            object Label7: TLabel
              Left = 16
              Top = 9
              Width = 22
              Height = 13
              Caption = 'Size '
            end
            object EditImageSize: TEdit
              Left = 73
              Top = 5
              Width = 125
              Height = 21
              Color = clBtnFace
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 0
            end
          end
        end
        object PanModOptions: TLMDDockPanel
          Left = 6
          Top = 142
          Width = 539
          Height = 233
          Buttons = [pbPin, pbMaximize, pbClose]
          ParentBackground = False
          TabOrder = 5
          Caption = 'Mod Options'
          object chkUnlimitedTime: TSpTBXCheckBox
            Left = 13
            Top = 127
            Width = 92
            Height = 21
            Caption = 'Unlimited Time'
            ParentColor = True
            TabOrder = 5
          end
          object chkFreeLandUpgade: TSpTBXCheckBox
            Left = 13
            Top = 106
            Width = 116
            Height = 21
            Caption = 'Free Land Upgrade'
            ParentColor = True
            TabOrder = 4
          end
          object chkNonUnique: TSpTBXCheckBox
            Left = 13
            Top = 85
            Width = 78
            Height = 21
            Caption = 'Non unique'
            ParentColor = True
            TabOrder = 3
          end
          object chkAllFree: TSpTBXCheckBox
            Left = 13
            Top = 64
            Width = 60
            Height = 21
            Caption = 'All Free'
            ParentColor = True
            TabOrder = 2
          end
          object chkInstantBuild: TSpTBXCheckBox
            Left = 13
            Top = 43
            Width = 84
            Height = 21
            Caption = 'Instant Build'
            ParentColor = True
            TabOrder = 1
          end
          object chkBuildStore: TSpTBXCheckBox
            Left = 13
            Top = 22
            Width = 114
            Height = 21
            Caption = 'Build Custom Store'
            ParentColor = True
            TabOrder = 0
          end
        end
      end
    end
    object PanProject: TLMDDockPanel
      Left = 6
      Top = 6
      Width = 150
      Height = 630
      ParentBackground = False
      TabOrder = 4
      Caption = 'Project'
    end
    object PanResources: TLMDDockPanel
      Left = 6
      Top = 6
      Width = 150
      Height = 630
      ParentBackground = False
      TabOrder = 9
      Caption = 'Resources'
      object PanFilterResources: TPanel
        Left = 0
        Top = 21
        Width = 150
        Height = 22
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
      end
    end
    object PanSbtp: TLMDDockPanel
      Left = 162
      Top = 27
      Width = 551
      Height = 629
      Buttons = [pbPin, pbMaximize, pbClose]
      ParentBackground = False
      TabOrder = 6
      Caption = 'Sbtp File'
    end
    object PanTreeView: TLMDDockPanel
      Left = 6
      Top = 6
      Width = 150
      Height = 630
      Buttons = [pbPin, pbMaximize, pbClose]
      ParentBackground = False
      TabOrder = 5
      Caption = 'DLC Server'
      object PanFilter: TPanel
        Left = 0
        Top = 21
        Width = 150
        Height = 22
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
      end
    end
  end
  object dckMgr: TLMDDockManager
    StyleName = 'VS2012Dark'
    Left = 24
    Top = 144
  end
  object SciLangMgr: TSciLanguageManager
    LanguageList = <
      item
        Name = 'null'
        Lexer = 'null'
        Styles = <
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clBlue
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '/*'
        CommentBoxEnd = '*/'
        CommentBoxMiddle = '*'
        CommentBlock = '//'
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 5
      end
      item
        Name = 'XML'
        Lexer = 'xml'
        Styles = <
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = 15000804
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGray
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Default'
            StyleNumber = 0
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlue
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Tags'
            StyleNumber = 1
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Unknown Tags'
            StyleNumber = 2
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Attributes'
            StyleNumber = 3
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Unknown Attributes'
            StyleNumber = 4
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 224
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Numbers'
            StyleNumber = 5
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = 16711808
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Double quoted strings'
            StyleNumber = 6
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = 16711808
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Single quoted strings'
            StyleNumber = 7
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Other inside tag'
            StyleNumber = 8
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clGreen
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Comment'
            StyleNumber = 9
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Entities'
            StyleNumber = 10
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clBlue
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'XML style tag ends'
            StyleNumber = 11
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'XML identifier start'
            StyleNumber = 12
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clYellow
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'XML identifier end'
            StyleNumber = 13
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            EOLFilled = True
            Name = 'CDATA'
            StyleNumber = 17
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 160
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'XML Question'
            StyleNumber = 18
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clFuchsia
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Unquoted values'
            StyleNumber = 19
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML tags <! ... >'
            StyleNumber = 21
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = 13684736
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML command'
            StyleNumber = 22
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 15793935
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML 1st param'
            StyleNumber = 23
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML double string'
            StyleNumber = 24
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clLime
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML single string'
            StyleNumber = 25
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clYellow
            BackColor = clMaroon
            CharCase = CASE_MIXED
            Name = 'SGML error'
            StyleNumber = 26
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 16737843
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML special'
            StyleNumber = 27
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clDefault
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML entity'
            StyleNumber = 28
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 9474192
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'SGML comment'
            StyleNumber = 29
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = 6684672
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'SGML block'
            StyleNumber = 31
          end>
        Keywords = <
          item
            KeywordListNumber = 0
            Name = 'Keywords'
            Keywords.CaseSensitive = False
          end
          item
            KeywordListNumber = 5
            Name = 'SGML Keywords'
            Keywords.CaseSensitive = False
            Keywords.Strings = (
              'ELEMENT'
              'DOCTYPE'
              'ATTLIST'
              'ENTITY'
              'NOTATION')
          end>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '<!--'
        CommentBoxEnd = '-->'
        CommentBoxMiddle = '*'
        CommentBlock = '//'
        CommentAtLineStart = True
        CommentStreamStart = '<!--'
        CommentStreamEnd = '-->'
        NumStyleBits = 7
      end
      item
        Name = 'container'
        Lexer = 'container'
        Styles = <
          item
            FontName = 'Arial'
            FontSize = 0
            FontStyles = []
            ForeColor = clBlack
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'LineNumbers'
            StyleNumber = 33
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clBlue
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Ok Braces'
            StyleNumber = 34
          end
          item
            FontSize = 0
            FontStyles = [fsBold]
            ForeColor = clRed
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Bad Braces'
            StyleNumber = 35
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clDefault
            BackColor = clSilver
            CharCase = CASE_MIXED
            Name = 'Control Chars'
            StyleNumber = 36
          end
          item
            FontSize = 0
            FontStyles = []
            ForeColor = clSilver
            BackColor = clDefault
            CharCase = CASE_MIXED
            Name = 'Indent Guide'
            StyleNumber = 37
          end>
        Keywords = <>
        AssignmentOperator = '='
        EndOfStatementOperator = ';'
        CommentBoxStart = '/*'
        CommentBoxEnd = '*/'
        CommentBoxMiddle = '*'
        CommentBlock = '//'
        CommentAtLineStart = True
        CommentStreamStart = '/*'
        CommentStreamEnd = '*/'
        NumStyleBits = 5
      end>
    Left = 24
    Top = 240
  end
  object actScintilla: TActionList
    Left = 24
    Top = 192
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
  object SpTBXBItemContainer1: TSpTBXBItemContainer
    Left = 56
    Top = 296
    object tbServerItems: TSpTBXSubmenuItem
      object tbSynch: TSpTBXItem
        Caption = 'Synchronize DlcIndex'
        Hint = 'Synchronize DlcIndex'
        ImageIndex = 87
        OnClick = tbSynchOldClick
      end
      object tbDownload: TSpTBXItem
        Caption = 'Download Files'
        Hint = 'Download selected files'
        ImageIndex = 17
        OnClick = tbDownloadOldClick
      end
    end
    object tbPopupMenuItems: TSpTBXSubmenuItem
      object tbSaveWorkSpace: TSpTBXItem
        Caption = 'Save Project'
        Enabled = False
        ImageIndex = 2
        OnClick = tbSaveWorkSpaceClick
      end
      object tbUnpackMod: TSpTBXItem
        Caption = 'Unpack Files'
        Hint = 'Unpack File'
        Enabled = False
        ImageIndex = 112
        OnClick = tbUnpackModOldClick
      end
      object tbPackMod: TSpTBXItem
        Caption = 'Pack Files'
        Hint = 'Pack File'
        Enabled = False
        ImageIndex = 113
        OnClick = tbPackModOldClick
      end
      object tbCreateMod: TSpTBXItem
        Caption = 'Create Mod'
        Hint = 'Create Mod'
        Enabled = False
        ImageIndex = 44
        OnClick = tbCreateModOldClick
      end
      object tbValidateXml: TSpTBXItem
        Caption = 'Validate XML'
        Hint = 'Validate XML'
        Enabled = False
        ImageIndex = 111
        OnClick = tbValidateXmlOldClick
      end
      object tbCreateMasterList: TSpTBXItem
        Caption = 'Create Masterlist'
        Hint = 'Create Masterlist'
        ImageIndex = 70
        OnClick = tbCreateMasterListClick
      end
      object tbBuildList: TSpTBXItem
        Caption = 'Build ReqLists'
        Hint = 'Build ReqLists'
        ImageIndex = 66
        Visible = False
        OnClick = tbBuildListClick
      end
    end
    object tbMiscItems: TSpTBXSubmenuItem
      object tbExtractRgb: TSpTBXItem
        Caption = 'Extract Rgb Files'
        Hint = 'Extract Rgb Files'
        ImageIndex = 104
        OnClick = tbExtractRgbOldClick
      end
    end
    object mnuIndexesItems: TSpTBXSubmenuItem
      object SpTBXItem5: TSpTBXItem
        Caption = 'Dah'
      end
      object SpTBXSeparatorItem3: TSpTBXSeparatorItem
      end
      object SpTBXItem4: TSpTBXItem
        Caption = 'Dah2'
      end
    end
    object popTVItems: TSpTBXSubmenuItem
      object popSelectMissingFiles: TSpTBXItem
        Caption = 'Select missing files'
        OnClick = popSelectMissingFilesClick
      end
      object SpTBXSeparatorItem10: TSpTBXSeparatorItem
      end
      object ExpandAll1: TSpTBXItem
        Caption = 'Expand All'
        OnClick = ExpandAll1Click
      end
      object CollapseAll1: TSpTBXItem
        Caption = 'Collapse All'
        OnClick = CollapseAll1Click
      end
      object SpTBXSeparatorItem11: TSpTBXSeparatorItem
      end
      object ExportasXML1: TSpTBXItem
        Caption = 'Export as XML'
        Visible = False
        OnClick = ExportasXML1Click
      end
    end
    object popTvRessourceItems: TSpTBXSubmenuItem
      object popExpandResources: TSpTBXItem
        Caption = 'Expand All'
        OnClick = popExpandResourcesClick
      end
      object popCollapseResources: TSpTBXItem
        Caption = 'Collapse All'
        OnClick = popCollapseResourcesClick
      end
    end
    object popTvWSProjectGroupItems: TSpTBXSubmenuItem
      object popAddNewProject: TSpTBXItem
        Caption = 'Add New Project...'
        OnClick = popAddNewProjectClick
      end
      object popAddExistingProject: TSpTBXItem
        Caption = 'Add Existing Project...'
        OnClick = popAddExistingProjectClick
      end
      object SpTBXSeparatorItem2: TSpTBXSeparatorItem
      end
      object popSaveProjectGroup: TSpTBXItem
        Caption = 'Save Project Group'
        OnClick = popSaveProjectGroupClick
      end
      object popSaveProjectGroupAs: TSpTBXItem
        Caption = 'Save Project Group As...'
        OnClick = popSaveProjectGroupAsClick
      end
      object popRenameProjectGroup: TSpTBXItem
        Caption = 'Rename'
        OnClick = popRenameProjectGroupClick
      end
      object SpTBXSeparatorItem13: TSpTBXSeparatorItem
      end
      object popExportHackConfig: TSpTBXItem
        Caption = 'Export Hack Config'
        OnClick = popExportHackConfigClick
      end
      object popBuildHackConfig: TSpTBXItem
        Caption = 'Build Hack Config'
        OnClick = popBuildHackConfigClick
      end
      object SpTBXSeparatorItem12: TSpTBXSeparatorItem
      end
      object popTvWSProjectGroupConfiguration: TSpTBXItem
        Caption = 'Configuration Manager...'
        OnClick = popTvWSProjectGroupConfigurationClick
      end
    end
    object popTvWSProjectItems: TSpTBXSubmenuItem
      object popTvWSRenameProject: TSpTBXItem
        Caption = 'Rename'
        OnClick = popTvWSRenameProjectClick
      end
      object popTvWSRemoveProject: TSpTBXItem
        Caption = 'Remove Project'
        OnClick = popTvWSRemoveProjectClick
      end
      object SpTBXSeparatorItem9: TSpTBXSeparatorItem
      end
      object popTvWSGenerateScripts: TSpTBXItem
        Caption = 'Generate Scripts'
        OnClick = popTvWSGenerateScriptsClick
      end
      object popTvWSApplyMod: TSpTBXItem
        Caption = 'Apply Mod'
        OnClick = popTvWSApplyModClick
<<<<<<< HEAD
=======
      end
      object popTvWSBuildMod: TSpTBXItem
        Caption = 'Build Mod'
        OnClick = popTvWSBuildModClick
>>>>>>> refs/remotes/origin/DevVersion
      end
      object popTvWSPackMod: TSpTBXItem
        Caption = 'Pack Mod'
        OnClick = popTvWSPackModClick
      end
      object popTvWSCleanProject: TSpTBXItem
        Caption = 'Clean'
        OnClick = popTvWSCleanProjectClick
      end
      object SpTBXSubmenuItem1: TSpTBXSubmenuItem
        Caption = 'From Here'
        object popTvWSApplyAllModFromHere: TSpTBXItem
          Caption = 'Apply All Mod From Here'
          OnClick = popTvWSApplyAllModFromHereClick
        end
        object popTvWSBuildAllModFromHere: TSpTBXItem
          Caption = 'Build All Mod From Here'
          OnClick = popTvWSBuildAllModFromHereClick
        end
        object PackAllModFromHere: TSpTBXItem
          Caption = 'Pack All Mod From Here'
          OnClick = PackAllModFromHereClick
        end
      end
      object SpTBXSeparatorItem6: TSpTBXSeparatorItem
      end
      object popTvWSProcessSooner: TSpTBXItem
        Caption = 'Process Sooner'
        OnClick = popTvWSProcessSoonerClick
      end
      object popTvWSProcessLater: TSpTBXItem
        Caption = 'Process Later'
        OnClick = popTvWSProcessLaterClick
      end
      object SpTBXSeparatorItem4: TSpTBXSeparatorItem
      end
      object popTvWSProjectConfiguration: TSpTBXItem
        Caption = 'Configuration Manager...'
        OnClick = popTvWSProjectConfigurationClick
      end
    end
    object popTvWSProjectSrcFolderItems: TSpTBXSubmenuItem
      object popAddFile: TSpTBXItem
        Caption = 'Add...'
        OnClick = popAddFileClick
      end
      object SpTBXSeparatorItem7: TSpTBXSeparatorItem
      end
      object popRemoveFile: TSpTBXItem
        Caption = 'Remove File...'
        OnClick = popRemoveFileClick
      end
    end
    object popTvWSItems: TSpTBXSubmenuItem
      object SpTBXTBGroupItem1: TSpTBXTBGroupItem
        LinkSubitems = popTvWSProjectGroupItems
      end
      object SpTBXSeparatorItem5: TSpTBXSeparatorItem
      end
      object SpTBXTBGroupItem2: TSpTBXTBGroupItem
        LinkSubitems = popTvWSProjectItems
      end
      object SpTBXSeparatorItem8: TSpTBXSeparatorItem
      end
      object SpTBXTBGroupItem3: TSpTBXTBGroupItem
        LinkSubitems = popTvWSProjectSrcFolderItems
      end
    end
  end
  object popTvWS: TSpTBXPopupMenu
    OnPopup = popTvWSPopup
    LinkSubitems = popTvWSItems
    Left = 88
    Top = 240
  end
  object popTV: TSpTBXPopupMenu
    OnPopup = popTVPopup
    LinkSubitems = popTVItems
    Left = 88
    Top = 192
  end
  object popTvResource: TSpTBXPopupMenu
    OnPopup = popTVPopup
    LinkSubitems = popTvRessourceItems
    Left = 88
    Top = 144
  end
  object popTvSTTemplate: TSpTBXPopupMenu
    OnPopup = popTvSTTemplatePopup
    Left = 199
    Top = 144
    object popTvSTTemplateNew: TSpTBXItem
      Caption = 'New'
      OnClick = popTvSTTemplateNewClick
    end
    object popTvSTTemplateDelete: TSpTBXItem
      Caption = 'Delete'
      OnClick = popTvSTTemplateDeleteClick
    end
  end
  object popTvSTVariables: TSpTBXPopupMenu
    OnPopup = popTvSTVariablesPopup
    Left = 199
    Top = 192
    object popTvSTVariablesNew: TSpTBXItem
      Caption = 'New'
      OnClick = popTvSTVariablesNewClick
    end
    object popTvSTVariablesDelete: TSpTBXItem
      Caption = 'Delete'
      OnClick = popTvSTVariablesDeleteClick
    end
  end
end
