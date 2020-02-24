unit frame.XV.GetErr;

interface

uses
  frame.master,
  dmCommon,
  neato.XV.GetErr, fmx.objects,
  fmx.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  fmx.Types, fmx.Graphics, fmx.Controls, fmx.Forms, fmx.Dialogs, fmx.StdCtrls, System.Rtti, fmx.Grid.Style, fmx.Grid,
  fmx.Controls.Presentation, fmx.ScrollBox, fmx.Layouts;

type
  TFrameXVGetErr = class(TframeMaster)
    sgGetErr: TStringGrid;
    scGetErrName: TStringColumn;
    scGetErrValue: TStringColumn;
    procedure timer_GetDataTimer(Sender: TObject);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; Rect: TRectangle); reintroduce; overload;
    procedure check;
  end;

implementation

{$R *.fmx}

constructor TFrameXVGetErr.Create(AOwner: TComponent; Rect: TRectangle);
begin
  inherited Create(AOwner, Rect);
  lblFrameTitle.Text := sDescription;
end;

procedure TFrameXVGetErr.timer_GetDataTimer(Sender: TObject);
var
  pGetErr: tGetErrXV;
  pReadData: TStringList;
  idx: integer;
  r: Boolean;
begin

  if (dm.com.Active = false) or (dm.ActiveTab <> Tab) then
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

procedure TFrameXVGetErr.check;
begin
  //
end;

end.
