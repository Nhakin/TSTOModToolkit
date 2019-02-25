object Form4: TForm4
  Left = 0
  Top = 0
  Caption = 'Form4'
  ClientHeight = 236
  ClientWidth = 342
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
    Top = 8
    Width = 163
    Height = 220
    ItemHeight = 13
    TabOrder = 0
    OnClick = ListBox1Click
  end
  object JvPluginManager1: TJvPluginManager
    PluginFolder = '.\Plugin'
    Extension = 'dll'
    PluginKind = plgDLL
    Left = 21
    Top = 6
  end
end
