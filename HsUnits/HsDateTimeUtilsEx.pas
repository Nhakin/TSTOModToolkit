unit HsDateTimeUtilsEx;

interface

Uses Windows, Controls, HsInterfaceEx;

Type
  IDateTimeEx = Interface(IInterfaceEx)
    ['{4B61686E-29A0-2112-B3C9-F8C762DE40D9}']
    Function  GetDateTime() : TDateTime;
    Procedure SetDateTime(Const ADateTime : TDateTime);

    Function  GetJavaDateTime() : Int64;
    Procedure SetJavaDateTime(AJavaDateTime : Int64);

    Function  GetDate() : TDate;
    Procedure SetDate(Const ADate : TDate);

    Function  GetTime() : TTime;
    Procedure SetTime(Const ATime : TTime);

    Function  GetYear() : Word;
    Procedure SetYear(Const AYear : Word);

    Function  GetMonth() : Word;
    Procedure SetMonth(Const AMonth : Word);

    Function  GetDay() : Word;
    Procedure SetDay(Const ADay : Word);

    Function  GetHour() : Word;
    Procedure SetHour(Const AHour : Word);

    Function  GetMin() : Word;
    Procedure SetMin(Const AMin : Word);

    Function  GetSec() : Word;
    Procedure SetSec(Const ASec : Word);

    Function  GetMSec() : Word;
    Procedure SetMSec(Const AMSec : Word);

    Function  GetEaster() : TDateTime;

    Property DateTime     : TDateTime Read GetDateTime     Write SetDateTime;
    Property JavaDateTime : Int64     Read GetJavaDateTime Write SetJavaDateTime;
    Property Date         : TDate     Read GetDate         Write SetDate;
    Property Time         : TTime     Read GetTime         Write SetTime;
    Property Year         : Word      Read GetYear         Write SetYear;
    Property Month        : Word      Read GetMonth        Write SetMonth;
    Property Day          : Word      Read GetDay          Write SetDay;
    Property Hour         : Word      Read GetHour         Write SetHour;
    Property Min          : Word      Read GetMin          Write SetMin;
    Property Sec          : Word      Read GetSec          Write SetSec;
    Property MSec         : Word      Read GetMSec         Write SetMSec;
    Property Easter       : TDateTime Read GetEaster;

  End;

  IDateTimeExs = Interface(IInterfaceListEx)
    ['{4B61686E-29A0-2112-B411-19ED2FDDEA41}']
    Function  Get(Index : Integer) : IDateTimeEx;
    Procedure Put(Index : Integer; Const Item : IDateTimeEx);

    Function Add() : IDateTimeEx; OverLoad;
    Function Add(Const AItem : IDateTimeEx) : Integer; OverLoad;

    Property Items[Index : Integer] : IDateTimeEx Read Get Write Put; Default;

  End;  

Function FileTimeToDateTime(Const AFileTime : TFileTime) : TDateTime;
Function GetFileCreationDate(Const AFileName : String) : TDateTime;
Function GetFileModificationDate(Const AFileName : String) : TDateTime;
Function JavaToDelphiDateTime(Const AJavaDate : Int64) : TDateTime;
Function DelphiToJavaDateTime(Const ADelphiDate : TDateTime) : Int64;

implementation

Uses SysUtils, DateUtils;//, JclDateTime;

Type
  TDateTimeExImpl = Class(TInterfacedObjectEx, IDateTimeEx)
  Private
    FDateTime  : TDateTime;

  Protected
    Function  GetDateTime() : TDateTime;
    Procedure SetDateTime(Const ADateTime : TDateTime);
    Function  GetJavaDateTime() : Int64;
    Procedure SetJavaDateTime(AJavaDateTime : Int64);
    Procedure SetDate(Const ADate : TDate);
    Function  GetDate() : TDate;
    Procedure SetTime(Const ATime : TTime);
    Function  GetTime() : TTime;
    Procedure SetYear(Const AYear : Word);
    Function  GetYear() : Word;
    Procedure SetMonth(Const AMonth : Word);
    Function  GetMonth() : Word;
    Procedure SetDay(Const ADay : Word);
    Function  GetDay() : Word;
    Procedure SetHour(Const AHour : Word);
    Function  GetHour() : Word;
    Procedure SetMin(Const AMin : Word);
    Function  GetMin() : Word;
    Procedure SetSec(Const ASec : Word);
    Function  GetSec() : Word;
    Procedure SetMSec(Const AMSec : Word);
    Function  GetMSec() : Word;

    Function GetEaster() : TDateTime;

  Public
    Function GetAge() : Integer; OverLoad;
    Function GetAge(ADate : TDateTime) : Integer; OverLoad;

    Function GetFirstDayOfMonth() : TDateTime; OverLoad;
    Function GetFirstDayOfMonth(Const ADay : Integer) : TDateTime; OverLoad;

    Constructor Create(Const ADate : TDateTime); ReIntroduce; OverLoad;
    Constructor Create(Const AYear, AMonth, ADay, AHour, AMin, ASec, AMsec : Word); OverLoad;
    Constructor Create(Const AYear, AMonth, ADay : Word); OverLoad;

  End;

  TDateTimeExs = Class(TInterfaceListEx, IDateTimeExs)
  Protected
    Function GetItemClass() : TInterfacedObjectExClass; OverRide;
    Function  Get(Index : Integer) : IDateTimeEx; OverLoad;
    Procedure Put(Index : Integer; Const Item : IDateTimeEx); OverLoad;

    Function Add() : IDateTimeEx; OverLoad;
    Function Add(Const AItem : IDateTimeEx) : Integer; OverLoad;

  End;  

(******************************************************************************)

Function DayLightCompareDate(Const ADate : PSystemTime; Const ACompareDate : PSystemTime) : Integer;
Var lLimitDay    , 
    lDayInSecs   , 
    lWeekOfMonth : Integer;
    lFirstDay    : Word;
Begin
  If ADate^.wMonth < ACompareDate^.wMonth Then
    Result := -1 (* We are in a month before the date limit. *)
  Else
  Begin
    If ADate^.wMonth > ACompareDate^.wMonth Then
      Result := 1 (* We are in a month after the date limit. *)
    Else
    Begin
      (* if year is 0 then date is in day-of-week format, otherwise
       * it's absolute date.
       *)
      If ACompareDate^.wYear = 0 Then
      Begin
        (* compareDate.wDay is interpreted as number of the week in the month
         * 5 means: the last week in the month *)
        lWeekOfMonth := ACompareDate^.wDay;
        (* calculate the day of the first DayOfWeek in the month *)
        lFirstDay := (6 + ACompareDate^.wDayOfWeek - ADate^.wDayOfWeek + ADate^.wDay) Mod 7 + 1;
        lLimitDay := lFirstDay + 7 * (lWeekOfMonth - 1);

        (* check needed for the 5th weekday of the month *)
        If (lLimitDay > MonthDays[(ADate^.wMonth=2) And IsLeapYear(ADate^.wYear)][ADate^.wMonth - 1]) Then
          Dec(lLimitDay, 7);
      End
      Else
        lLimitDay := ACompareDate^.wDay;

      (* convert to seconds *)
      lLimitDay  := ((lLimitDay * 24  + ACompareDate^.wHour) * 60 + ACompareDate^.wMinute) * 60;
      lDayInSecs := ((ADate^.wDay * 24  + ADate^.wHour) * 60 + ADate^.wMinute) * 60 + ADate^.wSecond;
      (* and compare *)

      If lDayInSecs < lLimitDay Then
        Result :=  -1
      Else If lDayInSecs > lLimitDay Then
        Result :=  1
      Else
        Result :=  0; (* date is equal to the date limit. *)
    End;
  End;
End;

Function CompTimeZoneID(Const pTZinfo: PTimeZoneInformation;
  lpFileTime: PFileTime; islocal: Boolean): Longword;
Var ret                : Integer;
    beforeStandardDate , 
    afterDaylightDate  : Boolean;
    llTime             : Int64;
    SysTime            : TSystemTime;
    ftTemp             : TFileTime;
Begin
  llTime := 0;

  If pTZinfo^.DaylightDate.wMonth <> 0 Then
  Begin
    (* if year is 0 then date is in day-of-week format, otherwise
     * it's absolute date.
     *)
    If (pTZinfo^.StandardDate.wMonth = 0) Or
       (
         (pTZinfo^.StandardDate.wYear = 0) And
         (
           (pTZinfo^.StandardDate.wDay < 1) Or
           (pTZinfo^.StandardDate.wDay > 5) Or
           (pTZinfo^.DaylightDate.wDay < 1) Or
           (pTZinfo^.DaylightDate.wDay > 5)
         )
       ) Then
    Begin
      SetLastError(ERROR_INVALID_PARAMETER);
      Result := TIME_ZONE_ID_INVALID;
    End
    Else
    Begin
      If Not islocal Then
      Begin
        llTime := PInt64(lpFileTime)^;
        Dec(llTime, Int64(pTZinfo^.Bias + pTZinfo^.DaylightBias) * 600000000);
        PInt64(@ftTemp)^ := llTime;
        lpFileTime := @ftTemp;
      End;

      FileTimeToSystemTime(lpFileTime^, SysTime);

      (* check for daylight savings *)
      ret := DayLightCompareDate(@SysTime, @pTZinfo^.StandardDate);
      If ret = -2 Then
        Result := TIME_ZONE_ID_INVALID
      Else
      Begin
        beforeStandardDate := ret < 0;

        If Not islocal Then
        Begin
          Dec(llTime, Int64(pTZinfo^.StandardBias - pTZinfo^.DaylightBias) * 600000000);
          PInt64(@ftTemp)^ := llTime;
          FileTimeToSystemTime(lpFileTime^, SysTime);
        End;

        ret := DayLightCompareDate(@SysTime, @pTZinfo^.DaylightDate);
        If ret = -2 Then
          Result := TIME_ZONE_ID_INVALID
        Else
        Begin
          afterDaylightDate := ret >= 0;

          Result := TIME_ZONE_ID_STANDARD;
          If pTZinfo^.DaylightDate.wMonth < pTZinfo^.StandardDate.wMonth Then
          Begin
            (* Northern hemisphere *)
            If beforeStandardDate And afterDaylightDate Then
              Result := TIME_ZONE_ID_DAYLIGHT;
          End
          Else If beforeStandardDate Or afterDaylightDate Then (* Down south *)
            Result := TIME_ZONE_ID_DAYLIGHT;
        End;
      End;
    End;
  End
  Else (* No transition date *)
    Result := TIME_ZONE_ID_UNKNOWN;
End;

Function GetTimezoneBias(Const pTZinfo: PTimeZoneInformation;
  lpFileTime: PFileTime; islocal: Boolean; pBias: PLongint): Boolean;
Var bias : Longint;
    tzid : Longword;
Begin
  Result := False;
  bias   := pTZinfo^.Bias;
  tzid   := CompTimeZoneID(pTZinfo, lpFileTime, islocal);

  If tzid <> TIME_ZONE_ID_INVALID Then
  Begin
    If (tzid = TIME_ZONE_ID_DAYLIGHT) Then
      Inc(bias, pTZinfo^.DaylightBias)
    Else If (tzid = TIME_ZONE_ID_STANDARD) Then
      Inc(bias, pTZinfo^.StandardBias);

    pBias^ := bias;
    Result := True;
  End;
End;

Function SystemTimeToTzSpecificLocalTime(
  lpTimeZoneInformation: PTimeZoneInformation;
  lpUniversalTime, lpLocalTime: PSystemTime): BOOL;
Var ft     : TFileTime;
    lBias  : Longint;
    llTime : Int64;
    tzinfo : TTimeZoneInformation;
Begin
  Result := False;

  If lpTimeZoneInformation <> Nil Then
    tzinfo := lpTimeZoneInformation^
  Else If GetTimeZoneInformation(tzinfo) = TIME_ZONE_ID_INVALID Then
  Begin
    Result := False;
    Exit;
  End;

  If SystemTimeToFileTime(lpUniversalTime^, ft) Then
  Begin
    llTime := PInt64(@ft)^;

    If GetTimezoneBias(@tzinfo, @ft, False, @lBias) Then
    Begin
      (* convert minutes to 100-nanoseconds-ticks *)
      Dec(llTime, Int64(lBias) * 600000000);
      PInt64(@ft)^ := llTime;
      Result := FileTimeToSystemTime(ft, lpLocalTime^);
    End;
  End;
End;

Function TzSpecificLocalTimeToSystemTime(
  Const lpTimeZoneInformation: PTimeZoneInformation;
  Const lpLocalTime: PSystemTime; lpUniversalTime: PSystemTime): BOOL;
Var ft     : TFileTime;
    lBias  : Longint;
    t      : Int64;
    tzinfo : TTimeZoneInformation;
Begin
  Result := False;

  If lpTimeZoneInformation <> Nil Then
    tzinfo := lpTimeZoneInformation^
  Else If GetTimeZoneInformation(tzinfo) = TIME_ZONE_ID_INVALID Then
  Begin
    Result := False;
    Exit;
  End;

  If SystemTimeToFileTime(lpLocalTime^, ft) Then
  Begin
    t := PInt64(@ft)^;

    If GetTimezoneBias(@tzinfo, @ft, True, @lBias) Then
    Begin
      (* convert minutes to 100-nanoseconds-ticks *)
      Inc(t, Int64(lBias) * 600000000);
      PInt64(@ft)^ := t;
      Result := FileTimeToSystemTime(ft, lpUniversalTime^);
    End;
  End;
End;

(******************************************************************************)

Function FileTimeToDateTime(Const AFileTime : TFileTime) : TDateTime;
Var SystemTime ,
    LocalTime  : TSystemTime;
Begin
  If Not FileTimeToSystemTime(AFileTime, SystemTime) Then
    RaiseLastOSError;
  If Not SystemTimeToTzSpecificLocalTime(Nil, @SystemTime, @LocalTime) Then
    RaiseLastOSError;
  Result := SystemTimeToDateTime(LocalTime);
End;

Function GetFileCreationDate(Const AFileName : String) : TDateTime;
Var fad  : TWin32FileAttributeData;
Begin
  If Not GetFileAttributesEx(PChar(AFileName), GetFileExInfoStandard, @fad) Then
    RaiseLastOSError;
  Result := FileTimeToDateTime(fad.ftCreationTime);
End;

Function GetFileModificationDate(Const AFileName : String) : TDateTime;
Var fad  : TWin32FileAttributeData;
Begin
  If Not GetFileAttributesEx(PChar(AFileName), GetFileExInfoStandard, @fad) Then
    RaiseLastOSError;
  Result := FileTimeToDateTime(fad.ftLastWriteTime);
End;

Function JavaToDelphiDateTime(Const AJavaDate : Int64): TDateTime;
Var t : TSystemTime;
Begin
  DateTimeToSystemTime(25569 + (AJavaDate / 86400000), t);
  SystemTimeToTzSpecificLocalTime(Nil, @t, @t);
  Result := SystemTimeToDateTime(t);
End;

Function DelphiToJavaDateTime(Const ADelphiDate : TDateTime): Int64;
Var t : TSystemTime;
Begin
  DateTimeToSystemTime(ADelphiDate, t);
  TzSpecificLocalTimeToSystemTime(Nil, @t, @t);
  Result := Round((SystemTimeToDateTime(t) - 25569) * 86400000)
End;

(******************************************************************************)

Constructor TDateTimeExImpl.Create(Const ADate : TDateTime);
Begin
  InHerited Create();

  FDateTime := ADate;
End;

Constructor TDateTimeExImpl.Create(Const AYear, AMonth, ADay, AHour, AMin, ASec, AMsec : Word);
Begin
  Create(EncodeDateTime(AYear, AMonth, ADay, AHour, AMin, ASec, AMsec));
End;

Constructor TDateTimeExImpl.Create(Const AYear, AMonth, ADay : Word);
Begin
  Create(EncodeDate(AYear, AMonth, ADay));
End;

Function TDateTimeExImpl.GetDateTime() : TDateTime;
Begin
  Result := FDateTime;
End;

Procedure TDateTimeExImpl.SetDateTime(Const ADateTime : TDateTime);
Begin
  If FDateTime <> ADateTime Then
    FDateTime := ADateTime;
End;

Function TDateTimeExImpl.GetJavaDateTime() : Int64;
Var t : TSystemTime;
Begin
  DateTimeToSystemTime(FDateTime, t);
  TzSpecificLocalTimeToSystemTime(Nil, @t, @t);
  Result := Round((SystemTimeToDateTime(t) - 25569) * 86400000)
End;

Procedure TDateTimeExImpl.SetJavaDateTime(AJavaDateTime : Int64);
Var t : TSystemTime;
Begin
  DateTimeToSystemTime(25569 + (AJavaDateTime / 86400000), t);
  SystemTimeToTzSpecificLocalTime(Nil, @t, @t);
  FDateTime := SystemTimeToDateTime(t);
End;

Procedure TDateTimeExImpl.SetDate(Const ADate : TDate);
Begin
  If Date <> ADate Then
    ReplaceDate(FDateTime, ADate);
End;

Function TDateTimeExImpl.GetDate() : TDate;
Begin
  Result := DateOf(FDateTime);
End;

Procedure TDateTimeExImpl.SetTime(Const ATime : TTime);
Begin
  If Time <> ATime Then
    ReplaceTime(FDateTime, ATime);
End;

Function TDateTimeExImpl.GetTime() : TTime;
Begin
  Result := TimeOf(FDateTime);
End;

Procedure TDateTimeExImpl.SetYear(Const AYear : Word);
Begin
  If GetYear() <> AYear Then
    RecodeYear(FDateTime, AYear);
End;

Function TDateTimeExImpl.GetYear() : Word;
Begin
  Result := YearOf(FDateTime);
End;

Procedure TDateTimeExImpl.SetMonth(Const AMonth : Word);
Begin
  If GetMonth() <> AMonth Then
    RecodeMonth(FDateTime, AMonth);
End;

Function TDateTimeExImpl.GetMonth() : Word;
Begin
  Result := MonthOf(FDateTime);
End;

Procedure TDateTimeExImpl.SetDay(Const ADay : Word);
Begin
  If GetDay() <> ADay Then
    RecodeDay(FDateTime, ADay);
End;

Function TDateTimeExImpl.GetDay() : Word;
Begin
  Result := DayOf(FDateTime);
End;

Procedure TDateTimeExImpl.SetHour(Const AHour : Word);
Begin
  If GetHour() <> AHour Then
    RecodeHour(FDateTime, AHour);
End;

Function TDateTimeExImpl.GetHour() : Word;
Begin
  Result := HourOf(FDateTime);
End;

Procedure TDateTimeExImpl.SetMin(Const AMin : Word);
Begin
  If GetMin() <> AMin Then
    RecodeMinute(FDateTime, AMin);
End;

Function TDateTimeExImpl.GetMin() : Word;
Begin
  Result := MinuteOf(FDateTime);
End;

Procedure TDateTimeExImpl.SetSec(Const ASec : Word);
Begin
  If GetSec() <> ASec Then
    RecodeSecond(FDateTime, ASec);
End;

Function TDateTimeExImpl.GetSec() : Word;
Begin
  Result := SecondOf(FDateTime);
End;

Procedure TDateTimeExImpl.SetMSec(Const AMSec : Word);
Begin
  If GetMSec() <> AMSec Then
    RecodeMilliSecond(FDateTime, AMSec);
End;

Function TDateTimeExImpl.GetMSec() : Word;
Begin
  Result := MilliSecondOf(FDateTime);
End;

Function TDateTimeExImpl.GetAge(ADate : TDateTime) : Integer;
Var lCurDate : IDateTimeEx;
Begin
  lCurDate := TDateTimeExImpl.Create(ADate);
  Try
    Result := lCurDate.Year - GetYear();

    If (lCurDate.Month < GetMonth()) Or ((lCurDate.Month = GetMonth()) And (lCurDate.Day < GetDay())) Then
      Dec(Result);

    Finally
      lCurDate := Nil;
  End;
End;

Function TDateTimeExImpl.GetAge() : Integer;
Begin
  Result := GetAge(Now());
End;

Function TDateTimeExImpl.GetFirstDayOfMonth() : TDateTime;
Begin
  Result := RecodeDay(FDateTime, 1);
End;

Function TDateTimeExImpl.GetFirstDayOfMonth(Const ADay : Integer) : TDateTime;
Var lCurDay : Integer;
Begin
  Result := RecodeDay(FDateTime, 1);
  lCurDay := DayOfTheWeek(Result);
  If lCurDay <> ADay Then
    Result := IncDay(Result, 8-lCurDay);
End;

Function TDateTimeExImpl.GetEaster() : TDateTime;
Var Y, H, I : Integer;
Begin
  Y := GetYear();

  H := (Y Mod 19 * 19 + Y Div 100 - Y Div 100 Div 4 - (8 * Y Div 100 + 13) Div 25 + 15) Mod 30;
  I := (H Div 28 * 29 Div (H + 1) * (21 - Y Mod 19) Div 11 - 1) * H Div 28 + H;

  Result := IncDay(EncodeDate(Y, 02, DaysInAMonth(Y, 2)),
             28 + I - (Y Div 4 + Y + I + 2 + Y Div 100 Div 4 - Y Div 100) Mod 7);
End;

Function TDateTimeExs.GetItemClass() : TInterfacedObjectExClass;
Begin
//  Result := TDateTimeEx;
End;

Function TDateTimeExs.Get(Index : Integer) : IDateTimeEx;
Begin
  Result := InHerited Items[Index] As IDateTimeEx;
End;

Procedure TDateTimeExs.Put(Index : Integer; Const Item : IDateTimeEx);
Begin
  InHerited Items[Index] := Item;
End;

Function TDateTimeExs.Add() : IDateTimeEx;
Begin
  Result := InHerited Add() As IDateTimeEx;
End;

Function TDateTimeExs.Add(Const AItem : IDateTimeEx) : Integer;
Begin
  Result := InHerited Add(AItem);
End;

end.
