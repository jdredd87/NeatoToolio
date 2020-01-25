unit dmCommon;

interface

uses
{$IFDEF MSWINDOWS}
  dmSerial.Windows,
{$ENDIF}
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls, FMX.StdCtrls;

type
  Tdm = class(TDataModule)
    StyleBook: TStyleBook;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
{$IFDEF MSWINDOWS}
    COM: TdmSerial; // COM, Communicaitons level depending on OS
{$ENDIF}
    chkTestmode: tcheckbox; // allows frames to access the main form object easily!

  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  COM := TdmSerial.Create(self);
end;

procedure Tdm.DataModuleDestroy(Sender: TObject);
begin
  freeandnil(COM);
end;

end.
