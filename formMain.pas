unit formMain;

interface

uses
{$IFDEF MSWINDOWS}
  Madexcept,
  Winsoft.FireMonkey.FComPort, dmSerial.Windows,
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
  Neato.D.GetVersion,
  Neato.D.GetUsage,
  Neato.D.GetUserSettings,
  Neato.D.GetSensor,
  Neato.D.GetMotors,
  Neato.D.GetWifiInfo,
  Neato.D.GetWifiStatus,
  Neato.D.GetButtons,
  Neato.D.GetCalInfo,
  Neato.D.ClearFiles,

  frame.D.GetCharger,
  frame.D.GetAnalogSensors,
  frame.D.GetDigitalSensors,
  frame.D.GetSensors,
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

  {XV Series}
  Neato.XV.GetCharger,
  Neato.XV.GetWarranty,
  Neato.XV.GetAnalogSensors,
  Neato.XV.GetDigitalSensors,
  Neato.XV.GetErr,
  Neato.XV.GetVersion,
  Neato.XV.GetMotors,
  Neato.XV.GetButtons,
  Neato.XV.GetCalInfo,

  frame.XV.GetCharger,
  frame.XV.GetAnalogSensors,
  frame.XV.GetDigitalSensors,

  {XV and D Series}
  Neato.DXV.Playsound,

  frame.DXV.GetAccel,
  frame.DXV.Playsound,
  frame.DXV.Terminal,

  {Everything else to run this}
  dmCommon,

  Generics.Collections,
  XSuperObject,
  XSuperJson,
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.TabControl, FMX.ListBox,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.ScrollBox, FMX.Memo, FMX.Objects, FMX.Effects,
  System.Math.Vectors, FMX.Controls3D, FMX.Objects3D, FMX.Viewport3D,
  FMX.MaterialSources, FMX.Types3D, FMX.Filter.Effects, System.Rtti, FMX.Grid.Style, FMX.Grid, FMX.ExtCtrls, FMX.Edit,
  FMX.EditBox, FMX.SpinBox, FMX.NumberBox, FMX.ComboEdit, FMX.Colors, FMX.TMSChart;

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
    DGetSensors: TframeDGetSensors;
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

    // XVSeries Frames

    XVGetCharger: TframeXVGetCharger;
    XVGetAnalogSensors: TframeXVGetAnalogSensors;
    XVGetDigitalSensors: TframeXVGetDigitalSensors;

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
        plotLidar.series.Items[0].Points.clear;
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
        timerStarter := DGetSensors.timer_GetData;
      neatoXV:
        timerStarter := nil;
    end;

  if TTabControl(Sender).ActiveTab = tabGetMotors then
    case Neato of
      neatoBotVac:
        timerStarter := DGetMotors.timer_GetData;
      neatoXV:
        timerStarter := nil;
    end;

  if TTabControl(Sender).ActiveTab = tabGetButtons then
    case Neato of
      neatoBotVac:
        timerStarter := DGetButtons.timer_GetData;
      neatoXV:
        timerStarter := nil;
    end;

  if TTabControl(Sender).ActiveTab = tabGetCalInfo then
    case Neato of
      neatoBotVac:
        timerStarter := DGetCalInfo.timer_GetData;
      neatoXV:
        timerStarter := nil;
    end;

  /// ///////////////////////////////////////////////////////////////////////////////////////////////

  if TTabControl(Sender).ActiveTab = tabGetWarranty then
    case Neato of
      neatoBotVac:
        timerStarter := DGetWarranty.timer_GetData;
      neatoXV:
        timerStarter := nil;
    end;

  if TTabControl(Sender).ActiveTab = tabGetErr then
    case Neato of
      neatoBotVac:
        timerStarter := DGetErr.timer_GetData;
      neatoXV:
        timerStarter := nil;
    end;

  if TTabControl(Sender).ActiveTab = tabGetVersion then
    case Neato of
      neatoBotVac:
        timerStarter := DGetVersion.timer_GetData;
      neatoXV:
        timerStarter := nil;
    end;

  if TTabControl(Sender).ActiveTab = tabGetUsage then
    case Neato of
      neatoBotVac:
        timerStarter := DGetUsage.timer_GetData;
      neatoXV:
        timerStarter := nil;
    end;

  if TTabControl(Sender).ActiveTab = tabGetUserSettings then
    case Neato of
      neatoBotVac:
        timerStarter := DGetUserSettings.timer_GetData;
      neatoXV:
        timerStarter := nil;
    end;

  if TTabControl(Sender).ActiveTab = tabPlaySound then
    DXVPlaySound.Check;

  /// ///////////////////////////////////////////////////////////////////////////////////////////////

  if TTabControl(Sender).ActiveTab = tabClearFiles then
    case Neato of
      neatoBotVac:
        DClearFiles.Check;
      neatoXV:
        timerStarter := nil; // does not have
    end;

  if TTabControl(Sender).ActiveTab = tabGetUserSettings then
    case Neato of
      neatoBotVac:
        timerStarter := DGetUserSettings.timer_GetData;
      neatoXV:
        timerStarter := nil;
    end;

  /// ///////////////////////////////////////////////////////////////////////////////////////////////

  if TTabControl(Sender).ActiveTab = tabGetWifiInfo then
    case Neato of
      neatoBotVac:
        DGetWifiInfo.Check;
      neatoXV:
        timerStarter := nil; // does not have
    end;

  if TTabControl(Sender).ActiveTab = tabGetWifiStatus then
    case Neato of
      neatoBotVac:
        timerStarter := DGetWifiStatus.timer_GetData;
      neatoXV:
        timerStarter := nil; // does not have
    end;

  if TTabControl(Sender).ActiveTab = tabDebugTerminal then
    timerStarter := DXVTerminal.timer_GetData;

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
    parent := tabGetCharger;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    fTimerList.Add(timer_GetData);
  end;

  DXVGetAccel := TframeDXVGetAccel.Create(tabGetAccel);
  with DXVGetAccel do
  begin
    Visible := false;
    parent := tabGetAccel;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    fTimerList.Add(timer_GetData);
  end;

  DGetAnalogSensors := TframeDGetAnalogSensors.Create(tabGetAnalogSensors);
  with DGetAnalogSensors do
  begin
    Visible := false;
    parent := tabGetAnalogSensors;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    fTimerList.Add(timer_GetData);
  end;

  DGetDigitalSensors := TframeDGetDigitalSensors.Create(tabGetDigitalSensors);
  with DGetDigitalSensors do
  begin
    Visible := false;
    parent := tabGetDigitalSensors;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    fTimerList.Add(timer_GetData);
  end;

  DGetSensors := TframeDGetSensors.Create(tabGetSensor);
  with DGetSensors do
  begin
    Visible := false;
    parent := tabGetSensor;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    fTimerList.Add(timer_GetData);
  end;

  DGetMotors := TframeDGetMotors.Create(tabGetMotors);
  with DGetMotors do
  begin
    Visible := false;
    parent := tabGetMotors;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    fTimerList.Add(timer_GetData);
  end;

  DGetButtons := TframeDGetButtons.Create(tabGetButtons);
  with DGetButtons do
  begin
    Visible := false;
    parent := tabGetButtons;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    fTimerList.Add(timer_GetData);
  end;

  DGetCalInfo := TframeDGetCalInfo.Create(tabGetCalInfo);
  with DGetCalInfo do
  begin
    Visible := false;
    parent := tabGetCalInfo;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    fTimerList.Add(timer_GetData);
  end;

  DGetWarranty := TframeDGetWarranty.Create(tabGetWarranty);
  with DGetWarranty do
  begin
    Visible := false;
    parent := tabGetWarranty;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    fTimerList.Add(timer_GetData);
  end;

  DGetErr := TframeDGetErr.Create(tabGetErr);
  with DGetErr do
  begin
    Visible := false;
    parent := tabGetErr;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    fTimerList.Add(timer_GetData);
  end;

  DGetVersion := TframeDGetVersion.Create(tabGetVersion);
  with DGetVersion do
  begin
    Visible := false;
    parent := tabGetVersion;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    fTimerList.Add(timer_GetData);
  end;

  DGetUsage := TframeDGetUsage.Create(tabGetUsage);
  with DGetUsage do
  begin
    Visible := false;
    parent := tabGetUsage;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    fTimerList.Add(timer_GetData);
  end;

  DGetUserSettings := TframeDGetUserSettings.Create(tabGetUserSettings);
  with DGetUserSettings do
  begin
    Visible := false;
    parent := tabGetUserSettings;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    fTimerList.Add(timer_GetData);
  end;

  DClearFiles := TframeDClearFiles.Create(tabClearFiles);
  with DClearFiles do
  begin
    Visible := false;
    parent := tabClearFiles;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
  end;

  DGetWifiInfo := TframeDGetWifiInfo.Create(tabGetWifiInfo);
  with DGetWifiInfo do
  begin
    Visible := false;
    parent := tabGetWifiInfo;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
  end;

  DGetWifiStatus := TframeDGetWifiStatus.Create(tabGetWifiStatus);
  with DGetWifiStatus do
  begin
    Visible := false;
    parent := tabGetWifiStatus;
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
    parent := tabGetCharger;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    fTimerList.Add(timer_GetData);
  end;

  XVGetAnalogSensors := TframeXVGetAnalogSensors.Create(tabGetAnalogSensors);
  with XVGetAnalogSensors do
  begin
    Visible := false;
    parent := tabGetAnalogSensors;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    fTimerList.Add(timer_GetData);
  end;

  XVGetDigitalSensors := TframeXVGetDigitalSensors.Create(tabGetDigitalSensors);
  with XVGetDigitalSensors do
  begin
    Visible := false;
    parent := tabGetDigitalSensors;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    fTimerList.Add(timer_GetData);
  end;


  // Create common tabs

  DXVPlaySound := TframeDXVPlaySound.Create(tabPlaySound);
  with DXVPlaySound do
  begin
    parent := tabPlaySound;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
  end;

  DXVTerminal := TframeDXVTerminal.Create(tabDebugTerminal);
  with DXVTerminal do
  begin
    parent := tabDebugTerminal;
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
