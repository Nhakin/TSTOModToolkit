unit TSTOScriptTemplateIntf;

interface

Uses HsInterfaceEx;

Type
  ITSTOScriptTemplateSettings = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-B8F1-FD92987D3332}']
    Function  GetOutputFileName() : WideString;
    Procedure SetOutputFileName(Const AOutputFileName : WideString);

    Function  GetCategoryNamePrefix() : WideString;
    Procedure SetCategoryNamePrefix(Const ACategoryNamePrefix : WideString);

    Function  GetStoreItemsPath() : WideString;
    Procedure SetStoreItemsPath(Const AStoreItemsPath : WideString);

    Function  GetRequirementPath() : WideString;
    Procedure SetRequirementPath(Const ARequirementPath : WideString);

    Function  GetStorePrefix() : WideString;
    Procedure SetStorePrefix(Const AStorePrefix : WideString);

    Procedure Assign(ASource : IInterface);

    Property OutputFileName     : WideString Read GetOutputFileName     Write SetOutputFileName;
    Property CategoryNamePrefix : WideString Read GetCategoryNamePrefix Write SetCategoryNamePrefix;
    Property StoreItemsPath     : WideString Read GetStoreItemsPath     Write SetStoreItemsPath;
    Property RequirementPath    : WideString Read GetRequirementPath    Write SetRequirementPath;
    Property StorePrefix        : WideString Read GetStorePrefix        Write SetStorePrefix;

  End;

  ITSTOScriptTemplateVariable = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-844B-ABCC24F4C489}']
    Function  GetName() : WideString;
    Procedure SetName(Const AName : WideString);

    Function  GetFunction() : WideString;
    Procedure SetFunction(Const AFunction : WideString);

    Procedure Assign(ASource : IInterface);

    Property Name    : WideString Read GetName     Write SetName;
    Property VarFunc : WideString Read GetFunction Write SetFunction;

  End;

  ITSTOScriptTemplateVariables = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-8B08-1EFDA95F4B89}']
    Function  Get(Index : Integer) : ITSTOScriptTemplateVariable;
    Procedure Put(Index : Integer; Const Item : ITSTOScriptTemplateVariable);

    Function Add() : ITSTOScriptTemplateVariable; OverLoad;
    Function Add(Const AItem : ITSTOScriptTemplateVariable) : Integer; OverLoad;
    Function Remove(Const Item : ITSTOScriptTemplateVariable) : Integer;

    Procedure Assign(ASource : IInterface);

    Property Items[Index : Integer] : ITSTOScriptTemplateVariable Read Get Write Put; Default;

  End;

  ITSTOScriptTemplateHack = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-95A5-40EFB56DA2CE}']
    Function  GetName() : WideString;
    Procedure SetName(Const AName : WideString);

    Function  GetEnabled() : Boolean;
    Procedure SetEnabled(Const AEnabled : Boolean);

    Function  GetVariables() : ITSTOScriptTemplateVariables;

    Function  GetSettings() : ITSTOScriptTemplateSettings;

    Function  GetTemplateFile() : WideString;
    Procedure SetTemplateFile(Const ATemplateFile : WideString);

    Procedure Assign(ASource : IInterface);

    Property Name         : WideString                   Read GetName         Write SetName;
    Property Enabled      : Boolean                      Read GetEnabled      Write SetEnabled;
    Property Variables    : ITSTOScriptTemplateVariables Read GetVariables;
    Property Settings     : ITSTOScriptTemplateSettings  Read GetSettings;
    Property TemplateFile : WideString                   Read GetTemplateFile Write SetTemplateFile;

  End;

  ITSTOScriptTemplateHacks = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-99B3-49236D60B2B4}']
    Function  Get(Index : Integer) : ITSTOScriptTemplateHack;
    Procedure Put(Index : Integer; Const Item : ITSTOScriptTemplateHack);

    Function Add() : ITSTOScriptTemplateHack; OverLoad;
    Function Add(Const AItem : ITSTOScriptTemplateHack) : Integer; OverLoad;

    Function  Remove(Const Item : ITSTOScriptTemplateHack) : Integer;

    Procedure Assign(ASource : IInterface);

    Property Items[Index : Integer] : ITSTOScriptTemplateHack Read Get Write Put; Default;

  End;

implementation

end.
