# Recovery Support for Ongoing Outage

This repository is in support of recovery videos for the ongoing outage. It contains scripts to generate regular and bad channel files and to trigger a BSOD for testing purposes.

## Channel File Generation Script

This script generates 90 regular channel files and one bad channel file in the CrowdStrike directory on a Windows system. These files simulate AV signature updates for the Falcon sensor.

### Prerequisites

- Windows operating system with PowerShell.
- Administrative privileges to write to C:\Windows\System32\drivers\CrowdStrike.

### Instructions

1. **Download the Scripts**

   You can download the scripts directly or copy the content into .ps1 files.

   **Option 1: Download using curl**
```Powershell
curl -O https://github.com/cyberjack256/windows-bsod-recovery/GenerateChannelFiles.ps1
curl -O https://github.com/cyberjack256/windows-bsod-recovery/TriggerBSOD.ps1
```

**Option 2: Copy and Save**
Copy the script content and save them as GenerateChannelFiles.ps1 and TriggerBSOD.ps1 using any text editor.

2. **Run PowerShell as Administrator**

- Click on the Start menu.
- Type PowerShell.
- Right-click on Windows PowerShell and select Run as administrator.

3. **Set Execution Policy**

Set the execution policy to bypass for the current process to allow script execution.

```Powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

4. **Run the Scripts**

Navigate to the directory where you saved the scripts and run them.

**Generate Channel Files**
```Powershell
.\GenerateChannelFiles.ps1
```

The script will generate 90 regular channel files and one bad channel file in the C:\Windows\System32\drivers\CrowdStrike directory.

## BSOD Trigger Setup Script
**Trigger BSOD**

```Powershell
.\TriggerBSOD.ps1
```

This script will add a registry entry to enable triggering a BSOD using the keyboard combination (Right Ctrl + Scroll Lock + Scroll Lock). Reboot your system for the changes to take effect.

## Script Explanation

- **Generate-Content**: Generates random data of specified size.
- **Write-File**: Writes the generated content to a file.
- **Set-FileTime**: Sets the creation, access, and modification times for the file to the specified timestamp.
- **Generate-RegularChannelFile**: Creates a regular channel file with a random size and timestamp.
- **Generate-BadChannelFile291**: Creates a bad channel file with a specified timestamp (July 19, 2024, 04:09 UTC) without corrupting the content.
- **TriggerBSOD.ps1**: Adds a registry entry that allows triggering a BSOD using the keyboard combination (Right Ctrl + Scroll Lock + Scroll Lock).
- The main script generates 90 regular channel files over the past 10 days and one bad channel file.

## Notes

- Ensure you have the necessary permissions to write to the specified directory.
- The script adds unique timestamps to each file name to ensure uniqueness.
- Running `TriggerBSOD.ps1` requires a system reboot for the changes to take effect.

For further assistance with the outage visit [CrowdStrike](https://www.crowdstrike.com).
