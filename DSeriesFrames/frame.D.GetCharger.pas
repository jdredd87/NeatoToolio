unit frame.D.GetCharger;

interface

uses
  frame.master,
  dmCommon,
  neato.D.GetCharger,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.TabControl;

type
  TframeDGetCharger = class(TframeMaster)
    pbGetChargerFuelPercentValue: TProgressBar;
    lblGetChargerFuelPercentValue: TLabel;
    lblGetChargerFuelPercent: TLabel;
    pbGetChargerBattTempCAvgValue: TProgressBar;
    lblGetChargerBattTempCAvgValue: TLabel;
    pbGetChargerVBattVValue: TProgressBar;
    lblGetChargerVbattVValue: TLabel;
    pbGetChargerVextVValue: TProgressBar;
    lblGetChargerVextVValue: TLabel;
    pbGetChargerChargermAHValue: TProgressBar;
    lblGetChargerChargermAHValue: TLabel;
    pbGetChargerDischargermAHValue: TProgressBar;
    lblGetChargerDischargermAHValue: TLabel;
    lblGetChargerBattTempCAvg: TLabel;
    lblGetChargerVBattV: TLabel;
    lblGetChargerVExtV: TLabel;
    lblGetChargerChargermAH: TLabel;
    lblGetChargerDischargermAH: TLabel;
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
    lblGetChargerThermistorPresent: TLabel;
    swGetChargerThermistorPresentValue: TSwitch;
    procedure timer_GetDataTimer(Sender: TObject);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); reintroduce; overload;
    procedure check;
  end;

implementation

{$R *.fmx}

constructor TframeDGetCharger.Create(AOwner: TComponent);
begin
  inherited;
  lblFrameTitle.Text := sDescription;
end;

procedure TframeDGetCharger.timer_GetDataTimer(Sender: TObject);
var
  pGetCharger: tGetChargerD;
  pReadData: TStringList;
  r: Boolean;
begin

  if (dm.com.Active = false) or (dm.ActiveTab <> tab) then
  begin
    timer_GetData.Enabled := false;
    exit;
  end;

  pGetCharger := tGetChargerD.Create;

  pReadData := TStringList.Create;
  pReadData.Text := dm.com.SendCommand(sGetChargerD);

  r := pGetCharger.ParseText(pReadData);

  if r then
  begin
    pbGetChargerFuelPercentValue.Value := pGetCharger.FuelPercent;
    pbGetChargerBattTempCAvgValue.Value := pGetCharger.BattTempCAvg;
    pbGetChargerVBattVValue.Value := pGetCharger.VBattV;
    pbGetChargerVextVValue.Value := pGetCharger.VExtV;
    pbGetChargerChargermAHValue.Value := pGetCharger.Charger_mAH;
    pbGetChargerDischargermAHValue.Value := pGetCharger.Discharge_mAH;

    lblGetChargerFuelPercentValue.Text := pGetCharger.FuelPercent.ToString + ' %';
    lblGetChargerBattTempCAvgValue.Text := pGetCharger.BattTempCAvg.ToString + ' *';
    lblGetChargerVbattVValue.Text := pGetCharger.VBattV.ToString + ' v';
    lblGetChargerVextVValue.Text := pGetCharger.VExtV.ToString + ' v';
    lblGetChargerChargermAHValue.Text := pGetCharger.Charger_mAH.ToString;
    lblGetChargerDischargermAHValue.Text := pGetCharger.Discharge_mAH.ToString;

    swGetChargerBatteryOverTempValue.IsChecked := pGetCharger.BatteryOverTemp;
    swGetChargerChargingActiveValue.IsChecked := pGetCharger.ChargingActive;
    swGetChargerChargingEnabledValue.IsChecked := pGetCharger.ChargingEnabled;
    swGetChargerConfidentOnFuelValue.IsChecked := pGetCharger.ConfidentOnFuel;
    swGetChargerOnReservedFuelValue.IsChecked := pGetCharger.OnReservedFuel;
    swGetChargerEmptyFuelValue.IsChecked := pGetCharger.EmptyFuel;
    swGetChargerBatteryFailureValue.IsChecked := pGetCharger.BatteryFailure;
    swGetChargerExtPwrPresentValue.IsChecked := pGetCharger.ExtPwrPresent;
    swGetChargerThermistorPresentValue.IsChecked := pGetCharger.ThermistorPresent;
  end;

  pReadData.Free;
  pGetCharger.Free;

end;

procedure TframeDGetCharger.check;
begin
//
end;


end.
