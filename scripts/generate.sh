#!/bin/sh

TEMPLATE="layout/index.html"

# Check if template file exists
if [ ! -f "$TEMPLATE" ]; then
  echo "Error: Template file '$TEMPLATE' not found!"
  exit 1
fi

find content -type f -name '*.md' | while read -r file; do
  # Read the content of the current file
  CONTENT=$(cat "$file")

  # Define the output file name (change extension to .html)
  OUTPUT_FILE="${file%.*}.html"

  # Use awk to replace {{ content }} properly
  awk -v content="$CONTENT" '{gsub(/\{\{ content \}\}/, content)}1' "$TEMPLATE" > "$OUTPUT_FILE"

  echo "Processed: $file -> $OUTPUT_FILE"
done
