#!/bin/bash

# Step 1: Get the file name from command-line argument or runtime
if [[ "$1" == "--interactive" || "$1" == "-i" ]]; then
  read -p "Enter the file name: " filename
else
  filename="$1"
fi

# If blank, exit script
if [ -z "$filename" ]; then
  echo "No file name provided. Exiting." >&2
  echo "Usage: $0 <FILE_NAME> or $0 --interactive" >&2
  exit 1
fi

# Step 2: Initialise directories and find the file path
input_dir="$(pwd)/Input"
output_dir="$(pwd)/Output"
found_path=""

# Use 'find' to locate the file and take the first match
found_path=$(find "$input_dir" -type f -name "$filename" | head -n 1)

if [ -n "$found_path" ]; then
  echo "File found at: $found_path"
else
  echo "File not found in $input_dir" >&2
  exit 1
fi

# Step 3: Print contents of file 
if ! cat "$found_path"; then
  echo "Failed to read contents of $found_path" >&2
  exit 1
fi

# Step 4: Copy the file to Output
mkdir -p "$output_dir"
if ! cp "$found_path" "$output_dir"; then
  echo "Failed to copy $found_path to $output_dir" >&2
  exit 1
fi
echo "File copied to: $output_dir" >&2

# Step 5: Delete the original file
if ! rm "$found_path"; then
  echo "Failed to delete $found_path" >&2
  exit 1
fi
echo "Original file deleted from: $found_path" >&2