unit neato.D.GetCalInfo;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors, neato.helpers;

const

  sDescription = 'Prints out the cal info from the System Control Block.';
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
  sCleaningTestSurface = 'CleaningTestSurface';
  sCleaningTestHardSpeed = 'CleaningTestHardSpeed';
  sCleaningTestCarpetSpeed = 'CleaningTestCarpetSpeed';
  sCleaningTestHardDistance = 'CleaningTestHardDistance';
  sCleaningTestCarpetDistance = 'CleaningTestCarpetDistance';
  sCleaningTestMode = 'CleaningTestMode';
  sQAState = 'QAState';
  sLeftDropSensor_CalibrationData = 'LeftDropSensor_CalibrationData';
  sRightDropSensor_CalibrationData = 'RightDropSensor_CalibrationData';
  sWheelDropSensor_CalibrationData = 'WheelDropSensor_CalibrationData';
  sWallSensor_CalibrationData = 'WallSensor_CalibrationData';

type
  tGetCalInfoD = class(tNeatoBaseCommand)
  strict private
    // not sure if these are doubles or integers or bytes as I don't have enough good sample data
    // double works, just over kill probably
    fLDSOffset: double;
    fXAccel: double;
    fYAccel: double;
    fZAccel: double;
    fRTCOffset: double;
    fCleaningTestSurface: String;
    fCleaningTestHardSpeed: double;
    fCleaningTestCarpetSpeed: double;
    fCleaningTestHardDistance: double;
    fCleaningTestCarpetDistance: double;
    fCleaningTestMode: double;
    fQAState: string;
    fLeftDropSensor_CalibrationData: double;
    fRightDropSensor_CalibrationData: double;
    fWheelDropSensor_CalibrationData: double;
    fWallSensor_CalibrationData: double;
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
    property CleaningTestSurface: String read fCleaningTestSurface write fCleaningTestSurface;
    property CleaningTestHardSpeed: double read fCleaningTestHardSpeed write fCleaningTestHardSpeed;
    property CleaningTestCarpetSpeed: double read fCleaningTestCarpetSpeed write fCleaningTestCarpetSpeed;
    property CleaningTestHardDistance: double read fCleaningTestHardDistance write fCleaningTestHardDistance;
    property CleaningTestCarpetDistance: double read fCleaningTestCarpetDistance write fCleaningTestCarpetDistance;
    property CleaningTestMode: double read fCleaningTestMode write fCleaningTestMode;
    property QAState: string read fQAState write fQAState;
    property LeftDropSensor_CalibrationData: double read fLeftDropSensor_CalibrationData
      write fLeftDropSensor_CalibrationData;
    property RightDropSensor_CalibrationData: double read fRightDropSensor_CalibrationData
      write fRightDropSensor_CalibrationData;
    property WheelDropSensor_CalibrationData: double read fWheelDropSensor_CalibrationData
      write fWheelDropSensor_CalibrationData;
    property WallSensor_CalibrationData: double read fWallSensor_CalibrationData write fWallSensor_CalibrationData;

  end;

implementation

Constructor tGetCalInfoD.Create;
begin
  inherited;
  fCommand := sGetCalInfo;
  fDescription := sDescription;
  Reset;
end;

Destructor tGetCalInfoD.Destroy;
begin
  inherited;
end;

procedure tGetCalInfoD.Reset;
begin
  fLDSOffset := 0;
  fXAccel := 0;
  fYAccel := 0;
  fZAccel := 0;
  fRTCOffset := 0;
  fCleaningTestSurface := '';
  fCleaningTestHardSpeed := 0;
  fCleaningTestCarpetSpeed := 0;
  fCleaningTestHardDistance := 0;
  fCleaningTestCarpetDistance := 0;
  fCleaningTestMode := 0;
  fQAState := '';
  fLeftDropSensor_CalibrationData := 0;
  fRightDropSensor_CalibrationData := 0;
  fWheelDropSensor_CalibrationData := 0;
  fWallSensor_CalibrationData := 0;
  inherited;
end;

function tGetCalInfoD.ParseText(data: tstringlist): boolean;
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
    fCleaningTestSurface := data.Values[sCleaningTestSurface];
    trystrtofloat(data.Values[sCleaningTestHardSpeed], fCleaningTestHardSpeed);
    trystrtofloat(data.Values[sCleaningTestCarpetSpeed], fCleaningTestCarpetSpeed);
    trystrtofloat(data.Values[sCleaningTestHardDistance], fCleaningTestHardDistance);
    trystrtofloat(data.Values[sCleaningTestCarpetDistance], fCleaningTestCarpetDistance);
    trystrtofloat(data.Values[sCleaningTestMode], fCleaningTestMode);
    fQAState := data.Values[sQAState];
    trystrtofloat(data.Values[sLeftDropSensor_CalibrationData], fLeftDropSensor_CalibrationData);
    trystrtofloat(data.Values[sRightDropSensor_CalibrationData], fRightDropSensor_CalibrationData);
    trystrtofloat(data.Values[sWheelDropSensor_CalibrationData], fWheelDropSensor_CalibrationData);
    trystrtofloat(data.Values[sWallSensor_CalibrationData], fWallSensor_CalibrationData);
    result := true;
  end
  else
  begin
    fError := strParseTextError;
    result := false;
  end;

end;

end.
