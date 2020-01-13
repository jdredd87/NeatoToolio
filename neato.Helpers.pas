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
function OccurrencesOfChar(const S: string; const C: Char): Integer;
function Hex2String(const Buffer: string): AnsiString;
function String2Hex(const Buffer: AnsiString): string;

implementation

function String2Hex(const Buffer: AnsiString): string;
begin
  SetLength(Result, Length(Buffer) * 2);
  BinToHex(PAnsiChar(Buffer), PChar(Result), Length(Buffer));
end;

function Hex2String(const Buffer: string): AnsiString;
begin
  SetLength(Result, Length(Buffer) div 2);
  HexToBin(PChar(Buffer), PAnsiChar(Result), Length(Result));
end;

function OccurrencesOfChar(const S: string; const C: Char): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 1 to Length(S) do
    if S[i] = C then
      inc(Result);
end;

function splitString(const Str: string; const delims: TCharSet; RemoveBlanks: Boolean = false): tstringlist;
var
  SepPos: TIntegerArray;
  i, C: Integer;
  tq: Boolean;
  value: String;

begin
  Result := tstringlist.Create;

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
    Result.Add(''); // and some dummy data for storage

  C := 0;
  for i := 0 to High(SepPos) - 1 do
  begin
    value := Trim(Copy(Str, SepPos[i] + 1, SepPos[i + 1] - SepPos[i] - 1));
    if RemoveBlanks then
    begin
      if value <> '' then
      begin
        Result[C] := Trim(Copy(Str, SepPos[i] + 1, SepPos[i + 1] - SepPos[i] - 1));
        inc(C);
      end;
    end
    else
    begin
      Result[C] := Trim(Copy(Str, SepPos[i] + 1, SepPos[i + 1] - SepPos[i] - 1));
      inc(C);
    end;
  end;

  for i := Result.Count - 1 downto C do
    Result.Delete(i);

  // SetLength(result, c);

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
  Result := value;
end;

function HEX_TimeInSecs_asHours(HexValue: string): Double; // some values have HEX to represent time
var
  value: longint;
begin
  value := 0;
  trystrtoint('$' + HexValue, value);
  value := (value div 60) div 60;
  Result := value;
end;

function GetSubData(dStr: tstringlist; var item: tNeatoNameValuePair; LookFor: String; _Type: TVarType): Boolean;
var
  subData: tstringlist;
begin
  Result := false;
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
      Result := false;
    end;
  end;

  freeandnil(subData);
end;

function GetSubDataNameValuePair(dStr: tstringlist; var item: tNeatoNameValuePair; LookFor: String;
  _Type: TVarType): Boolean;
begin
  Result := false;
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
      Result := false;
    end;
  end;

end;

end.
