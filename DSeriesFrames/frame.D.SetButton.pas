unit frame.D.SetButton;

interface

uses
  frame.master,
  dmCommon,
  neato.D.SetButton,
  FMX.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Objects;

type
  TframeDSetButton = class(TframeMaster)
    rectTop: TRectangle;
    btnSetButtonsoft: TButton;
    btnSetButtonstart: TButton;
    btnSetButtonspot: TButton;
    btnSetButtonback: TButton;
    btnSetButtonup: TButton;
    btnSetButtondown: TButton;
    lblsetbuttondescription: TLabel;
    lblSetButtonError: TLabel;
    btnSetButtonIRstart: TButton;
    btnSetButtonIRspot: TButton;
    btnSetButtonIRfront: TButton;
    btnSetButtonIRback: TButton;
    btnSetButtonIRleft: TButton;
    btnSetButtonIRright: TButton;
    btnSetButtonIRhome: TButton;
    btnSetButtonIReco: TButton;
    procedure btnSetButtonClick(Sender: TObject);
    procedure btnSetButtonMouseEnter(Sender: TObject);
    procedure btnSetButtonMouseLeave(Sender: TObject);
  private
    { Private declarations }
  public
    procedure check;
    constructor Create(AOwner: TComponent); reintroduce; overload;
  end;

implementation

{$R *.fmx}

constructor TframeDSetButton.Create(AOwner: TComponent);
begin
  inherited;
  lblFrameTitle.Text := sDescription;
end;

procedure TframeDSetButton.btnSetButtonClick(Sender: TObject);
var
  cmd: String;
  r: boolean;
  pReadData: tstringlist;
  pSetButton: tSetButton;
begin
  inherited;

  cmd := '';

  if Sender = btnSetButtonsoft then
    cmd := ssoft;

  if Sender = btnSetButtonstart then
    cmd := sstart;

  if Sender = btnSetButtonspot then
    cmd := sspot;

  if Sender = btnSetButtonback then
    cmd := sback;

  if Sender = btnSetButtonup then
    cmd := sup;

  if Sender = btnSetButtondown then
    cmd := sdown;

  if Sender = btnSetButtonIRstart then
    cmd := sIRstart;

  if Sender = btnSetButtonIRspot then
    cmd := sIRspot;

  if Sender = btnSetButtonIRfront then
    cmd := sIRfront;

  if Sender = btnSetButtonIRback then
    cmd := sIRback;

  if Sender = btnSetButtonIRleft then
    cmd := sIRleft;

  if Sender = btnSetButtonIRright then
    cmd := sIRright;

  if Sender = btnSetButtonIRhome then
    cmd := sIRhome;

  if Sender = btnSetButtonIReco then
    cmd := sIReco;

  if cmd <> '' then
  begin
    pReadData := tstringlist.Create;
    pReadData.Text := dm.com.SendCommand(sSetButton + ' ' + cmd);

    pSetButton := tSetButton.Create;

    r := pSetButton.ParseText(pReadData);

    if r then
    begin
      lblSetButtonError.Text := '';
    end
    else
      lblSetButtonError.Text := pSetButton.Error;

    freeandnil(pSetButton);
    freeandnil(pReadData);
  end;

  resetfocus;
end;

procedure TframeDSetButton.btnSetButtonMouseEnter(Sender: TObject);
var
  msg: string;
begin
  inherited;
  msg := '';

  if Sender = btnSetButtonsoft then
    msg := ssoftmsg;

  if Sender = btnSetButtonstart then
    msg := sstartmsg;

  if Sender = btnSetButtonspot then
    msg := sspotmsg;

  if Sender = btnSetButtonback then
    msg := sbackmsg;

  if Sender = btnSetButtonup then
    msg := supmsg;

  if Sender = btnSetButtondown then
    msg := sdownmsg;

  if Sender = btnSetButtonIRstart then
    msg := sIRstartMsg;

  if Sender = btnSetButtonIRspot then
    msg := sIRspotMsg;

  if Sender = btnSetButtonIRfront then
    msg := sIRfrontMsg;

  if Sender = btnSetButtonIRback then
    msg := sIRbackMsg;

  if Sender = btnSetButtonIRleft then
    msg := sIRleftMsg;

  if Sender = btnSetButtonIRright then
    msg := sIRrightMsg;

  if Sender = btnSetButtonIRhome then
    msg := sIRhomeMsg;

  if Sender = btnSetButtonIReco then
    msg := sIRecoMsg;

  lblsetbuttondescription.Text := msg;
end;

procedure TframeDSetButton.btnSetButtonMouseLeave(Sender: TObject);
begin
  inherited;
  lblsetbuttondescription.Text := '';
end;

procedure TframeDSetButton.check;
begin
  btnSetButtonsoft.Enabled := dm.com.Active;
  btnSetButtonstart.Enabled := dm.com.Active;
  btnSetButtonspot.Enabled := dm.com.Active;
  btnSetButtonback.Enabled := dm.com.Active;
  btnSetButtonup.Enabled := dm.com.Active;
  btnSetButtondown.Enabled := dm.com.Active;

  btnSetButtonIRstart.Enabled := neatotype = BotVac;
  btnSetButtonIRspot.Enabled := neatotype = BotVac;
  btnSetButtonIRfront.Enabled := neatotype = BotVac;
  btnSetButtonIRback.Enabled := neatotype = BotVac;
  btnSetButtonIRleft.Enabled := neatotype = BotVac;
  btnSetButtonIRright.Enabled := neatotype = BotVac;
  btnSetButtonIRhome.Enabled := neatotype = BotVac;
  btnSetButtonIReco.Enabled := neatotype = BotVac;
end;

end.
