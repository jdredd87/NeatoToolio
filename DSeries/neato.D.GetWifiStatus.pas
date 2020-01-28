unit neato.D.GetWifiStatus;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors, neato.helpers;

const

  sDescription = 'Get a list of available wifi networks';
  // Command to send
  sGetWifiStatus = 'GetWifiStatus';

  sEnabled = 'Enabled';
  sIPADDR = 'IPADDR';
  sWifi_Mode = 'Wifi Mode';
  sWifi_On_Init = 'Wifi On Init';
  sAP_Shutoff_in = 'AP Shutoff in';
  sAP_Desired = 'AP_Desired';
  sLinked_to_Beehive = 'Linked to Beehive';
  sNucleo_Connected = 'Nucleo Connected';
  sEZ_Connect_Message = 'EZ-Connect Message';
  sRobot_Name = 'Robot Name';
  sSSID = 'SSID';
  sScanning = 'Scanning';
  sSignalStrength = 'SignalStrength';
  sBSSID = 'BSSID';
  sBeehive_URL = 'Beehive URL';
  sNucleo_URL = 'Nucleo URL';
  sNTP_URL = 'NTP URL';
  sUTC_Offset = 'UTC Offset';
  sTime_Zone = 'Time Zone';

type

  tGetWifiStatusD = class(tNeatoBaseCommand)
  strict private
    fEnabled: boolean;
    fIPADDR: string;
    fWifi_Mode: string;
    fWifi_On_Init: boolean;
    fAP_Shutoff_in: string;
    fAP_Desired: boolean;
    fLinked_to_Beehive: boolean;
    fNucleo_Connected: boolean;
    fEZ_Connect_Message: string; // shows 0 now.. but not sure what other values we got yet
    fRobot_Name: string;
    fSSID: String;
    fScanning: String;
    fSignalStrength: integer;
    fBSSID: String;
    fBeehive_URL: string;
    fNucleo_URL: string;
    fNTP_URL: string;
    fUTC_Offset: string;
    fTime_Zone: string;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: tstringlist): boolean; override;
    property Enabled: boolean read fEnabled write fEnabled;
    property IPADDR: string read fIPADDR write fIPADDR;
    property Wifi_Mode: string read fWifi_Mode write fWifi_Mode;
    property Wifi_On_Init: boolean read fWifi_On_Init write fWifi_On_Init;
    property AP_Shutoff_in: string read fAP_Shutoff_in write fAP_Shutoff_in;
    property AP_Desired: boolean read fAP_Desired write fAP_Desired;
    property Linked_to_Beehive: boolean read fLinked_to_Beehive write fLinked_to_Beehive;
    property Nucleo_Connected: boolean read fNucleo_Connected write fNucleo_Connected;
    property EZ_Connect_Message: string read fEZ_Connect_Message write fEZ_Connect_Message;
    property Robot_Name: string read fRobot_Name write fRobot_Name;
    property SSID: String read fSSID write fSSID;
    property Scanning: String read fScanning write fScanning;
    property SignalStrength: integer read fSignalStrength write fSignalStrength;
    property BSSID: String read fBSSID write fBSSID;
    property Beehive_URL: string read fBeehive_URL write fBeehive_URL;
    property Nucleo_URL: string read fNucleo_URL write fNucleo_URL;
    property NTP_URL: string read fNTP_URL write fNTP_URL;
    property UTC_Offset: string read fUTC_Offset write fUTC_Offset;
    property Time_Zone: string read fTime_Zone write fTime_Zone;
  end;

implementation

Constructor tGetWifiStatusD.Create;
begin
  inherited;
  fCommand := sGetWifiStatus;
  fDescription := sDescription;
  Reset;
end;

Destructor tGetWifiStatusD.Destroy;
begin
  inherited;
end;

procedure tGetWifiStatusD.Reset;
begin
  fEnabled := false;
  fIPADDR := '';
  fWifi_Mode := '';
  fWifi_On_Init := false;
  fAP_Shutoff_in := '';
  fAP_Desired := false;
  fLinked_to_Beehive := false;
  fNucleo_Connected := false;
  fEZ_Connect_Message := ''; // shows 0 now.. but not sure what other values we got yet
  fRobot_Name := '';
  fSSID := '';
  fScanning := '';
  fSignalStrength := 0;
  fBSSID := '';
  fBeehive_URL := '';
  fNucleo_URL := '';
  fNTP_URL := '';
  fUTC_Offset := '';
  fTime_Zone := '';

  inherited;
end;

{
  getwifistatus
  Enabled, yes
  IPADDR, 192.168.50.17
  Wifi Mode, station
  Wifi On Init, yes
  AP Shutoff in, N/A
  AP Desired, no
  Linked to Beehive, yes
  Nucleo Connected, yes
  EZ-Connect Message, 0
  Robot Name, Wadsworth
  SSID, lucidgl2
  Scanning, N/A
  SignalStrength, -87
  BSSID, 04:d4:c4:d2:39:00
  Beehive URL, beehive.neatocloud.com
  Nucleo URL, nucleo.neatocloud.com
  NTP URL, pool.ntp.org
  UTC Offset, STD+5:00DST+4:00
  Time Zone, America/New_York
}

function tGetWifiStatusD.ParseText(data: tstringlist): boolean;
begin
  Reset;
  result := false;

  if NOT assigned(data) then
    exit;

  // Simple test to make sure we got data
  data.CaseSensitive := false;
  data.Text := stringreplace(data.Text, ',', '=', [rfreplaceall]);

  if pos(sEnabled, data.Text) > 0 then // kind of lazy in this case with the bad response layout
  begin
    fEnabled := trim(data.Values[sEnabled]) = 'yes';
    fIPADDR := trim(data.Values[sIPADDR]);
    fWifi_Mode := trim(data.Values[sWifi_Mode]);
    fWifi_On_Init := trim(data.Values[sWifi_On_Init]) = 'yes';
    fAP_Shutoff_in := trim(data.Values[sAP_Shutoff_in]);
    fAP_Desired := trim(data.Values[sAP_Desired]) = 'yes';
    fLinked_to_Beehive := trim(data.Values[sLinked_to_Beehive]) = 'yes';
    fNucleo_Connected := trim(data.Values[sNucleo_Connected]) = 'yes';
    fEZ_Connect_Message := trim(data.Values[sEZ_Connect_Message]);
    fRobot_Name := trim(data.Values[sRobot_Name]);
    fSSID := trim(data.Values[sSSID]);
    fScanning := trim(data.Values[sScanning]);

    try
      fSignalStrength := strtoint(trim(data.Values[sSignalStrength]));
    except
      fSignalStrength := 0;
    end;

    fBSSID := trim(data.Values[sBSSID]);
    fBeehive_URL := trim(data.Values[sBeehive_URL]);
    fNucleo_URL := trim(data.Values[sNucleo_URL]);
    fNTP_URL := trim(data.Values[sNTP_URL]);
    fUTC_Offset := trim(data.Values[sUTC_Offset]);
    fTime_Zone := trim(data.Values[sTime_Zone]);
    result := true;
  end
  else
  begin
    fError := strParseTextError;
    result := false;
  end;

end;

end.
