{$M+}
unit neato.Settings;

interface

uses classes, XSuperJSON, XSuperObject, sysutils, system.ioutils, neato.helpers;

Const
  JSONSettingsFile = 'NeatoToolio.JSON';

Type

  tNeatoSettings = class // application settings file, in JSON format
  private
    fAutoDetectNeato: boolean; // flag for auto detect neato serial port
    fIP: String;
    fPort: Integer;
    fLanguage: String;
  public
    //
  published
    property AutoDetectNeato: boolean read fAutoDetectNeato write fAutoDetectNeato;
    property IP: String read fIP write fIP;
    property PORT: Integer read fPort write fPort;
    property Language: String read fLanguage write fLanguage;
  end;

var
  NeatoSettings: tNeatoSettings;
  INIFilePath: string;

implementation

initialization

var
  loadSettingsFile: TStringlist;

begin
  loadSettingsFile := TStringlist.Create;
  INIFilePath := '';

  try
    forcedirectories(system.ioutils.TPath.GetHomePath + '\NeatoToolio\');
    INIFilePath := system.ioutils.TPath.GetHomePath + '\NeatoToolio\' + JSONSettingsFile;
    try
      if fileexists(INIFilePath) then
      begin
        loadSettingsFile.LoadFromFile(INIFilePath);
        NeatoSettings := tNeatoSettings.FromJSON(loadSettingsFile.Text);
      end
      else
      begin
        NeatoSettings := tNeatoSettings.Create; // something bad happened!
        NeatoSettings.AutoDetectNeato := true;
        NeatoSettings.fIP := '1.1.1.1';
        NeatoSettings.fPort := 2167;
        NeatoSettings.fLanguage := GetOSLangID;
      end;
    except
      on e: Exception do
      begin
        NeatoSettings := tNeatoSettings.Create; // something bad happened!
        NeatoSettings.AutoDetectNeato := false;
        NeatoSettings.fIP := '1.1.1.1';
        NeatoSettings.fPort := 2167;
        NeatoSettings.fLanguage := GetOSLangID;
      end;
    end;
  finally
    if NeatoSettings.fLanguage = '' then
      NeatoSettings.fLanguage := GetOSLangID;
    loadSettingsFile.Free;
  end;
end;

finalization

var
  saveSettingsFile: TStringlist;
try
  saveSettingsFile := TStringlist.Create;
  saveSettingsFile.Text := NeatoSettings.AsJSON(true);
  saveSettingsFile.SaveToFile(INIFilePath);
finally
  freeandnil(saveSettingsFile);
  NeatoSettings.Free;
end;

end.
