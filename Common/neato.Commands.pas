unit neato.Commands;

interface

uses classes;

type

  tNeatoBaseCommand = class // base command
  public
    fDescription: String; // command description
    fError: string; // error message
    fCommand: String; // Command to send, to easily grab

    constructor Create;
    destructor Destroy; override;

    procedure Reset; virtual; // reset error/response/ect
    procedure check; virtual; abstract; // check call before doing anything

    function execute: boolean;
    function ParseText(data: tstringlist): boolean; virtual; abstract;

    property Error: String read fError;
    property Command: String read fCommand write fCommand;
    property Description: string read fDescription write fDescription;
  end;

implementation

Constructor tNeatoBaseCommand.Create;
begin
  inherited;
  Reset;
end;

Destructor tNeatoBaseCommand.Destroy;
begin
  Reset;
  inherited;
end;

procedure tNeatoBaseCommand.Reset;
begin
  fError := '';
end;

function tNeatoBaseCommand.execute: boolean;
begin
  result := false;
  Reset;
end;

end.

