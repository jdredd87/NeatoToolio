unit neato.XV.GetCharger;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors;

const

  sDescription = 'Get the diagnostic data for the charging system.';

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

  sThermistorPresent0 = 'ThermistorPresent[0]';
  sThermistorPresent1 = 'ThermistorPresent[1]';

  sBattTempCAvg0 = 'BattTempCAvg[0]';
  sBattTempCAvg1 = 'BattTempCAvg[1]';

  sVBattV = 'VBattV';
  sVExtV = 'VExtV';
  sCharger_mAH = 'Charger_mAH';

  // Command to send

  sGetChargerXV = 'GetCharger';

type

  tGetChargerXV = class(tNeatoBaseCommand)
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
    fThermistorPresent0: boolean;
    fThermistorPresent1: boolean;
    fBattTempCAvg0: double;
    fBattTempCAvg1: double;
    fVBattV: double;
    fVExtV: double;
    fCharger_mAH: double;
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

    property ThermistorPresent0: boolean read fThermistorPresent0;
    property ThermistorPresent1: boolean read fThermistorPresent1;

    property BattTempCAvg0: double read fBattTempCAvg0;
    property BattTempCAvg1: double read fBattTempCAvg1;

    property VBattV: double read fVBattV;
    property VExtV: double read fVExtV;
    property Charger_mAH: double read fCharger_mAH;

  end;

implementation

Constructor tGetChargerXV.Create;
begin
  inherited;
  fCommand := sGetChargerXV;
  fDescription := 'Get the diagnostic data for the charging system.';
  Reset;
end;

Destructor tGetChargerXV.Destroy;
begin
  inherited;
end;

procedure tGetChargerXV.Reset;
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
  fThermistorPresent0 := false;
  fThermistorPresent1 := false;
  fBattTempCAvg0 := 0;
  fBattTempCAvg1 := 0;
  fVBattV := 0;
  fVExtV := 0;
  fCharger_mAH := 0;

  inherited;
end;

function tGetChargerXV.ParseText(data: tstringlist): boolean;
begin
  try
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
      fThermistorPresent0 := data.Values[sThermistorPresent0] = '1';
      fThermistorPresent1 := data.Values[sThermistorPresent1] = '1';

      TryStrToFloat(data.Values[sBattTempCAvg0], fBattTempCAvg0);
      TryStrToFloat(data.Values[sBattTempCAvg1], fBattTempCAvg1);

      TryStrToFloat(data.Values[sVBattV], fVBattV);
      TryStrToFloat(data.Values[sVExtV], fVExtV);
      TryStrToFloat(data.Values[sCharger_mAH], fCharger_mAH);

      result := true;
    end
    else
    begin
      fError := strParseTextError;
      result := false;
    end;
  except
    on e: exception do
    begin
      fError := e.Message;
      result := false;
    end;
  end;

end;

end.
