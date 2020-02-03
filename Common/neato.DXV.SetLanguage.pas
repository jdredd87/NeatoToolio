unit neato.DXV.SetLanguage;

interface

uses
  fmx.dialogs, classes, sysutils, neato.Commands, neato.errors, neato.helpers, system.dateutils;

const

  sDescription = 'Sets the UI Language for the robot.';
  // Command to send
  sSetLanguage = 'SetLanguage';

  sUnrecognizedOption = 'Unrecognized Option';

  sNone = 'None';
  sNoneMsg = 'Resets language. User will have to select language after shutdown.';

  sEnglish = 'English';
  sEnglishMsg = 'American English';

  sSChinese = 'Chinese';
  sSChineseMsg = 'Simplified Chinese';

  sGerman = 'German';
  sGermanMsg = 'German';

  sSpanish = 'Spanish';
  sSpanishMsg = 'Spanish';

  sFrench = 'French';
  sFrenchMsg = 'French';

  sItalian = 'Italian';
  sItalianMsg = 'Italian';

  sJapanese = 'Japanese';
  sJapaneseMsg = 'Japanese';

  sDanish = 'Danish';
  sDanishMsg = 'Danish';

  sDutch = 'Dutch';
  sDutchMsg = 'Dutch';

  sSwedish = 'Swedish';
  sSwedishMsg = 'Swedish';

  sCzech = 'Czech';
  sCzechMsg = 'Czech';

  sFinnish = 'Finnish';
  sFinnishMsg = 'Finnish';

  sPortuguese = 'Portuguese';
  sPortugueseMsg = 'Portuguese';

  sTChinese = 'Chinese';
  sTChineseMsg = 'Traditional Chinese';

  // keyword

  sUI_Language = 'UI Language:';

type

  tSetLanguage = class(tNeatoBaseCommand)
  strict private
    fResponse: string;
  public
    constructor Create;
    destructor Destroy; override;
    procedure reset; override;
    function parsetext(data: tstringlist): boolean; override;
    property Response: String read fResponse write fResponse;
  end;

implementation

Constructor tSetLanguage.Create;
begin
  inherited;
  fCommand := sSetLanguage;
  fDescription := sDescription;
  reset;
end;

Destructor tSetLanguage.Destroy;
begin
  inherited;
end;

procedure tSetLanguage.reset;
begin
  fResponse := '';
  inherited;
end;

function tSetLanguage.parsetext(data: tstringlist): boolean;
begin
  try
    reset;
    result := false;

    if NOT assigned(data) then
      exit;

    // Simple test to make sure we got data

    data.CaseSensitive := false;

    data.text := trim(data.text);

    fResponse := data.text;

    if (pos(sUI_Language, data.text) > 0) then
    begin
      result := true;
    end
    else if pos(sUnrecognizedOption, data.text) > 0 then
    begin
      data.text := trim(data.text);
      ferror := data.text;
      result := false;
    end
    else
    begin
      ferror := strParseTextError;
      result := false;
    end;
  except
    on e: exception do
    begin
      ferror := e.Message;
      result := false;
    end;
  end;
end;

end.
