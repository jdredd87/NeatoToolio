unit dmSerial.Windows;

interface

uses
  diagnostics,
  FMX.Dialogs,
  FMX.Memo,
  system.classes,
  Winsoft.FireMonkey.FComPort,
  Winsoft.FireMonkey.FComSignal,

{$IFDEF android}
  Winsoft.Android.UsbSerial,
  Winsoft.Android.Usb,
{$ENDIF}
  neato.helpers,
  system.SysUtils;

type
  TdmSerial = class(TDataModule)
    Serial: TFComPort;
    FComSignalRX: TFComSignal;
    FComSignalCTS: TFComSignal;
    FComSignalRing: TFComSignal;
    FComSignalBreak: TFComSignal;
    FComSignalRLSD: TFComSignal;
    FComSignalDSR: TFComSignal;
    FComSignalTX: TFComSignal;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure FComPort1Error(ComPort: TFComPort; E: EComError; var Action: TComAction);
  private
    fError: String;
    fErrorCode: longint;
    fComFailure: boolean;

  public
{$IFDEF win32}
    // com: TFComPort;
{$ENDIF}
{$IFDEF android}
    COM: TUsbSerial;
{$ENDIF}
    onError: TNotifyEvent;
    fmemoDebug: tmemo;
    Function Open(ComPort: String): boolean;
    procedure Close;

    function SendCommand(cmd: string; const readtimeout: integer = 500; const waitfor: integer = 100): string;

    function SendCommandOnly(cmd: string): String; // Just send command and move on

    function SendCommandAndWaitForValue(cmd: string; const readtimeout: integer = 500; const waitfor: string = '';
      const count: byte = 1): string;

    property Error: String read fError;
    property ErrorCode: longint read fErrorCode;
    property Failure: boolean read fComFailure;

  end;

var
  dmSerial: TdmSerial;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

procedure TdmSerial.DataModuleCreate(Sender: TObject);
begin
  // for now only going to worry only about windows

  // but android did kind of work

{$IFDEF android}
  COM := TUsbSerial.Create;
{$ENDIF}
end;

procedure TdmSerial.DataModuleDestroy(Sender: TObject);
begin
  freeandnil(Serial);
end;

procedure TdmSerial.FComPort1Error(ComPort: TFComPort; E: EComError; var Action: TComAction);
begin

  if E.ErrorCode = 22 then // when loose connection
  begin
    fError := E.Message;
    fErrorCode := E.ErrorCode;
    Action := caabort;
    Serial.Close;
    if assigned(onError) then
      onError(self);
  end;

end;

Function TdmSerial.Open(ComPort: String): boolean;

begin
  try
    fError := '';
    fErrorCode := 0;
    fComFailure := false;
    try
      Serial.Close;
    except
    end;
    Serial.DeviceName := '\\.\' + ComPort;
    Serial.Active := true;
    result := true;
  except
    on E: Exception do
    begin
      result := false;
      fError := E.Message;
      if assigned(onError) then
        onError(self);
    end;
  end;
end;

procedure TdmSerial.Close;
begin
  try
    Serial.Close;
  except
    on E: Exception do
    begin
      fError := E.Message;
      if assigned(onError) then
      begin
        tthread.Queue(nil, // Queue Syncronize
          procedure
          begin
            onError(self);
          end);
      end;
    end;
  end;
end;

function TdmSerial.SendCommandOnly(cmd: string): String;
begin
  try
    result := cmd;
    try
      result := '';
      Serial.Timeouts.ReadInterval := 16000;

      if assigned(fmemoDebug) then
      begin
        fmemoDebug.BeginUpdate;
        fmemoDebug.Lines.Add(cmd);
        fmemoDebug.Lines.Add('');
        fmemoDebug.Lines.Add('< Call does not check response >');
        fmemoDebug.GoToTextEnd;
        fmemoDebug.EndUpdate;
      end;

      Serial.WriteAnsiString(ansistring(cmd) + #13);
      Serial.WaitForWriteCompletion;
      Serial.WaitForReadCompletion;
    except
      on E: Exception do
      begin
        tthread.Queue(nil, // Queue Syncronize
          procedure
          begin
            fError := E.Message;
            fErrorCode := E.HelpContext;
            onError(self);
          end);
      end;
    end;
  finally
    //
  end;
end;

function TdmSerial.SendCommand(cmd: string; const readtimeout: integer = 500; const waitfor: integer = 100): string;
var
  sw: tstopwatch;
begin
  try
    try
      sw := tstopwatch.Create;
      result := '';
      Serial.Timeouts.ReadInterval := readtimeout;

      if assigned(fmemoDebug) then
        fmemoDebug.Lines.Add(cmd);

      Serial.WriteAnsiString(ansistring(cmd) + #13);
      Serial.WaitForWriteCompletion;
      Serial.WaitForReadCompletion;

      repeat
        sleep(waitfor);
      until (not Serial.ReadPending) or (not Serial.Active);

      result := string(Serial.ReadAnsiString);

      if assigned(fmemoDebug) then
      begin
        fmemoDebug.BeginUpdate;
        fmemoDebug.Lines.Add(result);
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
            onError(self);
          end);
      end;
    end;
  finally
    //
  end;
end;

function TdmSerial.SendCommandAndWaitForValue(cmd: string; const readtimeout: integer = 500; const waitfor: string = '';
const count: byte = 1): string;

var
  timeout: boolean;
  sw: tstopwatch;
begin
  try
    result := '';
    if assigned(fmemoDebug) then
      fmemoDebug.Lines.Add(cmd);

    Serial.WriteAnsiString(ansistring(cmd) + #13);
    Serial.Timeouts.ReadInterval := readtimeout;
    timeout := false;

    sw := tstopwatch.Create;
    sw.Start;
    repeat
      result := result + Serial.ReadAnsiString;
      if sw.ElapsedMilliseconds > readtimeout then
        timeout := true;
    until (not Serial.Active) or (OccurrencesOfChar(result, ^z) = count) or (timeout);

    result := trim(result);

    if assigned(fmemoDebug) then
    begin
      fmemoDebug.BeginUpdate;
      fmemoDebug.Lines.Add(result);
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
          onError(self);
        end);
    end;
  end;
end;

end.
