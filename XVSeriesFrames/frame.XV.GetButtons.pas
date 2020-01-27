unit frame.XV.GetButtons;

interface

uses
  frame.master,
  dmCommon,
  neato.xv.getbuttons,FMX.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation;

type
  TframeXVGetButtons = class(TframeMaster)
    lblGetButtonsBTN_SOFT_KEY: TLabel;
    swGetButtonsBTN_SOFT_KEYvalue: TSwitch;
    lblGetButtonsBTN_SCROLL_UP: TLabel;
    swGetButtonsBTN_SCROLL_UPvalue: TSwitch;
    lblGetButtonsBTN_START: TLabel;
    swGetButtonsBTN_STARTvalue: TSwitch;
    lblGetButtonsBTN_BACK: TLabel;
    swGetButtonsBTN_BACKvalue: TSwitch;
    lblGetButtonsBTN_SCROLL_DOWN: TLabel;
    swGetButtonsBTN_SCROLL_DOWNvalue: TSwitch;
    procedure timer_GetDataTimer(Sender: TObject);
  private
    { Private declarations }
  public
  end;

implementation

{$R *.fmx}

procedure TframeXVGetButtons.timer_GetDataTimer(Sender: TObject);
var
  pGetButtons: tGetButtonsXV;
  pReadData: TStringList;
  r: Boolean;
begin

  if (dm.com.Serial.Active = false) or (dm.ActiveTab<>Tab) then
  begin
    timer_GetData.Enabled := false;
    exit;
  end;

  pGetButtons := tGetButtonsXV.Create;

  pReadData := TStringList.Create;
  pReadData.Text := dm.com.SendCommand(sGetButtons);

  r := pGetButtons.ParseText(pReadData);

  if r then
  begin
    swGetButtonsBTN_SOFT_KEYvalue.IsChecked := pGetButtons.BTN_SOFT_KEY;
    swGetButtonsBTN_SCROLL_UPvalue.IsChecked := pGetButtons.BTN_SCROLL_UP;
    swGetButtonsBTN_STARTvalue.IsChecked := pGetButtons.BTN_START;
    swGetButtonsBTN_BACKvalue.IsChecked := pGetButtons.BTN_BACK;
    swGetButtonsBTN_SCROLL_DOWNvalue.IsChecked := pGetButtons.BTN_SCROLL_DOWN;
  end;

  pReadData.Free;
  pGetButtons.Free;
end;


end.
