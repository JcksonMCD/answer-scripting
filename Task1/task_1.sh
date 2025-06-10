#!/bin/bash

# Step 1: Get the filename from command-line argument or runtime
if [[ "$1" == "--interactive" || "$1" == "-i" ]]; then
  read -p "Enter the API URL: " api_url
else
  api_url="$1"
fi

# If blank, exit script
if [ -z "$api_url" ]; then
  echo "No filename provided. Exiting." >&2
  exit 1
fi

