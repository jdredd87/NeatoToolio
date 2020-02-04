Name "MotorMate Upgrade"
OutFile "c:\motorupgrade.exe"

InstallDir  "C:\Program Files\Car-Part\Mapmate"


Section "" ;No components page, name is not important

  SetOutPath $installdir
  

setsilent silent
 file "C:\Documents and Settings\CPStevenC\Desktop\motor\motortool.exe"
  
SectionEnd 
