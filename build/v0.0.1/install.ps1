<#
    Installation script for StartupAutomation.ps1
#>

# Copy the scripts to the installation directory
$InstallDir = 'C:\StartupAutomation'

$PSScriptPath = Join-Path -Path $InstallDir -ChildPath 'StartupAutomation.ps1'
$CmdScriptPath = Join-Path -Path $InstallDir -ChildPath 'StartupAutomation.cmd'

if (-not (Test-Path -Path $InstallDir -PathType Container)) {
    New-Item -Path $InstallDir -ItemType Directory | Out-Null
}

Copy-Item -Path $PSScriptRoot\StartupAutomation.ps1 -Destination $PSScriptPath -Force
Copy-Item -Path $PSScriptRoot\StartupAutomation.cmd -Destination $CmdScriptPath -Force

# Create a Shortcut (.lnk) file for the script
$WshShell = New-Object -ComObject WScript.Shell
$ShortcutDir = [System.Environment]::GetFolderPath('DesktopDirectory')

if (Test-Path -Path "$ShortcutDir\StartupAutomation.lnk") {
    Remove-Item -Path "$ShortcutDir\StartupAutomation.lnk" -Force
}

$Shortcut = $WshShell.CreateShortcut("$ShortcutDir\StartupAutomation.lnk")
$Shortcut.TargetPath = 'C:\StartupAutomation\StartupAutomation.cmd'
$Shortcut.Save()

# TODO: Import / Create Scheduled Task
# New-ScheduledTask -Action "C:\StartupAutomation\StartupAutomation.cmd"
