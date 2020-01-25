unit frame.DXV.Playsound;

interface

uses
  dmCommon,
  neato.Helpers,
  neato.DXV.Playsound,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, System.Rtti, FMX.Grid.Style, FMX.Grid,
  FMX.ScrollBox, FMX.Edit, FMX.EditBox, FMX.NumberBox, FMX.Controls.Presentation, FMX.Objects;

type
  TframeDXVPlaySound = class(TFrame)
    pnlPlaySoundTop: trectangle;
    lblPlaySoundID: TLabel;
    nbPlaySoundIDValue: TNumberBox;
    btnPlaySoundTest: TButton;
    btnSoundPlayTestAll: TButton;
    btnPlaySoundAbort: TButton;
    sgPlaysound: TStringGrid;
    sgPlaysoundID: TStringColumn;
    sgPlaySoundResponse: TStringColumn;
    procedure btnPlaySoundTestClick(Sender: TObject);
    procedure btnSoundPlayTestAllClick(Sender: TObject);
    procedure btnPlaySoundAbortClick(Sender: TObject);
  private
    fPlaySoundAborted: Boolean;
  public
    { Public declarations }
    procedure Check;
    property PlaySoundAborted: Boolean read fPlaySoundAborted;
  end;

implementation

{$R *.fmx}

procedure TframeDXVPlaySound.btnPlaySoundAbortClick(Sender: TObject);
begin
  fPlaySoundAborted := true;
  sgPlaysound.SetFocus;
  btnSoundPlayTestAll.Enabled := true;
  btnPlaySoundTest.Enabled := true;
  btnPlaySoundAbort.Enabled := false;
  nbPlaySoundIDValue.Enabled := true;
  resetfocus;
end;

procedure TframeDXVPlaySound.btnPlaySoundTestClick(Sender: TObject);
var
  pReadData: TStringList;
  gPlaySound: tPlaySoundDXV;
  r: Boolean;
begin
  pReadData := TStringList.Create;

  pReadData.Text := dm.com.SendCommand(sPlaysoundSoundID + ' ' + nbPlaySoundIDValue.Value.ToString);
  gPlaySound := tPlaySoundDXV.Create;

  r := gPlaySound.ParseText(pReadData);

  sgPlaysound.RowCount := 0;
  sgPlaysound.RowCount := 1;

  sgPlaysound.Cells[0, 0] := nbPlaySoundIDValue.Value.ToString;

  case r of
    true:
      sgPlaysound.Cells[1, 0] := 'Supported';
    false:
      sgPlaysound.Cells[1, 0] := 'Not Supported';
  end;

  freeandnil(pReadData);
  freeandnil(gPlaySound);
  resetfocus;
end;

procedure TframeDXVPlaySound.btnSoundPlayTestAllClick(Sender: TObject);
begin
  sgPlaysound.SetFocus;
  fPlaySoundAborted := false;

  btnSoundPlayTestAll.Enabled := false;
  btnPlaySoundTest.Enabled := false;
  btnPlaySoundAbort.Enabled := true;
  nbPlaySoundIDValue.Enabled := false;

  sgPlaysound.RowCount := 0;
  sgPlaysound.RowCount := sSoundIDMax;

  tthread.CreateAnonymousThread(
    procedure
    var
      idx: byte;
      pReadData: TStringList;
      gPlaySound: tPlaySoundDXV;
      r: Boolean;
    begin
      sleep(1000);

      pReadData := TStringList.Create;
      for idx := 0 to sSoundIDMax - 1 do
      begin

        if fPlaySoundAborted then
          break;

        // pReadData.Text := com.SendCommand(sPlaysoundSoundID + ' ' + idx.ToString);
        pReadData.Text := dm.com.SendCommandAndWaitForValue(sPlaysoundSoundID + ' ' + idx.ToString, 6000, ^Z, 1);

        gPlaySound := tPlaySoundDXV.Create;

        r := gPlaySound.ParseText(pReadData);

        tthread.Synchronize(tthread.CurrentThread,
          procedure
          begin
            sgPlaysound.Cells[0, idx] := idx.ToString;

            case r of
              true:
                sgPlaysound.Cells[1, idx] := 'Supported';
              false:
                sgPlaysound.Cells[1, idx] := 'Not Supported';
            end;
          end);
        sleep(2000);
      end;
      freeandnil(pReadData);
      freeandnil(gPlaySound);
      tthread.Synchronize(tthread.CurrentThread,
        procedure
        begin

          // not sure i like this area here
          // the TX light would get stuck on otherwise
          // revisit maybe

          dm.com.SendCommand('');
          dm.com.SendCommand('');

          dm.com.Serial.WaitForReadCompletion;
          dm.com.Serial.WaitForWriteCompletion;
          dm.com.Serial.PurgeInput;
          dm.com.Serial.PurgeOutput;

          fPlaySoundAborted := true;
          sgPlaysound.SetFocus;
          btnSoundPlayTestAll.Enabled := true;
          btnPlaySoundTest.Enabled := true;
          btnPlaySoundAbort.Enabled := false;
          nbPlaySoundIDValue.Enabled := true;
        end);
    end).start;
  resetfocus;
end;

procedure TframeDXVPlaySound.Check;
begin
  btnPlaySoundTest.Enabled := dm.com.Serial.Active;
  btnSoundPlayTestAll.Enabled := dm.com.Serial.Active;
  btnPlaySoundAbort.Enabled := dm.com.Serial.Active;
  nbPlaySoundIDValue.Enabled := dm.com.Serial.Active;
  sgPlaysound.Clear;
end;

end.
