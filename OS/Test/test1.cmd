@echo off
SETLOCAL EnableDelayedExpansion
cls
:AB
set start_time[0]=04
set End_time[0]=19
set start_time[1]=04
set End_time[1]=07
set start_time[2]=07
set End_time[2]=11
set start_time[3]=11
set End_time[3]=18
set start_time[4]=18
set End_time[4]=19

for /l %%a in (0,1,4) do (
	if "!start_time[%%a]:~0,1!" equ "0" ( 
		set start_time[%%a]=!start_time[%%a]:~1,9!
	)
	if "!end_time[%%a]:~0,1!" equ "0" ( 
		set end_time[%%a]=!end_time[%%a]:~1,9!
	)
)

for /l %%a in (0,1,4) do (
	if !start_time[%%a]! geq !end_time[%%a]! (
		set /a wait_time[%%a]=start_time[%%a]-end_time[%%a]
	) else (
		set /a wait_time[%%a]=end_time[%%a]-start_time[%%a]
	)
)

for /l %%a in (0,1,4) do (
	if !start_time[%%a]! geq !wait_time[%%a]! (
		set /a normal[%%a]=start_time[%%a]/wait_time[%%a]
	) else (
		set /a normal[%%a]=wait_time[%%a]/start_time[%%a]
	) 
)
echo.
echo Total Start^/End : !start_time[0]!^/!end_time[0]!
echo Total Wait[Execute] : !wait_time[0]!
echo Total Normal : !normal[0]!
for /l %%a in (1,1,4) do (
	echo.
	echo P%%a Start^/End : !start_time[%%a]!^/!end_time[%%a]!
	echo P%%a Wait[Execute] : !wait_time[%%a]!
	echo P%%a Normal : !normal[%%a]!
)