unit frame.DXV.SetIEC;

interface

uses
  frame.master,
  dmCommon,
  neato.DXV.SetIEC,
  FMX.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.DateTimeCtrls, FMX.Objects, FMX.Edit, FMX.EditBox, FMX.SpinBox, FMX.ListBox, FMX.Layouts;

type
  TframeDXVSetIEC = class(TframeMaster)
    lblSetIECError: TLabel;
    Rectangle1: TRectangle;
    btnSetIECHardSpeed: TButton;
    btnSetIECCarpetSpeed: TButton;
    btnSetIECDistance: TButton;
    sbSetIECHardSpeedValue: TSpinBox;
    sbSetIECCarpetSpeedValue: TSpinBox;
    sbSetIECDistanceValue: TSpinBox;
    procedure btnSetWallFollowerClick(Sender: TObject);
    procedure timer_getdataTimer(Sender: TObject);
  private
  public
    procedure check;
    constructor Create(AOwner: TComponent; Rect: TRectangle); reintroduce; overload;
  end;

implementation

{$R *.fmx}

constructor TframeDXVSetIEC.Create(AOwner: TComponent; Rect: TRectangle);
begin
  inherited Create(AOwner, Rect);
  lblFrameTitle.Text := sDescription;
end;

procedure TframeDXVSetIEC.timer_getdataTimer(Sender: TObject);
begin
  inherited;
//
end;

procedure TframeDXVSetIEC.btnSetWallFollowerClick(Sender: TObject);
var
  cmd: String;
  r: boolean;
  pReadData: tstringlist;
  pSetIECDXV: tSetIECDXV;
begin
  inherited;
  cmd := '';

  if Sender = btnSetIECHardSpeed then
    cmd := sSetIEC + ' ' + sHardSpeed + ' ' + self.sbSetIECHardSpeedValue.Value.ToString;

  if Sender = self.btnSetIECCarpetSpeed then
    cmd := sSetIEC + ' ' + sCarpetSpeed + ' ' + self.sbSetIECCarpetSpeedValue.Value.ToString;

  if Sender = self.btnSetIECDistance then
    cmd := sSetIEC + ' ' + sDistance + ' ' + self.sbSetIECDistanceValue.Value.ToString;

  if cmd <> '' then
  begin
    pReadData := tstringlist.Create;
    pReadData.Text := dm.com.SendCommandAndWaitForValue(cmd, 6000, ^Z, 1);

    pSetIECDXV := tSetIECDXV.Create;

    r := pSetIECDXV.ParseText(pReadData);

    if r then
      lblSetIECError.Text := ''
    else
      lblSetIECError.Text := pSetIECDXV.Error;

    freeandnil(pSetIECDXV);
    freeandnil(pReadData);
  end;

  resetfocus;
end;

procedure TframeDXVSetIEC.check;
begin
  btnSetIECHardSpeed.Enabled := dm.com.Active;
  btnSetIECCarpetSpeed.Enabled := dm.com.Active;
  btnSetIECDistance.Enabled := dm.com.Active;
  sbSetIECHardSpeedValue.Enabled := dm.com.Active;
  sbSetIECCarpetSpeedValue.Enabled := dm.com.Active;
  sbSetIECDistanceValue.Enabled := dm.com.Active;
  if dm.com.Active then
    dm.chkTestmode.IsChecked := true;
end;

end.
