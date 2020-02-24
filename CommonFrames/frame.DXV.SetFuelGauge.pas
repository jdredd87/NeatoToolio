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
  System.Rtti, FMX.Grid.Style, FMX.Grid, FMX.ScrollBox, FMX.Objects, FMX.Ani, FMX.Layouts;

type
  TframeDXVSetFuelGauge = class(TframeMaster)
    tbSetFuelGauge: TTrackBar;
    lblSetFuelGauge: TLabel;
    lblSetFuelGaugeError: TLabel;
    procedure tbSetFuelGaugeChange(Sender: TObject);
    procedure timer_getdataTimer(Sender: TObject);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; Rect: TRectangle); reintroduce; overload;
    procedure check;
  end;

implementation

{$R *.fmx}

constructor TframeDXVSetFuelGauge.Create(AOwner: TComponent; Rect: TRectangle);
begin
  inherited Create(AOwner, Rect);
  lblFrameTitle.Text := sDescription;
end;

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
    lblSetFuelGauge.Text := 'Fuel ' + ROUND(tbSetFuelGauge.Value).ToString + '%';
    lblSetFuelGaugeError.Text := '';
  end
  else
  begin
    lblSetFuelGaugeError.Text := pSetFuelGauge.Error;
  end;

  pReadData.Free;
  pSetFuelGauge.Free;

end;

procedure TframeDXVSetFuelGauge.timer_getdataTimer(Sender: TObject);
begin
  inherited;
//
end;

procedure TframeDXVSetFuelGauge.check;
begin
  //
end;

end.
