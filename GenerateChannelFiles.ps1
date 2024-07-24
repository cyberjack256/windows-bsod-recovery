# Define the base directory
$baseDir = "C:\Windows\System32\drivers\CrowdStrike"

# Ensure the base directory exists
if (-Not (Test-Path -Path $baseDir)) {
    New-Item -ItemType Directory -Path $baseDir
}

# Function to generate random content
function Generate-Content {
    param (
        [int]$size = 1024
    )
    return [byte[]](1..$size | ForEach-Object { Get-Random -Minimum 0 -Maximum 256 })
}

# Function to write content to a file
function Write-File {
    param (
        [string]$filePath,
        [byte[]]$content
    )
    [System.IO.File]::WriteAllBytes($filePath, $content)
}

# Function to set file creation and modification time
function Set-FileTime {
    param (
        [string]$filePath,
        [datetime]$timestamp
    )
    $creationTime = $timestamp
    $lastAccessTime = $timestamp
    $lastWriteTime = $timestamp
    [System.IO.File]::SetCreationTime($filePath, $creationTime)
    [System.IO.File]::SetLastAccessTime($filePath, $lastAccessTime)
    [System.IO.File]::SetLastWriteTime($filePath, $lastWriteTime)
}

# Generate a regular channel file
function Generate-RegularChannelFile {
    param (
        [datetime]$timestamp
    )
    $contentSize = Get-Random -Minimum 512 -Maximum 4096
    $content = Generate-Content -size $contentSize
    $fileNumber = Get-Random -Minimum 1000000 -Maximum 9999999
    $fileName = "C-$fileNumber-00000001-00000$([int](Get-Random * 100000)).sys"
    $filePath = Join-Path -Path $baseDir -ChildPath $fileName
    Write-File -filePath $filePath -content $content
    Set-FileTime -filePath $filePath -timestamp $timestamp
    Write-Output "Regular channel file generated: $filePath"
}

# Generate a bad channel file 291 (by name and timestamp only)
function Generate-BadChannelFile291 {
    $content = Generate-Content -size 1024
    $badTimestamp = Get-Date -Year 2024 -Month 7 -Day 19 -Hour 4 -Minute 9 -Second 0
    $fileName = "C-00000291-00000001.sys"
    $filePath = Join-Path -Path $baseDir -ChildPath $fileName
    Write-File -filePath $filePath -content $content
    Set-FileTime -filePath $filePath -timestamp $badTimestamp
    Write-Output "Bad channel file 291 generated: $filePath"
}

# Main script
$startDate = (Get-Date).AddDays(-10)
$endDate = Get-Date

# Generate 90 regular channel files over the last 10 days
for ($i = 0; $i -lt 90; $i++) {
    $randomTimestamp = Get-Random -Minimum $startDate.Ticks -Maximum $endDate.Ticks
    $fileTimestamp = [datetime]::FromFileTimeUtc($randomTimestamp)
    Generate-RegularChannelFile -timestamp $fileTimestamp
}

# Generate one bad channel file
Generate-BadChannelFile291

Write-Output "Channel file generation completed."