unit neato.XV.GetCalInfo;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors, neato.helpers;

const

  // Command to send
  sGetCalInfo = 'GetCalInfo';
  // I always get this odd message
  // calibration file /emmc/calibration/wheel_sensor_calibration.txt does not exist

  // sParameter = Parameter,Value,DistanceInMM // shows 3 columns, but data always shows 2? assume DistanceInMM maybe just a hint
  // so just going to make it look for Parameter,Value
  sParameter_Value_DistanceInMM = 'Parameter,Value';

  sLDSOffset = 'LDSOffset';
  sXAccel = 'XAccel';
  sYAccel = 'YAccel';
  sZAccel = 'ZAccel';
  sRTCOffset = 'RTCOffset';

  sLCDContrast = 'LCDContrast';
  sRDropMin = 'RDropMin';
  sRDropMid = 'RDropMid';
  sRDropMax = 'RDropMax';
  sLDropMin = 'LDropMin';
  sLDropMid = 'LDropMid';
  sLDropMax = 'LDropMax';
  sWallMin = 'WallMin';
  sWallMid = 'WallMid';
  sWallMax = 'WallMax';

  sQAState = 'QAState';
  sCleaningTestSurface = 'CleaningTestSurface';
  sCleaningTestHardSpeed = 'CleaningTestHardSpeed';
  sCleaningTestCarpetSpeed = 'CleaningTestCarpetSpeed';
  sCleaningTestHardDistance = 'CleaningTestHardDistance';
  sCleaningTestCarpetDistance = 'CleaningTestCarpetDistance';

type
  tGetCalInfoXV = class(tNeatoBaseCommand)
  strict private
    // not sure if these are doubles or integers or bytes as I don't have enough good sample data
    // double works, just over kill probably
    fLDSOffset: double;
    fXAccel: double;
    fYAccel: double;
    fZAccel: double;
    fRTCOffset: double;

    fLCDContrast: double;
    fRDropMin: double;
    fRDropMid: double;
    fRDropMax: double;
    fLDropMin: double;
    fLDropMid: double;
    fLDropMax: double;
    fWallMin: double;
    fWallMid: double;
    fWallMax: double;

    fQAState: string;
    fCleaningTestSurface: String;
    fCleaningTestHardSpeed: double;
    fCleaningTestCarpetSpeed: double;
    fCleaningTestHardDistance: double;
    fCleaningTestCarpetDistance: double;

  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: tstringlist): boolean; override;

    property LDSOffset: double read fLDSOffset write fLDSOffset;
    property XAccel: double read fXAccel write fXAccel;
    property YAccel: double read fYAccel write fYAccel;
    property ZAccel: double read fZAccel write fZAccel;
    property RTCOffset: double read fRTCOffset write fRTCOffset;
    property LCDContrast: double read fLCDContrast write fLCDContrast;
    property RDropMin: double read fRDropMin write fRDropMin;
    property RDropMid: double read fRDropMid write fRDropMid;
    property RDropMax: double read fRDropMax write fRDropMax;
    property LDropMin: double read fLDropMin write fLDropMin;
    property LDropMid: double read fLDropMid write fLDropMid;
    property LDropMax: double read fLDropMax write fLDropMax;
    property WallMin: double read fWallMin write fWallMin;
    property WallMid: double read fWallMid write fWallMid;
    property WallMax: double read fWallMax write fWallMax;

    property QAState: string read fQAState write fQAState;
    property CleaningTestSurface: String read fCleaningTestSurface write fCleaningTestSurface;
    property CleaningTestHardSpeed: double read fCleaningTestHardSpeed write fCleaningTestHardSpeed;
    property CleaningTestCarpetSpeed: double read fCleaningTestCarpetSpeed write fCleaningTestCarpetSpeed;
    property CleaningTestHardDistance: double read fCleaningTestHardDistance write fCleaningTestHardDistance;
    property CleaningTestCarpetDistance: double read fCleaningTestCarpetDistance write fCleaningTestCarpetDistance;
  end;

implementation

Constructor tGetCalInfoXV.Create;
begin
  inherited;
  fCommand := sGetCalInfo;
  fDescription := 'Prints out the cal info from the System Control Block.';
  Reset;
end;

Destructor tGetCalInfoXV.Destroy;
begin
  inherited;
end;

procedure tGetCalInfoXV.Reset;
begin
  fLDSOffset := 0;
  fXAccel := 0;
  fYAccel := 0;
  fZAccel := 0;
  fRTCOffset := 0;

  fLCDContrast := 0;
  fRDropMin := 0;
  fRDropMid := 0;
  fRDropMax := 0;
  fLDropMin := 0;
  fLDropMid := 0;
  fLDropMax := 0;
  fWallMin := 0;
  fWallMid := 0;
  fWallMax := 0;

  fQAState := '';
  fCleaningTestSurface := '';
  fCleaningTestHardSpeed := 0;
  fCleaningTestCarpetSpeed := 0;
  fCleaningTestHardDistance := 0;
  fCleaningTestCarpetDistance := 0;
  inherited;
end;

function tGetCalInfoXV.ParseText(data: tstringlist): boolean;
begin
  Reset;
  result := false;

  if NOT assigned(data) then
    exit;

  // Simple test to make sure we got data

  data.CaseSensitive := false;
  // looks like no spaces in the data but lets make sure
  data.Text := stringreplace(data.Text, ' ', '', [rfreplaceall]);

  if pos(sParameter_Value_DistanceInMM, data.Text) > 0 then
  begin
    // the , to = conversion now
    data.Text := stringreplace(data.Text, ',', '=', [rfreplaceall]);
    trystrtofloat(data.Values[sLDSOffset], fLDSOffset);
    trystrtofloat(data.Values[sXAccel], fXAccel);
    trystrtofloat(data.Values[sYAccel], fYAccel);
    trystrtofloat(data.Values[sZAccel], fZAccel);
    trystrtofloat(data.Values[sRTCOffset], fRTCOffset);

    trystrtofloat(data.Values[sLCDContrast], fLCDContrast);
    trystrtofloat(data.Values[sRDropMin], fRDropMin);
    trystrtofloat(data.Values[sRDropMid], fRDropMid);
    trystrtofloat(data.Values[sRDropMax], fRDropMax);
    trystrtofloat(data.Values[sLDropMin], fLDropMin);
    trystrtofloat(data.Values[sLDropMid], fLDropMid);
    trystrtofloat(data.Values[sLDropMax], fLDropMax);
    trystrtofloat(data.Values[sWallMin], fWallMin);
    trystrtofloat(data.Values[sWallMid], fWallMid);
    trystrtofloat(data.Values[sWallMax], fWallMax);

    fQAState := data.Values[sQAState];
    fCleaningTestSurface := data.Values[sCleaningTestSurface];
    trystrtofloat(data.Values[sCleaningTestHardSpeed], fCleaningTestHardSpeed);
    trystrtofloat(data.Values[sCleaningTestCarpetSpeed], fCleaningTestCarpetSpeed);
    trystrtofloat(data.Values[sCleaningTestHardDistance], fCleaningTestHardDistance);
    trystrtofloat(data.Values[sCleaningTestCarpetDistance], fCleaningTestCarpetDistance);
    result := true;
  end
  else
  begin
    fError := strParseTextError;
    result := false;
  end;

end;

end.
