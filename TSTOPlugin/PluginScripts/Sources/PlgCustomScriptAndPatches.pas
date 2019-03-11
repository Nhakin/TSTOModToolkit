unit PlgCustomScriptAndPatches;

interface

uses
  PlgTSTOCustomPlugin, TSTOPluginIntf, TSTOScriptTemplate.IO,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TTSTOCustomScriptPlugin = class(TTSTOCustomPlugin)
    procedure TTSTOCustomScriptPluginConfigure(Sender: TObject);

  Private
    FScriptTemplates : ITSTOScriptTemplateHacksIO;

    Procedure ExecuteFreeLandUpgrade(Sender : TObject);

  Protected
    Function  GetPluginKind() : TTSTOPluginKind; OverRide;
    Function  GetHaveSettings() : Boolean; OverRide;

    Procedure Initialize(AMainApplication : ITSTOApplication); OverRide;
    Procedure Finalize(); OverRide;
    Function  ShowSettings() : Boolean; OverRide;
    Function  Execute() : Integer; OverRide;

  Public

  end;

Function RegisterPlugin() : TTSTOCustomScriptPlugin; StdCall;

implementation

Uses HsInterfaceEx, HsStreamEx, HsXmlDocEx;

{$R *.dfm}

Function RegisterPlugin() : TTSTOCustomScriptPlugin;
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

Procedure TTSTOCustomScriptPlugin.Initialize(AMainApplication : ITSTOApplication);
Var lStrStrm : IStringStreamEx;
Begin
  InHerited Initialize(AMainApplication);

  If Initialized Then
  Begin
    FScriptTemplates := MainApp.CreateScriptTemplates();

    With FScriptTemplates.Add() Do
    Begin
      Name := 'Free Land Upgrade';
      With Variables.Add() Do
      Begin
        Name := '%FreeLandUpgrade%';
        VarFunc := 'hmCustom';
//        OnExecFunc := ExecuteFreeLandUpgrade;
      End;

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

      //FScript.GenenrateScript(MainApp.WorkSpace.HackSettings.HackMasterList);
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

procedure TTSTOCustomScriptPlugin.TTSTOCustomScriptPluginConfigure(Sender: TObject);
begin
  inherited;
  //
end;

Procedure TTSTOCustomScriptPlugin.ExecuteFreeLandUpgrade(Sender : TObject);
Var lVariable : ITSTOScriptTemplateVariableIO;
    lIdx : Integer;
    lNodes : IXmlNodeListEx;
    lStrs : TStringList;
    X, Y : Integer;
Begin
  If Supports(Sender, ITSTOScriptTemplateVariableIO, lVariable) Then
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

          lStrs := TStringList.Create();
          Try
            If Assigned(lNodes.First) And Assigned(lNodes.First.OwnerDocument) Then
              lStrs.Text := FormatXmlData(lNodes.First.OwnerDocument.Xml.Text);

            lStrs.SaveToFile(ExtractFilePath(ExcludeTrailingBackSlash(MainApp.CurrentProject.SrcPath)) + '1.src\LandInfo.xml');

            Finally
              lStrs.Free();
          End;

          Finally
            lNodes := Nil;
        End;
      End;
    End;
  End;
End;

end.
