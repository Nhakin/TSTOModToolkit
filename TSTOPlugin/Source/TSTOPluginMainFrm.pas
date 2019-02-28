unit TSTOPluginMainFrm;

interface

uses
  TSTOPluginIntf, TSTOProjectWorkSpace.IO,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvComponentBase, JvPluginManager, JvPlugin, StdCtrls, HsInterfaceEx,
  TB2Item, SpTBXItem, TB2Dock, TB2Toolbar,
  SpTBXControls, System.ImageList, Vcl.ImgList;

type
  TTSTOPluginManager = class(TForm, ITSTOApplication)
    JvPluginManager1: TJvPluginManager;
    lbPlugins: TListBox;
    SpTBXBItemContainer1: TSpTBXBItemContainer;
    SpTBXTestMnuItems: TSpTBXTBGroupItem;
    SpTBXItem2: TSpTBXItem;
    SpTBXSubmenuItem2: TSpTBXSubmenuItem;
    SpTBXItem3: TSpTBXItem;
    SpTBXItem4: TSpTBXItem;
    grpTbPluginItems: TSpTBXTBGroupItem;
    cmdLoadPlugins: TSpTBXButton;
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
    cmdInitPlugin: TSpTBXButton;
    cmdFinalizePlugin: TSpTBXButton;

    procedure lbPluginsClick(Sender: TObject);
    procedure SpTBXItem1Click(Sender: TObject);
    procedure SpTBXItem2Click(Sender: TObject);
    procedure cmdLoadPluginsClick(Sender: TObject);
    procedure cmdInitPluginClick(Sender: TObject);
    procedure cmdFinalizePluginClick(Sender: TObject);

  Private
    FWorkSpace : ITSTOWorkSpaceProjectGroupIO;
    FIntfImpl : TInterfaceExImplementor;

    Function GetIntfImpl() : TInterfaceExImplementor;

  Protected
    Property IntfImpl : TInterfaceExImplementor Read GetIntfImpl Implements ITSTOApplication;

  {$Region ' ITSTOApplication '}
  Private
    Function UniqueComponentName(AComponentName : String) : String;

    Function AddPluginCommandItem(Sender : TJvPlugin; AItem : TSpTBXItem; ACommandPrefix : String) : TTBCustomItem; OverLoad;
    Function AddPluginCommandItem(Sender : TJvPlugin; AItem : TSpTBXSubmenuItem; ACommandPrefix : String) : TTBCustomItem; OverLoad;
    Function AddPluginCommandItem(Sender : TJvPlugin; AItem : TSpTBXTBGroupItem; ACommandPrefix : String) : TTBCustomItem; OverLoad;

    Procedure InternalRemovePluginItem(AGroup : TSpTBXTBGroupItem; AItemId : NativeInt);

  Protected
    Function GetWorkSpace() : ITSTOWorkSpaceProjectGroupIO;

    Procedure AddToolBarButton(Sender : TJvPlugin; AItem : TSpTbxItem);
    Procedure AddToolBarDropDownButton(Sender : TJvPlugin; AItem : TSpTBXSubmenuItem);
    Procedure AddGroupToolBarItem(Sender : TJvPlugin; AItem : TSpTBXTBGroupItem);
    Procedure AddToolBarSeparatorItem(Sender : TJvPlugin);

    Procedure AddMenuItem(Sender : TJvPlugin; AItem : TSpTbxItem);
    Procedure AddSubMenuItem(Sender : TJvPlugin; AItem : TSpTBXSubmenuItem);
    Procedure AddGroupMenuItem(Sender : TJvPlugin; AItem : TSpTBXTBGroupItem);
    Procedure AddMenuSeparatorItem(Sender : TJvPlugin);

    Procedure RemoveToolBarItem(Sender : TJvPlugin; AItem : TTBCustomItem);
    Procedure RemoveMenuItem(Sender : TJvPlugin; AItem : TTBCustomItem);
  {$EndRegion}

  public

  end;

var
  TSTOPluginManager: TTSTOPluginManager;

implementation

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
        Else If SameText(ExtractFileExt(lSr.Name), '.dll') Then
          JvPluginManager1.LoadPlugin(AStartPath + lSr.Name, plgDLL);
      Until FindNext(lSr) <> 0;

      Finally
        FindClose(lSr);
    End;
  End;

Var X : Integer;
begin
  InternalListPlugins(ExtractFilePath(ParamStr(0)) + 'Plugins\', 0);

  For X := 0 To JvPluginManager1.PluginCount - 1 Do
    lbPlugins.AddItem(JvPluginManager1.Plugins[X].Name, JvPluginManager1.Plugins[X]);
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

Function TTSTOPluginManager.AddPluginCommandItem(Sender : TJvPlugin; AItem : TSpTBXItem; ACommandPrefix : String) : TTBCustomItem;
Begin
  Result := TSpTBXItem.Create(Self);
  Result.Name := UniqueComponentName(ACommandPrefix + Sender.Name + AItem.Name);
  Result.Images := AItem.Images;
  Result.ImageIndex := AItem.ImageIndex;
  Result.OnClick := AItem.OnClick;
  Result.Caption := AItem.Caption;
  Result.Tag := Integer(AItem);
End;

Function TTSTOPluginManager.AddPluginCommandItem(Sender : TJvPlugin; AItem : TSpTBXSubmenuItem; ACommandPrefix : String) : TTBCustomItem;
Var X : Integer;
    lCurItem : TTBCustomItem;
Begin
  Result := TSpTBXSubmenuItem.Create(Self);
  With TSpTBXSubmenuItem(Result) Do
  Begin
    Name := UniqueComponentName(ACommandPrefix + Sender.Name + AItem.Name);
    Images := AItem.Images;
    ImageIndex := AItem.ImageIndex;
    OnClick := AItem.OnClick;
    Caption := AItem.Caption;
    DropdownCombo := AItem.DropdownCombo;
    Tag := Integer(AItem);

    If Assigned(AItem.LinkSubitems) Then
      lCurItem := AItem.LinkSubitems
    Else
      lCurItem := AItem;

    For X := 0 To lCurItem.Count - 1 Do
      If SameText(lCurItem[X].ClassName, 'TSpTBXItem') Then
        Result.Add(AddPluginCommandItem(Sender, TSpTBXItem(lCurItem[X]), ACommandPrefix))
      Else If SameText(lCurItem[X].ClassName, 'TSpTBXSubmenuItem') Then
        Result.Add(AddPluginCommandItem(Sender, TSpTBXSubmenuItem(lCurItem[X]), ACommandPrefix))
      Else If SameText(lCurItem[X].ClassName, 'TSpTBXTBGroupItem') Then
        Result.Add(AddPluginCommandItem(Sender, TSpTBXTBGroupItem(lCurItem[X]), ACommandPrefix))
      Else If SameText(lCurItem[X].ClassName, 'TSpTBXSeparatorItem') Then
        Result.Add(TSpTBXSeparatorItem.Create(Self));
  End;
End;

Function TTSTOPluginManager.AddPluginCommandItem(Sender : TJvPlugin; AItem : TSpTBXTBGroupItem; ACommandPrefix : String) : TTBCustomItem;
Var X : Integer;
    lCurItem : TTBCustomItem;
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
      If SameText(lCurItem[X].ClassName, 'TSpTBXItem') Then
        Result.Add(AddPluginCommandItem(Sender, TSpTBXItem(lCurItem[X]), ACommandPrefix))
      Else If SameText(lCurItem[X].ClassName, 'TSpTBXSubmenuItem') Then
        Result.Add(AddPluginCommandItem(Sender, TSpTBXSubmenuItem(lCurItem[X]), ACommandPrefix))
      Else If SameText(lCurItem[X].ClassName, 'TSpTBXTBGroupItem') Then
        Result.Add(AddPluginCommandItem(Sender, TSpTBXTBGroupItem(lCurItem[X]), ACommandPrefix))
      Else If SameText(lCurItem[X].ClassName, 'TSpTBXSeparatorItem') Then
        Result.Add(TSpTBXSeparatorItem.Create(Self));
  End;
End;

Procedure TTSTOPluginManager.InternalRemovePluginItem(AGroup : TSpTBXTBGroupItem; AItemId : NativeInt);
Var X : Integer;
Begin
  For X := AGroup.Count - 1 DownTo 0 Do
    If AGroup[X].Tag = Integer(AItemId) Then
      AGroup.Remove(AGroup[X]);
End;

Procedure TTSTOPluginManager.AddToolBarButton(Sender : TJvPlugin; AItem : TSpTbxItem);
Begin
  grpTbPluginItems.Add(AddPluginCommandItem(Sender, AItem, 'Tb'));
End;

Procedure TTSTOPluginManager.AddToolBarDropDownButton(Sender : TJvPlugin; AItem : TSpTBXSubmenuItem);
Begin
  grpTbPluginItems.Add(AddPluginCommandItem(Sender, AItem, 'Tb'));
End;

Procedure TTSTOPluginManager.AddGroupToolBarItem(Sender : TJvPlugin; AItem : TSpTBXTBGroupItem);
Begin
  grpTbPluginItems.Add(AddPluginCommandItem(Sender, AItem, 'Tb'));
End;

Procedure TTSTOPluginManager.AddToolBarSeparatorItem(Sender : TJvPlugin);
Begin
  grpTbPluginItems.Add(TSpTBXSeparatorItem.Create(Self));
End;

Procedure TTSTOPluginManager.AddMenuItem(Sender : TJvPlugin; AItem : TSpTbxItem);
Begin
  grpMnuPluginItems.Add(AddPluginCommandItem(Sender, AItem, 'Mnu'));
End;

Procedure TTSTOPluginManager.AddSubMenuItem(Sender : TJvPlugin; AItem : TSpTBXSubmenuItem);
Begin
  grpMnuPluginItems.Add(AddPluginCommandItem(Sender, AItem, 'Mnu'));
End;

Procedure TTSTOPluginManager.AddGroupMenuItem(Sender : TJvPlugin; AItem : TSpTBXTBGroupItem);
Begin
  grpMnuPluginItems.Add(AddPluginCommandItem(Sender, AItem, 'Mnu'));
End;

Procedure TTSTOPluginManager.AddMenuSeparatorItem(Sender : TJvPlugin);
Begin
  grpMnuPluginItems.Add(TSpTBXSeparatorItem.Create(Self));
End;

Procedure TTSTOPluginManager.RemoveToolBarItem(Sender : TJvPlugin; AItem : TTBCustomItem);
Begin
  InternalRemovePluginItem(grpTbPluginItems, Integer(AItem));
End;

Procedure TTSTOPluginManager.RemoveMenuItem(Sender : TJvPlugin; AItem : TTBCustomItem);
Begin
  InternalRemovePluginItem(grpMnuPluginItems, Integer(AItem));
End;

end.
