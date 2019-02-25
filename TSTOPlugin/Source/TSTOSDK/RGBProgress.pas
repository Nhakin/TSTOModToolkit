unit RGBProgress;

interface

Uses HsInterfaceEx;

Type
  IRgbProgress = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-95F5-7E2008F64210}']
    Function  GetItemProgress() : Byte;
    Procedure SetItemProgress(Const AItemProgress : Byte);

    Function  GetCurOperation() : String;
    Procedure SetCurOperation(Const ACurOperation : String);

    Function  GetArchiveProgress() : Byte;
    Procedure SetArchiveProgress(Const AArchiveProgress : Byte);

    Function  GetCurArchiveName() : String;
    Procedure SetCurArchiveName(Const ACurArchiveName : String);

    Procedure Show();
    Procedure Hide();
    
    Property ItemProgress    : Byte   Read GetItemProgress    Write SetItemProgress;
    Property CurOperation    : String Read GetCurOperation    Write SetCurOperation;
    Property ArchiveProgress : Byte   Read GetArchiveProgress Write SetArchiveProgress;
    Property CurArchiveName  : String Read GetCurArchiveName  Write SetCurArchiveName;

  End;
  
implementation

end.
