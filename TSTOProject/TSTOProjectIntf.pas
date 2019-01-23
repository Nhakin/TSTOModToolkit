unit TSTOProjectIntf;

interface

Uses Classes, SysUtils, HsInterfaceEx, HsStreamEx;

Type
  ITSTOMasterFile = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-ADA1-5F552FBA5DA7}']
    Function  GetFileName() : AnsiString;
    Procedure SetFileName(Const AFileName : AnsiString);

    Function  GetNodeName() : AnsiString;
    Procedure SetNodeName(Const ANodeName : AnsiString);

    Function  GetNodeKind() : AnsiString;
    Procedure SetNodeKind(Const ANodeKind : AnsiString);

    Property FileName : AnsiString Read GetFileName Write SetFileName;
    Property NodeName : AnsiString Read GetNodeName Write SetNodeName;
    Property NodeKind : AnsiString Read GetNodeKind Write SetNodeKind;

  End;

  ITSTOMasterFiles = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-9C6D-CF06D62D2340}']
    Function  Get(Index : Integer) : ITSTOMasterFile;
    Procedure Put(Index : Integer; Const Item : ITSTOMasterFile);

    Function Add() : ITSTOMasterFile; OverLoad;
    Function Add(Const AItem : ITSTOMasterFile) : Integer; OverLoad;

    Property Items[Index : Integer] : ITSTOMasterFile Read Get Write Put; Default;

  End;

  ITSTOAppSettings = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-8D84-F9E010DA562C}']
    Function  GetDLCServer() : AnsiString;
    Procedure SetDLCServer(Const ADLCServer : AnsiString);

    Function  GetDLCPath() : AnsiString;
    Procedure SetDLCPath(Const ADLCPath : AnsiString);

    Function  GetHackPath() : AnsiString;
    Procedure SetHackPath(Const AHackPath : AnsiString);

    Function  GetHackFileName() : AnsiString;
    Procedure SetHackFileName(Const AHackFileName : AnsiString);

    Function  GetCustomPatchFileName() : AnsiString;
    Procedure SetCustomPatchFileName(Const ACustomPatchFileName : AnsiString);

    Function  GetResourcePath() : AnsiString;
    Procedure SetResourcePath(Const AResourcePath : AnsiString);

    Function  GetSourcePath() : AnsiString;
    Procedure SetSourcePath(Const ASourcePath : AnsiString);

    Function  GetTargetPath() : AnsiString;
    Procedure SetTargetPath(Const ATargetPath : AnsiString);

    Function  GetWorkSpaceFile() : AnsiString;
    Procedure SetWorkSpaceFile(Const AWorkSpaceFile : AnsiString);

    Function  GetSkinName() : AnsiString;
    Procedure SetSkinName(Const ASkinName : AnsiString);

    Function  GetHackFileTemplate() : AnsiString;
    Procedure SetHackFileTemplate(Const AHackFileTemplate : AnsiString);

    Function  GetMasterFile() : ITSTOMasterFiles;

    Function  GetBuildCustomStore() : Boolean;
    Procedure SetBuildCustomStore(Const ABuildCustomStore : Boolean);

    Function  GetInstantBuild() : Boolean;
    Procedure SetInstantBuild(Const AInstantBuild : Boolean);

    Function  GetAllFreeItems() : Boolean;
    Procedure SetAllFreeItems(Const AAllFreeItems : Boolean);

    Function  GetNonUnique() : Boolean;
    Procedure SetNonUnique(Const ANonUnique : Boolean);

    Function  GetFreeLand() : Boolean;
    Procedure SetFreeLand(Const AFreeLand : Boolean);

    Function  GetUnlimitedTime() : Boolean;
    Procedure SetUnlimitedTime(Const AUnlimitedTime : Boolean);

    Property DLCServer           : AnsiString       Read GetDLCServer           Write SetDLCServer;
    Property DLCPath             : AnsiString       Read GetDLCPath             Write SetDLCPath;
    Property HackPath            : AnsiString       Read GetHackPath            Write SetHackPath;
    Property HackFileName        : AnsiString       Read GetHackFileName        Write SetHackFileName;
    Property CustomPatchFileName : AnsiString       Read GetCustomPatchFileName Write SetCustomPatchFileName;
    Property ResourcePath        : AnsiString       Read GetResourcePath        Write SetResourcePath;
    Property SourcePath          : AnsiString       Read GetSourcePath          Write SetSourcePath;
    Property TargetPath          : AnsiString       Read GetTargetPath          Write SetTargetPath;
    Property WorkSpaceFile       : AnsiString       Read GetWorkSpaceFile       Write SetWorkSpaceFile;
    Property SkinName            : AnsiString       Read GetSkinName            Write SetSkinName;
    Property HackFileTemplate    : AnsiString       Read GetHackFileTemplate    Write SetHackFileTemplate;

    Property MasterFile          : ITSTOMasterFiles Read GetMasterFile;
    Property BuildCustomStore    : Boolean          Read GetBuildCustomStore    Write SetBuildCustomStore;
    Property InstantBuild        : Boolean          Read GetInstantBuild        Write SetInstantBuild;
    Property AllFreeItems        : Boolean          Read GetAllFreeItems        Write SetAllFreeItems;
    Property NonUnique           : Boolean          Read GetNonUnique           Write SetNonUnique;
    Property FreeLand            : Boolean          Read GetFreeLand            Write SetFreeLand;
    Property UnlimitedTime       : Boolean          Read GetUnlimitedTime       Write SetUnlimitedTime;


  End;

implementation

end.
