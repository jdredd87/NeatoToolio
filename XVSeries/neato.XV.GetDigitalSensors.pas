unit neato.XV.GetDigitalSensors;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors,
  neato.Helpers;

const
  sDescription = 'Get the state of the digital sensors';

  // labels of text to look / parse for
  sDigitalSensorName = 'Digital Sensor Name';
  sValue = ' Value'; // bug in neato, has leading space, derp

  sSNSR_DC_JACK_IS_IN = 'SNSR_DC_JACK_IS_IN';
  sSNSR_DUSTBIN_IS_IN = 'SNSR_DUSTBIN_IS_IN';
  sSNSR_LEFT_WHEEL_EXTENDED = 'SNSR_LEFT_WHEEL_EXTENDED';
  sSNSR_RIGHT_WHEEL_EXTENDED = 'SNSR_RIGHT_WHEEL_EXTENDED';
  sLSIDEBIT = 'LSIDEBIT';
  sLFRONTBIT = 'LFRONTBIT';
  sRSIDEBIT = 'RSIDEBIT';
  sRFRONTBIT = 'RFRONTBIT';

  // Command to send

  sGetDigitalSensors = 'GetDigitalSensors';



type

  tGetDigitalSensorsXV = class(tNeatoBaseCommand)
  private

    fSNSR_DC_JACK_IS_IN: tNeatoNameValuePair;
    fSNSR_DUSTBIN_IS_IN: tNeatoNameValuePair;
    fSNSR_LEFT_WHEEL_EXTENDED: tNeatoNameValuePair;
    fSNSR_RIGHT_WHEEL_EXTENDED: tNeatoNameValuePair;
    fLSIDEBIT: tNeatoNameValuePair;
    fLFRONTBIT: tNeatoNameValuePair;
    fRSIDEBIT: tNeatoNameValuePair;
    fRFRONTBIT: tNeatoNameValuePair;

  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: tstringlist): Boolean; override;
    property SNSR_DC_JACK_IS_IN: tNeatoNameValuePair read fSNSR_DC_JACK_IS_IN;
    property SNSR_DUSTBIN_IS_IN: tNeatoNameValuePair read fSNSR_DUSTBIN_IS_IN;
    property SNSR_LEFT_WHEEL_EXTENDED: tNeatoNameValuePair read fSNSR_LEFT_WHEEL_EXTENDED;
    property SNSR_RIGHT_WHEEL_EXTENDED: tNeatoNameValuePair read fSNSR_RIGHT_WHEEL_EXTENDED;
    property LSIDEBIT: tNeatoNameValuePair read fLSIDEBIT;
    property LFRONTBIT: tNeatoNameValuePair read fLFRONTBIT;
    property RSIDEBIT: tNeatoNameValuePair read fRSIDEBIT;
    property RFRONTBIT: tNeatoNameValuePair read fRFRONTBIT;
  end;

implementation

Constructor tGetDigitalSensorsXV.Create;
begin
  inherited;
  fCommand := sGetDigitalSensors;
  fDescription := sDescription;
  Reset;
end;

Destructor tGetDigitalSensorsXV.Destroy;
begin
  inherited;
end;

procedure tGetDigitalSensorsXV.Reset;
begin
  fSNSR_DC_JACK_IS_IN.ValueBoolean := false;
  fSNSR_DUSTBIN_IS_IN.ValueBoolean := false;
  fSNSR_LEFT_WHEEL_EXTENDED.ValueBoolean := false;
  fSNSR_RIGHT_WHEEL_EXTENDED.ValueBoolean := false;
  fLSIDEBIT.ValueBoolean := false;
  fLFRONTBIT.ValueBoolean := false;
  fRSIDEBIT.ValueBoolean := false;
  fRFRONTBIT.ValueBoolean := false;
  inherited;
end;

function tGetDigitalSensorsXV.ParseText(data: tstringlist): Boolean;
// this is a 3 field wide data set so things are differently done
var
  lineData: tstringlist;
begin
  Reset;

  result := false;

  if NOT assigned(data) then
    exit;

  data.Text := stringreplace(data.Text, ',', '=', [rfreplaceall]);

  lineData := tstringlist.Create;
  lineData.Text := data.Text;

  // Simple test to make sure we got data

  if lineData.Values[sDigitalSensorName] = sValue then
  begin
    GetSubDataNameValuePair(lineData, fSNSR_DC_JACK_IS_IN, sSNSR_DC_JACK_IS_IN, varBoolean);
    GetSubDataNameValuePair(lineData, fSNSR_DUSTBIN_IS_IN, sSNSR_DUSTBIN_IS_IN, varBoolean);
    GetSubDataNameValuePair(lineData, fSNSR_LEFT_WHEEL_EXTENDED, sSNSR_LEFT_WHEEL_EXTENDED, varBoolean);
    GetSubDataNameValuePair(lineData, fSNSR_RIGHT_WHEEL_EXTENDED, sSNSR_RIGHT_WHEEL_EXTENDED, varBoolean);
    GetSubDataNameValuePair(lineData, fLSIDEBIT, sLSIDEBIT, varBoolean);
    GetSubDataNameValuePair(lineData, fLFRONTBIT, sLFRONTBIT, varBoolean);
    GetSubDataNameValuePair(lineData, fRSIDEBIT, sRSIDEBIT, varBoolean);
    GetSubDataNameValuePair(lineData, fRFRONTBIT, sRFRONTBIT, varBoolean);
    result := true;
  end
  else
  begin
    fError := strParseTextError;
    result := false;
  end;

  freeandnil(lineData);
end;

end.
