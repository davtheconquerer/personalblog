#!/bin/bash

# Define where your blog lives
BLOG_DIR="$HOME/personalblog"

# Ask you for the name of the post
echo "📝 What is the title of your new post?"
read -p "> " TITLE

# Stop if you didn't type anything
if [ -z "$TITLE" ]; then
  echo "❌ You must enter a title. Canceling."
  exit 1
fi

# Convert the title to a clean filename (lowercase, spaces to hyphens)
FILENAME=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | tr -s ' ' '-' | tr -cd '[:alnum:]-')

# Go to the blog directory
cd "$BLOG_DIR" || exit

# Tell Hugo to generate the file
echo "⚙️ Creating content/posts/${FILENAME}.md..."
hugo new posts/${FILENAME}.md

# Open the new file in nano so you can start writing immediately
nano content/posts/${FILENAME}.md
