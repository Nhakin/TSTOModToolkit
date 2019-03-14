unit TSTOPluginMainFrm;

interface

uses
  TSTOPluginIntf, TSTOPluginManagerIntf, TSTORGBProgress,
  TSTOProjectWorkSpace.IO, TSTOHackMasterList.IO, TSTOScriptTemplate.IO,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, HsInterfaceEx,
  TB2Item, SpTBXItem, TB2Dock, TB2Toolbar,
  SpTBXControls, SpTBXExPanel, SpTBXEditors,
  ImgList, TntStdCtrls;

type
  TTSTOPluginManager = class(TForm, ITSTOApplication)
    SpTBXBItemContainer1: TSpTBXBItemContainer;
    SpTBXTestMnuItems: TSpTBXTBGroupItem;
    SpTBXItem2: TSpTBXItem;
    SpTBXSubmenuItem2: TSpTBXSubmenuItem;
    SpTBXItem3: TSpTBXItem;
    SpTBXItem4: TSpTBXItem;
    grpTbPluginItems: TSpTBXTBGroupItem;
    ilToolBar: TImageList;
    grpMnuPluginItems: TSpTBXTBGroupItem;
    SpTBXDock1: TSpTBXDock;
    tbMain: TSpTBXToolbar;
    grp1: TSpTBXTBGroupItem;
    SpTBXSeparatorItem1: TSpTBXSeparatorItem;
    grp2: TSpTBXTBGroupItem;
    mainMnu: TSpTBXToolbar;
    SpTBXSubmenuItem1: TSpTBXSubmenuItem;
    SpTBXItem1: TSpTBXItem;
    mnuPlugins: TSpTBXSubmenuItem;
    SpTBXSubmenuItem3: TSpTBXSubmenuItem;
    SpTBXSeparatorItem2: TSpTBXSeparatorItem;
    SpTBXTBGroupItem1: TSpTBXTBGroupItem;
    SpTBXExPanel1: TSpTBXExPanel;
    cmdLoadPlugins: TSpTBXButton;
    lbPlugins: TSpTBXListBox;
    procedure SpTBXItem1Click(Sender: TObject);
    procedure SpTBXItem2Click(Sender: TObject);
    procedure cmdLoadPluginsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  Private
    FIntfImpl  : TInterfaceExImplementor;
    FPluginM   : ITSTOPluginManager;

    Function GetIntfImpl() : TInterfaceExImplementor;

  Protected
    Property IntfImpl : TInterfaceExImplementor Read GetIntfImpl Implements ITSTOApplication;

  {$Region ' ITSTOApplication '}
  Private
    Function  UniqueComponentName(AComponentName : String) : String;
    Function  InternalAddPluginItem(Sender : TComponent; AItem : TTBCustomItem; ACommandPrefix : String) : TTBCustomItem;

    Procedure InternalRemovePluginItem(AGroup : TSpTBXTBGroupItem; AItemId : NativeInt);

  Protected
    Function GetWorkSpace() : ITSTOWorkSpaceProjectGroupIO;
    Function GetCurrentProject() : ITSTOWorkSpaceProjectIO;
    Function GetCurrentSkinName() : String;
    Function GetIcon() : TIcon;
    Function GetHost() : TApplication;

    Procedure AddItem(AItemKind : TUIItemKind; Sender : TComponent; AItem : TTBCustomItem); OverLoad;
    Procedure AddItem(Sender : TComponent; ASrcItem, ATrgItem : TTBCustomItem); OverLoad;
    Procedure RemoveItem(AItemKind : TUIItemKind; Sender : TComponent; AItem : TTBCustomItem);

    Function CreateWorkSpace() : ITSTOWorkSpaceProjectGroupIO;
    Function CreateScriptTemplates() : ITSTOScriptTemplateHacksIO;
    Function CreateHackMasterList() : ITSTOHackMasterListIO;
    Function CreateRgbProgress() : IRgbProgress;

  {$EndRegion}

  public

  end;

Var
  TSTOPluginManager : TTSTOPluginManager;

implementation

Uses
  SpTBXSkins, SpTBXAdditionalSkins;

{$R *.dfm}

Function TTSTOPluginManager.GetIntfImpl() : TInterfaceExImplementor;
Begin
  If Not Assigned(FIntfImpl) Then
    FIntfImpl := TInterfaceExImplementor.Create(Self, False);
  Result := FIntfImpl;
End;

procedure TTSTOPluginManager.SpTBXItem1Click(Sender: TObject);
begin
  Close();
end;

procedure TTSTOPluginManager.SpTBXItem2Click(Sender: TObject);
begin
  ShowMessage('SingleClick');
end;

Function TTSTOPluginManager.GetWorkSpace() : ITSTOWorkSpaceProjectGroupIO;
Begin
  Result := Nil;
End;

Function TTSTOPluginManager.GetCurrentProject() : ITSTOWorkSpaceProjectIO;
Begin
  Result := Nil;
End;

Function TTSTOPluginManager.GetCurrentSkinName() : String;
Begin
  Result := SkinManager.CurrentSkinName;
End;

Function TTSTOPluginManager.GetIcon() : TIcon;
Begin
  Result := Application.Icon;
End;

Function TTSTOPluginManager.GetHost() : TApplication;
Begin
  Result := Application;
End;

procedure TTSTOPluginManager.cmdLoadPluginsClick(Sender: TObject);
Var lPath : String;
    lModule : HWnd;
    X       : Integer;
    lCreatePM : Function(AHostApplication : TApplication; AApplication : ITSTOApplication) : ITSTOPluginManager;
begin
  lPath := ExtractFilePath(ParamStr(0)) + 'Plugins\';
  If FileExists(lPath + 'PluginManager.bpl') Then
  Begin
    lModule := LoadPackage(lPath + 'PluginManager.bpl');
    If lModule <> 0 Then
    Begin
      lCreatePM := GetProcAddress(lModule, 'CreatePluginManager');
      If Assigned(lCreatePM) Then
        FPluginM := lCreatePM(Application, Self);

      For X := 0 To FPluginM.Plugins.Count - 1 Do
        lbPlugins.AddItem(FPluginM.Plugins[X].Name, FPluginM.Plugins[X].InterfaceObject);
    End;
  End;
end;

procedure TTSTOPluginManager.FormCreate(Sender: TObject);
begin
  SkinManager.SetSkin('WMP11');
end;

Function TTSTOPluginManager.UniqueComponentName(AComponentName : String) : String;
Var lIdx : Integer;
Begin
  Result := AComponentName;

  If Assigned(FindComponent(Result)) Then
  Begin
    lIdx := 2;
    Repeat
      Result := AComponentName + IntToStr(lIdx);
      Inc(lIdx);
    Until Not Assigned(FindComponent(Result));
  End;
End;

Function TTSTOPluginManager.InternalAddPluginItem(Sender : TComponent; AItem : TTBCustomItem; ACommandPrefix : String) : TTBCustomItem;
Var lCurItem : TTBCustomItem;
    X : Integer;
Begin
  If SameText(AItem.ClassName, 'TSpTBXItem') Then
  Begin
    Result := TSpTBXItem.Create(Self);

    With TSpTBXItem(Result) Do
    Begin
      Name       := UniqueComponentName(ACommandPrefix + Sender.Name + AItem.Name);
      Images     := AItem.Images;
      ImageIndex := AItem.ImageIndex;
      OnClick    := AItem.OnClick;
      Caption    := AItem.Caption;
      Tag        := Integer(AItem);
    End;
  End
  Else If SameText(AItem.ClassName, 'TSpTBXSubmenuItem') Then
  Begin
    Result := TSpTBXSubmenuItem.Create(Self);
    With TSpTBXSubmenuItem(Result) Do
    Begin
      Name          := UniqueComponentName(ACommandPrefix + Sender.Name + AItem.Name);
      Images        := AItem.Images;
      ImageIndex    := AItem.ImageIndex;
      OnClick       := AItem.OnClick;
      Caption       := AItem.Caption;
      DropdownCombo := TSpTBXSubmenuItem(AItem).DropdownCombo;
      Tag := Integer(AItem);

      If Assigned(AItem.LinkSubitems) Then
        lCurItem := AItem.LinkSubitems
      Else
        lCurItem := AItem;

      For X := 0 To lCurItem.Count - 1 Do
        If SameText(lCurItem[X].ClassName, 'TSpTBXSeparatorItem') Then
          Result.Add(TSpTBXSeparatorItem.Create(Self))
        Else
          Result.Add(InternalAddPluginItem(Sender, lCurItem[X], ACommandPrefix));
    End;
  End
  Else If SameText(AItem.ClassName, 'TSpTBXTBGroupItem') Then
  Begin
    Result := TSpTBXTBGroupItem.Create(Self);
    With TSpTBXTBGroupItem(Result) Do
    Begin
      Name := UniqueComponentName(ACommandPrefix + Sender.Name + AItem.Name);
      Tag := Integer(AItem);

      If Assigned(AItem.LinkSubitems) Then
        lCurItem := AItem.LinkSubitems
      Else
        lCurItem := AItem;

      For X := 0 To lCurItem.Count - 1 Do
        If SameText(lCurItem[X].ClassName, 'TSpTBXSeparatorItem') Then
          Result.Add(TSpTBXSeparatorItem.Create(Self))
        Else
          Result.Add(InternalAddPluginItem(Sender, lCurItem[X], ACommandPrefix));
    End;
  End;
End;

Procedure TTSTOPluginManager.InternalRemovePluginItem(AGroup : TSpTBXTBGroupItem; AItemId : NativeInt);
Var X : Integer;
Begin
  For X := AGroup.Count - 1 DownTo 0 Do
    If AGroup[X].Tag = Integer(AItemId) Then
      AGroup.Remove(AGroup[X]);
End;

Procedure TTSTOPluginManager.AddItem(AItemKind : TUIItemKind; Sender : TComponent; AItem : TTBCustomItem);
Var lGroup : TSpTBXTBGroupItem;
Begin
  Case AItemKind Of
    iikToolBar : lGroup := grpTbPluginItems;
    iikMainMenu : lGroup := grpMnuPluginItems;
  End;

  lGroup.Add(InternalAddPluginItem(Sender, AItem, ''));
End;

Procedure TTSTOPluginManager.RemoveItem(AItemKind : TUIItemKind; Sender : TComponent; AItem : TTBCustomItem);
Var lGroup : TSpTBXTBGroupItem;
Begin
  Case AItemKind Of
    iikToolBar : lGroup := grpTbPluginItems;
    iikMainMenu : lGroup := grpMnuPluginItems;
  End;

  InternalRemovePluginItem(lGroup, Integer(AItem));
End;

Procedure TTSTOPluginManager.AddItem(Sender : TComponent; ASrcItem, ATrgItem : TTBCustomItem);
Begin
  ATrgItem.Add(InternalAddPluginItem(Sender, ASrcItem, ''));
End;

Function TTSTOPluginManager.CreateWorkSpace() : ITSTOWorkSpaceProjectGroupIO;
Begin
  Result := Nil;
End;

Function TTSTOPluginManager.CreateScriptTemplates() : ITSTOScriptTemplateHacksIO;
Begin
  Result := Nil;
End;

Function TTSTOPluginManager.CreateHackMasterList() : ITSTOHackMasterListIO;
Begin
  Result := Nil;
End;

Function TTSTOPluginManager.CreateRgbProgress() : IRgbProgress;
Begin
  Result := Nil;
End;

end.
