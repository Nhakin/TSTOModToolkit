object FrmSbtp: TFrmSbtp
  Left = 0
  Top = 0
  Caption = 'Sbtp Patches'
  ClientHeight = 359
  ClientWidth = 593
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 200
    Top = 30
    Height = 329
    ExplicitLeft = 210
    ExplicitTop = 35
  end
  object PanInfo: TPanel
    Left = 203
    Top = 30
    Width = 390
    Height = 329
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object GroupBox1: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 384
      Height = 90
      Align = alTop
      Caption = ' Variable Info '
      TabOrder = 0
      Visible = False
      DesignSize = (
        384
        90)
      object Label1: TLabel
        Left = 12
        Top = 60
        Width = 26
        Height = 13
        Caption = 'Value'
      end
      object Label5: TLabel
        Left = 12
        Top = 33
        Width = 27
        Height = 13
        Caption = 'Name'
      end
      object EditVariableName: TEdit
        Left = 70
        Top = 29
        Width = 302
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
      end
      object EditVariableValue: TEdit
        Left = 70
        Top = 54
        Width = 302
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 1
      end
    end
    object vstSbtpData: TVirtualStringTree
      AlignWithMargins = True
      Left = 3
      Top = 99
      Width = 384
      Height = 227
      Version = '6.2.5.918'
      Align = alClient
      Header.AutoSizeIndex = 2
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoShowSortGlyphs, hoVisible]
      TabOrder = 1
      TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning, toEditOnClick]
      TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowVertGridLines, toThemeAware, toUseBlendedImages]
      TreeOptions.SelectionOptions = [toExtendedFocus]
      OnEditing = vstSbtpDataEditing
      OnFocusChanged = vstSbtpDataFocusChanged
      OnGetText = vstSbtpDataGetText
      OnInitChildren = vstSbtpDataInitChildren
      OnInitNode = vstSbtpDataInitNode
      OnNewText = vstSbtpDataNewText
      Columns = <
        item
          Position = 0
          Width = 86
          WideText = 'Variable Prefix'
        end
        item
          Position = 1
          Width = 95
          WideText = 'Variable Suffix'
        end
        item
          Position = 2
          Width = 199
          WideText = 'Value'
        end
        item
          Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coAllowFocus, coEditable]
          Position = 3
        end>
    end
  end
  object panToolBar: TPanel
    Left = 0
    Top = 0
    Width = 593
    Height = 30
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object tbMain: TToolBar
      Left = 0
      Top = 0
      Width = 593
      Height = 29
      ButtonHeight = 25
      ButtonWidth = 25
      EdgeBorders = [ebLeft, ebTop, ebRight, ebBottom]
      Images = DataModuleImage.imgToolBar
      TabOrder = 0
      OnMouseDown = tbMainMouseDown
      object tbSave: TToolButton
        Left = 0
        Top = 0
        Caption = 'tbSave'
        DropdownMenu = popSave
        ImageIndex = 2
        Style = tbsDropDown
        OnClick = tbSaveClick
      end
      object tbLoadXml: TToolButton
        Left = 40
        Top = 0
        ImageIndex = 1
        OnClick = tbLoadXmlClick
      end
    end
  end
  object PanTreeView: TPanel
    Left = 0
    Top = 30
    Width = 200
    Height = 329
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 2
    object vstSbtpFile: TVirtualStringTree
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 194
      Height = 323
      Version = '6.2.5.918'
      Align = alClient
      Header.AutoSizeIndex = 0
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoShowSortGlyphs]
      TabOrder = 0
      OnFocusChanged = vstSbtpFileFocusChanged
      OnGetText = vstSbtpFileGetText
      OnInitChildren = vstSbtpFileInitChildren
      OnInitNode = vstSbtpFileInitNode
      Columns = <
        item
          Position = 0
          Width = 140
        end
        item
          Position = 1
        end>
    end
  end
  object popSave: TPopupMenu
    Left = 2
    Top = 27
    object Save1: TMenuItem
      Caption = 'Save'
      OnClick = tbSaveClick
    end
    object SaveAsXml1: TMenuItem
      Caption = 'Save As Xml'
      OnClick = SaveAsXml1Click
    end
  end
end
