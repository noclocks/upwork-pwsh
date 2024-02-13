
<#PSScriptInfo

.VERSION 1.0

.GUID 86a190f0-b778-40e7-bd67-437dbf4c2430

.AUTHOR Jimmy Briggs

.COMPANYNAME No Clocks, LLC

.COPYRIGHT No Clocks, LLC 2024

.TAGS Startup, Automation, URL, Browser, Launch, Program, Task, Script

.LICENSEURI https://github.com/noclocks/upwork-pwsh/blob/main/LICENSE

.PROJECTURI https://github.com/noclocks/upwork-pwsh

.ICONURI

.EXTERNALMODULEDEPENDENCIES

.REQUIREDSCRIPTS

.EXTERNALSCRIPTDEPENDENCIES

.RELEASENOTES

    - Version 0.0.1: Initial release of the script.

.PRIVATEDATA

#>

<#
.SYNOPSIS
    This script automates various tasks such as launching programs on startup and launching URLs in the default browser.
.DESCRIPTION
    This script automates various tasks such as launching programs on startup and launching URLs in the default browser.
.PARAMETER Programs
    An array of programs to launch on startup. These should be full paths to the executable files.
.PARAMETER URLs
    An array of URLs to launch in the default browser. These should be fully qualified URLs, including the protocol
    (e.g., http:// or https://).
.PARAMETER UseConfig
    A switch parameter that indicates whether to use a configuration file to load the Programs and URLs parameters.
.EXAMPLE
    $Programs = @(
        "C:\Program Files\MyProgram\MyProgram.exe",
        "C:\Program Files\AnotherProgram\AnotherProgram.exe"
    )

    $URLs = @(
        "https://www.google.com",
        "https://www.bing.com"
    )

    .\StartupAutomation.ps1 -Programs $Programs -URLs $URLs

    This example will launch the specified programs on startup and open the specified URLs in the default browser.
.EXAMPLE
    .\StartupAutomation.ps1 -UseConfig

    This example will use a configuration file to load the Programs and URLs parameters.
.NOTES
    File Name      : StartupAutomation.ps1
    Author         : Jimmy Briggs
    Prerequisite   : PowerShell V5.1
#>
Param(
    [String[]]$Programs,
    [String[]]$URLs,
    [Switch]$UseConfig,
    [String]$ConfigPath,
    [Switch]$Log,
    [String]$LogPath,
    [Switch]$Transcript,
    [String]$TranscriptPath
)

Function Write-Log {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)]
        [String]$Message
    )
    if ($Log) {
        $LogPath = Join-Path -Path $PSScriptRoot -ChildPath 'StartupAutomation.log'
        $Message = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - $Message"
        $Message | Out-File -FilePath $LogPath -Append
    }
}

Function Get-Config {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)]
        [String]$ConfigPath
    )
    Write-Verbose "Loading configuration from: $ConfigPath"
    $Config = Import-PowerShellDataFile -Path $ConfigPath
    return $Config
}

Function Start-Program {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)]
        [ValidateScript({ Test-Path $_ -PathType Leaf })]
        [String]$Program
    )
    Write-Verbose "Launching program: $Program"
    Start-Process -FilePath $Program | Out-Null
}

Function Start-URL {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_ -match '^http://|^https://' })]
        [String]$URL
    )
    Write-Verbose "Launching URL: $URL"
    Start-Process $URL
}

if ($UseConfig) {
    $ConfigPath = Join-Path -Path $PSScriptRoot -ChildPath 'Configuration.psd1'
    $Config = Get-Config -ConfigPath $ConfigPath
    $Programs = $Config.Programs
    $URLs = $Config.URLs
} else {
    if (-not $Programs -and -not $URLs) {
        Write-Error 'You must specify either the Programs or URLs parameter, or use the UseConfig switch.'
        Exit
    }
}

if ($Transcript) {
    Write-Verbose "Starting transcript: $TranscriptPath"
    $TranscriptPath = (Join-Path -Path $PSScriptRoot -ChildPath 'StartupAutomation.Transcript.log')
    Start-Transcript -Path $TranscriptPath
}

if ($Log) {
    Write-Verbose "Logging to: $LogPath"
    $LogPath = (Join-Path -Path $PSScriptRoot -ChildPath 'StartupAutomation.log')
    Write-Log -Message 'Starting StartupAutomation.ps1'
    Write-Log -Message "Programs: $($Programs -join ', ')"
    Write-Log -Message "URLs: $($URLs -join ', ')"
}

ForEach ($Program in $Programs) {
    Start-Program -Program $Program
}

ForEach ($URL in $URLs) {
    Start-URL -URL $URL
}
