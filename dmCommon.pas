unit dmCommon;

interface

uses
{$IFDEF MSWINDOWS}
  dmSerial.Windows,
{$ENDIF}
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls;

type
  Tdm = class(TDataModule)
    StyleBook: TStyleBook;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
   {$ifdef MSWINDOWS}
   COM: TdmSerial; // COM, Communicaitons level depending on OS
   {$endif}
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
 com := TdmSerial.Create(self);
end;

procedure Tdm.DataModuleDestroy(Sender: TObject);
begin
 freeandnil(com);
end;

end.
