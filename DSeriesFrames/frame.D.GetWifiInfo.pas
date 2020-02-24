unit frame.D.GetWifiInfo;

interface

uses
  frame.master,
  dmcommon,
  neato.helpers,
  neato.D.GetWifiInfo,
  FMX.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, System.Rtti, FMX.Grid.Style, FMX.Grid,
  FMX.ScrollBox, FMX.Controls.Presentation, FMX.Objects, FMX.Layouts;

type
  TframeDGetWifiInfo = class(TframeMaster)
    pnlGetWifiInfoTop: trectangle;
    btnGetWifiInfoScan: TButton;
    aniGetWifiInfo: TAniIndicator;
    sgGetWifiInfo: TStringGrid;
    sgGetWifiInfoSSID: TStringColumn;
    sgGetWifiInfoSignal: TStringColumn;
    sgGetWifiInfoFrequency: TStringColumn;
    sgGetWifiInfoBSSID: TStringColumn;
    procedure btnGetWifiInfoScanClick(Sender: TObject);
    procedure timer_getdataTimer(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Check;
    constructor Create(AOwner: TComponent; Rect: trectangle); reintroduce; overload;
  end;

implementation

{$R *.fmx}

constructor TframeDGetWifiInfo.Create(AOwner: TComponent; Rect: trectangle);
begin
  inherited Create(AOwner, Rect);
  lblFrameTitle.Text := sDescription;
end;

procedure TframeDGetWifiInfo.timer_getdataTimer(Sender: TObject);
begin
  inherited;
  //
end;

procedure TframeDGetWifiInfo.btnGetWifiInfoScanClick(Sender: TObject);
begin

  aniGetWifiInfo.visible := true;
  btnGetWifiInfoScan.Enabled := false;

  tthread.CreateAnonymousThread(
    procedure
    var
      pReadData: TStringList;
      gGetWifiInfo: tGetWifiInfoD;
      r: Boolean;
    begin
      // make sure to have it ready
      dm.com.PurgeInput;
      dm.com.PurgeOutput;
      dm.com.WaitForReadCompletion;

      dm.com.SendCommandOnly('');
      dm.com.SendCommandOnly('');

      pReadData := TStringList.Create;

      pReadData.Text := dm.com.SendCommandAndWaitForValue(sgetwifiinfo, 16000, ^Z, iGetWifiInfoHeaderBreaks);

      gGetWifiInfo := tGetWifiInfoD.Create;

      tthread.Synchronize(tthread.CurrentThread,
        procedure
        var
          idx: integer;
        begin
          try

            r := gGetWifiInfo.ParseText(pReadData);
            if r then
            begin
              sgGetWifiInfo.BeginUpdate;
              sgGetWifiInfo.RowCount := 0;
              sgGetWifiInfo.RowCount := 10;
              if gGetWifiInfo.GetWifiInfoItems.Count > 0 then
              begin

                sgGetWifiInfo.RowCount := gGetWifiInfo.GetWifiInfoItems.Count;
                for idx := 0 to gGetWifiInfo.GetWifiInfoItems.Count - 1 do
                begin
                  sgGetWifiInfo.Cells[0, idx] := gGetWifiInfo.GetWifiInfoItems.item[idx].SSID;
                  sgGetWifiInfo.Cells[1, idx] := gGetWifiInfo.GetWifiInfoItems.item[idx].Signal.ToString;
                  sgGetWifiInfo.Cells[2, idx] := gGetWifiInfo.GetWifiInfoItems.item[idx].Frequency.ToString;
                  sgGetWifiInfo.Cells[3, idx] := gGetWifiInfo.GetWifiInfoItems.item[idx].BSSID;
                end;
                sgGetWifiInfo.EndUpdate;
              end;
            end;
          finally
            btnGetWifiInfoScan.Enabled := true;
            aniGetWifiInfo.Enabled := false;
            aniGetWifiInfo.visible := false;
          end;
        end);

      freeandnil(pReadData);
      freeandnil(gGetWifiInfo);

    end).start;
  resetfocus;
end;

procedure TframeDGetWifiInfo.Check;
begin
  btnGetWifiInfoScan.Enabled := dm.com.Active;
  sgGetWifiInfo.Clear;
end;

end.
