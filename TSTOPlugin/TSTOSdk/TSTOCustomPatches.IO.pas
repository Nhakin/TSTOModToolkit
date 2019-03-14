unit TSTOCustomPatches.IO;

interface

Uses Classes, HsInterfaceEx, TSTOCustomPatchesIntf;

Type
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
