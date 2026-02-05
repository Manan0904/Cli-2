#!/bin/bash

file="input.txt"

# Pre-process: replace spaces with newlines to handle words
# Remove punctuation for better accuracy using tr -d '[:punct:]'
words=$(cat "$file" | tr -d '[:punct:]' | tr ' ' '\n' | grep -v "^$")

longest=""
shortest=""
total_len=0
count=0

for w in $words; do
    len=${#w}
    if [ -z "$longest" ] || [ $len -gt ${#longest} ]; then longest=$w; fi
    if [ -z "$shortest" ] || [ $len -lt ${#shortest} ]; then shortest=$w; fi
    
    total_len=$((total_len + len))
    count=$((count + 1))
done

avg=$((total_len / count))
unique=$(echo "$words" | sort | uniq | wc -l)

echo "Longest word: $longest"
echo "Shortest word: $shortest"
echo "Average length: $avg"
echo "Unique words: $unique"