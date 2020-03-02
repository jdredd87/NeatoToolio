unit frame.XV.Clean;

interface

uses
  frame.master,
  dmCommon,
  neato.XV.Clean,
  neato.errors, FMX.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Objects,
  FMX.Layouts;

type
  TframeXVClean = class(TframeMaster)
    btnCleanHouse: TButton;
    btnCleanSpot: TButton;
    btnCleanStop: TButton;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    lblCleanError: TLabel;
    procedure btnCleanClick(Sender: TObject);
    procedure timer_getdataTimer(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Check;
    constructor Create(AOwner: TComponent; Rect: TRectangle); reintroduce; overload;
  end;

implementation

{$R *.fmx}

constructor TframeXVClean.Create(AOwner: TComponent; Rect: TRectangle);
begin
  inherited Create(AOwner, Rect);
  lblFrameTitle.Text := sDescription;
end;

procedure TframeXVClean.timer_getdataTimer(Sender: TObject);
begin
  inherited;
  //
end;

procedure TframeXVClean.btnCleanClick(Sender: TObject);
var
  pReadData: TStringList;
  pCleanXV: tCleanXV;
  r: boolean;
  command: string;
begin
  pCleanXV := tCleanXV.Create;
  pReadData := TStringList.Create;

  if Sender = self.btnCleanHouse then
    command := sHouse;
  if Sender = self.btnCleanHouse then
    command := sSpot;
  if Sender = self.btnCleanHouse then
    command := sStop;

  pReadData.Text := dm.com.SendCommand(sClean + ' ' + sHouse);

  r := pCleanXV.ParseText(pReadData);

  if r then
    lblCleanError.Text := pCleanXV.Error;

  freeandnil(pCleanXV);
  freeandnil(pReadData);

  resetfocus;
end;

procedure TframeXVClean.Check;
begin
  btnCleanHouse.Enabled := dm.com.Active;
  btnCleanSpot.Enabled := dm.com.Active;
  btnCleanStop.Enabled := dm.com.Active;
end;

end.
