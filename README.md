# Dav's Personal Blog (blog.davcore.net)

A lightweight, blazing-fast personal blog built with plain text Markdown and hosted entirely on Raspberry Pi.

## The Tech Stack

* **Hardware:** Raspberry Pi (Self-hosted)
* **Site Generator:** [Hugo](https://gohugo.io/) (v0.146.0+)
* **Theme:** [PaperMod](https://github.com/adityatelange/hugo-PaperMod)
* **Web Server:** Nginx (Serving local HTML/CSS on port 80)
* **Networking:** Cloudflare Zero Trust Tunnel (Securely routes `blog.davcore.net` to the Pi without opening home router ports)

---

## Directory Structure

* `~/personalblog/` - The main Hugo working directory containing all source files and Markdown posts.
* `/var/www/personal-blog/` - The live Nginx directory where the compiled HTML site is served.

---

## Custom Bash Scripts

To make writing as frictionless as possible, this project uses two custom Bash scripts located in the home directory.

### 1. Creating a New Post
To write a new article, run:
```bash
./newpost.sh
```
**What it does:**
1. Prompts for a human-readable title.
2. Formats the title into a web-safe lowercase URL (e.g., `my-new-post.md`).
3. Generates the file using a custom TOML archetype - `archetypes/default.md` (setting default tags, Table of Contents, reading time, etc.).
4. Instantly opens the file in `nano` for writing.

### 2. Deploying to the Live Site
Once a post is written (and `draft = false` is set in the front matter), run:
```bash
./deploy.sh
```
**What it does:**
1. Compiles the Markdown files into static HTML using Hugo.
2. Uses `rsync` to intelligently sync the new files to the Nginx directory (`/var/www/personal-blog`).
3. Automatically fixes Linux file permissions (`www-data`) so Nginx can serve them without 403 errors.

---

## Customizations

* **Social Icons:** Configured in `hugo.toml` to display YouTube, Bluesky, and Instagram on the homepage.
* **External Links:** A custom CSS rule (`assets/css/extended/custom.css`) was added to automatically color all external `http`/`https` links blue while keeping internal anchor links (like the Table of Contents) the default text color.
* **Pinned Posts:** Posts can be pinned to the top of the homepage by adding `weight = 1` to the TOML front matter and adding 📌 Emoji to the title.

---

## Backup & Restore

This repository contains the source code. It explicitly ignores the generated `public/` folder via `.gitignore`. 

**To restore the site on a new machine:**
1. Install dependencies (Hugo, Git, Nginx).
2. Clone this repository.
3. Run `git submodule update --init --recursive` to pull down the PaperMod theme.
4. Run the deploy script to build and serve the site.
