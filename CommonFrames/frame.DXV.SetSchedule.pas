unit frame.DXV.SetSchedule;

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
  public
    { Private declarations }
    constructor Create(AOwner: TComponent); reintroduce; overload;
  end;

implementation

{$R *.fmx}

constructor TframeXVSetSchedule.Create(AOwner: TComponent);
begin
 inherited;
 lblFrameTitle.Text := sDescription;
end;

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
