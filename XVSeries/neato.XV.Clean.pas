unit neato.XV.Clean;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors, neato.helpers;

const
  sDescription = 'Starts a cleaning by simulating press of start button';
  // Command to send
  sClean = 'Clean';
  sHouse = 'House';
  sSpot = 'Spot';
  sStop = 'Stop';

type

  tCleanXV = class(tNeatoBaseCommand)
  strict private
  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: tstringlist): boolean; override;
  end;

implementation

Constructor tCleanXV.Create;
begin
  inherited;
  fCommand := sClean;
  fDescription := sDescription;
  Reset;
end;

Destructor tCleanXV.Destroy;
begin
  inherited;
end;

procedure tCleanXV.Reset;
begin
  inherited;
end;

function tCleanXV.ParseText(data: tstringlist): boolean;
begin
  Reset;
  result := false;

  if NOT assigned(data) then
    exit;

  data.Text := trim(data.Text);
  data.Text := stringreplace(data.Text, #10, '', [rfreplaceall]);
  data.Text := stringreplace(data.Text, #13, '', [rfreplaceall]);
  data.Text := stringreplace(data.Text, #26, '', [rfreplaceall]);
  data.Text := stringreplace(data.Text, sClean, '', [rfreplaceall, rfignorecase]);
  data.Text := stringreplace(data.Text, sHouse, '', [rfreplaceall, rfignorecase]);
  data.Text := stringreplace(data.Text, sSpot, '', [rfreplaceall, rfignorecase]);
  data.Text := stringreplace(data.Text, sStop, '', [rfreplaceall, rfignorecase]);

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
