unit neato.GetVersion;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors,
  neato.Helpers;

const

  // labels of text to look / parse for
  sComponent = 'Component';
  sMajor = 'Major';
  sMinor = 'Minor';
  sBuild = 'Build';
  sAux = 'Aux';

  iGetVersionRowCount = 47; // 47 fields were mapped out so far

  sBaseID = 'BaseID';
  sBeehive_URL = 'Beehive URL';
  sBlowerType = 'BlowerType';
  sBootloader_Version = 'Bootloader Version';
  sBrushMotorResistorPowerRating = 'BrushMotorResistorPowerRating';
  sBrushMotorResistorResistance = 'BrushMotorResistorResistance';
  sBrushMotorType = 'BrushMotorType';
  sBrushSpeed = 'BrushSpeed';
  sBrushSpeedEco = 'BrushSpeedEco';
  sChassisRev = 'ChassisRev';
  sDropSensorType = 'DropSensorType';
  sLCD_Panel = 'LCD Panel';
  sLDS_CPU = 'LDS CPU';
  sLDS_Serial = 'LDS Serial';
  sLDS_Software = 'LDS Software';
  sLDSMotorType = 'LDSMotorType';
  sLocale = 'Locale';
  sMagSensorType = 'MagSensorType';
  sMainBoard_Serial_Number = 'MainBoard Serial Number';
  sMainBoard_Version = 'MainBoard Version';
  sModel = 'Model';
  sNTP_URL = 'NTP URL';
  sNucleo_URL = 'Nucleo URL';
  sQAState = 'QAState';
  sSerial_Number = 'Serial Number';
  sSideBrushPower = 'SideBrushPower';
  sSideBrushType = 'SideBrushType';
  sSmartBatt_Authorization = 'SmartBatt Authorization';
  sSmartBatt_Data_Version = 'SmartBatt Data Version';
  sSmartBatt_Device_Chemistry = 'SmartBatt Device Chemistry';
  sSmartBatt_Device_Name = 'SmartBatt Device Name';
  sSmartBatt_Manufacturer_Name = 'SmartBatt Manufacturer Name';
  sSmartBatt_Mfg_Year_Month_Day = 'SmartBatt Mfg Year/Month/Day';
  sSmartBatt_Serial_Number = 'SmartBatt Serial Number';
  sSmartBatt_Software_Version = 'SmartBatt Software Version';
  sSoftware_Git_SHA = 'Software Git SHA';
  sSoftware = 'Software';
  sTime_Local = 'Time Local';
  sTime_UTC = 'Time UTC';
  sUI_Board_Hardware = 'UI Board Hardware';
  sUI_Board_Software = 'UI Board Software';
  sUI_Name = 'UI Name';
  sUI_Version = 'UI Version';
  sVacuumPwr = 'VacuumPwr';
  sVacuumPwrEco = 'VacuumPwrEco';
  sWallSensorType = 'WallSensorType';
  sWheelPodType = 'WheelPodType';


  // Command to send

  sGetVersion = 'GetVersion';

type

  tGetVersionFields = record
    Component: String;
    Major: String;
    Minor: String;
    Build: String;
    AUX: String;
    AUX2: String; // bug in neato response, where some fields like "software" has a 5th value. Derp.
    procedure Reset;
    function ParseText(data: TStringList; lookFor: string): boolean;
  end;

  tGetVersion = class(tNeatoBaseCommand)
  private

    fBaseID: tGetVersionFields;
    fBeehive_URL: tGetVersionFields;
    fBlowerType: tGetVersionFields;
    fBootloader_Version: tGetVersionFields;
    fBrushMotorResistorPowerRating: tGetVersionFields;
    fBrushMotorResistorResistance: tGetVersionFields;
    fBrushMotorType: tGetVersionFields;
    fBrushSpeed: tGetVersionFields;
    fBrushSpeedEco: tGetVersionFields;
    fChassisRev: tGetVersionFields;
    fDropSensorType: tGetVersionFields;
    fLCD_Panel: tGetVersionFields;
    fLDS_CPU: tGetVersionFields;
    fLDS_Serial: tGetVersionFields;
    fLDS_Software: tGetVersionFields;
    fLDSMotorType: tGetVersionFields;
    fLocale: tGetVersionFields;
    fMagSensorType: tGetVersionFields;
    fMainBoard_Serial_Number: tGetVersionFields;
    fMainBoard_Version: tGetVersionFields;
    fModel: tGetVersionFields;
    fNTP_URL: tGetVersionFields;
    fNucleo_URL: tGetVersionFields;
    fQAState: tGetVersionFields;
    fSerial_Number: tGetVersionFields;
    fSideBrushPower: tGetVersionFields;
    fSideBrushType: tGetVersionFields;
    fSmartBatt_Authorization: tGetVersionFields;
    fSmartBatt_Data_Version: tGetVersionFields;
    fSmartBatt_Device_Chemistry: tGetVersionFields;
    fSmartBatt_Device_Name: tGetVersionFields;
    fSmartBatt_Manufacturer_Name: tGetVersionFields;
    fSmartBatt_Mfg_Year_Month_Day: tGetVersionFields;
    fSmartBatt_Serial_Number: tGetVersionFields;
    fSmartBatt_Software_Version: tGetVersionFields;
    fSoftware_Git_SHA: tGetVersionFields;
    fSoftware: tGetVersionFields;
    fTime_Local: tGetVersionFields;
    fTime_UTC: tGetVersionFields;
    fUI_Board_Hardware: tGetVersionFields;
    fUI_Board_Software: tGetVersionFields;
    fUI_Name: tGetVersionFields;
    fUI_Version: tGetVersionFields;
    fVacuumPwr: tGetVersionFields;
    fVacuumPwrEco: tGetVersionFields;
    fWallSensorType: tGetVersionFields;
    fWheelPodType: tGetVersionFields;

  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: TStringList): boolean; override;

    property BaseID: tGetVersionFields Read fBaseID;
    property Beehive_URL: tGetVersionFields Read fBeehive_URL;
    property BlowerType: tGetVersionFields Read fBlowerType;
    property Bootloader_Version: tGetVersionFields Read fBootloader_Version;
    property BrushMotorResistorPowerRating: tGetVersionFields Read fBrushMotorResistorPowerRating;
    property BrushMotorResistorResistance: tGetVersionFields Read fBrushMotorResistorResistance;
    property BrushMotorType: tGetVersionFields Read fBrushMotorType;
    property BrushSpeed: tGetVersionFields Read fBrushSpeed;
    property BrushSpeedEco: tGetVersionFields Read fBrushSpeedEco;
    property ChassisRev: tGetVersionFields Read fChassisRev;
    property DropSensorType: tGetVersionFields Read fDropSensorType;
    property LCD_Panel: tGetVersionFields Read fLCD_Panel;
    property LDS_CPU: tGetVersionFields Read fLDS_CPU;
    property LDS_Serial: tGetVersionFields Read fLDS_Serial;
    property LDS_Software: tGetVersionFields Read fLDS_Software;
    property LDSMotorType: tGetVersionFields Read fLDSMotorType;
    property Locale: tGetVersionFields Read fLocale;
    property MagSensorType: tGetVersionFields Read fMagSensorType;
    property MainBoard_Serial_Number: tGetVersionFields Read fMainBoard_Serial_Number;
    property MainBoard_Version: tGetVersionFields Read fMainBoard_Version;
    property Model: tGetVersionFields Read fModel;
    property NTP_URL: tGetVersionFields Read fNTP_URL;
    property Nucleo_URL: tGetVersionFields Read fNucleo_URL;
    property QAState: tGetVersionFields Read fQAState;
    property Serial_Number: tGetVersionFields Read fSerial_Number;
    property SideBrushPower: tGetVersionFields Read fSideBrushPower;
    property SideBrushType: tGetVersionFields Read fSideBrushType;
    property SmartBatt_Authorization: tGetVersionFields Read fSmartBatt_Authorization;
    property SmartBatt_Data_Version: tGetVersionFields Read fSmartBatt_Data_Version;
    property SmartBatt_Device_Chemistry: tGetVersionFields Read fSmartBatt_Device_Chemistry;
    property SmartBatt_Device_Name: tGetVersionFields Read fSmartBatt_Device_Name;
    property SmartBatt_Manufacturer_Name: tGetVersionFields Read fSmartBatt_Manufacturer_Name;
    property SmartBatt_Mfg_Year_Month_Day: tGetVersionFields Read fSmartBatt_Mfg_Year_Month_Day;
    property SmartBatt_Serial_Number: tGetVersionFields Read fSmartBatt_Serial_Number;
    property SmartBatt_Software_Version: tGetVersionFields Read fSmartBatt_Software_Version;
    property Software_Git_SHA: tGetVersionFields Read fSoftware_Git_SHA;
    property Software: tGetVersionFields Read fSoftware;
    property Time_Local: tGetVersionFields Read fTime_Local;
    property Time_UTC: tGetVersionFields Read fTime_UTC;
    property UI_Board_Hardware: tGetVersionFields Read fUI_Board_Hardware;
    property UI_Board_Software: tGetVersionFields Read fUI_Board_Software;
    property UI_Name: tGetVersionFields Read fUI_Name;
    property UI_Version: tGetVersionFields Read fUI_Version;
    property VacuumPwr: tGetVersionFields Read fVacuumPwr;
    property VacuumPwrEco: tGetVersionFields Read fVacuumPwrEco;
    property WallSensorType: tGetVersionFields Read fWallSensorType;
    property WheelPodType: tGetVersionFields Read fWheelPodType;

  end;

implementation

Procedure tGetVersionFields.Reset;
begin
  Component := '';
  Major := '';
  Minor := '';
  Build := '';
  AUX := '';
  AUX2 := '';
end;

Function tGetVersionFields.ParseText(data: TStringList; lookFor: string): boolean;
var
  parse: TStringList;
begin
  try
    parse := TStringList.Create;
    Reset;
    parse.CaseSensitive := false;
    parse.Delimiter := ',';
    parse.DelimitedText := data.Values[lookFor];

    parse.StrictDelimiter := true;
    try
      Component := lookFor; // we defind this already above

      if parse.Count >= 1 then
        Major := parse[0];

      if parse.Count >= 2 then
        Minor := parse[1];

      if parse.Count >= 3 then
        Build := parse[2];

      if parse.Count >= 4 then
        AUX := parse[3];

      if parse.Count >= 5 then
        AUX2 := parse[4];

      result := true;
    except
      on e: exception do
      begin
        Reset;
        result := false;
      end;
    end;
  finally
    freeandnil(parse);
  end;
end;

Constructor tGetVersion.Create;
begin
  inherited;
  fCommand := sGetVersion;
  fDescription := 'Get the version information for the system software and hardware';
  Reset;
end;

Destructor tGetVersion.Destroy;
begin
  inherited;
end;

procedure tGetVersion.Reset;
begin
  fBaseID.Reset;
  fBeehive_URL.Reset;
  fBlowerType.Reset;
  fBootloader_Version.Reset;
  fBrushMotorResistorPowerRating.Reset;
  fBrushMotorResistorResistance.Reset;
  fBrushMotorType.Reset;
  fBrushSpeed.Reset;
  fBrushSpeedEco.Reset;
  fChassisRev.Reset;
  fDropSensorType.Reset;
  fLCD_Panel.Reset;
  fLDS_CPU.Reset;
  fLDS_Serial.Reset;
  fLDS_Software.Reset;
  fLDSMotorType.Reset;
  fLocale.Reset;
  fMagSensorType.Reset;
  fMainBoard_Serial_Number.Reset;
  fMainBoard_Version.Reset;
  fModel.Reset;
  fNTP_URL.Reset;
  fNucleo_URL.Reset;
  fQAState.Reset;
  fSerial_Number.Reset;
  fSideBrushPower.Reset;
  fSideBrushType.Reset;
  fSmartBatt_Authorization.Reset;
  fSmartBatt_Data_Version.Reset;
  fSmartBatt_Device_Chemistry.Reset;
  fSmartBatt_Device_Name.Reset;
  fSmartBatt_Manufacturer_Name.Reset;
  fSmartBatt_Mfg_Year_Month_Day.Reset;
  fSmartBatt_Serial_Number.Reset;
  fSmartBatt_Software_Version.Reset;
  fSoftware_Git_SHA.Reset;
  fSoftware.Reset;
  fTime_Local.Reset;
  fTime_UTC.Reset;
  fUI_Board_Hardware.Reset;
  fUI_Board_Software.Reset;
  fUI_Name.Reset;
  fUI_Version.Reset;
  fVacuumPwr.Reset;
  fVacuumPwrEco.Reset;
  fWallSensorType.Reset;
  fWheelPodType.Reset;
  inherited;
end;

function tGetVersion.ParseText(data: TStringList): boolean;
// this is a 3 field wide data set so things are differently done
var
  lineData: TStringList;
  IDX: integer;

begin
  Reset;

  result := false;

  if NOT assigned(data) then
    exit;

  if data.count<2 then
   exit;

  lineData := TStringList.Create;
  lineData.Delimiter := ',';


  lineData.DelimitedText := data.Strings[1]; // grab header row

  // Simple test to make sure we got data

  if lineData[0] = sComponent then
  begin
    lineData.Text := data.Text;
    lineData.Delete(0); // strip off heaer row, no longe needed

    for IDX := 0 to lineData.Count - 1 do
      lineData[IDX] := stringreplace(lineData[IDX], ',', '=', []);

    fBaseID.ParseText(lineData, sBaseID);
    fBeehive_URL.ParseText(lineData, sBeehive_URL);
    fBlowerType.ParseText(lineData, sBlowerType);
    fBootloader_Version.ParseText(lineData, sBootloader_Version);
    fBrushMotorResistorPowerRating.ParseText(lineData, sBrushMotorResistorPowerRating);
    fBrushMotorResistorResistance.ParseText(lineData, sBrushMotorResistorResistance);
    fBrushMotorType.ParseText(lineData, sBrushMotorType);
    fBrushSpeed.ParseText(lineData, sBrushSpeed);
    fBrushSpeedEco.ParseText(lineData, sBrushSpeedEco);
    fChassisRev.ParseText(lineData, sChassisRev);
    fDropSensorType.ParseText(lineData, sDropSensorType);
    fLCD_Panel.ParseText(lineData, sLCD_Panel);
    fLDS_CPU.ParseText(lineData, sLDS_CPU);
    fLDS_Serial.ParseText(lineData, sLDS_Serial);
    fLDS_Software.ParseText(lineData, sLDS_Software);
    fLDSMotorType.ParseText(lineData, sLDSMotorType);
    fLocale.ParseText(lineData, sLocale);
    fMagSensorType.ParseText(lineData, sMagSensorType);
    fMainBoard_Serial_Number.ParseText(lineData, sMainBoard_Serial_Number);
    fMainBoard_Version.ParseText(lineData, sMainBoard_Version);
    fModel.ParseText(lineData, sModel);
    fNTP_URL.ParseText(lineData, sNTP_URL);
    fNucleo_URL.ParseText(lineData, sNucleo_URL);
    fQAState.ParseText(lineData, sQAState);
    fSerial_Number.ParseText(lineData, sSerial_Number);
    fSideBrushPower.ParseText(lineData, sSideBrushPower);
    fSideBrushType.ParseText(lineData, sSideBrushType);
    fSmartBatt_Authorization.ParseText(lineData, sSmartBatt_Authorization);
    fSmartBatt_Data_Version.ParseText(lineData, sSmartBatt_Data_Version);
    fSmartBatt_Device_Chemistry.ParseText(lineData, sSmartBatt_Device_Chemistry);
    fSmartBatt_Device_Name.ParseText(lineData, sSmartBatt_Device_Name);
    fSmartBatt_Manufacturer_Name.ParseText(lineData, sSmartBatt_Manufacturer_Name);
    fSmartBatt_Mfg_Year_Month_Day.ParseText(lineData, sSmartBatt_Mfg_Year_Month_Day);
    fSmartBatt_Serial_Number.ParseText(lineData, sSmartBatt_Serial_Number);
    fSmartBatt_Software_Version.ParseText(lineData, sSmartBatt_Software_Version);
    fSoftware_Git_SHA.ParseText(lineData, sSoftware_Git_SHA);
    fSoftware.ParseText(lineData, sSoftware);
    fTime_Local.ParseText(lineData, sTime_Local);
    fTime_UTC.ParseText(lineData, sTime_UTC);
    fUI_Board_Hardware.ParseText(lineData, sUI_Board_Hardware);
    fUI_Board_Software.ParseText(lineData, sUI_Board_Software);
    fUI_Name.ParseText(lineData, sUI_Name);
    fUI_Version.ParseText(lineData, sUI_Version);
    fVacuumPwr.ParseText(lineData, sVacuumPwr);
    fVacuumPwrEco.ParseText(lineData, sVacuumPwrEco);
    fWallSensorType.ParseText(lineData, sWallSensorType);
    fWheelPodType.ParseText(lineData, sWheelPodType);
    // replaces only FIRST , with an =

    result := true;
  end
  else
  begin
    fError := nParseTextError;
    result := false;
  end;

  freeandnil(lineData);
end;

end.
