#requires -PSEdition Core

# Collect user input of file name
param ($FileName = $(throw "FileName parameter is required."))

# Search for the file of that name (use try catch for if it is not found)
try {
    $File=Get-ChildItem $FileName -Recurse -File -ErrorAction SilentlyContinue
}
catch {
    Console.WriteLine($"This file does not exist");
}

Set-Location $File.DirectoryName

# Copy file contents
$FileText = Get-Content $FileName

# Print contents to console
Write-Output $FileText

# Print contents to a new file in the output folder
Out-File -Force -Path "C:\Users\JacksonMacDonald\Documents\Answer Academy\Scripting\answer-scripting\Task1\Output\$FileName" -Encoding UTF8 -InputObject $FileText

# Delete old file
Remove-Item $File
