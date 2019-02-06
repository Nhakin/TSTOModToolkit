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
  OnActivate = FormActivate
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
          Visible = False
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
      5A223E0D0A0909093C7A6F6E65206B696E643D2250414E454C222069643D2250
      616E5472656556696577222076697369626C653D2231222073697A653D223135
      3022206473697A653D22302E323135383237333338313239343936222F3E0D0A
      0909093C7A6F6E65206B696E643D2256455254222073697A653D223337382220
      6473697A653D22302E353433383834383932303836333331223E0D0A09090909
      3C7A6F6E65206B696E643D2250414E454C222069643D2250616E46696C65496E
      666F222076697369626C653D2231222073697A653D2231323022206473697A65
      3D22302E313836333335343033373236373038222F3E0D0A090909093C7A6F6E
      65206B696E643D225441425322206163746976657461623D2230222073697A65
      3D2235323422206473697A653D22302E38313336363435393632373332393222
      20697373706163653D2231223E0D0A09090909093C7A6F6E65206B696E643D22
      50414E454C222069643D2250616E496E666F222076697369626C653D2231222F
      3E0D0A09090909093C7A6F6E65206B696E643D2250414E454C222069643D2250
      616E496D616765222076697369626C653D2231222F3E0D0A09090909093C7A6F
      6E65206B696E643D2250414E454C222069643D2250616E536274702220766973
      69626C653D2231222F3E0D0A09090909093C7A6F6E65206B696E643D2250414E
      454C222069643D2250616E48657845646974222076697369626C653D2231222F
      3E0D0A09090909093C7A6F6E65206B696E643D2250414E454C222069643D2250
      616E4861636B54656D706C6174654D6173746572222076697369626C653D2231
      222F3E0D0A090909093C2F7A6F6E653E0D0A0909093C2F7A6F6E653E0D0A0909
      093C7A6F6E65206B696E643D2256455254222073697A653D2231363722206473
      697A653D22302E323430323837373639373834313733223E0D0A090909093C7A
      6F6E65206B696E643D225441425322206163746976657461623D223022207369
      7A653D2233323522206473697A653D22302E3530343635383338353039333136
      38223E0D0A09090909093C7A6F6E65206B696E643D2250414E454C222069643D
      2250616E50726F6A656374222076697369626C653D2231222F3E0D0A09090909
      093C7A6F6E65206B696E643D2250414E454C222069643D2250616E5265736F75
      72636573222076697369626C653D2231222F3E0D0A090909093C2F7A6F6E653E
      0D0A090909093C7A6F6E65206B696E643D225441425322206163746976657461
      623D2230222073697A653D2233313922206473697A653D22302E343935333431
      363134393036383332223E0D0A09090909093C7A6F6E65206B696E643D225041
      4E454C222069643D2250616E4D6F644F7074696F6E73222076697369626C653D
      2231222F3E0D0A09090909093C7A6F6E65206B696E643D2250414E454C222069
      643D2250616E437573746F6D4D6F64222076697369626C653D2231222F3E0D0A
      090909093C2F7A6F6E653E0D0A0909093C2F7A6F6E653E0D0A09093C2F7A6F6E
      653E0D0A093C2F736974653E0D0A3C2F736974656C6973743E}
    object PanCustomMod: TLMDDockPanel
      Left = 546
      Top = 337
      Width = 167
      Height = 299
      Buttons = [pbPin, pbMaximize, pbClose]
      ParentBackground = False
      TabOrder = 11
      Caption = 'Custom Mod'
    end
    object PanFileInfo: TLMDDockPanel
      Left = 162
      Top = 6
      Width = 378
      Height = 120
      Buttons = [pbPin, pbMaximize, pbClose]
      ParentBackground = False
      TabOrder = 13
      Caption = 'File Info'
      DesignSize = (
        378
        120)
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
        TabOrder = 0
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
        TabOrder = 1
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
        TabOrder = 4
      end
      object EditFileName: TEdit
        Left = 70
        Top = 29
        Width = 284
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
        TabOrder = 5
        ExplicitWidth = 457
      end
    end
    object PanHackTemplateMaster: TLMDDockPanel
      Left = 162
      Top = 153
      Width = 378
      Height = 503
      ParentBackground = False
      TabOrder = 10
      Caption = 'Script Template'
      object dckScriptTemplate: TLMDDockSite
        Left = 0
        Top = 0
        Width = 378
        Height = 503
        Manager = dckMgr
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 389
        ExplicitHeight = 629
        Layout = {
          EFBBBF3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D
          227574662D38223F3E0D0A3C736974656C6973743E0D0A093C73697465206964
          3D2253454C465F53495445223E0D0A09093C7A6F6E65206B696E643D22564552
          54223E0D0A0909093C7A6F6E65206B696E643D22484F525A222073697A653D22
          31323722206473697A653D22302E323631383535363730313033303933223E0D
          0A090909093C7A6F6E65206B696E643D2250414E454C222069643D2250616E54
          764861636B54656D706C617465222076697369626C653D2231222073697A653D
          2231373522206473697A653D22302E343836363331303136303432373831222F
          3E0D0A090909093C7A6F6E65206B696E643D2254414253222061637469766574
          61623D2230222073697A653D2231383522206473697A653D22302E3531333336
          38393833393537323139223E0D0A09090909093C7A6F6E65206B696E643D2250
          414E454C222069643D2250616E53545661726961626C6573222076697369626C
          653D2231222F3E0D0A09090909093C7A6F6E65206B696E643D2250414E454C22
          2069643D2250616E535453657474696E6773222076697369626C653D2231222F
          3E0D0A090909093C2F7A6F6E653E0D0A0909093C2F7A6F6E653E0D0A0909093C
          7A6F6E65206B696E643D225441425322206163746976657461623D2230222073
          697A653D2233353822206473697A653D22302E37333831343433323938393639
          30372220697373706163653D2231223E0D0A090909093C7A6F6E65206B696E64
          3D2250414E454C222069643D2250616E4861636B54656D706C61746522207669
          7369626C653D2231222F3E0D0A0909093C2F7A6F6E653E0D0A09093C2F7A6F6E
          653E0D0A093C2F736974653E0D0A3C2F736974656C6973743E}
        object PanHackTemplate: TLMDDockPanel
          Left = 6
          Top = 160
          Width = 366
          Height = 337
          ParentBackground = False
          TabOrder = 5
          Caption = 'Template Source'
          object EditScriptTemplate: TScintillaNPP
            Left = 0
            Top = 0
            Width = 366
            Height = 309
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
            Top = 309
            Width = 366
            Height = 28
            Align = alBottom
            ActiveTabIndex = 0
            TabPosition = ttpBottom
            OnActiveTabChange = tsScriptTemplateActiveTabChange
            ExplicitTop = 568
            ExplicitWidth = 164
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
          Left = 187
          Top = 6
          Width = 185
          Height = 107
          ParentBackground = False
          TabOrder = 7
          Caption = 'Settings'
        end
        object PanSTVariables: TLMDDockPanel
          Left = 187
          Top = 6
          Width = 185
          Height = 107
          ParentBackground = False
          TabOrder = 6
          Caption = 'Variables'
        end
        object PanTvHackTemplate: TLMDDockPanel
          Left = 6
          Top = 6
          Width = 175
          Height = 127
          Buttons = [pbPin, pbMaximize, pbClose]
          ParentBackground = False
          TabOrder = 4
          Caption = 'Templates'
        end
      end
    end
    object PanHexEdit: TLMDDockPanel
      Left = 162
      Top = 153
      Width = 378
      Height = 503
      Buttons = [pbPin, pbMaximize, pbClose]
      ParentBackground = False
      TabOrder = 7
      Caption = 'Hex Editor'
      OnEnter = PanImageOldEnter
      object KHexEditor: TKHexEditor
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 372
        Height = 497
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Courier New'
        Font.Pitch = fpFixed
        Font.Style = [fsBold]
        TabOrder = 0
        ExplicitWidth = 383
        ExplicitHeight = 623
      end
    end
    object PanImage: TLMDDockPanel
      Left = 162
      Top = 153
      Width = 378
      Height = 503
      ParentBackground = False
      TabOrder = 14
      Caption = 'Image'
      object PanSize: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 372
        Height = 30
        Align = alTop
        BevelOuter = bvLowered
        ParentColor = True
        TabOrder = 0
        ExplicitLeft = 6
        ExplicitTop = 11
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
      object ScrlImage: TScrollBox
        AlignWithMargins = True
        Left = 3
        Top = 39
        Width = 372
        Height = 461
        Align = alClient
        BevelEdges = []
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        TabOrder = 1
        OnEnter = PanImageOldEnter
        ExplicitTop = 60
        ExplicitWidth = 533
        ExplicitHeight = 179
        object ImgResource: TImage
          Left = 0
          Top = 0
          Width = 94
          Height = 74
          AutoSize = True
        end
      end
    end
    object PanInfo: TLMDDockPanel
      Left = 162
      Top = 153
      Width = 378
      Height = 503
      Buttons = [pbMenu, pbPin, pbMaximize]
      ParentBackground = False
      TabOrder = 8
      Caption = 'XML Editor'
      object dckInfo: TLMDDockSite
        Left = 0
        Top = 0
        Width = 378
        Height = 503
        Manager = dckMgr
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 551
        ExplicitHeight = 629
        Layout = {
          EFBBBF3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D
          227574662D38223F3E0D0A3C736974656C6973743E0D0A093C73697465206964
          3D2253454C465F53495445223E0D0A09093C7A6F6E65206B696E643D22484F52
          5A223E0D0A0909093C7A6F6E65206B696E643D2250414E454C222069643D224C
          4D44446F636B50616E656C31222076697369626C653D2230222073697A653D22
          333222206473697A653D22302E30363030333735323334353231353736222F3E
          0D0A0909093C7A6F6E65206B696E643D2250414E454C222073697A653D223336
          3622206473697A653D22312220697373706163653D2231222F3E0D0A09093C2F
          7A6F6E653E0D0A093C2F736974653E0D0A3C2F736974656C6973743E}
        object LMDDockPanel1: TLMDDockPanel
          Left = 6
          Top = 121
          Width = 32
          Height = 254
          PanelVisible = False
          ParentBackground = False
          TabOrder = 4
          Caption = 'LMDDockPanel1'
        end
      end
    end
    object PanModOptions: TLMDDockPanel
      Left = 546
      Top = 337
      Width = 167
      Height = 299
      Buttons = [pbPin, pbMaximize, pbClose]
      ParentBackground = False
      TabOrder = 12
      Caption = 'Mod Options'
      object chkUnlimitedTime: TSpTBXCheckBox
        Left = 21
        Top = 135
        Width = 92
        Height = 21
        Caption = 'Unlimited Time'
        ParentColor = True
        TabOrder = 0
      end
      object chkFreeLandUpgade: TSpTBXCheckBox
        Left = 21
        Top = 114
        Width = 116
        Height = 21
        Caption = 'Free Land Upgrade'
        ParentColor = True
        TabOrder = 1
      end
      object chkNonUnique: TSpTBXCheckBox
        Left = 21
        Top = 93
        Width = 78
        Height = 21
        Caption = 'Non unique'
        ParentColor = True
        TabOrder = 2
      end
      object chkAllFree: TSpTBXCheckBox
        Left = 21
        Top = 72
        Width = 60
        Height = 21
        Caption = 'All Free'
        ParentColor = True
        TabOrder = 3
      end
      object chkInstantBuild: TSpTBXCheckBox
        Left = 21
        Top = 51
        Width = 84
        Height = 21
        Caption = 'Instant Build'
        ParentColor = True
        TabOrder = 4
      end
      object chkBuildStore: TSpTBXCheckBox
        Left = 21
        Top = 30
        Width = 114
        Height = 21
        Caption = 'Build Custom Store'
        ParentColor = True
        TabOrder = 5
      end
    end
    object PanProject: TLMDDockPanel
      Left = 546
      Top = 6
      Width = 167
      Height = 305
      Buttons = [pbPin, pbMaximize, pbClose]
      ParentBackground = False
      TabOrder = 4
      Caption = 'Project'
    end
    object PanResources: TLMDDockPanel
      Left = 546
      Top = 6
      Width = 167
      Height = 305
      Buttons = [pbPin, pbMaximize, pbClose]
      ParentBackground = False
      TabOrder = 9
      Caption = 'Resources'
      object PanFilterResources: TPanel
        Left = 0
        Top = 21
        Width = 167
        Height = 22
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitWidth = 150
      end
    end
    object PanSbtp: TLMDDockPanel
      Left = 162
      Top = 153
      Width = 378
      Height = 503
      Buttons = [pbPin, pbMaximize, pbClose]
      ParentBackground = False
      TabOrder = 6
      Caption = 'Sbtp File'
    end
    object PanTreeView: TLMDDockPanel
      Left = 6
      Top = 6
      Width = 150
      Height = 650
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
      object tbCreateMasterList: TSpTBXSubmenuItem
        Caption = 'HackMasterlist'
        ImageIndex = 70
        OnClick = tbCreateMasterListClick
        DropdownCombo = True
        HideEmptyPopup = True
        object popNewHackMasterList: TSpTBXItem
          Caption = 'New HackMasterlist'
          OnClick = tbCreateMasterListClick
        end
        object popDiffHackMasterList: TSpTBXItem
          Caption = 'Diff HackMasterlist'
          OnClick = popDiffHackMasterListClick
        end
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
      object popCompareHackMasterList: TSpTBXItem
        Caption = 'Compare HackMaster List'
        OnClick = popCompareHackMasterListClick
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
      end
      object popTvWSBuildMod: TSpTBXItem
        Caption = 'Build Mod'
        OnClick = popTvWSBuildModClick
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
