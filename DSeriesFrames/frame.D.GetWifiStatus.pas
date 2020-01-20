unit frame.D.GetWifiStatus;

interface

uses
  dmCommon,
  neato.D.GetWifiStatus,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation;

type
  TframeDGetWifiStatus = class(TFrame)
    lblGetWifiStatusEnabled: TLabel;
    swGetWifiStatusEnabledValue: TSwitch;
    lblGetWifiStatusIPADDR: TLabel;
    lblGetWifiStatusIPADDRValue: TLabel;
    lblGetWifiStatusWifiMode: TLabel;
    lblGetWifiStatusWifiModeValue: TLabel;
    lblGetWifiStatusWifiOnInit: TLabel;
    swGetWifiStatusWifiOnInitValue: TSwitch;
    lblGetWifiStatusAPShutoffin: TLabel;
    lblGetWifiStatusAPShutoffinValue: TLabel;
    lblGetWifiStatusAPDesired: TLabel;
    swGetWifiStatusAPDesiredValue: TSwitch;
    lblGetWifiStatusLinkToBeehive: TLabel;
    swGetWifiStatusLinkToBeehiveValue: TSwitch;
    lblGetWifiStatusNucleoConnected: TLabel;
    swGetWifiStatusNucleoConnectedValue: TSwitch;
    lblGetWifiStatusEZConnectMessage: TLabel;
    lblGetWifiStatusEZConnectMessageValue: TLabel;
    lblGetWifiStatusRobotName: TLabel;
    lblGetWifiStatusRobotNameValue: TLabel;
    lblGetWifiStatusSSID: TLabel;
    lblGetWifiStatusSSIDValue: TLabel;
    lblGetWifiStatusScanning: TLabel;
    lblGetWifiStatusScanningValue: TLabel;
    lblGetWifiStatusSignalStrength: TLabel;
    lblGetWifiStatusSignalStrengthValue: TLabel;
    lblGetWifiStatusBSSID: TLabel;
    lblGetWifiStatusBSSIDValue: TLabel;
    lblGetWifiStatusBeehiveURL: TLabel;
    lblGetWifiStatusBeehiveURLValue: TLabel;
    lblGetWifiStatusNucleoURL: TLabel;
    lblGetWifiStatusNucleoURLValue: TLabel;
    lblGetWifiStatusNTPURL: TLabel;
    lblGetWifiStatusNTPURLValue: TLabel;
    lblGetWifiStatusUTCOffset: TLabel;
    lblGetWifiStatusUTCOffsetValue: TLabel;
    lblGetWifiStatusTimeZone: TLabel;
    lblGetWifiStatusTimeZoneValue: TLabel;
    timer_GetData: TTimer;
    procedure timer_GetDataTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

procedure TframeDGetWifiStatus.timer_GetDataTimer(Sender: TObject);
var
  pGetWifiStatus: tGetWifiStatusD;
  pReadData: TStringList;
  r: Boolean;
begin

  if (dm.com.Serial.Active = false) then
  begin
    timer_GetData
    .Enabled := false;
    exit;
  end;

  pGetWifiStatus := tGetWifiStatusD.Create;

  pReadData := TStringList.Create;
  pReadData.Text := dm.com.SendCommand(sGetWifiStatus);
  pReadData.Text := stringreplace(pReadData.Text, ',', '=', [rfreplaceall]);

  r := pGetWifiStatus.ParseText(pReadData);

  if r then
  begin

    lblGetWifiStatusIPADDRValue.Text := pGetWifiStatus.IPADDR;
    swGetWifiStatusEnabledValue.IsChecked := pGetWifiStatus.Enabled;
    lblGetWifiStatusWifiModeValue.Text := pGetWifiStatus.Wifi_Mode;
    swGetWifiStatusWifiOnInitValue.IsChecked := pGetWifiStatus.Wifi_On_Init;
    lblGetWifiStatusAPShutoffinValue.Text := pGetWifiStatus.AP_Shutoff_in;
    swGetWifiStatusAPDesiredValue.IsChecked := pGetWifiStatus.AP_Desired;
    swGetWifiStatusLinkToBeehiveValue.IsChecked := pGetWifiStatus.Linked_to_Beehive;
    swGetWifiStatusNucleoConnectedValue.IsChecked := pGetWifiStatus.Nucleo_Connected;
    lblGetWifiStatusEZConnectMessageValue.Text := pGetWifiStatus.EZ_Connect_Message;
    lblGetWifiStatusRobotNameValue.Text := pGetWifiStatus.Robot_Name;
    lblGetWifiStatusSSIDValue.Text := pGetWifiStatus.SSID;
    lblGetWifiStatusScanningValue.Text := pGetWifiStatus.Scanning;
    lblGetWifiStatusSignalStrengthValue.Text := pGetWifiStatus.SignalStrength.ToString;
    lblGetWifiStatusBSSIDValue.Text := pGetWifiStatus.BSSID;
    lblGetWifiStatusBeehiveURLValue.Text := pGetWifiStatus.Beehive_URL;
    lblGetWifiStatusNucleoURLValue.Text := pGetWifiStatus.Nucleo_URL;
    lblGetWifiStatusNTPURLValue.Text := pGetWifiStatus.NTP_URL;
    lblGetWifiStatusUTCOffsetValue.Text := pGetWifiStatus.UTC_Offset;
    lblGetWifiStatusTimeZoneValue.Text := pGetWifiStatus.Time_Zone;
  end;

  pReadData.Free;
  pGetWifiStatus.Free;
end;

end.
