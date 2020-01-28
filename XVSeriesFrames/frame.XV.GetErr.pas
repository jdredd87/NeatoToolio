unit frame.XV.GetErr;

interface

uses
  frame.master,
  dmCommon,
  neato.XV.GetErr,
  FMX.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, System.Rtti, FMX.Grid.Style, FMX.Grid,
  FMX.Controls.Presentation, FMX.ScrollBox;

type
  TFrameXVGetErr = class(TframeMaster)
    sgGetErr: TStringGrid;
    scGetErrName: TStringColumn;
    scGetErrValue: TStringColumn;
    procedure timer_GetDataTimer(Sender: TObject);
  private
    { Private declarations }
  public
   constructor Create(AOwner: TComponent); reintroduce; overload;
  end;

implementation

{$R *.fmx}

constructor TFrameXVGetErr.Create(AOwner: TComponent);
begin
 inherited;
 lblFrameTitle.Text := sDescription;
end;


procedure TFrameXVGetErr.timer_GetDataTimer(Sender: TObject);
var
  pGetErr: tGetErrXV;
  pReadData: TStringList;
  idx: integer;
  r: Boolean;
begin

  if (dm.com.Serial.Active = false) or (dm.ActiveTab<>Tab) then
  begin
    timer_GetData.Enabled := false;
    exit;
  end;

  pGetErr := tGetErrXV.Create;

  pReadData := TStringList.Create;
  pReadData.Text := dm.com.SendCommand(sGetErr);

  r := pGetErr.ParseText(pReadData);

  if r then
  begin
    sgGetErr.RowCount := pGetErr.ErrorList.Count;
    for idx := 0 to pGetErr.ErrorList.Count - 1 do
    begin
      sgGetErr.Cells[0, idx] := pGetErr.ErrorList.Names[idx];
      sgGetErr.Cells[1, idx] := pGetErr.ErrorList.ValueFromIndex[idx];
    end;
  end;

  pReadData.Free;
  pGetErr.Free;
end;

end.
