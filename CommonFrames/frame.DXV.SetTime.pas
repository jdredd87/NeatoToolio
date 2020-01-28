unit frame.DXV.SetTime;

interface

uses
  frame.master,
  dmCommon,
  neato.DXV.SetTime,
  neato.helpers, FMX.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, System.Math.Vectors, FMX.Types3D,
  FMX.Controls3D, FMX.Objects3D, FMX.Viewport3D, FMX.MaterialSources, FMX.Controls.Presentation, FMX.Layers3D,
  System.Rtti, FMX.Grid.Style, FMX.Grid, FMX.ScrollBox, FMX.Objects, FMX.Ani, FMX.Edit, FMX.EditBox, FMX.SpinBox;

type
  TframeDXVSetTime = class(TframeMaster)
    lblSetTimeError: TLabel;
    Rectangle1: TRectangle;
    ckSetTimeSun: tradiobutton;
    ckSetTimeMon: tradiobutton;
    ckSetTimeTue: tradiobutton;
    ckSetTimeWed: tradiobutton;
    ckSetTimeThu: tradiobutton;
    ckSetTimeFri: tradiobutton;
    ckSetTimeSat: tradiobutton;
    sbSetTimeHour: TSpinBox;
    lblSetTimeHour: TLabel;
    lblSetTimeMinutes: TLabel;
    sbSetTimeMinutes: TSpinBox;
    sbSetTimeSeconds: TSpinBox;
    lblSetTimeSeconds: TLabel;
    btnSetTimeApply: TButton;
    procedure btnSetTimeApplyClick(Sender: TObject);
    procedure ckSetTimeSunChange(Sender: TObject);

  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); reintroduce; overload;
  end;

implementation

{$R *.fmx}

constructor TframeDXVSetTime.Create(AOwner: TComponent);
begin
  inherited;
  lblFrameTitle.Text := sDescription;
end;

procedure TframeDXVSetTime.btnSetTimeApplyClick(Sender: TObject);
var
  pSetTime: tSetTime;
  pReadData: TStringList;
  r: Boolean;
  fday: byte;
  fhour: byte;
  fminutes: byte;
  fseconds: byte;
begin

  pSetTime := tSetTime.Create;

  if ckSetTimeSun.IsChecked then
    fday := 0
  else if ckSetTimeMon.IsChecked then
    fday := 1
  else if ckSetTimeTue.IsChecked then
    fday := 2
  else if ckSetTimeWed.IsChecked then
    fday := 3
  else if ckSetTimeThu.IsChecked then
    fday := 4
  else if ckSetTimeFri.IsChecked then
    fday := 5
  else if ckSetTimeSat.IsChecked then
    fday := 6;

  fhour := round(sbSetTimeHour.Value);
  fminutes := round(sbSetTimeMinutes.Value);
  fseconds := round(sbSetTimeSeconds.Value);

  pReadData := TStringList.Create;
  pReadData.Text := dm.com.SendCommand(sSetTime + ' ' + fday.ToString + ' ' + fhour.ToString + ' ' + fminutes.ToString +
    ' ' + fseconds.ToString);

  r := pSetTime.ParseText(pReadData);

  if r then
  begin
    lblSetTimeError.Text := '';
  end
  else
  begin
    lblSetTimeError.Text := pSetTime.Error;
  end;

  pReadData.Free;
  pSetTime.Free;

end;

procedure TframeDXVSetTime.ckSetTimeSunChange(Sender: TObject);
begin // ick i know
  if (ckSetTimeSun.Enabled) or (ckSetTimeMon.Enabled) or (ckSetTimeTue.Enabled) or (ckSetTimeWed.Enabled) or
    (ckSetTimeThu.Enabled) or (ckSetTimeFri.Enabled) or (ckSetTimeSat.Enabled) then
    btnSetTimeApply.Enabled := true
  else
    btnSetTimeApply.Enabled := false;
end;

end.
