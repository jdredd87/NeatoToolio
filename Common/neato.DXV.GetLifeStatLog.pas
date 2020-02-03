unit neato.DXV.GetLifeStatLog;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors, neato.Helpers;

const

  sDescription = 'Get All Life Stat Logs.';
  sGetLifeStatLog = 'GetLifeStatLog';
  srunID = 'runID';
  sstatID = 'statID';
  scount = 'count';
  sMin = 'Min';
  sMax = 'Max';
  sSum = 'Sum';
  sSumV2 = 'SumV*2';

type

  tGetLifeStatLogDXV = class(tNeatoBaseCommand)
  private
  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: TStringList): boolean; override;
  end;

implementation

Constructor tGetLifeStatLogDXV.Create;
begin
  inherited;
  fCommand := sGetLifeStatLog;
  fDescription := sDescription;
  Reset;
end;

Destructor tGetLifeStatLogDXV.Destroy;
begin
  inherited;
end;

procedure tGetLifeStatLogDXV.Reset;
begin
  inherited;
end;

function tGetLifeStatLogDXV.ParseText(data: TStringList): boolean;
begin
  try
    Reset;

    result := false;

    if NOT assigned(data) then
      exit;

    // just check to see if these 2 fields exist.. first and last
    // if both there, good chance this is good data to go further

    if (pos(srunID, data.Text) > 0) or (pos(sSumV2, data.Text) > 0) then
    begin
      data.Delete(0);
      data.Delete(0);
      // make sure to delete first 2 rows of data
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
