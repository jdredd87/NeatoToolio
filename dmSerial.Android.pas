unit dmSerial.Android;

interface

uses
  SyncObjs,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  dmSerial.Base,
  diagnostics,
  FMX.Types,
  FMX.Colors,
  FMX.Dialogs,
  FMX.Memo,
  Winsoft.Android.UsbSer,
  Androidapi.JNIBridge,
  Winsoft.Android.Usb,
  neato.helpers;

type

  TdmSerialAndroid = class(TdmSerialBase)
  private
    fError: String;
    fErrorCode: integer;
    fComFailure: boolean;
    fDataBuffer: String;
    fTimerPermission: TTimer;
    cs: TCriticalSection;
    fdidPermissionRequest: boolean;
    fHasPermission: boolean;
    procedure OnReceivedData(Data: TJavaArray<Byte>);
    procedure fTimerPermissionTimer(Sender: TObject);
  protected
    //
  public
    onError: TNotifyEvent;

    fmemoDebug: tmemo;

    UsbDevices: TArray<JUsbDevice>;
    Serial: TUsbSerial;

    Comport: integer; // this would be the index of devices

    FComSignalRX: TColorBox;
    FComSignalTX: TColorBox;
    FComSignalCNX: TColorBox;

    constructor Create;
    destructor destroy; override;
    Function Open: boolean; override;
    procedure Close; override;
    procedure SetOnRxChar(value: TOnReceivedData);
    function SendCommand(cmd: string; const readtimeout: integer = 5000; const waitfor: integer = 100): string;
      override;
    function SendCommandOnly(cmd: string): String; override; // Just send command and move on
    function SendCommandAndWaitForValue(cmd: string; const readtimeout: integer = 5000; const waitfor: string = '';
      const count: Byte = 1): string; override;

    function ReadString: String; override;
    function active: boolean; override;
    procedure RefreshDevices(var idx: integer; var devicelist: tstringlist);

    procedure PurgeInput;
    procedure PurgeOutput;
    procedure WaitForWriteCompletion;
    procedure WaitForReadCompletion;

    function ReadBuffer: String;

    procedure OnDeviceAttached(Device: JUsbDevice);
    procedure OnDeviceDetached(Device: JUsbDevice);

    property Error: String read fError;
    property ErrorCode: integer read fErrorCode;
    property Failure: boolean read fComFailure;
    property didPermissionRequest: boolean read fdidPermissionRequest;
    property HasPermission: boolean read fHasPermission;
  end;

function ByteArrayToString(Data: TJavaArray<Byte>): string;

implementation

uses Androidapi.Jni.App, Androidapi.Jni.JavaTypes, Androidapi.helpers,
  Androidapi.Jni.Widget, Androidapi.Jni.Os, FMX.helpers.Android, Androidapi.Jni;

Const
  LineBreak = #10#13;

function Androidapi: integer;
begin
  Result := TJBuild_VERSION.JavaClass.SDK_INT;
end;

function ByteArrayToString(Data: TJavaArray<Byte>): string;
begin
  Result := '';
  try
    if (Data <> nil) and (Data.Length > 0) then
      Result := TEncoding.ANSI.GetString(ToByteArray(Data));
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

constructor TdmSerialAndroid.Create;
begin
  inherited;
  cs := TCriticalSection.Create;
  fTimerPermission := TTimer.Create(nil);
  fTimerPermission.OnTimer := fTimerPermissionTimer;

  Serial := TUsbSerial.Create;
  Serial.OnReceivedData := OnReceivedData;
  Serial.OnDeviceAttached := OnDeviceAttached;
  Serial.OnDeviceDetached := OnDeviceDetached;

  FComSignalRX := nil;
  FComSignalTX := nil;
  FComSignalCNX := nil;

  fdidPermissionRequest := false;
  fHasPermission := false;
end;

Destructor TdmSerialAndroid.destroy;
begin
  Serial.Free;
  cs.Free;
  fTimerPermission.Free;
  inherited;
end;

procedure TdmSerialAndroid.OnDeviceAttached(Device: JUsbDevice);
var
  idx: integer;
  devices: tstringlist;
begin
  RefreshDevices(idx, devices);
end;

procedure TdmSerialAndroid.OnDeviceDetached(Device: JUsbDevice);
var
  idx: integer;
  devices: tstringlist;
begin
  RefreshDevices(idx, devices);
end;

procedure TdmSerialAndroid.OnReceivedData(Data: TJavaArray<Byte>);
begin // Idea here is, TCP is a stream of data. So you will get the data possibly in 2 or more chunks.
  // So build up the string and say its ready.
  // Let the other code check to see if its truely ready or not.
  cs.Enter;

  fDataBuffer := fDataBuffer + ByteArrayToString(Data);
  fDataBuffer := stringreplace(fDataBuffer, char($0D) + char($00) + char($0A), char($0D) + char($0A), [rfreplaceall]);

  cs.Leave;

  tthread.CreateAnonymousThread(
    procedure
    begin
      tthread.Queue(nil,
        procedure
        begin
          if assigned(FComSignalRX) then
            FComSignalRX.Color := talphacolorrec.Red;
        end);
      sleep(100);
      tthread.Queue(nil,
        procedure
        begin
          if assigned(FComSignalRX) then
            FComSignalRX.Color := talphacolorrec.Maroon;
        end);
    end).Start;

end;

procedure TdmSerialAndroid.SetOnRxChar(value: TOnReceivedData);
begin
  Serial.OnReceivedData := value;
end;

function TdmSerialAndroid.ReadBuffer: String;
begin
  try
    cs.Enter;
    try
      Result := fDataBuffer;
    except
      on E: Exception do
      begin
      end;
    end;
  finally
    cs.Leave;
  end;
end;

procedure TdmSerialAndroid.RefreshDevices(var idx: integer; var devicelist: tstringlist);
var
  I: integer;
  Device: JUsbDevice;
begin
  idx := -1;
  devicelist := tstringlist.Create;
  UsbDevices := Serial.UsbDevices;
  if UsbDevices <> nil then
    for I := 0 to Length(UsbDevices) - 1 do
    begin
      Device := UsbDevices[I];
      if Androidapi >= 21 then
        devicelist.Add(JStringToString(Device.getManufacturerName) + ' ' + JStringToString(Device.getProductName))
      else
        devicelist.Add(JStringToString(Device.getDeviceName));
      if Device = Serial.UsbDevice then
        idx := I;
    end;
  Close;
end;

Function TdmSerialAndroid.Open: boolean;
var
  Device: JUsbDevice;
begin
  try

    try
      Serial.Disconnect;
    except
    end;

    fError := '';
    fErrorCode := 0;
    fComFailure := false;
    fTimerPermission.Enabled := false;
    fdidPermissionRequest := false;
    fHasPermission := false;

    Result := false;

    Device := UsbDevices[Comport];

    if not Serial.IsSupported(Device) then
      raise Exception.Create('Unsupported device');

    if not Serial.HasPermission(Device) then
    begin
      fHasPermission := false;
      Serial.RequestPermission(Device);
      if not Serial.HasPermission(Device) then
      begin
        fTimerPermission.Enabled := True;
        Exit;
      end;
    end;

    Serial.Connect(Device);
    Serial.Open(false);
    tthread.CreateAnonymousThread(
      procedure
      begin
        sleep(100);
        tthread.Queue(nil,
          procedure
          begin
            if assigned(FComSignalCNX) then
              FComSignalCNX.Color := talphacolorrec.Yellow;
          end);
      end).Start;

    Result := True;
    fHasPermission := True;
  except
    on E: Exception do
    begin
      Result := false;
      fError := E.Message;
      if assigned(onError) then
        onError(Self);
    end;
  end;
end;

procedure TdmSerialAndroid.Close;
begin
  try
    fTimerPermission.Enabled := false;
    Serial.Close;
    Serial.Disconnect;
  except
    on E: Exception do
    begin
      fError := E.Message;
      if assigned(onError) then
      begin
        tthread.Queue(nil, // Queue Syncronize
          procedure
          begin
            if assigned(onError) then
              onError(Self);
          end);
      end;
    end;
  end;

  tthread.CreateAnonymousThread(
    procedure
    begin
      sleep(100);
      tthread.Queue(nil,
        procedure
        begin
          if assigned(FComSignalCNX) then
            FComSignalCNX.Color := talphacolorrec.Olive;
        end);
    end).Start;

end;

procedure TdmSerialAndroid.fTimerPermissionTimer(Sender: TObject);
var
  Device: JUsbDevice;
begin
  fdidPermissionRequest := True;
  Device := UsbDevices[Comport];
  if Serial.HasPermission(Device) then
  begin
    // Open;  // for now do nothing
  end;
end;

function TdmSerialAndroid.SendCommandOnly(cmd: string): String;
var
  sw: tstopwatch;
begin
  tthread.CreateAnonymousThread(
    procedure
    begin
      sleep(100);
      tthread.Queue(nil,
        procedure
        begin
          Self.FComSignalTX.Color := talphacolorrec.Green;
        end);
    end).Start;

  cs.Enter;
  fDataBuffer := '';
  cs.Leave;

  try
    Result := cmd;
    try
      Result := '';

      if assigned(fmemoDebug) then
      begin
        fmemoDebug.BeginUpdate;
        fmemoDebug.Lines.Add(cmd);
        fmemoDebug.Lines.Add('');
        fmemoDebug.Lines.Add('< Call does not check response >');
        fmemoDebug.GoToTextEnd;
        fmemoDebug.EndUpdate;
      end;

      Serial.write(TEncoding.ANSI.GetBytes(cmd + LineBreak), 5000);
      sw := tstopwatch.Create;
      sw.Start;

      repeat // This is blocking so beware
        sleep(0);
      until (pos(^Z, fDataBuffer) > 0) or (sw.ElapsedMilliseconds >= 5000);
      sw.Stop;
      Result := trim(fDataBuffer);

    except
      on E: Exception do
      begin
        tthread.Queue(nil, // Queue Syncronize
          procedure
          begin
            fError := E.Message;
            fErrorCode := E.HelpContext;
            if assigned(onError) then
              onError(Self);
          end);
      end;
    end;
  finally
    tthread.CreateAnonymousThread(
      procedure
      begin
        sleep(100);
        tthread.Queue(nil,
          procedure
          begin
            if assigned(FComSignalTX) then
              FComSignalTX.Color := talphacolorrec.Darkgreen;
          end);
      end).Start;

  end;
end;

function TdmSerialAndroid.SendCommand(cmd: string; const readtimeout: integer = 5000;
const waitfor: integer = 100): string;
var
  sw: tstopwatch;
  readdone: boolean;
  fixData: tstringlist;
  idx: integer;

  breakFound: integer;
  timedout: boolean;
  s: string;
begin

  tthread.CreateAnonymousThread(
    procedure
    begin
      sleep(100);
      tthread.Queue(nil,
        procedure
        begin
          if assigned(FComSignalTX) then
            FComSignalTX.Color := talphacolorrec.Green;
        end);
    end).Start;

  cs.Enter;
  fDataBuffer := '';
  cs.Leave;

  try
    try
      sw := tstopwatch.Create;
      Result := '';

      if assigned(fmemoDebug) then
        fmemoDebug.Lines.Add(cmd);

      Serial.write(TEncoding.ANSI.GetBytes(cmd + #13), readtimeout * 2);

      sw := tstopwatch.Create;
      sw.Start;

      breakFound := 0;
      timedout := false;

      repeat // This is blocking so beware
        cs.Enter;
        breakFound := pos(char(^Z), fDataBuffer);
        cs.Leave;
        timedout := sw.ElapsedMilliseconds >= readtimeout * 2;
      until (breakFound > 0) or (timedout);


      // until (pos(^Z, fDataBuffer) > 0) or (sw.ElapsedMilliseconds >= Serial.readtimeout);

      sw.Stop;

      cs.Enter;
      fixData := tstringlist.Create;
      fixData.Text := trim(fDataBuffer);
      cs.Leave;

      for idx := fixData.count - 1 downto 0 do
        if trim(fixData[idx]) = '' then
          fixData.Delete(idx);

      Result := trim(fixData.Text);

      fixData.Free;
      if pos('Help', Result) > 0 then
        sw.Stop;

      if assigned(fmemoDebug) then
      begin
        fmemoDebug.BeginUpdate;
        fmemoDebug.Lines.Add(Result);
        fmemoDebug.GoToTextEnd;
        fmemoDebug.EndUpdate;
      end;

    except
      on E: Exception do
      begin
        tthread.Queue(nil, // Queue Syncronize
          procedure
          begin
            fError := E.Message;
            fErrorCode := E.HelpContext;
            if assigned(onError) then
              onError(Self);
          end);
      end;
    end;
  finally
    tthread.CreateAnonymousThread(
      procedure
      begin
        sleep(100);
        tthread.Queue(nil,
          procedure
          begin
            if assigned(FComSignalTX) then
              FComSignalTX.Color := talphacolorrec.Darkgreen;
          end);
      end).Start;
  end;
end;

function TdmSerialAndroid.ReadString: String;
var
  rbuffer: TArray<Byte>;
begin
  Serial.Read(rbuffer, 5000);
  Result := TEncoding.ANSI.GetString(rbuffer);
end;

function TdmSerialAndroid.SendCommandAndWaitForValue(cmd: string; const readtimeout: integer = 5000;
const waitfor: string = ''; const count: Byte = 1): string;

var
  sw: tstopwatch;
begin

  tthread.CreateAnonymousThread(
    procedure
    begin
      sleep(100);
      tthread.Queue(nil,
        procedure
        begin
          if assigned(FComSignalTX) then
            FComSignalTX.Color := talphacolorrec.Green;
        end);
    end).Start;
  try

    cs.Enter;
    fDataBuffer := '';
    cs.Leave;

    Result := '';
    if assigned(fmemoDebug) then
      fmemoDebug.Lines.Add(cmd);

    Serial.write(TEncoding.ANSI.GetBytes(cmd + LineBreak), 5000);
    sw := tstopwatch.Create;
    sw.Start;

    repeat // This is blocking so beware
      sleep(0);
    until (OccurrencesOfChar(Result, ^Z) = count) or (sw.ElapsedMilliseconds >= readtimeout);

    sw.Stop;

    Result := trim(fDataBuffer);

    if assigned(fmemoDebug) then
    begin
      fmemoDebug.BeginUpdate;
      fmemoDebug.Lines.Add(Result);
      fmemoDebug.GoToTextEnd;
      fmemoDebug.EndUpdate;
    end;

  except
    on E: Exception do
    begin
      tthread.Queue(nil, // Queue Syncronize
        procedure
        begin
          fError := E.Message;
          fErrorCode := E.HelpContext;
          if assigned(onError) then
            onError(Self);
        end);
    end;
  end;
  tthread.CreateAnonymousThread(
    procedure
    begin
      sleep(100);
      tthread.Queue(nil,
        procedure
        begin
          if assigned(FComSignalTX) then
            FComSignalTX.Color := talphacolorrec.Darkgreen;
        end);
    end).Start;

end;

function TdmSerialAndroid.active: boolean;
begin
  try
    Result := Serial.Connected;
  except
    on E: Exception do
    begin
      Self.fError := E.Message;
      Result := false;
    end;
  end;
end;

procedure TdmSerialAndroid.WaitForWriteCompletion;
begin
  sleep(10);
end;

procedure TdmSerialAndroid.WaitForReadCompletion;
begin
  sleep(10);
end;

procedure TdmSerialAndroid.PurgeInput;
var
  Data: Byte;
  idx: integer;
  r: Byte;
  count: Byte;
begin
  count := 0;
  for idx := 1 to 1024 * 32 do
  begin
    r := Serial.Read(Data, 100);
    if r = 0 then
      inc(count);
    if count >= 16 then
      Exit;
  end;
end;

procedure TdmSerialAndroid.PurgeOutput;
begin
  sleep(10); // no purge command it looks
end;

end.
