{$M+}
unit neato.Settings;

interface

uses classes, XSuperJSON, XSuperObject, sysutils;

Const
  JSONSettingsFile = 'NeatoToolio.JSON';

Type

  tNeatoSettings = class   // application settings file, in JSON format
  private
    fAutoDetectNeato: boolean; // flag for auto detect neato serial port
  public
   //
  published
    property AutoDetectNeato: boolean read fAutoDetectNeato write fAutoDetectNeato;
  end;

var
  NeatoSettings: tNeatoSettings;

implementation

initialization

var
  loadSettingsFile: TStringlist;

loadSettingsFile := TStringlist.Create;

try
  try
    if fileexists(JSONSettingsFile) then
    begin
      loadSettingsFile.LoadFromFile(JSONSettingsFile);
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

finalization

var
  saveSettingsFile: TStringlist;
try
  saveSettingsFile := TStringlist.Create;
  saveSettingsFile.Text := NeatoSettings.AsJSON(true);
  saveSettingsFile.SaveToFile(JSONSettingsFile);
finally
 freeandnil(saveSettingsFile);
end;

end.
