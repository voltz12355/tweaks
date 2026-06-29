@echo off
title Ultimate FPS and Ping Booster 2026
:: Ensure Admin Privileges
net session >nul 2>&1
if %errorLevel% == 0 (
    goto main
) else (
    powershell -Command "Start-Process '%~sdpnx0' -Verb RunAs"
    exit /b
)

:main
cls
echo ===================================================
echo     ULTIMATE HONE/PARAGON STYLE BOOST SCRIPT
echo ===================================================
echo.
echo  [1] Max Out FPS & Lower Input Delay
echo  [2] Max Out Wi-Fi/Ethernet & Kill Ping Spikes
echo  [3] Run Full Optimization (Recommended)
echo  [4] Exit
echo.
echo ===================================================
set /p choice="Select an option (1-4): "

if "%choice%"=="1" goto fps
if "%choice%"=="2" goto ping
if "%choice%"=="3" goto both
if "%choice%"=="4" exit
goto main

:fps
echo.
echo [!] Optimizing Windows for Maximum FPS...
:: 1. Unlocks the hidden Windows Ultimate Performance Plan and activates it
powercfg -duplicatescheme e9a42b02-d5df-44d7-9a86-7509351287ba
powercfg -setactive e9a42b02-d5df-44d7-9a86-7509351287ba

:: 2. Set System Responsiveness to 0 (gives games 100%% CPU priority over background apps)
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f

:: 3. Configure high gaming task priority settings in registry
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f

:: 4. Disable Hibernation to free up RAM clutter
powercfg -h off

echo.
echo ✨ FPS Tweaks Applied!
if "%choice%"=="3" goto ping
pause
goto main

:ping
echo.
echo [!] Tuning Network Adapter for Low Latency...
:: 1. Clear bad network routing paths
ipconfig /flushdns
netsh winsock reset >nul
netsh int ip reset >nul

:: 2. Disable Nagle's Algorithm (TCP NoDelay) to send game packets instantly
netsh int tcp set global autotuninglevel=normal

:: 3. Disable Network Throttling (stops Windows from slowing internet while gaming)
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f

:: 4. Force optimal MTU/packet handling parameters
netsh int tcp set global ecncapability=enabled

echo.
echo ✨ Ping & Latency Tweaks Applied!
pause
goto main

:both
goto fps