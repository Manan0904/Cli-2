#!/bin/bash

input="input.txt"

# Ensure output files are empty
> vowels.txt
> consonants.txt
> mixed.txt

# Read word by word
for word in $(cat "$input"); do
    # Case insensitive checking
    lower_word=$(echo "$word" | tr '[:upper:]' '[:lower:]')
    
    # Check if only vowels (regex: start to end are aeiou)
    if [[ "$lower_word" =~ ^[aeiou]+$ ]]; then
        echo "$word" >> vowels.txt
    
    # Check if only consonants (regex: start to end are NOT aeiou)
    elif [[ "$lower_word" =~ ^[^aeiou]+$ ]]; then
        echo "$word" >> consonants.txt
        
    # Check mixed: Starts with consonant AND contains a vowel
    # Logic: First char is not vowel AND word contains a vowel
    elif [[ ! "${lower_word:0:1}" =~ [aeiou] ]] && [[ "$lower_word" =~ [aeiou] ]]; then
        echo "$word" >> mixed.txt
    fi
done

echo "Processing complete. Check output files."