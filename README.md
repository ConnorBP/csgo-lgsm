# Counter Strike: Global Offensive, LGSM - Docker
First start will take a while since it downloads LSGM and then the game files.  
Will check for updated versions of LSGM and game files at at every start.
Check [here](https://linuxgsm.com/lgsm/csgoserver/) for further information.

### Some notes on networking
UDP ports are all that are used for game and query ports.  
It needs to be consistent all the way from docker container, config file to firewall openings/port forwards.  

## Volume redirection
Redirect whole folder to get persitance on game files + config files.  
Docker folder: /csgo  : Contains all config files and game binaries

## Files of interest
```bash
# CSGO Server Config file 
/csgo/serverfiles/csgo/cfg/csgoserver.cfg

# LGSM server files
 /csgo/lgsm/config-lgsm/csgoserver
```

## Running live
See docker-compose.yml for Docker Compose sample:

Docker:
```bash

# Basic startup
docker run -p 27103:27103/udp -p 27132:27132/udp \
      -v /my/local/path/to/csgo/:/csgo \
      --name csgo taxx/csgo-lgsm \
```

## Development / testing
```bash
# build image
docker build -t taxx/csgo-lgsm .

# run
docker run -p 27103:27103/udp -p 27132:27132/udp --name csgo taxx/csgo-lgsm
```

## Links
Please use [Github](https://github.com/taxx/csgo-lgsm) issue system.  
Link to image on [Docker hub](https://github.com/taxx/csgo-lgsm).


