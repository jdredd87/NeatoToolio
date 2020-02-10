unit frame.ScriptEngine;

interface

uses
  atScripter,
  ap_Sysutils,
  ap_Classes,
  ap_Graphics,
  ap_Controls,
  ap_Forms,
  ap_Dialogs,
  ap_StdCtrls,
  ap_Windows,
  ap_System,
  ap_ExtCtrls,
  ap_ComCtrls,
  ap_Menus,
  ap_Buttons,
  ap_ImgList,

  FMX.forms,
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
  FMX.Effects,
  System.ioutils,
  atScript,
  FMX.StdCtrls,
  System.Classes,
  FMX.Types,
  FMX.Controls,
  FMX.Controls.Presentation,
  FMX.ScrollBox,
  FMX.Memo,
  FMX.Layouts,
  FMX.ListBox,
  FMX.Objects,
  FMX.TabControl,
  atScriptDebug,
  atPascal,
  IDEMain,
  FMX.TMSMemo,
  FMX.TMSMemoStyles,
  ScrMemo,
  ScrMps,
  FMX.TMSBaseControl, IDEDialog;

type
  TframeScriptEngine = class(TFrame)
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    lbScripts: TListBox;
    lblScriptDescription: TLabel;
    btnScriptOpenEdit: TButton;
    btnScriptRun: TButton;
    btnScriptNew: TButton;
    tabScriptEditor: TTabItem;
    rectTop: TRectangle;
    btnScriptSave: TButton;
    btnScriptEditorRun: TButton;
    lblScriptFileName: TLabel;
    saveDialog: TSaveDialog;
    memoScript: TTMSFMXMemo;
    ScrPascalMemoStyler1: TScrPascalMemoStyler;
    TMSFMXMemoPascalStyler1: TTMSFMXMemoPascalStyler;
    IDEDialog1: TIDEDialog;
    IDEEngine1: TIDEEngine;
    IDEScripter1: TIDEScripter;
    btnIDE: TButton;
    ScripterEngine: TatScripter;
    procedure btnScriptEditorRunClick(Sender: TObject);
    procedure btnScriptNewClick(Sender: TObject);
    procedure lbScriptsChange(Sender: TObject);
    procedure btnScriptOpenEditClick(Sender: TObject);
    procedure btnScriptSaveClick(Sender: TObject);
    procedure memoScriptKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure btnIDEClick(Sender: TObject);
  private
    // ScripterEngine: TatScripter;
    fActiveScriptFN: String;
    procedure populate;
    procedure loadscript;
    procedure savescript;
    procedure SetActiveScriptFN(value: string);
  public
    scriptPath: string;
    procedure init;
    property ActiveScriptFN: String read fActiveScriptFN write SetActiveScriptFN;
  end;

implementation

{$R *.fmx}

uses
  neato.helpers,

  neato.D.Getversion,
  neato.D.GetCharger,
  neato.XV.GetCharger,

  XSuperObject,
  XSuperJson,
  System.Rtti,
  Generics.Collections,
  dmCommon,
  dmSerial.Windows;

procedure TframeScriptEngine.populate;
var
  filelist: TStringDynArray;
  idx: integer;
begin
  try
    lbScripts.BeginUpdate;
    lbScripts.Clear;
    forcedirectories(scriptPath);
    filelist := MyGetFiles(scriptPath, '*.PSC');
    for idx := 0 to high(filelist) do
      lbScripts.Items.Add(extractfilename(filelist[idx]));
  finally
    lbScripts.EndUpdate;
  end;
end;

procedure TframeScriptEngine.SetActiveScriptFN(value: string);
begin
  fActiveScriptFN := trim(value);
  fActiveScriptFN := scriptPath + fActiveScriptFN;
  if not fileexists(fActiveScriptFN) then
    fActiveScriptFN := '';

  lblScriptFileName.Text := extractfilename(fActiveScriptFN);
end;

procedure TframeScriptEngine.loadscript;
begin
  if ActiveScriptFN = '' then
    exit;

  memoScript.Lines.LoadFromFile(ActiveScriptFN);
  self.TabControl1.ActiveTab := tabScriptEditor;

end;

procedure TframeScriptEngine.memoScriptKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vktab then
    Key := vkSpace;
end;

procedure TframeScriptEngine.btnIDEClick(Sender: TObject);
begin
  IDEDialog1.Execute;
end;

procedure TframeScriptEngine.btnScriptEditorRunClick(Sender: TObject);
begin
  ScripterEngine.SourceCode := memoScript.Lines;
  ScripterEngine.Execute;
end;

procedure TframeScriptEngine.btnScriptNewClick(Sender: TObject);
var
  fn: string;
  samplescript: tstringlist;
begin
  saveDialog.InitialDir := scriptPath;
  if saveDialog.Execute then
  begin
    fn := saveDialog.FileName;
    if fileexists(fn) then
      showmessage('Invalid Filename! Already exists.')
    else
    begin
      try
        samplescript := tstringlist.Create;
        samplescript.Add('Program Sample;');
        samplescript.Add('');
        samplescript.Add('const');
        samplescript.Add('  ScriptDescription = ' + #39 + 'Sample program' + #39 + ';');
        samplescript.Add('');
        samplescript.Add('begin');
        samplescript.Add('  Showmessage(' + #39 + 'Hello Robot World!' + #39 + ');');
        samplescript.Add('end.');
        samplescript.SaveToFile(fn);
      except
        on e: Exception do
        begin
          showmessage('Could not create new script "' + fn + '" : ' + e.Message);
        end;
      end;
      freeandnil(samplescript);
    end;
  end;
  populate;
end;

procedure TframeScriptEngine.btnScriptOpenEditClick(Sender: TObject);
begin
  loadscript;
  resetfocus;
end;

procedure TframeScriptEngine.savescript;
begin
  try
    memoScript.Lines.SaveToFile(ActiveScriptFN);
  except
    on e: Exception do
    begin
      showmessage('Could not save script "' + ActiveScriptFN + '" : ' + e.Message);
    end;
  end;
end;

procedure TframeScriptEngine.btnScriptSaveClick(Sender: TObject);
begin
  savescript;
  resetfocus;
end;

procedure TframeScriptEngine.init;
begin

  scriptPath := System.ioutils.TPath.GetPublicPath + '\NeatoToolio\Scripts\';

  // ScripterEngine := TatScripter.Create(self);
  // ScripterEngine.EventSupport := True;

  ScripterEngine.AddLibrary(TatClassesLibrary);
  ScripterEngine.AddLibrary(TatDialogsLibrary);
  ScripterEngine.AddLibrary(TatSysUtilsLibrary);

  ScripterEngine.DefineClassByRTTI(TScriptForm, roInclude);
  ScripterEngine.DefineClassByRTTI(TButton);
  ScripterEngine.DefineClassByRTTI(TEdit);
  ScripterEngine.DefineClassByRTTI(TLabel);
  ScripterEngine.DefineClassByRTTI(TCustomMemo);
  ScripterEngine.DefineClassByRTTI(TMemo);
  ScripterEngine.DefineClassByRTTI(tstringlist);
  ScripterEngine.DefineClassByRTTI(TStrings);
  ScripterEngine.DefineClassByRTTI(TCheckBox);
  ScripterEngine.DefineClassByRTTI(TPanel);
  ScripterEngine.DefineClassByRTTI(TRectangle);
  ScripterEngine.DefineClassByRTTI(TRadioButton);
  ScripterEngine.DefineClassByRTTI(TComboBox);
  ScripterEngine.AddConstant('mrOk', mrOk);
  ScripterEngine.AddConstant('mrCancel', mrCancel);

//  ScripterEngine.DefineClassByRTTI(TdmSerial);
  ScripterEngine.DefineClassByRTTI(tdm);
  ScripterEngine.DefineClassByRTTI(tGetVersionD);
  ScripterEngine.DefineClassByRTTI(tGetChargerXV);
  ScripterEngine.DefineClassByRTTI(tGetChargerD);
  ScripterEngine.AddObject('dm', dm);
  ScripterEngine.AddDataModule(dm);


  {
  note to self for lidar mapping.

  don't clear map.
  if a plot point already exists then don't add it.
  possibly error of one near by to a certain point, don't add it.
  }



  IDEScripter1.AddLibrary(TatSysUtilsLibrary);
//  IDEScripter1.DefineClassByRTTI(TdmSerial);
  IDEScripter1.DefineClassByRTTI(tdm);
  IDEScripter1.DefineClassByRTTI(tGetVersionD);
  IDEScripter1.DefineClassByRTTI(tGetChargerXV);
  IDEScripter1.DefineClassByRTTI(tGetChargerD);
  IDEScripter1.AddObject('dm', dm);
  IDEScripter1.AddDataModule(dm);


  populate;
  resetfocus;
end;

procedure TframeScriptEngine.lbScriptsChange(Sender: TObject);
begin
  if lbScripts.ItemIndex > -1 then
  begin
    btnScriptOpenEdit.Enabled := True;
    btnScriptRun.Enabled := True;
    ActiveScriptFN := lbScripts.Items[lbScripts.ItemIndex];
  end
  else
  begin
    btnScriptOpenEdit.Enabled := false;
    btnScriptRun.Enabled := false;
    ActiveScriptFN := '';
  end;
end;

end.
