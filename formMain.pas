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
  {Script Engine}
  frame.ScriptEngine,
{$ENDIF}
{$IFDEF ANDROID}
  dmSerial.Android,
  Winsoft.Android.Usb,
{$ENDIF}
  frame.Master,
  dmSerial.Base,
  dmSerial.TCPIP,
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

  System.IOUtils,
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
  FMXTee.Chart,
  FMXTee.Series.Polar,
  FMXTee.Functions.Stats,
  FMXTee.Tools,
  IdTelnet,
  IdGlobal,
  IdComponent,
  IdBaseComponent,
  IdTCPConnection,
  IdTCPClient;

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
    tabAbout: TTabItem;
    ShadowEffectmemoAbout: TShadowEffect;
    RectangleaboutMemo: trectangle;
    memoAbout: TMemo;
    tabSetLanguage: TTabItem;
    aniConnect: TAniIndicator;
    ColorBoxCNX: TColorBox;
    LabelCNX: TLabel;
    lblVersion: TLabel;
    RectGetCharger: trectangle;
    rectTerminal: trectangle;
    rectSetFuelGauge: trectangle;
    rectSetSystemMode: trectangle;
    rectSetBatteryTest: trectangle;
    rectGetSensor: trectangle;
    rectGetAccel: trectangle;
    rectGetAnalogSensors: trectangle;
    rectGetDigitalSensors: trectangle;
    rectGetcalInfo: trectangle;
    rectSetWallFollower: trectangle;
    rectSetDistanceCal: trectangle;
    rectGetButtons: trectangle;
    rectSetButton: trectangle;
    rectSetLCD: trectangle;
    rectSetLED: trectangle;
    rectGetMotors: trectangle;
    rectSetMotor: trectangle;
    rectGetLDSScan: trectangle;
    rectLidarView: trectangle;
    rectTestLDS: trectangle;
    rectGetWarranty: trectangle;
    rectGetErr: trectangle;
    rectGetVersion: trectangle;
    rectGetUsage: trectangle;
    rectGetUserSettings: trectangle;
    rectSetUsage: trectangle;
    rectGetLifeStatLog: trectangle;
    rectClearFiles: trectangle;
    rectRestoreDefaults: trectangle;
    rectClean: trectangle;
    rectDiagTest: trectangle;
    rectSetIEC: trectangle;
    rectSetNavigationMode: trectangle;
    rectPlaySound: trectangle;
    rectSetLanguage: trectangle;
    rectGetWifiInfo: trectangle;
    rectGetWifiStatus: trectangle;
    rectGetTime: trectangle;
    rectSetTime: trectangle;
    rectGetSchedule: trectangle;
    rectSetSchedule: trectangle;
    rectSetNTPTime: trectangle;
    rectSerialConnect: trectangle;
    ckSerialConnect: TCheckBox;
    rectTCPConnect: trectangle;
    ckTCPIPConnect: TCheckBox;
    rectTestMode: trectangle;
    VertScrollBox: TVertScrollBox;
    Lang: TLang;
    cbLanguages: TComboBox;
    lblLanguages: TLabel;

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
    procedure rectSerialConnectClick(Sender: TObject);
    procedure rectTCPConnectClick(Sender: TObject);
    procedure rectTestModeClick(Sender: TObject);
    procedure cbLanguagesChange(Sender: TObject);

  private

    fPlaySoundAborted: Boolean;

{$IFDEF ANDROID}
    // virtual keyboard stuff
    FKBBounds: TRectF;
    FNeedOffset: Boolean;
    procedure CalcContentBoundsProc(Sender: TObject; var ContentBounds: TRectF);
    procedure RestorePosition;
    procedure UpdateKBBounds;
    procedure FormVirtualKeyboardHidden(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardShown(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormFocusChanged(Sender: TObject);
{$ENDIF}
    procedure onIDLE(Sender: TObject; var done: Boolean); // our idle code

    // COM Events

{$IFDEF MSWINDOWS}
    procedure FComPortAfterOpen(ComPort: TFComPort);
    procedure FComPortAfterClose(ComPort: TFComPort);
    procedure FComPortLineError(Sender: TObject; LineErrors: TLineErrors);
    procedure FComPortDeviceUpdate(Sender: TObject; const DeviceName: string);
{$ENDIF}
{$IFDEF ANDROID}
    procedure OnDeviceAttached(Device: JUsbDevice);
    procedure OnDeviceDetached(Device: JUsbDevice);
{$ENDIF}
    procedure FComPortError(Sender: TObject); // mine not winsofts

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

{$IFDEF MSWINDOWS}
    Scripts: TframeScriptEngine; // currently just want this for windows until its "done"
    COMWin32: TdmSerialWindows;
{$ENDIF}
{$IFDEF ANDROID}
    COMAndroid: TdmSerialAndroid;
{$ENDIF}
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
  procedure FindLanguages;

  var
    LList: TStringDynArray;
    I: Integer;
    LSearchOption: TSearchOption;
    langCode: string;
    idx: Integer;
  begin

    cbLanguages.clear;
    LSearchOption := TSearchOption.soTopDirectoryOnly;
    LList := TDirectory.GetFiles(System.IOUtils.TPath.GetHomePath + '\NeatoToolio\Languages\', '*.lang', LSearchOption);

    for I := 0 to Length(LList) - 1 do
    begin
      idx := pos('.lang', lowercase(LList[I]));
      langCode := LList[I];
      delete(langCode, 1, idx - 3);
      setlength(langCode, 2);
      cbLanguages.items.add(langCode);
    end;

    if cbLanguages.items.count = 0 then
    begin
      cbLanguages.enabled := false;
    end
    else
    begin
      idx := cbLanguages.items.IndexOf(neatosettings.Language);
      if idx = -1 then
        idx := cbLanguages.items.IndexOf('en'); // english
      cbLanguages.itemindex := idx
    end;
  end;

var
  idx: Integer;
begin

  FindLanguages;

{$IFDEF ANDROID}
  ScaledLayoutMain.Align := talignlayout.Client;
  VKAutoShowMode := TVKAutoShowMode.Always;
  VertScrollBox.OnCalcContentBounds := CalcContentBoundsProc;
  OnVirtualKeyboardHidden := FormVirtualKeyboardHidden;
  OnVirtualKeyboardShown := FormVirtualKeyboardShown;
  self.OnFocusChanged := FormFocusChanged;
{$ENDIF}
  dm.chkTestMode := chkTestMode;

  memoAbout.Lines.add('Neato Toolio Version : ' + GetAppVersionStr);
  memoAbout.Lines.add('');
  memoAbout.Lines.add('Created by Steven Chesser');
  memoAbout.Lines.add('Contact : NeatoToolio@twc.com');
  memoAbout.Lines.add('');
  memoAbout.Lines.add('');
  memoAbout.Lines.add('');
  memoAbout.Lines.add('Thanks to the Neato group at @ http://www.robotreviews.com/chat/viewforum.php?f=20');
  memoAbout.Lines.add('');
  memoAbout.Lines.add('Thanks to Ed Vickery for loaning out an XV for testing!');
  memoAbout.Lines.add('');
  memoAbout.Lines.add('');
  memoAbout.Lines.add('Neato Toolio is free.  It is open-source (mostly).  It comes with no guarantee.');
  memoAbout.Lines.add('Github @ https://github.com/jdredd87/NeatoToolio');
  memoAbout.Lines.add('');
  memoAbout.Lines.add('Neato Toolio is use at your own risk!');

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

{$IFDEF MSWINDOWS}
  COMWin32 := TdmSerialWindows.Create;
{$ENDIF}
{$IFDEF ANDROID}
  COMAndroid := TdmSerialAndroid.Create;
{$ENDIF}
  COMTCPIP := TdmSerialTCPIP.Create;

  COMTCPIP.FComSignalRX := self.ColorBoxRX;
  COMTCPIP.FComSignalTX := self.ColorBoxTX;
  COMTCPIP.FComSignalCNX := self.ColorBoxCNX;

  COMTCPIP.fmemoDebug := memoDebug;

{$IFDEF MSWINDOWS}
  dm.COM := COMWin32; // default as this will be the most use case
{$ENDIF}
{$IFDEF ANDROID}
  dm.COM := COMAndroid;
{$ENDIF}
  chkAutoDetect.IsChecked := neatosettings.AutoDetectNeato;
  chkAutoDetectChange(nil);

  edIPAddress.Text := neatosettings.IP;
  edIPPort.Text := neatosettings.PORT.ToString;

{$IFDEF MSWINDOWS}
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
{$ENDIF}
{$IFDEF ANDROID}
  pnlStatusBar.Height := pnlStatusBar.Height * 1.25; // make it a little taller

  TdmSerialAndroid(COMAndroid).onError := FComPortError;
  self.chkAutoDetect.Visible := false; // just remove it for Android. Should have only 1 device anyways if any.
  cbCOM.Width := cbCOM.Width * 2; // big com port driver names it appears
  cbCOM.Position.Y := self.chkAutoDetect.Position.Y; // move it up so have some room to click

  lblSetupComPort.Position.Y := cbCOM.Position.Y;

  COMAndroid.Serial.OnDeviceAttached := OnDeviceAttached;
  COMAndroid.Serial.OnDeviceDetached := OnDeviceDetached;

  COMAndroid.FComSignalRX := self.ColorBoxRX;
  COMAndroid.FComSignalTX := self.ColorBoxTX;
  COMAndroid.FComSignalCNX := self.ColorBoxCNX;
  COMAndroid.fmemoDebug := memoDebug;
{$ENDIF}
  for idx := 0 to self.ComponentCount - 1 do
  begin
{$IFDEF android}
    if components[idx] is TCheckBox then
    begin // make checkboxes slightly bigger
      TCheckBox(components[idx]).Scale.X := TCheckBox(components[idx]).Scale.X * 1.55;
      TCheckBox(components[idx]).Scale.Y := TCheckBox(components[idx]).Scale.Y * 1.55;
    end;
{$ENDIF}
    if components[idx] is TTabItem then
      TTabItem(components[idx]).OnClick := tabClickRepaint;

    if components[idx] is TTabControl then
    begin
      TTabControl(components[idx]).OnChange := tabControlChange;
      TTabControl(components[idx]).ActiveTab := nil;
{$IFDEF android}
      TTabControl(components[idx]).TabHeight := TTabControl(components[idx]).TabHeight * 1.25;
{$ENDIF}
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

{$IFDEF ANDROID}

procedure TfrmMain.CalcContentBoundsProc(Sender: TObject; var ContentBounds: TRectF);
begin
  if FNeedOffset and (FKBBounds.Top > 0) then
  begin
    ContentBounds.Bottom := Max(ContentBounds.Bottom, 2 * ClientHeight - FKBBounds.Top);
  end;
end;

procedure TfrmMain.RestorePosition;
begin
  VertScrollBox.ViewportPosition := PointF(VertScrollBox.ViewportPosition.X, 0);
  ScaledLayoutMain.Align := talignlayout.Client;
  VertScrollBox.RealignContent;
end;

procedure TfrmMain.UpdateKBBounds;
var
  LFocused: TControl;
  LFocusRect: TRectF;
begin
  FNeedOffset := false;
  if Assigned(Focused) then
  begin
    LFocused := TControl(Focused.GetObject);
    LFocusRect := LFocused.AbsoluteRect;
    LFocusRect.Offset(VertScrollBox.ViewportPosition);
    if (LFocusRect.IntersectsWith(TRectF.Create(FKBBounds))) and (LFocusRect.Bottom > FKBBounds.Top) then
    begin
      FNeedOffset := True;
      ScaledLayoutMain.Align := talignlayout.Horizontal;
      VertScrollBox.RealignContent;
      application.ProcessMessages;
      VertScrollBox.ViewportPosition := PointF(VertScrollBox.ViewportPosition.X, LFocusRect.Bottom - FKBBounds.Top);
    end;
  end;
  if not FNeedOffset then
    RestorePosition;
end;

procedure TfrmMain.FormFocusChanged(Sender: TObject);
begin
  UpdateKBBounds;
end;

procedure TfrmMain.FormVirtualKeyboardHidden(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
begin
  FKBBounds.Create(0, 0, 0, 0);
  FNeedOffset := false;
  RestorePosition;
end;

procedure TfrmMain.FormVirtualKeyboardShown(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
begin
  FKBBounds := TRectF.Create(Bounds);
  FKBBounds.TopLeft := ScreenToClient(FKBBounds.TopLeft);
  FKBBounds.BottomRight := ScreenToClient(FKBBounds.BottomRight);
  UpdateKBBounds;
end;

{$ENDIF}

procedure TfrmMain.FormShow(Sender: TObject);
begin
  // LoadImageID('NeatoLogo', self.imgRobot);
  lblVersion.Text := Neato.Helpers.GetAppVersionStr;
end;

procedure TfrmMain.memoDebugChange(Sender: TObject);
begin
  if memoDebug.Lines.count > 10000 then
    memoDebug.Lines.clear;
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
  idx: Integer;
begin
  if Assigned(dm.COM) then
  begin
    if dm.COM.Active then
    begin
      showmessage('Please disconnect first before closing....');
      CanClose := false;
      exit;
    end;
  end;

  stoptimers(True);
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
{$IFDEF MSWINDOWS}
    COMWin32.close;
{$ENDIF}
{$IFDEF ANDROID}
    COMAndroid.close;
{$ENDIF}
  finally
  end;

  CanClose := True;
end;

{$IFDEF MSWINDOWS}

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

procedure TfrmMain.FComPortDeviceUpdate(Sender: TObject; const DeviceName: string);
begin
  if cbCOM.DroppedDown then
    cbCOM.DropDown;
  cbCOM.itemindex := -1;
  PopulateCOMPorts;
end;

{$ENDIF}
{$IFDEF ANDROID}

procedure TfrmMain.OnDeviceAttached(Device: JUsbDevice);
begin
  COMAndroid.OnDeviceAttached(Device);
  PopulateCOMPorts;
end;

procedure TfrmMain.OnDeviceDetached(Device: JUsbDevice);
begin
  COMAndroid.OnDeviceDetached(Device);
  PopulateCOMPorts;
end;

{$ENDIF}

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
  chkAutoDetect.enabled := True;
  cbCOM.enabled := True;
end;

procedure TfrmMain.ckSerialConnectChange(Sender: TObject);
begin
  dm.COM := {$IFDEF MSWindows} COMWin32; {$ENDIF} {$IFDEF ANDROID} COMAndroid; {$ENDIF}
  // default as this will be the most use case
  stoptimers;
  toggleComs(ckSerialConnect.IsChecked);
end;

procedure TfrmMain.ckTCPIPConnectChange(Sender: TObject);
begin
  dm.COM := COMTCPIP; // default as this will be the most use case
  stoptimers;
  toggleComs(ckTCPIPConnect.IsChecked);
end;

procedure TfrmMain.cbLanguagesChange(Sender: TObject);
var
  l: string;
  languageFN: string;
begin
  l := cbLanguages.items[cbLanguages.itemindex];

  languageFN := System.IOUtils.TPath.GetHomePath + '\NeatoToolio\Languages\neatotoolio.' + l + '.lang';

  if fileexists(languageFN) then
  begin
    self.BeginUpdate;
    LoadLangFromFile(languageFN);
    neatosettings.Language := l;
    self.EndUpdate;
  end;

end;

procedure TfrmMain.btnDebugRawDataClearClick(Sender: TObject);
begin
  memoDebug.Lines.clear;
end;

procedure TfrmMain.chkAutoDetectChange(Sender: TObject);
begin
  cbCOM.enabled := NOT chkAutoDetect.IsChecked;
  ckSerialConnect.IsChecked := false;
  neatosettings.AutoDetectNeato := chkAutoDetect.IsChecked;
end;

procedure TfrmMain.chkTestModeChange(Sender: TObject);
begin
  if Assigned(CurrentTimer) then
    CurrentTimer.enabled := false;

  case chkTestMode.IsChecked of
    True:
      dm.COM.SendCommand('TestMode ON');
    false:
      dm.COM.SendCommand('TestMode OFF');
  end;

  if Assigned(CurrentTimer) then
    CurrentTimer.enabled := True;
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
  chkAutoDetect.enabled := not disable;
  cbCOM.enabled := not disable;
  chkTestMode.enabled := false;
  chkTestMode.IsChecked := false;

  edIPAddress.enabled := not disable;
  edIPPort.enabled := not disable;

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
  aniConnect.Visible := True;
  aniConnect.enabled := True;
  ckSerialConnect.enabled := false;
  ckTCPIPConnect.enabled := false;

  tthread.CreateAnonymousThread(
    procedure

    var
      idx: Integer;
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
              ckSerialConnect.enabled := True;
              ckTCPIPConnect.enabled := True;
            end
            else
            begin

              if (dm.COM is {$IFDEF MSWINDOWS} TdmSerialWindows{$ENDIF} {$IFDEF ANDROID} TdmSerialAndroid{$ENDIF}) then
              begin
                ckSerialConnect.enabled := True;
                if dm.COM.Active then
                  ckTCPIPConnect.enabled := false;
              end;

              if (dm.COM is TdmSerialTCPIP) then
              begin
                ckTCPIPConnect.enabled := True;
                if dm.COM.Active then
                  ckSerialConnect.enabled := false;
              end;

            end;
            aniConnect.Visible := false;
            aniConnect.enabled := false;
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
      else if (dm.COM is {$IFDEF MSWINDOWS}TdmSerialWindows{$ENDIF} {$IFDEF ANDROID}TdmSerialAndroid{$ENDIF}) then
      // if we are serial, then we can hunt down a port or go directly to one
      begin
        if chkAutoDetect.IsChecked then
        begin
          dm.COM.onError := nil;
          for idx := 0 to cbCOM.items.count - 1 do
          begin
{$IFDEF MSWINDOWS}
            COMWin32.ComPort := cbCOM.items[idx];
{$ENDIF}
{$IFDEF ANDORID}
            // if not COMAndroid.CheckPermission then
            // COMAndroid.RequestPermission;
            COMAndroid.ComPort := idx; // auto detect is off for android, but just in case i forget this
{$ENDIF}
            if not dm.COM.Open then
              continue;

            R := dm.COM.SendCommand('HELP');
            if pos('Help', R) > 0 then
            begin
              tthread.Synchronize(tthread.CurrentThread,
                procedure
                begin
                  cbCOM.itemindex := idx;
                end);
              break;
            end;
            try
              dm.COM.close;
            finally
            end;

          end;
          dm.COM.onError := FComPortError;
        end;

        if cbCOM.itemindex = -1 then
        begin
          stopAniConnect(True);
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
        begin
{$IFDEF MSWINDOWS}
          COMWin32.ComPort := cbCOM.items[cbCOM.itemindex];
{$ENDIF}
{$IFDEF ANDROID}
          COMAndroid.ComPort := cbCOM.itemindex; // should have access by now
{$ENDIF}
        end;
      end;

      if not dm.COM.Open then // by now we have serial or tcpip COM object assigned
      begin

        stopAniConnect(True);

{$IFDEF android}
        // since we have to deal with permissions  and for Serial only do we care about
        if dm.COM = COMAndroid then
        begin
          if (NOT COMAndroid.HasPermission) then
          begin
            tthread.CreateAnonymousThread(
              procedure
              begin
                sleep(250);
                tthread.Queue(nil,
                  procedure
                  begin
                    comConnect; // lets call this again
                  end);
              end).start;
            exit; // and oh make sure to exit!
          end;
        end;

{$ENDIF}
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
            ckSerialConnect.enabled := false;

          if (dm.COM is {$IFDEF MSWINDOWS} TdmSerialWindows{$ENDIF}{$IFDEF ANDROID} TdmSerialAndroid{$ENDIF} ) then
            ckTCPIPConnect.enabled := false;

        end);

      R := dm.COM.SendCommandAndWaitForValue(sGetVersion, 6000, ^Z, 1);

      if pos('BotVac', R) > 0 then
      begin
        if (pos('BotVacD3', R) > 0) or (pos('BotVacD4', R) > 0) or (pos('BotVacD5', R) > 0) or (pos('BotVacD6', R) > 0)
          or (pos('BotVacD7', R) > 0) or (pos('BotVacConnected', R) > 0) then
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
              end
              else
                LoadImageID('NeatoXV', DXVGetAccel._3DGetAccel); // generic model

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

            chkAutoDetect.enabled := True;
            cbCOM.enabled := True;
          end;
          chkTestMode.enabled := dm.COM.Active;
          ResetTabs;
        end);

      freeandnil(ReadData);

    end).start;
end;

procedure TfrmMain.comDisconnect;
begin
  aniConnect.enabled := True;
  aniConnect.Visible := True;

  try
    if Assigned(dm.COM) then
    begin
      if dm.COM.Active then
      begin
        dm.COM.SendCommand('TESTMODE OFF');
        dm.COM.SendCommand('TESTMODE OFF');
        dm.COM.SendCommand('TESTMODE OFF');
        dm.COM.close;
      end;
    end;
  except
    on e: Exception do
    begin
      showmessage('Error on disconnect : ' + e.message);
    end;
  end;

  aniConnect.enabled := false;
  aniConnect.Visible := false;
  lblSetupRobotName.Text := '';
  lblRobotModel.Text := '';
  LoadImageID('NeatoLogo', imgRobot);
  ckSerialConnect.enabled := True;
  ckTCPIPConnect.enabled := True;
  ResetTabs;
end;

procedure TfrmMain.edIPAddressChange(Sender: TObject);
begin
  neatosettings.IP := edIPAddress.Text;
end;

procedure TfrmMain.edIPPortChange(Sender: TObject);
begin
  neatosettings.PORT := ROUND(edIPPort.Value);
end;

procedure TfrmMain.PopulateCOMPorts;
var
  comList: TStringList;
  idx: Integer;
begin
  idx := -1;
  try
    ckSerialConnect.IsChecked := false;
    stoptimers;
    toggleComs(false);
  except
  end;
  comList := TStringList.Create;

{$IFDEF MSWINDOWS}
  TdmSerialWindows(COMWin32).Serial.EnumComDevices(comList);
{$ENDIF}
{$IFDEF ANDROID}
  TdmSerialAndroid(COMAndroid).RefreshDevices(idx, comList);
{$ENDIF}
  cbCOM.BeginUpdate;
  cbCOM.items.Assign(comList);
  cbCOM.itemindex := idx;
  cbCOM.EndUpdate;
  comList.Free;
  tabsMain.enabled := True;
end;

procedure TfrmMain.tabControlChange(Sender: TObject);
var
  tabItem: TTabItem;

  procedure SetNotSupported;
  begin
    lblNotSupported.Parent := TTabControl(Sender).ActiveTab;
    lblNotSupported.Visible := True;
  end;

begin

  dm.ActiveTab := TTabControl(Sender).ActiveTab;

  TTabControl(Sender).BeginUpdate;

  stoptimers;

  SetTimer(nil);

  // timerStarter := nil;

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
          XVGetCharger.Layout.Visible := false;
          DGetCharger.Layout.Visible := True;
          // SetTimer(DGetCharger.timer_GetData);
          DGetCharger.timer_getdata.enabled := True;
        end;
      XV:
        begin
          XVGetCharger.check;
          // DGetCharger.Layout.Visible := false;
          // XVGetCharger.Layout.Visible := true;
          DGetCharger.Layout.Visible := false;
          XVGetCharger.Layout.Visible := True;
          SetTimer(XVGetCharger.timer_getdata);
        end;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabGetAccel then
  begin
    DXVGetAccel.check;
    DXVGetAccel.Layout.Visible := True;
    SetTimer(DXVGetAccel.timer_getdata);
  end;

  if TTabControl(Sender).ActiveTab = tabGetAnalogSensors then
  begin
    case neatoType of
      BotVacConnected, BotVac:
        begin
          DGetAnalogSensors.check; // toggles things based on BotVac type
          XVGetAnalogSensors.Layout.Visible := false;
          DGetAnalogSensors.Layout.Visible := True;
          SetTimer(DGetAnalogSensors.timer_getdata);
        end;
      XV:
        begin
          XVGetAnalogSensors.check;
          DGetAnalogSensors.Layout.Visible := false;
          XVGetAnalogSensors.Layout.Visible := True;
          SetTimer(XVGetAnalogSensors.timer_getdata);
        end;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabGetDigitalSensors then
  begin
    case neatoType of
      BotVacConnected, BotVac:
        begin
          DGetDigitalSensors.check;
          XVGetDigitalSensors.Layout.Visible := false;
          DGetDigitalSensors.Layout.Visible := True;
          SetTimer(DGetDigitalSensors.timer_getdata);
        end;
      XV:
        begin
          XVGetDigitalSensors.check;
          DGetDigitalSensors.Layout.Visible := false;
          XVGetDigitalSensors.Layout.Visible := True;
          SetTimer(XVGetDigitalSensors.timer_getdata);
        end;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabGetSensor then
    case neatoType of
      BotVacConnected, BotVac:
        begin
          DGetSensors.check;
          DGetSensors.Layout.Visible := True;
          SetTimer(DGetSensors.timer_getdata);
        end;
      XV:
        begin
          DGetSensors.Layout.Visible := false;
          SetNotSupported;
        end;
    end;

  if TTabControl(Sender).ActiveTab = tabGetMotors then
  begin
    case neatoType of
      BotVacConnected, BotVac:
        begin
          DGetMotors.check;
          DGetMotors.Layout.Visible := True;
          XVGetMotors.Layout.Visible := false;
          SetTimer(DGetMotors.timer_getdata);
        end;
      XV:
        begin
          XVGetMotors.check;
          XVGetMotors.Layout.Visible := True;
          DGetMotors.Layout.Visible := false;
          SetTimer(XVGetMotors.timer_getdata);
        end;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabGetButtons then
  begin
    case neatoType of
      BotVacConnected, BotVac:
        begin
          DGetButtons.check;
          DGetButtons.Layout.Visible := True;
          XVGetButtons.Layout.Visible := false;
          SetTimer(DGetButtons.timer_getdata);
        end;
      XV:
        begin
          XVGetButtons.check;
          XVGetButtons.Layout.Visible := True;
          DGetButtons.Layout.Visible := false;
          SetTimer(XVGetButtons.timer_getdata);
        end;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabGetCalInfo then
  begin
    case neatoType of
      BotVacConnected, BotVac:
        begin
          DGetCalInfo.check;
          DGetCalInfo.Layout.Visible := True;
          DGetCalInfo.check;
          // toggles things based on BotVac type
          XVGetCalInfo.Layout.Visible := false;
          SetTimer(DGetCalInfo.timer_getdata);
        end;
      XV:
        begin
          XVGetCalInfo.check;
          XVGetCalInfo.Layout.Visible := True;
          DGetCalInfo.Layout.Visible := false;
          SetTimer(XVGetCalInfo.timer_getdata);
        end;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabGetWarranty then
  begin
    case neatoType of
      BotVacConnected, BotVac:
        begin
          DGetWarranty.check;
          DGetWarranty.Layout.Visible := True;
          XVGetWarranty.Layout.Visible := false;
          SetTimer(DGetWarranty.timer_getdata);
        end;
      XV:
        begin
          XVGetWarranty.check;
          XVGetWarranty.Layout.Visible := True;
          DGetWarranty.Layout.Visible := false;
          SetTimer(XVGetWarranty.timer_getdata);
        end;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabGetErr then
  begin
    case neatoType of
      BotVacConnected, BotVac:
        begin
          DGetErr.check;
          DGetErr.Layout.Visible := True;
          XVGetErr.Layout.Visible := false;
          SetTimer(DGetErr.timer_getdata);
        end;
      XV:
        begin
          XVGetErr.check;
          XVGetErr.Layout.Visible := True;
          DGetErr.Layout.Visible := false;
          SetTimer(XVGetErr.timer_getdata);
        end;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabGetVersion then
  begin
    case neatoType of
      BotVacConnected, BotVac:
        begin
          DGetVersion.check;
          DGetVersion.Layout.Visible := True;
          XVGetVersion.Layout.Visible := false;
          SetTimer(DGetVersion.timer_getdata);
        end;
      XV:
        begin
          XVGetVersion.check;
          XVGetVersion.Layout.Visible := True;
          DGetVersion.Layout.Visible := false;
          SetTimer(XVGetVersion.timer_getdata);
        end;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabGetUsage then
  begin
    case neatoType of
      BotVacConnected:
        begin
          DGetUsage.check;
          DGetUsage.Layout.Visible := True;
          SetTimer(DGetUsage.timer_getdata);
        end;
      BotVac, XV:
        begin
          DGetUsage.Layout.Visible := false;
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
          DGetUserSettings.Layout.Visible := True;
          SetTimer(DGetUserSettings.timer_getdata);
        end;
      BotVac, XV:
        begin
          DGetUserSettings.Layout.Visible := false;
          SetNotSupported;
        end;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabGetSchedule then
  begin
    case neatoType of
      BotVacConnected:
        // there is a GetSchedule but appears not usable
        begin
          XVGetSchedule.Layout.Visible := false;
          SetNotSupported;
        end;
      BotVac, XV:
        begin
          XVGetSchedule.check;
          XVGetSchedule.Layout.Visible := True;
          SetTimer(XVGetSchedule.timer_getdata);
        end;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabGetTime then
  begin
    case neatoType of
      BotVacConnected:
        // there is a GetSchedule but appears not usable
        begin
          XVGetTime.Layout.Visible := false;
          SetNotSupported;
        end;
      BotVac, XV:
        begin
          XVGetTime.check;
          XVGetTime.Layout.Visible := True;
          SetTimer(XVGetTime.timer_getdata);
        end;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabClean then
  begin
    case neatoType of
      BotVacConnected, BotVac:
        begin
          DClean.check;
          XVClean.Layout.Visible := false;
          DClean.Layout.Visible := True;
        end;
      XV:
        begin
          XVClean.check;
          DClean.Layout.Visible := false;
          XVClean.Layout.Visible := True;
        end;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabPlaySound then
  begin
    DXVPlaySound.check;
    DXVPlaySound.Layout.Visible := True;
  end;

  if TTabControl(Sender).ActiveTab = tabSetFuelGauge then
  begin
    DXVSetFuelGauge.check;
    DXVSetFuelGauge.Layout.Visible := True;
  end;

  if TTabControl(Sender).ActiveTab = tabSetTime then
  begin
    DXVSetTime.check;
    DXVSetTime.Layout.Visible := True;
  end;

  if TTabControl(Sender).ActiveTab = tabSetSystemMode then
  begin
    DXVSetSystemMode.check;
    DXVSetSystemMode.Layout.Visible := True;
  end;

  if TTabControl(Sender).ActiveTab = tabSetLCD then
  begin
    case neatoType of
      BotVacConnected, BotVac:
        // there IS a SetLCD available, but can't figure it out as no HELP for it
        begin
          DXVSetLCD.Layout.Visible := false;
          SetNotSupported;
        end;
      XV:
        begin
          DXVSetLCD.check;
          DXVSetLCD.Layout.Visible := True;
        end;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabSetLED then // BotVac Connected D3-D7 has SetLED, needs written.
  begin
    case neatoType of
      BotVacConnected: // there IS a setLED but can't seem to get anything to respond
        begin
          XVSetLED.Layout.Visible := false;
          SetNotSupported;
        end;
      BotVac, XV:
        begin
          XVSetLED.check;
          XVSetLED.Layout.Visible := True;
          // BotVac and XV are similar enough to share the XV code
        end;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabSetSchedule then
  begin
    case neatoType of
      BotVacConnected:
        // there IS a SetSchedule for D3-D7 but it appears not used anymore
        begin
          DXVSetSchedule.Layout.Visible := false;
          SetNotSupported;
        end;
      BotVac, XV:
        begin
          DXVSetSchedule.check;
          DXVSetSchedule.Layout.Visible := True;
        end;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabSetWallFollower then
  begin
    case neatoType of
      BotVac, BotVacConnected:
        begin
          DXVSetWallFollower.Layout.Visible := false;
          SetNotSupported;
        end;
      XV:
        begin
          DXVSetWallFollower.check;
          DXVSetWallFollower.Layout.Visible := True;
        end;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabSetDistanceCal then
  begin
    case neatoType of
      BotVac, BotVacConnected:
        begin
          DXVSetDistanceCal.Layout.Visible := false;
          SetNotSupported;
        end;
      XV:
        begin
          DXVSetDistanceCal.check;
          DXVSetDistanceCal.Layout.Visible := True;
        end;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabSetIEC then
  begin
    DXVSetIEC.check;
    DXVSetIEC.Layout.Visible := True;
  end;

  if TTabControl(Sender).ActiveTab = tabGetLifeStatLog then
  begin
    case neatoType of
      BotVac, BotVacConnected:
        begin
          DXVGetLifeStatLog.Layout.Visible := false;
          SetNotSupported;
        end;
      XV:
        begin
          DXVGetLifeStatLog.check;
          DXVGetLifeStatLog.Layout.Visible := True;
        end;
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabSetMotor then
    if Assigned(DXVSetMotor) then
    begin
      DXVSetMotor.check;
      DXVSetMotor.Layout.Visible := True;
    end;

  if TTabControl(Sender).ActiveTab = tabGetLDSScan then
  begin
    DXVGetLDSScan.check;
    DXVGetLDSScan.Layout.Visible := True;
    SetTimer(DXVGetLDSScan.timer_getdata);
  end;

  if TTabControl(Sender).ActiveTab = tabLidarView then
    if Assigned(DXVLidarView) then
    begin
      DXVLidarView.check;
      DXVLidarView.Layout.Visible := True;
      SetTimer(DXVLidarView.timer_getdata);
    end;

  if TTabControl(Sender).ActiveTab = tabTestLDS then
  begin
    DXVTestLDS.check;
    DXVTestLDS.Layout.Visible := True;
    SetTimer(DXVTestLDS.timer_getdata);
  end;

  if TTabControl(Sender).ActiveTab = tabSetBatteryTest then
    if Assigned(DXVSetBatteryTest) then
    begin
      DXVSetBatteryTest.check;
      DXVSetBatteryTest.Layout.Visible := True;
    end;

  /// ///////////////////////////////////////////////////////////////////////////////////////////////

  if TTabControl(Sender).ActiveTab = tabClearFiles then
    case neatoType of
      BotVacConnected, BotVac:
        begin
          DClearFiles.check;
          DClearFiles.Layout.Visible := True;
        end;
      XV:
        begin
          DClearFiles.Layout.Visible := false;
          SetNotSupported;
        end;
    end;

  if TTabControl(Sender).ActiveTab = tabRestoreDefaults then
    case neatoType of
      BotVacConnected, BotVac:
        begin
          XVRestoreDefaults.check;
          XVRestoreDefaults.Layout.Visible := false;
          SetNotSupported;
        end;
      XV:
        begin
          XVRestoreDefaults.check;
          XVRestoreDefaults.Layout.Visible := True;
        end;
    end;
  /// ///////////////////////////////////////////////////////////////////////////////////////////////

  if TTabControl(Sender).ActiveTab = tabGetWifiInfo then
    case neatoType of
      BotVacConnected:
        begin
          DGetWifiInfo.check;
          DGetWifiInfo.Layout.Visible := True;
        end;
      BotVac, XV:
        begin
          DGetWifiInfo.Layout.Visible := false;
          SetNotSupported;
        end;
    end;

  if TTabControl(Sender).ActiveTab = tabGetWifiStatus then
    case neatoType of
      BotVacConnected:
        begin
          DGetWifiStatus.check;
          DGetWifiStatus.Layout.Visible := True;
          SetTimer(DGetWifiStatus.timer_getdata);
        end;
      BotVac, XV:
        begin
          DGetWifiStatus.Layout.Visible := false;
          SetNotSupported;
        end;
    end;

  if TTabControl(Sender).ActiveTab = tabDebugTerminal then
  begin
    if Assigned(DXVTerminal) then
    begin
      DXVTerminal.Layout.Visible := True;
      if DXVTerminal.edDebugTerminalSend.CanFocus then
        DXVTerminal.edDebugTerminalSend.SetFocus;
      SetTimer(DXVTerminal.timer_getdata);
    end;
  end;

  if TTabControl(Sender).ActiveTab = tabSetLanguage then
    case neatoType of
      BotVac:
        begin
          DXVSetLanguage.check;
          DXVSetLanguage.Layout.Visible := True;
        end;
      BotVacConnected, XV:
        begin
          DXVSetLanguage.Layout.Visible := false;
          SetNotSupported;
        end;
    end;

  if TTabControl(Sender).ActiveTab = tabSetButton then
    case neatoType of
      BotVac, BotVacConnected: // maybe the connected ?
        begin
          DSetButton.check;
          DSetButton.Layout.Visible := True;
        end;
      XV:
        begin
          DSetButton.Layout.Visible := false;
          SetNotSupported;
        end;
    end;

  if TTabControl(Sender).ActiveTab = tabSetNTPTime then
    case neatoType of
      BotVacConnected: // maybe the connected ?
        begin
          DSetNTPTime.check;
          DSetNTPTime.Layout.Visible := True;
        end;
      BotVac, XV:
        begin
          DSetNTPTime.Layout.Visible := false;
          SetNotSupported;
        end;
    end;

  if TTabControl(Sender).ActiveTab = tabSetNavigationMode then
    case neatoType of
      BotVacConnected: // maybe the connected ?
        begin
          DSetNavigationMode.check;
          DSetNavigationMode.Layout.Visible := True;
        end;
      BotVac, XV:
        begin
          DSetNavigationMode.Layout.Visible := false;
          SetNotSupported;
        end;
    end;

  if TTabControl(Sender).ActiveTab = tabSetUsage then
    case neatoType of
      BotVacConnected: // maybe the connected ?
        begin
          DSetUsage.check;
          DSetUsage.Layout.Visible := True;
        end;
      BotVac, XV:
        begin
          DSetUsage.Layout.Visible := false;
          SetNotSupported;
        end;
    end;

  StartTimer;

  TTabControl(Sender).EndUpdate;
end;

procedure TfrmMain.StageTabs;
begin
  // create a whole bunch of tabs!
  dm.log := self.memoDebug;

  DGetCharger := TframeDGetCharger.Create(tabGetCharger, RectGetCharger);
  DXVGetAccel := TframeDXVGetAccel.Create(tabGetAccel, rectGetAccel);
  DGetAnalogSensors := TframeDGetAnalogSensors.Create(tabGetAnalogSensors, rectGetAnalogSensors);
  DGetDigitalSensors := TframeDGetDigitalSensors.Create(tabGetDigitalSensors, rectGetDigitalSensors);
  DGetSensors := TframeDGetSensors.Create(tabGetSensor, rectGetSensor);
  DGetMotors := TframeDGetMotors.Create(tabGetMotors, rectGetMotors);
  DGetButtons := TframeDGetButtons.Create(tabGetButtons, rectGetButtons);
  DGetCalInfo := TframeDGetCalInfo.Create(tabGetCalInfo, rectGetcalInfo);
  DGetWarranty := TframeDGetWarranty.Create(tabGetWarranty, rectGetWarranty);
  DGetErr := TframeDGetErr.Create(tabGetErr, rectGetErr);
  DGetVersion := TframeDGetVersion.Create(tabGetVersion, rectGetVersion);
  DGetUsage := TframeDGetUsage.Create(tabGetUsage, rectGetUsage);
  DGetUserSettings := TframeDGetUserSettings.Create(tabGetUserSettings, rectGetUserSettings);
  DClearFiles := TframeDClearFiles.Create(tabClearFiles, rectClearFiles);
  DGetWifiInfo := TframeDGetWifiInfo.Create(tabGetWifiInfo, rectGetWifiInfo);
  DGetWifiStatus := TframeDGetWifiStatus.Create(tabGetWifiStatus, rectGetWifiStatus);
  DSetNavigationMode := TframeDSetNavigationMode.Create(tabSetNavigationMode, rectSetNavigationMode);
  DSetUsage := TframeDSetUsage.Create(tabSetUsage, rectSetUsage);

  XVGetCharger := TframeXVGetCharger.Create(tabGetCharger, RectGetCharger);
  XVGetAnalogSensors := TframeXVGetAnalogSensors.Create(tabGetAnalogSensors, rectGetAnalogSensors);
  XVGetDigitalSensors := TframeXVGetDigitalSensors.Create(tabGetDigitalSensors, rectGetDigitalSensors);
  XVGetMotors := TframeXVGetMotors.Create(tabGetMotors, rectGetMotors);
  XVGetButtons := TframeXVGetButtons.Create(tabGetButtons, rectGetButtons);
  XVGetCalInfo := TframeXVGetCalInfo.Create(tabGetCalInfo, rectGetcalInfo);
  XVGetWarranty := TframeXVGetWarranty.Create(tabGetWarranty, rectGetWarranty);
  XVGetErr := TframeXVGetErr.Create(tabGetErr, rectGetErr);
  XVGetVersion := TframeXVGetVersion.Create(tabGetVersion, rectGetVersion);
  XVRestoreDefaults := TframeXVRestoreDefaults.Create(tabRestoreDefaults, rectRestoreDefaults);
  XVGetSchedule := TframeXVGetSchedule.Create(tabGetSchedule, rectGetSchedule);
  XVGetTime := TframeXVGetTime.Create(tabGetTime, rectGetTime);
  XVClean := TFrameXVClean.Create(tabClean, rectClean);
  XVSetLED := TframeXVSetLED.Create(tabSetLED, rectSetLED);

  DXVPlaySound := TframeDXVPlaySound.Create(tabPlaySound, rectPlaySound);
  DXVTerminal := TframeDXVTerminal.Create(tabDebugTerminal, rectTerminal);
  DXVGetLDSScan := TframeDXVGetLDSScan.Create(tabGetLDSScan, rectGetLDSScan);
  DXVSetFuelGauge := TframeDXVSetFuelGauge.Create(tabSetFuelGauge, rectSetFuelGauge);
  DXVSetTime := TframeDXVSetTime.Create(tabSetTime, rectSetTime);
  DXVSetSystemMode := TframeDXVSetSystemMode.Create(tabSetSystemMode, rectSetSystemMode);
  DXVSetLCD := TframeDXVSetLCD.Create(tabSetLCD, rectSetLCD);
  DXVSetSchedule := TframeXVSetSchedule.Create(tabSetSchedule, rectSetSchedule);
  DXVSetWallFollower := TframeDXVSetWallFollower.Create(tabSetWallFollower, rectSetWallFollower);
  DXVSetDistanceCal := TframeDXVSetDistanceCal.Create(tabSetDistanceCal, rectSetDistanceCal);
  DXVSetIEC := TframeDXVSetIEC.Create(tabSetIEC, rectSetIEC);
  DXVGetLifeStatLog := TframeDXVGetLifeStatLog.Create(tabGetLifeStatLog, rectGetLifeStatLog);
  DXVSetMotor := TframeDXVSetMotor.Create(tabSetMotor, rectSetMotor);
  DXVLidarView := TframeDXVLidarView.Create(tabLidarView, rectLidarView);
  DXVTestLDS := TframeDXVTestLDS.Create(tabTestLDS, rectTestLDS);
  DXVSetBatteryTest := TframeDXVSetBatteryTest.Create(tabSetBatteryTest, rectSetBatteryTest);
  DXVSetLanguage := TframeDXVSetLanguage.Create(tabSetLanguage, rectSetLanguage);
  DSetButton := TframeDSetButton.Create(tabSetButton, rectSetButton);
  DClean := TframeDClean.Create(tabClean, rectClean);
  DSetNTPTime := TframeDSetNTPTime.Create(tabSetNTPTime, rectSetNTPTime);

{$IFDEF MSWINDOWS}
  Scripts := TframeScriptEngine.Create(tabScripts);
  Scripts.Parent := tabScripts;
  Scripts.Position.X := 0;
  Scripts.Position.Y := 0;
  Scripts.Align := talignlayout.Client;
  Scripts.init;
{$ENDIF}
end;

procedure TfrmMain.rectSerialConnectClick(Sender: TObject);
begin
  if ckSerialConnect.enabled then
    ckSerialConnect.IsChecked := not ckSerialConnect.IsChecked;
end;

procedure TfrmMain.rectTCPConnectClick(Sender: TObject);
begin
  if ckTCPIPConnect.enabled then
    ckTCPIPConnect.IsChecked := not ckTCPIPConnect.IsChecked;
end;

procedure TfrmMain.rectTestModeClick(Sender: TObject);
begin
  if chkTestMode.enabled then
    chkTestMode.IsChecked := not chkTestMode.IsChecked;
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
