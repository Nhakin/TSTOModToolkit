object FrmSettings: TFrmSettings
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Settings'
  ClientHeight = 200
  ClientWidth = 447
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object dckNewTB: TSpTBXDock
    Left = 0
    Top = 0
    Width = 447
    Height = 26
    AllowDrag = False
    object tbMainV2: TSpTBXToolbar
      Left = 0
      Top = 0
      DockableTo = []
      DockMode = dmCannotFloatOrChangeDocks
      DragHandleStyle = dhNone
      FullSize = True
      TabOrder = 0
      Caption = 'tbMainV2'
      object tbSaveV2: TSpTBXItem
        ImageIndex = 2
        Images = DataModuleImage.imgToolBar
        OnClick = tbSaveClick
      end
    end
  end
  object SbMainV2: TSpTBXStatusBar
    Left = 0
    Top = 174
    Width = 447
    Height = 26
    Enabled = False
    ExplicitTop = 195
  end
  object PanData: TSpTBXExPanel
    Left = 0
    Top = 26
    Width = 447
    Height = 148
    Color = clBtnFace
    Align = alClient
    UseDockManager = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    ShowCaption = True
    ExplicitHeight = 169
    DesignSize = (
      447
      148)
    object LblResourcePath: TLabel
      Left = 11
      Top = 116
      Width = 70
      Height = 13
      Caption = 'Resource Path'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object LblDLCServer: TLabel
      Left = 11
      Top = 9
      Width = 51
      Height = 13
      Caption = 'DLCServer'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object LblDLCPath: TLabel
      Left = 11
      Top = 36
      Width = 41
      Height = 13
      Caption = 'DLCPath'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object LblHackPath: TLabel
      Left = 11
      Top = 63
      Width = 45
      Height = 13
      Caption = 'HackPath'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object LblHackFileName: TLabel
      Left = 11
      Top = 90
      Width = 86
      Height = 13
      Caption = 'Hack Zip FileName'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object LblSourcePath: TLabel
      Left = 11
      Top = 117
      Width = 58
      Height = 13
      Caption = 'Source Path'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
      Visible = False
    end
    object LblTargetPath: TLabel
      Left = 11
      Top = 116
      Width = 57
      Height = 13
      Caption = 'Target Path'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
      Visible = False
    end
    object EditDLCServer: TEdit
      Left = 105
      Top = 5
      Width = 332
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object EditDLCPath: TEdit
      Left = 105
      Top = 32
      Width = 332
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
    end
    object EditHackPath: TEdit
      Left = 105
      Top = 59
      Width = 332
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
    end
    object EditHackFileName: TEdit
      Left = 105
      Top = 86
      Width = 303
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 3
    end
    object EditSourcePath: TEdit
      Left = 105
      Top = 113
      Width = 332
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 4
      Visible = False
    end
    object EditTargetPath: TEdit
      Left = 105
      Top = 113
      Width = 332
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 5
      Visible = False
    end
    object EditResourcePath: TEdit
      Left = 105
      Top = 113
      Width = 303
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 6
    end
    object SbReloadRessourceIndex: TSpTBXSpeedButton
      Left = 414
      Top = 113
      Width = 23
      Height = 22
      Hint = 'Rebuild index'
      Anchors = [akTop, akRight]
      OnClick = SbReloadRessourceIndexClick
      Images = DataModuleImage.imgToolBar
      ImageIndex = 21
    end
    object SbCreateNewHack: TSpTBXSpeedButton
      Left = 414
      Top = 86
      Width = 23
      Height = 22
      Hint = 'Rebuild index'
      Anchors = [akTop, akRight]
      OnClick = SbCreateNewHackClick
      Images = DataModuleImage.imgToolBar
      ImageIndex = 0
    end
  end
end
