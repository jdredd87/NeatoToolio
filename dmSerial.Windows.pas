unit dmSerial.Windows;

interface

uses
  dmSerial.Base,
  diagnostics,
  FMX.Dialogs,
  FMX.Memo,
  FMX.Colors,
  system.classes,
  Winsoft.FireMonkey.FComPort,
  Winsoft.FireMonkey.FComSignal,
  system.UITypes,
  neato.helpers,
  system.SysUtils;

type
  TdmSerialWindows = class(TdmSerialBase)
  private
    fError: String;
    fErrorCode: integer;
    fComFailure: boolean;
    procedure FComPort1Error(ComPort: TFComPort; E: EComError; var Action: TComAction);
  protected
    procedure onAfterClose(ComPort: TFComPort);
    procedure onAfterOpen(ComPort: TFComPort);
  public
    FComSignalCNX: TColorBox;
    onError: TNotifyEvent;
    fmemoDebug: tmemo;
    Serial: TFComPort;
    FComSignalRX: TFComSignal;
    FComSignalTX: TFComSignal;
    ComPort: String;
    constructor Create;
    destructor Destroy; override;
    Function Open: boolean; override;
    procedure Close; override;
    procedure SetOnRxChar(value: TNotifyEvent);
    function SendCommand(cmd: string; const readtimeout: integer = 500; const waitfor: integer = 100): string; override;
    function SendCommandOnly(cmd: string): String; override; // Just send command and move on
    function SendCommandAndWaitForValue(cmd: string; const readtimeout: integer = 500; const waitfor: string = '';
      const count: byte = 1): string; override;

    function ReadString: String; override;
    function Active: boolean; override;

    procedure PurgeInput; override;
    procedure PurgeOutput; override;
    procedure WaitForReadCompletion; override;
    procedure WaitForWriteCompletion; override;

    property Error: String read fError;
    property ErrorCode: integer read fErrorCode;
    property Failure: boolean read fComFailure;
  end;

implementation

constructor TdmSerialWindows.Create;
begin
  inherited;
  Serial := TFComPort.Create(nil);
  Serial.BeforeClose := onAfterClose;
  Serial.BeforeOpen := onAfterOpen;

  FComSignalCNX := nil;

  FComSignalRX := TFComSignal.Create(Serial);
  FComSignalRX.ColorOff := talphacolorrec.Maroon;
  FComSignalRX.ColorOn := talphacolorrec.Red;
  FComSignalRX.Signal := tsignal.siRxChar;

  FComSignalTX := TFComSignal.Create(Serial);
  FComSignalTX.ColorOff := talphacolorrec.Darkgreen;
  FComSignalTX.ColorOn := talphacolorrec.Green;
  FComSignalTX.Signal := tsignal.siTxChar;

  FComSignalRX.ComPort := Serial;
  FComSignalTX.ComPort := Serial;
end;

Destructor TdmSerialWindows.Destroy;
begin
  FComSignalRX.Free;
  FComSignalTX.Free;
  Serial.Free;
  inherited;
end;

procedure TdmSerialWindows.onAfterClose(ComPort: TFComPort);
begin
  if assigned(FComSignalCNX) then
    FComSignalCNX.Color := talphacolorrec.Olive;
end;

procedure TdmSerialWindows.onAfterOpen(ComPort: TFComPort);
begin
  if assigned(FComSignalCNX) then
    FComSignalCNX.Color := talphacolorrec.Yellow;
end;

procedure TdmSerialWindows.SetOnRxChar(value: TNotifyEvent);
begin
  Serial.OnRxChar := value;
end;

procedure TdmSerialWindows.FComPort1Error(ComPort: TFComPort; E: EComError; var Action: TComAction);
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

Function TdmSerialWindows.Open: boolean;

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

procedure TdmSerialWindows.Close;
begin
  try
    Serial.Close;
  except
    on E: Exception do
    begin
      fError := E.Message;
      if assigned(onError) then
      begin
        tthread.Synchronize(tthread.currentthread, // Queue Syncronize
          procedure
          begin
            onError(self);
          end);
      end;
    end;
  end;
end;

function TdmSerialWindows.SendCommandOnly(cmd: string): String;
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

      if Serial.Active then
      begin
        Serial.WriteAnsiString(AnsiString(cmd) + #13);
        Serial.WaitForWriteCompletion;
        Serial.WaitForReadCompletion;
      end;
    except
      on E: Exception do
      begin
        tthread.Synchronize(tthread.currentthread, // Queue Syncronize
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

function TdmSerialWindows.SendCommand(cmd: string; const readtimeout: integer = 500;
const waitfor: integer = 100): string;
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

      if Serial.Active then
      begin

        Serial.WriteAnsiString(AnsiString(cmd) + #13);
        Serial.WaitForWriteCompletion;
        Serial.WaitForReadCompletion;
      end;

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
        tthread.Synchronize(tthread.currentthread, // Queue Syncronize
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

function TdmSerialWindows.ReadString: String;
begin
  result := String(Serial.ReadAnsiString);
end;

function TdmSerialWindows.SendCommandAndWaitForValue(cmd: string; const readtimeout: integer = 500;
const waitfor: string = ''; const count: byte = 1): string;

var
  timeout: boolean;
  sw: tstopwatch;
begin
  try
    result := '';
    if assigned(fmemoDebug) then
      fmemoDebug.Lines.Add(cmd);

    if Serial.Active then
      Serial.WriteAnsiString(AnsiString(cmd) + #13);

    Serial.Timeouts.ReadInterval := readtimeout;
    timeout := false;

    sw := tstopwatch.Create;
    sw.Start;
    repeat
      result := result + String(Serial.ReadAnsiString);
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
      tthread.Synchronize(tthread.currentthread, // Queue Syncronize
        procedure
        begin
          fError := E.Message;
          fErrorCode := E.HelpContext;
          onError(self);
        end);
    end;
  end;
end;

function TdmSerialWindows.Active: boolean;
begin
  result := Serial.Active;
end;

procedure TdmSerialWindows.PurgeInput;
begin
  Serial.PurgeInput;
end;

procedure TdmSerialWindows.PurgeOutput;
begin
  Serial.PurgeOutput;
end;

procedure TdmSerialWindows.WaitForReadCompletion;
begin
  Serial.WaitForReadCompletion;
end;

procedure TdmSerialWindows.WaitForWriteCompletion;
begin
  Serial.WaitForWriteCompletion;
end;

end.
