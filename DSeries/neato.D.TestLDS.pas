unit neato.D.TestLDS;

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

  tTestLDSD = class(tNeatoBaseCommand)
  private
    // these look to be big numbers, no decimals
  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: tstringlist): boolean; override;

  end;

implementation

Constructor tTestLDSD.Create;
begin
  inherited;
  fCommand := sTestLDS;
  fDescription := 'Get LDS information';
  Reset;
end;

Destructor tTestLDSD.Destroy;
begin
  inherited;
end;

procedure tTestLDSD.Reset;
begin
  inherited;
end;

function tTestLDSD.ParseText(data: tstringlist): boolean;
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
    fError := strParseTextError;
    result := false;
  end;

end;

end.
