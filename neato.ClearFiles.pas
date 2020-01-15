unit neato.ClearFiles;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors, neato.helpers;

const

  // Command to send
  sClearFiles = 'ClearFiles';
  sAll = 'ALL';
  sBB = 'BB';
  sDeleting = 'Deleting'; // use this to search response for

  iClearFilesHeaderBreaks = 2;

type

  tClearFiles = class(tNeatoBaseCommand)
  strict private
  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: tstringlist): boolean; override;
  end;

implementation

Constructor tClearFiles.Create;
begin
  inherited;
  fCommand := sClearFiles;
  fDescription := 'Erases Black Box, and other Logs.';
  Reset;
end;

Destructor tClearFiles.Destroy;
begin
  inherited;
end;

procedure tClearFiles.Reset;
begin
  inherited;
end;

function tClearFiles.ParseText(data: tstringlist): boolean;
begin
  Reset;
  result := false;

  if NOT assigned(data) then
    exit;

  // Simple test to make sure we got data
  data.CaseSensitive := false;
  if pos(sDeleting, data.text) > 0 then
  begin
    result := true;
  end
  else
  begin
    fError := nParseTextError;
    result := false;
  end;

end;

end.
