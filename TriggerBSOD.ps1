# Check if running as Administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Output "This script must be run as Administrator."
    exit
}

# Enable BSOD via keyboard (Right Ctrl + Scroll Lock + Scroll Lock)
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\kbdhid\Parameters"
$regName = "CrashOnCtrlScroll"
$regValue = 1

# Create the registry key if it does not exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force
}

# Set the registry value
Set-ItemProperty -Path $regPath -Name $regName -Value $regValue

Write-Output "Registry entry added to enable BSOD via keyboard (Right Ctrl + Scroll Lock + Scroll Lock)."
Write-Output "Reboot your system for the changes to take effect."