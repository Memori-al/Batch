echo %title% P4 Process Execution
REM FCFS ���� ��ӹ��� TS_P4 ���� ó����.
:Processing
set start_time[4]=%time:~6,2%
Timeout /T %TS_P4% >nul
set end_time[4]=%time:~6,2%
goto EOF

REM �۾� ���� �� ����
:EOF
