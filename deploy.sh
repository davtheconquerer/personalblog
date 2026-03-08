#!/bin/bash

# Define your folders
BLOG_DIR="$HOME/personalblog"
WEB_DIR="/var/www/personal-blog"

echo "🔨 Building Hugo site..."
cd "$BLOG_DIR" || exit
hugo

echo "🚀 Syncing files to Nginx..."
# rsync copies the files and --delete removes any files that no longer exist
sudo rsync -av --delete public/ "$WEB_DIR/"

echo "🔒 Fixing file permissions..."
sudo chown -R www-data:www-data "$WEB_DIR"

echo "✅ Done! Your local blog is up to date."
