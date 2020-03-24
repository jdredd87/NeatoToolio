unit neato.beehive.api;

interface

uses
{$IFDEF mswindows}
  Registry,
{$ENDIF}
  IdURI, inifiles, basejson,
  JSON,
  mobileIO,
  rest.JSON,
  xsuperobject,
  xsuperjson,

  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo,
  FMX.StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, FMX.WebBrowser, FMX.TabControl;

const

  _missing = 'missing';
  _invalid = 'invalid';
  _taken = 'taken';
  _BeehiveURL = 'https://beehive.neatocloud.com/';




type

  TbeehiveMessage = class
  private
    fmessage: string;
    fstatusmsg: string;
    fstatuscode: integer;
  public

  published
    property messge: string read fmessage;
    property httpstatusmg: string read fstatusmsg;
    property httpstatuscode: integer read fstatuscode;
  end;

  TbeeHiveTokenResponse = class
  public
    [alias('access_token')]
    access_token: string;
    [alias('token_type')]
    token_type: string;
    [alias('expires_in')]
    expires_in: longint;
    [alias('refresh_token')]
    refresh_token: string;
    [alias('scope')]
    scope: string;
  end;

  TbeeHiveTokenRequest = class(TBaseSendJSON)
  private
    fbeeHiveTokenResponse: TbeeHiveTokenResponse;
  public
    [alias('grant_type')]
    grant_type: string;
    [alias('client_id')]
    client_id: string;
    [alias('client_secret')]
    client_secret: string;
    [alias('redirect_uri')]
    redirect_uri: string;
    [alias('code')]
    code: string;
    [disable]
    constructor Create;
    [disable]
    destructor destroy; override;
    [disable]
    Function Execute: Boolean;
    [disable]
    Property beeHiveTokenResponse: TbeeHiveTokenResponse read fbeeHiveTokenResponse;
  end;

implementation

constructor TbeeHiveTokenRequest.Create;
begin
  inherited;
  ServerAddress := 'beehive.neatocloud.com';
  RestModule := 'oauth2';
  RestCall := 'token';
  grant_type := 'authorization_code';
end;

destructor TbeeHiveTokenRequest.destroy;
begin
  if assigned(fbeeHiveTokenResponse) then
    fbeeHiveTokenResponse.Free;
  inherited;
end;

Function TbeeHiveTokenRequest.Execute: Boolean;
begin
  try
    PrivateErrorMessage := '';
    Result := false;
    if SendRequest(self.asjson) then
    begin
      fbeeHiveTokenResponse := TbeeHiveTokenResponse.FromJSON(jsonResponseData.ToJSON);
      Result := true;
    end
    else
    begin
      fbeeHiveTokenResponse := TbeeHiveTokenResponse.Create;
    end;

  except
    on e: exception do
    begin
      Result := false;
      PrivateErrorMessage := e.Message;
    end;
  end;
end;

end.
