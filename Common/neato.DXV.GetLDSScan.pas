unit neato.DXV.GetLDSScan;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors,
  neato.Helpers;

const

  // Command to send

  sGetLDSScan = 'GetLDSScan';
  sSetLDSRotation = 'SetLDSRotation';
  sRotation_Speed = 'ROTATION_SPEED,';

type

  tGetLDSScanRecord = Record
    AngleInDegrees: Integer;
    DistInMM: Integer;
    Intensity: Integer;
    ErrorCodeHEX: Integer;
  End;

  tGetLDSScanRecords = array [1 .. 360] of tGetLDSScanRecord; // always 360

  tGetLDSScanDXV = class(tNeatoBaseCommand)
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

Constructor tGetLDSScanDXV.Create;
begin
  inherited;
  // fCommand := sGetErr;
  fDescription := 'Get Error Messages';

end;

Destructor tGetLDSScanDXV.Destroy;
begin
  inherited;
end;

procedure tGetLDSScanDXV.Reset;
begin
  fillchar(fGetLDSScanRecords, sizeof(fGetLDSScanRecords), #0);
  fRotation_Speed := 0;
  inherited;
end;

function tGetLDSScanDXV.ParseText(data: TStringList): Boolean;
var
  lineData: TStringList;
  idx: Integer;
begin
  Reset;
  result := false;

  if NOT assigned(data) then
    exit;

  try
    lineData := TStringList.Create;
    lineData.Delimiter := ',';
    lineData.StrictDelimiter := true;

    data.Text := trim(data.Text);
    data.Delete(0);
    data.Delete(0);
    for idx := 0 to 359 do
    begin
      lineData.DelimitedText := data[idx];
      trystrtoint(lineData[0], fGetLDSScanRecords[idx + 1].AngleInDegrees);
      trystrtoint(lineData[1], fGetLDSScanRecords[idx + 1].DistInMM);
      trystrtoint(lineData[2], fGetLDSScanRecords[idx + 1].Intensity);
      trystrtoint(lineData[3], fGetLDSScanRecords[idx + 1].ErrorCodeHEX);
      lineData.Clear;
    end;

    trystrtofloat(stringreplace(data[data.Count - 1],sRotation_Speed,'',[rfignorecase]), self.fRotation_Speed);
    result := true;
  except
    on e: exception do
    begin
      fError := strParseTextError;
      result := false;
    end;
  end;

  freeandnil(lineData);
end;

end.
