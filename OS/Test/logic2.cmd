echo %title% Starting Logical Operations
SETLOCAL EnableDelayedExpansion

:SetString
set start_time[0]=0
set End_time[0]=19
set start_time[1]=04
set End_time[1]=07
set start_time[2]=07
set End_time[2]=11
set start_time[3]=11
set End_time[3]=18
set start_time[4]=18
set End_time[4]=19
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
REM WAIT & EXECUTE TIME LOGICAL
echo 0 sectors
pause>nul
for /l %%a in (0,1,4) do (
	if !start_time[%%a]! geq !end_time[%%a]! (
		set /a wait_time[%%a]=start_time[%%a]-end_time[%%a]
	) else (
		set /a wait_time[%%a]=!end_time[%%a]!-!start_time[%%a]!
	)
)

echo wt0 = %wait_time[0]%
echo 1 sectors
pause>Nul
REM NORMALIZED LOGICAL
for /l %%a in (0,1,4) do (
	echo %%a
	if !start_time[%%a]! geq !wait_time[%%a]! (
		set /a normal[%%a]=start_time[%%a]/wait_time[%%a]
	) else (
		set /a normal[%%a]=wait_time[%%a]/start_time[%%a]
	) 
)
for /l %%a in (0,1,4) do (
	echo.
	echo P%%a Start^/End^/Wait^/Normal : !start_time[%%a]!^/!end_time[%%a]!^/!wait_time[%%a]!^/!normal[%%a]!
)
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
