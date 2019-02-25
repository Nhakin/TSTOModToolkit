unit TSTOWorkspaceIntf;

interface

Uses
  Windows, Classes, HsInterfaceEx, HsStreamEx, TSTOHackSettingsIntf;

Type
  TWorkSpaceProjectKind = (spkRoot, spkDLCServer);
  TWorkSpaceProjectType = (sptScript, sptTextPools);

  ITSTOWorkSpaceProjectSrcFile = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-8E6D-57596CAB70AD}']
    Function  GetFileName() : AnsiString;
    Procedure SetFileName(Const AFileName : AnsiString);

    Property FileName : AnsiString Read GetFileName Write SetFileName;

  End;

  ITSTOWorkSpaceProjectSrcFiles = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-9E79-0BE428CB0964}']
    Function  Get(Index : Integer) : ITSTOWorkSpaceProjectSrcFile;
    Procedure Put(Index : Integer; Const Item : ITSTOWorkSpaceProjectSrcFile);

    Function Add() : ITSTOWorkSpaceProjectSrcFile; OverLoad;
    Function Add(Const AItem : ITSTOWorkSpaceProjectSrcFile) : Integer; OverLoad;
    Function Remove(Const Item : ITSTOWorkSpaceProjectSrcFile) : Integer;

    Property Items[Index : Integer] : ITSTOWorkSpaceProjectSrcFile Read Get Write Put; Default;

  End;

  ITSTOWorkSpaceProjectSrcFolder = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-9B7D-067ED048E586}']
    Function  GetSrcPath() : AnsiString;
    Procedure SetSrcPath(Const ASrcPath : AnsiString);

    Function  GetSrcFileCount() : Integer;

    Function  GetFileList() : ITSTOWorkSpaceProjectSrcFiles;

    Function  GetSrcFiles(Index : Integer) : ITSTOWorkSpaceProjectSrcFile;

    Procedure Add(Const AFileName : AnsiString); OverLoad;
    Function  Add(Const AItem : ITSTOWorkSpaceProjectSrcFile) : Integer; OverLoad;
    Function  Add() : ITSTOWorkSpaceProjectSrcFile; OverLoad;

    Procedure Assign(ASource : IInterface);

    Property SrcPath      : AnsiString                    Read GetSrcPath  Write SetSrcPath;
    Property SrcFileCount : Integer                       Read GetSrcFileCount;
    Property FileList     : ITSTOWorkSpaceProjectSrcFiles Read GetFileList;

    Property SrcFiles[Index : Integer] : ITSTOWorkSpaceProjectSrcFile Read GetSrcFiles; Default;

  End;

  ITSTOWorkSpaceProjectSrcFolders = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-BBEA-5356FC33F428}']
    Function  Get(Index : Integer) : ITSTOWorkSpaceProjectSrcFolder;
    Procedure Put(Index : Integer; Const Item : ITSTOWorkSpaceProjectSrcFolder);

    Function Add() : ITSTOWorkSpaceProjectSrcFolder; OverLoad;
    Function Add(Const AItem : ITSTOWorkSpaceProjectSrcFolder) : Integer; OverLoad;

    Procedure Assign(ASource : IInterface);

    Property Items[Index : Integer] : ITSTOWorkSpaceProjectSrcFolder Read Get Write Put; Default;

  End;

  ITSTOWorkSpaceProject = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-8C64-5B308DF5B5E2}']
    Function  GetProjectName() : AnsiString;
    Procedure SetProjectName(Const AProjectName : AnsiString);

    Function  GetProjectKind() : TWorkSpaceProjectKind;
    Procedure SetProjectKind(Const AProjectKind : TWorkSpaceProjectKind);

    Function  GetProjectType() : TWorkSpaceProjectType;
    Procedure SetProjectType(Const AProjectType : TWorkSpaceProjectType);

    Function  GetZeroCrc32() : DWord;
    Procedure SetZeroCrc32(Const AZeroCrc32 : DWord);

    Function  GetPackOutput() : Boolean;
    Procedure SetPackOutput(Const APackOutput : Boolean);

    Function  GetOutputPath() : AnsiString;
    Procedure SetOutputPath(Const AOutputPath : AnsiString);

    Function  GetCustomScriptPath() : AnsiString;
    Procedure SetCustomScriptPath(Const ACustomScriptPath : AnsiString);

    Function  GetCustomModPath() : AnsiString;
    Procedure SetCustomModPath(Const ACustomModPath : AnsiString);

    Function  GetSrcFolders() : ITSTOWorkSpaceProjectSrcFolders;

    Procedure Assign(ASource : IInterface);

    Property ProjectName      : AnsiString                      Read GetProjectName      Write SetProjectName;
    Property ProjectKind      : TWorkSpaceProjectKind           Read GetProjectKind      Write SetProjectKind;
    Property ProjectType      : TWorkSpaceProjectType           Read GetProjectType      Write SetProjectType;
    Property ZeroCrc32        : DWord                           Read GetZeroCrc32        Write SetZeroCrc32;
    Property PackOutput       : Boolean                         Read GetPackOutput       Write SetPackOutput;
    Property OutputPath       : AnsiString                      Read GetOutputPath       Write SetOutputPath;
    Property CustomScriptPath : AnsiString                      Read GetCustomScriptPath Write SetCustomScriptPath;
    Property CustomModPath    : AnsiString                      Read GetCustomModPath    Write SetCustomModPath;
    Property SrcFolders       : ITSTOWorkSpaceProjectSrcFolders Read GetSrcFolders;

  End;

  ITSTOWorkSpaceProjectGroup = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-B8A2-605112DD5688}']
    Function  Get(Index : Integer) : ITSTOWorkSpaceProject;
    Procedure Put(Index : Integer; Const Item : ITSTOWorkSpaceProject);

    Function  GetProjectGroupName() : AnsiString;
    Procedure SetProjectGroupName(Const AProjectGroupName : AnsiString);

    Function  GetHackFileName() : AnsiString;
    Procedure SetHackFileName(Const AHackFileName : AnsiString);

    Function  GetPackOutput() : Boolean;
    Procedure SetPackOutput(Const APackOutput : Boolean);

    Function  GetOutputPath() : AnsiString;
    Procedure SetOutputPath(Const AOutputPath : AnsiString);

    Function Add() : ITSTOWorkSpaceProject; OverLoad;
    Function Add(Const AItem : ITSTOWorkSpaceProject) : Integer; OverLoad;

    Function  Remove(Const Item : ITSTOWorkSpaceProject) : Integer;

    Procedure Assign(ASource : IInterface);

    Property Items[Index : Integer] : ITSTOWorkSpaceProject Read Get Write Put; Default;

    Property ProjectGroupName : AnsiString Read GetProjectGroupName Write SetProjectGroupName;
    Property HackFileName     : AnsiString Read GetHackFileName     Write SetHackFileName;
    Property PackOutput       : Boolean    Read GetPackOutput       Write SetPackOutput;
    Property OutputPath       : AnsiString Read GetOutputPath       Write SetOutputPath;

  End;

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
