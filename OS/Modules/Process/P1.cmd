echo %title% P1 Process Execution
REM FCFS ���� ��ӹ��� TS_P1 ���� ó����.
:Processing
set start_time[1]=%time:~6,2%
Timeout /T %TS_P1% >nul
set end_time[1]=%time:~6,2%
goto EOF

REM �۾� ���� �� ����
:EOF
