unit frame.DXV.SetLCD;

interface

uses
  frame.master,
  dmCommon,
  neato.DXV.SetLCD,
  neato.helpers, FMX.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, System.Math.Vectors, FMX.Types3D,
  FMX.Controls3D, FMX.Objects3D, FMX.Viewport3D, FMX.MaterialSources, FMX.Controls.Presentation, FMX.Layers3D,
  System.Rtti, FMX.Grid.Style, FMX.Grid, FMX.ScrollBox, FMX.Objects, FMX.Ani, FMX.Edit, FMX.EditBox, FMX.SpinBox;

type
  TframeDXVSetLCD = class(TframeMaster)
    lblSetLCDError: TLabel;
    rectSetLCDTop: TRectangle;
    lblSetLCDMessage: TLabel;
    lblSetLCDContrast: TLabel;
    tbSetLCDContrast: TTrackBar;
    btnSetLCDBGWhite: TButton;
    btnSetLCDBGBlack: TButton;
    btnSetLCDHLine: TButton;
    btnSetLCDVLine: TButton;
    btnSetLCDHBars: TButton;
    btnSetLCDVBars: TButton;
    btnSetLCDFGWhite: TButton;
    btnSetLCDFGBlack: TButton;
    sbHLineValue: TSpinBox;
    sbVLineValue: TSpinBox;
    sbFGWhiteValue: TSpinBox;
    sbFGBlackValue: TSpinBox;
    btnSetLCDHBars2: TButton;
    procedure btnSetLCDBGWhiteMouseEnter(Sender: TObject);
    procedure btnSetLCDBGWhiteMouseLeave(Sender: TObject);
    procedure btnSetLCDClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure check;
    constructor Create(AOwner: TComponent); reintroduce; overload;
  end;

implementation

{$R *.fmx}

constructor TframeDXVSetLCD.Create(AOwner: TComponent);
begin
  inherited;
  lblFrameTitle.Text := sDescription;
end;

procedure TframeDXVSetLCD.btnSetLCDClick(Sender: TObject);
var
  cmd: string;
  pSetLCD: tSetLCD;
  pReadData: TStringList;
  r: Boolean;
  idx: integer;
begin
  cmd := '';

  if Sender = btnSetLCDBGWhite then
    cmd := sBGWhite;

  if Sender = btnSetLCDBGBlack then
    cmd := sBGBlack;

  if Sender = btnSetLCDHLine then
    cmd := sHLine + ' ' + round(self.sbHLineValue.Value).ToString;

  if Sender = btnSetLCDVLine then
    cmd := sVLine + ' ' + round(self.sbVLineValue.Value).ToString;

  if Sender = btnSetLCDHBars then
    cmd := sHBars;

  if Sender = btnSetLCDVBars then
    cmd := sVBars;

  if Sender = btnSetLCDFGWhite then
    cmd := sFGWhite + ' ' + round(self.sbFGWhiteValue.Value).ToString;

  if Sender = btnSetLCDFGBlack then
    cmd := sFGBlack + ' ' + round(self.sbFGBlackValue.Value).ToString;

  if Sender = tbSetLCDContrast then
  begin
    lblSetLCDContrast.Text := 'Contrast ' + round(tbSetLCDContrast.Value).ToString + '%';
    cmd := sContrast + ' ' + round(tbSetLCDContrast.Value).ToString;
  end;

  if Sender = btnSetLCDHBars2 then
  begin
    cmd := '';
    dm.chkTestmode.IsChecked := true;
    sleep(250);

    tbSetLCDContrast.Enabled := false;
    btnSetLCDBGWhite.Enabled := false;
    btnSetLCDBGBlack.Enabled := false;
    btnSetLCDHLine.Enabled := false;
    btnSetLCDVLine.Enabled := false;
    btnSetLCDHBars.Enabled := false;
    btnSetLCDVBars.Enabled := false;
    btnSetLCDFGWhite.Enabled := false;
    btnSetLCDFGBlack.Enabled := false;
    sbHLineValue.Enabled := false;
    sbVLineValue.Enabled := false;
    sbFGWhiteValue.Enabled := false;
    sbFGBlackValue.Enabled := false;
    btnSetLCDHBars2.Enabled := false;

    lblSetLCDError.Text := 'Please wait a few seconds for this to complete...';
    tthread.CreateAnonymousThread(
      procedure
      var
        cmd2: string;
        pSetLCD2: tSetLCD;
        pReadData2: TStringList;
        idx2: integer;
      begin
        pSetLCD2 := tSetLCD.Create;
        pReadData2 := TStringList.Create;

        for idx2 := 0 to 127 do
        begin
          tthread.Synchronize(tthread.CurrentThread,
            procedure
            begin
              lblSetLCDError.Text := 'Please wait a few seconds for this to complete... ' + idx2.ToString;
            end);

          sleep(100);

          if odd(idx2) then
            continue;
          pReadData2.Text := dm.com.SendCommand(sSetLCD + ' ' + sHLine + ' ' + idx2.ToString);
        end;

        // r := pSetLCD.ParseText(pReadData2);

        pReadData2.Free;
        pSetLCD2.Free;

        tthread.Synchronize(tthread.CurrentThread,
          procedure
          begin
            tbSetLCDContrast.Enabled := true;
            btnSetLCDBGWhite.Enabled := true;
            btnSetLCDBGBlack.Enabled := true;
            btnSetLCDHLine.Enabled := true;
            btnSetLCDVLine.Enabled := true;
            btnSetLCDHBars.Enabled := true;
            btnSetLCDVBars.Enabled := true;
            btnSetLCDFGWhite.Enabled := true;
            btnSetLCDFGBlack.Enabled := true;
            sbHLineValue.Enabled := true;
            sbVLineValue.Enabled := true;
            sbFGWhiteValue.Enabled := true;
            sbFGBlackValue.Enabled := true;
            btnSetLCDHBars2.Enabled := true;
            lblSetLCDError.Text := '';
          end);
      end).Start;

  end;

  if cmd <> '' then
  begin

    dm.chkTestmode.IsChecked := true;
    sleep(250);

    pSetLCD := tSetLCD.Create;

    pReadData := TStringList.Create;
    pReadData.Text := dm.com.SendCommand(sSetLCD + ' ' + cmd);

    r := pSetLCD.ParseText(pReadData);

    if r then
      lblSetLCDMessage.Text := ''
    else
      lblSetLCDMessage.Text := pSetLCD.Error;

    pReadData.Free;
    pSetLCD.Free;

  end;

  resetfocus;
end;

procedure TframeDXVSetLCD.btnSetLCDBGWhiteMouseEnter(Sender: TObject);
var
  msg: string;
begin
  msg := '';

  if Sender = tbSetLCDContrast then
    msg := sContrastMSG;
  if Sender = btnSetLCDBGWhite then
    msg := sBGWhiteMSG;
  if Sender = btnSetLCDBGBlack then
    msg := sBGBlackMSG;
  if Sender = btnSetLCDHLine then
    msg := sHLineMSG;
  if Sender = btnSetLCDVLine then
    msg := sVLineMSG;
  if Sender = btnSetLCDHBars then
    msg := sHBarsMSG;
  if Sender = btnSetLCDVBars then
    msg := sVBarsMSG;
  if Sender = btnSetLCDFGWhite then
    msg := sFGWhiteMSG;
  if Sender = btnSetLCDFGBlack then
    msg := sFGBlackMSG;

  if Sender = btnSetLCDHBars2 then
    msg := 'Draw alternating horizontal lines (FG,BG,FG,BG,…),across the whole screen. Line by line. (Slow)';

  if msg <> '' then
    lblSetLCDMessage.Text := msg;
end;

procedure TframeDXVSetLCD.btnSetLCDBGWhiteMouseLeave(Sender: TObject);
begin
  lblSetLCDMessage.Text := '';
end;

procedure TframeDXVSetLCD.check;
begin
  tbSetLCDContrast.Enabled := dm.com.Active;
  btnSetLCDBGWhite.Enabled := dm.com.Active;
  btnSetLCDBGBlack.Enabled := dm.com.Active;
  btnSetLCDHLine.Enabled := dm.com.Active;
  btnSetLCDVLine.Enabled := dm.com.Active;
  btnSetLCDHBars.Enabled := dm.com.Active;
  btnSetLCDVBars.Enabled := dm.com.Active;
  btnSetLCDFGWhite.Enabled := dm.com.Active;
  btnSetLCDFGBlack.Enabled := dm.com.Active;
  sbHLineValue.Enabled := dm.com.Active;
  sbVLineValue.Enabled := dm.com.Active;
  sbFGWhiteValue.Enabled := dm.com.Active;
  sbFGBlackValue.Enabled := dm.com.Active;
  btnSetLCDHBars2.Enabled := dm.com.Active;

  if dm.com.Active then
    dm.chkTestmode.IsChecked := true;
end;

end.
