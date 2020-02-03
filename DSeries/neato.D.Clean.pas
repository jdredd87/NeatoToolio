unit neato.D.Clean;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors, neato.helpers;

const
  sDescription = 'Starts a cleaning by simulating press of start button';
  // Command to send
  sClean = 'Clean';
  sInvalid_Width = 'Invalid Width';

  sExplore = 'Explore';
  sExploreMSG = 'Equivalent to starting an Exploration run from the Smart App. Starts an exploration run.';

  sHouse = 'House';
  sHouseMSG =
    'Equivalent to pressing `Start` button once. Starts a house cleaning. (House cleaning mode is the default cleaning mode.)';

  sSpot = 'Spot';
  sSpotMsg = 'Starts a spot clean. (Not available with AutoCycle)';

  sPersistent = 'Persistent';
  sPersistentMsg = 'Equivalent to starting a persistent cleaning from the Smart App.';

  sWidth = 'Width';
  SWidthMsg = 'Spot Width in CM (100-400)(-1=use default).';

  sHeight = 'Height';
  sHeightMsg = 'Spot Height in CM (100-400)(-1=use default).';

  sAutoCycle = 'AutoCycle';
  sAutoCycleMsg = 'Number of times the robot should clean or explore.';

  sStop = 'Stop';
  sStopMsg = 'Stop Cleaning.';

type

  tCleanD = class(tNeatoBaseCommand)
  strict private
  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: tstringlist): boolean; override;
  end;

implementation

Constructor tCleanD.Create;
begin
  inherited;
  fCommand := sClean;
  fDescription := sDescription;
  Reset;
end;

Destructor tCleanD.Destroy;
begin
  inherited;
end;

procedure tCleanD.Reset;
begin
  inherited;
end;

function tCleanD.ParseText(data: tstringlist): boolean;
begin
  try
    Reset;
    result := false;

    if NOT assigned(data) then
      exit;

    // Simple test to make sure we got data

    data.CaseSensitive := false;

    if data.Count > 0 then
      data.Delete(0);

    data.Text := trim(data.Text);

    if data.Text = '' then
    begin
      result := true;
    end
    else if pos(sInvalid_Width, data.Text) > 0 then
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
  except
    on e: exception do
    begin
      ferror := e.Message;
      result := false;
    end;
  end;
end;

end.
