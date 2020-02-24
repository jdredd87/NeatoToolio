unit dmCommon;

interface

uses
  syncobjs,
  dmSerial.Base,
{$IFDEF MSWINDOWS}
  dmSerial.Windows,
{$ENDIF}
{$IFDEF android}
  dmSerial.Android,
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
  FMX.Objects;
// Winsoft.FireMonkey.FComSignal, Winsoft.FireMonkey.FComPort;

type
  TNeatoModels = (XV, BotVac, BotVacConnected, neatoUnknown);

  TTimerList = TObjectList<TTimer>;

  Tdm = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    //
  public
    COM: TdmSerialBase; // COM, Communicaitons level depending on OS
    chkTestmode: tcheckbox; // allows frames to access the main form object easily!
    ActiveTab: TTabItem;
    log: tmemo;
    procedure TestModeON;
    procedure TestModeOFF;
    function GetNeatoType: integer; // used for scripts as issue with type exporting
    function isComSerial: boolean; // easy way to tell if using serial or tcpip
  end;

var

  dm: Tdm; // common datamodule
  ftimerStarter: TTimer;
  CurrentTimer: TTimer; // quickly know what the active TTimer is
  NeatoType: TNeatoModels; // what kind of bot model line
  onTabChangeEvent: TNotifyEvent;
  timerCS: TCriticalSection;

procedure StopTimers(NILEvent: boolean = false); // stop running timer
procedure SetTimer(T: TTimer);
procedure StartTimer;

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

function Tdm.isComSerial: boolean;
begin
  if assigned(dm.COM) then
{$IFDEF MSWINDOWS}
    result := dm.COM.ClassType = TdmSerialWindows;
{$ELSE}
    result := dm.COM.ClassType = TdmSerialAndroid;
{$ENDIF}
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

procedure SetTimer(T: TTimer);
begin
  timerCS.Enter;
  ftimerStarter := T;
  timerCS.Leave;
end;

procedure StartTimer;
begin
  timerCS.Enter;

  if assigned(ftimerStarter) then
  begin
    tthread.CreateAnonymousThread(
      procedure
      begin
        sleep(1000);
        tthread.Synchronize(tthread.CurrentThread,
          procedure
          begin
            try
              ftimerStarter.Enabled := true;
            except
              on e: exception do
              begin
                ftimerStarter := nil;
              end;
            end;
          end);
      end).start;
  end;

  timerCS.Leave;
end;

procedure StopTimers(NILEvent: boolean = false);
var
  idx: integer;
  i: integer;
begin
  timerCS.Enter;

  try
    if assigned(ftimerStarter) then
      if ftimerStarter <> nil then
        if assigned(ftimerStarter.OnTimer) then
        begin
          if NILEvent then
            ftimerStarter.OnTimer := nil;

          ftimerStarter.Enabled := false;
        end;
  except
    on e: exception do
    begin
      // eat the error for now
    end;
  end;

  timerCS.Leave;
end;

initialization

NeatoType := neatoUnknown;
CurrentTimer := nil;
timerCS := TCriticalSection.Create;

finalization

StopTimers;
timerCS.Free;

end.
