unit neato.GetWiFiInfo;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors, neato.helpers;

const

  // Command to send
  sGetWifiInfo = 'GetWifiInfo';
  sscanResultsReady = 'scan results ready'; // check for this


  iGetWifiInfoHeaderBreaks = 3; // number of ^Z to consider it finished reading

type

  tGetWifiInfoItem = class(tcollectionitem)
  strict private
    fSSID: String;
    fSignal: integer;
    fFrequency: integer;
    fBSSID: string; // mac address
  public
    property SSID: String read fSSID write fSSID;
    property Signal: integer read fSignal write fSignal;
    property Frequency: integer read fFrequency write fFrequency;
    property BSSID: String read fBSSID write fBSSID;
  end;

  tGetWifiInfoItems = Class(tcollection)
  private
    Function GetItem(index: integer): tGetWifiInfoItem;
  public
    Function Add: tGetWifiInfoItem;
    Property Item[Index: integer]: tGetWifiInfoItem read GetItem;
  end;

  tGetWifiInfo = class(tNeatoBaseCommand)
  private
    fGetWifiInfoItems: tGetWifiInfoItems;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: tstringlist): boolean; override;
    property GetWifiInfoItems: tGetWifiInfoItems read fGetWifiInfoItems write fGetWifiInfoItems;
  end;

implementation

Function tGetWifiInfoItems.GetItem(index: integer): tGetWifiInfoItem;
begin
  result := inherited Items[index] as tGetWifiInfoItem;
end;

Function tGetWifiInfoItems.Add: tGetWifiInfoItem;
begin
  result := inherited Add as tGetWifiInfoItem;
end;

Constructor tGetWifiInfo.Create;
begin
  inherited;
  fCommand := sGetWifiInfo;
  fDescription := 'Get a list of available wifi networks';
  fGetWifiInfoItems := tGetWifiInfoItems.Create(tGetWifiInfoItem);
  Reset;
end;

Destructor tGetWifiInfo.Destroy;
begin
  inherited;
end;

procedure tGetWifiInfo.Reset;
begin
  if assigned(fGetWifiInfoItems) then
    fGetWifiInfoItems.Clear;
  inherited;
end;

function tGetWifiInfo.ParseText(data: tstringlist): boolean;
var
  idx: integer;
  x: integer;
  wifiList: tstringlist;
  Item: tGetWifiInfoItem;
begin
  Reset;

  result := false;

  if NOT assigned(data) then
    exit;

  // Simple test to make sure we got data
  data.CaseSensitive := false;

  if pos(sscanResultsReady, data.Text) > 0 then // kind of lazy in this case with the bad response layout
  begin
    idx := data.IndexOf(sscanResultsReady);

    if idx > -1 then
    begin
      for x := idx downto 0 do
      begin
        data.Delete(x);
      end;

      // delete last 2 lines dont need them
      data.Delete(data.Count - 1);
      data.Delete(data.Count - 1);
      data.Delete(0); // delete header

      for idx := 0 to data.Count - 1 do
      begin
        wifiList := splitstring(data[idx], [','], false);

        if wifiList.Count = 4 then
        begin

          Item := fGetWifiInfoItems.Add;
          Item.SSID := wifiList[0].Trim;

          if Item.SSID = '\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00' then
            Item.SSID := '( Hidden Network )';

          try
            Item.Signal := strtoint(wifiList[1].Trim);
          except
            Item.Signal := -999;
          end;

          try
            Item.Frequency := strtoint(wifiList[2].Trim);
          except
            Item.Frequency := -999;
          end;
          Item.BSSID := wifiList[3].Trim;
          Item := nil;
        end;
        freeandnil(wifiList);
      end;
      result := true;
    end;

  end
  else
  begin
    fError := nParseTextError;
    result := false;
  end;

end;

{ getwifiinfo
  scanning...
  scan results callback:<3>CTRL-EVENT-SCAN-RESULTS
  scan results ready
  SSID                            ,Signal,   Frequency,                   BSSID
  lucidgl2                        ,   -18,        2427,       04:d4:c4:d2:39:00
  lucidgl2                        ,   -31,        5785,       04:d4:c4:d2:39:08
  lucidgl2                        ,   -37,        5200,       04:d4:c4:d2:39:04
  DIRECT-roku-639-13ABB8          ,   -38,        2462,       b8:3e:59:60:2e:77
  DIRECT-roku-745-1EE0F2          ,   -70,        5785,       0e:62:a6:f1:ef:9d
  DIRECT-roku-313-3A9488          ,   -71,        5785,       c6:98:5c:2f:04:ba
  DIRECT-roku-733-076D06          ,   -73,        5180,       ca:3a:6b:20:da:78
  DIRECT-roku-972-624488          ,   -74,        5180,       c2:d2:f3:63:55:46
  8 results

}

end.
