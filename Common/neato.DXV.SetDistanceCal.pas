unit neato.DXV.SetDistanceCal;

interface

uses
  fmx.dialogs, classes, sysutils, neato.Commands, neato.errors, neato.helpers, system.dateutils;

const

  sDescription = 'Compute and set distance sensor calibration values for min and max distances.';

  // Command to send
  sSetDistanceCal = 'SetDistanceCal';
  sUnrecognizedOption = 'Unrecognized Option';

  sTestmoed = 'TestMode';

  sDropMinimum = 'DropMinimum';
  sDropMiddle = 'DropMiddle';
  sDropMaximum = 'DropMaximum';
  sWallMinimum = 'WallMinimum';
  sWallMiddle = 'WallMiddle';
  sWallMaximum = 'WallMaximum';

  sDropMinimumMsg = 'Take minimum distance drop sensor readings. Mutually exclusive of DropMiddle and DropMax.';
  sDropMiddleMsg = 'Take middle distance drop sensor readings. Mutually exclusive of DropMinimim and DropMax.';
  sDropMaximumMsg = 'Take maximum distance drop sensor readings. Mutually exclusive of DropMinimum and DropMiddle.';
  sWallMinimumMsg = 'Take minimum distance wall sensor readings. Mutually exclusive of WallMiddle and WallMax.';
  sWallMiddleMsg = 'Take middle distance wall sensor readings. Mutually exclusive of WallMinimim and WallMax.';
  sWallMaximumMsg = 'Take maximum distance wall sensor readings. Mutually exclusive of WallMinimim and WallMiddle.';

  sLabel = 'Label';
  sValue = 'Value';
  sRDropCalA2DMin = 'RDropCalA2DMin';
  sRDropCalA2DMid = 'RDropCalA2DMid';
  sRDropCalA2DMax = 'RDropCalA2DMax';
  sLDropCalA2DMin = 'LDropCalA2DMin';
  sLDropCalA2DMid = 'LDropCalA2DMid';
  sLDropCalA2DMax = 'LDropCalA2DMax';
  sWallCalA2DMin = 'WallCalA2DMin';
  sWallCalA2DMid = 'WallCalA2DMid';
  sWallCalA2DMax = 'WallCalA2DMax';

type
  tSetDistanceCalDXV = class(tNeatoBaseCommand)
  strict private
    fRDropCalA2DMin: double;
    fRDropCalA2DMid: double;
    fRDropCalA2DMax: double;
    fLDropCalA2DMin: double;
    fLDropCalA2DMid: double;
    fLDropCalA2DMax: double;
    fWallCalA2DMin: double;
    fWallCalA2DMid: double;
    fWallCalA2DMax: double;

  public
    constructor Create;
    destructor Destroy; override;
    procedure reset; override;
    function parsetext(data: tstringlist): boolean; override;
    property RDropCalA2DMin: double read fRDropCalA2DMin write fRDropCalA2DMin;
    property RDropCalA2DMid: double read fRDropCalA2DMid write fRDropCalA2DMid;
    property RDropCalA2DMax: double read fRDropCalA2DMax write fRDropCalA2DMax;
    property LDropCalA2DMin: double read fLDropCalA2DMin write fLDropCalA2DMin;
    property LDropCalA2DMid: double read fLDropCalA2DMid write fLDropCalA2DMid;
    property LDropCalA2DMax: double read fLDropCalA2DMax write fLDropCalA2DMax;
    property WallCalA2DMin: double read fWallCalA2DMin write fWallCalA2DMin;
    property WallCalA2DMid: double read fWallCalA2DMid write fWallCalA2DMid;
    property WallCalA2DMax: double read fWallCalA2DMax write fWallCalA2DMax;
  end;

implementation

Constructor tSetDistanceCalDXV.Create;
begin
  inherited;
  fCommand := sSetDistanceCal;
  fDescription := sDescription;
  reset;
end;

Destructor tSetDistanceCalDXV.Destroy;
begin
  inherited;
end;

procedure tSetDistanceCalDXV.reset;
begin
  fRDropCalA2DMin := 0;
  fRDropCalA2DMid := 0;
  fRDropCalA2DMax := 0;
  fLDropCalA2DMin := 0;
  fLDropCalA2DMid := 0;
  fLDropCalA2DMax := 0;
  fWallCalA2DMin := 0;
  fWallCalA2DMid := 0;
  fWallCalA2DMax := 0;
  inherited;
end;

{
  SETDISTANCECAL WALLMIDDLE
  Label,Value
  RDropCalA2DMin,458
  RDropCalA2DMid,459
  RDropCalA2DMax,460
  LDropCalA2DMin,465
  LDropCalA2DMid,465
  LDropCalA2DMax,465
  WallCalA2DMin,752
  WallCalA2DMid,119
  WallCalA2DMax,118
}

function tSetDistanceCalDXV.parsetext(data: tstringlist): boolean;
begin
  reset;
  result := false;

  if NOT assigned(data) then
    exit;

  // Simple test to make sure we got data

  data.CaseSensitive := false;
  data.Text := stringreplace(data.Text, ',', '=', [rfreplaceall]);

  if (pos(sLabel, data.Text) > 0) or (pos(sValue, data.Text) > 0) then
  begin
    result := true;
    trystrtofloat(data.Values[sRDropCalA2DMin], fRDropCalA2DMin);
    trystrtofloat(data.Values[sRDropCalA2DMid], fRDropCalA2DMid);
    trystrtofloat(data.Values[sRDropCalA2DMax], fRDropCalA2DMax);
    trystrtofloat(data.Values[sLDropCalA2DMin], fLDropCalA2DMin);
    trystrtofloat(data.Values[sLDropCalA2DMid], fLDropCalA2DMid);
    trystrtofloat(data.Values[sLDropCalA2DMax], fLDropCalA2DMax);
    trystrtofloat(data.Values[sWallCalA2DMin], fWallCalA2DMin);
    trystrtofloat(data.Values[sWallCalA2DMid], fWallCalA2DMid);
    trystrtofloat(data.Values[sWallCalA2DMax], fWallCalA2DMax);
  end
  else if (pos(sUnrecognizedOption, data.Text) > 0) or (pos(sTestmoed, data.Text) > 0) then
  begin
    data.Text := trim(data.Text);
    ferror := data.Text;
    result := false;
  end
  else
  begin
    ferror := strParseTextError;
    result := false;
  end;
end;

end.
