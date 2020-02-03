unit neato.D.SetButton;

interface

uses fmx.dialogs, classes, sysutils, neato.Commands, neato.errors, neato.helpers;

const
  sDescription = 'Simulates a button press.';
  // Command to send
  sSetButton = 'SetButton';

  ssoft = 'soft';
  ssoftmsg = 'Simulate pressing the soft button';

  sstart = 'start';
  sstartmsg = 'Simulate pressing the start button';

  sspot = 'spot';
  sspotmsg = 'Simulate pressing the spot button';

  sback = 'back';
  sbackmsg = 'Simulate pressing the back button';

  sup = 'up';
  supmsg = 'Simulate pressing the up button';

  sdown = 'down';
  sdownmsg = 'Simulate pressing the down button';

  sIRstart = 'IRstart';
  sIRstartMsg = 'Simulate pressing the start button';

  sIRspot = 'IRspot';
  sIRspotMsg = 'Simulate pressing the spot button';

  sIRfront = 'IRfront';
  sIRfrontMsg = 'Simulate pressing the front button';

  sIRback = 'IRback';
  sIRbackMsg = 'Simulate pressing the back button';

  sIRleft = 'IRleft';
  sIRleftMsg = 'Simulate pressing the left button';

  sIRright = 'IRright';
  sIRrightMsg = 'Simulate pressing the right button';

  sIRhome = 'IRhome';
  sIRhomeMsg = 'Simulate pressing the home button';

  sIReco = 'IReco';
  sIRecoMsg = 'Simulate pressing the eco button';

  sUnrecognizedOption = 'Unrecognized Option';

type

  tSetButton = class(tNeatoBaseCommand)
  strict private
  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function ParseText(data: tstringlist): boolean; override;

  end;

implementation

Constructor tSetButton.Create;
begin
  inherited;
  fCommand := sSetButton;
  fDescription := sDescription;
  Reset;
end;

Destructor tSetButton.Destroy;
begin
  inherited;
end;

procedure tSetButton.Reset;
begin
  inherited;
end;

function tSetButton.ParseText(data: tstringlist): boolean;
begin
  try
    Reset;
    result := false;

    if NOT assigned(data) then
      exit;

    // Simple test to make sure we got data

    data.CaseSensitive := false;

    data.text := trim(data.text);

    if data.count > 0 then
      data.delete(0);

    if data.text = '' then
    begin
      result := true;
    end
    else if pos(sUnrecognizedOption, data.text) > 0 then
    begin
      data.text := trim(data.text);
      ferror := data.text;
      result := false;
    end
    else
    begin
      ferror := strParseTextError;
      result := false;
    end;
  except
    on e: exception do
    begin
      ferror := e.Message;
      result := false;
    end;
  end;
end;

end.
