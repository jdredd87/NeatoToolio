// reminders to futures self

// move all code out of the timers into their own routines...
// use timers to call them!

// possibly split up each Tab. Turn each tab to populate from a TFrame for each type?
// would help clean up this form, and modulize each tab/call. already 400+ components on one form... yikes.

// possibly swXXXXXXYYYYYYYvalue object names.. its a switch... so drop "value" off the end, getting wordy

// Cant find neato on com, get like 4 popups. derp.

// Possibly remove timers off form, and manually create one.
// Then can just stop the timer. unassign event, reassign it to new one.. and move on.
// Or set Tag # to define which event to use... who knows right now.

unit formMain;

interface

uses
{$IFDEF MSWINDOWS}
  Madexcept,
  Winsoft.FireMonkey.FComPort, dmSerial.Windows,
  WinAPI.Windows,
  FMX.Platform.WIN,
{$ENDIF}
  neato.GetCharger,
  neato.GetWarranty,
  neato.GetAccel,
  neato.GetAnalogSensors,
  neato.GetDigitalSensors,
  neato.GetErr,
  neato.Settings,
  neato.GetVersion,
  neato.GetUsage,
  neato.GetUserSettings,
  neato.GetSensor,
  neato.PlaySound,
  neato.GetMotors,
  neato.GetWifiInfo,
  neato.GetWifiStatus,
  neato.GetButtons,
  neato.GetCalInfo,
  neato.Helpers,
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.TabControl, FMX.ListBox,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.ScrollBox, FMX.Memo, FMX.Objects, FMX.Effects,
  System.Math.Vectors, FMX.Controls3D, FMX.Objects3D, FMX.Viewport3D,
  FMX.MaterialSources, FMX.Types3D, FMX.Filter.Effects, System.Rtti, FMX.Grid.Style, FMX.Grid, FMX.ExtCtrls, FMX.Edit,
  FMX.EditBox, FMX.SpinBox, FMX.NumberBox, FMX.ComboEdit, FMX.Colors;

type
  TfrmMain = class(TForm)
    StyleBook: TStyleBook;
    tabsMain: TTabControl;
    tabSetup: TTabItem;
    tabSensors: TTabItem;
    tabAbout: TTabItem;
    pnlSerialTop: TPanel;
    timer_GetCharger: TTimer;
    timer_getWarranty: TTimer;
    timer_GetAccel: TTimer;
    timer_GetAnalogSensors: TTimer;
    tabDebug: TTabItem;
    Model3D1Mat01: TLightMaterialSource;
    timer_GetDigitalSensors: TTimer;
    timer_GetErr: TTimer;
    ScaledLayoutMain: TScaledLayout;
    tabSensorsOptions: TTabControl;
    tabGetCharger: TTabItem;
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
    tabGetAccel: TTabItem;
    view3dGetAccelValue: TViewport3D;
    _3DGetAccel: TModel3D;
    Light1: TLight;
    pnlGetAccelLeft: TPanel;
    lblGetAccelPitchInDegrees: TLabel;
    lblGetAccelRollInDegrees: TLabel;
    lblGetAccelXInG: TLabel;
    lblGetAccelYInG: TLabel;
    lblGetAccelZInG: TLabel;
    lblGetAccelSumInG: TLabel;
    lblGetAccelSumInGValue: TLabel;
    lblGetAccelZInGValue: TLabel;
    lblGetAccelYInGValue: TLabel;
    lblGetAccelXInGValue: TLabel;
    lblGetAccelRollInDegreesValue: TLabel;
    lblGetAccelPitchInDegreesValue: TLabel;
    tabGetAnalogSensors: TTabItem;
    lblGetAnalogSensorsBatteryVoltage: TLabel;
    pbGetAnalogSensorsBatteryVoltageValue: TProgressBar;
    lblGetAnalogSensorsBatteryVoltageValue: TLabel;
    pbGetAnalogSensorsBatteryCurrentValue: TProgressBar;
    lblGetAnalogSensorsBatteryCurrentValue: TLabel;
    pbGetAnalogSensorsBatteryTemperatureValue: TProgressBar;
    lblGetAnalogSensorsBatteryTemperatureValue: TLabel;
    pbGetAnalogSensorsExternalVoltageValue: TProgressBar;
    lblGetAnalogSensorsExternalVoltageValue: TLabel;
    lblGetAnalogSensorsBatteryCurrent: TLabel;
    lblGetAnalogSensorsBatteryTemperature: TLabel;
    lblGetAnalogSensorsExternalVoltage: TLabel;
    lblGetAnalogSensorsAccelerometerX: TLabel;
    lblGetAnalogSensorsAccelerometerXValue: TLabel;
    lblGetAnalogSensorsAccelerometerY: TLabel;
    lblGetAnalogSensorsAccelerometerYValue: TLabel;
    lblGetAnalogSensorsAccelerometerZ: TLabel;
    lblGetAnalogSensorsAccelerometerZValue: TLabel;
    lblGetAnalogSensorsCompassmeterX: TLabel;
    lblGetAnalogSensorsCompassmeterXValue: TLabel;
    lblGetAnalogSensorsCompassmeterY: TLabel;
    lblGetAnalogSensorsCompassmeterYValue: TLabel;
    lblGetAnalogSensorsCompassmeterZ: TLabel;
    lblGetAnalogSensorsCompassmeterZValue: TLabel;
    lblGetAnalogSensorsGyroscopeX: TLabel;
    lblGetAnalogSensorsGyroscopeXValue: TLabel;
    lblGetAnalogSensorsGyroscopeY: TLabel;
    lblGetAnalogSensorsGyroscopeYValue: TLabel;
    lblGetAnalogSensorsGyroscopeZ: TLabel;
    lblGetAnalogSensorsGyroscopeZValue: TLabel;
    lblGetAnalogSensorsMagSensorLeft: TLabel;
    lblGetAnalogSensorsIMUAccelerometerXValue: TLabel;
    lblGetAnalogSensorsIMUAccelerometerY: TLabel;
    lblGetAnalogSensorsIMUAccelerometerYValue: TLabel;
    lblGetAnalogSensorsIMUAccelerometerZ: TLabel;
    lblGetAnalogSensorsIMUAccelerometerZValue: TLabel;
    lblGetAnalogSensorsVacuumCurrent: TLabel;
    lblGetAnalogSensorsVacuumCurrentValue: TLabel;
    lblGetAnalogSensorsSideBrushCurrent: TLabel;
    lblGetAnalogSensorsSideBrushCurrentValue: TLabel;
    lblGetAnalogSensorsWallSensor: TLabel;
    lblGetAnalogSensorsWallSensorValue: TLabel;
    lblGetAnalogSensorsDropSensorLeft: TLabel;
    lblGetAnalogSensorsDropSensorLeftValue: TLabel;
    lblGetAnalogSensorsDropSensorRight: TLabel;
    lblGetAnalogSensorsDropSensorRightValue: TLabel;
    swGetAnalogSensorsMagSensorLeftValue: TSwitch;
    swGetAnalogSensorsMagSensorRightValue: TSwitch;
    lblGetAnalogSensorsIMUAccelerometerX: TLabel;
    lblGetAnalogSensorsMagSensorRight: TLabel;
    tabGetDigitalSensors: TTabItem;
    swGetDigitalSensorsSNSR_DC_JACK_IS_INValue: TSwitch;
    lblGetDigitalSensorsSNSR_DC_JACK_IS_IN: TLabel;
    lblGetDigitalSensorsSNSR_DUSTBIN_IS_IN: TLabel;
    swGetDigitalSensorsSNSR_DUSTBIN_IS_INValue: TSwitch;
    lblGetDigitalSensorsSNSR_LEFT_WHEEL_EXTENDED: TLabel;
    swGetDigitalSensorsSNSR_LEFT_WHEEL_EXTENDEDValue: TSwitch;
    lblGetDigitalSensorsSNSR_RIGHT_WHEEL_EXTENDED: TLabel;
    swGetDigitalSensorsSNSR_RIGHT_WHEEL_EXTENDEDValue: TSwitch;
    lblGetDigitalSensorsRSIDEBIT: TLabel;
    swGetDigitalSensorsRSIDEBITValue: TSwitch;
    lblGetDigitalSensorsLLDSBIT: TLabel;
    swGetDigitalSensorsLLDSBITValue: TSwitch;
    swGetDigitalSensorsLFRONTBITValue: TSwitch;
    lblGetDigitalSensorsLFRONTBIT: TLabel;
    swGetDigitalSensorsLSIDEBITValue: TSwitch;
    lblGetDigitalSensorsLSIDEBIT: TLabel;
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
    lbl_CumulativeCleaningTimeInSecs: TLabel;
    lbl_CumulativeBatteryCycles: TLabel;
    lbl_ValidationCode: TLabel;
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
    timer_GetUsage: TTimer;
    timer_GetUserSettings: TTimer;

    lblGetUserSettingsLanguage: TLabel;
    lblGetUserSettingsLanguageValue: TLabel;
    lblGetUserSettingsClickSounds: TLabel;
    lblGetUserSettingsLED: TLabel;
    lblGetUserSettingsWallEnable: TLabel;
    lblGetUserSettingsEcoMode: TLabel;
    lblGetUserSettingsIntenseClean: TLabel;
    lblGetUserSettingsWiFi: TLabel;
    lblGetUserSettingsMelodySounds: TLabel;
    lblGetUserSettingsWarningSounds: TLabel;
    lblGetUserSettingsBinFullDetect: TLabel;
    lblGetUserSettingsFilterChnageTimeseconds: TLabel;
    lblGetUserSettingsFilterChnageTimesecondsValue: TLabel;
    lblGetUserSettingsBrushChangeTimeseconds: TLabel;
    lblGetUserSettingsBrushChangeTimesecondsValue: TLabel;
    lblGetUserSettingsDirtBinAlertReminderIntervalminutes: TLabel;
    lblGetUserSettingsDirtBinAlertReminderIntervalminutesValue: TLabel;
    lblGetUserSettingsCurrentDirtBinRuntimeis: TLabel;
    lblGetUserSettingsCurrentDirtBinRuntimeisValue: TLabel;
    lblGetUserSettingsNumberofCleaningwhereDustBinWasFullis: TLabel;
    lblGetUserSettingsNumberofCleaningwhereDustBinWasFullisValue: TLabel;
    lblGetUserSettingsScheduleis: TLabel;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox1: TCheckBox;
    swGetUserSettingsClickSoundsValue: TSwitch;
    swGetUserSettingsLEDValue: TSwitch;
    swGetUserSettingsWallEnableValue: TSwitch;
    swGetUserSettingsEcoModeValue: TSwitch;
    swGetUserSettingsIntenseCleanValue: TSwitch;
    swGetUserSettingsWiFiValue: TSwitch;
    swGetUserSettingsMelodySoundsValue: TSwitch;
    swGetUserSettingsWarningSoundsValue: TSwitch;
    swGetUserSettingsBinFullDetectValue: TSwitch;
    swGetUserSettingsScheduleisValue: TSwitch;
    TabDebugger: TTabControl;
    tabDebugRawData: TTabItem;
    tabDebugTerminal: TTabItem;
    memoDebug: TMemo;
    pnlDebugTerminalTop: TPanel;
    btnDebugTerminalClear: TButton;
    timer_GetSensor: TTimer;
    tabGetSensor: TTabItem;

    lblGetSensorWallFollower: TLabel;
    lblGetSensorUltraSound: TLabel;
    swGetSensorUltraSoundValue: TSwitch;
    swGetSensorWallFollowerValue: TSwitch;
    lblGetSensorDropSensors: TLabel;
    swGetSensorDropSensorsValue: TSwitch;
    lblGetSensorsensorsStatus: TLabel;
    lblGetSensorsensorsStatusValue: TLabel;
    lblGetSensorleftdropStatus: TLabel;
    lblGetSensorleftdropStatusValue: TLabel;
    lblGetSensorRightDropStatus: TLabel;
    lblGetSensorWallRightStatus: TLabel;
    lblGetSensorRightDropStatusValue: TLabel;
    lblGetSensorWallRightStatusValue: TLabel;
    lblGetSensorWheelDropStatus: TLabel;
    lblGetSensorLeftDropmm: TLabel;
    lblGetSensorWheelDropStatusValue: TLabel;
    lblGetSensorLeftDropmmValue: TLabel;
    lblGetSensorWallRightmm: TLabel;
    lblGetSensorWallRightmmValue: TLabel;
    lblGetSensorRightDropmmValue: TLabel;
    lblGetSensorRightDropmm: TLabel;
    lblGetSensorWheelDropmm: TLabel;
    lblGetSensorWheelDropmmValue: TLabel;
    lblGetSensorIMUAccelX: TLabel;
    lblGetSensorIMUAccelXValue: TLabel;
    lblGetSensorIMUAccelY: TLabel;
    lblGetSensorIMUAccelYValue: TLabel;
    lblGetSensorIMUAccelZ: TLabel;
    lblGetSensorIMUAccelZValue: TLabel;
    tabPlaySound: TTabItem;
    sgPlaysound: TStringGrid;
    sgPlaysoundID: TStringColumn;
    sgPlaySoundResponse: TStringColumn;
    lblPlaysoundIDX: TLabel;
    btnDebugTerminalHelp: TButton;
    tabGetMotors: TTabItem;
    lblGetMotorsBrush_RPM: TLabel;
    lblGetMotorsBrush_RPMValue: TLabel;
    lblGetMotorsBrush_mA: TLabel;
    lblGetMotorsBrush_mAValue: TLabel;
    lblGetMotorsVacuum_RPM: TLabel;
    lblGetMotorsVacuum_RPMValue: TLabel;
    lblGetMotorsVacuum_mA: TLabel;
    lblGetMotorsVacuum_mAValue: TLabel;
    lblGetMotorsLeftWheel_RPM: TLabel;
    lblGetMotorsLeftWheel_RPMValue: TLabel;
    lblGetMotorsLeftWheel_Load: TLabel;
    lblGetMotorsLeftWheel_LoadValue: TLabel;
    lblGetMotorsLeftWheel_PositionInMM: TLabel;
    lblGetMotorsLeftWheel_PositionInMMValue: TLabel;
    lblGetMotorsLeftWheel_Speed: TLabel;
    lblGetMotorsLeftWheel_SpeedValue: TLabel;
    lblGetMotorsLeftWheel_direction: TLabel;
    lblGetMotorsLeftWheel_directionValue: TLabel;
    lblGetMotorsRightWheel_RPM: TLabel;
    lblGetMotorsRightWheel_RPMValue: TLabel;
    lblGetMotorsRightWheel_Load: TLabel;
    lblGetMotorsRightWheel_LoadValue: TLabel;
    lblGetMotorsRightWheel_PositionInMM: TLabel;
    lblGetMotorsRightWheel_PositionInMMValue: TLabel;
    lblGetMotorsRightWheel_Speed: TLabel;
    lblGetMotorsRightWheel_SpeedValue: TLabel;
    lblGetMotorsRightWheel_direction: TLabel;
    lblGetMotorsRightWheel_directionValue: TLabel;
    lblGetMotorsROTATION_SPEED: TLabel;
    lblGetMotorsROTATION_SPEEDValue: TLabel;
    lblGetMotorsSideBrush_mA: TLabel;
    lblGetMotorsSideBrush_mAValue: TLabel;
    timer_GetMotors: TTimer;
    sgGetWifiInfo: TStringGrid;
    sgGetWifiInfoSSID: TStringColumn;
    sgGetWifiInfoSignal: TStringColumn;
    sgGetWifiInfoFrequency: TStringColumn;
    sgGetWifiInfoBSSID: TStringColumn;
    aniGetWifiInfo: TAniIndicator;
    pnlStatusBar: TPanel;
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
    timer_GetWifiStatus: TTimer;

    lblGetWifiStatusIPADDR: TLabel;
    lblGetWifiStatusIPADDRValue: TLabel;
    lblGetWifiStatusEnabled: TLabel;
    swGetWifiStatusEnabledValue: TSwitch;
    lblGetWifiStatusWifiMode: TLabel;
    lblGetWifiStatusWifiModeValue: TLabel;
    lblGetWifiStatusWifiOnInit: TLabel;
    swGetWifiStatusWifiOnInitValue: TSwitch;
    lblGetWifiStatusAPShutoffin: TLabel;
    lblGetWifiStatusAPShutoffinValue: TLabel;
    lblGetWifiStatusAPDesired: TLabel;
    swGetWifiStatusAPDesiredValue: TSwitch;
    lblGetWifiStatusLinkToBeehive: TLabel;
    swGetWifiStatusLinkToBeehiveValue: TSwitch;
    lblGetWifiStatusNucleoConnected: TLabel;
    swGetWifiStatusNucleoConnectedValue: TSwitch;
    lblGetWifiStatusEZConnectMessage: TLabel;
    lblGetWifiStatusEZConnectMessageValue: TLabel;
    lblGetWifiStatusRobotName: TLabel;
    lblGetWifiStatusSSID: TLabel;
    lblGetWifiStatusScanning: TLabel;
    lblGetWifiStatusSignalStrength: TLabel;
    lblGetWifiStatusBeehiveURL: TLabel;
    lblGetWifiStatusBSSID: TLabel;
    lblGetWifiStatusRobotNameValue: TLabel;
    lblGetWifiStatusSSIDValue: TLabel;
    lblGetWifiStatusScanningValue: TLabel;
    lblGetWifiStatusSignalStrengthValue: TLabel;
    lblGetWifiStatusBSSIDValue: TLabel;
    lblGetWifiStatusBeehiveURLValue: TLabel;
    lblGetWifiStatusNucleoURL: TLabel;
    lblGetWifiStatusNTPURL: TLabel;
    lblGetWifiStatusUTCOffset: TLabel;
    lblGetWifiStatusTimeZone: TLabel;
    lblGetWifiStatusNucleoURLValue: TLabel;
    lblGetWifiStatusNTPURLValue: TLabel;
    lblGetWifiStatusUTCOffsetValue: TLabel;
    lblGetWifiStatusTimeZoneValue: TLabel;
    pnlDebugTerminalBottom: TPanel;
    lblDebugTerminalCMD: TLabel;
    edDebugTerminalSend: TComboEdit;
    btnDebugTerminalSend: TButton;
    pnlDebugTerminalMemo: TPanel;
    memoDebugTerminal: TMemo;
    btnDebugTerminalSendHex: TButton;
    tabGetButtons: TTabItem;
    lblGetButtonsBTN_SOFT_KEY: TLabel;
    swGetButtonsBTN_SOFT_KEYvalue: TSwitch;
    lblGetButtonsBTN_SCROLL_UP: TLabel;
    swGetButtonsBTN_SCROLL_UPvalue: TSwitch;
    lblGetButtonsBTN_START: TLabel;
    swGetButtonsBTN_STARTvalue: TSwitch;
    lblGetButtonsBTN_BACK: TLabel;
    swGetButtonsBTN_BACKvalue: TSwitch;
    lblGetButtonsBTN_SCROLL_DOWN: TLabel;
    swGetButtonsBTN_SCROLL_DOWNvalue: TSwitch;
    lblGetButtonsBTN_SPOT: TLabel;
    swGetButtonsBTN_SPOTvalue: TSwitch;
    lblGetButtonsIR_BTN_HOME: TLabel;
    swGetButtonsIR_BTN_HOMEvalue: TSwitch;
    lblGetButtonsIR_BTN_SPOT: TLabel;
    swGetButtonsIR_BTN_SPOTvalue: TSwitch;
    lblGetButtonsIR_BTN_ECO: TLabel;
    swGetButtonsIR_BTN_ECOvalue: TSwitch;
    lblGetButtonsIR_BTN_UP: TLabel;
    swGetButtonsIR_BTN_UPvalue: TSwitch;
    lblGetButtonsIR_BTN_DOWN: TLabel;
    swGetButtonsIR_BTN_DOWNvalue: TSwitch;
    lblGetButtonsIR_BTN_RIGHT: TLabel;
    swGetButtonsIR_BTN_RIGHTvalue: TSwitch;
    lblGetButtonsIR_BTN_LEFT: TLabel;
    swGetButtonsIR_BTN_LEFTvalue: TSwitch;
    lblGetButtonsIR_BTN_START: TLabel;
    swGetButtonsIR_BTN_STARTvalue: TSwitch;
    lblGetButtonsIR_BTN_LEFT_ARC: TLabel;
    swGetButtonsIR_BTN_LEFT_ARCvalue: TSwitch;
    lblGetButtonsIR_BTN_RIGHT_ARC: TLabel;
    swGetButtonsIR_BTN_RIGHT_ARCvalue: TSwitch;
    timer_GetButtons: TTimer;
    pnlGetWifiInfoTop: TPanel;
    btnGetWifiInfoScan: TButton;
    Panel7: TPanel;
    lblPlaySoundID: TLabel;
    nbPlaySoundIDValue: TNumberBox;
    btnPlaySoundTest: TButton;
    btnSoundPlayTestAll: TButton;
    btnPlaySoundAbort: TButton;
    ckTestMode: TCheckBox;
    lblConnect: TLabel;
    lblSetupComPort: TLabel;
    cbCOM: TComboBox;
    chkAutoDetect: TCheckBox;
    timer_GetCalInfo: TTimer;
    tabGetCalInfo: TTabItem;
    lblGetCalInfoLDSOffset: TLabel;
    lblGetCalInfoLDSOffsetValue: TLabel;
    lblGetCalInfoXAccel: TLabel;
    lblGetCalInfoXAccelValue: TLabel;
    lblGetCalInfoYAccel: TLabel;
    lblGetCalInfoYAccelValue: TLabel;
    lblGetCalInfoZAccel: TLabel;
    lblGetCalInfoZAccelValue: TLabel;
    lblGetCalInfoRTCOffset: TLabel;
    lblGetCalInfoRTCOffsetValue: TLabel;
    lblGetCalInfoCleaningTestSurface: TLabel;
    lblGetCalInfoCleaningTestSurfaceValue: TLabel;
    lblGetCalInfoCleaningTestHardSpeed: TLabel;
    lblGetCalInfoCleaningTestHardSpeedValue: TLabel;
    lblGetCalInfoCleaningTestCarpetSpeed: TLabel;
    lblGetCalInfoCleaningTestCarpetSpeedValue: TLabel;
    lblGetCalInfoCleaningTestHardDistance: TLabel;
    lblGetCalInfoCleaningTestHardDistanceValue: TLabel;
    lblGetCalInfoCleaningTestCarpetDistance: TLabel;
    lblGetCalInfoCleaningTestCarpetDistanceValue: TLabel;
    lblGetCalInfoCleaningTestMode: TLabel;
    lblGetCalInfoCleaningTestModeValue: TLabel;
    lblGetCalInfoQAState: TLabel;
    lblGetCalInfoQAStateValue: TLabel;
    lblGetCalInfoLeftDropSensor_CalibrationData: TLabel;
    lblGetCalInfoLeftDropSensor_CalibrationDataValue: TLabel;
    lblGetCalInfoRightDropSensor_CalibrationData: TLabel;
    lblGetCalInfoRightDropSensor_CalibrationDataValue: TLabel;
    lblGetCalInfoWheelDropSensor_CalibrationData: TLabel;
    lblGetCalInfoWheelDropSensor_CalibrationDataValue: TLabel;
    lblGetCalInfoWallSensor_CalibrationData: TLabel;
    lblGetCalInfoWallSensor_CalibrationDataValue: TLabel;
    swConnect: TCheckBox;
    timer_StupidFix: TTimer;
    pnlSetupDetails: TPanel;
    lblSetupRobotName: TLabel;
    lblRobotModel: TLabel;
    imgRobot: TImage;
    procedure FormCreate(Sender: TObject);
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
    procedure timer_GetUserSettingsTimer(Sender: TObject);
    procedure btnDebugTerminalSendClick(Sender: TObject);
    procedure edDebugTerminalSendKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure btnDebugTerminalClearClick(Sender: TObject);
    procedure timer_GetSensorTimer(Sender: TObject);
    procedure btnPlaySoundTestClick(Sender: TObject);
    procedure btnSoundPlayTestAllClick(Sender: TObject);
    procedure btnPlaySoundAbortClick(Sender: TObject);
    procedure btnDebugTerminalHelpClick(Sender: TObject);
    procedure timer_GetMotorsTimer(Sender: TObject);
    procedure btnGetWifiInfoScanClick(Sender: TObject);
    procedure tabsWifiOptionsChange(Sender: TObject);
    procedure TabDebuggerChange(Sender: TObject);
    procedure timer_GetWifiStatusTimer(Sender: TObject);
    procedure timer_GetWifiInfoTimer(Sender: TObject);
    procedure timer_GetButtonsTimer(Sender: TObject);
    procedure timer_GetCalInfoTimer(Sender: TObject);
    procedure swConnectChange(Sender: TObject);
    procedure timer_StupidFixTimer(Sender: TObject);
  private
    fCurrentTimer: TTimer;
    fLIDARCounter: single;
    fPlaySoundAborted: Boolean;

    procedure PopulateCOMPorts;
    procedure toggleComs(disable: Boolean);
    procedure comConnect;
    procedure comDisconnect;
    procedure ResetGetAccel;
    procedure ResetGetDigitalSensors;
    procedure ResetGetErr;

    procedure onIDLE(Sender: TObject; var done: Boolean); // our idle code

    procedure FComPortAfterOpen(ComPort: TFComPort);
    procedure FComPortAfterClose(ComPort: TFComPort);
    procedure FComPortLineError(Sender: TObject; LineErrors: TLineErrors);
    procedure FComPortRxChar(Sender: TObject);
    procedure FComPortError(Sender: TObject); // mine not winsofts
    procedure FComPortEOL(Sender: TObject); // mine not winsofts, used to know when ^Z (char 26, hex $1A received)
    procedure FComPortDeviceUpdate(Sender: TObject; const DeviceName: string);

    procedure StopTimers;

  public
    com: TdmSerial;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  try
    deletefile('neato.toolio.log');
  except
  end;

  application.onIDLE := self.onIDLE;

{$IFDEF ANDORID}
  application.onException := self.onException;
{$ENDIF}
{$IFDEF MSWINDOWS}
  // I use MADEXCEPT for windows , so must use that event instead.
  // I lied - this eComError is handled via the MadExcept project settings
  // but if becomes an issues, can possibly deal with it here
{$ENDIF}
  tabsMain.TabIndex := 0;
  tabSensorsOptions.TabIndex := 0;
  tabsInfoOptions.TabIndex := 0;
  tabsWifiOptions.TabIndex := 0;

  chkAutoDetect.IsChecked := neatoSettings.AutoDetectNeato;
  chkAutoDetectChange(nil);

  aniGetWifiInfo.Visible := false;
  aniGetWifiInfo.Enabled := false;

  fCurrentTimer := nil;
  com := TdmSerial.Create(self);

  com.onError := FComPortError;
  com.com.OnLineError := FComPortLineError;
  com.com.afterclose := FComPortAfterClose;
  com.com.afteropen := FComPortAfterOpen;
  com.com.OnDeviceArrival := FComPortDeviceUpdate;
  com.com.OnDeviceRemoved := FComPortDeviceUpdate;

  com.FComSignalRX.ColorBox := self.ColorBoxRX;
  com.FComSignalCTS.ColorBox := self.ColorBoxCTS;
  com.FComSignalBreak.ColorBox := self.ColorBoxBreak;
  com.FComSignalRLSD.ColorBox := self.ColorBoxRLSD;
  com.FComSignalDSR.ColorBox := self.ColorBoxDSR;
  com.FComSignalTX.ColorBox := self.ColorBoxTX;

  tabsMain.Enabled := false;

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

procedure TfrmMain.PopulateCOMPorts;
var
  comList: TStringList;
begin
  comList := TStringList.Create;
  com.com.EnumComDevices(comList);
  cbCOM.BeginUpdate;
  cbCOM.Items.Assign(comList);
  cbCOM.EndUpdate;
  comList.Free;
  tabsMain.Enabled := true;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  freeandnil(com);
end;


// can use this event that when IDLE happens, which is very often and fast
// to enable/disable things , such as send buttons when com is open or not
// quick and easy way to keep UI up to date depending on com status

procedure TfrmMain.onIDLE(Sender: TObject; var done: Boolean);
var
  isActive: Boolean;
begin
  try
    isActive := com.com.Active;
  except
    isActive := false;
  end;

  btnDebugTerminalSend.Enabled := isActive;
  btnDebugTerminalSendHex.Enabled := isActive;
  btnDebugTerminalHelp.Enabled := isActive;
  btnGetWifiInfoScan.Enabled := isActive;
end;

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
  try
    com.com.Active := false;
  finally
  end;
  showmessage('COM Issue #' + com.errorcode.ToString + ' : ' + com.Error);

  swConnect.IsChecked := false;
  chkAutoDetect.Enabled := true;
  cbCOM.Enabled := true;
end;

procedure TfrmMain.FComPortRxChar(Sender: TObject);
var
  Text: AnsiString;
begin

  // beginupdate/endupdate fixes jumping of the memo box as each new text/line is added!!

  memoDebugTerminal.BeginUpdate;
  try
    Text := com.com.ReadAnsiString;
  except
    on E: Exception do
    begin
      Text := #10#13 + #10#13 + AnsiString(E.Message) + #10#13 + #1013;
    end;

  end;

  if pos(^Z, string(Text)) > 0 then
    FComPortEOL(Sender);

  memoDebugTerminal.Text := memoDebugTerminal.Text + string(Text);
  memoDebugTerminal.GoToTextEnd;

  memoDebugTerminal.EndUpdate;
end;

procedure TfrmMain.FComPortEOL(Sender: TObject);
begin
  // showmessage('^z found');
  // needs logic in here eventually to signal something waiting for data
end;

procedure TfrmMain.FComPortDeviceUpdate(Sender: TObject; const DeviceName: string);
begin
  if cbCOM.DroppedDown then
    cbCOM.DropDown;
  cbCOM.ItemIndex := -1;
  PopulateCOMPorts;
end;

procedure TfrmMain.StopTimers;
var
  idx: integer;
begin
  for idx := 0 to self.ComponentCount - 1 do
    if Components[idx] is TTimer then
      (Components[idx] as TTimer).Enabled := false;
  fCurrentTimer := nil;
end;

procedure TfrmMain.swConnectChange(Sender: TObject);
begin
  StopTimers;
  toggleComs(swConnect.IsChecked);
end;

procedure TfrmMain.TabDebuggerChange(Sender: TObject);
begin
  StopTimers;
  if TabDebugger.ActiveTab = tabDebugTerminal then
  begin
    edDebugTerminalSend.SetFocus;
  end;
end;

procedure TfrmMain.tabSensorsOptionsChange(Sender: TObject);
begin

  StopTimers;
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

          if tabSensorsOptions.ActiveTab = self.tabGetSensor then
          begin
            // ResetGetDigitalSensors;
            timer_GetSensor.Enabled := true;
            fCurrentTimer := timer_GetSensor;
            exit;
          end;

          if tabSensorsOptions.ActiveTab = self.tabGetMotors then
          begin
            timer_GetMotors.Enabled := true;
            fCurrentTimer := timer_GetMotors;
            exit;
          end;

          if tabSensorsOptions.ActiveTab = self.tabGetButtons then
          begin
            timer_GetButtons.Enabled := true;
            fCurrentTimer := timer_GetButtons;
            exit;
          end;

          if tabSensorsOptions.ActiveTab = self.tabGetCalInfo then
          begin
            timer_GetCalInfo.Enabled := true;
            fCurrentTimer := timer_GetCalInfo;
            exit;
          end;

        end);
    end).start;

end;

procedure TfrmMain.tabsLIDAROptionsChange(Sender: TObject);
begin
  StopTimers;
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
    end).start;

end;

procedure TfrmMain.tabsMainChange(Sender: TObject);
begin
  StopTimers;
  tthread.CreateAnonymousThread(
    procedure
    begin
      sleep(250); // allows the UI a few momments of drawing time
      // ran into an awkward issue that this seemed to fix

      tthread.Synchronize(tthread.CurrentThread,
        procedure
        begin

          if tabsMain.ActiveTab <> tabInfo then
            self.fPlaySoundAborted := true;

          if tabsMain.ActiveTab = tabSetup then
          begin
            if NOT com.com.Active then
              swConnect.IsChecked := false;
          end;

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

          if tabsMain.ActiveTab = self.tabDebug then
          begin
            self.TabDebugger.TabIndex := 0;
            self.TabDebuggerChange(nil);
            exit;
          end;

        end);
    end).start;

end;

procedure TfrmMain.tabsWifiOptionsChange(Sender: TObject);
begin
  StopTimers;
  tthread.CreateAnonymousThread(
    procedure
    begin
      sleep(250); // allows the UI a few momments of drawing time
      // ran into an awkward issue that this seemed to fix

      tthread.Synchronize(tthread.CurrentThread,
        procedure
        begin

          if tabsWifiOptions.ActiveTab = tabGetWifiStatus then
          begin
            timer_GetWifiStatus.Enabled := true;
            fCurrentTimer := timer_GetWifiStatus;
            exit;
          end;

          if tabsWifiOptions.ActiveTab = tabGetWifiInfo then
          begin
            // tab has no timer
            fCurrentTimer := nil;
            exit;
          end;

        end);

    end).start;
end;

procedure TfrmMain.tabsInfoOptionsChange(Sender: TObject);
begin
  StopTimers;
  tthread.CreateAnonymousThread(
    procedure
    begin
      sleep(250); // allows the UI a few momments of drawing time
      // ran into an awkward issue that this seemed to fix

      tthread.Synchronize(tthread.CurrentThread,
        procedure
        begin

          if tabsInfoOptions.ActiveTab = tabPlaySound then
            fPlaySoundAborted := false;

          if (tabsInfoOptions.ActiveTab <> tabPlaySound) then
            fPlaySoundAborted := true;

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

          if tabsInfoOptions.ActiveTab = tabGetUserSettings then
          begin
            // setGetErr;
            timer_GetUserSettings.Enabled := true;
            fCurrentTimer := timer_GetUserSettings;
            exit;
          end;

        end);

    end).start;
end;

procedure TfrmMain.chkAutoDetectChange(Sender: TObject);
begin
  cbCOM.Enabled := NOT chkAutoDetect.IsChecked;
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
    lblGetAccelPitchInDegreesValue.Text := pGetAccel.PitchInDegrees.ToString;
    lblGetAccelRollInDegreesValue.Text := pGetAccel.RollInDegrees.ToString;
    lblGetAccelXInGValue.Text := pGetAccel.XInG.ToString;
    lblGetAccelYInGValue.Text := pGetAccel.YInG.ToString;
    lblGetAccelZInGValue.Text := pGetAccel.ZInG.ToString;
    lblGetAccelSumInGValue.Text := pGetAccel.SumInG.ToString;

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

  if (com.com.Active = false) or (tabSensorsOptions.ActiveTab <> tabGetCharger) or (tabsMain.ActiveTab <> tabSensors)
  then
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

procedure TfrmMain.timer_GetWifiInfoTimer(Sender: TObject);
begin
  //
end;

procedure TfrmMain.timer_GetWifiStatusTimer(Sender: TObject);
var
  pGetWifiStatus: tGetWifiStatus;
  pReadData: TStringList;
  r: Boolean;
begin

  if (com.com.Active = false) or (tabsWifiOptions.ActiveTab <> tabGetWifiStatus) then
  begin
    timer_GetWifiStatus.Enabled := false;
    exit;
  end;

  pGetWifiStatus := tGetWifiStatus.Create;

  pReadData := TStringList.Create;
  pReadData.Text := com.SendCommand(sGetWifiStatus);
  pReadData.Text := stringreplace(pReadData.Text, ',', '=', [rfreplaceall]);

  r := pGetWifiStatus.ParseText(pReadData);

  if r then
  begin

    lblGetWifiStatusIPADDRValue.Text := pGetWifiStatus.IPADDR;
    swGetWifiStatusEnabledValue.IsChecked := pGetWifiStatus.Enabled;
    lblGetWifiStatusWifiModeValue.Text := pGetWifiStatus.Wifi_Mode;
    swGetWifiStatusWifiOnInitValue.IsChecked := pGetWifiStatus.Wifi_On_Init;
    lblGetWifiStatusAPShutoffinValue.Text := pGetWifiStatus.AP_Shutoff_in;
    swGetWifiStatusAPDesiredValue.IsChecked := pGetWifiStatus.AP_Desired;
    swGetWifiStatusLinkToBeehiveValue.IsChecked := pGetWifiStatus.Linked_to_Beehive;
    swGetWifiStatusNucleoConnectedValue.IsChecked := pGetWifiStatus.Nucleo_Connected;
    lblGetWifiStatusEZConnectMessageValue.Text := pGetWifiStatus.EZ_Connect_Message;
    lblGetWifiStatusRobotNameValue.Text := pGetWifiStatus.Robot_Name;
    lblGetWifiStatusSSIDValue.Text := pGetWifiStatus.SSID;
    lblGetWifiStatusScanningValue.Text := pGetWifiStatus.Scanning;
    lblGetWifiStatusSignalStrengthValue.Text := pGetWifiStatus.SignalStrength.ToString;
    lblGetWifiStatusBSSIDValue.Text := pGetWifiStatus.BSSID;
    lblGetWifiStatusBeehiveURLValue.Text := pGetWifiStatus.Beehive_URL;
    lblGetWifiStatusNucleoURLValue.Text := pGetWifiStatus.Nucleo_URL;
    lblGetWifiStatusNTPURLValue.Text := pGetWifiStatus.NTP_URL;
    lblGetWifiStatusUTCOffsetValue.Text := pGetWifiStatus.UTC_Offset;
    lblGetWifiStatusTimeZoneValue.Text := pGetWifiStatus.Time_Zone;
  end;

  pReadData.Free;
  pGetWifiStatus.Free;
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

    pbGetAnalogSensorsBatteryVoltageValue.Value := pGetAnalogSensors.BatteryVoltage.ValueDouble;

    lblGetAnalogSensorsBatteryVoltageValue.Text := pGetAnalogSensors.BatteryVoltage.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.BatteryVoltage._Unit;

    pbGetAnalogSensorsBatteryCurrentValue.Value := pGetAnalogSensors.BatteryCurrent.ValueDouble;
    lblGetAnalogSensorsBatteryCurrentValue.Text := pGetAnalogSensors.BatteryCurrent.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.BatteryCurrent._Unit;

    pbGetAnalogSensorsBatteryTemperatureValue.Value := pGetAnalogSensors.BatteryTemperature.ValueDouble;
    lblGetAnalogSensorsBatteryTemperatureValue.Text := pGetAnalogSensors.BatteryTemperature.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.BatteryTemperature._Unit;

    pbGetAnalogSensorsExternalVoltageValue.Value := pGetAnalogSensors.ExternalVoltage.ValueDouble;
    lblGetAnalogSensorsExternalVoltageValue.Text := pGetAnalogSensors.ExternalVoltage.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.ExternalVoltage._Unit;

    lblGetAnalogSensorsAccelerometerXValue.Text := pGetAnalogSensors.AccelerometerX.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.AccelerometerX._Unit;
    lblGetAnalogSensorsAccelerometerYValue.Text := pGetAnalogSensors.AccelerometerY.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.AccelerometerY._Unit;
    lblGetAnalogSensorsAccelerometerZValue.Text := pGetAnalogSensors.AccelerometerZ.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.AccelerometerZ._Unit;

    lblGetAnalogSensorsCompassmeterXValue.Text := pGetAnalogSensors.CompassmeterX.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.CompassmeterX._Unit;
    lblGetAnalogSensorsCompassmeterYValue.Text := pGetAnalogSensors.CompassmeterY.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.CompassmeterY._Unit;
    lblGetAnalogSensorsCompassmeterZValue.Text := pGetAnalogSensors.CompassmeterZ.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.CompassmeterZ._Unit;

    lblGetAnalogSensorsGyroscopeXValue.Text := pGetAnalogSensors.GyroscopeX.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.GyroscopeX._Unit;
    lblGetAnalogSensorsGyroscopeYValue.Text := pGetAnalogSensors.GyroscopeY.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.GyroscopeY._Unit;
    lblGetAnalogSensorsGyroscopeZValue.Text := pGetAnalogSensors.GyroscopeZ.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.GyroscopeZ._Unit;

    lblGetAnalogSensorsIMUAccelerometerXValue.Text := pGetAnalogSensors.IMUAccelerometerX.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.IMUAccelerometerX._Unit;
    lblGetAnalogSensorsIMUAccelerometerYValue.Text := pGetAnalogSensors.IMUAccelerometerY.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.IMUAccelerometerY._Unit;
    lblGetAnalogSensorsIMUAccelerometerZValue.Text := pGetAnalogSensors.IMUAccelerometerZ.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.IMUAccelerometerZ._Unit;

    lblGetAnalogSensorsVacuumCurrentValue.Text := pGetAnalogSensors.VacuumCurrent.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.VacuumCurrent._Unit;
    lblGetAnalogSensorsWallSensorValue.Text := pGetAnalogSensors.WallSensor.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.WallSensor._Unit;
    lblGetAnalogSensorsDropSensorLeftValue.Text := pGetAnalogSensors.DropSensorLeft.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.DropSensorLeft._Unit;
    lblGetAnalogSensorsDropSensorRightValue.Text := pGetAnalogSensors.DropSensorRight.ValueDouble.ToString + ' ' +
      pGetAnalogSensors.DropSensorRight._Unit;

    swGetAnalogSensorsMagSensorLeftValue.IsChecked := pGetAnalogSensors.MagSensorLeft.ValueBoolean;
    swGetAnalogSensorsMagSensorRightValue.IsChecked := pGetAnalogSensors.MagSensorRight.ValueBoolean;

  end;
  pReadData.Free;
  pGetAnalogSensors.Free;
end;

procedure TfrmMain.timer_GetCalInfoTimer(Sender: TObject);
var
  pGetCalInfo: tGetCalInfo;
  pReadData: TStringList;
  r: Boolean;
begin

  if (com.com.Active = false) or (tabSensorsOptions.ActiveTab <> tabGetCalInfo) then
  begin
    timer_GetButtons.Enabled := false;
    exit;
  end;

  pGetCalInfo := tGetCalInfo.Create;

  pReadData := TStringList.Create;
  pReadData.Text := com.SendCommand(sGetCalInfo);
  memoDebug.Lines.Text := pReadData.Text;

  r := pGetCalInfo.ParseText(pReadData);

  if r then
  begin
    lblGetCalInfoLDSOffsetValue.Text := pGetCalInfo.LDSOffset.ToString;
    lblGetCalInfoXAccelValue.Text := pGetCalInfo.XAccel.ToString;
    lblGetCalInfoYAccelValue.Text := pGetCalInfo.YAccel.ToString;
    lblGetCalInfoZAccelValue.Text := pGetCalInfo.ZAccel.ToString;
    lblGetCalInfoRTCOffsetValue.Text := pGetCalInfo.RTCOffset.ToString;
    lblGetCalInfoCleaningTestSurfaceValue.Text := pGetCalInfo.CleaningTestSurface;
    lblGetCalInfoCleaningTestHardSpeedValue.Text := pGetCalInfo.CleaningTestHardSpeed.ToString;
    lblGetCalInfoCleaningTestCarpetSpeedValue.Text := pGetCalInfo.CleaningTestCarpetSpeed.ToString;
    lblGetCalInfoCleaningTestHardDistanceValue.Text := pGetCalInfo.CleaningTestHardDistance.ToString;
    lblGetCalInfoCleaningTestCarpetDistanceValue.Text := pGetCalInfo.CleaningTestCarpetDistance.ToString;
    lblGetCalInfoCleaningTestModeValue.Text := pGetCalInfo.CleaningTestMode.ToString;
    lblGetCalInfoQAStateValue.Text := pGetCalInfo.QAState;
    lblGetCalInfoLeftDropSensor_CalibrationDataValue.Text := pGetCalInfo.LeftDropSensor_CalibrationData.ToString;
    lblGetCalInfoRightDropSensor_CalibrationDataValue.Text := pGetCalInfo.RightDropSensor_CalibrationData.ToString;
    lblGetCalInfoWheelDropSensor_CalibrationDataValue.Text := pGetCalInfo.WheelDropSensor_CalibrationData.ToString;
    lblGetCalInfoWallSensor_CalibrationDataValue.Text := pGetCalInfo.WallSensor_CalibrationData.ToString;
  end;

  pReadData.Free;
  pGetCalInfo.Free;
end;

procedure TfrmMain.timer_GetButtonsTimer(Sender: TObject);
var
  pGetButtons: tGetButtons;
  pReadData: TStringList;
  r: Boolean;
begin

  if (com.com.Active = false) or (tabSensorsOptions.ActiveTab <> tabGetButtons) then
  begin
    timer_GetButtons.Enabled := false;
    exit;
  end;

  pGetButtons := tGetButtons.Create;

  pReadData := TStringList.Create;
  pReadData.Text := com.SendCommand(sGetButtons);
  memoDebug.Lines.Text := pReadData.Text;

  r := pGetButtons.ParseText(pReadData);

  if r then
  begin
    swGetButtonsBTN_SOFT_KEYvalue.IsChecked := pGetButtons.BTN_SOFT_KEY;
    swGetButtonsBTN_SCROLL_UPvalue.IsChecked := pGetButtons.BTN_SCROLL_UP;
    swGetButtonsBTN_STARTvalue.IsChecked := pGetButtons.BTN_START;
    swGetButtonsBTN_BACKvalue.IsChecked := pGetButtons.BTN_BACK;
    swGetButtonsBTN_SCROLL_DOWNvalue.IsChecked := pGetButtons.BTN_SCROLL_DOWN;
    swGetButtonsBTN_SPOTvalue.IsChecked := pGetButtons.BTN_SPOT;
    swGetButtonsIR_BTN_HOMEvalue.IsChecked := pGetButtons.IR_BTN_HOME;
    swGetButtonsIR_BTN_SPOTvalue.IsChecked := pGetButtons.IR_BTN_SPOT;
    swGetButtonsIR_BTN_ECOvalue.IsChecked := pGetButtons.IR_BTN_ECO;
    swGetButtonsIR_BTN_UPvalue.IsChecked := pGetButtons.IR_BTN_UP;
    swGetButtonsIR_BTN_DOWNvalue.IsChecked := pGetButtons.IR_BTN_DOWN;
    swGetButtonsIR_BTN_RIGHTvalue.IsChecked := pGetButtons.IR_BTN_RIGHT;
    swGetButtonsIR_BTN_LEFTvalue.IsChecked := pGetButtons.IR_BTN_LEFT;
    swGetButtonsIR_BTN_STARTvalue.IsChecked := pGetButtons.IR_BTN_START;
    swGetButtonsIR_BTN_LEFT_ARCvalue.IsChecked := pGetButtons.IR_BTN_LEFT;
    swGetButtonsIR_BTN_RIGHT_ARCvalue.IsChecked := pGetButtons.IR_BTN_RIGHT_ARC;
  end;

  pReadData.Free;
  pGetButtons.Free;
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
    swGetDigitalSensorsSNSR_DC_JACK_IS_INValue.IsChecked := pGetDigitalSensors.SNSR_DC_JACK_IS_IN.ValueBoolean;
    swGetDigitalSensorsSNSR_DUSTBIN_IS_INValue.IsChecked := pGetDigitalSensors.SNSR_DUSTBIN_IS_IN.ValueBoolean;
    swGetDigitalSensorsSNSR_LEFT_WHEEL_EXTENDEDValue.IsChecked :=
      pGetDigitalSensors.SNSR_LEFT_WHEEL_EXTENDED.ValueBoolean;
    swGetDigitalSensorsSNSR_RIGHT_WHEEL_EXTENDEDValue.IsChecked :=
      pGetDigitalSensors.SNSR_RIGHT_WHEEL_EXTENDED.ValueBoolean;
    swGetDigitalSensorsLSIDEBITValue.IsChecked := pGetDigitalSensors.LSIDEBIT.ValueBoolean;
    swGetDigitalSensorsLFRONTBITValue.IsChecked := pGetDigitalSensors.LFRONTBIT.ValueBoolean;
    swGetDigitalSensorsLLDSBITValue.IsChecked := pGetDigitalSensors.LLDSBIT.ValueBoolean;
    swGetDigitalSensorsRSIDEBITValue.IsChecked := pGetDigitalSensors.RSIDEBIT.ValueBoolean;
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

procedure TfrmMain.timer_GetMotorsTimer(Sender: TObject);
var
  pGetMotors: tGetMotors;
  pReadData: TStringList;
  r: Boolean;
begin

  if (com.com.Active = false) or (self.tabSensorsOptions.ActiveTab <> tabGetMotors) then
  begin
    timer_GetMotors.Enabled := false;
    exit;
  end;

  pGetMotors := tGetMotors.Create;

  pReadData := TStringList.Create;
  pReadData.Text := com.SendCommand(sGetMotors);
  memoDebug.Lines.Text := pReadData.Text;

  r := pGetMotors.ParseText(pReadData);

  if r then
  begin
    lblGetMotorsBrush_RPMValue.Text := pGetMotors.Brush_RPM.ToString;
    lblGetMotorsBrush_mAValue.Text := pGetMotors.Brush_mA.ToString;

    lblGetMotorsVacuum_RPMValue.Text := pGetMotors.Vacuum_RPM.ToString;
    lblGetMotorsVacuum_mAValue.Text := pGetMotors.Vacuum_mA.ToString;

    lblGetMotorsLeftWheel_RPMValue.Text := pGetMotors.LeftWheel_RPM.ToString;
    lblGetMotorsLeftWheel_LoadValue.Text := pGetMotors.LeftWheel_Load.ToString;
    lblGetMotorsLeftWheel_PositionInMMValue.Text := pGetMotors.LeftWheel_PositionInMM.ToString;
    lblGetMotorsLeftWheel_SpeedValue.Text := pGetMotors.LeftWheel_Speed.ToString;
    lblGetMotorsLeftWheel_directionValue.Text := pGetMotors.LeftWheel_direction.ToString;

    lblGetMotorsRightWheel_RPMValue.Text := pGetMotors.RightWheel_RPM.ToString;
    lblGetMotorsRightWheel_LoadValue.Text := pGetMotors.RightWheel_Load.ToString;
    lblGetMotorsRightWheel_PositionInMMValue.Text := pGetMotors.RightWheel_PositionInMM.ToString;
    lblGetMotorsRightWheel_SpeedValue.Text := pGetMotors.RightWheel_Speed.ToString;
    lblGetMotorsRightWheel_directionValue.Text := pGetMotors.RightWheel_direction.ToString;

    lblGetMotorsROTATION_SPEEDValue.Text := pGetMotors.ROTATION_SPEED.ToString;
    lblGetMotorsSideBrush_mAValue.Text := pGetMotors.SideBrush_mA.ToString;
  end;

  pReadData.Free;
  pGetMotors.Free;
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

procedure TfrmMain.timer_GetUserSettingsTimer(Sender: TObject);
var
  pGetUserSettings: tGetUserSettings;
  pReadData: TStringList;
  r: Boolean;
begin

  if (com.com.Active = false) or (tabsInfoOptions.ActiveTab <> tabGetUserSettings) then
  begin
    timer_GetUserSettings.Enabled := false;
    exit;
  end;

  pGetUserSettings := tGetUserSettings.Create;

  pReadData := TStringList.Create;
  pReadData.Text := com.SendCommand(sGetUserSettings);
  memoDebug.Lines.Text := pReadData.Text;

  r := pGetUserSettings.ParseText(pReadData);

  if r then
  begin
    lblGetUserSettingsLanguageValue.Text := pGetUserSettings.Language;
    lblGetUserSettingsFilterChnageTimesecondsValue.Text := pGetUserSettings.Filter_Change_Time_seconds.ToString;
    lblGetUserSettingsBrushChangeTimesecondsValue.Text := pGetUserSettings.Brush_Change_Time_seconds.ToString;
    lblGetUserSettingsDirtBinAlertReminderIntervalminutesValue.Text :=
      pGetUserSettings.Dirt_Bin_Alert_Reminder_Interval_minutes.ToString;
    lblGetUserSettingsCurrentDirtBinRuntimeisValue.Text := pGetUserSettings.Current_Dirt_Bin_Runtime_is.ToString;
    lblGetUserSettingsNumberofCleaningwhereDustBinWasFullisValue.Text :=
      pGetUserSettings.Number_of_Cleanings_where_Dust_Bin_was_Full_is.ToString;

    swGetUserSettingsClickSoundsValue.IsChecked := pGetUserSettings.ClickSounds;
    swGetUserSettingsLEDValue.IsChecked := pGetUserSettings.LED;
    swGetUserSettingsWallEnableValue.IsChecked := pGetUserSettings.Wall_Enable;
    swGetUserSettingsEcoModeValue.IsChecked := pGetUserSettings.Eco_Mode;
    swGetUserSettingsIntenseCleanValue.IsChecked := pGetUserSettings.IntenseClean;
    swGetUserSettingsWiFiValue.IsChecked := pGetUserSettings.WiFi;
    swGetUserSettingsMelodySoundsValue.IsChecked := pGetUserSettings.Melody_Sounds;
    swGetUserSettingsWarningSoundsValue.IsChecked := pGetUserSettings.Warning_Sounds;
    swGetUserSettingsBinFullDetectValue.IsChecked := pGetUserSettings.Bin_Full_Detect;
    swGetUserSettingsScheduleisValue.IsChecked := pGetUserSettings.Schedule_is;

  end;

  pReadData.Free;
  pGetUserSettings.Free;
end;

procedure TfrmMain.timer_GetSensorTimer(Sender: TObject);
var
  pGetSensor: tGetSensor;
  pReadData: TStringList;
  r: Boolean;
begin

  if (com.com.Active = false) or (tabSensorsOptions.ActiveTab <> tabGetSensor) then
  begin
    timer_GetSensor.Enabled := false;
    exit;
  end;

  pGetSensor := tGetSensor.Create;

  pReadData := TStringList.Create;
  pReadData.Text := com.SendCommand(sGetSensor);
  memoDebug.Lines.Text := pReadData.Text;

  r := pGetSensor.ParseText(pReadData);

  if r then
  begin
    swGetSensorWallFollowerValue.IsChecked := pGetSensor.Wall_Follower;
    swGetSensorUltraSoundValue.IsChecked := pGetSensor.Ultra_Sound;
    swGetSensorDropSensorsValue.IsChecked := pGetSensor.Drop_Sensors;

    lblGetSensorsensorsStatusValue.Text := pGetSensor.sensor_Status.ToString;
    lblGetSensorleftdropStatusValue.Text := pGetSensor.left_drop_Status.ToString;
    lblGetSensorRightDropStatusValue.Text := pGetSensor.right_drop_Status.ToString;
    lblGetSensorWallRightStatusValue.Text := pGetSensor.wall_right_Status.ToString;
    lblGetSensorWheelDropStatusValue.Text := pGetSensor.wheel_drop_Status.ToString;
    lblGetSensorWallRightmmValue.Text := pGetSensor.wall_right_mm.ToString;
    lblGetSensorRightDropmmValue.Text := pGetSensor.right_drop_mm.ToString;
    lblGetSensorWheelDropmmValue.Text := pGetSensor.wheel_drop_mm.ToString;
    lblGetSensorIMUAccelXValue.Text := pGetSensor.IMU_accel_x.ToString;
    lblGetSensorIMUAccelYValue.Text := pGetSensor.IMU_accel_y.ToString;
    lblGetSensorIMUAccelZValue.Text := pGetSensor.IMU_accel_z.ToString;
  end;

  pReadData.Free;
  pGetSensor.Free;
end;

procedure TfrmMain.timer_LIDARTimer(Sender: TObject);

  procedure LoadCSV(ScanData: String; sg: TStringGrid);
  var
    i, j, Position, Count, edt1: integer;
    temp, tempField: string;
    FieldDel: Char;
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
      while pos('"', temp) > 0 do
      begin
        Delete(temp, pos('"', temp), 1);
      end;
      for j := 1 to edt1 do
      begin
        Position := pos(FieldDel, temp);
        tempField := copy(temp, 0, Position - 1);

        sg.Cells[j - 1, i] := tempField;

        Delete(temp, 1, length(tempField) + 1);
      end;
    end;
    Data.Free;
  end;

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

    p: TPointF;

  begin


    // Plot -6000 +6000 X, -6000 +6000 Y reminder
    // Set a fixed PLOT?

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

  chkAutoDetect.Enabled := not disable;
  cbCOM.Enabled := not disable;

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
  gGetWifiStatus: tGetWifiStatus;
  gGetVersion: tGetVersion;
  readData: TStringList;
  InStream: TResourceStream;
begin
  InStream := nil;

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
    com.onError := FComPortError;
  end;

  if cbCOM.ItemIndex = -1 then
  begin
    swConnect.IsChecked := false;
    swConnectChange(nil);
    showmessage('No COM Port selected');
  end
  else
  begin
    lblSetupRobotName.Text := '';

    {
      Note - getwifistatus takes to long?
      So it bleeds over the response into getversion
      Need to fix it so getwifistatus compeltes and if its good
      then do the getversion call
    }

    com.open(cbCOM.Items[cbCOM.ItemIndex]);
    r := com.SendCommand(sGetWifiStatus);
    gGetWifiStatus := tGetWifiStatus.Create;
    readData := TStringList.Create;
    readData.Text := r;

    if gGetWifiStatus.ParseText(readData) then
      lblSetupRobotName.Text := gGetWifiStatus.Robot_Name;

    freeandnil(gGetWifiStatus);

    r := com.SendCommand(sGetVersion);

    if r <> '' then
    begin
      gGetVersion := tGetVersion.Create;
      readData.Text := r;

      if gGetVersion.ParseText(readData) then
      begin
        lblRobotModel.Text := gGetVersion.Model.Major;

        if pos('BotVacD3', gGetVersion.Model.Major) > 0 then
          InStream := TResourceStream.Create(HInstance, 'NeatoD3', RT_RCDATA);

        if pos('BotVacD4', gGetVersion.Model.Major) > 0 then
          InStream := TResourceStream.Create(HInstance, 'NeatoD4', RT_RCDATA);

        if pos('BotVacD5', gGetVersion.Model.Major) > 0 then
          InStream := TResourceStream.Create(HInstance, 'NeatoD5', RT_RCDATA);

        if pos('BotVacD6', gGetVersion.Model.Major) > 0 then
          InStream := TResourceStream.Create(HInstance, 'NeatoD6', RT_RCDATA);

        if pos('BotVacD7', gGetVersion.Model.Major) > 0 then
          InStream := TResourceStream.Create(HInstance, 'NeatoD7', RT_RCDATA);

        if pos('BotVacConnected', gGetVersion.Model.Major) > 0 then
          InStream := TResourceStream.Create(HInstance, 'NeatoBotVac', RT_RCDATA);

        if assigned(InStream) then
        begin
          try
            imgRobot.Bitmap.LoadFromStream(InStream);
            imgRobot.Visible := true;
          finally
            InStream.Free;
          end;
        end
        else
        begin
          imgRobot.Visible := false;
        end;
      end;

      freeandnil(gGetVersion);
      pnlSetupDetails.Visible := true;
    end
    else
    begin
      showmessage('No Neato Found on this COM Port');
      swConnect.IsChecked := false;
      chkAutoDetect.Enabled := true;
      cbCOM.Enabled := true;
    end;

  end;

  { tabsMain.ActiveTab := tabSensors;
    tabSensorsOptions.ActiveTab := tabGetCharger;
    tabSensorsOptionsChange(nil);
  }
  ckTestMode.Enabled := true;
end;

procedure TfrmMain.comDisconnect;
begin
  try
    com.Close;
  finally
    timer_StupidFix.Enabled := true;
  end;
end;

procedure TfrmMain.timer_StupidFixTimer(Sender: TObject);
begin
  timer_StupidFix.Enabled := false;
  self.pnlSetupDetails.Visible := false;
end;

procedure TfrmMain.btnDebugTerminalClearClick(Sender: TObject);
begin
  memoDebugTerminal.Text := '';
  edDebugTerminalSend.SetFocus;
end;

procedure TfrmMain.btnDebugTerminalHelpClick(Sender: TObject);
begin
  edDebugTerminalSend.Text := 'HELP';
  btnDebugTerminalSendClick(Sender);
end;

procedure TfrmMain.btnDebugTerminalSendClick(Sender: TObject);
var
  Value: string;
begin

  StopTimers; // JUST IN CASE
  com.com.OnRxChar := FComPortRxChar;

  Value := trim(uppercase(edDebugTerminalSend.Text));

  if Sender = btnDebugTerminalSendHex then
  begin
    Value := uppercase(stringreplace(Value, ' ', '', [rfreplaceall]));
    Value := string(Hex2String(Value));
  end;

  if edDebugTerminalSend.Items.IndexOf(edDebugTerminalSend.Text) = -1 then
    if trim(edDebugTerminalSend.Text) <> '' then

      edDebugTerminalSend.Items.Insert(0, edDebugTerminalSend.Text);

  memoDebugTerminal.Lines.Add('');
  memoDebugTerminal.GoToTextEnd;

  edDebugTerminalSend.Text := '';
  edDebugTerminalSend.SetFocus;

  com.SendCommandOnly(Value);

end;

procedure TfrmMain.btnGetWifiInfoScanClick(Sender: TObject);
begin
  self.tabsMain.Enabled := false;

  aniGetWifiInfo.Enabled := true;
  aniGetWifiInfo.Visible := true;
  btnGetWifiInfoScan.Enabled := false;

  tthread.CreateAnonymousThread(
    procedure
    var
      pReadData: TStringList;
      gGetWifiInfo: tGetWifiInfo;
      r: Boolean;
    begin
      // make sure to have it ready
      com.com.PurgeInput;
      com.com.PurgeOutput;
      com.com.WaitForReadCompletion;

      com.SendCommandOnly('');
      com.SendCommandOnly('');

      pReadData := TStringList.Create;

      pReadData.Text := com.SendCommandAndWaitForValue(sgetwifiinfo, 16000, ^Z, iGetWifiInfoHeaderBreaks);

      gGetWifiInfo := tGetWifiInfo.Create;

      tthread.Synchronize(tthread.CurrentThread,
        procedure
        var
          idx: integer;
        begin
          try

            r := gGetWifiInfo.ParseText(pReadData);
            if r then
            begin
              sgGetWifiInfo.BeginUpdate;
              sgGetWifiInfo.RowCount := 0;
              sgGetWifiInfo.RowCount := 10;
              if gGetWifiInfo.GetWifiInfoItems.Count > 0 then
              begin

                sgGetWifiInfo.RowCount := gGetWifiInfo.GetWifiInfoItems.Count;
                for idx := 0 to gGetWifiInfo.GetWifiInfoItems.Count - 1 do
                begin
                  sgGetWifiInfo.Cells[0, idx] := gGetWifiInfo.GetWifiInfoItems.item[idx].SSID;
                  sgGetWifiInfo.Cells[1, idx] := gGetWifiInfo.GetWifiInfoItems.item[idx].Signal.ToString;
                  sgGetWifiInfo.Cells[2, idx] := gGetWifiInfo.GetWifiInfoItems.item[idx].Frequency.ToString;
                  sgGetWifiInfo.Cells[3, idx] := gGetWifiInfo.GetWifiInfoItems.item[idx].BSSID;
                end;
                sgGetWifiInfo.EndUpdate;
              end;
            end;
          finally
            btnGetWifiInfoScan.Enabled := true;
            aniGetWifiInfo.Enabled := false;
            aniGetWifiInfo.Visible := false;
            tabsMain.Enabled := true;
          end;
        end);

      freeandnil(pReadData);
      freeandnil(gGetWifiInfo);

    end).start;

end;

procedure TfrmMain.btnPlaySoundTestClick(Sender: TObject);
var
  pReadData: TStringList;
  gPlaySound: tPlaySound;
  r: Boolean;
begin
  pReadData := TStringList.Create;

  pReadData.Text := com.SendCommand(sPlaysoundSoundID + ' ' + nbPlaySoundIDValue.Value.ToString);
  gPlaySound := tPlaySound.Create;

  r := gPlaySound.ParseText(pReadData);

  sgPlaysound.RowCount := 0;
  sgPlaysound.RowCount := 1;

  sgPlaysound.Cells[0, 0] := nbPlaySoundIDValue.Value.ToString;

  case r of
    true:
      sgPlaysound.Cells[1, 0] := 'Supported';
    false:
      sgPlaysound.Cells[1, 0] := 'Not Supported';
  end;

  freeandnil(pReadData);
  freeandnil(gPlaySound);
end;

procedure TfrmMain.btnPlaySoundAbortClick(Sender: TObject);
begin
  fPlaySoundAborted := true;
  sgPlaysound.SetFocus;
  btnSoundPlayTestAll.Enabled := true;
  btnPlaySoundTest.Enabled := true;
  btnPlaySoundAbort.Enabled := false;
  nbPlaySoundIDValue.Enabled := true;
end;

procedure TfrmMain.btnSoundPlayTestAllClick(Sender: TObject);
begin
  sgPlaysound.SetFocus;
  fPlaySoundAborted := false;

  btnSoundPlayTestAll.Enabled := false;
  btnPlaySoundTest.Enabled := false;
  btnPlaySoundAbort.Enabled := true;
  nbPlaySoundIDValue.Enabled := false;

  sgPlaysound.RowCount := 0;
  sgPlaysound.RowCount := 64;

  tthread.CreateAnonymousThread(
    procedure
    var
      idx: byte;
      pReadData: TStringList;
      gPlaySound: tPlaySound;
      r: Boolean;
    begin
      sleep(1000);

      pReadData := TStringList.Create;
      for idx := 0 to sSoundIDMax - 1 do
      begin
        if fPlaySoundAborted then
          break;

        pReadData.Text := com.SendCommand(sPlaysoundSoundID + ' ' + idx.ToString);
        gPlaySound := tPlaySound.Create;

        r := gPlaySound.ParseText(pReadData);

        tthread.Synchronize(tthread.CurrentThread,
          procedure
          begin
            sgPlaysound.Cells[0, idx] := idx.ToString;

            case r of
              true:
                sgPlaysound.Cells[1, idx] := 'Supported';
              false:
                sgPlaysound.Cells[1, idx] := 'Not Supported';
            end;
          end);
        sleep(2000);
      end;
      freeandnil(pReadData);
      freeandnil(gPlaySound);

      tthread.Synchronize(tthread.CurrentThread,
        procedure
        begin
          fPlaySoundAborted := true;
          sgPlaysound.SetFocus;
          btnSoundPlayTestAll.Enabled := true;
          btnPlaySoundTest.Enabled := true;
          btnPlaySoundAbort.Enabled := false;
          nbPlaySoundIDValue.Enabled := true;
        end);
    end).start;

end;

procedure TfrmMain.edDebugTerminalSendKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    btnDebugTerminalSendClick(Sender);
    Key := 0;
    KeyChar := #0;
  end;

end;

end.
