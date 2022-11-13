echo %title% Starting Logical Operations
SETLOCAL EnableDelayedExpansion
@echo off
:SetString
set at[0]=0
set turn_time[0]=0
set ex_time[0]=0
set normal[0]=0
set at[1]=0
set at[2]=5
set at[3]=8
set at[4]=10

set start_time[0]=00
set start_time[1]=00
set start_time[2]=15
set start_time[3]=23
set start_time[4]=25

set End_time[0]=30
set End_time[1]=15
set End_time[2]=23
set End_time[3]=25
set End_time[4]=30


set ar=fcfs
echo SetStrings
for /l %%a in (0,1,4) do (
	echo.
	echo P%%a Start^/End : !start_time[%%a]!^/!end_time[%%a]!
)

pause>nul
cls
for /l %%a in (0,1,4) do (
	if "!start_time[%%a]:~0,1!" equ "0" ( 
		set start_time[%%a]=!start_time[%%a]:~1,9!
	)
	if "!end_time[%%a]:~0,1!" equ "0" ( 
		set end_time[%%a]=!end_time[%%a]:~1,9!
	)
)
for /l %%a in (0,1,4) do (
	echo.
	echo P%%a Start^/End : !start_time[%%a]!^/!end_time[%%a]!
)
goto Match

:Match
if /i "%ar%" equ "fcfs" ( goto FCFS_Logic )
if /i "%ar%" equ "sjf" ( goto SJF_Logic )
if /i "%ar%" equ "rr" ( goto RR_Logic )
if /i "%ar%" equ "hrn" ( goto HRN_Logic )
echo %title% an abnormal approach!
pause>nul
exit

REM start_time[i], end_time[i]
REM start_time[i] = 수행시간
REM end_time[i] = 종료시간
REM Nomal[i] = 정규화
REM ^ 대기시간 = 왕복시간 - 수행시간
^ 소요시간 = 종료시간 - 도착시간
^ 정규화 = 수행시간 / 대기시간

:FCFS_Logic
cls
REM WAIT TIME LOGICAL
echo 0 sectors
set wait_time[0]=0
for /l %%a in (1,1,4) do (
	if !start_time[%%a]! geq !at[%%a]! (
		set /a wait_time[%%a]=start_time[%%a]-at[%%a]
	) else (
		set /a wait_time[%%a]=!at[%%a]!-!start_time[%%a]!
	)
)
echo 1 sectors
REM EXECUTE TIME LOGICAL
for /l %%a in (0,1,4) do (
	if !start_time[%%a]! geq !end_time[%%a]! (
		set /a ex_time[%%a]=start_time[%%a]-end_time[%%a]
	) else (
		set /a ex_time[%%a]=!end_time[%%a]!-!start_time[%%a]!
	)
)

REM TURNARROUND TIME LOGICAL
for /l %%a in (1,1,4) do (
	if !ex_time[%%a]! geq !wait_time[%%a]! (
		set /a turn_time[%%a]=!ex_time[%%a]!+!wait_time[%%a]!
	) else (
		set /a turn_time[%%a]=!wait_time[%%a]!+!ex_time[%%a]!
	)
)

REM NORMALIZED LOGICAL
for /l %%a in (1,1,4) do (
	echo %%a
	if !turn_time[%%a]! geq !ex_time[%%a]! (
		set /a normal[%%a]=turn_time[%%a]/ex_time[%%a]
	) else (
		set /a normal[%%a]=ex_time[%%a]/turn_time[%%a]
	) 
)

for /l %%a in (0,1,4) do (
	echo.
	echo P%%a Arrived^/Execute^/Wait^/Turn^/Normal^/Start : !at[%%a]!^/!ex_time[%%a]!^/!wait_time[%%a]!^/!turn_time[%%a]!^/!normal[%%a]!^/!start_time[%%a]!
)
set /a awt=!wait_time[1]!+!wait_time[2]!+!wait_time[3]!+!wait_time[4]!
set /a awt=!awt!/4
echo Average Waiting Time ^= %awt% s
echo 2 sectors
pause>nul
goto Paint

:Paint
call %cd%\Modules\paint.cmd
echo 3 sectors
pause>nul
goto Result

:Result
echo TOTAL TIME = [%ex%] %wait_time[0]%s
echo 4 sectors
pause>nul
