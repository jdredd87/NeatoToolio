unit neato.D.GetWiFiInfo;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors, neato.helpers;

const

  sDescription = 'Get a list of available wifi networks';
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

  tGetWifiInfoD = class(tNeatoBaseCommand)
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

Constructor tGetWifiInfoD.Create;
begin
  inherited;
  fCommand := sGetWifiInfo;
  fDescription := sDescription;
  fGetWifiInfoItems := tGetWifiInfoItems.Create(tGetWifiInfoItem);
  Reset;
end;

Destructor tGetWifiInfoD.Destroy;
begin
  inherited;
end;

procedure tGetWifiInfoD.Reset;
begin
  if assigned(fGetWifiInfoItems) then
    fGetWifiInfoItems.Clear;
  inherited;
end;

function tGetWifiInfoD.ParseText(data: tstringlist): boolean;
var
  idx: integer;
  x: integer;
  wifiList: tstringlist;
  Item: tGetWifiInfoItem;
begin
  try
    Reset;

    result := false;

    if NOT assigned(data) then
      exit;

    // Simple test to make sure we got data
    data.CaseSensitive := false;


    if (pos(sscanResultsReady, data.Text) > 0) or (pos(^Z, data.Text) > 0) then
    // kind of lazy in this case with the bad response layout
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

            if Item.SSID = '\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
            then
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
          end;
          freeandnil(wifiList);
        end;
        result := true;
      end;

    end
    else
    begin
      fError := strParseTextError;
      result := false;
    end;
  except
    on e: exception do
    begin
      fError := e.Message;
      result := false;
    end;
  end;

end;

end.
