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
    ListBox1: TListBox;
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
    procedure ListBox1Click(Sender: TObject);
    procedure SpTBXItem1Click(Sender: TObject);
    procedure SpTBXItem2Click(Sender: TObject);
    procedure cmdLoadPluginsClick(Sender: TObject);
    procedure pCustomizeClick(Sender: TObject);

  Private
    FWorkSpace : ITSTOWorkSpaceProjectGroupIO;
    FIntfImpl : TInterfaceExImplementor;

    Function GetIntfImpl() : TInterfaceExImplementor;

  Protected
    Property IntfImpl : TInterfaceExImplementor Read GetIntfImpl Implements ITSTOApplication;

  {$Region ' ITSTOApplication '}
  Private
    Function AddPluginCommandItem(Sender : TJvPlugin; AItem : TSpTBXItem; ACommandPrefix : String) : TTBCustomItem; OverLoad;
    Function AddPluginCommandItem(Sender : TJvPlugin; AItem : TSpTBXSubmenuItem; ACommandPrefix : String) : TTBCustomItem; OverLoad;

  Protected
    Function GetWorkSpace() : ITSTOWorkSpaceProjectGroupIO;

    Procedure AddToolBarButton(Sender : TJvPlugin; AItem : TSpTbxItem);
    Procedure AddToolBarDropDownButton(Sender : TJvPlugin; AItem : TSpTBXSubmenuItem);

    Procedure AddMenuItem(Sender : TJvPlugin; AItem : TSpTbxItem);
    Procedure AddSubMenuItem(Sender : TJvPlugin; AItem : TSpTBXSubmenuItem);
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

procedure TTSTOPluginManager.ListBox1Click(Sender: TObject);
Var lPluginIntf : ITSTOPlugin;
    lPlugin     : TJvPlugin;
begin
  lPlugin := TJvPlugin(ListBox1.Items.Objects[ListBox1.ItemIndex]);
  If lPlugin.GetInterface(ITSTOPlugin, lPluginIntf) Then
  Begin
    lPlugin.Configure();

    If lPluginIntf.Enabled Then
    Begin
      lPluginIntf.InitPlugin(Self);
      ShowMessage(lPlugin.Name + ' - ' + lPlugin.Copyright);
    End;{
    Else
      JvPluginManager1.UnloadPlugin(ListBox1.ItemIndex);}
  End
  Else
    ShowMessage('ITSTOPlugin not implemented');
end;

procedure TTSTOPluginManager.pCustomizeClick(Sender: TObject);
begin
//
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
    ListBox1.AddItem(JvPluginManager1.Plugins[X].Name, JvPluginManager1.Plugins[X]);
end;

Function TTSTOPluginManager.AddPluginCommandItem(Sender : TJvPlugin; AItem : TSpTBXItem; ACommandPrefix : String) : TTBCustomItem;
Begin
  Result := TSpTBXItem.Create(Self);
  Result.Name := ACommandPrefix + Sender.Name + AItem.Name;
  Result.Images := AItem.Images;
  Result.ImageIndex := AItem.ImageIndex;
  Result.OnClick := AItem.OnClick;
  Result.Caption := AItem.Caption;
End;

Function TTSTOPluginManager.AddPluginCommandItem(Sender : TJvPlugin; AItem : TSpTBXSubmenuItem; ACommandPrefix : String) : TTBCustomItem;
Var X : Integer;
Begin
  Result := TSpTBXSubmenuItem.Create(Self);
  With TSpTBXSubmenuItem(Result) Do
  Begin
    Name := ACommandPrefix + Sender.Name + AItem.Name;
    Images := AItem.Images;
    ImageIndex := AItem.ImageIndex;
    OnClick := AItem.OnClick;
    Caption := AItem.Caption;
    DropdownCombo := AItem.DropdownCombo;

    For X := 0 To AItem.Count - 1 Do
      If SameText(AItem[X].ClassName, 'TSpTBXItem') Then
        Result.Add(AddPluginCommandItem(Sender, TSpTBXItem(AItem[X]), ACommandPrefix))
      Else If SameText(AItem[X].ClassName, 'TSpTBXSubmenuItem') Then
        Result.Add(AddPluginCommandItem(Sender, TSpTBXSubmenuItem(AItem[X]), ACommandPrefix))
      Else If SameText(AItem[X].ClassName, 'TSpTBXSeparatorItem') Then
        Result.Add(TSpTBXSeparatorItem.Create(Self));
  End;
End;

Procedure TTSTOPluginManager.AddToolBarButton(Sender : TJvPlugin; AItem : TSpTbxItem);
Begin
  grpTbPluginItems.Add(AddPluginCommandItem(Sender, AItem, 'Tb'));
End;

Procedure TTSTOPluginManager.AddToolBarDropDownButton(Sender : TJvPlugin; AItem : TSpTBXSubmenuItem);
Begin
  grpTbPluginItems.Add(AddPluginCommandItem(Sender, AItem, 'Tb'));
End;

Procedure TTSTOPluginManager.AddMenuItem(Sender : TJvPlugin; AItem : TSpTbxItem);
Begin
  grpMnuPluginItems.Add(AddPluginCommandItem(Sender, AItem, 'Mnu'));
End;

Procedure TTSTOPluginManager.AddSubMenuItem(Sender : TJvPlugin; AItem : TSpTBXSubmenuItem);
Begin
  grpMnuPluginItems.Add(AddPluginCommandItem(Sender, AItem, 'Mnu'));
End;

end.
