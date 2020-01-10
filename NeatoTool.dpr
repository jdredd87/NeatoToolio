program NeatoTool;

uses
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  {$ifdef windows}
  madExcept,
  {$endif }
  System.StartUpCopy,
  FMX.Forms,
  dmSerial.Windows in 'dmSerial.Windows.pas' {dmSerial: TDataModule},
  formMain in 'formMain.pas' {frmMain},
  XSuperJSON in 'XSuperJSON\XSuperJSON.pas',
  XSuperObject in 'XSuperJSON\XSuperObject.pas',
  neato.Commands in 'neato.Commands.pas',
  neato.errors in 'neato.errors.pas',
  neato.GetAccel in 'neato.GetAccel.pas',
  neato.GetAnalogSensors in 'neato.GetAnalogSensors.pas',
  neato.GetMotors in 'neato.GetMotors.pas',
  neato.GetDigitalSensors in 'neato.GetDigitalSensors.pas',
  neato.GetErr in 'neato.GetErr.pas',
  neato.GetLDSScan in 'neato.GetLDSScan.pas',
  neato.GetVersion in 'neato.GetVersion.pas',
  neato.TestLDS in 'neato.TestLDS.pas',
  neato.Helpers in 'neato.Helpers.pas',
  neato.Settings in 'neato.Settings.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;

end.
