@echo off
echo "Initializing StartupAutomation"

REM SourcePath: build/v0.0.1/StartupAutomation.cmd
REM InstallPath: C:\StartupAutomation\StartupAutomation.cmd

REM This script is used to automate the startup of the applications and URLs

REM Call the powershell script
powershell -ExecutionPolicy Bypass -File "C:\StartupAutomation\StartupAutomation.ps1"
