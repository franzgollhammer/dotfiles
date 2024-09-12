#!/bin/bash

# get argument from command line
arg="$1"

# check if argument is empty
if [ -z "$arg" ]; then
  echo "Error: Please enter a valid color code as argument."
  exit 1
fi

# Create file .vscode/settings.json if it doesn't exist
if [ ! -f "$HOME/.vscode/settings.json" ]; then
  touch "$HOME/.vscode/settings.json"
fi

# Add the command center background color to the settings.json file
echo "{\"commandCenter.background\": \"$arg\"}" >> "$HOME/.vscode/settings.json"
