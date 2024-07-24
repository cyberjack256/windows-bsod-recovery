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

For further assistance, please contact your support team.