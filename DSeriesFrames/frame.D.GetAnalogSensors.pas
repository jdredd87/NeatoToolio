unit frame.D.GetAnalogSensors;

interface

uses
  frame.master,
  dmCommon,
  neato.D.GetAnalogSensors,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.TabControl;

type
  TframeDGetAnalogSensors = class(TframeMaster)
    lblGetAnalogSensorsBatteryVoltage: TLabel;
    pbGetAnalogSensorsBatteryVoltageValue: TProgressBar;
    lblGetAnalogSensorsBatteryVoltageValue: TLabel;
    pbGetAnalogSensorsBatteryCurrentValue: TProgressBar;
    lblGetAnalogSensorsBatteryCurrentValue: TLabel;
    pbGetAnalogSensorsBatteryTemperatureValue: TProgressBar;
    lblGetAnalogSensorsBatteryTemperatureValue: TLabel;
    pbGetAnalogSensorsExternalVoltageValue: TProgressBar;
    lblGetAnalogSensorsExternalVoltageValue: TLabel;
    lblGetAnalogSensorsBatteryCurrent: TLabel;
    lblGetAnalogSensorsBatteryTemperature: TLabel;
    lblGetAnalogSensorsExternalVoltage: TLabel;
    lblGetAnalogSensorsAccelerometerX: TLabel;
    lblGetAnalogSensorsAccelerometerXValue: TLabel;
    lblGetAnalogSensorsAccelerometerY: TLabel;
    lblGetAnalogSensorsAccelerometerYValue: TLabel;
    lblGetAnalogSensorsAccelerometerZ: TLabel;
    lblGetAnalogSensorsAccelerometerZValue: TLabel;
    lblGetAnalogSensorsCompassmeterX: TLabel;
    lblGetAnalogSensorsCompassmeterXValue: TLabel;
    lblGetAnalogSensorsCompassmeterY: TLabel;
    lblGetAnalogSensorsCompassmeterYValue: TLabel;
    lblGetAnalogSensorsCompassmeterZ: TLabel;
    lblGetAnalogSensorsCompassmeterZValue: TLabel;
    lblGetAnalogSensorsGyroscopeX: TLabel;
    lblGetAnalogSensorsGyroscopeXValue: TLabel;
    lblGetAnalogSensorsGyroscopeY: TLabel;
    lblGetAnalogSensorsGyroscopeYValue: TLabel;
    lblGetAnalogSensorsGyroscopeZ: TLabel;
    lblGetAnalogSensorsGyroscopeZValue: TLabel;
    lblGetAnalogSensorsMagSensorLeft: TLabel;
    lblGetAnalogSensorsIMUAccelerometerXValue: TLabel;
    lblGetAnalogSensorsIMUAccelerometerY: TLabel;
    lblGetAnalogSensorsIMUAccelerometerYValue: TLabel;
    lblGetAnalogSensorsIMUAccelerometerZ: TLabel;
    lblGetAnalogSensorsIMUAccelerometerZValue: TLabel;
    lblGetAnalogSensorsVacuumCurrent: TLabel;
    lblGetAnalogSensorsVacuumCurrentValue: TLabel;
    lblGetAnalogSensorsSideBrushCurrent: TLabel;
    lblGetAnalogSensorsSideBrushCurrentValue: TLabel;
    lblGetAnalogSensorsWallSensor: TLabel;
    lblGetAnalogSensorsWallSensorValue: TLabel;
    lblGetAnalogSensorsDropSensorLeft: TLabel;
    lblGetAnalogSensorsDropSensorLeftValue: TLabel;
    lblGetAnalogSensorsDropSensorRight: TLabel;
    lblGetAnalogSensorsDropSensorRightValue: TLabel;
    swGetAnalogSensorsMagSensorLeftValue: TSwitch;
    swGetAnalogSensorsMagSensorRightValue: TSwitch;
    lblGetAnalogSensorsIMUAccelerometerX: TLabel;
    lblGetAnalogSensorsMagSensorRight: TLabel;
    procedure Timer_GetDataTimer(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Check;
    constructor Create(AOwner: TComponent); reintroduce; overload;
  end;

implementation

{$R *.fmx}

constructor TframeDGetAnalogSensors.Create(AOwner: TComponent);
begin
  inherited;
  lblFrameTitle.Text := sDescription;
end;

procedure TframeDGetAnalogSensors.Check;
begin

  lblGetAnalogSensorsCompassmeterX.Enabled := neatotype = BotVacConnected;
  lblGetAnalogSensorsCompassmeterY.Enabled := neatotype = BotVacConnected;
  lblGetAnalogSensorsCompassmeterZ.Enabled := neatotype = BotVacConnected;

  lblGetAnalogSensorsGyroscopeX.Enabled := neatotype = BotVacConnected;
  lblGetAnalogSensorsGyroscopeY.Enabled := neatotype = BotVacConnected;
  lblGetAnalogSensorsGyroscopeZ.Enabled := neatotype = BotVacConnected;

  lblGetAnalogSensorsIMUAccelerometerX.Enabled := neatotype = BotVacConnected;
  lblGetAnalogSensorsIMUAccelerometerY.Enabled := neatotype = BotVacConnected;
  lblGetAnalogSensorsIMUAccelerometerZ.Enabled := neatotype = BotVacConnected;

  lblGetAnalogSensorsCompassmeterXValue.Enabled := neatotype = BotVacConnected;
  lblGetAnalogSensorsCompassmeterYValue.Enabled := neatotype = BotVacConnected;
  lblGetAnalogSensorsCompassmeterZValue.Enabled := neatotype = BotVacConnected;

  lblGetAnalogSensorsGyroscopeXValue.Enabled := neatotype = BotVacConnected;
  lblGetAnalogSensorsGyroscopeYValue.Enabled := neatotype = BotVacConnected;
  lblGetAnalogSensorsGyroscopeZValue.Enabled := neatotype = BotVacConnected;

  lblGetAnalogSensorsIMUAccelerometerXValue.Enabled := neatotype = BotVacConnected;
  lblGetAnalogSensorsIMUAccelerometerYValue.Enabled := neatotype = BotVacConnected;
  lblGetAnalogSensorsIMUAccelerometerZValue.Enabled := neatotype = BotVacConnected;

end;

procedure TframeDGetAnalogSensors.Timer_GetDataTimer(Sender: TObject);
var
  pGetAnalogSensors: tGetAnalogSensorsD;
  pReadData: TStringList;
  r: Boolean;
begin

  if (dm.com.Serial.Active = false) or (dm.ActiveTab <> tab) then
  begin
    Timer_GetData.Enabled := false;
    exit;
  end;

  pGetAnalogSensors := tGetAnalogSensorsD.Create;

  pReadData := TStringList.Create;
  pReadData.Text := dm.com.SendCommand(sGetAnalogSensors);

  r := pGetAnalogSensors.ParseText(pReadData);

  if r then
  begin

    pbGetAnalogSensorsBatteryVoltageValue.Value := pGetAnalogSensors.BatteryVoltage.ValueDouble;

    lblGetAnalogSensorsBatteryVoltageValue.Text := pGetAnalogSensors.BatteryVoltage.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.BatteryVoltage._Unit;

    pbGetAnalogSensorsBatteryCurrentValue.Value := pGetAnalogSensors.BatteryCurrent.ValueDouble;
    lblGetAnalogSensorsBatteryCurrentValue.Text := pGetAnalogSensors.BatteryCurrent.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.BatteryCurrent._Unit;

    pbGetAnalogSensorsBatteryTemperatureValue.Value := pGetAnalogSensors.BatteryTemperature.ValueDouble;
    lblGetAnalogSensorsBatteryTemperatureValue.Text := pGetAnalogSensors.BatteryTemperature.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.BatteryTemperature._Unit;

    pbGetAnalogSensorsExternalVoltageValue.Value := pGetAnalogSensors.ExternalVoltage.ValueDouble;
    lblGetAnalogSensorsExternalVoltageValue.Text := pGetAnalogSensors.ExternalVoltage.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.ExternalVoltage._Unit;

    lblGetAnalogSensorsAccelerometerXValue.Text := pGetAnalogSensors.AccelerometerX.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.AccelerometerX._Unit;
    lblGetAnalogSensorsAccelerometerYValue.Text := pGetAnalogSensors.AccelerometerY.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.AccelerometerY._Unit;
    lblGetAnalogSensorsAccelerometerZValue.Text := pGetAnalogSensors.AccelerometerZ.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.AccelerometerZ._Unit;

    lblGetAnalogSensorsCompassmeterXValue.Text := pGetAnalogSensors.CompassmeterX.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.CompassmeterX._Unit;
    lblGetAnalogSensorsCompassmeterYValue.Text := pGetAnalogSensors.CompassmeterY.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.CompassmeterY._Unit;
    lblGetAnalogSensorsCompassmeterZValue.Text := pGetAnalogSensors.CompassmeterZ.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.CompassmeterZ._Unit;

    lblGetAnalogSensorsGyroscopeXValue.Text := pGetAnalogSensors.GyroscopeX.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.GyroscopeX._Unit;
    lblGetAnalogSensorsGyroscopeYValue.Text := pGetAnalogSensors.GyroscopeY.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.GyroscopeY._Unit;
    lblGetAnalogSensorsGyroscopeZValue.Text := pGetAnalogSensors.GyroscopeZ.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.GyroscopeZ._Unit;

    lblGetAnalogSensorsIMUAccelerometerXValue.Text := pGetAnalogSensors.IMUAccelerometerX.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.IMUAccelerometerX._Unit;
    lblGetAnalogSensorsIMUAccelerometerYValue.Text := pGetAnalogSensors.IMUAccelerometerY.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.IMUAccelerometerY._Unit;
    lblGetAnalogSensorsIMUAccelerometerZValue.Text := pGetAnalogSensors.IMUAccelerometerZ.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.IMUAccelerometerZ._Unit;

    lblGetAnalogSensorsVacuumCurrentValue.Text := pGetAnalogSensors.VacuumCurrent.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.VacuumCurrent._Unit;
    lblGetAnalogSensorsWallSensorValue.Text := pGetAnalogSensors.WallSensor.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.WallSensor._Unit;
    lblGetAnalogSensorsDropSensorLeftValue.Text := pGetAnalogSensors.DropSensorLeft.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.DropSensorLeft._Unit;
    lblGetAnalogSensorsDropSensorRightValue.Text := pGetAnalogSensors.DropSensorRight.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.DropSensorRight._Unit;

    swGetAnalogSensorsMagSensorLeftValue.IsChecked := pGetAnalogSensors.MagSensorLeft.ValueBoolean;
    swGetAnalogSensorsMagSensorRightValue.IsChecked := pGetAnalogSensors.MagSensorRight.ValueBoolean;

  end;
  pReadData.Free;
  pGetAnalogSensors.Free;
end;

end.
