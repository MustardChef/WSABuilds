@echo off
cd "%~dp0"
if not exist Install.ps1 (
    echo "Install.ps1" is not found.
    echo Press any key to exit
    pause>nul
    exit 1
)
start powershell.exe -ExecutionPolicy Bypass -File .\Install.ps1
exit
