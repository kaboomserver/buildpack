#!/bin/sh

# Since we can't open TCP ports on Heroku, we need to forward traffic to a proxy server that
# permits incoming connections
# Resources for setting up the proxy server: https://github.com/kaboomserver/proxy

set -x

while true; do
	ssh -i ~/.ssh/proxy \
		-o StrictHostKeyChecking=no -o ExitOnForwardFailure=yes -o StreamLocalBindUnlink=yes \
		-c aes128-ctr \
		-C -S none -N -T -R \
		25565:localhost:25565 \
		remote@play.kaboom.pw
	sleep 1
done
