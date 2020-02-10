unit frame.D.GetCalInfo;

interface

uses
  frame.master,
  dmCommon,
  neato.D.GetCalInfo,
  FMX.TabControl,
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

    lblGetCalInfoSNSRCAL_LEFT_DROP_NDX_SNSRCAL_MIN_DISTANCE_NDX: TLabel;
    lblGetCalInfoSNSRCAL_LEFT_DROP_NDX_SNSRCAL_MID_DISTANCE_NDX: TLabel;
    lblGetCalInfoSNSRCAL_LEFT_DROP_NDX_SNSRCAL_MAX_DISTANCE_NDX: TLabel;
    lblGetCalInfoSNSRCAL_RIGHT_DROP_NDX_SNSRCAL_MIN_DISTANCE_NDX: TLabel;
    lblGetCalInfoSNSRCAL_RIGHT_DROP_NDX_SNSRCAL_MID_DISTANCE_NDX: TLabel;
    lblGetCalInfoSNSRCAL_RIGHT_DROP_NDX_SNSRCAL_MAX_DISTANCE_NDX: TLabel;
    lblGetCalInfoSNSRCAL_WHEEL_DROP_NDX_SNSRCAL_MIN_DISTANCE_NDX: TLabel;
    lblGetCalInfoSNSRCAL_WHEEL_DROP_NDX_SNSRCAL_MID_DISTANCE_NDX: TLabel;
    lblGetCalInfoSNSRCAL_WHEEL_DROP_NDX_SNSRCAL_MAX_DISTANCE_NDX: TLabel;
    lblGetCalInfoSNSRCAL_WALL_NDX_SNSRCAL_MIN_DISTANCE_NDX: TLabel;
    lblGetCalInfoSNSRCAL_WALL_NDX_SNSRCAL_MID_DISTANCE_NDX: TLabel;
    lblGetCalInfoSNSRCAL_WALL_NDX_SNSRCAL_MAX_DISTANCE_NDX: TLabel;

    lblValue1: TLabel;
    lblValue2: TLabel;
    lblValue3: TLabel;
    lblValue4: TLabel;
    lblValue5: TLabel;
    lblValue6: TLabel;
    lblValue7: TLabel;
    lblValue8: TLabel;
    lblValue9: TLabel;
    lblValue10: TLabel;
    lblValue11: TLabel;
    lblValue12: TLabel;

    lblValue1A: TLabel;
    lblValue2A: TLabel;
    lblValue3A: TLabel;
    lblValue4A: TLabel;
    lblValue5A: TLabel;
    lblValue6A: TLabel;
    lblValue7A: TLabel;
    lblValue8A: TLabel;
    lblValue9A: TLabel;
    lblValue10A: TLabel;
    lblValue11A: TLabel;
    lblValue12A: TLabel;

    procedure timer_GetDataTimer(Sender: TObject);
  private
    { Private declarations }
  public
    procedure check;
    constructor Create(AOwner: TComponent); reintroduce; overload;
  end;

implementation

{$R *.fmx}

constructor TframeDGetCalInfo.Create(AOwner: TComponent);
begin
  inherited;
  lblFrameTitle.Text := sDescription;
end;

procedure TframeDGetCalInfo.check;
begin
  lblGetCalInfoSNSRCAL_LEFT_DROP_NDX_SNSRCAL_MIN_DISTANCE_NDX.enabled := neatoType = BotVac;
  lblGetCalInfoSNSRCAL_LEFT_DROP_NDX_SNSRCAL_MID_DISTANCE_NDX.enabled := neatoType = BotVac;
  lblGetCalInfoSNSRCAL_LEFT_DROP_NDX_SNSRCAL_MAX_DISTANCE_NDX.enabled := neatoType = BotVac;
  lblGetCalInfoSNSRCAL_RIGHT_DROP_NDX_SNSRCAL_MIN_DISTANCE_NDX.enabled := neatoType = BotVac;
  lblGetCalInfoSNSRCAL_RIGHT_DROP_NDX_SNSRCAL_MID_DISTANCE_NDX.enabled := neatoType = BotVac;
  lblGetCalInfoSNSRCAL_RIGHT_DROP_NDX_SNSRCAL_MAX_DISTANCE_NDX.enabled := neatoType = BotVac;
  lblGetCalInfoSNSRCAL_WHEEL_DROP_NDX_SNSRCAL_MIN_DISTANCE_NDX.enabled := neatoType = BotVac;
  lblGetCalInfoSNSRCAL_WHEEL_DROP_NDX_SNSRCAL_MID_DISTANCE_NDX.enabled := neatoType = BotVac;
  lblGetCalInfoSNSRCAL_WHEEL_DROP_NDX_SNSRCAL_MAX_DISTANCE_NDX.enabled := neatoType = BotVac;
  lblGetCalInfoSNSRCAL_WALL_NDX_SNSRCAL_MIN_DISTANCE_NDX.enabled := neatoType = BotVac;
  lblGetCalInfoSNSRCAL_WALL_NDX_SNSRCAL_MID_DISTANCE_NDX.enabled := neatoType = BotVac;
  lblGetCalInfoSNSRCAL_WALL_NDX_SNSRCAL_MAX_DISTANCE_NDX.enabled := neatoType = BotVac;

  lblValue1.enabled := neatoType = BotVac;
  lblValue2.enabled := neatoType = BotVac;
  lblValue3.enabled := neatoType = BotVac;
  lblValue4.enabled := neatoType = BotVac;
  lblValue5.enabled := neatoType = BotVac;
  lblValue6.enabled := neatoType = BotVac;
  lblValue7.enabled := neatoType = BotVac;
  lblValue8.enabled := neatoType = BotVac;
  lblValue9.enabled := neatoType = BotVac;
  lblValue10.enabled := neatoType = BotVac;
  lblValue11.enabled := neatoType = BotVac;
  lblValue12.enabled := neatoType = BotVac;

  lblValue1A.enabled := neatoType = BotVac;
  lblValue2A.enabled := neatoType = BotVac;
  lblValue3A.enabled := neatoType = BotVac;
  lblValue4A.enabled := neatoType = BotVac;
  lblValue5A.enabled := neatoType = BotVac;
  lblValue6A.enabled := neatoType = BotVac;
  lblValue7A.enabled := neatoType = BotVac;
  lblValue8A.enabled := neatoType = BotVac;
  lblValue9A.enabled := neatoType = BotVac;
  lblValue10A.enabled := neatoType = BotVac;
  lblValue11A.enabled := neatoType = BotVac;
  lblValue12A.enabled := neatoType = BotVac;
end;

procedure TframeDGetCalInfo.timer_GetDataTimer(Sender: TObject);
var
  pGetCalInfo: tGetCalInfoD;
  pReadData: TStringList;
  r: Boolean;
begin

  if (dm.com.Active = false) or (dm.ActiveTab <> tab) then
  begin
    timer_GetData.enabled := false;
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

    lblValue1.Text := pGetCalInfo.SNSRCAL_LEFT_DROP_NDX_SNSRCAL_MIN_DISTANCE_NDX[0].ToString;
    lblValue2.Text := pGetCalInfo.SNSRCAL_LEFT_DROP_NDX_SNSRCAL_MID_DISTANCE_NDX[0].ToString;
    lblValue3.Text := pGetCalInfo.SNSRCAL_LEFT_DROP_NDX_SNSRCAL_MAX_DISTANCE_NDX[0].ToString;
    lblValue4.Text := pGetCalInfo.SNSRCAL_RIGHT_DROP_NDX_SNSRCAL_MIN_DISTANCE_NDX[0].ToString;
    lblValue5.Text := pGetCalInfo.SNSRCAL_RIGHT_DROP_NDX_SNSRCAL_MID_DISTANCE_NDX[0].ToString;
    lblValue6.Text := pGetCalInfo.SNSRCAL_RIGHT_DROP_NDX_SNSRCAL_MAX_DISTANCE_NDX[0].ToString;
    lblValue7.Text := pGetCalInfo.SNSRCAL_WHEEL_DROP_NDX_SNSRCAL_MIN_DISTANCE_NDX[0].ToString;
    lblValue8.Text := pGetCalInfo.SNSRCAL_WHEEL_DROP_NDX_SNSRCAL_MID_DISTANCE_NDX[0].ToString;
    lblValue9.Text := pGetCalInfo.SNSRCAL_WHEEL_DROP_NDX_SNSRCAL_MAX_DISTANCE_NDX[0].ToString;
    lblValue10.Text := pGetCalInfo.SNSRCAL_WALL_NDX_SNSRCAL_MIN_DISTANCE_NDX[0].ToString;
    lblValue11.Text := pGetCalInfo.SNSRCAL_WALL_NDX_SNSRCAL_MID_DISTANCE_NDX[0].ToString;
    lblValue12.Text := pGetCalInfo.SNSRCAL_WALL_NDX_SNSRCAL_MAX_DISTANCE_NDX[0].ToString;

    lblValue1A.Text := pGetCalInfo.SNSRCAL_LEFT_DROP_NDX_SNSRCAL_MIN_DISTANCE_NDX[1].ToString + ' mm';
    lblValue2A.Text := pGetCalInfo.SNSRCAL_LEFT_DROP_NDX_SNSRCAL_MID_DISTANCE_NDX[1].ToString + ' mm';
    lblValue3A.Text := pGetCalInfo.SNSRCAL_LEFT_DROP_NDX_SNSRCAL_MAX_DISTANCE_NDX[1].ToString + ' mm';
    lblValue4A.Text := pGetCalInfo.SNSRCAL_RIGHT_DROP_NDX_SNSRCAL_MIN_DISTANCE_NDX[1].ToString + ' mm';
    lblValue5A.Text := pGetCalInfo.SNSRCAL_RIGHT_DROP_NDX_SNSRCAL_MID_DISTANCE_NDX[1].ToString + ' mm';
    lblValue6A.Text := pGetCalInfo.SNSRCAL_RIGHT_DROP_NDX_SNSRCAL_MAX_DISTANCE_NDX[1].ToString + ' mm';
    lblValue7A.Text := pGetCalInfo.SNSRCAL_WHEEL_DROP_NDX_SNSRCAL_MIN_DISTANCE_NDX[1].ToString + ' mm';
    lblValue8A.Text := pGetCalInfo.SNSRCAL_WHEEL_DROP_NDX_SNSRCAL_MID_DISTANCE_NDX[1].ToString + ' mm';
    lblValue9A.Text := pGetCalInfo.SNSRCAL_WHEEL_DROP_NDX_SNSRCAL_MAX_DISTANCE_NDX[1].ToString + ' mm';
    lblValue10A.Text := pGetCalInfo.SNSRCAL_WALL_NDX_SNSRCAL_MIN_DISTANCE_NDX[1].ToString + ' mm';
    lblValue11A.Text := pGetCalInfo.SNSRCAL_WALL_NDX_SNSRCAL_MID_DISTANCE_NDX[1].ToString + ' mm';
    lblValue12A.Text := pGetCalInfo.SNSRCAL_WALL_NDX_SNSRCAL_MAX_DISTANCE_NDX[1].ToString + ' mm';

  end;

  pReadData.Free;
  pGetCalInfo.Free;
end;

end.
