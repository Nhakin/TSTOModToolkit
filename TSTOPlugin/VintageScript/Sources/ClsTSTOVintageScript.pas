unit ClsTSTOVintageScript;

interface

Uses HsInterfaceEx;

Type
  TSTOVintageScriptType = (vstRGBFiles, vstSkinStore, vstFarm, vstOldMenu);
  TSTOVintageScriptTypes = Set Of TSTOVintageScriptType;
  
  ITSTOVintageScriptSettingItem = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-9E09-09475FC87BC6}']
    Function  GetEnabled() : Boolean;
    Procedure SetEnabled(Const AEnabled : Boolean);

    Function  GetAddInMenu() : Boolean;
    Procedure SetAddInMenu(Const AAddInMenu : Boolean);

    Function  GetAddInToolBar() : Boolean;
    Procedure SetAddInToolBar(Const AAddInToolBar : Boolean);

    Function  GetScriptType() : TSTOVintageScriptType;
    Procedure SetScriptType(Const AScriptType : TSTOVintageScriptType);

    Property Enabled      : Boolean               Read GetEnabled      Write SetEnabled;
    Property AddInMenu    : Boolean               Read GetAddInMenu    Write SetAddInMenu;
    Property AddInToolBar : Boolean               Read GetAddInToolBar Write SetAddInToolBar;
    Property ScriptType   : TSTOVintageScriptType Read GetScriptType   Write SetScriptType;

  End;

  ITSTOVintageScriptSettingItems = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-8C4D-0927958C927B}']
    Function  Get(Index : Integer) : ITSTOVintageScriptSettingItem;
    Procedure Put(Index : Integer; Const Item : ITSTOVintageScriptSettingItem);

    Function Add() : ITSTOVintageScriptSettingItem; OverLoad;
    Function Add(Const AItem : ITSTOVintageScriptSettingItem) : Integer; OverLoad;

    Property Items[Index : Integer] : ITSTOVintageScriptSettingItem Read Get Write Put; Default;

  End;

  ITSTOVintageScriptSetting = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-A3B7-15C1514DDD06}']
    Function  GetEnabled() : Boolean;
    Procedure SetEnabled(Const AEnabled : Boolean);

    Function  GetUseAppSetting() : Boolean;
    Procedure SetUseAppSetting(Const AUseAppSetting : Boolean);

    Function  GetHackMasterListFileName() : String;
    Procedure SetHackMasterListFileName(Const AHackMasterListFileName : String);

    Function  GetResourcePath() : String;
    Procedure SetResourcePath(Const AResourcePath : String);

    Function  GetStorePath() : String;
    Procedure SetStorePath(Const AStorePath : String);

    Function  GetScriptPath() : String;
    Procedure SetScriptPath(Const AScriptPath : String);

    Function  GetItems() : ITSTOVintageScriptSettingItems;

    Procedure LoadFromFile(Const AFileName : String);
    Procedure SaveToFile(Const AFileName : String);

    Procedure Assign(ASource : ITSTOVintageScriptSetting);

    Property Enabled                : Boolean Read GetEnabled                Write SetEnabled;
    Property UseAppSetting          : Boolean Read GetUseAppSetting          Write SetUseAppSetting;
    Property HackMasterListFileName : String  Read GetHackMasterListFileName Write SetHackMasterListFileName;
    Property ResourcePath           : String  Read GetResourcePath           Write SetResourcePath;
    Property StorePath              : String  Read GetStorePath              Write SetStorePath;
    Property ScriptPath             : String  Read GetScriptPath             Write SetScriptPath;

    Property Items : ITSTOVintageScriptSettingItems Read GetItems;

  End;

  TTSTOVintageScriptSetting = Class(TObject)
  Public
    Class Function CreateSettings() : ITSTOVintageScriptSetting;

  End;

implementation

Uses SysUtils, RTLConsts, HsIniFilesEx;

Type
  TTSTOVintageScriptSettingItem = Class(TInterfacedObjectEx, ITSTOVintageScriptSettingItem)
  Private
    FEnabled      : Boolean;
    FAddInMenu    : Boolean;
    FAddInToolBar : Boolean;
    FScriptType   : TSTOVintageScriptType;

  Protected
    Function  GetEnabled() : Boolean; 
    Procedure SetEnabled(Const AEnabled : Boolean); 

    Function  GetAddInMenu() : Boolean; 
    Procedure SetAddInMenu(Const AAddInMenu : Boolean); 

    Function  GetAddInToolBar() : Boolean; 
    Procedure SetAddInToolBar(Const AAddInToolBar : Boolean); 

    Function  GetScriptType() : TSTOVintageScriptType;
    Procedure SetScriptType(Const AScriptType : TSTOVintageScriptType);

  End;

  TTSTOVintageScriptSettingItems = Class(TInterfaceListEx, ITSTOVintageScriptSettingItems)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : ITSTOVintageScriptSettingItem; OverLoad;
    Procedure Put(Index : Integer; Const Item : ITSTOVintageScriptSettingItem); OverLoad;

    Function Add() : ITSTOVintageScriptSettingItem; ReIntroduce; OverLoad;
    Function Add(Const AItem : ITSTOVintageScriptSettingItem) : Integer; ReIntroduce; OverLoad;

  End;

  TTSTOVintageScriptSettingImpl = Class(TInterfacedObjectEx, ITSTOVintageScriptSetting)
  Private
    FEnabled                : Boolean;
    FUseAppSetting          : Boolean;
    FHackMasterListFileName : String;
    FResourcePath           : String;
    FStorePath              : String;
    FScriptPath             : String;

    FItems   : ITSTOVintageScriptSettingItems;

  Protected
    Function  GetEnabled() : Boolean;
    Procedure SetEnabled(Const AEnabled : Boolean);

    Function  GetUseAppSetting() : Boolean;
    Procedure SetUseAppSetting(Const AUseAppSetting : Boolean);

    Function  GetHackMasterListFileName() : String;
    Procedure SetHackMasterListFileName(Const AHackMasterListFileName : String);

    Function  GetResourcePath() : String;
    Procedure SetResourcePath(Const AResourcePath : String);

    Function  GetStorePath() : String;
    Procedure SetStorePath(Const AStorePath : String);

    Function  GetScriptPath() : String;
    Procedure SetScriptPath(Const AScriptPath : String);

    Function  GetItems() : ITSTOVintageScriptSettingItems;

    Procedure LoadFromFile(Const AFileName : String);
    Procedure SaveToFile(Const AFileName : String);

    Procedure Assign(ASource : ITSTOVintageScriptSetting);
    
  Public
    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;

  End;

Class Function TTSTOVintageScriptSetting.CreateSettings() : ITSTOVintageScriptSetting;
Begin
  Result := TTSTOVintageScriptSettingImpl.Create();
End;

(******************************************************************************)

Function TTSTOVintageScriptSettingItem.GetEnabled() : Boolean;
Begin
  Result := FEnabled;
End;

Procedure TTSTOVintageScriptSettingItem.SetEnabled(Const AEnabled : Boolean);
Begin
  FEnabled := AEnabled;
End;

Function TTSTOVintageScriptSettingItem.GetAddInMenu() : Boolean;
Begin
  Result := FAddInMenu;
End;

Procedure TTSTOVintageScriptSettingItem.SetAddInMenu(Const AAddInMenu : Boolean);
Begin
  FAddInMenu := AAddInMenu;
End;

Function TTSTOVintageScriptSettingItem.GetAddInToolBar() : Boolean;
Begin
  Result := FAddInToolBar;
End;

Procedure TTSTOVintageScriptSettingItem.SetAddInToolBar(Const AAddInToolBar : Boolean);
Begin
  FAddInToolBar := AAddInToolBar;
End;

Function TTSTOVintageScriptSettingItem.GetScriptType() : TSTOVintageScriptType;
Begin
  Result := FScriptType;
End;

Procedure TTSTOVintageScriptSettingItem.SetScriptType(Const AScriptType : TSTOVintageScriptType);
Begin
  FScriptType := AScriptType;
End;

Function TTSTOVintageScriptSettingItems.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TTSTOVintageScriptSettingItem;
End;

Function TTSTOVintageScriptSettingItems.Get(Index : Integer) : ITSTOVintageScriptSettingItem;
Begin
  Result := InHerited Items[Index] As ITSTOVintageScriptSettingItem;
End;

Procedure TTSTOVintageScriptSettingItems.Put(Index : Integer; Const Item : ITSTOVintageScriptSettingItem);
Begin
  InHerited Items[Index] := Item;
End;

Function TTSTOVintageScriptSettingItems.Add() : ITSTOVintageScriptSettingItem;
Begin
  Result := InHerited Add() As ITSTOVintageScriptSettingItem;
End;

Function TTSTOVintageScriptSettingItems.Add(Const AItem : ITSTOVintageScriptSettingItem) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Procedure TTSTOVintageScriptSettingImpl.AfterConstruction();
Begin
  InHerited AfterConstruction();

  FItems := TTSTOVintageScriptSettingItems.Create();
End;

Procedure TTSTOVintageScriptSettingImpl.BeforeDestruction();
Begin
  FItems := Nil;

  InHerited BeforeDestruction();
End;

Procedure TTSTOVintageScriptSettingImpl.Assign(ASource : ITSTOVintageScriptSetting);
Var lScripts : ITSTOVintageScriptSettingItems;
    X        : Integer;
Begin
  FEnabled                := ASource.Enabled;
  FUseAppSetting          := ASource.UseAppSetting;
  FHackMasterListFileName := ASource.HackMasterListFileName;
  FResourcePath           := ASource.ResourcePath;
  FStorePath              := ASource.StorePath;
  FScriptPath             := ASource.ScriptPath;

  lScripts := GetItems();
  lScripts.Clear();

  For X := 0 To ASource.Items.Count - 1 Do
    With lScripts.Add() Do
    Begin
      Enabled      := ASource.Items[X].Enabled;
      AddInMenu    := ASource.Items[X].AddInMenu;
      AddInToolBar := ASource.Items[X].AddInToolBar;
      ScriptType   := ASource.Items[X].ScriptType;
    End;
End;

Const
  cSectionName : Array[TSTOVintageScriptType] Of String = (
    'RGBFiles', 'SkinStore', 'Farm', 'OldMenu'
  );

Procedure TTSTOVintageScriptSettingImpl.LoadFromFile(Const AFileName : String);
Var lIni : IHsIniFileEx;
    lScripts : ITSTOVintageScriptSettingItems;
    X : Integer;
Begin
  FEnabled                := True;
  FUseAppSetting          := True;
  FHackMasterListFileName := 'Z:\Temp\TSTO\Bin\HackNew\NhakinHack.Src\HackMasterList.xml';
  FResourcePath           := 'Z:\Temp\TSTO\Bin\HackNew\NhakinHack.Src\GameScript.src\3.src\';
  FStorePath              := 'Z:\Temp\TSTO\Bin\HackNew\NhakinHack.Src\GameScripts.src\2.src\';
  FScriptPath             := 'Z:\Temp\TSTO\Bin\HackNew\4_14_Terwilligers_Patch3_PostLaunch_PCH4G4DL5LB0\gamescripts-r202094-EKXHLFAI\0';

  lScripts := GetItems();

  With lScripts.Add() Do
  Begin
    Enabled      := True;
    AddInMenu    := True;
    AddInToolBar := False;
    ScriptType   := vstRGBFiles;
  End;

  With lScripts.Add() Do
  Begin
    Enabled      := True;
    AddInMenu    := True;
    AddInToolBar := False;
    ScriptType   := vstSkinStore;
  End;

  With lScripts.Add() Do
  Begin
    Enabled      := True;
    AddInMenu    := True;
    AddInToolBar := False;
    ScriptType   := vstFarm;
  End;

  With lScripts.Add() Do
  Begin
    Enabled      := True;
    AddInMenu    := True;
    AddInToolBar := False;
    ScriptType   := vstOldMenu;
  End;

  If FileExists(AFileName) Then
  Begin
    lIni := THsIniFileEx.CreateIniFile(AFileName);
    Try
      FEnabled                := lIni.ReadBool('TSOVintagePlugin', 'Enabled', True);
      FUseAppSetting          := lIni.ReadBool('TSOVintagePlugin', 'UseAppSetting', True);
      FHackMasterListFileName := lIni.ReadString('TSOVintagePlugin', 'HackMasterListFileName', 'Z:\Temp\TSTO\Bin\HackNew\NhakinHack.Src\HackMasterList.xml');
      FResourcePath           := lIni.ReadString('TSOVintagePlugin', 'ResourcePath', 'Z:\Temp\TSTO\Bin\HackNew\NhakinHack.Src\GameScript.src\3.src\');
      FStorePath              := lIni.ReadString('TSOVintagePlugin', 'StorePath', 'Z:\Temp\TSTO\Bin\HackNew\NhakinHack.Src\GameScript.src\2.src\');
      FScriptPath             := lIni.ReadString('TSOVintagePlugin', 'ScriptPath', 'Z:\Temp\TSTO\Bin\HackNew\4_14_Terwilligers_Patch3_PostLaunch_PCH4G4DL5LB0\gamescripts-r202094-EKXHLFAI\0\');

      For X := 0 To lScripts.Count - 1 Do
      Begin
        lScripts[X].Enabled      := lIni.ReadBool(cSectionName[lScripts[X].ScriptType], 'Enabled', True);
        lScripts[X].AddInMenu    := lIni.ReadBool(cSectionName[lScripts[X].ScriptType], 'AddInMenu', True);
        lScripts[X].AddInToolBar := lIni.ReadBool(cSectionName[lScripts[X].ScriptType], 'AddInToolBar', False);
      End;

      Finally
        lIni := Nil;
    End;
  End;
End;

Procedure TTSTOVintageScriptSettingImpl.SaveToFile(Const AFileName : String);
Var lIni : IHsIniFileEx;
    lScripts : ITSTOVintageScriptSettingItems;
    X : Integer;
Begin
  lScripts := GetItems();

  lIni := THsIniFileEx.CreateIniFile(AFileName);
  Try
    lIni.WriteBool('TSOVintagePlugin', 'Enabled', FEnabled);
    lIni.WriteBool('TSOVintagePlugin', 'UseAppSetting', FUseAppSetting);
    lIni.WriteString('TSOVintagePlugin', 'HackMasterListFileName', FHackMasterListFileName);
    lIni.WriteString('TSOVintagePlugin', 'ResourcePath', FResourcePath);
    lIni.WriteString('TSOVintagePlugin', 'StorePath', FStorePath);
    lIni.WriteString('TSOVintagePlugin', 'ScriptPath', FScriptPath);

    For X := 0 To lScripts.Count - 1 Do
    Begin
      lIni.WriteBool(cSectionName[lScripts[X].ScriptType], 'Enabled', lScripts[X].Enabled);
      lIni.WriteBool(cSectionName[lScripts[X].ScriptType], 'AddInMenu', lScripts[X].AddInMenu);
      lIni.WriteBool(cSectionName[lScripts[X].ScriptType], 'AddInToolBar', lScripts[X].AddInToolBar);
    End;

    Finally
      lIni := Nil;
  End;
End;

Function TTSTOVintageScriptSettingImpl.GetEnabled() : Boolean;
Begin
  Result := FEnabled;
End;

Procedure TTSTOVintageScriptSettingImpl.SetEnabled(Const AEnabled : Boolean);
Begin
  FEnabled := AEnabled;
End;

Function  TTSTOVintageScriptSettingImpl.GetUseAppSetting() : Boolean;
Begin
  Result := FUseAppSetting;
End;

Procedure TTSTOVintageScriptSettingImpl.SetUseAppSetting(Const AUseAppSetting : Boolean);
Begin
  FUseAppSetting := AUseAppSetting;
End;

Function  TTSTOVintageScriptSettingImpl.GetHackMasterListFileName() : String;
Begin
  Result := FHackMasterListFileName;
End;

Procedure TTSTOVintageScriptSettingImpl.SetHackMasterListFileName(Const AHackMasterListFileName : String);
Begin
  FHackMasterListFileName := AHackMasterListFileName;
End;

Function  TTSTOVintageScriptSettingImpl.GetResourcePath() : String;
Begin
  Result := FResourcePath;
End;

Procedure TTSTOVintageScriptSettingImpl.SetResourcePath(Const AResourcePath : String);
Begin
  FResourcePath := AResourcePath;
End;

Function  TTSTOVintageScriptSettingImpl.GetStorePath() : String;
Begin
  Result := FStorePath;
End;

Procedure TTSTOVintageScriptSettingImpl.SetStorePath(Const AStorePath : String);
Begin
  FStorePath := AStorePath;
End;

Function  TTSTOVintageScriptSettingImpl.GetScriptPath() : String;
Begin
  Result := FScriptPath;
End;

Procedure TTSTOVintageScriptSettingImpl.SetScriptPath(Const AScriptPath : String);
Begin
  FScriptPath := AScriptPath;
End;

Function TTSTOVintageScriptSettingImpl.GetItems() : ITSTOVintageScriptSettingItems;
Begin
  Result := FItems;
End;

end.
