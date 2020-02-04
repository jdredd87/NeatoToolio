unit frame.XV.SetLED;

interface

uses
  frame.master,
  dmCommon,
  neato.XV.SetLED,
  neato.helpers, FMX.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, System.Math.Vectors, FMX.Types3D,
  FMX.Controls3D, FMX.Objects3D, FMX.Viewport3D, FMX.MaterialSources, FMX.Controls.Presentation, FMX.Layers3D,
  System.Rtti, FMX.Grid.Style, FMX.Grid, FMX.ScrollBox, FMX.Objects, FMX.Ani, FMX.Edit, FMX.EditBox, FMX.SpinBox;

type
  TframeXVSetLED = class(TframeMaster)
    lblSetLEDError: TLabel;
    rectSetLCDTop: TRectangle;
    lblSetLEDMessage: TLabel;
    btnSetLEDBacklightOn: TButton;
    btnSetLEDBacklightOff: TButton;
    btnSetLEDButtonAmber: TButton;
    btnSetLEDButtonOff: TButton;
    btnSetLEDBlinkOn: TButton;
    btnSetLEDButtonGreenDim: TButton;
    btnSetLEDButtonAmberDim: TButton;
    btnSetLEDLEDGreen: TButton;
    btnSetLEDLEDRed: TButton;
    btnSetLEDButtonGreen: TButton;
    btnSetLEDBlinkOff: TButton;
    procedure btnSetLEDBacklightOnMouseEnter(Sender: TObject);
    procedure btnSetLEDBacklightOnMouseLeave(Sender: TObject);
    procedure btnSetLEDOnClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure check;
    constructor Create(AOwner: TComponent); reintroduce; overload;
  end;

implementation

{$R *.fmx}

constructor TframeXVSetLED.Create(AOwner: TComponent);
begin
  inherited;
  lblFrameTitle.Text := sDescription;
end;

procedure TframeXVSetLED.btnSetLEDOnClick(Sender: TObject);
var
  cmd: string;
  pSetLED: tSetLEDXV;
  pReadData: TStringList;
  r: Boolean;
  idx: integer;
begin
  cmd := '';

  if Sender = btnSetLEDBacklightOn then
    cmd := sBacklightOn;
  if Sender = btnSetLEDBacklightOff then
    cmd := sBacklightOff;
  if Sender = btnSetLEDButtonAmber then
    cmd := sButtonAmber;
  if Sender = btnSetLEDButtonOff then
    cmd := sButtonOff;
  if Sender = btnSetLEDBlinkOn then
    cmd := sBlinkOn;
  if Sender = btnSetLEDButtonGreenDim then
    cmd := sButtonGreenDim;
  if Sender = btnSetLEDButtonAmberDim then
    cmd := sButtonAmberDim;
  if Sender = btnSetLEDLEDGreen then
    cmd := sLEDGreen;
  if Sender = btnSetLEDLEDRed then
    cmd := sLEDRed;
  if Sender = btnSetLEDButtonGreen then
    cmd := sButtonGreen;
  if Sender = btnSetLEDBlinkOff then
    cmd := sBlinkOff;

  if cmd <> '' then
  begin

    dm.chkTestmode.IsChecked := true;
    sleep(250);

    pSetLED := tSetLEDXV.Create;

    pReadData := TStringList.Create;
    pReadData.Text := dm.com.SendCommand(sSetLED + ' ' + cmd);

    r := pSetLED.ParseText(pReadData);

    if r then
      lblSetLEDMessage.Text := ''
    else
      lblSetLEDMessage.Text := pSetLED.Error;

    pReadData.Free;
    pSetLED.Free;

  end;

  resetfocus;
end;

procedure TframeXVSetLED.btnSetLEDBacklightOnMouseEnter(Sender: TObject);
var
  msg: string;
begin
  msg := '';

  if Sender = btnSetLEDBacklightOn then
    msg := sBacklightOnMSG;
  if Sender = btnSetLEDBacklightOff then
    msg := sBacklightOffMSG;
  if Sender = btnSetLEDButtonAmber then
    msg := sButtonAmberMSG;
  if Sender = btnSetLEDButtonOff then
    msg := sButtonOffMSG;
  if Sender = btnSetLEDBlinkOn then
    msg := sBlinkOnMSG;
  if Sender = btnSetLEDButtonGreenDim then
    msg := sButtonGreenDimMSG;
  if Sender = btnSetLEDButtonAmberDim then
    msg := sButtonAmberDimMSG;
  if Sender = btnSetLEDLEDGreen then
    msg := sLEDGreenMSG;
  if Sender = btnSetLEDLEDRed then
    msg := sLEDRedMSG;
  if Sender = btnSetLEDButtonGreen then
    msg := sButtonGreenMSG;
  if Sender = btnSetLEDBlinkOff then
    msg := sBlinkOffMSG;

  lblSetLEDMessage.Text := msg;
end;

procedure TframeXVSetLED.btnSetLEDBacklightOnMouseLeave(Sender: TObject);
begin
  lblSetLEDMessage.Text := '';
end;

procedure TframeXVSetLED.check;
begin
  btnSetLEDBacklightOn.Enabled := dm.com.Serial.Active;
  btnSetLEDBacklightOff.Enabled := dm.com.Serial.Active;
  btnSetLEDButtonAmber.Enabled := dm.com.Serial.Active;
  btnSetLEDButtonOff.Enabled := dm.com.Serial.Active;
  btnSetLEDBlinkOn.Enabled := dm.com.Serial.Active;
  btnSetLEDButtonGreenDim.Enabled := dm.com.Serial.Active;
  btnSetLEDButtonAmberDim.Enabled := dm.com.Serial.Active;
  btnSetLEDLEDGreen.Enabled := dm.com.Serial.Active;
  btnSetLEDLEDRed.Enabled := dm.com.Serial.Active;
  btnSetLEDButtonGreen.Enabled := dm.com.Serial.Active;
  btnSetLEDBlinkOff.Enabled := dm.com.Serial.Active;

  if dm.com.Serial.Active then
    dm.chkTestmode.IsChecked := true;
end;

end.
