@echo off
title Windows Repair Toolkit by By Devon Sumbry , version 0.1b
color 0A

:MAIN_MENU
cls
echo ================================
echo   Windows Repair Tool
echo ================================
echo.
echo 1. DISM
echo 2. SFC
echo 3. Manage-bde
echo 4. DiskPart
echo 5. OOBE
echo 6. Run a CMD Command
echo 7. Exit
echo.
set /p choice=Select an option: 

if "%choice%"=="1" goto DISM_MENU
if "%choice%"=="2" goto SFC_MENU
if "%choice%"=="3" goto BDE_MENU
if "%choice%"=="4" goto DISKPART_MENU
if "%choice%"=="5" goto OOBE_MENU
if "%choice%"=="6" goto CUSTOM_CMD
if "%choice%"=="7" exit

goto MAIN_MENU

:: ---------------- DISM ----------------
:DISM_MENU
cls
echo ===== DISM Options =====
echo 1. CheckHealth
echo 2. ScanHealth
echo 3. RestoreHealth
echo.
set /p dismchoice=Select option: 

if "%dismchoice%"=="1" (
    set cmd=dism /online /cleanup-image /checkhealth
    set desc=Checks if Windows image is corrupted (quick check)
)
if "%dismchoice%"=="2" (
    set cmd=dism /online /cleanup-image /scanhealth
    set desc=Scans Windows image for corruption (detailed)
)
if "%dismchoice%"=="3" (
    set cmd=dism /online /cleanup-image /restorehealth
    set desc=Repairs Windows image using Windows Update
)

goto CONFIRM

:: ---------------- SFC ----------------
:SFC_MENU
cls
echo ===== SFC Options =====
echo 1. Scan Now
echo 2. Verify Only
echo.
set /p sfcchoice=Select option: 

if "%sfcchoice%"=="1" (
    set cmd=sfc /scannow
    set desc=Scans and repairs system files
)
if "%sfcchoice%"=="2" (
    set cmd=sfc /verifyonly
    set desc=Checks system files without repairing
)

goto CONFIRM

:: ---------------- BitLocker ----------------
:BDE_MENU
cls
echo ===== Manage-bde Options =====
echo 1. Status
echo 2. Turn Off BitLocker
echo.
set /p bdechoice=Select option: 

if "%bdechoice%"=="1" (
    set cmd=manage-bde -status
    set desc=Shows encryption status of all drives
)
if "%bdechoice%"=="2" (
    set cmd=manage-bde -off C:
    set desc=Disables BitLocker on drive C:
)

goto CONFIRM

:: ---------------- DiskPart ----------------
:DISKPART_MENU
cls
echo ===== DiskPart =====
echo This will open DiskPart interactive mode.
echo.
set cmd=diskpart
set desc=Opens disk partition management tool

goto CONFIRM

:: ---------------- OOBE ----------------
:OOBE_MENU
cls
echo ===== OOBE =====
echo.
set cmd=%windir%\system32\oobe\msoobe.exe
set desc=Launches Windows Out-of-Box Experience setup

goto CONFIRM

:: ---------------- Custom Command ----------------
:CUSTOM_CMD
cls
echo ===== Custom CMD =====
echo Enter your command:
set /p usercmd=
set cmd=%usercmd%
set desc=Runs a custom command entered by user

goto CONFIRM

:: ---------------- Confirmation ----------------
:CONFIRM
cls
echo ================================
echo Command Explanation:
echo %desc%
echo.
echo Command:
echo %cmd%
echo ================================
echo.
echo Enter CMD mode after execution.
echo Do not close the window unless prompted.
echo.
set /p confirm=Run this command? (Y/N): 

if /i "%confirm%"=="Y" goto RUN_CMD
if /i "%confirm%"=="N" exit

goto CONFIRM

:: ---------------- Execute ----------------
:RUN_CMD
cls
echo Running command...
echo ================================
%cmd%
echo ================================
echo.
pause
goto MAIN_MENU