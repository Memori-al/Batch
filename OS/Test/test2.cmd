@echo off
SETLOCAL EnableDelayedExpansion
:ABC
for /l %%a in (1,1,4) do (
	set stime[%%a]=60
	set etime[%%a]=70
)
for /l %%a in (1,1,4) do (
	if "stime[%%a]" geq "etime[%%a]" (
		set /a wtime[%%a]=stime[%%a]-etime[%%a]
	) else (
		set /a wtime[%%a]=etime[%%a]-stime[%%a]
	)
)
goto AB

:AB
for /l %%c in (1,1,4) do (
	echo P%%c : !wtime[%%c]!
)
echo %stime[1]%
