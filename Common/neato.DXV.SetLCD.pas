// This maybe same for XV and original BotVac Connected
// not 100% sure yet!

unit neato.DXV.SetLCD;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors, dmCommon;

const
  // labels of text to look / parse for

  // Command to send

  sSetLCD = 'SetLCD';

  sBGWhite = 'BGWhite';
  sBGBlack = 'BGBlack';

  sHLine = 'HLine';
  sVLine = 'VLine';

  sHBars = 'HBars';
  sVBars = 'VBars';

  sFGWhite = 'FGWhite';
  sFGBlack = 'FGBlack';

  sContrast = 'Contrast';

  /// ///

  sBGWhiteMSG = 'Fill LCD background with White';
  sBGBlackMSG = 'Fill LCD background with Black';

  sHLineMSG = 'Draw a horizontal line (in foreground color) at the following row';
  sVLineMSG = 'Draw a vertical line (in foreground color) at the following column';

  sHBarsMSG = 'Draw alternating horizontal lines (FG,BG,FG,BG,…),across the whole screen.';
  sVBarsMSG = 'Draw alternating vertical lines (FG,BG,FG,BG,…),across the whole screen.';

  sFGWhiteMSG = 'Use White as Foreground (line) color';
  sFGBlackMSG = 'Use Black as Foreground (line) color';

  sContrastMSG = 'Set the following value as the LCD Contrast';

type
  tSetLCD = class(tNeatoBaseCommand)
  private
  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: tstringlist): boolean; override;
  end;

implementation

Constructor tSetLCD.Create;
begin
  inherited;
  fCommand := sSetLCD;
  fDescription := 'Sets the LCD to the specified display. (TestMode Only)';
  Reset;
end;

Destructor tSetLCD.Destroy;
begin
  inherited;
end;

procedure tSetLCD.Reset;
begin
  inherited;
end;

function tSetLCD.ParseText(data: tstringlist): boolean;
begin
  Reset;

  result := false;

  if NOT assigned(data) then
    exit;

  // Simple test to make sure we got data

  data.text := trim(data.text);

  if data.Count = 1 then
   data.delete(0);

  if data.Count=0 then
  begin
    result := true;
  end
  else
  begin

    ferror := strParseTextError;
    result := false;
  end;

end;

end.
