unit dmIP;

interface

uses
  System.SysUtils, System.Classes, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdCmdTCPClient;

type
  TDataModule1 = class(TDataModule)
    IdCmdTCPClient1: TIdCmdTCPClient;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
