unit frame.XV.GetVersion;

interface

uses
  dmCommon,
  neato.XV.GetVersion,
  neato.Helpers,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, System.Rtti, FMX.Grid.Style, FMX.Grid,
  FMX.Controls.Presentation, FMX.ScrollBox;

type
  TframeXVGetVersion = class(TFrame)
    sgGetVersion: TStringGrid;
    scGetVersionComponent: TStringColumn;
    scGerVersionMajor: TStringColumn;
    scGetVersionMinor: TStringColumn;
    scGetVersionBuild: TStringColumn;
    timer_GetData: TTimer;
    procedure timer_GetDataTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

procedure TframeXVGetVersion.timer_GetDataTimer(Sender: TObject);

  procedure PopulateRow(RowID: integer; item: tGetVersionFieldsXV);
  begin
    sgGetVersion.Cells[0, RowID] := item.Component;
    sgGetVersion.Cells[1, RowID] := item.Major;
    sgGetVersion.Cells[2, RowID] := item.Minor;
    sgGetVersion.Cells[3, RowID] := item.Build;
  end;

var
  pGetVersion: tGetVersionXV;
  pReadData: TStringList;
  r: Boolean;
begin

  if (dm.com.Serial.Active = false) then
  begin
    timer_GetData.Enabled := false;
    exit;
  end;

  pGetVersion := tGetVersionXV.Create;

  pReadData := TStringList.Create;
  pReadData.Text := dm.com.SendCommand(sGetVersion);

  r := pGetVersion.ParseText(pReadData);

  if r then
  begin
    sgGetVersion.RowCount := iGetVersionRowCount;

    PopulateRow(0, pGetVersion.ModelID);
    PopulateRow(1, pGetVersion.ConfigID);
    PopulateRow(2, pGetVersion.Serial_Number);
    PopulateRow(3, pGetVersion.Software);
    PopulateRow(4, pGetVersion.BatteryType);
    PopulateRow(5, pGetVersion.BlowerType);
    PopulateRow(6, pGetVersion.BrushSpeed);
    PopulateRow(7, pGetVersion.BrushMotorType);
    PopulateRow(8, pGetVersion.SideBrushType);
    PopulateRow(9, pGetVersion.WheelPodType);
    PopulateRow(10, pGetVersion.DropSensorType);
    PopulateRow(11, pGetVersion.MagSensorType);
    PopulateRow(12, pGetVersion.WallSensorType);
    PopulateRow(13, pGetVersion.Locale);
    PopulateRow(14, pGetVersion.LDS_Software);
    PopulateRow(15, pGetVersion.LDS_Serial);
    PopulateRow(16, pGetVersion.LDS_CPU);
    PopulateRow(17, pGetVersion.MainBoard_Vendor_ID);
    PopulateRow(18, pGetVersion.MainBoard_Serial_Number);
    PopulateRow(19, pGetVersion.BootLoader_Software);
    PopulateRow(20, pGetVersion.MainBoard_Software);
    PopulateRow(21, pGetVersion.MainBoard_Boot);
    PopulateRow(22, pGetVersion.MainBoard_Version);
    PopulateRow(23, pGetVersion.ChassisRev);
    PopulateRow(24, pGetVersion.UIPanelRev);
  end;

  pReadData.Free;
  pGetVersion.Free;
end;

end.
