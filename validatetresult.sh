#!/bin/bash

input="marks.txt"

if [ ! -f "$input" ]; then
    echo "marks.txt not found!"
    exit 1
fi

passed_all_count=0
failed_one_count=0

echo "Students who failed in exactly ONE subject:"
while IFS=, read -r roll name m1 m2 m3; do
    fail_count=0
    
    # Check each subject
    if [ "$m1" -lt 33 ]; then ((fail_count++)); fi
    if [ "$m2" -lt 33 ]; then ((fail_count++)); fi
    if [ "$m3" -lt 33 ]; then ((fail_count++)); fi

    if [ $fail_count -eq 1 ]; then
        echo "$name ($roll)"
        ((failed_one_count++))
    elif [ $fail_count -eq 0 ]; then
        ((passed_all_count++))
    fi
done < "$input"

echo "--------------------------------"
echo "Students passed in ALL subjects:"
# Reset reading for second pass or store inside loop (logic above counts them)
# To print names, we can modify loop or just print counts as requested by logic:
# Prompt asks to Print Students passed. Let's list them:
while IFS=, read -r roll name m1 m2 m3; do
    if [ "$m1" -ge 33 ] && [ "$m2" -ge 33 ] && [ "$m3" -ge 33 ]; then
        echo "$name"
    fi
done < "$input"

echo "--------------------------------"
echo "Count - Passed All: $passed_all_count"
echo "Count - Failed One: $failed_one_count"