object FrmProjectGroupSettings: TFrmProjectGroupSettings
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'FrmProjectGroupSettings'
  ClientHeight = 176
  ClientWidth = 364
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
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object SpTBXExPanel1: TSpTBXExPanel
    Left = 0
    Top = 26
    Width = 364
    Height = 124
    Caption = 'SpTBXExPanel1'
    Align = alClient
    TabOrder = 1
    Borders = False
    TBXStyleBackground = True
    DesignSize = (
      364
      124)
    object SpTBXLabel1: TSpTBXLabel
      Left = 16
      Top = 17
      Width = 77
      Height = 19
      Caption = 'Project Name :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object EditProjectName: TSpTBXEdit
      Left = 99
      Top = 16
      Width = 254
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object chkPackOutput: TSpTBXCheckBox
      Left = 99
      Top = 62
      Width = 20
      Height = 28
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 2
    end
    object EditOutputPath: TSpTBXButtonEdit
      Left = 99
      Top = 89
      Width = 254
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 5
      EditButton.Left = 231
      EditButton.Top = 0
      EditButton.Width = 19
      EditButton.Height = 17
      EditButton.Align = alRight
      EditButton.OnClick = EditOutputPathSubEditButton0Click
    end
    object SpTBXLabel5: TSpTBXLabel
      Left = 16
      Top = 90
      Width = 72
      Height = 19
      Caption = 'Output path :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object SpTBXLabel4: TSpTBXLabel
      Left = 16
      Top = 67
      Width = 70
      Height = 19
      Caption = 'Pack output :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object SpTBXLabel2: TSpTBXLabel
      Left = 16
      Top = 43
      Width = 79
      Height = 19
      Caption = 'Hack filename :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object EditHackFileName: TSpTBXButtonEdit
      Left = 99
      Top = 42
      Width = 254
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 7
      EditButton.Left = 231
      EditButton.Top = 0
      EditButton.Width = 19
      EditButton.Height = 17
      EditButton.Align = alRight
      EditButton.OnClick = EditHackFileNameSubEditButton0Click
    end
  end
  object SpTBXStatusBar1: TSpTBXStatusBar
    Left = 0
    Top = 150
    Width = 364
    Height = 26
  end
  object SpTBXDock1: TSpTBXDock
    Left = 0
    Top = 0
    Width = 364
    Height = 26
    AllowDrag = False
    object SpTBXToolbar1: TSpTBXToolbar
      Left = 0
      Top = 0
      FullSize = True
      Images = DataModuleImage.imgToolBar
      TabOrder = 0
      Caption = 'SpTBXToolbar1'
      object SpTbxSave: TSpTBXItem
        ImageIndex = 2
        OnClick = SpTbxSaveClick
      end
    end
  end
end
