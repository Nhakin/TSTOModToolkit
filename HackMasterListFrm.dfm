object FrmHackMasterList: TFrmHackMasterList
  Left = 0
  Top = 0
  Caption = 'Hack MasterList'
  ClientHeight = 556
  ClientWidth = 709
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
  object PanTreeView: TSpTBXExPanel
    Left = 0
    Top = 26
    Width = 201
    Height = 530
    Caption = 'PanTreeView'
    Align = alLeft
    TabOrder = 1
    Borders = False
    ExplicitHeight = 427
  end
  object SpTBXSplitter1: TSpTBXSplitter
    Left = 201
    Top = 26
    Height = 530
    Cursor = crSizeWE
    ExplicitHeight = 427
  end
  object PanData: TSpTBXExPanel
    Left = 206
    Top = 26
    Width = 503
    Height = 530
    Color = 2499877
    Align = alClient
    TabOrder = 3
    Borders = False
    ExplicitWidth = 456
    ExplicitHeight = 427
    object GrpPackage: TSpTBXGroupBox
      Left = 0
      Top = 81
      Width = 503
      Height = 103
      Caption = ' Package '
      Align = alTop
      ParentColor = True
      TabOrder = 1
      ExplicitWidth = 456
      object Label1: TSpTBXLabel
        Left = 10
        Top = 49
        Width = 49
        Height = 19
        Caption = 'Xml file : '
        ParentColor = True
      end
      object EditPackageXmlFile: TSpTBXEdit
        Left = 70
        Top = 48
        Width = 371
        Height = 21
        TabOrder = 2
        OnChange = EditPackageXmlFileChange
      end
      object chkPackageEnabled: TSpTBXCheckBox
        Left = 70
        Top = 71
        Width = 20
        Height = 28
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        TabOrder = 4
        OnClick = chkPackageEnabledClick
      end
      object SpTBXLabel1: TSpTBXLabel
        Left = 10
        Top = 75
        Width = 54
        Height = 19
        Caption = 'Enabled : '
        ParentColor = True
      end
      object CmbPackageType: TSpTBXComboBox
        Left = 70
        Top = 21
        Width = 145
        Height = 21
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 0
        OnChange = CmbPackageTypeChange
        Items.Strings = (
          'Building'
          'Character'
          'Consumable')
      end
      object SpTBXLabel2: TSpTBXLabel
        Left = 10
        Top = 22
        Width = 40
        Height = 19
        Caption = 'Type : '
        ParentColor = True
      end
    end
    object GrpCategory: TSpTBXGroupBox
      Left = 0
      Top = 0
      Width = 503
      Height = 81
      Caption = ' Category '
      Align = alTop
      ParentColor = True
      TabOrder = 0
      ExplicitWidth = 456
      object SpTBXLabel3: TSpTBXLabel
        Left = 10
        Top = 21
        Width = 40
        Height = 19
        Caption = 'Name :'
        ParentColor = True
      end
      object EditCategoryName: TSpTBXEdit
        Left = 70
        Top = 20
        Width = 371
        Height = 21
        TabOrder = 0
        OnChange = EditCategoryNameChange
      end
      object chkCategoryEnabled: TSpTBXCheckBox
        Left = 70
        Top = 43
        Width = 20
        Height = 28
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        TabOrder = 2
        OnClick = chkCategoryEnabledClick
      end
      object SpTBXLabel4: TSpTBXLabel
        Left = 10
        Top = 47
        Width = 54
        Height = 19
        Caption = 'Enabled : '
        ParentColor = True
      end
      object SpTBXLabel5: TSpTBXLabel
        Left = 114
        Top = 47
        Width = 66
        Height = 19
        Caption = 'Build store : '
        ParentColor = True
      end
      object chkCategoryBuildStore: TSpTBXCheckBox
        Left = 175
        Top = 43
        Width = 20
        Height = 28
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        TabOrder = 3
        OnClick = chkCategoryBuildStoreClick
      end
    end
    object GrpItem: TSpTBXGroupBox
      Left = 0
      Top = 184
      Width = 503
      Height = 346
      Caption = ' Item '
      Align = alClient
      ParentColor = True
      TabOrder = 2
      ExplicitWidth = 456
      ExplicitHeight = 243
      object EditXmlData: TScintillaNPP
        AlignWithMargins = True
        Left = 5
        Top = 177
        Width = 493
        Height = 164
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
        ExplicitLeft = 21
        ExplicitTop = 213
        ExplicitWidth = 446
        ExplicitHeight = 129
      end
      object SpTBXExPanel1: TSpTBXExPanel
        Left = 2
        Top = 15
        Width = 499
        Height = 159
        Caption = 'SpTBXExPanel1'
        Align = alTop
        ParentColor = True
        TabOrder = 0
        Borders = False
        object SpTBXLabel7: TSpTBXLabel
          Left = 10
          Top = 115
          Width = 54
          Height = 19
          Caption = 'Enabled : '
          ParentColor = True
        end
        object chkItemAddInStore: TSpTBXCheckBox
          Left = 70
          Top = 111
          Width = 20
          Height = 28
          BiDiMode = bdLeftToRight
          ParentBiDiMode = False
          TabOrder = 8
          OnClick = chkItemAddInStoreClick
        end
        object SpTBXLabel8: TSpTBXLabel
          Left = 114
          Top = 115
          Width = 58
          Height = 19
          Caption = 'Override : '
          ParentColor = True
        end
        object chkItemOverRide: TSpTBXCheckBox
          Left = 175
          Top = 111
          Width = 20
          Height = 28
          BiDiMode = bdLeftToRight
          ParentBiDiMode = False
          TabOrder = 9
          OnClick = chkItemOverRideClick
        end
        object EditItemName: TSpTBXEdit
          Left = 70
          Top = 38
          Width = 371
          Height = 21
          TabOrder = 2
          OnChange = EditItemNameChange
        end
        object EditItemId: TSpTBXEdit
          Left = 70
          Top = 12
          Width = 371
          Height = 21
          TabOrder = 0
          OnChange = EditItemIdChange
        end
        object SpTBXLabel9: TSpTBXLabel
          Left = 10
          Top = 13
          Width = 26
          Height = 19
          Caption = 'Id : '
          ParentColor = True
        end
        object SpTBXLabel6: TSpTBXLabel
          Left = 10
          Top = 39
          Width = 40
          Height = 19
          Caption = 'Name :'
          ParentColor = True
        end
        object SpTBXLabel10: TSpTBXLabel
          Left = 10
          Top = 137
          Width = 45
          Height = 19
          Caption = 'XmlData'
          ParentColor = True
        end
        object EditItemType: TSpTBXEdit
          Left = 70
          Top = 65
          Width = 371
          Height = 21
          TabOrder = 4
          OnChange = EditItemTypeChange
        end
        object SpTBXLabel11: TSpTBXLabel
          Left = 10
          Top = 67
          Width = 37
          Height = 19
          Caption = 'Type :'
          ParentColor = True
        end
        object SpTBXLabel12: TSpTBXLabel
          Left = 10
          Top = 94
          Width = 67
          Height = 19
          Caption = 'Skin Object :'
          ParentColor = True
        end
        object EditItemSkinObject: TSpTBXEdit
          Left = 70
          Top = 92
          Width = 371
          Height = 21
          TabOrder = 6
          OnChange = EditItemSkinObjectChange
        end
      end
    end
  end
  object sptbxDckMain: TSpTBXDock
    Left = 0
    Top = 0
    Width = 709
    Height = 26
    AllowDrag = False
    ExplicitWidth = 662
    object sptbxtbMain: TSpTBXToolbar
      Left = 0
      Top = 0
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
      TabOrder = 0
      Caption = 'sptbxtbMain'
      Customizable = False
      MenuBar = True
      object tbMainPopup: TSpTBXTBGroupItem
        LinkSubitems = tbPopupMenuItems
      end
    end
  end
  object SpTBXBItemContainer1: TSpTBXBItemContainer
    Left = 56
    Top = 296
    object tbPopupMenuItems: TSpTBXSubmenuItem
      object tbSaveHackMasterList: TSpTBXItem
        Caption = 'Save Hack MasterList'
        Enabled = False
        ImageIndex = 2
        OnClick = tbSaveHackMasterListClick
      end
    end
  end
end
