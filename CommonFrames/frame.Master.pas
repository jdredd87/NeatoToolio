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
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, FMX.Objects,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.TabControl,
  FMX.Controls.Presentation, FMX.Layouts;

type
  TframeMaster = class(TForm)
    timer_getdata: TTimer;
    lblFrameTitle: TLabel;
    Layout: TScaledLayout;
    StyleBook: TStyleBook;
    LangFrame: TLang;
    procedure timer_getdataTimer(Sender: TObject);
  private
  public
    Tab: TTabItem;
    constructor Create(AOwner: TComponent; Rect: TRectangle); overload;

    procedure resetfocus;
  end;

implementation

uses dmCommon;

{$R *.fmx}

constructor TframeMaster.Create(AOwner: TComponent; Rect: TRectangle);
begin
  inherited Create(AOwner);

  timer_getdata.Enabled := false;

  // this makes sure AOwner IS a TTabItem

  if (AOwner is TTabItem) then
    Tab := AOwner as TTabItem
  else
    Tab := nil;

  Layout.Position.X := 0;
  Layout.Position.Y := 0;
  Layout.Align := talignlayout.Client;
  Layout.Parent := Rect;
  Layout.Visible := false;

  {
    Parent := Tab;
    position.X := 0;
    position.Y := 0;
    align := talignlayout.Client;
    visible := false;
  }
  // dmCommon.TimerList.Add(timer_getdata);
end;

procedure TframeMaster.resetfocus;
begin
  try
    BeginUpdate;
    try
      ActiveControl := nil;
    except
    end;
  finally
   endupdate;
  end;
end;

procedure TframeMaster.timer_getdataTimer(Sender: TObject);
begin
  //
end;

end.

