unit HsHttpEx;

interface

Uses Classes, IdComponent, IdHTTP, HsInterfaceEx;

Type
  THsIdHTTPExOnProgress = Procedure(Const AFileName : String; Const ACurProgress, AMaxValue : Int64) Of Object;

  IHsIdHTTPEx = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-A722-5CC6839C3C2A}']
    Function  GetOnProgress() : THsIdHTTPExOnProgress;
    Procedure SetOnProgress(Const AValue : THsIdHTTPExOnProgress);

    Procedure Get(AURL : String; AResponseContent : TStream);

    Property OnProgress : THsIdHTTPExOnProgress Read GetOnProgress Write SetOnProgress;
    
  End;

  THsIdHTTPEx = Class(TInterfacedObjectEx, IHsIdHTTPEx)
  Private Type
    THsIdHTTPExImpl = Class(TIdHTTP)
    Private
      FFileName   : String;
      FMaxWork    : Int64;
      FOnProgress : THsIdHTTPExOnProgress;

      Procedure DoOnWork(ASender : TObject; AWorkMode : TWorkMode; AWorkCount : Int64);
      Procedure DoOnWorkBegin(ASender : TObject; AWorkMode : TWorkMode; AWorkCountMax : Int64);

    Protected
      Procedure DoRequest(Const AMethod : TIdHTTPMethod;
        AURL : String; ASource, AResponseContent : TStream;
        AIgnoreReplies : Array Of SmallInt); OverRide;

      //IHsIdHTTPEx
      Function  GetOnProgress() : THsIdHTTPExOnProgress;
      Procedure SetOnProgress(Const AValue : THsIdHTTPExOnProgress);

    Public
      Constructor Create(AOwner : TComponent); ReIntroduce;

    End;

  Private
    FIdHttp : THsIdHTTPExImpl;

    Function GetImpl() : THsIdHTTPExImpl;

  Protected
    Property IntfImpl : THsIdHTTPExImpl Read GetImpl Implements IHsIdHTTPEx;

    Procedure Created(); OverRide;

  Public
    Destructor Destroy(); OverRide;

  End;

implementation

Uses SysUtils, Forms;

Procedure THsIdHTTPEx.Created();
Begin
  FIdHttp := THsIdHTTPExImpl.Create(Nil);
End;

Destructor THsIdHTTPEx.Destroy();
Begin
  FreeAndNil(FIdHttp);

  InHerited Destroy();
End;

Function THsIdHTTPEx.GetImpl() : THsIdHTTPExImpl;
Begin
  Result := FIdHttp;
End;

Constructor THsIdHTTPEx.THsIdHTTPExImpl.Create(AOwner : TComponent);
Begin
  InHerited Create(AOwner);

  InHerited OnWork := DoOnWork;
  InHerited OnWorkBegin := DoOnWorkBegin;
End;

Function THsIdHTTPEx.THsIdHTTPExImpl.GetOnProgress() : THsIdHTTPExOnProgress;
Begin
  Result := FOnProgress;
End;

Procedure THsIdHTTPEx.THsIdHTTPExImpl.SetOnProgress(Const AValue : THsIdHTTPExOnProgress);
Begin
  FOnProgress := AValue;
End;

Procedure THsIdHTTPEx.THsIdHTTPExImpl.DoRequest(Const AMethod : TIdHTTPMethod;
  AURL : String; ASource, AResponseContent : TStream;
  AIgnoreReplies : Array Of SmallInt);
Begin
  FFileName := ExtractFileName(StringReplace(AURL, '/', '\', [rfReplaceAll]));
  InHerited DoRequest(AMethod, AURL, ASource, AResponseContent, AIgnoreReplies);
End;

Procedure THsIdHTTPEx.THsIdHTTPExImpl.DoOnWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
Begin
  Application.ProcessMessages();
  If Assigned(FOnProgress) Then
    FOnProgress(FFileName, AWorkCount, FMaxWork);
End;

Procedure THsIdHTTPEx.THsIdHTTPExImpl.DoOnWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
Begin
  FMaxWork := AWorkCountMax;
End;

end.
