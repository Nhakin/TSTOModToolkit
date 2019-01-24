object FrmProjectSettings: TFrmProjectSettings
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'FrmProjectSettings'
  ClientHeight = 261
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
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object SpTBXExPanel1: TSpTBXExPanel
    Left = 0
    Top = 26
    Width = 364
    Height = 209
    Caption = 'SpTBXExPanel1'
    Align = alClient
    TabOrder = 1
    Borders = False
    TBXStyleBackground = True
    ExplicitHeight = 188
    DesignSize = (
      364
      209)
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
      Top = 100
      Width = 20
      Height = 28
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 4
    end
    object EditOutputPath: TSpTBXButtonEdit
      Left = 117
      Top = 127
      Width = 241
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 6
      EditButton.Left = 218
      EditButton.Top = 0
      EditButton.Width = 19
      EditButton.Height = 17
      EditButton.Align = alRight
      EditButton.OnClick = EditOutputPathSubEditButton0Click
    end
    object SpTBXLabel5: TSpTBXLabel
      Left = 16
      Top = 128
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
      Top = 105
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
    object rgProjectKind: TSpTBXRadioGroup
      Left = 99
      Top = 42
      Width = 121
      Height = 58
      Caption = ' Project Kind '
      TabOrder = 2
      Items.Strings = (
        'Root'
        'Dlc Server')
    end
    object rgProjectType: TSpTBXRadioGroup
      Left = 232
      Top = 42
      Width = 121
      Height = 58
      Caption = ' Project Type '
      TabOrder = 3
      OnClick = rgProjectTypeClick
      Items.Strings = (
        'Scripts'
        'Textpools')
    end
    object LabelCustomScriptPath: TSpTBXLabel
      Left = 16
      Top = 182
      Width = 103
      Height = 19
      Caption = 'Custom script path :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object EditCustomScriptPath: TSpTBXButtonEdit
      Left = 117
      Top = 181
      Width = 241
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 10
      EditButton.Left = 218
      EditButton.Top = 0
      EditButton.Width = 19
      EditButton.Height = 17
      EditButton.Align = alRight
      EditButton.OnClick = EditCustomScriptPathSubEditButton0Click
    end
    object EditCustomModPath: TSpTBXButtonEdit
      Left = 117
      Top = 154
      Width = 241
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 9
      EditButton.Left = 218
      EditButton.Top = 0
      EditButton.Width = 19
      EditButton.Height = 17
      EditButton.Align = alRight
      EditButton.OnClick = EditCustomModPathSubEditButton0Click
    end
    object SpTBXLabel2: TSpTBXLabel
      Left = 16
      Top = 155
      Width = 97
      Height = 19
      Caption = 'Custom mod path :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
  end
  object SpTBXStatusBar1: TSpTBXStatusBar
    Left = 0
    Top = 235
    Width = 364
    Height = 26
    ExplicitTop = 214
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
