unit neato.DXV.SetFuelGauge;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors;

const
  // labels of text to look / parse for

  sDescription = 'Set Fuel Gauge Level.';

  // Command to send

  sSetFuelGauge = 'SetFuelGauge';
  sSetFuelGaugeTo = 'Set Fuel Gauge to';
  sInvalidFuelgauge = 'Invalid Fuel Gauge percent specified';

type

  tSetFuelGauge = class(tNeatoBaseCommand)
  private
  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: tstringlist): boolean; override;
  end;

implementation

Constructor tSetFuelGauge.Create;
begin
  inherited;
  fCommand := sSetFuelGauge;
  fDescription := sDescription;
  Reset;
end;

Destructor tSetFuelGauge.Destroy;
begin
  inherited;
end;

procedure tSetFuelGauge.Reset;
begin
  inherited;
end;

function tSetFuelGauge.ParseText(data: tstringlist): boolean;
begin
  Reset;

  result := false;

  if NOT assigned(data) then
    exit;

  // Simple test to make sure we got data

  if pos(sSetFuelGaugeTo, data.Text) > 0 then
  begin
    result := true;
  end
  else if pos(sInvalidFuelgauge, data.Text) > 0 then
  begin
    data.Text := trim(data.Text);
    ferror := data.Text;
    result := false;
  end
  else
  begin

    ferror := strParseTextError;
    result := false;
  end;
end;

end.
