unit baseJSON;

interface

uses
  IdSSL,
  IdSSLOpenSSL,
  IdSSLOpenSSLHeaders,
  IDCompressorZLib,
{$IF DEFINED(IOS) and DEFINED(CPUARM)}
  IdSSLOpenSSLHeaders_static,
{$ENDIF}
  xsuperobject,
  xsuperjson,
  mobileIO,
  fmx.dialogs,
  idhttp,
  JSON,
  fmx.StdCtrls,
  rest.JSON,
  DBXJSONCommon,
  Soap.EncdDecd,
  System.SysUtils,
  System.Classes,
  System.IOUtils,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  idglobal;

type

  TBaseSendJSONState = (jNotStarted, jRunning, jComplete, jError);

  TBaseSendJSON = Class // (TInterfacedObject)
  private
    fPrivateErrorMessage: string;
    fJSONSend: String;
    fJSONResponse: String;
    fServerAddres: String;
    // fHTTP: TIDHttp;
    fjsonResponseArray: TJsonarray; // First level Response
    fjsonResponseData: tjsonvalue; // Our Response Data out of the array deal
    fjsonToSend: TStringStream;
    fjsonString: String;
    fResponseBody: string;
    fResponse: string;
    fRestModule: String;
    fRestCall: String;
    fError: string;
    fState: TBaseSendJSONState;
    fResponseCode: Integer;

    fAuthorization: String;

    function getServerUrl: String;
    function VerifyPeer(Certificate: TIdX509; AOk: Boolean; ADepth, AError: Integer): Boolean;
    procedure StatusInfoEx(ASender: TObject; const AsslSocket: PSSL; const AWhere, Aret: Integer;
      const AType, AMsg: string);
  public

    [disable]
    RetryCount: Integer;

    [disable]
    ReadTimeout: Integer;

    [disable]
    ServerAddress: String;
    [disable]
    Constructor Create;
    [disable]
    Destructor Destroy; override;
    [disable]
    Function SendRequest(jsonStr: string): Boolean;
    [disable]
    procedure IdHTTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
    [disable]
    procedure IdHTTPWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    [disable]
    procedure IdHTTPWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    [disable]
    Property JSONSend: String read fJSONSend;
    [disable]
    Property JSONResponse: String read fJSONResponse;
    // [disable]
    // Property HTTP: TIDHttp read fHTTP write fHTTP;
    [disable]
    property RestModule: String read fRestModule write fRestModule;
    [disable]
    property RestCall: String read fRestCall write fRestCall;
    [disable]
    property jsonResponseData: tjsonvalue read fjsonResponseData;
    [disable]
    property errorcode: string read fError;
    [disable]
    property PrivateErrorMessage: String read fPrivateErrorMessage write fPrivateErrorMessage;
    [disable]
    property State: TBaseSendJSONState read fState;
    [disable]
    property ResponseCode: Integer read fResponseCode;
    [disable]
    property Authorization: String read fAuthorization write fAuthorization;
  end;

var
  fIsIpv6: Boolean;

implementation

procedure TBaseSendJSON.IdHTTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin
  tthread.Synchronize(tthread.CurrentThread,
    procedure
    begin

    end);
end;

procedure TBaseSendJSON.IdHTTPWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
begin
  tthread.Synchronize(tthread.CurrentThread,
    procedure

    begin

    end);

end;

procedure TBaseSendJSON.IdHTTPWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
  tthread.Synchronize(tthread.CurrentThread,
    procedure
    begin

    end);
end;

Constructor TBaseSendJSON.Create;
begin
  inherited;
  self.fJSONSend := '';
  self.fJSONResponse := '';
  self.fServerAddres := '';
  self.fRestModule := '';
  self.fRestCall := '';
  self.RetryCount := 3;
  self.ReadTimeout := 10000;

  self.fState := jNotStarted;
end;

Destructor TBaseSendJSON.Destroy;
begin
{$IFDEF AUTOREFCOUNT}
  // fHTTP.DisposeOf;
{$ELSE}
  // fHTTP.Free;
{$ENDIF}
  // fHTTP := nil;
  if assigned(fjsonResponseArray) then
  begin
{$IFDEF AUTOREFCOUNT}
    fjsonResponseArray.DisposeOf;
{$ELSE}
    fjsonResponseArray.Free;
{$ENDIF}
    fjsonResponseArray := nil;
  end;

  inherited;
end;

function TBaseSendJSON.VerifyPeer(Certificate: TIdX509; AOk: Boolean; ADepth, AError: Integer): Boolean;
begin
  Result := AOk;
end;

procedure TBaseSendJSON.StatusInfoEx(ASender: TObject; const AsslSocket: PSSL; const AWhere, Aret: Integer;
const AType, AMsg: string);
begin
  // not used yet
end;

// xfgf&^%$^&}{;'k[]HGOUg76&FJGf

Function TBaseSendJSON.SendRequest(jsonStr: String): Boolean;
var
  v: string;
  x: Integer;
  fHTTP: tidhttp;
  fSSL: TIdSSLIOHandlerSocketOpenSSL;
begin
  fState := jRunning;
  fHTTP := tidhttp.Create(nil);
  // fHTTP.Compressor := TIdCompressorZLib.Create(nil);

  fHTTP.OnWork := self.IdHTTPWork;
  fHTTP.OnWorkBegin := self.IdHTTPWorkBegin;
  fHTTP.OnWorkEnd := self.IdHTTPWorkEnd;

  fSSL := TIdSSLIOHandlerSocketOpenSSL.Create(fHTTP);

{$IFDEF win32}
  // fSSL.SSLOptions.RootCertFile := 'ca.cert.pem';
{$ENDIF}
{$IFDEF android}
  // fSSL.SSLOptions.VerifyDirs := TPath.GetDocumentsPath;
  // fSSL.SSLOptions.RootCertFile := TPath.Combine(TPath.GetDocumentsPath, 'ca.cert.pem');
{$ENDIF}
{$IFDEF ios}
  // fSSL.SSLOptions.VerifyDirs := TPath.GetDocumentsPath;
  // fSSL.SSLOptions.RootCertFile := TPath.Combine(TPath.GetDocumentsPath, 'ca.cert.pem');
{$ENDIF}
  fSSL.SSLOptions.Method := sslvSSLv23;
  fSSL.SSLOptions.SSLVersions := [sslvSSLv2, sslvSSLv3, sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];

  fHTTP.IOHandler := fSSL;
  fHTTP.Request.Accept := 'application/json';
  fHTTP.Request.ContentType := 'text/plain;charset=UTF-8';
  fHTTP.ConnectTimeout := self.ReadTimeout;
  fHTTP.ReadTimeout := self.ReadTimeout;
  fHTTP.AllowCookies := true;
  fHTTP.MaxAuthRetries := 5;
  fHTTP.IOHandler := fSSL;
  fHTTP.HandleRedirects := true;
  fHTTP.ReuseSocket := TIDReusesocket.rsTrue;
  fHTTP.BoundIP := '';
  fHTTP.BoundPort := 0;

  if fAuthorization <> '' then
  begin
    fHTTP.HTTPOptions := fHTTP.HTTPOptions + [hoNoProtocolErrorException, hoWantProtocolErrorContent];
    fHTTP.Request.BasicAuthentication := false;
    fHTTP.Request.CustomHeaders.FoldLines := false;
    fHTTP.Request.CustomHeaders.add('Authorization: Bearer ' + fAuthorization);
  end;

  try
    Result := false;

    if jsonStr <> '' then
    begin
      fjsonToSend := TStringStream.Create(Utf8Encode(jsonStr));

      v := fjsonToSend.DataString;

      fJSONSend := jsonStr;
      for x := 1 to RetryCount do
        try
          fResponse := fHTTP.post(getServerUrl(), fjsonToSend);
          break;

        except
          on e: exception do
          begin

            if (fIsIpv6) then
              fIsIpv6 := false
            else
              fIsIpv6 := true;

            try
              fResponse := fHTTP.post(getServerUrl(), fjsonToSend);
              break;
            except
              on e: exception do
              begin
                sleep(300);
                fResponse := '';
                fError := e.Message;
              end;
            end;

          end;

        end;
    end
    else
    begin
      fJSONSend := ''; // we didnt do a POST
      for x := 1 to RetryCount do
        try
          fResponse := fHTTP.Get(getServerUrl());
          break;
        except
          if (fIsIpv6) then
            fIsIpv6 := false
          else
            fIsIpv6 := true;

          try
            fResponse := fHTTP.Get(getServerUrl());
            break;
          except
            on e: exception do
            begin
              sleep(300);
              fResponse := '';
              fError := e.Message;
            end;
          end;
        end;
    end;

    if assigned(fjsonResponseArray) then
    begin
{$IFDEF AUTOREFCOUNT}
      fjsonResponseArray.DisposeOf;
{$ELSE}
      fjsonResponseArray.Free;
{$ENDIF}
      fjsonResponseArray := nil;
    end;

    if fResponse <> '' then
    begin
      try
        fResponse := '['+fResponse+']';
        fjsonResponseArray := tjsonobject.ParseJSONValue(fResponse) as TJsonarray;
        fjsonResponseData := fjsonResponseArray.Items[0];
        fJSONResponse := jsonResponseData.ToJSON;
        Result := true;
      except
        on e: exception do
        begin
          fError := e.Message;
          fJSONResponse := ''; // blank bad data
          Result := false;
        end;
      end;
    end
    else
    begin
      fJSONResponse := ''; // blank bad data
      Result := false;
    end;

  finally

    fResponseCode := fHTTP.ResponseCode;
    // fHTTP.Compressor.Free;
    fHTTP.Free;
    fHTTP := nil;
    if assigned(fjsonToSend) then
    begin
{$IFDEF AUTOREFCOUNT}
      fjsonToSend.DisposeOf;
{$ELSE}
      fjsonToSend.Free;
{$ENDIF}
      fjsonToSend := nil;
    end;
  end;

  if fError <> '' then
    fState := jError
  else
    fState := jComplete;

end;

Function TBaseSendJSON.getServerUrl: String;
var
  serverList: TStrings;
begin
  if fIsIpv6 then
  begin
    serverList := TStringLIst.Create;
    try
      ExtractStrings([':'], [], Pchar(ServerAddress), serverList);
      Result := 'https://' + '[' + serverList[0] + ']' + '/' + fRestModule + '/' + fRestCall;
    finally
      serverList.Free;
    end;
  end
  else
  begin
    Result := 'https://' + ServerAddress + '/' + fRestModule + '/' + fRestCall;
  end;
end;

initialization

fIsIpv6 := false;

end.
