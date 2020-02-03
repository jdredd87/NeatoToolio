unit neato.DXV.SetSchedule;

interface

uses
  fmx.dialogs, classes, sysutils, neato.Commands, neato.errors, neato.helpers, system.dateutils;

const

  // Command to send
  sSetSchedule = 'SetSchedule';
  sUnrecognizedOption = 'Unrecognized Option';
  sON = 'ON';
  sOFF = 'OFF';
  sDescription = 'Modify Cleaning Schedule.';

type

  tSetScheduleDXV = class(tNeatoBaseCommand)
  strict private
  public
    constructor Create;
    destructor Destroy; override;
    procedure reset; override;
    function parsetext(data: tstringlist): boolean; override;
  end;

implementation

Constructor tSetScheduleDXV.Create;
begin
  inherited;
  fCommand := sSetSchedule;
  fDescription := sDescription;
  reset;
end;

Destructor tSetScheduleDXV.Destroy;
begin
  inherited;
end;

procedure tSetScheduleDXV.reset;
begin
  inherited;
end;

function tSetScheduleDXV.parsetext(data: tstringlist): boolean;
begin
  try
    reset;
    result := false;

    if NOT assigned(data) then
      exit;

    // Simple test to make sure we got data

    data.CaseSensitive := false;
    if data.text = '' then
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
