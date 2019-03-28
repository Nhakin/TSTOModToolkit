unit DlgTSTOVintageScriptSettings;

interface

uses
  TSTOPluginIntf, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TB2Dock, TB2Toolbar, SpTBXItem, TB2Item, ImgList, SpTBXControls,
  SpTBXExPanel;

type
  TTSTOVintageScriptSettingsDlg = class(TForm)
    imgToolBar: TImageList;
    SpTBXBItemContainer1: TSpTBXBItemContainer;
    tbPopupMenuItems: TSpTBXSubmenuItem;
    tbSavePlugins: TSpTBXItem;
    sptbxDckMain: TSpTBXDock;
    sptbxtbMain: TSpTBXToolbar;
    SpTBXExPanel1: TSpTBXExPanel;

  private
    FMainApp : ITSTOApplication;

    Procedure SetMainApp(AMainApp : ITSTOApplication);

  public

  end;

implementation

{$R *.dfm}

Uses
  HsStreamEx;

Procedure TTSTOVintageScriptSettingsDlg.SetMainApp(AMainApp : ITSTOApplication);
Var lMemStrm : IMemoryStreamEx;
Begin
  FMainApp := AMainApp;

  If Assigned(FMainApp) Then
  Begin
    lMemStrm := TMemoryStreamEx.Create();
    Try
      FMainApp.Icon.SaveToStream(TStream(lMemStrm.InterfaceObject));
      lMemStrm.Position := 0;
      Icon.LoadFromStream(TStream(lMemStrm.InterfaceObject));
      
      Finally
        lMemStrm := Nil;
    End;
  End;
End;

end.
