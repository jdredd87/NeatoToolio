@echo off
cls
echo Building NeatoToolio installer.....
echo.
echo.
del neatotoolio.exe
copy ..\win32\debug\neatotoolio.exe
"c:\Program Files (x86)\upx\upx.exe" neatotoolio.exe
NSIS\makensis.exe NeatoToolio_Install.nsi
pause
