{

  Base object to define a basic layout for communications.

}

unit dmSerial.Base;

interface

uses
  diagnostics,
  FMX.Dialogs,
  FMX.Memo,
  system.classes,
  system.SysUtils;

type
  TdmSerialBase = class(tobject)
  private
    fError: String;
    fErrorCode: longint;
    fComFailure: boolean;
    fOnRxChar: TNotifyEvent;
  protected
    procedure SetOnRxChar(value:TNotifyEvent); virtual; Abstract;
  public
    onError: TNotifyEvent;
    fmemoDebug: tmemo;

    constructor Create;
    destructor destroy; override;

    procedure Close; virtual;
    function Open: boolean; virtual;
    function Active: boolean; virtual;

    function ReadString: String; Virtual;

    function SendCommand(cmd: string; const readtimeout: integer = 500; const waitfor: integer = 100): string; virtual;
    function SendCommandOnly(cmd: string): String; virtual;
    function SendCommandAndWaitForValue(cmd: string; const readtimeout: integer = 500; const waitfor: string = '';
      const count: byte = 1): string; virtual;
    procedure PurgeInput;
    procedure PurgeOutput;
    procedure WaitForReadCompletion;
    procedure WaitForWriteCompletion;

    property Error: String read fError;
    property ErrorCode: longint read fErrorCode;
    property Failure: boolean read fComFailure;
    property OnRXChar: TNotifyEvent read fOnRxChar write SetOnRxChar;

  end;

implementation

constructor TdmSerialBase.Create;
begin
  inherited;
end;

Destructor TdmSerialBase.destroy;
begin
  inherited;
end;

Function TdmSerialBase.Open: boolean;
begin
end;

procedure TdmSerialBase.Close;
begin
end;

function TdmSerialBase.ReadString: String;
begin
end;

function TdmSerialBase.SendCommandOnly(cmd: string): String;
begin
end;

function TdmSerialBase.SendCommand(cmd: string; const readtimeout: integer = 500; const waitfor: integer = 100): string;
begin
end;

function TdmSerialBase.SendCommandAndWaitForValue(cmd: string; const readtimeout: integer = 500;
  const waitfor: string = ''; const count: byte = 1): string;
begin
end;

function TdmSerialBase.Active: boolean;
begin
end;

procedure TdmSerialBase.PurgeInput;
begin
end;

procedure TdmSerialBase.PurgeOutput;
begin
end;

procedure TdmSerialBase.WaitForReadCompletion;
begin
end;

procedure TdmSerialBase.WaitForWriteCompletion;
begin
end;

end.
