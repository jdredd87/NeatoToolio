unit frame.DXV.SetLED;

interface

uses
  frame.master,
  dmCommon,
  neato.DXV.SetLED,
  neato.helpers, FMX.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, System.Math.Vectors, FMX.Types3D,
  FMX.Controls3D, FMX.Objects3D, FMX.Viewport3D, FMX.MaterialSources, FMX.Controls.Presentation, FMX.Layers3D,
  System.Rtti, FMX.Grid.Style, FMX.Grid, FMX.ScrollBox, FMX.Objects, FMX.Ani, FMX.Edit, FMX.EditBox, FMX.SpinBox;

type
  TframeDXVSetLED = class(TframeMaster)
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
   constructor Create(AOwner: TComponent); reintroduce; overload;
  end;

implementation

{$R *.fmx}

constructor TframeDXVSetLED.Create(AOwner: TComponent);
begin
 inherited;
 lblFrameTitle.Text := sDescription;
end;

procedure TframeDXVSetLED.btnSetLEDOnClick(Sender: TObject);
var
  cmd: string;
  pSetLED: tSetLED;
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

    pSetLED := tSetLED.Create;

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

procedure TframeDXVSetLED.btnSetLEDBacklightOnMouseEnter(Sender: TObject);
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

procedure TframeDXVSetLED.btnSetLEDBacklightOnMouseLeave(Sender: TObject);
begin
  lblSetLEDMessage.Text := '';
end;

end.
