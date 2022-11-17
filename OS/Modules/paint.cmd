:Print
mode con cols=123 lines=15
REM P1~P4 Data Print
if /i "%ar%" equ "fcfs" ( goto fcfs_paint )
if /i "%ar%" equ "sjf" ( goto sjf_paint )

:fcfs_paint
echo 	┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓> %cd%\data.txt
echo 	┃    Process	Arrival	  Burst	     Wait	Turnarround	Normalized	Start Time	End Time ┃>> %cd%\data.txt
echo 	┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛>> %cd%\data.txt
for /l %%a in (1,1,4) do (
	set /a length[%%a]=!arr_time[%%a]!+!exec_time[%%a]!+!wait_time[%%a]!+!turn_time[%%a]!+!normal[%%a]!+!start_time[%%a]!+!end_time[%%a]!
	set /a length[%%a]=!length[%%a]!/7
	echo P%%a Length ^= !length[%%a]!

	if !length[%%a]! leq 9 (
		echo 	       P%%a	    !arr_time[%%a]!	    !exec_time[%%a]!	      !wait_time[%%a]!	         !turn_time[%%a]!	    	   !normal[%%a]!	    	   !start_time[%%a]!	    	   !end_time[%%a]! >> %cd%\data.txt
	)
	if !length[%%a]! geq 10 (
		echo 	       P%%a	    !arr_time[%%a]!	    !exec_time[%%a]!	      !wait_time[%%a]!	 !turn_time[%%a]!	    	   !normal[%%a]!	    	   !start_time[%%a]!	    	   !end_time[%%a]! >> %cd%\data.txt
	)
	echo 	 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━>> %cd%\data.txt
)
echo 								  	The AWT(Average Wait Time) is !awt! seconds. >> %cd%\data.txt
goto BACK

:sjf_paint
echo 	┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓ > %cd%\data.txt
echo 	┃    Process	Arrival	  Burst	     Wait	Turnarround	Start Time	End Time ┃  >> %cd%\data.txt
echo 	┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛  >> %cd%\data.txt
for /l %%a in (1,1,4) do (
	set /a length[%%a]=!arr_time[%%a]!+!exec_time[%%a]!+!wait_time[%%a]!+!turn_time[%%a]!+!start_time[%%a]!+!end_time[%%a]!
	set /a length[%%a]=!length[%%a]!/6
	echo P%%a Length ^= !length[%%a]!

	if !length[%%a]! leq 6 (
		echo 	       P%%a	    !arr_time[%%a]!	    !exec_time[%%a]!	      !wait_time[%%a]!	         !turn_time[%%a]!	    	   !start_time[%%a]!	    	   !end_time[%%a]! >> %cd%\data.txt
	)
	if !length[%%a]! geq 7 (
		echo 	       P%%a	    !arr_time[%%a]!	    !exec_time[%%a]!	      !wait_time[%%a]!	 !turn_time[%%a]!	    	   !start_time[%%a]!	    	   !end_time[%%a]! >> %cd%\data.txt
	)
	echo 	 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  >> %cd%\data.txt
)
echo 								  	The AWT(Average Wait Time) is !awt! seconds. >> %cd%\data.txt
goto BACK


:BACK
REM Logic.cmd 로 돌아가기
