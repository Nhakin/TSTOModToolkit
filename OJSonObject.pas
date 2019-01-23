Unit OJSonObject;

Interface

Uses Classes, OWideSupp, OJsonUtils, OJsonReadWrite,
  HsInterfaceEx;

Type
  IJSonObject = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-BCF5-B61EB8A4EA1A}']
    //Writer
    Function OpenArray() : TCustomJSONWriter; Overload;// "["
    Function OpenArray(Const aPairName : OWideString) : TCustomJSONWriter; Overload;
    Function OpenArrayUnicode(Const aPairName : OUnicodeString) : TCustomJSONWriter;
    Function OpenArrayUTF8(Const aPairName : OUTF8Container) : TCustomJSONWriter;
    Function CloseArray : TCustomJSONWriter; // "]"

    Function OpenObject() : TCustomJSONWriter; Overload; // "{"
    Function OpenObject(Const aPairName : OWideString) : TCustomJSONWriter; Overload;
    Function OpenObjectUnicode(Const aPairName : OUnicodeString) : TCustomJSONWriter;
    Function OpenObjectUTF8(Const aPairName : OUTF8Container) : TCustomJSONWriter;
    Function CloseObject : TCustomJSONWriter; // "}"

    Procedure PairName(Const aString : OWideString);
    Procedure PairNameUnicode(Const aString : OUnicodeString);
    Procedure PairNameUTF8(Const aString : OUTF8Container);

    Function Text(Const aText : OWideString) : TCustomJSONWriter; Overload;
    Function Text(Const aPairName, aText : OWideString) : TCustomJSONWriter; Overload;
    Function TextUnicode(Const aText : OUnicodeString) : TCustomJSONWriter; Overload;
    Function TextUTF8(Const aText : OUTF8Container) : TCustomJSONWriter; Overload;
    Function TextUnicode(Const aPairName, aText : OUnicodeString) : TCustomJSONWriter; Overload;
    Function TextUTF8(Const aPairName, aText : OUTF8Container) : TCustomJSONWriter; Overload;

    Function Number(Const aNumber : Integer) : TCustomJSONWriter; Overload;
    Function Number(Const aPairName : OWideString; Const aNumber : Integer) : TCustomJSONWriter; Overload;
    Function Number(Const aNumber : Extended) : TCustomJSONWriter; Overload;
    Function Number(Const aPairName : OWideString; Const aNumber : Extended) : TCustomJSONWriter; Overload;
    Function NumberUnicode(Const aPairName : OUnicodeString; Const aNumber : Integer) : TCustomJSONWriter; Overload;
    Function NumberUTF8(Const aPairName : OUTF8Container; Const aNumber : Integer) : TCustomJSONWriter; Overload;
    Function NumberUnicode(Const aPairName : OUnicodeString; Const aNumber : Extended) : TCustomJSONWriter; Overload;
    Function NumberUTF8(Const aPairName : OUTF8Container; Const aNumber : Extended) : TCustomJSONWriter; Overload;

    Function Boolean(Const aBoolean : Boolean) : TCustomJSONWriter; Overload;
    Function Boolean(Const aPairName : OWideString; Const aBoolean : Boolean) : TCustomJSONWriter; Overload;
    Function BooleanUnicode(Const aPairName : OUnicodeString; Const aBoolean : Boolean) : TCustomJSONWriter;
    Function BooleanUTF8(Const aPairName : OUTF8Container; Const aBoolean : Boolean) : TCustomJSONWriter;

    Function Null() : TCustomJSONWriter; Overload;
    Function Null(Const aPairName : OWideString) : TCustomJSONWriter; Overload;
    Function NullUnicode(Const aPairName : OUnicodeString) : TCustomJSONWriter;
    Function NullUTF8(Const aPairName : OUTF8Container) : TCustomJSONWriter;

    Function AsJSon() : AnsiString;

    //Reader
    Function GetReaderToken() : TCustomJSONReaderToken; 

    Procedure InitFile(Const aFileName : OWideString); Overload;
    Procedure InitStream(Const aStream : TStream); Overload;
    Procedure InitString(Const aJSON : OWideString);
    Procedure InitString_UTF8(Const aJSON : OUTF8Container);
    Procedure ReleaseDocument();

    Function ReadNextToken(Var outToken : TCustomJSONReaderToken) : Boolean;

    Property LastToken : TCustomJSONReaderToken Read GetReaderToken;

  End;

  TJSonObject = Class(TInterfacedObjectEx, IJSonObject)
  Private
    FWriter : TJSonWriter;
    FReader : TJSonReader;
    
    Function GetWriterImpl() : TJSonWriter;

  Protected
    Property WriterImpl : TJSonWriter Read GetWriterImpl Implements IJSonObject;

    Procedure Created(); OverRide;

    Function AsJSon() : AnsiString;

    //Reader
    Function GetReaderToken() : TCustomJSONReaderToken; 

    Procedure InitFile(Const aFileName : OWideString);
    Procedure MyInitStream(Const aStream : TStream);
    Procedure IJSonObject.InitStream = MyInitStream;
    Procedure InitString(Const aJSON : OWideString);
    Procedure InitString_UTF8(Const aJSON : OUTF8Container);
    Procedure ReleaseDocument();

    Function ReadNextToken(Var outToken : TCustomJSONReaderToken) : Boolean;

  Public
    Destructor Destroy(); Override;

  End;

Implementation

Uses Dialogs,
  SysUtils, HsStreamEx;

Procedure TJSonObject.Created();
Begin
  InHerited Created();

  FReader := TJSonReader.Create();
End;

Destructor TJSonObject.Destroy();
Begin
  If Assigned(FWriter) Then
    FreeAndNil(FWriter);
  FreeAndNil(FReader);

  Inherited Destroy();
End;

Function TJSonObject.AsJSon() : AnsiString;
Begin
  Result := FWriter.AsJSon;
End;

Function TJSonObject.GetWriterImpl() : TJSONWriter;
Begin
  If Not Assigned(FWriter) Then
    FWriter := TJSonWriter.Create(TRawByteStringStream.Create(''), True);

  Result := FWriter;
End;

Function TJSonObject.GetReaderToken() : TCustomJSONReaderToken;
Begin
  Result := FReader.LastToken;
End;

Procedure TJSonObject.InitFile(Const aFileName : OWideString);
Begin
  FReader.InitFile(aFileName);
End;

Procedure TJSonObject.MyInitStream(Const aStream : TStream);
Begin
  FReader.InitStream(aStream);
End;

Procedure TJSonObject.InitString(Const aJSON : OWideString);
Begin
  FReader.InitString(aJSon);
End;

Procedure TJSonObject.InitString_UTF8(Const aJSON : OUTF8Container);
Begin
  FReader.InitString_UTF8(aJSon);
End;

Procedure TJSonObject.ReleaseDocument();
Begin
  FReader.ReleaseDocument();
End;

Function TJSonObject.ReadNextToken(Var outToken : TCustomJSONReaderToken) : Boolean;
Begin
  Result := FReader.ReadNextToken(outToken);
End;

End.

