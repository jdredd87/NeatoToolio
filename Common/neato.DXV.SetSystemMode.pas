unit neato.DXV.SetSystemMode;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors, dmCommon;

const
  // labels of text to look / parse for

  // Command to send

  sSetSystemMode = 'SetSystemMode';
  sShutdown = 'Shutdown';
  sHibernate = 'Hibernate';
  sStandby = 'Standby';
  sPowerCycle = 'PowerCycle';

  sShutDownMsg = 'Shut down the robot.';
  sHibernateMsg = 'Start hibernate operation.';
  sStandbyMsg = 'Start standby operation.';
  sPowerCycleMsg = 'Power cycles the entire system.';

type
  tSetSystemMode = class(tNeatoBaseCommand)
  private
  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: tstringlist): boolean; override;
  end;

implementation

Constructor tSetSystemMode.Create;
begin
  inherited;
  fCommand := sSetSystemMode;
  fDescription := 'Set the operation mode of the robot. (TestMode Only)';
  Reset;
end;

Destructor tSetSystemMode.Destroy;
begin
  inherited;
end;

procedure tSetSystemMode.Reset;
begin
  inherited;
end;

function tSetSystemMode.ParseText(data: tstringlist): boolean;
begin
  Reset;

  result := false;

  if NOT assigned(data) then
    exit;

  // Simple test to make sure we got data

  data.text := trim(data.text);

  if 1 = 1 then
  begin
    result := true;
  end
  else if pos('', data.text) > 0 then
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
