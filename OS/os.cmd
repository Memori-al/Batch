@echo off
SETLOCAL EnableDelayedExpansion
title �ü�� �˰��� �⸻���� :: 201968006 �̰���
set TCALL=0
set title=[Console]

rem 	���(FCFS, SJF, RR, HRN)
rem	P1, P2, P3, P4 �� ����
rem      	OS.CMD

:Check
call "%cd%\Modules\Verified.cmd"
goto Main

:Main
mode con cols=73 lines=12
cls
type %cd%\menu.dat
set /p ch=Select^>^> 
if "%ch%" equ "1" ( goto FCFS )
if "%ch%" equ "2" ( goto SJF )
if "%ch%" equ "3" ( goto RR )
if "%ch%" equ "4" ( goto HRN )
echo %title% %ch% ���� �������� �ʽ��ϴ�.
Timeout /T 3 >nul
goto Main 

:FCFS
set ar=fcfs
call "%cd%\Modules\fcfs.cmd"
goto logic

:SJF
set ar=sjf
call "%cd%\Modules\sjf.cmd"
goto logic
set stime = %time:~6,2%

:RR
set ar=rr
call "%cd%\Modules\rr.cmd"
goto logic

:HRN
set ar=hrn
call "%cd%\Modules\hrn.cmd"
goto logic

:Logic
call "%cd%\Modules\logic.cmd"
echo %title% ���� �Ϸ�
pause>nul
goto main
