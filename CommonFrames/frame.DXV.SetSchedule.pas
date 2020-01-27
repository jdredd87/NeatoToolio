unit frame.XV.GetSchedule;

{

SETSCHEDULE 1 12 12 F
SetSchedule: Unrecognized Option 'F'
SetSchedule - Modify Cleaning Schedule.
    Day - Day of the week to schedule cleaning for. Sun=0,Sat=6. (required)
    Hour - Hour value 0..23 (required)
    Min - Minutes value 0..59 (required)
    House - Schedule to Clean whole house (default)
(Mutually exclusive with None)
    None - Remove Scheduled Cleaning for specified day. Time is ignored.
(Mutually exclusive with House)
    ON - Enable Scheduled cleanings (Mutually exclusive with OFF)
    OFF - Disable Scheduled cleanings (Mutually exclusive with ON)

SETSCHEDULE 0 12 12 HOUSE
Schedule is Enabled
Sun 12:12 H

SETSCHEDULE 0 12 12 NONE
Schedule is Enabled
Sun 00:00 - None -

SETSCHEDULE 0 00 00 ON     // one must be on for schedule to be enabled
Schedule is Enabled
Sun 00:00 H
 }

interface

uses
  dmCommon,
  neato.XV.SetSchedule,FMX.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.DateTimeCtrls, FMX.Objects;

type
  TframeXVSetSchedule = class(TFrame)
    lblGetScheduleScheduleIs: TLabel;
    swGetScheduleScheduleIsValue: TSwitch;
    ckGetScheduleSun: TCheckBox;
    ckGetScheduleMon: TCheckBox;
    ckGetScheduleTue: TCheckBox;
    ckGetScheduleWed: TCheckBox;
    ckGetScheduleThu: TCheckBox;
    ckGetScheduleFri: TCheckBox;
    ckGetScheduleSat: TCheckBox;
    rectThu: TRectangle;
    lblGetScheduleThuValue: TLabel;
    rectFri: TRectangle;
    lblGetScheduleFriValue: TLabel;
    rectSat: TRectangle;
    lblGetScheduleSatValue: TLabel;
    rectMon: TRectangle;
    lblGetScheduleMonValue: TLabel;
    rectTue: TRectangle;
    lblGetScheduleTueValue: TLabel;
    rectWed: TRectangle;
    lblGetScheduleWedValue: TLabel;
    rectSun: TRectangle;
    lblGetScheduleSunValue: TLabel;
    procedure timer_GetDataTimer(Sender: TObject);
  private
    { Private declarations }
  public
   Tab : TTabItem;
  end;

implementation

{$R *.fmx}

procedure TframeXVSetSchedule.timer_GetDataTimer(Sender: TObject);
var
  pGetSchedule: tGetScheduleXV;
  pReadData: TStringList;
  r: Boolean;
begin

  if (dm.com.Serial.Active = false) or (dm.ActiveTab<>Tab) then
  begin
    timer_GetData.Enabled := false;
    exit;
  end;

  pGetSchedule := tGetScheduleXV.Create;

  pReadData := TStringList.Create;
  pReadData.Text := dm.com.SendCommand(sGetSchedule);

  r := pGetSchedule.ParseText(pReadData);

  if r then
  begin
    swGetScheduleScheduleIsValue.IsChecked := pGetSchedule.ScheduleIS;
    ckGetScheduleSun.IsChecked := pGetSchedule.Sun.sSet;
    ckGetScheduleMon.IsChecked := pGetSchedule.Mon.sSet;
    ckGetScheduleTue.IsChecked := pGetSchedule.Tue.sSet;
    ckGetScheduleWed.IsChecked := pGetSchedule.Wed.sSet;
    ckGetScheduleThu.IsChecked := pGetSchedule.Thu.sSet;
    ckGetScheduleFri.IsChecked := pGetSchedule.Fri.sSet;
    ckGetScheduleSat.IsChecked := pGetSchedule.Sat.sSet;

    lblGetScheduleSunValue.Text := formatdatetime('hh:mm AM/PM', pGetSchedule.Sun.sTime);
    lblGetScheduleMonValue.Text := formatdatetime('hh:mm AM/PM', pGetSchedule.Mon.sTime);
    lblGetScheduleTueValue.Text := formatdatetime('hh:mm AM/PM', pGetSchedule.Tue.sTime);
    lblGetScheduleWedValue.Text := formatdatetime('hh:mm AM/PM', pGetSchedule.Wed.sTime);
    lblGetScheduleThuValue.Text := formatdatetime('hh:mm AM/PM', pGetSchedule.Thu.sTime);
    lblGetScheduleFriValue.Text := formatdatetime('hh:mm AM/PM', pGetSchedule.Fri.sTime);
    lblGetScheduleSatValue.Text := formatdatetime('hh:mm AM/PM', pGetSchedule.Sat.sTime);
  end;

  pReadData.Free;
  pGetSchedule.Free;
end;

end.
