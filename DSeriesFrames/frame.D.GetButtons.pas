unit frame.D.GetButtons;

interface

uses
  dmCommon,
  neato.d.getbuttons,FMX.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation;

type
  TframeDGetButtons = class(TFrame)
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
    lblGetButtonsBTN_SPOT: TLabel;
    swGetButtonsBTN_SPOTvalue: TSwitch;
    lblGetButtonsIR_BTN_HOME: TLabel;
    swGetButtonsIR_BTN_HOMEvalue: TSwitch;
    lblGetButtonsIR_BTN_SPOT: TLabel;
    swGetButtonsIR_BTN_SPOTvalue: TSwitch;
    lblGetButtonsIR_BTN_ECO: TLabel;
    swGetButtonsIR_BTN_ECOvalue: TSwitch;
    lblGetButtonsIR_BTN_UP: TLabel;
    swGetButtonsIR_BTN_UPvalue: TSwitch;
    lblGetButtonsIR_BTN_DOWN: TLabel;
    swGetButtonsIR_BTN_DOWNvalue: TSwitch;
    lblGetButtonsIR_BTN_RIGHT: TLabel;
    swGetButtonsIR_BTN_RIGHTvalue: TSwitch;
    lblGetButtonsIR_BTN_LEFT: TLabel;
    swGetButtonsIR_BTN_LEFTvalue: TSwitch;
    lblGetButtonsIR_BTN_START: TLabel;
    swGetButtonsIR_BTN_STARTvalue: TSwitch;
    lblGetButtonsIR_BTN_LEFT_ARC: TLabel;
    swGetButtonsIR_BTN_LEFT_ARCvalue: TSwitch;
    lblGetButtonsIR_BTN_RIGHT_ARC: TLabel;
    swGetButtonsIR_BTN_RIGHT_ARCvalue: TSwitch;
    timer_GetData: TTimer;
    procedure timer_GetDataTimer(Sender: TObject);
  private
    { Private declarations }
  public
   Tab : TTabItem;
  end;

implementation

{$R *.fmx}

procedure TframeDGetButtons.timer_GetDataTimer(Sender: TObject);
var
  pGetButtons: tGetButtonsD;
  pReadData: TStringList;
  r: Boolean;
begin

  if (dm.com.Serial.Active = false) or (dm.ActiveTab<>tab) then
  begin
    timer_GetData.Enabled := false;
    exit;
  end;

  pGetButtons := tGetButtonsD.Create;

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
    swGetButtonsBTN_SPOTvalue.IsChecked := pGetButtons.BTN_SPOT;
    swGetButtonsIR_BTN_HOMEvalue.IsChecked := pGetButtons.IR_BTN_HOME;
    swGetButtonsIR_BTN_SPOTvalue.IsChecked := pGetButtons.IR_BTN_SPOT;
    swGetButtonsIR_BTN_ECOvalue.IsChecked := pGetButtons.IR_BTN_ECO;
    swGetButtonsIR_BTN_UPvalue.IsChecked := pGetButtons.IR_BTN_UP;
    swGetButtonsIR_BTN_DOWNvalue.IsChecked := pGetButtons.IR_BTN_DOWN;
    swGetButtonsIR_BTN_RIGHTvalue.IsChecked := pGetButtons.IR_BTN_RIGHT;
    swGetButtonsIR_BTN_LEFTvalue.IsChecked := pGetButtons.IR_BTN_LEFT;
    swGetButtonsIR_BTN_STARTvalue.IsChecked := pGetButtons.IR_BTN_START;
    swGetButtonsIR_BTN_LEFT_ARCvalue.IsChecked := pGetButtons.IR_BTN_LEFT;
    swGetButtonsIR_BTN_RIGHT_ARCvalue.IsChecked := pGetButtons.IR_BTN_RIGHT_ARC;
  end;

  pReadData.Free;
  pGetButtons.Free;
end;


end.
