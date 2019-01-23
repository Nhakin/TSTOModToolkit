unit dmImage;

interface

uses
  SysUtils, Classes, ImgList, Controls, System.ImageList;

type
  TDataModuleImage = class(TDataModule)
    imgToolBar: TImageList;
    procedure DataModuleCreate(Sender: TObject);

  private
    FIsV1 : Boolean;

  public
    Property IsV1 : Boolean Read FIsV1 Write FIsV1;

  end;

var
  DataModuleImage: TDataModuleImage;

implementation

{$R *.dfm}

procedure TDataModuleImage.DataModuleCreate(Sender: TObject);
Var X : Integer;
begin
  FIsV1 := False;

  For X := 0 To ParamCount Do
    If Pos('OLDUI', UpperCase(ParamStr(X))) > 0 Then
    Begin
      FIsV1 := True;
      Break;
    End;
end;

end.
