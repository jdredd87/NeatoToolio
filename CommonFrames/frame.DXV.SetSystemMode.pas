unit frame.DXV.SetSystemMode;

interface

uses
  frame.master,
  dmCommon,
  neato.DXV.SetSystemMode,
  neato.helpers, FMX.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, System.Math.Vectors, FMX.Types3D,
  FMX.Controls3D, FMX.Objects3D, FMX.Viewport3D, FMX.MaterialSources, FMX.Controls.Presentation, FMX.Layers3D,
  System.Rtti, FMX.Grid.Style, FMX.Grid, FMX.ScrollBox, FMX.Objects, FMX.Ani, FMX.Edit, FMX.EditBox, FMX.SpinBox;

type
  TframeDXVSetSystemMode = class(TframeMaster)
    lblSetSystemModeError: TLabel;
    Rectangle1: TRectangle;
    btnSetSystemModeShutdown: TButton;
    btnSetSystemModeHibernate: TButton;
    btnSetSystemModeStandby: TButton;
    btnSetSystemModePowerCycle: TButton;
    lblSetSystemModeMessage: TLabel;
    procedure btnSetSystemModeClick(Sender: TObject);
    procedure btnSetSystemModeShutdownMouseEnter(Sender: TObject);
    procedure btnSetSystemModeShutdownMouseLeave(Sender: TObject);

  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); reintroduce; overload;
  end;

implementation

{$R *.fmx}

constructor TframeDXVSetSystemMode.Create(AOwner: TComponent);
begin
  inherited;
  lblFrameTitle.Text := sDescription;
end;

procedure TframeDXVSetSystemMode.btnSetSystemModeClick(Sender: TObject);
var
  cmd: string;
  pSetSystemMode: tSetSystemMode;
  pReadData: TStringList;
  r: Boolean;
begin
  cmd := '';
  if Sender = btnSetSystemModeShutdown then
    cmd := sShutdown;
  if Sender = btnSetSystemModeHibernate then
    cmd := sHibernate;
  if Sender = btnSetSystemModeStandby then
    cmd := sStandby;
  if Sender = btnSetSystemModePowerCycle then
    cmd := sPowerCycle;

  if cmd <> '' then
  begin

    dm.chkTestmode.IsChecked := true;
    sleep(250);

    pSetSystemMode := tSetSystemMode.Create;

    pReadData := TStringList.Create;

    pReadData.Text := dm.com.SendCommand(sSetSystemMode + ' ' + cmd);
    sleep(250);
    pReadData.Text := dm.com.SendCommand(sSetSystemMode + ' ' + cmd);


    r := pSetSystemMode.ParseText(pReadData);

    if r then
    begin
      lblSetSystemModeError.Text := '';
      dm.ActiveTab := nil;
      dm.com.Serial.Close;
    end
    else
    begin
      lblSetSystemModeError.Text := pSetSystemMode.Error;
    end;

    pReadData.Free;
    pSetSystemMode.Free;

    resetfocus;

  end;

end;

procedure TframeDXVSetSystemMode.btnSetSystemModeShutdownMouseEnter(Sender: TObject);
var
  msg: string;
begin
  msg := '';
  if Sender = btnSetSystemModeShutdown then
    msg := sShutdownMsg;
  if Sender = btnSetSystemModeHibernate then
    msg := sHibernateMsg;
  if Sender = btnSetSystemModeStandby then
    msg := sStandbyMsg;
  if Sender = btnSetSystemModePowerCycle then
    msg := sPowerCycleMsg;

  if msg <> '' then
    lblSetSystemModeMessage.Text := msg;
end;

procedure TframeDXVSetSystemMode.btnSetSystemModeShutdownMouseLeave(Sender: TObject);
begin
  lblSetSystemModeMessage.Text := '';
end;

end.
