unit neato.XV.GetWarranty;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors, neato.helpers;

const
  // labels of text to look / parse for

  // sCumulativeCleaningTimeInSecs = 'CumulativeCleaningTimeInSecs';
  // sCumulativeBatteryCycles = 'CumulativeBatteryCycles';
  // sValidationCode = 'ValidationCode';
  // Command to send

  sGetWarranty = 'GetWarranty';
  sDescription = 'Get the warranty validation codes';

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

Constructor tGetWarrantyXV.Create;
begin
  inherited;
  fCommand := sGetWarranty;
  fDescription := sDescription;
  Reset;
end;

Destructor tGetWarrantyXV.Destroy;
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
  try
    Reset;

    result := false;

    if NOT assigned(data) then
      exit;

    // Simple test to make sure we got data

    if data.Count = 5 then
    begin
      data.Delete(0); // delete 1 top rows first
      fCumulativeCleaningTimeInSecs := data[0];
      fCumulativeBatteryCycles := data[1];
      fValidationCode := data[2];
      result := true;
    end
    else
    begin
      fError := strParseTextError;
      result := false;
    end;
  except
    on e: exception do
    begin
      fError := e.Message;
      result := false;
    end;
  end;
end;

function tGetWarrantyXV.CumulativeCleaningTimeInSecs_asHours: double;
begin
  result := HEX_TimeInSecs_asHours(fCumulativeCleaningTimeInSecs);
end;

end.
