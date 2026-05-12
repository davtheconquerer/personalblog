+++
title = 'Jellyfin Setup on Raspberry Pi'
date = 2026-05-12T13:55:17+01:00
draft = false
tags = ["Self-Hosting", "Raspberry Pi", "Jellyfin", "Cloudflare"]
categories = ["Projects"]
searchHidden = false
ShowBreadCrumbs = true
ShowShareButtons = true
ShowReadingTime = true
ShowCodeCopyButtons = true
ShowToc = false
TocOpen = true
+++

# Why I wanted to do this project?

So I've been wanting to make my own media server so I can quit streaming services like Prime and Disney+. The prices keep going up and I find myself only watching about 3 new films per month. As I am a 'rewatcher' making a media server was the way to go. There are multiple options for this but I chose [Jellyfin](https://jellyfin.org/) mainly because my friend is using it. I would have a look at the features you need and compare [Plex](https://watch.plex.tv/) and Jellyfin.

I have a [QNAP TS-211](https://www.qnap.com/en-uk/product/ts-221/specs/hardware) Network Attached Storage (NAS) that I wanted to put it on but then found out the firmware is too old and can't support it. But then I realised I could run Jellyfin on my [Raspberry Pi](https://www.raspberrypi.com/) and then use the QNAP NAS as storage for the films.

# Phase 1: Prepping the NAS

First, I had to make the QNAP talk to the Pi. I setup a dedicated shared folder on the NAS called 'jellyfin', I know I'm original like that, and enabled SMB. I gave the Pi it's own qnap login and then mounted it to the folder by adding this line to my `/etc/fstab`:

```bash
# Mounting the QNAP
//[QNAP_IP]/Multimedia/jellyfin /mnt/nas cifs username=pi,password=[pass],iocharset=utf8,dir_mode=0777,file_mode=0777,rw,uid=1000,gid=1003,_netdev,x-systemd.automount 0 0
```

The `x-systemd.automount` flag was the secret sauce here - it ensures the Pi doesn't hang during boot if the network isn't ready yet.

# Phase 2: Installing Jellyfin

With the storage mounted, installing Jellyfin on the Pi was easy using the official install script:

```bash
curl -fsSL https://repo.jellyfin.org/install-debuntu.sh | sudo bash
```

Once the service was active, I pointed the Jellyfin library to `/mnt/nas`. I already had some films in a folder and Jellyfin started generating the movie posters for them.

# Phase 3: Remote Access via Cloudflare

I didn't want to mess with port forwarding or exposing my home IP address to the world. Since I already use Cloudflare Tunnels for my blog and portfolio, I simply added a new public hostname.

Now, I can access my library securely at [movies.davcore.net](https://movies.davcore.net) from anywhere in the world. The tunnel handles the SSL encryption automatically, so everything is served over HTTPS.

# What's next?

Next on the list is setting up [Vaultwarden](https://github.com/dani-garcia/vaultwarden) for password management and potentially [Immich](https://immich.app/) for a [Google Photos](https://photos.google.com/) replacement. Although I'll leave these for a while I think.
