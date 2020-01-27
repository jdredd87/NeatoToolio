unit frame.D.GetUsage;

interface

uses
  frame.master,
  dmCommon,
  neato.D.GetUsage,FMX.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation;

type
  TframeDGetUsage = class(TframeMaster)
    lblTotalCleaningTime: TLabel;
    lblTotalCleaningTimeValue: TLabel;
    lblTotalCleanedArea: TLabel;
    lblTotalCleanedAreaValue: TLabel;
    lblMainBrushRunTimeinSec: TLabel;
    lblMainBrushRunTimeinSecValue: TLabel;
    lblSideBrushRunTimeinSec: TLabel;
    lblSideBrushRunTimeinSecValue: TLabel;
    lblDirtbinRunTimeinSec: TLabel;
    lblDirtbinRunTimeinSecValue: TLabel;
    lblFilterTimeinSec: TLabel;
    lblFilterTimeinSecValue: TLabel;
    procedure timer_GetDataTimer(Sender: TObject);
  private
    { Private declarations }
  public
  end;

implementation

{$R *.fmx}

procedure TframeDGetUsage.timer_GetDataTimer(Sender: TObject);
var
  pGetUsage: tGetUsageD;
  pReadData: TStringList;
  r: Boolean;
begin

  if (dm.com.Serial.Active = false) or (dm.ActiveTab <> tab) then
  begin
    timer_GetData.Enabled := false;
    exit;
  end;

  pGetUsage := tGetUsageD.Create;

  pReadData := TStringList.Create;
  pReadData.Text := dm.com.SendCommand(sGetUsage);

  r := pGetUsage.ParseText(pReadData);

  if r then
  begin
    lblTotalCleaningTimeValue.Text := pGetUsage.Total_Cleaning_Time.ToString;
    lblTotalCleanedAreaValue.Text := pGetUsage.Total_Cleaned_Area.ToString;
    lblMainBrushRunTimeinSecValue.Text := pGetUsage.MainBrushRunTimeinSec.ToString;
    lblSideBrushRunTimeinSecValue.Text := pGetUsage.SideBrushRunTimeinSec.ToString;
    lblDirtbinRunTimeinSecValue.Text := pGetUsage.DirtbinRunTimeinSec.ToString;
    lblFilterTimeinSecValue.Text := pGetUsage.FilterTimeinSec.ToString;
  end;

  pReadData.Free;
  pGetUsage.Free;
end;

end.
