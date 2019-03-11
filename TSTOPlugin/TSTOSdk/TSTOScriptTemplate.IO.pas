unit TSTOScriptTemplate.IO;

interface

Uses Classes, HsInterfaceEx, HsStreamEx,
  TSTOScriptTemplateIntf, TSTOHackMasterList.IO, TSTORGBProgress;

Type
  ITSTOScriptTemplateSettingsIO = Interface(ITSTOScriptTemplateSettings)
    ['{4B61686E-29A0-2112-AD91-A65A03B1F196}']
    Function  GetOnChanged() : TNotifyEvent;
    Procedure SetOnChanged(AOnChanged : TNotifyEvent);

    Property OnChanged : TNotifyEvent Read GetOnChanged Write SetOnChanged;

  End;

  ITSTOScriptTemplateVariableIO = Interface(ITSTOScriptTemplateVariable)
    ['{4B61686E-29A0-2112-A001-6B73F37F92E7}']
    Function  GetOnChanged() : TNotifyEvent;
    Procedure SetOnChanged(AOnChanged : TNotifyEvent);

    Property OnChanged : TNotifyEvent Read GetOnChanged Write SetOnChanged;

  End;

  ITSTOScriptTemplateVariablesIO = Interface(ITSTOScriptTemplateVariables)
    ['{4B61686E-29A0-2112-AC9F-1F5A4C47DCD6}']
    Function  Get(Index : Integer) : ITSTOScriptTemplateVariableIO;
    Procedure Put(Index : Integer; Const Item : ITSTOScriptTemplateVariableIO);

    Function Add() : ITSTOScriptTemplateVariableIO; OverLoad;
    Function Add(Const AItem : ITSTOScriptTemplateVariableIO) : Integer; OverLoad;

    Function  Remove(Const Item : ITSTOScriptTemplateVariableIO) : Integer;

    Function  GetOnChanged() : TNotifyEvent;
    Procedure SetOnChanged(AOnChanged : TNotifyEvent);

    Property Items[Index : Integer] : ITSTOScriptTemplateVariableIO Read Get Write Put; Default;

    Property OnChanged : TNotifyEvent Read GetOnChanged Write SetOnChanged;

  End;

  ITSTOScriptTemplateHackIO = Interface(ITSTOScriptTemplateHack)
    ['{4B61686E-29A0-2112-90B1-2D8ACA283AAA}']
    Function  GetVariables() : ITSTOScriptTemplateVariablesIO;
    Function  GetSettings() : ITSTOScriptTemplateSettingsIO;

    Function  GetOnChanged() : TNotifyEvent;
    Procedure SetOnChanged(AOnChanged : TNotifyEvent);

    Function GenenrateScript(AHackMasterList : ITSTOHackMasterListIO; AProgress : IRgbProgress = Nil) : String;

    Property Variables : ITSTOScriptTemplateVariablesIO Read GetVariables;
    Property Settings  : ITSTOScriptTemplateSettingsIO  Read GetSettings;

    Property OnChanged : TNotifyEvent Read GetOnChanged Write SetOnChanged;

  End;

  ITSTOScriptTemplateHacksIO = Interface(ITSTOScriptTemplateHacks)
    ['{4B61686E-29A0-2112-B770-4D9D7C2D5D26}']
    Function  Get(Index : Integer) : ITSTOScriptTemplateHackIO;
    Procedure Put(Index : Integer; Const Item : ITSTOScriptTemplateHackIO);

    Function Add() : ITSTOScriptTemplateHackIO; OverLoad;
    Function Add(Const AItem : ITSTOScriptTemplateHackIO) : Integer; OverLoad;

    Function  Remove(Const Item : ITSTOScriptTemplateHackIO) : Integer;

    Function  GetAsXml() : String;
    Procedure SetAsXml(Const AXml : String);

    Function GetFileName() : String;

    Function GetModified() : Boolean;

    Function  GetOnChanged() : TNotifyEvent;
    Procedure SetOnChanged(AOnChanged : TNotifyEvent);

    Procedure LoadFromXml(Const AXmlString : String);

    Procedure LoadFromStream(AStream : IStreamEx);
    Procedure LoadFromFile(Const AFileName : String);

    Procedure SaveToStream(AStream : IStreamEx);
    Procedure SaveToFile(Const AFileName : String);

    Procedure GenerateScripts(AHackMasterList : ITSTOHackMasterListIO);

    Property Items[Index : Integer] : ITSTOScriptTemplateHackIO Read Get Write Put; Default;

    Property AsXml    : String  Read GetAsXml Write SetAsXml;
    Property FileName : String  Read GetFileName;
    Property Modified : Boolean Read GetModified;

    Property OnChanged : TNotifyEvent Read GetOnChanged Write SetOnChanged;

  End;

implementation

end.
