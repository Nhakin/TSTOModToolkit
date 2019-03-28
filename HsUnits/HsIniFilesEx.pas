Unit HsIniFilesEx;

Interface

Uses Classes, HsInterfaceEx, HsStreamEx, HsStringListEx;

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
    Procedure WriteBinaryStream(Const Section, Name : String; Value : TStream); OverLoad;
    Function  ReadBinaryStream(Const Section, Name : String; Value : IStreamEx) : Integer; OverLoad;
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

  THsIniFileEx = ClasS(TObject)
  Public
    Class Function CreateIniFile(Const AFileName : String) : IHsIniFileEx;

  End;

Implementation

Uses IniFiles, SysUtils;

Type
  THsIniFileExImpl = Class(TIniFile, IHsIniFileEx)
  Strict Private
    FImpl : TInterfaceExImplementor;

    Function GetImpl() : TInterfaceExImplementor;

  Protected
    Property IniFileImpl : TInterfaceExImplementor Read GetImpl Implements IHsIniFileEx;

    Function  GetFileName() : String;
    Procedure SetFileName(Const AFileName : String);

    Function  ReadBinaryStream(Const Section, Name : String; Value : IStreamEx) : Integer; ReIntroduce; OverLoad;
    Procedure WriteBinaryStream(Const Section, Name : String; Value : IStreamEx); ReIntroduce; OverLoad;

    Procedure ReadSection(Const Section : String; Strings : IHsStringListEx); ReIntroduce; OverLoad;
    Procedure ReadSections(Strings : IHsStringListEx); ReIntroduce; OverLoad;
    Procedure ReadSectionValues(Const Section : String; Strings : IHsStringListEx); ReIntroduce; OverLoad;

  End;

Class Function THsIniFileEx.CreateIniFile(Const AFileName : String) : IHsIniFileEx;
Begin
  Result := THsIniFileExImpl.Create(AFileName);
End;

(******************************************************************************)

Function THsIniFileExImpl.GetImpl() : TInterfaceExImplementor;
Begin
  If Not Assigned(FImpl) Then
    FImpl := TInterfaceExImplementor.Create(Self);
  Result := FImpl;
End;

Function THsIniFileExImpl.GetFileName() : String;
Begin
  Result := FileName
End;

Procedure THsIniFileExImpl.SetFileName(Const AFileName : String);
Begin
  PString(@FileName)^ := AFileName;
End;

Function THsIniFileExImpl.ReadBinaryStream(Const Section, Name : String; Value : IStreamEx) : Integer;
Begin
  Result := InHerited ReadBinaryStream(Section, Name, TStream(Value.InterfaceObject));
End;

Procedure THsIniFileExImpl.WriteBinaryStream(Const Section, Name : String; Value : IStreamEx);
Begin
  InHerited WriteBinaryStream(Section, Name, TStream(Value.InterfaceObject));
End;

Procedure THsIniFileExImpl.ReadSection(Const Section : String; Strings : IHsStringListEx);
Begin
  InHerited ReadSection(Section, TStrings(Strings.InterfaceObject));
End;

Procedure THsIniFileExImpl.ReadSections(Strings : IHsStringListEx);
Begin
  InHerited ReadSections(TStrings(Strings.InterfaceObject));
End;

Procedure THsIniFileExImpl.ReadSectionValues(Const Section : String; Strings : IHsStringListEx);
Begin
  InHerited ReadSectionValues(Section, TStrings(Strings.InterfaceObject));
End;

End.

