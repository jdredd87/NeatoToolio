unit neato.oauth.api;

interface

uses
  IdURI, inifiles, basejson,
  JSON,
  mobileIO,
  rest.JSON,
  xsuperobject,
  xsuperjson,

  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo,
  FMX.StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, FMX.WebBrowser, FMX.TabControl;

Const
  _AuthURL =
    'https://apps.neatorobotics.com/oauth2/authorize?response_type=code&client_id={CLIENT_ID}&redirect_uri={REDIRECT_URI}&scope={REQUESTED_SCOPES}&state={STATE}';

  _RevokeTokenURL = 'https://beehive.neatocloud.com/oauth2/revoke';
  _RefreshTokenURL = 'https://beehive.neatocloud.com/oauth2/token';
  _AuthclientIDcode = '{CLIENT_ID}';
  _AuthredirectURIcode = '{REDIRECT_URI}';
  _AuthrequestedScopescode = '{REQUESTED_SCOPES}';
  _AuthStateCode = '{STATE}';
  _AuthscopeControl_Robots = 'control_robots';
  _AuthscopePublic_Profile = 'public_profile';
  _AuthscopeMaps = 'maps';
  _Authcode = 'code';

Type

  tneatoOAuthRevokeToken = class(TBaseSendJSON)
  private
    fneatoOAuthRevokeTokenResponse: integer; // Neato returns HTTP response 200 OK , {}
  public
    [alias('token')]
    token: string;
    [disable]
    constructor Create;
    [disable]
    destructor destroy; override;
    [disable]
    Function Execute: Boolean;
    [disable]
    Property neatoOAuthRevokeTokenResponse: integer read fneatoOAuthRevokeTokenResponse;
  end;

  tneatoOAuthRefreshTokenResponse = class
  private
  public
    [alias('access_token')]
    access_token: string;
    [alias('token_type')]
    token_type: string;
    [alias('expires_in')]
    expires_in: integer;
    [alias('refresh_token')]
    refresh_token: string;
    [alias('scope')]
    scope: string;
    [disable]
    responsecode: integer;
  end;

  tneatoOAuthRefreshToken = class(TBaseSendJSON)
  private
    fneatoOAuthRefreshTokenResponse: tneatoOAuthRefreshTokenResponse;
  public
    [alias('grant_type')]
    grant_type: String;
    [alias('refresh_token')]
    refresh_token: String;
    [disable]
    constructor Create;
    [disable]
    destructor destroy; override;
    [disable]
    Function Execute: Boolean;
    [disable]
    Property neatoOAuthRevokeTokenResponse: tneatoOAuthRefreshTokenResponse read fneatoOAuthRefreshTokenResponse;
  end;

  tneatoOAuthauthorizationTokenResponse = class
  private
  public
    [alias('access_token')]
    access_token: string;
    [alias('token_type')]
    token_type: string;
    [alias('expires_in')]
    expires_in: integer;
    [alias('refresh_token')]
    refresh_token: string;
    [alias('scope')]
    scope: String;
    [disable]
    responsecode: integer;
  end;

  tneatoOAuthauthorizationToken = class(TBaseSendJSON)
  private
    fneatoOAuthauthorizationTokenResponse: tneatoOAuthauthorizationTokenResponse;
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
    Property neatoOAuthauthorizationTokenResponse: tneatoOAuthauthorizationTokenResponse
      read fneatoOAuthauthorizationTokenResponse;
  end;

function GenerateURL(clientID: String; RedirectURI: String): String; // Generate a URL String
function GetUserCode(URL: String; var ReturnValue: String): Boolean; // Get UserCode value from returned URL

implementation

function GenerateURL(clientID: String; RedirectURI: String): String;
var
  GUID: TGuid;
  URL: String;
begin
  CreateGUID(GUID); // create a temp GUID value to pass to link for the State value
  URL := _AuthURL;
  URL := stringreplace(URL, _AuthclientIDcode, clientID, [rfignorecase]);
  URL := stringreplace(URL, _AuthredirectURIcode, RedirectURI, [rfignorecase]);
  URL := stringreplace(URL, _AuthrequestedScopescode, _AuthscopeControl_Robots + '+' + _AuthscopePublic_Profile + '+' +
    _AuthscopeMaps, [rfignorecase]);
  URL := stringreplace(URL, _AuthStateCode, Guidtostring(GUID), [rfignorecase]);

  result := URL;
end;

function GetUserCode(URL: String; var ReturnValue: String): Boolean;
var
  URI: TIdURI;
  params: tstringlist;
begin
  result := false;
  ReturnValue := '';
  URI := TIdURI.Create(URL);
  params := tstringlist.Create;
  params.Delimiter := '&';
  params.StrictDelimiter := true;
  params.DelimitedText := URI.params;
  if params.Values[_Authcode] <> '' then
  begin
    ReturnValue := params.Values[_Authcode];
    result := true;
  end;
  params.Free;
end;

constructor tneatoOAuthRevokeToken.Create;
begin
  inherited;
  ServerAddress := 'beehive.neatocloud.com';
  RestModule := 'oauth2';
  RestCall := 'revoke';
  token := '';
  fneatoOAuthRevokeTokenResponse := 0;
end;

destructor tneatoOAuthRevokeToken.destroy;
begin
  inherited;
end;

function tneatoOAuthRevokeToken.Execute: Boolean;
begin
  try
    PrivateErrorMessage := '';
    result := false;
    SendRequest(self.AsJSON(true));
    fneatoOAuthRevokeTokenResponse := responsecode;
    if responsecode = 200 then
      result := true;
  except
    on e: exception do
    begin
      result := false;
      PrivateErrorMessage := e.Message;
    end;
  end;
end;

Constructor tneatoOAuthRefreshToken.Create;
begin
  inherited;
  ServerAddress := 'beehive.neatocloud.com';
  RestModule := 'oauth2';
  RestCall := 'token';
  grant_type := 'refresh_token';
  refresh_token := '';
  fneatoOAuthRefreshTokenResponse := tneatoOAuthRefreshTokenResponse.Create;
  fneatoOAuthRefreshTokenResponse.responsecode := 0;
end;

Destructor tneatoOAuthRefreshToken.destroy;
begin
  freeandnil(fneatoOAuthRefreshTokenResponse);
  inherited;
end;

function tneatoOAuthRefreshToken.Execute: Boolean;
begin
  try
    PrivateErrorMessage := '';
    result := false;

    if SendRequest(self.AsJSON(true)) then
      fneatoOAuthRefreshTokenResponse := tneatoOAuthRefreshTokenResponse.FromJSON(jsonResponseData.ToJSON);

    fneatoOAuthRefreshTokenResponse.responsecode := responsecode;

    if responsecode = 200 then
      result := true;
  except
    on e: exception do
    begin
      result := false;
      PrivateErrorMessage := e.Message;
    end;
  end;
end;

Constructor tneatoOAuthauthorizationToken.Create;
begin
  inherited;
  ServerAddress := 'beehive.neatocloud.com';
  RestModule := 'oauth2';
  RestCall := 'token';
  grant_type := 'authorization_code';
  fneatoOAuthauthorizationTokenResponse := tneatoOAuthauthorizationTokenResponse.Create;
  fneatoOAuthauthorizationTokenResponse.responsecode := 0;
end;

Destructor tneatoOAuthauthorizationToken.destroy;
begin
  freeandnil(fneatoOAuthauthorizationTokenResponse);
  inherited;
end;

function tneatoOAuthauthorizationToken.Execute: Boolean;
begin
  try
    PrivateErrorMessage := '';
    result := false;

    if SendRequest(self.AsJSON(true)) then
      fneatoOAuthauthorizationTokenResponse := tneatoOAuthauthorizationTokenResponse.FromJSON(jsonResponseData.ToJSON);

    fneatoOAuthauthorizationTokenResponse.responsecode := responsecode;

    if responsecode = 200 then
      result := true;
  except
    on e: exception do
    begin
      result := false;
      PrivateErrorMessage := e.Message;
    end;
  end;
end;

end.
