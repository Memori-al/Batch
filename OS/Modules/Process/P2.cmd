echo %title% P2 Process Execution
REM FCFS ���� ��ӹ��� TS_P2 ���� ó����.
:Processing
set start_time[2]=%time:~6,2%
Timeout /T %TS_P2% >nul
set end_time[2]=%time:~6,2%
goto EOF

REM �۾� ���� �� ����
:EOF
