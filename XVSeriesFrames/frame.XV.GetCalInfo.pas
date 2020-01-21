unit frame.XV.GetCalInfo;

interface

uses
  dmCommon,
  neato.XV.GetCalInfo,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation;

type
  TframeXVGetCalInfo = class(TFrame)
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
    lblGetCalInfoQAState: TLabel;
    lblGetCalInfoQAStateValue: TLabel;
    timer_GetData: TTimer;
    lblGetCalInfoRDropMin: TLabel;
    lblGetCalInfoRDropMinValue: TLabel;
    lblGetCalInfoRDropMid: TLabel;
    lblGetCalInfoRDropMidValue: TLabel;
    lblGetCalInfoRDropMax: TLabel;
    lblGetCalInfoRDropMaxValue: TLabel;
    lblGetCalInfoLDropMin: TLabel;
    lblGetCalInfoLDropMinValue: TLabel;
    lblGetCalInfoLDropMid: TLabel;
    lblGetCalInfoLDropMidValue: TLabel;
    lblGetCalInfoLCDContrast: TLabel;
    lblGetCalInfoLCDContrastValue: TLabel;
    lblGetCalInfoWallMin: TLabel;
    lblGetCalInfoWallMinValue: TLabel;
    lblGetCalInfoWallMid: TLabel;
    lblGetCalInfoWallMidValue: TLabel;
    lblGetCalInfoWallMax: TLabel;
    lblGetCalInfoWallMaxValue: TLabel;
    lblGetCalInfoLDropMax: TLabel;
    lblGetCalInfoLDropMaxValue: TLabel;
    procedure timer_GetDataTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

procedure TframeXVGetCalInfo.timer_GetDataTimer(Sender: TObject);
var
  pGetCalInfo: tGetCalInfoXV;
  pReadData: TStringList;
  r: Boolean;
begin

  if (dm.com.Serial.Active = false) then
  begin
    timer_GetData.Enabled := false;
    exit;
  end;

  pGetCalInfo := tGetCalInfoxv.Create;

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

    lblGetCalInfoLCDContrastValue.Text := pGetCalInfo.LCDContrast.ToString;
    lblGetCalInfoRDropMinValue.Text := pGetCalInfo.RDropMin.ToString;
    lblGetCalInfoRDropMidValue.Text := pGetCalInfo.RDropMid.ToString;
    lblGetCalInfoRDropMaxValue.Text := pGetCalInfo.RDropMax.ToString;
    lblGetCalInfoLDropMinValue.Text := pGetCalInfo.LDropMin.ToString;
    lblGetCalInfoLDropMidValue.Text := pGetCalInfo.LDropMid.ToString;
    lblGetCalInfoLCDContrastValue.Text := pGetCalInfo.LDropMax.ToString;
    lblGetCalInfoWallMinValue.Text := pGetCalInfo.WallMin.ToString;
    lblGetCalInfoWallMidValue.Text := pGetCalInfo.WallMid.ToString;
    lblGetCalInfoWallMaxValue.Text := pGetCalInfo.WallMax.ToString;


    lblGetCalInfoQAStateValue.Text := pGetCalInfo.QAState;
    lblGetCalInfoCleaningTestSurfaceValue.Text := pGetCalInfo.CleaningTestSurface;
    lblGetCalInfoCleaningTestHardSpeedValue.Text := pGetCalInfo.CleaningTestHardSpeed.ToString;
    lblGetCalInfoCleaningTestCarpetSpeedValue.Text := pGetCalInfo.CleaningTestCarpetSpeed.ToString;
    lblGetCalInfoCleaningTestHardDistanceValue.Text := pGetCalInfo.CleaningTestHardDistance.ToString;
    lblGetCalInfoCleaningTestCarpetDistanceValue.Text := pGetCalInfo.CleaningTestCarpetDistance.ToString;
  end;

  pReadData.Free;
  pGetCalInfo.Free;
end;


end.
