#!/bin/sh

# The alive checker and Minecraft server is started at the same time

# Dump classes
java -Xshare:dump

while true; do
	# Make certain files and folders read-only

	chmod -R 500 plugins/bStats/
	chmod -R 500 plugins/PluginMetrics/
	chmod -R 500 plugins/ProtocolLib/
	chmod 400 bukkit.yml
	chmod 400 commands.yml
	chmod 400 eula.txt
	chmod 400 paper.yml
	chmod 400 permissions.yml
	chmod 400 server-icon.png
	chmod 400 server.properties
	chmod 400 spigot.yml
	chmod 400 wepif.yml

	# Start alive checker

	dtach -n alivecheck ~/script/alivecheck.sh

	# Start Minecraft server

	java \
        -Xmx384M \
        -Xtune:virtualized \
        -Xaggressive \
        -Xcompressedrefs \
        -Xdump:heap+java+snap:none \
        -Xdump:tool:events=throw+systhrow,filter=java/lang/OutOfMemoryError,exec="kill -9 %pid" \
        -Xgc:concurrentScavenge \
        -Xgc:dnssExpectedTimeRatioMaximum=3 \
        -Xgc:scvNoAdaptiveTenure \
        -Xdisableexplicitgc \
        -Xshareclasses \
        -Xshareclasses:noPersistentDiskSpaceCheck \
        -XX:MaxDirectMemorySize=64M \
        -XX:+ClassRelationshipVerifier \
        -XX:+UseContainerSupport \
		-DPaper.IgnoreJavaVersion=true \
		-Dpaper.playerconnection.keepalive=360 \
		-DIReallyKnowWhatIAmDoingISwear \
		-jar server.jar nogui

	# Stop alive checker (will be started again on the next run)

	pkill -9 alivecheck.sh

	# Ensure we don't abuse the CPU in case of failure
	sleep 1
done
