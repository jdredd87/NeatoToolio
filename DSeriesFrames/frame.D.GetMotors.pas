unit frame.D.GetMotors;

interface

uses
  frame.master,
  dmCommon,
  neato.D.GetMotors,FMX.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation;

type
  TframeDGetMotors = class(TframeMaster)
    lblGetMotorsBrush_RPM: TLabel;
    lblGetMotorsBrush_RPMValue: TLabel;
    lblGetMotorsBrush_mA: TLabel;
    lblGetMotorsBrush_mAValue: TLabel;
    lblGetMotorsVacuum_RPM: TLabel;
    lblGetMotorsVacuum_RPMValue: TLabel;
    lblGetMotorsVacuum_mA: TLabel;
    lblGetMotorsVacuum_mAValue: TLabel;
    lblGetMotorsLeftWheel_RPM: TLabel;
    lblGetMotorsLeftWheel_RPMValue: TLabel;
    lblGetMotorsLeftWheel_Load: TLabel;
    lblGetMotorsLeftWheel_LoadValue: TLabel;
    lblGetMotorsLeftWheel_PositionInMM: TLabel;
    lblGetMotorsLeftWheel_PositionInMMValue: TLabel;
    lblGetMotorsLeftWheel_Speed: TLabel;
    lblGetMotorsLeftWheel_SpeedValue: TLabel;
    lblGetMotorsLeftWheel_direction: TLabel;
    lblGetMotorsLeftWheel_directionValue: TLabel;
    lblGetMotorsRightWheel_RPM: TLabel;
    lblGetMotorsRightWheel_RPMValue: TLabel;
    lblGetMotorsRightWheel_Load: TLabel;
    lblGetMotorsRightWheel_LoadValue: TLabel;
    lblGetMotorsRightWheel_PositionInMM: TLabel;
    lblGetMotorsRightWheel_PositionInMMValue: TLabel;
    lblGetMotorsRightWheel_Speed: TLabel;
    lblGetMotorsRightWheel_SpeedValue: TLabel;
    lblGetMotorsRightWheel_direction: TLabel;
    lblGetMotorsRightWheel_directionValue: TLabel;
    lblGetMotorsROTATION_SPEED: TLabel;
    lblGetMotorsROTATION_SPEEDValue: TLabel;
    lblGetMotorsSideBrush_mA: TLabel;
    lblGetMotorsSideBrush_mAValue: TLabel;
    procedure timer_GetDataTimer(Sender: TObject);
  private
    { Private declarations }
  public
  end;

implementation

{$R *.fmx}

procedure TframeDGetMotors.timer_GetDataTimer(Sender: TObject);
var
  pGetMotors: tGetMotorsD;
  pReadData: TStringList;
  r: Boolean;
begin

  if (dm.com.Serial.Active = false) or (dm.ActiveTab <> tab) then
  begin
    timer_GetData.Enabled := false;
    exit;
  end;

  pGetMotors := tGetMotorsD.Create;

  pReadData := TStringList.Create;
  pReadData.Text := dm.com.SendCommand(sGetMotors);

  r := pGetMotors.ParseText(pReadData);

  if r then
  begin
    lblGetMotorsBrush_RPMValue.Text := pGetMotors.Brush_RPM.ToString;
    lblGetMotorsBrush_mAValue.Text := pGetMotors.Brush_mA.ToString;

    lblGetMotorsVacuum_RPMValue.Text := pGetMotors.Vacuum_RPM.ToString;
    lblGetMotorsVacuum_mAValue.Text := pGetMotors.Vacuum_mA.ToString;

    lblGetMotorsLeftWheel_RPMValue.Text := pGetMotors.LeftWheel_RPM.ToString;
    lblGetMotorsLeftWheel_LoadValue.Text := pGetMotors.LeftWheel_Load.ToString;
    lblGetMotorsLeftWheel_PositionInMMValue.Text := pGetMotors.LeftWheel_PositionInMM.ToString;
    lblGetMotorsLeftWheel_SpeedValue.Text := pGetMotors.LeftWheel_Speed.ToString;
    lblGetMotorsLeftWheel_directionValue.Text := pGetMotors.LeftWheel_direction.ToString;

    lblGetMotorsRightWheel_RPMValue.Text := pGetMotors.RightWheel_RPM.ToString;
    lblGetMotorsRightWheel_LoadValue.Text := pGetMotors.RightWheel_Load.ToString;
    lblGetMotorsRightWheel_PositionInMMValue.Text := pGetMotors.RightWheel_PositionInMM.ToString;
    lblGetMotorsRightWheel_SpeedValue.Text := pGetMotors.RightWheel_Speed.ToString;
    lblGetMotorsRightWheel_directionValue.Text := pGetMotors.RightWheel_direction.ToString;

    lblGetMotorsROTATION_SPEEDValue.Text := pGetMotors.ROTATION_SPEED.ToString;
    lblGetMotorsSideBrush_mAValue.Text := pGetMotors.SideBrush_mA.ToString;
  end;

  pReadData.Free;
  pGetMotors.Free;
end;

end.
