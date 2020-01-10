unit neato.TestLDS;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors, neato.helpers;

const

{


setlds help
SetLDSRate - Set LDS rate in rpm
    Hz - LDS rotational speed in Hz. Usage: SetLDSRate [<Hz>] where (0.0<Hz<=5.0).

Wrong SetLDSRateCmd Hz command.
}


  sTestLDS = 'Testlds CMD HELP';

type

  tTestLDS = class(tNeatoBaseCommand)
  private
    // these look to be big numbers, no decimals
  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: tstringlist): boolean; override;

  end;

implementation

Constructor tTestLDS.Create;
begin
  inherited;
  fCommand := sTestLDS;
  fDescription := 'Get LDS information';
  Reset;
end;

Destructor tTestLDS.Destroy;
begin
  inherited;
end;

procedure tTestLDS.Reset;
begin
  inherited;
end;

function tTestLDS.ParseText(data: tstringlist): boolean;
begin
  Reset;

  result := false;

  if NOT assigned(data) then
    exit;

  // Simple test to make sure we got data

  if 1 = 1 then
  begin
    result := true;
  end
  else
  begin
    fError := nParseTextError;
    result := false;
  end;

end;

end.
