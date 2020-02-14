#!/bin/sh

groupadd --gid $user_GID sheepit
useradd --no-create-home \
	--home-dir /sheep-cache \
	--uid $user_UID \
	--gid $user_GID \
	--inactive 0 \
	sheepit
chown sheepit:sheepit /sheep/runrenderer.sh
chmod ug+x /sheep/runrenderer.sh
chown -R sheepit:sheepit /sheep-cache
su --command "/sheep/runrenderer.sh" \
	--preserve-environment \
	sheepit
