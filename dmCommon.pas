unit dmCommon;

interface

uses
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
  FMX.Objects;

type
  TNeatoModels = (XV, BotVac, BotVacConnected, neatoUnknown);

  TTimerList = TObjectList<TTimer>;

  Tdm = class(TDataModule)
    StyleBook: TStyleBook;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
{$IFDEF MSWINDOWS}
    COM: TdmSerial; // COM, Communicaitons level depending on OS
{$ENDIF}
    chkTestmode: tcheckbox; // allows frames to access the main form object easily!

    ActiveTab: TTabItem;
    log: tmemo;
  end;

var

  dm: Tdm; // common datamodule

  TimerList: TTimerList; // object list of TTimers
  CurrentTimer: TTimer; // quickly know what the active TTimer is
  NeatoType: TNeatoModels; // what kind of bot model line
  timerStarter: TTimer;
  onTabChangeEvent: TNotifyEvent;

procedure StopTimers; // stops all running registered timers

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  COM := TdmSerial.Create(self);
  ActiveTab := nil;
end;

procedure Tdm.DataModuleDestroy(Sender: TObject);
begin
  freeandnil(COM);
end;

procedure StopTimers;
var
  idx: integer;
  i: integer;
begin

  if assigned(timerStarter) then
    if timerStarter <> nil then
      timerStarter.Enabled := false;

  // this below I think can be phased out
  // having a TimerList
  // will keep it around , for now...

  {
    if not assigned(TimerList) then
    exit;

    for idx := 0 to TimerList.Count - 1 do
    try
    if assigned(TimerList[idx]) then
    TimerList[idx].Enabled := false;
    except
    on e: exception do
    begin
    i := idx;
    end;
    end;
  }
end;

initialization

NeatoType := neatoUnknown;
TimerList := TTimerList.Create(false);
CurrentTimer := nil;

finalization

StopTimers;
freeandnil(TimerList);

end.
