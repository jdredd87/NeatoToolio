unit frame.D.SetNavigationMode;

interface

uses
  frame.master,
  dmCommon,
  neato.D.SetNavigationMode,
  FMX.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Objects,
  FMX.Layouts;

type
  TframeDSetNavigationMode = class(TframeMaster)
    rectTop: TRectangle;
    btnSetNavigationModeNormal: TButton;
    btnSetNavigationModeGentle: TButton;
    lblSetNavigationModeDescription: TLabel;
    lblSetNavigationModeError: TLabel;
    btnSetNavigationModeDeep: TButton;
    btnSetNavigationModeQuick: TButton;
    procedure btnSetNavigationModeClick(Sender: TObject);
    procedure btnSetNavigationModeMouseEnter(Sender: TObject);
    procedure btnSetNavigationModeMouseLeave(Sender: TObject);
    procedure timer_getdataTimer(Sender: TObject);
  private
    { Private declarations }
  public
    procedure check;
    constructor Create(AOwner: TComponent; Rect: TRectangle); reintroduce; overload;

  end;

implementation

{$R *.fmx}

constructor TframeDSetNavigationMode.Create(AOwner: TComponent; Rect: TRectangle);
begin
  inherited Create(AOwner, Rect);
  lblFrameTitle.Text := sDescription;
end;

procedure TframeDSetNavigationMode.timer_getdataTimer(Sender: TObject);
begin
  inherited;
//
end;

procedure TframeDSetNavigationMode.btnSetNavigationModeClick(Sender: TObject);
var
  cmd: String;
  r: boolean;
  pReadData: tstringlist;
  pSetNavigationMode: tSetNavigationMode;
begin
  inherited;

  cmd := '';

  if Sender = self.btnSetNavigationModeNormal then
    cmd := sNormal;

  if Sender = self.btnSetNavigationModeGentle then
    cmd := sGentle;

  if Sender = self.btnSetNavigationModeDeep then
    cmd := sDeep;

  if Sender = self.btnSetNavigationModeQuick then
    cmd := sQuick;

  if cmd <> '' then
  begin
    pReadData := tstringlist.Create;
    pSetNavigationMode := tSetNavigationMode.Create;

    pReadData.Text := dm.com.SendCommand(sSetNavigationMode + ' ' + cmd);

    r := pSetNavigationMode.ParseText(pReadData);

    if r then
    begin
      lblSetNavigationModeError.Text := '';
    end
    else
      lblSetNavigationModeError.Text := pSetNavigationMode.Error;

    freeandnil(pSetNavigationMode);
    freeandnil(pReadData);
  end;

  resetfocus;
end;

procedure TframeDSetNavigationMode.btnSetNavigationModeMouseEnter(Sender: TObject);
var
  msg: string;
begin
  inherited;
  msg := '';

  if Sender = self.btnSetNavigationModeNormal then
    msg := sNormalmsg;

  if Sender = self.btnSetNavigationModeGentle then
    msg := sGentlemsg;

  if Sender = self.btnSetNavigationModeDeep then
    msg := sDeepmsg;

  if Sender = self.btnSetNavigationModeQuick then
    msg := sQuickmsg;

  lblSetNavigationModeDescription.Text := msg;
end;

procedure TframeDSetNavigationMode.btnSetNavigationModeMouseLeave(Sender: TObject);
begin
  inherited;
  lblSetNavigationModeDescription.Text := '';
end;

procedure TframeDSetNavigationMode.check;
begin
  btnSetNavigationModeNormal.Enabled := dm.com.Active;
  btnSetNavigationModeGentle.Enabled := dm.com.Active;
  btnSetNavigationModeDeep.Enabled := dm.com.Active;
  btnSetNavigationModeQuick.Enabled := dm.com.Active;
end;

end.
