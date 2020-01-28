unit neato.DXV.SetWallFollower;

interface

uses
  fmx.dialogs, classes, sysutils, neato.Commands, neato.errors, neato.helpers, system.dateutils;

const

  sDescription = 'Enables/Disables wall follower';
  // Command to send
  sSetWallFollower = 'SetWallFollower';
  sUnrecognizedOption = 'Unrecognized Option';
  sEnable = 'Enable';
  sDisable = 'Disable';

  sWallFollowerENABLED = 'WallFollower ENABLED';
  sWallFollowerDISABLED = 'WallFollower DISABLED';

type

  tSetWallFollowerDXV = class(tNeatoBaseCommand)
  strict private
  public
    constructor Create;
    destructor Destroy; override;
    procedure reset; override;
    function parsetext(data: tstringlist): boolean; override;
  end;

implementation

Constructor tSetWallFollowerDXV.Create;
begin
  inherited;
  fCommand := sSetWallFollower;
  fDescription := sDescription;
  reset;
end;

Destructor tSetWallFollowerDXV.Destroy;
begin
  inherited;
end;

procedure tSetWallFollowerDXV.reset;
begin
  inherited;
end;

function tSetWallFollowerDXV.parsetext(data: tstringlist): boolean;
begin
  reset;
  result := false;

  if NOT assigned(data) then
    exit;

  // Simple test to make sure we got data

  data.CaseSensitive := false;

  if (pos(sWallFollowerENABLED, data.text) > 0) or (pos(sWallFollowerDISABLED, data.text) > 0) then
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
end;

end.
