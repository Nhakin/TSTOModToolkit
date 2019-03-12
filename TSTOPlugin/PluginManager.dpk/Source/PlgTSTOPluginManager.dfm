inherited TSTOPluginManager: TTSTOPluginManager
  OldCreateOrder = True
  Author = 'KahnAbyss'
  Description = 'TSTO Plugin Manager'
  Copyright = 'Copyright '#39'#169'#39' 2003-2019 by HellSpawn; all rights reserved.'
  PluginID = 'HellSpawn.PlgTSTOPluginManager'
  PluginVersion = '1.0.0.1'
  object JvPluginManager1: TJvPluginManager
    Extension = 'dll'
    PluginKind = plgDLL
    Left = 80
    Top = 16
  end
  object SpTBXBItemContainer1: TSpTBXBItemContainer
    Left = 80
    Top = 80
    object grpPluginManagerMenuItem: TSpTBXTBGroupItem
      object SpTBXSeparatorItem1: TSpTBXSeparatorItem
      end
      object mnuPluginManager: TSpTBXItem
        Caption = 'Plugin Manager'
        OnClick = mnuPluginManagerClick
      end
    end
  end
end
