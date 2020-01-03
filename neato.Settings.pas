unit neato.Settings;

interface

uses classes, XSuperJSON, XSuperObject;

Const
  JSONSettingsFile = 'NeatoToolio.JSON';

Type

  tNeatoSettings = class
  private
    fAutoDetectNeato: boolean;
  public

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
    loadSettingsFile.LoadFromFile(JSONSettingsFile);
    NeatoSettings := tNeatoSettings.FromJSON(loadSettingsFile.Text);
  except
    NeatoSettings := tNeatoSettings.Create;
    NeatoSettings.AutoDetectNeato := false;
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
  saveSettingsFile.Free;
end;

end.
