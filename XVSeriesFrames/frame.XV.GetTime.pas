unit frame.XV.GetTime;

interface

uses
  frame.master,
  dmCommon,
  neato.XV.GetTime, fmx.objects,
  fmx.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  fmx.Types, fmx.Graphics, fmx.Controls, fmx.Forms, fmx.Dialogs, fmx.StdCtrls, fmx.Controls.Presentation,
  fmx.DateTimeCtrls,  fmx.Layouts, fmx.Effects, fmx.Filter.Effects;

type
  // https://www.youtube.com/watch?v=QL5SdJAiWGE
  // Used his simple 3 line clock example!

  TframeXVGetTime = class(TframeMaster)
    lblGetTime: TLabel;
    ScaledLayout1: TScaledLayout;
    circleGetTime: TCircle;
    Layout12GetTime: TLayout;
    Text_12: TText;
    rrHour: TRoundRect;
    rrMin: TRoundRect;
    rrSec: TRoundRect;
    Layout1GetTime: TLayout;
    Text_1: TText;
    Layout2GetTime: TLayout;
    Text_2: TText;
    Layout3GetTime: TLayout;
    Text_3: TText;
    Layout4GetTime: TLayout;
    Text_4: TText;
    Layout5GetTime: TLayout;
    Text_5: TText;
    Layout6GetTime: TLayout;
    Text_6: TText;
    Layout7GetTime: TLayout;
    Text_7: TText;
    Layout8GetTime: TLayout;
    Text_8: TText;
    Layout9GetTime: TLayout;
    Text_9: TText;
    Layout10GetTime: TLayout;
    Text_10: TText;
    Layout11GetTime: TLayout;
    text_11: TText;
    ShadowEffect1: TShadowEffect;
    PixelateEffect1: TPixelateEffect;
    timer_Pixelate: TTimer;
    procedure timer_GetDataTimer(Sender: TObject);
    procedure circleGetTimeDblClick(Sender: TObject);
    procedure timer_PixelateTimer(Sender: TObject);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; Rect: TRectangle); reintroduce; overload;
    procedure check;
  end;

implementation

{$R *.fmx}

constructor TframeXVGetTime.Create(AOwner: TComponent; Rect: TRectangle);
begin
  inherited Create(AOwner, Rect);
  lblFrameTitle.Text := sDescription;
end;

procedure TframeXVGetTime.timer_GetDataTimer(Sender: TObject);
var
  pGetTime: tGetTimeXV;
  pReadData: TStringList;
  r: Boolean;
begin

  if (dm.com.Active = false) or (dm.ActiveTab <> tab) then
  begin
    timer_GetData.Enabled := false;
    exit;
  end;

  pGetTime := tGetTimeXV.Create;

  pReadData := TStringList.Create;
  pReadData.Text := dm.com.SendCommand(sGetTime);

  r := pGetTime.ParseText(pReadData);

  if r then
  begin
    lblGetTime.Text := pGetTime.Day + ' ' + timetostr(pGetTime._Time);
    rrHour.RotationAngle := (30 * StrToInt(FormatDateTime('h', pGetTime._Time))) +
      (6 * (StrToInt(FormatDateTime('n', pGetTime._Time)) / 12));
    rrMin.RotationAngle := 6 * StrToInt(FormatDateTime('n', pGetTime._Time));
    rrSec.RotationAngle := 6 * StrToInt(FormatDateTime('ss', pGetTime._Time));
  end;

  pReadData.Free;
  pGetTime.Free;
end;

// lets have a little fun since this is a boring frame
procedure TframeXVGetTime.circleGetTimeDblClick(Sender: TObject);
begin
  PixelateEffect1.BlockCount := 1000;
  timer_Pixelate.Tag := 0;
  timer_Pixelate.Enabled := true;
  PixelateEffect1.Enabled := true;
end;

procedure TframeXVGetTime.timer_PixelateTimer(Sender: TObject);
begin
  if timer_Pixelate.Tag = 0 then
  begin
    PixelateEffect1.BlockCount := PixelateEffect1.BlockCount - 25;
    if PixelateEffect1.BlockCount <= 50 then
      timer_Pixelate.Tag := 1;
  end;

  if timer_Pixelate.Tag = 1 then
  begin
    PixelateEffect1.BlockCount := PixelateEffect1.BlockCount + 25;
    if PixelateEffect1.BlockCount >= 1000 then
    begin
      timer_Pixelate.Tag := 0;
      timer_Pixelate.Enabled := false;
      PixelateEffect1.Enabled := false;
    end;
  end;
end;

procedure TframeXVGetTime.check;
begin
  //
end;

end.
