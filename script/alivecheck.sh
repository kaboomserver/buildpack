#!/bin/sh

# The following script is a failsafe for killing the Minecraft server if it happens
# to be stuck

set -x

while true; do
	sleep 420
	logfile=$HOME/logs/latest.log

	if [ -f "$logfile" ]; then

		# If localhost:25565 doesn't respond to ping, or if the log file is older than
		# 3 minutes, kill the server

		if [ "$(env printf '\xFE' | nc -w 5 localhost 25565 | wc -m)" -eq 0 ] ||
			[ "$(( $(date +%s) - $(date -r $logfile +%s) ))" -gt 180 ]; then
			if [ "$(tail -20 $logfile | grep -c 'ERROR]: Requested chunk')" -eq 1 ]; then
				rm -rf $HOME/worlds/
			fi
			pkill -9 java
		fi
	fi
done
