unit neato.D.GetUserSettings;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors, neato.helpers;

const

  // response for this call is a bit goofy.
  // sort of a line by line response, but with some commas and spaces

  {

    // example response data looks silly right?

    Language, EL_NONE
    ClickSounds, ON
    LED, ON
    Wall Enable, ON
    Eco Mode, OFF
    IntenseClean, OFF
    WiFi, ON
    Melody Sounds, ON
    Warning Sounds, ON
    Bin Full Detect, ON
    Filter Change Time (seconds), 43200
    Brush Change Time (seconds), 259200
    Dirt Bin Alert Reminder Interval (minutes), 90
    Current Dirt Bin Runtime is: 109470
    Number of Cleanings where Dust Bin was Full is: 0
    Schedule is Enabled
    ¸øÿ' 09:00 H
    ¸øÿ' 15:00 H
    ¸øÿ' 15:00 H
    ¸øÿ' 15:00 H
    ¸øÿ' 15:00 H
    ¸øÿ' 15:00 H
    Èøÿ' 09:00 H

  }

  sDescription = 'Get the user settings';
  // Command to send
  sGetUserSettings = 'GetUserSettings';

  sLanguage = 'Language';
  sClickSounds = 'ClickSounds';
  sLED = 'LED';
  sWall_EnableUnfixed = 'Wall Enable';
  sWall_Enable = 'WallEnable';
  sEco_ModeUnfixed = 'Eco Mode';
  sEco_Mode = 'EcoMode';
  sIntenseClean = 'IntenseClean';
  sWiFi = 'WiFi';
  sMelody_SoundsUnfixed = 'Melody Sounds';
  sMelody_Sounds = 'MelodySounds';
  sWarning_SoundsUnfixed = 'Warning Sounds';
  sWarning_Sounds = 'WarningSounds';
  sBin_Full_DetectUnfixed = 'Bin Full Detect';
  sBin_Full_Detect = 'BinFullDetect';
  sFilter_Change_Time_secondsUnfixed = 'Filter Change Time (seconds)';
  sFilter_Change_Time_seconds = 'FilterChangeTimeseconds';
  sBrush_Change_Time_secondsUnfixed = 'Brush Change Time (seconds)';
  sBrush_Change_Time_seconds = 'BrushChangeTimeseconds';
  sDirt_Bin_Alert_Reminder_Interval_minutesUnfixed = 'Dirt Bin Alert Reminder Interval (minutes)';
  sDirt_Bin_Alert_Reminder_Interval_minutes = 'DirtBinAlertReminderIntervalminutes';
  sCurrent_Dirt_Bin_Runtime_isUnfixed = 'Current Dirt Bin Runtime is';
  sCurrent_Dirt_Bin_Runtime_is = 'CurrentDirtBinRuntimeis';
  sNumber_of_Cleanings_where_Dust_Bin_was_Full_isUnfixed = 'Number of Cleanings where Dust Bin was Full is';
  sNumber_of_Cleanings_where_Dust_Bin_was_Full_is = 'NumberofCleaningswhereDustBinwasFullis';
  sSchedule_isUnfixed = 'Schedule is Enabled';
  sSchedule_is = 'ScheduleisEnabled';

  sSunday = 'abcd 09:00 H';
  sMonday = 'abcd 09:00 H';
  sTuesday = 'abcd 09:00 H';
  sWednesday = 'abcd 09:00 H';
  sThursday = 'abcd 09:00 H';
  sFriday = 'abcd 09:00 H';
  sSaturday = 'abcd 09:00 H';

  // figure these represent days of the week.. but can't decode it quite yet and
  // it never seems to ever change values.

  {

    sSunday = 'xxx 09:00 H';
    sMonday = 'xxx 09:00 H';
    sTuesday = 'xxx 09:00 H';
    sWednesday = 'xxx 09:00 H';
    sThursday = 'xxx 09:00 H';
    sFriday = 'xxx 09:00 H';
    sSaturday = 'xxx 09:00 H';

    ¸øÿ' 09:00 H
    ¸øÿ' 15:00 H
    ¸øÿ' 15:00 H
    ¸øÿ' 15:00 H
    ¸øÿ' 15:00 H
    ¸øÿ' 15:00 H
    Èøÿ' 09:00 H

  }

type

  tGetUserSettingsD = class(tNeatoBaseCommand)
  private
    // these look to be big numbers, no decimals

    fLanguage: String;
    fClickSounds: boolean;
    fLED: boolean;
    fWall_Enable: boolean;
    fEco_Mode: boolean;
    fIntenseClean: boolean;
    fWiFi: boolean;
    fMelody_Sounds: boolean;
    fWarning_Sounds: boolean;
    fBin_Full_Detect: boolean;
    fFilter_Change_Time_seconds: longint;
    fBrush_Change_Time_seconds: longint;
    fDirt_Bin_Alert_Reminder_Interval_minutes: integer;
    fCurrent_Dirt_Bin_Runtime_is: longint;
    fNumber_of_Cleanings_where_Dust_Bin_was_Full_is: integer;
    fSchedule_is: boolean;

    // figure these represent days of the week.. but can't decode it quite yet and
    // it never seems to ever change values.

    // appears to be 4 flags, hour
    // no idea what flags are yet as i can't get anything to change!
  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: tstringlist): boolean; override;

    property Language: String read fLanguage write fLanguage;
    property ClickSounds: boolean read fClickSounds write fClickSounds;
    property LED: boolean read fLED write fLED;
    property Wall_Enable: boolean read fWall_Enable write fWall_Enable;
    property Eco_Mode: boolean read fEco_Mode write fEco_Mode;
    property IntenseClean: boolean read fIntenseClean write fIntenseClean;
    property WiFi: boolean read fWiFi write fWiFi;
    property Melody_Sounds: boolean read fMelody_Sounds write fMelody_Sounds;
    property Warning_Sounds: boolean read fWarning_Sounds write fWarning_Sounds;
    property Bin_Full_Detect: boolean read fBin_Full_Detect write fBin_Full_Detect;
    property Filter_Change_Time_seconds: longint read fFilter_Change_Time_seconds write fFilter_Change_Time_seconds;
    property Brush_Change_Time_seconds: longint read fBrush_Change_Time_seconds write fBrush_Change_Time_seconds;
    property Dirt_Bin_Alert_Reminder_Interval_minutes: integer read fDirt_Bin_Alert_Reminder_Interval_minutes
      write fDirt_Bin_Alert_Reminder_Interval_minutes;
    property Current_Dirt_Bin_Runtime_is: longint read fCurrent_Dirt_Bin_Runtime_is write fCurrent_Dirt_Bin_Runtime_is;
    property Number_of_Cleanings_where_Dust_Bin_was_Full_is: integer
      read fNumber_of_Cleanings_where_Dust_Bin_was_Full_is write fNumber_of_Cleanings_where_Dust_Bin_was_Full_is;
    property Schedule_is: boolean read fSchedule_is write fSchedule_is;

  end;

implementation

Constructor tGetUserSettingsD.Create;
begin
  inherited;
  fCommand := sGetUserSettings;
  fDescription := sDescription;
  Reset;
end;

Destructor tGetUserSettingsD.Destroy;
begin
  inherited;
end;

procedure tGetUserSettingsD.Reset;
begin
  fLanguage := '';
  fClickSounds := false;
  fLED := false;
  fWall_Enable := false;
  fEco_Mode := false;
  fIntenseClean := false;
  fWiFi := false;
  fMelody_Sounds := false;
  fWarning_Sounds := false;
  fBin_Full_Detect := false;
  fFilter_Change_Time_seconds := 0;
  fBrush_Change_Time_seconds := 0;
  fDirt_Bin_Alert_Reminder_Interval_minutes := 0;
  fCurrent_Dirt_Bin_Runtime_is := 0;
  fNumber_of_Cleanings_where_Dust_Bin_was_Full_is := 0;
  fSchedule_is := false;
  inherited;
end;

function tGetUserSettingsD.ParseText(data: tstringlist): boolean;
begin
  Reset;

  result := false;

  if NOT assigned(data) then
    exit;

  // Simple test to make sure we got data

  if pos(sLanguage, data.Text) > 0 then // kind of lazy in this case with the bad response layout
  begin
    data.Text := stringreplace(data.Text, ',', '=', [rfreplaceall]); // strip out commas
    data.Text := stringreplace(data.Text, ':', '=', [rfreplaceall]); // so can do name value pair look ups
    data.Text := stringreplace(data.Text, ' ', '', [rfreplaceall]); // strip out spaces
    data.Text := stringreplace(data.Text, #9, '', [rfreplaceall]); // strip out tabs
    data.Text := stringreplace(data.Text, '(', '', [rfreplaceall]); // strip out (
    data.Text := stringreplace(data.Text, ')', '', [rfreplaceall]); // strip out )
    data.CaseSensitive := false;

    // data should be "cleaned up now"

    fLanguage := data.Values[sLanguage];
    fClickSounds := data.Values[sClickSounds] = 'ON';
    fLED := data.Values[sLED] = 'ON';
    fWall_Enable := data.Values[sWall_Enable] = 'ON';
    fEco_Mode := data.Values[sEco_Mode] = 'ON';
    fIntenseClean := data.Values[sIntenseClean] = 'ON';
    fWiFi := data.Values[sWiFi] = 'ON';
    fMelody_Sounds := data.Values[sMelody_Sounds] = 'ON';
    fWarning_Sounds := data.Values[sWarning_Sounds] = 'ON';
    fBin_Full_Detect := data.Values[sBin_Full_Detect] = 'ON';

    trystrtoint(data.Values[sFilter_Change_Time_seconds], fFilter_Change_Time_seconds);
    trystrtoint(data.Values[sBrush_Change_Time_seconds], fBrush_Change_Time_seconds);
    trystrtoint(data.Values[sDirt_Bin_Alert_Reminder_Interval_minutes], fDirt_Bin_Alert_Reminder_Interval_minutes);
    trystrtoint(data.Values[sCurrent_Dirt_Bin_Runtime_is], fCurrent_Dirt_Bin_Runtime_is);
    trystrtoint(data.Values[sNumber_of_Cleanings_where_Dust_Bin_was_Full_is],
      fNumber_of_Cleanings_where_Dust_Bin_was_Full_is);

    Schedule_is := data.IndexOf(sSchedule_is) > -1;

    result := true;
  end
  else
  begin
    fError := strParseTextError;
    result := false;
  end;

end;

end.
