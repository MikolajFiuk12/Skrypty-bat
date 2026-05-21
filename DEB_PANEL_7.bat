@echo off
setlocal EnableDelayedExpansion
chcp 65001 >nul 2>&1
title ⚡ CONTROL PANEL 2026 v7
mode con: cols=110 lines=45

:: =========================
:: CONFIG
:: =========================
set "server=100.96.49.10"
set "user=root"
set "ftp_host=100.96.49.10"
set "version=7"
set "fg=0E"
set "sound=1"

call :boot
goto main

:: =========================
:: LOG SAFE
:: =========================
:log
goto :eof

:: =========================
:: SOUND - WINDOWS STYLE
:: =========================
:snd
if "%sound%"=="1" powershell -NoProfile -Command "[System.Media.SystemSounds]::Beep.Play()"
goto :eof

:sndok
if "%sound%"=="1" powershell -NoProfile -Command "[System.Media.SystemSounds]::Asterisk.Play()"
goto :eof

:sndstart
if "%sound%"=="1" powershell -NoProfile -Command "[System.Media.SystemSounds]::Exclamation.Play()"
goto :eof

:sndexit
if "%sound%"=="1" powershell -NoProfile -Command "[System.Media.SystemSounds]::Hand.Play()"
goto :eof

:: =========================
:: MAIN (FIXED - NO AUTO BEEP LOOP)
:: =========================
:main
cls
color %fg%

set "timeNow=%time:~0,8%"
set "dateNow=%date%"

echo.
echo ╔════════════════════════════════════════════════════════════════════════════╗
echo ║        ⚡            CONTROL PANEL v%version%                                      ║
echo ╠════════════════════════════════════════════════════════════════════════════╣
echo ║  📅 %dateNow%   ⏰ %timeNow%   🌐 %server%   👤 %user%                   ║
echo ╚════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] 🔐 SSH CONNECT
echo  [2] 📁 FTP OPEN (STABLE)
echo  [3] 📡 PING TEST
echo  [4] ℹ  SYSTEM INFO
echo  [5] 🎨 COLORS
echo  [6] ⚡ WEB
echo  [7] 🌐 LINKS
echo  [8] 🖥  TERMINAL
echo  [9] 📊 STATUS
echo  [0] 🔄 RECONNECT
echo  [X] ❌ EXIT
echo.

choice /c 1234567890xZ /n /t 1 /d Z
set k=%errorlevel%

if %k%==1 goto ssh
if %k%==2 goto ftp
if %k%==3 goto ping
if %k%==4 goto info
if %k%==5 goto colors
if %k%==6 goto web
if %k%==7 goto webmenu
if %k%==8 goto terminal
if %k%==9 goto status
if %k%==10 goto reconnect
if %k%==11 goto exit

goto main

:: =========================
:: SSH (SAFE)
:: =========================
:ssh
call :sndok
cls
echo 🔐 SSH CONNECT
call :log SSH %user%@%server%

ssh %user%@%server%

if errorlevel 1 (
    echo ❌ SSH FAILED
    call :log SSH FAIL
) else (
    echo ✔ SSH CLOSED
    call :log SSH OK
)

pause
goto main

:: =========================
:: FTP (UNCHANGED - IMPORTANT)
:: =========================
:ftp
call :sndok
cls
echo 📁 OPENING FTP...

call :log FTP OPEN %ftp_host%

start explorer.exe "ftp://%ftp_host%/"

echo ✔ FTP OPENED
call :log FTP OK

pause
goto main

:: =========================
:: PING
:: =========================
:ping
call :sndok
cls
echo 📡 PING TEST
ping -n 5 %server%
pause
goto main

:: =========================
:: INFO
:: =========================
:info
call :sndok
cls
echo SYSTEM INFO
echo Server : %server%
echo User   : %user%
echo Version: %version%
echo Log    : %logfile%
pause
goto main

:: =========================
:: COLORS
:: =========================
:colors
call :sndok
cls
echo 🎨 COLORS
echo.
echo 0 Black
echo 1 Blue
echo 2 Green
echo 3 Aqua
echo 4 Red
echo 5 Purple
echo 6 Yellow
echo 7 White
echo 8 Gray
echo 9 Light Blue
echo A Light Green
echo B Light Aqua
echo C Light Red
echo D Light Purple
echo E Light Yellow
echo F Bright White
echo.

set /p fg=Wybierz kolor tła (0-9) i kolor czcionki (A-F) wpisując np. 0A:

call :log COLOR %fg%
goto main

:: =========================
:: WEB
:: =========================
:web
call :sndok
cls
start "" "https://mikolajfiukin.xce.pl/wol_animated_landing.html"
call :log WEB OPEN
pause
goto main

:webmenu
call :sndok
cls
echo 🌐 LINKS
echo [1] WOL
echo [2] TAILSCALE
echo [3] BACK

choice /c 123 /n
set w=%errorlevel%

if %w%==1 start "" "https://mikolajfiukin.xce.pl/wol_animated_landing.html"
if %w%==2 start "" "https://login.tailscale.com/admin/machines"
if %w%==3 goto main

goto webmenu

:: =========================
:: TERMINAL
:: =========================
:terminal
call :sndstart
cls
echo ⚡ POWERSHELL

start "CYBER TERMINAL" powershell -NoExit -Command ^
"cls; Write-Host 'CYBER TERMINAL ONLINE' -ForegroundColor Cyan"

pause
goto main

:: =========================
:: STATUS
:: =========================
:status
call :sndok
cls
echo 📊 STATUS

ping -n 1 %server% >nul
if errorlevel 1 (
    echo ❌ OFFLINE
    call :log OFFLINE
) else (
    echo ✔ ONLINE
    call :log ONLINE
)

pause
goto main

:: =========================
:: RECONNECT
:: =========================
:reconnect
call :sndstart
cls
echo 🔄 RECONNECT

call :log RECONNECT

timeout /t 2 >nul
echo ✔ DONE

pause
goto main

:: =========================
:: EXIT
:: =========================
:exit
call :sndexit
cls
echo SHUTDOWN...
timeout /t 2 >nul
exit

:: =========================
:: BOOT
:: =========================
:boot
cls
call :sndstart
color 0E

echo.
echo CYBER PANEL STARTING...
timeout /t 1 >nul

for %%i in (▁ ▂ ▃ ▄ ▅ ▆ ▇ █) do (
    cls
    echo LOADING SYSTEM...
    echo %%i %%i %%i %%i %%i %%i %%i %%i
    timeout /t 1 >nul
)

cls
echo SYSTEM READY
timeout /t 1 >nul
goto :eof