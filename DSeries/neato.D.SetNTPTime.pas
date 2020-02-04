unit neato.D.SetNTPTime;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors, neato.helpers;

const
  sDescription = 'Set system time using the NTP servers (WIFI must be up for this to work)';
  sSetNTPTime = 'SetNTPTime';

  sbrief = 'brief';
  sbriefMsg = 'Instruct Astro to get the time from an NTP Server';

  sDone = 'Done.';

  sUnrecognizedOption = 'Unrecognized Option';

type

  tSetNTPTime = class(tNeatoBaseCommand)
  strict private
  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: tstringlist): boolean; override;

  end;

implementation

Constructor tSetNTPTime.Create;
begin
  inherited;
  fCommand := sSetNTPTime;
  fDescription := sDescription;
  Reset;
end;

Destructor tSetNTPTime.Destroy;
begin
  inherited;
end;

procedure tSetNTPTime.Reset;
begin
  inherited;
end;

function tSetNTPTime.ParseText(data: tstringlist): boolean;
begin
  try
    Reset;
    result := false;

    if NOT assigned(data) then
      exit;

    // Simple test to make sure we got data

    data.CaseSensitive := false;

    data.text := trim(data.text);

    if data.count > 0 then
      data.delete(0);

    if pos(sDone,data.text)>0 then
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
