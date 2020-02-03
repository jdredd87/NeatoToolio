unit frame.D.Clean;

interface

uses
  frame.master,
  dmCommon,
  neato.D.Clean,
  neato.errors, FMX.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Objects,
  FMX.Edit, FMX.EditBox, FMX.SpinBox;

type
  TframeDClean = class(TframeMaster)
    lblCleanWidth: TLabel;
    lblCleanError: TLabel;
    lblCleanHeight: TLabel;
    lblCleanMaxCycles: TLabel;

    btnClean: TButton;
    btnCleanExplore: TButton;
    btnCleanHouse: TButton;
    btnCleanSpot: TButton;
    btnCleanPersistent: TButton;
    btnCleanAutoCycle: TButton;
    btnCleanStop: TButton;

    sbCleanWidth: TSpinBox;
    sbCleanHeight: TSpinBox;
    sbNumberOfCycles: TSpinBox;

    ckCleanForever: TCheckBox;
    rectTop: TRectangle;
    lblCleanMessage: TLabel;
    lblCleanWarning: TLabel;

    procedure btnCleanClick(Sender: TObject);
    procedure btnCleanMouseEnter(Sender: TObject);
    procedure btnCleanMouseLeave(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Check;
    constructor Create(AOwner: TComponent); reintroduce; overload;
  end;

implementation

{$R *.fmx}

constructor TframeDClean.Create(AOwner: TComponent);
begin
  inherited;
  lblFrameTitle.Text := sDescription;
end;

procedure TframeDClean.btnCleanClick(Sender: TObject);
var
  pReadData: TStringList;
  pClean: tCleanD;
  r: boolean;
  CMD: string;
begin
  CMD := '';

  pClean := tCleanD.Create;

  pReadData := TStringList.Create;

  if Sender = btnClean then
    CMD := sClean;

  if Sender = btnCleanExplore then
    CMD := sClean + ' ' + sExplore;

  if Sender = btnCleanHouse then
    CMD := sClean + ' ' + shouse;

  if Sender = btnCleanSpot then
    CMD := sClean + ' ' + sspot + ' width ' + sbCleanWidth.Value.ToString + ' height ' + sbCleanHeight.Value.ToString;

  if Sender = btnCleanPersistent then
    CMD := sClean + ' ' + spersistent;

  if Sender = btnCleanAutoCycle then
  begin
    CMD := sClean + ' ' + sAutoCycle;

    if ckCleanForever.IsChecked then
      CMD := CMD + ' -1'
    else
      CMD := CMD + ' ' + sbNumberOfCycles.Value.ToString;

  end;

  if Sender = btnCleanStop then
    CMD := sClean + ' ' + sstop;

  pReadData.Text := dm.com.SendCommand(CMD);

  r := pClean.ParseText(pReadData);

  lblCleanError.Text := pClean.Error;

  freeandnil(pClean);
  freeandnil(pReadData);
  resetfocus;
end;

procedure TframeDClean.btnCleanMouseEnter(Sender: TObject);
var
  msg: string;
begin
  inherited;
  msg := '';

  if Sender = btnClean then
    msg := sDescription;

  if Sender = btnCleanExplore then
    msg := sExploreMsg;

  if Sender = btnCleanHouse then
    msg := shouseMsg;

  if Sender = btnCleanSpot then
    msg := sSpotMsg;

  if Sender = btnCleanPersistent then
    msg := sPersistentMsg;

  if Sender = btnCleanAutoCycle then
    msg := sAutoCycleMsg;

  if Sender = btnCleanStop then
    msg := sStopMsg;

  lblCleanMessage.Text := msg;
end;

procedure TframeDClean.btnCleanMouseLeave(Sender: TObject);
begin
  inherited;
  lblCleanMessage.Text := '';
end;

procedure TframeDClean.Check;
begin
  case neatotype of
    botVac:
      begin
        sbCleanWidth.Min := -1;
        sbCleanWidth.Max := 500;

        btnClean.Enabled := dm.com.Serial.Active;
        sbCleanWidth.Enabled := dm.com.Serial.Active;

        btnCleanExplore.Enabled := false;
        btnCleanHouse.Enabled := false;
        btnCleanSpot.Enabled := false;
        btnCleanPersistent.Enabled := false;
        btnCleanAutoCycle.Enabled := false;
        sbCleanWidth.Enabled := false;
        sbCleanHeight.Enabled := false;
        sbNumberOfCycles.Enabled := false;
        ckCleanForever.Enabled := false;
      end;
    botVacConnected:
      begin
        sbCleanWidth.Min := 100;
        sbCleanWidth.Max := 400;
        btnCleanExplore.Enabled := dm.com.Serial.Active;
        btnCleanHouse.Enabled := dm.com.Serial.Active;
        btnCleanSpot.Enabled := dm.com.Serial.Active;
        btnCleanPersistent.Enabled := dm.com.Serial.Active;
        btnCleanAutoCycle.Enabled := dm.com.Serial.Active;
        sbCleanWidth.Enabled := dm.com.Serial.Active;
        sbCleanHeight.Enabled := dm.com.Serial.Active;
        sbNumberOfCycles.Enabled := dm.com.Serial.Active;
        ckCleanForever.Enabled := dm.com.Serial.Active;
      end;
  end;

end;

end.
