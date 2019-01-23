unit HsDataSetEx;

interface

Uses Classes, ADODB, DB, DbClient, HsInterfaceEx;

Type
  IDataSetRowEx = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-B89E-CB8DA62D0F3F}']
  End;

  IDataSetEx = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-97E9-17B768BD856E}']
    Function GetItems(Index : Integer) : IDataSetRowEx;
    Function GetCount() : Integer;
    Function GetAsDataSet() : TClientDataSet;

    Procedure Append();
    Procedure Post();

    Property Items[Index : Integer] : IDataSetRowEx Read GetItems; Default;
    Property Count : Integer Read GetCount;
    Property AsDataSet : TClientDataSet Read GetAsDataSet;

  End;

  TDataSetRowExClass = Class Of TDataSetRowEx;
  
  TDataSetRowEx = Class(TInterfacedObjectEx, IDataSetRowEx)
  Private
    FDataSet : TClientDataSet;
    FDataState : TIntegerField;

    Function GetDataSet() : TClientDataSet;
    Procedure Changed();

  Protected
    Function AddField(Const AFieldName : String; Const ADataType : TDataType;
        Const AFieldKind : TFieldKind = fkData; Const ASize : Integer = 0) : TField;
    Procedure InternalSetFieldValue(Const AField : TField; Const AValue : Variant);

    Procedure InitFields(); Virtual; Abstract; 

    Property DataSet : TClientDataSet Read GetDataSet;

  Public
    Constructor Create(ADataSet : TClientDataSet); ReIntroduce;
    Destructor  Destroy(); OverRide;

  End;

  TDataSetEx = Class(TClientDataSet, IDataSetEx)
  Private
    FImpl : TInterfaceExImplementor;
    FData : TDataSetRowEx;

  Protected
    Function GetImplementor() : TInterfaceExImplementor;
    Property DataSetImplementor : TInterfaceExImplementor Read GetImplementor Implements IDataSetEx;

    Function GetRowClass() : TDataSetRowExClass; Virtual;

    Function GetItems(Index : Integer) : IDataSetRowEx;
    Function GetCount() : Integer;
    Function GetAsDataSet() : TClientDataSet;

    Property Data : TDataSetRowEx Read FData;

  Public
    Constructor Create(); ReIntroduce;
    Destructor  Destroy(); OverRide;

  End;

(*
Type
  IMyRowEx = Interface(IDataSetRowEx)
    ['{4B61686E-29A0-2112-8087-EA083D778727}']
    Function  GetPolicyNbr() : String;
    Procedure SetPolicyNbr(Const APolicyNbr : String);

    Function  GetApplName() : String;
    Procedure SetApplName(Const AApplName : String);

    Property PolicyNbr : String Read GetPolicyNbr Write SetPolicyNbr;
    Property ApplName  : String Read GetApplName  Write SetApplName;

  End;

  IMyDataSetEx = Interface(IDataSetEx)
    ['{4B61686E-29A0-2112-97E9-17B768BD856E}']
    Function GetItems(Index : Integer) : IMyRowEx;

    Procedure AddRow(Const APolicyNbr, AApplName : String);

    Property Items[Index : Integer] : IMyRowEx Read GetItems; Default;

  End;
    
  TMyRowEx = Class(TDataSetRowEx, IMyRowEx)
  Private
    FPolicyNbr : TStringField;
    FApplName  : TStringField;

  Protected
    Procedure InitFields(); OverRide;

    Function  GetPolicyNbr() : String;
    Procedure SetPolicyNbr(Const APolicyNbr : String);

    Function  GetApplName() : String;
    Procedure SetApplName(Const AApplName : String);

  End;

  TMyDataSetEx = Class(TDataSetEx, IMyDataSetEx)
  Protected
    Property DataSetImplementor : TInterfaceExImplementor Read GetImplementor Implements IMyDataSetEx;
    
    Function GetRowClass() : TDataSetRowExClass; OverRide;
    Function GetItems(Index : Integer) : IMyRowEx; OverLoad;
    Function GetData() : IMyRowEx;

    Procedure AddRow(Const APolicyNbr, AApplName : String);

    Property Data : IMyRowEx Read GetData;

  End;

Procedure TMyRowEx.InitFields();
Begin
  FPolicyNbr := AddField('PolicyNbr', ftString, fkData, 15) As TStringField;
  FApplName  := AddField('ApplName', ftString, fkData, 50) As TStringField;
End;

Function TMyRowEx.GetPolicyNbr() : String;
Begin
  Result := FPolicyNbr.AsString;
End;

Procedure TMyRowEx.SetPolicyNbr(Const APolicyNbr : String);
Begin
  InternalSetFieldValue(FPolicyNbr, APolicyNbr);
End;

Function TMyRowEx.GetApplName() : String;
Begin
  Result := FApplName.AsString;
End;

Procedure TMyRowEx.SetApplName(Const AApplName : String);
Begin
  InternalSetFieldValue(FApplName, AApplName);
End;

Function TMyDataSetEx.GetRowClass() : TDataSetRowExClass;
Begin
  Result := TMyRowEx;
End;

Function TMyDataSetEx.GetItems(Index : Integer) : IMyRowEx;
Begin
  Result := InHerited GetItems(Index) As IMyRowEx;
End;

Function TMyDataSetEx.GetData() : IMyRowEx;
Var lRow : TDataSetRowEx;
Begin
  lRow := InHerited Data;
  Supports(lRow, IMyRowEx, Result)
End;

Procedure TMyDataSetEx.AddRow(Const APolicyNbr, AApplName : String);
Begin
  Append();

  With Data Do
  Begin
    PolicyNbr := APolicyNbr;
    ApplName  := AApplName; 
  End;

  Post();
End;  
*)

implementation

Uses SysUtils;

Type
  TDataState = (edsBrowse, edsAdded, edsModified, edsDeleted);

Constructor TDataSetRowEx.Create(ADataSet : TClientDataSet);
Begin
  InHerited Create(False);

  FDataSet := ADataSet;

  InitFields();
  FDataState := AddField('DataState', ftInteger) As TIntegerField;
End;

Destructor TDataSetRowEx.Destroy();
Begin
  InHerited Destroy();
End;

Function TDataSetRowEx.GetDataSet() : TClientDataSet;
Begin
  Result := FDataSet;
End;

Function TDataSetRowEx.AddField(Const AFieldName : String; Const ADataType : TDataType; Const AFieldKind : TFieldKind = fkData; Const ASize : Integer = 0) : TField;
Type
  SetOfValidDataType = Set Of TFieldType;

  ValidGrpDataType = (gdtString, gdtInteger, gdtFloat, gdtDateTime, gdtBoolean, gtdVariant);

Const
  FieldDefGrpClass : Array[ValidGrpDataType] Of SetOfValidDataType = (
   [ftString, ftWideString, ftFixedChar],
   [ftSmallint, ftInteger, ftLargeint, ftWord],
   [ftFloat, ftCurrency],
   [ftDate, ftTime, ftDateTime],
   [ftBoolean],
   [ftVariant]
  );

  FieldDefClass : Array[ValidGrpDataType] Of TFieldClass = (
   TStringField, TIntegerField, TFloatField, TDateTimeField, TBooleanField, TVariantField
  );
  MoneyFieldFormat = '#0.0000;-#0.0000';

Var X : ValidGrpDataType;
Begin
  Result := Nil;
    
  For X := Low(ValidGrpDataType) To High(ValidGrpDataType) Do
    If ADataType In FieldDefGrpClass[X] Then
    Begin
      Result := FieldDefClass[X].Create(FDataSet);
      With Result Do
      Begin
        FieldName := AFieldName;
        Name      := FDataSet.Name + FieldName;
        FieldKind := AFieldKind;
        DataSet   := FDataSet;
        Size      := ASize;

        Break;
      End;
    End;
End;

Procedure TDataSetRowEx.Changed();
Begin
  Case TDataState(FDataState.AsInteger) Of
    edsBrowse : FDataState.AsInteger := Ord(edsModified);
  End;
End;

Procedure TDataSetRowEx.InternalSetFieldValue(Const AField : TField; Const AValue : Variant);
Begin
  If AField.Value <> AValue Then
  Begin
    If FDataSet.State = dsBrowse Then
      FDataSet.Edit();
    AField.Value := AValue;

    Changed();
  End;
End;

(******************************************************************************)

Constructor TDataSetEx.Create();
Begin
  InHerited Create(Nil);

  FData := GetRowClass().Create(Self);
  CreateDataSet();
End;

Destructor TDataSetEx.Destroy();
Begin
  FreeAndNil(FData);
  InHerited Destroy();
End;

Function TDataSetEx.GetImplementor() : TInterfaceExImplementor;
Begin
  If Not Assigned(FImpl) Then
    FImpl := TInterfaceExImplementor.Create(Self);

  Result := FImpl;
End;

Function TDataSetEx.GetRowClass() : TDataSetRowExClass;
Begin
  Result := TDataSetRowEx;
End;

Function TDataSetEx.GetItems(Index : Integer) : IDataSetRowEx;
Begin
  RecNo  := Index;
  Result := FData;
End;

Function TDataSetEx.GetCount() : Integer;
Begin
  Result := RecordCount;
End;

Function TDataSetEx.GetAsDataSet() : TClientDataSet;
Begin
  Result := Self;
End;

end.
