Unit HsAlarmEx;

Interface

Uses Classes, SysUtils, ExtCtrls;

Type
  THsTriggerKind = ( tkOneShot, tkEachSecond, tkEachMinute, tkEachHour,
                     tkEachDay, tkEachMonth, tkEachYear );

  THsAlarmItemEx = Class(TCollectionItem)
  Private
    FName : String;
    FTime : TDateTime;
    FKind : THsTriggerKind;

    FOnExecute : TNotifyEvent;
    FOnSetTime : TNotifyEvent;
    FLastExecute : TDateTime;

    Procedure SetTime(Const ATime : TDateTime);

  Protected
    Procedure DoOnExecute(); Virtual;

  Published
    Property Name : String         Read FName Write FName;
    Property Time : TDateTime      Read FTime Write SetTime;
    Property Kind : THsTriggerKind Read FKind Write FKind;

    Property OnExecute  : TNotifyEvent Read FOnExecute Write FOnExecute;
    Property OnSetTime  : TNotifyEvent Read FOnSetTime Write FOnSetTime;

    Property LastExecute : TDateTime    Read FLastExecute;
    
  Public
    Procedure Assign(Source : TPersistent); OverRide;

    Procedure Execute();

    Constructor Create(Collection: TCollection); OverRide;

  End;

  THsAlarmItemsEx = Class(TOwnedCollection)
  Private
    Function  GetItems(Index: Integer) : THsAlarmItemEx;
    Procedure SetItems(Index: Integer; Const Value: THsAlarmItemEx);

  Public
    Property Items[Index : Integer]: THsAlarmItemEx Read GetItems Write SetItems; Default;

    Function  Add() : THsAlarmItemEx;
    Procedure Assign(Source: TPersistent); OverRide;

    Constructor Create(AOwner: TPersistent);

  End;

  THsAlarmsEx = Class(TComponent)
  Private
    FActive  : Boolean;
    FLast    : TTimeStamp;
    FRunning : Boolean;
    FTimer   : TTimer;
    FAlarms  : THsAlarmItemsEx;

    Procedure OnTimer(Sender: TObject);
    Procedure SetActive(Const Value: Boolean);
    Procedure SetAlarms(Const Value: THsAlarmItemsEx);

  Protected
    Procedure ResetAlarms();

  Published
    Property Alarms  : THsAlarmItemsEx Read FAlarms  Write SetAlarms;
    Property Active  : Boolean         Read FActive  Write SetActive Default False;

  Public
    Property Running : Boolean Read FRunning;

    Procedure Add(Const AName: String; Const ATime: TDateTime; Const AKind: THsTriggerKind = tkOneShot);
    Procedure Delete(Const Idx: Cardinal);

    Constructor Create(AOwner: TComponent); OverRide;
    Destructor Destroy(); OverRide;

  End;

Implementation

Uses Variants, DateUtils;

Constructor THsAlarmsEx.Create(AOwner: TComponent);
Begin
  Inherited Create(AOwner);

  FAlarms         := THsAlarmItemsEx.Create(Self);
  FActive         := False;
  FRunning        := False;
  FTimer          := TTimer.Create(Self);
  FTimer.Interval := 500;
  FTimer.OnTimer  := OnTimer;
  FTimer.Enabled  := False;
  FLast           := DateTimeToTimeStamp(Now);
End;

Destructor THsAlarmsEx.Destroy;
Begin
  FAlarms.Free();
  FTimer.Free();

  Inherited Destroy();
End;

Procedure THsAlarmsEx.Add(Const AName: String; Const ATime: TDateTime; Const AKind: THsTriggerKind);
Begin
  If (ATime >= Now) Or (AKind <> tkOneShot) Then
  Begin
    With Alarms.Add() Do
    Begin
      Name := AName;
      Time := ATime;
      Kind := AKind;
    End;

    FRunning       := Active;
    FTimer.Enabled := Running;
  End;
End;

Procedure THsAlarmsEx.Delete(Const Idx: Cardinal);
Begin
  Alarms.Delete(Idx);

  FRunning := Active And (Alarms.Count > 0);
End;

Const
  MSecsPerMin = MSecsPerSec * SecsPerMin;
  MSecsPerHour = MSecsPerMin * MinsPerHour;

Procedure THsAlarmsEx.OnTimer(Sender: TObject);
Var X                : Cardinal;
    lCurrent         : TDateTime;
    lStamp           : TTimeStamp;
    Year, Month, Day : Word;
    lAlarm           : THsAlarmItemEx;
Begin
  Active := False;
  Try
    If Alarms.Count >= 0 Then
    Begin
      lCurrent := Now;
      lStamp   := DateTimeToTimeStamp(lCurrent);

      // sort out delayed Timer events which may arrive in bunches
      If ((lStamp.Time - FLast.Time) >= 1000) Or (lStamp.Date > FLast.Date) Then
      Begin
        FLast := lStamp;
        For X := Alarms.Count - 1 DownTo 0 Do
        Begin
          lAlarm := Alarms[X];

          If lCurrent >= lAlarm.Time Then
          Begin
            lAlarm.Execute();
            lStamp := DateTimeToTimeStamp(lAlarm.Time);

            Case lAlarm.Kind Of
              tkOneShot: ;
              tkEachSecond: Inc(lStamp.Time, MSecsPerSec);
              tkEachMinute: Inc(lStamp.Time, MSecsPerMin);
              tkEachHour: Inc(lStamp.Time, MSecsPerHour);
              tkEachDay: Inc(lStamp.Date);
              tkEachMonth: lStamp := DateTimeToTimeStamp(IncMonth(lAlarm.Time, 1));
              tkEachYear:
              Begin
                DecodeDate(lCurrent, Year, Month, Day);
                Inc(lStamp.Date, DaysPerYear[IsLeapYear(Year)]);
              End;
            End;

            If lStamp.Time > MSecsPerDay Then
            Begin
              Inc(lStamp.Date);
              Dec(lStamp.Time, MSecsPerDay);
            End;

            If lAlarm.Kind <> tkOneShot Then
            Begin
              lAlarm.Time := TimeStampToDateTime(lStamp)
            End
            Else
              Delete(X);
          End;
        End;
      End;
    End;

    Finally
      Active := True;
  End;
End;

Procedure THsAlarmsEx.SetActive(Const Value: Boolean);
Begin
  FActive  := Value;
  FRunning := FActive And (Alarms.Count > 0);

  If FRunning Then
    ResetAlarms();

  FTimer.Enabled := Running;
End;

Procedure THsAlarmsEx.SetAlarms(Const Value: THsAlarmItemsEx);
Begin
  FAlarms.Assign(Value);
End;

Procedure THsAlarmsEx.ResetAlarms();
  Function MaxDate(Val1, Val2: TDateTime) : TDateTime;
  Begin
    Result := Val1;
    If Val2 > Val1 Then
      Result := Val2;
  End;

Var X        : Integer;
    lCurTime : TDateTime;
Begin
  lCurTime := Now();

  For X := 0 To Alarms.Count - 1 Do
    Alarms[X].Time := MaxDate(lCurTime, Alarms[X].Time);
End;

(******************************************************************************)

Constructor THsAlarmItemsEx.Create(AOwner: TPersistent);
Begin
  Inherited Create(AOwner, THsAlarmItemEx);
End;

Function THsAlarmItemsEx.Add() : THsAlarmItemEx;
Begin
  Result := THsAlarmItemEx(Inherited Add());
End;

Procedure THsAlarmItemsEx.Assign(Source: TPersistent);
Var X : Integer;
Begin
  If Source Is THsAlarmItemsEx Then
  Begin
    Clear();

    For X := 0 To THsAlarmItemsEx(Source).Count - 1 Do
      Add.Assign(THsAlarmItemsEx(Source).Items[X]);
  End
  Else
    Inherited Assign(Source);
End;

Function THsAlarmItemsEx.GetItems(Index: Integer) : THsAlarmItemEx;
Begin
  Result := THsAlarmItemEx(Inherited Items[Index]);
End;

Procedure THsAlarmItemsEx.SetItems(Index: Integer; Const Value: THsAlarmItemEx);
Begin
  Inherited Items[Index] := Value;
End;

(******************************************************************************)

Constructor THsAlarmItemEx.Create(Collection: TCollection);
Begin
  InHerited Create(Collection);

  FLastExecute := 0;
End;

Procedure THsAlarmItemEx.SetTime(Const ATime : TDateTime);
Begin
  If FTime <> ATime Then
  Begin
    FTime := ATime;

    If Assigned(FOnSetTime) Then
      FOnSetTime(Self);
  End;
End;

Procedure THsAlarmItemEx.DoOnExecute();
Begin
  If Assigned(FOnExecute) Then
  Begin
    Try
      FOnExecute(Self);
      FLastExecute := Now();

      Except
        FLastExecute := 0;
    End;
  End;
End;

Procedure THsAlarmItemEx.Execute();
Begin
  DoOnExecute();
End;

Procedure THsAlarmItemEx.Assign(Source: TPersistent);
Begin
  If Source Is THsAlarmItemEx Then
  Begin
    Name      := THsAlarmItemEx(Source).Name;
    Time      := THsAlarmItemEx(Source).Time;
    Kind      := THsAlarmItemEx(Source).Kind;
    OnExecute := THsAlarmItemEx(Source).OnExecute;
  End
  Else
    Inherited Assign(Source);
End;

{
  FLogDelay := 5;
  FSaveLog  := THsJvAlarms.Create(Self);

  DecodeTime(Now(), hh, mm, Dummy, Dummy);
  mm := (mm Div FLogDelay * FLogDelay) + FLogDelay;

  While mm >= 60 Do
  Begin
    hh := hh + 1;
    mm := mm - 60;
  End;

  With FSaveLog.Alarms.Add() Do
  Begin
    Name := 'DoSaveLog';
    Time := RecodeTime(Now(), hh, mm, 0, 0);
    OnExecute := DoSaveLogExecute;
  End;

Procedure TTmhoTCPServer.DoSaveLogExecute(Sender : TObject);
Var lAlarm : THsJvAlarmItem;
Begin
  SaveLog();

  lAlarm := FSaveLog.Alarms.Add();
  With lAlarm Do
  Begin
    Assign(THsJvAlarmItem(Sender));
    lAlarm.Time := IncMinute(lAlarm.Time, FLogDelay);
  End;
End;  
}

End.

