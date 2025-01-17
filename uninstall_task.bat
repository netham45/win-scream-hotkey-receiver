@echo off

:: Check for admin privileges
net session >nul 2>&1
if %errorLevel% == 0 (
    goto :admin
) else (
    echo Requesting administrative privileges...
    goto :elevate
)

:elevate
:: Self-elevate the script if not already running as admin
powershell -Command "Start-Process cmd -Verb RunAs -ArgumentList '/c %~dpnx0 %*'"
exit /b

:admin
echo Running with administrative privileges.

schtasks /End /TN "RunScreamHotkeyReceiver"
schtasks /Delete /TN "RunScreamHotkeyReceiver" /F
if %errorLevel% == 0 (
    echo Scheduled task "RunScreamHotkeyReceiver" has been successfully removed.
) else (
    echo Failed to remove scheduled task "RunScreamHotkeyReceiver". It may not exist or there was an error.
)


echo Script execution completed.
pause
