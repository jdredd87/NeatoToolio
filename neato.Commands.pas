unit neato.Commands;

interface

uses classes;

type

  tNeatoBaseCommand = class // base command
  private
  protected
    fCommand: String; // command text to send
    fDescription: String; // command description
    fError: string;
    fResponse: string;
    function ParseText(data: tstringlist): boolean; virtual; abstract;
  public
    constructor create;
    destructor destroy; override;
    procedure Reset; virtual; // reset error/response/ect
    function execute: boolean;
    property Error: String read fError;
    property Response: String read fResponse;
  end;

implementation

Constructor tNeatoBaseCommand.create;
begin
  inherited;
  Reset;
end;

Destructor tNeatoBaseCommand.destroy;
begin
  Reset;
  inherited;
end;

procedure tNeatoBaseCommand.Reset;
begin
  fError := '';
  fResponse := '';
end;

function tNeatoBaseCommand.execute: boolean;
begin
  result := false;
  Reset;
end;

end.
