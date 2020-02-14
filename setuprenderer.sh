#!/bin/sh

groupadd --gid $user_GID sheepit
useradd --no-create-home \
	--home-dir /sheep-cache \
	--uid $user_UID \
	--gid $user_GID \
	--inactive 0 \
	sheepit
chown -c sheepit:sheepit ./runrenderer.sh
chmod -c ug+x ./runrenderer.sh
chown -Rc sheepit:sheepit /sheep-cache
su --command "/sheep/runrenderer.sh" \
	--preserve-environment \
	sheepit
