unit Unit243;

interface

uses
{$IFDEF mswindows}
  Registry,
{$ENDIF}
  neato.oauth.api,
  neato.beehive.api,
  IdURI, inifiles, basejson,
  JSON,
  mobileIO,
  rest.JSON,
  xsuperobject,
  xsuperjson,

  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo,
  FMX.StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, FMX.WebBrowser, FMX.TabControl;

type

  TForm243 = class(TForm)
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    WebBrowser1: TWebBrowser;
    btnAuthorizeImplicit: TButton;
    lblCode: TLabel;
    TabItem3: TTabItem;
    TabItem4: TTabItem;
    TabItem5: TTabItem;
    Memo1: TMemo;
    btnGetToken: TButton;
    Memo2: TMemo;
    RevokeToken: TButton;
    Memo3: TMemo;
    Button2: TButton;
    Memo4: TMemo;
    TabItem6: TTabItem;
    Button1: TButton;
    Memo5: TMemo;
    procedure WebBrowser1DidFinishLoad(ASender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGetTokenClick(Sender: TObject);
    procedure btnAuthorizeImplicitClick(Sender: TObject);
    procedure RevokeTokenClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    _userCode: String;
{$IFDEF MSWINDOWS}
    procedure SetPermissions;
{$ENDIF}
  public
    { Public declarations }
  end;

var
  Form243: TForm243;

const
  _clientID = '600c902b83b7e1a9e39e8bd65da988f56abb3de056b7932d30b3c63a54970387';
  _clientSecret = '6200b5f2177e2ca76274e7931ef6829d3f8db9e7104136d1b608c9d31b4302f5';
  _RedirectURI = 'https://github.com/jdredd87/NeatoToolio';

implementation

{$R *.fmx}

procedure TForm243.btnGetTokenClick(Sender: TObject);
var
  token: TbeeHiveTokenRequest;
begin

  // Get Token from Neato with our credentials
  // gotten from the login authorize page

  token := TbeeHiveTokenRequest.Create;
  token.client_id := _clientID;
  token.client_secret := _clientSecret;
  token.redirect_uri := _RedirectURI;
  token.code := _userCode;

  if token.Execute then
  begin
    Memo2.Lines.Add(token.beeHiveTokenResponse.access_token);
    Memo2.Lines.Add(token.beeHiveTokenResponse.token_type);
    Memo2.Lines.Add(token.beeHiveTokenResponse.refresh_token);
    Memo2.Lines.Add(token.beeHiveTokenResponse.scope);
  end
  else
    Memo2.Lines.Add(token.JSONResponse);

  token.Free;
end;

procedure TForm243.btnAuthorizeImplicitClick(Sender: TObject);
var
  URL: string;
begin
{$IFDEF MSWINDOWS}
  SetPermissions;
{$ENDIF}
  URL := GenerateURL(_clientID, _RedirectURI);
  Memo1.Lines.Clear;
  Memo1.Lines.Add(URL);
  WebBrowser1.Navigate(URL);
end;

procedure TForm243.Button1Click(Sender: TObject);
var
  r: tneatoOAuthauthorizationToken;
begin

  r := tneatoOAuthauthorizationToken.Create;
  r.client_id  := _clientID;
  r.client_secret := _clientSecret;
  r.redirect_uri := _RedirectURI;
  r.code := lblCode.Text;

  if r.Execute then
  begin
    lblCode.Text := '';
    showmessage('Token revoked');
  end
  else
    showmessage('Could not revoke. Error ' + r.errorcode);
  r.Free;

end;

procedure TForm243.Button2Click(Sender: TObject);
var
  r: tneatoOAuthRefreshToken;
begin

  r := tneatoOAuthRefreshToken.Create;
  r.refresh_token := lblCode.Text;

  if r.Execute then
  begin
    Memo4.Lines.Add(r.neatoOAuthRevokeTokenResponse.access_token);
    Memo4.Lines.Add(r.neatoOAuthRevokeTokenResponse.token_type);
    Memo4.Lines.Add(r.neatoOAuthRevokeTokenResponse.expires_in.ToString);
    Memo4.Lines.Add(r.neatoOAuthRevokeTokenResponse.refresh_token);
    Memo4.Lines.Add(r.neatoOAuthRevokeTokenResponse.scope);
  end
  else
  begin
    showmessage('Could not refresh token. Error ' + r.neatoOAuthRevokeTokenResponse.responsecode.ToString);
  end;

  r.Free;

end;

procedure TForm243.FormCreate(Sender: TObject);
var
  i: tinifile;
begin
  i := tinifile.Create('.\data.ini');
  _userCode := i.ReadString('settings', 'token', '');
  lblCode.Text := _userCode;
  i.Free;
end;

procedure TForm243.RevokeTokenClick(Sender: TObject);
var
  r: tneatoOAuthRevokeToken;
begin

  r := tneatoOAuthRevokeToken.Create;
  r.Authorization := _clientID;
  r.token := lblCode.Text;
  if r.Execute then
  begin
    lblCode.Text := '';
    showmessage('Token revoked');
  end
  else
    showmessage('Could not revoke. Error ' + r.errorcode);
  r.Free;

end;

{$IFDEF mswindows}

procedure TForm243.SetPermissions; // this allows IE11 viewing mode

const
  cHomePath = 'SOFTWARE';
  cFeatureBrowserEmulation = 'Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION\';
  cIE11 = 11001;

var
  Reg: TRegIniFile;
  sKey: string;
begin

  sKey := ExtractFileName(ParamStr(0));
  Reg := TRegIniFile.Create(cHomePath);
  try
    if Reg.OpenKey(cFeatureBrowserEmulation, true) and
      not(TRegistry(Reg).KeyExists(sKey) and (TRegistry(Reg).ReadInteger(sKey) = cIE11)) then
      TRegistry(Reg).WriteInteger(sKey, cIE11);
  finally
    Reg.Free;
  end;

end;
{$ENDIF}

procedure TForm243.WebBrowser1DidFinishLoad(ASender: TObject);
var
  _userCode: String;
  URL: String;
  i: tinifile;

begin

  URL := WebBrowser1.URL;

  if pos('?' + _AuthCode, URL) > 0 then
  begin
    WebBrowser1.OnDidFinishLoad := nil;
    _userCode := '';
    if GetUserCode(URL, _userCode) then
    begin
      lblCode.Text := _userCode;
      showmessage('You are now authorized!');
    end
    else
      showmessage('Failed to authorize!');

    i := tinifile.Create('.\data.ini');
    i.WriteString('settings', 'token', _userCode);
    i.Free;

  end;
end;

end.
