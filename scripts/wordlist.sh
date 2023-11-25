#!/bin/bash

# Variables.
args_count=$(echo $#)
minlen=$2
maxlen=$3
charecters=$4
output_file=$5

# Function to check if the number of arguments is valid and display usage information if not.
function CHECK_ARGS_COUNT(){
    if ! [ "$args_count" == 5 ]; then
        echo -e "[-] Bad arguments.\n"
        echo -e "\tUsage: wordlist <min-len> <max-len> <caracters> <output-name>"
        exit 1
    fi
}

# Function to check if a given value is a number.
function CHECK_IF_NUMBER(){
    if ! [[ $2 =~ ^[0-9]+$ ]];then
        echo -e "\n[-] The value '$1' must be a number."
        exit 1
    fi
}

# Function to create a wordlist using the 'crunch' tool.
function CREATE_WORDLIST(){
    if crunch "$minlen" "$maxlen" "$charecters" -o "$output_file" 2>/dev/null 1>&2; then
        echo -e "\n[+] A wordlist called '$output_file' was created [ with $(cat $output_file | wc -l) entries ]"
    else
        echo -e "\n[-] An error has occurred"
    fi
}

CHECK_ARGS_COUNT
CHECK_IF_NUMBER "min-len" "$minlen"
CHECK_IF_NUMBER "max-len" "$maxlen"
CREATE_WORDLIST

