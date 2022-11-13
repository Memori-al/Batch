echo %title% P2 Process Execution
REM FCFS 에서 상속받은 TS_P2 값을 처리함.
:Processing
set start_time[2]=%time:~6,2%
Timeout /T %TS_P2% >nul
set end_time[2]=%time:~6,2%
goto EOF

REM 작업 수행 후 종료
:EOF
