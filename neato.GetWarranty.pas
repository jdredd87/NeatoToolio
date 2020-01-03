unit neato.GetWarranty;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors;

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

  tGetWarranty = class(tNeatoBaseCommand)
  private
    fCumulativeCleaningTimeInSecs: String; // hex
    fCumulativeBatteryCycles: String; // hex
    fValidationCode: String; // hex

    function CumulativeCleaningTimeInSecs_asHours: double;
  public
    constructor create;
    destructor destroy; override;
    procedure Reset; override;
    function ParseText(data: tstringlist): boolean;

    property CumulativeCleaningTimeInSecs: string read fCumulativeCleaningTimeInSecs;
    property CumulativeBatteryCycles: string read fCumulativeBatteryCycles;
    property ValidationCode: string read fValidationCode;
    property CumulativeCleaningTimeInSecsAsHours: double read CumulativeCleaningTimeInSecs_asHours;
  end;

implementation

Constructor tGetWarranty.create;
begin
  inherited;
  fCommand := sGetWarranty;
  fDescription := 'Get the warranty validation codes';
  Reset;
end;

Destructor tGetWarranty.destroy;
begin
  inherited;
end;

procedure tGetWarranty.Reset;
begin
  fCumulativeCleaningTimeInSecs := '00';
  fCumulativeBatteryCycles := '00';
  fValidationCode := '00';
  inherited;
end;

function tGetWarranty.ParseText(data: tstringlist): boolean;
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
    fError := nParseTextError;
    result := false;
  end;

end;

function tGetWarranty.CumulativeCleaningTimeInSecs_asHours: double;
var
  value: longint;
begin
  value := 0;
  trystrtoint('$' + fCumulativeCleaningTimeInSecs, value);
  value := (value div 60) div 60;
  result := value;
end;

end.
