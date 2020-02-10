unit frame.DXV.GetLDSScan;

interface

uses
  frame.master,
  dmCommon,
  neato.DXV.GetLDSScan,
  neato.helpers, FMX.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, System.Math.Vectors, FMX.Types3D,
  FMX.Controls3D, FMX.Objects3D, FMX.Viewport3D, FMX.MaterialSources, FMX.Controls.Presentation, FMX.Layers3D,
  System.Rtti, FMX.Grid.Style, FMX.Grid, FMX.ScrollBox, FMX.Objects, FMX.Ani;

type
  TframeDXVGetLDSScan = class(TframeMaster)
    sgGetLDSScan: TStringGrid;
    sgGetLDSScanColumnAngleInDegrees: TStringColumn;
    sgGetLDSScanColumnDistInMM: TStringColumn;
    sgGetLDSScanColumnIntensity: TStringColumn;
    sgGetLDSScanColumnErrorCodeHEX: TStringColumn;
    lblGetLDSScanRotationSpeed: TLabel;
    lblGetLDSScanRotationSpeedValue: TLabel;
    FloatAnimation1: TFloatAnimation;
    procedure Timer_GetDataTimer(Sender: TObject);
    procedure sgGetLDSScanDrawColumnCell(Sender: TObject; const Canvas: TCanvas; const Column: TColumn;
      const Bounds: TRectF; const Row: Integer; const Value: TValue; const State: TGridDrawStates);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); reintroduce; overload;
    procedure check;
  end;

implementation

{$R *.fmx}

constructor TframeDXVGetLDSScan.Create(AOwner: TComponent);
begin
  inherited;
  lblFrameTitle.Text := sDescription;
end;

procedure TframeDXVGetLDSScan.check;
begin
  dm.chkTestmode.IsChecked := true;
  sleep(250);
  dm.com.SendCommand('Setldsrotation on');
  sleep(250);
//  timer_getdata.Enabled := true;
end;

procedure TframeDXVGetLDSScan.sgGetLDSScanDrawColumnCell(Sender: TObject; const Canvas: TCanvas; const Column: TColumn;
  const Bounds: TRectF; const Row: Integer; const Value: TValue; const State: TGridDrawStates);
var
  aRowColor: TBrush;
  aNewRectF: TRectF;
begin
  aRowColor := TBrush.Create(TBrushKind.Solid, TAlphaColors.Alpha);

  if (sgGetLDSScan.Cells[3, Row] <> '0') then
    aRowColor.Color := TAlphaColors.Red
  else
    aRowColor.Color := TAlphaColors.White;

  aNewRectF := Bounds;
  aNewRectF.Inflate(3, 3);
  Canvas.FillRect(aNewRectF, 0, 0, [], 1, aRowColor);
  Column.DefaultDrawCell(Canvas, Bounds, Row, Value, State);

  aRowColor.free;
end;

procedure TframeDXVGetLDSScan.Timer_GetDataTimer(Sender: TObject);
var
  pGetLDSScan: tGetLDSScanDXV;
  pReadData: TStringList;
  r: Boolean;
  idx: Integer;
begin

  if (dm.com.Active = false) or (dm.ActiveTab <> Tab) then
  begin
    timer_getdata.Enabled := false;
    exit;
  end;

  pGetLDSScan := tGetLDSScanDXV.Create;

  pReadData := TStringList.Create;
  pReadData.Text := dm.com.SendCommand(sGetLDSScan);

  r := pGetLDSScan.ParseText(pReadData);

  if r then
  begin
    lblGetLDSScanRotationSpeedValue.Text := pGetLDSScan.Rotation_Speed.ToString;
    sgGetLDSScan.BeginUpdate;
    sgGetLDSScan.Clear;
    sgGetLDSScan.RowCount := 360;
    for idx := 1 to 360 do
    begin
      sgGetLDSScan.Cells[0, idx - 1] := pGetLDSScan.GetLDSScanRecords[idx].AngleInDegrees.ToString;
      sgGetLDSScan.Cells[1, idx - 1] := pGetLDSScan.GetLDSScanRecords[idx].DistInMM.ToString;
      sgGetLDSScan.Cells[2, idx - 1] := pGetLDSScan.GetLDSScanRecords[idx].Intensity.ToString;
      sgGetLDSScan.Cells[3, idx - 1] := pGetLDSScan.GetLDSScanRecords[idx].ErrorCodeHEX.ToString;
    end;
    sgGetLDSScan.EndUpdate;
  end;

  pReadData.free;
  pGetLDSScan.free;
end;

end.
