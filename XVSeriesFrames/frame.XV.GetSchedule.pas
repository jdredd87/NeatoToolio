unit frame.XV.GetSchedule;

interface

uses
  frame.master,
  dmCommon,
  neato.XV.GetSchedule,
  FMX.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.DateTimeCtrls, FMX.Objects;

type
  TframeXVGetSchedule = class(TframeMaster)
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
    constructor Create(AOwner: TComponent); reintroduce; overload;
    procedure check;
  end;

implementation

{$R *.fmx}

constructor TframeXVGetSchedule.Create(AOwner: TComponent);
begin
  inherited;
  lblFrameTitle.Text := sDescription;
end;

procedure TframeXVGetSchedule.timer_GetDataTimer(Sender: TObject);
var
  pGetSchedule: tGetScheduleXV;
  pReadData: TStringList;
  r: Boolean;
begin

  if (dm.com.Active = false) or (dm.ActiveTab <> Tab) then
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

procedure TframeXVGetSchedule.check;
begin
  //
end;

end.
