unit frame.DXV.Terminal;

interface

uses
  dmCommon,
  neato.Helpers,   FMX.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.ScrollBox, FMX.Memo, FMX.Edit,
  FMX.ComboEdit, FMX.Controls.Presentation, FMX.Objects;

type
  TframeDXVTerminal = class(TFrame)
    pnlDebugTerminalBottom: trectangle;
    lblDebugTerminalCMD: TLabel;
    edDebugTerminalSend: TComboEdit;
    btnDebugTerminalSend: TButton;
    btnDebugTerminalSendHex: TButton;
    pnlDebugTerminalTop: trectangle;
    btnDebugTerminalClear: TButton;
    btnDebugTerminalHelp: TButton;
    memoDebugTerminal: TMemo;
    timer_GetData: TTimer;
    procedure btnDebugTerminalClearClick(Sender: TObject);
    procedure btnDebugTerminalHelpClick(Sender: TObject);
    procedure btnDebugTerminalSendClick(Sender: TObject);
    procedure btnDebugTerminalSendHexClick(Sender: TObject);
    procedure edDebugTerminalSendKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure timer_GetDataTimer(Sender: TObject);
  private
    { Private declarations }
  public
    Tab : TTabItem;
    procedure check;
    procedure FComPortRxChar(Sender: TObject);
    procedure FComPortEOL(Sender: TObject);
  end;

implementation

{$R *.fmx}

procedure TframeDXVTerminal.check;
begin
  edDebugTerminalSend.Enabled := dm.COM.Serial.Active;
  btnDebugTerminalSend.Enabled := dm.COM.Serial.Active;
  btnDebugTerminalSendHex.Enabled := dm.COM.Serial.Active;
  btnDebugTerminalClear.Enabled := dm.COM.Serial.Active;
  btnDebugTerminalHelp.Enabled := dm.COM.Serial.Active;
end;

procedure TframeDXVTerminal.btnDebugTerminalClearClick(Sender: TObject);
begin
  memoDebugTerminal.Text := '';
  edDebugTerminalSend.SetFocus;
  resetfocus;
end;

procedure TframeDXVTerminal.btnDebugTerminalHelpClick(Sender: TObject);
begin
  edDebugTerminalSend.Text := 'HELP';
  btnDebugTerminalSendClick(Sender);
  resetfocus;
end;

procedure TframeDXVTerminal.btnDebugTerminalSendClick(Sender: TObject);
var
  Value: string;
begin

  dm.COM.Serial.OnRxChar := FComPortRxChar;
  Value := trim(uppercase(edDebugTerminalSend.Text));

  if Sender = btnDebugTerminalSendHex then
  begin
    Value := uppercase(stringreplace(Value, ' ', '', [rfreplaceall]));
    Value := string(Hex2String(Value));
  end;

  if edDebugTerminalSend.Items.IndexOf(edDebugTerminalSend.Text) = -1 then
    if trim(edDebugTerminalSend.Text) <> '' then

      edDebugTerminalSend.Items.Insert(0, edDebugTerminalSend.Text);

  memoDebugTerminal.Lines.Add('');
  memoDebugTerminal.GoToTextEnd;

  edDebugTerminalSend.Text := '';
  edDebugTerminalSend.SetFocus;

  dm.COM.SendCommandOnly(Value);
  resetfocus;
end;

procedure TframeDXVTerminal.btnDebugTerminalSendHexClick(Sender: TObject);
begin
  resetfocus; //
end;

procedure TframeDXVTerminal.edDebugTerminalSendKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    btnDebugTerminalSendClick(Sender);
    Key := 0;
    KeyChar := #0;
    edDebugTerminalSend.SetFocus;
  end;
end;

procedure TframeDXVTerminal.FComPortEOL(Sender: TObject);
begin
  //
end;

procedure TframeDXVTerminal.FComPortRxChar(Sender: TObject);
var
  Text: AnsiString;
begin

  // beginupdate/endupdate fixes jumping of the memo box as each new text/line is added!!

  memoDebugTerminal.BeginUpdate;
  try
    Text := dm.COM.Serial.ReadAnsiString;
  except
    on E: Exception do
    begin
      Text := #10#13 + #10#13 + AnsiString(E.Message) + #10#13 + #1013;
    end;

  end;

  if pos(^Z, string(Text)) > 0 then
    FComPortEOL(Sender);

  memoDebugTerminal.Text := memoDebugTerminal.Text + string(Text);
  memoDebugTerminal.GoToTextEnd;

  memoDebugTerminal.EndUpdate;
end;

procedure TframeDXVTerminal.timer_GetDataTimer(Sender: TObject);
begin
  check;
end;

end.
