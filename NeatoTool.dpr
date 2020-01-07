program NeatoTool;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
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
  neato.GetCharger in 'neato.GetCharger.pas',
  neato.GetDigitalSensors in 'neato.GetDigitalSensors.pas',
  neato.GetErr in 'neato.GetErr.pas',
  neato.GetLDSScan in 'neato.GetLDSScan.pas',
  neato.GetVersion in 'neato.GetVersion.pas',
  neato.GetUsage in 'neato.GetUsage.pas',
  neato.Helpers in 'neato.Helpers.pas',
  neato.Settings in 'neato.Settings.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;

end.
