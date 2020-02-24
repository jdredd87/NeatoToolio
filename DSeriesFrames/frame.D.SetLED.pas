unit frame.D.SetLED;

{ NOT SUPPORTED YET AND CAN'T SEEM TO GET ANYTHING TO ACTUALLY RESPOND }

interface

uses
  frame.master,
  dmCommon,
  neato.D.SetLED,
  neato.helpers, FMX.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, System.Math.Vectors, FMX.Types3D,
  FMX.Controls3D, FMX.Objects3D, FMX.Viewport3D, FMX.MaterialSources, FMX.Controls.Presentation, FMX.Layers3D,
  System.Rtti, FMX.Grid.Style, FMX.Grid, FMX.ScrollBox, FMX.Objects, FMX.Ani, FMX.Edit, FMX.EditBox, FMX.SpinBox,
  FMX.Layouts;

type
  TframeDSetLED = class(TframeMaster)
    lblSetLEDError: TLabel;
    rectSetLCDTop: TRectangle;
    lblSetLEDMessage: TLabel;

    btnSetLEDhome: TButton;
    btnSetLEDspot: TButton;
    btnSetLEDinfo: TButton;
    btnSetLEDbattery: TButton;
    btnSetLEDwifi: TButton;
    procedure btnSetLEDhomeMouseEnter(Sender: TObject);
    procedure btnSetLEDhomeMouseLeave(Sender: TObject);
    procedure btnSetLEDOnClick(Sender: TObject);
    procedure timer_getdataTimer(Sender: TObject);
  private
    { Private declarations }
  public
    procedure check;
    constructor Create(AOwner: TComponent; Rect: TRectangle); reintroduce; overload;

  end;

implementation

{$R *.fmx}

constructor TframeDSetLED.Create(AOwner: TComponent; Rect: TRectangle);
begin
  inherited Create(AOwner, Rect);
  lblFrameTitle.Text := sDescription;
end;

procedure TframeDSetLED.timer_getdataTimer(Sender: TObject);
begin
  inherited;
//
end;

procedure TframeDSetLED.btnSetLEDOnClick(Sender: TObject);
begin
  //
end;
{
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
  lblSetLEDMessage.Text := pSetLEd.Error;

  pReadData.Free;
  pSetLED.Free;

  end;

  resetfocus;
  end;
}

procedure TframeDSetLED.btnSetLEDhomeMouseEnter(Sender: TObject);
var
  msg: string;
begin
  msg := '';

  {
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
  }
  lblSetLEDMessage.Text := msg;
end;

procedure TframeDSetLED.btnSetLEDhomeMouseLeave(Sender: TObject);
begin
  lblSetLEDMessage.Text := '';
end;

procedure TframeDSetLED.check;
begin

  btnSetLEDhome.Enabled := dm.COM.Active;
  btnSetLEDspot.Enabled := dm.COM.Active;
  btnSetLEDinfo.Enabled := dm.COM.Active;
  btnSetLEDbattery.Enabled := dm.COM.Active;
  btnSetLEDwifi.Enabled := dm.COM.Active;

  if dm.COM.Active then
    dm.chkTestmode.IsChecked := true;
end;

end.
