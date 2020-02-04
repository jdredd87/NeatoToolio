unit neato.D.SetUsage;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors, neato.helpers;

const
  sDescription = 'Sets usage settings';
  sSetUsage = 'SetUsage';

  sMainBrush = 'MainBrush';
  sMainBrushMsg = 'Set mainbrush life time.';
  sSideBrush = 'SideBrush';
  sSideBrushMsg = 'Set sidebrush life time.';
  sDustbin = 'Dustbin';
  sDustbinMsg = 'Set dustbin life time.';
  sFilter = 'Filter';
  sFilterMsg = 'Set filter life time.';

  sUnrecognizedOption = 'Unrecognized Option';

type

  tSetUsage = class(tNeatoBaseCommand)
  strict private
  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: tstringlist): boolean; override;

  end;

implementation

Constructor tSetUsage.Create;
begin
  inherited;
  fCommand := sSetUsage;
  fDescription := sDescription;
  Reset;
end;

Destructor tSetUsage.Destroy;
begin
  inherited;
end;

procedure tSetUsage.Reset;
begin
  inherited;
end;

function tSetUsage.ParseText(data: tstringlist): boolean;
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

    if pos(sUnrecognizedOption, data.text) > 0 then
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
