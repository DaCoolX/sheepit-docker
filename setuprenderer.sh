#!/bin/sh

groupadd --gid $user_GID sheepit
useradd --no-create-home \
	--home-dir /sheep-cache \
	--uid $user_UID \
	--gid $user_GID \
	--inactive 0 \
	--shell /usr/sbin/nologin \
	sheepit
chown sheepit ./runrenderer.sh
chmod ug+x ./runrenderer.sh
chown -R sheepit:sheepit /sheep-cache
su --command "/sheep/runrenderer.sh" \
	--preserve-environment
	sheepit
