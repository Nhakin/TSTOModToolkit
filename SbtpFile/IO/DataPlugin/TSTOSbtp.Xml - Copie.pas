unit TSTOSbtp.Xml;

Interface

Uses Windows, Classes, SysUtils, RTLConsts, HsXmlDocEx;

Type
  IXmlSbtpSubVariable = Interface(IXmlNodeEx)
    ['{4B61686E-29A0-2112-9424-7C6AF115804C}']
    Function  GetVariableName() : String;
    Procedure SetVariableName(Const AVariableName : String);

    Function  GetVariableData() : String;
    Procedure SetVariableData(Const AVariableData : String);

    Procedure Assign(ASource : IInterface);

    Property VariableName : String Read GetVariableName Write SetVariableName;
    Property VariableData : String Read GetVariableData Write SetVariableData;

  End;

  IXmlSbtpSubVariables = Interface(IXmlNodeCollectionEx)
    ['{4B61686E-29A0-2112-93FA-B915A74141AC}']
    Function GetItem(Const Index : Integer) : IXmlSbtpSubVariable;

    Function Add() : IXmlSbtpSubVariable;
    Function Insert(Const Index: Integer) : IXmlSbtpSubVariable;

    Procedure Assign(ASource : IInterface);

    Property Items[Const Index: Integer] : IXmlSbtpSubVariable Read GetItem; Default;

  End;

  IXmlSbtpVariable = Interface(IXmlNodeEx)
    ['{4B61686E-29A0-2112-B27B-D35DBB202C96}']
    Function  GetVariableType() : String;
    Procedure SetVariableType(Const AVariableType : String);

    Function  GetNbSubItems() : DWord;

    Function  GetSubItem() : IXmlSbtpSubVariables;

    Procedure Assign(ASource : IInterface);

    Property VariableType : String               Read GetVariableType Write SetVariableType;
    Property NbSubItems   : DWord                Read GetNbSubItems;
    Property SubItem      : IXmlSbtpSubVariables Read GetSubItem;

  End;

  IXmlSbtpVariables = Interface(IXmlNodeCollectionEx)
    ['{4B61686E-29A0-2112-BDA3-20871446F8A7}']
    Function GetItem(Const Index : Integer) : IXmlSbtpVariable;

    Function Add() : IXmlSbtpVariable;
    Function Insert(Const Index: Integer) : IXmlSbtpVariable;

    Procedure Assign(ASource : IInterface);

    Property Items[Const Index: Integer] : IXmlSbtpVariable Read GetItem; Default;

  End;

  IXmlSbtpHeader = Interface(IXmlNodeEx)
    ['{4B61686E-29A0-2112-8E56-71D8253578A1}']
    Function  GetHeader() : String;
    Procedure SetHeader(Const AHeader : String);

    Function  GetHeaderPadding() : Word;
    Procedure SetHeaderPadding(Const AHeaderPadding : Word);
    Procedure Assign(ASource : IInterface);

    Property Header        : String Read GetHeader        Write SetHeader;
    Property HeaderPadding : Word   Read GetHeaderPadding Write SetHeaderPadding;

  End;

  IXmlSbtpFile = Interface(IXmlNodeEx)
    ['{4B61686E-29A0-2112-A167-F6FB9F504096}']
    Function  GetHeader() : IXmlSbtpHeader;

    Function  GetItem() : IXmlSbtpVariables;

    Procedure Assign(ASource : IInterface);

    Property Header : IXmlSbtpHeader    Read GetHeader;
    Property Item   : IXmlSbtpVariables Read GetItem;

  End;

  IXmlSbtpFiles = Interface(IXmlNodeCollectionEx)
    ['{4B61686E-29A0-2112-9A75-E9F85554694E}']
    Function GetItem(Const Index : Integer) : IXmlSbtpFile;

    Function Add() : IXmlSbtpFile;
    Function Insert(Const Index: Integer) : IXmlSbtpFile;

    Procedure Assign(ASource : IInterface);

    Property Items[Const Index: Integer] : IXmlSbtpFile Read GetItem; Default;

  End;  

(******************************************************************************)

  TXmlSbtpFile = Class(TObject)
  Public
    Class Function CreateSbtpFile() : IXmlSbtpFile; OverLoad;
    Class Function CreateSbtpFile(Const AXmlString : String) : IXmlSbtpFile; OverLoad;

    Class Function CreateSbtpFiles() : IXmlSbtpFiles; OverLoad;
    Class Function CreateSbtpFiles(Const AXmlString : String) : IXmlSbtpFiles; OverLoad;

  End;

Implementation

Uses Dialogs, TypInfo,
  Variants, Forms, XmlIntf, XmlDom, OXmlDOMVendor,
  HsInterfaceEx, TSTOSbtpIntf;

Type
  TXmlSbtpSubVariable = Class(TXmlNodeEx, ISbtpSubVariable, IXmlSbtpSubVariable)
  Private
    FSubVariableImpl : Pointer;
    Function GetImplementor() : ISbtpSubVariable;

  Protected
    Property SubVariableImpl : ISbtpSubVariable Read GetImplementor;

    Function  GetVariableName() : String;
    Procedure SetVariableName(Const AVariableName : String);

    Function  GetVariableData() : String;
    Procedure SetVariableData(Const AVariableData : String);

    Procedure Clear();

    Procedure Assign(ASource : IInterface); ReIntroduce;

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TXmlSbtpSubVariables = Class(TXMLNodeCollectionEx, ISbtpSubVariables, IXmlSbtpSubVariables)
  Private
    FSubVariablesImpl : Pointer;
    Function GetImplementor() : ISbtpSubVariables;

  Protected
    Property SubVariablesImpl : ISbtpSubVariables Read GetImplementor Implements ISbtpSubVariables;

    Function GetItem(Const Index : Integer) : IXmlSbtpSubVariable;

    Function Add() : IXmlSbtpSubVariable;
    Function Insert(Const Index : Integer) : IXmlSbtpSubVariable;

    Procedure Assign(ASource : IInterface); ReIntroduce;
    Procedure AssignTo(ATarget : ISbtpSubVariables);

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TXmlSbtpVariable = Class(TXmlNodeEx, ISbtpVariable, IXmlSbtpVariable)
  Private
    FVariableImpl : Pointer;
    Function GetImplementor() : ISbtpVariable;

  Protected
    Property VariableImpl : ISbtpVariable Read GetImplementor;

    Function  GetVariableType() : String;
    Procedure SetVariableType(Const AVariableType : String);

    Function  GetNbSubItems() : DWord;

    Function  GetSubItem() : IXmlSbtpSubVariables;
    Function  GetISubItem() : ISbtpSubVariables;
    Function  ISbtpVariable.GetSubItem = GetISubItem;

    Procedure Clear();

    Procedure Assign(ASource : IInterface); ReIntroduce;

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TXmlSbtpVariables = Class(TXMLNodeCollectionEx, ISbtpVariables, IXmlSbtpVariables)
  Private
    FVariablesImpl : Pointer;
    Function GetImplementor() : ISbtpVariables;

  Protected
    Property VariablesImpl : ISbtpVariables Read GetImplementor Implements ISbtpVariables;

    Function GetItem(Const Index : Integer) : IXmlSbtpVariable;

    Function Add() : IXmlSbtpVariable;
    Function Insert(Const Index : Integer) : IXmlSbtpVariable;

    Procedure Assign(ASource : IInterface); ReIntroduce;
    Procedure AssignTo(ASource : ISbtpVariables);

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TXmlSbtpHeader = Class(TXmlNodeEx, ISbtpHeader, IXmlSbtpHeader)
  Private
    FHeaderImpl : Pointer;
    Function GetImplementor() : ISbtpHeader;

  Protected
    Property HeaderImpl : ISbtpHeader Read GetImplementor;

    Function  GetHeader() : String;
    Procedure SetHeader(Const AHeader : String);

    Function  GetHeaderPadding() : Word;
    Procedure SetHeaderPadding(Const AHeaderPadding : Word);

    Procedure Clear();

    Procedure Assign(ASource : IInterface); ReIntroduce;

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TXmlSbtpFileImpl = Class(TXmlNodeEx, ISbtpFile, IXmlSbtpFile)
  Private
    FFileImpl : Pointer;
    Function GetImplementor() : ISbtpFile;

  Protected
    Property FileImpl : ISbtpFile Read GetImplementor;

    Function  GetHeader() : IXmlSbtpHeader;
    Function  GetIHeader() : ISbtpHeader;

    Function  GetItem() : IXmlSbtpVariables;
    Function  GetIItem() : ISbtpVariables;

    Function ISbtpFile.GetHeader = GetIHeader;
    Function ISbtpFile.GetItem = GetIItem;

    Procedure Clear();

    Procedure Assign(ASource : IInterface); ReIntroduce;

  Public
    Procedure AfterConstruction(); OverRide;

  End;

  TXmlSbtpFiles = Class(TXMLNodeCollectionEx, ISbtpFiles, IXmlSbtpFiles)
  Private
    FFilesImpl : Pointer;
    Function GetImplementor() : ISbtpFiles;

  Protected
    Property FilesImpl : ISbtpFiles Read GetImplementor Implements ISbtpFiles;

    Function GetItem(Const Index : Integer) : IXmlSbtpFile;

    Function Add() : IXmlSbtpFile;
    Function Insert(Const Index : Integer) : IXmlSbtpFile;

    Procedure Assign(ASource : IInterface); ReIntroduce;
    Procedure AssignTo(ATarget : ISbtpFiles);

  Public
    Procedure AfterConstruction(); OverRide;

  End;

Class Function TXmlSbtpFile.CreateSbtpFile() : IXmlSbtpFile;
Var lXml : TXmlDocumentEx;
Begin
  lXml := TXmlDocumentEx.Create(Nil);
  lXml.DOMVendor := GetDOMVendor(sOXmlDOMVendor);
  lXml.Options := lXml.Options + [doNodeAutoIndent];

  Result := lXml.GetDocBinding('SBTPFile', TXmlSbtpFileImpl) As IXmlSbtpFile;
End;

Class Function TXmlSbtpFile.CreateSbtpFile(Const AXmlString : String) : IXmlSbtpFile;
Var lXml : TXmlDocumentEx;
Begin
  lXml := TXmlDocumentEx.Create(Nil);
  lXml.DOMVendor := GetDOMVendor(sOXmlDOMVendor);
  lXml.Options := lXml.Options + [doNodeAutoIndent];
  lXml.LoadFromXML(AXmlString);
  Result := lXml.GetDocBinding('SBTPFile', TXmlSbtpFileImpl) As IXmlSbtpFile;
End;

Class Function TXmlSbtpFile.CreateSbtpFiles() : IXmlSbtpFiles;
Begin
  Result := NewXmlDocument().GetDocBinding('SBTPFiles', TXmlSbtpFiles) As IXmlSbtpFiles;
End;

Class Function TXmlSbtpFile.CreateSbtpFiles(Const AXmlString : String) : IXmlSbtpFiles;
Begin
  Result := LoadXmlData(AXmlString).GetDocBinding('SBTPFiles', TXmlSbtpFiles) As IXmlSbtpFiles;
End;

(******************************************************************************)

Procedure TXmlSbtpSubVariable.AfterConstruction();
Begin
  FSubVariableImpl := Pointer(ISbtpSubVariable(Self));

  InHerited AfterConstruction();
End;

Function TXmlSbtpSubVariable.GetImplementor() : ISbtpSubVariable;
Begin
  Result := ISbtpSubVariable(FSubVariableImpl);
End;

Procedure TXmlSbtpSubVariable.Clear();
Begin
  ChildNodes['VariableName'].NodeValue := Null;
  ChildNodes['VariableData'].NodeValue := Null;
End;

Procedure TXmlSbtpSubVariable.Assign(ASource : IInterface);
Var lXmlSrc : IXmlSbtpSubVariable;
    lSrc    : ISbtpSubVariable;
Begin
  If Supports(ASource, IXmlNodeEx) And
     Supports(ASource, IXmlSbtpSubVariable, lXmlSrc) Then
  Begin
    ChildNodes['VariableName'].NodeValue := lXmlSrc.VariableName;
    ChildNodes['VariableData'].NodeValue := lXmlSrc.VariableData;
  End
  Else If Supports(ASource, ISbtpSubVariable, lSrc) Then
  Begin
    FSubVariableImpl := Pointer(lSrc);

    ChildNodes['VariableName'].NodeValue := lSrc.VariableName;
    ChildNodes['VariableData'].NodeValue := lSrc.VariableData;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TXmlSbtpSubVariable.GetVariableName() : String;
Begin
  Result := ChildNodes['VariableName'].AsString;
End;

Procedure TXmlSbtpSubVariable.SetVariableName(Const AVariableName : String);
Begin
  ChildNodes['VariableName'].AsString := AVariableName;

  If Not IsImplementorOf(SubVariableImpl) Then
    SubVariableImpl.VariableName := AVariableName;
End;

Function TXmlSbtpSubVariable.GetVariableData() : String;
Begin
  Result := ChildNodes['VariableData'].AsString;
End;

Procedure TXmlSbtpSubVariable.SetVariableData(Const AVariableData : String);
Begin
  ChildNodes['VariableData'].AsString := AVariableData;

  If Not IsImplementorOf(SubVariableImpl) Then
    SubVariableImpl.VariableData := AVariableData;
End;

Procedure TXmlSbtpSubVariables.AfterConstruction();
Begin
  RegisterChildNode('SbtpSubVariable', TXmlSbtpSubVariable);
  ItemTag       := 'SbtpSubVariable';
  ItemInterface := IXmlSbtpSubVariable;
  FSubVariablesImpl := Nil;
  
  InHerited AfterConstruction();
End;

Function TXmlSbtpSubVariables.GetImplementor() : ISbtpSubVariables;
Begin
  If Not Assigned(FSubVariablesImpl) Then
  Begin
    Result := TSbtpFile.CreateSbtpSubVariables();
    AssignTo(Result);

    FSubVariablesImpl := Pointer(Result);
  End
  Else
    Result := ISbtpSubVariables(FSubVariablesImpl);
End;

Function TXmlSbtpSubVariables.GetItem(Const Index : Integer) : IXmlSbtpSubVariable;
Begin
  Result := List[Index] As IXmlSbtpSubVariable;
End;

Function TXmlSbtpSubVariables.Add() : IXmlSbtpSubVariable;
Begin
  Result := AddItem(-1) As IXmlSbtpSubVariable;

  If Assigned(FSubVariablesImpl) Then
    SubVariablesImpl.Add(Result As ISbtpSubVariable);
End;

Function TXmlSbtpSubVariables.Insert(Const Index : Integer) : IXmlSbtpSubVariable;
Begin
  Result := AddItem(Index) As IXmlSbtpSubVariable;
End;

Procedure TXmlSbtpSubVariables.Assign(ASource : IInterface);
Var lXmlSrc : IXmlSbtpSubVariables;
    lSrc    : ISbtpSubVariables;
    X       : Integer;
Begin
  If Supports(ASource, IXMLNodeCollectionEx) And
     Supports(ASource, IXmlSbtpSubVariables, lXmlSrc) Then
  Begin
    Clear();

    For X := 0 To lXmlSrc.Count - 1 Do
    Begin
      Add().Assign(lXmlSrc[X]);
      Application.ProcessMessages();
    End;
  End
  Else If Supports(ASource, ISbtpSubVariables, lSrc) Then
  Begin
    FSubVariablesImpl := Pointer(lSrc);

    Clear();
    For X := 0 To lSrc.Count - 1 Do
    Begin
      Add().Assign(lSrc[X]);
      Application.ProcessMessages();
    End;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Procedure TXmlSbtpSubVariables.AssignTo(ATarget : ISbtpSubVariables);
Var X : Integer;
    lItem : ISbtpSubVariable;
Begin
  ATarget.Clear();

  For X := 0 To Count - 1 Do
  Begin
    If Supports(List[X], ISbtpSubVariable, lItem) Then
      ATarget.Add().Assign(lItem);
  End;
End;

Procedure TXmlSbtpVariable.AfterConstruction();
Begin
  RegisterChildNode('SubItem', TXmlSbtpSubVariables);

  FVariableImpl := Pointer(ISbtpVariable(Self));
  InHerited AfterConstruction();
End;

Function TXmlSbtpVariable.GetImplementor() : ISbtpVariable;
Begin
  Result := ISbtpVariable(FVariableImpl);
End;

Procedure TXmlSbtpVariable.Clear();
Begin
  ChildNodes['VariableType'].NodeValue := Null;
  ChildNodes['SubItem'].NodeValue      := Null;
End;

Procedure TXmlSbtpVariable.Assign(ASource : IInterface);
Var lXmlSrc : IXmlSbtpVariable;
    lSrc    : ISbtpVariable;
Begin
  If Supports(ASource, IXmlNodeEx) And
     Supports(ASource, IXmlSbtpVariable, lXmlSrc) Then
  Begin
    ChildNodes['VariableType'].NodeValue := lXmlSrc.VariableType;
    GetSubItem().Assign(lXmlSrc.SubItem);
  End
  Else If Supports(ASource, ISbtpVariable, lSrc) Then
  Begin
    FVariableImpl := Pointer(lSrc);

    ChildNodes['VariableType'].NodeValue := lSrc.VariableType;
    GetSubItem().Assign(lSrc.SubItem);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TXmlSbtpVariable.GetVariableType() : String;
Begin
  Result := ChildNodes['VariableType'].AsString;
End;

Procedure TXmlSbtpVariable.SetVariableType(Const AVariableType : String);
Begin
  ChildNodes['VariableType'].AsString := AVariableType;

  If Not IsImplementorOf(VariableImpl) Then
    VariableImpl.VariableType := AVariableType;
End;

Function TXmlSbtpVariable.GetNbSubItems() : DWord;
Begin
  Result := GetSubItem().Count;
End;

Function TXmlSbtpVariable.GetSubItem() : IXmlSbtpSubVariables;
Begin
  Result := ChildNodes['SubItem'] As IXmlSbtpSubVariables;
End;

Function TXmlSbtpVariable.GetISubItem() : ISbtpSubVariables;
Begin
  Result := ChildNodes['SubItem'] As ISbtpSubVariables;
End;

Procedure TXmlSbtpVariables.AfterConstruction();
Begin
  RegisterChildNode('SbtpVariable', TXmlSbtpVariable);
  ItemTag       := 'SbtpVariable';
  ItemInterface := IXmlSbtpVariable;
  FVariablesImpl := Nil;
  
  InHerited AfterConstruction();
End;

Function TXmlSbtpVariables.GetImplementor() : ISbtpVariables;
Begin
  If Not Assigned(FVariablesImpl) Then
  Begin
    Result := TSbtpFile.CreateSbtpVariables();
    AssignTo(Result);
    FVariablesImpl := Pointer(Result);
  End
  Else
    Result := ISbtpVariables(FVariablesImpl);
End;

Function TXmlSbtpVariables.GetItem(Const Index : Integer) : IXmlSbtpVariable;
Begin
  Result := List[Index] As IXmlSbtpVariable;
End;

Function TXmlSbtpVariables.Add() : IXmlSbtpVariable;
Begin
  Result := AddItem(-1) As IXmlSbtpVariable;
  If Assigned(FVariablesImpl) Then
//    VariablesImpl.Add().Assign(Result);
    VariablesImpl.Add(Result As ISbtpVariable);
End;

Function TXmlSbtpVariables.Insert(Const Index : Integer) : IXmlSbtpVariable;
Begin
  Result := AddItem(Index) As IXmlSbtpVariable;
End;

Procedure TXmlSbtpVariables.Assign(ASource : IInterface);
Var lXmlSrc : IXmlSbtpVariables;
    lSrc    : ISbtpVariables;
    X       : Integer;
Begin
  If Supports(ASource, IXMLNodeCollectionEx) And
     Supports(ASource, IXmlSbtpVariables, lXmlSrc) Then
  Begin
    Clear();

    For X := 0 To lXmlSrc.Count - 1 Do
      Add().Assign(lXmlSrc[X]);
  End
  Else If Supports(ASource, ISbtpVariables, lSrc) Then
  Begin
    FVariablesImpl := Pointer(lSrc);
    
    Clear();
    For X := 0 To lSrc.Count - 1 Do
      Add().Assign(lSrc[X]);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Procedure TXmlSbtpVariables.AssignTo(ASource : ISbtpVariables);
Var X : Integer;
    lItem : ISbtpVariable;
Begin
  ASource.Clear();

  For X := 0 To Count - 1 Do
    If Supports(List[X], ISbtpVariable, lItem) Then
      ASource.Add().Assign(lItem);
End;

Procedure TXmlSbtpHeader.AfterConstruction();
Begin
  FHeaderImpl := Pointer(ISbtpHeader(Self));

  InHerited AfterConstruction();
End;

Function TXmlSbtpHeader.GetImplementor() : ISbtpHeader;
Begin
  Result := ISbtpHeader(FHeaderImpl);
End;

Procedure TXmlSbtpHeader.Clear();
Begin
  ChildNodes['Header'].NodeValue        := Null;
  ChildNodes['HeaderPadding'].NodeValue := Null;
End;

Procedure TXmlSbtpHeader.Assign(ASource : IInterface);
Var lXmlSrc : IXmlSbtpHeader;
    lSrc    : ISbtpHeader;
Begin
  If Supports(ASource, IXmlNodeEx) And
     Supports(ASource, IXmlSbtpHeader, lXmlSrc) Then
  Begin
    ChildNodes['Header'].NodeValue        := lXmlSrc.Header;
    ChildNodes['HeaderPadding'].NodeValue := lXmlSrc.HeaderPadding;
  End
  Else If Supports(ASource, ISbtpHeader, lSrc) Then
  Begin
    FHeaderImpl := Pointer(lSrc);

    ChildNodes['Header'].NodeValue        := lSrc.Header;
    ChildNodes['HeaderPadding'].NodeValue := lSrc.HeaderPadding;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TXmlSbtpHeader.GetHeader() : String;
Begin
  Result := ChildNodes['Header'].AsString;
End;

Procedure TXmlSbtpHeader.SetHeader(Const AHeader : String);
Begin
  ChildNodes['Header'].AsString := AHeader;
  If Not IsImplementorOf(HeaderImpl) Then
    HeaderImpl.Header := AHeader;
End;

Function TXmlSbtpHeader.GetHeaderPadding() : Word;
Begin
  Result := ChildNodes['HeaderPadding'].AsInteger;
End;

Procedure TXmlSbtpHeader.SetHeaderPadding(Const AHeaderPadding : Word);
Begin
  ChildNodes['HeaderPadding'].AsInteger := AHeaderPadding;
  If Not IsImplementorOf(HeaderImpl) Then
    HeaderImpl.HeaderPadding := AHeaderPadding;
End;

Procedure TXmlSbtpFileImpl.AfterConstruction();
Begin
  RegisterChildNode('Header', TXmlSbtpHeader);
  RegisterChildNode('Item', TXmlSbtpVariables);

  FFileImpl := Pointer(ISbtpFile(Self));

  InHerited AfterConstruction();
End;

Function TXmlSbtpFileImpl.GetImplementor() : ISbtpFile;
Begin
  Result := ISbtpFile(FFileImpl);
End;

Procedure TXmlSbtpFileImpl.Clear();
Begin
  ChildNodes['Header'].NodeValue := Null;
  ChildNodes['Item'].NodeValue   := Null;
End;

Procedure TXmlSbtpFileImpl.Assign(ASource : IInterface);
Var lXmlSrc : IXmlSbtpFile;
    lSrc : ISbtpFile;
Begin
  If Supports(ASource, IXmlNodeEx) And
     Supports(ASource, IXmlSbtpFile, lXmlSrc) Then
  Begin
    GetHeader().Assign(lXmlSrc.Header);
    GetItem().Assign(lXmlSrc.Item);
  End
  Else If Supports(ASource, ISbtpFile, lSrc) Then
  Begin
    FFileImpl := Pointer(lSrc);

    GetHeader().Assign(lSrc.Header);
    GetItem().Assign(lSrc.Item);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TXmlSbtpFileImpl.GetHeader() : IXmlSbtpHeader;
Begin
  Result := ChildNodes['Header'] As IXmlSbtpHeader;
End;

Function TXmlSbtpFileImpl.GetIHeader() : ISbtpHeader;
Begin
  Result := GetHeader() As ISbtpHeader;
End;

Function TXmlSbtpFileImpl.GetItem() : IXmlSbtpVariables;
Begin
  Result := ChildNodes['Item'] As IXmlSbtpVariables;
End;

Function TXmlSbtpFileImpl.GetIItem() : ISbtpVariables;
Begin
  Result := GetItem() As ISbtpVariables;
End;

Procedure TXmlSbtpFiles.AfterConstruction();
Begin
  RegisterChildNode('SBTPFile', TXmlSbtpFileImpl);
  ItemTag       := 'SBTPFile';
  ItemInterface := IXmlSbtpFile;

  InHerited AfterConstruction();
End;

Function TXmlSbtpFiles.GetImplementor() : ISbtpFiles;
Begin
  If Not Assigned(FFilesImpl) Then
  Begin
    Result := TSbtpFile.CreateSbtpFiles();
    AssignTo(Result);

    FFilesImpl := Pointer(Result);
  End
  Else
    Result := ISbtpFiles(FFilesImpl);
End;

Procedure TXmlSbtpFiles.Assign(ASource : IInterface);
Var lXmlSrc : IXmlSbtpFiles;
    lSrc    : ISbtpFiles;
    X       : Integer;
Begin
  If Supports(ASource, IXMLNodeCollectionEx) And
     Supports(ASource, IXmlSbtpFiles, lXmlSrc) Then
  Begin
    Clear();

    For X := 0 To lXmlSrc.Count - 1 Do
      Add().Assign(lXmlSrc[X]);
  End
  Else If Supports(ASource, ISbtpFiles, lSrc) Then
  Begin
    FFilesImpl := Pointer(lSrc);

    Clear();
    For X := 0 To lSrc.Count - 1 Do
      Add().Assign(lSrc[X]);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Procedure TXmlSbtpFiles.AssignTo(ATarget : ISbtpFiles);
Var X : Integer;
Begin
  ATarget.Clear();

  For X := 0 To List.Count - 1 Do
    ATarget.Add().Assign(List[X]);
End;

Function TXmlSbtpFiles.GetItem(Const Index : Integer) : IXmlSbtpFile;
Begin
  Result := List[Index] As IXmlSbtpFile;
End;

Function TXmlSbtpFiles.Add() : IXmlSbtpFile;
Begin
  Result := AddItem(-1) As IXmlSbtpFile;
  If Assigned(FFilesImpl) Then
    FilesImpl.Add(Result As ISbtpFile);
End;

Function TXmlSbtpFiles.Insert(Const Index : Integer) : IXmlSbtpFile;
Begin
  Result := AddItem(Index) As IXmlSbtpFile;
End;

End.

