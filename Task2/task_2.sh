#!/bin/bash

# Step 1: Ask user for the API URL
read -p "Enter the API URL: " api_url

# If blank exit script
if [ -z "$api_url" ]; then
  echo "No URL provided. Exiting."
  exit 1
fi                                          # Closing if statement - bash way of doing if statements

# Print
echo "You entered: $api_url"

# Step 2: Make the API call and store the response
response=$(curl -s "$api_url")

# Check if curl worked
if [ $? -ne 0 ] || [ -z "$response" ]; then
  echo "Failed to fetch data from the API."
  exit 1
fi

echo "API call successful."

# Step 3: Sort and print the items by name
echo "Sorted items by name:"
echo "$response" | jq 'sort_by(.name | ascii_downcase)[]'