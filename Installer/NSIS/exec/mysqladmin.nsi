;--------------------------------
; execcmd Script Sample
; Takhir Bedertdinov


;--------------------------------
; Base names definition

!define APP_NAME mysql


;--------------------------------
; General Attributes

Name "${APP_NAME} Test"
OutFile "${APP_NAME}.exe"


;--------------------------------
; Interface Settings

  !include "MUI.nsh"
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_LANGUAGE "English"


;--------------------------------
; Installer Sections

Section "Dummy Section" SecDummy

  SetOutPath "$EXEDIR"
  ReadEnvStr $0 "ComSpec"
  ExecCmd::exec /TIMEOUT=10000 '"mysqladmin.exe -p -uroot reload" >mysql.log' "my_password$\r$\n"
  Pop $0 # return value - process exit code or error or still running.
  MessageBox MB_OK "Exit code $0"

SectionEnd

