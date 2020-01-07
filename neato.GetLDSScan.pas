unit neato.GetLDSScan;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors,
  neato.Helpers;

const

  // Command to send

  sGetLDSScan = 'GetLDSScan';
  sSetLDSRotation = 'SetLDSRotation';

type

  tGetLDSScanRecord = Record
    AngleInDegrees: Integer;
    DistInMM: Integer;
    Intensity: Integer;
    ErrorCodeHEX: Integer;
  End;

  tGetLDSScanRecords = array [1 .. 360] of tGetLDSScanRecord; // always 360

  tGetLDSScan = class(tNeatoBaseCommand)
  private
    fGetLDSScanRecords: tGetLDSScanRecords;
    fRotation_Speed: double;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: TStringList): Boolean; override;
    property GetLDSScanRecords: tGetLDSScanRecords read fGetLDSScanRecords;
    property Rotation_Speed: double read fRotation_Speed;
  end;

implementation

Constructor tGetLDSScan.Create;
begin
  inherited;
  // fCommand := sGetErr;
  fDescription := 'Get Error Messages';

end;

Destructor tGetLDSScan.Destroy;
begin
  inherited;
end;

procedure tGetLDSScan.Reset;
begin
  inherited;
end;

function tGetLDSScan.ParseText(data: TStringList): Boolean;
begin
  Reset;
  result := false;

  if NOT assigned(data) then
    exit;

  // needs finished
  try
    result := true;
  except
    on e: exception do
    begin
      fError := nParseTextError;
      result := false;
    end;
  end;
end;

end.
