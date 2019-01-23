unit uSelectDirectoryEx;

interface

uses 
  SysUtils, Forms, Windows, ShlObj, ActiveX;

function SelectDirectoryEx(const Caption: AnsiString; const Root: WideString;
  var Directory: AnsiString; EditBox: Boolean = False; ShowFiles: Boolean = False;
  AllowCreateDirs: Boolean = True): Boolean;

implementation

function SelectDirectoryEx(const Caption: AnsiString; const Root: WideString;
  var Directory: AnsiString; EditBox: Boolean = False; ShowFiles: Boolean = False;
  AllowCreateDirs: Boolean = True): Boolean;
  // callback function that is called when the dialog has been initialized 
  //or a new directory has been selected 

  // Callback-Funktion, die aufgerufen wird, wenn der Dialog initialisiert oder 
  //ein neues Verzeichnis selektiert wurde 
  function SelectDirCB(Wnd: HWND; uMsg: UINT; lParam, lpData: lParam): Integer;
    stdcall; 
  //var
  //  PathName: array[0..MAX_PATH] of Char; 
  begin 
    case uMsg of 
      BFFM_INITIALIZED: SendMessage(Wnd, BFFM_SETSELECTION, Ord(True), Integer(lpData)); 
      // include the following comment into your code if you want to react on the 
      //event that is called when a new directory has been selected 
      // binde den folgenden Kommentar in deinen Code ein, wenn du auf das Ereignis 
      //reagieren willst, das aufgerufen wird, wenn ein neues Verzeichnis selektiert wurde 
      {BFFM_SELCHANGED: 
      begin 
        SHGetPathFromIDList(PItemIDList(lParam), @PathName); 
        // the directory "PathName" has been selected 
        // das Verzeichnis "PathName" wurde selektiert 
      end;} 
    end; 
    Result := 0; 
  end; 
var 
  WindowList: Pointer; 
  BrowseInfo: TBrowseInfoA;
  Buffer: PAnsiChar;
  RootItemIDList, ItemIDList: PItemIDList; 
  ShellMalloc: IMalloc; 
  IDesktopFolder: IShellFolder; 
  Eaten, Flags: LongWord; 
const 
  // necessary for some of the additional expansions 
  // notwendig für einige der zusätzlichen Erweiterungen 
  BIF_USENEWUI = $0040; 
  BIF_NOCREATEDIRS = $0200; 
begin 
  Result := False; 
  if not DirectoryExists(Directory) then
    Directory := ''; 
  FillChar(BrowseInfo, SizeOf(BrowseInfo), 0);
  if (ShGetMalloc(ShellMalloc) = S_OK) and (ShellMalloc <> nil) then 
  begin 
    Buffer := ShellMalloc.Alloc(MAX_PATH); 
    try 
      RootItemIDList := nil; 
      if Root <> '' then 
      begin 
        SHGetDesktopFolder(IDesktopFolder); 
        IDesktopFolder.ParseDisplayName(Application.Handle, nil,
          POleStr(Root), Eaten, RootItemIDList, Flags); 
      end; 
      OleInitialize(nil); 
      with BrowseInfo do 
      begin 
        hwndOwner := Application.Handle;
        pidlRoot := RootItemIDList; 
        pszDisplayName := Buffer; 
        lpszTitle := PAnsiChar(Caption);
        // defines how the dialog will appear: 
        // legt fest, wie der Dialog erscheint: 
        ulFlags := BIF_RETURNONLYFSDIRS or BIF_USENEWUI or 
          BIF_EDITBOX * Ord(EditBox) or BIF_BROWSEINCLUDEFILES * Ord(ShowFiles) or
          BIF_NOCREATEDIRS * Ord(not AllowCreateDirs); 
        lpfn    := @SelectDirCB; 
        if Directory <> '' then 
          lParam := Integer(PAnsiChar(Directory));
      end; 
      WindowList := DisableTaskWindows(0); 
      try 
        ItemIDList := SHBrowseForFolderA(BrowseInfo);
      finally 
        EnableTaskWindows(WindowList); 
      end; 
      Result := ItemIDList <> nil; 
      if Result then 
      begin 
        SHGetPathFromIDListA(ItemIDList, Buffer);
        ShellMalloc.Free(ItemIDList); 
        Directory := Buffer; 
      end; 
    finally 
      ShellMalloc.Free(Buffer); 
    end; 
  end;
end;

end.
