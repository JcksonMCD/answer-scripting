#requires -PSEdition Core

# Collect user input of file name
param (
    [Parameter(Mandatory = $true)]
    [string]$FileName
)

# Get the script's directory
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

try {
    $File = Get-ChildItem -Path $ScriptDir -Filter $FileName -Recurse -ErrorAction Stop | Select-Object -First 1
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
$FileText = Get-Content $File.FullName

# Print contents to console
Write-Output $FileText

# Create Output directory if it doesn't exist
$OutputDir = Join-Path $ScriptDir "Output"
if (-not (Test-Path $OutputDir)) {
    New-Item -Path $OutputDir -ItemType Directory | Out-Null
}

# Write contents to a new file in the Output folder
$OutputPath = Join-Path $OutputDir $File.Name
try {
    Out-File -Force -Path $OutputPath -Encoding UTF8 -InputObject $FileText
}
catch {
    Write-Error "Error while creating new file"
    Exit 1
}

# Delete the original file
try {
    Remove-Item -Path $File.FullName -Force
}
catch {
    Write-Error "Error while deleting the original file"
    Exit 1
}