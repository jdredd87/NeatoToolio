unit dmSerial.Windows;

interface

uses
  diagnostics,
  FMX.Dialogs,
{$IFDEF win32}
  Winsoft.FireMonkey.FComPort,
{$ENDIF}
{$IFDEF android}
  Winsoft.Android.UsbSerial,
  Winsoft.Android.Usb,
{$ENDIF}
  System.SysUtils, System.Classes, Winsoft.FireMonkey.FComSignal;

type
  TdmSerial = class(TDataModule)
    COM: TFComPort;
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
    Function Open(ComPort: String): boolean;
    procedure Close;

    function SendCommand(cmd: string; const readtimeout: integer = 500; const waitfor: integer = 100):string;

    function SendCommandOnly(cmd: string): String; // Just send command and move on

    function SendCommandAndWaitForValue(cmd: string; const readtimeout: integer = 500;
      const waitfor: string = ''): string;

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

{$IFDEF win32}
  // com := TFComPort.Create(nil);
  // com.onError := FComPort1Error;
  COM.LogFile := 'neato.toolio.log';
{$ENDIF}
{$IFDEF android}
  COM := TUsbSerial.Create;
{$ENDIF}
end;

procedure TdmSerial.DataModuleDestroy(Sender: TObject);
begin
  freeandnil(COM);
end;

procedure TdmSerial.FComPort1Error(ComPort: TFComPort; E: EComError; var Action: TComAction);
begin

  if E.ErrorCode = 22 then // when loose connection
  begin
    fError := E.Message;
    fErrorCode := E.ErrorCode;
    Action := caabort;
    COM.Close;
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
      COM.Close;
    except
    end;
    COM.DeviceName := ComPort;
    COM.Open;
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
    COM.Close;
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
      COM.Timeouts.ReadInterval := 16000;
      COM.WriteAnsiString(ansistring(cmd) + #13);
      COM.WaitForWriteCompletion;
      COM.WaitForReadCompletion;
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
      COM.Timeouts.ReadInterval := readtimeout;
      COM.WriteAnsiString(ansistring(cmd) + #13);
      COM.WaitForWriteCompletion;
      COM.WaitForReadCompletion;

      repeat
        sleep(waitfor);
      until (not COM.ReadPending) or (not COM.Active);

      result := string(COM.ReadAnsiString);

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

function TdmSerial.SendCommandAndWaitForValue(cmd: string; const readtimeout: integer = 500;
const waitfor: string = ''): string;
var
  sw: tstopwatch;
begin

  try
    sw := tstopwatch.Create;

    result := '';

    COM.Timeouts.ReadInterval := readtimeout;
    COM.WriteAnsiString(ansistring(cmd) + #13);

    {
      repeat
      sleep(100);
      until (not com.ReadPending) or (not com.Active);

      result := string(com.ReadAnsiUntil(^Z));

      // result := string(com.ReadAnsiString);
    }

    repeat
      sleep(100);
      if COM.ReadPending then
        result := result + string(COM.ReadAnsiString);
    until (Pos(waitfor, result) > 0) or (sw.ElapsedMilliseconds > readtimeout) or (COM.Active = false);

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
