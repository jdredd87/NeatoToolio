; WinVer.nsh was added in the same release that RequestExecutionLevel so check
; if ___WINVER__NSH___ is defined to determine if RequestExecutionLevel is
; available.
!include /NONFATAL WinVer.nsh
!ifdef ___WINVER__NSH___
  RequestExecutionLevel user
!else
  !warning "Installer will be created without Vista compatibility.$\n            \
            Upgrade your NSIS installation to at least version 2.21 to resolve."
!endif

## Basic stuff here
Name "AppAssocReg Example"
OutFile "AppAssocReg-Example.exe"
!addplugindir ../../Plugins/

ShowInstDetails show

Page instfiles

Section "-dummy"

!ifdef ___WINVER__NSH___
  ${If} ${AtLeastWinVista}
!endif
    SetDetailsPrint both
    ; Add dummy registry keys and name value pairs
    DetailPrint "Adding test registry keys"

    StrCpy $1 "StartMenuInternet"
    StrCpy $2 "startmenu"
    StrCpy $3 "user"
    AppAssocReg::QueryCurrentDefault "$1" "$2" "$3"
    Pop $R9
    DetailPrint "QueryCurrentDefault $1 $3 = $R9"

    StrCpy $1 "StartMenuInternet"
    StrCpy $2 "startmenu"
    StrCpy $3 "user"
    AppAssocReg::QueryCurrentDefault "$1" "$2" "$3"
    Pop $R9
    DetailPrint "QueryCurrentDefault $1 $3 = $R9"

    StrCpy $1 "http"
    StrCpy $2 "protocol"
    StrCpy $3 "effective"
    AppAssocReg::QueryCurrentDefault "$1" "$2" "$3"
    Pop $R9
    DetailPrint "QueryCurrentDefault $1 $3 = $R9"

    StrCpy $0 "Internet Explorer"
    StrCpy $3 "user"
    AppAssocReg::QueryAppIsDefaultAll "$0" "$3"
    Pop $R9
    DetailPrint "QueryAppIsDefault $0 = $R9"

    StrCpy $0 "Internet Explorer"
    StrCpy $3 "user"
    AppAssocReg::QueryAppIsDefaultAll "$0" "$3"
    Pop $R9
    DetailPrint "QueryAppIsDefaultAll $0 = $R9"

    StrCpy $0 "Internet Explorer"
    StrCpy $1 "http"
    StrCpy $2 "protocol"
    StrCpy $3 "effective"
    AppAssocReg::QueryAppIsDefault "$0" "$1" "$2" "$3"
    Pop $R9
    DetailPrint "QueryAppIsDefault $0 $1 $3 = $R9"

    # Commented out to prevent accidentally changing associations for the unwary
;    StrCpy $0 "Internet Explorer"
;    AppAssocReg::SetAppAsDefaultAll "$0"
;    Pop $R9
;    DetailPrint "SetAppAsDefaultAll $0 = $R9"

;    StrCpy $0 "Internet Explorer"
;    StrCpy $1 "http"
;    StrCpy $2 "protocol"
;    AppAssocReg::SetAppAsDefault "$0" "$1" "$2"
;    Pop $R9
;    DetailPrint "SetAppAsDefault $0 $1 = $R9"

;    StrCpy $0 "Internet Explorer"
;    StrCpy $1 "StartMenuInternet"
;    StrCpy $2 "startmenu"
;    AppAssocReg::SetAppAsDefault "$0" "$1" "$2"
;    Pop $R9
;    DetailPrint "SetAppAsDefault $0 $1 = $R9"

;    AppAssocReg::ClearUserAssociations
;    Pop $R9
;    DetailPrint "ClearUserAssociations = $R9"
!ifdef ___WINVER__NSH___
  ${Else}
    DetailPrint "This plugin only works on Windows Vista or greater"
  ${EndIf}
!endif

SectionEnd
