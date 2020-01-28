unit neato.XV.GetErr;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors,
  neato.Helpers;

const

  // Command to send

  sDescription = 'Get Error Messages';
  sGetErr = 'GetErr';

type

  tGetErrXV = class(tNeatoBaseCommand)
  private
    fErrorList: TStringList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: TStringList): Boolean; override;

    property ErrorList: TStringList read fErrorList;
  end;

implementation

Constructor tGetErrXV.Create;
begin
  inherited;
  fCommand := sGetErr;
  fDescription := sDescription;

  fErrorList := TStringList.Create;
  fErrorList.CaseSensitive := false;
end;

Destructor tGetErrXV.Destroy;
begin
  freeandnil(fErrorList);
  inherited;
end;

procedure tGetErrXV.Reset;
begin
  if assigned(fErrorList) then
    fErrorList.Clear;
  inherited;
end;

function tGetErrXV.ParseText(data: TStringList): Boolean;
// this is a 3 field wide data set so things are differently done
var
  IDX: integer;
  name, value: string;
begin
  Reset;
  result := false;

  if NOT assigned(data) then
    exit;

  data.Text := stringreplace(data.Text, ' - ', '=', [rfreplaceall]);

  try
    for IDX := 0 to data.Count - 1 do
     if trim(data.Names[idx])<>'' then
      fErrorList.AddPair(data.Names[IDX], data.ValueFromIndex[IDX]);

    result := true;

  except
    on e: exception do
    begin
      fError := strParseTextError;
      result := false;
    end;
  end;
end;

end.
