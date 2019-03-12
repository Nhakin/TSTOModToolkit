object TSTOPluginManagerDlg: TTSTOPluginManagerDlg
  Left = 0
  Top = 0
  Caption = 'Plugin Manager'
  ClientHeight = 325
  ClientWidth = 488
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object sptbxDckMain: TSpTBXDock
    Left = 0
    Top = 0
    Width = 488
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
      Images = imgToolBar
      LinkSubitems = tbPopupMenuItems
      ProcessShortCuts = True
      Resizable = False
      ShrinkMode = tbsmWrap
      Stretch = True
      TabOrder = 0
      Caption = 'sptbxtbMain'
      Customizable = False
      MenuBar = True
    end
  end
  object SpTBXExPanel1: TSpTBXExPanel
    Left = 0
    Top = 26
    Width = 161
    Height = 273
    Align = alLeft
    TabOrder = 1
    TBXStyleBackground = True
    object tvPlugins: TSpTBXVirtualStringTree
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 151
      Height = 263
      Align = alClient
      Header.AutoSizeIndex = 0
      Header.DefaultHeight = 17
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      Header.MainColumn = -1
      Header.Options = [hoColumnResize, hoDrag, hoOwnerDraw, hoShowSortGlyphs]
      NodeDataSize = 4
      TabOrder = 0
      TreeOptions.PaintOptions = [toHotTrack, toPopupMode, toShowButtons, toShowDropmark, toThemeAware, toUseBlendedImages]
      OnFocusChanged = tvPluginsFocusChanged
      OnGetText = tvPluginsGetText
      OnInitNode = tvPluginsInitNode
      Columns = <>
    end
  end
  object SpTBXStatusBar1: TSpTBXStatusBar
    Left = 0
    Top = 299
    Width = 488
    Height = 26
  end
  object SpTBXSplitter1: TSpTBXSplitter
    Left = 161
    Top = 26
    Height = 273
    Cursor = crSizeWE
  end
  object SpTBXExPanel2: TSpTBXExPanel
    Left = 166
    Top = 26
    Width = 322
    Height = 273
    Align = alClient
    TabOrder = 4
    TBXStyleBackground = True
    object SpTBXGroupBox1: TSpTBXGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 312
      Height = 263
      Caption = ' Plugin Info '
      Align = alClient
      TabOrder = 0
      TBXStyleBackground = True
      DesignSize = (
        312
        263)
      object SpTBXLabel1: TSpTBXLabel
        Left = 10
        Top = 20
        Width = 43
        Height = 19
        Caption = 'Name : '
      end
      object EditName: TSpTBXEdit
        Left = 75
        Top = 20
        Width = 227
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        ReadOnly = True
        TabOrder = 1
      end
      object SpTBXLabel2: TSpTBXLabel
        Left = 10
        Top = 47
        Width = 49
        Height = 19
        Caption = 'Author : '
      end
      object EditAuthor: TSpTBXEdit
        Left = 75
        Top = 47
        Width = 227
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        ReadOnly = True
        TabOrder = 3
      end
      object SpTBXLabel3: TSpTBXLabel
        Left = 10
        Top = 74
        Width = 63
        Height = 19
        Caption = 'Copyright : '
      end
      object EditCopyright: TSpTBXEdit
        Left = 75
        Top = 74
        Width = 227
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        ReadOnly = True
        TabOrder = 5
      end
      object SpTBXLabel4: TSpTBXLabel
        Left = 10
        Top = 101
        Width = 51
        Height = 19
        Caption = 'Version : '
      end
      object EditVersion: TSpTBXEdit
        Left = 75
        Top = 101
        Width = 227
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        ReadOnly = True
        TabOrder = 7
      end
      object SpTBXLabel5: TSpTBXLabel
        Left = 10
        Top = 128
        Width = 69
        Height = 19
        Caption = 'Description : '
      end
      object EditDescription: TSpTBXEdit
        Left = 10
        Top = 153
        Width = 292
        Height = 75
        Anchors = [akLeft, akTop, akRight, akBottom]
        AutoSize = False
        ReadOnly = True
        TabOrder = 9
      end
      object CmdPluginSetting: TSpTBXButton
        Left = 227
        Top = 234
        Width = 75
        Height = 25
        Caption = 'Settings...'
        Anchors = [akRight, akBottom]
        Enabled = False
        TabOrder = 10
        OnClick = CmdPluginSettingClick
      end
    end
  end
  object imgToolBar: TImageList
    Left = 26
    Top = 20
    Bitmap = {
      494C010101007800100010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000944239009442
      3900B59C9C00B59C9C00B59C9C00B59C9C00B59C9C00B59C9C00B59C9C009431
      3100944239000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000094423900D66B6B00C663
      6300E7DEDE009429290094292900E7E7E700E7E7E700DEDEE700CECECE008C21
      1800AD4242009442390000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000094423900D6636300C65A
      5A00EFE7E7009429290094292900E7E7E700E7E7EF00DEE7E700CECECE008C21
      2100AD4242009442390000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000094423900D6636300C65A
      5A00EFE7E7009429290094292900DEDEDE00E7E7EF00E7E7E700D6D6D6008C18
      1800AD4242009442390000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000094423900D6636300C65A
      5A00EFE7E700EFE7E700E7DEDE00E7DEDE00DEE7E700E7E7E700D6D6D6009429
      2900B54A4A009442390000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000094423900CE636300CE63
      6300CE636300CE737300CE737300C66B6B00C6636300CE6B6B00CE636300C65A
      5A00CE6363009442390000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000094423900B5525200C67B
      7B00D69C9C00D6A5A500DEA5A500DEA5A500D6A59C00D6A59C00D6ADA500DEAD
      AD00CE6363009442390000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000094423900CE636300FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CE6363009442390000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000094423900CE636300FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CE6363009442390000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000094423900CE636300FFFF
      FF00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00FFFF
      FF00CE6363009442390000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000094423900CE636300FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CE6363009442390000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000094423900CE636300FFFF
      FF00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00FFFF
      FF00CE6363009442390000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000094423900CE636300FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CE6363009442390000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000094423900FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00944239000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFF000000000000C007000000000000
      8003000000000000800300000000000080030000000000008003000000000000
      8003000000000000800300000000000080030000000000008003000000000000
      8003000000000000800300000000000080030000000000008003000000000000
      C007000000000000FFFF00000000000000000000000000000000000000000000
      000000000000}
  end
  object SpTBXBItemContainer1: TSpTBXBItemContainer
    Left = 24
    Top = 72
    object tbPopupMenuItems: TSpTBXSubmenuItem
      object tbSavePlugins: TSpTBXItem
        Caption = 'Save'
        ImageIndex = 0
        Images = imgToolBar
        OnClick = tbSavePluginsClick
      end
    end
  end
end
