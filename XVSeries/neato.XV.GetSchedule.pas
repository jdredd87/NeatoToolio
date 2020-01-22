unit neato.XV.GetSchedule;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors, neato.helpers, system.dateutils;

const

  // Command to send
  sGetSchedule = 'GetSchedule';

  sSchedule_is_Enabled = 'Schedule is Enabled';
  sSchedule_is = 'Schedule is';
  sSun = 'Sun';
  sMon = 'Mon';
  sTue = 'Tue';
  sWed = 'Wed';
  sThu = 'Thu';
  sFri = 'Fri';
  sSat = 'Sat';

type

  TTimeXVRec = record
    sDay: string;
    sTime: TTime; // military time
    sSet: boolean; // is it set
    sRaw: string; // raw value
    procedure reset;
    function parsetext(text: string): boolean;
  end;

  tGetScheduleXV = class(tNeatoBaseCommand)
  strict private
    fScheduleIS: boolean;
    fSun: TTimeXVRec;
    fMon: TTimeXVRec;
    fTue: TTimeXVRec;
    fWed: TTimeXVRec;
    fThu: TTimeXVRec;
    fFri: TTimeXVRec;
    fSat: TTimeXVRec;
  public
    constructor Create;
    destructor Destroy; override;
    procedure reset; override;
    function parsetext(data: tstringlist): boolean; override;
    property ScheduleIS: boolean read fScheduleIS write fScheduleIS;

    property Sun: TTimeXVRec read fSun write fSun;
    property Mon: TTimeXVRec read fMon write fMon;
    property Tue: TTimeXVRec read fTue write fTue;
    property Wed: TTimeXVRec read fWed write fWed;
    property Thu: TTimeXVRec read fThu write fThu;
    property Fri: TTimeXVRec read fFri write fFri;
    property Sat: TTimeXVRec read fSat write fSat;
  end;

  {


    Schedule is Enabled
    Sun 20:30 H
    Mon 20:30 H
    Tue 05:30 H
    Wed 01:30 H
    Thu 00:00 - None -
    Fri 00:00 - None -
    Sat 19:30 H


  }
implementation

procedure TTimeXVRec.reset;
begin
  self.sTime := strtotime('00:00:00');
  self.sSet := false;
  self.sRaw := '';
end;

function TTimeXVRec.parsetext(text: string): boolean;
var
  data: tstringlist;
begin
  reset;
  self.sRaw := text;
  data := tstringlist.Create;
  data.CaseSensitive := false;
  data.Delimiter := ' ';
  data.StrictDelimiter := true;
  text := stringreplace(text, '- None -', '-None-', [rfreplaceall, rfignorecase]);
  text := stringreplace(text, '=', ' ', []);
  data.DelimitedText := text;

  if data.Count = 2 then
  begin
    sTime := strtotime(data[0]);
    sSet := pos('None', data[1]) = 0;
  end;

end;

Constructor tGetScheduleXV.Create;
begin
  inherited;
  fCommand := sGetSchedule;
  fDescription := 'Get Cleaning Schedule';
  reset;
end;

Destructor tGetScheduleXV.Destroy;
begin
  inherited;
end;

procedure tGetScheduleXV.reset;
begin
  fScheduleIS := false;
  fSun.reset;
  fMon.reset;
  fTue.reset;
  fWed.reset;
  fThu.reset;
  fFri.reset;
  fSat.reset;
  inherited;
end;

function tGetScheduleXV.parsetext(data: tstringlist): boolean;
begin
  reset;
  result := false;

  if NOT assigned(data) then
    exit;

  // Simple test to make sure we got data

  data.CaseSensitive := false;
  data.text := stringreplace(data.text, ',', '=', [rfreplaceall]);
  // looks like no spaces in the data but lets make sure

  if pos(sSchedule_is, data.text) > 0 then
  begin
    data.text := stringreplace(data.text, sSun + ' ', sSun + '=', [rfignorecase]);
    data.text := stringreplace(data.text, sMon + ' ', sMon + '=', [rfignorecase]);
    data.text := stringreplace(data.text, sTue + ' ', sTue + '=', [rfignorecase]);
    data.text := stringreplace(data.text, sWed + ' ', sWed + '=', [rfignorecase]);
    data.text := stringreplace(data.text, sThu + ' ', sThu + '=', [rfignorecase]);
    data.text := stringreplace(data.text, sFri + ' ', sFri + '=', [rfignorecase]);
    data.text := stringreplace(data.text, sSat + ' ', sSat + '=', [rfignorecase]);

    fScheduleIS := pos(sSchedule_is_Enabled, data.text) > 0;

    fSun.parsetext(data.Values[sSun]);
    fMon.parsetext(data.Values[sMon]);
    fTue.parsetext(data.Values[sTue]);
    fWed.parsetext(data.Values[sWed]);
    fThu.parsetext(data.Values[sThu]);
    fFri.parsetext(data.Values[sFri]);
    fSat.parsetext(data.Values[sSat]);

    result := true;
  end
  else
  begin
    fError := strParseTextError;
    result := false;
  end;

end;

end.
