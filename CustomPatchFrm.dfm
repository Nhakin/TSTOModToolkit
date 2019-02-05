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
    object EditXml: TSynEdit
      Left = 0
      Top = 227
      Width = 548
      Height = 213
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      TabOrder = 1
      Gutter.Font.Charset = DEFAULT_CHARSET
      Gutter.Font.Color = clWindowText
      Gutter.Font.Height = -11
      Gutter.Font.Name = 'Courier New'
      Gutter.Font.Style = []
      Highlighter = SynXMLSyn1
      ReadOnly = True
      FontSmoothing = fsmNone
    end
    object vstPatchData: TSpTBXVirtualStringTree
      AlignWithMargins = True
      Left = 3
      Top = 124
      Width = 542
      Height = 100
      Version = '6.2.5.918'
      Align = alTop
      Header.AutoSizeIndex = 2
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoOwnerDraw, hoShowSortGlyphs, hoVisible]
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
      TabOrder = 2
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
        TabOrder = 0
      end
      object EditPatchDesc: TEdit
        Left = 71
        Top = 50
        Width = 460
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 1
      end
      object EditPatchFileName: TEdit
        Left = 71
        Top = 75
        Width = 460
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 2
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
      FullSize = True
      Images = DataModuleImage.imgToolBar
      ProcessShortCuts = True
      ShrinkMode = tbsmWrap
      TabOrder = 0
      Caption = 'tbMainV2'
      Customizable = False
      MenuBar = True
      object tbSave: TSpTBXItem
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
  object popVSTCustomPatches: TPopupMenu
    Left = 64
    Top = 68
    object popAdd: TMenuItem
      Caption = 'Add'
      OnClick = popAddClick
    end
    object popDelete: TMenuItem
      Caption = 'Delete'
    end
  end
  object SynXMLSyn1: TSynXMLSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    WantBracesParsed = False
    Left = 63
    Top = 123
  end
end
