unit frame.XV.GetAnalogSensors;

interface

uses
  frame.master,
  dmCommon,
  neato.XV.GetAnalogSensors,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.TabControl;

type
  TframeXVGetAnalogSensors = class(TframeMaster)
    lblGetAnalogSensorsBatteryVoltageIn: TLabel;
    pbGetAnalogSensorsBatteryVoltageInValue: TProgressBar;

    lblGetAnalogSensorsBatteryVoltageInValue: TLabel;
    pbGetAnalogSensorsBatteryTemp0InCValue: TProgressBar;

    lblGetAnalogSensorsBatteryTemp0InCValue: TLabel;
    lblGetAnalogSensorsBatteryTemp0InC: TLabel;

    lblGetAnalogSensorsBatteryTemperature: TLabel;
    lblGetAnalogSensorsAccelXInmG: TLabel;
    lblGetAnalogSensorsAccelXInmGValue: TLabel;
    lblGetAnalogSensorsAccelYInmG: TLabel;
    lblGetAnalogSensorsAccelYInmGValue: TLabel;
    lblGetAnalogSensorsAccelZInmG: TLabel;
    lblGetAnalogSensorsAccelZInmGValue: TLabel;
    lblGetAnalogSensorsLeftMagSensor: TLabel;
    lblGetAnalogSensorsWallSensorInMM: TLabel;
    lblGetAnalogSensorsWallSensorInMMValue: TLabel;
    lblGetAnalogSensorsLeftDropInMM: TLabel;
    lblGetAnalogSensorsLeftDropInMMValue: TLabel;
    lblGetAnalogSensorsRightDropInMM: TLabel;
    lblGetAnalogSensorsRightDropInMMValue: TLabel;
    lblGetAnalogSensorsRightMagSensor: TLabel;
    pbGetAnalogSensorsBatteryTemp1InCValue: TProgressBar;
    lblGetAnalogSensorsBatteryTemp1InCValue: TLabel;
    pbGetAnalogSensorsUIButtonInmVValue: TProgressBar;
    lblGetAnalogSensorsUIButtonInmVValue: TLabel;
    lblUIButtonInmV: TLabel;
    pbGetAnalogSensorsVacuumCurrentInmAValue: TProgressBar;
    lblGetAnalogSensorsVacuumCurrentInmAValue: TLabel;
    pbGetAnalogSensorsVoltageReferenceInmVValue: TProgressBar;
    lblGetAnalogSensorsVoltageReferenceInmVValue: TLabel;
    pbGetAnalogSensorsChargeVoltInmVValue: TProgressBar;
    lblGetAnalogSensorsChargeVoltInmVValue: TLabel;
    pbGetAnalogSensorsCurrentInmAValue: TProgressBar;
    lblGetAnalogSensorsCurrentInmAValue: TLabel;
    pnGetAnalogSensorsSideBrushCurrentInmAValue: TProgressBar;
    lblGetAnalogSensorsSideBrushCurrentInmAValue: TLabel;
    lblVacuumCurrentInmA: TLabel;
    lblChargeVoltInmV: TLabel;
    lblCurrentInmA: TLabel;
    lblSideBrushCurrentInmA: TLabel;
    lblVoltageReferenceInmV: TLabel;
    lblGetAnalogSensorsLeftMagSensorValue: TLabel;
    lblGetAnalogSensorsRightMagSensorValue: TLabel;
    procedure Timer_GetDataTimer(Sender: TObject);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); reintroduce; overload;
    procedure check;
  end;

implementation

{$R *.fmx}

constructor TframeXVGetAnalogSensors.Create(AOwner: TComponent);
begin
  inherited;
  lblFrameTitle.Text := sDescription;
end;

procedure TframeXVGetAnalogSensors.Timer_GetDataTimer(Sender: TObject);
var
  pGetAnalogSensors: tGetAnalogSensorsXV;
  pReadData: TStringList;
  r: Boolean;
begin

  if (dm.com.Active = false) or (dm.ActiveTab <> tab) then
  begin
    Timer_GetData.Enabled := false;
    exit;
  end;

  pGetAnalogSensors := tGetAnalogSensorsXV.Create;

  pReadData := TStringList.Create;
  pReadData.Text := dm.com.SendCommand(sGetAnalogSensors);

  r := pGetAnalogSensors.ParseText(pReadData);

  if r then
  begin

    lblGetAnalogSensorsBatteryVoltageInValue.Text := pGetAnalogSensors.BatteryVoltageInmV.ToString +  'mV';
    pbGetAnalogSensorsBatteryVoltageInValue.Value := pGetAnalogSensors.BatteryVoltageInmV;

    lblGetAnalogSensorsBatteryTemp0InCValue.Text := pGetAnalogSensors.BatteryTemp0InC.ToString + ' *C';
    pbGetAnalogSensorsBatteryTemp0InCValue.Value := pGetAnalogSensors.BatteryTemp0InC;

    lblGetAnalogSensorsBatteryTemp1InCValue.Text := pGetAnalogSensors.BatteryTemp1InC.ToString + ' *C';
    pbGetAnalogSensorsBatteryTemp1InCValue.Value := pGetAnalogSensors.BatteryTemp1InC;

    lblGetAnalogSensorsUIButtonInmVValue.Text := pGetAnalogSensors.UIButtonInmV.ToString + ' mV';
    pbGetAnalogSensorsUIButtonInmVValue.Value := pGetAnalogSensors.UIButtonInmV;

    lblGetAnalogSensorsChargeVoltInmVValue.Text := pGetAnalogSensors.VacuumCurrentInmA.ToString + ' mA';
    pbGetAnalogSensorsChargeVoltInmVValue.Value := pGetAnalogSensors.VacuumCurrentInmA;

    lblGetAnalogSensorsCurrentInmAValue.Text := pGetAnalogSensors.CurrentInmA.ToString +' mA';
    pbGetAnalogSensorsCurrentInmAValue.Value := pGetAnalogSensors.CurrentInmA;

    lblGetAnalogSensorsSideBrushCurrentInmAValue.Text := pGetAnalogSensors.SideBrushCurrentInmA.ToString +' mA';
    pnGetAnalogSensorsSideBrushCurrentInmAValue.Value := pGetAnalogSensors.SideBrushCurrentInmA;

    lblGetAnalogSensorsVoltageReferenceInmVValue.Text := pGetAnalogSensors.VoltageReferenceInmV.ToString + ' mV';
    pnGetAnalogSensorsSideBrushCurrentInmAValue.Value := pGetAnalogSensors.VoltageReferenceInmV;

    lblGetAnalogSensorsVacuumCurrentInmAValue.Text := pGetAnalogSensors.VacuumCurrentInmA.ToString + ' mA';
    pbGetAnalogSensorsVacuumCurrentInmAValue.Value := pGetAnalogSensors.VacuumCurrentInmA;

    lblGetAnalogSensorsWallSensorInMMValue.Text := pGetAnalogSensors.WallSensorInMM.ToString + ' mm';
    lblGetAnalogSensorsLeftDropInMMValue.Text := pGetAnalogSensors.LeftDropInMM.ToString + ' mm';
    lblGetAnalogSensorsRightDropInMMValue.Text := pGetAnalogSensors.RightDropInMM.ToString + ' mm';
    lblGetAnalogSensorsLeftMagSensorValue.Text := pGetAnalogSensors.LeftMagSensor.ToString;
    lblGetAnalogSensorsRightMagSensorValue.Text := pGetAnalogSensors.RightMagSensor.ToString;

    lblGetAnalogSensorsAccelXInmGValue.Text := pGetAnalogSensors.AccelXInmG.ToString + ' mG';
    lblGetAnalogSensorsAccelYInmGValue.Text := pGetAnalogSensors.AccelYInmG.ToString + ' mG';
    lblGetAnalogSensorsAccelZInmGValue.Text := pGetAnalogSensors.AccelZInmG.ToString + ' mG';

  end;
  pReadData.Free;
  pGetAnalogSensors.Free;
end;

procedure TframeXVGetAnalogSensors.check;
begin
//
end;

end.
