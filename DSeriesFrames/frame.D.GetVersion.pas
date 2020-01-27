unit frame.D.GetVersion;

interface

uses
  frame.master,
  dmCommon,
  neato.D.Getversion,FMX.TabControl,
  neato.Helpers,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, System.Rtti, FMX.Grid.Style, FMX.Grid,
  FMX.Controls.Presentation, FMX.ScrollBox;

type
  TframeDGetVersion = class(TframeMaster)
    sgGetVersion: TStringGrid;
    scGetVersionComponent: TStringColumn;
    scGerVersionMajor: TStringColumn;
    scGetVersionMinor: TStringColumn;
    scGetVersionBuild: TStringColumn;
    scGetVersionAux: TStringColumn;
    scGetGetVersionAUX2: TStringColumn;
    procedure timer_GetDataTimer(Sender: TObject);
  private
    { Private declarations }
  public
  end;

implementation

{$R *.fmx}

procedure TframeDGetVersion.timer_GetDataTimer(Sender: TObject);

  procedure PopulateRow(RowID: integer; item: tGetVersionFieldsD);
  begin
    sgGetVersion.Cells[0, RowID] := item.Component;
    sgGetVersion.Cells[1, RowID] := item.Major;
    sgGetVersion.Cells[2, RowID] := item.Minor;
    sgGetVersion.Cells[3, RowID] := item.Build;
    sgGetVersion.Cells[4, RowID] := item.AUX;
    sgGetVersion.Cells[5, RowID] := item.AUX2;
  end;

var
  pGetVersion: tGetVersionD;
  pReadData: TStringList;
  r: Boolean;
begin

  if (dm.com.Serial.Active = false) or (dm.ActiveTab<>tab) then
  begin
    timer_GetData.Enabled := false;
    exit;
  end;

  pGetVersion := tGetVersionD.Create;

  pReadData := TStringList.Create;
  pReadData.Text := dm.com.SendCommand(sGetVersion);

  r := pGetVersion.ParseText(pReadData);

  if r then
  begin
    sgGetVersion.RowCount := iGetVersionRowCount;

    PopulateRow(0, pGetVersion.BaseID);
    PopulateRow(1, pGetVersion.Beehive_URL);
    PopulateRow(2, pGetVersion.BlowerType);
    PopulateRow(3, pGetVersion.Bootloader_Version);
    PopulateRow(4, pGetVersion.BrushMotorResistorPowerRating);
    PopulateRow(5, pGetVersion.BrushMotorResistorResistance);
    PopulateRow(6, pGetVersion.BrushMotorType);
    PopulateRow(7, pGetVersion.BrushSpeed);
    PopulateRow(8, pGetVersion.BrushSpeedEco);
    PopulateRow(9, pGetVersion.ChassisRev);
    PopulateRow(10, pGetVersion.DropSensorType);
    PopulateRow(11, pGetVersion.LCD_Panel);
    PopulateRow(12, pGetVersion.LDS_CPU);
    PopulateRow(13, pGetVersion.LDS_Serial);
    PopulateRow(14, pGetVersion.LDS_Software);
    PopulateRow(15, pGetVersion.LDSMotorType);
    PopulateRow(16, pGetVersion.Locale);
    PopulateRow(17, pGetVersion.MagSensorType);
    PopulateRow(18, pGetVersion.MainBoard_Serial_Number);
    PopulateRow(19, pGetVersion.MainBoard_Version);
    PopulateRow(20, pGetVersion.Model);
    PopulateRow(21, pGetVersion.NTP_URL);
    PopulateRow(22, pGetVersion.Nucleo_URL);
    PopulateRow(23, pGetVersion.QAState);
    PopulateRow(24, pGetVersion.Serial_Number);
    PopulateRow(25, pGetVersion.SideBrushPower);
    PopulateRow(26, pGetVersion.SideBrushType);
    PopulateRow(27, pGetVersion.SmartBatt_Authorization);
    PopulateRow(28, pGetVersion.SmartBatt_Data_Version);
    PopulateRow(29, pGetVersion.SmartBatt_Device_Chemistry);
    PopulateRow(30, pGetVersion.SmartBatt_Device_Name);
    PopulateRow(31, pGetVersion.SmartBatt_Manufacturer_Name);
    PopulateRow(32, pGetVersion.SmartBatt_Mfg_Year_Month_Day);
    PopulateRow(33, pGetVersion.SmartBatt_Serial_Number);
    PopulateRow(34, pGetVersion.SmartBatt_Software_Version);
    PopulateRow(35, pGetVersion.Software_Git_SHA);
    PopulateRow(36, pGetVersion.Software);
    PopulateRow(37, pGetVersion.Time_Local);
    PopulateRow(38, pGetVersion.Time_UTC);
    PopulateRow(39, pGetVersion.UI_Board_Hardware);
    PopulateRow(40, pGetVersion.UI_Board_Software);
    PopulateRow(41, pGetVersion.UI_Name);
    PopulateRow(42, pGetVersion.UI_Version);
    PopulateRow(43, pGetVersion.VacuumPwr);
    PopulateRow(44, pGetVersion.VacuumPwrEco);
    PopulateRow(45, pGetVersion.WallSensorType);
    PopulateRow(46, pGetVersion.WheelPodType);
  end;

  pReadData.Free;
  pGetVersion.Free;
end;

end.
