# Ensure PowerShell is running as Administrator

# Directory to create the files in
$directoryPath = "C:\Windows\System32\drivers\CrowdStrike"
if (-Not (Test-Path -Path $directoryPath)) {
    New-Item -Path $directoryPath -ItemType Directory -Force
}

# Define the good and bad timestamps
$goodTimestamp = Get-Date -Year 2024 -Month 7 -Day 19 -Hour 5 -Minute 27 -Second 0
$badTimestamp = Get-Date -Year 2024 -Month 7 -Day 19 -Hour 4 -Minute 9 -Second 0

# Define the number of good files and one bad file
$numGoodFiles = 10
$files = @()

# Add good files
for ($i = 1; $i -le $numGoodFiles; $i++) {
    $files += @{Name = "C-00000291-$i.sys"; Timestamp = $goodTimestamp}
}

# Add the bad file
$files += @{Name = "C-00000291-Bad.sys"; Timestamp = $badTimestamp}

# Function to log messages
function Log-Message {
    param (
        [string]$message
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "$timestamp - $message"
    Write-Output $logMessage
}

# Loop through each file definition and create/timestomp the file
foreach ($file in $files) {
    $filePath = "$directoryPath\$($file.Name)"
    $timestamp = $file.Timestamp

    # Create the fake file
    New-Item -Path $filePath -ItemType File -Force

    # Set the file's creation, modification, and access times
    (Get-Item $filePath).CreationTime = $timestamp
    (Get-Item $filePath).LastWriteTime = $timestamp
    (Get-Item $filePath).LastAccessTime = $timestamp

    Log-Message "Fake file '$($file.Name)' created and timestomped successfully."
}

Log-Message "All files created and timestomped successfully."