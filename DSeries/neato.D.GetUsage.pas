unit neato.D.GetUsage;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors, neato.helpers;

const

  // response for this call is a bit goofy.
  // sort of a line by line response, but with some commas and spaces

  {

    // example response data looks silly right?

    Total cleaning time : 18365
    , Total cleaned area    : 0
    ,MainBrushRunTimeinSec  : 1750372
    ,SideBrushRunTimeinSec  : 1750372
    , DirtbinRunTimeinSec : 1750372
    ,FilterTimeinSec : 1750372
    Total cleaning time : 18365

  }
  sDescription = 'Get usage settings';

  sTotal_cleaning_timeUnFixed = 'Total cleaning time'; // use this original value
  sTotal_cleaning_time = 'Totalcleaningtime'; // use this original value

  sTotal_cleaned_areaUnFixed = 'Total_cleaned_area'; // use this original value
  sTotal_cleaned_area = 'Totalcleanedarea'; // use this original value

  sMainBrushRunTimeinSec = 'MainBrushRunTimeinSec';
  sSideBrushRunTimeinSec = 'SideBrushRunTimeinSec';
  sDirtbinRunTimeinSec = 'DirtbinRunTimeinSec';
  sFilterTimeinSec = 'FilterTimeinSec';

  // Command to send
  sGetUsage = 'GetUsage';

type

  tGetUsageD = class(tNeatoBaseCommand)
  private
    // these look to be big numbers, no decimals

    fTotal_cleaning_time: integer;
    fTotal_cleaned_area: integer;
    fMainBrushRunTimeinSec: integer;
    fSideBrushRunTimeinSec: integer;
    fDirtbinRunTimeinSec: integer;
    fFilterTimeinSec: integer;

  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: tstringlist): boolean; override;

    property Total_Cleaning_Time: integer read fTotal_cleaning_time;
    property Total_Cleaned_Area: integer read fTotal_cleaned_area;
    property MainBrushRunTimeinSec: integer read fMainBrushRunTimeinSec;
    property SideBrushRunTimeinSec: integer read fSideBrushRunTimeinSec;
    property DirtbinRunTimeinSec: integer read fDirtbinRunTimeinSec;
    property FilterTimeinSec: integer read fFilterTimeinSec;
  end;

implementation

Constructor tGetUsageD.Create;
begin
  inherited;
  fCommand := sGetUsage;
  fDescription := sDescription;
  Reset;
end;

Destructor tGetUsageD.Destroy;
begin
  inherited;
end;

procedure tGetUsageD.Reset;
begin
  fTotal_cleaning_time := 0;
  fTotal_cleaned_area := 0;
  fMainBrushRunTimeinSec := 0;
  fSideBrushRunTimeinSec := 0;
  fDirtbinRunTimeinSec := 0;
  fFilterTimeinSec := 0;;
  inherited;
end;

function tGetUsageD.ParseText(data: tstringlist): boolean;
begin
  try
    Reset;

    result := false;

    if NOT assigned(data) then
      exit;

    // Simple test to make sure we got data

    if pos(sTotal_cleaning_timeUnFixed, data.Text) > 0 then // kind of lazy in this case with the bad response layout
    begin
      data.Text := stringreplace(data.Text, ',', '', [rfreplaceall]); // strip out commas
      data.Text := stringreplace(data.Text, ' ', '', [rfreplaceall]); // strip out spaces
      data.Text := stringreplace(data.Text, #9, '', [rfreplaceall]); // strip out tabs
      data.Text := stringreplace(data.Text, ':', '=', [rfreplaceall]); // so can do name value pair look ups
      data.CaseSensitive := false;

      // data should be "cleaned up now"

      trystrtoint(data.Values[sTotal_cleaning_time], fTotal_cleaning_time);
      trystrtoint(data.Values[sTotal_cleaned_area], fTotal_cleaned_area);
      trystrtoint(data.Values[sMainBrushRunTimeinSec], fMainBrushRunTimeinSec);
      trystrtoint(data.Values[sSideBrushRunTimeinSec], fSideBrushRunTimeinSec);
      trystrtoint(data.Values[sDirtbinRunTimeinSec], fDirtbinRunTimeinSec);
      trystrtoint(data.Values[sFilterTimeinSec], fFilterTimeinSec);

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
