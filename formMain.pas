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

  {XV and D Series Units}
  Neato.DXV.Playsound,
  Neato.DXV.GetAccel,

  frame.DXV.GetAccel,
  frame.DXV.Playsound,
  frame.DXV.Terminal,

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
  FMX.Controls,
  FMX.TabControl,
  FMX.Layouts,
  FMX.Forms, frame.Scripts, FMX.DateTimeCtrls;

type
  TNeatoModels = (neatoXV, neatoBotVac, neatoUnknown);

  TTimerList = TObjectList<TTimer>;

  TfrmMain = class(TForm)
    tabsMain: TTabControl;
    tabSetup: TTabItem;
    tabSensors: TTabItem;
    tabAbout: TTabItem;
    pnlSerialTop: trectangle;
    tabDebug: TTabItem;
    ScaledLayoutMain: TScaledLayout;
    tabSensorsOptions: TTabControl;
    tabGetCharger: TTabItem;
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
    sbResetLIDARMapping: TSpinBox;
    lblResetLIDARmapping: TLabel;
    tabDebuggerOptions: TTabControl;
    tabDebugRawData: TTabItem;
    tabDebugTerminal: TTabItem;
    memoDebug: TMemo;
    tabGetSensor: TTabItem;
    tabPlaySound: TTabItem;
    lblPlaysoundIDX: TLabel;
    tabGetMotors: TTabItem;
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
    tabGetButtons: TTabItem;
    chkTestMode: TCheckBox;
    tabGetCalInfo: TTabItem;
    pnlSetupDetails: trectangle;
    lblSetupRobotName: TLabel;
    lblRobotModel: TLabel;
    imgRobot: TImage;
    tabClearFiles: TTabItem;
    plotLidar: TTMSFMXChart;
    Panel1: trectangle;
    ShadowEffect2: TShadowEffect;
    GlowEffect1: TGlowEffect;
    shadowBotImage: TShadowEffect;
    chkAutoDetect: TCheckBox;
    cbCOM: TComboBox;
    lblSetupComPort: TLabel;
    lblConnect: TLabel;
    swConnect: TCheckBox;
    ShadowEffectmemoAbout: TShadowEffect;
    RectangleaboutMemo: trectangle;
    memoAbout: TMemo;
    pnlDebugTerminalTop: trectangle;
    btnDebugRawDataClear: TButton;
    tabScripts: TTabItem;
    frameScripts: TframeScripts;
    lblNotSupported: TLabel;
    ShadowEffect1: TShadowEffect;
    tabRestoreDefaults: TTabItem;
    tabGetSchedule: TTabItem;
    tabGetTime: TTabItem;

    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure chkAutoDetectChange(Sender: TObject);
    procedure chkTestModeChange(Sender: TObject);

    procedure swConnectChange(Sender: TObject);

    procedure timer_LIDARTimer(Sender: TObject);
    procedure tabControlChange(Sender: TObject);
    procedure tabClickRepaint(Sender: TObject);
    procedure btnDebugRawDataClearClick(Sender: TObject);

  private
    fCurrentTimer: TTimer;
    fLIDARCounter: single;
    fPlaySoundAborted: Boolean;
    fTimerList: TTimerList;

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

    // common tabs
    DXVPlaySound: TframeDXVPlaySound;
    DXVTerminal: TframeDXVTerminal;
    DXVGetAccel: TframeDXVGetAccel;

    Neato: TNeatoModels; // what kind of bot model line

    Procedure StageTabs; // create and place our tabs depending on model
    procedure StopTimers; // STOP all tab timers from running
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
  fCurrentTimer := nil;
  fTimerList := TTimerList.Create(false);

  Neato := neatoUnknown;

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
    if components[idx] is TTabItem then
      TTabItem(components[idx]).OnClick := tabClickRepaint;

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

  self.frameScripts.init;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  if assigned(fTimerList) then
    freeandnil(fTimerList);
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
  //
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  idx: integer;
begin
  StopTimers;
  // make sure all onChange events are gone
  // as it seems these can trigger on closeing

  tabsMain.OnChange := nil;
  tabSensorsOptions.OnChange := nil;
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
  try
    dm.com.Serial.Active := false;
  finally
  end;
  showmessage('COM Issue #' + dm.com.errorcode.ToString + ' : ' + dm.com.Error);

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

procedure TfrmMain.chkTestModeChange(Sender: TObject);
begin
  if assigned(fCurrentTimer) then
    fCurrentTimer.Enabled := false;

  case chkTestMode.IsChecked of
    true:
      dm.com.SendCommand('TestMode ON');
    false:
      dm.com.SendCommand('TestMode OFF');
  end;

  if assigned(fCurrentTimer) then
    fCurrentTimer.Enabled := true;
end;

procedure TfrmMain.tabClickRepaint(Sender: TObject);
begin
  if (Sender) is TTabItem then
    TTabItem(Sender).Repaint;
end;

procedure TfrmMain.timer_LIDARTimer(Sender: TObject);

  procedure LoadCSV(ScanData: String; sg: TStringGrid);
  var
    i, j, position, Count, edt1: integer;
    temp, tempField: string;
    FieldDel: Char;
    Data: TStringList;
  begin
    sg.BeginUpdate;
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
        position := pos(FieldDel, temp);
        tempField := copy(temp, 0, position - 1);

        sg.Cells[j - 1, i] := tempField;

        Delete(temp, 1, length(tempField) + 1);
      end;
    end;
    Data.Free;
    sg.EndUpdate;
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

  begin

    scaleByValue := 0.16; // don't know what to do here
    plotSpotSize := 4; // this guy too

    xPixels := plotLidar.Width / 4;
    // Contain graph width within a quarter of the grid width (actually half because of neg values)
    yPixels := plotLidar.Height / 4;
    // Contain graph height within a quarter of the grid height (actually half because of neg values)
    PlotCenterOrigin := PointF(plotLidar.Width / 2, plotLidar.Height / 2);
    // Calculate the center point of the plot grid

    plotLidar.BeginUpdate;
    sgLIDAR.BeginUpdate;

    if sbResetLIDARMapping.Value > 0 then
    begin
      if round(fLIDARCounter) >= round(sbResetLIDARMapping.Value) then
      begin
        plotLidar.series.Items[0].Points.Clear;
        fLIDARCounter := 0;
      end;
    end;

    for RowIDX := 0 to sgLIDAR.RowCount - 1 do
    begin

      AngleInDegrees := strtoint(sgLIDAR.Cells[0, RowIDX]);
      DistInMM := strtoint(sgLIDAR.Cells[1, RowIDX]);
      intensity := strtoint(sgLIDAR.Cells[2, RowIDX]);
      errorcode := strtoint(sgLIDAR.Cells[3, RowIDX]);

      if errorcode <> 0 then
        continue;

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

      { if newPlotPoint.X > maxx then
        maxx := newPlotPoint.X;

        if newPlotPoint.Y > maxy then
        maxy := newPlotPoint.Y;

        if newPlotPoint.X < minx then
        minx := newPlotPoint.X;

        if newPlotPoint.Y < miny then
        miny := newPlotPoint.Y;

        // caption := 'MaxX = '+maxx.ToString + ' MaxY = '+maxy.ToString + '   ||   MinX = '+minx.ToString+' MinY = '+miny.ToString;

        plotLidar.series.Items[0].AddXYPoint(newPlotPoint.X, newPlotPoint.Y);
      }
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

    end;

    plotLidar.EndUpdate;
    sgLIDAR.EndUpdate;

  end;

var
  pReadData: TStringList;
begin

  if (dm.com.Serial.Active = false) or (tabsToolOptions.ActiveTab <> tabLidar) then
  begin
    timer_LIDAR.Enabled := false;
    exit;
  end;

  pReadData := TStringList.Create; // LIDAR will just use a simple TStringList name/Value pair to work by

  pReadData.Text := trim(dm.com.SendCommand('GetLDSScan'));
  memoDebug.Lines.Text := pReadData.Text;

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

  readData: TStringList;

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
    readData := TStringList.Create;
    dm.com.open(cbCOM.Items[cbCOM.ItemIndex]);

    r := dm.com.SendCommandAndWaitForValue(sGetVersion, 6000, ^Z, 1);

    if pos('BotVac', r) > 0 then
      Neato := neatoBotVac
    else if pos('XV', r) > 0 then
      Neato := neatoXV;

    if (r <> '') and (Neato = neatoBotVac) then
    begin
      r := dm.com.SendCommand(sGetWifiStatus);

      gGetWifiStatusD := tGetWifiStatusD.Create;
      readData.Text := r;

      if gGetWifiStatusD.ParseText(readData) then
        lblSetupRobotName.Text := gGetWifiStatusD.Robot_Name;

      freeandnil(gGetWifiStatusD);

      r := dm.com.SendCommand(sGetVersion);

      gGetVersionD := tGetVersionD.Create;
      readData.Text := r;

      if gGetVersionD.ParseText(readData) then
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

    if (r <> '') and (Neato = neatoXV) then
    begin
      gGetVersionXV := tGetVersionXV.Create;
      readData.Text := r;

      if gGetVersionXV.ParseText(readData) then
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

procedure TfrmMain.StopTimers;
var
  idx: integer;
begin
  if not assigned(fTimerList) then
    exit;

  for idx := 0 to fTimerList.Count - 1 do
    if assigned(fTimerList[idx]) then
      fTimerList[idx].Enabled := false;
end;

procedure TfrmMain.PopulateCOMPorts;
var
  comList: TStringList;
begin
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

  TTabControl(Sender).BeginUpdate;

  timerStarter := nil;
  StopTimers;

  if TTabControl(Sender) = tabsMain then
  begin
    tabSensorsOptions.TabIndex := -1;
    tabsWifiOptions.TabIndex := -1;
    tabsToolOptions.TabIndex := -1;
    tabsInfoOptions.TabIndex := -1;
  end;

  if TTabControl(Sender).ActiveTab = tabGetCharger then
    case Neato of
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
    case Neato of
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
    case Neato of
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
    case Neato of
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
    case Neato of
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
    case Neato of
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
    case Neato of
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
    case Neato of
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
    case Neato of
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
    case Neato of
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
    case Neato of
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
    case Neato of
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



  if TTabControl(Sender).ActiveTab = tabPlaySound then
  begin
    DXVPlaySound.Visible := true;
    DXVPlaySound.Check;
  end;

  /// ///////////////////////////////////////////////////////////////////////////////////////////////

  if TTabControl(Sender).ActiveTab = tabClearFiles then
    case Neato of
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
    case Neato of
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
    case Neato of
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
    case Neato of
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
  // create D Series frames
  DGetCharger := TframeDGetCharger.Create(tabGetCharger);
  with DGetCharger do
  begin
    Visible := false;
    Parent := tabGetCharger;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    fTimerList.Add(timer_GetData);
  end;

  DXVGetAccel := TframeDXVGetAccel.Create(tabGetAccel);
  with DXVGetAccel do
  begin
    Visible := false;
    Parent := tabGetAccel;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    fTimerList.Add(timer_GetData);
  end;

  DGetAnalogSensors := TframeDGetAnalogSensors.Create(tabGetAnalogSensors);
  with DGetAnalogSensors do
  begin
    Visible := false;
    Parent := tabGetAnalogSensors;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    fTimerList.Add(timer_GetData);
  end;

  DGetDigitalSensors := TframeDGetDigitalSensors.Create(tabGetDigitalSensors);
  with DGetDigitalSensors do
  begin
    Visible := false;
    Parent := tabGetDigitalSensors;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    fTimerList.Add(timer_GetData);
  end;

  DGetSensors := TframeDGetSensors.Create(tabGetSensor);
  with DGetSensors do
  begin
    Visible := false;
    Parent := tabGetSensor;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    fTimerList.Add(timer_GetData);
  end;

  DGetMotors := TframeDGetMotors.Create(tabGetMotors);
  with DGetMotors do
  begin
    Visible := false;
    Parent := tabGetMotors;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    fTimerList.Add(timer_GetData);
  end;

  DGetButtons := TframeDGetButtons.Create(tabGetButtons);
  with DGetButtons do
  begin
    Visible := false;
    Parent := tabGetButtons;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    fTimerList.Add(timer_GetData);
  end;

  DGetCalInfo := TframeDGetCalInfo.Create(tabGetCalInfo);
  with DGetCalInfo do
  begin
    Visible := false;
    Parent := tabGetCalInfo;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    fTimerList.Add(timer_GetData);
  end;

  DGetWarranty := TframeDGetWarranty.Create(tabGetWarranty);
  with DGetWarranty do
  begin
    Visible := false;
    Parent := tabGetWarranty;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    fTimerList.Add(timer_GetData);
  end;

  DGetErr := TframeDGetErr.Create(tabGetErr);
  with DGetErr do
  begin
    Visible := false;
    Parent := tabGetErr;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    fTimerList.Add(timer_GetData);
  end;

  DGetVersion := TframeDGetVersion.Create(tabGetVersion);
  with DGetVersion do
  begin
    Visible := false;
    Parent := tabGetVersion;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    fTimerList.Add(timer_GetData);
  end;

  DGetUsage := TframeDGetUsage.Create(tabGetUsage);
  with DGetUsage do
  begin
    Visible := false;
    Parent := tabGetUsage;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    fTimerList.Add(timer_GetData);
  end;

  DGetUserSettings := TframeDGetUserSettings.Create(tabGetUserSettings);
  with DGetUserSettings do
  begin
    Visible := false;
    Parent := tabGetUserSettings;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    fTimerList.Add(timer_GetData);
  end;

  DClearFiles := TframeDClearFiles.Create(tabClearFiles);
  with DClearFiles do
  begin
    Visible := false;
    Parent := tabClearFiles;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
  end;

  DGetWifiInfo := TframeDGetWifiInfo.Create(tabGetWifiInfo);
  with DGetWifiInfo do
  begin
    Visible := false;
    Parent := tabGetWifiInfo;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
  end;

  DGetWifiStatus := TframeDGetWifiStatus.Create(tabGetWifiStatus);
  with DGetWifiStatus do
  begin
    Visible := false;
    Parent := tabGetWifiStatus;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    fTimerList.Add(timer_GetData);
  end;

  // Create XV tabs

  XVGetCharger := TframeXVGetCharger.Create(tabGetCharger);
  with XVGetCharger do
  begin
    Visible := false;
    Parent := tabGetCharger;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    fTimerList.Add(timer_GetData);
  end;

  XVGetAnalogSensors := TframeXVGetAnalogSensors.Create(tabGetAnalogSensors);
  with XVGetAnalogSensors do
  begin
    Visible := false;
    Parent := tabGetAnalogSensors;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    fTimerList.Add(timer_GetData);
  end;

  XVGetDigitalSensors := TframeXVGetDigitalSensors.Create(tabGetDigitalSensors);
  with XVGetDigitalSensors do
  begin
    Visible := false;
    Parent := tabGetDigitalSensors;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    fTimerList.Add(timer_GetData);
  end;

  XVGetMotors := TframeXVGetMotors.Create(tabGetMotors);
  with XVGetMotors do
  begin
    Visible := false;
    Parent := tabGetMotors;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    fTimerList.Add(timer_GetData);
  end;

  XVGetButtons := TframeXVGetButtons.Create(tabGetButtons);
  with XVGetButtons do
  begin
    Visible := false;
    Parent := tabGetButtons;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    fTimerList.Add(timer_GetData);
  end;

  XVGetCalInfo := TframeXVGetCalInfo.Create(tabGetCalInfo);
  with XVGetCalInfo do
  begin
    Visible := false;
    Parent := tabGetCalInfo;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    fTimerList.Add(timer_GetData);
  end;

  XVGetWarranty := TframeXVGetWarranty.Create(tabGetWarranty);
  with XVGetWarranty do
  begin
    Visible := false;
    Parent := tabGetWarranty;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    fTimerList.Add(timer_GetData);
  end;

  XVGetErr := TframeXVGetErr.Create(tabGetErr);
  with XVGetErr do
  begin
    Visible := false;
    Parent := tabGetErr;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    fTimerList.Add(timer_GetData);
  end;

  XVGetVersion := TframeXVGetVersion.Create(tabGetVersion);
  with XVGetVersion do
  begin
    Visible := false;
    Parent := tabGetVersion;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    fTimerList.Add(timer_GetData);
  end;

  XVRestoreDefaults := TframeXVRestoreDefaults.Create(tabRestoreDefaults);
  with XVRestoreDefaults do
  begin
    Visible := false;
    Parent := tabRestoreDefaults;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
  end;

  XVGetSchedule := TframeXVGetSchedule.Create(tabGetSchedule);
  with XVGetSchedule do
  begin
    Visible := false;
    Parent := tabGetSchedule;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
  end;

  XVGetTime := TframeXVGetTime.Create(tabGetTime);
  with XVGetTime do
  begin
    Visible := false;
    Parent := tabGetTime;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
  end;



  // Create common tabs

  DXVPlaySound := TframeDXVPlaySound.Create(tabPlaySound);
  with DXVPlaySound do
  begin
    Parent := tabPlaySound;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
  end;

  DXVTerminal := TframeDXVTerminal.Create(tabDebugTerminal);
  with DXVTerminal do
  begin
    Parent := tabDebugTerminal;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
  end;

end;

procedure TfrmMain.ResetTabs;
begin
  tabsMain.TabIndex := 0;
  tabsMain.SetFocus;
  tabSensorsOptions.TabIndex := -1;
  tabsInfoOptions.TabIndex := -1;
  tabsWifiOptions.TabIndex := -1;
  tabsToolOptions.TabIndex := -1;
  tabDebuggerOptions.TabIndex := -1;
end;

end.
