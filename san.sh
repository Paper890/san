#!/bin/bash

# Install dependencies
apt install -y wget screen
apt update -y && apt upgrade -y
apt install lolcat -y
gem install lolcat

# Download and run setup.sh
wget -q https://raw.githubusercontent.com/Paper890/san/main/getting.sh
chmod +x getting.sh
screen -S install ./getting.sh
