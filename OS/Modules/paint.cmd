set ex=■
set count=0
set /a total=!awt!-1

REM Paint Logic
goto Print
:paint_logic
if %total% leq 0 ( goto Print )
set /a count=!count!+1
set ex=!ex!■
if %count% equ %total% ( goto Print )
goto paint_logic

:Print
mode con cols=123 lines=15
REM P1~P4 Data Print
echo 	┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓> %cd%\data.txt
echo 	┃    Process	Arrival	  Burst	     Wait	Turnarround	Normalized	Start Time	End Time ┃>> %cd%\data.txt
echo 	┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛>> %cd%\data.txt
for /l %%a in (1,1,4) do (
	echo 	       P%%a	    !arr_time[%%a]!	    !exec_time[%%a]!	      !wait_time[%%a]!	    	    !turn_time[%%a]!	    	   !normal[%%a]!	    	   !start_time[%%a]!	    	   !end_time[%%a]!>> %cd%\data.txt
	echo 	 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━>> %cd%\data.txt
)
echo 								  The AWT(Average Wait Time) is !awt! seconds.>>%cd%\data.txt
goto BACK

:BACK
REM Logic.cmd 로 돌아가기
