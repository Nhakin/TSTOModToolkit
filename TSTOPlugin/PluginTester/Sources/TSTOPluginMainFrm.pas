unit TSTOPluginMainFrm;

interface

uses
  TSTOPluginIntf, TSTOProjectWorkSpace.IO,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvComponentBase, JvPluginManager, JvPlugin, StdCtrls, HsInterfaceEx,
  TB2Item, SpTBXItem, TB2Dock, TB2Toolbar,
  SpTBXControls, SpTBXExPanel, SpTBXEditors,
  ImgList, TntStdCtrls;

type
  TTSTOPluginManager = class(TForm, ITSTOApplication)
    JvPluginManager1: TJvPluginManager;
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
    cmdInitPlugin: TSpTBXButton;
    cmdFinalizePlugin: TSpTBXButton;
    lbPlugins: TSpTBXListBox;

    procedure lbPluginsClick(Sender: TObject);
    procedure SpTBXItem1Click(Sender: TObject);
    procedure SpTBXItem2Click(Sender: TObject);
    procedure cmdLoadPluginsClick(Sender: TObject);
    procedure cmdInitPluginClick(Sender: TObject);
    procedure cmdFinalizePluginClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  Private
    FWorkSpace : ITSTOWorkSpaceProjectGroupIO;
    FIntfImpl : TInterfaceExImplementor;

    Function GetIntfImpl() : TInterfaceExImplementor;

  Protected
    Property IntfImpl : TInterfaceExImplementor Read GetIntfImpl Implements ITSTOApplication;

  {$Region ' ITSTOApplication '}
  Private
    Function  UniqueComponentName(AComponentName : String) : String;
    Function  InternalAddPluginItem(Sender : TJvPlugin; AItem : TTBCustomItem; ACommandPrefix : String) : TTBCustomItem;
    Procedure InternalRemovePluginItem(AGroup : TSpTBXTBGroupItem; AItemId : NativeInt);

  Protected
    Function GetWorkSpace() : ITSTOWorkSpaceProjectGroupIO;
    Function GetCurrentSkinName() : String;

    Procedure AddItem(AItemKind : TUIItemKind; Sender : TJvPlugin; AItem : TTBCustomItem); OverLoad;
    Procedure RemoveItem(AItemKind : TUIItemKind; Sender : TJvPlugin; AItem : TTBCustomItem);

    Procedure AddItem(Sender : TJvPlugin; ASrcItem, ATrgItem : TTBCustomItem); OverLoad;

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

procedure TTSTOPluginManager.lbPluginsClick(Sender: TObject);
Var lPluginIntf : ITSTOPlugin;
    lPlugin     : TJvPlugin;
begin
  lPlugin := TJvPlugin(lbPlugins.Items.Objects[lbPlugins.ItemIndex]);
  If lPlugin.GetInterface(ITSTOPlugin, lPluginIntf) Then
  Begin
    If lPluginIntf.Enabled Then
    Begin
      ShowMessage(lPlugin.Name + ' - ' + lPlugin.Copyright);
    End;{
    Else
      JvPluginManager1.UnloadPlugin(ListBox1.ItemIndex);}
  End
  Else
    ShowMessage('ITSTOPlugin not implemented');
end;

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
  Result := FWorkSpace;
End;

Function TTSTOPluginManager.GetCurrentSkinName() : String;
Begin
  Result := SkinManager.CurrentSkinName;
End;

procedure TTSTOPluginManager.cmdFinalizePluginClick(Sender: TObject);
Var lPluginIntf : ITSTOPlugin;
    lPlugin     : TJvPlugin;
begin
  lPlugin := TJvPlugin(lbPlugins.Items.Objects[lbPlugins.ItemIndex]);
  If lPlugin.GetInterface(ITSTOPlugin, lPluginIntf) Then
    lPluginIntf.Finalize()
  Else
    ShowMessage('ITSTOPlugin not implemented');
end;

procedure TTSTOPluginManager.cmdInitPluginClick(Sender: TObject);
Var lPluginIntf : ITSTOPlugin;
    lPlugin     : TJvPlugin;
begin
  lPlugin := TJvPlugin(lbPlugins.Items.Objects[lbPlugins.ItemIndex]);
  If lPlugin.GetInterface(ITSTOPlugin, lPluginIntf) Then
  Begin
    lPlugin.Configure();

    If lPluginIntf.Enabled Then
    Begin
      If Not lPluginIntf.Initialized Then
        lPluginIntf.Initialize(Self);
    End;{
    Else
      JvPluginManager1.UnloadPlugin(ListBox1.ItemIndex);}
  End
  Else
    ShowMessage('ITSTOPlugin not implemented');
end;

procedure TTSTOPluginManager.cmdLoadPluginsClick(Sender: TObject);
  Procedure InternalListPlugins(AStartPath : String; ALvl : Integer);
  Var lSr : TSearchRec;
  Begin
    If FindFirst(AStartPath + '*.*', faAnyFile, lSr) = 0 Then
    Try
      Repeat
        If (lSr.Attr And faDirectory = faDirectory) And (lSr.Name <> '.') And (lSr.Name <> '..') And (ALvl < 1) Then
          InternalListPlugins(AStartPath + lSr.Name + '\', ALvl + 1)
        Else If SameText(ExtractFileExt(lSr.Name), '.dll') And (ALvl = 1) Then
          JvPluginManager1.LoadPlugin(AStartPath + lSr.Name, plgDLL);{
        Else If SameText(ExtractFileExt(lSr.Name), '.bpl') And (ALvl = 0) Then
          JvPluginManager1.LoadPlugin(AStartPath + lSr.Name, plgPackage);}
      Until FindNext(lSr) <> 0;

      Finally
        FindClose(lSr);
    End;
  End;

Var X : Integer;
    lPath : String;
    lPlugin : ITSTOPlugin;
begin
  lPath := ExtractFilePath(ParamStr(0)) + 'Plugins\';
  If FileExists(lPath + 'PluginManager.bpl') Then
  Begin
    JvPluginManager1.LoadPlugin(lPath + 'PluginManager.bpl', plgPackage);
    If JvPluginManager1.Plugins[JvPluginManager1.PluginCount - 1].GetInterface(ITSTOPlugin, lPlugin) Then
    Begin
      JvPluginManager1.Plugins[JvPluginManager1.PluginCount - 1].Configure;
      lPlugin.Initialize(Self);
    End;
  End
  Else
    InternalListPlugins(lPath, 0);

  For X := 0 To JvPluginManager1.PluginCount - 1 Do
    lbPlugins.AddItem(JvPluginManager1.Plugins[X].Name, JvPluginManager1.Plugins[X]);
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

Function TTSTOPluginManager.InternalAddPluginItem(Sender : TJvPlugin; AItem : TTBCustomItem; ACommandPrefix : String) : TTBCustomItem;
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

Procedure TTSTOPluginManager.AddItem(AItemKind : TUIItemKind; Sender : TJvPlugin; AItem : TTBCustomItem);
Var lGroup : TSpTBXTBGroupItem;
Begin
  Case AItemKind Of
    iikToolBar : lGroup := grpTbPluginItems;
    iikMainMenu : lGroup := grpMnuPluginItems;
  End;

  lGroup.Add(InternalAddPluginItem(Sender, AItem, ''));
End;

Procedure TTSTOPluginManager.RemoveItem(AItemKind : TUIItemKind; Sender : TJvPlugin; AItem : TTBCustomItem);
Var lGroup : TSpTBXTBGroupItem;
Begin
  Case AItemKind Of
    iikToolBar : lGroup := grpTbPluginItems;
    iikMainMenu : lGroup := grpMnuPluginItems;
  End;

  InternalRemovePluginItem(lGroup, Integer(AItem));
End;

Procedure TTSTOPluginManager.AddItem(Sender : TJvPlugin; ASrcItem, ATrgItem : TTBCustomItem);
Begin
  ATrgItem.Add(InternalAddPluginItem(Sender, ASrcItem, ''));
End;

end.
