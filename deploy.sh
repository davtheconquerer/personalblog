#!/bin/bash

# Define your folders
BLOG_DIR="$HOME/personalblog"
WEB_DIR="/var/www/personal-blog"
BRANCH="main" # Change this if your default branch is not 'main'

echo "Pulling latest changes from GitHub..."
cd "$BLOG_DIR" || { echo "❌ Directory not found! Exiting."; exit 1; }

# Pull the latest changes from the specified branch
git pull origin "$BRANCH"

# Check if git pull was successful before building
if [ $? -ne 0 ]; then
    echo "❌ Git pull failed! Please check your repository."
    exit 1
fi

echo "🔨 Building Hugo site..."
cd "$BLOG_DIR" || { echo "❌ Directory not found! Exiting."; exit 1; }
hugo

echo "🚀 Syncing files to Nginx..."
# rsync copies the files and --delete removes any files that no longer exist
sudo rsync -av --delete public/ "$WEB_DIR/"

echo "🔒 Fixing file permissions..."
sudo chown -R www-data:www-data "$WEB_DIR"

echo "✅ Done! Your local blog is up to date."
