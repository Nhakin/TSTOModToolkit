object TSTOPluginDemo: TTSTOPluginDemo
  OldCreateOrder = False
  OnCreate = JvPlugInCreate
  OnDestroy = JvPlugInDestroy
  Author = 'KahnAbyss'
  Commands = <
    item
      Name = 'Command1'
      ShortCut = 0
    end>
  Description = 'TSTO Basic Plugin'
  Copyright = 'Copyright '#169' 2019 by KahnAbyss; all rights reserved.'
  PluginID = 'TSTOToolKit.PlgTSTOPluginDemo'
  OnConfigure = JvPlugInConfigure
  Height = 150
  Width = 215
end
