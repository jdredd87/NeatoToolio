{

This is common call between XV and Dx models.
So both have this in common.

}

unit neato.DXV.PlaySound;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors,
  neato.Helpers;

const

  sDescription = 'Play the specified sound in the robot.';
  // Command to send

  sPlaysoundSoundID = 'Playsound SoundId ';
  sSoundIDoutofRange = 'is out of range.';

  sSoundIDMax = 32;

type

  tPlaySoundDXV = class(tNeatoBaseCommand)
  private
  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: TStringList): boolean; override;
  end;

implementation

Function tPlaySoundDXV.ParseText(data: TStringList): boolean;
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

Constructor tPlaySoundDXV.Create;
begin
  inherited;
  fCommand := sPlaysoundSoundID;
  fDescription := sDescription;
  Reset;
end;

Destructor tPlaySoundDXV.Destroy;
begin
  inherited;
end;

procedure tPlaySoundDXV.Reset;
begin
  inherited;
end;

end.
