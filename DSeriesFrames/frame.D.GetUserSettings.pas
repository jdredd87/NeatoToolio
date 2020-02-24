unit frame.D.GetUserSettings;

interface

uses
  frame.master,
  dmCommon,
  neato.D.GetUserSettings,
  FMX.TabControl, FMX.objects,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Layouts;

type
  TframeDGetUserSettings = class(TframeMaster)
    lblGetUserSettingsLanguage: TLabel;
    lblGetUserSettingsLanguageValue: TLabel;
    lblGetUserSettingsClickSounds: TLabel;
    swGetUserSettingsClickSoundsValue: TSwitch;
    lblGetUserSettingsLED: TLabel;
    swGetUserSettingsLEDValue: TSwitch;
    lblGetUserSettingsWallEnable: TLabel;
    swGetUserSettingsWallEnableValue: TSwitch;
    lblGetUserSettingsEcoMode: TLabel;
    swGetUserSettingsEcoModeValue: TSwitch;
    lblGetUserSettingsIntenseClean: TLabel;
    swGetUserSettingsIntenseCleanValue: TSwitch;
    lblGetUserSettingsWiFi: TLabel;
    swGetUserSettingsWiFiValue: TSwitch;
    lblGetUserSettingsMelodySounds: TLabel;
    swGetUserSettingsMelodySoundsValue: TSwitch;
    lblGetUserSettingsWarningSounds: TLabel;
    swGetUserSettingsWarningSoundsValue: TSwitch;
    lblGetUserSettingsBinFullDetect: TLabel;
    swGetUserSettingsBinFullDetectValue: TSwitch;
    lblGetUserSettingsFilterChnageTimeseconds: TLabel;
    lblGetUserSettingsFilterChnageTimesecondsValue: TLabel;
    lblGetUserSettingsBrushChangeTimeseconds: TLabel;
    lblGetUserSettingsBrushChangeTimesecondsValue: TLabel;
    lblGetUserSettingsDirtBinAlertReminderIntervalminutes: TLabel;
    lblGetUserSettingsDirtBinAlertReminderIntervalminutesValue: TLabel;
    lblGetUserSettingsCurrentDirtBinRuntimeis: TLabel;
    lblGetUserSettingsCurrentDirtBinRuntimeisValue: TLabel;
    lblGetUserSettingsNumberofCleaningwhereDustBinWasFullis: TLabel;
    lblGetUserSettingsNumberofCleaningwhereDustBinWasFullisValue: TLabel;
    lblGetUserSettingsScheduleis: TLabel;
    swGetUserSettingsScheduleisValue: TSwitch;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;

    procedure timer_GetDataTimer(Sender: TObject);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; Rect: TRectangle); reintroduce; overload;
    procedure check;
  end;

implementation

{$R *.fmx}

constructor TframeDGetUserSettings.Create(AOwner: TComponent; Rect: TRectangle);
begin
  inherited Create(AOwner, Rect);
  lblFrameTitle.Text := sDescription;
end;

procedure TframeDGetUserSettings.timer_GetDataTimer(Sender: TObject);
var
  pGetUserSettings: tGetUserSettingsD;
  pReadData: TStringList;
  r: Boolean;
begin

  if (dm.com.Active = false) or (dm.ActiveTab <> Tab) then
  begin
    timer_GetData.Enabled := false;
    exit;
  end;

  pGetUserSettings := tGetUserSettingsD.Create;

  pReadData := TStringList.Create;
  pReadData.Text := dm.com.SendCommand(sGetUserSettings);

  r := pGetUserSettings.ParseText(pReadData);

  if r then
  begin
    lblGetUserSettingsLanguageValue.Text := pGetUserSettings.Language;
    lblGetUserSettingsFilterChnageTimesecondsValue.Text := pGetUserSettings.Filter_Change_Time_seconds.ToString;
    lblGetUserSettingsBrushChangeTimesecondsValue.Text := pGetUserSettings.Brush_Change_Time_seconds.ToString;
    lblGetUserSettingsDirtBinAlertReminderIntervalminutesValue.Text :=
      pGetUserSettings.Dirt_Bin_Alert_Reminder_Interval_minutes.ToString;
    lblGetUserSettingsCurrentDirtBinRuntimeisValue.Text := pGetUserSettings.Current_Dirt_Bin_Runtime_is.ToString;
    lblGetUserSettingsNumberofCleaningwhereDustBinWasFullisValue.Text :=
      pGetUserSettings.Number_of_Cleanings_where_Dust_Bin_was_Full_is.ToString;

    swGetUserSettingsClickSoundsValue.IsChecked := pGetUserSettings.ClickSounds;
    swGetUserSettingsLEDValue.IsChecked := pGetUserSettings.LED;
    swGetUserSettingsWallEnableValue.IsChecked := pGetUserSettings.Wall_Enable;
    swGetUserSettingsEcoModeValue.IsChecked := pGetUserSettings.Eco_Mode;
    swGetUserSettingsIntenseCleanValue.IsChecked := pGetUserSettings.IntenseClean;
    swGetUserSettingsWiFiValue.IsChecked := pGetUserSettings.WiFi;
    swGetUserSettingsMelodySoundsValue.IsChecked := pGetUserSettings.Melody_Sounds;
    swGetUserSettingsWarningSoundsValue.IsChecked := pGetUserSettings.Warning_Sounds;
    swGetUserSettingsBinFullDetectValue.IsChecked := pGetUserSettings.Bin_Full_Detect;
    swGetUserSettingsScheduleisValue.IsChecked := pGetUserSettings.Schedule_is;

  end;

  pReadData.Free;
  pGetUserSettings.Free;
end;

procedure TframeDGetUserSettings.check;
begin
  //
end;

end.
