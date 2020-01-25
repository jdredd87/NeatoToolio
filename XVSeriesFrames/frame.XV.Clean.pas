unit frame.XV.Clean;

interface

uses
  dmCommon,
  neato.XV.Clean,
  neato.errors,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Objects;

type
  TframeXVClean = class(TFrame)
    btnCleanHouse: TButton;
    btnCleanSpot: TButton;
    btnCleanStop: TButton;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    procedure btnCleanClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Check;
  end;

implementation

{$R *.fmx}

procedure TframeXVClean.btnCleanClick(Sender: TObject);
var
  pReadData: TStringList;
  gRestoreDefaults: tCleanXV;
  r: boolean;
  command: string;
begin
  gRestoreDefaults := tCleanXV.Create;
  pReadData := TStringList.Create;

  if Sender = self.btnCleanHouse then
    command := sHouse;
  if Sender = self.btnCleanHouse then
    command := sSpot;
  if Sender = self.btnCleanHouse then
    command := sStop;

  pReadData.Text := dm.com.SendCommand(sClean + ' ' + sHouse);

  r := gRestoreDefaults.ParseText(pReadData);

  if not r then
    showmessage(strParseTextError);

  freeandnil(gRestoreDefaults);

  resetfocus;
end;

procedure TframeXVClean.Check;
begin
  btnCleanHouse.Enabled := dm.com.Serial.Active;
  btnCleanSpot.Enabled := dm.com.Serial.Active;
  btnCleanStop.Enabled := dm.com.Serial.Active;
end;

end.
