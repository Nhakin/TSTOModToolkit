unit TSTOProjectIntf;

interface

Uses HsXmlDocEx;

Type
  ITSTOXmlMasterFile = interface(IXmlNodeEx)
    ['{2D01B906-F4F3-4ADE-B385-2F6FD1EA59E2}']
    Function  GetFileName() : AnsiString;
    Procedure SetFileName(Value : AnsiString);
    Function  GetNodeName() : AnsiString;
    Procedure SetNodeName(Value : AnsiString);
    Function  GetNodeKind() : AnsiString;
    Procedure SetNodeKind(Value : AnsiString);

    Property FileName : AnsiString Read GetFileName Write SetFileName;
    Property NodeName : AnsiString Read GetNodeName Write SetNodeName;
    Property NodeKind : AnsiString Read GetNodeKind Write SetNodeKind;

  end;

  ITSTOXmlMasterFiles = interface(IXmlNodeCollectionEx)
    ['{F41A72D5-4282-4FEE-9C9B-C7A381B07D3F}']
    Function GetMasterFile(Index : Integer) : ITSTOXmlMasterFile;

    Function Add() : ITSTOXmlMasterFile;
    Function Insert(const Index : Integer) : ITSTOXmlMasterFile;

    Property MasterFile[Index : Integer] : ITSTOXmlMasterFile Read GetMasterFile; Default;

  end;

  ITSTOXmlCustomFormSetting = interface(IXMLNodeEx)
    ['{C90E57EE-8F67-4127-BB78-CC84AFBCDED6}']
    function GetSettingName: WideString;
    procedure SetSettingName(Value: WideString);
    function GetSettingValue() : Variant;
    procedure SetSettingValue(Value: Variant);

    property SettingName  : WideString read GetSettingName  write SetSettingName;
    property SettingValue : Variant    read GetSettingValue write SetSettingValue;

  end;

  ITSTOXMLFormSetting = interface(IXMLNodeCollectionEx)
    ['{27BFA632-E78C-45F7-8493-7BEC25A94303}']
    function GetName: WideString;
    procedure SetName(Value: WideString);
    function GetWindowState: WideString;
    procedure SetWindowState(Value: WideString);
    function GetX: Integer;
    procedure SetX(Value: Integer);
    function GetY: Integer;
    procedure SetY(Value: Integer);
    function GetW: Integer;
    procedure SetW(Value: Integer);
    function GetH: Integer;
    procedure SetH(Value: Integer);
    function GetComponent(Index: Integer): ITSTOXmlCustomFormSetting;

    function Add: ITSTOXmlCustomFormSetting;
    function Insert(const Index: Integer): ITSTOXmlCustomFormSetting;

    property Name: WideString read GetName write SetName;
    property WindowState: WideString read GetWindowState write SetWindowState;
    property X: Integer read GetX write SetX;
    property Y: Integer read GetY write SetY;
    property W: Integer read GetW write SetW;
    property H: Integer read GetH write SetH;
    property Component[Index: Integer]: ITSTOXmlCustomFormSetting read GetComponent; default;

  end;

  ITSTOXMLFormPos = interface(IXMLNodeCollectionEx)
    ['{8FB14669-6120-4D9D-BCD4-3A95FC6141FF}']
    Function Get_Form(Index: Integer): ITSTOXMLFormSetting;

    Function Add: ITSTOXMLFormSetting;
    Function Insert(const Index: Integer): ITSTOXMLFormSetting;
    Property Form[Index: Integer]: ITSTOXMLFormSetting read Get_Form; default;

  end;

  ITSTOXMLSettings = Interface(IXmlNodeEx)
    ['{1A094087-BF7A-46AD-B6E2-D80959D75DC6}']
    Function  GetAllFreeItems() : Boolean;
    Procedure SetAllFreeItems(Value : Boolean);
    Function  GetBuildCustomStore() : Boolean;
    Procedure SetBuildCustomStore(Value : Boolean);
    Function  GetInstantBuild() : Boolean;
    Procedure SetInstantBuild(Value : Boolean);
    Function  GetNonUnique() : Boolean;
    Procedure SetNonUnique(Value : Boolean);
    Function  GetFreeLand() : Boolean;
    Procedure SetFreeLand(Value : Boolean);
    Function  GetUnlimitedTime() : Boolean;
    Procedure SetUnlimitedTime(Value : Boolean);

    Function  GetDLCIndexFileName() : AnsiString;
    Procedure SetDLCIndexFileName(Value : AnsiString);
    Function  GetSourcePath() : AnsiString;
    Procedure SetSourcePath(Value : AnsiString);
    Function  GetTargetPath() : AnsiString;
    Procedure SetTargetPath(Value : AnsiString);
    Function  GetWorkSpaceFile() : AnsiString;
    Procedure SetWorkSpaceFile(Value : AnsiString);
    Function  GetHackPath() : AnsiString;
    Procedure SetHackPath(Value : AnsiString);
    Function  GetHackFileName() : AnsiString;
    Procedure SetHackFileName(Value : AnsiString);
    Function  GetCustomPatchFileName() : AnsiString;
    Procedure SetCustomPatchFileName(Value : AnsiString);
    Function  GetDLCServer() : AnsiString;
    Procedure SetDLCServer(Value : AnsiString);
    Function  GetDLCPath() : AnsiString;
    Procedure SetDLCPath(Value : AnsiString);
    Function  GetSkinName() : AnsiString;
    Procedure SetSkinName(Value : AnsiString);
    Function  GetHackFileTemplate() : AnsiString;
    Procedure SetHackFileTemplate(Const AHackFileTemplate : AnsiString);
    Function  GetHackMasterList() : AnsiString;
    Procedure SetHackMasterList(Const AHackMasterList : AnsiString);
    Function  GetResourcePath() : AnsiString;
    Procedure SetResourcePath(Value : AnsiString);

    Function GetFormPos() : ITSTOXMLFormPos;
    Function GetMasterFiles: ITSTOXmlMasterFiles;

    Property AllFreeItems     : Boolean Read GetAllFreeItems     Write SetAllFreeItems;
    Property BuildCustomStore : Boolean Read GetBuildCustomStore Write SetBuildCustomStore;
    Property InstantBuild     : Boolean Read GetInstantBuild     Write SetInstantBuild;
    Property NonUnique        : Boolean Read GetNonUnique        Write SetNonUnique;
    Property FreeLand         : Boolean Read GetFreeLand         Write SetFreeLand;
    Property UnlimitedTime    : Boolean Read GetUnlimitedTime    Write SetUnlimitedTime;

    Property DLCIndexFileName    : AnsiString Read GetDLCIndexFileName    Write SetDLCIndexFileName;
    Property SourcePath          : AnsiString Read GetSourcePath          Write SetSourcePath;
    Property TargetPath          : AnsiString Read GetTargetPath          Write SetTargetPath;
    Property WorkSpaceFile       : AnsiString Read GetWorkSpaceFile       Write SetWorkSpaceFile;
    Property HackPath            : AnsiString Read GetHackPath            Write SetHackPath;
    Property HackFileName        : AnsiString Read GetHackFileName        Write SetHackFileName;
    Property CustomPatchFileName : AnsiString Read GetCustomPatchFileName Write SetCustomPatchFileName;
    Property DLCServer           : AnsiString Read GetDLCServer           Write SetDLCServer;
    Property DLCPath             : AnsiString Read GetDLCPath             Write SetDLCPath;
    Property SkinName            : AnsiString Read GetSkinName            Write SetSkinName;
    Property HackFileTemplate    : AnsiString Read GetHackFileTemplate    Write SetHackFileTemplate;
    Property HackMasterList      : AnsiString Read GetHackMasterList      Write SetHackMasterList;
    Property ResourcePath        : AnsiString Read GetResourcePath        Write SetResourcePath;
    Property FormPos             : ITSTOXMLFormPos Read GetFormPos;

    Property MasterFiles : ITSTOXmlMasterFiles Read GetMasterFiles;

  End;

  ITSTOXMLSourcePaths = Interface(IXmlNodeCollectionEx)
    ['{150EDB89-37F3-4CD3-BA76-2DA43747C01D}']
    Function GetSourcePath(Index : Integer) : AnsiString;
    Function Add(Const SourcePath : AnsiString) : IXmlNodeEx;
    Function Insert(Const Index : Integer; Const SourcePath : AnsiString) : IXmlNodeEx;

    Property SourcePath[Index : Integer] : AnsiString Read GetSourcePath; Default;

  End;

  ITSTOXMLProjectFile = Interface(IXmlNodeEx)
    ['{D71D70F7-A3BB-4E30-9A3A-71AB5CC6F311}']
    Function GetFileType() : Integer;
    Procedure SetFileType(Value : Integer);

    Function GetSourcePaths() : ITSTOXMLSourcePaths;

    Function GetOutputPath() : AnsiString;
    Procedure SetOutputPath(Value : AnsiString);

    Function GetOutputFileName() : AnsiString;
    Procedure SetOutputFileName(Value : AnsiString);


    Property FileType       : Integer             Read GetFileType       Write SetFileType;
    Property SourcePaths    : ITSTOXMLSourcePaths Read GetSourcePaths;
    Property OutputPath     : AnsiString          Read GetOutputPath     Write SetOutputPath;
    Property OutputFileName : AnsiString          Read GetOutputFileName Write SetOutputFileName;

  End;

  ITSTOXMLProjectFiles = Interface(IXmlNodeCollectionEx)
    ['{CDC40918-1876-407B-887B-E8E997EA22CC}']
    Function GetProjectFile(Index : Integer): ITSTOXMLProjectFile;

    Function Add() : ITSTOXMLProjectFile;
    Function Insert(Const Index : Integer): ITSTOXMLProjectFile;

    Property ProjectFile[Index : Integer] : ITSTOXMLProjectFile Read GetProjectFile; Default;

  End;

  ITSTOXMLProject = Interface(IXmlNodeEx)
    ['{980C930B-C7C7-4286-9244-0850265EBE31}']
    Function GetSettings() : ITSTOXMLSettings;
    Function GetProjectFiles() : ITSTOXMLProjectFiles;

    Property Settings      : ITSTOXMLSettings      Read GetSettings;
    Property ProjectFiles  : ITSTOXMLProjectFiles  Read GetProjectFiles;

  End;

implementation

end.
