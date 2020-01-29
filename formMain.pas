{

  Possibly make a new TFrame that the rest of the frames can inherit from.
  In said new Frame, create a new create constructor to handle the staging up.

}

unit formMain;

interface

uses
{$IFDEF MSWINDOWS}
  Madexcept,
  Winsoft.FireMonkey.FComPort,
  dmSerial.Windows,
  WinAPI.Windows,
  FMX.Platform.WIN,
{$ENDIF}
  {Common neato units}
  Neato.Helpers,
  Neato.Settings,

  {D3-D7, DSeries Units}
  Neato.D.GetCharger,
  Neato.D.GetWarranty,
  Neato.D.GetAnalogSensors,
  Neato.D.GetDigitalSensors,
  Neato.D.GetErr,
  Neato.D.GetUsage,
  Neato.D.GetUserSettings,
  Neato.D.GetVersion,
  Neato.D.GetMotors,
  Neato.D.GetWifiInfo,
  Neato.D.GetWifiStatus,
  Neato.D.GetButtons,
  Neato.D.GetCalInfo,
  Neato.D.ClearFiles,
  Neato.D.GetSensor,

  {D3-D7, DSeries Frames}
  frame.D.GetCharger,
  frame.D.GetAnalogSensors,
  frame.D.GetDigitalSensors,
  frame.D.GetMotors,
  frame.D.GetButtons,
  frame.D.GetCalInfo,
  frame.D.GetWarranty,
  frame.D.GetErr,
  frame.D.GetVersion,
  frame.D.GetUsage,
  frame.D.GetUserSettings,
  frame.D.ClearFiles,
  frame.D.GetWifiInfo,
  frame.D.GetWifiStatus,
  frame.D.GetSensors,

  {XV Series Units}
  Neato.XV.GetCharger,
  Neato.XV.GetWarranty,
  Neato.XV.GetAnalogSensors,
  Neato.XV.GetDigitalSensors,
  Neato.XV.GetErr,
  Neato.XV.GetVersion,
  Neato.XV.GetMotors,
  Neato.XV.GetButtons,
  Neato.XV.GetCalInfo,
  Neato.XV.RestoreDefaults,
  Neato.XV.GetSchedule,
  Neato.XV.GetTime,
  Neato.XV.Clean,

  {XV Series Frames}
  frame.XV.GetCharger,
  frame.XV.GetAnalogSensors,
  frame.XV.GetDigitalSensors,
  frame.XV.GetMotors,
  frame.XV.GetButtons,
  frame.XV.GetCalInfo,
  frame.XV.GetWarranty,
  frame.XV.GetErr,
  frame.XV.GetVersion,
  frame.XV.RestoreDefaults,
  frame.XV.GetSchedule,
  frame.XV.GetTime,
  frame.XV.Clean,

  {XV and D Series Units}
  Neato.DXV.Playsound,
  Neato.DXV.GetAccel,
  Neato.DXV.GetLDSScan,
  Neato.DXV.SetFuelGauge,
  Neato.DXV.SetTime,
  Neato.DXV.SetSystemMode,
  Neato.DXV.SetLCD,
  Neato.DXV.SetLED,
  Neato.DXV.SetSchedule,
  Neato.DXV.SetWallFollower,
  Neato.DXV.SetDistanceCal,
  Neato.DXV.SetIEC,
  Neato.DXV.GetLifeStatLog,

  frame.DXV.GetAccel,
  frame.DXV.Playsound,
  frame.DXV.Terminal,
  frame.DXV.GetLDSScan,
  frame.DXV.SetFuelGauge,
  frame.DXV.SetTime,
  frame.DXV.SetSystemMode,
  frame.DXV.SetLCD,
  frame.DXV.SetLED,
  frame.DXV.SetSchedule,
  frame.DXV.SetWallFollower,
  frame.DXV.SetDistanceCal,
  frame.DXV.SetIEC,
  frame.DXV.GetLifeStatLog,

  {Everything else to run this}
  dmCommon,
  frame.Scripts,

  XSuperObject,
  XSuperJson,

  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.Rtti,
  Generics.Collections,

  FMX.Controls,
  FMX.Dialogs,
  FMX.Grid.Style,
  FMX.Types,
  FMX.Colors,
  FMX.StdCtrls,
  FMX.Memo,
  FMX.TMSChart,
  FMX.Edit,
  FMX.EditBox,
  FMX.SpinBox,
  FMX.Grid,
  FMX.ScrollBox,
  FMX.ListBox,
  FMX.Objects,
  FMX.Effects,
  FMX.Controls.Presentation,
  FMX.TabControl,
  FMX.Layouts,
  FMX.Forms,
  FMX.DateTimeCtrls,
  FMXTee.Engine,
  FMXTee.Series,
  FMXTee.Procs,
  FMXTee.Chart;

type

  TfrmMain = class(TForm)
    tabsMain: TTabControl;
    tabSetup: TTabItem;
    tabSensors: TTabItem;
    ScaledLayoutMain: TScaledLayout;
    tabsSensorsOptions: TTabControl;
    tabGetAccel: TTabItem;
    tabGetAnalogSensors: TTabItem;
    tabGetDigitalSensors: TTabItem;
    tabInfo: TTabItem;
    tabsInfoOptions: TTabControl;
    tabGetUsage: TTabItem;
    tabGetUserSettings: TTabItem;
    tabGetVersion: TTabItem;
    tabWiFi: TTabItem;
    tabsWifiOptions: TTabControl;
    tabGetWifiInfo: TTabItem;
    tabGetWifiStatus: TTabItem;
    tabGetWarranty: TTabItem;
    tabGetErr: TTabItem;
    tabTools: TTabItem;
    tabsToolOptions: TTabControl;
    timer_LIDAR: TTimer;
    tabGetSensor: TTabItem;
    pnlStatusBar: trectangle;
    ColorBoxRX: TColorBox;
    LabelRX: TLabel;
    ColorBoxTX: TColorBox;
    LabelTX: TLabel;
    ColorBoxCTS: TColorBox;
    LabelCTS: TLabel;
    ColorBoxDSR: TColorBox;
    LabelDSR: TLabel;
    ColorBoxRLSD: TColorBox;
    LabelRLSD: TLabel;
    ColorBoxBreak: TColorBox;
    LabelBreak: TLabel;
    chkTestMode: TCheckBox;
    tabGetCalInfo: TTabItem;
    pnlSetupDetails: trectangle;
    tabClearFiles: TTabItem;
    lblNotSupported: TLabel;
    ShadowEffect1: TShadowEffect;
    tabRestoreDefaults: TTabItem;
    tabClean: TTabItem;
    tabDiagTest: TTabItem;
    tabGetConfiguredWifiNetworks: TTabItem;
    tabSetWifi: TTabItem;
    tabMotors: TTabItem;
    tabsMotorOptions: TTabControl;
    tabGetMotors: TTabItem;
    tabSetMotor: TTabItem;
    tabPower: TTabItem;
    tabsPowerOptions: TTabControl;
    tabGetCharger: TTabItem;
    tabSetFuelGauge: TTabItem;
    tabSetSystemMode: TTabItem;
    tabLidar: TTabItem;
    tabsLidarOptions: TTabControl;
    tabGetLDSScan: TTabItem;
    tabLidarView: TTabItem;
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
    pnlLidarTop: trectangle;
    sbResetLIDARMapping: TSpinBox;
    lblResetLIDARmapping: TLabel;
    btnLidarStart: TButton;
    chkChartShowLabels: TCheckBox;
    chkLidarHideCalc: TCheckBox;
    spinLidarDrawEvery: TSpinBox;
    lblMarkerCount: TLabel;
    rectLidarChart: trectangle;
    plotLidar: TChart;
    Series1: TPointSeries;
    Series2: TPointSeries;
    tabSetBatteryTest: TTabItem;
    tabSetBrushControlParams: TTabItem;
    tabButtons: TTabItem;
    tabsButtonOptions: TTabControl;
    tabGetButtons: TTabItem;
    tabsSerialOptions: TTabControl;
    tabSerialSettings: TTabItem;
    pnlSerialTop: trectangle;
    lblSetupComPort: TLabel;
    cbCOM: TComboBox;
    chkAutoDetect: TCheckBox;
    lblConnect: TLabel;
    swConnect: TCheckBox;
    imgRobot: TImage;
    shadowBotImage: TShadowEffect;
    lblSetupRobotName: TLabel;
    GlowEffect1: TGlowEffect;
    lblRobotModel: TLabel;
    ShadowEffect2: TShadowEffect;
    tabAbout: TTabItem;
    ShadowEffectmemoAbout: TShadowEffect;
    RectangleaboutMemo: trectangle;
    memoAbout: TMemo;
    tabDebug: TTabItem;
    tabsDebuggerOptions: TTabControl;
    tabDebugTerminal: TTabItem;
    tabDebugRawData: TTabItem;
    memoDebug: TMemo;
    pnlDebugTerminalTop: trectangle;
    btnDebugRawDataClear: TButton;
    tabScripts: TTabItem;
    tabTime: TTabItem;
    tabsTimeOptions: TTabControl;
    tabSetTime: TTabItem;
    tabGetTime: TTabItem;
    tabGetSchedule: TTabItem;
    tabSetIEC: TTabItem;
    tabSetLCD: TTabItem;
    tabSetLED: TTabItem;
    tabSetSchedule: TTabItem;
    tabSetNavigationMode: TTabItem;
    tabSetNTPTime: TTabItem;
    tabSetUsage: TTabItem;
    tabPlaySound: TTabItem;
    lblPlaysoundIDX: TLabel;
    tabSetUserSettings: TTabItem;
    tabTestLDS: TTabItem;
    edIPAddress: TEdit;
    lblConnectIP: TLabel;
    edIPPort: TSpinBox;
    lblConnectPort: TLabel;
    swIPConnection: TSwitch;
    lblConnectIPEnabled: TLabel;
    tabSetWallFollower: TTabItem;
    tabSetDistanceCal: TTabItem;
    tabGetLifeStatLog: TTabItem;

    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);

    procedure chkAutoDetectChange(Sender: TObject);
    procedure chkTestModeChange(Sender: TObject);

    procedure swConnectChange(Sender: TObject);

    procedure timer_LIDARTimer(Sender: TObject);
    procedure tabControlChange(Sender: TObject);
    procedure tabClickRepaint(Sender: TObject);
    procedure btnDebugRawDataClearClick(Sender: TObject);
    procedure btnLidarStartClick(Sender: TObject);
    procedure chkChartShowLabelsChange(Sender: TObject);
    procedure spinLidarDrawEveryChange(Sender: TObject);
    procedure chkLidarHideCalcChange(Sender: TObject);

  private

    fLIDARCounter: single;
    fPlaySoundAborted: Boolean;

    // fActiveTabControl: TTabControl;
    // form events

    procedure onIDLE(Sender: TObject; var done: Boolean); // our idle code

    // COM Events
    procedure FComPortAfterOpen(ComPort: TFComPort);
    procedure FComPortAfterClose(ComPort: TFComPort);
    procedure FComPortLineError(Sender: TObject; LineErrors: TLineErrors);
    procedure FComPortError(Sender: TObject); // mine not winsofts
    procedure FComPortDeviceUpdate(Sender: TObject; const DeviceName: string);

    procedure comConnect; // serial connect
    procedure comDisconnect; // serial disconnect

  public

    // DSeries Frames
    DGetCharger: TframeDGetCharger;
    DGetAnalogSensors: TframeDGetAnalogSensors;
    DGetDigitalSensors: TframeDGetDigitalSensors;
    DGetMotors: TframeDGetMotors;
    DGetButtons: TframeDGetButtons;
    DGetCalInfo: TframeDGetCalInfo;
    DGetWarranty: TframeDGetWarranty;
    DGetErr: TframeDGetErr;
    DGetVersion: TframeDGetVersion;
    DGetUsage: TframeDGetUsage;
    DGetUserSettings: TframeDGetUserSettings;
    DClearFiles: TframeDClearFiles;
    DGetWifiInfo: TframeDGetWifiInfo;
    DGetWifiStatus: TframeDGetWifiStatus;
    DGetSensors: TframeDGetSensors;

    // XVSeries Frames

    XVGetCharger: TframeXVGetCharger;
    XVGetAnalogSensors: TframeXVGetAnalogSensors;
    XVGetDigitalSensors: TframeXVGetDigitalSensors;
    XVGetMotors: TframeXVGetMotors;
    XVGetButtons: TframeXVGetButtons;
    XVGetCalInfo: TframeXVGetCalInfo;
    XVGetWarranty: TframeXVGetWarranty;
    XVGetErr: TframeXVGetErr;
    XVGetVersion: TframeXVGetVersion;
    XVRestoreDefaults: TframeXVRestoreDefaults;
    XVGetSchedule: TframeXVGetSchedule;
    XVGetTime: TframeXVGetTime;
    XVClean: TFrameXVClean;

    // common tabs
    DXVPlaySound: TframeDXVPlaySound;
    DXVTerminal: TframeDXVTerminal;
    DXVGetAccel: TframeDXVGetAccel;
    DXVGetLDSScan: TframeDXVGetLDSScan;
    DXVSetFuelGauge: TframeDXVSetFuelGauge;
    DXVSetTime: TframeDXVSetTime;
    DXVSetSystemMode: TframeDXVSetSystemMode;
    DXVSetLCD: TframeDXVSetLCD;
    DXVSetLED: TframeDXVSetLED;
    DXVSetSchedule: TframeXVSetSchedule;
    DXVSetWallFollower: TframeDXVSetWallFollower;
    DXVSetDistanceCal: TframeDXVSetDistanceCal;
    DXVSetIEC: TframeDXVSetIEC;
    DXVGetLifeStatLog: TframeDXVGetLifeStatLog;

    Procedure StageTabs; // create and place our tabs depending on model
    procedure ResetTabs; // Reset tab states
    procedure PopulateCOMPorts; // repopulate drop down with active com ports
    procedure toggleComs(disable: Boolean); // connect/disconnect basically

  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

procedure TfrmMain.FormCreate(Sender: TObject);
var
  idx: integer;
begin

  dm.chkTestMode := chkTestMode;
  chkLidarHideCalc.IsChecked := true;

  memoAbout.Lines.Add('Neato Toolio Version : ' + GetAppVersionStr);
  memoAbout.Lines.Add('');
  memoAbout.Lines.Add('Created by Steven Chesser');
  memoAbout.Lines.Add('Contact : steven.chesser@twc.com');
  memoAbout.Lines.Add('');
  memoAbout.Lines.Add('');
  memoAbout.Lines.Add('');
  memoAbout.Lines.Add('Thanks to the Neato group at @ http://www.robotreviews.com/chat/viewforum.php?f=20');
  memoAbout.Lines.Add('');
  memoAbout.Lines.Add('Thanks to Ed Vickery for loaning out an XV for testing!');
  memoAbout.Lines.Add('');
  memoAbout.Lines.Add('');
  memoAbout.Lines.Add('Neato Toolio is free.  It is open-source (mostly).  It comes with no guarantee.');
  memoAbout.Lines.Add('Github @ https://github.com/jdredd87/NeatoToolio');
  memoAbout.Lines.Add('');
  memoAbout.Lines.Add('Neato Toolio is use at your own risk!');

{$IFDEF ANDORID}
  application.onException := self.onException;
{$ENDIF}
  lblSetupRobotName.Text := '';
  lblRobotModel.Text := '';

  try
    deletefile('Neato.D.toolio.log');
  except
  end;

  application.onIDLE := self.onIDLE;

  ResetTabs;
  StageTabs;

  chkAutoDetect.IsChecked := neatoSettings.AutoDetectNeato;
  chkAutoDetectChange(nil);

  dm.com.onError := FComPortError;
  dm.com.Serial.OnLineError := FComPortLineError;
  dm.com.Serial.afterclose := FComPortAfterClose;
  dm.com.Serial.afteropen := FComPortAfterOpen;
  dm.com.Serial.OnDeviceArrival := FComPortDeviceUpdate;
  dm.com.Serial.OnDeviceRemoved := FComPortDeviceUpdate;
  dm.com.FComSignalRX.ColorBox := self.ColorBoxRX;
  dm.com.FComSignalCTS.ColorBox := self.ColorBoxCTS;
  dm.com.FComSignalBreak.ColorBox := self.ColorBoxBreak;
  dm.com.FComSignalRLSD.ColorBox := self.ColorBoxRLSD;
  dm.com.FComSignalDSR.ColorBox := self.ColorBoxDSR;
  dm.com.FComSignalTX.ColorBox := self.ColorBoxTX;
  dm.com.fmemoDebug := memoDebug;

  for idx := 0 to self.ComponentCount - 1 do
  begin
    if components[idx] is TTabItem then
      TTabItem(components[idx]).OnClick := tabClickRepaint;

    if components[idx] is TTabControl then
    begin
      TTabControl(components[idx]).OnChange := tabControlChange;
      TTabControl(components[idx]).ActiveTab := nil;
    end;
  end;

  // make sure we are at the first tab to do connection
  // otherwise looks dumb with nothing loaded up in view

  tabsMain.TabIndex := 0;
  tabsSerialOptions.TabIndex := 0;

  tthread.CreateAnonymousThread(
    procedure
    begin
      sleep(500); // wait a second before populating comports
      tthread.Synchronize(tthread.CurrentThread,
        procedure
        begin
          PopulateCOMPorts;
        end);
    end).start;

  /// self.frameScripts.init;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  LoadImageID('NeatoLogo', self.imgRobot);
end;


// can use this event that when IDLE happens, which is very often and fast
// to enable/disable things , such as send buttons when com is open or not
// quick and easy way to keep UI up to date depending on com status

procedure TfrmMain.onIDLE(Sender: TObject; var done: Boolean);
begin
  {
    if dm.ActiveTab = nil then
    begin
    tabsMain.TabIndex := 0;
    tabSetup.Index := 0;
    dm.ActiveTab := tabSerialSettings;
    if NOT dm.com.Serial.Active then
    begin
    chkTestMode.IsChecked := false;
    toggleComs(false);
    end;
    end;
  }
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  idx: integer;
begin
  StopTimers;
  // make sure all onChange events are gone
  // as it seems these can trigger on closeing

  tabsMain.OnChange := nil;
  tabsSensorsOptions.OnChange := nil;
  tabsInfoOptions.OnChange := nil;
  tabsWifiOptions.OnChange := nil;

  // make sure timers are disabled so they quit doing work
  for idx := 0 to self.ComponentCount - 1 do
    if components[idx] is TTimer then
      TTimer(components[idx]).Enabled := false;

  // if com is open still.. so lets make sure we turn testmode back OFF as we are done
  if dm.com.Serial.Active then
  begin
    try
      dm.com.SendCommand('testmode OFF'); // make sure to turn this off when close app
      dm.com.SendCommand('testmode OFF'); // make sure to turn this off when close app
      dm.com.SendCommand('testmode OFF'); // make sure to turn this off when close app
    finally
    end;
  end;

  CanClose := true;
end;

procedure TfrmMain.FComPortAfterClose(ComPort: TFComPort);
begin
  StopTimers;
end;

procedure TfrmMain.FComPortAfterOpen(ComPort: TFComPort);
begin
  StopTimers;
end;

procedure TfrmMain.FComPortLineError(Sender: TObject; LineErrors: TLineErrors);
begin
  StopTimers;

  if leBreak in LineErrors then
    FMX.Dialogs.MessageDlg('Break detected', TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
  if leDeviceNotSelected in LineErrors then
    FMX.Dialogs.MessageDlg('Device not selected', TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
  if leFrame in LineErrors then
    FMX.Dialogs.MessageDlg('Frame error', TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
  if leIO in LineErrors then
    FMX.Dialogs.MessageDlg('IO error', TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
  if leMode in LineErrors then
    FMX.Dialogs.MessageDlg('Mode error', TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
  if leOutOfPaper in LineErrors then
    FMX.Dialogs.MessageDlg('Out of paper', TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
  if leOverrun in LineErrors then
    FMX.Dialogs.MessageDlg('Overrun error', TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
  if leDeviceTimeOut in LineErrors then
    FMX.Dialogs.MessageDlg('Device timeout', TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
  if leRxOverflow in LineErrors then
    FMX.Dialogs.MessageDlg('Receiver overflow', TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
  if leParity in LineErrors then
    FMX.Dialogs.MessageDlg('Parity error', TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
  if leTxFull in LineErrors then
    FMX.Dialogs.MessageDlg('Transmitter full', TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
end;

procedure TfrmMain.FComPortError(Sender: TObject);
begin
  StopTimers;

  if dm.com.errorcode <> 0 then
    showmessage('COM Issue #' + dm.com.errorcode.ToString + ' : ' + dm.com.Error);

  try
    dm.com.Serial.Active := false;
  finally
  end;

  swConnect.IsChecked := false;
  chkAutoDetect.Enabled := true;
  cbCOM.Enabled := true;
end;

procedure TfrmMain.FComPortDeviceUpdate(Sender: TObject; const DeviceName: string);
begin
  if cbCOM.DroppedDown then
    cbCOM.DropDown;
  cbCOM.ItemIndex := -1;
  PopulateCOMPorts;
end;

procedure TfrmMain.swConnectChange(Sender: TObject);
begin
  StopTimers;
  toggleComs(swConnect.IsChecked);
end;

procedure TfrmMain.btnDebugRawDataClearClick(Sender: TObject);
begin
  memoDebug.Lines.Clear;
end;

procedure TfrmMain.chkAutoDetectChange(Sender: TObject);
begin
  cbCOM.Enabled := NOT chkAutoDetect.IsChecked;
  swConnect.IsChecked := false;
  neatoSettings.AutoDetectNeato := chkAutoDetect.IsChecked;
end;

procedure TfrmMain.chkChartShowLabelsChange(Sender: TObject);
begin
  plotLidar.Series[0].Marks.Visible := chkChartShowLabels.IsChecked;
  plotLidar.Series[0].Marks.DrawEvery := round(spinLidarDrawEvery.Value);
  spinLidarDrawEvery.Enabled := chkChartShowLabels.IsChecked;
end;

procedure TfrmMain.chkLidarHideCalcChange(Sender: TObject);
begin
  case chkLidarHideCalc.IsChecked of
    true:
      begin
        sgLIDAR.Visible := false;
        plotLidar.Width := plotLidar.Width + 100;
        plotLidar.height := plotLidar.height + 130;
      end;
    false:
      begin
        plotLidar.Width := plotLidar.Width - 100;
        plotLidar.height := plotLidar.height - 130;
        sgLIDAR.Visible := true;
      end;
  end;
end;

procedure TfrmMain.spinLidarDrawEveryChange(Sender: TObject);
begin
  plotLidar.Series[0].Marks.DrawEvery := round(spinLidarDrawEvery.Value);
end;

procedure TfrmMain.chkTestModeChange(Sender: TObject);
begin
  if assigned(CurrentTimer) then
    CurrentTimer.Enabled := false;

  case chkTestMode.IsChecked of
    true:
      dm.com.SendCommand('TestMode ON');
    false:
      dm.com.SendCommand('TestMode OFF');
  end;

  if assigned(CurrentTimer) then
    CurrentTimer.Enabled := true;
end;

procedure TfrmMain.tabClickRepaint(Sender: TObject);
begin
  if (Sender) is TTabItem then
    TTabItem(Sender).Repaint;
end;

procedure TfrmMain.timer_LIDARTimer(Sender: TObject);

  procedure MapLIDAR;

  Const
    D2R = 0.017453293;
    // PI divided by 180 degrees, multiply by this to get angle in degrees expressed in radians
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

  begin

    scaleByValue := 0.16; // don't know what to do here
    plotSpotSize := 4; // this guy too

    // xPixels := plotLidar.Width / 4;
    // Contain graph width within a quarter of the grid width (actually half because of neg values)
    // yPixels := plotLidar.Height / 4;
    // Contain graph height within a quarter of the grid height (actually half because of neg values)
    // PlotCenterOrigin := PointF(plotLidar.Width / 2, plotLidar.Height / 2);
    // Calculate the center point of the plot grid

    plotLidar.BeginUpdate;
    sgLIDAR.BeginUpdate;

    if sbResetLIDARMapping.Value > 0 then
    begin
      if round(fLIDARCounter) >= round(sbResetLIDARMapping.Value) then
      begin
        // plotLidar.series.Items[0].Points.Clear;
        plotLidar.Series[0].Clear;
        plotLidar.Series[1].Clear;
        fLIDARCounter := 0;
      end;
    end;

    for RowIDX := 0 to sgLIDAR.RowCount - 1 do
    begin

      AngleInDegrees := strtoint(sgLIDAR.Cells[0, RowIDX]);
      DistInMM := strtoint(sgLIDAR.Cells[1, RowIDX]);
      intensity := strtoint(sgLIDAR.Cells[2, RowIDX]);
      errorcode := strtoint(sgLIDAR.Cells[3, RowIDX]);

      // if errorcode <> 0 then   continue;

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

      newPlotPoint.X := plotLidar.position.X + PlotCenterOrigin.X + (Xf * scaleByValue);
      newPlotPoint.Y := plotLidar.position.Y + PlotCenterOrigin.Y + (Yf * scaleByValue);

      if (newPlotPoint.X > 1000) or (newPlotPoint.X < -1000) then
        continue;

      if (newPlotPoint.Y > 1000) or (newPlotPoint.Y < -1000) then
        continue;

      { if newPlotPoint.X > maxx then
        maxx := newPlotPoint.X;

        if newPlotPoint.Y > maxy then
        maxy := newPlotPoint.Y;

        if newPlotPoint.X < minx then
        minx := newPlotPoint.X;

        if newPlotPoint.Y < miny then
        miny := newPlotPoint.Y;
      }
      // caption := 'MaxX = '+maxx.ToString + ' MaxY = '+maxy.ToString + '   ||   MinX = '+minx.ToString+' MinY = '+miny.ToString;

      if errorcode > 0 then
        plotLidar.Series[1].AddXY(newPlotPoint.X, newPlotPoint.Y, '', talphacolorrec.Red)
        // plotLidar.series.Items[0].AddXYPoint(newPlotPoint.X, newPlotPoint.Y)
      else
        plotLidar.Series[0].AddXY(newPlotPoint.X, newPlotPoint.Y, '', talphacolorrec.green);
      // plotLidar.series.Items[0].AddXYPoint(newPlotPoint.X, newPlotPoint.Y);

      if errorcode > 0 then
        intensity := 99999;

      case intensity of
        0 .. 511: // green
          intensity := talphacolorrec.green;
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

    end;

    plotLidar.EndUpdate;
    sgLIDAR.EndUpdate;

  end;

var
  pReadData: TStringList;
begin

  if (dm.com.Serial.Active = false) or (dm.ActiveTab <> tabLidarView) then
  begin
    btnLidarStart.IsPressed := false;
    self.btnLidarStartClick(Sender);
    timer_LIDAR.Enabled := false;
    exit;
  end;

  pReadData := TStringList.Create; // LIDAR will just use a simple TStringList name/Value pair to work by

  pReadData.Text := trim(dm.com.SendCommand('GetLDSScan'));

  memoDebug.BeginUpdate;
  memoDebug.Lines.Add(pReadData.Text);
  memoDebug.GoToTextEnd;
  memoDebug.EndUpdate;

  fLIDARCounter := fLIDARCounter + 1;

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

procedure TfrmMain.btnLidarStartClick(Sender: TObject);
begin

  if NOT btnLidarStart.IsPressed then
  begin
    timer_LIDAR.Enabled := false;
    dm.com.SendCommand('Setldsrotation off');
    sleep(250);
    dm.com.SendCommand('Setldsrotation off');
    sleep(250);
    btnLidarStart.ResetFocus;
    btnLidarStart.Text := 'Start';
  end
  else
  begin

    chkTestMode.IsChecked := true;
    sleep(250);
    chkTestMode.IsChecked := true;
    sleep(250);
    dm.com.SendCommand('Setldsrotation on');
    sleep(250);
    dm.com.SendCommand('Setldsrotation on');
    sleep(250);
    timer_LIDAR.Enabled := true;
    btnLidarStart.ResetFocus;
    btnLidarStart.Text := 'Stop';
  end;

end;

/// ///////////////////////////////////////////////////////////////
// Routines for doing biz work
/// ///////////////////////////////////////////////////////////////

procedure TfrmMain.toggleComs(disable: Boolean);
begin

  chkAutoDetect.Enabled := not disable;
  cbCOM.Enabled := not disable;

  chkTestMode.Enabled := false;
  chkTestMode.IsChecked := false;
  if disable then
    comConnect
  else
    comDisconnect;
end;

procedure TfrmMain.comConnect;
var
  idx: integer;
  r: string;

  gGetWifiStatusD: tGetWifiStatusD;
  gGetVersionD: tGetVersionD;

  gGetVersionXV: tGetVersionXV;

  ReadData: TStringList;

  botFound: Boolean;
begin
  ResetTabs;
  botFound := false;
  lblSetupRobotName.Text := '';
  lblRobotModel.Text := '';

  if chkAutoDetect.IsChecked then
  begin
    dm.com.onError := nil;

    for idx := 0 to cbCOM.Items.Count - 1 do
    begin
      if not dm.com.open(cbCOM.Items[idx]) then
        continue;

      r := dm.com.SendCommand('HELP');
      if pos('Help', r) > 0 then
      begin
        cbCOM.ItemIndex := idx;
        break;
      end;
      dm.com.Close;
    end;
    dm.com.onError := FComPortError;
  end;

  if cbCOM.ItemIndex = -1 then
  begin
    swConnect.IsChecked := false;
    swConnectChange(nil);
    showmessage('No COM Port selected');
  end
  else
  begin
    ReadData := TStringList.Create;
    dm.com.open(cbCOM.Items[cbCOM.ItemIndex]);

    r := dm.com.SendCommandAndWaitForValue(sGetVersion, 6000, ^Z, 1);

    if pos('BotVac', r) > 0 then
      NeatoType := neatoBotVac
    else if pos('XV', r) > 0 then
      NeatoType := neatoXV;

    if (r <> '') and (NeatoType = neatoBotVac) then
    begin
      r := dm.com.SendCommand(sGetWifiStatus);

      gGetWifiStatusD := tGetWifiStatusD.Create;
      ReadData.Text := r;

      if gGetWifiStatusD.ParseText(ReadData) then
        lblSetupRobotName.Text := gGetWifiStatusD.Robot_Name;

      freeandnil(gGetWifiStatusD);

      r := dm.com.SendCommand(sGetVersion);

      gGetVersionD := tGetVersionD.Create;
      ReadData.Text := r;

      if gGetVersionD.ParseText(ReadData) then
      begin
        lblRobotModel.Text := stringreplace(gGetVersionD.Model.Major, 'BotVac', 'BotVac' + #13,
          [rfreplaceall, rfignorecase]);

        if pos('BotVacD3', gGetVersionD.Model.Major) > 0 then
        begin
          LoadImageID('NeatoD3', imgRobot);
          LoadImageID('NeatoD3', DXVGetAccel._3DGetAccel);
        end;

        if pos('BotVacD4', gGetVersionD.Model.Major) > 0 then
        begin
          LoadImageID('NeatoD4', imgRobot);
          LoadImageID('NeatoD4', DXVGetAccel._3DGetAccel);
        end;

        if pos('BotVacD5', gGetVersionD.Model.Major) > 0 then
        begin
          LoadImageID('NeatoD5', imgRobot);
          LoadImageID('NeatoD5', DXVGetAccel._3DGetAccel);
        end;

        if pos('BotVacD6', gGetVersionD.Model.Major) > 0 then
        begin
          LoadImageID('NeatoD6', imgRobot);
          LoadImageID('NeatoD6', DXVGetAccel._3DGetAccel);
        end;

        if pos('BotVacD7', gGetVersionD.Model.Major) > 0 then
        begin
          LoadImageID('NeatoD7', imgRobot);
          LoadImageID('NeatoD7', DXVGetAccel._3DGetAccel);
        end;

        if pos('BotVacConnected', gGetVersionD.Model.Major) > 0 then
        begin
          LoadImageID('NeatoBotVac', imgRobot);
          LoadImageID('NeatoBotVac', DXVGetAccel._3DGetAccel);
        end;
      end;
      freeandnil(gGetVersionD);
    end;

    if (r <> '') and (NeatoType = neatoXV) then
    begin
      gGetVersionXV := tGetVersionXV.Create;
      ReadData.Text := r;

      if gGetVersionXV.ParseText(ReadData) then
      begin
        lblRobotModel.Text := gGetVersionXV.ModelID.Minor;

        if pos('XV16', gGetVersionXV.ModelID.Minor) > 0 then
        begin
          LoadImageID('XV16', imgRobot);
          LoadImageID('NeatoXV', DXVGetAccel._3DGetAccel); // generic model
        end;

      end;
      freeandnil(gGetVersionXV);
    end;

    botFound := lblRobotModel.Text <> '';

    if not botFound then
    begin
      showmessage('No Neato Found on this COM Port');
      swConnect.IsChecked := false;
      chkAutoDetect.Enabled := true;
      cbCOM.Enabled := true;
    end;
  end;

  chkTestMode.Enabled := dm.com.Serial.Active;
  ResetTabs;

end;

procedure TfrmMain.comDisconnect;
begin
  try
    dm.com.Close;
  finally
    lblSetupRobotName.Text := '';
    lblRobotModel.Text := '';
    LoadImageID('NeatoLogo', imgRobot);
    ResetTabs;
  end;
end;

procedure TfrmMain.PopulateCOMPorts;
var
  comList: TStringList;
begin
  try
    swConnect.IsChecked := false;
    StopTimers;
    toggleComs(false);
  except
  end;
  comList := TStringList.Create;
  dm.com.Serial.EnumComDevices(comList);
  cbCOM.BeginUpdate;
  cbCOM.Items.Assign(comList);
  cbCOM.EndUpdate;
  comList.Free;
  tabsMain.Enabled := true;
end;

procedure TfrmMain.tabControlChange(Sender: TObject);
var
  timerStarter: TTimer;
begin

  dm.ActiveTab := TTabControl(Sender).ActiveTab;

  TTabControl(Sender).BeginUpdate;

  timerStarter := nil;
  StopTimers;

  if TTabControl(Sender) = tabsMain then
  begin
    tabsSensorsOptions.TabIndex := -1;
    tabsInfoOptions.TabIndex := -1;
    tabsWifiOptions.TabIndex := -1;
    tabsToolOptions.TabIndex := -1;
    tabsMotorOptions.TabIndex := -1;
    tabsPowerOptions.TabIndex := -1;
    tabsLidarOptions.TabIndex := -1;
    tabsButtonOptions.TabIndex := -1;
    tabsSerialOptions.TabIndex := -1;
    tabsDebuggerOptions.TabIndex := -1;
    tabsTimeOptions.TabIndex := -1;
  end;

  if TTabControl(Sender).ActiveTab = tabGetCharger then
    case NeatoType of
      neatoBotVac:
        begin
          timerStarter := DGetCharger.timer_GetData;
          XVGetCharger.Visible := false;
          DGetCharger.Visible := true;
        end;
      neatoXV:
        begin
          timerStarter := XVGetCharger.timer_GetData;
          DGetCharger.Visible := false;
          XVGetCharger.Visible := true;
        end;
    end;

  if TTabControl(Sender).ActiveTab = tabGetAccel then
  begin
    timerStarter := DXVGetAccel.timer_GetData;
    DXVGetAccel.Visible := true;
  end;

  if TTabControl(Sender).ActiveTab = tabGetAnalogSensors then
    case NeatoType of
      neatoBotVac:
        begin
          timerStarter := DGetAnalogSensors.timer_GetData;
          XVGetAnalogSensors.Visible := false;
          DGetAnalogSensors.Visible := true;
        end;
      neatoXV:
        begin
          timerStarter := XVGetAnalogSensors.timer_GetData;
          DGetAnalogSensors.Visible := false;
          XVGetAnalogSensors.Visible := true;
        end;
    end;

  if TTabControl(Sender).ActiveTab = tabGetDigitalSensors then
    case NeatoType of
      neatoBotVac:
        begin
          XVGetDigitalSensors.Visible := false;
          DGetDigitalSensors.Visible := true;
          timerStarter := DGetDigitalSensors.timer_GetData;
        end;
      neatoXV:
        begin
          DGetDigitalSensors.Visible := false;
          XVGetDigitalSensors.Visible := true;
          timerStarter := XVGetDigitalSensors.timer_GetData;
        end;
    end;

  if TTabControl(Sender).ActiveTab = tabGetSensor then
    case NeatoType of
      neatoBotVac:
        begin
          lblNotSupported.Visible := false;
          DGetSensors.Visible := true;
          timerStarter := DGetSensors.timer_GetData;
        end;
      neatoXV:
        begin
          DGetSensors.Visible := false;
          lblNotSupported.Parent := tabGetSensor;
          lblNotSupported.Visible := true;
        end;
    end;

  if TTabControl(Sender).ActiveTab = tabGetMotors then
    case NeatoType of
      neatoBotVac:
        begin
          DGetMotors.Visible := true;
          XVGetMotors.Visible := false;
          timerStarter := DGetMotors.timer_GetData;
        end;
      neatoXV:
        begin
          XVGetMotors.Visible := true;
          DGetMotors.Visible := false;
          timerStarter := XVGetMotors.timer_GetData;
        end;
    end;

  if TTabControl(Sender).ActiveTab = tabGetButtons then
    case NeatoType of
      neatoBotVac:
        begin
          DGetButtons.Visible := true;
          XVGetButtons.Visible := false;
          timerStarter := DGetButtons.timer_GetData;
        end;
      neatoXV:
        begin
          XVGetButtons.Visible := true;
          DGetButtons.Visible := false;
          timerStarter := XVGetButtons.timer_GetData;
        end;
    end;

  if TTabControl(Sender).ActiveTab = tabGetCalInfo then
    case NeatoType of
      neatoBotVac:
        begin
          DGetCalInfo.Visible := true;
          XVGetCalInfo.Visible := false;
          timerStarter := DGetCalInfo.timer_GetData;
        end;
      neatoXV:
        begin
          XVGetCalInfo.Visible := true;
          DGetCalInfo.Visible := false;
          timerStarter := XVGetCalInfo.timer_GetData;
        end;
    end;

  /// ///////////////////////////////////////////////////////////////////////////////////////////////

  if TTabControl(Sender).ActiveTab = tabGetWarranty then
    case NeatoType of
      neatoBotVac:
        begin
          DGetWarranty.Visible := true;
          XVGetWarranty.Visible := false;
          timerStarter := DGetWarranty.timer_GetData;
        end;
      neatoXV:
        begin
          XVGetWarranty.Visible := true;
          DGetWarranty.Visible := false;
          timerStarter := XVGetWarranty.timer_GetData;
        end;
    end;

  if TTabControl(Sender).ActiveTab = tabGetErr then
    case NeatoType of
      neatoBotVac:
        begin
          DGetErr.Visible := true;
          XVGetErr.Visible := false;
          timerStarter := DGetErr.timer_GetData;
        end;
      neatoXV:
        begin
          XVGetErr.Visible := true;
          DGetErr.Visible := false;
          timerStarter := XVGetErr.timer_GetData;
        end;
    end;

  if TTabControl(Sender).ActiveTab = tabGetVersion then
    case NeatoType of
      neatoBotVac:
        begin
          DGetVersion.Visible := true;
          XVGetVersion.Visible := false;
          timerStarter := DGetVersion.timer_GetData;
        end;
      neatoXV:
        begin
          XVGetVersion.Visible := true;
          DGetVersion.Visible := false;
          timerStarter := XVGetVersion.timer_GetData;
        end;
    end;

  if TTabControl(Sender).ActiveTab = tabGetUsage then
    case NeatoType of
      neatoBotVac:
        begin
          DGetUsage.Visible := true;
          lblNotSupported.Visible := false;
          timerStarter := DGetUsage.timer_GetData;
        end;
      neatoXV:
        begin
          DGetVersion.Visible := false;
          lblNotSupported.Parent := tabGetUsage;
          lblNotSupported.Visible := true;
        end;
    end;

  if TTabControl(Sender).ActiveTab = tabGetUserSettings then
    case NeatoType of
      neatoBotVac:
        begin
          DGetUserSettings.Visible := true;
          lblNotSupported.Visible := false;
          timerStarter := DGetUserSettings.timer_GetData;
        end;
      neatoXV:
        begin
          DGetUserSettings.Visible := false;
          lblNotSupported.Parent := tabGetUserSettings;
          lblNotSupported.Visible := true;
        end;
    end;

  if TTabControl(Sender).ActiveTab = tabGetSchedule then
  begin
    lblNotSupported.Visible := false;
    XVGetSchedule.Visible := true;
    timerStarter := XVGetSchedule.timer_GetData;
  end;

  if TTabControl(Sender).ActiveTab = tabGetTime then
  begin
    lblNotSupported.Visible := false;
    XVGetTime.Visible := true;
    timerStarter := XVGetTime.timer_GetData;
  end;

  if TTabControl(Sender).ActiveTab = tabClean then
    case NeatoType of
      neatoBotVac:
        begin
          XVClean.Visible := false;
          lblNotSupported.Parent := tabClean;
          lblNotSupported.Visible := true;
        end;
      neatoXV:
        begin
          XVClean.Visible := true;
          XVClean.Check;
          lblNotSupported.Visible := false;
        end;
    end;

  if TTabControl(Sender).ActiveTab = tabPlaySound then
  begin
    DXVPlaySound.Visible := true;
    DXVPlaySound.Check;
  end;

  if TTabControl(Sender).ActiveTab = tabGetLDSScan then
  begin
    DXVGetLDSScan.Visible := true;
    timerStarter := DXVGetLDSScan.timer_GetData;
  end;

  if TTabControl(Sender).ActiveTab = tabSetFuelGauge then
  begin
    DXVSetFuelGauge.Visible := true;
  end;

  if TTabControl(Sender).ActiveTab = tabSetTime then
  begin
    DXVSetTime.Visible := true;
  end;

  if TTabControl(Sender).ActiveTab = tabSetSystemMode then
  begin
    DXVSetSystemMode.Visible := true;
  end;

  if TTabControl(Sender).ActiveTab = tabSetLCD then
  begin
    DXVSetLCD.Visible := true;
  end;

  if TTabControl(Sender).ActiveTab = tabSetLED then
  begin
    DXVSetLED.Visible := true;
  end;

  if TTabControl(Sender).ActiveTab = tabSetSchedule then
  begin
    DXVSetSchedule.Visible := true;
  end;

  if TTabControl(Sender).ActiveTab = tabSetWallFollower then
  begin
    DXVSetWallFollower.Visible := true;
  end;

  if TTabControl(Sender).ActiveTab = tabSetDistanceCal then
  begin
    DXVSetDistanceCal.Visible := true;
  end;

  if TTabControl(Sender).ActiveTab = tabSetIEC then
  begin
    DXVSetIEC.Visible := true;
  end;

  if TTabControl(Sender).ActiveTab = tabGetLifeStatLog then
  begin
    DXVGetLifeStatLog.Check;
    DXVGetLifeStatLog.Visible := true;
  end;

  /// ///////////////////////////////////////////////////////////////////////////////////////////////

  if TTabControl(Sender).ActiveTab = tabClearFiles then
    case NeatoType of
      neatoBotVac:
        begin
          DClearFiles.Check;
          DClearFiles.Visible := true;
          lblNotSupported.Visible := false;
        end;
      neatoXV:
        begin
          DClearFiles.Visible := false;
          lblNotSupported.Parent := tabClearFiles;
          lblNotSupported.Visible := true;
        end;
    end;

  if TTabControl(Sender).ActiveTab = tabRestoreDefaults then
    case NeatoType of
      neatoBotVac:
        begin
          XVRestoreDefaults.Visible := false;
          lblNotSupported.Parent := tabRestoreDefaults;
          lblNotSupported.Visible := true;
        end;
      neatoXV:
        begin
          lblNotSupported.Visible := false;
          XVRestoreDefaults.Check;
          XVRestoreDefaults.Visible := true;
        end;
    end;
  /// ///////////////////////////////////////////////////////////////////////////////////////////////

  if TTabControl(Sender).ActiveTab = tabGetWifiInfo then
    case NeatoType of
      neatoBotVac:
        begin
          DGetWifiInfo.Check;
          DGetWifiInfo.Visible := true;
          lblNotSupported.Visible := false;
        end;
      neatoXV:
        begin
          DGetWifiInfo.Visible := false;
          lblNotSupported.Parent := tabGetWifiInfo;
          lblNotSupported.Visible := true;
        end;
    end;

  if TTabControl(Sender).ActiveTab = tabGetWifiStatus then
    case NeatoType of
      neatoBotVac:
        begin
          DGetWifiStatus.Visible := true;
          lblNotSupported.Visible := false;
          timerStarter := DGetWifiStatus.timer_GetData;
        end;
      neatoXV:
        begin
          DGetWifiStatus.Visible := false;
          lblNotSupported.Parent := tabGetWifiStatus;
          lblNotSupported.Visible := true;
        end;
    end;

  if TTabControl(Sender).ActiveTab = tabDebugTerminal then
  begin
    DXVTerminal.Visible := true;

    if DXVTerminal.edDebugTerminalSend.CanFocus then
      DXVTerminal.edDebugTerminalSend.SetFocus;

    timerStarter := DXVTerminal.timer_GetData;
  end;

  /// ///////////////////////////////////////////////////////////////////////////////////////////////

  if assigned(timerStarter) then
    timerStarter.Enabled := true;

  TTabControl(Sender).EndUpdate;
end;

procedure TfrmMain.StageTabs;
begin
  // create a whole bunch of tabs!

  DGetCharger := TframeDGetCharger.Create(tabGetCharger);
  DXVGetAccel := TframeDXVGetAccel.Create(tabGetAccel);
  DGetAnalogSensors := TframeDGetAnalogSensors.Create(tabGetAnalogSensors);
  DGetDigitalSensors := TframeDGetDigitalSensors.Create(tabGetDigitalSensors);
  DGetSensors := TframeDGetSensors.Create(tabGetSensor);
  DGetMotors := TframeDGetMotors.Create(tabGetMotors);
  DGetButtons := TframeDGetButtons.Create(tabGetButtons);
  DGetCalInfo := TframeDGetCalInfo.Create(tabGetCalInfo);
  DGetWarranty := TframeDGetWarranty.Create(tabGetWarranty);
  DGetErr := TframeDGetErr.Create(tabGetErr);
  DGetVersion := TframeDGetVersion.Create(tabGetVersion);
  DGetUsage := TframeDGetUsage.Create(tabGetUsage);
  DGetUserSettings := TframeDGetUserSettings.Create(tabGetUserSettings);
  DClearFiles := TframeDClearFiles.Create(tabClearFiles);
  DGetWifiInfo := TframeDGetWifiInfo.Create(tabGetWifiInfo);
  DGetWifiStatus := TframeDGetWifiStatus.Create(tabGetWifiStatus);
  XVGetCharger := TframeXVGetCharger.Create(tabGetCharger);
  XVGetAnalogSensors := TframeXVGetAnalogSensors.Create(tabGetAnalogSensors);
  XVGetDigitalSensors := TframeXVGetDigitalSensors.Create(tabGetDigitalSensors);
  XVGetMotors := TframeXVGetMotors.Create(tabGetMotors);
  XVGetButtons := TframeXVGetButtons.Create(tabGetButtons);
  XVGetCalInfo := TframeXVGetCalInfo.Create(tabGetCalInfo);
  XVGetWarranty := TframeXVGetWarranty.Create(tabGetWarranty);
  XVGetErr := TframeXVGetErr.Create(tabGetErr);
  XVGetVersion := TframeXVGetVersion.Create(tabGetVersion);
  XVRestoreDefaults := TframeXVRestoreDefaults.Create(tabRestoreDefaults);
  XVGetSchedule := TframeXVGetSchedule.Create(tabGetSchedule);
  XVGetTime := TframeXVGetTime.Create(tabGetTime);
  XVClean := TFrameXVClean.Create(tabClean);
  DXVPlaySound := TframeDXVPlaySound.Create(tabPlaySound);
  DXVTerminal := TframeDXVTerminal.Create(tabDebugTerminal);
  DXVGetLDSScan := TframeDXVGetLDSScan.Create(tabGetLDSScan);
  DXVSetFuelGauge := TframeDXVSetFuelGauge.Create(tabSetFuelGauge);
  DXVSetTime := TframeDXVSetTime.Create(tabSetTime);
  DXVSetSystemMode := TframeDXVSetSystemMode.Create(tabSetSystemMode);
  DXVSetLCD := TframeDXVSetLCD.Create(tabSetLCD);
  DXVSetLED := TframeDXVSetLED.Create(tabSetLED);
  DXVSetSchedule := TframeXVSetSchedule.Create(tabSetSchedule);
  DXVSetWallFollower := TframeDXVSetWallFollower.Create(tabSetWallFollower);
  DXVSetDistanceCal := TframeDXVSetDistanceCal.Create(tabSetDistanceCal);
  DXVSetIEC := TframeDXVSetIEC.Create(tabSetIEC);
  DXVGetLifeStatLog := TframeDXVGetLifeStatLog.Create(tabGetLifeStatLog);
end;

procedure TfrmMain.ResetTabs;
begin
  tabsMain.TabIndex := 0;
  tabsMain.SetFocus;
  tabsSerialOptions.TabIndex := 0;
  tabsSensorsOptions.TabIndex := -1;
  tabsInfoOptions.TabIndex := -1;
  tabsWifiOptions.TabIndex := -1;
  tabsToolOptions.TabIndex := -1;
  tabsMotorOptions.TabIndex := -1;
  tabsPowerOptions.TabIndex := -1;
  tabsLidarOptions.TabIndex := -1;
  tabsButtonOptions.TabIndex := -1;
  tabsDebuggerOptions.TabIndex := -1;
  tabsTimeOptions.TabIndex := -1;
end;

end.
