object DlcDownload: TDlcDownload
  Left = 98
  Top = 0
  Caption = 'TSTO ModToolKit'
  ClientHeight = 622
  ClientWidth = 719
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 286
    Top = 32
    Height = 590
    ExplicitLeft = 212
    ExplicitTop = 30
    ExplicitHeight = 509
  end
  object PanXml: TPanel
    Left = 289
    Top = 32
    Width = 430
    Height = 590
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    Visible = False
    object EditXML: TSynEdit
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 424
      Height = 584
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      TabOrder = 0
      Gutter.Font.Charset = DEFAULT_CHARSET
      Gutter.Font.Color = clWindowText
      Gutter.Font.Height = -11
      Gutter.Font.Name = 'Courier New'
      Gutter.Font.Style = []
      Gutter.LeadingZeros = True
      Gutter.ShowLineNumbers = True
      Highlighter = SynXMLSyn1
      ReadOnly = True
      FontSmoothing = fsmNone
    end
  end
  object PanSbtp: TPanel
    Left = 289
    Top = 32
    Width = 430
    Height = 590
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 5
    Visible = False
    object PansbtpTreeView: TPanel
      Left = 0
      Top = 0
      Width = 430
      Height = 590
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
    end
  end
  object PanHexEdit: TPanel
    Left = 289
    Top = 32
    Width = 430
    Height = 590
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 4
    object KHexEditor: TKHexEditor
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 424
      Height = 584
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
  object PanInfo: TPanel
    Left = 289
    Top = 32
    Width = 430
    Height = 590
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object GroupBox1: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 424
      Height = 114
      Align = alTop
      Caption = ' File Info '
      TabOrder = 0
      DesignSize = (
        424
        114)
      object Label1: TLabel
        Left = 12
        Top = 58
        Width = 40
        Height = 13
        Caption = 'Platform'
      end
      object Label2: TLabel
        Left = 137
        Top = 58
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
      object Label4: TLabel
        Left = 137
        Top = 83
        Width = 35
        Height = 13
        Caption = 'Version'
      end
      object Label5: TLabel
        Left = 12
        Top = 33
        Width = 43
        Height = 13
        Caption = 'FileName'
      end
      object Label6: TLabel
        Left = 241
        Top = 83
        Width = 47
        Height = 13
        Caption = 'Language'
      end
      object Label8: TLabel
        Left = 241
        Top = 58
        Width = 19
        Height = 13
        Caption = 'Size'
      end
      object EditFileName: TEdit
        Left = 70
        Top = 29
        Width = 343
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 0
      end
      object EditVersion: TEdit
        Left = 181
        Top = 79
        Width = 34
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 4
      end
      object EditTier: TEdit
        Left = 181
        Top = 54
        Width = 57
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 2
      end
      object EditMinVersion: TEdit
        Left = 70
        Top = 79
        Width = 57
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 3
      end
      object EditPlatform: TEdit
        Left = 70
        Top = 54
        Width = 57
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 1
      end
      object EditLanguage: TEdit
        Left = 298
        Top = 79
        Width = 34
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 5
      end
      object EditFileSize: TEdit
        Left = 298
        Top = 54
        Width = 87
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 6
      end
    end
    object PanImage: TPanel
      Left = 0
      Top = 274
      Width = 430
      Height = 316
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      Visible = False
      object ScrlImage: TScrollBox
        AlignWithMargins = True
        Left = 3
        Top = 39
        Width = 424
        Height = 274
        Align = alClient
        BevelEdges = []
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        TabOrder = 0
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
        Top = 3
        Width = 424
        Height = 30
        Align = alTop
        BevelOuter = bvLowered
        TabOrder = 1
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
          ReadOnly = True
          TabOrder = 0
        end
      end
    end
    object PanModOptions: TPanel
      Left = 0
      Top = 120
      Width = 430
      Height = 154
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      object Splitter3: TSplitter
        Left = 185
        Top = 0
        Height = 154
        ExplicitLeft = 222
        ExplicitTop = 43
        ExplicitHeight = 100
      end
      object PanModLeft: TPanel
        Left = 0
        Top = 0
        Width = 185
        Height = 154
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 0
        object GroupBox2: TGroupBox
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 179
          Height = 148
          Align = alClient
          Caption = ' Mod Options '
          TabOrder = 0
          object Animate1: TAnimate
            Left = 28
            Top = 37
            Width = 94
            Height = 74
            StopFrame = 23
            Visible = False
          end
          object chkAllFree: TCheckBox
            Left = 11
            Top = 60
            Width = 135
            Height = 17
            Caption = 'All Free'
            Checked = True
            State = cbChecked
            TabOrder = 0
          end
          object chkNonUnique: TCheckBox
            Left = 11
            Top = 81
            Width = 135
            Height = 17
            Caption = 'Non unique'
            Checked = True
            State = cbChecked
            TabOrder = 1
          end
          object chkBuildStore: TCheckBox
            Left = 11
            Top = 18
            Width = 135
            Height = 17
            Caption = 'Build Custom Store'
            TabOrder = 2
          end
          object chkInstantBuild: TCheckBox
            Left = 11
            Top = 39
            Width = 135
            Height = 17
            Caption = 'Instant Build'
            Checked = True
            State = cbChecked
            TabOrder = 3
          end
          object chkFreeLandUpgade: TCheckBox
            Left = 11
            Top = 102
            Width = 135
            Height = 17
            Caption = 'Free Land Upgrade'
            Checked = True
            State = cbChecked
            TabOrder = 4
          end
          object chkUnlimitedTime: TCheckBox
            Left = 11
            Top = 123
            Width = 135
            Height = 17
            Caption = 'Unlimited Time'
            Checked = True
            State = cbChecked
            TabOrder = 5
          end
        end
      end
      object PanModRight: TPanel
        Left = 188
        Top = 0
        Width = 242
        Height = 154
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object vstCustomPatchesOld: TVirtualStringTree
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 236
          Height = 148
          Version = '6.2.5.918'
          Align = alClient
          Header.AutoSizeIndex = 1
          Header.Font.Charset = DEFAULT_CHARSET
          Header.Font.Color = clWindowText
          Header.Font.Height = -11
          Header.Font.Name = 'Tahoma'
          Header.Font.Style = []
          Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoShowSortGlyphs, hoVisible]
          TabOrder = 0
          TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning, toEditOnClick]
          TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
          TreeOptions.SelectionOptions = [toFullRowSelect]
          Visible = False
          Columns = <
            item
              Position = 0
              Width = 90
              WideText = 'Name'
            end
            item
              Position = 1
              Width = 146
              WideText = 'Description'
            end>
        end
      end
    end
  end
  object PanToolBar: TPanel
    Left = 0
    Top = 0
    Width = 719
    Height = 32
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object tbMain: TToolBar
      Left = 0
      Top = 0
      Width = 719
      Height = 31
      EdgeBorders = [ebLeft, ebTop, ebRight, ebBottom]
      Images = DataModuleImage.imgToolBar
      TabOrder = 0
      OnMouseDown = tbMainMouseDown
      object tbSynch: TToolButton
        Left = 0
        Top = 0
        Hint = 'Synchronize DlcIndex'
        Caption = 'tbSynch'
        ImageIndex = 87
        ParentShowHint = False
        ShowHint = True
        OnClick = tbSynchClick
      end
      object tbDownload: TToolButton
        Left = 23
        Top = 0
        Hint = 'Download selected files'
        Caption = 'tbDownload'
        ImageIndex = 17
        ParentShowHint = False
        ShowHint = True
        OnClick = tbDownloadClick
      end
      object tbUnpackMod: TToolButton
        Left = 46
        Top = 0
        Hint = 'Unpack File'
        Caption = 'tbUnpackMod'
        Enabled = False
        ImageIndex = 112
        ParentShowHint = False
        ShowHint = True
        OnClick = tbUnpackModClick
      end
      object tbPackMod: TToolButton
        Left = 69
        Top = 0
        Hint = 'Pack File'
        Caption = 'tbPackMod'
        Enabled = False
        ImageIndex = 113
        ParentShowHint = False
        ShowHint = True
        OnClick = tbPackModClick
      end
      object tbCreateMod: TToolButton
        Left = 92
        Top = 0
        Hint = 'Create Mod'
        Caption = 'tbCreateMod'
        Enabled = False
        ImageIndex = 44
        ParentShowHint = False
        ShowHint = True
        OnClick = tbCreateModClick
      end
      object tbCreateMasterList: TToolButton
        Left = 115
        Top = 0
        Hint = 'Create Masterlist'
        ImageIndex = 70
        OnClick = tbCreateMasterListClick
      end
      object tbBuildList: TToolButton
        Left = 138
        Top = 0
        Hint = 'Build ReqLists'
        ImageIndex = 66
        OnClick = tbBuildListClick
      end
      object tbValidateXml: TToolButton
        Left = 161
        Top = 0
        Caption = 'tbValidateXml'
        Enabled = False
        ImageIndex = 111
        ParentShowHint = False
        ShowHint = True
        OnClick = tbValidateXmlClick
      end
      object tbExtractRgb: TToolButton
        Left = 184
        Top = 0
        Hint = 'Extract Rgb Files'
        Caption = 'tbExtractRgb'
        ImageIndex = 104
        ParentShowHint = False
        ShowHint = True
        OnClick = tbExtractRgbClick
      end
      object ToolButton1: TToolButton
        Left = 207
        Top = 0
        Caption = 'ToolButton1'
        ImageIndex = 105
        OnClick = ToolButton1Click
      end
      object ToolButton2: TToolButton
        Left = 230
        Top = 0
        Caption = 'ToolButton2'
        ImageIndex = 106
        OnClick = ToolButton2Click
      end
      object PanFilter: TPanel
        Left = 253
        Top = 0
        Width = 185
        Height = 22
        BevelOuter = bvNone
        TabOrder = 0
      end
    end
  end
  object PanTreeView: TPanel
    Left = 0
    Top = 32
    Width = 286
    Height = 590
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 3
  end
  object MainMenu1: TMainMenu
    Left = 109
    Top = 289
    object mnuFile: TMenuItem
      Caption = '&File'
      object mnuSettings: TMenuItem
        Caption = '&Settings'
        OnClick = mnuSettingsClick
      end
      object mnuCustomPatch: TMenuItem
        Caption = 'Custom Patch'
        OnClick = mnuCustomPatchClick
      end
      object mnuSbtpCustomPatch: TMenuItem
        Caption = 'Sbtp Custom Patch'
        OnClick = mnuSbtpCustomPatchClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object mnuExit: TMenuItem
        Caption = '&Exit'
        OnClick = mnuExitClick
      end
    end
    object mnuTools: TMenuItem
      Caption = 'Tools'
      object mnuDownloadAllIndexes: TMenuItem
        Caption = 'Download all indexes'
        OnClick = mnuDownloadAllIndexesClick
      end
      object mnuIndexes: TMenuItem
        Caption = 'Indexes'
      end
    end
  end
  object SynXMLSyn1: TSynXMLSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    WantBracesParsed = False
    Left = 408
    Top = 61
  end
  object popTV: TPopupMenu
    OnPopup = popTVPopup
    Left = 109
    Top = 254
    object ExpandAll1: TMenuItem
      Caption = 'Expand All'
      OnClick = ExpandAll1Click
    end
    object CollapseAll1: TMenuItem
      Caption = 'Collapse All'
      OnClick = CollapseAll1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object ExportasXML1: TMenuItem
      Caption = 'Export as XML'
      OnClick = ExportasXML1Click
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Xml File|*.xml'
    Left = 112
    Top = 80
  end
end
