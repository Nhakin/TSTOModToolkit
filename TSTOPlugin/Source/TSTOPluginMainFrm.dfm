object Form4: TForm4
  Left = 0
  Top = 0
  Caption = 'Form4'
  ClientHeight = 257
  ClientWidth = 391
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ListBox1: TListBox
    Left = 8
    Top = 49
    Width = 163
    Height = 200
    ItemHeight = 13
    TabOrder = 0
    OnClick = ListBox1Click
  end
  object SpTBXToolbar1: TSpTBXToolbar
    Left = 0
    Top = 21
    Width = 391
    Height = 22
    Align = alTop
    TabOrder = 1
    Caption = 'SpTBXToolbar1'
    object tbPlugins: TSpTBXTBGroupItem
    end
  end
  object SpTBXToolbar2: TSpTBXToolbar
    Left = 0
    Top = 0
    Width = 391
    Height = 21
    Align = alTop
    CloseButton = False
    FullSize = True
    ProcessShortCuts = True
    ShrinkMode = tbsmWrap
    TabOrder = 2
    Caption = 'SpTBXToolbar1'
    Customizable = False
    MenuBar = True
    object SpTBXSubmenuItem1: TSpTBXSubmenuItem
      Caption = 'File'
      object SpTBXItem1: TSpTBXItem
        Caption = 'Quit'
        OnClick = SpTBXItem1Click
      end
    end
    object mnuPlugins: TSpTBXSubmenuItem
      Caption = 'Plugins'
      object SpTBXTBGroupItem1: TSpTBXTBGroupItem
      end
    end
    object SpTBXSubmenuItem3: TSpTBXSubmenuItem
      Caption = 'Test'
      Visible = False
      object SpTBXTBGroupItem2: TSpTBXTBGroupItem
        LinkSubitems = SpTBXItem2
      end
      object SpTBXSubmenuItem4: TSpTBXSubmenuItem
        Caption = 'SubMenu'
        LinkSubitems = SpTBXSubmenuItem2
      end
    end
  end
  object JvPluginManager1: TJvPluginManager
    PluginFolder = '.\Plugin'
    Extension = 'dll'
    PluginKind = plgDLL
    Left = 13
    Top = 34
  end
  object SpTBXBItemContainer1: TSpTBXBItemContainer
    Left = 216
    Top = 112
    object SpTBXItem2: TSpTBXItem
      Caption = 'Single'
    end
    object SpTBXSubmenuItem2: TSpTBXSubmenuItem
      Caption = 'SubMenu'
      object SpTBXItem4: TSpTBXItem
        Caption = 'Item#1'
      end
      object SpTBXItem3: TSpTBXItem
        Caption = 'Item#2'
      end
    end
  end
end
