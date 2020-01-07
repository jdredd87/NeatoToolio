unit dmSerial.Windows;

interface

uses
  System.SysUtils, System.Classes, Winsoft.FireMonkey.FComPort;

type
  TdmSerial = class(TDataModule)
    com: TFComPort;
  private
    fError: String;
  public
    onError: TNotifyEvent;
    Function Open(comport: String): boolean;
    procedure Close;
    function SendCommand(cmd: string): string;
    property Error: String read fError;
  end;

var
  dmSerial: TdmSerial;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

Function TdmSerial.Open(comport: String): boolean;

begin
  try
    try
      com.Close;
    except
    end;

    com.DeviceName := comport;
    com.Open;
    result := true;
  except
    on e: Exception do
    begin
      result := false;
      fError := e.Message;
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
    on e: Exception do
    begin
      fError := e.Message;
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
