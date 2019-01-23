unit HsJSonEx;

interface

Uses Classes, HsInterfaceEx;

Type
  TJSonValueType = ( svtString, svtInteger, svtDouble,
                     svtObject, svtArray, svtBoolean, svtNull);

  THsJSonObjectClass = Class Of THsJSonObject;
  TJSonNumberType = (ntUnknown, ntInteger, ntDouble);

  IHsJSonObjects = Interface;
  IHsJSonObject = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-BC36-F4E103672D0F}']
    Procedure RegisterChildNode(Const Path : String; ChildNodeClass : THsJSonObjectClass);
    Function  GetChildNodeClass(Const Path : String; Const AIsList : Boolean = False) : THsJSonObjectClass;

    Function  GetName() : String;
    Procedure SetName(Const AName : String);

//    Function  GetParentNode() : IHsJSonObject;
    Function GetChildNodes() : IHsJSonObjects;

    Function  GetAsString() : String;
    Procedure SetAsString(Const AString : String);
    Function  GetAsBoolean() : Boolean;
    Procedure SetAsBoolean(Const ABoolean : Boolean);
    Function  GetAsInteger() : Integer;
    Procedure SetAsInteger(Const AInteger : Integer);
    Function  GetAsFloat() : Double;
    Procedure SetAsFloat(Const ADouble : Double);

    Function  GetO(Const AIndex : String) : IHsJSonObject;
    Procedure SetO(Const AIndex : String; AObject : IHsJSonObject);
    Function  GetS(Const AIndex : String) : String;
    Procedure SetS(Const AIndex : String; Const AString : String);
    Function  GetB(Const AIndex : String) : Boolean;
    Procedure SetB(Const AIndex : String; Const ABoolean : Boolean);
    Function  GetI(Const AIndex : String) : Integer;
    Procedure SetI(Const AIndex : String; Const AInteger : Integer);
    Function  GetD(Const AIndex : String) : Double;
    Procedure SetD(Const AIndex : String; Const ADouble : Double);
    Function  GetA(Const AIndex : String) : IHsJSonObjects;

    Property Name : String Read GetName Write SetName;

//    Property ParentNode : IHsJSonObject   Read GetParentNode;
    Property ChildNodes : IHsJSonObjects Read GetChildNodes;

    Property O[Const Index : String] : IHsJSonObject  Read GetO Write SetO; Default;
    Property S[Const Index : String] : String         Read GetS Write SetS;
    Property B[Const Index : String] : Boolean        Read GetB Write SetB;
    Property I[Const Index : String] : Integer        Read GetI Write SetI;
    Property D[Const Index : String] : Double         Read GetD Write SetD;
    Property A[Const Index : String] : IHsJSonObjects Read GetA;

    Property AsString  : String  Read GetAsString  Write SetAsString;
    Property AsBoolean : Boolean Read GetAsBoolean Write SetAsBoolean;
    Property AsInteger : Integer Read GetAsInteger Write SetAsInteger;
    Property AsFloat   : Double  Read GetAsFloat   Write SetAsFloat;

    Function AsArray() : IHsJSonObjects;
    Function AsJSon() : String;

    Procedure LoadFromJSon(Const AJSon : String);

    //To Remove
    Function GetObjectType() : TJSonValueType;

    Function AddChild(Const AValueType : TJSonValueType) : IHsJSonObject;

    Property ObjectType : TJSonValueType  Read GetObjectType;

  End;

  IHsJSonObjects = Interface(IHsJSonObject)
    ['{4B61686E-29A0-2112-9551-3EB9B96CE444}']
    Function GetItemClass() : THsJSonObjectClass;

    Function  Get(Index: Integer) : IHsJSonObject;
    Procedure Put(Index: Integer; Const Item: IHsJSonObject);

    Function GetCount() : Integer;

    Function  Add(Const AValueType : TJSonValueType = svtObject) : IHsJSonObject; OverLoad;
    Function  Add(Const Item : IHsJSonObject) : Integer; OverLoad;
    Procedure Delete(Const Index : Integer);

    Function IndexOf(Const AValueName : String) : Integer;
    Procedure Clear();

    Property Nodes[Index : Integer] : IHsJSonObject Read Get Write Put; Default;

    Property Count : Integer Read GetCount;

  End;

  THsJSonObject = Class(TInterfacedObjectEx, IHsJSonObject)
  Private
    FObjectType : TJSonValueType;
    FObjectName : String;
    FObjectData : Record
      odString  : String;
      odInteger : Integer;
      odDouble  : Double;
      odArray   : IHsJSonObjects;
      odBoolean : Boolean;
    End;
    FChild : IHsJSonObjects;

    FLstChildClass : TStringList;

  Protected
    Procedure RegisterChildNode(Const Path : String; ChildNodeClass: THsJSonObjectClass);
    Function  GetChildNodeClass(Const Path : String; Const AIsList : Boolean = False) : THsJSonObjectClass;

  Protected
    Procedure Created(); OverRide;

    Function  GetName() : String;
    Procedure SetName(Const AName : String);

    Function GetChildNodes() : IHsJSonObjects;

    Function  GetO(Const AIndex : String) : IHsJSonObject;
    Procedure SetO(Const AIndex : String; AObject : IHsJSonObject);
    Function  GetS(Const AIndex : String) : String;
    Procedure SetS(Const AIndex : String; Const AString : String);
    Function  GetB(Const AIndex : String) : Boolean;
    Procedure SetB(Const AIndex : String; Const ABoolean : Boolean);
    Function  GetI(Const AIndex : String) : Integer;
    Procedure SetI(Const AIndex : String; Const AInteger : Integer);
    Function  GetD(Const AIndex : String) : Double;
    Procedure SetD(Const AIndex : String; Const ADouble : Double);
    Function  GetA(Const AIndex : String) : IHsJSonObjects;

    Function  GetAsString() : String;
    Procedure SetAsString(Const AString : String);
    Function  GetAsBoolean() : Boolean;
    Procedure SetAsBoolean(Const ABoolean : Boolean);
    Function  GetAsInteger() : Integer;
    Procedure SetAsInteger(Const AInteger : Integer);
    Function  GetAsFloat() : Double;
    Procedure SetAsFloat(Const ADouble : Double);

    Function  GetObjectType() : TJSonValueType;
    Function  AddChild(Const AValueType : TJSonValueType) : IHsJSonObject;

    Function AsArray() : IHsJSonObjects;
    Function AsJSon() : String;

    Procedure LoadFromJSon(Const AJSon : String);

  Protected
    Property Name : String Read GetName Write SetName;

    Property ChildNodes : IHsJSonObjects Read GetChildNodes;

    Property O[Const Index : String] : IHsJSonObject  Read GetO Write SetO; Default;
    Property S[Const Index : String] : String         Read GetS Write SetS;
    Property B[Const Index : String] : Boolean        Read GetB Write SetB;
    Property I[Const Index : String] : Integer        Read GetI Write SetI;
    Property D[Const Index : String] : Double         Read GetD Write SetD;
    Property A[Const Index : String] : IHsJSonObjects Read GetA;

    Property AsString  : String  Read GetAsString  Write SetAsString;
    Property AsBoolean : Boolean Read GetAsBoolean Write SetAsBoolean;
    Property AsInteger : Integer Read GetAsInteger Write SetAsInteger;
    Property AsFloat   : Double  Read GetAsFloat   Write SetAsFloat;

  Public
    Class Function GetDocBinding(AObject : IHsJSonObject; Const ANodeClass : THsJSonObjectClass) : IHsJSonObject; OverLoad;
    Class Function GetDocBinding(AJSon : String; Const ANodeClass : THsJSonObjectClass) : IHsJSonObject; OverLoad;

    Constructor Create(Const AValueType : TJSonValueType = svtObject); ReIntroduce;
    Destructor Destroy(); OverRide;

  End;

  THsJSonObjects = Class(THsJSonObject, IHsJSonObjects)
  Private
    FList : IInterfaceListEx;

  Protected
    Function GetItemClass() : THsJSonObjectClass; Virtual;

    Function  Get(Index: Integer) : IHsJSonObject;
    Procedure Put(Index: Integer; Const Item: IHsJSonObject);

    Function GetCount() : Integer;

    Function Add(Const AValueType : TJSonValueType = svtObject) : IHsJSonObject; OverLoad;
    Function Add(Const Item : IHsJSonObject) : Integer; OverLoad;
    Procedure Delete(Const Index : Integer);

    Function  IndexOf(Const AValueName : String) : Integer;
    Procedure Clear();

    Property Items[Index : Integer] : IHsJSonObject Read Get Write Put; Default;
    Property Count : Integer Read GetCount;

  Public
    Procedure AfterConstruction(); OverRide;

    Constructor Create(); ReIntroduce;

  End;

implementation

Uses SysUtils, OJSonUtils, OJSonReadWrite, HsJSonFormatterEx;

Constructor THsJSonObjects.Create();
Begin
  InHerited Create(svtArray);
End;

Procedure THsJSonObjects.AfterConstruction();
Begin
  InHerited AfterConstruction();
  
  FList := TInterfaceListEx.Create(True);
End;

Function THsJSonObjects.GetItemClass() : THsJSonObjectClass;
Begin
  Result := THsJSonObject;
End;

Function THsJSonObjects.Get(Index: Integer) : IHsJSonObject;
Begin
  Result := FList.Items[Index] As IHsJSonObject;
End;

Procedure THsJSonObjects.Put(Index: Integer; Const Item: IHsJSonObject);
Begin
  FList.Items[Index] := Item;
End;

Function THsJSonObjects.GetCount() : Integer;
Begin
  Result := FList.Count;
End;

Function THsJSonObjects.Add(Const AValueType : TJSonValueType = svtObject) : IHsJSonObject;
Begin
  Result := GetItemClass().Create(AValueType);
  FList.Add(Result);
End;

Function THsJSonObjects.Add(Const Item : IHsJSonObject) : Integer;
Begin
  Result := FList.Add(Item);
End;

Procedure THsJSonObjects.Delete(Const Index : Integer);
Begin
  FList.Delete(Index);
End;

Function THsJSonObjects.IndexOf(Const AValueName : String) : Integer;
Var X : Integer;
Begin
  Result := -1;

  For X := 0 To FList.Count - 1 Do
    If SameText(AValueName, Items[X].Name) Then
    Begin
      Result := X;
      Break;
    End;
End;

Procedure THsJSonObjects.Clear();
Begin
  FList.Clear();
End;

Constructor THsJSonObject.Create(Const AValueType : TJSonValueType);
Begin
  InHerited Create(True);

  FObjectType := AValueType;
  If FObjectType = svtObject Then
    FChild := THsJSonObjects.Create();
End;

Destructor THsJSonObject.Destroy();
Begin
  FreeAndNil(FLstChildClass);

  InHerited Destroy();
End;

Procedure THsJSonObject.Created();
Begin
  InHerited Created();

  FLstChildClass := TStringList.Create();
End;

Class Function THsJSonObject.GetDocBinding(AObject : IHsJSonObject; Const ANodeClass : THsJSonObjectClass) : IHsJSonObject;
Begin
  Result := GetDocBinding(AObject.AsJSon, ANodeClass);
End;

Class Function THsJSonObject.GetDocBinding(AJSon : String; Const ANodeClass : THsJSonObjectClass) : IHsJSonObject;
Begin
  If Supports(ANodeClass.Create(), IHsJSonObject, Result) Then
    Result.LoadFromJSon(AJSon)
  Else
    Raise Exception.Create('IHsJSonObject Not Implemented : ' + ANodeClass.ClassName);
End;

Procedure THsJSonObject.RegisterChildNode(Const Path : String; ChildNodeClass: THsJSonObjectClass);
Begin
  FLstChildClass.AddObject(UpperCase(Path), TObject(ChildNodeClass));
End;

Function THsJSonObject.GetChildNodeClass(Const Path : String; Const AIsList : Boolean = False) : THsJSonObjectClass;
Var X : Integer;
    lPath : String;
Begin
  lPath := UpperCase(Path);
  If AIsList Then
    Result := THsJSonObjects
  Else
    Result := THsJSonObject;

  For X := 0 To FLstChildClass.Count - 1 Do
    If SameText(FLstChildClass[X], lPath) Then
    Begin
      Result := THsJSonObjectClass(FLstChildClass.Objects[X]);
      Break;
    End;
End;

Function THsJSonObject.AsJSon() : String;
  Procedure WriteObject(AObject : IHsJSonObject; AWriter : TJSonWriter);
  Var X, Y : Integer;
  Begin
    If AObject.Name <> '' Then
      AWriter.OpenObject(AObject.Name)
    Else
      AWriter.OpenObject();

    Try
      For X := 0 To AObject.ChildNodes.Count - 1 Do
      Begin
        Case AObject.ChildNodes[X].ObjectType Of
          svtObject : WriteObject(AObject.ChildNodes[X], AWriter);
          svtArray  :
          Begin
            If AObject.ChildNodes[X].Name <> '' Then
              AWriter.OpenArray(AObject.ChildNodes[X].Name)
            Else
              AWriter.OpenArray();

            Try
              For Y := 0 To AObject.ChildNodes[X].AsArray.Count - 1 Do
                WriteObject(AObject.ChildNodes[X].AsArray[Y], AWriter);

              Finally
                AWriter.CloseArray();
            End;
          End;

          svtString  : AWriter.Text(AObject.ChildNodes[X].Name, AObject.ChildNodes[X].AsString);
          svtBoolean : AWriter.Boolean(AObject.ChildNodes[X].Name, AObject.ChildNodes[X].AsBoolean);
          svtInteger : AWriter.Number(AObject.ChildNodes[X].Name, AObject.ChildNodes[X].AsInteger);
          svtDouble  : AWriter.Number(AObject.ChildNodes[X].Name, AObject.ChildNodes[X].AsFloat);
        End;
      End;

      Finally
        AWriter.CloseObject();
    End;
  End;

Var lW : TJSonWriter;
Begin
  lW := TJSonWriter.Create();
  Try
    WriteObject(Self, lW);
//    Result := lW.AsJSon;
    Result := FormatJSonData(lW.AsJSon);

    Finally
      lW.Free();
  End;
End;

Procedure THsJSonObject.LoadFromJSon(Const AJSon : String);
  Function CreateChild(AParent : IHsJSonObject; ANodeType : TJSonValueType) : IHsJSonObject; OverLoad;
  Begin
    Case AParent.ObjectType Of
      svtObject : Result := AParent.AddChild(ANodeType);
      svtArray  : Result := AParent.AsArray.Add(ANodeType);
    End;
  End;

  Function CreateChild(AParent : IHsJSonObject; AToken : TCustomJSonReaderToken) : IHsJSonObject; OverLoad;
  Const vtMapping : Array[TJSonReaderValueType] Of TJSonValueType = (
    svtString, svtInteger, svtObject, svtArray, svtBoolean, svtNull
  );
  Var lVal : Extended;
  Begin
    If AToken.ValueType = vtNumber Then
    Begin
      lVal := Frac(AToken.ExtendedValue);
      If lVal <> 0 Then
        Result := CreateChild(AParent, svtDouble)
      Else
        Result := CreateChild(AParent, svtInteger);
    End
    Else
      Result := CreateChild(AParent, vtMapping[AToken.ValueType]);
  End;

  Procedure ReadObject(AObject : IHsJSonObject; AReader : TJSonReader);
  Var lToken : TCustomJSonReaderToken;
      lPairName : String;
      lChild : IHsJSonObject;
  Begin
    While AReader.ReadNextToken(lToken) Do
      Case lToken.TokenType Of
        ttCloseObject, ttCloseArray :
        Begin
          Break;
        End;

        ttOpenObject :
        Begin
          lChild := CreateChild(AObject, svtObject);
          If Assigned(lChild) Then
            ReadObject(lChild, AReader);
        End;

        ttOpenArray :
        Begin
          lChild := CreateChild(AObject, svtArray);
          If Assigned(lChild) Then
            ReadObject(lChild, AReader);
        End;

        ttValue :
        Begin
          lChild := CreateChild(AObject, lToken);
          If Assigned(lChild) Then
            Case lChild.ObjectType Of
              svtString  : lChild.AsString := lToken.StringValue;
              svtInteger : lChild.AsInteger := lToken.IntegerValue;
              svtDouble  : lChild.AsFloat := lToken.DoubleValue;
              svtBoolean : lChild.AsBoolean := lToken.BooleanValue;
            End;
        End;

        ttPairName :
        Begin
          lPairName := lToken.PairName;
          If AReader.ReadNextToken(lToken) Then
            Case lToken.TokenType Of
              ttOpenObject :
              Begin
                lChild := AObject.GetChildNodeClass(lPairName).Create();

                If Assigned(lChild) Then
                Begin
                  AObject[lPairName] := lChild;
                  ReadObject(lChild, AReader);
                End;
              End;

              ttOpenArray :
              Begin
                lChild := AObject.GetChildNodeClass(lPairName, True).Create(svtArray);

                If Assigned(lChild) Then
                Begin
                  AObject[lPairName] := lChild;
                  ReadObject(lChild, AReader);
                End;
              End;

              ttValue :
              Begin
                lChild := CreateChild(AObject, lToken);
                If Assigned(lChild) Then
                Begin
                  lChild.Name := lPairName;

                  Case lChild.ObjectType Of
                    svtString  : lChild.AsString := lToken.StringValue;
                    svtInteger : lChild.AsInteger := lToken.IntegerValue;
                    svtDouble  : lChild.AsFloat := lToken.DoubleValue;
                    svtBoolean : lChild.AsBoolean := lToken.BooleanValue;
                  End;
                End;
              End;
            End;
        End;
      End;
  End;

Var lR : TJSonReader;
    lToken : TCustomJSonReaderToken;
Begin
  FChild.Clear();
  lR := TJSonReader.Create();
  Try
    lR.InitString(AJSon);
    If lR.ReadNextToken(lToken) And (lToken.TokenType = ttOpenObject) Then
      ReadObject(Self, lR);

    Finally
      lR.Free();
  End;
End;

Function THsJSonObject.GetAsString() : String;
Begin
  If FObjectType = svtString Then
    Result := FObjectData.odString
  Else
    Result := AsJSon();
End;

Procedure THsJSonObject.SetAsString(Const AString : String);
Begin
  If FObjectType = svtString Then
    FObjectData.odString := AString;
End;

Function THsJSonObject.GetAsBoolean() : Boolean;
Begin
  If FObjectType = svtBoolean Then
    Result := FObjectData.odBoolean
  Else
    Result := False;
End;

Procedure THsJSonObject.SetAsBoolean(Const ABoolean : Boolean);
Begin
  If FObjectType = svtBoolean Then
    FObjectData.odBoolean := ABoolean;
End;

Function THsJSonObject.GetAsInteger() : Integer;
Begin
//  If (FObjectType = vtNumber) And (FObjectData.odNumType = ntInteger) Then
  If FObjectType = svtInteger Then
    Result := FObjectData.odInteger
  Else
    Result := 0;
End;

Procedure THsJSonObject.SetAsInteger(Const AInteger : Integer);
Begin
//  If (FObjectType = vtNumber) And (FObjectData.odNumType = ntInteger) Then
  If FObjectType = svtInteger Then
    FObjectData.odInteger := AInteger;
End;

Function THsJSonObject.GetAsFloat() : Double;
Begin
//  If (FObjectType = vtNumber) And (FObjectData.odNumType = ntDouble) Then
  If FObjectType = svtDouble Then
    Result := FObjectData.odDouble
  Else
    Result := 0;
End;

Procedure THsJSonObject.SetAsFloat(Const ADouble : Double);
Begin
//  If (FObjectType = vtNumber) And (FObjectData.odNumType = ntDouble) Then
  If FObjectType = svtDouble Then
    FObjectData.odDouble := ADouble;
End;

Function THsJSonObject.GetObjectType() : TJSonValueType;
Begin
  Result := FObjectType;
End;

Function THsJSonObject.AddChild(Const AValueType : TJSonValueType) : IHsJSonObject;
Begin
  Result := FChild.Add(AValueType);
End;

Function THsJSonObject.AsArray() : IHsJSonObjects;
Begin
  If FObjectType = svtArray Then
  Begin
    If Not Assigned(FObjectData.odArray) Then
    Begin
      If Supports(Self, IHsJSonObjects, FObjectData.odArray) Then
        FObjectData.odArray._Release();
    End;

    Result := FObjectData.odArray;
  End
  Else
    Result := Nil;
End;

Function THsJSonObject.GetName() : String;
Begin
  Result := FObjectName;
End;

Procedure THsJSonObject.SetName(Const AName : String);
Begin
  FObjectName := AName;
End;

Function THsJSonObject.GetChildNodes() : IHsJSonObjects;
Begin
  Result := FChild;
End;

Function THsJSonObject.GetO(Const AIndex : String) : IHsJSonObject;
Var lIdx : Integer;
Begin
  lIdx := FChild.IndexOf(AIndex);
  If lIdx > -1 Then
    Result := FChild[lIdx]
  Else
    Result := Nil;
End;

Procedure THsJSonObject.SetO(Const AIndex : String; AObject : IHsJSonObject);
Var lIdx : Integer;
Begin
  lIdx := FChild.IndexOf(AIndex);
  If lIdx > -1 Then
  Begin
    If Assigned(AObject) Then
      FChild[lIdx] := AObject
    Else
      FChild.Delete(lIdx);
  End
  Else
  Begin
    If Assigned(AObject) Then
    Begin
      AObject.Name := AIndex;
      FChild.Add(AObject);
    End;
  End;
End;

Function THsJSonObject.GetS(Const AIndex : String) : String;
Var lItem : IHsJSonObject;
Begin
  lItem := GetO(AIndex);
  If Assigned(lItem) Then
    Result := lItem.AsString
  Else
    Result := '';
End;

Procedure THsJSonObject.SetS(Const AIndex : String; Const AString : String);
Var lItem : IHsJSonObject;
Begin
  lItem := GetO(AIndex);
  If Assigned(lItem) Then
    lItem.AsString := AString
  Else
  Begin
    lItem := THsJSonObject.Create(svtString);
    lItem.AsString := AString;
    SetO(AIndex, lItem);
  End;
End;

Function THsJSonObject.GetB(Const AIndex : String) : Boolean;
Var lItem : IHsJSonObject;
Begin
  lItem := GetO(AIndex);
  If Assigned(lItem) Then
    Result := lItem.AsBoolean
  Else
    Result := False;
End;

Procedure THsJSonObject.SetB(Const AIndex : String; Const ABoolean : Boolean);
Var lItem : IHsJSonObject;
Begin
  lItem := GetO(AIndex);
  If Assigned(lItem) Then
    lItem.AsBoolean := ABoolean
  Else
  Begin
    lItem := THsJSonObject.Create(svtBoolean);
    lItem.AsBoolean := ABoolean;
    SetO(AIndex, lItem);
  End;
End;

Function THsJSonObject.GetI(Const AIndex : String) : Integer;
Var lItem : IHsJSonObject;
Begin
  lItem := GetO(AIndex);
  If Assigned(lItem) Then
    Result := lItem.AsInteger
  Else
    Result := 0;
End;

Procedure THsJSonObject.SetI(Const AIndex : String; Const AInteger : Integer);
Var lItem : IHsJSonObject;
Begin
  lItem := GetO(AIndex);
  If Assigned(lItem) Then
    lItem.AsInteger := AInteger
  Else
  Begin
    lItem := THsJSonObject.Create(svtInteger);
    lItem.AsInteger := AInteger;
    SetO(AIndex, lItem);
  End;
End;

Function THsJSonObject.GetD(Const AIndex : String) : Double;
Var lItem : IHsJSonObject;
Begin
  lItem := GetO(AIndex);
  If Assigned(lItem) Then
    Result := lItem.AsFloat
  Else
    Result := 0;
End;

Procedure THsJSonObject.SetD(Const AIndex : String; Const ADouble : Double);
Var lItem : IHsJSonObject;
Begin
  lItem := GetO(AIndex);
  If Assigned(lItem) Then
    lItem.AsFloat := ADouble
  Else
  Begin
    lItem := THsJSonObject.Create(svtDouble);
    lItem.AsFloat := ADouble;
    SetO(AIndex, lItem);
  End;
End;

Function THsJSonObject.GetA(Const AIndex : String) : IHsJSonObjects;
Var lItem : IHsJSonObject;
Begin
  lItem := GetO(AIndex);
  If Assigned(lItem) Then
    Result := lItem.AsArray
  Else
    Result := Nil;
End;

end.
