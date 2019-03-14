unit TSTOProjectWorkSpace.IO;

interface

Uses
  Windows, Classes, HsInterfaceEx, HsStreamEx,
  TSTOHackSettingsIntf, TSTOProjectWorkspaceIntf;

Type
  ITSTOWorkSpaceProjectSrcFilesIO = Interface(ITSTOWorkSpaceProjectSrcFiles)
    ['{4B61686E-29A0-2112-83D8-AF14FA400832}']
    Function Remove(Const Item : ITSTOWorkSpaceProjectSrcFile) : Integer;

    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

    Property OnChange : TNotifyEvent Read GetOnChange Write SetOnChange;

  End;

  ITSTOWorkSpaceProjectSrcFolderIO = Interface(ITSTOWorkSpaceProjectSrcFolder)
    ['{4B61686E-29A0-2112-9A95-856C256092DA}']
    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

    Property OnChange : TNotifyEvent Read GetOnChange Write SetOnChange;

  End;

  ITSTOWorkSpaceProjectSrcFoldersIO = Interface(ITSTOWorkSpaceProjectSrcFolders)
    ['{4B61686E-29A0-2112-B4BD-C15FECA88CC7}']
    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

    Function  Get(Index : Integer) : ITSTOWorkSpaceProjectSrcFolderIO;
    Procedure Put(Index : Integer; Const Item : ITSTOWorkSpaceProjectSrcFolderIO);

    Function Add() : ITSTOWorkSpaceProjectSrcFolderIO; OverLoad;
    Function Add(Const AItem : ITSTOWorkSpaceProjectSrcFolderIO) : Integer; OverLoad;

    Property Items[Index : Integer] : ITSTOWorkSpaceProjectSrcFolderIO Read Get Write Put; Default;

    Property OnChange : TNotifyEvent Read GetOnChange Write SetOnChange;

  End;

  ITSTOWorkSpaceProjectGroupIO = Interface;
  ITSTOWorkSpaceProjectIO = Interface(ITSTOWorkSpaceProject)
    ['{4B61686E-29A0-2112-84E7-E72095D7D3D9}']
    Function  GetWorkSpace() : ITSTOWorkSpaceProjectGroupIO;
    Function  GetGlobalSettings() : ITSTOHackSettings;
    Function  GetSrcPath() : String;

    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

    Property WorkSpace      : ITSTOWorkSpaceProjectGroupIO Read GetWorkSpace;
    Property GlobalSettings : ITSTOHackSettings            Read GetGlobalSettings;
    Property SrcPath        : String                       Read GetSrcPath;

    Property OnChange : TNotifyEvent Read GetOnChange Write SetOnChange;

  End;

  ITSTOWorkSpaceProjectGroupIO = Interface(ITSTOWorkSpaceProjectGroup)
    ['{4B61686E-29A0-2112-A7E7-81D654C5F3FD}']
    Function GetFileName() : String;

    Function  GetAsXml() : String;
    Procedure SetAsXml(Const AXmlString : String);

    Function  GetHackSettings() : ITSTOHackSettings;

    Function  Get(Index : Integer) : ITSTOWorkSpaceProjectIO;
    Procedure Put(Index : Integer; Const Item : ITSTOWorkSpaceProjectIO);

    Function Add() : ITSTOWorkSpaceProjectIO; OverLoad;
    Function Add(Const AItem : ITSTOWorkSpaceProjectIO) : Integer; OverLoad;

    Function  GetModified() : Boolean;

    Function  GetOnChange() : TNotifyEvent;
    Procedure SetOnChange(AOnChange : TNotifyEvent);

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure LoadFromFile(Const AFileName : String);

    Procedure SaveToStream(ATarget : IStreamEx);
    Procedure SaveToFile(Const AFileName : String);

    Procedure ForceChanged();

    Procedure CreateWsGroupProject(APath : String; Const AHackFileName : String);
    Procedure CreateWsProject(APath : String; AProject : ITSTOWorkSpaceProjectIO);
    Procedure GenerateScripts(AProject : ITSTOWorkSpaceProjectIO);
    Procedure CompileMod(AWorkSpaceProject : ITSTOWorkSpaceProjectIO);
    Procedure PackMod(AWorkSpaceProject : ITSTOWorkSpaceProjectIO);

    Property FileName     : String            Read GetFileName;
    Property AsXml        : String            Read GetAsXml        Write SetAsXml;
    Property HackSettings : ITSTOHackSettings Read GetHackSettings;

    Property Items[Index : Integer] : ITSTOWorkSpaceProjectIO Read Get Write Put; Default;

    Property Modified : Boolean Read GetModified;

    Property OnChange : TNotifyEvent Read GetOnChange Write SetOnChange;

  End;

implementation

end.
