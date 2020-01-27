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
  FMX.Types,
  FMX.Controls,
  FMX.StdCtrls,
  FMX.TabControl,
  FMX.Objects;

type
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
  end;

var

  dm: Tdm; // common datamodule

  TimerList: TTimerList; // object list of TTimers
  CurrentTimer: TTimer; // quickly know what the active TTimer is

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
begin
  if not assigned(TimerList) then
    exit;

  for idx := 0 to TimerList.Count - 1 do
    if assigned(TimerList[idx]) then
      TimerList[idx].Enabled := false;
end;

initialization

TimerList := TTimerList.Create(false);
CurrentTimer := nil;

finalization

StopTimers;
freeandnil(TimerList);

end.
