unit frame.DXV.TestLDS;

interface

uses
  frame.master,
  dmCommon,
  neato.DXV.TestLDS,
  FMX.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, System.Math.Vectors, FMX.Types3D,
  FMX.Controls3D, FMX.Objects3D, FMX.Viewport3D, FMX.MaterialSources, FMX.Controls.Presentation, FMX.Layers3D,
  FMX.ScrollBox, FMX.Memo, FMX.Objects;

type
  TframeDXVTestLDS = class(TframeMaster)
    Rectangle1: TRectangle;
    lblGetAccelPitchInDegrees: TLabel;
    lblTestLDSLoaderValue: TLabel;
    lblGetAccelRollInDegrees: TLabel;
    lblTestLDSCPUValue: TLabel;
    lblGetAccelXInG: TLabel;
    lblTestLDSSerialValue: TLabel;
    lblGetAccelYInG: TLabel;
    lblTestLDSLastCalValue: TLabel;
    lblGetAccelZInG: TLabel;
    lblTestLDSRuntimeValue: TLabel;
    Label1: TLabel;
    procedure Timer_GetDataTimer(Sender: TObject);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); reintroduce; overload;
    procedure check;
  end;

implementation

{$R *.fmx}

constructor TframeDXVTestLDS.Create(AOwner: TComponent);
begin
  inherited;
  lblFrameTitle.Text := sDescription;
end;

procedure TframeDXVTestLDS.Timer_GetDataTimer(Sender: TObject);
var
  pTestLDS: tTestLDS;
  pReadData: TStringList;
  v: double;
  r: Boolean;
begin

  if (dm.com.Active = false) or (dm.ActiveTab <> Tab) then
  begin
    Timer_GetData.Enabled := false;
    exit;
  end;

  dm.chkTestmode.IsChecked := true; // make sure testmode is ON

  pTestLDS := tTestLDS.Create;

  pReadData := TStringList.Create;

  if not dm.chkTestmode.IsChecked then
    dm.chkTestmode.IsChecked := true;

  pReadData.Text := dm.com.SendCommandAndWaitForValue(sTestLDS + ' ' + sGetVersion, 5000, ^Z, 1);

  r := pTestLDS.ParseText(pReadData);

  if r then
  begin
    lblTestLDSRuntimeValue.Text := pTestLDS.Runtime;
    lblTestLDSLastCalValue.Text := pTestLDS.LastCal;
    lblTestLDSSerialValue.Text := pTestLDS.Serial;
    lblTestLDSCPUValue.Text := pTestLDS.CPU;
    lblTestLDSLoaderValue.Text := pTestLDS.Loader;
    Timer_GetData.Enabled := false;
  end
  else
  begin
    lblTestLDSRuntimeValue.Text := '';
    lblTestLDSLastCalValue.Text := '';
    lblTestLDSSerialValue.Text := '';
    lblTestLDSCPUValue.Text := '';
    lblTestLDSLoaderValue.Text := '';
  end;

  pReadData.Free;
  pTestLDS.Free;
end;

procedure TframeDXVTestLDS.check;
begin
  //
end;

end.
