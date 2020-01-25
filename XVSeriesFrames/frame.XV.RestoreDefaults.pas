unit frame.XV.RestoreDefaults;

interface

uses
  dmCommon,
  neato.XV.RestoreDefaults,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation;

type
  TframeXVRestoreDefaults = class(TFrame)
    btnRestoreDefaults: TButton;
    procedure btnRestoreDefaultsClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Check;
  end;

implementation

{$R *.fmx}

procedure TframeXVRestoreDefaults.btnRestoreDefaultsClick(Sender: TObject);
var
  pReadData: TStringList;
  gRestoreDefaults: tRestoreDefaultsXV;
  r: boolean;
begin
  gRestoreDefaults := tRestoreDefaultsXV.Create;
  pReadData := TStringList.Create;
  pReadData.Text := dm.com.SendCommand(sRestoreDefaults);
  r := gRestoreDefaults.ParseText(pReadData);
  if r then
  begin
    showmessage('RestoreDefaults Completed');
  end
  else
    showmessage('RestoreDefaults did not complete');
  freeandnil(gRestoreDefaults);
  resetfocus;
end;

procedure TframeXVRestoreDefaults.Check;
begin
  btnRestoreDefaults.Enabled := dm.com.Serial.Active;
end;

end.
