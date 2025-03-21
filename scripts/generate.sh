#!/bin/sh

TEMPLATE="layout/index.html"

# Check if template file exists
if [ ! -f "$TEMPLATE" ]; then
  echo "Error: Template file '$TEMPLATE' not found!"
  exit 1
fi

find content -type f | while read -r file; do
  # Read the content of the current file
  CONTENT=$(cat "$file")

  # Replace {{ content }} with the file's content inside the template
  OUTPUT=$(sed "s|{{ content }}|$CONTENT|g" "$TEMPLATE")

  # Define the output file name (change extension to .html)
  OUTPUT_FILE="${file%.*}.html"

  # Write the new file
  echo "$OUTPUT" > "$OUTPUT_FILE"

  echo "Processed: $file -> $OUTPUT_FILE"
done
