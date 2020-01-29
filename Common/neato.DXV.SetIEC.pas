unit neato.DXV.SetIEC;

interface

uses
  fmx.dialogs, classes, sysutils, neato.Commands, neato.errors, neato.helpers, system.dateutils;

const

  sDescription = 'Sets the IEC Cleaning Test parameters';
  sProvideMore = 'Provide or more of the following arguments';
  sInvalid = 'Invalid';

  // Command to send
  sSetIEC = 'SetIEC';
  sHardSpeed = 'HardSpeed';
  sCarpetSpeed = 'CarpetSpeed';
  sDistance = 'Distance';

type

  tSetIECDXV = class(tNeatoBaseCommand)
  strict private
  public
    constructor Create;
    destructor Destroy; override;
    procedure reset; override;
    function parsetext(data: tstringlist): boolean; override;
  end;

implementation

Constructor tSetIECDXV.Create;
begin
  inherited;
  fCommand := sSetIEC;
  fDescription := sDescription;
  reset;
end;

Destructor tSetIECDXV.Destroy;
begin
  inherited;
end;

procedure tSetIECDXV.reset;
begin
  inherited;
end;

function tSetIECDXV.parsetext(data: tstringlist): boolean;
begin
  reset;
  result := false;

  if NOT assigned(data) then
    exit;

  // Simple test to make sure we got data

  data.CaseSensitive := false;
  data.text := trim(data.text);

  if data.Count > 0 then
    data.Delete(0);

  if data.text = '' then
  begin
    result := true;
  end
  else if (pos(sProvideMore, data.text) > 0) or (pos(sInvalid, data.text) > 0) then
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
