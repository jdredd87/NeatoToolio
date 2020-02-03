unit neato.DXV.GetAccel;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors;

const
  sDescription = 'Get the Accelerometer readings';

  // labels of text to look / parse for
  sLabel = 'Label';
  sValue = 'Value';

  sPitchInDegrees = 'PitchInDegrees';
  sRollInDegrees = 'RollInDegrees';
  sXInG = 'XInG';
  sYInG = 'YInG';
  sZIng = 'ZInG';
  sSumInG = 'SumInG';

  // Command to send

  sGetAccelD = 'GetAccel';

type

  tGetAccelD = class(tNeatoBaseCommand)
  private
    fPitchInDegrees: double;
    fRollInDegrees: double;
    fXInG: double;
    fYInG: double;
    fZInG: double;
    fSumInG: double;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: tstringlist): boolean; override;

    property PitchInDegrees: double read fPitchInDegrees;
    property RollInDegrees: double read fRollInDegrees;
    property XInG: double read fXInG;
    property YInG: double read fYInG;
    property ZInG: double read fZInG;
    property SumInG: double read fSumInG;
  end;

implementation

Constructor tGetAccelD.Create;
begin
  inherited;
  fCommand := sGetAccelD;
  fDescription := sDescription;
  Reset;
end;

Destructor tGetAccelD.Destroy;
begin
  inherited;
end;

procedure tGetAccelD.Reset;
begin
  fPitchInDegrees := 0;
  fRollInDegrees := 0;
  fXInG := 0;
  fYInG := 0;
  fZInG := 0;
  fSumInG := 0;
  inherited;
end;

function tGetAccelD.ParseText(data: tstringlist): boolean;
begin
  try
    Reset;

    result := false;

    if NOT assigned(data) then
      exit;

    // Simple test to make sure we got data

    if data.Values[sLabel] = sValue then
    begin
      TryStrToFloat(data.Values[sPitchInDegrees], fPitchInDegrees);
      TryStrToFloat(data.Values[sRollInDegrees], fRollInDegrees);
      TryStrToFloat(data.Values[sXInG], fXInG);
      TryStrToFloat(data.Values[sYInG], fYInG);
      TryStrToFloat(data.Values[sZIng], fZInG);
      TryStrToFloat(data.Values[sSumInG], fSumInG);
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

end.
