REM FCFS �˰���
REM ���μ������� ���� �ð��� �����ϴ� Execution ������ �Է� �޴� Settings ���̺�
set prth=%cd%\Modules\Process
if exist "%cd%\sortdata.txt" (
	del /q "%cd%\sortdata.txt" 
)

:Settings
mode con cols=73 lines=18
echo %title% �� ���μ����� �۾� �ð��� �Է����ּ���. [ex^) P1 P2 P3 P4]
echo %title% ex^) 3 4 7 1
set /p Execution=^>^> 
for /f "tokens=1-4 delims= " %%a in ("%Execution%") do (
	set TS_P1=%%a
	set TS_P2=%%b
	set TS_P3=%%c
	set TS_P4=%%d
)
echo P2^, %TS_P2% > %cd%\sort.csv
for /l %%a in (3,1,4) do (
	echo P%%a^, !TS_P%%a! >> %cd%\sort.csv
)
for /l %%a in (1,1,4) do (
	if /i "TS_P%%a" equ "" (
		echo %title% P%%a Execution �� �����Դϴ�.
		goto Settings
	)
)
goto Settings2


:Settings2
mode con cols=73 lines=20
echo %title% P1 ���μ����� ������ P2, P3, P4 �� ���� �ð��� �Է����ּ���. [ex^) P2 P3 P4]
echo %title% ex^) 2 5 9
set /p arr_input=^>^> 
for /f "tokens=1-3 delims= " %%a in ("%arr_input%") do (
	set arr_time[1]=0
	set arr_time[2]=%%a
	set arr_time[3]=%%b
	set arr_time[4]=%%c
)
for /l %%a in (2,1,4) do (
	if /i "arr_time[%%a]" equ "" (
		echo %title% P%%a ���� �ð��� �����Դϴ�.
		goto Settings2
	)
)
goto Execute


REM �켱������ ���μ����� �����Ű�� ���̺�
:Execute
Powershell.exe -noprofile -executionpolicy bypass -file "%cd%\Modules\sort.ps1"
if not exist "%cd%\sortdata.txt" (
	goto Execute
)
call "%cd%\Modules\time.lnk"
cls
set start_time[0]=%time:~6,2%
call %prth%\P1.cmd
for /f "skip=3 tokens=1-3 delims= " %%a in (%cd%\sortdata.txt) do (
	call %prth%\%%a.cmd
)
set end_time[0]=%time:~6,2%
goto BACK

:BACK