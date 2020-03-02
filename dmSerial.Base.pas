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
    fErrorCode: integer;
    fComFailure: boolean;
//    fOnRxChar: TNotifyEvent;
  protected
    //procedure SetOnRxChar(value: TNotifyEvent); virtual; Abstract;
  public
    onError: TNotifyEvent;
    fmemoDebug: tmemo;

    constructor Create;
    destructor Destroy; override;

    procedure Close; virtual; abstract;
    function Open: boolean; virtual; abstract;
    function Active: boolean; virtual; abstract;
    function ReadString: String; Virtual; abstract;

    function SendCommand(cmd: string; const readtimeout: integer = 500; const waitfor: integer = 100): string;
      virtual; abstract;
    function SendCommandOnly(cmd: string): String; virtual; abstract;
    function SendCommandAndWaitForValue(cmd: string; const readtimeout: integer = 500; const waitfor: string = '';
      const count: byte = 1): string; virtual; abstract;
    procedure PurgeInput; virtual; abstract;
    procedure PurgeOutput; virtual; abstract;
    procedure WaitForReadCompletion; virtual; abstract;
    procedure WaitForWriteCompletion; virtual; abstract;

    property Error: String read fError;
    property ErrorCode: integer read fErrorCode;
    property Failure: boolean read fComFailure;
    //property OnRXChar: TNotifyEvent read fOnRxChar write SetOnRxChar;

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

end.
