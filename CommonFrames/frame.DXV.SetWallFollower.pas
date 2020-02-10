unit frame.DXV.SetWallFollower;

{

  SETSCHEDULE 1 12 12 F
  SetSchedule: Unrecognized Option 'F'
  SetSchedule - Modify Cleaning Schedule.
  Day - Day of the week to schedule cleaning for. Sun=0,Sat=6. (required)
  Hour - Hour value 0..23 (required)
  Min - Minutes value 0..59 (required)
  House - Schedule to Clean whole house (default)
  (Mutually exclusive with None)
  None - Remove Scheduled Cleaning for specified day. Time is ignored.
  (Mutually exclusive with House)
  ON - Enable Scheduled cleanings (Mutually exclusive with OFF)
  OFF - Disable Scheduled cleanings (Mutually exclusive with ON)

  SETSCHEDULE 0 12 12 HOUSE
  Schedule is Enabled
  Sun 12:12 H
  
  SETSCHEDULE 0 12 12 NONE
  Schedule is Enabled
  Sun 00:00 - None -

  SETSCHEDULE 0 00 00 ON     // one must be on for schedule to be enabled
  Schedule is Enabled
  Sun 00:00 H
}

interface

uses
  frame.master,
  dmCommon,
  neato.DXV.SetWallFollower,
  FMX.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.DateTimeCtrls, FMX.Objects, FMX.Edit, FMX.EditBox, FMX.SpinBox, FMX.ListBox;

type
  TframeDXVSetWallFollower = class(TframeMaster)
    lblSetWallFollowerError: TLabel;
    Rectangle1: TRectangle;
    Label1: TLabel;
    btnSetWallFollowerEnabled: TButton;
    btnSetWallFollowerDisabled: TButton;
    procedure btnSetWallFollowerClick(Sender: TObject);
  private
  public
    constructor Create(AOwner: TComponent); reintroduce; overload;
    procedure check;
  end;

implementation

{$R *.fmx}

constructor TframeDXVSetWallFollower.Create(AOwner: TComponent);
begin
  inherited;
  lblFrameTitle.Text := sDescription;
end;

procedure TframeDXVSetWallFollower.btnSetWallFollowerClick(Sender: TObject);
var
  cmd: String;
  r: boolean;
  pReadData: tstringlist;
  pSetWallFollowerDXV: tSetWallFollowerDXV;
begin
  inherited;
  cmd := '';

  if Sender = self.btnSetWallFollowerEnabled then
    cmd := sSetWallFollower + ' ' + sEnable;

  if Sender = self.btnSetWallFollowerDisabled then
    cmd := sSetWallFollower + ' ' + sDisable;

  if cmd <> '' then
  begin
    pReadData := tstringlist.Create;
    pReadData.Text := dm.com.SendCommandAndWaitForValue(cmd, 6000, ^Z, 1);

    pSetWallFollowerDXV := tSetWallFollowerDXV.Create;

    r := pSetWallFollowerDXV.ParseText(pReadData);

    if r then
      lblSetWallFollowerError.Text := ''
    else
      lblSetWallFollowerError.Text := pSetWallFollowerDXV.Error;

    freeandnil(pSetWallFollowerDXV);
    freeandnil(pReadData);
  end;
  resetfocus;
end;

procedure TframeDXVSetWallFollower.check;
begin
  //
end;

end.
