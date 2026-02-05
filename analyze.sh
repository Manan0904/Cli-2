#!/bin/bash

# Check if exactly one argument is provided
if [ "$#" -ne 1 ]; then
    echo "Error: Please provide exactly one argument."
    echo "Usage: $0 <file_or_directory_path>"
    exit 1
fi

PATH_ARG=$1

# Check if the path exists
if [ ! -e "$PATH_ARG" ]; then
    echo "Error: The path '$PATH_ARG' does not exist."
    exit 1
fi

# Logic for files
if [ -f "$PATH_ARG" ]; then
    echo "Processing file: $PATH_ARG"
    # Using wc to get lines, words, and characters
    wc "$PATH_ARG" | awk '{printf "Lines: %s\nWords: %s\nCharacters: %s\n", $1, $2, $3}'

# Logic for directories
elif [ -d "$PATH_ARG" ]; then
    echo "Processing directory: $PATH_ARG"
    
    # Total number of files (excluding directories)
    TOTAL_FILES=$(find "$PATH_ARG" -maxdepth 1 -type f | wc -l)
    
    # Number of .txt files
    TXT_FILES=$(find "$PATH_ARG" -maxdepth 1 -type f -name "*.txt" | wc -l)
    
    echo "Total number of files: $TOTAL_FILES"
    echo "Number of .txt files: $TXT_FILES"

else
    echo "Error: '$PATH_ARG' is neither a regular file nor a directory."
    exit 1
fi