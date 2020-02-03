unit neato.DXV.SetBatteryTest;

interface

uses
  fmx.dialogs, classes, sysutils, neato.Commands, neato.errors, neato.helpers, system.dateutils;

const

  sDescription = 'Sets California Energy Commission 10-CFR-430 Battery Charging System Test mode.';
  // Command to send
  sSetBatteryTest = 'SetBatteryTest';
  sOn = 'On';
  sOff = 'Off';

  sUnrecognizedOption = 'Unrecognized Option';

  // use these as our key words
  sactivated = 'activated';
  sdeactivated = 'deactivated';

type

  tSetBatteryTest = class(tNeatoBaseCommand)
  strict private
    fResponse: string;
  public
    constructor Create;
    destructor Destroy; override;
    procedure reset; override;
    function parsetext(data: tstringlist): boolean; override;
    property Response: String read fResponse write fResponse;
  end;

implementation

Constructor tSetBatteryTest.Create;
begin
  inherited;
  fCommand := sSetBatteryTest;
  fDescription := sDescription;
  reset;
end;

Destructor tSetBatteryTest.Destroy;
begin
  inherited;
end;

procedure tSetBatteryTest.reset;
begin
  fResponse := '';
  inherited;
end;

function tSetBatteryTest.parsetext(data: tstringlist): boolean;
begin
  try
    reset;
    result := false;

    if NOT assigned(data) then
      exit;

    // Simple test to make sure we got data

    data.CaseSensitive := false;

    data.text := trim(data.text);

    fResponse := data.text;

    if (pos(sactivated, data.text) > 0) or (pos(sdeactivated, data.text) > 0) then
    begin
      result := true;
    end
    else if pos(sUnrecognizedOption, data.text) > 0 then
    begin
      data.text := trim(data.text);
      ferror := data.text;
      result := false;
    end
    else
    begin
      ferror := strParseTextError;
      result := false;
    end;
  except
    on e: exception do
    begin
      ferror := e.Message;
      result := false;
    end;
  end;
end;

end.
