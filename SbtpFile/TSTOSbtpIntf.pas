unit TSTOSbtpIntf;

Interface

Uses Windows, Classes, SysUtils, HsInterfaceEx;

Type
  ISbtpSubVariable = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-ACC5-11ABFE2E8AE6}']
    Function  GetVariableName() : String;
    Procedure SetVariableName(Const AVariableName : String);

    Function  GetVariableData() : String;
    Procedure SetVariableData(Const AVariableData : String);

    Procedure Assign(ASource : IInterface);

    Property VariableName : String Read GetVariableName Write SetVariableName;
    Property VariableData : String Read GetVariableData Write SetVariableData;

  End;

  ISbtpSubVariables = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-AD16-759EDCAAB9C2}']
    Function  Get(Index : Integer) : ISbtpSubVariable;
    Procedure Put(Index : Integer; Const Item : ISbtpSubVariable);

    Function Add() : ISbtpSubVariable; OverLoad;
    Function Add(Const AItem : ISbtpSubVariable) : Integer; OverLoad;

    Procedure Assign(ASource : IInterface);
    Function IndexOf(Const AVariableName : String) : Integer;

    Property Items[Index : Integer] : ISbtpSubVariable Read Get Write Put; Default;

  End;

  ISbtpVariable = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-A664-5C2711E17303}']
    Function  GetVariableType() : String;
    Procedure SetVariableType(Const AVariableType : String);

    Function  GetNbSubItems() : DWord;

    Function  GetSubItem() : ISbtpSubVariables;

    Procedure Assign(ASource : IInterface);

    Property VariableType : String            Read GetVariableType Write SetVariableType;
    Property NbSubItems   : DWord             Read GetNbSubItems;
    Property SubItem      : ISbtpSubVariables Read GetSubItem;

  End;

  ISbtpVariables = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-A002-6CC05ECF025D}']
    Function  Get(Index : Integer) : ISbtpVariable;
    Procedure Put(Index : Integer; Const Item : ISbtpVariable);

    Function Add() : ISbtpVariable; OverLoad;
    Function Add(Const AItem : ISbtpVariable) : Integer; OverLoad;

    Procedure Assign(ASource : IInterface);
    Function IndexOf(Const AVariableType : String) : Integer;

    Property Items[Index : Integer] : ISbtpVariable Read Get Write Put; Default;

  End;

  ISbtpHeader = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-8457-61895A539B6F}']
    Function  GetHeader() : String;
    Procedure SetHeader(Const AHeader : String);

    Function  GetHeaderPadding() : Word;
    Procedure SetHeaderPadding(Const AHeaderPadding : Word);

    Procedure Assign(ASource : IInterface);
    Procedure Clear();
    
    Property Header        : String Read GetHeader        Write SetHeader;
    Property HeaderPadding : Word   Read GetHeaderPadding Write SetHeaderPadding;

  End;

  ISbtpFile = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-9796-5A92D84911C9}']
    Function  GetHeader() : ISbtpHeader;

    Function  GetItem() : ISbtpVariables;

    Procedure Assign(ASource : IInterface);

    Property Header : ISbtpHeader    Read GetHeader;
    Property Item   : ISbtpVariables Read GetItem;

  End;

  ISbtpFiles = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-E2F1-6CC05ECFA599}']
    Function  Get(Index : Integer) : ISbtpFile;
    Procedure Put(Index : Integer; Const Item : ISbtpFile);

    Function Add() : ISbtpFile; OverLoad;
    Function Add(Const AItem : ISbtpFile) : Integer; OverLoad;

    Procedure Assign(ASource : IInterface);

    Property Items[Index : Integer] : ISbtpFile Read Get Write Put; Default;

  End;

(******************************************************************************)

  TSbtpFile = Class(TObject)
  Public
    Class Function CreateSbtpFiles() : ISbtpFiles;
    Class Function CreateSbtpFile() : ISbtpFile;
    Class Function CreateSbtpSubVariables() : ISbtpSubVariables;
    Class Function CreateSbtpVariables() : ISbtpVariables;

  End;

Implementation

Uses TSTOSbtpImpl;

Class Function TSbtpFile.CreateSbtpFiles() : ISbtpFiles;
Begin
  Result := TSTOSbtpImpl.TSbtpFiles.Create();
End;

Class Function TSbtpFile.CreateSbtpFile() : ISbtpFile;
Begin
  Result := TSTOSbtpImpl.TSbtpFile.Create();
End;

Class Function TSbtpFile.CreateSbtpSubVariables() : ISbtpSubVariables;
Begin
  Result := TSTOSbtpImpl.TSbtpSubVariables.Create();
End;

Class Function TSbtpFile.CreateSbtpVariables() : ISbtpVariables;
Begin
  Result := TSTOSbtpImpl.TSbtpVariables.Create();
End;

End.

