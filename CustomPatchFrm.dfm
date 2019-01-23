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
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object SplitterV1: TSplitter
    Left = 205
    Top = 56
    Height = 438
    ExplicitLeft = 210
    ExplicitTop = 35
    ExplicitHeight = 329
  end
  object PanInfo: TPanel
    Left = 208
    Top = 56
    Width = 545
    Height = 438
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object gbPatchInfoV1: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 539
      Height = 114
      Align = alTop
      Caption = ' Patch Info '
      TabOrder = 0
      DesignSize = (
        539
        114)
      object lblPatchDesc: TLabel
        Left = 9
        Top = 58
        Width = 53
        Height = 13
        Caption = 'Description'
      end
      object lblPatchName: TLabel
        Left = 9
        Top = 31
        Width = 27
        Height = 13
        Caption = 'Name'
      end
      object lblPatchFileName: TLabel
        Left = 9
        Top = 83
        Width = 43
        Height = 13
        Caption = 'FileName'
      end
      object EditPatchName: TEdit
        Left = 70
        Top = 27
        Width = 457
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
      end
      object EditPatchDesc: TEdit
        Left = 70
        Top = 54
        Width = 457
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 1
      end
      object EditPatchFileName: TEdit
        Left = 70
        Top = 79
        Width = 457
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 2
      end
    end
    object tsXmlV1: TTabSet
      AlignWithMargins = True
      Left = 3
      Top = 386
      Width = 539
      Height = 21
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Tabs.Strings = (
        'Input'
        'XPath Result'
        'Output')
      TabIndex = 0
      OnChange = tsXmlV1Change
    end
    object EditXml: TSynEdit
      Left = 0
      Top = 347
      Width = 545
      Height = 36
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      TabOrder = 2
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
      Top = 244
      Width = 539
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
      TabOrder = 1
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
          Width = 287
          WideText = 'Code'
        end>
    end
    object gbPatchInfoV2: TSpTBXGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 123
      Width = 539
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
      TabOrder = 4
    end
    object tsXmlV2: TSpTBXTabSet
      Left = 0
      Top = 410
      Width = 545
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
  object panToolBar: TPanel
    Left = 0
    Top = 0
    Width = 753
    Height = 30
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object tbMain: TToolBar
      Left = 0
      Top = 0
      Width = 753
      Height = 29
      ButtonHeight = 25
      ButtonWidth = 25
      EdgeBorders = [ebLeft, ebTop, ebRight, ebBottom]
      Images = DataModuleImage.imgToolBar
      TabOrder = 0
      object tbSaveOld: TToolButton
        Left = 0
        Top = 0
        Caption = 'tbSaveOld'
        ImageIndex = 2
        OnClick = tbSaveOldClick
      end
    end
  end
  object PanTreeView: TPanel
    Left = 0
    Top = 56
    Width = 200
    Height = 438
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 2
    object vstCustomPacthes: TSpTBXVirtualStringTree
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 194
      Height = 432
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
    Top = 30
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
    Top = 56
    Height = 438
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
