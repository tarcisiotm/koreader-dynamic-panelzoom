@echo off
setlocal

:: Set the source directory to dynamic_panelzoom.koplugin inside the script's current folder
set "SRC=%~dp0dynamic_panelzoom.koplugin"

set "DEST=E:\.adds\koreader\plugins\dynamic_panelzoom.koplugin"

echo.
echo ==========================================
echo   Dynamic PanelZoom Plugin Installer
echo ==========================================
echo.
echo Source:
echo   "%SRC%"
echo.
echo Destination:
echo   "%DEST%"
echo.
echo Copying files...
echo.

robocopy "%SRC%" "%DEST%" /E /NJH /NJS /NDL /NC /NS
set "RC=%ERRORLEVEL%"

echo.

if %RC% LEQ 7 (
    echo [SUCCESS] All files were copied successfully!
    echo Robocopy exit code: %RC%
) else (
    echo [ERROR] Copy failed!
    echo Robocopy exit code: %RC%
    echo.
    echo Please check if drive E: is connected.
)

echo.
echo ==========================================
echo   Copy operation finished.
echo ==========================================
echo.
echo Press any key to close this window...
pause >nul

exit