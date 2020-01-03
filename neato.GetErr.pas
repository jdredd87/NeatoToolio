unit neato.GetErr;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors,
  neato.Helpers;

const

  // Command to send

  sGetErr = 'GetErr';

type

  tGetErr = class(tNeatoBaseCommand)
  private
    fErrorList: TStringList;
  public
    constructor create;
    destructor destroy; override;
    procedure Reset; override;
    function ParseText(data: TStringList): Boolean;

    property ErrorList: TStringList read fErrorList;
  end;

implementation

Constructor tGetErr.create;
begin
  inherited;
  fCommand := sGetErr;
  fDescription := 'Get Error Messages';

  fErrorList := TStringList.create;
  fErrorList.CaseSensitive := false;
end;

Destructor tGetErr.destroy;
begin
  freeandnil(fErrorList);
  inherited;
end;

procedure tGetErr.Reset;
begin
  if assigned(fErrorList) then
    fErrorList.Clear;
  inherited;
end;

function tGetErr.ParseText(data: TStringList): Boolean;
// this is a 3 field wide data set so things are differently done
var
  IDX: integer;
  name, value: string;
begin
  Reset;
  result := false;

  if NOT assigned(data) then
    exit;

  try
    for IDX := 0 to data.Count - 1 do
    begin
      if pos(sGetErr, data[IDX]) > 0 then
        continue; // skip row as it has the cmd sent

      if odd(IDX) then
        name := data[IDX]
      else
      begin
        value := data[IDX];
        fErrorList.AddPair(name, value);
        name := '';
        value := '';
      end;
    end;

    result := true;

  except
    on e: exception do
    begin
      fError := nParseTextError;
      result := false;
    end;
  end;
end;

end.
