unit dmSerial.Windows;

interface

uses
  FMX.Dialogs,
{$IFDEF win32}
  Winsoft.FireMonkey.FComPort,
{$ENDIF}
{$IFDEF android}
  Winsoft.Android.UsbSerial,
  Winsoft.Android.Usb,
{$ENDIF}
  System.SysUtils, System.Classes;

type
  TdmSerial = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure FComPort1Error(ComPort: TFComPort; E: EComError; var Action: TComAction);
  private
    fError: String;
    fErrorCode: longint;
    fComFailure: boolean;
  public
{$IFDEF win32}
    com: TFComPort;
{$ENDIF}
{$IFDEF android}
    com: TUsbSerial;
{$ENDIF}
    onError: TNotifyEvent;
    Function Open(ComPort: String): boolean;
    procedure Close;

    function SendCommand(cmd: string; const readtimeout: integer = 500; const waitfor: integer = 100): string;
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
{$IFDEF win32}
  com := TFComPort.Create(nil);
  com.onError := FComPort1Error;
  com.LogFile := 'neato.toolio.log';
{$ENDIF}
{$IFDEF android}
  com := TUsbSerial.Create;
{$ENDIF}
end;

procedure TdmSerial.DataModuleDestroy(Sender: TObject);
begin
  freeandnil(com);
end;

procedure TdmSerial.FComPort1Error(ComPort: TFComPort; E: EComError; var Action: TComAction);
begin

  if E.ErrorCode = 22 then // when loose connection
  begin
    fError := E.Message;
    fErrorCode := E.ErrorCode;
    Action := caabort;
    com.Close;
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
      com.Close;
    except
    end;
    com.DeviceName := ComPort;
    com.Open;
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
    com.Close;
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

function TdmSerial.SendCommand(cmd: string; const readtimeout: integer = 500; const waitfor: integer = 100): string;
begin

  try
    result := '';
    com.WriteAnsiString(ansistring(cmd) + #13);
    com.Timeouts.ReadInterval := readtimeout;

    repeat
      sleep(waitfor);
    until (not com.ReadPending) or (not com.Active);

    result := string(com.ReadAnsiString);

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

function TdmSerial.SendCommandAndWaitForValue(cmd: string; const readtimeout: integer = 500;
const waitfor: string = ''): string;
begin

  try
    result := '';
    com.WriteAnsiString(ansistring(cmd) + #13);
    com.Timeouts.ReadInterval := readtimeout;

    repeat
      sleep(100);
    until (not com.ReadPending) or (not com.Active);

    result := string(com.ReadAnsiUntil(^z));

    // result := string(com.ReadAnsiString);

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
