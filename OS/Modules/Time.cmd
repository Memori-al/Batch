@echo off
set hours=%time:~0,2%
set min=%time:~3,2%
set sec=%time:~6,2%
if %TCALL% equ 0 ( goto Change )
if %TCALL% equ 1 ( goto Reset )

:Change
time %hours%:%min%:00.00 >null
echo %title% Time Second %sec%s ^-^> 00s
set TCALL=1
goto BACK

:Reset
net start w32time >null
w32tm /resync >null
w32tm /config /manualpeerlist:"time.bora.net,0x9" /syncfromflags:MANUAL >null
net stop w32time >null
net start w32time >null
w32tm /resync >null
echo %title% Time Reset.
set TCALL=0
goto BACK

:BACK