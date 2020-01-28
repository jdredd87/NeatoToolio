unit frame.DXV.SetDistanceCal;

interface

uses
  frame.master,
  dmCommon,
  neato.DXV.SetDistanceCal,
  FMX.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.DateTimeCtrls, FMX.Objects, FMX.Edit, FMX.EditBox, FMX.SpinBox, FMX.ListBox;

Const
  sCommandWait = 'These commands take a few seconds to complete.';

type

  TframeDXVSetDistanceCal = class(TframeMaster)
    lblSetDistanceCalError: TLabel;
    Rectangle1: TRectangle;
    btnSetDistanceCalDropMinimum: TButton;
    btnSetDistanceCalDropMiddle: TButton;
    btnSetDistanceCalDropMaximum: TButton;
    btnSetDistanceCalWallMinimum: TButton;
    btnSetDistanceCalWallMiddle: TButton;
    btnSetDistanceCalWallMaximum: TButton;
    lblSetDistanceCalRDropCalA2DMin: TLabel;
    lblSetDistanceCalRDropCalA2DMinValue: TLabel;
    lblSetDistanceCalRDropCalA2DMid: TLabel;
    lblSetDistanceCalRDropCalA2DMidValue: TLabel;
    lblSetDistanceCalRDropCalA2DMax: TLabel;
    lblSetDistanceCalRDropCalA2DMaxValue: TLabel;
    lblSetDistanceCalLDropCalA2DMinValue: TLabel;
    lblSetDistanceCalLDropCalA2DMin: TLabel;
    lblSetDistanceCalLDropCalA2DMid: TLabel;
    lblSetDistanceCalLDropCalA2DMidValue: TLabel;
    lblSetDistanceCalLDropCalA2DMaxValue: TLabel;
    lblSetDistanceCalLDropCalA2DMax: TLabel;
    lblSetDistanceCalWallCalA2DMin: TLabel;
    lblSetDistanceCalWallCalA2DMinValue: TLabel;
    lblSetDistanceCalWallCalA2DMidValue: TLabel;
    lblSetDistanceCalWallCalA2DMid: TLabel;
    lblSetDistanceCalWallCalA2DMax: TLabel;
    lblSetDistanceCalWallCalA2DMaxValue: TLabel;
    lblSetDistanceCalMessage: TLabel;
    procedure btnSetDistanceCalClick(Sender: TObject);
    procedure btnSetDistanceCalWallMinimumMouseEnter(Sender: TObject);
    procedure btnSetDistanceCalDropMinimumMouseLeave(Sender: TObject);
  private
    { Private declarations }
  end;

implementation

{$R *.fmx}

procedure TframeDXVSetDistanceCal.btnSetDistanceCalClick(Sender: TObject);
var
  cmd: String;

begin
  inherited;

  // work around this to be better to do this for me
  if not dm.chkTestmode.IsChecked then
  begin
    dm.chkTestmode.IsChecked := true;
    sleep(250);
    dm.chkTestmode.IsChecked := true;
    sleep(250);
    dm.chkTestmode.IsChecked := true;
    sleep(250);
    dm.chkTestmode.IsChecked := true;
    sleep(250);
    dm.COM.Serial.PurgeInput;
    dm.COM.Serial.PurgeOutput;
  end;

  cmd := '';

  if Sender = btnSetDistanceCalDropMinimum then
    cmd := sSetDistanceCal + ' ' + sDropMinimum;
  if Sender = btnSetDistanceCalDropMiddle then
    cmd := sSetDistanceCal + ' ' + sDropMiddle;
  if Sender = btnSetDistanceCalDropMaximum then
    cmd := sSetDistanceCal + ' ' + sDropMaximum;
  if Sender = btnSetDistanceCalWallMinimum then
    cmd := sSetDistanceCal + ' ' + sWallMinimum;
  if Sender = btnSetDistanceCalWallMiddle then
    cmd := sSetDistanceCal + ' ' + sWallMiddle;
  if Sender = btnSetDistanceCalWallMaximum then
    cmd := sSetDistanceCal + ' ' + sWallMaximum;

  if cmd <> '' then
  begin

    btnSetDistanceCalDropMinimum.Enabled := false;
    btnSetDistanceCalDropMiddle.Enabled := false;
    btnSetDistanceCalDropMaximum.Enabled := false;
    btnSetDistanceCalWallMinimum.Enabled := false;
    btnSetDistanceCalWallMiddle.Enabled := false;
    btnSetDistanceCalWallMaximum.Enabled := false;

    tthread.CreateAnonymousThread(
      procedure
      var
        r: boolean;
        pReadData: tstringlist;
        pSetDistanceCalDXV: tSetDistanceCalDXV;
      begin

        pReadData := tstringlist.Create;
        pReadData.Text := dm.COM.SendCommandAndWaitForValue(cmd, 10000, ^Z, 1);

        pSetDistanceCalDXV := tSetDistanceCalDXV.Create;

        r := pSetDistanceCalDXV.ParseText(pReadData);

        tthread.Synchronize(tthread.CurrentThread,
          procedure
          begin
            if r then
            begin
              lblSetDistanceCalError.Text := '';
              lblSetDistanceCalRDropCalA2DMinValue.Text := pSetDistanceCalDXV.RDropCalA2DMin.ToString;
              lblSetDistanceCalRDropCalA2DMidValue.Text := pSetDistanceCalDXV.RDropCalA2DMid.ToString;
              lblSetDistanceCalRDropCalA2DMaxValue.Text := pSetDistanceCalDXV.RDropCalA2DMax.ToString;
              lblSetDistanceCalLDropCalA2DMinValue.Text := pSetDistanceCalDXV.LDropCalA2DMin.ToString;
              lblSetDistanceCalLDropCalA2DMidValue.Text := pSetDistanceCalDXV.LDropCalA2DMid.ToString;
              lblSetDistanceCalLDropCalA2DMaxValue.Text := pSetDistanceCalDXV.LDropCalA2DMax.ToString;
              lblSetDistanceCalWallCalA2DMinValue.Text := pSetDistanceCalDXV.WallCalA2DMin.ToString;
              lblSetDistanceCalWallCalA2DMidValue.Text := pSetDistanceCalDXV.WallCalA2DMid.ToString;
              lblSetDistanceCalWallCalA2DMaxValue.Text := pSetDistanceCalDXV.WallCalA2DMax.ToString;
            end
            else
              lblSetDistanceCalError.Text := pSetDistanceCalDXV.Error;

            btnSetDistanceCalDropMinimum.Enabled := true;
            btnSetDistanceCalDropMiddle.Enabled := true;
            btnSetDistanceCalDropMaximum.Enabled := true;
            btnSetDistanceCalWallMinimum.Enabled := true;
            btnSetDistanceCalWallMiddle.Enabled := true;
            btnSetDistanceCalWallMaximum.Enabled := true;
          end);

        freeandnil(pSetDistanceCalDXV);
        freeandnil(pReadData);
      end).Start;
  end;

  resetfocus;
end;

procedure TframeDXVSetDistanceCal.btnSetDistanceCalDropMinimumMouseLeave(Sender: TObject);
begin
  inherited;
  lblSetDistanceCalMessage.Text := sCommandWait;
end;

procedure TframeDXVSetDistanceCal.btnSetDistanceCalWallMinimumMouseEnter(Sender: TObject);
var
  msg: string;
begin
  inherited;
  msg := '';

  if Sender = btnSetDistanceCalDropMinimum then
    msg := sDropMinimumMsg;
  if Sender = btnSetDistanceCalDropMiddle then
    msg := sDropMiddleMsg;
  if Sender = btnSetDistanceCalDropMaximum then
    msg := sDropMaximumMsg;
  if Sender = btnSetDistanceCalWallMinimum then
    msg := sWallMinimumMsg;
  if Sender = btnSetDistanceCalWallMiddle then
    msg := sWallMiddleMsg;
  if Sender = btnSetDistanceCalWallMaximum then
    msg := sWallMiddleMsg;

  lblSetDistanceCalMessage.Text := msg;
end;

end.
