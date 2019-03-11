unit TSTOCustomPatchesIntf;

interface

Uses Classes, HsInterfaceEx;

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

(******************************************************************************)

  ITSTOPatchDataIO = Interface(ITSTOPatchData)
    ['{4B61686E-29A0-2112-BEDF-E83EBF2AEC51}']
    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

    Property OnChange : TNotifyEvent Read GetOnChange Write SetOnChange;

  End;

  ITSTOPatchDatasIO = Interface(ITSTOPatchDatas)
    ['{4B61686E-29A0-2112-BB65-879B0C21F3FC}']
    Function  Get(Index : Integer) : ITSTOPatchDataIO;
    Procedure Put(Index : Integer; Const Item : ITSTOPatchDataIO);

    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

    Function Add() : ITSTOPatchDataIO; OverLoad;
    Function Add(Const AItem : ITSTOPatchDataIO) : Integer; OverLoad;
    Function Remove(Const AItem : ITSTOPatchDataIO) : Integer;

    Property Items[Index : Integer] : ITSTOPatchDataIO Read Get Write Put; Default;

    Property OnChange : TNotifyEvent Read GetOnChange Write SetOnChange;

  End;

  ITSTOCustomPatchIO = Interface(ITSTOCustomPatch)
    ['{4B61686E-29A0-2112-95A5-DFC99ED38E13}']
    Function  GetPatchData() : ITSTOPatchDatasIO;

    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

    Property PatchData : ITSTOPatchDatasIO Read GetPatchData;

    Property OnChange : TNotifyEvent Read GetOnChange Write SetOnChange;

  End;

  ITSTOCustomPatchListIO = Interface(ITSTOCustomPatchList)
    ['{4B61686E-29A0-2112-ABB1-EF0013E01FA7}']
    Function  Get(Index : Integer) : ITSTOCustomPatchIO;
    Procedure Put(Index : Integer; Const Item : ITSTOCustomPatchIO);

    Function GetModified() : Boolean;

    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

    Function Add() : ITSTOCustomPatchIO; OverLoad;
    Function Add(Const AItem : ITSTOCustomPatchIO) : Integer; OverLoad;
    Function Remove(Const AItem : ITSTOCustomPatchIO) : Integer;

    Property Items[Index : Integer] : ITSTOCustomPatchIO Read Get Write Put; Default;

    Property Modified : Boolean Read GetModified;

    Property OnChange : TNotifyEvent Read GetOnChange Write SetOnChange;

  End;

(******************************************************************************)

  ITSTOCustomPatchesIO = Interface(ITSTOCustomPatches)
    ['{4B61686E-29A0-2112-9AB6-78B41DBCF99D}']
    Function  GetAsXml() : String;
    Procedure SetAsXml(Const AXml : String);

    Function  GetPatches() : ITSTOCustomPatchListIO;

    Function GetModified() : Boolean;

    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);
    Procedure ForceChanged();
    Procedure ClearChanges();

    Property AsXml    : String Read GetAsXml Write SetAsXml;
    Property Patches  : ITSTOCustomPatchListIO Read GetPatches;
    Property Modified : Boolean Read GetModified;

    Property OnChange : TNotifyEvent Read GetOnChange Write SetOnChange;

  End;

implementation

end.
