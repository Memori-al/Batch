@echo off 
SETLOCAL EnableDelayedExpansion
goto check
:Split
echo P1^, TS_P1 > %cd%\sort.csv
for /l %%a in (2,1,4) do (
	echo P%%a^, TS_P%%a >> %cd%\sort.csv
)

:check
for /f "skip=3 tokens=1-3 delims= " %%a in (%cd%\sortdata.txt) do (
	echo %%a Execution
)


REM P1 4 1
REM P2 15 3
REM P3 9 2
REM P4 16 4