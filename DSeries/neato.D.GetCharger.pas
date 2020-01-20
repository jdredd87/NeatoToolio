unit neato.D.GetCharger;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors;

const
  // labels of text to look / parse for
  sLabel = 'Label';
  sValue = 'Value';
  sFuelPercent = 'FuelPercent';
  sBatteryOverTemp = 'BatteryOverTemp';
  sChargingActive = 'ChargingActive';
  sChargingEnabled = 'ChargingEnabled';
  sConfidentOnFuel = 'ConfidentOnFuel';
  sOnReservedFuel = 'OnReservedFuel';
  sEmptyFuel = 'EmptyFuel';
  sBatteryFailure = 'BatteryFailure';
  sExtPwrPresent = 'ExtPwrPresent';
  sThermistorPresent = 'ThermistorPresent';
  sBattTempCAvg = 'BattTempCAvg';
  sVBattV = 'VBattV';
  sVExtV = 'VExtV';
  sCharger_mAH = 'Charger_mAH';
  sDischarge_mAH = 'Discharge_mAH';

  // Command to send

  sGetChargerD = 'GetCharger';

type

  tGetChargerD = class(tNeatoBaseCommand)
  private
    fFuelPercent: double;
    fBatteryOverTemp: boolean;
    fChargingActive: boolean;
    fChargingEnabled: boolean;
    fConfidentOnFuel: boolean;
    fOnReservedFuel: boolean;
    fEmptyFuel: boolean;
    fBatteryFailure: boolean;
    fExtPwrPresent: boolean;
    fThermistorPresent: boolean;
    fBattTempCAvg: double;
    fVBattV: double;
    fVExtV: double;
    fCharger_mAH: double;
    fDischarge_mAH: double;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: tstringlist): boolean; override;
    property FuelPercent: double read fFuelPercent;
    property BatteryOverTemp: boolean read fBatteryOverTemp;
    property ChargingActive: boolean read fChargingActive;
    property ChargingEnabled: boolean read fChargingEnabled;
    property ConfidentOnFuel: boolean read fConfidentOnFuel;
    property OnReservedFuel: boolean read fOnReservedFuel;
    property EmptyFuel: boolean read fEmptyFuel;
    property BatteryFailure: boolean read fBatteryFailure;
    property ExtPwrPresent: boolean read fExtPwrPresent;
    property ThermistorPresent: boolean read fThermistorPresent;
    property BattTempCAvg: double read fBattTempCAvg;
    property VBattV: double read fVBattV;
    property VExtV: double read fVExtV;
    property Charger_mAH: double read fCharger_mAH;
    property Discharge_mAH: double read fDischarge_mAH;
  end;

implementation

Constructor tGetChargerD.Create;
begin
  inherited;
  fCommand := sGetChargerD;
  fDescription := 'Get the diagnostic data for the charging system.';
  Reset;
end;

Destructor tGetChargerD.Destroy;
begin
  inherited;
end;

procedure tGetChargerD.Reset;
begin
  fFuelPercent := 0;
  fBatteryOverTemp := false;
  fChargingActive := false;
  fChargingEnabled := false;
  fConfidentOnFuel := false;
  fOnReservedFuel := false;
  fEmptyFuel := false;
  fBatteryFailure := false;
  fExtPwrPresent := false;
  fThermistorPresent := false;
  fBattTempCAvg := 0;
  fVBattV := 0;
  fVExtV := 0;
  fCharger_mAH := 0;
  fDischarge_mAH := 0;
  inherited;
end;

function tGetChargerD.ParseText(data: tstringlist): boolean;
begin
  Reset;

  result := false;

  if NOT assigned(data) then
    exit;

  // Simple test to make sure we got data

  if data.Values[sLabel] = sValue then
  begin
    TryStrToFloat(data.Values[sFuelPercent], fFuelPercent);
    fBatteryOverTemp := data.Values[sBatteryOverTemp] = '1';
    fChargingActive := data.Values[sChargingActive] = '1';
    fChargingEnabled := data.Values[sChargingEnabled] = '1';
    fConfidentOnFuel := data.Values[sConfidentOnFuel] = '1';
    fOnReservedFuel := data.Values[sOnReservedFuel] = '1';
    fEmptyFuel := data.Values[sEmptyFuel] = '1';
    fBatteryFailure := data.Values[sBatteryFailure] = '1';
    fExtPwrPresent := data.Values[sExtPwrPresent] = '1';
    fThermistorPresent := data.Values[sThermistorPresent] = '1';
    TryStrToFloat(data.Values[sBattTempCAvg], fBattTempCAvg);
    TryStrToFloat(data.Values[sVBattV], fVBattV);
    TryStrToFloat(data.Values[sVExtV], fVExtV);
    TryStrToFloat(data.Values[sCharger_mAH], fCharger_mAH);
    TryStrToFloat(data.Values[sDischarge_mAH], fDischarge_mAH);
    result := true;
  end
  else
  begin
    fError := strParseTextError;
    result := false;
  end;

end;

end.
