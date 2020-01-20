unit neato.XV.GetWarranty;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors, neato.helpers;

const
  // labels of text to look / parse for
  sLabel = 'Item';
  sValue = 'Value';
  sCumulativeCleaningTimeInSecs = 'CumulativeCleaningTimeInSecs';
  sCumulativeBatteryCycles = 'CumulativeBatteryCycles';
  sValidationCode = 'ValidationCode';
  // Command to send

  sGetWarranty = 'GetWarranty';

type

  tGetWarrantyXV = class(tNeatoBaseCommand)
  private
    fCumulativeCleaningTimeInSecs: String; // hex
    fCumulativeBatteryCycles: String; // hex
    fValidationCode: String; // hex

    function CumulativeCleaningTimeInSecs_asHours: double;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: tstringlist): boolean; override;

    property CumulativeCleaningTimeInSecs: string read fCumulativeCleaningTimeInSecs;
    property CumulativeBatteryCycles: string read fCumulativeBatteryCycles;
    property ValidationCode: string read fValidationCode;
    property CumulativeCleaningTimeInSecsAsHours: double read CumulativeCleaningTimeInSecs_asHours;
  end;

implementation

Constructor tGetWarrantyXV.create;
begin
  inherited;
  fCommand := sGetWarranty;
  fDescription := 'Get the warranty validation codes';
  Reset;
end;

Destructor tGetWarrantyXV.destroy;
begin
  inherited;
end;

procedure tGetWarrantyXV.Reset;
begin
  fCumulativeCleaningTimeInSecs := '00';
  fCumulativeBatteryCycles := '00';
  fValidationCode := '00';
  inherited;
end;

function tGetWarrantyXV.ParseText(data: tstringlist): boolean;
begin
  Reset;

  result := false;

  if NOT assigned(data) then
    exit;

  // Simple test to make sure we got data

  if data.Values[sLabel] = sValue then
  begin
    fCumulativeCleaningTimeInSecs := data.Values[sCumulativeCleaningTimeInSecs];
    fCumulativeBatteryCycles := data.Values[sCumulativeBatteryCycles];
    fValidationCode := data.Values[sValidationCode];
    result := true;
  end
  else
  begin
    fError := strParseTextError;
    result := false;
  end;

end;

function tGetWarrantyXV.CumulativeCleaningTimeInSecs_asHours: double;
begin
  result := HEX_TimeInSecs_asHours(fCumulativeCleaningTimeInSecs);
end;

end.
