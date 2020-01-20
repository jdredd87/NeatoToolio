unit neato.XV.GetAnalogSensors;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors,
  neato.Helpers;

const
  // labels of text to look / parse for
  sSensorName = 'SensorName';
  sValue = 'Value';

  sWallSensorInMM = 'WallSensorInMM';
  sBatteryVoltageInmV = 'BatteryVoltageInmV';
  sLeftDropInMM = 'LeftDropInMM';
  sRightDropInMM = 'RightDropInMM';
  sLeftMagSensor = 'LeftMagSensor';
  sRightMagSensor = 'RightMagSensor';
  sUIButtonInmV = 'UIButtonInmV';
  sVacuumCurrentInmA = 'VacuumCurrentInmA';
  sChargeVoltInmV = 'ChargeVoltInmV';
  sBatteryTemp0InC = 'BatteryTemp0InC';
  sBatteryTemp1InC = 'BatteryTemp1InC';
  sCurrentInmA = 'CurrentInmA';
  sSideBrushCurrentInmA = 'SideBrushCurrentInmA';
  sVoltageReferenceInmV = 'VoltageReferenceInmV';
  sAccelXInmG = 'AccelXInmG';
  sAccelYInmG = 'AccelYInmG';
  sAccelZInmG = 'AccelZInmG';
  // Command to send

  sGetAnalogSensors = 'GetAnalogSensors';

type

  tGetAnalogSensorsXV = class(tNeatoBaseCommand)
  private

    fWallSensorInMM: double;
    fBatteryVoltageInmV: double;
    fLeftDropInMM: double;
    fRightDropInMM: double;
    fLeftMagSensor: double;
    fRightMagSensor: double;
    fUIButtonInmV: double;
    fVacuumCurrentInmA: double;
    fChargeVoltInmV: double;
    fBatteryTemp0InC: double;
    fBatteryTemp1InC: double;
    fCurrentInmA: double;
    fSideBrushCurrentInmA: double;
    fVoltageReferenceInmV: double;
    fAccelXInmG: double;
    fAccelYInmG: double;
    fAccelZInmG: double;

  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: tstringlist): Boolean; override;

    property WallSensorInMM: double read fWallSensorInMM write fWallSensorInMM;
    property BatteryVoltageInmV: double read fBatteryVoltageInmV write fBatteryVoltageInmV;
    property LeftDropInMM: double read fLeftDropInMM write fLeftDropInMM;
    property RightDropInMM: double read fRightDropInMM write fRightDropInMM;
    property LeftMagSensor: double read fLeftMagSensor write fLeftMagSensor;
    property RightMagSensor: double read fRightMagSensor write fRightMagSensor;
    property UIButtonInmV: double read fUIButtonInmV write fUIButtonInmV;
    property VacuumCurrentInmA: double read fVacuumCurrentInmA write fVacuumCurrentInmA;
    property ChargeVoltInmV: double read fChargeVoltInmV write fChargeVoltInmV;
    property BatteryTemp0InC: double read fBatteryTemp0InC write fBatteryTemp0InC;
    property BatteryTemp1InC: double read fBatteryTemp1InC write fBatteryTemp1InC;
    property CurrentInmA: double read fCurrentInmA write fCurrentInmA;
    property SideBrushCurrentInmA: double read fSideBrushCurrentInmA write fSideBrushCurrentInmA;
    property VoltageReferenceInmV: double read fVoltageReferenceInmV write fVoltageReferenceInmV;
    property AccelXInmG: double read fAccelXInmG write fAccelXInmG;
    property AccelYInmG: double read fAccelYInmG write fAccelYInmG;
    property AccelZInmG: double read fAccelZInmG write fAccelZInmG;

  end;

implementation

Constructor tGetAnalogSensorsXV.Create;
begin
  inherited;
  fCommand := sGetAnalogSensors;
  fDescription := 'Get the A2D ( analog to digital ) readings for the analog sensors';
  Reset;
end;

Destructor tGetAnalogSensorsXV.Destroy;
begin
  inherited;
end;

procedure tGetAnalogSensorsXV.Reset;
begin
  fWallSensorInMM := 0;
  fBatteryVoltageInmV := 0;
  fLeftDropInMM := 0;
  fRightDropInMM := 0;
  fLeftMagSensor := 0;
  fRightMagSensor := 0;
  fUIButtonInmV := 0;
  fVacuumCurrentInmA := 0;
  fChargeVoltInmV := 0;
  fBatteryTemp0InC := 0;
  fBatteryTemp1InC := 0;
  fCurrentInmA := 0;
  fSideBrushCurrentInmA := 0;
  fVoltageReferenceInmV := 0;
  fAccelXInmG := 0;
  fAccelYInmG := 0;
  fAccelZInmG := 0;
  inherited;
end;

function tGetAnalogSensorsXV.ParseText(data: tstringlist): Boolean;
// this is a 3 field wide data set so things are differently done

begin
  Reset;

  result := false;

  if NOT assigned(data) then
    exit;

  data.CaseSensitive := false;
  data.Text := stringreplace(data.Text, ' ', '', [rfreplaceall]);
  data.Text := stringreplace(data.Text, ',', '=', [rfreplaceall]);

  // Neato output error... they have an extra comma after the data values...


  if pos(sSensorName, data.Text) > 0 then
  begin

    trystrtofloat(FixStringCommaTwoPart(data.Values[sWallSensorInMM]), fWallSensorInMM);
    trystrtofloat(FixStringCommaTwoPart(data.Values[sBatteryVoltageInmV]), fBatteryVoltageInmV);
    trystrtofloat(FixStringCommaTwoPart(data.Values[sLeftDropInMM]), fLeftDropInMM);
    trystrtofloat(FixStringCommaTwoPart(data.Values[sRightDropInMM]), fRightDropInMM);
    trystrtofloat(FixStringCommaTwoPart(data.Values[sLeftMagSensor]), fLeftMagSensor);
    trystrtofloat(FixStringCommaTwoPart(data.Values[sRightMagSensor]), fRightMagSensor);
    trystrtofloat(FixStringCommaTwoPart(data.Values[sUIButtonInmV]), fUIButtonInmV);
    trystrtofloat(FixStringCommaTwoPart(data.Values[sVacuumCurrentInmA]), fVacuumCurrentInmA);
    trystrtofloat(FixStringCommaTwoPart(data.Values[sChargeVoltInmV]), fChargeVoltInmV);
    trystrtofloat(FixStringCommaTwoPart(data.Values[sBatteryTemp0InC]), fBatteryTemp0InC);
    trystrtofloat(FixStringCommaTwoPart(data.Values[sBatteryTemp1InC]), fBatteryTemp1InC);
    trystrtofloat(FixStringCommaTwoPart(data.Values[sCurrentInmA]), fCurrentInmA);
    trystrtofloat(FixStringCommaTwoPart(data.Values[sSideBrushCurrentInmA]), fSideBrushCurrentInmA);
    trystrtofloat(FixStringCommaTwoPart(data.Values[sVoltageReferenceInmV]), fVoltageReferenceInmV);
    trystrtofloat(FixStringCommaTwoPart(data.Values[sAccelXInmG]), fAccelXInmG);
    trystrtofloat(FixStringCommaTwoPart(data.Values[sAccelYInmG]), fAccelYInmG);
    trystrtofloat(FixStringCommaTwoPart(data.Values[sAccelZInmG]), fAccelZInmG);

    result := true;
  end
  else
  begin
    fError := strParseTextError;
    result := false;
  end;

end;

end.
