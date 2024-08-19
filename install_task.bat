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

cd %~dp0

mkdir "%LOCALAPPDATA%\screamhotkeyrecevier" > NUL
copy hotkeyreceiver.ps1 "%LOCALAPPDATA%\screamhotkeyrecevier\hotkeyreceiver.ps1" > NUL

:: Prepare the command with parameters
set COMMAND=%%LOCALAPPDATA%%\screamhotkeyrecevier\hotkeyreceiver.ps1

:: Create the scheduled task with parameters
schtasks /create /tn "RunScreamHotkeyReceiver" /tr "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe %COMMAND%" /sc onlogon /rl highest /f

if %errorlevel% equ 0 (
    echo Scheduled task created successfully.
    schtasks /run /tn "RunScreamHotkeyReceiver"
    echo Scheduled task created successfully with the following parameters:
    echo Port: %TARGET_PORT%
    if %errorlevel% equ 0 (    

        echo Scheduled task created successfully.
        echo Scheduled task started successfully.
    ) else (
        echo Failed to start the scheduled task.
    )
) else (
    echo Failed to create the scheduled task.
)

pause
