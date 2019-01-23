unit TSTOPatches;

interface

Uses Classes, HsInterfaceEx, HsXmlDocEx,
  TSTOProject.Xml, TSTOStoreMenuMaster, TSTOStoreMenu,
  TSTOSbtp.IO, TSTOCustomPatches.IO, TSTOHackSettings, RgbExtractProgress;

Type
  TPatchType = ( tptCost, tptDynamicBuyInfo, tptDynamicSellInfo,
                 tptNonUnique, tptInstantBuild, tptUnlimitedTime);

  ITSTOXmlPatch = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-A2FD-AF9E6BEF0E0E}']
    Function  GetPatchType() : TPatchType;
    Procedure SetPatchType(Const APatchType : TPatchType);

    Function  GetPatches() : IXmlNodeListEx;
    Procedure SetPatches(Const APatch : IXmlNodeListEx);

    Property PatchType : TPatchType     Read GetPatchType Write SetPatchType;
    Property Patches   : IXmlNodeListEx Read GetPatches   Write SetPatches;

  End;

  ITSTOXmlPatchesEnumerator = Interface(IInterfaceExEnumerator)
    ['{4B61686E-29A0-2112-9B3C-79C8DDEF0ED1}']
    Function GetCurrent() : ITSTOXmlPatch;
    Property Current : ITSTOXmlPatch Read GetCurrent;

  End;

  ITSTOXmlPatches = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-AE36-45D837FE5409}']
    Function  GetTotalPatches() : Integer;
    Function  GetProgress() : IRgbProgress;
    Procedure SetProgress(AProgress : IRgbProgress);

    Procedure LoadPatches(AXml : IXmlDocumentEx; AMasterFile : ITSTOXMLMasterFile);
    Procedure ApplyPatches(AXml : IXmlDocumentEx);

    Property TotalPatches : Integer      Read GetTotalPatches;
    Property Progress     : IRgbProgress Read GetProgress Write SetProgress;

  End;

  ITSTOModder = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-B63A-517DA8B60311}']
    Function  GetProject() : ITSTOXMLProject;
    Procedure SetProject(AProject : ITSTOXMLProject);

    Procedure CreateMod(AProject : ITSTOXMLProject; AHackSettings : ITSTOHackSettings);
    Procedure PreviewCustomPatches(AXml : IXmlDocumentEx; APatches : ITSTOPatchDatasIO);

    Property Project : ITSTOXMLProject Read GetProject Write SetProject;

  End;

  ITSTOXmlStoreCategories = Interface(IInterfaceList)
    ['{252D50B9-5196-4811-AB9F-DA8F3AC215AF}']
    Function  Get(Index : Integer) : ITSTOXmlStoreCategory;
    Procedure Put(Index : Integer; Const Item : ITSTOXmlStoreCategory);

    Function IndexOf(Const AStoreName : String) : Integer;
    Function Add() : ITSTOXmlStoreCategory;
    Procedure Sort();

    Property Items[Index: Integer] : ITSTOXmlStoreCategory Read Get Write Put; Default;

  End;

  TTSTOXmlPatch = Class(TInterfacedObjectEx, ITSTOXmlPatch)
  Private
    FPatchType : TPatchType;
    FPatch     : IXmlNodeListEx;

  Protected
    Function  GetPatchType() : TPatchType; Virtual;
    Procedure SetPatchType(Const APatchType : TPatchType); Virtual;

    Function  GetPatches() : IXmlNodeListEx; Virtual;
    Procedure SetPatches(Const APatch : IXmlNodeListEx); Virtual;

    Property PatchType : TPatchType     Read GetPatchType Write SetPatchType;
    Property Patches   : IXmlNodeListEx Read GetPatches   Write SetPatches;

  Public
    Destructor Destroy(); OverRide;

  End;

  TTSTOXmlPatchesEnumerator = Class(TInterfaceExEnumerator, ITSTOXmlPatchesEnumerator)
  Protected
    Function GetCurrent() : ITSTOXmlPatch; OverLoad;

  End;

  TTSTOXmlPatches = Class(TInterfaceListEx, ITSTOXmlPatches)
  Private
    FOwner    : ITSTOModder;
    FProgress : IRgbProgress;

  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;

    Function  Get(Index : Integer) : ITSTOXmlPatch; OverLoad;
    Procedure Put(Index : Integer; Const Item : ITSTOXmlPatch); OverLoad;
    Function  GetEnumerator() : ITSTOXmlPatchesEnumerator;

    Function Add() : ITSTOXmlPatch; ReIntroduce;

    Function  GetTotalPatches() : Integer;
    Function  GetProgress() : IRgbProgress;
    Procedure SetProgress(AProgress : IRgbProgress);

    Procedure LoadPatches(AXml : IXmlDocumentEx; AMasterFile : ITSTOXMLMasterFile);
    Procedure ApplyPatches(AXml : IXmlDocumentEx);

    Property Items[Index : Integer] : ITSTOXmlPatch Read Get Write Put; Default;
    Property Enumerator : ITSTOXmlPatchesEnumerator Read GetEnumerator;

  Public
    Constructor Create(AOwner : ITSTOModder); ReIntroduce;

  End;

  TTSTOModder = Class(TInterfacedObjectEx, ITSTOModder)
  Private
    FProgress : IRgbProgress;
    FProject  : ITSTOXMLProject;

    Procedure BuildCustomStore(AXml : IXmlDocumentEx; AMasterFile : ITSTOXMLMasterFile; AStoreList : ITSTOXmlStoreCategories);
    Procedure BuildCustomStoreEx(AProject : ITSTOXMLProject; ATextPools : ISbtpFileIO);
    Procedure FreeLandUpgrades(AProject : ITSTOXMLProject);
    Function  GetSbtpPatch(Const AIndex : Integer; APatches : ISbtpFilesIO) : ISbtpFileIO;

    Function GetCodeNode(Const ACode : WideString) : IXmlNodeEx;

    Procedure ReplaceAttributes(APatch : WideString; ATarget : IXmlNodeEx);
    Procedure RemoveAttributes(APatch : WideString; ATarget : IXmlNodeEx);
    Procedure AddNode(APatch : WideString; ATarget : IXmlNodeEx);
    Procedure ApplyCustomPatches(AProject : ITSTOXMLProject; AHackSettings : ITSTOHackSettings; AXmlList : IXmlDocumentExList);

  Protected
    Procedure PreviewCustomPatches(AXml : IXmlDocumentEx; APatches : ITSTOPatchDatasIO);

    Function  GetProject() : ITSTOXMLProject;
    Procedure SetProject(AProject : ITSTOXMLProject);

    Procedure CreateMod(AProject : ITSTOXMLProject; AHackSettings : ITSTOHackSettings);

  End;

implementation

Uses SysUtils, XmlDom, HsStreamEx, HsZipUtils, TSTOSbtpTypes;

Type
  TTSTOXmlStoreCategories = Class(TInterfaceList, ITSTOXmlStoreCategories)
  Protected
    Function  Get(Index : Integer) : ITSTOXmlStoreCategory; OverLoad;
    Procedure Put(Index : Integer; Const Item : ITSTOXmlStoreCategory); OverLoad;

    Function IndexOf(Const AStoreName : String) : Integer; OverLoad;
    Function Add() : ITSTOXmlStoreCategory; OverLoad;
    Procedure Sort();

    Property Items[Index: Integer] : ITSTOXmlStoreCategory Read Get Write Put; Default;

  End;

Function TTSTOXmlStoreCategories.Get(Index : Integer) : ITSTOXmlStoreCategory;
Begin
  Result := InHerited Items[Index] As ITSTOXmlStoreCategory;
End;

Procedure TTSTOXmlStoreCategories.Put(Index : Integer; Const Item : ITSTOXmlStoreCategory);
Begin
  InHerited Items[Index] := Item;
End;

Function TTSTOXmlStoreCategories.IndexOf(Const AStoreName : String) : Integer;
Var X : Integer;
Begin
  Result := -1;
  For X := 0 To Count - 1 Do
    If SameText(Items[X].Name, AStoreName) Then
    Begin
      Result := X;
      Break;
    End;
End;

Function TTSTOXmlStoreCategories.Add() : ITSTOXmlStoreCategory;
Begin
  Result := NewStoreCategory();
  InHerited Add(Result);
End;

Procedure TTSTOXmlStoreCategories.Sort();
  Procedure QuickSort(L, R: Integer);
  Var I, J : Integer;
      P    : ITSTOXmlStoreCategory;
  Begin
    Repeat
      I := L;
      J := R;
      P := Items[(L + R) Shr 1];
      Repeat
        While CompareText(Items[I].Name, P.Name) < 0 Do
          Inc(I);
        While CompareText(Items[J].Name, P.Name) > 0 Do
          Dec(J);

        If I <= J Then
        Begin
          Exchange(I, J);
          Inc(I);
          Dec(J);
        End;
      Until I > J;

      If L < J Then
        QuickSort(L, J);

      L := I;
    Until I >= R;
  End;

Begin
  If Count > 0 Then
    QuickSort(0, Count - 1);
End;

(******************************************************************************)

Function TTSTOModder.GetProject() : ITSTOXMLProject;
Begin
  Result := FProject;
End;

Procedure TTSTOModder.SetProject(AProject : ITSTOXMLProject);
Begin
  FProject := AProject;
End;

Function TTSTOModder.GetCodeNode(Const ACode : WideString) : IXmlNodeEx;
Begin
  Result := LoadXMLData('<Code>' + ACode + '</Code>').ChildNodes['Code'];
End;

Procedure TTSTOModder.ReplaceAttributes(APatch : WideString; ATarget : IXmlNodeEx);
Begin
  With GetCodeNode(APatch).ChildNodes.Enumerator Do
    While MoveNext() Do
      With Current.AttributeNodes.Enumerator Do
        While MoveNext() Do
          ATarget.Attributes[Current.NodeName] := Current.Text;
End;

Procedure TTSTOModder.RemoveAttributes(APatch : WideString; ATarget : IXmlNodeEx);
Var lNode : IXmlNodeEx;
Begin
  With GetCodeNode(APatch).ChildNodes.Enumerator Do
    While MoveNext() Do
      With Current.AttributeNodes.Enumerator Do
        While MoveNext() Do
        Begin
          lNode := ATarget.AttributeNodes.FindNode(Current.NodeName);
          If Assigned(lNode) Then
            ATarget.AttributeNodes.Remove(lNode);
        End;
End;

Procedure TTSTOModder.AddNode(APatch : WideString; ATarget : IXmlNodeEx);
Var X : Integer;
    lNewNode : IDOMNode;
Begin
  With GetCodeNode(APatch) Do
    For X := 0 To ChildNodes.Count - 1 Do
    Begin
      lNewNode := ChildNodes[X].DOMNode.cloneNode(True);
      With ATarget.DOMNode Do
        If Assigned(nextSibling) Then
          parentNode.insertBefore(
            lNewNode, nextSibling
          )
        Else
          parentNode.appendChild(lNewNode);
    End;
End;

Procedure TTSTOModder.ApplyCustomPatches(AProject : ITSTOXMLProject; AHackSettings : ITSTOHackSettings; AXmlList : IXmlDocumentExList);
Var X, Y : Integer;
    lNbPatches,
    lPatchIdx : Integer;
    lXml : IXmlDocumentEx;
    lNodeList : IXmlNodeListEx;
    lStrStream : IStringStreamEx;
    lIdx : Integer;
Begin
  lPatchIdx  := 0;
  lNbPatches := AHackSettings.CustomPatches.ActivePatchCount;

  If Assigned(FProgress) Then
    FProgress.CurArchiveName := 'Applying Custom Patches';

  With AHackSettings.CustomPatches Do
  Begin
    For X := 0 To Patches.Count - 1 Do
      With Patches[X] Do
        If PatchActive And
           FileExists(AProject.Settings.SourcePath + FileName) Then
        Begin
          lIdx := AXmlList.IndexOf(FileName);

          If lIdx = -1 Then
          Begin
            lXml := LoadXMLDocument(AProject.Settings.SourcePath + FileName);
            AXmlList.Add(lXml);
          End
          Else
            lXml := AXmlList[lIdx];

          For Y := 0 To PatchData.Count - 1 Do
          Begin
            With PatchData[Y] Do
            Begin
              lNodeList := lXml.SelectNodes(PatchData[Y].PatchPath);
              If Assigned(lNodeList) Then
              Try
                With lNodeList.Enumerator Do
                  While MoveNext() Do
                    Case PatchType Of
                      1 : ReplaceAttributes(PatchData[Y].Code, Current);
                      2 : RemoveAttributes(PatchData[Y].Code, Current);
                      3 : AddNode(PatchData[Y].Code, Current);
                      4 : Current.DOMNode.parentNode.removeChild(Current.DOMNode);
                    End;

                Finally
                  lNodeList := Nil;
              End;
            End;
          End;

          Inc(lPatchIdx);
          If Assigned(FProgress) Then
            FProgress.ArchiveProgress := Round((lPatchIdx + 1) / lNbPatches * 100);
        End;

    For X := 0 To AXmlList.Count - 1 Do
    Begin
      lStrStream := TStringStreamEx.Create(FormatXmlData(AXmlList[X].Xml.Text));
      Try
        lStrStream.SaveToFile(AProject.Settings.TargetPath + ExtractFileName(AXmlList[X].FileName));

        Finally
          lStrStream := Nil;
      End;
    End;
  End;
End;

Procedure TTSTOModder.PreviewCustomPatches(AXml : IXmlDocumentEx; APatches : ITSTOPatchDatasIO);
Var X : Integer;
    lNodes : IXmlNodeListEx;
Begin
  For X := 0 To APatches.Count - 1 Do
  Begin
    lNodes := AXml.SelectNodes(APatches[X].PatchPath);
    With lNodes.Enumerator Do
      While MoveNext() Do
        Case APatches[X].PatchType Of
          1 : ReplaceAttributes(APatches[X].Code, Current);
          2 : RemoveAttributes(APatches[X].Code, Current);
          3 : AddNode(APatches[X].Code, Current);
          4 : Current.DOMNode.parentNode.removeChild(Current.DOMNode);
        End;
  End;
End;

Procedure TTSTOModder.CreateMod(AProject : ITSTOXMLProject; AHackSettings : ITSTOHackSettings);
Var X, Y : Integer;
    lCurFileName     : String;
    lXmlMaster       : IXmlDocumentEx;
    lMasterList      : IXmlNodeListEx;
    lXml             : IXmlDocumentEx;
    lPatchs          : ITSTOXmlPatches;

    lZip : IHsMemoryZipper;
    lMem : IMemoryStreamEx;
    lSbtpPatchFile : ISbtpFilesIO;
    lSbtpPatches   : ISbtpFileIO;

    lXmls : IXmlDocumentExList;
    lIdx  : Integer;
Begin
  FProject := AProject;

  If AProject.Settings.BuildCustomStore Then
  Begin
    lSbtpPatchFile := TSbtpFilesIO.CreateSbtpFiles();
    If FileExists(AProject.Settings.HackFileName) Then
    Begin
      lZip := THsMemoryZipper.Create();
      lMem := TMemoryStreamEx.Create();
      Try
        lZip.LoadFromFile(AProject.Settings.HackFileName);
        If lZip.FindFile('TextPools') > -1 Then
        Begin
          lZip.ExtractToStream('TextPools', lMem);
          If lMem.Size > 0 Then
            lSbtpPatchFile.LoadFromStream(lMem);
        End;

        Finally
          lMem := Nil;
          lZip := Nil;
      End;
    End;
  End;

  FProgress := TRgbProgress.CreateRgbProgress();
  FProgress.Show();
  Try
    With AProject.Settings Do
    Begin
      lXmls := TXmlDocumentExList.Create();

//      If FileExists(CustomPatchFileName) Then
      Begin
//        lMasterList := LoadXmlDocument(CustomPatchFileName).SelectNodes('//Patch[@Active="true"]/FileName/text()');
        lMasterList := LoadXmlData(AHackSettings.CustomPatches.AsXml).SelectNodes('//Patch[@Active="true"]/FileName/text()');
        If Assigned(lMasterList) Then
        Try
          For X := 0 To lMasterList.Count - 1 Do
            If FileExists(SourcePath + lMasterList[X].Text) Then
            Begin
              If lXmls.IndexOf(lMasterList[X].Text) = -1 Then
              Begin
                lXml := LoadXmlDocument(SourcePath + lMasterList[X].Text);
                lXmls.Add(lXml);
              End;
            End;

          Finally
            lMasterList := Nil;
        End;
      End;

(*
      If FileExists(CustomPatchFileName) Then
      Begin
        lMasterList := LoadXmlDocument(CustomPatchFileName).SelectNodes('//Patch[@Active="true"]/FileName/text()');
        Try
          For X := 0 To lMasterList.Count - 1 Do
            If FileExists(SourcePath + lMasterList[X].Text) Then
            Begin
              If lXmls.IndexOf(lMasterList[X].Text) = -1 Then
              Begin
                lXml := LoadXmlDocument(SourcePath + lMasterList[X].Text);
                lXmls.Add(lXml);
              End;
            End;

          Finally
            lMasterList := Nil;
        End;
      End;
*)
      For X := 0 To MasterFiles.Count - 1 Do
        If FileExists(SourcePath + MasterFiles[X].FileName) Then
        Begin
          lXmlMaster := LoadXMLDocument(SourcePath + MasterFiles[X].FileName);
          Try
            lMasterList := lXmlMaster.SelectNodes('Package');
            If Assigned(lMasterList) Then
            Try
              For Y := 0 To lMasterList.Count - 1 Do
              Begin
                lCurFileName := lMasterList[Y].Attributes['name'] + '.xml';

                If FileExists(SourcePath + lCurFileName) Then
                Begin
                  lIdx := lXmls.IndexOf(lCurFileName);
                  If lIdx = -1 Then
                    lXml := LoadXMLDocument(SourcePath + lCurFileName)
                  Else
                    lXml := lXmls[lIdx];

                  Try
                    lPatchs := TTSTOXmlPatches.Create(Self);
                    Try
                      lPatchs.Progress := FProgress;
                      lPatchs.LoadPatches(lXml, MasterFiles[X]);

                      If lPatchs.TotalPatches > 0 Then
                      Begin
                        lPatchs.ApplyPatches(lXml);
                        lXml.SaveToFile(TargetPath + lCurFileName);
                      End;

                      FProgress.ItemProgress := System.Round((Y + 1) / lMasterList.Count * 100);

//                      If AProject.Settings.BuildCustomStore Then
//                        Self.BuildCustomStore(lXml, MasterFiles[X], lStoreList);

                      Finally
                        lPatchs := Nil;
                    End;

                    Finally
                      lXml := Nil;
                  End;
                End;
              End;

              Finally
                lMasterList := Nil;
            End;

            Finally
              lXmlMaster := Nil;
          End;
        End;

      If AProject.Settings.BuildCustomStore Then
      Begin
        lSbtpPatches := GetSbtpPatch(14, lSbtpPatchFile);
        BuildCustomStoreEx(FProject, lSbtpPatches);

        lZip := THsMemoryZipper.Create();
        lMem := TMemoryStreamEx.Create();
        Try
          lZip.ShowProgress := False;
          If FileExists(AProject.Settings.HackFileName) Then
            lZip.LoadFromFile(AProject.Settings.HackFileName);
          lSbtpPatchFile.SaveToStream(lMem);
          lMem.Position := 0;
          lZip.AddFromStream('TextPools', lMem);
          lZip.SaveToFile(AProject.Settings.HackFileName);

          Finally
            lZip := Nil;
            lMem := Nil;
        End;
      End;

      If AProject.Settings.FreeLand Then
        FreeLandUpgrades(AProject);

      If AHackSettings.CustomPatches.ActivePatchCount > 0 Then
        ApplyCustomPatches(AProject, AHackSettings, lXmls);
    End;

    Finally
      FProgress := Nil;
      lXmls := Nil;
  End;
End;

(******************************************************************************)

Destructor TTSTOXmlPatch.Destroy();
Begin
  FPatch := Nil;

  InHerited Destroy();
End;

Function TTSTOXmlPatch.GetPatchType() : TPatchType;
Begin
  Result := FPatchType;
End;

Procedure TTSTOXmlPatch.SetPatchType(Const APatchType : TPatchType);
Begin
  FPatchType := APatchType;
End;

Function TTSTOXmlPatch.GetPatches() : IXmlNodeListEx;
Begin
  Result := FPatch;
End;

Procedure TTSTOXmlPatch.SetPatches(Const APatch : IXmlNodeListEx);
Begin
  FPatch := APatch;
End;

Function TTSTOXmlPatchesEnumerator.GetCurrent() : ITSTOXmlPatch;
Begin
  Result := InHerited Current As ITSTOXmlPatch;
End;

Constructor TTSTOXmlPatches.Create(AOwner : ITSTOModder);
Begin
  InHerited Create(True);

  FOwner := AOwner;
End;

Function TTSTOXmlPatches.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TTSTOXmlPatch;
End;

Function TTSTOXmlPatches.Get(Index : Integer) : ITSTOXmlPatch;
Begin
  Result := InHerited Items[Index] As ITSTOXmlPatch;
End;

Procedure TTSTOXmlPatches.Put(Index : Integer; Const Item : ITSTOXmlPatch);
Begin
  InHerited Items[Index] := Item;
End;

Function TTSTOXmlPatches.GetEnumerator() : ITSTOXmlPatchesEnumerator;
Begin
  Result := TTSTOXmlPatchesEnumerator.Create(Self);
End;

Function TTSTOXmlPatches.Add() : ITSTOXmlPatch;
Begin
  Result := InHerited Add() As ITSTOXmlPatch;
End;

Function TTSTOXmlPatches.GetTotalPatches() : Integer;
Var X : Integer;
Begin
  Result := 0;

  For X := 0 To Count - 1 Do
    Inc(Result, Items[X].Patches.Count);
End;

Function TTSTOXmlPatches.GetProgress() : IRgbProgress;
Begin
  Result := FProgress;
End;

Procedure TTSTOXmlPatches.SetProgress(AProgress : IRgbProgress);
Begin
  FProgress := AProgress;
End;

Procedure TTSTOXmlPatches.LoadPatches(AXml : IXmlDocumentEx; AMasterFile : ITSTOXMLMasterFile);
Begin
  If FOwner.Project.Settings.AllFreeItems Then
  Begin
    With Add() Do
    Begin
      PatchType := tptCost;
      Patches   := AXml.SelectNodes(AMasterFile.NodeName + '//Cost');
    End;

    With Add() Do
    Begin
      PatchType := tptDynamicBuyInfo;
      Patches   := AXml.SelectNodes(AMasterFile.NodeName + '//DynamicBuyInfo');
    End;

    With Add() Do
    Begin
      PatchType := tptDynamicSellInfo;
      Patches   := AXml.SelectNodes(AMasterFile.NodeName + '//DynamicSellInfo');
    End;
  End;

  If FOwner.Project.Settings.NonUnique Then
  Begin
    With Add() Do
    Begin
      PatchType := tptNonUnique;
      Patches   := AXml.SelectNodes(AMasterFile.NodeName + '//Unique');
    End;
  End;

  If FOwner.Project.Settings.InstantBuild Then
  Begin
    With Add() Do
    Begin
      PatchType := tptInstantBuild;
      Patches   := AXml.SelectNodes(AMasterFile.NodeName + '//BuildTime');
    End;
  End;

  If FOwner.Project.Settings.UnlimitedTime Then
    With Add() Do
    Begin
      PatchType := tptUnlimitedTime;
      Patches   := AXml.SelectNodes('//Requirement[@type="time" and @end]');
    End;
End;

Procedure TTSTOXmlPatches.ApplyPatches(AXml : IXmlDocumentEx);
Var X : Integer;
    lCurProgress ,
    lTotProgress : Integer;
Begin
  lCurProgress := 0;
  lTotProgress := 0;

  If Assigned(FProgress) Then
  Begin
    With Enumerator Do
      While MoveNext() Do
        With Current Do
          If PatchType In [tptCost, tptDynamicBuyInfo, tptDynamicSellInfo] Then
            Inc(lTotProgress, Patches.Count);
    FProgress.CurOperation := 'Processing : ' + ExtractFileName(AXml.FileName);
  End;

  With Enumerator Do
    While MoveNext() Do
      With Current Do
      Begin
        Case PatchType Of
          tptCost :
          Begin
            If Assigned(FProgress) Then
              FProgress.CurArchiveName := 'Making All Free';

            For X := 0 To Patches.Count - 1 Do
            Begin
              Patches[X].AttributeNodes.Clear();
              Patches[X].Attributes['money'] := 0;

              If Assigned(FProgress) Then
              Begin
                Inc(lCurProgress);
                FProgress.ArchiveProgress := Round(lCurProgress / lTotProgress * 100);
              End;
            End;
          End;

          tptDynamicBuyInfo :
          Begin
            If Assigned(FProgress) Then
              FProgress.CurArchiveName := 'Making All Free';

            For X := 0 To Patches.Count - 1 Do
            Begin
              Patches[X].DOMNode.parentNode.removeChild(Patches[X].DOMNode);

              If Assigned(FProgress) Then
              Begin
                Inc(lCurProgress);
                FProgress.ArchiveProgress := Round(lCurProgress / lTotProgress * 100);
              End;
            End;
          End;

          tptDynamicSellInfo :
          Begin
            If Assigned(FProgress) Then
              FProgress.CurArchiveName := 'Making All Free';

            For X := 0 To Patches.Count - 1 Do
            Begin
              Patches[X].DOMNode.parentNode.removeChild(Patches[X].DOMNode);

              If Assigned(FProgress) Then
              Begin
                Inc(lCurProgress);
                FProgress.ArchiveProgress := Round(lCurProgress / lTotProgress * 100);
              End;
            End;
          End;

          tptNonUnique :
          Begin
            If Assigned(FProgress) Then
              FProgress.CurArchiveName := 'Making Non Unique';

            For X := 0 To Patches.Count - 1 Do
            Begin
              Patches[X].DOMNode.parentNode.removeChild(Patches[X].DOMNode);
              
              If Assigned(FProgress) Then
                FProgress.ArchiveProgress := Round((X + 1) / Patches.Count * 100);
            End;
          End;

          tptInstantBuild :
          Begin
            If Assigned(FProgress) Then
              FProgress.CurArchiveName := 'Making Instant Build';

            For X := 0 To Patches.Count - 1 Do
            Begin
              Patches[X].Attributes['time'] := 0;

              If Assigned(FProgress) Then
                FProgress.ArchiveProgress := Round((X + 1) / Patches.Count * 100);
            End;
          End;

          tptUnlimitedTime :
          Begin
            If Assigned(FProgress) Then
              FProgress.CurArchiveName := 'Removing Limited Time';

            For X := 0 To Patches.Count - 1 Do
            Begin
              Patches[X].DOMNode.parentNode.removeChild(Patches[X].DOMNode);

              If Assigned(FProgress) Then
                FProgress.ArchiveProgress := Round((X + 1) / Patches.Count * 100);
            End;
          End;
        End;
      End;
End;

(******************************************************************************)

Type
  ICustomStoreItem = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-9FBC-A577B96003FB}']
    Function  GetItemType() : String;
    Procedure SetItemType(Const AItemType : String);

    Function  GetItemId() : String;
    Procedure SetItemId(Const AItemId : String);

    Function  GetItemName() : String;
    Procedure SetItemName(Const AItemName : String);

    Property ItemType : String Read GetItemType Write SetItemType;
    Property ItemId   : String Read GetItemId   Write SetItemId;
    Property ItemName : String Read GetItemName Write SetItemName;

  End;

  ICustomStore = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-890B-A1F7BC68AA1A}']
    Function  GetStoreName() : String;
    Procedure SetStoreName(Const AStoreName : String);

    Property StoreName : String Read GetStoreName Write SetStoreName;

    Function  Get(Index : Integer) : ICustomStoreItem;
    Procedure Put(Index : Integer; Const Item : ICustomStoreItem);

    Function Add() : ICustomStoreItem; OverLoad;
    Function Add(Const AItem : ICustomStoreItem) : Integer; OverLoad;

    Property Items[Index : Integer] : ICustomStoreItem Read Get Write Put; Default;

  End;

  ICustomStores = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-93A8-001B2990942F}']
    Function  Get(Index : Integer) : ICustomStore;
    Procedure Put(Index : Integer; Const Item : ICustomStore);

    Function  Add() : ICustomStore; OverLoad;
    Function  Add(Const AItem : ICustomStore) : Integer; OverLoad;
    Function  IndexOf(Const AStoreName : String): Integer;
    Procedure Sort();

    Property Items[Index : Integer] : ICustomStore Read Get Write Put; Default;

  End;

  TCustomStoreItem = Class(TInterfacedObjectEx, ICustomStoreItem)
  Private
    FItemType : String;
    FItemId   : String;
    FItemName : String;

  Protected
    Function  GetItemType() : String; 
    Procedure SetItemType(Const AItemType : String); 

    Function  GetItemId() : String; 
    Procedure SetItemId(Const AItemId : String); 

    Function  GetItemName() : String; 
    Procedure SetItemName(Const AItemName : String); 

    Procedure Clear();

  End;

  TCustomStore = Class(TInterfaceListEx, ICustomStore)
  Private
    FStoreName : String;
    
  Protected
    Function  GetItemClass() : TInterfacedObjectExClass; OverRide;

    Function  GetStoreName() : String;
    Procedure SetStoreName(Const AStoreName : String);

    Function  Get(Index : Integer) : ICustomStoreItem; OverLoad;
    Procedure Put(Index : Integer; Const Item : ICustomStoreItem); OverLoad;

    Function Add() : ICustomStoreItem; ReIntroduce; OverLoad;
    Function Add(Const AItem : ICustomStoreItem) : Integer; ReIntroduce; OverLoad;

  End;

  TCustomStores = Class(TInterfaceListEx, ICustomStores)
  Private
    Function InternalSort(Item1, Item2 : IInterfaceEx) : Integer;

  Protected
    Function  GetItemClass() : TInterfacedObjectExClass; OverRide;

    Function  Get(Index : Integer) : ICustomStore; OverLoad;
    Procedure Put(Index : Integer; Const Item : ICustomStore); OverLoad;

    Function  Add() : ICustomStore; ReIntroduce; OverLoad;
    Function  Add(Const AItem : ICustomStore) : Integer; OverLoad;
    Function  IndexOf(Const AStoreName : String) : Integer; ReIntroduce; OverLoad;
    Procedure Sort();

  End;

Procedure TCustomStoreItem.Clear();
Begin
  FItemType := '';
  FItemId   := '';
  FItemName := '';
End;

Function TCustomStoreItem.GetItemType() : String;
Begin
  Result := FItemType;
End;

Procedure TCustomStoreItem.SetItemType(Const AItemType : String);
Begin
  FItemType := AItemType;
End;

Function TCustomStoreItem.GetItemId() : String;
Begin
  Result := FItemId;
End;

Procedure TCustomStoreItem.SetItemId(Const AItemId : String);
Begin
  FItemId := AItemId;
End;

Function TCustomStoreItem.GetItemName() : String;
Begin
  Result := FItemName;
End;

Procedure TCustomStoreItem.SetItemName(Const AItemName : String);
Begin
  FItemName := AItemName;
End;

Function TCustomStore.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TCustomStoreItem;
End;

Function TCustomStore.GetStoreName() : String;
Begin
  Result := FStoreName;
End;

Procedure TCustomStore.SetStoreName(Const AStoreName : String);
Begin
  FStoreName := AStoreName;
End;

Function TCustomStore.Get(Index : Integer) : ICustomStoreItem;
Begin
  Result := InHerited Items[Index] As ICustomStoreItem;
End;

Procedure TCustomStore.Put(Index : Integer; Const Item : ICustomStoreItem);
Begin
  InHerited Items[Index] := Item;
End;

Function TCustomStore.Add() : ICustomStoreItem;
Begin
  Result := InHerited Add() As ICustomStoreItem;
End;

Function TCustomStore.Add(Const AItem : ICustomStoreItem) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Function TCustomStores.GetItemClass() : TInterfacedObjectExClass;
Begin
  Result := TCustomStore;
End;

Function TCustomStores.Get(Index : Integer) : ICustomStore;
Begin
  Result := InHerited Items[Index] As ICustomStore;
End;

Procedure TCustomStores.Put(Index : Integer; Const Item : ICustomStore);
Begin
  InHerited Items[Index] := Item;
End;

Function TCustomStores.Add() : ICustomStore;
Begin
  Result := InHerited Add() As ICustomStore;
End;

Function TCustomStores.Add(Const AItem : ICustomStore) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

Function TCustomStores.IndexOf(Const AStoreName : String) : Integer;
Var X : Integer;
Begin
  Result := -1;

  For X := 0 To Count - 1 Do
    If SameText(Get(X).StoreName, AStoreName) Then
    Begin
      Result := X;
      Break;
    End;
End;

Function TCustomStores.InternalSort(Item1, Item2 : IInterfaceEx) : Integer;
Var lItem1, lItem2 : ICustomStore;
Begin
  If Supports(Item1, ICustomStore, lItem1) And Supports(Item2, ICustomStore, lItem2) Then
    Result := CompareText(lItem1.StoreName, lItem2.StoreName)
  Else
    Result := 0;
End;

Procedure TCustomStores.Sort();
Begin
  InHerited Sort(InternalSort);
End;

Procedure TTSTOModder.BuildCustomStoreEx(AProject : ITSTOXMLProject; ATextPools : ISbtpFileIO);
  Function GetPackageName(Const APackage : String) : String;
  Var lIdx : Integer;
  Begin
    Result := ChangeFileExt(ExtractFileName(APackage), '');
    lIdx := Pos('_', Result);
    If lIdx > 0 Then
      Result := Copy(Result, 1, lIdx-1);
  End;

Var X, Y, Z    : Integer;
    lStores    : ICustomStores;
    lCurStore  : ICustomStore;
    lNodes     : IXmlNodeListEx;
    lInclNodes : IXmlNodeListEx;
    lIncl      : String;
    lStrs      : TStringList;
    lMaster    : IXmlDocumentEx;
    lPkgName   : String;
    lTrgStore  : IXmlDocumentEx;
    lTrgStores : IXmlDocumentEx;
    lIdx       : Integer;
    lPath      : String;
Begin
  lPath   := AProject.Settings.SourcePath;
  lStores := TCustomStores.Create();
  Try
    If Assigned(FProgress) Then
      FProgress.CurArchiveName := 'Making Custom Store';

    For Z := 0 To AProject.Settings.MasterFiles.Count - 1 Do
    Begin
      lMaster := LoadXMLDocument(lPath + AProject.Settings.MasterFiles[Z].FileName);
      lInclNodes := lMaster.SelectNodes('//Include');

      //Build full master list
      Try
        For X := 0 To lInclNodes.Count - 1 Do
        Begin
          lStrs := TStringList.Create();
          Try
            lIncl := lInclNodes[X].Attributes['path'];
            Classes.ExtractStrings([':'], [], PChar(lIncl), lStrs);

            If (lStrs.Count > 0) And FileExists(lPath + lStrs[0]) Then
            Begin
              lIncl := '';
              For Y := 1 To lStrs.Count - 1 Do
                lIncl := lIncl + '/' + lStrs[Y];
              lIncl := '/' + lIncl + '//DataID';

              lNodes := LoadXmlDocument(lPath + lStrs[0]).SelectNodes(lIncl);
              For Y := 0 To lNodes.Count - 1 Do
                lInclNodes[X].DOMNode.parentNode.appendChild(lNodes[Y].DOMNode.cloneNode(True));
              lInclNodes[X].DOMNode.parentNode.removeChild(lInclNodes[X].DOMNode);
            End;

            Finally
              lStrs.Free();
          End;
        End;

        Finally
          lInclNodes := Nil;
      End;

      //Remove Deprecated Items
      lNodes := lMaster.SelectNodes('//*[@onDeprecated="delete" and (@status="deprecated" or @enabled or @endDate)]');
      For X := 0 To lNodes.Count - 1 Do
        lNodes[X].DOMNode.parentNode.removeChild(lNodes[X].DOMNode);

      lNodes := lMaster.SelectNodes('IDMasterList//Package');
      Try
        For X := 0 To lNodes.Count - 1 Do
        Begin
          lPkgName := 'Store' + GetPackageName(lNodes[X].Attributes['name']);
          lIdx := lStores.IndexOf(lPkgName);
          If lIdx = -1 Then
          Begin
            lCurStore := lStores.Add();
            lCurStore.StoreName := lPkgName;
          End
          Else
            lCurStore := lStores[lIdx];

          For Y := 0 To lNodes[X].ChildNodes.Count - 1 Do
          Begin
            If SameText(lNodes[X].ChildNodes[Y].NodeName, 'DataID') Then
            Begin
              With lCurStore.Add() Do
              Begin
                ItemType := AProject.Settings.MasterFiles[Z].NodeKind;//NodeName;
                ItemId   := lNodes[X].ChildNodes[Y].Attributes['id'];
                ItemName := lNodes[X].ChildNodes[Y].Attributes['name'];
              End
            End;

            If Assigned(FProgress) Then
              FProgress.ArchiveProgress := Round((Y + 1) / lNodes[X].ChildNodes.Count * 100);
          End;
        End;

        Finally
          lNodes := Nil;
      End;
    End;

    lStores.Sort();

    lTrgStore  := NewXmlDocument('');
    lTrgStores := NewXmlDocument('');
    Try
      lTrgStore.AddChild('Stores');
      lTrgStores.AddChild('StoreMenus').AddChild('Categories');

      For X := 0 To lStores.Count - 1 Do
      Begin
        lPkgName := StringReplace(lStores[X].StoreName, 'Store', '', [rfReplaceAll, rfIgnoreCase]);

        If ATextPools.Item[0].SubItem.IndexOf(lPkgName) = -1 Then
          With ATextPools.Item[0].SubItem.Add() Do
          Begin
            VariableName := LowerCase(lPkgName);
            VariableData := lPkgName;
          End;

        With lTrgStores.ChildNodes[0].ChildNodes[0].AddChild('Category') Do
        Begin
          Attributes['name']         := lPkgName;
          Attributes['title']        := 'UI_' + lPkgName;
          Attributes['icon']         := lPkgName + 'Store';
          Attributes['disabledIcon'] := lPkgName + 'Store';
          Attributes['emptyText']    := 'UI_StoreEmpty';
          Attributes['sortList']     := 'false';

          With AddChild('Include') Do
            Attributes['path'] := 'NewStores.xml:Stores:' + lStores[X].StoreName;
        End;

        With lTrgStore.ChildNodes[0].AddChild(lStores[X].StoreName) Do
          For Y := 0 To lStores[X].Count - 1 Do
            With AddChild('Object') Do
            Begin
              Attributes['type'] := lStores[X][Y].ItemType;
              Attributes['id']   := lStores[X][Y].ItemId;
              Attributes['name'] := lStores[X][Y].ItemName;
            End;
      End;

      With TStringList.Create() Do
      Try
        Text := FormatXmlData(lTrgStore.Xml.Text);
        SaveToFile(AProject.Settings.TargetPath + 'newstores.xml');

        Text := FormatXmlData(lTrgStores.Xml.Text);
        SaveToFile(AProject.Settings.TargetPath + 'newstoremenu.xml');

        Finally
          Free();
      End;

      Finally
        lTrgStores := Nil;
        lTrgStore  := Nil;
    End;

    Finally
      lStores := Nil;
  End;
End;

(******************************************************************************)

Procedure TTSTOModder.BuildCustomStore(AXml : IXmlDocumentEx; AMasterFile : ITSTOXMLMasterFile; AStoreList : ITSTOXmlStoreCategories);
Type
  TPackageType = ( ptUnknown, ptConsumable, ptBuilding,
    ptDecoration, ptCharacter, ptCharacterSkin
  );
Const
  TItemType : Array[TPackageType] Of String = (
    '', 'consumable', 'building', 'building', 'character', ''
  );

  Function GetPackageType() : TPackageType;
  Begin
    If Pos('consumable', LowerCase(AXml.FileName)) > 0 Then
      Result := ptConsumable
    Else If Pos('building', LowerCase(AXml.FileName)) > 0 Then
      Result := ptBuilding
    Else If Pos('decoration', LowerCase(AXml.FileName)) > 0 Then
      Result := ptDecoration
    Else If Pos('characterskin', LowerCase(AXml.FileName)) > 0 Then
      Result := ptCharacterSkin
    Else If Pos('character', LowerCase(AXml.FileName)) > 0 Then
      Result := ptCharacter
    Else
      Result := ptUnknown;
  End;

  Function GetPackageName(Const APackage : String) : String;
  Var lIdx : Integer;
  Begin
    Result := ChangeFileExt(ExtractFileName(APackage), '');
    lIdx := Pos('_', Result);
    If lIdx > 0 Then
      Result := Copy(Result, 1, lIdx-1);
  End;

Var lStore : ITSTOXmlStoreCategory;
    lCurStore : String;
    lIdx : Integer;
    lNodeList : IXmlNodeListEx;
    lItemType : String;
    X         : Integer;
Begin
  lNodeList := AXml.SelectNodes(AMasterFile.NodeName);
  If Assigned(lNodeList) And (lNodeList.Count > 0) Then
  Try
    lCurStore := LowerCase('storemenu_' + GetPackageName(AXml.FileName) + '.xml');
    lIdx := AStoreList.IndexOf(GetPackageName(AXml.FileName));
    If lIdx = -1 Then
    Begin
      lStore := AStoreList.Add();
      lStore.Name := GetPackageName(AXml.FileName);
    End
    Else
      lStore := AStoreList[lIdx];

    lItemType := TItemType[GetPackageType()];
    If lItemType <> '' Then
    Begin
      If Assigned(FProgress) Then
        FProgress.CurArchiveName := 'Making Custom Store';

      For X := 0 To lNodeList.Count - 1 Do
        With lStore.Objects.Add() Do
        Begin
          ObjectType := lItemType;
          Id         := lNodeList[X].Attributes['id'];
          Name       := lNodeList[X].Attributes['name'];

          If Assigned(FProgress) Then
            FProgress.ArchiveProgress := Round((X + 1) / lNodeList.Count * 100);
        End;
    End;

    Finally
      lNodeList := Nil;
  End;
End;

Procedure TTSTOModder.FreeLandUpgrades(AProject : ITSTOXMLProject);
Var lXml   : IXmlDocumentEx;
    lNodes : IXmlNodeListEx;
    X, Y   : Integer;
    lLst   : TStringList;
    lStr   : String;
Begin
  lXml := TXmlDocumentEx.Create(AProject.Settings.SourcePath + 'LandInfo.xml');
  Try
    lNodes := lXml.SelectNodes('//LandCost');
    If Assigned(lNodes) And (lNodes.Count > 0) Then
    Try
      lLst := TStringList.Create();
      Try
        For X := 0 To lNodes.Count - 1 Do
        Begin
          lLst.Clear();
          lStr := lNodes[X].Attributes['value'];
          ExtractStrings([','], [], PChar(lStr), lLst);
          lStr := '';

          For Y := 0 To lLst.Count - 1 Do
          Begin
            If (Pos('*', lLst[Y]) > 0) Or (StrToIntDef(lLst[Y], 0) > 0) Then
              lStr := lStr + '1, '
            Else
              lStr := lStr + '0, ';
          End;
          lNodes[X].Attributes['value'] := lStr;
        End;

        lXml.SaveToFile(AProject.Settings.TargetPath + 'LandInfo.xml');

        Finally
          lLst.Free();
      End;

      Finally
        lNodes := Nil;
    End;

    Finally
      lXml := Nil;
  End;
End;

Function TTSTOModder.GetSbtpPatch(Const AIndex : Integer; APatches : ISbtpFilesIO) : ISbtpFileIO;
Var X : Integer;
Begin
  Result := Nil;

  For X := 0 To APatches.Count - 1 Do
    If APatches[X].Header.HeaderPadding = AIndex Then
    Begin
      Result := APatches[X];
      Break;
    End;

  If Not Assigned(Result) Then
  Begin
    Result := APatches.Add();
    Result.Header.HeaderPadding := AIndex;
    Result.Item.Add().VariableType := SbtpVariablePrefix[AIndex];
  End;
End;

end.
