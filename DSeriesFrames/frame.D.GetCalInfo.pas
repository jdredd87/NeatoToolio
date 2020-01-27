unit frame.D.GetCalInfo;

interface

uses
  frame.master,
  dmCommon,
  neato.D.GetCalInfo,FMX.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation;

type
  TframeDGetCalInfo = class(TframeMaster)
    lblGetCalInfoLDSOffset: TLabel;
    lblGetCalInfoLDSOffsetValue: TLabel;
    lblGetCalInfoXAccel: TLabel;
    lblGetCalInfoXAccelValue: TLabel;
    lblGetCalInfoYAccel: TLabel;
    lblGetCalInfoYAccelValue: TLabel;
    lblGetCalInfoZAccel: TLabel;
    lblGetCalInfoZAccelValue: TLabel;
    lblGetCalInfoRTCOffset: TLabel;
    lblGetCalInfoRTCOffsetValue: TLabel;
    lblGetCalInfoCleaningTestSurface: TLabel;
    lblGetCalInfoCleaningTestSurfaceValue: TLabel;
    lblGetCalInfoCleaningTestHardSpeed: TLabel;
    lblGetCalInfoCleaningTestHardSpeedValue: TLabel;
    lblGetCalInfoCleaningTestCarpetSpeed: TLabel;
    lblGetCalInfoCleaningTestCarpetSpeedValue: TLabel;
    lblGetCalInfoCleaningTestHardDistance: TLabel;
    lblGetCalInfoCleaningTestHardDistanceValue: TLabel;
    lblGetCalInfoCleaningTestCarpetDistance: TLabel;
    lblGetCalInfoCleaningTestCarpetDistanceValue: TLabel;
    lblGetCalInfoCleaningTestMode: TLabel;
    lblGetCalInfoCleaningTestModeValue: TLabel;
    lblGetCalInfoQAState: TLabel;
    lblGetCalInfoQAStateValue: TLabel;
    lblGetCalInfoLeftDropSensor_CalibrationData: TLabel;
    lblGetCalInfoLeftDropSensor_CalibrationDataValue: TLabel;
    lblGetCalInfoRightDropSensor_CalibrationData: TLabel;
    lblGetCalInfoRightDropSensor_CalibrationDataValue: TLabel;
    lblGetCalInfoWheelDropSensor_CalibrationData: TLabel;
    lblGetCalInfoWheelDropSensor_CalibrationDataValue: TLabel;
    lblGetCalInfoWallSensor_CalibrationData: TLabel;
    lblGetCalInfoWallSensor_CalibrationDataValue: TLabel;
    procedure timer_GetDataTimer(Sender: TObject);
  private
    { Private declarations }
  public
  end;

implementation

{$R *.fmx}

procedure TframeDGetCalInfo.timer_GetDataTimer(Sender: TObject);
var
  pGetCalInfo: tGetCalInfoD;
  pReadData: TStringList;
  r: Boolean;
begin

  if (dm.com.Serial.Active = false) or (dm.ActiveTab <> tab) then
  begin
    timer_GetData.Enabled := false;
    exit;
  end;

  pGetCalInfo := tGetCalInfoD.Create;

  pReadData := TStringList.Create;
  pReadData.Text := dm.com.SendCommand(sGetCalInfo);

  r := pGetCalInfo.ParseText(pReadData);

  if r then
  begin
    lblGetCalInfoLDSOffsetValue.Text := pGetCalInfo.LDSOffset.ToString;
    lblGetCalInfoXAccelValue.Text := pGetCalInfo.XAccel.ToString;
    lblGetCalInfoYAccelValue.Text := pGetCalInfo.YAccel.ToString;
    lblGetCalInfoZAccelValue.Text := pGetCalInfo.ZAccel.ToString;
    lblGetCalInfoRTCOffsetValue.Text := pGetCalInfo.RTCOffset.ToString;
    lblGetCalInfoCleaningTestSurfaceValue.Text := pGetCalInfo.CleaningTestSurface;
    lblGetCalInfoCleaningTestHardSpeedValue.Text := pGetCalInfo.CleaningTestHardSpeed.ToString;
    lblGetCalInfoCleaningTestCarpetSpeedValue.Text := pGetCalInfo.CleaningTestCarpetSpeed.ToString;
    lblGetCalInfoCleaningTestHardDistanceValue.Text := pGetCalInfo.CleaningTestHardDistance.ToString;
    lblGetCalInfoCleaningTestCarpetDistanceValue.Text := pGetCalInfo.CleaningTestCarpetDistance.ToString;
    lblGetCalInfoCleaningTestModeValue.Text := pGetCalInfo.CleaningTestMode.ToString;
    lblGetCalInfoQAStateValue.Text := pGetCalInfo.QAState;
    lblGetCalInfoLeftDropSensor_CalibrationDataValue.Text := pGetCalInfo.LeftDropSensor_CalibrationData.ToString;
    lblGetCalInfoRightDropSensor_CalibrationDataValue.Text := pGetCalInfo.RightDropSensor_CalibrationData.ToString;
    lblGetCalInfoWheelDropSensor_CalibrationDataValue.Text := pGetCalInfo.WheelDropSensor_CalibrationData.ToString;
    lblGetCalInfoWallSensor_CalibrationDataValue.Text := pGetCalInfo.WallSensor_CalibrationData.ToString;
  end;

  pReadData.Free;
  pGetCalInfo.Free;
end;


end.
