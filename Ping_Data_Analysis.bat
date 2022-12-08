@echo off
rem ================================================================================== ^
^ [핑 분석 도구]
^ 핑 분석 도구는 데이터 패킷인 Ping 을 지정한 호스트에 전송하여 반환되는 데이터를 분석해
^ 사용자의 네트워크 환경에 대한 보고서를 만드는 프로그램입니다.
^ 평균/최대 편차 대조 결과 패킷 손실률 1%, 왕복 시간 100ms
^ 이상인 경우 네트워크 환경에 대한 문제가 있음을 사용자에게 보고합니다.
^ 
^ [타겟] Yahoo, Google, 르네PvE/PvP, Localhost
^ [보고서] 패킷 및 왕복 시간(ms) 데이터를 기반으로한 최대/평균 편차 대조 결과가 보고서로 작성됨.
^ [빌드버전] 2.0.0
^ [저장경로] c:\ip_data 폴더에 보고서가 저장됩니다. (사용자명_Ping_Analysis.txt)
rem ==================================================================================
title :: Ping Data Analysis :: Rene v2
mode con cols=76 lines=18
set Max=67
set Avg=63
set Serror=0
set error=0
set lError=0
set Title=[Console]
if not exist "c:\IP_Data" (
	mkdir "c:\IP_Data"
) else (
	if exist "c:\IP_Data\%username%_Ping_Analysis.txt" (
		del /q "c:\IP_Data\%username%_Ping_Analysis.txt" >nul
	)
)
if not exist "c:\IP_Data\resource\" (
	mkdir "c:\IP_Data\resource\"
)
if not exist "c:\IP_Data\No.txt" (
	echo 1 > c:\IP_Data\No.txt
) else (
	for /f %%a in (c:\IP_Data\No.txt) do set Load=%%a>nul
)
if /i "%load%" equ "" (
	set Load=1
)
set /a AddLoad=%Load%+1
rem ==========================
echo %title% Packet Send to yahoo.com
ping -t yahoo.com -n 10 > c:\IP_Data\resource\%Username%_yahoo_Data.txt
findstr /c:"패킷" "c:\IP_Data\resource\%Username%_yahoo_Data.txt" > "c:\IP_Data\resource\yahoo_split.txt"
findstr /c:"최소" "c:\IP_Data\resource\%Username%_yahoo_Data.txt" >> "c:\IP_Data\resource\yahoo_split.txt"
for /f "eol=최 tokens=1-30 delims= " %%a in (c:\IP_Data\resource\yahoo_split.txt) do (
	set yasend=%%d
	set yarev=%%g
	set yless=%%j
	set yaper=%%k
	for /f "eol=패 tokens=1-30 delims= " %%a in (c:\IP_Data\resource\yahoo_split.txt) do (
		set yamin=%%c
		set yamax=%%f
		set yaavg=%%i
	)
)
set ysend=%yasend:,=%
set yrev=%yarev:,=%
set yper=%yaper:(=%
set ymin=%yamin:ms,=%
set ymax=%yamax:ms,=%
set yavg=%yaavg:ms=%
set /a tMax=%Max%-%ymax% >nul
set /a tAvg=%Avg%-%yavg% >nul
if /i "%tMax:~0,1%" equ "-" (
	set ComMax=%tMax:-=%
) else (
	set ComMax=%tMax%
)
if /i "%tAvg:~0,1%" equ "-" (
	set ComAvg=%tAvg:-=%
) else (
	set ComAvg=%tAvg%
)
set YahooAvg=%ComMax%
if "%ComAvg%" geq "100" (
	set /a Error=%Error%+1 >nul
	echo [Console] Yahoo 도메인에 패킷 전송 중 문제가 발생했습니다.
	echo   ================================== > c:\IP_Data\%username%_Ping_Analysis.txt
	echo            [ Ping Data Analysis Report v%addLoad% ] >> c:\IP_Data\%username%_Ping_Analysis.txt
	echo 			[%date:~0,4%-%date:~5,2%-%date:~8,3% %time:~0,2%:%time:~3,2%:%time:~6,2%] >> c:\IP_Data\%username%_Ping_Analysis.txt
	echo 			[ %username% ] >> c:\IP_Data\%username%_Ping_Analysis.txt
	echo   ================================== >> c:\IP_Data\%username%_Ping_Analysis.txt
	echo    [ Internet Report ] >> c:\IP_Data\%username%_Ping_Analysis.txt
	echo    ^- Yahoo ^= 최대 %ComMax% ms^, 평균 %ComAvg% ms^, 손실 %yless%^, 손실률 %yper% >> c:\IP_Data\%username%_Ping_Analysis.txt
) else (
	echo [Console] Yahoo 도메인에 패킷 전송 중 문제가 발견되지 않았습니다.
	echo   ================================== > c:\IP_Data\%username%_Ping_Analysis.txt
	echo            [ Ping Data Analysis Report v%addLoad% ] >> c:\IP_Data\%username%_Ping_Analysis.txt
	echo 			[%date:~0,4%-%date:~5,2%-%date:~8,3% %time:~0,2%:%time:~3,2%:%time:~6,2%] >> c:\IP_Data\%username%_Ping_Analysis.txt
	echo 			[ %username% ] >> c:\IP_Data\%username%_Ping_Analysis.txt
	echo   ================================== >> c:\IP_Data\%username%_Ping_Analysis.txt
	echo    [ Internet Report ] >> c:\IP_Data\%username%_Ping_Analysis.txt
	echo    ^- Yahoo ^= 최대 %ComMax% ms, 평균 %ComAvg% ms, 손실 %yless%, 손실률 %yper% >> c:\IP_Data\%username%_Ping_Analysis.txt
)
goto google

:Google
echo %title% Packet Send to google.co.kr
ping -t google.co.kr -n 10 > c:\IP_Data\resource\%Username%_google_Data.txt
findstr /c:"패킷" "c:\IP_Data\resource\%Username%_google_Data.txt" > "c:\IP_Data\resource\google_split.txt"
findstr /c:"최소" "c:\IP_Data\resource\%Username%_google_Data.txt" >> "c:\IP_Data\resource\google_split.txt"
for /f "eol=최 tokens=1-30 delims= " %%a in (c:\IP_Data\resource\google_split.txt) do (
	set yasend=%%d
	set yarev=%%g
	set yless=%%j
	set yaper=%%k
	for /f "eol=패 tokens=1-30 delims= " %%a in (c:\IP_Data\resource\google_split.txt) do (
		set yamin=%%c
		set yamax=%%f
		set yaavg=%%i
	)
)
set ysend=%yasend:,=%
set yrev=%yarev:,=%
set yper=%yaper:(=%
set ymin=%yamin:ms,=%
set ymax=%yamax:ms,=%
set yavg=%yaavg:ms=%
set /a tMax=%Max%-%ymax% >nul
set /a tAvg=%Avg%-%yavg% >nul
if /i "%tMax:~0,1%" equ "-" (
	set ComMax=%tMax:-=%
) else (
	set ComMax=%tMax%
)
if /i "%tAvg:~0,1%" equ "-" (
	set ComAvg=%tAvg:-=%
) else (
	set ComAvg=%tAvg%
)
set GoogleAvg=%ComMax%
if "%ComMax%" geq "100" (
	set /a Error=%Error%+1 >nul
	echo [Console] Google 도메인에 패킷 전송 중 문제가 발생했습니다.
	echo    ^- Google ^= 최대 %ComMax% ms, 평균 %ComAvg% ms, 손실 %yless%, 손실률 %yper% >> c:\IP_Data\%username%_Ping_Analysis.txt
) else (
	echo [Console] Google 도메인에 패킷 전송 중 문제가 발견되지 않았습니다.
	echo    ^- Google ^= 최대 %ComMax% ms, 평균 %ComAvg% ms, 손실 %yless%, 손실률 %yper% >> c:\IP_Data\%username%_Ping_Analysis.txt
)
if "%Error%" geq "1" (
	echo    ^= 네트워크 환경이 불안정합니다. >> c:\IP_Data\%username%_Ping_Analysis.txt
) else (
	echo    ^= 네트워크 환경이 정상적입니다. >> c:\IP_Data\%username%_Ping_Analysis.txt
)
echo. >> c:\IP_Data\%username%_Ping_Analysis.txt
goto PvE

:PvE
echo %title% Packet Send to Rene PvE Server
ping -t 35.216.123.122 -n 20 > c:\IP_Data\resource\%Username%_pve_Data.txt
findstr /c:"패킷" "c:\IP_Data\resource\%Username%_PvE_Data.txt" > "c:\IP_Data\resource\PvE_split.txt"
findstr /c:"최소" "c:\IP_Data\resource\%Username%_PvE_Data.txt" >> "c:\IP_Data\resource\PvE_split.txt"
for /f "eol=최 tokens=1-30 delims= " %%a in (c:\IP_Data\resource\PvE_split.txt) do (
	set yasend=%%d
	set yarev=%%g
	set yless=%%j
	set yaper=%%k
	for /f "eol=패 tokens=1-30 delims= " %%a in (c:\IP_Data\resource\PvE_split.txt) do (
		set yamin=%%c
		set yamax=%%f
		set yaavg=%%i
	)
)
set ysend=%yasend:,=%
set yrev=%yarev:,=%
set yper=%yaper:(=%
set ymin=%yamin:ms,=%
set ymax=%yamax:ms,=%
set yavg=%yaavg:ms=%
set /a tMax=%Max%-%ymax% >nul
set /a tAvg=%Avg%-%yavg% >nul
if /i "%tMax:~0,1%" equ "-" (
	set ComMax=%tMax:-=%
) else (
	set ComMax=%tMax%
)
if /i "%tAvg:~0,1%" equ "-" (
	set ComAvg=%tAvg:-=%
) else (
	set ComAvg=%tAvg%
)
set PvEAvg=%ComMax%
if "%ComMax%" geq "100" (
	set /a sError=%sError%+1 >nul
	echo [Console] PvE 도메인에 패킷 전송 중 문제가 발생했습니다.
	echo    [ Rene Report ] >> c:\IP_Data\%username%_Ping_Analysis.txt
	echo    ^- PvE ^= 최대 %ComMax% ms, 평균 %ComAvg% ms, 손실 %yless%, 손실률 %yper% >> c:\IP_Data\%username%_Ping_Analysis.txt
) else (
	echo [Console] PvE 도메인에 패킷 전송 중 문제가 발견되지 않았습니다.
	echo    [ Rene Report ] >> c:\IP_Data\%username%_Ping_Analysis.txt
	echo    ^- PvE ^= 최대 %ComMax% ms, 평균 %ComAvg% ms, 손실 %yless%, 손실률 %yper% >> c:\IP_Data\%username%_Ping_Analysis.txt
)
goto PvP

:PvP
echo %title% Packet Send to Rene PvP Server
ping -t 34.64.91.211 -n 20 > c:\IP_Data\resource\%Username%_pvp_Data.txt
findstr /c:"패킷" "c:\IP_Data\resource\%Username%_PvP_Data.txt" > "c:\IP_Data\resource\PvP_split.txt"
findstr /c:"최소" "c:\IP_Data\resource\%Username%_PvP_Data.txt" >> "c:\IP_Data\resource\PvP_split.txt"
for /f "eol=최 tokens=1-30 delims= " %%a in (c:\IP_Data\resource\PvP_split.txt) do (
	set yasend=%%d
	set yarev=%%g
	set yless=%%j
	set yaper=%%k
	for /f "eol=패 tokens=1-30 delims= " %%a in (c:\IP_Data\resource\PvP_split.txt) do (
		set yamin=%%c
		set yamax=%%f
		set yaavg=%%i
	)
)
set ysend=%yasend:,=%
set yrev=%yarev:,=%
set yper=%yaper:(=%
set ymin=%yamin:ms,=%
set ymax=%yamax:ms,=%
set yavg=%yaavg:ms=%
set /a tMax=%Max%-%ymax% >nul
set /a tAvg=%Avg%-%yavg% >nul
if /i "%tMax:~0,1%" equ "-" (
	set ComMax=%tMax:-=%
) else (
	set ComMax=%tMax%
)
if /i "%tAvg:~0,1%" equ "-" (
	set ComAvg=%tAvg:-=%
) else (
	set ComAvg=%tAvg%
)
set PvPAvg=%ComMax%
if "%ComMax%" geq "100" (
	set /a sError=%sError%+1 >nul
	echo [Console] PvP 도메인에 패킷 전송 중 문제가 발생했습니다.
	echo    ^- PvP ^= 최대 %ComMax% ms, 평균 %ComAvg% ms, 손실 %yless%, 손실률 %yper% >> c:\IP_Data\%username%_Ping_Analysis.txt
) else (
	echo [Console] PvP 도메인에 패킷 전송 중 문제가 발견되지 않았습니다.
	echo    ^- PvP ^= 최대 %ComMax% ms, 평균 %ComAvg% ms, 손실 %yless%, 손실률 %yper% >> c:\IP_Data\%username%_Ping_Analysis.txt
)
if "%sError%" geq "1" (
	echo    ^= 네트워크 환경이 불안정합니다. >> c:\IP_Data\%username%_Ping_Analysis.txt
) else (
	echo    ^= 네트워크 환경이 정상적입니다. >> c:\IP_Data\%username%_Ping_Analysis.txt
)
echo. >> c:\IP_Data\%username%_Ping_Analysis.txt
goto Local

:Local
echo %title% Extracting Local Ipv4 Address
ipconfig > c:\IP_Data\resource\ipdata.txt
findstr /c:"IPv4" "c:\IP_Data\resource\ipdata.txt" > c:\IP_Data\resource\ip.txt
for /f "tokens=1-30 delims= " %%a in (c:\IP_Data\resource\ip.txt) do (
	echo %title% Packet Send to Localhost
	ping -t %%m -n 10 >> c:\IP_Data\resource\%username%_local_data.txt
)
findstr /c:"패킷" "c:\IP_Data\resource\%Username%_Local_Data.txt" > "c:\IP_Data\resource\Local_split.txt"
findstr /c:"최소" "c:\IP_Data\resource\%Username%_Local_Data.txt" >> "c:\IP_Data\resource\Local_split.txt"
for /f "eol=최 tokens=1-30 delims= " %%a in (c:\IP_Data\resource\Local_split.txt) do (
	set yasend=%%d
	set yarev=%%g
	set yless=%%j
	set yaper=%%k
	for /f "eol=패 tokens=1-30 delims= " %%a in (c:\IP_Data\resource\Local_split.txt) do (
		set yamin=%%c
		set yamax=%%f
		set yaavg=%%i
	)
)
set ysend=%yasend:,=%
set yrev=%yarev:,=%
set yper=%yaper:(=%
set ymin=%yamin:ms,=%
set ymax=%yamax:ms,=%
set yavg=%yaavg:ms=%
if /i "%ymax%" gtr "0" (
	set /a tMax=%Max%-%ymax% >nul
	set /a tAvg=%Avg%-%yavg% >nul
) else (
	set /a tMax=%ymax% >nul
	set /a tAvg=%yavg% >nul
)
if /i "%tMax:~0,1%" equ "-" (
	set ComMax=%tMax:-=%
) else (
	set ComMax=%tMax%
)
if /i "%tAvg:~0,1%" equ "-" (
	set ComAvg=%tAvg:-=%
) else (
	set ComAvg=%tAvg%
)
set LocalAvg=%ComMax%
if "%ComMax%" geq "100" (
	set /a lError=%lError%+1 >nul
	echo [Console] Local 도메인에 패킷 전송 중 문제가 발생했습니다.
	echo    [ Localhost Report ] >> c:\IP_Data\%username%_Ping_Analysis.txt
	echo    ^- Localhost ^= 최대 %ComMax% ms, 평균 %ComAvg% ms, 손실 %yless%, 손실률 %yper% >> c:\IP_Data\%username%_Ping_Analysis.txt
) else (
	echo [Console] Local 도메인에 패킷 전송 중 문제가 발견되지 않았습니다.
	echo    [ Localhost Report ] >> c:\IP_Data\%username%_Ping_Analysis.txt
	echo    ^- Localhost ^= 최대 %ComMax% ms, 평균 %ComAvg% ms, 손실 %yless%, 손실률 %yper% >> c:\IP_Data\%username%_Ping_Analysis.txt
)
if "%lError%" geq "1" ( 
	echo    ^= 네트워크 환경이 불안정합니다. >> c:\IP_Data\%username%_Ping_Analysis.txt
) else (
	echo    ^= 네트워크 환경이 정상적입니다. >> c:\IP_Data\%username%_Ping_Analysis.txt
)
echo. >> c:\IP_Data\%username%_Ping_Analysis.txt
goto Result

:Result
set /a AllError=%Error%+%SError%+%LError%
set /a Combine=%YahooAvg%+%GoogleAvg%+%PvEAvg%+%PvPAvg%+%LocalAvg%
if /i "%Combine:~0,1%" equ "-" (
	set Setbine=%Combine:-=%
) else (
	set Setbine=%Combine%
)
set /a ComAvg=%Setbine% / 5
if /i "%ComAvg:~0,1%" equ "-" (
	set SetAvg=%ComAvg:-=%
) else (
	set SetAvg=%ComAvg%
)
echo   ================================== >> c:\IP_Data\%username%_Ping_Analysis.txt
echo    [* Report Analysis Results *] >> c:\IP_Data\%username%_Ping_Analysis.txt
echo    ^= 핑이 평균 [%SetAvg% ms] 만큼 지연되고 있습니다. >> c:\IP_Data\%username%_Ping_Analysis.txt
echo    ^= 네트워크 환경 오류 보고 [ %AllError% ] 건 >> c:\IP_Data\%username%_Ping_Analysis.txt
if "%allerror%" geq "1" (
	echo    + 네트워크 환경 점검을 권장드립니다. >> c:\IP_Data\%username%_Ping_Analysis.txt
)
echo   ================================== >> c:\IP_Data\%username%_Ping_Analysis.txt
echo    [ 핑 지연 속도 ] >> c:\IP_Data\%username%_Ping_Analysis.txt
echo    - 1 ~ 50 ms	[정상] >> c:\IP_Data\%username%_Ping_Analysis.txt
echo    - 50 ~ 100 ms	[주의] >> c:\IP_Data\%username%_Ping_Analysis.txt
echo    - 100ms 이상	[경고] >> c:\IP_Data\%username%_Ping_Analysis.txt
goto Exit

:Exit
echo %title% Complete all processes
rmdir /s /q "c:\IP_Data\resource"
echo %title% 자세한 상담 희망 시 관리자에게 "c:\IP_Data" 폴더의 %username%_Ping_Analysis.txt 파일을 전송해주십시오.
echo %AddLoad% > c:\IP_Data\No.txt
pause>nul
exit
