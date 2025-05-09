FROM debian:buster-slim

LABEL maintainer=segfault1337

# Server PORT (you can't remap with docker, it doesn't work)
ENV SERVERPORT=27015
# Query PORT (you can't remap with docker, it doesn't work)
ENV QUERYPORT=27016

# UID of the user csgo
ENV UID=1001
# GID of the user csgo
ENV GID=1001

# Install dependencies 
RUN dpkg --add-architecture i386
RUN apt update && \ 
    apt install -y mailutils postfix curl wget file tar \
	bzip2 gzip unzip bsdmainutils python util-linux \
	ca-certificates binutils bc jq tmux netcat lib32gcc1 \
	lib32stdc++6 cron iproute2 procps libsdl2-2.0-0:i386 \
	distro-info pigz

# Run commands as the steam user
RUN adduser \ 
	--disabled-login \ 
	--shell /bin/bash \ 
	--gecos "" \ 
	csgo

# Copy & rights to folders
COPY run.sh /home/csgo/run.sh
COPY user.sh /home/csgo/user.sh

# Set executable flags
RUN chmod +x /home/csgo/*.sh

# Switch from windows to linux file line endings
RUN sed -i -e 's/\r$//' /home/csgo/*.sh

RUN touch /root/.bash_profile & \
    chmod 777 /home/csgo/run.sh & \
    mkdir /csgo

WORKDIR /csgo/

RUN chown -R csgo:csgo /csgo

# EXPOSE 22/tcp
EXPOSE ${SERVERPORT}/udp ${QUERYPORT}/udp

VOLUME  /csgo

RUN chown -R csgo:csgo /csgo

# Change the working directory to /csgo
WORKDIR /csgo

ENTRYPOINT ["/home/csgo/user.sh"]
