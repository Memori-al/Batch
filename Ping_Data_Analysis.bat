@echo off
rem ==========================
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
findstr /c:"��Ŷ" "c:\IP_Data\resource\%Username%_yahoo_Data.txt" > "c:\IP_Data\resource\yahoo_split.txt"
findstr /c:"�ּ�" "c:\IP_Data\resource\%Username%_yahoo_Data.txt" >> "c:\IP_Data\resource\yahoo_split.txt"
for /f "eol=�� tokens=1-30 delims= " %%a in (c:\IP_Data\resource\yahoo_split.txt) do (
	set yasend=%%d
	set yarev=%%g
	set yless=%%j
	set yaper=%%k
	for /f "eol=�� tokens=1-30 delims= " %%a in (c:\IP_Data\resource\yahoo_split.txt) do (
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
	echo [Console] Yahoo �����ο� ��Ŷ ���� �� ������ �߻��߽��ϴ�.
	echo   ================================== > c:\IP_Data\%username%_Ping_Analysis.txt
	echo            [ Ping Data Analysis Report v%addLoad% ] >> c:\IP_Data\%username%_Ping_Analysis.txt
	echo 			[%date:~0,4%-%date:~5,2%-%date:~8,3% %time:~0,2%:%time:~3,2%:%time:~6,2%] >> c:\IP_Data\%username%_Ping_Analysis.txt
	echo 			[ %username% ] >> c:\IP_Data\%username%_Ping_Analysis.txt
	echo   ================================== >> c:\IP_Data\%username%_Ping_Analysis.txt
	echo    [ Internet Report ] >> c:\IP_Data\%username%_Ping_Analysis.txt
	echo    ^- Yahoo ^= �ִ� %ComMax% ms^, ��� %ComAvg% ms^, �ս� %yless%^, �սǷ� %yper% >> c:\IP_Data\%username%_Ping_Analysis.txt
) else (
	echo [Console] Yahoo �����ο� ��Ŷ ���� �� ������ �߰ߵ��� �ʾҽ��ϴ�.
	echo   ================================== > c:\IP_Data\%username%_Ping_Analysis.txt
	echo            [ Ping Data Analysis Report v%addLoad% ] >> c:\IP_Data\%username%_Ping_Analysis.txt
	echo 			[%date:~0,4%-%date:~5,2%-%date:~8,3% %time:~0,2%:%time:~3,2%:%time:~6,2%] >> c:\IP_Data\%username%_Ping_Analysis.txt
	echo 			[ %username% ] >> c:\IP_Data\%username%_Ping_Analysis.txt
	echo   ================================== >> c:\IP_Data\%username%_Ping_Analysis.txt
	echo    [ Internet Report ] >> c:\IP_Data\%username%_Ping_Analysis.txt
	echo    ^- Yahoo ^= �ִ� %ComMax% ms, ��� %ComAvg% ms, �ս� %yless%, �սǷ� %yper% >> c:\IP_Data\%username%_Ping_Analysis.txt
)
goto google

:Google
echo %title% Packet Send to google.co.kr
ping -t google.co.kr -n 10 > c:\IP_Data\resource\%Username%_google_Data.txt
findstr /c:"��Ŷ" "c:\IP_Data\resource\%Username%_google_Data.txt" > "c:\IP_Data\resource\google_split.txt"
findstr /c:"�ּ�" "c:\IP_Data\resource\%Username%_google_Data.txt" >> "c:\IP_Data\resource\google_split.txt"
for /f "eol=�� tokens=1-30 delims= " %%a in (c:\IP_Data\resource\google_split.txt) do (
	set yasend=%%d
	set yarev=%%g
	set yless=%%j
	set yaper=%%k
	for /f "eol=�� tokens=1-30 delims= " %%a in (c:\IP_Data\resource\google_split.txt) do (
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
	echo [Console] Google �����ο� ��Ŷ ���� �� ������ �߻��߽��ϴ�.
	echo    ^- Google ^= �ִ� %ComMax% ms, ��� %ComAvg% ms, �ս� %yless%, �սǷ� %yper% >> c:\IP_Data\%username%_Ping_Analysis.txt
) else (
	echo [Console] Google �����ο� ��Ŷ ���� �� ������ �߰ߵ��� �ʾҽ��ϴ�.
	echo    ^- Google ^= �ִ� %ComMax% ms, ��� %ComAvg% ms, �ս� %yless%, �սǷ� %yper% >> c:\IP_Data\%username%_Ping_Analysis.txt
)
if "%Error%" geq "1" (
	echo    ^= ��Ʈ��ũ ȯ���� �Ҿ����մϴ�. >> c:\IP_Data\%username%_Ping_Analysis.txt
) else (
	echo    ^= ��Ʈ��ũ ȯ���� �������Դϴ�. >> c:\IP_Data\%username%_Ping_Analysis.txt
)
echo. >> c:\IP_Data\%username%_Ping_Analysis.txt
goto PvE

:PvE
echo %title% Packet Send to Rene PvE Server
ping -t 35.216.123.122 -n 20 > c:\IP_Data\resource\%Username%_pve_Data.txt
findstr /c:"��Ŷ" "c:\IP_Data\resource\%Username%_PvE_Data.txt" > "c:\IP_Data\resource\PvE_split.txt"
findstr /c:"�ּ�" "c:\IP_Data\resource\%Username%_PvE_Data.txt" >> "c:\IP_Data\resource\PvE_split.txt"
for /f "eol=�� tokens=1-30 delims= " %%a in (c:\IP_Data\resource\PvE_split.txt) do (
	set yasend=%%d
	set yarev=%%g
	set yless=%%j
	set yaper=%%k
	for /f "eol=�� tokens=1-30 delims= " %%a in (c:\IP_Data\resource\PvE_split.txt) do (
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
	echo [Console] PvE �����ο� ��Ŷ ���� �� ������ �߻��߽��ϴ�.
	echo    [ Rene Report ] >> c:\IP_Data\%username%_Ping_Analysis.txt
	echo    ^- PvE ^= �ִ� %ComMax% ms, ��� %ComAvg% ms, �ս� %yless%, �սǷ� %yper% >> c:\IP_Data\%username%_Ping_Analysis.txt
) else (
	echo [Console] PvE �����ο� ��Ŷ ���� �� ������ �߰ߵ��� �ʾҽ��ϴ�.
	echo    [ Rene Report ] >> c:\IP_Data\%username%_Ping_Analysis.txt
	echo    ^- PvE ^= �ִ� %ComMax% ms, ��� %ComAvg% ms, �ս� %yless%, �սǷ� %yper% >> c:\IP_Data\%username%_Ping_Analysis.txt
)
goto PvP

:PvP
echo %title% Packet Send to Rene PvP Server
ping -t 34.64.91.211 -n 20 > c:\IP_Data\resource\%Username%_pvp_Data.txt
findstr /c:"��Ŷ" "c:\IP_Data\resource\%Username%_PvP_Data.txt" > "c:\IP_Data\resource\PvP_split.txt"
findstr /c:"�ּ�" "c:\IP_Data\resource\%Username%_PvP_Data.txt" >> "c:\IP_Data\resource\PvP_split.txt"
for /f "eol=�� tokens=1-30 delims= " %%a in (c:\IP_Data\resource\PvP_split.txt) do (
	set yasend=%%d
	set yarev=%%g
	set yless=%%j
	set yaper=%%k
	for /f "eol=�� tokens=1-30 delims= " %%a in (c:\IP_Data\resource\PvP_split.txt) do (
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
	echo [Console] PvP �����ο� ��Ŷ ���� �� ������ �߻��߽��ϴ�.
	echo    ^- PvP ^= �ִ� %ComMax% ms, ��� %ComAvg% ms, �ս� %yless%, �սǷ� %yper% >> c:\IP_Data\%username%_Ping_Analysis.txt
) else (
	echo [Console] PvP �����ο� ��Ŷ ���� �� ������ �߰ߵ��� �ʾҽ��ϴ�.
	echo    ^- PvP ^= �ִ� %ComMax% ms, ��� %ComAvg% ms, �ս� %yless%, �սǷ� %yper% >> c:\IP_Data\%username%_Ping_Analysis.txt
)
if "%sError%" geq "1" (
	echo    ^= ��Ʈ��ũ ȯ���� �Ҿ����մϴ�. >> c:\IP_Data\%username%_Ping_Analysis.txt
) else (
	echo    ^= ��Ʈ��ũ ȯ���� �������Դϴ�. >> c:\IP_Data\%username%_Ping_Analysis.txt
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
findstr /c:"��Ŷ" "c:\IP_Data\resource\%Username%_Local_Data.txt" > "c:\IP_Data\resource\Local_split.txt"
findstr /c:"�ּ�" "c:\IP_Data\resource\%Username%_Local_Data.txt" >> "c:\IP_Data\resource\Local_split.txt"
for /f "eol=�� tokens=1-30 delims= " %%a in (c:\IP_Data\resource\Local_split.txt) do (
	set yasend=%%d
	set yarev=%%g
	set yless=%%j
	set yaper=%%k
	for /f "eol=�� tokens=1-30 delims= " %%a in (c:\IP_Data\resource\Local_split.txt) do (
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
	echo [Console] Local �����ο� ��Ŷ ���� �� ������ �߻��߽��ϴ�.
	echo    [ Localhost Report ] >> c:\IP_Data\%username%_Ping_Analysis.txt
	echo    ^- Localhost ^= �ִ� %ComMax% ms, ��� %ComAvg% ms, �ս� %yless%, �սǷ� %yper% >> c:\IP_Data\%username%_Ping_Analysis.txt
) else (
	echo [Console] Local �����ο� ��Ŷ ���� �� ������ �߰ߵ��� �ʾҽ��ϴ�.
	echo    [ Localhost Report ] >> c:\IP_Data\%username%_Ping_Analysis.txt
	echo    ^- Localhost ^= �ִ� %ComMax% ms, ��� %ComAvg% ms, �ս� %yless%, �սǷ� %yper% >> c:\IP_Data\%username%_Ping_Analysis.txt
)
if "%lError%" geq "1" ( 
	echo    ^= ��Ʈ��ũ ȯ���� �Ҿ����մϴ�. >> c:\IP_Data\%username%_Ping_Analysis.txt
) else (
	echo    ^= ��Ʈ��ũ ȯ���� �������Դϴ�. >> c:\IP_Data\%username%_Ping_Analysis.txt
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
echo    ^= ���� ��� [%SetAvg% ms] ��ŭ �����ǰ� �ֽ��ϴ�. >> c:\IP_Data\%username%_Ping_Analysis.txt
echo    ^= ��Ʈ��ũ ȯ�� ���� ���� [ %AllError% ] �� >> c:\IP_Data\%username%_Ping_Analysis.txt
if "%allerror%" geq "1" (
	echo    + ��Ʈ��ũ ȯ�� ������ ����帳�ϴ�. >> c:\IP_Data\%username%_Ping_Analysis.txt
)
echo   ================================== >> c:\IP_Data\%username%_Ping_Analysis.txt
echo    [ �� ���� �ӵ� ] >> c:\IP_Data\%username%_Ping_Analysis.txt
echo    - 1 ~ 50 ms	[����] >> c:\IP_Data\%username%_Ping_Analysis.txt
echo    - 50 ~ 100 ms	[����] >> c:\IP_Data\%username%_Ping_Analysis.txt
echo    - 100ms �̻�	[���] >> c:\IP_Data\%username%_Ping_Analysis.txt
goto Exit

:Exit
echo %title% Complete all processes
rmdir /s /q "c:\IP_Data\resource"
echo %title% �ڼ��� ��� ��� �� �����ڿ��� "c:\IP_Data" ������ %username%_Ping_Analysis.txt ������ �������ֽʽÿ�.
echo %AddLoad% > c:\IP_Data\No.txt
pause>nul
exit