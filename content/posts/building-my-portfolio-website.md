+++
title = 'Building My Portfolio Website'
date = 2026-03-10T19:28:19Z
draft = false
tags = ["Software Development","Web Development","Linux","Raspberry Pi","Cloudflare","Bash","Nginx"]
categories = ["Projects"]
searchHidden = false
ShowBreadCrumbs = true
ShowShareButtons = true
ShowReadingTime = true
ShowCodeCopyButtons = true
ShowToc = false
TocOpen = true
+++

I recently decided it was time to build a dedicated software development portfolio. I wanted something completely distinct from my personal blog. Designed strictly for future employers to see my work.

The goal was simple: no bloated frameworks, no unnecessary dependencies, and a fast, minimalist aesthetic. Just pure HTML, CSS, and vanilla JavaScript. 

But building the site was only half the project. The real fun was the infrastructure. Here is how I set up the site and routed it through my existing Raspberry Pi home lab.

### The Challenge: Two Sites, One Pi
My personal blog is statically generated using Hugo and served via Nginx on my Raspberry Pi. Traffic is securely routed to the Pi using a Cloudflare Tunnel. I wanted to host my new portfolio on the exact same Pi, using a different subdomain (`portfolio.davcore.net`).

Nginx handles this easily using Server Blocks (Virtual Hosts). You just point both Cloudflare routes to `port 80` on the Pi, and Nginx reads the `server_name` in the HTTP request to serve the correct directory.

### The IPv6 Routing Quirk
When I first spun up the Cloudflare Tunnel for the portfolio and pointed it to `localhost:80`, something weird happened: my portfolio suddenly overwrote my blog domain. If you went to `blog.davcore.net`, you saw the portfolio. 

It turned out to be an incredibly subtle IPv4 vs. IPv6 routing issue. 

My new Nginx block for the portfolio included a listener for IPv6:
```nginx
listen 80;
listen [::]:80; # The IPv6 listener
server_name portfolio.davcore.net;
```

My older blog configuration only had `listen 80;`. When the Cloudflare Tunnel sent traffic to `localhost:80`, it defaulted to the IPv6 loopback address (`::1`). Because my portfolio was the only site actively listening on IPv6, Nginx ignored the domain names completely and dumped all traffic into the portfolio directory.

**The Fix:** Adding `listen [::]:80`; to the blog’s Nginx configuration instantly restored balance. Both sites now listen uniformly, and Nginx perfectly splits the traffic based on the domain requested.

### Automating Deployments

If you know me, you already know I’m a big fan of automation, so manually copying files over to the Nginx `/var/www/` directory every time I update my portfolio was out of the question.

I wrote a quick Bash script to handle the deployment. It pulls the latest commits from my GitHub repository and uses `rsync` to cleanly sync the files to the live web directory, completely ignoring the `.git` folder for security.

```bash
#!/bin/bash

REPO_DIR="$HOME/portfolio"
WEB_DIR="/var/www/portfolio"
BRANCH="main"

echo "🔨 Fetching latest Git repo..."
cd "$REPO_DIR" || { echo "❌ Directory not found! Exiting."; exit 1; }

git pull origin "$BRANCH"
if [ $? -ne 0 ]; then
    echo "❌ Git pull failed! Please check your repository."
    exit 1
fi

echo "🚀 Syncing files to Nginx..."
sudo rsync -av --exclude '.git/' --delete "$REPO_DIR/" "$WEB_DIR/"

echo "🔒 Fixing file permissions..."
sudo chown -R www-data:www-data "$WEB_DIR"

echo "✅ Done! Your portfolio site is up to date."
```

Now, pushing a new project to my portfolio is as simple as running a `git push` on my laptop, and executing `./deploy.sh` on the Pi.

The site is live and you can check it out here [portfolio.davcore.net](https://portfolio.davcore.net).
