unit neato.XV.SetLED;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors, dmCommon;

const

  sDescription = 'Sets the specified LED to on,off,blink, or dim. (TestMode Only)';
  // labels of text to look / parse for

  // Command to send

  sSetLED = 'SetLED';
  sBacklightOn = 'BacklightOn';
  sBacklightOff = 'BacklightOff';
  sButtonAmber = 'ButtonAmber';
  sButtonGreen = 'ButtonGreen';
  sLEDRed = 'LEDRed';
  sLEDGreen = 'LEDGreen';
  sButtonAmberDim = 'ButtonAmberDim';
  sButtonGreenDim = 'ButtonGreenDim';
  sButtonOff = 'ButtonOff';
  sBlinkOn = 'BlinkOn';
  sBlinkOff = 'BlinkOff';

  sBacklightOnMSG = 'LCD Backlight On  (mutually exclusive of BacklightOff)';
  sBacklightOffMSG = 'LCD Backlight Off (mutually exclusive of BacklightOn)';
  sButtonAmberMSG = 'Start Button Amber (mutually exclusive of other Button options)';
  sButtonGreenMSG = 'Start Button Green (mutually exclusive of other Button options)';
  sLEDRedMSG = 'Start Red LED (mutually exclusive of other Button options)';
  sLEDGreenMSG = 'Start Green LED (mutually exclusive of other Button options)';
  sButtonAmberDimMSG = 'Start Button LED Amber Dim (mutually exclusive of other Button options)';
  sButtonGreenDimMSG = 'Start Button LED Green Dim (mutually exclusive of other Button options)';
  sButtonOffMSG = 'Start Button LED Off';
  sBlinkOnMSG = 'Start the LED and LCD Blink';
  sBlinkOffMSG = 'Stop the LED and LCD Blink';

type
  tSetLEDXV = class(tNeatoBaseCommand)
  private
  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: tstringlist): boolean; override;
  end;

implementation

Constructor tSetLEDXV.Create;
begin
  inherited;
  fCommand := sSetLED;
  fDescription := sDescription;
  Reset;
end;

Destructor tSetLEDXV.Destroy;
begin
  inherited;
end;

procedure tSetLEDXV.Reset;
begin
  inherited;
end;

function tSetLEDXV.ParseText(data: tstringlist): boolean;
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
