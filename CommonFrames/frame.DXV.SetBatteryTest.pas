unit frame.DXV.SetBatteryTest;

interface

uses
  frame.master,
  dmCommon,
  neato.DXV.SetBatteryTest,
  FMX.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.DateTimeCtrls, FMX.Objects, FMX.Edit, FMX.EditBox, FMX.SpinBox, FMX.ListBox, FMX.ScrollBox, FMX.Memo;

type
  TframeDXVSetBatteryTest = class(TframeMaster)
    lblSetBatteryTestError: TLabel;
    rectTop: TRectangle;
    btnSetBatteryTestDisabled: TButton;
    btnSetBateryTestEnabled: TButton;
    lblSetBatteryTest: TLabel;
    memoSetBatteryTest: TMemo;
    procedure btnSetWallFollowerClick(Sender: TObject);
  private
  public
    procedure check;
    constructor Create(AOwner: TComponent); reintroduce; overload;
  end;

implementation

{$R *.fmx}

constructor TframeDXVSetBatteryTest.Create(AOwner: TComponent);
begin
  inherited;
  lblFrameTitle.Text := sDescription;
end;

procedure TframeDXVSetBatteryTest.btnSetWallFollowerClick(Sender: TObject);
var
  cmd: String;
  r: boolean;
  pReadData: tstringlist;
  pSetBatteryTestDXV: tSetBatteryTest;
begin
  inherited;
  cmd := '';

  if Sender = self.btnSetBateryTestEnabled then
    cmd := sSetBatteryTest + ' ' + sOn;

  if Sender = self.btnSetBatteryTestDisabled then
    cmd := sSetBatteryTest + ' ' + sOff;

  if cmd <> '' then
  begin
    pReadData := tstringlist.Create;
    pReadData.Text := dm.com.SendCommandAndWaitForValue(cmd, 6000, ^Z, 1);

    pSetBatteryTestDXV := tSetBatteryTest.Create;

    r := pSetBatteryTestDXV.ParseText(pReadData);
    memoSetBatteryTest.Text := pSetBatteryTestDXV.Response;

    if r then
    begin
      lblSetBatteryTestError.Text := '';
    end
    else
      lblSetBatteryTestError.Text := pSetBatteryTestDXV.Error;

    freeandnil(pSetBatteryTestDXV);
    freeandnil(pReadData);
  end;
  resetfocus;
end;

procedure TframeDXVSetBatteryTest.check;
begin
  btnSetBateryTestEnabled.Enabled := dm.com.Active;
  btnSetBatteryTestDisabled.Enabled := dm.com.Active;
  if dm.COM.Active then
   dm.chkTestmode.IsChecked := true;
end;

end.
