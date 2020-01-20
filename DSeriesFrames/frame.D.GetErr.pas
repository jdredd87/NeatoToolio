unit frame.D.GetErr;

interface

uses
  dmCommon,
  neato.D.GetErr,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, System.Rtti, FMX.Grid.Style, FMX.Grid,
  FMX.Controls.Presentation, FMX.ScrollBox;

type
  TFrameDGetErr = class(TFrame)
    sgGetErr: TStringGrid;
    scGetErrName: TStringColumn;
    scGetErrValue: TStringColumn;
    timer_GetData: TTimer;
    procedure timer_GetDataTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

procedure TFrameDGetErr.timer_GetDataTimer(Sender: TObject);
var
  pGetErr: tGetErrD;
  pReadData: TStringList;
  idx: integer;
  r: Boolean;
begin

  if (dm.com.Serial.Active = false) then
  begin
    timer_GetData.Enabled := false;
    exit;
  end;

  pGetErr := tGetErrD.Create;

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
