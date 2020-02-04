;--------------------------------
; ExecCmd plug-in Script Sample
; Takhir Bedertdinov


!define APP_NAME ExecCmd
!define DOS_APP consApp.exe

Name "${APP_NAME} Test"
OutFile "${APP_NAME}.exe"

!include "MUI.nsh"
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE "English"


; 'exec' command line
; ExecCmd::exec [/NOUNLOAD] [/ASYNC] [/TEST] [/TIMEOUT=TO_MS] CMD_LINE [STDIN_STRING]


Section "Dummy Section" SecDummy

    SetOutPath "$EXEDIR" ; for stdin.txt and stdout.txt file names without path

; sync call - not requires wait and nounload
; stdin from file and stdout to file, works on old OSs
    ExecCmd::exec '"$EXEDIR\consApp.exe" <stdin.txt >stdout.txt' ""


; stdin from string. More secure for passwords, but not works on Win98. >stdout is optional
#    ExecCmd::exec '"$EXEDIR\consApp.exe" >stdout.txt' "test_login$\r$\ntest_pwd$\r$\n"


; async launch, stdout to file
#  ExecCmd::exec /NOUNLOAD /ASYNC /TIMEOUT=2000 \
#    '"$EXEDIR\consApp.exe" >stdout.txt' "test_login$\r$\ntest_pwd$\r$\n"
#    Pop $0 ; thread handle for 'wait'
; can put some other code here for parallel execution
; it's time to check process exit code, $0 is thread handle we Pop'ed above
#    ExecCmd::wait $0


    Pop $0 ; return value - process exit code or error or STILL_ACTIVE (259).
; normal exit code is 5 for consApp.exe
    MessageBox MB_OK "Exit code $0"

SectionEnd

