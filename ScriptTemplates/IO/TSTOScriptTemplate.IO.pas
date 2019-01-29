unit TSTOScriptTemplate.IO;

interface

Uses Classes, HsStreamEx, RgbExtractProgress,
  TSTOScriptTemplateIntf, TSTOHackMasterList.IO;

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

  TTSTOScriptTemplateHacksIO = Class(TObject)
  Public
    Class Function CreateScriptTemplateHacks() : ITSTOScriptTemplateHacksIO; OverLoad;
    Class Function CreateScriptTemplateHacks(Const AFileName : String) : ITSTOScriptTemplateHacksIO; OverLoad;

  End;

implementation

Uses Forms, Dialogs,
  SysUtils, HsXmlDocEx, HsInterfaceEx, HsStringListEx,
  TSTOScriptTemplateImpl, TSTOScriptTemplate.Xml, TSTOScriptTemplate.Bin;

Type
  TTSTOScriptTemplateSettingsIO = Class(TTSTOScriptTemplateSettings, ITSTOScriptTemplateSettingsIO)
  Private
    FOnChanged : TNotifyEvent;

  Protected
    Procedure SetOutputFileName(Const AOutputFileName : WideString); OverRide;
    Procedure SetCategoryNamePrefix(Const ACategoryNamePrefix : WideString); OverRide;
    Procedure SetStoreItemsPath(Const AStoreItemsPath : WideString); OverRide;
    Procedure SetRequirementPath(Const ARequirementPath : WideString); OverRide;
    Procedure SetStorePrefix(Const AStorePrefix : WideString); OverRide;

    Function  GetOnChanged() : TNotifyEvent;
    Procedure SetOnChanged(AOnChanged : TNotifyEvent);

  End;

  TTSTOScriptTemplateVariableIO = Class(TTSTOScriptTemplateVariable, ITSTOScriptTemplateVariableIO)
  Private
    FOnChanged : TNotifyEvent;

  Protected
    Procedure SetName(Const AName : WideString); OverRide;
    Procedure SetFunction(Const AFunction : WideString); OverRide;

    Function  GetOnChanged() : TNotifyEvent;
    Procedure SetOnChanged(AOnChanged : TNotifyEvent);

  End;

  TTSTOScriptTemplateVariablesIO = Class(TTSTOScriptTemplateVariables, ITSTOScriptTemplateVariablesIO)
  Private
    FOnChanged : TNotifyEvent;

  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;

    Function  Get(Index : Integer) : ITSTOScriptTemplateVariableIO; OverLoad;
    Procedure Put(Index : Integer; Const Item : ITSTOScriptTemplateVariableIO); OverLoad;

    Procedure DoOnChanged(Sender : TObject);
    Function  GetOnChanged() : TNotifyEvent;
    Procedure SetOnChanged(AOnChanged : TNotifyEvent);

    Function Add() : ITSTOScriptTemplateVariableIO; OverLoad;
    Function Add(Const AItem : ITSTOScriptTemplateVariableIO) : Integer; OverLoad;

    Function Remove(Const Item : ITSTOScriptTemplateVariableIO) : Integer;

    Procedure Assign(ASource : IInterface); OverRide;

  End;

  TTSTOScriptTemplateHackIO = Class(TTSTOScriptTemplateHack, ITSTOScriptTemplateHackIO)
  Private
    FOnChanged : TNotifyEvent;

  Protected
    Function GetVariablesClass() : TTSTOScriptTemplateVariablesClass; OverRide;
    Function GetSettingsClass() : TTSTOScriptTemplateSettingsClass; OverRide;

    Function GetVariables() : ITSTOScriptTemplateVariablesIO; OverLoad;
    Function GetSettings() : ITSTOScriptTemplateSettingsIO; OverLoad;

    Procedure SetName(Const AName : WideString); OverRide;
    Procedure SetEnabled(Const AEnabled : Boolean); OverRide;
    Procedure SetTemplateFile(Const ATemplateFile : WideString); OverRide;

    Procedure DoOnChanged(Sender : TObject);
    Function  GetOnChanged() : TNotifyEvent;
    Procedure SetOnChanged(AOnChanged : TNotifyEvent);

    Function GenenrateScript(AHackMasterList : ITSTOHackMasterListIO; AProgress : IRgbProgress = Nil) : String;

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TTSTOScriptTemplateHacksIOImpl = Class(TTSTOScriptTemplateHacks, ITSTOScriptTemplateHacksIO,
    {ITSTOBinScriptTemplateHacks,} ITSTOXmlScriptTemplateHacks)
  Private
    FBinImpl   : ITSTOBinScriptTemplateHacks;
    FXmlImpl   : ITSTOXmlScriptTemplateHacks;
    FFileName  : String;
    FOnChanged : TNotifyEvent;
    FModified  : Boolean;

    Function GetBinImpl() : ITSTOBinScriptTemplateHacks;
    Function GetXmlImpl() : ITSTOXmlScriptTemplateHacks;

  Protected
//    Property BinImpl : ITSTOBinScriptTemplateHacks Read GetBinImpl Implements ITSTOBinScriptTemplateHacks;
    Property XmlImpl : ITSTOXmlScriptTemplateHacks Read GetXmlImpl Implements ITSTOXmlScriptTemplateHacks;

    Function GetItemClass() : TInterfacedObjectExClass; OverRide;

    Function  Get(Index : Integer) : ITSTOScriptTemplateHackIO; OverLoad;
    Procedure Put(Index : Integer; Const Item : ITSTOScriptTemplateHackIO); OverLoad;

    Function  GetAsXml() : String;
    Procedure SetAsXml(Const AXml : String);

    Function GetFileName() : String;

    Function GetModified() : Boolean;

    Procedure DoOnChanged(Sender : TObject);
    Function  GetOnChanged() : TNotifyEvent;
    Procedure SetOnChanged(AOnChanged : TNotifyEvent);

    Function Add() : ITSTOScriptTemplateHackIO; OverLoad;
    Function Add(Const AItem : ITSTOScriptTemplateHackIO) : Integer; OverLoad;
    Function Remove(Const Item : ITSTOScriptTemplateHackIO) : Integer;

    Procedure Assign(ASource : IInterface); OverRide;

    Procedure LoadFromXml(Const AXmlString : String);

    Procedure LoadFromStream(AStream : IStreamEx);
    Procedure LoadFromFile(Const AFileName : String);

    Procedure SaveToStream(AStream : IStreamEx);
    Procedure SaveToFile(Const AFileName : String);

    Procedure GenerateScripts(AHackMasterList : ITSTOHackMasterListIO);

  Public
    Procedure AfterConstruction(); OverRide;

  End;

Class Function TTSTOScriptTemplateHacksIO.CreateScriptTemplateHacks() : ITSTOScriptTemplateHacksIO;
Begin
  Result := TTSTOScriptTemplateHacksIOImpl.Create();
End;

Class Function TTSTOScriptTemplateHacksIO.CreateScriptTemplateHacks(Const AFileName : String) : ITSTOScriptTemplateHacksIO;
Begin
  Result := TTSTOScriptTemplateHacksIOImpl.Create();
  Result.LoadFromFile(AFileName);
End;

(******************************************************************************)

Procedure TTSTOScriptTemplateSettingsIO.SetOutputFileName(Const AOutputFileName : WideString);
Begin
  If GetOutputFileName() <> AOutputFileName Then
  Begin
    InHerited SetOutputFileName(AOutputFileName);

    If Assigned(FOnChanged) Then
      FOnChanged(Self);
  End;
End;

Procedure TTSTOScriptTemplateSettingsIO.SetCategoryNamePrefix(Const ACategoryNamePrefix : WideString);
Begin
  If GetCategoryNamePrefix() <> ACategoryNamePrefix Then
  Begin
    InHerited SetCategoryNamePrefix(ACategoryNamePrefix);

    If Assigned(FOnChanged) Then
      FOnChanged(Self);
  End;
End;

Procedure TTSTOScriptTemplateSettingsIO.SetStoreItemsPath(Const AStoreItemsPath : WideString);
Begin
  If GetStoreItemsPath() <> AStoreItemsPath Then
  Begin
    InHerited SetStoreItemsPath(AStoreItemsPath);

    If Assigned(FOnChanged) Then
      FOnChanged(Self);
  End;
End;

Procedure TTSTOScriptTemplateSettingsIO.SetRequirementPath(Const ARequirementPath : WideString);
Begin
  If GetRequirementPath() <> ARequirementPath Then
  Begin
    InHerited SetRequirementPath(ARequirementPath);

    If Assigned(FOnChanged) Then
      FOnChanged(Self);
  End;
End;

Procedure TTSTOScriptTemplateSettingsIO.SetStorePrefix(Const AStorePrefix : WideString);
Begin
  If GetStorePrefix() <> AStorePrefix Then
  Begin
    InHerited SetStorePrefix(AStorePrefix);

    If Assigned(FOnChanged) Then
      FOnChanged(Self);
  End;
End;

Function  TTSTOScriptTemplateSettingsIO.GetOnChanged() : TNotifyEvent;
Begin
  Result := FOnChanged;
End;

Procedure TTSTOScriptTemplateSettingsIO.SetOnChanged(AOnChanged : TNotifyEvent);
Begin
  FOnChanged := AOnChanged;
End;

Procedure TTSTOScriptTemplateVariableIO.SetName(Const AName : WideString);
Begin
  If GetName() <> AName Then
  Begin
    InHerited SetName(AName);

    If Assigned(FOnChanged) Then
      FOnChanged(Self);
  End;
End;

Procedure TTSTOScriptTemplateVariableIO.SetFunction(Const AFunction : WideString);
Begin
  If GetFunction() <> AFunction Then
  Begin
    InHerited SetFunction(AFunction);

    If Assigned(FOnChanged) Then
      FOnChanged(Self);
  End;
End;

Function TTSTOScriptTemplateVariableIO.GetOnChanged() : TNotifyEvent;
Begin
  Result := FOnChanged;
End;

Procedure TTSTOScriptTemplateVariableIO.SetOnChanged(AOnChanged : TNotifyEvent);
Begin
  FOnChanged := AOnChanged;
End;

Procedure TTSTOScriptTemplateVariablesIO.Assign(ASource : IInterface);
Var X : Integer;
Begin
  InHerited Assign(ASource);

  For X := 0 To Count - 1 Do
    Get(X).OnChanged := DoOnChanged;
End;

Function TTSTOScriptTemplateVariablesIO.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TTSTOScriptTemplateVariableIO;
End;

Function TTSTOScriptTemplateVariablesIO.Get(Index : Integer) : ITSTOScriptTemplateVariableIO;
Begin
  Result := InHerited Get(Index) As ITSTOScriptTemplateVariableIO;
End;

Procedure TTSTOScriptTemplateVariablesIO.Put(Index : Integer; Const Item : ITSTOScriptTemplateVariableIO);
Begin
  InHerited Put(Index, Item);
End;

Procedure TTSTOScriptTemplateVariablesIO.DoOnChanged(Sender : TObject);
Begin
  If Assigned(FOnChanged) Then
    FOnChanged(Sender);
End;

Function TTSTOScriptTemplateVariablesIO.GetOnChanged() : TNotifyEvent;
Begin
  Result := FOnChanged;
End;

Procedure TTSTOScriptTemplateVariablesIO.SetOnChanged(AOnChanged : TNotifyEvent);
Begin
  FOnChanged := AOnChanged;
End;

Function TTSTOScriptTemplateVariablesIO.Add() : ITSTOScriptTemplateVariableIO;
Begin
  Result := InHerited Add() As ITSTOScriptTemplateVariableIO;
  Result.OnChanged := DoOnChanged;
End;

Function TTSTOScriptTemplateVariablesIO.Add(Const AItem : ITSTOScriptTemplateVariableIO) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Function TTSTOScriptTemplateVariablesIO.Remove(Const Item : ITSTOScriptTemplateVariableIO) : Integer;
Begin
  Result := InHerited Remove(Item As ITSTOScriptTemplateVariableIO);
End;

Procedure TTSTOScriptTemplateHackIO.AfterConstruction();
Begin
  InHerited AfterConstruction();

  GetVariables().OnChanged := DoOnChanged;
  GetSettings().OnChanged := DoOnChanged;
End;

Function TTSTOScriptTemplateHackIO.GetVariablesClass() : TTSTOScriptTemplateVariablesClass;
Begin
  Result := TTSTOScriptTemplateVariablesIO;
End;

Function TTSTOScriptTemplateHackIO.GetSettingsClass() : TTSTOScriptTemplateSettingsClass;
Begin
  Result := TTSTOScriptTemplateSettingsIO;
End;

Procedure TTSTOScriptTemplateHackIO.SetName(Const AName : WideString);
Begin
  If GetName() <> AName Then
  Begin
    InHerited SetName(AName);

    If Assigned(FOnChanged) Then
      FOnChanged(Self);
  End;
End;

Procedure TTSTOScriptTemplateHackIO.SetEnabled(Const AEnabled : Boolean);
Begin
  If GetEnabled() <> AEnabled Then
  Begin
    InHerited SetEnabled(AEnabled);

    If Assigned(FOnChanged) Then
      FOnChanged(Self);
  End;
End;

Procedure TTSTOScriptTemplateHackIO.SetTemplateFile(Const ATemplateFile : WideString);
Begin
  If GetTemplateFile() <> ATemplateFile Then
  Begin
    InHerited SetTemplateFile(ATemplateFile);

    If Assigned(FOnChanged) Then
      FOnChanged(Self);
  End;
End;

Function TTSTOScriptTemplateHackIO.GetVariables() : ITSTOScriptTemplateVariablesIO;
Begin
  Result := InHerited GetVariables() As ITSTOScriptTemplateVariablesIO;
End;

Function TTSTOScriptTemplateHackIO.GetSettings() : ITSTOScriptTemplateSettingsIO;
Begin
  Result := InHerited GetSettings() As ITSTOScriptTemplateSettingsIO;
End;

Procedure TTSTOScriptTemplateHackIO.DoOnChanged(Sender : TObject);
Begin
  If Assigned(FOnChanged) Then
    FOnChanged(Sender);
End;

Function TTSTOScriptTemplateHackIO.GetOnChanged() : TNotifyEvent;
Begin
  Result := FOnChanged;
End;

Procedure TTSTOScriptTemplateHackIO.SetOnChanged(AOnChanged : TNotifyEvent);
Begin
  FOnChanged := AOnChanged;
End;

Function TTSTOScriptTemplateHackIO.GenenrateScript(AHackMasterList : ITSTOHackMasterListIO; AProgress : IRgbProgress = Nil) : String;
Var lLst : IHsStringListEx;
    lVar : IHsStringListEx;
    lVars : ITSTOScriptTemplateVariablesIO;
    lSettings : ITSTOScriptTemplateSettingsIO;
    X    : Integer;
Begin
  lLst := THsStringListEx.CreateList();
  lVar := THsStringListEx.CreateList();
  Try
    lVars := GetVariables();
    lSettings := GetSettings();

    lLst.Text := GetTemplateFile();
    For X := 0 To lVars.Count - 1 Do
    Begin
      lVar.Text := '';

      If SameText(lVars[X].VarFunc, 'hmBuildStoreMenu') Then
        lVar.Text := AHackMasterList.BuildStoreMenu(lSettings, AProgress)
      Else If SameText(lVars[X].VarFunc, 'hmBuildInventoryMenu') Then
        lVar.Text := AHackMasterList.BuildInventoryMenu(lSettings, AProgress)
      Else If SameText(lVars[X].VarFunc, 'hmBuildStoreItems') Then
        lVar.Text := AHackMasterList.BuildStoreItems(lSettings, AProgress)
      Else If SameText(lVars[X].VarFunc, 'hmBuildStoreReqs') Then
        lVar.Text := AHackMasterList.BuildStoreRequirements(AProgress)
      Else If SameText(lVars[X].VarFunc, 'hmBuildDeleteBadItems') Then
        lVar.Text := AHackMasterList.BuildDeleteBadItems(AProgress)
      Else If SameText(lVars[X].VarFunc, 'hmBuildFreeItems') Then
        lVar.Text := AHackMasterList.BuildFreeItems(AProgress)
      Else If SameText(lVars[X].VarFunc, 'hmBuildUniqueItems') Then
        lVar.Text := AHackMasterList.BuildUniqueItems(AProgress)
      Else If SameText(lVars[X].VarFunc, 'hmBuildReqsItems') Then
        lVar.Text := AHackMasterList.BuildReqsItems(AProgress)
      Else If SameText(lVars[X].VarFunc, 'hmBuildNonSellableItems') Then
        lVar.Text := AHackMasterList.BuildNonSellableItems(AProgress);

      lLst.Text := StringReplace(lLst.Text, lVars[X].Name, lVar.Text, [rfReplaceAll, rfIgnoreCase]);
    End;

    Result := FormatXmlData(lLst.Text);

    Finally
      lLst := Nil;
      lVar := Nil;
  End;
End;

Procedure TTSTOScriptTemplateHacksIOImpl.AfterConstruction();
Begin
  InHerited AfterConstruction();

  FModified := False;
End;

Function TTSTOScriptTemplateHacksIOImpl.GetBinImpl() : ITSTOBinScriptTemplateHacks;
Begin
  FBinImpl := TTSTOBinScriptTemplateHacks.CreateScriptTemplateHacks();
  FBinImpl.Assign(Self);

  Result := FBinImpl;
End;

Function TTSTOScriptTemplateHacksIOImpl.GetXmlImpl() : ITSTOXmlScriptTemplateHacks;
Begin
  FXmlImpl := TTSTOXmlScriptTemplateHacks.CreateScriptTemplateHacks();
  FXmlImpl.Assign(Self);

  Result := FXmlImpl;
End;

Function TTSTOScriptTemplateHacksIOImpl.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TTSTOScriptTemplateHackIO;
End;

Function TTSTOScriptTemplateHacksIOImpl.Get(Index : Integer) : ITSTOScriptTemplateHackIO;
Begin
  Result := InHerited Get(Index) As ITSTOScriptTemplateHackIO;
End;

Procedure TTSTOScriptTemplateHacksIOImpl.Put(Index : Integer; Const Item : ITSTOScriptTemplateHackIO);
Begin
  InHerited Put(Index, Item);
End;

Function TTSTOScriptTemplateHacksIOImpl.Add() : ITSTOScriptTemplateHackIO;
Begin
  Result := InHerited Add() As ITSTOScriptTemplateHackIO;
  Result.OnChanged := DoOnChanged;
End;

Function TTSTOScriptTemplateHacksIOImpl.Add(Const AItem : ITSTOScriptTemplateHackIO) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Function TTSTOScriptTemplateHacksIOImpl.Remove(Const Item : ITSTOScriptTemplateHackIO) : Integer;
Begin
  Result := InHerited Remove(Item As IInterfaceEx);
End;

Procedure TTSTOScriptTemplateHacksIOImpl.Assign(ASource : IInterface);
Var X : Integer;
Begin
  InHerited Assign(ASource);

  For X := 0 To Count - 1 Do
    Get(X).OnChanged := DoOnChanged;
End;

Function TTSTOScriptTemplateHacksIOImpl.GetAsXml() : String;
Begin
  Result := FormatXmlData(XmlImpl.Xml);
End;

Procedure TTSTOScriptTemplateHacksIOImpl.SetAsXml(Const AXml : String);
Begin
  Assign(TTSTOXmlScriptTemplateHacks.CreateScriptTemplateHacks(AXml));
End;

Function TTSTOScriptTemplateHacksIOImpl.GetFileName() : String;
Begin
  Result := FFileName;
End;

Function TTSTOScriptTemplateHacksIOImpl.GetModified() : Boolean;
Begin
  Result := FModified;
End;

Procedure TTSTOScriptTemplateHacksIOImpl.DoOnChanged(Sender : TObject);
Begin
  If Assigned(FOnChanged) Then
    FOnChanged(Sender);

  FModified := True;
End;

Function TTSTOScriptTemplateHacksIOImpl.GetOnChanged() : TNotifyEvent;
Begin
  Result := FOnChanged;
End;

Procedure TTSTOScriptTemplateHacksIOImpl.SetOnChanged(AOnChanged : TNotifyEvent);
Begin
  FOnChanged := AOnChanged;
End;

Procedure TTSTOScriptTemplateHacksIOImpl.LoadFromXml(Const AXmlString : String);
Begin
  SetAsXml(AXmlString);
End;

Procedure TTSTOScriptTemplateHacksIOImpl.LoadFromStream(AStream : IStreamEx);
Var lHacks : ITSTOBinScriptTemplateHacks;
Begin
  lHacks := TTSTOBinScriptTemplateHacks.CreateScriptTemplateHacks();
  lHacks.LoadFromStream(AStream);
  Assign(lHacks);
End;

Procedure TTSTOScriptTemplateHacksIOImpl.LoadFromFile(Const AFileName : String);
Var lMemStrm : IMemoryStreamEx;
Begin
  If FileExists(AFileName) Then
  Begin
    FFileName := AFileName;

    If SameText(ExtractFileExt(AFileName), '.xml') Then
      With TStringList.Create() Do
      Try
        LoadFromFile(AFileName);
        SetAsXml(Text);

        Finally
          Free();
      End
    Else
    Begin
      lMemStrm := TMemoryStreamEx.Create();
      Try
        lMemStrm.LoadFromFile(AFileName);
        LoadFromStream(lMemStrm);

        Finally
          lMemStrm := Nil;
      End;
    End;
  End;
End;

Procedure TTSTOScriptTemplateHacksIOImpl.SaveToStream(AStream : IStreamEx);
Var lHacks : ITSTOBinScriptTemplateHacks;
Begin
  lHacks := TTSTOBinScriptTemplateHacks.CreateScriptTemplateHacks();
  lHacks.Assign(Self);
  lHacks.SaveToStream(AStream);

  FModified := False;
End;

Procedure TTSTOScriptTemplateHacksIOImpl.SaveToFile(Const AFileName : String);
Begin
  With TStringList.Create() Do
  Try
    Text := GetAsXml();
    SaveToFile(AFileName);
    FModified := False;

    Finally
      Free();
  End;
End;

Procedure TTSTOScriptTemplateHacksIOImpl.GenerateScripts(AHackMasterList : ITSTOHackMasterListIO);
Var X : Integer;
    lLst : IHsStringListEx;
    lItem : ITSTOScriptTemplateHackIO;
    lNbScripts : Integer;
    lProgress : IRgbProgress;
Begin
  lNbScripts := 0;
  For X := 0 To Count - 1 Do
    If Get(X).Enabled Then
      Inc(lNbScripts);

  If lNbScripts > 0 Then
  Begin
    lLst := THsStringListEx.CreateList();
    lProgress := TRgbProgress.CreateRgbProgress();
    Try
      lProgress.Show();

      For X := 0 To Count - 1 Do
      Begin
        lItem := Get(X);

        If lItem.Enabled Then
        Begin
          lProgress.CurOperation := lItem.Name;
          lProgress.ItemProgress := Round((X + 1) / lNbScripts * 100);
          Application.ProcessMessages();

          lLst.Text := lItem.GenenrateScript(AHackMasterList, lProgress);
          lLst.SaveToFile(lItem.Settings.OutputFileName);
        End;
      End;

      Finally
        lLst := Nil;
        lProgress := Nil;
    End;
  End;
End;

end.
