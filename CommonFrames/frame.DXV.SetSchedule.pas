unit frame.DXV.SetSchedule;

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
  frame.master,
  dmCommon,
  neato.DXV.SetSchedule,
  FMX.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.DateTimeCtrls, FMX.Objects, FMX.Edit, FMX.EditBox, FMX.SpinBox, FMX.ListBox;

type
  TframeXVSetSchedule = class(TframeMaster)
    lblSetSchedule: TLabel;
    cbSetScheduleDay: TComboBox;
    lblSetScheduleHour: TLabel;
    sbSetScheduleHour: TSpinBox;
    lblSetScheduleMinutes: TLabel;
    sbSetScheduleMinutes: TSpinBox;
    ckSetScheduleEnabled: TCheckBox;
    btnSetScheduleApply: TButton;
    lblSetScheduleSetOnorOff: TLabel;
    btnSetScheduleModeON: TButton;
    btnSetScheduleModeOFF: TButton;
    lblSetScheduleError: TLabel;
    Rectangle1: TRectangle;
    procedure btnSetScheduleApplyClick(Sender: TObject);
    procedure ckSetScheduleEnabledChange(Sender: TObject);
    procedure cbSetScheduleDayChange(Sender: TObject);
    procedure btnSetScheduleModeONClick(Sender: TObject);
  private
    { Private declarations }
  end;

implementation

{$R *.fmx}

procedure TframeXVSetSchedule.btnSetScheduleApplyClick(Sender: TObject);
var
  isHouse: string;
  r: boolean;
  pReadData: tstringlist;
  pSetScheduleDXV: tSetScheduleDXV;
begin

  if self.ckSetScheduleEnabled.IsChecked then
    isHouse := 'House'
  else
    isHouse := 'None';

  pReadData := tstringlist.Create;
  pReadData.Text := dm.com.SendCommandOnly(sSetSchedule + ' ' + cbSetScheduleDay.ItemIndex.ToString + ' ' +
    self.sbSetScheduleHour.Value.ToString + ' ' + self.sbSetScheduleMinutes.Value.ToString + ' ' + isHouse);

  pSetScheduleDXV := tSetScheduleDXV.Create;
  r := pSetScheduleDXV.ParseText(pReadData);

  if r then
  begin
    cbSetScheduleDay.ItemIndex := -1;
    ckSetScheduleEnabled.Enabled := false;
    ckSetScheduleEnabled.IsChecked := false;
    sbSetScheduleHour.Value := 0;
    sbSetScheduleMinutes.Value := 0;
    lblSetScheduleError.Text := '';
  end
  else
    lblSetScheduleError.Text := pSetScheduleDXV.Error;

  freeandnil(pSetScheduleDXV);
  freeandnil(pReadData);
  resetfocus;
end;

procedure TframeXVSetSchedule.btnSetScheduleModeONClick(Sender: TObject);
var
  cmd: String;
  r: boolean;
  pReadData: tstringlist;
  pSetScheduleDXV: tSetScheduleDXV;
begin
  inherited;
  cmd := '';

  if Sender = self.btnSetScheduleModeON then
    cmd := sSetSchedule + ' ' + sON;

  if Sender = self.btnSetScheduleModeOFF then
    cmd := sSetSchedule + ' ' + sOff;

  if cmd <> '' then
  begin
    pReadData := tstringlist.Create;
    pReadData.Text := dm.com.SendCommandOnly(cmd);

    pSetScheduleDXV := tSetScheduleDXV.Create;
    r := pSetScheduleDXV.ParseText(pReadData);

    if not r then
      lblSetScheduleError.Text := pSetScheduleDXV.Error;
    freeandnil(pSetScheduleDXV);
    freeandnil(pReadData);
  end;
  resetfocus;
end;

procedure TframeXVSetSchedule.cbSetScheduleDayChange(Sender: TObject);
begin
  inherited;
  ckSetScheduleEnabled.Enabled := cbSetScheduleDay.ItemIndex > -1;
  self.btnSetScheduleApply.Enabled := cbSetScheduleDay.ItemIndex > -1;
end;

procedure TframeXVSetSchedule.ckSetScheduleEnabledChange(Sender: TObject);
begin
  inherited;
  sbSetScheduleHour.Enabled := self.ckSetScheduleEnabled.IsChecked;
  sbSetScheduleMinutes.Enabled := self.ckSetScheduleEnabled.IsChecked;
end;

end.
