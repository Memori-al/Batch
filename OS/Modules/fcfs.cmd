REM FCFS �˰���
REM ���μ������� ���� �ð��� �����ϴ� TimeSlice ������ �Է� �޴� Settings ���̺�
set prth=%cd%\Modules\Process

:Settings
mode con cols=73 lines=18
echo %title% �� ���μ����� �۾� �ð��� �Է����ּ���. [ex^) P1 P2 P3 P4]
echo %title% ex^) 3 4 7 1
set /p TimeSlice=^>^> 
for /f "tokens=1-4 delims= " %%a in ("%TimeSlice%") do (
	set TS_P1=%%a
	set TS_P2=%%b
	set TS_P3=%%c
	set TS_P4=%%d
)
for /l %%a in (1,1,4) do (
	if /i "TS_P%%a" equ "" (
		echo %title% P%%a TimeSlice �� �����Դϴ�.
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

REM ���������� ���μ����� �����Ű�� ���̺�
:Execute
rem end_time[i] == 0[Total], 1[P1], 2[P2], 3[P3], 4[P4]
rem start_time ������ ���� �� ����
call "%cd%\Modules\time.lnk"
cls
set start_time[0]=%time:~6,2%
call %prth%\P1.cmd
call %prth%\P2.cmd
call %prth%\P3.cmd
call %prth%\P4.cmd
set end_time[0]=%time:~6,2%
goto BACK

REM Execute �۾� ���� �� os.cmd �� ���ư��� ���̺�
:BACK