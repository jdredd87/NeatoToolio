unit frame.D.SetNTPTime;

interface

uses
  frame.master,
  dmCommon,
  neato.D.SetNTPTime,
  FMX.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Objects,
  FMX.Layouts;

type
  TframeDSetNTPTime = class(TframeMaster)
    rectTop: TRectangle;
    btnSetNTPTime: TButton;
    btnSetNTPTimeBrief: TButton;
    lblSetNTPTimeDescription: TLabel;
    lblSetNTPTimeError: TLabel;
    procedure btnSetNTPTimeClick(Sender: TObject);
    procedure btnSetNTPTimeMouseEnter(Sender: TObject);
    procedure btnSetNTPTimeMouseLeave(Sender: TObject);
    procedure timer_getdataTimer(Sender: TObject);
  private
    { Private declarations }
  public
    procedure check;
    constructor Create(AOwner: TComponent; Rect: TRectangle); reintroduce; overload;

  end;

implementation

{$R *.fmx}

constructor TframeDSetNTPTime.Create(AOwner: TComponent; Rect: TRectangle);
begin
  inherited Create(AOwner, Rect);
  lblFrameTitle.Text := sDescription;
end;

procedure TframeDSetNTPTime.timer_getdataTimer(Sender: TObject);
begin
  inherited;
//
end;

procedure TframeDSetNTPTime.btnSetNTPTimeClick(Sender: TObject);
var
  cmd: String;
  r: boolean;
  pReadData: tstringlist;
  pSetNTPTime: tSetNTPTime;
begin
  inherited;

  cmd := '';

  if Sender = btnSetNTPTime then
    cmd := sSetNTPTime;

  if Sender = btnSetNTPTimeBrief then
    cmd := sSetNTPTime + ' ' + sbrief;

  if cmd <> '' then
  begin
    pReadData := tstringlist.Create;
    pReadData.Text := dm.com.SendCommand(cmd);

    pSetNTPTime := tSetNTPTime.Create;

    r := pSetNTPTime.ParseText(pReadData);

    if r then
    begin
      lblSetNTPTimeError.Text := '';
    end
    else
      lblSetNTPTimeError.Text := pSetNTPTime.Error;

    freeandnil(pReadData);
    freeandnil(pSetNTPTime);
  end;

  resetfocus;
end;

procedure TframeDSetNTPTime.btnSetNTPTimeMouseEnter(Sender: TObject);
var
  msg: string;
begin
  inherited;
  msg := '';

  if Sender = btnSetNTPTime then
    msg := sDescription;

  if Sender = btnSetNTPTimeBrief then
    msg := sbriefMsg;

  lblSetNTPTimeDescription.Text := msg;
end;

procedure TframeDSetNTPTime.btnSetNTPTimeMouseLeave(Sender: TObject);
begin
  inherited;
  lblSetNTPTimeDescription.Text := '';
end;

procedure TframeDSetNTPTime.check;
begin
  btnSetNTPTime.Enabled := dm.com.Active;
  btnSetNTPTimeBrief.Enabled := dm.com.Active;
end;

end.
