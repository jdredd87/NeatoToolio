unit frame.XV.RestoreDefaults;

interface

uses
  frame.master,
  dmCommon, fmx.objects,
  neato.XV.RestoreDefaults, fmx.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  fmx.Types, fmx.Graphics, fmx.Controls, fmx.Forms, fmx.Dialogs, fmx.StdCtrls, fmx.Controls.Presentation, fmx.Layouts;

type
  TframeXVRestoreDefaults = class(TframeMaster)
    btnRestoreDefaults: TButton;
    procedure btnRestoreDefaultsClick(Sender: TObject);
    procedure timer_getdataTimer(Sender: TObject);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; Rect: TRectangle); reintroduce; overload;
    procedure Check;
  end;

implementation

{$R *.fmx}

constructor TframeXVRestoreDefaults.Create(AOwner: TComponent; Rect: TRectangle);
begin
  inherited Create(AOwner, Rect);
  lblFrameTitle.Text := sDescription;
end;

procedure TframeXVRestoreDefaults.timer_getdataTimer(Sender: TObject);
begin
  inherited;
//
end;

procedure TframeXVRestoreDefaults.btnRestoreDefaultsClick(Sender: TObject);
var
  pReadData: TStringList;
  gRestoreDefaults: tRestoreDefaultsXV;
  r: boolean;
begin
  gRestoreDefaults := tRestoreDefaultsXV.Create;
  pReadData := TStringList.Create;
  pReadData.Text := dm.com.SendCommand(sRestoreDefaults);
  r := gRestoreDefaults.ParseText(pReadData);
  if r then
  begin
    showmessage('RestoreDefaults Completed');
  end
  else
    showmessage('RestoreDefaults did not complete');
  freeandnil(gRestoreDefaults);
  resetfocus;
end;

procedure TframeXVRestoreDefaults.Check;
begin
  btnRestoreDefaults.Enabled := dm.com.Active;
end;

end.
