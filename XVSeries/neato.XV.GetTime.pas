unit neato.XV.GetTime;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors, neato.helpers, system.dateutils;

const

  // Command to send
  sGetTime = 'GetTime';
  sDescription = 'Get Current Scheduler Time';

type

  tGetTimeXV = class(tNeatoBaseCommand)
  strict private
    fTime: Ttime;
    fDay: string;
  public
    constructor Create;
    destructor Destroy; override;
    procedure reset; override;
    function parsetext(data: tstringlist): boolean; override;
    property _Time: Ttime read fTime write fTime;
    property Day: String read fDay write fDay;
  end;

implementation

Constructor tGetTimeXV.Create;
begin
  inherited;
  fCommand := sGetTime;
  fDescription := sDescription;
  reset;
end;

Destructor tGetTimeXV.Destroy;
begin
  inherited;
end;

procedure tGetTimeXV.reset;
begin
  fTime := strtotime('00:00:00');
  fDay := 'Sunday?';
  inherited;
end;

function tGetTimeXV.parsetext(data: tstringlist): boolean;
begin
  try
    reset;
    result := false;

    if NOT assigned(data) then
      exit;

    // Simple test to make sure we got data

    data.CaseSensitive := false;
    data.text := stringreplace(data.text, ' ', '=', [rfreplaceall]);
    // looks like no spaces in the data but lets make sure


    if pos(':', data.text) > 0 then
    begin
      data.Delete(0); // delete first row of data, dont need
      fDay := data.Names[0];
      fTime := strtotime(data.ValueFromIndex[0]);
      result := true;
    end
    else
    begin
      fError := strParseTextError;
      result := false;
    end;
  except
    on e: exception do
    begin
      fError := e.Message;
      result := false;
    end;
  end;

end;

end.
