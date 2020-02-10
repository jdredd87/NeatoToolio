unit frame.Scripts;

interface

uses

  atScript,
  atScripter,
  System.ioutils,
  FMX.ScriptForm,
    FMX.ScripterInit,
    FMX.Grid.Style,
  FMX.Colors,
  FMX.TMSChart,
  FMX.Edit,
  FMX.EditBox,
  FMX.SpinBox,
  FMX.Grid,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Objects, FMX.ScrollBox, FMX.Memo,
  FMX.Controls.Presentation, FMX.Layouts, FMX.ListBox, FMX.TabControl;

type
  TframeScripts = class(TFrame)
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    lbScripts: TListBox;
    lblScriptDescription: TLabel;
    btnScriptOpenEdit: TButton;
    btnScriptRun: TButton;
    btnScriptNew: TButton;
    tabScriptEditor: TTabItem;
    memoScript: TMemo;
    Rectangle1: TRectangle;
    btnScriptSave: TButton;
    btnScriptEditorRun: TButton;
    lblScriptFileName: TLabel;
    procedure btnScriptEditorRunClick(Sender: TObject);
  private
    Scripter: TatScripter;
    procedure populate;
  public
    procedure init;
  end;

implementation

{$R *.fmx}

uses
  ScrmPS,
  XSuperObject,
  XSuperJson,
  System.Rtti,
  Generics.Collections,
  dmCommon,
  dmSerial.Windows,
  ap_Classes, ap_Forms, ap_Dialogs;

procedure TframeScripts.populate;
var
  searchPath: string;
  filelist: TStringDynArray;
  LSearchOption: TSearchOption;
  S: String;
begin
  searchPath := System.ioutils.TPath.GetHomePath + '\NeatoToolio\Scripts\*.NTO';
  filelist := TDirectory.GetFiles(searchPath, 'NTO', LSearchOption);
  lbScripts.BeginUpdate;
  lbScripts.Clear;

  for S in filelist do
    lbScripts.Items.Add(S);

end;


procedure TframeScripts.btnScriptEditorRunClick(Sender: TObject);
begin
  Scripter.SourceCode := memoScript.Lines;
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
  populate;
  resetfocus;
end;

end.
