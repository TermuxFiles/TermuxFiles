#!/bin/bash

# A command-line tool to search and retrieve cheat sheets from cheat.sh

# Function to display usage information
usage() {
    echo "Usage: cheat.sh <search-term>"
    echo "Search for command usage examples from cheat.sh."
    echo
    echo "Options:"
    echo "  -h, --help     Show this help message and exit."
}

# Check for help flag
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    usage
    exit 0
fi

# Check if a search term is provided
if [ -z "$1" ]; then
    echo "Error: No search term provided."
    usage
    exit 1
fi

# URL encode the search term
SEARCH_TERM=$(echo "$1" | jq -sRr @uri)

# Fetch results from cheat.sh
RESULT=$(curl -s "https://cheat.sh/$SEARCH_TERM")

# Check if the curl command was successful
if [ $? -ne 0 ]; then
    echo "Error: Failed to connect to cheat.sh."
    exit 1
fi

# Check if the result is empty
if [ -z "$RESULT" ]; then
    echo "No results found for '$1'."
    exit 0
fi

# Display the results
echo "$RESULT" | sed 's/^# //; s/^==*//; s/^.*//; /^$/d'
