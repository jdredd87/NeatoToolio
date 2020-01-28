unit neato.D.GetAnalogSensors;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors,
  neato.Helpers;

const
  sDescription = 'Get the A2D ( analog to digital ) readings for the analog sensors';

  // labels of text to look / parse for
  sSensorName = 'SensorName';
  sUnit = 'Unit';
  sValue = 'Value';

  sBatteryVoltage = 'BatteryVoltage';
  sBatteryCurrent = 'BatteryCurrent';
  sBatteryTemperature = 'BatteryTemperature';
  sExternalVoltage = 'ExternalVoltage';
  sAccelerometerX = 'AccelerometerX';
  sAccelerometerY = 'AccelerometerY';
  sAccelerometerZ = 'AccelerometerZ';
  sCompassmeterX = 'CompassmeterX';
  sCompassmeterY = 'CompassmeterY';
  sCompassmeterZ = 'CompassmeterZ';
  sGyroscopeX = 'GyroscopeX';
  sGyroscopeY = 'GyroscopeY';
  sGyroscopeZ = 'GyroscopeZ';
  sIMUAccelerometerX = 'IMUAccelerometerX';
  sIMUAccelerometerY = 'IMUAccelerometerY';
  sIMUAccelerometerZ = 'IMUAccelerometerZ';
  sVacuumCurrent = 'VacuumCurrent';
  sSideBrushCurrent = 'SideBrushCurrent';
  sMagSensorLeft = 'MagSensorLeft';
  sMagSensorRight = 'MagSensorRight';
  sWallSensor = 'WallSensor';
  sDropSensorLeft = 'DropSensorLeft';
  sDropSensorRight = 'DropSensorRight';


  // Command to send

  sGetAnalogSensors = 'GetAnalogSensors';

type

  tGetAnalogSensorsD = class(tNeatoBaseCommand)
  private

    fBatteryVoltage: tNeatoNameValuePair;
    fBatteryCurrent: tNeatoNameValuePair;
    fBatteryTemperature: tNeatoNameValuePair;
    fExternalVoltage: tNeatoNameValuePair;
    fAccelerometerX: tNeatoNameValuePair;
    fAccelerometerY: tNeatoNameValuePair;
    fAccelerometerZ: tNeatoNameValuePair;
    fCompassmeterX: tNeatoNameValuePair;
    fCompassmeterY: tNeatoNameValuePair;
    fCompassmeterZ: tNeatoNameValuePair;
    fGyroscopeX: tNeatoNameValuePair;
    fGyroscopeY: tNeatoNameValuePair;
    fGyroscopeZ: tNeatoNameValuePair;
    fIMUAccelerometerX: tNeatoNameValuePair;
    fIMUAccelerometerY: tNeatoNameValuePair;
    fIMUAccelerometerZ: tNeatoNameValuePair;
    fVacuumCurrent: tNeatoNameValuePair;
    fSideBrushCurrent: tNeatoNameValuePair;
    fMagSensorLeft: tNeatoNameValuePair;
    fMagSensorRight: tNeatoNameValuePair;
    fWallSensor: tNeatoNameValuePair;
    fDropSensorLeft: tNeatoNameValuePair;
    fDropSensorRight: tNeatoNameValuePair;

  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: tstringlist): Boolean; override;

    property BatteryVoltage: tNeatoNameValuePair read fBatteryVoltage;
    property BatteryCurrent: tNeatoNameValuePair read fBatteryCurrent;
    property BatteryTemperature: tNeatoNameValuePair read fBatteryTemperature;
    property ExternalVoltage: tNeatoNameValuePair read fExternalVoltage;
    property AccelerometerX: tNeatoNameValuePair read fAccelerometerX;
    property AccelerometerY: tNeatoNameValuePair read fAccelerometerY;
    property AccelerometerZ: tNeatoNameValuePair read fAccelerometerZ;
    property CompassmeterX: tNeatoNameValuePair read fCompassmeterX;
    property CompassmeterY: tNeatoNameValuePair read fCompassmeterY;
    property CompassmeterZ: tNeatoNameValuePair read fCompassmeterZ;
    property GyroscopeX: tNeatoNameValuePair read fGyroscopeX;
    property GyroscopeY: tNeatoNameValuePair read fGyroscopeY;
    property GyroscopeZ: tNeatoNameValuePair read fGyroscopeZ;
    property IMUAccelerometerX: tNeatoNameValuePair read fIMUAccelerometerX;
    property IMUAccelerometerY: tNeatoNameValuePair read fIMUAccelerometerY;
    property IMUAccelerometerZ: tNeatoNameValuePair read fIMUAccelerometerZ;
    property VacuumCurrent: tNeatoNameValuePair read fVacuumCurrent;
    property SideBrushCurrent: tNeatoNameValuePair read fSideBrushCurrent;
    property MagSensorLeft: tNeatoNameValuePair read fMagSensorLeft;
    property MagSensorRight: tNeatoNameValuePair read fMagSensorRight;
    property WallSensor: tNeatoNameValuePair read fWallSensor;
    property DropSensorLeft: tNeatoNameValuePair read fDropSensorLeft;
    property DropSensorRight: tNeatoNameValuePair read fDropSensorRight;
  end;

implementation

Constructor tGetAnalogSensorsD.create;
begin
  inherited;
  fCommand := sGetAnalogSensors;
  fDescription := sDescription;
  Reset;
end;

Destructor tGetAnalogSensorsD.destroy;
begin
  inherited;
end;

procedure tGetAnalogSensorsD.Reset;
begin
  fBatteryVoltage.ValueDouble := 0;
  fBatteryCurrent.ValueDouble := 0;
  fBatteryTemperature.ValueDouble := 0;
  fExternalVoltage.ValueDouble := 0;
  fAccelerometerX.ValueDouble := 0;
  fAccelerometerY.ValueDouble := 0;
  fAccelerometerZ.ValueDouble := 0;
  fCompassmeterX.ValueDouble := 0;
  fCompassmeterY.ValueDouble := 0;
  fCompassmeterZ.ValueDouble := 0;
  fGyroscopeX.ValueDouble := 0;
  fGyroscopeY.ValueDouble := 0;
  fGyroscopeZ.ValueDouble := 0;
  fIMUAccelerometerX.ValueDouble := 0;
  fIMUAccelerometerY.ValueDouble := 0;
  fIMUAccelerometerZ.ValueDouble := 0;
  fVacuumCurrent.ValueDouble := 0;
  fSideBrushCurrent.ValueDouble := 0;
  fMagSensorLeft.ValueBoolean := false;
  fMagSensorRight.ValueBoolean := false;
  fWallSensor.ValueDouble := 0;
  fDropSensorLeft.ValueDouble := 0;
  fDropSensorRight.ValueDouble := 0;
  inherited;
end;

function tGetAnalogSensorsD.ParseText(data: tstringlist): Boolean;
// this is a 3 field wide data set so things are differently done
var
  lineData: tstringlist;
  subData: tstringlist;
  IDX: integer;

begin
  Reset;

  result := false;

  if NOT assigned(data) then
    exit;

  lineData := tstringlist.create;
  lineData.Delimiter := ',';
  lineData.DelimitedText := data.Strings[1]; // grab header row

  subData := tstringlist.create;
  subData.Delimiter := ',';

  // Simple test to make sure we got data

  if lineData[0] = sSensorName then
  begin
    lineData.Text := data.Text;
    lineData.Delete(0); // strip off heaer row, no longe needed

    for IDX := 0 to lineData.Count - 1 do
      lineData[IDX] := stringreplace(lineData[IDX], ',', '=', []);
    // replaces only FIRST , with an =

    GetSubData(lineData, fBatteryVoltage, sBatteryVoltage, varDouble);
    GetSubData(lineData, fBatteryCurrent, sBatteryCurrent, varDouble);
    GetSubData(lineData, fBatteryTemperature, sBatteryTemperature, varDouble);
    GetSubData(lineData, fExternalVoltage, sExternalVoltage, varDouble);
    GetSubData(lineData, fAccelerometerX, sAccelerometerX, varDouble);
    GetSubData(lineData, fAccelerometerY, sAccelerometerY, varDouble);
    GetSubData(lineData, fAccelerometerZ, sAccelerometerZ, varDouble);
    GetSubData(lineData, fCompassmeterX, sCompassmeterX, varDouble);
    GetSubData(lineData, fCompassmeterY, sCompassmeterY, varDouble);
    GetSubData(lineData, fCompassmeterZ, sCompassmeterZ, varDouble);
    GetSubData(lineData, fGyroscopeX, sGyroscopeX, varDouble);
    GetSubData(lineData, fGyroscopeY, sGyroscopeY, varDouble);
    GetSubData(lineData, fGyroscopeZ, sGyroscopeZ, varDouble);
    GetSubData(lineData, fIMUAccelerometerX, sIMUAccelerometerX, varDouble);
    GetSubData(lineData, fIMUAccelerometerY, sIMUAccelerometerY, varDouble);
    GetSubData(lineData, fIMUAccelerometerZ, sIMUAccelerometerZ, varDouble);
    GetSubData(lineData, fVacuumCurrent, sVacuumCurrent, varDouble);
    GetSubData(lineData, fSideBrushCurrent, sSideBrushCurrent, varDouble);
    GetSubData(lineData, fMagSensorLeft, sMagSensorLeft, varBoolean);
    GetSubData(lineData, fMagSensorRight, sMagSensorRight, varBoolean);
    GetSubData(lineData, fWallSensor, sWallSensor, varDouble);
    GetSubData(lineData, fDropSensorLeft, sDropSensorLeft, varDouble);
    GetSubData(lineData, fDropSensorRight, sDropSensorRight, varDouble);

    result := true;
  end
  else
  begin
    fError := strParseTextError;
    result := false;
  end;

  freeandnil(lineData);
  freeandnil(subData);
end;

end.
