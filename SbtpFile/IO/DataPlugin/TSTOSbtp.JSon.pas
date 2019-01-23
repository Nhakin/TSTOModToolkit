unit TSTOSbtp.JSon;

interface

Uses Windows, Classes, SysUtils, TSTOSbtpIntf, OJSonObject;

Type
  IJSonSbtpSubVariable = Interface(ISbtpSubVariable)
    ['{4B61686E-29A0-2112-B5E0-8DDF1D6E1570}']
    Procedure SaveJSon(AJSon : IJSonObject);
    Procedure LoadJSon(AJSon : IJSonObject);

  End;

  IJSonSbtpSubVariables = Interface(ISbtpSubVariables)
    ['{4B61686E-29A0-2112-8E1B-6C44BED9C401}']
    Function  Get(Index : Integer) : IJSonSbtpSubVariable;
    Procedure Put(Index : Integer; Const Item : IJSonSbtpSubVariable);

    Function Add() : IJSonSbtpSubVariable; OverLoad;
    Function Add(Const AItem : IJSonSbtpSubVariable) : Integer; OverLoad;

    Procedure SaveJSon(AJSon : IJSonObject);
    Procedure LoadJSon(AJSon : IJSonObject);
    
    Property Items[Index : Integer] : IJSonSbtpSubVariable Read Get Write Put; Default;

  End;

  IJSonSbtpVariable = Interface(ISbtpVariable)
    ['{4B61686E-29A0-2112-9C89-BE78BEE78E3A}']
    Function  GetSubItem() : IJSonSbtpSubVariables;

    Procedure SaveJSon(AJSon : IJSonObject);
    Procedure LoadJSon(AJSon : IJSonObject);

    Property SubItem : IJSonSbtpSubVariables Read GetSubItem;

  End;

  IJSonSbtpVariables = Interface(ISbtpVariables)
    ['{4B61686E-29A0-2112-B529-E4F15EB72F02}']
    Function  Get(Index : Integer) : IJSonSbtpVariable;
    Procedure Put(Index : Integer; Const Item : IJSonSbtpVariable);

    Function Add() : IJSonSbtpVariable; OverLoad;
    Function Add(Const AItem : IJSonSbtpVariable) : Integer; OverLoad;

    Procedure SaveJSon(AJSon : IJSonObject);
    Procedure LoadJSon(AJSon : IJSonObject);

    Property Items[Index : Integer] : IJSonSbtpVariable Read Get Write Put; Default;

  End;

  IJSonSbtpHeader = Interface(ISbtpHeader)
    ['{4B61686E-29A0-2112-81A0-415C4648A005}']
    Procedure SaveJSon(AJSon : IJSonObject);
    Procedure LoadJSon(AJSon : IJSonObject);

  End;

  IJSonSbtpFile = Interface(ISbtpFile)
    ['{4B61686E-29A0-2112-99E7-7C1B3CE0F0A4}']
    Function GetHeader() : IJSonSbtpHeader;
    Function GetItem() : IJSonSbtpVariables;

    Function  GetAsJSon() : String;
    Procedure SetAsJSon(Const AJSon : String);

    Property Header : IJSonSbtpHeader    Read GetHeader;
    Property Item   : IJSonSbtpVariables Read GetItem;
    Property AsJSon : String             Read GetAsJSon Write SetAsJSon;
    
  End;

(******************************************************************************)

  TJSonSbtpFile = Class(TObject)
  Public
    Class Function CreateSbtpFile() : IJSonSbtpFile; OverLoad;
    Class Function CreateSbtpFile(Const AJSonString : String) : IJSonSbtpFile; OverLoad;

  End;

Implementation

Uses Dialogs, 
  OJsonUtils, HsJSonFormatterEx, HsInterfaceEx, TSTOSbtpImpl;

Type
  TJSonSbtpSubVariable = Class(TSbtpSubVariable, IJSonSbtpSubVariable)
  Protected
    Procedure SaveJSon(AJSon : IJSonObject);
    Procedure LoadJSon(AJSon : IJSonObject);

    Property VariableName : String Read GetVariableName Write SetVariableName;
    Property VariableData : String Read GetVariableData Write SetVariableData;

  End;

  TJSonSbtpSubVariables = Class(TSbtpSubVariables, IJSonSbtpSubVariables)
  Protected
    Function  GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : IJSonSbtpSubVariable; OverLoad;
    Procedure Put(Index : Integer; Const Item : IJSonSbtpSubVariable); OverLoad;

    Function Add() : IJSonSbtpSubVariable; OverLoad;
    Function Add(Const AItem : IJSonSbtpSubVariable) : Integer; OverLoad;

    Procedure SaveJSon(AJSon : IJSonObject);
    Procedure LoadJSon(AJSon : IJSonObject);

    Property Items[Index : Integer] : IJSonSbtpSubVariable Read Get Write Put; Default;

  End;

  TJSonSbtpVariable = Class(TSbtpVariable, IJSonSbtpVariable)
  Protected
    Function GetSubItemClass() : TSbtpSubVariablesClass; OverRide;
    Function GetSubItem() : IJSonSbtpSubVariables; OverLoad;

    Procedure SaveJSon(AJSon : IJSonObject);
    Procedure LoadJSon(AJSon : IJSonObject);

    Property VariableType : String           Read GetVariableType Write SetVariableType;
    Property SubItem : IJSonSbtpSubVariables Read GetSubItem;

  End;

  TJSonSbtpVariables = Class(TSbtpVariables, IJSonSbtpVariables)
  Protected
    Function  GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : IJSonSbtpVariable; OverLoad;
    Procedure Put(Index : Integer; Const Item : IJSonSbtpVariable); OverLoad;

    Function Add() : IJSonSbtpVariable; OverLoad;
    Function Add(Const AItem : IJSonSbtpVariable) : Integer; OverLoad;

    Procedure SaveJSon(AJSon : IJSonObject);
    Procedure LoadJSon(AJSon : IJSonObject);

    Property Items[Index : Integer] : IJSonSbtpVariable Read Get Write Put; Default;

  End;

  TJSonSbtpHeader = Class(TSbtpHeader, IJSonSbtpHeader)
  Protected
    Procedure SaveJSon(AJSon : IJSonObject);
    Procedure LoadJSon(AJSon : IJSonObject);

    Property Header        : String Read GetHeader        Write SetHeader;
    Property HeaderPadding : Word   Read GetHeaderPadding Write SetHeaderPadding;

  End;

  TJSonSbtpFileImpl = Class(TSbtpFile, IJSonSbtpFile)
  Protected
    Function GetHeaderClass() : TSbtpHeaderClass; OverRide;
    Function GetItemClass() : TSbtpVariablesClass; OverRide;

    Function GetHeader() : IJSonSbtpHeader; OverLoad;
    Function GetItem() : IJSonSbtpVariables; OverLoad;

    Function  GetAsJSon() : String;
    Procedure SetAsJSon(Const AJSon : String);

    Property Header : IJSonSbtpHeader    Read GetHeader;
    Property Item   : IJSonSbtpVariables Read GetItem;

  End;

Class Function TJSonSbtpFile.CreateSbtpFile() : IJSonSbtpFile;
Begin
  Result := TJSonSbtpFileImpl.Create();
End;

Class Function TJSonSbtpFile.CreateSbtpFile(Const AJSonString : String) : IJSonSbtpFile;
Begin
  Result := TJSonSbtpFileImpl.Create();
  Result.AsJSon := AJSonString;
End;

(******************************************************************************)

Procedure TJSonSbtpSubVariable.SaveJSon(AJSon : IJSonObject);
Begin
  With AJSon.OpenObject() Do
  Try
    Text('Name', VariableName);
    Text('Data', VariableData);

    Finally
      AJSon.CloseObject();
  End;
End;

Procedure TJSonSbtpSubVariable.LoadJSon(AJSon : IJSonObject);
Var lToken : TCustomJSONReaderToken;
    lCurPairName : String;
Begin
  If AJSon.ReadNextToken(lToken) And (lToken.TokenType = ttOpenObject) Then
    While AJSon.ReadNextToken(lToken) And (lToken.TokenType <> ttCloseObject) Do
      Case lToken.TokenType Of
        ttPairName :
        Begin
          lCurPairName := lToken.PairName;
          If AJSon.ReadNextToken(lToken) And (lToken.TokenType = ttValue) Then
            Case lToken.ValueType Of
              vtString :
              Begin
                If SameText(lCurPairName, 'Name') Then
                  VariableName := lToken.StringValue
                Else If SameText(lCurPairName, 'Data') Then
                  VariableData := lToken.StringValue;
              End;
            End;
        End;
      End;
End;

Function TJSonSbtpSubVariables.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TJSonSbtpSubVariable;
End;

Function TJSonSbtpSubVariables.Get(Index : Integer) : IJSonSbtpSubVariable;
Begin
  Result := InHerited Items[Index] As IJSonSbtpSubVariable;
End;

Procedure TJSonSbtpSubVariables.Put(Index : Integer; Const Item : IJSonSbtpSubVariable);
Begin
  InHerited Items[Index] := Item;
End;

Function TJSonSbtpSubVariables.Add() : IJSonSbtpSubVariable;
Begin
  Result := InHerited Add() As IJSonSbtpSubVariable;
End;

Function TJSonSbtpSubVariables.Add(Const AItem : IJSonSbtpSubVariable) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Procedure TJSonSbtpSubVariables.SaveJSon(AJSon : IJSonObject);
Var X : Integer;
Begin
  With AJSon.OpenArray('SubVariable') Do
  Try
    For X := 0 To Count - 1 Do
      Items[X].SaveJSon(AJSon);

    Finally
      AJSon.CloseArray();
  End;
End;

Procedure TJSonSbtpSubVariables.LoadJSon(AJSon : IJSonObject);
Var lToken : TCustomJSONReaderToken;
Begin
  If AJSon.ReadNextToken(lToken) And (lToken.TokenType = ttOpenArray) Then
    While AJSon.LastToken.TokenType <> ttCloseArray Do
    Begin
      Add().LoadJSon(AJSon);
      AJSon.ReadNextToken(lToken);
    End;
End;

Function TJSonSbtpVariable.GetSubItemClass() : TSbtpSubVariablesClass;
Begin
  Result := TJSonSbtpSubVariables;
End;

Function TJSonSbtpVariable.GetSubItem() : IJSonSbtpSubVariables;
Begin
  Result := InHerited GetSubItem() As IJSonSbtpSubVariables;
End;

Procedure TJSonSbtpVariable.SaveJSon(AJSon : IJSonObject);
Begin
  With AJSon.OpenObject() Do
  Try
    Text('Type', VariableType);
    SubItem.SaveJSon(AJSon);

    Finally
      AJSon.CloseObject();
  End;
End;

Procedure TJSonSbtpVariable.LoadJSon(AJSon : IJSonObject);
Var lToken : TCustomJSONReaderToken;
Begin
  If AJSon.ReadNextToken(lToken) And (lToken.TokenType = ttOpenObject) Then
    While AJSon.ReadNextToken(lToken) And (lToken.TokenType <> ttCloseObject) Do
      Case lToken.TokenType Of
        ttPairName :
        Begin
          If SameText(lToken.PairName, 'Type') And
             AJSon.ReadNextToken(lToken) And
             (lToken.TokenType = ttValue) And
             (lToken.ValueType = vtString) Then
            VariableType := lToken.StringValue
          Else If SameText(lToken.PairName, 'SubVariable') Then
            SubItem.LoadJSon(AJSon);
        End;
      End;
End;

Function TJSonSbtpVariables.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TJSonSbtpVariable;
End;

Function TJSonSbtpVariables.Get(Index : Integer) : IJSonSbtpVariable;
Begin
  Result := InHerited Items[Index] As IJSonSbtpVariable;
End;

Procedure TJSonSbtpVariables.Put(Index : Integer; Const Item : IJSonSbtpVariable);
Begin
  InHerited Items[Index] := Item;
End;

Function TJSonSbtpVariables.Add() : IJSonSbtpVariable;
Begin
  Result := InHerited Add() As IJSonSbtpVariable;
End;

Function TJSonSbtpVariables.Add(Const AItem : IJSonSbtpVariable) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Procedure TJSonSbtpVariables.SaveJSon(AJSon : IJSonObject);
Var X : Integer;
Begin
  With AJSon.OpenArray('SbtpVariable') Do
  Try
    For X := 0 To Count - 1 Do
      Items[X].SaveJSon(AJSon);

    Finally
      AJSon.CloseArray();
  End;
End;

Procedure TJSonSbtpVariables.LoadJSon(AJSon : IJSonObject);
Var lToken  : TCustomJSONReaderToken;
Begin
  If AJSon.ReadNextToken(lToken) And (lToken.TokenType = ttOpenArray) Then
    While AJSon.LastToken.TokenType <> ttCloseArray Do
    Begin
      Add().LoadJSon(AJSon);
      AJSon.ReadNextToken(lToken);
    End;
End;

Procedure TJSonSbtpHeader.SaveJSon(AJSon : IJSonObject);
Begin
  With AJSon.OpenObject('SbtpHeader') Do
  Try
    Text('FileSig', Header);
    Number('Padding', HeaderPadding);

    Finally
      AJSon.CloseObject();
  End;
End;

Procedure TJSonSbtpHeader.LoadJSon(AJSon : IJSonObject);
Var lToken : TCustomJSONReaderToken;
    lCurPairName : String;
Begin
  If AJSon.ReadNextToken(lToken) And (lToken.TokenType = ttOpenObject) Then
    While AJSon.ReadNextToken(lToken) And (lToken.TokenType <> ttCloseObject) Do
    Begin
      Case lToken.TokenType Of
        ttPairName :
        Begin
          lCurPairName := lToken.PairName;
          If AJSon.ReadNextToken(lToken) And
             (lToken.TokenType = ttValue) Then
            Case lToken.ValueType Of
              vtString :
              Begin
                If SameText(lCurPairName, 'FileSig') Then
                  Header := lToken.StringValue;
              End;

              vtNumber :
              Begin
                If SameText(lCurPairName, 'Padding') Then
                  HeaderPadding := lToken.IntegerValue;
              End;
            End;
        End;
      End;
    End;
End;

Function TJSonSbtpFileImpl.GetHeaderClass() : TSbtpHeaderClass;
Begin
  Result := TJSonSbtpHeader;
End;

Function TJSonSbtpFileImpl.GetItemClass() : TSbtpVariablesClass;
Begin
  Result := TJSonSbtpVariables;
End;

Function TJSonSbtpFileImpl.GetHeader() : IJSonSbtpHeader;
Begin
  Result := InHerited GetHeader() As IJSonSbtpHeader;
End;

Function TJSonSbtpFileImpl.GetItem() : IJSonSbtpVariables;
Begin
  Result := InHerited GetItem() As IJSonSbtpVariables;
End;

Function TJSonSbtpFileImpl.GetAsJSon() : String;
Var lWriter : IJSonObject;
Begin
  lWriter := TJSonObject.Create();
  Try
    With lWriter.OpenObject() Do
    Try
      Header.SaveJSon(lWriter);
      Item.SaveJSon(lWriter);

      Finally
        CloseObject();
    End;
    Result := FormatJSonData(lWriter.AsJSon);

    Finally
      lWriter := Nil;
  End;
End;

Procedure TJSonSbtpFileImpl.SetAsJSon(Const AJSon : String);
Var lReader : IJSonObject;
    lToken  : TCustomJSONReaderToken;
Begin
  Header.Clear();
  Item.Clear();

  lReader := TJSonObject.Create();
  Try
    lReader.InitString(AJSon);

    If lReader.ReadNextToken(lToken) And
       (lToken.TokenType = ttOpenObject) Then
      While lReader.ReadNextToken(lToken) And (lToken.TokenType <> ttCloseObject) Do
      Begin
        Case lToken.TokenType Of
          ttPairName :
          Begin
            If SameText(lToken.PairName, 'SbtpHeader') Then
              Header.LoadJSon(lReader)
            Else If SameText(lToken.PairName, 'SbtpVariable') Then
              Item.LoadJSon(lReader);
          End;
        End;
      End;

    Finally
      lReader := Nil;
  End;
End;

End.
