unit frame.D.GetSensors;

interface

uses
  frame.master,
  dmCommon,
  neato.D.GetSensor,FMX.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation;

type
  TframeDGetSensors = class(TframeMaster)
    lblGetSensorWallFollower: TLabel;
    swGetSensorWallFollowerValue: TSwitch;
    lblGetSensorUltraSound: TLabel;
    swGetSensorUltraSoundValue: TSwitch;
    lblGetSensorDropSensors: TLabel;
    swGetSensorDropSensorsValue: TSwitch;
    lblGetSensorsensorsStatus: TLabel;
    lblGetSensorsensorsStatusValue: TLabel;
    lblGetSensorleftdropStatus: TLabel;
    lblGetSensorleftdropStatusValue: TLabel;
    lblGetSensorRightDropStatus: TLabel;
    lblGetSensorRightDropStatusValue: TLabel;
    lblGetSensorWallRightStatus: TLabel;
    lblGetSensorWallRightStatusValue: TLabel;
    lblGetSensorWheelDropStatus: TLabel;
    lblGetSensorWheelDropStatusValue: TLabel;
    lblGetSensorLeftDropmm: TLabel;
    lblGetSensorLeftDropmmValue: TLabel;
    lblGetSensorRightDropmm: TLabel;
    lblGetSensorRightDropmmValue: TLabel;
    lblGetSensorWallRightmm: TLabel;
    lblGetSensorWallRightmmValue: TLabel;
    lblGetSensorWheelDropmm: TLabel;
    lblGetSensorWheelDropmmValue: TLabel;
    lblGetSensorIMUAccelX: TLabel;
    lblGetSensorIMUAccelXValue: TLabel;
    lblGetSensorIMUAccelY: TLabel;
    lblGetSensorIMUAccelYValue: TLabel;
    lblGetSensorIMUAccelZ: TLabel;
    lblGetSensorIMUAccelZValue: TLabel;
    procedure timer_GetDataTimer(Sender: TObject);
  private
    { Private declarations }
  public
  end;

implementation

{$R *.fmx}

procedure TframeDGetSensors.timer_GetDataTimer(Sender: TObject);
var
  pGetSensor: tGetSensorD;
  pReadData: TStringList;
  r: Boolean;
begin

  if (dm.com.Serial.Active = false) or (dm.ActiveTab <> Tab) then
  begin
    timer_GetData.Enabled := false;
    exit;
  end;

  pGetSensor := tGetSensorD.Create;

  pReadData := TStringList.Create;
  pReadData.Text := dm.com.SendCommand(sGetSensor);


  r := pGetSensor.ParseText(pReadData);

  if r then
  begin
    swGetSensorWallFollowerValue.IsChecked := pGetSensor.Wall_Follower;
    swGetSensorUltraSoundValue.IsChecked := pGetSensor.Ultra_Sound;
    swGetSensorDropSensorsValue.IsChecked := pGetSensor.Drop_Sensors;

    lblGetSensorsensorsStatusValue.Text := pGetSensor.sensor_Status.ToString;
    lblGetSensorleftdropStatusValue.Text := pGetSensor.left_drop_Status.ToString;
    lblGetSensorRightDropStatusValue.Text := pGetSensor.right_drop_Status.ToString;
    lblGetSensorWallRightStatusValue.Text := pGetSensor.wall_right_Status.ToString;
    lblGetSensorWheelDropStatusValue.Text := pGetSensor.wheel_drop_Status.ToString;
    lblGetSensorWallRightmmValue.Text := pGetSensor.wall_right_mm.ToString;
    lblGetSensorRightDropmmValue.Text := pGetSensor.right_drop_mm.ToString;
    lblGetSensorWheelDropmmValue.Text := pGetSensor.wheel_drop_mm.ToString;
    lblGetSensorIMUAccelXValue.Text := pGetSensor.IMU_accel_x.ToString;
    lblGetSensorIMUAccelYValue.Text := pGetSensor.IMU_accel_y.ToString;
    lblGetSensorIMUAccelZValue.Text := pGetSensor.IMU_accel_z.ToString;
  end;

  pReadData.Free;
  pGetSensor.Free;
end;

end.
