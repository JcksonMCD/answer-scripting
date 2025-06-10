# Step 1: Input the file path
param (
    [string]$InputPath,
    [switch]$Interactive
)

# If interactive flag is used, ask the user
if ($Interactive) {
    $InputPath = Read-Host "Enter the path to the input JSON file"
}

# If still no input, show error and exit
if (-not $InputPath) {
    Write-Error "No input path provided. Use -Interactive or provide a file path directly."
    exit 1
}

# Check file existence
if (-not (Test-Path $InputPath)) {
    Write-Error "File not found at path: $InputPath"
    exit 1
}

# Step 2: Try reading and parsing the file
try {
    $jsonData = Get-Content $InputPath -Raw | ConvertFrom-Json
} catch {
    Write-Error "Failed to read or parse JSON file: $_"
    exit 1
}

# Step 3: Perform the calculations

# Initialise result - Creates empty hash table to hold all results
$result = @{}

# Calculate addition
try {
    if ($jsonData.add) {
        $result.add = ($jsonData.add | Measure-Object -Sum).Sum
    }
} catch {
    Write-Warning "Failed to calculate addition: $_"
}

# Calculate subtraction
try {
    if ($jsonData.minus -and $jsonData.minus.Count -gt 0) {
        $first = $jsonData.minus[0]
        $rest = $jsonData.minus[1..($jsonData.minus.Count - 1)]

        foreach ($num in $rest) {
            $first -= $num
        }

        $result.minus = $first
    }
} catch {
    Write-Warning "Failed to calculate subtraction: $_"
}

# Calculate multiplication
try {
    if ($jsonData.times) {
        $product = 1
        foreach ($n in $jsonData.times) {
            $product *= $n
        }
        $result.times = $product
    }
} catch {
    Write-Warning "Failed to calculate multiplication: $_"
}

# Step 4: Normalise result keys to lowercase
$normalisedResult = @{}
foreach ($key in $result.Keys) {
    $normalisedResult[$key.ToLower()] = $result[$key]
}

# Step 5: Write to output JSON file
try {
    $outputPath = "output-calculations.json"
    $normalisedResult | ConvertTo-Json -Depth 2 | Out-File -Encoding UTF8 $outputPath
    Write-Host "Results written to $outputPath"
} catch {
    Write-Error "Failed to write to output file: $_"
    exit 1
}