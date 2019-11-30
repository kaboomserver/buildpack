#!/bin/sh

# The alive checker and Minecraft server is started at the same time. For performance reasons, the
# OpenJ9 JVM is used instead of Java's default Hotspot JVM.

chmod -R 500 $HOME/plugins/bStats/ $HOME/plugins/PluginMetrics/
dtach -n alivecheck $HOME/script/alivecheck.sh

while true; do
	java -Xmx384M -Xtune:virtualized -Xaggressive -Xcompressedrefs -Xdump:none -Xgc:concurrentScavenge -Xgc:dnssExpectedTimeRatioMaximum=3 -Xgc:scvNoAdaptiveTenure -Xdisableexplicitgc -Xshareclasses -Xshareclasses:noPersistentDiskSpaceCheck -XX:-HeapDumpOnOutOfMemoryError -XX:OnOutofMemoryError="pkill -9 java" -XX:MaxDirectMemorySize=64M -XX:+UseContainerSupport -XX:+ClassRelationshipVerifier -Dpaper.playerconnection.keepalive=360 -DIReallyKnowWhatIAmDoingISwear -jar server.jar
	sleep 1
done
