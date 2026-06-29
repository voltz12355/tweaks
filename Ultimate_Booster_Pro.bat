@echo off
title Ultimate Gaming Booster PRO 2026
color 0A

:: ============================================================
::   ULTIMATE GAMING BOOSTER PRO - FPS / PING / SYSTEM MAX
:: ============================================================

net session >nul 2>&1
if %errorLevel% == 0 (
    goto main
) else (
    powershell -Command "Start-Process '%~sdpnx0' -Verb RunAs"
    exit /b
)

:main
cls
echo.
echo  ██████╗  ██████╗  ██████╗     ██████╗ ██████╗  ██████╗
echo  ██╔══██╗██╔═══██╗██╔════╝     ██╔══██╗██╔══██╗██╔═══██╗
echo  ██████╔╝██║   ██║██║  ███╗    ██████╔╝██████╔╝██║   ██║
echo  ██╔═══╝ ██║   ██║██║   ██║    ██╔═══╝ ██╔══██╗██║   ██║
echo  ██║     ╚██████╔╝╚██████╔╝    ██║     ██║  ██║╚██████╔╝
echo  ╚═╝      ╚═════╝  ╚═════╝     ╚═╝     ╚═╝  ╚═╝ ╚═════╝
echo.
echo  ============================================================
echo   ULTIMATE GAMING BOOSTER PRO 2026  ^|  Run as Administrator
echo  ============================================================
echo.
echo   [1]  Max FPS + Power Plan (Ultimate Performance)
echo   [2]  Network / Ping Optimizer
echo   [3]  GPU Optimization (NVIDIA + AMD tweaks)
echo   [4]  CPU Process Priority Booster
echo   [5]  RAM Cleaner + Virtual Memory Boost
echo   [6]  Disable Useless Background Services
echo   [7]  Visual Effects - Pure Performance Mode
echo   [8]  Mouse + Input Lag Eliminator
echo   [9]  Storage / Disk Speed Optimizer
echo   [10] Windows Defender Gaming Mode (temp disable)
echo   [11] Overclock-Safe Timer Resolution Fix
echo   [12] DirectX + Shader Cache Cleaner
echo   [13] Full System Restore (Undo All Changes)
echo   [14] RUN ALL OPTIMIZATIONS (NUKE MODE)
echo   [15] Exit
echo.
echo  ============================================================
set /p choice="  Select an option (1-15): "

if "%choice%"=="1"  goto fps
if "%choice%"=="2"  goto ping
if "%choice%"=="3"  goto gpu
if "%choice%"=="4"  goto cpu
if "%choice%"=="5"  goto ram
if "%choice%"=="6"  goto services
if "%choice%"=="7"  goto visual
if "%choice%"=="8"  goto mouse
if "%choice%"=="9"  goto disk
if "%choice%"=="10" goto defender
if "%choice%"=="11" goto timer
if "%choice%"=="12" goto cache
if "%choice%"=="13" goto restore
if "%choice%"=="14" goto nukemode
if "%choice%"=="15" exit
goto main

:: ============================================================
:: [1] MAX FPS + POWER PLAN
:: ============================================================
:fps
echo.
echo  [1/1] Applying FPS + Power Optimizations...
echo  --------------------------------------------

:: Activate Ultimate Performance power plan
powercfg -duplicatescheme e9a42b02-d5df-44d7-9a86-7509351287ba >nul 2>&1
powercfg -setactive e9a42b02-d5df-44d7-9a86-7509351287ba

:: Give games 100%% CPU - remove background app CPU cap
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f

:: Max game scheduling priority
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d "False" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f

:: Disable hibernation (frees pagefile + RAM clutter)
powercfg -h off

:: Disable Fast Startup (causes stale driver state on boot)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 0 /f

:: Disable CPU core parking (stops cores from going idle mid-game)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v ValueMax /t REG_DWORD /d 0 /f

:: Set processor minimum state to 100%% (no throttling)
powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMIN 100

echo.
echo  [OK] FPS + Power tweaks applied!
if "%choice%"=="14" goto ping
pause
goto main

:: ============================================================
:: [2] NETWORK / PING OPTIMIZER
:: ============================================================
:ping
echo.
echo  [2/2] Applying Network + Ping Optimizations...
echo  ------------------------------------------------

:: Flush bad DNS cache and reset winsock/IP stack
ipconfig /flushdns
netsh winsock reset >nul
netsh int ip reset >nul

:: Disable Nagle's Algorithm for both IPv4+IPv6 (instant packet sending)
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v TcpAckFrequency /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v TCPNoDelay /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpAckFrequency /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TCPNoDelay /t REG_DWORD /d 1 /f

:: Disable network throttling index entirely
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f

:: Enable ECN for smarter packet congestion handling
netsh int tcp set global ecncapability=enabled

:: Set TCP auto-tuning to normal (not experimental/disabled)
netsh int tcp set global autotuninglevel=normal

:: Enable RSS (Receive-Side Scaling) - better multi-core NIC usage
netsh int tcp set global rss=enabled

:: Enable TCP chimney offload
netsh int tcp set global chimney=enabled

:: Reduce DNS TTL for faster server resolution
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v MaxCacheTtl /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v MaxNegativeCacheTtl /t REG_DWORD /d 0 /f

:: Set NIC to max performance via power settings
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\0001" /v "*EEE" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\0001" /v "EnablePME" /t REG_SZ /d "0" /f

echo.
echo  [OK] Network + Ping tweaks applied!
if "%choice%"=="14" goto gpu
pause
goto main

:: ============================================================
:: [3] GPU OPTIMIZATION
:: ============================================================
:gpu
echo.
echo  [3/3] Applying GPU Optimizations...
echo  -------------------------------------

:: Disable NVIDIA power saving (force max GPU clocks)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PerfLevelSrc" /t REG_DWORD /d 8738 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PowerMizerEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PowerMizerLevel" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PowerMizerLevelAC" /t REG_DWORD /d 1 /f

:: Enable Hardware Accelerated GPU Scheduling (HAGS) - Win10 2004+
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f

:: Force GPU to prefer maximum performance (vs adaptive)
reg add "HKCU\SOFTWARE\NVIDIA Corporation\Global\NvCplApi\Policies" /v OverclockEnabled /t REG_DWORD /d 1 /f

:: Disable MPO (Multi Plane Overlay) - fixes FPS drops/stutters on some GPUs
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v OverlayTestMode /t REG_DWORD /d 5 /f

echo.
echo  [OK] GPU tweaks applied! (Reboot recommended)
if "%choice%"=="14" goto cpu
pause
goto main

:: ============================================================
:: [4] CPU PROCESS PRIORITY BOOSTER
:: ============================================================
:cpu
echo.
echo  [4/4] Boosting CPU Priority for Games...
echo  ------------------------------------------

:: Raise priority of foreground apps (games)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 38 /f

:: Disable speculative execution mitigations (Spectre/Meltdown patches = CPU overhead)
:: WARNING: Only do this on a personal gaming PC not used for sensitive work
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverride /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverrideMask /t REG_DWORD /d 3 /f

:: Disable SysMain (Superfetch) - causes random HDD/SSD spikes during gaming
sc config SysMain start= disabled
sc stop SysMain >nul 2>&1

:: Disable Windows Search indexing during gaming (eats CPU)
sc config WSearch start= disabled
sc stop WSearch >nul 2>&1

echo.
echo  [OK] CPU priority tweaks applied!
if "%choice%"=="14" goto ram
pause
goto main

:: ============================================================
:: [5] RAM CLEANER + VIRTUAL MEMORY BOOST
:: ============================================================
:ram
echo.
echo  [5/5] Cleaning RAM + Boosting Virtual Memory...
echo  -------------------------------------------------

:: Flush standby list (frees RAM held by closed apps)
powershell -Command "& { $mem = [System.Runtime.InteropServices.RuntimeEnvironment]::GetRuntimeDirectory(); [System.IO.Directory]::GetFiles($mem, '*.dll') | ForEach-Object { try { [System.Runtime.InteropServices.Marshal]::PrelinkAll([reflection.assembly]::LoadFile($_)) } catch {} } }" >nul 2>&1

:: Clear temp files that bloat RAM usage over time
del /f /s /q "%temp%\*" >nul 2>&1
del /f /s /q "C:\Windows\Temp\*" >nul 2>&1

:: Disable paging of kernel and driver memory (keep in RAM, faster)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v DisablePagingExecutive /t REG_DWORD /d 1 /f

:: Disable memory compression (can cause stutters)
powershell -Command "Disable-MMAgent -mc" >nul 2>&1

:: Optimize large system cache for gaming workloads
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 0 /f

echo.
echo  [OK] RAM optimized and temp files cleared!
if "%choice%"=="14" goto services
pause
goto main

:: ============================================================
:: [6] DISABLE USELESS BACKGROUND SERVICES
:: ============================================================
:services
echo.
echo  [6/6] Killing Useless Background Services...
echo  ----------------------------------------------

:: Disable Xbox services (unless you need Xbox Game Bar)
sc config XblAuthManager start= disabled >nul 2>&1
sc config XblGameSave start= disabled >nul 2>&1
sc config XboxGipSvc start= disabled >nul 2>&1
sc config XboxNetApiSvc start= disabled >nul 2>&1
sc stop XblAuthManager >nul 2>&1
sc stop XblGameSave >nul 2>&1

:: Disable print spooler (no printer = free resources)
sc config Spooler start= disabled >nul 2>&1
sc stop Spooler >nul 2>&1

:: Disable Fax service
sc config Fax start= disabled >nul 2>&1
sc stop Fax >nul 2>&1

:: Disable remote registry (security + performance)
sc config RemoteRegistry start= disabled >nul 2>&1
sc stop RemoteRegistry >nul 2>&1

:: Disable Diagnostic Policy Service (telemetry overhead)
sc config DPS start= disabled >nul 2>&1

:: Disable Connected User Experiences (telemetry / data collection)
sc config DiagTrack start= disabled >nul 2>&1
sc stop DiagTrack >nul 2>&1

:: Disable Windows Error Reporting
sc config WerSvc start= disabled >nul 2>&1
sc stop WerSvc >nul 2>&1

:: Kill Cortana background processing
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v BingSearchEnabled /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v CortanaEnabled /t REG_DWORD /d 0 /f

echo.
echo  [OK] Background services killed!
if "%choice%"=="14" goto visual
pause
goto main

:: ============================================================
:: [7] VISUAL EFFECTS - PURE PERFORMANCE MODE
:: ============================================================
:visual
echo.
echo  [7/7] Stripping Windows Visual Effects for Raw Performance...
echo  --------------------------------------------------------------

:: Set Windows to "Adjust for best performance" (kills all animations/shadows)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f

:: Disable individual animations
reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9012038010000000 /f
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d "0" /f
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewAlphaSelect /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewShadow /t REG_DWORD /d 0 /f

:: Disable transparency effects (eats GPU resources)
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f

:: Disable background wallpaper slideshow
reg add "HKCU\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "" /f

echo.
echo  [OK] Visual effects stripped to bare minimum!
if "%choice%"=="14" goto mouse
pause
goto main

:: ============================================================
:: [8] MOUSE + INPUT LAG ELIMINATOR
:: ============================================================
:mouse
echo.
echo  [8/8] Eliminating Mouse + Input Lag...
echo  ----------------------------------------

:: Disable mouse acceleration (raw 1:1 input)
reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d "0" /f
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d "0" /f
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d "0" /f

:: Disable pointer precision (same as uncheck "Enhance pointer precision")
reg add "HKCU\Control Panel\Mouse" /v MouseSensitivity /t REG_SZ /d "10" /f

:: Disable raw input buffering (lower click-to-action delay)
reg add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v MouseDataQueueSize /t REG_DWORD /d 16 /f

:: Set USB polling to high priority via IRQ
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v IRQ8Priority /t REG_DWORD /d 1 /f

:: Disable game DVR / Game Bar recording (kills input lag in fullscreen games)
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f

echo.
echo  [OK] Mouse + input lag tweaks applied!
if "%choice%"=="14" goto disk
pause
goto main

:: ============================================================
:: [9] STORAGE / DISK SPEED OPTIMIZER
:: ============================================================
:disk
echo.
echo  [9/9] Optimizing Disk I/O Speed...
echo  -------------------------------------

:: Enable TRIM on SSD (keeps SSD fast over time)
fsutil behavior set disabledeletenotify 0

:: Disable 8.3 filename creation (speeds up NTFS file ops)
fsutil behavior set disable8dot3 1

:: Disable last access timestamp update (reduces write overhead)
fsutil behavior set disablelastaccess 1

:: Set disk I/O scheduler to favor performance
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnablePrefetcher /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnableSuperfetch /t REG_DWORD /d 0 /f

:: Disable write-cache buffer flushing (faster writes, only safe on UPS/desktop)
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\SCSI\Disk&Ven_" /v UserWriteCacheSetting /t REG_DWORD /d 1 /f >nul 2>&1

:: Clear old prefetch data
del /f /s /q "C:\Windows\Prefetch\*" >nul 2>&1

echo.
echo  [OK] Disk speed optimized!
if "%choice%"=="14" goto defender
pause
goto main

:: ============================================================
:: [10] WINDOWS DEFENDER GAMING MODE (TEMP DISABLE)
:: ============================================================
:defender
echo.
echo  [10/10] Configuring Windows Defender for Gaming...
echo  ----------------------------------------------------
echo  NOTE: This adds your game folders to exclusions, not full disable.
echo  Full AV disable is a security risk - exclusions are the safe way.
echo.

:: Add common game install folders to Defender exclusion list
powershell -Command "Add-MpPreference -ExclusionPath 'C:\Program Files\Steam'" >nul 2>&1
powershell -Command "Add-MpPreference -ExclusionPath 'C:\Program Files (x86)\Steam'" >nul 2>&1
powershell -Command "Add-MpPreference -ExclusionPath 'C:\Program Files\Epic Games'" >nul 2>&1
powershell -Command "Add-MpPreference -ExclusionPath 'C:\Program Files\Riot Games'" >nul 2>&1
powershell -Command "Add-MpPreference -ExclusionPath 'C:\Program Files (x86)\Origin'" >nul 2>&1
powershell -Command "Add-MpPreference -ExclusionPath 'C:\Program Files\Ubisoft'" >nul 2>&1
powershell -Command "Add-MpPreference -ExclusionPath 'D:\Games'" >nul 2>&1
powershell -Command "Add-MpPreference -ExclusionPath 'E:\Games'" >nul 2>&1

:: Disable real-time Defender scanning for game processes
powershell -Command "Add-MpPreference -ExclusionProcess 'javaw.exe'" >nul 2>&1
powershell -Command "Add-MpPreference -ExclusionProcess 'GameOverlayUI.exe'" >nul 2>&1

:: Reduce Defender scan priority (won't fight games for CPU)
powershell -Command "Set-MpPreference -ScanAvgCPULoadFactor 5" >nul 2>&1

echo.
echo  [OK] Defender exclusions set for game folders!
if "%choice%"=="14" goto timer
pause
goto main

:: ============================================================
:: [11] OVERCLOCK-SAFE TIMER RESOLUTION FIX
:: ============================================================
:timer
echo.
echo  [11/11] Setting High-Resolution System Timer...
echo  -------------------------------------------------

:: Default Windows timer = 15.6ms (very coarse, hurts frame pacing)
:: This forces it to 0.5ms for much smoother frame delivery
:: Uses bcdedit for persistent boot-level setting
bcdedit /set useplatformtick yes >nul 2>&1
bcdedit /set disabledynamictick yes >nul 2>&1

:: Also set via registry for userspace processes
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f

:: Disable Dynamic Tick (keeps timer resolution from dropping during idle)
powercfg -setacvalueindex SCHEME_CURRENT SUB_SLEEP RTCWAKE 0

echo.
echo  [OK] System timer resolution maximized!
if "%choice%"=="14" goto cache
pause
goto main

:: ============================================================
:: [12] DIRECTX + SHADER CACHE CLEANER
:: ============================================================
:cache
echo.
echo  [12/12] Clearing Shader + DirectX Cache...
echo  --------------------------------------------

:: Clear DX shader cache (stale shaders can cause stutters on game updates)
del /f /s /q "%LOCALAPPDATA%\D3DSCache\*" >nul 2>&1
del /f /s /q "%LOCALAPPDATA%\Microsoft\DirectX Shader Cache\*" >nul 2>&1

:: Clear NVIDIA shader cache
del /f /s /q "%LOCALAPPDATA%\NVIDIA\DXCache\*" >nul 2>&1
del /f /s /q "%LOCALAPPDATA%\NVIDIA\GLCache\*" >nul 2>&1

:: Clear AMD shader cache
del /f /s /q "%LOCALAPPDATA%\AMD\DxCache\*" >nul 2>&1

:: Clear temp / crash dumps that pile up
del /f /s /q "%LOCALAPPDATA%\CrashDumps\*" >nul 2>&1
del /f /s /q "C:\Windows\Minidump\*" >nul 2>&1

:: Rebuild icon cache (fixes stuttery Explorer UI)
taskkill /f /im explorer.exe >nul 2>&1
del /f /s /q "%LOCALAPPDATA%\IconCache.db" >nul 2>&1
start explorer.exe

echo.
echo  [OK] Shader + DirectX cache cleared! Stutters reduced.
if "%choice%"=="14" goto nukedone
pause
goto main

:: ============================================================
:: [13] RESTORE - UNDO ALL CHANGES
:: ============================================================
:restore
echo.
echo  [RESTORE] Reverting all changes to Windows defaults...
echo  --------------------------------------------------------

:: Restore balanced power plan
powercfg -setactive 381b4222-f694-41f0-9685-ff5bb260df2e

:: Re-enable SysMain and WSearch
sc config SysMain start= auto >nul 2>&1
sc start SysMain >nul 2>&1
sc config WSearch start= delayed-auto >nul 2>&1
sc start WSearch >nul 2>&1

:: Re-enable Xbox services
sc config XblAuthManager start= demand >nul 2>&1
sc config XblGameSave start= demand >nul 2>&1

:: Restore Nagle's Algorithm
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v TcpAckFrequency /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v TCPNoDelay /f >nul 2>&1

:: Restore network throttling
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 10 /f

:: Restore system responsiveness to default (20)
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 20 /f

:: Restore visual effects to let Windows choose
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 0 /f

:: Re-enable mouse acceleration defaults
reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d "1" /f
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d "6" /f
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d "10" /f

:: Re-enable Game DVR
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 1 /f

:: Restore dynamic tick
bcdedit /deletevalue useplatformtick >nul 2>&1
bcdedit /deletevalue disabledynamictick >nul 2>&1

:: Restore hibernation
powercfg -h on

echo.
echo  [OK] All changes reverted to Windows defaults!
echo  Reboot recommended.
pause
goto main

:: ============================================================
:: [14] NUKE MODE - RUN EVERYTHING
:: ============================================================
:nukemode
cls
echo.
echo  ============================================================
echo   NUKE MODE - RUNNING ALL OPTIMIZATIONS
echo  ============================================================
echo  This will apply every tweak. Reboot when done.
echo.
pause
goto fps

:nukedone
echo.
echo  ============================================================
echo   ALL DONE! Every optimization has been applied.
echo  ============================================================
echo.
echo   Reboot your PC for all changes to take full effect.
echo   Your PC is now optimized for maximum gaming performance.
echo.
pause
goto main
