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
  dmSerial.Base,
  dmSerial.TCPIP,
  {Common neato units}
  Neato.Helpers,
  Neato.Settings,

  {Script Engine}
  frame.ScriptEngine,

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
  Neato.D.SetButton,
  Neato.D.Clean,
  Neato.D.SetNTPTime,
  Neato.D.SetNavigationMode,
  Neato.D.SetUsage,

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
  frame.D.SetButton,
  frame.D.Clean,
  frame.D.SetNTPTime,
  frame.D.SetNavigationMode,
  frame.D.SetUsage,

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
  Neato.XV.SetLED,

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
  frame.XV.SetLED,

  {XV and D Series Units}
  Neato.DXV.Playsound,
  Neato.DXV.GetAccel,
  Neato.DXV.GetLDSScan,
  Neato.DXV.SetFuelGauge,
  Neato.DXV.SetTime,
  Neato.DXV.SetSystemMode,
  Neato.DXV.SetLCD,
  Neato.DXV.SetSchedule,
  Neato.DXV.SetWallFollower,
  Neato.DXV.SetDistanceCal,
  Neato.DXV.SetIEC,
  Neato.DXV.GetLifeStatLog,
  Neato.DXV.SetMotor,
  Neato.DXV.TestLDS,
  Neato.DXV.SetBatteryTest,
  Neato.DXV.SetLanguage,

  frame.DXV.GetAccel,
  frame.DXV.Playsound,
  frame.DXV.Terminal,
  frame.DXV.GetLDSScan,
  frame.DXV.SetFuelGauge,
  frame.DXV.SetTime,
  frame.DXV.SetSystemMode,
  frame.DXV.SetLCD,
  frame.DXV.SetSchedule,
  frame.DXV.SetWallFollower,
  frame.DXV.SetDistanceCal,
  frame.DXV.SetIEC,
  frame.DXV.GetLifeStatLog,
  frame.DXV.SetMotor,
  frame.DXV.LidarView,
  frame.DXV.TestLDS,
  frame.DXV.SetBatteryTest,
  frame.DXV.SetLanguage,

  {Everything else to run this}
  dmCommon,
  XSuperObject,
  XSuperJson,

  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.Rtti,
  Generics.Collections,

  math,
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
  FMXTee.Chart, FMXTee.Series.Polar, FMXTee.Functions.Stats, FMXTee.Tools, IdTelnet, IdGlobal, IdComponent,
  IdBaseComponent, IdTCPConnection, IdTCPClient;

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
    tabGetSensor: TTabItem;
    pnlStatusBar: trectangle;
    ColorBoxRX: TColorBox;
    LabelRX: TLabel;
    ColorBoxTX: TColorBox;
    LabelTX: TLabel;
    chkTestMode: TCheckBox;
    tabGetCalInfo: TTabItem;
    pnlSetupDetails: trectangle;
    tabClearFiles: TTabItem;
    lblNotSupported: TLabel;
    ShadowEffect1: TShadowEffect;
    tabSetButton: TTabItem;
    tabRestoreDefaults: TTabItem;
    tabClean: TTabItem;
    tabDiagTest: TTabItem;
    tabMotors: TTabItem;
    tabsMotorOptions: TTabControl;
    tabGetMotors: TTabItem;
    tabSetMotor: TTabItem;
    tabPower: TTabItem;
    tabsPowerOptions: TTabControl;
    tabGetCharger: TTabItem;
    tabSetFuelGauge: TTabItem;
    tabSetSystemMode: TTabItem;
    tabLidarStuff: TTabItem;
    tabsLidarOptions: TTabControl;
    tabGetLDSScan: TTabItem;
    tabLidarView: TTabItem;
    tabSetBatteryTest: TTabItem;
    tabButtons: TTabItem;
    tabsButtonOptions: TTabControl;
    tabGetButtons: TTabItem;
    tabsSerialOptions: TTabControl;
    tabSerialSettings: TTabItem;
    pnlSerialTop: trectangle;
    lblSetupComPort: TLabel;
    cbCOM: TComboBox;
    chkAutoDetect: TCheckBox;
    ckSerialConnect: TCheckBox;
    imgRobot: TImage;
    shadowBotImage: TShadowEffect;
    lblSetupRobotName: TLabel;
    GlowEffect1: TGlowEffect;
    lblRobotModel: TLabel;
    ShadowEffect2: TShadowEffect;
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
    tabTestLDS: TTabItem;
    tabSetWallFollower: TTabItem;
    tabSetDistanceCal: TTabItem;
    tabGetLifeStatLog: TTabItem;

    edIPAddress: TEdit;
    lblConnectIP: TLabel;
    edIPPort: TSpinBox;
    lblConnectPort: TLabel;
    lblConnectIPEnabled: TLabel;
    tabAbout: TTabItem;
    ShadowEffectmemoAbout: TShadowEffect;
    RectangleaboutMemo: trectangle;
    memoAbout: TMemo;
    tabSetLanguage: TTabItem;
    ckTCPIPConnect: TCheckBox;
    aniConnect: TAniIndicator;
    ColorBoxCNX: TColorBox;
    LabelCNX: TLabel;
    StyleBook: TStyleBook;
    lblVersion: TLabel;

    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);

    procedure chkAutoDetectChange(Sender: TObject);
    procedure chkTestModeChange(Sender: TObject);

    procedure ckSerialConnectChange(Sender: TObject);
    procedure tabControlChange(Sender: TObject);
    procedure tabClickRepaint(Sender: TObject);
    procedure btnDebugRawDataClearClick(Sender: TObject);
    procedure ckTCPIPConnectChange(Sender: TObject);
    procedure edIPAddressChange(Sender: TObject);
    procedure edIPPortChange(Sender: TObject);
    procedure memoDebugChange(Sender: TObject);

  private

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
    DSetButton: TframeDSetButton;
    DClean: TframeDClean;
    DSetNTPTime: TframeDSetNTPTime;
    DSetNavigationMode: TframeDSetNavigationMode;
    DSetUsage: TframeDSetUsage;

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
    XVSetLED: TframeXVSetLED;

    // common tabs
    DXVPlaySound: TframeDXVPlaySound;
    DXVTerminal: TframeDXVTerminal;
    DXVGetAccel: TframeDXVGetAccel;
    DXVGetLDSScan: TframeDXVGetLDSScan;
    DXVSetFuelGauge: TframeDXVSetFuelGauge;
    DXVSetTime: TframeDXVSetTime;
    DXVSetSystemMode: TframeDXVSetSystemMode;
    DXVSetLCD: TframeDXVSetLCD;
    DXVSetSchedule: TframeXVSetSchedule;
    DXVSetWallFollower: TframeDXVSetWallFollower;
    DXVSetDistanceCal: TframeDXVSetDistanceCal;
    DXVSetIEC: TframeDXVSetIEC;
    DXVGetLifeStatLog: TframeDXVGetLifeStatLog;
    DXVSetMotor: TframeDXVSetMotor;
    DXVLidarView: TframeDXVLidarView;
    DXVTestLDS: TframeDXVTestLDS;
    DXVSetBatteryTest: TframeDXVSetBatteryTest;
    DXVSetLanguage: TframeDXVSetLanguage;

    ///

    Scripts: TframeScriptEngine;

    COMWin32: TdmSerialWindows;
    COMTCPIP: TdmSerialTCPIP;

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

  memoAbout.Lines.Add('Neato Toolio Version : ' + GetAppVersionStr);
  memoAbout.Lines.Add('');
  memoAbout.Lines.Add('Created by Steven Chesser');
  memoAbout.Lines.Add('Contact : NeatoToolio@twc.com');
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

  COMWin32 := TdmSerialWindows.Create;
  COMTCPIP := TdmSerialTCPIP.Create;

  COMTCPIP.FComSignalRX := self.ColorBoxRX;
  COMTCPIP.FComSignalTX := self.ColorBoxTX;
  COMTCPIP.FComSignalCNX := self.ColorBoxCNX;

  COMTCPIP.fmemoDebug := memoDebug;

  dm.COM := COMWin32; // default as this will be the most use case

  chkAutoDetect.IsChecked := neatoSettings.AutoDetectNeato;
  chkAutoDetectChange(nil);

  edIPAddress.Text := neatoSettings.IP;
  edIPPort.Text := neatoSettings.PORT.ToString;

  TdmSerialWindows(COMWin32).onError := FComPortError;

  with TdmSerialWindows(COMWin32).Serial do
  begin
    OnLineError := FComPortLineError;
    afterclose := FComPortAfterClose;
    afteropen := FComPortAfterOpen;
    OnDeviceArrival := FComPortDeviceUpdate;
    OnDeviceRemoved := FComPortDeviceUpdate;
  end;

  with TdmSerialWindows(COMWin32) do
  begin
    FComSignalRX.ColorBox := self.ColorBoxRX;
    FComSignalTX.ColorBox := self.ColorBoxTX;
    FComSignalCNX := self.ColorBoxCNX;

    fmemoDebug := memoDebug;
  end;

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

  dmCommon.onTabChangeEvent := tabControlChange; // so frames with tabs can piggy back off this

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

end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  LoadImageID('NeatoLogo', self.imgRobot);
  lblVersion.Text := Neato.Helpers.GetAppVersionStr;

end;

procedure TfrmMain.memoDebugChange(Sender: TObject);
begin
  if memoDebug.Lines.Count > 10000 then
    memoDebug.Lines.Clear;
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
    if NOT dm.com.Active then
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
  if assigned(dm.COM) then
  begin
    if dm.COM.Active then
    begin
      showmessage('Please disconnect first before closing....');
      CanClose := false;
      exit;
    end;
  end;

  stoptimers(true);
  // make sure all onChange events are gone
  // as it seems these can trigger on closeing

  tabsMain.OnChange := nil;
  tabsSensorsOptions.OnChange := nil;
  tabsInfoOptions.OnChange := nil;
  tabsWifiOptions.OnChange := nil;

  // if com is open still.. so lets make sure we turn testmode back OFF as we are done
  if dm.COM.Active then
  begin
    try
      dm.COM.SendCommand('testmode OFF'); // make sure to turn this off when close app
      dm.COM.SendCommand('testmode OFF'); // make sure to turn this off when close app
      dm.COM.SendCommand('testmode OFF'); // make sure to turn this off when close app
    finally
    end;
  end;

  try
    COMTCPIP.close;
  finally
  end;

  try
    COMWin32.close;
  finally
  end;

  CanClose := true;
end;

procedure TfrmMain.FComPortAfterClose(ComPort: TFComPort);
begin
  stoptimers;
end;

procedure TfrmMain.FComPortAfterOpen(ComPort: TFComPort);
begin
  stoptimers;
end;

procedure TfrmMain.FComPortLineError(Sender: TObject; LineErrors: TLineErrors);
begin
  stoptimers;

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
  stoptimers;

  if dm.COM.errorcode <> 0 then
    showmessage('COM Issue #' + dm.COM.errorcode.ToString + ' : ' + dm.COM.Error);

  try
    dm.COM.close;
  finally
  end;

  ckSerialConnect.IsChecked := false;
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

procedure TfrmMain.ckSerialConnectChange(Sender: TObject);
begin
  dm.COM := COMWin32; // default as this will be the most use case
  stoptimers;
  toggleComs(ckSerialConnect.IsChecked);
end;

procedure TfrmMain.ckTCPIPConnectChange(Sender: TObject);
begin
  dm.COM := COMTCPIP; // default as this will be the most use case
  stoptimers;
  toggleComs(ckTCPIPConnect.IsChecked);
end;

procedure TfrmMain.btnDebugRawDataClearClick(Sender: TObject);
begin
  memoDebug.Lines.Clear;
end;

procedure TfrmMain.chkAutoDetectChange(Sender: TObject);
begin
  cbCOM.Enabled := NOT chkAutoDetect.IsChecked;
  ckSerialConnect.IsChecked := false;
  neatoSettings.AutoDetectNeato := chkAutoDetect.IsChecked;
end;

procedure TfrmMain.chkTestModeChange(Sender: TObject);
begin
  if assigned(CurrentTimer) then
    CurrentTimer.Enabled := false;

  case chkTestMode.IsChecked of
    true:
      dm.COM.SendCommand('TestMode ON');
    false:
      dm.COM.SendCommand('TestMode OFF');
  end;

  if assigned(CurrentTimer) then
    CurrentTimer.Enabled := true;
end;

procedure TfrmMain.tabClickRepaint(Sender: TObject);
begin
  if (Sender) is TTabItem then
    TTabItem(Sender).Repaint;
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

  edIPAddress.Enabled := not disable;
  edIPPort.Enabled := not disable;

  if disable then
    comConnect
  else
    comDisconnect;
end;

procedure TfrmMain.comConnect;
begin
  ResetTabs;
  lblSetupRobotName.Text := '';
  lblRobotModel.Text := '';
  aniConnect.Visible := true;
  aniConnect.Enabled := true;
  ckSerialConnect.Enabled := false;
  ckTCPIPConnect.Enabled := false;

  tthread.CreateAnonymousThread(
    procedure

    var
      idx: integer;
      R: string;
      gGetWifiStatusD: tGetWifiStatusD;
      gGetVersionD: tGetVersionD;
      gGetVersionXV: tGetVersionXV;
      ReadData: TStringList;
      botFound: Boolean;

      procedure stopAniConnect(showBoth: Boolean);
      begin
        tthread.Synchronize(tthread.CurrentThread,
          procedure
          begin
            if showBoth then
            begin
              ckSerialConnect.Enabled := true;
              ckTCPIPConnect.Enabled := true;
            end
            else
            begin
              if (dm.COM is TdmSerialWindows) then
              begin
                ckSerialConnect.Enabled := true;
                if dm.COM.Active then
                  ckTCPIPConnect.Enabled := false;
              end;

              if (dm.COM is TdmSerialTCPIP) then
              begin
                ckTCPIPConnect.Enabled := true;
                if dm.COM.Active then
                  ckSerialConnect.Enabled := false;
              end;

            end;
            aniConnect.Visible := false;
            aniConnect.Enabled := false;
          end);
      end;

    begin
      botFound := false;
      if (dm.COM is TdmSerialTCPIP) then // if we are TCPIP, simple, set host and port
      begin
        COMTCPIP.Serial.ConnectTimeout := 10000;
        COMTCPIP.IP := self.edIPAddress.Text;
        COMTCPIP.PORT := ROUND(self.edIPPort.Value);
      end
      else if (dm.COM is TdmSerialWindows) then // if we are serial, then we can hunt down a port or go directly to one
      begin
        if chkAutoDetect.IsChecked then
        begin
          dm.COM.onError := nil;
          for idx := 0 to cbCOM.Items.Count - 1 do
          begin
            TdmSerialWindows(COMWin32).ComPort := cbCOM.Items[idx];
            if not dm.COM.Open then
              continue;

            R := dm.COM.SendCommand('HELP');
            if pos('Help', R) > 0 then
            begin
              tthread.Synchronize(tthread.CurrentThread,
                procedure
                begin
                  cbCOM.ItemIndex := idx;
                end);
              break;
            end;
            dm.COM.close;
          end;
          dm.COM.onError := FComPortError;
        end;

        if cbCOM.ItemIndex = -1 then
        begin
          stopAniConnect(true);
          tthread.Synchronize(tthread.CurrentThread,
            procedure
            begin
              ckSerialConnect.IsChecked := false;
              ckSerialConnectChange(nil);
              showmessage('No COM Port selected');
            end);
          exit;
        end
        else
          TdmSerialWindows(COMWin32).ComPort := cbCOM.Items[cbCOM.ItemIndex];
      end;

      if not dm.COM.Open then // by now we have serial or tcpip COM object assigned
      begin
        stopAniConnect(true);
        tthread.Synchronize(tthread.CurrentThread,
          procedure
          begin
            ckSerialConnect.IsChecked := false;
            ckTCPIPConnect.IsChecked := false;
            showmessage('Unable to open communications. ' + dm.COM.Error);
          end);
        exit;
      end;

      ReadData := TStringList.Create;

      tthread.Synchronize(tthread.CurrentThread,
        procedure
        begin
          if (dm.COM is TdmSerialTCPIP) then
            ckSerialConnect.Enabled := false;

          if (dm.COM is TdmSerialWindows) then
            ckTCPIPConnect.Enabled := false;
        end);

      R := dm.COM.SendCommandAndWaitForValue(sGetVersion, 6000, ^Z, 1);

      if pos('BotVac', R) > 0 then
      begin
        if (pos('BotVacD3', R) > 0) or (pos('BotVacD4', R) > 0) or (pos('BotVacD5', R) > 0) or (pos('BotVacD6', R) > 0)
          or (pos('BotVacD7', R) > 0) then
        begin
          neatoType := BotVacConnected;
        end
        else
          neatoType := BotVac;

      end
      else if pos('XV', R) > 0 then
        neatoType := XV;

      if (R <> '') and (neatoType in [BotVac, BotVacConnected]) then
      begin
        R := dm.COM.SendCommandAndWaitForValue(sGetWifiStatus, 5000, ^Z, 1);

        gGetWifiStatusD := tGetWifiStatusD.Create;
        ReadData.Text := R;

        tthread.Synchronize(tthread.CurrentThread,
          procedure
          begin
            if gGetWifiStatusD.ParseText(ReadData) then
              lblSetupRobotName.Text := gGetWifiStatusD.Robot_Name;
          end);

        freeandnil(gGetWifiStatusD);

        dm.COM.PurgeInput;
        dm.COM.PurgeOutput;

        R := dm.COM.SendCommandAndWaitForValue(sGetVersion, 5000, ^Z, 1);

        gGetVersionD := tGetVersionD.Create;
        ReadData.Text := R;

        if gGetVersionD.ParseText(ReadData) then
        begin
          tthread.Synchronize(tthread.CurrentThread,
            procedure
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
            end);
        end;
        freeandnil(gGetVersionD);
      end;

      if (R <> '') and (neatoType = XV) then
      begin
        gGetVersionXV := tGetVersionXV.Create;
        ReadData.Text := R;

        if gGetVersionXV.ParseText(ReadData) then
        begin
          tthread.Synchronize(tthread.CurrentThread,
            procedure
            begin

              lblRobotModel.Text := gGetVersionXV.ModelID.Minor;

              if pos('XV16', gGetVersionXV.ModelID.Minor) > 0 then
              begin
                LoadImageID('XV16', imgRobot);
                LoadImageID('NeatoXV', DXVGetAccel._3DGetAccel); // generic model
              end;

            end);
        end;

        freeandnil(gGetVersionXV);
      end;

      botFound := lblRobotModel.Text <> '';

      stopAniConnect(not botFound);

      tthread.Synchronize(tthread.CurrentThread,
        procedure
        begin
          if not botFound then
          begin
            if dm.isComSerial then
              showmessage('No Neato Found on this COM Port');

            if not dm.isComSerial then
              showmessage('No Neato Found on this IP / Port');

            ckSerialConnect.IsChecked := false;
            ckTCPIPConnect.IsChecked := false;

            chkAutoDetect.Enabled := true;
            cbCOM.Enabled := true;
          end;
          chkTestMode.Enabled := dm.COM.Active;
          ResetTabs;
        end);

      freeandnil(ReadData);

    end).start;
end;

procedure TfrmMain.comDisconnect;
begin
  aniConnect.Enabled := true;
  aniConnect.Visible := true;

  tthread.CreateAnonymousThread(
    procedure
    begin
      try
        if assigned(dm.COM) then
        begin
          if dm.COM.Active then
          begin
            dm.COM.SendCommand('TESTMODE OFF');
            dm.COM.SendCommand('TESTMODE OFF');
            dm.COM.SendCommand('TESTMODE OFF');
          end;
          dm.COM.close;
        end;
      finally
        tthread.Synchronize(tthread.CurrentThread,
          procedure
          begin
            aniConnect.Enabled := false;
            aniConnect.Visible := false;
            lblSetupRobotName.Text := '';
            lblRobotModel.Text := '';
            LoadImageID('NeatoLogo', imgRobot);
            ckSerialConnect.Enabled := true;
            ckTCPIPConnect.Enabled := true;
            ResetTabs;
          end);
      end;
    end).start;
end;

procedure TfrmMain.edIPAddressChange(Sender: TObject);
begin
  neatoSettings.IP := edIPAddress.Text;
end;

procedure TfrmMain.edIPPortChange(Sender: TObject);
begin
  neatoSettings.PORT := ROUND(edIPPort.Value);
end;

procedure TfrmMain.PopulateCOMPorts;
var
  comList: TStringList;
begin
  try
    ckSerialConnect.IsChecked := false;
    stoptimers;
    toggleComs(false);
  except
  end;
  comList := TStringList.Create;

  TdmSerialWindows(COMWin32).Serial.EnumComDevices(comList);

  cbCOM.BeginUpdate;
  cbCOM.Items.Assign(comList);
  cbCOM.endupdate;
  comList.Free;
  tabsMain.Enabled := true;
end;

procedure TfrmMain.tabControlChange(Sender: TObject);
var
  tabItem: TTabItem;

  procedure SetNotSupported;
  begin
    lblNotSupported.Parent := TTabControl(Sender).ActiveTab;
    lblNotSupported.Visible := true;
  end;

begin

  dm.ActiveTab := TTabControl(Sender).ActiveTab;

  TTabControl(Sender).BeginUpdate;

  stoptimers;
  timerStarter := nil;

  lblNotSupported.Visible := false;

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
  begin
    case neatoType of
      BotVac, BotVacConnected:
        begin
          DGetCharger.check;
          XVGetCharger.Visible := false;
          DGetCharger.Visible := true;
          timerStarter := DGetCharger.timer_GetData;
        end;
      XV:
        begin
          XVGetCharger.check;
          DGetCharger.Visible := false;
          XVGetCharger.Visible := true;
          timerStarter := XVGetCharger.timer_GetData;
        end;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabGetAccel then
  begin
    DXVGetAccel.check;
    DXVGetAccel.Visible := true;
    timerStarter := DXVGetAccel.timer_GetData;
  end;

  if TTabControl(Sender).ActiveTab = tabGetAnalogSensors then
  begin
    case neatoType of
      BotVacConnected, BotVac:
        begin
          DGetAnalogSensors.check; // toggles things based on BotVac type
          XVGetAnalogSensors.Visible := false;
          DGetAnalogSensors.Visible := true;
          timerStarter := DGetAnalogSensors.timer_GetData;
        end;
      XV:
        begin
          XVGetAnalogSensors.check;
          DGetAnalogSensors.Visible := false;
          XVGetAnalogSensors.Visible := true;
          timerStarter := XVGetAnalogSensors.timer_GetData;
        end;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabGetDigitalSensors then
  begin
    case neatoType of
      BotVacConnected, BotVac:
        begin
          DGetDigitalSensors.check;
          XVGetDigitalSensors.Visible := false;
          DGetDigitalSensors.Visible := true;
          timerStarter := DGetDigitalSensors.timer_GetData;
        end;
      XV:
        begin
          XVGetDigitalSensors.check;
          DGetDigitalSensors.Visible := false;
          XVGetDigitalSensors.Visible := true;
          timerStarter := XVGetDigitalSensors.timer_GetData;
        end;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabGetSensor then
    case neatoType of
      BotVacConnected, BotVac:
        begin
          DGetSensors.check;
          DGetSensors.Visible := true;
          timerStarter := DGetSensors.timer_GetData;
        end;
      XV:
        begin
          DGetSensors.Visible := false;
          SetNotSupported;
        end;
    end;

  if TTabControl(Sender).ActiveTab = tabGetMotors then
  begin
    case neatoType of
      BotVacConnected, BotVac:
        begin
          DGetMotors.check;
          DGetMotors.Visible := true;
          XVGetMotors.Visible := false;
          timerStarter := DGetMotors.timer_GetData;
        end;
      XV:
        begin
          XVGetMotors.check;
          XVGetMotors.Visible := true;
          DGetMotors.Visible := false;
          timerStarter := XVGetMotors.timer_GetData;
        end;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabGetButtons then
  begin
    case neatoType of
      BotVacConnected, BotVac:
        begin
          DGetButtons.check;
          DGetButtons.Visible := true;
          XVGetButtons.Visible := false;
          timerStarter := DGetButtons.timer_GetData;
        end;
      XV:
        begin
          XVGetButtons.check;
          XVGetButtons.Visible := true;
          DGetButtons.Visible := false;
          timerStarter := XVGetButtons.timer_GetData;
        end;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabGetCalInfo then
  begin
    case neatoType of
      BotVacConnected, BotVac:
        begin
          DGetCalInfo.check;
          DGetCalInfo.Visible := true;
          DGetCalInfo.check; // toggles things based on BotVac type
          XVGetCalInfo.Visible := false;
          timerStarter := DGetCalInfo.timer_GetData;
        end;
      XV:
        begin
          XVGetCalInfo.check;
          XVGetCalInfo.Visible := true;
          DGetCalInfo.Visible := false;
          timerStarter := XVGetCalInfo.timer_GetData;
        end;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabGetWarranty then
  begin
    case neatoType of
      BotVacConnected, BotVac:
        begin
          DGetWarranty.check;
          DGetWarranty.Visible := true;
          XVGetWarranty.Visible := false;
          timerStarter := DGetWarranty.timer_GetData;
        end;
      XV:
        begin
          XVGetWarranty.check;
          XVGetWarranty.Visible := true;
          DGetWarranty.Visible := false;
          timerStarter := XVGetWarranty.timer_GetData;
        end;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabGetErr then
  begin
    case neatoType of
      BotVacConnected, BotVac:
        begin
          DGetErr.check;
          DGetErr.Visible := true;
          XVGetErr.Visible := false;
          timerStarter := DGetErr.timer_GetData;
        end;
      XV:
        begin
          XVGetErr.check;
          XVGetErr.Visible := true;
          DGetErr.Visible := false;
          timerStarter := XVGetErr.timer_GetData;
        end;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabGetVersion then
  begin
    case neatoType of
      BotVacConnected, BotVac:
        begin
          DGetVersion.check;
          DGetVersion.Visible := true;
          XVGetVersion.Visible := false;
          timerStarter := DGetVersion.timer_GetData;
        end;
      XV:
        begin
          XVGetVersion.check;
          XVGetVersion.Visible := true;
          DGetVersion.Visible := false;
          timerStarter := XVGetVersion.timer_GetData;
        end;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabGetUsage then
  begin
    case neatoType of
      BotVacConnected:
        begin
          DGetUsage.check;
          DGetUsage.Visible := true;
          timerStarter := DGetUsage.timer_GetData;
        end;
      BotVac, XV:
        begin
          DGetUsage.Visible := false;
          SetNotSupported;
        end;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabGetUserSettings then
  begin
    case neatoType of
      BotVacConnected:
        begin
          DGetUserSettings.check;
          DGetUserSettings.Visible := true;
          timerStarter := DGetUserSettings.timer_GetData;
        end;
      BotVac, XV:
        begin
          DGetUserSettings.Visible := false;
          SetNotSupported;
        end;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabGetSchedule then
  begin
    case neatoType of
      BotVacConnected: // there is a GetSchedule but appears not usable
        begin
          XVGetSchedule.Visible := false;
          SetNotSupported;
        end;
      BotVac, XV:
        begin
          XVGetSchedule.check;
          XVGetSchedule.Visible := true;
          timerStarter := XVGetSchedule.timer_GetData;
        end;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabGetTime then
  begin
    case neatoType of
      BotVacConnected: // there is a GetSchedule but appears not usable
        begin
          XVGetTime.Visible := false;
          SetNotSupported;
        end;
      BotVac, XV:
        begin
          XVGetTime.check;
          XVGetTime.Visible := true;
          timerStarter := XVGetTime.timer_GetData;
        end;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabClean then
  begin
    case neatoType of
      BotVacConnected, BotVac:
        begin
          DClean.check;
          XVClean.Visible := false;
          DClean.Visible := true;
        end;
      XV:
        begin
          XVClean.check;
          DClean.Visible := false;
          XVClean.Visible := true;
        end;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabPlaySound then
  begin
    DXVPlaySound.check;
    DXVPlaySound.Visible := true;
  end;

  if TTabControl(Sender).ActiveTab = tabSetFuelGauge then
  begin
    DXVSetFuelGauge.check;
    DXVSetFuelGauge.Visible := true;
  end;

  if TTabControl(Sender).ActiveTab = tabSetTime then
  begin
    DXVSetTime.check;
    DXVSetTime.Visible := true;
  end;

  if TTabControl(Sender).ActiveTab = tabSetSystemMode then
  begin
    DXVSetSystemMode.check;
    DXVSetSystemMode.Visible := true;
  end;

  if TTabControl(Sender).ActiveTab = tabSetLCD then
  begin
    case neatoType of
      BotVacConnected, BotVac: // there IS a SetLCD available, but can't figure it out as no HELP for it
        begin
          DXVSetLCD.Visible := false;
          SetNotSupported;
        end;
      XV:
        begin
          DXVSetLCD.check;
          DXVSetLCD.Visible := true;
        end;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabSetLED then // BotVac Connected D3-D7 has SetLED, needs written.
  begin
    case neatoType of
      BotVacConnected: // there IS a setLED but can't seem to get anything to respond
        begin
          XVSetLED.Visible := false;
          SetNotSupported;
        end;
      BotVac, XV:
        begin
          XVSetLED.check;
          XVSetLED.Visible := true; // BotVac and XV are similar enough to share the XV code
        end;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabSetSchedule then
  begin
    case neatoType of
      BotVacConnected: // there IS a SetSchedule for D3-D7 but it appears not used anymore
        begin
          DXVSetSchedule.Visible := false;
          SetNotSupported;
        end;
      BotVac, XV:
        begin
          DXVSetSchedule.check;
          DXVSetSchedule.Visible := true;
        end;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabSetWallFollower then
  begin
    case neatoType of
      BotVac, BotVacConnected:
        begin
          DXVSetWallFollower.Visible := false;
          SetNotSupported;
        end;
      XV:
        begin
          DXVSetWallFollower.check;
          DXVSetWallFollower.Visible := true;
        end;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabSetDistanceCal then
  begin
    case neatoType of
      BotVac, BotVacConnected:
        begin
          DXVSetDistanceCal.Visible := false;
          SetNotSupported;
        end;
      XV:
        begin
          DXVSetDistanceCal.check;
          DXVSetDistanceCal.Visible := true;
        end;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabSetIEC then
  begin
    DXVSetIEC.check;
    DXVSetIEC.Visible := true;
  end;

  if TTabControl(Sender).ActiveTab = tabGetLifeStatLog then
  begin
    case neatoType of
      BotVac, BotVacConnected:
        begin
          DXVGetLifeStatLog.Visible := false;
          SetNotSupported;
        end;
      XV:
        begin
          DXVGetLifeStatLog.check;
          DXVGetLifeStatLog.Visible := true;
        end;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabSetMotor then
    if assigned(DXVSetMotor) then
    begin
      DXVSetMotor.check;
      DXVSetMotor.Visible := true;
    end;

  if TTabControl(Sender).ActiveTab = tabGetLDSScan then
  begin
    DXVGetLDSScan.check;
    DXVGetLDSScan.Visible := true;
    timerStarter := DXVGetLDSScan.timer_GetData;
  end;

  if TTabControl(Sender).ActiveTab = tabLidarView then
    if assigned(DXVLidarView) then
    begin
      DXVLidarView.check;
      DXVLidarView.Visible := true;
      timerStarter := DXVLidarView.timer_GetData;
    end;

  if TTabControl(Sender).ActiveTab = tabTestLDS then
  begin
    DXVTestLDS.check;
    DXVTestLDS.Visible := true;
    timerStarter := DXVTestLDS.timer_GetData;
  end;

  if TTabControl(Sender).ActiveTab = tabSetBatteryTest then
    if assigned(DXVSetBatteryTest) then
    begin
      DXVSetBatteryTest.check;
      DXVSetBatteryTest.Visible := true;
    end;

  /// ///////////////////////////////////////////////////////////////////////////////////////////////

  if TTabControl(Sender).ActiveTab = tabClearFiles then
    case neatoType of
      BotVacConnected, BotVac:
        begin
          DClearFiles.check;
          DClearFiles.Visible := true;
        end;
      XV:
        begin
          DClearFiles.Visible := false;
          SetNotSupported;
        end;
    end;

  if TTabControl(Sender).ActiveTab = tabRestoreDefaults then
    case neatoType of
      BotVacConnected, BotVac:
        begin
          XVRestoreDefaults.check;
          XVRestoreDefaults.Visible := false;
          SetNotSupported;
        end;
      XV:
        begin
          XVRestoreDefaults.check;
          XVRestoreDefaults.Visible := true;
        end;
    end;
  /// ///////////////////////////////////////////////////////////////////////////////////////////////

  if TTabControl(Sender).ActiveTab = tabGetWifiInfo then
    case neatoType of
      BotVacConnected:
        begin
          DGetWifiInfo.check;
          DGetWifiInfo.Visible := true;
        end;
      BotVac, XV:
        begin
          DGetWifiInfo.Visible := false;
          SetNotSupported;
        end;
    end;

  if TTabControl(Sender).ActiveTab = tabGetWifiStatus then
    case neatoType of
      BotVacConnected:
        begin
          DGetWifiStatus.check;
          DGetWifiStatus.Visible := true;
          timerStarter := DGetWifiStatus.timer_GetData;
        end;
      BotVac, XV:
        begin
          DGetWifiStatus.Visible := false;
          SetNotSupported;
        end;
    end;

  if TTabControl(Sender).ActiveTab = tabDebugTerminal then
  begin
    if assigned(DXVTerminal) then
    begin
      DXVTerminal.Visible := true;
      if DXVTerminal.edDebugTerminalSend.CanFocus then
        DXVTerminal.edDebugTerminalSend.SetFocus;
      timerStarter := DXVTerminal.timer_GetData;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabSetLanguage then
    case neatoType of
      BotVac:
        begin
          DXVSetLanguage.check;
          DXVSetLanguage.Visible := true;
        end;
      BotVacConnected, XV:
        begin
          DXVSetLanguage.Visible := false;
          SetNotSupported;
        end;
    end;

  if TTabControl(Sender).ActiveTab = tabSetButton then
    case neatoType of
      BotVac, BotVacConnected: // maybe the connected ?
        begin
          DSetButton.check;
          DSetButton.Visible := true;
        end;
      XV:
        begin
          DSetButton.Visible := false;
          SetNotSupported;
        end;
    end;

  if TTabControl(Sender).ActiveTab = tabSetNTPTime then
    case neatoType of
      BotVacConnected: // maybe the connected ?
        begin
          DSetNTPTime.check;
          DSetNTPTime.Visible := true;
        end;
      BotVac, XV:
        begin
          DSetNTPTime.Visible := false;
          SetNotSupported;
        end;
    end;

  if TTabControl(Sender).ActiveTab = tabSetNavigationMode then
    case neatoType of
      BotVacConnected: // maybe the connected ?
        begin
          DSetNavigationMode.check;
          DSetNavigationMode.Visible := true;
        end;
      BotVac, XV:
        begin
          DSetNavigationMode.Visible := false;
          SetNotSupported;
        end;
    end;

  if TTabControl(Sender).ActiveTab = tabSetUsage then
    case neatoType of
      BotVacConnected: // maybe the connected ?
        begin
          DSetUsage.check;
          DSetUsage.Visible := true;
        end;
      BotVac, XV:
        begin
          DSetUsage.Visible := false;
          SetNotSupported;
        end;
    end;

  if assigned(timerStarter) then
  begin
    tthread.CreateAnonymousThread(
      procedure
      begin
        sleep(1000);
        tthread.Synchronize(tthread.CurrentThread,
          procedure
          begin
            timerStarter.Enabled := true;
          end);
      end).start;
  end;

  TTabControl(Sender).endupdate;
end;

procedure TfrmMain.StageTabs;
begin
  // create a whole bunch of tabs!
  dm.log := self.memoDebug;

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
  DSetNavigationMode := TframeDSetNavigationMode.Create(tabSetNavigationMode);
  DSetUsage := TframeDSetUsage.Create(tabSetUsage);

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
  XVSetLED := TframeXVSetLED.Create(tabSetLED);

  DXVPlaySound := TframeDXVPlaySound.Create(tabPlaySound);
  DXVTerminal := TframeDXVTerminal.Create(tabDebugTerminal);
  DXVGetLDSScan := TframeDXVGetLDSScan.Create(tabGetLDSScan);
  DXVSetFuelGauge := TframeDXVSetFuelGauge.Create(tabSetFuelGauge);
  DXVSetTime := TframeDXVSetTime.Create(tabSetTime);
  DXVSetSystemMode := TframeDXVSetSystemMode.Create(tabSetSystemMode);
  DXVSetLCD := TframeDXVSetLCD.Create(tabSetLCD);
  DXVSetSchedule := TframeXVSetSchedule.Create(tabSetSchedule);
  DXVSetWallFollower := TframeDXVSetWallFollower.Create(tabSetWallFollower);
  DXVSetDistanceCal := TframeDXVSetDistanceCal.Create(tabSetDistanceCal);
  DXVSetIEC := TframeDXVSetIEC.Create(tabSetIEC);
  DXVGetLifeStatLog := TframeDXVGetLifeStatLog.Create(tabGetLifeStatLog);
  DXVSetMotor := TframeDXVSetMotor.Create(tabSetMotor);
  DXVLidarView := TframeDXVLidarView.Create(tabLidarView);
  DXVTestLDS := TframeDXVTestLDS.Create(tabTestLDS);
  DXVSetBatteryTest := TframeDXVSetBatteryTest.Create(tabSetBatteryTest);
  DXVSetLanguage := TframeDXVSetLanguage.Create(tabSetLanguage);
  DSetButton := TframeDSetButton.Create(tabSetButton);
  DClean := TframeDClean.Create(tabClean);
  DSetNTPTime := TframeDSetNTPTime.Create(tabSetNTPTime);

  Scripts := TframeScriptEngine.Create(tabScripts);
  Scripts.Parent := tabScripts;
  Scripts.Position.X := 0;
  Scripts.Position.Y := 0;
  Scripts.Align := talignlayout.Client;
  Scripts.init;

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
