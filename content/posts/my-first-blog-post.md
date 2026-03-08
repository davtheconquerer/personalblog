+++
title = '📌 My First Blog Post'
date = 2026-03-08T12:20:30Z
draft = false
weight = 1
tags = ["📌 Pinned", "FAQ", "Linux"]
categories = []
searchHidden = false
ShowBreadCrumbs = true
ShowShareButtons = true
ShowReadingTime = true
ShowCodeCopyButtons = true
ShowToc = false
TocOpen = true
+++

# FAQ

This post outlines 3 big questions you might have:

- [Why did I start this site?](#why-did-i-start-this-site)
- [How did I make this site?](#how-did-i-make-this-site)
- [Do I have a schedule for these posts?](#do-i-have-a-schedule-for-these-posts)

## Why did I start this site?

I've been wanting to start a personal blog for a while now.
I wanted a place to write down my thoughts and also be able to share them with the internet.
I've always had a goal of leaving my mark in the world and this is the easiest and simplest
way to start.

This site will also be used to share my thought process behind content creation.
I will hopefully start making posts for every YouTube video I post and show the behind the
scenes of making them. This won't be a how-to guide but more of just a knowledge dump of
everything I learn in the process. At the time of writing, I'm interested in making custom
LUTs using popular AI models and seeing if they will level up my vlog content.

## How did I make this site?

I'm hosting this site on my own server at home - specifically a [Raspberry Pi](https://www.raspberrypi.com/).
Writing the actual posts is super simple. I write everything in plain text using [Markdown](https://www.markdownguide.org/basic-syntax/)
(`.md` files). However, web browsers don't understand Markdown; they only read HTML and CSS.

That's where [Hugo](https://gohugo.io/) comes in. Everytime I write a new post, Hugo takes my `.md` files and
turns it into a fully built, ready-to-read website. It skips the heavy, slow databases that
sites like [WordPress](https://wordpress.com/) use, making this blog incredibly fast (I
hope).

Once Hugo builds those files, I use a piece of software called [Nginx](https://nginx.org/)
(pronounced *engine-ex*) to actually serve them.

Finally, to get this site out to the Internet **securely**, I set up a [Cloudflare Tunnel](https://developers.cloudflare.com/cloudflare-one/networks/connectors/cloudflare-tunnel/)
to connect my Raspberry Pi to my domain name, [davcore.net](https://www.davcore.net/). Instead
of opening up ports on my router (very bad security practice), the Cloudflare Tunnel acts as
a secure pipeline. It safely routes visitors from the Internet to my Nginx server, all without
exposing my home network.

## Do I have a schedule for these posts?

Due to ADHD procrastination and forgetfulness, there will be no schedule.
I'll aim to have at least 5 posts a year, I guess.
