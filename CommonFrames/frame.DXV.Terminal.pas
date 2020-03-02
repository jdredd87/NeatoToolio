unit frame.DXV.Terminal;

interface

uses
{$IFDEF ANDROID}
  Androidapi.JNIBridge,
  dmSerial.Android,
{$ENDIF}
{$IFDEF MSWINDOWS}
  dmSerial.Windows,
{$ENDIF}
  dmSerial.TCPIP,
  frame.master,
  dmCommon,
  neato.Helpers, FMX.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.ScrollBox, FMX.Memo, FMX.Edit,
  FMX.ComboEdit, FMX.Controls.Presentation, FMX.Objects, FMX.Layouts;

type
  TframeDXVTerminal = class(TframeMaster)
    pnlDebugTerminalBottom: trectangle;
    lblDebugTerminalCMD: TLabel;
    edDebugTerminalSend: TComboEdit;
    btnDebugTerminalSend: TButton;
    pnlDebugTerminalTop: trectangle;
    btnDebugTerminalClear: TButton;
    btnDebugTerminalHelp: TButton;
    memoDebugTerminal: TMemo;
    timerSend: TTimer;
    procedure btnDebugTerminalClearClick(Sender: TObject);
    procedure btnDebugTerminalHelpClick(Sender: TObject);
    procedure btnDebugTerminalSendClick(Sender: TObject);
    procedure edDebugTerminalSendKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure timer_GetDataTimer(Sender: TObject);
    procedure timerSendTimer(Sender: TObject);
  private
    { Private declarations }
  public
    procedure check;
{$IFDEF MSWINDOWS}
    procedure FComPortRxChar(Sender: TObject);
{$ENDIF}
    procedure FComPortEOL(Sender: TObject);
    constructor Create(AOwner: TComponent; Rect: trectangle); reintroduce; overload;
  end;

implementation

{$R *.fmx}

constructor TframeDXVTerminal.Create(AOwner: TComponent; Rect: trectangle);
begin
  inherited Create(AOwner, Rect);
  lblFrameTitle.Visible := false;
{$IFDEF android}
  pnlDebugTerminalBottom.Scale.Y := 2;
{$ENDIF}
end;

procedure TframeDXVTerminal.check;
begin
  edDebugTerminalSend.Enabled := dm.COM.Active;
  btnDebugTerminalSend.Enabled := dm.COM.Active;
  btnDebugTerminalClear.Enabled := dm.COM.Active;
  btnDebugTerminalHelp.Enabled := dm.COM.Active;
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

{$IFDEF MSWINDOWS}
  if dm.COM is TdmSerialWindows then
    TdmSerialWindows(dm.COM).setonrxchar(FComPortRxChar);
{$ENDIF}
  Value := trim(uppercase(edDebugTerminalSend.Text));

  if edDebugTerminalSend.Items.IndexOf(edDebugTerminalSend.Text) = -1 then
    if trim(edDebugTerminalSend.Text) <> '' then
      edDebugTerminalSend.Items.Insert(0, edDebugTerminalSend.Text);

  memoDebugTerminal.Lines.Add('');
  memoDebugTerminal.GoToTextEnd;
  edDebugTerminalSend.Text := '';

{$IFDEF MSWINDOWS}
  edDebugTerminalSend.SetFocus; // we only need to set focus for windows
{$ENDIF}
  if dm.COM is TdmSerialTCPIP then
    timerSend.Enabled := true;

{$IFDEF ANDROID}
  timerSend.Enabled := true;
{$ENDIF}
  dm.COM.SendCommandOnly(Value);
  resetfocus;
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

{$IFDEF MSWINDOWS}

procedure TframeDXVTerminal.FComPortRxChar(Sender: TObject);
var
  Text: String;
begin

  memoDebugTerminal.BeginUpdate;
  try
    Text := dm.COM.ReadString;
    Text := stringreplace(Text, #10, '', [rfreplaceall]);
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
{$ENDIF}

procedure TframeDXVTerminal.timerSendTimer(Sender: TObject);
begin
  inherited;

  if dm.COM is TdmSerialTCPIP then
  begin
    // I really don't like using a timer!
    // TODO : Try and get Android Serial and TCPIP modes to work similar to Windows Serial events
    if pos(^Z, TdmSerialTCPIP(dm.COM).ReadBuffer) > 0 then
    begin
      timerSend.Enabled := false;
      memoDebugTerminal.BeginUpdate;
      memoDebugTerminal.Text := memoDebugTerminal.Text + TdmSerialTCPIP(dm.COM).ReadBuffer;
      memoDebugTerminal.GoToTextEnd;
      memoDebugTerminal.EndUpdate;
    end;
  end
  else
  begin

{$IFDEF ANDROID}
    // I really don't like using a timer!
    // TODO : Try and get Android Serial and TCPIP modes to work similar to Windows Serial events
    if pos(^Z, TdmSerialAndroid(dm.COM).ReadBuffer) > 0 then
    begin
      timerSend.Enabled := false;
      memoDebugTerminal.BeginUpdate;
      memoDebugTerminal.Text := memoDebugTerminal.Text + TdmSerialAndroid(dm.COM).ReadBuffer;
      memoDebugTerminal.GoToTextEnd;
      memoDebugTerminal.EndUpdate;
    end;
{$ENDIF}
  end;
end;

procedure TframeDXVTerminal.timer_GetDataTimer(Sender: TObject);
begin
  check;
end;

end.
