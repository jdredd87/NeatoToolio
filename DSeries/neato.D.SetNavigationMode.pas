unit neato.D.SetNavigationMode;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors, neato.helpers;

const
  sDescription = 'Sets the Navigation Mode';
  sSetNavigationMode = 'SetNavigationMode';

  sNormal = 'Normal';
  sNormalMsg = 'Normal Cleaning';

  sGentle = 'Gentle';
  sGentleMsg = 'Gentle Cleaning';

  sDeep = 'Deep';
  sDeepMsg = 'Deep Cleaning';

  sQuick = 'Quick';
  sQuickMsg = 'Quick Cleaning';


  sNavigationMode = 'NavigationMode = ';
  sUnrecognizedOption = 'Unrecognized Option';

type

  tSetNavigationMode = class(tNeatoBaseCommand)
  strict private
  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: tstringlist): boolean; override;

  end;

implementation

Constructor tSetNavigationMode.Create;
begin
  inherited;
  fCommand := sSetNavigationMode;
  fDescription := sDescription;
  Reset;
end;

Destructor tSetNavigationMode.Destroy;
begin
  inherited;
end;

procedure tSetNavigationMode.Reset;
begin
  inherited;
end;

function tSetNavigationMode.ParseText(data: tstringlist): boolean;
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

    if pos(sNavigationMode, data.text) > 0 then
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
