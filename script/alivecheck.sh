#!/bin/sh

# The following script is a failsafe for killing the Minecraft server if it happens
# to be stuck

set -x

while true; do
	sleep 420

	# If server doesn't respond to ping, or if the log file is older than
	# 3 minutes, kill the server

	if [ "$(env printf '\xFE' | nc -w 15 152.67.69.20 25565 | wc -m)" -eq 0 ]; then
		pkill -9 java
		kill -9 $(ps -C ssh -o pid=)
		echo $(date) >> ~/kill.log
	fi
done
