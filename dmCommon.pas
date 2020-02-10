unit dmCommon;

interface

uses
  dmSerial.Base,
{$IFDEF MSWINDOWS}
  dmSerial.Windows,
{$ENDIF}
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.Rtti,
  Generics.Collections,
  FMX.Memo,
  FMX.Dialogs,
  FMX.Types,
  FMX.Controls,
  FMX.StdCtrls,
  FMX.TabControl,
  FMX.Objects, Winsoft.FireMonkey.FComSignal, Winsoft.FireMonkey.FComPort;

type
  TNeatoModels = (XV, BotVac, BotVacConnected, neatoUnknown);

  TTimerList = TObjectList<TTimer>;

  Tdm = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    //
  public
{$IFDEF MSWINDOWS}
    COM: TdmSerialBase; // COM, Communicaitons level depending on OS
{$ENDIF}
    chkTestmode: tcheckbox; // allows frames to access the main form object easily!
    ActiveTab: TTabItem;
    log: tmemo;
    procedure TestModeON;
    procedure TestModeOFF;
    function GetNeatoType: integer; // used for scripts as issue with type exporting
    function isComSerial : boolean; // easy way to tell if using serial or tcpip
  end;

var

  dm: Tdm; // common datamodule
  timerStarter: TTimer;
  CurrentTimer: TTimer; // quickly know what the active TTimer is
  NeatoType: TNeatoModels; // what kind of bot model line
  onTabChangeEvent: TNotifyEvent;

procedure StopTimers(NILEvent: Boolean = false); // stop running timer

implementation

uses dmSerial.TCPIP;

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  ActiveTab := nil;
end;

procedure Tdm.DataModuleDestroy(Sender: TObject);
begin
  if assigned(COM) then
    freeandnil(COM);
end;


procedure Tdm.TestModeON;
begin
  chkTestmode.ischecked := true;
end;

procedure Tdm.TestModeOFF;
begin
  chkTestmode.ischecked := false;
end;

function Tdm.isComSerial : boolean;
begin
 if assigned(dm.COM) then
   result := dm.COM.ClassType = TdmSerialWindows;
end;

function Tdm.GetNeatoType: integer;
begin

  case NeatoType of
    XV:
      result := 0;
    BotVac:
      result := 1;
    BotVacConnected:
      result := 2;
    neatoUnknown:
      result := -1;
  end;

end;

procedure StopTimers(NILEvent: Boolean = false);
var
  idx: integer;
  i: integer;
begin

  try
    if assigned(timerStarter) then
      if timerStarter <> nil then
        if assigned(timerStarter.OnTimer) then
        begin
          if NILEvent then
            timerStarter.OnTimer := nil;

          timerStarter.Enabled := false;
        end;
  except
    on e: exception do
    begin
      // eat the error for now
    end;
  end;
end;

initialization

NeatoType := neatoUnknown;
CurrentTimer := nil;

finalization

StopTimers;


end.
