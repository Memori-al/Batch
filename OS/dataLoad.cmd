@echo off
start
:Loop
Title Data.txt
cls
color 04
echo.
type %cd%\data.txt
timeout /T 2 >Nul
goto loop