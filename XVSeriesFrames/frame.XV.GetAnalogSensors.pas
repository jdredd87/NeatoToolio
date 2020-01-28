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

  if (dm.com.Serial.Active = false) or (dm.ActiveTab<>tab) then
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

    lblGetAnalogSensorsBatteryVoltageInValue.Text := pGetAnalogSensors.BatteryVoltageInmV.ToString;
    pbGetAnalogSensorsBatteryVoltageInValue.Value := pGetAnalogSensors.BatteryVoltageInmV;

    lblGetAnalogSensorsBatteryTemp0InCValue.Text := pGetAnalogSensors.BatteryTemp0InC.ToString;
    pbGetAnalogSensorsBatteryTemp0InCValue.Value := pGetAnalogSensors.BatteryTemp0InC;

    lblGetAnalogSensorsBatteryTemp1InCValue.Text := pGetAnalogSensors.BatteryTemp1InC.ToString;
    pbGetAnalogSensorsBatteryTemp1InCValue.Value := pGetAnalogSensors.BatteryTemp1InC;

    lblGetAnalogSensorsUIButtonInmVValue.Text := pGetAnalogSensors.UIButtonInmV.ToString;
    pbGetAnalogSensorsUIButtonInmVValue.Value := pGetAnalogSensors.UIButtonInmV;

    lblGetAnalogSensorsChargeVoltInmVValue.Text := pGetAnalogSensors.VacuumCurrentInmA.ToString;
    pbGetAnalogSensorsChargeVoltInmVValue.Value := pGetAnalogSensors.VacuumCurrentInmA;

    lblGetAnalogSensorsCurrentInmAValue.Text := pGetAnalogSensors.CurrentInmA.ToString;
    pbGetAnalogSensorsCurrentInmAValue.Value := pGetAnalogSensors.CurrentInmA;

    lblGetAnalogSensorsSideBrushCurrentInmAValue.Text := pGetAnalogSensors.SideBrushCurrentInmA.ToString;
    pnGetAnalogSensorsSideBrushCurrentInmAValue.Value := pGetAnalogSensors.SideBrushCurrentInmA;

    lblGetAnalogSensorsVoltageReferenceInmVValue.Text := pGetAnalogSensors.VoltageReferenceInmV.ToString;
    pnGetAnalogSensorsSideBrushCurrentInmAValue.Value := pGetAnalogSensors.VoltageReferenceInmV;

    lblGetAnalogSensorsVacuumCurrentInmAValue.Text := pGetAnalogSensors.VacuumCurrentInmA.ToString;
    pbGetAnalogSensorsVacuumCurrentInmAValue.Value := pGetAnalogSensors.VacuumCurrentInmA;

    lblGetAnalogSensorsWallSensorInMMValue.Text := pGetAnalogSensors.WallSensorInMM.ToString;
    lblGetAnalogSensorsLeftDropInMMValue.Text := pGetAnalogSensors.LeftDropInMM.ToString;
    lblGetAnalogSensorsRightDropInMMValue.Text := pGetAnalogSensors.RightDropInMM.ToString;
    lblGetAnalogSensorsLeftMagSensorValue.Text := pGetAnalogSensors.LeftMagSensor.ToString;
    lblGetAnalogSensorsRightMagSensorValue.Text := pGetAnalogSensors.RightMagSensor.ToString;

    lblGetAnalogSensorsAccelXInmGValue.Text := pGetAnalogSensors.AccelXInmG.ToString;
    lblGetAnalogSensorsAccelYInmGValue.Text := pGetAnalogSensors.AccelYInmG.ToString;
    lblGetAnalogSensorsAccelZInmGValue.Text := pGetAnalogSensors.AccelZInmG.ToString;

  end;
  pReadData.Free;
  pGetAnalogSensors.Free;
end;

end.
