#!/bin/sh

# The alive checker and Minecraft server is started at the same time. For performance reasons, the
# OpenJ9 JVM is used instead of Java's default Hotspot JVM.

chmod -R 500 $HOME/plugins/bStats/ $HOME/plugins/PluginMetrics/ $HOME/plugins/ProtocolLib/

dtach -n alivecheck $HOME/script/alivecheck.sh

# Make certain files read-only

chmod 400 bukkit.yml
chmod 400 commands.yml
chmod 400 eula.txt
chmod 400 permissions.yml
chmod 400 server-icon.png
chmod 400 wepif.yml

while true; do
	java -Xmx384M -Xtune:virtualized -Xaggressive -Xcompressedrefs -Xdump:heap+java+snap:none -Xdump:tool:events=throw+systhrow,filter=java/lang/OutOfMemoryError,exec="kill -9 %pid" -Xgc:concurrentScavenge -Xgc:dnssExpectedTimeRatioMaximum=3 -Xgc:scvNoAdaptiveTenure -Xdisableexplicitgc -Xshareclasses -Xshareclasses:noPersistentDiskSpaceCheck -XX:MaxDirectMemorySize=64M -XX:+ClassRelationshipVerifier -XX:+UseContainerSupport -DPaper.IgnoreJavaVersion=true -Dpaper.playerconnection.keepalive=360 -DIReallyKnowWhatIAmDoingISwear -jar server.jar
	sleep 1
done
