#!/bin/bash

if [ ! "$(id -u csgo)" -eq "$UID" ]; then 
	echo "Changing csgo uid to $UID."
	usermod -o -u "$UID" csgo ; 
fi
# Change gid if needed
if [ ! "$(id -g csgo)" -eq "$GID" ]; then 
	echo "Changing csgo gid to $GID."
	groupmod -o -g "$GID" csgo ; 
fi

# Put csgo owner of directories (if the uid changed, then it's needed)
chown -R csgo:csgo /csgo /home/csgo

# avoid error message when su -p (we need to read the /root/.bash_rc )
chmod -R 777 /root/

# Launch run.sh with user csgo (-p allow to keep env variables)
su -p csgo -c /home/csgo/run.sh