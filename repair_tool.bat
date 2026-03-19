@echo off
title Windows Repair Toolkit by By Devon Sumbry , version 0.2b
color 0A 
:MAIN_MENU
cls
echo ==================================
echo        Windows Repair Toolkit
echo ==================================
echo.
echo 1. DISM (Image Repair)
echo 2. SFC (System File Checker)
echo 3. CHKDSK (Disk Check)
echo 4. Manage-bde (BitLocker)
echo 5. DiskPart - Beta
echo 6. Network Repairs
echo 7. System Reset Tools
echo 8. Run Custom CMD Command
echo 9. Exit
echo.
set /p choice=Select an option: 

if "%choice%"=="1" goto DISM_MENU
if "%choice%"=="2" goto SFC_MENU
if "%choice%"=="3" goto CHKDSK_MENU
if "%choice%"=="4" goto BDE_MENU
if "%choice%"=="5" goto DISKPART_MENU
if "%choice%"=="6" goto NETWORK_MENU
if "%choice%"=="7" goto RESET_MENU
if "%choice%"=="8" goto CUSTOM_CMD
if "%choice%"=="9" exit

goto MAIN_MENU

:: ---------------- DISM ----------------
:DISM_MENU
cls
echo ===== DISM =====
echo 1. CheckHealth
echo 2. ScanHealth
echo 3. RestoreHealth
echo.
set /p opt=

if "%opt%"=="1" (
set cmd=dism /online /cleanup-image /checkhealth
set desc=Quick check for Windows image corruption
)
if "%opt%"=="2" (
set cmd=dism /online /cleanup-image /scanhealth
set desc=Detailed scan for corruption
)
if "%opt%"=="3" (
set cmd=dism /online /cleanup-image /restorehealth
set desc=Repairs Windows image
)

goto CONFIRM

:: ---------------- SFC ----------------
:SFC_MENU
cls
echo ===== SFC =====
echo 1. Scan Now
echo 2. Verify Only
echo.
set /p opt=

if "%opt%"=="1" (
set cmd=sfc /scannow
set desc=Scans and repairs system files
)
if "%opt%"=="2" (
set cmd=sfc /verifyonly
set desc=Checks files without repair
)

goto CONFIRM

:: ---------------- CHKDSK ----------------
:CHKDSK_MENU
cls
echo ===== CHKDSK =====
echo 1. Scan Only 
echo 2. Fix Errors
echo 3. Fix + Recover Bad Sectors
echo.
set /p opt=

if "%opt%"=="1" (
set cmd=chkdsk C:
set desc=Scans disk for errors (read-only)
)
if "%opt%"=="2" (
set cmd=chkdsk C: /f
set desc=Fixes disk errors (may require reboot)
)
if "%opt%"=="3" (
set cmd=chkdsk C: /f /r
set desc=Fixes errors and recovers bad sectors (slow)
)

goto CONFIRM

:: ---------------- BitLocker ----------------
:BDE_MENU
cls
echo ===== BitLocker =====
echo 1. Status
echo 2. Turn Off C:
echo.
set /p opt=

if "%opt%"=="1" (
set cmd=manage-bde -status
set desc=Shows encryption status
)
if "%opt%"=="2" (
set cmd=manage-bde -off C:
set desc=Disables BitLocker on C:
)

goto CONFIRM

:: ---------------- DiskPart ----------------
:DISKPART_MENU
cls
set cmd=diskpart
set desc=Opens disk partition tool

goto CONFIRM

:: ---------------- NETWORK ----------------
:NETWORK_MENU
cls
echo ===== Network Repairs =====
echo 1. Flush DNS
echo 2. Release IP
echo 3. Renew IP
echo 4. Winsock Reset
echo 5. Reset TCP/IP Stack
echo 6. Full Network Reset (All)
echo.
set /p opt=

if "%opt%"=="1" (
set cmd=ipconfig /flushdns
set desc=Clears DNS cache
)
if "%opt%"=="2" (
set cmd=ipconfig /release
set desc=Releases IP address
)
if "%opt%"=="3" (
set cmd=ipconfig /renew
set desc=Renews IP address
)
if "%opt%"=="4" (
set cmd=netsh winsock reset
set desc=Resets Winsock (fixes network issues)
)
if "%opt%"=="5" (
set cmd=netsh int ip reset
set desc=Resets TCP/IP stack
)
if "%opt%"=="6" (
set cmd=netsh winsock reset ^&^& netsh int ip reset ^&^& ipconfig /flushdns
set desc=Performs full network reset
)

goto CONFIRM

:: ---------------- SYSTEM RESET ----------------
:RESET_MENU
cls
echo ===== System Tools =====
echo 1. OOBE Setup - Will Break OS
echo 2. System File Cleanup
echo 3. Check Windows Activation
echo 4. Open System Restore
echo.
set /p opt=

if "%opt%"=="1" (
set cmd=%windir%\system32\oobe\msoobe.exe
set desc=Launch Windows setup experience
)
if "%opt%"=="2" (
set cmd=cleanmgr
set desc=Opens disk cleanup tool
)
if "%opt%"=="3" (
set cmd=slmgr /xpr
set desc=Shows activation status
)
if "%opt%"=="4" (
set cmd=rstrui
set desc=Opens System Restore
)

goto CONFIRM

:: ---------------- CUSTOM ----------------
:CUSTOM_CMD
cls
echo Enter your command:
set /p usercmd=
set cmd=%usercmd%
set desc=Custom user command

goto CONFIRM

:: ---------------- CONFIRM ----------------
:CONFIRM
cls
echo ==================================
echo Description: Runs your command once.
echo %desc%
echo.
echo Command:
echo %cmd%
echo ==================================
echo.
set /p confirm=Run this command? (Y/N): 

if /i "%confirm%"=="Y" goto RUN
if /i "%confirm%"=="N" exit

goto CONFIRM

:: ---------------- RUN ----------------
:RUN
cls
echo Running...
echo ==================================
%cmd%
echo ==================================
echo.
pause
goto MAIN_MENU
