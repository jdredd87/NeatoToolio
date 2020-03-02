Name "NeatoToolio"
RequestExecutionLevel admin
Setcompressor LZMA

function CheckSoftware
FindProcDLL::FindProc "NeatoToolio.EXE"
IntCmp $R0 1 0 notRunning
    MessageBox MB_OK|MB_ICONEXCLAMATION "NeatoToolio is currently running.$\r$\nPlease close it down first and try installing again." /SD IDOK
    quit
notRunning:
functionend

function un.onInit
FindProcDLL::FindProc "NeatoToolio.EXE"
IntCmp $R0 1 0 notRunning
    MessageBox MB_OK|MB_ICONEXCLAMATION "NeatoToolio is currently running.$\r$\nPlease close it down first and try uninstalling again." /SD IDOK
    quit
notRunning:
functionend

LoadLanguageFile "${NSISDIR}\Contrib\Language files\English.nlf"

OutFile "NeatoToolio_Install.exe"

InstallDir "$PROGRAMFILES\NeatoToolio"

InstallDirRegKey HKLM "Software\NeatoToolio" "Install_Dir"

LicenseData license.txt
LicenseForceSelection radiobuttons "accept" "decline"

Page license checksoftware
Page directory
Page instfiles

UninstPage uninstConfirm
UninstPage instfiles

Section "NeatoToolio (required)"

  SectionIn RO

  SetShellVarContext all
  StrCpy $0 $APPDATA
  CreateDirectory "$0\NeatoToolio"

  SetOutPath $INSTDIR

file "NeatoToolio.exe"
file "ssleay32.dll"
file "libeay32.dll"

SetOutPath "$0\NeatoToolio\\Languages"
file "..\Languages\*.lang"
  
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\App Paths\NeatoToolio.exe" "PATH" "$INSTDIR\"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\NeatoToolio" "DisplayName" "NeatoToolio"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\NeatoToolio" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\NeatoToolio" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\NeatoToolio" "NoRepair" 1
  WriteUninstaller "$INSTDIR\uninstall.exe"
  AccessControl::GrantOnFile "$0\NeatoToolio" "(BU)" "FullAccess"  
  AccessControl::GrantOnFile "$INSTDIR" "(BU)" "FullAccess"
SectionEnd

Section "Start Menu Shortcuts"
  CreateDirectory "$SMPROGRAMS\NeatoToolio"
  CreateShortCut "$SMPROGRAMS\NeatoToolio\Uninstall.lnk" "$INSTDIR\uninstall.exe" "" "$INSTDIR\uninstall.exe" 0
  CreateShortCut "$SMPROGRAMS\NeatoToolio\NeatoToolio.lnk" "$INSTDIR\NeatoToolio.exe" "" "$INSTDIR\NeatoToolio.exe" 0
SectionEnd

Section "Desktop Shortcut"
  CreateShortCut "$DESKTOP\NeatoToolio.lnk" "$INSTDIR\NeatoToolio.exe" "" "$INSTDIR\NeatoToolio.exe" 0
SectionEnd

Section "Uninstall"
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\App Paths\NeatoToolio.exe"
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\NeatoToolio"
  Delete $INSTDIR\NeatoToolio.exe
  Delete $INSTDIR\uninstall.exe
  Delete "$DESKTOP\NeatoToolio.lnk"
  Delete "$SMPROGRAMS\NeatoToolio\*.*"
  Delete "$PROGRAMFILES\NeatoToolio\*.*"
  RMDir "$INSTDIR"
  RMDir "$SMPROGRAMS\NeatoToolio"
  RMDir "$PROGRAMFILES\NeatoToolio" 
  RMDIR "$SMPROGRAMS\NeatoToolio"
  SetShellVarContext all
  StrCpy $0 $APPDATA
  Delete "$0\NeatoToolio\*.*"
  RMDir "$0\NeatoToolio"
  SetShellVarContext all
  Delete "$DESKTOP\NeatoToolio.lnk"
  Delete "$DESKTOP\NeatoToolio.lnk"
  Delete "$SMPROGRAMS\NeatoToolio\*.*"
  Delete "$PROGRAMFILES\NeatoToolio\*.*"
  RMDir "$INSTDIR"
  RMDir "$SMPROGRAMS\NeatoToolio"
  RMDir "$PROGRAMFILES\NeatoToolio" 
  RMDIR "$SMPROGRAMS\NeatoToolio"
SectionEnd
