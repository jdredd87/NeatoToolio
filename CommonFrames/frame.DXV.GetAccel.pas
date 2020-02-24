unit frame.DXV.GetAccel;

interface

uses
  frame.master,
  dmCommon,
  neato.DXV.GetAccel,
  FMX.TabControl,
  FMX.Objects,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, System.Math.Vectors, FMX.Types3D,
  FMX.Controls3D, FMX.Objects3D, FMX.Viewport3D, FMX.MaterialSources, FMX.Controls.Presentation, FMX.Layers3D,
  FMX.Layouts;

type
  TframeDXVGetAccel = class(TframeMaster)
    view3dGetAccelValue: TViewport3D;
    lblGetAccelSumInG: TLabel;
    lblGetAccelSumInGValue: TLabel;
    lblGetAccelZInG: TLabel;
    lblGetAccelZInGValue: TLabel;
    lblGetAccelYInG: TLabel;
    lblGetAccelYInGValue: TLabel;
    lblGetAccelXInG: TLabel;
    lblGetAccelXInGValue: TLabel;
    lblGetAccelRollInDegrees: TLabel;
    lblGetAccelRollInDegreesValue: TLabel;
    lblGetAccelPitchInDegrees: TLabel;
    lblGetAccelPitchInDegreesValue: TLabel;
    _3DGetAccel: TImage3D;
    procedure Timer_GetDataTimer(Sender: TObject);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; Rect: TRectangle); reintroduce; overload;
    procedure check;
  end;

implementation

{$R *.fmx}

constructor TframeDXVGetAccel.Create(AOwner: TComponent; rect:trectangle);
begin
  inherited create(aowner,rect);
  lblFrameTitle.Text := sDescription;
end;

procedure TframeDXVGetAccel.Timer_GetDataTimer(Sender: TObject);
var
  pGetAccel: tGetAccelD;
  pReadData: TStringList;
  v: double;
  r: Boolean;
begin

  if (dm.com.Active = false) or (dm.ActiveTab <> Tab) then // (tabSensorsOptions.ActiveTab <> tabGetAccel) then
  begin
    Timer_GetData.Enabled := false;
    exit;
  end;

  pGetAccel := tGetAccelD.Create;

  pReadData := TStringList.Create;
  pReadData.Text := dm.com.SendCommand(sGetAccelD);
  pReadData.Text := stringreplace(pReadData.Text, ',', '=', [rfreplaceall]);

  r := pGetAccel.ParseText(pReadData);

  if r then
  begin
    lblGetAccelPitchInDegreesValue.Text := pGetAccel.PitchInDegrees.ToString;
    lblGetAccelRollInDegreesValue.Text := pGetAccel.RollInDegrees.ToString;
    lblGetAccelXInGValue.Text := pGetAccel.XInG.ToString;
    lblGetAccelYInGValue.Text := pGetAccel.YInG.ToString;
    lblGetAccelZInGValue.Text := pGetAccel.ZInG.ToString;
    lblGetAccelSumInGValue.Text := pGetAccel.SumInG.ToString;

    v := pGetAccel.RollInDegrees;

    if v > 0 then
      v := abs(v)
    else
      v := -abs(v);

    _3DGetAccel.RotationAngle.Y := v; // side to side

    v := pGetAccel.PitchInDegrees;

    if v > 0 then
      v := -abs(v)
    else
      v := abs(v);

    _3DGetAccel.RotationAngle.X := 270 + v; // front to back

  end;

  pReadData.Free;
  pGetAccel.Free;
end;

procedure TframeDXVGetAccel.check;
begin
  //
end;

end.
