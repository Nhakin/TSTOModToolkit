unit TSTOScriptTemplateImpl;

interface

Uses Classes, HsInterfaceEx, TSTOScriptTemplateIntf;

Type
  TTSTOScriptTemplateSettings = Class(TInterfacedObjectEx, ITSTOScriptTemplateSettings)
  Private
    FOutputFileName     : WideString;
    FCategoryNamePrefix : WideString;
    FStoreItemsPath     : WideString;
    FRequirementPath    : WideString;
    FStorePrefix        : WideString;

  Protected
    Function  GetOutputFileName() : WideString; Virtual;
    Procedure SetOutputFileName(Const AOutputFileName : WideString); Virtual;

    Function  GetCategoryNamePrefix() : WideString; Virtual;
    Procedure SetCategoryNamePrefix(Const ACategoryNamePrefix : WideString); Virtual;

    Function  GetStoreItemsPath() : WideString; Virtual;
    Procedure SetStoreItemsPath(Const AStoreItemsPath : WideString); Virtual;

    Function  GetRequirementPath() : WideString; Virtual;
    Procedure SetRequirementPath(Const ARequirementPath : WideString); Virtual;

    Function  GetStorePrefix() : WideString; Virtual;
    Procedure SetStorePrefix(Const AStorePrefix : WideString); Virtual;

    Procedure Assign(ASource : IInterface); ReIntroduce; Virtual;

    Property OutputFileName     : WideString Read GetOutputFileName     Write SetOutputFileName;
    Property CategoryNamePrefix : WideString Read GetCategoryNamePrefix Write SetCategoryNamePrefix;
    Property StoreItemsPath     : WideString Read GetStoreItemsPath     Write SetStoreItemsPath;
    Property RequirementPath    : WideString Read GetRequirementPath    Write SetRequirementPath;
    Property StorePrefix        : WideString Read GetStorePrefix        Write SetStorePrefix;

  End;

  TTSTOScriptTemplateVariable = Class(TInterfacedObjectEx, ITSTOScriptTemplateVariable)
  Private
    FName      : WideString;
    FFunction  : WideString;

  Protected
    Function  GetName() : WideString; Virtual;
    Procedure SetName(Const AName : WideString); Virtual;

    Function  GetFunction() : WideString; Virtual;
    Procedure SetFunction(Const AFunction : WideString); Virtual;

    Procedure Assign(ASource : IInterface); ReIntroduce; Virtual;

    Property Name    : WideString Read GetName     Write SetName;
    Property VarFunc : WideString Read GetFunction Write SetFunction;

  End;

  TTSTOScriptTemplateVariables = Class(TInterfaceListEx, ITSTOScriptTemplateVariables)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;

    Function  Get(Index : Integer) : ITSTOScriptTemplateVariable; OverLoad;
    Procedure Put(Index : Integer; Const Item : ITSTOScriptTemplateVariable); OverLoad;

    Function Add() : ITSTOScriptTemplateVariable; ReIntroduce; OverLoad;
    Function Add(Const AItem : ITSTOScriptTemplateVariable) : Integer; ReIntroduce; OverLoad;
    Function Remove(Const Item : ITSTOScriptTemplateVariable) : Integer; OverLoad;

    Procedure Assign(ASource : IInterface); ReIntroduce; Virtual;

  End;

  TTSTOScriptTemplateSettingsClass  = Class Of TTSTOScriptTemplateSettings;
  TTSTOScriptTemplateVariablesClass = Class Of TTSTOScriptTemplateVariables;

  TTSTOScriptTemplateHack = Class(TInterfacedObjectEx, ITSTOScriptTemplateHack)
  Private
    FName         : WideString;
    FEnabled      : Boolean;
    FVariables    : ITSTOScriptTemplateVariables;
    FSettings     : ITSTOScriptTemplateSettings;
    FTemplateFile : WideString;

  Protected
    Function  GetVariablesClass() : TTSTOScriptTemplateVariablesClass; Virtual;
    Function  GetSettingsClass() : TTSTOScriptTemplateSettingsClass; Virtual;

    Function  GetName() : WideString; Virtual;
    Procedure SetName(Const AName : WideString); Virtual;

    Function  GetEnabled() : Boolean; Virtual;
    Procedure SetEnabled(Const AEnabled : Boolean); Virtual;

    Function  GetVariables() : ITSTOScriptTemplateVariables; Virtual;

    Function  GetSettings() : ITSTOScriptTemplateSettings; Virtual;

    Function  GetTemplateFile() : WideString; Virtual;
    Procedure SetTemplateFile(Const ATemplateFile : WideString); Virtual;

    Property Name         : WideString                   Read GetName         Write SetName;
    Property Enabled      : Boolean                      Read GetEnabled      Write SetEnabled;
    Property Variables    : ITSTOScriptTemplateVariables Read GetVariables;
    Property Settings     : ITSTOScriptTemplateSettings  Read GetSettings;
    Property TemplateFile : WideString                   Read GetTemplateFile Write SetTemplateFile;

  Public
    Procedure Assign(ASource : IInterface); ReIntroduce; Virtual;

    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;

  End;

  TTSTOScriptTemplateHacks = Class(TInterfaceListEx, ITSTOScriptTemplateHacks)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;

    Function  Get(Index : Integer) : ITSTOScriptTemplateHack; OverLoad;
    Procedure Put(Index : Integer; Const Item : ITSTOScriptTemplateHack); OverLoad;

    Function Add() : ITSTOScriptTemplateHack; ReIntroduce; OverLoad;
    Function Add(Const AItem : ITSTOScriptTemplateHack) : Integer; ReIntroduce; OverLoad;
    Function Remove(Const Item : ITSTOScriptTemplateHack) : Integer; ReIntroduce; OverLoad;

    Procedure Assign(ASource : IInterface); Virtual;

  End;

implementation

Uses RtlConsts, SysUtils;

Procedure TTSTOScriptTemplateSettings.Assign(ASource : IInterface);
Var lSrc : ITSTOScriptTemplateSettings;
Begin
  If Supports(ASource, ITSTOScriptTemplateSettings, lSrc) Then
  Begin
    FOutputFileName     := lSrc.OutputFileName;
    FCategoryNamePrefix := lSrc.CategoryNamePrefix;
    FStoreItemsPath     := lSrc.StoreItemsPath;
    FRequirementPath    := lSrc.RequirementPath;
    FStorePrefix        := lSrc.StorePrefix;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TTSTOScriptTemplateSettings.GetOutputFileName() : WideString;
Begin
  Result := FOutputFileName;
End;

Procedure TTSTOScriptTemplateSettings.SetOutputFileName(Const AOutputFileName : WideString);
Begin
  FOutputFileName := AOutputFileName;
End;

Function TTSTOScriptTemplateSettings.GetCategoryNamePrefix() : WideString;
Begin
  Result := FCategoryNamePrefix;
End;

Procedure TTSTOScriptTemplateSettings.SetCategoryNamePrefix(Const ACategoryNamePrefix : WideString);
Begin
  FCategoryNamePrefix := ACategoryNamePrefix;
End;

Function TTSTOScriptTemplateSettings.GetStoreItemsPath() : WideString;
Begin
  Result := FStoreItemsPath;
End;

Procedure TTSTOScriptTemplateSettings.SetStoreItemsPath(Const AStoreItemsPath : WideString);
Begin
  FStoreItemsPath := AStoreItemsPath;
End;

Function TTSTOScriptTemplateSettings.GetRequirementPath() : WideString;
Begin
  Result := FRequirementPath;
End;

Procedure TTSTOScriptTemplateSettings.SetRequirementPath(Const ARequirementPath : WideString);
Begin
  FRequirementPath := ARequirementPath;
End;

Function TTSTOScriptTemplateSettings.GetStorePrefix() : WideString;
Begin
  Result := FStorePrefix;
End;

Procedure TTSTOScriptTemplateSettings.SetStorePrefix(Const AStorePrefix : WideString);
Begin
  FStorePrefix := AStorePrefix;
End;

Procedure TTSTOScriptTemplateVariable.Assign(ASource : IInterface);
Var lSrc : ITSTOScriptTemplateVariable;
Begin
  If Supports(ASource, ITSTOScriptTemplateVariable, lSrc) Then
  Begin
    FName     := lSrc.Name;
    FFunction := lSrc.VarFunc;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TTSTOScriptTemplateVariable.GetName() : WideString;
Begin
  Result := FName;
End;

Procedure TTSTOScriptTemplateVariable.SetName(Const AName : WideString);
Begin
  FName := AName;
End;

Function TTSTOScriptTemplateVariable.GetFunction() : WideString;
Begin
  Result := FFunction;
End;

Procedure TTSTOScriptTemplateVariable.SetFunction(Const AFunction : WideString);
Begin
  FFunction := AFunction;
End;

Procedure TTSTOScriptTemplateVariables.Assign(ASource : IInterface);
Var lSrc : ITSTOScriptTemplateVariables;
    X    : Integer;
Begin
  If Supports(ASource, ITSTOScriptTemplateVariables, lSrc) Then
    For X := 0 To lSrc.Count - 1 Do
      Add().Assign(lSrc[X]);
End;

Function TTSTOScriptTemplateVariables.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TTSTOScriptTemplateVariable;
End;

Function TTSTOScriptTemplateVariables.Get(Index : Integer) : ITSTOScriptTemplateVariable;
Begin
  Result := InHerited Items[Index] As ITSTOScriptTemplateVariable;
End;

Procedure TTSTOScriptTemplateVariables.Put(Index : Integer; Const Item : ITSTOScriptTemplateVariable);
Begin
  InHerited Items[Index] := Item;
End;

Function TTSTOScriptTemplateVariables.Add() : ITSTOScriptTemplateVariable;
Begin
  Result := InHerited Add() As ITSTOScriptTemplateVariable;
End;

Function TTSTOScriptTemplateVariables.Add(Const AItem : ITSTOScriptTemplateVariable) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Function TTSTOScriptTemplateVariables.Remove(Const Item : ITSTOScriptTemplateVariable) : Integer;
Begin
  Result := InHerited Remove(Item As IInterfaceEx);
End;

Procedure TTSTOScriptTemplateHack.AfterConstruction();
Begin
  InHerited AfterConstruction();

  FVariables := GetVariablesClass().Create();
  FSettings  := GetSettingsClass().Create();
End;

Procedure TTSTOScriptTemplateHack.BeforeDestruction();
Begin
  FVariables := Nil;
  FSettings := Nil;

  InHerited BeforeDestruction();
End;

Function TTSTOScriptTemplateHack.GetVariablesClass() : TTSTOScriptTemplateVariablesClass;
Begin
  Result := TTSTOScriptTemplateVariables;
End;

Function TTSTOScriptTemplateHack.GetSettingsClass() : TTSTOScriptTemplateSettingsClass;
Begin
  Result := TTSTOScriptTemplateSettings;
End;

Procedure TTSTOScriptTemplateHack.Assign(ASource : IInterface);
Var lSrc : ITSTOScriptTemplateHack;
Begin
  If Supports(ASource, ITSTOScriptTemplateHack, lSrc) Then
  Begin
    FName         := lSrc.Name;
    FEnabled      := lSrc.Enabled;
    FVariables.Assign(lSrc.Variables);
    FSettings.Assign(lSrc.Settings);
    FTemplateFile := lSrc.TemplateFile;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TTSTOScriptTemplateHack.GetName() : WideString;
Begin
  Result := FName;
End;

Procedure TTSTOScriptTemplateHack.SetName(Const AName : WideString);
Begin
  FName := AName;
End;

Function TTSTOScriptTemplateHack.GetEnabled() : Boolean;
Begin
  Result := FEnabled;
End;

Procedure TTSTOScriptTemplateHack.SetEnabled(Const AEnabled : Boolean);
Begin
  FEnabled := AEnabled;
End;

Function TTSTOScriptTemplateHack.GetVariables() : ITSTOScriptTemplateVariables;
Begin
  Result := FVariables;
End;

Function TTSTOScriptTemplateHack.GetSettings() : ITSTOScriptTemplateSettings;
Begin
  Result := FSettings;
End;

Function TTSTOScriptTemplateHack.GetTemplateFile() : WideString;
Begin
  Result := FTemplateFile;
End;

Procedure TTSTOScriptTemplateHack.SetTemplateFile(Const ATemplateFile : WideString);
Begin
  FTemplateFile := ATemplateFile;
End;

Function TTSTOScriptTemplateHacks.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TTSTOScriptTemplateHack;
End;

Function TTSTOScriptTemplateHacks.Get(Index : Integer) : ITSTOScriptTemplateHack;
Begin
  Result := InHerited Items[Index] As ITSTOScriptTemplateHack;
End;

Procedure TTSTOScriptTemplateHacks.Put(Index : Integer; Const Item : ITSTOScriptTemplateHack);
Begin
  InHerited Items[Index] := Item;
End;

Function TTSTOScriptTemplateHacks.Add() : ITSTOScriptTemplateHack;
Begin
  Result := InHerited Add() As ITSTOScriptTemplateHack;
End;

Function TTSTOScriptTemplateHacks.Add(Const AItem : ITSTOScriptTemplateHack) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Function TTSTOScriptTemplateHacks.Remove(Const Item : ITSTOScriptTemplateHack) : Integer;
Begin
  Result := InHerited Remove(Item As IInterfaceEx);
End;

Procedure TTSTOScriptTemplateHacks.Assign(ASource : IInterface);
Var lSrc : ITSTOScriptTemplateHacks;
    X    : Integer;
Begin
  If Supports(ASource, ITSTOScriptTemplateHacks, lSrc) Then
  Begin
    Clear();

    For X := 0 To lSrc.Count - 1 Do
      Add().Assign(lSrc[X]);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

end.
