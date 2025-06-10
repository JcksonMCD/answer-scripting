#requires -PSEdition Core

# Collect user input of file name
param (
    [Parameter(Mandatory = $true)]
    [string]$FileName
)

# Search for the file of that name (use try catch for if it is not found)
Set-Location C:

try {
    $File = Get-ChildItem -Path . -Filter $FileName -Recurse -ErrorAction Stop | Select-Object -First 1
} catch {
    Write-Error "File '$FileName' not found."
    exit 1
}

if (-not $File) {
    Write-Error "File '$FileName' not found."
    exit 1
}

Set-Location $File.DirectoryName

# Copy file contents
$FileText = Get-Content $File.Name

# Print contents to console
Write-Output $FileText

# Navigate out of Input folder to Task 1 directory
Set-Location ..
Set-Location ..

# Create Output directory if it doesn't exist
if (-not (Test-Path "Output")) {
    New-Item -Name "Output" -ItemType Directory | Out-Null
}
Set-Location "Output"

# Print contents to a new file in the output folder
try {
    Out-File -Force -Path $FileName -Encoding UTF8 -InputObject $FileText
}
catch {
    Write-Error "Error while creating new file"
}

# Delete the original file
try {
    Remove-Item -Path "$($File.DirectoryName)\$($File.Name)" -Force
}
catch {
    Write-Error "Error while deleting the original file"
}