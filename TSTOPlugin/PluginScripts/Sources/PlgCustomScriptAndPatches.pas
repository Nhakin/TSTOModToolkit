unit PlgCustomScriptAndPatches;

interface

uses
  PlgTSTOCustomPlugin, TSTOPluginIntf, TSTOScriptTemplate.IO,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TTSTOCustomScriptPlugin = class(TTSTOCustomPlugin)
  Private
    FScriptTemplates : ITSTOScriptTemplateHacksIO;

    Function  GetFreeLandUpgradeScript(Sender : TObject) : String;
    Procedure PreviewFreeLandUpgrade(Sender : TObject);
    Procedure ExecuteFreeLandUpgrade(Sender : TObject);

  Protected
    Function  GetPluginKind() : TTSTOPluginKind; OverRide;
    Function  GetHaveSettings() : Boolean; OverRide;

    Function  GetName() : String; OverRide;
    Function  GetDescription() : String; OverRide;
    Function  GetPluginId() : String; OverRide;
    Function  GetPluginVersion() : String; OverRide;

    Procedure Initialize(AMainApplication : ITSTOApplication); OverRide;
    Procedure Finalize(); OverRide;
    Function  ShowSettings() : Boolean; OverRide;
    Function  Execute() : Integer; OverRide;

  Public

  end;

Function CreateTSTOPlugin() : ITSTOPlugin;

implementation

Uses
  SciScintillaNPP, HsInterfaceEx, HsStreamEx, HsStringListEx, HsXmlDocEx;

{$R *.dfm}

Function CreateTSTOPlugin() : ITSTOPlugin;
Begin
  Result := TTSTOCustomScriptPlugin.Create(Nil);
End;

Function TTSTOCustomScriptPlugin.GetPluginKind() : TTSTOPluginKind;
Begin
  Result := pkScript;
End;

Function TTSTOCustomScriptPlugin.GetHaveSettings() : Boolean;
Begin
  Result := True;
End;

Function TTSTOCustomScriptPlugin.GetName() : String;
Begin
  Result := 'TSTOCustomScriptPlugin';
End;

Function TTSTOCustomScriptPlugin.GetDescription() : String;
Begin
  Result := 'Add more ScriptTemplate functions';
End;

Function TTSTOCustomScriptPlugin.GetPluginId() : String;
Begin
  Result := 'TSTOModToolKit.PlgTSTOCustomScriptPlugin';
End;

Function TTSTOCustomScriptPlugin.GetPluginVersion() : String;
Begin
  Result := '1.0.0.2';
End;

Procedure TTSTOCustomScriptPlugin.Initialize(AMainApplication : ITSTOApplication);
Var lStrStrm : IStringStreamEx;
Begin
  InHerited Initialize(AMainApplication);

  If Initialized Then
  Begin
    FScriptTemplates := MainApp.CreateScriptTemplates();

    If Assigned(FScriptTemplates) Then
    Begin
      With FScriptTemplates.Add() Do
      Begin
        Name := 'Free Land Upgrade';
        With Variables.Add() Do
        Begin
          Name := '%FreeLandUpgrade%';
          VarFunc := 'hmCustom';

          OnExecute := ExecuteFreeLandUpgrade;
          OnPreview := PreviewFreeLandUpgrade;
        End;

        If Assigned(MainApp.CurrentProject) Then
          If FileExists(MainApp.CurrentProject.SrcPath + 'LandInfo.xml') Then
          Begin
            lStrStrm := TStringStreamEx.Create();
            Try
              lStrStrm.LoadFromFile(MainApp.CurrentProject.SrcPath + 'LandInfo.xml');
              TemplateFile := lStrStrm.DataString;

              Finally
                lStrStrm := Nil;
            End;
          End;
      End;
    End;
  End;
End;

Procedure TTSTOCustomScriptPlugin.Finalize();
Begin
  If Initialized Then
  Begin
    FScriptTemplates := Nil;
  End;

  InHerited Finalize();
End;

Function TTSTOCustomScriptPlugin.ShowSettings() : Boolean;
Begin
  Result := False;
End;

Function TTSTOCustomScriptPlugin.Execute() : Integer;
Begin
  Result := -1;
End;

Function TTSTOCustomScriptPlugin.GetFreeLandUpgradeScript(Sender : TObject) : String;
Var lVariable : ITSTOScriptTemplateVariableIO;
    lIdx : Integer;
    lNodes : IXmlNodeListEx;
    lStrs : TStringList;
    X, Y : Integer;
Begin
  Result := '';

  If Assigned(FScriptTemplates) And Assigned(MainApp.CurrentProject) And
     Supports(Sender, ITSTOScriptTemplateVariableIO, lVariable) Then
  Begin
    lIdx := FScriptTemplates.IndexOf(lVariable As IInterfaceEx);
    If lIdx > -1 Then
    Begin
      If FScriptTemplates[lIdx].TemplateFile = '' Then
      Begin
        If FileExists(MainApp.CurrentProject.SrcPath + 'LandInfo.xml') Then
          With TStringList.Create() Do
          Try
            LoadFromFile(MainApp.CurrentProject.SrcPath + 'LandInfo.xml');
            FScriptTemplates[lIdx].TemplateFile := Text;

            Finally
              Free();
          End;
      End;

      If FScriptTemplates[lIdx].TemplateFile <> '' Then
      Begin
        lNodes := LoadXMLData(FScriptTemplates[lIdx].TemplateFile).SelectNodes('//LandCost/@value');
        If Assigned(lNodes) Then
        Try
          lStrs := TStringList.Create();
          Try
            For X := 0 To lNodes.Count - 1 Do
            Begin
              lStrs.DelimitedText := lNodes[X].Text;

              For Y := 0 To lStrs.Count - 1 Do
                If (Copy(Trim(lStrs[Y]), 1, 1) = '*') Or (StrToIntDef(Trim(lStrs[Y]), 0) > 0) Then
                  lStrs[Y] := '1';

              lNodes[X].Text := lStrs.DelimitedText;
            End;

            Finally
              lStrs.Free();
          End;

          If Assigned(lNodes.First) And Assigned(lNodes.First.OwnerDocument) Then
            Result := FormatXmlData(lNodes.First.OwnerDocument.Xml.Text);

          Finally
            lNodes := Nil;
        End;
      End;
    End;
  End;
End;

Procedure TTSTOCustomScriptPlugin.PreviewFreeLandUpgrade(Sender : TObject);
Var lEdit : TScintillaNPP;
    lCmp  : TComponent;
Begin
  lCmp := MainApp.Host.MainForm.FindComponent('EditScriptTemplate');
  If Assigned(lCmp) And SameText(lCmp.ClassName, 'TScintillaNPP') Then
  Begin
    lEdit := lCmp As TScintillaNPP;
    lEdit.Lines.Text := GetFreeLandUpgradeScript(Sender);
  End;
End;

Procedure TTSTOCustomScriptPlugin.ExecuteFreeLandUpgrade(Sender : TObject);
Var lStrs : IHsStringListEx;
Begin
  If Assigned(FScriptTemplates) And Assigned(MainApp.CurrentProject) Then
  Begin
    lStrs := THsStringListEx.CreateList();
    Try
      lStrs.Text := GetFreeLandUpgradeScript(Sender);
      lStrs.SaveToFile(MainApp.CurrentProject.CustomModPath + 'LandInfo.xml');

      Finally
        lStrs := Nil;
    End;
  End;
End;

end.
