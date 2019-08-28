object TSTORgbPropSheet: TTSTORgbPropSheet
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 375
  ClientWidth = 450
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = SxShellPropSheetFormCreate
  DrawXPBackground = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 56
    Height = 13
    Caption = 'File Name : '
  end
  object LblFileName: TLabel
    Left = 70
    Top = 8
    Width = 56
    Height = 13
    Caption = 'File Name : '
  end
  object Label2: TLabel
    Left = 8
    Top = 24
    Width = 29
    Height = 13
    Caption = 'Size : '
  end
  object lblImageSize: TLabel
    Left = 70
    Top = 24
    Width = 56
    Height = 13
    Caption = 'File Name : '
  end
  object Panel1: TPanel
    Left = 0
    Top = 70
    Width = 450
    Height = 305
    BevelOuter = bvNone
    BorderWidth = 8
    ParentColor = True
    TabOrder = 0
    object ImgPreview: TImage
      AlignWithMargins = True
      Left = 8
      Top = 13
      Width = 105
      Height = 105
      AutoSize = True
    end
  end
end
