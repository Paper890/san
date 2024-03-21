#!/bin/bash

# Install dependencies
apt install -y wget screen
apt update -y && apt upgrade -y
apt install lolcat -y
gem install lolcat

# Download and run setup.sh
wget -q https://raw.githubusercontent.com/Paper890/san/main/get1.sh
chmod +x get1.sh
screen -S install ./get1.sh
