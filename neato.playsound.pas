unit neato.PlaySound;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors,
  neato.Helpers;

const

  // Command to send

  sPlaysoundSoundID = 'Playsound SoundId ';
  sSoundIDoutofRange = 'is out of range.';

  sSoundIDMax = 32;

type

  tPlaySound = class(tNeatoBaseCommand)
  private
  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: TStringList): boolean; override;
  end;

implementation

Function tPlaySound.ParseText(data: TStringList): boolean;
var
  id: integer;
begin
  try
    Reset;
    data.CaseSensitive := false;
    Result := pos(sSoundIDoutofRange, data.Text) = 0;
  except
    on e: exception do
    begin
      Reset;
      Result := false;
    end;
  end;

end;

Constructor tPlaySound.Create;
begin
  inherited;
  fCommand := sPlaysoundSoundID;
  fDescription := 'Play the specified sound in the robot.';
  Reset;
end;

Destructor tPlaySound.Destroy;
begin
  inherited;
end;

procedure tPlaySound.Reset;
begin
  inherited;
end;

end.
