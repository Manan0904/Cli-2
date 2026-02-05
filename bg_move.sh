#!/bin/bash

if [ -z "$1" ]; then echo "Provide directory path"; exit 1; fi
dir="$1"
mkdir -p "$dir/backup"

echo "Moving files from $dir to $dir/backup..."

for file in "$dir"/*; do
    # Ensure we don't move the backup folder itself
    if [ -f "$file" ]; then
        mv "$file" "$dir/backup/" &
        echo "Started process PID: $!"
    fi
done

wait
echo "All background moves finished."
