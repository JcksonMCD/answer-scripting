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
