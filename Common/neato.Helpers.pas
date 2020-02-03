unit neato.Helpers;

interface

uses

{$IFDEF MSWINDOWS}
  winapi.windows,
{$ENDIF}
  Classes,
  System.sysutils,
  System.types,
  fmx.extctrls,
  fmx.Grid,
  fmx.MaterialSources,
  fmx.objects,
  fmx.layers3d;

type

  TStringGridHelper = class helper for TStringGrid
    procedure Clear;
  end;

  tNeatoNameValuePair = record
    _Unit: string;
    ValueString: String;
    ValueDouble: Double;
    ValueBoolean: Boolean;
  end;

  TStringArray = array of string; // for splitString
  TIntegerArray = array of Integer; // for splitString
  TCharSet = set of AnsiChar;

function GetSubData(dStr: tstringlist; var item: tNeatoNameValuePair; LookFor: String; _Type: TVarType): Boolean;

function GetSubDataNameValuePair(dStr: tstringlist; var item: tNeatoNameValuePair; LookFor: String;
  _Type: TVarType): Boolean;

function HEX_TimeInSecs_asHours(HexValue: string): Double; // some values have HEX to represent time
function String_TimeInSecs_asHours(HexValue: string): Double; // some values have string number to represent time
function splitString(const Str: string; const delims: TCharSet; RemoveBlanks: Boolean = false): tstringlist;
function OccurrencesOfChar(const S: string; const C: Char): Integer;
function Hex2String(const Buffer: string): AnsiString;
function String2Hex(const Buffer: AnsiString): string;
function FixStringCommaTwoPart(InputStr: string): String;
function GetAppVersionStr: string;

procedure LoadCSV(ScanData: String; sg: TStringGrid);
procedure LoadImageID(id: String; img: TImage); overload;
procedure LoadImageID(id: String; img: TImage3D); overload;

function map(x, in_min, in_max, out_min, out_max: extended): extended;
// Stole this code from Arduino as it is very handy!

implementation

function GetAppVersionStr: string;
var
  Exe: string;
  Size, Handle: DWORD;
  Buffer: TBytes;
  FixedPtr: PVSFixedFileInfo;
begin
  Exe := ParamStr(0);
  Size := GetFileVersionInfoSize(PChar(Exe), Handle);
  if Size = 0 then
    RaiseLastOSError;
  SetLength(Buffer, Size);
  if not GetFileVersionInfo(PChar(Exe), Handle, Size, Buffer) then
    RaiseLastOSError;
  if not VerQueryValue(Buffer, '\', Pointer(FixedPtr), Size) then
    RaiseLastOSError;
  Result := Format('%d.%d.%d.%d', [LongRec(FixedPtr.dwFileVersionMS).Hi, // major
    LongRec(FixedPtr.dwFileVersionMS).Lo, // minor
    LongRec(FixedPtr.dwFileVersionLS).Hi, // release
    LongRec(FixedPtr.dwFileVersionLS).Lo]) // build
end;

Function FixStringCommaTwoPart(InputStr: string): String;
begin
  Result := InputStr;
  Result := StringReplace(Result, '=', '', []);
end;

procedure LoadImageID(id: String; img: TImage);
var
  InStream: TResourceStream;
begin
  try
    InStream := TResourceStream.Create(HInstance, id, RT_RCDATA);
  except
    InStream := TResourceStream.Create(HInstance, 'NeatoLogo', RT_RCDATA);
  end;
  if assigned(InStream) then
  begin
    img.BeginUpdate;
    img.Canvas.BeginScene;
    img.Bitmap.LoadFromStream(InStream);
    img.Width := img.Bitmap.Width;
    img.Height := img.Bitmap.Height;
    img.Visible := true;
    img.Canvas.EndScene;
    img.EndUpdate;
  end;
end;

procedure LoadImageID(id: String; img: TImage3D);
var
  InStream: TResourceStream;
begin
  try
    InStream := TResourceStream.Create(HInstance, id, RT_RCDATA);
  except
    InStream := TResourceStream.Create(HInstance, 'NeatoLogo', RT_RCDATA);
  end;
  if assigned(InStream) then
  begin
    img.Bitmap.LoadFromStream(InStream);
  end;
end;

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
  tq := false;

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

  if assigned(subData) then
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

procedure TStringGridHelper.Clear;
begin
  RowCount := 0;
  RowCount := 1;
end;

procedure LoadCSV(ScanData: String; sg: TStringGrid);
var
  i, j, position, Count, edt1: Integer;
  temp, tempField: string;
  FieldDel: Char;
  Data: tstringlist;
begin
  sg.BeginUpdate;
  Data := tstringlist.Create;
  FieldDel := ',';
  Data.Text := ScanData;
  temp := Data[1];

  Count := 0;

  for i := 1 to Length(temp) do
    if Copy(temp, i, 1) = FieldDel then
      inc(Count);

  edt1 := Count + 1;

  sg.RowCount := Data.Count;

  for i := 0 to Data.Count - 1 do
  begin;
    temp := Data[i];
    if Copy(temp, Length(temp), 1) <> FieldDel then
      temp := temp + FieldDel;
    while pos('"', temp) > 0 do
    begin
      Delete(temp, pos('"', temp), 1);
    end;
    for j := 1 to edt1 do
    begin
      position := pos(FieldDel, temp);
      tempField := Copy(temp, 0, position - 1);

      sg.Cells[j - 1, i] := tempField;

      Delete(temp, 1, Length(tempField) + 1);
    end;
  end;
  Data.Free;
  sg.EndUpdate;
end;

function map(x, in_min, in_max, out_min, out_max: extended): extended;
begin
  Result := (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
end;

end.
