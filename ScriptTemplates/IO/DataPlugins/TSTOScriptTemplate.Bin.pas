unit TSTOScriptTemplate.Bin;

interface

Uses
  HsInterfaceEx, HsStreamEx, TSTOScriptTemplateIntf;

Type
  ITSTOBinScriptTemplateSettings = Interface(ITSTOScriptTemplateSettings)
    ['{4B61686E-29A0-2112-A0A8-92DB9761394B}']
    Procedure SaveToStream(AStream : IStreamEx);
    Procedure LoadFromStream(AStream : IStreamEx);

  End;

  ITSTOBinScriptTemplateVariable = Interface(ITSTOScriptTemplateVariable)
    ['{4B61686E-29A0-2112-B6DE-3B476318F477}']
    Procedure SaveToStream(AStream : IStreamEx);
    Procedure LoadFromStream(AStream : IStreamEx);

  End;

  ITSTOBinScriptTemplateVariables = Interface(ITSTOScriptTemplateVariables)
    ['{4B61686E-29A0-2112-9142-3838AD37507C}']
    Function  Get(Index : Integer) : ITSTOBinScriptTemplateVariable;
    Procedure Put(Index : Integer; Const Item : ITSTOBinScriptTemplateVariable);

    Function Add() : ITSTOBinScriptTemplateVariable; OverLoad;
    Function Add(Const AItem : ITSTOBinScriptTemplateVariable) : Integer; OverLoad;
    Function Remove(Const Item : ITSTOBinScriptTemplateVariable) : Integer;

    Procedure SaveToStream(AStream : IStreamEx);
    Procedure LoadFromStream(AStream : IStreamEx);

    Property Items[Index : Integer] : ITSTOBinScriptTemplateVariable Read Get Write Put; Default;

  End;

  ITSTOBinScriptTemplateHack = Interface(ITSTOScriptTemplateHack)
    ['{4B61686E-29A0-2112-BC63-FC47E1C8504C}']
    Function  GetVariables() : ITSTOBinScriptTemplateVariables;
    Function  GetSettings() : ITSTOBinScriptTemplateSettings;

    Procedure SaveToStream(AStream : IStreamEx);
    Procedure LoadFromStream(AStream : IStreamEx);

    Property Variables : ITSTOBinScriptTemplateVariables Read GetVariables;
    Property Settings  : ITSTOBinScriptTemplateSettings  Read GetSettings;

  End;

  ITSTOBinScriptTemplateHacks = Interface(ITSTOScriptTemplateHacks)
    ['{4B61686E-29A0-2112-99D6-9E9E4301C397}']
    Function  Get(Index : Integer) : ITSTOBinScriptTemplateHack;
    Procedure Put(Index : Integer; Const Item : ITSTOBinScriptTemplateHack);

    Function Add() : ITSTOBinScriptTemplateHack; OverLoad;
    Function Add(Const AItem : ITSTOBinScriptTemplateHack) : Integer; OverLoad;

    Function  Remove(Const Item : ITSTOBinScriptTemplateHack) : Integer;

    Procedure SaveToStream(AStream : IStreamEx);
    Procedure LoadFromStream(AStream : IStreamEx);

    Property Items[Index : Integer] : ITSTOBinScriptTemplateHack Read Get Write Put; Default;

  End;

  TTSTOBinScriptTemplateHacks = Class(TObject)
  Public
    Class Function CreateScriptTemplateHacks() : ITSTOBinScriptTemplateHacks; OverLoad;
    Class Function CreateScriptTemplateHacks(AStream : IStreamEx) : ITSTOBinScriptTemplateHacks; OverLoad;
    Class Function CreateScriptTemplateHacks(Const AFileName : String) : ITSTOBinScriptTemplateHacks; OverLoad;

  End;

implementation

Uses SysUtils, XmlDom, HsStringListEx, HsXmlDocEx, Dialogs,
  TSTOScriptTemplateImpl;

Type
  TTSTOBinScriptTemplateSettings = Class(TTSTOScriptTemplateSettings, ITSTOBinScriptTemplateSettings)
  Private Type
    TSettingType = ( stOutputFileName, stCategoryNamePrefix, stStoreItemsPath,
                     stRequirementPath, stStorePrefix );
  Private
    Procedure LoadFromStreamV001(AStream : IStreamEx);

  Protected
    Procedure LoadFromStream(AStream : IStreamEx);
    Procedure SaveToStream(AStream : IStreamEx);

  End;

  TTSTOBinScriptTemplateVariable = Class(TTSTOScriptTemplateVariable, ITSTOBinScriptTemplateVariable)
  Private
    Procedure LoadFromStreamV001(AStream : IStreamEx);

  Protected
    Procedure LoadFromStream(AStream : IStreamEx);
    Procedure SaveToStream(AStream : IStreamEx);

  End;

  TTSTOBinScriptTemplateVariables = Class(TTSTOScriptTemplateVariables, ITSTOBinScriptTemplateVariables)
  Private
    Procedure LoadFromStreamV001(AStream : IStreamEx);

  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;

    Function  Get(Index : Integer) : ITSTOBinScriptTemplateVariable; OverLoad;
    Procedure Put(Index : Integer; Const Item : ITSTOBinScriptTemplateVariable); OverLoad;

    Function Add() : ITSTOBinScriptTemplateVariable; ReIntroduce; OverLoad;
    Function Add(Const AItem : ITSTOBinScriptTemplateVariable) : Integer; ReIntroduce; OverLoad;
    Function Remove(Const Item : ITSTOBinScriptTemplateVariable) : Integer; OverLoad;

    Procedure LoadFromStream(AStream : IStreamEx);
    Procedure SaveToStream(AStream : IStreamEx);

  End;

  TTSTOBinScriptTemplateHack = Class(TTSTOScriptTemplateHack, ITSTOBinScriptTemplateHack)
  Private
    Procedure LoadFromStreamV001(AStream : IStreamEx);

  Protected
    Function  GetVariablesClass() : TTSTOScriptTemplateVariablesClass; OverRide;
    Function  GetSettingsClass() : TTSTOScriptTemplateSettingsClass; OverRide;

    Function  GetVariables() : ITSTOBinScriptTemplateVariables;
    Function  GetSettings() : ITSTOBinScriptTemplateSettings;

    Procedure LoadFromStream(AStream : IStreamEx);
    Procedure SaveToStream(AStream : IStreamEx);

    Property Variables : ITSTOBinScriptTemplateVariables Read GetVariables;
    Property Settings  : ITSTOBinScriptTemplateSettings  Read GetSettings;

  End;

  TTSTOBinScriptTemplateHacksImpl = Class(TTSTOScriptTemplateHacks, ITSTOBinScriptTemplateHacks)
  Private
    Procedure LoadFromStreamV001(AStream : IStreamEx);

  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;

    Function  Get(Index : Integer) : ITSTOBinScriptTemplateHack; OverLoad;
    Procedure Put(Index : Integer; Const Item : ITSTOBinScriptTemplateHack); OverLoad;

    Function Add() : ITSTOBinScriptTemplateHack; ReIntroduce; OverLoad;
    Function Add(Const AItem : ITSTOBinScriptTemplateHack) : Integer; ReIntroduce; OverLoad;
    Function Remove(Const Item : ITSTOBinScriptTemplateHack) : Integer; ReIntroduce; OverLoad;

    Procedure LoadFromStream(AStream : IStreamEx);
    Procedure SaveToStream(AStream : IStreamEx);

  End;

Class Function TTSTOBinScriptTemplateHacks.CreateScriptTemplateHacks() : ITSTOBinScriptTemplateHacks;
Begin
  Result := TTSTOBinScriptTemplateHacksImpl.Create();
End;

Class Function TTSTOBinScriptTemplateHacks.CreateScriptTemplateHacks(AStream : IStreamEx) : ITSTOBinScriptTemplateHacks;
Begin
  Result := TTSTOBinScriptTemplateHacksImpl.Create();
  Result.LoadFromStream(AStream);
End;

Class Function TTSTOBinScriptTemplateHacks.CreateScriptTemplateHacks(Const AFileName : String) : ITSTOBinScriptTemplateHacks;
Var lMemStrm : IMemoryStreamEx;
Begin
  lMemStrm := TMemoryStreamEx.Create();
  Try
    If FileExists(AFileName) Then
    Begin
      lMemStrm.LoadFromFile(AFileName);
      Result := CreateScriptTemplateHacks(lMemStrm);
    End
    Else
      Result := CreateScriptTemplateHacks();

    Finally
      lMemStrm := Nil;
  End;
End;

(******************************************************************************)

Procedure TTSTOBinScriptTemplateSettings.LoadFromStreamV001(AStream : IStreamEx);
Var lNbSettings : Integer;
    lSettingType : TSettingType;
Begin
  lNbSettings := AStream.ReadByte();
  While lNbSettings > 0 Do
  Begin
    Case TSettingType(AStream.ReadByte()) Of
      stOutputFileName : OutputFileName := AStream.ReadAnsiString();
      stCategoryNamePrefix : CategoryNamePrefix := AStream.ReadAnsiString();
      stStoreItemsPath : StoreItemsPath := AStream.ReadAnsiString();
      stRequirementPath : RequirementPath := AStream.ReadAnsiString();
      stStorePrefix : StorePrefix := AStream.ReadAnsiString();
    End;

    Dec(lNbSettings);
  End;
End;

Procedure TTSTOBinScriptTemplateSettings.LoadFromStream(AStream : IStreamEx);
Begin
  Case AStream.ReadByte() Of
    1 : LoadFromStreamV001(AStream);

    Else
      Raise Exception.Create('Invalid file version');
  End;
End;

Procedure TTSTOBinScriptTemplateSettings.SaveToStream(AStream : IStreamEx);
Const
  cStreamVersion = 1;

Var lNbSettings : Integer;
Begin
  AStream.WriteByte(cStreamVersion);

  lNbSettings := 0;
  If OutputFileName <> '' Then
    Inc(lNbSettings);

  If CategoryNamePrefix <> '' Then
    Inc(lNbSettings);

  If StoreItemsPath <> '' Then
    Inc(lNbSettings);

  If RequirementPath <> '' Then
    Inc(lNbSettings);

  If StorePrefix <> '' Then
    Inc(lNbSettings);

  AStream.WriteByte(lNbSettings);

  If OutputFileName <> '' Then
  Begin
    AStream.WriteByte(Ord(stOutputFileName));
    AStream.WriteAnsiString(OutputFileName);
  End;

  If CategoryNamePrefix <> '' Then
  Begin
    AStream.WriteByte(Ord(stCategoryNamePrefix));
    AStream.WriteAnsiString(CategoryNamePrefix);
  End;

  If StoreItemsPath <> '' Then
  Begin
    AStream.WriteByte(Ord(stStoreItemsPath));
    AStream.WriteAnsiString(StoreItemsPath);
  End;

  If RequirementPath <> '' Then
  Begin
    AStream.WriteByte(Ord(stRequirementPath));
    AStream.WriteAnsiString(RequirementPath);
  End;

  If StorePrefix <> '' Then
  Begin
    AStream.WriteByte(Ord(stStorePrefix));
    AStream.WriteAnsiString(StorePrefix);
  End;

End;

Procedure TTSTOBinScriptTemplateVariable.LoadFromStreamV001(AStream : IStreamEx);
Begin
  Name    := AStream.ReadAnsiString();
  VarFunc := AStream.ReadAnsiString();
End;

Procedure TTSTOBinScriptTemplateVariable.LoadFromStream(AStream : IStreamEx);
Begin
  Case AStream.ReadByte() Of
    1 : LoadFromStreamV001(AStream);

    Else
      Raise Exception.Create('Invalid file version');
  End;
End;

Procedure TTSTOBinScriptTemplateVariable.SaveToStream(AStream : IStreamEx);
Const
  cStreamVersion = 1;
Begin
  AStream.WriteByte(cStreamVersion);
  AStream.WriteAnsiString(Name);
  AStream.WriteAnsiString(VarFunc);
End;

Function TTSTOBinScriptTemplateVariables.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TTSTOBinScriptTemplateVariable;
End;

Function TTSTOBinScriptTemplateVariables.Get(Index : Integer) : ITSTOBinScriptTemplateVariable;
Begin
  Result := InHerited Items[Index] As ITSTOBinScriptTemplateVariable;
End;

Procedure TTSTOBinScriptTemplateVariables.Put(Index : Integer; Const Item : ITSTOBinScriptTemplateVariable);
Begin
  InHerited Items[Index] := Item;
End;

Function TTSTOBinScriptTemplateVariables.Add() : ITSTOBinScriptTemplateVariable;
Begin
  Result := InHerited Add() As ITSTOBinScriptTemplateVariable;
End;

Function TTSTOBinScriptTemplateVariables.Add(Const AItem : ITSTOBinScriptTemplateVariable) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Function TTSTOBinScriptTemplateVariables.Remove(Const Item : ITSTOBinScriptTemplateVariable) : Integer;
Begin
  Result := InHerited Remove(Item As IInterfaceEx);
End;

Procedure TTSTOBinScriptTemplateVariables.LoadFromStreamV001(AStream : IStreamEx);
Var X : Integer;
Begin
  Clear();

  X := AStream.ReadByte();
  While X > 0 Do
  Begin
    Add().LoadFromStream(AStream);
    Dec(X);
  End;
End;

Procedure TTSTOBinScriptTemplateVariables.LoadFromStream(AStream : IStreamEx);
Begin
  Case AStream.ReadByte() Of
    1 : LoadFromStreamV001(AStream);

    Else
      Raise Exception.Create('Invalid file version');
  End;
End;

Procedure TTSTOBinScriptTemplateVariables.SaveToStream(AStream : IStreamEx);
Const
  cStreamVersion = 1;

Var X : Integer;
Begin
  AStream.WriteByte(cStreamVersion);
  AStream.WriteByte(Count);

  For X := 0 To Count - 1 Do
    Get(X).SaveToStream(AStream);
End;

Function TTSTOBinScriptTemplateHack.GetVariablesClass() : TTSTOScriptTemplateVariablesClass;
Begin
  Result := TTSTOBinScriptTemplateVariables;
End;

Function TTSTOBinScriptTemplateHack.GetSettingsClass() : TTSTOScriptTemplateSettingsClass;
Begin
  Result := TTSTOBinScriptTemplateSettings;
End;

Function TTSTOBinScriptTemplateHack.GetVariables() : ITSTOBinScriptTemplateVariables;
Begin
  Result := InHerited GetVariables() As ITSTOBinScriptTemplateVariables;
End;

Function TTSTOBinScriptTemplateHack.GetSettings() : ITSTOBinScriptTemplateSettings;
Begin
  Result := InHerited GetSettings() As ITSTOBinScriptTemplateSettings;
End;

Procedure TTSTOBinScriptTemplateHack.LoadFromStreamV001(AStream : IStreamEx);
Var lLst : IHsStringListEx;
    X : Integer;
Begin
  Name := AStream.ReadAnsiString();
  Enabled := AStream.ReadBoolean();
  Variables.LoadFromStream(AStream);
  Settings.LoadFromStream(AStream);

  lLst := THsStringListEx.CreateList();
  Try
    X := AStream.ReadWord();
    While X > 0 Do
    Begin
      lLst.Add(AStream.ReadAnsiString(2, False));
      Dec(X);
    End;

    Try
      TemplateFile := FormatXmlData(lLst.Text);

      Except
        On E:EDOMParseError Do
          TemplateFile := lLst.Text
        Else
          Raise;
    End;

    Finally
      lLst := Nil;
  End;
End;

Procedure TTSTOBinScriptTemplateHack.LoadFromStream(AStream : IStreamEx);
Begin
  Case AStream.ReadByte() Of
    1 : LoadFromStreamV001(AStream);

    Else
      Raise Exception.Create('Invalid file version');
  End;
End;

Procedure TTSTOBinScriptTemplateHack.SaveToStream(AStream : IStreamEx);
Const
  cStreamVersion = 1;
Var lLst : IHsStringListEx;
    X : Integer;
Begin
  AStream.WriteByte(cStreamVersion);

  AStream.WriteAnsiString(Name);
  AStream.WriteBoolean(Enabled);
  Variables.SaveToStream(AStream);
  Settings.SaveToStream(AStream);

  lLst := THsStringListEx.CreateList();
  Try
    lLst.Text := TemplateFile;

    AStream.WriteWord(lLst.Count);
    For X := 0 To lLst.Count - 1 Do
      AStream.WriteAnsiString(Trim(AnsiString(lLst[X])), True, 2, False);

    Finally
      lLst := Nil;
  End;
End;

Function TTSTOBinScriptTemplateHacksImpl.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TTSTOBinScriptTemplateHack;
End;

Function TTSTOBinScriptTemplateHacksImpl.Get(Index : Integer) : ITSTOBinScriptTemplateHack;
Begin
  Result := InHerited Items[Index] As ITSTOBinScriptTemplateHack;
End;

Procedure TTSTOBinScriptTemplateHacksImpl.Put(Index : Integer; Const Item : ITSTOBinScriptTemplateHack);
Begin
  InHerited Items[Index] := Item;
End;

Function TTSTOBinScriptTemplateHacksImpl.Add() : ITSTOBinScriptTemplateHack;
Begin
  Result := InHerited Add() As ITSTOBinScriptTemplateHack;
End;

Function TTSTOBinScriptTemplateHacksImpl.Add(Const AItem : ITSTOBinScriptTemplateHack) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Function TTSTOBinScriptTemplateHacksImpl.Remove(Const Item : ITSTOBinScriptTemplateHack) : Integer;
Begin
  Result := InHerited Remove(Item As IInterfaceEx);
End;

Procedure TTSTOBinScriptTemplateHacksImpl.LoadFromStreamV001(AStream : IStreamEx);
Var lNbItem : Integer;
Begin
  Clear();
  lNbItem := AStream.ReadByte();

  While lNbItem > 0 Do
  Begin
    Add().LoadFromStream(AStream);
    Dec(lNbItem);
  End;
End;

Procedure TTSTOBinScriptTemplateHacksImpl.LoadFromStream(AStream : IStreamEx);
Begin
  Case AStream.ReadByte() Of
    1 : LoadFromStreamV001(AStream);

    Else
      Raise Exception.Create('Invalid file version');
  End;
End;

Procedure TTSTOBinScriptTemplateHacksImpl.SaveToStream(AStream : IStreamEx);
Const
  cStreamVersion = 1;
Var X : Integer;
Begin
  AStream.WriteByte(cStreamVersion);

  AStream.WriteByte(Count);
  For X := 0 To Count - 1 Do
    Get(X).SaveToStream(AStream);
End;

end.
