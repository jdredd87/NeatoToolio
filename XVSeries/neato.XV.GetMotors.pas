unit neato.XV.GetMotors;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors;

const

  sGetMotors = 'GetMotors';

  sParameter = 'Parameter';
  sValue = 'Value';

  sBrush_RPM = 'Brush_RPM';
  sBrush_mA = 'Brush_mA';

  sVacuum_RPM = 'Vacuum_RPM';
  sVacuum_mA = 'Vacuum_mA';

  sLeftWheel_RPM = 'LeftWheel_RPM';
  sLeftWheel_Load = 'LeftWheel_Load%';
  sLeftWheel_PositionInMM = 'LeftWheel_PositionInMM';
  sLeftWheel_Speed = 'LeftWheel_Speed';

  sRightWheel_RPM = 'RightWheel_RPM';
  sRightWheel_Load = 'RightWheel_Load';
  sRightWheel_PositionInMM = 'RightWheel_PositionInMM';
  sRightWheel_Speed = 'RightWheel_Speed';

  sCharger_mAH = 'Charger_mAH';
  sSideBrush_mA = 'SideBrush_mA';

type

  tGetMotorsXV = class(tNeatoBaseCommand)
  private
    fBrush_RPM: double;
    fBrush_mA: double;
    fVacuum_RPM: double;
    fVacuum_mA: double;
    fLeftWheel_RPM: double;
    fLeftWheel_Load: double;
    fLeftWheel_PositionInMM: double;
    fLeftWheel_Speed: double;

    fRightWheel_RPM: double;
    fRightWheel_Load: double;
    fRightWheel_PositionInMM: double;
    fRightWheel_Speed: double;

    fCharger_mAH: double;
    fSideBrush_mA: double;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: tstringlist): boolean; override;

    property Brush_RPM: double read fBrush_RPM write fBrush_RPM;
    property Brush_mA: double read fBrush_mA write fBrush_mA;
    property Vacuum_RPM: double read fVacuum_RPM write fVacuum_RPM;
    property Vacuum_mA: double read fVacuum_mA write fVacuum_mA;
    property LeftWheel_RPM: double read fLeftWheel_RPM write fLeftWheel_RPM;
    property LeftWheel_Load: double read fLeftWheel_Load write fLeftWheel_Load;
    property LeftWheel_PositionInMM: double read fLeftWheel_PositionInMM write fLeftWheel_PositionInMM;
    property LeftWheel_Speed: double read fLeftWheel_Speed write fLeftWheel_Speed;

    property RightWheel_RPM: double read fRightWheel_RPM write fRightWheel_RPM;
    property RightWheel_Load: double read fRightWheel_Load write fRightWheel_Load;
    property RightWheel_PositionInMM: double read fRightWheel_PositionInMM write fRightWheel_PositionInMM;
    property RightWheel_Speed: double read fRightWheel_Speed write fRightWheel_Speed;

    property Charger_mAH: double read fCharger_mAH write fCharger_mAH;
    property SideBrush_mA: double read fSideBrush_mA write fSideBrush_mA;
  end;

implementation

Constructor tGetMotorsXV.Create;
begin
  inherited;
  fCommand := sGetMotors;
  fDescription := 'Get the diagnostic data for the motors';
  Reset;
end;

Destructor tGetMotorsXV.Destroy;
begin
  inherited;
end;

procedure tGetMotorsXV.Reset;
begin
  inherited;
end;

function tGetMotorsXV.ParseText(data: tstringlist): boolean;
begin
  Reset;

  result := false;

  if NOT assigned(data) then
    exit;

  data.CaseSensitive := false;
  data.Text := stringreplace(data.Text, ',', '=', [rfreplaceall]);

  // Simple test to make sure we got data

  if data.Values[sParameter] = sValue then
  begin
    trystrtofloat(data.Values[sBrush_RPM], fBrush_RPM);
    trystrtofloat(data.Values[sBrush_mA], fBrush_mA);
    trystrtofloat(data.Values[sVacuum_RPM], fVacuum_RPM);
    trystrtofloat(data.Values[sVacuum_mA], fVacuum_mA);
    trystrtofloat(data.Values[sLeftWheel_RPM], fLeftWheel_RPM);
    trystrtofloat(data.Values[sLeftWheel_Load], fLeftWheel_Load);
    trystrtofloat(data.Values[sLeftWheel_PositionInMM], fLeftWheel_PositionInMM);
    trystrtofloat(data.Values[sLeftWheel_Speed], fLeftWheel_Speed);

    trystrtofloat(data.Values[sRightWheel_RPM], fRightWheel_RPM);
    trystrtofloat(data.Values[sRightWheel_Load], fRightWheel_Load);
    trystrtofloat(data.Values[sRightWheel_PositionInMM], fRightWheel_PositionInMM);
    trystrtofloat(data.Values[sRightWheel_Speed], fRightWheel_Speed);

    trystrtofloat(data.Values[sCharger_mAH], fCharger_mAH);
    trystrtofloat(data.Values[sSideBrush_mA], fSideBrush_mA);
    result := true;
  end
  else
  begin
    fError := strParseTextError;
    result := false;
  end;

end;

end.
