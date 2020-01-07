@echo off
cls
echo.*****************************
echo.* Checkmate Source Clean Up * 
echo.*****************************
echo.
Echo Removing files not needed for build. Usually left over DCU and temp files.
echo.
del *.map /s
del *.dcu /s
del *.~* /s
del *.ddp /s
del *.sfb /s
del *.ddp /s
del *.~dfm /s
del *.stat /s

echo.
echo Clearing read only attributes from all files and sub folders. 
echo.This will remove any read only files.
echo.

attrib *.* -r -a -s -h /s
attrib updates\*.* -r -a -s -h /s

echo.
echo.Checking for CMW.DOF
echo.

IF EXIST "CMW.DOF"  GOTO FIXDOF

echo.CMW.DOF file does not exist. Skipping repair.
Goto END

:FIXDOF

echo.Reparing CMW.DOF file ...
echo.

IF EXIST "CMW2.DOF" DEL CMW2.DOF

rem type cmw.dof | findstr /V RunParams= >cmw2.dof

type cmw.dof | repl "RunParams=" "RunParams=-cmw-debugger \nOldRunParams=" IX > cmw2.dof
type cmw2.dof | repl "UnsafeType=1" "UnsafeType=0" I > cmw2.dof
type cmw2.dof | repl "UnsafeCode=1" "UnsafeCode=0" I > cmw2.dof
type cmw2.dof | repl "UnsafeCast=1" "UnsafeCast=0" I > cmw2.dof

echo.

DEL CMW.DOF
RENAME CMW2.DOF CMW.DOF

echo.CMW.DOF Repaired!
echo.

GOTO END

:END

echo.***************************************
echo.* Checkmate Source Clean Up COMPLETED *
echo.***************************************

echo.

Pause
