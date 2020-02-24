unit frame.DXV.SetLanguage;

interface

uses
  frame.master,
  dmCommon,
  neato.DXV.SetLanguage,
  FMX.TabControl,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.DateTimeCtrls, FMX.Objects, FMX.Edit, FMX.EditBox, FMX.SpinBox, FMX.ListBox, FMX.ScrollBox, FMX.Memo, FMX.Layouts;

type
  TframeDXVSetLanguage = class(TframeMaster)
    lblSetLanguageError: TLabel;
    rectTop: TRectangle;

    btnSetLanguageNone: TButton;
    btnSetLanguageGerman: TButton;
    btnSetLanguageItalian: TButton;
    btnSetLanguageDutch: TButton;
    btnSetLanguageEnglish: TButton;
    btnSetLanguageSpanish: TButton;
    btnSetLanguageJapanese: TButton;
    btnSetLanguageSwedish: TButton;
    btnSetLanguageSChinese: TButton;
    btnSetLanguageFrench: TButton;
    btnSetLanguageDanish: TButton;
    btnSetLanguageCzech: TButton;
    btnSetLanguageFinnish: TButton;
    btnSetLanguagePortuguese: TButton;
    btnSetLanguageTChinese: TButton;
    lblSetLanguageDescription: TLabel;

    procedure btnSetLanguage(Sender: TObject);
    procedure btnSetLanguageMouseEnter(Sender: TObject);
    procedure btnSetLanguageMouseLeave(Sender: TObject);
    procedure timer_getdataTimer(Sender: TObject);
  private
  public
    constructor Create(AOwner: TComponent; Rect: TRectangle); reintroduce; overload;
    procedure check;
  end;

implementation

{$R *.fmx}

constructor TframeDXVSetLanguage.Create(AOwner: TComponent; Rect: TRectangle);
begin
  inherited Create(AOwner, Rect);
  lblFrameTitle.Text := sDescription;
end;

procedure TframeDXVSetLanguage.timer_getdataTimer(Sender: TObject);
begin
  inherited;
//
end;

procedure TframeDXVSetLanguage.btnSetLanguageMouseEnter(Sender: TObject);
var
  msg: string;
begin
  inherited;

  msg := '';

  if Sender = btnSetLanguageNone then
    msg := sNoneMsg;

  if Sender = btnSetLanguageGerman then
    msg := sGermanMsg;

  if Sender = btnSetLanguageItalian then
    msg := sItalianMsg;

  if Sender = btnSetLanguageDutch then
    msg := sDutchMsg;

  if Sender = btnSetLanguageEnglish then
    msg := sEnglishMsg;

  if Sender = btnSetLanguageSpanish then
    msg := sSpanishMsg;

  if Sender = btnSetLanguageJapanese then
    msg := sJapaneseMsg;

  if Sender = btnSetLanguageSwedish then
    msg := sSwedishMsg;

  if Sender = btnSetLanguageSChinese then
    msg := sSChineseMsg;

  if Sender = btnSetLanguageFrench then
    msg := sFrenchMsg;

  if Sender = btnSetLanguageDanish then
    msg := sDanishMsg;

  if Sender = btnSetLanguageCzech then
    msg := sCzechMsg;

  if Sender = btnSetLanguageFinnish then
    msg := sFinnishMsg;

  if Sender = btnSetLanguagePortuguese then
    msg := sPortugueseMsg;

  if Sender = btnSetLanguageTChinese then
    msg := sTChineseMsg;

  lblSetLanguageDescription.Text := msg;
end;

procedure TframeDXVSetLanguage.btnSetLanguageMouseLeave(Sender: TObject);
begin
  inherited;
  lblSetLanguageDescription.Text := '';
end;

procedure TframeDXVSetLanguage.btnSetLanguage(Sender: TObject);
var
  cmd: String;
  r: boolean;
  pReadData: tstringlist;
  pSetLanguage: tSetLanguage;
begin
  inherited;
  cmd := '';

  if Sender = btnSetLanguageNone then
    cmd := sNone;

  if Sender = btnSetLanguageGerman then
    cmd := sGerman;

  if Sender = btnSetLanguageItalian then
    cmd := sItalian;

  if Sender = btnSetLanguageDutch then
    cmd := sDutch;

  if Sender = btnSetLanguageEnglish then
    cmd := sEnglish;

  if Sender = btnSetLanguageSpanish then
    cmd := sSpanish;

  if Sender = btnSetLanguageJapanese then
    cmd := sJapanese;

  if Sender = btnSetLanguageSwedish then
    cmd := sSwedish;

  if Sender = btnSetLanguageSChinese then
    cmd := sSChinese;

  if Sender = btnSetLanguageFrench then
    cmd := sFrench;

  if Sender = btnSetLanguageDanish then
    cmd := sDanish;

  if Sender = btnSetLanguageCzech then
    cmd := sCzech;

  if Sender = btnSetLanguageFinnish then
    cmd := sFinnish;

  if Sender = btnSetLanguagePortuguese then
    cmd := sPortuguese;

  if Sender = btnSetLanguageTChinese then
    cmd := sTChinese;

  if cmd <> '' then
  begin
    pReadData := tstringlist.Create;
    pReadData.Text := dm.com.SendCommandAndWaitForValue(sSetLanguage + ' ' + cmd, 6000, ^Z, 1);

    pSetLanguage := tSetLanguage.Create;

    r := pSetLanguage.ParseText(pReadData);

    if r then
    begin
      lblSetLanguageError.Text := '';
    end
    else
      lblSetLanguageError.Text := pSetLanguage.Error;

    freeandnil(pSetLanguage);
    freeandnil(pReadData);
  end;
  resetfocus;
end;

procedure TframeDXVSetLanguage.check;
begin
  //
end;

end.
