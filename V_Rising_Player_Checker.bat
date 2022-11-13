@echo off
set rc=0
mode con cols=87 lines=15
title :: V Rising Server User List :: %username%
echo [Console] BattleMetrics API 를 통해 서버 정보를 불러와 콘솔에 전시하는 프로그램입니다.
echo [Console] BattleMetrics 에 올라와있는 서버의 ID 8자리를 입력해주세요.
echo [Console] 예^) https://www.battlemetrics.com/servers/vrising/"16528067" ^<^< 8자리 숫자

if exist "%cd%\serverid.txt" (
	for /f %%a in (%cd%\serverid.txt) do set ID=%%a>nul
	del /q %cd%\%id%.txt >nul
	mode con cols=52 lines=5
	goto Loop
)

:Settings
set /p ID=ID^>^> 
if /i "%ID%" equ "" (
	echo [Console] 공백은 입력될 수 없습니다.
	pause>Nul
	goto Settings
)
if /i "%ID:~8,1%" neq "" (
	echo [Console] 숫자 8자리를 초과했습니다.
	pause>Nul
	goto Settings
)
echo [Console] 입력하신 [%ID%] 가 맞습니까?
set /p yorn=Y^/N^>^> 
if /i "%yorn%" equ "y" (
	echo [Console] 설정이 완료되었습니다.
	echo [Console] 앞으로 프로그램 시작 시 [%ID%] 주소로 연결합니다.
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
echo [Console] 현재 접속자 수 %play%명
echo [Console] API 응답 카운터 [%rc%]
timeout /T 10 >nul
goto Loop