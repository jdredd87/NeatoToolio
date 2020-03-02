unit dmSerial.TCPIP;

interface

uses
  SyncObjs,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  dmSerial.Base,
  diagnostics,
  FMX.Types,
  FMX.Colors,
  FMX.Dialogs,
  FMX.Memo,
  idstrings,
  idglobal,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdTelnet,
  neato.helpers;

type
  TdmSerialTCPIP = class(TdmSerialBase)
  private
    fError: String;
    fErrorCode: integer;
    fComFailure: boolean;
    fDataBuffer: String;

    cs: TCriticalSection;
    procedure IdTelnet1DataAvailable(Sender: TIdTelnet; const Buffer: TIdBytes);
    procedure IdTelnet1Connected(Sender: TObject);
    procedure IdTelnet1Disconnected(Sender: TObject);
  protected
    procedure SetOnRxChar(value: TNotifyEvent);
  public
    onError: TNotifyEvent;
    fmemoDebug: tmemo;

    IP: String;
    Port: Word;

    Serial: TIdTelnet;

    FComSignalRX: TColorBox;
    FComSignalTX: TColorBox;
    FComSignalCNX: TColorBox;

    constructor Create;
    destructor Destroy; override;
    Function Open: boolean; override;
    procedure Close; override;
    function SendCommand(cmd: string; const readtimeout: integer = 5000; const waitfor: integer = 100): string;
      override;
    function SendCommandOnly(cmd: string): String; override; // Just send command and move on
    function SendCommandAndWaitForValue(cmd: string; const readtimeout: integer = 5000; const waitfor: string = '';
      const count: byte = 1): string; override;

    function ReadString: String; override;
    function Active: boolean; override;
    function ReadBuffer: String;

    procedure PurgeInput; override;
    procedure PurgeOutput; override;
    procedure WaitForWriteCompletion; override;
    procedure WaitForReadCompletion; override;

    property Error: String read fError;
    property ErrorCode: integer read fErrorCode;
    property Failure: boolean read fComFailure;
  end;

implementation

Const
  LineBreak = #10#13;

constructor TdmSerialTCPIP.Create;
begin
  inherited;
  cs := TCriticalSection.Create;

  Serial := TIdTelnet.Create(nil);
  Serial.ThreadedEvent := true;
  Serial.OnConnected := IdTelnet1Connected;
  Serial.OnDisconnected := IdTelnet1Disconnected;
  Serial.OnDataAvailable := IdTelnet1DataAvailable;

  FComSignalRX := nil;
  FComSignalTX := nil;
  FComSignalCNX := nil;
end;

Destructor TdmSerialTCPIP.Destroy;
begin
  Serial.Free;
  cs.Free;
  inherited;
end;

procedure TdmSerialTCPIP.SetOnRxChar(value: TNotifyEvent);
begin
  // Serial.OnRxChar := value;
end;

function TdmSerialTCPIP.ReadBuffer: String;
begin
  try
    cs.Enter;
    try
      Result := fDataBuffer;
    except
      on E: Exception do
      begin
      end;
    end;
  finally
    cs.Leave;
  end;
end;

Function TdmSerialTCPIP.Open: boolean;

begin
  try
    fError := '';
    fErrorCode := 0;
    fComFailure := false;
    try
      Serial.Disconnect; // make sure to disconnect if let open
    except
    end;
    Serial.Host := IP;
    Serial.Port := Port;
    Serial.ConnectTimeout := 4000;
    Serial.readtimeout := 4000;
    Serial.Connect;
    Result := true;
  except
    on E: Exception do
    begin
      Result := false;
      fError := E.Message;
      if assigned(onError) then
        onError(self);
    end;
  end;
end;

procedure TdmSerialTCPIP.Close;
begin
  try
    Serial.Disconnect;
  except
    on E: Exception do
    begin
      fError := E.Message;
      if assigned(onError) then
      begin
        tthread.Queue(nil, // Queue Syncronize
          procedure
          begin
            if assigned(onError) then
              onError(self);
          end);
      end;
    end;
  end;
end;

function TdmSerialTCPIP.SendCommandOnly(cmd: string): String;
var
  sw: tstopwatch;
begin
  tthread.CreateAnonymousThread(
    procedure
    begin
      sleep(100);
      tthread.Queue(nil,
        procedure
        begin
          self.FComSignalTX.Color := talphacolorrec.Green;
        end);
    end).Start;

  cs.Enter;
  fDataBuffer := '';
  cs.Leave;

  try
    Result := cmd;
    try
      Result := '';
      Serial.readtimeout := 5000; // 1 second is all we allow

      if assigned(fmemoDebug) then
      begin
        fmemoDebug.BeginUpdate;
        fmemoDebug.Lines.Add(cmd);
        fmemoDebug.Lines.Add('');
        fmemoDebug.Lines.Add('< Call does not check response >');
        fmemoDebug.GoToTextEnd;
        fmemoDebug.EndUpdate;
      end;

      Serial.SendString(cmd + LineBreak);
      sw := tstopwatch.Create;
      sw.Start;

      repeat // This is blocking so beware
        if Serial.Socket.InputBufferIsEmpty = false then
          sleep(1);
      until (pos(^Z, fDataBuffer) > 0) or (sw.ElapsedMilliseconds >= Serial.readtimeout);
      sw.Stop;
      Result := trim(fDataBuffer);

    except
      on E: Exception do
      begin
        tthread.Queue(nil, // Queue Syncronize
          procedure
          begin
            fError := E.Message;
            fErrorCode := E.HelpContext;
            if assigned(onError) then
              onError(self);
          end);
      end;
    end;
  finally
    tthread.CreateAnonymousThread(
      procedure
      begin
        sleep(100);
        tthread.Queue(nil,
          procedure
          begin
            if assigned(FComSignalTX) then
              FComSignalTX.Color := talphacolorrec.Darkgreen;
          end);
      end).Start;

  end;
end;

function TdmSerialTCPIP.SendCommand(cmd: string; const readtimeout: integer = 5000;
const waitfor: integer = 100): string;
var
  sw: tstopwatch;
  fixData: TStringList;
  idx: integer;

  breakFound: integer;
  timedout: boolean;

begin

  tthread.CreateAnonymousThread(
    procedure
    begin
      sleep(100);
      tthread.Queue(nil,
        procedure
        begin
          if assigned(FComSignalTX) then
            FComSignalTX.Color := talphacolorrec.Green;
        end);
    end).Start;

  cs.Enter;
  fDataBuffer := '';
  cs.Leave;

  try
    try
      sw := tstopwatch.Create;
      Result := '';
      Serial.readtimeout := readtimeout * 2;

      if assigned(fmemoDebug) then
        fmemoDebug.Lines.Add(cmd);

      Serial.SendString(cmd + #13);
      sw := tstopwatch.Create;
      sw.Start;

      repeat // This is blocking so beware
        sleep(10);
        cs.Enter;
        breakFound := pos(char($1A), fDataBuffer);
        cs.Leave;
        timedout := sw.ElapsedMilliseconds >= Serial.readtimeout;
      until (breakFound > 0) or (timedout);
      // until (pos(^Z, fDataBuffer) > 0) or (sw.ElapsedMilliseconds >= Serial.readtimeout);

      sw.Stop;

      cs.Enter;
      fixData := TStringList.Create;
      fixData.Text := trim(fDataBuffer);
      cs.Leave;

      for idx := fixData.count - 1 downto 0 do
        if trim(fixData[idx]) = '' then
          fixData.Delete(idx);

      Result := trim(fixData.Text);

      fixData.Free;
      if pos('Help', Result) > 0 then
        sw.Stop;

      if assigned(fmemoDebug) then
      begin
        fmemoDebug.BeginUpdate;
        fmemoDebug.Lines.Add(Result);
        fmemoDebug.GoToTextEnd;
        fmemoDebug.EndUpdate;
      end;

    except
      on E: Exception do
      begin
        tthread.Queue(nil, // Queue Syncronize
          procedure
          begin
            fError := E.Message;
            fErrorCode := E.HelpContext;
            if assigned(onError) then
              onError(self);
          end);
      end;
    end;
  finally
    tthread.CreateAnonymousThread(
      procedure
      begin
        sleep(100);
        tthread.Queue(nil,
          procedure
          begin
            if assigned(FComSignalTX) then
              FComSignalTX.Color := talphacolorrec.Darkgreen;
          end);
      end).Start;
  end;
end;

function TdmSerialTCPIP.ReadString: String;
begin
  Result := Serial.Socket.ReadLn;
end;

function TdmSerialTCPIP.SendCommandAndWaitForValue(cmd: string; const readtimeout: integer = 5000;
const waitfor: string = ''; const count: byte = 1): string;

var
  sw: tstopwatch;
  // ToSend2: TIdBytes;
  // ToSend1: TBytes;

begin

  tthread.CreateAnonymousThread(
    procedure
    begin
      sleep(100);
      tthread.Queue(nil,
        procedure
        begin
          if assigned(FComSignalTX) then
            FComSignalTX.Color := talphacolorrec.Green;
        end);
    end).Start;
  try

    cs.Enter;
    fDataBuffer := '';
    cs.Leave;

    Result := '';
    if assigned(fmemoDebug) then
      fmemoDebug.Lines.Add(cmd);

    Serial.SendString(cmd + LineBreak);
    sw := tstopwatch.Create;
    sw.Start;

    repeat // This is blocking so beware
      if Serial.Socket.InputBufferIsEmpty = false then
        sleep(1);
    until (OccurrencesOfChar(Result, ^Z) = count) or (sw.ElapsedMilliseconds >= Serial.readtimeout);

    sw.Stop;

    Result := trim(fDataBuffer);

    if assigned(fmemoDebug) then
    begin
      fmemoDebug.BeginUpdate;
      fmemoDebug.Lines.Add(Result);
      fmemoDebug.GoToTextEnd;
      fmemoDebug.EndUpdate;
    end;

  except
    on E: Exception do
    begin
      tthread.Queue(nil, // Queue Syncronize
        procedure
        begin
          fError := E.Message;
          fErrorCode := E.HelpContext;
          if assigned(onError) then
            onError(self);
        end);
    end;
  end;
  tthread.CreateAnonymousThread(
    procedure
    begin
      sleep(100);
      tthread.Queue(nil,
        procedure
        begin
          if assigned(FComSignalTX) then
            FComSignalTX.Color := talphacolorrec.Darkgreen;
        end);
    end).Start;

end;

function TdmSerialTCPIP.Active: boolean;
begin
  try
    Result := Serial.Connected;
  except
    on E: Exception do
    begin
      self.fError := E.Message;
      Result := false;
    end;
  end;
end;

procedure TdmSerialTCPIP.WaitForWriteCompletion;
begin
  sleep(100);
end;

procedure TdmSerialTCPIP.WaitForReadCompletion;
begin
  sleep(100);
end;

procedure TdmSerialTCPIP.PurgeInput;
begin
  Serial.IOHandler.InputBuffer.Clear;
end;

procedure TdmSerialTCPIP.PurgeOutput;
begin
  Serial.Socket.WriteBufferFlush;
  Serial.Socket.WriteBufferClear;
end;

procedure TdmSerialTCPIP.IdTelnet1DataAvailable(Sender: TIdTelnet; const Buffer: TIdBytes);
begin // Idea here is, TCP is a stream of data. So you will get the data possibly in 2 or more chunks.
  // So build up the string and say its ready.
  // Let the other code check to see if its truely ready or not.
  cs.Enter;
  fDataBuffer := fDataBuffer + BytesToString(Buffer);
  fDataBuffer := stringreplace(fDataBuffer, char($0D) + char($00) + char($0A), char($0D) + char($0A), [rfreplaceall]);
  cs.Leave;

  tthread.CreateAnonymousThread(
    procedure
    begin
      tthread.Queue(nil,
        procedure
        begin
          if assigned(FComSignalRX) then
            FComSignalRX.Color := talphacolorrec.Red;
        end);
      sleep(100);
      tthread.Queue(nil,
        procedure
        begin
          if assigned(FComSignalRX) then
            FComSignalRX.Color := talphacolorrec.Maroon;
        end);
    end).Start;

end;

procedure TdmSerialTCPIP.IdTelnet1Connected(Sender: TObject);
begin
  tthread.CreateAnonymousThread(
    procedure
    begin
      sleep(100);
      tthread.Queue(nil,
        procedure
        begin
          if assigned(FComSignalCNX) then
            FComSignalCNX.Color := talphacolorrec.Yellow;
        end);
    end).Start;
end;

procedure TdmSerialTCPIP.IdTelnet1Disconnected(Sender: TObject);
begin
  tthread.CreateAnonymousThread(
    procedure
    begin
      sleep(100);
      tthread.Queue(nil,
        procedure
        begin
          if assigned(FComSignalCNX) then
            FComSignalCNX.Color := talphacolorrec.Olive;
        end);

    end).Start;
end;

end.
