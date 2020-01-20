unit neato.D.ClearFiles;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors, neato.helpers;

const

  // Command to send
  sClearFilesD = 'ClearFiles';
  sAll = 'ALL';
  sBB = 'BB';
  sDeleting = 'Deleting'; // use this to search response for

  iClearFilesHeaderBreaksD = 2;

type

  tClearFilesD = class(tNeatoBaseCommand)
  strict private
  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: tstringlist): boolean; override;
  end;

implementation

Constructor tClearFilesD.Create;
begin
  inherited;
  fCommand := sClearFilesD;
  fDescription := 'Erases Black Box, and other Logs.';
  Reset;
end;

Destructor tClearFilesD.Destroy;
begin
  inherited;
end;

procedure tClearFilesD.Reset;
begin
  inherited;
end;

function tClearFilesD.ParseText(data: tstringlist): boolean;
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
    fError := strParseTextError;
    result := false;
  end;

end;

end.
