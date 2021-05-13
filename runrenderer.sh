#!/bin/bash

echo "Checking for beta client..."
cd /sheep-cache

latestVersion=sheepit-client-6.21131.0

if [ ! -e $latestVersion.jar ]; then
	curl https://www.sheepit-renderfarm.com/media/applet/$latestVersion.jar -o $latestVersion.jar
	if [ $? -ne 0 ]; then
    		#Unclean exit is a good indicator of a critical failure
    		echo "!!! Failed client download! Aborting !!!"
    		echo "Possible causes and troubleshooting steps:"
    		echo "1. Check for internet connectivity \(Routes, DNS, Proxy\)"
    		echo "2. Check the status of SheepIt on the Blender Discord"
    		echo "3. Open an issue on Github if problems persists after 1. and 2."
    		exit 1
	fi
fi

echo "Starting beta client:"

java -jar /sheep-cache/$latestVersion.jar \
	-ui text \
	-login "$user_name" \
	-password "$user_password" \
	-cores $(nproc) \
	-cache-dir /sheep-cache \
	$extra_opt
