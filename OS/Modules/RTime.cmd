@echo off
:Reset
rem net start w32time >null
w32tm /resync >null
w32tm /config /manualpeerlist:"time.bora.net,0x9" /syncfromflags:MANUAL >null
net stop w32time >null
net start w32time >null
w32tm /resync >null
echo %title% Time Reset.
goto BACK

:BACK