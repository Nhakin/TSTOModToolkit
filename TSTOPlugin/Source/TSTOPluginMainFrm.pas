unit TSTOPluginMainFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvComponentBase, JvPluginManager, JvPlugin, StdCtrls, HsInterfaceEx,
  TSTOPluginIntf, TSTOWorkspaceIntf, TB2Item, SpTBXItem, TB2Dock, TB2Toolbar;

type
  TForm4 = class(TForm, ITSTOApplication)
    JvPluginManager1: TJvPluginManager;
    ListBox1: TListBox;
    SpTBXToolbar1: TSpTBXToolbar;
    tbPlugins: TSpTBXTBGroupItem;
    SpTBXToolbar2: TSpTBXToolbar;
    SpTBXSubmenuItem1: TSpTBXSubmenuItem;
    SpTBXItem1: TSpTBXItem;
    mnuPlugins: TSpTBXSubmenuItem;
    SpTBXTBGroupItem1: TSpTBXTBGroupItem;
    SpTBXBItemContainer1: TSpTBXBItemContainer;
    SpTBXItem2: TSpTBXItem;
    SpTBXSubmenuItem2: TSpTBXSubmenuItem;
    SpTBXItem3: TSpTBXItem;
    SpTBXItem4: TSpTBXItem;
    SpTBXSubmenuItem3: TSpTBXSubmenuItem;
    SpTBXTBGroupItem2: TSpTBXTBGroupItem;
    SpTBXSubmenuItem4: TSpTBXSubmenuItem;

    procedure FormCreate(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure SpTBXItem1Click(Sender: TObject);

  Private
    FWorkSpace : ITSTOWorkSpaceProjectGroupIO;
    FIntfImpl : TInterfaceExImplementor;

    Function GetIntfImpl() : TInterfaceExImplementor;

  Protected
    Property IntfImpl : TInterfaceExImplementor Read GetIntfImpl Implements ITSTOApplication;

    Function GetWorkSpace() : ITSTOWorkSpaceProjectGroupIO;
    Procedure AddToolBarButton(Sender : TJvPlugin; AItem : TSpTbxItem);
    Procedure AddMenuItem(Sender : TJvPlugin; AItem : TSpTbxItem);

  public

  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.FormCreate(Sender: TObject);
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

Function TForm4.GetIntfImpl() : TInterfaceExImplementor;
Begin
  If Not Assigned(FIntfImpl) Then
    FIntfImpl := TInterfaceExImplementor.Create(Self, False);
  Result := FIntfImpl;
End;

procedure TForm4.ListBox1Click(Sender: TObject);
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

procedure TForm4.SpTBXItem1Click(Sender: TObject);
begin
  Close();
end;

Function TForm4.GetWorkSpace() : ITSTOWorkSpaceProjectGroupIO;
Begin
  Result := FWorkSpace;
End;

Procedure TForm4.AddToolBarButton(Sender : TJvPlugin; AItem : TSpTbxItem);
Var lMnu : TSpTBXSubmenuItem;
Begin
  lMnu := TSpTBXSubmenuItem.Create(Self);
  lMnu.Name := 'tb' + Sender.Name + AItem.Name;
  lMnu.Images := AItem.Images;
  lMnu.ImageIndex := AItem.ImageIndex;
  lMnu.LinkSubitems := AItem;

  If AItem Is TSpTBXSubmenuItem Then
    lMnu.DropdownCombo := TSpTBXSubmenuItem(AItem).DropdownCombo;
  tbPlugins.Add(lMnu);
End;

Procedure TForm4.AddMenuItem(Sender : TJvPlugin; AItem : TSpTbxItem);
Var lMnu : TSpTBXTBGroupItem;
Begin
  lMnu := TSpTBXTBGroupItem.Create(Self);
  lMnu.Name := 'mnu' + Sender.Name + AItem.Name;
  lMnu.Images := AItem.Images;
  lMnu.ImageIndex := AItem.ImageIndex;
  lMnu.LinkSubitems := AItem;

  mnuPlugins.Add(lMnu);
{
  lMnu := TSpTBXSubmenuItem.Create(Self);
  lMnu.Name := 'mnu' + Sender.Name + AItem.Name;
  lMnu.Images := AItem.Images;
  lMnu.ImageIndex := AItem.ImageIndex;
  lMnu.LinkSubitems := AItem;

  If AItem Is TSpTBXSubmenuItem Then
    lMnu.DropdownCombo := TSpTBXSubmenuItem(AItem).DropdownCombo;
  mnuPluginItems.Add(lMnu);
}
End;

end.
