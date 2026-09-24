@echo off
setlocal

:: ============================================================================
:: CONFIGURATION:
:: Change the letter inside the quotes below if your e-Reader / Kobo uses a 
:: different drive letter (e.g., set "DRIVE_LETTER=F:").
:: ============================================================================
set "DRIVE_LETTER=E:"


:: Validate drive letter formatting
if "%DRIVE_LETTER:~-1%" neq ":" set "DRIVE_LETTER=%DRIVE_LETTER%:"

:: Verify target drive exists
if not exist "%DRIVE_LETTER%\" (
    echo.
    echo [ERROR] Drive %DRIVE_LETTER% was not found or is not connected.
    echo Please check the connection or update the DRIVE_LETTER variable in this script.
    echo.
    pause
    exit /b 1
)

:: Set source and destination paths
set "SRC=%~dp0dynamic_panelzoom.koplugin"
set "DEST=%DRIVE_LETTER%\.adds\koreader\plugins\dynamic_panelzoom.koplugin"

echo.
echo ==========================================
echo   Dynamic PanelZoom Plugin Installer
echo ==========================================
echo.
echo Target Drive: %DRIVE_LETTER%
echo Source:      "%SRC%"
echo Destination: "%DEST%"
echo.
echo Copying files...
echo.

robocopy "%SRC%" "%DEST%" /E /NJH /NJS /NDL /NC /NS
set "RC=%ERRORLEVEL%"

echo.

if %RC% LEQ 7 (
    echo [SUCCESS] All files were copied successfully!
    echo Robocopy exit code: %RC%
    
    echo.
    echo Ejecting drive %DRIVE_LETTER%...
    timeout /t 2 /nobreak >nul
    powershell -Command "$drive = Get-WmiObject Win32_Volume -Filter \"DriveLetter='%DRIVE_LETTER%'\"; $drive.DriveLetter = $null; $drive.Put()" 2>nul || powershell -Command "(New-Object -ComObject Shell.Application).NameSpace(17).ParseName('%DRIVE_LETTER%').InvokeVerb('Eject')"
) else (
    echo [ERROR] Copy failed!
    echo Robocopy exit code: %RC%
    echo.
    echo Please check if drive %DRIVE_LETTER% is connected.
)

echo.
echo ==========================================
echo   Copy operation finished.
echo ==========================================
echo.
echo Press any key to close this window...
pause >nul

exit