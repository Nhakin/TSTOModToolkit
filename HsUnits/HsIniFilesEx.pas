Unit HsIniFilesEx;

Interface

Uses Classes, IniFiles, HsInterfaceEx, HsStreamEx, HsStringListEx;

Type
  IHsIniFileEx = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-AA6B-9166E9EDB3C5}']
    Function  GetFileName() : String;
    Procedure SetFileName(Const AFileName : String);

    Function  ReadString(Const Section, Ident, Default : String) : String;
    Procedure WriteString(Const Section, Ident, Value : String);
    Function  ReadInteger(Const Section, Ident : String; Default : Longint) : Longint;
    Procedure WriteInteger(Const Section, Ident : String; Value : Longint);
    Function  ReadBool(Const Section, Ident : String; Default : Boolean) : Boolean;
    Procedure WriteBool(Const Section, Ident : String; Value : Boolean);
    Function  ReadBinaryStream(Const Section, Name : String; Value : TStream) : Integer; OverLoad;
    Function  ReadBinaryStream(Const Section, Name : String; Value : IStreamEx) : Integer; OverLoad;
    Procedure WriteBinaryStream(Const Section, Name : String; Value : TStream); OverLoad;
    Procedure WriteBinaryStream(Const Section, Name : String; Value : IStreamEx); OverLoad;
    Function  ReadDate(Const Section, Name : String; Default : TDateTime) : TDateTime;
    Procedure WriteDate(Const Section, Name : String; Value : TDateTime);
    Function  ReadDateTime(Const Section, Name : String; Default : TDateTime) : TDateTime;
    Procedure WriteDateTime(Const Section, Name : String; Value : TDateTime);
    Function  ReadFloat(Const Section, Name : String; Default : Double) : Double;
    Procedure WriteFloat(Const Section, Name : String; Value : Double);
    Function  ReadTime(Const Section, Name : String; Default : TDateTime) : TDateTime;
    Procedure WriteTime(Const Section, Name : String; Value : TDateTime);

    Function  SectionExists(Const Section : String) : Boolean;
    Procedure ReadSection(Const Section : String; Strings : TStrings); OverLoad;
    Procedure ReadSection(Const Section : String; Strings : IHsStringListEx); OverLoad;
    Procedure ReadSections(Strings : TStrings); OverLoad;
    Procedure ReadSections(Strings : IHsStringListEx); OverLoad;
    Procedure ReadSectionValues(Const Section : String; Strings : TStrings); OverLoad;
    Procedure ReadSectionValues(Const Section : String; Strings : IHsStringListEx); OverLoad;
    Procedure EraseSection(Const Section : String);

    Procedure DeleteKey(Const Section, Ident : String);
    Procedure UpdateFile();
    Function  ValueExists(Const Section, Ident : String) : Boolean;

    Property FileName : String Read GetFileName Write SetFileName;

  End;

  IHsMemIniFileEx = Interface(IHsIniFileEx)
    ['{4B61686E-29A0-2112-8EEF-F87F2BFE6F3E}']
    Function  GetCaseSensitive() : Boolean;
    Procedure SetCaseSensitive(Value: Boolean);

    Procedure Clear();
    Procedure Rename(Const FileName : String; Reload : Boolean);
    Procedure GetStrings(List: TStrings);
    Procedure SetStrings(List: TStrings);

    Property CaseSensitive : Boolean Read GetCaseSensitive Write SetCaseSensitive;

  End;

  THsCustomIniFileImplementor = Class(TInterfaceExImplementor)
  Strict Private
    FIniFile : TCustomIniFile;
    
  Protected
    Function  GetFileName() : String;
    Procedure SetFileName(Const AFileName : String);

    Function  ReadBinaryStream(Const Section, Name : String; Value : TStream) : Integer; OverLoad;
    Function  ReadBinaryStream(Const Section, Name : String; Value : IStreamEx) : Integer; OverLoad;

    Procedure WriteBinaryStream(Const Section, Name : String; Value : TStream); OverLoad;
    Procedure WriteBinaryStream(Const Section, Name : String; Value : IStreamEx); OverLoad;

    Procedure ReadSection(Const Section : String; Strings : TStrings); OverLoad;
    Procedure ReadSection(Const Section : String; Strings : IHsStringListEx); OverLoad;

    Procedure ReadSections(Strings : TStrings); OverLoad;
    Procedure ReadSections(Strings : IHsStringListEx); OverLoad;

    Procedure ReadSectionValues(Const Section : String; Strings : TStrings); OverLoad;
    Procedure ReadSectionValues(Const Section : String; Strings : IHsStringListEx); OverLoad;

  Public
    Constructor Create(AIniFile : TCustomIniFile); ReIntroduce;

  End;

  THsIniFileEx = Class(TIniFile, IHsIniFileEx)
  Strict Private
    FImplementor : THsCustomIniFileImplementor;

    Function GetImplementor() : THsCustomIniFileImplementor;

  Protected
    Property Implementor : THsCustomIniFileImplementor Read GetImplementor Implements IHsIniFileEx;

  End;

  THsMemIniFileEx = Class(TMemIniFile, IHsMemIniFileEx)
  Strict Private
    FImplementor : THsCustomIniFileImplementor;

    Function GetImplementor() : THsCustomIniFileImplementor;

  Protected
    Property Implementor : THsCustomIniFileImplementor Read GetImplementor Implements IHsMemIniFileEx;

    Function  GetCaseSensitive() : Boolean;
    Procedure SetCaseSensitive(Value: Boolean);

  End;

Implementation

Uses SysUtils;

(******************************************************************************)

Constructor THsCustomIniFileImplementor.Create(AIniFile : TCustomIniFile);
Begin
  InHerited Create(AIniFile, True);

  FIniFile := AIniFile;
End;

Function THsCustomIniFileImplementor.GetFileName() : String;
Begin
  Result := FIniFile.FileName;
End;

Procedure THsCustomIniFileImplementor.SetFileName(Const AFileName : String);
Begin
  PString(@FIniFile.FileName)^ := AFileName;
End;

Function THsCustomIniFileImplementor.ReadBinaryStream(Const Section, Name : String; Value : TStream) : Integer;
Begin
  Result := FIniFile.ReadBinaryStream(Section, Name, Value);
End;

Function THsCustomIniFileImplementor.ReadBinaryStream(Const Section, Name : String; Value : IStreamEx) : Integer;
Begin
  Result := FIniFile.ReadBinaryStream(Section, Name, TStream(Value.InterfaceObject));
End;

Procedure THsCustomIniFileImplementor.WriteBinaryStream(Const Section, Name : String; Value : TStream);
Begin
  FIniFile.WriteBinaryStream(Section, Name, Value);
End;

Procedure THsCustomIniFileImplementor.WriteBinaryStream(Const Section, Name : String; Value : IStreamEx);
Begin
  FIniFile.WriteBinaryStream(Section, Name, TStream(Value.InterfaceObject));
End;

Procedure THsCustomIniFileImplementor.ReadSection(Const Section : String; Strings : TStrings);
Begin
  FIniFile.ReadSection(Section, Strings);
End;

Procedure THsCustomIniFileImplementor.ReadSection(Const Section : String; Strings : IHsStringListEx);
Begin
  FIniFile.ReadSection(Section, TStrings(Strings.InterfaceObject));
End;

Procedure THsCustomIniFileImplementor.ReadSections(Strings : TStrings);
Begin
  FIniFile.ReadSections(Strings);
End;

Procedure THsCustomIniFileImplementor.ReadSections(Strings : IHsStringListEx);
Begin
  FIniFile.ReadSections(TStrings(Strings.InterfaceObject));
End;

Procedure THsCustomIniFileImplementor.ReadSectionValues(Const Section : String; Strings : TStrings);
Begin
  FIniFile.ReadSectionValues(Section, Strings);
End;

Procedure THsCustomIniFileImplementor.ReadSectionValues(Const Section : String; Strings : IHsStringListEx);
Begin
  FIniFile.ReadSectionValues(Section, TStrings(Strings.InterfaceObject));
End;

Function THsIniFileEx.GetImplementor() : THsCustomIniFileImplementor;
Begin
  If Not Assigned(FImplementor) Then
    FImplementor := THsCustomIniFileImplementor.Create(Self);
  Result := FImplementor;
End;

Function THsMemIniFileEx.GetImplementor() : THsCustomIniFileImplementor;
Begin
  If Not Assigned(FImplementor) Then
    FImplementor := THsCustomIniFileImplementor.Create(Self);
  Result := FImplementor;
End;

Function THsMemIniFileEx.GetCaseSensitive() : Boolean;
Begin
  Result := InHerited CaseSensitive;
End;

Procedure THsMemIniFileEx.SetCaseSensitive(Value: Boolean);
Begin
  InHerited CaseSensitive := Value;
End;

End.

