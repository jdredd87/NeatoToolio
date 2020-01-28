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
    Panel1: TRectangle;
    btnLidarStart: TButton;
    FloatAnimation1: TFloatAnimation;
    procedure Timer_GetDataTimer(Sender: TObject);
    procedure btnLidarStartClick(Sender: TObject);
    procedure sgGetLDSScanDrawColumnCell(Sender: TObject; const Canvas: TCanvas; const Column: TColumn;
      const Bounds: TRectF; const Row: Integer; const Value: TValue; const State: TGridDrawStates);
  private
    { Private declarations }
  public
  end;

implementation

{$R *.fmx}

procedure TframeDXVGetLDSScan.btnLidarStartClick(Sender: TObject);
begin

  if NOT btnLidarStart.IsPressed then
  begin
    dm.com.SendCommand('Setldsrotation off');
    sleep(250);
    dm.com.SendCommand('Setldsrotation off');
    sleep(250);
    btnLidarStart.ResetFocus;
    btnLidarStart.Text := 'Start';
  end
  else
  begin

    dm.chkTestmode.IsChecked := true;
    sleep(250);
    dm.chkTestmode.IsChecked := true;
    sleep(250);
    dm.chkTestmode.IsChecked := true;
    sleep(250);
    dm.chkTestmode.IsChecked := true;
    sleep(250);
    dm.com.SendCommand('Setldsrotation on');
    sleep(250);
    dm.com.SendCommand('Setldsrotation on');
    sleep(250);
    dm.com.SendCommand('Setldsrotation on');
    sleep(250);
    dm.com.SendCommand('Setldsrotation on');
    sleep(250);
    dm.com.Serial.PurgeInput;
    dm.com.Serial.PurgeOutput;
    btnLidarStart.ResetFocus;
    btnLidarStart.Text := 'Stop';
  end;

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

  if (dm.com.Serial.Active = false) or (dm.ActiveTab <> Tab) then
  // (tabSensorsOptions.ActiveTab <> tabGetAccel) then
  begin
    btnLidarStart.IsPressed := false;
    btnLidarStartClick(Sender);
    Timer_GetData.Enabled := false;
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
