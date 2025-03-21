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

  DOC_TITLE=$(echo "$CONTENT" | grep -m 1 '^# ' | sed 's/^# //')

  # Define the output file name (change extension to .html)
  OUTPUT_FILE="${file%.*}.html"

  # Use awk to replace {{ content }} properly
  awk -v content="$CONTENT" -v title="$DOC_TITLE" '
    {gsub(/\{\{ docTitle \}\}/, title)}
    {gsub(/\{\{ content \}\}/, content)}
    {print}
  ' "$TEMPLATE" > "$OUTPUT_FILE"

  echo "Processed: $file -> $OUTPUT_FILE"
done
