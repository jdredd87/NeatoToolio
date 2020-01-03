program NeatoTool;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  System.StartUpCopy,
  FMX.Forms,
  dmSerial.Windows in 'dmSerial.Windows.pas' {dmSerial: TDataModule} ,
  formMain in 'formMain.pas' {frmMain} ,

  neato.Settings in 'neato.Settings.pas',
  neato.Commands in 'neato.Commands.pas',
  neato.errors in 'neato.errors.pas',
  neato.GetLDSScan in 'neato.GetLDSScan.pas',
  neato.GetCharger in 'neato.GetCharger.pas',
  neato.GetWarranty in 'neato.GetWarranty.pas',
  neato.Helpers in 'neato.Helpers.pas',

  XSuperJSON in 'XSuperJSON\XSuperJSON.pas',
  XSuperObject in 'XSuperJSON\XSuperObject.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;

end.
