object FrmRemoveFileFromProject: TFrmRemoveFileFromProject
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'FrmRemoveFileFromProject'
  ClientHeight = 349
  ClientWidth = 553
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object SpTBXGroupBox1: TSpTBXGroupBox
    Left = 0
    Top = 318
    Width = 553
    Height = 31
    Color = 2499877
    Align = alBottom
    TabOrder = 0
    object SBOk: TSpTBXButton
      Left = 384
      Top = 3
      Width = 75
      Height = 25
      Caption = 'Ok'
      TabOrder = 0
      ModalResult = 1
    end
    object SbCancel: TSpTBXButton
      Left = 465
      Top = 3
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 1
      ModalResult = 2
    end
  end
  object PanTreeView: TPanel
    Left = 0
    Top = 0
    Width = 553
    Height = 318
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
  end
end
