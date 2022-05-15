@echo off
break off
title MicDapterfy
PUSHD "%CD%"
CD /D "%~dp0"
set back=%cd%
cls
goto checkadmin

:checkadmin
echo.
echo Checking admin privelages...
net session >nul 2>&1
if %errorlevel%==0 (
color 0a
echo.
echo Success.
goto prologue
) ELSE (
color 0c
echo.
echo Error: Current Admin privelages inadequate.
echo.
echo Run this batch file as administrator.
echo.
pause
exit
)

:prologue
cls
echo Configure WiFi adapter.
echo.
wmic nic get name, index
echo.
set /p number=Select Number: 
if %number%==exit exit
echo. 
echo %number% was selected
echo.
echo.
echo Internet Status:
echo.
echo netsh interface show interface | findstr /C:"Wi-Fi" /C:"Name" /C:"-"
echo.
netsh interface show interface | findstr /C:"Wi-Fi" /C:"Name" /C:"-"
echo.
echo.
pause

:main
color 0a
setlocal enabledelayedexpansion
setlocal
for /f "usebackq skip=1 tokens=2,* delims=]" %%x in (`wmic path win32_networkadapter where index^=%number% get caption`) do ( set adapter=%%x )
cls
echo.
echo O-=-=-=-=-I MicDapterfy I-=-=-=-=-O
echo.
echo - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - O
echo  Adapter selected: !adapter!
echo  Index Number: %number%
echo - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - O
endlocal
echo.
echo - - - - - - - - - - - - O
echo 1. Turn ON Adapter
echo.
echo 2. Turn OFF Adapter
echo.
echo 3. View Internet Status
echo.
echo 4. Check Internet Connection
echo.
echo 5. Ping Speedometer
echo.
echo 6. Macaddress
echo.
echo 7. Reselect Adapter
echo.
echo 8. View List
echo.
echo 9. Exit
echo - - - - - - - - - - - - O
echo.
set /p mchoice=Select: 
if %mchoice%==1 goto on
if %mchoice%==2 goto off
if %mchoice%==3 cls & echo Internet Status: & echo. & netsh interface show interface | findstr /C:"Wi-Fi" /C:"Name" /C:"-" & echo. & pause & goto main
if %mchoice%==4 cls & ping google.com & echo. & pause & goto main
if %mchoice%==5 start internet-speedometer.bat & goto main
if %mchoice%==6 cls & echo wmic path win32_networkadapter where index=%number% get macaddress & echo. & wmic path win32_networkadapter where index=%number% get macaddress & pause & goto main
if %mchoice%==7 goto prologue
if %mchoice%==8 cls & wmic nic get name, index & pause & goto main
if %mchoice%==9 exit
if %mchoice%==exit exit
echo.
echo.
echo Error: Wrong selection
echo.
pause
goto main

:on
echo.
echo.
echo wmic path win32_networkadapter where index=%number% call enable
echo.
wmic path win32_networkadapter where index=%number% call enable
if %errorlevel%==0 (
echo Success.
timeout 2 > nul
goto select
) ELSE (
echo Failed.
timeout 2 > nul
goto main
)

:off
echo.
echo.
echo wmic path win32_networkadapter where index=%number% call disable
echo.
wmic path win32_networkadapter where index=%number% call disable
if %errorlevel%==0 (
echo Success.
timeout 2 > nul
goto select
) ELSE (
echo Failed.
timeout 2 > nul
goto main
)

:: Jesus is Lord!