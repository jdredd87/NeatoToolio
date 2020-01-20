unit neato.D.GetSensor;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors, neato.helpers;

const
  sWall_FollowerUnfixed = 'Wall Follower';
  sUltra_SoundUnfixed = 'Ultra Sound';
  sDrop_SensorsUnfixed = 'Drop Sensors';
  ssensor_StatusUnfixed = 'sensors Status';
  sleft_drop_StatusUnfixed = 'left drop Status';
  sright_drop_StatusUnfixed = 'right drop Status';
  swall_right_StatusUnfixed = 'wall right Status';
  swheel_drop_StatusUnfixed = 'wheel drop Status';
  sleft_drop_mmUnfixed = 'left drop mm';
  sright_drop_mmUnfixed = 'right drop mm';
  swall_right_mmUnfixed = 'wall right mm';
  swheel_drop_mmUnfixed = 'wheel drop mm';
  sIMU_accel_xUnfixed = 'IMU accel x';
  sIMU_accel_yUnfixed = 'IMU accel y';
  sIMU_accel_zUnfixed = 'IMU accel z';

  sWall_Follower = 'WallFollower';
  sUltra_Sound = 'UltraSound';
  sDrop_Sensors = 'DropSensors';
  ssensor_Status = 'sensorsStatus';
  sleft_drop_Status = 'leftdropStatus';
  sright_drop_Status = 'rightdropStatus';
  swall_right_Status = 'wallrightStatus';
  swheel_drop_Status = 'wheeldropStatus';
  sleft_drop_mm = 'leftdropmm';
  sright_drop_mm = 'rightdropmm';
  swall_right_mm = 'wallrightmm';
  swheel_drop_mm = 'wheeldropmm';
  sIMU_accel_x = 'IMUaccelx';
  sIMU_accel_y = 'IMUaccely';
  sIMU_accel_z = 'IMUaccelz';

  // Command to send
  sGetSensor = 'GetSensor';

type

  tGetSensorD = class(tNeatoBaseCommand)
  private
    fWall_Follower: boolean;
    fUltra_Sound: boolean;
    fDrop_Sensors: boolean;
    fsensor_Status: integer;
    fleft_drop_Status: integer;
    fright_drop_Status: longint;
    fwall_right_Status: integer;
    fwheel_drop_Status: integer;
    fleft_drop_mm: integer;
    fright_drop_mm: integer;
    fwall_right_mm: integer;
    fwheel_drop_mm: integer;
    fIMU_accel_x: double;
    fIMU_accel_y: double;
    fIMU_accel_z: double;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: tstringlist): boolean; override;
    property Wall_Follower: boolean read fWall_Follower write fWall_Follower;
    property Ultra_Sound: boolean read fUltra_Sound write fUltra_Sound;
    property Drop_Sensors: boolean read fDrop_Sensors write fDrop_Sensors;
    property sensor_Status: integer read fsensor_Status write fsensor_Status;
    property left_drop_Status: integer read fleft_drop_Status write fleft_drop_Status;
    property right_drop_Status: longint read fright_drop_Status write fright_drop_Status;
    property wall_right_Status: integer read fwall_right_Status write fwall_right_Status;
    property wheel_drop_Status: integer read fwheel_drop_Status write fwheel_drop_Status;
    property left_drop_mm: integer read fleft_drop_mm write fleft_drop_mm;
    property right_drop_mm: integer read fright_drop_mm write fright_drop_mm;
    property wall_right_mm: integer read fwall_right_mm write fwall_right_mm;
    property wheel_drop_mm: integer read fwheel_drop_mm write fwheel_drop_mm;
    property IMU_accel_x: double read fIMU_accel_x write fIMU_accel_x;
    property IMU_accel_y: double read fIMU_accel_y write fIMU_accel_y;
    property IMU_accel_z: double read fIMU_accel_y write fIMU_accel_y;
  end;

implementation

Constructor tGetSensorD.Create;
begin
  inherited;
  fCommand := sGetSensor;
  fDescription := 'Gets the sensors status ON/OFF (Wall Follower and Ultra Sound Only)';
  Reset;
end;

Destructor tGetSensorD.Destroy;
begin
  inherited;
end;

procedure tGetSensorD.Reset;
begin

  fWall_Follower := false;
  fUltra_Sound := false;
  fDrop_Sensors := false;
  fsensor_Status := 0;
  fleft_drop_Status := 0;
  fright_drop_Status := 0;
  fwall_right_Status := 0;
  fwheel_drop_Status := 0;
  fleft_drop_mm := 0;
  fright_drop_mm := 0;
  fwall_right_mm := 0;
  fwheel_drop_mm := 0;
  fIMU_accel_x := 0;
  fIMU_accel_y := 0;
  fIMU_accel_z := 0;

  inherited;
end;

function tGetSensorD.ParseText(data: tstringlist): boolean;
begin
  Reset;

  result := false;

  if NOT assigned(data) then
    exit;

  // Simple test to make sure we got data

  if pos(sWall_FollowerUnfixed, data.Text) > 0 then // kind of lazy in this case with the bad response layout
  begin
    data.Text := stringreplace(data.Text, ',', '=', [rfreplaceall]); // strip out commas
    data.Text := stringreplace(data.Text, ':', '=', [rfreplaceall]); // so can do name value pair look ups
    data.Text := stringreplace(data.Text, ' ', '', [rfreplaceall]); // strip out spaces
    data.Text := stringreplace(data.Text, #9, '', [rfreplaceall]); // strip out tabs
    data.Text := stringreplace(data.Text, '(', '', [rfreplaceall]); // strip out (
    data.Text := stringreplace(data.Text, ')', '', [rfreplaceall]); // strip out )
    data.CaseSensitive := false;

    // data should be "cleaned up now"

    fWall_Follower := data.Values[sWall_Follower] = 'ON';;
    fUltra_Sound := data.Values[sUltra_Sound] = 'ON';;
    fDrop_Sensors := data.Values[sDrop_Sensors] = 'ON';;
    trystrtoint(data.Values[ssensor_Status], fsensor_Status);
    trystrtoint(data.Values[sleft_drop_Status], fleft_drop_Status);
    trystrtoint(data.Values[sright_drop_Status], fright_drop_Status);
    trystrtoint(data.Values[swall_right_Status], fwall_right_Status);
    trystrtoint(data.Values[swheel_drop_Status], fwheel_drop_Status);
    trystrtoint(data.Values[sleft_drop_mm], fleft_drop_mm);
    trystrtoint(data.Values[sright_drop_mm], fright_drop_mm);
    trystrtoint(data.Values[swall_right_mm], fwall_right_mm);
    trystrtoint(data.Values[swheel_drop_mm], fwheel_drop_mm);
    trystrtofloat(data.Values[sIMU_accel_x], fIMU_accel_x);
    trystrtofloat(data.Values[sIMU_accel_y], fIMU_accel_y);
    trystrtofloat(data.Values[sIMU_accel_z], fIMU_accel_z);

    result := true;
  end
  else
  begin
    fError := strParseTextError;
    result := false;
  end;

end;

end.
