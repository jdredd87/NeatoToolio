unit frame.XV.GetWarranty;

interface

uses
  frame.master,
  dmCommon,
  neato.XV.GetWarranty,
  FMX.TabControl, FMX.objects,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Layouts;

type
  TframeXVGetWarranty = class(TframeMaster)
    lbl_CumulativeCleaningTimeInSecs: TLabel;
    lbl_CumulativeCleaningTimeInSecsValue: TLabel;
    lbl_CumulativeBatteryCycles: TLabel;
    lbl_CumulativeBatteryCyclesValue: TLabel;
    lbl_ValidationCode: TLabel;
    lbl_ValidationCodeValue: TLabel;
    procedure timer_GetDataTimer(Sender: TObject);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; Rect: TRectangle); reintroduce; overload;
    procedure check;
  end;

implementation

{$R *.fmx}

constructor TframeXVGetWarranty.Create(AOwner: TComponent; Rect: TRectangle);
begin
  inherited Create(AOwner, Rect);
  lblFrameTitle.Text := sDescription;
end;

procedure TframeXVGetWarranty.timer_GetDataTimer(Sender: TObject);
var
  pGetWarranty: tGetWarrantyXV;
  pReadData: TStringList;
  r: Boolean;
begin

  if (dm.com.Active = false) or (dm.ActiveTab <> tab) then
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

procedure TframeXVGetWarranty.check;
begin
  //
end;

end.
