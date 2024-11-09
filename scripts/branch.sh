#!/bin/bash
git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short)' | fzf | xargs git checkout
# Check if an argument is provided
# if [ -z "$1" ]; then
#     exit 0
# fi

# Perform the fuzzy search and checkout the selected branch
# selected_branch=$(git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short)' | fzf --query="$1")

# if [ -n "$selected_branch" ]; then
#     git checkout "$selected_branch"
# else
#     echo "No matching branch found for '$1'"
# fi