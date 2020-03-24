unit neato.Helpers;

interface

uses

{$IFDEF MSWINDOWS}
  winapi.windows,
  winapi.shellapi,
{$ENDIF}
{$IFDEF Android}
  FMX.Platform.Android,
  FMX.Helpers.Android,
  AndroidAPI.Helpers,
  AndroidAPI.jni.app,
  AndroidAPI.jni.GraphicsContentViewText,
  AndroidAPI.jni.Net,
  AndroidAPI.jni.JavaTypes,
  AndroidAPI.jni.media,
  AndroidAPI.JNIBridge,
  AndroidAPI.jni,
  AndroidAPI.jni.Provider,
  AndroidAPI.jni.Os,
{$ENDIF}
  IDUri,
  FMX.Dialogs,
  Classes,
  System.sysutils,
  System.types,
  StrUtils,
  IOUtils,
  Masks,
  FMX.extctrls,
  FMX.Grid,
  FMX.MaterialSources,
  FMX.objects,
  FMX.layers3d,
  FMX.Controls,
  FMX.graphics;

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

{$IFDEF MSWINDOWS}
  TCharSet = set of AnsiChar;
{$ELSE}
  TCharSet = set of Char;
{$ENDIF}
function GetSubData(dStr: tstringlist; var item: tNeatoNameValuePair; LookFor: String; _Type: TVarType): Boolean;

function GetSubDataNameValuePair(dStr: tstringlist; var item: tNeatoNameValuePair; LookFor: String;
  _Type: TVarType): Boolean;

function HEX_TimeInSecs_asHours(HexValue: string): Double; // some values have HEX to represent time
function String_TimeInSecs_asHours(HexValue: string): Double; // some values have string number to represent time
function splitString(const Str: string; const delims: TCharSet; RemoveBlanks: Boolean = false): tstringlist;
function OccurrencesOfChar(const S: string; const C: Char): Integer;

{$IFDEF MSWINDOWS}
function Hex2String(const Buffer: string): AnsiString;
function String2Hex(const Buffer: AnsiString): string;
{$ELSE}
function Hex2String(const Buffer: string): String;
function String2Hex(const Buffer: String): string;
{$ENDIF}
function FixStringCommaTwoPart(InputStr: string): String;
function GetAppVersionStr: string;

procedure LoadCSV(ScanData: String; sg: TStringGrid);
procedure LoadImageID(id: String; img: TImage); overload;
procedure LoadImageID(id: String; img: TImage3D); overload;

function map(x, in_min, in_max, out_min, out_max: extended): extended;
// Stole this code from Arduino as it is very handy!
function MyGetFiles(const Path, Masks: string): TStringDynArray;
// Stole this code from https://stackoverflow.com/questions/12726756/how-to-pass-multiple-file-extensions-to-tdirectory-getfiles/12726969

function GetOSLangID: String;
function OpenURL(const URL: string; const DisplayError: Boolean = false): Boolean;

implementation

function GetOSLangID: String;
{$IFDEF ANDROID}
begin
  Result := 'en';
end;
{$ENDIF}
{$IFDEF MSWINDOWS}

var
  Buffer: MarshaledString;
  UserLCID: LCID;
  BufLen: Integer;
begin // defaults
  UserLCID := GetUserDefaultLCID;
  BufLen := GetLocaleInfo(UserLCID, LOCALE_SISO639LANGNAME, nil, 0);
  Buffer := StrAlloc(BufLen);
  if GetLocaleInfo(UserLCID, LOCALE_SISO639LANGNAME, Buffer, BufLen) <> 0 then
    Result := Buffer
  else
    Result := 'en';
  StrDispose(Buffer);
end;
{$ENDIF}
{$IFDEF Linux64}
begin
  Result := 'en';
end;
{$ENDIF}

function MyGetFiles(const Path, Masks: string): TStringDynArray;
var
  MaskArray: TStringDynArray;
  Predicate: TDirectory.TFilterPredicate;
begin
  MaskArray := StrUtils.splitString(Masks, ';');
  Predicate := function(const Path: string; const SearchRec: TSearchRec): Boolean
    var
      Mask: string;
    begin
      for Mask in MaskArray do
        if MatchesMask(SearchRec.Name, Mask) then
          exit(True);
      exit(false);
    end;
  Result := TDirectory.GetFiles(Path, Predicate);
end;

{$IFDEF MSWINDOWS}

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
{$ENDIF}
{$IFDEF ANDROID}

function GetAppVersionStr: string;
var
  PackageManager: JPackageManager;
  PackageInfo: JPackageInfo;
begin
  PackageManager := SharedActivity.getPackageManager;
  PackageInfo := PackageManager.getPackageInfo(SharedActivityContext.getPackageName(),
    TJPackageManager.JavaClass.GET_ACTIVITIES);
  Result := JStringToString(PackageInfo.versionName);
end;

{$ENDIF}

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
    try
      InStream := TResourceStream.Create(HInstance, id, RT_RCDATA);
    except
      InStream := TResourceStream.Create(HInstance, 'NeatoLogo', RT_RCDATA);
    end;
  finally
  end;

  if assigned(InStream) then
  begin
    img.BeginUpdate;
    img.Canvas.BeginScene;
    img.Bitmap.LoadFromStream(InStream);
    img.Width := img.Bitmap.Width;
    img.Height := img.Bitmap.Height;
    img.Visible := True;
    img.Canvas.EndScene;
    img.EndUpdate;
    InStream.Free;
  end;
end;

procedure LoadImageID(id: String; img: TImage3D);
var
  InStream: TResourceStream;
begin
  try
    try
      InStream := TResourceStream.Create(HInstance, id, RT_RCDATA);
    except
      InStream := TResourceStream.Create(HInstance, 'NeatoLogo', RT_RCDATA);
    end;
  finally
  end;

  if assigned(InStream) then
  begin
    img.Bitmap.LoadFromStream(InStream);
    InStream.Free;
  end;
end;

{$IFDEF MSWINDOWS}

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
{$ELSE}

function String2Hex(const Buffer: String): string;
begin
  SetLength(Result, Length(Buffer));
  // showmessage('String2Hex broke');
  // BinToHex(PChar(Buffer), PChar(Result), Length(Buffer));
end;

function Hex2String(const Buffer: string): String;
begin
  SetLength(Result, Length(Buffer));
  // HexToBin(PChar(Buffer), PChar(Result), Length(Result));
end;
{$ENDIF}

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
      tq := True;
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
{$IFDEF MSWINDOWS}
  trystrtoint('$' + HexValue, value);
{$ELSE}
  // trystrtoint('$' + HexValue, value);
  value := 1;
{$ENDIF}
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

function OpenURL(const URL: string; const DisplayError: Boolean = false): Boolean;
{$IFDEF ANDROID}
var
  Intent: JIntent;
begin
  // There may be an issue with the geo: prefix and URLEncode.
  // will need to research
  Intent := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_VIEW,
    TJnet_Uri.JavaClass.parse(StringToJString(TIdURI.URLEncode(URL))));
  try
    SharedActivity.startActivity(Intent);
    exit(True);
  except
    on e: exception do
    begin
      if DisplayError then
        ShowMessage('Error: ' + e.Message);
      exit(false);
    end;
  end;
end;
{$ENDIF ANDROID}
{$IFDEF IOS}

var
  app: UIApplication;
  NSU: NSurl;
begin
  app := TUIApplication.Wrap(TUIApplication.OCClass.sharedApplication);
  NSU := TNSURL.Wrap(TNSURL.OCClass.URLWithString(StrToNSStr(URL)));
  if app.canopenURL(NSU) then
    // Check if there is a default App that can open the URL
    app.OpenURL(NSU)
  else
    ShowMessage('Can not open URL');
end;

{$ENDIF IOS}
{$IFDEF MSWINDOWS}
begin
  winapi.shellapi.ShellExecute(0, 'OPEN', PChar(URL), '', '', SW_SHOWNORMAL);
end;
{$ENDIF MSWINDOWS}
{$IFDEF LINUX64}
begin
  ShowMessage('OpenURL Linux64');
end;
{$ENDIF}
{$IFDEF ios}

function StrToNSStringPtr(const AValue: string): Pointer;
begin
  Result := (StrToNSStr(AValue) as ILocalObject).GetObjectID;
end;

function IsWifiEnabled: Boolean;
var
  LAddrList, LAddrInfo: pifaddrs;
  LSet: NSCountedSet;
begin
  Result := false;
  if getifaddrs(LAddrList) = 0 then
    try
      LSet := TNSCountedSet.Create;
      LAddrInfo := LAddrList;
      repeat
        if (LAddrInfo.ifa_flags and IFF_UP) = IFF_UP then
          LSet.addObject(TNSString.OCClass.stringWithUTF8String(LAddrInfo.ifa_name));
        LAddrInfo := LAddrInfo^.ifa_next;
      until LAddrInfo = nil;
      Result := LSet.countForObject(StrToNSStringPtr(cWifiInterfaceName)) > 1;
    finally
      freeifaddrs(LAddrList);
    end;
end;
{$ENDIF}

end.
