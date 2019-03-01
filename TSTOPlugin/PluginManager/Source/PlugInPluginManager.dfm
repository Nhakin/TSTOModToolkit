object TSTOPluginManager: TTSTOPluginManager
  OldCreateOrder = False
  OnCreate = JvPlugInCreate
  Author = 'KahnAbyss'
  Commands = <>
  Description = 'TSTO Plugin Manager'
  Copyright = 'Copyright '#169' 2019 by KahnAbyss; all rights reserved.'
  PluginID = 'TSTOToolKit.PlgTSTOPluginManager'
  PluginVersion = '1.0.0.0'
  Height = 150
  Width = 215
  object SpTBXBItemContainer1: TSpTBXBItemContainer
    Left = 80
    Top = 8
    object SpTbxPluginManager: TSpTBXItem
      Caption = 'Plugin Manager'
      OnClick = SpTbxPluginManagerClick
    end
  end
end
