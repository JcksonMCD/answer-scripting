# Define the API URL
$apiUrl = Read-Host "Enter API URL"

try {
    # Make the API call
    $response = Invoke-RestMethod -Uri $apiUrl -Method Get

if($response -isnot [System.Collections.IEnumerable]){
    Write-Error "Unexpected response." 
    exit
}

    $sortedList = $response | Sort-Object -Property Name

    $sortedList | ForEach-Object {
        Write-Output $_
    }
}
catch {
    Write-Error "Failed to fetch data from API: $_"
}