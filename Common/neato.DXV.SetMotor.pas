unit neato.DXV.SetMotor;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors, dmCommon;

const
  // labels of text to look / parse for

  sSetMotor = 'SetMotor';

  sLWheelDist = 'LWheelDist';
  sRWheelDist = 'RWheelDist';
  sSpeed = 'Speed';
  sAccel = 'Accel';
  sRPM = 'RPM';
  sBrush = 'Brush';
  sVacuumOn = 'VacuumOn';
  sVacuumOff = 'VacuumOff';
  sVacuumSpeed = 'VacuumSpeed';
  sRWheelDisable = 'RWheelDisable';
  sLWheelDisable = 'LWheelDisable';
  sBrushDisable = 'BrushDisable';
  sRWheelEnable = 'RWheelEnable';
  sLWheelEnable = 'LWheelEnable';
  sBrushEnable = 'BrushEnable';
  sSideBrushEnable = 'SideBrushEnable';
  sSideBrushDisable = 'SideBrushDisable';
  sSideBrushOn = 'SideBrushOn';
  sSideBrushOff = 'SideBrushOff';
  sSideBrushPower = 'SideBrushPower';

  sDescription = 'Sets the specified motor to run in a direction at a requested speed. (TestMode Only)';

  // Command to send

type
  tSetMotor = class(tNeatoBaseCommand)
  private
  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: tstringlist): boolean; override;
  end;

implementation

Constructor tSetMotor.Create;
begin
  inherited;
  fCommand := sSetMotor;
  fDescription := sDescription;
  Reset;
end;

Destructor tSetMotor.Destroy;
begin
  inherited;
end;

procedure tSetMotor.Reset;
begin
  inherited;
end;

function tSetMotor.ParseText(data: tstringlist): boolean;
begin
  try
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
  except
    on e: exception do
    begin
      ferror := e.Message;
      result := false;
    end;
  end;

end;

end.
