unit frame.Scripts;

interface

uses
  frame.master,
    atScripter,
  atScript, FMX.StdCtrls, System.Classes, FMX.Types, FMX.Controls, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo;

type
  TframeScripts = class(TframeMaster)
    Memo1: TMemo;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);

  private
    Scripter: TatScripter;
  public
    procedure init;
  end;

implementation

uses

  ScrmPS,
  FMX.ScriptForm,
  FMX.ScripterInit,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Variants,
  FMX.Dialogs,
  FMX.Grid.Style,

  FMX.Colors,
  FMX.TMSChart,
  FMX.Edit,
  FMX.EditBox,
  FMX.SpinBox,
  FMX.Grid,
  FMX.ListBox,
  FMX.Objects,
  FMX.Effects,
  FMX.TabControl,
  FMX.Layouts,
  FMX.Forms,
  XSuperObject,
  XSuperJson,
  System.Rtti,
  Generics.Collections,
  dmCommon,
  dmSerial.Windows,

ap_Classes, ap_Forms, ap_Dialogs;

{$R *.fmx}

procedure TframeScripts.Button1Click(Sender: TObject);
begin
  Scripter.SourceCode := Memo1.Lines;
  Scripter.Execute;
end;

procedure TframeScripts.init;
begin
  Scripter := TatScripter.Create(Self);
  Scripter.EventSupport := true;

  Scripter.AddLibrary(TatClassesLibrary);
  Scripter.AddLibrary(TatDialogsLibrary);

  Scripter.DefineClassByRTTI(TScriptForm, roInclude);
  Scripter.DefineClassByRTTI(TButton);
  Scripter.DefineClassByRTTI(TEdit);
  Scripter.DefineClassByRTTI(TLabel);
  Scripter.DefineClassByRTTI(TCustomMemo);
  Scripter.DefineClassByRTTI(TMemo);
  Scripter.DefineClassByRTTI(TStringList);
  Scripter.DefineClassByRTTI(TStrings);
  Scripter.DefineClassByRTTI(TCheckBox);
  Scripter.DefineClassByRTTI(TPanel);
  Scripter.DefineClassByRTTI(TRectangle);
  Scripter.DefineClassByRTTI(TRadioButton);
  Scripter.DefineClassByRTTI(TComboBox);

  Scripter.DefineClassByRTTI(TdmSerial);
  Scripter.DefineClassByRTTI(tdm);

  Scripter.AddObject('dm', dm);

  Scripter.AddConstant('mrOk', mrOk);
  Scripter.AddConstant('mrCancel', mrCancel);

  Scripter.AddDataModule(dm);
  resetfocus;
end;

end.
