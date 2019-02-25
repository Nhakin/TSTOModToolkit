unit TSTOHackSettingsIntf;

interface

Uses Classes, HsInterfaceEx,
  TSTOCustomPatchesIntf, TSTOSbtpIntf, TSTOScriptTemplateIntfIO, TSTOHackMasterListIntf;

Type
  THackIdxFileFormat = (hiffXml, hiffBin, hiffZip);

  ITSTOHackSettings = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-9BE8-7A7F480881B7}']
    Function  GetCustomPatches() : ITSTOCustomPatchesIO;
    Function  GetTextPools() : ISbtpFilesIO;
    Function  GetScriptTemplates() : ITSTOScriptTemplateHacksIO;
    Function  GetHackMasterList() : ITSTOHackMasterListIO;

    Function  GetOnChanged() : TNotifyEvent;
    Procedure SetOnChanged(AOnChanged : TNotifyEvent);

    Procedure LoadFromFile(Const AFileName : String);
    Procedure SaveToFile(Const AForceSave : Boolean = False); OverLoad;
    Procedure SaveToFile(Const AFileName : String; Const AForceSave : Boolean = False); OverLoad;

    Procedure NewHackFile();
    Procedure ExtractHackSource(Const AFileFormat : THackIdxFileFormat; APath : String = '');
    Procedure PackHackSource(Const AFileFormat : THackIdxFileFormat; Const AIndexFile, AFileName : String);

    Property CustomPatches   : ITSTOCustomPatchesIO       Read GetCustomPatches;
    Property TextPools       : ISbtpFilesIO               Read GetTextPools;
    Property ScriptTemplates : ITSTOScriptTemplateHacksIO Read GetScriptTemplates;
    Property HackMasterList  : ITSTOHackMasterListIO      Read GetHackMasterList;

    Property OnChanged : TNotifyEvent Read GetOnChanged Write SetOnChanged;

  End;
  
implementation

end.
