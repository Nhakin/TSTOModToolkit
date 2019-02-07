unit TSTOHackSettings;

interface

Uses Classes, HsInterfaceEx,
  TSTOCustomPatches.IO, TSTOSbtp.IO, TSTOScriptTemplate.IO, TSTOHackMasterList.IO;

Type
  THackIdxFileType = (hiftCustomPatch, hiftGameScript, hiftHackTemplate, hiftHackMasterList, hiftTextPools);
  THackIdxFileFormat = (hiffXml, hiffBin, hiffZip);

  ITSTOHackSettings = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-9BE8-7A7F480881B7}']
    Function  GetCustomPatches() : ITSTOCustomPatchesIO;
    Function  GetTextPools() : ISbtpFilesIO;
    Function  GetScriptTemplates() : ITSTOScriptTemplateHacksIO;
    Function  GetHackMasterList() : ITSTOHackMasterListIO;

    Function  GetOnChanged() : TNotifyEvent;
    Procedure SetOnChanged(AOnChanged : TNotifyEvent);

    Procedure LoadFromFile(Const AFileName : String);
    Procedure SaveToFile(); OverLoad;
    Procedure SaveToFile(Const AFileName : String); OverLoad;

    Procedure NewHackFile();
    Procedure ExtractHackSource(Const AFileFormat : THackIdxFileFormat; APath : String = '');
    Procedure PackHackSource(Const AFileFormat : THackIdxFileFormat; Const AIndexFile, AFileName : String);

    Property CustomPatches   : ITSTOCustomPatchesIO       Read GetCustomPatches;
    Property TextPools       : ISbtpFilesIO               Read GetTextPools;
    Property ScriptTemplates : ITSTOScriptTemplateHacksIO Read GetScriptTemplates;
    Property HackMasterList  : ITSTOHackMasterListIO      Read GetHackMasterList;

    Property OnChanged : TNotifyEvent Read GetOnChanged Write SetOnChanged;

  End;

  TTSTOHackSettings = Class(TObject)
  Public
    Class Function CreateHackSettings() : ITSTOHackSettings; OverLoad;
    Class Function CreateHackSettings(Const AFileName : String) : ITSTOHackSettings; OverLoad;

  End;

implementation

Uses SysUtils, RtlConsts, AbArcTyp,
  HsZipUtils, HsStreamEx, HsStringListEx, HsXmlDocEx;

Type
  ITSTOHackFileIndex = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-942F-B24ADA8FE30A}']
    Function  GetFileName() : String;
    Procedure SetFileName(Const AFileName : String);

    Function  GetFileType() : THackIdxFileType;
    Procedure SetFileType(Const AFileType : THackIdxFileType);

    Function  GetFileFormat() : THackIdxFileFormat;
    Procedure SetFileFormat(Const AFileFormat : THackIdxFileFormat);

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Procedure Assign(ASource : IInterface);

    Property FileName   : String             Read GetFileName   Write SetFileName;
    Property FileType   : THackIdxFileType   Read GetFileType   Write SetFileType;
    Property FileFormat : THackIdxFileFormat Read GetFileFormat Write SetFileFormat;

  End;

  ITSTOHackFileIndexes = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-896C-5B06E4E34FF1}']
    Function  Get(Index : Integer) : ITSTOHackFileIndex;
    Procedure Put(Index : Integer; Const Item : ITSTOHackFileIndex);

    Function Add() : ITSTOHackFileIndex; OverLoad;
    Function Add(Const AItem : ITSTOHackFileIndex) : Integer; OverLoad;

    Function IndexOf(Const AFileType : THackIdxFileType) : Integer;

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Procedure Assign(ASource : IInterface);

    Property Items[Index : Integer] : ITSTOHackFileIndex Read Get Write Put; Default;

  End;

  TTSTOHackFileIndex = Class(TInterfacedObjectEx, ITSTOHackFileIndex)
  Private
    FFileName   : String;
    FFileType   : THackIdxFileType;
    FFileFormat : THackIdxFileFormat;

  Protected
    Function  GetFileName() : String;
    Procedure SetFileName(Const AFileName : String);

    Function  GetFileType() : THackIdxFileType;
    Procedure SetFileType(Const AFileType : THackIdxFileType);

    Function  GetFileFormat() : THackIdxFileFormat;
    Procedure SetFileFormat(Const AFileFormat : THackIdxFileFormat);

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Procedure Assign(ASource : IInterface);

  End;

  TTSTOHackFileIndexes = Class(TInterfaceListEx, ITSTOHackFileIndexes)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : ITSTOHackFileIndex; OverLoad;
    Procedure Put(Index : Integer; Const Item : ITSTOHackFileIndex); OverLoad;

    Function Add() : ITSTOHackFileIndex; OverLoad;
    Function Add(Const AItem : ITSTOHackFileIndex) : Integer; OverLoad;

    Function IndexOf(Const AFileType : THackIdxFileType) : Integer; ReIntroduce;

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure SaveToStream(ATarget : IStreamEx);

    Procedure Assign(ASource : IInterface);

  End;

  TTSTOHackSettingsImpl = Class(THsMemoryZipper, ITSTOHackSettings)
  Private
    FFileName        : String;

    FHackCfgFiles    : ITSTOHackFileIndexes;
    FCustomPatches   : ITSTOCustomPatchesIO;
    FTextPools       : ISbtpFilesIO;
    FScriptTemplates : ITSTOScriptTemplateHacksIO;
    FHackMasterList  : ITSTOHackMasterListIO;
    FOnChanged       : TNotifyEvent;

  Protected
    Function GetHackCfgFiles() : ITSTOHackFileIndexes;
    Function GetCustomPatches() : ITSTOCustomPatchesIO;
    Function GetTextPools() : ISbtpFilesIO;
    Function GetScriptTemplates() : ITSTOScriptTemplateHacksIO;
    Function GetHackMasterList() : ITSTOHackMasterListIO;

    Procedure DoOnChange(Sender : TObject);
    Function  GetOnChanged() : TNotifyEvent;
    Procedure SetOnChanged(AOnChanged : TNotifyEvent);

    Procedure LoadFromFile(Const AFileName : String);

    Procedure SaveToFile(Const AFileName : String); OverLoad;
    Procedure SaveToFile(); OverLoad;

    Procedure NewHackFile();
    Procedure ExtractHackSource(Const AFileFormat : THackIdxFileFormat; APath : String = '');
    Procedure PackHackSource(Const AFileFormat : THackIdxFileFormat; Const AIndexFile, AFileName : String);

    Property HackCfgFiles    : ITSTOHackFileIndexes       Read GetHackCfgFiles;
    Property CustomPatches   : ITSTOCustomPatchesIO       Read GetCustomPatches;
    Property TextPools       : ISbtpFilesIO               Read GetTextPools;
    Property ScriptTemplates : ITSTOScriptTemplateHacksIO Read GetScriptTemplates;
    Property HackMasterList  : ITSTOHackMasterListIO      Read GetHackMasterList;

  Public
    Destructor Destroy(); OverRide;

  End;

Class Function TTSTOHackSettings.CreateHackSettings() : ITSTOHackSettings;
Begin
  Result := TTSTOHackSettingsImpl.Create();
End;

Class Function TTSTOHackSettings.CreateHackSettings(Const AFileName : String) : ITSTOHackSettings;
Begin
  Result := TTSTOHackSettingsImpl.Create();
  Result.LoadFromFile(AFileName);
End;

Procedure TTSTOHackFileIndex.Assign(ASource : IInterface);
Var lSrc : ITSTOHackFileIndex;
Begin
  If Supports(ASource, ITSTOHackFileIndex, lSrc) Then
  Begin
    FFileName   := lSrc.FileName;
    FFileType   := lSrc.FileType;
    FFileFormat := lSrc.FileFormat;
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Procedure TTSTOHackFileIndex.LoadFromStream(ASource : IStreamEx);
Begin
  FFileName   := ASource.ReadAnsiString();
  FFileType   := THackIdxFileType(ASource.ReadByte());
  FFileFormat := THackIdxFileFormat(ASource.ReadByte());
End;

Procedure TTSTOHackFileIndex.SaveToStream(ATarget : IStreamEx);
Begin
  ATarget.WriteAnsiString(FFileName);
  ATarget.WriteByte(Ord(FFileType));
  ATarget.WriteByte(Ord(FFileFormat));
End;

Function TTSTOHackFileIndex.GetFileName() : String;
Begin
  Result := FFileName;
End;

Procedure TTSTOHackFileIndex.SetFileName(Const AFileName : String);
Begin
  FFileName := AFileName;
End;

Function TTSTOHackFileIndex.GetFileType() : THackIdxFileType;
Begin
  Result := FFileType;
End;

Procedure TTSTOHackFileIndex.SetFileType(Const AFileType : THackIdxFileType);
Begin
  FFileType := AFileType;
End;

Function TTSTOHackFileIndex.GetFileFormat() : THackIdxFileFormat;
Begin
  Result := FFileFormat;
End;

Procedure TTSTOHackFileIndex.SetFileFormat(Const AFileFormat : THackIdxFileFormat);
Begin
  FFileFormat := AFileFormat;
End;

Function TTSTOHackFileIndexes.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TTSTOHackFileIndex;
End;

Function TTSTOHackFileIndexes.Get(Index : Integer) : ITSTOHackFileIndex;
Begin
  Result := InHerited Items[Index] As ITSTOHackFileIndex;
End;

Procedure TTSTOHackFileIndexes.Put(Index : Integer; Const Item : ITSTOHackFileIndex);
Begin
  InHerited Items[Index] := Item;
End;

Function TTSTOHackFileIndexes.Add() : ITSTOHackFileIndex;
Begin
  Result := InHerited Add() As ITSTOHackFileIndex;
End;

Function TTSTOHackFileIndexes.Add(Const AItem : ITSTOHackFileIndex) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Function TTSTOHackFileIndexes.IndexOf(Const AFileType : THackIdxFileType) : Integer;
Var X : Integer;
Begin
  Result := -1;

  For X := 0 To Count - 1 Do
    If Get(X).FileType = AFileType Then
    Begin
      Result := X;
      Break;
    End;
End;

Procedure TTSTOHackFileIndexes.Assign(ASource : IInterface);
Var X : Integer;
    lIndex : ITSTOHackFileIndexes;
Begin
  Clear();
  If Supports(ASource, ITSTOHackFileIndexes, lIndex) Then
  Begin
    For X := 0 To lIndex.Count - 1 Do
      Add().Assign(lIndex[X]);
  End
  Else
    Raise EConvertError.CreateResFmt(@SAssignError, [GetInterfaceName(ASource), ClassName]);
End;

Procedure TTSTOHackFileIndexes.LoadFromStream(ASource : IStreamEx);
Var lNbItem : Byte;
Begin
  lNbItem := ASource.ReadByte();
  While lNbItem > 0 Do
  Begin
    Add().LoadFromStream(ASource);
    Dec(lNbItem);
  End;
End;

Procedure TTSTOHackFileIndexes.SaveToStream(ATarget : IStreamEx);
Var X : Integer;
Begin
  ATarget.WriteByte(Count);
  For X := 0 To Count - 1 Do
    Get(X).SaveToStream(ATarget);
End;

(******************************************************************************)

Destructor TTSTOHackSettingsImpl.Destroy();
Begin
  FHackCfgFiles    := Nil;
  FCustomPatches   := Nil;
  FTextPools       := Nil;
  FScriptTemplates := Nil;
  FHackMasterList  := Nil;

  InHerited Destroy();
End;

Procedure TTSTOHackSettingsImpl.DoOnChange(Sender : TObject);
Begin
  If Assigned(FOnChanged) Then
    FOnChanged(Sender);
End;

Function TTSTOHackSettingsImpl.GetOnChanged() : TNotifyEvent;
Begin
  Result := FOnChanged;
End;

Procedure TTSTOHackSettingsImpl.SetOnChanged(AOnChanged : TNotifyEvent);
Begin
  FOnChanged := AOnChanged;
End;

Function TTSTOHackSettingsImpl.GetHackCfgFiles() : ITSTOHackFileIndexes;
Var lIdx : Integer;
    lMemStrm : IMemoryStreamEx;
Begin
  If Not Assigned(FHackCfgFiles) Then
  Begin
    FHackCfgFiles := TTSTOHackFileIndexes.Create();

    lIdx := FindFile('HackIdx');
    If lIdx > -1 Then
    Begin
      lMemStrm := TMemoryStreamEx.Create();
      Try
        ExtractToStream(lIdx, lMemStrm);
        lMemStrm.Position := 0;
        FHackCfgFiles.LoadFromStream(lMemStrm);

        Finally
          lMemStrm := Nil;
      End;
    End;
  End;

  Result := FHackCfgFiles;
End;

Function TTSTOHackSettingsImpl.GetCustomPatches() : ITSTOCustomPatchesIO;
Var lIdx : Integer;
    lFileFormat : THackIdxFileFormat;
    lStrStrm : IStringStreamEx;
Begin
  If Not Assigned(FCustomPatches) Then
  Begin
    FCustomPatches := TTSTOCustomPatchesIO.CreateCustomPatchIO();

    lIdx := HackCfgFiles.IndexOf(hiftCustomPatch);
    If lIdx > -1 Then
    Begin
      lFileFormat := HackCfgFiles[lIdx].FileFormat;
      lIdx := FindFile(HackCfgFiles[lIdx].FileName);

      If lIdx > -1 Then
      Begin
//        If lFileFormat = hiffXml Then
        Begin
          lStrStrm := TStringStreamEx.Create();
          Try
            ExtractToStream(lIdx, lStrStrm);
            FCustomPatches.AsXml := lStrStrm.DataString;
//            FCustomPatches := TTSTOXmlCustomPatches.CreateCustomPatches(lStrStrm.DataString);

            Finally
              lStrStrm := Nil;
          End;
        End;
//        Else If lFileFormat = hiffBin Then
//          Raise Exception.Create('Binary format not supported for CustomPatches');
      End;
    End;

    FCustomPatches.OnChange := DoOnChange;
  End;

  Result := FCustomPatches;
End;

Function TTSTOHackSettingsImpl.GetTextPools() : ISbtpFilesIO;
Var lIdx : Integer;
    lFileFormat : THackIdxFileFormat;
    lMemStrm : IMemoryStreamEx;
    lStrStrm : IStringStreamEx;
Begin
  If Not Assigned(FTextPools) Then
  Begin
    lIdx := HackCfgFiles.IndexOf(hiftTextPools);
    If lIdx > -1 Then
    Begin
      lFileFormat := HackCfgFiles[lIdx].FileFormat;
      lIdx := FindFile(HackCfgFiles[lIdx].FileName);

      If lIdx > -1 Then
      Begin
        If lFileFormat = hiffBin Then
        Begin
          lMemStrm := TMemoryStreamEx.Create();
          Try
            ExtractToStream(lIdx, lMemStrm);
            lMemStrm.Position := 0;

            FTextPools := TSbtpFilesIO.LoadBinSbtpFiles(lMemStrm);

            Finally
              lMemStrm := Nil;
          End;
        End
        Else If lFileFormat = hiffXml Then
        Begin
          lStrStrm := TStringStreamEx.Create();
          Try
            ExtractToStream(lIdx, lStrStrm);
            FTextPools.AsXml := lStrStrm.DataString;

            Finally
              lStrStrm := Nil;
          End;
        End;
      End
      Else
        FTextPools := TSbtpFilesIO.CreateSbtpFiles();
    End
    Else
      FTextPools := TSbtpFilesIO.CreateSbtpFiles();

    FTextPools.OnChange := DoOnChange;
  End;

  Result := FTextPools;
End;

Function TTSTOHackSettingsImpl.GetScriptTemplates() : ITSTOScriptTemplateHacksIO;
Var lIdx : Integer;
    lFileFormat : THackIdxFileFormat;
    lStrStrm : IStringStreamEx;
    lMemStrm : IMemoryStreamEx;
Begin
  If Not Assigned(FScriptTemplates) Then
  Begin
    FScriptTemplates := TTSTOScriptTemplateHacksIO.CreateScriptTemplateHacks();

    lIdx := HackCfgFiles.IndexOf(hiftHackTemplate);
    If lIdx > -1 Then
    Begin
      lFileFormat := HackCfgFiles[lIdx].FileFormat;
      lIdx := FindFile(HackCfgFiles[lIdx].FileName);
      If lIdx > -1 Then
      Begin
        If lFileFormat = hiffBin Then
        Begin
          lMemStrm := TMemoryStreamEx.Create();
          Try
            ExtractToStream(lIdx, lMemStrm);
            lMemStrm.Position := 0;
            FScriptTemplates.LoadFromStream(lMemStrm);

            Finally
              lMemStrm := Nil;
          End;
        End
        Else If lFileFormat = hiffXml Then
        Begin
          lStrStrm := TStringStreamEx.Create();
          Try
            ExtractToStream(lIdx, lStrStrm);
            FScriptTemplates.AsXml := lStrStrm.DataString;

            Finally
              lStrStrm := Nil;
          End;
        End;
      End;
    End;

    FScriptTemplates.OnChanged := DoOnChange;
  End;

  Result := FScriptTemplates;
End;

Function TTSTOHackSettingsImpl.GetHackMasterList() : ITSTOHackMasterListIO;
Var lIdx : Integer;
    lMemStrm : IMemoryStreamEx;
    lStrStrm : IStringStreamEx;
    lFileFormat : THackIdxFileFormat;
Begin
  If Not Assigned(FHackMasterList) Then
  Begin
    FHackMasterList := TTSTOHackMasterListIO.CreateHackMasterList();

    lIdx := HackCfgFiles.IndexOf(hiftHackMasterList);
    If lIdx > -1 Then
    Begin
      lFileFormat := HackCfgFiles[lIdx].FileFormat;
      lIdx := FindFile(HackCfgFiles[lIdx].FileName);

      If lIdx > -1 Then
      Begin
        If lFileFormat = hiffBin Then
        Begin
          lMemStrm := TMemoryStreamEx.Create();
          Try
            ExtractToStream(lIdx, lMemStrm);
            lMemStrm.Position := 0;
            FHackMasterList.LoadFromStream(lMemStrm);

            Finally
              lMemStrm := Nil;
          End;
        End
        Else If lFileFormat = hiffXml Then
        Begin
          lStrStrm := TStringStreamEx.Create();
          Try
            ExtractToStream(lIdx, lStrStrm);
            FHackMasterList.AsXml := lStrStrm.DataString;

            Finally
              lStrStrm := Nil;
          End;
        End;
      End;
    End;

    FHackMasterList.OnChange := DoOnChange;
  End;

  Result := FHackMasterList;
End;

Procedure TTSTOHackSettingsImpl.SaveToFile(Const AFileName : String);
Var lStrStrm : IStringStreamEx;
    lMemStrm : IMemoryStreamEx;
    lIdx : Integer;
Begin
  If Assigned(FScriptTemplates) And FScriptTemplates.Modified Then
  Begin
    lIdx := HackCfgFiles.IndexOf(hiftHackTemplate);
    If lIdx > -1 Then
    Begin
      If HackCfgFiles[lIdx].FileFormat = hiffBin Then
      Begin
        lMemStrm := TMemoryStreamEx.Create();
        Try
          FScriptTemplates.SaveToStream(lMemStrm);
          lMemStrm.Position := 0;
          AddFromStream(HackCfgFiles[lIdx].FileName, lMemStrm);

          Finally
            lMemStrm := Nil;
        End;
      End
      Else If HackCfgFiles[lIdx].FileFormat = hiffXml Then
      Begin
        lStrStrm := TStringStreamEx.Create(FScriptTemplates.AsXml);
        Try
          lStrStrm.Position := 0;
          AddFromStream(HackCfgFiles[lIdx].FileName, lStrStrm);

          Finally
            lStrStrm := Nil;
        End;
      End;
    End;
  End;

  If Assigned(FTextPools) And FTextPools.Modified Then
  Begin
    lIdx := HackCfgFiles.IndexOf(hiftTextPools);
    If lIdx > -1 Then
    Begin
      If HackCfgFiles[lIdx].FileFormat = hiffBin Then
      Begin
        lMemStrm := TMemoryStreamEx.Create();
        Try
          FTextPools.SaveToStream(lMemStrm);
          lMemStrm.Position := 0;
          AddFromStream(HackCfgFiles[lIdx].FileName, lMemStrm);

          Finally
            lMemStrm := Nil;
        End;
      End
      Else If HackCfgFiles[lIdx].FileFormat = hiffXml Then
      Begin
        lStrStrm := TStringStreamEx.Create(FTextPools.AsXml);
        Try
          lStrStrm.Position := 0;
          AddFromStream(HackCfgFiles[lIdx].FileName, lStrStrm);

          Finally
            lStrStrm := Nil;
        End;
      End;
    End;
  End;

  If Assigned(FCustomPatches) And FCustomPatches.Modified Then
  Begin
    lIdx := HackCfgFiles.IndexOf(hiftCustomPatch);
    If lIdx > -1 Then
    Begin
      {If HackCfgFiles[lIdx].FileFormat = hiffBin Then
      Begin
        Raise Exception.Create('Binary format not supported for CustomPatches');
      End
      Else If HackCfgFiles[lIdx].FileFormat = hiffXml Then}
      Begin
        lStrStrm := TStringStreamEx.Create(FCustomPatches.AsXml);
        Try
          lStrStrm.Position := 0;
          AddFromStream(HackCfgFiles[lIdx].FileName, lStrStrm);

          Finally
            lStrStrm := Nil;
        End;
      End;
    End;
  End;

  If Assigned(FHackMasterList) And FHackMasterList.Modified Then
  Begin
    lIdx := HackCfgFiles.IndexOf(hiftHackMasterList);
    If lIdx > -1 Then
    Begin
      If HackCfgFiles[lIdx].FileFormat = hiffBin Then
      Begin
        lMemStrm := TMemoryStreamEx.Create();
        Try
          FHackMasterList.SaveToStream(lMemStrm);
          lMemStrm.Position := 0;
          AddFromStream(HackCfgFiles[lIdx].FileName, lMemStrm);

          Finally
            lMemStrm := Nil;
        End;
      End
      Else If HackCfgFiles[lIdx].FileFormat = hiffXml Then
      Begin
        lStrStrm := TStringStreamEx.Create(FHackMasterList.AsXml);
        Try
          lStrStrm.Position := 0;
          AddFromStream(HackCfgFiles[lIdx].FileName, lStrStrm);

          Finally
            lStrStrm := Nil;
        End;
      End;
    End;
  End;

  If (Assigned(FScriptTemplates) And FScriptTemplates.Modified) Or
     (Assigned(FCustomPatches) And FCustomPatches.Modified) Or
     (Assigned(FTextPools) And FTextPools.Modified) Or
     (Assigned(FHackMasterList) And FHackMasterList.Modified) Then
    InHerited SaveToFile(AFileName);
End;

Procedure TTSTOHackSettingsImpl.SaveToFile();
Begin
  SaveToFile(FFileName);
End;

Procedure TTSTOHackSettingsImpl.NewHackFile();
Var lZip : IHsMemoryZipper;
    lMemStrm : IMemoryStreamEx;
    lStrStrm : IStringstreamEx;
    lIdx : Integer;
Begin
  With HackCfgFiles Do
  Begin
    Clear();

    With Add() Do
    Begin
      FileName   := 'CustomPatches';
      FileType   := hiftCustomPatch;
      FileFormat := hiffBin;
    End;

    With Add() Do
    Begin
      FileName   := 'HackFilesTemplate';
      FileType   := hiftHackTemplate;
      FileFormat := hiffBin;
    End;

    With Add() Do
    Begin
      FileName   := 'HackMasterList';
      FileType   := hiftHackMasterList;
      FileFormat := hiffBin;
    End;

    With Add() Do
    Begin
      FileName   := 'TextPools';
      FileType   := hiftTextPools;
      FileFormat := hiffBin;
    End;

    With Add() Do
    Begin
      FileName   := 'GameScripts';
      FileType   := hiftTextPools;
      FileFormat := hiffZip;
    End;

    lMemStrm := TMemoryStreamEx.Create();
    Try
      FHackCfgFiles.SaveToStream(lMemStrm);
      lMemStrm.Position := 0;
      AddFromStream('HackIdx', lMemStrm);
      lMemStrm.Clear();

      lIdx := HackCfgFiles.IndexOf(hiftCustomPatch);
      If lIdx > -1 Then
      Begin
        lStrStrm := TStringstreamEx.Create(GetCustomPatches().AsXml);
        Try
          lStrStrm.Position := 0;
          AddFromStream(HackCfgFiles[lIdx].FileName, lStrStrm);

          Finally
            lStrStrm := Nil;
        End;
      End;

      lIdx := HackCfgFiles.IndexOf(hiftTextPools);
      If lIdx > -1 Then
      Begin
        GetTextPools().SaveToStream(lMemStrm);
        lMemStrm.Position := 0;
        AddFromStream(HackCfgFiles[lIdx].FileName, lMemStrm);
      End;
      lMemStrm.Clear();

      lIdx := HackCfgFiles.IndexOf(hiftHackMasterList);
      If lIdx > -1 Then
      Begin
        GetHackMasterList().SaveToStream(lMemStrm);
        lMemStrm.Position := 0;
        AddFromStream(HackCfgFiles[lIdx].FileName, lMemStrm);
      End;
      lMemStrm.Clear();

      lIdx := HackCfgFiles.IndexOf(hiftHackTemplate);
      If lIdx > -1 Then
      Begin
        GetScriptTemplates().SaveToStream(lMemStrm);
        lMemStrm.Position := 0;
        AddFromStream(HackCfgFiles[lIdx].FileName, lMemStrm);
      End;
      lMemStrm.Clear();

      //Create an empty zip file
      lMemStrm.WriteDWord($504B0506, True);
      lMemStrm.WriteDWord($0);
      lMemStrm.WriteDWord($0);
      lMemStrm.WriteDWord($0);
      lMemStrm.WriteDWord($0);
      lMemStrm.WriteWord($0);

      lMemStrm.Position := 0;
      AddFromStream('GameScripts', lMemStrm);
      Finally
        lMemStrm := Nil;
    End;
  End;
End;

Procedure TTSTOHackSettingsImpl.ExtractHackSource(Const AFileFormat : THackIdxFileFormat; APath : String = '');
Var lLst : IHsStringListEx;
    lMemStrm : IMemoryStreamEx;
    lPath : String;
    lIdx : Integer;
    lHackFile : ITSTOHackFileIndexes;
    X : Integer;
    lZip : IHsMemoryZipper;
Begin
  If APath = '' Then
    lPath := ChangeFileExt(FFileName, '.Src\')
  Else
    lPath := APath;

  If Not DirectoryExists(lPath) Then
    ForceDirectories(lPath);

  lHackFile := TTSTOHackFileIndexes.Create();
  Try
    lHackFile.Assign(HackCfgFiles);

    lMemStrm := TMemoryStreamEx.Create();
    Try
      For X := 0 To lHackFile.Count - 1 Do
        If lHackFile[X].FileFormat <> hiffZip Then
        Begin
          If AFileFormat = hiffXml Then
            lHackFile[X].FileName := ChangeFileExt(lHackFile[X].FileName, '.xml');
          lHackFile[X].FileFormat := AFileFormat;
        End;
      lHackFile.SaveToStream(lMemStrm);
      lMemStrm.SaveToFile(lPath + 'HackIdx');

      Finally
        lMemStrm := Nil;
    End;

    lLst := THsStringListEx.CreateList();
    Try
      lIdx := lHackFile.IndexOf(hiftCustomPatch);
      If lIdx > -1 Then
      Begin
//        If lHackFile[lIdx].FileFormat = hiffXml Then
        Begin
          lLst.Text := FormatXmlData(CustomPatches.AsXml);
          lLst.SaveToFile(lPath + lHackFile[lIdx].FileName);
        End;
//        Else If lHackFile[lIdx].FileFormat = hiffBin Then
//          Raise Exception.Create('Binary format not supported for CustomPatches');
      End;

      lIdx := lHackFile.IndexOf(hiftGameScript);
      If lIdx > -1 Then
      Begin
        If lHackFile[lIdx].FileFormat = hiffZip Then
        Begin
          lMemStrm := TMemoryStreamEx.Create();
          Try
            ExtractToStream(lHackFile[lIdx].FileName, lMemStrm);

            lZip := THsMemoryZipper.Create();
            Try
              lZip.LoadFromStream(lMemStrm);
              lZip.ShowProgress := False;
              lZip.ExtractFiles('*.*', lPath + lHackFile[lIdx].FileName + '.Src');

              Finally
                lZip := Nil;
            End;

            Finally
              lMemStrm := Nil;
          End;
        End;
      End;

      lIdx := lHackFile.IndexOf(hiftHackTemplate);
      If lIdx > -1 Then
      Begin
        If lHackFile[lIdx].FileFormat = hiffXml Then
        Begin
          lLst.Text := ScriptTemplates.AsXml;
          lLst.SaveToFile(lPath + lHackFile[lIdx].FileName);
        End
        Else If lHackFile[lIdx].FileFormat = hiffBin Then
        Begin
          lMemStrm := TMemoryStreamEx.Create();
          Try
            ScriptTemplates.SaveToStream(lMemStrm);
            lMemStrm.SaveToFile(lPath + lHackFile[lIdx].FileName);

            Finally
              lMemStrm := Nil;
          End;
        End;
      End;

      lIdx := lHackFile.IndexOf(hiftHackMasterList);
      If lIdx > -1 Then
      Begin
        If lHackFile[lIdx].FileFormat = hiffXml Then
        Begin
          lLst.Text := HackMasterList.AsXml;
          lLst.SaveToFile(lPath + lHackFile[lIdx].FileName);
        End
        Else
        Begin
          lMemStrm := TMemoryStreamEx.Create();
          Try
            HackMasterList.SaveToStream(lMemStrm);
            lMemStrm.SaveToFile(lPath + lHackFile[lIdx].FileName);

            Finally
              lMemStrm := Nil;
          End;
        End;
      End;

      lIdx := lHackFile.IndexOf(hiftTextPools);
      If lIdx > -1 Then
      Begin
        If lHackFile[lIdx].FileFormat = hiffXml Then
        Begin
          lLst.Text := TextPools.AsXml;
          lLst.SaveToFile(lPath + lHackFile[lIdx].FileName);
        End
        Else
        Begin
          lMemStrm := TMemoryStreamEx.Create();
          Try
            TextPools.SaveToStream(lMemStrm);
            lMemStrm.SaveToFile(lPath + lHackFile[lIdx].FileName);

            Finally
              lMemStrm := Nil;
          End;
        End;
      End;

      Finally
        lLst := Nil;
    End;

    Finally
      lHackFile := Nil;
  End;
End;

Procedure TTSTOHackSettingsImpl.PackHackSource(Const AFileFormat : THackIdxFileFormat; Const AIndexFile, AFileName : String);
Var lZip       ,
    lZip2      : IHsMemoryZipper;
    lHackFile  ,
    lHackFile2 : ITSTOHackFileIndexes;
    lMemStrm   : IMemoryStreamEx;
    lStrStrm   : IStringStreamEx;
    lPath      : String;

    X : Integer;
    lLst : IHsStringListEx;
    lIdx : Integer;
    lCustomPatches   : ITSTOCustomPatchesIO;
    lScriptTemplates : ITSTOScriptTemplateHacksIO;
    lHackMasterList  : ITSTOHackMasterListIO;
    lTextPools       : ISbtpFilesIO;
    lSr : TSearchRec;
Begin
  If FileExists(AIndexFile) Then
  Begin
    lPath := ExtractFilePath(AIndexFile);

    lHackFile := TTSTOHackFileIndexes.Create();
    lHackFile2 := TTSTOHackFileIndexes.Create();
    Try
(**)
      lZip := THsMemoryZipper.Create();
      lZip.ShowProgress := False;

      lMemStrm := TMemoryStreamEx.Create();
      Try
        lMemStrm.LoadFromFile(AIndexFile);
        lMemStrm.Position := 0;
        lHackFile.LoadFromStream(lMemStrm);
        lHackFile2.Assign(lHackFile);

        For X := 0 To lHackFile.Count - 1 Do
          If lHackFile[X].FileFormat <> hiffZip Then
          Begin
            If AFileFormat = hiffXml Then
              lHackFile[X].FileName := ChangeFileExt(lHackFile[X].FileName, '.xml')
            Else If AFileFormat = hiffBin Then
              lHackFile[X].FileName := ChangeFileExt(lHackFile[X].FileName, '');

            lHackFile[X].FileFormat := AFileFormat;
          End;

        lMemStrm.Clear();
        lHackFile.SaveToStream(lMemStrm);
        lMemStrm.Position := 0;
        lZip.AddFromStream(ExtractFileName(AIndexFile), lMemStrm);

        Finally
          lMemStrm := Nil;
      End;

      lLst := THsStringListEx.CreateList();
      Try
        lIdx := lHackFile2.IndexOf(hiftCustomPatch);
        If lIdx > -1 Then
        Begin
          lCustomPatches := TTSTOCustomPatchesIO.CreateCustomPatchIO();
          Try
//            If lHackFile2[lIdx].FileFormat = hiffXml Then
            Begin
              lStrStrm := TStringStreamEx.Create();
              Try
                lStrStrm.LoadFromFile(lPath + lHackFile2[lIdx].FileName);
                lCustomPatches.AsXml := lStrStrm.DataString;

                Finally
                  lStrStrm := Nil;
              End;
            End;{
            Else If lHackFile2[lIdx].FileFormat = hiffBin Then
              Raise Exception.Create('Binary format not supported for CustomPatches');
}
//            If lHackFile[lIdx].FileFormat = hiffXml Then
            Begin
              lStrStrm := TStringStreamEx.Create(lCustomPatches.AsXml);
              Try
                lStrStrm.Position := 0;
                lZip.AddFromStream(lHackFile[lIdx].FileName, lStrStrm);

                Finally
                  lStrStrm := Nil;
              End;
            End;{
            Else If lHackFile[lIdx].FileFormat = hiffBin Then
              Raise Exception.Create('Binary format not supported for CustomPatches');
}

            Finally
              lCustomPatches := Nil;
          End;
        End;

        lIdx := lHackFile2.IndexOf(hiftGameScript);
        If lIdx > -1 Then
        Begin
          If lHackFile[lIdx].FileFormat = hiffZip Then
          Begin
            lZip2 := THsMemoryZipper.Create();
            lZip2.StoreOptions := lZip2.StoreOptions + [soRecurse] - [soStripPath, soStripDrive];
            Try
              If DirectoryExists(lPath + lHackFile2[lIdx].FileName + '.Src') Then
              Begin
                lZip2.ShowProgress := False;
                lZip2.AddFiles(lPath + lHackFile2[lIdx].FileName + '.Src\*.*', faAnyFile);
                lZip2.RemovePathPart(StringReplace(StringReplace(lPath, ExtractFileDrive(lPath) + '\', '', [rfReplaceAll, rfIgnoreCase]) + lHackFile2[lIdx].FileName + '.Src\', '\', '/', [rfReplaceAll, rfIgnoreCase]));

                (lZip2 As IMemoryStreamEx).Position := 0;
                lZip.AddFromStream(lHackFile[lIdx].FileName, (lZip2 As IMemoryStreamEx));
              End;

              Finally
                lZip2 := Nil;
            End;
          End;
        End;

        lIdx := lHackFile2.IndexOf(hiftHackTemplate);
        If lIdx > -1 Then
        Begin
          lScriptTemplates := TTSTOScriptTemplateHacksIO.CreateScriptTemplateHacks(lPath + lHackFile2[lIdx].FileName);
          Try
            If lHackFile[lIdx].FileFormat = hiffXml Then
            Begin
              lStrStrm := TStringStreamEx.Create(lScriptTemplates.AsXml);
              Try
                lStrStrm.Position := 0;
                lZip.AddFromStream(lHackFile[lIdx].FileName, lStrStrm);

                Finally
                  lStrStrm := Nil;
              End;
            End
            Else If lHackFile[lIdx].FileFormat = hiffBin Then
            Begin
              lMemStrm := TMemoryStreamEx.Create();
              Try
                lScriptTemplates.SaveToStream(lMemStrm);
                lMemStrm.Position := 0;
                lZip.AddFromStream(lHackFile[lIdx].FileName, lMemStrm);
                Finally
                  lMemStrm := Nil;
              End;
            End;

            Finally
              lScriptTemplates := Nil;
          End;
        End;

        lIdx := lHackFile2.IndexOf(hiftHackMasterList);
        If lIdx > -1 Then
        Begin
          lHackMasterList := TTSTOHackMasterListIO.CreateHackMasterList();
          Try
            If lHackFile2[lIdx].FileFormat = hiffXml Then
              lHackMasterList.LoadFromFile(lPath + lHackFile2[lIdx].FileName)
            Else If lHackFile2[lIdx].FileFormat = hiffBin Then
            Begin
              lMemStrm := TMemoryStreamEx.Create();
              Try
                lMemStrm.LoadFromFile(lPath + lHackFile2[lIdx].FileName);
                lMemStrm.Position := 0;
                lHackMasterList.LoadFromStream(lMemStrm);

                Finally
                  lMemStrm := Nil;
              End;
            End;

            If lHackFile[lIdx].FileFormat = hiffXml Then
            Begin
              lStrStrm := TStringStreamEx.Create(lHackMasterList.AsXml);
              Try
                lStrStrm.Position := 0;
                lZip.AddFromStream(lHackFile[lIdx].FileName, lStrStrm);

                Finally
                  lStrStrm := Nil;
              End;
            End
            Else If lHackFile[lIdx].FileFormat = hiffBin Then
            Begin
              lMemStrm := TMemoryStreamEx.Create();
              Try
                lHackMasterList.SaveToStream(lMemStrm);
                lMemStrm.Position := 0;
                lZip.AddFromStream(lHackFile[lIdx].FileName, lMemStrm);

                Finally
                  lMemStrm := Nil;
              End;
            End;

            Finally
              lHackMasterList := Nil;
          End;
        End;

        lIdx := lHackFile2.IndexOf(hiftTextPools);
        If lIdx > -1 Then
        Begin
          If lHackFile2[lIdx].FileFormat = hiffXml Then
            lTextPools := TSbtpFilesIO.LoadXmlSbtpFiles(lPath + lHackFile2[lIdx].FileName)
          Else If lHackFile2[lIdx].FileFormat = hiffBin Then
            lTextPools := TSbtpFilesIO.LoadBinSbtpFiles(lPath + lHackFile2[lIdx].FileName);

          Try
            If lHackFile[lIdx].FileFormat = hiffXml Then
            Begin
              lStrStrm := TStringStreamEx.Create(lTextPools.AsXml);
              Try
                lStrStrm.Position := 0;
                lZip.AddFromStream(lHackFile[lIdx].FileName, lStrStrm);

                Finally
                  lStrStrm := Nil;
              End;
            End
            Else If lHackFile[lIdx].FileFormat = hiffBin Then
            Begin
              lMemStrm := TMemoryStreamEx.Create();
              Try
                lTextPools.SaveToStream(lMemStrm);
                lMemStrm.Position := 0;
                lZip.AddFromStream(lHackFile[lIdx].FileName, lMemStrm);

                Finally
                  lMemStrm := Nil;
              End;
            End;

            Finally
              lTextPools := Nil;
          End;
        End;

        lZip.SaveToFile(AFileName);

        Finally
          lZip := Nil;
          lLst := Nil;
      End;

      Finally
        lHackFile := Nil;
        lHackFile2 := Nil;
    End;
  End;
End;

Procedure TTSTOHackSettingsImpl.LoadFromFile(Const AFileName : String);
Begin
  If FileExists(AFileName) Then
  Begin
    FFileName := AFileName;

    InHerited LoadFromFile(AFileName);
  End;
End;

end.
