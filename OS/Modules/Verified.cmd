:Verified
mode con cols=87 lines=13
if not exist "c:\OS\Verified.info" (
	goto Setup
)
for /f %%a in (c:\OS\Verified.info) do (
	if not exist "%cd%%%a" (
		echo %title% "%cd%%%a"	Verified	[X]
		set verified=0
	) else (
		echo %title% "%cd%%%a"	Verified	[O]
		set verified=1
	)
)
if %verified% equ 0 (
	echo %title% Please re-unpacking ZIP file
	Pause>nul
	exit
) else (
	echo %title% All Modules Verified.
)
timeout /T 3 >nul
goto EOF

:Setup
md "c:\OS\"
echo \Modules\fcfs.cmd > c:\OS\Verified.info
echo \Modules\rr.cmd >> c:\OS\Verified.info
echo \Modules\sjf.cmd >> c:\OS\Verified.info
echo \Modules\hrn.cmd >> c:\OS\Verified.info
echo \Modules\logic.cmd >> c:\OS\Verified.info
echo \Modules\Process\P1.cmd >> c:\OS\Verified.info
echo \Modules\Process\P2.cmd >> c:\OS\Verified.info
echo \Modules\Process\P3.cmd >> c:\OS\Verified.info
echo \Modules\Process\P4.cmd >> c:\OS\Verified.info
goto Verified

:EOF