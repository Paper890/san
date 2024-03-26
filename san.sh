#!/bin/bash
# Download and run setup.sh
wget -q https://raw.githubusercontent.com/Paper890/san/main/setup1.sh
chmod +x setup1.sh
screen -S install ./setup1.sh
