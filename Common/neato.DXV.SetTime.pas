unit neato.DXV.SetTime;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors;

const
  // labels of text to look / parse for

  // Command to send
  sDescription = 'Sets the current day, hour, and minute for the scheduler clock.';
  sSetTime = 'SetTime';
  sUnrecognizedOption = 'Unrecognized Option';

type
  tSetTime = class(tNeatoBaseCommand)
  private
  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: tstringlist): boolean; override;
  end;

implementation

Constructor tSetTime.Create;
begin
  inherited;
  fCommand := sSetTime;
  fDescription := sDescription;
  Reset;
end;

Destructor tSetTime.Destroy;
begin
  inherited;
end;

procedure tSetTime.Reset;
begin
  inherited;
end;

function tSetTime.ParseText(data: tstringlist): boolean;
begin
  try
    Reset;

    result := false;

    if NOT assigned(data) then
      exit;

    // Simple test to make sure we got data

    data.text := trim(data.text);
    data.Delete(0);

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
