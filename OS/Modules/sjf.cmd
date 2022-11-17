REM SJF 알고리즘
REM 프로세스들의 수행 시간을 결정하는 Execution 변수를 입력 받는 Settings 레이블
set prth=%cd%\Modules\Process
if exist "%cd%\sortdata.txt" (
	del /q "%cd%\sortdata.txt" 
)

:Settings
mode con cols=73 lines=18
echo %title% 각 프로세스의 작업 시간을 입력해주세요. [ex^) P1 P2 P3 P4]
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
		echo %title% P%%a Execution 가 공백입니다.
		goto Settings
	)
)
goto Settings2


:Settings2
mode con cols=73 lines=20
echo %title% P1 프로세스를 제외한 P2, P3, P4 의 도착 시간을 입력해주세요. [ex^) P2 P3 P4]
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
		echo %title% P%%a 도착 시간이 공백입니다.
		goto Settings2
	)
)
goto Execute


REM 우선순위로 프로세스를 실행시키는 레이블
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
call "%cd%\Modules\rtime.lnk"
goto BACK

:BACK
