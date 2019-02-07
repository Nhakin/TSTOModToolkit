unit TSTOCustomPatchesImpl;

interface

Uses
  HsInterfaceEx, TSTOCustomPatchesIntf;

Type
  TTSTOPatchData = Class(TInterfacedObjectEx, ITSTOPatchData)
  Private
    FInterfaceState : TInterfaceState;
    FPatchType      : Integer;
    FPatchPath      : WideString;
    FCode           : WideString;

  Protected
    Function  GetInterfaceState() : TInterfaceState;

    Function  GetPatchType() : Integer; Virtual;
    Procedure SetPatchType(Const APatchType : Integer); Virtual;

    Function  GetPatchPath() : WideString; Virtual;
    Procedure SetPatchPath(Const APatchPath : WideString); Virtual;

    Function  GetCode() : WideString; Virtual;
    Procedure SetCode(Const ACode : WideString); Virtual;

    Procedure Clear();

    Property InterfaceState : TInterfaceState Read GetInterfaceState;
    Property PatchType      : Integer         Read GetPatchType Write SetPatchType;
    Property PatchPath      : WideString      Read GetPatchPath Write SetPatchPath;
    Property Code           : WideString      Read GetCode      Write SetCode;

    Procedure Assign(ASource : IInterface); ReIntroduce;

  Public
    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;

  End;

  TTSTOPatchDatasClass = Class Of TTSTOPatchDatas;
  TTSTOPatchDatas = Class(TInterfaceListEx, ITSTOPatchDatas)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : ITSTOPatchData; OverLoad;
    Procedure Put(Index : Integer; Const Item : ITSTOPatchData); OverLoad;

    Function Add() : ITSTOPatchData; ReIntroduce; OverLoad;
    Function Add(Const AItem : ITSTOPatchData) : Integer; OverLoad;

  End;

  TTSTOCustomPatch = Class(TInterfacedObjectEx, ITSTOCustomPatch)
  Private
    FInterfaceState : TInterfaceState;
    FPatchName      : WideString;
    FPatchActive    : Boolean;
    FPatchDesc      : WideString;
    FFileName       : WideString;
    FPatchData      : ITSTOPatchDatas;

  Protected
    Function GetInterfaceState() : TInterfaceState;

    Function GetPatchDatasClass() : TTSTOPatchDatasClass; Virtual;

    Function  GetPatchName() : WideString; Virtual;
    Procedure SetPatchName(Const APatchName : WideString); Virtual;

    Function  GetPatchActive() : Boolean; Virtual;
    Procedure SetPatchActive(Const APatchActive : Boolean); Virtual;

    Function  GetPatchDesc() : WideString; Virtual;
    Procedure SetPatchDesc(Const APatchDesc : WideString); Virtual;

    Function  GetFileName() : WideString; Virtual;
    Procedure SetFileName(Const AFileName : WideString); Virtual;

    Function  GetPatchData() : ITSTOPatchDatas;

    Procedure Clear();
    Procedure Assign(ASource : IInterface); ReIntroduce; Virtual;

    Property InterfaceState : TInterfaceState Read GetInterfaceState;
    Property PatchName      : WideString      Read GetPatchName   Write SetPatchName;
    Property PatchActive    : Boolean         Read GetPatchActive Write SetPatchActive;
    Property PatchDesc      : WideString      Read GetPatchDesc   Write SetPatchDesc;
    Property FileName       : WideString      Read GetFileName    Write SetFileName;
    Property PatchData      : ITSTOPatchDatas Read GetPatchData;

  Public
    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;

  End;

  TTSTOCustomPatchListClass = Class Of TTSTOCustomPatchList;
  TTSTOCustomPatchList = Class(TInterfaceListEx, ITSTOCustomPatchList)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : ITSTOCustomPatch; OverLoad;
    Procedure Put(Index : Integer; Const Item : ITSTOCustomPatch); OverLoad;

    Function Add() : ITSTOCustomPatch; ReIntroduce; OverLoad;
    Function Add(Const AItem : ITSTOCustomPatch) : Integer; OverLoad;

  End;

  TTSTOCustomPatches = Class(TInterfacedObjectEx, ITSTOCustomPatches)
  Private
    FInterfaceState : TInterfaceState;
    FPatches        : ITSTOCustomPatchList;

  Protected
    Function  GetInterfaceState() : TInterfaceState;
    Function  GetCustomPatchListClass() : TTSTOCustomPatchListClass; Virtual;

    Function  GetActivePatchCount() : Integer;

    Function  GetPatches() : ITSTOCustomPatchList;

    Procedure Clear();
    Procedure Assign(ASource : IInterface); ReIntroduce; Virtual;

    Property InterfaceState   : TInterfaceState      Read GetInterfaceState;
    Property ActivePatchCount : Integer              Read GetActivePatchCount;
    Property Patches          : ITSTOCustomPatchList Read GetPatches;

  Public
    Procedure AfterConstruction(); OverRide;
    Procedure BeforeDestruction(); OverRide;

  End;

implementation

Uses SysUtils, RtlConsts;

Procedure TTSTOPatchData.Clear();
Begin
  FPatchType := 0;
  FPatchPath := '';
  FCode      := '';
End;

Procedure TTSTOPatchData.Assign(ASource : IInterface);
Var lSrc : ITSTOPatchData;
Begin
  If Supports(ASource, ITSTOPatchData, lSrc) Then
  Begin
    FPatchType := lSrc.PatchType;
    FPatchPath := lSrc.PatchPath;
    FCode      := lSrc.Code;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Procedure TTSTOPatchData.AfterConstruction();
Begin
  InHerited AfterConstruction();

  FInterfaceState := isCreating;
End;

Procedure TTSTOPatchData.BeforeDestruction();
Begin
  FInterfaceState := isDestroying;

  InHerited BeforeDestruction();
End;

Function TTSTOPatchData.GetInterfaceState() : TInterfaceState;
Begin
  Result := FInterfaceState;
End;

Function TTSTOPatchData.GetPatchType() : Integer;
Begin
  Result := FPatchType;
End;

Procedure TTSTOPatchData.SetPatchType(Const APatchType : Integer);
Begin
  FPatchType := APatchType;
End;

Function TTSTOPatchData.GetPatchPath() : WideString;
Begin
  Result := FPatchPath;
End;

Procedure TTSTOPatchData.SetPatchPath(Const APatchPath : WideString);
Begin
  FPatchPath := APatchPath;
End;

Function TTSTOPatchData.GetCode() : WideString;
Begin
  Result := FCode;
End;

Procedure TTSTOPatchData.SetCode(Const ACode : WideString);
Begin
  FCode := ACode;
End;

Function TTSTOPatchDatas.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TTSTOPatchData;
End;

Function TTSTOPatchDatas.Get(Index : Integer) : ITSTOPatchData;
Begin
  Result := InHerited Items[Index] As ITSTOPatchData;
End;

Procedure TTSTOPatchDatas.Put(Index : Integer; Const Item : ITSTOPatchData);
Begin
  InHerited Items[Index] := Item;
End;

Function TTSTOPatchDatas.Add() : ITSTOPatchData;
Begin
  Result := InHerited Add() As ITSTOPatchData;
End;

Function TTSTOPatchDatas.Add(Const AItem : ITSTOPatchData) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Procedure TTSTOCustomPatch.AfterConstruction();
Begin
  InHerited AfterConstruction();

  FInterfaceState := isCreating;
  FPatchData := GetPatchDatasClass().Create();
End;

Procedure TTSTOCustomPatch.BeforeDestruction();
Begin
  FInterfaceState := isDestroying;
  FPatchData := Nil;

  InHerited BeforeDestruction();
End;

Function TTSTOCustomPatch.GetPatchDatasClass() : TTSTOPatchDatasClass;
Begin
  Result := TTSTOPatchDatas;
End;

Function TTSTOCustomPatch.GetInterfaceState() : TInterfaceState;
Begin
  Result := FInterfaceState;
End;

Procedure TTSTOCustomPatch.Clear();
Begin
  FPatchName   := '';
  FPatchActive := False;
  FPatchDesc   := '';
  FFileName    := '';
  FPatchData.Clear();
End;

Procedure TTSTOCustomPatch.Assign(ASource : IInterface);
Var lSrc : ITSTOCustomPatch;
    X    : Integer;
Begin
  If Supports(ASource, ITSTOCustomPatch, lSrc) Then
  Begin
    FPatchName   := lSrc.PatchName;
    FPatchActive := lSrc.PatchActive;
    FPatchDesc   := lSrc.PatchDesc;
    FFileName    := lSrc.FileName;

    FPatchData.Clear();
    For X := 0 To lSrc.PatchData.Count - 1 Do
      FPatchData.Add().Assign(lSrc.PatchData[X]);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TTSTOCustomPatch.GetPatchName() : WideString;
Begin
  Result := FPatchName;
End;

Procedure TTSTOCustomPatch.SetPatchName(Const APatchName : WideString);
Begin
  FPatchName := APatchName;
End;

Function TTSTOCustomPatch.GetPatchActive() : Boolean;
Begin
  Result := FPatchActive;
End;

Procedure TTSTOCustomPatch.SetPatchActive(Const APatchActive : Boolean);
Begin
  FPatchActive := APatchActive;
End;

Function TTSTOCustomPatch.GetPatchDesc() : WideString;
Begin
  Result := FPatchDesc;
End;

Procedure TTSTOCustomPatch.SetPatchDesc(Const APatchDesc : WideString);
Begin
  FPatchDesc := APatchDesc;
End;

Function TTSTOCustomPatch.GetFileName() : WideString;
Begin
  Result := FFileName;
End;

Procedure TTSTOCustomPatch.SetFileName(Const AFileName : WideString);
Begin
  FFileName := AFileName;
End;

Function TTSTOCustomPatch.GetPatchData() : ITSTOPatchDatas;
Begin
  Result := FPatchData;
End;

Function TTSTOCustomPatchList.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TTSTOCustomPatch;
End;

Function TTSTOCustomPatchList.Get(Index : Integer) : ITSTOCustomPatch;
Begin
  Result := InHerited Items[Index] As ITSTOCustomPatch;
End;

Procedure TTSTOCustomPatchList.Put(Index : Integer; Const Item : ITSTOCustomPatch);
Begin
  InHerited Items[Index] := Item;
End;

Function TTSTOCustomPatchList.Add() : ITSTOCustomPatch;
Begin
  Result := InHerited Add() As ITSTOCustomPatch;
End;

Function TTSTOCustomPatchList.Add(Const AItem : ITSTOCustomPatch) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Procedure TTSTOCustomPatches.AfterConstruction();
Begin
  InHerited AfterConstruction();

  FInterfaceState := isCreating;
  FPatches := GetCustomPatchListClass().Create();
End;

Procedure TTSTOCustomPatches.BeforeDestruction();
Begin
  FInterfaceState := isDestroying;
  FPatches := Nil;

  InHerited BeforeDestruction();
End;

Function TTSTOCustomPatches.GetCustomPatchListClass() : TTSTOCustomPatchListClass;
Begin
  Result := TTSTOCustomPatchList;
End;

Procedure TTSTOCustomPatches.Clear();
Begin
  FPatches.Clear();
End;

Procedure TTSTOCustomPatches.Assign(ASource : IInterface);
Var lSrc : ITSTOCustomPatches;
    X : Integer;
    lPatches : ITSTOCustomPatchList;
Begin
  If Supports(ASource, ITSTOCustomPatches, lSrc) Then
  Begin
    FPatches.Clear();

    lPatches := lSrc.Patches;
    For X := 0 To lPatches.Count - 1 Do
      FPatches.Add().Assign(lPatches[X])
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Function TTSTOCustomPatches.GetActivePatchCount() : Integer;
Var X : Integer;
Begin
  Result := 0;

  For X := 0 To FPatches.Count - 1 Do
    If FPatches[X].PatchActive Then
      Inc(Result);
End;

Function TTSTOCustomPatches.GetPatches() : ITSTOCustomPatchList;
Begin
  Result := FPatches;
End;

Function TTSTOCustomPatches.GetInterfaceState() : TInterfaceState;
Begin
  Result := FInterfaceState;
End;

end.
