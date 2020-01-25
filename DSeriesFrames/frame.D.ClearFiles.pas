unit frame.D.ClearFiles;

interface

uses
  dmCommon,
  neato.D.ClearFiles,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation;

type
  TframeDClearFiles = class(TFrame)
    gbClearFiles: TGroupBox;
    rbClearFilesBB: TRadioButton;
    rbClearFilesALL: TRadioButton;
    btnClearFiles: TButton;
    procedure rbClearFilesBBChange(Sender: TObject);
    procedure btnClearFilesClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Check;
  end;

implementation

{$R *.fmx}

procedure TframeDClearFiles.btnClearFilesClick(Sender: TObject);
var
  Code: string;
  r: Boolean;
  pReadData: TStringList;
  gClearFiles: tClearFilesD;
begin

  if rbClearFilesBB.IsChecked then
    Code := sBB
  else if rbClearFilesALL.IsChecked then
    Code := sAll;

  gClearFiles := tClearFilesD.Create;
  pReadData := TStringList.Create;

  pReadData.Text := dm.com.SendCommandAndWaitForValue(sClearFilesD + ' ' + Code, 6000, ^Z, iClearFilesHeaderBreaksD);
  pReadData.Text := stringreplace(pReadData.Text, ',', '=', [rfreplaceall]);

  r := gClearFiles.ParseText(pReadData);

  Code := pReadData.Text;

  if r then
  begin
    showmessage('Clearing Completed');
    rbClearFilesBB.IsChecked := false;
    rbClearFilesALL.IsChecked := false;
    btnClearFiles.Enabled := false;
  end
  else
    showmessage('Clearing did not complete');
  resetfocus;
end;

procedure TframeDClearFiles.rbClearFilesBBChange(Sender: TObject);
begin
  btnClearFiles.Enabled := gbClearFiles.Index > -1;
  resetfocus;
end;

procedure TframeDClearFiles.Check;
begin
  rbClearFilesBB.Enabled := dm.com.Serial.Active;
  rbClearFilesALL.Enabled := dm.com.Serial.Active;
  btnClearFiles.Enabled := dm.com.Serial.Active;
  rbClearFilesBB.IsChecked := false;
  rbClearFilesALL.IsChecked := false;
end;

end.
