echo %title% P3 Process Execution
REM FCFS ���� ��ӹ��� TS_P3 ���� ó����.
:Processing
set start_time[3]=%time:~6,2%
Timeout /T %TS_P3% >nul
set end_time[3]=%time:~6,2%
goto EOF

REM �۾� ���� �� ����
:EOF
