#!/bin/bash

dirA="dirA"
dirB="dirB"

echo "Files only in $dirA:"
comm -23 <(ls $dirA | sort) <(ls $dirB | sort)

echo "Files only in $dirB:"
comm -13 <(ls $dirA | sort) <(ls $dirB | sort)

echo "Comparison of common files:"
# Loop through files present in both
for file in $(comm -12 <(ls $dirA | sort) <(ls $dirB | sort)); do
    if cmp -s "$dirA/$file" "$dirB/$file"; then
        echo "$file: Contents Match"
    else
        echo "$file: Contents Differ"
    fi
done