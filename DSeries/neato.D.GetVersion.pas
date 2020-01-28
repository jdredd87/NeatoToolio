unit neato.D.GetVersion;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors,
  neato.Helpers;

const
  sDescription = 'Get the version information for the system software and hardware';

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

  tGetVersionFieldsD = record
    Component: String;
    Major: String;
    Minor: String;
    Build: String;
    AUX: String;
    AUX2: String; // bug in neato response, where some fields like "software" has a 5th value. Derp.
    procedure Reset;
    function ParseText(data: TStringList; lookFor: string): boolean;
  end;

  tGetVersionD = class(tNeatoBaseCommand)
  private

    fBaseID: tGetVersionFieldsD;
    fBeehive_URL: tGetVersionFieldsD;
    fBlowerType: tGetVersionFieldsD;
    fBootloader_Version: tGetVersionFieldsD;
    fBrushMotorResistorPowerRating: tGetVersionFieldsD;
    fBrushMotorResistorResistance: tGetVersionFieldsD;
    fBrushMotorType: tGetVersionFieldsD;
    fBrushSpeed: tGetVersionFieldsD;
    fBrushSpeedEco: tGetVersionFieldsD;
    fChassisRev: tGetVersionFieldsD;
    fDropSensorType: tGetVersionFieldsD;
    fLCD_Panel: tGetVersionFieldsD;
    fLDS_CPU: tGetVersionFieldsD;
    fLDS_Serial: tGetVersionFieldsD;
    fLDS_Software: tGetVersionFieldsD;
    fLDSMotorType: tGetVersionFieldsD;
    fLocale: tGetVersionFieldsD;
    fMagSensorType: tGetVersionFieldsD;
    fMainBoard_Serial_Number: tGetVersionFieldsD;
    fMainBoard_Version: tGetVersionFieldsD;
    fModel: tGetVersionFieldsD;
    fNTP_URL: tGetVersionFieldsD;
    fNucleo_URL: tGetVersionFieldsD;
    fQAState: tGetVersionFieldsD;
    fSerial_Number: tGetVersionFieldsD;
    fSideBrushPower: tGetVersionFieldsD;
    fSideBrushType: tGetVersionFieldsD;
    fSmartBatt_Authorization: tGetVersionFieldsD;
    fSmartBatt_Data_Version: tGetVersionFieldsD;
    fSmartBatt_Device_Chemistry: tGetVersionFieldsD;
    fSmartBatt_Device_Name: tGetVersionFieldsD;
    fSmartBatt_Manufacturer_Name: tGetVersionFieldsD;
    fSmartBatt_Mfg_Year_Month_Day: tGetVersionFieldsD;
    fSmartBatt_Serial_Number: tGetVersionFieldsD;
    fSmartBatt_Software_Version: tGetVersionFieldsD;
    fSoftware_Git_SHA: tGetVersionFieldsD;
    fSoftware: tGetVersionFieldsD;
    fTime_Local: tGetVersionFieldsD;
    fTime_UTC: tGetVersionFieldsD;
    fUI_Board_Hardware: tGetVersionFieldsD;
    fUI_Board_Software: tGetVersionFieldsD;
    fUI_Name: tGetVersionFieldsD;
    fUI_Version: tGetVersionFieldsD;
    fVacuumPwr: tGetVersionFieldsD;
    fVacuumPwrEco: tGetVersionFieldsD;
    fWallSensorType: tGetVersionFieldsD;
    fWheelPodType: tGetVersionFieldsD;

  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: TStringList): boolean; override;

    property BaseID: tGetVersionFieldsD Read fBaseID;
    property Beehive_URL: tGetVersionFieldsD Read fBeehive_URL;
    property BlowerType: tGetVersionFieldsD Read fBlowerType;
    property Bootloader_Version: tGetVersionFieldsD Read fBootloader_Version;
    property BrushMotorResistorPowerRating: tGetVersionFieldsD Read fBrushMotorResistorPowerRating;
    property BrushMotorResistorResistance: tGetVersionFieldsD Read fBrushMotorResistorResistance;
    property BrushMotorType: tGetVersionFieldsD Read fBrushMotorType;
    property BrushSpeed: tGetVersionFieldsD Read fBrushSpeed;
    property BrushSpeedEco: tGetVersionFieldsD Read fBrushSpeedEco;
    property ChassisRev: tGetVersionFieldsD Read fChassisRev;
    property DropSensorType: tGetVersionFieldsD Read fDropSensorType;
    property LCD_Panel: tGetVersionFieldsD Read fLCD_Panel;
    property LDS_CPU: tGetVersionFieldsD Read fLDS_CPU;
    property LDS_Serial: tGetVersionFieldsD Read fLDS_Serial;
    property LDS_Software: tGetVersionFieldsD Read fLDS_Software;
    property LDSMotorType: tGetVersionFieldsD Read fLDSMotorType;
    property Locale: tGetVersionFieldsD Read fLocale;
    property MagSensorType: tGetVersionFieldsD Read fMagSensorType;
    property MainBoard_Serial_Number: tGetVersionFieldsD Read fMainBoard_Serial_Number;
    property MainBoard_Version: tGetVersionFieldsD Read fMainBoard_Version;
    property Model: tGetVersionFieldsD Read fModel;
    property NTP_URL: tGetVersionFieldsD Read fNTP_URL;
    property Nucleo_URL: tGetVersionFieldsD Read fNucleo_URL;
    property QAState: tGetVersionFieldsD Read fQAState;
    property Serial_Number: tGetVersionFieldsD Read fSerial_Number;
    property SideBrushPower: tGetVersionFieldsD Read fSideBrushPower;
    property SideBrushType: tGetVersionFieldsD Read fSideBrushType;
    property SmartBatt_Authorization: tGetVersionFieldsD Read fSmartBatt_Authorization;
    property SmartBatt_Data_Version: tGetVersionFieldsD Read fSmartBatt_Data_Version;
    property SmartBatt_Device_Chemistry: tGetVersionFieldsD Read fSmartBatt_Device_Chemistry;
    property SmartBatt_Device_Name: tGetVersionFieldsD Read fSmartBatt_Device_Name;
    property SmartBatt_Manufacturer_Name: tGetVersionFieldsD Read fSmartBatt_Manufacturer_Name;
    property SmartBatt_Mfg_Year_Month_Day: tGetVersionFieldsD Read fSmartBatt_Mfg_Year_Month_Day;
    property SmartBatt_Serial_Number: tGetVersionFieldsD Read fSmartBatt_Serial_Number;
    property SmartBatt_Software_Version: tGetVersionFieldsD Read fSmartBatt_Software_Version;
    property Software_Git_SHA: tGetVersionFieldsD Read fSoftware_Git_SHA;
    property Software: tGetVersionFieldsD Read fSoftware;
    property Time_Local: tGetVersionFieldsD Read fTime_Local;
    property Time_UTC: tGetVersionFieldsD Read fTime_UTC;
    property UI_Board_Hardware: tGetVersionFieldsD Read fUI_Board_Hardware;
    property UI_Board_Software: tGetVersionFieldsD Read fUI_Board_Software;
    property UI_Name: tGetVersionFieldsD Read fUI_Name;
    property UI_Version: tGetVersionFieldsD Read fUI_Version;
    property VacuumPwr: tGetVersionFieldsD Read fVacuumPwr;
    property VacuumPwrEco: tGetVersionFieldsD Read fVacuumPwrEco;
    property WallSensorType: tGetVersionFieldsD Read fWallSensorType;
    property WheelPodType: tGetVersionFieldsD Read fWheelPodType;

  end;

implementation

Procedure tGetVersionFieldsD.Reset;
begin
  Component := '';
  Major := '';
  Minor := '';
  Build := '';
  AUX := '';
  AUX2 := '';
end;

Function tGetVersionFieldsD.ParseText(data: TStringList; lookFor: string): boolean;
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

Constructor tGetVersionD.Create;
begin
  inherited;
  fCommand := sGetVersion;
  fDescription := sDescription;
  Reset;
end;

Destructor tGetVersionD.Destroy;
begin
  inherited;
end;

procedure tGetVersionD.Reset;
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

function tGetVersionD.ParseText(data: TStringList): boolean;
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
    fError := strParseTextError;
    result := false;
  end;

  freeandnil(lineData);
end;

end.
