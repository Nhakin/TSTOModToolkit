unit TSTOScriptTemplateIntfReg;

interface

implementation

Uses HsInterfaceEx, TSTOScriptTemplateIntf, TSTOScriptTemplate.Xml, TSTOScriptTemplate.IO;

Initialization
  RegisterInterface('ITSTOScriptTemplateSettings', ITSTOScriptTemplateSettings);
  RegisterInterface('ITSTOScriptTemplateVariable', ITSTOScriptTemplateVariable);
  RegisterInterface('ITSTOScriptTemplateVariables', ITSTOScriptTemplateVariables);
  RegisterInterface('ITSTOScriptTemplateHack', ITSTOScriptTemplateHack);
  RegisterInterface('ITSTOScriptTemplateHacks', ITSTOScriptTemplateHacks);

  RegisterInterface('ITSTOXmlScriptTemplateSettings', ITSTOXmlScriptTemplateSettings);
  RegisterInterface('ITSTOXmlScriptTemplateVariable', ITSTOXmlScriptTemplateVariable);
  RegisterInterface('ITSTOXmlScriptTemplateVariables', ITSTOXmlScriptTemplateVariables);
  RegisterInterface('ITSTOXmlScriptTemplateHack', ITSTOXmlScriptTemplateHack);
  RegisterInterface('ITSTOXmlScriptTemplateHacks', ITSTOXmlScriptTemplateHacks);

  RegisterInterface('ITSTOScriptTemplateHacksIO', ITSTOScriptTemplateHacksIO);
  RegisterInterface('ITSTOScriptTemplateVariableIO', ITSTOScriptTemplateVariableIO);
  RegisterInterface('ITSTOScriptTemplateVariablesIO', ITSTOScriptTemplateVariablesIO);
  RegisterInterface('ITSTOScriptTemplateHackIO', ITSTOScriptTemplateHackIO);

end.
