#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <path_to_repos.txt> <destination_folder>"
  exit 1
fi

REPOS_FILE="$1"
DEST_FOLDER="$2"

# Create the destination folder if it doesn't exist
mkdir -p "$DEST_FOLDER"

while read -r REPO_URL COMMIT_HASH; do
  # Extract the repository name from the URL
  REPO_NAME=$(basename -s .git "$REPO_URL")

  # Clone the repository into the specified destination folder
  git clone "$REPO_URL" "$DEST_FOLDER/$REPO_NAME"

  # Change into the cloned repository directory
  cd "$DEST_FOLDER/$REPO_NAME" || exit

  # Checkout to the specific commit
  git checkout "$COMMIT_HASH"

  # Check if requirements.txt exists and install dependencies
  if [ -f requirements.txt ]; then
    # make sure torch is not overwriten
    grep -v '^torch' requirements.txt | pip install -r /dev/stdin
  fi

  # Return to the destination folder
  cd "$DEST_FOLDER" || exit

done < "$REPOS_FILE"
