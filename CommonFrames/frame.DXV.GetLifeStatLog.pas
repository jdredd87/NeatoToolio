unit frame.DXV.GetLifeStatLog;

interface

uses
  frame.master,
  dmCommon,
  neato.DXV.GetLifeStatLog,
  neato.helpers, FMX.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, System.Math.Vectors, FMX.Types3D,
  FMX.Controls3D, FMX.Objects3D, FMX.Viewport3D, FMX.MaterialSources, FMX.Controls.Presentation, FMX.Layers3D,
  System.Rtti, FMX.Grid.Style, FMX.Grid, FMX.ScrollBox, FMX.Objects, FMX.Ani, FMX.Edit, FMX.EditBox, FMX.SpinBox;

type
  TframeDXVGetLifeStatLog = class(TframeMaster)
    lblSetTimeError: TLabel;
    sgGetLifeStatLog: TStringGrid;
    pnlGetLifeStatLog: TRectangle;
    btnGetLifeStatLog: TButton;
    StringColumn1: TStringColumn;
    StringColumn2: TStringColumn;
    StringColumn3: TStringColumn;
    StringColumn4: TStringColumn;
    StringColumn5: TStringColumn;
    StringColumn6: TStringColumn;
    StringColumn7: TStringColumn;
    aniGetLifeStatLog: TAniIndicator;

    procedure btnGetLifeStatLogClick(Sender: TObject);

  private
    { Private declarations }
  public
    procedure check;
    constructor Create(AOwner: TComponent); reintroduce; overload;
  end;

implementation

{$R *.fmx}

constructor TframeDXVGetLifeStatLog.Create(AOwner: TComponent);
begin
  inherited;
  lblFrameTitle.Text := sDescription;
end;

procedure TframeDXVGetLifeStatLog.btnGetLifeStatLogClick(Sender: TObject);
begin

  btnGetLifeStatLog.Enabled := false;
  aniGetLifeStatLog.Enabled := true;
  aniGetLifeStatLog.Visible := true;

  tthread.CreateAnonymousThread(
    procedure
    var
      pGetLifeStatLogDXV: tGetLifeStatLogDXV;
      pReadData: TStringList;
      r: Boolean;
    begin
      pGetLifeStatLogDXV := tGetLifeStatLogDXV.Create;

      pReadData := TStringList.Create;
      pReadData.Text := dm.com.SendCommandAndWaitForValue(sGetLifeStatLog, 16000, ^Z, 1);

      r := pGetLifeStatLogDXV.ParseText(pReadData);

      tthread.Synchronize(tthread.CurrentThread,
        procedure
        begin
          if r then
          begin
            LoadCSV(pReadData.Text, sgGetLifeStatLog);
            lblSetTimeError.Text := '';
          end
          else
          begin
            lblSetTimeError.Text := pGetLifeStatLogDXV.Error;
          end;
          resetfocus;

          btnGetLifeStatLog.Enabled := true;
          aniGetLifeStatLog.Enabled := false;
          aniGetLifeStatLog.Visible := false;
        end);

      pReadData.Free;
      pGetLifeStatLogDXV.Free;

    end).Start;

end;

procedure TframeDXVGetLifeStatLog.check;
begin
 self.btnGetLifeStatLog.Enabled := dm.com.Active;
end;

end.
