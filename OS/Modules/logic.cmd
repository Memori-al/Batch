REM OS 프로그램의 핵심 모듈
echo %title% Starting Logical Operations

:SetString
for /l %%a in (0,1,4) do (
	if "!start_time[%%a]:~0,1!" equ "0" ( 
		set start_time[%%a]=!start_time[%%a]:~1,9!
	)
	if "!end_time[%%a]:~0,1!" equ "0" ( 
		set end_time[%%a]=!end_time[%%a]:~1,9!
	)
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
REM wait_time[i] = 대기시간
REM end_time[i] = 종료시간


:FCFS_Logic
REM Wait Time Logical
for /l %%a in (1,1,4) do (
	if !start_time[%%a]! geq !arr_time[%%a]! (
		set /a wait_time[%%a]=!start_time[%%a]!-!arr_time[%%a]!
	) else (
		set /a wait_time[%%a]=!arr_time[%%a]!-!start_time[%%a]!
	)
)

REM Execution Time Logical
for /l %%a in (1,1,4) do (
	if !start_time[%%a]! geq !end_time[%%a]! (
		set /a exec_time[%%a]=!start_time[%%a]!-!end_time[%%a]!
	) else (
		set /a exec_time[%%a]=!end_time[%%a]!-!start_time[%%a]!
	)
)

REM Turnarround Time Logical
for /l %%a in (1,1,4) do (
	if !exec_time[%%a]! geq !wait_time[%%a]! (
		set /a turn_time[%%a]=!exec_time[%%a]!+!wait_time[%%a]!
	) else (
		set /a turn_time[%%a]=!wait_time[%%a]!+!exec_time[%%a]!
	)
)

REM Normalized Logical
for /l %%a in (1,1,4) do (
	if !turn_time[%%a]! geq !exec_time[%%a]! (
		set /a normal[%%a]=turn_time[%%a]/exec_time[%%a]
	) else (
		set /a normal[%%a]=exec_time[%%a]/turn_time[%%a]
	) 
)
set /a awt=!wait_time[0]!+!wait_time[1]!+!wait_time[2]!+!wait_time[3]!+!wait_time[4]!
if !awt! lss 4 (
	set awt=0
)  else (
	set /a awt=!awt!/4
)
goto Paint

:SJF_Logic
REM Wait Time Logical
for /l %%a in (1,1,4) do (
	if !start_time[%%a]! geq !arr_time[%%a]! (
		set /a wait_time[%%a]=!start_time[%%a]!-!arr_time[%%a]!
	) else (
		set /a wait_time[%%a]=!arr_time[%%a]!-!start_time[%%a]!
	)
)

REM Execution Time Logical
for /l %%a in (1,1,4) do (
	if !start_time[%%a]! geq !end_time[%%a]! (
		set /a exec_time[%%a]=!start_time[%%a]!-!end_time[%%a]!
	) else (
		set /a exec_time[%%a]=!end_time[%%a]!-!start_time[%%a]!
	)
)

REM Turnarround Time Logical
for /l %%a in (1,1,4) do (
	if !exec_time[%%a]! geq !wait_time[%%a]! (
		set /a turn_time[%%a]=!exec_time[%%a]!+!wait_time[%%a]!
	) else (
		set /a turn_time[%%a]=!wait_time[%%a]!+!exec_time[%%a]!
	)
)
set /a awt=!wait_time[0]!+!wait_time[1]!+!wait_time[2]!+!wait_time[3]!+!wait_time[4]!
if !awt! lss 4 (
	set awt=0
)  else (
	set /a awt=!awt!/4
)
goto Paint


:Paint
call %cd%\Modules\paint.cmd
goto Result

:Result
cls
if !awt! leq 0 (
	type %cd%\data.txt
) else (
	type %cd%\data.txt
)
goto BACK

:BACK
REM OS.cmd 로 돌아가기
