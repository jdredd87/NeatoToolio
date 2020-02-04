;--------------------------------
; execDos Script Sample
; Takhir Bedertdinov


;--------------------------------
; Base names definition

!define APP_NAME GNUPG


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
; Use /TEST option to see console
  ExecCmd::exec /TIMEOUT=10000 '"gpg.exe --gen-key" >gpg.log'"1$\r$\n1024$\r$\n0$\r$\ny$\r$\ngpguser$\r$\ngpguser@gpguser$\r$\nmycomment$\r$\no$\r$\nmypassphrase$\r$\nmypassphrase$\r$\n"
  Pop $0 # return value - process exit code or error or still running.
  MessageBox MB_OK "Exit code $0"

SectionEnd

