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

function GetSubData(dStr: tstringlist; var item: tNeatoNameValuePair; LookFor: String; _Type: TVarType): Boolean;

function GetSubDataNameValuePair(dStr: tstringlist; var item: tNeatoNameValuePair; LookFor: String;
  _Type: TVarType): Boolean;

function HEX_TimeInSecs_asHours(HexValue: string): Double; // some values have HEX to represent time
function String_TimeInSecs_asHours(HexValue: string): Double; // some values have string number to represent time

implementation

function String_TimeInSecs_asHours(HexValue: string): Double; // some values have HEX to represent time
var
  value: longint;
begin
  try
   value := 0;
   value := hexvalue.ToInteger;
   value := (value div 60) div 60;
  except
   value := 0; // oops
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
