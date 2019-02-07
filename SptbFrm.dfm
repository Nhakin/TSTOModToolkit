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
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object PanInfo: TPanel
    Left = 205
    Top = 26
    Width = 388
    Height = 333
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object gbPatchInfoV2: TSpTBXGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 382
      Height = 90
      Caption = ' Variable Info '
      Color = 2499877
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 15856113
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Visible = False
      DesignSize = (
        382
        90)
      object Label5: TLabel
        Left = 12
        Top = 33
        Width = 27
        Height = 13
        Caption = 'Name'
      end
      object Label1: TLabel
        Left = 12
        Top = 60
        Width = 26
        Height = 13
        Caption = 'Value'
      end
      object EditVariableValue: TEdit
        Left = 70
        Top = 54
        Width = 297
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
      end
      object EditVariableName: TEdit
        Left = 70
        Top = 29
        Width = 297
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 1
      end
    end
  end
  object PanTreeView: TPanel
    Left = 0
    Top = 26
    Width = 200
    Height = 333
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
    object vstSbtpFile: TSpTBXVirtualStringTree
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 194
      Height = 327
      Version = '6.2.5.918'
      Align = alClient
      Color = clNone
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
          Width = 180
        end
        item
          Position = 1
          Width = 10
        end>
    end
  end
  object sptbxDckMain: TSpTBXDock
    Left = 0
    Top = 0
    Width = 593
    Height = 26
    AllowDrag = False
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
      object SpTBXItem3: TSpTBXItem
        ImageIndex = 35
        Visible = False
      end
    end
  end
  object SplitTvs: TSpTBXSplitter
    Left = 200
    Top = 26
    Height = 333
    Cursor = crSizeWE
  end
  object popSave: TPopupMenu
    Left = 50
    Top = 115
    object Save1: TMenuItem
      Caption = 'Save'
      OnClick = tbSaveClick
    end
    object SaveAsXml1: TMenuItem
      Caption = 'Save As Xml'
      OnClick = SaveAsXml1Click
    end
  end
  object SpTBXBItemContainer1: TSpTBXBItemContainer
    Left = 56
    Top = 296
    object tbPopupMenuItems: TSpTBXSubmenuItem
      object tbSave: TSpTBXSubmenuItem
        Caption = 'Save'
        Enabled = False
        ImageIndex = 2
        Images = DataModuleImage.imgToolBar
        OnClick = tbSaveClick
        DropdownCombo = True
        HideEmptyPopup = True
        object tbSave2: TSpTBXItem
          Caption = 'Save'
          OnClick = tbSaveClick
        end
        object tbSaveAsXml: TSpTBXItem
          Caption = 'Save As Xml'
          OnClick = SaveAsXml1Click
        end
      end
      object tbOpenFile: TSpTBXItem
        Caption = 'Open File'
        ImageIndex = 1
        Images = DataModuleImage.imgToolBar
        OnClick = tbLoadXmlClick
      end
    end
  end
end
