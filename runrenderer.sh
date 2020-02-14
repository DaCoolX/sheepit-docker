#!/bin/bash

echo "Checking for client updates..."
cd /sheep-cache

latestVersion=`curl --silent --head https://www.sheepit-renderfarm.com/media/applet/client-latest.php|grep -Po 'Content-Disposition:.*filename="?\Ksheepit-client-[\d\.]+'`

if [ ! -e $latestVersion.jar ]; then
	echo "Updating client..."
	rm -f sheepit-client*.jar
	#Download new client.
	curl https://www.sheepit-renderfarm.com/media/applet/client-latest.php -o $latestVersion.jar
fi

echo "Starting client:"

java -jar /sheep-cache/$latestVersion.jar \
	-ui text \
	-login $user_name \
	-password $user_password \
	-cores $(nproc) \
	-cache-dir /sheep-cache \
	$extra_opt
