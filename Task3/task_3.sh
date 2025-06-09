#!/bin/bash

# If arg of path not passed in throw err and ask for it
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <file-path>" >&2
    exit 1
fi
# Define the input file path as arg passed in by user
INFILE="$1"

# Initialize totals for counters
ADD_TOTAL=0
MINUS_TOTAL=0
TIMES_TOTAL=1

# Iterate through each operation
for OPERATION in $(jq -r 'keys[]' "$INFILE"); do
# For each value in the array under that key
    for VALUE in $(jq -r --arg key "$OPERATION" '.[$key][]' "$INFILE"); do
        case $OPERATION in
            "Add")
                ADD_TOTAL=$((ADD_TOTAL + VALUE))
                ;;
            "Minus")
                MINUS_TOTAL=$((MINUS_TOTAL - VALUE))
                ;;
            "Times")
                TIMES_TOTAL=$((TIMES_TOTAL * VALUE))
                ;;
        esac
    done
done

# Create a JSON output string using jq library
JSON_STRING=$(jq -n \
  --arg add "$ADD_TOTAL" \
  --arg minus "$MINUS_TOTAL" \
  --arg times "$TIMES_TOTAL" \
  '{add_total: $add, minus_total: $minus, times_total: $times}')

# Output to file
echo "$JSON_STRING" > output-calculations.json
