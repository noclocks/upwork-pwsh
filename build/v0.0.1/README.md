# Build v0.0.1 - Initial Release

## Overview

This is the initial release of the Startup Automation workflow. This workflow is designed to automate the launching of
pre-configured programs and websites at user logon and on a daily schedule. The workflow is designed to be installed on
a client machine and is intended to be used by a single user.

The workflow is comprised of a PowerShell Script that automates the launching of pre-configured programs and websites,
a Batch Script that calls the PowerShell Script, a Windows Task Scheduler XML configuration file that can be imported
on the client machine to create a task to run the workflow at user logon and on a daily schedule, a PowerShell Data
file serving as configuration for the workflow, and an Installation PowerShell Script to install and configure the
various components of the workflow on the client machine.

Currently the workflow is in a placeholder state and is not fully functional. This is the initial release of the
workflow and is intended to be used as a starting point for further development.

## Configuration

The workflow is configured using the `Configuration.psd1` file. This file is a PowerShell Data file that provides the
ability to customize the programs and websites to be launched, the schedule for the task, toggle on/off trace and debug
logging, and toggle on/off PowerShell transcript logging.

Currently the `Configuration.psd1` file is a placeholder and is set up to launch the following Programs and Websites:

Programs:

- Slack
- Outlook
- Chrome

Websites:

- Three separate instances of [Salesforce](https://www.salesforce.com/)
- [Monday.com](https://www.monday.com/)

The schedule for the task is set to run at user logon and on a daily schedule at 7:30 AM.

Trace and debug logging is currently set to off. If set to on, the default locations for the log files are:

- Trace Log: `%SystemDrive%\StartupAutomation\StartupAutomation.log`
- PowerShell Session Transcript: `%SystemDrive%\StartupAutomation.Transcript.log`

## Included Files

- [StartupAutomation.ps1](StartupAutomation.ps1) PowerShell Script which automates the launching of pre-configured
  programs and websites.

- [StartupAutomation.cmd](StartupAutomation.cmd) Batch Script which launches the PowerShell Script.

- [StartupAutomation.xml](StartupAutomation.xml) (Placeholder) Template Windows Task Scheduler XML file which
  can be imported on client machine to create a task to run the Batch Script at user logon and on a daily schedule.

- [Configuration.psd1](Configuration.psd1) (Placeholder) PowerShell Data file serving as configuration for the workflow
  that provides the ability to customize the programs and websites to be launched, the schedule for the task,
  toggle on/off trace and debug logging, and toggle on/off PowerShell transcript logging.

- [install.ps1](install.ps1) Installation PowerShell Script to install and configure the various components of the
  Startup Automation workflow on the client machine. This script will perform the following:
    - Create a directory for the workflow on the client machine's `%SystemDrive%` (e.g. `C:\StartupAutomation`).
    - Copy the necessary batch and PowerShell scripts to the directory.
    - Copy the placeholder configuration file to the directory.
    - Import the placeholder Windows Task Scheduler XML file to the client machine.
    - Create a scheduled task to run the batch script at user logon and on a daily schedule.
    - Create a shortcut to the batch script on the client machine's desktop that can be used to manually run the workflow.
