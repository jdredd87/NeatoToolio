unit frame.DXV.SetFuelGauge;

interface

uses
 frame.master,
  dmCommon,
  neato.DXV.SetFuelGauge,
  neato.helpers, FMX.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, System.Math.Vectors, FMX.Types3D,
  FMX.Controls3D, FMX.Objects3D, FMX.Viewport3D, FMX.MaterialSources, FMX.Controls.Presentation, FMX.Layers3D,
  System.Rtti, FMX.Grid.Style, FMX.Grid, FMX.ScrollBox, FMX.Objects, FMX.Ani;

type
  TframeDXVSetFuelGauge = class(TframeMaster)
    tbSetFuelGauge: TTrackBar;
    lblSetFuelGauge: TLabel;
    lblSetFuelGaugeError: TLabel;
    procedure tbSetFuelGaugeChange(Sender: TObject);
  private
    { Private declarations }
  public
  end;

implementation

{$R *.fmx}

procedure TframeDXVSetFuelGauge.tbSetFuelGaugeChange(Sender: TObject);
var
  pSetFuelGauge: tSetFuelGauge;
  pReadData: TStringList;
  r: Boolean;
begin

  pSetFuelGauge := tSetFuelGauge.Create;

  pReadData := TStringList.Create;
  pReadData.Text := dm.com.SendCommand(sSetFuelGauge + ' ' + ROUND(tbSetFuelGauge.Value).ToString);

  r := pSetFuelGauge.ParseText(pReadData);

  if r then
  begin
    lblSetFuelGauge.Text := 'Fuel '+ROUND(tbSetFuelGauge.Value).ToString+'%';
    lblSetFuelGaugeError.Text := '';
  end
  else
  begin
    lblSetFuelGaugeError.Text := pSetFuelGauge.Error;
  end;

  pReadData.Free;
  pSetFuelGauge.Free;

end;

end.
