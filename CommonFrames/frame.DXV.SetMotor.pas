unit frame.DXV.SetMotor;

interface

uses
  frame.master,
  dmCommon,
  neato.Helpers,
  neato.DXV.SetMotor,
  FMX.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, System.Rtti, FMX.Grid.Style, FMX.Grid,
  FMX.ScrollBox, FMX.Edit, FMX.EditBox, FMX.NumberBox, FMX.Controls.Presentation, FMX.Objects, FMX.Effects, FMX.SpinBox;

type
  TframeDXVSetMotor = class(TframeMaster)
    circleBody: TCircle;
    btnForward: TCircle;
    btnReverse: TCircle;
    btnLeft: TCircle;
    btnLeftUTurn: TCircle;
    btnRightUTurn: TCircle;
    btnRight: TCircle;
    lblLeftUTurn: TLabel;
    lblRightUTurn: TLabel;
    lblLeft: TLabel;
    lblReverse: TLabel;
    lblForward: TLabel;
    lblRight: TLabel;
    shapeD: TLabel;
    ShadowEffect1: TShadowEffect;
    ShadowEffect2: TShadowEffect;
    lblLeftWheel: TLabel;
    lblRightWheel: TLabel;
    lblSideBrush: TLabel;
    sbBrushRPMValue: TSpinBox;
    lblMainBrush: TLabel;
    sbSideBrushMillwattsValue: TSpinBox;
    lblVacuum: TLabel;
    sbVacuumSpeedValue: TSpinBox;
    spWheelSpeed: TSpinBox;
    lblWheelSpeed: TLabel;
    lblSideBrushPower: TLabel;
    lblMainBrushRPM: TLabel;
    lblVacuumSpeed: TLabel;
    lblBtnPosition: TLabel;
    btnSetMotorLeftWheelEnable: TButton;
    btnSetMotorLeftWheelDisable: TButton;
    btnSetMotorRightWheelEnable: TButton;
    btnSetMotorRightWheelDisable: TButton;
    btnSetMotorVacuumEnable: TButton;
    btnSetMotorVacuumDisable: TButton;
    btnSetMotorMainBrushEnable: TButton;
    btnSetMotorMainBrushDisable: TButton;
    btnSetMotorSideBrushEnable: TButton;
    btnSetMotorSideBrushDisable: TButton;
    sbWheelDistance: TSpinBox;
    btnSetMotorSTOP: TCircle;
    lblSetMotorSTOP: TLabel;
    procedure btnCircleMouseEnter(Sender: TObject);
    procedure btnCircleMouseLeave(Sender: TObject);
    procedure btnSetMotorLeftheelEnableClick(Sender: TObject);
    procedure btnSetMotorLeftWheelDisableClick(Sender: TObject);
    procedure btnSetMotorRightWheelEnableClick(Sender: TObject);
    procedure btnSetMotorVacuumEnableClick(Sender: TObject);
    procedure btnSetMotorMainBrushEnableClick(Sender: TObject);
    procedure btnSetMotorSideBrushEnableClick(Sender: TObject);
    procedure btnSetMotorRightWheelDisableClick(Sender: TObject);
    procedure btnSetMotorVacuumDisableClick(Sender: TObject);
    procedure btnSetMotorMainBrushDisableClick(Sender: TObject);
    procedure btnSetMotorSideBrushDisableClick(Sender: TObject);
    procedure btnForwardClick(Sender: TObject);
    procedure btnReverseClick(Sender: TObject);
    procedure btnLeftClick(Sender: TObject);
    procedure btnRightClick(Sender: TObject);
    procedure btnLeftUTurnClick(Sender: TObject);
    procedure btnRightUTurnClick(Sender: TObject);
    procedure btnSetMotorSTOPClick(Sender: TObject);
    procedure timer_getdataTimer(Sender: TObject);
  private
    fPlaySoundAborted: Boolean;
  public
    procedure Check;
    property PlaySoundAborted: Boolean read fPlaySoundAborted;
    constructor Create(AOwner: TComponent); reintroduce; overload;
  end;

Const
  CirclebtnEnterColor = $FFD5E12D;
  CirclebtnLeaveColor = $FF10A0CF;

  UTurnmm = 512;
  Turnmm = 30;

implementation

{$R *.fmx}

constructor TframeDXVSetMotor.Create(AOwner: TComponent);
begin
  inherited;
  lblFrameTitle.Text := sDescription;
end;

procedure TframeDXVSetMotor.timer_getdataTimer(Sender: TObject);
begin
  inherited;
  timer_getdata.Enabled := false;
end;

procedure TframeDXVSetMotor.btnCircleMouseEnter(Sender: TObject);
var
  msg: string;
begin
  inherited;
  if (Sender is TCircle) then
  begin
    (Sender as TCircle).Fill.Color := CirclebtnEnterColor;

    if Sender = self.btnForward then
      msg := 'Foward';
    if Sender = self.btnReverse then
      msg := 'Reverse';
    if Sender = self.btnLeft then
      msg := '10 degree left';
    if Sender = self.btnLeftUTurn then
      msg := '180 degree left';
    if Sender = self.btnRight then
      msg := '10 degree right';
    if Sender = self.btnRightUTurn then
      msg := '180 degree right';

    lblBtnPosition.Text := msg;
  end;
end;

procedure TframeDXVSetMotor.btnCircleMouseLeave(Sender: TObject);
begin
  inherited;
  lblBtnPosition.Text := '';
  if (Sender is TCircle) then
    (Sender as TCircle).Fill.Color := CirclebtnLeaveColor;
end;


// Possibly switch to just ONE Click Event
// and check Sender and send command based on who Sender is?
// Would clean this up a bit?

procedure TframeDXVSetMotor.btnForwardClick(Sender: TObject);
begin
  inherited;
  dm.COM.SendCommand(sSetmotor + ' ' + neato.DXV.SetMotor.sLWheelDist + ' ' + sbWheelDistance.Value.ToString + ' ' +
    neato.DXV.SetMotor.sRWheelDist + ' ' + sbWheelDistance.Value.ToString + ' ' + neato.DXV.SetMotor.sSpeed + ' ' +
    spWheelSpeed.Value.ToString);
  resetfocus;
end;

procedure TframeDXVSetMotor.btnReverseClick(Sender: TObject);
begin
  inherited;
  dm.COM.SendCommand(sSetmotor + ' ' + neato.DXV.SetMotor.sLWheelDist + ' ' + floattostr(-sbWheelDistance.Value) + ' ' +
    neato.DXV.SetMotor.sRWheelDist + ' ' + floattostr(-sbWheelDistance.Value) + ' ' + neato.DXV.SetMotor.sSpeed + ' ' +
    spWheelSpeed.Value.ToString);
  resetfocus;
end;

procedure TframeDXVSetMotor.btnLeftClick(Sender: TObject);
begin
  inherited;
  dm.COM.SendCommand(sSetmotor + ' ' + neato.DXV.SetMotor.sLWheelDist + ' ' + (-abs(Turnmm)).ToString + ' ' +
    neato.DXV.SetMotor.sRWheelDist + ' ' + Turnmm.ToString + ' ' + neato.DXV.SetMotor.sSpeed + ' ' +
    spWheelSpeed.Value.ToString);
  resetfocus;
end;

procedure TframeDXVSetMotor.btnLeftUTurnClick(Sender: TObject);
begin
  inherited;
  dm.COM.SendCommand(sSetmotor + ' ' + neato.DXV.SetMotor.sLWheelDist + ' ' + UTurnmm.ToString + ' ' +
    neato.DXV.SetMotor.sRWheelDist + ' ' + (-abs(UTurnmm)).ToString + ' ' + neato.DXV.SetMotor.sSpeed + ' ' +
    spWheelSpeed.Value.ToString);
  resetfocus;
end;

procedure TframeDXVSetMotor.btnRightClick(Sender: TObject);
begin
  inherited;
  dm.COM.SendCommand(sSetmotor + ' ' + neato.DXV.SetMotor.sLWheelDist + ' ' + Turnmm.ToString + ' ' +
    neato.DXV.SetMotor.sRWheelDist + ' ' + (-abs(Turnmm)).ToString + ' ' + neato.DXV.SetMotor.sSpeed + ' ' +
    spWheelSpeed.Value.ToString);
  resetfocus;
end;

procedure TframeDXVSetMotor.btnRightUTurnClick(Sender: TObject);
begin
  inherited;
  dm.COM.SendCommand(sSetmotor + ' ' + neato.DXV.SetMotor.sLWheelDist + ' ' + (-abs(UTurnmm)).ToString + ' ' +
    neato.DXV.SetMotor.sRWheelDist + ' ' + UTurnmm.ToString + ' ' + neato.DXV.SetMotor.sSpeed + ' ' +
    spWheelSpeed.Value.ToString);
  resetfocus;
end;

procedure TframeDXVSetMotor.btnSetMotorLeftWheelDisableClick(Sender: TObject);
begin
  inherited;
  dm.COM.SendCommand(sSetmotor + ' ' + neato.DXV.SetMotor.sLWheelDisable);
  resetfocus;
end;

procedure TframeDXVSetMotor.btnSetMotorMainBrushDisableClick(Sender: TObject);
begin
  inherited;
  dm.COM.SendCommand(sSetmotor + ' ' + neato.DXV.SetMotor.sBrush + ' ' + neato.DXV.SetMotor.sRPM + ' 0');
  resetfocus;
end;

procedure TframeDXVSetMotor.btnSetMotorMainBrushEnableClick(Sender: TObject);
begin
  inherited;
  dm.COM.SendCommand(sSetmotor + ' ' + neato.DXV.SetMotor.sBrushEnable);
  dm.COM.SendCommand(sSetmotor + ' ' + neato.DXV.SetMotor.sBrush + ' ' + neato.DXV.SetMotor.sRPM + ' ' +
    sbBrushRPMValue.Value.ToString);
  resetfocus;
end;

procedure TframeDXVSetMotor.btnSetMotorRightWheelDisableClick(Sender: TObject);
begin
  inherited;
  dm.COM.SendCommand(sSetmotor + ' ' + neato.DXV.SetMotor.sRWheelDisable);
  resetfocus;
end;

procedure TframeDXVSetMotor.btnSetMotorRightWheelEnableClick(Sender: TObject);
begin
  inherited;
  dm.COM.SendCommand(sSetmotor + ' ' + neato.DXV.SetMotor.sRWheelEnable);
  resetfocus;
end;

procedure TframeDXVSetMotor.btnSetMotorSideBrushDisableClick(Sender: TObject);
begin
  inherited;

  if neatotype = XV then

    dm.COM.SendCommand(sSetmotor + ' ' + neato.DXV.SetMotor.sSideBrushOn + ' ' +
      neato.DXV.SetMotor.sSideBrushPower + ' 0')
  else
    dm.COM.SendCommand(sSetmotor + ' ' + neato.DXV.SetMotor.sSideBrushOff);

  resetfocus;
end;

procedure TframeDXVSetMotor.btnSetMotorSideBrushEnableClick(Sender: TObject);
begin
  inherited;
  dm.COM.SendCommand(sSetmotor + ' ' + neato.DXV.SetMotor.sSideBrushEnable);

  dm.COM.SendCommand(sSetmotor + ' ' + neato.DXV.SetMotor.sSideBrushOn + ' ' + neato.DXV.SetMotor.sSideBrushPower + ' '
    + sbSideBrushMillwattsValue.Value.ToString);
  resetfocus;
end;

procedure TframeDXVSetMotor.btnSetMotorSTOPClick(Sender: TObject);
begin
  inherited;
  dm.chkTestmode.IsChecked := false;
  dm.chkTestmode.IsChecked := false;
  dm.chkTestmode.IsChecked := true;
  dm.chkTestmode.IsChecked := true;
  resetfocus;
end;

procedure TframeDXVSetMotor.btnSetMotorVacuumDisableClick(Sender: TObject);
begin
  inherited;
  dm.COM.SendCommand(sSetmotor + ' ' + neato.DXV.SetMotor.sVacuumOff);
  resetfocus;
end;

procedure TframeDXVSetMotor.btnSetMotorVacuumEnableClick(Sender: TObject);
begin
  inherited;
  dm.COM.SendCommand(sSetmotor + ' ' + neato.DXV.SetMotor.sVacuumOn + ' ' + neato.DXV.SetMotor.sVacuumSpeed + ' ' +
    sbVacuumSpeedValue.Value.ToString);
  resetfocus;
end;

procedure TframeDXVSetMotor.btnSetMotorLeftheelEnableClick(Sender: TObject);
begin
  inherited;
  dm.COM.SendCommand(sSetmotor + ' ' + neato.DXV.SetMotor.sLWheelEnable);
  resetfocus;
end;

procedure TframeDXVSetMotor.Check;
begin
  if NOT dm.chkTestmode.IsChecked then
    dm.chkTestmode.IsChecked := true;

  self.btnForward.Enabled := dm.COM.Serial.Active;
  self.btnReverse.Enabled := dm.COM.Serial.Active;
  self.btnLeft.Enabled := dm.COM.Serial.Active;
  self.btnLeftUTurn.Enabled := dm.COM.Serial.Active;
  self.btnRightUTurn.Enabled := dm.COM.Serial.Active;
  self.btnRight.Enabled := dm.COM.Serial.Active;
  self.btnSetMotorLeftWheelEnable.Enabled := dm.COM.Serial.Active;
  self.btnSetMotorLeftWheelDisable.Enabled := dm.COM.Serial.Active;
  self.btnSetMotorRightWheelEnable.Enabled := dm.COM.Serial.Active;
  self.btnSetMotorRightWheelDisable.Enabled := dm.COM.Serial.Active;
  self.btnSetMotorVacuumEnable.Enabled := dm.COM.Serial.Active;
  self.btnSetMotorVacuumDisable.Enabled := dm.COM.Serial.Active;
  self.btnSetMotorMainBrushEnable.Enabled := dm.COM.Serial.Active;
  self.btnSetMotorMainBrushDisable.Enabled := dm.COM.Serial.Active;
  self.btnSetMotorSideBrushEnable.Enabled := dm.COM.Serial.Active;
  self.btnSetMotorSideBrushDisable.Enabled := dm.COM.Serial.Active;

  if neatotype = XV then // appears XV allows down to 0 while others do NOT
  begin
    sbSideBrushMillwattsValue.Min := 0;
  end
  else
  begin
    sbSideBrushMillwattsValue.Min := 500;
  end;

end;

end.