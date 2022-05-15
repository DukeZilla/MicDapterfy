echo off
break off
mode con: cols=15 lines=2
title Internet speed
color 0a
setlocal enabledelayedexpansion
cls
goto main

:main
color 0a
ping -n 1 google.com > nul
if %errorlevel%==1 (
color 4
echo -Disconnected-
)
for /f "usebackq tokens=9 delims= " %%h in (`ping -n 1 google.com ^| findstr /ic:"Minimum"`) do (
cls
echo Ping: %%h
)
timeout 1 > nul
cls
goto main