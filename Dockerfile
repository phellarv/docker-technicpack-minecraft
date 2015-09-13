# -----------------------------------------------------------------------------
# docker-minecraft
#
# Builds a basic docker image that can run a Minecraft server
# (http://minecraft.net/).
#
# Authors: Carsten Ringe
# Updated: Sep 13th, 2015
# Require: Docker (http://www.docker.io/)
# -----------------------------------------------------------------------------


# Base system is the LTS version of Ubuntu.
FROM	ubuntu

# 25565 is for minecraft
EXPOSE	25565

# /data contains static files
#VOLUME ["/data"]

# Make sure we don't get notifications we can't answer during building.
ENV    DEBIAN_FRONTEND noninteractive

# Download and install everything from the repos.
RUN    apt-get --yes update; apt-get --yes upgrade ; apt-get --yes clean
RUN    apt-get --yes install curl unzip openjdk-7-jre-headless && apt-get --yes clean

# Load in all of our config files.
ADD	ops.json /data/
ADD	whitelist.json /data/

# download technicpack
RUN	curl -s "http://servers.technicpack.net/Technic/servers/bteam/BTeam_Server_v1.0.12a.zip" -o /data/technicpack.zip && cd /data && unzip /data/technicpack.zip && rm /data/technicpack.zip
RUN	ls -la /data

# disable mods
RUN	mkdir -p /data/mods/disabled
#RUN	mv /data/mods/morph*.zip /data/mods/disabled/

# Fix all permissions
RUN    chmod +x /data/launch.sh

# /start runs it.
CMD    ["/data/launch.sh"]

