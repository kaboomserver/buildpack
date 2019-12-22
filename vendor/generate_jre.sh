#!/bin/sh

# This script is used as a reference to generate a stripped-down OpenJ9 JRE for the server

rm -rf java/
wget https://github.com/AdoptOpenJDK/openjdk13-binaries/releases/download/jdk-13.0.1%2B9_openj9-0.17.0/OpenJDK13U-jdk_x64_linux_openj9_13.0.1_9_openj9-0.17.0.tar.gz
tar -zxvf OpenJDK*
rm OpenJDK*
mv jdk* jdk/
jdk/bin/jlink --no-header-files --no-man-pages --compress=2 --strip-debug \
	--exclude-files=**java_*.properties,**jrunscript,**keytool,**legal/** \
	--add-modules \
		java.desktop,java.logging,java.management,java.naming,java.net.http,java.scripting,java.sql,jdk.crypto.ec,jdk.unsupported,jdk.zipfs,openj9.sharedclasses \
	--output java
rm -rf jdk/
