unit frame.D.SetUsage;

interface

uses
  frame.master,
  dmCommon,
  neato.D.SetUsage,
  FMX.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Objects,
  FMX.Edit, FMX.EditBox, FMX.SpinBox, FMX.Layouts;

type
  TframeDSetUsage = class(TframeMaster)
    rectTop: TRectangle;
    btnSetUsageMainBrush: TButton;
    btnSetUsageSideBrush: TButton;
    lblSetUsageDescription: TLabel;
    lblSetUsageError: TLabel;
    btnSetUsageDustBin: TButton;
    btnSetUsageFilter: TButton;
    sbSetUsageSeconds: TSpinBox;
    lblSetUsageLifeTime: TLabel;
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

constructor TframeDSetUsage.Create(AOwner: TComponent; Rect: TRectangle);
begin
  inherited Create(AOwner, Rect);
  lblFrameTitle.Text := sDescription;
end;

procedure TframeDSetUsage.timer_getdataTimer(Sender: TObject);
begin
  inherited;
//
end;

procedure TframeDSetUsage.btnSetNavigationModeClick(Sender: TObject);
var
  cmd: String;
  r: boolean;
  pReadData: tstringlist;
  pSetUsage: tSetUsage;
begin
  inherited;

  cmd := '';

  if Sender = self.btnSetUsageMainBrush then
    cmd := sMainBrush;

  if Sender = self.btnSetUsageSideBrush then
    cmd := sSideBrush;

  if Sender = btnSetUsageDustBin then
    cmd := sDustbin;

  if Sender = btnSetUsageFilter then
    cmd := sFilter;

  if cmd <> '' then
  begin
    pReadData := tstringlist.Create;
    pSetUsage := tSetUsage.Create;

    pReadData.Text := dm.com.SendCommand(sSetUsage + ' ' + cmd + ' ' + self.sbSetUsageSeconds.Value.ToString);

    r := pSetUsage.ParseText(pReadData);

    if r then
    begin
      lblSetUsageError.Text := '';
    end
    else
      lblSetUsageError.Text := pSetUsage.Error;

    freeandnil(pSetUsage);
    freeandnil(pReadData);
  end;

  resetfocus;
end;

procedure TframeDSetUsage.btnSetNavigationModeMouseEnter(Sender: TObject);
var
  msg: string;
begin
  inherited;
  msg := '';

  if Sender = self.btnSetUsageMainBrush then
    msg := sMainBrushMsg;

  if Sender = self.btnSetUsageSideBrush then
    msg := sSideBrushMsg;

  if Sender = self.btnSetUsageDustBin then
    msg := sDustBinmsg;

  if Sender = self.btnSetUsageFilter then
    msg := sFilterMsg;

  lblSetUsageDescription.Text := msg;
end;

procedure TframeDSetUsage.btnSetNavigationModeMouseLeave(Sender: TObject);
begin
  inherited;
  lblSetUsageDescription.Text := '';
end;

procedure TframeDSetUsage.check;
begin
  self.btnSetUsageMainBrush.Enabled := dm.com.Active;
  self.btnSetUsageSideBrush.Enabled := dm.com.Active;
  self.btnSetUsageDustBin.Enabled := dm.com.Active;
  self.btnSetUsageFilter.Enabled := dm.com.Active;
  self.sbSetUsageSeconds.Enabled := dm.com.Active;
end;

end.
