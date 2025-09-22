#!/bin/bash
cd complete

# Directory containing the files
DIRECTORY="."

# Iterate through each file in the directory
for FILE in "$DIRECTORY"/*; do
    # Check if it's a regular file
    if [ -f "$FILE" ]; then
        # Generate the SHA-256 checksum and save it to a file
        sha256sum "$FILE" > "$FILE.sha256sum"
        echo "Generated SHA-256 checksum for $FILE"
    fi
done
cd ..
exit 0
