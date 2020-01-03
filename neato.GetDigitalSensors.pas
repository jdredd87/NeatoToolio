unit neato.GetDigitalSensors;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors,
  neato.Helpers;

const
  // labels of text to look / parse for
  sDigitalSensorName = 'Digital Sensor Name';
  sValue = ' Value'; // bug in neato, has leading space, derp

  sSNSR_DC_JACK_IS_IN = 'SNSR_DC_JACK_IS_IN';
  sSNSR_DUSTBIN_IS_IN = 'SNSR_DUSTBIN_IS_IN';
  sSNSR_LEFT_WHEEL_EXTENDED = 'SNSR_LEFT_WHEEL_EXTENDED';
  sSNSR_RIGHT_WHEEL_EXTENDED = 'SNSR_RIGHT_WHEEL_EXTENDED';
  sLSIDEBIT = 'LSIDEBIT';
  sLFRONTBIT = 'LFRONTBIT';
  sLLDSBIT = 'LLDSBIT';
  sRSIDEBIT = 'RSIDEBIT';
  sRFRONTBIT = 'RFRONTBIT';
  sRLDSBIT = 'RLDSBIT';

  // Command to send

  sGetDigitalSensors = 'GetDigitalSensors';

type

  tGetDigitalSensors = class(tNeatoBaseCommand)
  private

    fSNSR_DC_JACK_IS_IN: tNeatoNameValuePair;
    fSNSR_DUSTBIN_IS_IN: tNeatoNameValuePair;
    fSNSR_LEFT_WHEEL_EXTENDED: tNeatoNameValuePair;
    fSNSR_RIGHT_WHEEL_EXTENDED: tNeatoNameValuePair;
    fLSIDEBIT: tNeatoNameValuePair;
    fLFRONTBIT: tNeatoNameValuePair;
    fLLDSBIT: tNeatoNameValuePair;
    fRSIDEBIT: tNeatoNameValuePair;
    fRFRONTBIT: tNeatoNameValuePair;
    fRLDSBIT: tNeatoNameValuePair;

  public
    constructor create;
    destructor destroy; override;
    procedure Reset; override;
    function ParseText(data: tstringlist): Boolean;
    property SNSR_DC_JACK_IS_IN: tNeatoNameValuePair read fSNSR_DC_JACK_IS_IN;
    property SNSR_DUSTBIN_IS_IN: tNeatoNameValuePair read fSNSR_DUSTBIN_IS_IN;
    property SNSR_LEFT_WHEEL_EXTENDED: tNeatoNameValuePair read fSNSR_LEFT_WHEEL_EXTENDED;
    property SNSR_RIGHT_WHEEL_EXTENDED: tNeatoNameValuePair read fSNSR_RIGHT_WHEEL_EXTENDED;
    property LSIDEBIT: tNeatoNameValuePair read fLSIDEBIT;
    property LFRONTBIT: tNeatoNameValuePair read fLFRONTBIT;
    property LLDSBIT: tNeatoNameValuePair read fLLDSBIT;
    property RSIDEBIT: tNeatoNameValuePair read fRSIDEBIT;
    property RFRONTBIT: tNeatoNameValuePair read fRFRONTBIT;
    property RLDSBIT: tNeatoNameValuePair read fRLDSBIT;
  end;

implementation

Constructor tGetDigitalSensors.create;
begin
  inherited;
  fCommand := sGetDigitalSensors;
  fDescription := 'Get the state of the digital sensors';
  Reset;
end;

Destructor tGetDigitalSensors.destroy;
begin
  inherited;
end;

procedure tGetDigitalSensors.Reset;
begin
  fSNSR_DC_JACK_IS_IN.ValueBoolean := false;
  fSNSR_DUSTBIN_IS_IN.ValueBoolean := false;
  fSNSR_LEFT_WHEEL_EXTENDED.ValueBoolean := false;
  fSNSR_RIGHT_WHEEL_EXTENDED.ValueBoolean := false;
  fLSIDEBIT.ValueBoolean := false;
  fLFRONTBIT.ValueBoolean := false;
  fLLDSBIT.ValueBoolean := false;
  fRSIDEBIT.ValueBoolean := false;
  fRFRONTBIT.ValueBoolean := false;
  fRLDSBIT.ValueBoolean := false;
  inherited;
end;

function tGetDigitalSensors.ParseText(data: tstringlist): Boolean;
// this is a 3 field wide data set so things are differently done
var
  lineData: tstringlist;
  IDX: integer;
  cIDX: integer;

begin
  Reset;

  result := false;

  if NOT assigned(data) then
    exit;

  data.Text := stringreplace(data.Text, ',', '=', [rfreplaceall]);

  lineData := tstringlist.create;
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
    GetSubDataNameValuePair(lineData, fLLDSBIT, sLLDSBIT, varBoolean);
    GetSubDataNameValuePair(lineData, fRSIDEBIT, sRSIDEBIT, varBoolean);
    GetSubDataNameValuePair(lineData, fRFRONTBIT, sRFRONTBIT, varBoolean);
    GetSubDataNameValuePair(lineData, fRLDSBIT, sRLDSBIT, varBoolean);
    result := true;
  end
  else
  begin
    fError := nParseTextError;
    result := false;
  end;

  freeandnil(lineData);
end;

end.
