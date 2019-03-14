unit TSTOProjectWorkSpaceIntf;

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

implementation

end.
