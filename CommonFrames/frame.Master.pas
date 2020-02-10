{
  Purpose of this "master" frame is simple.
  Contains a timer control ( not every frame may need one.. but it will have at least one available )
  This timer control is registered ( added ) to a common object list ( so can quickly stop all timers )
  Each frame has a "Tab" variable to let the frame know its tab item its stuffed in.
  Create override assings the tab via AOwner. Sets some basic visual properties, and does the timer register.
  This reduces alot of repeated code.
}

unit frame.Master;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.TabControl,
  FMX.Controls.Presentation;

type
  TframeMaster = class(TFrame)
    timer_getdata: TTimer;
    lblFrameTitle: TLabel;
  private
  public
    Tab: TTabItem;
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses dmCommon;

{$R *.fmx}

constructor TframeMaster.Create(AOwner: TComponent);
begin
  inherited;

  timer_getdata.Enabled := false;

  // this makes sure AOwner IS a TTabItem

  if (AOwner is TTabItem) then
    Tab := AOwner as TTabItem
  else
    Tab := nil;

  Parent := Tab;
  position.X := 0;
  position.Y := 0;
  align := talignlayout.Client;
  visible := false;

//  dmCommon.TimerList.Add(timer_getdata);
end;

end.
