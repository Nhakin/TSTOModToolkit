unit TSTOModToolKit;

interface

Uses Windows, Classes, SysUtils, HsStringListEx,
  TSTOProject.Xml, TSTODlcIndex, TSTOPatches, TSTOProjectWorkSpace.IO;

Type
  TTSTODlcGenerator = Class(TObject)
  Public
    Procedure ValidateXmlFiles(AProject : ITSTOXMLProject);
    Procedure CreateMod(AProject : ITSTOXMLProject; AWorkSpace : ITSTOWorkSpaceProjectIO; AMasterFiles : ITSTOXmlMasterFiles);
    Procedure CreateSbtpMod(AWorkSpaceProject : ITSTOWorkSpaceProjectIO);
    Procedure CreateDLCEx(AProject : ITSTOXMLProject);
    Procedure CreateRootDLC(AProject : ITSTOXMLProject; ACrcValue : DWord);

    Procedure DownloadDLCIndex(AProject : ITSTOXMLProject);
    Procedure DownloadAllDLCIndex(AProject : ITSTOXMLProject);
    Function GetIndexFileNames(AProject : ITSTOXMLProject) : IHsStringListEx;
    Function GetIndexPackage(AProject : ITSTOXMLProject; Var AFileName : String) : ITSTOXmlDlcIndex; OverLoad;
    Function GetIndexPackage(AProject : ITSTOXMLProject) : ITSTOXmlDlcIndex; OverLoad;

  End;

implementation

Uses Forms, Dialogs, Controls,
  HsZipUtils, HsStreamEx, HsXmlDocEx, HsCheckSumEx,
  TSTODownloader, TSTOZero.Bin, TSTOSbtpIntf, TSTOSbtp.IO;

(******************************************************************************)

Procedure TTSTODlcGenerator.ValidateXmlFiles(AProject : ITSTOXMLProject);
Var X, Y : Integer;
    lPath : String;
    lSr   : TSearchRec;
Begin
  For X := 0 To AProject.ProjectFiles.Count - 1 Do
    For Y := 0 To AProject.ProjectFiles[X].SourcePaths.Count - 1 Do
    Begin
      lPath := IncludeTrailingBackslash(AProject.ProjectFiles[X].SourcePaths[Y]);

      If FindFirst(lPath + '*.xml', faAnyFile, lSr) = 0 Then
      Try
        Repeat
          With TStringList.Create() Do
          Try
            Try
              LoadFromFile(lPath + lSr.Name);
              If Copy(Text, 1, 3) = #$EF#$BB#$BF Then
                Text := Copy(Text, 4, Length(Text));
              Text := FormatXMLData(Text);

              Except
                On E:Exception Do
                  ShowMessage('Error Xml : ' + lSr.Name + #$D#$A + E.Message);
            End;

            Finally
              Free();
          End;
          Application.ProcessMessages();
        Until FindNext(lSr) <> 0;

        Finally
          FindClose(lSr);
      End;
    End;
  ShowMessage('Done no error found.');
End;

Procedure TTSTODlcGenerator.CreateMod(AProject : ITSTOXMLProject; AWorkSpace : ITSTOWorkSpaceProjectIO; AMasterFiles : ITSTOXmlMasterFiles);
Var lMod : ITSTOModder;
Begin
  lMod := TTSTOModder.Create();
  Try
    lMod.CreateMod(AProject, AWorkSpace, AMasterFiles);

    Finally
      lMod := Nil;
  End;
End;
{
Procedure TTSTODlcGenerator.CreateSbtpMod(AProject : ITSTOXMLProject);
Var lZip : IHsMemoryZipper;
    lMem : IMemoryStreamEx;
    lPatch : ITSTOSbtpPatchFile;
    lStrs : TStringList;
    lSr   : TSearchRec;
    X, Y, Z : Integer;
    lSbtp : ITSTOSbtpFile;
    lSbtpFName : String;
    lIdx  : Integer;
    lStrIdx : String;
Begin
  If FileExists(AProject.Settings.HackFileName) Then
  Begin
    lZip := THsMemoryZipper.Create();
    lMem := TMemoryStreamEx.Create();
    Try
      lZip.ShowProgress := False;
      lZip.LoadFromFile(AProject.Settings.HackFileName);
      lZip.ExtractToStream('TextPools', lMem);

      If lMem.Size > 0 Then
      Begin
        lPatch := TTSTOSbtpPatchFile.Create();
        lStrs := TStringList.Create();
        Try
          lPatch.LoadFromStream(lMem);
          If lPatch.Patchs.Count > 0 Then
          Begin
            If FindFirst(AProject.Settings.SourcePath + '*.sbtp', faAnyFile, lSr) = 0 Then
            Try
              Repeat
                lStrs.Add(lSr.Name);
              Until FindNext(lSr) <> 0;

              Finally
                FindClose(lSr);
            End;
          End;

          For X := 0 To lPatch.Patchs.Count - 1 Do
          Begin
            lSbtp := Nil;
            lSbtpFName := '';

            For Y := 0 To lStrs.Count - 1 Do
            Begin
              lStrIdx := '';
              For Z := 1 To Length(lStrs[Y]) Do
                If lStrs[Y][Z] In [#$30..#$39] Then
                  lStrIdx := lStrIdx + lStrs[Y][Z];

              If lPatch.Patchs[X].FileIndex = StrToIntDef(lStrIdx, -1) Then
              Begin
                lSbtp := TTSTOSbtpFile.Create();
                lSbtp.LoadFromFile(AProject.Settings.SourcePath + lStrs[Y]);
                lSbtpFName := lStrs[Y];
                Break;
              End;
            End;

            If Assigned(lSbtp) Then
            Begin
              For Y := 0 To lPatch.Patchs[X].Variables.Count - 1 Do
              Begin
                lIdx := lSbtp.Variables.IndexOf(lPatch.Patchs[X].Variables[Y].VariableName);
                If lIdx = -1 Then
                  lSbtp.Variables.Add().Assign(lPatch.Patchs[X].Variables[Y])
                Else
                  lSbtp.Variables[lIdx].DataAsString := lPatch.Patchs[X].Variables[Y].DataAsString;
              End;

              lSbtp.SaveToFile(AProject.Settings.TargetPath + lSbtpFName);
            End;
          End;

          Finally
            lStrs.Free();
            lPatch := Nil;
        End;
      End;

      Finally
        lMem := Nil;
        lZip := Nil;
    End;
  End;
End;
}

Procedure TTSTODlcGenerator.CreateSbtpMod(AWorkSpaceProject : ITSTOWorkSpaceProjectIO);
Var lZip : IHsMemoryZipper;
    lMem : IMemoryStreamEx;
    lPatch : ISbtpFilesIO;
    lStrs : IHsStringListEx;
    lSr   : TSearchRec;
    X, Y, Z : Integer;
    lSbtp : ISbtpFileIO;
    lSbtpFName : String;
    lIdx  : Integer;
    lStrIdx : String;

    lVariable : ISbtpVariable;
Begin
  lPatch := AWorkSpaceProject.GlobalSettings.TextPools;
  Try
    If lPatch.Count > 0 Then
    Begin
      lStrs := THsStringListEx.CreateList();
      Try
        If FindFirst(AWorkSpaceProject.SrcPath + '*.sbtp', faAnyFile, lSr) = 0 Then
        Try
          Repeat
            lStrs.Add(lSr.Name);
          Until FindNext(lSr) <> 0;

          Finally
            FindClose(lSr);
        End;

        For X := 0 To lPatch.Count - 1 Do
        Begin
          lSbtp := Nil;
          lSbtpFName := '';

          For Y := 0 To lStrs.Count - 1 Do
          Begin
            lStrIdx := '';
            For Z := 1 To Length(lStrs[Y]) Do
              If lStrs[Y][Z] In [#$30..#$39] Then
                lStrIdx := lStrIdx + lStrs[Y][Z];

            If lPatch[X].Header.HeaderPadding = StrToIntDef(lStrIdx, -1) Then
            Begin
              lSbtp := TSbtpFileIO.LoadBinSbtpFile(AWorkSpaceProject.SrcPath + lStrs[Y]);
              lSbtpFName := lStrs[Y];
              Break;
            End;
          End;

          If Assigned(lSbtp) Then
          Begin
            For Y := 0 To lPatch[X].Item.Count - 1 Do
            Begin
              lIdx := lSbtp.Item.IndexOf(lPatch[X].Item[Y].VariableType);
              If lIdx = -1 Then
                lSbtp.Item.Add().Assign(lPatch[X].Item[Y])
              Else
              Begin
                lVariable := lSbtp.Item[lIdx];

                For Z := 0 To lPatch[X].Item[Y].SubItem.Count - 1 Do
                Begin
                  lIdx := lVariable.SubItem.IndexOf(lPatch[X].Item[Y].SubItem[Z].VariableName);
                  If lIdx = -1 Then
                    lVariable.SubItem.Add().Assign(lPatch[X].Item[Y].SubItem[Z])
                  Else
                    lVariable.SubItem[lIdx].VariableData := lPatch[X].Item[Y].SubItem[Z].VariableData;
                End;
              End;
            End;

            lSbtp.SaveToFile(AWorkSpaceProject.CustomModPath + lSbtpFName);
          End;
        End;

        Finally
          lStrs := Nil;
      End;
    End;

    Finally
      lPatch := Nil;
  End;
End;

Procedure TTSTODlcGenerator.CreateDLCEx(AProject : ITSTOXMLProject);
Var lZips   : IHsMemoryZippers;
    lZip    : IHsMemoryZipper;
    lZero   : IBinZeroFile;
    X, Y, Z : Integer;
    lPos    : Integer;
    lMem    : IMemoryStreamEx;
    lDlc    : ITSTOXmlDlcIndex;
    lDlcFileName : String;
    lStr    : TStringStream;
Begin
  lDlc := GetIndexPackage(AProject, lDlcFileName);
  lZips := THsMemoryZippers.Create();
  Try
    For X := 0 To AProject.ProjectFiles.Count - 1 Do
    Begin
      lZips.Clear();
      For Y := 0 To AProject.ProjectFiles[X].SourcePaths.Count - 1 Do
      Begin
        If DirectoryExists(AProject.ProjectFiles[X].SourcePaths[Y]) Then
        Begin
          lZip := lZips.Add();
          lZip.AddFiles(AProject.ProjectFiles[X].SourcePaths[Y] + '*.*', faAnyFile);
          lZip.FileName := ExtractFileName(ExcludeTrailingBackslash(AProject.ProjectFiles[X].SourcePaths[Y]));
          lPos := Pos('.', lZip.FileName);
          If lPos > 0 Then
            lZip.FileName := Copy(lZip.FileName, 1, lPos - 1);
          TStream(lZip.InterfaceObject).Position := 0;
          Application.ProcessMessages();
        End;
      End;

      lZip := THsMemoryZipper.Create();
      lZero := TBinZeroFile.CreateBinZeroFile();
      Try
        lZero.ArchiveDirectory := 'KahnAbyss/TSTO DLC Generator';
        For Y := 0 To lZips.Count - 1 Do
        Begin
          lZip.AddFromStream(lZips[Y].FileName, TStream(lZips[Y].InterfaceObject));

          With lZero.FileDatas.Add() Do
          Begin
            FileName := lZip[Y].FileName;
            Crc32    := lZip[Y].Crc32;

            For Z := 0 To lZips[Y].Count - 1 Do
              With ArchivedFiles.Add() Do
              Begin
                FileName1     := lZips[Y][Z].FileName;
                FileExtension := StringReplace(ExtractFileExt(lZips[Y][Z].FileName), '.', '', [rfReplaceAll, rfIgnoreCase] );
                FileName2     := FileName1;
                FileSize      := lZips[Y][Z].UncompressedSize;
                ArchiveFileId := Y;
                Application.ProcessMessages();
              End;
          End;
        End;

        lMem := TMemoryStreamEx.Create();
        Try
          lZero.SaveToStream(lMem);
          lMem.Position := 0;
          lZip.AddFromStream('0', lMem);

          Finally
            lMem := Nil;
        End;

        Finally
          lZero := Nil;
      End;

      If Not DirectoryExists(AProject.ProjectFiles[X].OutputPath) Then
        ForceDirectories(AProject.ProjectFiles[X].OutputPath);

      lZip.SaveToFile( AProject.ProjectFiles[X].OutputPath +
                       AProject.ProjectFiles[X].OutputFileName);
      If Assigned(lDlc) Then
      Begin
        For Y := 0 To lDlc.Package.Count - 1 Do
        Begin
          If SameText(lDlc.Package[Y].FileName.FileName, AProject.ProjectFiles[X].OutputFileName) Then
          Begin
            lDlc.Package[Y].IndexFileCRC.Val := lZip[lZip.Count - 1].Crc32;
            Break;
          End;

          Application.ProcessMessages();
        End;

        For Y := 0 To lDlc.InitialPackages.Count - 1 Do
        Begin
          If SameText(lDlc.InitialPackages[Y].FileName.FileName, AProject.ProjectFiles[X].OutputFileName) Then
          Begin
            lDlc.InitialPackages[Y].IndexFileCRC.Val := lZip[lZip.Count - 1].Crc32;
            Break;
          End;

          Application.ProcessMessages();
        End;

//        For Y := 0 To lDlc.TutorialPackages.Count - 1 Do
//        Begin
//          If SameText(lDlc.TutorialPackages[Y].FileName.FileName, AProject.ProjectFiles[X].OutputFileName) Then
//          Begin
//            lDlc.TutorialPackages[Y].IndexFileCRC.Val := lZip[lZip.Count - 1].Crc32;
//            Break;
//          End;
//
//          Application.ProcessMessages();
//        End;

        Application.ProcessMessages();
      End;

    End;

    If Assigned(lDlc) Then
    Begin
      lStr := TStringStream.Create(lDlc.Xml);
      Try
        lStr.Position := 0;
        lZip := THsMemoryZipper.Create();
        lZip.ShowProgress := False;
        lZip.AddFromStream(ChangeFileExt(ExtractFileName(lDlcFileName), '.xml'), lStr);
        lZip.SaveToFile(lDlcFileName);

        Finally
          lStr.Free();
      End;
    End;

    Finally
      lZips := Nil;
  End;
End;

Procedure TTSTODlcGenerator.CreateRootDLC(AProject : ITSTOXMLProject; ACrcValue : DWord);
Var lZips   : IHsMemoryZippers;
    lZip    : IHsMemoryZipper;
    X, Y, Z : Integer;
    lPos    : Integer;
    lZero   : IBinZeroFile;
    lMem    : IMemoryStreamEx;
Begin
  lZips := THsMemoryZippers.Create();
  Try
    For X := 0 To AProject.ProjectFiles.Count - 1 Do
    Begin
      lZips.Clear();
      For Y := 0 To AProject.ProjectFiles[X].SourcePaths.Count - 1 Do
      Begin
        If DirectoryExists(AProject.ProjectFiles[X].SourcePaths[Y]) Then
        Begin
          lZip := lZips.Add();
          lZip.AddFiles(AProject.ProjectFiles[X].SourcePaths[Y] + '*.*', faAnyFile);
          lZip.FileName := ExtractFileName(ExcludeTrailingBackslash(AProject.ProjectFiles[X].SourcePaths[Y]));
          lPos := Pos('.', lZip.FileName);
          If lPos > 0 Then
            lZip.FileName := Copy(lZip.FileName, 1, lPos - 1);
          TStream(lZip.InterfaceObject).Position := 0;
          Application.ProcessMessages();
        End;
      End;

      lZip := THsMemoryZipper.Create();
      lZero := TBinZeroFile.CreateBinZeroFile();
      Try
        lZero.ArchiveDirectory := 'KahnAbyss/TSTO DLC Generator';
        For Y := 0 To lZips.Count - 1 Do
        Begin
          With lZero.FileDatas.Add() Do
          Begin
            FileName := lZips[Y].FileName;
            Crc32    := GetCrc32Value(TStream(lZips[Y].InterfaceObject));

            For Z := 0 To lZips[Y].Count - 1 Do
              With ArchivedFiles.Add() Do
              Begin
                FileName1     := lZips[Y][Z].FileName;
                FileExtension := StringReplace(ExtractFileExt(lZips[Y][Z].FileName), '.', '', [rfReplaceAll, rfIgnoreCase]);
                FileName2     := FileName1;
                FileSize      := lZips[Y][Z].UncompressedSize;
                ArchiveFileId := Y;
                Application.ProcessMessages();
              End;
          End;
        End;

        lMem := TMemoryStreamEx.Create();
        Try
          With lZero.FileDatas[lZero.FileDatas.Count - 1].ArchivedFiles.Add() Do
          Begin
            FileName1     := 'ZeroCrc.hex';//'CrcHack.xml';
            FileExtension := 'hex';//'xml';
            FileName2     := FileName1;
            FileSize      := 0;
            ArchiveFileId := lZero.FileDatas.Count - 1
          End;

          lZero.SaveToStream(lMem);
          lMem.Size := lMem.Size - SizeOf(DWord);
          SetCrc32Value(TStream(lMem.InterfaceObject), lMem.Size - SizeOf(QWord), ACrcValue);
          lMem.Position := lMem.Size;
          lMem.WriteDWord(ACrcValue, True);

          lMem.Position := 0;
          lZip.AddFromStream('0', lMem);

          For Y := 0 To lZips.Count - 1 Do
          Begin
            (lZips[Y] As IMemoryStreamEx).Position := 0;
            lZip.AddFromStream(lZips[Y].FileName, (lZips[Y] As IMemoryStreamEx));
          End;

          Finally
            lMem := Nil;
        End;

        Finally
          lZero := Nil;
      End;

      If Not DirectoryExists(AProject.ProjectFiles[X].OutputPath) Then
        ForceDirectories(AProject.ProjectFiles[X].OutputPath);

      lZip.SaveToFile( AProject.ProjectFiles[X].OutputPath +
                       AProject.ProjectFiles[X].OutputFileName);
    End;

    Finally
      lZips := Nil;
  End;
End;

Procedure TTSTODlcGenerator.DownloadDLCIndex(AProject : ITSTOXMLProject);
Var lDown : ITSTODownloader;
Begin
  If AProject.Settings.DLCServer <> '' Then
  Begin
    If AProject.Settings.DLCPath = '' Then
      AProject.Settings.DLCPath := ExtractFilePath(ParamStr(0)) + 'TSTODlcServer';
    If Not DirectoryExists(AProject.Settings.DLCPath) Then
      ForceDirectories(AProject.Settings.DLCPath);

    lDown := TTSTODownloader.CreateDownloader();
    Try
      lDown.ServerName   := AProject.Settings.DLCServer;
      lDown.DownloadPath := AProject.Settings.DLCPath;
      lDown.DownloadDlcIndex();

      Finally
        lDown := Nil;
    End;
  End
  Else
    MessageDlg('DlcServer not set', mtError, [mbOk], 0);
End;

Procedure TTSTODlcGenerator.DownloadAllDLCIndex(AProject : ITSTOXMLProject);
Var X : Integer;
    lDown : ITSTODownloader;
Begin
  With GetIndexFileNames(AProject) Do
  Begin
    lDown := TTSTODownloader.CreateDownloader();
    Try
      lDown.ServerName   := AProject.Settings.DLCServer;
      lDown.DownloadPath := AProject.Settings.DLCPath;

      For X := 0 To Count - 1 Do
        lDown.AddFile(StringReplace(Strings[X], ':', '/', [rfReplaceAll]));

      lDown.DownloadFile();

      Finally
        lDown := Nil;
    End;
  End;
End;

Function TTSTODlcGenerator.GetIndexFileNames(AProject : ITSTOXMLProject) : IHsStringListEx;
Var lZip : IHsMemoryZipper;
    lStrStream : IStringStreamEx;
    lNodes : IXmlNodeListEx;
    X : Integer;
Begin
  Result := THsStringListEx.CreateList();

  If FileExists(AProject.Settings.DLCPath + '\dlc\DLCIndex.zip') Then
  Begin
    lZip := THsMemoryZipper.Create();
    lStrStream := TStringStreamEx.Create();
    Try
      lZip.LoadFromFile(AProject.Settings.DLCPath + '\dlc\DLCIndex.zip');
      lZip.ExtractToStream(lZip[0].FileName, TStream(lStrStream.InterfaceObject));
      lNodes := LoadXMLData(lStrStream.DataString).SelectNodes('//IndexFile/@index');;

      For X := 0 To lNodes.Count - 1 Do
        Result.Add(StringReplace(lNodes[X].Text, ':', '\', [rfReplaceAll]));

      Finally
        lZip := Nil;
        lStrStream := Nil;
        lNodes := Nil;
    End;
  End;
End;

Function TTSTODlcGenerator.GetIndexPackage(AProject : ITSTOXMLProject; Var AFileName : String) : ITSTOXmlDlcIndex;
Var lZip         : IHsMemoryZipper;
    lXml         : IXmlDocumentEx;
    lStrStream   : IStringStreamEx;
    lNode        : IXmlNodeEx;
    lIdxFileName : String;
Begin
  If DirectoryExists(AProject.Settings.DLCPath + '\dlc') And
     FileExists(AProject.Settings.DLCPath + '\dlc\DLCIndex.zip') Then
  Begin
    lZip       := THsMemoryZipper.Create();
    lStrStream := TStringStreamEx.Create();
    Try
      lZip.LoadFromFile(AProject.Settings.DLCPath + '\dlc\DLCIndex.zip');
      lZip.ExtractToStream(lZip[0].FileName, TStream(lStrStream.InterfaceObject));
      lXml := LoadXMLData(lStrStream.DataString);
      Try
        lNode := lXml.SelectNode('//IndexFile[1]/@index');
        If Assigned(lNode) Then
        Try
          lIdxFileName := StringReplace(lNode.Text, ':', '\', [rfReplaceAll, rfIgnoreCase]);

          If FileExists(AProject.Settings.DLCPath + lIdxFileName) Then
          Begin
            lZip.LoadFromFile(AProject.Settings.DLCPath + lIdxFileName);
            lStrStream.Clear();
            lZip.ExtractToStream(lZip[0].FileName, TStream(lStrStream.InterfaceObject));
            AFileName := AProject.Settings.DLCPath + lIdxFileName;
            Result := GetDlcIndex(LoadXMLData(lStrStream.DataString));
          End
          Else
          Begin
            If MessageDlg('Dlc index not found...'#$D#$A'Do you want to download it now?', mtConfirmation, [mbYes, mbNo], 0) = mrYes Then
            Begin
              DownloadDLCIndex(AProject);
              Result := GetIndexPackage(AProject, AFileName);
            End;
          End;

          Finally
            lNode := Nil;
        End;

        Finally
          lXml := Nil;
      End;

      Finally
        lStrStream := Nil;
        lZip       := Nil;
    End;
  End
  Else
  Begin
    If MessageDlg('Dlc index not found...'#$D#$A'Do you want to download it now?', mtConfirmation, [mbYes, mbNo], 0) = mrYes Then
    Begin
      DownloadDLCIndex(AProject);
      Result := GetIndexPackage(AProject, AFileName);
    End;
  End
End;

Function TTSTODlcGenerator.GetIndexPackage(AProject : ITSTOXMLProject) : ITSTOXmlDlcIndex;
Var lDummy : String;
Begin
  Result := GetIndexPackage(AProject, lDummy);
End;

end.
