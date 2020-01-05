#!/bin/sh

# The alive checker and Minecraft server is started at the same time. For performance reasons, the
# OpenJ9 JVM is used instead of Java's default Hotspot JVM.

mkdir -p $HOME/plugins/Essentials/userdata/
chmod -R 500 $HOME/plugins/bStats/ $HOME/plugins/Essentials/userdata/ $HOME/plugins/PluginMetrics/

# Make certain files read-only

echo "[]" > banned-ips.json
echo "[]" > banned-players.json
echo "[]" > ops.json
echo "[]" > whitelist.json

chmod 400 banned-ips.json
chmod 400 banned-players.json
chmod 400 ops.json
chmod 400 whitelist.json

dtach -n alivecheck $HOME/script/alivecheck.sh

while true; do
	java -Xmx384M -Xtune:virtualized -Xaggressive -Xcompressedrefs -Xdump:none -Xgc:concurrentScavenge -Xgc:dnssExpectedTimeRatioMaximum=3 -Xgc:scvNoAdaptiveTenure -Xdisableexplicitgc -Xshareclasses -Xshareclasses:noPersistentDiskSpaceCheck -XX:-HeapDumpOnOutOfMemoryError -XX:OnOutofMemoryError="pkill -9 java" -XX:MaxDirectMemorySize=64M -XX:+UseContainerSupport -Dpaper.playerconnection.keepalive=360 -DIReallyKnowWhatIAmDoingISwear -jar server.jar
	sleep 1
done
