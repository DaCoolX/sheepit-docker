FROM debian:buster-slim

# Maintainer
LABEL maintainer=DaCoolX

ARG DEBIAN_FRONTEND=noninteractive
# Makes the apt-get process aware
# of the docker build process env
# so it doesn't complain as much

RUN \
# MAN folder needed for jre install
     mkdir -p /usr/share/man/man1 \
# Install JRE and curl
  && apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y --no-install-recommends \
	openjdk-11-jre-headless \
	curl \
	libglu1-mesa

	#Blender dependencies of other sheepit containers explained:
	#needed in the past:
	#libsdl1.2debian
	#libgl1-mesa-glx

	#libglu1-mesa deps:
	#libxxf86vm1
	#libxfixes3

	#openjdk-11-jre-headless deps:
	#libfreetype6
	#libxi6
	#libxrender1

ADD runrenderer.sh /sheep/runrenderer.sh
ADD setuprenderer.sh /sheep/setuprenderer.sh
RUN chmod u+x /sheep/setuprenderer.sh

VOLUME /sheep-cache
WORKDIR /sheep-cache

ENV user_name ""
ENV user_password ""
ENV extra_opt ""
ENV user_UID "1000"
ENV user_GID "1000"

ENTRYPOINT /sheep/setuprenderer.sh
