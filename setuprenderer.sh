#!/bin/sh

groupadd --gid $user_GID sheepit
useradd --no-create-home \
	--home-dir /sheep-cache \
	--uid $user_UID \
	--gid $user_GID \
	--inactive 0 \
	sheepit
# Adding a sheepit group and user

chown sheepit:sheepit /sheep/runrenderer.sh
chmod ug+x /sheep/runrenderer.sh
chown -R sheepit:sheepit /sheep-cache
# Setting file and dir permissions and ownerships

su --command "/sheep/runrenderer.sh" \
	--preserve-environment \
	sheepit
# Running sheepit as the configured user
