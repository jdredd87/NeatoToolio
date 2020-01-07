// reminder to self
// move all code out of the timers into their own routines.
// use timers to call them!

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
  neato.GetVersion,
  neato.GetUsage,
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.TabControl, FMX.ListBox,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.ScrollBox, FMX.Memo, FMX.Objects, FMX.Effects,
  System.Math.Vectors, FMX.Controls3D, FMX.Objects3D, FMX.Viewport3D,
  FMX.MaterialSources, FMX.Types3D, FMX.Filter.Effects, System.Rtti, FMX.Grid.Style, FMX.Grid, FMX.ExtCtrls, FMX.Edit,
  FMX.EditBox, FMX.SpinBox;

type
  TfrmMain = class(TForm)
    StyleBook: TStyleBook;
    tabsMain: TTabControl;
    tabSetup: TTabItem;
    tabSensors: TTabItem;
    tabAbout: TTabItem;
    Panel1: TPanel;
    swConnect: TSwitch;
    pnlComSetup: TPanel;
    chkAutoDetect: TCheckBox;
    Label2: TLabel;
    cbCOM: TComboBox;
    lblConnect: TLabel;
    timer_GetCharger: TTimer;
    timer_getWarranty: TTimer;
    timer_GetAccel: TTimer;
    timer_GetAnalogSensors: TTimer;
    tabDebug: TTabItem;
    memoDebug: TMemo;
    Label1: TLabel;
    Model3D1Mat01: TLightMaterialSource;
    ckTestMode: TCheckBox;
    timer_GetDigitalSensors: TTimer;
    timer_GetErr: TTimer;
    ScaledLayout1: TScaledLayout;
    tabSensorsOptions: TTabControl;
    tabGetCharger: TTabItem;
    pb_FuelPercent: TProgressBar;
    lbl_FuelPercent: TLabel;
    lblFuelPercent: TLabel;
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
    ShadowEffect2: TShadowEffect;
    tabGetAccel: TTabItem;
    Viewport3D1: TViewport3D;
    _3DGetAccel: TModel3D;
    Light1: TLight;
    ShadowEffect3: TShadowEffect;
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
    tabGetAnalogSensors: TTabItem;
    lblBatteryVoltage: TLabel;
    pb_BatteryVoltage: TProgressBar;
    lblBatteryVoltageValue: TLabel;
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
    tabGetDigitalSensors: TTabItem;
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
    ShadowEffect4: TShadowEffect;
    tabInfo: TTabItem;
    tabsInfoOptions: TTabControl;
    tabGetUsage: TTabItem;
    tabGetUserSettings: TTabItem;
    tabGetVersion: TTabItem;
    tabWiFi: TTabItem;
    tabsWifiOptions: TTabControl;
    TabItem5: TTabItem;
    TabItem6: TTabItem;
    GetConfiguredWifiNetworks: TTabItem;
    SetWifi: TTabItem;
    tabGetWarranty: TTabItem;
    lbl_CumulativeCleaningTimeInSecs: TLabel;
    lbl_CumulativeBatteryCycles: TLabel;
    lbl_ValidationCode: TLabel;
    ShadowEffect1: TShadowEffect;
    lbl_CumulativeCleaningTimeInSecsValue: TLabel;
    lbl_ValidationCodeValue: TLabel;
    lbl_CumulativeBatteryCyclesValue: TLabel;
    tabGetErr: TTabItem;
    sgGetErr: TStringGrid;
    scGetErrName: TStringColumn;
    scGetErrValue: TStringColumn;
    sgGetVersion: TStringGrid;
    scGetVersionComponent: TStringColumn;
    scGerVersionMajor: TStringColumn;
    scGetVersionMinor: TStringColumn;
    scGetVersionBuild: TStringColumn;
    scGetVersionAux: TStringColumn;
    scGetGetVersionAUX2: TStringColumn;
    timer_GetVersion: TTimer;
    timer_PlaySound: TTimer;
    tabTools: TTabItem;
    tabsLIDAROptions: TTabControl;
    tabLidar: TTabItem;
    sgLIDAR: TStringGrid;
    StringColumn1: TStringColumn;
    StringColumn2: TStringColumn;
    StringColumn3: TStringColumn;
    StringColumn4: TStringColumn;
    StringColumn5: TStringColumn;
    StringColumn6: TStringColumn;
    StringColumn7: TStringColumn;
    StringColumn8: TStringColumn;
    StringColumn9: TStringColumn;
    StringColumn10: TStringColumn;
    timer_LIDAR: TTimer;
    ShadowEffect7: TShadowEffect;
    Rectangle1: TRectangle;
    plotLIDAR: TPlotGrid;
    ckShowIntensityLines: TCheckBox;
    sbResetLIDARMapping: TSpinBox;
    lblResetLIDARmapping: TLabel;
    lblTotalCleaningTime: TLabel;
    lblTotalCleaningTimeValue: TLabel;
    lblTotalCleanedArea: TLabel;
    lblTotalCleanedAreaValue: TLabel;
    lblMainBrushRunTimeinSec: TLabel;
    lblMainBrushRunTimeinSecValue: TLabel;
    lblSideBrushRunTimeinSec: TLabel;
    lblSideBrushRunTimeinSecValue: TLabel;
    lblDirtbinRunTimeinSec: TLabel;
    lblDirtbinRunTimeinSecValue: TLabel;
    lblFilterTimeinSec: TLabel;
    lblFilterTimeinSecValue: TLabel;
    ShadowEffect8: TShadowEffect;
    ShadowEffect9: TShadowEffect;
    timer_GetUsage: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure swConnectSwitch(Sender: TObject);
    procedure cbCOMChange(Sender: TObject);
    procedure chkAutoDetectChange(Sender: TObject);
    procedure timer_GetChargerTimer(Sender: TObject);
    procedure timer_getWarrantyTimer(Sender: TObject);
    procedure tabSensorsOptionsChange(Sender: TObject);
    procedure timer_GetAccelTimer(Sender: TObject);
    procedure timer_GetAnalogSensorsTimer(Sender: TObject);
    procedure ckTestModeChange(Sender: TObject);
    procedure timer_GetDigitalSensorsTimer(Sender: TObject);
    procedure timer_GetErrTimer(Sender: TObject);
    procedure tabsInfoOptionsChange(Sender: TObject);
    procedure timer_GetVersionTimer(Sender: TObject);
    procedure tabsMainChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure timer_PlaySoundTimer(Sender: TObject);
    procedure timer_LIDARTimer(Sender: TObject);
    procedure tabsLIDAROptionsChange(Sender: TObject);
    procedure ckShowIntensityLinesChange(Sender: TObject);
    procedure timer_GetUsageTimer(Sender: TObject);
  private
    fCurrentTimer: TTimer;
    fLIDARCounter: single;
    procedure toggleComs(disable: Boolean);
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

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  idx: integer;
begin
  // make sure all onChange events are gone
  // as it seems these can trigger on closeing

  tabsMain.OnChange := nil;
  tabSensorsOptions.OnChange := nil;
  tabsInfoOptions.OnChange := nil;
  tabsWifiOptions.OnChange := nil;

  // make sure timers are disabled so they quit doing work
  for idx := 0 to self.ComponentCount - 1 do
    if Components[idx] is TTimer then
      TTimer(Components[idx]).Enabled := false;

  // if com is open still.. so lets make sure we turn testmode back OFF as we are done
  if com.com.Active then
  begin
    try
      com.SendCommand('testmode OFF'); // make sure to turn this off when close app
      com.SendCommand('testmode OFF'); // make sure to turn this off when close app
      com.SendCommand('testmode OFF'); // make sure to turn this off when close app
    finally
    end;
  end;

  CanClose := true;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  tabsMain.TabIndex := 0;
  tabSensorsOptions.TabIndex := 0;
  tabsInfoOptions.TabIndex := 0;
  tabsWifiOptions.TabIndex := 0;

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
begin
  freeandnil(com);
end;

procedure TfrmMain.swConnectSwitch(Sender: TObject);
begin
  toggleComs(swConnect.IsChecked);
end;

procedure TfrmMain.tabSensorsOptionsChange(Sender: TObject);
begin

  tthread.CreateAnonymousThread(
    procedure
    begin
      sleep(250); // allows the UI a few momments of drawing time
      // ran into an awkward issue that this seemed to fix

      tthread.Synchronize(tthread.CurrentThread,
        procedure
        begin

          if tabSensorsOptions.ActiveTab = self.tabGetCharger then
          begin
            timer_GetCharger.Enabled := true;
            fCurrentTimer := timer_GetCharger;
            exit;
          end;

          if tabSensorsOptions.ActiveTab = self.tabGetAccel then
          begin
            ResetGetAccel;
            timer_GetAccel.Enabled := true;
            fCurrentTimer := timer_GetAccel;
            exit;
          end;

          if tabSensorsOptions.ActiveTab = self.tabGetAnalogSensors then
          begin
            timer_GetAnalogSensors.Enabled := true;
            fCurrentTimer := timer_GetAnalogSensors;
            exit;
          end;

          if tabSensorsOptions.ActiveTab = self.tabGetDigitalSensors then
          begin
            ResetGetDigitalSensors;
            timer_GetDigitalSensors.Enabled := true;
            fCurrentTimer := timer_GetDigitalSensors;
            exit;
          end;

        end);
    end).Start;

end;

procedure TfrmMain.tabsLIDAROptionsChange(Sender: TObject);
begin

  tthread.CreateAnonymousThread(
    procedure
    begin
      sleep(250); // allows the UI a few momments of drawing time
      // ran into an awkward issue that this seemed to fix

      tthread.Synchronize(tthread.CurrentThread,
        procedure
        begin

          if tabsLIDAROptions.ActiveTab = tabLidar then
          begin
            com.SendCommand('Testmode ON');
            com.SendCommand('SetLDSRotation ON');
            timer_LIDAR.Enabled := true;
            fCurrentTimer := timer_LIDAR;
            exit;
          end;

        end);
    end).Start;

end;

procedure TfrmMain.tabsMainChange(Sender: TObject);
begin

  tthread.CreateAnonymousThread(
    procedure
    begin
      sleep(250); // allows the UI a few momments of drawing time
      // ran into an awkward issue that this seemed to fix

      tthread.Synchronize(tthread.CurrentThread,
        procedure
        begin

          if tabsMain.ActiveTab = tabSensors then
          begin
            tabSensorsOptions.TabIndex := 0;
            tabSensorsOptionsChange(nil);
            exit;
          end;

          if tabsMain.ActiveTab = tabInfo then
          begin
            self.tabsInfoOptions.TabIndex := 0;
            self.tabsInfoOptionsChange(nil);
            exit;
          end;

          if tabsMain.ActiveTab = tabTools then
          begin
            self.tabsLIDAROptions.TabIndex := 0;
            self.tabsLIDAROptionsChange(nil);
            exit;
          end;

        end);
    end).Start;

end;

procedure TfrmMain.tabsInfoOptionsChange(Sender: TObject);
begin
  tthread.CreateAnonymousThread(
    procedure
    begin
      sleep(250); // allows the UI a few momments of drawing time
      // ran into an awkward issue that this seemed to fix

      tthread.Synchronize(tthread.CurrentThread,
        procedure
        begin

          if tabsInfoOptions.ActiveTab = tabGetWarranty then
          begin
            timer_getWarranty.Enabled := true;
            fCurrentTimer := timer_getWarranty;
            exit;
          end;

          if tabsInfoOptions.ActiveTab = tabGetErr then
          begin
            ResetGetErr;
            timer_GetErr.Enabled := true;
            fCurrentTimer := timer_GetErr;
            exit;
          end;

          if tabsInfoOptions.ActiveTab = tabGetVersion then
          begin
            // setGetErr;
            timer_GetVersion.Enabled := true;
            fCurrentTimer := timer_GetVersion;
            exit;
          end;

          if tabsInfoOptions.ActiveTab = tabGetUsage then
          begin
            // setGetErr;
            timer_GetUsage.Enabled := true;
            fCurrentTimer := timer_GetUsage;
            exit;
          end;

        end);

    end).Start;
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
  neatoSettings.AutoDetectNeato := chkAutoDetect.IsChecked;
end;

procedure TfrmMain.ckShowIntensityLinesChange(Sender: TObject);
begin
  self.plotLIDAR.Repaint;
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
  pGetAccel: tGetAccel;
  pReadData: TStringList;
  v: double;
  r: Boolean;
begin

  if (com.com.Active = false) or (tabSensorsOptions.ActiveTab <> tabGetAccel) then
  begin
    timer_GetAccel.Enabled := false;
    exit;
  end;

  pGetAccel := tGetAccel.Create;

  pReadData := TStringList.Create;
  pReadData.Text := com.SendCommand(sGetAccel);
  pReadData.Text := stringreplace(pReadData.Text, ',', '=', [rfreplaceall]);

  r := pGetAccel.ParseText(pReadData);

  if r then
  begin
    lbl_PitchInDegreesValue.Text := pGetAccel.PitchInDegrees.ToString;
    lbl_RollInDegreesValue.Text := pGetAccel.RollInDegrees.ToString;
    lbl_XInGValue.Text := pGetAccel.XInG.ToString;
    lbl_YInGValue.Text := pGetAccel.YInG.ToString;
    lbl_ZInGValue.Text := pGetAccel.ZInG.ToString;
    lbl_SumInGValue.Text := pGetAccel.SumInG.ToString;

    v := pGetAccel.RollInDegrees;

    if v > 0 then
      v := -abs(v)
    else
      v := abs(v);

    _3DGetAccel.RotationAngle.Z := 90 + v;

    v := pGetAccel.PitchInDegrees;

    if v > 0 then
      v := -abs(v)
    else
      v := abs(v);

    _3DGetAccel.RotationAngle.Y := v;

  end;

  pReadData.Free;
  pGetAccel.Free;
end;

procedure TfrmMain.timer_GetChargerTimer(Sender: TObject);
var
  pGetCharger: tGetCharger;
  pReadData: TStringList;
  r: Boolean;
begin

  if (com.com.Active = false) or (tabSensorsOptions.ActiveTab <> tabGetCharger) then
  begin
    timer_GetCharger.Enabled := false;
    exit;
  end;

  pGetCharger := tGetCharger.Create;

  pReadData := TStringList.Create;
  pReadData.Text := com.SendCommand(sGetCharger);
  pReadData.Text := stringreplace(pReadData.Text, ',', '=', [rfreplaceall]);

  r := pGetCharger.ParseText(pReadData);

  if r then
  begin

    pb_FuelPercent.Value := pGetCharger.FuelPercent;
    pb_BattTempCAvg.Value := pGetCharger.BattTempCAvg;
    pb_VBattV.Value := pGetCharger.VBattV;
    pb_VextV.Value := pGetCharger.VExtV;
    pb_ChargermAH.Value := pGetCharger.Charger_mAH;
    pb_DischargermAH.Value := pGetCharger.Discharge_mAH;

    lbl_FuelPercent.Text := pGetCharger.FuelPercent.ToString + ' %';
    lbl_BattTempCAvg.Text := pGetCharger.BattTempCAvg.ToString + ' *';
    lbl_VbattV.Text := pGetCharger.VBattV.ToString + ' v';
    lbl_VextV.Text := pGetCharger.VExtV.ToString + ' v';
    lbl_ChargermAH.Text := pGetCharger.Charger_mAH.ToString;
    lbl_DischargermAH.Text := pGetCharger.Discharge_mAH.ToString;

    sw_BatteryOverTemp.IsChecked := pGetCharger.BatteryOverTemp;
    sw_ChargingActive.IsChecked := pGetCharger.ChargingActive;
    sw_ChargingEnabled.IsChecked := pGetCharger.ChargingEnabled;
    sw_ConfidentOnFuel.IsChecked := pGetCharger.ConfidentOnFuel;
    sw_OnReservedFuel.IsChecked := pGetCharger.OnReservedFuel;
    sw_EmptyFuel.IsChecked := pGetCharger.EmptyFuel;
    sw_BatteryFailure.IsChecked := pGetCharger.BatteryFailure;
    sw_ExtPwrPresent.IsChecked := pGetCharger.ExtPwrPresent;
    sw_ThermistorPresent.IsChecked := pGetCharger.ThermistorPresent;
  end;

  pReadData.Free;
  pGetCharger.Free;
end;

procedure TfrmMain.timer_getWarrantyTimer(Sender: TObject);
var
  pGetWarranty: tGetWarranty;
  pReadData: TStringList;
  r: Boolean;
begin

  if (com.com.Active = false) or (tabsInfoOptions.ActiveTab <> tabGetWarranty) then
  begin
    timer_getWarranty.Enabled := false;
    exit;
  end;

  pGetWarranty := tGetWarranty.Create;

  pReadData := TStringList.Create;
  pReadData.Text := com.SendCommand(sGetWarranty);
  pReadData.Text := stringreplace(pReadData.Text, ',', '=', [rfreplaceall]);

  r := pGetWarranty.ParseText(pReadData);

  if r then
  begin
    lbl_CumulativeCleaningTimeInSecsValue.Text := strtoint('$' + pGetWarranty.CumulativeCleaningTimeInSecs).ToString +
      ' seconds as ' + pGetWarranty.CumulativeCleaningTimeInSecsAsHours.ToString + ' hours';
    lbl_CumulativeBatteryCyclesValue.Text := inttostr(strtoint('$' + pGetWarranty.CumulativeBatteryCycles));
    lbl_ValidationCodeValue.Text := strtoint('$' + pGetWarranty.ValidationCode).ToString;
  end;

  pReadData.Free;
  pGetWarranty.Free;
end;

procedure TfrmMain.timer_PlaySoundTimer(Sender: TObject);
{ VAR
  idx: byte;
  r: string;
}
begin
  {
    idx := timer_PlaySound.Tag;

    r := com.SendCommand('PLAYSOUND SOUNDID ' + idx.ToString);

    if pos('out of range', r) > 0 then
    Memo1.Lines.Add('SoundID ' + idx.ToString + ' Not Supported')
    else
    Memo1.Lines.Add('SoundID ' + idx.ToString + ' Supported');

    inc(idx);

    if idx >= 256 then
    begin
    idx := 0;
    timer_PlaySound.Enabled := false;
    end;

    timer_PlaySound.Tag := idx;

  }
end;

procedure TfrmMain.timer_GetAnalogSensorsTimer(Sender: TObject);
var
  pGetAnalogSensors: tGetAnalogSensors;
  pReadData: TStringList;
  r: Boolean;
begin

  if (com.com.Active = false) or (tabSensorsOptions.ActiveTab <> tabGetAnalogSensors) then
  begin
    timer_GetAnalogSensors.Enabled := false;
    exit;
  end;

  pGetAnalogSensors := tGetAnalogSensors.Create;

  pReadData := TStringList.Create;
  pReadData.Text := com.SendCommand(sGetAnalogSensors);

  memoDebug.Lines.Text := pReadData.Text;

  r := pGetAnalogSensors.ParseText(pReadData);

  if r then
  begin

    pb_BatteryVoltage.Value := pGetAnalogSensors.BatteryVoltage.ValueDouble;

    lblBatteryVoltageValue.Text := pGetAnalogSensors.BatteryVoltage.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.BatteryVoltage._Unit;

    pb_BatteryCurrent.Value := pGetAnalogSensors.BatteryCurrent.ValueDouble;
    lblBatteryCurrentValue.Text := pGetAnalogSensors.BatteryCurrent.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.BatteryCurrent._Unit;

    pb_BatteryTemperature.Value := pGetAnalogSensors.BatteryTemperature.ValueDouble;
    lblBatteryTemperatureValue.Text := pGetAnalogSensors.BatteryTemperature.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.BatteryTemperature._Unit;

    pb_ExternalVoltage.Value := pGetAnalogSensors.ExternalVoltage.ValueDouble;
    lblExternalVoltageValue.Text := pGetAnalogSensors.ExternalVoltage.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.ExternalVoltage._Unit;

    lblAccelerometerXValue.Text := pGetAnalogSensors.AccelerometerX.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.AccelerometerX._Unit;
    lblAccelerometerYValue.Text := pGetAnalogSensors.AccelerometerY.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.AccelerometerY._Unit;
    lblAccelerometerZValue.Text := pGetAnalogSensors.AccelerometerZ.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.AccelerometerZ._Unit;

    lblCompassmeterXValue.Text := pGetAnalogSensors.CompassmeterX.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.CompassmeterX._Unit;
    lblCompassmeterYValue.Text := pGetAnalogSensors.CompassmeterY.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.CompassmeterY._Unit;
    lblCompassmeterZValue.Text := pGetAnalogSensors.CompassmeterZ.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.CompassmeterZ._Unit;

    lblGyroscopeXValue.Text := pGetAnalogSensors.GyroscopeX.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.GyroscopeX._Unit;
    lblGyroscopeYValue.Text := pGetAnalogSensors.GyroscopeY.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.GyroscopeY._Unit;
    lblGyroscopeZValue.Text := pGetAnalogSensors.GyroscopeZ.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.GyroscopeZ._Unit;

    lblIMUAccelerometerXValue.Text := pGetAnalogSensors.IMUAccelerometerX.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.IMUAccelerometerX._Unit;
    lblIMUAccelerometerYValue.Text := pGetAnalogSensors.IMUAccelerometerY.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.IMUAccelerometerY._Unit;
    lblIMUAccelerometerZValue.Text := pGetAnalogSensors.IMUAccelerometerZ.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.IMUAccelerometerZ._Unit;

    lblVacuumCurrentValue.Text := pGetAnalogSensors.VacuumCurrent.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.VacuumCurrent._Unit;
    lblWallSensorValue.Text := pGetAnalogSensors.WallSensor.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.WallSensor._Unit;
    lblDropSensorLeftValue.Text := pGetAnalogSensors.DropSensorLeft.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.DropSensorLeft._Unit;
    lblDropSensorRightValue.Text := pGetAnalogSensors.DropSensorRight.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.DropSensorRight._Unit;

    swMagSensorLeft.IsChecked := pGetAnalogSensors.MagSensorLeft.ValueBoolean;
    swMagSensorRight.IsChecked := pGetAnalogSensors.MagSensorRight.ValueBoolean;

  end;
  pReadData.Free;
  pGetAnalogSensors.Free;
end;

procedure TfrmMain.timer_GetDigitalSensorsTimer(Sender: TObject);
var
  pGetDigitalSensors: tGetDigitalSensors;
  pReadData: TStringList;
  r: Boolean;
begin

  if (com.com.Active = false) or (tabSensorsOptions.ActiveTab <> tabGetDigitalSensors) then
  begin
    timer_GetDigitalSensors.Enabled := false;
    exit;
  end;

  pGetDigitalSensors := tGetDigitalSensors.Create;

  pReadData := TStringList.Create;
  pReadData.Text := com.SendCommand(sGetDigitalSensors);
  memoDebug.Lines.Text := pReadData.Text;

  r := pGetDigitalSensors.ParseText(pReadData);

  if r then
  begin
    swSNSR_DC_JACK_IS_IN.IsChecked := pGetDigitalSensors.SNSR_DC_JACK_IS_IN.ValueBoolean;
    swSNSR_DUSTBIN_IS_IN.IsChecked := pGetDigitalSensors.SNSR_DUSTBIN_IS_IN.ValueBoolean;
    swSNSR_LEFT_WHEEL_EXTENDED.IsChecked := pGetDigitalSensors.SNSR_LEFT_WHEEL_EXTENDED.ValueBoolean;
    swSNSR_RIGHT_WHEEL_EXTENDED.IsChecked := pGetDigitalSensors.SNSR_RIGHT_WHEEL_EXTENDED.ValueBoolean;

    swLSIDEBIT.IsChecked := pGetDigitalSensors.LSIDEBIT.ValueBoolean;
    swLFRONTBIT.IsChecked := pGetDigitalSensors.LFRONTBIT.ValueBoolean;
    swLLDSBIT.IsChecked := pGetDigitalSensors.LLDSBIT.ValueBoolean;
    swRSIDEBIT.IsChecked := pGetDigitalSensors.RSIDEBIT.ValueBoolean;
  end;

  pReadData.Free;
  pGetDigitalSensors.Free;
end;

procedure TfrmMain.timer_GetErrTimer(Sender: TObject);
var
  pGetErr: tGetErr;
  pReadData: TStringList;
  idx: integer;
  r: Boolean;
begin

  if (com.com.Active = false) or (tabsInfoOptions.ActiveTab <> tabGetErr) then
  begin
    timer_GetErr.Enabled := false;
    exit;
  end;

  pGetErr := tGetErr.Create;

  pReadData := TStringList.Create;
  pReadData.Text := com.SendCommand(sGetErr);
  memoDebug.Lines.Text := pReadData.Text;

  r := pGetErr.ParseText(pReadData);

  if r then
  begin
    sgGetErr.RowCount := pGetErr.ErrorList.Count;
    for idx := 0 to pGetErr.ErrorList.Count - 1 do
    begin
      sgGetErr.Cells[0, idx] := pGetErr.ErrorList.Names[idx];
      sgGetErr.Cells[1, idx] := pGetErr.ErrorList.ValueFromIndex[idx];
    end;
  end;

  pReadData.Free;
  pGetErr.Free;
end;

procedure TfrmMain.timer_GetUsageTimer(Sender: TObject);
var
  pGetUsage: tGetUsage;
  pReadData: TStringList;
  r: Boolean;
begin

  if (com.com.Active = false) or (tabsInfoOptions.ActiveTab <> tabGetUsage) then
  begin
    timer_GetUsage.Enabled := false;
    exit;
  end;

  pGetUsage := tGetUsage.Create;

  pReadData := TStringList.Create;
  pReadData.Text := com.SendCommand(sGetUsage);
  memoDebug.Lines.Text := pReadData.Text;

  r := pGetUsage.ParseText(pReadData);

  if r then
  begin
    lblTotalCleaningTimeValue.Text := pGetUsage.Total_Cleaning_Time.ToString;
    lblTotalCleanedAreaValue.Text := pGetUsage.Total_Cleaned_Area.ToString;
    lblMainBrushRunTimeinSecValue.Text := pGetUsage.MainBrushRunTimeinSec.ToString;
    lblSideBrushRunTimeinSecValue.Text := pGetUsage.SideBrushRunTimeinSec.ToString;
    lblDirtbinRunTimeinSecValue.Text := pGetUsage.DirtbinRunTimeinSec.ToString;
    lblFilterTimeinSecValue.Text := pGetUsage.FilterTimeinSec.ToString;
  end;

  pReadData.Free;
  pGetUsage.Free;
end;

procedure TfrmMain.timer_LIDARTimer(Sender: TObject);

  procedure LoadCSV(ScanData: String; sg: TStringGrid);
  var
    i, j, Position, Count, edt1: integer;
    temp, tempField: string;
    FieldDel: char;
    Data: TStringList;
  begin
    Data := TStringList.Create;
    FieldDel := ',';
    Data.Text := ScanData;
    temp := Data[1];

    Count := 0;

    for i := 1 to length(temp) do
      if copy(temp, i, 1) = FieldDel then
        inc(Count);

    edt1 := Count + 1;

    sg.RowCount := Data.Count;

    for i := 0 to Data.Count - 1 do
    begin;
      temp := Data[i];
      if copy(temp, length(temp), 1) <> FieldDel then
        temp := temp + FieldDel;
      while Pos('"', temp) > 0 do
      begin
        Delete(temp, Pos('"', temp), 1);
      end;
      for j := 1 to edt1 do
      begin
        Position := Pos(FieldDel, temp);
        tempField := copy(temp, 0, Position - 1);

        sg.Cells[j - 1, i] := tempField;

        Delete(temp, 1, length(tempField) + 1);
      end;
    end;
    Data.Free;
  end;

  procedure MapLIDAR;

  Const
    D2R = 0.017453293; // PI divided by 180 degrees, multiply by this to get angle in degrees expressed in radians
    betaDegree = 82;
    // (degree) angle (for geometric correction) between laser beam and line parallel to the image plane
    bmm = 25; // (mm) distance (for geometric correction) between the rotation center and laser source along line parallel to the image plane

    Function CalcXCorrection(fiDegree, Distance: double): double;
    // Calculate x - add this to geometric correction to get object coordinates
    begin
      result := -SIN(fiDegree * D2R) * Distance;
    end;

    Function CalcYCorrection(Degree, Distance: double): double;
    // Calculate y - add this to geometric correction to get object coordinates
    begin
      result := Cos(Degree * D2R) * Distance;
    end;

    function CalcAlfaX(fiDegree: double): double;
    // Calculate x geometric correction - add this to x' and y' to get object coordinates
    var
      alfa: double;
    begin
      alfa := 180 - betaDegree + fiDegree;
      result := bmm * SIN(alfa * D2R);
    end;

    function CalcAlfaY(fiDegree: double): double;
    // Calculate y geometric correction - add this to x' and y' to get object coordinates
    var
      alfa: double;
    begin
      alfa := 180 - betaDegree + fiDegree;
      result := -bmm * Cos(alfa * D2R);
    end;

    function CalcFinalX(X1: double; X2: double): double; // Calculate x - object coordinates
    begin
      result := X1 + X2;
    end;

    function CalcFinalY(Y1: double; Y2: double): double; // Calculate y - object coordinates
    begin
      result := Y1 + Y2;
    end;

  var

    RowIDX: integer; // loop variable

    AngleInDegrees: double;
    DistInMM: double;
    intensity: cardinal;
    errorcode: integer;

    Xo: double; // X original calc
    Yo: double; // Y original calc

    Xc: double; // X 2nd calc (alfa?)
    Yc: double; // Y 2nd calc (alfa?)

    Xf: double; // X 3rd final calc
    Yf: double; // Y 3rd final calc

    xPixels, yPixels: double;
    PlotCenterOrigin: TPointF;
    newPlotPoint: TPointF;
    plotSpot: TRectF;

    scaleByValue: double;
    plotSpotSize: byte;

    scalebyX: double;
    scalebyY: double;

    p: TPointF;

  begin

    scaleByValue := 0.08; // don't know what to do here
    plotSpotSize := 4; // this guy too

    xPixels := plotLIDAR.AbsoluteWidth / 4;
    // Contain graph width within a quarter of the grid width (actually half because of neg values)
    yPixels := plotLIDAR.AbsoluteHeight / 4;
    // Contain graph height within a quarter of the grid height (actually half because of neg values)

    PlotCenterOrigin := PointF(plotLIDAR.AbsoluteWidth / 2, plotLIDAR.AbsoluteHeight / 2);
    // Calculate the center point of the plot grid

    plotLIDAR.Canvas.BeginScene;
    for RowIDX := 0 to sgLIDAR.RowCount - 1 do
    begin

      AngleInDegrees := strtoint(sgLIDAR.Cells[0, RowIDX]);
      DistInMM := strtoint(sgLIDAR.Cells[1, RowIDX]);
      intensity := strtoint(sgLIDAR.Cells[2, RowIDX]);
      errorcode := strtoint(sgLIDAR.Cells[3, RowIDX]);

      // Calculate x' and y' - add this to geometric correction to get object coordinates
      Xo := CalcXCorrection(AngleInDegrees, DistInMM);
      Yo := CalcYCorrection(AngleInDegrees, DistInMM);

      sgLIDAR.Cells[4, RowIDX] := Xo.ToString;
      sgLIDAR.Cells[5, RowIDX] := Yo.ToString;

      // Calculate x and y geometric correction - add this to x' and y' to get object coordinates
      Xc := CalcAlfaX(AngleInDegrees);
      Yc := CalcAlfaY(AngleInDegrees);

      sgLIDAR.Cells[6, RowIDX] := Xc.ToString;
      sgLIDAR.Cells[7, RowIDX] := Yc.ToString;

      // Calculate x and y - object coordinates

      Xf := CalcFinalX(Xo, Xc);
      Yf := CalcFinalY(Yo, Yc);

      sgLIDAR.Cells[8, RowIDX] := Xf.ToString;
      sgLIDAR.Cells[9, RowIDX] := Yf.ToString;

      // start in center point and create the new plot point
      // need to use plot's position on the form
      // then PlotCenterOrigin to get to the center of that
      // then add in our X,Y cords , with some scaling to fit... as X and Y can be big numbers
      // so it always needs to fit inside our plot.

      // assume a MIN / MAX of some sort of the final sample data is needed to figure this out?

      // need to be able to scale the values to make sure always fits inside plot grid area

      p.X := plotLIDAR.AbsoluteRect.Location.X;
      p.Y := plotLIDAR.AbsoluteRect.Location.Y;

      newPlotPoint.X := p.X + PlotCenterOrigin.X + (Xf * scaleByValue);
      newPlotPoint.Y := p.Y + PlotCenterOrigin.Y + (Yf * scaleByValue);

      {
        scalebyX := (plot.height / plot.width) *0.5; // * 0.001; //plot.Width * 0.0001;
        scalebyY := (plot.Height / plot.Width) * scalebyX;

        newPlotPoint.X := plot.Position.X + PlotCenterOrigin.X + (Xf * scaleByX);
        newPlotPoint.Y := plot.Position.Y + PlotCenterOrigin.Y + (Yf * scaleByY);
      }

      // Create the drawing area now.
      // Not sure how to adjust the width/height of the ellipse to scale up and down for the work area?

      plotSpot := TRectF.Create(newPlotPoint.X, newPlotPoint.Y, newPlotPoint.X + plotSpotSize,
        newPlotPoint.Y + plotSpotSize);

      plotLIDAR.Canvas.Stroke.Thickness := 1;

      if errorcode > 0 then
        intensity := 99999;

      case intensity of
        0 .. 511: // green
          intensity := talphacolorrec.Green;
        512 .. 1023:
          intensity := talphacolorrec.Yellow;
        1024 .. 1535:
          intensity := talphacolorrec.Blue;
        1536 .. 2047:
          intensity := talphacolorrec.Magenta;
        2048 .. 2559:
          intensity := talphacolorrec.Orange;
        2560 .. 99999:
          intensity := talphacolorrec.Red;
      end;

      plotLIDAR.Canvas.Fill.Color := TAlphaCOlor(intensity);
      plotLIDAR.Canvas.Stroke.Color := TAlphaCOlor(intensity);

      plotLIDAR.Canvas.Fill.Kind := TBrushKind.Solid;
      plotLIDAR.Canvas.FillEllipse(plotSpot, 1);

      plotLIDAR.Canvas.Fill.Kind := TBrushKind.Solid;

      newPlotPoint.X := p.X + PlotCenterOrigin.X + (Xf * scaleByValue) + (plotSpotSize div 2);
      newPlotPoint.Y := p.Y + PlotCenterOrigin.Y + (Yf * scaleByValue) + (plotSpotSize div 2);

      if ckShowIntensityLines.IsChecked then
        plotLIDAR.Canvas.DrawLine(TPointF.Create(p.X + PlotCenterOrigin.X, p.Y + PlotCenterOrigin.Y), newPlotPoint, 1);

    end;
    plotLIDAR.Canvas.EndScene;
  end;

var
  pReadData: TStringList;
begin

  if (com.com.Active = false) or (tabsLIDAROptions.ActiveTab <> tabLidar) then
  begin
    timer_LIDAR.Enabled := false;
    exit;
  end;

  pReadData := TStringList.Create; // LIDAR will just use a simple TStringList name/Value pair to work by

  pReadData.Text := trim(com.SendCommand('GetLDSScan'));
  memoDebug.Lines.Text := pReadData.Text;

  fLIDARCounter := fLIDARCounter + 1;

  if sbResetLIDARMapping.Value > 0 then
  begin
    if round(fLIDARCounter) >= round(sbResetLIDARMapping.Value) then
    begin
      plotLIDAR.Repaint;
      fLIDARCounter := 0;
    end;
  end;

  if pReadData.Count = 360 + 3 then // 360 data, plus header row, plus last row showing rotation speed
  begin
    pReadData.Delete(0); // delete first row
    pReadData.Delete(0); // delete first row again
    pReadData.Delete(360); // delete first row again
    LoadCSV(pReadData.Text, sgLIDAR);
    MapLIDAR;
  end;

  pReadData.Free;

end;

procedure TfrmMain.timer_GetVersionTimer(Sender: TObject);

  procedure PopulateRow(RowID: integer; item: tGetVersionFields);
  begin
    sgGetVersion.Cells[0, RowID] := item.Component;
    sgGetVersion.Cells[1, RowID] := item.Major;
    sgGetVersion.Cells[2, RowID] := item.Minor;
    sgGetVersion.Cells[3, RowID] := item.Build;
    sgGetVersion.Cells[4, RowID] := item.AUX;
    sgGetVersion.Cells[5, RowID] := item.AUX2;
  end;

var
  pGetVersion: tGetVersion;
  pReadData: TStringList;
  r: Boolean;
begin

  if (com.com.Active = false) or (tabsInfoOptions.ActiveTab <> tabGetVersion) then
  begin
    timer_GetVersion.Enabled := false;
    exit;
  end;

  pGetVersion := tGetVersion.Create;

  pReadData := TStringList.Create;
  pReadData.Text := com.SendCommand(sGetVersion);
  memoDebug.Lines.Text := pReadData.Text;

  r := pGetVersion.ParseText(pReadData);

  if r then
  begin
    sgGetVersion.RowCount := neato.GetVersion.iGetVersionRowCount;

    PopulateRow(0, pGetVersion.BaseID);
    PopulateRow(1, pGetVersion.Beehive_URL);
    PopulateRow(2, pGetVersion.BlowerType);
    PopulateRow(3, pGetVersion.Bootloader_Version);
    PopulateRow(4, pGetVersion.BrushMotorResistorPowerRating);
    PopulateRow(5, pGetVersion.BrushMotorResistorResistance);
    PopulateRow(6, pGetVersion.BrushMotorType);
    PopulateRow(7, pGetVersion.BrushSpeed);
    PopulateRow(8, pGetVersion.BrushSpeedEco);
    PopulateRow(9, pGetVersion.ChassisRev);
    PopulateRow(10, pGetVersion.DropSensorType);
    PopulateRow(11, pGetVersion.LCD_Panel);
    PopulateRow(12, pGetVersion.LDS_CPU);
    PopulateRow(13, pGetVersion.LDS_Serial);
    PopulateRow(14, pGetVersion.LDS_Software);
    PopulateRow(15, pGetVersion.LDSMotorType);
    PopulateRow(16, pGetVersion.Locale);
    PopulateRow(17, pGetVersion.MagSensorType);
    PopulateRow(18, pGetVersion.MainBoard_Serial_Number);
    PopulateRow(19, pGetVersion.MainBoard_Version);
    PopulateRow(20, pGetVersion.Model);
    PopulateRow(21, pGetVersion.NTP_URL);
    PopulateRow(22, pGetVersion.Nucleo_URL);
    PopulateRow(23, pGetVersion.QAState);
    PopulateRow(24, pGetVersion.Serial_Number);
    PopulateRow(25, pGetVersion.SideBrushPower);
    PopulateRow(26, pGetVersion.SideBrushType);
    PopulateRow(27, pGetVersion.SmartBatt_Authorization);
    PopulateRow(28, pGetVersion.SmartBatt_Data_Version);
    PopulateRow(29, pGetVersion.SmartBatt_Device_Chemistry);
    PopulateRow(30, pGetVersion.SmartBatt_Device_Name);
    PopulateRow(31, pGetVersion.SmartBatt_Manufacturer_Name);
    PopulateRow(32, pGetVersion.SmartBatt_Mfg_Year_Month_Day);
    PopulateRow(33, pGetVersion.SmartBatt_Serial_Number);
    PopulateRow(34, pGetVersion.SmartBatt_Software_Version);
    PopulateRow(35, pGetVersion.Software_Git_SHA);
    PopulateRow(36, pGetVersion.Software);
    PopulateRow(37, pGetVersion.Time_Local);
    PopulateRow(38, pGetVersion.Time_UTC);
    PopulateRow(39, pGetVersion.UI_Board_Hardware);
    PopulateRow(40, pGetVersion.UI_Board_Software);
    PopulateRow(41, pGetVersion.UI_Name);
    PopulateRow(42, pGetVersion.UI_Version);
    PopulateRow(43, pGetVersion.VacuumPwr);
    PopulateRow(44, pGetVersion.VacuumPwrEco);
    PopulateRow(45, pGetVersion.WallSensorType);
    PopulateRow(46, pGetVersion.WheelPodType);
  end;

  pReadData.Free;
  pGetVersion.Free;
end;

/// ///////////////////////////////////////////////////////////////
// Routines for doing biz work
/// ///////////////////////////////////////////////////////////////

procedure TfrmMain.toggleComs(disable: Boolean);
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
      if Pos('Help', r) > 0 then
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
    tabsMain.TabIndex := 0;
    tabSensorsOptions.TabIndex := 0;
    tabSensorsOptionsChange(nil);
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
