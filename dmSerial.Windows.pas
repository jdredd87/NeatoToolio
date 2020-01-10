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
    function SendCommand(cmd: string): string;
    property Error: String read fError;
    property ErrorCode : Longint read fErrorCode;
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
    fErrorCode := e.ErrorCode;
    Action := caabort;
    com.Close;
    if assigned(onError) then
      onError(self);
  end;

end;

Function TdmSerial.Open(ComPort: String): boolean;

begin
  try
    ferror := '';
    ferrorcode := 0;
    fcomfailure := false;
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

function TdmSerial.SendCommand(cmd: string): string;
begin
  result := '';
  com.WriteAnsiString(ansistring(cmd) + #13);
  com.Timeouts.ReadInterval := 500;

  repeat
    sleep(100);
  until (not com.ReadPending);

  result := string(com.ReadAnsiString);
end;

end.
