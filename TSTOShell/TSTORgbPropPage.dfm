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
    Top = 4
    Width = 56
    Height = 13
    Caption = 'File Name : '
  end
  object lblFileName: TLabel
    Left = 70
    Top = 4
    Width = 15
    Height = 13
  end
  object Label2: TLabel
    Left = 8
    Top = 20
    Width = 29
    Height = 13
    Caption = 'Size : '
  end
  object lblImageSize: TLabel
    Left = 70
    Top = 20
    Width = 15
    Height = 13
  end
  object Label3: TLabel
    Left = 8
    Top = 36
    Width = 38
    Height = 13
    Caption = 'Height :'
  end
  object lblHeight: TLabel
    Left = 70
    Top = 36
    Width = 15
    Height = 13
  end
  object lblWidth: TLabel
    Left = 70
    Top = 51
    Width = 15
    Height = 13
  end
  object Label6: TLabel
    Left = 8
    Top = 51
    Width = 35
    Height = 13
    Caption = 'Width :'
  end
  object lblFormat: TLabel
    Left = 374
    Top = 4
    Width = 44
    Height = 13
    Caption = 'Unknown'
  end
  object Label5: TLabel
    Left = 328
    Top = 4
    Width = 44
    Height = 13
    Caption = 'Format : '
  end
  object sbPreview: TScrollBox
    Left = 8
    Top = 70
    Width = 434
    Height = 297
    TabOrder = 0
    object ImgPreview: TImage
      Left = 3
      Top = 3
      Width = 424
      Height = 287
      AutoSize = True
    end
  end
end
