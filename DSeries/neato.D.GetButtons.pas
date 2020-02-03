unit neato.D.GetButtons;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors, neato.helpers;

const
  sDescription = 'Get the state of the UI Buttons.';

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
  sBTN_SPOT = 'BTN_SPOT';
  sIR_BTN_HOME = 'IR_BTN_HOME';
  sIR_BTN_SPOT = 'IR_BTN_SPOT';
  sIR_BTN_ECO = 'IR_BTN_ECO';
  sIR_BTN_UP = 'IR_BTN_UP';
  sIR_BTN_DOWN = 'IR_BTN_DOWN';
  sIR_BTN_RIGHT = 'IR_BTN_RIGHT';
  sIR_BTN_LEFT = 'IR_BTN_LEFT';
  sIR_BTN_START = 'IR_BTN_START';
  sIR_BTN_LEFT_ARC = 'IR_BTN_LEFT_ARC';
  sIR_BTN_RIGHT_ARC = 'IR_BTN_RIGHT_ARC';

type

  tGetButtonsD = class(tNeatoBaseCommand)
  strict private
    fButton_Name: boolean;
    fBTN_SOFT_KEY: boolean;
    fBTN_SCROLL_UP: boolean;
    fBTN_START: boolean;
    fBTN_BACK: boolean;
    fBTN_SCROLL_DOWN: boolean;
    fBTN_SPOT: boolean;
    fIR_BTN_HOME: boolean;
    fIR_BTN_SPOT: boolean;
    fIR_BTN_ECO: boolean;
    fIR_BTN_UP: boolean;
    fIR_BTN_DOWN: boolean;
    fIR_BTN_RIGHT: boolean;
    fIR_BTN_LEFT: boolean;
    fIR_BTN_START: boolean;
    fIR_BTN_LEFT_ARC: boolean;
    fIR_BTN_RIGHT_ARC: boolean;
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
    property BTN_SPOT: boolean read fBTN_SPOT write fBTN_SPOT;
    property IR_BTN_HOME: boolean read fIR_BTN_HOME write fIR_BTN_HOME;
    property IR_BTN_SPOT: boolean read fIR_BTN_SPOT write fIR_BTN_SPOT;
    property IR_BTN_ECO: boolean read fIR_BTN_ECO write fIR_BTN_ECO;
    property IR_BTN_UP: boolean read fIR_BTN_UP write fIR_BTN_UP;
    property IR_BTN_DOWN: boolean read fIR_BTN_DOWN write fIR_BTN_DOWN;
    property IR_BTN_RIGHT: boolean read fIR_BTN_RIGHT write fIR_BTN_RIGHT;
    property IR_BTN_LEFT: boolean read fIR_BTN_LEFT write fIR_BTN_LEFT;
    property IR_BTN_START: boolean read fIR_BTN_START write fIR_BTN_START;
    property IR_BTN_LEFT_ARC: boolean read fIR_BTN_LEFT_ARC write fIR_BTN_LEFT_ARC;
    property IR_BTN_RIGHT_ARC: boolean read fIR_BTN_RIGHT_ARC write fIR_BTN_RIGHT_ARC;
  end;

implementation

Constructor tGetButtonsD.Create;
begin
  inherited;
  fCommand := sGetButtons;
  fDescription := sDescription;
  Reset;
end;

Destructor tGetButtonsD.Destroy;
begin
  inherited;
end;

procedure tGetButtonsD.Reset;
begin
  fButton_Name := false;
  fBTN_SOFT_KEY := false;
  fBTN_SCROLL_UP := false;
  fBTN_START := false;
  fBTN_BACK := false;
  fBTN_SCROLL_DOWN := false;
  fBTN_SPOT := false;
  fIR_BTN_HOME := false;
  fIR_BTN_SPOT := false;
  fIR_BTN_ECO := false;
  fIR_BTN_UP := false;
  fIR_BTN_DOWN := false;
  fIR_BTN_RIGHT := false;
  fIR_BTN_LEFT := false;
  fIR_BTN_START := false;
  fIR_BTN_LEFT_ARC := false;
  fIR_BTN_RIGHT_ARC := false;
  inherited;
end;

function tGetButtonsD.ParseText(data: tstringlist): boolean;
begin
  try
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
      fBTN_SPOT := data.Values[sBTN_SPOT] = '1';
      fIR_BTN_HOME := data.Values[sIR_BTN_HOME] = '1';
      fIR_BTN_SPOT := data.Values[sIR_BTN_SPOT] = '1';
      fIR_BTN_ECO := data.Values[sIR_BTN_ECO] = '1';
      fIR_BTN_UP := data.Values[sIR_BTN_UP] = '1';
      fIR_BTN_DOWN := data.Values[sIR_BTN_DOWN] = '1';
      fIR_BTN_RIGHT := data.Values[sIR_BTN_RIGHT] = '1';
      fIR_BTN_LEFT := data.Values[sIR_BTN_LEFT] = '1';
      fIR_BTN_START := data.Values[sIR_BTN_START] = '1';
      fIR_BTN_LEFT_ARC := data.Values[sIR_BTN_LEFT_ARC] = '1';
      fIR_BTN_RIGHT_ARC := data.Values[sIR_BTN_RIGHT_ARC] = '1';
      result := true;
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
