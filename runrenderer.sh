#!/bin/bash

echo "Checking for client updates..."
cd /sheep-cache

latestVersion=`curl --silent --head https://www.sheepit-renderfarm.com/media/applet/client-latest.php | \
    grep -Po '(?i)content-disposition:.*filename="?(?-i)\Ksheepit-client-[\d\.]+\d'`
    
if [ -z $latestVersion ]; then
    #Empty latestVersion hints at a critical error
    echo Failed parsing version information! Aborting.
    exit 1
elif [ ! -e $latestVersion.jar ]; then
	echo "Updating client..."
	rm -f sheepit-client*.jar
	#Download new client.
	curl https://www.sheepit-renderfarm.com/media/applet/client-latest.php -o $latestVersion.jar
	echo "Update finished"
else
	echo "No updates found"
fi

echo "Starting client:"

java -jar /sheep-cache/$latestVersion.jar \
	-ui text \
	-login $user_name \
	-password $user_password \
	-cores $(nproc) \
	-cache-dir /sheep-cache \
	$extra_opt
