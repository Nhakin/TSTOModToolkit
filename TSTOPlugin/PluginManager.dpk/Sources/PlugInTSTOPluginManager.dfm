object TSTOPluginManagerPlg: TTSTOPluginManagerPlg
  OldCreateOrder = False
  OnCreate = JvPlugInCreate
  Author = 'KahnAbyss'
  Commands = <>
  Description = 'TSTO ModToolKit plugin manager'
  Copyright = 'Copyright '#169' 2003-2019 by HellSpawn; all rights reserved.'
  PluginID = 'HellSpawn.TSTOToolKit.TSTOPluginManager'
  PluginVersion = '1.0.0.1'
  OnInitialize = JvPlugInInitialize
  Height = 114
  Width = 129
  object JvPluginManager1: TJvPluginManager
    Extension = 'dll'
    PluginKind = plgDLL
    Left = 34
    Top = 24
  end
end
