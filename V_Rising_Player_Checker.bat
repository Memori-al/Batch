@echo off
set rc=0
mode con cols=87 lines=15
title :: V Rising Server User List :: %username%
echo [Console] BattleMetrics API �� ���� ���� ������ �ҷ��� �ֿܼ� �����ϴ� ���α׷��Դϴ�.
echo [Console] BattleMetrics �� �ö���ִ� ������ ID 8�ڸ��� �Է����ּ���.
echo [Console] ��^) https://www.battlemetrics.com/servers/vrising/"16528067" ^<^< 8�ڸ� ����

if exist "%cd%\serverid.txt" (
	for /f %%a in (%cd%\serverid.txt) do set ID=%%a>nul
	del /q %cd%\%id%.txt >nul
	mode con cols=52 lines=5
	goto Loop
)

:Settings
set /p ID=ID^>^> 
if /i "%ID%" equ "" (
	echo [Console] ������ �Էµ� �� �����ϴ�.
	pause>Nul
	goto Settings
)
if /i "%ID:~8,1%" neq "" (
	echo [Console] ���� 8�ڸ��� �ʰ��߽��ϴ�.
	pause>Nul
	goto Settings
)
echo [Console] �Է��Ͻ� [%ID%] �� �½��ϱ�?
set /p yorn=Y^/N^>^> 
if /i "%yorn%" equ "y" (
	echo [Console] ������ �Ϸ�Ǿ����ϴ�.
	echo [Console] ������ ���α׷� ���� �� [%ID%] �ּҷ� �����մϴ�.
	echo %ID%>%CD%\serverid.txt
	timeout /t 3 >nul
	mode con cols=52 lines=5
	goto Loop
)
goto Settings


:Loop
cls
set /a rc=rc+1>nul
echo [Console] BattleMetrics API Responds
curl -n https://api.battlemetrics.com/servers/%ID% -o %ID%.txt -s >nul
cls
for /f "tokens=1-11 delims=," %%a in (%ID%.txt) do (
	set non_split=%%h
)
for /f "tokens=1-2 delims=^:" %%a in ("%non_split%") do (
	set play=%%b
)
echo [Console] ���� ������ �� %play%��
echo [Console] API ���� ī���� [%rc%]
timeout /T 10 >nul
goto Loop