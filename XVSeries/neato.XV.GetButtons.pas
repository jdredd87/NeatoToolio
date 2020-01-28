unit neato.XV.GetButtons;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors, neato.helpers;

const

  sdescription = 'Get the state of the UI Buttons.';

  // Command to send
  sGetButtons = 'GetButtons';

  sButton_NameUnfixed = 'Button Name';
  sButton_Name = 'ButtonName';
  sPressed = 'Pressed';

  sBTN_SOFT_KEY = 'BTN_SOFT_KEY';
  sBTN_SCROLL_UP = 'BTN_SCROLL_UP';
  sBTN_START = 'BTN_START';
  sBTN_BACK = 'BTN_BACK';
  sBTN_SCROLL_DOWN = 'BTN_SCROLL_DOWN';

type

  tGetButtonsXV = class(tNeatoBaseCommand)
  strict private
    fButton_Name: boolean;
    fBTN_SOFT_KEY: boolean;
    fBTN_SCROLL_UP: boolean;
    fBTN_START: boolean;
    fBTN_BACK: boolean;
    fBTN_SCROLL_DOWN: boolean;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: tstringlist): boolean; override;

    property BTN_SOFT_KEY: boolean read fBTN_SOFT_KEY write fBTN_SOFT_KEY;
    property BTN_SCROLL_UP: boolean read fBTN_SCROLL_UP write fBTN_SCROLL_UP;
    property BTN_START: boolean read fBTN_START write fBTN_START;
    property BTN_BACK: boolean read fBTN_BACK write fBTN_BACK;
    property BTN_SCROLL_DOWN: boolean read fBTN_SCROLL_DOWN write fBTN_SCROLL_DOWN;
  end;

implementation

Constructor tGetButtonsXV.Create;
begin
  inherited;
  fCommand := sGetButtons;
  fDescription := 'Get the state of the UI Buttons.';
  Reset;
end;

Destructor tGetButtonsXV.Destroy;
begin
  inherited;
end;

procedure tGetButtonsXV.Reset;
begin
  fButton_Name := false;
  fBTN_SOFT_KEY := false;
  fBTN_SCROLL_UP := false;
  fBTN_START := false;
  fBTN_BACK := false;
  fBTN_SCROLL_DOWN := false;
  inherited;
end;

function tGetButtonsXV.ParseText(data: tstringlist): boolean;
begin
  Reset;
  result := false;

  if NOT assigned(data) then
    exit;

  // Simple test to make sure we got data

  data.CaseSensitive := false;
  data.Text := stringreplace(data.Text, ',', '=', [rfreplaceall]);
  // looks like no spaces in the data but lets make sure
  data.Text := stringreplace(data.Text, ' ', '', [rfreplaceall]);

  if data.Values[sButton_Name] = sPressed then
  begin
    fBTN_SOFT_KEY := data.Values[sBTN_SOFT_KEY] = '1';
    fBTN_SCROLL_UP := data.Values[sBTN_SCROLL_UP] = '1';
    fBTN_START := data.Values[sBTN_START] = '1';
    fBTN_BACK := data.Values[sBTN_BACK] = '1';
    fBTN_SCROLL_DOWN := data.Values[sBTN_SCROLL_DOWN] = '1';
    result := true;
  end
  else
  begin
    fError := strParseTextError;
    result := false;
  end;

end;

end.
