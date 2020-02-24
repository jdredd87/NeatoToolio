unit frame.D.ClearFiles;

interface

uses
  frame.master,
  dmCommon,
  neato.D.ClearFiles, fmx.objects,
  fmx.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  fmx.Types, fmx.Graphics, fmx.Controls, fmx.Forms, fmx.Dialogs, fmx.StdCtrls, fmx.Controls.Presentation, fmx.Layouts;

type
  TframeDClearFiles = class(TframeMaster)
    gbClearFiles: TGroupBox;
    rbClearFilesBB: TRadioButton;
    rbClearFilesALL: TRadioButton;
    btnClearFiles: TButton;
    procedure rbClearFilesBBChange(Sender: TObject);
    procedure btnClearFilesClick(Sender: TObject);
    procedure timer_getdataTimer(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Check;
    constructor Create(AOwner: TComponent; Rect: TRectangle); reintroduce; overload;
  end;

implementation

{$R *.fmx}

constructor TframeDClearFiles.Create(AOwner: TComponent; Rect: TRectangle);
begin
  inherited Create(AOwner, Rect);
  lblFrameTitle.Text := sDescription;
end;

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

procedure TframeDClearFiles.timer_getdataTimer(Sender: TObject);
begin
  inherited;
//
end;

procedure TframeDClearFiles.Check;
begin
  rbClearFilesBB.Enabled := dm.com.Active;
  rbClearFilesALL.Enabled := dm.com.Active;
  btnClearFiles.Enabled := dm.com.Active;
  rbClearFilesBB.IsChecked := false;
  rbClearFilesALL.IsChecked := false;
end;

end.
