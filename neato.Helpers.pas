unit neato.Helpers;

interface

uses Classes, System.sysutils;

type
  tNeatoNameValuePair = record
    _Unit: string;
    ValueString: String;
    ValueDouble: Double;
    ValueBoolean: Boolean;
  end;

  TStringArray = array of string; // for splitString
  TIntegerArray = array of Integer; // for splitString
  TCharSet = set of Char;

function GetSubData(dStr: tstringlist; var item: tNeatoNameValuePair; LookFor: String; _Type: TVarType): Boolean;

function GetSubDataNameValuePair(dStr: tstringlist; var item: tNeatoNameValuePair; LookFor: String;
  _Type: TVarType): Boolean;

function HEX_TimeInSecs_asHours(HexValue: string): Double; // some values have HEX to represent time
function String_TimeInSecs_asHours(HexValue: string): Double; // some values have string number to represent time
function splitString(const Str: string; const delims: TCharSet; RemoveBlanks: Boolean = false): tstringlist;

implementation

function splitString(const Str: string; const delims: TCharSet; RemoveBlanks: Boolean = false): tstringlist;
var
  SepPos: TIntegerArray;
  i, c: Integer;
  tq: Boolean;
  value: String;

begin
  result := tstringlist.Create;

  SetLength(SepPos, 1);
  SepPos[0] := 0;
  for i := 1 to Length(Str) do
  begin
    if Str[i] = '(' then
      tq := true;
    if Str[i] = ')' then
      tq := false;
    if (Str[i] in delims) and (tq = false) then
    begin
      SetLength(SepPos, Length(SepPos) + 1);
      SepPos[High(SepPos)] := i;
      tq := false;
    end;
  end;
  SetLength(SepPos, Length(SepPos) + 1);
  SepPos[High(SepPos)] := Length(Str) + 1;
  // SetLength(Result, High(SepPos));

  for i := 1 to High(SepPos) do
    result.Add(''); // and some dummy data for storage

  c := 0;
  for i := 0 to High(SepPos) - 1 do
  begin
    value := Trim(Copy(Str, SepPos[i] + 1, SepPos[i + 1] - SepPos[i] - 1));
    if RemoveBlanks then
    begin
      if value <> '' then
      begin
        result[c] := Trim(Copy(Str, SepPos[i] + 1, SepPos[i + 1] - SepPos[i] - 1));
        inc(c);
      end;
    end
    else
    begin
      result[c] := Trim(Copy(Str, SepPos[i] + 1, SepPos[i + 1] - SepPos[i] - 1));
      inc(c);
    end;
  end;


  for i := result.Count-1 downto c do
     result.Delete(i);

//  SetLength(result, c);

end;

function String_TimeInSecs_asHours(HexValue: string): Double; // some values have HEX to represent time
var
  value: longint;
begin
  try
    value := HexValue.ToInteger;
    value := (value div 60) div 60;
  except
    on e: exception do
    begin
      value := 0; // oops this is bad if this happens
    end;
  end;
  result := value;
end;

function HEX_TimeInSecs_asHours(HexValue: string): Double; // some values have HEX to represent time
var
  value: longint;
begin
  value := 0;
  trystrtoint('$' + HexValue, value);
  value := (value div 60) div 60;
  result := value;
end;

function GetSubData(dStr: tstringlist; var item: tNeatoNameValuePair; LookFor: String; _Type: TVarType): Boolean;
var
  subData: tstringlist;
begin
  result := false;
  item._Unit := '';
  item.ValueString := '';
  item.ValueDouble := 0;
  item.ValueBoolean := false;

  try
    subData := tstringlist.Create;
    subData.DelimitedText := dStr.Values[LookFor];

    item._Unit := subData[0];
    case _Type of
      varDouble:
        TryStrToFloat(subData[1], item.ValueDouble);
      varString:
        item.ValueString := subData[1];
      varBoolean:
        TryStrToBool(subData[1], item.ValueBoolean);
    end;

  except
    on e: exception do
    begin
      item._Unit := '';
      item.ValueString := '';
      item.ValueDouble := 0;
      item.ValueBoolean := false;
      result := false;
    end;
  end;

  freeandnil(subData);
end;

function GetSubDataNameValuePair(dStr: tstringlist; var item: tNeatoNameValuePair; LookFor: String;
  _Type: TVarType): Boolean;
begin
  result := false;
  item._Unit := '';
  item.ValueString := '';
  item.ValueDouble := 0;
  item.ValueBoolean := false;
  try
    item._Unit := ''; // this style gives only a name/value pair
    item.ValueString := dStr.Values[LookFor]; // save raw value if needed

    case _Type of // converts string to a "type" if possible
      varDouble:
        TryStrToFloat(dStr.Values[LookFor], item.ValueDouble);
      varBoolean:
        TryStrToBool(dStr.Values[LookFor], item.ValueBoolean);
    end;

  except
    on e: exception do
    begin
      item._Unit := '';
      item.ValueString := '';
      item.ValueDouble := 0;
      item.ValueBoolean := false;
      result := false;
    end;
  end;

end;

end.
