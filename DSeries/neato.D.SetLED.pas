unit neato.D.SetLED;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors, dmCommon;

const

  sDescription = 'Sets the specified LED to on,off,blink, or dim. (TestMode Only)';
  // labels of text to look / parse for

  sSetLed = 'SetLED';
  // Command to send

  shome = 'home';
  shomeMsg = 'Set the home led (Neato only).';

  sspot = 'spot';
  sspotMsg = 'Set the spot led (Neato and VR220).';

  sinfo = 'info';
  sinfoMsg = 'Set the info led (Neato D3/D5 only).';

  swifi = 'wifi';
  swifiMsg = 'Set the wifi led(All D`s and Vr 220)';

  sbattery = 'battery';
  sbatteryMsg = 'Set the battery led(Neato only)';

  sls = 'ls';
  slsMsg = 'Set both the light shower leds (Vr220 only)';

  slsu = 'lsu';
  slsuMsg = 'Set the light shower upper led (Vr220 only)';

  slsd = 'lsd';
  slsdMsg = 'Set the light shower lower led (Vr220 only)';

  seco = 'eco';
  secoMsg = 'Set the eco led (Vr220 only)';

  sdoc = 'doc';
  sdocMsg = 'Set the docking led (Vr220 only)';

  scolor = 'color';
  scolorMsg = 'Set color, red, green, blue, yellow,amber, white w/o _dim. Only supported colors will respond.';

  spattern = 'pattern';
  spatternMsg =
    'Set pattern. solid, throb,throb_fast, blink_500, blink_3sec, blink_400,blink_fast, blink_300, blink_5sec';

  sSpecify = 'You need to specify at least one LED.';

type
  tSetLEDD = class(tNeatoBaseCommand)
  private
  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: tstringlist): boolean; override;
  end;

implementation

Constructor tSetLEDD.Create;
begin
  inherited;
  fCommand := sSetLED;
  fDescription := sDescription;
  Reset;
end;

Destructor tSetLEDD.Destroy;
begin
  inherited;
end;

procedure tSetLEDD.Reset;
begin
  inherited;
end;

function tSetLEDD.ParseText(data: tstringlist): boolean;
begin
  try
    Reset;

    result := false;

    if NOT assigned(data) then
      exit;

    // Simple test to make sure we got data

    data.text := trim(data.text);

    if data.Count = 1 then
      data.delete(0);

    if data.Count = 0 then
    begin
      result := true;
    end
    else
    begin
      ferror := strParseTextError;
      result := false;
    end;
  except
    on e: exception do
    begin
      ferror := e.Message;
      result := false;
    end;
  end;

end;

end.
