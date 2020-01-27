unit frame.XV.GetDigitalSensors;

interface

uses
  dmCommon,
  neato.XV.GetDigitalSensors,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation, FMX.TabControl;

type
  TframeXVGetDigitalSensors = class(TFrame)
    swGetDigitalSensorsSNSR_DC_JACK_IS_INValue: TSwitch;
    lblGetDigitalSensorsSNSR_DC_JACK_IS_IN: TLabel;
    lblGetDigitalSensorsSNSR_DUSTBIN_IS_IN: TLabel;
    swGetDigitalSensorsSNSR_DUSTBIN_IS_INValue: TSwitch;
    lblGetDigitalSensorsSNSR_LEFT_WHEEL_EXTENDED: TLabel;
    swGetDigitalSensorsSNSR_LEFT_WHEEL_EXTENDEDValue: TSwitch;
    lblGetDigitalSensorsSNSR_RIGHT_WHEEL_EXTENDED: TLabel;
    swGetDigitalSensorsSNSR_RIGHT_WHEEL_EXTENDEDValue: TSwitch;
    swGetDigitalSensorsLFRONTBITValue: TSwitch;
    lblGetDigitalSensorsLFRONTBIT: TLabel;
    swGetDigitalSensorsLSIDEBITValue: TSwitch;
    lblGetDigitalSensorsLSIDEBIT: TLabel;
    timer_GetData: TTimer;
    swGetDigitalSensorsRFRONTBITValue: TSwitch;
    lblGetDigitalSensorsRFRONTBIT: TLabel;
    swGetDigitalSensorsRSIDEBITValue: TSwitch;
    lblGetDigitalSensorsRSIDEBIT: TLabel;
    procedure timer_GetDataTimer(Sender: TObject);
  private
    { Private declarations }
  public
   Tab : TTabItem;
  end;

implementation

{$R *.fmx}

procedure TframeXVGetDigitalSensors.timer_GetDataTimer(Sender: TObject);
var
  pGetDigitalSensors: tGetDigitalSensorsXV;
  pReadData: TStringList;
  r: Boolean;
begin

  if (dm.com.Serial.Active = false) or (dm.ActiveTab<>Tab) then
  begin
    timer_GetData.Enabled := false;
    exit;
  end;

  pGetDigitalSensors := tGetDigitalSensorsXV.Create;

  pReadData := TStringList.Create;
  pReadData.Text := dm.com.SendCommand(sGetDigitalSensors);

  r := pGetDigitalSensors.ParseText(pReadData);

  if r then
  begin
    swGetDigitalSensorsSNSR_DC_JACK_IS_INValue.IsChecked := pGetDigitalSensors.SNSR_DC_JACK_IS_IN.ValueBoolean;
    swGetDigitalSensorsSNSR_DUSTBIN_IS_INValue.IsChecked := pGetDigitalSensors.SNSR_DUSTBIN_IS_IN.ValueBoolean;
    swGetDigitalSensorsSNSR_LEFT_WHEEL_EXTENDEDValue.IsChecked := pGetDigitalSensors.SNSR_LEFT_WHEEL_EXTENDED.ValueBoolean;
    swGetDigitalSensorsSNSR_RIGHT_WHEEL_EXTENDEDValue.IsChecked := pGetDigitalSensors.SNSR_RIGHT_WHEEL_EXTENDED.ValueBoolean;

    swGetDigitalSensorsLSIDEBITValue.IsChecked := pGetDigitalSensors.LSIDEBIT.ValueBoolean;
    swGetDigitalSensorsLFRONTBITValue.IsChecked := pGetDigitalSensors.LFRONTBIT.ValueBoolean;

    swGetDigitalSensorsRSIDEBITValue.IsChecked := pGetDigitalSensors.RSIDEBIT.ValueBoolean;
    swGetDigitalSensorsRFRONTBITValue.IsChecked := pGetDigitalSensors.RFRONTBIT.ValueBoolean;
   end;

  pReadData.Free;
  pGetDigitalSensors.Free;
end;

end.
