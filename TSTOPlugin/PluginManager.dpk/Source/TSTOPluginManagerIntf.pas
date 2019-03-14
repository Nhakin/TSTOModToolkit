unit TSTOPluginManagerIntf;

interface

Uses
  TSTOPluginIntf, TSTOCustomPatches.IO, TSTOScriptTemplate.IO;

Type
  ITSTOPluginManager = Interface(ITSTOPlugin)
    ['{17FD91FF-4DD0-4E73-8AE5-B903D70F8747}']
    Function  GetPlugins() : ITSTOPlugins;
    Function  GetCustomPatchesPlugins() : ITSTOCustomPatchesIO;
    Function  GetScriptsTemplatePlugins() : ITSTOScriptTemplateHacksIO;

    Property Plugins                : ITSTOPlugins               Read GetPlugins;
    Property CustomPatchesPlugins   : ITSTOCustomPatchesIO       Read GetCustomPatchesPlugins;
    Property ScriptsTemplatePlugins : ITSTOScriptTemplateHacksIO Read GetScriptsTemplatePlugins;

  End;
  
implementation

end.
