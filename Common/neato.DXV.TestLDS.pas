unit neato.DXV.TestLDS;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors;

const
  sDescription = 'Get Lidar hardware information';


  // Command to send

  sTestLDS = 'TestLDS CMD';

  sGetVersion = 'GetVersion';
  sLoader = 'Loader';
  sCPU = 'CPU';
  sSerial = 'Serial';
  sLastCal = 'LastCal';
  sRuntime = 'Runtime';
  sPiccolo = 'Piccolo';

type

  tTestLDS = class(tNeatoBaseCommand)
  private
    fLoader: string;
    fCPU: string;
    fSerial: string;
    fLastCal: string;
    fRuntime: string;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: tstringlist): boolean; override;
    property Loader: string read fLoader write fLoader;
    property CPU: string read fCPU write fCPU;
    property Serial: string read fSerial write fSerial;
    property LastCal: string read fLastCal write fLastCal;
    property Runtime: string read fRuntime write fRuntime;
  end;

implementation

Constructor tTestLDS.Create;
begin
  inherited;
  fCommand := sTestLDS;
  fDescription := sDescription;
  Reset;
end;

Destructor tTestLDS.Destroy;
begin
  inherited;
end;

procedure tTestLDS.Reset;
begin
  fLoader := '';
  fCPU := '';
  fSerial := '';
  fLastCal := '';
  fRuntime := '';
  inherited;
end;

function tTestLDS.ParseText(data: tstringlist): boolean;
var
  idx: integer;
begin

  try
    Reset;

    result := false;

    if NOT assigned(data) then
      exit;

    // Simple test to make sure we got data

    data.CaseSensitive := false;

    if pos(sPiccolo, data.Text) > 0 then
    begin
      data.Delete(0);
      data.Delete(0);
      data.Delete(0);
      data.Delete(0);
      data.Delete(0);

      for idx := 0 to data.Count - 1 do
        data[idx] := stringreplace(data[idx], #9, '=', []);

      fLoader := data.Values[sLoader];
      fCPU := data.Values[sCPU];
      fSerial := data.Values[sSerial];
      fLastCal := data.Values[sLastCal];
      fRuntime := data.Values[sRuntime];

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
