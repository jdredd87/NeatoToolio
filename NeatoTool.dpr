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
  Neato.D.Commands in 'DSeries\Neato.D.Commands.pas',
  Neato.D.errors in 'DSeries\Neato.D.errors.pas',
  Neato.D.GetAccel in 'DSeries\Neato.D.GetAccel.pas',
  Neato.D.GetAnalogSensors in 'DSeries\Neato.D.GetAnalogSensors.pas',
  Neato.D.GetMotors in 'DSeries\Neato.D.GetMotors.pas',
  Neato.D.GetDigitalSensors in 'DSeries\Neato.D.GetDigitalSensors.pas',
  Neato.D.GetErr in 'DSeries\Neato.D.GetErr.pas',
  Neato.D.GetLDSScan in 'DSeries\Neato.D.GetLDSScan.pas',
  Neato.D.GetVersion in 'DSeries\Neato.D.GetVersion.pas',
  Neato.D.TestLDS in 'DSeries\Neato.D.TestLDS.pas',
  Neato.D.Helpers in 'DSeries\Neato.D.Helpers.pas',
  Neato.D.Settings in 'DSeries\Neato.D.Settings.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;

end.
