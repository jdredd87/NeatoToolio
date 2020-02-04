Name "MotorMate Upgrade"
OutFile "c:\motorupgrade.exe"
InstallDir  "C:\Program Files\Car-Part\Mapmate"

RequestExecutionLevel user

Function .onInit
    SetSilent silent
FunctionEnd

Section
SetOutPath $INSTDIR

CreateDirectory $INSTDIR  
 file "C:\Documents and Settings\CPStevenC\Desktop\motor\motortool.exe"
 ExecShell "open" "$INSTDIR\motortool.exe"


SectionEnd

