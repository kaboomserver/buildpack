#!/bin/sh

# This is the core script that Heroku uses when booting up a dyno

PATH="$HOME/dtach/bin/:$HOME/java/bin/:$PATH"

# Set up SSH for proxy server and schematics repository
# Load keys from environmental variables

echo "$PROXY_KEY" > .ssh/proxy
chmod 600 .ssh/proxy

echo "$SCHEMATIC_KEY" > .ssh/id_rsa
ssh-keyscan github.com >> .ssh/known_hosts

# Run scripts for starting the Minecraft server, reverse proxy and schematic
# checker in the background

while true; do
	dtach -n server ~/script/server.sh > /dev/null 2>&1
	dtach -n proxy ~/script/proxy.sh > /dev/null 2>&1
	# dtach -n schematics ~/script/schematics.sh > /dev/null 2>&1
	sleep 5
done &

# Keep this startup script alive to prevent Heroku from stopping the server

sleep infinity
