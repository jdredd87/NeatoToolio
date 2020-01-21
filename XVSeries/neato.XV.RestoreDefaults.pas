unit neato.XV.RestoreDefaults;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors, neato.helpers;

const

  // Command to send
  sRestoreDefaults = 'RestoreDefaults';

type

  tRestoreDefaults = class(tNeatoBaseCommand)
  strict private
  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: tstringlist): boolean; override;
  end;

implementation

Constructor tRestoreDefaults.Create;
begin
  inherited;
  fCommand := sRestoreDefaults;
  fDescription := 'Restore user settings to default.';
  Reset;
end;

Destructor tRestoreDefaults.Destroy;
begin
  inherited;
end;

procedure tRestoreDefaults.Reset;
begin
  inherited;
end;

function tRestoreDefaults.ParseText(data: tstringlist): boolean;
begin
  Reset;
  result := false;

  if NOT assigned(data) then
    exit;

  data.Text := stringreplace(data.Text, sRestoreDefaults, '', [rfreplaceall]);
  data.Text.Replace(#10, #0);
  data.Text.Replace(#13, #0);
  data.Text.Replace(#26, #0);

  if trim(data.Text) = '' then
  begin
    result := true;
  end
  else
  begin
    fError := strParseTextError;
    result := false;
  end;

end;

end.
