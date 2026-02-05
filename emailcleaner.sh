#!/bin/bash

input="emails.txt"
# Regex: Alphanumeric @ Alpha . com
grep -E "^[a-zA-Z0-9]+@[a-zA-Z]+\.com$" "$input" | sort | uniq > valid.txt
grep -v -E "^[a-zA-Z0-9]+@[a-zA-Z]+\.com$" "$input" > invalid.txt

echo "Valid emails saved to valid.txt"
echo "Invalid emails saved to invalid.txt"