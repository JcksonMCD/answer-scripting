#!/bin/bash

# Step 1: Get the API URL from command-line argument or runtime
if [[ "$1" == "--interactive" || "$1" == "-i" ]]; then
  read -p "Enter the API URL: " api_url
else
  api_url="$1"
fi

# If blank, exit script
if [ -z "$api_url" ]; then
  echo "No URL provided. Exiting." >&2
  echo "Usage: $0 <API_URL> or $0 --interactive" >&2
  exit 1
fi

# Print
echo "Using API URL: $api_url"

# Step 2: Make the API call and store the response
response=$(curl -s --fail "$api_url") # --fail returns error code
curl_exit_code=$?

# Check if curl worked, 0 is successful any other code is NOT
if [ $curl_exit_code -ne 0 ] || [ -z "$response" ]; then
  echo "Failed to fetch data from the API (exit code $curl_exit_code)." >&2
  exit 1
fi

echo "API call successful."

# Step 3: Check if jq is installed
if ! command -v jq >/dev/null 2>&1; then
  echo "'jq' is not installed. Please install it and try again." >&2
  exit 1
fi

# Step 4: Sort and print the items by name
echo "Sorted items by name:"
echo "$response" | jq 'sort_by(.name | ascii_downcase)[]' || {
  echo "Failed to parse or sort JSON with jq." >&2
  exit 1
}
