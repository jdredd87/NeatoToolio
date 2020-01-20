unit neato.XV.GetLDSScan;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors,
  neato.Helpers;

const

  // Command to send

  sGetLDSScan = 'GetLDSScan';
  sSetLDSRotation = 'SetLDSRotation';

type

  tGetLDSScanRecordXV = Record
    AngleInDegrees: Integer;
    DistInMM: Integer;
    Intensity: Integer;
    ErrorCodeHEX: Integer;
  End;

  tGetLDSScanRecords = array [1 .. 360] of tGetLDSScanRecordXV; // always 360

  tGetLDSScanXV = class(tNeatoBaseCommand)
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

Constructor tGetLDSScanXV.Create;
begin
  inherited;
  // fCommand := sGetErr;
  fDescription := 'Get Error Messages';

end;

Destructor tGetLDSScanXV.Destroy;
begin
  inherited;
end;

procedure tGetLDSScanXV.Reset;
begin
  inherited;
end;

function tGetLDSScanXV.ParseText(data: TStringList): Boolean;
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
      fError := strParseTextError;
      result := false;
    end;
  end;
end;

end.
