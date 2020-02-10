unit frame.XV.GetCharger;

interface

uses
  frame.master,
  dmCommon,
  neato.XV.GetCharger,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.TabControl;

type
  TframeXVGetCharger = class(TframeMaster)
    pbGetChargerFuelPercentValue: TProgressBar;
    lblGetChargerFuelPercentValue: TLabel;
    lblGetChargerFuelPercent: TLabel;
    pbGetChargerBattTempCAvg0Value: TProgressBar;
    lblGetChargerBattTempCAvg0Value: TLabel;
    pbGetChargerVBattVValue: TProgressBar;
    lblGetChargerVbattVValue: TLabel;
    pbGetChargerVextVValue: TProgressBar;
    lblGetChargerVextVValue: TLabel;
    pbGetChargerChargermAHValue: TProgressBar;
    lblGetChargerChargermAHValue: TLabel;
    lblGetChargerBattTempCAvg0: TLabel;
    lblGetChargerVBattV: TLabel;
    lblGetChargerVExtV: TLabel;
    lblGetChargerChargermAH: TLabel;
    swGetChargerBatteryOverTempValue: TSwitch;
    swGetChargerChargingActiveValue: TSwitch;
    swGetChargerChargingEnabledValue: TSwitch;
    lblGetChargerBatteryOverTemp: TLabel;
    lblGetChargerChargingActive: TLabel;
    lblGetChargerChargingEnabled: TLabel;
    lblGetChargerConfidentOnFuel: TLabel;
    swGetChargerConfidentOnFuelValue: TSwitch;
    lblGetChargerOnReservedFuel: TLabel;
    swGetChargerOnReservedFuelValue: TSwitch;
    lblGetChargerEmptyFuel: TLabel;
    swGetChargerEmptyFuelValue: TSwitch;
    lblGetChargerBatteryFailure: TLabel;
    swGetChargerBatteryFailureValue: TSwitch;
    lblGetChargerExtPwrPresent: TLabel;
    swGetChargerExtPwrPresentValue: TSwitch;
    lblGetChargerThermistor0Present: TLabel;
    swGetChargerThermistorPresent0Value: TSwitch;
    swGetChargerThermistorPresent1Value: TSwitch;
    lblGetChargerThermistor1Present: TLabel;
    pbGetChargerBattTempCAvg1Value: TProgressBar;
    lblGetChargerBattTempCAvg1Value: TLabel;
    lblGetChargerBattTempCAvg1: TLabel;
    procedure timer_GetDataTimer(Sender: TObject);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); reintroduce; overload;
    procedure check;
  end;

implementation

{$R *.fmx}

constructor TframeXVGetCharger.Create(AOwner: TComponent);
begin
  inherited;
  lblFrameTitle.Text := sDescription;
end;

procedure TframeXVGetCharger.timer_GetDataTimer(Sender: TObject);
var
  pGetCharger: tGetChargerXV;
  pReadData: TStringList;
  r: Boolean;
begin

  if (dm.com.Active = false) or (dm.ActiveTab <> Tab) then
  begin
    timer_GetData.Enabled := false;
    exit;
  end;

  pGetCharger := tGetChargerXV.Create;

  pReadData := TStringList.Create;
  pReadData.Text := dm.com.SendCommand(sGetChargerXV);
  pReadData.Text := stringreplace(pReadData.Text, ',', '=', [rfreplaceall]);

  r := pGetCharger.ParseText(pReadData);

  if r then
  begin
    pbGetChargerFuelPercentValue.Value := pGetCharger.FuelPercent;

    pbGetChargerBattTempCAvg0Value.Value := pGetCharger.BattTempCAvg0;
    pbGetChargerBattTempCAvg1Value.Value := pGetCharger.BattTempCAvg1;

    pbGetChargerVBattVValue.Value := pGetCharger.VBattV;
    pbGetChargerVextVValue.Value := pGetCharger.VExtV;
    pbGetChargerChargermAHValue.Value := pGetCharger.Charger_mAH;

    lblGetChargerFuelPercentValue.Text := pGetCharger.FuelPercent.ToString + ' %';

    lblGetChargerBattTempCAvg0Value.Text := pGetCharger.BattTempCAvg0.ToString + ' *C';
    lblGetChargerBattTempCAvg1Value.Text := pGetCharger.BattTempCAvg1.ToString + ' *C';

    lblGetChargerVbattVValue.Text := pGetCharger.VBattV.ToString + ' v';
    lblGetChargerVextVValue.Text := pGetCharger.VExtV.ToString + ' v';
    lblGetChargerChargermAHValue.Text := pGetCharger.Charger_mAH.ToString + ' mAH';

    swGetChargerBatteryOverTempValue.IsChecked := pGetCharger.BatteryOverTemp;
    swGetChargerChargingActiveValue.IsChecked := pGetCharger.ChargingActive;
    swGetChargerChargingEnabledValue.IsChecked := pGetCharger.ChargingEnabled;
    swGetChargerConfidentOnFuelValue.IsChecked := pGetCharger.ConfidentOnFuel;
    swGetChargerOnReservedFuelValue.IsChecked := pGetCharger.OnReservedFuel;
    swGetChargerEmptyFuelValue.IsChecked := pGetCharger.EmptyFuel;
    swGetChargerBatteryFailureValue.IsChecked := pGetCharger.BatteryFailure;
    swGetChargerExtPwrPresentValue.IsChecked := pGetCharger.ExtPwrPresent;
    swGetChargerThermistorPresent0Value.IsChecked := pGetCharger.ThermistorPresent0;
    swGetChargerThermistorPresent1Value.IsChecked := pGetCharger.ThermistorPresent1;
  end;

  pReadData.Free;
  pGetCharger.Free;

end;


procedure TframeXVGetCharger.check;
begin
//
end;

end.
