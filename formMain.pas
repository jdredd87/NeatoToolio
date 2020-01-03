unit formMain;

interface

uses
  dmSerial.Windows,
  neato.GetCharger,
  neato.GetWarranty,
  neato.GetAccel,
  neato.GetAnalogSensors,
  neato.GetDigitalSensors,
  neato.GetErr,
  neato.Settings,
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.TabControl, FMX.ListBox,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.ScrollBox, FMX.Memo, FMX.Objects, FMX.Effects,
  System.Math.Vectors, FMX.Controls3D, FMX.Objects3D, FMX.Viewport3D,
  FMX.MaterialSources, FMX.Types3D, FMX.Filter.Effects, System.Rtti, FMX.Grid.Style, FMX.Grid;

type
  TfrmMain = class(TForm)
    StyleBook: TStyleBook;
    tabsMain: TTabControl;
    tabSetup: TTabItem;
    tabCommands: TTabItem;
    tabAbout: TTabItem;
    Panel1: TPanel;
    swConnect: TSwitch;
    pnlComSetup: TPanel;
    chkAutoDetect: TCheckBox;
    Label2: TLabel;
    cbCOM: TComboBox;
    TabControl: TTabControl;
    tabGetCharger: TTabItem;
    pb_FuelPercent: TProgressBar;
    lblFuelPercent: TLabel;
    lbl_FuelPercent: TLabel;
    pb_BattTempCAvg: TProgressBar;
    lbl_BattTempCAvg: TLabel;
    pb_VBattV: TProgressBar;
    lbl_VbattV: TLabel;
    pb_VextV: TProgressBar;
    lbl_VextV: TLabel;
    pb_ChargermAH: TProgressBar;
    lbl_ChargermAH: TLabel;
    pb_DischargermAH: TProgressBar;
    lbl_DischargermAH: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    lblConnect: TLabel;
    sw_BatteryOverTemp: TSwitch;
    sw_ChargingActive: TSwitch;
    sw_ChargingEnabled: TSwitch;
    lbl_BatteryOverTemp: TLabel;
    lbl_ChargingActive: TLabel;
    lbl_ChargingEnabled: TLabel;
    lbl_ConfidentOnFuel: TLabel;
    sw_ConfidentOnFuel: TSwitch;
    lbl_OnReservedFuel: TLabel;
    sw_OnReservedFuel: TSwitch;
    lbl_EmptyFuel: TLabel;
    sw_EmptyFuel: TSwitch;
    lbl_BatteryFailure: TLabel;
    sw_BatteryFailure: TSwitch;
    lbl_ExtPwrPresent: TLabel;
    sw_ExtPwrPresent: TSwitch;
    lbl_ThermistorPresent: TLabel;
    sw_ThermistorPresent: TSwitch;
    timer_GetCharger: TTimer;
    tabGetWarranty: TTabItem;
    timer_getWarranty: TTimer;
    lbl_CumulativeCleaningTimeInSecs: TLabel;
    lbl_CumulativeBatteryCycles: TLabel;
    lbl_ValidationCode: TLabel;
    tabGetAccel: TTabItem;
    ShadowEffect2: TShadowEffect;
    ShadowEffect1: TShadowEffect;
    lbl_CumulativeCleaningTimeInSecsValue: TLabel;
    lbl_ValidationCodeValue: TLabel;
    lbl_CumulativeBatteryCyclesValue: TLabel;
    ShadowEffect4: TShadowEffect;
    timer_GetAccel: TTimer;
    tabGetAnalogSensors: TTabItem;
    timer_GetAnalogSensors: TTimer;
    tabDebug: TTabItem;
    lblBatteryVoltage: TLabel;
    pb_BatteryVoltage: TProgressBar;
    lblBatteryVoltageValue: TLabel;
    memoDebug: TMemo;
    Label1: TLabel;
    Viewport3D1: TViewport3D;
    _3DGetAccel: TModel3D;
    Model3D1Mat01: TLightMaterialSource;
    Light1: TLight;
    ShadowEffect3: TShadowEffect;
    pb_BatteryCurrent: TProgressBar;
    lblBatteryCurrentValue: TLabel;
    pb_BatteryTemperature: TProgressBar;
    lblBatteryTemperatureValue: TLabel;
    pb_ExternalVoltage: TProgressBar;
    lblExternalVoltageValue: TLabel;
    lblBatteryCurrent: TLabel;
    lblBatteryTemperature: TLabel;
    lblExternalVoltage: TLabel;
    lblAccelerometerX: TLabel;
    lblAccelerometerXValue: TLabel;
    lblAccelerometerY: TLabel;
    lblAccelerometerYValue: TLabel;
    lblAccelerometerZ: TLabel;
    lblAccelerometerZValue: TLabel;
    lblCompassmeterX: TLabel;
    lblCompassmeterXValue: TLabel;
    lblCompassmeterY: TLabel;
    lblCompassmeterYValue: TLabel;
    lblCompassmeterZ: TLabel;
    lblCompassmeterZValue: TLabel;
    lblGyroscopeX: TLabel;
    lblGyroscopeXValue: TLabel;
    lblGyroscopeY: TLabel;
    lblGyroscopeYValue: TLabel;
    lblGyroscopeZ: TLabel;
    lblGyroscopeZValue: TLabel;
    ShadowEffect5: TShadowEffect;
    lblMagSensorLeft: TLabel;
    lblIMUAccelerometerXValue: TLabel;
    lblIMUAccelerometerY: TLabel;
    lblIMUAccelerometerYValue: TLabel;
    lblIMUAccelerometerZ: TLabel;
    lblIMUAccelerometerZValue: TLabel;
    lblVacuumCurrent: TLabel;
    lblVacuumCurrentValue: TLabel;
    lblSideBrushCurrent: TLabel;
    lblSideBrushCurrentValue: TLabel;
    lblWallSensor: TLabel;
    lblWallSensorValue: TLabel;
    lblDropSensorLeft: TLabel;
    lblDropSensorLeftValue: TLabel;
    lblDropSensorRight: TLabel;
    lblDropSensorRightValue: TLabel;
    swMagSensorLeft: TSwitch;
    swMagSensorRight: TSwitch;
    lblIMUAccelerometerX: TLabel;
    lblMagSensorRight: TLabel;
    ckTestMode: TCheckBox;
    tabGetDigitalSensors: TTabItem;
    timer_GetDigitalSensors: TTimer;
    swSNSR_DC_JACK_IS_IN: TSwitch;
    lblSNSR_DC_JACK_IS_IN: TLabel;
    ShadowEffect6: TShadowEffect;
    lblSNSR_DUSTBIN_IS_IN: TLabel;
    swSNSR_DUSTBIN_IS_IN: TSwitch;
    lblSNSR_LEFT_WHEEL_EXTENDED: TLabel;
    swSNSR_LEFT_WHEEL_EXTENDED: TSwitch;
    lblSNSR_RIGHT_WHEEL_EXTENDED: TLabel;
    swSNSR_RIGHT_WHEEL_EXTENDED: TSwitch;
    lblRSIDEBIT: TLabel;
    swRSIDEBIT: TSwitch;
    lblLLDSBIT: TLabel;
    swLLDSBIT: TSwitch;
    swLFRONTBIT: TSwitch;
    lblLFRONTBIT: TLabel;
    swLSIDEBIT: TSwitch;
    lblLSIDEBIT: TLabel;
    tabGetErr: TTabItem;
    timer_GetErr: TTimer;
    sgGetErr: TStringGrid;
    scGetErrName: TStringColumn;
    scGetErrValue: TStringColumn;
    Panel2: TPanel;
    lbl_PitchInDegrees: TLabel;
    lbl_RollInDegrees: TLabel;
    lbl_XInG: TLabel;
    lbl_YInG: TLabel;
    lbl_ZInG: TLabel;
    lbl_SumInG: TLabel;
    lbl_SumInGValue: TLabel;
    lbl_ZInGValue: TLabel;
    lbl_YInGValue: TLabel;
    lbl_XInGValue: TLabel;
    lbl_RollInDegreesValue: TLabel;
    lbl_PitchInDegreesValue: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure swConnectSwitch(Sender: TObject);
    procedure cbCOMChange(Sender: TObject);
    procedure chkAutoDetectChange(Sender: TObject);
    procedure timer_GetChargerTimer(Sender: TObject);
    procedure timer_getWarrantyTimer(Sender: TObject);
    procedure TabControlChange(Sender: TObject);
    procedure timer_GetAccelTimer(Sender: TObject);
    procedure timer_GetAnalogSensorsTimer(Sender: TObject);
    procedure ckTestModeChange(Sender: TObject);
    procedure timer_GetDigitalSensorsTimer(Sender: TObject);
    procedure timer_GetErrTimer(Sender: TObject);
  private
    fCurrentTimer: TTimer;
    procedure toggleComs(disable: boolean);
    procedure comConnect;
    procedure comDisconnect;
    procedure comError(Sender: TObject);
    procedure ResetGetAccel;
    procedure ResetGetDigitalSensors;
    procedure ResetGetErr;
    // when connected, disable controls or the reverse
  public
    com: TdmSerial;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  chkAutoDetect.IsChecked := neatoSettings.AutoDetectNeato;

  fCurrentTimer := nil;
  com := TdmSerial.Create(self);
  com.onError := comError;
  tabsMain.Enabled := false;

  tthread.CreateAnonymousThread(
    procedure
    var
      comList: TStringList;
    begin
      comList := TStringList.Create;
      com.com.EnumComDevices(comList);
      tthread.Synchronize(tthread.CurrentThread,
        procedure
        begin
          cbCOM.Items.Assign(comList);
          comList.Free;
          tabsMain.Enabled := true;
        end);
    end).Start;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
var
  idx: integer;
begin
  // make sure timers are OFF
  for idx := 0 to self.ComponentCount - 1 do
    if Components[idx] is TTimer then
      TTimer(Components[idx]).Enabled := false;

  if com.com.Active then // com is open still.. so lets make sure we turn testmode back OFF as we are done
  begin
    try
      com.SendCommand('testmode OFF'); // make sure to turn this off when close app
      com.SendCommand('testmode OFF'); // make sure to turn this off when close app
      com.SendCommand('testmode OFF'); // make sure to turn this off when close app
    finally
    end;
  end;
  freeandnil(com);
end;

procedure TfrmMain.swConnectSwitch(Sender: TObject);
begin
  toggleComs(swConnect.IsChecked);
end;

procedure TfrmMain.TabControlChange(Sender: TObject);
begin
  case TabControl.TabIndex of
    0:
      begin
        timer_GetCharger.Enabled := true;
        fCurrentTimer := timer_GetCharger;
      end;
    1:
      begin
        timer_getWarranty.Enabled := true;
        fCurrentTimer := timer_getWarranty;
      end;
    2:
      begin
        ResetGetAccel;
        timer_GetAccel.Enabled := true;
        fCurrentTimer := timer_GetAccel;
      end;
    3:
      begin
        timer_GetAnalogSensors.Enabled := true;
        fCurrentTimer := timer_GetAnalogSensors;
      end;
    4:
      begin
        ResetGetDigitalSensors;
        timer_GetDigitalSensors.Enabled := true;
        fCurrentTimer := timer_GetDigitalSensors;
      end;
    5:
      begin
        ResetGetErr;
        timer_GetErr.Enabled := true;
        fCurrentTimer := timer_GetErr;
      end;
  end;
end;

procedure TfrmMain.cbCOMChange(Sender: TObject);
begin
  swConnect.Enabled := cbCOM.ItemIndex > -1;
  if swConnect.Enabled then
    swConnect.IsChecked := false;
end;

procedure TfrmMain.chkAutoDetectChange(Sender: TObject);
begin
  cbCOM.Enabled := NOT chkAutoDetect.IsChecked;
  swConnect.Enabled := true;
  swConnect.IsChecked := false;
  neatosettings.AutoDetectNeato := chkAutoDetect.IsChecked;
end;

procedure TfrmMain.ckTestModeChange(Sender: TObject);
begin
  if assigned(fCurrentTimer) then
    fCurrentTimer.Enabled := false;

  case ckTestMode.IsChecked of
    true:
      com.SendCommand('TestMode ON');
    false:
      com.SendCommand('TestMode OFF');
  end;

  if assigned(fCurrentTimer) then
    fCurrentTimer.Enabled := true;
end;

procedure TfrmMain.ResetGetAccel;
begin
  _3DGetAccel.RotationAngle.X := 0;
  _3DGetAccel.RotationAngle.Y := 0;
  _3DGetAccel.RotationAngle.Z := 90;
end;

procedure TfrmMain.ResetGetDigitalSensors;
begin
  //
end;

procedure TfrmMain.ResetGetErr;
begin
  sgGetErr.RowCount := 0;
end;

procedure TfrmMain.timer_GetAccelTimer(Sender: TObject);
var
  a: tGetAccel;
  t: TStringList;
  v: double;
begin

  if (com.com.Active = false) or (TabControl.ActiveTab <> tabGetAccel) then
  begin
    timer_GetAccel.Enabled := false;
    exit;
  end;

  a := tGetAccel.Create;

  t := TStringList.Create;
  t.Text := com.SendCommand(sGetAccel);
  t.Text := stringreplace(t.Text, ',', '=', [rfreplaceall]);

  a.ParseText(t);

  lbl_PitchInDegreesValue.Text := a.PitchInDegrees.ToString;
  lbl_RollInDegreesValue.Text := a.RollInDegrees.ToString;
  lbl_XInGValue.Text := a.XInG.ToString;
  lbl_YInGValue.Text := a.YInG.ToString;
  lbl_ZInGValue.Text := a.ZInG.ToString;
  lbl_SumInGValue.Text := a.SumInG.ToString;

  v := a.RollInDegrees;

  if v > 0 then
    v := -abs(v)
  else
    v := abs(v);

  _3DGetAccel.RotationAngle.Z := 90 + v;

  v := a.PitchInDegrees;

  if v > 0 then
    v := -abs(v)
  else
    v := abs(v);

  _3DGetAccel.RotationAngle.Y := v;

  t.Free;
  a.Free;
end;

procedure TfrmMain.timer_GetChargerTimer(Sender: TObject);
var
  c: tGetCharger;
  t: TStringList;
begin

  if (com.com.Active = false) or (TabControl.ActiveTab <> tabGetCharger) then
  begin
    timer_GetCharger.Enabled := false;
    exit;
  end;

  c := tGetCharger.Create;

  t := TStringList.Create;
  t.Text := com.SendCommand(sGetCharger);
  t.Text := stringreplace(t.Text, ',', '=', [rfreplaceall]);

  c.ParseText(t);

  pb_FuelPercent.Value := c.FuelPercent;
  pb_BattTempCAvg.Value := c.BattTempCAvg;
  pb_VBattV.Value := c.VBattV;
  pb_VextV.Value := c.VExtV;
  pb_ChargermAH.Value := c.Charger_mAH;
  pb_DischargermAH.Value := c.Discharge_mAH;

  lbl_FuelPercent.Text := c.FuelPercent.ToString + ' %';
  lbl_BattTempCAvg.Text := c.BattTempCAvg.ToString + ' *';
  lbl_VbattV.Text := c.VBattV.ToString + ' v';
  lbl_VextV.Text := c.VExtV.ToString + ' v';
  lbl_ChargermAH.Text := c.Charger_mAH.ToString;
  lbl_DischargermAH.Text := c.Discharge_mAH.ToString;

  sw_BatteryOverTemp.IsChecked := c.BatteryOverTemp;
  sw_ChargingActive.IsChecked := c.ChargingActive;
  sw_ChargingEnabled.IsChecked := c.ChargingEnabled;
  sw_ConfidentOnFuel.IsChecked := c.ConfidentOnFuel;
  sw_OnReservedFuel.IsChecked := c.OnReservedFuel;
  sw_EmptyFuel.IsChecked := c.EmptyFuel;
  sw_BatteryFailure.IsChecked := c.BatteryFailure;
  sw_ExtPwrPresent.IsChecked := c.ExtPwrPresent;
  sw_ThermistorPresent.IsChecked := c.ThermistorPresent;

  t.Free;
  c.Free;
end;

procedure TfrmMain.timer_getWarrantyTimer(Sender: TObject);
var
  w: tGetWarranty;
  t: TStringList;
begin

  if (com.com.Active = false) or (TabControl.ActiveTab <> tabGetWarranty) then
  begin
    timer_getWarranty.Enabled := false;
    exit;
  end;

  w := tGetWarranty.Create;

  t := TStringList.Create;
  t.Text := com.SendCommand(sGetWarranty);
  t.Text := stringreplace(t.Text, ',', '=', [rfreplaceall]);

  w.ParseText(t);

  lbl_CumulativeCleaningTimeInSecsValue.Text := strtoint('$' + w.CumulativeCleaningTimeInSecs).ToString + ' seconds as '
    + w.CumulativeCleaningTimeInSecsAsHours.ToString + ' hours';

  lbl_CumulativeBatteryCyclesValue.Text := inttostr(strtoint('$' + w.CumulativeBatteryCycles));

  lbl_ValidationCodeValue.Text := strtoint('$' + w.ValidationCode).ToString;

  t.Free;
  w.Free;
end;

procedure TfrmMain.timer_GetAnalogSensorsTimer(Sender: TObject);
var
  a: tGetAnalogSensors;
  t: TStringList;
begin

  if (com.com.Active = false) or (TabControl.ActiveTab <> tabGetAnalogSensors) then
  begin
    timer_GetAnalogSensors.Enabled := false;
    exit;
  end;

  a := tGetAnalogSensors.Create;

  t := TStringList.Create;
  t.Text := com.SendCommand(sGetAnalogSensors);

  memoDebug.lines.Text := t.Text;
  a.ParseText(t);

  pb_BatteryVoltage.Value := a.BatteryVoltage.ValueDouble;

  lblBatteryVoltageValue.Text := a.BatteryVoltage.ValueDouble.ToString + ' ' + a.BatteryVoltage._Unit;

  pb_BatteryCurrent.Value := a.BatteryCurrent.ValueDouble;
  lblBatteryCurrentValue.Text := a.BatteryCurrent.ValueDouble.ToString + ' ' + a.BatteryCurrent._Unit;

  pb_BatteryTemperature.Value := a.BatteryTemperature.ValueDouble;
  lblBatteryTemperatureValue.Text := a.BatteryTemperature.ValueDouble.ToString + ' ' + a.BatteryTemperature._Unit;

  pb_ExternalVoltage.Value := a.ExternalVoltage.ValueDouble;
  lblExternalVoltageValue.Text := a.ExternalVoltage.ValueDouble.ToString + ' ' + a.ExternalVoltage._Unit;

  lblAccelerometerXValue.Text := a.AccelerometerX.ValueDouble.ToString + ' ' + a.AccelerometerX._Unit;
  lblAccelerometerYValue.Text := a.AccelerometerY.ValueDouble.ToString + ' ' + a.AccelerometerY._Unit;
  lblAccelerometerZValue.Text := a.AccelerometerZ.ValueDouble.ToString + ' ' + a.AccelerometerZ._Unit;

  lblCompassmeterXValue.Text := a.CompassmeterX.ValueDouble.ToString + ' ' + a.CompassmeterX._Unit;
  lblCompassmeterYValue.Text := a.CompassmeterY.ValueDouble.ToString + ' ' + a.CompassmeterY._Unit;
  lblCompassmeterZValue.Text := a.CompassmeterZ.ValueDouble.ToString + ' ' + a.CompassmeterZ._Unit;

  lblGyroscopeXValue.Text := a.GyroscopeX.ValueDouble.ToString + ' ' + a.GyroscopeX._Unit;
  lblGyroscopeYValue.Text := a.GyroscopeY.ValueDouble.ToString + ' ' + a.GyroscopeY._Unit;
  lblGyroscopeZValue.Text := a.GyroscopeZ.ValueDouble.ToString + ' ' + a.GyroscopeZ._Unit;

  lblIMUAccelerometerXValue.Text := a.IMUAccelerometerX.ValueDouble.ToString + ' ' + a.IMUAccelerometerX._Unit;
  lblIMUAccelerometerYValue.Text := a.IMUAccelerometerY.ValueDouble.ToString + ' ' + a.IMUAccelerometerY._Unit;
  lblIMUAccelerometerZValue.Text := a.IMUAccelerometerZ.ValueDouble.ToString + ' ' + a.IMUAccelerometerZ._Unit;

  lblVacuumCurrentValue.Text := a.VacuumCurrent.ValueDouble.ToString + ' ' + a.VacuumCurrent._Unit;
  lblWallSensorValue.Text := a.WallSensor.ValueDouble.ToString + ' ' + a.WallSensor._Unit;
  lblDropSensorLeftValue.Text := a.DropSensorLeft.ValueDouble.ToString + ' ' + a.DropSensorLeft._Unit;
  lblDropSensorRightValue.Text := a.DropSensorRight.ValueDouble.ToString + ' ' + a.DropSensorRight._Unit;

  swMagSensorLeft.IsChecked := a.MagSensorLeft.ValueBoolean;
  swMagSensorRight.IsChecked := a.MagSensorRight.ValueBoolean;

  t.Free;
  a.Free;
end;

procedure TfrmMain.timer_GetDigitalSensorsTimer(Sender: TObject);
var
  d: tGetDigitalSensors;
  t: TStringList;
begin

  if (com.com.Active = false) or (TabControl.ActiveTab <> tabGetDigitalSensors) then
  begin
    timer_GetDigitalSensors.Enabled := false;
    exit;
  end;

  d := tGetDigitalSensors.Create;

  t := TStringList.Create;
  t.Text := com.SendCommand(sGetDigitalSensors);
  memoDebug.lines.Text := t.Text;
  d.ParseText(t);

  swSNSR_DC_JACK_IS_IN.IsChecked := d.SNSR_DC_JACK_IS_IN.ValueBoolean;
  swSNSR_DUSTBIN_IS_IN.IsChecked := d.SNSR_DUSTBIN_IS_IN.ValueBoolean;
  swSNSR_LEFT_WHEEL_EXTENDED.IsChecked := d.SNSR_LEFT_WHEEL_EXTENDED.ValueBoolean;
  swSNSR_RIGHT_WHEEL_EXTENDED.IsChecked := d.SNSR_RIGHT_WHEEL_EXTENDED.ValueBoolean;

  swLSIDEBIT.IsChecked := d.LSIDEBIT.ValueBoolean;
  swLFRONTBIT.IsChecked := d.LFRONTBIT.ValueBoolean;
  swLLDSBIT.IsChecked := d.LLDSBIT.ValueBoolean;
  swRSIDEBIT.IsChecked := d.RSIDEBIT.ValueBoolean;

  t.Free;
  d.Free;
end;

procedure TfrmMain.timer_GetErrTimer(Sender: TObject);
var
  g: tGetErr;
  t: TStringList;
  idx: integer;
begin

  if (com.com.Active = false) or (TabControl.ActiveTab <> tabGetErr) then
  begin
    timer_GetErr.Enabled := false;
    exit;
  end;

  g := tGetErr.Create;

  t := TStringList.Create;
  t.Text := com.SendCommand(sGetErr);
  memoDebug.lines.Text := t.Text;

  g.ParseText(t);

  sgGetErr.RowCount := g.ErrorList.Count;

  for idx := 0 to g.ErrorList.Count - 1 do
  begin
    sgGetErr.Cells[0, idx] := g.ErrorList.Names[idx];
    sgGetErr.Cells[1, idx] := g.ErrorList.ValueFromIndex[idx];
  end;

  t.Free;
  g.Free;
end;

/// ///////////////////////////////////////////////////////////////
// Routines for doing biz work
/// ///////////////////////////////////////////////////////////////

procedure TfrmMain.toggleComs(disable: boolean);
begin
  pnlComSetup.Enabled := not disable;
  ckTestMode.Enabled := false;
  ckTestMode.IsChecked := false;
  if disable then
    comConnect
  else
    comDisconnect;
end;

procedure TfrmMain.comConnect;
var
  idx: integer;
  r: string;
begin

  if chkAutoDetect.IsChecked then
  begin
    com.onError := nil;

    for idx := 0 to cbCOM.Items.Count - 1 do
    begin

      if not com.open(cbCOM.Items[idx]) then
        continue;

      r := com.SendCommand('HELP');
      if pos('Help', r) > 0 then
      begin
        com.Close;
        cbCOM.ItemIndex := idx;
        break;
      end;
    end;
    com.onError := comError;
  end;

  if cbCOM.ItemIndex = -1 then
    showmessage('No COM Port set')
  else
  begin
    com.open(cbCOM.Items[cbCOM.ItemIndex]);
    TabControl.ActiveTab := tabGetCharger;
    TabControlChange(nil);
    ckTestMode.Enabled := true;
  end;
end;

procedure TfrmMain.comDisconnect;
begin
  com.Close;
end;

procedure TfrmMain.comError(Sender: TObject);
begin
  swConnect.Enabled := true;
  swConnect.IsChecked := false;
  pnlComSetup.Enabled := true;
  showmessage(com.Error);
end;

end.
