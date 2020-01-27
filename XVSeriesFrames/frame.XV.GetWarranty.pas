unit frame.XV.GetWarranty;

interface

uses
  dmCommon,
  neato.XV.GetWarranty,FMX.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation;

type
  TframeXVGetWarranty = class(TFrame)
    lbl_CumulativeCleaningTimeInSecs: TLabel;
    lbl_CumulativeCleaningTimeInSecsValue: TLabel;
    lbl_CumulativeBatteryCycles: TLabel;
    lbl_CumulativeBatteryCyclesValue: TLabel;
    lbl_ValidationCode: TLabel;
    lbl_ValidationCodeValue: TLabel;
    timer_GetData: TTimer;
    procedure timer_GetDataTimer(Sender: TObject);
  private
    { Private declarations }
  public
   Tab : TTabItem;
  end;

implementation

{$R *.fmx}

procedure TframeXVGetWarranty.timer_GetDataTimer(Sender: TObject);
var
  pGetWarranty: tGetWarrantyXV;
  pReadData: TStringList;
  r: Boolean;
begin

  if (dm.com.Serial.Active = false) or (dm.ActiveTab<>tab)  then
  begin
    timer_GetData.Enabled := false;
    exit;
  end;

  pGetWarranty := tGetWarrantyXV.Create;

  pReadData := TStringList.Create;
  pReadData.Text := dm.com.SendCommand(sGetWarranty);
  pReadData.Text := stringreplace(pReadData.Text, ',', '=', [rfreplaceall]);

  r := pGetWarranty.ParseText(pReadData);

  if r then
  begin
    lbl_CumulativeCleaningTimeInSecsValue.Text := strtoint('$' + pGetWarranty.CumulativeCleaningTimeInSecs).ToString +
      ' seconds as ' + pGetWarranty.CumulativeCleaningTimeInSecsAsHours.ToString + ' hours';
    lbl_CumulativeBatteryCyclesValue.Text := inttostr(strtoint('$' + pGetWarranty.CumulativeBatteryCycles));
    lbl_ValidationCodeValue.Text := strtoint64('$' + pGetWarranty.ValidationCode).ToString;
  end;

  pReadData.Free;
  pGetWarranty.Free;
end;

end.
