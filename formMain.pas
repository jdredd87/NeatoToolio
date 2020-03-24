{
  Try 32bit android wifi compile?

  XV16 works fine on android but not the botvac basic

  Basically redo the whole conneciton process for android.

  Split the calls up totally for Windows / Linux / Android to connect.
  It is to much of a damn mess


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
  Androidapi.Jni.App,
  Androidapi.Jni.JavaTypes,
  Androidapi.helpers,
  Androidapi.Jni.Widget,
  Androidapi.Jni.Os,
  FMX.helpers.Android,
  Androidapi.Jni,
{$ENDIF}
  frame.Master,
  dmSerial.Base,
  dmSerial.TCPIP,
  {Common neato units}
  Neato.helpers,
  Neato.Settings,
  frame.UserHelp,

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
  FMX.Platform,
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
    tabAbout: TTabItem;
    ShadowEffectmemoAbout: TShadowEffect;
    RectangleaboutMemo: trectangle;
    memoAbout: TMemo;
    tabSetLanguage: TTabItem;
    ColorBoxCNX: TColorBox;
    LabelCNX: TLabel;
    lblVersion: TLabel;
    RectGetCharger: trectangle;
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
    rectTestMode: trectangle;
    VertScrollBox: TVertScrollBox;
    Lang: TLang;
    cbLanguages: TComboBox;
    lblLanguages: TLabel;
    tabsSerialOptions: TTabControl;
    tabSerialSettings: TTabItem;
    pnlSerialTop: trectangle;
    cbCOM: TComboBox;
    chkAutoDetect: TCheckBox;
    edIPAddress: TEdit;
    edIPPort: TSpinBox;
    aniConnect: TAniIndicator;
    lblSetupComPort: TLabel;
    lblConnectIP: TLabel;
    rectSerialConnect: trectangle;
    ckSerialConnect: TCheckBox;
    rectTCPConnect: trectangle;
    ckTCPIPConnect: TCheckBox;
    imgRobot: TImage;
    shadowBotImage: TShadowEffect;
    lblSetupRobotName: TLabel;
    GlowEffect1: TGlowEffect;
    lblRobotModel: TLabel;
    ShadowEffect2: TShadowEffect;
    tabDebug: TTabItem;
    tabsDebuggerOptions: TTabControl;
    tabDebugTerminal: TTabItem;
    rectTerminal: trectangle;
    tabDebugRawData: TTabItem;
    memoDebug: TMemo;
    pnlDebugTerminalTop: trectangle;
    btnDebugRawDataClear: TButton;
    tabScripts: TTabItem;
    btnSerialHelp: TButton;
    lblConnectPort: TLabel;
    btnTCPHelp: TButton;
    timerMakeAvailable: TTimer;

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
    procedure btnSerialHelpClick(Sender: TObject);
    procedure btnTCPHelpClick(Sender: TObject);
    procedure timerMakeAvailableTimer(Sender: TObject);

  private

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
    procedure stopAniConnect(showBoth: Boolean);
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

    LidarTabFix: Boolean; // paint issue for mobile work around

{$IFDEF MSWINDOWS}
    Scripts: TframeScriptEngine; // currently just want this for windows until its "done"
    COMWin32: TdmSerialWindows;
{$ENDIF}
{$IFDEF ANDROID}
    COMAndroid: TdmSerialAndroid;
{$ENDIF}
    COMTCPIP: TdmSerialTCPIP;

    procedure StageTabs; // create and place our tabs depending on model
    procedure ResetTabs; // Reset tab states
    procedure PopulateCOMPorts; // repopulate drop down with active com ports
    procedure toggleComs(disable: Boolean); // connect/disconnect basically

{$IFDEF MSWINDOWS}
    Function HelpCheck: Boolean;
{$ENDIF}
{$IFDEF android}
    procedure OnPermission(Device: JUsbDevice; Granted: Boolean);
{$ENDIF}
{$IFNDEF MSWINDOWS}
{$IFNDEF LINUX}
    function HandleAppEvent(AAppEvent: TApplicationEvent; AContext: TObject): Boolean; // handle mobile event
{$ENDIF}
{$ENDIF}
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

    if directoryexists(System.IOUtils.TPath.GetPublicPath + '\NeatoToolio\Languages\') = false then
    begin
      cbLanguages.enabled := false;
      exit;
    end;

    LSearchOption := TSearchOption.soTopDirectoryOnly;
    LList := TDirectory.GetFiles(System.IOUtils.TPath.GetPublicPath + '\NeatoToolio\Languages\', '*.lang',
      LSearchOption);

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
  aFMXApplicationEventService: IFMXApplicationEventService;

begin

{$IFNDEF MSWINDOWS} // we really only want this for mobile guys
{$IFNDEF LINUX}
  if TPlatformServices.Current.SupportsPlatformService(IFMXApplicationEventService,
    IInterface(aFMXApplicationEventService)) then
    aFMXApplicationEventService.SetApplicationEventHandler(HandleAppEvent);
{$ENDIF}
{$ENDIF}
{$IFDEF ANDROID}
  self.cbLanguages.Visible := false; // turn this off for now until mappings are done
  cbLanguages.OnChange := nil;
  lblLanguages.Visible := false;
  ScaledLayoutMain.Align := talignlayout.Client;
  VKAutoShowMode := TVKAutoShowMode.Always;
  VertScrollBox.OnCalcContentBounds := CalcContentBoundsProc;
  OnVirtualKeyboardHidden := FormVirtualKeyboardHidden;
  OnVirtualKeyboardShown := FormVirtualKeyboardShown;
  self.OnFocusChanged := FormFocusChanged;
{$ENDIF}
  dm.chkTestMode := chkTestMode;

  memoAbout.font.Size := memoAbout.font.Size * 1.25;

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
  cbCOM.Width := cbCOM.Width * 1.8; // big com port driver names it appears
  cbCOM.Position.Y := self.chkAutoDetect.Position.Y; // move it up so have some room to click

  lblSetupComPort.Position.Y := cbCOM.Position.Y;

  COMAndroid.Serial.OnDeviceAttached := OnDeviceAttached;
  COMAndroid.Serial.OnDeviceDetached := OnDeviceDetached;
  COMAndroid.Serial.OnPermission := OnPermission;

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

{$IFNDEF ANDROID}
    aniConnect.margins.right := 75;
    aniConnect.Scale.X := 0.5;
    aniConnect.Scale.Y := 0.5;
{$ENDIF}
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

{$IFDEF MSWINDOWS}
  FindLanguages;
{$ENDIF}
end;

{$IFNDEF MSWINDOWS}
{$IFNDEF LINUX}

function TfrmMain.HandleAppEvent(AAppEvent: TApplicationEvent; AContext: TObject): Boolean;
begin
  case AAppEvent OF

    TApplicationEvent.BecameActive:
      ;

    TApplicationEvent.EnteredBackground:
      ;

    TApplicationEvent.FinishedLaunching:
      begin
        // possibly move the onCreate code to this event
        // that way user can get to the MAIN UI quickly and then
        // kick off code to do everything needed.
        // Desktop is fine, but mobile is more picky
      end;

    TApplicationEvent.LowMemory:
      ;

{$IFDEF IOS}
    TApplicationEvent.OpenURL:
      ;
    TApplicationEvent.TimeChange:
      ;
{$ENDIF}
    TApplicationEvent.WillBecomeForeground:
      begin
        try
          if assigned(dm.COM) then
          begin
            if NOT dm.COM.Active then
            begin
{$IFDEF android}
              if COMAndroid.requestingPermission then
                exit;
{$ENDIF}
              PopulateCOMPorts;
            end;
          end;
        finally
          // ick
        end;
      end;

    TApplicationEvent.WillBecomeInactive, TApplicationEvent.WillTerminate:
      begin
        try

          if assigned(dm.COM) then
          begin
{$IFDEF android}
            if COMAndroid.requestingPermission then
              exit;
{$ENDIF}
            tthread.CreateAnonymousThread(
              procedure
              begin
                if dm.COM.Active then
                begin
                  dm.COM.SendCommand('testmode OFF'); // make sure to turn this off when close app
                  dm.COM.SendCommand('testmode OFF'); // make sure to turn this off when close app
                  dm.COM.SendCommand('testmode OFF'); // make sure to turn this off when close app
                  dm.COM.Close;
                end;
              end).start;
          end;

        finally
          // ick
        end;
      end;

  end;
  Result := True;
end;
{$ENDIF}
{$ENDIF}
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
  if assigned(Focused) then
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
  lblVersion.Text := Neato.helpers.GetAppVersionStr;
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
      dm.COM.SendCommand('testmode OFF');
      // make sure to turn this off when close app
      dm.COM.SendCommand('testmode OFF'); // make sure to turn this off when close app
      dm.COM.SendCommand('testmode OFF'); // make sure to turn this off when close app
    finally
    end;
  end;

  try
    COMTCPIP.Close;
  finally
  end;

  try
{$IFDEF MSWINDOWS}
    COMWin32.Close;
{$ENDIF}
{$IFDEF ANDROID}
    COMAndroid.Close;
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
var
  idx: Integer;
begin
  COMAndroid.OnDeviceAttached(Device);
  PopulateCOMPorts;

  // most likely.. only going to have 1 device , so just pre select it!
  if cbCOM.count > 0 then
    cbCOM.itemindex := 0;

end;

procedure TfrmMain.OnDeviceDetached(Device: JUsbDevice);
begin
  comDisconnect;
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
    dm.COM.Close;
  finally
  end;

  ckSerialConnect.IsChecked := false;
  chkAutoDetect.enabled := True;
  cbCOM.enabled := True;
end;

procedure TfrmMain.ckSerialConnectChange(Sender: TObject);
begin
  dm.COM := {$IFDEF MSWindows} COMWin32;
{$ENDIF} {$IFDEF ANDROID} COMAndroid; {$ENDIF}
  // default as this will be the most use case
  stoptimers;
  toggleComs(ckSerialConnect.IsChecked);
end;

procedure TfrmMain.ckTCPIPConnectChange(Sender: TObject);
begin
  dm.COM := COMTCPIP;
  // default as this will be the most use case
  stoptimers;
  toggleComs(ckTCPIPConnect.IsChecked);
end;

procedure TfrmMain.btnSerialHelpClick(Sender: TObject);
var
  URL: String;
begin
{$IFDEF MSWINDOWS}
  URL := 'https://www.youtube.com/embed/Ka_HVPrXIfU?&autoplay=0&rel=0&enablejsapi=1';
{$ENDIF}
{$IFDEF ANDROID}
  URL := 'https://www.youtube.com/embed/kicMsbnoJng?&autoplay=0rel=0&enablejsapi=1';
{$ENDIF}
  OpenURL(URL);
end;

procedure TfrmMain.btnTCPHelpClick(Sender: TObject);
begin
  showmessage('Use your desired IP Address and Port to connect to your USB Serial to Network Adapter');
end;

procedure TfrmMain.cbLanguagesChange(Sender: TObject);
var
  l: string;
  languageFN: String;
begin

  l := cbLanguages.items[cbLanguages.itemindex];
  languageFN := System.IOUtils.TPath.GetPublicPath + '\NeatoToolio\Languages\neatotoolio.' + l + '.lang';

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
  if assigned(CurrentTimer) then
    CurrentTimer.enabled := false;

  case chkTestMode.IsChecked of
    True:
      dm.COM.SendCommand('TestMode ON');
    false:
      dm.COM.SendCommand('TestMode OFF');
  end;

  if assigned(CurrentTimer) then
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

  // turn controls off while waiting
  aniConnect.Visible := True;
  aniConnect.enabled := True;

  chkAutoDetect.enabled := false;
  cbCOM.enabled := false;
  self.ckSerialConnect.enabled := false;
  edIPAddress.enabled := false;
  edIPPort.enabled := false;
  self.ckTCPIPConnect.enabled := false;
  chkTestMode.enabled := false;

  if disable then
    comConnect
  else
    comDisconnect;

end;

procedure TfrmMain.stopAniConnect(showBoth: Boolean);
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

{$IFDEF MSWINDOWS}

Function TfrmMain.HelpCheck: Boolean;
var
  idx: Integer;
  R: String;
begin
  Result := false;
  if chkAutoDetect.IsChecked then
  begin
    dm.COM.onError := nil;
    for idx := 0 to cbCOM.items.count - 1 do
    begin
      COMWin32.ComPort := cbCOM.items[idx];

      if not dm.COM.Open then
        continue;

      R := dm.COM.SendCommand('HELP');
      memoDebug.Lines.add(^M^M);
      memoDebug.Lines.add('HELP Response : ' + R);

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
        dm.COM.Close;
      finally
      end;

    end;
    dm.COM.onError := FComPortError;
  end;

  if cbCOM.itemindex = -1 then
  begin
    Result := false;
  end
  else
  begin
    Result := True;
    COMWin32.ComPort := cbCOM.items[cbCOM.itemindex];
    Result := dm.COM.Open;
  end;
end;
{$ENDIF}
{$IFDEF android}

procedure TfrmMain.OnPermission(Device: JUsbDevice; Granted: Boolean);
begin
  if Granted then
  begin
    if COMAndroid.Serial.HasPermission(Device) then
      CallInUIThread(
        procedure
        begin
          comConnect;
        end);
  end
  else
  begin
    CallInUIThread(
      procedure
      begin
        COMAndroid.requestingPermission := false; // make sure to flip it back
        comDisconnect;
      end);
  end;

  COMAndroid.requestingPermission := false; // make sure to flip it back
end;
{$ENDIF}

procedure TfrmMain.comConnect;

begin

  ResetTabs;
  lblSetupRobotName.Text := '';
  lblRobotModel.Text := '';

  aniConnect.Visible := True;
  aniConnect.enabled := True;

  LidarTabFix := false;

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
      ComConnected: Boolean;

    begin
      botFound := false;
      ComConnected := True; // assume all good to start the checking process

      if (dm.COM is TdmSerialTCPIP) then // if we are TCPIP, simple, set host and port
      begin
        COMTCPIP.Serial.ConnectTimeout := 10000;
        COMTCPIP.IP := self.edIPAddress.Text;
        COMTCPIP.PORT := ROUND(self.edIPPort.Value);
        ComConnected := dm.COM.Open;

        if ComConnected = false then
        begin
          tthread.Synchronize(tthread.CurrentThread,
            procedure
            begin
              showmessage('Unable to TCP connect. ' + dm.COM.Error);
              toggleComs(false); // make sure to reset everything!
              timerMakeAvailable.enabled := True;
            end);
          exit;
        end;

      end
      else
      begin

{$IFDEF ANDROID}
        COMAndroid.ComPort := cbCOM.itemindex;
        ComConnected := dm.COM.Open; // can we open
        if (ComConnected = false) and (COMAndroid.requestingPermission) then
        begin
          sleep(1000);
          exit;
        end;
{$ELSE}
        if ComConnected = false then
        begin
          tthread.Synchronize(tthread.CurrentThread,
            procedure
            begin
              showmessage('Unable to open Serial Port. ' + dm.COM.Error);
              toggleComs(false); // make sure to reset everything!
              timerMakeAvailable.enabled := True
            end);
          exit;
        end;
{$ENDIF}
{$IFDEF MSWINDOWS}
        ComConnected := HelpCheck; // lets find a comport
        if ComConnected = false then
        begin
          tthread.Synchronize(tthread.CurrentThread,
            procedure
            begin
              showmessage('Serial Port open but failed communications. ' + dm.COM.Error);
              toggleComs(false); // make sure to reset everything!
              timerMakeAvailable.enabled := True
            end);
          exit;
        end;
{$ENDIF}
      end;

      ReadData := TStringList.Create;

      R := dm.COM.SendCommandAndWaitForValue(sGetVersion, 6000, ^Z, 1);

      memoDebug.Lines.add(^M^M);

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

        memoDebug.Lines.add(^M^M);

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
        memoDebug.Lines.add(^M^M);

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
            timerMakeAvailable.enabled := True;
          end
          else
            chkTestMode.enabled := True;
        end);

      freeandnil(ReadData);

    end).start;
end;

procedure TfrmMain.comDisconnect;
begin

{$IFDEF android}
  // we do this so we don't goof up the UI while trying to get permissions

  if assigned(dm.COM) then
  begin
    if dm.COM is TdmSerialAndroid then
    begin
      if COMAndroid.requestingPermission then
        exit;
    end;
  end;

{$ENDIF}
  tthread.CreateAnonymousThread(
    procedure
    begin
      try
        tthread.Synchronize(tthread.CurrentThread,
          procedure
          begin
            timerMakeAvailable.enabled := True;
          end);

        if assigned(dm.COM) then
        begin
          if dm.COM.Active then
          begin
            dm.COM.SendCommandOnly('');
            dm.COM.SendCommandOnly('TESTMODE OFF');
            dm.COM.Close;
          end;
        end;
      finally
        // ick
      end;

    end).start;

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
    ckTCPIPConnect.IsChecked := false;
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
  timerMakeAvailable.enabled := True;

{$IFDEF android}
  // most likely.. only going to have 1 device , so just pre select it!
  if cbCOM.count > 0 then
  begin
    cbCOM.itemindex := 0;
  end;
{$ENDIF}
end;

procedure TfrmMain.tabControlChange(Sender: TObject);

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
    if assigned(DXVSetMotor) then
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
    if assigned(DXVLidarView) then
    begin

{$IFDEF ANDROID}
      // odd issue for android side of things where the tChart renders wrong
      // this "fixes" it at a small visual/time cost to ender user.

      if tabsLidarOptions.ActiveTab = tabLidarView then
      begin
        if not LidarTabFix then
        begin
          LidarTabFix := True;
          tabsLidarOptions.enabled := false;
          tthread.CreateAnonymousThread(
            procedure
            begin
              sleep(10);
              tthread.Synchronize(tthread.CurrentThread,
                procedure
                begin
                  tabsLidarOptions.TabIndex := -1;
                end);

              sleep(10);

              tthread.Synchronize(tthread.CurrentThread,
                procedure
                begin
                  tabsLidarOptions.ActiveTab := tabLidarView;
                  tabsLidarOptions.enabled := True;
                  LidarTabFix := false;
                end);

            end).start;
        end;
      end;
{$ENDIF}
      DXVLidarView.Layout.Visible := True;
      DXVLidarView.check;
      SetTimer(DXVLidarView.timer_getdata);
    end;

  if TTabControl(Sender).ActiveTab = tabTestLDS then
  begin
    DXVTestLDS.check;
    DXVTestLDS.Layout.Visible := True;
    SetTimer(DXVTestLDS.timer_getdata);
  end;

  if TTabControl(Sender).ActiveTab = tabSetBatteryTest then
    if assigned(DXVSetBatteryTest) then
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
    if assigned(DXVTerminal) then
    begin
      DXVTerminal.Layout.Visible := True;
      if DXVTerminal.edDebugTerminalSend.canfocus then
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
      BotVac, BotVacConnected:
        // maybe the connected ?
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
      BotVacConnected:
        // maybe the connected ?
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
      BotVacConnected:
        // maybe the connected ?
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
      BotVacConnected:
        // maybe the connected ?
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

procedure TfrmMain.timerMakeAvailableTimer(Sender: TObject);
begin
  memoDebug.Lines.add('timerMakeAvailableTimer');

  timerMakeAvailable.enabled := false;
  try
    lblSetupRobotName.Text := '';
    lblRobotModel.Text := '';

    chkTestMode.enabled := false;
    chkTestMode.IsChecked := false;

    chkAutoDetect.enabled := True;
    ckSerialConnect.enabled := True;
    ckTCPIPConnect.enabled := True;
    cbCOM.enabled := True;
    self.edIPAddress.enabled := True;
    self.edIPPort.enabled := True;

    ckSerialConnect.IsChecked := false;
    ckTCPIPConnect.IsChecked := false;

    aniConnect.enabled := false;
    aniConnect.Visible := false;
    ResetTabs;

    LoadImageID('NeatoLogo', imgRobot);
  except
    on e: Exception do
    begin
      showmessage('MakeControlsAvailable Fatal Error : ' + e.message);
    end;
  end;
end;

procedure TfrmMain.StageTabs;
begin
  // create a whole bunch of tabs!
  dm.Log := self.memoDebug;

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
