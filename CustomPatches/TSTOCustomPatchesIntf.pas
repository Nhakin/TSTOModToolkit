unit TSTOCustomPatchesIntf;

interface

Uses HsInterfaceEx;

Type
  ITSTOPatchData = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-8A2C-401F6BBB0CCC}']
    Function  GetInterfaceState() : TInterfaceState;

    Function  GetPatchType() : Integer;
    Procedure SetPatchType(Const APatchType : Integer);

    Function  GetPatchPath() : WideString;
    Procedure SetPatchPath(Const APatchPath : WideString);

    Function  GetCode() : WideString;
    Procedure SetCode(Const ACode : WideString);

    Procedure Assign(ASource : IInterface);

    Property InterfaceState : TInterfaceState Read GetInterfaceState;
    Property PatchType      : Integer         Read GetPatchType Write SetPatchType;
    Property PatchPath      : WideString      Read GetPatchPath Write SetPatchPath;
    Property Code           : WideString      Read GetCode      Write SetCode;

  End;

  ITSTOPatchDatas = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-B632-9DA31BA6BE39}']
    Function  Get(Index : Integer) : ITSTOPatchData;
    Procedure Put(Index : Integer; Const Item : ITSTOPatchData);

    Function Add() : ITSTOPatchData; OverLoad;
    Function Add(Const AItem : ITSTOPatchData) : Integer; OverLoad;

    Property Items[Index : Integer] : ITSTOPatchData Read Get Write Put; Default;

  End;

  ITSTOCustomPatch = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-BB3E-3D4F9116C15A}']
    Function GetInterfaceState() : TInterfaceState;

    Function  GetPatchName() : WideString;
    Procedure SetPatchName(Const APatchName : WideString);

    Function  GetPatchActive() : Boolean;
    Procedure SetPatchActive(Const APatchActive : Boolean);

    Function  GetPatchDesc() : WideString;
    Procedure SetPatchDesc(Const APatchDesc : WideString);

    Function  GetFileName() : WideString;
    Procedure SetFileName(Const AFileName : WideString);

    Function  GetPatchData() : ITSTOPatchDatas;

    Procedure Assign(ASource : IInterface);

    Property InterfaceState : TInterfaceState Read GetInterfaceState;
    Property PatchName      : WideString      Read GetPatchName   Write SetPatchName;
    Property PatchActive    : Boolean         Read GetPatchActive Write SetPatchActive;
    Property PatchDesc      : WideString      Read GetPatchDesc   Write SetPatchDesc;
    Property FileName       : WideString      Read GetFileName    Write SetFileName;
    Property PatchData      : ITSTOPatchDatas Read GetPatchData;

  End;

  ITSTOCustomPatchList = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-82BA-B6A965408045}']
    Function  Get(Index : Integer) : ITSTOCustomPatch;
    Procedure Put(Index : Integer; Const Item : ITSTOCustomPatch);

    Function Add() : ITSTOCustomPatch; OverLoad;
    Function Add(Const AItem : ITSTOCustomPatch) : Integer; OverLoad;

    Property Items[Index : Integer] : ITSTOCustomPatch Read Get Write Put; Default;

  End;

  ITSTOCustomPatches = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-B69C-ED06DD06DF1B}']
    Function GetInterfaceState() : TInterfaceState;

    Function  GetActivePatchCount() : Integer;

    Function  GetPatches() : ITSTOCustomPatchList;

    Procedure Assign(ASource : IInterface);

    Property InterfaceState   : TInterfaceState      Read GetInterfaceState;
    Property ActivePatchCount : Integer              Read GetActivePatchCount;
    Property Patches          : ITSTOCustomPatchList Read GetPatches;

  End;

implementation

end.
