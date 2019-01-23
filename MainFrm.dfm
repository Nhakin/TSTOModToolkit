object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'TSTO ModToolKit'
  ClientHeight = 206
  ClientWidth = 611
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 11
    Top = 34
    Width = 590
    Height = 66
    BevelOuter = bvNone
    TabOrder = 2
    Visible = False
    object Label2: TLabel
      Left = 16
      Top = 17
      Width = 56
      Height = 13
      Caption = 'Mod Source'
    end
    object SBGenDLC: TSpeedButton
      Left = 557
      Top = 22
      Width = 23
      Height = 22
      Caption = 'Go'
      OnClick = SBGenDLCClick
    end
    object Label3: TLabel
      Left = 16
      Top = 41
      Width = 57
      Height = 13
      Caption = 'Mod Output'
    end
    object EditModSource: TEdit
      Left = 105
      Top = 13
      Width = 444
      Height = 21
      TabOrder = 0
      Text = 
        'C:\Projects\TSTO-Hacker\Bin\TSTODlcServer\4_17_GinaMalloy_PostLa' +
        'unch_Patch1_F4UHQY50XTZ2\gamescripts-r262452-CFD3XBVM\Source\'
    end
    object EditModOutput: TEdit
      Left = 105
      Top = 37
      Width = 444
      Height = 21
      TabOrder = 1
      Text = 
        'C:\Projects\TSTO-Hacker\Bin\TSTODlcServer\4_17_GinaMalloy_PostLa' +
        'unch_Patch1_F4UHQY50XTZ2\gamescripts-r262452-CFD3XBVM\Bin\'
    end
  end
  object Panel3: TPanel
    Left = 11
    Top = 34
    Width = 590
    Height = 66
    BevelOuter = bvNone
    UseDockManager = False
    TabOrder = 3
    Visible = False
    object Label4: TLabel
      Left = 16
      Top = 17
      Width = 73
      Height = 13
      Caption = 'SBTP Patch File'
    end
    object SBPatchSBTP: TSpeedButton
      Left = 557
      Top = 22
      Width = 23
      Height = 22
      Caption = 'Go'
      OnClick = SBPatchSBTPClick
    end
    object Label5: TLabel
      Left = 16
      Top = 41
      Width = 73
      Height = 13
      Caption = 'SBTP Files Path'
    end
    object EditSBTPPatchFile: TEdit
      Left = 105
      Top = 13
      Width = 444
      Height = 21
      TabOrder = 0
      Text = 
        'C:\Projects\TSTO-Hacker\Bin\Projects\KahnMod\Sources\SBTPPatchs.' +
        'sptbx'
    end
    object EditSBTPFilesPath: TEdit
      Left = 105
      Top = 37
      Width = 444
      Height = 21
      TabOrder = 1
      Text = 'C:\Projects\TSTO-Hacker\Bin\Projects\KahnMod\Sources\3.src\'
    end
  end
  object Panel1: TPanel
    Left = 11
    Top = 6
    Width = 590
    Height = 41
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 17
      Width = 77
      Height = 13
      Caption = 'Download Script'
    end
    object SBDownload: TSpeedButton
      Left = 557
      Top = 13
      Width = 23
      Height = 22
      Caption = 'Go'
      OnClick = SBDownloadClick
    end
    object EditServer: TEdit
      Left = 105
      Top = 13
      Width = 444
      Height = 21
      TabOrder = 0
      Text = 
        'http://oct2015-4-17-5-bnc9a93.tstodlc.eamobile.com/netstorage/ga' +
        'measset/direct/simpsons/'
    end
  end
  object Button1: TButton
    Left = 15
    Top = 167
    Width = 115
    Height = 25
    Caption = 'Create SBTP Patch'
    TabOrder = 1
    Visible = False
    OnClick = Button1Click
  end
  object cmdCreateMod: TButton
    Left = 20
    Top = 167
    Width = 75
    Height = 25
    Caption = 'Create Mod'
    TabOrder = 4
    OnClick = cmdCreateModClick
  end
  object cmdPackMod: TButton
    Left = 98
    Top = 167
    Width = 75
    Height = 25
    Caption = 'Pack Mod'
    TabOrder = 5
    OnClick = cmdPackModClick
  end
  object cmdValidateXml: TButton
    Left = 176
    Top = 167
    Width = 75
    Height = 25
    Caption = 'Validate Xml'
    TabOrder = 6
    OnClick = cmdValidateXmlClick
  end
  object GroupBox1: TGroupBox
    Left = 21
    Top = 48
    Width = 185
    Height = 105
    Caption = ' Mod Options '
    TabOrder = 7
    object chkAllFree: TCheckBox
      Left = 11
      Top = 60
      Width = 97
      Height = 17
      Caption = 'All Free'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object chkNonUnique: TCheckBox
      Left = 11
      Top = 81
      Width = 97
      Height = 17
      Caption = 'Non unique'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object chkBuildStore: TCheckBox
      Left = 11
      Top = 18
      Width = 116
      Height = 17
      Caption = 'Build Custom Store'
      TabOrder = 2
    end
    object chkInstantBuild: TCheckBox
      Left = 11
      Top = 39
      Width = 97
      Height = 17
      Caption = 'Instant Build'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
  end
  object cmdFreeLandUpgrade: TButton
    Left = 256
    Top = 167
    Width = 75
    Height = 25
    Caption = 'FreeLand'
    TabOrder = 8
    OnClick = cmdFreeLandUpgradeClick
  end
  object Button3: TButton
    Left = 350
    Top = 167
    Width = 75
    Height = 25
    Caption = 'Button3'
    TabOrder = 9
    OnClick = Button3Click
  end
end
