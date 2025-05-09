#!/bin/bash
echo "###########################################################################"
echo "# CSGO Server - " `date`
echo "# UID $UID - GID $GID"
echo "###########################################################################"
[ -p /tmp/FIFO ] && rm /tmp/FIFO
mkfifo /tmp/FIFO

export TERM=linux

chown -R csgo:csgo /csgo /home/csgo
cd /csgo

if [ ! -f csgoserver ]; then 
   # First launch
   wget -O linuxgsm.sh https://linuxgsm.sh && chmod +x linuxgsm.sh && bash linuxgsm.sh csgoserver
   ./csgoserver auto-install
else
   ./csgoserver update-lgsm
   ./csgoserver update
fi

./csgoserver start

# Stop server in case of signal INT or TERM
echo "Waiting..."
trap stop INT
trap stop TERM

read < /tmp/FIFO &
wait