unit neato.XV.GetVersion;

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

  iGetVersionRowCount = 25; // 25 fields were mapped out so far

  sModelID = 'ModelID';
  sConfigID = 'ConfigID';
  sSerial_Number = 'Serial Number';
  sSoftware = 'Software';
  sBatteryType = 'BatteryType';
  sBlowerType = 'BlowerType';
  sBrushSpeed = 'BrushSpeed';
  sBrushMotorType = 'BrushMotorType';
  sSideBrushType = 'SideBrushType';
  sWheelPodType = 'WheelPodType';
  sDropSensorType = 'DropSensorType';
  sMagSensorType = 'MagSensorType';
  sWallSensorType = 'WallSensorType';
  sLocale = 'Locale';
  sLDS_Software = 'LDS Software';
  sLDS_Serial = 'LDS Serial';
  sLDS_CPU = 'LDS CPU';
  sMainBoard_Vendor_ID = 'MainBoard Vendor ID';
  sMainBoard_Serial_Number = 'MainBoard Serial Number';
  sBootLoader_Software = 'BootLoader Software';
  sMainBoard_Software = 'MainBoard Software';
  sMainBoard_Boot = 'MainBoard Boot';
  sMainBoard_Version = 'MainBoard Version';
  sChassisRev = 'ChassisRev';
  sUIPanelRev = 'UIPanelRev';


  // Command to send

  sGetVersion = 'GetVersion';

type

  tGetVersionFieldsXV = record
    Component: String;
    Major: String;
    Minor: String;
    Build: String;
    procedure Reset;
    function ParseText(data: TStringList; lookFor: string): boolean;
  end;

  tGetVersionXV = class(tNeatoBaseCommand)
  private

    fModelID: tGetVersionFieldsXV;
    fConfigID: tGetVersionFieldsXV;
    fSerial_Number: tGetVersionFieldsXV;
    fSoftware: tGetVersionFieldsXV;
    fBatteryType: tGetVersionFieldsXV;
    fBlowerType: tGetVersionFieldsXV;
    fBrushSpeed: tGetVersionFieldsXV;
    fBrushMotorType: tGetVersionFieldsXV;
    fSideBrushType: tGetVersionFieldsXV;
    fWheelPodType: tGetVersionFieldsXV;
    fDropSensorType: tGetVersionFieldsXV;
    fMagSensorType: tGetVersionFieldsXV;
    fWallSensorType: tGetVersionFieldsXV;
    fLocale: tGetVersionFieldsXV;
    fLDS_Software: tGetVersionFieldsXV;
    fLDS_Serial: tGetVersionFieldsXV;
    fLDS_CPU: tGetVersionFieldsXV;
    fMainBoard_Vendor_ID: tGetVersionFieldsXV;
    fMainBoard_Serial_Number: tGetVersionFieldsXV;
    fBootLoader_Software: tGetVersionFieldsXV;
    fMainBoard_Software: tGetVersionFieldsXV;
    fMainBoard_Boot: tGetVersionFieldsXV;
    fMainBoard_Version: tGetVersionFieldsXV;
    fChassisRev: tGetVersionFieldsXV;
    fUIPanelRev: tGetVersionFieldsXV;

  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: TStringList): boolean; override;

    property ModelID: tGetVersionFieldsXV read fModelID write fModelID;
    property ConfigID: tGetVersionFieldsXV read fConfigID write fConfigID;
    property Serial_Number: tGetVersionFieldsXV read fSerial_Number write fSerial_Number;
    property Software: tGetVersionFieldsXV read fSoftware write fSoftware;
    property BatteryType: tGetVersionFieldsXV read fBatteryType write fBatteryType;
    property BlowerType: tGetVersionFieldsXV read fBlowerType write fBlowerType;
    property BrushSpeed: tGetVersionFieldsXV read fBrushSpeed write fBrushSpeed;
    property BrushMotorType: tGetVersionFieldsXV read fBrushMotorType write fBrushMotorType;
    property SideBrushType: tGetVersionFieldsXV read fSideBrushType write fSideBrushType;
    property WheelPodType: tGetVersionFieldsXV read fWheelPodType write fWheelPodType;
    property DropSensorType: tGetVersionFieldsXV read fDropSensorType write fDropSensorType;
    property MagSensorType: tGetVersionFieldsXV read fMagSensorType write fMagSensorType;
    property WallSensorType: tGetVersionFieldsXV read fWallSensorType write fWallSensorType;
    property Locale: tGetVersionFieldsXV read fLocale write fLocale;
    property LDS_Software: tGetVersionFieldsXV read fLDS_Software write fLDS_Software;
    property LDS_Serial: tGetVersionFieldsXV read fLDS_Serial write fLDS_Serial;
    property LDS_CPU: tGetVersionFieldsXV read fLDS_CPU write fLDS_CPU;
    property MainBoard_Vendor_ID: tGetVersionFieldsXV read fMainBoard_Vendor_ID write fMainBoard_Vendor_ID;
    property MainBoard_Serial_Number: tGetVersionFieldsXV read fMainBoard_Serial_Number write fMainBoard_Serial_Number;
    property BootLoader_Software: tGetVersionFieldsXV read fBootLoader_Software write fBootLoader_Software;
    property MainBoard_Software: tGetVersionFieldsXV read fMainBoard_Software write fMainBoard_Software;
    property MainBoard_Boot: tGetVersionFieldsXV read fMainBoard_Boot write fMainBoard_Boot;
    property MainBoard_Version: tGetVersionFieldsXV read fMainBoard_Version write fMainBoard_Version;
    property ChassisRev: tGetVersionFieldsXV read fChassisRev write fChassisRev;
    property UIPanelRev: tGetVersionFieldsXV read fUIPanelRev write fUIPanelRev;

  end;

implementation

Procedure tGetVersionFieldsXV.Reset;
begin
  Component := '';
  Major := '';
  Minor := '';
  Build := '';
end;

Function tGetVersionFieldsXV.ParseText(data: TStringList; lookFor: string): boolean;
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

Constructor tGetVersionXV.Create;
begin
  inherited;
  fCommand := sGetVersion;
  fDescription := sDescription;
  Reset;
end;

Destructor tGetVersionXV.Destroy;
begin
  inherited;
end;

procedure tGetVersionXV.Reset;
begin
  fModelID.Reset;
  fConfigID.Reset;
  fSerial_Number.Reset;
  fSoftware.Reset;
  fBatteryType.Reset;
  fBlowerType.Reset;
  fBrushSpeed.Reset;
  fBrushMotorType.Reset;
  fSideBrushType.Reset;
  fWheelPodType.Reset;
  fDropSensorType.Reset;
  fMagSensorType.Reset;
  fWallSensorType.Reset;
  fLocale.Reset;
  fLDS_Software.Reset;
  fLDS_Serial.Reset;
  fLDS_CPU.Reset;
  fMainBoard_Vendor_ID.Reset;
  fMainBoard_Serial_Number.Reset;
  fBootLoader_Software.Reset;
  fMainBoard_Software.Reset;
  fMainBoard_Boot.Reset;
  fMainBoard_Version.Reset;
  fChassisRev.Reset;
  fUIPanelRev.Reset;
  inherited;
end;

function tGetVersionXV.ParseText(data: TStringList): boolean;
// this is a 3 field wide data set so things are differently done
var
  lineData: TStringList;
  IDX: integer;

begin
  Reset;

  result := false;

  if NOT assigned(data) then
    exit;

  if data.Count < 2 then
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

    fModelID.ParseText(lineData, sModelID);
    fConfigID.ParseText(lineData, sConfigID);
    fSerial_Number.ParseText(lineData, sSerial_Number);
    fSoftware.ParseText(lineData, sSoftware);
    fBatteryType.ParseText(lineData, sBatteryType);
    fBlowerType.ParseText(lineData, sBlowerType );
    fBrushSpeed.ParseText(lineData, sBrushSpeed);
    fBrushMotorType.ParseText(lineData, sBrushMotorType);
    fSideBrushType.ParseText(lineData, sSideBrushType );
    fWheelPodType.ParseText(lineData, sWheelPodType );
    fDropSensorType.ParseText(lineData, sDropSensorType );
    fMagSensorType.ParseText(lineData, sMagSensorType);
    fWallSensorType.ParseText(lineData, sWallSensorType );
    fLocale.ParseText(lineData, sLocale );
    fLDS_Software.ParseText(lineData, sLDS_Software );
    fLDS_Serial.ParseText(lineData, sLDS_Serial );
    fLDS_CPU.ParseText(lineData, sLDS_CPU);
    fMainBoard_Vendor_ID.ParseText(lineData, sMainBoard_Vendor_ID);
    fMainBoard_Serial_Number.ParseText(lineData, sMainBoard_Serial_Number);
    fBootLoader_Software.ParseText(lineData, sBootLoader_Software );
    fMainBoard_Software.ParseText(lineData, sMainBoard_Software);
    fMainBoard_Boot.ParseText(lineData, sMainBoard_Boot );
    fMainBoard_Version.ParseText(lineData, sMainBoard_Version );
    fChassisRev.ParseText(lineData, sChassisRev);
    fUIPanelRev.ParseText(lineData, sUIPanelRev );

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
