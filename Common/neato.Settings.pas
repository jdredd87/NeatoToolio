{$M+}
unit neato.Settings;

interface

uses classes, XSuperJSON, XSuperObject, sysutils, system.ioutils;

Const
  JSONSettingsFile = 'NeatoToolio.JSON';

Type

  tNeatoSettings = class // application settings file, in JSON format
  private
    fAutoDetectNeato: boolean; // flag for auto detect neato serial port
  public
    //
  published
    property AutoDetectNeato: boolean read fAutoDetectNeato write fAutoDetectNeato;
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
      end;
    except
      on e: Exception do
      begin
        NeatoSettings := tNeatoSettings.Create; // something bad happened!
        NeatoSettings.AutoDetectNeato := false;
      end;
    end;
  finally
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
end;

end.
